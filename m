Return-Path: <linux-kernel+bounces-13411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22B458204CB
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 13:01:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47AAF1C20EC8
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 12:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E2058483;
	Sat, 30 Dec 2023 12:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ipYATHDm"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E3679DC;
	Sat, 30 Dec 2023 12:01:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DD77C433C7;
	Sat, 30 Dec 2023 12:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703937710;
	bh=beVKpINuZkYp2freznV0DPDPmla420tTC8UjQLVHKZ4=;
	h=From:To:Cc:Subject:Date:From;
	b=ipYATHDmaUnjBrF/wK5tHpceBnzb9JBz/eb+kpCLgAKltRUPMG87UuHrQcE94qJtX
	 aJSmGg8mTe63eWFbycl+e5OaHlhqtZ9vU64TNvtVFvb301QiXf38izr9Elbhmk3z31
	 aH1hgsNYHDM/5zwfPWCCZ3Usn889g+wSkuzofhiQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org,
	akpm@linux-foundation.org,
	linux@roeck-us.net,
	shuah@kernel.org,
	patches@kernelci.org,
	lkft-triage@lists.linaro.org,
	pavel@denx.de,
	jonathanh@nvidia.com,
	f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net,
	rwarsow@gmx.de,
	conor@kernel.org,
	allen.lkml@gmail.com
Subject: [PATCH 6.6 000/156] 6.6.9-rc1 review
Date: Sat, 30 Dec 2023 11:57:34 +0000
Message-ID: <20231230115812.333117904@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.9-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.6.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.6.9-rc1
X-KernelTest-Deadline: 2024-01-01T11:58+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is the start of the stable review cycle for the 6.6.9 release.
There are 156 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Mon, 01 Jan 2024 11:57:43 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.9-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 6.6.9-rc1

Nam Cao <namcao@linutronix.de>
    spi: cadence: revert "Add SPI transfer delays"

Thomas Gleixner <tglx@linutronix.de>
    x86/smpboot/64: Handle X2APIC BIOS inconsistency gracefully

Thomas Gleixner <tglx@linutronix.de>
    x86/alternatives: Disable interrupts and sync when optimizing NOPs in place

Thomas Gleixner <tglx@linutronix.de>
    x86/alternatives: Sync core before enabling interrupts

Marc Zyngier <maz@kernel.org>
    KVM: arm64: vgic: Force vcpu vgic teardown on vcpu destroy

Marc Zyngier <maz@kernel.org>
    KVM: arm64: vgic: Add a non-locking primitive for kvm_vgic_vcpu_destroy()

Marc Zyngier <maz@kernel.org>
    KVM: arm64: vgic: Simplify kvm_vgic_destroy()

Yaxiong Tian <tianyaxiong@kylinos.cn>
    thunderbolt: Fix memory leak in margining_port_remove()

Herve Codina <herve.codina@bootlin.com>
    lib/vsprintf: Fix %pfwf when current node refcount == 0

xiongxin <xiongxin@kylinos.cn>
    gpio: dwapb: mask/unmask IRQ when disable/enale it

Tony Lindgren <tony@atomide.com>
    bus: ti-sysc: Flush posted write only after srst_udelay

Nam Cao <namcao@linutronix.de>
    pinctrl: starfive: jh7100: ignore disabled device tree nodes

Nam Cao <namcao@linutronix.de>
    pinctrl: starfive: jh7110: ignore disabled device tree nodes

Geliang Tang <geliang.tang@linux.dev>
    selftests: mptcp: join: fix subflow_send_ack lookup

Mikulas Patocka <mpatocka@redhat.com>
    dm-integrity: don't modify bio's immutable bio_vec in integrity_metadata()

Steven Rostedt (Google) <rostedt@goodmis.org>
    tracing / synthetic: Disable events after testing in synth_event_gen_test_init()

Alexander Atanasov <alexander.atanasov@virtuozzo.com>
    scsi: core: Always send batch on reset or error handling command

Martin K. Petersen <martin.petersen@oracle.com>
    Revert "scsi: aacraid: Reply queue mapping to CPUs based on IRQ affinity"

Rafał Miłecki <rafal@milecki.pl>
    nvmem: brcm_nvram: store a copy of NVRAM content

Louis Chauvet <louis.chauvet@bootlin.com>
    spi: atmel: Fix clock issue when using devices with different polarities

Miquel Raynal <miquel.raynal@bootlin.com>
    spi: atmel: Prevent spi transfers from being killed

Miquel Raynal <miquel.raynal@bootlin.com>
    spi: atmel: Do not cancel a transfer upon any signal

Steven Rostedt (Google) <rostedt@goodmis.org>
    ring-buffer: Fix slowpath of interrupted event

Steven Rostedt (Google) <rostedt@goodmis.org>
    ring-buffer: Remove useless update to write_stamp in rb_try_to_discard()

Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
    ring-buffer: Fix 32-bit rb_time_read() race with rb_time_cmpxchg()

JP Kobryn <inwardvessel@gmail.com>
    9p: prevent read overrun in protocol dump tracepoint

Ville Syrjälä <ville.syrjala@linux.intel.com>
    drm/i915/dmc: Don't enable any pipe DMC events

Ville Syrjälä <ville.syrjala@linux.intel.com>
    drm/i915: Reject async flips with bigjoiner

Paulo Alcantara <pc@manguebit.com>
    smb: client: fix OOB in smbCalcSize()

Paulo Alcantara <pc@manguebit.com>
    smb: client: fix OOB in SMB2_query_info_init()

Paulo Alcantara <pc@manguebit.com>
    smb: client: fix potential OOB in cifs_dump_detail()

Paulo Alcantara <pc@manguebit.com>
    smb: client: fix OOB in cifsd when receiving compounded resps

NeilBrown <neilb@suse.de>
    nfsd: call nfsd_last_thread() before final nfsd_put()

Fabio Estevam <festevam@denx.de>
    dt-bindings: nvmem: mxs-ocotp: Document fsl,ocotp

Lai Peter Jun Ann <jun.ann.lai@intel.com>
    net: stmmac: fix incorrect flag check in timestamp interrupt

Thomas Weißschuh <linux@weissschuh.net>
    net: avoid build bug in skb extension length calculation

Ronald Wahl <ronald.wahl@raritan.com>
    net: ks8851: Fix TX stall caused by TX buffer overrun

Rouven Czerwinski <r.czerwinski@pengutronix.de>
    net: rfkill: gpio: set GPIO direction

Fedor Pchelkin <pchelkin@ispras.ru>
    net: 9p: avoid freeing uninit memory in p9pdu_vreadf

Christoffer Sandberg <cs@tuxedo.de>
    Input: soc_button_array - add mapping for airplane mode button

Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
    net: usb: ax88179_178a: avoid failed operations when device is disconnected

Dan Carpenter <dan.carpenter@linaro.org>
    usb: fotg210-hcd: delete an incorrect bounds test

Johan Hovold <johan+linaro@kernel.org>
    usb: typec: ucsi: fix gpio-based orientation detection

Alex Lu <alex_lu@realsil.com.cn>
    Bluetooth: Add more enc key size check

Xiao Yao <xiaoyao@rock-chips.com>
    Bluetooth: MGMT/SMP: Fix address type when using SMP over BREDR/LE

Frédéric Danis <frederic.danis@collabora.com>
    Bluetooth: L2CAP: Send reject on command corrupted request

Hyunwoo Kim <v4bel@theori.io>
    Bluetooth: af_bluetooth: Fix Use-After-Free in bt_sock_recvmsg

Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
    Bluetooth: hci_event: Fix not checking if HCI_OP_INQUIRY has been sent

Gergo Koteles <soyer@irl.hu>
    ASoC: tas2781: check the validity of prm_no/cfg_no

Clément Villeret <clement.villeret@gmail.com>
    ALSA: hda/realtek: Add quirk for ASUS ROG GV302XA

Gergo Koteles <soyer@irl.hu>
    ALSA: hda/tas2781: select program 0, conf 0 by default

Reinhard Speyerer <rspmn@arcor.de>
    USB: serial: option: add Quectel RM500Q R13 firmware support

Slark Xiao <slark_xiao@163.com>
    USB: serial: option: add Foxconn T99W265 with new baseline

Alper Ak <alperyasinak1@gmail.com>
    USB: serial: option: add Quectel EG912Y module support

Mark Glover <mark.glover@actisense.com>
    USB: serial: ftdi_sio: update Actisense PIDs constant names

Johannes Berg <johannes.berg@intel.com>
    wifi: cfg80211: fix certs build to not depend on file order

Chen-Yu Tsai <wens@kernel.org>
    wifi: cfg80211: Add my certificate

Felix Fietkau <nbd@nbd.name>
    wifi: mt76: fix crash with WED rx support enabled

Tasos Sahanidis <tasos@tasossah.com>
    usb-storage: Add quirk for incorrect WP on Kingston DT Ultimate 3.0 G3

Tony Lindgren <tony@atomide.com>
    ARM: dts: Fix occasional boot hang for am3 usb

Jeremie Knuesel <knuesel@gmail.com>
    ALSA: usb-audio: Increase delay in MOTU M quirk

David Lechner <dlechner@baylibre.com>
    iio: triggered-buffer: prevent possible freeing of wrong buffer

Javier Carrasco <javier.carrasco@wolfvision.net>
    iio: tmag5273: fix temperature offset

Wadim Egorov <w.egorov@phytec.de>
    iio: adc: ti_am335x_adc: Fix return value check of tiadc_request_dma()

Nuno Sa <nuno.sa@analog.com>
    iio: imu: adis16475: add spi_device_id table

Javier Carrasco <javier.carrasco.cruz@gmail.com>
    iio: common: ms_sensors: ms_sensors_i2c: fix humidity conversion time table

Haibo Chen <haibo.chen@nxp.com>
    iio: adc: imx93: add four channels for imx93 adc

Matti Vaittinen <mazziesaccount@gmail.com>
    iio: kx022a: Fix acceleration value scaling

Can Guo <quic_cang@quicinc.com>
    scsi: ufs: core: Let the sq_lock protect sq_tail_slot access

ChanWoo Lee <cw9316.lee@samsung.com>
    scsi: ufs: qcom: Return ufs_qcom_clk_scale_*() errors in ufs_qcom_clk_scale_notify()

Wei Yongjun <weiyongjun1@huawei.com>
    scsi: bnx2fc: Fix skb double free in bnx2fc_rcv()

George Stark <gnstark@salutedevices.com>
    iio: adc: meson: add separate config for axg SoC family

Haoran Liu <liuhaoran14@163.com>
    Input: ipaq-micro-keys - add error handling for devm_kmemdup

Konrad Dybcio <konrad.dybcio@linaro.org>
    interconnect: qcom: sm8250: Enable sync_state

Su Hui <suhui@nfschina.com>
    iio: imu: inv_mpu6050: fix an error code problem in inv_mpu6050_read_raw

Mike Tipton <quic_mdtipton@quicinc.com>
    interconnect: Treat xlate() returning NULL node as an error

Maurizio Lombardi <mlombard@redhat.com>
    nvme-pci: fix sleeping function called from interrupt context

Kent Gibson <warthog618@gmail.com>
    gpiolib: cdev: add gpio_device locking wrapper around gpio_ioctl()

Alexis Lothoré <alexis.lothore@bootlin.com>
    pinctrl: at91-pio4: use dedicated lock class for IRQ

Arnd Bergmann <arnd@arndb.de>
    x86/xen: add CPU dependencies for 32-bit build

Quan Nguyen <quan@os.amperecomputing.com>
    i2c: aspeed: Handle the coalesced stop conditions with the start conditions.

ZhenGuo Yin <zhenguo.yin@amd.com>
    drm/amdgpu: re-create idle bo's PTE during VM state machine reset

Yang Yingliang <yangyingliang@huawei.com>
    i2c: qcom-geni: fix missing clk_disable_unprepare() and geni_se_resources_off()

Shengjiu Wang <shengjiu.wang@nxp.com>
    ASoC: fsl_sai: Fix channel swap issue on i.MX8MP

Jerome Brunet <jbrunet@baylibre.com>
    ASoC: hdmi-codec: fix missing report for jack initial status

Imre Deak <imre.deak@intel.com>
    drm/i915/mtl: Fix HDMI/DP PLL clock selection

Karthik Poosa <karthik.poosa@intel.com>
    drm/i915/hwmon: Fix static analysis tool reported issues

David Howells <dhowells@redhat.com>
    afs: Fix use-after-free due to get/remove race in volume tree

David Howells <dhowells@redhat.com>
    afs: Fix overwriting of result of DNS query

David Howells <dhowells@redhat.com>
    keys, dns: Allow key types (eg. DNS) to be reclaimed immediately on expiry

Eric Dumazet <edumazet@google.com>
    net: check dev->gso_max_size in gso_features_check()

David Ahern <dsahern@kernel.org>
    net/ipv6: Revert remove expired routes with a separated list of routes

Lorenzo Bianconi <lorenzo@kernel.org>
    net: ethernet: mtk_wed: fix possible NULL pointer dereference in mtk_wed_wo_queue_tx_clean()

David Howells <dhowells@redhat.com>
    afs: Fix dynamic root lookup DNS check

David Howells <dhowells@redhat.com>
    afs: Fix the dynamic root's d_delete to always delete unused dentries

Liu Jian <liujian56@huawei.com>
    net: check vlan filter feature in vlan_vids_add_by_dev() and vlan_vids_del_by_dev()

Yury Norov <yury.norov@gmail.com>
    net: mana: select PAGE_POOL

Larysa Zaremba <larysa.zaremba@intel.com>
    ice: Fix PF with enabled XDP going no-carrier after reset

Dave Ertman <david.m.ertman@intel.com>
    ice: alter feature support check for SRIOV and LAG

Jacob Keller <jacob.e.keller@intel.com>
    ice: stop trashing VF VSI aggregator node ID information

Daniel Golle <daniel@makrotopia.org>
    net: phy: skip LED triggers on PHYs on SFP modules

Andy Gospodarek <andrew.gospodarek@broadcom.com>
    bnxt_en: do not map packet buffers twice

Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
    Bluetooth: hci_core: Fix hci_conn_hash_lookup_cis

Arnd Bergmann <arnd@arndb.de>
    Bluetooth: hci_event: shut up a false-positive warning

Ying Hsu <yinghsu@chromium.org>
    Bluetooth: Fix deadlock in vhci_send_frame

Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
    Bluetooth: Fix not notifying when connection encryption changes

Eric Dumazet <edumazet@google.com>
    net/rose: fix races in rose_kill_by_device()

Zhipeng Lu <alexious@zju.edu.cn>
    ethernet: atheros: fix a memleak in atl1e_setup_ring_resources

Eric Dumazet <edumazet@google.com>
    net: sched: ife: fix potential use-after-free

Shigeru Yoshida <syoshida@redhat.com>
    net: Return error from sk_stream_wait_connect() if sk_wait_event() fails

Suman Ghosh <sumang@marvell.com>
    octeontx2-pf: Fix graceful exit during PFC configuration failure

Vladimir Oltean <vladimir.oltean@nxp.com>
    net: mscc: ocelot: fix pMAC TX RMON stats for bucket 256-511 and above

Vladimir Oltean <vladimir.oltean@nxp.com>
    net: mscc: ocelot: fix eMAC TX RMON stats for bucket 256-511 and above

Rahul Rameshbabu <rrameshbabu@nvidia.com>
    net/mlx5e: Correct snprintf truncation handling for fw_version buffer used by representors

Rahul Rameshbabu <rrameshbabu@nvidia.com>
    net/mlx5e: Correct snprintf truncation handling for fw_version buffer

Dan Carpenter <dan.carpenter@linaro.org>
    net/mlx5e: Fix error codes in alloc_branch_attr()

Dan Carpenter <dan.carpenter@linaro.org>
    net/mlx5e: Fix error code in mlx5e_tc_action_miss_mapping_get()

Vlad Buslov <vladbu@nvidia.com>
    net/mlx5: Refactor mlx5_flow_destination->rep pointer to vport num

Moshe Shemesh <moshe@nvidia.com>
    net/mlx5: Fix fw tracer first block check

Carolina Jubran <cjubran@nvidia.com>
    net/mlx5e: XDP, Drop fragmented packets larger than MTU size

Chris Mi <cmi@nvidia.com>
    net/mlx5e: Decrease num_block_tc when unblock tc offload

Jianbo Liu <jianbol@nvidia.com>
    net/mlx5e: Fix overrun reported by coverity

Dinghao Liu <dinghao.liu@zju.edu.cn>
    net/mlx5e: fix a potential double-free in fs_udp_create_groups

Shifeng Li <lishifeng@sangfor.com.cn>
    net/mlx5e: Fix a race in command alloc flow

Shifeng Li <lishifeng@sangfor.com.cn>
    net/mlx5e: Fix slab-out-of-bounds in mlx5_query_nic_vport_mac_list()

Vlad Buslov <vladbu@nvidia.com>
    Revert "net/mlx5e: fix double free of encap_header"

Vlad Buslov <vladbu@nvidia.com>
    Revert "net/mlx5e: fix double free of encap_header in update funcs"

John Fastabend <john.fastabend@gmail.com>
    bpf: syzkaller found null ptr deref in unix_bpf proto add

Michal Schmidt <mschmidt@redhat.com>
    ice: fix theoretical out-of-bounds access in ethtool link modes

Johannes Berg <johannes.berg@intel.com>
    wifi: mac80211: mesh_plink: fix matches_local logic

Johannes Berg <johannes.berg@intel.com>
    wifi: mac80211: mesh: check element parsing succeeded

Johannes Berg <johannes.berg@intel.com>
    wifi: mac80211: check defragmentation succeeded

Johannes Berg <johannes.berg@intel.com>
    wifi: mac80211: don't re-add debugfs during reconfig

Edward Adam Davis <eadavis@qq.com>
    wifi: mac80211: check if the existing link config remains unchanged

Johannes Berg <johannes.berg@intel.com>
    wifi: iwlwifi: pcie: add another missing bh-disable for rxq->lock

Johannes Berg <johannes.berg@intel.com>
    wifi: ieee80211: don't require protected vendor action frames

Chuck Lever <chuck.lever@oracle.com>
    SUNRPC: Revert 5f7fc5d69f6e92ec0b38774c387f5cf7812c5806

Rajvi Jingar <rajvi.jingar@linux.intel.com>
    platform/x86/intel/pmc: Fix hang in pmc_core_send_ltr_ignore()

Heiko Carstens <hca@linux.ibm.com>
    s390/vx: fix save/restore of fpu kernel context

Geert Uytterhoeven <geert+renesas@glider.be>
    reset: Fix crash when freeing non-existent optional resets

Kunwu Chan <chentao@kylinos.cn>
    ARM: OMAP2+: Fix null pointer dereference and memory leak in omap_soc_device_init

Andrew Davis <afd@ti.com>
    ARM: dts: dra7: Fix DRA7 L3 NoC node register size

Chukun Pan <amadeus@jmu.edu.cn>
    arm64: dts: allwinner: h616: update emac for Orange Pi Zero 3

Benjamin Bigler <benjamin@bigler.one>
    spi: spi-imx: correctly configure burst length when using dma

Lingkai Dong <Lingkai.Dong@arm.com>
    drm: Fix FD ownership check in drm_master_check_perm()

Tvrtko Ursulin <tvrtko.ursulin@intel.com>
    drm: Update file owner during use

Jani Nikula <jani.nikula@intel.com>
    drm/i915/edp: don't write to DP_LINK_BW_SET when using rate select

Ville Syrjälä <ville.syrjala@linux.intel.com>
    drm/i915: Introduce crtc_state->enhanced_framing

Ville Syrjälä <ville.syrjala@linux.intel.com>
    drm/i915: Fix FEC state dump

Hamza Mahfooz <hamza.mahfooz@amd.com>
    drm/amd/display: fix hw rotated modes when PSR-SU is enabled

Boris Burkov <boris@bur.io>
    btrfs: free qgroup pertrans reserve on transaction abort

Qu Wenruo <wqu@suse.com>
    btrfs: qgroup: use qgroup_iterator in qgroup_convert_meta()

Qu Wenruo <wqu@suse.com>
    btrfs: qgroup: iterate qgroups without memory allocation for qgroup_reserve()

SeongJae Park <sj@kernel.org>
    mm/damon/core: make damon_start() waits until kdamond_fn() starts

SeongJae Park <sj@kernel.org>
    mm/damon/core: use number of passed access sampling as a timer

Jiri Olsa <jolsa@kernel.org>
    bpf: Fix prog_array_map_poke_run map poke update


-------------

Diffstat:

 .../devicetree/bindings/nvmem/mxs-ocotp.yaml       |  10 +-
 Makefile                                           |   4 +-
 arch/arm/boot/dts/ti/omap/am33xx.dtsi              |   1 +
 arch/arm/boot/dts/ti/omap/dra7.dtsi                |   2 +-
 arch/arm/mach-omap2/id.c                           |   5 +
 .../dts/allwinner/sun50i-h616-orangepi-zero.dtsi   |   3 -
 .../dts/allwinner/sun50i-h616-orangepi-zero2.dts   |   3 +
 .../dts/allwinner/sun50i-h618-orangepi-zero3.dts   |   2 +
 arch/arm64/kvm/arm.c                               |   2 +-
 arch/arm64/kvm/vgic/vgic-init.c                    |  47 +++++---
 arch/arm64/kvm/vgic/vgic-mmio-v3.c                 |   2 +-
 arch/arm64/kvm/vgic/vgic.h                         |   1 +
 arch/s390/include/asm/fpu/api.h                    |   2 +-
 arch/x86/kernel/alternative.c                      |  14 ++-
 arch/x86/kernel/head_64.S                          |  16 +++
 arch/x86/net/bpf_jit_comp.c                        |  46 +++++++
 arch/x86/xen/Kconfig                               |   1 +
 drivers/bluetooth/hci_vhci.c                       |  10 +-
 drivers/bus/ti-sysc.c                              |  18 ++-
 drivers/gpio/gpio-dwapb.c                          |  12 +-
 drivers/gpio/gpiolib-cdev.c                        |  16 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c            |   6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c             |   1 +
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |   3 +
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h       |   1 +
 .../drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c  |   3 +-
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c  |  12 +-
 drivers/gpu/drm/drm_auth.c                         |   3 +-
 drivers/gpu/drm/drm_debugfs.c                      |  10 +-
 drivers/gpu/drm/drm_file.c                         |  40 +++++-
 drivers/gpu/drm/drm_ioctl.c                        |   3 +
 drivers/gpu/drm/i915/display/g4x_dp.c              |  10 +-
 drivers/gpu/drm/i915/display/intel_crt.c           |   2 +
 .../gpu/drm/i915/display/intel_crtc_state_dump.c   |   3 +
 drivers/gpu/drm/i915/display/intel_cx0_phy.c       |   3 +-
 drivers/gpu/drm/i915/display/intel_ddi.c           |  22 ++--
 drivers/gpu/drm/i915/display/intel_display.c       |  12 ++
 drivers/gpu/drm/i915/display/intel_display_types.h |   2 +
 drivers/gpu/drm/i915/display/intel_dmc.c           |  43 ++++++-
 drivers/gpu/drm/i915/display/intel_dp.c            |   3 +
 .../gpu/drm/i915/display/intel_dp_link_training.c  |  35 ++++--
 drivers/gpu/drm/i915/i915_hwmon.c                  |   4 +-
 drivers/gpu/drm/nouveau/nouveau_drm.c              |   5 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_gem.c                |   6 +-
 drivers/i2c/busses/i2c-aspeed.c                    |  48 +++++---
 drivers/i2c/busses/i2c-qcom-geni.c                 |   8 +-
 drivers/iio/accel/kionix-kx022a.c                  |  37 ++++--
 drivers/iio/adc/imx93_adc.c                        |   4 +
 drivers/iio/adc/meson_saradc.c                     |  16 ++-
 drivers/iio/adc/ti_am335x_adc.c                    |   4 +-
 drivers/iio/buffer/industrialio-triggered-buffer.c |  10 ++
 drivers/iio/common/ms_sensors/ms_sensors_i2c.c     |   4 +-
 drivers/iio/imu/adis16475.c                        | 117 +++++++++++-------
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c         |   4 +-
 drivers/iio/magnetometer/tmag5273.c                |   2 +-
 drivers/input/keyboard/ipaq-micro-keys.c           |   3 +
 drivers/input/misc/soc_button_array.c              |   5 +
 drivers/interconnect/core.c                        |   3 +
 drivers/interconnect/qcom/sm8250.c                 |   1 +
 drivers/md/dm-integrity.c                          |  11 +-
 drivers/net/ethernet/atheros/atl1e/atl1e_main.c    |   5 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c      |  11 +-
 drivers/net/ethernet/intel/ice/ice_ethtool.c       |   4 +-
 drivers/net/ethernet/intel/ice/ice_lag.c           |   2 +
 drivers/net/ethernet/intel/ice/ice_lib.c           |   7 +-
 .../ethernet/marvell/octeontx2/nic/otx2_dcbnl.c    |  17 ++-
 drivers/net/ethernet/mediatek/mtk_wed_wo.c         |   3 +
 drivers/net/ethernet/mellanox/mlx5/core/cmd.c      |  12 +-
 .../ethernet/mellanox/mlx5/core/diag/fw_tracer.c   |   2 +-
 .../mellanox/mlx5/core/en/fs_tt_redirect.c         |   1 +
 .../ethernet/mellanox/mlx5/core/en/tc/act/mirred.c |   5 +-
 .../net/ethernet/mellanox/mlx5/core/en/tc_tun.c    |  30 ++---
 .../ethernet/mellanox/mlx5/core/en/tc_tun_encap.c  |   3 +-
 drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c   |   4 +-
 .../mellanox/mlx5/core/en_accel/ipsec_fs.c         |   2 +-
 .../net/ethernet/mellanox/mlx5/core/en_ethtool.c   |   2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.c   |   2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c    |  10 +-
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.h  |   3 +-
 .../ethernet/mellanox/mlx5/core/eswitch_offloads.c |  31 +++--
 .../mellanox/mlx5/core/eswitch_offloads_termtbl.c  |   4 +-
 drivers/net/ethernet/mellanox/mlx5/core/vport.c    |   2 +-
 drivers/net/ethernet/micrel/ks8851.h               |   3 +
 drivers/net/ethernet/micrel/ks8851_common.c        |  20 +--
 drivers/net/ethernet/micrel/ks8851_spi.c           |  42 ++++---
 drivers/net/ethernet/microsoft/Kconfig             |   1 +
 drivers/net/ethernet/mscc/ocelot_stats.c           |  16 +--
 .../net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c  |   2 +-
 drivers/net/phy/phy_device.c                       |   6 +-
 drivers/net/usb/ax88179_178a.c                     |  23 +++-
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c    |   4 +-
 drivers/net/wireless/mediatek/mt76/dma.c           |  10 +-
 drivers/nvme/host/core.c                           |   3 +-
 drivers/nvmem/brcm_nvram.c                         | 134 +++++++++++++++------
 drivers/pinctrl/pinctrl-at91-pio4.c                |   8 ++
 drivers/pinctrl/starfive/pinctrl-starfive-jh7100.c |   4 +-
 drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c |   4 +-
 drivers/platform/x86/intel/pmc/core.c              |   2 +-
 drivers/reset/core.c                               |   8 +-
 drivers/scsi/aacraid/aacraid.h                     |   1 -
 drivers/scsi/aacraid/commsup.c                     |   6 +-
 drivers/scsi/aacraid/linit.c                       |  14 ---
 drivers/scsi/aacraid/src.c                         |  25 +---
 drivers/scsi/bnx2fc/bnx2fc_fcoe.c                  |   9 +-
 drivers/scsi/scsi_error.c                          |   2 +
 drivers/spi/spi-atmel.c                            |  92 ++++++++++++--
 drivers/spi/spi-cadence.c                          |   1 -
 drivers/spi/spi-imx.c                              |  15 ++-
 drivers/thunderbolt/debugfs.c                      |   2 +-
 drivers/ufs/core/ufshcd.c                          |   3 +-
 drivers/ufs/host/ufs-qcom.c                        |   6 +-
 drivers/usb/fotg210/fotg210-hcd.c                  |   3 -
 drivers/usb/serial/ftdi_sio.c                      |   6 +-
 drivers/usb/serial/ftdi_sio_ids.h                  |   6 +-
 drivers/usb/serial/option.c                        |   5 +
 drivers/usb/storage/unusual_devs.h                 |  11 ++
 drivers/usb/typec/ucsi/ucsi_glink.c                |   2 +-
 fs/afs/cell.c                                      |   6 +-
 fs/afs/dynroot.c                                   |  31 ++---
 fs/afs/internal.h                                  |   2 +
 fs/afs/volume.c                                    |  26 +++-
 fs/btrfs/disk-io.c                                 |  28 +++++
 fs/btrfs/qgroup.c                                  |  96 +++++++--------
 fs/btrfs/qgroup.h                                  |   9 ++
 fs/btrfs/transaction.c                             |   2 -
 fs/btrfs/transaction.h                             |   3 +
 fs/nfsd/nfsctl.c                                   |   9 +-
 fs/nfsd/nfsd.h                                     |   1 +
 fs/nfsd/nfssvc.c                                   |   2 +-
 fs/smb/client/cifs_debug.c                         |  12 +-
 fs/smb/client/cifsglob.h                           |   3 +-
 fs/smb/client/connect.c                            |   7 +-
 fs/smb/client/misc.c                               |   4 +
 fs/smb/client/smb2ops.c                            |  19 +--
 fs/smb/client/smb2pdu.c                            |  29 +++--
 include/drm/drm_file.h                             |  13 +-
 include/linux/bpf.h                                |   3 +
 include/linux/damon.h                              |  16 ++-
 include/linux/ieee80211.h                          |   3 +-
 include/linux/key-type.h                           |   1 +
 include/net/bluetooth/hci_core.h                   |   9 +-
 include/net/ip6_fib.h                              |  64 ++--------
 include/net/sock.h                                 |   5 +
 include/trace/events/9p.h                          |  11 +-
 kernel/bpf/arraymap.c                              |  58 ++-------
 kernel/trace/ring_buffer.c                         | 130 ++++++--------------
 kernel/trace/synth_event_gen_test.c                |  11 ++
 lib/vsprintf.c                                     |  11 +-
 mm/damon/core.c                                    | 102 ++++++++--------
 net/8021q/vlan_core.c                              |   9 +-
 net/9p/protocol.c                                  |  17 ++-
 net/bluetooth/af_bluetooth.c                       |   7 +-
 net/bluetooth/hci_event.c                          |  30 +++--
 net/bluetooth/l2cap_core.c                         |  21 +++-
 net/bluetooth/mgmt.c                               |  25 ++--
 net/bluetooth/smp.c                                |   7 ++
 net/core/dev.c                                     |   3 +
 net/core/skbuff.c                                  |   2 +
 net/core/sock_map.c                                |   2 +
 net/core/stream.c                                  |   2 +-
 net/dns_resolver/dns_key.c                         |  10 +-
 net/ife/ife.c                                      |   1 +
 net/ipv6/ip6_fib.c                                 |  55 +--------
 net/ipv6/route.c                                   |   6 +-
 net/mac80211/cfg.c                                 |   4 +-
 net/mac80211/driver-ops.c                          |   6 +-
 net/mac80211/mesh_plink.c                          |  16 +--
 net/mac80211/mlme.c                                |   4 +-
 net/rfkill/rfkill-gpio.c                           |   8 ++
 net/rose/af_rose.c                                 |  39 +++++-
 net/sunrpc/svc_xprt.c                              |   5 +-
 net/wireless/certs/wens.hex                        |  87 +++++++++++++
 security/keys/gc.c                                 |  31 +++--
 security/keys/internal.h                           |  11 +-
 security/keys/key.c                                |  15 +--
 security/keys/proc.c                               |   2 +-
 sound/pci/hda/patch_realtek.c                      |   1 +
 sound/pci/hda/tas2781_hda_i2c.c                    |   4 +
 sound/soc/codecs/hdmi-codec.c                      |  12 +-
 sound/soc/codecs/tas2781-fmwlib.c                  |  14 ++-
 sound/soc/fsl/fsl_sai.c                            |   3 +
 sound/usb/quirks.c                                 |   4 +-
 tools/testing/selftests/net/mptcp/mptcp_join.sh    |   8 +-
 183 files changed, 1677 insertions(+), 907 deletions(-)



