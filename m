Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 697CF7E2B11
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 18:39:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232016AbjKFRjM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 12:39:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231819AbjKFRjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 12:39:04 -0500
Received: from mx0a-0014ca01.pphosted.com (mx0a-0014ca01.pphosted.com [208.84.65.235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E865ED49;
        Mon,  6 Nov 2023 09:39:01 -0800 (PST)
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3A6DZqke010888;
        Mon, 6 Nov 2023 09:38:57 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding:content-type; s=proofpoint; bh=bM3emn
        e8aZofXYNPRzpzPf1uwjrMSPbJCRQrESdcHNo=; b=NyMXSMl/dBYWjbOcbpen1J
        uj4NRTDJ9BCFuf6t7uyx2dJ2yx9vaXVl3RMeKyTWdKM9pyzxVa7fzhzrErb+s3El
        hx7VJ6KBMuxFuNIrGwXU2MewSy3eydFFy0r/jUxLeZ91zRrVysbKn9oD1I09zE2X
        cdeJFDMej5WXnMOO3brHaE8NmiLPyafepUyt4+LueXsZGWtw+yO1nPvBVMVZDB4P
        lSPw4dUNsEpjTYNZpTx4jvfqqiZ9f0M662MmxejTE0BwX9bPYS+rYVRHZsYdZwYv
        uYR7CxAHx8tcAaiP2Z/uUT98vS7kLVsT9YdBA3MA8rzK4FZO+vQ22M4aKsWF3pNQ
        ==
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by mx0a-0014ca01.pphosted.com (PPS) with ESMTPS id 3u5jgsewv9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Nov 2023 09:38:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hKP2OBd7sZiKDqB51M+uWD/5/sjjlVMOFR0joIw2NYPVwiG2GBH8Bwu1VLPqyCX4g+VguMffoxXDN7n/s8ugVaWA3egShydqy6x6o8kldpRnBPbUKuwjMQcjUyIych+vHnHlqj0bdKh5ei9TVwPGS8kH+Dbyhc+wbCXYQWUkB8dEmDbYWQvr7SncjfuOHDBq3XBBi3m/DtkuDPZMoYxOFj7buBfvEp+/I/0GMyYupZWOSwEwRiA7D67tvxI8zsay+y9ZaewPEnVpJyEk5azWeAvM9vu4+gBdXeU7TSlHWdpsMst0tgeExJjua37l0PecLbPz+lHGJQGa4XY7sMvvvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bM3emne8aZofXYNPRzpzPf1uwjrMSPbJCRQrESdcHNo=;
 b=Xm1XO73hDjtlY63cz66vwwmhs0/k+XV3qHFAwDhuVVx66B/zwHGAM1v4sCFHkqhg74Fus/qeNuIF/Qpr9+NoJZ+g5XvA6LYLkiZN0+3VeHKoz47wV1CCK/NQ4J6TvTaCmkBXoIaSr9eQU3Dj0+Hq+6f87+hQAhmwsN+SszGaEmLK2Hk71pfOT2fvkiYpCizILR+mU0XDDyCLSIp19ymzH5XAT6telhEhI22TQ1g7bKidIsarfj4ZUyzexdxXc2Ur2HwDoA6pOjEUlYYrsfjFHTKp4AAFVHBBGvUYVy/fiDoJZBX+zBFSlD2rIc2nb2T/lz1nXhPblGsNVex0RARgqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 158.140.1.147) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=cadence.com; dmarc=temperror action=none
 header.from=cadence.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bM3emne8aZofXYNPRzpzPf1uwjrMSPbJCRQrESdcHNo=;
 b=V+1HK+fSKmHQ+1Dw8XZQw7FW4y7+/wxlDraLImj2y2OmokjAfTKaA7DadxnSLvbOjL87SLyximVHKnJ/qpSgnSLlwnejoNy3VhtkYX/EOMeGUeDVFIe5Z/vrEYqVcebNAj1M2ptfjgemc64z+QBW8Sf4SyQs/3KLYGfINtRDinE=
Received: from DM6PR07CA0061.namprd07.prod.outlook.com (2603:10b6:5:74::38) by
 DM8PR07MB8934.namprd07.prod.outlook.com (2603:10b6:8:4::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6954.27; Mon, 6 Nov 2023 17:38:49 +0000
Received: from DM6NAM12FT116.eop-nam12.prod.protection.outlook.com
 (2603:10b6:5:74:cafe::1c) by DM6PR07CA0061.outlook.office365.com
 (2603:10b6:5:74::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.27 via Frontend
 Transport; Mon, 6 Nov 2023 17:38:49 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 158.140.1.147) smtp.mailfrom=cadence.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=cadence.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of cadence.com: DNS Timeout)
Received: from sjmaillnx1.cadence.com (158.140.1.147) by
 DM6NAM12FT116.mail.protection.outlook.com (10.13.179.102) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6977.17 via Frontend Transport; Mon, 6 Nov 2023 17:38:47 +0000
Received: from maileu5.global.cadence.com (eudvw-maileu5.cadence.com [10.160.110.202])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 3A6Hcjgg010867
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 Nov 2023 09:38:47 -0800
Received: from maileu4.global.cadence.com (10.160.110.201) by
 maileu5.global.cadence.com (10.160.110.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 6 Nov 2023 18:38:44 +0100
Received: from eu-cn01.cadence.com (10.160.89.184) by
 maileu4.global.cadence.com (10.160.110.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7
 via Frontend Transport; Mon, 6 Nov 2023 18:38:44 +0100
Received: from eu-cn01.cadence.com (localhost.localdomain [127.0.0.1])
        by eu-cn01.cadence.com (8.14.7/8.14.7) with ESMTP id 3A6HcOil400191;
        Mon, 6 Nov 2023 18:38:34 +0100
Received: (from pawell@localhost)
        by eu-cn01.cadence.com (8.14.7/8.14.7/Submit) id 39DCEuEE454577;
        Fri, 13 Oct 2023 14:14:56 +0200
From:   Pawel Laszczak <pawell@cadence.com>
To:     <peter.chen@kernel.org>
CC:     <gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <pawell@cadence.com>
Subject: [PATCH] usb:cdnsp: remove TRB_FLUSH_ENDPOINT command
Date:   Fri, 13 Oct 2023 14:14:44 +0200
Message-ID: <20231013121444.454292-1-pawell@cadence.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-CrossPremisesHeadersFilteredBySendConnector: maileu5.global.cadence.com
X-OrganizationHeadersPreserved: maileu5.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM12FT116:EE_|DM8PR07MB8934:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f5f1998-c1b7-4212-7acb-08dbdeef3b7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oMcl0kfF0nSmYiHZLjvhQ5oPt0VAAL11DhOdrYoFjWmCFiK+tXCar0Uv8+dG3efjGBdLZ6RbPhSKAuzOhLHccC/y6kUjVqiB29iLqy01Y4iT+Y7d/wrmyJM5mJpbA589w7K6c+s5AVF9k8zsGyQP7DEtF2qBrZs1zycnKvlaD3O5mNEMrUO9aZ6iR8KV28s0v8pcTeGVs/LpWx3yWMRxdXcKtW5o6QaeuMOU+Fv9H7/XYAjDHM909mjAQyFGu/2TIbFpQgD2OiwGSfShmZfilDQo6DuQhg91g0wSc+ctb/dvO2Dc7s9m62lT7qiUhYDTAu4osLrzH+0mYU7xZDN3MOz8UQshvYRVmtpn6YWi4LpDMErh7rMNDqyeg67J0d0N9O/xfvINtpZBM4FIDnuHyt6x46kWSOfz1u39Xn5hrzzqEhVACaAE5LkLFRyf7JesK1OMZeDah7nxYrxZcnU26/hXh2cD8d8s7E7YwnZSnEY1lJKZNxAIoMg9BPWn9gZ7H6MBeObJ14fD+XXtgVLxhNThJKSNW5CDGED+4LjdSWUbtYmrw7TGSr6Zg8HdgKKDNsQXgalbKiNQoNSpaZMEFsTOqc2xF7fjTdPWNisCfjQRXcJ5oSHb8NB7r1Vuvk15W7Fj5P/6Ynd+TGp7l+LNOvjrJj4/NByWHVe1pEVd0QLDEfsjGYOIAdW3rNMeCYVpsQBbIL3FjX486LU63QSbHhz0Z+O4oOv70bIbS8xN4KXLP+g5vwOS+DUwNwHsNgHM
X-Forefront-Antispam-Report: CIP:158.140.1.147;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx1.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(376002)(396003)(346002)(230922051799003)(186009)(64100799003)(82310400011)(1800799009)(451199024)(46966006)(36840700001)(40470700004)(2616005)(6666004)(478600001)(63350400001)(63370400001)(83380400001)(47076005)(26005)(107886003)(1076003)(336012)(426003)(2906002)(5660300002)(41300700001)(70586007)(70206006)(6916009)(316002)(4326008)(8936002)(8676002)(54906003)(42186006)(36860700001)(36756003)(356005)(86362001)(82740400003)(7636003)(40460700003)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2023 17:38:47.8461
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f5f1998-c1b7-4212-7acb-08dbdeef3b7b
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.147];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM12FT116.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR07MB8934
X-Proofpoint-ORIG-GUID: iKWCImVNWw1fFtWAd98ccFAUDd79YPv8
X-Proofpoint-GUID: iKWCImVNWw1fFtWAd98ccFAUDd79YPv8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-06_13,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 phishscore=0
 clxscore=1015 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 mlxscore=0 spamscore=0 mlxlogscore=760 malwarescore=0
 adultscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2310240000 definitions=main-2311060144
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch removes TRB_FLUSH_ENDPOINT command from driver.
This command is not supported by controller and
USBSSP returns TRB Error completion code for it.

Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
 drivers/usb/cdns3/cdnsp-debug.h  |  3 ---
 drivers/usb/cdns3/cdnsp-gadget.c |  6 +-----
 drivers/usb/cdns3/cdnsp-gadget.h |  5 -----
 drivers/usb/cdns3/cdnsp-ring.c   | 24 ------------------------
 4 files changed, 1 insertion(+), 37 deletions(-)

diff --git a/drivers/usb/cdns3/cdnsp-debug.h b/drivers/usb/cdns3/cdnsp-debug.h
index f0ca865cce2a..ad617b7455b9 100644
--- a/drivers/usb/cdns3/cdnsp-debug.h
+++ b/drivers/usb/cdns3/cdnsp-debug.h
@@ -131,8 +131,6 @@ static inline const char *cdnsp_trb_type_string(u8 type)
 		return "Endpoint Not ready";
 	case TRB_HALT_ENDPOINT:
 		return "Halt Endpoint";
-	case TRB_FLUSH_ENDPOINT:
-		return "FLush Endpoint";
 	default:
 		return "UNKNOWN";
 	}
@@ -328,7 +326,6 @@ static inline const char *cdnsp_decode_trb(char *str, size_t size, u32 field0,
 		break;
 	case TRB_RESET_EP:
 	case TRB_HALT_ENDPOINT:
-	case TRB_FLUSH_ENDPOINT:
 		ret = snprintf(str, size,
 			       "%s: ep%d%s(%d) ctx %08x%08x slot %ld flags %c",
 			       cdnsp_trb_type_string(type),
diff --git a/drivers/usb/cdns3/cdnsp-gadget.c b/drivers/usb/cdns3/cdnsp-gadget.c
index 4b67749edb99..4a3f0f958256 100644
--- a/drivers/usb/cdns3/cdnsp-gadget.c
+++ b/drivers/usb/cdns3/cdnsp-gadget.c
@@ -1024,10 +1024,8 @@ static int cdnsp_gadget_ep_disable(struct usb_ep *ep)
 	pep->ep_state |= EP_DIS_IN_RROGRESS;
 
 	/* Endpoint was unconfigured by Reset Device command. */
-	if (!(pep->ep_state & EP_UNCONFIGURED)) {
+	if (!(pep->ep_state & EP_UNCONFIGURED))
 		cdnsp_cmd_stop_ep(pdev, pep);
-		cdnsp_cmd_flush_ep(pdev, pep);
-	}
 
 	/* Remove all queued USB requests. */
 	while (!list_empty(&pep->pending_list)) {
@@ -1424,8 +1422,6 @@ static void cdnsp_stop(struct cdnsp_device *pdev)
 {
 	u32 temp;
 
-	cdnsp_cmd_flush_ep(pdev, &pdev->eps[0]);
-
 	/* Remove internally queued request for ep0. */
 	if (!list_empty(&pdev->eps[0].pending_list)) {
 		struct cdnsp_request *req;
diff --git a/drivers/usb/cdns3/cdnsp-gadget.h b/drivers/usb/cdns3/cdnsp-gadget.h
index e1b5801fdddf..dbee6f085277 100644
--- a/drivers/usb/cdns3/cdnsp-gadget.h
+++ b/drivers/usb/cdns3/cdnsp-gadget.h
@@ -1128,8 +1128,6 @@ union cdnsp_trb {
 #define TRB_HALT_ENDPOINT	54
 /* Doorbell Overflow Event. */
 #define TRB_DRB_OVERFLOW	57
-/* Flush Endpoint Command. */
-#define TRB_FLUSH_ENDPOINT	58
 
 #define TRB_TYPE_LINK(x)	(((x) & TRB_TYPE_BITMASK) == TRB_TYPE(TRB_LINK))
 #define TRB_TYPE_LINK_LE32(x)	(((x) & cpu_to_le32(TRB_TYPE_BITMASK)) == \
@@ -1539,8 +1537,6 @@ void cdnsp_queue_configure_endpoint(struct cdnsp_device *pdev,
 void cdnsp_queue_reset_ep(struct cdnsp_device *pdev, unsigned int ep_index);
 void cdnsp_queue_halt_endpoint(struct cdnsp_device *pdev,
 			       unsigned int ep_index);
-void cdnsp_queue_flush_endpoint(struct cdnsp_device *pdev,
-				unsigned int ep_index);
 void cdnsp_force_header_wakeup(struct cdnsp_device *pdev, int intf_num);
 void cdnsp_queue_reset_device(struct cdnsp_device *pdev);
 void cdnsp_queue_new_dequeue_state(struct cdnsp_device *pdev,
@@ -1574,7 +1570,6 @@ void cdnsp_irq_reset(struct cdnsp_device *pdev);
 int cdnsp_halt_endpoint(struct cdnsp_device *pdev,
 			struct cdnsp_ep *pep, int value);
 int cdnsp_cmd_stop_ep(struct cdnsp_device *pdev, struct cdnsp_ep *pep);
-int cdnsp_cmd_flush_ep(struct cdnsp_device *pdev, struct cdnsp_ep *pep);
 void cdnsp_setup_analyze(struct cdnsp_device *pdev);
 int cdnsp_status_stage(struct cdnsp_device *pdev);
 int cdnsp_reset_device(struct cdnsp_device *pdev);
diff --git a/drivers/usb/cdns3/cdnsp-ring.c b/drivers/usb/cdns3/cdnsp-ring.c
index 07f6068342d4..af981778382d 100644
--- a/drivers/usb/cdns3/cdnsp-ring.c
+++ b/drivers/usb/cdns3/cdnsp-ring.c
@@ -2123,19 +2123,6 @@ int cdnsp_cmd_stop_ep(struct cdnsp_device *pdev, struct cdnsp_ep *pep)
 	return ret;
 }
 
-int cdnsp_cmd_flush_ep(struct cdnsp_device *pdev, struct cdnsp_ep *pep)
-{
-	int ret;
-
-	cdnsp_queue_flush_endpoint(pdev, pep->idx);
-	cdnsp_ring_cmd_db(pdev);
-	ret = cdnsp_wait_for_cmd_compl(pdev);
-
-	trace_cdnsp_handle_cmd_flush_ep(pep->out_ctx);
-
-	return ret;
-}
-
 /*
  * The transfer burst count field of the isochronous TRB defines the number of
  * bursts that are required to move all packets in this TD. Only SuperSpeed
@@ -2465,17 +2452,6 @@ void cdnsp_queue_halt_endpoint(struct cdnsp_device *pdev, unsigned int ep_index)
 			    EP_ID_FOR_TRB(ep_index));
 }
 
-/*
- * Queue a flush endpoint request on the command ring.
- */
-void  cdnsp_queue_flush_endpoint(struct cdnsp_device *pdev,
-				 unsigned int ep_index)
-{
-	cdnsp_queue_command(pdev, 0, 0, 0, TRB_TYPE(TRB_FLUSH_ENDPOINT) |
-			    SLOT_ID_FOR_TRB(pdev->slot_id) |
-			    EP_ID_FOR_TRB(ep_index));
-}
-
 void cdnsp_force_header_wakeup(struct cdnsp_device *pdev, int intf_num)
 {
 	u32 lo, mid;
-- 
2.25.1

