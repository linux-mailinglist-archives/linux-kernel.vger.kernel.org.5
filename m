Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F90D79F101
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 20:19:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231790AbjIMST5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 14:19:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbjIMSTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 14:19:55 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEADB19BF
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 11:19:51 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2bfb0a2682fso1500361fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 11:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694629189; x=1695233989; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lEAPfLQPyHWPs22S6K8OqWidoAHb8MCtHTLAq4j3yQg=;
        b=asvBHREaxchORsiuKrtz9i6jkaVRpjoG1pDWGlFTJRasaIpE6+mYR75iwSgsgAJJVc
         XzXPRnMdacxf407bEd7ElljpuCqy+rvj4rvhtB5yLcthcvsmQkToI1MOk2gzxzZLJfZw
         9RmwGrMnpK0KdX9Dt9ALX/V89aKNRk1iKiNY4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694629189; x=1695233989;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lEAPfLQPyHWPs22S6K8OqWidoAHb8MCtHTLAq4j3yQg=;
        b=uJMnk3R0BBYJv6NM3dfNrWeRN9B7rGZvh9ZYVKfYlh4n6D4tb9V8FXydAo3hDZgotZ
         I1cEyBNXw+EQs3lR89wvSAq0Ftd4ad1hwxuctq6o/OQDT/QEIkXVPAJ+DP6yGMlJEIIR
         3yspoAJ03GL/m4fkSgL0/OWwSoHacBR2XwxbI+WsRjxLPstdg+hYkWMGiU+JARSTlF0j
         EykVw4dVjJA4lglKyTOlPoafxN9pxveIatxNQezPA22VpsEQFrgQKRw//O+q2nAOeWO7
         Q0f6EK4aJtW91j0rLwoQtS4YYfHYPpDQbgZGn7rS6O3LIo/qJoSUhzsCemBVvfugNWVr
         HRig==
X-Gm-Message-State: AOJu0YxhFtQJeyAIAN9Y9cMPGaV2X12AWL1WYh7XS4+LDenk2TEKL0nU
        9E2V4X8fR9yz+DuxdbvlKh8MpJpysBDhDqsBflmDTunC
X-Google-Smtp-Source: AGHT+IG/wsZEHlY1cE1/gWOSJZFPmMsG6P/iHQovi2gXUdkWAZQGF8UhNDpY0OX/OWQRzVSaLdACkA==
X-Received: by 2002:a2e:9a98:0:b0:2bd:ce9:848f with SMTP id p24-20020a2e9a98000000b002bd0ce9848fmr3162657lji.17.1694629188841;
        Wed, 13 Sep 2023 11:19:48 -0700 (PDT)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com. [209.85.128.54])
        by smtp.gmail.com with ESMTPSA id i10-20020a170906114a00b00992076f4a01sm8740522eja.190.2023.09.13.11.19.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Sep 2023 11:19:48 -0700 (PDT)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-402c80b71ecso11255e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 11:19:48 -0700 (PDT)
X-Received: by 2002:a05:600c:1827:b0:3fe:f32f:c57f with SMTP id
 n39-20020a05600c182700b003fef32fc57fmr197792wmp.0.1694629187934; Wed, 13 Sep
 2023 11:19:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230906072803.1.Idef7e77e8961cbeb8625183eec9db0356b2eccd0@changeid>
In-Reply-To: <20230906072803.1.Idef7e77e8961cbeb8625183eec9db0356b2eccd0@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 13 Sep 2023 11:19:31 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X4OuYAkPbEL23DbNDRNhHT+0LNSfd01aY2nmkUhSvZ1A@mail.gmail.com>
Message-ID: <CAD=FV=X4OuYAkPbEL23DbNDRNhHT+0LNSfd01aY2nmkUhSvZ1A@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Update DRM DRIVERS FOR FREESCALE IMX entry
To:     dri-devel@lists.freedesktop.org,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Maxime Ripard <mripard@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Sep 6, 2023 at 7:28=E2=80=AFAM Douglas Anderson <dianders@chromium.=
org> wrote:
>
> As per the discussion on the lists [1], changes to this driver
> generally flow through drm-misc. If they need to be coordinated with
> v4l2 they sometimes go through Philipp Zabel's tree instead. List both
> trees in MAINTAINERS. Also update the title of this driver to specify
> that it's just for IMX 5/6 since, as per Philipp "There are a lot more
> i.MX that do not use IPUv3 than those that do."
>
> [1] https://lore.kernel.org/r/d56dfb568711b4b932edc9601010feda020c2c22.ca=
mel@pengutronix.de
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> I'd expect this MAINTAINERS update to go through drm-misc.
>
>  MAINTAINERS | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Pushed to drm-misc-next:

92e62478b62c MAINTAINERS: Update DRM DRIVERS FOR FREESCALE IMX entry
