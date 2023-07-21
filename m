Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCEF775D411
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 21:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232003AbjGUTRZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 15:17:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231715AbjGUTRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 15:17:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F3151BF4;
        Fri, 21 Jul 2023 12:17:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DA5AD61D76;
        Fri, 21 Jul 2023 19:17:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A6EAC433C7;
        Fri, 21 Jul 2023 19:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689967038;
        bh=JyHC2DlVcR2rAnmA2Cz2gXSBivH/nE683WljiQXED6U=;
        h=From:To:Cc:Subject:Date:From;
        b=LYoWICXxCkUk26ueCxV9Ns7W+xCiZsgTz6NjdJ2IwHdn7DFDFiam/LASgAFid8brC
         EVbef7FgdIIEUdL2PFu/mosLJGE0Gff3M96NgZnu2ywJum1ZrxXw6IF7svJ9lIcfes
         e7URiLcBgmeyi9Vo8bl+nADwBUPW4sIdXXVGUbmQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: [PATCH 6.1 000/223] 6.1.40-rc1 review
Date:   Fri, 21 Jul 2023 18:04:13 +0200
Message-ID: <20230721160520.865493356@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.40-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.1.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.1.40-rc1
X-KernelTest-Deadline: 2023-07-23T16:05+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 6.1.40 release.
There are 223 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Sun, 23 Jul 2023 16:04:33 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.40-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 6.1.40-rc1

Pedro Tammela <pctammela@mojatatu.com>
    net/sched: sch_qfq: reintroduce lmax bound check for MTU

Randy Dunlap <rdunlap@infradead.org>
    swiotlb: mark swiotlb_memblock_alloc() as __init

Mario Limonciello <mario.limonciello@amd.com>
    Revert "drm/amd: Disable PSR-SU on Parade 0803 TCON"

Thomas Bogendoerfer <tsbogend@alpha.franken.de>
    MIPS: kvm: Fix build error with KVM_MIPS_DEBUG_COP0_COUNTERS enabled

Dan Carpenter <dan.carpenter@linaro.org>
    scsi: qla2xxx: Fix end of loop test

Manish Rangankar <mrangankar@marvell.com>
    scsi: qla2xxx: Remove unused nvme_ls_waitq wait queue

Shreyas Deodhar <sdeodhar@marvell.com>
    scsi: qla2xxx: Pointer may be dereferenced

Bikash Hazarika <bhazarika@marvell.com>
    scsi: qla2xxx: Correct the index of array

Nilesh Javali <njavali@marvell.com>
    scsi: qla2xxx: Check valid rport returned by fc_bsg_to_rport()

Bikash Hazarika <bhazarika@marvell.com>
    scsi: qla2xxx: Fix potential NULL pointer dereference

Quinn Tran <qutran@marvell.com>
    scsi: qla2xxx: Fix buffer overrun

Nilesh Javali <njavali@marvell.com>
    scsi: qla2xxx: Avoid fcport pointer dereference

Nilesh Javali <njavali@marvell.com>
    scsi: qla2xxx: Array index may go out of bound

Quinn Tran <qutran@marvell.com>
    scsi: qla2xxx: Fix mem access after free

Quinn Tran <qutran@marvell.com>
    scsi: qla2xxx: Wait for io return on terminate rport

Quinn Tran <qutran@marvell.com>
    scsi: qla2xxx: Fix hang in task management

Quinn Tran <qutran@marvell.com>
    scsi: qla2xxx: Fix task management cmd fail due to unavailable resource

Quinn Tran <qutran@marvell.com>
    scsi: qla2xxx: Fix task management cmd failure

Quinn Tran <qutran@marvell.com>
    scsi: qla2xxx: Multi-que support for TMF

Beau Belgrave <beaub@linux.microsoft.com>
    tracing/user_events: Fix struct arg size match check

Masami Hiramatsu (Google) <mhiramat@kernel.org>
    tracing/probes: Fix to update dynamic data counter if fetcharg uses it

Masami Hiramatsu (Google) <mhiramat@kernel.org>
    tracing/probes: Fix not to count error code to total length

Matthieu Baerts <matthieu.baerts@tessares.net>
    selftests: mptcp: pm_nl_ctl: fix 32-bit support

Matthieu Baerts <matthieu.baerts@tessares.net>
    selftests: mptcp: depend on SYN_COOKIES

Matthieu Baerts <matthieu.baerts@tessares.net>
    selftests: mptcp: userspace_pm: report errors with 'remove' tests

Matthieu Baerts <matthieu.baerts@tessares.net>
    selftests: mptcp: userspace_pm: use correct server port

Matthieu Baerts <matthieu.baerts@tessares.net>
    selftests: mptcp: sockopt: return error if wrong mark

Matthieu Baerts <matthieu.baerts@tessares.net>
    selftests: mptcp: connect: fail if nft supposed to work

Mateusz Stachyra <m.stachyra@samsung.com>
    tracing: Fix null pointer dereference in tracing_err_log_open()

Masami Hiramatsu (Google) <mhiramat@kernel.org>
    fprobe: Ensure running fprobe_exit_handler() finished before calling rethook_free()

Jiri Olsa <jolsa@kernel.org>
    fprobe: Release rethook after the ftrace_ops is unregistered

Heiner Kallweit <hkallweit1@gmail.com>
    pwm: meson: fix handling of period/duty if greater than UINT_MAX

Heiner Kallweit <hkallweit1@gmail.com>
    pwm: meson: modify and simplify calculation in meson_pwm_get_state

Chungkai Yang <Chung-kai.Yang@mediatek.com>
    PM: QoS: Restore support for default value on frequency QoS

Namhyung Kim <namhyung@kernel.org>
    perf/x86: Fix lockdep warning in for_each_sibling_event() on SPR

Max Filippov <jcmvbkbc@gmail.com>
    xtensa: ISS: fix call to split_if_spec

Bharath SM <bharathsm@microsoft.com>
    cifs: if deferred close is disabled then close files immediately

Mario Limonciello <mario.limonciello@amd.com>
    drm/amd/pm: conditionally disable pcie lane/speed switching for SMU13

Evan Quan <evan.quan@amd.com>
    drm/amd/pm: share the code around SMU13 pcie parameters update

Zheng Yejian <zhengyejian1@huawei.com>
    ftrace: Fix possible warning on checking all pages used in ftrace_process_locs()

Zheng Yejian <zhengyejian1@huawei.com>
    ring-buffer: Fix deadloop issue on reading trace_pipe

Krister Johansen <kjlx@templeofstupid.com>
    net: ena: fix shift-out-of-bounds in exponential backoff

Isaac J. Manjarres <isaacmanjarres@google.com>
    regmap-irq: Fix out-of-bounds access when allocating config buffers

Eric Lin <eric.lin@sifive.com>
    perf: RISC-V: Remove PERF_HES_STOPPED flag checking in riscv_pmu_start()

Florent Revest <revest@chromium.org>
    samples: ftrace: Save required argument registers in sample trampolines

Christoph Hellwig <hch@lst.de>
    nvme: don't reject probe due to duplicate IDs for single-ported PCIe devices

Zheng Yejian <zhengyejian1@huawei.com>
    tracing: Fix memory leak of iter->temp when reading trace_pipe

Mohamed Khalfella <mkhalfella@purestorage.com>
    tracing/histograms: Add histograms to hist_vars if they have referenced variables

Matthias Kaehlcke <mka@chromium.org>
    dm: verity-loadpin: Add NULL pointer check for 'bdev' parameter

Heiko Carstens <hca@linux.ibm.com>
    s390/decompressor: fix misaligned symbol build error

Jonas Gorski <jonas.gorski@gmail.com>
    bus: ixp4xx: fix IXP4XX_EXP_T1_MASK

Jiaqing Zhao <jiaqing.zhao@linux.intel.com>
    Revert "8250: add support for ASIX devices with a FIFO bug"

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    soundwire: qcom: fix storing port config out-of-bounds

Stephan Gerhold <stephan.gerhold@kernkonzept.com>
    opp: Fix use-after-free in lazy_opp_tables after probe deferral

George Stark <gnstark@sberdevices.ru>
    meson saradc: fix clock divider mask length

Weitao Wang <WeitaoWang-oc@zhaoxin.com>
    xhci: Show ZHAOXIN xHCI root hub speed correctly

Weitao Wang <WeitaoWang-oc@zhaoxin.com>
    xhci: Fix TRB prefetch issue of ZHAOXIN hosts

Weitao Wang <WeitaoWang-oc@zhaoxin.com>
    xhci: Fix resume issue of some ZHAOXIN hosts

Xiubo Li <xiubli@redhat.com>
    ceph: don't let check_caps skip sending responses for revoke msgs

Xiubo Li <xiubli@redhat.com>
    ceph: fix blindly expanding the readahead windows

Xiubo Li <xiubli@redhat.com>
    ceph: add a dedicated private data for netfs rreq

Ilya Dryomov <idryomov@gmail.com>
    libceph: harden msgr2.1 frame segment length checks

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    firmware: stratix10-svc: Fix a potential resource leak in svc_create_memory_pool()

Martin Fuzzey <martin.fuzzey@flowbird.group>
    tty: serial: imx: fix rs485 rx after tx

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    tty: serial: samsung_tty: Fix a memory leak in s3c24xx_serial_getclk() when iterating clk

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    tty: serial: samsung_tty: Fix a memory leak in s3c24xx_serial_getclk() in case of error

Dan Carpenter <dan.carpenter@linaro.org>
    serial: atmel: don't enable IRQs prematurely

Christian König <christian.koenig@amd.com>
    drm/ttm: never consider pinned BOs for eviction&swap

Thomas Hellström <thomas.hellstrom@linux.intel.com>
    drm/ttm: Don't leak a resource on swapout move error

gaba <gaba@amd.com>
    drm/amdgpu: avoid restore process run into dead loop.

Aurabindo Pillai <aurabindo.pillai@amd.com>
    drm/amd/display: Add monitor specific edid quirk

Mario Limonciello <mario.limonciello@amd.com>
    drm/amd/display: Correct `DMUB_FW_VERSION` macro

Sung-huai Wang <danny.wang@amd.com>
    drm/amd/display: add a NULL pointer check

Mario Limonciello <mario.limonciello@amd.com>
    drm/amd: Disable PSR-SU on Parade 0803 TCON

Samuel Pitoiset <samuel.pitoiset@gmail.com>
    drm/amdgpu: fix clearing mappings for BOs that are always valid in VM

Leo Chen <sancchen@amd.com>
    drm/amd/display: disable seamless boot if force_odm_combine is enabled

Austin Zheng <austin.zheng@amd.com>
    drm/amd/display: Remove Phantom Pipe Check When Calculating K1 and K2

Hersen Wu <hersenxs.wu@amd.com>
    drm/amd/display: edp do not add non-edid timings

Dmytro Laktyushkin <dmytro.laktyushkin@amd.com>
    drm/amd/display: fix seamless odm transitions

Brian Norris <briannorris@chromium.org>
    drm/rockchip: vop: Leave vblank enabled in self-refresh

Brian Norris <briannorris@chromium.org>
    drm/atomic: Allow vblank-enabled + self-refresh "disable"

Justin Tee <justin.tee@broadcom.com>
    scsi: lpfc: Fix double free in lpfc_cmpl_els_logo_acc() caused by lpfc_nlp_not_used()

Alexander Aring <aahringo@redhat.com>
    fs: dlm: fix mismatch of plock results from userspace

Alexander Aring <aahringo@redhat.com>
    fs: dlm: make F_SETLK use unkillable wait_event

Alexander Aring <aahringo@redhat.com>
    fs: dlm: interrupt posix locks only when process is killed

Alexander Aring <aahringo@redhat.com>
    fs: dlm: fix cleanup pending ops when interrupted

Alexander Aring <aahringo@redhat.com>
    fs: dlm: return positive pid value for F_GETLK

Peter Korsgaard <peter@korsgaard.com>
    dm init: add dm-mod.waitfor to wait for asynchronously probed block devices

Jason Baron <jbaron@akamai.com>
    md/raid0: add discard support for the 'original' layout

Johan Hovold <johan+linaro@kernel.org>
    mfd: pm8008: Fix module autoloading

Damien Le Moal <dlemoal@kernel.org>
    misc: pci_endpoint_test: Re-init completion for every test

Damien Le Moal <dlemoal@kernel.org>
    misc: pci_endpoint_test: Free IRQs before removing the device

Damien Le Moal <dlemoal@kernel.org>
    PCI: rockchip: Set address alignment for endpoint mode

Rick Wertenbroek <rick.wertenbroek@gmail.com>
    PCI: rockchip: Use u32 variable to access 32-bit registers

Rick Wertenbroek <rick.wertenbroek@gmail.com>
    PCI: rockchip: Fix legacy IRQ generation for RK3399 PCIe endpoint core

Rick Wertenbroek <rick.wertenbroek@gmail.com>
    PCI: rockchip: Add poll and timeout to wait for PHY PLLs to be locked

Rick Wertenbroek <rick.wertenbroek@gmail.com>
    PCI: rockchip: Write PCI Device ID to correct register

Rick Wertenbroek <rick.wertenbroek@gmail.com>
    PCI: rockchip: Assert PCI Configuration Enable bit after probe

Damien Le Moal <dlemoal@kernel.org>
    PCI: epf-test: Fix DMA transfer completion detection

Damien Le Moal <dlemoal@kernel.org>
    PCI: epf-test: Fix DMA transfer completion initialization

Manivannan Sadhasivam <mani@kernel.org>
    PCI: qcom: Disable write access to read only registers for IP v2.3.3

Igor Mammedov <imammedo@redhat.com>
    PCI: acpiphp: Reassign resources on bridge if necessary

Robin Murphy <robin.murphy@arm.com>
    PCI: Add function 1 DMA alias quirk for Marvell 88SE9235

Ross Lagerwall <ross.lagerwall@citrix.com>
    PCI: Release resource invalidated by coalescing

Ondrej Zary <linux@zary.sk>
    PCI/PM: Avoid putting EloPOS E2/S2/H2 PCIe Ports in D3cold

Harald Freudenberger <freude@linux.ibm.com>
    s390/zcrypt: do not retry administrative requests

Sathya Prakash <sathya.prakash@broadcom.com>
    scsi: mpi3mr: Propagate sense data for admin queue SCSI I/O

Mikulas Patocka <mpatocka@redhat.com>
    dm integrity: reduce vmalloc space footprint on 32-bit architectures

Martin Kaiser <martin@kaiser.cx>
    hwrng: imx-rngc - fix the timeout for init and self check

Siddh Raman Pant <code@siddh.me>
    jfs: jfs_dmap: Validate db_l2nbperpage while mounting

Ritesh Harjani (IBM) <ritesh.list@gmail.com>
    ext2/dax: Fix ext2_setsize when len is page aligned

Christian Marangi <ansuelsmth@gmail.com>
    soc: qcom: mdt_loader: Fix unconditional call to scm_pas_mem_setup

Alexander Aring <aahringo@redhat.com>
    fs: dlm: revert check required context while close

Baokun Li <libaokun1@huawei.com>
    ext4: only update i_reserved_data_blocks on successful block allocation

Baokun Li <libaokun1@huawei.com>
    ext4: turn quotas off if mount failed after enabling quotas

Chao Yu <chao@kernel.org>
    ext4: fix to check return value of freeze_bdev() in ext4_shutdown()

Kemeng Shi <shikemeng@huaweicloud.com>
    ext4: fix wrong unit use in ext4_mb_new_blocks

Kemeng Shi <shikemeng@huaweicloud.com>
    ext4: get block from bh in ext4_free_blocks for fast commit replay

Kemeng Shi <shikemeng@huaweicloud.com>
    ext4: fix wrong unit use in ext4_mb_clear_bb

Zhihao Cheng <chengzhihao1@huawei.com>
    ext4: Fix reusing stale buffer heads from last failed mounting

Huacai Chen <chenhuacai@kernel.org>
    MIPS: KVM: Fix NULL pointer dereference

Huacai Chen <chenhuacai@kernel.org>
    MIPS: Loongson: Fix cpu_probe_loongson() again

Michael Ellerman <mpe@ellerman.id.au>
    powerpc/64s: Fix native_hpte_remove() to be irq-safe

Michael Ellerman <mpe@ellerman.id.au>
    powerpc/security: Fix Speculation_Store_Bypass reporting on Power10

Ekansh Gupta <quic_ekangupt@quicinc.com>
    misc: fastrpc: Create fastrpc scalar with correct buffer count

Naveen N Rao <naveen@kernel.org>
    powerpc: Fail build if using recordmcount with binutils v2.37

sunliming <sunliming@kylinos.cn>
    tracing/user_events: Fix incorrect return value for writing operation when events are disabled

Arnd Bergmann <arnd@arndb.de>
    kasan: add kasan_tag_mismatch prototype

Oleksij Rempel <linux@rempel-privat.de>
    net: phy: dp83td510: fix kernel stall during netboot in DP83TD510E PHY driver

Florian Fainelli <florian.fainelli@broadcom.com>
    net: bcmgenet: Ensure MDIO unregistration has clocks enabled

Arseniy Krasnov <AVKrasnov@sberdevices.ru>
    mtd: rawnand: meson: fix unaligned DMA buffers handling

Jerry Snitselaar <jsnitsel@redhat.com>
    tpm: return false from tpm_amd_is_rng_defective on non-x86 platforms

Alexander Sverdlin <alexander.sverdlin@siemens.com>
    tpm: tis_i2c: Limit write bursts to I2C_SMBUS_BLOCK_MAX (32) bytes

Alexander Sverdlin <alexander.sverdlin@siemens.com>
    tpm: tis_i2c: Limit read bursts to I2C_SMBUS_BLOCK_MAX (32) bytes

Jarkko Sakkinen <jarkko.sakkinen@tuni.fi>
    tpm: tpm_vtpm_proxy: fix a race condition in /dev/vtpmx creation

Valentin David <valentin.david@gmail.com>
    tpm: Do not remap from ACPI resources again for Pluton TPM

Mario Limonciello <mario.limonciello@amd.com>
    pinctrl: amd: Unify debounce handling into amd_pinconf_set()

Mario Limonciello <mario.limonciello@amd.com>
    pinctrl: amd: Drop pull up select configuration

Mario Limonciello <mario.limonciello@amd.com>
    pinctrl: amd: Use amd_pinconf_set() for all config options

Mario Limonciello <mario.limonciello@amd.com>
    pinctrl: amd: Only use special debounce behavior for GPIO 0

Mario Limonciello <mario.limonciello@amd.com>
    pinctrl: amd: Revert "pinctrl: amd: disable and mask interrupts on probe"

Kornel Dulęba <korneld@chromium.org>
    pinctrl: amd: Detect and mask spurious interrupts

Mario Limonciello <mario.limonciello@amd.com>
    pinctrl: amd: Fix mistake in handling clearing pins at startup

Mario Limonciello <mario.limonciello@amd.com>
    pinctrl: amd: Detect internal GPIO0 debounce handling

Mario Limonciello <mario.limonciello@amd.com>
    pinctrl: amd: Add fields for interrupt status and wake status

Mario Limonciello <mario.limonciello@amd.com>
    pinctrl: amd: Adjust debugfs output

Basavaraj Natikar <Basavaraj.Natikar@amd.com>
    pinctrl: amd: Add Z-state wake control bits

Jaegeuk Kim <jaegeuk@kernel.org>
    f2fs: fix deadlock in i_xattr_sem and inode page lock

Jaegeuk Kim <jaegeuk@kernel.org>
    f2fs: fix the wrong condition to determine atomic context

Kenneth Feng <kenneth.feng@amd.com>
    drm/amd/pm: add abnormal fan detection for smu 13.0.0

Luben Tuikov <luben.tuikov@amd.com>
    drm/amdgpu: Fix minmax warning

lyndonli <Lyndon.Li@amd.com>
    drm/amdgpu: add the fan abnormal detection feature

Evan Quan <evan.quan@amd.com>
    drm/amd/pm: revise the ASPM settings for thunderbolt attached scenario

Alex Deucher <alexander.deucher@amd.com>
    drm/amdgpu/sdma4: set align mask to 255

Thomas Zimmermann <tzimmermann@suse.de>
    drm/client: Send hotplug event after registering a client

Winston Wen <wentao@uniontech.com>
    cifs: fix session state check in smb2_find_smb_ses

Zhihao Cheng <chengzhihao1@huawei.com>
    ovl: fix null pointer dereference in ovl_get_acl_rcu()

Zhihao Cheng <chengzhihao1@huawei.com>
    ovl: let helper ovl_i_path_real() return the realinode

Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
    fs/ntfs3: Check fields while reading

Ming Lei <ming.lei@redhat.com>
    nvme-pci: fix DMA direction of unmapping integrity data

Pedro Tammela <pctammela@mojatatu.com>
    net/sched: sch_qfq: account for stab overhead in qfq_enqueue

Pedro Tammela <pctammela@mojatatu.com>
    net/sched: sch_qfq: refactor parsing of netlink parameters

Zhang Shurong <zhang_shurong@foxmail.com>
    wifi: rtw89: debug: fix error code in rtw89_debug_priv_send_h2c_set()

Pedro Tammela <pctammela@mojatatu.com>
    net/sched: make psched_mtu() RTNL-less safe

Dan Carpenter <dan.carpenter@linaro.org>
    netdevsim: fix uninitialized data in nsim_dev_trap_fa_cookie_write()

Jisheng Zhang <jszhang@kernel.org>
    riscv: mm: fix truncation warning on RV32

Ido Schimmel <idosch@nvidia.com>
    net/sched: flower: Ensure both minimum and maximum ports are specified

Pu Lehui <pulehui@huawei.com>
    bpf: cpumap: Fix memory leak in cpu_map_update_elem

Randy Dunlap <rdunlap@infradead.org>
    wifi: airo: avoid uninitialized warning in airo_get_rate()

Xin Yin <yinxin.x@bytedance.com>
    erofs: fix fsdax unavailability for chunk-based regular files

Chunhai Guo <guochunhai@vivo.com>
    erofs: avoid infinite loop in z_erofs_do_read_page() when reading beyond EOF

Chunhai Guo <guochunhai@vivo.com>
    erofs: avoid useless loops in z_erofs_pcluster_readmore() when reading beyond EOF

Suman Ghosh <sumang@marvell.com>
    octeontx2-pf: Add additional check for MCAM rules

Tvrtko Ursulin <tvrtko.ursulin@intel.com>
    drm/i915: Fix one wrong caching mode enum usage

Stanislav Lisovskiy <stanislav.lisovskiy@intel.com>
    drm/i915: Don't preserve dpll_hw_state for slave crtc in Bigjoiner

Björn Töpel <bjorn@rivosinc.com>
    riscv, bpf: Fix inconsistent JIT image generation

Ankit Kumar <ankit.kumar@samsung.com>
    nvme: fix the NVME_ID_NS_NVM_STS_MASK definition

Florian Kauer <florian.kauer@linutronix.de>
    igc: Fix inserting of empty frame for launchtime

Florian Kauer <florian.kauer@linutronix.de>
    igc: Fix launchtime before start of cycle

Tzvetomir Stoyanov (VMware) <tz.stoyanov@gmail.com>
    kernel/trace: Fix cleanup logic of enable_trace_eprobe

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    platform/x86: wmi: Break possible infinite loop when parsing GUID

Jiasheng Jiang <jiasheng@iscas.ac.cn>
    net: dsa: qca8k: Add check for skb_copy

Ziyang Xuan <william.xuanziyang@huawei.com>
    ipv6/addrconf: fix a potential refcount underflow for idev

Jiasheng Jiang <jiasheng@iscas.ac.cn>
    NTB: ntb_tool: Add check for devm_kcalloc

Yang Yingliang <yangyingliang@huawei.com>
    NTB: ntb_transport: fix possible memory leak while device_register() fails

Yuan Can <yuancan@huawei.com>
    ntb: intel: Fix error handling in intel_ntb_pci_driver_init()

Yuan Can <yuancan@huawei.com>
    NTB: amd: Fix error handling in amd_ntb_pci_driver_init()

Yuan Can <yuancan@huawei.com>
    ntb: idt: Fix error handling in idt_pci_driver_init()

Eric Dumazet <edumazet@google.com>
    udp6: fix udp6_ehashfn() typo

Kuniyuki Iwashima <kuniyu@amazon.com>
    icmp6: Fix null-ptr-deref of ip6_null_entry->rt6i_idev in icmp6_dev().

Paolo Abeni <pabeni@redhat.com>
    net: prevent skb corruption on frag list segmentation

Rafał Miłecki <rafal@milecki.pl>
    net: bgmac: postpone turning IRQs off to avoid SoC hangs

Nitya Sunkad <nitya.sunkad@amd.com>
    ionic: remove WARN_ON to prevent panic_on_warn

Sai Krishna <saikrishnag@marvell.com>
    octeontx2-af: Move validation of ptp pointer before its usage

Ratheesh Kannoth <rkannoth@marvell.com>
    octeontx2-af: Promisc enable/disable through mbox

Junfeng Guo <junfeng.guo@intel.com>
    gve: Set default duplex configuration to full

M A Ramdhan <ramdhan@starlabs.sg>
    net/sched: cls_fw: Fix improper refcount update leads to use-after-free

Klaus Kudielka <klaus.kudielka@gmail.com>
    net: mvneta: fix txq_map in case of txq_number==1

Kumar Kartikeya Dwivedi <memxor@gmail.com>
    bpf: Fix max stack depth check for async callbacks

Randy Dunlap <rdunlap@infradead.org>
    scsi: ufs: ufs-mediatek: Add dependency for RESET_CONTROLLER

Dan Carpenter <dan.carpenter@linaro.org>
    scsi: qla2xxx: Fix error code in qla2x00_start_sp()

Eric Biggers <ebiggers@google.com>
    blk-crypto: use dynamic lock class for blk_crypto_profile::lock

Aravindhan Gunasekaran <aravindhan.gunasekaran@intel.com>
    igc: Handle PPS start time programming for past time values

Prasad Koya <prasad@arista.com>
    igc: set TP bit in 'supported' and 'advertising' fields of ethtool_link_ksettings

Vlad Buslov <vladbu@nvidia.com>
    net/mlx5e: Check for NOT_READY flag state after locking

Zhengchao Shao <shaozhengchao@huawei.com>
    net/mlx5e: fix memory leak in mlx5e_ptp_open

Zhengchao Shao <shaozhengchao@huawei.com>
    net/mlx5e: fix memory leak in mlx5e_fs_tt_redirect_any_create

Zhengchao Shao <shaozhengchao@huawei.com>
    net/mlx5e: fix double free in mlx5e_destroy_flow_table

Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
    igc: Remove delay during TX ring configuration

Sridhar Samudrala <sridhar.samudrala@intel.com>
    ice: Fix max_rate check while configuring TX rate limits

Marek Vasut <marex@denx.de>
    drm/panel: simple: Add Powertip PH800480T013 drm_display_mode flags

Petr Tesarik <petr.tesarik.ext@huawei.com>
    swiotlb: reduce the number of areas to match actual memory pool size

Alexey Kardashevskiy <aik@amd.com>
    swiotlb: reduce the swiotlb buffer size on allocation failure

Petr Tesarik <petr.tesarik.ext@huawei.com>
    swiotlb: always set the number of areas before allocating the pool

Douglas Anderson <dianders@chromium.org>
    drm/bridge: ti-sn65dsi86: Fix auxiliary bus lifetime

Fabio Estevam <festevam@denx.de>
    drm/panel: simple: Add connector_type for innolux_at043tn24

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: fix out of bounds read in smb2_sess_setup

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: add missing compound request handing in some commands

Linus Torvalds <torvalds@linux-foundation.org>
    workqueue: clean up WORK_* constant types, clarify masking

Moritz Fischer <moritzf@google.com>
    net: lan743x: Don't sleep in atomic context

Basavaraj Natikar <Basavaraj.Natikar@amd.com>
    HID: amd_sfh: Fix for shift-out-of-bounds

Basavaraj Natikar <Basavaraj.Natikar@amd.com>
    HID: amd_sfh: Rename the float32 variable

Ivan Mikhaylov <fr0st61te@gmail.com>
    net/ncsi: change from ndo_set_mac_address to dev_set_mac_address


-------------

Diffstat:

 .../admin-guide/device-mapper/dm-init.rst          |   8 +
 Makefile                                           |   4 +-
 arch/mips/include/asm/kvm_host.h                   |   6 +-
 arch/mips/kernel/cpu-probe.c                       |   9 +-
 arch/mips/kvm/emulate.c                            |  22 +-
 arch/mips/kvm/mips.c                               |  16 +-
 arch/mips/kvm/stats.c                              |   4 +-
 arch/mips/kvm/trace.h                              |   8 +-
 arch/mips/kvm/vz.c                                 |  20 +-
 arch/powerpc/Makefile                              |   8 +
 arch/powerpc/kernel/security.c                     |  37 +--
 arch/powerpc/mm/book3s64/hash_native.c             |  13 +-
 arch/riscv/mm/init.c                               |   2 +-
 arch/riscv/net/bpf_jit.h                           |   6 +-
 arch/riscv/net/bpf_jit_core.c                      |  19 +-
 arch/s390/Makefile                                 |   1 +
 arch/x86/events/intel/core.c                       |   7 +
 arch/xtensa/platforms/iss/network.c                |   2 +-
 block/blk-crypto-profile.c                         |  12 +-
 drivers/base/regmap/regmap-irq.c                   |   2 +-
 drivers/bus/intel-ixp4xx-eb.c                      |   2 +-
 drivers/char/hw_random/imx-rngc.c                  |   6 +-
 drivers/char/tpm/tpm-chip.c                        |   7 +
 drivers/char/tpm/tpm_crb.c                         |  19 +-
 drivers/char/tpm/tpm_tis_i2c.c                     |  59 +++--
 drivers/char/tpm/tpm_vtpm_proxy.c                  |  30 +--
 drivers/firmware/stratix10-svc.c                   |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c   |   3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c             |  12 +
 drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c             |  11 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c             |   4 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |   8 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c  |  26 +++
 drivers/gpu/drm/amd/display/dc/core/dc.c           |   3 +
 .../drm/amd/display/dc/dce112/dce112_resource.c    |  10 +-
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c |  11 +
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c |   4 -
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.c  |   2 +-
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.h  |   1 +
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h        |   2 +-
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h      |   1 +
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h       |   4 +
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c     |  98 ++++++++
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c   |  34 +--
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c   |  34 +--
 drivers/gpu/drm/bridge/ti-sn65dsi86.c              |  35 +--
 drivers/gpu/drm/drm_atomic_helper.c                |  11 +-
 drivers/gpu/drm/drm_client.c                       |  21 ++
 drivers/gpu/drm/drm_fb_helper.c                    |   4 -
 drivers/gpu/drm/i915/display/intel_display.c       |   1 -
 drivers/gpu/drm/i915/gt/intel_gtt.c                |   2 +-
 drivers/gpu/drm/panel/panel-simple.c               |   2 +
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c        |   8 +-
 drivers/gpu/drm/ttm/ttm_bo.c                       |   7 +
 drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_desc.c      |  30 ++-
 drivers/iio/adc/meson_saradc.c                     |   2 +-
 drivers/md/dm-init.c                               |  22 +-
 drivers/md/dm-integrity.c                          |   4 +-
 drivers/md/dm-verity-loadpin.c                     |   3 +
 drivers/md/raid0.c                                 |  62 ++++-
 drivers/md/raid0.h                                 |   1 +
 drivers/mfd/qcom-pm8008.c                          |   1 +
 drivers/misc/fastrpc.c                             |   2 +-
 drivers/misc/pci_endpoint_test.c                   |  10 +-
 drivers/mtd/nand/raw/meson_nand.c                  |   4 +
 drivers/net/dsa/qca/qca8k-8xxx.c                   |   3 +
 drivers/net/ethernet/amazon/ena/ena_com.c          |   3 +
 drivers/net/ethernet/broadcom/bgmac.c              |   4 +-
 drivers/net/ethernet/broadcom/genet/bcmmii.c       |   2 +
 drivers/net/ethernet/google/gve/gve_ethtool.c      |   3 +
 drivers/net/ethernet/intel/ice/ice_main.c          |  16 +-
 drivers/net/ethernet/intel/igc/igc_ethtool.c       |   2 +
 drivers/net/ethernet/intel/igc/igc_main.c          |   5 +-
 drivers/net/ethernet/intel/igc/igc_ptp.c           |  25 +-
 drivers/net/ethernet/marvell/mvneta.c              |   4 +-
 drivers/net/ethernet/marvell/octeontx2/af/ptp.c    |  19 +-
 drivers/net/ethernet/marvell/octeontx2/af/rvu.c    |   2 +-
 .../net/ethernet/marvell/octeontx2/af/rvu_nix.c    |  11 +-
 .../ethernet/marvell/octeontx2/af/rvu_npc_hash.c   |  23 +-
 .../ethernet/marvell/octeontx2/nic/otx2_flows.c    |   8 +
 .../net/ethernet/marvell/octeontx2/nic/otx2_tc.c   |  15 ++
 .../mellanox/mlx5/core/en/fs_tt_redirect.c         |   6 +-
 drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c   |   6 +-
 .../ethernet/mellanox/mlx5/core/en_accel/fs_tcp.c  |   1 +
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c    |   6 +-
 drivers/net/ethernet/microchip/lan743x_main.c      |  21 +-
 drivers/net/ethernet/pensando/ionic/ionic_lif.c    |   5 -
 drivers/net/netdevsim/dev.c                        |   9 +-
 drivers/net/phy/dp83td510.c                        |  23 +-
 drivers/net/wireless/cisco/airo.c                  |   5 +-
 drivers/net/wireless/realtek/rtw89/debug.c         |   5 +-
 drivers/ntb/hw/amd/ntb_hw_amd.c                    |   7 +-
 drivers/ntb/hw/idt/ntb_hw_idt.c                    |   7 +-
 drivers/ntb/hw/intel/ntb_hw_gen1.c                 |   7 +-
 drivers/ntb/ntb_transport.c                        |   2 +-
 drivers/ntb/test/ntb_tool.c                        |   2 +
 drivers/nvme/host/core.c                           |  36 ++-
 drivers/nvme/host/pci.c                            |   2 +-
 drivers/opp/core.c                                 |   3 +
 drivers/pci/controller/dwc/pcie-qcom.c             |   2 +
 drivers/pci/controller/pcie-rockchip-ep.c          |  65 ++----
 drivers/pci/controller/pcie-rockchip.c             |  17 ++
 drivers/pci/controller/pcie-rockchip.h             |  11 +-
 drivers/pci/endpoint/functions/pci-epf-test.c      |  40 +++-
 drivers/pci/hotplug/acpiphp_glue.c                 |   5 +-
 drivers/pci/pci.c                                  |  10 +-
 drivers/pci/probe.c                                |   4 +-
 drivers/pci/quirks.c                               |   2 +
 drivers/perf/riscv_pmu.c                           |   3 -
 drivers/pinctrl/pinctrl-amd.c                      | 190 +++++++--------
 drivers/pinctrl/pinctrl-amd.h                      |   3 +-
 drivers/platform/x86/wmi.c                         |  22 +-
 drivers/pwm/pwm-meson.c                            |  28 +--
 drivers/s390/crypto/zcrypt_msgtype6.c              |   6 +
 drivers/scsi/lpfc/lpfc_crtn.h                      |   1 -
 drivers/scsi/lpfc/lpfc_els.c                       |  30 +--
 drivers/scsi/lpfc/lpfc_hbadisc.c                   |  24 +-
 drivers/scsi/mpi3mr/mpi3mr_fw.c                    |   5 +
 drivers/scsi/qla2xxx/qla_attr.c                    |  13 ++
 drivers/scsi/qla2xxx/qla_bsg.c                     |   6 +
 drivers/scsi/qla2xxx/qla_def.h                     |  22 +-
 drivers/scsi/qla2xxx/qla_edif.c                    |   4 +-
 drivers/scsi/qla2xxx/qla_gbl.h                     |   2 +-
 drivers/scsi/qla2xxx/qla_init.c                    | 258 +++++++++++++++++++--
 drivers/scsi/qla2xxx/qla_inline.h                  |   5 +-
 drivers/scsi/qla2xxx/qla_iocb.c                    |  38 ++-
 drivers/scsi/qla2xxx/qla_isr.c                     |  64 ++++-
 drivers/scsi/qla2xxx/qla_nvme.c                    |   3 -
 drivers/scsi/qla2xxx/qla_os.c                      | 133 ++++++-----
 drivers/soc/qcom/mdt_loader.c                      |  16 +-
 drivers/soundwire/qcom.c                           |   3 +-
 drivers/tty/serial/8250/8250.h                     |   1 -
 drivers/tty/serial/8250/8250_pci.c                 |  19 --
 drivers/tty/serial/8250/8250_port.c                |  11 +-
 drivers/tty/serial/atmel_serial.c                  |   4 +-
 drivers/tty/serial/imx.c                           |  18 +-
 drivers/tty/serial/samsung_tty.c                   |  14 +-
 drivers/ufs/host/Kconfig                           |   1 +
 drivers/usb/host/xhci-mem.c                        |  39 +++-
 drivers/usb/host/xhci-pci.c                        |  12 +
 drivers/usb/host/xhci.h                            |   2 +
 fs/ceph/addr.c                                     |  85 +++++--
 fs/ceph/caps.c                                     |   9 +
 fs/ceph/super.h                                    |  13 ++
 fs/dlm/lockspace.c                                 |  12 -
 fs/dlm/lockspace.h                                 |   1 -
 fs/dlm/midcomms.c                                  |   3 -
 fs/dlm/plock.c                                     | 115 +++++----
 fs/erofs/inode.c                                   |   3 +-
 fs/erofs/zdata.c                                   |   4 +-
 fs/ext2/inode.c                                    |   5 +-
 fs/ext4/indirect.c                                 |   8 +
 fs/ext4/inode.c                                    |  10 -
 fs/ext4/ioctl.c                                    |   5 +-
 fs/ext4/mballoc.c                                  |  17 +-
 fs/ext4/super.c                                    |  19 +-
 fs/f2fs/compress.c                                 |   2 +-
 fs/f2fs/dir.c                                      |   9 +-
 fs/f2fs/xattr.c                                    |   6 +-
 fs/jfs/jfs_dmap.c                                  |   6 +
 fs/jfs/jfs_filsys.h                                |   2 +
 fs/ntfs3/index.c                                   |  84 ++++++-
 fs/ntfs3/inode.c                                   |  18 +-
 fs/ntfs3/ntfs_fs.h                                 |   4 +-
 fs/ntfs3/run.c                                     |   7 +-
 fs/ntfs3/xattr.c                                   | 109 ++++++---
 fs/overlayfs/inode.c                               |  12 +-
 fs/overlayfs/overlayfs.h                           |   2 +-
 fs/overlayfs/util.c                                |   7 +-
 fs/smb/client/file.c                               |   4 +-
 fs/smb/client/smb2transport.c                      |   7 +
 fs/smb/server/smb2pdu.c                            | 109 +++++----
 include/linux/blk-crypto-profile.h                 |   1 +
 include/linux/nvme.h                               |   2 +-
 include/linux/rethook.h                            |   1 +
 include/linux/serial_8250.h                        |   1 -
 include/linux/workqueue.h                          |  15 +-
 include/net/pkt_sched.h                            |   2 +-
 kernel/bpf/cpumap.c                                |  40 ++--
 kernel/bpf/verifier.c                              |   5 +-
 kernel/dma/swiotlb.c                               | 110 ++++++---
 kernel/power/qos.c                                 |   9 +-
 kernel/trace/fprobe.c                              |  11 +-
 kernel/trace/ftrace.c                              |  45 ++--
 kernel/trace/rethook.c                             |  13 ++
 kernel/trace/ring_buffer.c                         |  24 +-
 kernel/trace/trace.c                               |   3 +-
 kernel/trace/trace_eprobe.c                        |  18 +-
 kernel/trace/trace_events_hist.c                   |   8 +-
 kernel/trace/trace_events_user.c                   |   6 +-
 kernel/trace/trace_probe_tmpl.h                    |  14 +-
 kernel/workqueue.c                                 |  13 +-
 mm/kasan/kasan.h                                   |   3 +
 net/ceph/messenger_v2.c                            |  41 ++--
 net/core/skbuff.c                                  |   5 +
 net/ipv6/addrconf.c                                |   3 +-
 net/ipv6/icmp.c                                    |   5 +-
 net/ipv6/udp.c                                     |   2 +-
 net/ncsi/ncsi-rsp.c                                |   5 +-
 net/sched/cls_flower.c                             |  10 +
 net/sched/cls_fw.c                                 |  10 +-
 net/sched/sch_qfq.c                                |  41 ++--
 samples/ftrace/ftrace-direct-too.c                 |  14 +-
 tools/testing/selftests/net/mptcp/config           |   1 +
 tools/testing/selftests/net/mptcp/mptcp_connect.sh |   3 +
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh |   9 +-
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c      |  10 +-
 tools/testing/selftests/net/mptcp/userspace_pm.sh  |   4 +-
 208 files changed, 2314 insertions(+), 1175 deletions(-)


