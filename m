Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD024789C1E
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 10:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbjH0I0v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 04:26:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbjH0I0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 04:26:39 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56815114
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 01:26:36 -0700 (PDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37R7vtST007816;
        Sun, 27 Aug 2023 08:26:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date : to :
 from : subject : cc : content-type : content-transfer-encoding :
 mime-version; s=pp1; bh=/FesXZVNgy710RsQi60vBX2WHbCvzb4grzE77H1NoUU=;
 b=T+C3XYK9nakYnzCs5CFm/n3CYHSeSnd9nF0pyIoK9XGffRb62cufe5McG1Yv75MaeF2L
 RBZdtwEXuLAVonU07O/21+SaOb/QAvJAZGmr3PmwtcChV2jfgdcIdA1NBxNBqrsFR5L2
 ihCWwVOgmr1w7TyfYSs7hOI7I+T2x03c5If6ql4gpQhcfXdsvHdXvf6W7BP2WzB4JnDo
 4JR5f7QITP2YuYrAs3MPpIvZmHtIORQqFpKjj5qvcv/KYRW8FWzSM1/AP+8sOrbD57bC
 dQdwdK4uwT0/Rg/UMKVA3eWKS1weqXe9KSz3xAcWn2ooh3oC2kNOdgB/HReDMDJ+CMOj Eg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sr2j7g9md-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 27 Aug 2023 08:26:23 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37R8MpS0010822;
        Sun, 27 Aug 2023 08:26:23 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sr2j7g9m7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 27 Aug 2023 08:26:23 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37R7oJVN009907;
        Sun, 27 Aug 2023 08:26:22 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
        by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3sqw7jsydh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 27 Aug 2023 08:26:22 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
        by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37R8QLWk20382064
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 27 Aug 2023 08:26:22 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D4EA85805A;
        Sun, 27 Aug 2023 08:26:21 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B25C858051;
        Sun, 27 Aug 2023 08:26:16 +0000 (GMT)
Received: from [9.43.105.110] (unknown [9.43.105.110])
        by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Sun, 27 Aug 2023 08:26:16 +0000 (GMT)
Message-ID: <67f349e2-33f1-30a3-f92c-3c0a68d6d22f@linux.vnet.ibm.com>
Date:   Sun, 27 Aug 2023 13:56:14 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To:     linux-kernel@vger.kernel.org
From:   Tasmiya Nalatwad <tasmiya@linux.vnet.ibm.com>
Subject: [linux-next][mainline/master] [IPR] [Function could be =
 "__mutex_lock_slowpath(lock)"]OOPs kernel crash while performing IPR test
Cc:     peterz@infradead.org, abdhalee@linux.vnet.ibm.com,
        mingo@redhat.com, will@kernel.org, longman@redhat.com,
        boqun.feng@gmail.com, sachinp@linux.vnet.com,
        mputtash@linux.vnet.com
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: PhJ9VuVnbUijDdCF7NlSz5ZYE-F9EVCZ
X-Proofpoint-GUID: ZN9HN2C9UY77971yeHwXxQvO2i5bsv6U
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-27_06,2023-08-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 mlxscore=0 spamscore=0 priorityscore=1501 clxscore=1011
 bulkscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0
 mlxlogscore=834 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308270074
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

[linux-next][mainline/master] [IPR] [Function could be = 
"__mutex_lock_slowpath(lock)"]OOPs kernel crash while performing IPR test

--- Traces ---

--- Traces ---
[65818.211823] Kernel attempted to read user page (380) - exploit 
attempt? (uid: 0)
[65818.211836] BUG: Kernel NULL pointer dereference on read at 0x00000380
[65818.211840] Faulting instruction address: 0xc000000000f5f2e4
[65818.211844] Oops: Kernel access of bad area, sig: 11 [#1]
[65818.211846] LE PAGE_SIZE=64K MMU=Radix SMP NR_CPUS=8192 NUMA pSeries
[65818.211850] Modules linked in: rpadlpar_io rpaphp nfnetlink xsk_diag 
bonding tls rfkill sunrpc ses enclosure scsi_transport_sas vmx_crypto 
pseries_rng binfmt_misc ip_tables ext4 mbcache jbd2 dm_service_time 
sd_mod t10_pi crc64_rocksoft crc64 sg ibmvfc scsi_transport_fc ibmveth 
ipr dm_multipath dm_mirror dm_region_hash dm_log dm_mod fuse
[65818.211879] CPU: 16 PID: 613 Comm: kworker/16:3 Kdump: loaded Not 
tainted 6.5.0-rc7-next-20230824-auto #1
[65818.211883] Hardware name: IBM,9080-HEX POWER10 (raw) 0x800200 
0xf000006 of:IBM,FW1030.30 (NH1030_062) hv:phyp pSeries
[65818.211887] Workqueue: events sg_remove_sfp_usercontext [sg]
[65818.211894] NIP:  c000000000f5f2e4 LR: c000000000f5f2d8 CTR: 
c00000000032df70
[65818.211897] REGS: c0000000081c7a10 TRAP: 0300   Not tainted 
(6.5.0-rc7-next-20230824-auto)
[65818.211900] MSR:  800000000280b033 <SF,VEC,VSX,EE,FP,ME,IR,DR,RI,LE>  
CR: 28000882  XER: 20040000
[65818.211909] CFAR: c000000000f5b0a4 DAR: 0000000000000380 DSISR: 
40000000 IRQMASK: 0
[65818.211909] GPR00: c000000000f5f2d8 c0000000081c7cb0 c000000001451300 
0000000000000000
[65818.211909] GPR04: 00000000000000c0 00000000c0000000 c000000006c5a298 
98a2c506000000c0
[65818.211909] GPR08: c00000006408ab00 c0000000022a3515 0000000000000000 
c008000000327d60
[65818.211909] GPR12: c00000000032df70 c000000c1bc93f00 c000000000197cc8 
c000000008797500
[65818.211909] GPR16: 0000000000000000 0000000000000000 0000000000000000 
c000000003071ab0
[65818.211909] GPR20: c000000003494c05 c000000c11340040 0000000000000000 
c0000000b9bb4030
[65818.211909] GPR24: c0000000b9bb4000 c00000005e8627c0 0000000000000000 
c000000c19b91e00
[65818.211909] GPR28: c0000000b9bb5328 c00000005e8627c0 0000000000000380 
0000000000000380
[65818.211946] NIP [c000000000f5f2e4] mutex_lock+0x34/0x90
[65818.211953] LR [c000000000f5f2d8] mutex_lock+0x28/0x90
[65818.211957] Call Trace:
[65818.211959] [c0000000081c7cb0] [c000000000f5f2d8] 
mutex_lock+0x28/0x90 (unreliable)
[65818.211966] [c0000000081c7ce0] [c00000000032df9c] 
blk_trace_remove+0x2c/0x80
[65818.211971] [c0000000081c7d10] [c0080000003205fc] 
sg_device_destroy+0x44/0x110 [sg]
[65818.211976] [c0000000081c7d90] [c008000000322988] 
sg_remove_sfp_usercontext+0x1d0/0x2c0 [sg]
[65818.211981] [c0000000081c7e40] [c000000000188010] 
process_scheduled_works+0x230/0x4f0
[65818.211987] [c0000000081c7f10] [c00000000018b044] 
worker_thread+0x1e4/0x500
[65818.211992] [c0000000081c7f90] [c000000000197df8] kthread+0x138/0x140
[65818.211996] [c0000000081c7fe0] [c00000000000df98] 
start_kernel_thread+0x14/0x18
[65818.212000] Code: 38422050 7c0802a6 60000000 7c0802a6 fbe1fff8 
7c7f1b78 f8010010 f821ffd1 4bffbd95 60000000 39400000 e90d0908 
<7d20f8a8> 7c295000 40c20010 7d00f9ad
[65818.212013] ---[ end trace 0000000000000000 ]---


Tried running gdb on the vmlinux code using faulting address. Looks like 
the bug is initiated from the function "__mutex_lock_slowpath(lock);"

[root@localhost ]# gdb vmlinux -ex "disassemble /m 0xc000000000f5f2e4"
GNU gdb (GDB) Red Hat Enterprise Linux 8.2-15.el8
Copyright (C) 2018 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later 
<http://gnu.org/licenses/gpl.html>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.
Type "show copying" and "show warranty" for details.
This GDB was configured as "ppc64le-redhat-linux-gnu".
Type "show configuration" for configuration details.
For bug reporting instructions, please see:
<http://www.gnu.org/software/gdb/bugs/>.
Find the GDB manual and other documentation resources online at:
     <http://www.gnu.org/software/gdb/documentation/>.

For help, type "help".
Type "apropos word" to search for commands related to "word"...
Reading symbols from vmlinux...done.
Dump of assembler code for function mutex_lock:
282    {
    0xc000000000f5f2b0 <+0>:    addis   r2,r12,79
    0xc000000000f5f2b4 <+4>:    addi    r2,r2,8272
    0xc000000000f5f2b8 <+8>:    mflr    r0
    0xc000000000f5f2bc <+12>:    bl      0xc0000000000807d4 <mcount>

283        might_sleep();
    0xc000000000f5f2c0 <+16>:    mflr    r0
    0xc000000000f5f2c4 <+20>:    std     r31,-8(r1)
    0xc000000000f5f2c8 <+24>:    mr      r31,r3
    0xc000000000f5f2cc <+28>:    std     r0,16(r1)
    0xc000000000f5f2d0 <+32>:    stdu    r1,-48(r1)
    0xc000000000f5f2d4 <+36>:    bl      0xc000000000f5b068 
<__cond_resched+8>
    0xc000000000f5f2d8 <+40>:    nop

284
285        if (!__mutex_trylock_fast(lock))
286            __mutex_lock_slowpath(lock);
    0xc000000000f5f304 <+84>:    addi    r1,r1,48
    0xc000000000f5f308 <+88>:    mr      r3,r31
    0xc000000000f5f30c <+92>:    ld      r0,16(r1)
--Type <RET> for more, q to quit, c to continue without paging--c
    0xc000000000f5f310 <+96>:    ld      r31,-8(r1)
    0xc000000000f5f314 <+100>:    mtlr    r0
    0xc000000000f5f318 <+104>:    b       0xc000000000f5f298 
<__mutex_lock_slowpath+8>
    0xc000000000f5f31c <+108>:    nop
    0xc000000000f5f320 <+112>:    addi    r1,r1,48
    0xc000000000f5f324 <+116>:    ld      r0,16(r1)
    0xc000000000f5f328 <+120>:    ld      r31,-8(r1)
    0xc000000000f5f32c <+124>:    mtlr    r0
    0xc000000000f5f330 <+128>:    blr
    0xc000000000f5f334:    nop
    0xc000000000f5f338:    nop
    0xc000000000f5f33c:    nop

End of assembler dump.

[root@localhost ]# grep -irn "mutex_lock_slowpath(lock)"
kernel/locking/mutex.c:286:

-- 
Regards,
Tasmiya Nalatwad
IBM Linux Technology Center

