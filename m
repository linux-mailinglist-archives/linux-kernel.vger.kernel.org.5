Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57C727EF7D2
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 20:28:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231947AbjKQT2E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 14:28:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231868AbjKQT2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 14:28:03 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01492D4B
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 11:28:00 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-280b06206f7so512154a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 11:27:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700249279; x=1700854079; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wj6uB37R8tTLmYWQxD3IhJvQztAaDxzKAeZZ9RZKtso=;
        b=czOLEI8ekywyK6DtdHCC4wAiindouKxJkyBuxBoNSzdT3+gWBr+TT/L8ZDgHIiKIOx
         DD0XmUnXovME+2d1fAAPLpo47FxlAhMicgh1pimCL18pcEkz8qK6zVZC0+elAebPGQ9Z
         NAJdQAD7fgdObVmNO919o+MFEAJ3eHA1wCjz0VecSFaygXclKoIbOYcuBz0jMBkJav7X
         NAP3nYPBbov5iyEFDurqlqwI9zHMpnPoH0qTf+Iuwjg8z3czlV+KSD722djctQYKo9dz
         W0KKFKEz51XOaowAymViqiOnlGDqFhuxruF6Mud02FT8JWwhz4UehYEXNIoBEz/026lY
         V3UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700249279; x=1700854079;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wj6uB37R8tTLmYWQxD3IhJvQztAaDxzKAeZZ9RZKtso=;
        b=bia+A+QePMAJWjlOjXR+ou31U+pGtSFMxQzYmJd060oLZFWkpgAXdeUpWb2nfi2gQZ
         nmeGwsNH94RxKskei4S1umkhPcU1IYdezygM64JP+JWDt2iEfkhdaSSJyj3OwydQxnkB
         4DJZbzr8PcVuwdayAE4hqe6IfcXNfYiX3YqL6JtMtKAIJOCITo6YVSWSwtqS4b3k+QnB
         yzcS+buXT5RiGnVKMgh+kTClsYzVuijV/KLqJTCPUZmsIHvGpmOROl71EsTaR7Pj69j7
         P1R7W4P3rFePvZ5rH/9jhjWrrtDhfxnhk+h0MoxegD9xuZVJAKt6+H75fe9k/auog3JN
         eATg==
X-Gm-Message-State: AOJu0Yy2Y1Yc4KT4OD7J0jOY2db8tHImEYvDF/kptU4Eysoxar7H1L4K
        8Vs1uI4tu0CHRP8d5NfLbVAGC+f/ceKAJYPxrpC5UXy0ppQ=
X-Google-Smtp-Source: AGHT+IGpmf5PpZM3wbqS3BAXz4gDlhI3cBaZHfL4/PkNJ2ypLVm6z4fUikgmsPY3cDV7ZVOSxpGfgU2JwamzWwg+ATU=
X-Received: by 2002:a17:90b:2386:b0:274:60c7:e15a with SMTP id
 mr6-20020a17090b238600b0027460c7e15amr469895pjb.4.1700249279423; Fri, 17 Nov
 2023 11:27:59 -0800 (PST)
MIME-Version: 1.0
References: <20231117-rk-lvds-defer-msg-v1-1-1e6894cf9a74@theobroma-systems.com>
In-Reply-To: <20231117-rk-lvds-defer-msg-v1-1-1e6894cf9a74@theobroma-systems.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Fri, 17 Nov 2023 16:27:47 -0300
Message-ID: <CAOMZO5BVX3UmZ-45OphM6WDhz_ENkxm+Sr1dXkt4jR+Mmo-1Gg@mail.gmail.com>
Subject: Re: [PATCH] drm/rockchip: lvds: do not print error message when
 deferring probe
To:     Quentin Schulz <foss+kernel@0leil.net>
Cc:     Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mark Yao <markyao0591@gmail.com>,
        linux-rockchip@lists.infradead.org,
        Quentin Schulz <quentin.schulz@theobroma-systems.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Quentin,

On Fri, Nov 17, 2023 at 3:31=E2=80=AFPM Quentin Schulz <foss+kernel@0leil.n=
et> wrote:
>
> From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
>
> This scary message may happen if the panel or bridge is not probed
> before the LVDS controller is, resulting in some head scratching because
> the LVDS panel is actually working, since a later try will eventually
> find the panel or bridge.
>
> Therefore let's demote this error message into a debug message to not
> scare users unnecessarily.
...

> diff --git a/drivers/gpu/drm/rockchip/rockchip_lvds.c b/drivers/gpu/drm/r=
ockchip/rockchip_lvds.c
> index f0f47e9abf5a..52e2ce2a61a8 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_lvds.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_lvds.c
> @@ -577,7 +577,7 @@ static int rockchip_lvds_bind(struct device *dev, str=
uct device *master,
>                 ret =3D -EINVAL;
>                 goto err_put_port;
>         } else if (ret) {
> -               DRM_DEV_ERROR(dev, "failed to find panel and bridge node\=
n");
> +               DRM_DEV_DEBUG(dev, "failed to find panel and bridge node\=
n");
>                 ret =3D -EPROBE_DEFER;

What about using dev_err_probe() instead?
