Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E27E7E2B0F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 18:39:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231872AbjKFRjH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 12:39:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231364AbjKFRjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 12:39:02 -0500
Received: from mx0a-0014ca01.pphosted.com (mx0a-0014ca01.pphosted.com [208.84.65.235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0488D45;
        Mon,  6 Nov 2023 09:38:59 -0800 (PST)
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3A6DZoCV010865;
        Mon, 6 Nov 2023 09:38:56 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding:content-type; s=proofpoint; bh=bM3emn
        e8aZofXYNPRzpzPf1uwjrMSPbJCRQrESdcHNo=; b=dBdvsl9ZBn+DZiqQri5B76
        l57Z3vllGkT/OLqY9kCQyqckANru4qnAhyfdWYdZDNmkZf0LmETcRlKV+mFkShgL
        IR1Z+/P59pHONSN7bQd4FHdSH0VGv+ABtwURL5xXfQ0i9OQObpe7Hm3xcaB2LMsw
        rvDca8eto07lj6NgnWqvcxlMa6qYb4RU638PQVZExNzcm9wiOi3DXoSIbXnGg7nD
        eWs4iYbBLCAwsifSCh7Sh+JAVPckJhfFzSTNfQPTNcDIWEogoev5FMAc6GdyLSFX
        51/KDABwPwILsYMsNcUiTbANswjYSE6wRUw6buoz5JWpoSjPiugjzJaWRzwUpPkQ
        ==
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2168.outbound.protection.outlook.com [104.47.73.168])
        by mx0a-0014ca01.pphosted.com (PPS) with ESMTPS id 3u5jgsewv0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Nov 2023 09:38:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jId5T+cm1m5UkoLBv/iK9KSPOLogA5Ezeuy4Nw+74l8tQqpmGO831tPGoy3TJmWxjxNvpMukqT7Qh6GYZynvAHSj777pBBUrZMU/D23PZIIb3qCVC36U2MMohbXlGdqpb1v/JX0oDoykr4VJZrgN9k6uXwp72BjFXPhmMy1ZaBmz0YeT212v5kQc3EENFH6VmeaSA0qbg4V8duLPw47vKiJbmIVJq8PJy8Z5St4BAvATan02DdO7GnvHo9Rer/SYdX/ZXqY7zQVteiJDfIi9opX1F3aAe27XM2B16oAGRtySgL8XDaBytprc28iwx2meFhw8b1nOe/JyOEc2sZ1E1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bM3emne8aZofXYNPRzpzPf1uwjrMSPbJCRQrESdcHNo=;
 b=hyqgS7gVfLx+XyxuvZQ2ej4gLxVl0dwgJNrbALcYsZJfFDmrTEUMU/g68l/UEXK7kE+iCW8g8R9eC7i2UYLu8w7U5+yhWk36NtRqszLWlbMBzTK736DpGHOJ2uFzAR2BC0dVzlRowmgp7t+QYq1ZOdcZLV4zDAI/X92QBtTiMVmiqHO2SlsZ69IHeyCDItE2vj+jYfjNuTfBkrtxh1+tEaCtXgcp5XAvP3uG14XYYxE6a82VF/TmOvKsGU8pI8d4f+PifWUxKBKL5m6v+S9MdCqWcAnu3nXLnWco44Drri1HyJoTV8WV6aJzuVqjHhF7JYZHya17WuS5TOyN5j2SEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.148) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bM3emne8aZofXYNPRzpzPf1uwjrMSPbJCRQrESdcHNo=;
 b=dW7eyt6C1/1bUCF/+kYW++iq3MGn2mzQkmgrbHxH2cA4pCxKE/BJD6jtaXKbD5sj0tsPaXOK0+X5DVMlg8NaqIO4oDzGm88xIdoi9KG6bQj8umDtvKhDsN9gWAYvgRqCYLom9mLxjw4s49ZxYA/hgfNCN010VlAFVOJNCxDu5VQ=
Received: from DS7P222CA0029.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::28) by
 MW4PR07MB9323.namprd07.prod.outlook.com (2603:10b6:303:1b2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Mon, 6 Nov
 2023 17:38:43 +0000
Received: from DM6NAM12FT030.eop-nam12.prod.protection.outlook.com
 (2603:10b6:8:2e:cafe::a4) by DS7P222CA0029.outlook.office365.com
 (2603:10b6:8:2e::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28 via Frontend
 Transport; Mon, 6 Nov 2023 17:38:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.148)
 smtp.mailfrom=cadence.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.148 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.148; helo=sjmaillnx2.cadence.com; pr=C
Received: from sjmaillnx2.cadence.com (158.140.1.148) by
 DM6NAM12FT030.mail.protection.outlook.com (10.13.178.167) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6977.13 via Frontend Transport; Mon, 6 Nov 2023 17:38:42 +0000
Received: from maileu5.global.cadence.com (eudvw-maileu5.cadence.com [10.160.110.202])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id 3A6Hce2b018871
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 Nov 2023 09:38:41 -0800
Received: from maileu4.global.cadence.com (10.160.110.201) by
 maileu5.global.cadence.com (10.160.110.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 6 Nov 2023 18:38:39 +0100
Received: from eu-cn01.cadence.com (10.160.89.184) by
 maileu4.global.cadence.com (10.160.110.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7
 via Frontend Transport; Mon, 6 Nov 2023 18:38:39 +0100
Received: from eu-cn01.cadence.com (localhost.localdomain [127.0.0.1])
        by eu-cn01.cadence.com (8.14.7/8.14.7) with ESMTP id 3A6HcOih400191;
        Mon, 6 Nov 2023 18:38:34 +0100
Received: (from pawell@localhost)
        by eu-cn01.cadence.com (8.14.7/8.14.7/Submit) id 39KAPMUV090940;
        Fri, 20 Oct 2023 12:25:22 +0200
From:   Pawel Laszczak <pawell@cadence.com>
To:     <peter.chen@kernel.org>
CC:     <gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <pawell@cadence.com>
Subject: [PATCH] usb:cdnsp: remove TRB_FLUSH_ENDPOINT command
Date:   Fri, 20 Oct 2023 12:25:07 +0200
Message-ID: <20231020102507.90685-1-pawell@cadence.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-CrossPremisesHeadersFilteredBySendConnector: maileu5.global.cadence.com
X-OrganizationHeadersPreserved: maileu5.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM12FT030:EE_|MW4PR07MB9323:EE_
X-MS-Office365-Filtering-Correlation-Id: 4276c73b-1562-47c7-81dd-08dbdeef3888
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PZBEeSxY/NUD2v2nJ1UookGLv8Ft/0KbXmrT2zP7Rqn8V+PtQo2EqZklB1h2l1s0Ao4vcsKhVroo/7uVLBd6u5BG+cg5YZAaKW8w8DYBEU1UGWwzu4ujU1nnllydtEmzRgl7kG/8i/wsFrRBGAWst3Bya+xP6WxbL0DccIPY/t+IcpyX1BZPBz/9G+wXOhC12JzpkSxdbtTLGtbemZKMmj0PW6nAHkqpOqjg+qgORNm3d7Yt8uCriF3umnDigKIKfaNykeVWsPi8HKGF81w3vFlY2MUokaG9N0TCg8xkRlYQf8Ld4OMSS5whIUNTgbKYa6BcwkbQkVjJlfn5fXtCjNgJ2MBplJIkl/7McHDRjzizmejH7t9groNrr5YU32aGnUOueAVG3PaSJg6/cgGUYCKcDnHO9qdv8uHL2FQIGCjgqdvOGdlJXBuwQit0+tgRRUpzse5ZjOBPvgA6vBWPnOhEKpeoSrR6sRAXyWHvi097fPFW5j4brmOXbvPZWzJB8KGo3pLs9bY+rkQb8KbNDeB5NWVay4iTN7QYZoyQkUFPzA//4cJ3SIdgrzbL1t9Y5zyzJtHeRhbdnhO5kPEoof5Nyd0aVSq7p8lVuQWFwsbOCUKyw+DJ6rvtYdaMW62w4ok+MsvLkU0I2t+X5wlqn6ogV8PKgzEeuc753Z4Wbp4U1qCQq2gOiqaw98y0yMGXt0LrbFJkE4qqlDF1bElKQFr99PNtW4JosEnhC1Ow9Fr/rNx6VOLfqz0vkBR9DxQG
X-Forefront-Antispam-Report: CIP:158.140.1.148;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx2.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(13230031)(4636009)(346002)(39860400002)(136003)(396003)(376002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(82310400011)(46966006)(40470700004)(36840700001)(40480700001)(83380400001)(26005)(2616005)(478600001)(1076003)(336012)(426003)(107886003)(36756003)(40460700003)(82740400003)(356005)(86362001)(7636003)(2906002)(54906003)(36860700001)(6666004)(8676002)(42186006)(6916009)(8936002)(316002)(4326008)(47076005)(5660300002)(41300700001)(70206006)(70586007);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2023 17:38:42.9139
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4276c73b-1562-47c7-81dd-08dbdeef3888
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.148];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM12FT030.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR07MB9323
X-Proofpoint-ORIG-GUID: pcTeeBuA7q0SLODKEnukEG3n67xYhwUQ
X-Proofpoint-GUID: pcTeeBuA7q0SLODKEnukEG3n67xYhwUQ
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

