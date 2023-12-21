Return-Path: <linux-kernel+bounces-8862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A55B81BD5E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 18:36:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C60B71F24398
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 17:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1475634EF;
	Thu, 21 Dec 2023 17:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="KdGjekLI";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="NvJVA9QD"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0014ca01.pphosted.com (mx0a-0014ca01.pphosted.com [208.84.65.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE3862811;
	Thu, 21 Dec 2023 17:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cadence.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cadence.com
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
	by mx0a-0014ca01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BLArhOg016198;
	Thu, 21 Dec 2023 08:21:01 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type; s=
	proofpoint; bh=t2WAHcTojol5LyadNmKttj8dpuigd+Kgg8tMs4vs2Fg=; b=K
	dGjekLI214bNLJMDWBaTabHhrxcOsOerML15OeMquNI4XrXjgc/5knvJsN4BJfcf
	CugindziFhKkRXgRWho0R3zAspsB93ha3Y0jtLJOdUKUbdAg0Rx5uG+iQgiisxZN
	cSjezA5K+Vyr2c+Xys9YIgGJb/DUVE8f7rJPSOJBXc3NIjXMkWiM+n/Ux/sZmhzA
	xPbIz0PdNs8CwUeN2+sEi+/7w8hiCOTkN3hbLj9agCFtvEid0kKrYxkYvvX9x84j
	+cARgtuJvswGTjkLYaSMmi9Ez6kq7T9PyL8RvTOxJAEB2jHF4hcReWTPEHs6onAu
	2EWu6oRIFlMvMv0NTTRnA==
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
	by mx0a-0014ca01.pphosted.com (PPS) with ESMTPS id 3v3rj5gsv7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Dec 2023 08:21:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HOJq7e+zEd6j0sKVnDGTDALgemQf00DgJuHqoD3llmtXopxdn5FKLThW7NwyrKzL2K6A2afur73UT2YapS7zyDYklNH4r4eV1yOE3fhLOA+QtU3vbyZgIewMXd0rpB0zsRii7tXoyzbj2D34makQuhbf6dAHWIlfHA/CiTgZ1/F0vLNLw7s1OxkmhF08Cv0tadazXnEA9XNgaYHyZU1SNTuY51DgSqYN8+sDudBmgwSMuZ3RCLMiwPaot6MFWrXz30A8bW3CEvv+wfjFNhA9UqC5IhVtVnD6G6Ea+MNntd5Bts134+n3GZPdArDiKr/GcTZw5OU+dSKMHBPS4AKQeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t2WAHcTojol5LyadNmKttj8dpuigd+Kgg8tMs4vs2Fg=;
 b=ZBHDEbgH0/CVwA75690vDmy55bTEy/8WG5RXj1u7lwq9rGuygWV46OUch4VcAgfb+ouPB5KDJitlyIaP3iDp1g4jMl4dmchD/qpzpbaV1sjGwYM+y2Mhj6QroerJVjgakG+k4sUMcN/xHbfeeGk04leLvJjOIbYXtC0AYOgAxPk+7hymU6mC6uML3thuJJHSjiwcFUBBzbCuhdlZcXPSOlywSRDsFRwbzriPEG2puZajBbXjB/1OW5BpSgbEmnrkJW57R0ZjYEU5HiLPmUbmvMVNoyTDEnD3e+7bfxTYxPyvnI266eAlFRlC/N1jTTuNNNEq2k3CIKxxoyg/bPFqBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.147) smtp.rcpttodomain=ti.com smtp.mailfrom=cadence.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=cadence.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t2WAHcTojol5LyadNmKttj8dpuigd+Kgg8tMs4vs2Fg=;
 b=NvJVA9QDgM3y5uQFbud2n/9Xe7cWB8w2/hmtCtssl/jVCGXuVnrfjQtBuRqRHBTKUOibG608bKWZUe6JzF4V+jNN8Gp6OYCbzPxvHn+z9IDy+HTBzYBhucLWJ3b9h6GpoKSqHZkIOVA0g9QJUMvAQqlYINzLbq5nw2Y3pl9N2v8=
Received: from BN9PR03CA0894.namprd03.prod.outlook.com (2603:10b6:408:13c::29)
 by BN8PR07MB7074.namprd07.prod.outlook.com (2603:10b6:408:da::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.19; Thu, 21 Dec
 2023 16:20:59 +0000
Received: from BN8NAM12FT026.eop-nam12.prod.protection.outlook.com
 (2603:10b6:408:13c:cafe::65) by BN9PR03CA0894.outlook.office365.com
 (2603:10b6:408:13c::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.20 via Frontend
 Transport; Thu, 21 Dec 2023 16:20:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.147)
 smtp.mailfrom=cadence.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.147 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.147; helo=sjmaillnx1.cadence.com; pr=C
Received: from sjmaillnx1.cadence.com (158.140.1.147) by
 BN8NAM12FT026.mail.protection.outlook.com (10.13.182.202) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7135.10 via Frontend Transport; Thu, 21 Dec 2023 16:20:59 +0000
Received: from maileu5.global.cadence.com (eudvw-maileu5.cadence.com [10.160.110.202])
	by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 3BLGKtLe005149
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Dec 2023 08:20:57 -0800
Received: from maileu4.global.cadence.com (10.160.110.201) by
 maileu5.global.cadence.com (10.160.110.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 21 Dec 2023 17:20:53 +0100
Received: from cadence.com (10.160.88.83) by maileu4.global.cadence.com
 (10.160.110.201) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7 via Frontend
 Transport; Thu, 21 Dec 2023 17:20:53 +0100
Received: from vleu-orange.cadence.com (localhost [127.0.0.1])
	by cadence.com (8.15.2/8.15.2) with ESMTP id 3BLGKsPG2131247;
	Thu, 21 Dec 2023 17:20:54 +0100
Received: (from sjakhade@localhost)
	by vleu-orange.cadence.com (8.15.2/8.15.2/Submit) id 3BLGKp7r2131244;
	Thu, 21 Dec 2023 17:20:51 +0100
From: Swapnil Jakhade <sjakhade@cadence.com>
To: <vkoul@kernel.org>, <kishon@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: <mparab@cadence.com>, <sjakhade@cadence.com>, <rogerq@kernel.org>,
        <s-vadapalli@ti.com>
Subject: [PATCH v3 0/5] PHY: Add support for dual refclk configurations in Cadence Torrent PHY driver
Date: Thu, 21 Dec 2023 17:20:46 +0100
Message-ID: <20231221162051.2131202-1-sjakhade@cadence.com>
X-Mailer: git-send-email 2.15.0
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
X-MS-TrafficTypeDiagnostic: BN8NAM12FT026:EE_|BN8PR07MB7074:EE_
X-MS-Office365-Filtering-Correlation-Id: c4c3334f-66b9-40aa-185a-08dc0240d15e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	24HT5z9bQZNRL4pBbpU66yl5eIsIRcIVf8LJ9oK0x92J84GHC0uDhXGdkKkmAYqeUfc+FWQTYT82P3X5mJ+SFRuohCE2sx91jnrzSsKoZYIdFkH8TTvTeu1X2imv9xV1u/S0hCfW+GGWGZ1xhxIVCIaYegnN59JJeiVJDsSzrttHTKIxJ9OnfJ54XY3ccvvoTSyX0Ia7d+OwFX594XtDJ2g6e3XRNMS0UoRefIznBhStXY9dGFLpSKAapzzhC5i2opDqdQSVytdNM89odBHCKxPMPaUQYXCRyQE8uy1cro4ZcSv2qxO3MSj/CkW6lNAZUaVCMNUIiLjo+M6/0Im5nK7+RVcGP64c/cOS5ymVs7F9Z3osNOEobY+n1SRzk8q6yR5gm6aHKVbuk+61h/QT+/VJolPX9vrICsydrvFQmtMV2z2MgRA60EVSB3qQz38fCxY8E5MNanjj+D7fVeOXoAe3l8zdml/YZZfizIiNpqojvwEAHUZ9xdquIRT9y1ntIDM6s9lGyol2LD52HOAKni2V+czjgWjQ9I1OlV1rCudqxG6fhkUABEXFvpy69TkYQ+vSBMPXhzR3ZRCgrBm+qi/3YsCR6YZ4vD02K+dzeIFk0f+zR2yUwqfPOzajJtEoTBLq5Io1TQD+3Z0BUId6Jounx/pi21qhr3058V347eIlkz6kEZP0eTKygpnBZynQ9tklJTAsO4nDDl5AFpchriKxCDWjCjH+bCMb/R8UteHofvQP9/QZdKsjMiwXqInR
X-Forefront-Antispam-Report: 
	CIP:158.140.1.147;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx1.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(39860400002)(136003)(376002)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(82310400011)(40470700004)(36840700001)(46966006)(41300700001)(2616005)(82740400003)(36756003)(86362001)(356005)(6666004)(966005)(478600001)(7636003)(1076003)(2906002)(40480700001)(336012)(426003)(83380400001)(26005)(40460700003)(70586007)(70206006)(110136005)(316002)(54906003)(47076005)(8936002)(42186006)(8676002)(4326008)(5660300002)(7416002)(36860700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2023 16:20:59.1972
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4c3334f-66b9-40aa-185a-08dc0240d15e
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.147];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	BN8NAM12FT026.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR07MB7074
X-Proofpoint-ORIG-GUID: MlJAifdHj32hK6ZusfFqENv4z7ibnJHT
X-Proofpoint-GUID: MlJAifdHj32hK6ZusfFqENv4z7ibnJHT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-02_01,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 phishscore=0
 priorityscore=1501 bulkscore=0 malwarescore=0 lowpriorityscore=0
 mlxscore=0 clxscore=1015 impostorscore=0 spamscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2311290000 definitions=main-2312210124

This patch series extends Torrent PHY driver functionality to support
dual input reference clocks.

It also adds support for following multilink configurations:
- PCIe(100MHz) + USXGMII(156.25MHz)
- USXGMII(156.25MHz) + SGMII/QSGMII(100MHz)

The changes have been validated on TI J721E and J7200 platforms.

v1 of the patch series can be found at [1].

Version History:

v3:
   - Updated clock description in DT documentation
   - Added Acked-by from Conor

v2:
   - Rename refclk1 to pll1_refclk in bindings and in driver
   - Simplify clock-names as suggested by Rob

[1] https://lore.kernel.org/linux-phy/20230724150002.5645-1-sjakhade@cadence.com/

Swapnil Jakhade (5):
  dt-bindings: phy: cadence-torrent: Add optional input reference clock
    for PLL1
  phy: cadence-torrent: Add PCIe(100MHz) + USXGMII(156.25MHz) multilink
    configuration
  phy: cadence-torrent: Add USXGMII(156.25MHz) + SGMII/QSGMII(100MHz)
    multilink configuration
  dt-bindings: phy: cadence-torrent: Add a separate compatible for TI
    J7200
  phy: cadence-torrent: Add USXGMII(156.25MHz) + SGMII/QSGMII(100MHz)
    multilink config for TI J7200

 .../bindings/phy/phy-cadence-torrent.yaml     |  11 +-
 drivers/phy/cadence/phy-cadence-torrent.c     | 705 +++++++++++++++++-
 2 files changed, 710 insertions(+), 6 deletions(-)

-- 
2.25.1


