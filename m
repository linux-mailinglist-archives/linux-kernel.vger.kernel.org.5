Return-Path: <linux-kernel+bounces-16774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C0C0824394
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 15:21:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D4AE1C20E2A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 14:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FE012374B;
	Thu,  4 Jan 2024 14:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="Z0KPkH/W";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="1mEAvJM+"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0014ca01.pphosted.com (mx0a-0014ca01.pphosted.com [208.84.65.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53638225AA;
	Thu,  4 Jan 2024 14:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cadence.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cadence.com
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
	by mx0a-0014ca01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 404CEZM3029523;
	Thu, 4 Jan 2024 05:30:27 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=proofpoint; bh=SoCb8bokPzZuZz0PJjB
	oW2MD0J9YPZXsxwHOstD+xsI=; b=Z0KPkH/W1KvDYVQKm6wDxtDWuaqmCdWyx01
	PHHxbuwR80mimhN9IB4Y1jNGqr7AjFUagyLEq/LIwmbJ87GEGYDDvNfzijziMDly
	necvKEeC4SfzJvFK6xxz8Tf0iwF481bfjXvJ/Epl3KteyUPkHtyqtmo1DwY2C96J
	PGm5Lq9QT2ZObomyRUPsyiZw4s8OSWYUhSovDkK3UhdEebY6+midqOqc5I7zbT1O
	fkoC93lvIDwPV7JCMXTm3R60D6Gsjigmduc/ZPtR3QDV6t1NoCgGGcrBlfMiPvUS
	NffzeOikoqmzVE0pCZdQB9S+vZavnDWHrT4NdB5WaoHXZSK41qw==
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by mx0a-0014ca01.pphosted.com (PPS) with ESMTPS id 3vagmwhm6b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Jan 2024 05:30:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zxxm3hzrCFrpYyFFOirlW7Wq2gAclw6JyvnPju/Gsa+r/vpMhw6j5BxIOE2rlwY4xG2ISaYhr66V2ZJRNg/g6WGnIabxe8K0yRemkotPtwQYPft399DRLo/EOEUWwyW/YOj0cBzQbMZSWXCyzN39F5+oMCmyjOMzMOcT35gqn5jZ3zHvBKPXL9KF4ePQhoeleMvpPrimGctRnGGif4nuNKMq0NK3ZP3sw+kiZdvo9aHOi5uXljJGPQdjRDZHDQt/b9RAvc3VHxugQRDijyAdCkHW3a+I4b+nA+8XYCOf7iUHfG1z6vbimYaX4/YutZljoa/FICkEkV/OvYiTqcZx0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SoCb8bokPzZuZz0PJjBoW2MD0J9YPZXsxwHOstD+xsI=;
 b=Au/+9SVGs0MKaUpDhKzwhP51rE+vIv863yBXVpO1kSEvPKIz+OB1PrG5EWy3DxovyosPCpIfIqMVrFfBgmnUDtmyigs5gZTu6BfQHtyOI4Uu5pyZwz4gz8N2w3ZA6Nl2Z6/CYPvz0rDCBUTSUM9VxkE7cujUQ6NTTpWG8NjvPXmyR6PaWoddtDNu+MaqlTcLI4bRQP7aGN7zFc6XNKfn8N71fC3PJI1w5Ijz6MIbBNHwUhqjLYvuNG4/ddwPCa1IV5inPqdwVdEA7OaRvZJyYuJHlSvOuq+6uksK1Oj2PFJDTskFXTbS5SUdSoQa8IOKIhE1o2B2ubrM6CuiydZzhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 64.207.220.244) smtp.rcpttodomain=ti.com smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SoCb8bokPzZuZz0PJjBoW2MD0J9YPZXsxwHOstD+xsI=;
 b=1mEAvJM+wohz2Gjv5/fhlYMsPbDtKB71wD9hgQUDf9xZIgtLUyO058PPW2QFfCeLTSo9CdOL+EPMoSEIJR1Gg5SPYikcuTSOEd0BxyWuJ5l2C3THKCYLWt8Vp7jQ5C31svQsK1kxhhi2xRSlfTyvcA17jLIhCuuRtBJcKSRvKF8=
Received: from DM6PR06CA0075.namprd06.prod.outlook.com (2603:10b6:5:336::8) by
 BL0PR07MB8097.namprd07.prod.outlook.com (2603:10b6:208:1ca::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.16; Thu, 4 Jan
 2024 13:30:24 +0000
Received: from DM6NAM12FT088.eop-nam12.prod.protection.outlook.com
 (2603:10b6:5:336:cafe::16) by DM6PR06CA0075.outlook.office365.com
 (2603:10b6:5:336::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.15 via Frontend
 Transport; Thu, 4 Jan 2024 13:30:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 64.207.220.244)
 smtp.mailfrom=cadence.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 64.207.220.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.207.220.244; helo=wcmailrelayl01.cadence.com; pr=C
Received: from wcmailrelayl01.cadence.com (64.207.220.244) by
 DM6NAM12FT088.mail.protection.outlook.com (10.13.179.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7135.29 via Frontend Transport; Thu, 4 Jan 2024 13:30:22 +0000
Received: from maileu4.global.cadence.com (eudvw-maileu4.cadence.com [10.160.110.201])
	by wcmailrelayl01.cadence.com (8.14.7/8.14.4) with ESMTP id 404DUJMi096550
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
	Thu, 4 Jan 2024 05:30:21 -0800
Received: from maileu5.global.cadence.com (10.160.110.202) by
 maileu4.global.cadence.com (10.160.110.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Thu, 4 Jan 2024 14:30:18 +0100
Received: from cadence.com (10.160.88.83) by maileu5.global.cadence.com
 (10.160.110.202) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24 via Frontend
 Transport; Thu, 4 Jan 2024 14:30:18 +0100
Received: from vleu-orange.cadence.com (localhost [127.0.0.1])
	by cadence.com (8.15.2/8.15.2) with ESMTP id 404DUIUc2911086;
	Thu, 4 Jan 2024 14:30:18 +0100
Received: (from sjakhade@localhost)
	by vleu-orange.cadence.com (8.15.2/8.15.2/Submit) id 404DUIsD2911085;
	Thu, 4 Jan 2024 14:30:18 +0100
From: Swapnil Jakhade <sjakhade@cadence.com>
To: <vkoul@kernel.org>, <kishon@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: <mparab@cadence.com>, <sjakhade@cadence.com>, <rogerq@kernel.org>,
        <s-vadapalli@ti.com>
Subject: [PATCH v4 1/5] dt-bindings: phy: cadence-torrent: Add optional input reference clock for PLL1
Date: Thu, 4 Jan 2024 14:30:09 +0100
Message-ID: <20240104133013.2911035-2-sjakhade@cadence.com>
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
X-MS-TrafficTypeDiagnostic: DM6NAM12FT088:EE_|BL0PR07MB8097:EE_
X-MS-Office365-Filtering-Correlation-Id: e570aedf-cbd3-4d44-248e-08dc0d294d8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	pu/AtLYyqIfWXzcXwP0l6MTmIy/Cn7iiW3cscSM3+/CXgm2W/+iORIvHcyqomcrmOpmD9K9kjIBkJofjmhHxQtNqM8IZu5Kfh0lPY3ApxFt7SA4zI2gVyeqGdshu7EOCsaHCbwTD6Khy8FnNNQZqLjfjiChWRf5SBNJq33dz8PUWkeSQglUtlCOvw+qgE4EMa1SbTq7IC+JoHMOFoL8DDe6xjjLQfhM26RfJIdpwQyXTkMwgezMTT8kV6JgDamCk6YYWHtua4qV8KxZGGXKONFOZmLqNJD9JPxTm1BNBuofrccHjTJbVv3qHyVz1aBZ5QH3A0aqwvJXV5kbW64om1dLgAw51dvJwhLbNzVDib7cPCiHYSNXWge2PvvR92ov+2c/HdnvMwMQSh6+TBJqB1rF/1yMKtM0r8zllX7PfUWporn3UZMyngU0htCsDODGXamr8T3oyrpUEtC+jLfjqwGsKuqt6QvpV0S2p2b1lr2U8uVy+QJvSeNm073jw6o3gnnfVfI4Qs1UBph+6QKx59aSw2AvQqToD1IXWpQugZxFWgTROQ/dh9SMfRy/u93ARhHv/V1eDijYkQiW6Gtm44cGbL2pg7pVtg6NHx1nPGH3spv1CwW/hfUTJQyGFKPl+QubA2qZyMzFoKr90YkIUI0M7r7yf8gqMDO92npsNa4SItaRdvlgCoOHHiRahhJO5kI8qxzdsqQ4v79cPfIT7YhLAZAkYg/7B+sVDEb7bYwhanqBhm5pLbxFyiDdKsgNesby1jhID/qF5pjyM+k2C9Q==
X-Forefront-Antispam-Report: 
	CIP:64.207.220.244;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:wcmailrelayl01.cadence.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(136003)(346002)(39850400004)(230922051799003)(186009)(82310400011)(64100799003)(451199024)(1800799012)(46966006)(36840700001)(40480700001)(36756003)(70586007)(70206006)(86362001)(426003)(336012)(81166007)(356005)(2616005)(1076003)(26005)(83380400001)(47076005)(36860700001)(2906002)(7416002)(5660300002)(6666004)(478600001)(4326008)(82740400003)(41300700001)(316002)(54906003)(42186006)(110136005)(8676002)(8936002)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 13:30:22.4589
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e570aedf-cbd3-4d44-248e-08dc0d294d8d
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[64.207.220.244];Helo=[wcmailrelayl01.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DM6NAM12FT088.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR07MB8097
X-Proofpoint-GUID: n74I9Hhh2stGSFD01X8oKb3vGTyIzUVq
X-Proofpoint-ORIG-GUID: n74I9Hhh2stGSFD01X8oKb3vGTyIzUVq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-02_01,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 impostorscore=0
 phishscore=0 adultscore=0 malwarescore=0 clxscore=1011 bulkscore=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 mlxscore=0
 spamscore=0 mlxlogscore=931 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2311290000 definitions=main-2401040105

Add a new optional input reference clock (pll1_refclk) for PLL1.
Update bindings to support dual reference clock multilink configurations.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Roger Quadros <rogerq@kernel.org>
---
 .../devicetree/bindings/phy/phy-cadence-torrent.yaml   | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml b/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
index dfb31314face..3893800f81b4 100644
--- a/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
+++ b/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
@@ -35,14 +35,18 @@ properties:
     minItems: 1
     maxItems: 2
     description:
-      PHY reference clock for 1 item. Must contain an entry in clock-names.
-      Optional Parent to enable output reference clock.
+      PHY input reference clocks - refclk (for PLL0) & pll1_refclk (for PLL1).
+      pll1_refclk is optional and used for multi-protocol configurations requiring
+      separate reference clock for each protocol.
+      Same refclk is used for both PLL0 and PLL1 if no separate pll1_refclk is used.
+      Optional parent clock (phy_en_refclk) to enable a reference clock output feature
+      on some platforms to output either derived or received reference clock.
 
   clock-names:
     minItems: 1
     items:
       - const: refclk
-      - const: phy_en_refclk
+      - enum: [ pll1_refclk, phy_en_refclk ]
 
   reg:
     minItems: 1
-- 
2.25.1


