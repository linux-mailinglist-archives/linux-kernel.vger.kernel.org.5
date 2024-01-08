Return-Path: <linux-kernel+bounces-19841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE826827517
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 17:28:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44051284312
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 16:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00CB2537F1;
	Mon,  8 Jan 2024 16:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nuvoton.onmicrosoft.com header.i=@nuvoton.onmicrosoft.com header.b="fIh9O+Ev"
X-Original-To: linux-kernel@vger.kernel.org
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01rlnn2054.outbound.protection.outlook.com [40.95.54.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA58352F80;
	Mon,  8 Jan 2024 16:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=taln60.nuvoton.co.il
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=afRb3xHEswKlTnVE2ozMwe8l6SGnxYg2UCEBRhd+9XqvCwxaospTqqVNnt02i3V2hsMn3lrYu0McTFd5sdnW+mGQ+fBZoJ9QmQUAicDN0CrKJ6oDLVS1z5LKfgg9knPfxlGACcKjme2BlmjnU9z+Np3lg8uU/F+IJoJzpO7fDZ+4D/8+zz2QMyux6EXz/qRPoXEdsDXZ9PeBQgcmjmlS003zsR478uTFoZCJnqODZDytdcYmHONYsZ3rHJ89R+4b56Al1gcgJKMZACm1vlcqChQNV1GpIx8syB+G4tEoTdQN0hrKRP57oq3q/B5N1hXUPltLs9xWXBGD3WVZWYZHrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Srrtx+a88TNyD5zyiXiMbEkBzrKR7ULA+ZK45jCj/S8=;
 b=WYUgYmjARAcEEkc3yADRY2wRqXoUA25pNfCjFJyXHxzvtMZdsoyuXWPG81YmYJVW1MQGVasx7P6dd1A+WNi/dE1ozS3H/MG6V3coGDEs0mb/ljD1Iv9Xr/1Aoh47KBwyv2JliEwHX0x9kXorljBsoEyk3a5VGHSPTv0FaWlJA1jkhhbem3jSENg0LGiYjYpWr0LH1yJ06GH0rWnBBzMjSYop3LIuTl7rMAPKRhDzXG/2Pl9PNrk71u7rPPE2uTTsD6+v6feBy86TnEZVrFkTxDIYS9gyot71qIz9wP7BSepm/1Pb1QfmLZN8CEgpLMt0b9LvK0+tMOsUPfKXqDN8Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 211.75.126.7) smtp.rcpttodomain=baylibre.com
 smtp.mailfrom=taln60.nuvoton.co.il; dmarc=fail (p=none sp=quarantine pct=100)
 action=none header.from=gmail.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuvoton.onmicrosoft.com; s=selector2-nuvoton-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Srrtx+a88TNyD5zyiXiMbEkBzrKR7ULA+ZK45jCj/S8=;
 b=fIh9O+EvxJUWPgPMFlg0MJq2pRAZ0o9ll0Q40i8qO12FUilbtxQo0somQfM8UYKxP50bfacDppdGUjF360MTzM5l06+9a9ir3mZc5LgKxSYPoG7vIYONoFmTTz+qyMe3USS/2yxazilM0QD3kkjuY6EAAr7nHzvb7wHt6h6OA1o=
Received: from PS2PR02CA0087.apcprd02.prod.outlook.com (2603:1096:300:5c::27)
 by SEZPR03MB7840.apcprd03.prod.outlook.com (2603:1096:101:18a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Mon, 8 Jan
 2024 13:54:32 +0000
Received: from HK2PEPF00006FB5.apcprd02.prod.outlook.com
 (2603:1096:300:5c:cafe::4) by PS2PR02CA0087.outlook.office365.com
 (2603:1096:300:5c::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21 via Frontend
 Transport; Mon, 8 Jan 2024 13:54:32 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 211.75.126.7)
 smtp.mailfrom=taln60.nuvoton.co.il; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=gmail.com;
Received-SPF: None (protection.outlook.com: taln60.nuvoton.co.il does not
 designate permitted sender hosts)
Received: from NTHCCAS01.nuvoton.com (211.75.126.7) by
 HK2PEPF00006FB5.mail.protection.outlook.com (10.167.8.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.12 via Frontend Transport; Mon, 8 Jan 2024 13:54:30 +0000
Received: from NTHCML01A.nuvoton.com (10.1.8.177) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 8 Jan
 2024 21:54:24 +0800
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCML01A.nuvoton.com
 (10.1.8.177) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.14; Mon, 8 Jan
 2024 21:54:24 +0800
Received: from taln58.nuvoton.co.il (10.191.1.178) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Mon, 8 Jan 2024 21:54:24 +0800
Received: from taln60.nuvoton.co.il (taln60 [10.191.1.180])
	by taln58.nuvoton.co.il (Postfix) with ESMTP id 81CF35F646;
	Mon,  8 Jan 2024 15:54:23 +0200 (IST)
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
	id 8127DDC0047; Mon,  8 Jan 2024 15:54:23 +0200 (IST)
From: Tomer Maimon <tmaimon77@gmail.com>
To: <mturquette@baylibre.com>, <sboyd@kernel.org>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <tali.perry1@gmail.com>,
	<joel@jms.id.au>, <venture@google.com>, <yuenn@google.com>,
	<benjaminfair@google.com>
CC: <openbmc@lists.ozlabs.org>, <linux-clk@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>, Tomer Maimon
	<tmaimon77@gmail.com>
Subject: [PATCH v22 3/8] arm: dts: nuvoton: npcm7xx: modify rst syscon node
Date: Mon, 8 Jan 2024 15:54:16 +0200
Message-ID: <20240108135421.684263-4-tmaimon77@gmail.com>
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
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FB5:EE_|SEZPR03MB7840:EE_
X-MS-Office365-Filtering-Correlation-Id: c354a121-1abc-4d12-2c1c-08dc1051568c
X-MS-Exchange-SenderADCheck: 2
X-MS-Exchange-AntiSpam-Relay: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	DxQJgjR7AWQorLlPsA9RQlcsKKDYDugMAzVsEpV419Mv0czVAKBGmusiDBXqZa/n68BznUlMcmhogO6um23LaoMycjNf/TDYO2shg7VeparierbSTPa1qTQmNj+Fh2W+quZW6L8faVxCF+8nZgdHaJGxhHi8jNPgNok8dmUJCNfJzgSIWJyySQdhsqap7iLMKrIR6rbL/I4nm8SYE2SiQkZNKbcg9hS2OEhUBC/yfCzH9gdAugLpmVpRSAf13aYL/iWBBm9eO9Utq9Kf3NiuXXBM7SQl2nnjkb12Npv5Z2HQzArQooDt1kN9xAZonvVx4w75CgkzW2faZxIuaspu4YI5KCEorMMA3XyJDXnawj5gGLOUB+0d8gRgR4Ng9gy8R5kAI2Bc2+yhea+tV6f0tGS9VrdrWfv2Ul+lodmcfPA61MhEvjFVkNjdpx9hA49zMIPtgIrP6uD6pfQg2n1hgxBexuILF5RlPjzuogQLQY7HOePYw4ZLVTxggBArbAyMI8qu26QgfNckMIbNrlJE34LNx+TEz8C0p9vYYO4xfjHHknm3aTO9coAMspfm63E4FTganMyOdatM+jI9UgJ5AxMpJfXRi5WKY8fA1CK1PVn+VnIB8Aan5M9X9R3IgPl6+Yn4klTaVsHBSVwhYgEPjc6wF3qHFfYcRpMQXl9xSZjKYjs90RFoLtUpfPSzQZC2ARPrk9ZS/1mgrOEkgMD/AcydR2c5COEIOPsZA6SFWXTygyQmHVFNaVa0MDqskz+PycKiYLYA8AYUFzJ+DzgIDCkj39DUCzQ0txogTa1bHtvDae/M/oAEUQBkc0E4sZT2RMNXfYfAo3O9o52xCwdq/S8H1Y7FcJpo3tiaZmckOew=
X-Forefront-Antispam-Report:
	CIP:211.75.126.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS01.nuvoton.com;PTR:211-75-126-7.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(376002)(346002)(136003)(230922051799003)(48200799006)(61400799012)(82310400011)(451199024)(64100799003)(40470700004)(46966006)(40460700003)(6666004)(4326008)(110136005)(40480700001)(76482006)(70586007)(70206006)(8676002)(8936002)(316002)(54906003)(42186006)(336012)(26005)(82202003)(83380400001)(1076003)(2616005)(498600001)(6266002)(73392003)(42882007)(4744005)(7416002)(5660300002)(2906002)(47076005)(35950700001)(82740400003)(356005)(83170400001)(55446002)(81166007)(41300700001)(36756003)(45356006)(35450700002);DIR:OUT;SFP:1022;
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 13:54:30.9721
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c354a121-1abc-4d12-2c1c-08dc1051568c
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[211.75.126.7];Helo=[NTHCCAS01.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource:
	HK2PEPF00006FB5.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB7840

rst node name and compatible property modified since clock and reset are
handled in the same memory region.

Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
---
 arch/arm/boot/dts/nuvoton/nuvoton-common-npcm7xx.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/nuvoton/nuvoton-common-npcm7xx.dtsi b/arch/arm/boot/dts/nuvoton/nuvoton-common-npcm7xx.dtsi
index 868454ae6bde..f72c5a03d04c 100644
--- a/arch/arm/boot/dts/nuvoton/nuvoton-common-npcm7xx.dtsi
+++ b/arch/arm/boot/dts/nuvoton/nuvoton-common-npcm7xx.dtsi
@@ -93,8 +93,8 @@ gcr: gcr@800000 {
 			reg = <0x800000 0x1000>;
 		};
 
-		rst: rst@801000 {
-			compatible = "nuvoton,npcm750-rst", "syscon", "simple-mfd";
+		clk_rst: syscon@801000 {
+			compatible = "nuvoton,npcm750-clk-rst", "syscon", "simple-mfd";
 			reg = <0x801000 0x6C>;
 		};
 	};
-- 
2.34.1


