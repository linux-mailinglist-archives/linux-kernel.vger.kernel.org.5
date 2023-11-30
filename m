Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2D3F7FE682
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 03:10:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344103AbjK3CJw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 21:09:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjK3CJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 21:09:51 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2116.outbound.protection.outlook.com [40.107.255.116])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C8FBBD
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 18:09:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SWltMt2M5a0wGxlhXZVO33lAaRlnoxvZ0rOjDgjb422tAbdenXO6FxXW4Jb2e4g/vCRmP34P2pji6YDgmjLh5pF1F+WpoIk/2cR+hXQ6CzLK/fsVGpleXnCsMmj+2coSNrC/crxqrm4yxwYviVF5tDf5S/7/LhMeyok3pTJvpLXxzZ0CnPfWNjICsQHVkhjt6WhDZXsUg2em/0RMdwpdV8TfZV5dKdhUvX8pV8kRgRvls8VGO0VrSOTOR4pVEbLk0b7q33CrJz0QG7WIIKX7AmVah27q6ikNvDlqtqzNiQk2vsho+my3iXIRT63dNiRgIQ5RvQqUkpOxD42GiX7cXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FA/5Vu5iZVP3F9frGjMZA3p9wNRLaqCg9Us8L5YqaBo=;
 b=b2zPbyWx0h57wu321viTRUiSBNXGlmXT9YN1D/KEfqlkPImo0XykpNqd5gL3TBTHkqFPUFVYbAz7kjesWj4Iulvc4Rl2n2JfzJO2Mpw/I/B4kynnbneYNK76G5Qq/KeAXehBQoebKXPTaRm5xFb6cgeqPQE2cGJu9Y8KCfe4SLJ1tXOlSLlxxHGQAL00PhDZnEuQxk04uKhUfjRo/spxc5GlL2ur9OeA2dtNGJ2lLQm8gCr+qpjIhBe/R2ba9py6V1UPHKxMWtO5orQZUMEs6vvuPNIp5Wea7RcR2Rg6ceDrWc6PNkB5HDWahY27DXj/mt8enIBNUGqoGelUUHy1WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FA/5Vu5iZVP3F9frGjMZA3p9wNRLaqCg9Us8L5YqaBo=;
 b=aalhQ+E5ByNUXnkFj+nsAb3//Q2uQL6SkLxgPw6nd7s+7FkMVhOxiDxoQRPjaheuVgmlpjJM922+bt8QgmAPdHhDixiEo/NPrkcMs69SD4cLCn4U6C4yV1RgrhxrVoXc78KjNLWU0j6VHI/SwKF1Zh+TOMnyy6hknKZh0U4zGYrjBRzC0FuYZQQzPh5Qx77WTzgJl0jDm5R58m0zI4cd/0/RNfqDDHGvLDucm7QEjaAUc41JAp1T2JDkxjFb1gMqFp/EP9A3T3fxNc4MaYVb6KVhiqmsDpqiwGlgAkxPA8Uk3M5LExL4P0yyhONiqjZEePYxSrLvNRK6tWnsurPmLw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
 by SI2PR06MB4347.apcprd06.prod.outlook.com (2603:1096:4:15b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24; Thu, 30 Nov
 2023 02:09:51 +0000
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::1be0:ebf0:eb04:6bd3]) by JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::1be0:ebf0:eb04:6bd3%4]) with mapi id 15.20.7046.015; Thu, 30 Nov 2023
 02:09:51 +0000
From:   Zhiguo Jiang <justinjiang@vivo.com>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Matthew Wilcox <willy@infradead.org>, opensource.kernel@vivo.com,
        Zhiguo Jiang <justinjiang@vivo.com>
Subject: [PATCH] mm:vmscan: fix shrink sc unqueued_dirty counter issue
Date:   Thu, 30 Nov 2023 10:09:19 +0800
Message-ID: <20231130020919.2154-1-justinjiang@vivo.com>
X-Mailer: git-send-email 2.41.0.windows.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0037.apcprd02.prod.outlook.com
 (2603:1096:4:196::8) To JH0PR06MB6849.apcprd06.prod.outlook.com
 (2603:1096:990:47::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR06MB6849:EE_|SI2PR06MB4347:EE_
X-MS-Office365-Filtering-Correlation-Id: b862e9ff-2fd6-45d3-a6eb-08dbf1496fbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ulao2JzQ8MJNtp29D7yXmoS0MJlKC6VtQuzUVbpbB+qs+YXMB8x1fQCDr1QpdnMh6b3Zjox+eS8F5h1DcmRqlTvwujY4/QZzTAL9BzlXqge5o45nyaKcQepHTrMc6pLXKUlS6SJ5AJmaIt+gquTy0CMc4hciLisypOakhCjC2CclEfzAdk1JlqWjJeGEvElj2Fmyqqc9oju39bUhIqATFbzIMhj5l4q/Z6RhSpxWUzfV3LgZPII4O876IWBTWj4zObECKDRHe0+UxdBJMbI+RwQbSUa+y047qIDsvjAm2Uve23l8JIKKLqNYxgDcw2jHXjlqoqq3xRI4gg281Qa9ZL4VkfAA6jYOx8pP+NutefAyM9RNHRm+4u8uOoX0X1DCfQ+mAhMIMWCU0nO7d8LZaF+rWA14o0Hsao5sVkK2qso+PvMzkxooPW4HqhhbuiT3/lGMv50ipSjeBTM3+rZ1uCtq/GwWxPjPLXqu/wRfo0GfUtcxvMuiAqk7Uv8S6Txue/OwQxI/sZMSOjaqhwkXpquKdgnAaPO2U0lOp3afK1sdH/UD4jATzVYA6nCC1EXcKlsdiNWgntXaoN2NZJ0suY9HTGYOUgaPd2qv+GiP2r43ushKseFRQrjUMuw09aqe/qH52mBt5ItYEBQGsSiGGcMWnBSvi9Y5mXyC0x+J2ZnmSUfvCQbyqWdhbf9bFlLr
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR06MB6849.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(136003)(366004)(346002)(376002)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(478600001)(2616005)(6512007)(26005)(6486002)(1076003)(107886003)(6666004)(52116002)(6506007)(83380400001)(41300700001)(2906002)(4744005)(5660300002)(54906003)(66946007)(66476007)(66556008)(8936002)(316002)(8676002)(4326008)(38100700002)(38350700005)(36756003)(86362001)(202311291699003)(14143004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HtFggMIQDNVx8MRaY7OaQc8i2iekwhEhYIEpqJlPxLIud5BJVGLUajF8RluZ?=
 =?us-ascii?Q?L3GjRntQxXnSEhaYBu212vB9CiGZu6I8nB52hS5OkgDKFGfGWsDFk2gKdAEk?=
 =?us-ascii?Q?4rgBlOLFY3XlTAC065hOvH/O3fzKftr3Wboci01yK52fzfymi2pQIEY7BP65?=
 =?us-ascii?Q?mvD32ky5iqwmfCsl5o1vMKi8jxneqWJ2+tD9ykQhinsKbSZPVmJ9SfPglWvD?=
 =?us-ascii?Q?N2fH/6IbZpxjHdSwbTADf/imdEDnpbf8ME6l8p3n/9dFpMd5uA5Bfx8q7mDZ?=
 =?us-ascii?Q?RQe0KBaAvZTojua4yLtrcHC2GzeAREv5Ly3PAw0jpiKbZPZrcFBSrjT1Aa/K?=
 =?us-ascii?Q?plEZk0C1vkNyqRrk8dAxKV15FNHDwVdYPfOY8OD9e+bJSyNL0tb65f54Di48?=
 =?us-ascii?Q?e/Lx8uZ/0OlSTS7dmaIVsuW+Hrf8y8G5wTcjuUlVPM0g2Ajw89S1ab/YORn0?=
 =?us-ascii?Q?O8209tAcXuVZWqk5cMA97AcQr1GuFJmlKC7p5/BVV3qjSxRzWYtKj1DLgy3X?=
 =?us-ascii?Q?yZ1Y3huD4lt/wgHQ1EJUpyH94RIQFrKiXlgaP+R6QEzlDXERGnfFt9Vt0sl6?=
 =?us-ascii?Q?UOEwI3XQPksSQUlpqZV40Lq5Xfq/kHhB5rdZcaiERgMNMR/JbEnttyEgPTAv?=
 =?us-ascii?Q?DEEs+Eud4auKgH4caQV2q1N73z9pOx60cV251m+x8LQZskt7ZE9JFwfEYG6u?=
 =?us-ascii?Q?r/hn5eROTpkxVs+2bWetCLqmTnTfi7W1k0yoIHA//RsglwTo8j44PK6z0NF3?=
 =?us-ascii?Q?yQd7SKFGDg7QkKqDThuBx0T5ZH5XPgL6EdgHsyqHNh9+JK7rlHaGL8xaQl2x?=
 =?us-ascii?Q?2HyXodXCtVoYdlq6YP15UOo7760NIUiTTdLex/47Wvq3frLcQWE8iSLbOBsf?=
 =?us-ascii?Q?YoMMRW6ir9s1tXfn+o34y7zg/0+p+ruEPfZ8l66XljnPoEvZko0EIHqvtos5?=
 =?us-ascii?Q?HH0DavNmA1ZKWsCJbiEeKwrh86zIBHflQAe0rpydpzGB+LybLjP8lMryog83?=
 =?us-ascii?Q?Sj6erharlCnBFLcziMlX3gQqAU8oUFT+w/t8JWKhtta6XK+eEdG3qxtqjIYH?=
 =?us-ascii?Q?VuFT0/w9saoxj6ihm6f0lno3SEZp900uGDhOdtjR9Vk2UJdMV+0JDd2OcLY/?=
 =?us-ascii?Q?jr9MaWh5NeVaABBf4aj6Zcvdn94+dVtnOtnxOynqw9HWB1u9pSw85yR1ZtXj?=
 =?us-ascii?Q?U6QqXAKjpr6eEPVC8A5wmpwpSjncp96MeLPipBJkxFrr0ohM5HWqN/MZaYRW?=
 =?us-ascii?Q?xQmAfBYveBgTGA+4cvz9HZSt55IeBXj2fuLmY1tWhbc8sB6Ffe4ZD/iA4CuX?=
 =?us-ascii?Q?0NEhgs3hPI85GpFISrzc6ERdiHU/Jc1tg49h368qgeZjpg5KXCrKZHk5gMwX?=
 =?us-ascii?Q?sP67hffAw56co+nLly3H0wFqswstqLjgjjYeM8A8+5qDmEOpKo11Q7Aj5k9g?=
 =?us-ascii?Q?jXuTr8KrQ+zGP84kPpl3pKHp5jm3YXeSW3y2pqoshwKMo3kvUbKcWJJorvxJ?=
 =?us-ascii?Q?ZzuuYLcLuyTSL/+YahQg6l9q/4gji/yv0Q/QHzgjomCVRFF4R2/ozfghpCQB?=
 =?us-ascii?Q?1abjMhngLmSAt4KIbV5GoDbGyb61hz38Ltl4GZuq?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b862e9ff-2fd6-45d3-a6eb-08dbf1496fbe
X-MS-Exchange-CrossTenant-AuthSource: JH0PR06MB6849.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 02:09:51.3610
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4N13b95GnVIkS0drS6+PsnlRF7o0VNgAWm3pu9aSzRs5wDsikxlaa3AbOEZ+dcdwzJ5OMYtlswxVBVY3wKWMQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB4347
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is needed to ensure sc->nr.unqueued_dirty > 0 first, which can avoid to
set PGDAT_DIRTY flag when both sc->nr.unqueued_dirty and sc->nr.file_taken
are zero at the same time.

Signed-off-by: Zhiguo Jiang <justinjiang@vivo.com>
---
 mm/vmscan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
 mode change 100644 => 100755 mm/vmscan.c

diff --git a/mm/vmscan.c b/mm/vmscan.c
index d8c3338fee0f..8b0c4d025c76
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -5915,7 +5915,7 @@ static void shrink_node(pg_data_t *pgdat, struct scan_control *sc)
 			set_bit(PGDAT_WRITEBACK, &pgdat->flags);
 
 		/* Allow kswapd to start writing pages during reclaim.*/
-		if (sc->nr.unqueued_dirty == sc->nr.file_taken)
+		if (sc->nr.unqueued_dirty && sc->nr.unqueued_dirty == sc->nr.file_taken)
 			set_bit(PGDAT_DIRTY, &pgdat->flags);
 
 		/*
-- 
2.39.0

