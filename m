Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BFFD76486F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 09:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231536AbjG0HXF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 03:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233115AbjG0HVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 03:21:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65E025FDB;
        Thu, 27 Jul 2023 00:14:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 280BF61D80;
        Thu, 27 Jul 2023 07:14:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7FB8C433C8;
        Thu, 27 Jul 2023 07:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690442047;
        bh=8UUj/oNO19sUxZlFofZYyoggoefpK+XCTTbKMnYmQjo=;
        h=From:To:Cc:Subject:Date:From;
        b=DhTnjrh7tlbKbQ/UnhieJ4zq46+Iv6N3mW3tUxNwKMv9c7Qlexf9qFV86NXrTbP7z
         N8ZL3YSy+C74LKz0DV7amjatut7mhwRkcS/HUK50av0Kr7cWIs8iK8vPeggnF3JHZk
         fEOMYMd3qh0fvuE5JPJvjh4LCistksQSvyac8KXo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.1.42
Date:   Thu, 27 Jul 2023 09:13:48 +0200
Message-ID: <2023072749-gumming-selector-a081@gregkh>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm announcing the release of the 6.1.42 kernel.

All users of the 6.1 kernel series must upgrade.

The updated 6.1.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.1.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/accounting/psi.rst                             |    4 
 Makefile                                                     |    2 
 arch/arm64/kernel/fpsimd.c                                   |   33 
 arch/arm64/net/bpf_jit_comp.c                                |    8 
 arch/mips/include/asm/dec/prom.h                             |    2 
 drivers/acpi/video_detect.c                                  |    8 
 drivers/base/regmap/regmap-i2c.c                             |    8 
 drivers/base/regmap/regmap-spi-avmm.c                        |    2 
 drivers/base/regmap/regmap.c                                 |    6 
 drivers/dma-buf/dma-resv.c                                   |   13 
 drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c                     |    5 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c            |  423 ++++----
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h            |   12 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c       |   12 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c    |  125 ++
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c  |  121 ++
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.h  |   11 
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c |    5 
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c             |  141 --
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c    |    3 
 drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c      |    2 
 drivers/gpu/drm/amd/display/dc/dm_helpers.h                  |    6 
 drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h              |    4 
 drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c      |    8 
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c         |    2 
 drivers/gpu/drm/display/drm_dp_mst_topology.c                |   54 -
 drivers/gpu/drm/drm_client_modeset.c                         |    6 
 drivers/gpu/drm/i915/display/intel_dp.c                      |    7 
 drivers/gpu/drm/nouveau/dispnv50/disp.c                      |   12 
 drivers/gpu/drm/radeon/radeon_cs.c                           |    3 
 drivers/gpu/drm/ttm/ttm_resource.c                           |    5 
 drivers/hid/hid-ids.h                                        |    1 
 drivers/hid/hid-quirks.c                                     |    1 
 drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c               |   10 
 drivers/net/can/spi/mcp251xfd/mcp251xfd.h                    |    1 
 drivers/net/can/usb/gs_usb.c                                 |   31 
 drivers/net/dsa/microchip/ksz8.h                             |    2 
 drivers/net/dsa/microchip/ksz8795.c                          |  121 +-
 drivers/net/dsa/microchip/ksz_common.c                       |    8 
 drivers/net/dsa/microchip/ksz_common.h                       |    7 
 drivers/net/dsa/mv88e6xxx/chip.c                             |    7 
 drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c           |   31 
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c   |   29 
 drivers/net/ethernet/intel/iavf/iavf.h                       |   16 
 drivers/net/ethernet/intel/iavf/iavf_ethtool.c               |   39 
 drivers/net/ethernet/intel/iavf/iavf_main.c                  |  232 +++-
 drivers/net/ethernet/intel/iavf/iavf_txrx.c                  |   43 
 drivers/net/ethernet/intel/iavf/iavf_txrx.h                  |    4 
 drivers/net/ethernet/intel/iavf/iavf_virtchnl.c              |    8 
 drivers/net/ethernet/intel/igb/igb_main.c                    |    5 
 drivers/net/ethernet/intel/igc/igc_main.c                    |   12 
 drivers/net/ethernet/litex/litex_liteeth.c                   |   19 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c         |    5 
 drivers/net/ethernet/mediatek/mtk_eth_soc.c                  |   29 
 drivers/net/ethernet/ti/cpsw_ale.c                           |   24 
 drivers/net/phy/phy_device.c                                 |   21 
 drivers/net/wireless/ath/ath11k/core.c                       |   53 -
 drivers/net/wireless/ath/ath11k/mac.c                        |    3 
 drivers/net/wireless/ath/ath11k/wmi.c                        |    5 
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c                 |    2 
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c                |    4 
 drivers/net/wireless/mac80211_hwsim.c                        |    4 
 drivers/of/platform.c                                        |    2 
 drivers/pinctrl/renesas/pinctrl-rzg2l.c                      |   28 
 drivers/pinctrl/renesas/pinctrl-rzv2m.c                      |   28 
 drivers/spi/spi-bcm63xx.c                                    |    2 
 drivers/spi/spi-dw-mmio.c                                    |   22 
 drivers/spi/spi-s3c64xx.c                                    |    2 
 drivers/video/fbdev/au1200fb.c                               |    3 
 drivers/video/fbdev/imxfb.c                                  |    5 
 fs/btrfs/block-group.c                                       |    1 
 fs/btrfs/inode.c                                             |   14 
 fs/btrfs/qgroup.c                                            |    1 
 fs/btrfs/volumes.c                                           |   20 
 fs/ext4/xattr.c                                              |   14 
 fs/fuse/dir.c                                                |    2 
 fs/fuse/inode.c                                              |    5 
 fs/fuse/ioctl.c                                              |   21 
 fs/jbd2/checkpoint.c                                         |  102 --
 fs/jfs/jfs_dmap.c                                            |    3 
 fs/jfs/jfs_txnmgr.c                                          |    5 
 fs/jfs/namei.c                                               |    5 
 fs/overlayfs/ovl_entry.h                                     |    9 
 fs/quota/dquot.c                                             |    5 
 fs/smb/client/connect.c                                      |   19 
 fs/udf/unicode.c                                             |    2 
 include/drm/display/drm_dp_mst_helper.h                      |    7 
 include/linux/psi.h                                          |    5 
 include/linux/psi_types.h                                    |   49 -
 include/linux/tcp.h                                          |    2 
 include/net/bluetooth/hci_core.h                             |    5 
 include/net/ip.h                                             |    2 
 include/net/tcp.h                                            |   31 
 io_uring/io_uring.c                                          |    8 
 kernel/bpf/bpf_lru_list.c                                    |   21 
 kernel/bpf/bpf_lru_list.h                                    |    7 
 kernel/bpf/syscall.c                                         |    3 
 kernel/bpf/verifier.c                                        |  234 ++++
 kernel/cgroup/cgroup.c                                       |    2 
 kernel/kallsyms.c                                            |   91 +
 kernel/kallsyms_internal.h                                   |    1 
 kernel/rcu/tasks.h                                           |    5 
 kernel/rcu/tree_exp.h                                        |    2 
 kernel/rcu/tree_plugin.h                                     |    4 
 kernel/sched/fair.c                                          |    4 
 kernel/sched/psi.c                                           |  528 ++++++-----
 kernel/trace/trace_events_hist.c                             |    3 
 lib/maple_tree.c                                             |    3 
 net/bluetooth/hci_conn.c                                     |   10 
 net/bluetooth/hci_core.c                                     |   42 
 net/bluetooth/hci_event.c                                    |   15 
 net/bluetooth/hci_sync.c                                     |  117 ++
 net/bluetooth/iso.c                                          |   53 -
 net/bluetooth/mgmt.c                                         |   26 
 net/bridge/br_stp_if.c                                       |    3 
 net/can/bcm.c                                                |   12 
 net/core/devlink.c                                           |    5 
 net/ipv4/esp4.c                                              |    2 
 net/ipv4/inet_connection_sock.c                              |    2 
 net/ipv4/inet_hashtables.c                                   |   17 
 net/ipv4/inet_timewait_sock.c                                |    8 
 net/ipv4/ip_output.c                                         |    4 
 net/ipv4/tcp.c                                               |   57 -
 net/ipv4/tcp_fastopen.c                                      |    6 
 net/ipv4/tcp_ipv4.c                                          |   27 
 net/ipv4/tcp_minisocks.c                                     |   11 
 net/ipv4/tcp_output.c                                        |    6 
 net/ipv6/ip6_gre.c                                           |    3 
 net/ipv6/tcp_ipv6.c                                          |    4 
 net/llc/llc_input.c                                          |    3 
 net/netfilter/nf_tables_api.c                                |   12 
 net/netfilter/nft_set_pipapo.c                               |    6 
 net/sched/cls_bpf.c                                          |   99 --
 net/sched/cls_matchall.c                                     |   35 
 net/sched/cls_u32.c                                          |   48 -
 net/wireless/wext-core.c                                     |    6 
 scripts/kallsyms.c                                           |   75 +
 scripts/link-vmlinux.sh                                      |    4 
 security/keys/request_key.c                                  |   35 
 security/keys/trusted-keys/trusted_tpm2.c                    |    2 
 sound/pci/emu10k1/emufx.c                                    |  112 --
 sound/pci/hda/patch_realtek.c                                |   54 -
 sound/soc/amd/acp/amd.h                                      |    7 
 sound/soc/codecs/cs42l51-i2c.c                               |    6 
 sound/soc/codecs/cs42l51.c                                   |    7 
 sound/soc/codecs/cs42l51.h                                   |    1 
 sound/soc/codecs/rt5640.c                                    |   12 
 sound/soc/codecs/wcd-mbhc-v2.c                               |   57 -
 sound/soc/codecs/wcd934x.c                                   |   12 
 sound/soc/codecs/wcd938x.c                                   |   86 +
 sound/soc/fsl/fsl_sai.c                                      |    8 
 sound/soc/fsl/fsl_sai.h                                      |    1 
 sound/soc/qcom/qdsp6/q6apm.c                                 |    7 
 sound/soc/qcom/qdsp6/topology.c                              |    4 
 sound/soc/sof/ipc3-dtrace.c                                  |    9 
 sound/soc/tegra/tegra210_adx.c                               |   34 
 sound/soc/tegra/tegra210_amx.c                               |   40 
 tools/perf/Makefile.config                                   |    4 
 tools/perf/tests/shell/test_uprobe_from_different_cu.sh      |   77 +
 tools/testing/radix-tree/maple.c                             |    6 
 tools/testing/selftests/bpf/prog_tests/align.c               |   38 
 tools/testing/selftests/bpf/prog_tests/sk_assign.c           |   25 
 tools/testing/selftests/bpf/progs/connect4_prog.c            |    2 
 tools/testing/selftests/bpf/progs/test_sk_assign.c           |   11 
 tools/testing/selftests/bpf/progs/test_sk_assign_libbpf.c    |    3 
 tools/testing/selftests/tc-testing/config                    |    2 
 tools/testing/selftests/tc-testing/settings                  |    1 
 167 files changed, 2989 insertions(+), 1559 deletions(-)

Abe Kohandel (2):
      spi: dw: Add compatible for Intel Mount Evans SoC
      spi: dw: Remove misleading comment for Mount Evans SoC

Aditi Ghag (1):
      bpf: tcp: Avoid taking fast sock lock in iterator

Ahmed Zaki (4):
      iavf: use internal state to free traffic IRQs
      iavf: send VLAN offloading caps once after VFR
      iavf: fix a deadlock caused by rtnl and driver's lock circular dependencies
      iavf: fix reset task race with iavf_remove()

Alex Deucher (2):
      drm/amdgpu/pm: make gfxclock consistent for sienna cichlid
      drm/amdgpu/pm: make mclk consistent for smu 13.0.7

Alexander Duyck (1):
      bpf, arm64: Fix BTI type used for freplace attached functions

Andrii Nakryiko (4):
      bpf: allow precision tracking for programs with subprogs
      bpf: stop setting precise in current state
      bpf: aggressively forget precise markings during state checkpointing
      selftests/bpf: make test_align selftest more robust

Antoine Tenart (1):
      net: ipv4: use consistent txhash in TIME_WAIT and SYN_RECV

Arnd Bergmann (1):
      kallsyms: add kallsyms_seqs_of_names to list of special symbols

Bernd Schubert (1):
      fuse: Apply flags2 only when userspace set the FUSE_INIT_EXT

Biju Das (1):
      pinctrl: renesas: rzg2l: Handle non-unique subnode names

Chengming Zhou (1):
      sched/psi: Fix avgs_work re-arm in psi_avgs_work()

Christian Brauner (1):
      ovl: check type and offset of struct vfsmount in ovl_entry

Christoffer Sandberg (1):
      ALSA: hda/realtek: Add quirk for Clevo NS70AU

Christoph Hellwig (1):
      btrfs: be a bit more careful when setting mirror_num_ret in btrfs_map_block

Dan Carpenter (1):
      ASoC: SOF: ipc3-dtrace: uninitialized data in dfsentry_trace_filter_write()

Daniel Golle (1):
      net: ethernet: mtk_eth_soc: handle probe deferral

Ding Hui (2):
      iavf: Fix use-after-free in free_netdev
      iavf: Fix out-of-bounds when setting channels on remove

Domenico Cerasuolo (4):
      sched/psi: Rearrange polling code in preparation
      sched/psi: Rename existing poll members in preparation
      sched/psi: Extract update_triggers side effect
      sched/psi: Allow unprivileged polling of N*2s period

Douglas Anderson (1):
      Bluetooth: hci_sync: Avoid use-after-free in dbg for hci_remove_adv_monitor()

Eric Dumazet (13):
      tcp: annotate data-races around tcp_rsk(req)->txhash
      tcp: annotate data-races around tcp_rsk(req)->ts_recent
      tcp: annotate data-races around tp->tcp_tx_delay
      tcp: annotate data-races around tp->tsoffset
      tcp: annotate data-races around tp->keepalive_time
      tcp: annotate data-races around tp->keepalive_intvl
      tcp: annotate data-races around tp->keepalive_probes
      tcp: annotate data-races around icsk->icsk_syn_retries
      tcp: annotate data-races around tp->linger2
      tcp: annotate data-races around rskq_defer_accept
      tcp: annotate data-races around tp->notsent_lowat
      tcp: annotate data-races around icsk->icsk_user_timeout
      tcp: annotate data-races around fastopenq.max_qlen

Eric Whitney (1):
      ext4: correct inline offset when handling xattrs in inode body

Fabio Estevam (1):
      ASoC: fsl_sai: Revert "ASoC: fsl_sai: Enable MCTL_MCLK_EN bit for master mode"

Fedor Ross (1):
      can: mcp251xfd: __mcp251xfd_chip_set_mode(): increase poll timeout

Filipe Manana (2):
      btrfs: fix warning when putting transaction with qgroups enabled after abort
      btrfs: zoned: fix memory leak after finding block group with super blocks

Florian Kauer (1):
      igc: Prevent garbled TX queue with XDP ZEROCOPY

Florian Westphal (3):
      netfilter: nf_tables: fix spurious set element insertion failure
      netfilter: nf_tables: can't schedule in nft_chain_validate
      netfilter: nft_set_pipapo: fix improper element removal

Geert Uytterhoeven (1):
      pinctrl: renesas: rzv2m: Handle non-unique subnode names

Geetha sowjanya (1):
      octeontx2-pf: Dont allocate BPIDs for LBK interfaces

Georg Müller (1):
      perf probe: Add test for regression introduced by switch to die_get_decl_file()

Greg Kroah-Hartman (1):
      Linux 6.1.42

Guchun Chen (1):
      drm/amdgpu/vkms: relax timer deactivation by hrtimer_try_to_cancel

Gustavo A. R. Silva (2):
      MIPS: dec: prom: Address -Warray-bounds warning
      wifi: wext-core: Fix -Wstringop-overflow warning in ioctl_standard_iw_point()

Hamza Mahfooz (1):
      drm/amd/display: use max_dsc_bpp in amdgpu_dm

Hans de Goede (1):
      ACPI: video: Add backlight=native DMI quirk for Dell Studio 1569

Hao Chen (1):
      net: hns3: fix strncpy() not using dest-buf length as length issue

Hersen Wu (2):
      drm/amd/display: fix linux dp link lost handled only one time
      Revert "drm/amd/display: edp do not add non-edid timings"

Ilan Peer (1):
      wifi: mac80211_hwsim: Fix possible NULL dereference

Ilya Leoshkevich (1):
      selftests/bpf: Fix sk_assign on s390x

Immad Mir (2):
      FS: JFS: Fix null-ptr-deref Read in txBegin
      FS: JFS: Check for read-only mounted filesystem in txBegin

Jaewon Kim (1):
      spi: s3c64xx: clear loopback bit after loopback test

James Clark (1):
      perf build: Fix library not found error when using CSLIBS

Jan Kara (2):
      quota: Properly disable quotas when add_dquot_ref() fails
      udf: Fix uninitialized array access for some pathnames

Jens Axboe (1):
      io_uring: treat -EAGAIN for REQ_F_NOWAIT as final for io-wq

Jiapeng Chong (1):
      security: keys: Modify mismatched function name

Jisheng Zhang (1):
      net: ethernet: litex: add support for 64 bit stats

Jocelyn Falempe (2):
      drm/client: Fix memory leak in drm_client_target_cloned
      drm/client: Fix memory leak in drm_client_modeset_probe

Johan Hovold (9):
      ASoC: codecs: wcd938x: fix missing clsh ctrl error handling
      ASoC: codecs: wcd-mbhc-v2: fix resource leaks on component remove
      ASoC: qdsp6: audioreach: fix topology probe deferral
      ASoC: codecs: wcd938x: fix resource leaks on component remove
      ASoC: codecs: wcd938x: fix missing mbhc init error handling
      ASoC: codecs: wcd934x: fix resource leaks on component remove
      ASoC: codecs: wcd938x: fix codec initialisation race
      ASoC: codecs: wcd938x: fix soundwire initialisation race
      ASoC: codecs: wcd938x: fix mbhc impedance loglevel

Johannes Berg (1):
      wifi: iwlwifi: mvm: avoid baid size integer overflow

Jonas Gorski (1):
      spi: bcm63xx: fix max prepend length

Josef Bacik (2):
      btrfs: set_page_extent_mapped after read_folio in btrfs_cont_expand
      btrfs: fix race between balance and cancel/pause

Kailang Yang (1):
      ALSA: hda/realtek - remove 3k pull low procedure

Kui-Feng Lee (1):
      bpf: Print a warning only if writing to unprivileged_bpf_disabled.

Kumar Kartikeya Dwivedi (2):
      bpf: Fix subprog idx logic in check_max_stack_depth
      bpf: Repeat check_max_stack_depth for async callbacks

Kuniyuki Iwashima (3):
      bridge: Add extack warning when enabling STP in netns.
      Revert "tcp: avoid the lookup process failing to get sk in ehash table"
      llc: Don't drop packet from non-root netns.

Kurt Kanzenbach (1):
      igc: Avoid transmit queue timeout for XDP

Liam R. Howlett (1):
      maple_tree: fix node allocation testing on 32 bit

Linus Walleij (1):
      dsa: mv88e6xxx: Do a final check before timing out

Luka Guzenko (1):
      ALSA: hda/realtek: Enable Mute LED on HP Laptop 15s-eq2xxx

Marc Kleine-Budde (1):
      can: gs_usb: gs_can_open(): improve error handling

Marcin Szycik (2):
      iavf: Move netdev_update_features() into watchdog task
      iavf: Wait for reset in callbacks which trigger it

Marco Morandini (1):
      HID: add quirk for 03f0:464a HP Elite Presenter Mouse

Mark Brown (3):
      regmap: Drop initial version of maximum transfer length fixes
      regmap: Account for register length in SMBus I/O limits
      arm64/fpsimd: Ensure SME storage is allocated after SVE VL changes

Martin KaFai Lau (1):
      bpf: Address KCSAN report on bpf_lru_list

Martin Kaiser (1):
      fbdev: imxfb: warn about invalid left/right margin

Masahiro Yamada (1):
      scripts/kallsyms: update the usage in the comment block

Matthieu Baerts (3):
      selftests: tc: set timeout to 15 minutes
      selftests: tc: add 'ct' action kconfig dep
      selftests: tc: add ConnTrack procfs kconfig

Matus Gajdos (1):
      ASoC: fsl_sai: Disable bit clock with transmitter

Maxime Bizon (1):
      wifi: ath11k: fix registration of 6Ghz-only phy without the full channel range

Miaohe Lin (1):
      sched/fair: Use recent_used_cpu to test p->cpus_ptr

Miklos Szeredi (2):
      fuse: revalidate: don't invalidate if interrupted
      fuse: ioctl: translate ENOSYS in outarg

Mohamed Khalfella (1):
      tracing/histograms: Return an error if we fail to add histogram to hist_vars list

Mukesh Sisodiya (1):
      wifi: iwlwifi: Add support for new PCI Id

Nicholas Kazlauskas (1):
      drm/amd/display: Keep PHY active for DP displays on DCN31

Oleksij Rempel (3):
      net: dsa: microchip: ksz8: Separate static MAC table operations for code reuse
      net: dsa: microchip: ksz8: Make ksz8_r_sta_mac_table() static
      net: dsa: microchip: ksz8_r_sta_mac_table(): Avoid using error code for empty entries

Oswald Buddenhagen (1):
      ALSA: emu10k1: roll up loops in DSP setup code for Audigy

P Praneesh (1):
      wifi: ath11k: fix memory leak in WMI firmware stats

Pablo Neira Ayuso (2):
      netfilter: nf_tables: skip bound chain in netns release path
      netfilter: nf_tables: skip bound chain on rule flush

Paul E. McKenney (1):
      rcu: Mark additional concurrent load from ->cpu_no_qs.b.exp

Pauli Virtanen (3):
      Bluetooth: use RCU for hci_conn_params and iterate safely in hci_sync
      Bluetooth: hci_event: call disconnect callback before deleting conn
      Bluetooth: ISO: fix iso_conn related locking and validity issues

Peng Zhang (1):
      maple_tree: set the node limit when creating a new root node

Petr Oros (1):
      devlink: report devlink_port_type_warn source device

Petr Pavlu (1):
      keys: Fix linking a duplicate key to a keyring's assoc_array

Przemek Kitszel (1):
      iavf: make functions static where possible

Qingqing Zhuo (1):
      drm/amd/display: force connector state when bpc changes during compliance

Rob Herring (1):
      of: Preserve "of-display" device name for compatibility

Sameer Pujar (1):
      ASoC: rt5640: Fix sleep in atomic context

Sheetal (2):
      ASoC: tegra: Fix ADX byte map
      ASoC: tegra: Fix AMX byte map

Shigeru Yoshida (1):
      rcu-tasks: Avoid pr_info() with spin lock in cblist_init_generic()

Shyam Prasad N (1):
      cifs: fix mid leak during reconnection after timeout threshold

Simon Ser (1):
      drm/amd/display: only accept async flips for fast updates

Srinivas Kandagatla (2):
      ASoC: codecs: wcd938x: fix dB range for HPHL and HPHR
      ASoC: qcom: q6apm: do not close GPR port before closing graph

Srinivasan Shanmugam (2):
      drm/amd/display: fix some coding style issues
      drm/amd/display: Clean up errors & warnings in amdgpu_dm.c

Suren Baghdasaryan (1):
      sched/psi: use kernfs polling functions for PSI trigger polling

Taimur Hassan (1):
      drm/amd/display: check TG is non-null before checking if enabled

Tanmay Patil (1):
      net: ethernet: ti: cpsw_ale: Fix cpsw_ale_get_field()/cpsw_ale_set_field()

Thomas Petazzoni (1):
      ASoC: cs42l51: fix driver to properly autoload with automatic module loading

Tristram Ha (1):
      net: dsa: microchip: correct KSZ8795 static MAC table access

Victor Nogueira (4):
      net: sched: cls_matchall: Undo tcf_bind_filter in case of failure after mall_set_parms
      net: sched: cls_u32: Undo tcf_bind_filter if u32_replace_hw_knode
      net: sched: cls_u32: Undo refcount decrement in case update failed
      net: sched: cls_bpf: Undo tcf_bind_filter in case of an error

Vijendar Mukunda (1):
      ASoC: amd: acp: fix for invalid dai id handling in acp_get_byte_count()

Ville Syrjälä (1):
      dma-buf/dma-resv: Stop leaking on krealloc() failure

Vitaly Rodionov (1):
      ALSA: hda/realtek: Fix generic fixup definition for cs35l41 amp

Vladimir Oltean (1):
      net: phy: prevent stale pointer dereference in phy_init()

Wang Ming (1):
      net: ipv4: Use kfree_sensitive instead of kfree

Wayne Lin (2):
      drm/dp_mst: Clear MSG_RDY flag before sending new message
      drm/amd/display: Add polling method to handle MST reply packet

Wen Gong (1):
      wifi: ath11k: add support default regdb while searching board-2.bin for WCN6855

Yangtao Li (1):
      fbdev: imxfb: Removed unneeded release_mem_region

Ye Bin (1):
      quota: fix warning in dqgrab()

Yi Kuo (1):
      wifi: iwlwifi: pcie: add device id 51F1 for killer 1675

Yicong Yang (1):
      sched/fair: Don't balance task to its current running CPU

Ying Hsu (1):
      igb: Fix igb_down hung on surprise removal

Yogesh (1):
      fs: jfs: Fix UBSAN: array-index-out-of-bounds in dbAllocDmapLev

Yonghong Song (2):
      kallsyms: strip LTO-only suffixes from promoted global functions
      selftests/bpf: Workaround verification failure for fexit_bpf2bpf/func_replace_return_code

Yuanjun Gong (1):
      net:ipv6: check return value of pskb_trim()

YueHaibing (1):
      can: bcm: Fix UAF in bcm_proc_show()

Yuma Ueda (1):
      scripts/kallsyms.c Make the comment up-to-date with current implementation

Yunxiang Li (1):
      drm/ttm: fix bulk_move corruption when adding a entry

Zhang Shurong (1):
      fbdev: au1200fb: Fix missing IRQ check in au1200fb_drv_probe

Zhang Yi (1):
      jbd2: recheck chechpointing non-dirty buffer

Zhen Lei (2):
      kallsyms: Improve the performance of kallsyms_lookup_name()
      kallsyms: Correctly sequence symbols when CONFIG_LTO_CLANG=y

Zhikai Zhai (1):
      drm/amd/display: Disable MPC split by default on special asic

hackyzh002 (1):
      drm/radeon: Fix integer overflow in radeon_cs_parser_init

