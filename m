Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0129C76C756
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 09:47:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233354AbjHBHrL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 03:47:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233295AbjHBHqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 03:46:45 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0259135A5
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 00:44:02 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-3090d3e9c92so6548044f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 00:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1690962240; x=1691567040;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=zrfr8demoIbS0/fY7FGFGHUvwM9dqz7KGdFUzvSMnB4=;
        b=SQ0Jmtsd6fDkK+VaTExixKraao2PdwInKoTajuVotP1pQ1FPyv409LVbP9v/bMIqEw
         VoJcEqWxkG1QCm2ugsqmnlRX6nPvEdKEXEYtD4O4lRTI03300HRKUfQqgWvcGmOb5HyP
         wXz1F3U/RzYBlZ6JpHDdtJtpxsDMOJrhp+UWTBI0FlWZMkt6AVF5KOHBJbv8yoNOjN4A
         MIosrKok2qAQR/tvHmLn+Az/PLp2iGy8Kj/UweBlIeG48eMkxPlua3zHMNlJISEspHz1
         AwAaE+DWWHdW8WNFbFZ0JcgVfRqxmUvR1fC1nF5mpJHwOLJeJ1GyaeaEod0UoJdFT6d9
         N39w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690962240; x=1691567040;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zrfr8demoIbS0/fY7FGFGHUvwM9dqz7KGdFUzvSMnB4=;
        b=bECcCpkEXba7wupPfr/p1tHFYS5J9Jw3kL9x85BHs9teIpbwrvpJ21H8PQZqcT+QW9
         A1DYcbEHcLuTVMEugFQK2vxOOmUb544HJYmLnoHcDnTHPhlUCMinabdhaG+WgBwdaK3e
         VvJV8hLVgmKQx9wk3iqwdEWVc4WhbFLV+RnTqXR6Owq51qSedif1zzkfPACi56EjDrzV
         7oS9jLy7Y2gqW3pnmU+REq6Ka9IKbR+7qvu3F3Q6Z+ksuVMlIpPT8/jgdFH6pjPgClLb
         WqYCdxYJ2/rwxoCcrZnVzP248GCLMD/VyfDI7L9W+eCrCqgXpxukTkArtJy8yV3i/+Oi
         d6YA==
X-Gm-Message-State: ABy/qLZwHbzXy60TzKVcHqO2C2PlwPUfp3tCm4gDlRy6jEvvD937uAMx
        hK3yax0cAjRQr6vJ3F5qoQCNug==
X-Google-Smtp-Source: APBJJlHR+6nvvNO3+YmG+iuU8bYWQGf23hXA05GwI6Tl5IAu5Z/Y9z2rBt7aF/BbyZ8pIhHmTV1+5g==
X-Received: by 2002:adf:e883:0:b0:317:6e08:ed35 with SMTP id d3-20020adfe883000000b003176e08ed35mr4518025wrm.1.1690962240440;
        Wed, 02 Aug 2023 00:44:00 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:43ac:b106:31d5:42b7])
        by smtp.gmail.com with ESMTPSA id y18-20020a5d6212000000b003143c6e09ccsm18306002wru.16.2023.08.02.00.43.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 00:44:00 -0700 (PDT)
References: <CACqvRUZYH2NkOooE78SK6=Ow07y=YnE2QOSNzyb99rV4vSvxpQ@mail.gmail.com>
User-agent: mu4e 1.8.13; emacs 28.2
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Da Xue <da@libre.computer>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: mdio-mux-meson-gxl: set RESERVED0 bit in REG2
Date:   Wed, 02 Aug 2023 09:43:38 +0200
In-reply-to: <CACqvRUZYH2NkOooE78SK6=Ow07y=YnE2QOSNzyb99rV4vSvxpQ@mail.gmail.com>
Message-ID: <1ja5v9q474.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue 01 Aug 2023 at 16:34, Da Xue <da@libre.computer> wrote:

> The first RESERVED register bit needs to be set in order for the PHY
> to come up. Otherwise the ethernet device stays in "No Carrier".
> There's no associated documentation for this register bit in the
> Amlogic datasheets, only the default value to set for the entire
> register.
>
> This register bit is normally set in u-boot so it is not noticed in
> Linux. During my testing with u-boot net disabled, this problem crops
> up.
>
> Signed-off-by: Da Xue <da@libre.computer>

Reviewed-by: Jerome Brunet <jbrunet@baylibre.com>

> ---
>  drivers/net/mdio/mdio-mux-meson-gxl.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/mdio/mdio-mux-meson-gxl.c
> b/drivers/net/mdio/mdio-mux-meson-gxl.c
> index 76188575ca1f..210a52d98112 100644
> --- a/drivers/net/mdio/mdio-mux-meson-gxl.c
> +++ b/drivers/net/mdio/mdio-mux-meson-gxl.c
> @@ -17,6 +17,7 @@
>  #define  REG2_LEDACT           GENMASK(23, 22)
>  #define  REG2_LEDLINK          GENMASK(25, 24)
>  #define  REG2_DIV4SEL          BIT(27)
> +#define  REG2_RESERVED0                BIT(28)
>  #define  REG2_ADCBYPASS                BIT(30)
>  #define  REG2_CLKINSEL         BIT(31)
>  #define ETH_REG3               0x4
> @@ -65,7 +66,7 @@ static void gxl_enable_internal_mdio(struct
> gxl_mdio_mux *priv)
>          * The only constraint is that it must match the one in
>          * drivers/net/phy/meson-gxl.c to properly match the PHY.
>          */
> -       writel(FIELD_PREP(REG2_PHYID, EPHY_GXL_ID),
> +       writel(REG2_RESERVED0 | FIELD_PREP(REG2_PHYID, EPHY_GXL_ID),
>                priv->regs + ETH_REG2);
>
>         /* Enable the internal phy */

