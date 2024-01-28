Return-Path: <linux-kernel+bounces-41641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 929E583F5BA
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 15:07:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D14A1F22B9E
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 14:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9782F241E7;
	Sun, 28 Jan 2024 14:07:01 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05olkn2040.outbound.protection.outlook.com [40.92.91.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7FB23748;
	Sun, 28 Jan 2024 14:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.91.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706450821; cv=fail; b=MM/h+6Y9c1h1THKJ904NoMUfX0+G6fQmEXUCdKDNsNx0KXAgltuZJXs+lOUsf087/O8N8hH769wwGhGrxdwMHLgcyP5yAI2CBGqBeGZJrRdNwG4nuxs3NWZIkh0XeBZ6hkB7lHw7EJ/A1/Gu8zLyHhNj5GwCV+oZ9zyMU5OlW3M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706450821; c=relaxed/simple;
	bh=Pwy3+XnTJFvvlQdROLru3bEVpmPaK+4+cIH3qbGxrWk=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=XVqUhHHuDAqIeKLNsmjdoiEjSbqQrOHXtiObMcO18prziQns+Z6PZsboJDlOSJ3MUhlbZFwx4ubuvc/QlhxYgieMP4oWwk+8PKrvV1GVUbtE65geN6rCz81hJuemnP9H5wkGE3oHDDQOTsmoKQaEe7KYJdfWwHbylfCSEyNaaiY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.it; spf=pass smtp.mailfrom=outlook.it; arc=fail smtp.client-ip=40.92.91.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.it
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JP3/FRp0CMeL8eu8lz8vGE2qBtSY25rfuAkYOaVb+N+9P0USvsATA1gaToJl2zohTO4kwVuaHSt8zwoyhYm9r2yDnn4tTUPck6w70YnjqL6WTT432eeFuicEd+o+4iKPOI/Xoo02J8DFbWWmuaZW1NFcKT9IGC2NhzfCAFHfxYz96XbNuX8FuBLDX5Nhy4tUJ9gJOu8IfyWKL2yFDlDXpSbNRmQO0ltRewV+0LKrf8JmMaHebHBcHOkDk9tU6wE6tdfBA5D0kDYuQm2kFABRnthQhVhm+/84dllTbrnN8LL0eHsWuhyo8HKhioLI5XzWsySFaGaMSLn15yKWYcfCog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q2sEBf9r0iv6Sdjil6/yna65vQCMIk1zB8mnfFh3XNY=;
 b=Wu/ysNzX6Qh7cZwZ5qhcLYVNF2vp4WJE5K1zE5TlAC2DuTqtoJNN/pusW5z9Z/ls3EbwodzvxWE8NOKK4liRXwYH31w8HEK1jq/HJDoZCJEmh1EQvOuGfpIVSGyI6BlNubKDeNuNlz2jo6s72tygFtaMwNU3zF/NQQEB3zrCkdJlk6boQDrVFpZubz8J9TRsIiT/Cbe6F9//xOgavDcdZHUFoz18V30I1xgNIkZccdsEmqSRIP2/YOdBnGwZoHXKMmc6ENnNv2cE081vh/cZh8cU5FOyoxgf07F99U+DeNXra3lNNSRunyeDdZyk8k9vDsu12D/l06iS5vpxKW4Jng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from AS1PR03MB8189.eurprd03.prod.outlook.com (2603:10a6:20b:47d::10)
 by AM9PR03MB7742.eurprd03.prod.outlook.com (2603:10a6:20b:3dc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Sun, 28 Jan
 2024 14:06:56 +0000
Received: from AS1PR03MB8189.eurprd03.prod.outlook.com
 ([fe80::ffb3:3ff8:6ea9:52b5]) by AS1PR03MB8189.eurprd03.prod.outlook.com
 ([fe80::ffb3:3ff8:6ea9:52b5%5]) with mapi id 15.20.7202.035; Sun, 28 Jan 2024
 14:06:50 +0000
From: Sergio Palumbo <palumbo.ser@outlook.it>
To: Russell King <linux@armlinux.org.uk>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: sfp: add quirk for OEM DFP-34X-2C2 GPON ONU SFP
Date: Sun, 28 Jan 2024 15:06:33 +0100
Message-ID:
 <AS1PR03MB8189AD85CEB6E139F27307D3827F2@AS1PR03MB8189.eurprd03.prod.outlook.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [G3Q7lYVxeWH//9HFfIlTk0Lwc/MFRxg+]
X-ClientProxiedBy: MRXP264CA0041.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:14::29) To AS1PR03MB8189.eurprd03.prod.outlook.com
 (2603:10a6:20b:47d::10)
X-Microsoft-Original-Message-ID:
 <20240128140633.8753-1-palumbo.ser@outlook.it>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS1PR03MB8189:EE_|AM9PR03MB7742:EE_
X-MS-Office365-Filtering-Correlation-Id: 580f6c84-c2cf-4a8f-cf06-08dc200a5f61
X-MS-Exchange-SLBlob-MailProps:
	Mga27o8vReGfIc1VICO0dmEM3GFX/n+pKij/noRrFm5eFC94ZWVs7OYPy+eLKYealSEu5Rzm/dABZiPST74dh61UzERh93w7y3bX71sJMMvxmLxDTGRXcdXyLLRhX5FTzvUTBEy0XMEl+WRF0RFeXdng11PrDpAU3h0WkRLchHNz+NzbO0t5iRK2OlX0HTxYmNXuOmXs9RQ0G2dlpw/ASOPdjCY3syvBlN+N/RyjCYMbYkr22y03yuvPdih0kV4zdYBub4OnCOex2ot0OvlelHLG2C5n97igNHkuldirVOOFkvTCBSEOlVD8zlChjRT5DPZuN8hPJTonZE8HWcPJybWBPGM5wdxXjuCpJLfqTOAGwZlAdoljWqAmjyB8Xjv9xujboEmO1f3FYEaxmIRRQXsnty+UUeV0/LRRS+WsLoZvo7In+b7GjVNErw3lRMiQTWx7caHpB40l8Z5sXphFfX26ebEW/7tpQzWkapsKeElk32+7y1DNr/oVU5uQuOcXvAHtKywMQ+t5Afachk4u+bgzw9tq+ilBWr8XSUxAxuWvJj8TnqPBuzzVY7SiqCThRrNzAnmQ5m83EuZ7H0njpS7+6gMGke7oScoBf7WHAo6yiZPcnOMXZ7+5fT5nLym2xizIAvNNqlGt3D1wh0ELPqx2KddEBeBDrLz/DljpnGDve25UJdnQBxO4SFhuwaAev8tAKMO1JDQGC5HflGCVfNI2GU7sV53/4vfBSub8sGdK8KNXq/H2NBQlCfYO8tfwZMFD2kRa5dZseUqKlCg1HT11K0BD+bUqFhmRS855vLTqA3iUdJFSzQ==
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ak8hi434v3xz7Tn78UWuVLpWQsrwIQANht/5qTK+zamYtdUbDDq+mOvjgQQtBTnMS8EqlSYTa0GV3dINEg+HStzsSmTml3FOFOssmW42e0fZUKdz1r6st8nJZREmMs0PgSTtTeKCUi5g0XkNZz+GVT5WQ4fnuwkW/NnZ76XNl/4ieum9w0jFAWM87EhSAUcZSHeFMU8nTFzVNJVGYRXI4ZhDlHvhEtl2mPYI+XcpE98uYzF7GkvZzQBP5GFn2/QDLrf5vdF5LZ70BEXSyNm4n5KVNaKJxP+umUY2IgA+O6KnTCgVHLmk8JRSVoEKgAJ/m5QSM9IlTNqlmprq4gUpoxqgSWqaJZLFUqhzGkfdD+bw34xZNaZWw/xUTjUp27IfJZS0LXV2nT4HPRHnkgEtJjY3QOS5Dfhqcw6riPi0YVDcULNwFbGt2gERWvsTTsk8N5mbnyHCQcY2Q56ytDcYhBnwbSs6WOJnLLgMDnTOJbAcyoLat7HJWYWri8BfKWD4954Ap+h+HOp7+qPyEFrBsp/n30cN1seTN6aQZd7+0lyRUoKoGscjvSBIcJ6cS2R+Tx+13r6sJXDe4M4h0m+AdtQVlFBT1nwkhFQIfdL05cA=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KbDQ63AFflgVaYndOCD6qC/+10O+kcLDLAzqVP45YostgMlitnAZJIcaml/d?=
 =?us-ascii?Q?QWiVrj2BI1g5Bo8sp/46AiO3nJChH16AoNSOHC/vvNOIbaPS+x77oGMmgvIU?=
 =?us-ascii?Q?PiBkzzNWd8yvov5hBruWTIM4LAKgvLqmzlNV7x+nlgra9Gbp6te17LGkEznT?=
 =?us-ascii?Q?qzaeWYfKucwDCpizVM7jxrPnmNqCffeTUW5oyLiQU6hCHCnd6vCF5g6vosFv?=
 =?us-ascii?Q?owqK5VgjDhbtBJUi7Cd6vo1Qo55dF6lEZ3GI0ikq5aWvDeo3ImE0/SriymTp?=
 =?us-ascii?Q?F08t2sN8SjMp2UPY4bVp7BEOxOovpaWMQ8c+m2nzeFAqxbRV36OhREfog7T0?=
 =?us-ascii?Q?FrLbDKDC7jzL5kUXcMfpsoUNvwq8QNv0COH/FO1mz7h9H9rvswHiMXqNL5ta?=
 =?us-ascii?Q?G7PG4zVZpxpbtwgVWg6tAhdMNZYJlsZB1XfgG51H95AZRPVcyfXd4d7IunqD?=
 =?us-ascii?Q?1jUK5M8qobQyQUop9jir60jYfCUSecqi8XRHEE/BmhK4n5ZqiSmvfpUlS2kz?=
 =?us-ascii?Q?Dp5dwYghKvy1OhLyqt7l6wxIOd89yHPf1xxZT8wY+1jh81H1Ln2vKNjnAtjJ?=
 =?us-ascii?Q?a6Bf3s10PSXWKSXsuiwLzc1K/GmiXng3Ho8V1fRFGULulXokqBdI7ftjtDEv?=
 =?us-ascii?Q?07PtaTexmf5XkxWyiGIDcsa7+G+10evdhutBZwKTXwdY3oUyva0hneBaT+6x?=
 =?us-ascii?Q?Bv3ACSIP4kL8rsgcPNu9SeNlfiqCM82XpN92rsK+E4R93RFLQqCidjSkqBR+?=
 =?us-ascii?Q?6v6XndP5QsTU2VzyBb9u3TSGZiItUxWutVHNrKqQ0/l/Mqa6p66/O1G+eNsj?=
 =?us-ascii?Q?uKEhXawKY75o3I8EII/bYSBpHJxMkPgtZP0UNL6WWYaH1pzu4zmiWw+mFbr1?=
 =?us-ascii?Q?p5ZXMGHKqX/Ts2DpQ5irNqWDTRdgTmOeXqaFROW+/Slhj0OICXKq57nYxmDI?=
 =?us-ascii?Q?8YQY7ZfFWggIW7ol+WOX4YQP4Z/n6VLj4uLXZc5N3y1uFmiGV5Rd7+hitLDp?=
 =?us-ascii?Q?Y6uyBsojABSsE5vgIw/fStjc/h5Lcq+gteiEJY2dI4oVlVpstrJgEM04nK/W?=
 =?us-ascii?Q?mkm5eNCT+3KPz1wrAgXZOIYgK1/YLkvT7qrV6Ja5jpfNe2r4FhMFrGo4lgef?=
 =?us-ascii?Q?32X4Q9/T0KktmTOeqT6iCocoe8WypKY6kPdLKFuJCXXZJPXjw56P4GnaO4Jb?=
 =?us-ascii?Q?pETr2Z1U+8GvEn0j/IKqyIerNHDOAvjZF9s9vJegpvuwwCq6GUhy9o7FHAE?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-76d7b.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 580f6c84-c2cf-4a8f-cf06-08dc200a5f61
X-MS-Exchange-CrossTenant-AuthSource: AS1PR03MB8189.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2024 14:06:50.3777
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR03MB7742

     DFP-34X-2C2 is a GPON spf module working at both 1000baseX
     and 2500baseX.
     Setting the module to LAN_SDS_MODE=6 the module is working
     at 2500baseX with auto negotiation see at
     https://hack-gpon.org/ont-odi-realtek-dfp-34x-2c2/
     Unfortunatly the module's PHY is accessible at 1000baseX only.
     ethtool returning:
     Supported ports: [ Fibre ]
     Supported link modes: 1000baseX/Full

     After applying the quirk:
     Supported ports: [ Fibre ]
     Supported link modes: 1000baseX/Full
                           2500baseX/Full
     Tested on BANANA PI R3 in OpenWRT v 23.05.2 Kernel 5.15.137
     Tested on sfp to ethernet Media Converter.
     Autonegotiating 1000baseX or 2500baseX according to the
     connected host speed.

     This module is existing in 2 versions:
     Vendor = "ODI"
     Vendor = "OEM"
     This is the patch for vendor "OEM"

     Patch has been inserted keeping the list in alphabetical order
     first by vendor first and then by part string.

Signed-off-by: Sergio Palumbo <palumbo.ser@outlook.it>
---
 drivers/net/phy/sfp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
index f75c9eb3958e..3c0028a4af92 100644
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -502,6 +502,9 @@ static const struct sfp_quirk sfp_quirks[] = {
 	SFP_QUIRK_F("Walsun", "HXSX-ATRC-1", sfp_fixup_fs_10gt),
 	SFP_QUIRK_F("Walsun", "HXSX-ATRI-1", sfp_fixup_fs_10gt),
 
+	// OEM DFP-34X-2C2 GPON ONU support 2500base-X
+	SFP_QUIRK_M("OEM", "DFP-34X-2C2", sfp_quirk_2500basex),
+
 	SFP_QUIRK_F("OEM", "SFP-10G-T", sfp_fixup_rollball_cc),
 	SFP_QUIRK_M("OEM", "SFP-2.5G-T", sfp_quirk_oem_2_5g),
 	SFP_QUIRK_F("OEM", "RTSFP-10", sfp_fixup_rollball_cc),
-- 
2.34.1


