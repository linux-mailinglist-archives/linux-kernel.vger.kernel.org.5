Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEA267B8939
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 20:23:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244133AbjJDSXo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 14:23:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244129AbjJDSXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 14:23:43 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4347098;
        Wed,  4 Oct 2023 11:23:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32278C433C9;
        Wed,  4 Oct 2023 18:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696443814;
        bh=dkSBSmnY4otRKN0HZUiSdXMnzaEBj6ei9AhYevQhnlY=;
        h=From:To:Cc:Subject:Date:From;
        b=fJXssjlXXbnqR0NVZUWk0uMkUb/T9ufsXwGzglpboqHpAcNAKMsDrfofsJLSr7hf3
         0yTyICFmovnIBUg9+koMNTjogj5nVkzpIVDg7O8r+b8Of9wxRWoXgSS1Z2in1qv50s
         Rp1uVTmnTiFNnezmyG4MqirYa+pBUzTSbHEKG7uc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: [PATCH 6.5 000/321] 6.5.6-rc1 review
Date:   Wed,  4 Oct 2023 19:52:25 +0200
Message-ID: <20231004175229.211487444@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.5.6-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.5.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.5.6-rc1
X-KernelTest-Deadline: 2023-10-06T17:52+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 6.5.6 release.
There are 321 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Fri, 06 Oct 2023 17:51:12 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.5.6-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.5.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 6.5.6-rc1

Mario Limonciello <mario.limonciello@amd.com>
    ASoC: amd: yc: Fix a non-functional mic on Lenovo 82TL

Michal Hocko <mhocko@suse.com>
    mm, memcg: reconsider kmem.limit_in_bytes deprecation

Michal Hocko <mhocko@suse.com>
    memcg: drop kmem.limit_in_bytes

Ilya Dryomov <idryomov@gmail.com>
    rbd: take header_rwsem in rbd_dev_refresh() only when updating

Ilya Dryomov <idryomov@gmail.com>
    rbd: decouple parent info read-in from updating rbd_dev

Ilya Dryomov <idryomov@gmail.com>
    rbd: decouple header read-in from updating rbd_dev->header

Ilya Dryomov <idryomov@gmail.com>
    rbd: move rbd_dev_refresh() definition

Jani Nikula <jani.nikula@intel.com>
    drm/meson: fix memory leak on ->hpd_notify callback

Hamza Mahfooz <hamza.mahfooz@amd.com>
    drm/amd/display: fix the ability to use lower resolution modes on eDP

YuBiao Wang <YuBiao.Wang@amd.com>
    drm/amdkfd: Use gpu_offset for user queue's wptr

Greg Ungerer <gerg@kernel.org>
    fs: binfmt_elf_efpic: fix personality for ELF-FDPIC

Linus Walleij <linus.walleij@linaro.org>
    power: supply: ab8500: Set typing and props

Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
    power: supply: rk817: Add missing module alias

Javier Pello <devel@otheo.eu>
    drm/i915/gt: Fix reservation address in ggtt_reserve_guc_top

Matthew Wilcox (Oracle) <willy@infradead.org>
    i915: Limit the length of an sg list to the requested length

Matthias Schiffer <mschiffer@universe-factory.net>
    ata: libata-sata: increase PMP SRST timeout to 10s

Damien Le Moal <dlemoal@kernel.org>
    ata: libata-core: Do not register PM operations for SAS ports

Damien Le Moal <dlemoal@kernel.org>
    ata: libata-core: Fix port and device removal

Damien Le Moal <dlemoal@kernel.org>
    ata: libata-core: Fix ata_port_request_pm() locking

Beau Belgrave <beaub@linux.microsoft.com>
    tracing/user_events: Align set_bit() address for all archs

Quang Le <quanglex97@gmail.com>
    fs/smb/client: Reset password pointer to NULL

Rafael J. Wysocki <rafael.j.wysocki@intel.com>
    thermal: sysfs: Fix trip_point_hyst_store()

Mika Westerberg <mika.westerberg@linux.intel.com>
    net: thunderbolt: Fix TCPv6 GSO checksum calculation

Nick Desaulniers <ndesaulniers@google.com>
    bpf: Fix BTF_ID symbol generation collision in tools/

Jiri Olsa <jolsa@kernel.org>
    bpf: Fix BTF_ID symbol generation collision

Jiri Olsa <jolsa@kernel.org>
    bpf: Add override check to kprobe multi link attach

Ricardo Ribalda <ribalda@chromium.org>
    media: uvcvideo: Fix OOB read

Josef Bacik <josef@toxicpanda.com>
    btrfs: properly report 0 avail for very full file systems

Filipe Manana <fdmanana@suse.com>
    btrfs: fix race between reading a directory and adding entries to it

Filipe Manana <fdmanana@suse.com>
    btrfs: set last dir index to the current last index when opening dir

Bernd Schubert <bschubert@ddn.com>
    btrfs: file_remove_privs needs an exclusive lock in direct io write

Filipe Manana <fdmanana@suse.com>
    btrfs: refresh dir last index during a rewinddir(3) call

Steven Rostedt (Google) <rostedt@goodmis.org>
    ring-buffer: Update "shortest_full" in polling

Zheng Yejian <zhengyejian1@huawei.com>
    ring-buffer: Fix bytes info in per_cpu buffer stats

Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
    cxl/pci: Fix appropriate checking for _OSC while handling CXL RAS registers

Dan Williams <dan.j.williams@intel.com>
    cxl/port: Fix cxl_test register enumeration regression

Johannes Weiner <hannes@cmpxchg.org>
    mm: memcontrol: fix GFP_NOFS recursion in memory.high enforcement

Johannes Weiner <hannes@cmpxchg.org>
    mm: page_alloc: fix CMA and HIGHATOMIC landing on the wrong buddy list

Rafael Aquini <aquini@redhat.com>
    mm/slab_common: fix slab_caches list corruption after kmem_cache_destroy()

Yang Shi <yang@os.amperecomputing.com>
    mm: mempolicy: keep VMA walk if both MPOL_MF_STRICT and MPOL_MF_MOVE are specified

Juntong Deng <juntong.deng@outlook.com>
    selftests/mm: fix awk usage in charge_reserved_hugetlb.sh and hugetlb_reparenting_test.sh that may cause error

Jinjie Ruan <ruanjinjie@huawei.com>
    mm/damon/vaddr-test: fix memory leak in damon_do_test_apply_three_regions()

Mikko Rapeli <mikko.rapeli@linaro.org>
    arm64: defconfig: remove CONFIG_COMMON_CLK_NPCM8XX=y

Ira Weiny <ira.weiny@intel.com>
    cxl/mbox: Fix CEL logic for poison and security commands

Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
    drm/tests: Fix incorrect argument in drm_test_mm_insert_range

Frederic Weisbecker <frederic@kernel.org>
    timers: Tag (hr)timer softirq as hotplug safe

Yu Liao <liaoyu15@huawei.com>
    ACPI: NFIT: Fix incorrect calculation of idt size

Trond Myklebust <trond.myklebust@hammerspace.com>
    NFSv4: Fix a state manager thread deadlock regression

Trond Myklebust <trond.myklebust@hammerspace.com>
    Revert "SUNRPC dont update timeout value on connection reset"

Joel Fernandes (Google) <joel@joelfernandes.org>
    sched/rt: Fix live lock between select_fallback_rq() and RT push

Liam R. Howlett <Liam.Howlett@oracle.com>
    kernel/sched: Modify initial boot task idle setup

August Wikerfors <git@augustwikerfors.se>
    ASoC: amd: yc: Fix non-functional mic on Lenovo 82QF and 82UG

Heiner Kallweit <hkallweit1@gmail.com>
    i2c: i801: unregister tco_pdev in i801_probe() error path

Jens Axboe <axboe@kernel.dk>
    io_uring/fs: remove sqe->rw_flags checking from LINKAT

Niklas Cassel <niklas.cassel@wdc.com>
    ata: libata-scsi: ignore reserved bits for REPORT SUPPORTED OPERATION CODES

Damien Le Moal <dlemoal@kernel.org>
    scsi: sd: Do not issue commands to suspended disks on shutdown

Damien Le Moal <dlemoal@kernel.org>
    scsi: sd: Differentiate system and runtime start/stop management

Damien Le Moal <dlemoal@kernel.org>
    ata: libata-scsi: link ata port and scsi device

Tiezhu Yang <yangtiezhu@loongson.cn>
    LoongArch: Add support for 64_PCREL relocation type

Tiezhu Yang <yangtiezhu@loongson.cn>
    LoongArch: Add support for 32_PCREL relocation type

Huacai Chen <chenhuacai@kernel.org>
    LoongArch: numa: Fix high_memory calculation

Tiezhu Yang <yangtiezhu@loongson.cn>
    LoongArch: Define relocation types for ABI v2.10

Helge Deller <deller@gmx.de>
    LoongArch: Fix lockdep static memory detection

Kailang Yang <kailang@realtek.com>
    ALSA: hda: Disable power save for solving pop issue on Lenovo ThinkCentre M70q

Takashi Iwai <tiwai@suse.de>
    ALSA: rawmidi: Fix NULL dereference at proc read

Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
    crypto: sm2 - Fix crash caused by uninitialized context

Pan Bian <bianpan2016@163.com>
    nilfs2: fix potential use after free in nilfs_gccache_submit_read_data()

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    serial: 8250_port: Check IRQ data before use

Damien Le Moal <dlemoal@kernel.org>
    scsi: core: ata: Do no try to probe for CDL on old drives

Daniel Starke <daniel.starke@siemens.com>
    Revert "tty: n_gsm: fix UAF in gsm_cleanup_mux"

Ricky WU <ricky_wu@realtek.com>
    misc: rtsx: Fix some platforms can not boot and move the l1ss judgment to probe

Paolo Abeni <pabeni@redhat.com>
    mptcp: process pending subflow error on close

Paolo Abeni <pabeni@redhat.com>
    mptcp: move __mptcp_error_report in protocol.c

Paolo Abeni <pabeni@redhat.com>
    mptcp: fix bogus receive window shrinkage with multiple subflows

Sean Christopherson <seanjc@google.com>
    KVM: x86/mmu: Stop zapping invalidated TDP MMU roots asynchronously

Paolo Bonzini <pbonzini@redhat.com>
    KVM: x86/mmu: Do not filter address spaces in for_each_tdp_mmu_root_yield_safe()

Sean Christopherson <seanjc@google.com>
    KVM: x86/mmu: Open code leaf invalidation from mmu_notifier

Tom Lendacky <thomas.lendacky@amd.com>
    KVM: SVM: Fix TSC_AUX virtualization setup

Paolo Bonzini <pbonzini@redhat.com>
    KVM: SVM: INTERCEPT_RDTSCP is never intercepted anyway

Pu Wen <puwen@hygon.cn>
    x86/srso: Add SRSO mitigation for Hygon processors

Haitao Huang <haitao.huang@linux.intel.com>
    x86/sgx: Resolves SECS reclaim vs. page fault for EAUG race

Johan Hovold <johan+linaro@kernel.org>
    spi: zynqmp-gqspi: fix clock imbalance on probe failure

Nicolin Chen <nicolinc@nvidia.com>
    iommu/arm-smmu-v3: Fix soft lockup triggered by arm_smmu_mm_invalidate_range

Richard Fitzgerald <rf@opensource.cirrus.com>
    ASoC: cs35l56: Call pm_runtime_dont_use_autosuspend()

Arnaldo Carvalho de Melo <acme@redhat.com>
    perf build: Define YYNOMEM as YYNOABORT for bison < 3.81

Thomas Zimmermann <tzimmermann@suse.de>
    fbdev/sh7760fb: Depend on FB=y

Huacai Chen <chenhuacai@kernel.org>
    LoongArch: Set all reserved memblocks on Node#0 at initialization

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    LoongArch: Use _UL() and _ULL()

Yann Sionneau <ysionneau@kalray.eu>
    i2c: designware: fix __i2c_dw_disable() in case master is holding SCL low

Bob Peterson <rpeterso@redhat.com>
    gfs2: fix glock shrinker ref issues

Gerhard Engleder <gerhard@engleder-embedded.com>
    tsnep: Fix NAPI polling with budget 0

Gerhard Engleder <gerhard@engleder-embedded.com>
    tsnep: Fix ethtool channels

Gerhard Engleder <gerhard@engleder-embedded.com>
    tsnep: Fix NAPI scheduling

Sebastian Andrzej Siewior <bigeasy@linutronix.de>
    net: hsr: Add __packed to struct hsr_sup_tlv.

Johnathan Mantey <johnathanx.mantey@intel.com>
    ncsi: Propagate carrier gain/loss events to the NCSI controller

Benjamin Gray <bgray@linux.ibm.com>
    powerpc/watchpoints: Annotate atomic context in more places

Benjamin Gray <bgray@linux.ibm.com>
    powerpc/watchpoint: Disable pagefaults when getting user instruction

Benjamin Gray <bgray@linux.ibm.com>
    powerpc/watchpoints: Disable preemption in thread_change_pc()

Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
    ASoC: SOF: Intel: MTL: Reduce the DSP init timeout

Olga Kornievskaia <kolga@netapp.com>
    NFSv4.1: fix zero value filehandle in post open getattr

Hans Verkuil <hverkuil-cisco@xs4all.nl>
    media: vb2: frame_vector.c: replace WARN_ONCE with a comment

Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
    ASoC: SOF: sof-audio: Fix DSP core put imbalance on widget setup failure

Chancel Liu <chancel.liu@nxp.com>
    ASoC: imx-rpmsg: Set ignore_pmdown_time for dai_link

Mike Rapoport (IBM) <rppt@kernel.org>
    memblock tests: fix warning ‘struct seq_file’ declared inside parameter list

Mike Rapoport (IBM) <rppt@kernel.org>
    memblock tests: fix warning: "__ALIGN_KERNEL" redefined

Richard Fitzgerald <rf@opensource.cirrus.com>
    ASoC: wm_adsp: Fix missing locking in wm_adsp_[read|write]_ctl()

Richard Fitzgerald <rf@opensource.cirrus.com>
    firmware: cirrus: cs_dsp: Only log list of algorithms in debug build

Richard Fitzgerald <rf@opensource.cirrus.com>
    ASoC: cs42l42: Avoid stale SoundWire ATTACH after hard reset

Richard Fitzgerald <rf@opensource.cirrus.com>
    ASoC: cs42l42: Don't rely on GPIOD_OUT_LOW to set RESET initially low

Richard Fitzgerald <rf@opensource.cirrus.com>
    ASoC: cs42l42: Ensure a reset pulse meets minimum pulse width.

Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
    ALSA: hda: intel-sdw-acpi: Use u8 type for link index

Hans de Goede <hdegoede@redhat.com>
    ASoC: rt5640: Only cancel jack-detect work on suspend if active

Stanislav Fomichev <sdf@google.com>
    bpf: Clarify error expectations from bpf_clone_redirect

Hou Tao <houtao1@huawei.com>
    bpf: Ensure unit_size is matched with slab cache object size

Mika Westerberg <mika.westerberg@linux.intel.com>
    spi: intel-pci: Add support for Granite Rapids SPI serial flash

Shengjiu Wang <shengjiu.wang@nxp.com>
    ASoC: fsl: imx-pcm-rpmsg: Add SNDRV_PCM_INFO_BATCH flag

Valentin Caron <valentin.caron@foss.st.com>
    spi: stm32: add a delay before SPI disable

Han Xu <han.xu@nxp.com>
    spi: nxp-fspi: reset the FLSHxCR1 registers

Walt Holman <waltholman09@gmail.com>
    Add DMI ID for MSI Bravo 15 B7ED

Niklas Cassel <niklas.cassel@wdc.com>
    ata: libata-eh: do not thaw the port twice in ata_eh_reset()

Niklas Cassel <niklas.cassel@wdc.com>
    ata: libata-eh: do not clear ATA_PFLAG_EH_PENDING in ata_eh_reset()

Steve French <stfrench@microsoft.com>
    smb3: correct places where ENOTSUPP is used instead of preferred EOPNOTSUPP

Michal Grzedzicki <mge@meta.com>
    scsi: pm80xx: Avoid leaking tags when processing OPC_INB_SET_CONTROLLER_CONFIG command

Michal Grzedzicki <mge@meta.com>
    scsi: pm80xx: Use phy-specific SAS address when sending PHY_START command

Icenowy Zheng <uwu@icenowy.me>
    riscv: errata: fix T-Head dcache.cva encoding

Pratyush Yadav <ptyadav@amazon.de>
    nvme-pci: do not set the NUMA node of device if it has none

Josh Poimboeuf <jpoimboe@kernel.org>
    objtool: Fix _THIS_IP_ detection for cold functions

David Francis <David.Francis@amd.com>
    drm/amdgpu: Handle null atom context in VBIOS info ioctl

David Francis <David.Francis@amd.com>
    drm/amdkfd: Checkpoint and restore queues on GFX11

Hawking Zhang <Hawking.Zhang@amd.com>
    drm/amdgpu: fallback to old RAS error message for aqua_vanjaram

Alex Deucher <alexander.deucher@amd.com>
    drm/amdgpu/nbio4.3: set proper rmmio_remap.reg_offset for SR-IOV

Alex Deucher <alexander.deucher@amd.com>
    drm/amdgpu/soc21: don't remap HDP registers for SR-IOV

Swapnil Patel <swapnil.patel@amd.com>
    drm/amd/display: Don't check registers, if using AUX BL control

Mukul Joshi <mukul.joshi@amd.com>
    drm/amdkfd: Update CU masking for GFX 9.4.3

Mukul Joshi <mukul.joshi@amd.com>
    drm/amdkfd: Update cache info reporting for GFX v9.4.3

Mukul Joshi <mukul.joshi@amd.com>
    drm/amdgpu: Store CU info from all XCCs for GFX v9.4.3

Julia Lawall <Julia.Lawall@inria.fr>
    thermal/of: add missing of_node_put()

Luke D. Jones <luke@ljones.dev>
    platform/x86: asus-wmi: Support 2023 ROG X16 tablet mode

David Thompson <davthompson@nvidia.com>
    platform/mellanox: mlxbf-bootctl: add NET dependency into Kconfig

Ard Biesheuvel <ardb@kernel.org>
    efi/x86: Ensure that EFI_RUNTIME_MAP is enabled for kexec

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    ata: sata_mv: Fix incorrect string length computation in mv_dump_mem()

Guangguan Wang <guangguan.wang@linux.alibaba.com>
    net/smc: bugfix for smcr v2 server connect success statistic

Steven Rostedt (Google) <rostedt@goodmis.org>
    ring-buffer: Do not attempt to read past "commit"

Ricardo B. Marliere <rbmarliere@gmail.com>
    selftests: fix dependency checker script

Filipe Manana <fdmanana@suse.com>
    btrfs: assert delayed node locked when removing delayed item

Zheng Yejian <zhengyejian1@huawei.com>
    ring-buffer: Avoid softlockup in ring_buffer_resize()

Zheng Yejian <zhengyejian1@huawei.com>
    selftests/ftrace: Correctly enable event in instance-event.tc

Kiwoong Kim <kwmad.kim@samsung.com>
    scsi: ufs: core: Poll HCS.UCRDY before issuing a UIC command

Kiwoong Kim <kwmad.kim@samsung.com>
    scsi: ufs: core: Move __ufshcd_send_uic_cmd() outside host_lock

Javed Hasan <jhasan@marvell.com>
    scsi: qedf: Add synchronization between I/O completions and abort

Helge Deller <deller@gmx.de>
    parisc: irq: Make irq_stack_union static to avoid sparse warning

Helge Deller <deller@gmx.de>
    parisc: drivers: Fix sparse warning

Helge Deller <deller@gmx.de>
    parisc: iosapic.c: Fix sparse warnings

Helge Deller <deller@gmx.de>
    parisc: ccio-dma: Fix sparse warnings

Helge Deller <deller@gmx.de>
    parisc: sba-iommu: Fix sparse warnigs

Helge Deller <deller@gmx.de>
    parisc: sba: Fix compile warning wrt list of SBA devices

Nigel Kirkland <nkirkland2304@gmail.com>
    nvme-fc: Prevent null pointer dereference in nvme_fc_io_getuuid()

Tobias Schramm <t.schramm@manjaro.org>
    spi: sun6i: fix race between DMA RX transfer completion and RX FIFO drain

Tobias Schramm <t.schramm@manjaro.org>
    spi: sun6i: reduce DMA RX transfer width to single byte

Shubh <shubhisroking@gmail.com>
    ASoC: amd: yc: Add DMI entries to support Victus by HP Gaming Laptop 15-fb0xxx (8A3E)

Daniel Borkmann <daniel@iogearbox.net>
    bpf: Annotate bpf_long_memcpy with data_race

Sergey Senozhatsky <senozhatsky@chromium.org>
    dma-debug: don't call __dma_entry_alloc_check_leak() under free_entries_lock

Xiubo Li <xiubli@redhat.com>
    ceph: drop messages from MDS when unmounting

Sean Christopherson <seanjc@google.com>
    x86/reboot: VMCLEAR active VMCSes before emergency reboot

Chuck Lever <chuck.lever@oracle.com>
    NFSD: Fix zero NFSv4 READ results when RQ_SPLICE_OK is not set

William A. Kennington III <william@wkennington.com>
    i2c: npcm7xx: Fix callback completion ordering

Wenhua Lin <Wenhua.Lin@unisoc.com>
    gpio: pmic-eic-sprd: Add can_sleep flag for PMIC EIC chip

Karol Wachowski <karol.wachowski@linux.intel.com>
    accel/ivpu: Use cached buffers for FW loading

Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
    accel/ivpu: Do not use wait event interruptible

Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>
    i915/guc: Get runtime pm in busyness worker only if already active

Sudeep Holla <sudeep.holla@arm.com>
    firmware: arm_ffa: Don't set the memory region attributes for MEM_LEND

Rob Herring <robh@kernel.org>
    arm64: dts: imx: Add imx8mm-prt8mm.dtb to build

Liu Ying <victor.liu@nxp.com>
    arm64: dts: imx8mm-evk: Fix hdmi@3d node

Nathan Rossi <nathan.rossi@digi.com>
    soc: imx8m: Enable OCOTP clock for imx8mm before reading registers

Adam Ford <aford173@gmail.com>
    arm64: dts: imx8mp-beacon-kit: Fix audio_pll2 clock

Adam Ford <aford173@gmail.com>
    arm64: dts: imx8mp: Fix SDMA2/3 clocks

Michael Ellerman <mpe@ellerman.id.au>
    selftests/powerpc: Fix emit_tests to work with run_kselftest.sh

Michael Ellerman <mpe@ellerman.id.au>
    powerpc/stacktrace: Fix arch_stack_walk_reliable()

Chris Morgan <macromorgan@hotmail.com>
    power: supply: rk817: Fix node refcount leak

Max Filippov <jcmvbkbc@gmail.com>
    xtensa: boot/lib: fix function prototypes

Randy Dunlap <rdunlap@infradead.org>
    xtensa: umulsidi3: fix conditional expression

Randy Dunlap <rdunlap@infradead.org>
    xtensa: boot: don't add include-dirs

Randy Dunlap <rdunlap@infradead.org>
    xtensa: iss/network: make functions static

Max Filippov <jcmvbkbc@gmail.com>
    xtensa: add default definition for XCHAL_HAVE_DIV32

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    firmware: imx-dsp: Fix an error handling path in imx_dsp_setup_channels()

Sebastian Reichel <sebastian.reichel@collabora.com>
    power: supply: core: fix use after free in uevent

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    power: supply: rt9467: Fix rt9467_run_aicl()

Dan Carpenter <dan.carpenter@linaro.org>
    power: supply: ucs1002: fix error code in ucs1002_get_property()

Ross Lagerwall <ross.lagerwall@citrix.com>
    swiotlb: use the calculated number of areas

Tony Lindgren <tony@atomide.com>
    bus: ti-sysc: Fix SYSC_QUIRK_SWSUP_SIDLE_ACT handling for uart wake-up

Tony Lindgren <tony@atomide.com>
    ARM: dts: ti: omap: motorola-mapphone: Fix abe_clkctrl warning on boot

Tony Lindgren <tony@atomide.com>
    ARM: dts: ti: omap: Fix bandgap thermal cells addressing for omap3/4

Timo Alho <talho@nvidia.com>
    clk: tegra: fix error return case for recalc_rate

Marek Vasut <marex@denx.de>
    clk: si521xx: Fix regmap write accessor

Marek Vasut <marex@denx.de>
    clk: si521xx: Use REGCACHE_FLAT instead of NONE

Zhifeng Tang <zhifeng.tang@unisoc.com>
    clk: sprd: Fix thm_parents incorrect configuration

Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
    power: supply: mt6370: Fix missing error code in mt6370_chg_toggle_cfo()

Sibi Sankar <quic_sibis@quicinc.com>
    firmware: arm_scmi: Fixup perf power-cost/microwatt support

Cristian Marussi <cristian.marussi@arm.com>
    firmware: arm_scmi: Harden perf domain info access

Adam Ford <aford173@gmail.com>
    bus: ti-sysc: Fix missing AM35xx SoC matching

Julien Panis <jpanis@baylibre.com>
    bus: ti-sysc: Use fsleep() instead of usleep_range() in sysc_reset()

Charles Kearney <charles.kearney@hpe.com>
    spi: spi-gxp: BUG: Correct spi write return value

Christoph Hellwig <hch@lst.de>
    MIPS: Alchemy: only build mmc support helpers if au1xmmc is enabled

Jinjie Ruan <ruanjinjie@huawei.com>
    vfio/mdev: Fix a null-ptr-deref bug for mdev_unregister_parent()

Qu Wenruo <wqu@suse.com>
    btrfs: reset destination buffer when read_extent_buffer() gets invalid range

Al Viro <viro@zeniv.linux.org.uk>
    direct_write_fallback(): on error revert the ->ki_pos update from buffered write

Amit Pundir <amit.pundir@linaro.org>
    arm64: dts: qcom: sdm845-db845c: Mark cont splash memory region as reserved

Wenjing Liu <wenjing.liu@amd.com>
    drm/amd/display: fix a regression in blank pixel data caused by coding mistake

Wenjing Liu <wenjing.liu@amd.com>
    drm/amd/display: Update DPG test pattern programming

Richard Fitzgerald <rf@opensource.cirrus.com>
    ASoC: cs35l56: Disable low-power hibernation mode

Jiadong Zhu <Jiadong.Zhu@amd.com>
    drm/amdgpu: set completion status as preempted for the resubmission

Daniel Scally <dan.scally@ideasonboard.com>
    i2c: xiic: Correct return value check for xiic_reinit()

Liang He <windhl@126.com>
    i2c: mux: gpio: Add missing fwnode_handle_put()

Xiaoke Wang <xkernel.wang@foxmail.com>
    i2c: mux: demux-pinctrl: check the return value of devm_kstrdup()

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    gpio: tb10x: Fix an error handling path in tb10x_gpio_probe()

Zhang Xiaoxu <zhangxiaoxu5@huawei.com>
    cifs: Fix UAF in cifs_demultiplex_thread()

Ben Wolsieffer <ben.wolsieffer@hefring.com>
    proc: nommu: fix empty /proc/<pid>/maps

Ben Wolsieffer <Ben.Wolsieffer@hefring.com>
    proc: nommu: /proc/<pid>/maps: release mmap read lock

Alison Schofield <alison.schofield@intel.com>
    cxl/region: Match auto-discovered region decoders by HPA range

Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
    igc: Expose tx-usecs coalesce setting to user

Sebastian Andrzej Siewior <bigeasy@linutronix.de>
    octeontx2-pf: Do xdp_do_flush() after redirects.

Sebastian Andrzej Siewior <bigeasy@linutronix.de>
    bnxt_en: Flush XDP for bnxt_poll_nitroa0()'s NAPI

Sebastian Andrzej Siewior <bigeasy@linutronix.de>
    net: ena: Flush XDP packets on error.

Sebastian Andrzej Siewior <bigeasy@linutronix.de>
    locking/seqlock: Do the lockdep annotation before locking in do_write_seqcount_begin_nested()

José Pekkarinen <jose.pekkarinen@foxhound.fi>
    drm/virtio: clean out_fence on complete_submit

Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>
    i915/pmu: Move execlist stats initialization to execlist specific setup

Jinjie Ruan <ruanjinjie@huawei.com>
    net/handshake: Fix memory leak in __sock_create() and sock_alloc_file()

Cai Huoqing <cai.huoqing@linux.dev>
    net: hinic: Fix warning-hinic_set_vlan_fliter() warn: variable dereferenced before check 'hwdev'

Jozsef Kadlecsik <kadlec@netfilter.org>
    netfilter: ipset: Fix race between IPSET_CMD_CREATE and IPSET_CMD_SWAP

Florian Westphal <fw@strlen.de>
    netfilter: nf_tables: disable toggling dormant table state more than once

Benjamin Poirier <bpoirier@nvidia.com>
    vxlan: Add missing entries to vxlan_get_size()

Artem Chernyshev <artem.chernyshev@red-soft.ru>
    net: rds: Fix possible NULL-pointer dereference

Mark Rutland <mark.rutland@arm.com>
    locking/atomic: scripts: fix fallback ifdeffery

Ziyang Xuan <william.xuanziyang@huawei.com>
    team: fix null-ptr-deref when team device type is changed

Eric Dumazet <edumazet@google.com>
    net: bridge: use DEV_STATS_INC()

Jie Wang <wangjie125@huawei.com>
    net: hns3: add 5ms delay before clear firmware reset irq source

Jijie Shao <shaojijie@huawei.com>
    net: hns3: fix fail to delete tc flower rules during reset issue

Jian Shen <shenjian15@huawei.com>
    net: hns3: only enable unicast promisc when mac table full

Jie Wang <wangjie125@huawei.com>
    net: hns3: fix GRE checksum offload issue

Jie Wang <wangjie125@huawei.com>
    net: hns3: add cmdq check for vf periodic service task

Josh Poimboeuf <jpoimboe@kernel.org>
    x86/srso: Fix SBPB enablement for spec_rstack_overflow=off

Josh Poimboeuf <jpoimboe@kernel.org>
    x86/srso: Don't probe microcode in a guest

Josh Poimboeuf <jpoimboe@kernel.org>
    x86/srso: Set CPUID feature bits independently of bug or mitigation status

Josh Poimboeuf <jpoimboe@kernel.org>
    x86/srso: Fix srso_show_state() side effect

Vincent Whitchurch <vincent.whitchurch@axis.com>
    x86/asm: Fix build of UML with KASAN

Stephen Boyd <swboyd@chromium.org>
    platform/x86: intel_scu_ipc: Fail IPC send if still busy

Stephen Boyd <swboyd@chromium.org>
    platform/x86: intel_scu_ipc: Don't override scu in intel_scu_ipc_dev_simple_command()

Stephen Boyd <swboyd@chromium.org>
    platform/x86: intel_scu_ipc: Check status upon timeout in ipc_wait_for_interrupt()

Stephen Boyd <swboyd@chromium.org>
    platform/x86: intel_scu_ipc: Check status after timeout in busy_loop()

Lukasz Majewski <lukma@denx.de>
    net: hsr: Properly parse HSRv1 supervisor frames.

Rik van Riel <riel@surriel.com>
    x86/mm, kexec, ima: Use memblock_free_late() from ima_free_kexec_buffer()

Eric Dumazet <edumazet@google.com>
    dccp: fix dccp_v4_err()/dccp_v6_err() again

Benjamin Gray <bgray@linux.ibm.com>
    powerpc/dexcr: Move HASHCHK trap handler

Kajol Jain <kjain@linux.ibm.com>
    powerpc/perf/hv-24x7: Update domain value check

Eric Dumazet <edumazet@google.com>
    scsi: iscsi_tcp: restrict to TCP sockets

Kyle Zeng <zengyhkyle@gmail.com>
    ipv4: fix null-deref in ipv4_link_failure

Vinicius Costa Gomes <vinicius.gomes@intel.com>
    igc: Fix infinite initialization loop with early XDP redirect

David Christensen <drc@linux.vnet.ibm.com>
    ionic: fix 16bit math issue when PAGE_SIZE >= 64KB

Ilya Leoshkevich <iii@linux.ibm.com>
    netfilter, bpf: Adjust timeouts of non-confirmed CTs in bpf_ct_insert_entry()

Ivan Vecera <ivecera@redhat.com>
    i40e: Fix VF VLAN offloading when port VLAN is configured

Petr Oros <poros@redhat.com>
    iavf: schedule a request immediately after add/delete vlan

Petr Oros <poros@redhat.com>
    iavf: add iavf_schedule_aq_request() helper

Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
    ASoC: SOF: core: Only call sof_ops_free() on remove if the probe was successful

Radoslaw Tyl <radoslawx.tyl@intel.com>
    iavf: do not process adminq tasks when __IAVF_IN_REMOVE_TASK is set

Shinas Rasheed <srasheed@marvell.com>
    octeon_ep: fix tx dma unmap len values in SG

Shengjiu Wang <shengjiu.wang@nxp.com>
    ASoC: imx-audmix: Fix return error with devm_clk_get()

Chen Ni <nichen@iscas.ac.cn>
    ASoC: hdaudio.c: Add missing check for devm_kstrdup

Takashi Iwai <tiwai@suse.de>
    ALSA: seq: ump: Fix -Wformat-truncation warning

Sasha Neftin <sasha.neftin@intel.com>
    net/core: Fix ETH_P_1588 flow dissector

Sabrina Dubroca <sd@queasysnail.net>
    selftests: tls: swap the TX and RX sockets in some tests

Jinjie Ruan <ruanjinjie@huawei.com>
    net: microchip: sparx5: Fix possible memory leaks in vcap_api_kunit

Jinjie Ruan <ruanjinjie@huawei.com>
    net: microchip: sparx5: Fix possible memory leaks in test_vcap_xn_rule_creator()

Jinjie Ruan <ruanjinjie@huawei.com>
    net: microchip: sparx5: Fix possible memory leak in vcap_api_encode_rule_test()

Jinjie Ruan <ruanjinjie@huawei.com>
    net: microchip: sparx5: Fix memory leak for vcap_api_rule_add_actionvalue_test()

Jinjie Ruan <ruanjinjie@huawei.com>
    net: microchip: sparx5: Fix memory leak for vcap_api_rule_add_keyvalue_test()

Bard Liao <yung-chuan.liao@linux.intel.com>
    ASoC: SOF: ipc4-topology: fix wrong sizeof argument

Rong Tao <rongtao@cestc.cn>
    memblock tests: Fix compilation errors.

Alexey Dobriyan <adobriyan@gmail.com>
    uapi: stddef.h: Fix __DECLARE_FLEX_ARRAY for C++

Alexey Dobriyan <adobriyan@gmail.com>
    uapi: stddef.h: Fix header guard location

Kees Cook <keescook@chromium.org>
    Compiler Attributes: counted_by: Adjust name and identifier expansion

Phil Sutter <phil@nwl.cc>
    netfilter: nf_tables: Fix entries val in rule reset audit log

Florian Westphal <fw@strlen.de>
    netfilter: conntrack: fix extension size table

Knyazev Arseniy <poseaydone@ya.ru>
    ALSA: hda/realtek: Splitting the UX3402 into two separate models

Artem Savkov <asavkov@redhat.com>
    selftests/bpf: fix unpriv_disabled check in test_verifier

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    bpf: Fix a erroneous check after snprintf()

Hans de Goede <hdegoede@redhat.com>
    ASoC: rt5640: Fix IRQ not being free-ed for HDA jack detect mode

Hans de Goede <hdegoede@redhat.com>
    ASoC: rt5640: Enable the IRQ on resume after configuring jack-detect

Hans de Goede <hdegoede@redhat.com>
    ASoC: rt5640: Do not disable/enable IRQ twice on suspend/resume

Senhong Liu <liusenhong2022@email.szu.edu.cn>
    ASoC: rt5640: fix typos

Hans de Goede <hdegoede@redhat.com>
    ASoC: rt5640: Fix sleep in atomic context

Hans de Goede <hdegoede@redhat.com>
    ASoC: rt5640: Revert "Fix sleep in atomic context"

Takashi Iwai <tiwai@suse.de>
    ALSA: seq: Avoid delivery of events for disabled UMP groups

Takashi Iwai <tiwai@suse.de>
    ALSA: docs: Fix a typo of midi2_ump_probe option for snd-usb-audio

Eduard Zingerman <eddyz87@gmail.com>
    bpf: Avoid dummy bpf_offload_netdev in __bpf_prog_dev_bound_init

Toke Høiland-Jørgensen <toke@redhat.com>
    bpf: Avoid deadlock when using queue and stack maps from NMI

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: disallow element removal on anonymous sets

Jerome Brunet <jbrunet@baylibre.com>
    ASoC: meson: spdifin: start hw on dai probe

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: disallow rule removal from chain binding

Florian Westphal <fw@strlen.de>
    netfilter: nf_tables: fix memleak when more than 255 elements expired

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nft_set_hash: try later when GC hits EAGAIN on iteration

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nft_set_pipapo: stop GC iteration if GC transaction allocation fails

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nft_set_pipapo: call nft_trans_gc_queue_sync() in catchall GC

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nft_set_rbtree: use read spinlock to avoid datapath contention

Jan Kara <jack@suse.cz>
    ext4: do not let fstrim block system suspend

Jan Kara <jack@suse.cz>
    ext4: move setting of trimmed bit into ext4_try_to_trim_range()

Kemeng Shi <shikemeng@huaweicloud.com>
    ext4: replace the traditional ternary conditional operator with with max()/min()

Filipe Manana <fdmanana@suse.com>
    btrfs: remove BUG() after failure to insert delayed dir index item

Filipe Manana <fdmanana@suse.com>
    btrfs: improve error message after failure to add delayed dir index item

Dave Wysochanski <dwysocha@redhat.com>
    netfs: Only call folio_start_fscache() one time for each folio

Andreas Gruenbacher <agruenba@redhat.com>
    gfs2: Fix another freeze/thaw hang

Sakari Ailus <sakari.ailus@linux.intel.com>
    media: via: Use correct dependency for camera sensor drivers

Sakari Ailus <sakari.ailus@linux.intel.com>
    media: v4l: Use correct dependency for camera sensor drivers

Olga Kornievskaia <kolga@netapp.com>
    NFSv4.1: fix pnfs MDS=DS session trunking

Olga Kornievskaia <kolga@netapp.com>
    NFSv4.1: use EXCHGID4_FLAG_USE_PNFS_DS for DS server

Trond Myklebust <trond.myklebust@hammerspace.com>
    SUNRPC: Mark the cred for revalidation if the server rejects it

Trond Myklebust <trond.myklebust@hammerspace.com>
    NFS/pNFS: Report EINVAL errors from connect() to the server

Trond Myklebust <trond.myklebust@hammerspace.com>
    NFS: More fixes for nfs_direct_write_reschedule_io()

Trond Myklebust <trond.myklebust@hammerspace.com>
    NFS: Use the correct commit info in nfs_join_page_group()

Trond Myklebust <trond.myklebust@hammerspace.com>
    NFS: More O_DIRECT accounting fixes for error paths

Trond Myklebust <trond.myklebust@hammerspace.com>
    NFS: Fix O_DIRECT locking issues

Trond Myklebust <trond.myklebust@hammerspace.com>
    NFS: Fix error handling for O_DIRECT write scheduling


-------------

Diffstat:

 Documentation/admin-guide/cgroup-v1/memory.rst     |   9 +-
 Documentation/sound/designs/midi-2.0.rst           |   4 +-
 Makefile                                           |   4 +-
 .../boot/dts/ti/omap/motorola-mapphone-common.dtsi |   4 +-
 arch/arm/boot/dts/ti/omap/omap3-cpu-thermal.dtsi   |   3 +-
 arch/arm/boot/dts/ti/omap/omap4-cpu-thermal.dtsi   |   5 +-
 arch/arm/boot/dts/ti/omap/omap443x.dtsi            |   1 +
 arch/arm/boot/dts/ti/omap/omap4460.dtsi            |   1 +
 arch/arm64/boot/dts/freescale/Makefile             |   1 +
 arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi      |  32 +-
 .../arm64/boot/dts/freescale/imx8mp-beacon-kit.dts |   5 +-
 arch/arm64/boot/dts/freescale/imx8mp.dtsi          |   6 +
 arch/arm64/boot/dts/qcom/sdm845-db845c.dts         |   9 +
 arch/arm64/configs/defconfig                       |   1 -
 arch/loongarch/include/asm/addrspace.h             |  14 +-
 arch/loongarch/include/asm/elf.h                   |   9 +
 arch/loongarch/kernel/mem.c                        |   4 +-
 arch/loongarch/kernel/module.c                     |  22 +-
 arch/loongarch/kernel/numa.c                       |   2 +-
 arch/loongarch/kernel/vmlinux.lds.S                |  55 +--
 arch/mips/alchemy/devboards/db1000.c               |   4 +
 arch/mips/alchemy/devboards/db1200.c               |   6 +
 arch/mips/alchemy/devboards/db1300.c               |   4 +
 arch/parisc/include/asm/ropes.h                    |   7 +-
 arch/parisc/kernel/drivers.c                       |   2 +-
 arch/parisc/kernel/irq.c                           |   2 +-
 arch/powerpc/kernel/hw_breakpoint.c                |  16 +-
 arch/powerpc/kernel/hw_breakpoint_constraints.c    |   7 +-
 arch/powerpc/kernel/stacktrace.c                   |  27 +-
 arch/powerpc/kernel/traps.c                        |  56 ++-
 arch/powerpc/perf/hv-24x7.c                        |   2 +-
 arch/riscv/include/asm/errata_list.h               |   4 +-
 arch/x86/Kconfig                                   |   2 +-
 arch/x86/include/asm/kexec.h                       |   2 -
 arch/x86/include/asm/kvm_host.h                    |   3 +-
 arch/x86/include/asm/linkage.h                     |   7 +
 arch/x86/include/asm/processor.h                   |   2 -
 arch/x86/include/asm/reboot.h                      |   2 +
 arch/x86/kernel/cpu/amd.c                          |  28 +-
 arch/x86/kernel/cpu/bugs.c                         |  17 +-
 arch/x86/kernel/cpu/common.c                       |   2 +-
 arch/x86/kernel/cpu/sgx/encl.c                     |  30 +-
 arch/x86/kernel/crash.c                            |  31 --
 arch/x86/kernel/reboot.c                           |  22 ++
 arch/x86/kernel/setup.c                            |   8 +-
 arch/x86/kvm/mmu/mmu.c                             |  20 +-
 arch/x86/kvm/mmu/mmu_internal.h                    |  15 +-
 arch/x86/kvm/mmu/tdp_mmu.c                         | 152 ++++----
 arch/x86/kvm/mmu/tdp_mmu.h                         |   5 +-
 arch/x86/kvm/svm/sev.c                             |  34 +-
 arch/x86/kvm/svm/svm.c                             |   9 +-
 arch/x86/kvm/svm/svm.h                             |   1 +
 arch/x86/kvm/vmx/vmx.c                             |  10 +-
 arch/x86/kvm/x86.c                                 |   5 +-
 arch/x86/lib/memcpy_64.S                           |   2 +-
 arch/x86/lib/memmove_64.S                          |   2 +-
 arch/x86/lib/memset_64.S                           |   2 +-
 arch/xtensa/boot/Makefile                          |   3 +-
 arch/xtensa/boot/lib/zmem.c                        |   5 +-
 arch/xtensa/include/asm/core.h                     |   4 +
 arch/xtensa/lib/umulsidi3.S                        |   4 +-
 arch/xtensa/platforms/iss/network.c                |   4 +-
 crypto/sm2.c                                       |   6 +-
 drivers/accel/ivpu/ivpu_fw.c                       |   8 +-
 drivers/accel/ivpu/ivpu_gem.h                      |   5 +
 drivers/accel/ivpu/ivpu_ipc.c                      |  11 +-
 drivers/acpi/nfit/core.c                           |   2 +-
 drivers/ata/libata-core.c                          |  47 ++-
 drivers/ata/libata-eh.c                            |  16 +-
 drivers/ata/libata-scsi.c                          |  53 ++-
 drivers/ata/libata-transport.c                     |   9 +-
 drivers/ata/libata.h                               |   2 +
 drivers/ata/sata_mv.c                              |   4 +-
 drivers/block/rbd.c                                | 416 +++++++++++----------
 drivers/bus/ti-sysc.c                              |  31 +-
 drivers/char/agp/parisc-agp.c                      |   2 -
 drivers/clk/clk-si521xx.c                          |   9 +-
 drivers/clk/sprd/ums512-clk.c                      |   2 +-
 drivers/clk/tegra/clk-bpmp.c                       |   2 +-
 drivers/cxl/core/mbox.c                            |  23 +-
 drivers/cxl/core/port.c                            |  13 +-
 drivers/cxl/core/region.c                          |  24 +-
 drivers/cxl/pci.c                                  |   6 +-
 drivers/firewire/sbp2.c                            |   9 +-
 drivers/firmware/arm_ffa/driver.c                  |  16 +-
 drivers/firmware/arm_scmi/perf.c                   |  93 +++--
 drivers/firmware/cirrus/cs_dsp.c                   |  34 +-
 drivers/firmware/imx/imx-dsp.c                     |   1 +
 drivers/gpio/gpio-pmic-eic-sprd.c                  |   1 +
 drivers/gpio/gpio-tb10x.c                          |   6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c         |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h            |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c            |  19 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c            |   6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h       |   9 +
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c             |   2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c             |   2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c              |   2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c              |   2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c              |   2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c              |   7 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c            |  72 ++--
 drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c             |   3 +
 drivers/gpu/drm/amd/amdgpu/soc21.c                 |   2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c              |   3 +-
 drivers/gpu/drm/amd/amdkfd/kfd_crat.h              |   4 +
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c  |   2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c       |  34 +-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h       |   2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c   |   2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c   |   2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c   |  43 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c    |  44 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c    |   2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c          |  75 ++--
 drivers/gpu/drm/amd/amdkfd/kfd_topology.h          |   2 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |   4 +-
 .../amd/display/dc/dce110/dce110_hw_sequencer.c    |   4 +-
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c |  47 +--
 .../amd/display/dc/link/accessories/link_dp_cts.c  | 105 +++---
 drivers/gpu/drm/amd/include/kgd_kfd_interface.h    |   6 +-
 drivers/gpu/drm/i915/gem/i915_gem_shmem.c          |  11 +-
 drivers/gpu/drm/i915/gt/intel_engine_cs.c          |   1 -
 .../gpu/drm/i915/gt/intel_execlists_submission.c   |   2 +
 drivers/gpu/drm/i915/gt/intel_ggtt.c               |  23 +-
 drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c  |  38 +-
 drivers/gpu/drm/meson/meson_encoder_hdmi.c         |   2 +
 drivers/gpu/drm/tests/drm_mm_test.c                |   2 +-
 drivers/gpu/drm/virtio/virtgpu_submit.c            |   1 -
 drivers/i2c/busses/i2c-designware-common.c         |  17 +
 drivers/i2c/busses/i2c-designware-core.h           |   3 +
 drivers/i2c/busses/i2c-i801.c                      |   1 +
 drivers/i2c/busses/i2c-npcm7xx.c                   |  17 +-
 drivers/i2c/busses/i2c-xiic.c                      |   2 +-
 drivers/i2c/muxes/i2c-demux-pinctrl.c              |   4 +
 drivers/i2c/muxes/i2c-mux-gpio.c                   |   4 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c    |  27 +-
 drivers/media/common/videobuf2/frame_vector.c      |   6 +-
 drivers/media/platform/marvell/Kconfig             |   4 +-
 drivers/media/platform/via/Kconfig                 |   2 +-
 drivers/media/usb/em28xx/Kconfig                   |   4 +-
 drivers/media/usb/go7007/Kconfig                   |   2 +-
 drivers/media/usb/uvc/uvc_ctrl.c                   |   3 +
 drivers/misc/cardreader/rts5227.c                  |  55 +--
 drivers/misc/cardreader/rts5228.c                  |  57 +--
 drivers/misc/cardreader/rts5249.c                  |  56 +--
 drivers/misc/cardreader/rts5260.c                  |  43 +--
 drivers/misc/cardreader/rts5261.c                  |  52 +--
 drivers/misc/cardreader/rtsx_pcr.c                 |  51 ++-
 drivers/net/ethernet/amazon/ena/ena_netdev.c       |   3 +
 drivers/net/ethernet/broadcom/bnxt/bnxt.c          |   5 +
 drivers/net/ethernet/engleder/tsnep_ethtool.c      |   6 +-
 drivers/net/ethernet/engleder/tsnep_main.c         |  18 +-
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c    |   9 +
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    |  13 +-
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c  |   3 +-
 drivers/net/ethernet/huawei/hinic/hinic_port.c     |   3 -
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |   8 +-
 drivers/net/ethernet/intel/iavf/iavf.h             |   2 +-
 drivers/net/ethernet/intel/iavf/iavf_ethtool.c     |   2 +-
 drivers/net/ethernet/intel/iavf/iavf_main.c        |  17 +-
 drivers/net/ethernet/intel/igc/igc_ethtool.c       |  31 +-
 drivers/net/ethernet/intel/igc/igc_main.c          |   2 +-
 .../net/ethernet/marvell/octeon_ep/octep_main.c    |   8 +-
 drivers/net/ethernet/marvell/octeon_ep/octep_tx.c  |   8 +-
 drivers/net/ethernet/marvell/octeon_ep/octep_tx.h  |  16 +-
 .../net/ethernet/marvell/octeontx2/nic/otx2_txrx.c |  19 +-
 .../net/ethernet/microchip/vcap/vcap_api_kunit.c   |  59 ++-
 drivers/net/ethernet/pensando/ionic/ionic_dev.h    |   1 +
 drivers/net/ethernet/pensando/ionic/ionic_txrx.c   |  10 +-
 drivers/net/team/team.c                            |  10 +-
 drivers/net/thunderbolt/main.c                     |   3 +-
 drivers/net/vxlan/vxlan_core.c                     |   4 +
 drivers/nvme/host/fc.c                             |   2 +-
 drivers/nvme/host/pci.c                            |   3 -
 drivers/parisc/ccio-dma.c                          |  18 +-
 drivers/parisc/iommu-helpers.h                     |   8 +-
 drivers/parisc/iosapic.c                           |   4 +-
 drivers/parisc/iosapic_private.h                   |   4 +-
 drivers/parisc/sba_iommu.c                         |  28 +-
 drivers/platform/mellanox/Kconfig                  |   1 +
 drivers/platform/x86/asus-nb-wmi.c                 |   9 +
 drivers/platform/x86/intel_scu_ipc.c               |  66 ++--
 drivers/power/supply/ab8500_btemp.c                |   9 +-
 drivers/power/supply/ab8500_chargalg.c             |   2 +-
 drivers/power/supply/mt6370-charger.c              |   2 +-
 drivers/power/supply/power_supply_sysfs.c          |   7 +
 drivers/power/supply/rk817_charger.c               |  16 +-
 drivers/power/supply/rt9467-charger.c              |   4 +-
 drivers/power/supply/ucs1002_power.c               |   3 +-
 drivers/scsi/iscsi_tcp.c                           |   4 +
 drivers/scsi/pm8001/pm8001_hwi.c                   |   2 +-
 drivers/scsi/pm8001/pm80xx_hwi.c                   |   4 +-
 drivers/scsi/qedf/qedf_io.c                        |  10 +-
 drivers/scsi/qedf/qedf_main.c                      |   7 +-
 drivers/scsi/scsi.c                                |  11 +
 drivers/scsi/scsi_scan.c                           |   2 +-
 drivers/scsi/sd.c                                  | 101 ++++-
 drivers/scsi/sd.h                                  |   1 +
 drivers/soc/imx/soc-imx8m.c                        |  10 +
 drivers/spi/spi-gxp.c                              |   2 +-
 drivers/spi/spi-intel-pci.c                        |   1 +
 drivers/spi/spi-nxp-fspi.c                         |   7 +
 drivers/spi/spi-stm32.c                            |   8 +
 drivers/spi/spi-sun6i.c                            |  31 +-
 drivers/spi/spi-zynqmp-gqspi.c                     |  12 +-
 drivers/thermal/thermal_of.c                       |   8 +-
 drivers/thermal/thermal_sysfs.c                    |   9 +-
 drivers/tty/n_gsm.c                                |   4 +-
 drivers/tty/serial/8250/8250_port.c                |   5 +-
 drivers/ufs/core/ufshcd.c                          |  13 +-
 drivers/vfio/mdev/mdev_sysfs.c                     |   3 +-
 drivers/video/fbdev/Kconfig                        |   2 +-
 fs/binfmt_elf_fdpic.c                              |   5 +-
 fs/btrfs/delayed-inode.c                           |  85 +++--
 fs/btrfs/extent_io.c                               |   8 +-
 fs/btrfs/file.c                                    |  16 +-
 fs/btrfs/inode.c                                   |  29 +-
 fs/btrfs/super.c                                   |   2 +-
 fs/ceph/caps.c                                     |   6 +-
 fs/ceph/mds_client.c                               |  12 +-
 fs/ceph/mds_client.h                               |  11 +-
 fs/ceph/quota.c                                    |  14 +-
 fs/ceph/snap.c                                     |  10 +-
 fs/ceph/super.c                                    |  75 +++-
 fs/ceph/super.h                                    |   3 +
 fs/ext4/mballoc.c                                  |  60 +--
 fs/gfs2/glock.c                                    |   4 +-
 fs/gfs2/glops.c                                    |   9 +-
 fs/libfs.c                                         |   1 +
 fs/netfs/buffered_read.c                           |   6 +-
 fs/nfs/direct.c                                    | 134 +++++--
 fs/nfs/flexfilelayout/flexfilelayout.c             |   1 +
 fs/nfs/nfs4client.c                                |   9 +-
 fs/nfs/nfs4proc.c                                  |  14 +-
 fs/nfs/nfs4state.c                                 |  38 +-
 fs/nfs/write.c                                     |  23 +-
 fs/nfsd/nfs4xdr.c                                  |   4 +-
 fs/nilfs2/gcinode.c                                |   6 +-
 fs/proc/internal.h                                 |   2 -
 fs/proc/task_nommu.c                               |  70 ++--
 fs/smb/client/cifsglob.h                           |   1 +
 fs/smb/client/fs_context.c                         |   1 +
 fs/smb/client/inode.c                              |   2 +-
 fs/smb/client/smb2ops.c                            |   6 +-
 fs/smb/client/transport.c                          |  34 +-
 include/linux/atomic/atomic-arch-fallback.h        |  10 +-
 include/linux/bpf.h                                |   2 +-
 include/linux/btf_ids.h                            |   2 +-
 include/linux/compiler_attributes.h                |  26 +-
 include/linux/if_team.h                            |   2 +
 include/linux/interrupt.h                          |   6 +-
 include/linux/libata.h                             |   4 +-
 include/linux/memcontrol.h                         |   4 +-
 include/linux/nfs_fs_sb.h                          |   1 +
 include/linux/nfs_page.h                           |   4 +-
 include/linux/resume_user_mode.h                   |   2 +-
 include/linux/seqlock.h                            |   2 +-
 include/net/netfilter/nf_tables.h                  |   7 +-
 include/scsi/scsi.h                                |   3 +
 include/scsi/scsi_device.h                         |   5 +-
 include/uapi/linux/bpf.h                           |   4 +-
 include/uapi/linux/stddef.h                        |  11 +
 io_uring/fs.c                                      |   2 +-
 kernel/bpf/btf.c                                   |   2 +-
 kernel/bpf/memalloc.c                              |  33 +-
 kernel/bpf/offload.c                               |  12 +-
 kernel/bpf/queue_stack_maps.c                      |  21 +-
 kernel/dma/debug.c                                 |  20 +-
 kernel/dma/swiotlb.c                               |   4 +-
 kernel/sched/core.c                                |   2 +-
 kernel/sched/cpupri.c                              |   1 +
 kernel/sched/idle.c                                |   1 +
 kernel/trace/bpf_trace.c                           |  16 +
 kernel/trace/ring_buffer.c                         |  38 +-
 kernel/trace/trace_events_user.c                   |  58 ++-
 mm/damon/vaddr-test.h                              |   2 +
 mm/memcontrol.c                                    |  13 +-
 mm/mempolicy.c                                     |  39 +-
 mm/page_alloc.c                                    |  12 +-
 mm/slab_common.c                                   |  12 +-
 net/bridge/br_forward.c                            |   4 +-
 net/bridge/br_input.c                              |   4 +-
 net/core/flow_dissector.c                          |   2 +-
 net/dccp/ipv4.c                                    |   9 +-
 net/dccp/ipv6.c                                    |   9 +-
 net/handshake/handshake-test.c                     |  14 +-
 net/hsr/hsr_framereg.c                             |   4 +-
 net/hsr/hsr_main.h                                 |   2 +-
 net/ipv4/route.c                                   |   4 +-
 net/mptcp/options.c                                |   5 +-
 net/mptcp/protocol.c                               |  41 ++
 net/mptcp/subflow.c                                |  36 --
 net/ncsi/ncsi-aen.c                                |   5 +
 net/netfilter/ipset/ip_set_core.c                  |  12 +-
 net/netfilter/nf_conntrack_bpf.c                   |   2 +
 net/netfilter/nf_conntrack_extend.c                |   4 +-
 net/netfilter/nf_tables_api.c                      |  79 +++-
 net/netfilter/nft_set_hash.c                       |  11 +-
 net/netfilter/nft_set_pipapo.c                     |   4 +-
 net/netfilter/nft_set_rbtree.c                     |   8 +-
 net/rds/rdma_transport.c                           |  12 +-
 net/smc/smc_stats.h                                |   3 +-
 net/sunrpc/clnt.c                                  |  15 +-
 scripts/atomic/gen-atomic-fallback.sh              |   2 +-
 sound/core/rawmidi.c                               |   2 +-
 sound/core/seq/seq_ump_client.c                    |  24 +-
 sound/core/seq/seq_ump_convert.c                   |   2 +
 sound/hda/intel-sdw-acpi.c                         |   8 +-
 sound/pci/hda/hda_intel.c                          |   1 +
 sound/pci/hda/patch_realtek.c                      |   3 +-
 sound/soc/amd/yc/acp6x-mach.c                      |  35 ++
 sound/soc/codecs/cs35l56-i2c.c                     |   1 -
 sound/soc/codecs/cs35l56.c                         |   1 +
 sound/soc/codecs/cs42l42-sdw.c                     |  20 +
 sound/soc/codecs/cs42l42.c                         |  21 +-
 sound/soc/codecs/cs42l42.h                         |   1 +
 sound/soc/codecs/rt5640.c                          |  33 +-
 sound/soc/codecs/wm_adsp.c                         |  13 +-
 sound/soc/fsl/imx-audmix.c                         |   2 +-
 sound/soc/fsl/imx-pcm-rpmsg.c                      |   1 +
 sound/soc/fsl/imx-rpmsg.c                          |   8 +
 sound/soc/intel/avs/boards/hdaudio.c               |   3 +
 sound/soc/meson/axg-spdifin.c                      |  49 +--
 sound/soc/sof/core.c                               |   3 +-
 sound/soc/sof/intel/mtl.c                          |   2 +-
 sound/soc/sof/intel/mtl.h                          |   1 -
 sound/soc/sof/ipc4-topology.c                      |   2 +-
 sound/soc/sof/sof-audio.c                          |   3 +-
 tools/include/linux/btf_ids.h                      |   2 +-
 tools/include/linux/mm.h                           |   4 +-
 tools/include/linux/seq_file.h                     |   2 +
 tools/include/uapi/linux/bpf.h                     |   4 +-
 tools/objtool/check.c                              |   3 +-
 tools/perf/util/Build                              |   6 +
 tools/testing/memblock/internal.h                  |   4 +
 tools/testing/memblock/mmzone.c                    |   2 +-
 tools/testing/memblock/tests/basic_api.c           |   2 +-
 tools/testing/memblock/tests/common.h              |   1 +
 tools/testing/selftests/bpf/test_verifier.c        |   2 +-
 .../ftrace/test.d/instances/instance-event.tc      |   2 +-
 tools/testing/selftests/kselftest_deps.sh          |  77 +++-
 .../selftests/mm/charge_reserved_hugetlb.sh        |   4 +-
 .../selftests/mm/hugetlb_reparenting_test.sh       |   4 +-
 tools/testing/selftests/net/tls.c                  |   8 +-
 tools/testing/selftests/powerpc/Makefile           |   7 +-
 tools/testing/selftests/powerpc/pmu/Makefile       |  11 +-
 347 files changed, 3207 insertions(+), 1871 deletions(-)


