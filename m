Return-Path: <linux-kernel+bounces-39423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 256C883D0F7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 00:57:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30CCD1C24522
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 23:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1E0C134C7;
	Thu, 25 Jan 2024 23:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="y6gpQfXo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B7E125BD;
	Thu, 25 Jan 2024 23:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706227040; cv=none; b=dwx6zBpmoTgbsOPnQxn0rwezaubWp93Zw3pv98QklLU974+OLhiJJeR3+PvPbxWLK0sXhxKCOwFiNuvCOWjsqyRuirP3/T8IZOcESgfRCFcg9uz0jNs1iiihASFDfke3C2J65tQjl7cjihYrhmOVDKqUxHms/bbLkh2DmCRfil0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706227040; c=relaxed/simple;
	bh=+HnAuDnjkLFsae4e8CReMCIQIgqnr4sWCOgU5Z9RWDU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hcEwxDLW7Prkh9/Eqwi+MP55Ra/w50E7huB0881pGk4U+KBTC8MempwlqDjH5n/00Uhe/FAIDQPp1FDS506N3QbViUGqhbXOm4GH21/jqggtdAgXLJu3AziJGsrcPLvrF/JhPeWomcCVvPO1INprBa0o7dc671qzgilcR28J64k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=y6gpQfXo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3417C433C7;
	Thu, 25 Jan 2024 23:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706227040;
	bh=+HnAuDnjkLFsae4e8CReMCIQIgqnr4sWCOgU5Z9RWDU=;
	h=From:To:Cc:Subject:Date:From;
	b=y6gpQfXoZ30AZUUq/Hdk6n4EsHUOxYhC7Oafp5AUgf7gVCLcoOWqP19hsB7GoXEBv
	 Zp5bhISZ5Bxbcr81X59grB+vjGT4f5O8j/k/m16pn9s4Bw0eQo7OsjuzXYaMv/gA7t
	 cbShkWB2GcI3L6oBt9YyIWZf2qjSRV8BiG4Ts3O4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 4.19.306
Date: Thu, 25 Jan 2024 15:57:17 -0800
Message-ID: <2024012518-flick-uncurious-f9bc@gregkh>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 4.19.306 kernel.

All users of the 4.19 kernel series must upgrade.

The updated 4.19.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-4.19.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                                     |    2 
 arch/arc/kernel/signal.c                                     |    6 
 arch/arm/boot/dts/qcom-apq8064.dtsi                          |    2 
 arch/arm/mach-sunxi/mc_smp.c                                 |    4 
 arch/mips/alchemy/devboards/db1200.c                         |    2 
 arch/mips/alchemy/devboards/db1550.c                         |    2 
 arch/powerpc/Kconfig                                         |   14 -
 arch/powerpc/Kconfig.debug                                   |    6 
 arch/powerpc/lib/Makefile                                    |    2 
 arch/powerpc/perf/imc-pmu.c                                  |    6 
 arch/powerpc/platforms/40x/Kconfig                           |    9 
 arch/powerpc/platforms/44x/Kconfig                           |   23 -
 arch/powerpc/platforms/82xx/Kconfig                          |    1 
 arch/powerpc/platforms/Kconfig                               |   21 -
 arch/powerpc/platforms/Kconfig.cputype                       |    4 
 arch/powerpc/platforms/cell/Kconfig                          |    3 
 arch/powerpc/platforms/maple/Kconfig                         |    1 
 arch/powerpc/platforms/pasemi/Kconfig                        |    1 
 arch/powerpc/platforms/powernv/Kconfig                       |    1 
 arch/powerpc/platforms/powernv/opal-irqchip.c                |    2 
 arch/powerpc/platforms/ps3/Kconfig                           |    2 
 arch/powerpc/platforms/pseries/Kconfig                       |    2 
 arch/powerpc/platforms/pseries/hotplug-memory.c              |   21 -
 arch/powerpc/sysdev/Kconfig                                  |    5 
 arch/powerpc/sysdev/xive/Kconfig                             |    3 
 arch/x86/lib/misc.c                                          |    2 
 crypto/af_alg.c                                              |   14 +
 crypto/scompress.c                                           |  135 +++++------
 drivers/acpi/acpi_lpit.c                                     |    2 
 drivers/acpi/acpi_video.c                                    |   12 
 drivers/acpi/property.c                                      |    4 
 drivers/android/binder.c                                     |    2 
 drivers/android/binder_alloc.c                               |   21 -
 drivers/bluetooth/btmtkuart.c                                |   11 
 drivers/clk/rockchip/clk-rk3128.c                            |    2 
 drivers/crypto/ccp/ccp-ops.c                                 |    5 
 drivers/crypto/sahara.c                                      |  127 +++-------
 drivers/crypto/virtio/virtio_crypto_common.h                 |    2 
 drivers/crypto/virtio/virtio_crypto_core.c                   |   26 +-
 drivers/edac/thunderx_edac.c                                 |   10 
 drivers/firmware/ti_sci.c                                    |   10 
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c                  |    4 
 drivers/gpu/drm/amd/amdgpu/kv_dpm.c                          |    4 
 drivers/gpu/drm/amd/amdgpu/si_dpm.c                          |    5 
 drivers/gpu/drm/drm_crtc.c                                   |    8 
 drivers/gpu/drm/drm_drv.c                                    |   10 
 drivers/gpu/drm/exynos/exynos_hdmi.c                         |    2 
 drivers/gpu/drm/msm/disp/mdp4/mdp4_crtc.c                    |    9 
 drivers/gpu/drm/radeon/r100.c                                |    4 
 drivers/gpu/drm/radeon/r600_cs.c                             |    4 
 drivers/gpu/drm/radeon/radeon_display.c                      |    7 
 drivers/gpu/drm/radeon/radeon_vm.c                           |    8 
 drivers/gpu/drm/radeon/si.c                                  |    4 
 drivers/gpu/drm/radeon/sumo_dpm.c                            |    4 
 drivers/gpu/drm/radeon/trinity_dpm.c                         |    4 
 drivers/hid/wacom_wac.c                                      |   32 --
 drivers/hwtracing/coresight/coresight-etm4x.h                |    2 
 drivers/i2c/busses/i2c-s3c2410.c                             |   40 +--
 drivers/infiniband/hw/mthca/mthca_cmd.c                      |    4 
 drivers/infiniband/hw/mthca/mthca_main.c                     |    2 
 drivers/input/joystick/xpad.c                                |    1 
 drivers/input/keyboard/atkbd.c                               |   50 +++-
 drivers/input/serio/i8042-x86ia64io.h                        |    8 
 drivers/media/dvb-core/dvbdev.c                              |    2 
 drivers/media/usb/cx231xx/cx231xx-core.c                     |    2 
 drivers/media/usb/pvrusb2/pvrusb2-context.c                  |    3 
 drivers/mmc/host/Kconfig                                     |    5 
 drivers/mtd/mtd_blkdevs.c                                    |    4 
 drivers/mtd/nand/raw/fsl_ifc_nand.c                          |    2 
 drivers/net/dsa/vitesse-vsc73xx.c                            |    2 
 drivers/net/ethernet/broadcom/tg3.c                          |   11 
 drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c           |    2 
 drivers/net/ethernet/renesas/ravb_main.c                     |    2 
 drivers/net/wireless/marvell/libertas/Kconfig                |    2 
 drivers/net/wireless/marvell/mwifiex/cfg80211.c              |    2 
 drivers/net/wireless/marvell/mwifiex/fw.h                    |    1 
 drivers/net/wireless/marvell/mwifiex/ioctl.h                 |    1 
 drivers/net/wireless/marvell/mwifiex/uap_cmd.c               |    8 
 drivers/net/wireless/realtek/rtlwifi/pci.c                   |   79 +-----
 drivers/net/wireless/realtek/rtlwifi/pci.h                   |    5 
 drivers/net/wireless/realtek/rtlwifi/rtl8188ee/phy.c         |   20 -
 drivers/net/wireless/realtek/rtlwifi/rtl8192c/phy_common.c   |   16 -
 drivers/net/wireless/realtek/rtlwifi/rtl8192c/phy_common.h   |    1 
 drivers/net/wireless/realtek/rtlwifi/rtl8192ce/phy.c         |    6 
 drivers/net/wireless/realtek/rtlwifi/rtl8192ce/phy.h         |    1 
 drivers/net/wireless/realtek/rtlwifi/rtl8192cu/phy.c         |    6 
 drivers/net/wireless/realtek/rtlwifi/rtl8192de/phy.c         |   66 +----
 drivers/net/wireless/realtek/rtlwifi/rtl8192ee/phy.c         |   20 -
 drivers/net/wireless/realtek/rtlwifi/rtl8192se/phy.c         |   20 -
 drivers/net/wireless/realtek/rtlwifi/rtl8723com/phy_common.c |    8 
 drivers/net/wireless/realtek/rtlwifi/rtl8821ae/phy.c         |   19 -
 drivers/net/wireless/realtek/rtlwifi/wifi.h                  |    7 
 drivers/net/xen-netback/netback.c                            |   44 +++
 drivers/of/base.c                                            |    1 
 drivers/of/unittest-data/tests-phandle.dtsi                  |   10 
 drivers/of/unittest.c                                        |   74 +++---
 drivers/reset/hisilicon/hi6220_reset.c                       |    2 
 drivers/s390/block/scm_blk.c                                 |    7 
 drivers/scsi/hisi_sas/hisi_sas_main.c                        |    4 
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c                       |    2 
 drivers/tty/serial/imx.c                                     |    2 
 drivers/uio/uio.c                                            |    7 
 drivers/usb/chipidea/core.c                                  |    7 
 drivers/usb/dwc3/core.c                                      |   39 ---
 drivers/usb/dwc3/ep0.c                                       |    5 
 drivers/usb/mon/mon_bin.c                                    |    7 
 drivers/usb/phy/phy-mxs-usb.c                                |    3 
 drivers/usb/typec/class.c                                    |    4 
 drivers/video/fbdev/core/fb_defio.c                          |    6 
 drivers/watchdog/bcm2835_wdt.c                               |    3 
 drivers/watchdog/hpwdt.c                                     |    2 
 drivers/watchdog/watchdog_dev.c                              |    3 
 fs/f2fs/namei.c                                              |    2 
 fs/f2fs/xattr.c                                              |    6 
 fs/jbd2/journal.c                                            |    4 
 fs/nfs/blocklayout/blocklayout.c                             |    2 
 fs/nfs/nfs4proc.c                                            |    3 
 fs/nfsd/nfs4state.c                                          |   12 
 fs/pstore/ram_core.c                                         |    2 
 include/crypto/if_alg.h                                      |    3 
 include/drm/drm_bridge.h                                     |    2 
 include/net/bluetooth/hci_core.h                             |    1 
 kernel/bpf/lpm_trie.c                                        |    3 
 kernel/debug/kdb/kdb_main.c                                  |   14 -
 kernel/dma/coherent.c                                        |    4 
 kernel/time/tick-sched.c                                     |    5 
 kernel/trace/ring_buffer.c                                   |    6 
 kernel/trace/trace.c                                         |    6 
 kernel/trace/trace_output.c                                  |    6 
 net/bluetooth/hci_conn.c                                     |    8 
 net/bluetooth/hci_event.c                                    |   11 
 net/ipv6/ip6_tunnel.c                                        |   26 +-
 net/ncsi/internal.h                                          |    9 
 net/ncsi/ncsi-netlink.c                                      |    4 
 net/ncsi/ncsi-pkt.h                                          |    7 
 net/ncsi/ncsi-rsp.c                                          |   26 +-
 net/netfilter/ipvs/ip_vs_xmit.c                              |    4 
 net/netlabel/netlabel_calipso.c                              |   52 ++--
 net/netlabel/netlabel_cipso_v4.c                             |    4 
 net/netlabel/netlabel_mgmt.c                                 |    8 
 net/netlabel/netlabel_unlabeled.c                            |   10 
 net/netlabel/netlabel_user.h                                 |    4 
 security/apparmor/policy_unpack.c                            |    4 
 security/selinux/hooks.c                                     |    7 
 sound/pci/oxygen/oxygen_mixer.c                              |    2 
 sound/soc/atmel/sam9g20_wm8731.c                             |   61 ++++
 sound/soc/codecs/cs35l33.c                                   |    4 
 sound/soc/codecs/cs35l34.c                                   |    4 
 sound/soc/codecs/cs43130.c                                   |    6 
 sound/soc/codecs/da7219-aad.c                                |    2 
 sound/soc/codecs/rt5645.c                                    |   10 
 sound/soc/intel/skylake/skl-pcm.c                            |    5 
 tools/perf/util/genelf.c                                     |    6 
 tools/testing/selftests/powerpc/math/fpu_preempt.c           |    9 
 tools/testing/selftests/powerpc/math/vmx_preempt.c           |   10 
 155 files changed, 859 insertions(+), 826 deletions(-)

Alex Deucher (1):
      drm/amdgpu/debugfs: fix error code when smc register accessors are NULL

Andrew Lunn (1):
      net: netlabel: Fix kerneldoc warnings

Arnd Bergmann (2):
      EDAC/thunderx: Fix possible out-of-bounds string access
      wifi: libertas: stop selecting wext

Bartlomiej Zolnierkiewicz (1):
      powerpc: remove redundant 'default n' from Kconfig-s

Benjamin Coddington (1):
      blocklayoutdriver: Fix reference leak of pnfs_device_node

Bhaskar Chowdhury (1):
      ncsi: internal.h: Fix a spello

Carlos Llamas (5):
      binder: use EPOLLERR from eventpoll.h
      binder: fix comment on binder_alloc_new_buf() return value
      binder: fix async space check for 0-sized buffers
      binder: fix race between mmput() and do_exit()
      binder: fix unused alloc->free_async_space

Chao Yu (1):
      f2fs: fix to avoid dirent corruption

Chengming Zhou (1):
      crypto: scomp - fix req->dst buffer overflow

Christian A. Ehrhardt (1):
      of: Fix double free in of_parse_phandle_with_args_map

Christoph Niedermaier (1):
      serial: imx: Correct clock error message in function probe()

Christophe JAILLET (4):
      firmware: ti_sci: Fix an off-by-one in ti_sci_debugfs_create()
      MIPS: Alchemy: Fix an out-of-bound access in db1200_dev_setup()
      MIPS: Alchemy: Fix an out-of-bound access in db1550_dev_setup()
      kdb: Fix a potential buffer overflow in kdb_local()

Colin Ian King (2):
      x86/lib: Fix overflow when counting digits
      rtlwifi: rtl8192de: make arrays static const, makes object smaller

Curtis Klein (1):
      watchdog: set cdev owner before adding

Dan Carpenter (1):
      media: dvbdev: drop refcount on error path in dvb_device_open()

Daniel Thompson (1):
      kdb: Censor attempts to set PROMPT without ENABLE_MEM_READ

Dario Binacchi (1):
      drm/bridge: Fix typo in post_disable() description

David Lin (1):
      wifi: mwifiex: configure BSSID consistently when starting AP

David Rau (1):
      ASoC: da7219: Support low DC impedance headset

Dinghao Liu (1):
      crypto: ccp - fix memleak in ccp_init_dm_workarea

Dmitry Baryshkov (3):
      ARM: dts: qcom: apq8064: correct XOADC register address
      drm/msm/mdp4: flush vblank event on disable
      drm/drv: propagate errors from drm_modeset_register_all()

Eric Biggers (1):
      f2fs: explicitly null-terminate the xattr list

Eric Dumazet (1):
      ip6_tunnel: fix NEXTHDR_FRAGMENT handling in ip6_tnl_parse_tlv_enc_lim()

Esther Shimanovich (1):
      Input: i8042 - add nomux quirk for Acer P459-G2-M

Fedor Pchelkin (2):
      apparmor: avoid crash when parsed profile name is empty
      ipvs: avoid stat macros calls from preemptible context

Florian Lehner (1):
      bpf, lpm: Fix check prefixlen before walking trie

Francesco Dolcini (1):
      Bluetooth: btmtkuart: fix recv_buf() return value

Gavrilov Ilia (1):
      calipso: fix memory leak in netlbl_calipso_add_pass()

Geert Uytterhoeven (1):
      of: unittest: Fix of_count_phandle_with_args() expected value message

Gonglei (Arei) (1):
      crypto: virtio - Handle dataq logic with tasklet

Greg Kroah-Hartman (3):
      Revert "ASoC: atmel: Remove system clock tree configuration for at91sam9g20ek"
      Revert "NFSD: Fix possible sleep during nfsd4_release_lockowner()"
      Linux 4.19.306

Guanghui Feng (1):
      uio: Fix use-after-free in uio_open

Gui-Dong Han (1):
      usb: mon: Fix atomicity violation in mon_bin_vma_fault

Hans de Goede (2):
      Input: atkbd - skip ATKBD_CMD_GETID in translated mode
      Input: atkbd - use ab83 as id when skipping the getid command

Heikki Krogerus (1):
      Revert "usb: typec: class: fix typec_altmode_put_partner to put plugs"

Heiko Carstens (1):
      tick-sched: Fix idle and iowait sleeptime accounting vs CPU hotplug

Herbert Xu (1):
      crypto: af_alg - Disallow multiple in-flight AIO requests

Ilpo Järvinen (2):
      wifi: rtlwifi: Remove bogus and dangerous ASPM disable/enable code
      wifi: rtlwifi: Convert LNKCTL change to PCIe cap RMW accessors

James Clark (1):
      coresight: etm4x: Fix width of CCITMIN field

Jan Beulich (1):
      xen-netback: don't produce zero-size SKB frags

Jani Nikula (1):
      drm/crtc: fix uninitialized variable use

Jason Gerecke (1):
      HID: wacom: Correct behavior when processing some confidence == false touches

Jerry Hoemann (1):
      watchdog/hpwdt: Only claim UNKNOWN NMI if from iLO

Joakim Zhang (1):
      dma-mapping: clear dev->dma_mem to NULL after freeing it

Joe Perches (1):
      rtlwifi: Use ffs in <foo>_phy_calculate_bit_shift

Kamil Duljas (1):
      ASoC: Intel: Skylake: mem leak in skl register function

Krzysztof Kozlowski (1):
      reset: hisilicon: hi6220: fix Wvoid-pointer-to-enum-cast warning

Kunwu Chan (3):
      powerpc/powernv: Add a null pointer check in opal_event_init()
      powerpc/imc-pmu: Add a null pointer check in update_events_in_group()
      net: dsa: vsc73xx: Add null pointer check to vsc73xx_gpio_probe

Laurent Dufour (1):
      powerpc/pseries/memhotplug: Quieten some DLPAR operations

Leon Romanovsky (1):
      RDMA/usnic: Silence uninitialized symbol smatch warnings

Lin Ma (1):
      net: qualcomm: rmnet: fix global oob in rmnet_policy

Linus Walleij (2):
      ASoC: cs35l33: Fix GPIO name and drop legacy include
      ASoC: cs35l34: Fix GPIO name and drop legacy include

Luca Weiss (1):
      Input: xpad - add Razer Wolverine V2 support

Luiz Augusto von Dentz (1):
      Bluetooth: Fix bogus check for re-auth no supported with non-ssp

Maciej Strozek (2):
      ASoC: cs43130: Fix the position of const qualifier
      ASoC: cs43130: Fix incorrect frame delay configuration

Marek Szyprowski (2):
      i2c: s3c24xx: fix read transfers in polling mode
      i2c: s3c24xx: fix transferring more than one message in polling mode

Masahiro Yamada (1):
      powerpc: add crtsavres.o to always-y instead of extra-y

Michael Ellerman (1):
      selftests/powerpc: Fix error handling in FPU/VMX preemption tests

Mickaël Salaün (1):
      selinux: Fix error priority for bind with AF_UNSPEC on PF_INET6 socket

Nam Cao (1):
      fbdev: flush deferred work in fb_deferred_io_fsync()

Namhyung Kim (1):
      perf genelf: Set ELF program header addresses properly

Nathan Lynch (1):
      powerpc/pseries/memhp: Fix access beyond end of drmem array

Nikita Kiryushin (2):
      ACPI: video: check for error while searching for backlight device parent
      ACPI: LPIT: Avoid u32 multiplication overflow

Nikita Yushchenko (1):
      net: ravb: Fix dma_addr_t truncation in error case

Nikita Zhandarovich (3):
      drm/radeon/r600_cs: Fix possible int overflows in r600_cs_check_reg()
      drm/radeon/r100: Fix integer overflow issues in r100_cs_track_check()
      drm/radeon: check return value of radeon_ring_lock()

Ovidiu Panait (9):
      crypto: sahara - remove FLAGS_NEW_KEY logic
      crypto: sahara - fix ahash selftest failure
      crypto: sahara - fix processing requests with cryptlen < sg->length
      crypto: sahara - fix error handling in sahara_hw_descriptor_create()
      crypto: sahara - fix ahash reqsize
      crypto: sahara - fix wait_for_completion_timeout() error handling
      crypto: sahara - improve error handling in sahara_sha_process()
      crypto: sahara - fix processing hash requests with req->nbytes < sg->length
      crypto: sahara - do not resize req->src when doing hash operations

Peter Delevoryas (1):
      net/ncsi: Fix netlink major/minor version numbers

Peter Robinson (1):
      mmc: sdhci_omap: Fix TI SoC dependencies

RD Babiera (1):
      usb: typec: class: fix typec_altmode_put_partner to put plugs

Randy Dunlap (1):
      powerpc/44x: select I2C for CURRITUCK

Ricardo B. Marliere (1):
      media: pvrusb2: fix use after free on context disconnection

Ronald Monthero (1):
      mtd: rawnand: Increment IFC_TIMEOUT_MSECS for nand controller response

Sakari Ailus (1):
      acpi: property: Let args be NULL in __acpi_node_get_property_reference

Sebastian Andrzej Siewior (3):
      crypto: scompress - return proper error code for allocation failure
      crypto: scompress - Use per-CPU struct instead multiple variables
      crypto: scompress - initialize per-CPU variables on each CPU

Sergey Shtylyov (1):
      pstore: ram_core: fix possible overflow in persistent_ram_init_ecc()

Shuming Fan (1):
      ASoC: rt5650: add mutex to avoid the jack detection failure

Stefan Wahren (2):
      ARM: sun9i: smp: fix return code check of of_property_match_string
      watchdog: bcm2835_wdt: Fix WDIOC_SETTIMEOUT handling

Steven Rostedt (Google) (3):
      tracing: Have large events show up as '[LINE TOO BIG]' instead of nothing
      tracing: Add size check when printing trace_marker output
      ring-buffer: Do not record in NMI if the arch does not support cmpxchg in NMI

Su Hui (9):
      wifi: rtlwifi: rtl8821ae: phy: fix an undefined bitwise shift behavior
      wifi: rtlwifi: add calculate_bit_shift()
      wifi: rtlwifi: rtl8188ee: phy: using calculate_bit_shift()
      wifi: rtlwifi: rtl8192c: using calculate_bit_shift()
      wifi: rtlwifi: rtl8192cu: using calculate_bit_shift()
      wifi: rtlwifi: rtl8192ce: using calculate_bit_shift()
      wifi: rtlwifi: rtl8192de: using calculate_bit_shift()
      wifi: rtlwifi: rtl8192ee: using calculate_bit_shift()
      wifi: rtlwifi: rtl8192se: using calculate_bit_shift()

Takashi Iwai (1):
      ALSA: oxygen: Fix right channel of capture volume mixer

Thinh Nguyen (2):
      Revert "usb: dwc3: Soft reset phy on probe for host"
      Revert "usb: dwc3: don't reset device side if dwc3 was configured as host-only"

Thinh Tran (1):
      net/tg3: fix race condition in tg3_reset_task()

Trond Myklebust (1):
      NFSv4.1/pnfs: Ensure we handle the error NFS4ERR_RETURNCONFLICT

Uttkarsh Aggarwal (1):
      usb: dwc: ep0: Update request status in dwc3_ep0_stall_restart

Vineet Gupta (1):
      ARC: fix spare error

Vineeth Vijayan (1):
      s390/scm: fix virtual vs physical address confusion

Weihao Li (1):
      clk: rockchip: rk3128: Fix HCLK_OTG gate register

Xiang Yang (1):
      drm/exynos: fix a potential error pointer dereference

Xu Yang (2):
      usb: phy: mxs: remove CONFIG_USB_OTG condition for mxs_phy_is_otg_host()
      usb: chipidea: wait controller resume finished for wakeup irq

Yang Yingliang (1):
      drm/radeon: check the alloc_workqueue return value in radeon_crtc_init()

Yihang Li (1):
      scsi: hisi_sas: Replace with standard error code return value

Zhang Yi (1):
      jbd2: correct the printing of write_flags in jbd2_write_superblock()

ZhaoLong Wang (1):
      mtd: Fix gluebi NULL pointer dereference caused by ftl notifier

Zheng Yejian (1):
      netlabel: remove unused parameter in netlbl_netlink_auditinfo()

Zhipeng Lu (6):
      drm/radeon/dpm: fix a memleak in sumo_parse_power_table
      drm/radeon/trinity_dpm: fix a memleak in trinity_parse_power_table
      media: cx231xx: fix a memleak in cx231xx_init_isoc
      drm/amd/pm: fix a double-free in si_dpm_init
      drivers/amd/pm: fix a use-after-free in kv_parse_power_table
      gpu/drm/radeon: fix two memleaks in radeon_vm_init

Ziqi Zhao (1):
      drm/crtc: Fix uninit-value bug in drm_mode_setcrtc

wangyangxin (1):
      crypto: virtio - Wait for tasklet to complete on device remove


