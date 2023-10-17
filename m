Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 504057E2B0D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 18:39:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231822AbjKFRjE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 12:39:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231434AbjKFRjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 12:39:02 -0500
Received: from mx0a-0014ca01.pphosted.com (mx0a-0014ca01.pphosted.com [208.84.65.235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFE39B7;
        Mon,  6 Nov 2023 09:38:58 -0800 (PST)
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3A6DZqkf010888;
        Mon, 6 Nov 2023 09:38:57 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding:content-type; s=proofpoint; bh=bM3emn
        e8aZofXYNPRzpzPf1uwjrMSPbJCRQrESdcHNo=; b=PEoxXRZVqf6gWYePtkiig8
        N59tm8/92zDJxb9PFnHup6SzZVvxwxg2gL2KD33PuGz4STzUF1y4ONFo8ZtHjTpV
        AGSbnJhMnDGiiulu0mK0fqZx958hOormVDGYrfeQlWuprKifhGu8dVjb5EL3KXUp
        Sr0+8S35vJcTZx0nV3uVC6CbfUwF+m7BEheHqZAbT8q/6qcrQ5rOWW1E6pnd4hdz
        shOOTgwFwYou6pL9oij80/nQLrTHz4odTIVPgmmzF+1M+HngdD0jIGvPd2JGifFq
        nJxGfHlO/1/ttEGkngsjawvs2po00nJ2O+1oUfHP0M9D74svktvK+aq0zjrNHZmA
        ==
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by mx0a-0014ca01.pphosted.com (PPS) with ESMTPS id 3u5jgsewuk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Nov 2023 09:38:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mF5RRuGXkcNN7xXiV/Sx+r63q6ke2TNZpNF6J6gXYyQmx72cPz1a3EIxq7WxL8i7XVwZCWeZcsD7DymSc1lMFBjkiib+ly0ClKMdMAJRIHCx5s9iN+IRKMaggDN7Ibw9WS6M2X5joEhvdZ2f+hfTENizWfALilCTlqxIH8Wr/ODGuvtpfcHtMqUjoNWNimiIU5JDSiPQe3MhK7vOAK/H1VgVvijGwxScaGDswavm/+isF/YLnTfIMnL4QyFEwbolHXPKwFMu3r5NqVFP6oq6SVNDW/58bUlTYakYdTMG6029TFbzv5qhOZYlvQCU9i/VYzhvqZVkAy51V9FE73cSag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bM3emne8aZofXYNPRzpzPf1uwjrMSPbJCRQrESdcHNo=;
 b=EfN1yzc/McxjT/Tdj/+xo3DvUdWvD2JPdESkMqwbJXzQMw5B8N1au0/gjh16GexI5MPSzapTMKPhSARLZ6GpDljAlTDTWqAm6DfxfkjxIfpheAc2Vkp0RwqURmV1bm8h3ZSYI8Xk7b16ZwDMkPaZ2rgAwGZtYpxMjXLCHBkmIquZt1umwmzo7ZqQxc4hGETjlQY9/U1Iqw4XLRHqd1CSrd21f91U6N72ROxREymBUGbsYbx+ZNVCbCaX0YJP7eefsoL0V7QZ4Y/TcSlcYxvzwsxTsFTfcA+aZ4qM81nwbymo7CBE6Ji/H/o0Ld5YFLqgkmR2isyCwSkzeFd2QiZWXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 64.207.220.244) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=cadence.com; dmarc=temperror action=none
 header.from=cadence.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bM3emne8aZofXYNPRzpzPf1uwjrMSPbJCRQrESdcHNo=;
 b=VI+zli8PSGBcqI33zaUWjxtQGiv/bKKFZWkfgGEcmalkyRQpDVUT0psC/gi7M0RqdoaYkoGRrQPKl+Dt+2M7Hwt04V/4cTcvqu5XfaTSnC9gBTwwCVkdRd/ljQFh7xLC0mSsR2OgX7VoPolw3EZSnS4GK229BlpgFSJif1nnGAM=
Received: from BN9PR03CA0751.namprd03.prod.outlook.com (2603:10b6:408:13a::6)
 by CH0PR07MB8346.namprd07.prod.outlook.com (2603:10b6:610:c3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Mon, 6 Nov
 2023 17:38:39 +0000
Received: from BN8NAM12FT111.eop-nam12.prod.protection.outlook.com
 (2603:10b6:408:13a:cafe::2f) by BN9PR03CA0751.outlook.office365.com
 (2603:10b6:408:13a::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28 via Frontend
 Transport; Mon, 6 Nov 2023 17:38:38 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 64.207.220.244) smtp.mailfrom=cadence.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=cadence.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of cadence.com: DNS Timeout)
Received: from wcmailrelayl01.cadence.com (64.207.220.244) by
 BN8NAM12FT111.mail.protection.outlook.com (10.13.182.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6977.10 via Frontend Transport; Mon, 6 Nov 2023 17:38:37 +0000
Received: from maileu5.global.cadence.com (eudvw-maileu5.cadence.com [10.160.110.202])
        by wcmailrelayl01.cadence.com (8.14.7/8.14.4) with ESMTP id 3A6HcZ5q117610
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Mon, 6 Nov 2023 09:38:36 -0800
Received: from maileu4.global.cadence.com (10.160.110.201) by
 maileu5.global.cadence.com (10.160.110.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 6 Nov 2023 18:38:34 +0100
Received: from eu-cn01.cadence.com (10.160.89.184) by
 maileu4.global.cadence.com (10.160.110.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7
 via Frontend Transport; Mon, 6 Nov 2023 18:38:34 +0100
Received: from eu-cn01.cadence.com (localhost.localdomain [127.0.0.1])
        by eu-cn01.cadence.com (8.14.7/8.14.7) with ESMTP id 3A6HcOid400191;
        Mon, 6 Nov 2023 18:38:29 +0100
Received: (from pawell@localhost)
        by eu-cn01.cadence.com (8.14.7/8.14.7/Submit) id 39H7eTUF353314;
        Tue, 17 Oct 2023 09:40:29 +0200
From:   Pawel Laszczak <pawell@cadence.com>
To:     <gregkh@linuxfoundation.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <pawell@cadence.com>
Subject: [PATCH] usb:cdnsp: remove TRB_FLUSH_ENDPOINT command
Date:   Tue, 17 Oct 2023 09:40:18 +0200
Message-ID: <20231017074018.353205-1-pawell@cadence.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-CrossPremisesHeadersFilteredBySendConnector: maileu5.global.cadence.com
X-OrganizationHeadersPreserved: maileu5.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM12FT111:EE_|CH0PR07MB8346:EE_
X-MS-Office365-Filtering-Correlation-Id: 72578b14-abe2-4148-f36f-08dbdeef352d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0KNopJkgjLmCButftImxtZ67rODTFwK4WkZZNhTLN04z94d3wzk86MrwM2VLhA0Ds6Tswpqyh9xXiWec6dliR1/Tf/frbvx0xOKw/tbDegWJe4i+JV3lqps0qNeqY0lwz2miEIAtVyV3pl/eyvXKNT5mV46FrNBR+fck685TM7IdHlYYHvoLxwXRSawg0D2Gf8kbFUQ2JCZ5XVlQxd2WLmxnjg43uM46Yx2dSN1ozJm3Xm8HsZhrWcWV7JaZM0r633QhnEDbMVdChvvBbm2p8+ivoA/tUo6xsb4jy7oEKGsZuQijl8aVV58LVXaThPPuQ2Le14GV6ndyaufz1natAiHmAMqikxk7H1KJxmxSLEM0AFmIO1PUfXYmFLG36D/m/S1Scw8FWzMVHieL+LPDI+HLwyj/jzUexRAuXOYmkcywGHQVF47usXK3KcGeXcHeAW9c8pTXhdmLATYrv1hCAxbc7WtM077aK+xoPrBHCs8BvE9v5TSyVJ3saTfwbUnXmW+9NceC27IRvDEy1LJjOSi2oYiC4es07IL2PopsYSDhNVVkEtx11T7vQnHtviJQBK8W0HwDjRUO/t7z6wNPTQmwXUOv1HDfkcPgAUqH/CpTGQYomOAmSoj4RvjOVe8Z2ueivKBVxhI9HBv9CyPDQ18WDnkXa3lge7W0a/Z3T32oVae55HoFFWF3XGhD3kkUpA3aef6EjyeHUAEgwdUwWqWNTMKwuSndDg68fHHWuGRx+O5ReRDdQbA2/VixVEp1A+JR0lIP7qdCfnfIYJqpGQ==
X-Forefront-Antispam-Report: CIP:64.207.220.244;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:wcmailrelayl01.cadence.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230031)(4636009)(346002)(39860400002)(396003)(136003)(376002)(230922051799003)(82310400011)(64100799003)(186009)(1800799009)(451199024)(46966006)(36840700001)(40470700004)(336012)(426003)(2616005)(81166007)(63370400001)(83380400001)(63350400001)(6666004)(107886003)(82740400003)(26005)(1076003)(40480700001)(478600001)(47076005)(356005)(36860700001)(70586007)(70206006)(8936002)(8676002)(316002)(6916009)(54906003)(42186006)(4326008)(5660300002)(86362001)(2906002)(41300700001)(36756003)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2023 17:38:37.2404
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72578b14-abe2-4148-f36f-08dbdeef352d
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[64.207.220.244];Helo=[wcmailrelayl01.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM12FT111.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR07MB8346
X-Proofpoint-ORIG-GUID: wTw4LCvPf3uCrUo1ll_93drv2ETyr0_0
X-Proofpoint-GUID: wTw4LCvPf3uCrUo1ll_93drv2ETyr0_0
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

