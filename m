Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5D227D30EC
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 13:03:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233067AbjJWLDn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 07:03:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230461AbjJWLDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 07:03:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EEE2D7A;
        Mon, 23 Oct 2023 04:03:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05A95C433C7;
        Mon, 23 Oct 2023 11:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698059014;
        bh=tOl+aP1RpRzNf1af+sEvT66MrX7D77NO0bYZ4mGaDxU=;
        h=From:To:Cc:Subject:Date:From;
        b=NVisj7/iIcMfFf83k6Zv2vVeuVHDxriAcLwSyYLwk0vI0nzOmsiK2YioYdyb+so2X
         ChoGLE3uJ4lSbiPDsZSuw2aOPcF6gosyQ262+g7zvpua1ZyBo80uGKTngtwN7lWxl2
         ti/S3nWhXkCuWhYDL/Wo9zssKx517o/Ok3h0noq4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: [PATCH 6.5 000/241] 6.5.9-rc1 review
Date:   Mon, 23 Oct 2023 12:53:06 +0200
Message-ID: <20231023104833.832874523@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.5.9-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.5.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.5.9-rc1
X-KernelTest-Deadline: 2023-10-25T10:48+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 6.5.9 release.
There are 241 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Wed, 25 Oct 2023 10:47:57 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.5.9-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.5.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 6.5.9-rc1

Matthieu Baerts <matttbe@kernel.org>
    selftests: mptcp: join: correctly check for no RST

Geliang Tang <geliang.tang@suse.com>
    mptcp: avoid sending RST when closing the initial subflow

Kees Cook <keescook@chromium.org>
    Bluetooth: hci_sock: Correctly bounds check and pad HCI_MON_NEW_INDEX name

Miguel Ojeda <ojeda@kernel.org>
    kbuild: remove old Rust docs output path

Miguel Ojeda <ojeda@kernel.org>
    docs: rust: update Rust docs output path

Johannes Berg <johannes.berg@intel.com>
    net: rfkill: reduce data->mtx scope in rfkill_fop_open

Edward AD <twuufnxlz@gmail.com>
    Bluetooth: hci_sock: fix slab oob read in create_monitor_event

Jakub Kicinski <kuba@kernel.org>
    net: move altnames together with the netdevice

Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
    efi/unaccepted: Fix soft lockups caused by parallel memory acceptance

Konrad Dybcio <konrad.dybcio@linaro.org>
    phy: qcom-qmp-combo: initialize PCS_USB registers

Konrad Dybcio <konrad.dybcio@linaro.org>
    phy: qcom-qmp-combo: Square out 8550 POWER_STATE_CONFIG1

Adrien Thierry <athierry@redhat.com>
    phy: qcom-qmp-usb: split PCS_USB init table for sc8280xp and sa8775p

Adrien Thierry <athierry@redhat.com>
    phy: qcom-qmp-usb: initialize PCS_USB registers

Tony Lindgren <tony@atomide.com>
    phy: mapphone-mdm6600: Fix pinctrl_pm handling for sleep pins

Tony Lindgren <tony@atomide.com>
    phy: mapphone-mdm6600: Fix runtime PM for remove

Tony Lindgren <tony@atomide.com>
    phy: mapphone-mdm6600: Fix runtime disable on probe

Miguel Ojeda <ojeda@kernel.org>
    rust: docs: fix logo replacement

Carlos Bilbao <carlos.bilbao@amd.com>
    docs: Move rustdoc output, cross-reference it

Nicholas Piggin <npiggin@gmail.com>
    powerpc/qspinlock: Fix stale propagated yield_cpu

Michael Ellerman <mpe@ellerman.id.au>
    powerpc/mm: Allow ARCH_FORCE_MAX_ORDER up to 12

Felix Kuehling <Felix.Kuehling@amd.com>
    drm/amdgpu: Fix possible null pointer dereference

Khaled Almahallawy <khaled.almahallawy@intel.com>
    drm/i915/cx0: Only clear/set the Pipe Reset bit of the PHY Lanes Owned

Douglas Anderson <dianders@chromium.org>
    drm/panel: Move AUX B116XW03 out of panel-edp back to panel-simple

Stephen Boyd <swboyd@chromium.org>
    drm/bridge: ti-sn65dsi86: Associate DSI device lifetime with auxiliary device

Richard Fitzgerald <rf@opensource.cirrus.com>
    ASoC: cs42l42: Fix missing include of gpio/consumer.h

Dan Carpenter <dan.carpenter@linaro.org>
    ASoC: pxa: fix a memory leak in probe()

Richard Fitzgerald <rf@opensource.cirrus.com>
    ASoC: cs35l56: Fix illegal use of init_completion()

Haibo Chen <haibo.chen@nxp.com>
    gpio: vf610: mask the gpio irq in system suspend and support wakeup

Haibo Chen <haibo.chen@nxp.com>
    gpio: vf610: set value before the direction to avoid a glitch

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    gpiolib: acpi: Add missing memset(0) to acpi_get_gpiod_from_data()

Wedson Almeida Filho <walmeida@microsoft.com>
    rust: error: fix the description for `ECHILD`

Hans de Goede <hdegoede@redhat.com>
    platform/x86: asus-wmi: Map 0x2a code, Ignore 0x2b and 0x2c events

Hans de Goede <hdegoede@redhat.com>
    platform/x86: asus-wmi: Only map brightness codes when using asus-wmi backlight control

Hans de Goede <hdegoede@redhat.com>
    platform/x86: asus-wmi: Change ASUS_WMI_BRN_DOWN code from 0x20 to 0x2e

Nikita Kravets <teackot@gmail.com>
    platform/x86: msi-ec: Fix the 3rd config

Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
    platform/x86: intel-uncore-freq: Conditionally create attribute for read frequency

Armin Wolf <W_Armin@gmx.de>
    platform/surface: platform_profile: Propagate error if profile registration fails

Dinghao Liu <dinghao.liu@zju.edu.cn>
    s390/cio: fix a memleak in css_alloc_subchannel

Orlando Chamberlain <orlandoch.dev@gmail.com>
    apple-gmux: Hard Code max brightness for MMIO gmux

Herbert Xu <herbert@gondor.apana.org.au>
    KEYS: asymmetric: Fix sign/verify on pkcs1pad without a hash

Francis Laniel <flaniel@linux.microsoft.com>
    selftests/ftrace: Add new test case which checks non unique symbol

Francis Laniel <flaniel@linux.microsoft.com>
    tracing/kprobes: Return EADDRNOTAVAIL when func matches several symbols

Niklas Schnelle <schnelle@linux.ibm.com>
    s390/pci: fix iommu bitmap allocation

Peter Zijlstra <peterz@infradead.org>
    perf: Disallow mis-matched inherited group reads

Gil Fine <gil.fine@linux.intel.com>
    thunderbolt: Call tb_switch_put() once DisplayPort bandwidth request is finished

Puliang Lu <puliang.lu@fibocom.com>
    USB: serial: option: add Fibocom to DELL custom modem FM101R-GL

Benoît Monin <benoit.monin@gmx.fr>
    USB: serial: option: add entry for Sierra EM9191 with new firmware

Fabio Porcedda <fabio.porcedda@gmail.com>
    USB: serial: option: add Telit LE910C4-WWX 0x1035 composition

Maurizio Lombardi <mlombard@redhat.com>
    nvme-rdma: do not try to stop unallocated queues

Maurizio Lombardi <mlombard@redhat.com>
    nvmet-auth: complete a request only after freeing the dhchap pointers

Martin Wilck <mwilck@suse.com>
    nvme-auth: use chap->s2 to indicate bidirectional authentication

Keith Busch <kbusch@kernel.org>
    nvme-pci: add BOGUS_NID for Intel 0a54 device

Keith Busch <kbusch@kernel.org>
    nvme: sanitize metadata bounce buffer for reads

Dai Ngo <dai.ngo@oracle.com>
    nfs42: client needs to strip file mode's suid/sgid bit after ALLOCATE op

Scott Mayhew <smayhew@redhat.com>
    NFS: Fix potential oops in nfs_inode_remove_request()

Amir Goldstein <amir73il@gmail.com>
    fanotify: limit reporting of event with non-decodeable file handles

Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
    Revert "accel/ivpu: Use cached buffers for FW loading"

Adrian Hunter <adrian.hunter@intel.com>
    perf dlfilter: Fix use of addr_location__exit() in dlfilter__object_code()

Hanjun Guo <guohanjun@huawei.com>
    ACPI: bus: Move acpi_arm_init() to the place of after acpi_ghes_init()

Sunil V L <sunilvl@ventanamicro.com>
    ACPI: irq: Fix incorrect return value in acpi_register_gsi()

Olga Kornievskaia <kolga@netapp.com>
    NFSv4.1: fixup use EXCHGID4_FLAG_USE_PNFS_DS for DS server

Trond Myklebust <trond.myklebust@hammerspace.com>
    pNFS/flexfiles: Check the layout validity in ff_layout_mirror_prepare_stats

Trond Myklebust <trond.myklebust@hammerspace.com>
    pNFS: Fix a hang in nfs4_evict_inode()

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    Revert "pinctrl: avoid unsafe code pattern in find_pinctrl()"

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    pinctrl: qcom: lpass-lpi: fix concurrent register updates

Avri Altman <avri.altman@wdc.com>
    mmc: core: Capture correct oemid-bits for eMMC cards

Haibo Chen <haibo.chen@nxp.com>
    mmc: core: sdio: hold retuning if sdio in 1-bit mode

Ulf Hansson <ulf.hansson@linaro.org>
    mmc: core: Fix error propagation for some ioctl commands

Pablo Sun <pablo.sun@mediatek.com>
    mmc: mtk-sd: Use readl_poll_timeout_atomic in msdc_reset_hw

Sven van Ashbrook <svenva@chromium.org>
    mmc: sdhci-pci-gli: fix LPM negotiation so x86/S0ix SoCs can suspend

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    dt-bindings: mmc: sdhci-msm: correct minimum number of clocks

Geert Uytterhoeven <geert+renesas@glider.be>
    mtd: physmap-core: Restore map_rom fallback

Martin Kurbanov <mmkurbanov@sberdevices.ru>
    mtd: spinand: micron: correct bitmask for ecc status

Rouven Czerwinski <r.czerwinski@pengutronix.de>
    mtd: rawnand: Ensure the nand chip supports cached reads

Miquel Raynal <miquel.raynal@bootlin.com>
    mtd: rawnand: arasan: Ensure program page operations are successful

Miquel Raynal <miquel.raynal@bootlin.com>
    mtd: rawnand: marvell: Ensure program page operations are successful

Miquel Raynal <miquel.raynal@bootlin.com>
    mtd: rawnand: pl353: Ensure program page operations are successful

Bibek Kumar Patro <quic_bibekkum@quicinc.com>
    mtd: rawnand: qcom: Unmap the right resource upon probe failure

Paolo Abeni <pabeni@redhat.com>
    tcp_bpf: properly release resources on error paths

Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
    Bluetooth: hci_event: Fix using memcmp when comparing keys

Albert Huang <huangjie.albert@bytedance.com>
    net/smc: fix smc clc failed issue when netdevice not in init_net

Guangguan Wang <guangguan.wang@linux.alibaba.com>
    net/smc: support smc v2.x features validate

Guangguan Wang <guangguan.wang@linux.alibaba.com>
    net/smc: support smc release version negotiation in clc handshake

Paolo Abeni <pabeni@redhat.com>
    tcp: allow again tcp_disconnect() when threads are waiting

Hannes Reinecke <hare@suse.de>
    net/tls: split tls_rx_reader_lock

Amir Tzin <amirtz@nvidia.com>
    net/mlx5e: Fix VF representors reporting zero counters to "ip -s" command

Jianbo Liu <jianbol@nvidia.com>
    net/mlx5e: Don't offload internal port if filter device is out device

Lama Kayal <lkayal@nvidia.com>
    net/mlx5e: Take RTNL lock before triggering netdev notifiers

Dragos Tatulea <dtatulea@nvidia.com>
    net/mlx5e: XDP, Fix XDP_REDIRECT mpwqe page fragment leaks on shutdown

Dragos Tatulea <dtatulea@nvidia.com>
    net/mlx5e: RX, Fix page_pool allocation failure recovery for legacy rq

Dragos Tatulea <dtatulea@nvidia.com>
    net/mlx5e: RX, Fix page_pool allocation failure recovery for striding rq

Maher Sanalla <msanalla@nvidia.com>
    net/mlx5: Handle fw tracer change ownership event based on MTRC

Shay Drory <shayd@nvidia.com>
    net/mlx5: E-switch, register event handler before arming the event

Pauli Virtanen <pav@iki.fi>
    Bluetooth: hci_sync: always check if connection is alive before deleting

Pauli Virtanen <pav@iki.fi>
    Bluetooth: hci_sync: delete CIS in BT_OPEN/CONNECT/BOUND when aborting

Iulia Tanasescu <iulia.tanasescu@nxp.com>
    Bluetooth: ISO: Fix invalid context error

Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
    Bluetooth: hci_sync: Introduce PTR_UINT/UINT_PTR macros

Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
    Bluetooth: hci_sync: Fix not handling ISO_LINK in hci_abort_conn_sync

Jeff Moyer <jmoyer@redhat.com>
    io-wq: fully initialize wqe before calling cpuhp_state_add_instance_nocalls()

Xuewen Yan <xuewen.yan@unisoc.com>
    cpufreq: schedutil: Update next_freq when cpufreq_limits change

Renan Guilherme Lebre Ramos <japareaggae@gmail.com>
    platform/x86: touchscreen_dmi: Add info for the Positivo C4128B

Fabian Vogt <fabian@ritter-vogt.de>
    HID: Add quirk to ignore the touchscreen battery on HP ENVY 15-eu0556ng

Martino Fontana <tinozzo123@gmail.com>
    HID: nintendo: reinitialize USB Pro Controller after resuming from suspend

Rahul Rameshbabu <sergeantsagara@protonmail.com>
    HID: multitouch: Add required quirk for Synaptics 0xcd7e device

Kenneth Feng <kenneth.feng@amd.com>
    drm/amd/pm: add unique_id for gc 11.0.3

Tomasz Swiatek <swiatektomasz99@gmail.com>
    platform/x86: touchscreen_dmi: Add info for the BUSH Bush Windows tablet

Filipe Manana <fdmanana@suse.com>
    btrfs: error out when reallocating block for defrag using a stale transaction

Filipe Manana <fdmanana@suse.com>
    btrfs: error when COWing block from a root that is being deleted

Filipe Manana <fdmanana@suse.com>
    btrfs: error out when COWing block using a stale transaction

Josef Bacik <josef@toxicpanda.com>
    btrfs: fix some -Wmaybe-uninitialized warnings in ioctl.c

Kai Uwe Broulik <foss-linux@broulik.de>
    drm: panel-orientation-quirks: Add quirk for One Mix 2S

Hangbin Liu <liuhangbin@gmail.com>
    ipv4/fib: send notify when delete source address routes

Kees Cook <keescook@chromium.org>
    sky2: Make sure there is at least one frag_addr available

Jeff Layton <jlayton@kernel.org>
    nfs: decrement nrequests counter before releasing the req

Anna Schumaker <Anna.Schumaker@Netapp.com>
    SUNRPC/TLS: Lock the lower_xprt during the tls handshake

Chuck Lever <chuck.lever@oracle.com>
    SUNRPC: Fail quickly when server does not recognize TLS

Michał Mirosław <mirq-linux@rere.qmqm.pl>
    regulator/core: Revert "fix kobject release warning and memory leak in regulator_register()"

Benjamin Berg <benjamin.berg@intel.com>
    wifi: cfg80211: avoid leaking stack data into trace

Wen Gong <quic_wgong@quicinc.com>
    wifi: mac80211: allow transmitting EAPOL frames with tainted key

Johannes Berg <johannes.berg@intel.com>
    wifi: mac80211: work around Cisco AP 9115 VHT MPDU length

Ilan Peer <ilan.peer@intel.com>
    wifi: cfg80211: Fix 6GHz scan configuration

Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
    Bluetooth: hci_core: Fix build warnings

Ying Hsu <yinghsu@chromium.org>
    Bluetooth: Avoid redundant authentication

Rocky Liao <quic_rjliao@quicinc.com>
    Bluetooth: btusb: add shutdown function for QCA6174

Ma Ke <make_ruc2021@163.com>
    HID: holtek: fix slab-out-of-bounds Write in holtek_kbd_input_event

Hans de Goede <hdegoede@redhat.com>
    HID: logitech-hidpp: Add Bluetooth ID for the Logitech M720 Triathlon mouse

Johannes Berg <johannes.berg@intel.com>
    rfkill: sync before userspace visibility/changes

Ben Greear <greearb@candelatech.com>
    wifi: iwlwifi: Ensure ack flag is properly cleared.

Aditya Kumar Singh <quic_adisi@quicinc.com>
    wifi: cfg80211: validate AP phy operation before starting it

Gustavo A. R. Silva <gustavoars@kernel.org>
    wifi: mwifiex: Sanity check tlv_len and tlv_bitmap_len

Clément Léger <cleger@rivosinc.com>
    tracing: relax trace_event_eval_update() execution with cond_resched()

Damien Le Moal <dlemoal@kernel.org>
    ata: libata-eh: Fix compilation warning in ata_eh_link_report()

Damien Le Moal <dlemoal@kernel.org>
    ata: libata-core: Fix compilation warning in ata_dev_config_ncq()

Chengfeng Ye <dg573847474@gmail.com>
    gpio: timberdale: Fix potential deadlock on &tgpio->lock

Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
    accel/ivpu: Don't flood dmesg with VPU ready message

Jeff Layton <jlayton@kernel.org>
    overlayfs: set ctime when setting mtime and atime

Heiner Kallweit <hkallweit1@gmail.com>
    i2c: mux: Avoid potential false error message in i2c_mux_add_adapter

Josef Bacik <josef@toxicpanda.com>
    btrfs: initialize start_slot in btrfs_log_prealloc_extents

Filipe Manana <fdmanana@suse.com>
    btrfs: return -EUCLEAN for delayed tree ref with a ref count not equals to 1

Filipe Manana <fdmanana@suse.com>
    btrfs: prevent transaction block reserve underflow when starting transaction

Filipe Manana <fdmanana@suse.com>
    btrfs: fix race when refilling delayed refs block reserve

Chunhai Guo <guochunhai@vivo.com>
    fs-writeback: do not requeue a clean inode having skipped pages

Rob Herring <robh@kernel.org>
    arm64: dts: mediatek: Fix "mediatek,merge-mute" and "mediatek,merge-fifo-en" types

Tony Lindgren <tony@atomide.com>
    ARM: dts: ti: omap: Fix noisy serial with overrun-throttle-ms for mapphone

David Thompson <davthompson@nvidia.com>
    pwr-mlxbf: extend Kconfig to include gpio-mlxbf3 dependency

Mårten Lindahl <marten.lindahl@axis.com>
    iio: light: vcnl4000: Don't power on/off chip in config

Jakub Kicinski <kuba@kernel.org>
    net: check for altname conflicts when changing netdev's netns

Jakub Kicinski <kuba@kernel.org>
    net: fix ifname in netlink ntf during netns move

Jakub Kicinski <kuba@kernel.org>
    net: avoid UAF on deleted altname

Vladimir Oltean <vladimir.oltean@nxp.com>
    net: mdio-mux: fix C45 access returning -EIO after API change

Willem de Bruijn <willemb@google.com>
    net: more strict VIRTIO_NET_HDR_GSO_UDP_L4 validation

Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>
    net: pktgen: Fix interface flags printing

Florian Fainelli <florian.fainelli@broadcom.com>
    net: phy: bcm7xxx: Add missing 16nm EPHY statistics

Aaron Conole <aconole@redhat.com>
    selftests: openvswitch: Add version check for pyroute2

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: revert do not remove elements if set backend implements .abort

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: do not remove elements if set backend implements .abort

Xingyuan Mo <hdthky0@gmail.com>
    nf_tables: fix NULL pointer dereference in nft_inner_init()

Xingyuan Mo <hdthky0@gmail.com>
    nf_tables: fix NULL pointer dereference in nft_expr_inner_parse()

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: do not refresh timeout when resetting element

Christoph Paasch <cpaasch@apple.com>
    netlink: Correct offload_xstats size

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nft_set_rbtree: .deactivate fails if element has expired

Phil Sutter <phil@nwl.cc>
    selftests: netfilter: Run nft_audit.sh in its own netns

Aaron Conole <aconole@redhat.com>
    selftests: openvswitch: Fix the ct_tuple for v4

Aaron Conole <aconole@redhat.com>
    selftests: openvswitch: Catch cases where the tests are killed

Geert Uytterhoeven <geert+renesas@glider.be>
    neighbor: tracing: Move pin6 inside CONFIG_IPV6=y section

Pedro Tammela <pctammela@mojatatu.com>
    net/sched: sch_hfsc: upgrade 'rt' to 'sc' when it becomes a inner curve

Jiri Wiesner <jwiesner@suse.de>
    bonding: Return pointer to data after pull on skb

Jinjie Ruan <ruanjinjie@huawei.com>
    net: dsa: bcm_sf2: Fix possible memory leak in bcm_sf2_mdio_register()

Michal Schmidt <mschmidt@redhat.com>
    i40e: prevent crash on probe if hw registers have invalid values

Shinas Rasheed <srasheed@marvell.com>
    octeon_ep: update BQL sent bytes before ringing doorbell

Dan Carpenter <dan.carpenter@linaro.org>
    net: usb: smsc95xx: Fix an error code in smsc95xx_reset()

Eric Dumazet <edumazet@google.com>
    ipv4: fib: annotate races around nh->nh_saddr_genid and nh->nh_saddr

Shailend Chand <shailend@google.com>
    gve: Do not fully free QPL pages on prefill errors

Eric Dumazet <edumazet@google.com>
    tun: prevent negative ifindex

Mateusz Polchlopek <mateusz.polchlopek@intel.com>
    docs: fix info about representor identification

Kuniyuki Iwashima <kuniyu@amazon.com>
    tcp: Fix listen() warning with v4-mapped-v6 address.

Eric Dumazet <edumazet@google.com>
    tcp: tsq: relax tcp_small_queue_check() when rtx queue contains a single skb

Neal Cardwell <ncardwell@google.com>
    tcp: fix excessive TLP and RACK timeouts from HZ rounding

Josua Mayer <josua@solid-run.com>
    net: rfkill: gpio: prevent value glitch during probe

Ma Ke <make_ruc2021@163.com>
    net: ipv6: fix return value check in esp_remove_trailer

Ma Ke <make_ruc2021@163.com>
    net: ipv4: fix return value check in esp_remove_trailer

Johannes Berg <johannes.berg@intel.com>
    wifi: cfg80211: use system_unbound_wq for wiphy work

Masami Hiramatsu (Google) <mhiramat@kernel.org>
    fprobe: Fix to ensure the number of active retprobes is not zero

Dong Chenchen <dongchenchen2@huawei.com>
    net: xfrm: skip policies marked as dead while reinserting policies

Eric Dumazet <edumazet@google.com>
    xfrm: interface: use DEV_STATS_INC()

Eric Dumazet <edumazet@google.com>
    xfrm: fix a data-race in xfrm_gen_index()

Zhang Changzhong <zhangchangzhong@huawei.com>
    xfrm6: fix inet6_dev refcount underflow problem

Eric Dumazet <edumazet@google.com>
    xfrm: fix a data-race in xfrm_lookup_with_ifid()

Manish Chopra <manishc@marvell.com>
    qed: fix LL2 RX buffer allocation

Johan Hovold <johan+linaro@kernel.org>
    ASoC: codecs: wcd938x: fix runtime PM imbalance on remove

Johan Hovold <johan+linaro@kernel.org>
    ASoC: codecs: wcd938x: fix regulator leaks on probe errors

Johan Hovold <johan+linaro@kernel.org>
    ASoC: codecs: wcd938x: fix resource leaks on bind errors

Johan Hovold <johan+linaro@kernel.org>
    ASoC: codecs: wcd938x: fix unbind tear down order

Johan Hovold <johan+linaro@kernel.org>
    ASoC: codecs: wcd938x: drop bogus bind error handling

Johan Hovold <johan+linaro@kernel.org>
    ASoC: codecs: wcd938x-sdw: fix runtime PM imbalance on probe errors

Johan Hovold <johan+linaro@kernel.org>
    ASoC: codecs: wcd938x-sdw: fix use after free on driver unbind

Luka Guzenko <l.guzenko@web.de>
    ALSA: hda/relatek: Enable Mute LED on HP Laptop 15s-fq5xxx

Artem Borisov <dedsa2002@gmail.com>
    ALSA: hda/realtek: Add quirk for ASUS ROG GU603ZV

Kailang Yang <kailang@realtek.com>
    ALSA: hda/realtek - Fixed ASUS platform headset Mic issue

Hamza Mahfooz <hamza.mahfooz@amd.com>
    drm/edid: add 8 bpc quirk to the BenQ GW2765

Karol Herbst <kherbst@redhat.com>
    drm/nouveau/disp: fix DP capable DSM connectors

Chen-Yu Tsai <wenst@chromium.org>
    drm/mediatek: Correctly free sg_table in gem prime vmap

Ville Syrjälä <ville.syrjala@linux.intel.com>
    drm/i915: Retry gtt fault when out of fence registers

Sagi Grimberg <sagi@grimberg.me>
    nvmet-tcp: Fix a possible UAF in queue intialization setup

Jens Axboe <axboe@kernel.dk>
    io_uring: fix crash with IORING_SETUP_NO_MMAP and invalid SQ ring address

Florian Westphal <fw@strlen.de>
    netfilter: nft_payload: fix wrong mac header matching

Bagas Sanjaya <bagasdotme@gmail.com>
    Revert "net: wwan: iosm: enable runtime pm support for 7560"

Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
    fs/ntfs3: fix deadlock in mark_as_free_ex

Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
    fs/ntfs3: Fix shift-out-of-bounds in ntfs_fill_super

Zeng Heng <zengheng4@huawei.com>
    fs/ntfs3: fix panic about slab-out-of-bounds caused by ntfs_list_ea()

Ziqi Zhao <astrajoan@yahoo.com>
    fs/ntfs3: Fix possible null-pointer dereference in hdr_find_e()

Pavel Skripkin <paskripkin@gmail.com>
    fs/ntfs3: Fix OOB read in ntfs_init_from_boot

Catalin Marinas <catalin.marinas@arm.com>
    mm: slab: Do not create kmalloc caches smaller than arch_slab_minalign()

Matthieu Baerts <matttbe@kernel.org>
    selftests: mptcp: join: no RST when rm subflow/addr

Paolo Abeni <pabeni@redhat.com>
    mptcp: more conservative check for zero probes

Paolo Abeni <pabeni@redhat.com>
    tcp: check mptcp-level constraints for backlog coalescing

Dan Clash <daclash@linux.microsoft.com>
    audit,io_uring: io_uring openat triggers audit reference count underflow

Maxim Levitsky <mlevitsk@redhat.com>
    x86: KVM: SVM: refresh AVIC inhibition in svm_leave_nested()

Maxim Levitsky <mlevitsk@redhat.com>
    x86: KVM: SVM: add support for Invalid IPI Vector interception

Maxim Levitsky <mlevitsk@redhat.com>
    x86: KVM: SVM: always update the x2avic msr interception

Sean Christopherson <seanjc@google.com>
    KVM: x86: Constrain guest-supported xfeatures only at KVM_GET_XSAVE{2}

Roman Kagan <rkagan@amazon.de>
    KVM: x86/pmu: Truncate counter value to allowed width on write

Sean Christopherson <seanjc@google.com>
    x86/fpu: Allow caller to constrain xfeatures when copying to uabi buffer

Joerg Roedel <jroedel@suse.de>
    x86/sev: Check for user-space IOIO pointing to kernel space

Joerg Roedel <jroedel@suse.de>
    x86/sev: Check IOBM for IOIO exceptions from user-space

Borislav Petkov (AMD) <bp@alien8.de>
    x86/sev: Disable MMIO emulation from user mode

Jim Mattson <jmattson@google.com>
    KVM: x86: Mask LVTPC when handling a PMI

Johan Hovold <johan+linaro@kernel.org>
    regmap: fix NULL deref on lookup

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    nfc: nci: fix possible NULL pointer dereference in send_acknowledge()

Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
    btrfs: fix stripe length calculation for non-zoned data chunk allocation

Dust Li <dust.li@linux.alibaba.com>
    net/smc: return the right falback reason when prefix checks fail

Jesse Brandeburg <jesse.brandeburg@intel.com>
    ice: reset first in crash dump kernels

Mateusz Pacuszka <mateuszx.pacuszka@intel.com>
    ice: Fix safe mode when DDP is missing

Jesse Brandeburg <jesse.brandeburg@intel.com>
    ice: fix over-shifted variable

Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
    Bluetooth: hci_conn: Fix modifying handle while aborting

Arnd Bergmann <arnd@arndb.de>
    Bluetooth: avoid memcmp() out of bounds warning

Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
    Bluetooth: hci_event: Fix coding style

Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
    Bluetooth: vhci: Fix race when opening vhci device

Ziyang Xuan <william.xuanziyang@huawei.com>
    Bluetooth: Fix a refcnt underflow problem for hci_conn

Lee, Chun-Yi <jlee@suse.com>
    Bluetooth: Reject connection with the device which has same BD_ADDR

Lee, Chun-Yi <jlee@suse.com>
    Bluetooth: hci_event: Ignore NULL link key


-------------

Diffstat:

 .../devicetree/bindings/mmc/sdhci-msm.yaml         |   2 +-
 Documentation/networking/representors.rst          |   8 +-
 Documentation/rust/general-information.rst         |   2 +-
 Documentation/rust/index.rst                       |   8 +
 Makefile                                           |   6 +-
 .../boot/dts/ti/omap/motorola-mapphone-common.dtsi |   1 +
 arch/arm64/boot/dts/mediatek/mt8195.dtsi           |  10 +-
 arch/powerpc/Kconfig                               |   2 +-
 arch/powerpc/lib/qspinlock.c                       |   3 +
 arch/s390/pci/pci_dma.c                            |  15 +-
 arch/x86/boot/compressed/sev.c                     |  10 ++
 arch/x86/include/asm/fpu/api.h                     |   3 +-
 arch/x86/include/asm/svm.h                         |   1 +
 arch/x86/kernel/fpu/core.c                         |   5 +-
 arch/x86/kernel/fpu/xstate.c                       |  12 +-
 arch/x86/kernel/fpu/xstate.h                       |   3 +-
 arch/x86/kernel/sev-shared.c                       |  53 +++++--
 arch/x86/kernel/sev.c                              |  30 ++++
 arch/x86/kvm/cpuid.c                               |   8 -
 arch/x86/kvm/lapic.c                               |   8 +-
 arch/x86/kvm/pmu.h                                 |   6 +
 arch/x86/kvm/svm/avic.c                            |   5 +-
 arch/x86/kvm/svm/nested.c                          |   3 +
 arch/x86/kvm/svm/pmu.c                             |   2 +-
 arch/x86/kvm/svm/svm.c                             |   3 +-
 arch/x86/kvm/vmx/pmu_intel.c                       |   4 +-
 arch/x86/kvm/x86.c                                 |  37 +++--
 crypto/asymmetric_keys/public_key.c                |   5 +-
 drivers/accel/ivpu/ivpu_drv.c                      |   2 +-
 drivers/accel/ivpu/ivpu_fw.c                       |   9 +-
 drivers/accel/ivpu/ivpu_gem.h                      |   5 -
 drivers/acpi/bus.c                                 |   2 +-
 drivers/acpi/irq.c                                 |   7 +-
 drivers/ata/libata-core.c                          |   2 +-
 drivers/ata/libata-eh.c                            |   2 +-
 drivers/base/regmap/regmap.c                       |   2 +-
 drivers/bluetooth/btusb.c                          |   1 +
 drivers/bluetooth/hci_vhci.c                       |   3 +
 drivers/firmware/efi/unaccepted_memory.c           |  64 +++++++-
 drivers/gpio/gpio-timberdale.c                     |   5 +-
 drivers/gpio/gpio-vf610.c                          |   7 +-
 drivers/gpio/gpiolib-acpi.c                        |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c             |   3 +-
 drivers/gpu/drm/amd/pm/amdgpu_pm.c                 |   1 +
 drivers/gpu/drm/bridge/ti-sn65dsi86.c              |  14 +-
 drivers/gpu/drm/drm_edid.c                         |   3 +
 drivers/gpu/drm/drm_panel_orientation_quirks.c     |  16 ++
 drivers/gpu/drm/i915/display/intel_cx0_phy.c       |   3 +-
 drivers/gpu/drm/i915/gem/i915_gem_mman.c           |   1 +
 drivers/gpu/drm/mediatek/mtk_drm_gem.c             |   6 +-
 drivers/gpu/drm/nouveau/nvkm/engine/disp/uconn.c   |  14 +-
 drivers/gpu/drm/panel/panel-edp.c                  |  29 ----
 drivers/gpu/drm/panel/panel-simple.c               |  35 +++++
 drivers/hid/hid-holtek-kbd.c                       |   4 +
 drivers/hid/hid-ids.h                              |   1 +
 drivers/hid/hid-input.c                            |   2 +
 drivers/hid/hid-logitech-hidpp.c                   |   2 +
 drivers/hid/hid-multitouch.c                       |   4 +
 drivers/hid/hid-nintendo.c                         | 175 ++++++++++++---------
 drivers/i2c/i2c-mux.c                              |   2 +-
 drivers/iio/light/vcnl4000.c                       |   1 -
 drivers/mmc/core/block.c                           |  31 ++--
 drivers/mmc/core/mmc.c                             |   2 +-
 drivers/mmc/core/sdio.c                            |   8 +-
 drivers/mmc/host/mtk-sd.c                          |   6 +-
 drivers/mmc/host/sdhci-pci-gli.c                   | 104 +++++++-----
 drivers/mtd/maps/physmap-core.c                    |  11 ++
 drivers/mtd/nand/raw/arasan-nand-controller.c      |  16 +-
 drivers/mtd/nand/raw/marvell_nand.c                |  23 ++-
 drivers/mtd/nand/raw/nand_base.c                   |   3 +
 drivers/mtd/nand/raw/nand_jedec.c                  |   3 +
 drivers/mtd/nand/raw/nand_onfi.c                   |   3 +
 drivers/mtd/nand/raw/pl35x-nand-controller.c       |   9 ++
 drivers/mtd/nand/raw/qcom_nandc.c                  |   2 +-
 drivers/mtd/nand/spi/micron.c                      |   2 +-
 drivers/net/bonding/bond_main.c                    |   2 +-
 drivers/net/dsa/bcm_sf2.c                          |  24 +--
 .../chelsio/inline_crypto/chtls/chtls_io.c         |  36 ++++-
 drivers/net/ethernet/google/gve/gve_rx.c           |  18 ++-
 drivers/net/ethernet/intel/i40e/i40e_common.c      |   4 +-
 drivers/net/ethernet/intel/ice/ice_lib.c           |   3 +-
 drivers/net/ethernet/intel/ice/ice_main.c          |  18 +++
 .../net/ethernet/marvell/octeon_ep/octep_main.c    |  13 +-
 drivers/net/ethernet/marvell/sky2.h                |   2 +-
 .../ethernet/mellanox/mlx5/core/diag/fw_tracer.c   |   2 +-
 .../ethernet/mellanox/mlx5/core/en/tc_tun_encap.c  |   3 +-
 drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c   |   8 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.c   |  10 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c    |  35 +++--
 drivers/net/ethernet/mellanox/mlx5/core/en_stats.h |  11 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c    |   5 +-
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.c  |  17 +-
 drivers/net/ethernet/qlogic/qed/qed_ll2.c          |   7 +-
 drivers/net/mdio/mdio-mux.c                        |  47 ++++++
 drivers/net/phy/bcm7xxx.c                          |   3 +
 drivers/net/tun.c                                  |   7 +-
 drivers/net/usb/smsc95xx.c                         |   2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c        |   3 +
 .../net/wireless/marvell/mwifiex/11n_rxreorder.c   |  16 ++
 drivers/net/wwan/iosm/iosm_ipc_imem.c              |  17 --
 drivers/net/wwan/iosm/iosm_ipc_imem.h              |   2 -
 drivers/net/wwan/iosm/iosm_ipc_pcie.c              |   4 +-
 drivers/net/wwan/iosm/iosm_ipc_port.c              |  17 +-
 drivers/net/wwan/iosm/iosm_ipc_trace.c             |   8 -
 drivers/net/wwan/iosm/iosm_ipc_wwan.c              |  21 +--
 drivers/nvme/host/auth.c                           |   4 +-
 drivers/nvme/host/ioctl.c                          |  10 +-
 drivers/nvme/host/pci.c                            |   3 +-
 drivers/nvme/host/rdma.c                           |   3 +
 drivers/nvme/target/fabrics-cmd-auth.c             |   9 +-
 drivers/nvme/target/tcp.c                          |   7 +-
 drivers/phy/motorola/phy-mapphone-mdm6600.c        |  38 +++--
 drivers/phy/qualcomm/phy-qcom-qmp-combo.c          |   6 +-
 drivers/phy/qualcomm/phy-qcom-qmp-pcs-usb-v6.h     |   3 +-
 drivers/phy/qualcomm/phy-qcom-qmp-usb.c            |  24 ++-
 drivers/pinctrl/core.c                             |  16 +-
 drivers/pinctrl/qcom/pinctrl-lpass-lpi.c           |  17 +-
 .../platform/surface/surface_platform_profile.c    |   3 +-
 drivers/platform/x86/apple-gmux.c                  |  14 +-
 drivers/platform/x86/asus-nb-wmi.c                 |   3 +
 drivers/platform/x86/asus-wmi.c                    |  15 +-
 drivers/platform/x86/asus-wmi.h                    |   2 +-
 .../uncore-frequency/uncore-frequency-common.c     |   8 +-
 drivers/platform/x86/msi-ec.c                      |   3 +-
 drivers/platform/x86/touchscreen_dmi.c             |  45 ++++++
 drivers/power/reset/Kconfig                        |   2 +-
 drivers/regulator/core.c                           |   6 +-
 drivers/s390/cio/css.c                             |   6 +-
 drivers/thunderbolt/tb.c                           |  10 +-
 drivers/usb/serial/option.c                        |   7 +
 fs/btrfs/ctree.c                                   |  52 ++++--
 fs/btrfs/delayed-ref.c                             |  46 ++++--
 fs/btrfs/delayed-ref.h                             |   1 -
 fs/btrfs/extent-tree.c                             |   6 +-
 fs/btrfs/ioctl.c                                   |   4 +-
 fs/btrfs/transaction.c                             |   6 +-
 fs/btrfs/tree-log.c                                |   2 +-
 fs/btrfs/volumes.c                                 |   2 +-
 fs/fs-writeback.c                                  |  11 +-
 fs/namei.c                                         |   9 +-
 fs/nfs/flexfilelayout/flexfilelayout.c             |  17 +-
 fs/nfs/nfs42proc.c                                 |   3 +-
 fs/nfs/nfs4proc.c                                  |   2 -
 fs/nfs/pnfs.c                                      |  33 ++--
 fs/nfs/write.c                                     |   4 +-
 fs/notify/fanotify/fanotify_user.c                 |  25 ++-
 fs/ntfs3/fsntfs.c                                  |   6 +-
 fs/ntfs3/index.c                                   |   3 +
 fs/ntfs3/ntfs_fs.h                                 |   2 +
 fs/ntfs3/super.c                                   |  31 +++-
 fs/ntfs3/xattr.c                                   |   7 +-
 fs/overlayfs/copy_up.c                             |   2 +-
 include/linux/fs.h                                 |   2 +-
 include/linux/mtd/jedec.h                          |   3 +
 include/linux/mtd/onfi.h                           |   1 +
 include/linux/mtd/rawnand.h                        |   2 +
 include/linux/perf_event.h                         |   1 +
 include/linux/virtio_net.h                         |  19 ++-
 include/net/bluetooth/hci_core.h                   |   3 +-
 include/net/bluetooth/hci_mon.h                    |   2 +-
 include/net/bluetooth/hci_sync.h                   |   3 +
 include/net/ip_fib.h                               |   1 +
 include/net/netns/xfrm.h                           |   1 +
 include/net/sock.h                                 |  10 +-
 include/net/tcp.h                                  |   3 +
 include/trace/events/neigh.h                       |   4 +-
 io_uring/io-wq.c                                   |  10 +-
 io_uring/io_uring.c                                |   6 +
 kernel/auditsc.c                                   |   8 +-
 kernel/events/core.c                               |  39 ++++-
 kernel/sched/cpufreq_schedutil.c                   |   3 +-
 kernel/trace/fprobe.c                              |   6 +-
 kernel/trace/trace_events.c                        |   1 +
 kernel/trace/trace_kprobe.c                        |  63 ++++++++
 kernel/trace/trace_probe.h                         |   1 +
 mm/slab_common.c                                   |   6 +-
 net/bluetooth/hci_conn.c                           | 135 +++++++++++-----
 net/bluetooth/hci_core.c                           |   8 +-
 net/bluetooth/hci_event.c                          |  77 +++++----
 net/bluetooth/hci_sock.c                           |   3 +-
 net/bluetooth/hci_sync.c                           |  70 ++++++---
 net/bluetooth/iso.c                                |  14 --
 net/core/dev.c                                     |  65 ++++++--
 net/core/dev.h                                     |   3 +
 net/core/pktgen.c                                  |  14 +-
 net/core/rtnetlink.c                               |   4 +-
 net/core/stream.c                                  |  12 +-
 net/ipv4/af_inet.c                                 |  10 +-
 net/ipv4/esp4.c                                    |   4 +-
 net/ipv4/fib_semantics.c                           |  15 +-
 net/ipv4/fib_trie.c                                |   4 +
 net/ipv4/inet_connection_sock.c                    |   1 -
 net/ipv4/inet_hashtables.c                         |  24 ++-
 net/ipv4/tcp.c                                     |  16 +-
 net/ipv4/tcp_bpf.c                                 |  12 ++
 net/ipv4/tcp_ipv4.c                                |   1 +
 net/ipv4/tcp_output.c                              |  25 ++-
 net/ipv4/tcp_recovery.c                            |   2 +-
 net/ipv6/esp6.c                                    |   4 +-
 net/ipv6/xfrm6_policy.c                            |   4 +-
 net/mac80211/cfg.c                                 |   3 +-
 net/mac80211/ibss.c                                |   2 +-
 net/mac80211/ieee80211_i.h                         |   1 +
 net/mac80211/mesh_plink.c                          |   2 +-
 net/mac80211/mlme.c                                |  27 +++-
 net/mac80211/tx.c                                  |   3 +-
 net/mac80211/vht.c                                 |  16 +-
 net/mptcp/protocol.c                               |  43 ++---
 net/netfilter/nf_tables_api.c                      |  20 +--
 net/netfilter/nft_inner.c                          |   1 +
 net/netfilter/nft_payload.c                        |   2 +-
 net/netfilter/nft_set_rbtree.c                     |   2 +
 net/nfc/nci/spi.c                                  |   2 +
 net/rfkill/core.c                                  |  37 +++--
 net/rfkill/rfkill-gpio.c                           |   4 +-
 net/sched/sch_hfsc.c                               |  18 ++-
 net/smc/af_smc.c                                   |  44 +++++-
 net/smc/smc.h                                      |   5 +-
 net/smc/smc_clc.c                                  |  60 ++++++-
 net/smc/smc_clc.h                                  |  30 +++-
 net/smc/smc_core.h                                 |   1 +
 net/smc/smc_ib.c                                   |   7 +-
 net/smc/smc_ib.h                                   |   2 +-
 net/sunrpc/auth.c                                  |  11 +-
 net/sunrpc/auth_tls.c                              |   4 +-
 net/sunrpc/clnt.c                                  |  10 +-
 net/sunrpc/xprtsock.c                              |   6 +
 net/tls/tls_main.c                                 |  10 +-
 net/tls/tls_sw.c                                   |  57 ++++---
 net/wireless/core.c                                |   2 +-
 net/wireless/nl80211.c                             |  21 ++-
 net/wireless/scan.c                                |   4 +
 net/xfrm/xfrm_interface_core.c                     |  22 ++-
 net/xfrm/xfrm_policy.c                             |  27 ++--
 rust/Makefile                                      |  24 +--
 rust/kernel/error.rs                               |   2 +-
 sound/pci/hda/patch_realtek.c                      |  27 ++++
 sound/soc/codecs/cs35l56.c                         |   2 +-
 sound/soc/codecs/cs42l42-sdw.c                     |   1 +
 sound/soc/codecs/wcd938x-sdw.c                     |  27 +++-
 sound/soc/codecs/wcd938x.c                         |  76 ++++++---
 sound/soc/pxa/pxa-ssp.c                            |   2 +-
 tools/perf/util/dlfilter.c                         |  32 ++--
 .../ftrace/test.d/kprobe/kprobe_non_uniq_symbol.tc |  13 ++
 tools/testing/selftests/net/mptcp/mptcp_join.sh    |  21 ++-
 .../selftests/net/openvswitch/openvswitch.sh       |   4 +-
 .../testing/selftests/net/openvswitch/ovs-dpctl.py |  14 +-
 tools/testing/selftests/netfilter/nft_audit.sh     |   6 +
 248 files changed, 2331 insertions(+), 960 deletions(-)


