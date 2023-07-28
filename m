Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 517817668E6
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 11:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235409AbjG1Jcp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 05:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235412AbjG1JcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 05:32:24 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00D6D19A7;
        Fri, 28 Jul 2023 02:31:05 -0700 (PDT)
Received: from dggpeml500006.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RC2RL4JZHz1GDFs;
        Fri, 28 Jul 2023 17:30:06 +0800 (CST)
Received: from [10.174.176.127] (10.174.176.127) by
 dggpeml500006.china.huawei.com (7.185.36.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 28 Jul 2023 17:31:00 +0800
Subject: Re: [PATCH 5.10 000/509] 5.10.188-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <stable@vger.kernel.org>
CC:     <patches@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <torvalds@linux-foundation.org>, <akpm@linux-foundation.org>,
        <linux@roeck-us.net>, <shuah@kernel.org>, <patches@kernelci.org>,
        <lkft-triage@lists.linaro.org>, <pavel@denx.de>,
        <jonathanh@nvidia.com>, <f.fainelli@gmail.com>,
        <sudipm.mukherjee@gmail.com>, <srw@sladewatkins.net>,
        <rwarsow@gmx.de>, <conor@kernel.org>
References: <20230725104553.588743331@linuxfoundation.org>
From:   luomeng <luomeng12@huawei.com>
Message-ID: <645471da-dbfc-ee61-decc-73bae34690ba@huawei.com>
Date:   Fri, 28 Jul 2023 17:31:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20230725104553.588743331@linuxfoundation.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.127]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500006.china.huawei.com (7.185.36.76)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tested on arm64 and x86 for 5.10.188-rc1,

Kernel 
repo:https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
Branch: linux-5.10.y
Version:  5.10.188-rc1
Commit: 4a64f03701033c39271bac1039ff76ef15ae50a3
Compiler: gcc version 7.3.0 (GCC)

arm64:
--------------------------------------------------------------------
Testcase Result Summary:
total: 8978
passed: 8978
failed: 0
timeout: 0
--------------------------------------------------------------------

x86:
--------------------------------------------------------------------
Testcase Result Summary:
total: 8978
passed: 8978
failed: 0
timeout: 0
--------------------------------------------------------------------
Tested-by: Hulk Robot <hulkrobot@huawei.com>

在 2023/7/25 18:38, Greg Kroah-Hartman 写道:
> This is the start of the stable review cycle for the 5.10.188 release.
> There are 509 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 27 Jul 2023 10:44:26 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.188-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 
> -------------
> Pseudo-Shortlog of commits:
> 
> Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>      Linux 5.10.188-rc1
> 
> Zheng Yejian <zhengyejian1@huawei.com>
>      ftrace: Fix possible warning on checking all pages used in ftrace_process_locs()
> 
> Linus Torvalds <torvalds@linux-foundation.org>
>      ftrace: Store the order of pages allocated in ftrace_page
> 
> Zheng Yejian <zhengyejian1@huawei.com>
>      tracing: Fix memory leak of iter->temp when reading trace_pipe
> 
> Mohamed Khalfella <mkhalfella@purestorage.com>
>      tracing/histograms: Return an error if we fail to add histogram to hist_vars list
> 
> Vladimir Oltean <vladimir.oltean@nxp.com>
>      net: phy: prevent stale pointer dereference in phy_init()
> 
> Eric Dumazet <edumazet@google.com>
>      tcp: annotate data-races around fastopenq.max_qlen
> 
> Eric Dumazet <edumazet@google.com>
>      tcp: annotate data-races around icsk->icsk_user_timeout
> 
> Eric Dumazet <edumazet@google.com>
>      tcp: annotate data-races around tp->notsent_lowat
> 
> Eric Dumazet <edumazet@google.com>
>      tcp: annotate data-races around rskq_defer_accept
> 
> Eric Dumazet <edumazet@google.com>
>      tcp: annotate data-races around tp->linger2
> 
> Eric Dumazet <edumazet@google.com>
>      tcp: annotate data-races around icsk->icsk_syn_retries
> 
> Kuniyuki Iwashima <kuniyu@amazon.com>
>      tcp: Fix data-races around sysctl_tcp_syn(ack)?_retries.
> 
> Kuniyuki Iwashima <kuniyu@amazon.co.jp>
>      net: Introduce net.ipv4.tcp_migrate_req.
> 
> Eric Dumazet <edumazet@google.com>
>      tcp: annotate data-races around tp->keepalive_probes
> 
> Eric Dumazet <edumazet@google.com>
>      tcp: annotate data-races around tp->keepalive_intvl
> 
> Eric Dumazet <edumazet@google.com>
>      tcp: annotate data-races around tp->keepalive_time
> 
> Eric Dumazet <edumazet@google.com>
>      tcp: annotate data-races around tp->tcp_tx_delay
> 
> Pablo Neira Ayuso <pablo@netfilter.org>
>      netfilter: nf_tables: skip bound chain on rule flush
> 
> Pablo Neira Ayuso <pablo@netfilter.org>
>      netfilter: nf_tables: skip bound chain in netns release path
> 
> Florian Westphal <fw@strlen.de>
>      netfilter: nft_set_pipapo: fix improper element removal
> 
> Florian Westphal <fw@strlen.de>
>      netfilter: nf_tables: can't schedule in nft_chain_validate
> 
> Florian Westphal <fw@strlen.de>
>      netfilter: nf_tables: fix spurious set element insertion failure
> 
> Kuniyuki Iwashima <kuniyu@amazon.com>
>      llc: Don't drop packet from non-root netns.
> 
> Zhang Shurong <zhang_shurong@foxmail.com>
>      fbdev: au1200fb: Fix missing IRQ check in au1200fb_drv_probe
> 
> Kuniyuki Iwashima <kuniyu@amazon.com>
>      Revert "tcp: avoid the lookup process failing to get sk in ehash table"
> 
> Yuanjun Gong <ruc_gongyuanjun@163.com>
>      net:ipv6: check return value of pskb_trim()
> 
> Wang Ming <machel@vivo.com>
>      net: ipv4: Use kfree_sensitive instead of kfree
> 
> Eric Dumazet <edumazet@google.com>
>      tcp: annotate data-races around tcp_rsk(req)->ts_recent
> 
> Geetha sowjanya <gakula@marvell.com>
>      octeontx2-pf: Dont allocate BPIDs for LBK interfaces
> 
> Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
>      security: keys: Modify mismatched function name
> 
> Ding Hui <dinghui@sangfor.com.cn>
>      iavf: Fix out-of-bounds when setting channels on remove
> 
> Ding Hui <dinghui@sangfor.com.cn>
>      iavf: Fix use-after-free in free_netdev
> 
> Kuniyuki Iwashima <kuniyu@amazon.com>
>      bridge: Add extack warning when enabling STP in netns.
> 
> Tanmay Patil <t-patil@ti.com>
>      net: ethernet: ti: cpsw_ale: Fix cpsw_ale_get_field()/cpsw_ale_set_field()
> 
> Mario Limonciello <mario.limonciello@amd.com>
>      pinctrl: amd: Use amd_pinconf_set() for all config options
> 
> Martin Kaiser <martin@kaiser.cx>
>      fbdev: imxfb: warn about invalid left/right margin
> 
> Jonas Gorski <jonas.gorski@gmail.com>
>      spi: bcm63xx: fix max prepend length
> 
> Ying Hsu <yinghsu@chromium.org>
>      igb: Fix igb_down hung on surprise removal
> 
> Johannes Berg <johannes.berg@intel.com>
>      wifi: iwlwifi: mvm: avoid baid size integer overflow
> 
> Gustavo A. R. Silva <gustavoars@kernel.org>
>      wifi: wext-core: Fix -Wstringop-overflow warning in ioctl_standard_iw_point()
> 
> Petr Oros <poros@redhat.com>
>      devlink: report devlink_port_type_warn source device
> 
> Martin KaFai Lau <martin.lau@kernel.org>
>      bpf: Address KCSAN report on bpf_lru_list
> 
> Maxime Bizon <mbizon@freebox.fr>
>      wifi: ath11k: fix registration of 6Ghz-only phy without the full channel range
> 
> Yicong Yang <yangyicong@hisilicon.com>
>      sched/fair: Don't balance task to its current running CPU
> 
> Mark Rutland <mark.rutland@arm.com>
>      arm64: mm: fix VA-range sanity check
> 
> Youngmin Nam <youngmin.nam@samsung.com>
>      arm64: set __exception_irq_entry with __irq_entry as a default
> 
> Hans de Goede <hdegoede@redhat.com>
>      ACPI: video: Add backlight=native DMI quirk for Lenovo ThinkPad X131e (3371 AMD version)
> 
> Hans de Goede <hdegoede@redhat.com>
>      ACPI: video: Add backlight=native DMI quirk for Apple iMac11,3
> 
> Hans de Goede <hdegoede@redhat.com>
>      ACPI: button: Add lid disable DMI quirk for Nextbook Ares 8A
> 
> David Sterba <dsterba@suse.com>
>      btrfs: add xxhash to fast checksum implementations
> 
> Thomas Gleixner <tglx@linutronix.de>
>      posix-timers: Ensure timer ID search-loop limit is valid
> 
> Yu Kuai <yukuai3@huawei.com>
>      md/raid10: prevent soft lockup while flush writes
> 
> Yu Kuai <yukuai3@huawei.com>
>      md: fix data corruption for raid456 when reshape restart while grow up
> 
> Zhong Jinghua <zhongjinghua@huawei.com>
>      nbd: Add the maximum limit of allocated index in nbd_dev_add
> 
> Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
>      debugobjects: Recheck debug_objects_enabled before reporting
> 
> Eric Whitney <enwlinux@gmail.com>
>      ext4: correct inline offset when handling xattrs in inode body
> 
> Matus Gajdos <matuszpd@gmail.com>
>      ASoC: fsl_sai: Disable bit clock with transmitter
> 
> Jocelyn Falempe <jfalempe@redhat.com>
>      drm/client: Fix memory leak in drm_client_modeset_probe
> 
> Jocelyn Falempe <jfalempe@redhat.com>
>      drm/client: Fix memory leak in drm_client_target_cloned
> 
> YueHaibing <yuehaibing@huawei.com>
>      can: bcm: Fix UAF in bcm_proc_show()
> 
> Mark Brown <broonie@kernel.org>
>      regmap: Account for register length in SMBus I/O limits
> 
> Mark Brown <broonie@kernel.org>
>      regmap: Drop initial version of maximum transfer length fixes
> 
> Matthieu Baerts <matthieu.baerts@tessares.net>
>      selftests: tc: add 'ct' action kconfig dep
> 
> Matthieu Baerts <matthieu.baerts@tessares.net>
>      selftests: tc: set timeout to 15 minutes
> 
> Miklos Szeredi <mszeredi@redhat.com>
>      fuse: revalidate: don't invalidate if interrupted
> 
> Filipe Manana <fdmanana@suse.com>
>      btrfs: fix warning when putting transaction with qgroups enabled after abort
> 
> Georg Müller <georgmueller@gmx.net>
>      perf probe: Add test for regression introduced by switch to die_get_decl_file()
> 
> Petr Pavlu <petr.pavlu@suse.com>
>      keys: Fix linking a duplicate key to a keyring's assoc_array
> 
> Luka Guzenko <l.guzenko@web.de>
>      ALSA: hda/realtek: Enable Mute LED on HP Laptop 15s-eq2xxx
> 
> Kailang Yang <kailang@realtek.com>
>      ALSA: hda/realtek - remove 3k pull low procedure
> 
> Daniel Vetter <daniel.vetter@ffwll.ch>
>      drm/atomic: Fix potential use-after-free in nonblocking commits
> 
> Jason Gunthorpe <jgg@ziepe.ca>
>      RDMA/cma: Ensure rdma_addr_cancel() happens before issuing more requests
> 
> Pedro Tammela <pctammela@mojatatu.com>
>      net/sched: sch_qfq: reintroduce lmax bound check for MTU
> 
> Manish Rangankar <mrangankar@marvell.com>
>      scsi: qla2xxx: Remove unused nvme_ls_waitq wait queue
> 
> Shreyas Deodhar <sdeodhar@marvell.com>
>      scsi: qla2xxx: Pointer may be dereferenced
> 
> Bikash Hazarika <bhazarika@marvell.com>
>      scsi: qla2xxx: Correct the index of array
> 
> Nilesh Javali <njavali@marvell.com>
>      scsi: qla2xxx: Check valid rport returned by fc_bsg_to_rport()
> 
> Bikash Hazarika <bhazarika@marvell.com>
>      scsi: qla2xxx: Fix potential NULL pointer dereference
> 
> Quinn Tran <qutran@marvell.com>
>      scsi: qla2xxx: Fix buffer overrun
> 
> Nilesh Javali <njavali@marvell.com>
>      scsi: qla2xxx: Array index may go out of bound
> 
> Quinn Tran <qutran@marvell.com>
>      scsi: qla2xxx: Wait for io return on terminate rport
> 
> Masami Hiramatsu (Google) <mhiramat@kernel.org>
>      tracing/probes: Fix not to count error code to total length
> 
> Mateusz Stachyra <m.stachyra@samsung.com>
>      tracing: Fix null pointer dereference in tracing_err_log_open()
> 
> Max Filippov <jcmvbkbc@gmail.com>
>      xtensa: ISS: fix call to split_if_spec
> 
> Zheng Yejian <zhengyejian1@huawei.com>
>      ring-buffer: Fix deadloop issue on reading trace_pipe
> 
> Krister Johansen <kjlx@templeofstupid.com>
>      net: ena: fix shift-out-of-bounds in exponential backoff
> 
> Florent Revest <revest@chromium.org>
>      samples: ftrace: Save required argument registers in sample trampolines
> 
> Mohamed Khalfella <mkhalfella@purestorage.com>
>      tracing/histograms: Add histograms to hist_vars if they have referenced variables
> 
> Heiko Carstens <hca@linux.ibm.com>
>      s390/decompressor: fix misaligned symbol build error
> 
> Jiaqing Zhao <jiaqing.zhao@linux.intel.com>
>      Revert "8250: add support for ASIX devices with a FIFO bug"
> 
> George Stark <gnstark@sberdevices.ru>
>      meson saradc: fix clock divider mask length
> 
> Weitao Wang <WeitaoWang-oc@zhaoxin.com>
>      xhci: Show ZHAOXIN xHCI root hub speed correctly
> 
> Weitao Wang <WeitaoWang-oc@zhaoxin.com>
>      xhci: Fix TRB prefetch issue of ZHAOXIN hosts
> 
> Weitao Wang <WeitaoWang-oc@zhaoxin.com>
>      xhci: Fix resume issue of some ZHAOXIN hosts
> 
> Xiubo Li <xiubli@redhat.com>
>      ceph: don't let check_caps skip sending responses for revoke msgs
> 
> Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>      firmware: stratix10-svc: Fix a potential resource leak in svc_create_memory_pool()
> 
> Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>      tty: serial: samsung_tty: Fix a memory leak in s3c24xx_serial_getclk() when iterating clk
> 
> Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>      tty: serial: samsung_tty: Fix a memory leak in s3c24xx_serial_getclk() in case of error
> 
> Dan Carpenter <dan.carpenter@linaro.org>
>      serial: atmel: don't enable IRQs prematurely
> 
> Mario Limonciello <mario.limonciello@amd.com>
>      drm/amd/display: Correct `DMUB_FW_VERSION` macro
> 
> Brian Norris <briannorris@chromium.org>
>      drm/rockchip: vop: Leave vblank enabled in self-refresh
> 
> Brian Norris <briannorris@chromium.org>
>      drm/atomic: Allow vblank-enabled + self-refresh "disable"
> 
> Alexander Aring <aahringo@redhat.com>
>      fs: dlm: return positive pid value for F_GETLK
> 
> Jason Baron <jbaron@akamai.com>
>      md/raid0: add discard support for the 'original' layout
> 
> Damien Le Moal <dlemoal@kernel.org>
>      misc: pci_endpoint_test: Re-init completion for every test
> 
> Damien Le Moal <dlemoal@kernel.org>
>      misc: pci_endpoint_test: Free IRQs before removing the device
> 
> Damien Le Moal <dlemoal@kernel.org>
>      PCI: rockchip: Set address alignment for endpoint mode
> 
> Rick Wertenbroek <rick.wertenbroek@gmail.com>
>      PCI: rockchip: Use u32 variable to access 32-bit registers
> 
> Rick Wertenbroek <rick.wertenbroek@gmail.com>
>      PCI: rockchip: Fix legacy IRQ generation for RK3399 PCIe endpoint core
> 
> Rick Wertenbroek <rick.wertenbroek@gmail.com>
>      PCI: rockchip: Add poll and timeout to wait for PHY PLLs to be locked
> 
> Rick Wertenbroek <rick.wertenbroek@gmail.com>
>      PCI: rockchip: Write PCI Device ID to correct register
> 
> Rick Wertenbroek <rick.wertenbroek@gmail.com>
>      PCI: rockchip: Assert PCI Configuration Enable bit after probe
> 
> Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>      PCI: qcom: Disable write access to read only registers for IP v2.3.3
> 
> Robin Murphy <robin.murphy@arm.com>
>      PCI: Add function 1 DMA alias quirk for Marvell 88SE9235
> 
> Ondrej Zary <linux@zary.sk>
>      PCI/PM: Avoid putting EloPOS E2/S2/H2 PCIe Ports in D3cold
> 
> Martin Kaiser <martin@kaiser.cx>
>      hwrng: imx-rngc - fix the timeout for init and self check
> 
> Siddh Raman Pant <code@siddh.me>
>      jfs: jfs_dmap: Validate db_l2nbperpage while mounting
> 
> Baokun Li <libaokun1@huawei.com>
>      ext4: only update i_reserved_data_blocks on successful block allocation
> 
> Chao Yu <chao@kernel.org>
>      ext4: fix to check return value of freeze_bdev() in ext4_shutdown()
> 
> Kemeng Shi <shikemeng@huaweicloud.com>
>      ext4: fix wrong unit use in ext4_mb_new_blocks
> 
> Kemeng Shi <shikemeng@huaweicloud.com>
>      ext4: get block from bh in ext4_free_blocks for fast commit replay
> 
> Kemeng Shi <shikemeng@huaweicloud.com>
>      ext4: fix wrong unit use in ext4_mb_clear_bb
> 
> Zhihao Cheng <chengzhihao1@huawei.com>
>      ext4: Fix reusing stale buffer heads from last failed mounting
> 
> Huacai Chen <chenhuacai@loongson.cn>
>      MIPS: Loongson: Fix cpu_probe_loongson() again
> 
> Gao Xiang <hsiangkao@linux.alibaba.com>
>      erofs: fix compact 4B support for 16k block size
> 
> Ekansh Gupta <quic_ekangupt@quicinc.com>
>      misc: fastrpc: Create fastrpc scalar with correct buffer count
> 
> Naveen N Rao <naveen@kernel.org>
>      powerpc: Fail build if using recordmcount with binutils v2.37
> 
> Florian Fainelli <florian.fainelli@broadcom.com>
>      net: bcmgenet: Ensure MDIO unregistration has clocks enabled
> 
> Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>      mtd: rawnand: meson: fix unaligned DMA buffers handling
> 
> Jarkko Sakkinen <jarkko.sakkinen@tuni.fi>
>      tpm: tpm_vtpm_proxy: fix a race condition in /dev/vtpmx creation
> 
> Mario Limonciello <mario.limonciello@amd.com>
>      pinctrl: amd: Only use special debounce behavior for GPIO 0
> 
> Mario Limonciello <mario.limonciello@amd.com>
>      pinctrl: amd: Detect internal GPIO0 debounce handling
> 
> Mario Limonciello <mario.limonciello@amd.com>
>      pinctrl: amd: Fix mistake in handling clearing pins at startup
> 
> Chao Yu <chao@kernel.org>
>      f2fs: fix to avoid NULL pointer dereference f2fs_write_end_io()
> 
> Ming Lei <ming.lei@redhat.com>
>      nvme-pci: fix DMA direction of unmapping integrity data
> 
> Pedro Tammela <pctammela@mojatatu.com>
>      net/sched: sch_qfq: account for stab overhead in qfq_enqueue
> 
> Pedro Tammela <pctammela@mojatatu.com>
>      net/sched: sch_qfq: refactor parsing of netlink parameters
> 
> Pedro Tammela <pctammela@mojatatu.com>
>      net/sched: make psched_mtu() RTNL-less safe
> 
> Dan Carpenter <dan.carpenter@linaro.org>
>      netdevsim: fix uninitialized data in nsim_dev_trap_fa_cookie_write()
> 
> Ido Schimmel <idosch@nvidia.com>
>      net/sched: flower: Ensure both minimum and maximum ports are specified
> 
> Randy Dunlap <rdunlap@infradead.org>
>      wifi: airo: avoid uninitialized warning in airo_get_rate()
> 
> Chunhai Guo <guochunhai@vivo.com>
>      erofs: avoid infinite loop in z_erofs_do_read_page() when reading beyond EOF
> 
> Björn Töpel <bjorn@rivosinc.com>
>      riscv, bpf: Fix inconsistent JIT image generation
> 
> Pu Lehui <pulehui@huawei.com>
>      bpf, riscv: Support riscv jit to provide bpf_line_info
> 
> Jisheng Zhang <jszhang@kernel.org>
>      riscv: bpf: Avoid breaking W^X
> 
> Jisheng Zhang <jszhang@kernel.org>
>      riscv: bpf: Move bpf_jit_alloc_exec() and bpf_jit_free_exec() to core
> 
> Florian Kauer <florian.kauer@linutronix.de>
>      igc: Fix inserting of empty frame for launchtime
> 
> Florian Kauer <florian.kauer@linutronix.de>
>      igc: Fix launchtime before start of cycle
> 
> Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>      platform/x86: wmi: Break possible infinite loop when parsing GUID
> 
> Barnabás Pőcze <pobrn@protonmail.com>
>      platform/x86: wmi: move variables
> 
> Barnabás Pőcze <pobrn@protonmail.com>
>      platform/x86: wmi: use guid_t and guid_equal()
> 
> Barnabás Pőcze <pobrn@protonmail.com>
>      platform/x86: wmi: remove unnecessary argument
> 
> Ziyang Xuan <william.xuanziyang@huawei.com>
>      ipv6/addrconf: fix a potential refcount underflow for idev
> 
> Jiasheng Jiang <jiasheng@iscas.ac.cn>
>      NTB: ntb_tool: Add check for devm_kcalloc
> 
> Yang Yingliang <yangyingliang@huawei.com>
>      NTB: ntb_transport: fix possible memory leak while device_register() fails
> 
> Yuan Can <yuancan@huawei.com>
>      ntb: intel: Fix error handling in intel_ntb_pci_driver_init()
> 
> Yuan Can <yuancan@huawei.com>
>      NTB: amd: Fix error handling in amd_ntb_pci_driver_init()
> 
> Yuan Can <yuancan@huawei.com>
>      ntb: idt: Fix error handling in idt_pci_driver_init()
> 
> Eric Dumazet <edumazet@google.com>
>      udp6: fix udp6_ehashfn() typo
> 
> Kuniyuki Iwashima <kuniyu@amazon.com>
>      icmp6: Fix null-ptr-deref of ip6_null_entry->rt6i_idev in icmp6_dev().
> 
> Paolo Abeni <pabeni@redhat.com>
>      net: prevent skb corruption on frag list segmentation
> 
> Rafał Miłecki <rafal@milecki.pl>
>      net: bgmac: postpone turning IRQs off to avoid SoC hangs
> 
> Nitya Sunkad <nitya.sunkad@amd.com>
>      ionic: remove WARN_ON to prevent panic_on_warn
> 
> Junfeng Guo <junfeng.guo@intel.com>
>      gve: Set default duplex configuration to full
> 
> M A Ramdhan <ramdhan@starlabs.sg>
>      net/sched: cls_fw: Fix improper refcount update leads to use-after-free
> 
> Klaus Kudielka <klaus.kudielka@gmail.com>
>      net: mvneta: fix txq_map in case of txq_number==1
> 
> Dan Carpenter <dan.carpenter@linaro.org>
>      scsi: qla2xxx: Fix error code in qla2x00_start_sp()
> 
> Prasad Koya <prasad@arista.com>
>      igc: set TP bit in 'supported' and 'advertising' fields of ethtool_link_ksettings
> 
> Vlad Buslov <vladbu@nvidia.com>
>      net/mlx5e: Check for NOT_READY flag state after locking
> 
> Zhengchao Shao <shaozhengchao@huawei.com>
>      net/mlx5e: fix double free in mlx5e_destroy_flow_table
> 
> Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
>      igc: Remove delay during TX ring configuration
> 
> Marek Vasut <marex@denx.de>
>      drm/panel: simple: Add Powertip PH800480T013 drm_display_mode flags
> 
> Fabio Estevam <festevam@denx.de>
>      drm/panel: simple: Add connector_type for innolux_at043tn24
> 
> Linus Torvalds <torvalds@linux-foundation.org>
>      workqueue: clean up WORK_* constant types, clarify masking
> 
> Moritz Fischer <moritzf@google.com>
>      net: lan743x: Don't sleep in atomic context
> 
> Jens Axboe <axboe@kernel.dk>
>      io_uring: add reschedule point to handle_tw_list()
> 
> Andres Freund <andres@anarazel.de>
>      io_uring: Use io_schedule* in cqring wait
> 
> Michael Schmitz <schmitzmic@gmail.com>
>      block/partition: fix signedness issue for Amiga partitions
> 
> Paul E. McKenney <paulmck@kernel.org>
>      rcu-tasks: Simplify trc_read_check_handler() atomic operations
> 
> Paul E. McKenney <paulmck@kernel.org>
>      rcu-tasks: Mark ->trc_reader_special.b.need_qs data races
> 
> Paul E. McKenney <paulmck@kernel.org>
>      rcu-tasks: Mark ->trc_reader_nesting data races
> 
> Sherry Sun <sherry.sun@nxp.com>
>      tty: serial: fsl_lpuart: add earlycon for imx8ulp platform
> 
> Jason A. Donenfeld <Jason@zx2c4.com>
>      wireguard: netlink: send staged packets when setting initial private key
> 
> Jason A. Donenfeld <Jason@zx2c4.com>
>      wireguard: queueing: use saner cpu selection wrapping
> 
> Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
>      netfilter: nf_tables: prevent OOB access in nft_byteorder_eval
> 
> Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
>      netfilter: nf_tables: do not ignore genmask when looking up chain by id
> 
> Florent Revest <revest@chromium.org>
>      netfilter: conntrack: Avoid nf_ct_helper_hash uses after free
> 
> Florian Westphal <fw@strlen.de>
>      netfilter: nf_tables: fix scheduling-while-atomic splat
> 
> Pablo Neira Ayuso <pablo@netfilter.org>
>      netfilter: nf_tables: unbind non-anonymous set if rule construction fails
> 
> Pablo Neira Ayuso <pablo@netfilter.org>
>      netfilter: nf_tables: drop map element references from preparation phase
> 
> Pablo Neira Ayuso <pablo@netfilter.org>
>      netfilter: nftables: rename set element data activation/deactivation functions
> 
> Pablo Neira Ayuso <pablo@netfilter.org>
>      netfilter: nf_tables: reject unbound chain set before commit phase
> 
> Pablo Neira Ayuso <pablo@netfilter.org>
>      netfilter: nf_tables: reject unbound anonymous set before commit phase
> 
> Pablo Neira Ayuso <pablo@netfilter.org>
>      netfilter: nf_tables: add NFT_TRANS_PREPARE_ERROR to deal with bound set/chain
> 
> Pablo Neira Ayuso <pablo@netfilter.org>
>      netfilter: nf_tables: fix chain binding transaction logic
> 
> Pablo Neira Ayuso <pablo@netfilter.org>
>      netfilter: nf_tables: incorrect error path handling with NFT_MSG_NEWRULE
> 
> Florian Westphal <fw@strlen.de>
>      netfilter: nf_tables: add rescheduling points during loop detection walks
> 
> Florian Westphal <fw@strlen.de>
>      netfilter: nf_tables: use net_generic infra for transaction data
> 
> Geert Uytterhoeven <geert+renesas@glider.be>
>      sh: pgtable-3level: Fix cast to pointer from integer of different size
> 
> Michael Schmitz <schmitzmic@gmail.com>
>      block: add overflow checks for Amiga partition support
> 
> Gilad Reti <gilad.reti@gmail.com>
>      selftests/bpf: Add verifier test for PTR_TO_MEM spill
> 
> Lino Sanfilippo <l.sanfilippo@kunbus.com>
>      tpm, tpm_tis: Claim locality in interrupt handler
> 
> Amir Goldstein <amir73il@gmail.com>
>      fanotify: disallow mount/sb marks on kernel internal pseudo fs
> 
> Jan Kara <jack@suse.cz>
>      fs: no need to check source
> 
> Christian Marangi <ansuelsmth@gmail.com>
>      leds: trigger: netdev: Recheck NETDEV_LED_MODE_LINKUP on dev rename
> 
> Arnd Bergmann <arnd@arndb.de>
>      ARM: orion5x: fix d2net gpio initialization
> 
> Ricardo Ribalda Delgado <ribalda@chromium.org>
>      ASoC: mediatek: mt8173: Fix snd_soc_component_initialize error path
> 
> Ricardo Ribalda Delgado <ribalda@chromium.org>
>      ASoC: mediatek: mt8173: Fix irq error path
> 
> Filipe Manana <fdmanana@suse.com>
>      btrfs: fix race when deleting quota root from the dirty cow roots list
> 
> Matt Corallo <blnxfsl@bluematt.me>
>      btrfs: add handling for RAID1C23/DUP to btrfs_reduce_alloc_profile
> 
> Jan Kara <jack@suse.cz>
>      fs: Lock moved directories
> 
> Jan Kara <jack@suse.cz>
>      fs: Establish locking order for unrelated directories
> 
> Jan Kara <jack@suse.cz>
>      Revert "f2fs: fix potential corruption when moving a directory"
> 
> Jan Kara <jack@suse.cz>
>      ext4: Remove ext4 locking of moved directory
> 
> Thomas Weißschuh <linux@weissschuh.net>
>      fs: avoid empty option when generating legacy mount string
> 
> Fabian Frederick <fabf@skynet.be>
>      jffs2: reduce stack usage in jffs2_build_xattr_subsystem()
> 
> Roberto Sassu <roberto.sassu@huawei.com>
>      shmem: use ramfs_kill_sb() for kill_sb method of ramfs-based tmpfs
> 
> Arnd Bergmann <arnd@arndb.de>
>      autofs: use flexible array in ioctl structure
> 
> Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
>      integrity: Fix possible multiple allocation in integrity_inode_get()
> 
> Kees Cook <keescook@chromium.org>
>      um: Use HOST_DIR for mrproper
> 
> Zheng Wang <zyytlz.wz@163.com>
>      bcache: Fix __bch_btree_node_alloc to make the failure behavior consistent
> 
> Zheng Wang <zyytlz.wz@163.com>
>      bcache: Remove unnecessary NULL point check in node allocations
> 
> Mingzhe Zou <mingzhe.zou@easystack.cn>
>      bcache: fixup btree_cache_wait list damage
> 
> Chevron Li <chevron.li@bayhubtech.com>
>      mmc: sdhci: fix DMA configure compatibility issue when 64bit DMA mode is used.
> 
> Ulf Hansson <ulf.hansson@linaro.org>
>      mmc: mmci: Set PROBE_PREFER_ASYNCHRONOUS
> 
> Robert Marko <robimarko@gmail.com>
>      mmc: core: disable TRIM on Micron MTFC4GACAJCN-1M
> 
> Robert Marko <robimarko@gmail.com>
>      mmc: core: disable TRIM on Kingston EMMC04G-M627
> 
> Jens Axboe <axboe@kernel.dk>
>      io_uring: wait interruptibly for request completions on exit
> 
> Dai Ngo <dai.ngo@oracle.com>
>      NFSD: add encoding of op_recall flag for write delegation
> 
> Shuai Jiang <d202180596@hust.edu.cn>
>      i2c: qup: Add missing unwind goto in qup_i2c_probe()
> 
> Takashi Iwai <tiwai@suse.de>
>      ALSA: jack: Fix mutex call in snd_jack_report()
> 
> Robert Hancock <robert.hancock@calian.com>
>      i2c: xiic: Don't try to handle more interrupt events after error
> 
> Marek Vasut <marex@denx.de>
>      i2c: xiic: Defer xiic_wakeup() and __xiic_start_xfer() in xiic_process()
> 
> Danila Chernetsov <listdansp@mail.ru>
>      apparmor: fix missing error check for rhashtable_insert_fast
> 
> Artur Rojek <contact@artur-rojek.eu>
>      sh: dma: Fix DMA channel offset calculation
> 
> Thorsten Winkler <twinkler@linux.ibm.com>
>      s390/qeth: Fix vipa deletion
> 
> Vladimir Oltean <vladimir.oltean@nxp.com>
>      net: dsa: tag_sja1105: fix MAC DA patching from meta frames
> 
> Guillaume Nault <gnault@redhat.com>
>      pptp: Fix fib lookup calls.
> 
> Lin Ma <linma@zju.edu.cn>
>      net/sched: act_pedit: Add size check for TCA_PEDIT_PARMS_EX
> 
> Ilya Maximets <i.maximets@ovn.org>
>      xsk: Honor SO_BINDTODEVICE on bind
> 
> Eric Dumazet <edumazet@google.com>
>      tcp: annotate data races in __tcp_oow_rate_limited()
> 
> Vladimir Oltean <vladimir.oltean@nxp.com>
>      net: bridge: keep ports without IFF_UNICAST_FLT in BR_PROMISC mode
> 
> Randy Dunlap <rdunlap@infradead.org>
>      powerpc: allow PPC_EARLY_DEBUG_CPM only when SERIAL_CPM=y
> 
> Hariprasad Kelam <hkelam@marvell.com>
>      octeontx2-af: Fix mapping for NIX block from CGX connection
> 
> Chao Yu <chao@kernel.org>
>      f2fs: fix error path handling in truncate_dnode()
> 
> Nishanth Menon <nm@ti.com>
>      mailbox: ti-msgmgr: Fill non-message tx data fields with 0x0
> 
> Jonas Gorski <jonas.gorski@gmail.com>
>      spi: bcm-qspi: return error if neither hif_mspi nor mspi is available
> 
> Pawel Dembicki <paweldembicki@gmail.com>
>      net: dsa: vsc73xx: fix MTU configuration
> 
> Tobias Heider <me@tobhe.de>
>      Add MODULE_FIRMWARE() for FIRMWARE_TG357766.
> 
> Chengfeng Ye <dg573847474@gmail.com>
>      sctp: fix potential deadlock on &net->sctp.addr_wq_lock
> 
> Randy Dunlap <rdunlap@infradead.org>
>      media: cec: i2c: ch7322: also select REGMAP
> 
> Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>      rtc: st-lpc: Release some resources in st_rtc_probe() in case of error
> 
> Marek Vasut <marex@denx.de>
>      pwm: sysfs: Do not apply state to already disabled PWMs
> 
> Fancy Fang <chen.fang@nxp.com>
>      pwm: imx-tpm: force 'real_period' to be zero in suspend
> 
> Claudiu Beznea <claudiu.beznea@microchip.com>
>      phy: tegra: xusb: check return value of devm_kzalloc()
> 
> Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>      mfd: stmpe: Only disable the regulators if they are enabled
> 
> Pierre Morel <pmorel@linux.ibm.com>
>      KVM: s390: vsie: fix the length of APCB bitmap
> 
> Amelie Delaunay <amelie.delaunay@foss.st.com>
>      mfd: stmfx: Nullify stmfx->vdd in case of error
> 
> Amelie Delaunay <amelie.delaunay@foss.st.com>
>      mfd: stmfx: Fix error path in stmfx_chip_init
> 
> Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
>      test_firmware: return ENOMEM instead of ENOSPC on failed memory allocation
> 
> Tony Lindgren <tony@atomide.com>
>      serial: 8250_omap: Use force_suspend and resume for system suspend
> 
> Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>      Revert "usb: common: usb-conn-gpio: Set last role to unknown before initial detection"
> 
> Jiasheng Jiang <jiasheng@iscas.ac.cn>
>      mfd: intel-lpss: Add missing check for platform_get_resource
> 
> Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>      usb: dwc3-meson-g12a: Fix an error handling path in dwc3_meson_g12a_probe()
> 
> Prashanth K <quic_prashk@quicinc.com>
>      usb: common: usb-conn-gpio: Set last role to unknown before initial detection
> 
> Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>      usb: dwc3: qcom: Fix an error handling path in dwc3_qcom_probe()
> 
> Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>      usb: dwc3: qcom: Release the correct resources in dwc3_qcom_remove()
> 
> Nico Boehr <nrb@linux.ibm.com>
>      KVM: s390: fix KVM_S390_GET_CMMA_BITS for GFNs in memslot holes
> 
> Dan Carpenter <dan.carpenter@linaro.org>
>      media: atomisp: gmin_platform: fix out_len in gmin_get_config_dsm_var()
> 
> Rikard Falkeborn <rikard.falkeborn@gmail.com>
>      media: venus: helpers: Fix ALIGN() of non power of two
> 
> Stephan Gerhold <stephan@gerhold.net>
>      mfd: rt5033: Drop rt5033-battery sub-device
> 
> James Clark <james.clark@arm.com>
>      coresight: Fix loss of connection info when a module is unloaded
> 
> Muchun Song <songmuchun@bytedance.com>
>      kernfs: fix missing kernfs_idr_lock to remove an ID from the IDR
> 
> John Ogness <john.ogness@linutronix.de>
>      serial: 8250: lock port for UART_IER access in omap8250_irq()
> 
> John Ogness <john.ogness@linutronix.de>
>      serial: 8250: lock port for stop_rx() in omap8250_irq()
> 
> Arnd Bergmann <arnd@arndb.de>
>      usb: hide unused usbfs_notify_suspend/resume functions
> 
> Li Yang <lidaxian@hust.edu.cn>
>      usb: phy: phy-tahvo: fix memory leak in tahvo_usb_probe()
> 
> Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>      extcon: Fix kernel doc of property capability fields to avoid warnings
> 
> Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>      extcon: Fix kernel doc of property fields to avoid warnings
> 
> Prashanth K <quic_prashk@quicinc.com>
>      usb: gadget: u_serial: Add null pointer check in gserial_suspend
> 
> Vladislav Efanov <VEfanov@ispras.ru>
>      usb: dwc3: qcom: Fix potential memory leak
> 
> Robert Marko <robimarko@gmail.com>
>      clk: qcom: ipq6018: fix networking resets
> 
> Robert Marko <robimarko@gmail.com>
>      clk: qcom: reset: support resetting multiple bits
> 
> Stephan Gerhold <stephan.gerhold@kernkonzept.com>
>      clk: qcom: reset: Allow specifying custom reset delay
> 
> Duoming Zhou <duoming@zju.edu.cn>
>      media: usb: siano: Fix warning due to null work_func_t function pointer
> 
> Marek Vasut <marex@denx.de>
>      media: videodev2.h: Fix struct v4l2_input tuner index comment
> 
> Daniil Dulov <d.dulov@aladdin.ru>
>      media: usb: Check az6007_read() return value
> 
> Mantas Pucka <mantas@8devices.com>
>      clk: qcom: gcc-ipq6018: Use floor ops for sdcc clocks
> 
> Tony Lindgren <tony@atomide.com>
>      serial: 8250: omap: Fix freeing of resources on failed register
> 
> John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
>      sh: j2: Use ioremap() to translate device tree address into kernel memory
> 
> Dan Carpenter <dan.carpenter@oracle.com>
>      w1: fix loop in w1_fini()
> 
> Stefan Wahren <stefan.wahren@i2se.com>
>      w1: w1_therm: fix locking behavior in convert_t
> 
> Ding Hui <dinghui@sangfor.com.cn>
>      SUNRPC: Fix UAF in svc_tcp_listen_data_ready()
> 
> Michael Schmitz <schmitzmic@gmail.com>
>      block: change all __u32 annotations to __be32 in affs_hardblocks.h
> 
> Michael Schmitz <schmitzmic@gmail.com>
>      block: fix signed int overflow in Amiga partition support
> 
> EJ Hsu <ejh@nvidia.com>
>      phy: tegra: xusb: Clear the driver reference in usb-phy dev
> 
> Krishna Kurapati <quic_kriskura@quicinc.com>
>      usb: dwc3: gadget: Propagate core init errors to UDC during pullup
> 
> Davide Tronchin <davide.tronchin.94@gmail.com>
>      USB: serial: option: add LARA-R6 01B PIDs
> 
> Jens Axboe <axboe@kernel.dk>
>      io_uring: ensure IOPOLL locks around deferred work
> 
> Martin Kaiser <martin@kaiser.cx>
>      hwrng: st - keep clock enabled while hwrng is registered
> 
> Dan Williams <dan.j.williams@intel.com>
>      dax: Introduce alloc_dev_dax_id()
> 
> Dan Williams <dan.j.williams@intel.com>
>      dax: Fix dax_mapping_release() use after free
> 
> Olga Kornievskaia <kolga@netapp.com>
>      NFSv4.1: freeze the session table upon receiving NFS4ERR_BADSESSION
> 
> Masahiro Yamada <masahiroy@kernel.org>
>      ARC: define ASM_NL and __ALIGN(_STR) outside #ifdef __ASSEMBLY__ guard
> 
> Dan Carpenter <dan.carpenter@linaro.org>
>      modpost: fix off by one in is_executable_section()
> 
> Arnd Bergmann <arnd@arndb.de>
>      crypto: marvell/cesa - Fix type mismatch warning
> 
> Masahiro Yamada <masahiroy@kernel.org>
>      modpost: fix section mismatch message for R_ARM_{PC24,CALL,JUMP24}
> 
> Masahiro Yamada <masahiroy@kernel.org>
>      modpost: fix section mismatch message for R_ARM_ABS32
> 
> Randy Dunlap <rdunlap@infradead.org>
>      crypto: nx - fix build warnings when DEBUG_FS is not enabled
> 
> Herbert Xu <herbert@gondor.apana.org.au>
>      hwrng: virtio - Fix race on data_avail and actual data
> 
> Laurent Vivier <lvivier@redhat.com>
>      hwrng: virtio - always add a pending request
> 
> Laurent Vivier <lvivier@redhat.com>
>      hwrng: virtio - don't waste entropy
> 
> Laurent Vivier <lvivier@redhat.com>
>      hwrng: virtio - don't wait on cleanup
> 
> Laurent Vivier <lvivier@redhat.com>
>      hwrng: virtio - add an internal buffer
> 
> Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>      powerpc/mm/dax: Fix the condition when checking if altmap vmemap can cross-boundary
> 
> Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>      powerpc/book3s64/mm: Fix DirectMap stats in /proc/meminfo
> 
> Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>      mm: rename p4d_page_vaddr to p4d_pgtable and make it return pud_t *
> 
> Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>      mm: rename pud_page_vaddr to pud_pgtable and make it return pmd_t *
> 
> Colin Ian King <colin.i.king@gmail.com>
>      powerpc/powernv/sriov: perform null check on iov before dereferencing iov
> 
> Claudiu Beznea <claudiu.beznea@microchip.com>
>      pinctrl: at91-pio4: check return value of devm_kasprintf()
> 
> Namhyung Kim <namhyung@kernel.org>
>      perf dwarf-aux: Fix off-by-one in die_get_varname()
> 
> Arnaldo Carvalho de Melo <acme@redhat.com>
>      perf script: Fix allocation of evsel->priv related to per-event dump files
> 
> Arnaldo Carvalho de Melo <acme@redhat.com>
>      perf script: Fixup 'struct evsel_script' method prefix
> 
> Christophe Leroy <christophe.leroy@csgroup.eu>
>      kcsan: Don't expect 64 bits atomic builtins from 32 bits architectures
> 
> Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>      pinctrl: cherryview: Return correct value if pin in push-pull mode
> 
> Arnaldo Carvalho de Melo <acme@redhat.com>
>      perf bench: Add missing setlocale() call to allow usage of %'d style formatting
> 
> Sohaib Mohamed <sohaib.amhmd@gmail.com>
>      perf bench: Use unbuffered output when pipe/tee'ing to a file
> 
> Sui Jingfeng <suijingfeng@loongson.cn>
>      PCI: Add pci_clear_master() stub for non-CONFIG_PCI
> 
> Junyan Ye <yejunyan@hust.edu.cn>
>      PCI: ftpci100: Release the clock resources
> 
> Rongguang Wei <weirongguang@kylinos.cn>
>      PCI: pciehp: Cancel bringup sequence if card is not present
> 
> Yuchen Yang <u202114568@hust.edu.cn>
>      scsi: 3w-xxxx: Add error handling for initialization failure in tw_probe()
> 
> Ding Hui <dinghui@sangfor.com.cn>
>      PCI/ASPM: Disable ASPM on MFD function removal to avoid use-after-free
> 
> Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>      pinctrl: bcm2835: Handle gpiochip_add_pin_range() errors
> 
> Jinhong Zhu <jinhongzhu@hust.edu.cn>
>      scsi: qedf: Fix NULL dereference in error handling
> 
> Siddharth Vadapalli <s-vadapalli@ti.com>
>      PCI: cadence: Fix Gen2 Link Retraining process
> 
> Claudiu Beznea <claudiu.beznea@microchip.com>
>      ASoC: imx-audmix: check return value of devm_kasprintf()
> 
> Amir Goldstein <amir73il@gmail.com>
>      ovl: update of dentry revalidate flags after copy up
> 
> Alexey Romanov <avromanov@sberdevices.ru>
>      drivers: meson: secure-pwrc: always enable DMA domain
> 
> Claudiu Beznea <claudiu.beznea@microchip.com>
>      clk: ti: clkctrl: check return value of kasprintf()
> 
> Claudiu Beznea <claudiu.beznea@microchip.com>
>      clk: keystone: sci-clk: check return value of kasprintf()
> 
> Claudiu Beznea <claudiu.beznea@microchip.com>
>      clk: si5341: free unused memory on probe failure
> 
> Claudiu Beznea <claudiu.beznea@microchip.com>
>      clk: si5341: check return value of {devm_}kasprintf()
> 
> Claudiu Beznea <claudiu.beznea@microchip.com>
>      clk: si5341: return error if one synth clock registration fails
> 
> Robert Hancock <robert.hancock@calian.com>
>      clk: si5341: Add sysfs properties to allow checking/resetting device faults
> 
> Robert Hancock <robert.hancock@calian.com>
>      clk: si5341: Allow different output VDD_SEL values
> 
> Claudiu Beznea <claudiu.beznea@microchip.com>
>      clk: cdce925: check return value of kasprintf()
> 
> Claudiu Beznea <claudiu.beznea@microchip.com>
>      clk: vc5: check memory returned by kasprintf()
> 
> Bjorn Andersson <quic_bjorande@quicinc.com>
>      drm/msm/dp: Free resources after unregistering them
> 
> Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>      drm/msm/dpu: do not enable color-management if DSPPs are not available
> 
> Su Hui <suhui@nfschina.com>
>      ALSA: ac97: Fix possible NULL dereference in snd_ac97_mixer
> 
> Yuan Can <yuancan@huawei.com>
>      clk: tegra: tegra124-emc: Fix potential memory leak
> 
> Yuxing Liu <lyx2022@hust.edu.cn>
>      clk: imx: clk-imx8mp: improve error handling in imx8mp_clocks_probe()
> 
> Hao Luo <m202171776@hust.edu.cn>
>      clk: imx: clk-imx8mn: fix memory leak in imx8mn_clocks_probe
> 
> Kashyap Desai <kashyap.desai@broadcom.com>
>      RDMA/bnxt_re: Avoid calling wake_up threads from spin_lock context
> 
> Kashyap Desai <kashyap.desai@broadcom.com>
>      RDMA/bnxt_re: wraparound mbox producer index
> 
> Chia-I Wu <olvaffe@gmail.com>
>      amdgpu: validate offset_in_bo of drm_amdgpu_gem_va
> 
> Nikita Zhandarovich <n.zhandarovich@fintech.ru>
>      drm/radeon: fix possible division-by-zero errors
> 
> Daniil Dulov <d.dulov@aladdin.ru>
>      drm/amdkfd: Fix potential deallocation of previously deallocated memory.
> 
> Christian Lamparter <chunkeey@gmail.com>
>      ARM: dts: BCM5301X: fix duplex-full => full-duplex
> 
> Guenter Roeck <linux@roeck-us.net>
>      hwmon: (pmbus/adm1275) Fix problems with temperature monitoring on ADM1272
> 
> Potin Lai <potin.lai@quantatw.com>
>      hwmon: (adm1275) Allow setting sample averaging
> 
> Chu Lin <linchuyuan@google.com>
>      hwmon: (adm1275) enable adm1272 temperature reporting
> 
> Tim Harvey <tharvey@gateworks.com>
>      hwmon: (gsc-hwmon) fix fan pwm temperature scaling
> 
> Olivier Moysan <olivier.moysan@foss.st.com>
>      ARM: dts: stm32: fix i2s endpoint format property for stm32mp15xx-dkx
> 
> Marek Vasut <marex@denx.de>
>      ARM: dts: stm32: Fix audio routing on STM32MP15xx DHCOM PDK2
> 
> Keerthy <j-keerthy@ti.com>
>      arm64: dts: ti: k3-j7200: Fix physical address of pin
> 
> Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>      fbdev: omapfb: lcd_mipid: Fix an error handling path in mipid_spi_probe()
> 
> Wolfram Sang <wsa+renesas@sang-engineering.com>
>      arm64: dts: renesas: ulcb-kf: Remove flow control for SCIF1
> 
> Geert Uytterhoeven <geert+renesas@glider.be>
>      ARM: dts: iwg20d-q7-common: Fix backlight pwm specifier
> 
> Chengchang Tang <tangchengchang@huawei.com>
>      RDMA/hns: Fix hns_roce_table_get return value
> 
> Xi Wang <wangxi11@huawei.com>
>      RDMA/hns: Clean the hardware related code for HEM
> 
> Weihang Li <liweihang@huawei.com>
>      RDMA/hns: Use refcount_t APIs for HEM
> 
> Lang Cheng <chenglang@huawei.com>
>      RDMA/hns: Fix coding style issues
> 
> Jason Gunthorpe <jgg@ziepe.ca>
>      RDMA: Remove uverbs_ex_cmd_mask values that are linked to functions
> 
> Brendan Cunningham <bcunningham@cornelisnetworks.com>
>      IB/hfi1: Fix wrong mmu_node used for user SDMA packet after invalidate
> 
> Patrick Kelsey <pat.kelsey@cornelisnetworks.com>
>      IB/hfi1: Fix sdma.h tx->num_descs off-by-one errors
> 
> Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>      IB/hfi1: Use bitmap_zalloc() when applicable
> 
> Randy Dunlap <rdunlap@infradead.org>
>      soc/fsl/qe: fix usb.c build errors
> 
> Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>      ARM: dts: meson8: correct uart_B and uart_C clock references
> 
> Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
>      ASoC: es8316: Do not set rate constraints for unsupported MCLKs
> 
> Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
>      ASoC: es8316: Increment max value for ALC Capture Target Volume control
> 
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>      memory: brcmstb_dpfe: fix testing array offset after use
> 
> Marek Vasut <marex@denx.de>
>      ARM: dts: stm32: Shorten the AV96 HDMI sound card name
> 
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>      arm64: dts: qcom: apq8096: fix fixed regulator name property
> 
> Arnd Bergmann <arnd@arndb.de>
>      ARM: omap2: fix missing tick_broadcast() prototype
> 
> Arnd Bergmann <arnd@arndb.de>
>      ARM: ep93xx: fix missing-prototype warnings
> 
> Dario Binacchi <dario.binacchi@amarulasolutions.com>
>      drm/panel: simple: fix active size for Ampire AM-480272H3TMQW-T01H
> 
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>      arm64: dts: qcom: msm8996: correct camss unit address
> 
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>      arm64: dts: qcom: msm8994: correct SPMI unit address
> 
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>      arm64: dts: qcom: msm8916: correct camss unit address
> 
> Tony Lindgren <tony@atomide.com>
>      ARM: dts: gta04: Move model property out of pinctrl node
> 
> Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
>      RDMA/bnxt_re: Fix to remove an unnecessary log
> 
> Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
>      RDMA/bnxt_re: Remove a redundant check inside bnxt_re_update_gid
> 
> Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
>      RDMA/bnxt_re: Use unique names while registering interrupts
> 
> Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
>      RDMA/bnxt_re: Fix to remove unnecessary return labels
> 
> Selvin Xavier <selvin.xavier@broadcom.com>
>      RDMA/bnxt_re: Disable/kill tasklet only if it is enabled
> 
> Robert Marko <robert.marko@sartura.hr>
>      arm64: dts: microchip: sparx5: do not use PSCI on reference boards
> 
> Tony Lindgren <tony@atomide.com>
>      bus: ti-sysc: Fix dispc quirk masking bool variables
> 
> Marek Vasut <marex@denx.de>
>      ARM: dts: stm32: Move ethernet MAC EEPROM from SoM to carrier boards
> 
> Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>      drm/panel: sharp-ls043t1le01: adjust mode settings
> 
> XuDong Liu <m202071377@hust.edu.cn>
>      drm: sun4i_tcon: use devm_clk_get_enabled in `sun4i_tcon_init_clocks`
> 
> Marek Vasut <marex@denx.de>
>      Input: adxl34x - do not hardcode interrupt trigger type
> 
> hfdevel@gmx.net <hfdevel@gmx.net>
>      ARM: dts: meson8b: correct uart_B and uart_C clock references
> 
> Rafał Miłecki <rafal@milecki.pl>
>      ARM: dts: BCM5301X: Drop "clock-names" from the SPI node
> 
> Luc Ma <luc@sietium.com>
>      drm/vram-helper: fix function names in vram helper doc
> 
> Francesco Dolcini <francesco.dolcini@toradex.com>
>      drm/bridge: tc358768: fix THS_TRAILCNT computation
> 
> Francesco Dolcini <francesco.dolcini@toradex.com>
>      drm/bridge: tc358768: fix TXTAGOCNT computation
> 
> Francesco Dolcini <francesco.dolcini@toradex.com>
>      drm/bridge: tc358768: fix THS_ZEROCNT computation
> 
> Francesco Dolcini <francesco.dolcini@toradex.com>
>      drm/bridge: tc358768: fix TCLK_TRAILCNT computation
> 
> Francesco Dolcini <francesco.dolcini@toradex.com>
>      drm/bridge: tc358768: Add atomic_get_input_bus_fmts() implementation
> 
> Francesco Dolcini <francesco.dolcini@toradex.com>
>      drm/bridge: tc358768: fix TCLK_ZEROCNT computation
> 
> Francesco Dolcini <francesco.dolcini@toradex.com>
>      drm/bridge: tc358768: fix PLL target frequency
> 
> Francesco Dolcini <francesco.dolcini@toradex.com>
>      drm/bridge: tc358768: fix PLL parameters computation
> 
> Francesco Dolcini <francesco.dolcini@toradex.com>
>      drm/bridge: tc358768: always enable HS video mode
> 
> Luca Weiss <luca@z3ntu.xyz>
>      Input: drv260x - sleep between polling GO bit
> 
> Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
>      drm/amd/display: Explicitly specify update type per plane info change
> 
> Nikita Zhandarovich <n.zhandarovich@fintech.ru>
>      radeon: avoid double free in ci_dpm_init()
> 
> Kuniyuki Iwashima <kuniyu@amazon.com>
>      netlink: Add __sock_i_ino() for __netlink_diag_dump().
> 
> Cambda Zhu <cambda@linux.alibaba.com>
>      ipvlan: Fix return value of ipvlan_queue_xmit()
> 
> Ilia.Gavrilov <Ilia.Gavrilov@infotecs.ru>
>      netfilter: nf_conntrack_sip: fix the ct_sip_parse_numerical_param() return value.
> 
> Florian Westphal <fw@strlen.de>
>      netfilter: conntrack: dccp: copy entire header to stack buffer, not just basic one
> 
> Jeremy Sowden <jeremy@azazel.net>
>      lib/ts_bm: reset initial match offset for every block of text
> 
> Lin Ma <linma@zju.edu.cn>
>      net: nfc: Fix use-after-free caused by nfc_llcp_find_local
> 
> Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>      nfc: llcp: simplify llcp_sock_connect() error paths
> 
> Edward Cree <ecree.xilinx@gmail.com>
>      sfc: fix crash when reading stats while NIC is resetting
> 
> Maxim Kochetkov <fido_max@inbox.ru>
>      net: axienet: Move reset before 64-bit DMA detection
> 
> Kuniyuki Iwashima <kuniyu@amazon.com>
>      gtp: Fix use-after-free in __gtp_encap_destroy().
> 
> Sabrina Dubroca <sd@queasysnail.net>
>      selftests: rtnetlink: remove netdevsim device after ipsec offload test
> 
> Eric Dumazet <edumazet@google.com>
>      netlink: do not hard code device address lenth in fdb dumps
> 
> Eric Dumazet <edumazet@google.com>
>      netlink: fix potential deadlock in netlink_set_err()
> 
> Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>      net: stmmac: fix double serdes powerdown
> 
> Vinicius Costa Gomes <vinicius.gomes@intel.com>
>      igc: Fix race condition in PTP tx code
> 
> Dmitry Antipov <dmantipov@yandex.ru>
>      wifi: ath9k: convert msecs to jiffies where needed
> 
> Benjamin Berg <benjamin.berg@intel.com>
>      wifi: cfg80211: rewrite merging of inherited elements
> 
> Johannes Berg <johannes.berg@intel.com>
>      wifi: iwlwifi: pull from TXQs with softirqs disabled
> 
> Edwin Peer <edwin.peer@broadcom.com>
>      rtnetlink: extend RTEXT_FILTER_SKIP_STATS to IFLA_VF_INFO
> 
> Remi Pommarel <repk@triplefau.lt>
>      wifi: ath9k: Fix possible stall on ath9k_txq_list_has_key()
> 
> Arnd Bergmann <arnd@arndb.de>
>      memstick r592: make memstick_debug_get_tpc_name() static
> 
> Zhen Lei <thunder.leizhen@huawei.com>
>      kexec: fix a memory leak in crash_shrink_memory()
> 
> Douglas Anderson <dianders@chromium.org>
>      watchdog/perf: more properly prevent false positives with turbo modes
> 
> Douglas Anderson <dianders@chromium.org>
>      watchdog/perf: define dummy watchdog_update_hrtimer_threshold() on correct config
> 
> Marek Vasut <marex@denx.de>
>      wifi: rsi: Do not set MMC_PM_KEEP_POWER in shutdown
> 
> Marek Vasut <marex@denx.de>
>      wifi: rsi: Do not configure WoWlan in shutdown hook if not enabled
> 
> Fedor Pchelkin <pchelkin@ispras.ru>
>      wifi: ath9k: don't allow to overwrite ENDPOINT0 attributes
> 
> Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>      wifi: ray_cs: Fix an error handling path in ray_probe()
> 
> Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>      wifi: ray_cs: Drop useless status variable in parse_addr()
> 
> Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>      wifi: ray_cs: Utilize strnlen() in parse_addr()
> 
> Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>      wifi: wl3501_cs: Fix an error handling path in wl3501_probe()
> 
> Jakub Kicinski <kuba@kernel.org>
>      wl3501_cs: use eth_hw_addr_set()
> 
> Jakub Kicinski <kuba@kernel.org>
>      net: create netdev->dev_addr assignment helpers
> 
> Lee Jones <lee.jones@linaro.org>
>      wl3501_cs: Fix misspelling and provide missing documentation
> 
> Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>      wifi: atmel: Fix an error handling path in atmel_probe()
> 
> Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>      wifi: orinoco: Fix an error handling path in orinoco_cs_probe()
> 
> Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>      wifi: orinoco: Fix an error handling path in spectrum_cs_probe()
> 
> Geert Uytterhoeven <geert+renesas@glider.be>
>      regulator: core: Streamline debugfs operations
> 
> Geert Uytterhoeven <geert+renesas@glider.be>
>      regulator: core: Fix more error checking for debugfs_create_dir()
> 
> Alan Maguire <alan.maguire@oracle.com>
>      bpftool: JIT limited misreported as negative value on aarch64
> 
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>      nfc: llcp: fix possible use of uninitialized variable in nfc_llcp_send_connect()
> 
> Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>      nfc: constify several pointers to u8, char and sk_buff
> 
> Andrii Nakryiko <andrii@kernel.org>
>      libbpf: fix offsetof() and container_of() to work with CO-RE
> 
> Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
>      sctp: add bpf_bypass_getsockopt proto callback
> 
> Stanislav Fomichev <sdf@google.com>
>      bpf: Remove extra lock_sock for TCP_ZEROCOPY_RECEIVE
> 
> Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>      wifi: mwifiex: Fix the size of a memory allocation in mwifiex_ret_802_11_scan()
> 
> Amisha Patel <amisha.patel@microchip.com>
>      wifi: wilc1000: fix for absent RSN capabilities WFA testcase
> 
> Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
>      spi: spi-geni-qcom: Correct CS_TOGGLE bit in SPI_TRANS_CFG
> 
> Pengcheng Yang <yangpc@wangsu.com>
>      samples/bpf: Fix buffer overflow in tcp_basertt
> 
> Fedor Pchelkin <pchelkin@ispras.ru>
>      wifi: ath9k: avoid referencing uninit memory in ath9k_wmi_ctrl_rx
> 
> Peter Seiderer <ps.report@gmx.net>
>      wifi: ath9k: fix AR9003 mac hardware hang check register offset calculation
> 
> Jesper Dangaard Brouer <brouer@redhat.com>
>      igc: Enable and fix RX hash usage by netstack
> 
> Jiasheng Jiang <jiasheng@iscas.ac.cn>
>      pstore/ram: Add check for kstrdup
> 
> Roberto Sassu <roberto.sassu@huawei.com>
>      ima: Fix build warnings
> 
> Roberto Sassu <roberto.sassu@huawei.com>
>      evm: Complete description of evm_inode_setattr()
> 
> Juergen Gross <jgross@suse.com>
>      x86/mm: Fix __swp_entry_to_pte() for Xen PV guests
> 
> Ravi Bangoria <ravi.bangoria@amd.com>
>      perf/ibs: Fix interface via core pmu events
> 
> Qiuxu Zhuo <qiuxu.zhuo@intel.com>
>      rcu/rcuscale: Stop kfree_scale_thread thread(s) after unloading rcuscale
> 
> Qiuxu Zhuo <qiuxu.zhuo@intel.com>
>      rcu/rcuscale: Move rcu_scale_*() after kfree_scale_cleanup()
> 
> Paul E. McKenney <paulmck@kernel.org>
>      rcuscale: Move shutdown from wait_event() to wait_event_idle()
> 
> Li Zhijian <zhijianx.li@intel.com>
>      rcuscale: Always log error message
> 
> Jiangong.Han <jiangong.han@windriver.com>
>      rcuscale: Console output claims too few grace periods
> 
> Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>      thermal/drivers/sun8i: Fix some error handling paths in sun8i_ths_probe()
> 
> Tero Kristo <tero.kristo@linux.intel.com>
>      cpufreq: intel_pstate: Fix energy_performance_preference for passive
> 
> Arnd Bergmann <arnd@arndb.de>
>      ARM: 9303/1: kprobes: avoid missing-declaration warnings
> 
> Zhang Rui <rui.zhang@intel.com>
>      powercap: RAPL: Fix CONFIG_IOSF_MBI dependency
> 
> Robin Murphy <robin.murphy@arm.com>
>      perf/arm-cmn: Fix DTC reset
> 
> Nikita Zhandarovich <n.zhandarovich@fintech.ru>
>      PM: domains: fix integer overflow issues in genpd_parse_state()
> 
> Feng Mingxi <m202271825@hust.edu.cn>
>      clocksource/drivers/cadence-ttc: Fix memory leak in ttc_timer_probe
> 
> Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>      tracing/timer: Add missing hrtimer modes to decode_hrtimer_mode().
> 
> Thomas Gleixner <tglx@linutronix.de>
>      posix-timers: Prevent RT livelock in itimer_delete()
> 
> John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
>      irqchip/jcore-aic: Fix missing allocation of IRQ descriptors
> 
> Marc Zyngier <maz@kernel.org>
>      irqchip/jcore-aic: Kill use of irq_create_strict_mappings()
> 
> Li Nan <linan122@huawei.com>
>      md/raid10: fix io loss while replacement replace rdev
> 
> Li Nan <linan122@huawei.com>
>      md/raid10: fix null-ptr-deref of mreplace in raid10_sync_request
> 
> Li Nan <linan122@huawei.com>
>      md/raid10: fix wrong setting of max_corr_read_errors
> 
> Li Nan <linan122@huawei.com>
>      md/raid10: fix overflow of md/safe_mode_delay
> 
> Li Nan <linan122@huawei.com>
>      md/raid10: check slab-out-of-bounds in md_bitmap_get_counter
> 
> Li Nan <linan122@huawei.com>
>      blk-iocost: use spin_lock_irqsave in adjust_inuse_and_calc_cost
> 
> Shawn Wang <shawnwang@linux.alibaba.com>
>      x86/resctrl: Only show tasks' pid in current pid namespace
> 
> Arnd Bergmann <arnd@arndb.de>
>      fs: pipe: reveal missing function protoypes
> 
> Finn Thain <fthain@linux-m68k.org>
>      nubus: Partially revert proc_create_single_data() conversion
> 
> Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
>      drm/amdgpu: Validate VM ioctl flags.
> 
> Ahmed S. Darwish <darwi@linutronix.de>
>      scripts/tags.sh: Resolve gtags empty index generation
> 
> Ricardo Cañuelo <ricardo.canuelo@collabora.com>
>      Revert "thermal/drivers/mediatek: Use devm_of_iomap to avoid resource leak in mtk_thermal_probe"
> 
> Mike Hommey <mh@glandium.org>
>      HID: logitech-hidpp: add HIDPP_QUIRK_DELAYED_INIT for the T651.
> 
> Jason Gerecke <jason.gerecke@wacom.com>
>      HID: wacom: Use ktime_t rather than int when dealing with timestamps
> 
> Zheng Wang <zyytlz.wz@163.com>
>      fbdev: imsttfb: Fix use after free bug in imsttfb_probe
> 
> Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>      video: imsttfb: check for ioremap() failures
> 
> Oliver Hartkopp <socketcan@hartkopp.net>
>      can: isotp: isotp_sendmsg(): fix return error fix on TX path
> 
> Thomas Gleixner <tglx@linutronix.de>
>      x86/smp: Use dedicated cache-line for mwait_play_dead()
> 
> Tsuchiya Yuto <kitakar@gmail.com>
>      media: atomisp: fix "variable dereferenced before check 'asd'"
> 
> 
> -------------
> 
> Diffstat:
> 
>   Documentation/filesystems/autofs-mount-control.rst |   2 +-
>   Documentation/filesystems/autofs.rst               |   2 +-
>   Documentation/filesystems/directory-locking.rst    |  26 +-
>   Documentation/networking/af_xdp.rst                |   9 +
>   Documentation/networking/ip-sysctl.rst             |  25 +
>   Makefile                                           |   4 +-
>   arch/alpha/include/asm/pgtable.h                   |   8 +-
>   arch/arc/include/asm/linkage.h                     |   8 +-
>   arch/arm/boot/dts/bcm53015-meraki-mr26.dts         |   2 +-
>   arch/arm/boot/dts/bcm53016-meraki-mr32.dts         |   2 +-
>   arch/arm/boot/dts/bcm5301x.dtsi                    |   1 -
>   arch/arm/boot/dts/iwg20d-q7-common.dtsi            |   2 +-
>   arch/arm/boot/dts/meson8.dtsi                      |   4 +-
>   arch/arm/boot/dts/meson8b.dtsi                     |   4 +-
>   arch/arm/boot/dts/omap3-gta04a5one.dts             |   4 +-
>   arch/arm/boot/dts/stm32mp15xx-dhcom-pdk2.dtsi      |  11 +-
>   arch/arm/boot/dts/stm32mp15xx-dhcor-avenger96.dtsi |   8 +-
>   arch/arm/boot/dts/stm32mp15xx-dhcor-som.dtsi       |   6 -
>   arch/arm/boot/dts/stm32mp15xx-dkx.dtsi             |   2 +-
>   arch/arm/include/asm/pgtable-3level.h              |   2 +-
>   arch/arm/mach-ep93xx/timer-ep93xx.c                |   3 +-
>   arch/arm/mach-omap2/board-generic.c                |   1 +
>   arch/arm/mach-orion5x/board-dt.c                   |   3 +
>   arch/arm/mach-orion5x/common.h                     |   6 +
>   arch/arm/probes/kprobes/checkers-common.c          |   2 +-
>   arch/arm/probes/kprobes/core.c                     |   2 +-
>   arch/arm/probes/kprobes/opt-arm.c                  |   2 -
>   arch/arm/probes/kprobes/test-core.c                |   2 +-
>   arch/arm/probes/kprobes/test-core.h                |   4 +
>   arch/arm64/boot/dts/microchip/sparx5.dtsi          |   2 +-
>   .../boot/dts/microchip/sparx5_pcb_common.dtsi      |  12 +
>   arch/arm64/boot/dts/qcom/apq8096-ifc6640.dts       |   4 +-
>   arch/arm64/boot/dts/qcom/msm8916.dtsi              |   2 +-
>   arch/arm64/boot/dts/qcom/msm8994.dtsi              |   2 +-
>   arch/arm64/boot/dts/qcom/msm8996.dtsi              |   2 +-
>   arch/arm64/boot/dts/renesas/ulcb-kf.dtsi           |   3 +-
>   .../boot/dts/ti/k3-j7200-common-proc-board.dts     |  28 +-
>   arch/arm64/include/asm/exception.h                 |   5 -
>   arch/arm64/include/asm/pgtable.h                   |   8 +-
>   arch/arm64/mm/mmu.c                                |   4 +-
>   arch/ia64/include/asm/pgtable.h                    |   4 +-
>   arch/m68k/include/asm/motorola_pgtable.h           |   2 +-
>   arch/mips/include/asm/pgtable-64.h                 |   8 +-
>   arch/mips/kernel/cpu-probe.c                       |   9 +-
>   arch/parisc/include/asm/pgtable.h                  |   4 +-
>   arch/powerpc/Kconfig.debug                         |   2 +-
>   arch/powerpc/Makefile                              |   8 +
>   arch/powerpc/include/asm/book3s/64/pgtable.h       |  11 +-
>   arch/powerpc/include/asm/nohash/64/pgtable-4k.h    |   6 +-
>   arch/powerpc/include/asm/nohash/64/pgtable.h       |   6 +-
>   arch/powerpc/mm/book3s64/radix_pgtable.c           |  40 +-
>   arch/powerpc/mm/init_64.c                          |   2 +-
>   arch/powerpc/mm/pgtable_64.c                       |   4 +-
>   arch/powerpc/platforms/powernv/pci-sriov.c         |   6 +-
>   arch/riscv/include/asm/pgtable-64.h                |   4 +-
>   arch/riscv/net/bpf_jit.h                           |   5 +-
>   arch/riscv/net/bpf_jit_comp64.c                    |  13 -
>   arch/riscv/net/bpf_jit_core.c                      |  29 +-
>   arch/s390/Makefile                                 |   1 +
>   arch/s390/kvm/kvm-s390.c                           |   4 +
>   arch/s390/kvm/vsie.c                               |   6 +-
>   arch/sh/drivers/dma/dma-sh.c                       |  37 +-
>   arch/sh/include/asm/pgtable-3level.h               |   4 +-
>   arch/sh/kernel/cpu/sh2/probe.c                     |   2 +-
>   arch/sparc/include/asm/pgtable_32.h                |   6 +-
>   arch/sparc/include/asm/pgtable_64.h                |  10 +-
>   arch/um/Makefile                                   |   2 +-
>   arch/um/include/asm/pgtable-3level.h               |   2 +-
>   arch/x86/events/amd/core.c                         |   2 +-
>   arch/x86/events/amd/ibs.c                          |  53 +-
>   arch/x86/include/asm/perf_event.h                  |   2 +
>   arch/x86/include/asm/pgtable.h                     |   8 +-
>   arch/x86/include/asm/pgtable_64.h                  |   4 +-
>   arch/x86/kernel/cpu/resctrl/rdtgroup.c             |   8 +-
>   arch/x86/kernel/smpboot.c                          |  24 +-
>   arch/x86/mm/init_64.c                              |   4 +-
>   arch/x86/mm/pat/set_memory.c                       |   4 +-
>   arch/x86/mm/pgtable.c                              |   2 +-
>   arch/xtensa/platforms/iss/network.c                |   2 +-
>   block/blk-iocost.c                                 |   7 +-
>   block/partitions/amiga.c                           | 104 +++-
>   drivers/acpi/button.c                              |   9 +
>   drivers/acpi/video_detect.c                        |  16 +
>   drivers/base/power/domain.c                        |   6 +-
>   drivers/base/regmap/regmap-i2c.c                   |   8 +-
>   drivers/base/regmap/regmap-spi-avmm.c              |   2 +-
>   drivers/base/regmap/regmap.c                       |   6 +-
>   drivers/block/nbd.c                                |   3 +-
>   drivers/bus/ti-sysc.c                              |   4 +-
>   drivers/char/hw_random/imx-rngc.c                  |   6 +-
>   drivers/char/hw_random/st-rng.c                    |  21 +-
>   drivers/char/hw_random/virtio-rng.c                |  86 ++-
>   drivers/char/tpm/tpm_tis_core.c                    |   2 +
>   drivers/char/tpm/tpm_vtpm_proxy.c                  |  30 +-
>   drivers/clk/clk-cdce925.c                          |  12 +
>   drivers/clk/clk-si5341.c                           | 242 +++++++-
>   drivers/clk/clk-versaclock5.c                      |  29 +
>   drivers/clk/imx/clk-imx8mn.c                       |   8 +-
>   drivers/clk/imx/clk-imx8mp.c                       |  24 +-
>   drivers/clk/keystone/sci-clk.c                     |   2 +
>   drivers/clk/qcom/gcc-ipq6018.c                     |  34 +-
>   drivers/clk/qcom/reset.c                           |   8 +-
>   drivers/clk/qcom/reset.h                           |   2 +
>   drivers/clk/tegra/clk-tegra124-emc.c               |   2 +
>   drivers/clk/ti/clkctrl.c                           |   7 +
>   drivers/clocksource/timer-cadence-ttc.c            |  19 +-
>   drivers/cpufreq/intel_pstate.c                     |   2 +
>   drivers/crypto/marvell/cesa/cipher.c               |   2 +-
>   drivers/crypto/nx/Makefile                         |   2 +-
>   drivers/crypto/nx/nx.h                             |   4 +-
>   drivers/dax/bus.c                                  |  61 +-
>   drivers/dax/dax-private.h                          |   4 +-
>   drivers/extcon/extcon.c                            |   8 +
>   drivers/firmware/stratix10-svc.c                   |   2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c             |  20 +-
>   drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c    |  13 +-
>   drivers/gpu/drm/amd/display/dc/core/dc.c           |   3 -
>   drivers/gpu/drm/amd/display/dmub/dmub_srv.h        |   2 +-
>   drivers/gpu/drm/bridge/tc358768.c                  |  93 ++-
>   drivers/gpu/drm/drm_atomic.c                       |  11 +-
>   drivers/gpu/drm/drm_atomic_helper.c                |  11 +-
>   drivers/gpu/drm/drm_client_modeset.c               |   6 +
>   drivers/gpu/drm/drm_gem_vram_helper.c              |   6 +-
>   drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c           |   5 +-
>   drivers/gpu/drm/msm/dp/dp_display.c                |   2 +-
>   drivers/gpu/drm/panel/panel-sharp-ls043t1le01.c    |  11 +-
>   drivers/gpu/drm/panel/panel-simple.c               |   6 +-
>   drivers/gpu/drm/radeon/ci_dpm.c                    |  28 +-
>   drivers/gpu/drm/radeon/cypress_dpm.c               |   8 +-
>   drivers/gpu/drm/radeon/ni_dpm.c                    |   8 +-
>   drivers/gpu/drm/radeon/rv740_dpm.c                 |   8 +-
>   drivers/gpu/drm/rockchip/rockchip_drm_vop.c        |   8 +-
>   drivers/gpu/drm/sun4i/sun4i_tcon.c                 |  19 +-
>   drivers/hid/hid-logitech-hidpp.c                   |   2 +-
>   drivers/hid/wacom_wac.c                            |   6 +-
>   drivers/hid/wacom_wac.h                            |   2 +-
>   drivers/hwmon/gsc-hwmon.c                          |   6 +-
>   drivers/hwmon/pmbus/adm1275.c                      |  94 ++-
>   drivers/hwtracing/coresight/coresight-core.c       |   9 +-
>   drivers/i2c/busses/i2c-qup.c                       |  21 +-
>   drivers/i2c/busses/i2c-xiic.c                      |  39 +-
>   drivers/iio/adc/meson_saradc.c                     |   2 +-
>   drivers/infiniband/core/cma.c                      |  23 +
>   drivers/infiniband/core/cma_priv.h                 |   1 +
>   drivers/infiniband/core/device.c                   |  11 +
>   drivers/infiniband/core/uverbs_cmd.c               |   2 +-
>   drivers/infiniband/hw/bnxt_re/main.c               |  20 +-
>   drivers/infiniband/hw/bnxt_re/qplib_fp.c           |  40 +-
>   drivers/infiniband/hw/bnxt_re/qplib_fp.h           |   2 +-
>   drivers/infiniband/hw/bnxt_re/qplib_rcfw.c         |  46 +-
>   drivers/infiniband/hw/bnxt_re/qplib_rcfw.h         |   1 +
>   drivers/infiniband/hw/efa/efa_main.c               |   3 -
>   drivers/infiniband/hw/hfi1/ipoib_tx.c              |   4 +-
>   drivers/infiniband/hw/hfi1/mmu_rb.c                | 101 +--
>   drivers/infiniband/hw/hfi1/mmu_rb.h                |   3 +
>   drivers/infiniband/hw/hfi1/sdma.c                  |  27 +-
>   drivers/infiniband/hw/hfi1/sdma.h                  |  62 +-
>   drivers/infiniband/hw/hfi1/sdma_txreq.h            |   2 +
>   drivers/infiniband/hw/hfi1/user_sdma.c             | 145 ++---
>   drivers/infiniband/hw/hfi1/user_sdma.h             |   1 -
>   drivers/infiniband/hw/hfi1/vnic_sdma.c             |   4 +-
>   drivers/infiniband/hw/hns/hns_roce_cmd.c           |  27 +-
>   drivers/infiniband/hw/hns/hns_roce_cmd.h           |   4 +-
>   drivers/infiniband/hw/hns/hns_roce_cq.c            |   2 +-
>   drivers/infiniband/hw/hns/hns_roce_device.h        |   2 -
>   drivers/infiniband/hw/hns/hns_roce_hem.c           | 131 +---
>   drivers/infiniband/hw/hns/hns_roce_hem.h           |  15 +-
>   drivers/infiniband/hw/hns/hns_roce_hw_v1.c         |  93 ++-
>   drivers/infiniband/hw/hns/hns_roce_hw_v1.h         |   7 +-
>   drivers/infiniband/hw/hns/hns_roce_hw_v2.c         |   9 +-
>   drivers/infiniband/hw/hns/hns_roce_hw_v2.h         |   6 +-
>   drivers/infiniband/hw/hns/hns_roce_main.c          |   8 +-
>   drivers/infiniband/hw/hns/hns_roce_mr.c            |   4 +-
>   drivers/infiniband/hw/hns/hns_roce_qp.c            |   2 +-
>   drivers/infiniband/hw/hns/hns_roce_srq.c           |   1 -
>   drivers/infiniband/hw/mlx4/main.c                  |  14 +-
>   drivers/infiniband/hw/mlx5/main.c                  |  14 +-
>   drivers/input/misc/adxl34x.c                       |   3 +-
>   drivers/input/misc/drv260x.c                       |   1 +
>   drivers/irqchip/irq-jcore-aic.c                    |  11 +-
>   drivers/leds/trigger/ledtrig-netdev.c              |   3 +
>   drivers/mailbox/ti-msgmgr.c                        |  12 +-
>   drivers/md/bcache/btree.c                          |  25 +-
>   drivers/md/bcache/btree.h                          |   1 +
>   drivers/md/bcache/super.c                          |   4 +-
>   drivers/md/bcache/writeback.c                      |  10 +
>   drivers/md/md-bitmap.c                             |  17 +-
>   drivers/md/md.c                                    |  23 +-
>   drivers/md/raid0.c                                 |  62 +-
>   drivers/md/raid0.h                                 |   1 +
>   drivers/md/raid10.c                                |  38 +-
>   drivers/media/cec/i2c/Kconfig                      |   1 +
>   drivers/media/platform/qcom/venus/helpers.c        |   4 +-
>   drivers/media/usb/dvb-usb-v2/az6007.c              |   3 +-
>   drivers/media/usb/siano/smsusb.c                   |   3 +-
>   drivers/memory/brcmstb_dpfe.c                      |   4 +-
>   drivers/memstick/host/r592.c                       |   4 +-
>   drivers/mfd/intel-lpss-acpi.c                      |   3 +
>   drivers/mfd/rt5033.c                               |   3 -
>   drivers/mfd/stmfx.c                                |   7 +-
>   drivers/mfd/stmpe.c                                |   4 +-
>   drivers/misc/fastrpc.c                             |   2 +-
>   drivers/misc/pci_endpoint_test.c                   |  10 +-
>   drivers/mmc/core/quirks.h                          |  14 +
>   drivers/mmc/host/mmci.c                            |   1 +
>   drivers/mmc/host/sdhci.c                           |   4 +-
>   drivers/mtd/nand/raw/meson_nand.c                  |   4 +
>   drivers/net/dsa/vitesse-vsc73xx-core.c             |   6 +-
>   drivers/net/ethernet/amazon/ena/ena_com.c          |   3 +
>   drivers/net/ethernet/broadcom/bgmac.c              |   4 +-
>   drivers/net/ethernet/broadcom/genet/bcmmii.c       |   2 +
>   drivers/net/ethernet/broadcom/tg3.c                |   1 +
>   drivers/net/ethernet/google/gve/gve_ethtool.c      |   3 +
>   drivers/net/ethernet/intel/iavf/iavf_ethtool.c     |   2 +-
>   drivers/net/ethernet/intel/iavf/iavf_main.c        |   5 +-
>   drivers/net/ethernet/intel/igb/igb_main.c          |   5 +
>   drivers/net/ethernet/intel/igc/igc.h               |  33 +-
>   drivers/net/ethernet/intel/igc/igc_ethtool.c       |   2 +
>   drivers/net/ethernet/intel/igc/igc_main.c          |  45 +-
>   drivers/net/ethernet/intel/igc/igc_ptp.c           |  57 +-
>   drivers/net/ethernet/marvell/mvneta.c              |   4 +-
>   drivers/net/ethernet/marvell/octeontx2/af/rvu.h    |  11 +
>   .../net/ethernet/marvell/octeontx2/af/rvu_cgx.c    |   2 +-
>   .../net/ethernet/marvell/octeontx2/nic/otx2_pf.c   |   5 +-
>   .../ethernet/mellanox/mlx5/core/en_accel/fs_tcp.c  |   1 +
>   drivers/net/ethernet/mellanox/mlx5/core/en_tc.c    |   6 +-
>   drivers/net/ethernet/microchip/lan743x_main.c      |  21 +-
>   drivers/net/ethernet/pensando/ionic/ionic_lif.c    |   5 -
>   drivers/net/ethernet/sfc/ef10.c                    |  13 +-
>   drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |   6 -
>   drivers/net/ethernet/ti/cpsw_ale.c                 |  24 +-
>   drivers/net/ethernet/xilinx/xilinx_axienet_main.c  |  10 +-
>   drivers/net/gtp.c                                  |   2 +
>   drivers/net/ipvlan/ipvlan_core.c                   |   9 +-
>   drivers/net/netdevsim/dev.c                        |   9 +-
>   drivers/net/phy/phy_device.c                       |  21 +-
>   drivers/net/ppp/pptp.c                             |  31 +-
>   drivers/net/wireguard/netlink.c                    |  14 +-
>   drivers/net/wireguard/queueing.c                   |   1 +
>   drivers/net/wireguard/queueing.h                   |  25 +-
>   drivers/net/wireguard/receive.c                    |   2 +-
>   drivers/net/wireguard/send.c                       |   2 +-
>   drivers/net/wireless/ath/ath11k/mac.c              |   2 +-
>   drivers/net/wireless/ath/ath9k/ar9003_hw.c         |  27 +-
>   drivers/net/wireless/ath/ath9k/htc_hst.c           |   8 +-
>   drivers/net/wireless/ath/ath9k/main.c              |  11 +-
>   drivers/net/wireless/ath/ath9k/wmi.c               |   4 +
>   drivers/net/wireless/atmel/atmel_cs.c              |  13 +-
>   drivers/net/wireless/cisco/airo.c                  |   5 +-
>   drivers/net/wireless/intel/iwlwifi/mvm/ops.c       |   5 +-
>   drivers/net/wireless/intel/iwlwifi/mvm/sta.c       |   2 +-
>   drivers/net/wireless/intersil/orinoco/orinoco_cs.c |  13 +-
>   .../net/wireless/intersil/orinoco/spectrum_cs.c    |  13 +-
>   drivers/net/wireless/marvell/mwifiex/scan.c        |   6 +-
>   drivers/net/wireless/microchip/wilc1000/hif.c      |   8 +-
>   drivers/net/wireless/ray_cs.c                      |  36 +-
>   drivers/net/wireless/rsi/rsi_91x_sdio.c            |   9 +-
>   drivers/net/wireless/wl3501_cs.c                   |  27 +-
>   drivers/ntb/hw/amd/ntb_hw_amd.c                    |   7 +-
>   drivers/ntb/hw/idt/ntb_hw_idt.c                    |   7 +-
>   drivers/ntb/hw/intel/ntb_hw_gen1.c                 |   7 +-
>   drivers/ntb/ntb_transport.c                        |   2 +-
>   drivers/ntb/test/ntb_tool.c                        |   2 +
>   drivers/nubus/proc.c                               |  22 +-
>   drivers/nvme/host/pci.c                            |   3 +-
>   drivers/pci/controller/cadence/pcie-cadence-host.c |  27 +
>   drivers/pci/controller/dwc/pcie-qcom.c             |   2 +
>   drivers/pci/controller/pci-ftpci100.c              |  14 +-
>   drivers/pci/controller/pcie-rockchip-ep.c          |  65 +-
>   drivers/pci/controller/pcie-rockchip.c             |  17 +
>   drivers/pci/controller/pcie-rockchip.h             |  11 +-
>   drivers/pci/hotplug/pciehp_ctrl.c                  |   8 +
>   drivers/pci/pci.c                                  |  10 +-
>   drivers/pci/pcie/aspm.c                            |  21 +-
>   drivers/pci/quirks.c                               |   2 +
>   drivers/perf/arm-cmn.c                             |   7 +-
>   drivers/phy/tegra/xusb.c                           |   4 +
>   drivers/pinctrl/bcm/pinctrl-bcm2835.c              |   6 +-
>   drivers/pinctrl/intel/pinctrl-cherryview.c         |  15 +-
>   drivers/pinctrl/pinctrl-amd.c                      |  41 +-
>   drivers/pinctrl/pinctrl-amd.h                      |   1 +
>   drivers/pinctrl/pinctrl-at91-pio4.c                |   2 +
>   drivers/platform/x86/wmi.c                         |  64 +-
>   drivers/powercap/Kconfig                           |   4 +-
>   drivers/powercap/intel_rapl_msr.c                  |   1 -
>   drivers/pwm/pwm-imx-tpm.c                          |   7 +
>   drivers/pwm/sysfs.c                                |  17 +
>   drivers/regulator/core.c                           |  30 +-
>   drivers/rtc/rtc-st-lpc.c                           |   2 +-
>   drivers/s390/net/qeth_l3_sys.c                     |   2 +-
>   drivers/scsi/3w-xxxx.c                             |   4 +-
>   drivers/scsi/qedf/qedf_main.c                      |   3 +-
>   drivers/scsi/qla2xxx/qla_attr.c                    |  13 +
>   drivers/scsi/qla2xxx/qla_bsg.c                     |   6 +
>   drivers/scsi/qla2xxx/qla_def.h                     |   1 -
>   drivers/scsi/qla2xxx/qla_init.c                    |   2 +-
>   drivers/scsi/qla2xxx/qla_inline.h                  |   5 +-
>   drivers/scsi/qla2xxx/qla_iocb.c                    |   5 +-
>   drivers/scsi/qla2xxx/qla_nvme.c                    |   3 -
>   drivers/scsi/qla2xxx/qla_os.c                      |   3 +-
>   drivers/soc/amlogic/meson-secure-pwrc.c            |   2 +-
>   drivers/soc/fsl/qe/Kconfig                         |   1 +
>   drivers/spi/spi-bcm-qspi.c                         |  10 +-
>   drivers/spi/spi-bcm63xx.c                          |   2 +-
>   drivers/spi/spi-geni-qcom.c                        |   2 +-
>   drivers/staging/media/atomisp/pci/atomisp_cmd.c    |   3 +-
>   .../media/atomisp/pci/atomisp_gmin_platform.c      |   2 +-
>   drivers/staging/media/atomisp/pci/atomisp_ioctl.c  |   3 +-
>   drivers/thermal/mtk_thermal.c                      |  14 +-
>   drivers/thermal/sun8i_thermal.c                    |  55 +-
>   drivers/tty/serial/8250/8250.h                     |   1 -
>   drivers/tty/serial/8250/8250_omap.c                |  25 +-
>   drivers/tty/serial/8250/8250_pci.c                 |  19 -
>   drivers/tty/serial/8250/8250_port.c                |  11 +-
>   drivers/tty/serial/atmel_serial.c                  |   4 +-
>   drivers/tty/serial/fsl_lpuart.c                    |   1 +
>   drivers/tty/serial/samsung_tty.c                   |  14 +-
>   drivers/usb/core/devio.c                           |   2 +
>   drivers/usb/dwc3/dwc3-meson-g12a.c                 |   5 +-
>   drivers/usb/dwc3/dwc3-qcom.c                       |  17 +-
>   drivers/usb/dwc3/gadget.c                          |   4 +-
>   drivers/usb/gadget/function/u_serial.c             |  13 +-
>   drivers/usb/host/xhci-mem.c                        |  39 +-
>   drivers/usb/host/xhci-pci.c                        |  12 +
>   drivers/usb/host/xhci.h                            |   2 +
>   drivers/usb/phy/phy-tahvo.c                        |   2 +-
>   drivers/usb/serial/option.c                        |   4 +
>   drivers/video/fbdev/au1200fb.c                     |   3 +
>   drivers/video/fbdev/imsttfb.c                      |  34 +-
>   drivers/video/fbdev/imxfb.c                        |   4 +-
>   drivers/video/fbdev/omap/lcd_mipid.c               |   6 +-
>   drivers/w1/slaves/w1_therm.c                       |  31 +-
>   drivers/w1/w1.c                                    |   4 +-
>   fs/btrfs/block-group.c                             |   9 +-
>   fs/btrfs/disk-io.c                                 |   3 +
>   fs/btrfs/qgroup.c                                  |   3 +
>   fs/ceph/caps.c                                     |   9 +
>   fs/dlm/plock.c                                     |   4 +-
>   fs/erofs/zdata.c                                   |   2 +-
>   fs/erofs/zmap.c                                    |   6 +-
>   fs/ext4/indirect.c                                 |   8 +
>   fs/ext4/inode.c                                    |  10 -
>   fs/ext4/ioctl.c                                    |   5 +-
>   fs/ext4/mballoc.c                                  |  17 +-
>   fs/ext4/namei.c                                    |  17 +-
>   fs/ext4/super.c                                    |  13 +-
>   fs/ext4/xattr.c                                    |  14 +
>   fs/f2fs/f2fs.h                                     |   2 +-
>   fs/f2fs/file.c                                     |   2 +-
>   fs/f2fs/gc.c                                       |  22 +-
>   fs/f2fs/namei.c                                    |  16 +-
>   fs/f2fs/node.c                                     |   4 +-
>   fs/fs_context.c                                    |   3 +-
>   fs/fuse/dir.c                                      |   2 +-
>   fs/inode.c                                         |  42 ++
>   fs/internal.h                                      |   2 +
>   fs/jffs2/build.c                                   |   5 +-
>   fs/jffs2/xattr.c                                   |  13 +-
>   fs/jffs2/xattr.h                                   |   4 +-
>   fs/jfs/jfs_dmap.c                                  |   6 +
>   fs/jfs/jfs_filsys.h                                |   2 +
>   fs/kernfs/dir.c                                    |   2 +
>   fs/namei.c                                         |  25 +-
>   fs/nfs/nfs4proc.c                                  |   1 +
>   fs/nfsd/nfs4xdr.c                                  |   2 +-
>   fs/notify/fanotify/fanotify_user.c                 |  22 +-
>   fs/overlayfs/copy_up.c                             |   2 +
>   fs/overlayfs/dir.c                                 |   3 +-
>   fs/overlayfs/export.c                              |   3 +-
>   fs/overlayfs/namei.c                               |   3 +-
>   fs/overlayfs/overlayfs.h                           |   6 +-
>   fs/overlayfs/super.c                               |   2 +-
>   fs/overlayfs/util.c                                |  24 +-
>   fs/pstore/ram_core.c                               |   2 +
>   fs/ramfs/inode.c                                   |   2 +-
>   include/asm-generic/pgtable-nop4d.h                |   2 +-
>   include/asm-generic/pgtable-nopmd.h                |   2 +-
>   include/asm-generic/pgtable-nopud.h                |   2 +-
>   include/linux/bpf-cgroup.h                         |  27 +-
>   include/linux/etherdevice.h                        |  12 +
>   include/linux/indirect_call_wrapper.h              |   6 +
>   include/linux/netdevice.h                          |  18 +
>   include/linux/nmi.h                                |   2 +-
>   include/linux/pci.h                                |   1 +
>   include/linux/pgtable.h                            |   4 +-
>   include/linux/pipe_fs_i.h                          |   4 -
>   include/linux/ramfs.h                              |   1 +
>   include/linux/sched/signal.h                       |   2 +-
>   include/linux/serial_8250.h                        |   1 -
>   include/linux/tcp.h                                |   2 +-
>   include/linux/workqueue.h                          |  15 +-
>   include/net/netfilter/nf_tables.h                  |  41 +-
>   include/net/netns/ipv4.h                           |   1 +
>   include/net/netns/nftables.h                       |   7 -
>   include/net/nfc/nfc.h                              |   4 +-
>   include/net/pkt_sched.h                            |   2 +-
>   include/net/sock.h                                 |   3 +
>   include/net/tcp.h                                  |  32 +-
>   include/trace/events/timer.h                       |   6 +-
>   include/uapi/linux/affs_hardblocks.h               |  68 +-
>   include/uapi/linux/auto_dev-ioctl.h                |   2 +-
>   include/uapi/linux/videodev2.h                     |   2 +-
>   io_uring/io_uring.c                                |  66 +-
>   kernel/bpf/bpf_lru_list.c                          |  21 +-
>   kernel/bpf/bpf_lru_list.h                          |   7 +-
>   kernel/bpf/cgroup.c                                |  46 ++
>   kernel/kcsan/core.c                                |   2 +
>   kernel/kexec_core.c                                |   5 +-
>   kernel/rcu/rcuscale.c                              | 214 +++----
>   kernel/rcu/tasks.h                                 |  37 +-
>   kernel/sched/fair.c                                |   2 +-
>   kernel/time/posix-timers.c                         |  74 ++-
>   kernel/trace/ftrace.c                              |  72 ++-
>   kernel/trace/ring_buffer.c                         |  24 +-
>   kernel/trace/trace.c                               |   3 +-
>   kernel/trace/trace_events_hist.c                   |   9 +-
>   kernel/trace/trace_probe_tmpl.h                    |   2 +
>   kernel/watchdog_hld.c                              |   6 +-
>   kernel/workqueue.c                                 |  13 +-
>   lib/debugobjects.c                                 |   9 +
>   lib/test_firmware.c                                |  12 +-
>   lib/ts_bm.c                                        |   4 +-
>   mm/shmem.c                                         |   2 +-
>   net/bridge/br_if.c                                 |   5 +-
>   net/bridge/br_stp_if.c                             |   3 +
>   net/can/bcm.c                                      |  12 +-
>   net/can/isotp.c                                    |   5 +-
>   net/core/devlink.c                                 |   5 +-
>   net/core/rtnetlink.c                               | 104 ++--
>   net/core/skbuff.c                                  |   5 +
>   net/core/sock.c                                    |  17 +-
>   net/dsa/tag_sja1105.c                              |   4 +-
>   net/ipv4/esp4.c                                    |   2 +-
>   net/ipv4/inet_connection_sock.c                    |   3 +-
>   net/ipv4/inet_hashtables.c                         |  17 +-
>   net/ipv4/inet_timewait_sock.c                      |   8 +-
>   net/ipv4/sysctl_net_ipv4.c                         |   9 +
>   net/ipv4/tcp.c                                     |  68 +-
>   net/ipv4/tcp_fastopen.c                            |   6 +-
>   net/ipv4/tcp_input.c                               |  12 +-
>   net/ipv4/tcp_ipv4.c                                |   3 +-
>   net/ipv4/tcp_minisocks.c                           |   9 +-
>   net/ipv4/tcp_output.c                              |   2 +-
>   net/ipv4/tcp_timer.c                               |  10 +-
>   net/ipv6/addrconf.c                                |   3 +-
>   net/ipv6/icmp.c                                    |   5 +-
>   net/ipv6/ip6_gre.c                                 |   3 +-
>   net/ipv6/tcp_ipv6.c                                |   3 +-
>   net/ipv6/udp.c                                     |   2 +-
>   net/llc/llc_input.c                                |   3 -
>   net/netfilter/nf_conntrack_helper.c                |   4 +
>   net/netfilter/nf_conntrack_proto_dccp.c            |  52 +-
>   net/netfilter/nf_conntrack_sip.c                   |   2 +-
>   net/netfilter/nf_tables_api.c                      | 681 +++++++++++++++------
>   net/netfilter/nf_tables_offload.c                  |  30 +-
>   net/netfilter/nft_byteorder.c                      |  14 +-
>   net/netfilter/nft_chain_filter.c                   |  11 +-
>   net/netfilter/nft_dynset.c                         |   6 +-
>   net/netfilter/nft_immediate.c                      |  90 ++-
>   net/netfilter/nft_set_bitmap.c                     |   5 +-
>   net/netfilter/nft_set_hash.c                       |  23 +-
>   net/netfilter/nft_set_pipapo.c                     |  20 +-
>   net/netfilter/nft_set_rbtree.c                     |   5 +-
>   net/netlink/af_netlink.c                           |   5 +-
>   net/netlink/diag.c                                 |   7 +-
>   net/nfc/core.c                                     |   4 +-
>   net/nfc/hci/llc_shdlc.c                            |  10 +-
>   net/nfc/llcp.h                                     |   9 +-
>   net/nfc/llcp_commands.c                            |  59 +-
>   net/nfc/llcp_core.c                                |  95 ++-
>   net/nfc/llcp_sock.c                                |  21 +-
>   net/nfc/netlink.c                                  |  20 +-
>   net/nfc/nfc.h                                      |   3 +-
>   net/sched/act_pedit.c                              |   1 +
>   net/sched/cls_flower.c                             |  10 +
>   net/sched/cls_fw.c                                 |  10 +-
>   net/sched/sch_qfq.c                                |  41 +-
>   net/sctp/socket.c                                  |  22 +-
>   net/socket.c                                       |   3 +
>   net/sunrpc/svcsock.c                               |  23 +-
>   net/wireless/scan.c                                | 217 ++++---
>   net/wireless/wext-core.c                           |   6 +
>   net/xdp/xsk.c                                      |   5 +
>   samples/bpf/tcp_basertt_kern.c                     |   2 +-
>   samples/ftrace/ftrace-direct-too.c                 |  14 +-
>   scripts/mod/modpost.c                              |  26 +-
>   scripts/tags.sh                                    |   9 +-
>   security/apparmor/policy_unpack.c                  |   9 +-
>   security/integrity/evm/evm_main.c                  |   2 +
>   security/integrity/iint.c                          |  15 +-
>   security/integrity/ima/ima_modsig.c                |   3 +
>   security/integrity/ima/ima_policy.c                |   3 +-
>   security/keys/request_key.c                        |  35 +-
>   security/keys/trusted-keys/trusted_tpm2.c          |   2 +-
>   sound/core/jack.c                                  |  15 +-
>   sound/pci/ac97/ac97_codec.c                        |   4 +-
>   sound/pci/hda/patch_realtek.c                      |  28 +-
>   sound/soc/codecs/es8316.c                          |  23 +-
>   sound/soc/fsl/fsl_sai.c                            |   2 +-
>   sound/soc/fsl/fsl_sai.h                            |   1 +
>   sound/soc/fsl/imx-audmix.c                         |   9 +
>   sound/soc/mediatek/mt8173/mt8173-afe-pcm.c         |  13 +-
>   tools/bpf/bpftool/feature.c                        |  24 +-
>   tools/include/uapi/linux/tcp.h                     | 357 +++++++++++
>   tools/lib/bpf/bpf_helpers.h                        |  15 +-
>   tools/perf/builtin-bench.c                         |   7 +-
>   tools/perf/builtin-script.c                        |  34 +-
>   tools/perf/tests/builtin-test.c                    |   3 +
>   .../tests/shell/test_uprobe_from_different_cu.sh   |  77 +++
>   tools/perf/util/dwarf-aux.c                        |   2 +-
>   .../testing/selftests/bpf/prog_tests/bpf_tcp_ca.c  |   1 +
>   .../selftests/bpf/prog_tests/cls_redirect.c        |   1 +
>   .../selftests/bpf/prog_tests/sockmap_basic.c       |   1 +
>   .../testing/selftests/bpf/prog_tests/sockopt_sk.c  |  28 +
>   tools/testing/selftests/bpf/progs/sockopt_sk.c     |  23 +-
>   tools/testing/selftests/bpf/test_progs.h           |   1 -
>   tools/testing/selftests/bpf/test_verifier.c        |  12 +-
>   tools/testing/selftests/bpf/verifier/spill_fill.c  |  30 +
>   tools/testing/selftests/net/rtnetlink.sh           |   1 +
>   tools/testing/selftests/tc-testing/config          |   1 +
>   tools/testing/selftests/tc-testing/settings        |   1 +
>   tools/testing/selftests/wireguard/netns.sh         |  30 +-
>   522 files changed, 5604 insertions(+), 2683 deletions(-)
> 
> 
> .
> 
