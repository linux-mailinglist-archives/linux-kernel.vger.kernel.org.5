Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18CF976DAE1
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 00:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbjHBWmy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 18:42:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbjHBWmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 18:42:52 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2443F1BFD;
        Wed,  2 Aug 2023 15:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Cc:Content-ID:Content-Description;
        bh=ZAt5oCDS6JrwfOPrBUaQCwMwkHrvaU90qd98KrNpgBg=; b=IbsXYdM1zZqenWe0ZizdWJ4GLJ
        2OeZY1/thYqaNjkvlVVa4f6LZ75AXL7Gmnh4QG5qS5H0OmWnBz7VV2iyQoeEbZwCl6p7JSxSKRZIz
        i8f/7RL6tlDslFYl/NWA/baM2PBEGJkKuo4hA27ULIXv0LniQtlUGqoWlCDxqHcqZBkhgM/5kK3CS
        +YJsB4itAP/XZYi4BsSnx1d5MBwptn+PTqtdqRCvRphasbIMerv90UDqCjkSjOpwmu+cqJL9Y6h4E
        /j7MHQTXHyYQ7W+lyYoZbmjc2x3jNPQnLiU5L9QZc9SpC60cJEh1jvl9Hkszo/MGrGI+XYhAktyl8
        9bG4768g==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qRKYC-0063Ky-06;
        Wed, 02 Aug 2023 22:42:40 +0000
Message-ID: <0fb34d56-7333-1551-b19e-fa3e19dcab58@infradead.org>
Date:   Wed, 2 Aug 2023 15:42:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 2/5] net: hpe: Add GXP UMAC MDIO
Content-Language: en-US
To:     nick.hawkins@hpe.com, christophe.jaillet@wanadoo.fr,
        simon.horman@corigine.com, andrew@lunn.ch, verdun@hpe.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230802201824.3683-1-nick.hawkins@hpe.com>
 <20230802201824.3683-3-nick.hawkins@hpe.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230802201824.3683-3-nick.hawkins@hpe.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick,

On 8/2/23 13:18, nick.hawkins@hpe.com wrote:
> diff --git a/drivers/net/mdio/Kconfig b/drivers/net/mdio/Kconfig
> index 9ff2e6f22f3f..58e054bff786 100644
> --- a/drivers/net/mdio/Kconfig
> +++ b/drivers/net/mdio/Kconfig
> @@ -115,6 +115,19 @@ config MDIO_GPIO
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called mdio-gpio.
>  
> +config GXP_UMAC_MDIO
> +	tristate "GXP UMAC mdio support"
> +	depends on ARCH_HPE || COMPILE_TEST
> +	depends on OF_MDIO && HAS_IOMEM
> +	depends on MDIO_DEVRES
> +        help

Indent line above with one tab only.

> +	  Say y here to support the GXP UMAC MDIO bus. The
> +	  MDIO(mdio0) interface from the primary MAC (umac0)

Consistent spacing:
	  MDIO (mdio0)

> +	  is used for external PHY status and configuration.
> +	  The MDIO(mdio1) interface from the secondary MAC

	      MDIO (mdio1)

> +	  (umac1) is routed to the SGMII/100Base-X IP blocks
> +	  on the two SERDES interface connections.

thanks.
-- 
~Randy
