Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABC3275CD47
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 18:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232493AbjGUQJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 12:09:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232467AbjGUQJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 12:09:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8820F2D50;
        Fri, 21 Jul 2023 09:09:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F1B0761D2B;
        Fri, 21 Jul 2023 16:09:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2407C433CB;
        Fri, 21 Jul 2023 16:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689955767;
        bh=tvJdlGE0WUKBfOVVqUB+kVZaxvSy3fL+cq7MvYGKHHw=;
        h=From:To:Cc:Subject:Date:From;
        b=uBS4S4lwB30TPrp28MqoBGz5yDO27io2IyAPa2+bzGVcszUPNgaNB+hFyKntIoxLM
         EPbRmHgkbdpdvKxXlWiDGQYrRlW/7CjzqlJWliGl8XTG7beMb9J9uV2YHozVUs1yT5
         au4rnCGLm4bIgwipxto2KuKpEH1pM8pi5bDBQvoU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: [PATCH 6.4 000/292] 6.4.5-rc1 review
Date:   Fri, 21 Jul 2023 18:01:49 +0200
Message-ID: <20230721160528.800311148@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.4.5-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.4.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.4.5-rc1
X-KernelTest-Deadline: 2023-07-23T16:05+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 6.4.5 release.
There are 292 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Sun, 23 Jul 2023 16:04:29 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.4.5-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.4.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 6.4.5-rc1

Mario Limonciello <mario.limonciello@amd.com>
    Revert "drm/amd: Disable PSR-SU on Parade 0803 TCON"

Thomas Bogendoerfer <tsbogend@alpha.franken.de>
    MIPS: kvm: Fix build error with KVM_MIPS_DEBUG_COP0_COUNTERS enabled

Dan Carpenter <dan.carpenter@linaro.org>
    net: dsa: ocelot: unlock on error in vsc9959_qos_port_tas_set()

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
    tracing/probes: Fix to record 0-length data_loc in fetch_store_string*() if fails

Masami Hiramatsu (Google) <mhiramat@kernel.org>
    Revert "tracing: Add "(fault)" name injection to kernel probes"

Masami Hiramatsu (Google) <mhiramat@kernel.org>
    tracing/probes: Fix to update dynamic data counter if fetcharg uses it

Masami Hiramatsu (Google) <mhiramat@kernel.org>
    tracing/probes: Fix not to count error code to total length

Masami Hiramatsu (Google) <mhiramat@kernel.org>
    tracing/probes: Fix to avoid double count of the string length on the array

Gustavo A. R. Silva <gustavoars@kernel.org>
    smb: client: Fix -Wstringop-overflow issues

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

Matthieu Baerts <matthieu.baerts@tessares.net>
    selftests: mptcp: sockopt: use 'iptables-legacy' if available

Paolo Abeni <pabeni@redhat.com>
    mptcp: ensure subflow is unhashed before cleaning the backlog

Paolo Abeni <pabeni@redhat.com>
    mptcp: do not rely on implicit state check in mptcp_listen()

Mateusz Stachyra <m.stachyra@samsung.com>
    tracing: Fix null pointer dereference in tracing_err_log_open()

Masami Hiramatsu (Google) <mhiramat@kernel.org>
    fprobe: Ensure running fprobe_exit_handler() finished before calling rethook_free()

Jiri Olsa <jolsa@kernel.org>
    fprobe: Release rethook after the ftrace_ops is unregistered

Karol Wachowski <karol.wachowski@linux.intel.com>
    accel/ivpu: Clear specific interrupt status bits on C0

Karol Wachowski <karol.wachowski@linux.intel.com>
    accel/ivpu: Fix VPU register access in irq disable

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

Sakari Ailus <sakari.ailus@linux.intel.com>
    media: uapi: Fix [GS]_ROUTING ACTIVE flag value

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

Oliver Upton <oliver.upton@linux.dev>
    arm64: errata: Mitigate Ampere1 erratum AC03_CPU_38 at stage-2

Yinjun Zhang <yinjun.zhang@corigine.com>
    nfp: clean mc addresses in application firmware when closing port

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

Hui Li <caelli@tencent.com>
    tty: fix hang on tty device with no_room set

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

Thomas Hellström <thomas.hellstrom@linux.intel.com>
    drm/ttm: Don't leak a resource on eviction error

Yang Wang <kevinyang.wang@amd.com>
    drm/amd/pm: fix smu i2c data read risk

gaba <gaba@amd.com>
    drm/amdgpu: avoid restore process run into dead loop.

Aurabindo Pillai <aurabindo.pillai@amd.com>
    drm/amd/display: Add monitor specific edid quirk

Mario Limonciello <mario.limonciello@amd.com>
    drm/amd/display: Correct `DMUB_FW_VERSION` macro

Ilya Bakoulin <ilya.bakoulin@amd.com>
    drm/amd/display: Fix 128b132b link loss handling

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

Alan Liu <HaoPing.Liu@amd.com>
    drm/amd/display: Fix in secure display context creation

Alvin Lee <Alvin.Lee2@amd.com>
    drm/amd/display: Limit DCN32 8 channel or less parts to DPM1 for FPO

Wayne Lin <Wayne.Lin@amd.com>
    drm/dp_mst: Clear MSG_RDY flag before sending new message

Brian Norris <briannorris@chromium.org>
    drm/rockchip: vop: Leave vblank enabled in self-refresh

Brian Norris <briannorris@chromium.org>
    drm/atomic: Allow vblank-enabled + self-refresh "disable"

Justin Tee <justin.tee@broadcom.com>
    scsi: lpfc: Fix double free in lpfc_cmpl_els_logo_acc() caused by lpfc_nlp_not_used()

Alexander Aring <aahringo@redhat.com>
    fs: dlm: fix missing pending to false

Alexander Aring <aahringo@redhat.com>
    fs: dlm: clear pending bit when queue was empty

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

Sinthu Raja <sinthu.raja@ti.com>
    arm64: dts: ti: k3-j721s2: Fix wkup pinmux range

Frank Wunderlich <frank-w@public-files.de>
    arm64: dts: mt7986: use size of reserved partition for bl2

Siddh Raman Pant <code@siddh.me>
    jfs: jfs_dmap: Validate db_l2nbperpage while mounting

Ritesh Harjani (IBM) <ritesh.list@gmail.com>
    ext2/dax: Fix ext2_setsize when len is page aligned

Christian Marangi <ansuelsmth@gmail.com>
    soc: qcom: mdt_loader: Fix unconditional call to scm_pas_mem_setup

David Woodhouse <dwmw@amazon.co.uk>
    mm/mmap: Fix error return in do_vmi_align_munmap()

Alexander Aring <aahringo@redhat.com>
    fs: dlm: revert check required context while close

Baokun Li <libaokun1@huawei.com>
    ext4: only update i_reserved_data_blocks on successful block allocation

Baokun Li <libaokun1@huawei.com>
    ext4: turn quotas off if mount failed after enabling quotas

Chao Yu <chao@kernel.org>
    ext4: fix to check return value of freeze_bdev() in ext4_shutdown()

Theodore Ts'o <tytso@mit.edu>
    ext4: avoid updating the superblock on a r/o mount if not needed

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
    MIPS: Loongson: Fix build error when make modules_install

Huacai Chen <chenhuacai@kernel.org>
    MIPS: Loongson: Fix cpu_probe_loongson() again

Jiaxun Yang <jiaxun.yang@flygoat.com>
    MIPS: cpu-features: Use boot_cpu_type for CPU type based features

Hamza Mahfooz <hamza.mahfooz@amd.com>
    drm/amd/display: perform a bounds check before filling dirty rectangles

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

Andrey Konovalov <andreyknvl@gmail.com>
    kasan: fix type cast in memory_is_poisoned_n

Andrey Konovalov <andreyknvl@gmail.com>
    kasan, slub: fix HW_TAGS zeroing with slub_debug

Arnd Bergmann <arnd@arndb.de>
    kasan: use internal prototypes matching gcc-13 builtins

Arnd Bergmann <arnd@arndb.de>
    kasan: add kasan_tag_mismatch prototype

Oleksij Rempel <linux@rempel-privat.de>
    net: phy: dp83td510: fix kernel stall during netboot in DP83TD510E PHY driver

Florian Fainelli <florian.fainelli@broadcom.com>
    net: bcmgenet: Ensure MDIO unregistration has clocks enabled

Arseniy Krasnov <AVKrasnov@sberdevices.ru>
    mtd: rawnand: meson: fix unaligned DMA buffers handling

Florian Bezdeka <florian@bezdeka.de>
    tpm/tpm_tis: Disable interrupts for Lenovo L590 devices

Lino Sanfilippo <l.sanfilippo@kunbus.com>
    tpm,tpm_tis: Disable interrupts after 1000 unhandled IRQs

Christian Hesse <mail@eworm.de>
    tpm/tpm_tis: Disable interrupts for Framework Laptop Intel 13th gen

Jerry Snitselaar <jsnitsel@redhat.com>
    tpm: return false from tpm_amd_is_rng_defective on non-x86 platforms

Alexander Sverdlin <alexander.sverdlin@siemens.com>
    tpm: tis_i2c: Limit write bursts to I2C_SMBUS_BLOCK_MAX (32) bytes

Christian Hesse <mail@eworm.de>
    tpm/tpm_tis: Disable interrupts for Framework Laptop Intel 12th gen

Alexander Sverdlin <alexander.sverdlin@siemens.com>
    tpm: tis_i2c: Limit read bursts to I2C_SMBUS_BLOCK_MAX (32) bytes

Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
    tpm: tpm_tis: Disable interrupts *only* for AEON UPX-i11

Jarkko Sakkinen <jarkko@kernel.org>
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

Masahiro Yamada <masahiroy@kernel.org>
    kbuild: make modules_install copy modules.builtin(.modinfo)

Jaegeuk Kim <jaegeuk@kernel.org>
    f2fs: fix deadlock in i_xattr_sem and inode page lock

Chao Yu <chao@kernel.org>
    f2fs: don't reset unchangable mount option in f2fs_remount()

Thomas Zimmermann <tzimmermann@suse.de>
    drm/client: Send hotplug event after registering a client

Paulo Alcantara <pc@manguebit.com>
    smb: client: fix parsing of source mount option

Winston Wen <wentao@uniontech.com>
    cifs: fix session state check in smb2_find_smb_ses

Paulo Alcantara <pc@manguebit.com>
    smb: client: improve DFS mount check

Ming Lei <ming.lei@redhat.com>
    nvme-pci: fix DMA direction of unmapping integrity data

Pedro Tammela <pctammela@mojatatu.com>
    net/sched: sch_qfq: account for stab overhead in qfq_enqueue

Pedro Tammela <pctammela@mojatatu.com>
    net/sched: sch_qfq: reintroduce lmax bound check for MTU

Zhang Shurong <zhang_shurong@foxmail.com>
    wifi: rtw89: debug: fix error code in rtw89_debug_priv_send_h2c_set()

Jiawen Wu <jiawenwu@trustnetic.com>
    net: txgbe: fix eeprom calculation error

Pedro Tammela <pctammela@mojatatu.com>
    net/sched: make psched_mtu() RTNL-less safe

Karol Herbst <kherbst@redhat.com>
    drm/nouveau: bring back blit subchannel for pre nv50 GPUs

Karol Herbst <kherbst@redhat.com>
    drm/nouveau/acr: Abort loading ACR if no firmware was found

Dan Carpenter <dan.carpenter@linaro.org>
    netdevsim: fix uninitialized data in nsim_dev_trap_fa_cookie_write()

Karol Herbst <kherbst@redhat.com>
    drm/nouveau/disp/g94: enable HDMI

Karol Herbst <kherbst@redhat.com>
    drm/nouveau/disp: fix HDMI on gt215+

Jisheng Zhang <jszhang@kernel.org>
    riscv: mm: fix truncation warning on RV32

Ido Schimmel <idosch@nvidia.com>
    net/sched: flower: Ensure both minimum and maximum ports are specified

Larysa Zaremba <larysa.zaremba@intel.com>
    xdp: use trusted arguments in XDP hints kfuncs

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

Lu Hongfei <luhongfei@vivo.com>
    net: dsa: Removed unneeded of_node_put in felix_parse_ports_node

Tvrtko Ursulin <tvrtko.ursulin@intel.com>
    drm/i915: Fix one wrong caching mode enum usage

Stanislav Lisovskiy <stanislav.lisovskiy@intel.com>
    drm/i915: Don't preserve dpll_hw_state for slave crtc in Bigjoiner

Wei Fang <wei.fang@nxp.com>
    net: fec: increase the size of tx ring and update tx_wake_threshold

Wei Fang <wei.fang@nxp.com>
    net: fec: recycle pages for transmitted XDP frames

Wei Fang <wei.fang@nxp.com>
    net: fec: remove last_bdp from fec_enet_txq_xmit_frame()

Wei Fang <wei.fang@nxp.com>
    net: fec: remove useless fec_enet_reset_skb()

Björn Töpel <bjorn@rivosinc.com>
    riscv, bpf: Fix inconsistent JIT image generation

Stafford Horne <shorne@gmail.com>
    openrisc: Union fpcsr and oldmask in sigcontext to unbreak userspace ABI

Ankit Kumar <ankit.kumar@samsung.com>
    nvme: fix the NVME_ID_NS_NVM_STS_MASK definition

Florian Kauer <florian.kauer@linutronix.de>
    igc: Fix inserting of empty frame for launchtime

Florian Kauer <florian.kauer@linutronix.de>
    igc: Fix launchtime before start of cycle

Florian Kauer <florian.kauer@linutronix.de>
    igc: No strict mode in pure launchtime/CBS offload

Ze Gao <zegao2021@gmail.com>
    fprobe: add unlock to match a succeeded ftrace_test_recursion_trylock

Tzvetomir Stoyanov (VMware) <tz.stoyanov@gmail.com>
    kernel/trace: Fix cleanup logic of enable_trace_eprobe

Florian Kauer <florian.kauer@linutronix.de>
    igc: Handle already enabled taprio offload for basetime 0

Florian Kauer <florian.kauer@linutronix.de>
    igc: Do not enable taprio offload for invalid arguments

Florian Kauer <florian.kauer@linutronix.de>
    igc: Rename qbv_enable to taprio_offload_enable

Vladimir Oltean <vladimir.oltean@nxp.com>
    net/sched: taprio: replace tc_taprio_qopt_offload :: enable with a "cmd" enum

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    platform/x86: wmi: Break possible infinite loop when parsing GUID

Peter Zijlstra <peterz@infradead.org>
    x86/fineibt: Poison ENDBR at +0

Jiasheng Jiang <jiasheng@iscas.ac.cn>
    net: dsa: qca8k: Add check for skb_copy

Arnd Bergmann <arnd@arndb.de>
    HID: hyperv: avoid struct memcpy overrun warning

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

Niklas Schnelle <schnelle@linux.ibm.com>
    s390/ism: Do not unregister clients with registered DMBs

Niklas Schnelle <schnelle@linux.ibm.com>
    s390/ism: Fix and simplify add()/remove() callback handling

Niklas Schnelle <schnelle@linux.ibm.com>
    s390/ism: Fix locking for forwarding of IRQs and events to clients

Paolo Abeni <pabeni@redhat.com>
    net: prevent skb corruption on frag list segmentation

Rafał Miłecki <rafal@milecki.pl>
    net: bgmac: postpone turning IRQs off to avoid SoC hangs

Ivan Babrou <ivan@cloudflare.com>
    udp6: add a missing call into udp_fail_queue_rcv_skb tracepoint

Nitya Sunkad <nitya.sunkad@amd.com>
    ionic: remove WARN_ON to prevent panic_on_warn

Sai Krishna <saikrishnag@marvell.com>
    octeontx2-af: Move validation of ptp pointer before its usage

Ratheesh Kannoth <rkannoth@marvell.com>
    octeontx2-af: Promisc enable/disable through mbox

Geert Uytterhoeven <geert+renesas@glider.be>
    drm/fbdev-dma: Fix documented default preferred_bpp value

Junfeng Guo <junfeng.guo@intel.com>
    gve: Set default duplex configuration to full

M A Ramdhan <ramdhan@starlabs.sg>
    net/sched: cls_fw: Fix improper refcount update leads to use-after-free

Vladimir Oltean <vladimir.oltean@nxp.com>
    net: mscc: ocelot: fix oversize frame dropping for preemptible TCs

Vladimir Oltean <vladimir.oltean@nxp.com>
    net: dsa: felix: make vsc9959_tas_guard_bands_update() visible to ocelot->ops

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

Tan Tee Min <tee.min.tan@linux.intel.com>
    igc: Include the length/type field and VLAN tag in queueMaxSDU

Prasad Koya <prasad@arista.com>
    igc: set TP bit in 'supported' and 'advertising' fields of ethtool_link_ksettings

Dragos Tatulea <dtatulea@nvidia.com>
    net/mlx5e: RX, Fix page_pool page fragment tracking for XDP

Maher Sanalla <msanalla@nvidia.com>
    net/mlx5: Query hca_cap_2 only when supported

Yevgeny Kliteynik <kliteyn@nvidia.com>
    net/mlx5e: TC, CT: Offload ct clear only once

Vlad Buslov <vladbu@nvidia.com>
    net/mlx5e: Check for NOT_READY flag state after locking

Saeed Mahameed <saeedm@nvidia.com>
    net/mlx5: Register a unique thermal zone per device

Dragos Tatulea <dtatulea@nvidia.com>
    net/mlx5e: RX, Fix flush and close release flow of regular rq for legacy rq

Zhengchao Shao <shaozhengchao@huawei.com>
    net/mlx5e: fix memory leak in mlx5e_ptp_open

Zhengchao Shao <shaozhengchao@huawei.com>
    net/mlx5e: fix memory leak in mlx5e_fs_tt_redirect_any_create

Zhengchao Shao <shaozhengchao@huawei.com>
    net/mlx5e: fix double free in mlx5e_destroy_flow_table

Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
    igc: Fix TX Hang issue when QBV Gate is closed

Jesper Dangaard Brouer <brouer@redhat.com>
    igc: Add XDP hints kfuncs for RX hash

Jesper Dangaard Brouer <brouer@redhat.com>
    igc: Add igc_xdp_buff wrapper for xdp_buff in driver

Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
    igc: Remove delay during TX ring configuration

Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
    igc: Add condition for qbv_config_change_errors counter

Sridhar Samudrala <sridhar.samudrala@intel.com>
    ice: Fix tx queue rate limit when TCs are configured

Sridhar Samudrala <sridhar.samudrala@intel.com>
    ice: Fix max_rate check while configuring TX rate limits

Florian Westphal <fw@strlen.de>
    netfilter: conntrack: don't fold port numbers into addresses before hashing

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: report use refcount overflow

Petr Pavlu <petr.pavlu@suse.com>
    xen/virtio: Fix NULL deref when a bridge of PCI root bus has no parent

Marek Vasut <marex@denx.de>
    drm/panel: simple: Add Powertip PH800480T013 drm_display_mode flags

Petr Tesarik <petr.tesarik.ext@huawei.com>
    swiotlb: reduce the number of areas to match actual memory pool size

Petr Tesarik <petr.tesarik.ext@huawei.com>
    swiotlb: always set the number of areas before allocating the pool

Douglas Anderson <dianders@chromium.org>
    drm/bridge: ti-sn65dsi86: Fix auxiliary bus lifetime

Adrián Larumbe <adrian.larumbe@collabora.com>
    drm: bridge: dw_hdmi: fix connector access for scdc

Fabio Estevam <festevam@denx.de>
    drm/panel: simple: Add connector_type for innolux_at043tn24

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: fix out of bounds read in smb2_sess_setup

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: add missing compound request handing in some commands

Simon Horman <horms@kernel.org>
    net: lan743x: select FIXED_PHY

Moritz Fischer <moritzf@google.com>
    net: lan743x: Don't sleep in atomic context

Basavaraj Natikar <Basavaraj.Natikar@amd.com>
    HID: amd_sfh: Fix for shift-out-of-bounds

Basavaraj Natikar <Basavaraj.Natikar@amd.com>
    HID: amd_sfh: Rename the float32 variable

Dmitry Torokhov <dmitry.torokhov@gmail.com>
    HID: input: fix mapping for camera access keys

Nayna Jain <nayna@linux.ibm.com>
    security/integrity: fix pointer to ESL data and its size on pseries

Ivan Mikhaylov <fr0st61te@gmail.com>
    net/ncsi: change from ndo_set_mac_address to dev_set_mac_address


-------------

Diffstat:

 Documentation/arm64/silicon-errata.rst             |   3 +
 .../media/v4l/vidioc-subdev-g-routing.rst          |   2 +-
 Makefile                                           |  30 ++-
 arch/arm64/Kconfig                                 |  19 ++
 .../dts/mediatek/mt7986a-bananapi-bpi-r3-nor.dtso  |   7 +-
 arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts   |  42 ++--
 .../boot/dts/ti/k3-j721s2-common-proc-board.dts    |  76 +++---
 arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi   |  29 ++-
 arch/arm64/kernel/cpu_errata.c                     |   7 +
 arch/arm64/kernel/traps.c                          |   2 +-
 arch/arm64/kvm/hyp/pgtable.c                       |  14 +-
 arch/arm64/mm/fault.c                              |   2 +-
 arch/arm64/tools/cpucaps                           |   1 +
 arch/mips/Makefile                                 |  10 +-
 arch/mips/include/asm/cpu-features.h               |   4 +-
 arch/mips/include/asm/kvm_host.h                   |   6 +-
 arch/mips/kernel/cpu-probe.c                       |   9 +-
 arch/mips/kvm/emulate.c                            |  22 +-
 arch/mips/kvm/mips.c                               |  16 +-
 arch/mips/kvm/stats.c                              |   4 +-
 arch/mips/kvm/trace.h                              |   8 +-
 arch/mips/kvm/vz.c                                 |  20 +-
 arch/openrisc/include/uapi/asm/sigcontext.h        |   6 +-
 arch/openrisc/kernel/signal.c                      |   4 +-
 arch/powerpc/Makefile                              |   8 +
 arch/powerpc/kernel/security.c                     |  37 +--
 arch/powerpc/mm/book3s64/hash_native.c             |  13 +-
 arch/riscv/mm/init.c                               |   2 +-
 arch/riscv/net/bpf_jit.h                           |   6 +-
 arch/riscv/net/bpf_jit_core.c                      |  19 +-
 arch/s390/Makefile                                 |   1 +
 arch/x86/events/intel/core.c                       |   7 +
 arch/x86/kernel/alternative.c                      |  16 ++
 arch/xtensa/platforms/iss/network.c                |   2 +-
 block/blk-crypto-profile.c                         |  12 +-
 drivers/accel/ivpu/ivpu_drv.h                      |   1 +
 drivers/accel/ivpu/ivpu_hw_mtl.c                   |  20 +-
 drivers/base/regmap/regmap-irq.c                   |   2 +-
 drivers/bus/intel-ixp4xx-eb.c                      |   2 +-
 drivers/char/hw_random/imx-rngc.c                  |   6 +-
 drivers/char/tpm/tpm-chip.c                        |   7 +
 drivers/char/tpm/tpm_crb.c                         |  19 +-
 drivers/char/tpm/tpm_tis.c                         |  25 ++
 drivers/char/tpm/tpm_tis_core.c                    | 103 ++++++--
 drivers/char/tpm/tpm_tis_core.h                    |   4 +
 drivers/char/tpm/tpm_tis_i2c.c                     |  59 +++--
 drivers/char/tpm/tpm_vtpm_proxy.c                  |  30 +--
 drivers/firmware/stratix10-svc.c                   |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c   |   3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c             |  12 +
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |  64 ++---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.h  |   2 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c  |  26 +++
 drivers/gpu/drm/amd/display/dc/core/dc.c           |   3 +
 .../drm/amd/display/dc/dce112/dce112_resource.c    |  10 +-
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c |  11 +
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c |   4 -
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.c  |   2 +-
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.h  |   1 +
 .../gpu/drm/amd/display/dc/dcn32/dcn32_resource.c  |   2 +
 .../gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c   |  15 ++
 .../gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.h   |   2 +
 .../dc/link/protocols/link_dp_irq_handler.c        |  11 +-
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h        |   2 +-
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h       |   4 +
 drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c  |   2 +-
 drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c    |   2 +-
 .../drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c    |   2 +-
 drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c |   2 +-
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c     |  67 ++++++
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c   |  35 +--
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c   |   2 +-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c   |  33 +--
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c          |   9 +-
 drivers/gpu/drm/bridge/ti-sn65dsi86.c              |  35 +--
 drivers/gpu/drm/display/drm_dp_mst_topology.c      |  54 ++++-
 drivers/gpu/drm/drm_atomic_helper.c                |  11 +-
 drivers/gpu/drm/drm_client.c                       |  21 ++
 drivers/gpu/drm/drm_fbdev_dma.c                    |   6 +-
 drivers/gpu/drm/drm_fbdev_generic.c                |   4 -
 drivers/gpu/drm/exynos/exynos_drm_fbdev.c          |   4 -
 drivers/gpu/drm/gma500/fbdev.c                     |   4 -
 drivers/gpu/drm/i915/display/intel_display.c       |   1 -
 drivers/gpu/drm/i915/display/intel_dp.c            |   7 +-
 drivers/gpu/drm/i915/gt/intel_gtt.c                |   2 +-
 drivers/gpu/drm/msm/msm_fbdev.c                    |   4 -
 drivers/gpu/drm/nouveau/dispnv50/disp.c            |  12 +-
 drivers/gpu/drm/nouveau/nouveau_chan.c             |   1 +
 drivers/gpu/drm/nouveau/nouveau_chan.h             |   1 +
 drivers/gpu/drm/nouveau/nouveau_drm.c              |  20 +-
 drivers/gpu/drm/nouveau/nvkm/engine/disp/g94.c     |   1 +
 drivers/gpu/drm/nouveau/nvkm/engine/disp/gt215.c   |   2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/acr/base.c     |   2 +-
 drivers/gpu/drm/omapdrm/omap_fbdev.c               |   4 -
 drivers/gpu/drm/panel/panel-simple.c               |   2 +
 drivers/gpu/drm/radeon/radeon_fbdev.c              |   4 -
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c        |   8 +-
 drivers/gpu/drm/tegra/fbdev.c                      |   4 -
 drivers/gpu/drm/ttm/ttm_bo.c                       |  29 ++-
 drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_desc.c      |  30 ++-
 drivers/hid/hid-hyperv.c                           |  10 +-
 drivers/hid/hid-input.c                            |   7 +-
 drivers/iio/adc/meson_saradc.c                     |   2 +-
 drivers/md/dm-integrity.c                          |   4 +-
 drivers/md/dm-verity-loadpin.c                     |   3 +
 drivers/md/raid0.c                                 |  62 ++++-
 drivers/md/raid0.h                                 |   1 +
 drivers/mfd/qcom-pm8008.c                          |   1 +
 drivers/misc/fastrpc.c                             |   2 +-
 drivers/misc/pci_endpoint_test.c                   |  10 +-
 drivers/mtd/nand/raw/meson_nand.c                  |   4 +
 drivers/net/dsa/hirschmann/hellcreek.c             |  14 +-
 drivers/net/dsa/ocelot/felix.c                     |   6 +-
 drivers/net/dsa/ocelot/felix.h                     |   1 -
 drivers/net/dsa/ocelot/felix_vsc9959.c             |  28 ++-
 drivers/net/dsa/qca/qca8k-8xxx.c                   |   3 +
 drivers/net/dsa/sja1105/sja1105_tas.c              |   7 +-
 drivers/net/ethernet/amazon/ena/ena_com.c          |   3 +
 drivers/net/ethernet/broadcom/bgmac.c              |   4 +-
 drivers/net/ethernet/broadcom/genet/bcmmii.c       |   2 +
 drivers/net/ethernet/engleder/tsnep_selftests.c    |  12 +-
 drivers/net/ethernet/engleder/tsnep_tc.c           |   4 +-
 drivers/net/ethernet/freescale/enetc/enetc_qos.c   |   6 +-
 drivers/net/ethernet/freescale/fec.h               |  17 +-
 drivers/net/ethernet/freescale/fec_main.c          | 178 ++++++++------
 drivers/net/ethernet/google/gve/gve_ethtool.c      |   3 +
 drivers/net/ethernet/intel/ice/ice_main.c          |  23 +-
 drivers/net/ethernet/intel/ice/ice_tc_lib.c        |  22 +-
 drivers/net/ethernet/intel/ice/ice_tc_lib.h        |   1 +
 drivers/net/ethernet/intel/igc/igc.h               |  15 +-
 drivers/net/ethernet/intel/igc/igc_ethtool.c       |   2 +
 drivers/net/ethernet/intel/igc/igc_main.c          | 158 ++++++++++---
 drivers/net/ethernet/intel/igc/igc_ptp.c           |  25 +-
 drivers/net/ethernet/intel/igc/igc_tsn.c           |  68 ++++--
 drivers/net/ethernet/marvell/mvneta.c              |   4 +-
 drivers/net/ethernet/marvell/octeontx2/af/ptp.c    |  19 +-
 drivers/net/ethernet/marvell/octeontx2/af/rvu.c    |   2 +-
 .../net/ethernet/marvell/octeontx2/af/rvu_nix.c    |  11 +-
 .../ethernet/marvell/octeontx2/af/rvu_npc_hash.c   |  23 +-
 .../ethernet/marvell/octeontx2/nic/otx2_flows.c    |   8 +
 .../net/ethernet/marvell/octeontx2/nic/otx2_tc.c   |  15 ++
 .../mellanox/mlx5/core/en/fs_tt_redirect.c         |   6 +-
 drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c   |   6 +-
 drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c |  14 +-
 drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.h |   1 +
 drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c   |   3 +-
 .../ethernet/mellanox/mlx5/core/en_accel/fs_tcp.c  |   1 +
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c    |  44 ++--
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c    |   6 +-
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.c  |   3 +
 drivers/net/ethernet/mellanox/mlx5/core/thermal.c  |  19 +-
 drivers/net/ethernet/microchip/Kconfig             |   2 +-
 drivers/net/ethernet/microchip/lan743x_main.c      |  21 +-
 .../net/ethernet/microchip/lan966x/lan966x_tc.c    |  10 +-
 drivers/net/ethernet/mscc/ocelot_mm.c              |   7 +-
 .../net/ethernet/netronome/nfp/nfp_net_common.c    |   5 +
 drivers/net/ethernet/pensando/ionic/ionic_lif.c    |   5 -
 drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c    |   7 +-
 drivers/net/ethernet/ti/am65-cpsw-qos.c            |  11 +-
 drivers/net/ethernet/wangxun/txgbe/txgbe_hw.c      |   3 -
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
 drivers/pinctrl/pinctrl-amd.c                      | 103 +++-----
 drivers/pinctrl/pinctrl-amd.h                      |   2 +-
 drivers/platform/x86/wmi.c                         |  22 +-
 drivers/pwm/pwm-meson.c                            |  28 +--
 drivers/s390/crypto/zcrypt_msgtype6.c              |   6 +
 drivers/s390/net/ism_drv.c                         | 139 ++++++-----
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
 drivers/tty/n_tty.c                                |  25 +-
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
 drivers/xen/grant-dma-ops.c                        |   2 +
 fs/ceph/addr.c                                     |  85 +++++--
 fs/ceph/caps.c                                     |   9 +
 fs/ceph/super.h                                    |  13 ++
 fs/dlm/ast.c                                       |   8 +-
 fs/dlm/lockspace.c                                 |  12 -
 fs/dlm/lockspace.h                                 |   1 -
 fs/dlm/lowcomms.c                                  |   1 +
 fs/dlm/midcomms.c                                  |   3 -
 fs/dlm/plock.c                                     | 115 +++++----
 fs/erofs/inode.c                                   |   3 +-
 fs/erofs/zdata.c                                   |   4 +-
 fs/ext2/inode.c                                    |   5 +-
 fs/ext4/indirect.c                                 |   8 +
 fs/ext4/inode.c                                    |  10 -
 fs/ext4/ioctl.c                                    |   5 +-
 fs/ext4/mballoc.c                                  |  17 +-
 fs/ext4/super.c                                    |  31 ++-
 fs/f2fs/dir.c                                      |   9 +-
 fs/f2fs/super.c                                    |  30 ++-
 fs/f2fs/xattr.c                                    |   6 +-
 fs/jfs/jfs_dmap.c                                  |   6 +
 fs/jfs/jfs_filsys.h                                |   2 +
 fs/smb/client/cifs_dfs_ref.c                       |  20 +-
 fs/smb/client/cifsproto.h                          |   2 +
 fs/smb/client/cifssmb.c                            |   2 +-
 fs/smb/client/dfs.c                                |  43 +---
 fs/smb/client/file.c                               |   4 +-
 fs/smb/client/fs_context.c                         |  59 ++++-
 fs/smb/client/misc.c                               |  17 +-
 fs/smb/client/smb2transport.c                      |   7 +
 fs/smb/server/smb2pdu.c                            | 109 +++++----
 include/drm/display/drm_dp_mst_helper.h            |   7 +-
 include/linux/blk-crypto-profile.h                 |   1 +
 include/linux/ism.h                                |   7 +-
 include/linux/kasan.h                              |   2 +-
 include/linux/nvme.h                               |   2 +-
 include/linux/rethook.h                            |   1 +
 include/linux/serial_8250.h                        |   1 -
 include/net/netfilter/nf_conntrack_tuple.h         |   3 +
 include/net/netfilter/nf_tables.h                  |  31 ++-
 include/net/pkt_sched.h                            |   9 +-
 include/soc/mscc/ocelot.h                          |   1 +
 kernel/bpf/cpumap.c                                |  40 ++--
 kernel/bpf/verifier.c                              |   5 +-
 kernel/dma/swiotlb.c                               |  46 +++-
 kernel/power/qos.c                                 |   9 +-
 kernel/trace/fprobe.c                              |  15 +-
 kernel/trace/ftrace.c                              |  45 ++--
 kernel/trace/rethook.c                             |  13 ++
 kernel/trace/ring_buffer.c                         |  24 +-
 kernel/trace/trace.c                               |   3 +-
 kernel/trace/trace.h                               |   2 +
 kernel/trace/trace_eprobe.c                        |  18 +-
 kernel/trace/trace_events_hist.c                   |   8 +-
 kernel/trace/trace_events_user.c                   |   6 +-
 kernel/trace/trace_probe.c                         |   2 +-
 kernel/trace/trace_probe_kernel.h                  |  30 +--
 kernel/trace/trace_probe_tmpl.h                    |  10 +-
 kernel/trace/trace_uprobe.c                        |   3 +-
 mm/kasan/common.c                                  |   2 +-
 mm/kasan/generic.c                                 |  73 +++---
 mm/kasan/kasan.h                                   | 171 +++++++-------
 mm/kasan/report.c                                  |  17 +-
 mm/kasan/report_generic.c                          |  12 +-
 mm/kasan/report_hw_tags.c                          |   2 +-
 mm/kasan/report_sw_tags.c                          |   2 +-
 mm/kasan/shadow.c                                  |  36 +--
 mm/kasan/sw_tags.c                                 |  20 +-
 mm/mmap.c                                          |   9 +-
 mm/slab.h                                          |  16 +-
 net/ceph/messenger_v2.c                            |  41 ++--
 net/core/net-traces.c                              |   2 +
 net/core/skbuff.c                                  |   5 +
 net/core/xdp.c                                     |   2 +-
 net/ipv6/addrconf.c                                |   3 +-
 net/ipv6/icmp.c                                    |   5 +-
 net/ipv6/udp.c                                     |   4 +-
 net/mptcp/protocol.c                               |   7 +-
 net/ncsi/ncsi-rsp.c                                |   5 +-
 net/netfilter/nf_conntrack_core.c                  |  20 +-
 net/netfilter/nf_tables_api.c                      | 163 ++++++++-----
 net/netfilter/nft_flow_offload.c                   |   6 +-
 net/netfilter/nft_immediate.c                      |   8 +-
 net/netfilter/nft_objref.c                         |   8 +-
 net/sched/cls_flower.c                             |  10 +
 net/sched/cls_fw.c                                 |  10 +-
 net/sched/sch_qfq.c                                |  18 +-
 net/sched/sch_taprio.c                             |   4 +-
 samples/ftrace/ftrace-direct-too.c                 |  14 +-
 security/integrity/platform_certs/load_powerpc.c   |  40 ++--
 tools/testing/selftests/net/mptcp/config           |   1 +
 tools/testing/selftests/net/mptcp/mptcp_connect.sh |   3 +
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh |  29 +--
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c      |  10 +-
 tools/testing/selftests/net/mptcp/userspace_pm.sh  |   4 +-
 312 files changed, 3504 insertions(+), 1921 deletions(-)


