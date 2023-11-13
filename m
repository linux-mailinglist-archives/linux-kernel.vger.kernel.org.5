Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42DFA7EA5A1
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 22:56:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbjKMVuu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 16:50:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjKMVut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 16:50:49 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10olkn2035.outbound.protection.outlook.com [40.92.41.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77E1619D;
        Mon, 13 Nov 2023 13:50:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KwJmKPlar8HTZfEK5P/hO7kHcoVwrjdF1hgBO0IO81vplcB1JKbNrpdrm+AO9Lomx+jcGeswb2xNKVXH3AdYx6g8o6OOGIiP6kro8e2twT5acudOBC//8k4p6m4VjAkZwkRFTSgTUIK+n05suXYdCLrNalZr1lbNGNG96U8d862Nqr0dffjs42WdOLg+oVlTmKUkwHg/9urBDInqBiGpbmJUBmwd20Q0Eq8u/BPyzjyDjyzlMAv3EDvmijian/oIXqLbuXeK3v9UU28yVIKkyMw79BJl+9w/Vryalog9liMA0nLEO7Aa9vZ8XdjM0vz+gmdbsBkaruoF0uYLx9CQow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2byRroOSLkvMjnOus5DWUJotAMGvn0TLDn9K8ShmcIA=;
 b=N281wrq8ly4mrjRAIBjRZ+lOJ7C0MWsKiATYsI+WczXtxcl+p4d62urzvy4akKZ3q+jtlPheoy03lFfk+6E0DV6MaqZIpRphIGq+zXoZRp/pkM/Wx0JAGMMt3c8RO+vEPlSZ/Onect3aP8Xwsb2fWGMkHmEHfu9Dxby330UTKratn490ov2TMMAUyDcbG17iXBYn4B1esRqgRo9peIv8/MgbxPUEvbi1pCu3R7hKRtRDryGh0suQavilua8kDXpHurxlBS6Jgbgc34QdoMlJS7+i/eeNKYYr/ZuA169T/IkLYaioQiudhgdZvrilb5sLRiVmWMXoxnM2qz5CVsQE/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2byRroOSLkvMjnOus5DWUJotAMGvn0TLDn9K8ShmcIA=;
 b=FuPI9pdhwfcnvyNynJR+OcZYvfM8QlYbdguCt793AFNIwgsxqo9xeBdwUVUsxMjRc8nj9AOGOymTO4kAgAxwjvxxf2FTqF1di0Pqn0tt5822jWuO/QdMFDGvygQtMKa0YQTNh2YbNHC3032/5c7cVUvGnsDbqbs68x45bAgtQv3VXWCLEYAUD6QbdpgPvMi7wvEMBAKbh1CIQkrZleVLZKyfCLRWWIeSD7QLijWaRua6AjHAyhqtrX3BzGOoxdOTDbO0NhHnwTUbn6k/SJ44+bLtajFjFMuKZ0ojoQtdhjkarZBv2Qo8gkChYz8FvzoM2w2MaFtA/hPDJV8jAUHRQw==
Received: from MW5PR03MB6932.namprd03.prod.outlook.com (2603:10b6:303:1cd::22)
 by CH2PR03MB5158.namprd03.prod.outlook.com (2603:10b6:610:92::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Mon, 13 Nov
 2023 21:50:43 +0000
Received: from MW5PR03MB6932.namprd03.prod.outlook.com
 ([fe80::e204:782d:2249:36d8]) by MW5PR03MB6932.namprd03.prod.outlook.com
 ([fe80::e204:782d:2249:36d8%7]) with mapi id 15.20.7002.015; Mon, 13 Nov 2023
 21:50:43 +0000
From:   Min Li <lnimi@hotmail.com>
To:     richardcochran@gmail.com
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Min Li <min.li.xe@renesas.com>
Subject: [PATCH net-next RFC 1/1] ptp: use extts interface for the measured external offset
Date:   Mon, 13 Nov 2023 16:50:25 -0500
Message-ID: <MW5PR03MB6932F6DB45F5ED179DF0BA4DA0B3A@MW5PR03MB6932.namprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [J7BIvzjlHmgAaq4gfuYjZ/mhD3t6IX+8]
X-ClientProxiedBy: BN9PR03CA0058.namprd03.prod.outlook.com
 (2603:10b6:408:fb::33) To MW5PR03MB6932.namprd03.prod.outlook.com
 (2603:10b6:303:1cd::22)
X-Microsoft-Original-Message-ID: <20231113215025.17448-1-lnimi@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR03MB6932:EE_|CH2PR03MB5158:EE_
X-MS-Office365-Filtering-Correlation-Id: bd62116c-2d39-439d-a913-08dbe49293be
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yAflIVxXzSms+pJLWrMezxEMbvfweN0ghwlzC/jjmnACCQHxGaY1vJpwHmePpoN/n3QwO2J6lpxfnwwZxbrhm1LMynOjCVwEQnccKFbIkiDKX5ZM7XAelXzrpSymxHVI46QiFFeifOSYjW/PirUmvDQect7bHpjERlnvOHAg204jEk7NikwTYoP2es9+ifwl4N+IrdGce5HnDR5opboyijxnZhWNeZNhWSg5E0SUGqBXB0uFS2l2hzoZc73R42zuT3nGQlQ+VdwvH2ZMBVBKGJC8MJ4EyTl8r6Jho7kf5RnrbTHRDCKeAZ6iWJ5BiYZzBVdThM/gY+jZqZxzSqb/hy0mHW9h98fn0DDrCH0c7K6SEyxw2QAI1dubCR5LFIIgLcIi898fdCagqmOVhQloapOOYuAbnytrtvV8YPkU6PkfllfGlSsHCPVhhnmVOt1OdVGzne8ogtfjNWU1lEGTI3ZCsZ1C+7IpTxIbQkGEztCtvP+lp0cBoueHbN8zfYajORFLtpp16GMOViVl/nusVaXGCqF2XpH5U6foD39lS8NWUDFKotkx/BveKV7j7Ox5
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Dq5rmsqbD08P/BmesLAldLB1vV0dKQRxvTSKdK/vMbIg3pTx7i0mXgfCzOoS?=
 =?us-ascii?Q?WH9v+a03y2RSAyqdkAFr17MnJZb48khKynMsa3XgaLnF9E900L56gzke8hn6?=
 =?us-ascii?Q?L7S2FNy7QHKL4EgTZe23QIOkt1LiS9SFIBXCggTSbIzifHRsyjnov/jfG5pk?=
 =?us-ascii?Q?6UEYMGBUnLrm88Z8ef85tAWVmqb8aYdcjGJ9ViJAXJoxEXqfADq9gbkW6ISx?=
 =?us-ascii?Q?9hLNW4aLEHzoNHr4Qbe0AGB+CF2vCyTiWFlyHkA+qwd3EV6jD0jei9OqtfH7?=
 =?us-ascii?Q?J78X8KwE9g2ymiLpIS4i0bV02vzk/Q+lEgzvlQ1nS5sm5HTQ+wO/j8yi+YyI?=
 =?us-ascii?Q?GmBchqbWwdRWgEYJNDwSlm+Ko63eZvnQHYiUDFKR6OU4lnQFlB3SXS4XmOqt?=
 =?us-ascii?Q?43ROQ2c1wGKlMDLx2KL3lWsMQHBQygaI3VayNQdPHZ/seH0UWxfctYqRWbfr?=
 =?us-ascii?Q?QULIkp8JvvjJYmMeAALGbhF9A/5DJtCh28FTsFkTX/icoe/VuOEGzLjAKIIO?=
 =?us-ascii?Q?W1gTOyYx2pbJ00xtwoFXQj9eh/6a2LGHlmMDDBDI9Ipil4hIFFM+nzmMQ2kV?=
 =?us-ascii?Q?OVUzrP0ugW/LEwgYooLr2h6v4TQX6EbQ+n+F1pl6y9ZkQ//PlRDLcb7svu8E?=
 =?us-ascii?Q?s5hSC76xexFIEsILXNn/YBmJHX35vqg+m8eUebd8lBpM1/C6eFj9eobqWB0z?=
 =?us-ascii?Q?aCr1l3akk3uzye/wc3v0pzocn7I6+yeZLY3rdKRgHOD9pVeahYZKDnoKhjS6?=
 =?us-ascii?Q?NQfsFz5CRaHtm/QmhaNK4ZXkBmptQSkn0Y5dZzfOhdKmgR1HeyxDk8M3YZPP?=
 =?us-ascii?Q?Z0RvN6g1dGPNJvpBO3mk+EISkAqmPqbstBeh81Y8lKTewzZyLW+tCnsgGQC3?=
 =?us-ascii?Q?xmKA7G6e1SzOk78jauwSriP6QzUlXkJ8rj31pp6N4PneFT6UUzkmI6LAfrFX?=
 =?us-ascii?Q?wZwkbG8i3MCxOFexKQRdvgTySFJTTvZ82i52MjKDGNmTxXNWP55mbriV7+YP?=
 =?us-ascii?Q?T2BmhnCmOTq0I/ak63NQ+w1PIUWjnJkX1UP7KZxLU1J/LggOUi5tYTZKFRm9?=
 =?us-ascii?Q?Ulbf456C+WSbcLEpi7s94jAbh4UgLHy9MupBkFTzRKLiZA7lUjmEd4AU5620?=
 =?us-ascii?Q?L8DRhSFp9HT1//Q6+L1TPq73V2pFtUxVDojcvCWmAz+vPS9pfBv+0Mzmknlj?=
 =?us-ascii?Q?OK1M1oRnef35NdTzXSomv0LMJKQsMt6pTgF47A=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-839f4.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: bd62116c-2d39-439d-a913-08dbe49293be
X-MS-Exchange-CrossTenant-AuthSource: MW5PR03MB6932.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2023 21:50:40.4984
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5158
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Min Li <min.li.xe@renesas.com>

This change is for the PHC devices that can measure the
phase offset between PHC signal and the external signal, such
as GNSS. With this change, ts2phc can use the existing extts
interface to retrieve measurement offset so that the alignment
between PHC and the external signal can be achieved.

Signed-off-by: Min Li <min.li.xe@renesas.com>
---
 drivers/ptp/ptp_clock.c          | 12 +++++++++---
 include/linux/ptp_clock_kernel.h |  2 ++
 include/uapi/linux/ptp_clock.h   |  9 +++++++--
 3 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/ptp/ptp_clock.c b/drivers/ptp/ptp_clock.c
index 3134568af622..c87954c8642f 100644
--- a/drivers/ptp/ptp_clock.c
+++ b/drivers/ptp/ptp_clock.c
@@ -48,14 +48,19 @@ static void enqueue_external_timestamp(struct timestamp_event_queue *queue,
 	s64 seconds;
 	u32 remainder;
 
-	seconds = div_u64_rem(src->timestamp, 1000000000, &remainder);
+	if(src->type != PTP_CLOCK_EXTOFF)
+		seconds = div_u64_rem(src->timestamp, 1000000000, &remainder);
 
 	spin_lock_irqsave(&queue->lock, flags);
 
 	dst = &queue->buf[queue->tail];
 	dst->index = src->index;
-	dst->t.sec = seconds;
-	dst->t.nsec = remainder;
+	if(src->type != PTP_CLOCK_EXTOFF) {
+		dst->t.sec = seconds;
+		dst->t.nsec = remainder;
+	} else {
+		dst->o = src->offset;
+	}
 
 	if (!queue_free(queue))
 		queue->head = (queue->head + 1) % PTP_MAX_TIMESTAMPS;
@@ -416,6 +421,7 @@ void ptp_clock_event(struct ptp_clock *ptp, struct ptp_clock_event *event)
 		break;
 
 	case PTP_CLOCK_EXTTS:
+	case PTP_CLOCK_EXTOFF:
 		/* Enqueue timestamp on selected queues */
 		spin_lock_irqsave(&ptp->tsevqs_lock, flags);
 		list_for_each_entry(tsevq, &ptp->tsevqs, qlist) {
diff --git a/include/linux/ptp_clock_kernel.h b/include/linux/ptp_clock_kernel.h
index 1ef4e0f9bd2a..7f2d1e1cc185 100644
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
@@ -218,6 +219,7 @@ struct ptp_clock_event {
 	int index;
 	union {
 		u64 timestamp;
+		s64 offset;
 		struct pps_event_time pps_times;
 	};
 };
diff --git a/include/uapi/linux/ptp_clock.h b/include/uapi/linux/ptp_clock.h
index da700999cad4..61e0473cdf53 100644
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
+		__s64 o; /* measured offset */
+	};
 	unsigned int index;      /* Which channel produced the event. */
 	unsigned int flags;      /* Reserved for future use. */
 	unsigned int rsv[2];     /* Reserved for future use. */
-- 
2.39.2

