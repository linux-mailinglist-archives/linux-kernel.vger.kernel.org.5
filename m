Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C017B80A22E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 12:29:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233365AbjLHL3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 06:29:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbjLHL3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 06:29:43 -0500
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2120.outbound.protection.outlook.com [40.107.117.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BDCB10D8
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 03:29:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DtbzbkIT1/droRljVCxM1O76/NTRXt2305pKtMOEZsVWx2BluNw0b7e4mXinHiPQbiGOuIISkIucBLObF41NaL1o2KabU5bwrLvAuPyOkFfih/M22fcyRy9FwkUt4BGHqbUG8j7JM6geW5NSuIaKZp9fLc8gwYGxBpxbYM3NtDFtHf/IX5c1Z4Kewf7+vqFsJ1NuRipwj2UmxEjtTJSQTkU39kI6tNH2UyZtscJMuYMKT8Xt0WssFZI89fiW8yEXY9D7y9mFSLHgFbJ90MYHP+Qe9Ognyp6VLmEvxS4KkDSmTthrq/0eHy0pPpqexnAKuBdFjTV7f5ENgFplQOENfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3tfh/duRSEal8+BthvyainR0gBFaLRLugZo+0ba2KD4=;
 b=ZTkYoW8CQ84sJmVAqrqsJNPaFrrESSBsElseDEIgMWiE9BxDEg20i8AV0jKPdFPqUiEZwtP45SEwpvJmr/g+o2bi6G/rSwLZa/6uunSqUv3d6aW4nksuuTGuxMNTg2lJWA6RoIkQYWye4dxH6xBYmx8sGC50ISmKkaSUj58D5elfZ8JlxjX2l8HzgZXL+3ktqFwgWy3WxO4YdkYlxw/z/VtEjgUXU90hdVMD9BDMTFkT7ZfbQZflbRGKYnc/vAO0mPLAlFGWCqDgRSmbVPzhZmJI+RA2XW+qtsIRzZKyootFY4temMwxSCQt9qtYoM1+V4JYufiIXH9X0NZel2aDDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3tfh/duRSEal8+BthvyainR0gBFaLRLugZo+0ba2KD4=;
 b=LGk47gbsMnRh4LmdcSTGT7Y/QvAI6gfWOYcjF6D+pB5Z9KV8h+EqRXoPQgsOleZF0NibOQxUQ1WYG2ygJYHjiul02qxfSGBC8oGWuv24/plljL7n/4l6/gTHt5sfl2z4oKaTDENbiVRlh87m5TdsY0tHkAsAsyMWVrNQWrmfatbK4vKElQ3LsfZWTU9ld+VyMNWp90fCCzg9HvJydiZrgYQPIakfCEEDyIzhPtabADn7rxNUb4oL475s0OHAKTEJyUz75uf7IBDvccHEolveoYSssHv3ccpsSuNQVpE/oR0ag3891rRlaqed2SdMCRbLxWoftTjTny70I4r8U/QgXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
 by PSAPR06MB4376.apcprd06.prod.outlook.com (2603:1096:301:79::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.28; Fri, 8 Dec
 2023 11:29:43 +0000
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::1be0:ebf0:eb04:6bd3]) by JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::1be0:ebf0:eb04:6bd3%4]) with mapi id 15.20.7068.027; Fri, 8 Dec 2023
 11:29:42 +0000
From:   Zhiguo Jiang <justinjiang@vivo.com>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com, Zhiguo Jiang <justinjiang@vivo.com>
Subject: [PATCH] mm: fix shrink nr.unqueued_dirty counter issue
Date:   Fri,  8 Dec 2023 19:29:32 +0800
Message-ID: <20231208112933.1385-1-justinjiang@vivo.com>
X-Mailer: git-send-email 2.41.0.windows.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0055.apcprd02.prod.outlook.com
 (2603:1096:4:54::19) To JH0PR06MB6849.apcprd06.prod.outlook.com
 (2603:1096:990:47::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR06MB6849:EE_|PSAPR06MB4376:EE_
X-MS-Office365-Filtering-Correlation-Id: b75bb137-b9cc-4863-2117-08dbf7e0f8b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2zX7unz66cSZOFE9xkQhT81AHjmFuDjZlwq8YWK2trXGKTzQ7QUt95gz1aW3EJShM6gSOv57pqpVGaWBbbQ67f+afH74rU6wgmxmJSxp4IBRhSXhKUc3mifgP9h4zKEyxvzHS2zTMdniwshB7/j+b28kJQXKcRv5PODzHrV3OaWtVZQhqu7mkda+HORyvJZ5tm2cqGM5oK5dkyiskt/sHu+Xovzg2SlUa8izYpovCw6p8R+57p+/sURExvyjaEhUKP4mYRyCGknhIefozIivpkC58CKx+FFU3dzz+A5d5AFbsVDXgbEE/7S3R50KfANZoS+iih3QHD3XzmS/O5ZNDAYZIcNiBQc6CQoBafOsHkQ4WxXGSqsVigLvSE0M01PAQ+WrSZgrNCPdWW7QE4xzcwqFj9uj9M9WidaywuMVBZE3GluD2FFgqRh6D4f9fjow5NkNYu4AIy5xtfZc9T1z+f33LUNF6d2LdOV/a/L8yrEYhEi2JRzlv6tK+MsbMz76cQ+jOSMmaldv+XlIqm4B7V4fcUoRJvZRyqnoa0pP+B8eW3TWHsKrCymKC5xgN+iapHU+zuUUpFQDf1yZNu6ZR2sBZ+vbHX4dsM13WqpZU37YRNwpqi6usHveWYvdoJPXRDvO95r/b0qeGKVXr3AsLw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR06MB6849.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(376002)(346002)(39850400004)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(86362001)(38100700002)(41300700001)(83380400001)(38350700005)(107886003)(8936002)(8676002)(4326008)(478600001)(6666004)(66946007)(66556008)(6486002)(66476007)(316002)(1076003)(26005)(2616005)(5660300002)(52116002)(36756003)(2906002)(4744005)(6512007)(6506007)(14143004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AiDQ1Cu1wr4ACKuChvrccFwZWXHmiYsTX04YwfbOMxejrSeA8jZPeKx4UpUg?=
 =?us-ascii?Q?d/wVgRPpAf+FHBgvLIiTZLx3PGF8P/2UcsSOHfVb+oGIgmTHe8ST6Q+GxaDM?=
 =?us-ascii?Q?wSwRpzyML3aKGh8RE9VKqtdRKyHT7C4mxteN99r0YeYIp+QXqzMRCMVlPKOL?=
 =?us-ascii?Q?aI6UH3urDxO5XUEhS+qdp5yp6EOnEnYa7hatF95d6z0Df+SSwla4BEynIVOV?=
 =?us-ascii?Q?qlnDwUx3rlMaXQjFNEXD4YWBdILnBK/PPxC3UAzVKP1PVSmL1bUFYKdzjvqV?=
 =?us-ascii?Q?q0SniC4qIowcBN0zZ2PD54S0//PtFKIEd2wec5RSw2Wy2aT/bP5L/rtRSwmT?=
 =?us-ascii?Q?B8kQ9zzP7blt8/5tGz+D4yIQehVoOc8hgSez3pQfMOYMG7KYBaB9AfsL6ZiE?=
 =?us-ascii?Q?AckHx49syqXfJjjSs+jHE4xM3l7f+gHqlyLvsMGAzcv4dESXxuXp/kQPT5BF?=
 =?us-ascii?Q?RQaqHd46hjbEnvBHMMnQO9NPQt4cyteskCTseJFUKavD1mfH8GgOj0YUDGMd?=
 =?us-ascii?Q?H64ZqOD2hC4uaetZlx9lLFJ3TDgTxNij+ftT2MVUNZqDsPg3G6LiNcWa2TYp?=
 =?us-ascii?Q?lH++JUsEJxLj5udtT3bIuFCGgwV3xWPMStZy2x3u1mZOBNUoKvr+A84gILLy?=
 =?us-ascii?Q?fkw5fVMhDWqDxScwwkHxCDfqgegLIdlGMh1Z8E7Rh6ZlI+32amK6f/Qb2tFj?=
 =?us-ascii?Q?HEpoPyIw8L2ZmGSGxfOPUzB94/vqybW/lmxscZX/Ec2l9Mqa+wJRyOXo1HGK?=
 =?us-ascii?Q?bdo16Ent3RefbKZhOYd/F5NsInAT+JPU4L56IvXiIJ9SU+RFhp+frPaV5MYe?=
 =?us-ascii?Q?A+gg3q+eQeaeVO117xU7/WmYGGUylfL8CZe3PemeUqp1V1jTQ57WIb/VHv1y?=
 =?us-ascii?Q?Qvce59Y91i9/bs4SjxzxqjF0LhxJuZQY4CvUGJsXzKQves6tiL92SV+xl95j?=
 =?us-ascii?Q?/fRCgRApNIdNUW5vI8OQeyoJxItgL2euOrJBUMlppJXvYtiOssZN40CzH3wL?=
 =?us-ascii?Q?X6cosUdbkxKt0EzEGo0Woh1mrWawFU1PeQDsPXLaSxeZtUiGeJ44YuCnv873?=
 =?us-ascii?Q?m6JEfayii1dCEujg7ROzF+lBsnA7QlmVoAGMN27ngCfOLBWfFKjKzUh/WZwt?=
 =?us-ascii?Q?Wy8k05TI9F0sZ8GdV53ygRKDZFHZQm/UPa4SbUL7ep3HqPrcmAqvJoHXIzVO?=
 =?us-ascii?Q?J9lx7Lg2oK0OBWkVCedQP83mF+CgVHtdE0poou7QtODIoZSWeUBAfO2tPtFw?=
 =?us-ascii?Q?wAkZ6jMeLhmky37ltfF8Rtg62hj1IToSlNuefE/thAF+NrMo80AQTjE/Lh6D?=
 =?us-ascii?Q?4jYpLIIPPu4EFN1GLpGhR3++GPz+lOs/QqevlspntPrNq8h9jhBKBnejli+0?=
 =?us-ascii?Q?uAoHHcoA1Z8krIU/2XCbz7AUzuT3V1I5Zoed0AbCUaP4WzPnwgMXIj+kz4e2?=
 =?us-ascii?Q?E9IGPYhCBiXwlAGOapc8doMD+gyJ+IVNoqmJjFL3/r3I9EKC4hHCCYljzbbr?=
 =?us-ascii?Q?yH7PkNW4P60Q3OEwBgIz43RU5Y9oINqRxsli0zR5tnyk9m2mA8vYtucxZuOI?=
 =?us-ascii?Q?AHKrrigXQHRMVIj4gbDlqHJhJmuCjjFPzmqoyDF9?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b75bb137-b9cc-4863-2117-08dbf7e0f8b3
X-MS-Exchange-CrossTenant-AuthSource: JH0PR06MB6849.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2023 11:29:42.7592
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rJjJBapu7ytP5H8h90+zviV7F9ekNbYIOhmcwXwavw07t+5+k7kbWBb4DBVxWfg8j5zXPjOKE6NYQYv9klDVmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR06MB4376
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is needed to ensure sc->nr.unqueued_dirty > 0, which can avoid to
set PGDAT_DIRTY flag when sc->nr.unqueued_dirty and sc->nr.file_taken
are both zero at the same time.

Signed-off-by: Zhiguo Jiang <justinjiang@vivo.com>
---
 mm/vmscan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
 mode change 100644 => 100755 mm/vmscan.c

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 4e3b835c6b4a..12680c392bb0
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -5908,7 +5908,7 @@ static void shrink_node(pg_data_t *pgdat, struct scan_control *sc)
 			set_bit(PGDAT_WRITEBACK, &pgdat->flags);
 
 		/* Allow kswapd to start writing pages during reclaim.*/
-		if (sc->nr.unqueued_dirty == sc->nr.file_taken)
+		if (sc->nr.unqueued_dirty && sc->nr.unqueued_dirty == sc->nr.file_taken)
 			set_bit(PGDAT_DIRTY, &pgdat->flags);
 
 		/*
-- 
2.39.0

