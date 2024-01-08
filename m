Return-Path: <linux-kernel+bounces-20042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A728827891
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 20:29:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D9001C220AF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 19:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FFFE4652A;
	Mon,  8 Jan 2024 19:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nuvoton.onmicrosoft.com header.i=@nuvoton.onmicrosoft.com header.b="JQbipxoY"
X-Original-To: linux-kernel@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01rlnn2079.outbound.protection.outlook.com [40.95.110.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 157FD45C0D;
	Mon,  8 Jan 2024 19:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=taln60.nuvoton.co.il
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qw6bBZNRZzilX0z6YnGHzMXt6MG0tebgGVdwsU/piOWDg7HhQzxLaruLxqQQs+2uOK2rw6X7TFTZHw30rmynai2pjapsKbfZv43FnxtaHlZE8uT+SVgyua1h4C0sboooVgNI1Ti5VNaG9b2iD1Kh3dMozis2AAwHJU+mAsbO3SZiglU/xNUmoFYFmymSOdIAIiGCucr5ETWppbRG1lPH+KoMOgXJNPzj/cmDKATanhaYfDcSEUYLjZn2P/LpAxnp6LAEmEWGUy2mzFQs46FQneakR/6/hxp2QJmEhtzv7qpagW6kNp2LRNTX2wahsnCn/5rngQTNgL/1ljz3CVGB0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v2D468flie3JNhJ+N5NYFfoJqr/veU8Xh/sDR5huZgc=;
 b=a/QkMYRDym6RP/+CxQO9Gm8wrTINQr3C4T0+RZvLao3flxcqFlmTFKJOIYL0PQt33fxpontcbDuNJL8Haw3OxWVT7d/mEDk/YBIXsB6fwYsJUtbcijTGud5MsggH5woqDkh6eDGFHVv1MqoHZYQ+h98Api8WHPWAtpxEJqM+IhyXRKeUN9jfooEuy5gBmzYs4IMwqXHHT8CDnANBuv3wrZfWIkDlo+I0mONO0fGUOKLomSqWlf1PTl87u10hmAEgfDzP0li6yFNPxHfpmBF5y3jTvMlDyymOdTK/RtME5Ttn12TXkr26UuVAw6yr01uheHVNe7ab4FYzyDvAPy7fbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 211.75.126.7) smtp.rcpttodomain=baylibre.com
 smtp.mailfrom=taln60.nuvoton.co.il; dmarc=fail (p=none sp=quarantine pct=100)
 action=none header.from=gmail.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuvoton.onmicrosoft.com; s=selector2-nuvoton-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v2D468flie3JNhJ+N5NYFfoJqr/veU8Xh/sDR5huZgc=;
 b=JQbipxoYbAo+FY9POlT2KWZc0MwCO8reoFohLhwDev3Ww9KeEH/Mz6cbpGElQf/peIvHQGuanUuiOPMm/ByJv0JFqAUwl4OyDLAa4Hf/uJfAHXSX8/uJ9M7DvdLimpwmsmGYLe/UkrvzE6Ld61RlfTb+t/2Tv319o1cP5KLoxrE=
Received: from PS2PR02CA0082.apcprd02.prod.outlook.com (2603:1096:300:5c::22)
 by SEYPR03MB7681.apcprd03.prod.outlook.com (2603:1096:101:13d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21; Mon, 8 Jan
 2024 13:54:35 +0000
Received: from HK2PEPF00006FB5.apcprd02.prod.outlook.com
 (2603:1096:300:5c:cafe::b7) by PS2PR02CA0082.outlook.office365.com
 (2603:1096:300:5c::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21 via Frontend
 Transport; Mon, 8 Jan 2024 13:54:35 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 211.75.126.7)
 smtp.mailfrom=taln60.nuvoton.co.il; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=gmail.com;
Received-SPF: None (protection.outlook.com: taln60.nuvoton.co.il does not
 designate permitted sender hosts)
Received: from NTHCCAS01.nuvoton.com (211.75.126.7) by
 HK2PEPF00006FB5.mail.protection.outlook.com (10.167.8.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.12 via Frontend Transport; Mon, 8 Jan 2024 13:54:34 +0000
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 8 Jan
 2024 21:54:25 +0800
Received: from taln58.nuvoton.co.il (10.191.1.178) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Mon, 8 Jan 2024 21:54:25 +0800
Received: from taln60.nuvoton.co.il (taln60 [10.191.1.180])
	by taln58.nuvoton.co.il (Postfix) with ESMTP id 97D175F64B;
	Mon,  8 Jan 2024 15:54:23 +0200 (IST)
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
	id 97224DC0047; Mon,  8 Jan 2024 15:54:23 +0200 (IST)
From: Tomer Maimon <tmaimon77@gmail.com>
To: <mturquette@baylibre.com>, <sboyd@kernel.org>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <tali.perry1@gmail.com>,
	<joel@jms.id.au>, <venture@google.com>, <yuenn@google.com>,
	<benjaminfair@google.com>
CC: <openbmc@lists.ozlabs.org>, <linux-clk@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>, Tomer Maimon
	<tmaimon77@gmail.com>
Subject: [PATCH v22 5/8] arm64: dts: nuvoton: npcm8xx: add clock reset syscon node
Date: Mon, 8 Jan 2024 15:54:18 +0200
Message-ID: <20240108135421.684263-6-tmaimon77@gmail.com>
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
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FB5:EE_|SEYPR03MB7681:EE_
X-MS-Office365-Filtering-Correlation-Id: 84125afc-d926-4982-9c15-08dc105158e2
X-MS-Exchange-SenderADCheck: 2
X-MS-Exchange-AntiSpam-Relay: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	30A8GdJ4Y3sRrJQp8gWd8ptywWyvFxh6Y+C2Y3t4XrIGEwIf/ZfTlODxPIk0x6u9AR8/aAf2XxzmBmh4y/Lg8Mx+cM1+rMO00i9sH5BxiVnWMXLdu/wDzmQhM2axWVxhgD+lCnstKhPuz45nyEQ4RwYEYme6+IqnOUkkTN3RGO3QQ4u7hsWsswzubgpB3cWhvF8Nf059ty/uAyH4grJaw477S2f6NXQcPe3BN2eAy8b4FugySAYMKM20CQX03ZGxr2NC5/NdBM5cYtxQey0xRE6/sRzHKDYycdSo0Sa7btrqglu8j5TmlXOXE46spAnL279xKOfBbgZZFUGyLQzqvvDDEsOgCyY7j9UA6xyOw4zV/WOq2ATI/lHOLeIGv4IZTt2U+XqH0UIV3MfealxTnniPYX3rthoImeJEeNEmv9s6YWh6DwRnXHBS5ChfrKwGqQPu23aWVvnvhTKQi9/W+eXbcbvUNKKK8eLhMxxwL4QzjxasYV7uSX/ppsVKzOVMUtOxAT7ihtKVJ+a/Nam6yYQPRpa5G0kjEVm08spYPWIkby2IeJvj1Ibggypfb+ebD1Y0321C7UDvrk/nGkn14RWEcAgFF2lW82oTBKDU5ckpApZ48ZVBhELIe0qHJI5i4Dl/S9FmOyPcz+7WNYaziIaHjiA3vurpg07FW6XNrFMVjjKfJmDbYni8qUgiCo1TpdcRZvc7kQB42uGOXXg18cDmCcB8JGUFXN5VEU/8WKxJZBssv0V509p8Drjm+Z0DBH0tBoHVqhoe6lAsboi4qpGIcHKJyLPZKEnzemlLdBq5i0hA7FPlogGL83xk0tkbtl6malWQ4GmGuQ34sIdEZ7cdWkMuEhBiph5llwlwFCh3Kf61kkjyMbRo4wKudwlx
X-Forefront-Antispam-Report:
	CIP:211.75.126.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS01.nuvoton.com;PTR:211-75-126-7.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(396003)(136003)(39860400002)(230922051799003)(61400799012)(451199024)(82310400011)(48200799006)(64100799003)(46966006)(40470700004)(47076005)(35950700001)(5660300002)(2906002)(4744005)(7416002)(83170400001)(36756003)(41300700001)(81166007)(356005)(55446002)(82740400003)(40460700003)(4326008)(2616005)(6666004)(110136005)(316002)(54906003)(42186006)(498600001)(76482006)(70206006)(8936002)(8676002)(336012)(6266002)(70586007)(40480700001)(73392003)(42882007)(83380400001)(82202003)(26005)(1076003)(45356006)(32563001)(35450700002);DIR:OUT;SFP:1022;
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 13:54:34.9096
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84125afc-d926-4982-9c15-08dc105158e2
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[211.75.126.7];Helo=[NTHCCAS01.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource:
	HK2PEPF00006FB5.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7681

Add clock reset syscon node to handle reset and clock registers
controllers.

Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
---
 arch/arm64/boot/dts/nuvoton/nuvoton-common-npcm8xx.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/nuvoton/nuvoton-common-npcm8xx.dtsi b/arch/arm64/boot/dts/nuvoton/nuvoton-common-npcm8xx.dtsi
index 9c4df91031e7..7d5956e2c9f3 100644
--- a/arch/arm64/boot/dts/nuvoton/nuvoton-common-npcm8xx.dtsi
+++ b/arch/arm64/boot/dts/nuvoton/nuvoton-common-npcm8xx.dtsi
@@ -22,6 +22,11 @@ gcr: system-controller@f0800000 {
 			reg = <0x0 0xf0800000 0x0 0x1000>;
 		};
 
+		clk_rst: syscon@f0801000 {
+			compatible = "nuvoton,npcm845-clk-rst", "syscon", "simple-mfd";
+			reg = <0x0 0xf0801000 0x0 0xC4>;
+		};
+
 		gic: interrupt-controller@dfff9000 {
 			compatible = "arm,gic-400";
 			reg = <0x0 0xdfff9000 0x0 0x1000>,
-- 
2.34.1


