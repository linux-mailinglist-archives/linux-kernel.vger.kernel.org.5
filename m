Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B97C07F08EC
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 21:51:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbjKSUrj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 15:47:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjKSUrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 15:47:37 -0500
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02olkn2022.outbound.protection.outlook.com [40.92.49.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE4F0E5
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 12:47:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dZ6TCziyavlHj10hJp3W403mcCfqTNy7a/oRAmRuTjcTCqBlgdPQxqz0r2xzu9CmSveK8D/+Kj/MiIhJuFuWvN7s2WXmYJxPoF6igf0UbhBFIjxgZb3M0JNJ7shhsjXPJHGqi3ZFUX1/DRNkujwQtTNQ3Mn4tjSOBAEEwkuBiMQbgZYPt5JOqzfkgA0CNUNLxzrZGJXE60B05vh9VRFEakZ83fWjht6IFcuaa0PpYLr8IA6biLXwXqERAWWQQ5W6imE/qWqyXA58Hff/NQGCrXWC8J1sPEc9ZtxQclEu5MSjS+17eISuqDYGR12NwkKaymDmxRx+biUOM1ykbN8PLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YsUMSVOnhh1wXQpueuIRtJL4hWzd409vv6M7e5vGF54=;
 b=nuHGYU23NVh3g1EOwNmddWjVH/BxBIzZROjT8n1gt3kQfuz2K9MVi+WBDuyeP6EbbrsYIt/QN7DFwYHSw+pRp5xw2vNbME00xvTKd81kdmYU78kz8gUAN7BA3j4mbFm6e6bH7X7uEFUXhm9ZFkU6w2P5NOiX8Pkxh1z7nkKVcRnydZOCxYzRDqox/YYIxGJtWeklTqEsM5ochyHPM0Qrs3/Hfjxp9p4mMVyEKVsJfGuR6r6VNDpG9WFFJ7YJCi9G9qy3/g1qhyWGcWqn2qy3jEmR2p45ApMjhp6FV4XkC6egPUQhuxoGYLinIGefSN6S9dG12LE0NQmwgYk1WQGSAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YsUMSVOnhh1wXQpueuIRtJL4hWzd409vv6M7e5vGF54=;
 b=pz4rspAq5luXpr3p4Q63T+UNhrMMHSEuhSNj8c6Zxv0CTQfAAQYOrVs2vcS4PS/b7r+KOCicCbd0mA6XwRMf8GTmopEZQtjj/TGipxc5qgG7MQ//Kfnfg7UG9QqhDYoMjq+qqRJWHjcKbNASB2IUdp9zgVU+N9UnmqMIQ/b1zB38HoEeYAAnGngRZ/T4wtjJYdUSLO/ZgCPptZEuW6QxPxnAws8FYirqFUIOGBBXg5kDsSvaRZQmAvNq4L1ibkeZ/wrNLE8XF48mQNUlQyVQzMRJo6+6wwHmLgU+i4sDkvEZpYtZ/ATN/FTGAPL91muu/L9Ino2NUSyYJ6UcsBz0tA==
Received: from VI1P193MB0752.EURP193.PROD.OUTLOOK.COM (2603:10a6:800:32::19)
 by DB9P193MB1354.EURP193.PROD.OUTLOOK.COM (2603:10a6:10:2a0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.26; Sun, 19 Nov
 2023 20:47:31 +0000
Received: from VI1P193MB0752.EURP193.PROD.OUTLOOK.COM
 ([fe80::fdd2:7dbf:e16c:f4a4]) by VI1P193MB0752.EURP193.PROD.OUTLOOK.COM
 ([fe80::fdd2:7dbf:e16c:f4a4%4]) with mapi id 15.20.7002.027; Sun, 19 Nov 2023
 20:47:31 +0000
From:   Juntong Deng <juntong.deng@outlook.com>
To:     ryabinin.a.a@gmail.com, glider@google.com, andreyknvl@gmail.com,
        dvyukov@google.com, vincenzo.frascino@arm.com,
        akpm@linux-foundation.org
Cc:     kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH] kasan: Improve free meta storage in Generic KASAN
Date:   Mon, 20 Nov 2023 04:46:29 +0800
Message-ID: <VI1P193MB0752DE2CCD9046B5FED0AA8E99B5A@VI1P193MB0752.EURP193.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [SDLZg+o5aRh8rljxMKf9GYjanOwFCPPo]
X-ClientProxiedBy: LO4P123CA0068.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:153::19) To VI1P193MB0752.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:800:32::19)
X-Microsoft-Original-Message-ID: <20231119204629.50560-1-juntong.deng@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1P193MB0752:EE_|DB9P193MB1354:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cb3973d-d264-4571-b623-08dbe940c005
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ioV3GNxZUGwzbi/BEEUl0gzZWb9LAeS7OutWNDIxlenq3o4+taZRHbmYYqT9lA111nA581bCHKFdi3hJ5jJOcY8VGH+KvPFmgjoz5gN7Qa+pDLY5fPC9iEuhQqgpDgE33Y/eRVYvX1OxV80rjtUbFEuuyq4SBeqPeFbmjiCfB/v5X5LjqhNrr1NBJe8SP9ee+EBM0WXnbkP8zZUMj3Pae9zo8En389hsT7Cv2rjiAixev33SGRet1dqkONR/jDBJH8eAiPdKpl5fO7UqKQmMQ4Tcwkh2lT6ogcb6onhmAWf12M20FeXcrVhEnGahSn4+ylcIshP1ChryAMRmhxSjqP1mg0qzHMErnIxQ6pbzQkGy1MAlwW2R7AM5TjXSlGA5DHeoFapaz677/nxbsvCQnjAjaNJvHzGICk30lI9am/115hXWVAsUvEjVLPah71sGGxX9rWLGb4kIw7S0N1qQ1FlRTEYrXuv0QSD9hzUz5hUAnhOgp5SWN51lURZPlgSK4QNqiExaSV9qGpi5292pjBTIBwPcVBoVE1crzgT5BMxJu19AI0QQWYeBB8/3BC79
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WjmwsBQ18Spe/TmVvGEh0LyWLWl7JE5KdCho1V6eRVQEYgxzcRzHOfLNdUJt?=
 =?us-ascii?Q?r1xS4KkuybMzQbfcYDZTvxuP3wDETcFdYm4KTHzRTlXDDjFwUMuVSpw3mBJq?=
 =?us-ascii?Q?WyFAPkRnpq3CHVcK+zOgmj+rlSNlORuCG+8ZrTfL0+mWA6SMtWvOjHG1YVAk?=
 =?us-ascii?Q?0UKJpgAc0Bg2pNgJOpLq4STi9vWdvxyoTtkaZtE04qdz/W5KhB87DoaHvhcf?=
 =?us-ascii?Q?DQyovu5ZueTokgf1ZTDMVWJJ8lo7QrUZ3f29WQvU2r6DnMVoXpwruY+z7tDS?=
 =?us-ascii?Q?zQctzF1NX2/17wdr4/p0tRW48Fgxmh6wArQEFtVTkG+R1gl88jnFNlEp1uvA?=
 =?us-ascii?Q?VCXc+aCk5hHX8qy//6RPDOXBcQVAqBpivwHM2FMVCroRFlmyEQMCb+nuXFMc?=
 =?us-ascii?Q?9rnUPlrG29X73ws5CGwzn6GMEugOPuP13LXfSzcMglsoC1a5VF+uKSAedw5U?=
 =?us-ascii?Q?SMbRuZKpv/Of7r/32eRPuvCyt14c1LQysfafyc4oOW5bfhI5lPlLHN3f82Ak?=
 =?us-ascii?Q?18C73l+2CJr89GjhhOdOWEIlgHjrFAMXlkPZrmbDzooEIvjULtRH1mS6U2iq?=
 =?us-ascii?Q?xLYSWI2d8AJQeHJ5krlqf7bbNMAb2E6HB8LH4nvzSQdzOwsMITJ5u0cXHbs0?=
 =?us-ascii?Q?f4WlNPHebjAC4sIDDCBd1OMcrxXITY+tIyqJn1Ojc0YmAisbNwBF/PpyPvH8?=
 =?us-ascii?Q?LiafAvn/Y4EAm1qsx10KB8eg0UAy0I8St38raLXXQhin8T4OVXUbYajfVD3/?=
 =?us-ascii?Q?9+buoiKQiSrv88icdTt6PeIBmLZiO/biNSnt4D01VDIoxYjG4wNkHkRR3hlh?=
 =?us-ascii?Q?e47nTKsaDSOBFbpRxLevrFwoRKGk8NQsSp5yHSH+z/A9G+h61RufRRmVjbx3?=
 =?us-ascii?Q?fr91wfWeXKPx6lMBlpoWJuSZk0wIUAEo1evGTJ3tGAryvAlz5r87VwVWxxmF?=
 =?us-ascii?Q?+WK/RMFj9NK4WLFXdowOK/4/7f/kriC0LZFaBGFzPirHkngrHXQngy90MjvE?=
 =?us-ascii?Q?MS1BsBu8+2BlVb1iGaD8duWZVgYc9f0ws+SFXaE3FIwlBOUaTOV76lfp5yrM?=
 =?us-ascii?Q?Fdgdlf+GIkT8uf+g8P2td6LTPlDe6u56MPP6es17rx2P+Gwnf596/SFVWl8k?=
 =?us-ascii?Q?iAgt0IL1jed095pyu/QQYhe6qz698RlKE0e/eaNHkpdI9BkJg+Ej+wJEdiMp?=
 =?us-ascii?Q?ix+fxUJ+xUnDf25WxHunaDJaKI9+uiTwILa9ZQuW48q8+xNdNil/CKvMULQ?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cb3973d-d264-4571-b623-08dbe940c005
X-MS-Exchange-CrossTenant-AuthSource: VI1P193MB0752.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2023 20:47:31.5305
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P193MB1354
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently free meta can only be stored in object if the object is
not smaller than free meta.

After the improvement, even when the object is smaller than free meta,
it is still possible to store part of the free meta in the object,
reducing the increased size of the redzone.

Example:

free meta size: 16 bytes
alloc meta size: 16 bytes
object size: 8 bytes
optimal redzone size (object_size <= 64): 16 bytes

Before improvement:
actual redzone size = alloc meta size + free meta size = 32 bytes

After improvement:
actual redzone size = alloc meta size + (free meta size - object size)
                    = 24 bytes

Suggested-by: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
---
 mm/kasan/generic.c | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
index 4d837ab83f08..286b80661a80 100644
--- a/mm/kasan/generic.c
+++ b/mm/kasan/generic.c
@@ -361,6 +361,8 @@ void kasan_cache_create(struct kmem_cache *cache, unsigned int *size,
 {
 	unsigned int ok_size;
 	unsigned int optimal_size;
+	unsigned int rem_free_meta_size;
+	unsigned int orig_alloc_meta_offset;
 
 	if (!kasan_requires_meta())
 		return;
@@ -394,6 +396,9 @@ void kasan_cache_create(struct kmem_cache *cache, unsigned int *size,
 		/* Continue, since free meta might still fit. */
 	}
 
+	ok_size = *size;
+	orig_alloc_meta_offset = cache->kasan_info.alloc_meta_offset;
+
 	/*
 	 * Add free meta into redzone when it's not possible to store
 	 * it in the object. This is the case when:
@@ -401,21 +406,26 @@ void kasan_cache_create(struct kmem_cache *cache, unsigned int *size,
 	 *    be touched after it was freed, or
 	 * 2. Object has a constructor, which means it's expected to
 	 *    retain its content until the next allocation, or
-	 * 3. Object is too small.
 	 * Otherwise cache->kasan_info.free_meta_offset = 0 is implied.
+	 * Even if the object is smaller than free meta, it is still
+	 * possible to store part of the free meta in the object.
 	 */
-	if ((cache->flags & SLAB_TYPESAFE_BY_RCU) || cache->ctor ||
-	    cache->object_size < sizeof(struct kasan_free_meta)) {
-		ok_size = *size;
-
+	if ((cache->flags & SLAB_TYPESAFE_BY_RCU) || cache->ctor) {
 		cache->kasan_info.free_meta_offset = *size;
 		*size += sizeof(struct kasan_free_meta);
+	} else if (cache->object_size < sizeof(struct kasan_free_meta)) {
+		rem_free_meta_size = sizeof(struct kasan_free_meta) -
+								cache->object_size;
+		*size += rem_free_meta_size;
+		if (cache->kasan_info.alloc_meta_offset != 0)
+			cache->kasan_info.alloc_meta_offset += rem_free_meta_size;
+	}
 
-		/* If free meta doesn't fit, don't add it. */
-		if (*size > KMALLOC_MAX_SIZE) {
-			cache->kasan_info.free_meta_offset = KASAN_NO_FREE_META;
-			*size = ok_size;
-		}
+	/* If free meta doesn't fit, don't add it. */
+	if (*size > KMALLOC_MAX_SIZE) {
+		cache->kasan_info.free_meta_offset = KASAN_NO_FREE_META;
+		cache->kasan_info.alloc_meta_offset = orig_alloc_meta_offset;
+		*size = ok_size;
 	}
 
 	/* Calculate size with optimal redzone. */
-- 
2.39.2

