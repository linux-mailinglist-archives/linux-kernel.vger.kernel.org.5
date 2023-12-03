Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 849D780245B
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 14:48:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233525AbjLCNrr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 08:47:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjLCNrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 08:47:46 -0500
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E35AF3;
        Sun,  3 Dec 2023 05:47:51 -0800 (PST)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3B3DlXpk071454;
        Sun, 3 Dec 2023 07:47:33 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1701611253;
        bh=xsg/cZcC0C4RBj5/hP3Rl+RIv4uXX6jNJCBDcI6sbsM=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=YpSHBzLFqZlDmVXKm0BcTSuNFrjn4JFnzHvew5OdFiIruybcgRW34OstTfqliCG31
         vwAGtBkToresUbhr2WnLYcbFWo80D+hIMRmF3YNkvEA8RY++HuPsI/r72uEx2FKy9r
         whyPqiXowhlzMRuRefK2ZjY1LKxsYUDecJkq7Qfg=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3B3DlXL5052513
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 3 Dec 2023 07:47:33 -0600
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 3
 Dec 2023 07:47:32 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 3 Dec 2023 07:47:32 -0600
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3B3DlWD1048955;
        Sun, 3 Dec 2023 07:47:32 -0600
Date:   Sun, 3 Dec 2023 07:47:32 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Ravi Gunasekaran <r-gunasekaran@ti.com>
CC:     <s-vadapalli@ti.com>, <rogerq@kernel.org>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <andrew@lunn.ch>, <f.fainelli@gmail.com>, <horms@kernel.org>,
        <linux-omap@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <srk@ti.com>
Subject: Re: [PATCH net-next v3] net: ethernet: ti: davinci_mdio: Update K3
 SoCs list for errata i2329
Message-ID: <20231203134732.qkvq7t4w7nthfxpx@kobold>
References: <20231201132033.29576-1-r-gunasekaran@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231201132033.29576-1-r-gunasekaran@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18:50-20231201, Ravi Gunasekaran wrote:
> The errata i2329 affects all the currently available silicon revisions of
> AM62x, AM64x, AM65x, J7200, J721E and J721S2. So remove the revision
> string from the SoC list.
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
> Changes since v2:
> * Removed revision string for all the affected SoCs
> 
> Changes since v1:
> * For J721E, retained the incorrect SR ID and added the correct one
> * Add AM65x SR2.1 to the workaround list
> 
> v2: https://lore.kernel.org/all/20231020111738.14671-1-r-gunasekaran@ti.com/
> v1: https://lore.kernel.org/all/20231018140009.1725-1-r-gunasekaran@ti.com/
> 
>  drivers/net/ethernet/ti/davinci_mdio.c | 16 ++++++----------
>  1 file changed, 6 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/net/ethernet/ti/davinci_mdio.c b/drivers/net/ethernet/ti/davinci_mdio.c
> index 628c87dc1d28..8e07d4a1b6ba 100644
> --- a/drivers/net/ethernet/ti/davinci_mdio.c
> +++ b/drivers/net/ethernet/ti/davinci_mdio.c
> @@ -511,16 +511,12 @@ static const struct k3_mdio_soc_data am65_mdio_soc_data = {
>  };
>  
>  static const struct soc_device_attribute k3_mdio_socinfo[] = {
> -	{ .family = "AM62X", .revision = "SR1.0", .data = &am65_mdio_soc_data },
> -	{ .family = "AM64X", .revision = "SR1.0", .data = &am65_mdio_soc_data },
> -	{ .family = "AM64X", .revision = "SR2.0", .data = &am65_mdio_soc_data },
> -	{ .family = "AM65X", .revision = "SR1.0", .data = &am65_mdio_soc_data },
> -	{ .family = "AM65X", .revision = "SR2.0", .data = &am65_mdio_soc_data },
> -	{ .family = "J7200", .revision = "SR1.0", .data = &am65_mdio_soc_data },
> -	{ .family = "J7200", .revision = "SR2.0", .data = &am65_mdio_soc_data },
> -	{ .family = "J721E", .revision = "SR1.0", .data = &am65_mdio_soc_data },
> -	{ .family = "J721E", .revision = "SR2.0", .data = &am65_mdio_soc_data },
> -	{ .family = "J721S2", .revision = "SR1.0", .data = &am65_mdio_soc_data},
> +	{ .family = "AM62X", .data = &am65_mdio_soc_data },
> +	{ .family = "AM64X", .data = &am65_mdio_soc_data },
> +	{ .family = "AM65X", .data = &am65_mdio_soc_data },
> +	{ .family = "J7200", .data = &am65_mdio_soc_data },
> +	{ .family = "J721E", .data = &am65_mdio_soc_data },
> +	{ .family = "J721S2", .data = &am65_mdio_soc_data },
>  	{ /* sentinel */ },


Much better. Thank you. and will avoid the conflicts we have with fixups
pending..

Reviewed-by: Nishanth Menon <nm@ti.com>

-- 

Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
