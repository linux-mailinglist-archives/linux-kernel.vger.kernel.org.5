Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB6347F9529
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 21:05:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbjKZT6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 14:58:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjKZT6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 14:58:15 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61C4E102
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 11:58:21 -0800 (PST)
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id E7F853F0CB
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 19:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1701028696;
        bh=Fv5Sy1bgeeKuTWXOaS5zgFRHLi1qOcJDMOy9gTwJIrY=;
        h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=W1Hbqeb3YBQmivGjXehzTQTvLBgi1m6XVWTEkoQ0sMvtK8rBGxMHozO+hMbVEulIC
         OaqJw9YiLds118o1/xbSSeqoHoAUO2I0VAtX253bCAPE3KIMq4lqMGnjhvjxBS3VOj
         r5ASHdXvuXoV8NFgzO+44Q6YH39oG6F0bW3Icuijm2RoU2iYxDBOmZIhLGqgOFgT3n
         Rs1ARUVMxnQolNFg/w5uul/nx0G3vQlvSnO7o4xTiHmCguKin/QjnCIcr/7/8r7+Fu
         +UGKOI5cOdIc3owySEoNngUB1gM/UbD1PNVLPxnLTb3lY5uktD3qv8loDOOjD8kdz0
         Y5wjRX0gvDdjw==
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-41cbb2970f4so44464191cf.2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 11:58:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701028696; x=1701633496;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fv5Sy1bgeeKuTWXOaS5zgFRHLi1qOcJDMOy9gTwJIrY=;
        b=EKVN2r5BVM21eBFg1K7SOMOX6NkzrSSY4tV2u01bz0WklBma8j3dCmmXFFhOZ6+v3d
         SzceyPEm0IQQfkE7tc5DStSp3SDoa0OotXxWoxu7rKfOHjUuww+8H7u8b/8LwSAtIRGD
         tjPN01DNmrm8FDbV6/c5jodIt49jJUj30CX1BzNORwH7qrd7xGxwjNscknI6XM8Nbvjo
         926rQg1Uc/quwpfcKFJxVLPFfNnT5LqbSTrsLv6hJx20+RRArpyuKniCRLgcwhWEWToT
         hvBtnUVWrqRCnDV9MZPfTHqkCu7miEirGHPz3TpkzbzR9qzj33E3a+UgUfdb58ZclrHZ
         xbtg==
X-Gm-Message-State: AOJu0YzmyLOsWkBPJ/6HXhg6gKTVYSESQFbyNxfjCQtQSg09U13B2Uqu
        NX2+bKTBJNbsPmWN/e2DPe3T8Zz4w0isWHwZqiDiigK+VUAZcj8tvUNpLArWuJkbEza/fepbnvM
        k2uoThgIN9K10Sc2zaU+vlmECB2rvWLSoN8oXO5rIIhUXrJK6Oo/lVNsrhg==
X-Received: by 2002:a05:622a:4e:b0:415:138e:d858 with SMTP id y14-20020a05622a004e00b00415138ed858mr10677409qtw.60.1701028695964;
        Sun, 26 Nov 2023 11:58:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHzfyxHlMPg6gs3qECUZMlDZNOsnBSQXcHKr05s9isHZQzCbpV2qykQRVIfDqD/UjwyIvvSobv1eWomDNEQTz0=
X-Received: by 2002:a05:622a:4e:b0:415:138e:d858 with SMTP id
 y14-20020a05622a004e00b00415138ed858mr10677398qtw.60.1701028695690; Sun, 26
 Nov 2023 11:58:15 -0800 (PST)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 26 Nov 2023 20:58:15 +0100
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <20231123193355.3400852-21-andriy.shevchenko@linux.intel.com>
References: <20231123193355.3400852-1-andriy.shevchenko@linux.intel.com> <20231123193355.3400852-21-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Date:   Sun, 26 Nov 2023 20:58:15 +0100
Message-ID: <CAJM55Z_bWE8BU5V+j5DFHoBm+EWngj9dOVZ8Qq0x7EimLCWbZg@mail.gmail.com>
Subject: Re: [PATCH v2 20/21] pinctrl: starfive: Convert to use grp member
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
        Jianlong Huang <jianlong.huang@starfivetech.com>,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        openbmc@lists.ozlabs.org, linux-mips@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Cc:     Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>, Jacky Bai <ping.bai@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sean Wang <sean.wang@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Hal Feng <hal.feng@starfivetech.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Shevchenko wrote:
> Convert drivers to use grp member embedded in struct group_desc.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>

> ---
>  drivers/pinctrl/starfive/pinctrl-starfive-jh7100.c | 8 ++++----
>  drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c | 8 ++++----
>  2 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/pinctrl/starfive/pinctrl-starfive-jh7100.c b/drivers/pinctrl/starfive/pinctrl-starfive-jh7100.c
> index ea70b8c61679..21bfbbaede72 100644
> --- a/drivers/pinctrl/starfive/pinctrl-starfive-jh7100.c
> +++ b/drivers/pinctrl/starfive/pinctrl-starfive-jh7100.c
> @@ -654,7 +654,7 @@ static int starfive_set_mux(struct pinctrl_dev *pctldev,
>  		return -EINVAL;
>
>  	pinmux = group->data;
> -	for (i = 0; i < group->num_pins; i++) {
> +	for (i = 0; i < group->grp.npins; i++) {
>  		u32 v = pinmux[i];
>  		unsigned int gpio = starfive_pinmux_to_gpio(v);
>  		u32 dout = starfive_pinmux_to_dout(v);
> @@ -797,7 +797,7 @@ static int starfive_pinconf_group_get(struct pinctrl_dev *pctldev,
>  	if (!group)
>  		return -EINVAL;
>
> -	return starfive_pinconf_get(pctldev, group->pins[0], config);
> +	return starfive_pinconf_get(pctldev, group->grp.pins[0], config);
>  }
>
>  static int starfive_pinconf_group_set(struct pinctrl_dev *pctldev,
> @@ -876,8 +876,8 @@ static int starfive_pinconf_group_set(struct pinctrl_dev *pctldev,
>  		}
>  	}
>
> -	for (i = 0; i < group->num_pins; i++)
> -		starfive_padctl_rmw(sfp, group->pins[i], mask, value);
> +	for (i = 0; i < group->grp.npins; i++)
> +		starfive_padctl_rmw(sfp, group->grp.pins[i], mask, value);
>
>  	return 0;
>  }
> diff --git a/drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c b/drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c
> index 9d71e8c13310..60160965cd29 100644
> --- a/drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c
> +++ b/drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c
> @@ -307,7 +307,7 @@ static int jh7110_set_mux(struct pinctrl_dev *pctldev,
>  		return -EINVAL;
>
>  	pinmux = group->data;
> -	for (i = 0; i < group->num_pins; i++) {
> +	for (i = 0; i < group->grp.npins; i++) {
>  		u32 v = pinmux[i];
>
>  		if (info->jh7110_set_one_pin_mux)
> @@ -437,7 +437,7 @@ static int jh7110_pinconf_group_get(struct pinctrl_dev *pctldev,
>  	if (!group)
>  		return -EINVAL;
>
> -	return jh7110_pinconf_get(pctldev, group->pins[0], config);
> +	return jh7110_pinconf_get(pctldev, group->grp.pins[0], config);
>  }
>
>  static int jh7110_pinconf_group_set(struct pinctrl_dev *pctldev,
> @@ -508,8 +508,8 @@ static int jh7110_pinconf_group_set(struct pinctrl_dev *pctldev,
>  		}
>  	}
>
> -	for (i = 0; i < group->num_pins; i++)
> -		jh7110_padcfg_rmw(sfp, group->pins[i], mask, value);
> +	for (i = 0; i < group->grp.npins; i++)
> +		jh7110_padcfg_rmw(sfp, group->grp.pins[i], mask, value);
>
>  	return 0;
>  }
> --
> 2.43.0.rc1.1.gbec44491f096
>
