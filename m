Return-Path: <linux-kernel+bounces-114006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94941888F0A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:35:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A88B41C2B4EB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BADB1474CD;
	Sun, 24 Mar 2024 23:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dJm3GM3A"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293CE1F9C39;
	Sun, 24 Mar 2024 23:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321280; cv=none; b=k8BnHNTd8AnawA100A6zch7Hmexf45gZXjG3CoGx/6DYEFrSqErRlajvGqae5lJZZpzoMIOc+YoZX1HFVEdbC1Fd16RyILNf95r7uVNYQ3kQ/7BKDjoJrjxko+Nhts380KIaKlf0T8Tp5VrGJfbmoUODU+HRzsahHsU4APNd22E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321280; c=relaxed/simple;
	bh=VDdkL3Y8f+ZlP+pYbfyEbb+HJFAbbuyfA/5yyVYheSo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=i9Q8t02OKiOW2S2R16pP4Hx2u42fRtzz5FB4EU3Hp9+J/lAhjPQwhLCcwHy+rJVMo0BJf6TMt+s5+8c1OXWlm3hNvGPJN5Q4Pdzx8FC8m6UM7W6z1WvOkAQhYxTu43VSUC3YskTnNfxBjq4W7rUG1PVHqL+p7nyEn3NvbkSaJA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dJm3GM3A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9487EC433F1;
	Sun, 24 Mar 2024 23:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321279;
	bh=VDdkL3Y8f+ZlP+pYbfyEbb+HJFAbbuyfA/5yyVYheSo=;
	h=From:To:Cc:Subject:Date:From;
	b=dJm3GM3AeHQz5pgkpGnRShTr2JvtBk1k7UY4xsLlvevk6gD0XaA9M7YIu8qYouvBG
	 VYhhwFbWh9EUTX4BtxSqIPNoM62jRiz+AhlS1jAgPNgqK54HBnh4XVP/fYoyzdcOJI
	 hgGqL/InONKjJTQ7EWHPq2ka14kDgu9FNnYsPC2f2RjXgBxtuhr1LI++0Yw6oaiJQG
	 8ATE67PGUWsjRN0MEIunPvnZNTVXyn217cwwcW9aMvvkOZVjRhpst3TSxDCLpNJHVe
	 nZ7JEPt86bLTqcOZU7hn9wfDbBLy9rqXMznaXr7n38ak5RVMlUOY6laaeE3XXMl45J
	 yqxGRotYadGDQ==
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
Subject: [PATCH 6.6 000/638] 6.6.23-rc1 review
Date: Sun, 24 Mar 2024 18:50:37 -0400
Message-ID: <20240324230116.1348576-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.23-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.6.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.6.23-rc1
X-KernelTest-Deadline: 2024-03-26T23:01+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit


This is the start of the stable review cycle for the 6.6.23 release.
There are 638 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Tue Mar 26 11:01:10 PM UTC 2024.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
        https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/patch/?id=linux-6.6.y&id2=v6.6.22
or in the git tree and branch at:
        git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
and the diffstat can be found below.

Thanks,
Sasha

-------------
Pseudo-Shortlog of commits:

Aaron Conole (1):
  selftests: openvswitch: Add validation for the recursion test

Abel Vesa (1):
  arm64: dts: qcom: sm8550: Fix SPMI channels size

Abhinav Kumar (1):
  drm/msm/dpu: fix the programming of INTF_CFG2_DATA_HCTL_EN

Adam Butcher (1):
  spi: spi-imx: fix off-by-one in mx51 CPU mode burst length

Adam Guerin (1):
  crypto: qat - avoid division by zero

Adam Skladowski (1):
  dt-bindings: msm: qcom, mdss: Include ommited fam-b compatible

Ajay Singh (2):
  wifi: wilc1000: do not realloc workqueue everytime an interface is
    added
  wifi: wilc1000: fix multi-vif management when deleting a vif

Al Raj Hassain (1):
  ASoC: amd: yc: Add HP Pavilion Aero Laptop 13-be2xxx(8BD6) into DMI
    quirk table

Al Viro (1):
  erofs: fix handling kern_mount() failure

Alban Boyé (1):
  ASoC: Intel: bytcr_rt5640: Add an extra entry for the Chuwi Vi8 tablet

Alex Bee (1):
  drm/rockchip: inno_hdmi: Fix video timing

Alexander Gordeev (1):
  net/iucv: fix the allocation size of iucv_path_table array

Alexander Stein (2):
  media: tc358743: register v4l2 async device only after successful
    setup
  media: i2c: imx290: Fix IMX920 typo

Alexander Sverdlin (1):
  spi: lpspi: Avoid potential use-after-free in probe()

Alexander Usyskin (1):
  mei: gsc_proxy: match component when GSC is on different bus

Alexandre Ghiti (1):
  riscv: Fix compilation error with FAST_GUP and rv32

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

Alison Schofield (2):
  cxl/region: Handle endpoint decoders in cxl_region_find_decoder()
  cxl/region: Allow out of order assembly of autodiscovered regions

Amir Goldstein (4):
  ovl: remove unused code in lowerdir param parsing
  ovl: store and show the user provided lowerdir mount option
  ovl: refactor layer parsing helpers
  ovl: add support for appending lowerdirs one by one

Anastasia Belova (1):
  cpufreq: brcmstb-avs-cpufreq: add check for cpufreq_cpu_get's return
    value

Andre Przywara (1):
  firmware: arm_scmi: Fix double free in SMC transport cleanup path

Andre Werner (1):
  net: smsc95xx: add support for SYS TEC USB-SPEmodule1

Andrejs Cainikovs (1):
  arm64: dts: ti: k3-am62-main: disable usb lpm

Andrew Ballance (1):
  gen_compile_commands: fix invalid escape sequence warning

Andrew Davis (1):
  arm64: dts: ti: k3-am64: Enable SDHCI nodes at the board level

Andrey Grafin (2):
  libbpf: Apply map_set_def_max_entries() for inner_maps on creation
  selftest/bpf: Add map_in_maps with BPF_MAP_TYPE_PERF_EVENT_ARRAY
    values

Andrey Skvortsov (2):
  Bluetooth: hci_h5: Add ability to allocate memory for private data
  Bluetooth: btrtl: fix out of bounds memory access

Andrii Nakryiko (3):
  libbpf: Fix faccessat() usage on Android
  libbpf: Add missing LIBBPF_API annotation to libbpf_set_memlock_rlim
    API
  bpf: don't infer PTR_TO_CTX for programs with unnamed context type

Andy Shevchenko (1):
  serial: 8250_exar: Don't remove GPIO device on suspend

AngeloGioacchino Del Regno (1):
  drm/mediatek: dsi: Fix DSI RGB666 formats and definitions

Ard Biesheuvel (3):
  x86/sme: Fix memory encryption setting if enabled by default and not
    overridden
  x86/efistub: Clear decompressor BSS in native EFI entrypoint
  x86/efistub: Don't clear BSS twice in mixed mode

Armin Wolf (1):
  ACPI: processor_idle: Fix memory leak in acpi_processor_power_exit()

Arnaldo Carvalho de Melo (1):
  perf bpf: Clean up the generated/copied vmlinux.h

Arnaud Pouliquen (2):
  remoteproc: stm32: Fix incorrect type in assignment for va
  remoteproc: stm32: Fix incorrect type assignment returned by
    stm32_rproc_get_loaded_rsc_tablef

Arnd Bergmann (11):
  fs/select: rework stack allocation hack for clang
  cpufreq: qcom-hw: add CONFIG_COMMON_CLK dependency
  wifi: brcmsmac: avoid function pointer casts
  media: pvrusb2: fix pvr2_stream_callback casts
  crypto: arm/sha - fix function cast warnings
  mtd: rawnand: lpc32xx_mlc: fix irq handler prototype
  media: dvb-frontends: avoid stack overflow warnings with clang
  media: mediatek: vcodec: avoid -Wcast-function-type-strict warning
  scsi: csiostor: Avoid function pointer casts
  scsi: bfa: Fix function pointer type mismatch for hcb_qe->cbfn
  soc: fsl: dpio: fix kcalloc() argument order

Artem Savkov (1):
  selftests/bpf: Fix potential premature unload in bpf_testmod

Arthur Grillo (1):
  drm: Fix drm_fixp2int_round() making it add 0.5

Arınç ÜNAL (3):
  net: dsa: mt7530: prevent possible incorrect XTAL frequency selection
  net: dsa: mt7530: fix link-local frames that ingress vlan filtering
    ports
  net: dsa: mt7530: fix handling of all link-local frames

Asad Kamal (1):
  drm/amd/pm: Fix esm reg mask use to get pcie speed

Athaariq Ardhiansyah (1):
  ALSA: hda/realtek: fix ALC285 issues on HP Envy x360 laptops

Attila Tőkés (1):
  ASoC: amd: yc: Fix non-functional mic on Lenovo 82UU

Audra Mitchell (1):
  workqueue.c: Increase workqueue name length

Babu Moger (2):
  x86/resctrl: Remove hard-coded memory bandwidth limit
  x86/resctrl: Read supported bandwidth sources from CPUID

Baochen Qiang (1):
  wifi: ath11k: initialize rx_mcs_80 and rx_mcs_160 before use

Baokun Li (1):
  erofs: fix lockdep false positives on initializing erofs_pseudo_mnt

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

Benjamin Lin (2):
  wifi: mt76: mt7996: fix incorrect interpretation of EHT MCS caps
  wifi: mt76: mt7996: fix HIF_TXD_V2_1 value

Bert Karwatzki (1):
  iommu: Fix compilation without CONFIG_IOMMU_INTEL

Bhavya Kapoor (4):
  arm64: dts: ti: k3-j7200-common-proc-board: Modify Pinmux for
    wkup_uart0 and mcu_uart0
  arm64: dts: ti: k3-j7200-common-proc-board: Remove clock-frequency
    from mcu_uart0
  arm64: dts: ti: k3-j721s2-common-proc-board: Remove Pinmux for CTS and
    RTS in wkup_uart0
  arm64: dts: ti: k3-j784s4-evm: Remove Pinmux for CTS and RTS in
    wkup_uart0

Bitterblue Smith (3):
  wifi: rtw88: 8821cu: Fix firmware upload fail
  wifi: rtw88: 8821c: Fix beacon loss and disconnect
  wifi: rtw88: 8821c: Fix false alarm count

Bjorn Andersson (2):
  pmdomain: qcom: rpmhpd: Drop SA8540P gfx.lvl
  arm64: dts: qcom: sa8540p: Drop gfx.lvl as power-domain for gpucc

Breno Leitao (1):
  net: blackhole_dev: fix build warning for ethh set but not used

Bryan O'Donoghue (1):
  clk: Fix clk_core_get NULL dereference

Changbin Du (1):
  modules: wait do_free_init correctly

Chao Yu (19):
  f2fs: compress: fix to guarantee persisting compressed blocks by CP
  f2fs: compress: fix to cover normal cluster write with cp_rwsem
  f2fs: delete obsolete FI_FIRST_BLOCK_WRITTEN
  f2fs: delete obsolete FI_DROP_CACHE
  f2fs: introduce get_dnode_addr() to clean up codes
  f2fs: update blkaddr in __set_data_blkaddr() for cleanup
  f2fs: compress: fix to avoid inconsistence bewteen i_blocks and dnode
  f2fs: fix to remove unnecessary f2fs_bug_on() to avoid panic
  f2fs: zone: fix to wait completion of last bio in zone correctly
  f2fs: compress: fix to cover f2fs_disable_compressed_file() w/ i_sem
  f2fs: fix to avoid potential panic during recovery
  f2fs: fix to create selinux label during whiteout initialization
  f2fs: compress: fix to check zstd compress level correctly in mount
    option
  f2fs: compress: fix to check compress flag w/ .i_sem lock
  f2fs: fix to use correct segment type in f2fs_allocate_data_block()
  f2fs: ro: compress: fix to avoid caching unaligned extent
  f2fs: introduce f2fs_invalidate_internal_cache() for cleanup
  f2fs: fix to truncate meta inode pages forcely
  f2fs: zone: fix to remove pow2 check condition for zoned block device

Charles Keepax (1):
  ASoC: cs42l43: Handle error from devm_pm_runtime_enable

Chen Ni (2):
  sr9800: Add check for usbnet_get_endpoints
  drm/tegra: dsi: Add missing check for of_find_device_by_node

Chen-Yu Tsai (4):
  arm64: dts: allwinner: h6: Add RX DMA channel for SPDIF
  pinctrl: mediatek: Drop bogus slew rate register range for MT8186
  pinctrl: mediatek: Drop bogus slew rate register range for MT8192
  clk: mediatek: mt8183: Correct parent of CLK_INFRA_SSPM_32K_SELF

Christian König (1):
  drm/ttm/tests: depend on UML || COMPILE_TEST

Christoph Hellwig (1):
  iomap: clear the per-folio dirty bits on all writeback failures

Christophe JAILLET (17):
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
  PCI/P2PDMA: Fix a sleeping issue in a RCU read section
  PCI: switchtec: Fix an error handling path in switchtec_pci_probe()
  clk: hisilicon: hi3519: Release the correct number of gates in
    hi3519_clk_unregister()
  clk: hisilicon: hi3559a: Fix an erroneous devm_kfree()
  clk: mediatek: mt8135: Fix an error handling path in
    clk_mt8135_apmixed_probe()
  clk: mediatek: mt7622-apmixedsys: Fix an error handling path in
    clk_mt8135_apmixed_probe()
  perf pmu: Fix a potential memory leak in perf_pmu__lookup()
  net: sunrpc: Fix an off by one in rpc_sockaddr2uaddr()
  NFS: Fix an off by one in root_nfs_cat()
  thermal/drivers/mediatek/lvts_thermal: Fix a memory leak in an error
    handling path

Christophe Leroy (1):
  powerpc: Force inlining of arch_vmap_p{u/m}d_supported()

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

Cristian Ciocaltea (2):
  ASoC: amd: acp: Add missing error handling in sof-mach
  ASoC: SOF: amd: Fix memory leak in amd_sof_acp_probe()

Damian Muszynski (1):
  crypto: qat - fix ring to service map for dcc in 4xxx

Dan Carpenter (5):
  io_uring/net: fix overflow check in io_recvmsg_mshot_prep()
  Bluetooth: msft: __hci_cmd_sync() doesn't return NULL
  ASoC: SOF: Add some bounds checking to firmware data
  bus: mhi: ep: check the correct variable in
    mhi_ep_register_controller()
  staging: greybus: fix get_channel_from_mode() failure path

Daniel Borkmann (2):
  selftests/bpf: De-veth-ize the tc_redirect test case
  selftests/bpf: Add netkit to tc_redirect selftest

Daniel Gabay (1):
  wifi: iwlwifi: mvm: use correct address 3 in A-MSDU

Daniel Golle (3):
  clk: mediatek: mt7981-topckgen: flag SGM_REG_SEL as critical
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

Dave Wysochanski (1):
  NFS: Fix nfs_netfs_issue_read() xarray locking for writeback interrupt

David Gow (5):
  kunit: test: Log the correct filter string in executor_test
  lib/cmdline: Fix an invalid format specifier in an assertion msg
  lib: memcpy_kunit: Fix an invalid format specifier in an assertion msg
  time: test: Fix incorrect format specifier
  rtc: test: Fix invalid format specifier.

David Heidelberg (1):
  arm64: dts: qcom: sdm845-oneplus-common: improve DAI node naming

David Howells (3):
  cifs: Don't use certain unnecessary folio_*() functions
  cifs: Fix writeback data corruption
  afs: Revert "afs: Hide silly-rename files from userspace"

David McFarland (1):
  ACPI: resource: Add Infinity laptops to irq1_edge_low_force_override

Deren Wu (1):
  wifi: mt76: mt7921e: fix use-after-free in free_irq()

Devarsh Thakkar (2):
  arm64: dts: ti: Add common1 register space for AM65x SoC
  arm64: dts: ti: Add common1 register space for AM62x SoC

Dmitry Baryshkov (6):
  soc: qcom: socinfo: rename PM2250 to PM4125
  arm64: dts: qcom: msm8998: switch USB QMP PHY to new style of bindings
  arm64: dts: qcom: msm8998: declare VLS CLAMP register for USB3 PHY
  arm64: dts: qcom: qcm2290: declare VLS CLAMP register for USB3 PHY
  arm64: dts: qcom: sm6115: declare VLS CLAMP register for USB3 PHY
  drm: ci: use clk_ignore_unused for apq8016

Douglas Anderson (1):
  drm/panel: boe-tv101wum-nl6: make use of prepare_prev_first

Duanqiang Wen (1):
  net: txgbe: fix clk_name exceed MAX_DEV_ID limits

Duoming Zhou (3):
  wifi: brcm80211: handle pmk_op allocation failure
  nfp: flower: handle acti_netdevs allocation failure
  clk: zynq: Prevent null pointer dereference caused by kmalloc failure

Dylan Hung (1):
  i3c: dw: Disable IBI IRQ depends on hot-join and SIR enabling

Edward Adam Davis (1):
  media: pvrusb2: fix uaf in pvr2_context_set_notify

Emmanuel Grumbach (2):
  wifi: iwlwifi: mvm: fix the TLC command after ADD_STA
  wifi: iwlwifi: mvm: don't set the MFP flag for the GTK

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

Eugen Hristev (2):
  arm64: dts: mediatek: mt8192: fix vencoder clock name
  arm64: dts: mediatek: mt8186: fix VENC power domain clocks

Ezra Buehler (1):
  mtd: spinand: esmt: Extend IDs to 5 bytes

Fedor Pchelkin (1):
  drm/tegra: put drm_gem_object ref on error in tegra_fb_create

Fei Shao (1):
  spi: spi-mt65xx: Fix NULL pointer access in interrupt handler

Fei Wu (1):
  perf: RISCV: Fix panic on pmu overflow handler

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

Gabor Juhos (3):
  clk: qcom: gcc-ipq5018: fix 'enable_reg' offset of 'gcc_gmac0_sys_clk'
  clk: qcom: gcc-ipq5018: fix 'halt_reg' offset of 'gcc_pcie1_pipe_clk'
  clk: qcom: gcc-ipq5018: fix register offset for GCC_UBI0_AXI_ARES
    reset

Gabriel Krisman Bertazi (2):
  ovl: Always reject mounting over case-insensitive directories
  io_uring: Fix release of pinned pages when __io_uaddr_map fails

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

Geert Uytterhoeven (12):
  soc: microchip: Fix POLARFIRE_SOC_SYS_CTRL input prompt
  ARM: dts: renesas: rcar-gen2: Add missing #interrupt-cells to DA9063
    nodes
  ARM: dts: renesas: r8a73a4: Fix external clocks and clock rate
  arm64: dts: renesas: r8a779g0: Restore sort order
  arm64: dts: renesas: r8a779g0: Add missing SCIF_CLK2
  ARM: dts: arm: realview: Fix development chip ROM compatible value
  arm64: dts: renesas: r8a779a0: Correct avb[01] reg sizes
  arm64: dts: renesas: r8a779g0: Correct avb[01] reg sizes
  pinctrl: renesas: r8a779g0: Add missing SCIF_CLK2 pin group/function
  clk: renesas: r8a779g0: Correct PFC/GPIO parent clocks
  clk: renesas: r8a779f0: Correct PFC/GPIO parent clock
  pinctrl: renesas: Allow the compiler to optimize away sh_pfc_pm

Gen Xu (1):
  wifi: mt76: mt792x: fix ethtool warning

George Stark (1):
  leds: aw2013: Unlock mutex before destroying it

Gergo Koteles (7):
  ALSA: hda/tas2781: use dev_dbg in system_resume
  ALSA: hda/tas2781: add lock to system_suspend
  ALSA: hda/tas2781: do not reset cur_* values in runtime_suspend
  ALSA: hda/tas2781: add ptrs to calibration functions
  ALSA: hda/tas2781: do not call pm_runtime_force_* in
    system_resume/suspend
  ALSA: hda/tas2781: configure the amp after firmware load
  ALSA: hda/tas2781: restore power state after system_resume

Giovanni Cabiddu (1):
  crypto: qat - move adf_cfg_services

Greg Joyce (1):
  block: sed-opal: handle empty atoms when parsing response

Hans de Goede (3):
  platform/x86: p2sb: On Goldmont only cache P2SB and SPI devfn BAR
  ASoC: rt5645: Make LattePanda board DMI match more precise
  platform/x86: x86-android-tablets: Fix acer_b1_750_goodix_gpios name

Harry Wentland (2):
  drm: Don't treat 0 as -1 in drm_fixp2int_ceil
  drm/vkms: Avoid reading beyond LUT array

Heiko Carstens (1):
  s390/cache: prevent rebuild of shared_cpu_list

Heiko Stuebner (3):
  arm64: dts: rockchip: add missing interrupt-names for rk356x vdpu
  arm64: dts: rockchip: fix reset-names for rk356x i2s2 controller
  arm64: dts: rockchip: drop rockchip,trcm-sync-tx-only from rk3588 i2s

Hojin Nam (1):
  perf: CXL: fix CPMU filter value mask length

Hongyu Jin (1):
  dm io: Support IO priority

Hou Tao (2):
  x86/mm: Move is_vsyscall_vaddr() into asm/vsyscall.h
  x86/mm: Disallow vsyscall page read for copy_from_kernel_nofault()

Howard Hsu (1):
  wifi: mt76: mt7996: fix HE beamformer phy cap for station vif

Hsin-Te Yuan (1):
  arm64: dts: mt8195-cherry-tomato: change watchdog reset boot flow

Hsin-Yi Wang (2):
  drm/panel-edp: use put_sync in unprepare
  drm/mediatek: Fix a null pointer crash in
    mtk_drm_crtc_finish_page_flip

Hugo Villeneuve (1):
  serial: max310x: fix syntax error in IRQ error message

Ian Abbott (1):
  comedi: comedi_test: Prevent timers rescheduling during deletion

Ian Rogers (5):
  perf pmu: Treat the msr pmu as software
  perf srcline: Add missed addr2line closes
  perf expr: Fix "has_event" function for metric style events
  perf stat: Avoid metric-only segv
  perf metric: Don't remove scale from counts

Ido Schimmel (2):
  selftests: forwarding: Add missing multicast routing config entries
  selftests: forwarding: Fix ping failure due to short timeout

Ignat Korchagin (1):
  net: veth: do not manipulate GRO when using XDP

Igor Prusov (1):
  clk: meson: Add missing clocks to axg_clk_regmaps

Ilan Peer (1):
  wifi: iwlwifi: mvm: Fix the listener MAC filter flags

Ilkka Koskinen (1):
  perf/arm-cmn: Workaround AmpereOneX errata AC04_MESH_1 (incorrect
    child count)

Ilpo Järvinen (1):
  PCI/DPC: Print all TLP Prefixes, not just the first

Jaegeuk Kim (1):
  f2fs: check number of blocks in a current section

Jai Luthra (1):
  arm64: dts: ti: k3-am62p: Fix memory ranges for DMSS

Jakub Kicinski (1):
  selftests: tls: use exact comparison in recv_partial

James Clark (1):
  coresight: Fix issue where a source device's helpers aren't disabled

Jan Höppner (1):
  s390/dasd: Use dev_*() for device log messages

Jan Kara (4):
  block: Provide bdev_open_* functions
  erofs: Convert to use bdev_open_by_path()
  quota: Fix rcu annotations of inode dquot pointers
  quota: Properly annotate i_dquot arrays with __rcu

Jason Gunthorpe (1):
  iommu/arm-smmu-v3: Check that the RID domain is S1 in SVA

Jeff Johnson (1):
  wifi: ath12k: Update Qualcomm Innovation Center, Inc. copyrights

Jeff LaBundy (1):
  Input: iqs7222 - add support for IQS7222D v1.1 and v1.2

Jens Axboe (7):
  io_uring/unix: drop usage of io_uring socket
  io_uring: drop any code related to SCM_RIGHTS
  io_uring: remove looping around handling traditional task_work
  io_uring: remove unconditional looping in local task_work handling
  io_uring/net: unify how recvmsg and sendmsg copy in the msghdr
  io_uring/net: move receive multishot out of the generic msghdr path
  io_uring: don't save/restore iowait state

Jeremy Kerr (1):
  net: mctp: copy skb ext data when fragmenting

Jernej Skrabec (4):
  media: cedrus: h265: Fix configuring bitstream size
  media: sun8i-di: Fix coefficient writes
  media: sun8i-di: Fix power on/off sequences
  media: sun8i-di: Fix chroma difference threshold

Jerome Brunet (4):
  ASoC: meson: aiu: fix function pointer type mismatch
  ASoC: meson: t9015: fix function pointer type mismatch
  ASoC: meson: axg-tdm-interface: fix mclk setup without mclk-fs
  ASoC: meson: axg-tdm-interface: add frame rate constraint

Ji Sheng Teoh (1):
  watchdog: starfive: Check pm_runtime_enabled() before decrementing
    usage counter

Jianhua Lu (1):
  backlight: ktz8866: Correct the check for of_property_read_u32

Jiawei Wang (1):
  ASoC: amd: yc: Fix non-functional mic on Lenovo 21J2

Jiaxun Yang (1):
  MIPS: Clear Cause.BD in instruction_pointer_set

Jie Wang (2):
  net: hns3: fix port duplex configure error in IMP reset
  crypto: qat - relocate and rename get_service_enabled()

Jijie Shao (1):
  net: hns3: fix wrong judgment condition issue

Jinjie Ruan (1):
  wifi: mwifiex: debugfs: Drop unnecessary error check for
    debugfs_create_dir()

Jiri Pirko (1):
  devlink: fix port new reply cmd type

Jiri Slaby (SUSE) (1):
  tty: vt: fix 20 vs 0x20 typo in EScsiignore

Johan Carlsson (1):
  ALSA: usb-audio: Stop parsing channels bits when all channels are
    found.

Johan Hovold (2):
  soc: qcom: pmic_glink_altmode: fix drm bridge use-after-free
  PCI/AER: Fix rootport attribute paths in ABI docs

Johannes Berg (7):
  wifi: iwlwifi: mvm: report beacon protection failures
  wifi: iwlwifi: dbg-tlv: ensure NUL termination
  wifi: iwlwifi: acpi: fix WPFC reading
  wifi: iwlwifi: mvm: initialize rates in FW earlier
  wifi: iwlwifi: mvm: d3: fix IPN byte order
  wifi: iwlwifi: mvm: fix erroneous queue index mask
  wifi: iwlwifi: mvm: don't set replay counters to 0xff

John Keeping (1):
  regulator: userspace-consumer: add module device table

Johnny Hsieh (1):
  ASoC: amd: yc: Add Lenovo ThinkBook 21J0 into DMI quirk table

Jon Hunter (1):
  memory: tegra: Correct DLA client names

Jonah Palmer (1):
  vdpa/mlx5: Allow CVQ size changes

Jonas Dreßler (3):
  Bluetooth: Remove HCI_POWER_OFF_TIMEOUT
  Bluetooth: mgmt: Remove leftover queuing of power_off work
  Bluetooth: Remove superfluous call to hci_conn_check_pending()

Jonathan Bell (1):
  PCI: brcmstb: Fix broken brcm_pcie_mdio_write() polling

Jorge Mora (2):
  NFSv4.2: fix nfs4_listxattr kernel BUG at mm/usercopy.c:102
  NFSv4.2: fix listxattr maximum XDR buffer size

Josef Bacik (1):
  nfs: fix panic when nfs4_ff_layout_prepare_ds() fails

Josh Poimboeuf (1):
  objtool: Fix UNWIND_HINT_{SAVE,RESTORE} across basic blocks

Judith Mendez (1):
  arm64: dts: ti: k3-am64-main: Fix ITAP/OTAP values for MMC

Juergen Gross (2):
  xen/evtchn: avoid WARN() when unbinding an event channel
  xen/events: increment refcnt only if event channel is refcounted

Julien Massot (2):
  media: cadence: csi2rx: use match fwnode for media link
  media: v4l2: cci: print leading 0 on error

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
  perf top: Uniform the event name for the hybrid machine

Kang Yang (1):
  wifi: ath12k: fix incorrect logic of calculating vdev_stats_id

Kees Cook (3):
  pstore: inode: Convert mutex usage to guard(mutex)
  pstore: inode: Only d_invalidate() is needed
  x86, relocs: Ignore relocations in .notes section

Keisuke Nishimura (2):
  sched/fair: Take the scheduling domain into account in
    select_idle_smt()
  sched/fair: Take the scheduling domain into account in
    select_idle_core()

Konrad Dybcio (12):
  arm64: dts: qcom: sc8180x: Hook up VDD_CX as GCC parent domain
  arm64: dts: qcom: sc8180x: Fix up big CPU idle state entry latency
  arm64: dts: qcom: sc8180x: Add missing CPU off state
  arm64: dts: qcom: sc8180x: Fix eDP PHY power-domains
  arm64: dts: qcom: sc8180x: Don't hold MDP core clock at FMAX
  arm64: dts: qcom: sc8180x: Require LOW_SVS vote for MMCX if DISPCC is
    on
  arm64: dts: qcom: sc8180x: Shrink aoss_qmp register space size
  arm64: dts: qcom: sm8450: Add missing interconnects to serial
  arm64: dts: qcom: sdm845: Use the Low Power Island CX/MX for SLPI
  clk: qcom: reset: Commonize the de/assert functions
  clk: qcom: reset: Ensure write completion on reset de/assertion
  clk: qcom: dispcc-sdm845: Adjust internal GDSC wait times

Konstantin Taranov (1):
  RDMA/mana_ib: Fix bug in creation of dma regions

Krzysztof Kozlowski (3):
  arm64: dts: qcom: sdm845-db845c: correct PCIe wake-gpios
  arm64: dts: qcom: sm8150: use 'gpios' suffix for PCI GPIOs
  arm64: dts: qcom: sm8150: correct PCIe wake-gpios

Kuniyuki Iwashima (3):
  af_unix: Annotate data-race of gc_in_progress in wait_for_unix_gc().
  rds: tcp: Fix use-after-free of net in reqsk_timer_handler().
  tcp: Fix refcnt handling in __inet_hash_connect().

Kunwu Chan (1):
  x86/xen: Add some null pointer checking to smp.c

Kévin L'hôpital (1):
  net: phy: fix phy_get_internal_delay accessing an empty array

Lad Prabhakar (2):
  arm64: dts: renesas: rzg2l: Add missing interrupts to IRQC nodes
  ASoC: sh: rz-ssi: Fix error message print

Leon Romanovsky (2):
  RDMA/mlx5: Fix fortify source warning while accessing Eth segment
  xfrm: Allow UDP encapsulation only in offload modes

Li Nan (1):
  md: Don't clear MD_CLOSING when the raid is about to stop

Linu Cherian (1):
  octeontx2-af: Use matching wake_up API variant in CGX command
    interface

Liu Ying (1):
  arm64: dts: imx8mp-evk: Fix hdmi@3d node

Luca Ceresoli (1):
  ASoC: rockchip: i2s-tdm: Fix inaccurate sampling rates

Luca Weiss (2):
  backlight: lm3630a: Initialize backlight_properties on init
  backlight: lm3630a: Don't set bl->props.brightness in get_brightness

Lucas Stach (1):
  media: imx: csc/scaler: fix v4l2_ctrl_handler memory leak

Luiz Augusto von Dentz (8):
  Bluetooth: Remove BT_HS
  Bluetooth: hci_event: Fix not indicating new connection for BIG Sync
  Bluetooth: hci_core: Cancel request on command timeout
  Bluetooth: hci_sync: Fix overwriting request callback
  Bluetooth: hci_core: Fix possible buffer overflow
  Bluetooth: msft: Fix memory leak
  Bluetooth: btusb: Fix memory leak
  Bluetooth: af_bluetooth: Fix deadlock

Luoyouming (1):
  RDMA/hns: Fix mis-modifying default congestion control algorithm

Maciej Strozek (2):
  mfd: cs42l43: Fix wrong register defaults
  mfd: cs42l43: Fix wrong GPIO_FN_SEL and SPI_CLK_CONFIG1 defaults

Manorit Chawdhry (2):
  arm64: dts: ti: k3-j721s2: Fix power domain for VTM node
  arm64: dts: ti: k3-j784s4: Fix power domain for VTM node

Manu Bretelle (1):
  selftests/bpf: Disable IPv6 for lwt_redirect test

Manuel Fombuena (1):
  HID: multitouch: Add required quirk for Synaptics 0xcddc device

Mao Jinlong (1):
  coresight: etm4x: Set skip_power_up in etm4_init_arch_data function

Marek Vasut (1):
  arm64: dts: imx8mp: Set SPI NOR to max 40 MHz on Data Modul i.MX8M
    Plus eDM SBC

Marijn Suijten (1):
  drm/msm/dpu: Only enable DSC_MODE_MULTIPLEX if dsc_merge is enabled

Mario Limonciello (2):
  iommu/amd: Mark interrupt as managed
  crypto: ccp - Avoid discarding errors in
    psp_send_platform_access_msg()

Mark Brown (2):
  regmap: kunit: Ensure that changed bytes are actually different
  arm64/sve: Lower the maximum allocation for the SVE ptrace regset

Mark Rutland (1):
  perf print-events: make is_event_supported() more robust

Markus Schneider-Pargmann (1):
  can: m_can: Start/Cancel polling timer together with interrupts

Martin KaFai Lau (2):
  selftests/bpf: Fix the flaky tc_redirect_dtime test
  selftests/bpf: Wait for the netstamp_needed_key static key to be
    turned on

Martin Kaiser (1):
  gpio: vf610: allow disabling the vf610 driver

Martin Kaistra (1):
  wifi: rtl8xxxu: add cancel_work_sync() for c2hcmd_work

Martin Krastev (1):
  drm/vmwgfx: Fix vmw_du_get_cursor_mob fencing of newly-created MOBs

Masahiro Yamada (1):
  kconfig: fix infinite loop when expanding a macro at the end of file

Matthew Wilcox (Oracle) (1):
  smb: do not test the return value of folio_start_writeback()

Matti Vaittinen (1):
  iio: gts-helper: Fix division loop

Max Kellermann (1):
  parisc/ftrace: add missing CONFIG_DYNAMIC_FTRACE check

Maxim Kudinov (1):
  ACPI: resource: Add MAIBENBEN X577 to irq1_edge_low_force_override

Maxime Ripard (1):
  drm/tests: helpers: Include missing drm_drv header

Mete Durlu (1):
  s390/vtime: fix average steal time calculation

Michael Ellerman (1):
  powerpc/embedded6xx: Fix no previous prototype for avr_uart_send()
    etc.

Michael Roth (1):
  x86/mm: Ensure input to pfn_to_kaddr() is treated as a 64-bit type

Michal Vokáč (2):
  ARM: dts: imx6dl-yapp4: Fix typo in the QCA switch register address
  ARM: dts: imx6dl-yapp4: Move the internal switch PHYs under the switch
    node

Mika Westerberg (1):
  spi: intel-pci: Add support for Lunar Lake-M SPI serial flash

Mike Yu (2):
  xfrm: fix xfrm child route lookup for packet offload
  xfrm: set skb control buffer based on packet offload as well

Mikhail Khvainitski (1):
  HID: lenovo: Add middleclick_workaround sysfs knob for cptkbd

Mikulas Patocka (4):
  dm-verity, dm-crypt: align "struct bvec_iter" correctly
  dm: call the resume method on internal suspend
  dm-integrity: fix a memory leak when rechecking the data
  dm-integrity: align the outgoing bio in integrity_recheck

Ming Lei (1):
  dm raid: fix false positive for requeue needed during reshape

Ming Yen Hsieh (1):
  wifi: mt76: mt792x: fix a potential loading failure of the 6Ghz
    channel config from ACPI

Miri Korenblit (3):
  wifi: iwlwifi: fix EWRD table validity check
  wifi: iwlwifi: read BIOS PNVM only for non-Intel SKU
  wifi: iwlwifi: support EHT for WH

Miroslav Franc (1):
  s390/dasd: fix double module refcount decrement

Muhammad Usama Anjum (1):
  io_uring/net: correct the type of variable

Mustafa Ismail (1):
  RDMA/irdma: Remove duplicate assignment

Naresh Solanki (1):
  regulator: max5970: Fix regulator child node name

Nathan Chancellor (1):
  s390/vdso: drop '-fPIC' from LDFLAGS

Navid Emamdoost (1):
  nbd: null check for nla_nest_start

Nicholas Piggin (1):
  powerpc/ps3: Fix lv1 hcall assembly for ELFv2 calling convention

Nikita Kiryushin (1):
  net: phy: fix phy_read_poll_timeout argument type in genphy_loopback

Nikita Zhandarovich (5):
  do_sys_name_to_handle(): use kzalloc() to fix kernel-infoleak
  media: em28xx: annotate unchecked call to media_device_register()
  drm/radeon/ni: Fix wrong firmware size logging in ni_init_microcode()
  drm/amd/display: fix NULL checks for adev->dm.dc in amdgpu_dm_fini()
  wireguard: receive: annotate data-race around
    receiving_counter.counter

Nishanth Menon (2):
  arm64: dts: ti: k3-am642-evm: Add boot phase tags marking
  arm64: dts: ti: k3-am642-sk: Add boot phase tags marking

Nícolas F. R. A. Prado (6):
  cpufreq: mediatek-hw: Wait for CPU supplies before probing
  cpufreq: mediatek-hw: Don't error out if supply is not found
  arm64: dts: mt8183: Move CrosEC base detection node to kukui-based DTs
  arm64: dts: mediatek: mt8192-asurada: Remove CrosEC base detection
    node
  arm64: dts: mediatek: mt8186: Add missing clocks to ssusb power
    domains
  arm64: dts: mediatek: mt8186: Add missing xhci clock to usb
    controllers

Olga Kornievskaia (1):
  NFSv4.1/pnfs: fix NFS with TLS in pnfs

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

Pavel Begunkov (1):
  io_uring: fix poll_remove stalled req completion

Peng Fan (1):
  thermal/drivers/qoriq: Fix getting tmu range

Perry Yuan (1):
  ACPI: CPPC: enable AMD CPPC V2 support for family 17h processors

Peter Chiu (1):
  wifi: mt76: mt7996: fix TWT issues

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
  ASoC: SOF: ipc4-pcm: Workaround for crashed firmware on system suspend

Petr Machata (1):
  selftests: forwarding: Add missing config entries

Petr Mladek (1):
  printk: Disable passing console lock owner completely during panic()

Petre Rodan (1):
  iio: pressure: mprls0025pa fix off-by-one enum

Prike Liang (1):
  drm/amdgpu: Enable gpu reset for S3 abort cases on Raven series

Przemek Kitszel (1):
  ice: fix stats being updated by way too large values

Puranjay Mohan (1):
  bpf: hardcode BPF_PROG_PACK_SIZE to 2MB * num_possible_nodes()

Qiheng Lin (1):
  powerpc/pseries: Fix potential memleak in papr_get_attr()

Quan Tian (1):
  netfilter: nf_tables: Fix a memory leak in nf_tables_updchain

Quanyang Wang (1):
  crypto: xilinx - call finalize with bh disabled

Quentin Schulz (2):
  drm/rockchip: lvds: do not overwrite error code
  drm/rockchip: lvds: do not print scary message when probing defer

Rafael J. Wysocki (1):
  ACPI: scan: Fix device check notification handling

Rafał Miłecki (9):
  arm64: dts: mediatek: mt7986: fix reference to PWM in fan node
  arm64: dts: mediatek: mt7986: drop crypto's unneeded/invalid clock
    name
  arm64: dts: mediatek: mt7986: fix SPI bus width properties
  arm64: dts: mediatek: mt7986: fix SPI nodename
  arm64: dts: mediatek: mt7986: drop "#clock-cells" from PWM
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

Raj Kumar Bhagat (1):
  wifi: ath12k: fix fetching MCBC flag for QCN9274

Randy Dunlap (3):
  drivers/ps3: select VIDEO to provide cmdline functions
  crypto: jitter - fix CRYPTO_JITTERENTROPY help text
  rtc: mt6397: select IRQ_DOMAIN instead of depending on it

Ranjan Kumar (1):
  scsi: mpt3sas: Prevent sending diag_reset when the controller is ready

Rob Herring (4):
  arm: dts: Fix dtc interrupt_provider warnings
  arm64: dts: Fix dtc interrupt_provider warnings
  arm: dts: Fix dtc interrupt_map warnings
  arm64: dts: qcom: Fix interrupt-map cell sizes

Sakari Ailus (1):
  media: ivsc: csi: Swap SINK and SOURCE pads

Sam Protsenko (1):
  clk: samsung: exynos850: Propagate SPI IPCLK rate change

Sam Ravnborg (1):
  sparc32: Fix section mismatch in leon_pci_grpci

Sami Tolvanen (1):
  riscv: Fix syscall wrapper for >word-size arguments

Sandipan Das (1):
  perf/x86/amd/core: Avoid register reset when CPU is dead

Sasha Levin (1):
  Linux 6.6.23-rc1

Saurabh Sengar (2):
  x86/hyperv: Allow 15-bit APIC IDs for VTL platforms
  x86/hyperv: Use per cpu initial stack for vtl context

Sean Anderson (1):
  usb: phy: generic: Get the vbus supply

Sebastian Reichel (1):
  arm64: dts: rockchip: mark system power controller on rk3588-evb1

Sheng Yong (1):
  f2fs: compress: fix to check unreleased compressed cluster

Shengjiu Wang (1):
  clk: imx: imx8mp: Fix SAI_MCLK_SEL definition

Shifeng Li (1):
  RDMA/device: Fix a race between mad_client and cm_client init

Shigeru Yoshida (1):
  hsr: Fix uninit-value access in hsr_get_node()

Shiming Cheng (1):
  ipv6: fib6_rules: flush route cache when rule is changed

Sibi Sankar (1):
  cpufreq: Fix per-policy boost behavior on SoCs using
    cpufreq_boost_set_sw()

Srinivasan Shanmugam (5):
  drm/amd/display: Fix a potential buffer overflow in
    'dp_dsc_clock_en_read()'
  drm/amd/display: Fix potential NULL pointer dereferences in
    'dcn10_set_output_transfer_func()'
  drm/amdgpu: Fix potential out-of-bounds access in
    'amdgpu_discovery_reg_base_init()'
  drm/amd/display: Add 'replay' NULL check in
    'edp_set_replay_allow_active()'
  drm/amdgpu: Fix missing break in ATOM_ARG_IMM Case of
    atom_get_src_int()

Sriram R (1):
  wifi: ath12k: Fix issues in channel list update

StanleyYP Wang (1):
  wifi: mt76: mt7996: fix efuse reading issue

Stephen Boyd (2):
  gpiolib: Pass consumer device through to core in
    devm_fwnode_gpiod_get_index()
  arm64: ftrace: Don't forbid CALL_OPS+CC_OPTIMIZE_FOR_SIZE with Clang

Steve Sistare (1):
  vdpa_sim: reset must not run

Stuart Henderson (3):
  ASoC: wm8962: Enable oscillator if selecting WM8962_FLL_OSC
  ASoC: wm8962: Enable both SPKOUTR_ENA and SPKOUTL_ENA in mono mode
  ASoC: wm8962: Fix up incorrect error message in wm8962_set_fll

Subbaraya Sundeep (5):
  octeontx2: Detect the mbox up or down message via register
  octeontx2-pf: Wait till detach_resources msg is complete
  octeontx2-pf: Use default max_active works instead of one
  octeontx2-pf: Send UP messages to VF only when VF is up.
  octeontx2-af: Use separate handlers for interrupts

Takashi Iwai (1):
  ALSA: seq: fix function cast warnings

Takashi Sakamoto (1):
  firewire: core: use long bus reset on gap count error

Tejun Heo (9):
  workqueue: Move pwq->max_active to wq->max_active
  workqueue: Factor out pwq_is_empty()
  workqueue: Replace pwq_activate_inactive_work() with
    [__]pwq_activate_work()
  workqueue: Move nr_active handling into helpers
  workqueue: Make wq_adjust_max_active() round-robin pwqs while
    activating
  workqueue: RCU protect wq->dfl_pwq and implement accessors for it
  workqueue: Introduce struct wq_node_nr_active
  workqueue: Implement system-wide nr_active enforcement for unbound
    workqueues
  workqueue: Don't call cpumask_test_cpu() with -1 CPU in
    wq_update_node_max_active()

Thierry Reding (1):
  arm64: tegra: Set the correct PHY mode for MGBE

Thinh Tran (1):
  net/bnx2x: Prevent access to a freed page in page_pool

Thomas Richter (1):
  s390/pai: fix attr_event_free upper limit for pai device drivers

Thomas Zimmermann (1):
  arch/powerpc: Remove <linux/fb.h> from backlight code

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

Toke Høiland-Jørgensen (5):
  wifi: ath9k: delay all of ath9k_wmi_event_tasklet() until init is
    complete
  libbpf: Use OPTS_SET() macro in bpf_xdp_query()
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

Unnathi Chalicheemala (1):
  soc: qcom: llcc: Check return value on Broadcast_OR reg read

Uwe Kleine-König (5):
  ARM: dts: rockchip: Drop interrupts property from pwm-rockchip nodes
  Input: gpio_keys_polled - suppress deferred probe error for gpio
  pwm: atmel-hlcdc: Fix clock imbalance related to suspend support
  pwm: sti: Fix capture for st,pwm-num-chan < st,capture-num-chan
  ASoC: tlv320adc3xxx: Don't strip remove function when driver is
    builtin

Viktor Malik (2):
  tools/resolve_btfids: Refactor set sorting with types from btf_ids.h
  tools/resolve_btfids: Fix cross-compilation to non-host endianness

Vinicius Costa Gomes (2):
  igc: Fix missing time sync events
  igb: Fix missing time sync events

Viresh Kumar (1):
  OPP: debugfs: Fix warning around icc_get_name()

Wang Jianjian (1):
  quota: Fix potential NULL pointer dereference

Wen Gong (1):
  wifi: ath11k: change to move WMI_VDEV_PARAM_SET_HEMU_MODE before
    WMI_PEER_ASSOC_CMDID

Wenjie Qi (1):
  f2fs: fix NULL pointer dereference in f2fs_submit_page_write()

William Kucharski (1):
  RDMA/srpt: Do not register event handler until srpt device is fully
    setup

William Tu (1):
  vmxnet3: Fix missing reserved tailroom

Xingyuan Mo (1):
  wifi: ath10k: fix NULL pointer dereference in
    ath10k_wmi_tlv_op_pull_mgmt_tx_compl_ev()

Xiubo Li (1):
  ceph: stop copying to iter at EOF on sync reads

Xiuhong Wang (2):
  f2fs: compress: relocate some judgments in
    f2fs_reserve_compress_blocks
  f2fs: compress: fix reserve_cblocks counting error when out of space

Xuan Zhuo (1):
  virtio: packed: fix unmap leak for indirect desc table

Yan Zhai (3):
  rcu: add a helper to report consolidated flavor QS
  net: report RCU QS on threaded NAPI repolling
  bpf: report RCU QS in cpumap kthread

Yang Jihong (5):
  perf record: Fix possible incorrect free in record__switch_output()
  perf record: Check conflict between '--timestamp-filename' option and
    pipe mode before recording
  perf evsel: Fix duplicate initialization of data->id in
    evsel__parse_sample()
  perf thread_map: Free strlist on normal path in
    thread_map__new_by_tid_str()
  hwtracing: hisi_ptt: Move type check to the beginning of
    hisi_ptt_pmu_event_init()

Yang Yingliang (1):
  NTB: fix possible name leak in ntb_register_device()

Yewon Choi (1):
  rds: introduce acquire/release ordering in acquire/release_in_xmit()

Yishai Hadas (1):
  RDMA/mlx5: Relax DEVX access upon modify commands

Yonghong Song (1):
  bpf: Mark bpf_spin_{lock,unlock}() helpers with notrace correctly

Yonglong Liu (1):
  net: hns3: fix kernel crash when 1588 is received on HIP08 devices

Yuxuan Hu (1):
  Bluetooth: rfcomm: Fix null-ptr-deref in rfcomm_check_security

Zhang Shurong (1):
  drm/tegra: dpaux: Fix PM disable depth imbalance in tegra_dpaux_probe

Zhipeng Lu (10):
  wifi: libertas: fix some memleaks in lbs_allocate_cmd_buffer()
  SUNRPC: fix a memleak in gss_import_v2_context
  SUNRPC: fix some memleaks in gssx_dec_option_array
  drm/vmwgfx: fix a memleak in vmw_gmrid_man_get_node
  drm/lima: fix a memleak in lima_heap_alloc
  media: v4l2-tpg: fix some memleaks in tpg_alloc
  media: v4l2-mem2mem: fix a memleak in v4l2_m2m_register_entity
  media: edia: dvbdev: fix a use-after-free
  media: go7007: fix a memleak in go7007_load_encoder
  media: ttpci: fix two memleaks in budget_av_attach

 .../testing/sysfs-bus-pci-devices-aer_stats   |    6 +-
 .../bindings/display/msm/qcom,mdss.yaml       |    1 +
 Documentation/filesystems/overlayfs.rst       |   17 +-
 Makefile                                      |    4 +-
 arch/arm/boot/dts/amazon/alpine.dtsi          |    1 -
 arch/arm/boot/dts/arm/arm-realview-pb1176.dts |    2 +-
 arch/arm/boot/dts/aspeed/aspeed-g4.dtsi       |   14 -
 arch/arm/boot/dts/aspeed/aspeed-g5.dtsi       |   15 +-
 arch/arm/boot/dts/aspeed/aspeed-g6.dtsi       |   18 +-
 arch/arm/boot/dts/broadcom/bcm-cygnus.dtsi    |    3 +
 arch/arm/boot/dts/broadcom/bcm-hr2.dtsi       |    1 +
 arch/arm/boot/dts/broadcom/bcm-nsp.dtsi       |    2 +
 .../intel/ixp/intel-ixp42x-gateway-7001.dts   |    2 +
 .../ixp/intel-ixp42x-goramo-multilink.dts     |    2 +
 arch/arm/boot/dts/marvell/kirkwood-l-50.dts   |    2 +
 .../arm/boot/dts/nuvoton/nuvoton-wpcm450.dtsi |    2 +
 .../boot/dts/nvidia/tegra30-apalis-v1.1.dtsi  |    1 -
 arch/arm/boot/dts/nvidia/tegra30-apalis.dtsi  |    1 -
 arch/arm/boot/dts/nvidia/tegra30-colibri.dtsi |    1 -
 .../boot/dts/nxp/imx/imx6dl-yapp4-common.dtsi |   25 +-
 arch/arm/boot/dts/nxp/imx/imx6q-b850v3.dts    |    3 -
 arch/arm/boot/dts/nxp/imx/imx6q-bx50v3.dtsi   |    2 +-
 arch/arm/boot/dts/nxp/imx/imx6qdl-apalis.dtsi |    1 -
 .../arm/boot/dts/nxp/imx/imx6qdl-colibri.dtsi |    1 -
 arch/arm/boot/dts/nxp/imx/imx6qdl-emcon.dtsi  |    1 -
 .../dts/nxp/imx/imx6qdl-phytec-pfla02.dtsi    |    1 +
 .../nxp/imx/imx6qdl-phytec-phycore-som.dtsi   |    1 +
 .../arm/boot/dts/nxp/imx/imx7d-pico-dwarf.dts |    1 +
 .../boot/dts/nxp/vf/vf610-zii-dev-rev-b.dts   |    1 +
 arch/arm/boot/dts/qcom/qcom-msm8974.dtsi      |    2 +-
 arch/arm/boot/dts/qcom/qcom-sdx55.dtsi        |    8 +-
 arch/arm/boot/dts/renesas/r8a73a4-ape6evm.dts |   12 +
 arch/arm/boot/dts/renesas/r8a73a4.dtsi        |    9 +-
 arch/arm/boot/dts/renesas/r8a7790-lager.dts   |    1 +
 arch/arm/boot/dts/renesas/r8a7790-stout.dts   |    1 +
 arch/arm/boot/dts/renesas/r8a7791-koelsch.dts |    1 +
 arch/arm/boot/dts/renesas/r8a7791-porter.dts  |    1 +
 arch/arm/boot/dts/renesas/r8a7792-blanche.dts |    1 +
 arch/arm/boot/dts/renesas/r8a7793-gose.dts    |    1 +
 arch/arm/boot/dts/renesas/r8a7794-alt.dts     |    1 +
 arch/arm/boot/dts/renesas/r8a7794-silk.dts    |    1 +
 arch/arm/boot/dts/rockchip/rv1108.dtsi        |    8 -
 arch/arm/boot/dts/st/stm32429i-eval.dts       |    1 -
 arch/arm/boot/dts/st/stm32mp157c-dk2.dts      |    1 -
 .../boot/dts/ti/omap/am5729-beagleboneai.dts  |    1 -
 arch/arm/crypto/sha256_glue.c                 |   13 +-
 arch/arm/crypto/sha512-glue.c                 |   12 +-
 arch/arm64/Kconfig                            |    2 +-
 .../dts/allwinner/sun50i-h6-beelink-gs1.dts   |    2 +
 .../boot/dts/allwinner/sun50i-h6-tanix.dtsi   |    2 +
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi  |    7 +-
 arch/arm64/boot/dts/amazon/alpine-v2.dtsi     |    1 -
 arch/arm64/boot/dts/amazon/alpine-v3.dtsi     |    1 -
 .../boot/dts/broadcom/bcmbca/bcm4908.dtsi     |    3 -
 .../boot/dts/broadcom/northstar2/ns2.dtsi     |    1 +
 .../boot/dts/broadcom/stingray/stingray.dtsi  |    1 +
 .../dts/freescale/imx8mm-kontron-bl-osm-s.dts |   38 +-
 .../boot/dts/freescale/imx8mm-kontron-bl.dts  |   38 +-
 .../dts/freescale/imx8mm-kontron-osm-s.dtsi   |    6 +-
 .../boot/dts/freescale/imx8mm-kontron-sl.dtsi |    4 +-
 .../dts/freescale/imx8mm-venice-gw71xx.dtsi   |   29 +-
 .../freescale/imx8mp-data-modul-edm-sbc.dts   |    2 +-
 arch/arm64/boot/dts/freescale/imx8mp-evk.dts  |   33 +-
 arch/arm64/boot/dts/lg/lg1312.dtsi            |    1 -
 arch/arm64/boot/dts/lg/lg1313.dtsi            |    1 -
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi  |   10 +-
 arch/arm64/boot/dts/marvell/armada-ap80x.dtsi |    1 -
 arch/arm64/boot/dts/marvell/armada-cp11x.dtsi |   10 +-
 .../dts/mediatek/mt7622-bananapi-bpi-r64.dts  |    1 +
 arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts  |    1 +
 .../dts/mediatek/mt7986a-bananapi-bpi-r3.dts  |    2 +-
 arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts  |    7 +-
 arch/arm64/boot/dts/mediatek/mt7986a.dtsi     |    3 +-
 arch/arm64/boot/dts/mediatek/mt7986b-rfb.dts  |    7 +-
 .../dts/mediatek/mt8183-kukui-kakadu.dtsi     |    4 +
 .../dts/mediatek/mt8183-kukui-kodama.dtsi     |    4 +
 .../boot/dts/mediatek/mt8183-kukui-krane.dtsi |    4 +
 .../arm64/boot/dts/mediatek/mt8183-kukui.dtsi |    4 -
 arch/arm64/boot/dts/mediatek/mt8186.dtsi      |   18 +-
 .../boot/dts/mediatek/mt8192-asurada.dtsi     |    4 -
 arch/arm64/boot/dts/mediatek/mt8192.dtsi      |    2 +-
 .../dts/mediatek/mt8195-cherry-tomato-r1.dts  |    4 +
 .../dts/mediatek/mt8195-cherry-tomato-r2.dts  |    4 +
 .../dts/mediatek/mt8195-cherry-tomato-r3.dts  |    4 +
 arch/arm64/boot/dts/mediatek/mt8195-demo.dts  |    1 +
 .../nvidia/tegra234-p3737-0000+p3701-0000.dts |    2 +-
 arch/arm64/boot/dts/qcom/ipq6018.dtsi         |    8 +-
 arch/arm64/boot/dts/qcom/ipq8074.dtsi         |   16 +-
 arch/arm64/boot/dts/qcom/msm8998.dtsi         |   42 +-
 arch/arm64/boot/dts/qcom/qcm2290.dtsi         |    7 +
 arch/arm64/boot/dts/qcom/sa8540p.dtsi         |    3 +
 arch/arm64/boot/dts/qcom/sc8180x.dtsi         |   26 +-
 arch/arm64/boot/dts/qcom/sdm845-db845c.dts    |    2 +-
 .../boot/dts/qcom/sdm845-oneplus-common.dtsi  |    8 +-
 arch/arm64/boot/dts/qcom/sdm845.dtsi          |    4 +-
 arch/arm64/boot/dts/qcom/sm6115.dtsi          |    7 +
 arch/arm64/boot/dts/qcom/sm8150.dtsi          |    6 +-
 arch/arm64/boot/dts/qcom/sm8450.dtsi          |   12 +
 arch/arm64/boot/dts/qcom/sm8550.dtsi          |    2 +-
 arch/arm64/boot/dts/renesas/r8a779a0.dtsi     |    4 +-
 arch/arm64/boot/dts/renesas/r8a779g0.dtsi     |   88 +-
 arch/arm64/boot/dts/renesas/r9a07g043u.dtsi   |   12 +-
 arch/arm64/boot/dts/renesas/r9a07g044.dtsi    |   22 +-
 arch/arm64/boot/dts/renesas/r9a07g054.dtsi    |   22 +-
 arch/arm64/boot/dts/renesas/ulcb-kf.dtsi      |    4 +
 arch/arm64/boot/dts/rockchip/rk356x.dtsi      |    3 +-
 .../boot/dts/rockchip/rk3588-evb1-v10.dts     |    1 +
 arch/arm64/boot/dts/rockchip/rk3588s.dtsi     |    2 -
 arch/arm64/boot/dts/ti/k3-am62-main.dtsi      |    9 +-
 arch/arm64/boot/dts/ti/k3-am62p.dtsi          |    2 +-
 arch/arm64/boot/dts/ti/k3-am64-main.dtsi      |   11 +-
 .../boot/dts/ti/k3-am64-phycore-som.dtsi      |    1 +
 arch/arm64/boot/dts/ti/k3-am642-evm.dts       |   34 +-
 .../dts/ti/k3-am642-phyboard-electra-rdk.dts  |    1 +
 arch/arm64/boot/dts/ti/k3-am642-sk.dts        |   33 +-
 .../dts/ti/k3-am642-tqma64xxl-mbax4xxl.dts    |    1 -
 .../arm64/boot/dts/ti/k3-am642-tqma64xxl.dtsi |    1 +
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi      |    5 +-
 .../dts/ti/k3-j7200-common-proc-board.dts     |   18 +-
 .../dts/ti/k3-j721s2-common-proc-board.dts    |    2 -
 .../boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi     |    2 +-
 arch/arm64/boot/dts/ti/k3-j784s4-evm.dts      |    2 -
 .../boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi     |    2 +-
 arch/arm64/include/asm/fpsimd.h               |   12 +-
 arch/arm64/kernel/ptrace.c                    |    3 +-
 arch/mips/include/asm/ptrace.h                |    1 +
 arch/parisc/kernel/ftrace.c                   |    2 +-
 arch/powerpc/include/asm/backlight.h          |    5 +-
 arch/powerpc/include/asm/ppc_asm.h            |    6 +-
 arch/powerpc/include/asm/vmalloc.h            |    4 +-
 arch/powerpc/perf/hv-gpci.c                   |   29 +-
 .../platforms/embedded6xx/linkstation.c       |    3 -
 arch/powerpc/platforms/embedded6xx/mpc10x.h   |    3 +
 arch/powerpc/platforms/powermac/backlight.c   |   26 -
 arch/powerpc/platforms/ps3/Kconfig            |    1 +
 arch/powerpc/platforms/ps3/hvcall.S           |   18 +-
 .../pseries/papr_platform_attributes.c        |    8 +-
 .../boot/dts/sifive/hifive-unmatched-a00.dts  |    1 +
 arch/riscv/include/asm/pgtable.h              |    2 +
 arch/riscv/include/asm/syscall_wrapper.h      |   53 +-
 arch/s390/kernel/cache.c                      |    1 +
 arch/s390/kernel/perf_pai_crypto.c            |    2 +-
 arch/s390/kernel/perf_pai_ext.c               |    2 +-
 arch/s390/kernel/vdso32/Makefile              |    2 +-
 arch/s390/kernel/vdso64/Makefile              |    2 +-
 arch/s390/kernel/vtime.c                      |    4 +-
 arch/sparc/kernel/leon_pci_grpci1.c           |    2 +-
 arch/sparc/kernel/leon_pci_grpci2.c           |    2 +-
 arch/x86/events/amd/core.c                    |    1 -
 arch/x86/hyperv/hv_vtl.c                      |   26 +-
 arch/x86/include/asm/page.h                   |    6 +-
 arch/x86/include/asm/vsyscall.h               |   10 +
 arch/x86/kernel/acpi/cppc.c                   |    2 +-
 arch/x86/kernel/cpu/resctrl/core.c            |   10 +-
 arch/x86/kernel/cpu/resctrl/internal.h        |    8 +-
 arch/x86/kernel/cpu/resctrl/monitor.c         |   48 +-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c        |   14 +-
 arch/x86/mm/fault.c                           |    9 -
 arch/x86/mm/maccess.c                         |   10 +
 arch/x86/mm/mem_encrypt_identity.c            |   10 +-
 arch/x86/tools/relocs.c                       |    8 +
 arch/x86/xen/smp.c                            |   12 +
 block/bdev.c                                  |   48 +
 block/opal_proto.h                            |    1 +
 block/sed-opal.c                              |    6 +-
 crypto/Kconfig                                |    5 +-
 drivers/acpi/processor_idle.c                 |    2 +
 drivers/acpi/resource.c                       |   33 +
 drivers/acpi/scan.c                           |    8 +-
 drivers/base/regmap/regmap-kunit.c            |   54 +-
 drivers/block/aoe/aoecmd.c                    |   12 +-
 drivers/block/aoe/aoenet.c                    |    1 +
 drivers/block/nbd.c                           |    6 +
 drivers/bluetooth/btmtk.c                     |    4 +-
 drivers/bluetooth/btusb.c                     |   10 +-
 drivers/bluetooth/hci_h5.c                    |    5 +-
 drivers/bluetooth/hci_qca.c                   |    6 +-
 drivers/bluetooth/hci_serdev.c                |    9 +-
 drivers/bluetooth/hci_uart.h                  |   12 +-
 drivers/bus/Kconfig                           |    5 +-
 drivers/bus/mhi/ep/main.c                     |    2 +-
 drivers/clk/clk.c                             |    3 +
 drivers/clk/hisilicon/clk-hi3519.c            |    2 +-
 drivers/clk/hisilicon/clk-hi3559a.c           |    1 -
 drivers/clk/imx/clk-imx8mp-audiomix.c         |   11 +-
 drivers/clk/mediatek/clk-mt7622-apmixedsys.c  |    1 -
 drivers/clk/mediatek/clk-mt7981-topckgen.c    |    5 +-
 drivers/clk/mediatek/clk-mt8135-apmixedsys.c  |    4 +-
 drivers/clk/mediatek/clk-mt8183.c             |    2 +-
 drivers/clk/meson/axg.c                       |    2 +
 drivers/clk/qcom/dispcc-sdm845.c              |    2 +
 drivers/clk/qcom/gcc-ipq5018.c                |    6 +-
 drivers/clk/qcom/reset.c                      |   27 +-
 drivers/clk/renesas/r8a779f0-cpg-mssr.c       |    2 +-
 drivers/clk/renesas/r8a779g0-cpg-mssr.c       |   11 +-
 drivers/clk/samsung/clk-exynos850.c           |   33 +-
 drivers/clk/zynq/clkc.c                       |    8 +-
 drivers/comedi/drivers/comedi_test.c          |   30 +-
 drivers/cpufreq/Kconfig.arm                   |    1 +
 drivers/cpufreq/brcmstb-avs-cpufreq.c         |    2 +
 drivers/cpufreq/cpufreq.c                     |   18 +-
 drivers/cpufreq/freq_table.c                  |    2 +-
 drivers/cpufreq/mediatek-cpufreq-hw.c         |   19 +-
 drivers/crypto/ccp/platform-access.c          |   11 +-
 .../intel/qat/qat_4xxx/adf_4xxx_hw_data.c     |   39 +-
 drivers/crypto/intel/qat/qat_common/Makefile  |    1 +
 .../intel/qat/qat_common/adf_cfg_services.c   |   47 +
 .../intel/qat/qat_common/adf_cfg_services.h   |   18 +-
 .../crypto/intel/qat/qat_common/adf_clock.c   |    3 +
 drivers/crypto/xilinx/zynqmp-aes-gcm.c        |    3 +
 drivers/cxl/core/region.c                     |   62 +-
 drivers/dma/Kconfig                           |   14 +-
 drivers/firewire/core-card.c                  |   14 +-
 drivers/firmware/arm_scmi/smc.c               |    7 +
 drivers/firmware/efi/libstub/x86-stub.c       |    7 +-
 drivers/gpio/Kconfig                          |    3 +-
 drivers/gpio/gpiolib-devres.c                 |    2 +-
 drivers/gpio/gpiolib.c                        |   14 +-
 drivers/gpio/gpiolib.h                        |    8 +
 drivers/gpu/drm/Kconfig                       |    5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |    6 +-
 drivers/gpu/drm/amd/amdgpu/atom.c             |    2 +-
 drivers/gpu/drm/amd/amdgpu/soc15.c            |   45 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   16 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c |    2 +-
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c |    7 +-
 .../link/protocols/link_edp_panel_control.c   |    3 +-
 .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c |    4 +-
 .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    |    4 +-
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  |    4 +-
 drivers/gpu/drm/ci/test.yml                   |    5 +-
 drivers/gpu/drm/lima/lima_gem.c               |   23 +-
 drivers/gpu/drm/mediatek/mtk_drm_crtc.c       |   12 +-
 drivers/gpu/drm/mediatek/mtk_dsi.c            |   10 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c   |   11 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h   |    7 +
 .../drm/msm/disp/dpu1/dpu_encoder_phys_vid.c  |    7 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c   |   15 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h   |    1 +
 drivers/gpu/drm/nouveau/nouveau_bo.c          |    2 +
 .../gpu/drm/panel/panel-boe-tv101wum-nl6.c    |    2 +
 drivers/gpu/drm/panel/panel-edp.c             |    3 +-
 drivers/gpu/drm/radeon/ni.c                   |    2 +-
 drivers/gpu/drm/rockchip/inno_hdmi.c          |    4 +-
 drivers/gpu/drm/rockchip/rockchip_lvds.c      |    3 +-
 drivers/gpu/drm/tegra/dpaux.c                 |   14 +-
 drivers/gpu/drm/tegra/dsi.c                   |   59 +-
 drivers/gpu/drm/tegra/fb.c                    |    1 +
 drivers/gpu/drm/tegra/hdmi.c                  |   20 +-
 drivers/gpu/drm/tegra/output.c                |   16 +-
 drivers/gpu/drm/tegra/rgb.c                   |   18 +-
 drivers/gpu/drm/tidss/tidss_crtc.c            |   10 +
 drivers/gpu/drm/tidss/tidss_plane.c           |    2 +-
 drivers/gpu/drm/vkms/vkms_composer.c          |   14 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_gmrid_manager.c |    5 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c           |   11 +-
 drivers/hid/amd-sfh-hid/amd_sfh_pcie.c        |   30 +-
 drivers/hid/amd-sfh-hid/amd_sfh_pcie.h        |    6 +-
 drivers/hid/hid-lenovo.c                      |   57 +-
 drivers/hid/hid-multitouch.c                  |    4 +
 drivers/hv/Kconfig                            |    1 +
 drivers/hwtracing/coresight/coresight-core.c  |   30 +-
 .../hwtracing/coresight/coresight-etm-perf.c  |    2 +-
 .../coresight/coresight-etm4x-core.c          |   10 +-
 drivers/hwtracing/coresight/coresight-priv.h  |    2 +-
 drivers/hwtracing/ptt/hisi_ptt.c              |    6 +-
 drivers/i3c/master/dw-i3c-master.c            |    4 +-
 drivers/iio/industrialio-gts-helper.c         |   15 +-
 drivers/iio/pressure/mprls0025pa.c            |    4 +-
 drivers/infiniband/core/device.c              |   37 +-
 drivers/infiniband/hw/hns/hns_roce_device.h   |   17 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c    |   16 +-
 drivers/infiniband/hw/irdma/verbs.c           |    3 +-
 drivers/infiniband/hw/mana/main.c             |    2 +-
 drivers/infiniband/hw/mlx5/devx.c             |    2 +-
 drivers/infiniband/hw/mlx5/wr.c               |    2 +-
 drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c  |    2 +-
 drivers/infiniband/ulp/srpt/ib_srpt.c         |    3 +-
 drivers/input/keyboard/gpio_keys_polled.c     |   10 +-
 drivers/input/misc/iqs7222.c                  |  112 ++
 drivers/iommu/Kconfig                         |    2 +-
 drivers/iommu/amd/init.c                      |    3 +
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   |    8 +-
 drivers/iommu/intel/Makefile                  |    2 +
 drivers/iommu/intel/pasid.c                   |    3 +
 drivers/iommu/irq_remapping.c                 |    3 +-
 drivers/leds/flash/leds-sgm3140.c             |    3 +
 drivers/leds/leds-aw2013.c                    |    1 +
 drivers/md/dm-bufio.c                         |    6 +-
 drivers/md/dm-crypt.c                         |    4 +-
 drivers/md/dm-integrity.c                     |   30 +-
 drivers/md/dm-io.c                            |   23 +-
 drivers/md/dm-kcopyd.c                        |    4 +-
 drivers/md/dm-log.c                           |    4 +-
 drivers/md/dm-raid.c                          |    4 +-
 drivers/md/dm-raid1.c                         |    6 +-
 drivers/md/dm-snap-persistent.c               |    4 +-
 drivers/md/dm-verity-target.c                 |    2 +-
 drivers/md/dm-verity.h                        |    4 +-
 drivers/md/dm-writecache.c                    |    8 +-
 drivers/md/dm.c                               |   26 +-
 drivers/md/md.c                               |   14 +-
 drivers/media/common/v4l2-tpg/v4l2-tpg-core.c |   52 +-
 drivers/media/dvb-core/dvbdev.c               |    5 +
 drivers/media/dvb-frontends/stv0367.c         |   34 +-
 drivers/media/i2c/imx290.c                    |   16 +-
 drivers/media/i2c/tc358743.c                  |    7 +-
 drivers/media/pci/intel/ivsc/mei_csi.c        |    4 +-
 drivers/media/pci/ttpci/budget-av.c           |    8 +-
 drivers/media/platform/cadence/cdns-csi2rx.c  |    2 +-
 .../media/platform/mediatek/mdp/mtk_mdp_vpu.c |    2 +-
 .../vcodec/common/mtk_vcodec_fw_vpu.c         |   10 +-
 drivers/media/platform/mediatek/vpu/mtk_vpu.c |    2 +-
 drivers/media/platform/mediatek/vpu/mtk_vpu.h |    2 +-
 .../platform/rockchip/rkisp1/rkisp1-capture.c |    3 +
 .../platform/rockchip/rkisp1/rkisp1-common.h  |    2 +
 .../platform/rockchip/rkisp1/rkisp1-csi.c     |    3 +
 .../platform/rockchip/rkisp1/rkisp1-dev.c     |   22 +
 .../platform/rockchip/rkisp1/rkisp1-isp.c     |    3 +
 .../media/platform/sunxi/sun8i-di/sun8i-di.c  |   69 +-
 drivers/media/usb/em28xx/em28xx-cards.c       |    4 +
 drivers/media/usb/go7007/go7007-driver.c      |    8 +-
 drivers/media/usb/go7007/go7007-usb.c         |    4 +-
 drivers/media/usb/pvrusb2/pvrusb2-context.c   |   10 +-
 drivers/media/usb/pvrusb2/pvrusb2-dvb.c       |    6 +-
 drivers/media/usb/pvrusb2/pvrusb2-v4l2.c      |   11 +-
 drivers/media/v4l2-core/v4l2-cci.c            |    4 +-
 drivers/media/v4l2-core/v4l2-mem2mem.c        |   10 +-
 drivers/memory/tegra/tegra234.c               |   16 +-
 drivers/mfd/altera-sysmgr.c                   |    4 +-
 drivers/mfd/cs42l43.c                         |   72 +-
 drivers/mfd/syscon.c                          |    4 +-
 drivers/misc/mei/gsc_proxy/mei_gsc_proxy.c    |    8 +-
 drivers/mmc/host/wmt-sdmmc.c                  |    4 -
 drivers/mtd/maps/physmap-core.c               |    2 +-
 drivers/mtd/nand/raw/lpc32xx_mlc.c            |    5 +-
 drivers/mtd/nand/spi/esmt.c                   |    9 +-
 drivers/net/can/m_can/m_can.c                 |   23 +-
 drivers/net/dsa/mt7530.c                      |   60 +-
 drivers/net/dsa/mt7530.h                      |   22 +-
 drivers/net/ethernet/amazon/ena/ena_netdev.c  |   17 -
 .../net/ethernet/broadcom/bnx2x/bnx2x_cmn.h   |    6 +-
 .../net/ethernet/hisilicon/hns3/hns3_dcbnl.c  |    2 +-
 .../hisilicon/hns3/hns3pf/hclge_main.c        |    5 +-
 .../hisilicon/hns3/hns3pf/hclge_ptp.c         |    2 +-
 drivers/net/ethernet/intel/ice/ice_main.c     |   24 +-
 drivers/net/ethernet/intel/igb/igb_main.c     |   23 +-
 drivers/net/ethernet/intel/igc/igc_main.c     |   12 +-
 .../net/ethernet/marvell/octeontx2/af/cgx.c   |    2 +-
 .../net/ethernet/marvell/octeontx2/af/mbox.c  |   43 +-
 .../net/ethernet/marvell/octeontx2/af/mbox.h  |    6 +
 .../marvell/octeontx2/af/mcs_rvu_if.c         |   17 +-
 .../net/ethernet/marvell/octeontx2/af/rvu.c   |   31 +-
 .../net/ethernet/marvell/octeontx2/af/rvu.h   |    2 +
 .../ethernet/marvell/octeontx2/af/rvu_cgx.c   |   20 +-
 .../marvell/octeontx2/nic/otx2_common.c       |    2 +-
 .../marvell/octeontx2/nic/otx2_common.h       |    2 +-
 .../ethernet/marvell/octeontx2/nic/otx2_pf.c  |  119 +-
 .../ethernet/marvell/octeontx2/nic/otx2_vf.c  |   71 +-
 drivers/net/ethernet/mediatek/mtk_eth_soc.c   |    7 +-
 drivers/net/ethernet/mediatek/mtk_ppe.c       |   18 +-
 .../ethernet/netronome/nfp/flower/lag_conf.c  |    5 +
 .../net/ethernet/wangxun/txgbe/txgbe_phy.c    |    2 +-
 drivers/net/phy/dp83822.c                     |   37 +-
 drivers/net/phy/phy_device.c                  |    6 +-
 drivers/net/usb/smsc95xx.c                    |    5 +
 drivers/net/usb/sr9800.c                      |    4 +-
 drivers/net/veth.c                            |   18 -
 drivers/net/vmxnet3/vmxnet3_xdp.c             |    6 +-
 drivers/net/wireguard/receive.c               |    6 +-
 drivers/net/wireless/ath/ath10k/wmi-tlv.c     |    4 +
 drivers/net/wireless/ath/ath11k/mac.c         |   17 +-
 drivers/net/wireless/ath/ath12k/core.h        |    2 +-
 drivers/net/wireless/ath/ath12k/dbring.c      |    2 +-
 drivers/net/wireless/ath/ath12k/debug.c       |    2 +-
 drivers/net/wireless/ath/ath12k/dp_tx.c       |    2 +-
 drivers/net/wireless/ath/ath12k/hal.c         |    6 +-
 drivers/net/wireless/ath/ath12k/hal.h         |    2 +-
 drivers/net/wireless/ath/ath12k/hal_rx.c      |    2 +-
 drivers/net/wireless/ath/ath12k/hif.h         |    2 +-
 drivers/net/wireless/ath/ath12k/hw.c          |    2 +-
 drivers/net/wireless/ath/ath12k/hw.h          |    2 +-
 drivers/net/wireless/ath/ath12k/mac.c         |    6 +-
 drivers/net/wireless/ath/ath12k/mac.h         |    2 +-
 drivers/net/wireless/ath/ath12k/mhi.c         |    2 +-
 drivers/net/wireless/ath/ath12k/pci.c         |    2 +-
 drivers/net/wireless/ath/ath12k/pci.h         |    2 +-
 drivers/net/wireless/ath/ath12k/peer.h        |    2 +-
 drivers/net/wireless/ath/ath12k/qmi.c         |    2 +-
 drivers/net/wireless/ath/ath12k/qmi.h         |    2 +-
 drivers/net/wireless/ath/ath12k/reg.c         |    6 +-
 drivers/net/wireless/ath/ath12k/reg.h         |    2 +-
 drivers/net/wireless/ath/ath12k/rx_desc.h     |    2 +-
 drivers/net/wireless/ath/ath12k/wmi.c         |    2 +-
 drivers/net/wireless/ath/ath9k/htc.h          |    2 +-
 drivers/net/wireless/ath/ath9k/htc_drv_init.c |    4 +
 drivers/net/wireless/ath/ath9k/htc_drv_txrx.c |    4 -
 drivers/net/wireless/ath/ath9k/wmi.c          |   10 +-
 drivers/net/wireless/broadcom/b43/b43.h       |   16 +
 drivers/net/wireless/broadcom/b43/dma.c       |    4 +-
 drivers/net/wireless/broadcom/b43/main.c      |   16 +-
 drivers/net/wireless/broadcom/b43/pio.c       |    6 +-
 .../broadcom/brcm80211/brcmfmac/cfg80211.c    |    3 +
 .../broadcom/brcm80211/brcmsmac/phy/phy_cmn.c |    3 +-
 .../broadcom/brcm80211/brcmsmac/phy_shim.c    |    5 +-
 .../broadcom/brcm80211/brcmsmac/phy_shim.h    |    2 +-
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c  |   12 +-
 drivers/net/wireless/intel/iwlwifi/fw/acpi.h  |    2 +-
 drivers/net/wireless/intel/iwlwifi/fw/pnvm.c  |   30 +-
 .../net/wireless/intel/iwlwifi/iwl-dbg-tlv.c  |    6 +
 .../wireless/intel/iwlwifi/iwl-nvm-parse.c    |    2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c   |   12 +-
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |   25 +-
 .../net/wireless/intel/iwlwifi/mvm/mld-key.c  |   18 +-
 .../net/wireless/intel/iwlwifi/mvm/mld-mac.c  |    2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c |   26 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c   |   81 +-
 drivers/net/wireless/marvell/libertas/cmd.c   |   13 +-
 .../net/wireless/marvell/mwifiex/debugfs.c    |    3 -
 .../net/wireless/mediatek/mt76/mt7921/pci.c   |    1 +
 .../wireless/mediatek/mt76/mt792x_acpi_sar.c  |   26 +-
 .../net/wireless/mediatek/mt76/mt792x_core.c  |    1 +
 .../net/wireless/mediatek/mt76/mt792x_dma.c   |    2 +
 .../net/wireless/mediatek/mt76/mt7996/init.c  |    7 +-
 .../net/wireless/mediatek/mt76/mt7996/mac.c   |   53 +-
 .../net/wireless/mediatek/mt76/mt7996/mcu.c   |   18 +-
 .../wireless/mediatek/mt76/mt7996/mt7996.h    |    3 +-
 .../wireless/microchip/wilc1000/cfg80211.c    |   12 +-
 drivers/net/wireless/microchip/wilc1000/hif.c |   40 +-
 .../net/wireless/microchip/wilc1000/netdev.c  |   38 +-
 drivers/net/wireless/microchip/wilc1000/spi.c |    6 +-
 .../wireless/realtek/rtl8xxxu/rtl8xxxu_core.c |    1 +
 drivers/net/wireless/realtek/rtw88/main.c     |    2 -
 drivers/net/wireless/realtek/rtw88/phy.c      |    3 +
 drivers/net/wireless/realtek/rtw88/rtw8821c.c |    2 +-
 drivers/net/wireless/realtek/rtw88/usb.c      |   40 +
 drivers/net/wireless/silabs/wfx/sta.c         |   15 +-
 drivers/ntb/core.c                            |    8 +-
 drivers/nvme/host/core.c                      |    6 +-
 drivers/nvme/host/fabrics.h                   |    7 -
 drivers/opp/debugfs.c                         |    6 +-
 drivers/pci/controller/pcie-brcmstb.c         |    2 +-
 drivers/pci/endpoint/functions/pci-epf-vntb.c |    6 +-
 drivers/pci/p2pdma.c                          |    2 +-
 drivers/pci/pci.h                             |    5 -
 drivers/pci/pcie/dpc.c                        |    2 +-
 drivers/pci/quirks.c                          |    1 +
 drivers/pci/switch/switchtec.c                |    4 +-
 drivers/perf/arm-cmn.c                        |   11 +
 drivers/perf/cxl_pmu.c                        |   10 +-
 drivers/perf/riscv_pmu_sbi.c                  |    8 +-
 drivers/pinctrl/mediatek/pinctrl-mt8186.c     |    1 -
 drivers/pinctrl/mediatek/pinctrl-mt8192.c     |    1 -
 drivers/pinctrl/nomadik/pinctrl-nomadik.c     |    6 +-
 drivers/pinctrl/renesas/core.c                |    4 +-
 drivers/pinctrl/renesas/pfc-r8a779g0.c        |   14 +
 drivers/platform/x86/p2sb.c                   |   25 +-
 .../platform/x86/x86-android-tablets/other.c  |    4 +-
 drivers/pmdomain/qcom/rpmhpd.c                |    1 -
 drivers/powercap/dtpm_cpu.c                   |    2 +-
 drivers/pwm/pwm-atmel-hlcdc.c                 |    2 +-
 drivers/pwm/pwm-sti.c                         |   11 +-
 drivers/regulator/max5970-regulator.c         |    8 +-
 drivers/regulator/userspace-consumer.c        |    1 +
 drivers/remoteproc/stm32_rproc.c              |    6 +-
 drivers/rtc/Kconfig                           |    3 +-
 drivers/rtc/lib_test.c                        |    2 +-
 drivers/s390/block/dasd.c                     |   55 +-
 drivers/scsi/bfa/bfa.h                        |    9 +-
 drivers/scsi/bfa/bfa_core.c                   |    4 +-
 drivers/scsi/bfa/bfa_ioc.h                    |    8 +-
 drivers/scsi/bfa/bfad_bsg.c                   |   11 +-
 drivers/scsi/csiostor/csio_defs.h             |   18 +-
 drivers/scsi/csiostor/csio_lnode.c            |    8 +-
 drivers/scsi/csiostor/csio_lnode.h            |   13 -
 drivers/scsi/mpt3sas/mpt3sas_base.c           |    4 +-
 drivers/soc/fsl/dpio/dpio-service.c           |    2 +-
 drivers/soc/microchip/Kconfig                 |    2 +-
 drivers/soc/qcom/llcc-qcom.c                  |    2 +
 drivers/soc/qcom/pmic_glink_altmode.c         |   16 +-
 drivers/soc/qcom/socinfo.c                    |    2 +-
 drivers/spi/spi-fsl-lpspi.c                   |    8 +-
 drivers/spi/spi-imx.c                         |    4 +-
 drivers/spi/spi-intel-pci.c                   |    1 +
 drivers/spi/spi-mt65xx.c                      |   22 +-
 drivers/staging/greybus/light.c               |    8 +-
 .../staging/media/imx/imx-media-csc-scaler.c  |    1 +
 .../staging/media/sunxi/cedrus/cedrus_h265.c  |   10 +-
 drivers/thermal/mediatek/lvts_thermal.c       |    4 +-
 drivers/thermal/qoriq_thermal.c               |   12 +-
 drivers/tty/serial/8250/8250_exar.c           |    5 +-
 drivers/tty/serial/max310x.c                  |    2 +-
 drivers/tty/serial/samsung_tty.c              |    5 +-
 drivers/tty/vt/vt.c                           |    2 +-
 drivers/usb/gadget/udc/net2272.c              |    2 +-
 drivers/usb/phy/phy-generic.c                 |    7 +
 drivers/vdpa/mlx5/net/mlx5_vnet.c             |   13 +-
 drivers/vdpa/vdpa_sim/vdpa_sim.c              |    3 +-
 drivers/video/backlight/da9052_bl.c           |    1 +
 drivers/video/backlight/ktz8866.c             |    6 +-
 drivers/video/backlight/lm3630a_bl.c          |   15 +-
 drivers/video/backlight/lm3639_bl.c           |    1 +
 drivers/video/backlight/lp8788_bl.c           |    1 +
 drivers/virtio/virtio_ring.c                  |    6 +-
 drivers/watchdog/starfive-wdt.c               |    9 +-
 drivers/watchdog/stm32_iwdg.c                 |    3 +
 drivers/xen/events/events_base.c              |   22 +-
 drivers/xen/evtchn.c                          |    6 +
 fs/afs/dir.c                                  |   10 -
 fs/btrfs/block-rsv.c                          |    2 +-
 fs/btrfs/block-rsv.h                          |   32 +
 fs/btrfs/space-info.c                         |   26 +-
 fs/ceph/file.c                                |   23 +-
 fs/erofs/data.c                               |    4 +-
 fs/erofs/fscache.c                            |   20 +-
 fs/erofs/internal.h                           |    3 +-
 fs/erofs/super.c                              |   50 +-
 fs/ext2/ext2.h                                |    2 +-
 fs/ext2/super.c                               |    2 +-
 fs/ext4/ext4.h                                |    2 +-
 fs/ext4/super.c                               |    2 +-
 fs/f2fs/checkpoint.c                          |    5 +-
 fs/f2fs/compress.c                            |   43 +-
 fs/f2fs/data.c                                |   73 +-
 fs/f2fs/dir.c                                 |    5 +-
 fs/f2fs/f2fs.h                                |  109 +-
 fs/f2fs/file.c                                |   94 +-
 fs/f2fs/gc.c                                  |    7 +-
 fs/f2fs/inode.c                               |   57 +-
 fs/f2fs/namei.c                               |   25 +-
 fs/f2fs/node.c                                |   20 +-
 fs/f2fs/recovery.c                            |   33 +-
 fs/f2fs/segment.c                             |   25 +-
 fs/f2fs/segment.h                             |   17 +-
 fs/f2fs/super.c                               |   17 +-
 fs/fcntl.c                                    |   12 +-
 fs/fhandle.c                                  |    2 +-
 fs/iomap/buffered-io.c                        |   18 +-
 fs/jfs/jfs_incore.h                           |    2 +-
 fs/jfs/super.c                                |    2 +-
 fs/nfs/flexfilelayout/flexfilelayout.c        |    2 +-
 fs/nfs/fscache.c                              |    9 +-
 fs/nfs/nfs42.h                                |    7 +-
 fs/nfs/nfs4proc.c                             |   16 +-
 fs/nfs/nfsroot.c                              |    4 +-
 fs/nfs/pnfs_nfs.c                             |   44 +-
 fs/ocfs2/inode.h                              |    2 +-
 fs/ocfs2/super.c                              |    2 +-
 fs/overlayfs/params.c                         |  330 ++---
 fs/overlayfs/params.h                         |    1 +
 fs/overlayfs/super.c                          |    5 +-
 fs/pstore/inode.c                             |   76 +-
 fs/quota/dquot.c                              |  159 ++-
 fs/reiserfs/reiserfs.h                        |    2 +-
 fs/reiserfs/super.c                           |    2 +-
 fs/select.c                                   |    2 +-
 fs/smb/client/file.c                          |  295 +++--
 include/drm/drm_fixed.h                       |    5 +-
 include/drm/drm_kunit_helpers.h               |    2 +
 include/dt-bindings/clock/r8a779g0-cpg-mssr.h |    1 +
 include/linux/blkdev.h                        |   10 +
 include/linux/dm-io.h                         |    3 +-
 include/linux/f2fs_fs.h                       |    1 +
 include/linux/filter.h                        |   21 +-
 include/linux/fs.h                            |   11 +-
 include/linux/io_uring.h                      |   10 +-
 include/linux/io_uring_types.h                |    3 -
 include/linux/mlx5/qp.h                       |    5 +-
 include/linux/moduleloader.h                  |    8 +
 include/linux/pci.h                           |    5 +
 include/linux/poll.h                          |    4 -
 include/linux/rcupdate.h                      |   31 +
 include/linux/shmem_fs.h                      |    2 +-
 include/linux/workqueue.h                     |   35 +-
 include/net/bluetooth/hci.h                   |    2 -
 include/net/bluetooth/hci_core.h              |    1 +
 include/net/bluetooth/hci_sync.h              |    2 +-
 include/net/bluetooth/l2cap.h                 |   42 -
 include/soc/qcom/qcom-spmi-pmic.h             |    2 +-
 include/sound/tas2781.h                       |    5 +
 init/main.c                                   |    5 +-
 io_uring/filetable.c                          |   11 +-
 io_uring/io_uring.c                           |  161 +--
 io_uring/io_uring.h                           |    1 -
 io_uring/net.c                                |  260 ++--
 io_uring/poll.c                               |    4 +-
 io_uring/rsrc.c                               |  169 +--
 io_uring/rsrc.h                               |   15 -
 kernel/bpf/btf.c                              |    3 +
 kernel/bpf/core.c                             |    7 +-
 kernel/bpf/cpumap.c                           |    3 +
 kernel/bpf/devmap.c                           |   11 +-
 kernel/bpf/hashtab.c                          |   14 +-
 kernel/bpf/helpers.c                          |    4 +-
 kernel/bpf/stackmap.c                         |    9 +-
 kernel/module/main.c                          |    9 +-
 kernel/printk/printk.c                        |   29 +
 kernel/rcu/tree.c                             |    3 +
 kernel/rcu/tree_exp.h                         |   25 +-
 kernel/sched/fair.c                           |   16 +-
 kernel/time/time_test.c                       |    2 +-
 kernel/time/timekeeping.c                     |   24 +-
 kernel/workqueue.c                            |  755 ++++++++++--
 lib/cmdline_kunit.c                           |    2 +-
 lib/kunit/executor_test.c                     |    2 +-
 lib/memcpy_kunit.c                            |    4 +-
 lib/test_blackhole_dev.c                      |    3 +-
 mm/shmem.c                                    |    2 +-
 net/bluetooth/Kconfig                         |    8 -
 net/bluetooth/Makefile                        |    1 -
 net/bluetooth/a2mp.c                          | 1054 ----------------
 net/bluetooth/a2mp.h                          |  154 ---
 net/bluetooth/af_bluetooth.c                  |   10 +-
 net/bluetooth/amp.c                           |  590 ---------
 net/bluetooth/amp.h                           |   60 -
 net/bluetooth/eir.c                           |   29 +-
 net/bluetooth/hci_conn.c                      |    6 +-
 net/bluetooth/hci_core.c                      |  126 +-
 net/bluetooth/hci_event.c                     |   43 +-
 net/bluetooth/hci_request.c                   |    2 +-
 net/bluetooth/hci_sync.c                      |   41 +-
 net/bluetooth/l2cap_core.c                    | 1069 +----------------
 net/bluetooth/l2cap_sock.c                    |   18 +-
 net/bluetooth/mgmt.c                          |  101 +-
 net/bluetooth/msft.c                          |   23 +-
 net/bluetooth/rfcomm/core.c                   |    2 +-
 net/core/dev.c                                |    5 +-
 net/core/scm.c                                |    2 +-
 net/core/skbuff.c                             |    8 +
 net/core/sock_diag.c                          |   10 +-
 net/devlink/port.c                            |    2 +-
 net/hsr/hsr_framereg.c                        |    4 +
 net/hsr/hsr_main.c                            |   15 +-
 net/ipv4/inet_diag.c                          |    6 +-
 net/ipv4/inet_hashtables.c                    |    2 +-
 net/ipv4/inet_timewait_sock.c                 |   41 +-
 net/ipv4/ip_tunnel.c                          |   15 +-
 net/ipv4/ipmr.c                               |    4 +-
 net/ipv4/raw.c                                |    1 +
 net/ipv4/tcp.c                                |    4 +-
 net/ipv4/tcp_minisocks.c                      |    4 -
 net/ipv4/udp.c                                |    4 +-
 net/ipv6/fib6_rules.c                         |    6 +
 net/ipv6/mcast.c                              |    1 -
 net/iucv/iucv.c                               |    4 +-
 net/kcm/kcmsock.c                             |    3 +-
 net/l2tp/l2tp_ppp.c                           |    4 +-
 net/mac80211/rate.c                           |    3 +-
 net/mctp/route.c                              |    3 +
 net/netfilter/nf_tables_api.c                 |   29 +-
 net/netfilter/nft_set_pipapo.c                |    5 +-
 net/packet/af_packet.c                        |    4 +-
 net/rds/send.c                                |    5 +-
 net/sched/sch_taprio.c                        |    3 +-
 net/sunrpc/addr.c                             |    4 +-
 net/sunrpc/auth_gss/gss_krb5_mech.c           |   11 +-
 net/sunrpc/auth_gss/gss_rpc_xdr.c             |   27 +-
 net/unix/garbage.c                            |    2 +-
 net/unix/scm.c                                |    4 +-
 net/x25/af_x25.c                              |    4 +-
 net/xfrm/xfrm_device.c                        |    3 +-
 net/xfrm/xfrm_output.c                        |    6 +-
 net/xfrm/xfrm_policy.c                        |    4 +-
 scripts/clang-tools/gen_compile_commands.py   |    2 +-
 scripts/kconfig/lexer.l                       |    7 +-
 sound/core/seq/seq_midi.c                     |    8 +-
 sound/core/seq/seq_virmidi.c                  |    9 +-
 sound/pci/hda/patch_realtek.c                 |   64 +
 sound/pci/hda/tas2781_hda_i2c.c               |   62 +-
 sound/soc/amd/acp/acp-sof-mach.c              |   14 +-
 sound/soc/amd/yc/acp6x-mach.c                 |   28 +
 sound/soc/codecs/cs42l43.c                    |    5 +-
 sound/soc/codecs/rt5645.c                     |   10 +
 sound/soc/codecs/tas2781-comlib.c             |   15 +
 sound/soc/codecs/tlv320adc3xxx.c              |    4 +-
 sound/soc/codecs/wm8962.c                     |   29 +-
 sound/soc/intel/boards/bytcr_rt5640.c         |   12 +
 sound/soc/meson/aiu.c                         |   19 +-
 sound/soc/meson/aiu.h                         |    1 -
 sound/soc/meson/axg-tdm-interface.c           |   29 +-
 sound/soc/meson/t9015.c                       |   20 +-
 sound/soc/rockchip/rockchip_i2s_tdm.c         |  352 +-----
 sound/soc/sh/rz-ssi.c                         |    2 +-
 sound/soc/sof/amd/acp.c                       |   28 +-
 sound/soc/sof/ipc3-loader.c                   |    2 +
 sound/soc/sof/ipc4-pcm.c                      |   13 +-
 sound/usb/stream.c                            |    5 +-
 tools/bpf/bpftool/prog.c                      |    2 +-
 tools/bpf/resolve_btfids/main.c               |   70 +-
 tools/include/linux/btf_ids.h                 |    9 +
 tools/lib/bpf/bpf.h                           |    2 +-
 tools/lib/bpf/libbpf.c                        |    4 +
 tools/lib/bpf/libbpf_internal.h               |   14 +
 tools/lib/bpf/netlink.c                       |    4 +-
 tools/objtool/check.c                         |   12 +
 tools/perf/Makefile.perf                      |    2 +-
 tools/perf/builtin-record.c                   |   35 +-
 tools/perf/builtin-top.c                      |    1 +
 tools/perf/util/data.c                        |    2 -
 tools/perf/util/evlist.c                      |   25 +
 tools/perf/util/evlist.h                      |    1 +
 tools/perf/util/evsel.c                       |    1 -
 tools/perf/util/expr.c                        |   20 +-
 tools/perf/util/pmu.c                         |   19 +-
 tools/perf/util/print-events.c                |   27 +-
 tools/perf/util/srcline.c                     |    2 +
 tools/perf/util/stat-display.c                |    2 +-
 tools/perf/util/stat-shadow.c                 |    7 +-
 tools/perf/util/thread_map.c                  |    2 +-
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   |    9 +
 .../selftests/bpf/prog_tests/lwt_redirect.c   |    1 +
 .../selftests/bpf/prog_tests/tc_redirect.c    |  407 +++++--
 .../bpf/progs/test_global_func_ctx_args.c     |   19 +
 .../selftests/bpf/progs/test_map_in_map.c     |   26 +
 tools/testing/selftests/bpf/test_maps.c       |    6 +-
 tools/testing/selftests/net/forwarding/config |   35 +
 .../net/forwarding/vxlan_bridge_1d_ipv6.sh    |    4 +-
 .../net/forwarding/vxlan_bridge_1q_ipv6.sh    |    4 +-
 .../selftests/net/openvswitch/openvswitch.sh  |   13 +
 .../selftests/net/openvswitch/ovs-dpctl.py    |   71 +-
 tools/testing/selftests/net/tls.c             |    8 +-
 721 files changed, 6551 insertions(+), 7187 deletions(-)
 create mode 100644 drivers/crypto/intel/qat/qat_common/adf_cfg_services.c
 delete mode 100644 net/bluetooth/a2mp.c
 delete mode 100644 net/bluetooth/a2mp.h
 delete mode 100644 net/bluetooth/amp.c
 delete mode 100644 net/bluetooth/amp.h

-- 
2.43.0


