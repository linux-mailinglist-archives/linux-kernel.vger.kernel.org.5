Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CCBD7E538A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 11:42:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344291AbjKHKmQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 05:42:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344022AbjKHKmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 05:42:13 -0500
X-Greylist: delayed 4210 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 08 Nov 2023 02:42:10 PST
Received: from mx0a-0014ca01.pphosted.com (mx0b-0014ca01.pphosted.com [208.86.201.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 779471723;
        Wed,  8 Nov 2023 02:42:10 -0800 (PST)
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3A85mReb012948;
        Wed, 8 Nov 2023 01:31:47 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding:content-type; s=proofpoint; bh=ylYcfG
        YQy5wlQlWyaA8F3G7+L0434gtHtxQrkvViJ5k=; b=tMhXs/DU/Uugp/qerxT9zW
        KVxQDaBuFJ/wVtpcXCxGcE8NcNb4a/OgHbbTUa3H4Ms+pNh6KLxGg3uydl9c7x7i
        22atMqIyOT3swvUxHfHuo3szPMPktZI5gvCosxVFrZlKKhdEiN2iMZC6TwB7zMT5
        zPIarCPTDltjVqmIogfWAfGNPiakHHl5xAQkXqLesS7CSOpcEaTLJMwkJeC0Mrze
        wB38waGfLG2AFH1w6+To1jgE3gJdmOWZ4jdJuVfeKS0DMfhsAKCK2H2JVbtynDeG
        P+PQ/KttO4GrG5De/WJchwW8oFpGW8PW5dIesGhgJwv6f04KL93+d5TQthOhW8Dw
        ==
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2041.outbound.protection.outlook.com [104.47.74.41])
        by mx0b-0014ca01.pphosted.com (PPS) with ESMTPS id 3u7w24tesx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Nov 2023 01:31:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YZjksUyGzQFfD6uYoDdTubBlpixRBcXSGvtpOqbZCil5Zk1ntPTRemaplyWdSZa1dkKnHmXUxsQvyIVyQWML8rbYXQVGOReOiX09GKxZquPaolSwYZT1b1QSaDbB18ENU5MSU+BtA6xGYvPhx1asorrVwNuJhnJw8RZU6SiozcKyAEYDsvuQe2+b/YVqjMEkHvhPw0nmBwq5/Zkr1nRJycVrAbhmYyZ8fle2eJHjTo0UqTEJFvL1p0/ytdx/ckXblG4tt0Z0ZrnVbt/T9+j4UG4s0vOy3MnJgRLyaOCHNVN56F8PC+XUGoHdEZ7bs9hkr+itMlLNG2PsF70td9uMZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ylYcfGYQy5wlQlWyaA8F3G7+L0434gtHtxQrkvViJ5k=;
 b=dG4MyaRbfnZ64MZ6aWn+US84QhWBoKWivHcFhztG47Ku66PxBHDD7OL3o0/5hZkDpvosARlEqTwnQlf+/Ew7kJPLEUDnKYdn+rqYl0yQE+PZBpbFDH8d+qg8csKAKcD6Ft6mlbiQYBVlbXnEpJvZY1v8Lwitkw6yj43Wf8h0xyShBvcQ8kKxeyMPDvHfmY/xgq3abIme9T63xPH65mT+fSue8yO3uPgKYfYqAioKrw5nsUK1lyR8iEXEyZ+MWOm71GrMxHriMA6ia37QF5xTApnW1UkM4MOATQXZh+4S+UK/W8igi/rvlNMuHT9dQv0esTyx7ikkqu6bC83CJhHKBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.147) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ylYcfGYQy5wlQlWyaA8F3G7+L0434gtHtxQrkvViJ5k=;
 b=cich8cxOYt4YdWRSrc8auJh5iahLOkGyM7nfbxY2IqlUQApprugbS9/m7od1GAyzCVFkrA7D7Rnlkt30PAh5jTnPfhclulPSDl+5HLlCcQPfAJVNcBVOL8jRZNmhZpTA5sI68OCtbKVcKzeO8VVJK68xYYBAfXanfN5ZC+/GuuU=
Received: from MW4PR04CA0087.namprd04.prod.outlook.com (2603:10b6:303:6b::32)
 by LV8PR07MB10071.namprd07.prod.outlook.com (2603:10b6:408:1ed::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18; Wed, 8 Nov
 2023 09:31:45 +0000
Received: from MW2NAM12FT028.eop-nam12.prod.protection.outlook.com
 (2603:10b6:303:6b:cafe::f1) by MW4PR04CA0087.outlook.office365.com
 (2603:10b6:303:6b::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18 via Frontend
 Transport; Wed, 8 Nov 2023 09:31:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.147)
 smtp.mailfrom=cadence.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.147 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.147; helo=sjmaillnx1.cadence.com; pr=C
Received: from sjmaillnx1.cadence.com (158.140.1.147) by
 MW2NAM12FT028.mail.protection.outlook.com (10.13.181.238) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7002.6 via Frontend Transport; Wed, 8 Nov 2023 09:31:44 +0000
Received: from maileu5.global.cadence.com (eudvw-maileu5.cadence.com [10.160.110.202])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 3A89VgIX013665
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 8 Nov 2023 01:31:43 -0800
Received: from maileu4.global.cadence.com (10.160.110.201) by
 maileu5.global.cadence.com (10.160.110.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 8 Nov 2023 10:31:41 +0100
Received: from eu-cn02.cadence.com (10.160.89.185) by
 maileu4.global.cadence.com (10.160.110.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7
 via Frontend Transport; Wed, 8 Nov 2023 10:31:41 +0100
Received: from eu-cn02.cadence.com (localhost.localdomain [127.0.0.1])
        by eu-cn02.cadence.com (8.14.7/8.14.7) with ESMTP id 3A89VVL0225199;
        Wed, 8 Nov 2023 10:31:31 +0100
Received: (from pawell@localhost)
        by eu-cn02.cadence.com (8.14.7/8.14.7/Submit) id 3A89VVSm225195;
        Wed, 8 Nov 2023 10:31:31 +0100
From:   Pawel Laszczak <pawell@cadence.com>
To:     <peter.chen@kernel.org>
CC:     <gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <pawell@cadence.com>,
        <stable@vger.kernel.org>
Subject: [PATCH] usb: cdnsp: Fix deadlock issue during using NCM gadget
Date:   Wed, 8 Nov 2023 10:31:25 +0100
Message-ID: <20231108093125.224963-1-pawell@cadence.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-CrossPremisesHeadersFilteredBySendConnector: maileu5.global.cadence.com
X-OrganizationHeadersPreserved: maileu5.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2NAM12FT028:EE_|LV8PR07MB10071:EE_
X-MS-Office365-Filtering-Correlation-Id: c688d8e6-b2df-4156-ef2d-08dbe03d85e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gSa6DyWjmDjeBl/VhZTnphyZIuyuh++Zob+DL+uk7Mh8dmKWqsM9oOy3zm3gQ8cL0cMm5LYsRqUxQVahoBEtU+XIn7URVSpMAwbvzqm4khLoUnJ5WfB9H+sPfEBdae6hHK5KO5QjGOy7zoZpVERrgeH1BXpXFdKHr5oiotvI4LacDG5C2OPPakLEMuOuO94htr09/ko/9fMkpcBn74Db7I6T1rEKh4fhXb0XUt1cTdJYELb5RKxkOab9AfcI0xEQ/dYA3GM564v6ekLnl3O/3bM8NLAapBlCsAwFMwFayDu+VJWR1OPLr2UVqR87bdnn4gPji6zjt6UymxZeW65eLEJLS8EgMTrbIxfN4N4sCOifCd+xb6X7Lo7RVqIwTj2xmLU9ujftGIHxXxB9G/PoYEyBynMfJmAQriFsP/fUqkI3Ons94OAeA7it2vOXlHwfVn/rW1cULxyv/NFWvZddGkamVvTOhYYCQz4kh57Wn4+of5jCLggUWy25z/r/VhHLO3tIRYv/pkmgX53KWamC9R2l3iaMYMpUZTAOEy7mpm2ulwwNq9GL4pFTAWX1nDTizTymtlvNQdWUxlGRqERInncjGqsk2jpgH2Sa1fTiEGztpMSDWwUqlndT7TRn80q4/ijEI3rIX3EEA31EBHDmOcjp7Itkn/EN0Rz+zwGF+fMjtFLVqy2lImLoXNx9wmxMUGsu8Bki/t3tTpMTEz4V3HkndoRHf+asWue2++wKNj4QWmPS+jym3whkDi+HoCck
X-Forefront-Antispam-Report: CIP:158.140.1.147;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx1.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(13230031)(4636009)(136003)(39860400002)(376002)(346002)(396003)(230922051799003)(186009)(1800799009)(451199024)(82310400011)(64100799003)(46966006)(40470700004)(36840700001)(47076005)(40460700003)(36860700001)(41300700001)(54906003)(42186006)(6916009)(36756003)(70586007)(70206006)(82740400003)(7636003)(356005)(2616005)(6666004)(316002)(86362001)(26005)(1076003)(478600001)(2906002)(336012)(426003)(83380400001)(4326008)(8936002)(5660300002)(8676002)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 09:31:44.6719
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c688d8e6-b2df-4156-ef2d-08dbe03d85e6
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.147];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: MW2NAM12FT028.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR07MB10071
X-Proofpoint-ORIG-GUID: 0Db5RbJr--kXsI2ZIH3AKhVaeb-o-qtl
X-Proofpoint-GUID: 0Db5RbJr--kXsI2ZIH3AKhVaeb-o-qtl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-08_01,2023-11-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=64 suspectscore=0
 malwarescore=0 impostorscore=0 mlxlogscore=-23 adultscore=0 spamscore=64
 mlxscore=64 priorityscore=1501 phishscore=0 lowpriorityscore=0
 clxscore=1011 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311060001 definitions=main-2311080079
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The interrupt service routine registered for the gadget is a primary
handler which mask the interrupt source and a threaded handler which
handles the source of the interrupt. Since the threaded handler is
voluntary threaded, the IRQ-core does not disable bottom halves before
invoke the handler like it does for the forced-threaded handler.

Due to changes in networking it became visible that a network gadget's
completions handler may schedule a softirq which remains unprocessed.
The gadget's completion handler is usually invoked either in hard-IRQ or
soft-IRQ context. In this context it is enough to just raise the softirq
because the softirq itself will be handled once that context is left.
In the case of the voluntary threaded handler, there is nothing that
will process pending softirqs. Which means it remain queued until
another random interrupt (on this CPU) fires and handles it on its exit
path or another thread locks and unlocks a lock with the bh suffix.
Worst case is that the CPU goes idle and the NOHZ complains about
unhandled softirqs.

Disable bottom halves before acquiring the lock (and disabling
interrupts) and enable them after dropping the lock. This ensures that
any pending softirqs will handled right away.

cc: <stable@vger.kernel.org>
Fixes: 3d82904559f4 ("usb: cdnsp: cdns3 Add main part of Cadence USBSSP DRD Driver")
Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
 drivers/usb/cdns3/cdnsp-ring.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/cdns3/cdnsp-ring.c b/drivers/usb/cdns3/cdnsp-ring.c
index 07f6068342d4..275a6a2fa671 100644
--- a/drivers/usb/cdns3/cdnsp-ring.c
+++ b/drivers/usb/cdns3/cdnsp-ring.c
@@ -1529,6 +1529,7 @@ irqreturn_t cdnsp_thread_irq_handler(int irq, void *data)
 	unsigned long flags;
 	int counter = 0;
 
+	local_bh_disable();
 	spin_lock_irqsave(&pdev->lock, flags);
 
 	if (pdev->cdnsp_state & (CDNSP_STATE_HALTED | CDNSP_STATE_DYING)) {
@@ -1541,6 +1542,7 @@ irqreturn_t cdnsp_thread_irq_handler(int irq, void *data)
 			cdnsp_died(pdev);
 
 		spin_unlock_irqrestore(&pdev->lock, flags);
+		local_bh_enable();
 		return IRQ_HANDLED;
 	}
 
@@ -1557,6 +1559,7 @@ irqreturn_t cdnsp_thread_irq_handler(int irq, void *data)
 	cdnsp_update_erst_dequeue(pdev, event_ring_deq, 1);
 
 	spin_unlock_irqrestore(&pdev->lock, flags);
+	local_bh_enable();
 
 	return IRQ_HANDLED;
 }
-- 
2.37.2

