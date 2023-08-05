Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A0267710D2
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 19:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbjHERPW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 13:15:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjHERPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 13:15:21 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB4CFE6E;
        Sat,  5 Aug 2023 10:15:19 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 375HF934093337;
        Sat, 5 Aug 2023 12:15:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691255709;
        bh=EScFImeXpCeHeumWjkkLDl7mHRhAqEj9tr3yBKEd7rU=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=aO1MTkog61RI7+kD/UottjJj18ouSB4vYlRLyNSGloB9uUBGJ7y+EBNQJ6D1xFVyZ
         IHjUHEweJDbgkeFWGomF/0F+INqE/KCImbskcXTR8KuT2QwsdjSOKqZUyUVcTCCbIs
         0c+qpbcQEAYJcJLtYgBDDX8GplxmQjSVnfw0vk6Q=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 375HF95u095136
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 5 Aug 2023 12:15:09 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 5
 Aug 2023 12:15:09 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 5 Aug 2023 12:15:08 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 375HF86h035194;
        Sat, 5 Aug 2023 12:15:08 -0500
Date:   Sat, 5 Aug 2023 12:15:08 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Dhruva Gole <d-gole@ti.com>
CC:     Tony Lindgren <tony@atomide.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-omap@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH] pinctrl: single: Add compatible for ti,am625-padconf
Message-ID: <20230805171508.schg4xquoa24klk5@october>
References: <20230805045554.786092-1-d-gole@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230805045554.786092-1-d-gole@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10:25-20230805, Dhruva Gole wrote:
> From: Tony Lindgren <tony@atomide.com>
> 
> Add compatible for ti,am625-padconf to enable the use of wake-up events.
> 
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Dhruva Gole <d-gole@ti.com>
> ---
> 
> Base:
> *****
> tag: next-20230731 + below "depends on" patches
> 
> Depends on:
> ***********
> [0] Update pinctrl-single to use yaml
> [1] dt-binding: pinctrl-single: add am625 compatible
> 
> Links:
> ******
> [0] https://lore.kernel.org/linux-omap/20230731061908.GG5194@atomide.com/T/
> [1] https://lore.kernel.org/all/20230804050737.635186-1-d-gole@ti.com/
> 
> Cc: Nishanth Menon <nm@ti.com>
> Cc: Vignesh Raghavendra <vigneshr@ti.com>
> 
> Link to this patch:
> ******************
> https://lore.kernel.org/all/20230805045554.786092-1-d-gole@ti.com
> 
>  drivers/pinctrl/pinctrl-single.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/pinctrl/pinctrl-single.c b/drivers/pinctrl/pinctrl-single.c
> index f056923ecc98..3a2a9910f2ec 100644
> --- a/drivers/pinctrl/pinctrl-single.c
> +++ b/drivers/pinctrl/pinctrl-single.c
> @@ -1954,6 +1954,12 @@ static const struct pcs_soc_data pinctrl_single_am437x = {
>  	.irq_status_mask = (1 << 30),   /* OMAP_WAKEUP_EVENT */
>  };
>  
> +static const struct pcs_soc_data pinctrl_single_am625 = {
> +	.flags = PCS_QUIRK_SHARED_IRQ | PCS_CONTEXT_LOSS_OFF,
> +	.irq_enable_mask = (1 << 29),   /* WKUP_EN */
> +	.irq_status_mask = (1 << 30),   /* WKUP_EVT */
> +};
> +

Why cant we set this in the k3-pinctrl.h and set it once?

The event will not be generated until wakeup daisy chain is triggered
anyways.

Have you looked at all the padconf registers across devices to ensure
the WKUP_EN/EVT bits are present? daisy chain feature is used elsewhere
as well.


>  static const struct pcs_soc_data pinctrl_single = {
>  };
>  
> @@ -1962,6 +1968,7 @@ static const struct pcs_soc_data pinconf_single = {
>  };
>  
>  static const struct of_device_id pcs_of_match[] = {
> +	{ .compatible = "ti,am625-padconf", .data = &pinctrl_single_am625 },
>  	{ .compatible = "ti,omap3-padconf", .data = &pinctrl_single_omap_wkup },
>  	{ .compatible = "ti,omap4-padconf", .data = &pinctrl_single_omap_wkup },
>  	{ .compatible = "ti,omap5-padconf", .data = &pinctrl_single_omap_wkup },
> -- 
> 2.34.1
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
