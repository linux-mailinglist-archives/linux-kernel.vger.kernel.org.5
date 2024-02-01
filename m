Return-Path: <linux-kernel+bounces-47968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BEAA284556E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 11:33:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E47E11C24235
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 10:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B12433A1DC;
	Thu,  1 Feb 2024 10:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=Sony.onmicrosoft.com header.i=@Sony.onmicrosoft.com header.b="FVoRHlHb"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2068.outbound.protection.outlook.com [40.107.223.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2846B3A1BB;
	Thu,  1 Feb 2024 10:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706783596; cv=fail; b=d3OvepfqCwEi4cQsLXBG9z1ACY+9hawZrW9kZegIr5vqfMaojeiIYf2JLyuWcNOWbgR9+gweF2CsOcSCGBeoIP4fkVS5FqJBrqGATOSwhQsrfk2poVememcK3ani6kiaf8OIeofG/6/axNX1p+QrXwNderlwn/ETN7oxqqYjLhc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706783596; c=relaxed/simple;
	bh=G7cRbRPxs8CUJ1VViTGx72ig0XolbIz4vieMwZ6ZtUc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HQZJHWb0lpLDaw8u+7S4yuk3f73FKEpolvG70/R9TnxV8735aR2ZxXTGSuk+kvNLvT+jLZRqIgn84z2eYbygyTnm0BeNLpSJSUmU3ynOvdwsXf5u2EAPna0nKtroQr20YPnJz/lITv725pg080YdtGeswCzcb1na6PNFLoh5lXg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (1024-bit key) header.d=Sony.onmicrosoft.com header.i=@Sony.onmicrosoft.com header.b=FVoRHlHb; arc=fail smtp.client-ip=40.107.223.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F/mdVVJu2qP5yNPefKI0U+ZCBdC/urlu7vNMnylv4JXDD9EbkTVfH/C584qymmzw1xwFeMglpx2Fioqy010oYOKYYPyK0bQ0H8Y4fNsXMXYSypBsQKDw0RMPBimm2tnxKOAMcndRmSCPWqD+14i7QPqmWG+xOceX0J62eni8pBLZ72awOA6rtkJszhB+sQuakh5UiFHRU2lNQvEy+2TKYwAaDYYv5lgUK4K7oMbHhkm5JebcTCRbT8khB9q+TwL1Uo5TIUnRxcrLT1BeAZN1ZX9K2Slh2zqQxWqa4FvrhuTHrUBp7V21AWGRv+WVPD3AYnBq+7HAzv6IiPtghTFtoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yLs2P3s49bjsbevW4T9Hhuh5aR5rSGmElejR7NCZc/g=;
 b=RGO9ahAv+oQwhbA5i71wNTyWEdYW9LpRPTs7b68lTbRjqevknhnVS+M+mK/fdQHHIOPHeh2ThgZnvu+murkDGXF3kk18kb+8RhOTRm1r8NFCq/8n2+KmBB+noIySzZCcpMHPkMYqOlZ0PbcEHcqy0Pk6v0rPtyGT02eg085432hSlaCQMgEebox6UDg6ljTN2GQ3NeHTlxMEPZ59dYt7SDnywSiROk/6VzhUIkfVA/uXav8L2WwsLj2aoilQSY8Q/awiYn7drW8su6YkE/+lCxQHHaZxnNpK7Bx6J2kpyfOExM8335P/OevmZKEm5H13JsXFPiBtB0HZ02tZkITtgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 121.100.38.196) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=sony.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=sony.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Sony.onmicrosoft.com;
 s=selector2-Sony-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yLs2P3s49bjsbevW4T9Hhuh5aR5rSGmElejR7NCZc/g=;
 b=FVoRHlHbTDGN/IVgACwfgNTvddVkZshiaU/hWpY1FB30ZskaSyEZRkWVPy/WXbaEmFAO8PmPeBj1iS5OrOQTONfSRnVmfZ7319LqCV6LghNkI+LJ6i/sQ/91n0JejXC2r8wVDQ55k7qJMHPI3rNJ4yVrFneq/l0AnJSVwTrAOWE=
Received: from CH0PR03CA0243.namprd03.prod.outlook.com (2603:10b6:610:e5::8)
 by SJ0PR13MB5983.namprd13.prod.outlook.com (2603:10b6:a03:43f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Thu, 1 Feb
 2024 10:33:12 +0000
Received: from DS2PEPF00003443.namprd04.prod.outlook.com
 (2603:10b6:610:e5:cafe::56) by CH0PR03CA0243.outlook.office365.com
 (2603:10b6:610:e5::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.24 via Frontend
 Transport; Thu, 1 Feb 2024 10:33:12 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 121.100.38.196)
 smtp.mailfrom=sony.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=sony.com;
Received-SPF: Fail (protection.outlook.com: domain of sony.com does not
 designate 121.100.38.196 as permitted sender)
 receiver=protection.outlook.com; client-ip=121.100.38.196;
 helo=gepdcl07.sg.gdce.sony.com.sg;
Received: from gepdcl07.sg.gdce.sony.com.sg (121.100.38.196) by
 DS2PEPF00003443.mail.protection.outlook.com (10.167.17.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.19 via Frontend Transport; Thu, 1 Feb 2024 10:33:11 +0000
Received: from gepdcl04.s.gdce.sony.com.sg (SGGDCSE1NS08.sony.com.sg [146.215.123.198])
	by gepdcl07.sg.gdce.sony.com.sg (8.14.7/8.14.4) with ESMTP id 411AVlS0022120
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 1 Feb 2024 18:32:52 +0800
Received: from mail.sony.com ([43.88.80.246])
	by gepdcl04.s.gdce.sony.com.sg (8.14.7/8.14.4) with ESMTP id 411AVFXd012375;
	Thu, 1 Feb 2024 18:31:15 +0800
Received: by mail.sony.com (Postfix, from userid 1000)
	id 70FBB20C1C4D; Thu,  1 Feb 2024 15:59:42 +0530 (IST)
Date: Thu, 1 Feb 2024 15:59:42 +0530
From: Sreenath Vijayan <sreenath.vijayan@sony.com>
To: john.ogness@linutronix.de, corbet@lwn.net, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, pmladek@suse.com
Cc: rdunlap@infradead.org, rostedt@goodmis.org, senozhatsky@chromium.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, taichi.shimoyashiki@sony.com,
        daniel.palmer@sony.com, anandakumar.balasubramaniam@sony.com,
        sreenath.vijayan@sony.com
Subject: [PATCH v4 2/2] tty/sysrq: Dump printk ring buffer messages via sysrq
Message-ID: <ca8dd18e434f309612c907d90e9f77c09e045b37.1706772349.git.sreenath.vijayan@sony.com>
References: <cover.1706772349.git.sreenath.vijayan@sony.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1706772349.git.sreenath.vijayan@sony.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003443:EE_|SJ0PR13MB5983:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a94104c-5cf2-4bcd-ecba-08dc231130c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	uACyjzY3GNax10HkdmQRnYfTQMiu+BiSfHteks0zFgU0pDWjcT/zLTJrRvk+MmlvetHYZVnoq9A0lTTFtqefXVvw8CtyC7OX4xevd9dWeGwFbCDkQpIsWqQE7PgctELvgpD4YA4wuB8io6kSdz84tNNIHO8wpyfwXBG6CjTbl5hGBbIKT8at/LKx/e9rPMF55NzywEvKwIWd51sjkjU+roph11lPIGq9SHYMLF9k/CdeE3EyhnEfvNVIf3OFP+fGoeq6TM8naH6+um66Ox6coNfzfeOwv3cL/Hp4/+MjIvowL/kIeUQKImMKgHIM6ngRFCWukXfhrXB7ilu8tR8y2MeYSeKa0FeLjeorUhrK8TmhDN54t9dUakt4HdMEmug2BsGkp6vEv0kH3Tmjwe4BeZ7+hGb1epSKE54xw7zv9X2k3Sz9OQRW63ZR6lc4GV022xLbBHRgJfHM7P01JqYemE+d+MwIDLZgWVoKEEtcEATF1qtoxUMnnsyTDLxuc75xFj/UGKdfz+7LaaMVxuMjTUUz7jxhXikStljpuUawN5cbSUUy82uKRkDRmyoIlRTtRd7p1VBrz5bFVBAKzyFrdBOz901baLdWdwUp0WLGotoeEo44U5OGW5s5nOL8tnYWSE4jMycP0Snj0++2Oi9LJQ4hWl2eX9h7pZB/6e5anf2+wneBj77S1J1o9Xfn6u3Sn8DT9y0XSu9ntJ3hTf3oOXWnK3Z5VnFWWBqiYW8ssUp3e/aP/SZoIILIGQIqvaD8TgY3wQppOf8zPEoyUcx0zg==
X-Forefront-Antispam-Report:
	CIP:121.100.38.196;CTRY:SG;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:gepdcl07.sg.gdce.sony.com.sg;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(396003)(39860400002)(136003)(230922051799003)(451199024)(1800799012)(64100799003)(82310400011)(186009)(40470700004)(36840700001)(46966006)(41300700001)(47076005)(83380400001)(107886003)(6266002)(426003)(336012)(26005)(8676002)(356005)(36860700001)(4326008)(44832011)(450100002)(15650500001)(5660300002)(82740400003)(8936002)(2906002)(478600001)(81166007)(42186006)(316002)(2616005)(70206006)(36756003)(82960400001)(86362001)(40480700001)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2024 10:33:11.2208
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a94104c-5cf2-4bcd-ecba-08dc231130c4
X-MS-Exchange-CrossTenant-Id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=66c65d8a-9158-4521-a2d8-664963db48e4;Ip=[121.100.38.196];Helo=[gepdcl07.sg.gdce.sony.com.sg]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DS2PEPF00003443.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR13MB5983

When terminal is unresponsive, one cannot use dmesg to view printk
ring buffer messages. Also, syslog services may be disabled,
to check the messages after a reboot, especially on embedded systems.
In this scenario, dump the printk ring buffer messages via sysrq
by pressing sysrq+D.

Signed-off-by: Sreenath Vijayan <sreenath.vijayan@sony.com>
Signed-off-by: Shimoyashiki Taichi <taichi.shimoyashiki@sony.com>
---
 Documentation/admin-guide/sysrq.rst |  2 ++
 drivers/tty/sysrq.c                 | 20 +++++++++++++++++++-
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/sysrq.rst b/Documentation/admin-guide/sysrq.rst
index 2f2e5bd440f9..c634e8b4cea2 100644
--- a/Documentation/admin-guide/sysrq.rst
+++ b/Documentation/admin-guide/sysrq.rst
@@ -161,6 +161,8 @@ Command	    Function
             will be printed to your console. (``0``, for example would make
             it so that only emergency messages like PANICs or OOPSes would
             make it to your console.)
+
+``D``	    Dump the printk ring buffer
 =========== ===================================================================
 
 Okay, so what can I use them for?
diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
index 02217e3c916b..365f7fa145f0 100644
--- a/drivers/tty/sysrq.c
+++ b/drivers/tty/sysrq.c
@@ -450,6 +450,24 @@ static const struct sysrq_key_op sysrq_unrt_op = {
 	.enable_mask	= SYSRQ_ENABLE_RTNICE,
 };
 
+static void dmesg_dump_callback(struct work_struct *work)
+{
+	dump_printk_buffer();
+}
+
+static DECLARE_WORK(sysrq_dmesg_work, dmesg_dump_callback);
+
+static void sysrq_handle_dmesg_dump(u8 key)
+{
+	queue_work(system_unbound_wq, &sysrq_dmesg_work);
+}
+static struct sysrq_key_op sysrq_dmesg_dump_op = {
+	.handler        = sysrq_handle_dmesg_dump,
+	.help_msg       = "dump-dmesg(D)",
+	.action_msg     = "Dump dmesg",
+	.enable_mask    = SYSRQ_ENABLE_DUMP,
+};
+
 /* Key Operations table and lock */
 static DEFINE_SPINLOCK(sysrq_key_table_lock);
 
@@ -505,7 +523,7 @@ static const struct sysrq_key_op *sysrq_key_table[62] = {
 	NULL,				/* A */
 	NULL,				/* B */
 	NULL,				/* C */
-	NULL,				/* D */
+	&sysrq_dmesg_dump_op,		/* D */
 	NULL,				/* E */
 	NULL,				/* F */
 	NULL,				/* G */
-- 
2.43.0


