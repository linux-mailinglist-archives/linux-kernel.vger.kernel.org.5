Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9648F7FE151
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 21:48:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233967AbjK2UsS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 15:48:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjK2UsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 15:48:16 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12olkn2022.outbound.protection.outlook.com [40.92.22.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2548810D1;
        Wed, 29 Nov 2023 12:48:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ACGv8jPc1gQBv7wSXpYtq/4jUw3sgngIVEUH07v+ezehXW0z5z0/tLbUyGjhYffpUSc2glcU1vk0IWPOBux3YgDevfLe9FLwzKC9FIQ8X25DpL29tyGBo4iUbeNagTaqQF8clRM0trZY7A2guSoaj1g8Qsh2J+r6JgZ/0CHCm0Ule+YowHVe9b4piYp+IbahrOX3/Q3yYQwn3nMgg4ekRwSI3soveblBr3NajGUVGeRaTEoiN/wWjDrlyaLgB1C+dWKLx0tPnyJr7dPswXsWKucvq/6wn3MRdVY+bBRUNURBWE3Zd40H6JQnYQWSTdBpjb1T1zPbNCvsla6sRoPgdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Juqzo0JhMeLeUzql3cvl0YmuSzln/yU2Cz2EC3jzHPk=;
 b=IuC3MBcKAmIXtEAb88mm8reZFcB2DCYAawQr0N06NgExZEFilxddUpxF7Lbjh5zk0e0/r61Jjd7jKbIZ+bHD/ewC/W5Ad4aiG/dAUnC8/NsdCvnc6Gw9dnwEAHj/tM7Fy+Bv6fJBgm+RzQJ5qEPlerbKZ6ztmAhVT3opwMmB+v4UG0OP7cJ4watEr7Kj1l6zOWbnT7UeSKhivsWbVxpN3oEUDfdI7uG7TzJ3N7VYKZQz3HEAUqaYygqKrleJYHp+TyNcxu+Po5w3KWKHaCdr90v3s/a+1G8jutriuYyydFdkFz3fQBRVSMXD3AFMpsyNX8w6BVzMnMqVsWshb9ctRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Juqzo0JhMeLeUzql3cvl0YmuSzln/yU2Cz2EC3jzHPk=;
 b=sE6znCVy6U8nMvA18haPAXsFXg9MyW8Vbx5z1K/YCOjv1QnzEtY0Pr41tIfJb99+GOjCl3TOBkTPtJydQ5fGN+Hn/3r0YEryWt4S42sMsf7/aLjCg+Ca6DiIj6Fzf0TIp1ggGDORJ2g579yG3x1GxGYeWQE4ZOJHJfSB3E31LCShyy5vkaYJ5lQ1BYMVq+YraImotbTahKd+F0npbKZ1j43Y6QpSP+zUuRSss9UE+SRnTa6J1ofxOEqU/+1JjI53exeO34XEvzSuv260fjBX+Z58Y7f3QbpuwX2tEHmr7QywULyXsudkkBACXkf7zhf68ErXi9DKH3Cby+Mg7dP3CQ==
Received: from PH7PR03MB7064.namprd03.prod.outlook.com (2603:10b6:510:2a5::8)
 by SJ0PR03MB5808.namprd03.prod.outlook.com (2603:10b6:a03:2dd::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22; Wed, 29 Nov
 2023 20:48:19 +0000
Received: from PH7PR03MB7064.namprd03.prod.outlook.com
 ([fe80::9ca4:4c22:a89:9a8]) by PH7PR03MB7064.namprd03.prod.outlook.com
 ([fe80::9ca4:4c22:a89:9a8%7]) with mapi id 15.20.7046.015; Wed, 29 Nov 2023
 20:48:19 +0000
From:   Min Li <lnimi@hotmail.com>
To:     richardcochran@gmail.com, lee@kernel.org
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Min Li <min.li.xe@renesas.com>
Subject: [PATCH net-next v2 1/2] ptp: introduce PTP_CLOCK_EXTOFF event for the measured external offset
Date:   Wed, 29 Nov 2023 15:48:05 -0500
Message-ID: <PH7PR03MB7064CC413965BFE5E005B273A083A@PH7PR03MB7064.namprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [ByTbcxrHd/v6hYqhxlVacCXf5hcN/kuE]
X-ClientProxiedBy: YQBPR01CA0136.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:1::36) To PH7PR03MB7064.namprd03.prod.outlook.com
 (2603:10b6:510:2a5::8)
X-Microsoft-Original-Message-ID: <20231129204806.14539-1-lnimi@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB7064:EE_|SJ0PR03MB5808:EE_
X-MS-Office365-Filtering-Correlation-Id: b0c83b9e-e78f-49d8-18c2-08dbf11c8462
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XkoUH2FKqw95Kg1D+jhvB330LzGidzupIobjcso5I1xUvvRkFjdhkob8CzNIvVner+0p0VX38uuvX1NtxqNAHMVn5Rlg8tM1ex4Lo0WwG5fbfzIOufd33mfXbIMUze7OtLw8m76MatxnE/bXMPGs7YYH0X02HaY6rwAtjkAzxjPPhhl8x+UgsIfKa9lwB+EjufDfh2bGwlqgMOL6P/IOpWAHBY/NoSld43QX879Pbzd6Cen8+t1shJHDq9bSbv3mRpYnwcj7uunWbb5KXeWG89X6KUGkuImadbnVPZo30hx6V4LbJekujOmKzYfyUKR9QoPuWPFcu70s/ZtPVRTge3krF8c8M2UgSOMKoM92zzigrVJ8aq4R21N09SdRh1dV+EoydATadChahQRE/PTmpXpbom7qgpoPCmHn84z7zXcYQkhCuzKYDKDe8Cv7+40okPw9MZCcgvB6qRzxzz9HAKxkxgqc1WOgyostW+FxAlMO3q04z7lgRM2IxirRfI4FBVzUDWgHeOEq/xog2v1HigxdCll+1eaMuOgtbxYAH77FlmtpxNtpm1Mb6MNKC0gB
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?P/kpQFKB4uk8U4LsRAk+guF1+ZQX0eab3umhTbZ9Bv/s43PvdX7sSJ9aSh17?=
 =?us-ascii?Q?DjU4+Es2aO+0SwKhy5Ao5jgH7st3UMNvQZvb2Nbq4VUnTVDDu0NY1CKf/rBm?=
 =?us-ascii?Q?y+4SlBYySGGhwQcVO0fsZPed+qZtU+/Dk3jSRYSQ/8MR49k/f0wBsLnvsHF6?=
 =?us-ascii?Q?qJLrmgHV/k1YJ2djR7IrHgyNVyVmClnxVnL7o8AZlN2VYauZ2fWGEvf2wja2?=
 =?us-ascii?Q?GfhO4hH1BgKVL+pR0JDV9tpNn8GLxvi6q+zjO4j+QjlZbLCXhjg01N2zlcc4?=
 =?us-ascii?Q?hhvdf9nKwl2NLjLJJdyrM7CIKxEo173gwSAGNm+NqLPcC9kOk1QsHK1Tv0qS?=
 =?us-ascii?Q?IDK0ATeMLFqmonzbkV6OhXudDmA5Pdc1iaW2YX0CNVaHFy9aa1q+76p8KgVc?=
 =?us-ascii?Q?sxLioxH7j5vB2aAS9uU1IZ1G66dSff1vHtfpBJWUHIKdclPo75PvNuxUMNAQ?=
 =?us-ascii?Q?1j2hF6a/oxBgqKPaz0gAlHqsGSiFQf5xQYWApwAfqjP6hiSrhbniGRKLlRZp?=
 =?us-ascii?Q?6ILIl+L9y5j2vDoogEJZc7Je0eKc8/kqJRYAGR2n8nTWCdiEFZlJmbPSiwDf?=
 =?us-ascii?Q?42eZXnQsXAmsZYlJ7gs5tcbrYfK9/HLENOurFw7oa5Fz3T6boVuzugdisQOQ?=
 =?us-ascii?Q?O/XrOBGveXlaTg4OyGjUyNyeQJpk0jeQCZxzQlWCeAbE9Kk8u+4DTG5soz3N?=
 =?us-ascii?Q?P8sOEo9/nOd3DACfMX6hYkqE5Mgb45fy9USKTqOIhaqgRkpk8HXPRwMJoi6r?=
 =?us-ascii?Q?XWs83QvIa+w7daC5qz9wpYduJrY9o5GOM0FisppVrqwMWLTescPLLkhJlz7M?=
 =?us-ascii?Q?YNGe9ygwYjegS08pzMLygEHuCOafX/kA16GQttM/x3MZgeSzFcCatB/8HtzG?=
 =?us-ascii?Q?Ve5+Wyo8W1ONWH0DVsNM1qlrayTTJJ9giTneNLLV+KTHgTYHw81uDwm2qXqQ?=
 =?us-ascii?Q?2hR8zZy6bAlX5kkdslS1nrwaHmphDk92YggFYoRW/rZhB8OVJyK5ElgZAJ9b?=
 =?us-ascii?Q?vcoI26Ep2sHr5KKp3Wq6TW/UKVbMiE40ytYKnNotgt0F0fbefHxcAf+3CiPU?=
 =?us-ascii?Q?R50jrRi54uajIeeDL98WmKzVNHvywZTxN1LnFnKZcZWQvjF5+E6uJohuFDGp?=
 =?us-ascii?Q?5wHa3GyCRzrI07VRvVlj1Qjn33HC7G9ef82Y/BeB6KBVwFQrd6+N7V0OM9yd?=
 =?us-ascii?Q?XYtVF/JHmZIqyaqguYYlLOvIbW4qaMhgEnxHIw=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-839f4.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: b0c83b9e-e78f-49d8-18c2-08dbf11c8462
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7064.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2023 20:48:19.0691
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5808
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Min Li <min.li.xe@renesas.com>

This change is for the PHC devices that can measure the phase offset
between PHC signal and the external signal, such as the 1PPS signal of
GNSS. Reporting PTP_CLOCK_EXTOFF to user space will be piggy-backed to
the existing ptp_extts_event so that application such as ts2phc can
poll the external offset the same way as extts. Hence, ts2phc can use
the offset to achieve the alignment between PHC and the external signal
by the help of either SW or HW filters.

Signed-off-by: Min Li <min.li.xe@renesas.com>
---
-Rebase to net-next tree

 drivers/ptp/ptp_clock.c          | 12 +++++++++---
 include/linux/ptp_clock_kernel.h |  3 +++
 include/uapi/linux/ptp_clock.h   |  9 +++++++--
 3 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/ptp/ptp_clock.c b/drivers/ptp/ptp_clock.c
index 15b804ba4..01b55c1e2 100644
--- a/drivers/ptp/ptp_clock.c
+++ b/drivers/ptp/ptp_clock.c
@@ -48,14 +48,19 @@ static void enqueue_external_timestamp(struct timestamp_event_queue *queue,
 	s64 seconds;
 	u32 remainder;
 
-	seconds = div_u64_rem(src->timestamp, 1000000000, &remainder);
+	if (src->type != PTP_CLOCK_EXTOFF)
+		seconds = div_u64_rem(src->timestamp, 1000000000, &remainder);
 
 	spin_lock_irqsave(&queue->lock, flags);
 
 	dst = &queue->buf[queue->tail];
 	dst->index = src->index;
-	dst->t.sec = seconds;
-	dst->t.nsec = remainder;
+	if (src->type != PTP_CLOCK_EXTOFF) {
+		dst->t.sec = seconds;
+		dst->t.nsec = remainder;
+	} else {
+		dst->offset_ns = src->offset;
+	}
 
 	/* Both WRITE_ONCE() are paired with READ_ONCE() in queue_cnt() */
 	if (!queue_free(queue))
@@ -417,6 +422,7 @@ void ptp_clock_event(struct ptp_clock *ptp, struct ptp_clock_event *event)
 		break;
 
 	case PTP_CLOCK_EXTTS:
+	case PTP_CLOCK_EXTOFF:
 		/* Enqueue timestamp on selected queues */
 		spin_lock_irqsave(&ptp->tsevqs_lock, flags);
 		list_for_each_entry(tsevq, &ptp->tsevqs, qlist) {
diff --git a/include/linux/ptp_clock_kernel.h b/include/linux/ptp_clock_kernel.h
index 1ef4e0f9b..6e4b8206c 100644
--- a/include/linux/ptp_clock_kernel.h
+++ b/include/linux/ptp_clock_kernel.h
@@ -200,6 +200,7 @@ struct ptp_clock;
 enum ptp_clock_events {
 	PTP_CLOCK_ALARM,
 	PTP_CLOCK_EXTTS,
+	PTP_CLOCK_EXTOFF,
 	PTP_CLOCK_PPS,
 	PTP_CLOCK_PPSUSR,
 };
@@ -210,6 +211,7 @@ enum ptp_clock_events {
  * @type:  One of the ptp_clock_events enumeration values.
  * @index: Identifies the source of the event.
  * @timestamp: When the event occurred (%PTP_CLOCK_EXTTS only).
+ * @offset:    When the event occurred (%PTP_CLOCK_EXTOFF only).
  * @pps_times: When the event occurred (%PTP_CLOCK_PPSUSR only).
  */
 
@@ -218,6 +220,7 @@ struct ptp_clock_event {
 	int index;
 	union {
 		u64 timestamp;
+		s64 offset;
 		struct pps_event_time pps_times;
 	};
 };
diff --git a/include/uapi/linux/ptp_clock.h b/include/uapi/linux/ptp_clock.h
index da700999c..17ecbe755 100644
--- a/include/uapi/linux/ptp_clock.h
+++ b/include/uapi/linux/ptp_clock.h
@@ -32,6 +32,7 @@
 #define PTP_RISING_EDGE    (1<<1)
 #define PTP_FALLING_EDGE   (1<<2)
 #define PTP_STRICT_FLAGS   (1<<3)
+#define PTP_EXT_OFFSET     (1<<4)
 #define PTP_EXTTS_EDGES    (PTP_RISING_EDGE | PTP_FALLING_EDGE)
 
 /*
@@ -40,7 +41,8 @@
 #define PTP_EXTTS_VALID_FLAGS	(PTP_ENABLE_FEATURE |	\
 				 PTP_RISING_EDGE |	\
 				 PTP_FALLING_EDGE |	\
-				 PTP_STRICT_FLAGS)
+				 PTP_STRICT_FLAGS |	\
+				 PTP_EXT_OFFSET)
 
 /*
  * flag fields valid for the original PTP_EXTTS_REQUEST ioctl.
@@ -228,7 +230,10 @@ struct ptp_pin_desc {
 #define PTP_MASK_EN_SINGLE  _IOW(PTP_CLK_MAGIC, 20, unsigned int)
 
 struct ptp_extts_event {
-	struct ptp_clock_time t; /* Time event occured. */
+	union {
+		struct ptp_clock_time t; /* Time event occured. */
+		__s64 offset_ns;         /* Offset event occured */
+	};
 	unsigned int index;      /* Which channel produced the event. */
 	unsigned int flags;      /* Reserved for future use. */
 	unsigned int rsv[2];     /* Reserved for future use. */
-- 
2.39.2

