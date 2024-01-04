Return-Path: <linux-kernel+bounces-16708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 847438242C3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 14:38:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6E651F231C5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 13:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00E5F22338;
	Thu,  4 Jan 2024 13:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="PrMexsi5";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="Cgl7fHaX"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0014ca01.pphosted.com (mx0b-0014ca01.pphosted.com [208.86.201.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B5D2232F;
	Thu,  4 Jan 2024 13:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cadence.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cadence.com
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
	by mx0b-0014ca01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 404CXphL012198;
	Thu, 4 Jan 2024 05:30:29 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=proofpoint; bh=QIs5HkA6CLE3oFPi/Lc
	qsu+r5c9hqNOrH0dkzgmieXU=; b=PrMexsi5hbck+++15S+hOPSHGpxVziiDJ8a
	KZVF13epMnzhnE4naSDUq9d4UhwivL9kciyHxe3Z2/AkgrABNZXxPR/DC4B6IAMx
	1S2PcsDhBMeXGTAMsJpiikwyC3UNBZKodUXsHD3b+Lif2VVp0YVNy5ScUWZQQF54
	IieOY/LHwg7eQikvZW/8H0yxlpfP0TqNv0RW37HC5KEODjw+6lt9yECH1Yc/gJi7
	+nCSUpKJ3IIKLLmXrAfV/kUPfPnBsnbXFBg7C5Z0JLyi3OLSkoWE67UMjK6kCYEs
	Zf/C44e0kXgSoUFXVX0pbsDdTbZF4fJFs36OdvwG/mnLcwrteeg==
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by mx0b-0014ca01.pphosted.com (PPS) with ESMTPS id 3vafp0snd3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Jan 2024 05:30:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bUAnNWf8AaeL8A97lrpQdCCduu9oNptEwA505qKoNTvvi+/NqoMapDfot40OMg+Jzyt/2SunJmRVCgqOfLYTrDf9nh7slkeAyDel/Sp4x9jyYQ8rMVLT+0uXaAn0chgT80wzfCPCKEMWEYmDCOImp6CK4eYQl2L8sGF2BUAhue3HfwDeat3qfo0EhjEBkZxop9v3C6n9dNOB7NxZq/tufqbofZVARaV6Frehw2JH8Yb3/LQ7ai9DxtAvjQG/SDLfzKyRyxSMmDYHYLoC2UJhBFPELOeRa9VZ549PueBhKr1g3xZRc8W3L9rhadNzSF+zrl8fVfqPkPEmvjDalKm7cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QIs5HkA6CLE3oFPi/Lcqsu+r5c9hqNOrH0dkzgmieXU=;
 b=OBcWk6IsSoOxzA0wIVXsnWyR+ckj+s5xqkflRLKLvoaxN2/Xp71BxxhV2UPGXDyJkW117F6VVtFqdjI5xRCwhcW5p1T+FQF46UzZAishDGz19KRLIQn1XTN5GOq4WsvV+ixJEbXJ8kEV58HqGERwEDogmXZuMYHQYgRkeVJPhSr+zBN1eCMKWihAw5KYKv5fASNA39BVOFj8UH/5o/UpX40HcfbOinv1Z+A1vVMedF5GLM4jUoWciNTXR01O4bN4mej7k5bU20uMZxKWa6qVDESjlSF0xhui8PQ1lwuLltU7JqliLU85cHdZsqBf6JSuwIp3/LLQgq7NZI91uVpT7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 64.207.220.244) smtp.rcpttodomain=ti.com smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QIs5HkA6CLE3oFPi/Lcqsu+r5c9hqNOrH0dkzgmieXU=;
 b=Cgl7fHaX9Ubf+f0kIPtigXLPSJC1AkFkPOSSKT7D1iouRMPepNqa+zfINoTYSz8Xt6XNkLd6Tl+7LM2Va5evDhL0l2vXYTtCf8Y2/StXizE03XNPNKdiuXCO4wX9HCU2GDTcAHu+t5+YFlgzc8EzCix6Pdh2Vy3CIQDtkuyVLLE=
Received: from CY5PR19CA0114.namprd19.prod.outlook.com (2603:10b6:930:64::7)
 by MN2PR07MB7134.namprd07.prod.outlook.com (2603:10b6:208:1a2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.15; Thu, 4 Jan
 2024 13:30:25 +0000
Received: from CY4PEPF0000FCC4.namprd03.prod.outlook.com
 (2603:10b6:930:64:cafe::17) by CY5PR19CA0114.outlook.office365.com
 (2603:10b6:930:64::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.15 via Frontend
 Transport; Thu, 4 Jan 2024 13:30:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 64.207.220.244)
 smtp.mailfrom=cadence.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 64.207.220.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.207.220.244; helo=wcmailrelayl01.cadence.com; pr=C
Received: from wcmailrelayl01.cadence.com (64.207.220.244) by
 CY4PEPF0000FCC4.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7159.9 via Frontend Transport; Thu, 4 Jan 2024 13:30:23 +0000
Received: from maileu4.global.cadence.com (eudvw-maileu4.cadence.com [10.160.110.201])
	by wcmailrelayl01.cadence.com (8.14.7/8.14.4) with ESMTP id 404DUJMk096550
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
	Thu, 4 Jan 2024 05:30:22 -0800
Received: from maileu5.global.cadence.com (10.160.110.202) by
 maileu4.global.cadence.com (10.160.110.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Thu, 4 Jan 2024 14:30:18 +0100
Received: from cadence.com (10.160.88.83) by maileu5.global.cadence.com
 (10.160.110.202) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24 via Frontend
 Transport; Thu, 4 Jan 2024 14:30:18 +0100
Received: from vleu-orange.cadence.com (localhost [127.0.0.1])
	by cadence.com (8.15.2/8.15.2) with ESMTP id 404DUIpk2911102;
	Thu, 4 Jan 2024 14:30:18 +0100
Received: (from sjakhade@localhost)
	by vleu-orange.cadence.com (8.15.2/8.15.2/Submit) id 404DUIIl2911101;
	Thu, 4 Jan 2024 14:30:18 +0100
From: Swapnil Jakhade <sjakhade@cadence.com>
To: <vkoul@kernel.org>, <kishon@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: <mparab@cadence.com>, <sjakhade@cadence.com>, <rogerq@kernel.org>,
        <s-vadapalli@ti.com>
Subject: [PATCH v4 4/5] dt-bindings: phy: cadence-torrent: Add a separate compatible for TI J7200
Date: Thu, 4 Jan 2024 14:30:12 +0100
Message-ID: <20240104133013.2911035-5-sjakhade@cadence.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20240104133013.2911035-1-sjakhade@cadence.com>
References: <20240104133013.2911035-1-sjakhade@cadence.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-CrossPremisesHeadersFilteredBySendConnector: maileu4.global.cadence.com
X-OrganizationHeadersPreserved: maileu4.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC4:EE_|MN2PR07MB7134:EE_
X-MS-Office365-Filtering-Correlation-Id: 98970579-213a-4129-1870-08dc0d294e23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	xJnQvO563FrQ3wJYVjngg4LRDR+cpEGdd/KqVu8wBDVyRmJjdxLrTUu4kq4CGvMndQqX7xOXWbIDEz6uzcKzRHFDDTjwBUDiprY9j4NGYrZJpqPmCqBrjoLqhJmRknCUZz28O+mgfCcBhoF1Fzl/yzTo2t4d/f75hPlMV8cgF1F1v27Vz5p3udo/Nu6zOGi2vzOJFTpoxLUP+/VgYZEel05y0RstdFvd/ZthiCPlg9lS8ppI3vx289SLWWPMaxdt0X48uhnEDOcDTKEDWyzTsVxVXoqva/qmzf7oa256s2rfAuODqJy/l3zl8xQu8wNxjoRGUuJGdL51/QqBuXP50/0wKRwR+xaKqntg8SFoIJbTf1UnhvFhUO5ovLZO+4xyZn++dEgwNs8DaDhZF0egUCx7mtHY572mzGkida7iSJ98mn+PbBNXKbcmrYEO9MS6mZExWUExj8LMo/WWy2M8satOLgqlOEZVPhS2dDU34os0Y8CDgALjVWe8H87+8IOYRd1WDtf00Fbcdat/IDx59QQsS5JxKOoXXerSInhDoKvnON09VtCZ0yBrIalCWgJsVQIASuh89MUiOhk951YoSTkdRRsRGYj7/tu6889LjA5GRo0PYiY6ebKr+oSc1rxQyEl3cFVA43B5f0lXBWhpgXZHlI9uJvL0Pmm1W5XqgXOhTzeMVWrEwjNoW8HCqHWPWozJAcN3TzVpkZdKgrYVcn7C5mnnImPh4E94A6sFO9scIopy1t3/XY0hWU2AG+fOlrRfZGpC0y45kSEky83tpBf3KDz3dqp39z8stwU4ZdQ=
X-Forefront-Antispam-Report: 
	CIP:64.207.220.244;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:wcmailrelayl01.cadence.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(396003)(376002)(136003)(230922051799003)(1800799012)(64100799003)(186009)(82310400011)(451199024)(46966006)(40470700004)(36840700001)(4744005)(7416002)(5660300002)(8676002)(8936002)(4326008)(36756003)(2906002)(41300700001)(86362001)(356005)(81166007)(2616005)(6666004)(478600001)(82740400003)(40480700001)(36860700001)(47076005)(26005)(1076003)(40460700003)(336012)(426003)(70586007)(70206006)(110136005)(54906003)(42186006)(316002)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 13:30:23.4104
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98970579-213a-4129-1870-08dc0d294e23
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[64.207.220.244];Helo=[wcmailrelayl01.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	CY4PEPF0000FCC4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR07MB7134
X-Proofpoint-GUID: yiH-wFNQ8xzuqSAwCnjrFSSExptMo8z2
X-Proofpoint-ORIG-GUID: yiH-wFNQ8xzuqSAwCnjrFSSExptMo8z2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-02_01,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 impostorscore=0
 malwarescore=0 mlxscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 mlxlogscore=841 lowpriorityscore=0 clxscore=1015 adultscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401040105

TI J7200 uses Torrent SD0805 version which is a special version derived
from Torrent SD0801 with some differences in register configurations.
Add a separate compatible for TI J7200 platforms.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Roger Quadros <rogerq@kernel.org>
---
 Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml b/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
index 3893800f81b4..15dc8efe6ffe 100644
--- a/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
+++ b/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
@@ -20,6 +20,7 @@ properties:
   compatible:
     enum:
       - cdns,torrent-phy
+      - ti,j7200-serdes-10g
       - ti,j721e-serdes-10g
 
   '#address-cells':
-- 
2.25.1


