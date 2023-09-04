Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEB2A79108C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 06:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351474AbjIDERm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 00:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235595AbjIDERl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 00:17:41 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2128.outbound.protection.outlook.com [40.107.255.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87D27F9;
        Sun,  3 Sep 2023 21:17:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N2CS9lt6AAefHoVbsOLpaSH1rGisaafgJJactt59+OoV/vIm+jjuFiddBhl+n7ofIlR4YoOqKQwNUws+hpC5BT/oC/dQhomJamlSSnA1e7FMjUkzg9qL5f/bKsrMQ9kKejt5NwCyvT+9CnFAFGA8Vkdm/ZKaUu61jPrX+uyBHtYFPgpiDc3FUBVgWBZzIvuN9q+yPDJDULhOz5W8rNP4ZrJc/ex94/++2ZCYzVfH0slJfiQFy+C0Z8E5LS6Qo+jHpExFX+OBepNMIdzI6VDQbhFHKKaiycbWhhUe3FqMwNEekLRvp670/zzVe/BxkqHgyQT7Uk3i0f/6vWLhFcYqXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZQrEP8J/yaJbBLWlA1KusJumCtRdrDWDi8sOqDFxOb8=;
 b=jIMhCAcpA9UH68uZnR4OQjpRK4aHlHr1bqhLMIA6XVV2Cx2sS8zg6bU70O4NyJNtoHx65X8fCfUE1XbvzYO895KtnpHZHDMfHeCUaLoQdto+RHKrhS5hYSu2ZsIKdRo7FGWcycnqvdRyLJd64bI7w04duzvG96bemUrbIe4TDGaaY0SrGUGbJ/pzy4UFhgdCvmSN888ZEtiGlEOE5q8pApsyn5OzjtSZFt6wzExsOuBpOQh5ExlYvyJloJumhZZpzExYnYu1KJYfalsOxxLFaQkAKk+UaWgzcw/C7fZZK7VUt1m8RS88kXhsXO29p2E30FaXt4BxMlAkvitDD6yl6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZQrEP8J/yaJbBLWlA1KusJumCtRdrDWDi8sOqDFxOb8=;
 b=GrMY+sHIhDnSZ3075GmmVH4fpFwRDx1EDwZDLEN1WnpuETFGwDcodNmDhuSiyk8vIU6WdKI3x0HifAYz9xqgRjxKYNjoaDQxncVqQ8kaPHnX4Q8lizcRQ8TwOWdgRIEXljy07yMaf6W2y9JKLz0uO9pVezhmWdRsJDwxNfzJOzk/47jD2DERHZEddbUEHmzJ3FVRuWr/9Gb+cWEB3ni7RB5i2rR/8oaH5qVKkK67vOue4+qM/qwzAPEnc/xVw8fZhRmoJSBF9LnXsDhPzkAahrepTFYtDyKnTiVYLvQK7cCjd2JerSOSmomwgFYurK3ZQPYLrSfkzOV9UdnDl5Mi/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TY2PR06MB3342.apcprd06.prod.outlook.com (2603:1096:404:fb::23)
 by TYSPR06MB6627.apcprd06.prod.outlook.com (2603:1096:400:474::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.30; Mon, 4 Sep
 2023 04:17:29 +0000
Received: from TY2PR06MB3342.apcprd06.prod.outlook.com
 ([fe80::60d3:1ef9:d644:3959]) by TY2PR06MB3342.apcprd06.prod.outlook.com
 ([fe80::60d3:1ef9:d644:3959%4]) with mapi id 15.20.6745.030; Mon, 4 Sep 2023
 04:17:29 +0000
From:   Chunhai Guo <guochunhai@vivo.com>
To:     axboe@kernel.dk
Cc:     chao@kernel.org, jaegeuk@kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chunhai Guo <guochunhai@vivo.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] block: export symbol blk_flush_plug
Date:   Sun,  3 Sep 2023 22:22:43 -0600
Message-Id: <20230904042243.820031-1-guochunhai@vivo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGXP274CA0024.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::36)
 To TY2PR06MB3342.apcprd06.prod.outlook.com (2603:1096:404:fb::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PR06MB3342:EE_|TYSPR06MB6627:EE_
X-MS-Office365-Filtering-Correlation-Id: 33685597-1cf2-46ce-7f03-08dbacfdda4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iv56a+PSCGpoh8B+xOwth/vGTjYC7o+IJVJbbk/9aKCO4JSMSH6gvcodsHz3iodWn9keRhXbRPcZr2lOmQL1ha///s30oXg/s5peHYyKd3HX1Lc/t6qbYdaA6RAxv2vcag8w97q45jCFG5TkLNhS8Hbyg7gG5kELeas35zJ6aCz6GCznB/RUJA8gnlVLAqyL9Nyvu+kmKNNy2Y3PmF0dinTwAJSumuL4L496ZAcjrqW3s8X8WNJY8lCnaqHMgZQ35o7ijfx0h28Z3uCo65KjbpDAlzWGht/tyG5+gy5g8lzRT96REkb/LpmLgxQa7q3OhJzjB63RagXj1S3WwS0vMnxc44URAg5X+euYiAhjoDMP//SGzFpYC3Glo+T1EAI1EvwBs0TS95oo4GIht7TL/8DFz9nTd+nRV395fbsCW+MJX2YDa0EO9tKcbxNZBzKyyRqIegtq4Hevr9FwSYO0Aui7juBArTZOqqy9vtQoWBQtPzXthpXsl3XgYUyf88E9zsOIN92TQqhfjGw7VHvyricm/z+O47hcVVJMrTfWdVArXZDNmA1hdG/k3jcR03mjxgLKSaYFOBax+B/xG/fVqCkzS64vdXlfzfAI7mN+43Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR06MB3342.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(136003)(366004)(396003)(376002)(451199024)(1800799009)(186009)(966005)(8936002)(41300700001)(83380400001)(478600001)(6666004)(2906002)(66946007)(5660300002)(8676002)(6916009)(66476007)(66556008)(54906003)(316002)(4326008)(6512007)(52116002)(2616005)(1076003)(6506007)(26005)(6486002)(36756003)(38100700002)(38350700002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vxPakr4/w+DqHmozvP7vSRBetz97VvwYt4PsIbMV4ksb2BpLsb4lgFZGrgnz?=
 =?us-ascii?Q?Dw9K7KB0pBFxh04iPLXtB5pVJiQaLDcoOFcorKp8v1mIqGFFkThmCcIvdJHm?=
 =?us-ascii?Q?lLadkMFECntru4wi1S0WtlId5LOh+/f6IYiE6hi2VYhj3eVeZXj/bs7C4DQk?=
 =?us-ascii?Q?9aI3I0+hD9G9roIOfX0AUWfPS9a7xvvgqgubb4onLfnODsFiyarXVPasji4X?=
 =?us-ascii?Q?/kTwQ6tt6ZuoNrcWOcTpTe6pb4pfU4xOEu12fveWkgMzKaPszco1NCkSole8?=
 =?us-ascii?Q?4uRfBSPU2pg4B/Lp7WKXUwVOocrG2wf8ZuJhRyb0vQMmT/vcB0J++1VIuDJf?=
 =?us-ascii?Q?Jzhq/v76wU5skylGGzwgU6FljP0idn+lVTSjEOO5Q+T+zIv/Mw9wpwosCqTV?=
 =?us-ascii?Q?V3h2vXe/XbY2bZfU7lEiEZBdUwgojKl0PsRrcFsZe1ApFNoXQXh1LmtYRpwG?=
 =?us-ascii?Q?R9rDOBkq7Lu76BIukM3oWqc9Z8rvviepObkDmg44wNUsJTKAnHr3O1eLXqmg?=
 =?us-ascii?Q?BeFe+f9MWox4yp1L7MYkxtW4rI/7fERFVStTrk8m1aI1hT4kmk24mj/XEsda?=
 =?us-ascii?Q?YvN+0EZ+OjyeJNcAzRNTpy7eMkMc/NLYWRJCLNOdT02CN96+RpSSwxg8l2+H?=
 =?us-ascii?Q?R969MdF2dl+FmPxzGAQdchPyZ21D11dYArO1dyKwXYRz5K+RQ7OV3yA5lQvN?=
 =?us-ascii?Q?xluCBiuLYODWjHiF+gpo3dKoDO3jNa3mIX/osB9FA1LhMeSp+4kmZcue9MCT?=
 =?us-ascii?Q?GnsBp8JqXg9MQf92FBniMWB+wg6Y8vg0Bl+FvmuHm5uPZXJyijcIEZxWWD7Z?=
 =?us-ascii?Q?GlUqKYmBlEPqOxpK9+PjbubsM9evWohrKHqmnuSnErh2RedJUuHp1NlaTxEc?=
 =?us-ascii?Q?cGm+Tufj4zkGOAToCATsAssvRMACqjBMP9z56qw5W9PvYgOf9oM0jCTBaVUN?=
 =?us-ascii?Q?fvnO/ery/d8oqxWqdYntnLNj5r3fZmBM0MsI4M6oew3y+lk0v5vEC5mcqFAG?=
 =?us-ascii?Q?PUq4nIU+kpM5Cbhh1vBUULsB3FP/3xx8N8eeM0j/1lP3h5w4Z9IhlLCMS6ob?=
 =?us-ascii?Q?VVqfT8h/l9++3j9PFFvgUefjUFuDBvUmBhVDz4ufVoZMVpBEzK904QnVTAsi?=
 =?us-ascii?Q?jEiPiU1nkbQJKJyeHMRqru7WuBbcZdT+NMGshvZoQUQnoQRN4AoQwwDY5sto?=
 =?us-ascii?Q?R448t413LgxoR/uuEjmQG/pMGrc4XTSm6TPFE/4vx37n7UWv3ybBn/izdhLH?=
 =?us-ascii?Q?Dah7IvAOUCwaf3HRwgQvPM/hWYZWFiepa1RdgApUroCsFE6hHF0gt/+Y2gfP?=
 =?us-ascii?Q?SuorM17WIvIIHDNXr4MHnsQ/xHpx0GGkx9gtkIYHc38SHutsEJXHm+guKtK+?=
 =?us-ascii?Q?XcC/HKSFH5bZqPMxZCBepCzVKYbh9teaEoMz+jfAU7/nk98qYGS2briagW0m?=
 =?us-ascii?Q?qoynsV7yl5cCRwXEwRPKvw0ARd8bt35FUnLkLHLF7wBejgpFgk9crFppnsJ5?=
 =?us-ascii?Q?4zugsqmY4LOlacpQevJ88HQ6J8rRUevEEzFhMcbEb2PROKHS8RkpwhMk4PoR?=
 =?us-ascii?Q?Yy6LwLf2S+uCih6Cwq/536Hp4n6yYZa0IDQ9lBsh?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33685597-1cf2-46ce-7f03-08dbacfdda4c
X-MS-Exchange-CrossTenant-AuthSource: TY2PR06MB3342.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2023 04:17:29.4259
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r24oaDFGk/jWItidpbR9Z0yr0O9PwEUs2drEKVlFg9Opx3K1M3u0RcRFD40GfavrjV3+I4uYQPDj8XBJN+AmmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB6627
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

blk_flush_plug() can be used in a filesystem module, without it may cause
a link failure, as shown in the reported test.

ERROR: modpost: "__blk_flush_plug" [fs/f2fs/f2fs.ko] undefined!

Export the symbol so it can be used by filesystem module.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202309021523.UcS7T7mp-lkp@intel.com/
Closes: https://lore.kernel.org/oe-kbuild-all/202309021427.K1P8kWbl-lkp@intel.com/
Fixes: e1e9b8062c74 ("f2fs: replace blk_finish_plug() with blk_flush_plug()")
Signed-off-by: Chunhai Guo <guochunhai@vivo.com>
---
 block/blk-core.c       | 7 +++++++
 include/linux/blkdev.h | 8 +-------
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 99d8b9812b18..1c5e5d3406fe 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1156,6 +1156,13 @@ void __blk_flush_plug(struct blk_plug *plug, bool from_schedule)
 		blk_mq_free_plug_rqs(plug);
 }
 
+void blk_flush_plug(struct blk_plug *plug, bool async)
+{
+	if (plug)
+		__blk_flush_plug(plug, async);
+}
+EXPORT_SYMBOL(blk_flush_plug);
+
 /**
  * blk_finish_plug - mark the end of a batch of submitted I/O
  * @plug:	The &struct blk_plug passed to blk_start_plug()
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index ed44a997f629..26ff9d417e6e 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -986,13 +986,7 @@ extern struct blk_plug_cb *blk_check_plugged(blk_plug_cb_fn unplug,
 extern void blk_start_plug(struct blk_plug *);
 extern void blk_start_plug_nr_ios(struct blk_plug *, unsigned short);
 extern void blk_finish_plug(struct blk_plug *);
-
-void __blk_flush_plug(struct blk_plug *plug, bool from_schedule);
-static inline void blk_flush_plug(struct blk_plug *plug, bool async)
-{
-	if (plug)
-		__blk_flush_plug(plug, async);
-}
+extern void blk_flush_plug(struct blk_plug *plug, bool async);
 
 int blkdev_issue_flush(struct block_device *bdev);
 long nr_blockdev_pages(void);
-- 
2.25.1

