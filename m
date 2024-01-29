Return-Path: <linux-kernel+bounces-42317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9351083FF88
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 09:00:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F30C2824A1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 08:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A96CC524C7;
	Mon, 29 Jan 2024 08:00:23 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2072.outbound.protection.partner.outlook.cn [139.219.17.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF0F51C37
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 08:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706515223; cv=fail; b=ELUONKj0Euh7WPhwBjBVm83q5oxPOKYY9qvmd/rDROzpfX7wTwZcDho9/NSX0+bbgLZ9jNmy8n45s2RzQdaeD3DdChWhZa6dQeiwRQGS/mq65obMn4ylAXkJ4WuPQQ8oQj/8GBRl42o2eYM4oGzatmlyAG7bJBidG2HhHinfbXs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706515223; c=relaxed/simple;
	bh=2XIwfwU3ML1I8zQzWe1SmsA29kaPUMheUXiKfG6ErGw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=g44bOBF314Ddt65D0LZYWyGUPY1hesxI+aBxD1kXq3axY92YJLEuEA/T2yhAeavWC6juPmyc1UySk4c5uIOjm5d0/vhMsKz9n2iadXSsm0tx1+oSBaQdUx7PR3bBqZ+v8/813ZueJUnbc7jQyytbD2Ttxfg6cQois3Q2sdTAUzM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BDuYMJorbRW9nAmxpsnXuIl2ioCm/1v+79SGjZjvEw1/O/vX9riwgglxKjUanGiJJEaaxjuoWoeimuI380W6EEaVat1QGNSRlrz4+mR0UiGFE7T3r5SAIGVoaQO3+F8+dxDzGdrssAl5qhQkg7RnDz0zBhvfBId6XW4gZOR75DaKzwSFI9aqGtBpAaZ7shd1qkCY7huU2VEqQUJ5cimiLjQj8BWYR1l5uL0WRAX1Ku/ARgNhZ7RiQiVz/Qmnz6muuqMQVfg1ITDxqQdqLiPHd3COSw7VN5LWlwwZUdh61So7LuCSGpO71l3YEulHm76bI4S9TVicTt/lt/oHGJSXDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hQZtdNYJ56KwD1I/52FjiLmuaG1QJCswXe4mYk0EikI=;
 b=D7OlLbrjB9jBooNKhDqjnxr+kMnrP8egImtkhWiIpNMikH15g37sfm6QIQexk4wkg1pbIgL0jUjMKoc7J/bIuOFz59MkJYxj0Y5tJOOryoLn83Puw4HhPjxD+PZpznNlF6kAXYM9KPQryxDhVpuxtLB/RUoK1SjZZxQtgawbbbqCqGzdRipQBtnaBaJ00iVlGMH8c+YKkOy9/lXJXl+Md57KWfYVtb+rKJct8h1JA8/iLT5DBLKMeDnnl8hhMGhinzclw9X+zNrolzIe+TJIBBxB7QBzbo0Bo9ghSdBTKATOnxZ83U97cEQ2P8k3ki9DHlUm0TH0IzcD/xdv6C6LEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:f::16) by BJSPR01MB0545.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:f::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.31; Mon, 29 Jan
 2024 08:00:16 +0000
Received: from BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn
 ([fe80::3862:65b4:c857:c4a6]) by
 BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn ([fe80::3862:65b4:c857:c4a6%4])
 with mapi id 15.20.7228.029; Mon, 29 Jan 2024 08:00:16 +0000
From: Sia Jee Heng <jeeheng.sia@starfivetech.com>
To: linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Cc: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	sudeep.holla@arm.com,
	jeeheng.sia@starfivetech.com,
	robh@kernel.org,
	conor.dooley@microchip.com,
	suagrfillet@gmail.com
Subject: [RFC v1 1/2] riscv: cacheinfo: Remove unused parameter
Date: Sun, 28 Jan 2024 23:59:56 -0800
Message-Id: <20240129075957.116033-2-jeeheng.sia@starfivetech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240129075957.116033-1-jeeheng.sia@starfivetech.com>
References: <20240129075957.116033-1-jeeheng.sia@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0031.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:c::14) To BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:f::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BJSPR01MB0561:EE_|BJSPR01MB0545:EE_
X-MS-Office365-Filtering-Correlation-Id: 048c09d5-343a-4e89-2980-08dc20a0540f
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	JPcLGyvgzHMGte3IfQL86liL5UWCsgeyb7Ss2uuSoOn0TQRsi72EcmWlt8nIfYPF/EZTlKulIbQrMPxPNX8mlVywRppkdKKzpsN6BEVa8nD1oZ4Ur6HYGiXVt/PvLKcwgMac/JvesCvQzkJhsIS+9PKis75Cg2QOMM0rMoIKzewVYDeSa8iQuMZ00EH02dydskSi22udEDQY5ECKg0lL4tu2ou6Ar0IW2sV4L6zG2+ABwJqZ7jG87KaJw2hXrS4lNwKTcGYoGeVd0a6vYdQJYzmvdnEV9rHr4AU3fnPgaj7l6hC5vzSAd2SS6luEFmRhUDQvSKKgxAVigiKQtigNx90QYGYG8KyW7kzxB9Nut8ishKxZv3N+XfRwhedV8nCnS7se1tpuDVPWKW9kVtgracLGEcjiaWP0UxwjYQ7NY/PBLxqCs9wavJDsz6O9OTE0FbhfdV8usAwdAoRF8gT6fyAQSdERqqwxUgbGgXsk5E3qj98NYcrCIrHBBhBepcTPEewpcPFg8LeVoZiUjfPIwRGU7kahqMgyBKsmnxBnddN7Kzv11ab4uh/R37L1NfNy
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(346002)(396003)(39830400003)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(38350700005)(41320700001)(2616005)(2906002)(52116002)(5660300002)(6666004)(66946007)(66556008)(4326008)(26005)(1076003)(66476007)(8676002)(8936002)(38100700002)(83380400001)(508600001)(41300700001)(40180700001)(86362001)(40160700002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LeMV2ksVy0mvH81f4EqP/7VvjtRiwxkDXIgyn43qBle0jOqXLfzw6ospgnNy?=
 =?us-ascii?Q?D/ZZVzEH1GTw9rQSKLd2BfEdRZAzq+mMzkvD8Q0VLaWxmQOLLG6wAtJgeq5l?=
 =?us-ascii?Q?1x+XVL1fzCSXPo6Qn2MMu7JirEiaSOcBJa+HiwjiOef7p5L/4kPpXIFmpC9z?=
 =?us-ascii?Q?Ljph5etogTfiox5MRcmB9zPYt8ktY9eUGmN2UZ/Wmf+HctP0KYyufBoDWP6G?=
 =?us-ascii?Q?WEzmG7dD9LNjT7z+Uf4sB10+PAfZ/YEX612VtVjCsricx4XeQUWnJ8Jqybpz?=
 =?us-ascii?Q?Gdrvzf+Hg2RySq4gwLmaG1/VaCOi2QVp28nTCEhKYN8NLmJgNJ0fNugoaN7k?=
 =?us-ascii?Q?8QTx3KeGiAalIBMWKBxadRDgcVSfnP1xTgJvel9vG1R5PoS+M6/OWZ9Zzc6j?=
 =?us-ascii?Q?k24Wc1It6DhkJtFVU17Ikk2aP0hLq8RLmp7pwfJBUSOSH5Zn+HuNiC7K2unA?=
 =?us-ascii?Q?igDnpaE2PpU3tvJCJXdD1y6nlEouoyDgLbfssaeFFtIm0RRDMH5U9XhVLlYX?=
 =?us-ascii?Q?NQiuDpzCDJXBJYiCWgyhL1qYsnRBgA54eNtHa5dzCNwTGexAMgHk2QVmC467?=
 =?us-ascii?Q?Q0KUMNjIlL7MKWo2KUE9E9XbteehKfoP/PERLK94X1MXaYfWsBODnqqMMsWT?=
 =?us-ascii?Q?B1YduJIWhZQlhvtBBlRkDGInhq6pOsqb30NEhJh9+/5ryVQ9XG6HwcUocW8H?=
 =?us-ascii?Q?63eQG8lq+opqGMQDXmCyVTRC/jnklvXmYviCTEoi8SOhN5TIyC6RjkT9YRwG?=
 =?us-ascii?Q?SXgBKgncpejoTki015dlhoKs3/CAbyhR8rPRLYm4EFKpNU3Xgnu5mdzphx9f?=
 =?us-ascii?Q?NhmUaUGEToOTpp0siV2C7ZvhdS5qLV9tn022xgnOgUwJSKltKLdD7tmxZmmN?=
 =?us-ascii?Q?kNkE0cf1CSoOhcoK9hwh8w8Im+eQiEjeT/MfggBZwgW3300QBpGpyP8qRf84?=
 =?us-ascii?Q?iMm7t4hH6AEHLhI2pj4gQ69ZJ5mlpKeXEJi25sNThzHFyoUG+tCiiVCnoOmb?=
 =?us-ascii?Q?2SeuHFm6dbaZuUJinb5cg4akyzCMSftRNkrwEsHjKL4577QLKqi9tA+XaTfB?=
 =?us-ascii?Q?YCX1/FqkqmDDB4lNmkU1ElmDPIxcvKSVa8sVkdyZRJOsmOHcyPFMUYLPTryf?=
 =?us-ascii?Q?bymhDYObb2PnUQMv07/uGHtqGbQoB+bL7+8CERWYN8epnFRycY2n0THi15C8?=
 =?us-ascii?Q?1S1iYDkoqbUgVUGbQMCryn/U7tI4mIfuE1K3u1PnxuhZWTsKbOgqOzRjLx6u?=
 =?us-ascii?Q?7ChaUvch8tS64T6r0GEyIPFyy/4gdeCZ/NwmCgstz0x6juxtI1EMwXLE+sAx?=
 =?us-ascii?Q?8YHwm+B0vCH+gpBD2kIQD8FHjCNvmb2dhsOWmX21CczF5bm3HlnpQ5C85WxK?=
 =?us-ascii?Q?r+yYBPMD8JR40ZBquA2l7DoEcqf4jwc5e2G1HEAM8jfXfD6mk3FIDzZkSpyG?=
 =?us-ascii?Q?uVa4AB1iV/tgP3kzCaphpXVXavZP6/KK5skX2CClrjT9D9GoRfIokpMxihtF?=
 =?us-ascii?Q?VV0cxebwivot3HCz2IZ8oH4kaIidTV2Jj0T+8oKrbZ+H68X4va2yhhS+Pn4t?=
 =?us-ascii?Q?P1UPf4Hdnx9trx1Xy+lgKZqsGty/DHszs3W8hKDuNfInD9IVIW8PigEWDBwD?=
 =?us-ascii?Q?kg=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 048c09d5-343a-4e89-2980-08dc20a0540f
X-MS-Exchange-CrossTenant-AuthSource: BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 08:00:15.9754
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i4tzgcZhp0TEraiF5mDFOXtxYsmQ3v30xS5MMbJAMaUsLw8Wn2pMG/xuhVoVFCIEGMzGJVxyhjz0IOV4FumOeAzF6nSVJWQrXpD/RHQYQig=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BJSPR01MB0545

Removing the unused parameter in ci_leaf_init() to simplify the code.

Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
---
 arch/riscv/kernel/cacheinfo.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/riscv/kernel/cacheinfo.c b/arch/riscv/kernel/cacheinfo.c
index 09e9b88110d1..30a6878287ad 100644
--- a/arch/riscv/kernel/cacheinfo.c
+++ b/arch/riscv/kernel/cacheinfo.c
@@ -64,7 +64,6 @@ uintptr_t get_cache_geometry(u32 level, enum cache_type type)
 }
 
 static void ci_leaf_init(struct cacheinfo *this_leaf,
-			 struct device_node *node,
 			 enum cache_type type, unsigned int level)
 {
 	this_leaf->level = level;
@@ -80,11 +79,11 @@ int populate_cache_leaves(unsigned int cpu)
 	int levels = 1, level = 1;
 
 	if (of_property_read_bool(np, "cache-size"))
-		ci_leaf_init(this_leaf++, np, CACHE_TYPE_UNIFIED, level);
+		ci_leaf_init(this_leaf++, CACHE_TYPE_UNIFIED, level);
 	if (of_property_read_bool(np, "i-cache-size"))
-		ci_leaf_init(this_leaf++, np, CACHE_TYPE_INST, level);
+		ci_leaf_init(this_leaf++, CACHE_TYPE_INST, level);
 	if (of_property_read_bool(np, "d-cache-size"))
-		ci_leaf_init(this_leaf++, np, CACHE_TYPE_DATA, level);
+		ci_leaf_init(this_leaf++, CACHE_TYPE_DATA, level);
 
 	prev = np;
 	while ((np = of_find_next_cache_node(np))) {
@@ -97,11 +96,11 @@ int populate_cache_leaves(unsigned int cpu)
 		if (level <= levels)
 			break;
 		if (of_property_read_bool(np, "cache-size"))
-			ci_leaf_init(this_leaf++, np, CACHE_TYPE_UNIFIED, level);
+			ci_leaf_init(this_leaf++, CACHE_TYPE_UNIFIED, level);
 		if (of_property_read_bool(np, "i-cache-size"))
-			ci_leaf_init(this_leaf++, np, CACHE_TYPE_INST, level);
+			ci_leaf_init(this_leaf++, CACHE_TYPE_INST, level);
 		if (of_property_read_bool(np, "d-cache-size"))
-			ci_leaf_init(this_leaf++, np, CACHE_TYPE_DATA, level);
+			ci_leaf_init(this_leaf++, CACHE_TYPE_DATA, level);
 		levels = level;
 	}
 	of_node_put(np);
-- 
2.34.1


