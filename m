Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F293180806F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 07:02:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377325AbjLGGBx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 01:01:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjLGGBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 01:01:51 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39969110
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 22:01:56 -0800 (PST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B73RQJt030679;
        Thu, 7 Dec 2023 06:00:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=kfHjtCO81Cq8F7M9jaU5wyPSkczYMxitjDVI9RPfJio=;
 b=MQ9djqAWLvnjHlsqCIn1z4x8xEycpgJkP/dqIEtOaXko/T0pTi/mV9oXrywjtrrSLamj
 BwL+T0Bxg68qMp+cs4wk8FSHy+GYuvG+6CmkWArWG5+fEx2IjEq84Z31Hv30mzoZdIM3
 ySsYi1zEMXRKZYepXNFx3PNLn9uU3d177qZ0uaaW0T85QVhN8bPU1rS4k9NqP0zvXink
 lKu1pY8rgreFje49uER7E9dJg7Nr51vbOp3lWkiVSSBZuZ53ne+pq0qn5JDouNk+a6Ak
 YkpFzan+usyG3bMCQkkSWLObJzJ9AFq5HnCbxFY9iAM5oZNSmvWmKGno5G2EbxxnnPF4 SA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uu65mujdm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Dec 2023 06:00:27 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3B75o9j0030305;
        Thu, 7 Dec 2023 06:00:24 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uu65muja7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Dec 2023 06:00:24 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
        by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3B74WQsf027000;
        Thu, 7 Dec 2023 06:00:21 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
        by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3utav31a75-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Dec 2023 06:00:21 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
        by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3B760KDj19661390
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 7 Dec 2023 06:00:20 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3E59158057;
        Thu,  7 Dec 2023 06:00:20 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E9F3558062;
        Thu,  7 Dec 2023 06:00:14 +0000 (GMT)
Received: from li-34d1fccc-27cd-11b2-a85c-c167793e56f7.ibm.com (unknown [9.171.33.211])
        by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Thu,  7 Dec 2023 06:00:14 +0000 (GMT)
Message-ID: <c9bdc8611db65d47041ffc485c8da0b7fbd12184.camel@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 0/7] sched: Implement shared runqueue in CFS
From:   Aboorva Devarajan <aboorvad@linux.vnet.ibm.com>
To:     David Vernet <void@manifault.com>
Cc:     peterz@infradead.org, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, tj@kernel.org,
        roman.gushchin@linux.dev, gautham.shenoy@amd.com,
        kprateek.nayak@amd.com, aaron.lu@intel.com,
        wuyun.abel@bytedance.com, kernel-team@meta.com,
        linux-kernel@vger.kernel.org
Date:   Thu, 07 Dec 2023 11:30:13 +0530
In-Reply-To: <20231127194929.GA5421@maniforge>
References: <20230809221218.163894-1-void@manifault.com>
         <fd7370aeef50c50228b817e817872921b33fc5fe.camel@linux.vnet.ibm.com>
         <20231127194929.GA5421@maniforge>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: yJ6WFJzELMjAGNcQIvJSoAw9kaPk_ZAQ
X-Proofpoint-GUID: _68Fp2kalz44QDKG5lK7jnyj-b7Yr3V3
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-07_03,2023-12-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 lowpriorityscore=0 mlxlogscore=999 malwarescore=0
 impostorscore=0 bulkscore=0 spamscore=0 clxscore=1011 mlxscore=0
 phishscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311290000 definitions=main-2312070045
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-11-27 at 13:49 -0600, David Vernet wrote:
> On Mon, Nov 27, 2023 at 01:58:34PM +0530, Aboorva Devarajan wrote:
> > On Wed, 2023-08-09 at 17:12 -0500, David Vernet wrote:
> > 
> > Hi David,
> > 
> > I have been benchmarking the patch-set on POWER9 machine to understand
> > its impact. However, I've run into a recurring hard-lockups in
> > newidle_balance, specifically when SHARED_RUNQ feature is enabled. It
> > doesn't happen all the time, but it's something worth noting. I wanted
> > to inform you about this, and I can provide more details if needed.
> 
> Hello Aboorva,
> 
> Thank you for testing out this patch set and for the report. One issue
> that v4 will correct is that the shared_runq list could become corrupted
> if you enable and disable the feature, as a stale task could remain in
> the list after the feature has been disabled. I'll be including a fix
> for that in v4, which I'm currently benchmarking, but other stuff keeps
> seeming to preempt it.

Hi David,

Thank you for your response. While testing, I did observe the
shared_runq list becoming corrupted when enabling and disabling the
feature. 

Please find the logs below with CONFIG_DEBUG_LIST enabled:
------------------------------------------

[ 4952.270819] list_add corruption. prev->next should be next (c0000003fae87a80), but was c0000000ba027ec8. (prev=c0000000ba027ec8).
[ 4952.270926] ------------[ cut here ]------------
[ 4952.270935] kernel BUG at lib/list_debug.c:30!
[ 4952.270947] Oops: Exception in kernel mode, sig: 5 [#1]
[ 4952.270956] LE PAGE_SIZE=64K MMU=Radix SMP NR_CPUS=2048 NUMA pSeries
[ 4952.271029] CPU: 10 PID: 31426 Comm: cc1 Kdump: loaded Not tainted 6.5.0-rc2+ #1
[ 4952.271042] Hardware name: IBM,9080-HEX POWER10 (raw) 0x800200 0xf000006 of:IBM,FW1060.00 (NH1060_012) hv:phyp pSeries
[ 4952.271054] NIP:  c000000000872f88 LR: c000000000872f84 CTR: 00000000006d1a1c
[ 4952.271070] REGS: c00000006e1b34e0 TRAP: 0700   Not tainted  (6.5.0-rc2+)
[ 4952.271079] MSR:  8000000002029033 <SF,VEC,EE,ME,IR,DR,RI,LE>  CR: 28048222  XER: 00000006
[ 4952.271102] CFAR: c0000000001ffa24 IRQMASK: 1 
[ 4952.271102] GPR00: c000000000872f84 c00000006e1b3780 c0000000019a3b00 0000000000000075 
[ 4952.271102] GPR04: c0000003faff2c08 c0000003fb077e80 c00000006e1b35c8 00000003f8e70000 
[ 4952.271102] GPR08: 0000000000000027 c000000002185f30 00000003f8e70000 0000000000000001 
[ 4952.271102] GPR12: 0000000000000000 c0000003fffe2c80 c000000068ecb100 0000000000000000 
[ 4952.271102] GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
[ 4952.271102] GPR20: 0000000000000000 0000000000000000 0000000000000041 c00000006e1b3bb0 
[ 4952.271102] GPR24: c000000002c72058 00000003f8e70000 0000000000000001 c00000000e919948 
[ 4952.271102] GPR28: c0000000ba027ec8 c0000003fae87a80 c000000080ce6c00 c00000000e919980 
[ 4952.271212] NIP [c000000000872f88] __list_add_valid+0xb8/0x100
[ 4952.271236] LR [c000000000872f84] __list_add_valid+0xb4/0x100
[ 4952.271248] Call Trace:
[ 4952.271254] [c00000006e1b3780] [c000000000872f84] __list_add_valid+0xb4/0x100 (unreliable)
[ 4952.271270] [c00000006e1b37e0] [c0000000001b8f50] __enqueue_entity+0x110/0x1c0
[ 4952.271288] [c00000006e1b3830] [c0000000001bec9c] enqueue_entity+0x16c/0x690
[ 4952.271301] [c00000006e1b38e0] [c0000000001bf280] enqueue_task_fair+0xc0/0x490
[ 4952.271315] [c00000006e1b3980] [c0000000001ada0c] ttwu_do_activate+0xac/0x410
[ 4952.271328] [c00000006e1b3a10] [c0000000001ae59c] try_to_wake_up+0x5fc/0x8b0
[ 4952.271341] [c00000006e1b3ae0] [c0000000001df6dc] autoremove_wake_function+0x2c/0xc0
[ 4952.271359] [c00000006e1b3b20] [c0000000001e1018] __wake_up_common+0xc8/0x240
[ 4952.271372] [c00000006e1b3b90] [c0000000001e123c] __wake_up_common_lock+0xac/0x120
[ 4952.271385] [c00000006e1b3c20] [c0000000005bd4a4] pipe_write+0xd4/0x980
[ 4952.271401] [c00000006e1b3d00] [c0000000005ad720] vfs_write+0x350/0x4b0
[ 4952.271420] [c00000006e1b3dc0] [c0000000005adc24] ksys_write+0xf4/0x140
[ 4952.271433] [c00000006e1b3e10] [c000000000031108] system_call_exception+0x128/0x340
[ 4952.271449] [c00000006e1b3e50] [c00000000000cedc] system_call_vectored_common+0x15c/0x2ec
[ 4952.271470] --- interrupt: 3000 at 0x7fff8df3aa34
[ 4952.271482] NIP:  00007fff8df3aa34 LR: 0000000000000000 CTR: 0000000000000000
[ 4952.271492] REGS: c00000006e1b3e80 TRAP: 3000   Not tainted  (6.5.0-rc2+)
[ 4952.271502] MSR:  800000000000f033 <SF,EE,PR,FP,ME,IR,DR,RI,LE>  CR: 44002822  XER: 00000000
[ 4952.271526] IRQMASK: 0 
[ 4952.271526] GPR00: 0000000000000004 00007fffea094d00 0000000112467a00 0000000000000001 
[ 4952.271526] GPR04: 0000000132c6a810 0000000000002000 00000000000004e4 0000000000000036 
[ 4952.271526] GPR08: 0000000132c6c810 0000000000000000 0000000000000000 0000000000000000 
[ 4952.271526] GPR12: 0000000000000000 00007fff8e71cac0 0000000000000000 0000000000000000 
[ 4952.271526] GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
[ 4952.271526] GPR20: 00007fffea09c76f 00000001123b6898 0000000000000003 0000000132c6c820 
[ 4952.271526] GPR24: 0000000112469d88 00000001124686b8 0000000132c6a810 0000000000002000 
[ 4952.271526] GPR28: 0000000000002000 00007fff8e0418e0 0000000132c6a810 0000000000002000 
[ 4952.271627] NIP [00007fff8df3aa34] 0x7fff8df3aa34
[ 4952.271635] LR [0000000000000000] 0x0
[ 4952.271642] --- interrupt: 3000
[ 4952.271648] Code: f8010070 4b98ca81 60000000 0fe00000 7c0802a6 3c62ffa6 7d064378 7d244b78 38637f68 f8010070 4b98ca5d 60000000 <0fe00000> 7c0802a6 3c62ffa6 7ca62b78 
[ 4952.271685] ---[ end trace 0000000000000000 ]---
[ 4952.282562] pstore: backend (nvram) writing error (-1)
------------------------------------------

> 
> By any chance, did you run into this when you were enabling / disabling
> the feature? Or did you just enable it once and then hit this issue
> after some time, which would indicate a different issue? I'm trying to
> repro using ab, but haven't been successful thus far. If you're able to
> repro consistently, it might be useful to run with CONFIG_LIST_DEBUG=y.
> 

Additionally, I noticed a sporadic issue persisting even after enabling
the feature once, and the issue surfaced over time.  However, it
occurred specifically on a particular system, and my attempts to
recreate it were unsuccessful. I will provide more details if I can
successfully reproduce the issue with debug enabled. But looks like the
primary issue revolves around the shared_runq list getting corrupted
when toggling the feature on and off repeatedly as you pointed out.

I will keep an eye out for v4 and test if it's available later.

Thanks,
Aboorva


> Thanks,
> David
> 
> > -----------------------------------------
> > 
> > Some inital information regarding the hard-lockup:
> > 
> > Base Kernel:
> > -----------
> > 
> > Base kernel is upto commit 88c56cfeaec4 ("sched/fair: Block nohz
> > tick_stop when cfs bandwidth in use").
> > 
> > Patched Kernel:
> > -------------
> > 
> > Base Kernel + v3 (shared runqueue patch-set)(
> > https://lore.kernel.org/all/20230809221218.163894-1-void@manifault.com/
> > )
> > 
> > The hard-lockup moslty occurs when running the Apache2 benchmarks
> > with
> > ab (Apache HTTP benchmarking tool) on the patched kernel. However,
> > this
> > problem is not exclusive to the mentioned benchmark and only occurs
> > while the SHARED_RUNQ feature is enabled. Disabling SHARED_RUNQ
> > feature
> > prevents the occurrence of the lockup.
> > 
> > ab (Apache HTTP benchmarking tool): 
> > https://httpd.apache.org/docs/2.4/programs/ab.html
> > 
> > Hardlockup with Patched Kernel:
> > ------------------------------
> > 
> > [ 3289.727912][  C123] rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
> > [ 3289.727943][  C123] rcu: 	124-...0: (1 GPs behind) idle=f174/1/0x4000000000000000 softirq=12283/12289 fqs=732
> > [ 3289.727976][  C123] rcu: 	(detected by 123, t=2103 jiffies, g=127061, q=5517 ncpus=128)
> > [ 3289.728008][  C123] Sending NMI from CPU 123 to CPUs 124:
> > [ 3295.182378][  C123] CPU 124 didn't respond to backtrace IPI, inspecting paca.
> > [ 3295.182403][  C123] irq_soft_mask: 0x01 in_mce: 0 in_nmi: 0 current: 15 (ksoftirqd/124)
> > [ 3295.182421][  C123] Back trace of paca->saved_r1 (0xc000000de13e79b0) (possibly stale):
> > [ 3295.182437][  C123] Call Trace:
> > [ 3295.182456][  C123] [c000000de13e79b0] [c000000de13e7a70] 0xc000000de13e7a70 (unreliable)
> > [ 3295.182477][  C123] [c000000de13e7ac0] [0000000000000008] 0x8
> > [ 3295.182500][  C123] [c000000de13e7b70] [c000000de13e7c98] 0xc000000de13e7c98
> > [ 3295.182519][  C123] [c000000de13e7ba0] [c0000000001da8bc] move_queued_task+0x14c/0x280
> > [ 3295.182557][  C123] [c000000de13e7c30] [c0000000001f22d8] newidle_balance+0x648/0x940
> > [ 3295.182602][  C123] [c000000de13e7d30] [c0000000001f26ac] pick_next_task_fair+0x7c/0x680
> > [ 3295.182647][  C123] [c000000de13e7dd0] [c0000000010f175c] __schedule+0x15c/0x1040
> > [ 3295.182675][  C123] [c000000de13e7ec0] [c0000000010f26b4] schedule+0x74/0x140
> > [ 3295.182694][  C123] [c000000de13e7f30] [c0000000001c4994] smpboot_thread_fn+0x244/0x250
> > [ 3295.182731][  C123] [c000000de13e7f90] [c0000000001bc6e8] kthread+0x138/0x140
> > [ 3295.182769][  C123] [c000000de13e7fe0] [c00000000000ded8] start_kernel_thread+0x14/0x18
> > [ 3295.182806][  C123] rcu: rcu_sched kthread starved for 544 jiffies! g127061 f0x0 RCU_GP_DOING_FQS(6) ->state=0x0 ->cpu=66
> > [ 3295.182845][  C123] rcu: 	Unless rcu_sched kthread gets sufficient CPU time, OOM is now expected behavior.
> > [ 3295.182878][  C123] rcu: RCU grace-period kthread stack dump:
> > 
> > -----------------------------------------
> > 
> > [ 3943.438625][  C112] watchdog: CPU 112 self-detected hard LOCKUP @ _raw_spin_lock_irqsave+0x4c/0xc0
> > [ 3943.438631][  C112] watchdog: CPU 112 TB:115060212303626, last heartbeat TB:115054309631589 (11528ms ago)
> > [ 3943.438673][  C112] CPU: 112 PID: 2090 Comm: kworker/112:2 Tainted: G        W    L     6.5.0-rc2-00028-g7475adccd76b #51
> > [ 3943.438676][  C112] Hardware name: 8335-GTW POWER9 (raw) 0x4e1203 opal:skiboot-v6.5.3-35-g1851b2a06 PowerNV
> > [ 3943.438678][  C112] Workqueue:  0x0 (events)
> > [ 3943.438682][  C112] NIP:  c0000000010ff01c LR: c0000000001d1064 CTR: c0000000001e8580
> > [ 3943.438684][  C112] REGS: c000007fffb6bd60 TRAP: 0900   Tainted: G        W    L      (6.5.0-rc2-00028-g7475adccd76b)
> > [ 3943.438686][  C112] MSR:  9000000000009033 <SF,HV,EE,ME,IR,DR,RI,LE>  CR: 24082222  XER: 00000000
> > [ 3943.438693][  C112] CFAR: 0000000000000000 IRQMASK: 1 
> > [ 3943.438693][  C112] GPR00: c0000000001d1064 c000000e16d1fb20 c0000000014e8200 c000000e092fed3c 
> > [ 3943.438693][  C112] GPR04: c000000e16d1fc58 c000000e092fe3c8 00000000000000e1 fffffffffffe0000 
> > [ 3943.438693][  C112] GPR08: 0000000000000000 00000000000000e1 0000000000000000 c00000000299ccd8 
> > [ 3943.438693][  C112] GPR12: 0000000024088222 c000007ffffb8300 c0000000001bc5b8 c000000deb46f740 
> > [ 3943.438693][  C112] GPR16: 0000000000000008 c000000e092fe280 0000000000000001 c000007ffedd7b00 
> > [ 3943.438693][  C112] GPR20: 0000000000000001 c0000000029a1280 0000000000000000 0000000000000001 
> > [ 3943.438693][  C112] GPR24: 0000000000000000 c000000e092fed3c c000000e16d1fdf0 c00000000299ccd8 
> > [ 3943.438693][  C112] GPR28: c000000e16d1fc58 c0000000021fbf00 c000007ffee6bf00 0000000000000001 
> > [ 3943.438722][  C112] NIP [c0000000010ff01c] _raw_spin_lock_irqsave+0x4c/0xc0
> > [ 3943.438725][  C112] LR [c0000000001d1064] task_rq_lock+0x64/0x1b0
> > [ 3943.438727][  C112] Call Trace:
> > [ 3943.438728][  C112] [c000000e16d1fb20] [c000000e16d1fb60] 0xc000000e16d1fb60 (unreliable)
> > [ 3943.438731][  C112] [c000000e16d1fb50] [c000000e16d1fbf0] 0xc000000e16d1fbf0
> > [ 3943.438733][  C112] [c000000e16d1fbf0] [c0000000001f214c] newidle_balance+0x4bc/0x940
> > [ 3943.438737][  C112] [c000000e16d1fcf0] [c0000000001f26ac] pick_next_task_fair+0x7c/0x680
> > [ 3943.438739][  C112] [c000000e16d1fd90] [c0000000010f175c] __schedule+0x15c/0x1040
> > [ 3943.438743][  C112] [c000000e16d1fe80] [c0000000010f26b4] schedule+0x74/0x140
> > [ 3943.438747][  C112] [c000000e16d1fef0] [c0000000001afd44] worker_thread+0x134/0x580
> > [ 3943.438749][  C112] [c000000e16d1ff90] [c0000000001bc6e8] kthread+0x138/0x140
> > [ 3943.438753][  C112] [c000000e16d1ffe0] [c00000000000ded8] start_kernel_thread+0x14/0x18
> > [ 3943.438756][  C112] Code: 63e90001 992d0932 a12d0008 3ce0fffe 5529083c 61290001 7d001
> > 
> > -----------------------------------------
> > 
> > System configuration:
> > --------------------
> > 
> > # lscpu
> > Architecture:                    ppc64le
> > Byte Order:                      Little Endian
> > CPU(s):                          128
> > On-line CPU(s) list:             0-127
> > Thread(s) per core:              4
> > Core(s) per socket:              16
> > Socket(s):                       2
> > NUMA node(s):                    8
> > Model:                           2.3 (pvr 004e 1203)
> > Model name:                      POWER9 (raw), altivec supported
> > Frequency boost:                 enabled
> > CPU max MHz:                     3800.0000
> > CPU min MHz:                     2300.0000
> > L1d cache:                       1 MiB
> > L1i cache:                       1 MiB
> > NUMA node0 CPU(s):               64-127
> > NUMA node8 CPU(s):               0-63
> > NUMA node250 CPU(s):             
> > NUMA node251 CPU(s):             
> > NUMA node252 CPU(s):             
> > NUMA node253 CPU(s):             
> > NUMA node254 CPU(s):             
> > NUMA node255 CPU(s):             
> > 
> > # uname -r
> > 6.5.0-rc2-00028-g7475adccd76b
> > 
> > # cat /sys/kernel/debug/sched/features
> > GENTLE_FAIR_SLEEPERS START_DEBIT NO_NEXT_BUDDY LAST_BUDDY
> > CACHE_HOT_BUDDY WAKEUP_PREEMPTION NO_HRTICK NO_HRTICK_DL NO_DOUBLE_TICK
> > NONTASK_CAPACITY TTWU_QUEUE NO_SIS_PROP SIS_UTIL NO_WARN_DOUBLE_CLOCK
> > RT_PUSH_IPI NO_RT_RUNTIME_SHARE NO_LB_MIN ATTACH_AGE_LOAD WA_IDLE
> > WA_WEIGHT WA_BIAS UTIL_EST UTIL_EST_FASTUP NO_LATENCY_WARN ALT_PERIOD
> > BASE_SLICE HZ_BW SHARED_RUNQ
> > 
> > -----------------------------------------
> > 
> > Please let me know if I've missed anything here. I'll continue
> > investigating and share any additional information I find.
> > 
> > Thanks and Regards,
> > Aboorva
> > 

