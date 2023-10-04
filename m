Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7E847B97F2
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 00:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233781AbjJDWYd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 18:24:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231651AbjJDWYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 18:24:30 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9B45EC;
        Wed,  4 Oct 2023 15:24:24 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 070B720003;
        Wed,  4 Oct 2023 22:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1696458263;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rZEPDMNKYxxc1y/Lg8uXbOfwUDjfLMxGlYiDmv2DKy0=;
        b=F5MZyLh50CqykMPgDt4SoT8jABGpLvGTQmWqAH1oKxPi9ISbpZ1bcQhF8L82NNNCZUF4td
        STe03+qh1fT6FcGgGLxf2XMhEmQDqksoXUidjFwK6rIxQi4DxtPI7CiFCj5nomM+yI9mK7
        Lms3vpQ58rf4An1FIeFQGmagLIod3PLuEx9x1yydigKLXKrmKgOyCHjbP3Z6pF1GHFZsEI
        aP/o4+huX6Vm0bHF4pqKY3bp5t8kZNlpezxh56xhq7P6uwSJcH0Y+EgPmcJiZlWNFoA1eu
        tU4Hjbzb3QhpPvCEFP1Rs4xs4B11bepJNjp91M2sl0vY5rStDv7pZyGXMdBkGg==
Date:   Thu, 5 Oct 2023 00:24:20 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Ralph Siemsen <ralph.siemsen@linaro.org>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pinctrl: renesas: rzn1: enable PINMUX
Message-ID: <20231005002420.7d03bbd8@xps-13>
In-Reply-To: <20231004200008.1306798-1-ralph.siemsen@linaro.org>
References: <20231004200008.1306798-1-ralph.siemsen@linaro.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ralph,

ralph.siemsen@linaro.org wrote on Wed,  4 Oct 2023 16:00:08 -0400:

> Enable pin muxing (eg. programmable function), so that the RZN1 GPIO
> pins will be configured as specified by the pinmux in the DTS.
>=20
> This used to be enabled implicitly via CONFIG_GENERIC_PINMUX_FUNCTIONS,
> however that was removed in 308fb4e4eae14e6189dece3b7cf5b5f453c5d02
> since the rzn1 driver does not call any of the generic pinmux functions.
>=20
> Signed-off-by: Ralph Siemsen <ralph.siemsen@linaro.org>

You probably need to point at this commit with a Fixes and possibly Cc
this to stable. Also you should use proper formatting for the commit
(12 digits sha then the text inside ("...")).

With this added:

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

> ---
>  drivers/pinctrl/renesas/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/pinctrl/renesas/Kconfig b/drivers/pinctrl/renesas/Kc=
onfig
> index 77730dc548ed..0ad8e14ccc52 100644
> --- a/drivers/pinctrl/renesas/Kconfig
> +++ b/drivers/pinctrl/renesas/Kconfig
> @@ -234,6 +234,7 @@ config PINCTRL_RZN1
>  	bool "pin control support for RZ/N1"
>  	depends on OF
>  	depends on ARCH_RZN1 || COMPILE_TEST
> +	select PINMUX
>  	select GENERIC_PINCONF
>  	help
>  	  This selects pinctrl driver for Renesas RZ/N1 devices.


Thanks,
Miqu=C3=A8l
