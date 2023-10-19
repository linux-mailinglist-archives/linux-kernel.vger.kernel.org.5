Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 075437CF288
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 10:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235244AbjJSI1k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 04:27:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344957AbjJSI13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 04:27:29 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB15113A;
        Thu, 19 Oct 2023 01:27:26 -0700 (PDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39J8KWeb028111;
        Thu, 19 Oct 2023 08:27:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=ZOmmcefAxJ5+oq4SFK1clWhsG9/Bc4sHzoFO4aplk/8=;
 b=gU/JODCp+UsT0kwaN3AsqKsdsSVv+gCResD00t48TxrE/fj6Q7U5Mv1H6dJncdtyvMgj
 ZYNNTmVaCDiGQAQpBbTnodAEZgWZ41nO7PkILvEoS88Il04EAzpBNH8++YAw2E3o5p6D
 zER641xLlJY4mnI96b7QmOcw2soZ+j2GjRCXiv54nOoXcTiiOEMvWxGZSd4QfsYmP7HM
 34kdYp3lEBFXtcPKv/N9UfzWtLaFpB0b/LgnItkERWsK16Y133ukhWHERuMV6ibor5Ef
 aS2m9LlProSqSBlDH1ITeonZ8yg7moChObLTCpV7x+XKDy1p3ba/1FrACwXwsuhWVUbR CA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tu0uu0bxt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Oct 2023 08:27:22 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39J8KoAn028446;
        Thu, 19 Oct 2023 08:27:09 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tu0uu0bb9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Oct 2023 08:27:08 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39J7bwjA012850;
        Thu, 19 Oct 2023 08:26:56 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tr5pyqqv1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Oct 2023 08:26:55 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39J8QqUI16581252
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Oct 2023 08:26:52 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 91E9120043;
        Thu, 19 Oct 2023 08:26:52 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 68F742005A;
        Thu, 19 Oct 2023 08:26:52 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 19 Oct 2023 08:26:52 +0000 (GMT)
From:   Thomas Richter <tmricht@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, iii@linux.ibm.com, irogers@google.com
Cc:     svens@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, Thomas Richter <tmricht@linux.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH] perf trace: Use the right bpf_probe_read(_str) variant for reading user data
Date:   Thu, 19 Oct 2023 10:26:42 +0200
Message-Id: <20231019082642.3286650-1-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: PU7g41jItrM3CggElCzaGTVuuakomo93
X-Proofpoint-ORIG-GUID: xMS0ot7ZZ2FptzebZIEnjAih9PlqCOsE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-19_05,2023-10-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 mlxlogscore=999 impostorscore=0 spamscore=0 malwarescore=0
 bulkscore=0 clxscore=1015 suspectscore=0 phishscore=0 lowpriorityscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310190069
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Perf test case 111 Check open filename arg using perf trace + vfs_getname
fails on s390. This is caused by a failing function
bpf_probe_read() in file util/bpf_skel/augmented_raw_syscalls.bpf.c.

The root cause is the lookup by address. Function bpf_probe_read()
is used. This function works only for architectures
with ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE.

On s390 is not possible to determine from the address to which
address space the address belongs to (user or kernel space).

Replace bpf_probe_read() by bpf_probe_read_kernel()
and bpf_probe_read_str() by bpf_probe_read_user_str() to
explicity specify the address space the address refers to.

Output before:
 # ./perf trace -eopen,openat -- touch /tmp/111
 libbpf: prog 'sys_enter': BPF program load failed: Invalid argument
 libbpf: prog 'sys_enter': -- BEGIN PROG LOAD LOG --
 reg type unsupported for arg#0 function sys_enter#75
 0: R1=ctx(off=0,imm=0) R10=fp0
 ; int sys_enter(struct syscall_enter_args *args)
 0: (bf) r6 = r1           ; R1=ctx(off=0,imm=0) R6_w=ctx(off=0,imm=0)
 ; return bpf_get_current_pid_tgid();
 1: (85) call bpf_get_current_pid_tgid#14      ; R0_w=scalar()
 2: (63) *(u32 *)(r10 -8) = r0 ; R0_w=scalar() R10=fp0 fp-8=????mmmm
 3: (bf) r2 = r10              ; R2_w=fp0 R10=fp0
 ;
 .....
 lines deleted here
 .....
 23: (bf) r3 = r6              ; R3_w=ctx(off=0,imm=0) R6=ctx(off=0,imm=0)
 24: (85) call bpf_probe_read#4
 unknown func bpf_probe_read#4
 processed 23 insns (limit 1000000) max_states_per_insn 0 \
	 total_states 2 peak_states 2 mark_read 2
 -- END PROG LOAD LOG --
 libbpf: prog 'sys_enter': failed to load: -22
 libbpf: failed to load object 'augmented_raw_syscalls_bpf'
 libbpf: failed to load BPF skeleton 'augmented_raw_syscalls_bpf': -22
 ....

Output after:
 # ./perf test -Fv 111
 111: Check open filename arg using perf trace + vfs_getname          :
 --- start ---
     1.085 ( 0.011 ms): touch/320753 openat(dfd: CWD, filename: \
	"/tmp/temporary_file.SWH85", \
	flags: CREAT|NOCTTY|NONBLOCK|WRONLY, mode: IRUGO|IWUGO) = 3
 ---- end ----
 Check open filename arg using perf trace + vfs_getname: Ok
 #

Test with the sleep command shows:
Output before:
 # ./perf trace -e *sleep sleep 1.234567890
     0.000 (1234.681 ms): sleep/63114 clock_nanosleep(rqtp: \
         { .tv_sec: 0, .tv_nsec: 0 }, rmtp: 0x3ffe0979720) = 0
 #

Output after:
 # ./perf trace -e *sleep sleep 1.234567890
     0.000 (1234.686 ms): sleep/64277 clock_nanosleep(rqtp: \
         { .tv_sec: 1, .tv_nsec: 234567890 }, rmtp: 0x3fff3df9ea0) = 0
 #

Fixes: 14e4b9f4289a ("perf trace: Raw augmented syscalls fix libbpf 1.0+ compatibility")
Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Co-developed-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Acked-by: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Ian Rogers <irogers@google.com>
---
 .../util/bpf_skel/augmented_raw_syscalls.bpf.c   | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
index 939ec769bf4a..52c270330ae0 100644
--- a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
+++ b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
@@ -153,7 +153,7 @@ static inline
 unsigned int augmented_arg__read_str(struct augmented_arg *augmented_arg, const void *arg, unsigned int arg_len)
 {
 	unsigned int augmented_len = sizeof(*augmented_arg);
-	int string_len = bpf_probe_read_str(&augmented_arg->value, arg_len, arg);
+	int string_len = bpf_probe_read_user_str(&augmented_arg->value, arg_len, arg);
 
 	augmented_arg->size = augmented_arg->err = 0;
 	/*
@@ -203,7 +203,7 @@ int sys_enter_connect(struct syscall_enter_args *args)
 	_Static_assert(is_power_of_2(sizeof(augmented_args->saddr)), "sizeof(augmented_args->saddr) needs to be a power of two");
 	socklen &= sizeof(augmented_args->saddr) - 1;
 
-	bpf_probe_read(&augmented_args->saddr, socklen, sockaddr_arg);
+	bpf_probe_read_user(&augmented_args->saddr, socklen, sockaddr_arg);
 
 	return augmented__output(args, augmented_args, len + socklen);
 }
@@ -221,7 +221,7 @@ int sys_enter_sendto(struct syscall_enter_args *args)
 
 	socklen &= sizeof(augmented_args->saddr) - 1;
 
-	bpf_probe_read(&augmented_args->saddr, socklen, sockaddr_arg);
+	bpf_probe_read_user(&augmented_args->saddr, socklen, sockaddr_arg);
 
 	return augmented__output(args, augmented_args, len + socklen);
 }
@@ -311,7 +311,7 @@ int sys_enter_perf_event_open(struct syscall_enter_args *args)
         if (augmented_args == NULL)
 		goto failure;
 
-	if (bpf_probe_read(&augmented_args->__data, sizeof(*attr), attr) < 0)
+	if (bpf_probe_read_user(&augmented_args->__data, sizeof(*attr), attr) < 0)
 		goto failure;
 
 	attr_read = (const struct perf_event_attr_size *)augmented_args->__data;
@@ -325,7 +325,7 @@ int sys_enter_perf_event_open(struct syscall_enter_args *args)
                 goto failure;
 
 	// Now that we read attr->size and tested it against the size limits, read it completely
-	if (bpf_probe_read(&augmented_args->__data, size, attr) < 0)
+	if (bpf_probe_read_user(&augmented_args->__data, size, attr) < 0)
 		goto failure;
 
 	return augmented__output(args, augmented_args, len + size);
@@ -347,7 +347,7 @@ int sys_enter_clock_nanosleep(struct syscall_enter_args *args)
 	if (size > sizeof(augmented_args->__data))
                 goto failure;
 
-	bpf_probe_read(&augmented_args->__data, size, rqtp_arg);
+	bpf_probe_read_user(&augmented_args->__data, size, rqtp_arg);
 
 	return augmented__output(args, augmented_args, len + size);
 failure:
@@ -385,7 +385,7 @@ int sys_enter(struct syscall_enter_args *args)
 	if (augmented_args == NULL)
 		return 1;
 
-	bpf_probe_read(&augmented_args->args, sizeof(augmented_args->args), args);
+	bpf_probe_read_kernel(&augmented_args->args, sizeof(augmented_args->args), args);
 
 	/*
 	 * Jump to syscall specific augmenter, even if the default one,
@@ -406,7 +406,7 @@ int sys_exit(struct syscall_exit_args *args)
 	if (pid_filter__has(&pids_filtered, getpid()))
 		return 0;
 
-	bpf_probe_read(&exit_args, sizeof(exit_args), args);
+	bpf_probe_read_kernel(&exit_args, sizeof(exit_args), args);
 	/*
 	 * Jump to syscall specific return augmenter, even if the default one,
 	 * "!raw_syscalls:unaugmented" that will just return 1 to return the
-- 
2.41.0

