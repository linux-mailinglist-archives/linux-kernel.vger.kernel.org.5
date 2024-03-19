Return-Path: <linux-kernel+bounces-107354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B114987FB5C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 10:59:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FB421F22715
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 09:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2326E7F47F;
	Tue, 19 Mar 2024 09:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iesy20.onmicrosoft.com header.i=@iesy20.onmicrosoft.com header.b="JnTWffE/";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=iesy20.onmicrosoft.com header.i=@iesy20.onmicrosoft.com header.b="MsYHnZHT"
Received: from DEU01-FR2-obe.outbound.protection.outlook.com (mail-fr2deu01on2123.outbound.protection.outlook.com [40.107.135.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC917D3FB
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 09:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.135.123
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710842189; cv=fail; b=su83Mm3e+ZH1hX/7J4D1W0bBod13ibvMSD888JZXsMlYXg4Rmrji/QySi4fx/d6Pkz60HYk7HFp8nHWb6IBiBFN04eFABk74c+mDexsdmXNzAnvtkwGgPA+wJbzlIxC1wgAtDyQkszS769t1qcWGN0qSm2y25c5fSRo8NLwhLkw=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710842189; c=relaxed/simple;
	bh=RkF+5/KLzVRkAe11O54ZMZYXlSChr+gZTZDP3fwk0Qs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RR4aemeI7KMg3SNmLpAOOy7OEE2inQGh9PZNpWJUdVSLOWHcw8LLFAAbWE+F1F7kCelyfbg4gKvQGGhgrc44EZ/Lricpa5LePlGJlv2AhOwjgjECHypcTGaF5m/InAhoNSF5XLcNMLE7Gg1+2Q0css57HetUr260NMqdT5oVcBE=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iesy.com; spf=pass smtp.mailfrom=iesy.com; dkim=pass (1024-bit key) header.d=iesy20.onmicrosoft.com header.i=@iesy20.onmicrosoft.com header.b=JnTWffE/; dkim=fail (1024-bit key) header.d=iesy20.onmicrosoft.com header.i=@iesy20.onmicrosoft.com header.b=MsYHnZHT reason="signature verification failed"; arc=fail smtp.client-ip=40.107.135.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iesy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iesy.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=fail;
 b=GVlvRj9Ccvh16GSWNI0E80mCnAMjmuLSBqZVPgHCniT8frGsendBRqObjtfdxriqF1QOb7sbxHGp9zfsP286RHpybHgbAV5BQsiLihJ0F4M7CbkgD9yoB/aUaGxVh3xjP4BSIVVsdPtiANircneOLIgSI9rwtJadSPND4SKTM4WlOCNcWbHdBqxatNuEEzOheHzfW1YTGplDepLtZOeKvYpt4vrg0lLfPmiEPViF0ox8iHPK0g61r81MpCdzAbGmG9iSSnkYieDMeZFDMK/BiXgoU/RpZPfY4kMaCUQKgrwbT5iQhO+kbxhx9gRfTcWysZwTVwNDWMT1EK2LlcS27g==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CfqgEgehjhAgi2aZAR1Ft3o57dbv5YtT3UR0ZPpnWVI=;
 b=KSLNQqsWLgTwa0i3cj/IyawrvktltECiZw/vBqbnyDAh9mWQQ7n7Lbl2Me1qI4hclEpN1L0Or2PfNlC5/GK4Jq1dMy4jdkkOk0WryOcPC2D/XyEjHyzZdD1hWYcFPHkZRnXWYkYOucpQ4qU8h8kR3NnRn2/E2wtjcypO96COIovbiUHfEO4/dXYyT2EcOiGitYUj9MabloABTiDWpr6dWuV/9/4oWZene21LkcXmhnt2UYPzY2hNo1VnpRXLzPzKTfB/PFj3hmQhKcunkjdoS6+D9HeMNsKwbxA2qYcCqwJzAdutJ0nqyM8sHqNza+cL28B1n6gBT/1avJJiR5E+Nw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=fail (sender ip is
 20.79.220.33) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=iesy.com;
 dmarc=none action=none header.from=iesy.com; dkim=fail (body hash did not
 verify) header.d=iesy20.onmicrosoft.com; arc=fail (47)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iesy20.onmicrosoft.com; s=selector1-iesy20-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CfqgEgehjhAgi2aZAR1Ft3o57dbv5YtT3UR0ZPpnWVI=;
 b=JnTWffE/1avKVn8WVjtW7Yy9JuCnKFIye/ne25KLWQ/XluuQbKenI3ij/dfx677jXkAh5X1dUgbm20Bub7rFLHr+5u9r6s5fgblbyZ6PI3yrhITjMQMJP2AGpGkhsQ0gRPuFKpcRewdkzROHkuzLBbQYXcPpA8Qi0r7ojK/fdug=
Received: from FR5P281CA0017.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:f1::9) by
 FR2P281MB1767.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:8e::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7386.28; Tue, 19 Mar 2024 09:56:24 +0000
Received: from FR3PEPF00000485.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f1:cafe::61) by FR5P281CA0017.outlook.office365.com
 (2603:10a6:d10:f1::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.11 via Frontend
 Transport; Tue, 19 Mar 2024 09:56:24 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 20.79.220.33)
 smtp.mailfrom=iesy.com; dkim=fail (body hash did not verify)
 header.d=iesy20.onmicrosoft.com;dmarc=none action=none header.from=iesy.com;
Received-SPF: Fail (protection.outlook.com: domain of iesy.com does not
 designate 20.79.220.33 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.79.220.33; helo=de1-emailsignatures-cloud.codetwo.com;
Received: from de1-emailsignatures-cloud.codetwo.com (20.79.220.33) by
 FR3PEPF00000485.mail.protection.outlook.com (10.167.240.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.10 via Frontend Transport; Tue, 19 Mar 2024 09:56:24 +0000
Received: from DEU01-FR2-obe.outbound.protection.outlook.com (104.47.11.168) by de1-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Tue, 19 Mar 2024 09:56:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ToVoiln8slz24Zd5tONWlhpxMFV8VXHxgnh1ywBSRBfKoLyD4tO5jVcOFHxkzdLlS3ciBJNxDixpkPQILX2KfR8qIhX/0eXjKdBqzT7VHQ+sUhnjHbvbj2QCZgP7gxNXNUZ2ii8PnFyAxz0USdbsouylhVOfmv0VVCL/bIYQZfHCcyfYMSa/Cd+gnPf2bJXc4K9nbyZ6RBYuGcXb0xGlX8G2wANHX4L+2fdH2fysL1PAAn900TPvLzPMXGuXdS6tDoFDZi/M4/EotXco3Af11JWxkULeILciC6vy+dNvKLLWzoEAP+5zw54hJAP/oxxKvpeiZWxmK+kevVwwRnPRpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k9Q7flSpE0KZCAn04UCUZRESTfWID1OR/7DzyuaLbiE=;
 b=blZM7keuEKQzjaQb/W2Wc3s79sXuIBIz9Aqmb2ajYumolhonK8gDr2BI+8figuBaEbg4xN1p9tUJlG7dw1RLtRMAGT5gsZ0h4Vc9OgeR/bgQ5VX0gZgiuyw5hUTW2eQ4zkGv2rlisXRJx/zDINhcCfIHdJk5sOgtF/TkGV9sY2mWs15y4xymbOpxQJHhvj16lqfHjpqLDB5fGwoB8ho2GCVdpCB4PhJQaA3cnFI59vOKBNMNp6q/8Nk9+0t2oYaVK+C/d9/VYhzNry7mYwzLdmqvl19K1Xb6L/Vm6GSVj3wgoqrFwZF/slTHNy+6+9rwhKa92h5ndypWwQ+c9Zo93A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=iesy.com; dmarc=pass action=none header.from=iesy.com;
 dkim=pass header.d=iesy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iesy20.onmicrosoft.com; s=selector1-iesy20-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k9Q7flSpE0KZCAn04UCUZRESTfWID1OR/7DzyuaLbiE=;
 b=MsYHnZHTpR4xAF+qz2z4gHDjNATRZ3Q0wxX2Gows9kEXCrFvqrvEaMZu9DAqmxyHq+nr09/dya45PWUiUX4AzCL61mr9PcTaFLQGtAIgHNRAbZPtvLZZia6Rquv3TptIRWkFwn4mwRb6fJmFi+5REBJMHK0b/Hq0ny6GCR5Lt8k=
Received: from FR2P281MB2393.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:39::12)
 by BEYP281MB3930.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:b4::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.29; Tue, 19 Mar
 2024 09:56:22 +0000
Received: from FR2P281MB2393.DEUP281.PROD.OUTLOOK.COM
 ([fe80::8af4:a741:edb6:e851]) by FR2P281MB2393.DEUP281.PROD.OUTLOOK.COM
 ([fe80::8af4:a741:edb6:e851%3]) with mapi id 15.20.7386.025; Tue, 19 Mar 2024
 09:56:22 +0000
From: Dominik Poggel <pog@iesy.com>
To: robh+dt@kernel.org
CC: Dominik Poggel <pog@iesy.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Chris Morgan <macromorgan@hotmail.com>,
	Sebastian Reichel <sre@kernel.org>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Tianling Shen <cnsztl@gmail.com>,
	Ondrej Jirman <megi@xff.cz>,
	Andy Yan <andyshrk@163.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: [PATCH 2/3] dt-bindings: vendor-prefixes: add iesy
Date: Tue, 19 Mar 2024 10:54:01 +0100
Message-ID: <20240319095411.4112296-3-pog@iesy.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240319095411.4112296-1-pog@iesy.com>
References: <20240319095411.4112296-1-pog@iesy.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0067.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:15::20) To FR2P281MB2393.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:39::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-TrafficTypeDiagnostic:
	FR2P281MB2393:EE_|BEYP281MB3930:EE_|FR3PEPF00000485:EE_|FR2P281MB1767:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original:
 yQktxLhofcdNpLGkCcoEtcUj/zZf+QriJMovKfft9fylMzp61zXQXAE0ydQuiSxijzWDfrRoJ1Q2P5XzL+lp9tBN1rANnQS2prAZcqRvhIWtL3QOcu5z7gngBr/5yOysySjlce2102jgYg2dEuKK9Sy9oayovNFzN5BYPHSlFvYcM22BRN4Fg/dEzSS/G2EOuMoOQBUMSgeeIcH3R6nIrmUSrbrVFFPEhRYDH71wxJ2UpRIkdK9wQD3OmmqxJ4hc7QtQc0JR4ILRG7+xCUkxBfrfsDNVZL1Je9R6eQVI7SaI2OsqWNzSF7DuRAZpUav03LNAwiNayn/q1owIynXoFc0SCU2tdlnk608vRfvfaBtvBWQmuT8KBk7QaZHjsKPrJxE2fP++6jN7Zi+qjfsfTBPrbsEQyGYNfluFCn7ys+tSnvu8qa4MOwlppPO+j641P3Sfnphc/SeQ35QZKy8nqUz5OsIWtHXy/ezlwUkfJ7HmSElmPlqgbNKd+RJ2tIbeK4zY6/4d2jsk373spbUSI0iU5fxXTTIbUDMONL27QGRbZ5ENssvSGay8L33/7xMEu/NnPZ3rgTtZ+5ySCZKX4eJizhYIoKA9eetHU0CKWk8OYBsIScLHUoZYZB7nvs7Gyr/oqaGsTC4INrRfUVoOUM7tyUmRVwuhKFqfaw2sqPUz7r4WTfLVdyDeUQoN/fN9XCysWMs3QbK6EtqQWZ2xrrpSIX1RTOhLnMm5AyOrFD0=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR2P281MB2393.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(52116005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BEYP281MB3930
X-CodeTwo-MessageID: 1aa96dd6-e3b0-43a2-99e2-fc62a399cc61.20240319095623@de1-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 FR3PEPF00000485.DEUP281.PROD.OUTLOOK.COM
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f66707b8-0af1-432e-f454-08dc47fad660
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	D9Znzy1NJVXTW2bGubRPYfHDW7efvji3Drx0nz4neAJ7jVsi4LYJOMPpGLFY3zHhWPGBR5sDTSOZuipjX+UXSBBusGZhnzUlVTHAipRbXd4L6w2ckVaUsB7iwL8UY4CqjLzThF8qNO+lKhWaN2CbCMsUkDp4jDwvahoEkYCxLzsbqze7FsPV/nL/xcFjRHPRc2tpqvKd+BAb5KUEkXXvplFslz8Dv+vPHZOneFjtREEjFGrdIZYaO8a4bQyJYOiZvXqGVg/kdEa7EsTO6C9Uy5tpgtaSQrGp9k23pweV3kMM65UvryRi5U8wLy7OwKm5wMv3G2T2R0+Bd5JjBuuf5UqKAgPcG7PFPU0AedB+OVqqtYYE42sB4rKA+Uxyp2pJ/MkJbDg501goMssrvQRII5b7ZE/a/FdkwvqhVZxjNLkmA3XWmtz2pbvEJR3w9Ef1KuzfbgYhG/HQytjFt/ewqHEbXMVYPTX9xLZMeSUd6opTQ8G2PSmxAVnYu/W9WAhFvcL1SNvKpllb2ixGeCPPuyf7DEs+D4YWasMh+WIAqatm4yUBeTtfdtnE2Q1QVFaEiRQQm/+CtZ7PiCWNuu16XbbOUJaNYUbktaZ0tyACq9jTqBHxentbZnoQbhEL6eXydecxSbkQlPPlu8ZnurUTlqVNPWx46z/Ya72pZWE4kn6z9KhGJdhQWZkqmrMDS8IG38lb5NSrH3rp+z9rPjBg+lII8Z8W/9yO0QYyfsyjQGI+FzW7lLPqgHTJ/BjVUKfv
X-Forefront-Antispam-Report:
	CIP:20.79.220.33;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:de1-emailsignatures-cloud.codetwo.com;PTR:de1-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230031)(1800799015)(376005)(82310400014)(36860700004);DIR:OUT;SFP:1102;
X-OriginatorOrg: iesy.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2024 09:56:24.3529
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f66707b8-0af1-432e-f454-08dc47fad660
X-MS-Exchange-CrossTenant-Id: ace663fd-5672-464f-8169-8d373312f6bc
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ace663fd-5672-464f-8169-8d373312f6bc;Ip=[20.79.220.33];Helo=[de1-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource: FR3PEPF00000485.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR2P281MB1767

Add iesy GmbH

Signed-off-by: Dominik Poggel <pog@iesy.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Docum=
entation/devicetree/bindings/vendor-prefixes.yaml
index 04505cb0b640..ffb2abb5edc2 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -656,6 +656,8 @@ patternProperties:
     description: International Business Machines (IBM)
   "^icplus,.*":
     description: IC Plus Corp.
+  "^iesy,.*":
+    description: iesy GmbH
   "^idt,.*":
     description: Integrated Device Technologies, Inc.
   "^iei,.*":
--=20
2.44.0


