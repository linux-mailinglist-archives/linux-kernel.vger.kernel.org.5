Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEE3C7A06EA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 16:08:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239745AbjINOIq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 10:08:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239497AbjINOIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 10:08:44 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2112.outbound.protection.outlook.com [40.107.215.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5108D1BF8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 07:08:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QKvzhMlRsXAFxevKhDIG2EPQtLghTWyMb7JggQJpTrTODQ7uo++FL3K+Qym7pQj+V8j38Php/2xVA/4O/UPOCaabZX188tV4EJ0MH3gHwR4mHc9GYfo9xjaEQ25GN0M46PPyk8nt2mI33enKwT8j++xreiLTLxRXisnWYg92iHZWWa3lV8oik96oH0eHIO5toxpKnY4xesso2Sgoe98j1COD7i9xhywXRSLeTOydJK9EqCQkQXg8h7Zeeyj9sq4KXgxrCDskCO1hKKL2IYQl3zrR+Eeq/Xbp0+C/kNRw3dfvYRnDe8b1nGpYKIatq8RoRv7w7Qjylp4GrKqoNwJrBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=25gSk+iw+1BRBgn4qPNLDn+HEnsKsvO2/y0kYfraXAs=;
 b=FTZHNUuYfK493L3XbRgSznrUbcCrVXju5UFhUasqUCfowQOUulsQLXu+JpPGIGXrQ8RLsfevobxhGCebU2dPo7v6dzpsH95oYAfoA03IcUiG0Cr395A2DWis3f99CQhgyKpGcfQXoPYdjkI0kqIOH/zrg9rfqXH16QQ8GmSz19qcLy3LJ3jzTk5Sl3MC0UFPiFYEs6I/HeOJneCHg/+JoRXjDhzlNziRieE6eJAXvYqaLZa5vLfB9tVjlf9UIwMVklw7U8OFVI5nm4QP7xDpWAryM6L0fka6d8AT4rwjHgIzK4U3hwYHOEthGjAaMx7OsZLWMzDee/PtBqsuEeP1yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=25gSk+iw+1BRBgn4qPNLDn+HEnsKsvO2/y0kYfraXAs=;
 b=TCxMiazLSwCcWJymBqs4a+bGCzJiHWMBG8RG8BpUdfV5itBOVvd6udWbbm9RQNQfPgElzErfdQ73uKqkH/pnSg0Q5SbB5k0+7WHbQGbE63H11l86lMROtoNLJxno7KzZA/7yhaHO4pu31liWl2Rf5PmO28P7N7oXtvTK5SlMqxOfmveb6h9rSmu4okeL/d8ZK3dNIaA4JkG9winYIehWjbslg1+VOQFHNSVGjn6yb1r8S6hItmDH1HQpZo7eVGqQAyaLNolbp/OSMkwT+1lo7PC5CBAE+UPScBWLFshz6rXHQw3lHLM/XpQg6JZPjggca4Xn0a5aV6VuTuwdqBwMxA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
 by SEYPR06MB6756.apcprd06.prod.outlook.com (2603:1096:101:165::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20; Thu, 14 Sep
 2023 14:08:33 +0000
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::832:19a2:2f83:1cfc]) by JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::832:19a2:2f83:1cfc%4]) with mapi id 15.20.6768.029; Thu, 14 Sep 2023
 14:08:33 +0000
From:   Zhiguo Jiang <justinjiang@vivo.com>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com, Zhiguo Jiang <justinjiang@vivo.com>
Subject: [PATCH] mm: mglru: fix add unevictable folio to lruvec->lists
Date:   Thu, 14 Sep 2023 22:08:23 +0800
Message-ID: <20230914140823.1732-1-justinjiang@vivo.com>
X-Mailer: git-send-email 2.41.0.windows.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0192.apcprd04.prod.outlook.com
 (2603:1096:4:14::30) To JH0PR06MB6849.apcprd06.prod.outlook.com
 (2603:1096:990:47::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR06MB6849:EE_|SEYPR06MB6756:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b61d915-9312-46bc-ce4e-08dbb52c14b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8lzgS1LOC1h6CMRorgt3n+PRsesPE1ErOq4DnDDErbNYzCIXp/hZJswJxyTe7Xp4hm2XJ/Ss74xn36zuqNb0RmnxnmLdoB/zgSRwHC0YefyblErzlJt+dv65aO50nFkKDpLCGTKBmNt9YYrynWajdzel1RBJsTf2w8wQFoQFlqDP6cnH1qHcgEOtSDwP2omzYigv+gp3IAqOZIE5A2gOUYZOZWsn4WzvW0Ec0kr8ePRSlUPmS0FX1hJzYeXOeevDWCIkZ05iglvDrM8WOh92G8x1qiXGjfPax2hNVnWN8Ta5Vbxn8pMz8XUV7fnBGY4aEyWvSLnJuRJ13RQnlCJ7UD8nfYCEe3ZIBFkXZTXfiuv4BQp2bM9ZhFEXj9UFgxEH4eg0mFe3Xn7xnide9okdQ8ZeGTAvUQnlDfa8577RvqH68x39HXOI74L2yHIgdXO6Zr4e/OvoVj+fSQInA8SW5YDXrW/I/890w48Hto+WlfSavhrw8VTA9588kF0HCiIeP1sEhQIhE0ZR1ksyQfdXBcILQeviEkDChee3EzjF+PQS1QnmFkuvXkVATMbvnxz3yOszOtg2vmwGnN8vtJnUsQZVGxNYPr7jJWqY+t0gKfuXpLkKhVzx67qwCp5YvEF5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR06MB6849.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(366004)(346002)(39860400002)(396003)(451199024)(186009)(1800799009)(6506007)(6666004)(52116002)(6486002)(83380400001)(38350700002)(36756003)(86362001)(38100700002)(107886003)(4744005)(6512007)(478600001)(4326008)(316002)(2906002)(1076003)(8676002)(8936002)(5660300002)(41300700001)(66476007)(2616005)(66556008)(66946007)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?L4q5a0S94vZDOxVAf7qbyxHT1KySif3zxr0RXtvaUxsSxqK5F00vY6bdPToG?=
 =?us-ascii?Q?ixQIDG+DZW5hRmX0QgXt8OWEoMNxYEJ0+yLLuh2nHirVL6UBt0x3ongDBr5o?=
 =?us-ascii?Q?+8HNI2PwkRCJVJFnsxK1LYZjkwWQrrOemcl9sYidbMV7bgWYCZcPQKvYJ6uN?=
 =?us-ascii?Q?Um3R5/tg8GrNHaCEArb+zE2sEEqG1I5CiOW6J+cPxWn5pCptF6h+gbf+V40f?=
 =?us-ascii?Q?sS/kqqwJMUGFfybBH+a/d5XeP86bKMWdQRT2z3GW9Vp8mfXmfCWRhkY/tpoA?=
 =?us-ascii?Q?/XPf56+yAWjcY59h1j8Q8Os5AO8dkuDKTbT1o3ZSeEEHJMlBMsRTHLebYSyH?=
 =?us-ascii?Q?ucYsC2JxHFETv5yHQGMZZZcaKPaRVkD1zFwbfJ98oi6NCjtbpMfALn4NFYWg?=
 =?us-ascii?Q?th/u9HVfDIV2w5iMDufM8KAOWKgoQnby5Xp8LelriNAsKB+py1E6Al6DsmKv?=
 =?us-ascii?Q?DqUNIhloiaRO+rs2E+5UeFzTeh/tkF5KWEHIWIRps2meCbFPo8FGvBAKSsYZ?=
 =?us-ascii?Q?+gH16T6tQJrf05s2fTaiA0UjmfHM1ws3PBbN5gT+3rknh+/PJSR9oPm7X+v2?=
 =?us-ascii?Q?RWblIxj2EDd0tA1u4bhG8GFVeSwnHW7YDe64SNAGntK2TNb3DqO0sXQOXnS0?=
 =?us-ascii?Q?3pEwQuvR8PrMq6jSe7jo8XqjbFiToVKb5InWSsPs1x8vb1JZqMEaUbqWZkci?=
 =?us-ascii?Q?4sMk7gynep1V00uTGjFtOg5CZH/4dJ913F6x6xWptFSI3u1JsHGwu2s0Ghl2?=
 =?us-ascii?Q?xpzKDNbNbf2MhGVL9GT8y+ROSUKeT62v85hH1DHPBftYAUGpDCh/pw1Du3E6?=
 =?us-ascii?Q?Zgpra3upchKUORquKvK1hxrU6FQ+b7QTNXExa+eUcBLI7oZ6zY+WHvUM6Nuo?=
 =?us-ascii?Q?Qw7sl54uEU4pgo5MrcGcFytjtTLbrM6Gxmzp0p871JE5Vozp+tNtUaZ/0JOJ?=
 =?us-ascii?Q?QNnaUoK4u5QTvwJVzJbG/5BIUzboqShCVRK+J/JvcbgrBRkOhVgI/xURf3iK?=
 =?us-ascii?Q?jzRZinQTWnQZSTYeVnhrfT1EzfgKcWJbpu2GggW2cHwo+XwVnMLyEAQOiVsb?=
 =?us-ascii?Q?Rp8wWHOcpDAzF6M5YtlWG9BrVT7cnumIp9S2ByJaT59sap7XkoOWfiOqht5O?=
 =?us-ascii?Q?VIToTRjJnPkasB75SI2WBjChzersvkDCsW3wH8mDFIU6hvPAYKQuZ4ZxjKZc?=
 =?us-ascii?Q?9PUUENhtQJ9Z0RA2nlyV3JuTO9O3h/ifJUXCvQZ5CRsydg6Z4h1/9V3CsCmB?=
 =?us-ascii?Q?Q22SUZIL9h0zbxycAv/ggyJmAsrxUYZeSMheZlr/FjsPfWzUjoMWK9ueYZN/?=
 =?us-ascii?Q?3RwJekuypsMmF63rH91iMnnA/XgiRkqaN/KljuGzQdCyXeVI5Q0S2A9QhkY2?=
 =?us-ascii?Q?EC36YZI1wfxJnwbp8k8xUo83JtCBZ8Gy+kuT2gKRxrZSX4lNc1VFo1ZSdhBj?=
 =?us-ascii?Q?Ka0FOJvpzrqxcCXUtC2ee5tcPNu2XLR3oBZ0tdwFgYJQBf8SEcnwhIou8j+d?=
 =?us-ascii?Q?uRbSNswcHlehHVwuKM9s/24AVwf4TMBtWBYCT55CjBRgWGuO/olm5uvyC3+9?=
 =?us-ascii?Q?Dn7beMU1XS6bhtUC/r17/dUflKz/v/9H3C2G/yJp?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b61d915-9312-46bc-ce4e-08dbb52c14b7
X-MS-Exchange-CrossTenant-AuthSource: JH0PR06MB6849.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 14:08:33.6571
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q3YDhQb/3F3srSh5Yh2s4y1C3fzpAZJRJY7VYxvCA9wr+tdqm/EcakMeV3v907SZrIqyKaOay8glmvVmpI8KeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6756
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The unevictable folio is not supported to add to lruvec->lists
in lruvec_add_folio().

So use lruvec_add_folio_tail() instead of lruvec_add_folio()
to add unevictable folio to lruvec->lists in sort_folio().

Signed-off-by: Zhiguo Jiang <justinjiang@vivo.com>
---
 mm/vmscan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
 mode change 100644 => 100755 mm/vmscan.c

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 661615fa709b..a15e45632034
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4237,7 +4237,7 @@ static bool sort_folio(struct lruvec *lruvec, struct folio *folio, struct scan_c
 		success = lru_gen_del_folio(lruvec, folio, true);
 		VM_WARN_ON_ONCE_FOLIO(!success, folio);
 		folio_set_unevictable(folio);
-		lruvec_add_folio(lruvec, folio);
+		lruvec_add_folio_tail(lruvec, folio);
 		__count_vm_events(UNEVICTABLE_PGCULLED, delta);
 		return true;
 	}
-- 
2.39.0

