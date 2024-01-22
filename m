Return-Path: <linux-kernel+bounces-33957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D02F8370DC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:51:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC73C2869ED
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BECB3E461;
	Mon, 22 Jan 2024 18:18:15 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05olkn2030.outbound.protection.outlook.com [40.92.89.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7F33D99D;
	Mon, 22 Jan 2024 18:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.89.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705947494; cv=fail; b=S8VBDXn4/NZx6Xr1RlIqNU9Q0uymWnrHj0TR1JQ2a6tH5fhXGZObQb9tiKzbNfL/TgMXE2NbxtSfQHupLUgUaXdS0InsrDPdKw6xp7WBs2q74y+aD+XIApM4vjdA34hktCzDj8Jg6VnFTeMEptSUcFE2DgO+yBx9a+nLB16n8NY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705947494; c=relaxed/simple;
	bh=EMiSC84lyuwtmR+OGCOdBDqs9tOMzITBxYcojCrJtRo=;
	h=Message-ID:Date:Subject:From:To:References:In-Reply-To:
	 Content-Type:MIME-Version; b=S8OlXrNstIAeHUG4ZzsHQiWmCo2GNULK81plUdxbs1fWpXYAFFeaa2mvrXAIwappMovxSnNXiA4cWTxj7i9VydY+BMb/c2E+Zoxo17to/UOLgNKfDXb5bTr5GZgEV8iMin5iBV4TSzbpcnE9N7OD07lpJN/or9Lo+hd8hacoiII=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.de; spf=pass smtp.mailfrom=hotmail.de; arc=fail smtp.client-ip=40.92.89.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T8W68C7afj0q3lR0oSA7Uj3wFbTPtNigqBEQT4/5MYzIUoSSzowQU/PMypMotfEk0m293AoRuyimyhESAE+Sto3Vs8yVZpBsrRZGLR1H9lJJn06tw4o4U1xV7tzVHLnZEW0QztPJ3tmUQtLWQnkLPPrGxeVhZP7kxO6tGe01cb8cJTXVjHAjSl7xvIBP+ScVv9FVjEgFJtojmx1cArSyYvDLyVP184mdVG7kBub5Eszcsfw8CwYD7aZwSGb5EwyjXM8zQgjEUxT4++XyadWanPMhXM1/psH2dY4xsvm61wXCniXTpjU+mouvpwF9H1ftjO63gI8A2uhLSNFfzimLww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IEfiwqS1GXTi25zXS/pUdzFI5o8tyC1bEjhcGGvfEFg=;
 b=iA0Ni9ZNA3gRJKr6DEawaO4pnzQBna6O9WeIur/HewmBHNlbE8u+0KUZ2/1/ur+vPS5045JZ5K8jUPr+COV9DbInVB8aT6Vif2OBnBqELjLOHea3bk/O94FWcxtZKDLeMor2aa930eYFEWr1Dw53NOK//zD/KF5xQR9LG3vZeatoeW0QhKY73BC8GU49n/hG1xKaH1sk6PSYq3B5zjm4Cq5uiWJFH6o7JZUKGRZ3yanaX65H4QHpBMq+jSxDGvc/CW1x9ha0i2u5Y22GIm44Qh92rKavEHeV0Oo8h3WAWT8he2Ez8vQr/MIGTB3P2loY2PpabjyFVYc9GrIuWzpJFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from AS8P193MB1285.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:333::21)
 by PAXP193MB2201.EURP193.PROD.OUTLOOK.COM (2603:10a6:102:22c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.36; Mon, 22 Jan
 2024 18:18:09 +0000
Received: from AS8P193MB1285.EURP193.PROD.OUTLOOK.COM
 ([fe80::897e:cfd5:b29b:c611]) by AS8P193MB1285.EURP193.PROD.OUTLOOK.COM
 ([fe80::897e:cfd5:b29b:c611%6]) with mapi id 15.20.7202.031; Mon, 22 Jan 2024
 18:18:09 +0000
Message-ID:
 <AS8P193MB1285A810BD78C111E7F6AA34E4752@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
Date: Mon, 22 Jan 2024 19:19:09 +0100
User-Agent: Mozilla Thunderbird
Subject: [PATCH net v3] net: stmmac: Wait a bit for the reset to take effect
Content-Language: en-US
From: Bernd Edlinger <bernd.edlinger@hotmail.de>
To: Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Jiri Pirko <jiri@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>,
 Serge Semin <fancer.lancer@gmail.com>
References: <AS8P193MB1285DECD77863E02EF45828BE4A1A@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
 <AS8P193MB1285EEAFE30C0DE7B201D33CE46C2@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
In-Reply-To: <AS8P193MB1285EEAFE30C0DE7B201D33CE46C2@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TMN: [BAtjC9paNT0X5pFntVxz3mvUexhCEIZMOud0jdfa7Dq8UnEEn/KyIF/tP6MprThn]
X-ClientProxiedBy: FR5P281CA0058.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f0::14) To AS8P193MB1285.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:333::21)
X-Microsoft-Original-Message-ID:
 <03e90c5c-ed34-4d0f-aafa-b8f3165ecd1c@hotmail.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P193MB1285:EE_|PAXP193MB2201:EE_
X-MS-Office365-Filtering-Correlation-Id: 99098321-45b1-41b2-0415-08dc1b767cb4
X-MS-Exchange-SLBlob-MailProps:
	obhAqMD0nT+gBgqCImLTqb4mdYBvtNPTyonupf3OileFmXaQWuz3XEOFAjLVItD233Qv3HfMLCzS1dctlXGrb/FF3jVjUGzAS25jFdxOpSybby7lIpkRnYYmAzE5/sB5edzoZevoknX6Up1dxQo0YO8rRtpB2ypN0WPECrsR6pbDo89vW+FbdT+RFJgPR/flvGnxn99lSs20OJ93P5B+mHCWD+AjS6WNk4SGTbxoiN31YPszfGEdvfHa4x2oAtBpCDF6EWVOcT0G3Tm7wZhsFxSMdMio2sB/MNv0wxTv9u/NuUJszmplm6dZPpgkYEhdyy+bO1Zpjzpk7Gq3NgiUv+b30LqKaW2DKg2IZvr6VBOh88vgeHIZ82Smjp/xicKDYVwiGBcH3b1GqPXhBUJ8UHaWuCLdYG6xrcYGKbJ0AxWQEAGuZ92/bzGSAzk1IQwT/gicHjOPYYxEKLKfLOA/eZ/c0qwEmA+wIyN8wr3DcE2B7sldr5QT9Q2njsi0H+Zbs4WFW9rQvVFCguosXTEy5CA1bNKN/tRgNjnLE1/JLvg9XdwfUm2hbBX1vNygiH1hP+/V/nOp46fUXrhUO7KAeDaf6M5ZW6u1DbAALLYySPRL9gKrvy4iytugv569T9jl9Ty9weOcnRrX07DW2POxxYFQW0A6vXU1/OFd4AvFVsW+n75/Jt3R4vWjlEpfDn2NHGFoYhyVMZvkh1WTsSZ8S1o/EMtLo7mqZWzV5ob7bARdWVPok8mi1Nmk6lNIDf+r3yBjW3zR2KjqCI9EQIIWe9kysV0vp+tG7kWnmiStQf/7CR8fnY/rt80abA4WtplS
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	mVr9ldl2IEiATk+Khz6dWhQsGurpWr59ZMcs2+T0S8S+rcHtc77/ex8iLUm1hVhW9j8IX7s48kUCzRelfWv1OTLc8tJnGNaHzEWLljQnJIakUL2/YvnJLOmWjPJzVO1cdwOm6d8ZwJ0itcUmUXtkApS/b4iePK2M97eMXuesiYSR0loMAvj+sSxbbQn9YqUP3AbuPstH9PcoxA39TVVZNbt+wSa3Hi45oWN3qB9EZrUfXcs7JY/VEnpZv3+ojxIU2Xbaq90E4cQzmR8/8eo8lRhUEcOHhqK23zxbRgwU81EN4IRIAD0LMD/+tUSwMBcQegVL0wY67RYIzLoasNbo4r3tYSaVODv9mXVHJ64Gv3OjmJZwaN4aNfXVlSVqjahwm3T9Di94crLqxJodvICYQLWuM35RVDRXDEIdwxUg18NTReH8+FCJDK+WB0LCpWJ8+k4vqyMSlgFVh4lcOegw1HJEOUIj52sn2rbFpjrmOrAjRknog6GmW9YZ0Dvs+0yrDjBt1OnU3vTrNTUCHG/CzyAu8bkpqcXwPTuKV2aZVumSXvYaXFRNflG7sqac30QhxNH+UiayHx8Z2T7maGhhDnzH7d2t+vnOKZMPTVMxoYE=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TlBjcGZoVWVYMkdKTVlQNDRZbDlnZDlSY2lza1U3dWp0bnBsRzl4aUJBa0Vo?=
 =?utf-8?B?WXdLaC92cmVzaFBpeDlkNW1CclFMK2Nkemk5MUp2ZEk1N0EvdTgwa1NiZndV?=
 =?utf-8?B?eHA3QklVVzg4U3ZGVC9NMWJZSVhHbjlzeW5VVG0xL0w4TFdVbHB2TEdjblZW?=
 =?utf-8?B?cWJZYU5pM1E1NDNvdVZhbEpGUjVHcFcrZWNZek82R1Ruc3c2SnVtdGZEcXc1?=
 =?utf-8?B?UnlkVmxrc1c5RDBvVjg4bDhvTnh6cVJnVTRxWmc5Tkh6WTdKTVFlcTd2SmFR?=
 =?utf-8?B?dDN1VG5RdHRHWHd3Y3JoVzlVS090SEQ5MjdYV1VPR3R2R0pGUDByLzVtWHhu?=
 =?utf-8?B?ZmFOaGxjaVBJRzdMa1kxRjhyUHcwTnF1RklDMTZDdGtuWDRHazVSc3NMd1dL?=
 =?utf-8?B?dGNkcS9ER0hGR2FKczhKK09DWG1zSWttOEloNlFxMGhJdWxXbUNUZHJ4ZU4z?=
 =?utf-8?B?SWlGVnJ4RUhPOUJYdDRxTmExb3plL1RaOXZvY0IzREljekIyZ05hdTNKR1ZC?=
 =?utf-8?B?Z0EwT2tTOGRuNE1Vb2NjOVg3eDdYRmR3eVFKMTB3WTZsZ0RGMjhRRkJnRC8y?=
 =?utf-8?B?TTVQSUlvTVYrektQQVB0S2hTQ25wTnB6ZGRKckhaaml3ZFFSeWRHTkNuYk5K?=
 =?utf-8?B?TGdRNG8vUWg1c0NQUWJZaWRoSThDemFzR3BxdHk4VEZRbzVSbFVaRTNDVzVh?=
 =?utf-8?B?WEdzelgvdGFaOTd4QmpGbUhmSGxwMDVuRDlUYmxjV3N6UitqVTRvY1M5K3Fr?=
 =?utf-8?B?RFBGMjBNSEFiSDM0a1NzOXZoaXExU0RvRnR6Y1BoVmRTVVVmZ0pRN1NVaEhz?=
 =?utf-8?B?Q1JMWkk2M00wU2g3UTMvbGd0S05sTERacmdIeDB4YVlRKzh6WEl5ZG5HTXVr?=
 =?utf-8?B?MjdVZWdTSjR2cXV1QmFnV3dvYkhYbDVkSE1pL2RyMWlKRERwUmVVVVduZFpN?=
 =?utf-8?B?VFhZWDRnTk1VenpJRUdmTXNtRVAvUkhHaHg2a0tsL0JOL2N6QysxOXZFWHJR?=
 =?utf-8?B?L01jMnkzTmFKd0h1cGZaaTJiUWpxdlRKSXVaVXhmREdaMXVoRFdyUXpHVXlM?=
 =?utf-8?B?YW93NUJkV0JEbnZuNCtOWmM2VE1uQlVIL3BJOHdwN2VCdzBiU1JKQlJTdUVC?=
 =?utf-8?B?QUV5QkFRcTdOZS8rd0xnZFNWcEFsMDJ4YkZEVGcvRHhBbWNBT04ycHZUMGlB?=
 =?utf-8?B?ek1sQ1JNMzhBVC9NNzFGVkxXYXB4SWlybTVFSHNwMzFlbk1YUEVRWXVWRUVS?=
 =?utf-8?B?c0E5cGJKbjFYSXp5Y2pNdmdEeStNRlJLMjdtUTFTV1hLOW1UajFrTk9nMm45?=
 =?utf-8?B?eE1yMVlBRmdVeDhOdDJXREIyM3BvNVAvSHoxb2JsS29uTVRGdVpIK29uRXRB?=
 =?utf-8?B?WStEdXhVOE9JbFV0cldBUG9iaE51cWJUQk5BTG9pbEtTaWJaMU9tOE9PckJu?=
 =?utf-8?B?UXhBWmhWL2pTVXRjRVFuNG93YlpnSllFeXJLRFFkZUQvQ1Mydko1M2p5NzRh?=
 =?utf-8?B?YlhXS1BjampTMlV3aCtjajBKL0lNa0orTWNCditDdFMxUWtvYjJBa1VHdXkz?=
 =?utf-8?B?eGNDbE5QZFI0ZkhHMkROVmVoS0Fya0RNdFc1WTNBUHN5elprb0NqRTFjc25a?=
 =?utf-8?B?WHdhdVFiM21BM3RXcjJzSzBacHZBMTdaNTZsSkZJb3QzZ3F5K1lBL09kVi9M?=
 =?utf-8?B?MVBYbjBKQWFVamdjMmpKbE5ITTVDNmZhN21UMkcybldaTnNUZmVPTDRHcTNT?=
 =?utf-8?Q?qagNqlGriF+MXSpsY8=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-80ceb.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 99098321-45b1-41b2-0415-08dc1b767cb4
X-MS-Exchange-CrossTenant-AuthSource: AS8P193MB1285.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2024 18:18:09.6200
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXP193MB2201

otherwise the synopsys_id value may be read out wrong,
because the GMAC_VERSION register might still be in reset
state, for at least 1 us after the reset is de-asserted.

Add a wait for 10 us before continuing to be on the safe side.

> From what have you got that delay value?

Just try and error, with very old linux versions and old gcc versions
the synopsys_id was read out correctly most of the time (but not always),
with recent linux versions and recnet gcc versions it was read out
wrongly most of the time, but again not always.
I don't have access to the VHDL code in question, so I cannot
tell why it takes so long to get the correct values, I also do not
have more than a few hardware samples, so I cannot tell how long
this timeout must be in worst case.
Experimentally I can tell that the register is read several times
as zero immediately after the reset is de-asserted, also adding several
no-ops is not enough, adding a printk is enough, also udelay(1) seems to
be enough but I tried that not very often, and I have not access to many
hardware samples to be 100% sure about the necessary delay.
And since the udelay here is only executed once per device instance,
it seems acceptable to delay the boot for 10 us.

BTW: my hardware's synopsys id is 0x37.

Fixes: c5e4ddbdfa11 ("net: stmmac: Add support for optional reset control")
Signed-off-by: Bernd Edlinger <bernd.edlinger@hotmail.de>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 3 +++
 1 file changed, 3 insertions(+)

v2: rebased to v6.7, retested and updated the commit message
as suggested Serge Semins review comment:
https://lore.kernel.org/lkml/b4mpa62b2juln47374x6xxnbozb7fcfgztrc5ounk4tvscs3wg@mixnvsoqno7j/
and retained Jiri Pirkos Reviwed-by from:
https://lore.kernel.org/lkml/ZT+Zq4j9iQj1+Xai@nanopsycho/

v3: addressed review comments.


Thanks
Bernd.

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index a0e46369ae15..b334eb16da23 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -7542,6 +7542,9 @@ int stmmac_dvr_probe(struct device *device,
 		dev_err(priv->device, "unable to bring out of ahb reset: %pe\n",
 			ERR_PTR(ret));
 
+	/* Wait a bit for the reset to take effect */
+	udelay(10);
+
 	/* Init MAC and get the capabilities */
 	ret = stmmac_hw_init(priv);
 	if (ret)
-- 
2.39.2

