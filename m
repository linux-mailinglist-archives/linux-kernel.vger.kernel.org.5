Return-Path: <linux-kernel+bounces-116958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A6288A8AD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:15:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30F72BC83F7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE830138493;
	Mon, 25 Mar 2024 12:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZUBwcE9R"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107581552ED;
	Mon, 25 Mar 2024 11:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711367951; cv=none; b=U3/35GEO4pfiNPV6S36Ygs28I4hCMptIR2ZGi8Vv1Q/eSCFUcKS3XoL4IbeVf6e1rjJglkITGJ+jCb+wG9d2FbxGVoHSAPQU25gQ09p1hQy0XS1PQiXyjuj8yYW7CN6C63Yb8xfsPX7xp+0Z4DNBivpG3a4JzHe9RcbphczeTbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711367951; c=relaxed/simple;
	bh=5oW9bnBTJocPpLlJGsv15w2d4xQ/CkYEqxFoHtCKiKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jhLtDGUMHvZl0REEebweH3u9ne4WNqSipROoQMktzJjJPpshZb9aUNi3TdgViv5256oDcS1/yx09rT5GYjU2OBudp4cPn2mxB1NHOKBTbQhCBC5Hrsq5PCgIBa060cA8RQb83NGhj0eJnT1v8zxE6OlMl4RicZUPZ5sCvKWXTFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZUBwcE9R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E8F0C433F1;
	Mon, 25 Mar 2024 11:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711367950;
	bh=5oW9bnBTJocPpLlJGsv15w2d4xQ/CkYEqxFoHtCKiKQ=;
	h=From:To:Cc:Subject:Date:From;
	b=ZUBwcE9RZCtXaw8cCA28NhPF7VSkHc+Hrz8zN2NG9obkaha/FJKVpykUWr4giYNDR
	 jiAeTlnFF9oWngPITdlguRNPSGVY7+y5Zh7SN4uVTEEjEWkgRPwdZFN8kgNSd5MsNB
	 zIX8x/ckhTNy7ygPFr5Q9OYR/OqYOW8r7tjEhm6eEaBD3niMjyb4F1qhhvGtCtCYHr
	 MenKarmQHVYuvZ0CoOayOKZL26zQrvfIcNqjlN056kAWp7Qz3efC8axPMDovgJiVtQ
	 qL4DJVdQKbFMbz6L72HqEZPP9NHKC8KsM36sz/6dGwtEB6Mp8IpWY4N7lS6AddVf69
	 OThcGmdkQWOFg==
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
Subject: [PATCH 5.4 000/180] 5.4.273-rc2 review
Date: Mon, 25 Mar 2024 07:59:08 -0400
Message-ID: <20240325115908.1765126-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.273-rc2.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.4.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.4.273-rc2
X-KernelTest-Deadline: 2024-03-27T11:59+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit


This is the start of the stable review cycle for the 5.4.273 release.
There are 180 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Wed Mar 27 11:59:07 AM UTC 2024.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
        https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/patch/?id=linux-5.4.y&id2=v5.4.272
or in the git tree and branch at:
        git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
and the diffstat can be found below.

Thanks,
Sasha

-------------
Pseudo-Shortlog of commits:

Alban Boyé (1):
  ASoC: Intel: bytcr_rt5640: Add an extra entry for the Chuwi Vi8 tablet

Alex Bee (1):
  drm/rockchip: inno_hdmi: Fix video timing

Alexander Gordeev (1):
  net/iucv: fix the allocation size of iucv_path_table array

Alexander Stein (1):
  media: tc358743: register v4l2 async device only after successful
    setup

Alexei Starovoitov (2):
  bpf: Add typecast to bpf helpers to help BTF generation
  bpf: Factor out bpf_spin_lock into helpers.

Alexis Lothoré (2):
  wifi: wilc1000: fix declarations ordering
  wifi: wilc1000: fix RCU usage in connect path

Anastasia Belova (1):
  cpufreq: brcmstb-avs-cpufreq: add check for cpufreq_cpu_get's return
    value

Andy Shevchenko (1):
  serial: 8250_exar: Don't remove GPIO device on suspend

AngeloGioacchino Del Regno (1):
  drm/mediatek: dsi: Fix DSI RGB666 formats and definitions

Armin Wolf (1):
  ACPI: processor_idle: Fix memory leak in acpi_processor_power_exit()

Arnd Bergmann (8):
  fs/select: rework stack allocation hack for clang
  wifi: brcmsmac: avoid function pointer casts
  media: pvrusb2: fix pvr2_stream_callback casts
  crypto: arm/sha - fix function cast warnings
  mtd: rawnand: lpc32xx_mlc: fix irq handler prototype
  media: dvb-frontends: avoid stack overflow warnings with clang
  scsi: csiostor: Avoid function pointer casts
  scsi: bfa: Fix function pointer type mismatch for hcb_qe->cbfn

Arthur Kiyanovski (1):
  net: ena: cosmetic: fix line break issues

Baokun Li (1):
  quota: simplify drop_dquot_ref()

Baruch Siach (1):
  mtd: maps: physmap-core: fix flash size larger than 32-bit

Ben Wolsieffer (1):
  watchdog: stm32_iwdg: initialize default timeout

Bjorn Andersson (4):
  arm64: dts: qcom: db820c: Move non-soc entries out of /soc
  arm64: dts: qcom: msm8996: Use node references in db820c
  arm64: dts: qcom: msm8996: Move regulator consumers to db820c
  arm64: dts: qcom: msm8996: Pad addresses

Breno Leitao (1):
  net: blackhole_dev: fix build warning for ethh set but not used

Bryan O'Donoghue (1):
  clk: Fix clk_core_get NULL dereference

Cai Huoqing (1):
  drm/tegra: dsi: Make use of the helper function dev_err_probe()

Chen Ni (2):
  sr9800: Add check for usbnet_get_endpoints
  drm/tegra: dsi: Add missing check for of_find_device_by_node

Christophe JAILLET (8):
  mmc: wmt-sdmmc: remove an incorrect release_mem_region() call in the
    .remove function
  drm/tegra: dsi: Fix some error handling paths in tegra_dsi_probe()
  drm/tegra: dsi: Fix missing pm_runtime_disable() in the error handling
    path of tegra_dsi_probe()
  drm/tegra: output: Fix missing i2c_put_adapter() in the error handling
    paths of tegra_output_probe()
  PCI: switchtec: Fix an error handling path in switchtec_pci_probe()
  clk: hisilicon: hi3519: Release the correct number of gates in
    hi3519_clk_unregister()
  net: sunrpc: Fix an off by one in rpc_sockaddr2uaddr()
  NFS: Fix an off by one in root_nfs_cat()

Chun-Yi Lee (1):
  aoe: fix the potential use-after-free problem in aoecmd_cfg_pkts

Colin Ian King (1):
  usb: gadget: net2272: Use irqflags in the call to net2272_probe_fin

Dan Carpenter (1):
  staging: greybus: fix get_channel_from_mode() failure path

Daniel Thompson (3):
  backlight: da9052: Fully initialize backlight_properties during probe
  backlight: lm3639: Fully initialize backlight_properties during probe
  backlight: lp8788: Fully initialize backlight_properties during probe

Daniil Dulov (2):
  media: go7007: add check of return value of go7007_read_addr()
  media: pvrusb2: remove redundant NULL check

David Howells (1):
  afs: Revert "afs: Hide silly-rename files from userspace"

Duoming Zhou (1):
  nfp: flower: handle acti_netdevs allocation failure

Edward Adam Davis (1):
  media: pvrusb2: fix uaf in pvr2_context_set_notify

Eric Dumazet (3):
  sock_diag: annotate data-races around sock_diag_handlers[family]
  net: ip_tunnel: make sure to pull inner header in ip_tunnel_rcv()
  packet: annotate data-races around ignore_outgoing

Fedor Pchelkin (1):
  drm/tegra: put drm_gem_object ref on error in tegra_fb_create

Fei Shao (1):
  spi: spi-mt65xx: Fix NULL pointer access in interrupt handler

Felix Maurer (1):
  hsr: Handle failures in module init

Filipe Manana (1):
  btrfs: fix data race at btrfs_use_block_rsv() when accessing block
    reserve

Gavrilov Ilia (5):
  tcp: fix incorrect parameter validation in the do_tcp_getsockopt()
    function
  l2tp: fix incorrect parameter validation in the pppol2tp_getsockopt()
    function
  udp: fix incorrect parameter validation in the udp_lib_getsockopt()
    function
  net: kcm: fix incorrect parameter validation in the kcm_getsockopt)
    function
  net/x25: fix incorrect parameter validation in the x25_getsockopt()
    function

Geert Uytterhoeven (2):
  ARM: dts: renesas: r8a73a4: Fix external clocks and clock rate
  ARM: dts: arm: realview: Fix development chip ROM compatible value

Greg Joyce (1):
  block: sed-opal: handle empty atoms when parsing response

Hans Verkuil (2):
  media: rename VFL_TYPE_GRABBER to _VIDEO
  media: media/pci: rename VFL_TYPE_GRABBER to _VIDEO

Hans de Goede (1):
  ASoC: rt5645: Make LattePanda board DMI match more precise

Harry Wentland (1):
  drm: Don't treat 0 as -1 in drm_fixp2int_ceil

Hsin-Yi Wang (1):
  drm/mediatek: Fix a null pointer crash in
    mtk_drm_crtc_finish_page_flip

Hugo Villeneuve (1):
  serial: max310x: fix syntax error in IRQ error message

Ian Rogers (1):
  perf stat: Avoid metric-only segv

Ilpo Järvinen (1):
  PCI/DPC: Print all TLP Prefixes, not just the first

Jakub Kicinski (1):
  selftests: tls: use exact comparison in recv_partial

Jan Kara (1):
  quota: Fix rcu annotations of inode dquot pointers

Jens Axboe (2):
  io_uring/unix: drop usage of io_uring socket
  io_uring: drop any code related to SCM_RIGHTS

Jerome Brunet (1):
  ASoC: meson: axg-tdm-interface: fix mclk setup without mclk-fs

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

Jonas Dreßler (1):
  Bluetooth: Remove superfluous call to hci_conn_check_pending()

Jörg Wedekind (1):
  PCI: Mark 3ware-9650SE Root Port Extended Tags as broken

Kajol Jain (1):
  powerpc/hv-gpci: Fix the H_GET_PERF_COUNTER_INFO hcall return value
    checks

Kamal Heib (1):
  net: ena: Remove ena_select_queue

Kees Cook (1):
  x86, relocs: Ignore relocations in .notes section

Konrad Dybcio (3):
  clk: qcom: reset: Commonize the de/assert functions
  clk: qcom: reset: Ensure write completion on reset de/assertion
  clk: qcom: dispcc-sdm845: Adjust internal GDSC wait times

Kuniyuki Iwashima (1):
  af_unix: Annotate data-race of gc_in_progress in wait_for_unix_gc().

Kunwu Chan (1):
  x86/xen: Add some null pointer checking to smp.c

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

Masahiro Yamada (1):
  kconfig: fix infinite loop when expanding a macro at the end of file

Max Kellermann (1):
  parisc/ftrace: add missing CONFIG_DYNAMIC_FTRACE check

Mete Durlu (1):
  s390/vtime: fix average steal time calculation

Michael Ellerman (1):
  powerpc/embedded6xx: Fix no previous prototype for avr_uart_send()
    etc.

Michael Klein (1):
  ARM: dts: sun8i-h2-plus-bananapi-m2-zero: add regulator nodes vcc-dram
    and vcc1v2

Michal Vokáč (3):
  ARM: dts: imx6dl-yapp4: Move phy reset into switch node
  ARM: dts: imx6dl-yapp4: Fix typo in the QCA switch register address
  ARM: dts: imx6dl-yapp4: Move the internal switch PHYs under the switch
    node

Mikulas Patocka (2):
  dm-verity, dm-crypt: align "struct bvec_iter" correctly
  dm: call the resume method on internal suspend

Ming Lei (1):
  dm raid: fix false positive for requeue needed during reshape

Navid Emamdoost (1):
  nbd: null check for nla_nest_start

Nikita Zhandarovich (3):
  do_sys_name_to_handle(): use kzalloc() to fix kernel-infoleak
  media: em28xx: annotate unchecked call to media_device_register()
  drm/radeon/ni: Fix wrong firmware size logging in ni_init_microcode()

Pablo Neira Ayuso (1):
  netfilter: nf_tables: do not compare internal table flags on updates

Paloma Arellano (1):
  drm/msm/dpu: add division of drm_display_mode's hskew parameter

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

Quentin Schulz (1):
  drm/rockchip: lvds: do not overwrite error code

Rafael J. Wysocki (1):
  ACPI: scan: Fix device check notification handling

Rafał Miłecki (1):
  arm64: dts: mediatek: mt7622: add missing "device_type" to memory
    nodes

Rahul Rameshbabu (4):
  wifi: b43: Stop/wake correct queue in DMA Tx path when QoS is disabled
  wifi: b43: Stop/wake correct queue in PIO Tx path when QoS is disabled
  wifi: b43: Stop correct queue in DMA worker when QoS is disabled
  wifi: b43: Disable QoS for bcm4331

Randy Dunlap (1):
  rtc: mt6397: select IRQ_DOMAIN instead of depending on it

Ranjan Kumar (1):
  scsi: mpt3sas: Prevent sending diag_reset when the controller is ready

Robert Marko (1):
  clk: qcom: reset: support resetting multiple bits

Ruud Bos (1):
  igb: move PEROUT and EXTTS isr logic to separate functions

Sam Ravnborg (1):
  sparc32: Fix section mismatch in leon_pci_grpci

Sasha Levin (1):
  Linux 5.4.273-rc2

Saurav Girepunje (2):
  b43: dma: Fix use true/false for bool type variable
  b43: main: Fix use true/false for bool type

Shifeng Li (1):
  RDMA/device: Fix a race between mad_client and cm_client init

Shigeru Yoshida (1):
  hsr: Fix uninit-value access in hsr_get_node()

Shiming Cheng (1):
  ipv6: fib6_rules: flush route cache when rule is changed

Sowjanya Komatineni (1):
  gpu: host1x: mipi: Update tegra_mipi_request() to be node based

Srinivasan Shanmugam (2):
  drm/amd/display: Fix potential NULL pointer dereferences in
    'dcn10_set_output_transfer_func()'
  drm/amdgpu: Fix missing break in ATOM_ARG_IMM Case of
    atom_get_src_int()

Stephan Gerhold (1):
  clk: qcom: reset: Allow specifying custom reset delay

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

Thinh Tran (1):
  net/bnx2x: Prevent access to a freed page in page_pool

Toke Høiland-Jørgensen (2):
  bpf: Fix hashtab overflow check on 32-bit arches
  bpf: Fix stackmap overflow check on 32-bit arches

Tudor Ambarus (1):
  tty: serial: samsung: fix tx_empty() to return TIOCSER_TEMT

Uwe Kleine-König (1):
  Input: gpio_keys_polled - suppress deferred probe error for gpio

Vandana BN (1):
  media: v4l2-core: correctly validate video and metadata ioctls

Vinicius Costa Gomes (1):
  igb: Fix missing time sync events

Wang Jianjian (1):
  quota: Fix potential NULL pointer dereference

Xingyuan Mo (1):
  wifi: ath10k: fix NULL pointer dereference in
    ath10k_wmi_tlv_op_pull_mgmt_tx_compl_ev()

Yan Zhai (2):
  rcu: add a helper to report consolidated flavor QS
  bpf: report RCU QS in cpumap kthread

Yang Jihong (3):
  perf record: Fix possible incorrect free in record__switch_output()
  perf evsel: Fix duplicate initialization of data->id in
    evsel__parse_sample()
  perf thread_map: Free strlist on normal path in
    thread_map__new_by_tid_str()

Yewon Choi (1):
  rds: introduce acquire/release ordering in acquire/release_in_xmit()

Yishai Hadas (1):
  RDMA/mlx5: Relax DEVX access upon modify commands

Yonghong Song (1):
  bpf: Mark bpf_spin_{lock,unlock}() helpers with notrace correctly

Yuxuan Hu (1):
  Bluetooth: rfcomm: Fix null-ptr-deref in rfcomm_check_security

Zhipeng Lu (7):
  wifi: libertas: fix some memleaks in lbs_allocate_cmd_buffer()
  SUNRPC: fix some memleaks in gssx_dec_option_array
  media: v4l2-tpg: fix some memleaks in tpg_alloc
  media: v4l2-mem2mem: fix a memleak in v4l2_m2m_register_entity
  media: edia: dvbdev: fix a use-after-free
  media: go7007: fix a memleak in go7007_load_encoder
  media: ttpci: fix two memleaks in budget_av_attach

 Documentation/media/kapi/v4l2-dev.rst         |   4 +-
 .../zh_CN/video4linux/v4l2-framework.txt      |   4 +-
 Makefile                                      |   4 +-
 arch/arm/boot/dts/arm-realview-pb1176.dts     |   2 +-
 arch/arm/boot/dts/imx6dl-yapp4-common.dtsi    |  28 +-
 arch/arm/boot/dts/r8a73a4-ape6evm.dts         |  12 +
 arch/arm/boot/dts/r8a73a4.dtsi                |   9 +-
 .../dts/sun8i-h2-plus-bananapi-m2-zero.dts    |  24 +
 arch/arm/crypto/sha256_glue.c                 |  13 +-
 arch/arm/crypto/sha512-glue.c                 |  12 +-
 .../dts/mediatek/mt7622-bananapi-bpi-r64.dts  |   1 +
 arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts  |   1 +
 arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi  | 783 +++++++++---------
 arch/arm64/boot/dts/qcom/msm8996.dtsi         | 192 ++---
 arch/mips/include/asm/ptrace.h                |   1 +
 arch/parisc/kernel/ftrace.c                   |   2 +-
 arch/powerpc/perf/hv-gpci.c                   |  29 +-
 .../platforms/embedded6xx/linkstation.c       |   3 -
 arch/powerpc/platforms/embedded6xx/mpc10x.h   |   3 +
 arch/s390/kernel/vtime.c                      |   4 +-
 arch/sparc/kernel/leon_pci_grpci1.c           |   2 +-
 arch/sparc/kernel/leon_pci_grpci2.c           |   2 +-
 arch/x86/tools/relocs.c                       |   8 +
 arch/x86/xen/smp.c                            |  12 +
 block/opal_proto.h                            |   1 +
 block/sed-opal.c                              |   6 +-
 drivers/acpi/processor_idle.c                 |   2 +
 drivers/acpi/scan.c                           |   8 +-
 drivers/base/regmap/regmap.c                  |   2 +-
 drivers/block/aoe/aoecmd.c                    |  12 +-
 drivers/block/aoe/aoenet.c                    |   1 +
 drivers/block/nbd.c                           |   6 +
 drivers/bus/Kconfig                           |   5 +-
 drivers/clk/clk.c                             |   3 +
 drivers/clk/hisilicon/clk-hi3519.c            |   2 +-
 drivers/clk/qcom/dispcc-sdm845.c              |   2 +
 drivers/clk/qcom/reset.c                      |  33 +-
 drivers/clk/qcom/reset.h                      |   2 +
 drivers/cpufreq/brcmstb-avs-cpufreq.c         |   2 +
 drivers/dma/Kconfig                           |  14 +-
 drivers/firewire/core-card.c                  |  14 +-
 drivers/gpu/drm/amd/amdgpu/atom.c             |   2 +-
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c |   7 +-
 drivers/gpu/drm/mediatek/mtk_drm_crtc.c       |  12 +-
 drivers/gpu/drm/mediatek/mtk_dsi.c            |  10 +-
 .../drm/msm/disp/dpu1/dpu_encoder_phys_vid.c  |   6 +-
 drivers/gpu/drm/radeon/ni.c                   |   2 +-
 drivers/gpu/drm/rockchip/inno_hdmi.c          |   4 +-
 drivers/gpu/drm/rockchip/rockchip_lvds.c      |   1 -
 drivers/gpu/drm/tegra/dsi.c                   |  49 +-
 drivers/gpu/drm/tegra/fb.c                    |   1 +
 drivers/gpu/drm/tegra/output.c                |  16 +-
 drivers/gpu/host1x/mipi.c                     |   4 +-
 drivers/hid/hid-multitouch.c                  |   4 +
 drivers/infiniband/core/device.c              |  37 +-
 drivers/infiniband/hw/mlx5/devx.c             |   2 +-
 drivers/input/keyboard/gpio_keys_polled.c     |  10 +-
 drivers/iommu/amd_iommu_init.c                |   3 +
 drivers/md/dm-crypt.c                         |   4 +-
 drivers/md/dm-raid.c                          |   4 +-
 drivers/md/dm-verity.h                        |   4 +-
 drivers/md/dm.c                               |  26 +-
 drivers/media/common/v4l2-tpg/v4l2-tpg-core.c |  52 +-
 drivers/media/dvb-core/dvbdev.c               |   5 +
 drivers/media/dvb-frontends/stv0367.c         |  34 +-
 drivers/media/i2c/tc358743.c                  |   7 +-
 drivers/media/pci/bt8xx/bttv-driver.c         |   4 +-
 drivers/media/pci/cobalt/cobalt-v4l2.c        |   2 +-
 drivers/media/pci/cx18/cx18-streams.c         |  12 +-
 drivers/media/pci/cx23885/cx23885-417.c       |   2 +-
 drivers/media/pci/cx23885/cx23885-video.c     |   2 +-
 drivers/media/pci/cx25821/cx25821-video.c     |   2 +-
 drivers/media/pci/cx88/cx88-blackbird.c       |   2 +-
 drivers/media/pci/cx88/cx88-video.c           |   2 +-
 drivers/media/pci/dt3155/dt3155.c             |   2 +-
 drivers/media/pci/intel/ipu3/ipu3-cio2.c      |   2 +-
 drivers/media/pci/ivtv/ivtv-streams.c         |  12 +-
 drivers/media/pci/meye/meye.c                 |   2 +-
 drivers/media/pci/saa7134/saa7134-core.c      |   2 +-
 drivers/media/pci/saa7134/saa7134-empress.c   |   2 +-
 drivers/media/pci/saa7146/hexium_gemini.c     |   2 +-
 drivers/media/pci/saa7146/hexium_orion.c      |   2 +-
 drivers/media/pci/saa7146/mxb.c               |   2 +-
 drivers/media/pci/saa7164/saa7164-encoder.c   |   2 +-
 .../media/pci/solo6x10/solo6x10-v4l2-enc.c    |   2 +-
 drivers/media/pci/solo6x10/solo6x10-v4l2.c    |   2 +-
 drivers/media/pci/sta2x11/sta2x11_vip.c       |   2 +-
 drivers/media/pci/ttpci/av7110_v4l.c          |   2 +-
 drivers/media/pci/ttpci/budget-av.c           |  10 +-
 drivers/media/pci/tw5864/tw5864-video.c       |   2 +-
 drivers/media/pci/tw68/tw68-video.c           |   2 +-
 drivers/media/pci/tw686x/tw686x-video.c       |   2 +-
 drivers/media/usb/em28xx/em28xx-cards.c       |   4 +
 drivers/media/usb/go7007/go7007-driver.c      |   8 +-
 drivers/media/usb/go7007/go7007-usb.c         |   4 +-
 drivers/media/usb/pvrusb2/pvrusb2-context.c   |  10 +-
 drivers/media/usb/pvrusb2/pvrusb2-dvb.c       |   6 +-
 drivers/media/usb/pvrusb2/pvrusb2-v4l2.c      |  11 +-
 drivers/media/v4l2-core/v4l2-dev.c            |  68 +-
 drivers/media/v4l2-core/v4l2-ioctl.c          |  16 +-
 drivers/media/v4l2-core/v4l2-mem2mem.c        |  10 +-
 drivers/mfd/altera-sysmgr.c                   |   4 +-
 drivers/mfd/syscon.c                          |   4 +-
 drivers/mmc/host/wmt-sdmmc.c                  |   4 -
 drivers/mtd/maps/physmap-core.c               |   2 +-
 drivers/mtd/nand/raw/lpc32xx_mlc.c            |   5 +-
 drivers/net/ethernet/amazon/ena/ena_com.c     |   8 +-
 drivers/net/ethernet/amazon/ena/ena_netdev.c  |  20 +-
 .../net/ethernet/broadcom/bnx2x/bnx2x_cmn.h   |   6 +-
 .../hisilicon/hns3/hns3pf/hclge_main.c        |   5 +-
 drivers/net/ethernet/intel/igb/igb_main.c     | 112 ++-
 .../net/ethernet/marvell/octeontx2/af/cgx.c   |   2 +-
 .../net/ethernet/marvell/octeontx2/af/rvu.c   |  17 +-
 .../ethernet/netronome/nfp/flower/lag_conf.c  |   5 +
 drivers/net/usb/sr9800.c                      |   4 +-
 drivers/net/wireless/ath/ath10k/wmi-tlv.c     |   4 +
 drivers/net/wireless/broadcom/b43/b43.h       |  16 +
 drivers/net/wireless/broadcom/b43/dma.c       |   8 +-
 drivers/net/wireless/broadcom/b43/main.c      |  22 +-
 drivers/net/wireless/broadcom/b43/pio.c       |   6 +-
 .../broadcom/brcm80211/brcmsmac/phy/phy_cmn.c |   3 +-
 .../broadcom/brcm80211/brcmsmac/phy_shim.c    |   5 +-
 .../broadcom/brcm80211/brcmsmac/phy_shim.h    |   2 +-
 drivers/net/wireless/marvell/libertas/cmd.c   |  13 +-
 .../net/wireless/marvell/mwifiex/debugfs.c    |   3 -
 drivers/pci/pcie/dpc.c                        |   2 +-
 drivers/pci/quirks.c                          |   1 +
 drivers/pci/switch/switchtec.c                |   4 +-
 drivers/rtc/Kconfig                           |   3 +-
 drivers/scsi/bfa/bfa.h                        |   9 +-
 drivers/scsi/bfa/bfa_core.c                   |   4 +-
 drivers/scsi/bfa/bfa_ioc.h                    |   8 +-
 drivers/scsi/bfa/bfad_bsg.c                   |  11 +-
 drivers/scsi/csiostor/csio_defs.h             |  18 +-
 drivers/scsi/csiostor/csio_lnode.c            |   8 +-
 drivers/scsi/csiostor/csio_lnode.h            |  13 -
 drivers/scsi/mpt3sas/mpt3sas_base.c           |   4 +-
 drivers/spi/spi-mt65xx.c                      |  22 +-
 drivers/staging/greybus/light.c               |   8 +-
 .../staging/media/imx/imx-media-csc-scaler.c  |   1 +
 drivers/staging/wilc1000/wilc_hif.c           |  40 +-
 drivers/tty/serial/8250/8250_exar.c           |   5 +-
 drivers/tty/serial/max310x.c                  |   2 +-
 drivers/tty/serial/samsung.c                  |   5 +-
 drivers/tty/vt/vt.c                           |   2 +-
 drivers/usb/gadget/udc/net2272.c              |   2 +-
 drivers/video/backlight/da9052_bl.c           |   1 +
 drivers/video/backlight/lm3630a_bl.c          |  15 +-
 drivers/video/backlight/lm3639_bl.c           |   1 +
 drivers/video/backlight/lp8788_bl.c           |   1 +
 drivers/watchdog/stm32_iwdg.c                 |   3 +
 fs/afs/dir.c                                  |  10 -
 fs/btrfs/block-rsv.c                          |   2 +-
 fs/btrfs/block-rsv.h                          |  16 +
 fs/fhandle.c                                  |   2 +-
 fs/io_uring.c                                 |  65 +-
 fs/nfs/nfsroot.c                              |   4 +-
 fs/quota/dquot.c                              | 226 +++--
 fs/select.c                                   |   2 +-
 include/drm/drm_fixed.h                       |   2 +-
 include/linux/filter.h                        |  24 +-
 include/linux/fs.h                            |   6 +-
 include/linux/host1x.h                        |   3 +-
 include/linux/poll.h                          |   4 -
 include/linux/rcupdate.h                      |  31 +
 include/media/v4l2-dev.h                      |   6 +-
 kernel/bpf/cpumap.c                           |   3 +
 kernel/bpf/hashtab.c                          |  14 +-
 kernel/bpf/helpers.c                          |  18 +-
 kernel/bpf/stackmap.c                         |   9 +-
 kernel/time/timekeeping.c                     |  24 +-
 lib/test_blackhole_dev.c                      |   3 +-
 net/bluetooth/hci_core.c                      |   2 +-
 net/bluetooth/hci_event.c                     |   2 -
 net/bluetooth/rfcomm/core.c                   |   2 +-
 net/core/dev.c                                |   2 +-
 net/core/scm.c                                |   2 +-
 net/core/sock_diag.c                          |  10 +-
 net/hsr/hsr_framereg.c                        |   4 +
 net/hsr/hsr_main.c                            |  15 +-
 net/ipv4/ip_tunnel.c                          |  15 +-
 net/ipv4/tcp.c                                |   4 +-
 net/ipv4/udp.c                                |   4 +-
 net/ipv6/fib6_rules.c                         |   6 +
 net/iucv/iucv.c                               |   4 +-
 net/kcm/kcmsock.c                             |   3 +-
 net/l2tp/l2tp_ppp.c                           |   4 +-
 net/netfilter/nf_tables_api.c                 |   2 +-
 net/packet/af_packet.c                        |   4 +-
 net/rds/send.c                                |   5 +-
 net/sunrpc/addr.c                             |   4 +-
 net/sunrpc/auth_gss/gss_rpc_xdr.c             |  27 +-
 net/unix/garbage.c                            |   2 +-
 net/unix/scm.c                                |   4 +-
 net/x25/af_x25.c                              |   4 +-
 samples/v4l/v4l2-pci-skeleton.c               |   2 +-
 scripts/kconfig/lexer.l                       |   7 +-
 sound/core/seq/seq_midi.c                     |   8 +-
 sound/core/seq/seq_virmidi.c                  |   9 +-
 sound/soc/codecs/rt5645.c                     |  10 +
 sound/soc/codecs/wm8962.c                     |  29 +-
 sound/soc/intel/boards/bytcr_rt5640.c         |  12 +
 sound/soc/meson/axg-tdm-interface.c           |   4 +-
 sound/usb/stream.c                            |   5 +-
 tools/perf/builtin-record.c                   |   2 +-
 tools/perf/util/evsel.c                       |   1 -
 tools/perf/util/stat-display.c                |   2 +-
 tools/perf/util/thread_map.c                  |   2 +-
 tools/testing/selftests/net/tls.c             |   8 +-
 209 files changed, 1663 insertions(+), 1311 deletions(-)

-- 
2.43.0


