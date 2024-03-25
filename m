Return-Path: <linux-kernel+bounces-116963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F07D88A597
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:00:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3032D3090A1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E477F1327F7;
	Mon, 25 Mar 2024 12:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fNSgBDjy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B921CBBB5;
	Mon, 25 Mar 2024 11:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711367982; cv=none; b=RgJVNDD2U5wHa3gvktPZWYeNvqaq2NgigHZlQUwJrEmsNYH8zwoHZv4SY7s9ZzGYlcwHupCd7eQavn7KUApvTPGBYMP4ookzlv56Z6ldB5UMELr/wHz+o7XjqVcRH16wiokwMHhzHXgV51maeHTcAwKpt7vP0uHEvkvxxeW6sgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711367982; c=relaxed/simple;
	bh=8n7MWtCnMo0O6K99RJywt1c0rHuedpmd0A27rDiLbQA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=A/dhhbIx+fGUcsUcMZHdvU9xb11TylfayLiHANVDtiO2qLLC0kxxF5/Ij1+D2wCgFsbFML5EULjp05146DXyVBEENcWUAxVkRnbApwWrr2RcxoN77TCtYq9PqNTjIyi2i8lqqACmzmubL3bj1Np5KuNzlkoE7pdQOzppA6VJVWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fNSgBDjy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3EC4C433F1;
	Mon, 25 Mar 2024 11:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711367981;
	bh=8n7MWtCnMo0O6K99RJywt1c0rHuedpmd0A27rDiLbQA=;
	h=From:To:Cc:Subject:Date:From;
	b=fNSgBDjy/Y0LUiNBn41EBeIwUcSeFpW5EymPbZ6QdAUykbVCw5kE59qDvuOgtQWGG
	 KK1d5VZesaPY1Tvnwr7eeGhCY3itefyoe1RkZQaWBz0sSt60kkgLaNfThD17a9HrEq
	 pMPtQwG9HGBE9St8C72tVm3JyrT/VIoz8jI9UVztAm5s2XtkadpcsFuy02abLNiu/9
	 OHZ0pUXHnioFXVU0vMvi0HBx5mWKcz4pcbvGAFhDYGeZrTgX4EAV4hY1E0rfR6uOLJ
	 jSbw/EiuF9Y6OEeWii+MA6fOoAiy+d7rQCCcEFOs3Q/JNrTtsdfqtSpt+R6G7KwW/Q
	 nRJlcrSE/CBfg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	torvalds@linux-foundation.org,
	akpm@linux-foundation.org,
	linux@roeck-us.net,
	shuah@kernel.org,
	patches@kernelci.org,
	lkft-triage@lists.linaro.org,
	florian.fainelli@broadcom.com,
	pavel@denx.de
Subject: [PATCH 6.1 000/444] 6.1.83-rc2 review
Date: Mon, 25 Mar 2024 07:59:39 -0400
Message-ID: <20240325115939.1766258-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.83-rc2.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.1.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.1.83-rc2
X-KernelTest-Deadline: 2024-03-27T11:59+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit


This is the start of the stable review cycle for the 6.1.83 release.
There are 444 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Wed Mar 27 11:59:37 AM UTC 2024.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
        https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/patch/?id=linux-6.1.y&id2=v6.1.82
or in the git tree and branch at:
        git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
and the diffstat can be found below.

Thanks,
Sasha

-------------
Pseudo-Shortlog of commits:

Abhinav Kumar (1):
  drm/msm/dpu: fix the programming of INTF_CFG2_DATA_HCTL_EN

Ajay Singh (2):
  wifi: wilc1000: do not realloc workqueue everytime an interface is
    added
  wifi: wilc1000: fix multi-vif management when deleting a vif

Alban Boyé (1):
  ASoC: Intel: bytcr_rt5640: Add an extra entry for the Chuwi Vi8 tablet

Alex Bee (1):
  drm/rockchip: inno_hdmi: Fix video timing

Alexander Gordeev (1):
  net/iucv: fix the allocation size of iucv_path_table array

Alexander Stein (1):
  media: tc358743: register v4l2 async device only after successful
    setup

Alexey I. Froloff (1):
  ACPI: resource: Do IRQ override on Lunnen Ground laptops

Alexey Kodanev (1):
  RDMA/rtrs-clt: Check strnlen return len in sysfs mpath_policy_store()

Alexis Lothoré (4):
  wifi: wilc1000: fix declarations ordering
  wifi: wilc1000: fix RCU usage in connect path
  wifi: wilc1000: prevent use-after-free on vif when cleaning up all
    interfaces
  wifi: wilc1000: revert reset line logic flip

Anastasia Belova (1):
  cpufreq: brcmstb-avs-cpufreq: add check for cpufreq_cpu_get's return
    value

Andre Przywara (1):
  firmware: arm_scmi: Fix double free in SMC transport cleanup path

Andre Werner (1):
  net: smsc95xx: add support for SYS TEC USB-SPEmodule1

Andrew Ballance (1):
  gen_compile_commands: fix invalid escape sequence warning

Andrey Grafin (2):
  libbpf: Apply map_set_def_max_entries() for inner_maps on creation
  selftest/bpf: Add map_in_maps with BPF_MAP_TYPE_PERF_EVENT_ARRAY
    values

Andrii Nakryiko (2):
  libbpf: Fix faccessat() usage on Android
  libbpf: Add missing LIBBPF_API annotation to libbpf_set_memlock_rlim
    API

Andy Shevchenko (1):
  serial: 8250_exar: Don't remove GPIO device on suspend

AngeloGioacchino Del Regno (1):
  drm/mediatek: dsi: Fix DSI RGB666 formats and definitions

Archie Pusaka (1):
  Bluetooth: Cancel sync command before suspend and power off

Ard Biesheuvel (3):
  x86/sme: Fix memory encryption setting if enabled by default and not
    overridden
  x86/efistub: Clear decompressor BSS in native EFI entrypoint
  x86/efistub: Don't clear BSS twice in mixed mode

Armin Wolf (1):
  ACPI: processor_idle: Fix memory leak in acpi_processor_power_exit()

Arnaud Pouliquen (2):
  remoteproc: stm32: Fix incorrect type in assignment for va
  remoteproc: stm32: Fix incorrect type assignment returned by
    stm32_rproc_get_loaded_rsc_tablef

Arnd Bergmann (12):
  fs/select: rework stack allocation hack for clang
  wifi: brcmsmac: avoid function pointer casts
  media: pvrusb2: fix pvr2_stream_callback casts
  crypto: arm/sha - fix function cast warnings
  mtd: rawnand: lpc32xx_mlc: fix irq handler prototype
  media: dvb-frontends: avoid stack overflow warnings with clang
  media: mediatek: vcodec: avoid -Wcast-function-type-strict warning
  scsi: csiostor: Avoid function pointer casts
  scsi: bfa: Fix function pointer type mismatch for hcb_qe->cbfn
  remoteproc: stm32: use correct format strings on 64-bit
  soc: fsl: dpio: fix kcalloc() argument order
  remoteproc: stm32: fix incorrect optional pointers

Arthur Grillo (1):
  drm: Fix drm_fixp2int_round() making it add 0.5

Arınç ÜNAL (3):
  net: dsa: mt7530: prevent possible incorrect XTAL frequency selection
  net: dsa: mt7530: fix link-local frames that ingress vlan filtering
    ports
  net: dsa: mt7530: fix handling of all link-local frames

Athaariq Ardhiansyah (1):
  ALSA: hda/realtek: fix ALC285 issues on HP Envy x360 laptops

Attila Tőkés (1):
  ASoC: amd: yc: Fix non-functional mic on Lenovo 82UU

Baochen Qiang (1):
  wifi: ath11k: initialize rx_mcs_80 and rx_mcs_160 before use

Baokun Li (1):
  quota: simplify drop_dquot_ref()

Bart Van Assche (1):
  fs: Fix rw_hint validation

Bartosz Golaszewski (1):
  Bluetooth: hci_qca: don't use IS_ERR_OR_NULL() with
    gpiod_get_optional()

Baruch Siach (1):
  mtd: maps: physmap-core: fix flash size larger than 32-bit

Basavaraj Natikar (2):
  HID: amd_sfh: Update HPD sensor structure elements
  HID: amd_sfh: Avoid disabling the interrupt

Ben Wolsieffer (1):
  watchdog: stm32_iwdg: initialize default timeout

Bert Karwatzki (1):
  iommu: Fix compilation without CONFIG_IOMMU_INTEL

Bitterblue Smith (2):
  wifi: rtw88: 8821c: Fix beacon loss and disconnect
  wifi: rtw88: 8821c: Fix false alarm count

Bjorn Andersson (1):
  pmdomain: qcom: rpmhpd: Drop SA8540P gfx.lvl

Breno Leitao (1):
  net: blackhole_dev: fix build warning for ethh set but not used

Bryan O'Donoghue (1):
  clk: Fix clk_core_get NULL dereference

Cai Huoqing (1):
  drm/tegra: dsi: Make use of the helper function dev_err_probe()

Changbin Du (1):
  modules: wait do_free_init correctly

Chao Yu (13):
  f2fs: reduce stack memory cost by using bitfield in struct
    f2fs_io_info
  f2fs: compress: fix to guarantee persisting compressed blocks by CP
  f2fs: compress: fix to cover normal cluster write with cp_rwsem
  f2fs: delete obsolete FI_FIRST_BLOCK_WRITTEN
  f2fs: delete obsolete FI_DROP_CACHE
  f2fs: introduce get_dnode_addr() to clean up codes
  f2fs: update blkaddr in __set_data_blkaddr() for cleanup
  f2fs: compress: fix to avoid inconsistence bewteen i_blocks and dnode
  f2fs: compress: fix to cover f2fs_disable_compressed_file() w/ i_sem
  f2fs: fix to avoid potential panic during recovery
  f2fs: compress: fix to check zstd compress level correctly in mount
    option
  f2fs: compress: fix to check compress flag w/ .i_sem lock
  f2fs: ro: compress: fix to avoid caching unaligned extent

Chen Ni (2):
  sr9800: Add check for usbnet_get_endpoints
  drm/tegra: dsi: Add missing check for of_find_device_by_node

Chen-Yu Tsai (3):
  arm64: dts: allwinner: h6: Add RX DMA channel for SPDIF
  pinctrl: mediatek: Drop bogus slew rate register range for MT8186
  pinctrl: mediatek: Drop bogus slew rate register range for MT8192

Christoph Hellwig (3):
  f2fs: simplify __allocate_data_block
  nvme: only set reserved_tags in nvme_alloc_io_tag_set for fabrics
    controllers
  nvme: add the Apple shared tag workaround to nvme_alloc_io_tag_set

Christophe JAILLET (12):
  mmc: wmt-sdmmc: remove an incorrect release_mem_region() call in the
    .remove function
  drm/tegra: dsi: Fix some error handling paths in tegra_dsi_probe()
  drm/tegra: dsi: Fix missing pm_runtime_disable() in the error handling
    path of tegra_dsi_probe()
  drm/tegra: hdmi: Fix some error handling paths in tegra_hdmi_probe()
  drm/tegra: rgb: Fix some error handling paths in tegra_dc_rgb_probe()
  drm/tegra: rgb: Fix missing clk_put() in the error handling paths of
    tegra_dc_rgb_probe()
  drm/tegra: output: Fix missing i2c_put_adapter() in the error handling
    paths of tegra_output_probe()
  PCI: switchtec: Fix an error handling path in switchtec_pci_probe()
  clk: hisilicon: hi3519: Release the correct number of gates in
    hi3519_clk_unregister()
  clk: hisilicon: hi3559a: Fix an erroneous devm_kfree()
  net: sunrpc: Fix an off by one in rpc_sockaddr2uaddr()
  NFS: Fix an off by one in root_nfs_cat()

Christophe Leroy (1):
  powerpc: Force inlining of arch_vmap_p{u/m}d_supported()

Chuck Lever (2):
  NFSD: Convert filecache to rhltable
  NFSD: Add an nfsd4_encode_nfstime4() helper

Chun-Yi Lee (1):
  aoe: fix the potential use-after-free problem in aoecmd_cfg_pkts

Chunguang Xu (1):
  nvme: fix reconnection fail due to reserved tag allocation

Colin Ian King (1):
  usb: gadget: net2272: Use irqflags in the call to net2272_probe_fin

Conor Dooley (1):
  riscv: dts: sifive: add missing #interrupt-cells to pmic

Craig Tatlor (1):
  ARM: dts: qcom: msm8974: correct qfprom node size

Cristian Ciocaltea (1):
  ASoC: amd: acp: Add missing error handling in sof-mach

Dai Ngo (1):
  NFSD: Fix problem of COMMIT and NFS4ERR_DELAY in infinite loop

Dan Carpenter (3):
  io_uring/net: fix overflow check in io_recvmsg_mshot_prep()
  ASoC: SOF: Add some bounds checking to firmware data
  staging: greybus: fix get_channel_from_mode() failure path

Daniel Golle (2):
  net: mediatek: mtk_eth_soc: clear MAC_MCR_FORCE_LINK only when MAC is
    up
  net: ethernet: mtk_eth_soc: fix PPE hanging issue

Daniel Lezcano (1):
  powercap: dtpm_cpu: Fix error check against freq_qos_add_request()

Daniel Thompson (3):
  backlight: da9052: Fully initialize backlight_properties during probe
  backlight: lm3639: Fully initialize backlight_properties during probe
  backlight: lp8788: Fully initialize backlight_properties during probe

Daniil Dulov (2):
  media: go7007: add check of return value of go7007_read_addr()
  media: pvrusb2: remove redundant NULL check

Dave Airlie (1):
  nouveau: reset the bo resource bus info after an eviction

David Gow (4):
  lib/cmdline: Fix an invalid format specifier in an assertion msg
  lib: memcpy_kunit: Fix an invalid format specifier in an assertion msg
  time: test: Fix incorrect format specifier
  rtc: test: Fix invalid format specifier.

David Howells (1):
  afs: Revert "afs: Hide silly-rename files from userspace"

David McFarland (1):
  ACPI: resource: Add Infinity laptops to irq1_edge_low_force_override

Duoming Zhou (2):
  nfp: flower: handle acti_netdevs allocation failure
  clk: zynq: Prevent null pointer dereference caused by kmalloc failure

Edward Adam Davis (1):
  media: pvrusb2: fix uaf in pvr2_context_set_notify

Eric Dumazet (7):
  sock_diag: annotate data-races around sock_diag_handlers[family]
  inet_diag: annotate data-races around inet_diag_table[]
  ipv6: mcast: remove one synchronize_net() barrier in ipv6_mc_down()
  net: ip_tunnel: make sure to pull inner header in ip_tunnel_rcv()
  tcp: Fix NEW_SYN_RECV handling in inet_twsk_purge()
  net/sched: taprio: proper TCA_TAPRIO_TC_ENTRY_INDEX check
  packet: annotate data-races around ignore_outgoing

Ethan Zhao (2):
  PCI: Make pci_dev_is_disconnected() helper public for other drivers
  iommu/vt-d: Don't issue ATS Invalidation request when device is
    disconnected

Eugen Hristev (1):
  arm64: dts: mediatek: mt8192: fix vencoder clock name

Fedor Pchelkin (1):
  drm/tegra: put drm_gem_object ref on error in tegra_fb_create

Fei Shao (1):
  spi: spi-mt65xx: Fix NULL pointer access in interrupt handler

Felix Fietkau (1):
  wifi: mac80211: only call drv_sta_rc_update for uploaded stations

Felix Maurer (1):
  hsr: Handle failures in module init

Filipe Manana (2):
  btrfs: fix data races when accessing the reserved amount of block
    reserves
  btrfs: fix data race at btrfs_use_block_rsv() when accessing block
    reserve

Frederic Weisbecker (2):
  rcu/exp: Fix RCU expedited parallel grace period kworker allocation
    failure recovery
  rcu/exp: Handle RCU expedited grace period kworker allocation failure

Frieder Schrempf (7):
  arm64: dts: imx8mm-kontron: Disable pullups for I2C signals on OSM-S
    i.MX8MM
  arm64: dts: imx8mm-kontron: Disable pullups for I2C signals on SL/BL
    i.MX8MM
  arm64: dts: imx8mm-kontron: Disable pullups for onboard UART signals
    on BL OSM-S board
  arm64: dts: imx8mm-kontron: Disable pullups for onboard UART signals
    on BL board
  arm64: dts: imx8mm-kontron: Disable pull resistors for SD card signals
    on BL OSM-S board
  arm64: dts: imx8mm-kontron: Disable pull resistors for SD card signals
    on BL board
  arm64: dts: imx8mm-kontron: Fix interrupt for RTC on OSM-S i.MX8MM
    module

Frédéric Danis (2):
  Bluetooth: mgmt: Fix limited discoverable off timeout
  Bluetooth: Fix eir name length

Gavrilov Ilia (6):
  tcp: fix incorrect parameter validation in the do_tcp_getsockopt()
    function
  ipmr: fix incorrect parameter validation in the ip_mroute_getsockopt()
    function
  l2tp: fix incorrect parameter validation in the pppol2tp_getsockopt()
    function
  udp: fix incorrect parameter validation in the udp_lib_getsockopt()
    function
  net: kcm: fix incorrect parameter validation in the kcm_getsockopt)
    function
  net/x25: fix incorrect parameter validation in the x25_getsockopt()
    function

Geert Uytterhoeven (10):
  soc: microchip: Fix POLARFIRE_SOC_SYS_CTRL input prompt
  ARM: dts: renesas: r8a73a4: Fix external clocks and clock rate
  ARM: dts: arm: realview: Fix development chip ROM compatible value
  arm64: dts: renesas: r8a779a0: Update to R-Car Gen4 compatible values
  arm64: dts: renesas: r8a779a0: Correct avb[01] reg sizes
  arm64: dts: renesas: r8a779g0: Correct avb[01] reg sizes
  pinctrl: renesas: r8a779g0: Add missing SCIF_CLK2 pin group/function
  clk: renesas: r8a779g0: Add thermal clock
  clk: renesas: r8a779g0: Correct PFC/GPIO parent clocks
  clk: renesas: r8a779f0: Correct PFC/GPIO parent clock

George Stark (1):
  leds: aw2013: Unlock mutex before destroying it

Greg Joyce (1):
  block: sed-opal: handle empty atoms when parsing response

Hans de Goede (1):
  ASoC: rt5645: Make LattePanda board DMI match more precise

Harry Wentland (1):
  drm: Don't treat 0 as -1 in drm_fixp2int_ceil

Heiko Carstens (1):
  s390/cache: prevent rebuild of shared_cpu_list

Heiko Stuebner (1):
  arm64: dts: rockchip: add missing interrupt-names for rk356x vdpu

Heinz Mauelshagen (1):
  dm: address indent/space issues

Hongyu Jin (1):
  dm io: Support IO priority

Hou Tao (2):
  x86/mm: Move is_vsyscall_vaddr() into asm/vsyscall.h
  x86/mm: Disallow vsyscall page read for copy_from_kernel_nofault()

Hsin-Te Yuan (1):
  arm64: dts: mt8195-cherry-tomato: change watchdog reset boot flow

Hsin-Yi Wang (3):
  arm64: dts: mt8183: kukui: Split out keyboard node and describe
    detachables
  drm/panel-edp: use put_sync in unprepare
  drm/mediatek: Fix a null pointer crash in
    mtk_drm_crtc_finish_page_flip

Hugo Villeneuve (1):
  serial: max310x: fix syntax error in IRQ error message

Ian Abbott (1):
  comedi: comedi_test: Prevent timers rescheduling during deletion

Ian Rogers (1):
  perf stat: Avoid metric-only segv

Ido Schimmel (2):
  selftests: forwarding: Add missing multicast routing config entries
  selftests: forwarding: Fix ping failure due to short timeout

Ignat Korchagin (1):
  net: veth: do not manipulate GRO when using XDP

Igor Prusov (1):
  clk: meson: Add missing clocks to axg_clk_regmaps

Ilkka Koskinen (1):
  perf/arm-cmn: Workaround AmpereOneX errata AC04_MESH_1 (incorrect
    child count)

Ilpo Järvinen (1):
  PCI/DPC: Print all TLP Prefixes, not just the first

Jaegeuk Kim (1):
  f2fs: check number of blocks in a current section

Jakub Kicinski (1):
  selftests: tls: use exact comparison in recv_partial

Jan Höppner (1):
  s390/dasd: Use dev_*() for device log messages

Jan Kara (1):
  quota: Fix rcu annotations of inode dquot pointers

Jeff Layton (10):
  nfsd: allow nfsd_file_get to sanely handle a NULL pointer
  nfsd: don't open-code clear_and_wake_up_bit
  nfsd: NFSD_FILE_KEY_INODE only needs to find GC'ed entries
  nfsd: simplify test_bit return in NFSD_FILE_KEY_FULL comparator
  nfsd: don't kill nfsd_files because of lease break error
  nfsd: add some comments to nfsd_file_do_acquire
  nfsd: don't take/put an extra reference when putting a file
  nfsd: update comment over __nfsd_file_cache_purge
  nfsd: allow reaping files still under writeback
  nfsd: simplify the delayed disposal list code

Jens Axboe (4):
  io_uring/unix: drop usage of io_uring socket
  io_uring: drop any code related to SCM_RIGHTS
  io_uring/net: unify how recvmsg and sendmsg copy in the msghdr
  io_uring/net: move receive multishot out of the generic msghdr path

Jeremy Kerr (1):
  net: mctp: copy skb ext data when fragmenting

Jernej Skrabec (5):
  media: cedrus: h265: Associate mv col buffers with buffer
  media: cedrus: h265: Fix configuring bitstream size
  media: sun8i-di: Fix coefficient writes
  media: sun8i-di: Fix power on/off sequences
  media: sun8i-di: Fix chroma difference threshold

Jerome Brunet (4):
  ASoC: meson: aiu: fix function pointer type mismatch
  ASoC: meson: t9015: fix function pointer type mismatch
  ASoC: meson: axg-tdm-interface: fix mclk setup without mclk-fs
  ASoC: meson: axg-tdm-interface: add frame rate constraint

Jiawei Wang (1):
  ASoC: amd: yc: Fix non-functional mic on Lenovo 21J2

Jiaxun Yang (1):
  MIPS: Clear Cause.BD in instruction_pointer_set

Jie Wang (1):
  net: hns3: fix port duplex configure error in IMP reset

Jijie Shao (1):
  net: hns3: fix wrong judgment condition issue

Jinjie Ruan (1):
  wifi: mwifiex: debugfs: Drop unnecessary error check for
    debugfs_create_dir()

Jiri Slaby (SUSE) (1):
  tty: vt: fix 20 vs 0x20 typo in EScsiignore

Johan Carlsson (1):
  ALSA: usb-audio: Stop parsing channels bits when all channels are
    found.

Johannes Berg (3):
  wifi: iwlwifi: mvm: report beacon protection failures
  wifi: iwlwifi: dbg-tlv: ensure NUL termination
  wifi: iwlwifi: mvm: don't set replay counters to 0xff

Johnny Hsieh (1):
  ASoC: amd: yc: Add Lenovo ThinkBook 21J0 into DMI quirk table

Jonah Palmer (1):
  vdpa/mlx5: Allow CVQ size changes

Jonas Dreßler (3):
  Bluetooth: Remove HCI_POWER_OFF_TIMEOUT
  Bluetooth: mgmt: Remove leftover queuing of power_off work
  Bluetooth: Remove superfluous call to hci_conn_check_pending()

Jorge Mora (2):
  NFSv4.2: fix nfs4_listxattr kernel BUG at mm/usercopy.c:102
  NFSv4.2: fix listxattr maximum XDR buffer size

Josef Bacik (1):
  nfs: fix panic when nfs4_ff_layout_prepare_ds() fails

Jérôme Pouiller (1):
  wifi: wfx: fix memory leak when starting AP

Jörg Wedekind (1):
  PCI: Mark 3ware-9650SE Root Port Extended Tags as broken

Kailang Yang (1):
  ALSA: hda/realtek - ALC285 reduce pop noise from Headphone port

Kajol Jain (1):
  powerpc/hv-gpci: Fix the H_GET_PERF_COUNTER_INFO hcall return value
    checks

Kamal Heib (1):
  net: ena: Remove ena_select_queue

Kan Liang (1):
  iommu/vt-d: Retrieve IOMMU perfmon capability information

Kees Cook (3):
  pstore: inode: Convert mutex usage to guard(mutex)
  pstore: inode: Only d_invalidate() is needed
  x86, relocs: Ignore relocations in .notes section

Keisuke Nishimura (2):
  sched/fair: Take the scheduling domain into account in
    select_idle_smt()
  sched/fair: Take the scheduling domain into account in
    select_idle_core()

Konrad Dybcio (3):
  clk: qcom: reset: Commonize the de/assert functions
  clk: qcom: reset: Ensure write completion on reset de/assertion
  clk: qcom: dispcc-sdm845: Adjust internal GDSC wait times

Krzysztof Kozlowski (3):
  arm64: dts: qcom: sdm845-db845c: correct PCIe wake-gpios
  arm64: dts: qcom: sm8150: use 'gpios' suffix for PCI GPIOs
  arm64: dts: qcom: sm8150: correct PCIe wake-gpios

Kuninori Morimoto (1):
  clk: renesas: r8a779g0: Add Audio clocks

Kuniyuki Iwashima (3):
  af_unix: Annotate data-race of gc_in_progress in wait_for_unix_gc().
  rds: tcp: Fix use-after-free of net in reqsk_timer_handler().
  tcp: Fix refcnt handling in __inet_hash_connect().

Kunwu Chan (1):
  x86/xen: Add some null pointer checking to smp.c

Kévin L'hôpital (1):
  net: phy: fix phy_get_internal_delay accessing an empty array

Lad Prabhakar (3):
  arm64: dts: renesas: r9a07g043: Split out RZ/G2UL SoC specific parts
  arm64: dts: renesas: r9a07g043u: Add IRQC node
  arm64: dts: renesas: rzg2l: Add missing interrupts to IRQC nodes

Leon Romanovsky (1):
  RDMA/mlx5: Fix fortify source warning while accessing Eth segment

Li Nan (1):
  md: Don't clear MD_CLOSING when the raid is about to stop

Linh Phung (1):
  pinctrl: renesas: r8a779g0: Add Audio SSI pins, groups, and functions

Linu Cherian (1):
  octeontx2-af: Use matching wake_up API variant in CGX command
    interface

Luca Ceresoli (1):
  ASoC: rockchip: i2s-tdm: Fix inaccurate sampling rates

Luca Weiss (2):
  backlight: lm3630a: Initialize backlight_properties on init
  backlight: lm3630a: Don't set bl->props.brightness in get_brightness

Lucas Stach (1):
  media: imx: csc/scaler: fix v4l2_ctrl_handler memory leak

Luiz Augusto von Dentz (8):
  Bluetooth: hci_sync: Only allow hci_cmd_sync_queue if running
  Bluetooth: hci_conn: Consolidate code for aborting connections
  Bluetooth: hci_core: Cancel request on command timeout
  Bluetooth: hci_sync: Fix overwriting request callback
  Bluetooth: hci_core: Fix possible buffer overflow
  Bluetooth: af_bluetooth: Fix deadlock
  Bluetooth: MGMT: Fix always using HCI_MAX_AD_LENGTH
  Bluetooth: hci_core: Fix missing instances using HCI_MAX_AD_LENGTH

Luoyouming (1):
  RDMA/hns: Fix mis-modifying default congestion control algorithm

Manuel Fombuena (1):
  HID: multitouch: Add required quirk for Synaptics 0xcddc device

Marijn Suijten (1):
  drm/msm/dpu: Only enable DSC_MODE_MULTIPLEX if dsc_merge is enabled

Mario Limonciello (1):
  iommu/amd: Mark interrupt as managed

Mark Brown (1):
  arm64/sve: Lower the maximum allocation for the SVE ptrace regset

Martin Kaiser (1):
  gpio: vf610: allow disabling the vf610 driver

Martin Kaistra (1):
  wifi: rtl8xxxu: add cancel_work_sync() for c2hcmd_work

Masahiro Yamada (1):
  kconfig: fix infinite loop when expanding a macro at the end of file

Max Kellermann (1):
  parisc/ftrace: add missing CONFIG_DYNAMIC_FTRACE check

Maxim Kudinov (1):
  ACPI: resource: Add MAIBENBEN X577 to irq1_edge_low_force_override

Mete Durlu (1):
  s390/vtime: fix average steal time calculation

Michael Ellerman (1):
  powerpc/embedded6xx: Fix no previous prototype for avr_uart_send()
    etc.

Michal Vokáč (3):
  ARM: dts: imx6dl-yapp4: Move phy reset into switch node
  ARM: dts: imx6dl-yapp4: Fix typo in the QCA switch register address
  ARM: dts: imx6dl-yapp4: Move the internal switch PHYs under the switch
    node

Mikhail Khvainitski (1):
  HID: lenovo: Add middleclick_workaround sysfs knob for cptkbd

Mikulas Patocka (4):
  dm-verity, dm-crypt: align "struct bvec_iter" correctly
  dm: call the resume method on internal suspend
  dm-integrity: fix a memory leak when rechecking the data
  dm-integrity: align the outgoing bio in integrity_recheck

Ming Lei (1):
  dm raid: fix false positive for requeue needed during reshape

Miri Korenblit (1):
  wifi: iwlwifi: fix EWRD table validity check

Miroslav Franc (1):
  s390/dasd: fix double module refcount decrement

Muhammad Usama Anjum (1):
  io_uring/net: correct the type of variable

Mustafa Ismail (1):
  RDMA/irdma: Remove duplicate assignment

Nathan Chancellor (1):
  s390/vdso: drop '-fPIC' from LDFLAGS

Navid Emamdoost (1):
  nbd: null check for nla_nest_start

Nikita Kiryushin (1):
  net: phy: fix phy_read_poll_timeout argument type in genphy_loopback

Nikita Zhandarovich (4):
  do_sys_name_to_handle(): use kzalloc() to fix kernel-infoleak
  media: em28xx: annotate unchecked call to media_device_register()
  drm/radeon/ni: Fix wrong firmware size logging in ni_init_microcode()
  wireguard: receive: annotate data-race around
    receiving_counter.counter

Nícolas F. R. A. Prado (4):
  cpufreq: mediatek-hw: Wait for CPU supplies before probing
  cpufreq: mediatek-hw: Don't error out if supply is not found
  arm64: dts: mt8183: Move CrosEC base detection node to kukui-based DTs
  arm64: dts: mediatek: mt8192-asurada: Remove CrosEC base detection
    node

Ondrej Jirman (1):
  leds: sgm3140: Add missing timer cleanup and flash gpio control

Pablo Neira Ayuso (2):
  netfilter: nft_set_pipapo: release elements in clone only from destroy
    path
  netfilter: nf_tables: do not compare internal table flags on updates

Paloma Arellano (1):
  drm/msm/dpu: add division of drm_display_mode's hskew parameter

Pauli Virtanen (1):
  Bluetooth: fix use-after-free in accessing skb after sending it

Perry Yuan (1):
  ACPI: CPPC: enable AMD CPPC V2 support for family 17h processors

Peter Griffin (2):
  mfd: syscon: Call of_node_put() only when of_parse_phandle() takes a
    ref
  mfd: altera-sysmgr: Call of_node_put() only when of_parse_phandle()
    takes a ref

Peter Hilber (3):
  timekeeping: Fix cross-timestamp interpolation on counter wrap
  timekeeping: Fix cross-timestamp interpolation corner case decision
  timekeeping: Fix cross-timestamp interpolation for non-x86

Peter Robinson (2):
  bus: tegra-aconnect: Update dependency to ARCH_TEGRA
  dmaengine: tegra210-adma: Update dependency to ARCH_TEGRA

Peter Ujfalusi (1):
  ASoC: SOF: Introduce container struct for SOF firmware

Petr Machata (1):
  selftests: forwarding: Add missing config entries

Petr Mladek (1):
  printk: Disable passing console lock owner completely during panic()

Prike Liang (1):
  drm/amdgpu: Enable gpu reset for S3 abort cases on Raven series

Puranjay Mohan (1):
  bpf: hardcode BPF_PROG_PACK_SIZE to 2MB * num_possible_nodes()

Qiheng Lin (1):
  powerpc/pseries: Fix potential memleak in papr_get_attr()

Quanyang Wang (1):
  crypto: xilinx - call finalize with bh disabled

Quentin Schulz (2):
  drm/rockchip: lvds: do not overwrite error code
  drm/rockchip: lvds: do not print scary message when probing defer

Rafael J. Wysocki (1):
  ACPI: scan: Fix device check notification handling

Rafał Miłecki (4):
  arm64: dts: mediatek: mt7986: add "#reset-cells" to infracfg
  arm64: dts: mediatek: mt7622: add missing "device_type" to memory
    nodes
  arm64: dts: marvell: reorder crypto interrupts on Armada SoCs
  arm64: dts: broadcom: bcmbca: bcm4908: drop invalid switch cells

Rahul Rameshbabu (4):
  wifi: b43: Stop/wake correct queue in DMA Tx path when QoS is disabled
  wifi: b43: Stop/wake correct queue in PIO Tx path when QoS is disabled
  wifi: b43: Stop correct queue in DMA worker when QoS is disabled
  wifi: b43: Disable QoS for bcm4331

Randy Dunlap (2):
  crypto: jitter - fix CRYPTO_JITTERENTROPY help text
  rtc: mt6397: select IRQ_DOMAIN instead of depending on it

Ranjan Kumar (1):
  scsi: mpt3sas: Prevent sending diag_reset when the controller is ready

Rob Herring (2):
  arm64: dts: Fix dtc interrupt_provider warnings
  cpufreq: Explicitly include correct DT includes

Sam Protsenko (1):
  clk: samsung: exynos850: Propagate SPI IPCLK rate change

Sam Ravnborg (1):
  sparc32: Fix section mismatch in leon_pci_grpci

Sandipan Das (1):
  perf/x86/amd/core: Avoid register reset when CPU is dead

Sasha Levin (1):
  Linux 6.1.83-rc2

Sean Anderson (1):
  usb: phy: generic: Get the vbus supply

Sheng Yong (1):
  f2fs: compress: fix to check unreleased compressed cluster

Shifeng Li (1):
  RDMA/device: Fix a race between mad_client and cm_client init

Shigeru Yoshida (1):
  hsr: Fix uninit-value access in hsr_get_node()

Shiming Cheng (1):
  ipv6: fib6_rules: flush route cache when rule is changed

Sindhu Devale (1):
  RDMA/irdma: Allow accurate reporting on QP max send/recv WR

Srinivasan Shanmugam (3):
  drm/amd/display: Fix a potential buffer overflow in
    'dp_dsc_clock_en_read()'
  drm/amd/display: Fix potential NULL pointer dereferences in
    'dcn10_set_output_transfer_func()'
  drm/amdgpu: Fix missing break in ATOM_ARG_IMM Case of
    atom_get_src_int()

Srujana Challa (4):
  octeontx2-af: recover CPT engine when it gets fault
  octeontx2-af: add mbox for CPT LF reset
  octeontx2-af: optimize cpt pf identification
  octeontx2-af: add mbox to return CPT_AF_FLT_INT info

Stefan Haberland (1):
  s390/dasd: add autoquiesce feature

Steve Sistare (1):
  vdpa_sim: reset must not run

Stuart Henderson (3):
  ASoC: wm8962: Enable oscillator if selecting WM8962_FLL_OSC
  ASoC: wm8962: Enable both SPKOUTR_ENA and SPKOUTL_ENA in mono mode
  ASoC: wm8962: Fix up incorrect error message in wm8962_set_fll

Subbaraya Sundeep (4):
  octeontx2: Detect the mbox up or down message via register
  octeontx2-pf: Use default max_active works instead of one
  octeontx2-pf: Send UP messages to VF only when VF is up.
  octeontx2-af: Use separate handlers for interrupts

Takashi Iwai (1):
  ALSA: seq: fix function cast warnings

Takashi Sakamoto (1):
  firewire: core: use long bus reset on gap count error

Tavian Barnes (1):
  nfsd: Fix creation time serialization order

Tejun Heo (1):
  net: octeontx2: Use alloc_ordered_workqueue() to create ordered
    workqueues

Thierry Reding (1):
  arm64: tegra: Set the correct PHY mode for MGBE

Thinh Tran (1):
  net/bnx2x: Prevent access to a freed page in page_pool

Thomas Richter (1):
  s390/pai: fix attr_event_free upper limit for pai device drivers

Théo Lebrun (1):
  gpio: nomadik: fix offset bug in nmk_pmx_set()

Tiezhu Yang (1):
  bpftool: Silence build warning about calloc()

Tim Harvey (1):
  arm64: dts: imx8mm-venice-gw71xx: fix USB OTG VBUS

Tim Pambor (1):
  net: phy: dp83822: Fix RGMII TX delay configuration

Tobias Brunner (1):
  ipv4: raw: Fix sending packets from raw sockets via IPsec tunnels

Toke Høiland-Jørgensen (4):
  wifi: ath9k: delay all of ath9k_wmi_event_tasklet() until init is
    complete
  bpf: Fix DEVMAP_HASH overflow check on 32-bit arches
  bpf: Fix hashtab overflow check on 32-bit arches
  bpf: Fix stackmap overflow check on 32-bit arches

Tomi Valkeinen (3):
  media: rkisp1: Fix IRQ handling due to shared interrupts
  drm/tidss: Fix initial plane zpos values
  drm/tidss: Fix sync-lost issue with two displays

Tony Luck (1):
  x86/resctrl: Implement new mba_MBps throttling heuristic

Tudor Ambarus (1):
  tty: serial: samsung: fix tx_empty() to return TIOCSER_TEMT

Uwe Kleine-König (5):
  Input: gpio_keys_polled - suppress deferred probe error for gpio
  pwm: atmel-hlcdc: Convert to platform remove callback returning void
  pwm: atmel-hlcdc: Use consistent variable naming
  pwm: atmel-hlcdc: Fix clock imbalance related to suspend support
  pwm: sti: Fix capture for st,pwm-num-chan < st,capture-num-chan

Viktor Malik (2):
  tools/resolve_btfids: Refactor set sorting with types from btf_ids.h
  tools/resolve_btfids: Fix cross-compilation to non-host endianness

Vinicius Costa Gomes (1):
  igb: Fix missing time sync events

Viresh Kumar (1):
  OPP: debugfs: Fix warning around icc_get_name()

Wang Jianjian (1):
  quota: Fix potential NULL pointer dereference

William Kucharski (1):
  RDMA/srpt: Do not register event handler until srpt device is fully
    setup

Wolfram Sang (1):
  clk: renesas: r8a779g0: Add CMT clocks

Xingyuan Mo (1):
  wifi: ath10k: fix NULL pointer dereference in
    ath10k_wmi_tlv_op_pull_mgmt_tx_compl_ev()

Xiuhong Wang (2):
  f2fs: compress: relocate some judgments in
    f2fs_reserve_compress_blocks
  f2fs: compress: fix reserve_cblocks counting error when out of space

Yan Zhai (3):
  rcu: add a helper to report consolidated flavor QS
  net: report RCU QS on threaded NAPI repolling
  bpf: report RCU QS in cpumap kthread

Yang Jihong (4):
  perf record: Fix possible incorrect free in record__switch_output()
  perf evsel: Fix duplicate initialization of data->id in
    evsel__parse_sample()
  perf thread_map: Free strlist on normal path in
    thread_map__new_by_tid_str()
  hwtracing: hisi_ptt: Move type check to the beginning of
    hisi_ptt_pmu_event_init()

Yang Yingliang (1):
  NTB: fix possible name leak in ntb_register_device()

Yangtao Li (2):
  drm/tegra: hdmi: Convert to devm_platform_ioremap_resource()
  f2fs: convert to use sbi directly

Yewon Choi (1):
  rds: introduce acquire/release ordering in acquire/release_in_xmit()

Yishai Hadas (1):
  RDMA/mlx5: Relax DEVX access upon modify commands

Yonghong Song (1):
  bpf: Mark bpf_spin_{lock,unlock}() helpers with notrace correctly

Yonglong Liu (1):
  net: hns3: fix kernel crash when 1588 is received on HIP08 devices

Yu Kuai (2):
  md: fix data corruption for raid456 when reshape restart while grow up
  md/raid10: prevent soft lockup while flush writes

Yuxuan Hu (1):
  Bluetooth: rfcomm: Fix null-ptr-deref in rfcomm_check_security

Zhang Shurong (1):
  drm/tegra: dpaux: Fix PM disable depth imbalance in tegra_dpaux_probe

Zhipeng Lu (9):
  wifi: libertas: fix some memleaks in lbs_allocate_cmd_buffer()
  SUNRPC: fix some memleaks in gssx_dec_option_array
  drm/vmwgfx: fix a memleak in vmw_gmrid_man_get_node
  drm/lima: fix a memleak in lima_heap_alloc
  media: v4l2-tpg: fix some memleaks in tpg_alloc
  media: v4l2-mem2mem: fix a memleak in v4l2_m2m_register_entity
  media: edia: dvbdev: fix a use-after-free
  media: go7007: fix a memleak in go7007_load_encoder
  media: ttpci: fix two memleaks in budget_av_attach

ruanjinjie (1):
  NTB: EPF: fix possible memory leak in pci_vntb_probe()

 Makefile                                      |   4 +-
 arch/arm/boot/dts/arm-realview-pb1176.dts     |   2 +-
 arch/arm/boot/dts/imx6dl-yapp4-common.dtsi    |  28 +-
 arch/arm/boot/dts/qcom-msm8974.dtsi           |   2 +-
 arch/arm/boot/dts/r8a73a4-ape6evm.dts         |  12 +
 arch/arm/boot/dts/r8a73a4.dtsi                |   9 +-
 arch/arm/crypto/sha256_glue.c                 |  13 +-
 arch/arm/crypto/sha512-glue.c                 |  12 +-
 .../dts/allwinner/sun50i-h6-beelink-gs1.dts   |   2 +
 .../boot/dts/allwinner/sun50i-h6-tanix.dtsi   |   2 +
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi  |   7 +-
 arch/arm64/boot/dts/amazon/alpine-v2.dtsi     |   1 -
 arch/arm64/boot/dts/amazon/alpine-v3.dtsi     |   1 -
 .../boot/dts/broadcom/bcmbca/bcm4908.dtsi     |   3 -
 .../boot/dts/broadcom/northstar2/ns2.dtsi     |   1 +
 .../boot/dts/broadcom/stingray/stingray.dtsi  |   1 +
 .../dts/freescale/imx8mm-kontron-bl-osm-s.dts |  38 +-
 .../boot/dts/freescale/imx8mm-kontron-bl.dts  |  38 +-
 .../dts/freescale/imx8mm-kontron-osm-s.dtsi   |   6 +-
 .../boot/dts/freescale/imx8mm-kontron-sl.dtsi |   4 +-
 .../dts/freescale/imx8mm-venice-gw71xx.dtsi   |  29 +-
 arch/arm64/boot/dts/lg/lg1312.dtsi            |   1 -
 arch/arm64/boot/dts/lg/lg1313.dtsi            |   1 -
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi  |  10 +-
 arch/arm64/boot/dts/marvell/armada-ap80x.dtsi |   1 -
 arch/arm64/boot/dts/marvell/armada-cp11x.dtsi |  10 +-
 .../dts/mediatek/mt7622-bananapi-bpi-r64.dts  |   1 +
 arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts  |   1 +
 arch/arm64/boot/dts/mediatek/mt7986a.dtsi     |   1 +
 .../dts/mediatek/mt8183-kukui-jacuzzi.dtsi    |   2 +
 .../dts/mediatek/mt8183-kukui-kakadu.dtsi     |  10 +
 .../dts/mediatek/mt8183-kukui-kodama.dtsi     |  10 +
 .../boot/dts/mediatek/mt8183-kukui-krane.dtsi |  10 +
 .../arm64/boot/dts/mediatek/mt8183-kukui.dtsi |   5 -
 .../boot/dts/mediatek/mt8192-asurada.dtsi     |   4 -
 arch/arm64/boot/dts/mediatek/mt8192.dtsi      |   2 +-
 .../dts/mediatek/mt8195-cherry-tomato-r1.dts  |   4 +
 .../dts/mediatek/mt8195-cherry-tomato-r2.dts  |   4 +
 .../dts/mediatek/mt8195-cherry-tomato-r3.dts  |   4 +
 arch/arm64/boot/dts/mediatek/mt8195-demo.dts  |   1 +
 .../nvidia/tegra234-p3737-0000+p3701-0000.dts |   2 +-
 arch/arm64/boot/dts/qcom/sdm845-db845c.dts    |   2 +-
 arch/arm64/boot/dts/qcom/sm8150.dtsi          |   6 +-
 arch/arm64/boot/dts/renesas/r8a779a0.dtsi     |  28 +-
 arch/arm64/boot/dts/renesas/r8a779g0.dtsi     |   4 +-
 arch/arm64/boot/dts/renesas/r9a07g043.dtsi    |  54 +--
 arch/arm64/boot/dts/renesas/r9a07g043u.dtsi   | 136 ++++++
 arch/arm64/boot/dts/renesas/r9a07g044.dtsi    |  22 +-
 arch/arm64/boot/dts/renesas/r9a07g054.dtsi    |  22 +-
 arch/arm64/boot/dts/renesas/ulcb-kf.dtsi      |   4 +
 arch/arm64/boot/dts/rockchip/rk356x.dtsi      |   1 +
 arch/arm64/include/asm/fpsimd.h               |  12 +-
 arch/arm64/kernel/ptrace.c                    |   3 +-
 arch/mips/include/asm/ptrace.h                |   1 +
 arch/parisc/kernel/ftrace.c                   |   2 +-
 arch/powerpc/include/asm/vmalloc.h            |   4 +-
 arch/powerpc/perf/hv-gpci.c                   |  29 +-
 .../platforms/embedded6xx/linkstation.c       |   3 -
 arch/powerpc/platforms/embedded6xx/mpc10x.h   |   3 +
 .../pseries/papr_platform_attributes.c        |   8 +-
 .../boot/dts/sifive/hifive-unmatched-a00.dts  |   1 +
 arch/s390/include/uapi/asm/dasd.h             |   2 +
 arch/s390/kernel/cache.c                      |   1 +
 arch/s390/kernel/perf_pai_crypto.c            |   2 +-
 arch/s390/kernel/perf_pai_ext.c               |   2 +-
 arch/s390/kernel/vdso32/Makefile              |   2 +-
 arch/s390/kernel/vdso64/Makefile              |   2 +-
 arch/s390/kernel/vtime.c                      |   4 +-
 arch/sparc/kernel/leon_pci_grpci1.c           |   2 +-
 arch/sparc/kernel/leon_pci_grpci2.c           |   2 +-
 arch/x86/events/amd/core.c                    |   1 -
 arch/x86/include/asm/vsyscall.h               |  10 +
 arch/x86/kernel/acpi/cppc.c                   |   2 +-
 arch/x86/kernel/cpu/resctrl/internal.h        |   4 -
 arch/x86/kernel/cpu/resctrl/monitor.c         |  42 +-
 arch/x86/mm/fault.c                           |   9 -
 arch/x86/mm/maccess.c                         |  10 +
 arch/x86/mm/mem_encrypt_identity.c            |  10 +-
 arch/x86/tools/relocs.c                       |   8 +
 arch/x86/xen/smp.c                            |  12 +
 block/opal_proto.h                            |   1 +
 block/sed-opal.c                              |   6 +-
 crypto/Kconfig                                |   5 +-
 drivers/acpi/processor_idle.c                 |   2 +
 drivers/acpi/resource.c                       |  33 ++
 drivers/acpi/scan.c                           |   8 +-
 drivers/block/aoe/aoecmd.c                    |  12 +-
 drivers/block/aoe/aoenet.c                    |   1 +
 drivers/block/nbd.c                           |   6 +
 drivers/bluetooth/hci_qca.c                   |   6 +-
 drivers/bus/Kconfig                           |   5 +-
 drivers/clk/clk.c                             |   3 +
 drivers/clk/hisilicon/clk-hi3519.c            |   2 +-
 drivers/clk/hisilicon/clk-hi3559a.c           |   1 -
 drivers/clk/meson/axg.c                       |   2 +
 drivers/clk/qcom/dispcc-sdm845.c              |   2 +
 drivers/clk/qcom/reset.c                      |  27 +-
 drivers/clk/renesas/r8a779f0-cpg-mssr.c       |   2 +-
 drivers/clk/renesas/r8a779g0-cpg-mssr.c       |  18 +-
 drivers/clk/samsung/clk-exynos850.c           |  33 +-
 drivers/clk/zynq/clkc.c                       |   8 +-
 drivers/comedi/drivers/comedi_test.c          |  30 +-
 drivers/cpufreq/armada-37xx-cpufreq.c         |   4 +-
 drivers/cpufreq/brcmstb-avs-cpufreq.c         |   2 +
 drivers/cpufreq/mediatek-cpufreq-hw.c         |  22 +-
 drivers/cpufreq/ppc_cbe_cpufreq.c             |   2 +-
 drivers/cpufreq/ppc_cbe_cpufreq_pmi.c         |   1 -
 drivers/cpufreq/qcom-cpufreq-nvmem.c          |   1 -
 drivers/cpufreq/scpi-cpufreq.c                |   2 +-
 drivers/cpufreq/sti-cpufreq.c                 |   2 +-
 drivers/cpufreq/ti-cpufreq.c                  |   2 +-
 drivers/cpufreq/vexpress-spc-cpufreq.c        |   1 -
 drivers/crypto/xilinx/zynqmp-aes-gcm.c        |   3 +
 drivers/dma/Kconfig                           |  14 +-
 drivers/firewire/core-card.c                  |  14 +-
 drivers/firmware/arm_scmi/smc.c               |   7 +
 drivers/firmware/efi/libstub/x86-stub.c       |   7 +-
 drivers/gpio/Kconfig                          |   3 +-
 drivers/gpu/drm/amd/amdgpu/atom.c             |   2 +-
 drivers/gpu/drm/amd/amdgpu/soc15.c            |  45 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c |   2 +-
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c |   7 +-
 drivers/gpu/drm/lima/lima_gem.c               |  23 +-
 drivers/gpu/drm/mediatek/mtk_drm_crtc.c       |  12 +-
 drivers/gpu/drm/mediatek/mtk_dsi.c            |  10 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c   |  11 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h   |   7 +
 .../drm/msm/disp/dpu1/dpu_encoder_phys_vid.c  |   7 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c   |  15 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h   |   1 +
 drivers/gpu/drm/nouveau/nouveau_bo.c          |   2 +
 drivers/gpu/drm/panel/panel-edp.c             |   3 +-
 drivers/gpu/drm/radeon/ni.c                   |   2 +-
 drivers/gpu/drm/rockchip/inno_hdmi.c          |   4 +-
 drivers/gpu/drm/rockchip/rockchip_lvds.c      |   3 +-
 drivers/gpu/drm/tegra/dpaux.c                 |  14 +-
 drivers/gpu/drm/tegra/dsi.c                   |  47 +-
 drivers/gpu/drm/tegra/fb.c                    |   1 +
 drivers/gpu/drm/tegra/hdmi.c                  |  24 +-
 drivers/gpu/drm/tegra/output.c                |  16 +-
 drivers/gpu/drm/tegra/rgb.c                   |  18 +-
 drivers/gpu/drm/tidss/tidss_crtc.c            |  10 +
 drivers/gpu/drm/tidss/tidss_plane.c           |   2 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_gmrid_manager.c |   5 +-
 drivers/hid/amd-sfh-hid/amd_sfh_pcie.c        |  30 +-
 drivers/hid/amd-sfh-hid/amd_sfh_pcie.h        |   6 +-
 drivers/hid/hid-lenovo.c                      |  57 ++-
 drivers/hid/hid-multitouch.c                  |   4 +
 drivers/hwtracing/ptt/hisi_ptt.c              |   6 +-
 drivers/infiniband/core/device.c              |  37 +-
 drivers/infiniband/hw/hns/hns_roce_device.h   |  17 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c    |  16 +-
 drivers/infiniband/hw/irdma/uk.c              |  89 +++-
 drivers/infiniband/hw/irdma/user.h            |  10 +
 drivers/infiniband/hw/irdma/verbs.c           | 187 +++++---
 drivers/infiniband/hw/irdma/verbs.h           |   3 +-
 drivers/infiniband/hw/mlx5/devx.c             |   2 +-
 drivers/infiniband/hw/mlx5/wr.c               |   2 +-
 drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c  |   2 +-
 drivers/infiniband/ulp/srpt/ib_srpt.c         |   3 +-
 drivers/input/keyboard/gpio_keys_polled.c     |  10 +-
 drivers/iommu/Kconfig                         |   2 +-
 drivers/iommu/amd/init.c                      |   3 +
 drivers/iommu/intel/Kconfig                   |  11 +
 drivers/iommu/intel/Makefile                  |   3 +
 drivers/iommu/intel/dmar.c                    |   7 +
 drivers/iommu/intel/iommu.h                   |  43 +-
 drivers/iommu/intel/pasid.c                   |   3 +
 drivers/iommu/intel/perfmon.c                 | 172 +++++++
 drivers/iommu/intel/perfmon.h                 |  40 ++
 drivers/iommu/irq_remapping.c                 |   3 +-
 drivers/leds/flash/leds-sgm3140.c             |   3 +
 drivers/leds/leds-aw2013.c                    |   1 +
 drivers/md/dm-bufio.c                         |   6 +-
 drivers/md/dm-cache-policy.h                  |   2 +-
 drivers/md/dm-crypt.c                         |   6 +-
 drivers/md/dm-integrity.c                     |  35 +-
 drivers/md/dm-io.c                            |  23 +-
 drivers/md/dm-kcopyd.c                        |   4 +-
 drivers/md/dm-log.c                           |  12 +-
 drivers/md/dm-raid.c                          |  12 +-
 drivers/md/dm-raid1.c                         |   8 +-
 drivers/md/dm-snap-persistent.c               |   4 +-
 drivers/md/dm-table.c                         |   4 +-
 drivers/md/dm-thin.c                          |   6 +-
 drivers/md/dm-verity-target.c                 |   2 +-
 drivers/md/dm-verity.h                        |   4 +-
 drivers/md/dm-writecache.c                    |   8 +-
 drivers/md/dm.c                               |  26 +-
 drivers/md/md.c                               |  28 +-
 drivers/md/persistent-data/dm-btree.c         |   6 +-
 .../md/persistent-data/dm-space-map-common.c  |   2 +-
 .../md/persistent-data/dm-space-map-common.h  |   2 +-
 drivers/md/raid10.c                           |   2 +
 drivers/media/common/v4l2-tpg/v4l2-tpg-core.c |  52 ++-
 drivers/media/dvb-core/dvbdev.c               |   5 +
 drivers/media/dvb-frontends/stv0367.c         |  34 +-
 drivers/media/i2c/tc358743.c                  |   7 +-
 .../media/platform/mediatek/mdp/mtk_mdp_vpu.c |   2 +-
 .../mediatek/vcodec/mtk_vcodec_fw_vpu.c       |  10 +-
 drivers/media/platform/mediatek/vpu/mtk_vpu.c |   2 +-
 drivers/media/platform/mediatek/vpu/mtk_vpu.h |   2 +-
 .../platform/rockchip/rkisp1/rkisp1-capture.c |   3 +
 .../platform/rockchip/rkisp1/rkisp1-common.h  |   2 +
 .../platform/rockchip/rkisp1/rkisp1-csi.c     |   3 +
 .../platform/rockchip/rkisp1/rkisp1-dev.c     |  22 +
 .../platform/rockchip/rkisp1/rkisp1-isp.c     |   3 +
 .../media/platform/sunxi/sun8i-di/sun8i-di.c  |  69 +--
 drivers/media/usb/em28xx/em28xx-cards.c       |   4 +
 drivers/media/usb/go7007/go7007-driver.c      |   8 +-
 drivers/media/usb/go7007/go7007-usb.c         |   4 +-
 drivers/media/usb/pvrusb2/pvrusb2-context.c   |  10 +-
 drivers/media/usb/pvrusb2/pvrusb2-dvb.c       |   6 +-
 drivers/media/usb/pvrusb2/pvrusb2-v4l2.c      |  11 +-
 drivers/media/v4l2-core/v4l2-mem2mem.c        |  10 +-
 drivers/mfd/altera-sysmgr.c                   |   4 +-
 drivers/mfd/syscon.c                          |   4 +-
 drivers/mmc/host/wmt-sdmmc.c                  |   4 -
 drivers/mtd/maps/physmap-core.c               |   2 +-
 drivers/mtd/nand/raw/lpc32xx_mlc.c            |   5 +-
 drivers/net/dsa/mt7530.c                      |  60 ++-
 drivers/net/dsa/mt7530.h                      |  22 +-
 drivers/net/ethernet/amazon/ena/ena_netdev.c  |  17 -
 .../net/ethernet/broadcom/bnx2x/bnx2x_cmn.h   |   6 +-
 .../net/ethernet/hisilicon/hns3/hns3_dcbnl.c  |   2 +-
 .../hisilicon/hns3/hns3pf/hclge_main.c        |   5 +-
 .../hisilicon/hns3/hns3pf/hclge_ptp.c         |   2 +-
 drivers/net/ethernet/intel/igb/igb_main.c     |  23 +-
 .../net/ethernet/marvell/octeontx2/af/cgx.c   |   2 +-
 .../net/ethernet/marvell/octeontx2/af/mbox.c  |  43 +-
 .../net/ethernet/marvell/octeontx2/af/mbox.h  |  31 ++
 .../marvell/octeontx2/af/mcs_rvu_if.c         |  17 +-
 .../net/ethernet/marvell/octeontx2/af/rvu.c   |  44 +-
 .../net/ethernet/marvell/octeontx2/af/rvu.h   |   8 +
 .../ethernet/marvell/octeontx2/af/rvu_cgx.c   |  20 +-
 .../ethernet/marvell/octeontx2/af/rvu_cpt.c   | 191 ++++++--
 .../marvell/octeontx2/nic/otx2_common.h       |   2 +-
 .../ethernet/marvell/octeontx2/nic/otx2_pf.c  | 124 +++--
 .../ethernet/marvell/octeontx2/nic/otx2_vf.c  |  74 +--
 drivers/net/ethernet/mediatek/mtk_eth_soc.c   |   7 +-
 drivers/net/ethernet/mediatek/mtk_ppe.c       |  18 +-
 .../ethernet/netronome/nfp/flower/lag_conf.c  |   5 +
 drivers/net/phy/dp83822.c                     |  37 +-
 drivers/net/phy/phy_device.c                  |   6 +-
 drivers/net/usb/smsc95xx.c                    |   5 +
 drivers/net/usb/sr9800.c                      |   4 +-
 drivers/net/veth.c                            |  18 -
 drivers/net/wireguard/receive.c               |   6 +-
 drivers/net/wireless/ath/ath10k/wmi-tlv.c     |   4 +
 drivers/net/wireless/ath/ath11k/mac.c         |   4 +
 drivers/net/wireless/ath/ath9k/htc.h          |   2 +-
 drivers/net/wireless/ath/ath9k/htc_drv_init.c |   4 +
 drivers/net/wireless/ath/ath9k/htc_drv_txrx.c |   4 -
 drivers/net/wireless/ath/ath9k/wmi.c          |  10 +-
 drivers/net/wireless/broadcom/b43/b43.h       |  16 +
 drivers/net/wireless/broadcom/b43/dma.c       |   4 +-
 drivers/net/wireless/broadcom/b43/main.c      |  16 +-
 drivers/net/wireless/broadcom/b43/pio.c       |   6 +-
 .../broadcom/brcm80211/brcmsmac/phy/phy_cmn.c |   3 +-
 .../broadcom/brcm80211/brcmsmac/phy_shim.c    |   5 +-
 .../broadcom/brcm80211/brcmsmac/phy_shim.h    |   2 +-
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c  |   2 +-
 .../net/wireless/intel/iwlwifi/iwl-dbg-tlv.c  |   6 +
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c   |   4 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c |  26 +-
 drivers/net/wireless/marvell/libertas/cmd.c   |  13 +-
 .../net/wireless/marvell/mwifiex/debugfs.c    |   3 -
 .../wireless/microchip/wilc1000/cfg80211.c    |  12 +-
 drivers/net/wireless/microchip/wilc1000/hif.c |  40 +-
 .../net/wireless/microchip/wilc1000/netdev.c  |  38 +-
 drivers/net/wireless/microchip/wilc1000/spi.c |   6 +-
 .../wireless/realtek/rtl8xxxu/rtl8xxxu_core.c |   1 +
 drivers/net/wireless/realtek/rtw88/main.c     |   2 -
 drivers/net/wireless/realtek/rtw88/phy.c      |   3 +
 drivers/net/wireless/realtek/rtw88/rtw8821c.c |   2 +-
 drivers/net/wireless/silabs/wfx/sta.c         |  15 +-
 drivers/ntb/core.c                            |   8 +-
 drivers/nvme/host/core.c                      |  13 +-
 drivers/nvme/host/fabrics.h                   |   7 -
 drivers/opp/debugfs.c                         |   6 +-
 drivers/pci/endpoint/functions/pci-epf-vntb.c |   5 +-
 drivers/pci/pci.h                             |   5 -
 drivers/pci/pcie/dpc.c                        |   2 +-
 drivers/pci/quirks.c                          |   1 +
 drivers/pci/switch/switchtec.c                |   4 +-
 drivers/perf/arm-cmn.c                        |  11 +
 drivers/pinctrl/mediatek/pinctrl-mt8186.c     |   1 -
 drivers/pinctrl/mediatek/pinctrl-mt8192.c     |   1 -
 drivers/pinctrl/nomadik/pinctrl-nomadik.c     |   6 +-
 drivers/pinctrl/renesas/pfc-r8a779g0.c        |  40 ++
 drivers/powercap/dtpm_cpu.c                   |   2 +-
 drivers/pwm/pwm-atmel-hlcdc.c                 |  71 ++-
 drivers/pwm/pwm-sti.c                         |  11 +-
 drivers/remoteproc/Kconfig                    |   2 +-
 drivers/remoteproc/stm32_rproc.c              |  24 +-
 drivers/rtc/Kconfig                           |   3 +-
 drivers/rtc/lib_test.c                        |   2 +-
 drivers/s390/block/dasd.c                     | 111 +++--
 drivers/s390/block/dasd_eer.c                 |   1 +
 drivers/s390/block/dasd_int.h                 |   2 +
 drivers/scsi/bfa/bfa.h                        |   9 +-
 drivers/scsi/bfa/bfa_core.c                   |   4 +-
 drivers/scsi/bfa/bfa_ioc.h                    |   8 +-
 drivers/scsi/bfa/bfad_bsg.c                   |  11 +-
 drivers/scsi/csiostor/csio_defs.h             |  18 +-
 drivers/scsi/csiostor/csio_lnode.c            |   8 +-
 drivers/scsi/csiostor/csio_lnode.h            |  13 -
 drivers/scsi/mpt3sas/mpt3sas_base.c           |   4 +-
 drivers/soc/fsl/dpio/dpio-service.c           |   2 +-
 drivers/soc/microchip/Kconfig                 |   2 +-
 drivers/soc/qcom/rpmhpd.c                     |   1 -
 drivers/spi/spi-mt65xx.c                      |  22 +-
 drivers/staging/greybus/light.c               |   8 +-
 .../deprecated/saa7146/ttpci/budget-av.c      |   8 +-
 .../staging/media/imx/imx-media-csc-scaler.c  |   1 +
 drivers/staging/media/sunxi/cedrus/cedrus.h   |   9 +-
 .../staging/media/sunxi/cedrus/cedrus_h265.c  |  73 +--
 drivers/tty/serial/8250/8250_exar.c           |   5 +-
 drivers/tty/serial/max310x.c                  |   2 +-
 drivers/tty/serial/samsung_tty.c              |   5 +-
 drivers/tty/vt/vt.c                           |   2 +-
 drivers/usb/gadget/udc/net2272.c              |   2 +-
 drivers/usb/phy/phy-generic.c                 |   7 +
 drivers/vdpa/mlx5/net/mlx5_vnet.c             |  13 +-
 drivers/vdpa/vdpa_sim/vdpa_sim.c              |   3 +-
 drivers/video/backlight/da9052_bl.c           |   1 +
 drivers/video/backlight/lm3630a_bl.c          |  15 +-
 drivers/video/backlight/lm3639_bl.c           |   1 +
 drivers/video/backlight/lp8788_bl.c           |   1 +
 drivers/watchdog/stm32_iwdg.c                 |   3 +
 fs/afs/dir.c                                  |  10 -
 fs/btrfs/block-rsv.c                          |   2 +-
 fs/btrfs/block-rsv.h                          |  32 ++
 fs/btrfs/space-info.c                         |  26 +-
 fs/f2fs/checkpoint.c                          |   6 +-
 fs/f2fs/compress.c                            |  48 +-
 fs/f2fs/data.c                                |  73 ++-
 fs/f2fs/f2fs.h                                |  85 ++--
 fs/f2fs/file.c                                | 106 ++---
 fs/f2fs/gc.c                                  |  10 +-
 fs/f2fs/inode.c                               |  57 +--
 fs/f2fs/node.c                                |  22 +-
 fs/f2fs/recovery.c                            |  33 +-
 fs/f2fs/segment.c                             |   8 +-
 fs/f2fs/segment.h                             |  17 +-
 fs/f2fs/super.c                               |  10 +-
 fs/fcntl.c                                    |  12 +-
 fs/fhandle.c                                  |   2 +-
 fs/nfs/export.c                               |   9 +-
 fs/nfs/flexfilelayout/flexfilelayout.c        |   2 +-
 fs/nfs/nfs42.h                                |   7 +-
 fs/nfs/nfs4proc.c                             |  16 +-
 fs/nfs/nfsroot.c                              |   4 +-
 fs/nfsd/filecache.c                           | 433 ++++++++----------
 fs/nfsd/filecache.h                           |   9 +-
 fs/nfsd/nfs4state.c                           |   4 +-
 fs/nfsd/nfs4xdr.c                             |  50 +-
 fs/pstore/inode.c                             |  76 ++-
 fs/quota/dquot.c                              | 226 ++++-----
 fs/select.c                                   |   2 +-
 include/drm/drm_fixed.h                       |   5 +-
 include/dt-bindings/clock/r8a779g0-cpg-mssr.h |   1 +
 include/linux/dm-io.h                         |   3 +-
 include/linux/exportfs.h                      |   1 +
 include/linux/filter.h                        |  21 +-
 include/linux/io_uring.h                      |  10 +-
 include/linux/io_uring_types.h                |   3 -
 include/linux/mlx5/qp.h                       |   5 +-
 include/linux/moduleloader.h                  |   8 +
 include/linux/pci.h                           |   5 +
 include/linux/poll.h                          |   4 -
 include/linux/rcupdate.h                      |  31 ++
 include/net/bluetooth/hci.h                   |   1 -
 include/net/bluetooth/hci_core.h              |  13 +-
 include/net/bluetooth/hci_sync.h              |   4 +-
 include/uapi/rdma/irdma-abi.h                 |   6 +
 init/main.c                                   |   5 +-
 io_uring/filetable.c                          |  10 +-
 io_uring/io_uring.c                           |  44 +-
 io_uring/io_uring.h                           |   1 -
 io_uring/net.c                                | 260 ++++++-----
 io_uring/rsrc.c                               | 151 +-----
 io_uring/rsrc.h                               |  15 -
 kernel/bpf/core.c                             |   7 +-
 kernel/bpf/cpumap.c                           |   3 +
 kernel/bpf/devmap.c                           |  11 +-
 kernel/bpf/hashtab.c                          |  14 +-
 kernel/bpf/helpers.c                          |   4 +-
 kernel/bpf/stackmap.c                         |   9 +-
 kernel/module/main.c                          |   9 +-
 kernel/printk/printk.c                        |  29 ++
 kernel/rcu/tree.c                             |   3 +
 kernel/rcu/tree_exp.h                         |  25 +-
 kernel/sched/fair.c                           |  16 +-
 kernel/time/time_test.c                       |   2 +-
 kernel/time/timekeeping.c                     |  24 +-
 lib/cmdline_kunit.c                           |   2 +-
 lib/memcpy_kunit.c                            |   4 +-
 lib/test_blackhole_dev.c                      |   3 +-
 net/bluetooth/af_bluetooth.c                  |  10 +-
 net/bluetooth/eir.c                           |  29 +-
 net/bluetooth/hci_conn.c                      | 154 ++-----
 net/bluetooth/hci_core.c                      | 129 ++++--
 net/bluetooth/hci_event.c                     |  32 +-
 net/bluetooth/hci_request.c                   |   2 +-
 net/bluetooth/hci_sync.c                      |  89 +++-
 net/bluetooth/mgmt.c                          |  61 +--
 net/bluetooth/rfcomm/core.c                   |   2 +-
 net/core/dev.c                                |   5 +-
 net/core/scm.c                                |   2 +-
 net/core/skbuff.c                             |   8 +
 net/core/sock_diag.c                          |  10 +-
 net/hsr/hsr_framereg.c                        |   4 +
 net/hsr/hsr_main.c                            |  15 +-
 net/ipv4/inet_diag.c                          |   6 +-
 net/ipv4/inet_hashtables.c                    |   2 +-
 net/ipv4/inet_timewait_sock.c                 |  41 +-
 net/ipv4/ip_tunnel.c                          |  15 +-
 net/ipv4/ipmr.c                               |   4 +-
 net/ipv4/raw.c                                |   1 +
 net/ipv4/tcp.c                                |   4 +-
 net/ipv4/tcp_minisocks.c                      |   4 -
 net/ipv4/udp.c                                |   4 +-
 net/ipv6/fib6_rules.c                         |   6 +
 net/ipv6/mcast.c                              |   1 -
 net/iucv/iucv.c                               |   4 +-
 net/kcm/kcmsock.c                             |   3 +-
 net/l2tp/l2tp_ppp.c                           |   4 +-
 net/mac80211/rate.c                           |   3 +-
 net/mctp/route.c                              |   3 +
 net/netfilter/nf_tables_api.c                 |   2 +-
 net/netfilter/nft_set_pipapo.c                |   5 +-
 net/packet/af_packet.c                        |   4 +-
 net/rds/send.c                                |   5 +-
 net/sched/sch_taprio.c                        |   3 +-
 net/sunrpc/addr.c                             |   4 +-
 net/sunrpc/auth_gss/gss_rpc_xdr.c             |  27 +-
 net/unix/garbage.c                            |   2 +-
 net/unix/scm.c                                |   4 +-
 net/x25/af_x25.c                              |   4 +-
 scripts/clang-tools/gen_compile_commands.py   |   2 +-
 scripts/kconfig/lexer.l                       |   7 +-
 sound/core/seq/seq_midi.c                     |   8 +-
 sound/core/seq/seq_virmidi.c                  |   9 +-
 sound/pci/hda/patch_realtek.c                 |  64 +++
 sound/soc/amd/acp/acp-sof-mach.c              |  14 +-
 sound/soc/amd/yc/acp6x-mach.c                 |  21 +
 sound/soc/codecs/rt5645.c                     |  10 +
 sound/soc/codecs/wm8962.c                     |  29 +-
 sound/soc/intel/boards/bytcr_rt5640.c         |  12 +
 sound/soc/meson/aiu.c                         |  19 +-
 sound/soc/meson/aiu.h                         |   1 -
 sound/soc/meson/axg-tdm-interface.c           |  29 +-
 sound/soc/meson/t9015.c                       |  20 +-
 sound/soc/rockchip/rockchip_i2s_tdm.c         | 352 +-------------
 sound/soc/sof/ipc3-loader.c                   |  28 +-
 sound/soc/sof/ipc4-loader.c                   |   6 +-
 sound/soc/sof/loader.c                        |  18 +-
 sound/soc/sof/sof-priv.h                      |  14 +
 sound/usb/stream.c                            |   5 +-
 tools/bpf/bpftool/prog.c                      |   2 +-
 tools/bpf/resolve_btfids/main.c               |  70 ++-
 tools/include/linux/btf_ids.h                 |   9 +
 tools/lib/bpf/bpf.h                           |   2 +-
 tools/lib/bpf/libbpf.c                        |   4 +
 tools/lib/bpf/libbpf_internal.h               |  14 +
 tools/perf/builtin-record.c                   |   2 +-
 tools/perf/util/evsel.c                       |   1 -
 tools/perf/util/stat-display.c                |   2 +-
 tools/perf/util/thread_map.c                  |   2 +-
 .../selftests/bpf/progs/test_map_in_map.c     |  26 ++
 tools/testing/selftests/bpf/test_maps.c       |   6 +-
 tools/testing/selftests/net/forwarding/config |  35 ++
 .../net/forwarding/vxlan_bridge_1d_ipv6.sh    |   4 +-
 .../net/forwarding/vxlan_bridge_1q_ipv6.sh    |   4 +-
 tools/testing/selftests/net/tls.c             |   8 +-
 476 files changed, 4661 insertions(+), 3362 deletions(-)
 create mode 100644 drivers/iommu/intel/perfmon.c
 create mode 100644 drivers/iommu/intel/perfmon.h

-- 
2.43.0


