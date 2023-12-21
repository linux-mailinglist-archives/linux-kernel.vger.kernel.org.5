Return-Path: <linux-kernel+bounces-8756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8340781BBD8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 17:21:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A815A1C24515
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 16:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B22C55E77;
	Thu, 21 Dec 2023 16:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="LNs3hMyf";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="wsPBP5Sz"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0014ca01.pphosted.com (mx0b-0014ca01.pphosted.com [208.86.201.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CFBD55E63;
	Thu, 21 Dec 2023 16:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cadence.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cadence.com
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
	by mx0b-0014ca01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BL66OlI005362;
	Thu, 21 Dec 2023 08:21:03 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=proofpoint; bh=Kru2jWe0eDytAKLr51E
	AZGr+XqJRdMIW1UIa7stbHqE=; b=LNs3hMyfJFZbE2vLMXuDJ6qUTrYt1EREWtg
	HOeeNZtFCG0vvWokYVRq3QGeOFp7Cv//9Q5mKcxREVtGIhG+v/E1VuJgDXnyV5fv
	vUiS2uSp7a7UO4a7P6s9RWdsxQUdG987+0mdntXuevcmOOyBZh+aofOKOL3+AdyV
	tKpkMptNYxWUd43VibzSRpdPWr7nAMPzNfOr+PPq9lMQRLgPefRCUSFrGjdnMOoM
	ZQOTyBnj19gqMHtTaSPYzUU8zzIjDxqD1PbL1kSlsN3PJm4btdv6fZnvQ6DYu1SI
	gzwi/j9q4Lxh/UTmz2PlEiTLZZk1TIA41U7+JeO7Fc31NYrPGPQ==
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by mx0b-0014ca01.pphosted.com (PPS) with ESMTPS id 3v18bydrtg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Dec 2023 08:21:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QC01YEP4V8ddpsHxmrZ6S30R0UeY/NQ7gczg/eVuD8bjNcWlZXBPNbSCFaPTKoqIAC5ytoXpYADgW5M6LHH/H/pDf/XpfTj5P7ZPOK8L/qpcTBUZrGhQueBAcBpSqV19AmSAQgnjEApDDlVxO/GQ5bK5BXT5hfZdU3ygIw3vzyEPdOkzDZ5UmC011cuyCbUQDfaBXEAGHrqPID0heEKEXwSyhF7/1ej1F+Yf+G+wF0dtRpR5OATeGf/7YVu2tNchzAptrAu4NhFL2crbl/poI+bWNrqtfouF7ShTkb9SULO5QBnvLHgip3XdIPK7Bk4wC4ha4BY+oYF18Lv3gmE06A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kru2jWe0eDytAKLr51EAZGr+XqJRdMIW1UIa7stbHqE=;
 b=FkxsA1LZ4A9TUR+6HvHrDIUe0UBCMIa7yrCSl2e+J2ssv4wwTZCA4yzkvsjnJtbVWs3l1HCLCk/I6ZjuxKaWGHcUq7o3cTv0uFOzwlfSyfQNb6RHodfU5kdAgSzRCfePcplAAZEl5fmQI+Ua3bZKZHOz+fkD38TvnJP9kZpDkGurewYnNoEh0N6OUJLOo51ZQWEIOqTJJkpcmkw7B4XqwIJwsFblg8iYpQx/csYgxIKtjSkKW8e3Uu28gGjUvZk5qHM2k2T1L0bpwhklPPGj1oZLoljtgWHaz1Ruz6ZFQWVEx3CFFuPPqA2Px9YOYUWj2NoXg8XKdeDpqdhNKn/Vgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.147) smtp.rcpttodomain=ti.com smtp.mailfrom=cadence.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=cadence.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kru2jWe0eDytAKLr51EAZGr+XqJRdMIW1UIa7stbHqE=;
 b=wsPBP5Sz9c4A+kuaoSjxP4iI6dg8m1vhWenXhhPmkX7IVc/YmzJlIjHgS8y02Erby+9LiZR9rE0lcI/c4hh3p7u3ollY1UIf5LFhUP05Y5xvbrDjmfTjja6lLKnd+o/39ECu/TpZ3tDYCUA/ftYmD3tto89Ht0RshHZuX1TXhy8=
Received: from BN0PR10CA0010.namprd10.prod.outlook.com (2603:10b6:408:143::14)
 by SN7PR07MB9435.namprd07.prod.outlook.com (2603:10b6:806:2a2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18; Thu, 21 Dec
 2023 16:21:00 +0000
Received: from BN8NAM12FT038.eop-nam12.prod.protection.outlook.com
 (2603:10b6:408:143:cafe::8c) by BN0PR10CA0010.outlook.office365.com
 (2603:10b6:408:143::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.21 via Frontend
 Transport; Thu, 21 Dec 2023 16:21:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.147)
 smtp.mailfrom=cadence.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.147 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.147; helo=sjmaillnx1.cadence.com; pr=C
Received: from sjmaillnx1.cadence.com (158.140.1.147) by
 BN8NAM12FT038.mail.protection.outlook.com (10.13.183.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7135.8 via Frontend Transport; Thu, 21 Dec 2023 16:20:59 +0000
Received: from maileu5.global.cadence.com (eudvw-maileu5.cadence.com [10.160.110.202])
	by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 3BLGKtLf005149
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Dec 2023 08:20:58 -0800
Received: from maileu4.global.cadence.com (10.160.110.201) by
 maileu5.global.cadence.com (10.160.110.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 21 Dec 2023 17:20:55 +0100
Received: from cadence.com (10.160.88.83) by maileu4.global.cadence.com
 (10.160.110.201) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7 via Frontend
 Transport; Thu, 21 Dec 2023 17:20:55 +0100
Received: from vleu-orange.cadence.com (localhost [127.0.0.1])
	by cadence.com (8.15.2/8.15.2) with ESMTP id 3BLGKu0N2131263;
	Thu, 21 Dec 2023 17:20:56 +0100
Received: (from sjakhade@localhost)
	by vleu-orange.cadence.com (8.15.2/8.15.2/Submit) id 3BLGKuOE2131262;
	Thu, 21 Dec 2023 17:20:56 +0100
From: Swapnil Jakhade <sjakhade@cadence.com>
To: <vkoul@kernel.org>, <kishon@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: <mparab@cadence.com>, <sjakhade@cadence.com>, <rogerq@kernel.org>,
        <s-vadapalli@ti.com>
Subject: [PATCH v3 4/5] dt-bindings: phy: cadence-torrent: Add a separate compatible for TI J7200
Date: Thu, 21 Dec 2023 17:20:50 +0100
Message-ID: <20231221162051.2131202-5-sjakhade@cadence.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20231221162051.2131202-1-sjakhade@cadence.com>
References: <20231221162051.2131202-1-sjakhade@cadence.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-CrossPremisesHeadersFilteredBySendConnector: maileu5.global.cadence.com
X-OrganizationHeadersPreserved: maileu5.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM12FT038:EE_|SN7PR07MB9435:EE_
X-MS-Office365-Filtering-Correlation-Id: 7745caea-23f8-488b-68f8-08dc0240d1d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	rVzWDPWQbVrwU+Yv6K1GDGAtYXm2GICq7cREpP/s4PsxUBUiyht1x88gPFI9ShrMbElO94fdUXdXpTfJbbqo9w8G51Qfn0JiAdpCmdHonQDvMk8y/7LePYE5WN0tOHXlQC98KKu5Qvi1ILFy8+XzHRiXKLOZm1Nl6N6+Yn9jfVGwJS1PJ/h+ZBaE8+ABJlG2EJCElbxXlItPuUWtOToc40xuh/7iBVR4JaeAv+hwvJ3gFvtOOhSiB6mmoQ6bhM0QgFBRUN6J35Lg6RjhUX52qg1hH59VgPFRDa96q0mlC7NXQta1cx9D9kTr9KNcQwrg6Q+7z5luyvJXBMJLJ3sOiyr+QvIH9l7E160FLw2Ze0qbLUhhk3FvSygk8c+PT292NvFxotfalaq1mTUnfaIQttLQzWoxWgyWYuf49k5GWP9YkpXFr/myglcb81KtnFKBwmjxpIT30ksN13TVjnBgABEUAzqSK4Np+/sR3o/fyROlvY2MLXOZu/r19wYbr4s0CFFJGLDHd/iV/7QQSLOELjIof30+14U6zrsq9Aeycf0Ia6EKOZaoyxq0vLv1HRHNdAGddGb1/RaG3ziqQxFfA3c32+p+P3IAciX7aTPtdxqbcyb7qpi2yLTndnInnhe22/oCfPMvDWvSuM/EBTzRjwGJx4tqFKOiXLv8Amu3ouYPUib3/AYlSJQBNge26+cEfzuSb06yADHGyhW4z/5gqUQvfS0duByuPSHle++D2he4Y79b7DMtttQgkjq/lt/ohFb5KtgZ9GaNevoeJ6Rrdw==
X-Forefront-Antispam-Report: 
	CIP:158.140.1.147;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx1.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(13230031)(4636009)(376002)(396003)(39860400002)(136003)(346002)(230922051799003)(1800799012)(186009)(64100799003)(82310400011)(451199024)(40470700004)(36840700001)(46966006)(4326008)(54906003)(42186006)(70206006)(316002)(2906002)(70586007)(8936002)(8676002)(6666004)(40460700003)(110136005)(40480700001)(478600001)(356005)(7636003)(82740400003)(336012)(426003)(47076005)(1076003)(7416002)(5660300002)(2616005)(4744005)(36756003)(41300700001)(26005)(36860700001)(86362001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2023 16:20:59.9660
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7745caea-23f8-488b-68f8-08dc0240d1d3
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.147];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	BN8NAM12FT038.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR07MB9435
X-Proofpoint-ORIG-GUID: skYTZ6iY1dASTNMUGsO4YspZW5TANIZh
X-Proofpoint-GUID: skYTZ6iY1dASTNMUGsO4YspZW5TANIZh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-02_01,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 clxscore=1015
 suspectscore=0 mlxlogscore=803 mlxscore=0 bulkscore=0 phishscore=0
 malwarescore=0 spamscore=0 adultscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2312210124

TI J7200 uses Torrent SD0805 version which is a special version derived
from Torrent SD0801 with some differences in register configurations.
Add a separate compatible for TI J7200 platforms.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
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


