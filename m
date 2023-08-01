Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D44A76ADB9
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 11:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233055AbjHAJcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 05:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbjHAJbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 05:31:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84A014690;
        Tue,  1 Aug 2023 02:30:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9268E614BB;
        Tue,  1 Aug 2023 09:30:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45202C433C8;
        Tue,  1 Aug 2023 09:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690882217;
        bh=OZkkEDSbOA9RAh/i+FjTNhJS67KOkMsUci9DVYz0eis=;
        h=From:To:Cc:Subject:Date:From;
        b=yC0EKoBZjtsWvGqKGWhcct6acRu7P0kNJn+H0wrkiDXk2RJjsXdooLmp2xl2T4ArO
         uz18jptWgBdGotBdK457sgNtbZQI1bE48UWb45Gpt/L0qyhqQp7Y0jhq4sXw1E0SSV
         R/W0Wr1MuD6r3DEJPPrpUfyE+FsyCqWwn905sTd0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: [PATCH 6.1 000/228] 6.1.43-rc1 review
Date:   Tue,  1 Aug 2023 11:17:38 +0200
Message-ID: <20230801091922.799813980@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.43-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.1.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.1.43-rc1
X-KernelTest-Deadline: 2023-08-03T09:19+00:00
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

This is the start of the stable review cycle for the 6.1.43 release.
There are 228 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Thu, 03 Aug 2023 09:18:38 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.43-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 6.1.43-rc1

Dan Carpenter <dan.carpenter@linaro.org>
    dma-buf: fix an error pointer vs NULL bug

Christian König <christian.koenig@amd.com>
    dma-buf: keep the signaling time of merged fences v3

Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
    test_firmware: return ENOMEM instead of ENOSPC on failed memory allocation

Matthieu Baerts <matthieu.baerts@tessares.net>
    selftests: mptcp: sockopt: use 'iptables-legacy' if available

Paolo Abeni <pabeni@redhat.com>
    mptcp: ensure subflow is unhashed before cleaning the backlog

Rafael J. Wysocki <rafael.j.wysocki@intel.com>
    cpufreq: intel_pstate: Drop ACPI _PSS states table patching

Rafael J. Wysocki <rafael.j.wysocki@intel.com>
    ACPI: processor: perflib: Avoid updating frequency QoS unnecessarily

Rafael J. Wysocki <rafael.j.wysocki@intel.com>
    ACPI: processor: perflib: Use the "no limit" frequency QoS

Benjamin Cheng <ben@bcheng.me>
    drm/amd/display: Write to correct dirty_rect

Hamza Mahfooz <hamza.mahfooz@amd.com>
    drm/amd/display: perform a bounds check before filling dirty rectangles

Steven Rostedt (Google) <rostedt@goodmis.org>
    tracing: Fix trace_event_raw_event_synth() if else statement

Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
    drm/amd/display: set per pipe dppclk to 0 when dpp is off

Ilya Dryomov <idryomov@gmail.com>
    rbd: retrieve and check lock owner twice before blocklisting

Ilya Dryomov <idryomov@gmail.com>
    rbd: harden get_lock_owner_info() a bit

Ilya Dryomov <idryomov@gmail.com>
    rbd: make get_lock_owner_info() return a single locker or NULL

Joe Thornber <ejt@redhat.com>
    dm cache policy smq: ensure IO doesn't prevent cleaner policy progress

Radhakrishna Sripada <radhakrishna.sripada@intel.com>
    drm/i915/dpt: Use shmem for dpt objects

Xiubo Li <xiubli@redhat.com>
    ceph: never send metrics if disable_send_metrics is set

Johan Hovold <johan+linaro@kernel.org>
    PM: sleep: wakeirq: fix wake irq arming

Mark Brown <broonie@kernel.org>
    arm64/sme: Set new vector length before reallocating

Mark Brown <broonie@kernel.org>
    ASoC: wm8904: Fill the cache for WM8904_ADC_TEST_0 register

Stefan Haberland <sth@linux.ibm.com>
    s390/dasd: print copy pair message only for the correct error

Stefan Haberland <sth@linux.ibm.com>
    s390/dasd: fix hanging device after quiesce/resume

Chenguang Zhao <zhaochenguang@kylinos.cn>
    LoongArch: BPF: Enable bpf_probe_read{, str}() on LoongArch

Tiezhu Yang <yangtiezhu@loongson.cn>
    LoongArch: BPF: Fix check condition to call lu32id in move_imm()

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    Revert "um: Use swap() to make code cleaner"

Johan Hovold <johan+linaro@kernel.org>
    soundwire: fix enumeration completion

Matthieu Baerts <matthieu.baerts@tessares.net>
    selftests: mptcp: join: only check for ip6tables if needed

Sean Christopherson <seanjc@google.com>
    selftests/rseq: Play nice with binaries statically linked against glibc 2.35+

Christian Marangi <ansuelsmth@gmail.com>
    net: dsa: qca8k: fix mdb add/del case with 0 VID

Christian Marangi <ansuelsmth@gmail.com>
    net: dsa: qca8k: fix broken search_and_del

Christian Marangi <ansuelsmth@gmail.com>
    net: dsa: qca8k: fix search_and_insert wrong handling of new rule

Jason Wang <jasowang@redhat.com>
    virtio-net: fix race between set queues and probe

Demi Marie Obenour <demi@invisiblethingslab.com>
    xen: speed up grant-table reclaim

Dan Carpenter <dan.carpenter@linaro.org>
    proc/vmcore: fix signedness bug in read_from_oldmem()

Peter Zijlstra <peterz@infradead.org>
    locking/rtmutex: Fix task->pi_waiters integrity

Marc Zyngier <maz@kernel.org>
    irqchip/gic-v4.1: Properly lock VPEs when doing a directLPI invalidation

Jonas Gorski <jonas.gorski@gmail.com>
    irq-bcm6345-l1: Do not assume a fixed block to cpu mapping

Alexander Steffen <Alexander.Steffen@infineon.com>
    tpm_tis: Explicitly check for error code

Guanghui Feng <guanghuifeng@linux.alibaba.com>
    ACPI/IORT: Remove erroneous id_count check in iort_node_get_rmr_info()

Trond Myklebust <trond.myklebust@hammerspace.com>
    nfsd: Remove incorrect check in nfsd4_validate_stateid

Christian Brauner <brauner@kernel.org>
    file: always lock position for FMODE_ATOMIC_POS

Yazen Ghannam <yazen.ghannam@amd.com>
    x86/MCE/AMD: Decrement threshold_bank refcount when removing threshold blocks

Filipe Manana <fdmanana@suse.com>
    btrfs: check for commit error at btrfs_attach_transaction_barrier()

Filipe Manana <fdmanana@suse.com>
    btrfs: check if the transaction was aborted at btrfs_wait_for_commit()

Filipe Manana <fdmanana@suse.com>
    btrfs: account block group tree when calculating global reserve size

Gilles Buloz <Gilles.Buloz@kontron.com>
    hwmon: (nct7802) Fix for temp6 (PECI1) processed even if PECI1 disabled

Baskaran Kannan <Baski.Kannan@amd.com>
    hwmon: (k10temp) Enable AMD3255 Proc to show negative temperature

Luka Guzenko <l.guzenko@web.de>
    ALSA: hda/relatek: Enable Mute LED on HP 250 G8

Pavel Asyutchenko <svenpavel@gmail.com>
    ALSA: hda/realtek: Support ASUS G713PV laptop

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

Xu Yang <xu.yang_2@nxp.com>
    usb: misc: ehset: fix wrong if condition

Jisheng Zhang <jszhang@kernel.org>
    usb: dwc3: don't reset device side if dwc3 was configured as host-only

Gratian Crisan <gratian.crisan@ni.com>
    usb: dwc3: pci: skip BYT GPIO lookup table for hardwired phy

Jakub Vanek <linuxtardis@gmail.com>
    Revert "usb: dwc3: core: Enable AutoRetry feature in the controller"

Kyle Tso <kyletso@google.com>
    usb: typec: Use sysfs_emit_at when concatenating the string

Kyle Tso <kyletso@google.com>
    usb: typec: Iterate pds array when showing the pd list

Kyle Tso <kyletso@google.com>
    usb: typec: Set port->pd before adding device for typec_port

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
    KVM: x86: Disallow KVM_SET_SREGS{2} if incoming CR0 is invalid

Sean Christopherson <seanjc@google.com>
    KVM: VMX: Don't fudge CR0 and CR4 for restricted L2 guest

Sean Christopherson <seanjc@google.com>
    KVM: Grab a reference to KVM for VM and vCPU stats file descriptors

Michael Grzeschik <m.grzeschik@pengutronix.de>
    usb: gadget: core: remove unbalanced mutex_unlock in usb_gadget_activate

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

Ming Lei <ming.lei@redhat.com>
    ublk: fail to recover device if queue setup is interrupted

Ming Lei <ming.lei@redhat.com>
    ublk: fail to start device if queue setup is interrupted

Ming Lei <ming.lei@redhat.com>
    ublk_drv: move ublk_get_device_from_id into ublk_ctrl_uring_cmd

Rob Clark <robdclark@chromium.org>
    drm/msm: Disallow submit with fence id 0

Rob Clark <robdclark@chromium.org>
    drm/msm: Switch idr_lock to spinlock

Sindhu Devale <sindhu.devale@intel.com>
    RDMA/irdma: Report correct WC error

Sindhu Devale <sindhu.devale@intel.com>
    RDMA/irdma: Fix op_type reporting in CQEs

Dan Carpenter <dan.carpenter@linaro.org>
    drm/amd/display: Unlock on error path in dm_handle_mst_sideband_msg_ready_event()

Mario Limonciello <mario.limonciello@amd.com>
    drm/amd: Fix an error handling mistake in psp_sw_init()

Yu Kuai <yukuai3@huawei.com>
    dm raid: protect md_stop() with 'reconfig_mutex'

Yu Kuai <yukuai3@huawei.com>
    dm raid: clean up four equivalent goto tags in raid_ctr()

Yu Kuai <yukuai3@huawei.com>
    dm raid: fix missing reconfig_mutex unlock in raid_ctr() error paths

Stefano Stabellini <sstabellini@kernel.org>
    xenbus: check xen_domain in xenbus_probe_initcall

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    drm/i915: Fix an error handling path in igt_write_huge()

Steve French <stfrench@microsoft.com>
    smb3: do not set NTLMSSP_VERSION flag for negotiate not auth request

Bart Van Assche <bvanassche@acm.org>
    block: Fix a source code comment in include/uapi/linux/blkzoned.h

Matus Gajdos <matuszpd@gmail.com>
    ASoC: fsl_spdif: Silence output on stop

Breno Leitao <leitao@debian.org>
    cxl/acpi: Return 'rc' instead of '0' in cxl_parse_cfmws()

Breno Leitao <leitao@debian.org>
    cxl/acpi: Fix a use-after-free in cxl_parse_cfmws()

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

Linus Torvalds <torvalds@linux-foundation.org>
    mm: suppress mm fault logging if fatal signal already pending

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: disallow rule addition to bound chain via NFTA_RULE_CHAIN_ID

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: skip immediate deactivate in _PREPARE_ERROR

Florian Westphal <fw@strlen.de>
    netfilter: nft_set_rbtree: fix overlap expiration walk

Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
    igc: Fix Kernel Panic during ndo_tx_timeout callback

Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
    x86/traps: Fix load_unaligned_zeropad() handling for shared TDX memory

Maxim Mikityanskiy <maxtram95@gmail.com>
    platform/x86: msi-laptop: Fix rfkill out-of-sync on MSI Wind U100

Vincent Whitchurch <vincent.whitchurch@axis.com>
    net: stmmac: Apply redundant write work around on 4.xx too

Suman Ghosh <sumang@marvell.com>
    octeontx2-af: Fix hash extraction enable configuration

Sunil Goutham <sgoutham@marvell.com>
    octeontx2-af: Removed unnecessary debug messages.

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

Yuanjun Gong <ruc_gongyuanjun@163.com>
    atheros: fix return value check in atl1_tso()

Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
    phy: hisilicon: Fix an out of bounds check in hisi_inno_phy_probe()

Jiri Benc <jbenc@redhat.com>
    vxlan: fix GRO with VXLAN-GPE

Jiri Benc <jbenc@redhat.com>
    vxlan: generalize vxlan_parse_gpe_hdr and remove unused args

Jiri Benc <jbenc@redhat.com>
    vxlan: calculate correct header length for GPE

Jijie Shao <shaojijie@huawei.com>
    net: hns3: fix wrong bw weight of disabled tc issue

Jijie Shao <shaojijie@huawei.com>
    net: hns3: fix wrong tc bandwidth weight data issue

Hao Lan <lanhao@huawei.com>
    net: hns3: fix the imp capability bit cannot exceed 32 bits issue

Jiawen Wu <jiawenwu@trustnetic.com>
    net: phy: marvell10g: fix 88x3310 power up

Jacob Keller <jacob.e.keller@intel.com>
    iavf: check for removal state before IAVF_FLAG_PF_COMMS_FAILED

Jacob Keller <jacob.e.keller@intel.com>
    iavf: fix potential deadlock on allocation failure

Wang Ming <machel@vivo.com>
    i40e: Fix an NULL vs IS_ERR() bug for debugfs_create_dir()

Nicolas Dufresne <nicolas.dufresne@collabora.com>
    media: amphion: Fix firmware path to match linux-firmware

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

Dan Carpenter <dan.carpenter@linaro.org>
    phy: phy-mtk-dp: Fix an error code in probe()

Zhang Yi <yi.zhang@huawei.com>
    jbd2: fix a race when checking checkpoint buffer busy

Zhang Yi <yi.zhang@huawei.com>
    jbd2: remove journal_clean_one_cp_list()

Zhang Yi <yi.zhang@huawei.com>
    jbd2: remove t_checkpoint_io_list

Daniel Miess <daniel.miess@amd.com>
    drm/amd/display: Prevent vtotal from being set to 0

Daniel Miess <daniel.miess@amd.com>
    drm/amd/display: Fix possible underflow for displays with large vblank

Gabe Teeger <gabe.teeger@amd.com>
    drm/amd/display: update extended blank for dcn314 onwards

Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
    drm/amd/display: Add FAMS validation before trying to use it

Randy Dunlap <rdunlap@infradead.org>
    drm/amd/display: fix dc/core/dc.c kernel-doc

Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
    drm/amd/display: Rework comments on dc file

Liam R. Howlett <Liam.Howlett@oracle.com>
    maple_tree: fix 32 bit mas_next testing

Liam R. Howlett <Liam.Howlett@oracle.com>
    maple_tree: add __init and __exit to test module

Liam R. Howlett <Liam.Howlett@Oracle.com>
    test_maple_tree: test modifications while iterating

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

Paolo Abeni <pabeni@redhat.com>
    mptcp: do not rely on implicit state check in mptcp_listen()

Menglong Dong <imagedong@tencent.com>
    mptcp: introduce 'sk' to replace 'sock->sk' in mptcp_listen()

Oliver Upton <oliver.upton@linux.dev>
    arm64: errata: Mitigate Ampere1 erratum AC03_CPU_38 at stage-2

Oliver Upton <oliver.upton@linux.dev>
    KVM: arm64: Condition HW AF updates on config option

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

Mario Limonciello <mario.limonciello@amd.com>
    drm/amd/display: Set minimum requirement for using PSR-SU on Phoenix

Mario Limonciello <mario.limonciello@amd.com>
    drm/amd/display: Set minimum requirement for using PSR-SU on Rembrandt

Cruise Hung <cruise.hung@amd.com>
    drm/amd/display: Update correct DCN314 register header

Dmytro Laktyushkin <dmytro.laktyushkin@amd.com>
    drm/amd/display: fix dcn315 single stream crb allocation

Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
    drm/amd/display: add pixel rate based CRB allocation support

Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
    drm/amd/display: fix unbounded requesting for high pixel rate modes on dcn315

Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
    drm/amd/display: use low clocks for no plane configs

Samson Tam <samson.tam@amd.com>
    drm/amd/display: add ODM case when looking for first split pipe

Alvin Lee <Alvin.Lee2@amd.com>
    drm/amd/display: Use min transition for all SubVP plane add/remove

Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
    drm/amd/display: Include surface of unaffected streams

Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
    drm/amd/display: Copy DC context in the commit streams

Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
    drm/amd/display: Enable new commit sequence only for DCN32x

Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
    drm/amd/display: Rework context change check

Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
    drm/amd/display: Check if link state is valid

Hamza Mahfooz <hamza.mahfooz@amd.com>
    drm/amd/display: add FB_DAMAGE_CLIPS support

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

Huacai Chen <chenhuacai@kernel.org>
    MIPS: Loongson: Fix build error when make modules_install

Jiaxun Yang <jiaxun.yang@flygoat.com>
    MIPS: Loongson: Move arch cflags to MIPS top level Makefile

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

Chao Yu <chao@kernel.org>
    f2fs: don't reset unchangable mount option in f2fs_remount()

Yangtao Li <frank.li@vivo.com>
    f2fs: fix to set flush_merge opt and show noflush_merge

Filipe Manana <fdmanana@suse.com>
    btrfs: fix race between quota disable and relocation

Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
    gpio: mvebu: fix irq domain leak

Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
    gpio: mvebu: Make use of devm_pwmchip_add

Hans de Goede <hdegoede@redhat.com>
    gpio: tps68470: Make tps68470_gpio_output() always set the initial value

Ondrej Mosnacek <omosnace@redhat.com>
    io_uring: don't audit the capability check in io_uring_create()

Claudio Imbrenda <imbrenda@linux.ibm.com>
    KVM: s390: pv: fix index value of replaced ASCE

Haren Myneni <haren@linux.ibm.com>
    powerpc/pseries/vas: Hold mmap_mutex after mmap lock during window close

Ross Lagerwall <ross.lagerwall@citrix.com>
    blk-mq: Fix stall due to recursive flush plug

Zhihao Cheng <chengzhihao1@huawei.com>
    jbd2: Fix wrongly judgement for buffer head removing while doing checkpoint

Mario Limonciello <mario.limonciello@amd.com>
    drm/amd: Align SMU11 SMU_MSG_OverridePcieParameters implementation with SMU13

Mario Limonciello <mario.limonciello@amd.com>
    drm/amd: Move helper for dynamic speed switch check out of smu13

Zhihao Cheng <chengzhihao1@huawei.com>
    ovl: fix null pointer dereference in ovl_permission()

Agustin Gutierrez <agustin.gutierrez@amd.com>
    drm/amd/display: Keep PHY active for dp config

Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
    platform/x86/amd/pmf: reduce verbosity of apmf_get_system_params

Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
    platform/x86/amd/pmf: Notify OS power slider update

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: fix underflow in chain reference counter

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: fix underflow in object reference counter


-------------

Diffstat:

 Documentation/ABI/testing/sysfs-module             |  11 +
 Documentation/admin-guide/security-bugs.rst        |  37 +--
 Documentation/arm64/silicon-errata.rst             |   3 +
 Documentation/trace/kprobetrace.rst                |   8 +-
 Makefile                                           |   4 +-
 arch/arm64/Kconfig                                 |  19 ++
 arch/arm64/kernel/cpu_errata.c                     |   7 +
 arch/arm64/kernel/fpsimd.c                         |   4 +-
 arch/arm64/kvm/hyp/pgtable.c                       |  16 +-
 arch/arm64/tools/cpucaps                           |   1 +
 arch/loongarch/Kconfig                             |   1 +
 arch/loongarch/net/bpf_jit.h                       |   2 +-
 arch/mips/Makefile                                 |  34 ++
 arch/mips/loongson2ef/Platform                     |  35 ---
 arch/mips/loongson64/Platform                      |  16 -
 arch/powerpc/platforms/pseries/vas.c               |   9 +-
 arch/s390/mm/gmap.c                                |   1 +
 arch/um/os-Linux/sigio.c                           |   7 +-
 arch/x86/include/asm/kvm-x86-ops.h                 |   1 +
 arch/x86/include/asm/kvm_host.h                    |   3 +-
 arch/x86/kernel/cpu/mce/amd.c                      |   4 +-
 arch/x86/kernel/traps.c                            |  18 +-
 arch/x86/kvm/svm/svm.c                             |   6 +
 arch/x86/kvm/vmx/vmx.c                             |  41 ++-
 arch/x86/kvm/x86.c                                 |  34 +-
 block/blk-core.c                                   |   3 +-
 block/blk-mq.c                                     |   9 +-
 drivers/acpi/arm64/iort.c                          |   3 -
 drivers/acpi/processor_perflib.c                   |  42 ++-
 drivers/ata/pata_ns87415.c                         |   2 +-
 drivers/base/power/power.h                         |   1 +
 drivers/base/power/wakeirq.c                       |  12 +-
 drivers/block/rbd.c                                | 124 +++++---
 drivers/block/ublk_drv.c                           | 145 ++++-----
 drivers/char/tpm/tpm_tis_core.c                    |   9 +-
 drivers/cpufreq/intel_pstate.c                     |  14 -
 drivers/cxl/acpi.c                                 |   5 +-
 drivers/dma-buf/dma-fence-unwrap.c                 |  26 +-
 drivers/dma-buf/dma-fence.c                        |   7 +-
 drivers/gpio/gpio-mvebu.c                          |  26 +-
 drivers/gpio/gpio-tps68470.c                       |   6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu.h                |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |  19 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c            |   6 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  | 121 ++++---
 .../amd/display/amdgpu_dm/amdgpu_dm_mst_types.c    |   2 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c    |   4 +
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c  |   3 +-
 .../amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c |   5 +
 drivers/gpu/drm/amd/display/dc/core/dc.c           | 348 +++++++++++++--------
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c  |  20 ++
 drivers/gpu/drm/amd/display/dc/dc.h                |  64 ++--
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c       |   7 +
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h       |   1 +
 drivers/gpu/drm/amd/display/dc/dc_stream.h         |   5 +
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c |   4 +-
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c  |   7 +-
 .../gpu/drm/amd/display/dc/dcn31/dcn31_hubbub.c    |   1 +
 .../drm/amd/display/dc/dcn315/dcn315_resource.c    | 110 ++++++-
 .../gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c   |  23 +-
 .../gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c   |  49 ++-
 .../gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.h   |   4 +
 .../amd/display/dc/dml/dcn31/display_mode_vba_31.c |  39 ++-
 .../display/dc/dml/dcn31/display_rq_dlg_calc_31.c  |   3 +-
 .../gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c |  15 +-
 .../dc/dml/dcn314/display_rq_dlg_calc_314.c        |  16 +-
 .../gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c   |  19 +-
 .../drm/amd/display/dc/dml/display_mode_structs.h  |   3 +-
 .../gpu/drm/amd/display/dc/dml/display_mode_vba.c  |   6 +
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h        |   2 +
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h    |   2 +-
 drivers/gpu/drm/amd/display/dmub/src/Makefile      |   2 +-
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c  |   5 +
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.h  |   2 +
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn314.c |  67 ++++
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn314.h |  35 +++
 drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c    |  12 +-
 .../drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c    |  89 ++----
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c     |  21 +-
 drivers/gpu/drm/drm_syncobj.c                      |   6 +-
 drivers/gpu/drm/i915/display/intel_dpt.c           |   4 +-
 drivers/gpu/drm/i915/gem/selftests/huge_pages.c    |   6 +-
 drivers/gpu/drm/msm/adreno/a5xx_gpu.c              |   2 +-
 drivers/gpu/drm/msm/adreno/a6xx_gpu_state.h        |   2 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.h      |  13 -
 drivers/gpu/drm/msm/msm_drv.c                      |   6 +-
 drivers/gpu/drm/msm/msm_gem_submit.c               |  12 +-
 drivers/gpu/drm/msm/msm_gpu.h                      |   2 +-
 drivers/gpu/drm/msm/msm_submitqueue.c              |   2 +-
 drivers/gpu/drm/ttm/ttm_bo.c                       |  25 +-
 drivers/hwmon/k10temp.c                            |  17 +-
 drivers/hwmon/nct7802.c                            |   2 +-
 drivers/i2c/busses/i2c-ibm_iic.c                   |   4 +-
 drivers/i2c/busses/i2c-nomadik.c                   |  42 +--
 drivers/i2c/busses/i2c-sh7760.c                    |   3 +-
 drivers/i2c/busses/i2c-tiny-usb.c                  |   4 +-
 drivers/infiniband/hw/bnxt_re/ib_verbs.c           |  12 +
 drivers/infiniband/hw/bnxt_re/qplib_fp.c           |  18 ++
 drivers/infiniband/hw/bnxt_re/qplib_fp.h           |   1 +
 drivers/infiniband/hw/irdma/ctrl.c                 |  31 +-
 drivers/infiniband/hw/irdma/defs.h                 |  46 ++-
 drivers/infiniband/hw/irdma/hw.c                   |   3 +-
 drivers/infiniband/hw/irdma/main.h                 |   2 +-
 drivers/infiniband/hw/irdma/puda.c                 |   6 +
 drivers/infiniband/hw/irdma/type.h                 |   2 +
 drivers/infiniband/hw/irdma/uk.c                   |   5 +-
 drivers/infiniband/hw/irdma/utils.c                |   8 +-
 drivers/infiniband/hw/mlx4/qp.c                    |  18 +-
 drivers/infiniband/hw/mthca/mthca_qp.c             |   2 +-
 drivers/irqchip/irq-bcm6345-l1.c                   |  14 +-
 drivers/irqchip/irq-gic-v3-its.c                   |  75 +++--
 drivers/md/dm-cache-policy-smq.c                   |  28 +-
 drivers/md/dm-raid.c                               |  20 +-
 drivers/md/md.c                                    |   2 +
 drivers/media/platform/amphion/vpu_core.c          |   4 +-
 drivers/net/bonding/bond_main.c                    |   5 +
 drivers/net/can/usb/gs_usb.c                       |   2 +
 drivers/net/dsa/qca/qca8k-common.c                 |  19 +-
 drivers/net/ethernet/atheros/atl1e/atl1e_main.c    |   7 +-
 drivers/net/ethernet/atheros/atlx/atl1.c           |   7 +-
 drivers/net/ethernet/emulex/benet/be_main.c        |   3 +-
 drivers/net/ethernet/hisilicon/hns3/hnae3.h        |   3 +-
 .../hisilicon/hns3/hns3_common/hclge_comm_cmd.c    |  21 +-
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c |  17 +-
 .../ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c |   3 +-
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c  |   3 +-
 drivers/net/ethernet/intel/i40e/i40e_debugfs.c     |   2 +-
 drivers/net/ethernet/intel/iavf/iavf_main.c        |  11 +-
 drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c  |  26 +-
 drivers/net/ethernet/intel/igc/igc_main.c          |  40 ++-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c      |   2 +-
 .../ethernet/marvell/octeontx2/af/rvu_npc_hash.c   |  59 +++-
 .../ethernet/marvell/octeontx2/af/rvu_npc_hash.h   |   8 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac4_lib.c   |   4 +-
 drivers/net/phy/marvell10g.c                       |   7 +
 drivers/net/team/team.c                            |   9 +
 drivers/net/virtio_net.c                           |   4 +-
 drivers/net/vxlan/vxlan_core.c                     | 165 ++++++----
 drivers/pci/controller/pcie-rockchip-ep.c          | 156 +++++----
 drivers/pci/controller/pcie-rockchip.h             |  40 ++-
 drivers/pci/pcie/aspm.c                            |  55 ++--
 drivers/phy/hisilicon/phy-hisi-inno-usb2.c         |   2 +-
 drivers/phy/mediatek/phy-mtk-dp.c                  |   2 +-
 drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c      |  74 +++--
 drivers/platform/x86/amd/pmf/acpi.c                |  23 +-
 drivers/platform/x86/amd/pmf/core.c                |   9 +-
 drivers/platform/x86/amd/pmf/pmf.h                 |  16 +
 drivers/platform/x86/amd/pmf/sps.c                 |  74 ++++-
 drivers/platform/x86/msi-laptop.c                  |   8 +-
 drivers/s390/block/dasd_3990_erp.c                 |   2 +-
 drivers/s390/block/dasd_ioctl.c                    |   1 +
 drivers/soundwire/bus.c                            |   8 +-
 drivers/soundwire/qcom.c                           |   2 +-
 drivers/staging/ks7010/ks_wlan_net.c               |   6 +-
 drivers/staging/media/atomisp/Kconfig              |   1 +
 drivers/staging/rtl8712/rtl871x_xmit.c             |  43 ++-
 drivers/staging/rtl8712/xmit_linux.c               |   6 +
 drivers/tty/n_gsm.c                                |   4 +-
 drivers/tty/n_tty.c                                |  29 +-
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
 drivers/usb/gadget/udc/core.c                      |   1 -
 drivers/usb/gadget/udc/tegra-xudc.c                |   8 +-
 drivers/usb/host/ohci-at91.c                       |   8 +-
 drivers/usb/host/xhci-mtk.c                        |   1 +
 drivers/usb/host/xhci-pci.c                        |   4 +-
 drivers/usb/host/xhci-ring.c                       |  25 +-
 drivers/usb/host/xhci-tegra.c                      |   8 +-
 drivers/usb/misc/ehset.c                           |   8 +-
 drivers/usb/serial/option.c                        |   6 +
 drivers/usb/serial/usb-serial-simple.c             |  73 +++--
 drivers/usb/typec/class.c                          |  15 +-
 drivers/xen/grant-table.c                          |  40 ++-
 drivers/xen/xenbus/xenbus_probe.c                  |   3 +
 fs/btrfs/block-rsv.c                               |   5 +
 fs/btrfs/qgroup.c                                  |  18 +-
 fs/btrfs/transaction.c                             |  10 +-
 fs/ceph/metric.c                                   |   2 +-
 fs/f2fs/super.c                                    |  43 ++-
 fs/file.c                                          |   6 +-
 fs/jbd2/checkpoint.c                               | 197 +++++-------
 fs/jbd2/commit.c                                   |   3 +-
 fs/jbd2/transaction.c                              |  17 +-
 fs/nfsd/nfs4state.c                                |   2 -
 fs/overlayfs/inode.c                               |   5 +-
 fs/proc/vmcore.c                                   |   2 +-
 fs/smb/client/sess.c                               |   4 +-
 include/linux/dma-fence.h                          |   2 +-
 include/linux/jbd2.h                               |   7 +-
 include/net/ipv6.h                                 |   8 +-
 include/net/vxlan.h                                |  13 +-
 include/trace/events/jbd2.h                        |  12 +-
 include/uapi/linux/blkzoned.h                      |  10 +-
 io_uring/io_uring.c                                |   2 +-
 kernel/locking/rtmutex.c                           | 172 ++++++----
 kernel/locking/rtmutex_api.c                       |   2 +-
 kernel/locking/rtmutex_common.h                    |  47 ++-
 kernel/locking/ww_mutex.h                          |  12 +-
 kernel/signal.c                                    |   4 +
 kernel/trace/ring_buffer.c                         |  22 +-
 kernel/trace/trace.c                               |   2 +-
 kernel/trace/trace.h                               |   6 +
 kernel/trace/trace_events.c                        |  14 +-
 kernel/trace/trace_events_hist.c                   |   7 +-
 kernel/trace/trace_events_synth.c                  |  80 ++++-
 kernel/trace/trace_probe.c                         |  46 ++-
 kernel/trace/trace_probe.h                         |  16 +-
 kernel/trace/trace_probe_kernel.h                  |  30 +-
 kernel/trace/trace_probe_tmpl.h                    |  59 +++-
 kernel/trace/trace_synth.h                         |   1 +
 kernel/trace/trace_uprobe.c                        |   3 +-
 lib/test_firmware.c                                |  12 +-
 lib/test_maple_tree.c                              | 233 +++++++++-----
 net/ceph/messenger.c                               |   1 +
 net/ipv6/addrconf.c                                |  14 +-
 net/mptcp/protocol.c                               |  20 +-
 net/netfilter/nf_tables_api.c                      |  18 +-
 net/netfilter/nft_immediate.c                      |  27 +-
 net/netfilter/nft_set_rbtree.c                     |  20 +-
 net/sched/sch_mqprio.c                             | 144 ++++++---
 net/tipc/crypto.c                                  |   3 +-
 net/tipc/node.c                                    |   2 +-
 sound/pci/hda/patch_realtek.c                      |   2 +
 sound/soc/codecs/wm8904.c                          |   3 +
 sound/soc/fsl/fsl_spdif.c                          |   2 +
 tools/testing/radix-tree/linux/init.h              |   1 +
 tools/testing/radix-tree/maple.c                   | 143 ++++-----
 tools/testing/selftests/net/mptcp/mptcp_join.sh    |   4 +-
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh |  24 +-
 tools/testing/selftests/rseq/rseq.c                |  28 +-
 virt/kvm/kvm_main.c                                |  24 ++
 239 files changed, 3289 insertions(+), 1930 deletions(-)


