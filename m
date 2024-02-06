Return-Path: <linux-kernel+bounces-54706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30A4384B2AA
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 11:44:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC2352890F7
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 10:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD80C12EBDB;
	Tue,  6 Feb 2024 10:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="U8ZaQNCr";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="V5/VRia0"
Received: from mx0a-0014ca01.pphosted.com (mx0b-0014ca01.pphosted.com [208.86.201.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7341EA7F;
	Tue,  6 Feb 2024 10:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=208.86.201.193
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707216246; cv=fail; b=enh75U4JwJ36ilNuRs8mMq7l0TsEJkcmfYNRYGEmqCvlPnRvPbJNQaXjcMACUdbVLXX3Jlw2BxLTp8FwS9S5VU29wptuVkcC/fMv1NQaIQdHGUZ73B60qtvL2jnoSk6dhScKln9p900GEijYVQ0yiYystwhAErAOhGibDOvJ7fc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707216246; c=relaxed/simple;
	bh=ua9BtmcTgDW9gLY7oM2k7Me0dtA3qvRdLZ/GhvXRyaE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dguXuYnVzK25EdKCuo2JGUIouwvOTTHS6OsWAvZNk724QuFVXYhyb6d4FiErWkHj2nupfCwBHXsuDzRsKtIgdOuzmm5+Q/zB47rhv8NJ4GBVJ5IFVLBjo/ti7gnHdNhUTy9hl3b20dKHGgCaTbUskuk8k4Cc4AiONeleUXSUQc4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cadence.com; spf=pass smtp.mailfrom=cadence.com; dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b=U8ZaQNCr; dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b=V5/VRia0; arc=fail smtp.client-ip=208.86.201.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cadence.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cadence.com
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
	by mx0b-0014ca01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 416AcBOb004611;
	Tue, 6 Feb 2024 02:43:55 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=proofpoint; bh=JE/Xmi
	AYLlwhbiG1xS2J7DsnwbAKuihY6cOknT41MDU=; b=U8ZaQNCrp5hPw2q5hYo92Y
	BrhbgI749MSj/Aok7+ENnUAfe7kwAeL/AfAdhWcG+FERBPxweAc/M7nOM3uqQZBC
	RV2uOyPME0c+eW5PTJkaTjSqqejGx0mxcU/7n4p3b/lTf9SmoVDoZi1X8lpKAMlj
	Jwca7iZw412uRcLS4djJ2IugdYPSkKebRIHe/sRQ5C/xXo0o14eg5VL43ifZX+rO
	yZq045LLmktuTnGwTRMawmipms/Ux4NJI7ntsiUHO80D/LL2I/dsu0Pi975dpJKT
	Yb3Q7uxGQkqdK9xn1hBidj2+VW3+Mm+SCXgp6CuJLtE7JLseyAMOguJfwhJuORrg
	==
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazlp17011010.outbound.protection.outlook.com [40.93.1.10])
	by mx0b-0014ca01.pphosted.com (PPS) with ESMTPS id 3w3dpqh66y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Feb 2024 02:43:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mjUTgJFqfnzenb30tOaFXv+Z6B2ZdTfXGyVqUnF+6bdj+lD3AJc+diNHBKK/1KsArW5PKGq1kQW/+CWkmTzZVPkXJGkhrUzI590niRQpuSPK5WfWzJYE8dlVbyAmeyGlL44ibBk9BWwj+B285xLtDqsh/HCHtFAD3X0aDejTJTxIwZCQVlW4HRDcK0u4zZyOxJn55oD4JP8LanMtXhUG5kdETsDyx8wQB/oPyTbRYe/xnMQ2sP5h6xVi1CmxbbyzCRiKOm2p4RRlfULE1KNVBgWQMSn7iKPY22dHuPrRCitNsP5ucx0is38/HnTzlmYmaFhsPNnkc3X8nK4FhicIBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JE/XmiAYLlwhbiG1xS2J7DsnwbAKuihY6cOknT41MDU=;
 b=PpQkrkYoFmLarGpTd/4sKPX8hLDxYCiK+vrtjm/eZSanM8cRphVpTlrw6Ke5CKskTqd+wnwICNXXKvED5Twi4uiw7qGS34BCkShXSu4/MG878T2zDmypS+0wdO7a0PdY9Y1OhG6v5AxqYAcdNHHLjDq2kf5mNYEjtbHrpttPZ9OWldQb0Mi0ZW+JNlfiAX8L8eyQzudXqVqZIct/Nlsx1F4J4P0vIc3rvjoFnIsDw+MozJB6S8d/A8OwKTsGEER6OaZCcrDOqdb8vwiDOGVrelB0a6XEFL4ynmP6QPYztQCMjbpRoP9SCLZFGXjJtAxdro63RgqDkCZ8FfW9QemRRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.147) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JE/XmiAYLlwhbiG1xS2J7DsnwbAKuihY6cOknT41MDU=;
 b=V5/VRia0p/c2qZNgQ00Xhh+doLcIJXZBqIliS52NvTUXSxMrr9Uc6AUV8q2YwzgGxGNykB0NOWg/6Vmub8yhSXHmtQKiw/VQU+XUDi8G1leGCqR8r/acy0AYn3bIKDN1jfiEuoGDuY7Ch84JRltZMVzJblhs8sdCW2XkoFFali0=
Received: from BN0PR04CA0118.namprd04.prod.outlook.com (2603:10b6:408:ec::33)
 by BN0PR07MB8941.namprd07.prod.outlook.com (2603:10b6:408:150::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Tue, 6 Feb
 2024 10:43:52 +0000
Received: from BN8NAM12FT084.eop-nam12.prod.protection.outlook.com
 (2603:10b6:408:ec:cafe::c2) by BN0PR04CA0118.outlook.office365.com
 (2603:10b6:408:ec::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36 via Frontend
 Transport; Tue, 6 Feb 2024 10:43:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.147)
 smtp.mailfrom=cadence.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.147 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.147; helo=sjmaillnx1.cadence.com; pr=C
Received: from sjmaillnx1.cadence.com (158.140.1.147) by
 BN8NAM12FT084.mail.protection.outlook.com (10.13.183.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7270.8 via Frontend Transport; Tue, 6 Feb 2024 10:43:52 +0000
Received: from maileu5.global.cadence.com (eudvw-maileu5.cadence.com [10.160.110.202])
	by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 416Ahmaf005285
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 6 Feb 2024 02:43:50 -0800
Received: from maileu5.global.cadence.com (10.160.110.202) by
 maileu5.global.cadence.com (10.160.110.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 6 Feb 2024 11:43:36 +0100
Received: from eu-cn01.cadence.com (10.160.89.184) by
 maileu5.global.cadence.com (10.160.110.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24 via Frontend Transport; Tue, 6 Feb 2024 11:43:36 +0100
Received: from eu-cn01.cadence.com (localhost.localdomain [127.0.0.1])
	by eu-cn01.cadence.com (8.14.7/8.14.7) with ESMTP id 416AhaZK055903;
	Tue, 6 Feb 2024 11:43:36 +0100
Received: (from pawell@localhost)
	by eu-cn01.cadence.com (8.14.7/8.14.7/Submit) id 416AhZgN055896;
	Tue, 6 Feb 2024 11:43:35 +0100
From: Pawel Laszczak <pawell@cadence.com>
To: <peter.chen@kernel.org>
CC: <gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <pawell@cadence.com>,
        <peter.chen@cixtech.com>, <stable@vger.kernel.org>
Subject: [PATCH] usb: cdnsp: fixed issue with incorrect detecting CDNSP family controllers
Date: Tue, 6 Feb 2024 11:43:25 +0100
Message-ID: <20240206104325.55456-1-pawell@cadence.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM12FT084:EE_|BN0PR07MB8941:EE_
X-MS-Office365-Filtering-Correlation-Id: 56ada39e-653e-4e08-71df-08dc27008296
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	L0ZXwh6//EeCHkPuLnmUn73D9Ku3A310sw28lqMsVul7AuEqwVznDIBlePjo1sfvTk2AWkB2mELc/PeL7eqj9i1bDViyqPQENM0JwpYYz+H/sswaoEM7wfu+aYDtoobCmKC9S+Ze4OmiZUD1hbgvOzq7AU22B7/ChCLfMyw+xVx1EtSt7ZuSMQMHyN11rZkRWqn3apjyPODw53z/nJmXMPsVIGcyWC0GIanOH8FJL4AJ2YUxMiHpbrix2YpaceyBNRBNYx2eBI4jLDJ05jH3qQDsA7rhP+ss+2bWlcl/uExttFc3C/w9slOVh7KHHg4q+8ToN5zAJXFAVpRNFT1C1IPTRRhTpHY3NcgI/m/clW4c7V2dJ39UCAMhozNt+OHPCEE0HRI/ksmlWNTVE4Wef63sS44LcfhVMF4KlA8R7i9hNW/ftNPwqXyqJdUM+XeeYAtx7ZVg5iZY9xH1UXWugtFFQ1XIhVp+U2NJ0tSvZp5arsXVz+ZXOeqmRnDBDH/dEbtTXayJymWlBLdxXK7gFxGBgV0nq8nibA+OI7avVUrPH+vONGVkZk41Ru69FSUpfyrGWKH1lCBVqKrdwK/dDHS9E2AeW2D0505sUzgq5sZpc54kFF5dYbWpD0MQtQX+LtZZlJ58gIgGsvZ+lq16lRiS6js1op1bay4ZWOoqBCHI+8qCgEPMpgJvBTquVQT+86ubsLLos63vlE6fNkrd1SwZfccKydqB427XvzYLabPl0O28cxyQ4YIvhpEKyxfp
X-Forefront-Antispam-Report: 
	CIP:158.140.1.147;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx1.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(136003)(346002)(39860400002)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(82310400011)(36840700001)(40470700004)(46966006)(40480700001)(47076005)(40460700003)(82740400003)(7636003)(356005)(83380400001)(36860700001)(86362001)(426003)(336012)(1076003)(2616005)(26005)(478600001)(6666004)(54906003)(316002)(41300700001)(42186006)(70586007)(70206006)(6916009)(4326008)(36756003)(8676002)(2906002)(5660300002)(8936002);DIR:OUT;SFP:1102;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 10:43:52.2586
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56ada39e-653e-4e08-71df-08dc27008296
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.147];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	BN8NAM12FT084.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR07MB8941
X-Proofpoint-ORIG-GUID: jMijDfYKa0toQ0DRXf7PmVyN-CPVYb05
X-Proofpoint-GUID: jMijDfYKa0toQ0DRXf7PmVyN-CPVYb05
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-06_04,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 mlxscore=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 bulkscore=0 adultscore=0 priorityscore=1501 suspectscore=0 spamscore=0
 mlxlogscore=450 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2401310000 definitions=main-2402060075

Cadence have several controllers from 0x000403xx family but current
driver suuport detecting only one with DID equal 0x0004034E.
It causes that if someone use different CDNSP controller then driver
will use incorrect version and register space.
Patch fix this issue.

cc: <stable@vger.kernel.org>
Fixes: 3d82904559f4 ("usb: cdnsp: cdns3 Add main part of Cadence USBSSP DRD Driver")
Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
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


