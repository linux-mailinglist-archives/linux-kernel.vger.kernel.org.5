Return-Path: <linux-kernel+bounces-140238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66EF48A0FA4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 12:26:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 849EAB23772
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 10:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A09F146A8C;
	Thu, 11 Apr 2024 10:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WudkmHvs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1BC13FD94;
	Thu, 11 Apr 2024 10:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712831155; cv=none; b=eNcNo+GObAfVweflv1/LS1X5GjiYdCqL2g1c4ThOt4b5WDgnyPQ9ZX2iZbA6/S9GHP+y/GDOZ694IdwbgUBT8BukoPAZDwxH07GwLroLCAI9kR+hujfQWyGRvm62XrTh8sLLfUjF4OXch61x3uG7ngcew5pVHhF/JdMY2QWQhCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712831155; c=relaxed/simple;
	bh=4fyX9oxN9VHaqpW4ZqkSu7V0KZNZQS5gZcJyQ+iXR4w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=u+Bo+GsnAIPv8Ysdc0EPYWdat0XYremsg32vjPyXXdRMhXjobTc5fTsbAQOQ+2NiT3fQML94xT9cnWKA+oQHoyOTnzdr3bx1suaklbyDkUjQuunMo9MzI9LPEEEiQcR6L+3SqCReiKQc7+7Doita2ER8Fri9TQD4QagRoyC9MS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WudkmHvs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57FB9C433C7;
	Thu, 11 Apr 2024 10:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712831154;
	bh=4fyX9oxN9VHaqpW4ZqkSu7V0KZNZQS5gZcJyQ+iXR4w=;
	h=From:To:Cc:Subject:Date:From;
	b=WudkmHvspc9+oLJJNuqsVTgORiq31M3oHGuyEBtiKRucPzkzROF9LMFeRrIkbPd15
	 1B3El8UwIH3yie8l2tqQH4NHOhAFnqA7V1jQaDXBPu5GTnod8Q85NyQEDYIn4U2zda
	 wdK4mhi0bR1U2YOZyETH0h6YsgN76rCZaIgprsxw=
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
	allen.lkml@gmail.com,
	broonie@kernel.org
Subject: [PATCH 6.6 000/114] 6.6.27-rc1 review
Date: Thu, 11 Apr 2024 11:55:27 +0200
Message-ID: <20240411095416.853744210@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.27-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.6.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.6.27-rc1
X-KernelTest-Deadline: 2024-04-13T09:54+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is the start of the stable review cycle for the 6.6.27 release.
There are 114 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Sat, 13 Apr 2024 09:53:55 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.27-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 6.6.27-rc1

Ma Jun <Jun.Ma2@amd.com>
    Revert "drm/amd/amdgpu: Fix potential ioremap() memory leaks in amdgpu_device_init()"

Vasiliy Kovalev <kovalev@altlinux.org>
    VMCI: Fix possible memcpy() run-time warning in vmci_datagram_invoke_guest_handler()

Florian Westphal <fw@strlen.de>
    net: mpls: error out if inner headers are not set

Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
    Bluetooth: btintel: Fixe build regression

Gwendal Grignou <gwendal@chromium.org>
    platform/x86: intel-vbtn: Update tablet mode switch at end of probe

Kees Cook <keescook@chromium.org>
    randomize_kstack: Improve entropy diffusion

Yunfei Dong <yunfei.dong@mediatek.com>
    media: mediatek: vcodec: adding lock to protect encoder context list

Yunfei Dong <yunfei.dong@mediatek.com>
    media: mediatek: vcodec: adding lock to protect decoder context list

Nicolas Dufresne <nicolas.dufresne@collabora.com>
    media: mediatek: vcodec: Fix oops when HEVC init fails

Geliang Tang <geliang.tang@suse.com>
    selftests: mptcp: display simult in extra_msg

Ard Biesheuvel <ardb@kernel.org>
    gcc-plugins/stackleak: Avoid .head.text section

Tim Crawford <tcrawford@system76.com>
    ALSA: hda/realtek: Add quirks for some Clevo laptops

Roman Smirnov <r.smirnov@omp.ru>
    fbmon: prevent division by zero in fb_videomode_from_videomode()

Jiawei Fu (iBug) <i@ibugone.com>
    drivers/nvme: Add quirks for device 126f:2262

Max Kellermann <max.kellermann@ionos.com>
    modpost: fix null pointer dereference

Jens Axboe <axboe@kernel.dk>
    io_uring: clear opcode specific data for an early failure

Aleksandr Burakov <a.burakov@rosalinux.ru>
    fbdev: viafb: fix typo in hw_bitblt_1 and hw_bitblt_2

Roger Pau Monne <roger.pau@citrix.com>
    x86/xen: attempt to inflate the memory balloon on PVH

Chancel Liu <chancel.liu@nxp.com>
    ASoC: soc-core.c: Skip dummy codec when adding platforms

Konrad Dybcio <konrad.dybcio@linaro.org>
    thermal/of: Assume polling-delay(-passive) 0 when absent

M Cooley <m.cooley.198@gmail.com>
    ASoC: amd: yc: Fix non-functional mic on ASUS M7600RE

Colin Ian King <colin.i.king@gmail.com>
    usb: sl811-hcd: only defined function checkdone if QUIRK2 is defined

Marco Felsch <m.felsch@pengutronix.de>
    usb: typec: tcpci: add generic tcpci fallback compatible

Mika Westerberg <mika.westerberg@linux.intel.com>
    thunderbolt: Keep the domain powered when USB4 port is in redrive mode

Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
    usb: typec: ucsi: Limit read size on v1.2

Michael Grzeschik <m.grzeschik@pengutronix.de>
    usb: gadget: uvc: mark incomplete frames with UVC_STREAM_ERR

Tejun Heo <tj@kernel.org>
    kernfs: RCU protect kernfs_nodes and avoid kernfs_idr_lock in kernfs_find_and_get_node_by_id()

Jeffrey Hugo <quic_jhugo@quicinc.com>
    bus: mhi: host: Add MHI_PM_SYS_ERR_FAIL state

Petre Rodan <petre.rodan@subdimension.ro>
    tools: iio: replace seekdir() in iio_generic_buffer

linke li <lilinke99@qq.com>
    ring-buffer: use READ_ONCE() to read cpu_buffer->commit_page in concurrent environment

Matt Scialabba <matt.git@fastmail.fm>
    Input: xpad - add support for Snakebyte GAMEPADs

Ricardo B. Marliere <ricardo@marliere.net>
    ktest: force $buildonly = 1 for 'make_warnings_file' test type

Jichi Zhang <i@jichi.ca>
    ALSA: hda/realtek: Add quirk for Lenovo Yoga 9 14IMH9

Sandipan Das <sandipan.das@amd.com>
    perf/x86/amd/lbr: Discard erroneous branch entries

Alban Boyé <alban.boye@protonmail.com>
    platform/x86: touchscreen_dmi: Add an extra entry for a variant of the Chuwi Vi8 tablet

Gergo Koteles <soyer@irl.hu>
    Input: allocate keycode for Display refresh rate toggle

Duje Mihanović <duje.mihanovic@skole.hr>
    Input: imagis - use FIELD_GET where applicable

Manjunath Patil <manjunath.b.patil@oracle.com>
    RDMA/cm: add timeout to cm_destroy_id wait

Roman Smirnov <r.smirnov@omp.ru>
    block: prevent division by zero in blk_rq_stat_sum()

Junhao He <hejunhao3@huawei.com>
    drivers/perf: hisi: Enable HiSilicon Erratum 162700402 quirk for HIP09

Markuss Broks <markuss.broks@gmail.com>
    input/touchscreen: imagis: Correct the maximum touch area value

Ian Rogers <irogers@google.com>
    libperf evlist: Avoid out-of-bounds access

Daniel Drake <drake@endlessos.org>
    Revert "ACPI: PM: Block ASUS B1400CEAE from suspend to idle by default"

Daniel Drake <drake@endlessos.org>
    PCI: Disable D3cold on Asus B1400 PCI-NVMe bridge

Dai Ngo <dai.ngo@oracle.com>
    SUNRPC: increase size of rpc_wait_queue.qlen from unsigned short to unsigned int

Shradha Gupta <shradhagupta@linux.microsoft.com>
    drm: Check output polling initialized before disabling

Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
    drm/amd/amdgpu: Fix potential ioremap() memory leaks in amdgpu_device_init()

Dmitry Torokhov <dmitry.torokhov@gmail.com>
    HID: input: avoid polling stylus battery on Chromebook Pompom

Jarkko Nikula <jarkko.nikula@linux.intel.com>
    i2c: designware: Fix RX FIFO depth define on Wangxun 10Gb NIC

Koby Elbaz <kelbaz@habana.ai>
    accel/habanalabs: increase HL_MAX_STR to 64 bytes to avoid warnings

Aric Cyr <aric.cyr@amd.com>
    drm/amd/display: Fix nanosec stat overflow

Ye Bin <yebin10@huawei.com>
    ext4: forbid commit inconsistent quota data when errors=remount-ro

Zhang Yi <yi.zhang@huawei.com>
    ext4: add a hint for block bitmap corrupt state in mb_groups

Cezary Rojewski <cezary.rojewski@intel.com>
    ASoC: Intel: avs: Populate board selection with new I2S entries

Takashi Sakamoto <o-takashi@sakamocchi.jp>
    ALSA: firewire-lib: handle quirk to calculate payload quadlets as data block counter

Arnd Bergmann <arnd@arndb.de>
    media: sta2x11: fix irq handler cast

Mike Marshall <hubcap@omnibond.com>
    Julia Lawall reported this null pointer dereference, this should fix it.

Paul E. McKenney <paulmck@kernel.org>
    rcu-tasks: Repair RCU Tasks Trace quiescence check

Zqiang <qiang.zhang1211@gmail.com>
    rcu/nocb: Fix WARN_ON_ONCE() in the rcu_nocb_bypass_lock()

mosomate <mosomate@gmail.com>
    ASoC: Intel: common: DMI remap for rebranded Intel NUC M15 (LAPRC710) laptops

Alex Henrie <alexhenrie24@gmail.com>
    isofs: handle CDs with bad root inode but good Joliet root directory

Justin Tee <justin.tee@broadcom.com>
    scsi: lpfc: Fix possible memory leak in lpfc_rcv_padisc()

Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
    sysv: don't call sb_bread() with pointers_lock held

Geert Uytterhoeven <geert+renesas@glider.be>
    pinctrl: renesas: checker: Limit cfg reg enum checks to provided IDs

Christian König <christian.koenig@amd.com>
    drm/ttm: return ENOSPC from ttm_bo_mem_space v3

Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
    ASoC: SOF: amd: Optimize quirk for Valve Galileo

Samuel Dionne-Riel <samuel@dionne-riel.com>
    drm: panel-orientation-quirks: Add quirk for GPD Win Mini

Kunwu Chan <chentao@kylinos.cn>
    Input: synaptics-rmi4 - fail probing if memory allocation for "phys" fails

Maíra Canal <mcanal@igalia.com>
    drm/vc4: don't check if plane->state->fb == state->fb

Vinicius Peixoto <nukelet64@gmail.com>
    Bluetooth: Add new quirk for broken read key length on ATS2851

Takashi Iwai <tiwai@suse.de>
    Bluetooth: btmtk: Add MODULE_FIRMWARE() for MT7922

Edward Adam Davis <eadavis@qq.com>
    Bluetooth: btintel: Fix null ptr deref in btintel_read_version

Eric Dumazet <edumazet@google.com>
    net/smc: reduce rtnl pressure in smc_pnet_create_pnetids_list()

Jacob Keller <jacob.e.keller@intel.com>
    ice: use relative VSI index for VFs instead of PF VSI number

David Sterba <dsterba@suse.com>
    btrfs: send: handle path ref underflow in header iterate_inode_ref()

David Sterba <dsterba@suse.com>
    btrfs: export: handle invalid inode or root reference in btrfs_get_parent()

David Sterba <dsterba@suse.com>
    btrfs: handle chunk tree lookup error in btrfs_relocate_sys_chunks()

Johannes Berg <johannes.berg@intel.com>
    wifi: cfg80211: check A-MSDU format more carefully

Takashi Iwai <tiwai@suse.de>
    wifi: iwlwifi: Add missing MODULE_FIRMWARE() for *.pnvm

Kees Cook <keescook@chromium.org>
    overflow: Allow non-type arg to type_max() and type_min()

Viresh Kumar <viresh.kumar@linaro.org>
    cpufreq: Don't unregister cpufreq cooling on CPU hotplug

Baochen Qiang <quic_bqiang@quicinc.com>
    wifi: ath11k: decrease MHI channel buffer length to 8KB

Rick Edgecombe <rick.p.edgecombe@intel.com>
    dma-direct: Leak pages on dma_set_decrypted() failure

Serge Semin <fancer.lancer@gmail.com>
    net: pcs: xpcs: Return EINVAL in the internal methods

Samasth Norway Ananda <samasth.norway.ananda@oracle.com>
    tools/power x86_energy_perf_policy: Fix file leak in get_pkg_num()

Kunwu Chan <chentao@kylinos.cn>
    pstore/zone: Add a null pointer check to the psz_kmsg_read

Hans de Goede <hdegoede@redhat.com>
    ACPI: x86: Move acpi_quirk_skip_serdev_enumeration() out of CONFIG_X86_ANDROID_TABLETS

Shayne Chen <shayne.chen@mediatek.com>
    wifi: mt76: mt7996: add locking for accessing mapped registers

Peter Chiu <chui-hao.chiu@mediatek.com>
    wifi: mt76: mt7996: disable AMSDU for non-data frames

Shayne Chen <shayne.chen@mediatek.com>
    wifi: mt76: mt7915: add locking for accessing mapped registers

Hans de Goede <hdegoede@redhat.com>
    wifi: brcmfmac: Add DMI nvram filename quirk for ACEPC W5 Pro

Markus Elfring <elfring@users.sourceforge.net>
    firmware: tegra: bpmp: Return directly after a failed kzalloc() in get_filename()

Florian Westphal <fw@strlen.de>
    net: skbuff: add overflow debug check to pull/push helpers

Shannon Nelson <shannon.nelson@amd.com>
    ionic: set adminq irq affinity

Adam Ford <aford173@gmail.com>
    pmdomain: imx8mp-blk-ctrl: imx8mp_blk: Add fdcc clock to hdmimix domain

Kunwu Chan <chentao@kylinos.cn>
    pmdomain: ti: Add a null pointer check to the omap_prm_domain_init

Eric Dumazet <edumazet@google.com>
    net: add netdev_lockdep_set_classes() to virtual drivers

Johan Jonker <jbx6244@gmail.com>
    arm64: dts: rockchip: fix rk3399 hdmi ports node

Johan Jonker <jbx6244@gmail.com>
    arm64: dts: rockchip: fix rk3328 hdmi ports node

Johan Jonker <jbx6244@gmail.com>
    ARM: dts: rockchip: fix rk322x hdmi ports node

Johan Jonker <jbx6244@gmail.com>
    ARM: dts: rockchip: fix rk3288 hdmi ports node

C Cheng <C.Cheng@mediatek.com>
    cpuidle: Avoid potential overflow in integer multiplication

John Ogness <john.ogness@linutronix.de>
    panic: Flush kernel log buffer at the end

John Ogness <john.ogness@linutronix.de>
    printk: For @suppress_panic_printk check for other CPU in panic

Mukesh Sisodiya <mukesh.sisodiya@intel.com>
    wifi: iwlwifi: pcie: Add the PCI device id for new hardware

Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
    VMCI: Fix memcpy() run-time warning in dg_dispatch_as_host()

Ping-Ke Shih <pkshih@realtek.com>
    wifi: rtw89: pci: enlarge RX DMA buffer to consider size of RX descriptor

Andre Werner <andre.werner@systec-electronic.com>
    net: phy: phy_device: Prevent nullptr exceptions on ISR

Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
    net: stmmac: dwmac-starfive: Add support for JH7100 SoC

Markus Elfring <elfring@users.sourceforge.net>
    batman-adv: Improve exception handling in batadv_throw_uevent()

Markus Elfring <elfring@users.sourceforge.net>
    batman-adv: Return directly after a failed batadv_dat_select_candidates() in batadv_dat_forward_data()

Kees Cook <keescook@chromium.org>
    bnx2x: Fix firmware version string character counts

Po-Hao Huang <phhuang@realtek.com>
    wifi: rtw89: fix null pointer access when abort scan

Dmitry Antipov <dmantipov@yandex.ru>
    wifi: ath9k: fix LNA selection in ath_ant_try_scan()


-------------

Diffstat:

 Makefile                                           |  4 +-
 arch/arm/boot/dts/rockchip/rk322x.dtsi             | 16 ++--
 arch/arm/boot/dts/rockchip/rk3288.dtsi             | 16 +++-
 arch/arm64/boot/dts/rockchip/rk3328.dtsi           | 11 ++-
 arch/arm64/boot/dts/rockchip/rk3399.dtsi           | 12 ++-
 arch/x86/events/amd/lbr.c                          |  6 +-
 arch/x86/include/asm/xen/hypervisor.h              |  5 ++
 arch/x86/pci/fixup.c                               | 48 ++++++++++++
 arch/x86/platform/pvh/enlighten.c                  |  3 +
 arch/x86/xen/enlighten.c                           | 32 ++++++++
 arch/x86/xen/enlighten_pvh.c                       | 68 +++++++++++++++++
 arch/x86/xen/setup.c                               | 44 -----------
 arch/x86/xen/xen-ops.h                             | 14 ++++
 block/blk-stat.c                                   |  2 +-
 drivers/accel/habanalabs/common/habanalabs.h       |  2 +-
 drivers/acpi/sleep.c                               | 12 ---
 drivers/acpi/x86/utils.c                           | 18 ++++-
 drivers/bluetooth/btintel.c                        |  2 +-
 drivers/bluetooth/btmtk.c                          |  1 +
 drivers/bluetooth/btmtk.h                          |  1 +
 drivers/bluetooth/btusb.c                          |  1 +
 drivers/bus/mhi/host/init.c                        |  1 +
 drivers/bus/mhi/host/internal.h                    |  9 ++-
 drivers/bus/mhi/host/pm.c                          | 20 ++++-
 drivers/cpufreq/cpufreq.c                          | 17 +++--
 drivers/cpuidle/driver.c                           |  3 +-
 drivers/firmware/tegra/bpmp-debugfs.c              |  2 +-
 .../gpu/drm/amd/display/modules/inc/mod_stats.h    |  4 +-
 drivers/gpu/drm/drm_modeset_helper.c               | 19 ++++-
 drivers/gpu/drm/drm_panel_orientation_quirks.c     | 12 +++
 drivers/gpu/drm/drm_probe_helper.c                 | 13 +++-
 drivers/gpu/drm/ttm/ttm_bo.c                       |  7 +-
 drivers/gpu/drm/vc4/vc4_plane.c                    |  5 +-
 drivers/hid/hid-ids.h                              |  1 +
 drivers/hid/hid-input.c                            |  2 +
 drivers/i2c/busses/i2c-designware-core.h           |  2 +-
 drivers/infiniband/core/cm.c                       | 20 ++++-
 drivers/input/joystick/xpad.c                      |  3 +
 drivers/input/rmi4/rmi_driver.c                    |  6 +-
 drivers/input/touchscreen/imagis.c                 | 20 ++---
 drivers/media/pci/sta2x11/sta2x11_vip.c            |  9 +--
 .../mediatek/vcodec/common/mtk_vcodec_fw_vpu.c     |  8 +-
 .../mediatek/vcodec/decoder/mtk_vcodec_dec_drv.c   |  5 ++
 .../mediatek/vcodec/decoder/mtk_vcodec_dec_drv.h   |  2 +
 .../vcodec/decoder/vdec/vdec_hevc_req_multi_if.c   |  2 +-
 .../platform/mediatek/vcodec/decoder/vdec_vpu_if.c |  2 +
 .../mediatek/vcodec/encoder/mtk_vcodec_enc_drv.c   |  5 ++
 .../mediatek/vcodec/encoder/mtk_vcodec_enc_drv.h   |  2 +
 .../platform/mediatek/vcodec/encoder/venc_vpu_if.c |  2 +
 drivers/misc/vmw_vmci/vmci_datagram.c              |  6 +-
 drivers/net/dummy.c                                |  1 +
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c    |  9 ++-
 .../net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c    |  2 +-
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_link.c   | 14 ++--
 drivers/net/ethernet/intel/ice/ice_virtchnl.c      |  9 +--
 drivers/net/ethernet/intel/ice/ice_virtchnl.h      |  9 +++
 drivers/net/ethernet/pensando/ionic/ionic_lif.c    |  5 +-
 drivers/net/ethernet/stmicro/stmmac/Kconfig        |  6 +-
 .../net/ethernet/stmicro/stmmac/dwmac-starfive.c   | 32 +++++++-
 drivers/net/geneve.c                               |  1 +
 drivers/net/loopback.c                             |  1 +
 drivers/net/pcs/pcs-xpcs.c                         |  4 +-
 drivers/net/phy/phy_device.c                       | 13 ++--
 drivers/net/veth.c                                 |  1 +
 drivers/net/vxlan/vxlan_core.c                     |  1 +
 drivers/net/wireless/ath/ath11k/mhi.c              |  2 +-
 drivers/net/wireless/ath/ath9k/antenna.c           |  2 +-
 .../net/wireless/broadcom/brcm80211/brcmfmac/dmi.c |  9 +++
 drivers/net/wireless/intel/iwlwifi/cfg/ax210.c     |  6 ++
 drivers/net/wireless/intel/iwlwifi/cfg/bz.c        |  2 +
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c      |  1 +
 drivers/net/wireless/mediatek/mt76/mt7915/mmio.c   | 45 ++++++++++--
 drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h |  1 +
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c    |  5 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mmio.c   | 64 ++++++++++------
 drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h |  3 +-
 drivers/net/wireless/realtek/rtw89/mac80211.c      |  4 +-
 drivers/net/wireless/realtek/rtw89/pci.h           |  2 +-
 drivers/nvme/host/pci.c                            |  3 +
 drivers/perf/hisilicon/hisi_uncore_uc_pmu.c        | 42 ++++++++++-
 drivers/pinctrl/renesas/core.c                     |  4 +-
 drivers/platform/x86/intel/vbtn.c                  |  5 +-
 drivers/platform/x86/touchscreen_dmi.c             |  9 +++
 drivers/pmdomain/imx/imx8mp-blk-ctrl.c             | 10 +--
 drivers/pmdomain/ti/omap_prm.c                     |  2 +
 drivers/scsi/lpfc/lpfc_nportdisc.c                 |  6 +-
 drivers/soundwire/dmi-quirks.c                     |  8 ++
 drivers/thermal/thermal_of.c                       | 12 ++-
 drivers/thunderbolt/quirks.c                       | 14 ++++
 drivers/thunderbolt/tb.c                           | 49 ++++++++++++-
 drivers/thunderbolt/tb.h                           |  4 +
 drivers/usb/gadget/function/uvc_video.c            |  3 +
 drivers/usb/host/sl811-hcd.c                       |  2 +
 drivers/usb/typec/tcpm/tcpci.c                     |  1 +
 drivers/usb/typec/ucsi/ucsi.c                      | 26 ++++++-
 drivers/usb/typec/ucsi/ucsi.h                      | 11 +++
 drivers/video/fbdev/core/fbmon.c                   |  7 +-
 drivers/video/fbdev/via/accel.c                    |  4 +-
 drivers/xen/balloon.c                              |  2 -
 fs/btrfs/export.c                                  |  9 ++-
 fs/btrfs/send.c                                    | 10 ++-
 fs/btrfs/volumes.c                                 | 12 ++-
 fs/ext4/mballoc.c                                  |  5 +-
 fs/ext4/super.c                                    | 12 +++
 fs/isofs/inode.c                                   | 18 ++++-
 fs/kernfs/dir.c                                    | 31 +++++---
 fs/kernfs/kernfs-internal.h                        |  2 +
 fs/orangefs/super.c                                |  2 +-
 fs/pstore/zone.c                                   |  2 +
 fs/sysv/itree.c                                    | 10 +--
 include/acpi/acpi_bus.h                            | 22 +++---
 include/linux/kernfs.h                             |  2 +
 include/linux/overflow.h                           | 12 +--
 include/linux/randomize_kstack.h                   |  2 +-
 include/linux/rcupdate.h                           |  4 +-
 include/linux/skbuff.h                             | 11 +++
 include/linux/sunrpc/sched.h                       |  2 +-
 include/net/bluetooth/hci.h                        |  8 ++
 include/uapi/linux/input-event-codes.h             |  1 +
 io_uring/io_uring.c                                | 25 ++++---
 kernel/dma/direct.c                                |  9 ++-
 kernel/panic.c                                     |  8 ++
 kernel/printk/printk.c                             |  3 +-
 kernel/rcu/tree_nocb.h                             |  2 +-
 kernel/trace/ring_buffer.c                         |  2 +-
 net/batman-adv/distributed-arp-table.c             |  3 +-
 net/batman-adv/main.c                              | 14 ++--
 net/bluetooth/hci_event.c                          |  3 +-
 net/ipv4/ip_tunnel.c                               |  1 +
 net/ipv6/ip6_gre.c                                 |  2 +
 net/ipv6/ip6_tunnel.c                              |  1 +
 net/ipv6/ip6_vti.c                                 |  1 +
 net/ipv6/sit.c                                     |  1 +
 net/mpls/mpls_gso.c                                |  3 +
 net/smc/smc_pnet.c                                 | 10 +++
 net/wireless/util.c                                | 14 +++-
 scripts/gcc-plugins/stackleak_plugin.c             |  2 +
 scripts/mod/modpost.c                              |  4 +-
 sound/firewire/amdtp-stream.c                      | 12 ++-
 sound/firewire/amdtp-stream.h                      |  4 +
 sound/pci/hda/patch_realtek.c                      | 12 +++
 sound/soc/amd/yc/acp6x-mach.c                      |  7 ++
 sound/soc/intel/avs/board_selection.c              | 85 ++++++++++++++++++++++
 sound/soc/intel/boards/sof_sdw.c                   | 11 +++
 sound/soc/soc-core.c                               |  3 +
 sound/soc/sof/amd/acp.c                            |  3 +-
 tools/iio/iio_utils.c                              |  2 +-
 tools/lib/perf/evlist.c                            | 18 +++--
 tools/lib/perf/include/internal/evlist.h           |  4 +-
 .../x86_energy_perf_policy.c                       |  1 +
 tools/testing/ktest/ktest.pl                       |  1 +
 tools/testing/selftests/net/mptcp/mptcp_join.sh    |  5 +-
 152 files changed, 1140 insertions(+), 318 deletions(-)



