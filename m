Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 860457CE16F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 17:45:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344750AbjJRPpK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 11:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232412AbjJRPpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 11:45:06 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36EFC118;
        Wed, 18 Oct 2023 08:45:04 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39IFinrK079557;
        Wed, 18 Oct 2023 10:44:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1697643889;
        bh=/ZywHds19OF8HgvTVTSGg8Wo3OLLlAOYwDmxLDtIUMI=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=Oe+C2tKY9UB/+03MhksDPTI9LlmzUpd1II2ZhfYIPlV+t5hcan100OuXwJfrBF33J
         W93rOEkMI0mR5RdGp32+ZBNEXgBnGP3VV4TNHGQ8Duzndv8AAHKE55QqLUgcRbIxoY
         dE4EmZwVR/R+KHAup/hz7dOT44ShcigrueL5XLOs=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39IFin8o029902
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 18 Oct 2023 10:44:49 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 18
 Oct 2023 10:44:48 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 18 Oct 2023 10:44:48 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39IFim0D005933;
        Wed, 18 Oct 2023 10:44:48 -0500
Date:   Wed, 18 Oct 2023 10:44:48 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Ravi Gunasekaran <r-gunasekaran@ti.com>,
        Neha Malcom Francis <n-francis@ti.com>
CC:     <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <rogerq@ti.com>, <andrew@lunn.ch>,
        <f.fainelli@gmail.com>, <horms@kernel.org>,
        <linux-omap@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <srk@ti.com>,
        Thejasvi Konduru <t-konduru@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <u-kumar1@ti.com>
Subject: Re: [PATCH net-next] net: ethernet: ti: davinci_mdio: Fix the
 revision string for J721E
Message-ID: <20231018154448.vlunpwbw67xeh4rj@unfasten>
References: <20231018140009.1725-1-r-gunasekaran@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231018140009.1725-1-r-gunasekaran@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19:30-20231018, Ravi Gunasekaran wrote:
> Prior to the commit 07e651db2d78 ("soc: ti: k3-socinfo: Revamp driver
> to accommodate different rev structs"), K3 SoC's revision was
> interpreted as an incremental value or one-to-one mapping of the
> JTAG_ID's variant field. Now that the revision mapping is fixed,
> update the correct revision string for J721E in k3_mdio_socinfo,
> so that MDIO errata i2329 is applied for J721E SR1.1.
> 
> Fixes: 07e651db2d78 ("soc: ti: k3-socinfo: Revamp driver to accommodate different rev structs")
> Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
> ---
>  drivers/net/ethernet/ti/davinci_mdio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/ti/davinci_mdio.c b/drivers/net/ethernet/ti/davinci_mdio.c
> index 628c87dc1d28..998fe2717cf9 100644
> --- a/drivers/net/ethernet/ti/davinci_mdio.c
> +++ b/drivers/net/ethernet/ti/davinci_mdio.c
> @@ -519,7 +519,7 @@ static const struct soc_device_attribute k3_mdio_socinfo[] = {
>  	{ .family = "J7200", .revision = "SR1.0", .data = &am65_mdio_soc_data },
>  	{ .family = "J7200", .revision = "SR2.0", .data = &am65_mdio_soc_data },
>  	{ .family = "J721E", .revision = "SR1.0", .data = &am65_mdio_soc_data },
> -	{ .family = "J721E", .revision = "SR2.0", .data = &am65_mdio_soc_data },
> +	{ .family = "J721E", .revision = "SR1.1", .data = &am65_mdio_soc_data },
>  	{ .family = "J721S2", .revision = "SR1.0", .data = &am65_mdio_soc_data},
>  	{ /* sentinel */ },
>  };
> 
> base-commit: 2dac75696c6da3c848daa118a729827541c89d33

Uggh.. This is a bit of chicken or hen problem here that creates
bisectability issues (thanks for linux-next for exposing this).

Neha's patch I picked up is a valid fix, though this side effect was
unfortunate.

My suggestion is:
a) I will drop
   https://lore.kernel.org/all/20231016101608.993921-4-n-francis@ti.com/
   from my queue for this window.
b) please identify other places where we could have this situation.
https://www.ti.com/lit/pdf/spruiu1 seems to indicate just SR1.0 for
J7200.

We then have the following steps potentially

Drop the fixes and Maintain both SR2.0 and SR1.0 (add SR1.1) so that
we can merge the socinfo fixes without breaking bisectability.

To merge, the following options exist:
A) netdev maintainers could provide me an rc1 based immutable tag
B) if netdev maintainers can give me a ack to carry this patch(or patch
   series for relevant SoCs) on my tree, I can apply the fixes before
   picking up the socinfo fixups.
C) I can wait a kernel window to the nearest rc1 *after* netdev fixes
   are merged in to pick up socinfo fix.

Once A/B/C is done (I would like netdev maintainers to suggest which way
to go), we can drop the "invalid" SoC SR ID.

I don't see a cleaner way to get this inter-dependency integrated.

Also in the future, please CC me as the reporter and for Soc-fixes
dependency issues (I am listed in the MAINTAINERS file).

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
