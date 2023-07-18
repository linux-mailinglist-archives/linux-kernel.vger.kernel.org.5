Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95766757B46
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 14:06:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbjGRMGK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 18 Jul 2023 08:06:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232307AbjGRMGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 08:06:03 -0400
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A56C0172D;
        Tue, 18 Jul 2023 05:05:56 -0700 (PDT)
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-563439ea4a2so3535118eaf.0;
        Tue, 18 Jul 2023 05:05:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689681955; x=1692273955;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mruK4CcEV2Y+7wEbISBr4ytxp2ssbiMoV3xOD12S4I8=;
        b=lvblrOylRBFqpXVZnDt4NqAxFB3kvsk0p2TclTCMgUkespSP1ifvggA1Vbod67MUi+
         Psi9UfFmiEfe8MJa86CcA9wMtV8/pX277VH3+lhgLsR1Ds52sBnH0n86xD5aBW4LMlVs
         sFTYHAO+iaj74yhyNvmnJf7Oai5LLwYO52MIjqjlJ7CeRhleOQDKRaX0xJLkKd85g8m/
         QEZ/8VJZUoLdrZjmqEXAKgMBqSPEVoNxM8GeTYl0VD805s3PfC1Z95gMtBG4aUxews6X
         AyPy7Ob3LzZSc8dy727ulrYi5PAXBltAZxx5IOwgtCGmVEaPR4q24yVH8HuiUm3CAT+M
         TD6w==
X-Gm-Message-State: ABy/qLarLKdMOJDFuCceVmJbt/VbLgBNxj8iAAsp51O//UFhOaKgtK/r
        BuJaOtbQ3rItUe9VCOHKdjZovCE/DsbHOQ==
X-Google-Smtp-Source: APBJJlHhImNcKZgCFXK4b0vF8NcrTrJGaqfHx7r82sTtY89HWzUG94MvWpFBkNfzSw6kJCAInnjNlw==
X-Received: by 2002:a05:6808:14d6:b0:3a3:f932:4b80 with SMTP id f22-20020a05680814d600b003a3f9324b80mr17597390oiw.5.1689681955319;
        Tue, 18 Jul 2023 05:05:55 -0700 (PDT)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com. [209.85.219.175])
        by smtp.gmail.com with ESMTPSA id a84-20020a0dd857000000b0057a560a9832sm428194ywe.1.2023.07.18.05.05.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jul 2023 05:05:55 -0700 (PDT)
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-c4cb4919bb9so5576042276.3;
        Tue, 18 Jul 2023 05:05:55 -0700 (PDT)
X-Received: by 2002:a25:f81f:0:b0:c4e:3060:41f5 with SMTP id
 u31-20020a25f81f000000b00c4e306041f5mr13037468ybd.33.1689681954806; Tue, 18
 Jul 2023 05:05:54 -0700 (PDT)
MIME-Version: 1.0
References: <ac8d6190-06ae-b538-1293-07efedbfe94e@gmail.com>
In-Reply-To: <ac8d6190-06ae-b538-1293-07efedbfe94e@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 18 Jul 2023 14:05:42 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV-wu_XHy_qYGM+_UOAXN8etip731WxmgEmbQdv+SPwbw@mail.gmail.com>
Message-ID: <CAMuHMdV-wu_XHy_qYGM+_UOAXN8etip731WxmgEmbQdv+SPwbw@mail.gmail.com>
Subject: Re: [PATCH v2] pwm: fix pwm-rz-mtu3.c build errors
To:     Randy Dunlap <rd.dunlab@gmail.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-pwm@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

On Tue, Jul 18, 2023 at 8:44 AM Randy Dunlap <rd.dunlab@gmail.com> wrote:
> From: Randy Dunlap <rd.dunlab@gmail.com>
>
> When (MFD) RZ_MTU3=m and PWM_RZ_MTU3=y, there are numerous build errors:
>
> ld: vmlinux.o: in function `rz_mtu3_pwm_config':
> drivers/pwm/pwm-rz-mtu3.c:374: undefined reference to `rz_mtu3_disable'
> ld: drivers/pwm/pwm-rz-mtu3.c:377: undefined reference to `rz_mtu3_8bit_ch_write'
> ld: vmlinux.o: in function `rz_mtu3_pwm_write_tgr_registers':
> drivers/pwm/pwm-rz-mtu3.c:110: undefined reference to `rz_mtu3_16bit_ch_write'
> ld: vmlinux.o: in function `rz_mtu3_pwm_config':
> drivers/pwm/pwm-rz-mtu3.c:382: undefined reference to `rz_mtu3_8bit_ch_write'
> ld: vmlinux.o: in function `rz_mtu3_pwm_write_tgr_registers':
> drivers/pwm/pwm-rz-mtu3.c:110: undefined reference to `rz_mtu3_16bit_ch_write'
> ld: drivers/pwm/pwm-rz-mtu3.c:111: undefined reference to `rz_mtu3_16bit_ch_write'
> ld: vmlinux.o: in function `rz_mtu3_pwm_config':
> drivers/pwm/pwm-rz-mtu3.c:397: undefined reference to `rz_mtu3_enable'
> ld: vmlinux.o: in function `rz_mtu3_pwm_disable':
> drivers/pwm/pwm-rz-mtu3.c:259: undefined reference to `rz_mtu3_8bit_ch_write'
> ld: drivers/pwm/pwm-rz-mtu3.c:264: undefined reference to `rz_mtu3_disable'
> ld: vmlinux.o: in function `rz_mtu3_pwm_enable':
> drivers/pwm/pwm-rz-mtu3.c:230: undefined reference to `rz_mtu3_8bit_ch_write'
> ld: drivers/pwm/pwm-rz-mtu3.c:234: undefined reference to `rz_mtu3_8bit_ch_write'
> ld: drivers/pwm/pwm-rz-mtu3.c:238: undefined reference to `rz_mtu3_enable'
> ld: vmlinux.o: in function `rz_mtu3_pwm_is_ch_enabled':
> drivers/pwm/pwm-rz-mtu3.c:155: undefined reference to `rz_mtu3_is_enabled'
> ld: drivers/pwm/pwm-rz-mtu3.c:162: undefined reference to `rz_mtu3_8bit_ch_read'
> ld: vmlinux.o: in function `rz_mtu3_pwm_read_tgr_registers':
> drivers/pwm/pwm-rz-mtu3.c:102: undefined reference to `rz_mtu3_16bit_ch_read'
> ld: drivers/pwm/pwm-rz-mtu3.c:102: undefined reference to `rz_mtu3_16bit_ch_read'
> ld: drivers/pwm/pwm-rz-mtu3.c:103: undefined reference to `rz_mtu3_16bit_ch_read'
> ld: vmlinux.o: in function `rz_mtu3_pwm_get_state':
> drivers/pwm/pwm-rz-mtu3.c:296: undefined reference to `rz_mtu3_8bit_ch_read'
>
> Modify the dependencies of PWM_RZ_MTU3 so that COMPILE_TEST is
> still allowed but PWM_RZ_MTU3 depends on RZ_MTU3 if it is being built
> but also allow the latter not to be built.
>
> Fixes: 254d3a727421 ("pwm: Add Renesas RZ/G2L MTU3a PWM driver")
> Signed-off-by: Randy Dunlap <rd.dunlab@gmail.com

Thanks for your patch!

> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -505,7 +505,8 @@ config PWM_ROCKCHIP
>
>  config PWM_RZ_MTU3
>         tristate "Renesas RZ/G2L MTU3a PWM Timer support"
> -       depends on RZ_MTU3 || COMPILE_TEST
> +       depends on COMPILE_TEST

This makes the driver always depend on COMPILE_TEST,
which is definitely not what we want.

> +       depends on RZ_MTU3 || RZ_MTU3=n
>         depends on HAS_IOMEM
>         help
>           This driver exposes the MTU3a PWM Timer controller found in Renesas

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
