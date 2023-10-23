Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EAB77D38A1
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 15:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbjJWN6d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 09:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjJWN6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 09:58:31 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2133.outbound.protection.outlook.com [40.107.255.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B659103
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 06:58:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LSBuMRqHBQOZF9+6w7stBb94+bUql1rRLt394XocQRvkxylKmBuddqJVNyzaiwVPaErI88gjPnRQ7TTQ+QMGcOcsk2eRdBFBa84SVmm39Ano/0OzoYuROXddmiV45DieXEzwrEhQ1b7JuemL9wyB0RqImVIkiyT4XoYva71CAze2ZbVGX5rs5dtr5MWpg8rZzvA0NuSl1PJ055XBtKxSwDaEqpTeY4y2+CD9d30h4o7GPMOb+52F7kyBpG3w9Kvk6H+ypk4Jesbc8jXaZgqfNkREykZOLGKftViB3jg0BmKkdso83se7Rbz4C/FsyA9iPojzK9/vLdSvaIhSDiJgkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aeb9LlGEzMmdUTksPh2V6AKConWBq6KOSoctrIV6K58=;
 b=lh85ECqx+fElPHRamF7DA+8tyiJjIjoec5BobfQ/qBIspWXUcJI2dzBE10OCrUfoVDaJdVzg31NAf26cPKFW4/+rpmN/9kfaChwxPrLxFEKw6iNcCVQXqhiIvPAQQjNo4jLva7gRGyZbE5AF2rsRTutBmlCTiDIHjC3s/QfVqZ61N3PRhtQsk0Jhef0wgdcHSm2uysBEFP9RswyRhAcA8PYO4Qf4CSyT7wmrpxHOFKwteSeqUm8QWF6RlnhQrAb0rSKLfLEfULfv23ITBaCflTWzrwJYyS1nmnwoYjaU+5Czyr54G9bzGOWnN0iR+4l7xLbQ6pLWUuj8+SU80RTLTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aeb9LlGEzMmdUTksPh2V6AKConWBq6KOSoctrIV6K58=;
 b=mQsmJzR9XwhtCNaNJ+Y2rWb87NlYJpGI0BziC55oKa9fdMCtsSze18xXTlVISAxFxstUQL5sOoV839B/e5DbrPw8rx7f+jPhbA06stdcI5U8UbpIw8ETcz8bNCdjLkC65pCO3WAJJFezGkME75+eyyInlJcib/YVbmnK8pFApucPdItG1sxuK7wen5LXgKYND/qi/f16dKAr0XNycWANOgQofV6k1DXC1+aHWNDw7agv5m+srRKxi9btX9PalfNME0ePyGNyiEg/D4m7HDvASuUT5rscmyib0aUY9T5+XTEQQ1JXgkoH0850g8tMx8ZkXl+mA5eqdtZO5wgTPw+Z4w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB4693.apcprd06.prod.outlook.com (2603:1096:4:145::7) by
 PUZPR06MB4576.apcprd06.prod.outlook.com (2603:1096:301:a7::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6907.31; Mon, 23 Oct 2023 13:58:23 +0000
Received: from SI2PR06MB4693.apcprd06.prod.outlook.com
 ([fe80::4c2b:f8ad:f3e1:d4d8]) by SI2PR06MB4693.apcprd06.prod.outlook.com
 ([fe80::4c2b:f8ad:f3e1:d4d8%4]) with mapi id 15.20.6907.030; Mon, 23 Oct 2023
 13:58:23 +0000
From:   Liangliang Li <liliangliang@vivo.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com, Liangliang Li <liliangliang@vivo.com>
Subject: [PATCH] freezer,sched: Report TASK_FROZEN tasks as TASK_UNINTERRUPTIBLE
Date:   Mon, 23 Oct 2023 21:57:35 +0800
Message-Id: <20231023135736.17891-1-liliangliang@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0187.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::12) To SI2PR06MB4693.apcprd06.prod.outlook.com
 (2603:1096:4:145::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB4693:EE_|PUZPR06MB4576:EE_
X-MS-Office365-Filtering-Correlation-Id: 93b1dc04-ab19-4072-0433-08dbd3d01ea8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8hLcRmlMH/svU1F45IPeCw7aEMmXXegW1FGXqHI2We4KQFNkU8gR67QKNka8a3qe+Hko+R5znrN+URr+58/qPVIQKHkElcZbCjghfTHi8RDCqxn+rFQhxBq9IHneR2GlIs88vOPAK77ClWgx5LAMdpKeyo+QhRTAHzt9ttWJMfnoVHEf/EjBJYZMthnOfnSxjshumgqfxQ4IFmKhW3Jx0BTcdjsepyvJ8OCEJsIBWfjU8NP9J/cfbaZtuX1nr1qnjP9R/o3MLrzhQNkTp6k+n+6pMuvl6QGTgbx/N9ca+EApPsCFrtScSIbDF+xYv+mSjLdU3PLzcy0RSfM779Y0c/4JCRdsvcecRhsU7AuTbL/U8BNpVvxeInGN2j5yOf/qihlMpB/e7tF3kst0Fv5nwo/8r1EKtUSbg5Py/2iWSdDS+s0tkX+cyi5PohmjAQ3IjMwmVWjSbCmG2wZLXbNklfOA9JnyvH/HueP1EEqXZHNq25DzeOnW6OjocgTykd3vOAU9RGaWDjbfXE+W5BlRxh/upUXl8k93HbJt6Hq17hFIVIWacgsQpldCeasnUF/V+qi/hl/F4OMC/v8fIvQd4nG5fJ6fSeQoxXixHQEdHfjejyXUoMUy+3Uwcnxnr4GPu9WmjUP4swICrNxoJVWsQw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB4693.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(376002)(346002)(136003)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(4744005)(2906002)(38100700002)(66476007)(110136005)(316002)(66556008)(2616005)(66946007)(6506007)(1076003)(107886003)(6666004)(478600001)(52116002)(6486002)(6512007)(83380400001)(7416002)(36756003)(86362001)(4326008)(5660300002)(8936002)(8676002)(38350700005)(41300700001)(921008)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Otje0WF0hmsUF4H19OTiwpPMYqHRkxoRWMZpbjOZOaFUPUQmvYs/xVfb7a+v?=
 =?us-ascii?Q?0nX5Jjbk/Yp87+nwH7Z23rsjPdsAeRO1g5s7VBXJjjQnCuBof3YsCyabyq8y?=
 =?us-ascii?Q?VrJBEeoFwJZ82pkEuVtLDpNrVovgXv3yMCH4RmIlrQAoEbC3VxIMcHUhqwak?=
 =?us-ascii?Q?fE3g7OtmwNW7uCX9bAHCAdP8NHiCpI9ESaOofok7XjuJWxSGGFVggxmf4MzM?=
 =?us-ascii?Q?wtaw8vbuMoKbXOiuzG0HZTePCQKuWNkZT7OphRx/xhe9Gn6rUuYyHo5YfKtd?=
 =?us-ascii?Q?XdIZ7R3i3rF69Hf3Gq07hjKcODmUzfaW3U/ePEpuY/HSc4fGIr8GiSHcKg6O?=
 =?us-ascii?Q?2OtaKjCZ16ZKpJqENAJUHk8JV0OTwSVnX18HY63Xb+/PLJ8pDTp+eYH+lkq+?=
 =?us-ascii?Q?wQcGRq+vJoYwKWP7dcm1TzL5X6E43zpPnUv68veHo659Il+NKlJ3IOQLv5qN?=
 =?us-ascii?Q?xfrX61YDzhxUIKVSH4I3HaUGG1sn9MSnLoWNLsBKVD2u38yW+VDDETLfBe+h?=
 =?us-ascii?Q?ePn0X9AgiQq8eytC3zptD4TG/Foqqq+w8UMZYODMy/qnhGaZNxKmzSQY4nZP?=
 =?us-ascii?Q?8B1iAF5Y53pKzvxI3wb7j5eFXVE/h9dGsaQ/VBDBKKhfx84nqZp0Asihlgjq?=
 =?us-ascii?Q?VBmlmsv4RZsssPc86DcOaV41sLnvXqTQol6iQQu1zGRTKoj4jfEq6RIJoPy1?=
 =?us-ascii?Q?AQshKXajLuyImQ1NkNSg+lAG/655rbym3wj0BzsPBcrAPMkfUXTHPGhSP/e8?=
 =?us-ascii?Q?/7uZ42GIF2stSs7EljU1KxJNU8LSKw0E5RKcwXjMWWXiAdQtoN/rMiWgqtU8?=
 =?us-ascii?Q?w8mmZOpn/vjKZOBLzzkqdY9WTZ177vykrFfr/TS2+la4kxI2kEhQ0uo4KNhF?=
 =?us-ascii?Q?6o5jzZsm3VriWCvEBown+kDaSkLna6YK+79PgyR4+/ui3Q1uzNZbK3ya3ulN?=
 =?us-ascii?Q?E+AztztUYIKH0e4HSYxTqhaDCDip6MMcQ5FM8Yr0nRc+Yh+9Rl7ezSXduKUq?=
 =?us-ascii?Q?Zh80TdbQhPs3CHsWK+ZIQ2ou0qLsXSFBEo5UiwzD8JNxP+caPaP+0Oe0Nc1x?=
 =?us-ascii?Q?DlsIC8YDzKcx4zRc++FnzVWrJH/iNag+oqejPpXO1xydhoNoN+7c3rbU4kSZ?=
 =?us-ascii?Q?+xzyyqMWeRRi+oJhpj6/zgTRpSxM1Lv49ZPot7yFoD3gnC/j/SeucETmMUET?=
 =?us-ascii?Q?mMcGWquDDNn1f7vra0ZksWeANUQuPCanFjAgW+sxOXUka4E5n6H4mb4W62tc?=
 =?us-ascii?Q?12npXysZclWGXIQllTlf9MJE+wat6A8BiG0+SMzn+fW7ehY+nC25CdECtyA7?=
 =?us-ascii?Q?ZU/h0rIT+z3GofqvWj4l2uKRThWaWyGkixx+hHNMsGXuihSVqQH+gdtEdM6F?=
 =?us-ascii?Q?s1hXsYrjvoWTgSLIniO0j6NjPokHItq4Y1ECAjKvSJEHAfACqqrwY7VHSJ2A?=
 =?us-ascii?Q?8smVE37wIvLHPFYu8fvQ9Lv78P1fNGP2cMCPyTcXXt66sZOYp2zTrU8vj21d?=
 =?us-ascii?Q?WTcknhwIk6GD3sjAVEbvin2U+J0MwCy9HT1eu+3NMCLDFcy6I/+347FbuJ2N?=
 =?us-ascii?Q?34puP6LPkhVN7+Xew2kKLI86zJzUhA7gg/5tbIux?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93b1dc04-ab19-4072-0433-08dbd3d01ea8
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB4693.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2023 13:58:22.7577
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AMuz8SlZS5PtPIDbE136NUryJbTomnXyEvvJ6tvA3Gxh6jqGndV9buVLyVY7WjjVaMqakyPHJfqfcdGfmlFqlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB4576
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TASK_FROZEN is not in TASK_REPORT, thus a frozen task will appear as
state == 0, IOW TASK_RUNNING.

Fix this by make TASK_FROZEN appear as TASK_UNINTERRUPTIBLE, thus we
dont need to imply a new state to userspace tools.

Signed-off-by: Liangliang Li <liliangliang@vivo.com>
---
 include/linux/sched.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 292c31697248..0cfe2ba4fc6f 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1690,6 +1690,10 @@ static inline unsigned int __task_state_index(unsigned int tsk_state,
 	if (tsk_state & TASK_RTLOCK_WAIT)
 		state = TASK_UNINTERRUPTIBLE;
 
+	/* Frozen tasks should appear as "D (disk sleep)' in userspace. */
+	if (tsk_state & TASK_FROZEN)
+		state = TASK_UNINTERRUPTIBLE;
+
 	return fls(state);
 }
 
-- 
2.34.1

