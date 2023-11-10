Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2BFB7E75DC
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 01:18:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345501AbjKJASx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 19:18:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234881AbjKJASv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 19:18:51 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 141AA1FEA
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 16:18:49 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9c603e235d1so244348966b.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 16:18:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699575527; x=1700180327; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wQ3q2rvys4Kv3C4TyRLLSN9g60w8HP9NiDPhmYCzW38=;
        b=i4sEkWtK+2nqJxrl6AU9bmwC7Cf2bQGuK0VLjC9YZUf2rR481lwe8CkdZCXRod6sMF
         w9TJWB17g7Ehhs7TkDEuGQhLPQOFQpgfS6dBKKZECNuc9zVXfUL7MgKVRCspxOq+CaMg
         SX9o6r3wDWmbxx0cUOrdxqYxums/tRHV/NnyY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699575527; x=1700180327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wQ3q2rvys4Kv3C4TyRLLSN9g60w8HP9NiDPhmYCzW38=;
        b=u3aX1KZpOQIFTUpj6Xt+EWV3Owlus0+jCHEvp1/jnzmq7v6mSjAseiQ1a9IQrbjtvo
         /X3kKZ9scH0t/41WWlYJaExnuOJ+rX1W2pn9GtGfBCA9d0KwL1kCuVsS/UnwQgPhnRZz
         nmTPFNS2rflY5orupDTlvNF3uuO1mDQZEjJsydM1z26eW4IKOVh36onFRv4apfU9IJid
         k0LJfqz9+bAjZse2yYafHF+/fpUZFuLn4TYnK0kI/u3EYXq3kgYm8o4qr1ZAPJPiqfgP
         2OlQ/b4O1QHZGQZtao7FHgnmf6LaoUiGGcJBa5eZFXDh2Bv0QIPixD6FBaTE7CWPedoe
         I8CA==
X-Gm-Message-State: AOJu0YwvKVG3MG/E4kDHQeoK11IcjY7fYJlBHQMbEB3o1U1EKBYK6cuA
        3NlG7A41BL7rrdeKVNmvk2N+3pXBE9tKKFUixbD3Ig==
X-Google-Smtp-Source: AGHT+IFYoWOOGqqWGrZldypw+oTJAwuC1p55+wQbLT5nl/aRq8clZPVAe7SsHfXGC3+5c+x6rGXENA==
X-Received: by 2002:a17:907:3ea4:b0:9c3:b3cb:29ae with SMTP id hs36-20020a1709073ea400b009c3b3cb29aemr5601969ejc.47.1699575527269;
        Thu, 09 Nov 2023 16:18:47 -0800 (PST)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com. [209.85.128.41])
        by smtp.gmail.com with ESMTPSA id u22-20020a17090617d600b009dd8473559dsm3160098eje.110.2023.11.09.16.18.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Nov 2023 16:18:46 -0800 (PST)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40a426872c6so66025e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 16:18:46 -0800 (PST)
X-Received: by 2002:a05:600c:34cd:b0:408:2b:5956 with SMTP id
 d13-20020a05600c34cd00b00408002b5956mr277978wmq.6.1699575526502; Thu, 09 Nov
 2023 16:18:46 -0800 (PST)
MIME-Version: 1.0
References: <20231107204611.3082200-1-hsinyi@chromium.org> <20231107204611.3082200-4-hsinyi@chromium.org>
In-Reply-To: <20231107204611.3082200-4-hsinyi@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 9 Nov 2023 16:18:34 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WZ-d3J1S8gyc=g1_Bd1OffmH0JxavGK6GBykhQO3pp=w@mail.gmail.com>
Message-ID: <CAD=FV=WZ-d3J1S8gyc=g1_Bd1OffmH0JxavGK6GBykhQO3pp=w@mail.gmail.com>
Subject: Re: [PATCH v6 3/5] drm/panel-edp: drm/panel-edp: Add several generic
 edp panels
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Nov 7, 2023 at 12:46=E2=80=AFPM Hsin-Yi Wang <hsinyi@chromium.org> =
wrote:
>
> Add a few generic edp panels used by mt8186 chromebooks.
>
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> ---
> no change.
> ---
>  drivers/gpu/drm/panel/panel-edp.c | 51 +++++++++++++++++++++++++++++++
>  1 file changed, 51 insertions(+)

Pushed to drm-misc-next:

4d53cf814795 drm/panel-edp: drm/panel-edp: Add several generic edp panels
