Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EF9C7F9388
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 16:47:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232345AbjKZPrj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 10:47:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231926AbjKZPrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 10:47:17 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E4F410E7
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 07:46:49 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BD9BC433CB;
        Sun, 26 Nov 2023 15:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1701013609;
        bh=Qnu61ix1x1S66YzaB8zcqkwaN4s/YdzuNq9ovuz2uUc=;
        h=From:To:Cc:Subject:Date:From;
        b=MVAkroyvmyKCSWWwFFNX34PnSeBHXFxHkhDHoBSjRuyOsSz1LwCCx700BNBkaKzZo
         17x2b1VcSaxSktIgCa+PD7HyCegQnTQyeGugesAQGpQFmImAPzLHRWulqyr1iOPtEB
         gLGsAVPA3yP9euQCiCEkwG2Bo8C1WnwlSJxE4ACU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        allen.lkml@gmail.com
Subject: [PATCH 5.15 000/292] 5.15.140-rc3 review
Date:   Sun, 26 Nov 2023 15:46:45 +0000
Message-ID: <20231126154348.824037389@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.140-rc3.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.15.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.15.140-rc3
X-KernelTest-Deadline: 2023-11-28T15:43+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 5.15.140 release.
There are 292 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Tue, 28 Nov 2023 15:43:06 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.140-rc3.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 5.15.140-rc3

Saravana Kannan <saravanak@google.com>
    driver core: Release all resources during unbind before updating device links

Vicki Pfau <vi@endrift.com>
    Input: xpad - add VID for Turtle Beach controllers

Steven Rostedt (Google) <rostedt@goodmis.org>
    tracing: Have trace_event_file have ref counters

Michael Ellerman <mpe@ellerman.id.au>
    powerpc/powernv: Fix fortify source warnings in opal-prd.c

Jens Axboe <axboe@kernel.dk>
    io_uring/fdinfo: lock SQ thread while retrieving thread cpu/pid

Lewis Huang <lewis.huang@amd.com>
    drm/amd/display: Change the DMCUB mailbox memory location from FB to inbox

Christian König <christian.koenig@amd.com>
    drm/amdgpu: fix error handling in amdgpu_bo_list_get()

Alex Deucher <alexander.deucher@amd.com>
    drm/amdgpu: don't use ATRM for external devices

Kunwu Chan <chentao@kylinos.cn>
    drm/i915: Fix potential spectre vulnerability

Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
    drm/amd/pm: Handle non-terminated overdrive commands.

Kemeng Shi <shikemeng@huaweicloud.com>
    ext4: add missed brelse in update_backups

Kemeng Shi <shikemeng@huaweicloud.com>
    ext4: remove gdb backup copy for meta bg in setup_new_flex_group_blocks

Zhang Yi <yi.zhang@huawei.com>
    ext4: correct the start block of counting reserved clusters

Kemeng Shi <shikemeng@huaweicloud.com>
    ext4: correct return value of ext4_convert_meta_bg

Kemeng Shi <shikemeng@huaweicloud.com>
    ext4: correct offset of gdb backup in non meta_bg group to update_backups

Max Kellermann <max.kellermann@ionos.com>
    ext4: apply umask if ACL support is disabled

Heiner Kallweit <hkallweit1@gmail.com>
    Revert "net: r8169: Disable multicast filter for RTL8168H and RTL8107E"

Bryan O'Donoghue <bryan.odonoghue@linaro.org>
    media: qcom: camss: Fix missing vfe_lite clocks check

Bryan O'Donoghue <bryan.odonoghue@linaro.org>
    media: qcom: camss: Fix VFE-17x vfe_disable_output()

Bryan O'Donoghue <bryan.odonoghue@linaro.org>
    media: qcom: camss: Fix vfe_get() error jump

Bryan O'Donoghue <bryan.odonoghue@linaro.org>
    media: qcom: camss: Fix pm_domain_on sequence in probe

Victor Shih <victor.shih@genesyslogic.com.tw>
    mmc: sdhci-pci-gli: GL9750: Mask the replay timer timeout of AER

ChunHao Lin <hau@realtek.com>
    r8169: fix network lost after resume on DASH systems

Roman Gushchin <roman.gushchin@linux.dev>
    mm: kmem: drop __GFP_NOFAIL when allocating objcg vectors

Victor Shih <victor.shih@genesyslogic.com.tw>
    mmc: sdhci-pci-gli: A workaround to allow GL9750 to enter ASPM L1.2

Nam Cao <namcaov@gmail.com>
    riscv: kprobes: allow writing to x0

Mahmoud Adam <mngyadam@amazon.com>
    nfsd: fix file memleak on client_opens_release

Sakari Ailus <sakari.ailus@linux.intel.com>
    media: ccs: Correctly initialise try compose rectangle

Vikash Garodia <quic_vgarodia@quicinc.com>
    media: venus: hfi: add checks to handle capabilities from firmware

Vikash Garodia <quic_vgarodia@quicinc.com>
    media: venus: hfi: fix the check to handle session buffer requirement

Vikash Garodia <quic_vgarodia@quicinc.com>
    media: venus: hfi_parser: Add check to keep the number of codecs within range

Sean Young <sean@mess.org>
    media: sharp: fix sharp encoding

Sean Young <sean@mess.org>
    media: lirc: drop trailing space from scancode transmit

Su Hui <suhui@nfschina.com>
    f2fs: avoid format-overflow warning

Heiner Kallweit <hkallweit1@gmail.com>
    i2c: i801: fix potential race in i801_block_transaction_byte_by_byte

Klaus Kudielka <klaus.kudielka@gmail.com>
    net: phylink: initialize carrier state at creation

Alexander Sverdlin <alexander.sverdlin@siemens.com>
    net: dsa: lan9303: consequently nested-lock physical MDIO

Andrew Lunn <andrew@lunn.ch>
    net: ethtool: Fix documentation of ethtool_sprintf()

Harald Freudenberger <freude@linux.ibm.com>
    s390/ap: fix AP bus crash on early config change callback invocation

Tam Nguyen <tamnguyenchi@os.amperecomputing.com>
    i2c: designware: Disable TX_EMPTY irq while waiting for block length byte

Darren Hart <darren@os.amperecomputing.com>
    sbsa_gwdt: Calculate timeout with 64-bit math

Ondrej Mosnacek <omosnace@redhat.com>
    lsm: fix default return value for inode_getsecctx

Ondrej Mosnacek <omosnace@redhat.com>
    lsm: fix default return value for vm_enough_memory

Robert Marko <robert.marko@sartura.hr>
    Revert "i2c: pxa: move to generic GPIO recovery"

Johnathan Mantey <johnathanx.mantey@intel.com>
    Revert ncsi: Propagate carrier gain/loss events to the NCSI controller

Gaurav Batra <gbatra@linux.vnet.ibm.com>
    powerpc/pseries/iommu: enable_ddw incorrectly returns direct mapping for SR-IOV device

Alexey Kardashevskiy <aik@ozlabs.ru>
    powerpc/pseries/ddw: simplify enable_ddw()

Vignesh Viswanathan <quic_viswanat@quicinc.com>
    arm64: dts: qcom: ipq6018: Fix tcsr_mutex register size

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    arm64: dts: qcom: ipq6018: switch TCSR mutex to MMIO

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: fix slab out of bounds write in smb_inherit_dacl()

Guan Wentao <guanwentao@uniontech.com>
    Bluetooth: btusb: Add 0bda:b85b for Fn-Link RTL8852BE

Masum Reza <masumrezarock100@gmail.com>
    Bluetooth: btusb: Add RTW8852BE device 13d3:3570 to device tables

Larry Finger <Larry.Finger@lwfinger.net>
    bluetooth: Add device 13d3:3571 to device tables

Larry Finger <Larry.Finger@lwfinger.net>
    bluetooth: Add device 0bda:887b to device tables

Artem Lukyanov <dukzcry@ya.ru>
    Bluetooth: btusb: Add Realtek RTL8852BE support ID 0x0cb8:0xc559

Christian Marangi <ansuelsmth@gmail.com>
    cpufreq: stats: Fix buffer overflow detection in trans_stats()

Mark Brown <broonie@kernel.org>
    regmap: Ensure range selector registers are updated after cache sync

Pavel Krasavin <pkrasavin@imaqliq.com>
    tty: serial: meson: fix hard LOCKUP on crtscts mode

Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
    serial: meson: Use platform_get_irq() to get the interrupt

Chandradeep Dey <codesigning@chandradeepdey.com>
    ALSA: hda/realtek - Enable internal speaker of ASUS K6500ZC

Kailang Yang <kailang@realtek.com>
    ALSA: hda/realtek - Add Dell ALC295 to pin fall back table

Takashi Iwai <tiwai@suse.de>
    ALSA: info: Fix potential deadlock at disconnection

Basavaraj Natikar <Basavaraj.Natikar@amd.com>
    xhci: Enable RPM on controllers that support low-power states

Helge Deller <deller@gmx.de>
    parisc/pgtable: Do not drop upper 5 address bits of physical address

Helge Deller <deller@gmx.de>
    parisc: Prevent booting 64-bit kernels on PA1.x machines

Frank Li <Frank.Li@nxp.com>
    i3c: master: svc: fix SDA keep low when polling IBIWON timeout happen

Frank Li <Frank.Li@nxp.com>
    i3c: master: svc: fix check wrong status register in irq handler

Frank Li <Frank.Li@nxp.com>
    i3c: master: svc: fix ibi may not return mandatory data byte

Frank Li <Frank.Li@nxp.com>
    i3c: master: svc: fix wrong data return when IBI happen during start frame

Frank Li <Frank.Li@nxp.com>
    i3c: master: svc: fix race condition in ibi work thread

Joshua Yeong <joshua.yeong@starfivetech.com>
    i3c: master: cdns: Fix reading status register

Linus Walleij <linus.walleij@linaro.org>
    mtd: cfi_cmdset_0001: Byte swap OTP info

Zi Yan <ziy@nvidia.com>
    mm/memory_hotplug: use pfn math in place of direct struct page manipulation

Zi Yan <ziy@nvidia.com>
    mm/cma: use nth_page() in place of direct struct page manipulation

Heiko Carstens <hca@linux.ibm.com>
    s390/cmma: fix detection of DAT pages

Alain Volmat <alain.volmat@foss.st.com>
    dmaengine: stm32-mdma: correct desc prep when channel running

Sanjuán García, Jorge <Jorge.SanjuanGarcia@duagon.com>
    mcb: fix error handling for different scenarios when parsing

Steven Rostedt (Google) <rostedt@goodmis.org>
    tracing: Have the user copy of synthetic event address use correct context

Benjamin Bara <benjamin.bara@skidata.com>
    i2c: core: Run atomic i2c xfer when !preemptible

Benjamin Bara <benjamin.bara@skidata.com>
    kernel/reboot: emergency_restart: Set correct system_state

Eric Biggers <ebiggers@google.com>
    quota: explicitly forbid quota files from being encrypted

Zhihao Cheng <chengzhihao1@huawei.com>
    jbd2: fix potential data lost in recovering journal raced with synchronizing fs bdev

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    ASoC: codecs: wsa-macro: fix uninitialized stack variables with name prefix

Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
    selftests/resctrl: Reduce failures due to outliers in MBA/MBM tests

Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
    selftests/resctrl: Remove duplicate feature check from CMT test

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: split async and sync catchall in two functions

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: remove catchall element in GC sync path

Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
    PCI: keystone: Don't discard .probe() callback

Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
    PCI: keystone: Don't discard .remove() callback

Jarkko Sakkinen <jarkko@kernel.org>
    KEYS: trusted: Rollback init_trusted() consistently

Herve Codina <herve.codina@bootlin.com>
    genirq/generic_chip: Make irq_remove_generic_chip() irqdomain aware

Rong Chen <rong.chen@amlogic.com>
    mmc: meson-gx: Remove setting of CMD_CFG_ERROR

Johan Hovold <johan+linaro@kernel.org>
    wifi: ath11k: fix htt pktlog locking

Johan Hovold <johan+linaro@kernel.org>
    wifi: ath11k: fix dfs radar event locking

Johan Hovold <johan+linaro@kernel.org>
    wifi: ath11k: fix temperature event locking

Mimi Zohar <zohar@linux.ibm.com>
    ima: detect changes to the backing overlay file

Amir Goldstein <amir73il@gmail.com>
    ima: annotate iint mutex to avoid lockdep false positive warnings

Vasily Khoruzhick <anarsoul@gmail.com>
    ACPI: FPDT: properly handle invalid FPDT subtables

Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
    firmware: qcom_scm: use 64-bit calling convention only when client is 64-bit

Josef Bacik <josef@toxicpanda.com>
    btrfs: don't arbitrarily slow down delalloc if we're committing

Catalin Marinas <catalin.marinas@arm.com>
    rcu: kmemleak: Ignore kmemleak false positives when RCU-freeing objects

Brian Geffon <bgeffon@google.com>
    PM: hibernate: Clean up sync_read handling in snapshot_write_next()

Brian Geffon <bgeffon@google.com>
    PM: hibernate: Use __get_safe_page() rather than touching the list

Vignesh Viswanathan <quic_viswanat@quicinc.com>
    arm64: dts: qcom: ipq6018: Fix hwlock index for SMEM

Joel Fernandes (Google) <joel@joelfernandes.org>
    rcu/tree: Defer setting of jiffies during stall reset

Chuck Lever <chuck.lever@oracle.com>
    svcrdma: Drop connection after an RDMA Read error

Ajay Singh <ajay.kathat@microchip.com>
    wifi: wilc1000: use vmm_table as array in wilc struct

Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
    PCI: exynos: Don't discard .remove() callback

Heiner Kallweit <hkallweit1@gmail.com>
    PCI/ASPM: Fix L1 substate handling in aspm_attr_store_common()

Nitin Yadav <n-yadav@ti.com>
    mmc: sdhci_am654: fix start loop index for TAP value parsing

Dan Carpenter <dan.carpenter@linaro.org>
    mmc: vub300: fix an error code

Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
    clk: qcom: ipq6018: drop the CLK_SET_RATE_PARENT flag from PLL clocks

Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
    clk: qcom: ipq8074: drop the CLK_SET_RATE_PARENT flag from PLL clocks

Gustavo A. R. Silva <gustavoars@kernel.org>
    clk: socfpga: Fix undefined behavior bug in struct stratix10_clock_data

Helge Deller <deller@gmx.de>
    parisc/pdc: Add width field to struct pdc_model

Nathan Chancellor <nathan@kernel.org>
    arm64: Restrict CPU_BIG_ENDIAN to GNU as or LLVM IAS 15.x or newer

Werner Sembach <wse@tuxedocomputers.com>
    ACPI: resource: Do IRQ override on TongFang GMxXGxx

Krister Johansen <kjlx@templeofstupid.com>
    watchdog: move softlockup_panic back to early_param

Lukas Wunner <lukas@wunner.de>
    PCI/sysfs: Protect driver's D3cold preference from user space

David Woodhouse <dwmw@amazon.co.uk>
    hvc/xen: fix event channel handling for secondary consoles

David Woodhouse <dwmw@amazon.co.uk>
    hvc/xen: fix error path in xen_hvc_init() to always register frontend driver

David Woodhouse <dwmw@amazon.co.uk>
    hvc/xen: fix console unplug

Muhammad Usama Anjum <usama.anjum@collabora.com>
    tty/sysrq: replace smp_processor_id() with get_cpu()

Paul Moore <paul@paul-moore.com>
    audit: don't WARN_ON_ONCE(!current->mm) in audit_exe_compare()

Paul Moore <paul@paul-moore.com>
    audit: don't take task_lock() in audit_exe_compare() code path

Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
    KVM: x86: Ignore MSR_AMD64_TW_CFG access

Nicolas Saenz Julienne <nsaenz@amazon.com>
    KVM: x86: hyper-v: Don't auto-enable stimer on write from user-space

Pu Wen <puwen@hygon.cn>
    x86/cpu/hygon: Fix the CPU topology evaluation for real

Roxana Nicolescu <roxana.nicolescu@canonical.com>
    crypto: x86/sha - load modules based on CPU features

Quinn Tran <qutran@marvell.com>
    scsi: qla2xxx: Fix system crash due to bad pointer access

Chandrakanth patil <chandrakanth.patil@broadcom.com>
    scsi: megaraid_sas: Increase register read retry rount from 3 to 30 for selected registers

Ranjan Kumar <ranjan.kumar@broadcom.com>
    scsi: mpt3sas: Fix loop logic

Shung-Hsi Yu <shung-hsi.yu@suse.com>
    bpf: Fix precision tracking for BPF_ALU | BPF_TO_BE | BPF_END

Hao Sun <sunhao.th@gmail.com>
    bpf: Fix check_stack_write_fixed_off() to correctly spill imm

Kees Cook <keescook@chromium.org>
    randstruct: Fix gcc-plugin performance mode to stay in group

Nicholas Piggin <npiggin@gmail.com>
    powerpc/perf: Fix disabling BHRB and instruction sampling

Vikash Garodia <quic_vgarodia@quicinc.com>
    media: venus: hfi: add checks to perform sanity on queue pointers

Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
    i915/perf: Fix NULL deref bugs with drm_dbg() calls

Li Zetao <lizetao1@huawei.com>
    xfs: Fix unreferenced object reported by kmemleak in xfs_sysfs_init()

Zeng Heng <zengheng4@huawei.com>
    xfs: fix memory leak in xfs_errortag_init

Guo Xuenan <guoxuenan@huawei.com>
    xfs: fix exception caused by unexpected illegal bestcount in leaf dir

Darrick J. Wong <djwong@kernel.org>
    xfs: avoid a UAF when log intent item recovery fails

hexiaole <hexiaole@kylinos.cn>
    xfs: fix inode reservation space for removing transaction

Chandan Babu R <chandan.babu@oracle.com>
    xfs: Fix false ENOSPC when performing direct write on a delalloc extent in cow fork

Gao Xiang <hsiangkao@linux.alibaba.com>
    xfs: add missing cmap->br_state = XFS_EXT_NORM update

Darrick J. Wong <djwong@kernel.org>
    xfs: fix intermittent hang during quotacheck

Darrick J. Wong <djwong@kernel.org>
    xfs: don't leak memory when attr fork loading fails

Darrick J. Wong <djwong@kernel.org>
    xfs: fix use-after-free in xattr node block inactivation

Zhang Yi <yi.zhang@huawei.com>
    xfs: flush inode gc workqueue before clearing agi bucket

Darrick J. Wong <djwong@kernel.org>
    xfs: prevent a UAF when log IO errors race with unmount

Kaixu Xia <kaixuxia@tencent.com>
    xfs: use invalidate_lock to check the state of mmap_lock

Darrick J. Wong <djwong@kernel.org>
    xfs: convert buf_cancel_table allocation to kmalloc_array

Darrick J. Wong <djwong@kernel.org>
    xfs: don't leak xfs_buf_cancel structures when recovery fails

Darrick J. Wong <djwong@kernel.org>
    xfs: refactor buffer cancellation table allocation

Ekaterina Esina <eesina@astralinux.ru>
    cifs: fix check of rc in function generate_smb3signingkey

Anastasia Belova <abelova@astralinux.ru>
    cifs: spnego: add ';' in HOST_KEY_LEN

Chen Yu <yu.c.chen@intel.com>
    tools/power/turbostat: Enable the C-state Pre-wake printing

Zhang Rui <rui.zhang@intel.com>
    tools/power/turbostat: Fix a knl bug

Vlad Buslov <vladbu@nvidia.com>
    macvlan: Don't propagate promisc change to lower dev in passthru

Rahul Rameshbabu <rrameshbabu@nvidia.com>
    net/mlx5e: Check return value of snprintf writing to fw_version buffer for representors

Saeed Mahameed <saeedm@nvidia.com>
    net/mlx5e: Reduce the size of icosq_str

Vlad Buslov <vladbu@nvidia.com>
    net/mlx5e: Fix pedit endianness

Paul Blakey <paulb@nvidia.com>
    net/mlx5e: Refactor mod header management API

Roi Dayan <roid@nvidia.com>
    net/mlx5e: Move mod hdr allocation to a single place

Roi Dayan <roid@nvidia.com>
    net/mlx5e: Remove incorrect addition of action fwd flag

Gavin Li <gavinl@nvidia.com>
    net/mlx5e: fix double free of encap_header in update funcs

Dust Li <dust.li@linux.alibaba.com>
    net/mlx5e: fix double free of encap_header

Baruch Siach <baruch@tkos.co.il>
    net: stmmac: fix rx budget limit check

Dan Carpenter <dan.carpenter@linaro.org>
    netfilter: nf_tables: fix pointer math issue in nft_byteorder_eval()

Florian Westphal <fw@strlen.de>
    netfilter: nf_tables: add and use BE register load-store helpers

Florian Westphal <fw@strlen.de>
    netfilter: nf_tables: use the correct get/put helpers

Linkui Xiao <xiaolinkui@kylinos.cn>
    netfilter: nf_conntrack_bridge: initialize err to 0

Eric Dumazet <edumazet@google.com>
    af_unix: fix use-after-free in unix_stream_read_actor()

Linus Walleij <linus.walleij@linaro.org>
    net: ethernet: cortina: Fix MTU max setting

Linus Walleij <linus.walleij@linaro.org>
    net: ethernet: cortina: Handle large frames

Linus Walleij <linus.walleij@linaro.org>
    net: ethernet: cortina: Fix max RX frame define

Eric Dumazet <edumazet@google.com>
    bonding: stop the device in bond_setup_by_slave()

Eric Dumazet <edumazet@google.com>
    ptp: annotate data-race around q->head and q->tail

Juergen Gross <jgross@suse.com>
    xen/events: fix delayed eoi list handling

Willem de Bruijn <willemb@google.com>
    ppp: limit MRU to 64K

Shigeru Yoshida <syoshida@redhat.com>
    tipc: Fix kernel-infoleak due to uninitialized TLV value

Jijie Shao <shaojijie@huawei.com>
    net: hns3: fix VF wrong speed and duplex issue

Jijie Shao <shaojijie@huawei.com>
    net: hns3: fix VF reset fail issue

Yonglong Liu <liuyonglong@huawei.com>
    net: hns3: fix variable may not initialized problem in hns3_init_mac_addr()

Jian Shen <shenjian15@huawei.com>
    net: hns3: fix incorrect capability bit display for copper port

Yonglong Liu <liuyonglong@huawei.com>
    net: hns3: add barrier in vf mailbox reply process

Jie Wang <wangjie125@huawei.com>
    net: hns3: add byte order conversion for PF to VF mailbox message

Jian Shen <shenjian15@huawei.com>
    net: hns3: refine the definition for struct hclge_pf_to_vf_msg

Jian Shen <shenjian15@huawei.com>
    net: hns3: fix add VLAN fail issue

Shigeru Yoshida <syoshida@redhat.com>
    tty: Fix uninit-value access in ppp_sync_receive()

Eric Dumazet <edumazet@google.com>
    ipvlan: add ipvlan_route_v6_outbound() helper

Stanislav Fomichev <sdf@google.com>
    net: set SOCK_RCU_FREE before inserting socket into hashtable

Martin KaFai Lau <kafai@fb.com>
    net: inet: Retire port only listening_hash

Martin KaFai Lau <kafai@fb.com>
    net: inet: Open code inet_hash2 and inet_unhash2

Martin KaFai Lau <kafai@fb.com>
    net: inet: Remove count from inet_listen_hashbucket

Florian Westphal <fw@strlen.de>
    mptcp: listen diag dump support

Florian Westphal <fw@strlen.de>
    mptcp: diag: switch to context structure

Andreas Gruenbacher <agruenba@redhat.com>
    gfs2: Silence "suspicious RCU usage in gfs2_permission" warning

felix <fuzhen5@huawei.com>
    SUNRPC: Fix RPC client cleaned up the freed pipefs dentries

Olga Kornievskaia <kolga@netapp.com>
    NFSv4.1: fix SP4_MACH_CRED protection for pnfs IO

Dan Carpenter <dan.carpenter@linaro.org>
    SUNRPC: Add an IS_ERR() check back to where it was

Marc Zyngier <maz@kernel.org>
    gpio: Add helpers to ease the transition towards immutable irq_chip

Marc Zyngier <maz@kernel.org>
    gpio: Expose the gpiochip_irq_re[ql]res helpers

Marc Zyngier <maz@kernel.org>
    gpio: Don't fiddle with irqchips marked as immutable

Trond Myklebust <trond.myklebust@hammerspace.com>
    SUNRPC: ECONNRESET might require a rebind

Marek Szyprowski <m.szyprowski@samsung.com>
    media: cec: meson: always include meson sub-directory in Makefile

Pratyush Yadav <p.yadav@ti.com>
    media: cadence: csi2rx: Unregister v4l2 async notifier

Finn Thain <fthain@linux-m68k.org>
    sched/core: Optimize in_task() and in_interrupt() a bit

Steven Rostedt (VMware) <rostedt@goodmis.org>
    tracing/perf: Add interrupt_context_level() helper

Steven Rostedt (VMware) <rostedt@goodmis.org>
    tracing: Reuse logic from perf's get_recursion_context()

Miri Korenblit <miriam.rachel.korenblit@intel.com>
    wifi: iwlwifi: Use FW rate for non-data frames

Dan Carpenter <dan.carpenter@linaro.org>
    pwm: Fix double shift bug

Vitaly Prosyak <vitaly.prosyak@amd.com>
    drm/amdgpu: fix software pci_unplug on some chips

Zongmin Zhou <zhouzongmin@kylinos.cn>
    drm/qxl: prevent memory leak

Tony Lindgren <tony@atomide.com>
    ASoC: ti: omap-mcbsp: Fix runtime PM underflow warnings

Philipp Stanner <pstanner@redhat.com>
    i2c: dev: copy userspace array safely

Douglas Anderson <dianders@chromium.org>
    kgdb: Flush console before entering kgdb on panic

Wayne Lin <wayne.lin@amd.com>
    drm/amd/display: Avoid NULL dereference of timing generator

Takashi Iwai <tiwai@suse.de>
    media: imon: fix access to invalid resource for the second interface

Sakari Ailus <sakari.ailus@linux.intel.com>
    media: ccs: Fix driver quirk struct documentation

Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
    media: cobalt: Use FIELD_GET() to extract Link Width

Al Viro <viro@zeniv.linux.org.uk>
    gfs2: fix an oops in gfs2_permission

Bob Peterson <rpeterso@redhat.com>
    gfs2: ignore negated quota changes

Hans Verkuil <hverkuil-cisco@xs4all.nl>
    media: vivid: avoid integer overflow

Rajeshwar R Shinde <coolrrsh@gmail.com>
    media: gspca: cpia1: shift-out-of-bounds in set_flicker

Billy Tsai <billy_tsai@aspeedtech.com>
    i3c: master: mipi-i3c-hci: Fix a kernel panic for accessing DAT_data.

zhenwei pi <pizhenwei@bytedance.com>
    virtio-blk: fix implicit overflow on virtio_max_dma_size

Axel Lin <axel.lin@ingics.com>
    i2c: sun6i-p2wi: Prevent potential division by zero

Jarkko Nikula <jarkko.nikula@linux.intel.com>
    i3c: mipi-i3c-hci: Fix out of bounds access in hci_dma_irq_handler

Dominique Martinet <asmadeus@codewreck.org>
    9p: v9fs_listxattr: fix %s null argument warning

Marco Elver <elver@google.com>
    9p/trans_fd: Annotate data-racy writes to file::f_flags

Hardik Gajjar <hgajjar@de.adit-jv.com>
    usb: gadget: f_ncm: Always set current gadget in ncm_bind()

Yi Yang <yiyang13@huawei.com>
    tty: vcc: Add check for kstrdup() in vcc_probe()

Yuezhang Mo <Yuezhang.Mo@sony.com>
    exfat: support handle zero-size directory

Jiri Kosina <jkosina@suse.cz>
    HID: Add quirk for Dell Pro Wireless Keyboard and Mouse KM5221W

Bjorn Helgaas <bhelgaas@google.com>
    PCI: Use FIELD_GET() in Sapphire RX 5600 XT Pulse quirk

Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
    misc: pci_endpoint_test: Add Device ID for R-Car S4-8 PCIe controller

Bartosz Pawlowski <bartosz.pawlowski@intel.com>
    PCI: Disable ATS for specific Intel IPU E2000 devices

Bartosz Pawlowski <bartosz.pawlowski@intel.com>
    PCI: Extract ATS disabling to a helper function

Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
    PCI: Use FIELD_GET() to extract Link Width

Wenchao Hao <haowenchao2@huawei.com>
    scsi: libfc: Fix potential NULL pointer dereference in fc_lport_ptp_setup()

Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
    atm: iphase: Do PCI error checks on own line

Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
    PCI: tegra194: Use FIELD_GET()/FIELD_PREP() with Link Width fields

Cezary Rojewski <cezary.rojewski@intel.com>
    ALSA: hda: Fix possible null-ptr-deref when assigning a stream

Vincent Whitchurch <vincent.whitchurch@axis.com>
    ARM: 9320/1: fix stack depot IRQ stack filter

Mikhail Khvainitski <me@khvoinitsky.org>
    HID: lenovo: Detect quirk-free fw on cptkbd and stop applying workaround

Manas Ghandat <ghandatmanas@gmail.com>
    jfs: fix array-index-out-of-bounds in diAlloc

Manas Ghandat <ghandatmanas@gmail.com>
    jfs: fix array-index-out-of-bounds in dbFindLeaf

Juntong Deng <juntong.deng@outlook.com>
    fs/jfs: Add validity check for db_maxag and db_agpref

Juntong Deng <juntong.deng@outlook.com>
    fs/jfs: Add check for negative db_l2nbperpage

Tyrel Datwyler <tyreld@linux.ibm.com>
    scsi: ibmvfc: Remove BUG_ON in the case of an empty event pool

Yihang Li <liyihang9@huawei.com>
    scsi: hisi_sas: Set debugfs_dir pointer to NULL after removing debugfs

Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
    RDMA/hfi1: Use FIELD_GET() to extract Link Width

Lu Jialin <lujialin4@huawei.com>
    crypto: pcrypt - Fix hungtask for PADATA_RESET

Richard Fitzgerald <rf@opensource.cirrus.com>
    ASoC: soc-card: Add storage for PCI SSID

zhujun2 <zhujun2@cmss.chinamobile.com>
    selftests/efivarfs: create-read: fix a resource leak

Laurentiu Tudor <laurentiu.tudor@nxp.com>
    arm64: dts: ls208xa: use a pseudo-bus to constrain usb dma size

Qu Huang <qu.huang@linux.dev>
    drm/amdgpu: Fix a null pointer access when the smc_rreg pointer is NULL

Jesse Zhang <jesse.zhang@amd.com>
    drm/amdkfd: Fix shift out-of-bounds issue

Ondrej Jirman <megi@xff.cz>
    drm/panel: st7703: Pick different reset sequence

Ma Ke <make_ruc2021@163.com>
    drm/amdgpu/vkms: fix a possible null pointer dereference

Ma Ke <make_ruc2021@163.com>
    drm/panel/panel-tpo-tpg110: fix a possible null pointer dereference

Ma Ke <make_ruc2021@163.com>
    drm/panel: fix a possible null pointer dereference

Stanley.Yang <Stanley.Yang@amd.com>
    drm/amdgpu: Fix potential null pointer derefernce

Mario Limonciello <mario.limonciello@amd.com>
    drm/amd: Fix UBSAN array-index-out-of-bounds for Polaris and Tonga

Mario Limonciello <mario.limonciello@amd.com>
    drm/amd: Fix UBSAN array-index-out-of-bounds for SMU7

Jani Nikula <jani.nikula@intel.com>
    drm/msm/dp: skip validity check for DP CTS EDID checksum

Philipp Stanner <pstanner@redhat.com>
    drm: vmwgfx_surface.c: copy user-array safely

Philipp Stanner <pstanner@redhat.com>
    kernel: watch_queue: copy user-array safely

Philipp Stanner <pstanner@redhat.com>
    kernel: kexec: copy user-array safely

Philipp Stanner <pstanner@redhat.com>
    string.h: add array-wrappers for (v)memdup_user()

Wenjing Liu <wenjing.liu@amd.com>
    drm/amd/display: use full update for clip size increase of large plane source

Xiaogang Chen <xiaogang.chen@amd.com>
    drm/amdkfd: Fix a race condition of vram buffer unref in svm code

baozhu.liu <lucas.liu@siengine.com>
    drm/komeda: drop all currently held locks if deadlock happens

Olli Asikainen <olli.asikainen@gmail.com>
    platform/x86: thinkpad_acpi: Add battery quirk for Thinkpad X120e

ZhengHan Wang <wzhmmmmm@gmail.com>
    Bluetooth: Fix double free in hci_conn_cleanup

youwan Wang <wangyouwan@126.com>
    Bluetooth: btusb: Add date->evt_skb is NULL check

Douglas Anderson <dianders@chromium.org>
    wifi: ath10k: Don't touch the CE interrupt registers after power up

Eric Dumazet <edumazet@google.com>
    net: annotate data-races around sk->sk_dst_pending_confirm

Eric Dumazet <edumazet@google.com>
    net: annotate data-races around sk->sk_tx_queue_mapping

Dmitry Antipov <dmantipov@yandex.ru>
    wifi: ath10k: fix clang-specific fortify warning

Dmitry Antipov <dmantipov@yandex.ru>
    wifi: ath9k: fix clang-specific fortify warnings

Kumar Kartikeya Dwivedi <memxor@gmail.com>
    bpf: Detect IP == ksym.end as part of BPF program

Sieng-Piaw Liew <liew.s.piaw@gmail.com>
    atl1c: Work around the DMA RX overflow issue

Ping-Ke Shih <pkshih@realtek.com>
    wifi: mac80211: don't return unset power in ieee80211_get_tx_power()

Dmitry Antipov <dmantipov@yandex.ru>
    wifi: mac80211_hwsim: fix clang-specific fortify warning

Mike Rapoport (IBM) <rppt@kernel.org>
    x86/mm: Drop the 4 MB restriction on minimal NUMA node memory size

Frederic Weisbecker <frederic@kernel.org>
    workqueue: Provide one lock class key per work_on_cpu() callsite

Ronald Wahl <ronald.wahl@raritan.com>
    clocksource/drivers/timer-atmel-tcb: Fix initialization on SAM9 hardware

Jacky Bai <ping.bai@nxp.com>
    clocksource/drivers/timer-imx-gpt: Fix potential memory leak

Shuai Xue <xueshuai@linux.alibaba.com>
    perf/core: Bail out early if the request AUX area is out of bound

John Stultz <jstultz@google.com>
    locking/ww_mutex/test: Fix potential workqueue corruption


-------------

Diffstat:

 Makefile                                           |   4 +-
 arch/arm/include/asm/exception.h                   |   4 -
 arch/arm64/Kconfig                                 |   2 +
 arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi     |  46 ++--
 arch/arm64/boot/dts/qcom/ipq6018.dtsi              |  15 +-
 arch/parisc/include/uapi/asm/pdc.h                 |   1 +
 arch/parisc/kernel/entry.S                         |   7 +-
 arch/parisc/kernel/head.S                          |   5 +-
 arch/powerpc/perf/core-book3s.c                    |   5 +-
 arch/powerpc/platforms/powernv/opal-prd.c          |  17 +-
 arch/powerpc/platforms/pseries/iommu.c             |  19 +-
 arch/riscv/kernel/probes/simulate-insn.c           |   2 +-
 arch/s390/mm/page-states.c                         |   6 +-
 arch/x86/crypto/sha1_ssse3_glue.c                  |  12 ++
 arch/x86/crypto/sha256_ssse3_glue.c                |  12 ++
 arch/x86/include/asm/msr-index.h                   |   1 +
 arch/x86/include/asm/numa.h                        |   7 -
 arch/x86/kernel/cpu/hygon.c                        |   8 +-
 arch/x86/kvm/hyperv.c                              |  10 +-
 arch/x86/kvm/x86.c                                 |   2 +
 arch/x86/mm/numa.c                                 |   7 -
 crypto/pcrypt.c                                    |   4 +
 drivers/acpi/acpi_fpdt.c                           |  45 +++-
 drivers/acpi/resource.c                            |  12 ++
 drivers/atm/iphase.c                               |  20 +-
 drivers/base/dd.c                                  |   4 +-
 drivers/base/regmap/regcache.c                     |  30 +++
 drivers/block/virtio_blk.c                         |   4 +-
 drivers/bluetooth/btusb.c                          |  15 ++
 drivers/clk/qcom/gcc-ipq6018.c                     |   6 -
 drivers/clk/qcom/gcc-ipq8074.c                     |   6 -
 drivers/clk/socfpga/stratix10-clk.h                |   4 +-
 drivers/clocksource/timer-atmel-tcb.c              |   1 +
 drivers/clocksource/timer-imx-gpt.c                |  18 +-
 drivers/cpufreq/cpufreq_stats.c                    |  14 +-
 drivers/dma/stm32-mdma.c                           |   4 +-
 drivers/firmware/qcom_scm.c                        |   7 +
 drivers/gpio/gpiolib.c                             |  13 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c           |   5 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c        |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c        |   6 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c            |   9 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c           |   2 +
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c               |  13 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |  13 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c           |  12 +-
 drivers/gpu/drm/amd/display/dc/core/dc_stream.c    |   4 +-
 drivers/gpu/drm/amd/display/dc/dc.h                |   5 +
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h        |  22 +-
 drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c    |  32 ++-
 drivers/gpu/drm/amd/include/pptable.h              |   4 +-
 drivers/gpu/drm/amd/pm/amdgpu_pm.c                 |   8 +-
 .../gpu/drm/amd/pm/powerplay/hwmgr/pptable_v1_0.h  |  16 +-
 .../drm/arm/display/komeda/komeda_pipeline_state.c |   9 +-
 drivers/gpu/drm/i915/gem/i915_gem_context.c        |   1 +
 drivers/gpu/drm/i915/i915_perf.c                   |  15 +-
 drivers/gpu/drm/msm/dp/dp_panel.c                  |  21 +-
 drivers/gpu/drm/panel/panel-arm-versatile.c        |   2 +
 drivers/gpu/drm/panel/panel-sitronix-st7703.c      |  25 +--
 drivers/gpu/drm/panel/panel-tpo-tpg110.c           |   2 +
 drivers/gpu/drm/qxl/qxl_display.c                  |   3 +
 drivers/gpu/drm/vmwgfx/vmwgfx_surface.c            |   4 +-
 drivers/hid/hid-ids.h                              |   1 +
 drivers/hid/hid-lenovo.c                           |  68 ++++--
 drivers/hid/hid-quirks.c                           |   1 +
 drivers/i2c/busses/i2c-designware-master.c         |  19 +-
 drivers/i2c/busses/i2c-i801.c                      |  19 +-
 drivers/i2c/busses/i2c-pxa.c                       |  76 ++++++-
 drivers/i2c/busses/i2c-sun6i-p2wi.c                |   5 +
 drivers/i2c/i2c-core.h                             |   2 +-
 drivers/i2c/i2c-dev.c                              |   4 +-
 drivers/i3c/master/i3c-master-cdns.c               |   6 +-
 drivers/i3c/master/mipi-i3c-hci/dat_v1.c           |  29 ++-
 drivers/i3c/master/mipi-i3c-hci/dma.c              |   2 +-
 drivers/i3c/master/svc-i3c-master.c                |  45 +++-
 drivers/infiniband/hw/hfi1/pcie.c                  |   9 +-
 drivers/input/joystick/xpad.c                      |   1 +
 drivers/mcb/mcb-core.c                             |   1 +
 drivers/mcb/mcb-parse.c                            |   2 +-
 drivers/media/cec/platform/Makefile                |   2 +-
 drivers/media/i2c/ccs/ccs-core.c                   |   2 +-
 drivers/media/i2c/ccs/ccs-quirk.h                  |   4 +-
 drivers/media/pci/cobalt/cobalt-driver.c           |  11 +-
 drivers/media/platform/cadence/cdns-csi2rx.c       |   7 +-
 drivers/media/platform/qcom/camss/camss-vfe-170.c  |  22 +-
 drivers/media/platform/qcom/camss/camss-vfe.c      |   5 +-
 drivers/media/platform/qcom/camss/camss.c          |  12 +-
 drivers/media/platform/qcom/venus/hfi_msgs.c       |   2 +-
 drivers/media/platform/qcom/venus/hfi_parser.c     |  15 ++
 drivers/media/platform/qcom/venus/hfi_venus.c      |  10 +
 drivers/media/rc/imon.c                            |   6 +
 drivers/media/rc/ir-sharp-decoder.c                |   8 +-
 drivers/media/rc/lirc_dev.c                        |   6 +-
 drivers/media/test-drivers/vivid/vivid-rds-gen.c   |   2 +-
 drivers/media/usb/gspca/cpia1.c                    |   3 +
 drivers/misc/pci_endpoint_test.c                   |   4 +
 drivers/mmc/host/meson-gx-mmc.c                    |   1 -
 drivers/mmc/host/sdhci-pci-gli.c                   |  22 ++
 drivers/mmc/host/sdhci_am654.c                     |   2 +-
 drivers/mmc/host/vub300.c                          |   1 +
 drivers/mtd/chips/cfi_cmdset_0001.c                |  20 +-
 drivers/net/bonding/bond_main.c                    |   6 +
 drivers/net/dsa/lan9303_mdio.c                     |   4 +-
 drivers/net/ethernet/atheros/atl1c/atl1c.h         |   3 -
 drivers/net/ethernet/atheros/atl1c/atl1c_main.c    |  67 ++----
 drivers/net/ethernet/cortina/gemini.c              |  45 ++--
 drivers/net/ethernet/cortina/gemini.h              |   4 +-
 drivers/net/ethernet/hisilicon/hns3/hclge_mbx.h    |  47 ++++-
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c    |   2 +-
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    |  33 ++-
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c |  62 +++---
 .../ethernet/hisilicon/hns3/hns3pf/hclge_trace.h   |   2 +-
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c  |  29 ++-
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h  |   3 +-
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_mbx.c   |  87 +++++---
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_trace.h |   2 +-
 .../net/ethernet/mellanox/mlx5/core/en/mod_hdr.c   |  47 +++++
 .../net/ethernet/mellanox/mlx5/core/en/mod_hdr.h   |  13 ++
 .../ethernet/mellanox/mlx5/core/en/reporter_rx.c   |   4 +-
 .../net/ethernet/mellanox/mlx5/core/en/tc/sample.c |   5 +-
 drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c |  25 +--
 .../net/ethernet/mellanox/mlx5/core/en/tc_tun.c    |  30 ++-
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.c   |  12 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c    | 234 +++++++++------------
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.h    |   5 -
 .../ethernet/mellanox/mlx5/core/esw/indir_table.c  |   5 +-
 drivers/net/ethernet/realtek/r8169_main.c          |  10 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |   2 +-
 drivers/net/ipvlan/ipvlan_core.c                   |  41 ++--
 drivers/net/macvlan.c                              |   2 +-
 drivers/net/phy/phylink.c                          |   1 +
 drivers/net/ppp/ppp_synctty.c                      |   6 +-
 drivers/net/wireless/ath/ath10k/debug.c            |   2 +-
 drivers/net/wireless/ath/ath10k/snoc.c             |  18 +-
 drivers/net/wireless/ath/ath11k/dp_rx.c            |   8 +-
 drivers/net/wireless/ath/ath11k/wmi.c              |  12 +-
 drivers/net/wireless/ath/ath9k/debug.c             |   2 +-
 drivers/net/wireless/ath/ath9k/htc_drv_debug.c     |   2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c        |  14 +-
 drivers/net/wireless/mac80211_hwsim.c              |   2 +-
 drivers/net/wireless/microchip/wilc1000/wlan.c     |   2 +-
 drivers/pci/controller/dwc/pci-exynos.c            |   4 +-
 drivers/pci/controller/dwc/pci-keystone.c          |   8 +-
 drivers/pci/controller/dwc/pcie-tegra194.c         |   9 +-
 drivers/pci/pci-acpi.c                             |   2 +-
 drivers/pci/pci-sysfs.c                            |  10 +-
 drivers/pci/pci.c                                  |  13 +-
 drivers/pci/pcie/aspm.c                            |   2 +
 drivers/pci/quirks.c                               |  35 ++-
 drivers/platform/x86/thinkpad_acpi.c               |   1 +
 drivers/ptp/ptp_chardev.c                          |   3 +-
 drivers/ptp/ptp_clock.c                            |   5 +-
 drivers/ptp/ptp_private.h                          |   8 +-
 drivers/ptp/ptp_sysfs.c                            |   3 +-
 drivers/s390/crypto/ap_bus.c                       |   4 +
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c             |  13 +-
 drivers/scsi/ibmvscsi/ibmvfc.c                     | 124 ++++++++++-
 drivers/scsi/libfc/fc_lport.c                      |   6 +
 drivers/scsi/megaraid/megaraid_sas_base.c          |   4 +-
 drivers/scsi/mpt3sas/mpt3sas_base.c                |   4 +-
 drivers/scsi/qla2xxx/qla_os.c                      |  12 +-
 drivers/tty/hvc/hvc_xen.c                          |  39 +++-
 drivers/tty/serial/meson_uart.c                    |  25 ++-
 drivers/tty/sysrq.c                                |   3 +-
 drivers/tty/vcc.c                                  |  16 +-
 drivers/usb/gadget/function/f_ncm.c                |  27 +--
 drivers/usb/host/xhci-pci.c                        |   4 +-
 drivers/watchdog/sbsa_gwdt.c                       |   4 +-
 drivers/xen/events/events_base.c                   |   4 +-
 fs/9p/xattr.c                                      |   5 +-
 fs/btrfs/delalloc-space.c                          |   3 -
 fs/cifs/cifs_spnego.c                              |   4 +-
 fs/cifs/smb2transport.c                            |   5 +-
 fs/exfat/namei.c                                   |  29 ++-
 fs/ext4/acl.h                                      |   5 +
 fs/ext4/extents_status.c                           |   4 +-
 fs/ext4/resize.c                                   |  23 +-
 fs/f2fs/compress.c                                 |   2 +-
 fs/gfs2/inode.c                                    |  14 +-
 fs/gfs2/quota.c                                    |  11 +
 fs/gfs2/super.c                                    |   2 +-
 fs/jbd2/recovery.c                                 |   8 +
 fs/jfs/jfs_dmap.c                                  |  23 +-
 fs/jfs/jfs_imap.c                                  |   5 +-
 fs/ksmbd/smbacl.c                                  |  29 ++-
 fs/nfs/nfs4proc.c                                  |   5 +-
 fs/nfsd/nfs4state.c                                |   2 +-
 fs/overlayfs/super.c                               |   2 +-
 fs/proc/proc_sysctl.c                              |   1 -
 fs/quota/dquot.c                                   |  14 ++
 fs/xfs/libxfs/xfs_dir2_leaf.c                      |   9 +-
 fs/xfs/libxfs/xfs_inode_fork.c                     |   1 +
 fs/xfs/libxfs/xfs_log_recover.h                    |  14 +-
 fs/xfs/libxfs/xfs_trans_resv.c                     |   2 +-
 fs/xfs/xfs_attr_inactive.c                         |   8 +-
 fs/xfs/xfs_buf_item_recover.c                      |  66 ++++++
 fs/xfs/xfs_error.c                                 |   9 +-
 fs/xfs/xfs_inode.c                                 |   4 +-
 fs/xfs/xfs_log.c                                   |   9 +-
 fs/xfs/xfs_log_priv.h                              |   3 -
 fs/xfs/xfs_log_recover.c                           |  44 ++--
 fs/xfs/xfs_qm.c                                    |   7 +
 fs/xfs/xfs_reflink.c                               | 197 ++++++++++++++---
 fs/xfs/xfs_sysfs.h                                 |   7 +-
 include/linux/ethtool.h                            |   4 +-
 include/linux/gpio/driver.h                        |  16 ++
 include/linux/irq.h                                |   2 +
 include/linux/lsm_hook_defs.h                      |   4 +-
 include/linux/preempt.h                            |  36 +++-
 include/linux/pwm.h                                |   4 +-
 include/linux/string.h                             |  40 ++++
 include/linux/sunrpc/clnt.h                        |   1 +
 include/linux/trace_events.h                       |   4 +
 include/linux/trace_recursion.h                    |   8 +-
 include/linux/workqueue.h                          |  46 +++-
 include/net/inet_connection_sock.h                 |   2 -
 include/net/inet_hashtables.h                      |  42 +---
 include/net/netfilter/nf_tables.h                  |  19 +-
 include/net/sock.h                                 |  26 ++-
 include/sound/soc-card.h                           |  37 ++++
 include/sound/soc.h                                |  11 +
 io_uring/io_uring.c                                |  18 +-
 kernel/audit_watch.c                               |   9 +-
 kernel/bpf/core.c                                  |   6 +-
 kernel/bpf/verifier.c                              |   9 +-
 kernel/debug/debug_core.c                          |   3 +
 kernel/events/internal.h                           |   7 +-
 kernel/events/ring_buffer.c                        |   6 +
 kernel/irq/debugfs.c                               |   1 +
 kernel/irq/generic-chip.c                          |  25 ++-
 kernel/kexec.c                                     |   2 +-
 kernel/locking/test-ww_mutex.c                     |  20 +-
 kernel/padata.c                                    |   2 +-
 kernel/power/snapshot.c                            |  16 +-
 kernel/rcu/tree.c                                  |  21 ++
 kernel/rcu/tree.h                                  |   4 +
 kernel/rcu/tree_stall.h                            |  20 +-
 kernel/reboot.c                                    |   1 +
 kernel/trace/ring_buffer.c                         |   9 +-
 kernel/trace/trace.c                               |  15 ++
 kernel/trace/trace.h                               |   3 +
 kernel/trace/trace_events.c                        |  43 ++--
 kernel/trace/trace_events_filter.c                 |   3 +
 kernel/trace/trace_events_synth.c                  |   2 +-
 kernel/watch_queue.c                               |   2 +-
 kernel/watchdog.c                                  |   7 +
 kernel/workqueue.c                                 |  20 +-
 mm/cma.c                                           |   2 +-
 mm/memcontrol.c                                    |   3 +-
 mm/memory_hotplug.c                                |   2 +-
 net/9p/client.c                                    |   2 +-
 net/9p/trans_fd.c                                  |  13 +-
 net/bluetooth/hci_conn.c                           |   6 +-
 net/bluetooth/hci_sysfs.c                          |  23 +-
 net/bridge/netfilter/nf_conntrack_bridge.c         |   2 +-
 net/bridge/netfilter/nft_meta_bridge.c             |   2 +-
 net/core/sock.c                                    |   2 +-
 net/dccp/proto.c                                   |   1 -
 net/ipv4/inet_diag.c                               |   5 +-
 net/ipv4/inet_hashtables.c                         | 121 +++--------
 net/ipv4/tcp.c                                     |   1 -
 net/ipv4/tcp_ipv4.c                                |  21 +-
 net/ipv4/tcp_output.c                              |   2 +-
 net/ipv6/inet6_hashtables.c                        |   5 +-
 net/mac80211/cfg.c                                 |   4 +
 net/mptcp/mptcp_diag.c                             | 105 ++++++++-
 net/ncsi/ncsi-aen.c                                |   5 -
 net/netfilter/nf_tables_api.c                      |  53 +++--
 net/netfilter/nft_byteorder.c                      |   6 +-
 net/netfilter/nft_meta.c                           |   2 +-
 net/netfilter/nft_osf.c                            |   2 +-
 net/netfilter/nft_socket.c                         |   8 +-
 net/netfilter/nft_tproxy.c                         |   6 +-
 net/netfilter/nft_xfrm.c                           |   8 +-
 net/sunrpc/clnt.c                                  |   7 +-
 net/sunrpc/rpcb_clnt.c                             |   4 +
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c            |   3 +-
 net/tipc/netlink_compat.c                          |   1 +
 net/unix/af_unix.c                                 |   9 +-
 scripts/gcc-plugins/randomize_layout_plugin.c      |  11 +-
 security/integrity/iint.c                          |  48 ++++-
 security/integrity/ima/ima_api.c                   |   5 +
 security/integrity/ima/ima_main.c                  |  16 +-
 security/integrity/integrity.h                     |   2 +
 security/keys/trusted-keys/trusted_core.c          |  20 +-
 sound/core/info.c                                  |  21 +-
 sound/hda/hdac_stream.c                            |   6 +-
 sound/pci/hda/patch_realtek.c                      |  20 +-
 sound/soc/codecs/lpass-wsa-macro.c                 |   3 +
 sound/soc/ti/omap-mcbsp.c                          |   6 +-
 tools/power/x86/turbostat/turbostat.c              |   3 +-
 tools/testing/selftests/efivarfs/create-read.c     |   2 +
 tools/testing/selftests/resctrl/cmt_test.c         |   3 -
 tools/testing/selftests/resctrl/mba_test.c         |   2 +-
 tools/testing/selftests/resctrl/mbm_test.c         |   2 +-
 296 files changed, 2790 insertions(+), 1353 deletions(-)


