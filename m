Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6D0F7F27D5
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 09:47:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbjKUIrC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 03:47:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbjKUIq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 03:46:56 -0500
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2118.outbound.protection.outlook.com [40.107.215.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5799210F
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 00:46:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mPQU4m/AS87lg6iWtsGwCzR46n90I/w8PlBOnzfIYDUupEFhorrhtpLYpFoXq7wuS6AiQcRYoxnli7+5fuirs++GC7wzaIEtDWGMNdIg7lWqTHtAG0MPAh9zXMr539BE9gk5KUSVOrPAqCz8EMHON+V5CCXQVDcdt7r5AXE+4oJkmacxSJyUQqT9zoaOlMDbDMGR+aTF5XsxAiyOLbakGNigw63CTMUEU9R5joAbzmW7T206V+1/uATql+F/TvL2lcpNCWkgSmvCBkU2k3KBR+dr69tQMbFbGujNjM5W3RaELSLUfz6QI2IIpr4JnAYJnZ3ywpQNznXOUBr/WqkTCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zOZj09/M3VElLeovXt9H4i98jVpN1nF8xPItEn3ROYM=;
 b=WpyIlTPpph/jHHfuF920Gk/WpABY9F+IdvjPOgCrlZtEjX5u+lx+EtEJswJC2cwxo54gVHd1UEZ3tUstYYyOXfYlkfgNxWKclA5kmy7QOCfyjLMIVdLehZHL2k1pPt+D8R3mVJ0PleGF2sQlW8o74DLsuYgO13irrzhvZgr0jieANdAwGK9+K8q7UiHnS/4I/yefSSte4WEFc5m4MpzPlWW4JVnYG3WYuwxSPwsqkhQV4VcEit4kX0YiF9pYsjuKiPH7Cy28e9UKUeXKZsUeu9MEOo9m/+NncnwTjZ/uI5vb6hrMCTZ0IYMyCumMKHIrpNdMerjW2JRVHSJtHtM2hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zOZj09/M3VElLeovXt9H4i98jVpN1nF8xPItEn3ROYM=;
 b=K08EHM4EAlZgF30fhPjlwekJlR1DGpM3H1kZEbDG1SUp8usIBvS2iRlDAlg1Sh3cP9fQEETI6JfA0Obyo6wO3a30apMIPwgCZJiv/fjLgchqaiXOCs/iCFF7WOXdvgUq0FtYHhP6vhj66Urtu01vJZgqbKnVKcrHWNePJVHjccvn12KrksmqKHdOSKf1bHx6VKQiUWuJ6AlieYwHIGBx3883JmTL2DqXqg4kDfIqFW408VKj32oyz+6ufLpcLxlbpMkvQwP8mNYHKGNigxAEvJBajqvsyvWRZAli8705c6gom1YC1dK/Im1+XGvyE0fPu7k8PhQ2gdRm3Mo7LKpcYA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PS2PR06MB3509.apcprd06.prod.outlook.com (2603:1096:300:67::17)
 by TYZPR06MB4127.apcprd06.prod.outlook.com (2603:1096:400:6::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.28; Tue, 21 Nov
 2023 08:46:49 +0000
Received: from PS2PR06MB3509.apcprd06.prod.outlook.com
 ([fe80::863b:f0a1:3066:24d]) by PS2PR06MB3509.apcprd06.prod.outlook.com
 ([fe80::863b:f0a1:3066:24d%6]) with mapi id 15.20.7002.027; Tue, 21 Nov 2023
 08:46:49 +0000
From:   Wu Bo <bo.wu@vivo.com>
To:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Mikulas Patocka <mpatocka@redhat.com>
Cc:     dm-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
        Wu Bo <wubo.oduw@gmail.com>, Wu Bo <bo.wu@vivo.com>
Subject: [PATCH 1/2] dm verity: init fec io before cleaning it
Date:   Tue, 21 Nov 2023 01:55:28 -0700
Message-Id: <419e7aa58f67d90020512892f7652623e8c9f059.1700555778.git.bo.wu@vivo.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1700555778.git.bo.wu@vivo.com>
References: <cover.1700555778.git.bo.wu@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0047.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::15) To PS2PR06MB3509.apcprd06.prod.outlook.com
 (2603:1096:300:67::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PS2PR06MB3509:EE_|TYZPR06MB4127:EE_
X-MS-Office365-Filtering-Correlation-Id: 7739ea1a-2ffe-4979-ca50-08dbea6e6604
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c2Dc2uRDVOb8o3V/CCaEvHWup+z+f+KM2YIiVfb2b/D+KaBezp5wKFjqrYSvdA+vHZp8Bdrg3Nrv09g+lmYvK2Q5kSUFE+hHdWPNsnz3F3/ucgqbYsisfJcvA0Q+wEm4vrnKEnvfWnaEIc9vrhQXlEwpf1ISAP68S2e2kp26H+29V9/B47OsANndDHHgp4UGfWepkvSEWNSi9eiYXTJAYbIKTFjb/SS+qC4m+KXj/FU1mR+CwQSR4fVaUmrTZz6/mw2JY/3ifzJD7hSjxDkfwvg0nTWuMiVHoMQhnMOJLd3W37ZaowbD158S3yw211D55PdKDpVfDgIW0gXn438cCauqnh05miPPYnO4oWZ9IGrRe4x1cKQvXKWSHWavdRK+uwIH5zAl0lXqhHna0xrOmI4wJojoBKOAQJ8FPFveRfUiuZpj7MlZ9ZeNsGRjbo7HgdFBxrYpZgKQmMhS99E7cUy437YdgoJ8Xhv6zI9elc2KZq6uE/gcE6BWhisX7Nx0P83b/MJ2dYdTdbKPvWe5AVhksC0eSUZrcnr4XkN1SpJyeJHd5HRbSee/nMWVujdu6V6Xt3Z2pLClsE4PhmLLFs7sL94Pjw/h3ecS/MN8tMQIIGwIxuorOXn9dOrfMp6R
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PS2PR06MB3509.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39850400004)(136003)(396003)(366004)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(316002)(110136005)(54906003)(66946007)(66476007)(66556008)(36756003)(52116002)(6512007)(6666004)(6506007)(2616005)(26005)(107886003)(6486002)(478600001)(38350700005)(38100700002)(83380400001)(86362001)(2906002)(5660300002)(8936002)(4326008)(8676002)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LGRtE2X/rNXFYOOsS5YubsX3M33L89w7KtXvMR74dzL0nUbWKN2GnKqX4jNl?=
 =?us-ascii?Q?wgBFngNSJEzVDsvNL6Jn/r/4fc0u1zCQ8sKGpiJOgWNgd83Pm472+6NksyYd?=
 =?us-ascii?Q?Ylmb1/YuOVY+Qutv5mUNDmvVZrt6YmIEBMdKcku110QwT6jFbkYdniYTH95g?=
 =?us-ascii?Q?kkW7RNAxlcYpWYJejlnB5K4Ofu3KmBjpCWCfidAayzmoZW+t75jzDkQEG00D?=
 =?us-ascii?Q?I4s10mxFaY/tC8aYX4AXJXkxmNxPa5p3SAIftR6pcnJGY1LnBTdurq6BjFym?=
 =?us-ascii?Q?caa/Zr6UrxosjspeR6r2fm4ihKt/i61sD/7FjvY6K/7jpNnpoUZF1h4Fghme?=
 =?us-ascii?Q?0WuWcrC9N+yZrIWpAvtg7CsqjtaJnlqJuKXwhn7TYT+Qd5Rb/REl6KXWjo1h?=
 =?us-ascii?Q?bEs2Uc7xkh45DtZx1YdFQ2blYLxLp2zV4trJcJPyN/aaIURYT6/2sBdur80B?=
 =?us-ascii?Q?mOpfKic/tqGGSQDqgLk6RunKTw3GUTi0rsbGxboz6MqQu7Ct6jzfG4TfVTng?=
 =?us-ascii?Q?+IERJm5fQw+FVPphVOobPPOnzY2o42X8whmjX9jSHWeTUMKnxi4PoL0NXnWB?=
 =?us-ascii?Q?UZrstTETDxQCST7q3MXcWa1A54OgzO+1iQqnnTRPMS2+TaRnAeD6hXliJgTh?=
 =?us-ascii?Q?3FhFkT2XgOIJlDLmIneH+JgRYhx9n1o7mb9SzB4cOdJgOXJUO64XDc8r43yF?=
 =?us-ascii?Q?U852ByA5yLUjS+qeymtiXIwntiOsjxNdw2l0UPV0yzIIhpioIfqw2oagMtIj?=
 =?us-ascii?Q?0QBUdVxTFW8U6/Uj5AGcGvGk0hyZ6ydF78VUG5mKku/XE0QGZkxVG4RTQjUC?=
 =?us-ascii?Q?e6Tp0TSVRH9nc/skJOW9Ssm2EDd4Qz9UwbAGiM9qSwt2MSOhR7s4olvTa9wO?=
 =?us-ascii?Q?PTbYYSj5bWeqQ3s5zA2xciiLIibxrl8rbSD7J21FpYQ6b3d8zcAUohQ6yv2B?=
 =?us-ascii?Q?A96+iAGK7x1HpyKPNTNucOMfd6U3p5/a+m97JLTikyXomBKalTZWyVX46mBm?=
 =?us-ascii?Q?8cFGvQiee1GdL/bQRxWjjOTFXFinfjlyutDXW8C+ok7ibecKTk/2lzzImS2w?=
 =?us-ascii?Q?ydB25KKl3BmOaFyDeAmRc0I0x7sOBX1Izh6sn+c7NddkgdYbeibhq1txk/g0?=
 =?us-ascii?Q?nKZ+7QEZMuHo/c9kJHFPnETb9QFKz0SartfSj6mDT3c13B1X7sFUaJmoguRN?=
 =?us-ascii?Q?GVFqAPjfHx57qGnrQ5jtnEZuvKTws6atlQpUjjzMTBUZYrV3VSQLh45OSKDW?=
 =?us-ascii?Q?cu9k0qIZfVhOs/3xarU1/OXWAQHHBUVLwnNhA7pLR6RDgx78JWrfv8yB4qsB?=
 =?us-ascii?Q?G3iBh3tTMjyHJudJH/PUK1BTS5Ncnjnvau74P9DqnceYTEbD/0tTd065P6fI?=
 =?us-ascii?Q?0GXyUIoau396aOgzdxhtTXSEscK8BFNXbAfk3F10xGTjmS9PKEYgmrn8yNZq?=
 =?us-ascii?Q?ZAhvlmdha9FCLVuInDokrFeYeh++RCv7SQF7FeYIT45+ZAkbb7WcsJv7HQL4?=
 =?us-ascii?Q?Qpw3WWf592rVnfZ6E2oPETseyJdqXZGftKvApFe+jDEyvDO8aFg58+QeKJm6?=
 =?us-ascii?Q?BJvtgw3/nqbYPJxOSGgXa1lq4tPWLZVNmY2XUglo?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7739ea1a-2ffe-4979-ca50-08dbea6e6604
X-MS-Exchange-CrossTenant-AuthSource: PS2PR06MB3509.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2023 08:46:48.9329
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 21kDYlBMzv3tj0+xmxqKhAppm5qU9rdOoJTApDKOi+Ywub/FNR+nsl1X6yW02DuGNiB4PmNTg1mAru9zztDPJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB4127
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If BIO error, it may goto verity_finish_io() before
verity_fec_init_io(). Therefor, the fec_io->rs is not initialized and
may crash when doing memory freeing in verity_fec_finish_io().

Crash call stack:
 die+0x90/0x2b8
 __do_kernel_fault+0x260/0x298
 do_bad_area+0x2c/0xdc
 do_translation_fault+0x3c/0x54
 do_mem_abort+0x54/0x118
 el1_abort+0x38/0x5c
 el1h_64_sync_handler+0x50/0x90
 el1h_64_sync+0x64/0x6c
 free_rs+0x18/0xac
 fec_rs_free+0x10/0x24
 mempool_free+0x58/0x148
 verity_fec_finish_io+0x4c/0xb0
 verity_end_io+0xb8/0x150

Signed-off-by: Wu Bo <bo.wu@vivo.com>
---
 drivers/md/dm-verity-target.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/dm-verity-target.c b/drivers/md/dm-verity-target.c
index e115fcfe723c..42b2483eb08c 100644
--- a/drivers/md/dm-verity-target.c
+++ b/drivers/md/dm-verity-target.c
@@ -642,7 +642,6 @@ static void verity_work(struct work_struct *w)
 
 	io->in_tasklet = false;
 
-	verity_fec_init_io(io);
 	verity_finish_io(io, errno_to_blk_status(verity_verify_io(io)));
 }
 
@@ -667,6 +666,7 @@ static void verity_end_io(struct bio *bio)
 {
 	struct dm_verity_io *io = bio->bi_private;
 
+	verity_fec_init_io(io);
 	if (bio->bi_status &&
 	    (!verity_fec_is_enabled(io->v) || verity_is_system_shutting_down())) {
 		verity_finish_io(io, bio->bi_status);
-- 
2.25.1

