Return-Path: <linux-kernel+bounces-28754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE7908302A6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 10:46:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6A551C244BB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 09:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45B7314275;
	Wed, 17 Jan 2024 09:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=digi.com header.i=@digi.com header.b="UlN1riqJ"
Received: from outbound-ip24a.ess.barracuda.com (outbound-ip24a.ess.barracuda.com [209.222.82.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B57E14004;
	Wed, 17 Jan 2024 09:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.206
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705484807; cv=fail; b=IcTeu+h6+7JbB4iOOv6fIRh1byVMm5HH3EADyzLTgY08U2yjwudsvNLBMmvrDDzFj5JdcrZ0NrrFMUdfvWRElRk6iZn7AH1Bi6F/g2kF7hpoTZcGZF1gnUxKJwGXsnKHcRB5Ivyg4ehD065gLUIZYvzIOj25MJPO0u32FRUXjpA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705484807; c=relaxed/simple;
	bh=pXDBHRevEql/IeA5iatwabWIlzO7mvprZrqFBYbdktQ=;
	h=Received:ARC-Message-Signature:ARC-Authentication-Results:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BESS-ID:
	 X-BESS-VER:X-BESS-Apparent-Source-IP:X-BESS-Parts:
	 X-BESS-Outbound-Spam-Score:X-BESS-Outbound-Spam-Report:
	 X-BESS-Outbound-Spam-Status:X-BESS-BRTS-Status; b=ajaTLrPEh8JYclXOZcdsNdXiB69tUD7oTz5X21cvYhUH8bcuCHQboT9abtJq7bekstiRggjEDYJljtPQltlpYwCforPGBdgMGvqLNca+U8Ktc1WGrlv+0giC2wvnad0TWLcou3yyUeuCmjJW+Id07VU3mh85d6lQcJ6awKTtBqE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=digi.com; spf=pass smtp.mailfrom=digi.com; dkim=pass (2048-bit key) header.d=digi.com header.i=@digi.com header.b=UlN1riqJ; arc=fail smtp.client-ip=209.222.82.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=digi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digi.com
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168]) by mx-outbound14-151.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Wed, 17 Jan 2024 09:46:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d7FYbL3lJVi4HlmPcJhbM30QGhCwOaCNNtNvkVPuP6yBA2IOi2SnwArXbSVeGn8l6CjHHquyeJ2GC+rrvdPOcu4pXlkw4MJWeJGipPgP65wlyg3Zhes45wNfzyju1OCUB9Bw4s7iC4zfQs1s66dnJVeSLKA8f290rsjmBviwo/28w7faPrUj1D1qDDFFe1w4PZL79jR5lXZ3/jwxF1qYC63njsIb4+UjJUghKx2Ccfi5EZb50z1FgLVytQFqpNaYR1GqfCt6yTuuQ29RO8CVljurgacbd8hZCVFUJy+5tfrtzqFs/Aks5J2O+PCFBJkFG3p2QaWagND8Ga64MJNNrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U66kNV+nxEwPq6JzmRc7XVuiSHyrKSzuiysTkD3mYJ4=;
 b=hoQQuJOtwxcbrzMlPxU/iL28QWUOCvYSd6NAE8CqX/S/A2su0nvRrMCtE3AaqFZHS3ieGOxSt2hKAinbijTBnUTHJJPIv1qR3CwyOC+6MrAqrSvjnGpUXihzBdIcBQ+b69nEOtSAjy1VUhNBR0G8i/4zFPrWxJ/DVr6YcdyfKxl344HCskRq3uRLR/R+AzFKKnly3DAO3Y4/fe8wFJ56wyj5kjhV6FeaZpuisJFR/tIUJYX66JZqcrH8TkdL7aMu6RlUblc/NG97VzvV9lBbsOjeBFqJvayDRZFqNEMVhGr1uMJUngANHY9Zj5j9DC52X5LoebtHIKnev7AJTWQ4sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=digi.com; dmarc=pass action=none header.from=digi.com;
 dkim=pass header.d=digi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digi.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U66kNV+nxEwPq6JzmRc7XVuiSHyrKSzuiysTkD3mYJ4=;
 b=UlN1riqJklUJIrEff6QDTIyAykcMYCZuk+b24IK0gJvLu1a60ZOP5X6maAbLxw31h8Of34m+Dx5yxA5m8Dov5eLUfSuJ1d7w3qVbXVDRoHmVlokLtUqsDTyGAVFjb0fqTDViTrfpG7Hwu0qBctlYmcGnmDWmYrXyCDJUs05Cbu57GJZvKf+Tm1YwoW10pGMCubrk9yA2+k3JonJ7uAXLiJOmxPjExetzmlV9NLsiSZQ0dMfZAT7hGc+rEVxfMbJW3ymB76buNETjpeJ469omH7FBwXkpas3UGJbvOKpQVIvW2glFLrq5WS4z8+1nGZ608kpM45cKn3S1Bp9iEwUSiA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=digi.com;
Received: from BY5PR10MB4370.namprd10.prod.outlook.com (2603:10b6:a03:20b::19)
 by MN2PR10MB4317.namprd10.prod.outlook.com (2603:10b6:208:199::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.21; Wed, 17 Jan
 2024 09:45:42 +0000
Received: from BY5PR10MB4370.namprd10.prod.outlook.com
 ([fe80::283b:b934:7a82:c8c7]) by BY5PR10MB4370.namprd10.prod.outlook.com
 ([fe80::283b:b934:7a82:c8c7%7]) with mapi id 15.20.7181.026; Wed, 17 Jan 2024
 09:45:42 +0000
From: Hector Palacios <hector.palacios@digi.com>
To: linus.walleij@linaro.org,
	brgl@bgdev.pl,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org
Cc: andy@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	linux-imx@nxp.com,
	stefan@agner.ch,
	linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	hector.palacios@digi.com
Subject: [PATCH v4 3/3] arm64: dts: imx93: specify available 'ngpios' per GPIO port
Date: Wed, 17 Jan 2024 10:44:53 +0100
Message-Id: <20240117094453.100518-4-hector.palacios@digi.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240117094453.100518-1-hector.palacios@digi.com>
References: <20240117094453.100518-1-hector.palacios@digi.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR06CA0108.eurprd06.prod.outlook.com
 (2603:10a6:803:8c::37) To BY5PR10MB4370.namprd10.prod.outlook.com
 (2603:10b6:a03:20b::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4370:EE_|MN2PR10MB4317:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b83c18b-e93b-4d2b-409d-08dc174111d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+Dt17TonVqWXxdjjn7oE1kCNG6YoPub/omAwfCr0jpK5unb25DJnn5Nlt0DvFC7NvudaOFLiMy4g6ruhpMiaK7A775en0E3nRoJ/Rh3wrYYGQtaYTTuX8orM4YphiemQ8kZ9QVeJCiCKLr3mhel+czyhVdHaKqIHSiNqmyqCxNaFW/BTF0Tq+drx2h+6o8uXXPDk2msmUBU2Ak9IeKrYQRKP30FL+wBuUFDTn6GmPIZK3P5OodQ8r4+YpWJEY6xr9VtKnp1tpGzwSRAZoVwJiTAyHK7uqfwJUFVBx64tDBZqeHEaA72w38fiOIL/x0u8RN2XLqkZ4lCQTD64WXXtid7l1krp5snvqvU1Z7dMGM0k1GvuYtrihyzZnUeADTpW5hJJxZoUERyXPN6Orz4//50z4EPp0crsNBDgfq2VYhLehU97+ge8TU9B5KiwtSLArBItjA0Qrqvzpa4yP1n5MoH784EYBcJx2mSyoSkw4RRXuBxdr27r5UUq61387gtqUaCpErySVUuBCHM6JlUujm4KJVase8Ks6tdl3WryPIz6FDvhRWTiAdBWpcSAYH4ILmTqKVI0y+dk1eAkdRpW7U/YsrorfTii4YuC4sDiS3Bpwps1umnVZxvXNJekwkGQ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4370.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39850400004)(396003)(376002)(366004)(346002)(136003)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(6666004)(6506007)(478600001)(52116002)(6512007)(26005)(1076003)(107886003)(2616005)(38350700005)(38100700002)(36756003)(41300700001)(44832011)(2906002)(4326008)(83380400001)(5660300002)(316002)(66556008)(8676002)(7416002)(86362001)(66476007)(66946007)(8936002)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rcPau9fZBJk6iWcKc0vQLWJpVBnvJPfJf5I5k6jjtUb+X5RdLv0PC6EeFAW4?=
 =?us-ascii?Q?QjJTk7O/2ZvFz7oqnmoXmXZqoz87Sq7iclPqGs5NAGcceVypoBfKwsSu8kW5?=
 =?us-ascii?Q?mfvFZgO9RGPsP6SHsswwnlXZXP6S+CtXof9U/+9ht6zfOrkA6mG2d415okFu?=
 =?us-ascii?Q?E40CZPMpFsweBoNvN/gtb7E8/d6NfqVZBp3Hqy06eCFFE+Lciv3ujKIXFcxm?=
 =?us-ascii?Q?J+mQoP2v7z9XdYakHRGi1GvcaRmSRLpM+r4MK+ykzrnvczEnVcT+q5Vl41/b?=
 =?us-ascii?Q?kmFYo6fDszQ9g1L2iTdx19mFEDIknGlj0+gpM0JB99jQE3Ov8X4UfzW+2B8v?=
 =?us-ascii?Q?EQs0P0jzAr8cbfTOoZ7J0tuGjfKuejqWf2Wk2C2FuMuVOfU+Lpz20OD1v9oe?=
 =?us-ascii?Q?1nsnQHX+awZGNzBDfgIdMLwH7oAY1S9QY/ZgyLQj9c3tVGTWb2xAMSKPFPXD?=
 =?us-ascii?Q?+mNqf9H+NGJ3WcnZKcevO99EYurHBIqJD0Jmv1hfNlT9d45q5NveNyyeJcT4?=
 =?us-ascii?Q?6Zc338/+wVIKfeAeC9yI71YuKL9EgMBe02dpnhBguArLeJKKjmOT0bK+68ib?=
 =?us-ascii?Q?jj0dHew9NwbWOTrcU2ilNiqwTM9m06b+mjWsmC3u0M1gHPUsMvbkbTjpFnHK?=
 =?us-ascii?Q?F+fqUp8HL7L5ox0TKYEOvuiFrJO5Hz+fkxdn5Jb5H5zDsVBmODwiJ9BnmHdG?=
 =?us-ascii?Q?tCIZXHu8YnUvyclItaKOh1tDww2MkLdYA/wQOzBK0/RrmrnVP2z213Sifnf+?=
 =?us-ascii?Q?Pgu0+x5fKlmO2NNwkVIVNGQixb0FEKVTLYUnksAxQFEIllib44KqZt1C2BtD?=
 =?us-ascii?Q?N92XXHTGRQxAudmSa7t+R7MaewyIUV91V6XMtpFO8wX6glhWEdsfV8sYmLzG?=
 =?us-ascii?Q?JePYX0Oq9tVsapLVtLJdA/FORRbfFE0qLCLiQRQjiHUfyz4sYI+eQRQgoA1u?=
 =?us-ascii?Q?WhasW2TQvXwsRWlsugNinRBxPy+F8x1ifXV0Lwi4nhm4docTLgo3fyx3U8nX?=
 =?us-ascii?Q?hkCMhF0Lou7cL8NYSolfhgpqFfXC1ivs11W4HetuSA2uJrxRS9HYAuG1lUMi?=
 =?us-ascii?Q?vze0fsMAgKDe1tDQmtS5aP+Km3rDJ7QGfHpHLB630cE9M4J9MJ214HBpRq+Z?=
 =?us-ascii?Q?cUt2g1W0fWhq9RpEvyINoc/d89iff+utRrVr2a41a+XFe0V1Ck1VkVnrBRu+?=
 =?us-ascii?Q?mZXXP1c0AZRSW3VKAr5iFiQkCcn351zFSkMBJTSc8qAjehqP/OtsnBZuaugi?=
 =?us-ascii?Q?miAYrmV/iGXXC1Dh9lSNm+4MvLNxblUpS7WepWyq1w0eTPW8I3D+a0UBY/8i?=
 =?us-ascii?Q?/p3jZ2xVXUrCwKFFTUrt8t1X/l2uSJT1+Sww5j65uOsR+IWRs0NvvTcEtmFg?=
 =?us-ascii?Q?DLJxtWnhi8MrRumekIqFRLAP5bQ1r/6GcvTDkcJ6LblEdgvnGkZ6KrzSsm33?=
 =?us-ascii?Q?JM5qyfX/ikuoAnhyQToUSUsF70bVgmIzhriJAbiVsIBhqm7WJVRrQh7nWTBJ?=
 =?us-ascii?Q?NlAUX2lrNEIm4L30hDF09sdTJRr/N4inlwCCr2LG0whMsrgQ2/P4T2sW0RwB?=
 =?us-ascii?Q?qNIcwro7i/unNyJPOCgDvK7eOUK7PraJF9BB70UI?=
X-OriginatorOrg: digi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b83c18b-e93b-4d2b-409d-08dc174111d9
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4370.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2024 09:45:42.1955
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: abb4cdb7-1b7e-483e-a143-7ebfd1184b9e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5dZ7KHAE3Di7jvJlBihxPESgRpqdagq17uvigXo9KNnOdcKHRRQ0UvhQXyJjd0QetxaPJGqFOC3FN/2/dS+N5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4317
X-BESS-ID: 1705484730-103735-22813-55859-4
X-BESS-VER: 2019.1_20240103.1634
X-BESS-Apparent-Source-IP: 104.47.58.168
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoYmhsZAVgZQ0NQixdLI1DDR0M
	DS3NTQ0tQkNdk0EQQNE1MNTZItlGpjAVpic8VBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.253576 [from 
	cloudscan14-82.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS112744 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

According to NXP HRM for i.MX93, the following GPIO pins are available:
- GPIO1: 16 pins (0..15)
- GPIO2: 30 pins (0..29)
- GPIO3: 32 pins (0..31)
- GPIO4: 30 pins (0..29)

Signed-off-by: Hector Palacios <hector.palacios@digi.com>
---
 arch/arm64/boot/dts/freescale/imx93.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/dts/freescale/imx93.dtsi
index 34c0540276d1..7eb2cab7c749 100644
--- a/arch/arm64/boot/dts/freescale/imx93.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
@@ -970,6 +970,7 @@ gpio2: gpio@43810000 {
 				 <&clk IMX93_CLK_GPIO2_GATE>;
 			clock-names = "gpio", "port";
 			gpio-ranges = <&iomuxc 0 4 30>;
+			ngpios = <30>;
 		};
 
 		gpio3: gpio@43820000 {
@@ -986,6 +987,7 @@ gpio3: gpio@43820000 {
 			clock-names = "gpio", "port";
 			gpio-ranges = <&iomuxc 0 84 8>, <&iomuxc 8 66 18>,
 				      <&iomuxc 26 34 2>, <&iomuxc 28 0 4>;
+			ngpios = <32>;
 		};
 
 		gpio4: gpio@43830000 {
@@ -1001,6 +1003,7 @@ gpio4: gpio@43830000 {
 				 <&clk IMX93_CLK_GPIO4_GATE>;
 			clock-names = "gpio", "port";
 			gpio-ranges = <&iomuxc 0 38 28>, <&iomuxc 28 36 2>;
+			ngpios = <30>;
 		};
 
 		gpio1: gpio@47400000 {
@@ -1016,6 +1019,7 @@ gpio1: gpio@47400000 {
 				 <&clk IMX93_CLK_GPIO1_GATE>;
 			clock-names = "gpio", "port";
 			gpio-ranges = <&iomuxc 0 92 16>;
+			ngpios = <16>;
 		};
 
 		ocotp: efuse@47510000 {

