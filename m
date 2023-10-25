Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2F3F7D685A
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 12:24:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234581AbjJYKYK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 06:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233635AbjJYKYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 06:24:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA45593;
        Wed, 25 Oct 2023 03:24:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD265C433C8;
        Wed, 25 Oct 2023 10:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698229443;
        bh=GQdg3NUKqJe71T4OetXfIUHqgADYd80NgX/aRvH11gQ=;
        h=From:To:Cc:Subject:Date:From;
        b=DRuePO5YqwsbzccyI2eIsaD0WsKXjLZRdAN4kLoQaHD8zTIJJlbf4cYhy5iWjLBW5
         nkx7vFGf5ggDw3Z7NGJ4ps79Wva1SsjnbzTAVBZhvemIub7X1IrudulIMhkEB4//QF
         u0UqdXj3cxd3YudOLiV59Ur/KbFjKDLMyxzD7DdU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.5.9
Date:   Wed, 25 Oct 2023 12:23:58 +0200
Message-ID: <2023102559-pouch-landside-710c@gregkh>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm announcing the release of the 6.5.9 kernel.

All users of the 6.5 kernel series must upgrade.

The updated 6.5.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.5.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/devicetree/bindings/mmc/sdhci-msm.yaml                   |    2 
 Documentation/networking/representors.rst                              |    8 
 Documentation/rust/general-information.rst                             |    2 
 Documentation/rust/index.rst                                           |    8 
 Makefile                                                               |    4 
 arch/arm/boot/dts/ti/omap/motorola-mapphone-common.dtsi                |    1 
 arch/arm64/boot/dts/mediatek/mt8195.dtsi                               |   10 
 arch/powerpc/Kconfig                                                   |    2 
 arch/powerpc/lib/qspinlock.c                                           |    3 
 arch/s390/pci/pci_dma.c                                                |   15 
 arch/x86/boot/compressed/sev.c                                         |   10 
 arch/x86/include/asm/fpu/api.h                                         |    3 
 arch/x86/include/asm/svm.h                                             |    1 
 arch/x86/kernel/fpu/core.c                                             |    5 
 arch/x86/kernel/fpu/xstate.c                                           |   12 
 arch/x86/kernel/fpu/xstate.h                                           |    3 
 arch/x86/kernel/sev-shared.c                                           |   53 ++-
 arch/x86/kernel/sev.c                                                  |   30 +
 arch/x86/kvm/cpuid.c                                                   |    8 
 arch/x86/kvm/lapic.c                                                   |    8 
 arch/x86/kvm/pmu.h                                                     |    6 
 arch/x86/kvm/svm/avic.c                                                |    5 
 arch/x86/kvm/svm/nested.c                                              |    3 
 arch/x86/kvm/svm/pmu.c                                                 |    2 
 arch/x86/kvm/svm/svm.c                                                 |    3 
 arch/x86/kvm/vmx/pmu_intel.c                                           |    4 
 arch/x86/kvm/x86.c                                                     |   37 +-
 crypto/asymmetric_keys/public_key.c                                    |    5 
 drivers/accel/ivpu/ivpu_drv.c                                          |    2 
 drivers/accel/ivpu/ivpu_fw.c                                           |    9 
 drivers/accel/ivpu/ivpu_gem.h                                          |    5 
 drivers/acpi/bus.c                                                     |    2 
 drivers/acpi/irq.c                                                     |    7 
 drivers/ata/libata-core.c                                              |    2 
 drivers/ata/libata-eh.c                                                |    2 
 drivers/base/regmap/regmap.c                                           |    2 
 drivers/bluetooth/btusb.c                                              |    1 
 drivers/bluetooth/hci_vhci.c                                           |    3 
 drivers/firmware/efi/unaccepted_memory.c                               |   64 +++
 drivers/gpio/gpio-timberdale.c                                         |    5 
 drivers/gpio/gpio-vf610.c                                              |    7 
 drivers/gpio/gpiolib-acpi.c                                            |    1 
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c                                 |    3 
 drivers/gpu/drm/amd/pm/amdgpu_pm.c                                     |    1 
 drivers/gpu/drm/bridge/ti-sn65dsi86.c                                  |   14 
 drivers/gpu/drm/drm_edid.c                                             |    3 
 drivers/gpu/drm/drm_panel_orientation_quirks.c                         |   16 
 drivers/gpu/drm/i915/display/intel_cx0_phy.c                           |    3 
 drivers/gpu/drm/i915/gem/i915_gem_mman.c                               |    1 
 drivers/gpu/drm/mediatek/mtk_drm_gem.c                                 |    6 
 drivers/gpu/drm/nouveau/nvkm/engine/disp/uconn.c                       |   14 
 drivers/hid/hid-holtek-kbd.c                                           |    4 
 drivers/hid/hid-ids.h                                                  |    1 
 drivers/hid/hid-input.c                                                |    2 
 drivers/hid/hid-logitech-hidpp.c                                       |    2 
 drivers/hid/hid-multitouch.c                                           |    4 
 drivers/hid/hid-nintendo.c                                             |  175 +++++-----
 drivers/i2c/i2c-mux.c                                                  |    2 
 drivers/iio/light/vcnl4000.c                                           |    1 
 drivers/mmc/core/block.c                                               |   31 +
 drivers/mmc/core/mmc.c                                                 |    2 
 drivers/mmc/core/sdio.c                                                |    8 
 drivers/mmc/host/mtk-sd.c                                              |    6 
 drivers/mmc/host/sdhci-pci-gli.c                                       |  104 +++--
 drivers/mtd/maps/physmap-core.c                                        |   11 
 drivers/mtd/nand/raw/arasan-nand-controller.c                          |   16 
 drivers/mtd/nand/raw/marvell_nand.c                                    |   23 +
 drivers/mtd/nand/raw/nand_base.c                                       |    3 
 drivers/mtd/nand/raw/nand_jedec.c                                      |    3 
 drivers/mtd/nand/raw/nand_onfi.c                                       |    3 
 drivers/mtd/nand/raw/pl35x-nand-controller.c                           |    9 
 drivers/mtd/nand/raw/qcom_nandc.c                                      |    2 
 drivers/mtd/nand/spi/micron.c                                          |    2 
 drivers/net/bonding/bond_main.c                                        |    2 
 drivers/net/dsa/bcm_sf2.c                                              |   24 -
 drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_io.c            |   36 +-
 drivers/net/ethernet/google/gve/gve_rx.c                               |   18 -
 drivers/net/ethernet/intel/i40e/i40e_common.c                          |    4 
 drivers/net/ethernet/intel/ice/ice_lib.c                               |    3 
 drivers/net/ethernet/intel/ice/ice_main.c                              |   18 +
 drivers/net/ethernet/marvell/octeon_ep/octep_main.c                    |   13 
 drivers/net/ethernet/marvell/sky2.h                                    |    2 
 drivers/net/ethernet/mellanox/mlx5/core/diag/fw_tracer.c               |    2 
 drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun_encap.c              |    3 
 drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c                       |    8 
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.c                       |   10 
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c                        |   35 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_stats.h                     |   11 
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c                        |    5 
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.c                      |   17 
 drivers/net/ethernet/qlogic/qed/qed_ll2.c                              |    7 
 drivers/net/mdio/mdio-mux.c                                            |   47 ++
 drivers/net/phy/bcm7xxx.c                                              |    3 
 drivers/net/tun.c                                                      |    7 
 drivers/net/usb/smsc95xx.c                                             |    2 
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c                            |    3 
 drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c                   |   16 
 drivers/net/wwan/iosm/iosm_ipc_imem.c                                  |   17 
 drivers/net/wwan/iosm/iosm_ipc_imem.h                                  |    2 
 drivers/net/wwan/iosm/iosm_ipc_pcie.c                                  |    4 
 drivers/net/wwan/iosm/iosm_ipc_port.c                                  |   17 
 drivers/net/wwan/iosm/iosm_ipc_trace.c                                 |    8 
 drivers/net/wwan/iosm/iosm_ipc_wwan.c                                  |   21 -
 drivers/nvme/host/auth.c                                               |    4 
 drivers/nvme/host/ioctl.c                                              |   10 
 drivers/nvme/host/pci.c                                                |    3 
 drivers/nvme/host/rdma.c                                               |    3 
 drivers/nvme/target/fabrics-cmd-auth.c                                 |    9 
 drivers/nvme/target/tcp.c                                              |    7 
 drivers/phy/motorola/phy-mapphone-mdm6600.c                            |   38 +-
 drivers/phy/qualcomm/phy-qcom-qmp-combo.c                              |    6 
 drivers/phy/qualcomm/phy-qcom-qmp-pcs-usb-v6.h                         |    3 
 drivers/phy/qualcomm/phy-qcom-qmp-usb.c                                |   24 +
 drivers/pinctrl/core.c                                                 |   16 
 drivers/pinctrl/qcom/pinctrl-lpass-lpi.c                               |   17 
 drivers/platform/surface/surface_platform_profile.c                    |    3 
 drivers/platform/x86/apple-gmux.c                                      |   14 
 drivers/platform/x86/asus-nb-wmi.c                                     |    3 
 drivers/platform/x86/asus-wmi.c                                        |   15 
 drivers/platform/x86/asus-wmi.h                                        |    2 
 drivers/platform/x86/intel/uncore-frequency/uncore-frequency-common.c  |    8 
 drivers/platform/x86/msi-ec.c                                          |    3 
 drivers/platform/x86/touchscreen_dmi.c                                 |   45 ++
 drivers/power/reset/Kconfig                                            |    2 
 drivers/regulator/core.c                                               |    6 
 drivers/s390/cio/css.c                                                 |    6 
 drivers/thunderbolt/tb.c                                               |   10 
 drivers/usb/serial/option.c                                            |    7 
 fs/btrfs/ctree.c                                                       |   52 ++
 fs/btrfs/delayed-ref.c                                                 |   46 ++
 fs/btrfs/delayed-ref.h                                                 |    1 
 fs/btrfs/extent-tree.c                                                 |    6 
 fs/btrfs/ioctl.c                                                       |    4 
 fs/btrfs/transaction.c                                                 |    6 
 fs/btrfs/tree-log.c                                                    |    2 
 fs/btrfs/volumes.c                                                     |    2 
 fs/fs-writeback.c                                                      |   11 
 fs/namei.c                                                             |    9 
 fs/nfs/flexfilelayout/flexfilelayout.c                                 |   17 
 fs/nfs/nfs42proc.c                                                     |    3 
 fs/nfs/nfs4proc.c                                                      |    2 
 fs/nfs/pnfs.c                                                          |   33 +
 fs/nfs/write.c                                                         |    4 
 fs/notify/fanotify/fanotify_user.c                                     |   25 -
 fs/ntfs3/fsntfs.c                                                      |    6 
 fs/ntfs3/index.c                                                       |    3 
 fs/ntfs3/ntfs_fs.h                                                     |    2 
 fs/ntfs3/super.c                                                       |   31 +
 fs/ntfs3/xattr.c                                                       |    7 
 fs/overlayfs/copy_up.c                                                 |    2 
 include/linux/fs.h                                                     |    2 
 include/linux/mtd/jedec.h                                              |    3 
 include/linux/mtd/onfi.h                                               |    1 
 include/linux/mtd/rawnand.h                                            |    2 
 include/linux/perf_event.h                                             |    1 
 include/linux/virtio_net.h                                             |   19 -
 include/net/bluetooth/hci_core.h                                       |    3 
 include/net/bluetooth/hci_mon.h                                        |    2 
 include/net/bluetooth/hci_sync.h                                       |    3 
 include/net/ip_fib.h                                                   |    1 
 include/net/netns/xfrm.h                                               |    1 
 include/net/sock.h                                                     |   10 
 include/net/tcp.h                                                      |    3 
 include/trace/events/neigh.h                                           |    4 
 io_uring/io-wq.c                                                       |   10 
 io_uring/io_uring.c                                                    |    6 
 kernel/auditsc.c                                                       |    8 
 kernel/events/core.c                                                   |   39 +-
 kernel/sched/cpufreq_schedutil.c                                       |    3 
 kernel/trace/fprobe.c                                                  |    6 
 kernel/trace/trace_events.c                                            |    1 
 kernel/trace/trace_kprobe.c                                            |   63 +++
 kernel/trace/trace_probe.h                                             |    1 
 mm/slab_common.c                                                       |    6 
 net/bluetooth/hci_conn.c                                               |  135 +++++--
 net/bluetooth/hci_core.c                                               |    8 
 net/bluetooth/hci_event.c                                              |   77 ++--
 net/bluetooth/hci_sock.c                                               |    3 
 net/bluetooth/hci_sync.c                                               |   70 ++--
 net/bluetooth/iso.c                                                    |   14 
 net/core/dev.c                                                         |   65 ++-
 net/core/dev.h                                                         |    3 
 net/core/pktgen.c                                                      |   14 
 net/core/rtnetlink.c                                                   |    4 
 net/core/stream.c                                                      |   12 
 net/ipv4/af_inet.c                                                     |   10 
 net/ipv4/esp4.c                                                        |    4 
 net/ipv4/fib_semantics.c                                               |   15 
 net/ipv4/fib_trie.c                                                    |    4 
 net/ipv4/inet_connection_sock.c                                        |    1 
 net/ipv4/inet_hashtables.c                                             |   24 -
 net/ipv4/tcp.c                                                         |   16 
 net/ipv4/tcp_bpf.c                                                     |   12 
 net/ipv4/tcp_ipv4.c                                                    |    1 
 net/ipv4/tcp_output.c                                                  |   25 +
 net/ipv4/tcp_recovery.c                                                |    2 
 net/ipv6/esp6.c                                                        |    4 
 net/ipv6/xfrm6_policy.c                                                |    4 
 net/mac80211/cfg.c                                                     |    3 
 net/mac80211/ibss.c                                                    |    2 
 net/mac80211/ieee80211_i.h                                             |    1 
 net/mac80211/mesh_plink.c                                              |    2 
 net/mac80211/mlme.c                                                    |   27 +
 net/mac80211/tx.c                                                      |    3 
 net/mac80211/vht.c                                                     |   16 
 net/mptcp/protocol.c                                                   |   43 +-
 net/netfilter/nf_tables_api.c                                          |   20 -
 net/netfilter/nft_inner.c                                              |    1 
 net/netfilter/nft_payload.c                                            |    2 
 net/netfilter/nft_set_rbtree.c                                         |    2 
 net/nfc/nci/spi.c                                                      |    2 
 net/rfkill/core.c                                                      |   37 +-
 net/rfkill/rfkill-gpio.c                                               |    4 
 net/sched/sch_hfsc.c                                                   |   18 -
 net/smc/af_smc.c                                                       |    2 
 net/sunrpc/auth.c                                                      |   11 
 net/sunrpc/auth_tls.c                                                  |    4 
 net/sunrpc/clnt.c                                                      |   10 
 net/sunrpc/xprtsock.c                                                  |    6 
 net/tls/tls_main.c                                                     |   10 
 net/tls/tls_sw.c                                                       |   57 ++-
 net/wireless/core.c                                                    |    2 
 net/wireless/nl80211.c                                                 |   21 +
 net/wireless/scan.c                                                    |    4 
 net/xfrm/xfrm_interface_core.c                                         |   22 -
 net/xfrm/xfrm_policy.c                                                 |   27 -
 rust/Makefile                                                          |   24 -
 rust/kernel/error.rs                                                   |    2 
 sound/pci/hda/patch_realtek.c                                          |   27 +
 sound/soc/codecs/cs35l56.c                                             |    2 
 sound/soc/codecs/cs42l42-sdw.c                                         |    1 
 sound/soc/codecs/wcd938x-sdw.c                                         |   27 +
 sound/soc/codecs/wcd938x.c                                             |   76 +++-
 sound/soc/pxa/pxa-ssp.c                                                |    2 
 tools/perf/util/dlfilter.c                                             |   32 -
 tools/testing/selftests/ftrace/test.d/kprobe/kprobe_non_uniq_symbol.tc |   13 
 tools/testing/selftests/net/mptcp/mptcp_join.sh                        |   21 +
 tools/testing/selftests/net/openvswitch/openvswitch.sh                 |    4 
 tools/testing/selftests/net/openvswitch/ovs-dpctl.py                   |   14 
 tools/testing/selftests/netfilter/nft_audit.sh                         |    6 
 240 files changed, 2166 insertions(+), 912 deletions(-)

Aaron Conole (3):
      selftests: openvswitch: Catch cases where the tests are killed
      selftests: openvswitch: Fix the ct_tuple for v4
      selftests: openvswitch: Add version check for pyroute2

Aditya Kumar Singh (1):
      wifi: cfg80211: validate AP phy operation before starting it

Adrian Hunter (1):
      perf dlfilter: Fix use of addr_location__exit() in dlfilter__object_code()

Adrien Thierry (2):
      phy: qcom-qmp-usb: initialize PCS_USB registers
      phy: qcom-qmp-usb: split PCS_USB init table for sc8280xp and sa8775p

Amir Goldstein (1):
      fanotify: limit reporting of event with non-decodeable file handles

Amir Tzin (1):
      net/mlx5e: Fix VF representors reporting zero counters to "ip -s" command

Andy Shevchenko (2):
      Revert "pinctrl: avoid unsafe code pattern in find_pinctrl()"
      gpiolib: acpi: Add missing memset(0) to acpi_get_gpiod_from_data()

Anna Schumaker (1):
      SUNRPC/TLS: Lock the lower_xprt during the tls handshake

Arkadiusz Bokowy (1):
      Bluetooth: vhci: Fix race when opening vhci device

Armin Wolf (1):
      platform/surface: platform_profile: Propagate error if profile registration fails

Arnd Bergmann (1):
      Bluetooth: avoid memcmp() out of bounds warning

Artem Borisov (1):
      ALSA: hda/realtek: Add quirk for ASUS ROG GU603ZV

Avri Altman (1):
      mmc: core: Capture correct oemid-bits for eMMC cards

Bagas Sanjaya (1):
      Revert "net: wwan: iosm: enable runtime pm support for 7560"

Ben Greear (1):
      wifi: iwlwifi: Ensure ack flag is properly cleared.

Benjamin Berg (1):
      wifi: cfg80211: avoid leaking stack data into trace

Benoît Monin (1):
      USB: serial: option: add entry for Sierra EM9191 with new firmware

Bibek Kumar Patro (1):
      mtd: rawnand: qcom: Unmap the right resource upon probe failure

Borislav Petkov (AMD) (1):
      x86/sev: Disable MMIO emulation from user mode

Carlos Bilbao (1):
      docs: Move rustdoc output, cross-reference it

Catalin Marinas (1):
      mm: slab: Do not create kmalloc caches smaller than arch_slab_minalign()

Chen-Yu Tsai (1):
      drm/mediatek: Correctly free sg_table in gem prime vmap

Chengfeng Ye (1):
      gpio: timberdale: Fix potential deadlock on &tgpio->lock

Christoph Paasch (1):
      netlink: Correct offload_xstats size

Chuck Lever (1):
      SUNRPC: Fail quickly when server does not recognize TLS

Chunhai Guo (1):
      fs-writeback: do not requeue a clean inode having skipped pages

Clément Léger (1):
      tracing: relax trace_event_eval_update() execution with cond_resched()

Dai Ngo (1):
      nfs42: client needs to strip file mode's suid/sgid bit after ALLOCATE op

Damien Le Moal (2):
      ata: libata-core: Fix compilation warning in ata_dev_config_ncq()
      ata: libata-eh: Fix compilation warning in ata_eh_link_report()

Dan Carpenter (2):
      net: usb: smsc95xx: Fix an error code in smsc95xx_reset()
      ASoC: pxa: fix a memory leak in probe()

Dan Clash (1):
      audit,io_uring: io_uring openat triggers audit reference count underflow

David Thompson (1):
      pwr-mlxbf: extend Kconfig to include gpio-mlxbf3 dependency

Dinghao Liu (1):
      s390/cio: fix a memleak in css_alloc_subchannel

Dong Chenchen (1):
      net: xfrm: skip policies marked as dead while reinserting policies

Dragos Tatulea (3):
      net/mlx5e: RX, Fix page_pool allocation failure recovery for striding rq
      net/mlx5e: RX, Fix page_pool allocation failure recovery for legacy rq
      net/mlx5e: XDP, Fix XDP_REDIRECT mpwqe page fragment leaks on shutdown

Dust Li (1):
      net/smc: return the right falback reason when prefix checks fail

Edward AD (1):
      Bluetooth: hci_sock: fix slab oob read in create_monitor_event

Eric Dumazet (6):
      xfrm: fix a data-race in xfrm_lookup_with_ifid()
      xfrm: fix a data-race in xfrm_gen_index()
      xfrm: interface: use DEV_STATS_INC()
      tcp: tsq: relax tcp_small_queue_check() when rtx queue contains a single skb
      tun: prevent negative ifindex
      ipv4: fib: annotate races around nh->nh_saddr_genid and nh->nh_saddr

Fabian Vogt (1):
      HID: Add quirk to ignore the touchscreen battery on HP ENVY 15-eu0556ng

Fabio Porcedda (1):
      USB: serial: option: add Telit LE910C4-WWX 0x1035 composition

Felix Kuehling (1):
      drm/amdgpu: Fix possible null pointer dereference

Filipe Manana (6):
      btrfs: fix race when refilling delayed refs block reserve
      btrfs: prevent transaction block reserve underflow when starting transaction
      btrfs: return -EUCLEAN for delayed tree ref with a ref count not equals to 1
      btrfs: error out when COWing block using a stale transaction
      btrfs: error when COWing block from a root that is being deleted
      btrfs: error out when reallocating block for defrag using a stale transaction

Florian Fainelli (1):
      net: phy: bcm7xxx: Add missing 16nm EPHY statistics

Florian Westphal (1):
      netfilter: nft_payload: fix wrong mac header matching

Francis Laniel (2):
      tracing/kprobes: Return EADDRNOTAVAIL when func matches several symbols
      selftests/ftrace: Add new test case which checks non unique symbol

Gavrilov Ilia (1):
      net: pktgen: Fix interface flags printing

Geert Uytterhoeven (2):
      neighbor: tracing: Move pin6 inside CONFIG_IPV6=y section
      mtd: physmap-core: Restore map_rom fallback

Geliang Tang (1):
      mptcp: avoid sending RST when closing the initial subflow

Gil Fine (1):
      thunderbolt: Call tb_switch_put() once DisplayPort bandwidth request is finished

Greg Kroah-Hartman (1):
      Linux 6.5.9

Gustavo A. R. Silva (1):
      wifi: mwifiex: Sanity check tlv_len and tlv_bitmap_len

Haibo Chen (3):
      mmc: core: sdio: hold retuning if sdio in 1-bit mode
      gpio: vf610: set value before the direction to avoid a glitch
      gpio: vf610: mask the gpio irq in system suspend and support wakeup

Hamza Mahfooz (1):
      drm/edid: add 8 bpc quirk to the BenQ GW2765

Hangbin Liu (1):
      ipv4/fib: send notify when delete source address routes

Hanjun Guo (1):
      ACPI: bus: Move acpi_arm_init() to the place of after acpi_ghes_init()

Hannes Reinecke (1):
      net/tls: split tls_rx_reader_lock

Hans de Goede (4):
      HID: logitech-hidpp: Add Bluetooth ID for the Logitech M720 Triathlon mouse
      platform/x86: asus-wmi: Change ASUS_WMI_BRN_DOWN code from 0x20 to 0x2e
      platform/x86: asus-wmi: Only map brightness codes when using asus-wmi backlight control
      platform/x86: asus-wmi: Map 0x2a code, Ignore 0x2b and 0x2c events

Heiner Kallweit (1):
      i2c: mux: Avoid potential false error message in i2c_mux_add_adapter

Herbert Xu (1):
      KEYS: asymmetric: Fix sign/verify on pkcs1pad without a hash

Ilan Peer (1):
      wifi: cfg80211: Fix 6GHz scan configuration

Iulia Tanasescu (1):
      Bluetooth: ISO: Fix invalid context error

Jacek Lawrynowicz (1):
      accel/ivpu: Don't flood dmesg with VPU ready message

Jakub Kicinski (4):
      net: avoid UAF on deleted altname
      net: fix ifname in netlink ntf during netns move
      net: check for altname conflicts when changing netdev's netns
      net: move altnames together with the netdevice

Jeff Layton (2):
      overlayfs: set ctime when setting mtime and atime
      nfs: decrement nrequests counter before releasing the req

Jeff Moyer (1):
      io-wq: fully initialize wqe before calling cpuhp_state_add_instance_nocalls()

Jens Axboe (1):
      io_uring: fix crash with IORING_SETUP_NO_MMAP and invalid SQ ring address

Jesse Brandeburg (2):
      ice: fix over-shifted variable
      ice: reset first in crash dump kernels

Jianbo Liu (1):
      net/mlx5e: Don't offload internal port if filter device is out device

Jim Mattson (1):
      KVM: x86: Mask LVTPC when handling a PMI

Jinjie Ruan (1):
      net: dsa: bcm_sf2: Fix possible memory leak in bcm_sf2_mdio_register()

Jiri Wiesner (1):
      bonding: Return pointer to data after pull on skb

Joerg Roedel (2):
      x86/sev: Check IOBM for IOIO exceptions from user-space
      x86/sev: Check for user-space IOIO pointing to kernel space

Johan Hovold (8):
      regmap: fix NULL deref on lookup
      ASoC: codecs: wcd938x-sdw: fix use after free on driver unbind
      ASoC: codecs: wcd938x-sdw: fix runtime PM imbalance on probe errors
      ASoC: codecs: wcd938x: drop bogus bind error handling
      ASoC: codecs: wcd938x: fix unbind tear down order
      ASoC: codecs: wcd938x: fix resource leaks on bind errors
      ASoC: codecs: wcd938x: fix regulator leaks on probe errors
      ASoC: codecs: wcd938x: fix runtime PM imbalance on remove

Johannes Berg (4):
      wifi: cfg80211: use system_unbound_wq for wiphy work
      rfkill: sync before userspace visibility/changes
      wifi: mac80211: work around Cisco AP 9115 VHT MPDU length
      net: rfkill: reduce data->mtx scope in rfkill_fop_open

Josef Bacik (2):
      btrfs: initialize start_slot in btrfs_log_prealloc_extents
      btrfs: fix some -Wmaybe-uninitialized warnings in ioctl.c

Josua Mayer (1):
      net: rfkill: gpio: prevent value glitch during probe

Kai Uwe Broulik (1):
      drm: panel-orientation-quirks: Add quirk for One Mix 2S

Kailang Yang (1):
      ALSA: hda/realtek - Fixed ASUS platform headset Mic issue

Karol Herbst (1):
      drm/nouveau/disp: fix DP capable DSM connectors

Kees Cook (2):
      sky2: Make sure there is at least one frag_addr available
      Bluetooth: hci_sock: Correctly bounds check and pad HCI_MON_NEW_INDEX name

Keith Busch (2):
      nvme: sanitize metadata bounce buffer for reads
      nvme-pci: add BOGUS_NID for Intel 0a54 device

Kenneth Feng (1):
      drm/amd/pm: add unique_id for gc 11.0.3

Khaled Almahallawy (1):
      drm/i915/cx0: Only clear/set the Pipe Reset bit of the PHY Lanes Owned

Kirill A. Shutemov (1):
      efi/unaccepted: Fix soft lockups caused by parallel memory acceptance

Konrad Dybcio (2):
      phy: qcom-qmp-combo: Square out 8550 POWER_STATE_CONFIG1
      phy: qcom-qmp-combo: initialize PCS_USB registers

Konstantin Komarov (2):
      fs/ntfs3: Fix shift-out-of-bounds in ntfs_fill_super
      fs/ntfs3: fix deadlock in mark_as_free_ex

Krzysztof Kozlowski (3):
      nfc: nci: fix possible NULL pointer dereference in send_acknowledge()
      dt-bindings: mmc: sdhci-msm: correct minimum number of clocks
      pinctrl: qcom: lpass-lpi: fix concurrent register updates

Kuniyuki Iwashima (1):
      tcp: Fix listen() warning with v4-mapped-v6 address.

Lama Kayal (1):
      net/mlx5e: Take RTNL lock before triggering netdev notifiers

Lee, Chun-Yi (2):
      Bluetooth: hci_event: Ignore NULL link key
      Bluetooth: Reject connection with the device which has same BD_ADDR

Luiz Augusto von Dentz (6):
      Bluetooth: hci_event: Fix coding style
      Bluetooth: hci_conn: Fix modifying handle while aborting
      Bluetooth: hci_core: Fix build warnings
      Bluetooth: hci_sync: Fix not handling ISO_LINK in hci_abort_conn_sync
      Bluetooth: hci_sync: Introduce PTR_UINT/UINT_PTR macros
      Bluetooth: hci_event: Fix using memcmp when comparing keys

Luka Guzenko (1):
      ALSA: hda/relatek: Enable Mute LED on HP Laptop 15s-fq5xxx

Ma Ke (3):
      net: ipv4: fix return value check in esp_remove_trailer
      net: ipv6: fix return value check in esp_remove_trailer
      HID: holtek: fix slab-out-of-bounds Write in holtek_kbd_input_event

Maher Sanalla (1):
      net/mlx5: Handle fw tracer change ownership event based on MTRC

Manish Chopra (1):
      qed: fix LL2 RX buffer allocation

Martin Kurbanov (1):
      mtd: spinand: micron: correct bitmask for ecc status

Martin Wilck (1):
      nvme-auth: use chap->s2 to indicate bidirectional authentication

Martino Fontana (1):
      HID: nintendo: reinitialize USB Pro Controller after resuming from suspend

Masami Hiramatsu (Google) (1):
      fprobe: Fix to ensure the number of active retprobes is not zero

Mateusz Pacuszka (1):
      ice: Fix safe mode when DDP is missing

Mateusz Polchlopek (1):
      docs: fix info about representor identification

Matthieu Baerts (2):
      selftests: mptcp: join: no RST when rm subflow/addr
      selftests: mptcp: join: correctly check for no RST

Maurizio Lombardi (2):
      nvmet-auth: complete a request only after freeing the dhchap pointers
      nvme-rdma: do not try to stop unallocated queues

Maxim Levitsky (3):
      x86: KVM: SVM: always update the x2avic msr interception
      x86: KVM: SVM: add support for Invalid IPI Vector interception
      x86: KVM: SVM: refresh AVIC inhibition in svm_leave_nested()

Michael Ellerman (1):
      powerpc/mm: Allow ARCH_FORCE_MAX_ORDER up to 12

Michal Schmidt (1):
      i40e: prevent crash on probe if hw registers have invalid values

Michał Mirosław (1):
      regulator/core: Revert "fix kobject release warning and memory leak in regulator_register()"

Miguel Ojeda (3):
      rust: docs: fix logo replacement
      docs: rust: update Rust docs output path
      kbuild: remove old Rust docs output path

Miquel Raynal (3):
      mtd: rawnand: pl353: Ensure program page operations are successful
      mtd: rawnand: marvell: Ensure program page operations are successful
      mtd: rawnand: arasan: Ensure program page operations are successful

Mårten Lindahl (1):
      iio: light: vcnl4000: Don't power on/off chip in config

Neal Cardwell (1):
      tcp: fix excessive TLP and RACK timeouts from HZ rounding

Nicholas Piggin (1):
      powerpc/qspinlock: Fix stale propagated yield_cpu

Nikita Kravets (1):
      platform/x86: msi-ec: Fix the 3rd config

Niklas Schnelle (1):
      s390/pci: fix iommu bitmap allocation

Olga Kornievskaia (1):
      NFSv4.1: fixup use EXCHGID4_FLAG_USE_PNFS_DS for DS server

Orlando Chamberlain (1):
      apple-gmux: Hard Code max brightness for MMIO gmux

Pablo Neira Ayuso (4):
      netfilter: nft_set_rbtree: .deactivate fails if element has expired
      netfilter: nf_tables: do not refresh timeout when resetting element
      netfilter: nf_tables: do not remove elements if set backend implements .abort
      netfilter: nf_tables: revert do not remove elements if set backend implements .abort

Pablo Sun (1):
      mmc: mtk-sd: Use readl_poll_timeout_atomic in msdc_reset_hw

Paolo Abeni (4):
      tcp: check mptcp-level constraints for backlog coalescing
      mptcp: more conservative check for zero probes
      tcp: allow again tcp_disconnect() when threads are waiting
      tcp_bpf: properly release resources on error paths

Pauli Virtanen (2):
      Bluetooth: hci_sync: delete CIS in BT_OPEN/CONNECT/BOUND when aborting
      Bluetooth: hci_sync: always check if connection is alive before deleting

Pavel Skripkin (1):
      fs/ntfs3: Fix OOB read in ntfs_init_from_boot

Pedro Tammela (1):
      net/sched: sch_hfsc: upgrade 'rt' to 'sc' when it becomes a inner curve

Peter Zijlstra (1):
      perf: Disallow mis-matched inherited group reads

Phil Sutter (1):
      selftests: netfilter: Run nft_audit.sh in its own netns

Puliang Lu (1):
      USB: serial: option: add Fibocom to DELL custom modem FM101R-GL

Rahul Rameshbabu (1):
      HID: multitouch: Add required quirk for Synaptics 0xcd7e device

Renan Guilherme Lebre Ramos (1):
      platform/x86: touchscreen_dmi: Add info for the Positivo C4128B

Richard Fitzgerald (2):
      ASoC: cs35l56: Fix illegal use of init_completion()
      ASoC: cs42l42: Fix missing include of gpio/consumer.h

Rob Herring (1):
      arm64: dts: mediatek: Fix "mediatek,merge-mute" and "mediatek,merge-fifo-en" types

Rocky Liao (1):
      Bluetooth: btusb: add shutdown function for QCA6174

Roman Kagan (1):
      KVM: x86/pmu: Truncate counter value to allowed width on write

Rouven Czerwinski (1):
      mtd: rawnand: Ensure the nand chip supports cached reads

Sagi Grimberg (1):
      nvmet-tcp: Fix a possible UAF in queue intialization setup

Scott Mayhew (1):
      NFS: Fix potential oops in nfs_inode_remove_request()

Sean Christopherson (2):
      x86/fpu: Allow caller to constrain xfeatures when copying to uabi buffer
      KVM: x86: Constrain guest-supported xfeatures only at KVM_GET_XSAVE{2}

Shailend Chand (1):
      gve: Do not fully free QPL pages on prefill errors

Shay Drory (1):
      net/mlx5: E-switch, register event handler before arming the event

Shinas Rasheed (1):
      octeon_ep: update BQL sent bytes before ringing doorbell

Srinivas Pandruvada (1):
      platform/x86: intel-uncore-freq: Conditionally create attribute for read frequency

Stanislaw Gruszka (1):
      Revert "accel/ivpu: Use cached buffers for FW loading"

Stephen Boyd (1):
      drm/bridge: ti-sn65dsi86: Associate DSI device lifetime with auxiliary device

Sunil V L (1):
      ACPI: irq: Fix incorrect return value in acpi_register_gsi()

Sven van Ashbrook (1):
      mmc: sdhci-pci-gli: fix LPM negotiation so x86/S0ix SoCs can suspend

Tomasz Swiatek (1):
      platform/x86: touchscreen_dmi: Add info for the BUSH Bush Windows tablet

Tony Lindgren (4):
      ARM: dts: ti: omap: Fix noisy serial with overrun-throttle-ms for mapphone
      phy: mapphone-mdm6600: Fix runtime disable on probe
      phy: mapphone-mdm6600: Fix runtime PM for remove
      phy: mapphone-mdm6600: Fix pinctrl_pm handling for sleep pins

Trond Myklebust (2):
      pNFS: Fix a hang in nfs4_evict_inode()
      pNFS/flexfiles: Check the layout validity in ff_layout_mirror_prepare_stats

Ulf Hansson (1):
      mmc: core: Fix error propagation for some ioctl commands

Ville Syrjälä (1):
      drm/i915: Retry gtt fault when out of fence registers

Vladimir Oltean (1):
      net: mdio-mux: fix C45 access returning -EIO after API change

Wedson Almeida Filho (1):
      rust: error: fix the description for `ECHILD`

Wen Gong (1):
      wifi: mac80211: allow transmitting EAPOL frames with tainted key

Willem de Bruijn (1):
      net: more strict VIRTIO_NET_HDR_GSO_UDP_L4 validation

Xingyuan Mo (2):
      nf_tables: fix NULL pointer dereference in nft_expr_inner_parse()
      nf_tables: fix NULL pointer dereference in nft_inner_init()

Xuewen Yan (1):
      cpufreq: schedutil: Update next_freq when cpufreq_limits change

Ying Hsu (1):
      Bluetooth: Avoid redundant authentication

Zeng Heng (1):
      fs/ntfs3: fix panic about slab-out-of-bounds caused by ntfs_list_ea()

Zhang Changzhong (1):
      xfrm6: fix inet6_dev refcount underflow problem

Ziqi Zhao (1):
      fs/ntfs3: Fix possible null-pointer dereference in hdr_find_e()

Ziyang Xuan (1):
      Bluetooth: Fix a refcnt underflow problem for hci_conn

Zygo Blaxell (1):
      btrfs: fix stripe length calculation for non-zoned data chunk allocation

