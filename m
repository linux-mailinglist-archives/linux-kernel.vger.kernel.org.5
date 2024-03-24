Return-Path: <linux-kernel+bounces-114718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A94A9889421
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:47:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8095AB2AF54
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F0C413B59D;
	Mon, 25 Mar 2024 00:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LhXhKblc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5AC174940;
	Sun, 24 Mar 2024 23:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323302; cv=none; b=YBBuCg7o/P3H/+lD3oLOn0EIoFnj2c52E9GU4ZTSo3K9vFXH/Yq8vWrOFYGNfelx04egbdWS1R2HhieQ+qujUJ96mGtWJF7ru/1vI2pZCxMi/JOSbLv52HnzSwU2SqkZZ/Uzj1NV1WrwI6VULY+phaM1O3hPmgTZy14ZR99LdZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323302; c=relaxed/simple;
	bh=JbQPyZRFj3y77G/dnd4C0Ypaay5BpJeaJXzqVawFG7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XMxd9EuiINd9U5k+hR2mGRjf50Q7bgzdK1pO6TfgBRBQjFBEv9cVLyBYC+yq05hBo1MkscVBrkCxozQZVRpbw4wV9qoxbTPrxkCRd/Kn1AB6AcAphB/9Xp3ohzwrZksQxSa+JtYgu4l0a0m70YK6+4SDnk7u2jq6uPqTVID5c8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LhXhKblc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36229C433C7;
	Sun, 24 Mar 2024 23:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323300;
	bh=JbQPyZRFj3y77G/dnd4C0Ypaay5BpJeaJXzqVawFG7Q=;
	h=From:To:Cc:Subject:Date:From;
	b=LhXhKblcXFp95zJWElGbmjmujxvK6qESUtctC29LveryGx0pcPIKtc07JCC2z+f9i
	 G+h+uPJg8byjTZ/oxZmrUEXI8EFooiB7QytMG6Cw7FKMmMT4ln778XzqqR01nVmpnV
	 17GUiZslvH/w+YkOHxilBFKWpNI5ej4vcfI5GsREoJvSOSxt2krMvzW6HQgI8vqtlg
	 Au9yKBM7TqlU1eBvJBgJ7Gd+hOARB+5jdmNq+8n0FkDPormT6U/zH/DQH3K3L4Ww+g
	 ClkiLu+yKlcAUOy00wWBi4HNJz1l7YfHkRJ2C+ZJxY5PuxdcxgVk8IszHS6P5YIeny
	 Ymp8k9MUIayhA==
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
Subject: [PATCH 5.15 000/317] 5.15.153-rc1 review
Date: Sun, 24 Mar 2024 19:29:40 -0400
Message-ID: <20240324233458.1352854-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.153-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.15.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.15.153-rc1
X-KernelTest-Deadline: 2024-03-26T23:34+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit


This is the start of the stable review cycle for the 5.15.153 release.
There are 317 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Tue Mar 26 11:34:43 PM UTC 2024.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
        https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/patch/?id=linux-5.15.y&id2=v5.15.152
or in the git tree and branch at:
        git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
and the diffstat can be found below.

Thanks,
Sasha

-------------
Pseudo-Shortlog of commits:

Ajay Singh (1):
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

Alexis Lothoré (3):
  wifi: wilc1000: fix declarations ordering
  wifi: wilc1000: fix RCU usage in connect path
  wifi: wilc1000: prevent use-after-free on vif when cleaning up all
    interfaces

Anastasia Belova (1):
  cpufreq: brcmstb-avs-cpufreq: add check for cpufreq_cpu_get's return
    value

Andrew Ballance (1):
  gen_compile_commands: fix invalid escape sequence warning

Andrey Grafin (2):
  libbpf: Apply map_set_def_max_entries() for inner_maps on creation
  selftest/bpf: Add map_in_maps with BPF_MAP_TYPE_PERF_EVENT_ARRAY
    values

Andy Shevchenko (1):
  serial: 8250_exar: Don't remove GPIO device on suspend

AngeloGioacchino Del Regno (1):
  drm/mediatek: dsi: Fix DSI RGB666 formats and definitions

Armin Wolf (1):
  ACPI: processor_idle: Fix memory leak in acpi_processor_power_exit()

Arnaud Pouliquen (2):
  remoteproc: stm32: Fix incorrect type in assignment for va
  remoteproc: stm32: Fix incorrect type assignment returned by
    stm32_rproc_get_loaded_rsc_tablef

Arnd Bergmann (11):
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

Arınç ÜNAL (5):
  net: dsa: mt7530: prevent possible incorrect XTAL frequency selection
  net: dsa: mt7530: fix handling of LLDP frames
  net: dsa: mt7530: fix handling of 802.1X PAE frames
  net: dsa: mt7530: fix link-local frames that ingress vlan filtering
    ports
  net: dsa: mt7530: fix handling of all link-local frames

Athaariq Ardhiansyah (1):
  ALSA: hda/realtek: fix ALC285 issues on HP Envy x360 laptops

Baokun Li (1):
  quota: simplify drop_dquot_ref()

Bartosz Golaszewski (1):
  Bluetooth: hci_qca: don't use IS_ERR_OR_NULL() with
    gpiod_get_optional()

Baruch Siach (1):
  mtd: maps: physmap-core: fix flash size larger than 32-bit

Basavaraj Natikar (1):
  HID: amd_sfh: Update HPD sensor structure elements

Ben Wolsieffer (1):
  watchdog: stm32_iwdg: initialize default timeout

Bitterblue Smith (1):
  wifi: rtw88: 8821c: Fix false alarm count

Breno Leitao (1):
  net: blackhole_dev: fix build warning for ethh set but not used

Bryan O'Donoghue (1):
  clk: Fix clk_core_get NULL dereference

Cai Huoqing (1):
  drm/tegra: dsi: Make use of the helper function dev_err_probe()

Changbin Du (1):
  modules: wait do_free_init correctly

Chao Yu (5):
  f2fs: multidevice: support direct IO
  f2fs: fix to invalidate META_MAPPING before DIO write
  f2fs: invalidate meta pages only for post_read required inode
  f2fs: reduce stack memory cost by using bitfield in struct
    f2fs_io_info
  f2fs: compress: fix to cover normal cluster write with cp_rwsem

Chen Ni (2):
  sr9800: Add check for usbnet_get_endpoints
  drm/tegra: dsi: Add missing check for of_find_device_by_node

Chen-Yu Tsai (1):
  pinctrl: mediatek: Drop bogus slew rate register range for MT8192

Christian König (1):
  drm/ttm: add ttm_resource_fini v2

Christophe JAILLET (13):
  wireless: Remove redundant 'flush_workqueue()' calls
  mmc: wmt-sdmmc: remove an incorrect release_mem_region() call in the
    .remove function
  drm/tegra: dsi: Fix some error handling paths in tegra_dsi_probe()
  drm/tegra: dsi: Fix missing pm_runtime_disable() in the error handling
    path of tegra_dsi_probe()
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
  net: sunrpc: Fix an off by one in rpc_sockaddr2uaddr()
  NFS: Fix an off by one in root_nfs_cat()

Christophe Leroy (1):
  powerpc: Force inlining of arch_vmap_p{u/m}d_supported()

Chun-Yi Lee (1):
  aoe: fix the potential use-after-free problem in aoecmd_cfg_pkts

Colin Ian King (1):
  usb: gadget: net2272: Use irqflags in the call to net2272_probe_fin

Conor Dooley (1):
  riscv: dts: sifive: add missing #interrupt-cells to pmic

Dan Carpenter (1):
  staging: greybus: fix get_channel_from_mode() failure path

Daniel Golle (2):
  net: mediatek: mtk_eth_soc: clear MAC_MCR_FORCE_LINK only when MAC is
    up
  net: ethernet: mtk_eth_soc: fix PPE hanging issue

Daniel Thompson (3):
  backlight: da9052: Fully initialize backlight_properties during probe
  backlight: lm3639: Fully initialize backlight_properties during probe
  backlight: lp8788: Fully initialize backlight_properties during probe

Daniil Dulov (2):
  media: go7007: add check of return value of go7007_read_addr()
  media: pvrusb2: remove redundant NULL check

Dave Airlie (1):
  nouveau: reset the bo resource bus info after an eviction

David Gow (3):
  lib/cmdline: Fix an invalid format specifier in an assertion msg
  time: test: Fix incorrect format specifier
  rtc: test: Fix invalid format specifier.

David Howells (1):
  afs: Revert "afs: Hide silly-rename files from userspace"

David McFarland (1):
  ACPI: resource: Add Infinity laptops to irq1_edge_low_force_override

Dmitry Baryshkov (2):
  arm64: dts: qcom: msm8998: switch USB QMP PHY to new style of bindings
  arm64: dts: qcom: msm8998: declare VLS CLAMP register for USB3 PHY

Dmitry Osipenko (1):
  drm/tegra: dc: rgb: Allow changing PLLD rate on Tegra30+

Duoming Zhou (2):
  nfp: flower: handle acti_netdevs allocation failure
  clk: zynq: Prevent null pointer dereference caused by kmalloc failure

Edward Adam Davis (1):
  media: pvrusb2: fix uaf in pvr2_context_set_notify

Eric Biggers (1):
  f2fs: implement iomap operations

Eric Dumazet (5):
  sock_diag: annotate data-races around sock_diag_handlers[family]
  inet_diag: annotate data-races around inet_diag_table[]
  ipv6: mcast: remove one synchronize_net() barrier in ipv6_mc_down()
  net: ip_tunnel: make sure to pull inner header in ip_tunnel_rcv()
  packet: annotate data-races around ignore_outgoing

Ethan Zhao (2):
  PCI: Make pci_dev_is_disconnected() helper public for other drivers
  iommu/vt-d: Don't issue ATS Invalidation request when device is
    disconnected

Fedor Pchelkin (1):
  drm/tegra: put drm_gem_object ref on error in tegra_fb_create

Fei Shao (1):
  spi: spi-mt65xx: Fix NULL pointer access in interrupt handler

Felix Maurer (1):
  hsr: Handle failures in module init

Filipe Manana (1):
  btrfs: add and use helper to check if block group is used

Frank Li (1):
  PCI: endpoint: Support NTB transfer between RC and EP

Frieder Schrempf (5):
  arm64: dts: imx8mm-kontron: Disable pullups for I2C signals on SL/BL
    i.MX8MM
  arm64: dts: imx8mm-kontron: Disable pullups for onboard UART signals
    on BL board
  arm64: dts: imx8mm-kontron: Add support for ultra high speed modes on
    SD card
  arm64: dts: imx8mm-kontron: Use the VSELECT signal to switch SD card
    IO voltage
  arm64: dts: imx8mm-kontron: Disable pull resistors for SD card signals
    on BL board

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

Geert Uytterhoeven (4):
  ARM: dts: renesas: r8a73a4: Fix external clocks and clock rate
  ARM: dts: arm: realview: Fix development chip ROM compatible value
  arm64: dts: renesas: r8a779a0: Update to R-Car Gen4 compatible values
  arm64: dts: renesas: r8a779a0: Correct avb[01] reg sizes

George Stark (1):
  leds: aw2013: Unlock mutex before destroying it

Greg Joyce (1):
  block: sed-opal: handle empty atoms when parsing response

Hans de Goede (1):
  ASoC: rt5645: Make LattePanda board DMI match more precise

Harry Wentland (1):
  drm: Don't treat 0 as -1 in drm_fixp2int_ceil

Hou Tao (3):
  bpf: Defer the free of inner map when necessary
  x86/mm: Move is_vsyscall_vaddr() into asm/vsyscall.h
  x86/mm: Disallow vsyscall page read for copy_from_kernel_nofault()

Hsin-Yi Wang (2):
  arm64: dts: mt8183: kukui: Split out keyboard node and describe
    detachables
  drm/mediatek: Fix a null pointer crash in
    mtk_drm_crtc_finish_page_flip

Hugo Villeneuve (1):
  serial: max310x: fix syntax error in IRQ error message

Hyeong-Jun Kim (1):
  f2fs: invalidate META_MAPPING before IPU/DIO write

Ian Abbott (1):
  comedi: comedi_test: Prevent timers rescheduling during deletion

Ian Rogers (1):
  perf stat: Avoid metric-only segv

Ignat Korchagin (1):
  net: veth: do not manipulate GRO when using XDP

Igor Prusov (1):
  clk: meson: Add missing clocks to axg_clk_regmaps

Ilpo Järvinen (1):
  PCI/DPC: Print all TLP Prefixes, not just the first

Jakub Kicinski (1):
  selftests: tls: use exact comparison in recv_partial

Jan Höppner (1):
  s390/dasd: Use dev_*() for device log messages

Jan Kara (1):
  quota: Fix rcu annotations of inode dquot pointers

Jens Axboe (3):
  io_uring/unix: drop usage of io_uring socket
  io_uring: drop any code related to SCM_RIGHTS
  io_uring: don't save/restore iowait state

Jernej Skrabec (3):
  media: sun8i-di: Fix coefficient writes
  media: sun8i-di: Fix power on/off sequences
  media: sun8i-di: Fix chroma difference threshold

Jerome Brunet (4):
  ASoC: meson: aiu: fix function pointer type mismatch
  ASoC: meson: t9015: fix function pointer type mismatch
  ASoC: meson: axg-tdm-interface: fix mclk setup without mclk-fs
  ASoC: meson: axg-tdm-interface: add frame rate constraint

Jiaxun Yang (1):
  MIPS: Clear Cause.BD in instruction_pointer_set

Jie Wang (1):
  net: hns3: fix port duplex configure error in IMP reset

Jinjie Ruan (1):
  wifi: mwifiex: debugfs: Drop unnecessary error check for
    debugfs_create_dir()

Jiri Slaby (SUSE) (1):
  tty: vt: fix 20 vs 0x20 typo in EScsiignore

Johan Carlsson (1):
  ALSA: usb-audio: Stop parsing channels bits when all channels are
    found.

Johan Hovold (2):
  arm64: dts: qcom: msm8998: drop USB PHY clock index
  PCI/AER: Fix rootport attribute paths in ABI docs

Johannes Berg (3):
  wifi: iwlwifi: mvm: report beacon protection failures
  wifi: iwlwifi: dbg-tlv: ensure NUL termination
  wifi: iwlwifi: mvm: don't set replay counters to 0xff

Jonah Palmer (1):
  vdpa/mlx5: Allow CVQ size changes

Jonas Dreßler (1):
  Bluetooth: Remove superfluous call to hci_conn_check_pending()

Jorge Mora (2):
  NFSv4.2: fix nfs4_listxattr kernel BUG at mm/usercopy.c:102
  NFSv4.2: fix listxattr maximum XDR buffer size

Jörg Wedekind (1):
  PCI: Mark 3ware-9650SE Root Port Extended Tags as broken

Kailang Yang (1):
  ALSA: hda/realtek - ALC285 reduce pop noise from Headphone port

Kajol Jain (1):
  powerpc/hv-gpci: Fix the H_GET_PERF_COUNTER_INFO hcall return value
    checks

Kamal Heib (1):
  net: ena: Remove ena_select_queue

Kees Cook (1):
  x86, relocs: Ignore relocations in .notes section

Keisuke Nishimura (1):
  sched/fair: Take the scheduling domain into account in
    select_idle_core()

Konrad Dybcio (3):
  clk: qcom: reset: Commonize the de/assert functions
  clk: qcom: reset: Ensure write completion on reset de/assertion
  clk: qcom: dispcc-sdm845: Adjust internal GDSC wait times

Kuninori Morimoto (1):
  ASoC: meson: Use dev_err_probe() helper

Kuniyuki Iwashima (1):
  af_unix: Annotate data-race of gc_in_progress in wait_for_unix_gc().

Kunwu Chan (1):
  x86/xen: Add some null pointer checking to smp.c

Kévin L'hôpital (1):
  net: phy: fix phy_get_internal_delay accessing an empty array

Leon Romanovsky (1):
  RDMA/mlx5: Fix fortify source warning while accessing Eth segment

Li Nan (1):
  md: Don't clear MD_CLOSING when the raid is about to stop

Linu Cherian (1):
  octeontx2-af: Use matching wake_up API variant in CGX command
    interface

Luca Weiss (2):
  backlight: lm3630a: Initialize backlight_properties on init
  backlight: lm3630a: Don't set bl->props.brightness in get_brightness

Lucas Stach (1):
  media: imx: csc/scaler: fix v4l2_ctrl_handler memory leak

Luiz Augusto von Dentz (1):
  Bluetooth: hci_core: Fix possible buffer overflow

Manuel Fombuena (1):
  HID: multitouch: Add required quirk for Synaptics 0xcddc device

Marek Vasut (1):
  regmap: Add missing map->bus check

Mario Limonciello (1):
  iommu/amd: Mark interrupt as managed

Martin KaFai Lau (3):
  net: Change sock_getsockopt() to take the sk ptr instead of the sock
    ptr
  bpf: net: Change sk_getsockopt() to take the sockptr_t argument
  bpf: net: Change do_ip_getsockopt() to take the sockptr_t argument

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

Mikulas Patocka (2):
  dm-verity, dm-crypt: align "struct bvec_iter" correctly
  dm: call the resume method on internal suspend

Ming Lei (1):
  dm raid: fix false positive for requeue needed during reshape

Miri Korenblit (1):
  wifi: iwlwifi: fix EWRD table validity check

Miroslav Franc (1):
  s390/dasd: fix double module refcount decrement

Nathan Chancellor (1):
  s390/vdso: drop '-fPIC' from LDFLAGS

Navid Emamdoost (1):
  nbd: null check for nla_nest_start

NeilBrown (1):
  f2fs: replace congestion_wait() calls with io_schedule_timeout()

Nikita Kiryushin (1):
  net: phy: fix phy_read_poll_timeout argument type in genphy_loopback

Nikita Zhandarovich (4):
  do_sys_name_to_handle(): use kzalloc() to fix kernel-infoleak
  media: em28xx: annotate unchecked call to media_device_register()
  drm/radeon/ni: Fix wrong firmware size logging in ni_init_microcode()
  wireguard: receive: annotate data-race around
    receiving_counter.counter

Nícolas F. R. A. Prado (3):
  cpufreq: mediatek-hw: Wait for CPU supplies before probing
  cpufreq: mediatek-hw: Don't error out if supply is not found
  arm64: dts: mt8183: Move CrosEC base detection node to kukui-based DTs

Ondrej Jirman (1):
  leds: sgm3140: Add missing timer cleanup and flash gpio control

Pablo Neira Ayuso (2):
  netfilter: nft_set_pipapo: release elements in clone only from destroy
    path
  netfilter: nf_tables: do not compare internal table flags on updates

Paloma Arellano (1):
  drm/msm/dpu: add division of drm_display_mode's hskew parameter

Paul E. McKenney (1):
  rcu-tasks: Provide rcu_trace_implies_rcu_gp()

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

Petr Mladek (1):
  printk: Disable passing console lock owner completely during panic()

Prashant Malani (1):
  arm64: dts: mt8183: kukui: Add Type C node

Prike Liang (1):
  drm/amdgpu: Enable gpu reset for S3 abort cases on Raven series

Quanyang Wang (1):
  crypto: xilinx - call finalize with bh disabled

Quentin Schulz (2):
  drm/rockchip: lvds: do not overwrite error code
  drm/rockchip: lvds: do not print scary message when probing defer

Rafael J. Wysocki (1):
  ACPI: scan: Fix device check notification handling

Rafał Miłecki (3):
  arm64: dts: mediatek: mt7622: add missing "device_type" to memory
    nodes
  arm64: dts: marvell: reorder crypto interrupts on Armada SoCs
  arm64: dts: broadcom: bcmbca: bcm4908: drop invalid switch cells

Rahul Rameshbabu (4):
  wifi: b43: Stop/wake correct queue in DMA Tx path when QoS is disabled
  wifi: b43: Stop/wake correct queue in PIO Tx path when QoS is disabled
  wifi: b43: Stop correct queue in DMA worker when QoS is disabled
  wifi: b43: Disable QoS for bcm4331

Randy Dunlap (1):
  rtc: mt6397: select IRQ_DOMAIN instead of depending on it

Ranjan Kumar (1):
  scsi: mpt3sas: Prevent sending diag_reset when the controller is ready

Rob Herring (1):
  cpufreq: Explicitly include correct DT includes

Russell King (Oracle) (1):
  net: mtk_eth_soc: move MAC_MCR setting to mac_finish()

Ruud Bos (1):
  igb: move PEROUT and EXTTS isr logic to separate functions

Sam Ravnborg (1):
  sparc32: Fix section mismatch in leon_pci_grpci

Saravana Kannan (1):
  module: Add support for default value for module async_probe

Sasha Levin (1):
  Linux 5.15.153-rc1

Shawn Guo (1):
  arm64: dts: qcom: msm8996: Move '#clock-cells' to QMP PHY child node

Sheng Yong (1):
  f2fs: compress: fix to check unreleased compressed cluster

Shifeng Li (1):
  RDMA/device: Fix a race between mad_client and cm_client init

Shigeru Yoshida (1):
  hsr: Fix uninit-value access in hsr_get_node()

Shiming Cheng (1):
  ipv6: fib6_rules: flush route cache when rule is changed

Srinivasan Shanmugam (3):
  drm/amd/display: Fix a potential buffer overflow in
    'dp_dsc_clock_en_read()'
  drm/amd/display: Fix potential NULL pointer dereferences in
    'dcn10_set_output_transfer_func()'
  drm/amdgpu: Fix missing break in ATOM_ARG_IMM Case of
    atom_get_src_int()

Steev Klimaszewski (1):
  Bluetooth: hci_qca: Add support for QTI Bluetooth chip wcn6855

Stefan Haberland (4):
  s390/dasd: put block allocation in separate function
  s390/dasd: add query PPRC function
  s390/dasd: add copy pair setup
  s390/dasd: add autoquiesce feature

Stephen Brennan (1):
  printk: Add panic_in_progress helper

Stuart Henderson (3):
  ASoC: wm8962: Enable oscillator if selecting WM8962_FLL_OSC
  ASoC: wm8962: Enable both SPKOUTR_ENA and SPKOUTL_ENA in mono mode
  ASoC: wm8962: Fix up incorrect error message in wm8962_set_fll

Subbaraya Sundeep (1):
  octeontx2-af: Use separate handlers for interrupts

Takashi Iwai (1):
  ALSA: seq: fix function cast warnings

Takashi Sakamoto (1):
  firewire: core: use long bus reset on gap count error

Thierry Reding (1):
  drm/tegra: dpaux: Populate AUX bus

Thinh Tran (1):
  net/bnx2x: Prevent access to a freed page in page_pool

Thomas Zimmermann (1):
  arch/powerpc: Remove <linux/fb.h> from backlight code

Tiezhu Yang (1):
  bpftool: Silence build warning about calloc()

Tim Harvey (1):
  arm64: dts: imx8mm-venice-gw71xx: fix USB OTG VBUS

Tim Pambor (1):
  net: phy: dp83822: Fix RGMII TX delay configuration

Toke Høiland-Jørgensen (4):
  wifi: ath9k: delay all of ath9k_wmi_event_tasklet() until init is
    complete
  bpf: Fix DEVMAP_HASH overflow check on 32-bit arches
  bpf: Fix hashtab overflow check on 32-bit arches
  bpf: Fix stackmap overflow check on 32-bit arches

Tomi Valkeinen (1):
  drm/tidss: Fix initial plane zpos values

Tommaso Merciai (1):
  net: phy: DP83822: enable rgmii mode if phy_interface_is_rgmii

Tudor Ambarus (1):
  tty: serial: samsung: fix tx_empty() to return TIOCSER_TEMT

Uwe Kleine-König (6):
  Input: gpio_keys_polled - suppress deferred probe error for gpio
  pwm: atmel-hlcdc: Convert to platform remove callback returning void
  pwm: atmel-hlcdc: Use consistent variable naming
  pwm: atmel-hlcdc: Fix clock imbalance related to suspend support
  pwm: sti: Implement .apply() callback
  pwm: sti: Fix capture for st,pwm-num-chan < st,capture-num-chan

Vinicius Costa Gomes (1):
  igb: Fix missing time sync events

Viresh Kumar (1):
  OPP: debugfs: Fix warning around icc_get_name()

Wang Jianjian (1):
  quota: Fix potential NULL pointer dereference

William Kucharski (1):
  RDMA/srpt: Do not register event handler until srpt device is fully
    setup

Xingyuan Mo (1):
  wifi: ath10k: fix NULL pointer dereference in
    ath10k_wmi_tlv_op_pull_mgmt_tx_compl_ev()

Xiuhong Wang (1):
  f2fs: compress: fix reserve_cblocks counting error when out of space

Yan Zhai (3):
  rcu: add a helper to report consolidated flavor QS
  net: report RCU QS on threaded NAPI repolling
  bpf: report RCU QS in cpumap kthread

Yang Jihong (3):
  perf record: Fix possible incorrect free in record__switch_output()
  perf evsel: Fix duplicate initialization of data->id in
    evsel__parse_sample()
  perf thread_map: Free strlist on normal path in
    thread_map__new_by_tid_str()

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

 .../testing/sysfs-bus-pci-devices-aer_stats   |    6 +-
 .../admin-guide/kernel-parameters.txt         |   17 +-
 Makefile                                      |    4 +-
 arch/arm/boot/dts/arm-realview-pb1176.dts     |    2 +-
 arch/arm/boot/dts/imx6dl-yapp4-common.dtsi    |   28 +-
 arch/arm/boot/dts/r8a73a4-ape6evm.dts         |   12 +
 arch/arm/boot/dts/r8a73a4.dtsi                |    9 +-
 arch/arm/crypto/sha256_glue.c                 |   13 +-
 arch/arm/crypto/sha512-glue.c                 |   12 +-
 .../boot/dts/broadcom/bcmbca/bcm4908.dtsi     |    3 -
 .../dts/freescale/imx8mm-kontron-n801x-s.dts  |   55 +-
 .../freescale/imx8mm-kontron-n801x-som.dtsi   |    4 +-
 .../dts/freescale/imx8mm-venice-gw71xx.dtsi   |   29 +-
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi  |   10 +-
 arch/arm64/boot/dts/marvell/armada-cp11x.dtsi |   10 +-
 .../dts/mediatek/mt7622-bananapi-bpi-r64.dts  |    1 +
 arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts  |    1 +
 .../dts/mediatek/mt8183-kukui-jacuzzi.dtsi    |    2 +
 .../dts/mediatek/mt8183-kukui-kakadu.dtsi     |   10 +
 .../dts/mediatek/mt8183-kukui-kodama.dtsi     |   10 +
 .../boot/dts/mediatek/mt8183-kukui-krane.dtsi |   10 +
 .../arm64/boot/dts/mediatek/mt8183-kukui.dtsi |   15 +-
 arch/arm64/boot/dts/qcom/ipq8074.dtsi         |    4 +-
 arch/arm64/boot/dts/qcom/msm8996.dtsi         |    4 +-
 arch/arm64/boot/dts/qcom/msm8998.dtsi         |   42 +-
 arch/arm64/boot/dts/qcom/sm8350.dtsi          |    3 -
 arch/arm64/boot/dts/renesas/r8a779a0.dtsi     |   28 +-
 arch/mips/include/asm/ptrace.h                |    1 +
 arch/parisc/kernel/ftrace.c                   |    2 +-
 arch/powerpc/include/asm/backlight.h          |    5 +-
 arch/powerpc/include/asm/vmalloc.h            |    4 +-
 arch/powerpc/perf/hv-gpci.c                   |   29 +-
 .../platforms/embedded6xx/linkstation.c       |    3 -
 arch/powerpc/platforms/embedded6xx/mpc10x.h   |    3 +
 arch/powerpc/platforms/powermac/backlight.c   |   26 -
 .../boot/dts/sifive/hifive-unmatched-a00.dts  |    1 +
 arch/s390/include/uapi/asm/dasd.h             |    2 +
 arch/s390/kernel/vdso32/Makefile              |    2 +-
 arch/s390/kernel/vdso64/Makefile              |    2 +-
 arch/s390/kernel/vtime.c                      |    4 +-
 arch/sparc/kernel/leon_pci_grpci1.c           |    2 +-
 arch/sparc/kernel/leon_pci_grpci2.c           |    2 +-
 arch/x86/include/asm/vsyscall.h               |   10 +
 arch/x86/mm/fault.c                           |    9 -
 arch/x86/mm/maccess.c                         |   10 +
 arch/x86/tools/relocs.c                       |    8 +
 arch/x86/xen/smp.c                            |   12 +
 block/opal_proto.h                            |    1 +
 block/sed-opal.c                              |    6 +-
 drivers/acpi/processor_idle.c                 |    2 +
 drivers/acpi/resource.c                       |   33 +
 drivers/acpi/scan.c                           |    8 +-
 drivers/base/regmap/regmap.c                  |    2 +-
 drivers/block/aoe/aoecmd.c                    |   12 +-
 drivers/block/aoe/aoenet.c                    |    1 +
 drivers/block/nbd.c                           |    6 +
 drivers/bluetooth/btqca.c                     |   14 +-
 drivers/bluetooth/btqca.h                     |   10 +
 drivers/bluetooth/hci_qca.c                   |   59 +-
 drivers/bus/Kconfig                           |    5 +-
 drivers/clk/clk.c                             |    3 +
 drivers/clk/hisilicon/clk-hi3519.c            |    2 +-
 drivers/clk/hisilicon/clk-hi3559a.c           |    1 -
 drivers/clk/meson/axg.c                       |    2 +
 drivers/clk/qcom/dispcc-sdm845.c              |    2 +
 drivers/clk/qcom/reset.c                      |   27 +-
 drivers/clk/zynq/clkc.c                       |    8 +-
 drivers/comedi/drivers/comedi_test.c          |   30 +-
 drivers/cpufreq/armada-37xx-cpufreq.c         |    4 +-
 drivers/cpufreq/brcmstb-avs-cpufreq.c         |    2 +
 drivers/cpufreq/mediatek-cpufreq-hw.c         |   22 +-
 drivers/cpufreq/ppc_cbe_cpufreq.c             |    2 +-
 drivers/cpufreq/ppc_cbe_cpufreq_pmi.c         |    1 -
 drivers/cpufreq/qcom-cpufreq-nvmem.c          |    1 -
 drivers/cpufreq/scpi-cpufreq.c                |    2 +-
 drivers/cpufreq/sti-cpufreq.c                 |    2 +-
 drivers/cpufreq/ti-cpufreq.c                  |    2 +-
 drivers/cpufreq/vexpress-spc-cpufreq.c        |    1 -
 drivers/crypto/xilinx/zynqmp-aes-gcm.c        |    3 +
 drivers/dma/Kconfig                           |   14 +-
 drivers/firewire/core-card.c                  |   14 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c   |    2 +
 .../gpu/drm/amd/amdgpu/amdgpu_preempt_mgr.c   |    1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c  |    2 +
 drivers/gpu/drm/amd/amdgpu/atom.c             |    2 +-
 drivers/gpu/drm/amd/amdgpu/soc15.c            |   45 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c |    2 +-
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c |    7 +-
 drivers/gpu/drm/i915/i915_ttm_buddy_manager.c |    2 +
 drivers/gpu/drm/lima/lima_gem.c               |   23 +-
 drivers/gpu/drm/mediatek/mtk_drm_crtc.c       |   12 +-
 drivers/gpu/drm/mediatek/mtk_dsi.c            |   10 +-
 .../drm/msm/disp/dpu1/dpu_encoder_phys_vid.c  |    6 +-
 drivers/gpu/drm/nouveau/nouveau_bo.c          |    2 +
 drivers/gpu/drm/nouveau/nouveau_mem.c         |    3 +-
 drivers/gpu/drm/nouveau/nouveau_mem.h         |    3 +-
 drivers/gpu/drm/nouveau/nouveau_ttm.c         |    9 +-
 drivers/gpu/drm/radeon/ni.c                   |    2 +-
 drivers/gpu/drm/rockchip/inno_hdmi.c          |    4 +-
 drivers/gpu/drm/rockchip/rockchip_lvds.c      |    3 +-
 drivers/gpu/drm/tegra/Kconfig                 |    1 +
 drivers/gpu/drm/tegra/dc.c                    |   27 +-
 drivers/gpu/drm/tegra/dc.h                    |    1 +
 drivers/gpu/drm/tegra/dpaux.c                 |   19 +-
 drivers/gpu/drm/tegra/dsi.c                   |   47 +-
 drivers/gpu/drm/tegra/fb.c                    |    1 +
 drivers/gpu/drm/tegra/output.c                |   16 +-
 drivers/gpu/drm/tegra/rgb.c                   |   63 +-
 drivers/gpu/drm/tidss/tidss_plane.c           |    2 +-
 drivers/gpu/drm/ttm/ttm_range_manager.c       |    2 +
 drivers/gpu/drm/ttm/ttm_resource.c            |   23 +
 drivers/gpu/drm/ttm/ttm_sys_manager.c         |    1 +
 drivers/gpu/drm/vmwgfx/vmwgfx_gmrid_manager.c |    7 +-
 .../gpu/drm/vmwgfx/vmwgfx_system_manager.c    |    1 +
 drivers/hid/amd-sfh-hid/amd_sfh_pcie.h        |    6 +-
 drivers/hid/hid-lenovo.c                      |   57 +-
 drivers/hid/hid-multitouch.c                  |    4 +
 drivers/infiniband/core/device.c              |   37 +-
 drivers/infiniband/hw/mlx5/devx.c             |    2 +-
 drivers/infiniband/hw/mlx5/wr.c               |    2 +-
 drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c  |    2 +-
 drivers/infiniband/ulp/srpt/ib_srpt.c         |    3 +-
 drivers/input/keyboard/gpio_keys_polled.c     |   10 +-
 drivers/iommu/amd/init.c                      |    3 +
 drivers/iommu/intel/pasid.c                   |    3 +
 drivers/leds/flash/leds-sgm3140.c             |    3 +
 drivers/leds/leds-aw2013.c                    |    1 +
 drivers/md/dm-crypt.c                         |    4 +-
 drivers/md/dm-raid.c                          |    4 +-
 drivers/md/dm-verity.h                        |    4 +-
 drivers/md/dm.c                               |   26 +-
 drivers/md/md.c                               |   14 +-
 drivers/media/common/v4l2-tpg/v4l2-tpg-core.c |   52 +-
 drivers/media/dvb-core/dvbdev.c               |    5 +
 drivers/media/dvb-frontends/stv0367.c         |   34 +-
 drivers/media/i2c/tc358743.c                  |    7 +-
 drivers/media/pci/ttpci/budget-av.c           |    8 +-
 drivers/media/platform/mtk-mdp/mtk_mdp_vpu.c  |    2 +-
 .../platform/mtk-vcodec/mtk_vcodec_fw_vpu.c   |   10 +-
 drivers/media/platform/mtk-vpu/mtk_vpu.c      |    2 +-
 drivers/media/platform/mtk-vpu/mtk_vpu.h      |    2 +-
 .../media/platform/sunxi/sun8i-di/sun8i-di.c  |   69 +-
 drivers/media/usb/em28xx/em28xx-cards.c       |    4 +
 drivers/media/usb/go7007/go7007-driver.c      |    8 +-
 drivers/media/usb/go7007/go7007-usb.c         |    4 +-
 drivers/media/usb/pvrusb2/pvrusb2-context.c   |   10 +-
 drivers/media/usb/pvrusb2/pvrusb2-dvb.c       |    6 +-
 drivers/media/usb/pvrusb2/pvrusb2-v4l2.c      |   11 +-
 drivers/media/v4l2-core/v4l2-mem2mem.c        |   10 +-
 drivers/mfd/altera-sysmgr.c                   |    4 +-
 drivers/mfd/syscon.c                          |    4 +-
 drivers/mmc/host/wmt-sdmmc.c                  |    4 -
 drivers/mtd/maps/physmap-core.c               |    2 +-
 drivers/mtd/nand/raw/lpc32xx_mlc.c            |    5 +-
 drivers/net/dsa/mt7530.c                      |   56 +-
 drivers/net/dsa/mt7530.h                      |   27 +
 drivers/net/ethernet/amazon/ena/ena_netdev.c  |   17 -
 .../net/ethernet/broadcom/bnx2x/bnx2x_cmn.h   |    6 +-
 .../hisilicon/hns3/hns3pf/hclge_main.c        |    5 +-
 .../hisilicon/hns3/hns3pf/hclge_ptp.c         |    2 +-
 drivers/net/ethernet/intel/igb/igb_main.c     |  112 +-
 .../net/ethernet/marvell/octeontx2/af/cgx.c   |    2 +-
 .../net/ethernet/marvell/octeontx2/af/rvu.c   |   17 +-
 drivers/net/ethernet/mediatek/mtk_eth_soc.c   |   38 +-
 drivers/net/ethernet/mediatek/mtk_ppe.c       |   18 +-
 .../ethernet/netronome/nfp/flower/lag_conf.c  |    5 +
 drivers/net/phy/dp83822.c                     |   38 +-
 drivers/net/phy/phy_device.c                  |    6 +-
 drivers/net/usb/sr9800.c                      |    4 +-
 drivers/net/veth.c                            |   18 -
 drivers/net/wireguard/receive.c               |    6 +-
 drivers/net/wireless/ath/ath10k/core.c        |    3 -
 drivers/net/wireless/ath/ath10k/sdio.c        |    1 -
 drivers/net/wireless/ath/ath10k/wmi-tlv.c     |    4 +
 drivers/net/wireless/ath/ath9k/htc.h          |    2 +-
 drivers/net/wireless/ath/ath9k/htc_drv_init.c |    4 +
 drivers/net/wireless/ath/ath9k/htc_drv_txrx.c |    4 -
 drivers/net/wireless/ath/ath9k/wmi.c          |   10 +-
 drivers/net/wireless/broadcom/b43/b43.h       |   16 +
 drivers/net/wireless/broadcom/b43/dma.c       |    4 +-
 drivers/net/wireless/broadcom/b43/main.c      |   16 +-
 drivers/net/wireless/broadcom/b43/pio.c       |    6 +-
 .../broadcom/brcm80211/brcmsmac/phy/phy_cmn.c |    3 +-
 .../broadcom/brcm80211/brcmsmac/phy_shim.c    |    5 +-
 .../broadcom/brcm80211/brcmsmac/phy_shim.h    |    2 +-
 .../net/wireless/intel/iwlegacy/3945-mac.c    |    1 -
 .../net/wireless/intel/iwlegacy/4965-mac.c    |    1 -
 drivers/net/wireless/intel/iwlwifi/dvm/main.c |    1 -
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c  |    2 +-
 .../net/wireless/intel/iwlwifi/iwl-dbg-tlv.c  |    6 +
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c   |    4 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c |   26 +-
 drivers/net/wireless/marvell/libertas/cmd.c   |   13 +-
 .../net/wireless/marvell/mwifiex/cfg80211.c   |    2 -
 .../net/wireless/marvell/mwifiex/debugfs.c    |    3 -
 drivers/net/wireless/marvell/mwifiex/main.c   |    2 -
 .../wireless/microchip/wilc1000/cfg80211.c    |    1 -
 drivers/net/wireless/microchip/wilc1000/hif.c |   40 +-
 .../net/wireless/microchip/wilc1000/netdev.c  |   29 +-
 drivers/net/wireless/quantenna/qtnfmac/core.c |    2 -
 .../wireless/quantenna/qtnfmac/pcie/pcie.c    |    2 -
 .../wireless/realtek/rtl8xxxu/rtl8xxxu_core.c |    1 +
 drivers/net/wireless/realtek/rtlwifi/pci.c    |    1 -
 drivers/net/wireless/realtek/rtw88/rtw8821c.c |    2 +-
 drivers/net/wireless/rndis_wlan.c             |    2 -
 drivers/net/wireless/st/cw1200/bh.c           |    2 -
 drivers/ntb/core.c                            |    8 +-
 drivers/opp/debugfs.c                         |    6 +-
 drivers/pci/endpoint/functions/Kconfig        |   11 +
 drivers/pci/endpoint/functions/Makefile       |    1 +
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 1421 +++++++++++++++++
 drivers/pci/p2pdma.c                          |    2 +-
 drivers/pci/pci.h                             |    5 -
 drivers/pci/pcie/dpc.c                        |    2 +-
 drivers/pci/quirks.c                          |    1 +
 drivers/pci/switch/switchtec.c                |    4 +-
 drivers/pinctrl/mediatek/pinctrl-mt8192.c     |    1 -
 drivers/pwm/pwm-atmel-hlcdc.c                 |   71 +-
 drivers/pwm/pwm-sti.c                         |   40 +-
 drivers/remoteproc/Kconfig                    |    2 +-
 drivers/remoteproc/stm32_rproc.c              |   12 +-
 drivers/rtc/Kconfig                           |    3 +-
 drivers/rtc/lib_test.c                        |    2 +-
 drivers/s390/block/dasd.c                     |  111 +-
 drivers/s390/block/dasd_devmap.c              |  566 ++++++-
 drivers/s390/block/dasd_eckd.c                |  154 +-
 drivers/s390/block/dasd_eckd.h                |    8 +-
 drivers/s390/block/dasd_eer.c                 |    1 +
 drivers/s390/block/dasd_int.h                 |   54 +
 drivers/scsi/bfa/bfa.h                        |    9 +-
 drivers/scsi/bfa/bfa_core.c                   |    4 +-
 drivers/scsi/bfa/bfa_ioc.h                    |    8 +-
 drivers/scsi/bfa/bfad_bsg.c                   |   11 +-
 drivers/scsi/csiostor/csio_defs.h             |   18 +-
 drivers/scsi/csiostor/csio_lnode.c            |    8 +-
 drivers/scsi/csiostor/csio_lnode.h            |   13 -
 drivers/scsi/mpt3sas/mpt3sas_base.c           |    4 +-
 drivers/soc/fsl/dpio/dpio-service.c           |    2 +-
 drivers/spi/spi-mt65xx.c                      |   22 +-
 drivers/staging/greybus/light.c               |    8 +-
 .../staging/media/imx/imx-media-csc-scaler.c  |    1 +
 drivers/tty/serial/8250/8250_exar.c           |    5 +-
 drivers/tty/serial/max310x.c                  |    2 +-
 drivers/tty/serial/samsung_tty.c              |    5 +-
 drivers/tty/vt/vt.c                           |    2 +-
 drivers/usb/gadget/udc/net2272.c              |    2 +-
 drivers/vdpa/mlx5/net/mlx5_vnet.c             |   13 +-
 drivers/video/backlight/da9052_bl.c           |    1 +
 drivers/video/backlight/lm3630a_bl.c          |   15 +-
 drivers/video/backlight/lm3639_bl.c           |    1 +
 drivers/video/backlight/lp8788_bl.c           |    1 +
 drivers/watchdog/stm32_iwdg.c                 |    3 +
 fs/afs/dir.c                                  |   10 -
 fs/btrfs/block-group.c                        |    3 +-
 fs/btrfs/block-group.h                        |    7 +
 fs/f2fs/Kconfig                               |    1 +
 fs/f2fs/checkpoint.c                          |    6 +-
 fs/f2fs/compress.c                            |   36 +-
 fs/f2fs/data.c                                |  128 +-
 fs/f2fs/f2fs.h                                |   49 +-
 fs/f2fs/file.c                                |   28 +-
 fs/f2fs/gc.c                                  |    8 +-
 fs/f2fs/node.c                                |    2 +-
 fs/f2fs/segment.c                             |   59 +-
 fs/f2fs/super.c                               |   13 +-
 fs/fhandle.c                                  |    2 +-
 fs/nfs/nfs42.h                                |    7 +-
 fs/nfs/nfs4proc.c                             |   16 +-
 fs/nfs/nfsroot.c                              |    4 +-
 fs/quota/dquot.c                              |  226 ++-
 fs/select.c                                   |    2 +-
 include/drm/drm_fixed.h                       |    2 +-
 include/drm/ttm/ttm_resource.h                |    3 +
 include/linux/bpf.h                           |    7 +-
 include/linux/filter.h                        |   24 +-
 include/linux/igmp.h                          |    4 +-
 include/linux/io_uring.h                      |   10 +-
 include/linux/mlx5/qp.h                       |    5 +-
 include/linux/moduleloader.h                  |    8 +
 include/linux/mroute.h                        |    6 +-
 include/linux/pci.h                           |    5 +
 include/linux/poll.h                          |    4 -
 include/linux/rcupdate.h                      |   43 +
 include/linux/sockptr.h                       |    5 +
 include/trace/events/f2fs.h                   |   21 +-
 init/main.c                                   |    5 +-
 io_uring/io_uring.c                           |  234 +--
 kernel/bpf/cpumap.c                           |    3 +
 kernel/bpf/devmap.c                           |   11 +-
 kernel/bpf/hashtab.c                          |   14 +-
 kernel/bpf/helpers.c                          |    4 +-
 kernel/bpf/map_in_map.c                       |   11 +-
 kernel/bpf/stackmap.c                         |    9 +-
 kernel/bpf/syscall.c                          |   26 +-
 kernel/module.c                               |   20 +-
 kernel/printk/printk.c                        |   34 +
 kernel/rcu/tasks.h                            |    2 +
 kernel/sched/fair.c                           |    4 +-
 kernel/time/time_test.c                       |    2 +-
 kernel/time/timekeeping.c                     |   24 +-
 lib/cmdline_kunit.c                           |    2 +-
 lib/test_blackhole_dev.c                      |    3 +-
 net/bluetooth/hci_core.c                      |    2 +-
 net/bluetooth/hci_event.c                     |    2 -
 net/bluetooth/rfcomm/core.c                   |    2 +-
 net/core/dev.c                                |    5 +-
 net/core/filter.c                             |    5 +-
 net/core/scm.c                                |    2 +-
 net/core/sock.c                               |   51 +-
 net/core/sock_diag.c                          |   10 +-
 net/hsr/hsr_framereg.c                        |    4 +
 net/hsr/hsr_main.c                            |   15 +-
 net/ipv4/igmp.c                               |   22 +-
 net/ipv4/inet_diag.c                          |    6 +-
 net/ipv4/ip_sockglue.c                        |   80 +-
 net/ipv4/ip_tunnel.c                          |   15 +-
 net/ipv4/ipmr.c                               |   13 +-
 net/ipv4/tcp.c                                |    4 +-
 net/ipv4/udp.c                                |    4 +-
 net/ipv6/fib6_rules.c                         |    6 +
 net/ipv6/mcast.c                              |    1 -
 net/iucv/iucv.c                               |    4 +-
 net/kcm/kcmsock.c                             |    3 +-
 net/l2tp/l2tp_ppp.c                           |    4 +-
 net/netfilter/nf_tables_api.c                 |    2 +-
 net/netfilter/nft_set_pipapo.c                |    5 +-
 net/packet/af_packet.c                        |    4 +-
 net/rds/send.c                                |    5 +-
 net/sunrpc/addr.c                             |    4 +-
 net/sunrpc/auth_gss/gss_rpc_xdr.c             |   27 +-
 net/unix/garbage.c                            |    2 +-
 net/unix/scm.c                                |    4 +-
 net/x25/af_x25.c                              |    4 +-
 scripts/clang-tools/gen_compile_commands.py   |    2 +-
 scripts/kconfig/lexer.l                       |    7 +-
 sound/core/seq/seq_midi.c                     |    8 +-
 sound/core/seq/seq_virmidi.c                  |    9 +-
 sound/pci/hda/patch_realtek.c                 |   64 +
 sound/soc/codecs/rt5645.c                     |   10 +
 sound/soc/codecs/wm8962.c                     |   29 +-
 sound/soc/intel/boards/bytcr_rt5640.c         |   12 +
 sound/soc/meson/aiu.c                         |   49 +-
 sound/soc/meson/aiu.h                         |    1 -
 sound/soc/meson/axg-fifo.c                    |   16 +-
 sound/soc/meson/axg-pdm.c                     |   25 +-
 sound/soc/meson/axg-spdifin.c                 |   17 +-
 sound/soc/meson/axg-spdifout.c                |   17 +-
 sound/soc/meson/axg-tdm-formatter.c           |   50 +-
 sound/soc/meson/axg-tdm-interface.c           |   54 +-
 sound/soc/meson/meson-card-utils.c            |    8 +-
 sound/soc/meson/t9015.c                       |   30 +-
 sound/usb/stream.c                            |    5 +-
 tools/bpf/bpftool/prog.c                      |    2 +-
 tools/lib/bpf/libbpf.c                        |    4 +
 tools/perf/builtin-record.c                   |    2 +-
 tools/perf/util/evsel.c                       |    1 -
 tools/perf/util/stat-display.c                |    2 +-
 tools/perf/util/thread_map.c                  |    2 +-
 .../selftests/bpf/progs/test_map_in_map.c     |   26 +
 tools/testing/selftests/bpf/test_maps.c       |    6 +-
 tools/testing/selftests/net/tls.c             |    8 +-
 361 files changed, 4909 insertions(+), 1864 deletions(-)
 create mode 100644 drivers/pci/endpoint/functions/pci-epf-vntb.c

-- 
2.43.0


