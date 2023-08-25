Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B6B9787DD1
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 04:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238459AbjHYCij (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 22:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242020AbjHYCiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 22:38:23 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on20612.outbound.protection.outlook.com [IPv6:2a01:111:f400:feae::612])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC0371FFD
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 19:37:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TtxoyCoKDkL4Ji+zZDFCL6/laon1+60tJzKez6BLaKzqJJ/wsgyDEKM87W6CwkNMQUCTTJlfQwiZAv35317M4WPBQ6VM2Oz/ongSyt7bwusXqn+/9/FtZoQeXZSrtdswmsc/OZ0Ek4AP+o5Anf8yvgEcmqjWync+n7ChPndYNqDg+FNmlYy5/lHuYMaRdjks5cYiIeAYGXKOTfi3+zQRWgVPJ3/M8SnY3vucdufqq21gZ/ksXAjNpMRBclyd9TYQLcuqQTymvwayeYD3et1zIGFSkgh//agGb4/hj1gET11XnPc4s+ayuLpbFwUcgP1eYfXS5+XNaNazfVbMtqzXjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZpnlsGyo/vkRhNUA0n4fBEiM515WswcsHM8UuFTlLNU=;
 b=HpMcPb81DDuG6GQaYIWyWNZIxiaW+TntF6N55pfjQNsLxEKZ26r92/OQnQ+0Q07Hj8Q+dU6AI03P4d378ajHENvlzH1i0bVZksetnrtiDOmBMO9IZlOkTaGK4OrOjmNS7xMMMwjPQ7A43UkHtqm6GMwCRVWgRmRZLUt0NRmsCBxnVp1p6xcbI1RxQCARpuEkRGYKIq62NyAWRRUrGmhmPmhnNmqnz9EF/+52U91QTlwKWiNbgGZMp4s74pWSV3sUJHuVEfAg2IIOc2UtkW7keLtSjfrtP7Ie4NfAyamko+iIAnSib/xcw8jNmrkZUkM+jZtPyny4CymTTq9AMNg8xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZpnlsGyo/vkRhNUA0n4fBEiM515WswcsHM8UuFTlLNU=;
 b=ZxVmnXUgmk/FmvIGI09nao/FHxcWbAm76nl32wVO32xhQo1mz+25BAavTqTwJ+Oe6vaLDokJ/+BtoPl3ZF5KxJdluzBbnBUUn1hpyBnRvJkMgxOntlrKWonATBpAus8vIAKX6aAaqx8BUmR0x+av/2iKqN/Q0POCQxytcVVba1uy+PXwzrCF6romPwRttg5C4sYg0eTZN5ABrHzJlW2MXgOUmr55lY51qFXJMZm5N1HmrBKlEioGt9iC1YGz+PCUIVMgEVmuuTajpE8kO2B2zROSVSUqF5Ox8nOtzPrYKLLjzY6lt6n9MCUcljyM6Pd2VdbEaFuCpCjf+vRInKgC4w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
Received: from PSAPR06MB3942.apcprd06.prod.outlook.com (2603:1096:301:2b::5)
 by KL1PR0601MB5488.apcprd06.prod.outlook.com (2603:1096:820:9d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.29; Fri, 25 Aug
 2023 02:35:21 +0000
Received: from PSAPR06MB3942.apcprd06.prod.outlook.com
 ([fe80::e272:7a5a:37ad:187b]) by PSAPR06MB3942.apcprd06.prod.outlook.com
 ([fe80::e272:7a5a:37ad:187b%6]) with mapi id 15.20.6699.028; Fri, 25 Aug 2023
 02:35:20 +0000
From:   liming.wu@jaguarmicro.com
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, brauner@kernel.org,
        linux-kernel@vger.kernel.org, 398776277@qq.com
Cc:     Liming Wu <liming.wu@jaguarmicro.com>
Subject: [PATCH] [RFC] sched/core: avoid checking in_atomic_preempt_off twice
Date:   Fri, 25 Aug 2023 10:35:00 +0800
Message-Id: <20230825023501.1848-1-liming.wu@jaguarmicro.com>
X-Mailer: git-send-email 2.34.0.windows.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PS2PR02CA0075.apcprd02.prod.outlook.com
 (2603:1096:300:5c::15) To PSAPR06MB3942.apcprd06.prod.outlook.com
 (2603:1096:301:2b::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PSAPR06MB3942:EE_|KL1PR0601MB5488:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f02a3c9-c78a-4967-1751-08dba513ecf3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pkyz7OJTtYoYdgxZFmogyv3z/HEzhNaGdpb9SVH1UeTi42d9pALchABxUC6sPO5fI4oAAE9Jovoq8ePUBF/3VlPNM7d1GCIe1zxX0+QijbuQQWId1RIZTngAUOL0HF0GLhmB0f5bXESBBomtmnf6MbEgwHgb2mix0wq77WS0mfovKhpQIWJLPVmFzP/3SRq6NvUiR1fRU1RNGaeWWgqqua7V/6QQC2tmMVlZqTHSRLS9Vaoy2p160Xogon3iF4R3ep0mjl1cc/LwhQdwGGnW+mETA9x3A71QoRf3/GjWq26HBU/1d59QxHv6ReulQqn1FOTo6EvjyEtYqIrrxPGwrlyk2qVv6soQjdlIgZTEGgU7hE7U4GMG/3DHoQihFXvrh1HArctWmDA/Dh3k0Dlge7Aa/yk5bvhRUs+gwiG2By+BbqiBf/j8jmZYcpUWd4mp3D6B8sGdGA5NaRgnzEXs83FRDzenGo+8VdtonQT4+B140W4UqmtIttW0na1Lu8K162KXHfIIxMyYDp2PouRTUPyG1yyCAJjtubK4eC8qPXidfNbItrkqU1J/w12iYWlYov3LV+NIM94pEpSyWbJq2vdV1kDRqDtciZ+VpSlpQjgmoASK4/UaQ/xvjUNeZDdsb1o6ro+H26219mrNFN8C4g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR06MB3942.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39830400003)(346002)(366004)(396003)(136003)(84040400005)(451199024)(1800799009)(186009)(38100700002)(38350700002)(921005)(4326008)(8676002)(8936002)(41300700001)(52116002)(6486002)(6506007)(316002)(6666004)(36756003)(66476007)(66556008)(66946007)(86362001)(6512007)(9686003)(26005)(478600001)(1076003)(83380400001)(7416002)(2906002)(4744005)(2616005)(107886003)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Sf68971f8PGIDC8zA+70X0t3guRV5EkpDpaUl1j8cfVlvTQ3jO7hiSg5XUDx?=
 =?us-ascii?Q?trgafEnUl6EWDLNzgjTCCEdVoY9VuVYKLjL0vNIwiPknzXlHv0a0jDrBlNRl?=
 =?us-ascii?Q?S09f+RJxNWRQbEzpbIf7fj32HHdL9W5szQNAk+5hki9o65V84DVpBvStrM9R?=
 =?us-ascii?Q?EijCMNj91ymYCQoDVzCyMgNNPydzCxHtdvf+C9HZLvFYtdLrd4SW+S887A02?=
 =?us-ascii?Q?DnobjqLRAKnjrZd6PmnyiBv48I/jpVIwQpBA/nF9vXatvZE/gBVEK8mhNChM?=
 =?us-ascii?Q?VZ8G077sF9sn+haudUjC/xfJ+MRdBEI0Ai6vn5LRZLsaRFMOp3XzFJbgQ61d?=
 =?us-ascii?Q?GG286GkYQsyrQe9rbZxZlq+QmbAi2+vvJGy3RwyPZHX5JncY+XcEphk2gz7P?=
 =?us-ascii?Q?GkWLxgVTixmf0DzzPMrD87B006gQqGJq3sYx8PwaxKxarr5WACLtKLzKROck?=
 =?us-ascii?Q?SUzZh+UdYQHtQ9qdXO7kuQL6UtuifnOKJhIaPMW4frzM5CdOnSl2BSybHFEJ?=
 =?us-ascii?Q?XNguUqmMcLul+pXhMvPi2RSiodfixKrL3DllhoU7UAMD45i1LuL6Xf6epF4H?=
 =?us-ascii?Q?VjwYsTWq6s6AwHIA0cmZVtUa7cwtQ0jP4bKUX/jqhs48fZXMyhzjzEkQkcAT?=
 =?us-ascii?Q?Lbs2/1mFZ2XoamSTruFN6FugHhcFHiS3MGrhz+jC1r4XKrs15Z5LBdH9o/78?=
 =?us-ascii?Q?HYdob99tuqEZ4PgOYQw/691tHD436B4/ql6ZCSrcCAvIad0ZW0/cbfQudXeo?=
 =?us-ascii?Q?G7zqXqRAYBVTY9TNP1I54G2nCX8rehG9sC5zhQaT+jJm9aGCnXmk8HUEv5Zq?=
 =?us-ascii?Q?FQkZ5DfClbWOaRJlilfedWMFW5lyKZRZKvYwkbSORy5FbDsjFZQE0mJPGg/i?=
 =?us-ascii?Q?UKYrpblsB8/ShKqPiR/Hd0bglakySm6se8ZJn83gJXZrtsHTNbSZe+8i57nn?=
 =?us-ascii?Q?vBjH2jb7OJkCJSbZItSv3sLxaTJGmc1AdkXVx8tYJjjAByK6edcrLVmq4jt+?=
 =?us-ascii?Q?K9MegueudG269VB8Ex7i81O9pm2RkKlOFzIIeDh3+tqurg+rAtNDA1IkMOLP?=
 =?us-ascii?Q?mxRfmYaox/2h1pUZkx+BotiU81ts6SPlb5iK6NwCYHhgoiXJmDQ8j6bG7UCj?=
 =?us-ascii?Q?K7/vYn2v7PqhWyMr6ppTlO5BvnbBlNXcsijxni3ppj+23Kt/QllJVdhCkVv6?=
 =?us-ascii?Q?qPLMzNFKwffn8bznIDCQ3/jbNjtAaBD3ZhJAxRctNOenHLFdb2XaOXJ0DfEI?=
 =?us-ascii?Q?xCXviE5cRaAvUMTUdQdVE/rTtlpLDD6exIWellpahHUHJCQ5QGPvB8eL7OWS?=
 =?us-ascii?Q?hSrXc2I6bdBBnSnkrp5ojVhkYmp6wjo2ql1EyhXUjYmcQJl7WbqSFJnYRw2L?=
 =?us-ascii?Q?uCm1/G6raHt4Ttlxt9p2zStRcF30E6mPt583EZYfyNIqGZchn51m/37rWM6N?=
 =?us-ascii?Q?wi9RuB6H9V5lKGj7K5g2ZdcgMwZbtHXTm7afoFh+/j3dAVo8A+mBhOjuuzlA?=
 =?us-ascii?Q?usyQ0KndvdoSYrbcxJBu4zu/vq6RGNiImFqWZKsH6pF2RY7tggiQRb72gA0P?=
 =?us-ascii?Q?vJsh90hdzZuoc/FcVc5d0poIh1V+jKH8HG4/Tczl8OwjKMYjOIoqIM7wR23S?=
 =?us-ascii?Q?uA=3D=3D?=
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f02a3c9-c78a-4967-1751-08dba513ecf3
X-MS-Exchange-CrossTenant-AuthSource: PSAPR06MB3942.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2023 02:35:20.3846
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7OxuhDKpvG5FkUNysAhJDFCmqe6cwSaTIFs4Onp+X38zKN3ZcwQCFzYVBEVpg8L57XIezvi6Kt/cRwTymxPSHhzRx/Wq828tlTm/AtZMulE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB5488
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liming Wu <liming.wu@jaguarmicro.com>

in_atomic_preempt_off is checked twice in schedule_debug, and
__schedule_bug only called in schedule_debug. remove the redundant
in_atomic_preempt_off check in __schedule_bug.

Signed-off-by: Liming Wu <liming.wu@jaguarmicro.com>
---
 kernel/sched/core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index a68d1276bab0..ae44958b3851 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5884,8 +5884,7 @@ static noinline void __schedule_bug(struct task_struct *prev)
 	print_modules();
 	if (irqs_disabled())
 		print_irqtrace_events(prev);
-	if (IS_ENABLED(CONFIG_DEBUG_PREEMPT)
-	    && in_atomic_preempt_off()) {
+	if (IS_ENABLED(CONFIG_DEBUG_PREEMPT)) {
 		pr_err("Preemption disabled at:");
 		print_ip_sym(KERN_ERR, preempt_disable_ip);
 	}
-- 
2.25.1

