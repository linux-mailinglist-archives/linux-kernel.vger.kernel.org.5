Return-Path: <linux-kernel+bounces-66962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E938285641C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 14:14:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52F3D2847EE
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 13:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 877B312FF8C;
	Thu, 15 Feb 2024 13:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="DTsfJQQ4";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="vcbeKchR"
Received: from mx0a-0014ca01.pphosted.com (mx0a-0014ca01.pphosted.com [208.84.65.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9443212F582;
	Thu, 15 Feb 2024 13:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=208.84.65.235
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708002838; cv=fail; b=Ml6iRezDzp+xA3SAN5RO6EGiFURADR3K4oJLCl9bG6W0huCQ9x7KfU841pWXKyooEHFSf/zWfORpBKqPEaglmMrOmKq471wGaw6VZYo3Cm31oADhU6SW2SHPE7OiOkUk3S4sReDUdTbeC3UJpExx2FVjahIcsRnwFbUwy/z5/uc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708002838; c=relaxed/simple;
	bh=EexJT4jFWaEPB2e7MtMAm1XWm6+Spf+mxas/O7X/hU0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OK3AYLeLuolP/5wfVVWAgcdT1NnI1QxC56Nv80jcdA4gPXk9dW+PhJVhtPhzIl9iVjj0rQpEear+fnT7x+7aGDhNOFEP7IJ5gfnzScFfcLF5hqfGkwAA1fKAA2db9AVdmZ+/q03GR7mKZKmLh8V219I9cxPT/7J8YxskDWoaMo8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cadence.com; spf=pass smtp.mailfrom=cadence.com; dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b=DTsfJQQ4; dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b=vcbeKchR; arc=fail smtp.client-ip=208.84.65.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cadence.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cadence.com
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
	by mx0a-0014ca01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41F3fvnV031565;
	Thu, 15 Feb 2024 04:16:28 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=proofpoint; bh=ZfMXSC
	L0BrDiHN3JJbGkJNx0MnD5467RvxiBDQeoHqI=; b=DTsfJQQ47h6lpc38zY5gfO
	omd47nJji6pRW8n9Cm7eFV4QjvA87xD8p8JalUHliM9MPuS0KMfR8Hvm9QOM6b71
	stIJPhSLbGxmSAkhSEgXa0v5WIPyavmlAIYqUGOgsb5VFt5RA1Itk3WYgDKotn9C
	qVCfmHRG3e9ldn4JcChtjYaqXf5Pyxr12ny5BEAN9BIrOxv4GEKx3kQZE7qwkZo+
	g9zXKy5Ca+/L1Y1WFV5N05wv1VwqPyVp8getbXuSqdKj87+wxb0tDEBrVNG2Nr0v
	18J770YtnWqyynHl5G73lDCxw1V3n+/h++T6zGdQeJHZaJk5KA64CG5ZjEIRy53w
	==
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by mx0a-0014ca01.pphosted.com (PPS) with ESMTPS id 3w9axd1b7m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Feb 2024 04:16:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YMVRPmZxJxk0q95Jf+Xs4llsF9kpps2qvdZzVASlgPp3i09x72LNdyzIivnoYcsZi/NThGjKMPUpRAi1dl1TIsWFFj2G2M4GPMprk0jQ5WxnmMUbPv+aF5zzwvPk9C/sNlOTLXBQWztCU+Dbvyj8MJf4U5d93BwMPMb0g2DNn/qbwG3qQzNvzeiKPMFK15L3vT62tEG55/cVCYFFThlNUtXHJIuQ/yS5NKvbYRHzu/9i3EEee0GFwOz8UPwQwbZoDlQEmBepX6DCwlYUlr53xJj+njljNXtwQAQEPEi5/3VFQ3AxyLmt8MLP7PpLW4a018tgs9CLszU4fvSFvllYZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZfMXSCL0BrDiHN3JJbGkJNx0MnD5467RvxiBDQeoHqI=;
 b=f7P0/K1tSubTYdkjVGnasysJ6UU5RrecV5iB8TkOGeToc7poCm/cnTMKaP+tE5028AQ8zGJpZWSuIka3cDusFjZfXLUGJSW2+s4lplSW3iL8FWU2yRkL3LmMtqR0HgOXIlb8ISD36XTQ3e/YHdGKRdEx8mRf+AjpGWuYyKwVjTzh0KNmRd2OjqUow3g2NBs7vVPr2nc6ukKYBgE0VI7fg1g1Rk2Ke+Ud7sMO8W9naZCXpnMYoiBljKzB+wiE4tp5oTcE6/0akQbSLOwQg022iJVtoCGzbBXBlmoVfJyy5ifeaiKvc9QGB4dtATZ8fQ9FeT+EX9R1odL7p1/sZM7xHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.147) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZfMXSCL0BrDiHN3JJbGkJNx0MnD5467RvxiBDQeoHqI=;
 b=vcbeKchRgbQFxCtTYNIzEz6HeYRldeLFqPhwZJoXDQYRQBuMothdsseo0Tjg9FsySQlSEsYxICbK51jsD7tmiNUxcvy+/UN9YuCNRrExL4WW8l0wOZtVUy3lNTGbi55MrEJf5q2nLjZ1BDtupJ+a8jnVgXkLv1LRaB2TOJ3hhi4=
Received: from BN8PR04CA0007.namprd04.prod.outlook.com (2603:10b6:408:70::20)
 by SJ0PR07MB8418.namprd07.prod.outlook.com (2603:10b6:a03:335::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.28; Thu, 15 Feb
 2024 12:16:26 +0000
Received: from BN8NAM12FT115.eop-nam12.prod.protection.outlook.com
 (2603:10b6:408:70:cafe::d5) by BN8PR04CA0007.outlook.office365.com
 (2603:10b6:408:70::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.26 via Frontend
 Transport; Thu, 15 Feb 2024 12:16:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.147)
 smtp.mailfrom=cadence.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.147 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.147; helo=sjmaillnx1.cadence.com; pr=C
Received: from sjmaillnx1.cadence.com (158.140.1.147) by
 BN8NAM12FT115.mail.protection.outlook.com (10.13.182.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7316.14 via Frontend Transport; Thu, 15 Feb 2024 12:16:25 +0000
Received: from maileu5.global.cadence.com (eudvw-maileu5.cadence.com [10.160.110.202])
	by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 41FCGLjt012652
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Feb 2024 04:16:22 -0800
Received: from maileu5.global.cadence.com (10.160.110.202) by
 maileu5.global.cadence.com (10.160.110.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 15 Feb 2024 13:16:21 +0100
Received: from eu-cn01.cadence.com (10.160.89.184) by
 maileu5.global.cadence.com (10.160.110.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24 via Frontend Transport; Thu, 15 Feb 2024 13:16:21 +0100
Received: from eu-cn01.cadence.com (localhost.localdomain [127.0.0.1])
	by eu-cn01.cadence.com (8.14.7/8.14.7) with ESMTP id 41FCGKE2259946;
	Thu, 15 Feb 2024 13:16:20 +0100
Received: (from pawell@localhost)
	by eu-cn01.cadence.com (8.14.7/8.14.7/Submit) id 41FCGK7c259942;
	Thu, 15 Feb 2024 13:16:20 +0100
From: Pawel Laszczak <pawell@cadence.com>
To: <peter.chen@kernel.org>
CC: <gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <pawell@cadence.com>,
        <stable@vger.kernel.org>
Subject: [PATCH] usb: cdnsp: fixed issue with incorrect detecting CDNSP family controllers
Date: Thu, 15 Feb 2024 13:16:09 +0100
Message-ID: <20240215121609.259772-1-pawell@cadence.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-CrossPremisesHeadersFilteredBySendConnector: maileu5.global.cadence.com
X-OrganizationHeadersPreserved: maileu5.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM12FT115:EE_|SJ0PR07MB8418:EE_
X-MS-Office365-Filtering-Correlation-Id: b5876c7a-ba8b-42bd-c053-08dc2e1fee13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	FSpBstMc56VivpOzLDU0uI1+G7oq6NBg+SEynWDLr7GOanH7aWksYCQbH9Xkv6tW5wT+ePoE9rvATKRXGlfSBwR/7uLcP0c2PHhprCS4VQTWtxYHfMn4S7bGBQFCkNRSYodpC3IzifviJCsX6hDcRkdHGDQ06sw/ytvgrBH4QyajyvuKHbIU2084g7akRfV8YkpjBF+nnw6gOxhq31UgmMoPzxwFBb16/+IS3u7dsutRC3VWDasT9/AMfD085kA68xvG3Su5ZKqqpnmIHfXZBCwuGfgxKj0nEqlXVHDZhh5544hYEpZSHOBujo2NcXf3wTyY8Ra517uiZUEyUC15H7G0seeb7mqHpo7/9qqSJ3XWCLTEq8+MYpEnyHpUgVrDs+Tj9ZXGkdB1Zhpb5Iw8587bIK/UMxwIPjA/TFmIXHYhBdKYOJteoT82TV1+4vn1AtCQwtxLtpHDHb/sq72ttTHIiuKhvm8pNYjmKjDm/hDUVsV0AXdf4djAC8qjvBjK72DgaphxQ7ExGxCQ72gwUWcoiko2yr0TNximiyiuopjG+NHbrXAWh5ebAJDpOMpW/DOyBXeUeuG7H+iVa7lGqOhyt4IdZWH3ey2FuIDb6E+WmBJ/eCZkfh5DWeZIetPOCVVpfWXjzKRu+khCOpFRtXVi11yJWqLtLIrCt1/2oAY=
X-Forefront-Antispam-Report: 
	CIP:158.140.1.147;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx1.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(136003)(39860400002)(376002)(230922051799003)(1800799012)(451199024)(36860700004)(186009)(82310400011)(64100799003)(46966006)(40470700004)(5660300002)(8936002)(8676002)(6916009)(4326008)(70586007)(2906002)(83380400001)(26005)(1076003)(82740400003)(336012)(426003)(7636003)(356005)(36756003)(86362001)(42186006)(316002)(54906003)(6666004)(41300700001)(2616005)(478600001)(70206006);DIR:OUT;SFP:1102;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2024 12:16:25.1497
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5876c7a-ba8b-42bd-c053-08dc2e1fee13
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.147];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	BN8NAM12FT115.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR07MB8418
X-Proofpoint-GUID: TAesQK7eAcvTwTydkzvpeom-I8ASJge9
X-Proofpoint-ORIG-GUID: TAesQK7eAcvTwTydkzvpeom-I8ASJge9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-15_11,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 suspectscore=0
 mlxlogscore=475 malwarescore=0 spamscore=0 lowpriorityscore=0 phishscore=0
 impostorscore=0 adultscore=0 mlxscore=0 clxscore=1015 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402150098

Cadence have several controllers from 0x000403xx family but current
driver suuport detecting only one with DID equal 0x0004034E.
It causes that if someone uses different CDNSP controller then driver
will use incorrect version and register space.
Patch fix this issue.

cc: <stable@vger.kernel.org>
Fixes: 3d82904559f4 ("usb: cdnsp: cdns3 Add main part of Cadence USBSSP DRD Driver")
Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
Changlog:
v2:
- typo have been removed

 drivers/usb/cdns3/core.c |  1 -
 drivers/usb/cdns3/drd.c  | 13 +++++++++----
 drivers/usb/cdns3/drd.h  |  6 +++++-
 3 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
index 33548771a0d3..465e9267b49c 100644
--- a/drivers/usb/cdns3/core.c
+++ b/drivers/usb/cdns3/core.c
@@ -395,7 +395,6 @@ static int cdns_role_set(struct usb_role_switch *sw, enum usb_role role)
 	return ret;
 }
 
-
 /**
  * cdns_wakeup_irq - interrupt handler for wakeup events
  * @irq: irq number for cdns3/cdnsp core device
diff --git a/drivers/usb/cdns3/drd.c b/drivers/usb/cdns3/drd.c
index 04b6d12f2b9a..ee917f1b091c 100644
--- a/drivers/usb/cdns3/drd.c
+++ b/drivers/usb/cdns3/drd.c
@@ -156,7 +156,8 @@ bool cdns_is_device(struct cdns *cdns)
  */
 static void cdns_otg_disable_irq(struct cdns *cdns)
 {
-	writel(0, &cdns->otg_irq_regs->ien);
+	if (cdns->version)
+		writel(0, &cdns->otg_irq_regs->ien);
 }
 
 /**
@@ -422,15 +423,20 @@ int cdns_drd_init(struct cdns *cdns)
 
 		cdns->otg_regs = (void __iomem *)&cdns->otg_v1_regs->cmd;
 
-		if (readl(&cdns->otg_cdnsp_regs->did) == OTG_CDNSP_DID) {
+		state = readl(&cdns->otg_cdnsp_regs->did);
+
+		if (OTG_CDNSP_CHECK_DID(state)) {
 			cdns->otg_irq_regs = (struct cdns_otg_irq_regs __iomem *)
 					      &cdns->otg_cdnsp_regs->ien;
 			cdns->version  = CDNSP_CONTROLLER_V2;
-		} else {
+		} else if (OTG_CDNS3_CHECK_DID(state)) {
 			cdns->otg_irq_regs = (struct cdns_otg_irq_regs __iomem *)
 					      &cdns->otg_v1_regs->ien;
 			writel(1, &cdns->otg_v1_regs->simulate);
 			cdns->version  = CDNS3_CONTROLLER_V1;
+		} else {
+			dev_err(cdns->dev, "not supporte DID=0x%08x\n", state);
+			return -EINVAL;
 		}
 
 		dev_dbg(cdns->dev, "DRD version v1 (ID: %08x, rev: %08x)\n",
@@ -483,7 +489,6 @@ int cdns_drd_exit(struct cdns *cdns)
 	return 0;
 }
 
-
 /* Indicate the cdns3 core was power lost before */
 bool cdns_power_is_lost(struct cdns *cdns)
 {
diff --git a/drivers/usb/cdns3/drd.h b/drivers/usb/cdns3/drd.h
index cbdf94f73ed9..d72370c321d3 100644
--- a/drivers/usb/cdns3/drd.h
+++ b/drivers/usb/cdns3/drd.h
@@ -79,7 +79,11 @@ struct cdnsp_otg_regs {
 	__le32 susp_timing_ctrl;
 };
 
-#define OTG_CDNSP_DID	0x0004034E
+/* CDNSP driver supports 0x000403xx Cadence USB controller family. */
+#define OTG_CDNSP_CHECK_DID(did) (((did) & GENMASK(31, 8)) == 0x00040300)
+
+/* CDNS3 driver supports 0x000402xx Cadence USB controller family. */
+#define OTG_CDNS3_CHECK_DID(did) (((did) & GENMASK(31, 8)) == 0x00040200)
 
 /*
  * Common registers interface for both CDNS3 and CDNSP version of DRD.
-- 
2.37.2


