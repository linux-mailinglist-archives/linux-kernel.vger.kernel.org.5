Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1D0579B010
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350002AbjIKVf1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238251AbjIKNw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 09:52:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8B44FA;
        Mon, 11 Sep 2023 06:52:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79CC9C433C7;
        Mon, 11 Sep 2023 13:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694440337;
        bh=QUH4bkHVQTvBADjIG8L8K1CaxBtzkD1noZGP82fqW+s=;
        h=From:To:Cc:Subject:Date:From;
        b=D0P77ZnAtNEwR64tgeRVudiGVEFC06p/skbpSNAS6Vg5jcUnPzySHizLhP9Tyc9QV
         AacY/E2q4Kki9gqXRw60oZdM3OF9FBH0Js0cEc0DnQ93P6+mc7cEDiDlqdiL7izLzE
         nLm/VMcHDq7yyiWKm0luBhA1zIqP7GirzXe353Cw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: [PATCH 6.5 000/739] 6.5.3-rc1 review
Date:   Mon, 11 Sep 2023 15:36:39 +0200
Message-ID: <20230911134650.921299741@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.5.3-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.5.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.5.3-rc1
X-KernelTest-Deadline: 2023-09-13T13:47+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 6.5.3 release.
There are 739 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Wed, 13 Sep 2023 13:44:56 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.5.3-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.5.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 6.5.3-rc1

Lorenz Bauer <lmb@isovalent.com>
    net: remove duplicate INDIRECT_CALLABLE_DECLARE of udp[6]_ehashfn

Andrew Morton <akpm@linux-foundation.org>
    revert "memfd: improve userspace warnings for missing exec-related flags".

Aleksa Sarai <cyphar@cyphar.com>
    memfd: improve userspace warnings for missing exec-related flags

Aleksa Sarai <cyphar@cyphar.com>
    memfd: replace ratcheting feature from vm.memfd_noexec with hierarchy

Aleksa Sarai <cyphar@cyphar.com>
    memfd: do not -EACCES old memfd_create() users with vm.memfd_noexec=2

Jeff Xu <jeffxu@google.com>
    selftests/memfd: sysctl: fix MEMFD_NOEXEC_SCOPE_NOEXEC_ENFORCED

Jeff Xu <jeffxu@google.com>
    mm/memfd: sysctl: fix MEMFD_NOEXEC_SCOPE_NOEXEC_ENFORCED

Hugo Villeneuve <hvilleneuve@dimonoff.com>
    serial: sc16is7xx: fix regression with GPIO configuration

Hugo Villeneuve <hvilleneuve@dimonoff.com>
    serial: sc16is7xx: remove obsolete out_thread label

Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
    Bluetooth: HCI: Introduce HCI_QUIRK_BROKEN_LE_CODED

Hilda Wu <hildawu@realtek.com>
    Bluetooth: msft: Extended monitor tracking by address filter

Arnd Bergmann <arnd@kernel.org>
    media: ipu3-cio2: allow ipu_bridge to be a module again

Kan Liang <kan.liang@linux.intel.com>
    perf/x86/uncore: Correct the number of CHAs on EMR

Song Liu <song@kernel.org>
    x86/build: Fix linker fill bytes quirk/incompatibility for ld.lld

Jack Wang <jinpu.wang@ionos.com>
    x86/sgx: Break up long non-preemptible delays in sgx_vepc_release()

Thomas Gleixner <tglx@linutronix.de>
    x86/smp: Don't send INIT to non-present and non-booted CPUs

Alan Stern <stern@rowland.harvard.edu>
    USB: core: Fix oversight in SuperSpeed initialization

Douglas Anderson <dianders@chromium.org>
    of: property: fw_devlink: Add a devlink for panel followers

Gustavo A. R. Silva <gustavoars@kernel.org>
    cpufreq: brcmstb-avs-cpufreq: Fix -Warray-bounds bug

Thomas Bourgoin <thomas.bourgoin@foss.st.com>
    crypto: stm32 - fix MDMAT condition

Thomas Bourgoin <thomas.bourgoin@foss.st.com>
    crypto: stm32 - fix loop iterating through scatterlist for DMA

Benjamin Tissoires <benjamin.tissoires@redhat.com>
    HID: logitech-hidpp: rework one more time the retries attempts

Heiko Carstens <hca@linux.ibm.com>
    s390/dasd: fix string length handling

Sven Schnelle <svens@linux.ibm.com>
    s390/ipl: add missing secure/has_secure file to ipl type 'unknown'

Gerald Schaefer <gerald.schaefer@linux.ibm.com>
    s390/dcssblk: fix kernel crash with list_add corruption

Andy Chiu <andy.chiu@sifive.com>
    RISC-V: Add ptrace support for vectors

David Howells <dhowells@redhat.com>
    iov_iter: Fix iov_iter_extract_pages() with zero-sized entries

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    regulator: dt-bindings: qcom,rpm: fix pattern for children

D Scott Phillips <scott@os.amperecomputing.com>
    arm64: sdei: abort running SDEI handlers during crash

Enlin Mu <enlin.mu@unisoc.com>
    pstore/ram: Check start of empty przs during init

Wolfram Sang <wsa+renesas@sang-engineering.com>
    mmc: renesas_sdhi: register irqs before registering controller

Tzung-Bi Shih <tzungbi@kernel.org>
    platform/chrome: chromeos_acpi: print hex string for ACPI_TYPE_BUFFER

Frederick Lawler <fred@cloudflare.com>
    crypto: af_alg - Decrement struct key.usage in alg_set_by_key_serial()

Yazen Ghannam <yazen.ghannam@amd.com>
    x86/MCE: Always save CS register on AMD Zen IF Poison errors

Eric Biggers <ebiggers@google.com>
    fsverity: skip PKCS#7 parser when keyring is empty

Nicolas Dichtel <nicolas.dichtel@6wind.com>
    net: handle ARPHRD_PPP in dev_is_mac_header_xmit()

Thore Sommer <public@thson.de>
    X.509: if signature is unsupported skip validation

Heiner Kallweit <hkallweit1@gmail.com>
    r8169: fix ASPM-related issues on a number of systems with NIC version from RTL8168h

Steve Rutherford <srutherford@google.com>
    x86/sev: Make enc_dec_hypercall() accept a size instead of npages

Jann Horn <jannh@google.com>
    dccp: Fix out of bounds access in DCCP error handler

Alexander Aring <aahringo@redhat.com>
    dlm: fix plock lookup when using multiple lockspaces

Yafang Shao <laoar.shao@gmail.com>
    bpf: Fix issue in verifying allow_ptr_leaks

Fudong Wang <fudong.wang@amd.com>
    drm/amd/display: Add smu write msg id fail retry process

Ekansh Gupta <quic_ekangupt@quicinc.com>
    misc: fastrpc: Pass proper scm arguments for static process init

Helge Deller <deller@gmx.de>
    parisc: Fix /proc/cpuinfo output for lscpu

Aleksa Sarai <cyphar@cyphar.com>
    procfs: block chmod on /proc/thread-self/comm

Li Lingfeng <lilingfeng3@huawei.com>
    block: don't add or resize partition on the disk with GENHD_FL_NO_PART

Christoph Hellwig <hch@lst.de>
    block: fix pin count management when merging same-page segments

Bjorn Helgaas <bhelgaas@google.com>
    Revert "PCI: Mark NVIDIA T4 GPUs to avoid bus reset"

Dave Jiang <dave.jiang@intel.com>
    ntb: Fix calculation ntb_transport_tx_free_entry()

Dave Jiang <dave.jiang@intel.com>
    ntb: Clean up tx tail index on link down

Dave Jiang <dave.jiang@intel.com>
    ntb: Drop packets when qp link is down

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    dt-bindings: PCI: qcom: Fix SDX65 compatible

Feiyang Chen <chenfeiyang@loongson.cn>
    PCI/PM: Only read PCI_PM_CTRL register when available

Dexuan Cui <decui@microsoft.com>
    PCI: hv: Fix a crash in hv_pci_restore_msi_msg() during hibernation

Ross Lagerwall <ross.lagerwall@citrix.com>
    PCI: Free released resource after coalescing

Ranjan Kumar <ranjan.kumar@broadcom.com>
    scsi: mpt3sas: Perform additional retries if doorbell read returns 0

Nilesh Javali <njavali@marvell.com>
    Revert "scsi: qla2xxx: Fix buffer overrun"

Yang Yingliang <yangyingliang@huawei.com>
    media: nxp: Fix wrong return pointer check in mxc_isi_crossbar_init()

Konrad Dybcio <konrad.dybcio@linaro.org>
    media: venus: hfi_venus: Write to VIDC_CTRL_INIT after unmasking interrupts

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    media: dvb: symbol fixup for dvb_attach()

Ding Xiang <dingxiang@cmss.chinamobile.com>
    selftests/landlock: Fix a resource leak

Vitaly Rodionov <vitalyr@opensource.cirrus.com>
    ALSA: hda/cirrus: Fix broken audio on hardware with two CS42L42 codecs.

Takashi Iwai <tiwai@suse.de>
    ALSA: seq: Fix snd_seq_expand_var_event() call to user-space

Takashi Iwai <tiwai@suse.de>
    ALSA: usb-audio: Fix potential memory leaks at error path for UMP open

Will Deacon <will@kernel.org>
    arm64: csum: Fix OoB access in IP checksum code for negative lengths

Gabriel Krisman Bertazi <krisman@suse.de>
    io_uring: Don't set affinity on a dying sqpoll thread

Frank Li <Frank.Li@nxp.com>
    i3c: master: svc: fix probe failure when no i3c device exist

Naveen N Rao <naveen@kernel.org>
    powerpc/ftrace: Fix dropping weak symbols with older toolchains

Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
    powercap: intel_rapl: Fix invalid setting of Power Limit 4

Hongchen Zhang <zhanghongchen@loongson.cn>
    LoongArch: mm: Add p?d_leaf() definitions

Max Filippov <jcmvbkbc@gmail.com>
    xtensa: PMU: fix base address for the newer hardware

Hamza Mahfooz <hamza.mahfooz@amd.com>
    drm/amd/display: register edp_backlight_control() for DCN301

Thomas Zimmermann <tzimmermann@suse.de>
    backlight/lv5207lp: Compare against struct fb_info.device

Thomas Zimmermann <tzimmermann@suse.de>
    backlight/bd6107: Compare against struct fb_info.device

Thomas Zimmermann <tzimmermann@suse.de>
    backlight/gpio_backlight: Compare against struct fb_info.device

Pavel Begunkov <asml.silence@gmail.com>
    io_uring: break out of iowq iopoll on teardown

Pavel Begunkov <asml.silence@gmail.com>
    io_uring/net: don't overflow multishot accept

Pavel Begunkov <asml.silence@gmail.com>
    io_uring/net: don't overflow multishot recv

Jens Axboe <axboe@kernel.dk>
    io_uring/sqpoll: fix io-wq affinity when IORING_SETUP_SQPOLL is used

Pavel Begunkov <asml.silence@gmail.com>
    io_uring: break iopolling on signal

Pavel Begunkov <asml.silence@gmail.com>
    io_uring: fix false positive KASAN warnings

Matthew Wilcox (Oracle) <willy@infradead.org>
    XArray: Do not return sibling entries from xa_load()

Alexandre Ghiti <alexghiti@rivosinc.com>
    riscv: Mark KASAN tmp* page tables variables as static

Alexandre Ghiti <alexghiti@rivosinc.com>
    riscv: Move create_tmp_mapping() to init sections

Gustavo A. R. Silva <gustavoars@kernel.org>
    ARM: OMAP2+: Fix -Warray-bounds warning in _pwrdm_state_switch()

Yi Yang <yiyang13@huawei.com>
    ipmi_si: fix a memleak in try_smi_init()

Rick Wertenbroek <rick.wertenbroek@gmail.com>
    PCI: rockchip: Use 64-bit mask on MSI 64-bit PCI address

Sakari Ailus <sakari.ailus@linux.intel.com>
    media: i2c: Add a camera sensor top level menu

Sakari Ailus <sakari.ailus@linux.intel.com>
    media: i2c: ccs: Check rules is non-NULL

Thomas Gleixner <tglx@linutronix.de>
    cpu/hotplug: Prevent self deadlock on CPU hot-unplug

Joel Fernandes (Google) <joel@joelfernandes.org>
    mm/vmalloc: add a safer version of find_vm_area() for debug

Bart Van Assche <bvanassche@acm.org>
    scsi: core: Fix the scsi_set_resid() documentation

Kees Cook <keescook@chromium.org>
    printk: ringbuffer: Fix truncating buffer size min_t cast

Zqiang <qiang.zhang1211@gmail.com>
    rcu: dump vmalloc memory info safely

Hou Tao <houtao1@huawei.com>
    virtio_pmem: add the missing REQ_OP_WRITE for flush bio

Takashi Iwai <tiwai@suse.de>
    ALSA: pcm: Fix missing fixup call in compat hw_refine ioctl

Kalesh Singh <kaleshsingh@google.com>
    Multi-gen LRU: fix per-zone reclaim

Boris Brezillon <boris.brezillon@collabora.com>
    PM / devfreq: Fix leak in devfreq_dev_release()

Helge Deller <deller@gmx.de>
    parisc: ccio-dma: Create private runway procfs root entry

Radoslaw Tyl <radoslawx.tyl@intel.com>
    igb: set max size RX buffer when store bad packet is enabled

Daniel Mack <daniel@zonque.org>
    gpio: zynq: restore zynq_gpio_irq_reqres/zynq_gpio_irq_relres callbacks

Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
    drbd: swap bvec_set_page len and offset

Mohamed Khalfella <mkhalfella@purestorage.com>
    skbuff: skb_segment, Call zero copy functions before using skbuff frags

Wander Lairson Costa <wander@redhat.com>
    netfilter: xt_sctp: validate the flag_info count

Wander Lairson Costa <wander@redhat.com>
    netfilter: xt_u32: validate user space input

Xiao Liang <shaw.leon@gmail.com>
    netfilter: nft_exthdr: Fix non-linear header modification

Kyle Zeng <zengyhkyle@gmail.com>
    netfilter: ipset: add the missing IP_SET_HASH_WITH_NET0 macro for ip_set_hash_netportnet.c

Eric Dumazet <edumazet@google.com>
    igmp: limit igmpv3_newpack() packet size to IP_MAX_MTU

Eric Dumazet <edumazet@google.com>
    net: deal with integer overflows in kmalloc_reserve()

Yuan Yao <yuanyaogoog@chromium.org>
    virtio_ring: fix avail_wrap_counter in virtqueue_add_packed

Jason Wang <jasowang@redhat.com>
    virtio_vdpa: build affinity masks conditionally

Liao Chang <liaochang1@huawei.com>
    cpufreq: Fix the race condition while updating the transition_task of policy

Vincent Whitchurch <vincent.whitchurch@axis.com>
    um: virt-pci: fix missing declaration warning

Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
    Drivers: hv: vmbus: Don't dereference ACPI root object handle

Arnd Bergmann <arnd@arndb.de>
    remoteproc: stm32: fix incorrect optional pointers

Fenghua Yu <fenghua.yu@intel.com>
    dmaengine: idxd: Fix issues with PRS disable sysfs knob

Fenghua Yu <fenghua.yu@intel.com>
    dmaengine: idxd: Allow ATS disable update only for configurable devices

Fenghua Yu <fenghua.yu@intel.com>
    dmaengine: idxd: Expose ATS disable knob only when WQ ATS is supported

Fenghua Yu <fenghua.yu@intel.com>
    dmaengine: idxd: Simplify WQ attribute visibility checks

ruanjinjie <ruanjinjie@huawei.com>
    dmaengine: ste_dma40: Add missing IRQ check in d40_probe

Randy Dunlap <rdunlap@infradead.org>
    um: Fix hostaudio build errors

Arnd Bergmann <arnd@arndb.de>
    mfd: rz-mtu3: Link time dependencies

Geert Uytterhoeven <geert+renesas@glider.be>
    mfd: rk808: Make MFD_RK8XX tristate

Yi Yang <yiyang13@huawei.com>
    mtd: rawnand: fsmc: handle clk prepare error in fsmc_nand_resume()

Hsin-Yi Wang <hsinyi@chromium.org>
    mtd: spi-nor: Check bus width while setting QE bit

Marek Behún <kabel@kernel.org>
    leds: trigger: tty: Do not use LED_ON/OFF constants, use led_blink_set_oneshot instead

Marek Behún <kabel@kernel.org>
    leds: Fix BUG_ON check for LED_COLOR_ID_MULTI that is always false

Marek Behún <kabel@kernel.org>
    leds: multicolor: Use rounded division when calculating color components

Ahmad Fatoum <a.fatoum@pengutronix.de>
    thermal/drivers/imx8mm: Suppress log message on probe deferral

Nícolas F. R. A. Prado <nfraprado@collabora.com>
    thermal/drivers/mediatek/lvts_thermal: Manage threshold between sensors

Nícolas F. R. A. Prado <nfraprado@collabora.com>
    thermal/drivers/mediatek/lvts_thermal: Don't leave threshold zeroed

Nícolas F. R. A. Prado <nfraprado@collabora.com>
    thermal/drivers/mediatek/lvts_thermal: Disable undesired interrupts

Nícolas F. R. A. Prado <nfraprado@collabora.com>
    thermal/drivers/mediatek/lvts_thermal: Use offset threshold for IRQ

Nícolas F. R. A. Prado <nfraprado@collabora.com>
    thermal/drivers/mediatek/lvts_thermal: Honor sensors in immediate mode

Nícolas F. R. A. Prado <nfraprado@collabora.com>
    thermal/drivers/mediatek/lvts_thermal: Handle IRQ on all controllers

Dan Carpenter <dan.carpenter@linaro.org>
    leds: pwm: Fix error code in led_pwm_create_fwnode()

Arnd Bergmann <arnd@arndb.de>
    leds: simatic-ipc-leds-gpio: Restore LEDS_CLASS dependency

Dan Carpenter <dan.carpenter@linaro.org>
    leds: aw200xx: Fix error code in probe()

Jiasheng Jiang <jiasheng@iscas.ac.cn>
    rpmsg: glink: Add check for kstrdup

Jonas Karlman <jonas@kwiboo.se>
    phy/rockchip: inno-hdmi: do not power on rk3328 post pll on reg write

Zheng Yang <zhengyang@rock-chips.com>
    phy/rockchip: inno-hdmi: round fractal pixclock in rk3328 recalc_rate

Jonas Karlman <jonas@kwiboo.se>
    phy/rockchip: inno-hdmi: use correct vco_div_5 macro on rk3328

Rex Zhang <rex.zhang@intel.com>
    dmaengine: idxd: Modify the dependence of attribute pasid_enabled

William Zhang <william.zhang@broadcom.com>
    mtd: rawnand: brcmnand: Fix mtd oobsize

Hugh Dickins <hughd@google.com>
    mm/pagewalk: fix bootstopping regression from extra pte_unmap()

Zheng Yejian <zhengyejian1@huawei.com>
    tracing: Fix race issue between cpu buffer write and swap

Mikhail Kobuk <m.kobuk@ispras.ru>
    tracing: Remove extra space at the end of hwlat_detector/mode

Dave Hansen <dave.hansen@linux.intel.com>
    x86/speculation: Mark all Skylake CPUs as vulnerable to GDS

Paul Gortmaker <paul.gortmaker@windriver.com>
    tick/rcu: Fix false positive "softirq work is pending" messages

Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
    workqueue: fix data race with the pwq->stats[] increment

Mario Limonciello <mario.limonciello@amd.com>
    platform/x86/amd/pmf: Fix a missing cleanup path

Rahul Rameshbabu <rrameshbabu@nvidia.com>
    HID: nvidia-shield: Reference hid_device devm allocation of input_dev name

Rahul Rameshbabu <sergeantsagara@protonmail.com>
    HID: multitouch: Correct devm device reference for hidinput input_dev name

Rahul Rameshbabu <sergeantsagara@protonmail.com>
    HID: uclogic: Correct devm device reference for hidinput input_dev name

Chao Yu <chao@kernel.org>
    f2fs: compress: fix to assign compress_level for lz4 correctly

Björn Töpel <bjorn@rivosinc.com>
    riscv: Require FRAME_POINTER for some configurations

Miquel Raynal <miquel.raynal@bootlin.com>
    nvmem: core: Return NULL when no nvmem layout is found

Nikita Zhandarovich <n.zhandarovich@fintech.ru>
    HID: logitech-dj: Fix error handling in logi_dj_recv_switch_to_dj_mode()

Yonatan Nachum <ynachum@amazon.com>
    RDMA/efa: Fix wrong resources deallocation order

Guoqing Jiang <guoqing.jiang@linux.dev>
    RDMA/siw: Correct wrong debug message

Guoqing Jiang <guoqing.jiang@linux.dev>
    RDMA/siw: Balance the reference of cep->kref in the error path

Leon Romanovsky <leon@kernel.org>
    Revert "IB/isert: Fix incorrect release of isert connection"

Peng Fan <peng.fan@nxp.com>
    amba: bus: fix refcount leak

Christophe Leroy <christophe.leroy@csgroup.eu>
    Documentation: devices.txt: Fix minors for ttyCPM*

Christophe Leroy <christophe.leroy@csgroup.eu>
    Documentation: devices.txt: Remove ttySIOC*

Christophe Leroy <christophe.leroy@csgroup.eu>
    Documentation: devices.txt: Remove ttyIOC*

Yi Yang <yiyang13@huawei.com>
    serial: tegra: handle clk prepare error in tegra_uart_hw_init()

Sam Protsenko <semen.protsenko@linaro.org>
    dt-bindings: usb: samsung,exynos-dwc3: Fix Exynos5433 compatible

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    dt-bindings: usb: samsung,exynos-dwc3: fix order of clocks on Exynos5433

Konrad Dybcio <konrad.dybcio@linaro.org>
    interconnect: qcom: bcm-voter: Use enable_maks for keepalive voting

Konrad Dybcio <konrad.dybcio@linaro.org>
    interconnect: qcom: bcm-voter: Improve enable_mask handling

Konrad Dybcio <konrad.dybcio@linaro.org>
    interconnect: qcom: sm8450: Enable sync_state

Chengfeng Ye <dg573847474@gmail.com>
    scsi: fcoe: Fix potential deadlock on &fip->ctlr_lock

Tony Battersby <tonyb@cybernetics.com>
    scsi: core: Use 32-bit hostnum in scsi_host_lookup()

Christopher Bednarz <christopher.n.bednarz@intel.com>
    RDMA/irdma: Prevent zero-length STAG registration

Chao Yu <chao@kernel.org>
    Revert "f2fs: do not issue small discard commands during checkpoint"

Junhao He <hejunhao3@huawei.com>
    coresight: trbe: Fix TRBE potential sleep in atomic context

Junhao He <hejunhao3@huawei.com>
    coresight: Fix memory leak in acpi_buffer->pointer

Suzuki K Poulose <suzuki.poulose@arm.com>
    coresight: platform: acpi: Ignore the absence of graph

Suzuki K Poulose <suzuki.poulose@arm.com>
    coresight: trbe: Allocate platform data per device

Lu Jialin <lujialin4@huawei.com>
    cgroup:namespace: Remove unused cgroup_namespaces_init()

Chao Yu <chao@kernel.org>
    f2fs: fix to account cp stats correctly

Chao Yu <chao@kernel.org>
    f2fs: fix to account gc stats correctly

Chao Yu <chao@kernel.org>
    Revert "f2fs: fix to do sanity check on extent cache correctly"

Chunhai Guo <guochunhai@vivo.com>
    f2fs: Only lfs mode is allowed with zoned block device feature

Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
    f2fs: check zone type before sending async reset zone command

Christoph Hellwig <hch@lst.de>
    f2fs: don't reopen the main block device in f2fs_scan_devices

Chao Yu <chao@kernel.org>
    f2fs: fix to avoid mmap vs set_compress_option case

Randy Dunlap <rdunlap@infradead.org>
    f2fs: fix spelling in ABI documentation

Jacopo Mondi <jacopo.mondi@ideasonboard.com>
    media: i2c: rdacm21: Fix uninitialized value

Hans de Goede <hdegoede@redhat.com>
    media: ov2680: Fix regulators being left enabled on ov2680_power_on() errors

Hans de Goede <hdegoede@redhat.com>
    media: ov2680: Fix ov2680_set_fmt() which == V4L2_SUBDEV_FORMAT_TRY not working

Hans de Goede <hdegoede@redhat.com>
    media: ov2680: Add ov2680_fill_format() helper function

Hans de Goede <hdegoede@redhat.com>
    media: ov2680: Don't take the lock for try_fmt calls

Hans de Goede <hdegoede@redhat.com>
    media: ov2680: Remove VIDEO_V4L2_SUBDEV_API ifdef-s

Hans de Goede <hdegoede@redhat.com>
    media: ov2680: Fix vflip / hflip set functions

Hans de Goede <hdegoede@redhat.com>
    media: ov2680: Fix ov2680_bayer_order()

Hans de Goede <hdegoede@redhat.com>
    media: ov2680: Remove auto-gain and auto-exposure controls

Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
    media: Documentation: Fix [GS]_ROUTING documentation

Marek Vasut <marex@denx.de>
    media: ov5640: Fix initial RESETB state and annotate timings

Marek Vasut <marex@denx.de>
    media: ov5640: Enable MIPI interface in ov5640_set_power_mipi()

Rahul Rameshbabu <rrameshbabu@nvidia.com>
    HID: nvidia-shield: Remove led_classdev_unregister in thunderstrike_create

Illia Ostapyshyn <ostapyshyn@sra.uni-hannover.de>
    HID: input: Support devices sending Eraser without Invert

David Gow <davidgow@google.com>
    drivers: base: Free devm resources when unregistering a device

Alan Stern <stern@rowland.harvard.edu>
    USB: gadget: f_mass_storage: Fix unused variable warning

Alan Stern <stern@rowland.harvard.edu>
    USB: gadget: core: Add missing kerneldoc for vbus_work

Randy Dunlap <rdunlap@infradead.org>
    docs: ABI: fix spelling/grammar in SBEFIFO timeout interface

Hans de Goede <hdegoede@redhat.com>
    media: ipu-bridge: Do not use on stack memory for software_node.name field

Bingbu Cao <bingbu.cao@intel.com>
    media: ipu3-cio2: rename cio2 bridge to ipu bridge and move out of ipu3

Hans de Goede <hdegoede@redhat.com>
    media: ipu-bridge: Fix null pointer deref on SSDB/PLD parsing warnings

Laurent Pinchart <laurent.pinchart@ideasonboard.com>
    arm64: defconfig: Drop CONFIG_VIDEO_IMX_MEDIA

Konrad Dybcio <konrad.dybcio@linaro.org>
    media: venus: hfi_venus: Only consider sys_idle_indicator on V1

Colin Ian King <colin.i.king@gmail.com>
    media: go7007: Remove redundant if statement

Hans Verkuil <hverkuil-cisco@xs4all.nl>
    media: cec: core: add adap_unconfigured() callback

Hans Verkuil <hverkuil-cisco@xs4all.nl>
    media: cec: core: add adap_nb_transmit_canceled() callback

Armin Wolf <W_Armin@gmx.de>
    platform/x86: dell-sysman: Fix reference leak

Yanfei Xu <yanfei.xu@intel.com>
    iommu/vt-d: Fix to flush cache of PASID directory table

Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
    tty: serial: qcom-geni-serial: Poll primary sequencer irq status after cancel_tx

AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
    iommu/qcom: Disable and reset context bank before programming

Eddie James <eajames@linux.ibm.com>
    fsi: aspeed: Reset master errors after CFAM reset

Xiang Yang <xiangyang3@huawei.com>
    IB/uverbs: Fix an potential error pointer dereference

Chengchang Tang <tangchengchang@huawei.com>
    RDMA/hns: Fix CQ and QP cache affinity

Junxian Huang <huangjunxian6@hisilicon.com>
    RDMA/hns: Fix inaccurate error label name in init instance

Junxian Huang <huangjunxian6@hisilicon.com>
    RDMA/hns: Fix incorrect post-send with direct wqe of wr-list

Chengchang Tang <tangchengchang@huawei.com>
    RDMA/hns: Fix port active speed

Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
    RDMA/bnxt_re: Remove a redundant flag

Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
    RDMA/bnxt_re: Fix max_qp count for virtual functions

Chandramohan Akula <chandramohan.akula@broadcom.com>
    RDMA/bnxt_re: Initialize Doorbell pacing feature

Chandramohan Akula <chandramohan.akula@broadcom.com>
    bnxt_en: Share the bar0 address with the RoCE driver

Chandramohan Akula <chandramohan.akula@broadcom.com>
    bnxt_en: Update HW interface headers

Zhu Wang <wangzhu9@huawei.com>
    iommu: Remove kernel-doc warnings

Jason Gunthorpe <jgg@ziepe.ca>
    iommu/sprd: Add missing force_aperture

Chengci.Xu <chengci.xu@mediatek.com>
    iommu/mediatek: Fix two IOMMU share pagetable issue

Arnd Bergmann <arnd@arndb.de>
    extcon: cht_wc: add POWER_SUPPLY dependency

Arnd Bergmann <arnd@arndb.de>
    kernfs: add stub helper for kernfs_generic_poll()

Jason Gunthorpe <jgg@ziepe.ca>
    driver core: Call dma_cleanup() on the test_remove path

Dan Carpenter <dan.carpenter@linaro.org>
    driver core: test_async: fix an error code

Rob Clark <robdclark@chromium.org>
    dma-buf/sync_file: Fix docs syntax

Konrad Dybcio <konrad.dybcio@linaro.org>
    interconnect: qcom: qcm2290: Enable sync state

Ruidong Tian <tianruidong@linux.alibaba.com>
    coresight: tmc: Explicit type conversions to prevent integer overflow

Gustavo A. R. Silva <gustavoars@kernel.org>
    RDMA/irdma: Replace one-element array with flexible-array member

Oleksandr Natalenko <oleksandr@natalenko.name>
    scsi: qedf: Do not touch __user pointer in qedf_dbg_fp_int_cmd_read() directly

Oleksandr Natalenko <oleksandr@natalenko.name>
    scsi: qedf: Do not touch __user pointer in qedf_dbg_debug_cmd_read() directly

Oleksandr Natalenko <oleksandr@natalenko.name>
    scsi: qedf: Do not touch __user pointer in qedf_dbg_stop_io_on_error_cmd_read() directly

Bob Pearson <rpearsonhpe@gmail.com>
    RDMA/rxe: Fix incomplete state save in rxe_requester

Bob Pearson <rpearsonhpe@gmail.com>
    RDMA/rxe: Fix rxe_modify_srq

Bob Pearson <rpearsonhpe@gmail.com>
    RDMA/rxe: Fix unsafe drain work queue code

Bob Pearson <rpearsonhpe@gmail.com>
    RDMA/rxe: Move work queue code to subroutines

Randy Dunlap <rdunlap@infradead.org>
    x86/APM: drop the duplicate APM_MINOR_DEV macro

Chunyan Zhang <chunyan.zhang@unisoc.com>
    serial: sprd: Fix DMA buffer leak issue

Chunyan Zhang <chunyan.zhang@unisoc.com>
    serial: sprd: Assign sprd_port after initialized to avoid wrong access

Biju Das <biju.das.jz@bp.renesas.com>
    iio: accel: adxl313: Fix adxl313_i2c_id[] table

Lin Ma <linma@zju.edu.cn>
    scsi: qla4xxx: Add length check when parsing nlattrs

Lin Ma <linma@zju.edu.cn>
    scsi: be2iscsi: Add length check when parsing nlattrs

Lin Ma <linma@zju.edu.cn>
    scsi: iscsi: Add strlen() check in iscsi_if_set{_host}_param()

Lin Ma <linma@zju.edu.cn>
    scsi: iscsi: Add length check for nlattr payload

Bart Van Assche <bvanassche@acm.org>
    scsi: ufs: Fix residual handling

Bart Van Assche <bvanassche@acm.org>
    scsi: RDMA/srp: Fix residual handling

Xu Yang <xu.yang_2@nxp.com>
    usb: phy: mxs: fix getting wrong state with mxs_phy_is_otg_host()

Dan Carpenter <dan.carpenter@linaro.org>
    media: mediatek: vcodec: fix resource leaks in vdec_msg_queue_init()

Dan Carpenter <dan.carpenter@linaro.org>
    media: mediatek: vcodec: fix potential double free

Irui Wang <irui.wang@mediatek.com>
    media: mediatek: vcodec: Return NULL if no vdec_fb is found

Xiaoyong Lu <xiaoyong.lu@mediatek.com>
    media: mediatek: vcodec: fix AV1 decode fail for 36bit iova

Ming Qian <ming.qian@nxp.com>
    media: amphion: ensure the bitops don't cross boundaries

Ming Qian <ming.qian@nxp.com>
    media: amphion: fix UNUSED_VALUE issue reported by coverity

Ming Qian <ming.qian@nxp.com>
    media: amphion: fix UNINIT issues reported by coverity

Ming Qian <ming.qian@nxp.com>
    media: amphion: fix REVERSE_INULL issues reported by coverity

Ming Qian <ming.qian@nxp.com>
    media: amphion: fix CHECKED_RETURN issues reported by coverity

Benjamin Gaignard <benjamin.gaignard@collabora.com>
    media: rkvdec: increase max supported height for H.264

Ming Qian <ming.qian@nxp.com>
    media: amphion: decoder support display delay for all formats

Zheng Wang <zyytlz.wz@163.com>
    media: mtk-jpeg: Fix use after free bug due to uncanceled work

Michael Tretter <m.tretter@pengutronix.de>
    media: verisilicon: Fix TRY_FMT on encoder OUTPUT

Ming Qian <ming.qian@nxp.com>
    media: amphion: add helper function to get id name

Ming Qian <ming.qian@nxp.com>
    media: amphion: reinit vpu if reqbufs output 0

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    dt-bindings: extcon: maxim,max77843: restrict connector properties

Xingui Yang <yangxingui@huawei.com>
    scsi: hisi_sas: Fix normally completed I/O analysed as failed

Chuck Lever <chuck.lever@oracle.com>
    RDMA/siw: Fabricate a GID on tun and loopback devices

Daniil Dulov <d.dulov@aladdin.ru>
    media: cx24120: Add retval check for cx24120_message_send()

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    media: dvb-usb: m920x: Fix a potential memory leak in m920x_i2c_xfer()

Daniil Dulov <d.dulov@aladdin.ru>
    media: dib7000p: Fix potential division by zero

Dongliang Mu <dzm91@hust.edu.cn>
    drivers: usb: smsusb: fix error handling code in smsusb_init_device

Jonas Karlman <jonas@kwiboo.se>
    iommu: rockchip: Fix directory table address encoding

Daniel Marcovitch <dmarcovitch@nvidia.com>
    iommu/amd/iommu_v2: Fix pasid_state refcount dec hit 0 warning on pasid unbind

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    media: v4l2-core: Fix a potential resource leak in v4l2_fwnode_parse_link()

Claudiu Beznea <claudiu.beznea@microchip.com>
    media: i2c: tvp5150: check return value of devm_kasprintf()

Hans de Goede <hdegoede@redhat.com>
    media: ad5820: Drop unsupported ad5823 from i2c_ and of_device_id tables

Tommaso Merciai <tomm.merciai@gmail.com>
    media: i2c: imx290: drop format param from imx290_ctrl_update

Guoniu.zhou <guoniu.zhou@nxp.com>
    media: ov5640: fix low resolution image abnormal issue

Minjie Du <duminjie@vivo.com>
    RDMA/qedr: Remove a duplicate assignment in irdma_query_ah()

Waiman Long <longman@redhat.com>
    cgroup/cpuset: Inherit parent's load balance state in v2

Anna Schumaker <Anna.Schumaker@Netapp.com>
    pNFS: Fix assignment of xprtdata.cred

Olga Kornievskaia <kolga@netapp.com>
    NFSv4.2: fix handling of COPY ERR_OFFLOAD_NO_REQ

Benjamin Coddington <bcodding@redhat.com>
    NFS: Guard against READDIR loop when entry names exceed MAXNAMELEN

Nathan Chancellor <nathan@kernel.org>
    clk: qcom: Fix SM_GPUCC_8450 dependencies

Chuck Lever <chuck.lever@oracle.com>
    NFSD: da_addr_body field missing in some GETDEVICEINFO replies

Su Hui <suhui@nfschina.com>
    fs: lockd: avoid possible wrong NULL parameter

Chuck Lever <chuck.lever@oracle.com>
    SUNRPC: Fix the recent bv_offset fix

Alexei Filippov <halip0503@gmail.com>
    jfs: validate max amount of blocks before allocation.

Zhihao Cheng <chengzhihao1@huawei.com>
    ext4: fix unttached inode after power cut with orphan file feature enabled

Russell Currey <ruscur@russell.cc>
    powerpc/iommu: Fix notifiers being shared by PCI and VIO buses

Liang He <windhl@126.com>
    powerpc/mpc5xxx: Add missing fwnode_handle_put()

Nicholas Piggin <npiggin@gmail.com>
    powerpc/pseries: Fix hcall tracepoints with JUMP_LABEL=n

Dan Carpenter <dan.carpenter@linaro.org>
    nfs/blocklayout: Use the passed in gfp flags

Russell Currey <ruscur@russell.cc>
    powerpc/pseries: Rework lppaca_shared_proc() to avoid DEBUG_PREEMPT

Michael Ellerman <mpe@ellerman.id.au>
    powerpc: Don't include lppaca.h in paca.h

Xiaowei Bao <xiaowei.bao@nxp.com>
    PCI: layerscape: Add workaround for lost link capabilities during reset

Anna Schumaker <Anna.Schumaker@Netapp.com>
    NFSv4.2: Rework scratch handling for READ_PLUS (again)

Anna Schumaker <Anna.Schumaker@Netapp.com>
    NFSv4.2: Fix READ_PLUS size calculations

Anna Schumaker <Anna.Schumaker@Netapp.com>
    NFSv4.2: Fix READ_PLUS smatch warnings

Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
    wifi: ath10k: Use RMW accessors for changing LNKCTL

Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
    wifi: ath12k: Use RMW accessors for changing LNKCTL

Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
    wifi: ath11k: Use RMW accessors for changing LNKCTL

Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
    net/mlx5: Use RMW accessors for changing LNKCTL

Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
    drm/radeon: Use RMW accessors for changing LNKCTL

Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
    drm/amdgpu: Use RMW accessors for changing LNKCTL

Daniel Golle <daniel@makrotopia.org>
    pinctrl: mediatek: assign functions to configure pin bias on MT7986

Daniel Golle <daniel@makrotopia.org>
    pinctrl: mediatek: fix pull_type data for MT7981

Christophe Leroy <christophe.leroy@csgroup.eu>
    powerpc/perf: Convert fsl_emb notifier to state machine callbacks

Sourabh Jain <sourabhjain@linux.ibm.com>
    powerpc/fadump: reset dump area size if fadump memory reserve fails

Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
    nvdimm: Fix dereference after free in register_nvdimm_pmu()

Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
    nvdimm: Fix memleak of pmu attr_groups in unregister_nvdimm_pmu()

Stefan Hajnoczi <stefanha@redhat.com>
    vfio/type1: fix cap_migration information leak

Christophe Leroy <christophe.leroy@csgroup.eu>
    powerpc/radix: Move some functions into #ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE

Ahmad Fatoum <a.fatoum@pengutronix.de>
    clk: imx: composite-8m: fix clock pauses when set_rate would be a no-op

Marco Felsch <m.felsch@pengutronix.de>
    clk: imx8mp: fix sai4 clock

Peng Fan <peng.fan@nxp.com>
    clk: imx: imx8ulp: update SPLL2 type

Ye Li <ye.li@nxp.com>
    clk: imx: pllv4: Fix SPLL2 MULT range

Imran Shaik <quic_imrashai@quicinc.com>
    clk: qcom: gcc-qdu1000: Fix clkref clocks handling

Imran Shaik <quic_imrashai@quicinc.com>
    clk: qcom: gcc-qdu1000: Fix gcc_pcie_0_pipe_clk_src clock handling

Konrad Dybcio <konrad.dybcio@linaro.org>
    clk: qcom: gcc-sm8450: Use floor ops for SDCC RCGs

Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
    PCI/ASPM: Use RMW accessors for changing LNKCTL

Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
    PCI: pciehp: Use RMW accessors for changing LNKCTL

Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
    PCI: Make link retraining use RMW accessors for changing LNKCTL

Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
    PCI: Add locking to RMW PCI Express Capability Register accessors

Claudiu Beznea <claudiu.beznea@microchip.com>
    pinctrl: mcp23s08: check return value of devm_kasprintf()

Wu Zongyong <wuzongyong@linux.alibaba.com>
    PCI: Mark NVIDIA T4 GPUs to avoid bus reset

Daire McNamara <daire.mcnamara@microchip.com>
    PCI: microchip: Correct the DED and SEC interrupt bit offsets

Luca Weiss <luca.weiss@fairphone.com>
    clk: qcom: gcc-sm6350: Fix gcc_sdcc2_apps_clk_src

Konrad Dybcio <konrad.dybcio@linaro.org>
    clk: qcom: reset: Use the correct type of sleep/delay based on length

Dmitry Torokhov <dmitry.torokhov@gmail.com>
    kvm/vfio: ensure kvg instance stays around in kvm_vfio_group_add()

Yi Liu <yi.l.liu@intel.com>
    kvm/vfio: Prepare for accepting vfio device fd

Arnd Bergmann <arnd@arndb.de>
    clk: qcom: fix some Kconfig corner cases

Patrick Whewell <patrick.whewell@sightlineapplications.com>
    clk: qcom: gcc-sm8250: Fix gcc_sdcc2_apps_clk_src

Kemeng Shi <shikemeng@huaweicloud.com>
    ext4: avoid potential data overflow in next_linear_group

Kemeng Shi <shikemeng@huaweicloud.com>
    ext4: correct grp validation in ext4_mb_good_group

Qiuxu Zhuo <qiuxu.zhuo@intel.com>
    EDAC/igen6: Fix the issue of no error events

David Wronek <davidwronek@gmail.com>
    clk: qcom: gcc-sc7180: Fix up gcc_sdcc2_apps_clk_src

Zhang Jianhua <chris.zjh@huawei.com>
    clk: sunxi-ng: Modify mismatched function name

Konrad Dybcio <konrad.dybcio@linaro.org>
    clk: qcom: dispcc-sc8280xp: Use ret registers on GDSCs

Ira Weiny <ira.weiny@intel.com>
    PCI/DOE: Fix destroy_work_on_stack() race

Jason Gunthorpe <jgg@ziepe.ca>
    iommufd: Fix locking around hwpt allocation

Qiuxu Zhuo <qiuxu.zhuo@intel.com>
    EDAC/i10nm: Skip the absent memory controllers

Minjie Du <duminjie@vivo.com>
    drivers: clk: keystone: Fix parameter judgment in _of_pll_clk_init()

Johan Hovold <johan+linaro@kernel.org>
    clk: qcom: gcc-sc8280xp: fix runtime PM imbalance on probe errors

Manivannan Sadhasivam <mani@kernel.org>
    PCI: qcom-ep: Switch MHI bus master clock off during L1SS

Sven Peter <sven@svenpeter.dev>
    PCI: apple: Initialize pcie->nvecs before use

Alibek Omarov <a1ba.omarov@gmail.com>
    clk: rockchip: rk3568: Fix PLL rate setting for 78.75MHz

Danila Tikhonov <danila@jiaxyga.com>
    clk: qcom: gcc-sm7150: Add CLK_OPS_PARENT_ENABLE to sdcc2 rcg

Konrad Dybcio <konrad.dybcio@linaro.org>
    clk: qcom: gcc-sc8280xp: Add missing GDSCs

Konrad Dybcio <konrad.dybcio@linaro.org>
    dt-bindings: clock: qcom,gcc-sc8280xp: Add missing GDSCs

Konrad Dybcio <konrad.dybcio@linaro.org>
    clk: qcom: gcc-sc8280xp: Add missing GDSC flags

Konrad Dybcio <konrad.dybcio@linaro.org>
    clk: qcom: gpucc-sm6350: Fix clock source names

Konrad Dybcio <konrad.dybcio@linaro.org>
    clk: qcom: gpucc-sm6350: Introduce index-based clk lookup

Corey Minyard <minyard@acm.org>
    ipmi:ssif: Fix a memory leak when scanning for an adapter

Jiasheng Jiang <jiasheng@iscas.ac.cn>
    ipmi:ssif: Add check for kstrdup

Takashi Iwai <tiwai@suse.de>
    ALSA: ump: Fix -Wformat-truncation warnings

Takashi Iwai <tiwai@suse.de>
    ALSA: ump: Don't create unused substreams for static blocks

Takashi Iwai <tiwai@suse.de>
    ALSA: ump: Fill group names for legacy rawmidi substreams

Takashi Iwai <tiwai@suse.de>
    ALSA: usb-audio: Attach legacy rawmidi after probing all UMP EPs

Su Hui <suhui@nfschina.com>
    ALSA: ac97: Fix possible error value of *rac97

Geert Uytterhoeven <geert+renesas@glider.be>
    of: unittest: Fix overlay type in apply/revert check

Geert Uytterhoeven <geert+renesas@glider.be>
    of: overlay: Call of_changeset_init() early

Vijendar Mukunda <Vijendar.Mukunda@amd.com>
    ASoC: SOF: amd: clear dsp to host interrupt status

Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
    ASoC: fsl: merge DAI call back functions into ops

Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
    ASoC: soc-dai.h: merge DAI call back functions into ops

Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
    ASoC: pxa: merge DAI call back functions into ops

David Jeffery <djeffery@redhat.com>
    md: raid0: account for split bio in iostat accounting

Jan Kara <jack@suse.cz>
    md/raid0: Fix performance regression for large sequential writes

Jan Kara <jack@suse.cz>
    md/raid0: Factor out helper for mapping and submitting a bio

Xueshi Hu <xueshi.hu@smartx.com>
    md/raid1: hold the barrier until handle_read_error() finishes

Xueshi Hu <xueshi.hu@smartx.com>
    md/raid1: free the r1bio before waiting for blocked rdev

Tejun Heo <tj@kernel.org>
    blk-cgroup: Fix NULL deref caused by blkg_policy_data being installed before init

Vlad Karpovich <vkarpovi@opensource.cirrus.com>
    firmware: cs_dsp: Fix new control name check

Yu Kuai <yukuai3@huawei.com>
    md/raid5-cache: fix null-ptr-deref for r5l_flush_stripe_to_raid()

Yu Kuai <yukuai3@huawei.com>
    md/raid5-cache: fix a deadlock in r5l_exit_log()

Damien Le Moal <dlemoal@kernel.org>
    block: uapi: Fix compilation errors using ioprio.h with C++

Tony Lindgren <tony@atomide.com>
    bus: ti-sysc: Fix cast to enum warning

Rob Clark <robdclark@chromium.org>
    drm/msm/a690: Switch to a660_gmu.bin

Konrad Dybcio <konrad.dybcio@linaro.org>
    arm64: dts: qcom: sc8280xp-x13s: Unreserve NC pins

David Wronek <davidwronek@gmail.com>
    arm64: dts: qcom: msm8996: Fix dsi1 interrupts

Rohit Agarwal <quic_rohiagar@quicinc.com>
    ARM: dts: qcom: sdx65-mtp: Update the pmic used in sdx65

Konrad Dybcio <konrad.dybcio@linaro.org>
    arm64: dts: qcom: msm8998: Add missing power domain to MMSS SMMU

Konrad Dybcio <konrad.dybcio@linaro.org>
    arm64: dts: qcom: msm8998: Drop bus clock reference from MMSS SMMU

Bryan O'Donoghue <bryan.odonoghue@linaro.org>
    arm64: dts: qcom: apq8016-sbc: Rename ov5640 enable-gpios to powerdown-gpios

Bryan O'Donoghue <bryan.odonoghue@linaro.org>
    arm64: dts: qcom: apq8016-sbc: Fix ov5640 regulator supply names

Jason-JH.Lin <jason-jh.lin@mediatek.com>
    drm/mediatek: Fix void-pointer-to-enum-cast warning

Sui Jingfeng <suijingfeng@loongson.cn>
    drm/mediatek: Fix potential memory leak if vmap() fail

Aradhya Bhatia <a-bhatia1@ti.com>
    arm64: dts: ti: k3-am62x-sk-common: Update main-i2c1 frequency

Robert Marko <robert.marko@sartura.hr>
    ARM: dts: qcom: ipq4019: correct SDHCI XO clock

Marco Felsch <m.felsch@pengutronix.de>
    arm64: dts: imx8mp-debix: remove unused fec pinctrl node

Jason-JH.Lin <jason-jh.lin@mediatek.com>
    drm/mediatek: Add cnt checking for coverity issue

Jason-JH.Lin <jason-jh.lin@mediatek.com>
    drm/mediatek: Remove freeing not dynamic allocated memory

Tony Lindgren <tony@atomide.com>
    bus: ti-sysc: Fix build warning for 64-bit build

Apelete Seketeli <aseketeli@baylibre.com>
    arm64: dts: ti: k3-j784s4: Fix interrupt ranges for wkup & main gpio

Udit Kumar <u-kumar1@ti.com>
    arm64: dts: ti: k3-j784s4-evm: Correct Pin mux offset for ADC

AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
    drm/mediatek: dp: Add missing error checks in mtk_dp_parse_capabilities

Jinyoung Choi <j-young.choi@samsung.com>
    bio-integrity: create multi-page bvecs in bio_integrity_add_page()

Jinyoung Choi <j-young.choi@samsung.com>
    block: make bvec_try_merge_hw_page() non-static

Christoph Hellwig <hch@lst.de>
    block: don't pass a bio to bio_try_merge_hw_seg

Christoph Hellwig <hch@lst.de>
    block: move the bi_size update out of __bio_try_merge_page

Christoph Hellwig <hch@lst.de>
    block: move the bi_size overflow check in __bio_try_merge_page

Christoph Hellwig <hch@lst.de>
    block: move the bi_vcnt check out of __bio_try_merge_page

Christoph Hellwig <hch@lst.de>
    block: move the BIO_CLONED checks out of __bio_try_merge_page

Pavel Begunkov <asml.silence@gmail.com>
    io_uring: fix drain stalls by invalid SQE

Zhiguo Niu <zhiguo.niu@unisoc.com>
    block/mq-deadline: use correct way to throttling write requests

Gaosheng Cui <cuigaosheng1@huawei.com>
    audit: fix possible soft lockup in __audit_inode_child()

Nancy.Lin <nancy.lin@mediatek.com>
    drm/mediatek: Fix uninitialized symbol

Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
    ASoC: SOF: Intel: fix u16/32 confusion in LSDIID

Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
    ASoC: SOF: Intel: hda-mlink: fix off-by-one error

Rob Clark <robdclark@chromium.org>
    drm/msm/a6xx: Fix GMU lockdep splat

Fabio Estevam <festevam@denx.de>
    drm/msm/a2xx: Call adreno_gpu_init() earlier

Yang Wang <kevinyang.wang@amd.com>
    drm/amd/pm: fix variable dereferenced issue in amdgpu_device_attr_create()

Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
    drm/amdgpu: Move vram, gtt & flash defines to amdgpu_ ttm & _psp.h

Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
    drm/amdgpu: Sort the includes in amdgpu/amdgpu_drv.c

Dan Carpenter <dan.carpenter@linaro.org>
    smackfs: Prevent underflow in smk_set_cipso()

Udit Kumar <u-kumar1@ti.com>
    arm64: dts: ti: k3-j721s2: correct pinmux offset for ospi

Udit Kumar <u-kumar1@ti.com>
    arm64: dts: ti: k3-j784s4-evm: Correct Pin mux offset for ospi

Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
    drm/msm/dpu: fix the irq index in dpu_encoder_phys_wb_wait_for_commit_done

Zhang Shurong <zhang_shurong@foxmail.com>
    firmware: meson_sm: fix to avoid potential NULL pointer dereference

Daniel Vetter <daniel.vetter@ffwll.ch>
    drm/msm/mdp5: Don't leak some plane state

Chen Jiahao <chenjiahao16@huawei.com>
    soc: qcom: smem: Fix incompatible types in comparison

Abel Vesa <abel.vesa@linaro.org>
    arm64: dts: qcom: sm8550-mtp: Add missing supply for L1B regulator

Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
    drm/msm/dpu: fix DSC 1.2 enc subblock length

Ryan McCann <quic_rmccann@quicinc.com>
    drm/msm/dpu: Define names for unnamed sblks

Konrad Dybcio <konrad.dybcio@linaro.org>
    drm/msm/dpu1: Rename sm8150_dspp_blk to sdm845_dspp_blk

Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
    drm/msm/dpu: fix DSC 1.2 block lengths

Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
    drm/msm/dpu: inline DSC_BLK and DSC_BLK_1_2 macros

Jonathan Marek <jonathan@marek.ca>
    drm/msm/dpu: increase memtype count to 16 for sm8550

Jiasheng Jiang <jiasheng@iscas.ac.cn>
    drm: xlnx: zynqmp_dpsub: Add missing check for dma_set_mask

Nayna Jain <nayna@linux.ibm.com>
    ima: Remove deprecated IMA_TRUSTED_KEYRING Kconfig

Marek Vasut <marex@denx.de>
    drm/panel: simple: Add missing connector type and pixel format for AUO T215HVN01

Geert Uytterhoeven <geert@linux-m68k.org>
    drm/repaper: Reduce temporary buffer size in repaper_fb_dirty()

Geert Uytterhoeven <geert+renesas@glider.be>
    drm/armada: Fix off-by-one error in armada_overlay_get_property()

Rafał Miłecki <rafal@milecki.pl>
    ARM: dts: BCM53573: Fix Tenda AC9 switch CPU port

Jocelyn Falempe <jfalempe@redhat.com>
    drm/ast: report connection status on Display Port.

Zeyan Li <qaz6750@outlook.com>
    arm64: dts: qcom: sm8150: Fix the I2C7 interrupt

Ruan Jinjie <ruanjinjie@huawei.com>
    of: unittest: fix null pointer dereferencing in of_unittest_find_node_by_name()

Yangtao Li <frank.li@vivo.com>
    drm/tegra: dpaux: Fix incorrect return value of platform_get_irq

Ryan McCann <quic_rmccann@quicinc.com>
    drm/msm: Update dev core dump to not print backwards

Yu Kuai <yukuai3@huawei.com>
    md/md-bitmap: hold 'reconfig_mutex' in backlog_store()

Yu Kuai <yukuai3@huawei.com>
    md/md-bitmap: remove unnecessary local variable in backlog_store()

Li Nan <linan122@huawei.com>
    md/raid10: use dereference_rdev_and_rrdev() to get devices

Li Nan <linan122@huawei.com>
    md/raid10: factor out dereference_rdev_and_rrdev()

Yu Kuai <yukuai3@huawei.com>
    md: restore 'noio_flag' for the last mddev_resume()

Herve Codina <herve.codina@bootlin.com>
    ASoC: fsl: fsl_qmc_audio: Fix snd_pcm_format_t values handling

YingKun Meng <mengyingkun@loongson.cn>
    ASoC: loongson: drop of_match_ptr for OF device id

Jonas Karlman <jonas@kwiboo.se>
    arm64: dts: rockchip: Enable SATA on Radxa E25

Jonas Karlman <jonas@kwiboo.se>
    arm64: dts: rockchip: Fix PCIe regulators on Radxa E25

Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
    drm/amdgpu: Use seq_puts() instead of seq_printf()

Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
    drm/amdgpu: Update min() to min_t() in 'amdgpu_info_ioctl'

Konrad Dybcio <konrad.dybcio@linaro.org>
    dt-bindings: arm: msm: kpss-acc: Make the optional reg truly optional

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    arm64: dts: qcom: sc8180x-pmics: align LPG node name with dtschema

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    arm64: dts: qcom: sc8180x-pmics: align SPMI PMIC Power-on node name with dtschema

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    arm64: dts: qcom: sc8180x-pmics: add missing gpio-ranges

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    arm64: dts: qcom: sc8180x-pmics: add missing qcom,spmi-gpio fallbacks

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    arm64: dts: qcom: msm8996-gemini: fix touchscreen VIO supply

Bjorn Andersson <quic_bjorande@quicinc.com>
    arm64: dts: qcom: sc8180x: Fix LLCC reg property

Manivannan Sadhasivam <mani@kernel.org>
    arm64: dts: qcom: sdm845: Fix the min frequency of "ice_core_clk"

Manivannan Sadhasivam <mani@kernel.org>
    arm64: dts: qcom: sdm845: Add missing RPMh power domain to GCC

Rafał Miłecki <rafal@milecki.pl>
    ARM: dts: BCM53573: Fix Ethernet info for Luxul devices

Bogdan Togorean <bogdan.togorean@analog.com>
    drm: adv7511: Fix low refresh rate register for ADV7533/5

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    ARM: dts: samsung: s5pv210-smdkv210: correct ethernet reg addresses (split)

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    ARM: dts: samsung: s3c6410-mini6410: correct ethernet reg addresses (split)

Chen-Yu Tsai <wenst@chromium.org>
    drm/bridge: anx7625: Use common macros for HDCP capabilities

Chen-Yu Tsai <wenst@chromium.org>
    drm/bridge: anx7625: Use common macros for DP power sequencing commands

Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
    x86/mm: Fix PAT bit missing from page protection modify mask

Chengming Zhou <zhouchengming@bytedance.com>
    blk-flush: fix rq->flush.seq for post-flush requests

Christoph Hellwig <hch@lst.de>
    block: don't allow enabling a cache on devices that don't support it

Christoph Hellwig <hch@lst.de>
    block: cleanup queue_wc_store

Lucas Stach <l.stach@pengutronix.de>
    drm/etnaviv: fix dumping of active MMU context

Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>
    arm64: tegra: Fix HSUART for Smaug

Konrad Dybcio <konrad.dybcio@linaro.org>
    arm64: dts: qcom: sc8180x: Add missing 'cache-unified' to L3

Konrad Dybcio <konrad.dybcio@linaro.org>
    arm64: dts: qcom: pmi8994: Add missing OVP interrupt

Konrad Dybcio <konrad.dybcio@linaro.org>
    arm64: dts: qcom: pmi8950: Add missing OVP interrupt

Konrad Dybcio <konrad.dybcio@linaro.org>
    arm64: dts: qcom: pm660l: Add missing short interrupt

Konrad Dybcio <konrad.dybcio@linaro.org>
    arm64: dts: qcom: pm6150l: Add missing short interrupt

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    arm64: dts: qcom: sm8250-sony-xperia: correct GPIO keys wakeup again

Jon Hunter <jonathanh@nvidia.com>
    arm64: tegra: Fix HSUART for Jetson AGX Orin

Jon Hunter <jonathanh@nvidia.com>
    arm64: tegra: Add missing alias for NVIDIA IGX Orin

Rafał Miłecki <rafal@milecki.pl>
    ARM: dts: BCM53573: Use updated "spi-gpio" binding properties

Rafał Miłecki <rafal@milecki.pl>
    ARM: dts: BCM53573: Add cells sizes to PCIe node

Rafał Miłecki <rafal@milecki.pl>
    ARM: dts: BCM53573: Drop nonexistent #usb-cells

Rafał Miłecki <rafal@milecki.pl>
    ARM: dts: BCM53573: Drop nonexistent "default-off" LED trigger

Arnd Bergmann <arnd@arndb.de>
    drm/amdgpu: avoid integer overflow warning in amdgpu_device_resize_fb_bar()

Nishanth Menon <nm@ti.com>
    firmware: ti_sci: Use system_state to determine polling

Marek Vasut <marex@denx.de>
    ARM: dts: stm32: Add missing detach mailbox for DHCOR SoM

Marek Vasut <marex@denx.de>
    ARM: dts: stm32: Add missing detach mailbox for DHCOM SoM

Marek Vasut <marex@denx.de>
    ARM: dts: stm32: Add missing detach mailbox for Odyssey SoM

Marek Vasut <marex@denx.de>
    ARM: dts: stm32: Add missing detach mailbox for emtrion emSBC-Argon

Konrad Dybcio <konrad.dybcio@linaro.org>
    arm64: dts: qcom: sm8250: Mark SMMUs as DMA coherent

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    arm64: dts: qcom: minor whitespace cleanup around '='

Konrad Dybcio <konrad.dybcio@linaro.org>
    arm64: dts: qcom: sm8250: Mark PCIe hosts as DMA coherent

Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
    arm64: dts: qcom: sm8450-hdk: remove pmr735b PMIC inclusion

Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
    arm64: dts: qcom: pmk8350: fix ADC-TM compatible string

Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
    arm64: dts: qcom: pmr735b: fix thermal zone name

Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
    arm64: dts: qcom: pm8350b: fix thermal zone name

Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
    arm64: dts: qcom: pm8350: fix thermal zone name

Konrad Dybcio <konrad.dybcio@linaro.org>
    arm64: dts: qcom: sm8350: Use proper CPU compatibles

Konrad Dybcio <konrad.dybcio@linaro.org>
    arm64: dts: qcom: sc8180x: Fix cluster PSCI suspend param

Konrad Dybcio <konrad.dybcio@linaro.org>
    arm64: dts: qcom: sm8350: Add missing LMH interrupts to cpufreq

Konrad Dybcio <konrad.dybcio@linaro.org>
    arm64: dts: qcom: sm8350: Fix CPU idle state residency times

Konrad Dybcio <konrad.dybcio@linaro.org>
    arm64: dts: qcom: sdm845-tama: Set serial indices and stdout-path

Konrad Dybcio <konrad.dybcio@linaro.org>
    arm64: dts: qcom: msm8996: Add missing interrupt to the USB2 controller

Konrad Dybcio <konrad.dybcio@linaro.org>
    arm64: dts: qcom: msm8939: Add missing 'cache-unified' to L2

Konrad Dybcio <konrad.dybcio@linaro.org>
    arm64: dts: qcom: msm8939: Drop "qcom,idle-state-spc" compatible

Konrad Dybcio <konrad.dybcio@linaro.org>
    arm64: dts: qcom: sc8280xp: Add missing SCM interconnect

Bjorn Andersson <quic_bjorande@quicinc.com>
    arm64: dts: qcom: sc8280xp-crd: Correct vreg_misc_3p3 GPIO

Konrad Dybcio <konrad.dybcio@linaro.org>
    arm64: dts: qcom: sm8250-edo: Rectify gpio-keys

Konrad Dybcio <konrad.dybcio@linaro.org>
    arm64: dts: qcom: sm8250-edo: Add GPIO line names for PMIC GPIOs

Konrad Dybcio <konrad.dybcio@linaro.org>
    arm64: dts: qcom: sm8250-edo: Add gpio line names for TLMM

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    arm64: dts: qcom: msm8916-l8150: correct light sensor VDDIO supply

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    arm64: dts: qcom: sm8450: correct crypto unit address

Vincent Guittot <vincent.guittot@linaro.org>
    arm64: dts: qcom: sm8250: correct dynamic power coefficients

Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
    Revert "arm64: dts: qcom: msm8996: rename labels for HDMI nodes"

Konrad Dybcio <konrad.dybcio@somainline.org>
    arm64: dts: qcom: sm6350: Fix ZAP region

Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
    arm64: dts: qcom: sm8150: use proper DSI PHY compatible

Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
    arm64: defconfig: enable Qualcomm MSM8996 Global Clock Controller as built-in

Luca Weiss <luca@z3ntu.xyz>
    soc: qcom: ocmem: Fix NUM_PORTS & NUM_MACROS macros

Randy Dunlap <rdunlap@infradead.org>
    ASoC: stac9766: fix build errors with REGMAP_AC97

Sui Jingfeng <suijingfeng@loongson.cn>
    drm/hyperv: Fix a compilation issue because of not including screen_info.h

Wesley Chalmers <Wesley.Chalmers@amd.com>
    drm/amd/display: Do not set drr on pipe commit

Baokun Li <libaokun1@huawei.com>
    quota: fix dqput() to follow the guarantees dquot_srcu should provide

Baokun Li <libaokun1@huawei.com>
    quota: add new helper dquot_active()

Baokun Li <libaokun1@huawei.com>
    quota: rename dquot_active() to inode_quota_active()

Baokun Li <libaokun1@huawei.com>
    quota: factor out dquot_write_dquot()

Ondrej Jirman <megi@xff.cz>
    drm: bridge: dw-mipi-dsi: Fix enable/disable of DSI controller

Phil Elwell <phil@raspberrypi.com>
    ASoC: cs43130: Fix numerator/denominator mixup

yixuanjiang <yixuanjiang@google.com>
    ASoC: soc-compress: Fix deadlock in soc_compr_open_fe

Marek Vasut <marex@denx.de>
    drm/bridge: tc358764: Fix debug print parameter order

Kuniyuki Iwashima <kuniyu@amazon.com>
    netrom: Deny concurrent connect().

Shannon Nelson <shannon.nelson@amd.com>
    pds_core: pass opcode to devcmd_wait

Shannon Nelson <shannon.nelson@amd.com>
    pds_core: check for work queue before use

Shannon Nelson <shannon.nelson@amd.com>
    pds_core: no reset command for VF

Shannon Nelson <shannon.nelson@amd.com>
    pds_core: no health reporter in VF

Shannon Nelson <shannon.nelson@amd.com>
    pds_core: protect devlink callbacks from fw_down state

Budimir Markovic <markovicbudimir@gmail.com>
    net/sched: sch_hfsc: Ensure inner classes have fsc curve

Alex Austin <alex.austin@amd.com>
    sfc: Check firmware supports Ethernet PTP filter

Suman Ghosh <sumang@marvell.com>
    cteonxt2-pf: Fix backpressure config for multiple PFC priorities to work simultaneously

Hariprasad Kelam <hkelam@marvell.com>
    octeontx2-af: CN10KB: fix PFC configuration

Suman Ghosh <sumang@marvell.com>
    octeontx2-pf: Fix PFC TX scheduler free

Biju Das <biju.das.jz@bp.renesas.com>
    hwmon: (tmp513) Fix the channel number in tmp51x_is_visible()

Adam Guerin <adam.guerin@intel.com>
    crypto: qat - fix crypto capability detection for 4xxx

Vadim Pasternak <vadimp@nvidia.com>
    mlxsw: core_hwmon: Adjust module label names based on MTCAP sensor counter

Vadim Pasternak <vadimp@nvidia.com>
    mlxsw: i2c: Limit single transaction buffer size

Vadim Pasternak <vadimp@nvidia.com>
    mlxsw: i2c: Fix chunk size setting in output mailbox buffer

Christophe Leroy <christophe.leroy@csgroup.eu>
    kunit: Fix checksum tests on big endian CPUs

Jinjie Ruan <ruanjinjie@huawei.com>
    net: arcnet: Do not call kfree_skb() under local_irq_disable()

Ratheesh Kannoth <rkannoth@marvell.com>
    octeontx2-pf: fix page_pool creation fail for rings > 32k

Jacob Keller <jacob.e.keller@intel.com>
    ice: avoid executing commands on other ports when driving sync

Wang Ming <machel@vivo.com>
    wifi: ath9k: use IS_ERR() with debugfs_create_dir()

Rahul Rameshbabu <rrameshbabu@nvidia.com>
    net/mlx5: Dynamic cyclecounter shift calculation for PTP free running clock

Qi Zheng <zhengqi.arch@bytedance.com>
    arm64: mm: use ptep_clear() instead of pte_clear() in clear_flush()

Jinjie Ruan <ruanjinjie@huawei.com>
    Bluetooth: btusb: Do not call kfree_skb() under spin_lock_irqsave()

Pauli Virtanen <pav@iki.fi>
    Bluetooth: hci_conn: fail SCO/ISO via hci_conn_failed if ACL gone early

Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
    Bluetooth: hci_sync: Fix UAF in hci_disconnect_all_sync

Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
    Bluetooth: hci_sync: Fix UAF on hci_abort_conn_sync

Iulia Tanasescu <iulia.tanasescu@nxp.com>
    Bluetooth: ISO: Notify user space about failed bis connections

Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
    Bluetooth: hci_conn: Consolidate code for aborting connections

Dmitry Antipov <dmantipov@yandex.ru>
    wifi: mwifiex: avoid possible NULL skb pointer dereference

Kumar Kartikeya Dwivedi <memxor@gmail.com>
    bpf: Fix check_func_arg_reg_off bug for graph root/node

Arnd Bergmann <arnd@arndb.de>
    mac80211: make ieee80211_tx_info padding explicit

Lin Ma <linma@zju.edu.cn>
    wifi: nl80211/cfg80211: add forgotten nla_policy for BSS color attribute

Johannes Berg <johannes.berg@intel.com>
    wifi: mac80211: fix puncturing bitmap handling in CSA

Yonghong Song <yonghong.song@linux.dev>
    bpf: Fix a bpf_kptr_xchg() issue with local kptr

Fedor Pchelkin <pchelkin@ispras.ru>
    wifi: ath9k: protect WMI command response buffer replacement with a lock

Fedor Pchelkin <pchelkin@ispras.ru>
    wifi: ath9k: fix races between ath9k_wmi_cmd and ath9k_wmi_ctrl_rx

Daniel T. Lee <danieltimlee@gmail.com>
    samples/bpf: fix broken map lookup probe

Daniel T. Lee <danieltimlee@gmail.com>
    samples/bpf: fix bio latency check with tracepoint

Aleksa Sarai <cyphar@cyphar.com>
    selftests: memfd: error out test process when child test fails

Ping-Ke Shih <pkshih@realtek.com>
    wifi: rtw89: 8852b: rfk: fine tune IQK parameters to improve performance on 2GHz band

Polaris Pi <pinkperfect2021@gmail.com>
    wifi: mwifiex: Fix missed return in oob checks failed path

Dmitry Antipov <dmantipov@yandex.ru>
    wifi: mwifiex: fix memory leak in mwifiex_histogram_read()

Eugene Shalygin <eugene.shalygin@gmail.com>
    hwmon: (asus-ec-sensosrs) fix mutex path for X670E Hero

Eric Dumazet <edumazet@google.com>
    net: annotate data-races around sk->sk_lingertime

Ruan Jinjie <ruanjinjie@huawei.com>
    net: lan966x: Fix return value check for vcap_get_rule()

Artem Chernyshev <artem.chernyshev@red-soft.ru>
    fs: ocfs2: namei: check return value of ocfs2_add_entry()

Douglas Anderson <dianders@chromium.org>
    watchdog/hardlockup: avoid large stack frames in watchdog_hardlockup_check()

Douglas Anderson <dianders@chromium.org>
    nmi_backtrace: allow excluding an arbitrary CPU

Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
    scripts/gdb: fix 'lx-lsmod' show the wrong size

Alan Stern <stern@rowland.harvard.edu>
    USB: core: Fix race by not overwriting udev->descriptor in hub_port_init()

Alan Stern <stern@rowland.harvard.edu>
    USB: core: Change usb_get_device_descriptor() API

Alan Stern <stern@rowland.harvard.edu>
    USB: core: Unite old scheme and new scheme descriptor reads

RD Babiera <rdbabiera@google.com>
    usb: typec: bus: verify partner exists in typec_altmode_attention

RD Babiera <rdbabiera@google.com>
    usb: typec: tcpm: set initial svdm version based on pd revision

Yan Zhai <yan@cloudflare.com>
    lwt: Check LWTUNNEL_XMIT_CONTINUE strictly

Yan Zhai <yan@cloudflare.com>
    lwt: Fix return values of BPF xmit ops

Florian Fainelli <florian.fainelli@broadcom.com>
    hwrng: iproc-rng200 - Implement suspend and resume calls

Gaurav Jain <gaurav.jain@nxp.com>
    crypto: caam - fix unchecked return value error

Przemek Kitszel <przemyslaw.kitszel@intel.com>
    ice: ice_aq_check_events: fix off-by-one check when filling buffer

Abel Wu <wuyun.abel@bytedance.com>
    net-memcg: Fix scope of sockmem pressure indicators

Jijie Shao <shaojijie@huawei.com>
    net: hns3: fix wrong rpu tln reg issue

Jijie Shao <shaojijie@huawei.com>
    net: hns3: Support tlv in regs data for HNS3 PF driver

Jijie Shao <shaojijie@huawei.com>
    net: hns3: move dump regs function to a separate file

Lorenz Bauer <lmb@isovalent.com>
    net: Fix slab-out-of-bounds in inet[6]_steal_sock

Alexander Danilenko <al.b.danilenko@gmail.com>
    spi: tegra114: Remove unnecessary NULL-pointer checks

Yipeng Zou <zouyipeng@huawei.com>
    selftests/bpf: Clean up fmod_ret in bench_rename test script

Yipeng Zou <zouyipeng@huawei.com>
    selftests/bpf: Fix repeat option when kfunc_call verification fails

Marco Vedovati <marco.vedovati@crowdstrike.com>
    libbpf: Set close-on-exec flag on gzopen

Vladimir Oltean <vladimir.oltean@nxp.com>
    net: pcs: lynx: fix lynx_pcs_link_up_sgmii() not doing anything in fixed-link mode

Menglong Dong <imagedong@tencent.com>
    net: tcp: fix unexcepted socket die when snd_wnd is 0

Pauli Virtanen <pav@iki.fi>
    Bluetooth: hci_event: drop only unbound CIS if Set CIG Parameters fails

Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
    Bluetooth: hci_conn: Always allocate unique handles

Manish Mandlik <mmandlik@google.com>
    Bluetooth: hci_sync: Avoid use-after-free in dbg for hci_add_adv_monitor()

Douglas Anderson <dianders@chromium.org>
    Bluetooth: hci_sync: Don't double print name in add/remove adv_monitor

Min Li <lm0963hack@gmail.com>
    Bluetooth: Fix potential use-after-free when clear keys

Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
    Bluetooth: hci_conn: Fix hci_le_set_cig_params

Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
    Bluetooth: hci_conn: Fix not allowing valid CIS ID

Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
    Bluetooth: ISO: Fix not checking for valid CIG/CIS IDs

Yuanjun Gong <ruc_gongyuanjun@163.com>
    Bluetooth: nokia: fix value check in nokia_bluetooth_serdev_probe()

Pauli Virtanen <pav@iki.fi>
    Bluetooth: ISO: do not emit new LE Create CIS if previous is pending

Iulia Tanasescu <iulia.tanasescu@nxp.com>
    Bluetooth: ISO: Add support for connecting multiple BISes

Herbert Xu <herbert@gondor.apana.org.au>
    crypto: api - Use work queue in crypto_destroy_instance

Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
    crypto: stm32 - Properly handle pm_runtime_get failing

Miguel Ojeda <ojeda@kernel.org>
    kbuild: rust_is_available: fix confusion when a version appears in the path

Miguel Ojeda <ojeda@kernel.org>
    kbuild: rust_is_available: add check for `bindgen` invocation

Russell Currey <ruscur@russell.cc>
    kbuild: rust_is_available: fix version check when CC has multiple arguments

Masahiro Yamada <masahiroy@kernel.org>
    kbuild: rust_is_available: remove -v option

Kui-Feng Lee <thinker.li@gmail.com>
    bpf: fix bpf_dynptr_slice() to stop return an ERR_PTR.

David Howells <dhowells@redhat.com>
    crypto: af_alg - Fix missing initialisation affecting gcm-aes-s390

Li Zetao <lizetao1@huawei.com>
    spi: mpc5xxx-psc: Fix unsigned expression compared with zero

Yu Liao <liaoyu15@huawei.com>
    power: supply: qcom_pmi8998_charger: fix uninitialized variable

Alan Maguire <alan.maguire@oracle.com>
    selftests/bpf: fix static assert compilation issue for test_cls_*.c

Arnd Bergmann <arnd@arndb.de>
    wifi: ath12k: fix memcpy array overflow in ath12k_peer_assoc_h_he()

Aditya Kumar Singh <quic_adisi@quicinc.com>
    wifi: ath11k: fix band selection for ppdu received in channel 177 of 5 GHz

Dmitry Antipov <dmantipov@yandex.ru>
    wifi: mwifiex: fix error recovery in PCIE buffer descriptor management

Polaris Pi <pinkperfect2021@gmail.com>
    wifi: mwifiex: Fix OOB and integer underflow when rx packets

Larry Finger <Larry.Finger@lwfinger.net>
    wifi: rtw89: Fix loading of compressed firmware

Ryder Lee <ryder.lee@mediatek.com>
    wifi: mt76: mt7915: fix power-limits while chan_switch

Ryder Lee <ryder.lee@mediatek.com>
    wifi: mt76: mt7915: fix tlv length of mt7915_mcu_get_chan_mib_info

Markus Schneider-Pargmann <msp@baylibre.com>
    can: tcan4x5x: Remove reserved register 0x814 from writable table

Marc Kleine-Budde <mkl@pengutronix.de>
    can: gs_usb: gs_usb_receive_bulk_callback(): count RX overflow errors also in case of OOM

Zhang Shurong <zhang_shurong@foxmail.com>
    spi: tegra20-sflash: fix to check return value of platform_get_irq() in tegra_sflash_probe()

Lin Ma <linma@zju.edu.cn>
    wifi: mt76: testmode: add nla_policy for MT76_TM_ATTR_TX_LENGTH

Felix Fietkau <nbd@nbd.name>
    wifi: mt76: mt7915: remove VHT160 capability on MT7915

Felix Fietkau <nbd@nbd.name>
    wifi: mt76: mt7915: fix capabilities in non-AP mode

Rany Hany <rany_hany@riseup.net>
    wifi: mt76: mt7915: fix command timeout in AP stop period

Lorenz Bauer <lmb@isovalent.com>
    bpf, net: Support SO_REUSEPORT sockets with bpf_sk_assign

Lorenz Bauer <lmb@isovalent.com>
    net: remove duplicate reuseport_lookup functions

Lorenz Bauer <lmb@isovalent.com>
    net: export inet_lookup_reuseport and inet6_lookup_reuseport

Lorenz Bauer <lmb@isovalent.com>
    bpf: reject unhashed sockets in bpf_sk_assign

Lorenz Bauer <lmb@isovalent.com>
    udp: re-score reuseport groups when connected sockets are present

StanleyYP Wang <StanleyYP.Wang@mediatek.com>
    wifi: mt76: mt7996: fix WA event ring size

StanleyYP Wang <StanleyYP.Wang@mediatek.com>
    wifi: mt76: mt7996: use correct phy for background radar event

Peter Chiu <chui-hao.chiu@mediatek.com>
    wifi: mt76: mt7996: fix bss wlan_idx when sending bss_info command

Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
    wifi: mt76: mt7921: fix non-PSC channel scan fail

Peter Chiu <chui-hao.chiu@mediatek.com>
    wifi: mt76: mt7915: rework tx bytes counting when WED is active

Peter Chiu <chui-hao.chiu@mediatek.com>
    wifi: mt76: mt7915: rework tx packets counting when WED is active

StanleyYP Wang <StanleyYP.Wang@mediatek.com>
    wifi: mt76: mt7915: fix background radar event being blocked

Ryder Lee <ryder.lee@mediatek.com>
    wifi: mt76: mt7996: fix header translation logic

Zhang Shurong <zhang_shurong@foxmail.com>
    wifi: rtw89: debug: Fix error handling in rtw89_debug_priv_btc_manual_set()

Dan Carpenter <dan.carpenter@linaro.org>
    regmap: rbtree: Use alloc_flags for memory allocations

Guenter Roeck <linux@roeck-us.net>
    regmap: maple: Use alloc_flags for memory allocations

Martin Kaiser <martin@kaiser.cx>
    hwrng: pic32 - use devm_clk_get_enabled

Martin Kaiser <martin@kaiser.cx>
    hwrng: nomadik - keep clock enabled while hwrng is registered

Eric Dumazet <edumazet@google.com>
    tcp: tcp_enter_quickack_mode() should be static

Giovanni Cabiddu <giovanni.cabiddu@intel.com>
    crypto: qat - change value of default idle filter

Yafang Shao <laoar.shao@gmail.com>
    bpf: Fix an error in verifying a field in a union

Yafang Shao <laoar.shao@gmail.com>
    bpf: Fix an error around PTR_UNTRUSTED

Yafang Shao <laoar.shao@gmail.com>
    bpf: Clear the probe_addr for uprobe

Andrii Nakryiko <andrii@kernel.org>
    libbpf: Fix realloc API handling in zero-sized edge cases

Alexander Lobakin <alobakin@pm.me>
    bpftool: Use a local bpf_perf_event_value to fix accessing its fields

Quentin Monnet <quentin@isovalent.com>
    bpftool: Use a local copy of BPF_LINK_TYPE_PERF_EVENT in pid_iter.bpf.c

Alexander Lobakin <alobakin@pm.me>
    bpftool: Define a local bpf_perf_link to fix accessing its fields

Alexander Lobakin <alobakin@pm.me>
    bpftool: use a local copy of perf_event to fix accessing :: Bpf_cookie

Andrii Nakryiko <andrii@kernel.org>
    libbpf: only reset sec_def handler when necessary

Daniel Borkmann <daniel@iogearbox.net>
    selftests/bpf: Fix bpf_nf failure upon test rerun

Sumit Gupta <sumitg@nvidia.com>
    cpufreq: tegra194: remove opp table in exit hook

Sumit Gupta <sumitg@nvidia.com>
    cpufreq: tegra194: add online/offline hooks

Liao Chang <liaochang1@huawei.com>
    cpufreq: powernow-k8: Use related_cpus instead of cpus in driver.exit()

Mikel Rychliski <mikel@mikelr.com>
    x86/efistub: Fix PCI ROM preservation in mixed mode

Zhangjin Wu <falcon@tinylab.org>
    tools/nolibc: fix up startup failures for -O0 under gcc < 11.1.0

Zhangjin Wu <falcon@tinylab.org>
    tools/nolibc: arch-*.h: add missing space after ','

Swapnil Sapkal <swapnil.sapkal@amd.com>
    cpufreq: amd-pstate-ut: Fix kernel panic when loading the driver

Swapnil Sapkal <swapnil.sapkal@amd.com>
    cpufreq: amd-pstate-ut: Remove module parameter access

Peng Fan <peng.fan@nxp.com>
    thermal/of: Fix potential uninitialized value access

Mario Limonciello <mario.limonciello@amd.com>
    ACPI: x86: s2idle: Fix a logic error parsing AMD constraints table

Mario Limonciello <mario.limonciello@amd.com>
    ACPI: x86: s2idle: Post-increment variables when getting constraints

Bibo Mao <maobibo@loongson.cn>
    irqchip/loongson-eiointc: Fix return value checking of eiointc_index

Holger Dengler <dengler@linux.ibm.com>
    s390/paes: fix PKEY_TYPE_EP11_AES handling for secure keyblobs

Holger Dengler <dengler@linux.ibm.com>
    s390/pkey: fix PKEY_TYPE_EP11_AES handling for sysfs attributes

Holger Dengler <dengler@linux.ibm.com>
    s390/pkey: fix PKEY_TYPE_EP11_AES handling in PKEY_VERIFYKEY2 IOCTL

Holger Dengler <dengler@linux.ibm.com>
    s390/pkey: fix PKEY_TYPE_EP11_AES handling in PKEY_KBLOB2PROTK[23]

Holger Dengler <dengler@linux.ibm.com>
    s390/pkey: fix PKEY_TYPE_EP11_AES handling in PKEY_CLR2SECK2 IOCTL

Holger Dengler <dengler@linux.ibm.com>
    s390/pkey: fix PKEY_TYPE_EP11_AES handling in PKEY_GENSECK2 IOCTL

Holger Dengler <dengler@linux.ibm.com>
    s390/pkey: fix/harmonize internal keyblob headers

Nysal Jan K.A <nysal@linux.ibm.com>
    selftests/futex: Order calls to futex_lock_pi

Xu Yang <xu.yang_2@nxp.com>
    perf/imx_ddr: don't enable counter0 if none of 4 counters are used

Cyril Hrubis <chrubis@suse.cz>
    sched/rt: Fix sysctl_sched_rr_timeslice intial value

Mark Brown <broonie@kernel.org>
    arm64/fpsimd: Only provide the length to cpufeature for xCR registers

Ard Biesheuvel <ardb@kernel.org>
    x86/decompressor: Don't rely on upper 32 bits of GPRs being preserved

Rafael J. Wysocki <rafael.j.wysocki@intel.com>
    cpuidle: teo: Update idle duration estimate when choosing shallower state

Randy Dunlap <rdunlap@infradead.org>
    sched/psi: Select KERNFS as needed

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    arm64/ptrace: Clean up error handling path in sve_set_common()

Vincent Guittot <vincent.guittot@linaro.org>
    sched/fair: remove util_est boosting

Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
    selftests/resctrl: Close perf value read fd on errors

Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
    selftests/resctrl: Unmount resctrl FS if child fails to run benchmark

Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
    selftests/resctrl: Don't leak buffer in fill_cache()

Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
    selftests/resctrl: Add resctrl.h into build deps

Manivannan Sadhasivam <mani@kernel.org>
    OPP: Fix passing 0 to PTR_ERR in _opp_attach_genpd()

Manivannan Sadhasivam <mani@kernel.org>
    OPP: Fix potential null ptr dereference in dev_pm_opp_get_required_pstate()

Cristian Marussi <cristian.marussi@arm.com>
    powercap: arm_scmi: Remove recursion while parsing zones

Paul E. McKenney <paulmck@kernel.org>
    clocksource: Handle negative skews in "skew is too large" messages

Waiman Long <longman@redhat.com>
    refscale: Fix uninitalized use of wait_queue_head_t

Uros Bizjak <ubizjak@gmail.com>
    locking/arch: Avoid variable shadowing in local_try_cmpxchg()

Jingbo Xu <jefflexu@linux.alibaba.com>
    erofs: release ztailpacking pclusters properly

Naohiro Aota <naohiro.aota@wdc.com>
    btrfs: zoned: skip splitting and logical rewriting on pre-alloc write

Kees Cook <keescook@chromium.org>
    ARM: ptrace: Restore syscall skipping for tracers

Kees Cook <keescook@chromium.org>
    ARM: ptrace: Restore syscall restart tracing

David Howells <dhowells@redhat.com>
    vfs, security: Fix automount superblock LSM init problem, preventing NFS sb sharing

Kees Cook <keescook@chromium.org>
    selftests/harness: Actually report SKIP for signal tests

Christian Brauner <brauner@kernel.org>
    tmpfs: verify {g,u}id mount options correctly

Matthew Wilcox (Oracle) <willy@infradead.org>
    iomap: Remove large folio handling in iomap_invalidate_folio()

Wang Ming <machel@vivo.com>
    fs: Fix error checking for d_hash_and_lookup()

Wen Yang <wenyang.linux@foxmail.com>
    eventfd: prevent underflow for eventfd semaphores

Ahelenia Ziemiańska <nabijaczleweli@nabijaczleweli.xyz>
    splice: fsnotify_access(in), fsnotify_modify(out) on success in tee

Ahelenia Ziemiańska <nabijaczleweli@nabijaczleweli.xyz>
    splice: fsnotify_access(fd)/fsnotify_modify(fd) in vmsplice

Ahelenia Ziemiańska <nabijaczleweli@nabijaczleweli.xyz>
    splice: always fsnotify_access(in), fsnotify_modify(out) on success

Matthew Wilcox <willy@infradead.org>
    reiserfs: Check the return value from __getblk()

Sabrina Dubroca <sd@queasysnail.net>
    Revert "net: macsec: preserve ingress frame ordering"

Vidya Sagar <vidyas@nvidia.com>
    Revert "PCI: tegra194: Enable support for 256 Byte payload"

Jaegeuk Kim <jaegeuk@kernel.org>
    Revert "f2fs: clean up w/ sbi->log_sectors_per_block"

Miklos Szeredi <mszeredi@redhat.com>
    Revert "fuse: in fuse_flush only wait if someone wants the return code"

Werner Sembach <wse@tuxedocomputers.com>
    Input: i8042 - add quirk for TUXEDO Gemini 17 Gen1/Clevo PD70PN

Max Chou <max.chou@realtek.com>
    Bluetooth: btrtl: Load FW v2 otherwise FW v1 for RTL8852C

Jordan Rife <jrife@google.com>
    net: Avoid address overwrite in kernel_connect

Jarkko Sakkinen <jarkko@kernel.org>
    tpm: Enable hwrng only for Pluton on AMD CPUs

Doug Smythies <dsmythies@telus.net>
    cpufreq: intel_pstate: set stale CPU frequency to minimum

Hamza Mahfooz <hamza.mahfooz@amd.com>
    drm/amd/display: ensure async flips are only accepted for fast updates


-------------

Diffstat:

 .../ABI/testing/sysfs-bus-fsi-devices-sbefifo      |   6 +-
 .../ABI/testing/sysfs-driver-chromeos-acpi         |   2 +-
 Documentation/ABI/testing/sysfs-fs-f2fs            |   8 +-
 Documentation/admin-guide/devices.txt              |  16 +-
 .../devicetree/bindings/extcon/maxim,max77843.yaml |   1 +
 .../devicetree/bindings/pci/qcom,pcie-ep.yaml      |  12 +-
 .../bindings/power/qcom,kpss-acc-v2.yaml           |   1 +
 .../bindings/regulator/qcom,rpm-regulator.yaml     |   2 +-
 .../bindings/usb/samsung,exynos-dwc3.yaml          |   4 +-
 Documentation/scsi/scsi_mid_low_api.rst            |   4 +-
 .../media/v4l/vidioc-subdev-g-routing.rst          |   7 +-
 Makefile                                           |   8 +-
 .../boot/dts/broadcom/bcm47189-luxul-xap-1440.dts  |  14 +-
 .../boot/dts/broadcom/bcm47189-luxul-xap-810.dts   |  15 +-
 arch/arm/boot/dts/broadcom/bcm47189-tenda-ac9.dts  |   4 +-
 arch/arm/boot/dts/broadcom/bcm53573.dtsi           |   5 +-
 arch/arm/boot/dts/broadcom/bcm947189acdbmr.dts     |   6 +-
 arch/arm/boot/dts/qcom/qcom-ipq4019.dtsi           |   9 +-
 arch/arm/boot/dts/qcom/qcom-sdx65-mtp.dts          |   2 +-
 arch/arm/boot/dts/samsung/s3c6410-mini6410.dts     |   2 +-
 arch/arm/boot/dts/samsung/s5pv210-smdkv210.dts     |   2 +-
 .../arm/boot/dts/st/stm32mp157c-emstamp-argon.dtsi |   4 +-
 arch/arm/boot/dts/st/stm32mp157c-odyssey-som.dtsi  |   4 +-
 arch/arm/boot/dts/st/stm32mp15xx-dhcom-som.dtsi    |   4 +-
 arch/arm/boot/dts/st/stm32mp15xx-dhcor-som.dtsi    |   4 +-
 arch/arm/include/asm/irq.h                         |   2 +-
 arch/arm/include/asm/syscall.h                     |   3 +
 arch/arm/kernel/entry-common.S                     |   1 +
 arch/arm/kernel/ptrace.c                           |   5 +-
 arch/arm/kernel/smp.c                              |   4 +-
 arch/arm/mach-omap2/powerdomain.c                  |   2 +-
 .../boot/dts/freescale/imx8mp-debix-model-a.dts    |  22 -
 arch/arm64/boot/dts/nvidia/tegra210-smaug.dts      |   1 +
 .../dts/nvidia/tegra234-p3737-0000+p3701-0000.dts  |   1 +
 .../dts/nvidia/tegra234-p3740-0002+p3701-0008.dts  |   1 +
 arch/arm64/boot/dts/qcom/apq8016-sbc.dts           |   8 +-
 arch/arm64/boot/dts/qcom/apq8096-db820c.dts        |  50 +-
 arch/arm64/boot/dts/qcom/apq8096-ifc6640.dts       |   6 +-
 arch/arm64/boot/dts/qcom/ipq8074.dtsi              |   8 +-
 .../boot/dts/qcom/msm8916-longcheer-l8150.dts      |   2 +-
 .../boot/dts/qcom/msm8916-samsung-serranove.dts    |   6 +-
 arch/arm64/boot/dts/qcom/msm8939.dtsi              |  16 +-
 arch/arm64/boot/dts/qcom/msm8953-xiaomi-daisy.dts  |   2 +-
 arch/arm64/boot/dts/qcom/msm8953-xiaomi-vince.dts  |   2 +-
 arch/arm64/boot/dts/qcom/msm8996-mtp.dts           |   4 +-
 arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dts |   2 +-
 arch/arm64/boot/dts/qcom/msm8996.dtsi              |  27 +-
 .../boot/dts/qcom/msm8996pro-xiaomi-natrium.dts    |   2 +-
 arch/arm64/boot/dts/qcom/msm8998.dtsi              |  26 +-
 arch/arm64/boot/dts/qcom/pm6150l.dtsi              |   5 +-
 arch/arm64/boot/dts/qcom/pm660l.dtsi               |   5 +-
 arch/arm64/boot/dts/qcom/pm8350.dtsi               |   2 +-
 arch/arm64/boot/dts/qcom/pm8350b.dtsi              |   2 +-
 arch/arm64/boot/dts/qcom/pmi8950.dtsi              |   5 +-
 arch/arm64/boot/dts/qcom/pmi8994.dtsi              |   5 +-
 arch/arm64/boot/dts/qcom/pmk8350.dtsi              |   2 +-
 arch/arm64/boot/dts/qcom/pmr735b.dtsi              |   2 +-
 arch/arm64/boot/dts/qcom/qcm2290.dtsi              |   2 +-
 arch/arm64/boot/dts/qcom/qcs404.dtsi               |   8 +-
 arch/arm64/boot/dts/qcom/sa8540p.dtsi              |   2 +-
 .../qcom/sc7280-herobrine-audio-rt5682-3mic.dtsi   |   2 +-
 arch/arm64/boot/dts/qcom/sc7280.dtsi               |   2 +-
 arch/arm64/boot/dts/qcom/sc8180x-pmics.dtsi        |  12 +-
 arch/arm64/boot/dts/qcom/sc8180x.dtsi              |  12 +-
 arch/arm64/boot/dts/qcom/sc8280xp-crd.dts          |   4 +-
 .../dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts     |   2 +-
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi             |   1 +
 arch/arm64/boot/dts/qcom/sdm630.dtsi               |  10 +-
 .../boot/dts/qcom/sdm845-oneplus-enchilada.dts     |   2 +-
 .../boot/dts/qcom/sdm845-sony-xperia-tama.dtsi     |   9 +
 arch/arm64/boot/dts/qcom/sdm845.dtsi               |   3 +-
 arch/arm64/boot/dts/qcom/sdx75.dtsi                |   4 +-
 arch/arm64/boot/dts/qcom/sm6115.dtsi               |   2 +-
 arch/arm64/boot/dts/qcom/sm6350.dtsi               |  10 +-
 arch/arm64/boot/dts/qcom/sm8150.dtsi               |   6 +-
 .../dts/qcom/sm8250-sony-xperia-edo-pdx203.dts     | 233 +++++++
 .../dts/qcom/sm8250-sony-xperia-edo-pdx206.dts     | 243 ++++++++
 .../boot/dts/qcom/sm8250-sony-xperia-edo.dtsi      |  54 +-
 arch/arm64/boot/dts/qcom/sm8250.dtsi               | 211 +++----
 arch/arm64/boot/dts/qcom/sm8350.dtsi               | 227 +++----
 arch/arm64/boot/dts/qcom/sm8450-hdk.dts            |   1 -
 arch/arm64/boot/dts/qcom/sm8450.dtsi               | 196 +++---
 arch/arm64/boot/dts/qcom/sm8550-mtp.dts            |   1 +
 arch/arm64/boot/dts/qcom/sm8550.dtsi               | 196 +++---
 arch/arm64/boot/dts/rockchip/rk3568-radxa-e25.dts  |  24 +-
 arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi     |   2 +-
 .../boot/dts/ti/k3-j721s2-common-proc-board.dts    |  19 +-
 arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi       |   3 -
 arch/arm64/boot/dts/ti/k3-j784s4-evm.dts           |  61 +-
 arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi         |   2 +-
 arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi   |   2 +-
 arch/arm64/configs/defconfig                       |   2 +-
 arch/arm64/include/asm/sdei.h                      |   6 +
 arch/arm64/kernel/entry.S                          |  27 +-
 arch/arm64/kernel/fpsimd.c                         |  22 +-
 arch/arm64/kernel/ptrace.c                         |   3 +-
 arch/arm64/kernel/sdei.c                           |   3 +
 arch/arm64/kernel/smp.c                            |   8 +-
 arch/arm64/lib/csum.c                              |   2 +-
 arch/arm64/mm/hugetlbpage.c                        |   2 +-
 arch/loongarch/include/asm/irq.h                   |   2 +-
 arch/loongarch/include/asm/local.h                 |   4 +-
 arch/loongarch/include/asm/pgtable.h               |   3 +
 arch/loongarch/kernel/process.c                    |   4 +-
 arch/mips/include/asm/irq.h                        |   2 +-
 arch/mips/include/asm/local.h                      |   4 +-
 arch/mips/kernel/process.c                         |   4 +-
 arch/parisc/include/asm/runway.h                   |   3 -
 arch/parisc/kernel/processor.c                     |  13 +-
 arch/powerpc/include/asm/ftrace.h                  |   2 +-
 arch/powerpc/include/asm/irq.h                     |   2 +-
 arch/powerpc/include/asm/lppaca.h                  |  13 +-
 arch/powerpc/include/asm/paca.h                    |   6 +-
 arch/powerpc/include/asm/paravirt.h                |   1 +
 arch/powerpc/include/asm/plpar_wrappers.h          |   1 +
 arch/powerpc/kernel/fadump.c                       |   1 +
 arch/powerpc/kernel/iommu.c                        |  17 +-
 arch/powerpc/kernel/stacktrace.c                   |   4 +-
 arch/powerpc/kernel/watchdog.c                     |   4 +-
 arch/powerpc/kvm/book3s_hv_ras.c                   |   1 +
 arch/powerpc/mm/book3s64/radix_tlb.c               | 240 ++++----
 arch/powerpc/mm/book3s64/slb.c                     |   1 +
 arch/powerpc/perf/core-fsl-emb.c                   |   8 +-
 arch/powerpc/platforms/pseries/hvCall.S            |   1 +
 arch/powerpc/platforms/pseries/lpar.c              |  10 +-
 arch/powerpc/platforms/pseries/lparcfg.c           |   4 +-
 arch/powerpc/platforms/pseries/setup.c             |   2 +-
 arch/powerpc/sysdev/mpc5xxx_clocks.c               |   4 +-
 arch/powerpc/xmon/xmon.c                           |   1 +
 arch/riscv/Kconfig                                 |   1 +
 arch/riscv/Makefile                                |   3 -
 arch/riscv/include/uapi/asm/ptrace.h               |  13 +-
 arch/riscv/kernel/ptrace.c                         |  79 +++
 arch/riscv/mm/kasan_init.c                         |   8 +-
 arch/s390/crypto/paes_s390.c                       |   2 +-
 arch/s390/include/uapi/asm/pkey.h                  |   2 +-
 arch/s390/kernel/ipl.c                             |   2 +
 arch/sparc/include/asm/irq_64.h                    |   2 +-
 arch/sparc/kernel/process_64.c                     |   6 +-
 arch/um/configs/i386_defconfig                     |   1 +
 arch/um/configs/x86_64_defconfig                   |   1 +
 arch/um/drivers/Kconfig                            |  16 +-
 arch/um/drivers/Makefile                           |   2 +-
 arch/um/drivers/virt-pci.c                         |   2 +
 arch/x86/boot/compressed/head_64.S                 |  30 +-
 arch/x86/events/intel/uncore_snbep.c               |  12 +-
 arch/x86/include/asm/irq.h                         |   2 +-
 arch/x86/include/asm/local.h                       |   4 +-
 arch/x86/include/asm/mem_encrypt.h                 |   6 +-
 arch/x86/include/asm/pgtable_types.h               |  11 +-
 arch/x86/kernel/apic/hw_nmi.c                      |   4 +-
 arch/x86/kernel/apm_32.c                           |   6 -
 arch/x86/kernel/cpu/common.c                       |   8 +-
 arch/x86/kernel/cpu/mce/core.c                     |  26 +
 arch/x86/kernel/cpu/mce/internal.h                 |   5 +-
 arch/x86/kernel/cpu/sgx/virt.c                     |   3 +
 arch/x86/kernel/kvm.c                              |   4 +-
 arch/x86/kernel/smpboot.c                          |   2 +-
 arch/x86/kernel/vmlinux.lds.S                      |   2 +-
 arch/x86/mm/mem_encrypt_amd.c                      |  13 +-
 arch/xtensa/include/asm/core.h                     |   9 +
 arch/xtensa/kernel/perf_event.c                    |  17 +-
 block/bio-integrity.c                              |  31 +-
 block/bio.c                                        | 112 ++--
 block/blk-cgroup.c                                 |  32 +-
 block/blk-flush.c                                  |   2 +-
 block/blk-map.c                                    |   7 +-
 block/blk-settings.c                               |   7 +-
 block/blk-sysfs.c                                  |  21 +-
 block/blk.h                                        |   4 +
 block/ioctl.c                                      |   2 +
 block/mq-deadline.c                                |   3 +-
 crypto/af_alg.c                                    |   4 +
 crypto/algapi.c                                    |  16 +-
 crypto/asymmetric_keys/x509_public_key.c           |   5 +
 drivers/acpi/x86/s2idle.c                          |  39 +-
 drivers/amba/bus.c                                 |   1 +
 drivers/base/core.c                                |  11 +
 drivers/base/dd.c                                  |   2 +
 drivers/base/regmap/regcache-maple.c               |  16 +-
 drivers/base/regmap/regcache-rbtree.c              |  10 +-
 drivers/base/test/test_async_driver_probe.c        |   2 +-
 drivers/block/drbd/drbd_main.c                     |   2 +-
 drivers/bluetooth/btintel.c                        |   6 +
 drivers/bluetooth/btrtl.c                          |  74 ++-
 drivers/bluetooth/btusb.c                          |   2 +-
 drivers/bluetooth/hci_nokia.c                      |   6 +-
 drivers/bus/ti-sysc.c                              |   2 +-
 drivers/char/hw_random/iproc-rng200.c              |  25 +
 drivers/char/hw_random/nomadik-rng.c               |  12 +-
 drivers/char/hw_random/pic32-rng.c                 |  19 +-
 drivers/char/ipmi/ipmi_si_intf.c                   |   5 +
 drivers/char/ipmi/ipmi_ssif.c                      |   7 +-
 drivers/char/tpm/tpm_crb.c                         |  33 +-
 drivers/clk/imx/clk-composite-8m.c                 |  12 +-
 drivers/clk/imx/clk-imx8mp.c                       |   5 -
 drivers/clk/imx/clk-imx8ulp.c                      |   2 +-
 drivers/clk/imx/clk-pllv4.c                        |  46 +-
 drivers/clk/imx/clk.h                              |   1 +
 drivers/clk/keystone/pll.c                         |   2 +-
 drivers/clk/qcom/Kconfig                           |   5 +
 drivers/clk/qcom/dispcc-sc8280xp.c                 |   8 +-
 drivers/clk/qcom/gcc-qdu1000.c                     |  33 +-
 drivers/clk/qcom/gcc-sc7180.c                      |   1 +
 drivers/clk/qcom/gcc-sc8280xp.c                    | 135 ++++-
 drivers/clk/qcom/gcc-sm6350.c                      |   1 +
 drivers/clk/qcom/gcc-sm7150.c                      |   1 +
 drivers/clk/qcom/gcc-sm8250.c                      |   1 +
 drivers/clk/qcom/gcc-sm8450.c                      |   4 +-
 drivers/clk/qcom/gpucc-sm6350.c                    |  18 +-
 drivers/clk/qcom/reset.c                           |   3 +-
 drivers/clk/rockchip/clk-rk3568.c                  |   2 +-
 drivers/clk/sunxi-ng/ccu_mmc_timing.c              |   2 +-
 drivers/counter/Kconfig                            |   2 +-
 drivers/cpufreq/amd-pstate-ut.c                    |  46 +-
 drivers/cpufreq/brcmstb-avs-cpufreq.c              |   6 +-
 drivers/cpufreq/cpufreq.c                          |   2 +
 drivers/cpufreq/intel_pstate.c                     |   5 +
 drivers/cpufreq/powernow-k8.c                      |   3 +-
 drivers/cpufreq/tegra194-cpufreq.c                 |  29 +
 drivers/cpuidle/cpuidle-pseries.c                  |   8 +-
 drivers/cpuidle/governors/teo.c                    |  40 +-
 drivers/crypto/caam/caampkc.c                      |   4 +-
 .../crypto/intel/qat/qat_4xxx/adf_4xxx_hw_data.c   |   9 +
 drivers/crypto/intel/qat/qat_common/adf_gen4_pm.h  |   2 +-
 drivers/crypto/intel/qat/qat_common/icp_qat_hw.h   |   5 +-
 drivers/crypto/stm32/stm32-hash.c                  |  11 +-
 drivers/devfreq/devfreq.c                          |   1 +
 drivers/dma/idxd/sysfs.c                           |  33 +-
 drivers/dma/ste_dma40.c                            |   4 +
 drivers/edac/i10nm_base.c                          |  54 +-
 drivers/edac/igen6_edac.c                          |   8 +-
 drivers/extcon/Kconfig                             |   1 +
 drivers/firmware/arm_sdei.c                        |  19 +
 drivers/firmware/cirrus/cs_dsp.c                   |   3 +-
 drivers/firmware/efi/libstub/x86-stub.c            |   2 +-
 drivers/firmware/meson/meson_sm.c                  |   2 +
 drivers/firmware/ti_sci.c                          |  36 +-
 drivers/fsi/fsi-master-aspeed.c                    |   2 +
 drivers/gpio/gpio-zynq.c                           |  26 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |   3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c            |  26 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c             |  22 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c            |  14 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h            |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h            |   3 +
 drivers/gpu/drm/amd/amdgpu/cik.c                   |  36 +-
 drivers/gpu/drm/amd/amdgpu/si.c                    |  36 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |  24 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c |  12 -
 .../drm/amd/display/dc/clk_mgr/dcn315/dcn315_smu.c |  20 +-
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c |   6 +
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c |   7 +
 .../gpu/drm/amd/display/dc/dcn301/dcn301_init.c    |   1 +
 drivers/gpu/drm/amd/pm/amdgpu_pm.c                 |  10 +-
 drivers/gpu/drm/armada/armada_overlay.c            |   6 +-
 drivers/gpu/drm/ast/ast_dp.c                       |  11 +
 drivers/gpu/drm/ast/ast_dp501.c                    |  37 +-
 drivers/gpu/drm/ast/ast_drv.h                      |   2 +
 drivers/gpu/drm/ast/ast_mode.c                     |  30 +-
 drivers/gpu/drm/bridge/adv7511/adv7511_drv.c       |   9 +-
 drivers/gpu/drm/bridge/analogix/anx7625.c          |  12 +-
 drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c      |  28 +-
 drivers/gpu/drm/bridge/tc358764.c                  |   2 +-
 drivers/gpu/drm/etnaviv/etnaviv_dump.c             |  14 +-
 drivers/gpu/drm/hyperv/hyperv_drm_drv.c            |   1 +
 drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c    |   2 +-
 drivers/gpu/drm/mediatek/mtk_dp.c                  |  15 +-
 drivers/gpu/drm/mediatek/mtk_drm_crtc.c            |   7 +-
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c        |  16 +-
 drivers/gpu/drm/mediatek/mtk_drm_drv.c             |   7 +-
 drivers/gpu/drm/mediatek/mtk_drm_gem.c             |   6 +-
 drivers/gpu/drm/msm/adreno/a2xx_gpu.c              |   8 +-
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c              |  11 +-
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c              |   2 -
 drivers/gpu/drm/msm/adreno/adreno_device.c         |   2 +-
 .../drm/msm/disp/dpu1/catalog/dpu_3_0_msm8998.h    |   9 +-
 .../gpu/drm/msm/disp/dpu1/catalog/dpu_4_0_sdm845.h |  25 +-
 .../gpu/drm/msm/disp/dpu1/catalog/dpu_5_0_sm8150.h |  29 +-
 .../drm/msm/disp/dpu1/catalog/dpu_5_1_sc8180x.h    |  39 +-
 .../gpu/drm/msm/disp/dpu1/catalog/dpu_6_0_sm8250.h |  29 +-
 .../gpu/drm/msm/disp/dpu1/catalog/dpu_6_2_sc7180.h |   2 +-
 .../gpu/drm/msm/disp/dpu1/catalog/dpu_6_3_sm6115.h |   2 +-
 .../gpu/drm/msm/disp/dpu1/catalog/dpu_6_4_sm6350.h |   8 +-
 .../drm/msm/disp/dpu1/catalog/dpu_6_5_qcm2290.h    |   2 +-
 .../gpu/drm/msm/disp/dpu1/catalog/dpu_6_9_sm6375.h |   8 +-
 .../gpu/drm/msm/disp/dpu1/catalog/dpu_7_0_sm8350.h |  33 +-
 .../gpu/drm/msm/disp/dpu1/catalog/dpu_7_2_sc7280.h |   9 +-
 .../drm/msm/disp/dpu1/catalog/dpu_8_0_sc8280xp.h   |  45 +-
 .../gpu/drm/msm/disp/dpu1/catalog/dpu_8_1_sm8450.h |  33 +-
 .../gpu/drm/msm/disp/dpu1/catalog/dpu_9_0_sm8550.h |  37 +-
 .../gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c    |   3 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c     |  57 +-
 drivers/gpu/drm/msm/disp/mdp5/mdp5_plane.c         |   3 +-
 drivers/gpu/drm/msm/disp/msm_disp_snapshot_util.c  |   2 +-
 drivers/gpu/drm/panel/panel-simple.c               |   4 +-
 drivers/gpu/drm/radeon/cik.c                       |  36 +-
 drivers/gpu/drm/radeon/si.c                        |  37 +-
 drivers/gpu/drm/tegra/dpaux.c                      |   2 +-
 drivers/gpu/drm/tiny/repaper.c                     |   2 +-
 drivers/gpu/drm/xlnx/zynqmp_dpsub.c                |   4 +-
 drivers/hid/hid-input.c                            |  18 +-
 drivers/hid/hid-logitech-dj.c                      |   5 +-
 drivers/hid/hid-logitech-hidpp.c                   | 115 ++--
 drivers/hid/hid-multitouch.c                       |  13 +-
 drivers/hid/hid-nvidia-shield.c                    |  15 +-
 drivers/hid/hid-uclogic-core.c                     |  13 +-
 drivers/hv/vmbus_drv.c                             |   3 +-
 drivers/hwmon/asus-ec-sensors.c                    |   2 +-
 drivers/hwmon/tmp513.c                             |   2 +-
 drivers/hwtracing/coresight/coresight-platform.c   |  44 +-
 drivers/hwtracing/coresight/coresight-tmc-etf.c    |   2 +-
 drivers/hwtracing/coresight/coresight-tmc-etr.c    |   5 +-
 drivers/hwtracing/coresight/coresight-tmc.h        |   2 +-
 drivers/hwtracing/coresight/coresight-trbe.c       |  43 +-
 drivers/i3c/master/svc-i3c-master.c                |  14 +-
 drivers/iio/accel/adxl313_i2c.c                    |   4 +-
 .../infiniband/core/uverbs_std_types_counters.c    |   2 +
 drivers/infiniband/hw/bnxt_re/bnxt_re.h            |  23 +-
 drivers/infiniband/hw/bnxt_re/main.c               | 107 +++-
 drivers/infiniband/hw/bnxt_re/qplib_res.h          |  19 +
 drivers/infiniband/hw/bnxt_re/qplib_sp.c           |   7 +-
 drivers/infiniband/hw/bnxt_re/qplib_sp.h           |   2 +-
 drivers/infiniband/hw/efa/efa_verbs.c              |   6 +-
 drivers/infiniband/hw/hns/hns_roce_device.h        |   1 +
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c         |  11 +-
 drivers/infiniband/hw/hns/hns_roce_main.c          |   7 +-
 drivers/infiniband/hw/hns/hns_roce_qp.c            |  28 +-
 drivers/infiniband/hw/irdma/ctrl.c                 |   6 +
 drivers/infiniband/hw/irdma/main.h                 |   2 +-
 drivers/infiniband/hw/irdma/type.h                 |   2 +
 drivers/infiniband/hw/irdma/verbs.c                |  11 +-
 drivers/infiniband/sw/rxe/rxe_comp.c               |   4 +
 drivers/infiniband/sw/rxe/rxe_loc.h                |   6 -
 drivers/infiniband/sw/rxe/rxe_qp.c                 | 159 +++--
 drivers/infiniband/sw/rxe/rxe_req.c                |  45 +-
 drivers/infiniband/sw/rxe/rxe_resp.c               |   4 +
 drivers/infiniband/sw/rxe/rxe_srq.c                |  60 +-
 drivers/infiniband/sw/siw/siw.h                    |   1 +
 drivers/infiniband/sw/siw/siw_cm.c                 |   1 -
 drivers/infiniband/sw/siw/siw_main.c               |  22 +-
 drivers/infiniband/sw/siw/siw_verbs.c              |   6 +-
 drivers/infiniband/ulp/isert/ib_isert.c            |   2 +
 drivers/infiniband/ulp/srp/ib_srp.c                |   4 -
 drivers/input/serio/i8042-acpipnpio.h              |   7 +
 drivers/interconnect/qcom/bcm-voter.c              |  43 +-
 drivers/interconnect/qcom/qcm2290.c                |   1 +
 drivers/interconnect/qcom/sm8450.c                 |   1 +
 drivers/iommu/amd/iommu_v2.c                       |   4 +-
 drivers/iommu/arm/arm-smmu/qcom_iommu.c            |   7 +
 drivers/iommu/intel/pasid.c                        |   2 +-
 drivers/iommu/iommu.c                              |   4 +-
 drivers/iommu/iommufd/device.c                     |   2 +-
 drivers/iommu/mtk_iommu.c                          |  22 +-
 drivers/iommu/rockchip-iommu.c                     |  43 +-
 drivers/iommu/sprd-iommu.c                         |   1 +
 drivers/irqchip/irq-loongson-eiointc.c             |   2 +-
 drivers/leds/led-class-multicolor.c                |   8 +-
 drivers/leds/led-core.c                            |   8 +-
 drivers/leds/leds-aw200xx.c                        |   2 +-
 drivers/leds/leds-pwm.c                            |   2 +-
 drivers/leds/simple/Kconfig                        |   1 +
 drivers/leds/trigger/ledtrig-tty.c                 |  12 +-
 drivers/md/md-bitmap.c                             |   9 +-
 drivers/md/md.c                                    |   6 +-
 drivers/md/raid0.c                                 |  82 +--
 drivers/md/raid1.c                                 |   8 +-
 drivers/md/raid10.c                                |  42 +-
 drivers/md/raid5-cache.c                           |  12 +-
 drivers/media/cec/core/cec-adap.c                  |   8 +-
 drivers/media/dvb-frontends/ascot2e.c              |   2 +-
 drivers/media/dvb-frontends/atbm8830.c             |   2 +-
 drivers/media/dvb-frontends/au8522_dig.c           |   2 +-
 drivers/media/dvb-frontends/bcm3510.c              |   2 +-
 drivers/media/dvb-frontends/cx22700.c              |   2 +-
 drivers/media/dvb-frontends/cx22702.c              |   2 +-
 drivers/media/dvb-frontends/cx24110.c              |   2 +-
 drivers/media/dvb-frontends/cx24113.c              |   2 +-
 drivers/media/dvb-frontends/cx24116.c              |   2 +-
 drivers/media/dvb-frontends/cx24120.c              |   6 +-
 drivers/media/dvb-frontends/cx24123.c              |   2 +-
 drivers/media/dvb-frontends/cxd2820r_core.c        |   2 +-
 drivers/media/dvb-frontends/cxd2841er.c            |   4 +-
 drivers/media/dvb-frontends/cxd2880/cxd2880_top.c  |   2 +-
 drivers/media/dvb-frontends/dib0070.c              |   2 +-
 drivers/media/dvb-frontends/dib0090.c              |   4 +-
 drivers/media/dvb-frontends/dib3000mb.c            |   2 +-
 drivers/media/dvb-frontends/dib3000mc.c            |   2 +-
 drivers/media/dvb-frontends/dib7000m.c             |   2 +-
 drivers/media/dvb-frontends/dib7000p.c             |   4 +-
 drivers/media/dvb-frontends/dib8000.c              |   2 +-
 drivers/media/dvb-frontends/dib9000.c              |   2 +-
 drivers/media/dvb-frontends/drx39xyj/drxj.c        |   2 +-
 drivers/media/dvb-frontends/drxd_hard.c            |   2 +-
 drivers/media/dvb-frontends/drxk_hard.c            |   2 +-
 drivers/media/dvb-frontends/ds3000.c               |   2 +-
 drivers/media/dvb-frontends/dvb-pll.c              |   2 +-
 drivers/media/dvb-frontends/ec100.c                |   2 +-
 drivers/media/dvb-frontends/helene.c               |   4 +-
 drivers/media/dvb-frontends/horus3a.c              |   2 +-
 drivers/media/dvb-frontends/isl6405.c              |   2 +-
 drivers/media/dvb-frontends/isl6421.c              |   2 +-
 drivers/media/dvb-frontends/isl6423.c              |   2 +-
 drivers/media/dvb-frontends/itd1000.c              |   2 +-
 drivers/media/dvb-frontends/ix2505v.c              |   2 +-
 drivers/media/dvb-frontends/l64781.c               |   2 +-
 drivers/media/dvb-frontends/lg2160.c               |   2 +-
 drivers/media/dvb-frontends/lgdt3305.c             |   2 +-
 drivers/media/dvb-frontends/lgdt3306a.c            |   2 +-
 drivers/media/dvb-frontends/lgdt330x.c             |   2 +-
 drivers/media/dvb-frontends/lgs8gxx.c              |   2 +-
 drivers/media/dvb-frontends/lnbh25.c               |   2 +-
 drivers/media/dvb-frontends/lnbp21.c               |   4 +-
 drivers/media/dvb-frontends/lnbp22.c               |   2 +-
 drivers/media/dvb-frontends/m88ds3103.c            |   2 +-
 drivers/media/dvb-frontends/m88rs2000.c            |   2 +-
 drivers/media/dvb-frontends/mb86a16.c              |   2 +-
 drivers/media/dvb-frontends/mb86a20s.c             |   2 +-
 drivers/media/dvb-frontends/mt312.c                |   2 +-
 drivers/media/dvb-frontends/mt352.c                |   2 +-
 drivers/media/dvb-frontends/nxt200x.c              |   2 +-
 drivers/media/dvb-frontends/nxt6000.c              |   2 +-
 drivers/media/dvb-frontends/or51132.c              |   2 +-
 drivers/media/dvb-frontends/or51211.c              |   2 +-
 drivers/media/dvb-frontends/s5h1409.c              |   2 +-
 drivers/media/dvb-frontends/s5h1411.c              |   2 +-
 drivers/media/dvb-frontends/s5h1420.c              |   2 +-
 drivers/media/dvb-frontends/s5h1432.c              |   2 +-
 drivers/media/dvb-frontends/s921.c                 |   2 +-
 drivers/media/dvb-frontends/si21xx.c               |   2 +-
 drivers/media/dvb-frontends/sp887x.c               |   2 +-
 drivers/media/dvb-frontends/stb0899_drv.c          |   2 +-
 drivers/media/dvb-frontends/stb6000.c              |   2 +-
 drivers/media/dvb-frontends/stb6100.c              |   2 +-
 drivers/media/dvb-frontends/stv0288.c              |   2 +-
 drivers/media/dvb-frontends/stv0297.c              |   2 +-
 drivers/media/dvb-frontends/stv0299.c              |   2 +-
 drivers/media/dvb-frontends/stv0367.c              |   6 +-
 drivers/media/dvb-frontends/stv0900_core.c         |   2 +-
 drivers/media/dvb-frontends/stv090x.c              |   2 +-
 drivers/media/dvb-frontends/stv6110.c              |   2 +-
 drivers/media/dvb-frontends/stv6110x.c             |   2 +-
 drivers/media/dvb-frontends/tda10021.c             |   2 +-
 drivers/media/dvb-frontends/tda10023.c             |   2 +-
 drivers/media/dvb-frontends/tda10048.c             |   2 +-
 drivers/media/dvb-frontends/tda1004x.c             |   4 +-
 drivers/media/dvb-frontends/tda10086.c             |   2 +-
 drivers/media/dvb-frontends/tda665x.c              |   2 +-
 drivers/media/dvb-frontends/tda8083.c              |   2 +-
 drivers/media/dvb-frontends/tda8261.c              |   2 +-
 drivers/media/dvb-frontends/tda826x.c              |   2 +-
 drivers/media/dvb-frontends/ts2020.c               |   2 +-
 drivers/media/dvb-frontends/tua6100.c              |   2 +-
 drivers/media/dvb-frontends/ves1820.c              |   2 +-
 drivers/media/dvb-frontends/ves1x93.c              |   2 +-
 drivers/media/dvb-frontends/zl10036.c              |   2 +-
 drivers/media/dvb-frontends/zl10039.c              |   2 +-
 drivers/media/dvb-frontends/zl10353.c              |   2 +-
 drivers/media/i2c/Kconfig                          |  13 +-
 drivers/media/i2c/ad5820.c                         |   2 -
 drivers/media/i2c/ccs/ccs-data.c                   | 101 ++--
 drivers/media/i2c/imx290.c                         |   7 +-
 drivers/media/i2c/ov2680.c                         | 330 +++-------
 drivers/media/i2c/ov5640.c                         |  22 +-
 drivers/media/i2c/rdacm21.c                        |   2 +-
 drivers/media/i2c/tvp5150.c                        |   4 +
 drivers/media/pci/Kconfig                          |   2 +-
 drivers/media/pci/bt8xx/dst.c                      |   2 +-
 drivers/media/pci/bt8xx/dst_ca.c                   |   2 +-
 drivers/media/pci/ddbridge/ddbridge-dummy-fe.c     |   2 +-
 drivers/media/pci/intel/Kconfig                    |  10 +
 drivers/media/pci/intel/Makefile                   |   4 +-
 .../pci/intel/{ipu3/cio2-bridge.c => ipu-bridge.c} | 192 +++---
 .../pci/intel/{ipu3/cio2-bridge.h => ipu-bridge.h} |  57 +-
 drivers/media/pci/intel/ipu3/Kconfig               |   1 +
 drivers/media/pci/intel/ipu3/Makefile              |   1 -
 drivers/media/pci/intel/ipu3/ipu3-cio2-main.c      |   4 +-
 drivers/media/pci/intel/ipu3/ipu3-cio2.h           |   6 -
 drivers/media/platform/amphion/vdec.c              |  41 +-
 drivers/media/platform/amphion/venc.c              |   6 +-
 drivers/media/platform/amphion/vpu.h               |   3 +
 drivers/media/platform/amphion/vpu_cmds.c          |  16 +-
 drivers/media/platform/amphion/vpu_core.c          |   2 +
 drivers/media/platform/amphion/vpu_dbg.c           |  17 +-
 drivers/media/platform/amphion/vpu_helpers.c       |  61 ++
 drivers/media/platform/amphion/vpu_msgs.c          |  14 +-
 drivers/media/platform/amphion/vpu_v4l2.c          |   7 +-
 .../media/platform/mediatek/jpeg/mtk_jpeg_core.c   |   1 +
 .../mediatek/vcodec/vdec/vdec_av1_req_lat_if.c     |  12 +-
 .../platform/mediatek/vcodec/vdec/vdec_vp9_if.c    |   5 +-
 .../platform/mediatek/vcodec/vdec_msg_queue.c      |   6 +-
 .../platform/nxp/imx8-isi/imx8-isi-crossbar.c      |   2 +-
 drivers/media/platform/qcom/venus/hfi_venus.c      |  20 +-
 drivers/media/platform/verisilicon/hantro_v4l2.c   |   9 +-
 drivers/media/tuners/fc0011.c                      |   2 +-
 drivers/media/tuners/fc0012.c                      |   2 +-
 drivers/media/tuners/fc0013.c                      |   2 +-
 drivers/media/tuners/max2165.c                     |   2 +-
 drivers/media/tuners/mc44s803.c                    |   2 +-
 drivers/media/tuners/mt2060.c                      |   2 +-
 drivers/media/tuners/mt2131.c                      |   2 +-
 drivers/media/tuners/mt2266.c                      |   2 +-
 drivers/media/tuners/mxl5005s.c                    |   2 +-
 drivers/media/tuners/qt1010.c                      |   2 +-
 drivers/media/tuners/tda18218.c                    |   2 +-
 drivers/media/tuners/xc2028.c                      |   2 +-
 drivers/media/tuners/xc4000.c                      |   2 +-
 drivers/media/tuners/xc5000.c                      |   2 +-
 drivers/media/usb/dvb-usb/m920x.c                  |   5 +-
 drivers/media/usb/go7007/go7007-i2c.c              |   2 -
 drivers/media/usb/siano/smsusb.c                   |  21 +-
 drivers/media/v4l2-core/v4l2-fwnode.c              |  18 +-
 drivers/mfd/Kconfig                                |   2 +-
 drivers/misc/fastrpc.c                             |  13 +-
 drivers/mmc/host/renesas_sdhi_core.c               |  10 +-
 drivers/mtd/nand/raw/brcmnand/brcmnand.c           |   7 +-
 drivers/mtd/nand/raw/fsmc_nand.c                   |   7 +-
 drivers/mtd/spi-nor/core.c                         |  19 +-
 drivers/net/arcnet/arcnet.c                        |   2 +-
 drivers/net/can/m_can/tcan4x5x-regmap.c            |   1 -
 drivers/net/can/usb/gs_usb.c                       |   5 +-
 drivers/net/ethernet/amd/pds_core/core.c           |  11 +-
 drivers/net/ethernet/amd/pds_core/dev.c            |   9 +-
 drivers/net/ethernet/amd/pds_core/devlink.c        |   3 +
 drivers/net/ethernet/broadcom/bnxt/bnxt_hsi.h      |  54 ++
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c      |   2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h      |   1 +
 drivers/net/ethernet/hisilicon/hns3/Makefile       |   4 +-
 drivers/net/ethernet/hisilicon/hns3/hnae3.h        |   1 +
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h |   4 +-
 .../ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c |   1 +
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    | 560 +----------------
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.h    |   2 -
 .../ethernet/hisilicon/hns3/hns3pf/hclge_regs.c    | 668 +++++++++++++++++++++
 .../ethernet/hisilicon/hns3/hns3pf/hclge_regs.h    |  17 +
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c  | 121 +---
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h  |   1 +
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_regs.c  | 127 ++++
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_regs.h  |  13 +
 drivers/net/ethernet/intel/ice/ice_main.c          |  13 +-
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c        |  55 +-
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h        |   3 +-
 drivers/net/ethernet/intel/igb/igb_main.c          |  11 +-
 drivers/net/ethernet/marvell/octeontx2/af/rpm.c    |  17 +-
 .../ethernet/marvell/octeontx2/nic/otx2_common.c   |   3 +-
 .../ethernet/marvell/octeontx2/nic/otx2_dcbnl.c    |  19 +-
 .../net/ethernet/marvell/octeontx2/nic/otx2_txrx.h |   2 +
 drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c |   9 +-
 .../net/ethernet/mellanox/mlx5/core/lib/clock.c    |  32 +-
 drivers/net/ethernet/mellanox/mlxsw/core_hwmon.c   |   3 +-
 drivers/net/ethernet/mellanox/mlxsw/i2c.c          |   5 +-
 .../net/ethernet/microchip/lan966x/lan966x_ptp.c   |   4 +-
 drivers/net/ethernet/realtek/r8169_main.c          |   4 -
 drivers/net/ethernet/sfc/ptp.c                     |   4 +-
 drivers/net/macsec.c                               |   3 +-
 drivers/net/pcs/pcs-lynx.c                         |   2 +-
 drivers/net/wireless/ath/ath10k/pci.c              |   9 +-
 drivers/net/wireless/ath/ath11k/dp_rx.c            |   2 +-
 drivers/net/wireless/ath/ath11k/pci.c              |  10 +-
 drivers/net/wireless/ath/ath12k/mac.c              |   4 +-
 drivers/net/wireless/ath/ath12k/pci.c              |  10 +-
 drivers/net/wireless/ath/ath9k/htc_drv_debug.c     |   2 +-
 drivers/net/wireless/ath/ath9k/wmi.c               |  20 +-
 drivers/net/wireless/marvell/mwifiex/debugfs.c     |   9 +-
 drivers/net/wireless/marvell/mwifiex/pcie.c        |  25 +-
 drivers/net/wireless/marvell/mwifiex/sta_rx.c      |  12 +-
 drivers/net/wireless/marvell/mwifiex/uap_txrx.c    |  30 +-
 drivers/net/wireless/marvell/mwifiex/util.c        |  10 +-
 drivers/net/wireless/mediatek/mt76/mt76.h          |   2 +-
 .../net/wireless/mediatek/mt76/mt76_connac_mac.c   |  11 +-
 .../net/wireless/mediatek/mt76/mt76_connac_mcu.h   |   1 +
 drivers/net/wireless/mediatek/mt76/mt7915/init.c   |   7 +-
 drivers/net/wireless/mediatek/mt76/mt7915/main.c   |  93 ++-
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c    | 105 +++-
 drivers/net/wireless/mediatek/mt76/mt7915/mmio.c   |  30 +-
 drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h |  15 +
 drivers/net/wireless/mediatek/mt76/mt7921/init.c   |   3 +-
 drivers/net/wireless/mediatek/mt76/mt7996/dma.c    |   2 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c    |  13 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c    |  11 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h |   1 +
 drivers/net/wireless/mediatek/mt76/testmode.c      |   1 +
 drivers/net/wireless/mediatek/mt76/tx.c            |   9 +-
 drivers/net/wireless/realtek/rtw89/debug.c         |   8 +-
 drivers/net/wireless/realtek/rtw89/fw.c            |  27 +-
 drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c  |   4 +-
 drivers/ntb/ntb_transport.c                        |  19 +-
 drivers/nvdimm/nd_perf.c                           |   3 +-
 drivers/nvdimm/nd_virtio.c                         |   3 +-
 drivers/of/overlay.c                               |   3 +-
 drivers/of/property.c                              |   2 +
 drivers/of/unittest.c                              |  12 +-
 drivers/opp/core.c                                 |  10 +-
 drivers/parisc/ccio-dma.c                          |  11 +-
 drivers/parisc/sba_iommu.c                         |   2 +-
 drivers/pci/access.c                               |  20 +-
 drivers/pci/controller/dwc/pci-layerscape-ep.c     |  19 +
 drivers/pci/controller/dwc/pcie-qcom-ep.c          |   2 +-
 drivers/pci/controller/dwc/pcie-tegra194.c         |  10 -
 drivers/pci/controller/pci-hyperv.c                |   3 +
 drivers/pci/controller/pcie-apple.c                |   6 +-
 drivers/pci/controller/pcie-microchip-host.c       |   8 +-
 drivers/pci/controller/pcie-rockchip.h             |   6 +-
 drivers/pci/doe.c                                  |   2 +-
 drivers/pci/hotplug/pciehp_hpc.c                   |  12 +-
 drivers/pci/pci.c                                  |  21 +-
 drivers/pci/pcie/aspm.c                            |  30 +-
 drivers/pci/probe.c                                |   2 +
 drivers/perf/fsl_imx8_ddr_perf.c                   |  24 +-
 drivers/phy/rockchip/phy-rockchip-inno-hdmi.c      |  18 +-
 drivers/pinctrl/mediatek/pinctrl-mt7981.c          |  44 +-
 drivers/pinctrl/mediatek/pinctrl-mt7986.c          |   8 +
 drivers/pinctrl/pinctrl-mcp23s08_spi.c             |  10 +
 drivers/platform/chrome/chromeos_acpi.c            |  31 +-
 drivers/platform/x86/amd/pmf/core.c                |   3 +-
 drivers/platform/x86/dell/dell-wmi-sysman/sysman.c |   9 +-
 drivers/power/supply/qcom_pmi8998_charger.c        |   3 +-
 drivers/powercap/arm_scmi_powercap.c               | 159 ++---
 drivers/powercap/intel_rapl_common.c               |   4 +-
 drivers/pwm/Kconfig                                |   2 +-
 drivers/remoteproc/stm32_rproc.c                   |  12 +-
 drivers/rpmsg/qcom_glink_native.c                  |   4 +
 drivers/s390/block/dasd_devmap.c                   |   6 +-
 drivers/s390/block/dasd_eckd.c                     |  10 +-
 drivers/s390/block/dasd_int.h                      |   4 +
 drivers/s390/block/dcssblk.c                       |   4 +-
 drivers/s390/crypto/pkey_api.c                     |  98 ++-
 drivers/s390/crypto/zcrypt_ep11misc.c              | 287 ++++++---
 drivers/s390/crypto/zcrypt_ep11misc.h              |  20 +-
 drivers/scsi/be2iscsi/be_iscsi.c                   |   4 +
 drivers/scsi/fcoe/fcoe_ctlr.c                      |  20 +-
 drivers/scsi/hisi_sas/hisi_sas_v2_hw.c             |  11 +-
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c             |   6 +-
 drivers/scsi/hosts.c                               |   4 +-
 drivers/scsi/mpt3sas/mpt3sas_base.c                |  46 +-
 drivers/scsi/mpt3sas/mpt3sas_base.h                |   1 +
 drivers/scsi/qedf/qedf_dbg.h                       |   2 +
 drivers/scsi/qedf/qedf_debugfs.c                   |  35 +-
 drivers/scsi/qla2xxx/qla_init.c                    |   2 +-
 drivers/scsi/qla4xxx/ql4_os.c                      |  15 +
 drivers/scsi/scsi_transport_iscsi.c                |  80 ++-
 drivers/soc/qcom/ocmem.c                           |   4 +-
 drivers/soc/qcom/smem.c                            |   2 +-
 drivers/spi/spi-mpc512x-psc.c                      |   2 +-
 drivers/spi/spi-tegra114.c                         |  18 +-
 drivers/spi/spi-tegra20-sflash.c                   |   6 +-
 drivers/staging/media/av7110/sp8870.c              |   2 +-
 drivers/staging/media/rkvdec/rkvdec.c              |   2 +-
 drivers/thermal/imx8mm_thermal.c                   |   6 +-
 drivers/thermal/mediatek/lvts_thermal.c            | 152 +++--
 drivers/thermal/thermal_of.c                       |   8 +-
 drivers/tty/serial/qcom_geni_serial.c              |   7 +-
 drivers/tty/serial/sc16is7xx.c                     | 145 +++--
 drivers/tty/serial/serial-tegra.c                  |   6 +-
 drivers/tty/serial/sprd_serial.c                   |  30 +-
 drivers/ufs/core/ufshcd.c                          |  12 +-
 drivers/usb/core/hcd.c                             |  10 +-
 drivers/usb/core/hub.c                             | 349 ++++++-----
 drivers/usb/core/message.c                         |  29 +-
 drivers/usb/core/usb.h                             |   4 +-
 drivers/usb/gadget/function/f_mass_storage.c       |   2 +-
 drivers/usb/gadget/udc/core.c                      |   1 +
 drivers/usb/phy/phy-mxs-usb.c                      |  10 +-
 drivers/usb/typec/bus.c                            |  12 +-
 drivers/usb/typec/tcpm/tcpm.c                      |  38 +-
 drivers/vfio/vfio_iommu_type1.c                    |   2 +-
 drivers/video/backlight/bd6107.c                   |   2 +-
 drivers/video/backlight/gpio_backlight.c           |   2 +-
 drivers/video/backlight/lv5207lp.c                 |   2 +-
 drivers/virtio/virtio_ring.c                       |   2 +-
 drivers/virtio/virtio_vdpa.c                       |  17 +-
 fs/btrfs/zoned.c                                   |  19 +-
 fs/dlm/plock.c                                     |   6 +-
 fs/erofs/zdata.c                                   |   5 +-
 fs/eventfd.c                                       |   2 +-
 fs/ext4/mballoc.c                                  |   7 +-
 fs/ext4/namei.c                                    |   3 +
 fs/f2fs/checkpoint.c                               |   2 +-
 fs/f2fs/debug.c                                    |  33 +-
 fs/f2fs/f2fs.h                                     |  72 ++-
 fs/f2fs/file.c                                     |  27 +-
 fs/f2fs/gc.c                                       |  18 +-
 fs/f2fs/inode.c                                    |  12 +-
 fs/f2fs/recovery.c                                 |   1 +
 fs/f2fs/segment.c                                  |  68 ++-
 fs/f2fs/super.c                                    |  41 +-
 fs/f2fs/sysfs.c                                    |  18 +-
 fs/fs_context.c                                    |  23 +-
 fs/fuse/file.c                                     |  89 +--
 fs/iomap/buffered-io.c                             |   5 -
 fs/jfs/jfs_extent.c                                |   5 +
 fs/lockd/mon.c                                     |   3 +
 fs/namei.c                                         |   2 +-
 fs/nfs/blocklayout/dev.c                           |   4 +-
 fs/nfs/internal.h                                  |   1 +
 fs/nfs/nfs2xdr.c                                   |   2 +-
 fs/nfs/nfs3xdr.c                                   |   2 +-
 fs/nfs/nfs42.h                                     |   1 +
 fs/nfs/nfs42proc.c                                 |   5 +-
 fs/nfs/nfs42xdr.c                                  |  17 +-
 fs/nfs/nfs4proc.c                                  |  13 +-
 fs/nfs/pnfs_nfs.c                                  |   2 +-
 fs/nfs/read.c                                      |  10 +
 fs/nfsd/blocklayoutxdr.c                           |   9 +
 fs/nfsd/flexfilelayoutxdr.c                        |   9 +
 fs/nfsd/nfs4xdr.c                                  |  25 +-
 fs/ocfs2/namei.c                                   |   4 +
 fs/proc/base.c                                     |   3 +-
 fs/pstore/ram_core.c                               |   2 +-
 fs/quota/dquot.c                                   | 174 ++++--
 fs/reiserfs/journal.c                              |   4 +-
 fs/splice.c                                        |  44 +-
 fs/verity/signature.c                              |  16 +
 include/crypto/algapi.h                            |   3 +
 include/dt-bindings/clock/qcom,gcc-sc8280xp.h      |  10 +
 include/linux/arm_sdei.h                           |   2 +
 include/linux/blkdev.h                             |   1 +
 include/linux/hid.h                                |   1 +
 include/linux/if_arp.h                             |   4 +
 include/linux/kernfs.h                             |   4 +
 include/linux/lsm_hook_defs.h                      |   1 +
 include/linux/memcontrol.h                         |   9 +-
 include/linux/mfd/rz-mtu3.h                        |  66 --
 include/linux/nmi.h                                |  14 +-
 include/linux/nvmem-consumer.h                     |   2 +-
 include/linux/pci.h                                |  34 +-
 include/linux/pid_namespace.h                      |  39 +-
 include/linux/security.h                           |   6 +
 include/linux/trace_events.h                       |   3 +-
 include/linux/usb/typec_altmode.h                  |   2 +-
 include/media/cec.h                                |  11 +-
 include/net/bluetooth/hci.h                        |  20 +
 include/net/bluetooth/hci_core.h                   |  67 ++-
 include/net/bluetooth/hci_sync.h                   |   2 +-
 include/net/inet6_hashtables.h                     |  72 ++-
 include/net/inet_hashtables.h                      |  67 ++-
 include/net/lwtunnel.h                             |   5 +-
 include/net/mac80211.h                             |   4 +-
 include/net/sock.h                                 |   7 +-
 include/net/tcp.h                                  |   1 -
 include/scsi/scsi_host.h                           |   2 +-
 include/sound/soc-dai.h                            |  13 +
 include/sound/ump.h                                |   1 +
 include/uapi/linux/bpf.h                           |   3 -
 include/uapi/linux/elf.h                           |   2 +
 include/uapi/linux/ioprio.h                        |  21 +-
 include/uapi/linux/sync_file.h                     |   2 +-
 include/ufs/ufs.h                                  |   6 +
 init/Kconfig                                       |   1 +
 io_uring/io-wq.c                                   |  19 +-
 io_uring/io-wq.h                                   |   3 +-
 io_uring/io_uring.c                                |  37 +-
 io_uring/io_uring.h                                |   1 -
 io_uring/net.c                                     |   4 +-
 io_uring/sqpoll.c                                  |  17 +
 io_uring/sqpoll.h                                  |   1 +
 kernel/auditsc.c                                   |   2 +
 kernel/bpf/btf.c                                   |  22 +-
 kernel/bpf/helpers.c                               |   2 +-
 kernel/bpf/verifier.c                              |  58 +-
 kernel/cgroup/cpuset.c                             |  33 +-
 kernel/cgroup/namespace.c                          |   6 -
 kernel/cpu.c                                       |  24 +-
 kernel/pid.c                                       |   3 +
 kernel/pid_namespace.c                             |   6 +-
 kernel/pid_sysctl.h                                |  28 +-
 kernel/printk/printk_ringbuffer.c                  |   2 +-
 kernel/rcu/refscale.c                              |   3 +-
 kernel/sched/fair.c                                |   3 -
 kernel/sched/rt.c                                  |   2 +-
 kernel/time/clocksource.c                          |   8 +-
 kernel/time/tick-sched.c                           |   2 +-
 kernel/trace/bpf_trace.c                           |   2 +-
 kernel/trace/trace.c                               |  17 +-
 kernel/trace/trace_hwlat.c                         |   2 +-
 kernel/trace/trace_uprobe.c                        |   3 +-
 kernel/watchdog.c                                  |  11 +-
 kernel/workqueue.c                                 |   2 +-
 lib/checksum_kunit.c                               |  54 +-
 lib/iov_iter.c                                     |  30 +-
 lib/nmi_backtrace.c                                |   6 +-
 lib/xarray.c                                       |   2 +-
 mm/memfd.c                                         |  56 +-
 mm/pagewalk.c                                      |   2 +-
 mm/shmem.c                                         |  28 +-
 mm/util.c                                          |   4 +-
 mm/vmalloc.c                                       |  26 +-
 mm/vmpressure.c                                    |   8 +
 mm/vmscan.c                                        |  18 +-
 net/bluetooth/hci_conn.c                           | 622 +++++++++----------
 net/bluetooth/hci_core.c                           |  28 +-
 net/bluetooth/hci_event.c                          | 133 ++--
 net/bluetooth/hci_sync.c                           | 188 ++++--
 net/bluetooth/iso.c                                |  78 ++-
 net/bluetooth/mgmt.c                               |  15 +-
 net/bluetooth/msft.c                               | 412 ++++++++++++-
 net/bluetooth/sco.c                                |   2 +-
 net/core/filter.c                                  |   4 +-
 net/core/lwt_bpf.c                                 |   7 +-
 net/core/skbuff.c                                  |  44 +-
 net/core/sock.c                                    |  18 +-
 net/dccp/ipv4.c                                    |  13 +-
 net/dccp/ipv6.c                                    |  15 +-
 net/ipv4/igmp.c                                    |   3 +-
 net/ipv4/inet_hashtables.c                         |  27 +-
 net/ipv4/ip_output.c                               |   2 +-
 net/ipv4/tcp_input.c                               |   3 +-
 net/ipv4/tcp_timer.c                               |  18 +-
 net/ipv4/udp.c                                     |  60 +-
 net/ipv6/inet6_hashtables.c                        |  25 +-
 net/ipv6/ip6_output.c                              |   2 +-
 net/ipv6/udp.c                                     |  66 +-
 net/mac80211/cfg.c                                 |  12 +-
 net/netfilter/ipset/ip_set_hash_netportnet.c       |   1 +
 net/netfilter/nft_exthdr.c                         |  20 +-
 net/netfilter/xt_sctp.c                            |   2 +
 net/netfilter/xt_u32.c                             |  21 +
 net/netrom/af_netrom.c                             |   5 +
 net/sched/em_meta.c                                |   2 +-
 net/sched/sch_hfsc.c                               |   4 +
 net/smc/af_smc.c                                   |   2 +-
 net/socket.c                                       |   6 +-
 net/sunrpc/svcsock.c                               |   4 +-
 net/wireless/nl80211.c                             |   1 +
 samples/bpf/tracex3_kern.c                         |  36 +-
 samples/bpf/tracex6_kern.c                         |  17 +-
 scripts/gdb/linux/constants.py.in                  |   3 +
 scripts/gdb/linux/modules.py                       |  12 +-
 scripts/rust_is_available.sh                       | 122 ++--
 security/integrity/ima/Kconfig                     |  12 -
 security/security.c                                |  14 +
 security/selinux/hooks.c                           |  22 +
 security/smack/smack_lsm.c                         |  51 ++
 security/smack/smackfs.c                           |   2 +-
 sound/Kconfig                                      |   2 +-
 sound/core/pcm_compat.c                            |   8 +-
 sound/core/seq/seq_memory.c                        |   9 +-
 sound/core/ump.c                                   |  58 +-
 sound/pci/ac97/ac97_codec.c                        |   5 +-
 sound/pci/hda/patch_cs8409.c                       |   2 +-
 sound/pci/hda/patch_cs8409.h                       |   1 +
 sound/soc/codecs/Kconfig                           |   1 +
 sound/soc/codecs/cs43130.h                         | 138 ++---
 sound/soc/fsl/fsl_asrc.c                           |  16 +-
 sound/soc/fsl/fsl_aud2htx.c                        |  10 +-
 sound/soc/fsl/fsl_easrc.c                          |  16 +-
 sound/soc/fsl/fsl_esai.c                           |  20 +-
 sound/soc/fsl/fsl_micfil.c                         |  14 +-
 sound/soc/fsl/fsl_qmc_audio.c                      |  28 +-
 sound/soc/fsl/fsl_sai.c                            |  24 +-
 sound/soc/fsl/fsl_spdif.c                          |  17 +-
 sound/soc/fsl/fsl_ssi.c                            |   3 +-
 sound/soc/fsl/fsl_xcvr.c                           |  16 +-
 sound/soc/generic/audio-graph-card.c               |   2 +-
 sound/soc/loongson/loongson_card.c                 |   2 +-
 sound/soc/pxa/mmp-sspa.c                           |   2 +-
 sound/soc/soc-compress.c                           |   1 +
 sound/soc/soc-core.c                               |  25 +
 sound/soc/soc-dai.c                                |  44 +-
 sound/soc/sof/amd/acp.c                            |   6 +-
 sound/soc/sof/intel/hda-mlink.c                    |  20 +-
 sound/usb/midi2.c                                  |  22 +-
 tools/bpf/bpftool/skeleton/pid_iter.bpf.c          |  26 +-
 tools/bpf/bpftool/skeleton/profiler.bpf.c          |  27 +-
 tools/include/nolibc/arch-aarch64.h                |   2 +-
 tools/include/nolibc/arch-arm.h                    |   2 +-
 tools/include/nolibc/arch-i386.h                   |   2 +-
 tools/include/nolibc/arch-loongarch.h              |   2 +-
 tools/include/nolibc/arch-mips.h                   |   2 +-
 tools/include/nolibc/arch-riscv.h                  |   2 +-
 tools/include/nolibc/arch-s390.h                   |   2 +-
 tools/include/nolibc/arch-x86_64.h                 |   2 +-
 tools/include/uapi/linux/bpf.h                     |   3 -
 tools/lib/bpf/libbpf.c                             |  46 +-
 tools/lib/bpf/usdt.c                               |   5 +-
 tools/testing/radix-tree/multiorder.c              |  68 ++-
 .../selftests/bpf/benchs/run_bench_rename.sh       |   2 +-
 tools/testing/selftests/bpf/prog_tests/bpf_nf.c    |   5 +-
 .../testing/selftests/bpf/prog_tests/kfunc_call.c  |   2 +-
 .../selftests/bpf/progs/test_cls_redirect.h        |   9 +
 .../futex/functional/futex_wait_timeout.c          |   7 +
 tools/testing/selftests/kselftest_harness.h        |  11 +-
 tools/testing/selftests/landlock/fs_test.c         |   8 +-
 tools/testing/selftests/memfd/memfd_test.c         |  40 +-
 tools/testing/selftests/resctrl/Makefile           |   2 +-
 tools/testing/selftests/resctrl/cache.c            |  18 +-
 tools/testing/selftests/resctrl/fill_buf.c         |   3 +-
 tools/testing/selftests/resctrl/resctrl.h          |   1 +
 virt/kvm/vfio.c                                    | 115 ++--
 889 files changed, 10463 insertions(+), 6112 deletions(-)


