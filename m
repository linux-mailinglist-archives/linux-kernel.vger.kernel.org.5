Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6FE27E2B10
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 18:39:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231921AbjKFRjJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 12:39:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231496AbjKFRjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 12:39:03 -0500
Received: from mx0a-0014ca01.pphosted.com (mx0a-0014ca01.pphosted.com [208.84.65.235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3352ED47;
        Mon,  6 Nov 2023 09:39:01 -0800 (PST)
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3A6DZqkg010888;
        Mon, 6 Nov 2023 09:38:58 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding:content-type; s=proofpoint; bh=bM3emn
        e8aZofXYNPRzpzPf1uwjrMSPbJCRQrESdcHNo=; b=Xnis9nx8sjmPzui0H7MqOI
        ii75+t33NM+L7ZSN6dbwV0xysk+VTN04Z39ZhP8+Yh9Xh74trXiH1DGCjw0BzA/M
        lYgw4qbhVvtFtHOltEtA94fV/MfqQ48OWlbR1Q17B/SQcbFJtu4UKDRnnAMBCpEb
        STYL8m4tF/e9AnRbNG9Tb/ibbQEG9a5xR20q+oqhmUp3IB5VG6ykCSsF8MhXR4Vk
        7+tuel8eUbfoODIbyd+gcLosSlWbS2OZHTxBUDuQq+Nq9rvT+rNvE2RYWfIqySU5
        qCpR4F00zMkog7z5j70TS040hiSvvowy9rTFpGd2ndIc0OfKtBsptpBpDK7TbMkQ
        ==
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2040.outbound.protection.outlook.com [104.47.57.40])
        by mx0a-0014ca01.pphosted.com (PPS) with ESMTPS id 3u5jgsewv6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Nov 2023 09:38:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H04gEcbkyi91jKQltY8vnOnONPlpU56plLcQKn3VHYVIG4fyC26ZqMxYu0g/rzkiWxoiUFzvlkBo996O3jQQDYI6NJy40Gl5OoZBVPp+OOS6Q47n3hGTTK+OSaPg6FRMmFPySUNk4eWh6JNyuhBURoZijRsf92vWAJygKP+fRj4SlL9C9CcWAMe8BgnZZ0KL2bxnFIL8zc+IvO8j31SWXqzO3WW4uRU+fnEff4MT9DLwjMJmZWML++noIxYqZY/wOozy38EJDZ39z/kpAAdGglStexs3+FxkHGLI7+2jaDBNzWuj+s+0SCyFisYubuxZayDtAXGrYscWf4mxGrbVtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bM3emne8aZofXYNPRzpzPf1uwjrMSPbJCRQrESdcHNo=;
 b=baMfMhsz4aShkTXOI+jl1K6UByeOzO6bWuJDvjS/4e9tILYJE1z6F/X1dWp1FLN2Ocdf7rOmj3Dh4yENT3WA/Iw+h/NzLztKSWIL6eoMyafio6M4TMJgpjik7sUe5n/dAL7N5qDO+5lyG07tszxJnvg4C6GImUcrUgF9mF/ep+4Chfldl9PLgLlZm7tEHIAu+YdZ48KykcNlu/HbaVEs372QHWeQbDw+qz2Ex6tTVEPdbFJ2vjmcoG7O0bogkZh6dkU4Hboh1hxf2yH3MRRDM6BSxZd2q4mHBXh+Qmf5c6JNPQlu9xN1Jd2EoPUtg20Cf9zk3mqiX0Rfsv0LmxnOwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.147) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bM3emne8aZofXYNPRzpzPf1uwjrMSPbJCRQrESdcHNo=;
 b=Elzp3cR9JkO4poOfSAqEMCsiqqiITQ+IlvHuoYQeo9uh9LbnF1ZmFWOpYjE2tdpURYaRqvjUn5H4oUwmRoU6IsaQcsuVM7+RZDtlASIyaWBWmnw8zC05Nvj01XKApYEO8nEkOdDSbv0j9hfuYYUbB4VOqjTqXnjIuLGXVdojqr8=
Received: from SJ0PR13CA0173.namprd13.prod.outlook.com (2603:10b6:a03:2c7::28)
 by SA0PR07MB7580.namprd07.prod.outlook.com (2603:10b6:806:bb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Mon, 6 Nov
 2023 17:38:48 +0000
Received: from MW2NAM12FT018.eop-nam12.prod.protection.outlook.com
 (2603:10b6:a03:2c7:cafe::5c) by SJ0PR13CA0173.outlook.office365.com
 (2603:10b6:a03:2c7::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.16 via Frontend
 Transport; Mon, 6 Nov 2023 17:38:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.147)
 smtp.mailfrom=cadence.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.147 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.147; helo=sjmaillnx1.cadence.com; pr=C
Received: from sjmaillnx1.cadence.com (158.140.1.147) by
 MW2NAM12FT018.mail.protection.outlook.com (10.13.180.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6954.16 via Frontend Transport; Mon, 6 Nov 2023 17:38:47 +0000
Received: from maileu5.global.cadence.com (eudvw-maileu5.cadence.com [10.160.110.202])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 3A6Hcjgf010867
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 Nov 2023 09:38:46 -0800
Received: from maileu4.global.cadence.com (10.160.110.201) by
 maileu5.global.cadence.com (10.160.110.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 6 Nov 2023 18:38:44 +0100
Received: from eu-cn01.cadence.com (10.160.89.184) by
 maileu4.global.cadence.com (10.160.110.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7
 via Frontend Transport; Mon, 6 Nov 2023 18:38:44 +0100
Received: from eu-cn01.cadence.com (localhost.localdomain [127.0.0.1])
        by eu-cn01.cadence.com (8.14.7/8.14.7) with ESMTP id 3A6HcOij400191;
        Mon, 6 Nov 2023 18:38:34 +0100
Received: (from pawell@localhost)
        by eu-cn01.cadence.com (8.14.7/8.14.7/Submit) id 39C4lIv8293620;
        Thu, 12 Oct 2023 06:47:18 +0200
From:   Pawel Laszczak <pawell@cadence.com>
To:     <peter.chen@kernel.org>
CC:     <gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <pawell@cadence.com>
Subject: [PATCH] usb:cdnsp: remove TRB_FLUSH_ENDPOINT command
Date:   Thu, 12 Oct 2023 06:46:28 +0200
Message-ID: <20231012044628.293070-1-pawell@cadence.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-CrossPremisesHeadersFilteredBySendConnector: maileu5.global.cadence.com
X-OrganizationHeadersPreserved: maileu5.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2NAM12FT018:EE_|SA0PR07MB7580:EE_
X-MS-Office365-Filtering-Correlation-Id: f9e21436-736a-4823-3b69-08dbdeef3b46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hIQ09Onb4wcY5VVMpYIThOMWVrGwlMf/uvKy3lJLZTBx7o/kJoTD8oSuurnmMHh1YePZvp0IWwStnmfqHvEvzxjlhM/4/rd6QZY/BlOFyQ40AVEotHqNc6tuaRBXl06p5nhk72s3gBwwjLDihQxRnACU9jNrErL9AHQphZdl/DDd1VCUcT9YvQUtAs4j0n0ZpfkRsr78in3Odn0ebv0bNEmwsLOwwNzHXmRvblHXECO+a5CJ8wZQbd2ZYRHfCgNI0wpbky1Kk8lAHk1f+oKIKQB7HEml4e6xCYdSjvCIUvpaDJVV4rpdpwXhciuLrPhg4mLRhguCR0zX068a2f/8I0Dme5onar16P6OPfgLP7atJ5VpSJHSyi0RkhEOIgvzXeqyzW1IDABBIGgW4L8NU247r2Nw4iUvMcsKAWhVrmgN8K7f4x6j98dKTaTCQVuwN6vQXIZK2x5SkVhwVmWZgJPyrMzzDqGjGp2MUgR/Ia3wXB1Tq9VKEuBSTOH8GKjDZn+rqx4AT8Eh6mzZibuOrT3RN8jpASZ6twQ1ESd4pDhX9056iSbwLJ7BWMEVeOpnx3zYOQ02/UfXp/AUQfJsu0J9jZKR3FvV54MOaBU+AyUXmr3RFsm5sEauN1X5uIX45fLD48BaWxRmCl1RKskItvdTl493ikEaMFbche9JyLB1HCguxrzlIU086zO3MwJ6KeCbEZyBJ4aqgNSyp7gKzoE7PqJhLT2gzP1k3bKVhVZXGnhJaPox+Bktu6lJc2XNG
X-Forefront-Antispam-Report: CIP:158.140.1.147;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx1.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(136003)(376002)(396003)(230922051799003)(186009)(1800799009)(82310400011)(64100799003)(451199024)(40470700004)(46966006)(36840700001)(47076005)(36860700001)(83380400001)(356005)(6916009)(7636003)(82740400003)(6666004)(478600001)(426003)(70206006)(336012)(54906003)(26005)(42186006)(70586007)(2616005)(107886003)(1076003)(5660300002)(2906002)(8676002)(36756003)(4326008)(41300700001)(86362001)(8936002)(316002)(40480700001)(40460700003);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2023 17:38:47.5284
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9e21436-736a-4823-3b69-08dbdeef3b46
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.147];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: MW2NAM12FT018.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR07MB7580
X-Proofpoint-ORIG-GUID: BkHE_GEzj6s0sTODFnDGX8lsu_wwm4tF
X-Proofpoint-GUID: BkHE_GEzj6s0sTODFnDGX8lsu_wwm4tF
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

