Return-Path: <linux-kernel+bounces-47448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CF41844E13
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 01:44:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 761D31F2BE81
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 00:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9F693FE1;
	Thu,  1 Feb 2024 00:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="M86fnK/7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851894403;
	Thu,  1 Feb 2024 00:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706748250; cv=none; b=VRs215FCNSJr6ynrP9gewJv2CoNoEXpB0lB6EFDXFBTDrYLbeRCFtipzvc6MAb5WiJhv41Zwlp5qdVEvXPJ48kDLgs5feksKzCPPoVOw+SJ4wLbn1VC267HmKkMvjBUTqzL0NN+37FX0AMeALZYvIzjEoTBen9tkTK7d8ycjBCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706748250; c=relaxed/simple;
	bh=HN5G7Woe/6FiqdLtDh5lxIB+L1AYP6X7oc8rqZ6A8i4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Jm0sMPuP5Lkr+NbQlxv7JiVD6HJF5hD8gWN+MfWIbU5c27vBeze8n7FGlmFDcwYTXJBp7CgOww/SLIBx5vlBeUeqQRFYmQ32xUFMAyWPT6OZIR+ncRywU7CistiNvYjWOZ6SVShR2pUaoqlPSKariB7MLF2wEYZWjGAgDDJerew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=M86fnK/7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00C45C43399;
	Thu,  1 Feb 2024 00:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706748250;
	bh=HN5G7Woe/6FiqdLtDh5lxIB+L1AYP6X7oc8rqZ6A8i4=;
	h=From:To:Cc:Subject:Date:From;
	b=M86fnK/72SWFzLs5QwPITLO7xeTamVTA5CDmpuqUBtGD5GIp9Ye8EvVjtLynY8tgB
	 ONKRjP1waFmnCGS+nvmKzIAFe1vmgL+61kkMgzOg785kjFGc04glH+I+P9YBBKziEg
	 OH1OqoW8YNPGPPDhBUyKyB9+OF8V87ApFtBgSUMU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.1.76
Date: Wed, 31 Jan 2024 16:44:06 -0800
Message-ID: <2024013107-passive-emphatic-7fb4@gregkh>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.1.76 kernel.

All users of the 6.1 kernel series must upgrade.

The updated 6.1.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.1.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/ABI/testing/sysfs-class-devfreq                         |    3 
 Documentation/admin-guide/abi-obsolete.rst                            |    2 
 Documentation/admin-guide/abi-removed.rst                             |    2 
 Documentation/admin-guide/abi-stable.rst                              |    2 
 Documentation/admin-guide/abi-testing.rst                             |    2 
 Documentation/filesystems/directory-locking.rst                       |   29 
 Documentation/filesystems/locking.rst                                 |    5 
 Documentation/filesystems/porting.rst                                 |   18 
 Documentation/sphinx/kernel_abi.py                                    |   56 -
 Makefile                                                              |    2 
 arch/alpha/kernel/rtc.c                                               |    2 
 arch/arm/boot/dts/exynos4210-i9100.dts                                |    8 
 arch/arm/boot/dts/qcom-sdx55.dtsi                                     |   10 
 arch/arm64/Kconfig                                                    |    4 
 arch/arm64/boot/dts/qcom/sc7180.dtsi                                  |    4 
 arch/arm64/boot/dts/qcom/sc7280.dtsi                                  |    4 
 arch/arm64/boot/dts/qcom/sdm845.dtsi                                  |   16 
 arch/arm64/boot/dts/qcom/sm8150.dtsi                                  |   16 
 arch/arm64/boot/install.sh                                            |    3 
 arch/arm64/kernel/cpu_errata.c                                        |    4 
 arch/arm64/kernel/entry.S                                             |    2 
 arch/arm64/tools/cpucaps                                              |    2 
 arch/loongarch/kernel/smp.c                                           |    3 
 arch/mips/kernel/elf.c                                                |    6 
 arch/mips/lantiq/prom.c                                               |    7 
 arch/mips/mm/init.c                                                   |   12 
 arch/parisc/kernel/firmware.c                                         |    4 
 arch/powerpc/Kconfig                                                  |    1 
 arch/s390/crypto/aes_s390.c                                           |    4 
 arch/s390/crypto/paes_s390.c                                          |    4 
 arch/x86/include/asm/syscall_wrapper.h                                |   25 
 arch/x86/kernel/hpet.c                                                |    2 
 arch/x86/kernel/rtc.c                                                 |    2 
 arch/x86/kvm/svm/nested.c                                             |   14 
 block/ioctl.c                                                         |    2 
 block/partitions/core.c                                               |    5 
 crypto/algapi.c                                                       |    1 
 drivers/base/power/main.c                                             |  160 +---
 drivers/base/power/trace.c                                            |    2 
 drivers/block/nbd.c                                                   |    6 
 drivers/block/rbd.c                                                   |   22 
 drivers/bus/mhi/ep/main.c                                             |   68 +
 drivers/bus/mhi/host/main.c                                           |   29 
 drivers/char/hw_random/core.c                                         |   34 
 drivers/cpufreq/intel_pstate.c                                        |   55 -
 drivers/cxl/core/region.c                                             |    4 
 drivers/devfreq/devfreq.c                                             |   57 +
 drivers/dma/dmaengine.c                                               |    3 
 drivers/firmware/arm_scmi/common.h                                    |    1 
 drivers/firmware/arm_scmi/mailbox.c                                   |   14 
 drivers/firmware/arm_scmi/shmem.c                                     |    6 
 drivers/gpio/gpio-eic-sprd.c                                          |   32 
 drivers/gpio/gpiolib-acpi.c                                           |   14 
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c                               |    2 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c                     |    3 
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c        |   21 
 drivers/gpu/drm/amd/display/modules/power/power_helpers.c             |    2 
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c                             |   13 
 drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c                        |    2 
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c                        |    2 
 drivers/gpu/drm/bridge/analogix/anx7625.c                             |    7 
 drivers/gpu/drm/bridge/analogix/anx7625.h                             |    2 
 drivers/gpu/drm/bridge/nxp-ptn3460.c                                  |    6 
 drivers/gpu/drm/bridge/parade-ps8640.c                                |   23 
 drivers/gpu/drm/bridge/sii902x.c                                      |   68 -
 drivers/gpu/drm/drm_plane.c                                           |    1 
 drivers/gpu/drm/exynos/exynos5433_drm_decon.c                         |    4 
 drivers/gpu/drm/exynos/exynos_drm_fimd.c                              |    4 
 drivers/gpu/drm/exynos/exynos_drm_gsc.c                               |    2 
 drivers/gpu/drm/nouveau/nouveau_vmm.c                                 |    3 
 drivers/gpu/drm/panel/panel-edp.c                                     |    4 
 drivers/gpu/drm/panel/panel-simple.c                                  |    2 
 drivers/gpu/drm/tidss/tidss_crtc.c                                    |   10 
 drivers/iio/adc/ad7091r-base.c                                        |  169 ++++
 drivers/iio/adc/ad7091r-base.h                                        |    8 
 drivers/iio/adc/ad7091r5.c                                            |   28 
 drivers/media/common/videobuf2/videobuf2-dma-sg.c                     |   10 
 drivers/media/i2c/imx355.c                                            |   12 
 drivers/media/i2c/ov13b10.c                                           |   86 +-
 drivers/media/i2c/ov9734.c                                            |   19 
 drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c                  |    6 
 drivers/mmc/core/block.c                                              |   46 +
 drivers/mmc/host/mmc_spi.c                                            |  186 ----
 drivers/net/ethernet/broadcom/bnxt/bnxt.c                             |    5 
 drivers/net/ethernet/freescale/fec_main.c                             |    2 
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c                       |   27 
 drivers/net/ethernet/mellanox/mlx5/core/en/fs_tt_redirect.c           |    1 
 drivers/net/ethernet/mellanox/mlx5/core/en/params.c                   |    4 
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.h              |    2 
 drivers/net/ethernet/mellanox/mlx5/core/en_arfs.c                     |   26 
 drivers/net/ethernet/mellanox/mlx5/core/lib/aso.c                     |    2 
 drivers/net/ethernet/mellanox/mlx5/core/steering/dr_action.c          |   17 
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c                     |    3 
 drivers/net/fjes/fjes_hw.c                                            |   37 
 drivers/net/hyperv/netvsc_drv.c                                       |    4 
 drivers/net/phy/micrel.c                                              |   11 
 drivers/net/tun.c                                                     |   10 
 drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c                      |    2 
 drivers/opp/core.c                                                    |    6 
 drivers/parisc/power.c                                                |    2 
 drivers/platform/x86/intel/uncore-frequency/uncore-frequency-common.c |   64 -
 drivers/platform/x86/intel/uncore-frequency/uncore-frequency-common.h |   20 
 drivers/platform/x86/p2sb.c                                           |  180 +++-
 drivers/rpmsg/virtio_rpmsg_bus.c                                      |    1 
 drivers/rtc/rtc-cmos.c                                                |   28 
 drivers/rtc/rtc-mc146818-lib.c                                        |   39 -
 drivers/s390/crypto/vfio_ap_ops.c                                     |   72 -
 drivers/spi/spi-bcm-qspi.c                                            |    4 
 drivers/spi/spi.c                                                     |    4 
 drivers/thermal/intel/intel_hfi.c                                     |  106 ++
 drivers/tty/serial/sc16is7xx.c                                        |  389 +++++-----
 drivers/ufs/core/ufshcd.c                                             |    7 
 drivers/usb/dwc3/gadget.c                                             |   70 -
 fs/afs/dir.c                                                          |    8 
 fs/btrfs/ctree.h                                                      |    1 
 fs/btrfs/delayed-inode.c                                              |    5 
 fs/btrfs/delayed-inode.h                                              |    1 
 fs/btrfs/extent-tree.c                                                |   53 +
 fs/btrfs/inode.c                                                      |  172 ++--
 fs/btrfs/ioctl.c                                                      |    7 
 fs/btrfs/ref-verify.c                                                 |    6 
 fs/btrfs/sysfs.c                                                      |    4 
 fs/btrfs/tree-checker.c                                               |    2 
 fs/dlm/lowcomms.c                                                     |   14 
 fs/erofs/decompressor.c                                               |   49 -
 fs/exec.c                                                             |    3 
 fs/ext4/mballoc.c                                                     |   15 
 fs/fscache/cache.c                                                    |    3 
 fs/ioctl.c                                                            |    3 
 fs/namei.c                                                            |   60 -
 fs/pipe.c                                                             |   19 
 fs/smb/server/connection.c                                            |    1 
 fs/smb/server/ksmbd_netlink.h                                         |    3 
 fs/smb/server/oplock.c                                                |   16 
 fs/smb/server/smb2pdu.c                                               |    8 
 fs/smb/server/transport_ipc.c                                         |    4 
 fs/ubifs/dir.c                                                        |    2 
 fs/xfs/xfs_super.c                                                    |   27 
 include/linux/async.h                                                 |    2 
 include/linux/lsm_hook_defs.h                                         |    2 
 include/linux/mc146818rtc.h                                           |    3 
 include/linux/mmzone.h                                                |   14 
 include/linux/pipe_fs_i.h                                             |   16 
 include/linux/rmap.h                                                  |    4 
 include/linux/security.h                                              |    9 
 include/linux/serial_core.h                                           |   79 ++
 include/linux/skmsg.h                                                 |    6 
 include/linux/syscalls.h                                              |    1 
 include/net/inet_connection_sock.h                                    |    8 
 include/net/inet_sock.h                                               |    5 
 include/net/llc_pdu.h                                                 |    6 
 include/net/sock.h                                                    |   18 
 include/uapi/linux/btrfs.h                                            |    3 
 kernel/async.c                                                        |   85 +-
 kernel/power/swap.c                                                   |   38 
 kernel/rcu/tree.c                                                     |   34 
 kernel/rcu/tree_exp.h                                                 |    3 
 kernel/time/tick-sched.c                                              |    5 
 kernel/trace/tracing_map.c                                            |    7 
 mm/page_alloc.c                                                       |   16 
 mm/sparse.c                                                           |   17 
 net/8021q/vlan_netlink.c                                              |    4 
 net/core/dev.c                                                        |    9 
 net/core/dev.h                                                        |    3 
 net/core/request_sock.c                                               |    3 
 net/core/sock.c                                                       |   11 
 net/ipv4/af_inet.c                                                    |    3 
 net/ipv4/inet_connection_sock.c                                       |    4 
 net/ipv4/tcp.c                                                        |    1 
 net/ipv6/af_inet6.c                                                   |    3 
 net/llc/af_llc.c                                                      |   24 
 net/llc/llc_core.c                                                    |    7 
 net/mac80211/sta_info.c                                               |    5 
 net/netfilter/nf_tables_api.c                                         |   20 
 net/netfilter/nft_chain_filter.c                                      |   11 
 net/netfilter/nft_compat.c                                            |   12 
 net/netfilter/nft_flow_offload.c                                      |    5 
 net/netfilter/nft_limit.c                                             |   23 
 net/netfilter/nft_nat.c                                               |    5 
 net/netfilter/nft_rt.c                                                |    5 
 net/netfilter/nft_socket.c                                            |    5 
 net/netfilter/nft_synproxy.c                                          |    7 
 net/netfilter/nft_tproxy.c                                            |    5 
 net/netfilter/nft_xfrm.c                                              |    5 
 net/netlink/af_netlink.c                                              |    2 
 net/rds/af_rds.c                                                      |    2 
 net/smc/smc_diag.c                                                    |    2 
 scripts/get_abi.pl                                                    |    2 
 security/security.c                                                   |   18 
 security/selinux/hooks.c                                              |   28 
 security/smack/smack_lsm.c                                            |    1 
 security/tomoyo/tomoyo.c                                              |    1 
 tools/testing/selftests/drivers/net/netdevsim/udp_tunnel_nic.sh       |    9 
 193 files changed, 2418 insertions(+), 1385 deletions(-)

Al Viro (1):
      rename(): fix the locking of subdirectories

Aleksander Jan Bajkowski (1):
      MIPS: lantiq: register smp_ops on non-smp platforms

Alfred Piccioni (1):
      lsm: new security_file_ioctl_compat() hook

Amelie Delaunay (1):
      dmaengine: fix NULL pointer in channel unregistration function

Andy Shevchenko (1):
      mmc: mmc_spi: remove custom DMA mapped buffers

Anthony Krowiak (1):
      s390/vfio-ap: unpin pages on gisc registration failure

Arec Kao (1):
      media: ov13b10: Support device probe in non-zero ACPI D state

Arnd Bergmann (1):
      drm/exynos: fix accidental on-stack copy of exynos_drm_plane

Avri Altman (1):
      mmc: core: Use mrq.sbc in close-ended ffu

Bart Van Assche (1):
      scsi: ufs: core: Remove the ufshcd_hba_exit() call from ufshcd_async_scan()

Bernd Edlinger (2):
      net: stmmac: Wait a bit for the reset to take effect
      exec: Fix error handling in begin_new_exec()

Bhaumik Bhatt (1):
      bus: mhi: host: Add spinlock to protect WP access when queueing TREs

Bingbu Cao (3):
      media: imx355: Enable runtime PM before registering async sub-device
      media: ov9734: Enable runtime PM before registering async sub-device
      media: ov13b10: Enable runtime PM before registering async sub-device

Charan Teja Kalla (2):
      mm/sparsemem: fix race in accessing memory_section->usage
      mm: page_alloc: unreserve highatomic page blocks before oom

Christian Marangi (1):
      PM / devfreq: Fix buffer overflow in trans_stat_show

Chung-Chiang Cheng (1):
      btrfs: tree-checker: fix inline ref size in error messages

Cristian Marussi (1):
      firmware: arm_scmi: Check mailbox/SMT channel for consistency

Dan Carpenter (3):
      netfs, fscache: Prevent Oops in fscache_put_cache()
      drm/bridge: nxp-ptn3460: fix i2c_master_send() error checking
      drm/bridge: nxp-ptn3460: simplify some error checking

Dave Airlie (1):
      nouveau/vmm: don't set addr on the fail path to avoid warning

Dave Chinner (1):
      xfs: read only mounts with fsopen mount API are busted

David Disseldorp (1):
      btrfs: sysfs: validate scrub_speed_max value

David Howells (1):
      afs: Hide silly-rename files from userspace

David Lechner (1):
      spi: fix finalize message on error return

David Sterba (1):
      btrfs: don't warn if discard range is not aligned to sector

Dinghao Liu (1):
      net/mlx5e: fix a potential double-free in fs_any_create_groups

Douglas Anderson (2):
      drm/bridge: parade-ps8640: Wait for HPD when doing an AUX transfer
      drm/bridge: parade-ps8640: Make sure we drop the AUX mutex in the error case

Emmanuel Grumbach (1):
      wifi: iwlwifi: fix a memory corruption

Eric Dumazet (3):
      llc: make llc_ui_sendmsg() more robust against bonding changes
      udp: fix busy polling
      nbd: always initialize struct msghdr completely

Fedor Pchelkin (2):
      btrfs: ref-verify: free ref cache before clearing mount opt
      drm/exynos: gsc: minor fix for loop iteration in gsc_runtime_resume

Filipe Manana (4):
      btrfs: fix infinite directory reads
      btrfs: set last dir index to the current last index when opening dir
      btrfs: refresh dir last index during a rewinddir(3) call
      btrfs: fix race between reading a directory and adding entries to it

Florian Westphal (3):
      netfilter: nft_limit: reject configurations that cause integer overflow
      netfilter: nf_tables: restrict anonymous set and map names to 16 bytes
      netfilter: nf_tables: reject QUEUE/DROP verdict parameters

Frederic Weisbecker (1):
      rcu: Defer RCU kthreads wakeup when CPU is dying

Gao Xiang (2):
      erofs: get rid of the remaining kmap_atomic()
      erofs: fix lz4 inplace decompression

Greg Kroah-Hartman (1):
      Linux 6.1.76

Helge Deller (2):
      parisc/firmware: Fix F-extend for PDC addresses
      parisc/power: Fix power soft-off button emulation on qemu

Herbert Xu (3):
      crypto: api - Disallow identical driver names
      hwrng: core - Fix page fault dead lock on mmap-ed hwrng
      crypto: s390/aes - Fix buffer overread in CTR mode

Hongchen Zhang (1):
      PM: hibernate: Enforce ordering during image compression/decompression

Horatiu Vultur (1):
      net: micrel: Fix PTP frame parsing for lan8814

Hsin-Yi Wang (2):
      drm/panel-edp: drm/panel-edp: Fix AUO B116XAK01 name and timing
      drm/bridge: anx7625: Ensure bridge is suspended in disable()

Huacai Chen (1):
      LoongArch/smp: Call rcutree_report_cpu_starting() earlier

Hugo Villeneuve (10):
      serial: sc16is7xx: improve regmap debugfs by using one regmap per port
      serial: sc16is7xx: remove wasteful static buffer in sc16is7xx_regmap_name()
      serial: sc16is7xx: remove global regmap from struct sc16is7xx_port
      serial: sc16is7xx: remove unused line structure member
      serial: sc16is7xx: change EFR lock to operate on each channels
      serial: sc16is7xx: convert from _raw_ to _noinc_ regmap functions for FIFO
      serial: sc16is7xx: fix invalid sc16is7xx_lines bitfield in case of probe error
      serial: sc16is7xx: remove obsolete loop in sc16is7xx_port_irq()
      serial: sc16is7xx: improve do/while loop in sc16is7xx_irq()
      serial: sc16is7xx: fix unconditional activation of THRI interrupt

Ilya Dryomov (1):
      rbd: don't move requests to the running list on errors

Jakub Kicinski (2):
      net: fix removing a namespace with conflicting altnames
      selftests: netdevsim: fix the udp_tunnel_nic test

Jenishkumar Maheshbhai Patel (1):
      net: mvpp2: clear BM pool before initialization

Johan Hovold (10):
      arm64: dts: qcom: sc7180: fix USB wakeup interrupt types
      arm64: dts: qcom: sdm845: fix USB wakeup interrupt types
      arm64: dts: qcom: sm8150: fix USB wakeup interrupt types
      arm64: dts: qcom: sc7280: fix usb_1 wakeup interrupt types
      arm64: dts: qcom: sdm845: fix USB DP/DM HS PHY interrupts
      arm64: dts: qcom: sm8150: fix USB DP/DM HS PHY interrupts
      ARM: dts: qcom: sdx55: fix USB wakeup interrupt types
      ARM: dts: qcom: sdx55: fix pdc '#interrupt-cells'
      ARM: dts: qcom: sdx55: fix USB DP/DM HS PHY interrupts
      ARM: dts: qcom: sdx55: fix USB SS wakeup

Johannes Berg (1):
      wifi: mac80211: fix potential sta-link leak

Jonathan Gray (1):
      Revert "drm/amd: Enable PCIe PME from D3"

Jordan Rife (1):
      dlm: use kernel_connect() and kernel_bind()

Josef Bacik (1):
      arm64: properly install vmlinuz.efi

Kamal Dasu (1):
      spi: bcm-qspi: fix SFDP BFPT read by usig mspi read

Krishna chaitanya chundru (1):
      bus: mhi: host: Add alignment check for event ring read pointer

Kuniyuki Iwashima (1):
      llc: Drop support for ETH_P_TR_802_2.

Leon Romanovsky (2):
      net/mlx5e: Allow software parsing when IPsec crypto is enabled
      net/mlx5e: Handle hardware IPsec limits events

Li Lingfeng (1):
      block: Move checking GENHD_FL_NO_PART to bdev_add_partition()

Li zeming (1):
      PM: core: Remove unnecessary (void *) conversions

Lin Ma (2):
      vlan: skip nested type that is not IFLA_VLAN_QOS_MAPPING
      ksmbd: fix global oob in ksmbd_nl_policy

Lukas Schauer (1):
      pipe: wakeup wr_wait after setting max_usage

Ma Jun (1):
      drm/amdgpu/pm: Fix the power source flag error

Manivannan Sadhasivam (1):
      bus: mhi: ep: Do not allocate event ring element on stack

Marcelo Schmitt (3):
      iio: adc: ad7091r: Set alert bit in config register
      iio: adc: ad7091r: Allow users to configure device events
      iio: adc: ad7091r: Enable internal vref if external vref is not supplied

Mario Limonciello (7):
      rtc: cmos: Use ACPI alarm for non-Intel x86 systems too
      rtc: Adjust failure return code for cmos_set_alarm()
      rtc: mc146818-lib: Adjust failure return code for mc146818_get_time()
      rtc: Add support for configuring the UIP timeout for RTC reads
      rtc: Extend timeout for waiting for UIP to clear to 1s
      gpiolib: acpi: Ignore touchpad wakeup on GPD G1619-04
      drm/amd/display: Disable PSR-SU on Parade 0803 TCON again

Markus Niebel (1):
      drm: panel-simple: add missing bus flags for Tianma tm070jvhg[30/33]

Matti Vaittinen (1):
      drm/bridge: sii902x: Use devm_regulator_bulk_get_enable()

Max Kellermann (1):
      fs/pipe: move check to pipe_has_watch_queue()

Michael Chan (1):
      bnxt_en: Wait for FLR to complete during probe

Michael Grzeschik (1):
      media: videobuf2-dma-sg: fix vmap callback

Michael Kelley (1):
      hv_netvsc: Calculate correct ring size when PAGE_SIZE is not 4 Kbytes

Namjae Jeon (5):
      ksmbd: set v2 lease version on lease upgrade
      ksmbd: fix potential circular locking issue in smb2_set_ea()
      ksmbd: don't increment epoch if current state and request state are same
      ksmbd: send lease break notification on FILE_RENAME_INFORMATION
      ksmbd: Add missing set_freezable() for freezable kthread

Naohiro Aota (2):
      btrfs: zoned: factor out prepare_allocation_zoned()
      btrfs: zoned: optimize hint byte for zoned allocator

Nathan Chancellor (1):
      platform/x86: intel-uncore-freq: Fix types in sysfs callbacks

Nicholas Kazlauskas (1):
      drm/amd/display: Port DENTIST hang and TDR fixes to OTG disable W/A

Omar Sandoval (2):
      btrfs: avoid copying BTRFS_ROOT_SUBVOL_DEAD flag to snapshot of subvolume being deleted
      btrfs: don't abort filesystem when attempting to snapshot deleted subvolume

Pablo Neira Ayuso (2):
      netfilter: nf_tables: validate NFPROTO_* family
      netfilter: nft_chain_filter: handle NETDEV_UNREGISTER for inet/ingress basechain

Paul Cercueil (1):
      ARM: dts: samsung: exynos4210-i9100: Unconditionally enable LDO12

Petr Pavlu (1):
      tracing: Ensure visibility when inserting an element into tracing_map

Pin-yen Lin (1):
      drm/bridge: parade-ps8640: Ensure bridge is suspended in .post_disable()

Qiang Yu (1):
      bus: mhi: host: Drop chan lock before queuing buffers

Qu Wenruo (1):
      btrfs: defrag: reject unknown flags of btrfs_ioctl_defrag_range_args

Quanquan Cao (1):
      cxl/region：Fix overflow issue in alloc_hpa()

Rafael J. Wysocki (4):
      async: Split async_schedule_node_domain()
      async: Introduce async_schedule_dev_nocall()
      cpufreq: intel_pstate: Refine computation of P-state for given frequency
      PM: sleep: Fix possible deadlocks in core system-wide PM code

Rahul Rameshbabu (1):
      net/mlx5: Use mlx5 device constant for selecting CQ period mode for ASO

Randy Dunlap (1):
      serial: core: fix kernel-doc for uart_port_unlock_irqrestore()

Ricardo Neri (3):
      thermal: intel: hfi: Refactor enabling code into helper functions
      thermal: intel: hfi: Disable an HFI instance when all its CPUs go offline
      thermal: intel: hfi: Add syscore callbacks for system-wide PM

Richard Palethorpe (1):
      x86/entry/ia32: Ensure s32 is sign extended to s64

Rob Herring (1):
      arm64: Rename ARM64_WORKAROUND_2966298

Salvatore Dipietro (1):
      tcp: Add memory barrier to tcp_push()

Sasha Levin (1):
      Revert "powerpc/64s: Increase default stack size to 32KB"

Sean Christopherson (1):
      Revert "nSVM: Check for reserved encodings of TLB_CONTROL in nested VMCB"

Serge Semin (1):
      mips: Fix max_mapnr being uninitialized on early stages

Sharath Srinivasan (1):
      net/rds: Fix UBSAN: array-index-out-of-bounds in rds_cmsg_recv

Shenwei Wang (1):
      net: fec: fix the unhandled context fault from smmu

Shin'ichiro Kawasaki (1):
      platform/x86: p2sb: Allow p2sb_bar() calls during PCI device probe

Steven Rostedt (Google) (1):
      mm/rmap: fix misplaced parenthesis of a likely()

Suraj Jitindar Singh (1):
      ext4: allow for the last group to be marked as trimmed

Thomas Gleixner (2):
      serial: core: Provide port lock wrappers
      serial: sc16is7xx: Use port lock wrappers

Tim Chen (1):
      tick/sched: Preserve number of idle sleeps across CPU hotplug events

Tomi Valkeinen (3):
      drm/tidss: Fix atomic_flush check
      drm/bridge: sii902x: Fix probing race issue
      drm/bridge: sii902x: Fix audio codec unregistration

Tony Krowiak (3):
      s390/vfio-ap: always filter entire AP matrix
      s390/vfio-ap: loop over the shadow APCB when filtering guest's AP configuration
      s390/vfio-ap: let on_scan_complete() callback filter matrix and update guest's APCB

Vegard Nossum (2):
      docs: kernel_abi.py: fix command injection
      scripts/get_abi: fix source path leak

Ville Syrjälä (1):
      drm: Don't unref the same fb many times by mistake due to deadlock handling

Viresh Kumar (1):
      OPP: Pass rounded rate to _set_opp()

Wayne Lin (1):
      drm/amd/display: pbn_div need be updated for hotplug event

Wen Gu (1):
      net/smc: fix illegal rmb_desc access in SMC-D connection dump

Wenhua Lin (1):
      gpio: eic-sprd: Clear interrupt after set the interrupt type

Wesley Cheng (3):
      usb: dwc3: gadget: Refactor EP0 forced stall/restart into a separate API
      usb: dwc3: gadget: Queue PM runtime idle on disconnect event
      usb: dwc3: gadget: Handle EP0 request dequeuing properly

Xi Ruoyao (1):
      mips: Call lose_fpu(0) before initializing fcr31 in mips_set_personality_nan

Xiaolei Wang (1):
      rpmsg: virtio: Free driver_override when rpmsg_remove()

Yevgeny Kliteynik (2):
      net/mlx5: DR, Use the right GVMI number for drop action
      net/mlx5: DR, Can't go to uplink vport on RX rule

Yunjian Wang (2):
      tun: fix missing dropped counter in tun_xdp_act
      tun: add missing rx stats accounting in tun_xdp_act

Zheng Wang (1):
      media: mtk-jpeg: Fix use after free bug due to error path handling in mtk_jpeg_dec_device_run

Zhengchao Shao (3):
      tcp: make sure init the accept_queue's spinlocks once
      netlink: fix potential sleeping issue in mqueue_flush_file
      ipv6: init the accept_queue's spinlocks in inet6_create

Zhihao Cheng (1):
      ubifs: ubifs_symlink: Fix memleak of inode->i_link in error path

Zhipeng Lu (2):
      net/mlx5e: fix a double-free in arfs_create_groups
      fjes: fix memleaks in fjes_hw_setup


