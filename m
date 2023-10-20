Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA1C97D0F9A
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 14:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377209AbjJTMYY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 08:24:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377028AbjJTMYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 08:24:22 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B546811B;
        Fri, 20 Oct 2023 05:24:20 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39KCO0vV047247;
        Fri, 20 Oct 2023 07:24:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1697804640;
        bh=bleI4hpWyyBKUFt0bBQEFx8HzzITluGATb+vZs7VYt8=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=OeXVPHWjvXRcjbTO+bazmngXBveqtbabpXRmcbib5HuBrLQ5YRxe2aUNYNFIFP40B
         9yiY5kiWch6CLp+Exj369cTtnFY/EXkZY8KjxrgtJBxEvRHvuyr/fYTl1mddQAXor/
         KkfLl5UJPVAytjOkGrjxYwOQFG00j3IQpti/FoGU=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39KCO0EQ053300
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 20 Oct 2023 07:24:00 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 20
 Oct 2023 07:23:59 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 20 Oct 2023 07:23:59 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39KCNxEc121092;
        Fri, 20 Oct 2023 07:23:59 -0500
Date:   Fri, 20 Oct 2023 07:23:59 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Ravi Gunasekaran <r-gunasekaran@ti.com>
CC:     <kuba@kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
        <pabeni@redhat.com>, <rogerq@kernel.org>, <andrew@lunn.ch>,
        <f.fainelli@gmail.com>, <horms@kernel.org>,
        <linux-omap@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <srk@ti.com>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH net-next v2] net: ethernet: ti: davinci_mdio: Update K3
 SoCs list for errata i2329
Message-ID: <20231020122359.vwia7sxrcjyeo3ov@pushover>
References: <20231020111738.14671-1-r-gunasekaran@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231020111738.14671-1-r-gunasekaran@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16:47-20231020, Ravi Gunasekaran wrote:
> The errata i2329 affects certain K3 SoC versions. The k3-socinfo.c
> driver generates the revision string for different variants of the
> same SoC in an incremental fashion. This is not true for all SoCs.
> An example case being J721E, for which the actual silicon revision
> names are 1.0, 1.1 for its variants, while the k3-socinfo.c driver
> interprets these variants as revisions 1.0, 2.0 respectively,
> which is incorrect.
> 
> While the work to fixup the silicon revision string is posted
> to the soc tree, this patch serves as a fail-safe step by maintaining
> a list of correct and incorrect revision strings, so that the fixup
> work does not break the errata workaround for such corrected SoCs.
> 
> The silicon revisions affected by the errata i2329 can be found under
> the MDIO module in the "Advisories by Modules" section of each
> SoC errata document listed below
> 
> AM62x: https://www.ti.com/lit/er/sprz487c/sprz487c.pdf
> AM64X: https://www.ti.com/lit/er/sprz457g/sprz457g.pdf
> AM65X: https://www.ti.com/lit/er/sprz452i/sprz452i.pdf
> J7200: https://www.ti.com/lit/er/sprz491d/sprz491d.pdf
> J721E: https://www.ti.com/lit/er/sprz455d/sprz455d.pdf
> J721S2: https://www.ti.com/lit/er/sprz530b/sprz530b.pdf
> 
> Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
> ---
> 
> Changes since v1:
> * For J721E, retained the incorrect SR ID and added the correct one
> * Add AM65x SR2.1 to the workaround list
> 
> v1: https://lore.kernel.org/all/20231018140009.1725-1-r-gunasekaran@ti.com/
> 
>  drivers/net/ethernet/ti/davinci_mdio.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/ethernet/ti/davinci_mdio.c b/drivers/net/ethernet/ti/davinci_mdio.c
> index 628c87dc1d28..25aaef502edc 100644
> --- a/drivers/net/ethernet/ti/davinci_mdio.c
> +++ b/drivers/net/ethernet/ti/davinci_mdio.c
> @@ -516,9 +516,11 @@ static const struct soc_device_attribute k3_mdio_socinfo[] = {
>  	{ .family = "AM64X", .revision = "SR2.0", .data = &am65_mdio_soc_data },
>  	{ .family = "AM65X", .revision = "SR1.0", .data = &am65_mdio_soc_data },
>  	{ .family = "AM65X", .revision = "SR2.0", .data = &am65_mdio_soc_data },
> +	{ .family = "AM65X", .revision = "SR2.1", .data = &am65_mdio_soc_data },
>  	{ .family = "J7200", .revision = "SR1.0", .data = &am65_mdio_soc_data },
>  	{ .family = "J7200", .revision = "SR2.0", .data = &am65_mdio_soc_data },
>  	{ .family = "J721E", .revision = "SR1.0", .data = &am65_mdio_soc_data },
> +	{ .family = "J721E", .revision = "SR1.1", .data = &am65_mdio_soc_data },
>  	{ .family = "J721E", .revision = "SR2.0", .data = &am65_mdio_soc_data },
>  	{ .family = "J721S2", .revision = "SR1.0", .data = &am65_mdio_soc_data},
>  	{ /* sentinel */ },
> 

Looks like every device is impacted -> so, why not just flip the
logic to indicate devices that are NOT impacted? is'nt that a smaller
list?

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
