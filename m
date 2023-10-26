Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54A797D7EA6
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 10:41:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbjJZIk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 04:40:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234854AbjJZIkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 04:40:47 -0400
X-Greylist: delayed 3737 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 26 Oct 2023 01:40:44 PDT
Received: from mx0a-0014ca01.pphosted.com (mx0a-0014ca01.pphosted.com [208.84.65.235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76D3E128;
        Thu, 26 Oct 2023 01:40:44 -0700 (PDT)
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 39Q2MN79017651;
        Thu, 26 Oct 2023 00:38:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding:content-type; s=proofpoint; bh=bM3emn
        e8aZofXYNPRzpzPf1uwjrMSPbJCRQrESdcHNo=; b=h2/iaBko5o8fYOiVP6PB3E
        dO+sXyw1gM6AHyH/lhSPhY74QTc128aknAV+2s6RRsPCpLWAzoSNnFmPiasO8n44
        KIvuUH+a+mW0UOfYLaNFZ7BYeuUE6Kqonu4UMmDrHqDNDz+oF5W7PNME3W3L/i0U
        +yMs3iQPfrPxUxxap1JMt0+SyJvBGh0msvBHAFLICujx++l4gHqmrdIk/VD8Ogo4
        +JQV7yPLcPKdDvn/498Jqeihfv5M/bkJgHaWAPAZH2p9Wxe3xlUijCofKCDLLJxi
        OXzZ4Q0kYAOXaprPDkJ8uo4jeGpfARuVqiJJckHGsos2yJdpEUTHRTZ1Xhwirt0Q
        ==
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by mx0a-0014ca01.pphosted.com (PPS) with ESMTPS id 3ty71qtskt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Oct 2023 00:38:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AfO8grevam28HTSqjgNccd+qhz/+y4rNv7kZoW/CiWGjQ0LyiVrSFVj0ORga8d7bpJ/+gXfySy7bnq8W40Kx0IWYK3nfh3bqGjYom9vYIgOQIA/odJqiN8OCW4N5aAmm1rsOjXP3E6No2hih9E7o2VpaALa65Z3EduEI6e57ruc/VKqnTzkbXfi/pUX0/uzezUgSAWtoS5vXphIsFQsHv1YZoBwMHTiqpdpXdujhbntFd3LxwViw6DRpi3gCrRaxzIbMPp+vTz0kC/SeQorvWKVDbdSw0DKWVZFf4Xds3xnsKVVJKw7k/XMpgQUnLXYKXta/WAiZ4UqyGYAl47KmFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bM3emne8aZofXYNPRzpzPf1uwjrMSPbJCRQrESdcHNo=;
 b=WwF50+ZLWvNw3dojbcYJnket7mKOgU9a/lfM7w9HPJdgerkpgJrI5JAws3MF62OEcu3AvJl0oEy+2mvh2T3gaT90T/TuRTacwdG4EFjxcvlmAJFDc8HHOTTPWmexEzKRt9l1aA9xt4M26FB0zG8OyhfTRFf5kraoTsc7d1+ltnBbk75CfR+2A/v7t6kxvn7nvnn5Dht7QPu67I9pXIfSX9WO0qQUJ5dXGYjw1fiV3KFlTXpzjrHTgElZ6T/DLzIh/cdsUEogQgnFLBSZA1xjfG8QgD45myl9KNsDBSEIilWc/+OKQ9VoHlF/7inp5x3mS94nc3+ebAo8iXS1aie9Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.148) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bM3emne8aZofXYNPRzpzPf1uwjrMSPbJCRQrESdcHNo=;
 b=VugabbZdHEf7Tu6NTtYpThaSX+hK8ni8ownejJNX+JMeqr/OpiiZY4xvMGNcvKWWJ3ur+uaTSaqBZGZPdSMU9Zbs1woT0rsy98dhoiU+covJZnN//Agx990t/VJoW2GpQnPB3f+pmueu0X69tKiUAbED+e+QsdxRVPIPfwr2cPI=
Received: from MW4PR04CA0381.namprd04.prod.outlook.com (2603:10b6:303:81::26)
 by PH7PR07MB9774.namprd07.prod.outlook.com (2603:10b6:510:2b2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Thu, 26 Oct
 2023 07:38:13 +0000
Received: from MW2NAM12FT114.eop-nam12.prod.protection.outlook.com
 (2603:10b6:303:81:cafe::d4) by MW4PR04CA0381.outlook.office365.com
 (2603:10b6:303:81::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19 via Frontend
 Transport; Thu, 26 Oct 2023 07:38:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.148)
 smtp.mailfrom=cadence.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.148 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.148; helo=sjmaillnx2.cadence.com; pr=C
Received: from sjmaillnx2.cadence.com (158.140.1.148) by
 MW2NAM12FT114.mail.protection.outlook.com (10.13.180.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6954.8 via Frontend Transport; Thu, 26 Oct 2023 07:38:12 +0000
Received: from maileu5.global.cadence.com (eudvw-maileu5.cadence.com [10.160.110.202])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id 39Q7c95c015400
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Oct 2023 00:38:10 -0700
Received: from maileu4.global.cadence.com (10.160.110.201) by
 maileu5.global.cadence.com (10.160.110.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 26 Oct 2023 09:37:57 +0200
Received: from eu-cn02.cadence.com (10.160.89.185) by
 maileu4.global.cadence.com (10.160.110.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7
 via Frontend Transport; Thu, 26 Oct 2023 09:37:57 +0200
Received: from eu-cn02.cadence.com (localhost.localdomain [127.0.0.1])
        by eu-cn02.cadence.com (8.14.7/8.14.7) with ESMTP id 39Q7blje165614;
        Thu, 26 Oct 2023 09:37:47 +0200
Received: (from pawell@localhost)
        by eu-cn02.cadence.com (8.14.7/8.14.7/Submit) id 39Q7bkVq165607;
        Thu, 26 Oct 2023 09:37:46 +0200
From:   Pawel Laszczak <pawell@cadence.com>
To:     <peter.chen@kernel.org>
CC:     <gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <pawell@cadence.com>
Subject: [PATCH] usb:cdnsp: remove TRB_FLUSH_ENDPOINT command
Date:   Thu, 26 Oct 2023 09:37:37 +0200
Message-ID: <20231026073737.165450-1-pawell@cadence.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-CrossPremisesHeadersFilteredBySendConnector: maileu5.global.cadence.com
X-OrganizationHeadersPreserved: maileu5.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2NAM12FT114:EE_|PH7PR07MB9774:EE_
X-MS-Office365-Filtering-Correlation-Id: b9e07917-c413-4ef9-1b13-08dbd5f68207
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JHAJ7rE8UGnrRvPMs4Y3LXRdqcEk2n/NNE+f6EWVbZPlhURW5YVTHvR9HgiD4L4e33KPs/p12XQVDCYfoUYr2Vvim60mhfWVuxZm6mb7lgXLz6g8V+qZAgKBu2Wo3CZxKYeOhRx/+g8Mz2eM/5JbWRzXtdt9F2o6eMy+n9yb7moovyxzvaovNwAsfYNQCApcyXtTg+B0dW0cTLbmfi8RTvhawqg7fNxffENeAieIfMNq2Sh6waybJmv/61wo0xT4isHiA/0Z10BnBrOUnpctuck0EDJmlqvFYc99KKS7ALQXb6EBefzFxTr4+3SPmaaAgGkf5C4JmEUiQUN5LDuLQHHhe3QYj2QyHB00oU4k7Oi90TkVTej9/GV9k6Q8I2KLR14/UZPjeQ5vcYc0h/YYPKPhXgX3rlTo1/jVHxEFFv69SgT4v+75tmZpmKfxwLuDqIv9vIn9EVzBWhZyOlNbwgesoLIqThQsF19UlJ1B7jzuXsYHPiY9h+qeQfZnjFw8k5FKTAijOiGBHYNft3rSS/I4gQCraRJnPzPKsNDl9rImAp7r+ePsE5zNg0xlBkHYqrfhTDjrS9Ry2txCmC/7GERTFzFTbuyOqDQAFucD3gItP2DoMCmCB9yQJH/QzqWK/MNzE2c4Gi1yslTmoqQ/HlGpeg+FmPFyG+Ot7z/UxOGZW4vJHZrkRq/PDmGbiBKkflFMsM2qKRcZUZKNofY4pCBKDwfuW4CgNXr9ysuDY8EpIYX5qOZolewSrmXwmN9r56GI/XEhrG7KACnLojtDNQ==
X-Forefront-Antispam-Report: CIP:158.140.1.148;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx2.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(136003)(396003)(346002)(230922051799003)(64100799003)(82310400011)(1800799009)(451199024)(186009)(40470700004)(36840700001)(46966006)(26005)(478600001)(34070700002)(1076003)(426003)(336012)(40480700001)(6666004)(86362001)(316002)(6916009)(42186006)(54906003)(40460700003)(70586007)(70206006)(36756003)(36860700001)(47076005)(2616005)(107886003)(356005)(7636003)(2906002)(83380400001)(8676002)(4326008)(8936002)(82740400003)(5660300002)(41300700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 07:38:12.2606
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9e07917-c413-4ef9-1b13-08dbd5f68207
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.148];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: MW2NAM12FT114.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR07MB9774
X-Proofpoint-GUID: pZFoR2qRg7biND93chPKduA0HtlCkXjW
X-Proofpoint-ORIG-GUID: pZFoR2qRg7biND93chPKduA0HtlCkXjW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-26_05,2023-10-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 impostorscore=0
 malwarescore=0 suspectscore=0 clxscore=1011 spamscore=0 mlxscore=0
 lowpriorityscore=0 adultscore=0 mlxlogscore=747 bulkscore=0
 priorityscore=1501 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2310170000 definitions=main-2310260063
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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

