Return-Path: <linux-kernel+bounces-116954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9225B88A587
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:59:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A76341C3A8A2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6171912A151;
	Mon, 25 Mar 2024 12:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZgQ0IS5H"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9DD71CBBC0;
	Mon, 25 Mar 2024 12:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711368020; cv=none; b=u0vWX1Aeb0nJxZOEtXz3wDTYCtQykLkHCPC+P0GIpFuhJ32r1VdKCxL2vOPSdtPUlLP89ckf23odp7OuDhnlU4wGDbX3+k67ahbDbnukdkxJjiZ1iynShoP/eYeaNrEMjp8waK7L4lGfJBT1e0tRotgjQ18DljP/7Yq+ATY9W9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711368020; c=relaxed/simple;
	bh=HU3Kzp53LhkjVgGGzFXzl4MIFBYq6H/NaKTSSG3vmDo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aVXt0ygjfNzg8B5Easq6FsdWR01hCfNNi5WU214npV6/n3qOtWxHY72CGfJvpw8L2rri21+yTSQFJQOPyF2RoIzERBKnlKyHWifOOvT66O13C1VRa/ILgjNR1YvrqbDouUvheITe4U/X75ZxLSlcl2Je3g2d1bcIdTyCD9Hn2oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZgQ0IS5H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44DACC433C7;
	Mon, 25 Mar 2024 12:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711368020;
	bh=HU3Kzp53LhkjVgGGzFXzl4MIFBYq6H/NaKTSSG3vmDo=;
	h=From:To:Cc:Subject:Date:From;
	b=ZgQ0IS5HjSXEAOtJDpiKzYBTvLKFCmC/JHKAbmejdYG4HJ3KIBixDrMBnw2d4/Db/
	 ieoD2jGYxRtlFVQAXlQp3gTh50/yN7T3ckTbrk/NqY0OMwUC70eWwbddkhRM2T522q
	 p1bCN9Ro9xSFE59uAb0XFuvbjlyjSDN5D7LeBKIhAOYtEcHkQZ+Dxhi5q0AwxXe/tw
	 3nXiLc+E9w97UGgst6DNk5mWkisGRErAQPTMkaXHPpKFsSXQO46YCJLFQngh4nB6Uo
	 fD41RxDqklURLAWdLIwH56Wae8VVjZoCQB0q0fwSBATPlPCZQR3UHwd6n/ZWcpX5/p
	 qqOPCus+jq7sg==
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
Subject: [PATCH 6.8 000/710] 6.8.2-rc2 review
Date: Mon, 25 Mar 2024 08:00:18 -0400
Message-ID: <20240325120018.1768449-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.8.2-rc2.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.8.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.8.2-rc2
X-KernelTest-Deadline: 2024-03-27T12:00+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit


This is the start of the stable review cycle for the 6.8.2 release.
There are 710 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Wed Mar 27 12:00:13 PM UTC 2024.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
        https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/patch/?id=linux-6.8.y&id2=v6.8.1
or in the git tree and branch at:
        git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.8.y
and the diffstat can be found below.

Thanks,
Sasha

-------------
Pseudo-Shortlog of commits:

Abel Vesa (3):
  arm64: dts: qcom: x1e80100-qcp: Fix supplies for LDOs 3E and 2J
  arm64: dts: qcom: sm8550: Fix SPMI channels size
  arm64: dts: qcom: sm8650: Fix SPMI channels size

Abhinav Kumar (1):
  drm/msm/dpu: fix the programming of INTF_CFG2_DATA_HCTL_EN

Adam Butcher (1):
  spi: spi-imx: fix off-by-one in mx51 CPU mode burst length

Adam Guerin (4):
  crypto: qat - remove unused macros in qat_comp_alg.c
  crypto: qat - removed unused macro in adf_cnv_dbgfs.c
  crypto: qat - avoid division by zero
  crypto: qat - remove double initialization of value

Adam Skladowski (1):
  dt-bindings: msm: qcom, mdss: Include ommited fam-b compatible

Ajay Singh (2):
  wifi: wilc1000: do not realloc workqueue everytime an interface is
    added
  wifi: wilc1000: fix multi-vif management when deleting a vif

Alex Bee (1):
  drm/rockchip: inno_hdmi: Fix video timing

Alexander Stein (2):
  media: tc358743: register v4l2 async device only after successful
    setup
  media: i2c: imx290: Fix IMX920 typo

Alexander Sverdlin (1):
  spi: lpspi: Avoid potential use-after-free in probe()

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

Amir Goldstein (1):
  ovl: relax WARN_ON in ovl_verify_area()

Anastasia Belova (1):
  cpufreq: brcmstb-avs-cpufreq: add check for cpufreq_cpu_get's return
    value

Andre Przywara (1):
  firmware: arm_scmi: Fix double free in SMC transport cleanup path

Andrejs Cainikovs (1):
  arm64: dts: ti: k3-am62-main: disable usb lpm

Andrew Davis (1):
  arm64: dts: ti: k3-j721e: Fix mux-reg-masks in hbmc_mux

Andrey Grafin (2):
  libbpf: Apply map_set_def_max_entries() for inner_maps on creation
  selftest/bpf: Add map_in_maps with BPF_MAP_TYPE_PERF_EVENT_ARRAY
    values

Andrey Skvortsov (2):
  Bluetooth: hci_h5: Add ability to allocate memory for private data
  Bluetooth: btrtl: fix out of bounds memory access

Andrii Nakryiko (9):
  libbpf: Fix faccessat() usage on Android
  libbpf: fix __arg_ctx type enforcement for perf_event programs
  libbpf: Add missing LIBBPF_API annotation to libbpf_set_memlock_rlim
    API
  libbpf: Add bpf_token_create() API
  libbpf: Add btf__new_split() API that was declared but not implemented
  libbpf: Add missed btf_ext__raw_data() API
  bpf: make sure scalar args don't accept __arg_nonnull tag
  bpf: don't emit warnings intended for global subprogs for static
    subprogs
  libbpf: fix return value for PERF_EVENT __arg_ctx type fix up check

Andrzej Pietrasiewicz (1):
  media: videobuf2: Add missing doc comment for waiting_in_dqbuf

Andy Shevchenko (2):
  backlight: hx8357: Fix potential NULL pointer dereference
  serial: 8250_exar: Don't remove GPIO device on suspend

AngeloGioacchino Del Regno (1):
  drm/mediatek: dsi: Fix DSI RGB666 formats and definitions

Antoniu Miclaus (1):
  rtc: max31335: fix interrupt status reg

Anup Patel (1):
  RISC-V: KVM: Forward SEED CSR access to user space

Ard Biesheuvel (3):
  x86/sme: Fix memory encryption setting if enabled by default and not
    overridden
  x86/efistub: Clear decompressor BSS in native EFI entrypoint
  x86/efistub: Don't clear BSS twice in mixed mode

Armin Wolf (2):
  ACPI: processor_idle: Fix memory leak in acpi_processor_power_exit()
  platform/x86/amd/pmf: Do not use readl() for policy buffer access

Arnaldo Carvalho de Melo (1):
  perf bpf: Clean up the generated/copied vmlinux.h

Arnaud Pouliquen (2):
  remoteproc: stm32: Fix incorrect type in assignment for va
  remoteproc: stm32: Fix incorrect type assignment returned by
    stm32_rproc_get_loaded_rsc_tablef

Arnd Bergmann (12):
  fs/select: rework stack allocation hack for clang
  cpufreq: qcom-hw: add CONFIG_COMMON_CLK dependency
  wifi: brcmsmac: avoid function pointer casts
  crypto: qat - avoid memcpy() overflow warning
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

Audra Mitchell (1):
  workqueue.c: Increase workqueue name length

Babu Moger (2):
  x86/resctrl: Remove hard-coded memory bandwidth limit
  x86/resctrl: Read supported bandwidth sources from CPUID

Baochen Qiang (2):
  wifi: ath11k: fix a possible dead lock caused by ab->base_lock
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

Benjamin Berg (3):
  wifi: cfg80211: add RNR with reporting AP information
  wifi: mac80211: use deflink and fix typo in link ID check
  wifi: cfg80211: set correct param change count in ML element

Benjamin Gaignard (1):
  media: usbtv: Remove useless locks in usbtv_video_free()

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

Brian Masney (1):
  fbdev/simplefb: change loglevel when the power domains cannot be
    parsed

Bryan O'Donoghue (1):
  clk: Fix clk_core_get NULL dereference

Changbin Du (1):
  modules: wait do_free_init correctly

Changhuang Liang (1):
  staging: media: starfive: Set 16 bpp for capture_raw device

Chao Yu (15):
  f2fs: compress: fix to guarantee persisting compressed blocks by CP
  f2fs: compress: fix to cover normal cluster write with cp_rwsem
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
  f2fs: fix to truncate meta inode pages forcely
  f2fs: zone: fix to remove pow2 check condition for zoned block device
  f2fs: fix to avoid use-after-free issue in f2fs_filemap_fault

Charles Keepax (1):
  ASoC: Intel: ssp-common: Add stub for sof_ssp_get_codec_name

Charlie Jenkins (1):
  riscv: Only check online cpus for emulated accesses

Chen Ni (2):
  sr9800: Add check for usbnet_get_endpoints
  drm/tegra: dsi: Add missing check for of_find_device_by_node

Chen-Yu Tsai (4):
  arm64: dts: allwinner: h6: Add RX DMA channel for SPDIF
  pinctrl: mediatek: Drop bogus slew rate register range for MT8186
  pinctrl: mediatek: Drop bogus slew rate register range for MT8192
  clk: mediatek: mt8183: Correct parent of CLK_INFRA_SSPM_32K_SELF

Chintan Vankar (1):
  arm64: dts: ti: k3-j784s4-main: Fix mux-reg-masks in serdes_ln_ctrl

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

Claudiu Beznea (3):
  arm64: dts: renesas: rzg3s-smarc-som: Guard Ethernet IRQ GPIO hogs
  pinctrl: renesas: rzg2l: Fix locking in rzg2l_dt_subnode_to_map()
  clk: renesas: r9a07g04[34]: Use SEL_SDHI1_STS status configuration for
    SD1 mux

Colin Ian King (1):
  usb: gadget: net2272: Use irqflags in the call to net2272_probe_fin

Craig Tatlor (1):
  ARM: dts: qcom: msm8974: correct qfprom node size

Cristian Ciocaltea (6):
  ASoC: amd: acp: Add missing error handling in sof-mach
  ASoC: SOF: amd: Fix memory leak in amd_sof_acp_probe()
  ASoC: SOF: core: Skip firmware test for custom loaders
  ASoC: SOF: amd: Compute file paths on firmware load
  ASoC: SOF: amd: Move signed_fw_image to struct acp_quirk_entry
  ASoC: SOF: amd: Skip IRAM/DRAM size modification for Steam Deck OLED

Dafna Hirschfeld (1):
  drm/xe: Replace 'grouped target' in Makefile with pattern rule

Damian Muszynski (2):
  crypto: qat - fix ring to service map for dcc in 4xxx
  crypto: qat - fix ring to service map for dcc in 420xx

Dan Carpenter (6):
  io_uring/net: fix overflow check in io_recvmsg_mshot_prep()
  ASoC: SOF: Add some bounds checking to firmware data
  lib/stackdepot: off by one in depot_fetch_stack()
  bus: mhi: ep: check the correct variable in
    mhi_ep_register_controller()
  staging: greybus: fix get_channel_from_mode() failure path
  char: xilinx_hwicap: Fix NULL vs IS_ERR() bug

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

Dave Airlie (2):
  nouveau: reset the bo resource bus info after an eviction
  nouveau/gsp: don't check devinit disable on GSP.

Dave Jiang (2):
  ACPI: HMAT: Remove register of memory node for generic target
  cxl: Fix the incorrect assignment of SSLBIS entry pointer initial
    location

Dave Wysochanski (1):
  NFS: Fix nfs_netfs_issue_read() xarray locking for writeback interrupt

David E. Box (2):
  platform/x86/intel/pmc/lnl: Remove SSRAM support
  platform/x86/intel/pmc/arl: Put GNA device in D3

David Gow (8):
  kunit: test: Log the correct filter string in executor_test
  lib/cmdline: Fix an invalid format specifier in an assertion msg
  lib: memcpy_kunit: Fix an invalid format specifier in an assertion msg
  time: test: Fix incorrect format specifier
  rtc: test: Fix invalid format specifier.
  net: test: Fix printf format specifier in skb_segment kunit test
  drm/xe/tests: Fix printf format specifiers in xe_migrate test
  drm: tests: Fix invalid printf format specifiers in KUnit tests

David Heidelberg (1):
  arm64: dts: qcom: sdm845-oneplus-common: improve DAI node naming

David Howells (4):
  cifs: Fix writeback data corruption
  afs: Revert "afs: Hide silly-rename files from userspace"
  afs: Don't cache preferred address
  afs: Fix occasional rmdir-then-VNOVNODE with generic/011

David Lechner (2):
  spi: consolidate setting message->spi
  spi: move split xfers for CS_WORD emulation

David Regan (1):
  mtd: rawnand: brcmnand: exec_op helper functions return type fixes

Deren Wu (3):
  wifi: mt76: mt7925: update PCIe DMA settings
  wifi: mt76: mt7921e: fix use-after-free in free_irq()
  wifi: mt76: mt7925e: fix use-after-free in free_irq()

Devarsh Thakkar (2):
  arm64: dts: ti: Add common1 register space for AM65x SoC
  arm64: dts: ti: Add common1 register space for AM62x SoC

Dmitry Baryshkov (10):
  soc: qcom: socinfo: rename PM2250 to PM4125
  arm64: dts: qcom: rename PM2250 to PM4125
  arm64: dts: qcom: qcm2290: declare VLS CLAMP register for USB3 PHY
  arm64: dts: qcom: sm6115: declare VLS CLAMP register for USB3 PHY
  drm: ci: use clk_ignore_unused for apq8016
  drm/msm/dpu: finalise global state object
  drm/msm/a6xx: specify UBWC config for sc7180
  phy: qcom: qmp-usb: split USB-C PHY driver
  phy: qcom: qmp-usbc: add support for the Type-C handling
  phy: qcom: qmp-usbc: handle CLAMP register in a correct way

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

Eric Dumazet (8):
  sock_diag: annotate data-races around sock_diag_handlers[family]
  inet_diag: annotate data-races around inet_diag_table[]
  ipv6: mcast: remove one synchronize_net() barrier in ipv6_mc_down()
  net: ip_tunnel: make sure to pull inner header in ip_tunnel_rcv()
  tcp: Fix NEW_SYN_RECV handling in inet_twsk_purge()
  net/sched: taprio: proper TCA_TAPRIO_TC_ENTRY_INDEX check
  packet: annotate data-races around ignore_outgoing
  net: move dev->state into net_device_read_txrx group

Ethan Zhao (3):
  PCI: Make pci_dev_is_disconnected() helper public for other drivers
  iommu/vt-d: Don't issue ATS Invalidation request when device is
    disconnected
  iommu/vt-d: Improve ITE fault handling if target device isn't present

Eugen Hristev (2):
  arm64: dts: mediatek: mt8192: fix vencoder clock name
  arm64: dts: mediatek: mt8186: fix VENC power domain clocks

Ezra Buehler (1):
  mtd: spinand: esmt: Extend IDs to 5 bytes

Fedor Pchelkin (1):
  drm/tegra: put drm_gem_object ref on error in tegra_fb_create

Fei Shao (1):
  spi: spi-mt65xx: Fix NULL pointer access in interrupt handler

Felix Maurer (1):
  hsr: Handle failures in module init

Filipe Manana (1):
  btrfs: fix race when detecting delalloc ranges during fiemap

Florian Fainelli (1):
  spi: Fix error code checking in spi_mem_exec_op()

Frank Li (2):
  arm64: dts: imx8qm: Align edma3 power-domains resources indentation
  arm64: dts: imx8qm: Correct edma3 power-domains and interrupt numbers

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

Frédéric Danis (1):
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

Geert Uytterhoeven (11):
  ARM: dts: renesas: r8a73a4: Fix external clocks and clock rate
  arm64: dts: renesas: r8a779g0: Restore sort order
  arm64: dts: renesas: r8a779g0: Add missing SCIF_CLK2
  ARM: dts: arm: realview: Fix development chip ROM compatible value
  arm64: dts: renesas: r8a779a0: Correct avb[01] reg sizes
  arm64: dts: renesas: r8a779g0: Correct avb[01] reg sizes
  clk: renesas: r8a779g0: Fix PCIe clock name
  pinctrl: renesas: r8a779g0: Add missing SCIF_CLK2 pin group/function
  clk: renesas: r8a779g0: Correct PFC/GPIO parent clocks
  clk: renesas: r8a779f0: Correct PFC/GPIO parent clock
  pinctrl: renesas: Allow the compiler to optimize away sh_pfc_pm

Gen Xu (1):
  wifi: mt76: mt792x: fix ethtool warning

Geoffrey D. Bennett (4):
  ALSA: scarlett2: Fix Scarlett 4th Gen 4i4 low-voltage detection
  ALSA: scarlett2: Fix Scarlett 4th Gen autogain status values
  ALSA: scarlett2: Fix Scarlett 4th Gen input gain range
  ALSA: scarlett2: Fix Scarlett 4th Gen input gain range again

George Stark (1):
  leds: aw2013: Unlock mutex before destroying it

Gergo Koteles (5):
  ALSA: hda/tas2781: use dev_dbg in system_resume
  ALSA: hda/tas2781: add lock to system_suspend
  ALSA: hda/tas2781: do not reset cur_* values in runtime_suspend
  ALSA: hda/tas2781: do not call pm_runtime_force_* in
    system_resume/suspend
  ALSA: hda/tas2781: restore power state after system_resume

Hao Zhang (1):
  wifi: mt76: mt7925: fix mcu query command fail

Harry Wentland (2):
  drm: Don't treat 0 as -1 in drm_fixp2int_ceil
  drm/vkms: Avoid reading beyond LUT array

Hayes Wang (1):
  r8152: fix unknown device for choose_configuration

Heiko Carstens (1):
  s390/cache: prevent rebuild of shared_cpu_list

Heiko Stuebner (3):
  arm64: dts: rockchip: add missing interrupt-names for rk356x vdpu
  arm64: dts: rockchip: fix reset-names for rk356x i2s2 controller
  arm64: dts: rockchip: drop rockchip,trcm-sync-tx-only from rk3588 i2s

Hongyu Jin (1):
  dm io: Support IO priority

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

Ilpo Järvinen (1):
  PCI/DPC: Print all TLP Prefixes, not just the first

Jaegeuk Kim (1):
  f2fs: check number of blocks in a current section

Jai Luthra (1):
  arm64: dts: ti: k3-am62p: Fix memory ranges for DMSS

James Clark (1):
  coresight: Fix issue where a source device's helpers aren't disabled

Jan Höppner (1):
  s390/dasd: Use dev_*() for device log messages

Jan Kara (2):
  quota: Fix rcu annotations of inode dquot pointers
  quota: Properly annotate i_dquot arrays with __rcu

Janne Grunau (1):
  spi: Restore delays for non-GPIO chip select

Jayesh Choudhary (1):
  arm64: dts: ti: k3-am69-sk: remove assigned-clock-parents for unused
    VP

Jeff LaBundy (1):
  Input: iqs7222 - add support for IQS7222D v1.1 and v1.2

Jens Axboe (5):
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

Jie Wang (1):
  net: hns3: fix port duplex configure error in IMP reset

Jijie Shao (1):
  net: hns3: fix wrong judgment condition issue

Jinjie Ruan (1):
  wifi: mwifiex: debugfs: Drop unnecessary error check for
    debugfs_create_dir()

Jiri Olsa (1):
  bpftool: Fix wrong free call in do_show_link

Jiri Pirko (3):
  dpll: spec: use proper enum for pin capabilities attribute
  dpll: fix dpll_xa_ref_*_del() for multiple registrations
  devlink: fix port new reply cmd type

Jiri Slaby (SUSE) (1):
  tty: vt: fix 20 vs 0x20 typo in EScsiignore

Johan Carlsson (1):
  ALSA: usb-audio: Stop parsing channels bits when all channels are
    found.

Johannes Berg (8):
  wifi: iwlwifi: mvm: report beacon protection failures
  wifi: iwlwifi: dbg-tlv: ensure NUL termination
  wifi: iwlwifi: acpi: fix WPFC reading
  wifi: iwlwifi: mvm: initialize rates in FW earlier
  wifi: iwlwifi: mvm: d3: fix IPN byte order
  wifi: iwlwifi: always have 'uats_enabled'
  wifi: iwlwifi: mvm: fix erroneous queue index mask
  wifi: iwlwifi: mvm: don't set replay counters to 0xff

John Keeping (1):
  regulator: userspace-consumer: add module device table

John Ogness (6):
  printk: nbcon: Relocate 32bit seq macros
  printk: ringbuffer: Do not skip non-finalized records with
    prb_next_seq()
  printk: Wait for all reserved records with pr_flush()
  printk: Add this_cpu_in_panic()
  printk: ringbuffer: Cleanup reader terminology
  printk: ringbuffer: Skip non-finalized records in panic

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

José Roberto de Souza (1):
  drm/xe: Skip VMAs pin when requesting signal to the last XE_EXEC

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

Kai Huang (1):
  x86/asm: Remove the __iomem annotation of movdir64b()'s dst argument

Kajol Jain (1):
  powerpc/hv-gpci: Fix the H_GET_PERF_COUNTER_INFO hcall return value
    checks

Kamal Heib (1):
  net: ena: Remove ena_select_queue

Kang Yang (1):
  wifi: ath12k: fix incorrect logic of calculating vdev_stats_id

Kees Cook (2):
  pstore: inode: Only d_invalidate() is needed
  x86, relocs: Ignore relocations in .notes section

Keisuke Nishimura (2):
  sched/fair: Take the scheduling domain into account in
    select_idle_smt()
  sched/fair: Take the scheduling domain into account in
    select_idle_core()

Komal Bajaj (2):
  arm64: dts: qcom: qcm6490-idp: Correct the voltage setting for vph_pwr
  arm64: dts: qcom: qcs6490-rb3gen2: Correct the voltage setting for
    vph_pwr

Konrad Dybcio (13):
  arm64: dts: qcom: sc8180x: Hook up VDD_CX as GCC parent domain
  arm64: dts: qcom: sc8180x: Fix up big CPU idle state entry latency
  arm64: dts: qcom: sc8180x: Add missing CPU off state
  arm64: dts: qcom: sc8180x: Fix eDP PHY power-domains
  arm64: dts: qcom: sc8180x: Don't hold MDP core clock at FMAX
  arm64: dts: qcom: sc8180x: Require LOW_SVS vote for MMCX if DISPCC is
    on
  arm64: dts: qcom: sc8180x: Add missing CPU<->MDP_CFG path
  arm64: dts: qcom: sc8180x: Shrink aoss_qmp register space size
  arm64: dts: qcom: sm8450: Add missing interconnects to serial
  arm64: dts: qcom: sdm845: Use the Low Power Island CX/MX for SLPI
  clk: qcom: reset: Commonize the de/assert functions
  clk: qcom: reset: Ensure write completion on reset de/assertion
  clk: qcom: dispcc-sdm845: Adjust internal GDSC wait times

Konstantin Taranov (5):
  RDMA/mana_ib: Fix bug in creation of dma regions
  RDMA/mana_ib: Introduce mdev_to_gc helper function
  RDMA/mana_ib: Introduce mana_ib_get_netdev helper function
  RDMA/mana_ib: Introduce mana_ib_install_cq_cb helper function
  RDMA/mana_ib: Use virtual address in dma regions for MRs

Krzysztof Kozlowski (5):
  arm64: dts: qcom: x1e80100: drop qcom,drv-count
  arm64: dts: qcom: sdm845-db845c: correct PCIe wake-gpios
  arm64: dts: qcom: sm8150: correct PCIe wake-gpios
  riscv: dts: starfive: jh7100: fix root clock names
  soundwire: stream: add missing const to Documentation

Kuniyuki Iwashima (3):
  af_unix: Annotate data-race of gc_in_progress in wait_for_unix_gc().
  rds: tcp: Fix use-after-free of net in reqsk_timer_handler().
  tcp: Fix refcnt handling in __inet_hash_connect().

Kévin L'hôpital (1):
  net: phy: fix phy_get_internal_delay accessing an empty array

Lad Prabhakar (3):
  arm64: dts: renesas: rzg2l: Add missing interrupts to IRQC nodes
  arm64: dts: renesas: r9a08g045: Add missing interrupts to IRQC node
  ASoC: sh: rz-ssi: Fix error message print

Lang Yu (1):
  drm/amdgpu: fix mmhub client id out-of-bounds access

Le Ma (1):
  drm/amdgpu: drop setting buffer funcs in sdma442

Leon Romanovsky (1):
  xfrm: Allow UDP encapsulation only in offload modes

Li Nan (3):
  md: fix kmemleak of rdev->serial
  block: fix deadlock between bd_link_disk_holder and partition scan
  md: Don't clear MD_CLOSING when the raid is about to stop

Li Zhijian (1):
  coccinelle: device_attr_show: Remove useless expression STR

Linu Cherian (1):
  octeontx2-af: Use matching wake_up API variant in CGX command
    interface

Liu Ying (1):
  arm64: dts: imx8mp-evk: Fix hdmi@3d node

Lorenzo Bianconi (1):
  wifi: mt76: mt7996: fix fw loading timeout

Lu Baolu (4):
  iommu/vt-d: Use rbtree to track iommu probed devices
  iommu/vt-d: Use device rbtree in iopf reporting path
  iommu: Add static iommu_ops->release_domain
  iommu/vt-d: Fix NULL domain on device release

Luca Ceresoli (1):
  ASoC: rockchip: i2s-tdm: Fix inaccurate sampling rates

Luca Weiss (4):
  arm64: dts: qcom: sc7280: Add static properties to cryptobam
  arm64: dts: qcom: qcm6490-fairphone-fp5: Add missing reserved-memory
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

Mads Bligaard Nielsen (1):
  drm/bridge: adv7511: fix crash on irq during probe

Manivannan Sadhasivam (1):
  arm64: dts: qcom: sm8650: Fix UFS PHY clocks

Manorit Chawdhry (2):
  arm64: dts: ti: k3-j721s2: Fix power domain for VTM node
  arm64: dts: ti: k3-j784s4: Fix power domain for VTM node

Manu Bretelle (1):
  selftests/bpf: Disable IPv6 for lwt_redirect test

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

Mathias Nyman (4):
  xhci: Add interrupt pending autoclear flag to each interrupter
  xhci: make isoc_bei_interval variable interrupter specific.
  xhci: remove unnecessary event_ring_deq parameter from
    xhci_handle_event()
  xhci: update event ring dequeue pointer position to controller
    correctly

Matthew Brost (2):
  drm/xe: Fix ref counting leak on page fault
  drm/xe: Invalidate userptr VMA on page pin fault

Matti Vaittinen (1):
  iio: gts-helper: Fix division loop

Maxim Kudinov (1):
  ACPI: resource: Add MAIBENBEN X577 to irq1_edge_low_force_override

Maxime Ripard (2):
  kunit: Setup DMA masks on the kunit device
  drm/tests: helpers: Include missing drm_drv header

Mete Durlu (1):
  s390/vtime: fix average steal time calculation

Michael Ellerman (3):
  powerpc/32: fix ADB_CUDA kconfig warning
  powerpc/embedded6xx: Fix no previous prototype for avr_uart_send()
    etc.
  powerpc/4xx: Fix warp_gpio_leds build failure

Michael Roth (1):
  x86/mm: Ensure input to pfn_to_kaddr() is treated as a 64-bit type

Michal Vokáč (2):
  ARM: dts: imx6dl-yapp4: Fix typo in the QCA switch register address
  ARM: dts: imx6dl-yapp4: Move the internal switch PHYs under the switch
    node

Mikhail Khvainitski (1):
  HID: lenovo: Add middleclick_workaround sysfs knob for cptkbd

Mikulas Patocka (3):
  dm: call the resume method on internal suspend
  dm-integrity: fix a memory leak when rechecking the data
  dm-integrity: align the outgoing bio in integrity_recheck

Ming Lei (1):
  dm raid: fix false positive for requeue needed during reshape

Ming Yen Hsieh (9):
  wifi: mt76: mt7925: fix connect to 80211b mode fail in 2Ghz band
  wifi: mt76: mt7925: fix wmm queue mapping
  wifi: mt76: mt7925: fix fw download fail
  wifi: mt76: mt7925: fix WoW failed in encrypted mode
  wifi: mt76: mt7925: fix the wrong header translation config
  wifi: mt76: mt7925: add support to set ifs time by mcu command
  wifi: mt76: mt7921: fix incorrect type conversion for CLC command
  wifi: mt76: mt792x: fix a potential loading failure of the 6Ghz
    channel config from ACPI
  wifi: mt76: fix the issue of missing txpwr settings from ch153 to
    ch177

Miri Korenblit (5):
  wifi: iwlwifi: change link id in time event to s8
  wifi: iwlwifi: fix EWRD table validity check
  wifi: iwlwifi: read BIOS PNVM only for non-Intel SKU
  wifi: iwlwifi: support EHT for WH
  wifi: iwlwifi: properly check if link is active

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

Neil Armstrong (1):
  dt-bindings: arm-smmu: fix SM8[45]50 GPU SMMU if condition

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

Oleksij Rempel (1):
  net: dsa: microchip: make sure drive strength configuration is not
    lost by soft reset

Olga Kornievskaia (1):
  NFSv4.1/pnfs: fix NFS with TLS in pnfs

Ondrej Jirman (1):
  leds: sgm3140: Add missing timer cleanup and flash gpio control

Oscar Salvador (1):
  lib/stackdepot: fix first entry having a 0-handle

Pablo Neira Ayuso (2):
  netfilter: nft_set_pipapo: release elements in clone only from destroy
    path
  netfilter: nf_tables: do not compare internal table flags on updates

Paloma Arellano (2):
  drm/msm/dpu: allow certain formats for CDM for DP
  drm/msm/dpu: add division of drm_display_mode's hskew parameter

Pauli Virtanen (1):
  Bluetooth: fix use-after-free in accessing skb after sending it

Pavel Begunkov (1):
  io_uring: fix poll_remove stalled req completion

Peng Fan (1):
  thermal/drivers/qoriq: Fix getting tmu range

Perry Yuan (1):
  ACPI: CPPC: enable AMD CPPC V2 support for family 17h processors

Peter Chiu (2):
  wifi: mt76: mt7996: check txs format before getting skb by pid
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

Petr Machata (1):
  selftests: forwarding: Add missing config entries

Petr Mladek (1):
  printk: Disable passing console lock owner completely during panic()

Petre Rodan (1):
  iio: pressure: mprls0025pa fix off-by-one enum

Przemek Kitszel (1):
  ice: fix stats being updated by way too large values

Puranjay Mohan (1):
  bpf: hardcode BPF_PROG_PACK_SIZE to 2MB * num_possible_nodes()

Qiheng Lin (1):
  powerpc/pseries: Fix potential memleak in papr_get_attr()

Quan Tian (1):
  netfilter: nf_tables: Fix a memory leak in nf_tables_updchain

Quan Zhou (1):
  wifi: mt76: mt7925: add flow to avoid chip bt function fail

Quanyang Wang (1):
  crypto: xilinx - call finalize with bh disabled

Quentin Schulz (2):
  drm/rockchip: lvds: do not overwrite error code
  drm/rockchip: lvds: do not print scary message when probing defer

Raag Jadav (1):
  pwm: dwc: use pm_sleep_ptr() macro

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

Randy Dunlap (4):
  fs/hfsplus: use better @opf description
  drivers/ps3: select VIDEO to provide cmdline functions
  crypto: jitter - fix CRYPTO_JITTERENTROPY help text
  rtc: mt6397: select IRQ_DOMAIN instead of depending on it

Ravi Gunasekaran (1):
  arm64: dts: ti: k3-am62p5-sk: Enable CPSW MDIO node

Rob Clark (1):
  drm/msm/a7xx: Fix LLC typo

Rob Herring (1):
  media: dt-bindings: techwell,tw9900: Fix port schema ref

Roger Quadros (1):
  arm64: dts: ti: am65x: Fix dtbs_install for Rocktech OLDI overlay

Romain Naour (2):
  arm64: dts: ti: k3-am69-sk: fix PMIC interrupt number
  arm64: dts: ti: k3-j721e-sk: fix PMIC interrupt number

Sakari Ailus (3):
  media: ivsc: csi: Swap SINK and SOURCE pads
  mei: vsc: Call wake_up() in the threaded IRQ handler
  mei: vsc: Don't use sleeping condition in wait_event_timeout()

Sam Protsenko (1):
  clk: samsung: exynos850: Propagate SPI IPCLK rate change

Sam Ravnborg (4):
  sparc32: Use generic cmpdi2/ucmpdi2 variants
  mtd: maps: sun_uflash: Declare uflash_devinit static
  sparc32: Do not select GENERIC_ISA_DMA
  sparc32: Fix section mismatch in leon_pci_grpci

Sami Tolvanen (1):
  riscv: Fix syscall wrapper for >word-size arguments

Sandipan Das (2):
  perf vendor events amd: Fix Zen 4 cache latency events
  perf/x86/amd/core: Avoid register reset when CPU is dead

Sasha Levin (1):
  Linux 6.8.2-rc2

Saurabh Sengar (1):
  x86/hyperv: Use per cpu initial stack for vtl context

Sean Anderson (1):
  usb: phy: generic: Get the vbus supply

Serge Semin (2):
  tty: mips_ejtag_fdc: Fix passing incompatible pointer type warning
  mips: cm: Convert __mips_cm_l2sync_phys_base() to weak function

Shay Drory (1):
  devlink: Fix devlink parallel commands processing

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

Shin'ichiro Kawasaki (1):
  nvme: host: fix double-free of struct nvme_id_ns in ns_update_nuse()

Shung-Hsi Yu (1):
  selftests/bpf: trace_helpers.c: do not use poisoned type

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

Stefan Binding (1):
  ALSA: hda: cs35l41: Set Channel Index correctly when system is missing
    _DSD

Stephen Boyd (2):
  gpiolib: Pass consumer device through to core in
    devm_fwnode_gpiod_get_index()
  arm64: ftrace: Don't forbid CALL_OPS+CC_OPTIMIZE_FOR_SIZE with Clang

Steve Sistare (1):
  vdpa_sim: reset must not run

Subbaraya Sundeep (5):
  octeontx2: Detect the mbox up or down message via register
  octeontx2-pf: Wait till detach_resources msg is complete
  octeontx2-pf: Use default max_active works instead of one
  octeontx2-pf: Send UP messages to VF only when VF is up.
  octeontx2-af: Use separate handlers for interrupts

Sunil Goutham (1):
  octeontx2-af: Fix devlink params

Suzuki K Poulose (1):
  virtio: uapi: Drop __packed attribute in linux/virtio_pci.h

Takashi Iwai (1):
  ALSA: seq: fix function cast warnings

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

Thinh Tran (1):
  net/bnx2x: Prevent access to a freed page in page_pool

Thomas Richter (1):
  s390/pai: fix attr_event_free upper limit for pai device drivers

Thomas Weißschuh (1):
  power: supply: mm8013: fix "not charging" detection

Théo Lebrun (2):
  gpio: nomadik: fix offset bug in nmk_pmx_set()
  spi: spi-mem: add statistics support to ->exec_op() calls

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

Tomi Valkeinen (2):
  drm/tidss: Fix initial plane zpos values
  drm/tidss: Fix sync-lost issue with two displays

Tony Luck (1):
  x86/resctrl: Implement new mba_MBps throttling heuristic

Tudor Ambarus (1):
  tty: serial: samsung: fix tx_empty() to return TIOCSER_TEMT

Unnathi Chalicheemala (1):
  soc: qcom: llcc: Check return value on Broadcast_OR reg read

Uwe Kleine-König (3):
  pwm: atmel-hlcdc: Fix clock imbalance related to suspend support
  pwm: sti: Fix capture for st,pwm-num-chan < st,capture-num-chan
  ASoC: tlv320adc3xxx: Don't strip remove function when driver is
    builtin

Vaishnav Achath (1):
  arm64: dts: ti: k3-am62p-mcu/wakeup: Disable MCU and wakeup R5FSS
    nodes

Viktor Malik (2):
  tools/resolve_btfids: Refactor set sorting with types from btf_ids.h
  tools/resolve_btfids: Fix cross-compilation to non-host endianness

Vinicius Costa Gomes (2):
  igc: Fix missing time sync events
  igb: Fix missing time sync events

Viresh Kumar (1):
  OPP: debugfs: Fix warning around icc_get_name()

Vladimir Zapolskiy (1):
  arm64: dts: qcom: sm6115: drop pipe clock selection

Wang Jianjian (1):
  quota: Fix potential NULL pointer dereference

Wen Gong (3):
  wifi: ath11k: add support to select 6 GHz regulatory type
  wifi: ath11k: store cur_regulatory_info for each radio
  wifi: ath11k: change to move WMI_VDEV_PARAM_SET_HEMU_MODE before
    WMI_PEER_ASSOC_CMDID

Wenjie Qi (1):
  f2fs: fix NULL pointer dereference in f2fs_submit_page_write()

William Kucharski (1):
  RDMA/srpt: Do not register event handler until srpt device is fully
    setup

William Tu (2):
  devlink: Fix length of eswitch inline-mode
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

Yifan Zhang (1):
  drm/amdgpu: add MMHUB 3.3.1 support

Yihang Li (1):
  scsi: hisi_sas: Fix a deadlock issue related to automatic dump

Yonghong Song (1):
  bpf: Mark bpf_spin_{lock,unlock}() helpers with notrace correctly

Yonglong Liu (1):
  net: hns3: fix kernel crash when 1588 is received on HIP08 devices

Yu Kuai (3):
  md/raid1: factor out helpers to add rdev to conf
  md/raid1: record nonrot rdevs while adding/removing rdevs to conf
  md/raid1: fix choose next idle in read_balance()

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

rong.yan (1):
  wifi: mt76: mt7925: fix SAP no beacon issue in 5Ghz and 6Ghz band

 .../bindings/display/msm/qcom,mdss.yaml       |    1 +
 .../devicetree/bindings/iommu/arm,smmu.yaml   |   13 +-
 .../bindings/media/i2c/techwell,tw9900.yaml   |    2 +-
 Documentation/driver-api/soundwire/stream.rst |    4 +-
 Documentation/netlink/specs/devlink.yaml      |    2 +-
 Documentation/netlink/specs/dpll.yaml         |    1 +
 .../networking/net_cachelines/net_device.rst  |    2 +-
 Makefile                                      |    4 +-
 arch/arm/boot/dts/arm/arm-realview-pb1176.dts |    2 +-
 .../boot/dts/nxp/imx/imx6dl-yapp4-common.dtsi |   25 +-
 arch/arm/boot/dts/qcom/qcom-msm8974.dtsi      |    2 +-
 arch/arm/boot/dts/renesas/r8a73a4-ape6evm.dts |   12 +
 arch/arm/boot/dts/renesas/r8a73a4.dtsi        |    9 +-
 arch/arm/crypto/sha256_glue.c                 |   13 +-
 arch/arm/crypto/sha512-glue.c                 |   12 +-
 arch/arm64/Kconfig                            |    2 +-
 .../dts/allwinner/sun50i-h6-beelink-gs1.dts   |    2 +
 .../boot/dts/allwinner/sun50i-h6-tanix.dtsi   |    2 +
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi  |    7 +-
 .../boot/dts/broadcom/bcmbca/bcm4908.dtsi     |    3 -
 .../dts/freescale/imx8mm-kontron-bl-osm-s.dts |   38 +-
 .../boot/dts/freescale/imx8mm-kontron-bl.dts  |   38 +-
 .../dts/freescale/imx8mm-kontron-osm-s.dtsi   |    6 +-
 .../boot/dts/freescale/imx8mm-kontron-sl.dtsi |    4 +-
 .../dts/freescale/imx8mm-venice-gw71xx.dtsi   |   29 +-
 .../freescale/imx8mp-data-modul-edm-sbc.dts   |    2 +-
 arch/arm64/boot/dts/freescale/imx8mp-evk.dts  |   33 +-
 .../boot/dts/freescale/imx8qm-ss-dma.dtsi     |   29 +-
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi  |   10 +-
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
 .../dts/qcom/{pm2250.dtsi => pm4125.dtsi}     |    8 +-
 arch/arm64/boot/dts/qcom/qcm2290.dtsi         |    7 +
 .../boot/dts/qcom/qcm6490-fairphone-fp5.dts   |    5 +
 arch/arm64/boot/dts/qcom/qcm6490-idp.dts      |    4 +-
 arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts  |    4 +-
 arch/arm64/boot/dts/qcom/qrb2210-rb1.dts      |   78 +-
 arch/arm64/boot/dts/qcom/qrb4210-rb2.dts      |    4 -
 arch/arm64/boot/dts/qcom/sa8540p.dtsi         |    3 +
 arch/arm64/boot/dts/qcom/sc7280.dtsi          |    2 +
 arch/arm64/boot/dts/qcom/sc8180x.dtsi         |   38 +-
 arch/arm64/boot/dts/qcom/sdm845-db845c.dts    |    2 +-
 .../boot/dts/qcom/sdm845-oneplus-common.dtsi  |    8 +-
 arch/arm64/boot/dts/qcom/sdm845.dtsi          |    4 +-
 arch/arm64/boot/dts/qcom/sm6115.dtsi          |    8 +-
 arch/arm64/boot/dts/qcom/sm8150.dtsi          |    2 +-
 arch/arm64/boot/dts/qcom/sm8450.dtsi          |   12 +
 arch/arm64/boot/dts/qcom/sm8550.dtsi          |    2 +-
 arch/arm64/boot/dts/qcom/sm8650.dtsi          |   10 +-
 arch/arm64/boot/dts/qcom/x1e80100-qcp.dts     |    4 +-
 arch/arm64/boot/dts/qcom/x1e80100.dtsi        |    1 -
 arch/arm64/boot/dts/renesas/r8a779a0.dtsi     |    4 +-
 arch/arm64/boot/dts/renesas/r8a779g0.dtsi     |   88 +-
 arch/arm64/boot/dts/renesas/r9a07g043u.dtsi   |   12 +-
 arch/arm64/boot/dts/renesas/r9a07g044.dtsi    |   22 +-
 arch/arm64/boot/dts/renesas/r9a07g054.dtsi    |   22 +-
 arch/arm64/boot/dts/renesas/r9a08g045.dtsi    |    8 +-
 .../boot/dts/renesas/rzg3s-smarc-som.dtsi     |    4 +
 arch/arm64/boot/dts/rockchip/rk356x.dtsi      |    3 +-
 arch/arm64/boot/dts/rockchip/rk3588s.dtsi     |    2 -
 arch/arm64/boot/dts/ti/Makefile               |    1 +
 arch/arm64/boot/dts/ti/k3-am62-main.dtsi      |    9 +-
 arch/arm64/boot/dts/ti/k3-am62p-mcu.dtsi      |    2 +
 arch/arm64/boot/dts/ti/k3-am62p-wakeup.dtsi   |    1 +
 arch/arm64/boot/dts/ti/k3-am62p.dtsi          |    2 +-
 arch/arm64/boot/dts/ti/k3-am62p5-sk.dts       |    4 +
 arch/arm64/boot/dts/ti/k3-am64-main.dtsi      |    9 +-
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi      |    5 +-
 arch/arm64/boot/dts/ti/k3-am69-sk.dts         |   10 +-
 .../dts/ti/k3-j7200-common-proc-board.dts     |   18 +-
 .../boot/dts/ti/k3-j721e-mcu-wakeup.dtsi      |    4 +-
 arch/arm64/boot/dts/ti/k3-j721e-sk.dts        |    4 +-
 .../dts/ti/k3-j721s2-common-proc-board.dts    |    2 -
 .../boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi     |    2 +-
 arch/arm64/boot/dts/ti/k3-j784s4-evm.dts      |    2 -
 arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi    |   12 +-
 .../boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi     |    2 +-
 arch/mips/include/asm/mips-cm.h               |   13 +
 arch/mips/kernel/mips-cm.c                    |    5 +-
 arch/powerpc/include/asm/ppc_asm.h            |    6 +-
 arch/powerpc/include/asm/vmalloc.h            |    4 +-
 arch/powerpc/perf/hv-gpci.c                   |   29 +-
 arch/powerpc/platforms/44x/warp.c             |    1 +
 .../platforms/embedded6xx/linkstation.c       |    3 -
 arch/powerpc/platforms/embedded6xx/mpc10x.h   |    3 +
 arch/powerpc/platforms/powermac/Kconfig       |    2 +-
 arch/powerpc/platforms/ps3/Kconfig            |    1 +
 arch/powerpc/platforms/ps3/hvcall.S           |   18 +-
 .../pseries/papr_platform_attributes.c        |    8 +-
 arch/riscv/boot/dts/starfive/jh7100.dtsi      |    4 +
 arch/riscv/include/asm/pgtable.h              |    2 +
 arch/riscv/include/asm/syscall_wrapper.h      |   53 +-
 arch/riscv/kernel/traps_misaligned.c          |    2 +-
 arch/riscv/kvm/vcpu_insn.c                    |   13 +
 arch/s390/kernel/cache.c                      |    1 +
 arch/s390/kernel/perf_pai_crypto.c            |    2 +-
 arch/s390/kernel/perf_pai_ext.c               |    2 +-
 arch/s390/kernel/vdso32/Makefile              |    2 +-
 arch/s390/kernel/vdso64/Makefile              |    2 +-
 arch/s390/kernel/vtime.c                      |    4 +-
 arch/sparc/Kconfig                            |    6 +-
 arch/sparc/kernel/leon_pci_grpci1.c           |    2 +-
 arch/sparc/kernel/leon_pci_grpci2.c           |    2 +-
 arch/sparc/lib/Makefile                       |    4 +-
 arch/sparc/lib/cmpdi2.c                       |   28 -
 arch/sparc/lib/ucmpdi2.c                      |   20 -
 arch/x86/events/amd/core.c                    |    1 -
 arch/x86/hyperv/hv_vtl.c                      |   19 +-
 arch/x86/include/asm/io.h                     |    2 +-
 arch/x86/include/asm/page.h                   |    6 +-
 arch/x86/include/asm/special_insns.h          |    9 +-
 arch/x86/kernel/acpi/cppc.c                   |    2 +-
 arch/x86/kernel/cpu/resctrl/core.c            |   10 +-
 arch/x86/kernel/cpu/resctrl/internal.h        |    8 +-
 arch/x86/kernel/cpu/resctrl/monitor.c         |   48 +-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c        |   14 +-
 arch/x86/mm/mem_encrypt_identity.c            |   10 +-
 arch/x86/tools/relocs.c                       |    8 +
 block/holder.c                                |   12 +-
 crypto/Kconfig                                |    5 +-
 drivers/acpi/numa/hmat.c                      |    8 +-
 drivers/acpi/processor_idle.c                 |    2 +
 drivers/acpi/resource.c                       |   21 +
 drivers/acpi/scan.c                           |    8 +-
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
 drivers/char/xilinx_hwicap/xilinx_hwicap.c    |    4 +-
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
 drivers/clk/renesas/r8a779g0-cpg-mssr.c       |   13 +-
 drivers/clk/renesas/r9a07g043-cpg.c           |    2 +-
 drivers/clk/renesas/r9a07g044-cpg.c           |    2 +-
 drivers/clk/samsung/clk-exynos850.c           |   33 +-
 drivers/clk/zynq/clkc.c                       |    8 +-
 drivers/cpufreq/Kconfig.arm                   |    1 +
 drivers/cpufreq/brcmstb-avs-cpufreq.c         |    2 +
 drivers/cpufreq/cpufreq.c                     |   18 +-
 drivers/cpufreq/freq_table.c                  |    2 +-
 drivers/cpufreq/mediatek-cpufreq-hw.c         |   19 +-
 drivers/crypto/ccp/platform-access.c          |   11 +-
 .../intel/qat/qat_420xx/adf_420xx_hw_data.c   |    8 +
 .../intel/qat/qat_4xxx/adf_4xxx_hw_data.c     |    8 +
 .../crypto/intel/qat/qat_common/adf_clock.c   |    3 +
 .../intel/qat/qat_common/adf_cnv_dbgfs.c      |    1 -
 .../intel/qat/qat_common/adf_gen4_hw_data.c   |    3 +
 .../intel/qat/qat_common/adf_gen4_ras.c       |    6 +-
 .../intel/qat/qat_common/qat_comp_algs.c      |    9 -
 drivers/crypto/xilinx/zynqmp-aes-gcm.c        |    3 +
 drivers/cxl/core/cdat.c                       |   30 +-
 drivers/dma/Kconfig                           |   14 +-
 drivers/dpll/dpll_core.c                      |    8 +-
 drivers/firmware/arm_scmi/smc.c               |    7 +
 drivers/firmware/efi/libstub/x86-stub.c       |    7 +-
 drivers/gpio/Kconfig                          |    3 +-
 drivers/gpio/gpiolib-devres.c                 |    2 +-
 drivers/gpio/gpiolib.c                        |   14 +-
 drivers/gpio/gpiolib.h                        |    8 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |    6 +-
 drivers/gpu/drm/amd/amdgpu/atom.c             |    2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c        |    1 +
 drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c       |    8 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c      |   23 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   16 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c |    2 +-
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.c   |    7 +-
 .../link/protocols/link_edp_panel_control.c   |    3 +-
 .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c |    4 +-
 .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    |    4 +-
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  |    4 +-
 drivers/gpu/drm/bridge/adv7511/adv7511_drv.c  |   22 +-
 drivers/gpu/drm/ci/test.yml                   |    5 +-
 drivers/gpu/drm/lima/lima_gem.c               |   23 +-
 drivers/gpu/drm/mediatek/mtk_drm_crtc.c       |   12 +-
 drivers/gpu/drm/mediatek/mtk_dsi.c            |   10 +-
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c         |    5 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c   |   11 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h   |    7 +
 .../drm/msm/disp/dpu1/dpu_encoder_phys_vid.c  |    7 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_cdm.c    |    2 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c   |   15 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h   |    1 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c       |    8 +
 drivers/gpu/drm/nouveau/nouveau_bo.c          |    2 +
 .../drm/nouveau/nvkm/subdev/devinit/r535.c    |    1 -
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
 drivers/gpu/drm/tests/drm_buddy_test.c        |   14 +-
 drivers/gpu/drm/tests/drm_mm_test.c           |    6 +-
 drivers/gpu/drm/tidss/tidss_crtc.c            |   10 +
 drivers/gpu/drm/tidss/tidss_plane.c           |    2 +-
 drivers/gpu/drm/vkms/vkms_composer.c          |   14 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_gmrid_manager.c |    5 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c           |   11 +-
 drivers/gpu/drm/xe/Makefile                   |    3 +-
 drivers/gpu/drm/xe/tests/xe_migrate.c         |    8 +-
 drivers/gpu/drm/xe/xe_exec.c                  |   41 +-
 drivers/gpu/drm/xe/xe_gt_pagefault.c          |   10 +-
 drivers/gpu/drm/xe/xe_trace.h                 |    2 +-
 drivers/gpu/drm/xe/xe_vm.c                    |   32 +-
 drivers/gpu/drm/xe/xe_vm_types.h              |    7 +-
 drivers/hid/amd-sfh-hid/amd_sfh_pcie.c        |   30 +-
 drivers/hid/amd-sfh-hid/amd_sfh_pcie.h        |    6 +-
 drivers/hid/hid-lenovo.c                      |   57 +-
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
 drivers/infiniband/hw/mana/cq.c               |   29 +-
 drivers/infiniband/hw/mana/main.c             |   82 +-
 drivers/infiniband/hw/mana/mana_ib.h          |   27 +-
 drivers/infiniband/hw/mana/mr.c               |   17 +-
 drivers/infiniband/hw/mana/qp.c               |   94 +-
 drivers/infiniband/hw/mana/wq.c               |    4 +-
 drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c  |    2 +-
 drivers/infiniband/ulp/srpt/ib_srpt.c         |    3 +-
 drivers/input/misc/iqs7222.c                  |  112 ++
 drivers/iommu/Kconfig                         |    2 +-
 drivers/iommu/amd/init.c                      |    3 +
 drivers/iommu/intel/Makefile                  |    2 +
 drivers/iommu/intel/dmar.c                    |   26 +-
 drivers/iommu/intel/iommu.c                   |  122 +-
 drivers/iommu/intel/iommu.h                   |   10 +
 drivers/iommu/intel/pasid.c                   |   67 +
 drivers/iommu/intel/pasid.h                   |    1 +
 drivers/iommu/intel/svm.c                     |   17 +-
 drivers/iommu/iommu.c                         |   19 +-
 drivers/iommu/irq_remapping.c                 |    3 +-
 drivers/leds/flash/leds-sgm3140.c             |    3 +
 drivers/leds/leds-aw2013.c                    |    1 +
 drivers/md/dm-bufio.c                         |    6 +-
 drivers/md/dm-integrity.c                     |   30 +-
 drivers/md/dm-io.c                            |   23 +-
 drivers/md/dm-kcopyd.c                        |    4 +-
 drivers/md/dm-log.c                           |    4 +-
 drivers/md/dm-raid.c                          |    4 +-
 drivers/md/dm-raid1.c                         |    6 +-
 drivers/md/dm-snap-persistent.c               |    4 +-
 drivers/md/dm-verity-target.c                 |    2 +-
 drivers/md/dm-writecache.c                    |    8 +-
 drivers/md/dm.c                               |   26 +-
 drivers/md/md.c                               |   15 +-
 drivers/md/md.h                               |    1 +
 drivers/md/raid1.c                            |  134 +-
 drivers/md/raid1.h                            |    1 +
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
 .../media/platform/sunxi/sun8i-di/sun8i-di.c  |   69 +-
 drivers/media/usb/em28xx/em28xx-cards.c       |    4 +
 drivers/media/usb/go7007/go7007-driver.c      |    8 +-
 drivers/media/usb/go7007/go7007-usb.c         |    4 +-
 drivers/media/usb/pvrusb2/pvrusb2-context.c   |   10 +-
 drivers/media/usb/pvrusb2/pvrusb2-dvb.c       |    6 +-
 drivers/media/usb/pvrusb2/pvrusb2-v4l2.c      |   11 +-
 drivers/media/usb/usbtv/usbtv-video.c         |    7 -
 drivers/media/v4l2-core/v4l2-cci.c            |    4 +-
 drivers/media/v4l2-core/v4l2-mem2mem.c        |   10 +-
 drivers/memory/tegra/tegra234.c               |   16 +-
 drivers/mfd/altera-sysmgr.c                   |    4 +-
 drivers/mfd/cs42l43.c                         |   72 +-
 drivers/mfd/syscon.c                          |    4 +-
 drivers/misc/mei/vsc-tp.c                     |   17 +-
 drivers/mmc/host/wmt-sdmmc.c                  |    4 -
 drivers/mtd/maps/physmap-core.c               |    2 +-
 drivers/mtd/maps/sun_uflash.c                 |    2 +-
 drivers/mtd/nand/raw/brcmnand/brcmnand.c      |   12 +-
 drivers/mtd/nand/raw/lpc32xx_mlc.c            |    5 +-
 drivers/mtd/nand/spi/esmt.c                   |    9 +-
 drivers/net/can/m_can/m_can.c                 |   23 +-
 drivers/net/dsa/microchip/ksz_common.c        |   10 +-
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
 .../marvell/octeontx2/af/rvu_devlink.c        |   20 +-
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
 drivers/net/usb/r8152.c                       |    2 +-
 drivers/net/usb/sr9800.c                      |    4 +-
 drivers/net/veth.c                            |   18 -
 drivers/net/vmxnet3/vmxnet3_xdp.c             |    6 +-
 drivers/net/wireguard/receive.c               |    6 +-
 drivers/net/wireless/ath/ath10k/wmi-tlv.c     |    4 +
 drivers/net/wireless/ath/ath11k/core.h        |    1 +
 drivers/net/wireless/ath/ath11k/mac.c         |   17 +-
 drivers/net/wireless/ath/ath11k/reg.c         |  249 +++-
 drivers/net/wireless/ath/ath11k/reg.h         |   11 +-
 drivers/net/wireless/ath/ath11k/wmi.c         |  147 +-
 drivers/net/wireless/ath/ath11k/wmi.h         |    1 +
 drivers/net/wireless/ath/ath12k/core.h        |    2 +-
 drivers/net/wireless/ath/ath12k/hal.c         |    6 +-
 drivers/net/wireless/ath/ath12k/mac.c         |    4 +-
 drivers/net/wireless/ath/ath12k/reg.c         |    4 +-
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
 .../net/wireless/intel/iwlwifi/fw/runtime.h   |    2 +-
 .../net/wireless/intel/iwlwifi/iwl-dbg-tlv.c  |    6 +
 .../wireless/intel/iwlwifi/iwl-nvm-parse.c    |    2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c   |   12 +-
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |   25 +-
 .../net/wireless/intel/iwlwifi/mvm/mld-key.c  |   18 +-
 .../net/wireless/intel/iwlwifi/mvm/mld-mac.c  |    2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |    2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c |   26 +-
 .../wireless/intel/iwlwifi/mvm/time-event.c   |   11 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c   |   12 +-
 drivers/net/wireless/marvell/libertas/cmd.c   |   13 +-
 .../net/wireless/marvell/mwifiex/debugfs.c    |    3 -
 .../wireless/mediatek/mt76/mt76_connac_mcu.c  |    4 +-
 .../wireless/mediatek/mt76/mt76_connac_mcu.h  |    4 +
 .../net/wireless/mediatek/mt76/mt7921/mcu.c   |    4 +-
 .../net/wireless/mediatek/mt76/mt7921/pci.c   |    1 +
 .../net/wireless/mediatek/mt76/mt7925/main.c  |   26 +-
 .../net/wireless/mediatek/mt76/mt7925/mcu.c   |  176 ++-
 .../net/wireless/mediatek/mt76/mt7925/mcu.h   |   92 +-
 .../net/wireless/mediatek/mt76/mt7925/pci.c   |    3 +
 .../wireless/mediatek/mt76/mt792x_acpi_sar.c  |   26 +-
 .../net/wireless/mediatek/mt76/mt792x_core.c  |    1 +
 .../net/wireless/mediatek/mt76/mt792x_dma.c   |   15 +-
 .../net/wireless/mediatek/mt76/mt792x_regs.h  |    8 +
 .../net/wireless/mediatek/mt76/mt7996/dma.c   |    3 +-
 .../net/wireless/mediatek/mt76/mt7996/init.c  |    7 +-
 .../net/wireless/mediatek/mt76/mt7996/mac.c   |   76 +-
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
 drivers/nvme/host/sysfs.c                     |    7 +-
 drivers/opp/debugfs.c                         |    6 +-
 drivers/pci/controller/pcie-brcmstb.c         |    2 +-
 drivers/pci/endpoint/functions/pci-epf-vntb.c |    6 +-
 drivers/pci/p2pdma.c                          |    2 +-
 drivers/pci/pci.h                             |    5 -
 drivers/pci/pcie/dpc.c                        |    2 +-
 drivers/pci/quirks.c                          |    1 +
 drivers/pci/switch/switchtec.c                |    4 +-
 drivers/phy/qualcomm/Makefile                 |    2 +-
 drivers/phy/qualcomm/phy-qcom-qmp-usb.c       |  266 ----
 drivers/phy/qualcomm/phy-qcom-qmp-usbc.c      | 1195 +++++++++++++++++
 drivers/pinctrl/mediatek/pinctrl-mt8186.c     |    1 -
 drivers/pinctrl/mediatek/pinctrl-mt8192.c     |    1 -
 drivers/pinctrl/nomadik/pinctrl-nomadik.c     |    6 +-
 drivers/pinctrl/renesas/core.c                |    4 +-
 drivers/pinctrl/renesas/pfc-r8a779g0.c        |   14 +
 drivers/pinctrl/renesas/pinctrl-rzg2l.c       |   20 +-
 drivers/platform/x86/amd/pmf/tee-if.c         |    4 +-
 drivers/platform/x86/intel/pmc/arl.c          |    2 +
 drivers/platform/x86/intel/pmc/lnl.c          |   40 +-
 drivers/pmdomain/qcom/rpmhpd.c                |    1 -
 drivers/power/supply/mm8013.c                 |   13 +-
 drivers/powercap/dtpm_cpu.c                   |    2 +-
 drivers/pwm/pwm-atmel-hlcdc.c                 |    2 +-
 drivers/pwm/pwm-dwc.c                         |    2 +-
 drivers/pwm/pwm-sti.c                         |   11 +-
 drivers/regulator/userspace-consumer.c        |    1 +
 drivers/remoteproc/stm32_rproc.c              |    6 +-
 drivers/rtc/Kconfig                           |    3 +-
 drivers/rtc/lib_test.c                        |    2 +-
 drivers/rtc/rtc-max31335.c                    |    2 +-
 drivers/s390/block/dasd.c                     |   55 +-
 drivers/scsi/bfa/bfa.h                        |    9 +-
 drivers/scsi/bfa/bfa_core.c                   |    4 +-
 drivers/scsi/bfa/bfa_ioc.h                    |    8 +-
 drivers/scsi/bfa/bfad_bsg.c                   |   11 +-
 drivers/scsi/csiostor/csio_defs.h             |   18 +-
 drivers/scsi/csiostor/csio_lnode.c            |    8 +-
 drivers/scsi/csiostor/csio_lnode.h            |   13 -
 drivers/scsi/hisi_sas/hisi_sas_main.c         |   12 +-
 drivers/soc/fsl/dpio/dpio-service.c           |    2 +-
 drivers/soc/qcom/llcc-qcom.c                  |    2 +
 drivers/soc/qcom/socinfo.c                    |    2 +-
 drivers/spi/spi-fsl-lpspi.c                   |    8 +-
 drivers/spi/spi-imx.c                         |    4 +-
 drivers/spi/spi-mem.c                         |   49 +-
 drivers/spi/spi-mt65xx.c                      |   22 +-
 drivers/spi/spi.c                             |   94 +-
 drivers/staging/greybus/light.c               |    8 +-
 .../staging/media/imx/imx-media-csc-scaler.c  |    1 +
 .../media/starfive/camss/stf-capture.c        |    8 +-
 .../staging/media/sunxi/cedrus/cedrus_h265.c  |   10 +-
 drivers/thermal/mediatek/lvts_thermal.c       |    4 +-
 drivers/thermal/qoriq_thermal.c               |   12 +-
 drivers/tty/mips_ejtag_fdc.c                  |    2 +-
 drivers/tty/serial/8250/8250_exar.c           |    5 +-
 drivers/tty/serial/max310x.c                  |    2 +-
 drivers/tty/serial/samsung_tty.c              |    5 +-
 drivers/tty/vt/vt.c                           |    2 +-
 drivers/usb/gadget/udc/net2272.c              |    2 +-
 drivers/usb/host/xhci-mem.c                   |    2 +-
 drivers/usb/host/xhci-ring.c                  |   90 +-
 drivers/usb/host/xhci.c                       |    3 +
 drivers/usb/host/xhci.h                       |    3 +-
 drivers/usb/phy/phy-generic.c                 |    7 +
 drivers/vdpa/mlx5/net/mlx5_vnet.c             |   13 +-
 drivers/vdpa/vdpa_sim/vdpa_sim.c              |    3 +-
 drivers/video/backlight/da9052_bl.c           |    1 +
 drivers/video/backlight/hx8357.c              |   10 +-
 drivers/video/backlight/ktz8866.c             |    6 +-
 drivers/video/backlight/lm3630a_bl.c          |   15 +-
 drivers/video/backlight/lm3639_bl.c           |    1 +
 drivers/video/backlight/lp8788_bl.c           |    1 +
 drivers/video/fbdev/simplefb.c                |    2 +-
 drivers/virtio/virtio_ring.c                  |    6 +-
 drivers/watchdog/starfive-wdt.c               |    9 +-
 drivers/watchdog/stm32_iwdg.c                 |    3 +
 drivers/xen/events/events_base.c              |   22 +-
 drivers/xen/evtchn.c                          |    6 +
 fs/afs/dir.c                                  |   10 -
 fs/afs/rotate.c                               |   21 +-
 fs/afs/validation.c                           |   16 +-
 fs/btrfs/extent_io.c                          |  221 ++-
 fs/ceph/file.c                                |   23 +-
 fs/erofs/fscache.c                            |   15 +-
 fs/erofs/internal.h                           |    1 -
 fs/erofs/super.c                              |   30 +-
 fs/ext2/ext2.h                                |    2 +-
 fs/ext2/super.c                               |    2 +-
 fs/ext4/ext4.h                                |    2 +-
 fs/ext4/super.c                               |    2 +-
 fs/f2fs/checkpoint.c                          |    5 +-
 fs/f2fs/compress.c                            |   41 +-
 fs/f2fs/data.c                                |   36 +-
 fs/f2fs/dir.c                                 |    5 +-
 fs/f2fs/f2fs.h                                |   72 +-
 fs/f2fs/file.c                                |   76 +-
 fs/f2fs/namei.c                               |   25 +-
 fs/f2fs/node.c                                |   20 +-
 fs/f2fs/recovery.c                            |   33 +-
 fs/f2fs/segment.c                             |   11 +-
 fs/f2fs/segment.h                             |   17 +-
 fs/f2fs/super.c                               |   17 +-
 fs/fcntl.c                                    |   12 +-
 fs/fhandle.c                                  |    2 +-
 fs/hfsplus/wrapper.c                          |    2 +-
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
 fs/overlayfs/copy_up.c                        |    6 +-
 fs/overlayfs/params.c                         |   14 +-
 fs/pstore/inode.c                             |   10 +-
 fs/quota/dquot.c                              |  159 ++-
 fs/reiserfs/reiserfs.h                        |    2 +-
 fs/reiserfs/super.c                           |    2 +-
 fs/select.c                                   |    2 +-
 fs/smb/client/file.c                          |  283 ++--
 include/drm/drm_fixed.h                       |    5 +-
 include/drm/drm_kunit_helpers.h               |    2 +
 include/dt-bindings/clock/r8a779g0-cpg-mssr.h |    1 +
 include/linux/dm-io.h                         |    3 +-
 include/linux/f2fs_fs.h                       |    1 +
 include/linux/filter.h                        |   21 +-
 include/linux/fs.h                            |   11 +-
 include/linux/iommu.h                         |    1 +
 include/linux/moduleloader.h                  |    8 +
 include/linux/netdevice.h                     |    2 +-
 include/linux/pci.h                           |    5 +
 include/linux/poll.h                          |    4 -
 include/linux/rcupdate.h                      |   31 +
 include/linux/shmem_fs.h                      |    2 +-
 include/linux/workqueue.h                     |   35 +-
 include/media/videobuf2-core.h                |   13 +-
 include/net/bluetooth/hci.h                   |    2 -
 include/net/bluetooth/hci_core.h              |    1 +
 include/net/bluetooth/hci_sync.h              |    2 +-
 include/net/bluetooth/l2cap.h                 |   42 -
 include/soc/qcom/qcom-spmi-pmic.h             |    2 +-
 include/uapi/linux/virtio_pci.h               |   10 +-
 init/main.c                                   |    5 +-
 io_uring/io_uring.c                           |  116 +-
 io_uring/net.c                                |  260 ++--
 io_uring/poll.c                               |    4 +-
 kernel/bpf/btf.c                              |   14 +-
 kernel/bpf/core.c                             |    7 +-
 kernel/bpf/cpumap.c                           |    3 +
 kernel/bpf/devmap.c                           |   11 +-
 kernel/bpf/hashtab.c                          |   14 +-
 kernel/bpf/helpers.c                          |    4 +-
 kernel/bpf/stackmap.c                         |    9 +-
 kernel/module/main.c                          |    9 +-
 kernel/printk/internal.h                      |    1 +
 kernel/printk/nbcon.c                         |   41 +-
 kernel/printk/printk.c                        |   74 +-
 kernel/printk/printk_ringbuffer.c             |  313 ++++-
 kernel/printk/printk_ringbuffer.h             |   38 +-
 kernel/rcu/tree.c                             |    3 +
 kernel/rcu/tree_exp.h                         |   25 +-
 kernel/sched/fair.c                           |   16 +-
 kernel/time/time_test.c                       |    2 +-
 kernel/time/timekeeping.c                     |   24 +-
 kernel/workqueue.c                            |  755 +++++++++--
 lib/cmdline_kunit.c                           |    2 +-
 lib/kunit/device.c                            |    4 +
 lib/kunit/executor_test.c                     |    2 +-
 lib/memcpy_kunit.c                            |    4 +-
 lib/stackdepot.c                              |   16 +-
 lib/test_blackhole_dev.c                      |    3 +-
 mm/shmem.c                                    |    2 +-
 net/bluetooth/Kconfig                         |    8 -
 net/bluetooth/Makefile                        |    1 -
 net/bluetooth/a2mp.c                          | 1054 ---------------
 net/bluetooth/a2mp.h                          |  154 ---
 net/bluetooth/af_bluetooth.c                  |   10 +-
 net/bluetooth/amp.c                           |  590 --------
 net/bluetooth/amp.h                           |   60 -
 net/bluetooth/eir.c                           |   29 +-
 net/bluetooth/hci_conn.c                      |    6 +-
 net/bluetooth/hci_core.c                      |  126 +-
 net/bluetooth/hci_event.c                     |   43 +-
 net/bluetooth/hci_request.c                   |    2 +-
 net/bluetooth/hci_sync.c                      |   41 +-
 net/bluetooth/l2cap_core.c                    | 1069 +--------------
 net/bluetooth/l2cap_sock.c                    |   18 +-
 net/bluetooth/mgmt.c                          |   97 +-
 net/bluetooth/msft.c                          |    3 +
 net/core/dev.c                                |    8 +-
 net/core/gso_test.c                           |    2 +-
 net/core/skbuff.c                             |    8 +
 net/core/sock_diag.c                          |   10 +-
 net/devlink/netlink.c                         |   13 +-
 net/devlink/netlink_gen.c                     |    2 +-
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
 net/kcm/kcmsock.c                             |    3 +-
 net/l2tp/l2tp_ppp.c                           |    4 +-
 net/mac80211/mlme.c                           |    4 +-
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
 net/wireless/scan.c                           |  161 ++-
 net/wireless/tests/scan.c                     |   36 +-
 net/x25/af_x25.c                              |    4 +-
 net/xfrm/xfrm_device.c                        |    3 +-
 scripts/coccinelle/api/device_attr_show.cocci |    2 +-
 scripts/kconfig/lexer.l                       |    7 +-
 sound/core/seq/seq_midi.c                     |    8 +-
 sound/core/seq/seq_virmidi.c                  |    9 +-
 sound/pci/hda/cs35l41_hda_property.c          |   16 +-
 sound/pci/hda/patch_realtek.c                 |   63 +
 sound/pci/hda/tas2781_hda_i2c.c               |   35 +-
 sound/soc/amd/acp/acp-sof-mach.c              |   14 +-
 sound/soc/codecs/tlv320adc3xxx.c              |    4 +-
 sound/soc/intel/boards/sof_ssp_common.h       |    8 +
 sound/soc/meson/aiu.c                         |   19 +-
 sound/soc/meson/aiu.h                         |    1 -
 sound/soc/meson/axg-tdm-interface.c           |   29 +-
 sound/soc/meson/t9015.c                       |   20 +-
 sound/soc/rockchip/rockchip_i2s_tdm.c         |  352 +----
 sound/soc/sh/rz-ssi.c                         |    2 +-
 sound/soc/sof/amd/acp-loader.c                |   34 +-
 sound/soc/sof/amd/acp.c                       |   47 +-
 sound/soc/sof/amd/acp.h                       |    7 +-
 sound/soc/sof/amd/vangogh.c                   |    9 +-
 sound/soc/sof/fw-file-profile.c               |   18 +-
 sound/soc/sof/ipc3-loader.c                   |    2 +
 sound/usb/mixer_scarlett2.c                   |   88 +-
 sound/usb/stream.c                            |    5 +-
 tools/bpf/bpftool/link.c                      |    2 +-
 tools/bpf/bpftool/prog.c                      |    2 +-
 tools/bpf/resolve_btfids/main.c               |   70 +-
 tools/include/linux/btf_ids.h                 |    9 +
 tools/lib/bpf/bpf.c                           |   17 +
 tools/lib/bpf/bpf.h                           |   26 +-
 tools/lib/bpf/btf.c                           |   11 +-
 tools/lib/bpf/libbpf.c                        |   25 +-
 tools/lib/bpf/libbpf.map                      |    6 +-
 tools/lib/bpf/libbpf_internal.h               |   14 +
 tools/lib/bpf/linker.c                        |    2 +-
 tools/lib/bpf/netlink.c                       |    4 +-
 tools/objtool/check.c                         |   12 +
 tools/perf/Makefile.perf                      |    2 +-
 tools/perf/builtin-record.c                   |    7 +-
 .../pmu-events/arch/x86/amdzen4/cache.json    |   56 +
 tools/perf/pmu-events/jevents.py              |    4 +
 tools/perf/util/data.c                        |    2 -
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
 .../selftests/bpf/prog_tests/tc_redirect.c    |   90 +-
 .../selftests/bpf/progs/test_map_in_map.c     |   26 +
 tools/testing/selftests/bpf/test_maps.c       |    6 +-
 tools/testing/selftests/bpf/trace_helpers.c   |    2 +-
 tools/testing/selftests/net/forwarding/config |   35 +
 .../net/forwarding/vxlan_bridge_1d_ipv6.sh    |    4 +-
 .../net/forwarding/vxlan_bridge_1q_ipv6.sh    |    4 +-
 725 files changed, 8780 insertions(+), 7598 deletions(-)
 rename arch/arm64/boot/dts/qcom/{pm2250.dtsi => pm4125.dtsi} (91%)
 delete mode 100644 arch/sparc/lib/cmpdi2.c
 delete mode 100644 arch/sparc/lib/ucmpdi2.c
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-usbc.c
 delete mode 100644 net/bluetooth/a2mp.c
 delete mode 100644 net/bluetooth/a2mp.h
 delete mode 100644 net/bluetooth/amp.c
 delete mode 100644 net/bluetooth/amp.h

-- 
2.43.0


