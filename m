Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C96FC75C41E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 12:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231573AbjGUKLl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 06:11:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231405AbjGUKLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 06:11:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E23B2727
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 03:11:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AF57A61059
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 10:11:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4389C433C8;
        Fri, 21 Jul 2023 10:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689934295;
        bh=k8eV/3qHdnbYgcZI2X9fFCwH8gqs3YzalZZPqB9YJ08=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=K7zk8MwQYLqclUypLaTrXMCzvlgETP5wEUWYH0H/6hRQCVlJ2XF8oY1b2h0EY0uRn
         qGH6fUjQz9xO3zkx9Ef4VLHWU8jiD9CtFogqDBwrTdIrA2rlAiF7t0sLqGfWMBJ06N
         sd+tv+6e6gLU0xZZ7K+kl5RSz3I8Gk1mR36ZRrVUKpER3jHGaJu7uPgtzFJqSbRt9u
         24aHlOVN+bmSPukO3e79iQUiANVgAdvct/SgdK88yqoVHlphiDOJJjTpODhfz6Z/6e
         4MoV3J7h8ISpE3hwy0qAl4T2Dm+rguLoiTFK/keQqTv5crxgOCzcqv7SwLKYj6E/vA
         jd/LUNYKARcLQ==
Message-ID: <cfba8fa4-47e5-7553-f40e-9e34b25d1405@kernel.org>
Date:   Fri, 21 Jul 2023 12:11:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [Enable Designware XGMAC VLAN Stripping Feature 2/2] net: stmmac:
 dwxgmac2: Add support for HW-accelerated VLAN Stripping
Content-Language: en-US
To:     Boon@ecsmtp.png.intel.com, Khai@ecsmtp.png.intel.com,
        "Ng <boon.khai.ng"@intel.com,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Boon Khai Ng <boon.khai.ng@intel.com>,
        Shevchenko Andriy <andriy.shevchenko@intel.com>,
        Mun Yew Tham <mun.yew.tham@intel.com>,
        Leong Ching Swee <leong.ching.swee@intel.com>,
        G Thomas Rohan <rohan.g.thomas@intel.com>,
        Shevchenko Andriy <andriy.shevchenko@linux.intel.com>
References: <20230721062617.9810-1-boon.khai.ng@intel.com>
 <20230721062617.9810-3-boon.khai.ng@intel.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20230721062617.9810-3-boon.khai.ng@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/07/2023 08:26, Boon@ecsmtp.png.intel.com wrote:
> From: Boon Khai Ng <boon.khai.ng@intel.com>
> 
> Currently, VLAN tag stripping is done by software driver in
> stmmac_rx_vlan(). This patch is to Add support for VLAN tag
> stripping by the MAC hardware and MAC drivers to support it.
> This is done by adding rx_hw_vlan() and set_hw_vlan_mode()
> callbacks at stmmac_ops struct which are called from upper
> software layer.
...

>  	if (priv->dma_cap.vlhash) {
>  		ndev->features |= NETIF_F_HW_VLAN_CTAG_FILTER;
>  		ndev->features |= NETIF_F_HW_VLAN_STAG_FILTER;
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> index 23d53ea04b24..bd7f3326a44c 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> @@ -543,6 +543,12 @@ stmmac_probe_config_dt(struct platform_device *pdev, u8 *mac)
>  			plat->flags |= STMMAC_FLAG_TSO_EN;
>  	}
>  
> +	/* Rx VLAN HW Stripping */
> +	if (of_property_read_bool(np, "snps,rx-vlan-offload")) {
> +		dev_info(&pdev->dev, "RX VLAN HW Stripping\n");

Why? Drop.



Best regards,
Krzysztof

