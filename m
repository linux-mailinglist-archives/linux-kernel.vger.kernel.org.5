Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A77E07F92EC
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 15:00:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbjKZOAF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 09:00:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjKZOAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 09:00:04 -0500
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01olkn2076.outbound.protection.outlook.com [40.92.99.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D5EDFC;
        Sun, 26 Nov 2023 06:00:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m23pFYmO7USYkTzqMOlr3nbT891uo7pcJL3LCrUfC6jKtIRQk8q8E7sFNEOIi2DboWD4bublGppstDWVv+0cgWjABsGTKx+/sr1ajHM4l7U+pLPQ5AfFWZ7iJiQhbUsGLU1y0f/eo0174zhniwzyrWKW4P6cR+lgMrkZMIzvdy8NIVqxI046gciGqq6kOuJ3EePXR+FAs1KjQzfsiuDxNqS+aVbgPL9GzcMvsApoHYoW6+LXa27eVcqu1SeZJ7M/o19Af/30Hm+pOPPNh4eLzZMbHGQYU+cqWVKhoSFD+FqPeVw/bD1AX9H7Ck9wso8dsKS9InwKZ95fAeEaar3W3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LQuQIQSi4fdfjdG1mPI5nQAv1bsCQvkrIvzZUt3OfyY=;
 b=HbvWrtDehaLwOz5+wOkNoSsjHrDf9NE6bzzVdP++uoBPpE05QKTM/sHtnFwfmaGeDHgLFghnPAb4Jim0vutjZ+S1RqM9jjtLo9AeXNy780TVL6iFRbnude0VMEe0eel01U2USnKDcpv/OS46Wo74jyoX7KhSgqxg26jXvUOejYjFXXTeNTRUt5lCuFhDUdyIg8CyVd+zyR0fHmFxWGSWDQMMDOrST6Te+LWT+vMiV4bsX8noWmU6Xn3BbfCc7e84Hlv7xVrGSgRm/g/1pTRw3qP3UNrr9oGMi/WBydLlgYUXfRt9zcxoq30em2a1N5ASWEOMz25yahLeTkNsuNXgmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LQuQIQSi4fdfjdG1mPI5nQAv1bsCQvkrIvzZUt3OfyY=;
 b=O7SctXCcLK4cQ1M65w0PP3b+MCPm5ZdQiyI2xboP0LH7z8i1OQ0d55q+ByI5DxyIrGh/4E20VYnLpvmfgq5ksVFflSc/FHzPpcSKp9/kUOOBNLF2wxQ2ek8L5djsjcRTWlhDJ1eZ8jPC5fuQW+b1KcnowvYa0qWmuPQrz6/NE8YG8rix43s0YsD2bECJApzIgrMveYt0porRMcZ0byqx3+9ahIoSACR2YCG4Lbx+gXTKOznONOHTDxPlIq7BVcD5NeAuuv2RW5J4xKEnqYKbeafj5oyclHs+68vwX0qssjP+/t60Z7qA9DlLha5VyQZF3X5boBmVlZGKucbb1hb65A==
Received: from OS3P286MB1951.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:175::7)
 by TY3P286MB3761.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:40b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Sun, 26 Nov
 2023 14:00:06 +0000
Received: from OS3P286MB1951.JPNP286.PROD.OUTLOOK.COM
 ([fe80::3264:1deb:5bc:df48]) by OS3P286MB1951.JPNP286.PROD.OUTLOOK.COM
 ([fe80::3264:1deb:5bc:df48%5]) with mapi id 15.20.7025.022; Sun, 26 Nov 2023
 14:00:06 +0000
From:   Yuluo Qiu <qyl27@outlook.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yuluo Qiu <qyl27@outlook.com>,
        Celeste Liu <CoelacanthusHex@gmail.com>
Subject: [PATCH] acpi/video: Add quirk for the Colorful X15 AT 23 Laptop
Date:   Sun, 26 Nov 2023 21:59:13 +0800
Message-ID: <OS3P286MB1951B46E88AB4A91E47A2696BDBEA@OS3P286MB1951.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [edH36FDc4LLzyz3Ir6rgMOuz6ConkrDB]
X-ClientProxiedBy: TYCP301CA0082.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:7b::20) To OS3P286MB1951.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:175::7)
X-Microsoft-Original-Message-ID: <20231126135914.47279-1-qyl27@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3P286MB1951:EE_|TY3P286MB3761:EE_
X-MS-Office365-Filtering-Correlation-Id: 563cf157-a409-4f72-2536-08dbee87fec1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A7PPjXqFxAHbC/kmluE3Y5UF7CTxD5PBx7aKfuOBFGNTl5CImW71JiExeghISn0M6pAPzGtaOkCbvDId9WMsrRjIdP/MTFIMFU23/aYKARXfpXCMhoHA6RhqP0boYEr6x8hGpRvoorVI8810LWG6hRhjFwKg0LrHOPbq3Eofmkte9+/OAEWw+z6Qp86vEePTJ8OA7fwxlY51gBihlBAinv6PRx+GG+3QWMO83sdUtBOcPgRRY0mUrrBJXWSYDHPKNzdCwn2IrOyoqcYIAngrk0EKAY2yDODxYVphR5YFLwqGzQQ7/8eo9+RIdJnh7tMhthAo29HpqxuC+ISU5oj7Nwh+7tzRg6in3HB6W/fzItoBGQv/+i2SyMi4JfmU1lA8+hOIv8NbKszdKom0wmokQrY9zVxkhza3c9ZjtfTi1MxqLiM79CyPN5gfvWbM9ONEvVRldGgBV0giIsMUKqB+GecBUlpdgEO6qXDxCS0sKtmShRcOg4GyC7KIunyCuziZlhiQLiNvroNNSygnq1t7ORCXHV2St7WNEuhdd2N7JaalZiobQiNIT9KKPUxzmVg4gGZCrNCITV4Ky+tUhrNRNWmtS7EWeSDaa9uOSlcS5sldZwbyHXI73R3Ggz/NdOb9
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?b5NpekuyGPHR1y5lV4p0WkclO4crZeO9YAOU0Rl6ZSTTgxlvilLY6jsee8PT?=
 =?us-ascii?Q?r7bN3FjKg6UhsKA9+gpJjD0yI2/+rWs8NF9u3kfT0EAIBpw044fU1zAA8lqq?=
 =?us-ascii?Q?IIPKEfT0RXf1sF1ySCULhAOkpAxumxICvwG4ToTUM/P9PecvT5BW7f0pyNFb?=
 =?us-ascii?Q?TZtZ8BzQlCmfYtZ44AZFhEqexyfxnr+1CF3QA5HcmI8ABCVQzzpf0Maa67gV?=
 =?us-ascii?Q?SX+BiQ399BpDkoBBAXDiI/CKzKkMfwIP8+AJrY+tx2ptJHQbnBV1NqyVSnjF?=
 =?us-ascii?Q?C17ZAfvVM9O3NHfKEWfXgp077jiDK1XF84K500EIZIxVekpgySryPLUV66wY?=
 =?us-ascii?Q?zfucedVSon6s7fn8RX9m70mBZwN+8bkFbHv4b785sEOo3IFVTfX5R9oYSluj?=
 =?us-ascii?Q?ieKuhQ/mqRAmhdw0glWzrCWZc5ubo9FZWVBNh2CRD7s1igMEFti1rBRegVtt?=
 =?us-ascii?Q?r4464hjMEFaaPmLIbnbNlPqh4fIskqKzr0l175Exj/G8cw7Odt5mAOq7N46d?=
 =?us-ascii?Q?dbr9DCvqKV/y3Xp4RkcpQ5+QUtHhVvCGEyukk9zyIOyqGCCR5UQhhC/54UMw?=
 =?us-ascii?Q?uBKUx6+qwLAUXRjgQl7pDPTsQm4+A3UktgwOdS/T9oynPrpCb7jmUVoRNDZk?=
 =?us-ascii?Q?eMUrdPv7wc/EHgwhfPldBqSh18vV+Il10i8UP1GuAZYMQEzZWl3qQFRBdshf?=
 =?us-ascii?Q?f0guuj4JgenFIAivBBwGRRZtcLIPEm1LlutSLAr9JPl2hqc2a+hKhqn7WHcV?=
 =?us-ascii?Q?COV9V+jiRSZmf6NZFvvhInEJy4SIK9040xNKeNToZDGXvvpraebC1E6WjTLM?=
 =?us-ascii?Q?boOwMtyIuiDUPemMHf4EqO0tRK9diNpI41iCcOtOLBkLJODOABn8gmb/qYeH?=
 =?us-ascii?Q?N1IBrhTEhW5eFpfXAmezatFnzJ0WYsr+XdgRgh6wtpRVaNJv39iyLSsaYudM?=
 =?us-ascii?Q?gPRRCKtXPq3TGHwKkpl+fhSFOMo6ymuS6PMdj9Up4+CII7NBtp6Y3GHeEndK?=
 =?us-ascii?Q?4ykCiNB842qVzn79IekamRyhSzQR2itG2GapI4b1HNJGnt6x1vjdTJVlqFSn?=
 =?us-ascii?Q?8dDA8xKHj8XOaIXu5FiBTv90ZexwgBVCjbv4v1eE6FmskuGWywpqhcT/BzyP?=
 =?us-ascii?Q?iY5foz9iBoAf/A8BuZCX9vovNnfwVCKZE/T6lxXQtZCde9eMx2dv3Z6db9Rh?=
 =?us-ascii?Q?Wk8LtOFC7bol4eu8ToOFXTXCj++n+2h2Ov5tViQro4mvbeDqrNORkNgnWEE?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 563cf157-a409-4f72-2536-08dbee87fec1
X-MS-Exchange-CrossTenant-AuthSource: OS3P286MB1951.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2023 14:00:06.8459
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3P286MB3761
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Colorful X15 AT 23 ACIP video-bus device report spurious
ACPI_VIDEO_NOTIFY_CYCLE events resulting in spurious KEY_SWITCHVIDEOMODE
events being reported to userspace (and causing trouble there) when
an external screen plugged in.

Add a quirk setting the report_key_events mask to
REPORT_BRIGHTNESS_KEY_EVENTS so that the ACPI_VIDEO_NOTIFY_CYCLE
events will be ignored, while still reporting brightness up/down
hotkey-presses to userspace normally.

Signed-off-by: Yuluo Qiu <qyl27@outlook.com>
Co-developed-by: Celeste Liu <CoelacanthusHex@gmail.com>
Signed-off-by: Celeste Liu <CoelacanthusHex@gmail.com>
---
 drivers/acpi/acpi_video.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
index d321ca7160d9..c54a364ffff3 100644
--- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -503,6 +503,15 @@ static const struct dmi_system_id video_dmi_table[] = {
 		DMI_MATCH(DMI_PRODUCT_NAME, "Vostro 3350"),
 		},
 	},
+	{
+	 .callback = video_set_report_key_events,
+	 .driver_data = (void *)((uintptr_t)REPORT_BRIGHTNESS_KEY_EVENTS),
+	 .ident = "COLORFUL X15 AT 23",
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "COLORFUL"),
+		DMI_MATCH(DMI_PRODUCT_NAME, "X15 AT 23"),
+		},
+	},
 	/*
 	 * Some machines change the brightness themselves when a brightness
 	 * hotkey gets pressed, despite us telling them not to. In this case
-- 
2.43.0

