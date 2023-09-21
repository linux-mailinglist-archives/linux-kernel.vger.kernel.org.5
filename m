Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D4E97A9AB7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 20:47:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbjIUSr7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 14:47:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbjIUSrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 14:47:52 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C09D8EE5BD
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 11:47:43 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-533352059fdso1460179a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 11:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695322060; x=1695926860; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZE8jn6HHsFTTLGSwFTvjr4C1qpDw4tvtE+zZqrkJga0=;
        b=L7EbKCeMwRt0CrwM2OlAejV+4C+N7UGG2opaprsWphw/CnEBDex2J6GsBeqB+wcWhu
         t9D5o1kjzNKaqMsWywsFf30Mtqk556OUE5w5AJmWx7LC+NzMH826NsvLN28yVpD2DjHa
         42k70lf6dC6EuAkuOch+1cWoHxVgjMpaPEkAA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695322060; x=1695926860;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZE8jn6HHsFTTLGSwFTvjr4C1qpDw4tvtE+zZqrkJga0=;
        b=pU9vmHfTQjaYc+PbdP2gCuHHIY6kxwyeJjShiAkoizFumtywhPzChhK5dMMGcQyy7e
         m7P7QKwjxStJ6j+KFhZzblhMlqYTwURT4yfE6bMxyt8iE40vTilhuf2nUk6VuhW9tUyy
         CHG3KLWgAmiV9UyEubvDbQ4dmQ7t2rSjkijUZtzo5DgJEc3BhEcfLqcC1c7drs9jmTUr
         msHKITuZfmNwCPMJG58cgrnsyy+VnAsLxkYCB60BKT2wqK1JrKql98k2DQ4vCH4oETMI
         j/Z9dPiXkATqKL0dG6o2d57fuNpZQlbUsW+bQLyElH4DwUUZTOuNsETpUcNe65wL5jPt
         s80A==
X-Gm-Message-State: AOJu0YyvyBAPniQKhKtPQrVM3hS8QSj5LahgcKv2g9cQswWoOZjfwxtj
        JBufiZNiPxIjc6lv+NSCb+CA7LxvYchKX1Ltz4TQZelH
X-Google-Smtp-Source: AGHT+IEwO6Vjd4GPAcmS077JAs2bxZiOyH8ED5J5XWa8ad59K63s25oGaQxBDoVDNQWLZKhQtIlkPw==
X-Received: by 2002:a17:906:196:b0:9ad:df85:97ae with SMTP id 22-20020a170906019600b009addf8597aemr5456660ejb.66.1695322060514;
        Thu, 21 Sep 2023 11:47:40 -0700 (PDT)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com. [209.85.128.48])
        by smtp.gmail.com with ESMTPSA id bu10-20020a170906a14a00b0099bd7b26639sm1451740ejb.6.2023.09.21.11.47.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Sep 2023 11:47:39 -0700 (PDT)
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-404f881aa48so18875e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 11:47:39 -0700 (PDT)
X-Received: by 2002:a05:600c:3caa:b0:3f7:3e85:36a with SMTP id
 bg42-20020a05600c3caa00b003f73e85036amr104085wmb.7.1695322058640; Thu, 21 Sep
 2023 11:47:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230901234015.566018-1-dianders@chromium.org> <20230901163944.RFT.4.I4752a39ad9f8fd08b32c2b78a8a3e40491bfb5eb@changeid>
In-Reply-To: <20230901163944.RFT.4.I4752a39ad9f8fd08b32c2b78a8a3e40491bfb5eb@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 21 Sep 2023 11:47:21 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XrhPxrYRP4A4vcKyq+euhfyWq3rzs2egXB51fdFNSLZQ@mail.gmail.com>
Message-ID: <CAD=FV=XrhPxrYRP4A4vcKyq+euhfyWq3rzs2egXB51fdFNSLZQ@mail.gmail.com>
Subject: Re: [RFT PATCH 4/6] drm/ssd130x: Call drm_atomic_helper_shutdown() at
 remove time
To:     dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>
Cc:     airlied@gmail.com, daniel@ffwll.ch, javierm@redhat.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Sep 1, 2023 at 4:40=E2=80=AFPM Douglas Anderson <dianders@chromium.=
org> wrote:
>
> Based on grepping through the source code, this driver appears to be
> missing a call to drm_atomic_helper_shutdown() at remove time. Let's
> add it.
>
> The fact that we should call drm_atomic_helper_shutdown() in the case
> of OS driver remove comes straight out of the kernel doc "driver
> instance overview" in drm_drv.c.
>
> Suggested-by: Maxime Ripard <mripard@kernel.org>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> This commit is only compile-time tested.
>
> NOTE: I'm not 100% sure this is the correct thing to do, but I _think_
> so. Please shout if you know better.
>
>  drivers/gpu/drm/solomon/ssd130x.c | 1 +
>  1 file changed, 1 insertion(+)

Landed this to drm-misc-next. Since I wasn't 100% sure, if someone
finds that this is bad after-the-fact, we can certainly revert.

10c8204c8b17 drm/ssd130x: Call drm_atomic_helper_shutdown() at remove time
