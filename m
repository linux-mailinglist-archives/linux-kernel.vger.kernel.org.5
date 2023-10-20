Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D8C57D158B
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 20:12:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377990AbjJTSM3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 14:12:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377957AbjJTSM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 14:12:27 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A674D5E;
        Fri, 20 Oct 2023 11:12:25 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39KIC64N091271;
        Fri, 20 Oct 2023 13:12:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1697825526;
        bh=O5tj34Fk5wcP36nJvs/VWBsQMe3mczk8/9535aCy8Cs=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=qH2lVI/DPwvFiAPkUgK0c3L8GzueZfyeV/J3s82kxt6ZcGOChVhj40p23ZHtGS5kY
         HTS5HZMBw7F9u8cEN6jqzMwd0I4LL39Mva+RLS+0/F/X3GdYzrT2MJ+6f9mP0iwu8/
         U0fAFQzL5x5YZ0/Ki1e6a+IupEx1BF8ZlIuZXNLY=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39KIC6E3095769
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 20 Oct 2023 13:12:06 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 20
 Oct 2023 13:12:06 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 20 Oct 2023 13:12:05 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39KIC5JD078186;
        Fri, 20 Oct 2023 13:12:06 -0500
Date:   Fri, 20 Oct 2023 13:12:05 -0500
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
Message-ID: <20231020181205.7zfsfq3aue6dazp2@theme>
References: <20231020111738.14671-1-r-gunasekaran@ti.com>
 <20231020122359.vwia7sxrcjyeo3ov@pushover>
 <2046f9ad-b5c2-bc42-03de-6254d6ed92d3@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2046f9ad-b5c2-bc42-03de-6254d6ed92d3@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23:35-20231020, Ravi Gunasekaran wrote:
> 
> 
> On 10/20/2023 5:53 PM, Nishanth Menon wrote:
> > On 16:47-20231020, Ravi Gunasekaran wrote:
> >> The errata i2329 affects certain K3 SoC versions. The k3-socinfo.c
> >> driver generates the revision string for different variants of the
> >> same SoC in an incremental fashion. This is not true for all SoCs.
> >> An example case being J721E, for which the actual silicon revision
> >> names are 1.0, 1.1 for its variants, while the k3-socinfo.c driver
> >> interprets these variants as revisions 1.0, 2.0 respectively,
> >> which is incorrect.
> >>
> >> While the work to fixup the silicon revision string is posted
> >> to the soc tree, this patch serves as a fail-safe step by maintaining
> >> a list of correct and incorrect revision strings, so that the fixup
> >> work does not break the errata workaround for such corrected SoCs.
> >>
> >> The silicon revisions affected by the errata i2329 can be found under
> >> the MDIO module in the "Advisories by Modules" section of each
> >> SoC errata document listed below
> >>
> >> AM62x: https://www.ti.com/lit/er/sprz487c/sprz487c.pdf
> >> AM64X: https://www.ti.com/lit/er/sprz457g/sprz457g.pdf
> >> AM65X: https://www.ti.com/lit/er/sprz452i/sprz452i.pdf
> >> J7200: https://www.ti.com/lit/er/sprz491d/sprz491d.pdf
> >> J721E: https://www.ti.com/lit/er/sprz455d/sprz455d.pdf
> >> J721S2: https://www.ti.com/lit/er/sprz530b/sprz530b.pdf
> >>
> >> Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
> >> ---
> >>
> >> Changes since v1:
> >> * For J721E, retained the incorrect SR ID and added the correct one
> >> * Add AM65x SR2.1 to the workaround list
> >>
> >> v1: https://lore.kernel.org/all/20231018140009.1725-1-r-gunasekaran@ti.com/
> >>
> >>  drivers/net/ethernet/ti/davinci_mdio.c | 2 ++
> >>  1 file changed, 2 insertions(+)
> >>
> >> diff --git a/drivers/net/ethernet/ti/davinci_mdio.c b/drivers/net/ethernet/ti/davinci_mdio.c
> >> index 628c87dc1d28..25aaef502edc 100644
> >> --- a/drivers/net/ethernet/ti/davinci_mdio.c
> >> +++ b/drivers/net/ethernet/ti/davinci_mdio.c
> >> @@ -516,9 +516,11 @@ static const struct soc_device_attribute k3_mdio_socinfo[] = {
> >>  	{ .family = "AM64X", .revision = "SR2.0", .data = &am65_mdio_soc_data },
> >>  	{ .family = "AM65X", .revision = "SR1.0", .data = &am65_mdio_soc_data },
> >>  	{ .family = "AM65X", .revision = "SR2.0", .data = &am65_mdio_soc_data },
> >> +	{ .family = "AM65X", .revision = "SR2.1", .data = &am65_mdio_soc_data },
> >>  	{ .family = "J7200", .revision = "SR1.0", .data = &am65_mdio_soc_data },
> >>  	{ .family = "J7200", .revision = "SR2.0", .data = &am65_mdio_soc_data },
> >>  	{ .family = "J721E", .revision = "SR1.0", .data = &am65_mdio_soc_data },
> >> +	{ .family = "J721E", .revision = "SR1.1", .data = &am65_mdio_soc_data },
> >>  	{ .family = "J721E", .revision = "SR2.0", .data = &am65_mdio_soc_data },
> >>  	{ .family = "J721S2", .revision = "SR1.0", .data = &am65_mdio_soc_data},
> >>  	{ /* sentinel */ },
> >>
> > Looks like every device is impacted -> so, why not just flip the
> > logic to indicate devices that are NOT impacted? is'nt that a smaller
> > list?
> >
> 
> At the moment, the list of unaffected devices is small. But as and when we
> introduce more devices,
> this list will need update. Also I feel that few years down the line, when
> someone looks at the code,
> a list of affected devices provides a better context as it is easier to trace it
> back to the errata document.

Just handle it with a different compatible if needed. There is no loss
of readability as the check is still readable based on soc_data. but
this removes this entire mess of interdependency of merges completely
out. There are still ROM only spins that are happening and as far as I
see this mess just keeps growing. Alternatively, reading some IP level
version register helps detect the fixed versions, uses that (infact
you should probably insist to the design team to update the revision
for the fix for this very purpose) - that way, the ones that may have
been missed could be limited by soc_data management.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
