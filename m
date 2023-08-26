Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99137789720
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 16:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231712AbjHZOF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 10:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232314AbjHZOFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 10:05:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B5E6211E;
        Sat, 26 Aug 2023 07:05:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1ED4261277;
        Sat, 26 Aug 2023 14:05:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FB22C433C9;
        Sat, 26 Aug 2023 14:05:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693058738;
        bh=Fs4G2uVGxOQxNWs/v8r3YdWAiHvx2FrJQN7sJYQbfPk=;
        h=From:To:Cc:Subject:Date:From;
        b=ZMtO2m/vFQ5lRZwp4z7TkFaYJHe4MX2wGT/VQN154tTVy+Jl1OCmyA7I33ZFfDzMg
         x1pRwC53kX9AFmHANqRTNYVHTVUD/Z5GSe7xAZFe32AK2YNoF8zs/eh2vUM7vztUMC
         zY2qaKwnjsaXmEvHHs9sBjtqYWLzpZ5/1LGZUsjw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.10.192
Date:   Sat, 26 Aug 2023 16:05:33 +0200
Message-ID: <2023082634-tightrope-bountiful-f121@gregkh>
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

I'm announcing the release of the 5.10.192 kernel.

All users of the 5.10 kernel series must upgrade.

The updated 5.10.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.10.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/admin-guide/hw-vuln/srso.rst                    |    4 
 Documentation/devicetree/bindings/iio/addac/adi,ad74413r.yaml |  158 
 Makefile                                                      |    2 
 arch/arm/boot/dts/imx6dl-prtrvt.dts                           |    4 
 arch/arm/boot/dts/imx6qdl-prti6q.dtsi                         |   11 
 arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi            |  197 -
 arch/mips/include/asm/dec/prom.h                              |    2 
 arch/powerpc/kernel/rtas_flash.c                              |    6 
 arch/powerpc/mm/kasan/Makefile                                |    1 
 arch/x86/include/asm/entry-common.h                           |    1 
 arch/x86/include/asm/nospec-branch.h                          |   28 
 arch/x86/kernel/cpu/amd.c                                     |    1 
 arch/x86/kernel/cpu/bugs.c                                    |   28 
 arch/x86/kernel/static_call.c                                 |   13 
 arch/x86/kernel/traps.c                                       |    2 
 arch/x86/kernel/vmlinux.lds.S                                 |   18 
 arch/x86/kvm/svm/svm.c                                        |    1 
 arch/x86/lib/retpoline.S                                      |  135 
 drivers/bluetooth/btusb.c                                     |    3 
 drivers/bus/Makefile                                          |    2 
 drivers/bus/mhi/Kconfig                                       |   18 
 drivers/bus/mhi/Makefile                                      |    4 
 drivers/bus/mhi/core/Makefile                                 |    4 
 drivers/bus/mhi/core/boot.c                                   |  525 ---
 drivers/bus/mhi/core/debugfs.c                                |  411 --
 drivers/bus/mhi/core/init.c                                   | 1375 --------
 drivers/bus/mhi/core/internal.h                               |  722 ----
 drivers/bus/mhi/core/main.c                                   | 1630 ----------
 drivers/bus/mhi/core/pm.c                                     | 1157 -------
 drivers/bus/mhi/host/Kconfig                                  |   31 
 drivers/bus/mhi/host/Makefile                                 |    6 
 drivers/bus/mhi/host/boot.c                                   |  525 +++
 drivers/bus/mhi/host/debugfs.c                                |  411 ++
 drivers/bus/mhi/host/init.c                                   | 1387 ++++++++
 drivers/bus/mhi/host/internal.h                               |  722 ++++
 drivers/bus/mhi/host/main.c                                   | 1630 ++++++++++
 drivers/bus/mhi/host/pci_generic.c                            |  345 ++
 drivers/bus/mhi/host/pm.c                                     | 1157 +++++++
 drivers/bus/ti-sysc.c                                         |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c                        |    6 
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c                        |    6 
 drivers/gpu/drm/panel/panel-simple.c                          |   24 
 drivers/gpu/drm/radeon/radeon_cs.c                            |    3 
 drivers/hid/hid-ids.h                                         |    1 
 drivers/hid/hid-quirks.c                                      |    1 
 drivers/i2c/busses/i2c-bcm-iproc.c                            |   11 
 drivers/i2c/busses/i2c-designware-master.c                    |   15 
 drivers/iio/Kconfig                                           |    1 
 drivers/iio/Makefile                                          |    1 
 drivers/iio/adc/stx104.c                                      |   96 
 drivers/iio/addac/Kconfig                                     |    8 
 drivers/iio/addac/Makefile                                    |    6 
 drivers/infiniband/hw/mlx5/qpc.c                              |   10 
 drivers/irqchip/irq-mips-gic.c                                |   63 
 drivers/media/platform/mtk-vpu/mtk_vpu.c                      |    6 
 drivers/mmc/core/block.c                                      |    7 
 drivers/mmc/core/host.c                                       |   26 
 drivers/mmc/host/bcm2835.c                                    |    4 
 drivers/mmc/host/meson-gx-mmc.c                               |   52 
 drivers/mmc/host/sdhci_f_sdh30.c                              |   66 
 drivers/mmc/host/sunxi-mmc.c                                  |    4 
 drivers/mmc/host/wbsd.c                                       |    2 
 drivers/net/dsa/mv88e6xxx/chip.c                              |    8 
 drivers/net/ethernet/intel/i40e/i40e_nvm.c                    |   16 
 drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c           |  168 -
 drivers/net/ethernet/mellanox/mlx5/core/lib/clock.h           |    3 
 drivers/net/macsec.c                                          |   70 
 drivers/net/phy/broadcom.c                                    |   13 
 drivers/net/team/team.c                                       |    4 
 drivers/net/virtio_net.c                                      |    4 
 drivers/pci/controller/dwc/pcie-tegra194.c                    |   13 
 drivers/pcmcia/rsrc_nonstatic.c                               |    2 
 drivers/tty/n_gsm.c                                           |    3 
 drivers/tty/serial/8250/8250_port.c                           |    1 
 drivers/tty/serial/fsl_lpuart.c                               |    4 
 drivers/usb/cdns3/gadget.c                                    |   60 
 drivers/usb/cdns3/gadget.h                                    |    9 
 drivers/usb/chipidea/ci_hdrc_imx.c                            |    5 
 drivers/usb/chipidea/usbmisc_imx.c                            |    2 
 drivers/usb/dwc3/dwc3-qcom.c                                  |   11 
 drivers/usb/gadget/function/u_serial.c                        |    3 
 drivers/usb/gadget/udc/core.c                                 |   19 
 drivers/video/fbdev/mmp/hw/mmp_ctrl.c                         |    4 
 drivers/virtio/virtio_mmio.c                                  |    8 
 fs/btrfs/volumes.c                                            |    3 
 fs/cifs/file.c                                                |    2 
 fs/gfs2/super.c                                               |   26 
 fs/jfs/jfs_dmap.c                                             |    3 
 fs/jfs/jfs_txnmgr.c                                           |    5 
 fs/jfs/namei.c                                                |    5 
 fs/overlayfs/ovl_entry.h                                      |    9 
 fs/quota/dquot.c                                              |    5 
 fs/udf/unicode.c                                              |    2 
 include/dt-bindings/iio/addac/adi,ad74413r.h                  |   21 
 include/linux/iopoll.h                                        |    2 
 include/linux/mhi.h                                           |    2 
 include/linux/mlx5/driver.h                                   |   12 
 include/linux/mmc/host.h                                      |    1 
 include/linux/objtool.h                                       |   28 
 include/linux/usb/gadget.h                                    |    4 
 include/linux/virtio_net.h                                    |    4 
 include/media/v4l2-mem2mem.h                                  |   18 
 include/net/sock.h                                            |    6 
 kernel/dma/remap.c                                            |    4 
 kernel/trace/ring_buffer.c                                    |   14 
 kernel/trace/trace.c                                          |    3 
 kernel/trace/trace_kprobe.c                                   |    3 
 kernel/trace/trace_probe_tmpl.h                               |   18 
 kernel/trace/trace_uprobe.c                                   |    3 
 net/bluetooth/l2cap_core.c                                    |    5 
 net/core/sock.c                                               |    2 
 net/ipv4/ip_vti.c                                             |    4 
 net/ipv4/tcp_timer.c                                          |    4 
 net/ipv6/ip6_vti.c                                            |    4 
 net/key/af_key.c                                              |    4 
 net/netfilter/ipvs/ip_vs_ctl.c                                |    4 
 net/netfilter/nf_conntrack_proto_sctp.c                       |    6 
 net/netfilter/nft_dynset.c                                    |    3 
 net/unix/af_unix.c                                            |    9 
 net/xfrm/xfrm_compat.c                                        |    2 
 net/xfrm/xfrm_interface_core.c                                |    4 
 net/xfrm/xfrm_user.c                                          |   14 
 security/integrity/ima/Kconfig                                |    2 
 sound/hda/hdac_regmap.c                                       |    7 
 sound/pci/emu10k1/emufx.c                                     |  112 
 sound/pci/hda/patch_realtek.c                                 |   16 
 sound/soc/codecs/rt5665.c                                     |    2 
 sound/soc/intel/boards/sof_sdw.c                              |   25 
 sound/soc/meson/axg-tdm-formatter.c                           |   42 
 sound/usb/quirks-table.h                                      |   29 
 tools/include/linux/objtool.h                                 |   28 
 tools/objtool/arch/x86/decode.c                               |    2 
 tools/objtool/check.c                                         |   21 
 tools/testing/selftests/net/forwarding/mirror_gre_changes.sh  |    3 
 134 files changed, 7627 insertions(+), 6458 deletions(-)

Abel Wu (1):
      sock: Fix misuse of sk_under_memory_pressure()

Alex Bee (2):
      arm64: dts: rockchip: add ES8316 codec for ROCK Pi 4
      arm64: dts: rockchip: add SPDIF node for ROCK Pi 4

Alfred Lee (1):
      net: dsa: mv88e6xxx: Wait for EEPROM done before HW reset

Andrii Staikov (1):
      i40e: fix misleading debug logs

Armin Wolf (1):
      pcmcia: rsrc_nonstatic: Fix memory leak in nonstatic_release_resource_db()

Bard Liao (1):
      ASoC: Intel: sof_sdw: add quirk for MTL RVP

Benjamin Gray (1):
      powerpc/kasan: Disable KCOV in KASAN code

Bhaumik Bhatt (1):
      bus: mhi: Add MMIO region length to controller structure

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

Cosmin Tanislav (2):
      iio: add addac subdirectory
      dt-bindings: iio: add AD74413R

Eran Ben Elisha (2):
      net/mlx5: Refactor init clock function
      net/mlx5: Move all internal timer metadata into a dedicated struct

Eric Dumazet (2):
      macsec: use DEV_STATS_INC()
      net: do not allow gso_size to be set to GSO_BY_FRAGS

FUKAUMI Naoki (2):
      arm64: dts: rockchip: fix regulator name on rk3399-rock-4
      arm64: dts: rockchip: sort nodes/properties on rk3399-rock-4

Frank Li (2):
      usb: cdns3: allocate TX FIFO size according to composite EP number
      usb: cdns3: fix NCM gadget RX speed 20x slow than expection at iMX8QM

Geert Uytterhoeven (1):
      iopoll: Call cpu_relax() in busy loops

Greg Kroah-Hartman (1):
      Linux 5.10.192

Gustavo A. R. Silva (1):
      MIPS: dec: prom: Address -Warray-bounds warning

Hans Verkuil (1):
      media: platform: mediatek: vpu: fix NULL ptr dereference

Heiner Kallweit (2):
      mmc: core: add devm_mmc_alloc_host
      mmc: meson-gx: use devm_mmc_alloc_host

Immad Mir (2):
      FS: JFS: Fix null-ptr-deref Read in txBegin
      FS: JFS: Check for read-only mounted filesystem in txBegin

Jan Kara (2):
      quota: Properly disable quotas when add_dquot_ref() fails
      udf: Fix uninitialized array access for some pathnames

Jason Wang (1):
      virtio-net: set queues after driver_ok

Jason Xing (1):
      net: fix the RTO timer retransmitting skb every 1ms if linear option is enabled

Jeffrey Hugo (1):
      bus: mhi: host: Range check CHDBOFF and ERDBOFF

Jerome Brunet (1):
      ASoC: meson: axg-tdm-formatter: fix channel slot allocation

Jiaxun Yang (1):
      irqchip/mips-gic: Use raw spinlock for gic_lock

Johan Hovold (1):
      USB: dwc3: qcom: fix NULL-deref on suspend

Josh Poimboeuf (1):
      objtool: Add frame-pointer-specific function ignore

Justin Chen (1):
      net: phy: broadcom: stub c45 read/write for 54810

Kailang Yang (1):
      ALSA: hda/realtek - Remodified 3k pull low procedure

Kunihiko Hayashi (1):
      mmc: sdhci-f-sdh30: Replace with sdhci_pltfm

Kuniyuki Iwashima (1):
      af_unix: Fix null-ptr-deref in unix_stream_sendpage().

Lang Yu (1):
      drm/amdgpu: install stub fence into potential unused fence pointers

Lin Ma (5):
      net: xfrm: Fix xfrm_address_filter OOB read
      net: af_key: fix sadb_x_filter validation
      net: xfrm: Amend XFRMA_SEC_CTX nla_policy structure
      xfrm: add NULL check in xfrm_update_ae_params
      xfrm: add forgotten nla_policy for XFRMA_MTIMER_THRESH

Loic Poulain (1):
      bus: mhi: Add MHI PCI support for WWAN modems

Luca Ceresoli (1):
      drm/panel: simple: Fix AUO G121EAN01 panel timings according to the docs

Manivannan Sadhasivam (1):
      bus: mhi: Move host MHI code to "host" directory

Marc Zyngier (1):
      irqchip/mips-gic: Get rid of the reliance on irq_cpu_online()

Marco Morandini (1):
      HID: add quirk for 03f0:464a HP Elite Presenter Mouse

Masami Hiramatsu (Google) (1):
      tracing/probes: Fix to update dynamic data counter if fetcharg uses it

Matthew Anderson (1):
      Bluetooth: btusb: Add MT7922 bluetooth ID for the Asus Ally

Moshe Shemesh (1):
      net/mlx5: Skip clock update work when device is in error state

Nathan Lynch (1):
      powerpc/rtas_flash: allow user copy to flash block cache objects

Oleksij Rempel (1):
      ARM: dts: imx6dl: prtrvt, prtvt7, prti6q, prtwd2: fix USB related warnings

Oswald Buddenhagen (1):
      ALSA: emu10k1: roll up loops in DSP setup code for Audigy

Pablo Neira Ayuso (1):
      netfilter: nft_dynset: disallow object maps

Patrisious Haddad (1):
      RDMA/mlx5: Return the firmware result upon destroying QP/RQ

Peter Ujfalusi (1):
      ASoC: Intel: sof_sdw: add quirk for LNL RVP

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

Prashanth K (1):
      usb: gadget: u_serial: Avoid spinlock recursion in __gs_console_push

Randy Dunlap (1):
      IMA: allow/fix UML builds

Russell Harmon via samba-technical (1):
      cifs: Release folio lock on fscache read hit.

Sean Christopherson (1):
      x86/retpoline: Don't clobber RFLAGS during srso_safe_ret()

Sergey Shtylyov (3):
      mmc: bcm2835: fix deferred probing
      mmc: sunxi: fix deferred probing
      mmc: meson-gx: fix deferred probing

Sherry Sun (1):
      tty: serial: fsl_lpuart: Clear the error flags by writing 1 for lpuart32 platforms

Sishuai Gong (1):
      ipvs: fix racy memcpy in proc_do_sync_threshold

Steven Rostedt (VMware) (1):
      tracing/probes: Have process_fetch_insn() take a void * instead of pt_regs

Sumit Gupta (1):
      PCI: tegra194: Fix possible array out of bounds access

Tam Nguyen (1):
      i2c: designware: Handle invalid SMBus block data response length value

Tang Bin (1):
      virtio-mmio: Use to_virtio_mmio_device() to simply code

Tony Lindgren (2):
      bus: ti-sysc: Flush posted write on enable before reset
      serial: 8250: Fix oops for port->pm on uart_change_pm()

Tuo Li (2):
      gfs2: Fix possible data races in gfs2_show_options()
      ALSA: hda: fix a possible null-pointer dereference due to data race in snd_hdac_regmap_sync()

Uday M Bhat (1):
      ASoC: Intel: sof_sdw: Add support for Rex soundwire

Vicente Bergas (2):
      arm64: dts: rockchip: fix supplies on rk3399-rock-pi-4
      arm64: dts: rockchip: use USB host by default on rk3399-rock-pi-4

Wesley Cheng (1):
      usb: gadget: udc: core: Introduce check_config to verify USB configuration

William Breathitt Gray (4):
      iio: adc: stx104: Utilize iomap interface
      iio: adc: stx104: Implement and utilize register structures
      iio: addac: stx104: Fix race condition for stx104_write_raw()
      iio: addac: stx104: Fix race condition when converting analog-to-digital

Wolfram Sang (1):
      virtio-mmio: don't break lifecycle of vm_dev

Xin Long (1):
      netfilter: set default timeout to 3 secs for sctp shutdown send and recv state

Xu Yang (2):
      usb: chipidea: imx: don't request QoS for imx8ulp
      usb: chipidea: imx: add missing USB PHY DPDM wakeup setting

Yang Yingliang (1):
      mmc: wbsd: fix double mmc_free_host() in wbsd_init()

Yangtao Li (1):
      mmc: f-sdh30: fix order of function calls in sdhci_f_sdh30_remove

Ye Bin (1):
      quota: fix warning in dqgrab()

Yi Yang (1):
      tty: n_gsm: fix the UAF caused by race condition in gsm_cleanup_mux

Yibin Ding (1):
      mmc: block: Fix in_flight[issue_type] value error

Yogesh (1):
      fs: jfs: Fix UBSAN: array-index-out-of-bounds in dbAllocDmapLev

Yuanjun Gong (1):
      fbdev: mmp: fix value check in mmphw_probe()

Yunfei Dong (1):
      media: v4l2-mem2mem: add lock to protect parameter num_rdy

Zhang Shurong (1):
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

hackyzh002 (1):
      drm/radeon: Fix integer overflow in radeon_cs_parser_init

shanzhulig (1):
      drm/amdgpu: Fix potential fence use-after-free v2

xiaoshoukui (1):
      btrfs: fix BUG_ON condition in btrfs_cancel_balance

