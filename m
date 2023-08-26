Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C07CF789724
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 16:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232118AbjHZOGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 10:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232673AbjHZOFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 10:05:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B179C19A0;
        Sat, 26 Aug 2023 07:05:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4214C612EA;
        Sat, 26 Aug 2023 14:05:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 549B6C433CA;
        Sat, 26 Aug 2023 14:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693058748;
        bh=h4urnB8SPGACjc9uXont1zp2pqvHQUyKiUYcECHn2Ek=;
        h=From:To:Cc:Subject:Date:From;
        b=FHIS7/ZD5NrxS/67BYhdNN1zainICXU6Ss5dCL/03AL/7+M05ceFOJ718qmYcAL5a
         88JgvOITe4I8hX5G10mbcrunBmK/4v8wpSWPwL1PRjW5Wrz/aAcWJoKErPqxPnH9mb
         MAdrEbOX2YrSxmH5Zxcm2MDWhFoovNJXWGTxiJPc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.15.128
Date:   Sat, 26 Aug 2023 16:05:40 +0200
Message-ID: <2023082641-easel-sudden-fde4@gregkh>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm announcing the release of the 5.15.128 kernel.

All users of the 5.15 kernel series must upgrade.

The updated 5.15.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.15.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/admin-guide/hw-vuln/srso.rst                   |    4 
 MAINTAINERS                                                  |    2 
 Makefile                                                     |    2 
 arch/arm/boot/dts/aspeed-bmc-asrock-e3c246d4i.dts            |    2 
 arch/arm/boot/dts/imx6dl-prtrvt.dts                          |    4 
 arch/arm/boot/dts/imx6qdl-prti6q.dtsi                        |   11 
 arch/arm/boot/dts/imx6sll.dtsi                               |   24 
 arch/arm/boot/dts/imx6sx.dtsi                                |    6 
 arch/arm64/boot/dts/qcom/qrb5165-rb5.dts                     |    2 
 arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi           |    4 
 arch/powerpc/kernel/rtas_flash.c                             |    6 
 arch/powerpc/mm/kasan/Makefile                               |    1 
 arch/riscv/lib/uaccess.S                                     |   11 
 arch/x86/include/asm/entry-common.h                          |    1 
 arch/x86/include/asm/nospec-branch.h                         |   28 
 arch/x86/kernel/cpu/amd.c                                    |    1 
 arch/x86/kernel/cpu/bugs.c                                   |   28 
 arch/x86/kernel/static_call.c                                |   13 
 arch/x86/kernel/traps.c                                      |    2 
 arch/x86/kernel/vmlinux.lds.S                                |   20 
 arch/x86/kvm/svm/svm.c                                       |    2 
 arch/x86/lib/retpoline.S                                     |  135 ++-
 drivers/bluetooth/btusb.c                                    |    3 
 drivers/bus/ti-sysc.c                                        |    2 
 drivers/firewire/net.c                                       |    6 
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c                       |    6 
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c                   |    1 
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c                      |    9 
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c                       |    6 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c            |  209 ++++-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h       |   14 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c  |   30 
 drivers/gpu/drm/panel/panel-simple.c                         |   24 
 drivers/gpu/drm/qxl/qxl_drv.h                                |    2 
 drivers/gpu/drm/qxl/qxl_dumb.c                               |    5 
 drivers/gpu/drm/qxl/qxl_gem.c                                |   25 
 drivers/gpu/drm/qxl/qxl_ioctl.c                              |    6 
 drivers/hid/hid-ids.h                                        |    1 
 drivers/hid/hid-logitech-hidpp.c                             |    4 
 drivers/hid/hid-quirks.c                                     |    1 
 drivers/i2c/busses/i2c-bcm-iproc.c                           |   11 
 drivers/i2c/busses/i2c-designware-master.c                   |   16 
 drivers/i2c/busses/i2c-hisi.c                                |    8 
 drivers/iio/Kconfig                                          |    1 
 drivers/iio/Makefile                                         |    1 
 drivers/iio/adc/Kconfig                                      |   16 
 drivers/iio/adc/Makefile                                     |    1 
 drivers/iio/adc/stx104.c                                     |  374 ---------
 drivers/iio/addac/Kconfig                                    |   24 
 drivers/iio/addac/Makefile                                   |    7 
 drivers/iio/addac/stx104.c                                   |  414 +++++++++++
 drivers/infiniband/hw/mlx5/qpc.c                             |   10 
 drivers/media/platform/mtk-vpu/mtk_vpu.c                     |    6 
 drivers/mmc/core/block.c                                     |    7 
 drivers/mmc/host/bcm2835.c                                   |    4 
 drivers/mmc/host/sdhci_f_sdh30.c                             |   66 -
 drivers/mmc/host/sunxi-mmc.c                                 |    4 
 drivers/mmc/host/wbsd.c                                      |    2 
 drivers/net/dsa/mv88e6xxx/chip.c                             |    8 
 drivers/net/ethernet/intel/i40e/i40e_nvm.c                   |   16 
 drivers/net/ethernet/intel/iavf/iavf_ethtool.c               |   10 
 drivers/net/ethernet/intel/iavf/iavf_fdir.c                  |   77 +-
 drivers/net/ethernet/intel/iavf/iavf_fdir.h                  |    2 
 drivers/net/ethernet/intel/igc/igc_base.h                    |   11 
 drivers/net/ethernet/intel/igc/igc_main.c                    |    7 
 drivers/net/macsec.c                                         |   70 +
 drivers/net/phy/broadcom.c                                   |   13 
 drivers/net/phy/phy_device.c                                 |   13 
 drivers/net/team/team.c                                      |    4 
 drivers/net/virtio_net.c                                     |    4 
 drivers/pci/controller/dwc/pcie-tegra194.c                   |   13 
 drivers/pcmcia/rsrc_nonstatic.c                              |    2 
 drivers/soc/aspeed/aspeed-socinfo.c                          |    1 
 drivers/thunderbolt/retimer.c                                |   29 
 drivers/tty/n_gsm.c                                          |    3 
 drivers/tty/serial/8250/8250_port.c                          |    1 
 drivers/tty/serial/fsl_lpuart.c                              |   26 
 drivers/usb/chipidea/ci_hdrc_imx.c                           |    5 
 drivers/usb/chipidea/usbmisc_imx.c                           |    2 
 drivers/usb/dwc3/core.c                                      |    9 
 drivers/usb/dwc3/dwc3-qcom.c                                 |   11 
 drivers/usb/dwc3/gadget.c                                    |  116 +--
 drivers/usb/gadget/function/u_serial.c                       |    3 
 drivers/vdpa/vdpa_user/vduse_dev.c                           |    8 
 drivers/video/fbdev/mmp/hw/mmp_ctrl.c                        |    4 
 drivers/virtio/virtio_mmio.c                                 |    5 
 drivers/watchdog/sp5100_tco.c                                |    4 
 fs/btrfs/block-group.c                                       |    5 
 fs/btrfs/volumes.c                                           |    3 
 fs/cifs/cifsfs.c                                             |   28 
 fs/cifs/file.c                                               |   25 
 fs/exfat/dir.c                                               |    9 
 fs/gfs2/super.c                                              |   26 
 fs/ntfs3/frecord.c                                           |   16 
 fs/ntfs3/fsntfs.c                                            |    2 
 fs/ntfs3/index.c                                             |    6 
 fs/ntfs3/ntfs_fs.h                                           |    2 
 fs/ntfs3/record.c                                            |   10 
 fs/overlayfs/ovl_entry.h                                     |    9 
 include/linux/iopoll.h                                       |    2 
 include/linux/objtool.h                                      |   28 
 include/linux/virtio_net.h                                   |    4 
 include/media/v4l2-mem2mem.h                                 |   18 
 include/net/sock.h                                           |    6 
 include/net/tls.h                                            |    2 
 kernel/dma/remap.c                                           |    4 
 kernel/trace/ring_buffer.c                                   |   14 
 kernel/trace/trace.c                                         |    3 
 net/bluetooth/l2cap_core.c                                   |    5 
 net/core/sock.c                                              |    2 
 net/ipv4/ip_vti.c                                            |    4 
 net/ipv4/tcp_timer.c                                         |    4 
 net/ipv6/ip6_vti.c                                           |    4 
 net/key/af_key.c                                             |    4 
 net/netfilter/ipvs/ip_vs_ctl.c                               |    4 
 net/netfilter/nf_conntrack_proto_sctp.c                      |    6 
 net/netfilter/nf_tables_api.c                                |    1 
 net/netfilter/nft_dynset.c                                   |    3 
 net/netfilter/nft_set_pipapo.c                               |   13 
 net/tls/tls_device.c                                         |  137 +--
 net/unix/af_unix.c                                           |    9 
 net/xfrm/xfrm_compat.c                                       |    2 
 net/xfrm/xfrm_interface_core.c                               |    4 
 net/xfrm/xfrm_user.c                                         |   14 
 sound/hda/hdac_regmap.c                                      |    7 
 sound/pci/hda/patch_realtek.c                                |   16 
 sound/soc/codecs/rt5665.c                                    |    2 
 sound/soc/meson/axg-tdm-formatter.c                          |   42 -
 sound/soc/sof/intel/hda.c                                    |   12 
 sound/usb/quirks-table.h                                     |   29 
 tools/include/linux/objtool.h                                |   28 
 tools/objtool/arch/x86/decode.c                              |    2 
 tools/objtool/check.c                                        |   21 
 tools/testing/selftests/net/forwarding/mirror_gre_changes.sh |    3 
 tools/testing/selftests/net/forwarding/tc_actions.sh         |   18 
 135 files changed, 1774 insertions(+), 956 deletions(-)

Abel Wu (1):
      sock: Fix misuse of sk_under_memory_pressure()

Alexandre Ghiti (1):
      riscv: uaccess: Return the number of bytes effectively not copied

Alfred Lee (1):
      net: dsa: mv88e6xxx: Wait for EEPROM done before HW reset

Andreas Kemnade (1):
      ARM: dts: imx6sll: fixup of operating points

Andrii Staikov (1):
      i40e: fix misleading debug logs

Armin Wolf (1):
      pcmcia: rsrc_nonstatic: Fix memory leak in nonstatic_release_resource_db()

Benjamin Gray (1):
      powerpc/kasan: Disable KCOV in KASAN code

Borislav Petkov (AMD) (4):
      x86/srso: Explain the untraining sequences a bit more
      x86/CPU/AMD: Fix the DIV(0) initial fix attempt
      x86/srso: Disable the mitigation on unaffected configurations
      x86/srso: Correct the mitigation status when SMT is disabled

Chen Lin (1):
      ring-buffer: Do not swap cpu_buffer during resize process

Chengfeng Ye (1):
      i2c: bcm-iproc: Fix bcm_iproc_i2c_isr deadlock issue

Christian Brauner (1):
      ovl: check type and offset of struct vfsmount in ovl_entry

Christopher Obbard (1):
      arm64: dts: rockchip: Disable HS400 for eMMC on ROCK Pi 4

Clayton Yager (1):
      macsec: Fix traffic counters/statistics

Cosmin Tanislav (1):
      iio: add addac subdirectory

Davide Caratti (1):
      selftests: forwarding: tc_actions: cleanup temporary files when test is aborted

Dmitry Baryshkov (1):
      arm64: dts: qcom: qrb5165-rb5: fix thermal zone conflict

Edward Lo (1):
      fs/ntfs3: Enhance sanity check while generating attr_list

Eric Dumazet (2):
      macsec: use DEV_STATS_INC()
      net: do not allow gso_size to be set to GSO_BY_FRAGS

Florian Westphal (2):
      netfilter: nf_tables: fix false-positive lockdep splat
      netfilter: nf_tables: deactivate catchall elements in next generation

Geert Uytterhoeven (1):
      iopoll: Call cpu_relax() in busy loops

Greg Kroah-Hartman (1):
      Linux 5.15.128

Hans Verkuil (1):
      media: platform: mediatek: vpu: fix NULL ptr dereference

Hersen Wu (1):
      drm/amd/display: fix access hdcp_workqueue assert

Ido Schimmel (1):
      selftests: forwarding: tc_actions: Use ncat instead of nc

Jakub Kicinski (1):
      net: tls: avoid discarding data on record close

Jason Wang (1):
      virtio-net: set queues after driver_ok

Jason Xing (1):
      net: fix the RTO timer retransmitting skb every 1ms if linear option is enabled

Jerome Brunet (1):
      ASoC: meson: axg-tdm-formatter: fix channel slot allocation

Jesse Taube (1):
      tty: serial: fsl_lpuart: Add i.MXRT1050 support

Jia-Ju Bai (1):
      fs: ntfs3: Fix possible null-pointer dereferences in mi_read()

Jiasheng Jiang (1):
      soc: aspeed: socinfo: Add kfree for kstrdup

Johan Hovold (3):
      USB: dwc3: gadget: drop dead hibernation code
      USB: dwc3: qcom: fix NULL-deref on suspend
      USB: dwc3: fix use-after-free on core driver unbind

Josh Poimboeuf (1):
      objtool: Add frame-pointer-specific function ignore

Justin Chen (1):
      net: phy: broadcom: stub c45 read/write for 54810

Kailang Yang (1):
      ALSA: hda/realtek - Remodified 3k pull low procedure

Konstantin Komarov (1):
      fs/ntfs3: Mark ntfs dirty when on-disk struct is corrupted

Kunihiko Hayashi (1):
      mmc: sdhci-f-sdh30: Replace with sdhci_pltfm

Kuniyuki Iwashima (1):
      af_unix: Fix null-ptr-deref in unix_stream_sendpage().

Kushagra Verma (1):
      usb: dwc3: Fix typos in gadget.c

Lang Yu (1):
      drm/amdgpu: install stub fence into potential unused fence pointers

Lin Ma (5):
      net: xfrm: Fix xfrm_address_filter OOB read
      net: af_key: fix sadb_x_filter validation
      net: xfrm: Amend XFRMA_SEC_CTX nla_policy structure
      xfrm: add NULL check in xfrm_update_ae_params
      xfrm: add forgotten nla_policy for XFRMA_MTIMER_THRESH

Luca Ceresoli (1):
      drm/panel: simple: Fix AUO G121EAN01 panel timings according to the docs

Marco Morandini (1):
      HID: add quirk for 03f0:464a HP Elite Presenter Mouse

Mario Limonciello (1):
      drm/amd: flush any delayed gfxoff on suspend entry

Matthew Anderson (1):
      Bluetooth: btusb: Add MT7922 bluetooth ID for the Asus Ally

Maxime Coquelin (1):
      vduse: Use proper spinlock for IRQ injection

Mika Westerberg (1):
      thunderbolt: Read retimer NVM authentication status prior tb_retimer_set_inbound_sbtx()

Namjae Jeon (1):
      exfat: check if filename entries exceeds max filename length

Naohiro Aota (1):
      btrfs: move out now unused BG from the reclaim list

Nathan Lynch (1):
      powerpc/rtas_flash: allow user copy to flash block cache objects

Oleksij Rempel (1):
      ARM: dts: imx6dl: prtrvt, prtvt7, prti6q, prtwd2: fix USB related warnings

Pablo Neira Ayuso (1):
      netfilter: nft_dynset: disallow object maps

Patrisious Haddad (1):
      RDMA/mlx5: Return the firmware result upon destroying QP/RQ

Paulo Alcantara (1):
      smb: client: fix warning in cifs_smb3_do_mount()

Peter Zijlstra (10):
      x86/cpu: Fix __x86_return_thunk symbol type
      x86/cpu: Fix up srso_safe_ret() and __x86_return_thunk()
      x86/alternative: Make custom return thunk unconditional
      x86/ibt: Add ANNOTATE_NOENDBR
      x86/cpu: Clean up SRSO return thunk mess
      x86/cpu: Rename original retbleed methods
      x86/cpu: Rename srso_(.*)_alias to srso_alias_\1
      x86/cpu: Cleanup the untrain mess
      x86/static_call: Fix __static_call_fixup()
      objtool/x86: Fixup frame-pointer vs rethunk

Petr Machata (1):
      selftests: mirror_gre_changes: Tighten up the TTL test match

Petr Pavlu (1):
      x86/retpoline,kprobes: Fix position of thunk sections with CONFIG_LTO_CLANG

Pierre-Louis Bossart (1):
      ASoC: SOF: Intel: fix SoundWire/HDaudio mutual exclusion

Piotr Gardocki (1):
      iavf: fix FDIR rule fields masks validation

Prashanth K (1):
      usb: gadget: u_serial: Avoid spinlock recursion in __gs_console_push

Quan Nguyen (1):
      i2c: designware: Correct length byte validation logic

Robert Hodaszi (1):
      tty: serial: fsl_lpuart: reduce RX watermark to 0 on LS1028A

Roger Quadros (1):
      usb: dwc3: gadget: Improve dwc3_gadget_suspend() and dwc3_gadget_resume()

Russell Harmon via samba-technical (1):
      cifs: Release folio lock on fscache read hit.

Russell King (Oracle) (1):
      net: phy: fix IRQ-based wake-on-lan over hibernate / power off

Sean Christopherson (1):
      x86/retpoline: Don't clobber RFLAGS during srso_safe_ret()

Sergey Shtylyov (2):
      mmc: bcm2835: fix deferred probing
      mmc: sunxi: fix deferred probing

Sherry Sun (2):
      tty: serial: fsl_lpuart: make rx_watermark configurable for different platforms
      tty: serial: fsl_lpuart: Clear the error flags by writing 1 for lpuart32 platforms

Sishuai Gong (1):
      ipvs: fix racy memcpy in proc_do_sync_threshold

Song Yoong Siang (1):
      igc: read before write to SRRCTL register

Steve French (1):
      cifs: fix potential oops in cifs_oplock_break

Sumit Gupta (1):
      PCI: tegra194: Fix possible array out of bounds access

Tam Nguyen (1):
      i2c: designware: Handle invalid SMBus block data response length value

Tariq Toukan (2):
      net/tls: Perform immediate device ctx cleanup when possible
      net/tls: Multi-threaded calls to TX tls_dev_del

Tony Lindgren (2):
      bus: ti-sysc: Flush posted write on enable before reset
      serial: 8250: Fix oops for port->pm on uart_change_pm()

Tuo Li (2):
      gfs2: Fix possible data races in gfs2_show_options()
      ALSA: hda: fix a possible null-pointer dereference due to data race in snd_hdac_regmap_sync()

Wander Lairson Costa (1):
      drm/qxl: fix UAF on handle creation

Wesley Cheng (2):
      usb: dwc3: gadget: Synchronize IRQ between soft connect/disconnect
      usb: dwc3: Remove DWC3 locking during gadget suspend/resume

William Breathitt Gray (5):
      iio: adc: stx104: Utilize iomap interface
      iio: adc: stx104: Implement and utilize register structures
      iio: stx104: Move to addac subdirectory
      iio: addac: stx104: Fix race condition for stx104_write_raw()
      iio: addac: stx104: Fix race condition when converting analog-to-digital

Wolfram Sang (1):
      virtio-mmio: don't break lifecycle of vm_dev

Xiaolei Wang (1):
      ARM: dts: imx: Set default tuning step for imx6sx usdhc

Xin Long (1):
      netfilter: set default timeout to 3 secs for sctp shutdown send and recv state

Xu Yang (3):
      usb: chipidea: imx: don't request QoS for imx8ulp
      usb: chipidea: imx: add missing USB PHY DPDM wakeup setting
      ARM: dts: nxp/imx6sll: fix wrong property name in usbphy node

Yang Yingliang (1):
      mmc: wbsd: fix double mmc_free_host() in wbsd_init()

Yangtao Li (1):
      mmc: f-sdh30: fix order of function calls in sdhci_f_sdh30_remove

Yi Yang (1):
      tty: n_gsm: fix the UAF caused by race condition in gsm_cleanup_mux

Yibin Ding (1):
      mmc: block: Fix in_flight[issue_type] value error

Yicong Yang (1):
      i2c: hisi: Only handle the interrupt of the driver's transfer

Yuanjun Gong (1):
      fbdev: mmp: fix value check in mmphw_probe()

Yuechao Zhao (1):
      watchdog: sp5100_tco: support Hygon FCH/SCH (Server Controller Hub)

Yunfei Dong (1):
      media: v4l2-mem2mem: add lock to protect parameter num_rdy

Zev Weiss (1):
      ARM: dts: aspeed: asrock: Correct firmware flash SPI clocks

Zhang Shurong (2):
      firewire: net: fix use after free in fwnet_finish_incoming_packet()
      ASoC: rt5665: add missed regulator_bulk_disable

Zhengchao Shao (3):
      xfrm: fix slab-use-after-free in decode_session6
      ip6_vti: fix slab-use-after-free in decode_session6
      ip_vti: fix potential slab-use-after-free in decode_session6

Zhengping Jiang (1):
      Bluetooth: L2CAP: Fix use-after-free

Ziyang Xuan (1):
      team: Fix incorrect deletion of ETH_P_8021AD protocol vid from slaves

dengxiang (2):
      ALSA: hda/realtek: Add quirks for Unis H3C Desktop B760 & Q760
      ALSA: usb-audio: Add support for Mythware XA001AU capture and playback interfaces.

gaoxu (1):
      dma-remap: use kvmalloc_array/kvfree for larger dma memory remap

hersen wu (2):
      drm/amd/display: save restore hdcp state when display is unplugged from mst hub
      drm/amd/display: phase3 mst hdcp for multiple displays

shanzhulig (1):
      drm/amdgpu: Fix potential fence use-after-free v2

stuarthayhurst (1):
      HID: logitech-hidpp: Add USB and Bluetooth IDs for the Logitech G915 TKL Keyboard

xiaoshoukui (1):
      btrfs: fix BUG_ON condition in btrfs_cancel_balance

