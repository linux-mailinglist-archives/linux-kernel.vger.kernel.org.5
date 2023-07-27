Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0361376486B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 09:21:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233288AbjG0HV3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 03:21:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233215AbjG0HU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 03:20:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6069030F5;
        Thu, 27 Jul 2023 00:14:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EC4C661D6F;
        Thu, 27 Jul 2023 07:13:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF6A2C433C7;
        Thu, 27 Jul 2023 07:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690442039;
        bh=Djk7T0b/cnVtp3wT6zK06Yg6LNGSdOske3C5T8PRJQs=;
        h=From:To:Cc:Subject:Date:From;
        b=arHyKVff2TqlamcTdjZu8EAxIomjH8SPfcpMThtbQj0ivbbDmi1VJLhWtzK9tz3h0
         avlm6OwuXgzHOuXeoD61muVCEFFeKHNyr/6OB0QsFfoiKmU3v7FNd21C6bE0QFfCU3
         EX6dADg9Jm2anLmGm/DE0XXPhDoEfijdeGmw8YyY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.15.123
Date:   Thu, 27 Jul 2023 09:13:32 +0200
Message-ID: <2023072733-driving-bulldog-c9e6@gregkh>
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

I'm announcing the release of the 5.15.123 kernel.

All users of the 5.15 kernel series must upgrade.

The updated 5.15.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.15.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                                     |    2 
 arch/mips/include/asm/dec/prom.h                             |    2 
 drivers/base/regmap/regmap-i2c.c                             |    8 
 drivers/base/regmap/regmap-spi-avmm.c                        |    2 
 drivers/base/regmap/regmap.c                                 |    6 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c            |    8 
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c |    5 
 drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c      |    2 
 drivers/gpu/drm/drm_client_modeset.c                         |    6 
 drivers/gpu/drm/radeon/radeon_cs.c                           |    3 
 drivers/net/ethernet/agere/et131x.c                          |    4 
 drivers/net/ethernet/alacritech/slicoss.c                    |    2 
 drivers/net/ethernet/allwinner/sun4i-emac.c                  |    2 
 drivers/net/ethernet/altera/altera_tse_main.c                |    2 
 drivers/net/ethernet/amazon/ena/ena_netdev.c                 |    2 
 drivers/net/ethernet/aquantia/atlantic/aq_nic.c              |    2 
 drivers/net/ethernet/arc/emac_main.c                         |    2 
 drivers/net/ethernet/atheros/ag71xx.c                        |    2 
 drivers/net/ethernet/broadcom/bcm4908_enet.c                 |    2 
 drivers/net/ethernet/broadcom/bcmsysport.c                   |    2 
 drivers/net/ethernet/broadcom/bgmac-bcma.c                   |    4 
 drivers/net/ethernet/broadcom/bgmac-platform.c               |    2 
 drivers/net/ethernet/broadcom/bgmac.c                        |    2 
 drivers/net/ethernet/broadcom/bnxt/bnxt_vfr.c                |    2 
 drivers/net/ethernet/broadcom/genet/bcmgenet.c               |    4 
 drivers/net/ethernet/brocade/bna/bnad.c                      |    4 
 drivers/net/ethernet/cadence/macb_main.c                     |    2 
 drivers/net/ethernet/cavium/liquidio/lio_core.c              |    2 
 drivers/net/ethernet/cavium/liquidio/lio_main.c              |    2 
 drivers/net/ethernet/cavium/liquidio/lio_vf_main.c           |    2 
 drivers/net/ethernet/cavium/octeon/octeon_mgmt.c             |    2 
 drivers/net/ethernet/cavium/thunder/nicvf_main.c             |    3 
 drivers/net/ethernet/emulex/benet/be_main.c                  |    2 
 drivers/net/ethernet/ethoc.c                                 |    4 
 drivers/net/ethernet/ezchip/nps_enet.c                       |    4 
 drivers/net/ethernet/faraday/ftgmac100.c                     |    4 
 drivers/net/ethernet/freescale/fec_mpc52xx.c                 |    2 
 drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c        |    2 
 drivers/net/ethernet/freescale/gianfar.c                     |    2 
 drivers/net/ethernet/freescale/ucc_geth.c                    |    2 
 drivers/net/ethernet/google/gve/gve_adminq.c                 |    2 
 drivers/net/ethernet/hisilicon/hisi_femac.c                  |    2 
 drivers/net/ethernet/hisilicon/hix5hd2_gmac.c                |    2 
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c              |    4 
 drivers/net/ethernet/ibm/ibmveth.c                           |    2 
 drivers/net/ethernet/ibm/ibmvnic.c                           |    5 
 drivers/net/ethernet/intel/fm10k/fm10k_netdev.c              |    2 
 drivers/net/ethernet/intel/fm10k/fm10k_pci.c                 |    4 
 drivers/net/ethernet/intel/i40e/i40e_main.c                  |    4 
 drivers/net/ethernet/intel/iavf/iavf_ethtool.c               |    2 
 drivers/net/ethernet/intel/iavf/iavf_main.c                  |    7 
 drivers/net/ethernet/intel/iavf/iavf_virtchnl.c              |    4 
 drivers/net/ethernet/intel/ice/ice_main.c                    |    4 
 drivers/net/ethernet/intel/igc/igc_main.c                    |    4 
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c            |    6 
 drivers/net/ethernet/korina.c                                |    4 
 drivers/net/ethernet/lantiq_xrx200.c                         |    2 
 drivers/net/ethernet/litex/litex_liteeth.c                   |    2 
 drivers/net/ethernet/marvell/mvneta.c                        |    2 
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c              |    4 
 drivers/net/ethernet/marvell/mvpp2/mvpp2_prs.c               |    2 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c     |    2 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c         |    5 
 drivers/net/ethernet/marvell/prestera/prestera_main.c        |    2 
 drivers/net/ethernet/marvell/pxa168_eth.c                    |    2 
 drivers/net/ethernet/marvell/sky2.c                          |    2 
 drivers/net/ethernet/mediatek/mtk_eth_soc.c                  |   29 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c            |    2 
 drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c   |    2 
 drivers/net/ethernet/micrel/ks8851_common.c                  |    2 
 drivers/net/ethernet/microchip/enc28j60.c                    |    4 
 drivers/net/ethernet/microchip/lan743x_main.c                |    4 
 drivers/net/ethernet/microchip/sparx5/sparx5_netdev.c        |    2 
 drivers/net/ethernet/microsoft/mana/mana_en.c                |    2 
 drivers/net/ethernet/mscc/ocelot_net.c                       |    2 
 drivers/net/ethernet/netronome/nfp/abm/main.c                |    2 
 drivers/net/ethernet/netronome/nfp/nfp_net_main.c            |    2 
 drivers/net/ethernet/netronome/nfp/nfp_netvf_main.c          |    2 
 drivers/net/ethernet/ni/nixge.c                              |    6 
 drivers/net/ethernet/nxp/lpc_eth.c                           |    2 
 drivers/net/ethernet/qlogic/qede/qede_filter.c               |    4 
 drivers/net/ethernet/qlogic/qede/qede_main.c                 |    2 
 drivers/net/ethernet/qualcomm/emac/emac.c                    |    2 
 drivers/net/ethernet/qualcomm/qca_spi.c                      |    2 
 drivers/net/ethernet/qualcomm/qca_uart.c                     |    2 
 drivers/net/ethernet/renesas/ravb_main.c                     |    2 
 drivers/net/ethernet/samsung/sxgbe/sxgbe_platform.c          |    2 
 drivers/net/ethernet/sfc/ef10_sriov.c                        |    2 
 drivers/net/ethernet/sfc/efx.c                               |    2 
 drivers/net/ethernet/sfc/efx_common.c                        |    4 
 drivers/net/ethernet/sfc/falcon/efx.c                        |    6 
 drivers/net/ethernet/socionext/netsec.c                      |    2 
 drivers/net/ethernet/socionext/sni_ave.c                     |    2 
 drivers/net/ethernet/ti/am65-cpsw-nuss.c                     |    2 
 drivers/net/ethernet/ti/cpsw_ale.c                           |   24 +-
 drivers/net/ethernet/ti/cpsw_new.c                           |    4 
 drivers/net/ethernet/ti/davinci_emac.c                       |    2 
 drivers/net/ethernet/ti/netcp_core.c                         |    4 
 drivers/net/ethernet/xilinx/xilinx_emaclite.c                |    2 
 drivers/net/phy/phy_device.c                                 |   21 +-
 drivers/pinctrl/pinctrl-amd.c                                |   28 +-
 drivers/spi/spi-bcm63xx.c                                    |    2 
 drivers/video/fbdev/au1200fb.c                               |    3 
 drivers/video/fbdev/imxfb.c                                  |    4 
 fs/btrfs/block-group.c                                       |    1 
 fs/btrfs/qgroup.c                                            |    1 
 fs/ext4/xattr.c                                              |   14 +
 fs/fuse/dir.c                                                |    2 
 fs/fuse/ioctl.c                                              |   21 +-
 fs/jbd2/checkpoint.c                                         |  102 ++--------
 fs/jfs/jfs_dmap.c                                            |    3 
 fs/jfs/jfs_txnmgr.c                                          |    5 
 fs/jfs/namei.c                                               |    5 
 fs/quota/dquot.c                                             |    5 
 fs/udf/unicode.c                                             |    2 
 include/linux/etherdevice.h                                  |    2 
 include/linux/of_net.h                                       |    6 
 include/linux/tcp.h                                          |    2 
 include/net/tcp.h                                            |   31 ++-
 kernel/bpf/verifier.c                                        |   11 -
 kernel/trace/trace_events_hist.c                             |    3 
 net/bridge/br_stp_if.c                                       |    3 
 net/can/bcm.c                                                |   12 -
 net/core/of_net.c                                            |   25 ++
 net/ipv4/esp4.c                                              |    2 
 net/ipv4/inet_connection_sock.c                              |    2 
 net/ipv4/inet_hashtables.c                                   |   17 -
 net/ipv4/inet_timewait_sock.c                                |    8 
 net/ipv4/tcp.c                                               |   53 ++---
 net/ipv4/tcp_fastopen.c                                      |    6 
 net/ipv4/tcp_ipv4.c                                          |    2 
 net/ipv4/tcp_minisocks.c                                     |    9 
 net/ipv4/tcp_output.c                                        |    2 
 net/ipv6/ip6_gre.c                                           |    3 
 net/ipv6/tcp_ipv6.c                                          |    2 
 net/llc/llc_input.c                                          |    3 
 net/netfilter/nf_tables_api.c                                |    8 
 net/netfilter/nft_set_pipapo.c                               |    6 
 net/sched/cls_bpf.c                                          |   99 ++++-----
 security/keys/request_key.c                                  |   35 ++-
 security/keys/trusted-keys/trusted_tpm2.c                    |    2 
 sound/pci/emu10k1/emufx.c                                    |  112 -----------
 sound/pci/hda/patch_realtek.c                                |   29 ++
 sound/soc/codecs/wcd-mbhc-v2.c                               |   57 ++++-
 sound/soc/codecs/wcd934x.c                                   |   12 +
 sound/soc/codecs/wcd938x.c                                   |   76 ++++++-
 sound/soc/fsl/fsl_sai.c                                      |    2 
 sound/soc/fsl/fsl_sai.h                                      |    1 
 tools/perf/Makefile.config                                   |    4 
 tools/perf/tests/shell/test_uprobe_from_different_cu.sh      |   77 +++++++
 tools/testing/selftests/tc-testing/config                    |    2 
 tools/testing/selftests/tc-testing/settings                  |    1 
 152 files changed, 735 insertions(+), 548 deletions(-)

Arnd Bergmann (1):
      nixge: fix mac address error handling again

Christoffer Sandberg (1):
      ALSA: hda/realtek: Add quirk for Clevo NS70AU

Daniel Golle (1):
      net: ethernet: mtk_eth_soc: handle probe deferral

Ding Hui (2):
      iavf: Fix use-after-free in free_netdev
      iavf: Fix out-of-bounds when setting channels on remove

Eric Dumazet (11):
      tcp: annotate data-races around tcp_rsk(req)->ts_recent
      tcp: annotate data-races around tp->tcp_tx_delay
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

Filipe Manana (2):
      btrfs: fix warning when putting transaction with qgroups enabled after abort
      btrfs: zoned: fix memory leak after finding block group with super blocks

Florian Kauer (1):
      igc: Prevent garbled TX queue with XDP ZEROCOPY

Florian Westphal (2):
      netfilter: nf_tables: fix spurious set element insertion failure
      netfilter: nft_set_pipapo: fix improper element removal

Geetha sowjanya (1):
      octeontx2-pf: Dont allocate BPIDs for LBK interfaces

Georg Müller (1):
      perf probe: Add test for regression introduced by switch to die_get_decl_file()

Greg Kroah-Hartman (1):
      Linux 5.15.123

Gustavo A. R. Silva (1):
      MIPS: dec: prom: Address -Warray-bounds warning

Hersen Wu (1):
      Revert "drm/amd/display: edp do not add non-edid timings"

Immad Mir (2):
      FS: JFS: Fix null-ptr-deref Read in txBegin
      FS: JFS: Check for read-only mounted filesystem in txBegin

Jakub Kicinski (3):
      ethernet: use eth_hw_addr_set() instead of ether_addr_copy()
      of: net: add a helper for loading netdev->dev_addr
      ethernet: use of_get_ethdev_address()

James Clark (1):
      perf build: Fix library not found error when using CSLIBS

Jan Kara (2):
      quota: Properly disable quotas when add_dquot_ref() fails
      udf: Fix uninitialized array access for some pathnames

Jiapeng Chong (1):
      security: keys: Modify mismatched function name

Jocelyn Falempe (2):
      drm/client: Fix memory leak in drm_client_target_cloned
      drm/client: Fix memory leak in drm_client_modeset_probe

Johan Hovold (7):
      ASoC: codecs: wcd938x: fix missing clsh ctrl error handling
      ASoC: codecs: wcd-mbhc-v2: fix resource leaks on component remove
      ASoC: codecs: wcd938x: fix resource leaks on component remove
      ASoC: codecs: wcd938x: fix missing mbhc init error handling
      ASoC: codecs: wcd934x: fix resource leaks on component remove
      ASoC: codecs: wcd938x: fix codec initialisation race
      ASoC: codecs: wcd938x: fix soundwire initialisation race

Jonas Gorski (1):
      spi: bcm63xx: fix max prepend length

Kailang Yang (1):
      ALSA: hda/realtek - remove 3k pull low procedure

Kumar Kartikeya Dwivedi (1):
      bpf: Fix subprog idx logic in check_max_stack_depth

Kuniyuki Iwashima (3):
      bridge: Add extack warning when enabling STP in netns.
      Revert "tcp: avoid the lookup process failing to get sk in ehash table"
      llc: Don't drop packet from non-root netns.

Luka Guzenko (1):
      ALSA: hda/realtek: Enable Mute LED on HP Laptop 15s-eq2xxx

Mario Limonciello (1):
      pinctrl: amd: Use amd_pinconf_set() for all config options

Mark Brown (2):
      regmap: Drop initial version of maximum transfer length fixes
      regmap: Account for register length in SMBus I/O limits

Martin Kaiser (1):
      fbdev: imxfb: warn about invalid left/right margin

Matthieu Baerts (3):
      selftests: tc: set timeout to 15 minutes
      selftests: tc: add 'ct' action kconfig dep
      selftests: tc: add ConnTrack procfs kconfig

Matus Gajdos (1):
      ASoC: fsl_sai: Disable bit clock with transmitter

Miklos Szeredi (2):
      fuse: revalidate: don't invalidate if interrupted
      fuse: ioctl: translate ENOSYS in outarg

Mohamed Khalfella (1):
      tracing/histograms: Return an error if we fail to add histogram to hist_vars list

Nicholas Kazlauskas (1):
      drm/amd/display: Keep PHY active for DP displays on DCN31

Oswald Buddenhagen (1):
      ALSA: emu10k1: roll up loops in DSP setup code for Audigy

Pablo Neira Ayuso (2):
      netfilter: nf_tables: skip bound chain in netns release path
      netfilter: nf_tables: skip bound chain on rule flush

Petr Pavlu (1):
      keys: Fix linking a duplicate key to a keyring's assoc_array

Tanmay Patil (1):
      net: ethernet: ti: cpsw_ale: Fix cpsw_ale_get_field()/cpsw_ale_set_field()

Victor Nogueira (1):
      net: sched: cls_bpf: Undo tcf_bind_filter in case of an error

Vladimir Oltean (1):
      net: phy: prevent stale pointer dereference in phy_init()

Wang Ming (1):
      net: ipv4: Use kfree_sensitive instead of kfree

Ye Bin (1):
      quota: fix warning in dqgrab()

Yogesh (1):
      fs: jfs: Fix UBSAN: array-index-out-of-bounds in dbAllocDmapLev

Yuanjun Gong (1):
      net:ipv6: check return value of pskb_trim()

YueHaibing (1):
      can: bcm: Fix UAF in bcm_proc_show()

Zhang Shurong (1):
      fbdev: au1200fb: Fix missing IRQ check in au1200fb_drv_probe

Zhang Yi (1):
      jbd2: recheck chechpointing non-dirty buffer

Zhikai Zhai (1):
      drm/amd/display: Disable MPC split by default on special asic

hackyzh002 (1):
      drm/radeon: Fix integer overflow in radeon_cs_parser_init

