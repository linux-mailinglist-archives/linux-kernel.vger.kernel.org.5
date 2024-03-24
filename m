Return-Path: <linux-kernel+bounces-116305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4124E889E1D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:02:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C95F12C1C1B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43C3F297D5E;
	Mon, 25 Mar 2024 03:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MeeGnBuu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4189522B6B1;
	Sun, 24 Mar 2024 23:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324215; cv=none; b=r/1TL1z/stKGDHXnQIIrubPlCY/Ng6QeLZEcxizcHzJ9kCLJqlcy4HU/Lt9xbpxKmqaAAKrqoKSydfsZiFLMO567Ou/9D9OWbNbzgO4AuzjD00NRqbN8C9taKR3XQxH57xLWBWUPlt9Q+c+MQnozjxGfSXqR+FfSbl0BKyr1SDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324215; c=relaxed/simple;
	bh=oys/WHRAsfIL2b/fygeKhjUkGkKnmVR3qFXi69ANvPs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YJiPvAb9sdHl+fbd6HQz9nO23N9Indg2fdb6WYUzIe1ryYw32UjQNZHkN5T0/IhfrbruNCJDeQS751MDp/UFKrtjyydPjTHnuk+P+0JfVKIn4xINJ1K2TxiIu3LOroXHO44CHJEa28dGpqB2MfEqSxaeUXbi+wByHnyUAKmg8zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MeeGnBuu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD243C433F1;
	Sun, 24 Mar 2024 23:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324215;
	bh=oys/WHRAsfIL2b/fygeKhjUkGkKnmVR3qFXi69ANvPs=;
	h=From:To:Cc:Subject:Date:From;
	b=MeeGnBuuRgN41GEqyXI37NKvWo8psr4QPqeB3bZnO9JSnNn15bNlFZ1lP4971iduo
	 UUvo3A/AUmntH8K9gi+ptR3TapWzh2TAqpzk5aajpSR+SITod9NVKoh9Wsd/Y2jz29
	 pgtT85j5aPqFbXyD50SuDceJYGTGe8fZRXYCL37jB1hZnerqM+fm5D1twJ9ILbXlfE
	 m6X/H3fzxD7Ify6AJLBUy4I9envnF9GrD4Vb95TKdCeZ6Vebjrf+hyp3hM2hmp0CiH
	 ffM4ALnSuBsVt8Y8ocS81j+OIlX2c/0a96r0065bTCDJ08CDqgweBo/VbnWr2ZnZsS
	 D6nSXNIcDy7ng==
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
Subject: [PATCH 4.19 000/148] 4.19.311-rc1 review
Date: Sun, 24 Mar 2024 19:47:44 -0400
Message-ID: <20240324235012.1356413-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.311-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.19.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.19.311-rc1
X-KernelTest-Deadline: 2024-03-26T23:50+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit


This is the start of the stable review cycle for the 4.19.311 release.
There are 148 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Tue Mar 26 11:50:05 PM UTC 2024.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
        https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/patch/?id=linux-4.19.y&id2=v4.19.310
or in the git tree and branch at:
        git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
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

Baokun Li (1):
  quota: simplify drop_dquot_ref()

Cai Huoqing (1):
  drm/tegra: dsi: Make use of the helper function dev_err_probe()

Chen Ni (2):
  sr9800: Add check for usbnet_get_endpoints
  drm/tegra: dsi: Add missing check for of_find_device_by_node

Chengguang Xu (2):
  quota: code cleanup for __dquot_alloc_space()
  quota: check time limit when back out space/inode change

Christoph Hellwig (3):
  md: switch to ->check_events for media change notifications
  block: add a new set_read_only method
  md: implement ->set_read_only to hook into BLKROSET processing

Christophe JAILLET (6):
  mmc: wmt-sdmmc: remove an incorrect release_mem_region() call in the
    .remove function
  drm/tegra: dsi: Fix some error handling paths in tegra_dsi_probe()
  drm/tegra: dsi: Fix missing pm_runtime_disable() in the error handling
    path of tegra_dsi_probe()
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

Daniil Dulov (1):
  media: go7007: add check of return value of go7007_read_addr()

Dinghao Liu (1):
  media: dvbdev: Fix memleak in dvb_register_device

Duoming Zhou (1):
  nfp: flower: handle acti_netdevs allocation failure

Edward Adam Davis (1):
  media: pvrusb2: fix uaf in pvr2_context_set_notify

Eric Biggers (1):
  crypto: af_alg - make some functions static

Eric Dumazet (1):
  sock_diag: annotate data-races around sock_diag_handlers[family]

Fedor Pchelkin (1):
  drm/tegra: put drm_gem_object ref on error in tegra_fb_create

Fei Shao (1):
  spi: spi-mt65xx: Fix NULL pointer access in interrupt handler

Felix Maurer (1):
  hsr: Handle failures in module init

Fuqian Huang (1):
  media: media/dvb: Use kmemdup rather than duplicating its
    implementation

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

Govind Singh (1):
  firmware: qcom: scm: Add WLAN VMID for Qualcomm SCM interface

Greg Joyce (1):
  block: sed-opal: handle empty atoms when parsing response

Hans de Goede (2):
  ASoC: rt5645: Make LattePanda board DMI match more precise
  crypto: arm - Rename functions to avoid conflict with crypto/sha256.h

Harry Wentland (1):
  drm: Don't treat 0 as -1 in drm_fixp2int_ceil

Herbert Xu (1):
  crypto: algif_aead - Only wake up when ctx->more is zero

Hsin-Yi Wang (1):
  drm/mediatek: Fix a null pointer crash in
    mtk_drm_crtc_finish_page_flip

Hugo Villeneuve (1):
  serial: max310x: fix syntax error in IRQ error message

Hyunwoo Kim (1):
  media: dvb-core: Fix use-after-free due to race at
    dvb_register_device()

Jan Kara (1):
  quota: Fix rcu annotations of inode dquot pointers

Jerome Brunet (1):
  ASoC: meson: axg-tdm-interface: fix mclk setup without mclk-fs

Jiang Biao (1):
  fs/quota: erase unused but set variable warning

Jiaxun Yang (1):
  MIPS: Clear Cause.BD in instruction_pointer_set

Jinjie Ruan (1):
  wifi: mwifiex: debugfs: Drop unnecessary error check for
    debugfs_create_dir()

Johan Carlsson (1):
  ALSA: usb-audio: Stop parsing channels bits when all channels are
    found.

Johan Hovold (1):
  PCI/AER: Fix rootport attribute paths in ABI docs

Jonas Dreßler (1):
  Bluetooth: Remove superfluous call to hci_conn_check_pending()

Jörg Wedekind (1):
  PCI: Mark 3ware-9650SE Root Port Extended Tags as broken

Kajol Jain (1):
  powerpc/hv-gpci: Fix the H_GET_PERF_COUNTER_INFO hcall return value
    checks

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

Li Nan (1):
  md: Don't clear MD_CLOSING when the raid is about to stop

Luca Weiss (2):
  backlight: lm3630a: Initialize backlight_properties on init
  backlight: lm3630a: Don't set bl->props.brightness in get_brightness

Luiz Augusto von Dentz (1):
  Bluetooth: hci_core: Fix possible buffer overflow

Mario Limonciello (1):
  iommu/amd: Mark interrupt as managed

Masahiro Yamada (1):
  kconfig: fix infinite loop when expanding a macro at the end of file

Mauro Carvalho Chehab (3):
  ABI: sysfs-bus-pci-devices-aer_stats uses an invalid tag
  media: dvbdev: remove double-unlock
  media: dvbdev: fix error logic at dvb_register_device()

Michael Ellerman (1):
  powerpc/embedded6xx: Fix no previous prototype for avr_uart_send()
    etc.

Mikulas Patocka (2):
  dm-verity, dm-crypt: align "struct bvec_iter" correctly
  dm: call the resume method on internal suspend

Ming Lei (1):
  dm raid: fix false positive for requeue needed during reshape

Murali Karicheri (1):
  net: hsr: fix placement of logical operator in a multi-line statement

Nikita Zhandarovich (3):
  do_sys_name_to_handle(): use kzalloc() to fix kernel-infoleak
  media: em28xx: annotate unchecked call to media_device_register()
  drm/radeon/ni: Fix wrong firmware size logging in ni_init_microcode()

Ondrej Mosnacek (1):
  crypto: algif_aead - fix uninitialized ctx->init

Peter Griffin (1):
  mfd: syscon: Call of_node_put() only when of_parse_phandle() takes a
    ref

Peter Hilber (3):
  timekeeping: Fix cross-timestamp interpolation on counter wrap
  timekeeping: Fix cross-timestamp interpolation corner case decision
  timekeeping: Fix cross-timestamp interpolation for non-x86

Peter Robinson (1):
  bus: tegra-aconnect: Update dependency to ARCH_TEGRA

Quentin Schulz (2):
  drm/rockchip: lvds: do not overwrite error code
  drm/rockchip: lvds: do not print scary message when probing defer

Rafael J. Wysocki (1):
  ACPI: scan: Fix device check notification handling

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
  Linux 4.19.311-rc1

Saurav Girepunje (2):
  b43: dma: Fix use true/false for bool type variable
  b43: main: Fix use true/false for bool type

Sean Anderson (1):
  usb: phy: generic: Get the vbus supply

Shigeru Yoshida (1):
  hsr: Fix uninit-value access in hsr_get_node()

Shiming Cheng (1):
  ipv6: fib6_rules: flush route cache when rule is changed

Sowjanya Komatineni (1):
  gpu: host1x: mipi: Update tegra_mipi_request() to be node based

Srinivasan Shanmugam (1):
  drm/amdgpu: Fix missing break in ATOM_ARG_IMM Case of
    atom_get_src_int()

Stephan Gerhold (1):
  clk: qcom: reset: Allow specifying custom reset delay

Stuart Henderson (3):
  ASoC: wm8962: Enable oscillator if selecting WM8962_FLL_OSC
  ASoC: wm8962: Enable both SPKOUTR_ENA and SPKOUTL_ENA in mono mode
  ASoC: wm8962: Fix up incorrect error message in wm8962_set_fll

Takashi Iwai (1):
  ALSA: seq: fix function cast warnings

Takashi Sakamoto (1):
  firewire: core: use long bus reset on gap count error

Taniya Das (1):
  clk: qcom: gdsc: Add support to update GDSC transition delay

Thinh Tran (1):
  net/bnx2x: Prevent access to a freed page in page_pool

Thomas Zimmermann (1):
  arch/powerpc: Remove <linux/fb.h> from backlight code

Toke Høiland-Jørgensen (2):
  bpf: Fix hashtab overflow check on 32-bit arches
  bpf: Fix stackmap overflow check on 32-bit arches

Tudor Ambarus (1):
  tty: serial: samsung: fix tx_empty() to return TIOCSER_TEMT

Uwe Kleine-König (1):
  Input: gpio_keys_polled - suppress deferred probe error for gpio

Vinicius Costa Gomes (1):
  igb: Fix missing time sync events

Wang Jianjian (1):
  quota: Fix potential NULL pointer dereference

Xingyuan Mo (1):
  wifi: ath10k: fix NULL pointer dereference in
    ath10k_wmi_tlv_op_pull_mgmt_tx_compl_ev()

Yang Jihong (2):
  perf evsel: Fix duplicate initialization of data->id in
    evsel__parse_sample()
  perf thread_map: Free strlist on normal path in
    thread_map__new_by_tid_str()

Yewon Choi (1):
  rds: introduce acquire/release ordering in acquire/release_in_xmit()

Yuxuan Hu (1):
  Bluetooth: rfcomm: Fix null-ptr-deref in rfcomm_check_security

Zhipeng Lu (6):
  wifi: libertas: fix some memleaks in lbs_allocate_cmd_buffer()
  SUNRPC: fix some memleaks in gssx_dec_option_array
  media: v4l2-tpg: fix some memleaks in tpg_alloc
  media: v4l2-mem2mem: fix a memleak in v4l2_m2m_register_entity
  media: edia: dvbdev: fix a use-after-free
  media: go7007: fix a memleak in go7007_load_encoder

 .../testing/sysfs-bus-pci-devices-aer_stats   |  12 +-
 Documentation/filesystems/Locking             |   4 +-
 Makefile                                      |   4 +-
 arch/arm/boot/dts/arm-realview-pb1176.dts     |   2 +-
 arch/arm/boot/dts/r8a73a4-ape6evm.dts         |  12 +
 arch/arm/boot/dts/r8a73a4.dtsi                |   9 +-
 arch/arm/crypto/sha256_glue.c                 |  21 +-
 arch/arm/crypto/sha256_neon_glue.c            |  24 +-
 arch/arm/crypto/sha512-glue.c                 |  12 +-
 arch/mips/include/asm/ptrace.h                |   1 +
 arch/powerpc/include/asm/backlight.h          |   5 +-
 arch/powerpc/perf/hv-gpci.c                   |  29 ++-
 .../platforms/embedded6xx/linkstation.c       |   3 -
 arch/powerpc/platforms/embedded6xx/mpc10x.h   |   3 +
 arch/powerpc/platforms/powermac/backlight.c   |  26 --
 arch/sparc/kernel/leon_pci_grpci1.c           |   2 +-
 arch/sparc/kernel/leon_pci_grpci2.c           |   2 +-
 arch/x86/tools/relocs.c                       |   8 +
 arch/x86/xen/smp.c                            |  12 +
 block/genhd.c                                 |   8 +-
 block/ioctl.c                                 |   5 +
 block/opal_proto.h                            |   1 +
 block/sed-opal.c                              |   6 +-
 crypto/af_alg.c                               |  31 ++-
 crypto/algif_aead.c                           |  10 +-
 crypto/algif_skcipher.c                       |  11 +-
 drivers/acpi/processor_idle.c                 |   2 +
 drivers/acpi/scan.c                           |   8 +-
 drivers/block/aoe/aoecmd.c                    |  12 +-
 drivers/block/aoe/aoenet.c                    |   1 +
 drivers/bus/Kconfig                           |   5 +-
 drivers/clk/hisilicon/clk-hi3519.c            |   2 +-
 drivers/clk/qcom/dispcc-sdm845.c              |   2 +
 drivers/clk/qcom/gdsc.c                       |  26 +-
 drivers/clk/qcom/gdsc.h                       |   8 +-
 drivers/clk/qcom/reset.c                      |  33 +--
 drivers/clk/qcom/reset.h                      |   2 +
 drivers/cpufreq/brcmstb-avs-cpufreq.c         |   2 +
 drivers/firewire/core-card.c                  |  14 +-
 drivers/gpu/drm/amd/amdgpu/atom.c             |   2 +-
 drivers/gpu/drm/mediatek/mtk_drm_crtc.c       |  12 +-
 drivers/gpu/drm/mediatek/mtk_dsi.c            |  10 +-
 drivers/gpu/drm/radeon/ni.c                   |   2 +-
 drivers/gpu/drm/rockchip/inno_hdmi.c          |   4 +-
 drivers/gpu/drm/rockchip/rockchip_lvds.c      |   3 +-
 drivers/gpu/drm/tegra/dsi.c                   |  49 ++--
 drivers/gpu/drm/tegra/fb.c                    |   1 +
 drivers/gpu/host1x/mipi.c                     |   4 +-
 drivers/input/keyboard/gpio_keys_polled.c     |  10 +-
 drivers/iommu/amd_iommu_init.c                |   3 +
 drivers/md/dm-crypt.c                         |   4 +-
 drivers/md/dm-raid.c                          |   4 +-
 drivers/md/dm-verity.h                        |   4 +-
 drivers/md/dm.c                               |  26 +-
 drivers/md/md.c                               |  95 +++----
 drivers/media/common/v4l2-tpg/v4l2-tpg-core.c |  52 +++-
 drivers/media/dvb-core/dvbdev.c               |  95 +++++--
 drivers/media/dvb-frontends/drx39xyj/drxj.c   |   5 +-
 drivers/media/dvb-frontends/stv0367.c         |  34 +--
 drivers/media/i2c/tc358743.c                  |   7 +-
 drivers/media/usb/em28xx/em28xx-cards.c       |   4 +
 drivers/media/usb/go7007/go7007-driver.c      |   8 +-
 drivers/media/usb/go7007/go7007-usb.c         |   4 +-
 drivers/media/usb/pvrusb2/pvrusb2-context.c   |  10 +-
 drivers/media/usb/pvrusb2/pvrusb2-dvb.c       |   6 +-
 drivers/media/usb/pvrusb2/pvrusb2-v4l2.c      |   6 +-
 drivers/media/v4l2-core/v4l2-mem2mem.c        |  10 +-
 drivers/mfd/syscon.c                          |   4 +-
 drivers/mmc/host/wmt-sdmmc.c                  |   4 -
 drivers/mtd/nand/raw/lpc32xx_mlc.c            |   5 +-
 .../net/ethernet/broadcom/bnx2x/bnx2x_cmn.h   |   6 +-
 drivers/net/ethernet/intel/igb/igb_main.c     | 112 ++++-----
 .../ethernet/netronome/nfp/flower/lag_conf.c  |   5 +
 drivers/net/usb/sr9800.c                      |   4 +-
 drivers/net/wireless/ath/ath10k/wmi-tlv.c     |   4 +
 drivers/net/wireless/broadcom/b43/b43.h       |  16 ++
 drivers/net/wireless/broadcom/b43/dma.c       |   8 +-
 drivers/net/wireless/broadcom/b43/main.c      |  22 +-
 drivers/net/wireless/broadcom/b43/pio.c       |   6 +-
 .../broadcom/brcm80211/brcmsmac/phy/phy_cmn.c |   3 +-
 .../broadcom/brcm80211/brcmsmac/phy_shim.c    |   5 +-
 .../broadcom/brcm80211/brcmsmac/phy_shim.h    |   2 +-
 drivers/net/wireless/marvell/libertas/cmd.c   |  13 +-
 .../net/wireless/marvell/mwifiex/debugfs.c    |   3 -
 drivers/pci/quirks.c                          |   1 +
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
 drivers/tty/serial/8250/8250_exar.c           |   5 +-
 drivers/tty/serial/max310x.c                  |   2 +-
 drivers/tty/serial/samsung.c                  |   5 +-
 drivers/usb/gadget/udc/net2272.c              |   2 +-
 drivers/usb/phy/phy-generic.c                 |   7 +
 drivers/video/backlight/da9052_bl.c           |   1 +
 drivers/video/backlight/lm3630a_bl.c          |  15 +-
 drivers/video/backlight/lm3639_bl.c           |   1 +
 drivers/video/backlight/lp8788_bl.c           |   1 +
 fs/fhandle.c                                  |   2 +-
 fs/nfs/nfsroot.c                              |   4 +-
 fs/quota/dquot.c                              | 238 ++++++++----------
 fs/select.c                                   |   2 +-
 include/crypto/if_alg.h                       |  11 +-
 include/drm/drm_fixed.h                       |   2 +-
 include/linux/blkdev.h                        |   3 +-
 include/linux/host1x.h                        |   3 +-
 include/linux/poll.h                          |   4 -
 include/linux/qcom_scm.h                      |   4 +-
 include/media/dvbdev.h                        |  15 ++
 kernel/bpf/hashtab.c                          |  14 +-
 kernel/bpf/stackmap.c                         |   9 +-
 kernel/time/timekeeping.c                     |  24 +-
 net/bluetooth/hci_core.c                      |   2 +-
 net/bluetooth/hci_event.c                     |   2 -
 net/bluetooth/rfcomm/core.c                   |   2 +-
 net/core/sock_diag.c                          |  10 +-
 net/hsr/hsr_forward.c                         |   8 +-
 net/hsr/hsr_framereg.c                        |   8 +-
 net/hsr/hsr_main.c                            |  15 +-
 net/ipv4/tcp.c                                |   4 +-
 net/ipv4/udp.c                                |   4 +-
 net/ipv6/fib6_rules.c                         |   6 +
 net/iucv/iucv.c                               |   4 +-
 net/kcm/kcmsock.c                             |   3 +-
 net/l2tp/l2tp_ppp.c                           |   4 +-
 net/rds/send.c                                |   5 +-
 net/sunrpc/addr.c                             |   4 +-
 net/sunrpc/auth_gss/gss_rpc_xdr.c             |  27 +-
 net/unix/garbage.c                            |   2 +-
 net/x25/af_x25.c                              |   4 +-
 scripts/kconfig/zconf.l                       |   7 +-
 sound/core/seq/seq_midi.c                     |   8 +-
 sound/core/seq/seq_virmidi.c                  |   9 +-
 sound/soc/codecs/rt5645.c                     |  10 +
 sound/soc/codecs/wm8962.c                     |  29 ++-
 sound/soc/intel/boards/bytcr_rt5640.c         |  12 +
 sound/soc/meson/axg-tdm-interface.c           |   4 +-
 sound/usb/stream.c                            |   5 +-
 tools/perf/util/evsel.c                       |   1 -
 tools/perf/util/thread_map.c                  |   2 +-
 147 files changed, 1027 insertions(+), 733 deletions(-)

-- 
2.43.0


