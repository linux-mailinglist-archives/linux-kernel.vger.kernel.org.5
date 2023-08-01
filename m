Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C570676AF07
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 11:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233513AbjHAJo0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 05:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233303AbjHAJn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 05:43:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D05B71729;
        Tue,  1 Aug 2023 02:41:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 77FD46126D;
        Tue,  1 Aug 2023 09:41:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CA66C433C8;
        Tue,  1 Aug 2023 09:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690882882;
        bh=W0fNvQsago8kXY++/cl9wtypclUjDRR0v6TdNFSdBvI=;
        h=From:To:Cc:Subject:Date:From;
        b=QsEJCgEEAyNcHafsMYBwt7pLFFZ7d9pAV2P+M414YSWqGP4qO0M2u03K/sQ118YcP
         Q/P1n819UvwLeZdiuQNeOe9V7CrHBzTjsPBx5oIVsCeJ1QUfPYXV36nmNFiEhN788a
         NkKHz1+pA8RAMkBa6V0bhWw7X8MAUt3gMst3rsNI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: [PATCH 6.4 000/239] 6.4.8-rc1 review
Date:   Tue,  1 Aug 2023 11:17:44 +0200
Message-ID: <20230801091925.659598007@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.4.8-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.4.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.4.8-rc1
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

This is the start of the stable review cycle for the 6.4.8 release.
There are 239 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Thu, 03 Aug 2023 09:18:38 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.4.8-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.4.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 6.4.8-rc1

Dan Carpenter <dan.carpenter@linaro.org>
    dma-buf: fix an error pointer vs NULL bug

Christian König <christian.koenig@amd.com>
    dma-buf: keep the signaling time of merged fences v3

Jann Horn <jannh@google.com>
    mm/mempolicy: Take VMA lock before replacing policy

Sidhartha Kumar <sidhartha.kumar@oracle.com>
    mm/memory-failure: fix hardware poison check in unpoison_memory()

Jann Horn <jannh@google.com>
    mm: fix memory ordering for mm_lock_seq and vm_lock_seq

Jann Horn <jannh@google.com>
    mm: lock VMA in dup_anon_vma() before setting ->anon_vma

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

Ahmad Fatoum <a.fatoum@pengutronix.de>
    thermal: of: fix double-free on unregistration

Johan Hovold <johan+linaro@kernel.org>
    PM: sleep: wakeirq: fix wake irq arming

Mark Brown <broonie@kernel.org>
    arm64/sme: Set new vector length before reallocating

Mark Brown <broonie@kernel.org>
    ASoC: wm8904: Fill the cache for WM8904_ADC_TEST_0 register

Paolo Abeni <pabeni@redhat.com>
    mptcp: more accurate NL event generation

Stefan Haberland <sth@linux.ibm.com>
    s390/dasd: print copy pair message only for the correct error

Stefan Haberland <sth@linux.ibm.com>
    s390/dasd: fix hanging device after quiesce/resume

Eric Van Hensbergen <ericvh@kernel.org>
    fs/9p: remove unnecessary invalidate_inode_pages2

Eric Van Hensbergen <ericvh@kernel.org>
    fs/9p: fix type mismatch in file cache mode helper

Eric Van Hensbergen <ericvh@kernel.org>
    fs/9p: fix typo in comparison logic for cache mode

Eric Van Hensbergen <ericvh@kernel.org>
    fs/9p: remove unnecessary and overrestrictive check

Dominique Martinet <asmadeus@codewreck.org>
    9p: fix ignored return value in v9fs_dir_release

Chenguang Zhao <zhaochenguang@kylinos.cn>
    LoongArch: BPF: Enable bpf_probe_read{, str}() on LoongArch

Tiezhu Yang <yangtiezhu@loongson.cn>
    LoongArch: BPF: Fix check condition to call lu32id in move_imm()

WANG Rui <wangrui@loongson.cn>
    LoongArch: Fix return value underflow in exception path

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    Revert "um: Use swap() to make code cleaner"

Johan Hovold <johan+linaro@kernel.org>
    soundwire: fix enumeration completion

Matthieu Baerts <matthieu.baerts@tessares.net>
    selftests: mptcp: join: only check for ip6tables if needed

Sean Christopherson <seanjc@google.com>
    selftests/rseq: Play nice with binaries statically linked against glibc 2.35+

Jason Gunthorpe <jgg@ziepe.ca>
    iommufd: Set end correctly when doing batch carry

Jens Axboe <axboe@kernel.dk>
    io_uring: gate iowait schedule on having pending requests

Christian Marangi <ansuelsmth@gmail.com>
    net: dsa: qca8k: fix mdb add/del case with 0 VID

Christian Marangi <ansuelsmth@gmail.com>
    net: dsa: qca8k: fix broken search_and_del

Christian Marangi <ansuelsmth@gmail.com>
    net: dsa: qca8k: fix search_and_insert wrong handling of new rule

Christian Marangi <ansuelsmth@gmail.com>
    net: dsa: qca8k: enable use_single_write for qca8xxx

Alex Elder <elder@linaro.org>
    net: ipa: only reset hashed tables when supported

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

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: check if a mount point is crossed during path lookup

Trond Myklebust <trond.myklebust@hammerspace.com>
    nfsd: Remove incorrect check in nfsd4_validate_stateid

Christian Brauner <brauner@kernel.org>
    file: always lock position for FMODE_ATOMIC_POS

Kim Phillips <kim.phillips@amd.com>
    x86/cpu: Enable STIBP on AMD if Automatic IBRS is enabled

Yazen Ghannam <yazen.ghannam@amd.com>
    x86/MCE/AMD: Decrement threshold_bank refcount when removing threshold blocks

Filipe Manana <fdmanana@suse.com>
    btrfs: check for commit error at btrfs_attach_transaction_barrier()

Filipe Manana <fdmanana@suse.com>
    btrfs: check if the transaction was aborted at btrfs_wait_for_commit()

Filipe Manana <fdmanana@suse.com>
    btrfs: account block group tree when calculating global reserve size

Naohiro Aota <naohiro.aota@wdc.com>
    btrfs: zoned: do not enable async discard

Guenter Roeck <linux@roeck-us.net>
    hwmon: (pmbus_core) Fix Deadlock in pmbus_regulator_get_status

Patrick Rudolph <patrick.rudolph@9elements.com>
    hwmon: (pmbus_core) Fix NULL pointer dereference

Patrick Rudolph <patrick.rudolph@9elements.com>
    hwmon: (pmbus_core) Fix pmbus_is_enabled()

Aleksa Savic <savicaleksa83@gmail.com>
    hwmon: (aquacomputer_d5next) Fix incorrect PWM value readout

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

Samuel Thibault <samuel.thibault@ens-lyon.org>
    TIOCSTI: always enable for CAP_SYS_ADMIN

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

Biju Das <biju.das.jz@bp.renesas.com>
    tty: serial: sh-sci: Fix sleeping in atomic context

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

Hugh Dickins <hughd@google.com>
    tmpfs: fix Documentation of noswap and huge mount options

Jason Gunthorpe <jgg@ziepe.ca>
    iommufd: IOMMUFD_DESTROY should not increase the refcount

Ming Lei <ming.lei@redhat.com>
    ublk: return -EINTR if breaking from waiting for existed users in DEL_DEV

Ming Lei <ming.lei@redhat.com>
    ublk: fail to recover device if queue setup is interrupted

Ming Lei <ming.lei@redhat.com>
    ublk: fail to start device if queue setup is interrupted

Rob Clark <robdclark@chromium.org>
    drm/msm: Disallow submit with fence id 0

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

Rob Clark <robdclark@chromium.org>
    drm/msm: Fix hw_fence error path cleanup

Gaosheng Cui <cuigaosheng1@huawei.com>
    drm/msm: Fix IS_ERR_OR_NULL() vs NULL check in a5xx_submit_in_rb()

Selvin Xavier <selvin.xavier@broadcom.com>
    RDMA/bnxt_re: Fix hang during driver unload

Kashyap Desai <kashyap.desai@broadcom.com>
    RDMA/bnxt_re: add helper function __poll_for_resp

Kashyap Desai <kashyap.desai@broadcom.com>
    RDMA/bnxt_re: Simplify the function that sends the FW commands

Kashyap Desai <kashyap.desai@broadcom.com>
    RDMA/bnxt_re: use shadow qd while posting non blocking rcfw command

Kashyap Desai <kashyap.desai@broadcom.com>
    RDMA/bnxt_re: Avoid the command wait if firmware is inactive

Kashyap Desai <kashyap.desai@broadcom.com>
    RDMA/bnxt_re: Enhance the existing functions that wait for FW responses

Kashyap Desai <kashyap.desai@broadcom.com>
    RDMA/bnxt_re: Prevent handling any completions after qp destroy

Thomas Bogendoerfer <tbogendoerfer@suse.de>
    RDMA/mthca: Fix crash when polling CQ for shared QPs

Shiraz Saleem <shiraz.saleem@intel.com>
    RDMA/core: Update CMA destination address on rdma_resolve_addr

Shiraz Saleem <shiraz.saleem@intel.com>
    RDMA/irdma: Fix data race on CQP request done

Shiraz Saleem <shiraz.saleem@intel.com>
    RDMA/irdma: Fix data race on CQP completion stats

Shiraz Saleem <shiraz.saleem@intel.com>
    RDMA/irdma: Add missing read barriers

Rob Clark <robdclark@chromium.org>
    drm/msm/adreno: Fix snapshot BINDLESS_DATA size

Marijn Suijten <marijn.suijten@somainline.org>
    drm/msm/dsi: Drop unused regulators from QCM2290 14nm DSI PHY config

Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
    drm/msm/dpu: drop enum dpu_core_perf_data_bus_id

Jonathan Marek <jonathan@marek.ca>
    drm/msm/dpu: add missing flush and fetch bits for DMA4/DMA5 planes

Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
    drm/msm/mdss: correct UBWC programming for SM8550

Dan Carpenter <dan.carpenter@linaro.org>
    RDMA/mlx4: Make check for invalid flags stricter

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    fs/9p: Fix a datatype used with V9FS_DIRECT_IO

Fedor Pchelkin <pchelkin@ispras.ru>
    tipc: stop tipc crypto on failure in tipc_node_create

Yuanjun Gong <ruc_gongyuanjun@163.com>
    tipc: check return value of pskb_trim()

Yuanjun Gong <ruc_gongyuanjun@163.com>
    benet: fix return value check in be_lancer_xmit_workarounds()

Lin Ma <linma@zju.edu.cn>
    net/sched: mqprio: Add length check for TCA_MQPRIO_{MAX/MIN}_RATE64

Wei Fang <wei.fang@nxp.com>
    net: fec: tx processing does not call XDP APIs if budget is 0

Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
    tools: ynl-gen: fix enum index in _decode_enum(..)

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

Lin Ma <linma@zju.edu.cn>
    macvlan: add forgotten nla_policy for IFLA_MACVLAN_BC_CUTOFF

Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
    x86/traps: Fix load_unaligned_zeropad() handling for shared TDX memory

Maxim Mikityanskiy <maxtram95@gmail.com>
    platform/x86: msi-laptop: Fix rfkill out-of-sync on MSI Wind U100

Vincent Whitchurch <vincent.whitchurch@axis.com>
    net: stmmac: Apply redundant write work around on 4.xx too

Suman Ghosh <sumang@marvell.com>
    octeontx2-af: Fix hash extraction enable configuration

Hangbin Liu <liuhangbin@gmail.com>
    team: reset team's flags when down link is P2P device

Hangbin Liu <liuhangbin@gmail.com>
    bonding: reset bond's flags when down link is P2P device

Jedrzej Jagielski <jedrzej.jagielski@intel.com>
    ice: Fix memory management in ice_ethtool_fdir.c

Stewart Smith <trawets@amazon.com>
    tcp: Reduce chance of collisions in inet6_hashfn().

Wei Fang <wei.fang@nxp.com>
    net: fec: avoid tx queue timeout when XDP is enabled

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

Arnd Bergmann <arnd@arndb.de>
    media: mtk_jpeg_core: avoid unused-variable warning

Randy Dunlap <rdunlap@infradead.org>
    media: mtk-jpeg: move data/code inside CONFIG_OF blocks

Nicolas Dufresne <nicolas.dufresne@collabora.com>
    media: amphion: Fix firmware path to match linux-firmware

Sakari Ailus <sakari.ailus@linux.intel.com>
    media: staging: atomisp: select V4L2_FWNODE

Sakari Ailus <sakari.ailus@linux.intel.com>
    media: tc358746: Address compiler warnings

Dan Carpenter <dan.carpenter@linaro.org>
    soundwire: amd: Fix a check for errors in probe()

Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
    soundwire: qcom: update status correctly with mask

Adrien Thierry <athierry@redhat.com>
    phy: qcom-snps-femto-v2: properly enable ref clock

Adrien Thierry <athierry@redhat.com>
    phy: qcom-snps-femto-v2: keep cfg_ahb_clk enabled during runtime suspend

Guillaume Ranquet <granquet@baylibre.com>
    phy: mediatek: hdmi: mt8195: fix prediv bad upper limit test

Dan Carpenter <dan.carpenter@linaro.org>
    phy: phy-mtk-dp: Fix an error code in probe()

Ojaswin Mujoo <ojaswin@linux.ibm.com>
    ext4: fix rbtree traversal bug in ext4_mb_use_preallocated

Ritesh Harjani <ritesh.list@gmail.com>
    ext4: mballoc: Remove useless setting of ac_criteria

Kemeng Shi <shikemeng@huaweicloud.com>
    ext4: add EXT4_MB_HINT_GOAL_ONLY test in ext4_mb_use_preallocated

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

Liam R. Howlett <Liam.Howlett@oracle.com>
    maple_tree: fix 32 bit mas_next testing

Liam R. Howlett <Liam.Howlett@oracle.com>
    maple_tree: add __init and __exit to test module

Christian König <christian.koenig@amd.com>
    drm/ttm: never consider pinned BOs for eviction&swap

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

Michael Strauss <michael.strauss@amd.com>
    drm/amd/display: Keep disable aux-i delay as 0

Michael Strauss <michael.strauss@amd.com>
    drm/amd/display: Convert Delaying Aux-I Disable To Monitor Patch

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

Christoph Hellwig <hch@lst.de>
    btrfs: fix fsverify read error handling in end_page_read

Christoph Hellwig <hch@lst.de>
    btrfs: factor out a btrfs_verify_page helper

Guenter Roeck <linux@roeck-us.net>
    regmap: Disable locking for RBTREE and MAPLE unit tests

Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
    gpio: mvebu: fix irq domain leak

Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
    gpio: mvebu: Make use of devm_pwmchip_add

Hans de Goede <hdegoede@redhat.com>
    gpio: tps68470: Make tps68470_gpio_output() always set the initial value

Ondrej Mosnacek <omosnace@redhat.com>
    io_uring: don't audit the capability check in io_uring_create()

Sven Schnelle <svens@linux.ibm.com>
    s390/mm: fix per vma lock fault handling

Claudio Imbrenda <imbrenda@linux.ibm.com>
    KVM: s390: pv: fix index value of replaced ASCE

Claudio Imbrenda <imbrenda@linux.ibm.com>
    KVM: s390: pv: simplify shutdown and fix race

Haren Myneni <haren@linux.ibm.com>
    powerpc/pseries/vas: Hold mmap_mutex after mmap lock during window close

Ross Lagerwall <ross.lagerwall@citrix.com>
    blk-mq: Fix stall due to recursive flush plug

Sudeep Holla <sudeep.holla@arm.com>
    KVM: arm64: Handle kvm_arm_init failure correctly in finalize_pkvm

Zhihao Cheng <chengzhihao1@huawei.com>
    jbd2: Fix wrongly judgement for buffer head removing while doing checkpoint

Heiner Kallweit <hkallweit1@gmail.com>
    r8169: revert 2ab19de62d67 ("r8169: remove ASPM restrictions now that ASPM is disabled during NAPI poll")

Mario Limonciello <mario.limonciello@amd.com>
    drm/amd: Align SMU11 SMU_MSG_OverridePcieParameters implementation with SMU13

Mario Limonciello <mario.limonciello@amd.com>
    drm/amd: Move helper for dynamic speed switch check out of smu13

Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
    platform/x86/amd/pmf: reduce verbosity of apmf_get_system_params

Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
    platform/x86/amd/pmf: Notify OS power slider update


-------------

Diffstat:

 Documentation/ABI/testing/sysfs-module             |  11 +
 Documentation/admin-guide/hw-vuln/spectre.rst      |  11 +-
 Documentation/filesystems/tmpfs.rst                |  45 +-
 Documentation/process/security-bugs.rst            |  37 +-
 Makefile                                           |   4 +-
 arch/arm64/include/asm/virt.h                      |   1 +
 arch/arm64/kernel/fpsimd.c                         |   4 +-
 arch/arm64/kvm/arm.c                               |   9 +-
 arch/arm64/kvm/pkvm.c                              |   2 +-
 arch/loongarch/Kconfig                             |   1 +
 arch/loongarch/lib/clear_user.S                    |   3 +-
 arch/loongarch/lib/copy_user.S                     |   3 +-
 arch/loongarch/net/bpf_jit.h                       |   2 +-
 arch/powerpc/platforms/pseries/vas.c               |   9 +-
 arch/s390/kvm/pv.c                                 |   8 +-
 arch/s390/mm/fault.c                               |   2 +
 arch/s390/mm/gmap.c                                |   1 +
 arch/um/os-Linux/sigio.c                           |   7 +-
 arch/x86/include/asm/kvm-x86-ops.h                 |   1 +
 arch/x86/include/asm/kvm_host.h                    |   3 +-
 arch/x86/kernel/cpu/bugs.c                         |  15 +-
 arch/x86/kernel/cpu/mce/amd.c                      |   4 +-
 arch/x86/kernel/traps.c                            |  18 +-
 arch/x86/kvm/svm/svm.c                             |   6 +
 arch/x86/kvm/vmx/vmx.c                             |  41 +-
 arch/x86/kvm/x86.c                                 |  34 +-
 block/blk-core.c                                   |   3 +-
 block/blk-mq.c                                     |   9 +-
 drivers/acpi/arm64/iort.c                          |   3 -
 drivers/ata/pata_ns87415.c                         |   2 +-
 drivers/base/power/power.h                         |   1 +
 drivers/base/power/wakeirq.c                       |  12 +-
 drivers/base/regmap/regmap-kunit.c                 |   3 +
 drivers/block/rbd.c                                | 124 ++-
 drivers/block/ublk_drv.c                           |  11 +-
 drivers/char/tpm/tpm_tis_core.c                    |   9 +-
 drivers/cxl/acpi.c                                 |   5 +-
 drivers/dma-buf/dma-fence-unwrap.c                 |  26 +-
 drivers/dma-buf/dma-fence.c                        |   7 +-
 drivers/gpio/gpio-mvebu.c                          |  26 +-
 drivers/gpio/gpio-tps68470.c                       |   6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu.h                |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |  19 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c            |   6 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_mst_types.c    |   2 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c  |   3 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c           |  25 +-
 drivers/gpu/drm/amd/display/dc/dc.h                |   3 -
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c       |   7 +
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h       |   1 +
 drivers/gpu/drm/amd/display/dc/dc_stream.h         |   1 +
 drivers/gpu/drm/amd/display/dc/dc_types.h          |   1 +
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c |   4 +-
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c  |   7 +-
 .../gpu/drm/amd/display/dc/dcn31/dcn31_hubbub.c    |   1 +
 .../drm/amd/display/dc/dcn315/dcn315_resource.c    | 106 ++-
 .../gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c   |  23 +-
 .../gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c   |  25 +-
 .../gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.h   |   3 +
 .../amd/display/dc/dml/dcn31/display_mode_vba_31.c |  39 +-
 .../display/dc/dml/dcn31/display_rq_dlg_calc_31.c  |   3 +-
 .../gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c |  15 +-
 .../dc/dml/dcn314/display_rq_dlg_calc_314.c        |  16 +-
 .../drm/amd/display/dc/dml/display_mode_structs.h  |   3 +-
 .../gpu/drm/amd/display/dc/dml/display_mode_vba.c  |   6 +
 .../link_dp_training_fixed_vs_pe_retimer.c         |  23 +-
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h        |   2 +
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h    |   2 +-
 drivers/gpu/drm/amd/display/dmub/src/Makefile      |   2 +-
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c  |   5 +
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.h  |   2 +
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn314.c |  67 ++
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn314.h |  35 +
 drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c    |  12 +-
 .../drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c    |  89 +--
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c     |  21 +-
 drivers/gpu/drm/drm_syncobj.c                      |   6 +-
 drivers/gpu/drm/i915/display/intel_dpt.c           |   4 +-
 drivers/gpu/drm/i915/gem/selftests/huge_pages.c    |   6 +-
 drivers/gpu/drm/msm/adreno/a5xx_gpu.c              |   2 +-
 drivers/gpu/drm/msm/adreno/a6xx_gpu_state.h        |   2 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.h      |  13 -
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c         |   8 +-
 drivers/gpu/drm/msm/dsi/phy/dsi_phy_14nm.c         |   2 -
 drivers/gpu/drm/msm/msm_fence.c                    |   6 +
 drivers/gpu/drm/msm/msm_gem_submit.c               |  16 +-
 drivers/gpu/drm/msm/msm_mdss.c                     |  19 +-
 drivers/gpu/drm/ttm/ttm_bo.c                       |   6 +
 drivers/hwmon/aquacomputer_d5next.c                |   2 +-
 drivers/hwmon/k10temp.c                            |  17 +-
 drivers/hwmon/nct7802.c                            |   2 +-
 drivers/hwmon/pmbus/pmbus_core.c                   |  20 +-
 drivers/i2c/busses/i2c-ibm_iic.c                   |   4 +-
 drivers/i2c/busses/i2c-nomadik.c                   |  42 +-
 drivers/i2c/busses/i2c-sh7760.c                    |   3 +-
 drivers/i2c/busses/i2c-tiny-usb.c                  |   4 +-
 drivers/infiniband/core/cma.c                      |   2 +
 drivers/infiniband/hw/bnxt_re/ib_verbs.c           |  12 +
 drivers/infiniband/hw/bnxt_re/qplib_fp.c           |  28 +-
 drivers/infiniband/hw/bnxt_re/qplib_fp.h           |   1 +
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c         | 355 ++++++---
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.h         |  26 +
 drivers/infiniband/hw/irdma/ctrl.c                 |  31 +-
 drivers/infiniband/hw/irdma/defs.h                 |  46 +-
 drivers/infiniband/hw/irdma/hw.c                   |   3 +-
 drivers/infiniband/hw/irdma/main.h                 |   2 +-
 drivers/infiniband/hw/irdma/puda.c                 |   6 +
 drivers/infiniband/hw/irdma/type.h                 |   2 +
 drivers/infiniband/hw/irdma/uk.c                   |   5 +-
 drivers/infiniband/hw/irdma/utils.c                |   8 +-
 drivers/infiniband/hw/mlx4/qp.c                    |  18 +-
 drivers/infiniband/hw/mthca/mthca_qp.c             |   2 +-
 drivers/iommu/iommufd/device.c                     |  12 +-
 drivers/iommu/iommufd/iommufd_private.h            |  15 +-
 drivers/iommu/iommufd/main.c                       |  78 +-
 drivers/iommu/iommufd/pages.c                      |   2 +-
 drivers/irqchip/irq-bcm6345-l1.c                   |  14 +-
 drivers/irqchip/irq-gic-v3-its.c                   |  75 +-
 drivers/md/dm-cache-policy-smq.c                   |  28 +-
 drivers/md/dm-raid.c                               |  20 +-
 drivers/md/md.c                                    |   2 +
 drivers/media/i2c/tc358746.c                       |   4 +-
 drivers/media/platform/amphion/vpu_core.c          |   4 +-
 .../media/platform/mediatek/jpeg/mtk_jpeg_core.c   | 830 ++++++++++-----------
 .../media/platform/mediatek/jpeg/mtk_jpeg_dec_hw.c |   4 +-
 .../media/platform/mediatek/jpeg/mtk_jpeg_enc_hw.c |   4 +-
 drivers/net/bonding/bond_main.c                    |   5 +
 drivers/net/can/usb/gs_usb.c                       |   2 +
 drivers/net/dsa/qca/qca8k-8xxx.c                   |   7 +-
 drivers/net/dsa/qca/qca8k-common.c                 |  19 +-
 drivers/net/ethernet/atheros/atl1e/atl1e_main.c    |   7 +-
 drivers/net/ethernet/atheros/atlx/atl1.c           |   7 +-
 drivers/net/ethernet/emulex/benet/be_main.c        |   3 +-
 drivers/net/ethernet/freescale/fec_main.c          |  18 +-
 drivers/net/ethernet/hisilicon/hns3/hnae3.h        |   3 +-
 .../hisilicon/hns3/hns3_common/hclge_comm_cmd.c    |  21 +-
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c |  17 +-
 .../ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c |   3 +-
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c  |   3 +-
 drivers/net/ethernet/intel/i40e/i40e_debugfs.c     |   2 +-
 drivers/net/ethernet/intel/iavf/iavf_main.c        |  11 +-
 drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c  |  26 +-
 drivers/net/ethernet/intel/igc/igc_main.c          |  40 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c      |   2 +-
 .../ethernet/marvell/octeontx2/af/rvu_npc_hash.c   |  43 +-
 .../ethernet/marvell/octeontx2/af/rvu_npc_hash.h   |   8 +-
 drivers/net/ethernet/realtek/r8169_main.c          |  27 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac4_lib.c   |   4 +-
 drivers/net/ipa/ipa_table.c                        |  22 +-
 drivers/net/macvlan.c                              |   1 +
 drivers/net/phy/marvell10g.c                       |   7 +
 drivers/net/team/team.c                            |   9 +
 drivers/net/virtio_net.c                           |   4 +-
 drivers/net/vxlan/vxlan_core.c                     | 165 ++--
 drivers/pci/controller/pcie-rockchip-ep.c          | 156 ++--
 drivers/pci/controller/pcie-rockchip.h             |  40 +-
 drivers/pci/pcie/aspm.c                            |  55 +-
 drivers/phy/hisilicon/phy-hisi-inno-usb2.c         |   2 +-
 drivers/phy/mediatek/phy-mtk-dp.c                  |   2 +-
 drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c         |   2 +-
 drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c      |  72 +-
 drivers/platform/x86/amd/pmf/acpi.c                |  23 +-
 drivers/platform/x86/amd/pmf/core.c                |   9 +-
 drivers/platform/x86/amd/pmf/pmf.h                 |  16 +
 drivers/platform/x86/amd/pmf/sps.c                 |  74 +-
 drivers/platform/x86/msi-laptop.c                  |   8 +-
 drivers/s390/block/dasd_3990_erp.c                 |   2 +-
 drivers/s390/block/dasd_ioctl.c                    |   1 +
 drivers/soundwire/amd_manager.c                    |   4 +-
 drivers/soundwire/bus.c                            |   8 +-
 drivers/soundwire/qcom.c                           |   2 +-
 drivers/staging/ks7010/ks_wlan_net.c               |   6 +-
 drivers/staging/media/atomisp/Kconfig              |   1 +
 drivers/staging/rtl8712/rtl871x_xmit.c             |  43 +-
 drivers/staging/rtl8712/xmit_linux.c               |   6 +
 drivers/thermal/thermal_of.c                       |  27 +-
 drivers/tty/n_gsm.c                                |   4 +-
 drivers/tty/serial/8250/8250_dwlib.c               |   6 +-
 drivers/tty/serial/qcom_geni_serial.c              |   7 -
 drivers/tty/serial/sh-sci.c                        |   2 +-
 drivers/tty/serial/sifive.c                        |   2 +-
 drivers/tty/tty_io.c                               |   2 +-
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
 drivers/usb/serial/usb-serial-simple.c             |  73 +-
 drivers/usb/typec/class.c                          |  15 +-
 drivers/xen/grant-table.c                          |  40 +-
 drivers/xen/xenbus/xenbus_probe.c                  |   3 +
 fs/9p/fid.h                                        |   6 +-
 fs/9p/v9fs.h                                       |   2 +-
 fs/9p/vfs_dir.c                                    |   5 +-
 fs/9p/vfs_file.c                                   |   5 +-
 fs/btrfs/block-rsv.c                               |   5 +
 fs/btrfs/disk-io.c                                 |   7 +-
 fs/btrfs/extent_io.c                               |  21 +-
 fs/btrfs/qgroup.c                                  |  18 +-
 fs/btrfs/transaction.c                             |  10 +-
 fs/btrfs/zoned.c                                   |   3 +
 fs/ceph/metric.c                                   |   2 +-
 fs/ext4/mballoc.c                                  | 200 ++++-
 fs/file.c                                          |   6 +-
 fs/jbd2/checkpoint.c                               | 197 ++---
 fs/jbd2/commit.c                                   |   3 +-
 fs/jbd2/transaction.c                              |  17 +-
 fs/nfsd/nfs4state.c                                |   2 -
 fs/proc/vmcore.c                                   |   2 +-
 fs/smb/client/sess.c                               |   4 +-
 fs/smb/server/ksmbd_netlink.h                      |   3 +-
 fs/smb/server/smb2pdu.c                            |  27 +-
 fs/smb/server/vfs.c                                |  58 +-
 fs/smb/server/vfs.h                                |   4 +-
 include/linux/dma-fence.h                          |   2 +-
 include/linux/jbd2.h                               |   7 +-
 include/linux/mm.h                                 |  29 +-
 include/linux/mm_types.h                           |  28 +
 include/linux/mmap_lock.h                          |  10 +-
 include/net/ipv6.h                                 |   8 +-
 include/net/vxlan.h                                |  13 +-
 include/trace/events/jbd2.h                        |  12 +-
 include/uapi/linux/blkzoned.h                      |  10 +-
 io_uring/io_uring.c                                |  25 +-
 kernel/locking/rtmutex.c                           | 172 +++--
 kernel/locking/rtmutex_api.c                       |   2 +-
 kernel/locking/rtmutex_common.h                    |  47 +-
 kernel/locking/ww_mutex.h                          |  12 +-
 kernel/signal.c                                    |   4 +
 kernel/trace/ring_buffer.c                         |  22 +-
 kernel/trace/trace_events.c                        |  14 +-
 lib/test_maple_tree.c                              | 163 ++--
 mm/memory-failure.c                                |   2 +-
 mm/mempolicy.c                                     |  15 +-
 mm/mmap.c                                          |   1 +
 net/ceph/messenger.c                               |   1 +
 net/ipv6/addrconf.c                                |  14 +-
 net/mptcp/protocol.c                               |   3 +-
 net/netfilter/nf_tables_api.c                      |   5 +-
 net/netfilter/nft_immediate.c                      |  27 +-
 net/netfilter/nft_set_rbtree.c                     |  20 +-
 net/sched/sch_mqprio.c                             |  14 +
 net/tipc/crypto.c                                  |   3 +-
 net/tipc/node.c                                    |   2 +-
 sound/pci/hda/patch_realtek.c                      |   2 +
 sound/soc/codecs/wm8904.c                          |   3 +
 sound/soc/fsl/fsl_spdif.c                          |   2 +
 tools/net/ynl/lib/ynl.py                           |   4 +-
 tools/testing/radix-tree/linux/init.h              |   1 +
 tools/testing/radix-tree/maple.c                   | 143 ++--
 tools/testing/selftests/net/mptcp/mptcp_join.sh    |   4 +-
 tools/testing/selftests/rseq/rseq.c                |  28 +-
 virt/kvm/kvm_main.c                                |  24 +
 264 files changed, 3622 insertions(+), 2136 deletions(-)


