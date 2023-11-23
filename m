Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 037377F57CB
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 06:33:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344641AbjKWFdJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 00:33:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbjKWFdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 00:33:06 -0500
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2050.outbound.protection.outlook.com [40.107.104.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E61CBCB
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 21:33:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SxRtTXx/jUpYhZMEukKnrwTzA5T9lC0hTSQZgoN4y4B4kn6hax9y2zXl3eGqe/P0GRIXq58aM3YmM7EaBM58oCTm9lheHdR+PjCBwSt15CkjqheOI8fuT9y/ENrpoy/prB46gTYHIFQxaL1WFFh0F2T0rdi0FZdaovs4xF+CIIkKY3xbS7+5LM7Er7NdvUXa4Yh7HVpITJghC76w+RY+tvoXjjI6elU3LV+cm09wlfdE1ptXtvRp5nGv2Aotn1TjSVpZPCD1sCyi1qqcb1qr0YpwBWRKedcp7wAhIGPWj97q1//hr4gdUS5TmYbO34vdSWp4GSoIhimVzUpeMqRVKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tnUqWnDUVXVsXeii7TUQukjBA996iR+/ZIzjxv4tphI=;
 b=X9n4Nl113s8krTH7SF6tMVKslsAtd4WtBoThwMWQB+RG1HtlE1PNmgHSNZTwvIBmmM7PEVamWwgTyiETLw6Zcy0Oj6zMdWJyLrzWku2VUxzhIXXCfFuiWPnWqrvzWsiuPiAO85YX4qDEJOxsJZalrKcoTB3PZcPSP3akUvwZZaeppHVQOIMUJFN6WWSjNPaEnvVQbWw1Crthn/N+lkO5RpU/cx2SzkKNmGLxzGmc0OqaCp1PepXoPSutTueBCPXZolyZfGTF+BDAYQeHW+3Ms3Ius91xo4Pid0Dc5xMYG14slpeoybWmmffn/uqMGCuToLxnQczXfHNZokUk3b/HVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tnUqWnDUVXVsXeii7TUQukjBA996iR+/ZIzjxv4tphI=;
 b=nvrFtNWQOHQYxc2EQ0RpU1sOnQVtTsn6QeSI+3/nwsI4OtnOsabtJZMt09dRrnTF6pmkygaA+/Ki8xyZq7nSeIpQ2pFp62bzMpiQJmjS76ffOmjXZuGYj6vdqj6EhZUyDRlT8Zf4Q9WymLU42prW7vlo9z2Jr77QZCMFhreOSWPIsafTPKIWtaLUH5HoTCUl9J2eaNbxHUoTxbHxuis2DKJ1XPCJrhrtCQWc5yFAKvt3oqOUwlQJYfrDnrUgiU07kLfHDVrlMTgmxHhODc9CNPTlLaaC+AO/57eb+tz2OpCm7KwfL6WN/MDoQZIVX7ccCd8Gmr57AfIqCiIEMuaaJw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8199.eurprd04.prod.outlook.com (2603:10a6:20b:3f6::21)
 by PAXPR04MB8077.eurprd04.prod.outlook.com (2603:10a6:102:1c3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.19; Thu, 23 Nov
 2023 05:33:09 +0000
Received: from AS8PR04MB8199.eurprd04.prod.outlook.com
 ([fe80::9d39:5718:5401:764d]) by AS8PR04MB8199.eurprd04.prod.outlook.com
 ([fe80::9d39:5718:5401:764d%5]) with mapi id 15.20.7046.012; Thu, 23 Nov 2023
 05:33:09 +0000
From:   Wei Gao <wegao@suse.com>
To:     tglx@linutronix.de, mingo@redhat.com, peterz@infradead.org,
        dvhart@infradead.org, dave@stgolabs.net, andrealmeid@igalia.com,
        linux-kernel@vger.kernel.org
Cc:     wei gao <wegao@suse.com>
Subject: [PATCH v1] futex: Add compat_sys_futex_waitv for 32bit compatibility
Date:   Thu, 23 Nov 2023 00:31:40 -0500
Message-Id: <20231123053140.16062-1-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0077.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::10) To AS8PR04MB8199.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8199:EE_|PAXPR04MB8077:EE_
X-MS-Office365-Filtering-Correlation-Id: 8945261b-5760-4505-9b0d-08dbebe5ad33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5sg+z6ZU5VAzxGeQQdcQjicK1Msq2/X1vHhXC91f60MN67WWLC0+tI1cy2jswtbWrtCJ3EFIhAGB++uf7NmDcHzurOqyeSprmuFlkmzh9RICGoFUFdIdj27rVhVFu7BKXNsVD38kuKrMXOCg8gnbIplUxzBEC3SUpnbKVMAhdyLGF0Vh27tgXNVxl4IEqLfGCWkrK5S2pCiYPOsfh4YztWH/z9TjPHRTfEj8KUfK5Noj6ByFxue8epuM1RAz++E6MZnK+XQpRBT91oSjOwJY2RKTjTbw8/oBaidvFi+202QsVsdaTZeD3Z4RhOr0naCiawN/XalOq4fWj5+bvHNeaN1cFH0Q3A4/3Llz1SpnS53CwmRFZlEY1btj19AYwVNiqh37PHrof/JJrZ2Br85YuHX0Hys5+PJnE19yhFXRtNDIRyGRFHarKjGFiPb/2xSoZq8FstY66PIxhptxYCZoe/XLmsTc4oQRsBr8ory4IQca8vgMx92qksqaXNBQh0H16OEOh2mz6fWwQAWRAQTmG0DqvQnAn81VvioVJpmqwxDJj+AeZ1GVSi0+IYtQgUoh
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8199.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(396003)(366004)(136003)(39860400002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(26005)(6486002)(1076003)(107886003)(6506007)(6666004)(83380400001)(6512007)(2616005)(5660300002)(4326008)(8936002)(8676002)(41300700001)(2906002)(478600001)(316002)(66476007)(66946007)(66556008)(86362001)(36756003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rnJw85Him5sNtjD6xWrFCvByWl+kAN6w86svFMLqAEMvSKPZ3fVdmfG0n0Or?=
 =?us-ascii?Q?ZtPZ8w1LWg+OfBr1CD0PKfr8rtd1TR9AGw4evlaNkxMqA8mFk58RXI9grn1a?=
 =?us-ascii?Q?E9PhtRGZsllE+1mXQunrfdgHAn5zUsSEE6HVB9dVoDfxwimuvsRLUH/crnEJ?=
 =?us-ascii?Q?tlVnN5qJV0N5Z8RG/r0hwzDTUD3YUrf3SaDUBwAaKMnHdhXt1YC/5GyaLAwB?=
 =?us-ascii?Q?oQjIiCKbRs7RdyYkNYo0utEMz4zjqW4mz1aq+/+G1SPNAb3Ds2i+sD5jWQEQ?=
 =?us-ascii?Q?B/r2Ms8fQVxEbXJqzKlOJ5NIIwcXGVbWbApfV/NFhN5rC+wN0OkICr5k3aq6?=
 =?us-ascii?Q?Aj7p6GynyesZl0b8L6FQiQYBzCrA/3PmPbppIjHeQjEvmK+pk3kBB4cX7yv6?=
 =?us-ascii?Q?sHWqS419ojw6iNIj2fdsjxA6uLaGjd7fgv+pa1Id0kN5U7ujNToxs2+act2v?=
 =?us-ascii?Q?F9PjGGTLbDh0vnoMRpy442sT38E7w2tQlXHrrxSY4BW/rzhlIBTYRLWwrEKF?=
 =?us-ascii?Q?u3wpg3Cj0ipq2wuzvPQGq+dlItaE215RiRJZcYRNeUW6udAXULVV69d8UCHu?=
 =?us-ascii?Q?HE5SdhqY3Dhe/IXYzG1R/UcwVHdP8NWOKecXXjluQo18oFtx3k3XamQTykVL?=
 =?us-ascii?Q?MMaQGG85JwunsU+KROwBFnY/B4Zupx56bwxzCo5095eIr6mSV3ghMVYKQ5hB?=
 =?us-ascii?Q?09DgncuttJYrf/74FpcylPQFki18PHZndlMoQT06QRA+1KxVYH2tp8hkTP5c?=
 =?us-ascii?Q?oPn63dFfAyhWToevNb/faHCpmPbagmu5PBS23MqamCmggLshkOadMnfqr/9t?=
 =?us-ascii?Q?B4K783GrRHJ+d0oSIpH3r4c5oU6SXMcnTOBrnhi+Y3SC8yTeM/VVFmSYedeG?=
 =?us-ascii?Q?0CJDAZIJlhtIcy/Ih2kS+8+MJ8nYB6UZ5KhFPGTX4prYXbdl+47sWpQyM00b?=
 =?us-ascii?Q?s7ate7UiUtQBbpFRWzJR9dKRydR3UtW76PkdJKTCFQxlsqiFsACcSGK78F+D?=
 =?us-ascii?Q?5m+4jfw0yuEB6y9X9XuA26i5i3k5/CyqpSKM+SZvZnnAR3m6DeqKUocSX4n3?=
 =?us-ascii?Q?UXC4N3sGVetIWqWdqH8+cy89d/pzqLMXrmEF31FEzmJZiNPFTIRI/8Q9c7ly?=
 =?us-ascii?Q?r3Yl98rdlOV45XuXlY2ywJnDg12xTk2Uht3xTespu3hg2lGi1EN5eV8qSJx9?=
 =?us-ascii?Q?BSkpBnHKM/OIfa1Wxx+NhciFRexhcE1lgpN0D12uoxoNqUNoFe+FE8mpiicC?=
 =?us-ascii?Q?SjknCZ/29elUySh04SrAsjifBAilA3ICV4Z4T4FsRtAFo/QE6zqkMi0KFZMr?=
 =?us-ascii?Q?ehEy+UTY0WlutF96G6txHZukiL9BkRmGfOenMl/gw+wLmSUu9Pvh8eUOTxGY?=
 =?us-ascii?Q?PQg7Isw6MXXiuhRqWy6wW3mDV+phpYYVmw9Gki/NCowaKSV/10wz6CiQFlI9?=
 =?us-ascii?Q?tIumJRwe6GIorI9PhuMGTduo9UpzJDc33GfExrJwV4IAPV9Sj6XknoIC8QNb?=
 =?us-ascii?Q?m2MgREnQ3M4ZZ6WFMv3dWVZw3EshfVsDNy6ASrUmfz/DiRnhFu9P/7jnD0E9?=
 =?us-ascii?Q?XIGquATZX657jos+2sk=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8945261b-5760-4505-9b0d-08dbebe5ad33
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8199.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2023 05:33:09.2435
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +vbtNgDYBKsFjEz+lnr9t1EL5oM4eFYeMGUsIS7mS7ETpWMmGpKu2iQHCBb2TAj+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8077
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: wei gao <wegao@suse.com>

Current implementation lead LTP test case futex_waitv failed when compiled with
-m32. This patch add new compat_sys_futex_waitv to handle m32 mode syscall.

The failure reason is futex_waitv in m32 mode will deliver kernel with struct
old_timespec32 timeout, but this struct type can not directly used by current
sys_futex_waitv implementation.

The new function copy main logic of current sys_futex_waitv, just update parameter
type from "struct __kernel_timespec __user *" to "struct old_timespec32 __user *,"
and use get_old_timespec32 within the new function to get timeout value.

Signed-off-by: wei gao <wegao@suse.com>
---
 arch/x86/entry/syscalls/syscall_32.tbl |  2 +-
 kernel/futex/syscalls.c                | 61 ++++++++++++++++++++++++++
 2 files changed, 62 insertions(+), 1 deletion(-)

diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index c8fac5205803..11bd927dd417 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -453,7 +453,7 @@
 446	i386	landlock_restrict_self	sys_landlock_restrict_self
 447	i386	memfd_secret		sys_memfd_secret
 448	i386	process_mrelease	sys_process_mrelease
-449	i386	futex_waitv		sys_futex_waitv
+449	i386	futex_waitv		sys_futex_waitv  compat_sys_futex_waitv
 450	i386	set_mempolicy_home_node		sys_set_mempolicy_home_node
 451	i386	cachestat		sys_cachestat
 452	i386	fchmodat2		sys_fchmodat2
diff --git a/kernel/futex/syscalls.c b/kernel/futex/syscalls.c
index 4b6da9116aa6..62d69f8ec34c 100644
--- a/kernel/futex/syscalls.c
+++ b/kernel/futex/syscalls.c
@@ -486,6 +486,67 @@ COMPAT_SYSCALL_DEFINE3(get_robust_list, int, pid,
 
 	return ret;
 }
+
+COMPAT_SYSCALL_DEFINE5(futex_waitv, struct futex_waitv __user *, waiters,
+		unsigned int, nr_futexes, unsigned int, flags,
+		struct old_timespec32 __user *, timeout, clockid_t, clockid)
+{
+	struct hrtimer_sleeper to;
+	struct futex_vector *futexv;
+	struct timespec64 ts;
+	ktime_t time;
+	int ret;
+
+	/* This syscall supports no flags for now */
+	if (flags)
+		return -EINVAL;
+
+	if (!nr_futexes || nr_futexes > FUTEX_WAITV_MAX || !waiters)
+		return -EINVAL;
+
+	if (timeout) {
+		int flag_clkid = 0, flag_init = 0;
+
+		if (clockid == CLOCK_REALTIME) {
+			flag_clkid = FLAGS_CLOCKRT;
+			flag_init = FUTEX_CLOCK_REALTIME;
+		}
+
+		if (clockid != CLOCK_REALTIME && clockid != CLOCK_MONOTONIC)
+			return -EINVAL;
+
+		if (get_old_timespec32(&ts, timeout))
+			return -EFAULT;
+
+		/*
+		 * Since there's no opcode for futex_waitv, use
+		 * FUTEX_WAIT_BITSET that uses absolute timeout as well
+		 */
+		ret = futex_init_timeout(FUTEX_WAIT_BITSET, flag_init, &ts, &time);
+		if (ret)
+			return ret;
+
+		futex_setup_timer(&time, &to, flag_clkid, 0);
+	}
+
+	futexv = kcalloc(nr_futexes, sizeof(*futexv), GFP_KERNEL);
+	if (!futexv) {
+		ret = -ENOMEM;
+		goto destroy_timer;
+	}
+
+	ret = futex_parse_waitv(futexv, waiters, nr_futexes, futex_wake_mark,
+				NULL);
+	if (!ret)
+		ret = futex_wait_multiple(futexv, nr_futexes, timeout ? &to : NULL);
+
+	kfree(futexv);
+
+destroy_timer:
+	if (timeout)
+		futex2_destroy_timeout(&to);
+	return ret;
+}
 #endif /* CONFIG_COMPAT */
 
 #ifdef CONFIG_COMPAT_32BIT_TIME
-- 
2.34.1

