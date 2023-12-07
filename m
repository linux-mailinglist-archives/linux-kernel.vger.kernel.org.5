Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EFE2808685
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 12:17:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378926AbjLGLRl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 06:17:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378884AbjLGLRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 06:17:39 -0500
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 351BC11F;
        Thu,  7 Dec 2023 03:17:45 -0800 (PST)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3B7At0jJ006057;
        Thu, 7 Dec 2023 03:16:54 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
         h=from:to:cc:subject:date:message-id:content-transfer-encoding
        :content-type:mime-version; s=PPS06212021; bh=SlSauMest/NZtzOUHV
        XS1RkdvGrewacSoHgydz3rfuE=; b=FVJywQZI6dzz8lsBnAjvYwbueTItfu1FtG
        D6+85qNx7VZ7+Oe0bbewhDwyA+8t910virWwHTXUlGnnu0DyZF95Nn0I2RYklazj
        qTLSbcRhNWtHLSNIiUijKzLHwg7JjxyPaPGnreSDSAHfvA1DmwK7H5Q+Bjk7y0RE
        rajIVLeOAFu6cRVlVUrvcIhedoCwvqtxLKxkXZLbJ6LSijtBKZjS3pUOdJ18y62n
        R2ezLA9MJEU+lpCP4BPVxi+gzfuARnCQXrzHipDgXwVvInu9bmyOOiA+upIVODXp
        VCPvc2estgMjoz5qoeJVaFPGYe+qc2wi4NunM5iVoNvuyGhF7cQw==
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3utd2r1jkj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Dec 2023 03:16:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fhHqY7VUPIEeT5s/j2hQZJ9sz7NLJf1iGNTQ1+Yafeo/z/vVXbfPsfGwdkv9249Ke0NAmUttmT859+KT57JqiL4Wuv5B6KoTaAWQuR3BshB1fyQSMg8RDjOAipOTyqCFgNQVvBOSJ1g3ruQl3++Q1IyNMCx0IJ6YH9Y51+3YAm33JZhSkLWg2lqUveq9pvfrn/mGFWizVfQe8Th4xC4zatz4Vl91ipEBERmkPuwA4h5hLin4Xdq2e5Jj76DPrmHtqmZL++uNsMFJ0z/MHrT9E54Rjnzz3fg5NDs9RWuzIhJZASt/fo4MpQ2IEaQIrxJXKvtOD0UHnnficlgvHAryzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SlSauMest/NZtzOUHVXS1RkdvGrewacSoHgydz3rfuE=;
 b=Adn+bne+buml/8OZcgTsEd+vQ5ynpsAPJbzE8z9ZXMTkMF8M3W1RKdlimoJIVoKY691k+ob3dBss1tiORcGsj5YndKu0JSBkGOJi4rj4o2nRkNRQFfltn1RoCB2VZdVmvgQxC5Z6r3GP2S/vvjApPMtJ3B05KINFkQVhWMMjNqyAqJ7Oonu8t/0ecfSG6+zeaGaOnqc6PLei2hqy2Mxa5iUS3DBCyhC/cm92wKTFIKWFPYkDbKQ59n8kqLlpUOQVYeNLTo7LV5bTEFyyRmKFCkM9SEN/oqCzTS/X37hvJvwssUpfktP/K1x/AGcRJRSMfvzOeebySZSbBKcclZaikQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from MW5PR11MB5764.namprd11.prod.outlook.com (2603:10b6:303:197::8)
 by PH7PR11MB7145.namprd11.prod.outlook.com (2603:10b6:510:1ec::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29; Thu, 7 Dec
 2023 11:16:51 +0000
Received: from MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::7d7c:4379:e96:3537]) by MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::7d7c:4379:e96:3537%7]) with mapi id 15.20.7068.027; Thu, 7 Dec 2023
 11:16:51 +0000
From:   Xiaolei Wang <xiaolei.wang@windriver.com>
To:     rafael@kernel.org, pavel@ucw.cz, len.brown@intel.com,
        peterz@infradead.org, mingo@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] freezer,sched: Move state information judgment outside task_call_func
Date:   Thu,  7 Dec 2023 19:16:34 +0800
Message-Id: <20231207111634.667057-1-xiaolei.wang@windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0194.apcprd06.prod.outlook.com (2603:1096:4:1::26)
 To MW5PR11MB5764.namprd11.prod.outlook.com (2603:10b6:303:197::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR11MB5764:EE_|PH7PR11MB7145:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fe13986-8fa5-4ce3-2bcd-08dbf71602a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kShUBMBVOQjvBycOZtXSSuAM9jxHi/9XMOgMLEHgcY67a+MXy0VCuxLXo2+1OlCQJgt5MNHzj69+9YkpL/46fEnnQg4flLKUXs3QO4TChag4FFO9VTP/6yEI96MQoiR0FkCb3u7E2KAhyF5Kr5hGO3anUiuaZXPkM4QS0HooD640mfs65YicoxizyAXmZZB4KhlDq7mU0iSPXTOOLdjLlbWp4O6lOdeJvfWLdTxHBSfIIj11toA/4p1LEjCllCoaYmLAMyeWNEQhSIR8JyXlNQKXkR7DyXVqfYdiH3gHm4btu2gkOSst3gj+3umyNnv2RbTJ1KPGZBIYHulCJBVbwO0bOy6xQmcv7J7ljD7uad6EdQv9/vYVqrq2cqUySEa6lh+p00bRseHZ8VsYYUuhegOE4JvvTsQ1jn48bbuF4M7feShF+W1UhsKm9Zf6zdPemiyST4Wp4GxuF2XL1jDEKxXLpvcCemEKTMAmiSrf+ld21Hdagq6s4ZtgXQQ1uztR7yHEj8OCsepLqOop92ZBIPzd/JbNXovPRK6ObWudbcCCvpOhsq2xhR1743Pe1HCcpx6ISwxaQO/b/1wA2+DX5sArNSLfrN6POnUkaEBRwY4Uda48Vmo5sk2rrvLI4TP1BOTAgEtA1KdU4u5/86xJuH2ObXwIH7Sy/IdZU/dUku0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5764.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(366004)(39860400002)(376002)(396003)(230273577357003)(230173577357003)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(38100700002)(41300700001)(36756003)(26005)(1076003)(38350700005)(83380400001)(5660300002)(44832011)(2906002)(86362001)(6512007)(6666004)(6486002)(6506007)(8676002)(4326008)(8936002)(52116002)(478600001)(2616005)(66556008)(316002)(66946007)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jJ96ee4R9ncXsi47zkDaEZz5rhWTAPZAQZZJk4nAPWCtDBqeoZGVZzOYrL+8?=
 =?us-ascii?Q?FiZqfqqwDEbzVVrBLqfPPbsiSmtg67BZHGX16cpdLbdrqjUvthPGMACCv0RX?=
 =?us-ascii?Q?aBStmVJ5E1UIlT38Ji2Cq6lXVa9nLkTCfrQpNYx8AW16u1wTiRQv/Wj1liHK?=
 =?us-ascii?Q?lVt57xbP50X+aYFlYkSiFk/x24TrNoz7ON/fNLNB6f89lpDZJG+N2lZ6KqUr?=
 =?us-ascii?Q?EaN+DIuXqTPhzqja6dxUE4R5QHqnW5dzKZbfGMFNJ32xB8vUBxZ4cgNX0uks?=
 =?us-ascii?Q?xdchxZSwGGw6J+SEB4M5pl0kBOLv2Mbs/PANKd9ZPaKXushJ0ZqqdJ1u7yk4?=
 =?us-ascii?Q?7tuIlRI53YOid1z3huC3ihQWQ77bezdtbv4gBtKy5JDTEbip4bB5NhUXG79Z?=
 =?us-ascii?Q?kWJfkRgl/NnOx6At7H5BWn/2B+WcQtGwEVmhoSsq6BG/Cm+tbuFEpl9OO+72?=
 =?us-ascii?Q?8VTNmgsBQjo2m3g7KGqFckM9reRxb29Q4mvLQHDH1Pj7QpNCw3QYRL1Bwb8f?=
 =?us-ascii?Q?mPkJHN0jU8JRd9JUDWU0L6ieF6+bYeUzC+yhLRJjo0MP30m3LVarAgWOX0Cp?=
 =?us-ascii?Q?VG4Js86OTgAWI6Bj+BL11PtOgKphT6IeF7W+n6LHGkFiECi5sGTs0MoBqRQp?=
 =?us-ascii?Q?Sl++E7e+5PGTAqJZsKrsU4cxEHQHCL1Jd+w9cPpIXu+n4a7tP7/mAacE0GhS?=
 =?us-ascii?Q?UXqcHImoMPNlJ5p08LbE0K082snFzqAhy2kD8NrPZBQ4HAyga+YmotzqvP7B?=
 =?us-ascii?Q?9waBQYPtxb/LoLQkwhmnuySNrvmjgcVpdJgItQFR4+qJms5WDbQ1LFJG3szW?=
 =?us-ascii?Q?gJjzqcePSWeYJisXPfSEehnhDmxyHte2a1ZFkRKyz9EuHY2ZJZpQKkrpjLRZ?=
 =?us-ascii?Q?xsBxfD/ZvUFSSiF4q1y7Jnwvrmxe1fNCRFi1/+XF6iX0zFwQ9YVMxvm5/I7Z?=
 =?us-ascii?Q?rAdUbWIy4nBm7kATj9/TgvmKgIkxIn46WxzHnGKyjxK7VcEzqT5hM1sHH02I?=
 =?us-ascii?Q?I8Kk29E4CqKYmBhBgrvGWcJpIkvzOhyhTqJ+h2FwFfucSdVdVbdh8YDpUkQD?=
 =?us-ascii?Q?ikNDIPL1bIIZIgeljkYvlbrktifQNXfpj6CAVULZj+dssyfHM48gpZQYbNxo?=
 =?us-ascii?Q?4F/rFRTKT6qf6jvSVR6k02K77X+qSs/q0K/R6+Lvgr+U3Xw3Vpk51BaTLzRK?=
 =?us-ascii?Q?aTDwvhn8Gd0V5ThemypV+a5HbJ2/AXpOX5OmrSL7BMNU/HoDfU/wIis7DSAc?=
 =?us-ascii?Q?4aHvG31ZIrVdi/byUfZtCidiPSxgVi50yd5ZpI8QPvphYBDmDcGYycSo3QCF?=
 =?us-ascii?Q?A8mKEZpcYDvpTinpylTDoxAmOMKmefnPfLu71t1VMoscmSusGxvvrFn66g1H?=
 =?us-ascii?Q?Z9LSnwJp3Ir7zoseYiJiXT4NsOt0FCADWynfgsvkMFUoG5dvAxxoYlcWOfhm?=
 =?us-ascii?Q?yudLL/TilLqPZrBLyHh9KSTcFitYkpMXK+xHV4b6XD3jqDJTYwMEdwqfmTIU?=
 =?us-ascii?Q?K6MhCJDEivo7riDBb66D6oTeUr79VIcSbgcdd6/h2zfZGZiAwf+l2UZlGJYD?=
 =?us-ascii?Q?Dq5iK9uF7Gapz/KiXfBp9ji6w8B22/jLhFGGKhhKf+CSiUCmw7xD5u9TyNB+?=
 =?us-ascii?Q?gg=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fe13986-8fa5-4ce3-2bcd-08dbf71602a7
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5764.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2023 11:16:51.0830
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ar8QhMSYoSmMH5Nr32JLSqbJjmjsUpW2443NZO+fTzXcMrnMe9mmQlpHiUW+Wzqiz4/n4Ra+dQEO/rETPnawZScTtAKbmqbd53ygLIZJ3Y8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7145
X-Proofpoint-ORIG-GUID: 5MclkZLjb0Y7sv43OimYtzaqjqrHU6dt
X-Proofpoint-GUID: 5MclkZLjb0Y7sv43OimYtzaqjqrHU6dt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-16_25,2023-11-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 priorityscore=1501 clxscore=1011 bulkscore=0 adultscore=0 spamscore=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 mlxlogscore=999
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312070092
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is dangerous to output warnings in task_call_func,
which may lead to the risk of deadlock. task_call_func
uses p->pi_lock, and the serial port output may call
try_to_wake_up to wake up the write buff, which also
uses p->pi_lock.

 WARNING: possible circular locking dependency detected
 6.7.0-rc4 #28 Not tainted
 ------------------------------------------------------
 sh/475 is trying to acquire lock:
 ffff800082b17f20 ((console_sem).lock){-.-.}-{2:2}, at: down_trylock+0x18/0x48

 but task is already holding lock:
 ffff0000c582dde0 (&p->pi_lock){-.-.}-{2:2}, at: task_call_func+0x40/0x124

 which lock already depends on the new lock.

 the existing dependency chain (in reverse order) is:

 -> #1 (&p->pi_lock){-.-.}-{2:2}:
        _raw_spin_lock_irqsave+0x68/0xd0
        try_to_wake_up+0x5c/0x820
        wake_up_process+0x18/0x24
        __up.isra.0+0x40/0x4c
        up+0x5c/0x78
        console_unlock+0x124/0x138
        vt_move_to_console+0x48/0xb8
        pm_restore_console+0x44/0x5c
        pm_suspend+0x2f0/0x688
        state_store+0x8c/0x118
        kobj_attr_store+0x18/0x2c
        sysfs_kf_write+0x4c/0x78
        kernfs_fop_write_iter+0x120/0x1b4
        vfs_write+0x3b4/0x558
        ksys_write+0x6c/0xfc
        __arm64_sys_write+0x1c/0x28
        invoke_syscall+0x44/0x104
        el0_svc_common.constprop.0+0xc0/0xe0
        do_el0_svc+0x1c/0x28
        el0_svc+0x50/0xec
        el0t_64_sync_handler+0xc0/0xc4
        el0t_64_sync+0x190/0x194

 -> #0 ((console_sem).lock){-.-.}-{2:2}:
        __lock_acquire+0x1248/0x1ab4
        lock_acquire+0x120/0x308
        _raw_spin_lock_irqsave+0x68/0xd0
        down_trylock+0x18/0x48
        __down_trylock_console_sem+0x38/0xc4
        console_trylock+0x34/0x78
        vprintk_emit+0x124/0x3a4
        vprintk_default+0x38/0x44
        vprintk+0xb0/0xc0
        _printk+0x60/0x88
        report_bug+0x208/0x270
        bug_handler+0x24/0x6c
        brk_handler+0x70/0xd4
        do_debug_exception+0x9c/0x16c
        el1_dbg+0x74/0x90
        el1h_64_sync_handler+0xc8/0xe4
        el1h_64_sync+0x64/0x68
        __set_task_frozen+0x64/0xac
        task_call_func+0xa0/0x124
        freeze_task+0xb4/0x10c
        try_to_freeze_tasks+0xd8/0x3fc
        freeze_processes+0xd4/0xe4
        pm_suspend+0x21c/0x688
        state_store+0x8c/0x118
        kobj_attr_store+0x18/0x2c
        sysfs_kf_write+0x4c/0x78
        kernfs_fop_write_iter+0x120/0x1b4
        vfs_write+0x3b4/0x558
        ksys_write+0x6c/0xfc
        __arm64_sys_write+0x1c/0x28
        invoke_syscall+0x44/0x104
        el0_svc_common.constprop.0+0xc0/0xe0
        do_el0_svc+0x1c/0x28
        el0_svc+0x50/0xec
        el0t_64_sync_handler+0xc0/0xc4
        el0t_64_sync+0x190/0x194

 other info that might help us debug this:

  Possible unsafe locking scenario:

        CPU0                    CPU1
        ----                    ----
   lock(&p->pi_lock);
                                lock((console_sem).lock);
                                lock(&p->pi_lock);

  *** DEADLOCK ***

 7 locks held by sh/475:
  #0: ffff0000c7245420 (sb_writers#5){.+.+}-{0:0}, at: ksys_write+0x6c/0xfc
  #1: ffff0000c313a890 (&of->mutex){+.+.}-{3:3}, at: kernfs_fop_write_iter+0xf0/0x1b4
  #2: ffff0000c0d3e0b8 (kn->active#48){.+.+}-{0:0}, at: kernfs_fop_write_iter+0xf8/0x1b4
  #3: ffff800082b11530 (system_transition_mutex){+.+.}-{3:3}, at: pm_suspend+0xb4/0x688
  #4: ffff800082ae6058 (tasklist_lock){.+.+}-{2:2}, at: try_to_freeze_tasks+0x88/0x3fc
  #5: ffff800082b93f10 (freezer_lock){....}-{2:2}, at: freeze_task+0x3c/0x10c
  #6: ffff0000c582dde0 (&p->pi_lock){-.-.}-{2:2}, at: task_call_func+0x40/0x124

Fixes: f5d39b020809 ("freezer,sched: Rewrite core freezer logic")
Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
---
 include/linux/freezer.h |  9 +++++++++
 kernel/freezer.c        | 40 ++++++++++++++++++++++++----------------
 2 files changed, 33 insertions(+), 16 deletions(-)

diff --git a/include/linux/freezer.h b/include/linux/freezer.h
index b303472255be..0f089bf6ff7e 100644
--- a/include/linux/freezer.h
+++ b/include/linux/freezer.h
@@ -16,6 +16,15 @@ DECLARE_STATIC_KEY_FALSE(freezer_active);
 extern bool pm_freezing;		/* PM freezing in effect */
 extern bool pm_nosig_freezing;		/* PM nosig freezing in effect */
 
+/*
+ * Check whether the status and locks are normal
+ * when the task is frozen
+ */
+struct task_freeze_check {
+	unsigned int state;
+	int lockdep_depth;
+};
+
 /*
  * Timeout for stopping processes
  */
diff --git a/kernel/freezer.c b/kernel/freezer.c
index c450fa8b8b5e..263687e0b0a3 100644
--- a/kernel/freezer.c
+++ b/kernel/freezer.c
@@ -108,6 +108,7 @@ static void fake_signal_wake_up(struct task_struct *p)
 static int __set_task_frozen(struct task_struct *p, void *arg)
 {
 	unsigned int state = READ_ONCE(p->__state);
+	struct task_freeze_check *p_check = arg;
 
 	if (p->on_rq)
 		return 0;
@@ -118,30 +119,37 @@ static int __set_task_frozen(struct task_struct *p, void *arg)
 	if (!(state & (TASK_FREEZABLE | __TASK_STOPPED | __TASK_TRACED)))
 		return 0;
 
-	/*
-	 * Only TASK_NORMAL can be augmented with TASK_FREEZABLE, since they
-	 * can suffer spurious wakeups.
-	 */
-	if (state & TASK_FREEZABLE)
-		WARN_ON_ONCE(!(state & TASK_NORMAL));
-
-#ifdef CONFIG_LOCKDEP
-	/*
-	 * It's dangerous to freeze with locks held; there be dragons there.
-	 */
-	if (!(state & __TASK_FREEZABLE_UNSAFE))
-		WARN_ON_ONCE(debug_locks && p->lockdep_depth);
-#endif
-
 	p->saved_state = p->__state;
 	WRITE_ONCE(p->__state, TASK_FROZEN);
+	p_check->state = p->__state;
+	p_check->lockdep_depth = p->lockdep_depth;
 	return TASK_FROZEN;
 }
 
 static bool __freeze_task(struct task_struct *p)
 {
+	struct task_freeze_check p_check;
+	unsigned int ret;
 	/* TASK_FREEZABLE|TASK_STOPPED|TASK_TRACED -> TASK_FROZEN */
-	return task_call_func(p, __set_task_frozen, NULL);
+	ret = task_call_func(p, __set_task_frozen, &p_check);
+	if (ret) {
+		/*
+		 * Only TASK_NORMAL can be augmented with TASK_FREEZABLE, since they
+		 * can suffer spurious wakeups.
+		 */
+		if (p_check.state & TASK_FREEZABLE)
+			WARN_ON_ONCE(!(p_check.state & TASK_NORMAL));
+
+#ifdef CONFIG_LOCKDEP
+		/*
+		 * It's dangerous to freeze with locks held; there be dragons there.
+		 */
+		if (!(p_check.state & __TASK_FREEZABLE_UNSAFE))
+			WARN_ON_ONCE(debug_locks && p_check.lockdep_depth);
+#endif
+	}
+	return ret;
+
 }
 
 /**
-- 
2.25.1

