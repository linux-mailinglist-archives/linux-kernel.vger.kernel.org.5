Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 620B97CD49D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 08:45:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344488AbjJRGpA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 02:45:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjJRGo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 02:44:58 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DDDB93;
        Tue, 17 Oct 2023 23:44:56 -0700 (PDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39I6g2uR029553;
        Wed, 18 Oct 2023 06:44:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=LqE3bsjS3d7fUFgQ8meolb1vfdC6rlb7wmWsYw/PucM=;
 b=nJoA+pVSGDOtYfiFAi5xI5nLhruV6f2x/mBG8rJkstAVEMxNHaJ2+qTUSrD0PYobzCFQ
 uvn0JM+o3e/5KhlepCXpbE8QcgMybcT2SPlpWJYP3O3oqsPuHcYA2azxYH0LTzpf6GMm
 BVFZBjAi4A1fWOYwZxXbWrCi20+CoovmYnDjDWn0nMbWKtFRU5QRC0IKkMQcSFEAWaEz
 +bpglfdRD7Qj8KIUcXd/CkCdTLs3Vr/myInHzvkTCRSHnuzE5mFdLvHB4y/LOhmSK31j
 doBRbDGZrmLLjQ8wg4dgUle1rqRIY4zpUwJMnEkT59iAtRJx8GjYr0WOY4++0q4nfmOL kA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ttaaqg25v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Oct 2023 06:44:53 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39I6ha6u002871;
        Wed, 18 Oct 2023 06:44:53 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ttaaqg259-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Oct 2023 06:44:52 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
        by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39I40Cxc026879;
        Wed, 18 Oct 2023 06:44:51 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tr5asekgd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Oct 2023 06:44:51 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39I6imHV21299956
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Oct 2023 06:44:48 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4F9092004E;
        Wed, 18 Oct 2023 06:44:48 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 204FA2004B;
        Wed, 18 Oct 2023 06:44:48 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 18 Oct 2023 06:44:48 +0000 (GMT)
From:   Thomas Richter <tmricht@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, iii@linux.ibm.com, irogers@google.com
Cc:     svens@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH] perf test: test case 111 fails on s390
Date:   Wed, 18 Oct 2023 08:44:41 +0200
Message-Id: <20231018064441.2751317-1-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: NXPT4q3yb5Umjie7CUINcWIkWlyPu0Zw
X-Proofpoint-ORIG-GUID: U7lLSEIItiDpuRwUU0DqJZ27YGPaANCr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-18_04,2023-10-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 clxscore=1011
 phishscore=0 spamscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 suspectscore=0 mlxscore=0 malwarescore=0 lowpriorityscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310180056
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

Fixes: 14e4b9f4289a ("perf trace: Raw augmented syscalls fix libbpf 1.0+ compatibility")
Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Acked-by: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Ian Rogers <irogers@google.com>
---
 .../util/bpf_skel/augmented_raw_syscalls.bpf.c   | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
index 939ec769bf4a..cc22bccfc178 100644
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
+	bpf_probe_read_kernel(&augmented_args->saddr, socklen, sockaddr_arg);
 
 	return augmented__output(args, augmented_args, len + socklen);
 }
@@ -221,7 +221,7 @@ int sys_enter_sendto(struct syscall_enter_args *args)
 
 	socklen &= sizeof(augmented_args->saddr) - 1;
 
-	bpf_probe_read(&augmented_args->saddr, socklen, sockaddr_arg);
+	bpf_probe_read_kernel(&augmented_args->saddr, socklen, sockaddr_arg);
 
 	return augmented__output(args, augmented_args, len + socklen);
 }
@@ -311,7 +311,7 @@ int sys_enter_perf_event_open(struct syscall_enter_args *args)
         if (augmented_args == NULL)
 		goto failure;
 
-	if (bpf_probe_read(&augmented_args->__data, sizeof(*attr), attr) < 0)
+	if (bpf_probe_read_kernel(&augmented_args->__data, sizeof(*attr), attr) < 0)
 		goto failure;
 
 	attr_read = (const struct perf_event_attr_size *)augmented_args->__data;
@@ -325,7 +325,7 @@ int sys_enter_perf_event_open(struct syscall_enter_args *args)
                 goto failure;
 
 	// Now that we read attr->size and tested it against the size limits, read it completely
-	if (bpf_probe_read(&augmented_args->__data, size, attr) < 0)
+	if (bpf_probe_read_kernel(&augmented_args->__data, size, attr) < 0)
 		goto failure;
 
 	return augmented__output(args, augmented_args, len + size);
@@ -347,7 +347,7 @@ int sys_enter_clock_nanosleep(struct syscall_enter_args *args)
 	if (size > sizeof(augmented_args->__data))
                 goto failure;
 
-	bpf_probe_read(&augmented_args->__data, size, rqtp_arg);
+	bpf_probe_read_kernel(&augmented_args->__data, size, rqtp_arg);
 
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

