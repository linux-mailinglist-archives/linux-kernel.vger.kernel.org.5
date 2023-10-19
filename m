Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7FA47CFB77
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 15:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346095AbjJSNmq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 09:42:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346091AbjJSNmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 09:42:39 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2098.outbound.protection.outlook.com [40.107.255.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73B2511F
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 06:42:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iHr84kSY07B+RSsphp5Ux0rn81eNb0ZCbK9Sn8gj915f+JwS0HzaIbCK2ULFFJzIfioZC49FKTXfObH74y1y9xWV5zRvtyjBJ2sMI5RqpU26CFHzEcCM7mO+jVqOISb6R+mWaG8YUWIsmTvilqVMpvxyFPFgEfZEFZx//monmzyijYA1/BlJu2ReSGaDS4O9m/CkCzZBa4yO5+OXfaFWDwEmsqsCywfS77itiJ4rX0l2vZgzXLOpCX0zRY+FXTBI2L0gKq8vhCo0sFtT2zCw+mINZO2ylETeG+E3vUrcdDCxGgDDoj+5nGo7NEomeNW5VuB8NlM4m0EDs8y1xmQWKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G+W6fmJ72ArZzY33LmCyBv0xsV450yR0iejgRMpA4iw=;
 b=mC64egYSKqv+/EvIFy7tGJsAD52Mu9lL2i/mZITg20Ey5lqnSLLiaf1Y78/U1gl6Mjm5JJBl0m4tSASDqwQFR/X4a04QfS627zo5Hms+bHAsnrQ+s2pUDB5zQ9Dwx8qZB3B8/P1MA5ZwHjvCXN7n/kJgHy9Yais0PUz8UWSIOnM4VbiFEb3OADtwUKwfqgxCd2cT9xwWz7N683wpD/Yv4KFQwSNpTXWatdf9Q80S0MN1Rlo0CkgACIjhbgHrkN5upvHbWq+gMB/o9RDEjpZ1JVgUVYq74sRNUVt+92tZphzoli+6JG3EbQjmjiCVViUFrPIvIGhg7Ioe1NWPuclr4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G+W6fmJ72ArZzY33LmCyBv0xsV450yR0iejgRMpA4iw=;
 b=qD+xncfiUk/9CmKZ/LpYvkfmwljnn/MWxnGJn0bxoOqd8ZjRt2Rd8LTsSX9FwijGHjEp07GA4QRQKelhbyWwNLy72x728Y9aSvmhUUXll+KhhcPF+kb2yDCw0gIWqxL60Og7ArFLcL66I0MxAhH545EYXQeYNiLS5WC0j/Ls0C+zw0yf1dWoiUnMo5sIeYcq0IaJrUoYjqwPtD72fFa6VE0an1XhjacYwL5xfT14x6bJ5mI8uc38O7+a+ziTWhOAElcCf4hRa6hc0uile0GTbxcyQiaYFQvslThy5hwkBJZ1UH2zkAhNZN1ENas41GRTrL3xN4nPhbjjbILz2ygBQA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
 by KL1PR0601MB4100.apcprd06.prod.outlook.com (2603:1096:820:24::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.24; Thu, 19 Oct
 2023 13:42:26 +0000
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::32d4:1209:6b36:86e5]) by JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::32d4:1209:6b36:86e5%7]) with mapi id 15.20.6907.025; Thu, 19 Oct 2023
 13:42:26 +0000
From:   Zhiguo Jiang <justinjiang@vivo.com>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com, Zhiguo Jiang <justinjiang@vivo.com>
Subject: [PATCH v2 2/2] mm:vmscan: the ref clean dirty folio skip unmap
Date:   Thu, 19 Oct 2023 21:42:11 +0800
Message-ID: <20231019134211.329-3-justinjiang@vivo.com>
X-Mailer: git-send-email 2.41.0.windows.3
In-Reply-To: <20231019134211.329-1-justinjiang@vivo.com>
References: <20231019134211.329-1-justinjiang@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0141.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::21) To JH0PR06MB6849.apcprd06.prod.outlook.com
 (2603:1096:990:47::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR06MB6849:EE_|KL1PR0601MB4100:EE_
X-MS-Office365-Filtering-Correlation-Id: 863f265c-b576-482c-42c0-08dbd0a93ae4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o85Ct6fU1hRIJlr4fvQgZ4xljBU6ZeMbcJOWw3UWvRHQxZU2BTYcwF+TFSDM7w6WfGAdUeWCnnC7Q4iLxBxqC1CX+WJTgfvVLqcs6ylH1XiJyqnRPXKMoE1ue+TpfUI1+X7GHJ3VH/qANNnWxzO82U5hR9E3HPs1eikVQDRHO87uOFuxmwlN6zsaVQ04gWLVcG+yWF0WlgICZXVa21glkFZc4PxSAI54e6UXOGc4uGUQp69YjWZCGF5E1Vhw2JPp7heWrZhp0UkN6ymygcCV/nzo8dELABQ5yCTPGSMlM6QSUFeV6TtIyP2iBOmhMmd4bPRaSMNGLdqzsjR41XsWjyDGSM5p2TLvaJandXp4ShbH2arohIc4r0O+D0fJCLzfBXIXbZsB4cIvGXWJ7ENpcNZ8iiQ8F5azMxi8PDu2wwd9jB8Yd346SEZUANsSw6mv3jqCb0o7+bwTU7Nd+h7oI8LsuafrcM4xa1K9NE3WhbJDFsVeQDReYG17qAQxnm0JuiFD/v0cT4hSwoMCPT/eUkGvbTnSvJqLpsUqzu8pnZNCwHfLXWQZsCrNXQpiMqvVMRC8LgC9g2jsgII+1NeY39UU3Zw3YIM3vih9Ut8CnZFuABmrKR3unC6/+gXTx4bEOSxEz+DzYUE1wBy88+0ilw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR06MB6849.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(376002)(136003)(366004)(39860400002)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(8676002)(52116002)(6666004)(2616005)(1076003)(6506007)(107886003)(26005)(66476007)(478600001)(316002)(66946007)(8936002)(4326008)(66556008)(6486002)(83380400001)(38100700002)(6512007)(2906002)(86362001)(41300700001)(5660300002)(4744005)(38350700005)(36756003)(14143004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vxuWMr/qkh4P3rDyBNzchSrKLXEPXnT26oCMHv1XUzAtgWlqAYT+DitUl/0/?=
 =?us-ascii?Q?rV8puTI8+NtJZkEuPOdB6yD/OmamNZaX7ChGg8GdfN8hxCr7Jk7hCmS/p6YL?=
 =?us-ascii?Q?vISP5QfJ3nS+PxOHVPwBVAa8GrZKnGYiw0UQqUyrBQK0WJkA0wMppQuDqZNc?=
 =?us-ascii?Q?tHXJFpHikkU/CSwsbAwzfX5uPezpkePy+Lgdtq50yBEaX/4vtFbefPMNNJyS?=
 =?us-ascii?Q?ZOwp1riWXXhLX5X3Djad0y46qts7+HC7KXx6jNQEgIgl0GFFBlATCuARWtQQ?=
 =?us-ascii?Q?PRBgQoSKDMBiybQ5Wr6d73kMZ5qVcukRzb6/JitMD3hWi4nS0LF0DI+98dB0?=
 =?us-ascii?Q?r5nLMOHVJY4IA/eVwJkoiYIR+I33yVNK8edv7vl4pR33Os3sA4d3xS+azX9b?=
 =?us-ascii?Q?kURkRlypurIQAExmkJc6lL1QTRP7Q6tlJpeTFEfguXqqOd9DbuZZhjiZmqHc?=
 =?us-ascii?Q?ZdEt4b1VdjSqTIAE5xaWnRQis7R37rMA/tpr+8sKcbSLIWR1OTmof+LFhGxb?=
 =?us-ascii?Q?R4Nt3jV4qP8Be7iSLGGgGWHgGNXm7KTZ9FIlB4vaVkNPz488wug2sOIfBNco?=
 =?us-ascii?Q?gI82TRQqEBXj+V+TNFdauhBkYu4DvEUKxWXtrK0lBJ5Cxvuqg5XlQtSlvY/G?=
 =?us-ascii?Q?GCGoB/cQJfC25ucp058fW7VZfbAa1T0HlYIQlv1rwd/jOr5Iqt06BQwq2DH7?=
 =?us-ascii?Q?0mltVNZm9SoBuGEY1vZDej6q2XVfOcHFKuvfL3rN0VQ2KABfaY3Diqr9ahLX?=
 =?us-ascii?Q?dIa49Bpx4/U43EHpbxDTEuwqeKWweLr4NgN2qMsurCWmkuSE+x7wziB5dSm8?=
 =?us-ascii?Q?naA68Mbc5QqcotYHBKbrdQQze6pbWhPX+AFFKceZXmKWsWTFZzvJBw0P0JMo?=
 =?us-ascii?Q?KnKjXsnxP68b2056Vy5Fs8SdYOqcDryPip85xTzEIdmwaQB00YppXXhrXNvu?=
 =?us-ascii?Q?f5cH8NWoevTI+pH3XUqnK0V9ihTlpwTZAiiIb1ErBhOMdp3jVP2ixULrJ9n/?=
 =?us-ascii?Q?2jcllBdqgXhJBNaGfk1zJPfAIN6jUTWghtsvP39+xFRMCSgGfNasVGENiRf5?=
 =?us-ascii?Q?lJ8olSrFG5s23OxgTv1Z3VHZCSOj1Dl+aeMK+I4ySg29HClt4kaSxyv0GU0E?=
 =?us-ascii?Q?XwqgFsO/pw/2XcHGT/KWXiB4uxM3kEV+f0Xzqo+gmwvPWpsn+RVcYCaFOgAd?=
 =?us-ascii?Q?FuJKDQ29LpT43gkFwkIj4shkzd+hXbdDrJ21OF5M8poI5t6DF7NgKTpRt+iG?=
 =?us-ascii?Q?4lky1lPOSMrCicnrFQXqSS8QNQPo/5Bi24yUPG9UuM/KQjtS+K7vwNSEOh8c?=
 =?us-ascii?Q?GS2dVQD5MCOA8Fv5S+jB80dn6CSVKUj6Z1oGo6rbWpdSEY2tlXVKFmD2jLxj?=
 =?us-ascii?Q?IvdWjzs0FPLM1veZ/kW9YMnkbXXknq4rq/H4NR3hfvKKKWPGqAHc84Gmf9XO?=
 =?us-ascii?Q?IF2+n5mfCUWDenMhq6LKwAXtSNM/cJhJqxgumohDG5Uev1gxlsBzRwiJx3Ui?=
 =?us-ascii?Q?7yIQM3DU4ONDWAYbfgKECT5FEXxwssJstM/BlFViBC5hP3JfiTseXnVPsOB+?=
 =?us-ascii?Q?PtHMYtgQ1dIJlCvCy5+PLCKtlIIsaAGEsEzCzhE7?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 863f265c-b576-482c-42c0-08dbd0a93ae4
X-MS-Exchange-CrossTenant-AuthSource: JH0PR06MB6849.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 13:42:26.0515
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I2oQnwRFw01JwdmNEf2Q5NOLVoVehcOzW/SYCZoYsqrfydReH3QCkOJmsTdbUL2iFgPlnxFGGu+4m7alQdft+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB4100
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the dirty folio in folio_list which is inactive file lru is
FOLIOREF_RECLAIM_CLEAN, the dirty folio can skip unmap in advance
to reduce recyling time.

Signed-off-by: Zhiguo Jiang <justinjiang@vivo.com>
---

Changelog:
v1->v2:
1. The dirty folio in folio_list wich FOLIOREF_RECLAIM_CLEAN skip
   unmap in advance.

 mm/vmscan.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index e067269275a5..e587dafeef94 100755
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1225,7 +1225,10 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 			stat->nr_ref_keep += nr_pages;
 			goto keep_locked;
 		case FOLIOREF_RECLAIM:
+			break;
 		case FOLIOREF_RECLAIM_CLEAN:
+			if (dirty)
+				goto activate_locked;
 			; /* try to reclaim the folio below */
 		}
 
-- 
2.39.0

