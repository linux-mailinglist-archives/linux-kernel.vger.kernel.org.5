Return-Path: <linux-kernel+bounces-54743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E69184B31C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 12:08:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50FFB1C23F90
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 11:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12F4B131728;
	Tue,  6 Feb 2024 11:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="jvY6ggHR";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="ZdfxD+D0"
Received: from mx0a-0014ca01.pphosted.com (mx0b-0014ca01.pphosted.com [208.86.201.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F22B130AF0;
	Tue,  6 Feb 2024 11:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=208.86.201.193
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707217561; cv=fail; b=tRCKk9sVm1dH2JEwwies4XDrDXbRuFLdnY4g7HbQviQmnyFN2an3C0VJH4TljmD35lEwVbw1UvK3OEXiYbW3ASlep7quUkAWdTpfY47lLjtEeTHZvThDmTsY9MP9WECETHltJkv5D3P/hNzmIiOP90urNHyaIIgIuk8goCt5CBs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707217561; c=relaxed/simple;
	bh=p7V75UMlZCbxe6UohQvRSQ4W+ZcdeBdh6F5AKkVhwfc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mPdvE4+jo18UnW5Qfz+5HCi5ZeH3gb4Z/m2Y0mJ2xunCCPNjFXRungooB0pc4yucQ5Kdx4i1UC4rsGx9FYXxbkFDx4z90FpK6b6wbcKWhyCMRNB7/lxfLj1EPDgs4pzot/n+IljTpowCgWDKRgr9wDAm/ttCvTceoILuJ/KoyRY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cadence.com; spf=pass smtp.mailfrom=cadence.com; dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b=jvY6ggHR; dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b=ZdfxD+D0; arc=fail smtp.client-ip=208.86.201.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cadence.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cadence.com
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
	by mx0b-0014ca01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4164N59p004618;
	Tue, 6 Feb 2024 02:40:31 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=proofpoint; bh=jfec4i
	vPAaLg3Gek215m6DeZ6OYIbZs3U9P2su3wLmc=; b=jvY6ggHRI3gcOhs+aPovQ/
	02As3nQwlhNYxBUycG9MUccqs0DpE1AmVPnsBkQ3QBE4xamRVLgQ17nm2wDOkLHn
	DnTPyL4eh8mGpLoc4OkFugw4fS3xlrXziXtxU0W2mShouER11vVNO9/T5pKvcAhD
	Wi+KR1pIQBYQUjd0HTt1lraj2GaAbROzDdkJ7dozyWZ+T5vkLP3gjVC7XbM2Rpfq
	hTemEQcXhaznsqOvdtP1hTY86EPvFD+p6p5bud5RYbtOzpbo9EGqlbfTVtaoYFZA
	qi3GUo3/xpBWirwKCWWoT0EXIACHFLCzaIfF8gJCA/9C/+DbikymlDk6XpkB+s9g
	==
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazlp17010000.outbound.protection.outlook.com [40.93.14.0])
	by mx0b-0014ca01.pphosted.com (PPS) with ESMTPS id 3w3dpqh5xn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Feb 2024 02:40:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fyLkWYtatZWq+P2hfsGIuvcEGxCAK5LUO02SVpnlFT9LRriYeTPs7YXXticzTAwGC8zkxFmqjSu4s8Ptk9ZoYnkJPlMOzOeb6k3KB6pFpulrFuqj+0Ir/Q7dU69cVotRdfAdRTnurGCKuCu5PzIlwsRXQFV/PAh/ulWbBy3wJI4XSkInEYtQgs3dSQ9UQ5BBTb/ssBKo+8v9cE/pf7IMHH3Q1oomziX13YZgVWKu+RMsi5i/o2r17NYCWhGMASoskAiVUkBAOjdbDdzgr/0o6iFLOx826M0smuy3QNfI7mXdThA3GHTL8bEwGFTt32+yrt6sH2hQyHgUt46XtnViaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jfec4ivPAaLg3Gek215m6DeZ6OYIbZs3U9P2su3wLmc=;
 b=eegclXLIUVVf7kehI7WZDh11s4YUTBnCNO4Iu5U8Y3sCi5l1gI8NLCy52Kvj+iiHYRnKiPpQV5xJIIA2IvXCyz/jD3pt3KOa3L3ZbSfyAWFmcsEiCMMziHk+3MepDryqS5ucDR15YEqqaRzdbrI9ZGrchK+2CnJwS4XN5NBJRSJzaBenXPDVTWox8wzswuPZ6oAMywoR0TcyuRyP7X9sP1bKH0p3CqtQSD1RDbmfl1d1LTe9C44FzdkTAQ1mVkL6fiw7VcZtpE4119EHt6TpKfFb4qmAP55uyAgwWziHBYAJ8bRFtsAUcnHi89gbebpauPaRyvf02LzwGtrpNY4vDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 64.207.220.244) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jfec4ivPAaLg3Gek215m6DeZ6OYIbZs3U9P2su3wLmc=;
 b=ZdfxD+D0jVCX+1bRf5jL2TdwMQeEzh2GK0MZgasF62OZ1kjLuut4erqbzDCS2ilICgEqWdMkP0jtLXMWZkSJz8MIVsKY6Ys9OBmA16TlMhzYu1G9yAIi7Za2HR957x4guNEPJdF61dy9ojarHFYHAjecuSWzRv4pPhVKyjj2+zk=
Received: from MW4PR03CA0194.namprd03.prod.outlook.com (2603:10b6:303:b8::19)
 by CH2PR07MB8188.namprd07.prod.outlook.com (2603:10b6:610:68::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Tue, 6 Feb
 2024 10:40:28 +0000
Received: from MW2NAM12FT106.eop-nam12.prod.protection.outlook.com
 (2603:10b6:303:b8:cafe::3b) by MW4PR03CA0194.outlook.office365.com
 (2603:10b6:303:b8::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36 via Frontend
 Transport; Tue, 6 Feb 2024 10:40:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 64.207.220.244)
 smtp.mailfrom=cadence.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 64.207.220.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.207.220.244; helo=wcmailrelayl01.cadence.com; pr=C
Received: from wcmailrelayl01.cadence.com (64.207.220.244) by
 MW2NAM12FT106.mail.protection.outlook.com (10.13.180.208) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7270.11 via Frontend Transport; Tue, 6 Feb 2024 10:40:26 +0000
Received: from maileu5.global.cadence.com (eudvw-maileu5.cadence.com [10.160.110.202])
	by wcmailrelayl01.cadence.com (8.14.7/8.14.4) with ESMTP id 416AeOLr062797
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
	Tue, 6 Feb 2024 02:40:25 -0800
Received: from maileu5.global.cadence.com (10.160.110.202) by
 maileu5.global.cadence.com (10.160.110.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 6 Feb 2024 11:40:24 +0100
Received: from eu-cn01.cadence.com (10.160.89.184) by
 maileu5.global.cadence.com (10.160.110.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24 via Frontend Transport; Tue, 6 Feb 2024 11:40:24 +0100
Received: from eu-cn01.cadence.com (localhost.localdomain [127.0.0.1])
	by eu-cn01.cadence.com (8.14.7/8.14.7) with ESMTP id 416AeNen048487;
	Tue, 6 Feb 2024 11:40:23 +0100
Received: (from pawell@localhost)
	by eu-cn01.cadence.com (8.14.7/8.14.7/Submit) id 416AeNKP048482;
	Tue, 6 Feb 2024 11:40:23 +0100
From: Pawel Laszczak <pawell@cadence.com>
To: <peter.chen@kernel.org>
CC: <gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <pawell@cadence.com>,
        <peter.chen@cixtech.com>, <stable@vger.kernel.org>
Subject: [PATCH] usb: cdnsp: blocked some cdns3 specific code
Date: Tue, 6 Feb 2024 11:40:18 +0100
Message-ID: <20240206104018.48272-1-pawell@cadence.com>
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
X-MS-TrafficTypeDiagnostic: MW2NAM12FT106:EE_|CH2PR07MB8188:EE_
X-MS-Office365-Filtering-Correlation-Id: d05344e2-15bc-47f3-93c7-08dc2700081a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	JQ+tF3vTqX6RIBmPx7dDNbvLUzzgmdXqCRilXyXeRFvEW7agRBqPxWczbuZrpNCKpYoQ/yPWEEB5Tsg4/0sOdioHw5jo0ebGSFujhnPObJ25UHB4LbENwO8g8Ptc+q6HKfdZvlOiZmq3cicsD/2o87ZX6W3FYGxLur39GTwulBbydQWlzbWSvthMFaKls40SCn7LCWYDncYHzgx80pCFPu1A5K+H3e65YKci7u3JYk3up44gGfrvCd+t4NRAj8PjMyyShZvoWokp07Wtht9KHdnQSKyQHYKywFGAHocY7xSmcswEiAr0zwHpv7rKOeF9dzJRSVQY+9Fr+RJ7M/opHeb3+q+uDVTo9/DuDPQ0c9Em3Pf1th1sn57HOtUMFOqNV71JZgsQdW+Nf7reT1spFZ4QdCSEX/2iBwZHYz5oJPCZjjUJR63mDH5SKcHbVrPJr1eRNIt4CknHpzUoi/N6ZaAiOct2yxRYgc0rwdVXjo94S/bTxYeN0/euW2FgZxl9VlnKPMZ7g/zb0Tx+HbYiHdFITOjJY1ymwoZ5m6Z4SGIECSJARV8UrkzUEft7nsVYt2AtEjhE9Jqgo2Oyq4GtXpXYvooeGrdSb9B/OYMEea2V5HKBaTdkNKZVL/5EuQlFj/9mSQ+oAW9fYXmTaorIcqquKMEGLswVMjrT3qbg0ADo7vXv3fZhemkfnk8HF7qatfr9PDoTHkpxLiQzj82iuXMcJ2tcjS3LuvB0tGQJA7K7oJiHo7pOnGNJ/a0fHvM0WYoJLmKajULg+cC6YvQ1LQ==
X-Forefront-Antispam-Report: 
	CIP:64.207.220.244;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:wcmailrelayl01.cadence.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(39860400002)(346002)(396003)(230922051799003)(451199024)(1800799012)(64100799003)(82310400011)(186009)(46966006)(40470700004)(36840700001)(47076005)(41300700001)(86362001)(8936002)(8676002)(4326008)(336012)(426003)(478600001)(36756003)(5660300002)(2616005)(6666004)(1076003)(26005)(70586007)(316002)(6916009)(42186006)(70206006)(54906003)(2906002)(83380400001)(40480700001)(40460700003)(36860700001)(81166007)(356005)(82740400003)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 10:40:26.8585
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d05344e2-15bc-47f3-93c7-08dc2700081a
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[64.207.220.244];Helo=[wcmailrelayl01.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	MW2NAM12FT106.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR07MB8188
X-Proofpoint-ORIG-GUID: kbH1Tq2PjrhUDvFO606fTouTE0atqc1Y
X-Proofpoint-GUID: kbH1Tq2PjrhUDvFO606fTouTE0atqc1Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-06_04,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 mlxscore=0
 lowpriorityscore=0 clxscore=1011 impostorscore=0 malwarescore=0
 bulkscore=0 adultscore=0 priorityscore=1501 suspectscore=0 spamscore=0
 mlxlogscore=902 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2401310000 definitions=main-2402060075

host.c file has some parts of code that were introduced for CDNS3 driver
and should not be used with CDNSP driver.
This patch blocks using these parts of codes by CDNSP driver.
These elements include:
- xhci_plat_cdns3_xhci object
- cdns3 specific XECP_PORT_CAP_REG register
- cdns3 specific XECP_AUX_CTRL_REG1 register

cc: <stable@vger.kernel.org>
Fixes: 3d82904559f4 ("usb: cdnsp: cdns3 Add main part of Cadence USBSSP DRD Driver")
Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
 drivers/usb/cdns3/host.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/cdns3/host.c b/drivers/usb/cdns3/host.c
index 6164fc4c96a4..ceca4d839dfd 100644
--- a/drivers/usb/cdns3/host.c
+++ b/drivers/usb/cdns3/host.c
@@ -18,6 +18,11 @@
 #include "../host/xhci.h"
 #include "../host/xhci-plat.h"
 
+/*
+ * The XECP_PORT_CAP_REG and XECP_AUX_CTRL_REG1 exist only
+ * in Cadence USB3 dual-role controller, so it can't be used
+ * with Cadence CDNSP dual-role controller.
+ */
 #define XECP_PORT_CAP_REG	0x8000
 #define XECP_AUX_CTRL_REG1	0x8120
 
@@ -57,6 +62,8 @@ static const struct xhci_plat_priv xhci_plat_cdns3_xhci = {
 	.resume_quirk = xhci_cdns3_resume_quirk,
 };
 
+static const struct xhci_plat_priv xhci_plat_cdnsp_xhci;
+
 static int __cdns_host_init(struct cdns *cdns)
 {
 	struct platform_device *xhci;
@@ -81,8 +88,13 @@ static int __cdns_host_init(struct cdns *cdns)
 		goto err1;
 	}
 
-	cdns->xhci_plat_data = kmemdup(&xhci_plat_cdns3_xhci,
-			sizeof(struct xhci_plat_priv), GFP_KERNEL);
+	if (cdns->version < CDNSP_CONTROLLER_V2)
+		cdns->xhci_plat_data = kmemdup(&xhci_plat_cdns3_xhci,
+				sizeof(struct xhci_plat_priv), GFP_KERNEL);
+	else
+		cdns->xhci_plat_data = kmemdup(&xhci_plat_cdnsp_xhci,
+				sizeof(struct xhci_plat_priv), GFP_KERNEL);
+
 	if (!cdns->xhci_plat_data) {
 		ret = -ENOMEM;
 		goto err1;
-- 
2.37.2


