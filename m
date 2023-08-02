Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1893976C746
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 09:44:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232918AbjHBHoI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 03:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbjHBHnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 03:43:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 784EF3C1E;
        Wed,  2 Aug 2023 00:41:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 030666184B;
        Wed,  2 Aug 2023 07:41:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B03DAC433C8;
        Wed,  2 Aug 2023 07:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690962107;
        bh=N+Hlq+JeC5gWQ4b+ZcyfoOXuGUJM2Ipzz2fkXFw4gGk=;
        h=From:To:Cc:Subject:Date:From;
        b=p4L0eohbHwXNCmkhvl6z2D4n69og70Nh+NfZ3z4OTHLPZhpXX7YqbBmI1IviqRiep
         4SlrY5A+gzq/b2sdr5WelXxI0q9mk9X1u1fSYRoDok0JQkERc/mAmgouh/AMxfyqz3
         js4aCGJiTJpDqYoLyUbqkXtnsJy6h5f6Rb9yDJkY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: [PATCH 5.15 000/153] 5.15.124-rc2 review
Date:   Wed,  2 Aug 2023 09:41:43 +0200
Message-ID: <20230802065452.161574662@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.124-rc2.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.15.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.15.124-rc2
X-KernelTest-Deadline: 2023-08-04T06:54+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 5.15.124 release.
There are 153 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Fri, 04 Aug 2023 06:54:22 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.124-rc2.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 5.15.124-rc2

Matthieu Baerts <matthieu.baerts@tessares.net>
    selftests: mptcp: join: only check for ip6tables if needed

Thomas Petazzoni <thomas.petazzoni@bootlin.com>
    ASoC: cs42l51: fix driver to properly autoload with automatic module loading

Jens Axboe <axboe@kernel.dk>
    io_uring: treat -EAGAIN for REQ_F_NOWAIT as final for io-wq

Matthieu Baerts <matthieu.baerts@tessares.net>
    selftests: mptcp: sockopt: use 'iptables-legacy' if available

Rafael J. Wysocki <rafael.j.wysocki@intel.com>
    cpufreq: intel_pstate: Drop ACPI _PSS states table patching

Rafael J. Wysocki <rafael.j.wysocki@intel.com>
    ACPI: processor: perflib: Avoid updating frequency QoS unnecessarily

Rafael J. Wysocki <rafael.j.wysocki@intel.com>
    ACPI: processor: perflib: Use the "no limit" frequency QoS

Steven Rostedt (Google) <rostedt@goodmis.org>
    tracing: Fix trace_event_raw_event_synth() if else statement

Ilya Dryomov <idryomov@gmail.com>
    rbd: retrieve and check lock owner twice before blocklisting

Ilya Dryomov <idryomov@gmail.com>
    rbd: harden get_lock_owner_info() a bit

Ilya Dryomov <idryomov@gmail.com>
    rbd: make get_lock_owner_info() return a single locker or NULL

Joe Thornber <ejt@redhat.com>
    dm cache policy smq: ensure IO doesn't prevent cleaner policy progress

Xiubo Li <xiubli@redhat.com>
    ceph: never send metrics if disable_send_metrics is set

Mark Brown <broonie@kernel.org>
    ASoC: wm8904: Fill the cache for WM8904_ADC_TEST_0 register

Stefan Haberland <sth@linux.ibm.com>
    s390/dasd: fix hanging device after quiesce/resume

Jason Wang <jasowang@redhat.com>
    virtio-net: fix race between set queues and probe

Sean Christopherson <seanjc@google.com>
    KVM: x86: Disallow KVM_SET_SREGS{2} if incoming CR0 is invalid

Peter Zijlstra <peterz@infradead.org>
    locking/rtmutex: Fix task->pi_waiters integrity

Marc Zyngier <maz@kernel.org>
    irqchip/gic-v4.1: Properly lock VPEs when doing a directLPI invalidation

Jonas Gorski <jonas.gorski@gmail.com>
    irq-bcm6345-l1: Do not assume a fixed block to cpu mapping

Alexander Steffen <Alexander.Steffen@infineon.com>
    tpm_tis: Explicitly check for error code

Trond Myklebust <trond.myklebust@hammerspace.com>
    nfsd: Remove incorrect check in nfsd4_validate_stateid

Christian Brauner <brauner@kernel.org>
    file: always lock position for FMODE_ATOMIC_POS

Filipe Manana <fdmanana@suse.com>
    btrfs: check for commit error at btrfs_attach_transaction_barrier()

Filipe Manana <fdmanana@suse.com>
    btrfs: check if the transaction was aborted at btrfs_wait_for_commit()

Gilles Buloz <Gilles.Buloz@kontron.com>
    hwmon: (nct7802) Fix for temp6 (PECI1) processed even if PECI1 disabled

Baskaran Kannan <Baski.Kannan@amd.com>
    hwmon: (k10temp) Enable AMD3255 Proc to show negative temperature

Luka Guzenko <l.guzenko@web.de>
    ALSA: hda/relatek: Enable Mute LED on HP 250 G8

Oliver Neukum <oneukum@suse.com>
    Revert "xhci: add quirk for host controllers that don't update endpoint DCS"

Chaoyuan Peng <hedonistsmith@gmail.com>
    tty: n_gsm: fix UAF in gsm_cleanup_mux

Zhang Shurong <zhang_shurong@foxmail.com>
    staging: ks7010: potential buffer overflow in ks_wlan_set_encode_ext()

Larry Finger <Larry.Finger@lwfinger.net>
    staging: r8712: Fix memory leak in _r8712_init_xmit_priv()

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Documentation: security-bugs.rst: clarify CVE handling

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Documentation: security-bugs.rst: update preferences when dealing with the linux-distros group

Dan Carpenter <dan.carpenter@linaro.org>
    Revert "usb: xhci: tegra: Fix error check"

Ricardo Ribalda <ribalda@chromium.org>
    usb: xhci-mtk: set the dma max_seg_size

Frank Li <Frank.Li@nxp.com>
    usb: cdns3: fix incorrect calculation of ep_buf_size when more than one config

Łukasz Bartosik <lb@semihalf.com>
    USB: quirks: add quirk for Focusrite Scarlett

Guiting Shen <aarongt.shen@gmail.com>
    usb: ohci-at91: Fix the unhandle interrupt when resume

Jisheng Zhang <jszhang@kernel.org>
    usb: dwc3: don't reset device side if dwc3 was configured as host-only

Gratian Crisan <gratian.crisan@ni.com>
    usb: dwc3: pci: skip BYT GPIO lookup table for hardwired phy

Jakub Vanek <linuxtardis@gmail.com>
    Revert "usb: dwc3: core: Enable AutoRetry feature in the controller"

Marc Kleine-Budde <mkl@pengutronix.de>
    can: gs_usb: gs_can_close(): add missing set of CAN state to CAN_STATE_STOPPED

Johan Hovold <johan@kernel.org>
    USB: serial: simple: sort driver entries

Oliver Neukum <oneukum@suse.com>
    USB: serial: simple: add Kaufmann RKS+CAN VCP

Mohsen Tahmasebi <moh53n@moh53n.ir>
    USB: serial: option: add Quectel EC200A module support

Jerry Meng <jerry-meng@foxmail.com>
    USB: serial: option: support Quectel EM060K_128

Samuel Holland <samuel.holland@sifive.com>
    serial: sifive: Fix sifive_serial_console_setup() section

Ruihong Luo <colorsu1922@gmail.com>
    serial: 8250_dw: Preserve original value of DLF register

Johan Hovold <johan+linaro@kernel.org>
    serial: qcom-geni: drop bogus runtime pm state update

Sean Christopherson <seanjc@google.com>
    KVM: VMX: Don't fudge CR0 and CR4 for restricted L2 guest

Sean Christopherson <seanjc@google.com>
    KVM: Grab a reference to KVM for VM and vCPU stats file descriptors

Zqiang <qiang.zhang1211@gmail.com>
    USB: gadget: Fix the memory leak in raw_gadget driver

Frank Li <Frank.Li@nxp.com>
    usb: gadget: call usb_gadget_check_config() to verify UDC capability

Dan Carpenter <dan.carpenter@linaro.org>
    Revert "usb: gadget: tegra-xudc: Fix error check in tegra_xudc_powerdomain_init()"

Zheng Yejian <zhengyejian1@huawei.com>
    tracing: Fix warning in trace_buffered_event_disable()

Zheng Yejian <zhengyejian1@huawei.com>
    ring-buffer: Fix wrong stat of cpu_buffer->read

Arnd Bergmann <arnd@arndb.de>
    ata: pata_ns87415: mark ns87560_tf_read static

Sindhu Devale <sindhu.devale@intel.com>
    RDMA/irdma: Report correct WC error

Mario Limonciello <mario.limonciello@amd.com>
    drm/amd: Fix an error handling mistake in psp_sw_init()

Yu Kuai <yukuai3@huawei.com>
    dm raid: protect md_stop() with 'reconfig_mutex'

Yu Kuai <yukuai3@huawei.com>
    dm raid: clean up four equivalent goto tags in raid_ctr()

Yu Kuai <yukuai3@huawei.com>
    dm raid: fix missing reconfig_mutex unlock in raid_ctr() error paths

Bart Van Assche <bvanassche@acm.org>
    block: Fix a source code comment in include/uapi/linux/blkzoned.h

Matus Gajdos <matuszpd@gmail.com>
    ASoC: fsl_spdif: Silence output on stop

Gaosheng Cui <cuigaosheng1@huawei.com>
    drm/msm: Fix IS_ERR_OR_NULL() vs NULL check in a5xx_submit_in_rb()

Kashyap Desai <kashyap.desai@broadcom.com>
    RDMA/bnxt_re: Prevent handling any completions after qp destroy

Thomas Bogendoerfer <tbogendoerfer@suse.de>
    RDMA/mthca: Fix crash when polling CQ for shared QPs

Shiraz Saleem <shiraz.saleem@intel.com>
    RDMA/irdma: Fix data race on CQP request done

Shiraz Saleem <shiraz.saleem@intel.com>
    RDMA/irdma: Fix data race on CQP completion stats

Shiraz Saleem <shiraz.saleem@intel.com>
    RDMA/irdma: Add missing read barriers

Rob Clark <robdclark@chromium.org>
    drm/msm/adreno: Fix snapshot BINDLESS_DATA size

Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
    drm/msm/dpu: drop enum dpu_core_perf_data_bus_id

Dan Carpenter <dan.carpenter@linaro.org>
    RDMA/mlx4: Make check for invalid flags stricter

Fedor Pchelkin <pchelkin@ispras.ru>
    tipc: stop tipc crypto on failure in tipc_node_create

Yuanjun Gong <ruc_gongyuanjun@163.com>
    tipc: check return value of pskb_trim()

Yuanjun Gong <ruc_gongyuanjun@163.com>
    benet: fix return value check in be_lancer_xmit_workarounds()

Lin Ma <linma@zju.edu.cn>
    net/sched: mqprio: Add length check for TCA_MQPRIO_{MAX/MIN}_RATE64

Vladimir Oltean <vladimir.oltean@nxp.com>
    net/sched: mqprio: add extack to mqprio_parse_nlattr()

Vladimir Oltean <vladimir.oltean@nxp.com>
    net/sched: mqprio: refactor nlattr parsing to a separate function

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: disallow rule addition to bound chain via NFTA_RULE_CHAIN_ID

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: skip immediate deactivate in _PREPARE_ERROR

Florian Westphal <fw@strlen.de>
    netfilter: nft_set_rbtree: fix overlap expiration walk

Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
    igc: Fix Kernel Panic during ndo_tx_timeout callback

Maxim Mikityanskiy <maxtram95@gmail.com>
    platform/x86: msi-laptop: Fix rfkill out-of-sync on MSI Wind U100

Vincent Whitchurch <vincent.whitchurch@axis.com>
    net: stmmac: Apply redundant write work around on 4.xx too

Hangbin Liu <liuhangbin@gmail.com>
    team: reset team's flags when down link is P2P device

Hangbin Liu <liuhangbin@gmail.com>
    bonding: reset bond's flags when down link is P2P device

Jedrzej Jagielski <jedrzej.jagielski@intel.com>
    ice: Fix memory management in ice_ethtool_fdir.c

Stewart Smith <trawets@amazon.com>
    tcp: Reduce chance of collisions in inet6_hashfn().

Maciej Żenczykowski <maze@google.com>
    ipv6 addrconf: fix bug where deleting a mngtmpaddr can create a new temporary address

Yuanjun Gong <ruc_gongyuanjun@163.com>
    ethernet: atheros: fix return value check in atl1e_tso_csum()

Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
    phy: hisilicon: Fix an out of bounds check in hisi_inno_phy_probe()

Jiri Benc <jbenc@redhat.com>
    vxlan: calculate correct header length for GPE

Roopa Prabhu <roopa@nvidia.com>
    vxlan: move to its own directory

Jijie Shao <shaojijie@huawei.com>
    net: hns3: fix wrong bw weight of disabled tc issue

Jijie Shao <shaojijie@huawei.com>
    net: hns3: fix wrong tc bandwidth weight data issue

Jiawen Wu <jiawenwu@trustnetic.com>
    net: phy: marvell10g: fix 88x3310 power up

Jacob Keller <jacob.e.keller@intel.com>
    iavf: check for removal state before IAVF_FLAG_PF_COMMS_FAILED

Jacob Keller <jacob.e.keller@intel.com>
    iavf: fix potential deadlock on allocation failure

Wang Ming <machel@vivo.com>
    i40e: Fix an NULL vs IS_ERR() bug for debugfs_create_dir()

Sakari Ailus <sakari.ailus@linux.intel.com>
    media: staging: atomisp: select V4L2_FWNODE

Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
    soundwire: qcom: update status correctly with mask

Adrien Thierry <athierry@redhat.com>
    phy: qcom-snps-femto-v2: properly enable ref clock

Adrien Thierry <athierry@redhat.com>
    phy: qcom-snps-femto-v2: keep cfg_ahb_clk enabled during runtime suspend

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    phy: qcom-snps: correct struct qcom_snps_hsphy kerneldoc

Yuan Can <yuancan@huawei.com>
    phy: qcom-snps: Use dev_err_probe() to simplify code

Guchun Chen <guchun.chen@amd.com>
    drm/amdgpu/vkms: relax timer deactivation by hrtimer_try_to_cancel

Flora Cui <flora.cui@amd.com>
    drm/amdgpu: fix vkms crtc settings

Quinn Tran <qutran@marvell.com>
    scsi: qla2xxx: Fix hang in task management

Arun Easi <aeasi@marvell.com>
    scsi: qla2xxx: Add debug prints in the device remove path

Quinn Tran <qutran@marvell.com>
    scsi: qla2xxx: Fix task management cmd fail due to unavailable resource

Quinn Tran <qutran@marvell.com>
    scsi: qla2xxx: Fix task management cmd failure

Quinn Tran <qutran@marvell.com>
    scsi: qla2xxx: Multi-que support for TMF

Gaosheng Cui <cuigaosheng1@huawei.com>
    scsi: qla2xxx: Remove unused declarations for qla2xxx

Masami Hiramatsu (Google) <mhiramat@kernel.org>
    tracing/probes: Fix to record 0-length data_loc in fetch_store_string*() if fails

Masami Hiramatsu (Google) <mhiramat@kernel.org>
    Revert "tracing: Add "(fault)" name injection to kernel probes"

Steven Rostedt (Google) <rostedt@goodmis.org>
    tracing: Allow synthetic events to pass around stacktraces

Masami Hiramatsu (Google) <mhiramat@kernel.org>
    tracing/probes: Fix to avoid double count of the string length on the array

Masami Hiramatsu (Google) <mhiramat@kernel.org>
    tracing/probes: Add symstr type for dynamic events

Heiner Kallweit <hkallweit1@gmail.com>
    pwm: meson: fix handling of period/duty if greater than UINT_MAX

Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
    pwm: meson: Simplify duplicated per-channel tracking

Bharath SM <bharathsm@microsoft.com>
    cifs: if deferred close is disabled then close files immediately

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: remove internal.h include

Paulo Alcantara <pc@cjr.nz>
    cifs: use fs_context for automounts

Steve French <stfrench@microsoft.com>
    cifs: missing directory in MAINTAINERS file

Christian König <christian.koenig@amd.com>
    drm/ttm: never consider pinned BOs for eviction&swap

Hui Li <caelli@tencent.com>
    tty: fix hang on tty device with no_room set

Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
    n_tty: Rename tail to old_tail in n_tty_read()

Thomas Hellström <thomas.hellstrom@linux.intel.com>
    drm/ttm: Don't leak a resource on eviction error

Thomas Hellström <thomas.hellstrom@linux.intel.com>
    drm/ttm: Don't print error message if eviction was interrupted

Alexander Aring <aahringo@redhat.com>
    fs: dlm: interrupt posix locks only when process is killed

Alexander Aring <aahringo@redhat.com>
    dlm: rearrange async condition return

Alexander Aring <aahringo@redhat.com>
    dlm: cleanup plock_op vs plock_xop

Rick Wertenbroek <rick.wertenbroek@gmail.com>
    PCI: rockchip: Don't advertise MSI-X in PCIe capabilities

Rick Wertenbroek <rick.wertenbroek@gmail.com>
    PCI: rockchip: Fix window mapping and address translation for endpoint

Rick Wertenbroek <rick.wertenbroek@gmail.com>
    PCI: rockchip: Remove writes to unused registers

Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
    PCI/ASPM: Avoid link retraining race

Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
    PCI/ASPM: Factor out pcie_wait_for_retrain()

Bjorn Helgaas <bhelgaas@google.com>
    PCI/ASPM: Return 0 or -ETIMEDOUT from pcie_retrain_link()

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    i2c: nomadik: Remove a useless call in the remove function

Andi Shyti <andi.shyti@kernel.org>
    i2c: nomadik: Use devm_clk_get_enabled()

Andi Shyti <andi.shyti@kernel.org>
    i2c: nomadik: Remove unnecessary goto label

Markus Elfring <elfring@users.sourceforge.net>
    i2c: Improve size determinations

Markus Elfring <elfring@users.sourceforge.net>
    i2c: Delete error messages for failed memory allocations

Filipe Manana <fdmanana@suse.com>
    btrfs: fix race between quota disable and relocation

Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
    gpio: mvebu: fix irq domain leak

Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
    gpio: mvebu: Make use of devm_pwmchip_add

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    pwm: Add a stub for devm_pwmchip_add()

Hans de Goede <hdegoede@redhat.com>
    gpio: tps68470: Make tps68470_gpio_output() always set the initial value

Ondrej Mosnacek <omosnace@redhat.com>
    io_uring: don't audit the capability check in io_uring_create()

Claudio Imbrenda <imbrenda@linux.ibm.com>
    KVM: s390: pv: fix index value of replaced ASCE

Zhihao Cheng <chengzhihao1@huawei.com>
    jbd2: Fix wrongly judgement for buffer head removing while doing checkpoint


-------------

Diffstat:

 Documentation/admin-guide/security-bugs.rst        |  37 ++-
 Documentation/trace/kprobetrace.rst                |   8 +-
 MAINTAINERS                                        |   1 +
 Makefile                                           |   4 +-
 arch/s390/mm/gmap.c                                |   1 +
 arch/x86/include/asm/kvm-x86-ops.h                 |   1 +
 arch/x86/include/asm/kvm_host.h                    |   3 +-
 arch/x86/kvm/svm/svm.c                             |   6 +
 arch/x86/kvm/vmx/vmx.c                             |  41 +++-
 arch/x86/kvm/x86.c                                 |  34 ++-
 drivers/acpi/processor_perflib.c                   |  42 +++-
 drivers/ata/pata_ns87415.c                         |   2 +-
 drivers/block/rbd.c                                | 124 +++++++---
 drivers/char/tpm/tpm_tis_core.c                    |  10 +-
 drivers/cpufreq/intel_pstate.c                     |  14 --
 drivers/gpio/gpio-mvebu.c                          |  26 ++-
 drivers/gpio/gpio-tps68470.c                       |   6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c            |   6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c           |  45 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.h           |   5 +-
 drivers/gpu/drm/msm/adreno/a5xx_gpu.c              |   2 +-
 drivers/gpu/drm/msm/adreno/a6xx_gpu_state.h        |   2 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.h      |  13 --
 drivers/gpu/drm/ttm/ttm_bo.c                       |  25 +-
 drivers/hwmon/k10temp.c                            |  17 +-
 drivers/hwmon/nct7802.c                            |   2 +-
 drivers/i2c/busses/i2c-ibm_iic.c                   |   4 +-
 drivers/i2c/busses/i2c-nomadik.c                   |  42 +---
 drivers/i2c/busses/i2c-sh7760.c                    |   3 +-
 drivers/i2c/busses/i2c-tiny-usb.c                  |   4 +-
 drivers/infiniband/hw/bnxt_re/ib_verbs.c           |  12 +
 drivers/infiniband/hw/bnxt_re/qplib_fp.c           |  18 ++
 drivers/infiniband/hw/bnxt_re/qplib_fp.h           |   1 +
 drivers/infiniband/hw/irdma/ctrl.c                 |  31 ++-
 drivers/infiniband/hw/irdma/defs.h                 |  46 ++--
 drivers/infiniband/hw/irdma/hw.c                   |   3 +-
 drivers/infiniband/hw/irdma/main.h                 |   2 +-
 drivers/infiniband/hw/irdma/puda.c                 |   6 +
 drivers/infiniband/hw/irdma/type.h                 |   2 +
 drivers/infiniband/hw/irdma/uk.c                   |   3 +
 drivers/infiniband/hw/irdma/utils.c                |   8 +-
 drivers/infiniband/hw/mlx4/qp.c                    |  18 +-
 drivers/infiniband/hw/mthca/mthca_qp.c             |   2 +-
 drivers/irqchip/irq-bcm6345-l1.c                   |  14 +-
 drivers/irqchip/irq-gic-v3-its.c                   |  75 +++---
 drivers/md/dm-cache-policy-smq.c                   |  28 ++-
 drivers/md/dm-raid.c                               |  20 +-
 drivers/md/md.c                                    |   2 +
 drivers/net/Makefile                               |   2 +-
 drivers/net/bonding/bond_main.c                    |   5 +
 drivers/net/can/usb/gs_usb.c                       |   2 +
 drivers/net/ethernet/atheros/atl1e/atl1e_main.c    |   7 +-
 drivers/net/ethernet/emulex/benet/be_main.c        |   3 +-
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c |  17 +-
 .../ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c |   3 +-
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c  |   3 +-
 drivers/net/ethernet/intel/i40e/i40e_debugfs.c     |   2 +-
 drivers/net/ethernet/intel/iavf/iavf_main.c        |  11 +-
 drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c  |  26 ++-
 drivers/net/ethernet/intel/igc/igc_main.c          |  40 +++-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c      |   2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac4_lib.c   |   4 +-
 drivers/net/phy/marvell10g.c                       |   7 +
 drivers/net/team/team.c                            |   9 +
 drivers/net/virtio_net.c                           |   4 +-
 drivers/net/vxlan/Makefile                         |   7 +
 drivers/net/{vxlan.c => vxlan/vxlan_core.c}        |  23 +-
 drivers/pci/controller/pcie-rockchip-ep.c          | 156 ++++++-------
 drivers/pci/controller/pcie-rockchip.h             |  40 ++--
 drivers/pci/pcie/aspm.c                            |  55 +++--
 drivers/phy/hisilicon/phy-hisi-inno-usb2.c         |   2 +-
 drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c      |  86 ++++---
 drivers/platform/x86/msi-laptop.c                  |   8 +-
 drivers/pwm/pwm-meson.c                            |  25 +-
 drivers/s390/block/dasd_ioctl.c                    |   1 +
 drivers/scsi/qla2xxx/qla_attr.c                    |   3 +
 drivers/scsi/qla2xxx/qla_def.h                     |  27 +++
 drivers/scsi/qla2xxx/qla_gbl.h                     |  14 +-
 drivers/scsi/qla2xxx/qla_init.c                    | 256 +++++++++++++++++++--
 drivers/scsi/qla2xxx/qla_iocb.c                    |  33 ++-
 drivers/scsi/qla2xxx/qla_isr.c                     |  26 ++-
 drivers/scsi/qla2xxx/qla_target.h                  |   2 -
 drivers/soundwire/qcom.c                           |   2 +-
 drivers/staging/ks7010/ks_wlan_net.c               |   6 +-
 drivers/staging/media/atomisp/Kconfig              |   1 +
 drivers/staging/rtl8712/rtl871x_xmit.c             |  43 +++-
 drivers/staging/rtl8712/xmit_linux.c               |   6 +
 drivers/tty/n_gsm.c                                |   4 +-
 drivers/tty/n_tty.c                                |  29 ++-
 drivers/tty/serial/8250/8250_dwlib.c               |   6 +-
 drivers/tty/serial/qcom_geni_serial.c              |   7 -
 drivers/tty/serial/sifive.c                        |   2 +-
 drivers/usb/cdns3/cdns3-gadget.c                   |   4 +-
 drivers/usb/core/quirks.c                          |   4 +
 drivers/usb/dwc3/core.c                            |  20 +-
 drivers/usb/dwc3/core.h                            |   3 -
 drivers/usb/dwc3/dwc3-pci.c                        |   6 +-
 drivers/usb/gadget/composite.c                     |   4 +
 drivers/usb/gadget/legacy/raw_gadget.c             |  12 +-
 drivers/usb/gadget/udc/tegra-xudc.c                |   8 +-
 drivers/usb/host/ohci-at91.c                       |   8 +-
 drivers/usb/host/xhci-mtk.c                        |   1 +
 drivers/usb/host/xhci-pci.c                        |   4 +-
 drivers/usb/host/xhci-ring.c                       |  25 +-
 drivers/usb/host/xhci-tegra.c                      |   8 +-
 drivers/usb/serial/option.c                        |   6 +
 drivers/usb/serial/usb-serial-simple.c             |  73 +++---
 fs/btrfs/qgroup.c                                  |  18 +-
 fs/btrfs/transaction.c                             |  10 +-
 fs/ceph/metric.c                                   |   2 +-
 fs/cifs/cifs_dfs_ref.c                             | 100 ++++----
 fs/cifs/file.c                                     |   4 +-
 fs/dlm/plock.c                                     | 100 ++++----
 fs/file.c                                          |   6 +-
 fs/internal.h                                      |   2 -
 fs/jbd2/checkpoint.c                               |  32 +--
 fs/ksmbd/vfs.c                                     |   2 -
 fs/nfsd/nfs4state.c                                |   2 -
 include/linux/namei.h                              |   2 +
 include/linux/pwm.h                                |   5 +
 include/net/ipv6.h                                 |   8 +-
 include/net/vxlan.h                                |  13 +-
 include/uapi/linux/blkzoned.h                      |  10 +-
 io_uring/io_uring.c                                |  10 +-
 kernel/locking/rtmutex.c                           | 172 +++++++++-----
 kernel/locking/rtmutex_api.c                       |   2 +-
 kernel/locking/rtmutex_common.h                    |  47 ++--
 kernel/locking/ww_mutex.h                          |  12 +-
 kernel/trace/ring_buffer.c                         |  22 +-
 kernel/trace/trace.c                               |   2 +-
 kernel/trace/trace.h                               |   6 +
 kernel/trace/trace_events.c                        |  14 +-
 kernel/trace/trace_events_hist.c                   |   7 +-
 kernel/trace/trace_events_synth.c                  |  80 ++++++-
 kernel/trace/trace_probe.c                         |  46 ++--
 kernel/trace/trace_probe.h                         |  16 +-
 kernel/trace/trace_probe_kernel.h                  |  30 +--
 kernel/trace/trace_probe_tmpl.h                    |  59 ++++-
 kernel/trace/trace_synth.h                         |   1 +
 kernel/trace/trace_uprobe.c                        |   3 +-
 net/ceph/messenger.c                               |   1 +
 net/ipv6/addrconf.c                                |  14 +-
 net/netfilter/nf_tables_api.c                      |   5 +-
 net/netfilter/nft_immediate.c                      |  27 ++-
 net/netfilter/nft_set_rbtree.c                     |  20 +-
 net/sched/sch_mqprio.c                             | 144 ++++++++----
 net/tipc/crypto.c                                  |   3 +-
 net/tipc/node.c                                    |   2 +-
 sound/pci/hda/patch_realtek.c                      |   1 +
 sound/soc/codecs/cs42l51-i2c.c                     |   6 +
 sound/soc/codecs/cs42l51.c                         |   7 -
 sound/soc/codecs/cs42l51.h                         |   1 -
 sound/soc/codecs/wm8904.c                          |   3 +
 sound/soc/fsl/fsl_spdif.c                          |   2 +
 tools/testing/selftests/net/mptcp/mptcp_join.sh    |   5 +-
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh |  20 +-
 virt/kvm/kvm_main.c                                |  24 ++
 157 files changed, 2032 insertions(+), 1122 deletions(-)


