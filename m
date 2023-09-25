Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FC0A7ACEF8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 06:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232039AbjIYEAR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 00:00:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232041AbjIYD7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 23:59:53 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2134.outbound.protection.outlook.com [40.107.215.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 581AEE5A
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 20:59:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZKnrE3vRZwqYKhTXWV0y96QPcNj+ast5F/eNvNUuf2CncuQUqrAIEYaDMpLie5Fo6UpzP1OMJRc+SG/W6c4oxmmc+V86ea/XRIqv1RbSYU/X6TLf+vuLpK78m5sMY9Xpxqu5VjO5KvXCdKKwgb6DWXUjFcGpyFG7+IKDrLDa0Tr3NJjSojcK1t+PWULLjPMUNMf8cRvQJFsjHo2/EMnePfu+Ds9+UD3JOQr3XvVQVAVAOQGE4wvpjVA1gw7Vx9UmfZHHzse9V52mnLgPxA79vTI0dfgHTmap81KrkeNBFIwh48ZNMBdkY5cKrps68heihYk9++PuCcc8MFqvEXRXVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JzysWamZK+9kW6UWVQs3wGfzLoPboH5hnc5SyBpbi3s=;
 b=Fne7WelFhJZ9wuWTFJz4J3tYPXgGJl0fKW6MwZCYGP+Gp2kGBwBhetrDm0M3c00Dufa1cUt6n66//zeE29aQhZr5/tjKC+JHMpi62hfodfZoQLY5yf3XG0G7WGSBv2bC4epgKUpq8F8/BhTwacpud0PWRNDAF20hUK//Kvm8Rogihe/cosiol9mr6T0l6hzEheviTcLujE9CuFH2J1O7uQlsuwfToykRrK1EGYwkIhLccruh2T+C3yEb6Fg0rCtPXnvCQbEp1O5x4JXucye9K9b/4eut2FqAreEsDjkvhM/0IgIHlahy0FkQyhYCKNeLqyXOEhGoX9L9ylcbXFbW8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JzysWamZK+9kW6UWVQs3wGfzLoPboH5hnc5SyBpbi3s=;
 b=aOsi/zw0S4Mnlt4NqysJgs+yLtQ453AzJbgiWUd/d82WQU3X+p0lA4Ec9aaor4ijiCURRmLRsdgQpp5ElDDRTcaC3bQUJHzWULIyvB0Kr+ph2IiIdKI0z4Xo9BW/wvU7QIUcDWgUTNXIv6yGTfcaT8ZlcfgR3hI9q90wrBRidMzhqIYZbSIVBbqj6uYr/8X5XAcvPYEqt61E+lUqKl5kh373IzKspas5Q0/lMMt8MruCOtaXE2T5J0N0bYTcnUHZFLtzBivMutr0CAz5UwI6MLyQNNEQcubU9AvIdg4Ps7DIlZ57NDrnGCau1j+8dQFebteIzyiBwijyqyfjrBy3tQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
 by TYZPR06MB5179.apcprd06.prod.outlook.com (2603:1096:400:1f8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Mon, 25 Sep
 2023 03:59:21 +0000
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::832:19a2:2f83:1cfc]) by JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::832:19a2:2f83:1cfc%4]) with mapi id 15.20.6813.027; Mon, 25 Sep 2023
 03:59:21 +0000
From:   Zhiguo Jiang <justinjiang@vivo.com>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com, Zhiguo Jiang <justinjiang@vivo.com>
Subject: [PATCH] mm: vmscan: fix kswapd nr_to_reclaim repeated calculation
Date:   Mon, 25 Sep 2023 11:59:07 +0800
Message-ID: <20230925035907.1723-1-justinjiang@vivo.com>
X-Mailer: git-send-email 2.41.0.windows.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0052.apcprd02.prod.outlook.com
 (2603:1096:4:54::16) To JH0PR06MB6849.apcprd06.prod.outlook.com
 (2603:1096:990:47::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR06MB6849:EE_|TYZPR06MB5179:EE_
X-MS-Office365-Filtering-Correlation-Id: baecdd99-8279-4f0c-2f73-08dbbd7bcc3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YVJxNYsw07aBQMBVGFHDuYebJBH77jHXOq3p5s5+YseW/43LhDUzI0Le3LK8OeJBq0ixlmQA9ZcKm0pJ6tGYw/OQ0H0keDPlW+7BEmq7cI0IBTjt0SHJ65CbdRz6mTEtQLE1+kQy/p8TaWEyfz62L08JIwQtA4ei0P4p/ZX7bkSc2sMNlrOK6D3Y8BZoSQPbArGFHwFcRsn53j9vSQJnoIYmKv6DKzX0YSw1rptbAzyuHCLIHRROKsF9bbRQnC+5bzNcoFqnvO//+Rz2OTaC2Ez0RBJNTRZeRBt/pwfx4lVoGImhEwwTbrCN69KCc2xA00cC7G3mv0q21vACUB4gkCwO47x6YhhzAaddlpdeNBNiiEMIj9IBQzfNkbWXxBLW0ghbVZOBNrjh1fl68CG+IyQxOAZMtvY6gVq9L42PH9uneEO+UuEIyTtIJb+GjEqfO0kUaF9KHlgCQI0hqTpty1xq7/DNnf7pjNOmAEULqCXDbl08xsRDxvXtWS/OXslIlMpVb6i2nj9psVYh9K0B/RgrfewXvTVd9N5h1Ruv3908ifVLpNc/xIREUa/XKcf8hV5JUhEi6uyqpq6C+k/GFOJVp0zkorqtwBNJNU/EtMs0b2jKSMqgTppunLBYxH13
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR06MB6849.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39850400004)(366004)(346002)(396003)(136003)(230922051799003)(451199024)(186009)(1800799009)(316002)(41300700001)(66556008)(66476007)(66946007)(6512007)(8936002)(8676002)(2906002)(4326008)(478600001)(26005)(6666004)(5660300002)(6486002)(6506007)(38100700002)(38350700002)(52116002)(83380400001)(36756003)(1076003)(2616005)(107886003)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oPcXKVoq5DxYZAGKg01eDNNCeH0+gPzqwRbXeLwoVkysVENBqVTtzm6N3mSj?=
 =?us-ascii?Q?RWJlJHo7tpDo125MxqurRas/crbVZF2ORzywlxd2qC+R5Nrl8cvgTxO5PuOK?=
 =?us-ascii?Q?TZNqRoS0UCR9O1YwmY5Xy673hjy0QuS4psP9H+4wXM3bp4c5rsrOU1FMiKdK?=
 =?us-ascii?Q?riKTPjYWaV2WZMAylS0/AWRXpb4LP6pUK8NeSJ0hJHO/U0EaVTvF7pAs7WWg?=
 =?us-ascii?Q?7sbQ6edhERNeZn+DCmO/CwZSlPMpI+pWtxQ6rEo7i/TocgTFJMJL9HUQgEIN?=
 =?us-ascii?Q?QUpiPctMhZZ1bApzfgcTWK/lAkhYq3gnjK5ZsPs0OtwkJhFhv4GPdDBf+40k?=
 =?us-ascii?Q?OoxeKvcqa0WgCnNnkOgFIP+qXjx94fGnWdr+6Uiqu/0gr9trkdkH/Qsa5OFe?=
 =?us-ascii?Q?gjkF3A1brlSOq8kGQF/D6klAA04DPywl7ux+4WqAiypLMZXoMgpbj9BzifYe?=
 =?us-ascii?Q?V8WUKeuo/JtcGSQ0qBM5r0xvaqyd+bn63eZaOsU6K0iAV31MMsxjZ3mOvjw1?=
 =?us-ascii?Q?gIguJbrcbao/x8XkCLJsA74GLxILIWvy+NEhQP9BrP7htWQNla2bSZ4TF0BR?=
 =?us-ascii?Q?BSPuiPk6m0aQ2+FEGsSEUfkg2PPHjTvpszW3B0euzM3z9qraAzgDNof8ymyg?=
 =?us-ascii?Q?eIenO+mUBnSG7PSuM4/p/7p44bmI/BkrpROmjdCESdnMkCJeDftaLHPu7Blo?=
 =?us-ascii?Q?0pzZbdd8qDptODHyurZRGcrGqbHgvOglkHU0u4dwTpxJOgopeNY1h/t9Yk+y?=
 =?us-ascii?Q?m92FpThUZuGdfweXF3VEfHn8ScXkPqvoMb7LNoXpaSbSbEdYMrpZ1MEBB/2e?=
 =?us-ascii?Q?rHTa3V8L88ns0I4Q6Bp/8+xTzNgzqF0AfzT5xB2gBIisgBZOUPCiF4wjExwd?=
 =?us-ascii?Q?F7RlQPr53FDpw2D3Ss4fV3B2wHoZhQTDdxIpChMiuNV4SHuYLRWU053ps0Os?=
 =?us-ascii?Q?kKIIRpuVbb6FFHERftk9JDF6/AxoM/bJ1PYPIk2i1E8QbZOSfGx4stMdctH/?=
 =?us-ascii?Q?5aRQhVJDn00fc1QyklNdLX7BzDGYZmbQg4meMMfo3bDKgj5flqvksajRYV6O?=
 =?us-ascii?Q?qHhRbxtJt4TGA4UHN029yM4e0cBPz0I3f6Pp3Zr/E391LRG3/h43eh/YD+7c?=
 =?us-ascii?Q?Q0+H9/FVzTN/PIL/MHJNbXn+riGgenoq7fi3BUWBs04Lu1BJyYx2a8nH30eP?=
 =?us-ascii?Q?jaBKlkTkkYKm9P3hO3tW+MJcrHi0ZnBOZfD7HHeqneUYffDrkseT6Oa41wfx?=
 =?us-ascii?Q?3kTvphYTh9RTWmsaQZ05/5Ft/X0h0qIuWaaKlQIqZnkg5ghHUB9dpq6uaHTO?=
 =?us-ascii?Q?q152ufAE7VnP8/AOhQdwx2lvGzu0sOiHrAKB4j+Q7rQMiPvSF7NGsUtJYqvn?=
 =?us-ascii?Q?GSJsnSVjBnUO9o3wl2OjcNp/AwujuaNZVzcTtBfrYnZbNb7lCfa6+nGl1mii?=
 =?us-ascii?Q?Sl1499Xh0yOE8zgItqurELXigIOU0fae8GlADRnxs/Du9l88vlJrNdiOK8hr?=
 =?us-ascii?Q?JPbdMJQOMuLueQjYt3O0TsCosyQA7Oer6EEiYlMFwqbvGLKNwjMDmPQqnqRi?=
 =?us-ascii?Q?WpEbitWTfP7BBurIhqadEZN7e5/LbxZl7oNYNwu+?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: baecdd99-8279-4f0c-2f73-08dbbd7bcc3f
X-MS-Exchange-CrossTenant-AuthSource: JH0PR06MB6849.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 03:59:21.1052
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E2pBzFzD15kHevop0Q+3CsXcw3CmWaOlkXtU0I1fvMveFKFNGtaCasej4R/lM/Xe3AJBC9ZiOdaOMPfuvSe28w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5179
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In kswapd recycling shrink, high watermark is fixed, meaning the 
nr_to_reclaim value is fixed, so there is no need to repeatedly
calculate the nr_to_reclaim value during each iteraton.

Signed-off-by: Zhiguo Jiang <justinjiang@vivo.com>
---
 mm/vmscan.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)
 mode change 100644 => 100755 mm/vmscan.c

diff --git a/mm/vmscan.c b/mm/vmscan.c
index a4e44f1c97c1..1aab3549969e
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -6638,7 +6638,9 @@ static bool kswapd_shrink_node(pg_data_t *pgdat,
 	int z;
 
 	/* Reclaim a number of pages proportional to the number of zones */
-	sc->nr_to_reclaim = 0;
+	if (sc->nr_to_reclaim > 0)
+		goto shrink;
+
 	for (z = 0; z <= sc->reclaim_idx; z++) {
 		zone = pgdat->node_zones + z;
 		if (!managed_zone(zone))
@@ -6647,6 +6649,7 @@ static bool kswapd_shrink_node(pg_data_t *pgdat,
 		sc->nr_to_reclaim += max(high_wmark_pages(zone), SWAP_CLUSTER_MAX);
 	}
 
+shrink:
 	/*
 	 * Historically care was taken to put equal pressure on all zones but
 	 * now pressure is applied based on node LRU order.
@@ -6725,6 +6728,7 @@ static int balance_pgdat(pg_data_t *pgdat, int order, int highest_zoneidx)
 		.gfp_mask = GFP_KERNEL,
 		.order = order,
 		.may_unmap = 1,
+		.nr_to_reclaim = 0,
 	};
 
 	set_task_reclaim_state(current, &sc.reclaim_state);
-- 
2.39.0

