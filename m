Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26668751D9B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 11:43:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234512AbjGMJno (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 05:43:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234681AbjGMJnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 05:43:07 -0400
X-Greylist: delayed 1466 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 13 Jul 2023 02:41:44 PDT
Received: from mx0a-0014ca01.pphosted.com (mx0b-0014ca01.pphosted.com [208.86.201.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE90F2D43;
        Thu, 13 Jul 2023 02:41:44 -0700 (PDT)
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36D4Z12r016903;
        Thu, 13 Jul 2023 01:14:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=proofpoint;
 bh=UyfXsStPg3cp6IuL0Tabo3tg2yOR47bjz2DMdutvSBw=;
 b=VOt6nMbJuGIDmZq/lOW5erecpSmZOj5xIJ1Os/43I0E5c2Fp+ajtQ2zkHDPNv1RyOEN8
 xnkHFBVifwVuEaPs0IcBjJxSLFnexeDGHadieyFhPqzgxGNUQhNAJz26YI3aIx/tqo74
 Eq44LIY9mNP46Ec7TfSfHYih4lgUOBDObO68Y65duDZHEcLr9sSWi8784HSszGxoUmRf
 wKLlgBslWUvkiLdnwTLl/xN46HlaHuiknB5xR2kc5m76zuXSnvJXTDb3c9Ya/86w1FCT
 K+572ssElLFr3OndLWi1UwwLe0ZL+EtEmGLYnUX+QtZwwnkPEEEO2gtb+0zX84GPggIS GA== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2105.outbound.protection.outlook.com [104.47.70.105])
        by mx0b-0014ca01.pphosted.com (PPS) with ESMTPS id 3rt6c1sbah-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Jul 2023 01:14:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ku8OtkgF8aJNdVAgiWB5QYWg/GR1Dfta/dxamz9TgEgh0MkqiDCDNLPiZ51gcpowp22eUWYI1HUqgp21KORO2e1xneSzdWtAg2DpDKt8u+Dnen5UIjgNP2JMCo2ixtfK/w+c2gwbZFVnOAmTFNc8DK2FantZcr0twSkXbPNorXN6R41Y3kTCJNdvY0VDp1RFpU6Z1VdOBvlysVoZ5FH23a9KJV6/dz5GQgM+2p0aXebkDZxj+L6e/FBMswhUwqU5MYAi+RfHnZaAzKyhrQfIBvqSP6wkPNj+GtplJG5v19un7n69KeTY7VEucfIbRS6wkTo8INfSMx2j8BJOVdAyQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UyfXsStPg3cp6IuL0Tabo3tg2yOR47bjz2DMdutvSBw=;
 b=IuQsFvHnFhDn6zhL17IGQ+9nRHWTG9M9xUPzUedcMB+jTEt+H5Uk89BQsKbdNNs1kwqkLZfUIMHGWzN/RGD9/dXyPudqhrYdLYJW+uPDRw6ttFocJEH8ed/yXlQPtp65dGm0r4EHd//SRXiLEP7iX/XnCkO4wGSg5L8xWCxGAS/VDIfIchx4AIDU+WAjFuUdWao3uj0y+QoS2puMD6AxoBdYAw1mrtqd1rtEwWQbBmWr6qqB6NB6Fokzl99MuiBwpWugo3T8eZH5LTuKXpOTdF+1UXvvVOfByMLva34j+NV+VJIN0N2Jk8WLKVGZZ6Bwf0lAiHEc+x3ySBaM9pa1aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 64.207.220.244) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UyfXsStPg3cp6IuL0Tabo3tg2yOR47bjz2DMdutvSBw=;
 b=ZGuIxXk3yT7GjrxtgZaR+cny4wHOjCmRKydFH0mCpKKhqy9FBKUXMHkRIuPx3LuNe8yniwG7G4lqHlGynOPV7dSg5ixfStq2FyOVHWiLXSsgJXlGgVra79AW6SEQav0xhRFCapPu8gTkn4fVJ4NzosrFq8ywVWpRGA8B5DNdv6w=
Received: from DS7PR03CA0275.namprd03.prod.outlook.com (2603:10b6:5:3ad::10)
 by MN2PR07MB7135.namprd07.prod.outlook.com (2603:10b6:208:1a7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.24; Thu, 13 Jul
 2023 08:14:39 +0000
Received: from DM6NAM12FT044.eop-nam12.prod.protection.outlook.com
 (2603:10b6:5:3ad:cafe::43) by DS7PR03CA0275.outlook.office365.com
 (2603:10b6:5:3ad::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.24 via Frontend
 Transport; Thu, 13 Jul 2023 08:14:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 64.207.220.244)
 smtp.mailfrom=cadence.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 64.207.220.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.207.220.244; helo=wcmailrelayl01.cadence.com; pr=C
Received: from wcmailrelayl01.cadence.com (64.207.220.244) by
 DM6NAM12FT044.mail.protection.outlook.com (10.13.178.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6609.9 via Frontend Transport; Thu, 13 Jul 2023 08:14:37 +0000
Received: from maileu5.global.cadence.com (eudvw-maileu5.cadence.com [10.160.110.202])
        by wcmailrelayl01.cadence.com (8.14.7/8.14.4) with ESMTP id 36D8EY5m138529
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Thu, 13 Jul 2023 01:14:35 -0700
Received: from maileu5.global.cadence.com (10.160.110.202) by
 maileu5.global.cadence.com (10.160.110.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 13 Jul 2023 10:14:33 +0200
Received: from eu-cn02.cadence.com (10.160.89.185) by
 maileu5.global.cadence.com (10.160.110.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24 via Frontend Transport; Thu, 13 Jul 2023 10:14:33 +0200
Received: from eu-cn02.cadence.com (localhost.localdomain [127.0.0.1])
        by eu-cn02.cadence.com (8.14.7/8.14.7) with ESMTP id 36D8EXhP326761;
        Thu, 13 Jul 2023 04:14:33 -0400
Received: (from pawell@localhost)
        by eu-cn02.cadence.com (8.14.7/8.14.7/Submit) id 36D8EWiq326741;
        Thu, 13 Jul 2023 04:14:32 -0400
From:   Pawel Laszczak <pawell@cadence.com>
To:     <peter.chen@kernel.org>
CC:     <gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Pawel Laszczak <pawell@cadence.com>, <stable@vger.kernel.org>
Subject: [PATCH] usb: cdnsp: Fixes issue with dequeuing not queued requests
Date:   Thu, 13 Jul 2023 04:14:29 -0400
Message-ID: <20230713081429.326660-1-pawell@cadence.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-CrossPremisesHeadersFilteredBySendConnector: maileu5.global.cadence.com
X-OrganizationHeadersPreserved: maileu5.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM12FT044:EE_|MN2PR07MB7135:EE_
X-MS-Office365-Filtering-Correlation-Id: a88dae3f-8f90-4f74-c925-08db8379333f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MtSyH8605DOjSWhczPYgE4jmMnTqCQzXgx/85PFsI2W1W/vdwvssd7bHu8TMP0JogwXiNf5ilwx4JYRS9GqKRnRIvjcfLA+iE4/x09ynU7HLLAWgKgGZEA78EblRlRybL2vas30Cf16Ug+QCgcuqDQ+xFZyEomGS7mK6B1Cl7RbgA81b73Me2XLT4v9xt56dvLGWjcEBRBpDMksJ+waOOx6yvi2qqO1KZ+jOk5DT7yW0WGEr43z/BpiOW+iHSNTceFXpKsFCVFIqtaocAVt6jnu7EBWQwg3g4zVczCAVC53/feo4Txe/RMougAHjP5TlpCktOm6PWTfQuGpg0Q+aUys73pWIOYB+e4C1qy9ef//Zaw3w8nxC6T6kOEuy1+D4e90WbvP9FrO85YJaf4nWjxncMZl2Nrju3yVhFGAU+qYUIli2Wau/K7k9D03ZFFoc2nJ03247UpEP1qCKAW5g9kYs6GbH7ikmRzzNAwOv0aZ/DAaTTqgUbdXGk95Ne6OeOksnWZBp+ezqPUyIYUSkgQLNV/yMgIflXjnhIdaDMh8OC7oTGmuJpbCfXBtvUiOAmRXaeV6GpGeMRPwXsOnYk+iqHWPfi2aKEVfe8ieqCeA/HkwY6yXmH7BX2JRD4VMLm1j/HhRDbdQORwPyGCUECc5JJg5B+iBCv0BTYQ0DMZOjeXJFqMjxx3fPbnpSmlghYL01oNYT/YeSFJfB7B8408hoTpG6ooUCSWpjBVMtn87K4PH8QJbanRnUE8ONSfqrrliHusbpGavhd+PtEmm00A==
X-Forefront-Antispam-Report: CIP:64.207.220.244;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:wcmailrelayl01.cadence.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(136003)(396003)(346002)(36092001)(451199021)(46966006)(40470700004)(36840700001)(4744005)(2906002)(36860700001)(83380400001)(40460700003)(2616005)(426003)(47076005)(356005)(82740400003)(86362001)(36756003)(82310400005)(81166007)(40480700001)(316002)(6916009)(4326008)(42186006)(70586007)(70206006)(41300700001)(1076003)(336012)(26005)(54906003)(478600001)(186003)(6666004)(8676002)(8936002)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 08:14:37.5438
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a88dae3f-8f90-4f74-c925-08db8379333f
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[64.207.220.244];Helo=[wcmailrelayl01.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM12FT044.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR07MB7135
X-Proofpoint-GUID: fyZHq2o2dkmlfPSdd6X4ns4Wo0d66-4P
X-Proofpoint-ORIG-GUID: fyZHq2o2dkmlfPSdd6X4ns4Wo0d66-4P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-13_04,2023-07-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 mlxscore=0
 phishscore=0 malwarescore=0 spamscore=0 clxscore=1011 suspectscore=0
 mlxlogscore=483 priorityscore=1501 adultscore=0 lowpriorityscore=0
 impostorscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2305260000 definitions=main-2307130071
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gadget ACM while unloading module try to dequeue not queued usb
request which causes the kernel to crash.
Patch adds extra condition to check whether usb request is processed
by CDNSP driver.

cc: <stable@vger.kernel.org>
Fixes: 3d82904559f4 ("usb: cdnsp: cdns3 Add main part of Cadence USBSSP DRD Driver")
Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
 drivers/usb/cdns3/cdnsp-gadget.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/cdns3/cdnsp-gadget.c b/drivers/usb/cdns3/cdnsp-gadget.c
index fff9ec9c391f..3a30c2af0c00 100644
--- a/drivers/usb/cdns3/cdnsp-gadget.c
+++ b/drivers/usb/cdns3/cdnsp-gadget.c
@@ -1125,6 +1125,9 @@ static int cdnsp_gadget_ep_dequeue(struct usb_ep *ep,
 	unsigned long flags;
 	int ret;

+	if (request->status != -EINPROGRESS)
+		return 0;
+
 	if (!pep->endpoint.desc) {
 		dev_err(pdev->dev,
 			"%s: can't dequeue to disabled endpoint\n",
-- 
2.37.2

