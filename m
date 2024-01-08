Return-Path: <linux-kernel+bounces-19678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F8F78270C1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 15:09:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 689731C21C63
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 14:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81AC34654D;
	Mon,  8 Jan 2024 14:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nuvoton.onmicrosoft.com header.i=@nuvoton.onmicrosoft.com header.b="ss/M/dov"
X-Original-To: linux-kernel@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01rlnn2071.outbound.protection.outlook.com [40.95.53.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34B046B99;
	Mon,  8 Jan 2024 14:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=taln60.nuvoton.co.il
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qxr6f9mZ3jHGTRBG3OAjJHmrXvehkgkzPaIsIRbbRjQQkIZYsAoT0KQjn6jg4L91fTrNbIrKXsHwURCZMlnd+F178ckM8VDCvdmu6kSkmV+7keb3NhjxttpqlcmT1Afr2iCFYZ05IN2fnmW58nyutBfiW/T86OpY21G3R339DpXsAxofxdARkVNa6XEt9n6NszXgce/UrjYZ5UweXjfg421bF0W4iyKAXLmMk4dLampYWTnvgcyeG132a8aM20HiV75vfBwI2Om2PtF8rNyo1uoBqTPN0e80TY0LvYLfyX4fh3WTxJ8ozRwHeUTXQCx6VCYqin3B8Pj6kkKFZ+Iywg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RvUhDHYoU9YFrryA5rfo0pqlGp1xJAYI7AjUQCu11Bg=;
 b=BnKL4GKQTvdl1/nCRAgWumJypgYuOYwmr0CWTirx5I+6MvPEFZLRBzpRc57hxRAFHNVJh7pszvI0zDikdePFgObsUqZTOqEsJtZZBMwGhyyPD6tHtjcI7KwccolyuHoO+A8DfEhuTzYXws3lo353ST0s0NgnNqCV78sSt9DvZwSsLDA+i5b4I+Bd8/DhKn3vzEtwtRFzUojZhWECKT4hWQdhSVOeYCupF2VbUOXMcktZFDT09kGvnkbppueWTb/qCHUk9aL4Sn1zDTJeW+FjLan8KyB7sf2gnSd2r33WorIYsDTko2HNV4SUl5zUeyLCj8jglED40Yos+M+Nlcaz7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 211.75.126.7) smtp.rcpttodomain=baylibre.com
 smtp.mailfrom=taln60.nuvoton.co.il; dmarc=fail (p=none sp=quarantine pct=100)
 action=none header.from=gmail.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuvoton.onmicrosoft.com; s=selector2-nuvoton-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RvUhDHYoU9YFrryA5rfo0pqlGp1xJAYI7AjUQCu11Bg=;
 b=ss/M/dovphW62xwObeYhmSMx5In1RN9H/yF8ulhFqr6+UkA9Pvlsq0DeplCApglGHl+Y/DFrqx/n/TdjACKCNJ81zqln+8FOsNjJobZlKETw1Ohsr0GnyG3zn0QmpZZwouLa/ZQq02W6+Kgjx6j3zBRimSY4Yh8KdqRf0uW7xD8=
Received: from PS2PR02CA0091.apcprd02.prod.outlook.com (2603:1096:300:5c::31)
 by SEZPR03MB7677.apcprd03.prod.outlook.com (2603:1096:101:12e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Mon, 8 Jan
 2024 13:54:34 +0000
Received: from HK2PEPF00006FB5.apcprd02.prod.outlook.com
 (2603:1096:300:5c:cafe::9a) by PS2PR02CA0091.outlook.office365.com
 (2603:1096:300:5c::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21 via Frontend
 Transport; Mon, 8 Jan 2024 13:54:34 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 211.75.126.7)
 smtp.mailfrom=taln60.nuvoton.co.il; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=gmail.com;
Received-SPF: None (protection.outlook.com: taln60.nuvoton.co.il does not
 designate permitted sender hosts)
Received: from NTHCCAS01.nuvoton.com (211.75.126.7) by
 HK2PEPF00006FB5.mail.protection.outlook.com (10.167.8.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.12 via Frontend Transport; Mon, 8 Jan 2024 13:54:32 +0000
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 8 Jan
 2024 21:54:25 +0800
Received: from taln58.nuvoton.co.il (10.191.1.178) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Mon, 8 Jan 2024 21:54:25 +0800
Received: from taln60.nuvoton.co.il (taln60 [10.191.1.180])
	by taln58.nuvoton.co.il (Postfix) with ESMTP id AE8675F64D;
	Mon,  8 Jan 2024 15:54:23 +0200 (IST)
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
	id ADCB1DC0047; Mon,  8 Jan 2024 15:54:23 +0200 (IST)
From: Tomer Maimon <tmaimon77@gmail.com>
To: <mturquette@baylibre.com>, <sboyd@kernel.org>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <tali.perry1@gmail.com>,
	<joel@jms.id.au>, <venture@google.com>, <yuenn@google.com>,
	<benjaminfair@google.com>
CC: <openbmc@lists.ozlabs.org>, <linux-clk@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>, Tomer Maimon
	<tmaimon77@gmail.com>
Subject: [PATCH v22 7/8] arm64: dts: nuvoton: npcm8xx: replace reg with syscon property
Date: Mon, 8 Jan 2024 15:54:20 +0200
Message-ID: <20240108135421.684263-8-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240108135421.684263-1-tmaimon77@gmail.com>
References: <20240108135421.684263-1-tmaimon77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NotSetDelaration: True
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FB5:EE_|SEZPR03MB7677:EE_
X-MS-Office365-Filtering-Correlation-Id: fcca10f4-85dd-4995-0c10-08dc105157af
X-MS-Exchange-SenderADCheck: 2
X-MS-Exchange-AntiSpam-Relay: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ZGrcuAJYbMly5fREhdV5JI6z+75sb6myLZqRTcy3nHEHuU4WtboY0hxgZDGiIEeKG+bLJDIaVnyV9ooKH35SZBHo80eMIF6DRDyiIDlHfUmZySeRygO8Wo5BnSvUshBN1LYWRhbgpEv+ADMl4zTarsnfqVAnaZNG2cGGq7KIUa2XU7t0SbDEumQAb3KtGKAySwJ/v3IHKw8d1iyAtKRfilLvgA2nlzTkX4z3t4wC3uc91dviZ4/HrTTBOsQcmlfdXIrIPMMBDSjNL5eCSQEW8Kr8MuXUJAkS6c/RPSjfIacDD3D+RcUHTPfy01LkBJsEpPV0BQn+Qk+XimI5+g0+UYR058Sq6jmYvsZfFRkyEgZiS8nmsQa92depKKS0SUQn+PwfuylZD278i2HE8kEpGaVCshAS1lVWsriYaUQJljqEfFG+sK2IKodLYQhQKPdAfwPwcox2pheZGVJsSioreK9BtUwJ2M3GlHawf16+O2Mz2mIvZDbc+eSg5PGijaMFbIAF2cqiXu7uem7utp77S5zoxS3JxLtvWfA7RtHuThbf8zP9gBaktyE8D5CVrrDZuhHCJ7jz4J+E8hNlC6LpjGpq0sJlani9hJAoXATeyfJLQunQx/5+DEf94dYYCjhknc6bxRrQkNDt/1K0atkM+HIZ+w1BqSVpcsfPRhuTyf9COgYiYEB1idPKXFvaZqGZWv2bFmk1F9UV7bX7tOtGY+C8gNUlFb3SkA4SSXK0TTKtmMY7T4jYXml738QmxEV9JIu7oq94nc7Q3gKPYys41TTlpg+UZCnRfbfnzlsBOMHWeaytZGtTQ3AXPjRZLjvm/gLxRzgcCQOzhn9ZLyZn1LH1Flvtt3G00ic3jApJGnNQbINPmkoTvOCBDRausQ4P
X-Forefront-Antispam-Report:
	CIP:211.75.126.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS01.nuvoton.com;PTR:211-75-126-7.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(136003)(396003)(39860400002)(230922051799003)(48200799006)(61400799012)(451199024)(64100799003)(82310400011)(40470700004)(46966006)(41300700001)(47076005)(1076003)(83380400001)(336012)(42882007)(82202003)(73392003)(6266002)(40480700001)(40460700003)(2906002)(76482006)(70586007)(70206006)(42186006)(54906003)(110136005)(82740400003)(83170400001)(498600001)(2616005)(26005)(356005)(35950700001)(55446002)(81166007)(316002)(36756003)(5660300002)(7416002)(4744005)(4326008)(8936002)(8676002)(45356006)(32563001)(35450700002);DIR:OUT;SFP:1022;
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 13:54:32.8940
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fcca10f4-85dd-4995-0c10-08dc105157af
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[211.75.126.7];Helo=[NTHCCAS01.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource:
	HK2PEPF00006FB5.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB7677

Replace reg with syscon property since the clock registers handle the
reset registers as well.

Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
---
 arch/arm64/boot/dts/nuvoton/nuvoton-common-npcm8xx.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/nuvoton/nuvoton-common-npcm8xx.dtsi b/arch/arm64/boot/dts/nuvoton/nuvoton-common-npcm8xx.dtsi
index 7d5956e2c9f3..5cc0efdbb3c7 100644
--- a/arch/arm64/boot/dts/nuvoton/nuvoton-common-npcm8xx.dtsi
+++ b/arch/arm64/boot/dts/nuvoton/nuvoton-common-npcm8xx.dtsi
@@ -59,10 +59,10 @@ rstc: reset-controller@f0801000 {
 			nuvoton,sysgcr = <&gcr>;
 		};
 
-		clk: clock-controller@f0801000 {
+		clk: clock-controller {
 			compatible = "nuvoton,npcm845-clk";
 			#clock-cells = <1>;
-			reg = <0x0 0xf0801000 0x0 0x1000>;
+			nuvoton,sysclk = <&clk_rst>;
 			clocks = <&refclk>;
 			clock-names = "refclk";
 		};
-- 
2.34.1


