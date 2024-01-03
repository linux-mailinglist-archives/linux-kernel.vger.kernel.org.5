Return-Path: <linux-kernel+bounces-15251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 712F1822924
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 08:54:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9FAF1F230A7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 07:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9160418050;
	Wed,  3 Jan 2024 07:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b="Z7P3vMIX"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2043.outbound.protection.outlook.com [40.107.241.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77062182C6;
	Wed,  3 Jan 2024 07:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=theobroma-systems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oghgw8gOj6CfgxgwEet2leN3cDhx7/4EnUk+dyJ7sKNPi5Gkwl39G3PBWE4gRBbcUHn1cGSQdIhflqsz29PoXzENnVEpNZfC/w+pZux55c3MVu1hytf4Mp+3qr2WkHPZEtooHk+W/lHbBDHvosoQ1lEDYIV34AvLldhIE88tWTwlLioW3JS5gYkcO6DOVLdx5V8mnGfB2a7XpJD+V8imqHaodR40omv9EWi9+MwnaGJUciD6uFxmX1gTV7/rBsGe7w9QMDw8y+GWOHX5H+5q3NL4bCl8lg60H0Om+DtqZjAVQDiGG9/3lnKXViN34I38NqOmpOeCc0HGGAsqHOG/bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=99I0Vif/lKja3UIosHBYTgLnuGDSXzAlAADMMVcEdjE=;
 b=jmrfbMRnEZeYUuy8RdMWKKKXhRp6IeEuKern4uGELSPDHlLroF2+DslGpn9h3GwOQfg/WfhWETugb8mQjaXPu1bCC/uzPKW1ICewsplgnPzyeGQYpnt5uBSScAYSG/vELA9pVKobdEzN98mKDk4zUM2Y4wpIVR5i52DSNaQhIF0b6R9cX+jYvW4kxeAntKTSfHIQHx9B+QjqV22WxEsQI/JB/E10le1xX8eKgsFSsLF48tGN5lf2+tJrq4d0QsMeiNMFTich4d4q9Npc0k8EfTu3yycH8UFRHx/BlwxBxXPRSobRD/e8Rse4kJ52aludBaduKfJQ0c8DUqXFf9zJBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=99I0Vif/lKja3UIosHBYTgLnuGDSXzAlAADMMVcEdjE=;
 b=Z7P3vMIXMc9VyvORZPGcuirGuKguVXFawRWNpInBgNjPS7Kkpbc04x7lURzoukMGHEo3Nago9mU8r4uw6+1+FHrlqXzaYm1ujje4pf4k/0PIKd5Ri5x7JgBn/2/Y+kdZmX1vqfVQWhgvnlo0kgZxpV8BDXoGhCfc7fHgmCvhEJFaarDPeAWStOaFc19SVJaZvnqIrHcXAe5syCQh8jETeGyFvxAAoAxpcWIFe+auIr4Tq2omBIi4f3am4ExRSBaJz6cQYE4CHWHZy0HLQDcB7waeUYWSPI7c0DZOrrnmVYeBVP7SyrKe+y+CP/x/mc+8VhTA4+mI6OUF1XgPcpwaqA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from VI1PR04MB6013.eurprd04.prod.outlook.com (2603:10a6:803:cb::15)
 by DUZPR04MB9946.eurprd04.prod.outlook.com (2603:10a6:10:4db::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Wed, 3 Jan
 2024 07:54:01 +0000
Received: from VI1PR04MB6013.eurprd04.prod.outlook.com
 ([fe80::cc4a:6b4:812d:7c8a]) by VI1PR04MB6013.eurprd04.prod.outlook.com
 ([fe80::cc4a:6b4:812d:7c8a%5]) with mapi id 15.20.7159.013; Wed, 3 Jan 2024
 07:54:01 +0000
From: Iskander Amara <iskander.amara@theobroma-systems.com>
To: robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	heiko@sntech.de,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: quentin.schulz@theobroma-systems.com,
	Iskander Amara <iskander.amara@theobroma-systems.com>
Subject: [PATCH] arm64: dts: rockchip: add missing definition of pmu io domains 1 and 2 on ringneck
Date: Wed,  3 Jan 2024 08:53:52 +0100
Message-Id: <20240103075352.1009393-1-iskander.amara@theobroma-systems.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR07CA0136.eurprd07.prod.outlook.com
 (2603:10a6:802:16::23) To VI1PR04MB6013.eurprd04.prod.outlook.com
 (2603:10a6:803:cb::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB6013:EE_|DUZPR04MB9946:EE_
X-MS-Office365-Filtering-Correlation-Id: d0369bea-7df6-438c-4c58-08dc0c3125fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1le8VZEWeqmQx7+4VB4Gp3krl47OkLqn3mpK/PwuEK3Yj+3/BJYfjL3aorAB7dIptGxk3fkPgb0xXK7pEj24zRb3baOOWM5pKpNkkBLHrz4ZIypfzXtRemB78F4WZ7a0ADA4Cpy2X6dKaaApiy8PVO1jk9vAgdbbtDKYTxCqTPUlEnkZ1/rgZLJrxSQgUfDqhi8wXfLgi/FuGC6hNmyth/6hmD2wQDIC54VkjhnlXAz7fyTjmnDTbsGenqTXrHFHrE2VQvuqgTDadezUpd8/bKG7gcr1LE6gFEP++6KHOheyW+fVi6woI9fJo4w5rakrOsYTWABBfdU3V8f0Rzw53LCl7rGD8dq6UNAqEs673mBnxYRkzCfzaxi+Vs/KhVC7CQgmyOmFPO9bgSFskDa+G3rdDw65CjhT575OElCXlNCeeemOBN/7zCeZWEe4gnQZw9HVhuYltp9fnB1xv/WENq1RaP0RXTCOAK+mPoWSRCLT1Yd2YGgWaP0O33HAdqoYCQqTL63nh+i8PaDf/hTTMCeo9pGPylh88T17Y7tObXlbsi3Sj4D/cnqsvQFssSdX1BWLA4s6JyCGNQJ4279+xddxwJCWvE3cchprih0K3w5jy267b7XsaCCfIofrcdO1
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB6013.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39850400004)(396003)(346002)(136003)(366004)(376002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(5660300002)(4744005)(2906002)(38350700005)(41300700001)(44832011)(26005)(1076003)(107886003)(52116002)(6512007)(6666004)(6506007)(478600001)(2616005)(86362001)(38100700002)(316002)(4326008)(66946007)(66476007)(36756003)(66556008)(6486002)(8936002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4nXPnj2WHzUVAycEL3+WEwgYYEZl8AIyEB6DvJUr4uZZkqpivvmoHpWOr9jv?=
 =?us-ascii?Q?4KqqO8L6fN9RQzmHKIL37ObC4FiZLtWTNkMNFcQOvD8KDHj6q+Mj6zC74P80?=
 =?us-ascii?Q?H6OVizK0DndWRZEYcOYdxc/pk2zOmv7dLT4v/X8cseDA+dBs/8TrBxgAye7G?=
 =?us-ascii?Q?+5zS2Dhw85QIDSsbaEJs8NLgegiBdXHPSTSb15/KUOR0B7o0Xt1bkPmk/vKl?=
 =?us-ascii?Q?B24ZExtiWs6LkllSUKvN4FgmxGwt2g1aFTa+WvSpmVP9GuaqLPwaAFH48Ye4?=
 =?us-ascii?Q?1WEUppuqmdiAhW493aDRnC91dT1uUrv5ex/T3BFiQM08YH5yzzEsKhSDpbrm?=
 =?us-ascii?Q?OaeyIJqzDvCkz6rNV5EBiyLUqbBS55stOR8/4FwOJJAjTku63XXX0PNSVZGS?=
 =?us-ascii?Q?WN/9tmehn+kZIOg6i8ExDX5xBCYV8LaOUjab6ga+UCPcxaeaZlifr7m0UURx?=
 =?us-ascii?Q?dxQRhU+2EvitBJgrKJPl65HSkvQP1oWRwVIwcmKPJ8+iFgJewBkUUUFeJdnk?=
 =?us-ascii?Q?QL6oD9TvsWidtMAlmnJdnZ4aDtChZc+yr34b2Cu9jCKu/SWNWwXKVlkRDrH9?=
 =?us-ascii?Q?wr9/szUTTSOA7zRLIYDuT6iWbaRrcGrPgCy4WhuXGTdXIUFsx/lO0oOifQ5r?=
 =?us-ascii?Q?UJAEqYLIIM0zAPbR0Q+mkuMnlYu90JZIzAm58RV5t2SUZpJrMmzLACfbIZrF?=
 =?us-ascii?Q?y2ThXcn4w8SUT51Nr33Al6xs180aiZkJ54+UCry8+eqmu2HrZ1w7haI3SbVs?=
 =?us-ascii?Q?JR+5wB7MNedLGJxWhsPOb8hz7AyS2u2kENLSyETdnWI4EeOyS1WEDEFyoT/C?=
 =?us-ascii?Q?1kzLj4X/eIpULDECF/u/fiU0wAUE/KVy1Z58HWgrCQo6CRPqaknWMO/BiF6U?=
 =?us-ascii?Q?1wXmB3ELeU/4ahsKgbn77wgN7S7qMzyhq4H3XtFb60pbu/3+GPSFz0bCMmiv?=
 =?us-ascii?Q?4bj3rBJiNExSnTH8N4LBBZB0ohV6NFxudavxeSlucozmMGI/j0G8lchUXtsj?=
 =?us-ascii?Q?CKgvzjitp5Mx8hoRk8dkhabjgWfLvmS9hod1QN74Y6kKMlIpljJ6YfPJoxjj?=
 =?us-ascii?Q?wslU4shyb6GhoFEMEo0oFJ3HA+kSgwVSckw26DIdcaMEUXrG++SDqjePsqyG?=
 =?us-ascii?Q?c3zlryJauSGcoXMeXz9wL4wrVn5zzOO7miP/td4D90/X4qdad5LNqN202nbC?=
 =?us-ascii?Q?erUWuOYv5po3litr6y/HH4ck42KjUzxSBhQk/vilZXQuKpXGhW1j3ZS7n4cL?=
 =?us-ascii?Q?jJtJ5tM1foiuwYgm1bXSojNVFlZaEd60MuIzsDWd/bpoUOp18KR87mCcXsWv?=
 =?us-ascii?Q?HBlxPQwIsPh1uwsb28H6kY0VNXnISwTb7Zxz7RnX7PWwV796NLCWY1dbAJIm?=
 =?us-ascii?Q?aqImAK/kTyVuqQCYZLZ5sf51HzouIIgLfCRucK0f2MSkjOrDyKmDomRT3o6e?=
 =?us-ascii?Q?cSEwqtRHwWK3jduf34PSAe+xkELt+CwVwCCLeTNl/ms4x9I6QS5836l/lYOQ?=
 =?us-ascii?Q?2l5cTOVPAceHeAu/op2v/4T6nxHmFFziUGCUz8y7rfVuiTsZLn/2JQnuFpoo?=
 =?us-ascii?Q?pH0RDgods3a74rGci7iQ+0d5VjHB50jVNDviMdo1vgOM16oAO+7mzdzQMMaR?=
 =?us-ascii?Q?QvWH9EOQKqaYAcIBm10+8/g=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0369bea-7df6-438c-4c58-08dc0c3125fb
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB6013.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2024 07:54:01.1204
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ouSwGu+5YKmhggKFFu4P2Tv2uWjXYTRlgeqbIRfuHCTFj+BK+J8z2d/AgoGtT/WXuWmjdfAAsm9HLVYvvOoEuVXeXq52HoWV0hvtVmagIwj2aAvakQ+osLKeykEPfKIY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9946

Two pmuio domains on ringneck are not defined:
	1- PMUIO1: supplied by vcc_3v3 regulator(PMIC RK809)
	2- PMUIO2: supplied by vcc_3v3 regulator(PMIC RK809)

The reason why no functional effect was observed is because of that
the above mentionned PMUIO domains were supplied by a regulator
which is always on.

So let's add their definition in the dtsi.

Signed-off-by: Iskander Amara <iskander.amara@theobroma-systems.com>
---
 arch/arm64/boot/dts/rockchip/px30-ringneck.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/px30-ringneck.dtsi b/arch/arm64/boot/dts/rockchip/px30-ringneck.dtsi
index 12397755830b..821824a6668e 100644
--- a/arch/arm64/boot/dts/rockchip/px30-ringneck.dtsi
+++ b/arch/arm64/boot/dts/rockchip/px30-ringneck.dtsi
@@ -347,6 +347,12 @@ pmic_int: pmic-int {
 	};
 };
 
+&pmu_io_domains {
+		pmuio1-supply = <&vcc_3v3>;
+		pmuio2-supply = <&vcc_3v3>;
+		status = "okay";
+};
+
 &saradc {
 	vref-supply = <&vcc_1v8>;
 	status = "okay";
-- 
2.34.1


