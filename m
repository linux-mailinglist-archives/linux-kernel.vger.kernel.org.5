Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3C5E77CC66
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 14:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237090AbjHOMKr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 08:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237076AbjHOMKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 08:10:25 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8649171B;
        Tue, 15 Aug 2023 05:10:22 -0700 (PDT)
Received: from kwepemm600012.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RQ96N6wGqzrScB;
        Tue, 15 Aug 2023 20:09:00 +0800 (CST)
Received: from [10.174.178.220] (10.174.178.220) by
 kwepemm600012.china.huawei.com (7.193.23.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 15 Aug 2023 20:10:19 +0800
Message-ID: <5f3794ef-6719-d9fd-a264-8c467db52ae6@huawei.com>
Date:   Tue, 15 Aug 2023 20:10:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 9/9] scsi:scsi_debug: Add debugfs interface to fail
 target reset
Content-Language: en-US
To:     kernel test robot <oliver.sang@intel.com>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-scsi@vger.kernel.org>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Douglas Gilbert <dgilbert@interlog.com>,
        <linux-kernel@vger.kernel.org>, Dan Carpenter <error27@gmail.com>,
        <louhongxiang@huawei.com>
References: <202308031027.5941ce5f-oliver.sang@intel.com>
From:   "haowenchao (C)" <haowenchao2@huawei.com>
In-Reply-To: <202308031027.5941ce5f-oliver.sang@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.220]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600012.china.huawei.com (7.193.23.74)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/8/3 14:26, kernel test robot wrote:
> 
> 
> Hello,
> 
> kernel test robot noticed "BUG:sleeping_function_called_from_invalid_context_at_kernel/locking/rwsem.c" on:
> 
> commit: b75b216522fef4d99e145fd9a1535db987ef2836 ("[PATCH v3 9/9] scsi:scsi_debug: Add debugfs interface to fail target reset")
> url: https://github.com/intel-lab-lkp/linux/commits/Wenchao-Hao/scsi-scsi_debug-create-scsi_debug-directory-in-the-debugfs-filesystem/20230723-182123
> base: https://git.kernel.org/cgit/linux/kernel/git/mkp/scsi.git for-next
> patch link: https://lore.kernel.org/all/20230723234105.1628982-10-haowenchao2@huawei.com/
> patch subject: [PATCH v3 9/9] scsi:scsi_debug: Add debugfs interface to fail target reset
> 
> in testcase: xfstests
> version: xfstests-x86_64-bb8af9c-1_20230801
> with following parameters:
> 
> 	disk: 4HDD
> 	fs: ext4
> 	test: generic-350
> 
> 
> 
> compiler: gcc-12
> test machine: 4 threads Intel(R) Core(TM) i5-6500 CPU @ 3.20GHz (Skylake) with 32G memory
> 
> (please refer to attached dmesg/kmsg for entire log/backtrace)
> 
> 
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202308031027.5941ce5f-oliver.sang@intel.com
> 
> 

Would be fixed in v4 patch.


> [  224.728219][ T2216] BUG: sleeping function called from invalid context at kernel/locking/rwsem.c:1572
> [  224.737418][ T2216] in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 2216, name: modprobe
> [  224.746095][ T2216] preempt_count: 1, expected: 0
> [  224.750787][ T2216] RCU nest depth: 0, expected: 0
> [  224.755564][ T2216] CPU: 3 PID: 2216 Comm: modprobe Tainted: G          I        6.5.0-rc1-00013-gb75b216522fe #1
> [  224.765799][ T2216] Hardware name: Dell Inc. OptiPlex 7040/0Y7WYT, BIOS 1.1.1 10/07/2015
> [  224.773867][ T2216] Call Trace:
> [  224.777011][ T2216]  <TASK>
> [ 224.779796][ T2216] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1))
> [ 224.784146][ T2216] __might_resched (kernel/sched/core.c:10190)
> [ 224.788753][ T2216] ? preempt_notifier_dec (kernel/sched/core.c:10144)
> [ 224.793792][ T2216] ? preempt_notifier_dec (kernel/sched/core.c:10144)
> [ 224.798851][ T2216] down_write (include/linux/kernel.h:111 kernel/locking/rwsem.c:1572)
> [ 224.802936][ T2216] ? rwsem_down_write_slowpath (kernel/locking/rwsem.c:1571)
> [ 224.808582][ T2216] ? kobject_put (arch/x86/include/asm/atomic.h:103 include/linux/atomic/atomic-arch-fallback.h:940 include/linux/atomic/atomic-instrumented.h:401 include/linux/refcount.h:272 include/linux/refcount.h:315 include/linux/refcount.h:333 include/linux/kref.h:64 lib/kobject.c:730)
> [ 224.812858][ T2216] simple_recursive_removal (include/linux/dcache.h:385 include/linux/dcache.h:400 include/linux/dcache.h:410 fs/libfs.c:273)
> [ 224.818256][ T2216] ? start_creating (fs/tracefs/inode.c:135)
> [ 224.823555][ T2216] ? _raw_spin_lock_irqsave (arch/x86/include/asm/atomic.h:115 include/linux/atomic/atomic-arch-fallback.h:2155 include/linux/atomic/atomic-instrumented.h:1296 include/asm-generic/qspinlock.h:111 include/linux/spinlock.h:187 include/linux/spinlock_api_smp.h:111 kernel/locking/spinlock.c:162)
> [ 224.828766][ T2216] ? _raw_read_unlock_irqrestore (kernel/locking/spinlock.c:161)
> [ 224.834412][ T2216] debugfs_remove (fs/debugfs/inode.c:766)
> [ 224.838758][ T2216] sdebug_target_destroy (drivers/scsi/scsi_debug.c:1147) scsi_debug
> [ 224.844874][ T2216] scsi_target_destroy (drivers/scsi/scsi_scan.c:401)
> [ 224.849830][ T2216] __scsi_remove_device (drivers/scsi/scsi_sysfs.c:1517)
> [ 224.854889][ T2216] scsi_forget_host (drivers/scsi/scsi_scan.c:1988)
> [ 224.859508][ T2216] scsi_remove_host (drivers/scsi/hosts.c:182)
> [ 224.864113][ T2216] sdebug_driver_remove (drivers/scsi/scsi_debug.c:8342) scsi_debug
> [ 224.870201][ T2216] ? kernfs_remove_by_name_ns (fs/kernfs/dir.c:1679)
> [ 224.875758][ T2216] device_release_driver_internal (drivers/base/dd.c:1272 drivers/base/dd.c:1293)
> [ 224.881662][ T2216] bus_remove_device (include/linux/kobject.h:191 drivers/base/base.h:73 drivers/base/bus.c:581)
> [ 224.886442][ T2216] device_del (drivers/base/core.c:3815)
> [ 224.890616][ T2216] ? __device_link_del (drivers/base/core.c:3769)
> [ 224.895567][ T2216] ? mutex_unlock (arch/x86/include/asm/atomic64_64.h:109 include/linux/atomic/atomic-arch-fallback.h:4303 include/linux/atomic/atomic-long.h:1499 include/linux/atomic/atomic-instrumented.h:4446 kernel/locking/mutex.c:181 kernel/locking/mutex.c:540)
> [ 224.899915][ T2216] ? __mutex_unlock_slowpath+0x2b0/0x2b0
> [ 224.906427][ T2216] device_unregister (drivers/base/core.c:3732 drivers/base/core.c:3845)
> [ 224.911038][ T2216] sdebug_do_remove_host (drivers/scsi/scsi_debug.c:7691) scsi_debug
> [ 224.917309][ T2216] scsi_debug_exit (drivers/scsi/scsi_debug.c:8170) scsi_debug
> [ 224.922889][ T2216] __do_sys_delete_module+0x316/0x540
> [ 224.929162][ T2216] ? module_flags (kernel/module/main.c:698)
> [ 224.933689][ T2216] ? task_work_cancel (kernel/task_work.c:147)
> [ 224.938388][ T2216] ? _raw_spin_lock (arch/x86/include/asm/atomic.h:115 include/linux/atomic/atomic-arch-fallback.h:2155 include/linux/atomic/atomic-instrumented.h:1296 include/asm-generic/qspinlock.h:111 include/linux/spinlock.h:187 include/linux/spinlock_api_smp.h:134 kernel/locking/spinlock.c:154)
> [ 224.942921][ T2216] ? exit_to_user_mode_loop (include/linux/sched.h:2337 include/linux/resume_user_mode.h:61 kernel/entry/common.c:171)
> [ 224.948222][ T2216] do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80)
> [ 224.952483][ T2216] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120)
> [  224.958217][ T2216] RIP: 0033:0x7fe4243fc417
> [ 224.962479][ T2216] Code: 73 01 c3 48 8b 0d 79 1a 0d 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 b0 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 49 1a 0d 00 f7 d8 64 89 01 48
> All code
> ========
>     0:	73 01                	jae    0x3
>     2:	c3                   	retq
>     3:	48 8b 0d 79 1a 0d 00 	mov    0xd1a79(%rip),%rcx        # 0xd1a83
>     a:	f7 d8                	neg    %eax
>     c:	64 89 01             	mov    %eax,%fs:(%rcx)
>     f:	48 83 c8 ff          	or     $0xffffffffffffffff,%rax
>    13:	c3                   	retq
>    14:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
>    1b:	00 00 00
>    1e:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
>    23:	b8 b0 00 00 00       	mov    $0xb0,%eax
>    28:	0f 05                	syscall
>    2a:*	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax		<-- trapping instruction
>    30:	73 01                	jae    0x33
>    32:	c3                   	retq
>    33:	48 8b 0d 49 1a 0d 00 	mov    0xd1a49(%rip),%rcx        # 0xd1a83
>    3a:	f7 d8                	neg    %eax
>    3c:	64 89 01             	mov    %eax,%fs:(%rcx)
>    3f:	48                   	rex.W
> 
> Code starting with the faulting instruction
> ===========================================
>     0:	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax
>     6:	73 01                	jae    0x9
>     8:	c3                   	retq
>     9:	48 8b 0d 49 1a 0d 00 	mov    0xd1a49(%rip),%rcx        # 0xd1a59
>    10:	f7 d8                	neg    %eax
>    12:	64 89 01             	mov    %eax,%fs:(%rcx)
>    15:	48                   	rex.W
> [  224.981910][ T2216] RSP: 002b:00007ffc194cd048 EFLAGS: 00000206 ORIG_RAX: 00000000000000b0
> [  224.990153][ T2216] RAX: ffffffffffffffda RBX: 00005641e66c7c70 RCX: 00007fe4243fc417
> [  224.997962][ T2216] RDX: 0000000000000000 RSI: 0000000000000800 RDI: 00005641e66c7cd8
> [  225.005769][ T2216] RBP: 00005641e66c7c70 R08: 0000000000000000 R09: 0000000000000000
> [  225.013579][ T2216] R10: 00007fe42447cac0 R11: 0000000000000206 R12: 00005641e66c7cd8
> [  225.021386][ T2216] R13: 0000000000000000 R14: 0000000000000000 R15: 00005641e66c7df0
> [  225.029197][ T2216]  </TASK>
> [  225.355582][ T2223] EXT4-fs (sda1): unmounting filesystem fc80755b-20bd-48b4-996a-4bc58040c94e.
> [  225.676238][  T277] generic/350       _check_dmesg: something found in dmesg (see /lkp/benchmarks/xfstests/results//generic/350.dmesg)
> [  225.676268][  T277]
> [  304.321275][  T277]
> [  304.321304][  T277]
> [  304.343153][  T277] Ran: generic/350
> [  304.343170][  T277]
> [  304.349423][  T277] Failures: generic/350
> [  304.349436][  T277]
> [  304.356135][  T277] Failed 1 of 1 tests
> 
> 
> To reproduce:
> 
>          git clone https://github.com/intel/lkp-tests.git
>          cd lkp-tests
>          sudo bin/lkp install job.yaml           # job file is attached in this email
>          bin/lkp split-job --compatible job.yaml # generate the yaml file for lkp run
>          sudo bin/lkp run generated-yaml-file
> 
>          # if come across any failure that blocks the test,
>          # please remove ~/.lkp and /lkp dir to run from a clean state.
> 
> 
> 

