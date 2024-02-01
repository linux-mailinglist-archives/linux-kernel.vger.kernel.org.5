Return-Path: <linux-kernel+bounces-47421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBD55844DB8
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 01:17:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C05F1C25A76
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 00:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33E7815E9B;
	Thu,  1 Feb 2024 00:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=PHYTEC.onmicrosoft.com header.i=@PHYTEC.onmicrosoft.com header.b="U3Jj3E7P"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2090.outbound.protection.outlook.com [40.107.102.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E915255;
	Thu,  1 Feb 2024 00:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706746541; cv=fail; b=Iq8uf1nSO90j0PZBWHYL+EpkP6VtQEol+cf8rtBysZjmuzf6m1G7jsKRgdCl5Uy63vmTkuTHjg1lrynFxsuHwIpMXSRMqToU1oad8UFreq+RTHnfdDWUd5IwcKfz8VP+sEiPqfagcHQ3rUwUNy6z/b7kqy0s0K7DcVQiNkxCzTk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706746541; c=relaxed/simple;
	bh=AQPLC1VA3KNnPSWxAr9O11E+oId/Ir/Fpv1lvxTdlkc=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=rZ1vlYv09o44eR8Lay9OYC7wr152KL+IM4U9SATy8xiomWYqcqat+yb7pkm2WQYgA7BqZW259+mR4E/zFaJzMMe3q7jvAH1zK/ppnhklIB2tNjlgk19qhe6NU0lCmlc3U4NyiIXveadwpfim7oKKG66INJRRvcwR4nFQnq31Z9M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.com; spf=pass smtp.mailfrom=phytec.com; dkim=pass (1024-bit key) header.d=PHYTEC.onmicrosoft.com header.i=@PHYTEC.onmicrosoft.com header.b=U3Jj3E7P; arc=fail smtp.client-ip=40.107.102.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W8tLx6zQTo99tw2HtRXIRpS7D/zQCkGZ8skIjrKixnjfP6YTRqfICyuaHYUjuNzECGrPeACzEzYHZ1SSVurv9WE52mobQhDhOv5dz70uTq6aMbD17na4hcDF1mY5Siz5xnJyiYU6ok1FZfcjcW4YR6GIphsg8DqhbYwQ8vO6qXnzrP+xcbuC1BVMLWQkp2zGhntCDrrh0Zc0vnWbgNb+DD9hpc3lSpagNvb5h/7FT0kyUHK1VGF31sJvDCym5MHWOuloMmMaNv+W56yhwOxgY6304/0PZ/bE8xnYobIXqOd+nCrWUJj/vZZOm2xtEvfmc2JBRS4k5WzssSlzQfOSUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DcYOy1WbK/XqkYlR0gCO9pZMvtaZcnKj7FiA5x0DbQU=;
 b=jhidEXtu4L7PhP9GhXYTBFelbwBkMBa44OVJVU+dQoN/lM31cCYeDhhsMccQXVzJpRCAn9FVRWM0TIVxAnQZJ9WouRoXPpAmTuyFYp+4VB6VbZPbZgdhGP5Yq19cNSv1/ezz7LnvxfR4xhIdV1R70aKZLvvJEoTZx+AXtY0kzpDG5mh5dU3Pxw+r5w2XjeSw5KOYs/FJsGllGw0594l+6oSMQoGhZJiWui9/B1xfXjg3ca/6CTcjwzB1h19h4tFKRmBwig6CsMR1EmuJksg0tYts9bZas4NDtJORl61Qgymx3UIaWSJft/XrEcCiLuPOR8B33w1mLDdt7VaiiS57Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.com; dmarc=pass action=none header.from=phytec.com;
 dkim=pass header.d=phytec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=PHYTEC.onmicrosoft.com; s=selector2-PHYTEC-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DcYOy1WbK/XqkYlR0gCO9pZMvtaZcnKj7FiA5x0DbQU=;
 b=U3Jj3E7P0kOphVxDg+rbqBhHXBpl+G0G432xhrforpnheMeYps8Gd/Qev+uMEZbBymzEJnkfp1N8MW3TxtYqB/E62L3aOrsUjrQ8mydGuoChjbVZsvbDqlUirVY94+v5JvezswMGc1iR/6H40yVW4lIP9VkyjomaBYWvQQJ3Owk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.com;
Received: from DM5PR2201MB1515.namprd22.prod.outlook.com (2603:10b6:4:36::18)
 by LV8PR22MB5648.namprd22.prod.outlook.com (2603:10b6:408:233::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.22; Thu, 1 Feb
 2024 00:15:34 +0000
Received: from DM5PR2201MB1515.namprd22.prod.outlook.com
 ([fe80::a312:f0d1:fc0f:ad42]) by DM5PR2201MB1515.namprd22.prod.outlook.com
 ([fe80::a312:f0d1:fc0f:ad42%5]) with mapi id 15.20.7228.029; Thu, 1 Feb 2024
 00:15:34 +0000
From: Nathan Morrisson <nmorrisson@phytec.com>
To: nm@ti.com,
	vigneshr@ti.com,
	kristo@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	upstream@lists.phytec.de
Subject: [PATCH] arm64: dts: ti: phycore-am64: Add ADC
Date: Wed, 31 Jan 2024 16:14:39 -0800
Message-Id: <20240201001439.3259450-1-nmorrisson@phytec.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0P221CA0025.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:11d::9) To DM5PR2201MB1515.namprd22.prod.outlook.com
 (2603:10b6:4:36::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR2201MB1515:EE_|LV8PR22MB5648:EE_
X-MS-Office365-Filtering-Correlation-Id: cb505680-8123-478f-43ca-08dc22bae8b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	LeITlQbRjG5c1bLT3J180JK7Bh8SN0C0trOnNp0xRnsm7glRbZX2dyYlTjiAuYu7cXAUxueJQtdRq60TxmcscAUkgdB3SeNOs9ny4zJ+TntGb8PoKGJLEALY4wdXrDr4JF53kPcv0YpWg8P37CCgo3YoGdyV2h+ogr9AaYn4tlR5Ax8UFYUMO7Hog6GXOUx/W3lIisoCOZKlxzGjFLSsfSvp6/cvMkXEX6VIATJZT0kRr53qLEPMYqU3Gux279o+i/R1VI/RZqv+uk8TMVj7blH/ujvfKqeIkNYg0l4mlqihZWKvYsTNZvqfHTxVXRwt4XBO9eTDGWj54tnCiLSboGZ22zMtXt5sxvy4gFQfIiKg7qGmzTQ2xu6zJm2Sw3aYSkcgHw6g6FgN0iiza5OblWkTVVtGScRgK8zFzAJyTOFwWqwZA0EwGZ7Vxe682ZwACogsLFdMpoKR7TPSiJI1oy7RjFDvsGeE/rCC6zkGYktVzhSzhhb9yeoO0Dnc+EM106DwdDz6RBOwWiv4JoWNNhQiBbT3Qd1g8N0fwCAK0wK++sEKJEaSgN3ktbRR65BWsYwhReEn/FkjwBM/ssR2TLFyIw35n7riCM9k1jnza1xIYht71G0EE9uOOFzo6I1D
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR2201MB1515.namprd22.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(136003)(376002)(39830400003)(396003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(41300700001)(2616005)(26005)(1076003)(6486002)(38350700005)(36756003)(478600001)(6506007)(6512007)(83380400001)(38100700002)(52116002)(316002)(66946007)(86362001)(4744005)(5660300002)(2906002)(66476007)(7416002)(66556008)(8936002)(4326008)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ed7K/jI7Br9DV/xt5wpsl1046S9XfqRo1NL2e+iClihlmHZA/47WKa0LvJtp?=
 =?us-ascii?Q?BWOf6DNRgh/Z9zP+fawG8+Cdoa7XhgpWR14YqbWvKEnYjJgc+kwvve/JTQfw?=
 =?us-ascii?Q?4hZ8XxroPV7S+B7CUnUDPvyVqlfKGlVtI9c2C8UWIO3KtH6788OPvV+YZpjy?=
 =?us-ascii?Q?P0z9j+0y26k1pL2JRvVhy6S/nPf/Yp3AvyoMcRiVV7e1qL6Fkv69EkhtyH8C?=
 =?us-ascii?Q?RW0K/WbaCOi6eMMvruBt6n36GBeADvTevRtKQgU8PFqH+3T/2JqplxeRpgDc?=
 =?us-ascii?Q?iA0bxSFZVmF+YalLRPIJ3wlARjMwIk1A9VF4xqbYIQWPa50cJPi75MMueVaw?=
 =?us-ascii?Q?4CWcEfX+9YKJauCCT+chLPGrbbMlrD3wN6FPpIWRoFH8qJgmWjFnikG+FvjM?=
 =?us-ascii?Q?tVfGWKqvE6augOZFHM41BD8SKDuBDbRYElxTrVxB8sL4cgu8LnLjL8mkADsH?=
 =?us-ascii?Q?sTLFfjTKULRXynlCaN8P2YtbITMoOLmS6XiK+UH0m1HADQYS0usSruZQFvMa?=
 =?us-ascii?Q?5CUeDovSdUKNwCcaF2CrHyeAYOAryLXbMkeC7G4FeplEzI6b294scsCVUMY7?=
 =?us-ascii?Q?dVspcDMGs8oGst2+sAersmi19bNTAkwei3wVB5KdxYXex0HzacI+wSN4phD+?=
 =?us-ascii?Q?0Sk8/QAf/3a2gu9ImWy0A1u8kGhOPDYIX0SW90P5rfh3XKWry5tMpBuxtD7h?=
 =?us-ascii?Q?d2jM5kyYeYtrYoW6fB4WRlWddgs2tVDor0wnC33U+z2mmIkkRC+S5dx3qnBZ?=
 =?us-ascii?Q?KEWDL4TAcPV7dVvaHUbM+OIyZY9HjEATbKNFNtGmX45iYj5SImpBXikVIcNI?=
 =?us-ascii?Q?fzN+FccQ6WewIEywfGPW+eRRMkaYK7KfrulatYDHtCach8xRSx27mSd6/Ena?=
 =?us-ascii?Q?e3l+qvNqDg2dkUNWcp6s0XcW7qZAa2P+3SnqGQBcRuOhPGS5I7N5livpHCyM?=
 =?us-ascii?Q?QGvE6Hmav+7cpVSXLEjwNJa8kDcjNLNUiNRhtHuxKKMOiOLrU1+rmfOKlgep?=
 =?us-ascii?Q?SptCv+Wg2y3dmlTcf6nxKi1EtWw6XqKkm8g/fxSgfw1f50rQYsvGbIyQFYab?=
 =?us-ascii?Q?p4xDV1pENiTWBou8e3cKmh8ukXVNmd0lp9byOzdjMrKR/r9L1lGPiZAoMMaC?=
 =?us-ascii?Q?WobTUP5bfiMXBOaSXuJ9zpPuk2VJYMGCoQQntS5p8YiYtMnD7xO8J4z9TtGd?=
 =?us-ascii?Q?YedtbgGYHZ2EM/w9nGhDLyiSre+i3uFp0lSspQsDG8CK/bnn85cs8zbuRnUN?=
 =?us-ascii?Q?1fXEKDuKblE2i0oV+1e3nCWmoaU+Gl14mMKlpQgNsk3znDFSPeQuu9LHqiJS?=
 =?us-ascii?Q?SkbJSawHxpXHnehETdeMh1mtcCJE2G8/SH1GwxNCpSUpFPaHFoGZt3eESSD/?=
 =?us-ascii?Q?0tTqNq4La5M5meqgma/8KKGK66oa0fuekmvrUpxz2o6ffPKZnJichWuthIc0?=
 =?us-ascii?Q?wEO0r3xccBaRfyx4YyKiFtu4IvDkCa/rHHPV+xqpj40IwNhsVEcrLAik6yWk?=
 =?us-ascii?Q?i3xUBLlR2/AUWrntEAsN8IOzSkWQ7V5ObxihGkcPPAdaOv937/If7d+bPsmh?=
 =?us-ascii?Q?g1tfcNS/cQ9XGFwcHNEa7/1ez4ZpvTNfijfvOWXZ?=
X-OriginatorOrg: phytec.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb505680-8123-478f-43ca-08dc22bae8b8
X-MS-Exchange-CrossTenant-AuthSource: DM5PR2201MB1515.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2024 00:15:34.6327
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bcab1a-5db0-4ee8-86f4-1533d0b4b5c7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fz5RPhI1xeJFFnnBPbVptYE7VS3Z3pteWduJXKUx66jVqDOAPwK8NCpX2IgueUWuRY5EHqKtd2RnBOf7RU8nJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR22MB5648

Add the ADC node to the phyCORE AM64x and enable the ADC.

Signed-off-by: Nathan Morrisson <nmorrisson@phytec.com>
---
 arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi b/arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi
index 1678e74cb750..cf1940c23bfe 100644
--- a/arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi
@@ -318,3 +318,10 @@ &sdhci0 {
 	disable-wp;
 	keep-power-in-suspend;
 };
+
+&tscadc0 {
+	status = "okay";
+	adc {
+		ti,adc-channels = <0 1 2 3 4 5 6 7>;
+	};
+};
-- 
2.25.1


