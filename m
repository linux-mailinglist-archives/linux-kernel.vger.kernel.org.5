Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3221761358
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 13:10:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234179AbjGYLKB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 07:10:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234055AbjGYLJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 07:09:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6EF13C3E;
        Tue, 25 Jul 2023 04:08:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D3EB861656;
        Tue, 25 Jul 2023 11:08:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA406C433C8;
        Tue, 25 Jul 2023 11:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690283314;
        bh=2fQVp461ypDWLyRE+NIiT2HVhFOY5yfR5C9VS//PZT8=;
        h=From:To:Cc:Subject:Date:From;
        b=jHs9Y3r6vThwInJee7uvekJA7L+rSiAubk5wNBtMFctrO8jQ68HldSE++WvnNzQ/h
         TMNp0HRymNszyLbTQMy9NK99y1dKJgUkMRpQC/9bsPHnIr1+rJYfMaqRZMK5Rhw+uk
         t42OY38EGp6yopaE/LYGbNJRXuOTcbiBNmBtK/CA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: [PATCH 5.15 00/78] 5.15.123-rc1 review
Date:   Tue, 25 Jul 2023 12:45:51 +0200
Message-ID: <20230725104451.275227789@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.123-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.15.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.15.123-rc1
X-KernelTest-Deadline: 2023-07-27T10:44+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 5.15.123 release.
There are 78 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Thu, 27 Jul 2023 10:44:26 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.123-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 5.15.123-rc1

Arnd Bergmann <arnd@arndb.de>
    nixge: fix mac address error handling again

Mohamed Khalfella <mkhalfella@purestorage.com>
    tracing/histograms: Return an error if we fail to add histogram to hist_vars list

Zhang Yi <yi.zhang@huawei.com>
    jbd2: recheck chechpointing non-dirty buffer

Vladimir Oltean <vladimir.oltean@nxp.com>
    net: phy: prevent stale pointer dereference in phy_init()

Eric Dumazet <edumazet@google.com>
    tcp: annotate data-races around fastopenq.max_qlen

Eric Dumazet <edumazet@google.com>
    tcp: annotate data-races around icsk->icsk_user_timeout

Eric Dumazet <edumazet@google.com>
    tcp: annotate data-races around tp->notsent_lowat

Eric Dumazet <edumazet@google.com>
    tcp: annotate data-races around rskq_defer_accept

Eric Dumazet <edumazet@google.com>
    tcp: annotate data-races around tp->linger2

Eric Dumazet <edumazet@google.com>
    tcp: annotate data-races around icsk->icsk_syn_retries

Eric Dumazet <edumazet@google.com>
    tcp: annotate data-races around tp->keepalive_probes

Eric Dumazet <edumazet@google.com>
    tcp: annotate data-races around tp->keepalive_intvl

Eric Dumazet <edumazet@google.com>
    tcp: annotate data-races around tp->keepalive_time

Eric Dumazet <edumazet@google.com>
    tcp: annotate data-races around tp->tcp_tx_delay

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: skip bound chain on rule flush

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: skip bound chain in netns release path

Florian Westphal <fw@strlen.de>
    netfilter: nft_set_pipapo: fix improper element removal

Florian Westphal <fw@strlen.de>
    netfilter: nf_tables: fix spurious set element insertion failure

Kuniyuki Iwashima <kuniyu@amazon.com>
    llc: Don't drop packet from non-root netns.

Zhang Shurong <zhang_shurong@foxmail.com>
    fbdev: au1200fb: Fix missing IRQ check in au1200fb_drv_probe

Kuniyuki Iwashima <kuniyu@amazon.com>
    Revert "tcp: avoid the lookup process failing to get sk in ehash table"

Yuanjun Gong <ruc_gongyuanjun@163.com>
    net:ipv6: check return value of pskb_trim()

Wang Ming <machel@vivo.com>
    net: ipv4: Use kfree_sensitive instead of kfree

Eric Dumazet <edumazet@google.com>
    tcp: annotate data-races around tcp_rsk(req)->ts_recent

Florian Kauer <florian.kauer@linutronix.de>
    igc: Prevent garbled TX queue with XDP ZEROCOPY

Kumar Kartikeya Dwivedi <memxor@gmail.com>
    bpf: Fix subprog idx logic in check_max_stack_depth

Geetha sowjanya <gakula@marvell.com>
    octeontx2-pf: Dont allocate BPIDs for LBK interfaces

Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
    security: keys: Modify mismatched function name

Ding Hui <dinghui@sangfor.com.cn>
    iavf: Fix out-of-bounds when setting channels on remove

Ding Hui <dinghui@sangfor.com.cn>
    iavf: Fix use-after-free in free_netdev

Victor Nogueira <victor@mojatatu.com>
    net: sched: cls_bpf: Undo tcf_bind_filter in case of an error

Daniel Golle <daniel@makrotopia.org>
    net: ethernet: mtk_eth_soc: handle probe deferral

Jakub Kicinski <kuba@kernel.org>
    ethernet: use of_get_ethdev_address()

Jakub Kicinski <kuba@kernel.org>
    of: net: add a helper for loading netdev->dev_addr

Jakub Kicinski <kuba@kernel.org>
    ethernet: use eth_hw_addr_set() instead of ether_addr_copy()

Kuniyuki Iwashima <kuniyu@amazon.com>
    bridge: Add extack warning when enabling STP in netns.

Tanmay Patil <t-patil@ti.com>
    net: ethernet: ti: cpsw_ale: Fix cpsw_ale_get_field()/cpsw_ale_set_field()

Mario Limonciello <mario.limonciello@amd.com>
    pinctrl: amd: Use amd_pinconf_set() for all config options

James Clark <james.clark@arm.com>
    perf build: Fix library not found error when using CSLIBS

Martin Kaiser <martin@kaiser.cx>
    fbdev: imxfb: warn about invalid left/right margin

Jonas Gorski <jonas.gorski@gmail.com>
    spi: bcm63xx: fix max prepend length

Immad Mir <mirimmad17@gmail.com>
    FS: JFS: Check for read-only mounted filesystem in txBegin

Immad Mir <mirimmad17@gmail.com>
    FS: JFS: Fix null-ptr-deref Read in txBegin

Gustavo A. R. Silva <gustavoars@kernel.org>
    MIPS: dec: prom: Address -Warray-bounds warning

Yogesh <yogi.kernel@gmail.com>
    fs: jfs: Fix UBSAN: array-index-out-of-bounds in dbAllocDmapLev

Jan Kara <jack@suse.cz>
    udf: Fix uninitialized array access for some pathnames

Ye Bin <yebin10@huawei.com>
    quota: fix warning in dqgrab()

Jan Kara <jack@suse.cz>
    quota: Properly disable quotas when add_dquot_ref() fails

Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
    ALSA: emu10k1: roll up loops in DSP setup code for Audigy

hackyzh002 <hackyzh002@gmail.com>
    drm/radeon: Fix integer overflow in radeon_cs_parser_init

Eric Whitney <enwlinux@gmail.com>
    ext4: correct inline offset when handling xattrs in inode body

Johan Hovold <johan+linaro@kernel.org>
    ASoC: codecs: wcd938x: fix soundwire initialisation race

Johan Hovold <johan+linaro@kernel.org>
    ASoC: codecs: wcd938x: fix codec initialisation race

Johan Hovold <johan+linaro@kernel.org>
    ASoC: codecs: wcd934x: fix resource leaks on component remove

Johan Hovold <johan+linaro@kernel.org>
    ASoC: codecs: wcd938x: fix missing mbhc init error handling

Johan Hovold <johan+linaro@kernel.org>
    ASoC: codecs: wcd938x: fix resource leaks on component remove

Johan Hovold <johan+linaro@kernel.org>
    ASoC: codecs: wcd-mbhc-v2: fix resource leaks on component remove

Johan Hovold <johan+linaro@kernel.org>
    ASoC: codecs: wcd938x: fix missing clsh ctrl error handling

Matus Gajdos <matuszpd@gmail.com>
    ASoC: fsl_sai: Disable bit clock with transmitter

Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
    drm/amd/display: Keep PHY active for DP displays on DCN31

Zhikai Zhai <zhikai.zhai@amd.com>
    drm/amd/display: Disable MPC split by default on special asic

Jocelyn Falempe <jfalempe@redhat.com>
    drm/client: Fix memory leak in drm_client_modeset_probe

Jocelyn Falempe <jfalempe@redhat.com>
    drm/client: Fix memory leak in drm_client_target_cloned

Matthieu Baerts <matthieu.baerts@tessares.net>
    selftests: tc: add ConnTrack procfs kconfig

YueHaibing <yuehaibing@huawei.com>
    can: bcm: Fix UAF in bcm_proc_show()

Mark Brown <broonie@kernel.org>
    regmap: Account for register length in SMBus I/O limits

Mark Brown <broonie@kernel.org>
    regmap: Drop initial version of maximum transfer length fixes

Matthieu Baerts <matthieu.baerts@tessares.net>
    selftests: tc: add 'ct' action kconfig dep

Matthieu Baerts <matthieu.baerts@tessares.net>
    selftests: tc: set timeout to 15 minutes

Miklos Szeredi <mszeredi@redhat.com>
    fuse: ioctl: translate ENOSYS in outarg

Filipe Manana <fdmanana@suse.com>
    btrfs: zoned: fix memory leak after finding block group with super blocks

Miklos Szeredi <mszeredi@redhat.com>
    fuse: revalidate: don't invalidate if interrupted

Filipe Manana <fdmanana@suse.com>
    btrfs: fix warning when putting transaction with qgroups enabled after abort

Georg Müller <georgmueller@gmx.net>
    perf probe: Add test for regression introduced by switch to die_get_decl_file()

Petr Pavlu <petr.pavlu@suse.com>
    keys: Fix linking a duplicate key to a keyring's assoc_array

Luka Guzenko <l.guzenko@web.de>
    ALSA: hda/realtek: Enable Mute LED on HP Laptop 15s-eq2xxx

Christoffer Sandberg <cs@tuxedo.de>
    ALSA: hda/realtek: Add quirk for Clevo NS70AU

Kailang Yang <kailang@realtek.com>
    ALSA: hda/realtek - remove 3k pull low procedure


-------------

Diffstat:

 Makefile                                           |   4 +-
 arch/mips/include/asm/dec/prom.h                   |   2 +-
 drivers/base/regmap/regmap-i2c.c                   |   8 +-
 drivers/base/regmap/regmap-spi-avmm.c              |   2 +-
 drivers/base/regmap/regmap.c                       |   6 +-
 .../amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c   |   5 +
 .../drm/amd/display/dc/dcn303/dcn303_resource.c    |   2 +-
 drivers/gpu/drm/drm_client_modeset.c               |   6 ++
 drivers/gpu/drm/radeon/radeon_cs.c                 |   3 +-
 drivers/net/ethernet/agere/et131x.c                |   4 +-
 drivers/net/ethernet/alacritech/slicoss.c          |   2 +-
 drivers/net/ethernet/allwinner/sun4i-emac.c        |   2 +-
 drivers/net/ethernet/altera/altera_tse_main.c      |   2 +-
 drivers/net/ethernet/amazon/ena/ena_netdev.c       |   2 +-
 drivers/net/ethernet/aquantia/atlantic/aq_nic.c    |   2 +-
 drivers/net/ethernet/arc/emac_main.c               |   2 +-
 drivers/net/ethernet/atheros/ag71xx.c              |   2 +-
 drivers/net/ethernet/broadcom/bcm4908_enet.c       |   2 +-
 drivers/net/ethernet/broadcom/bcmsysport.c         |   2 +-
 drivers/net/ethernet/broadcom/bgmac-bcma.c         |   4 +-
 drivers/net/ethernet/broadcom/bgmac-platform.c     |   2 +-
 drivers/net/ethernet/broadcom/bgmac.c              |   2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_vfr.c      |   2 +-
 drivers/net/ethernet/broadcom/genet/bcmgenet.c     |   4 +-
 drivers/net/ethernet/brocade/bna/bnad.c            |   4 +-
 drivers/net/ethernet/cadence/macb_main.c           |   2 +-
 drivers/net/ethernet/cavium/liquidio/lio_core.c    |   2 +-
 drivers/net/ethernet/cavium/liquidio/lio_main.c    |   2 +-
 drivers/net/ethernet/cavium/liquidio/lio_vf_main.c |   2 +-
 drivers/net/ethernet/cavium/octeon/octeon_mgmt.c   |   2 +-
 drivers/net/ethernet/cavium/thunder/nicvf_main.c   |   3 +-
 drivers/net/ethernet/emulex/benet/be_main.c        |   2 +-
 drivers/net/ethernet/ethoc.c                       |   4 +-
 drivers/net/ethernet/ezchip/nps_enet.c             |   4 +-
 drivers/net/ethernet/faraday/ftgmac100.c           |   4 +-
 drivers/net/ethernet/freescale/fec_mpc52xx.c       |   2 +-
 .../net/ethernet/freescale/fs_enet/fs_enet-main.c  |   2 +-
 drivers/net/ethernet/freescale/gianfar.c           |   2 +-
 drivers/net/ethernet/freescale/ucc_geth.c          |   2 +-
 drivers/net/ethernet/google/gve/gve_adminq.c       |   2 +-
 drivers/net/ethernet/hisilicon/hisi_femac.c        |   2 +-
 drivers/net/ethernet/hisilicon/hix5hd2_gmac.c      |   2 +-
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c    |   4 +-
 drivers/net/ethernet/ibm/ibmveth.c                 |   2 +-
 drivers/net/ethernet/ibm/ibmvnic.c                 |   5 +-
 drivers/net/ethernet/intel/fm10k/fm10k_netdev.c    |   2 +-
 drivers/net/ethernet/intel/fm10k/fm10k_pci.c       |   4 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c        |   4 +-
 drivers/net/ethernet/intel/iavf/iavf_ethtool.c     |   2 +-
 drivers/net/ethernet/intel/iavf/iavf_main.c        |   7 +-
 drivers/net/ethernet/intel/iavf/iavf_virtchnl.c    |   4 +-
 drivers/net/ethernet/intel/ice/ice_main.c          |   4 +-
 drivers/net/ethernet/intel/igc/igc_main.c          |   4 +-
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c  |   6 +-
 drivers/net/ethernet/korina.c                      |   4 +-
 drivers/net/ethernet/lantiq_xrx200.c               |   2 +-
 drivers/net/ethernet/litex/litex_liteeth.c         |   2 +-
 drivers/net/ethernet/marvell/mvneta.c              |   2 +-
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c    |   4 +-
 drivers/net/ethernet/marvell/mvpp2/mvpp2_prs.c     |   2 +-
 .../ethernet/marvell/octeontx2/nic/otx2_common.c   |   2 +-
 .../net/ethernet/marvell/octeontx2/nic/otx2_pf.c   |   5 +-
 .../net/ethernet/marvell/prestera/prestera_main.c  |   2 +-
 drivers/net/ethernet/marvell/pxa168_eth.c          |   2 +-
 drivers/net/ethernet/marvell/sky2.c                |   2 +-
 drivers/net/ethernet/mediatek/mtk_eth_soc.c        |  29 ++----
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c  |   2 +-
 .../ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c |   2 +-
 drivers/net/ethernet/micrel/ks8851_common.c        |   2 +-
 drivers/net/ethernet/microchip/enc28j60.c          |   4 +-
 drivers/net/ethernet/microchip/lan743x_main.c      |   4 +-
 .../net/ethernet/microchip/sparx5/sparx5_netdev.c  |   2 +-
 drivers/net/ethernet/microsoft/mana/mana_en.c      |   2 +-
 drivers/net/ethernet/mscc/ocelot_net.c             |   2 +-
 drivers/net/ethernet/netronome/nfp/abm/main.c      |   2 +-
 drivers/net/ethernet/netronome/nfp/nfp_net_main.c  |   2 +-
 .../net/ethernet/netronome/nfp/nfp_netvf_main.c    |   2 +-
 drivers/net/ethernet/ni/nixge.c                    |   6 +-
 drivers/net/ethernet/nxp/lpc_eth.c                 |   2 +-
 drivers/net/ethernet/qlogic/qede/qede_filter.c     |   4 +-
 drivers/net/ethernet/qlogic/qede/qede_main.c       |   2 +-
 drivers/net/ethernet/qualcomm/emac/emac.c          |   2 +-
 drivers/net/ethernet/qualcomm/qca_spi.c            |   2 +-
 drivers/net/ethernet/qualcomm/qca_uart.c           |   2 +-
 drivers/net/ethernet/renesas/ravb_main.c           |   2 +-
 .../net/ethernet/samsung/sxgbe/sxgbe_platform.c    |   2 +-
 drivers/net/ethernet/sfc/ef10_sriov.c              |   2 +-
 drivers/net/ethernet/sfc/efx.c                     |   2 +-
 drivers/net/ethernet/sfc/efx_common.c              |   4 +-
 drivers/net/ethernet/sfc/falcon/efx.c              |   6 +-
 drivers/net/ethernet/socionext/netsec.c            |   2 +-
 drivers/net/ethernet/socionext/sni_ave.c           |   2 +-
 drivers/net/ethernet/ti/am65-cpsw-nuss.c           |   2 +-
 drivers/net/ethernet/ti/cpsw_ale.c                 |  24 ++++-
 drivers/net/ethernet/ti/cpsw_new.c                 |   4 +-
 drivers/net/ethernet/ti/davinci_emac.c             |   2 +-
 drivers/net/ethernet/ti/netcp_core.c               |   4 +-
 drivers/net/ethernet/xilinx/xilinx_emaclite.c      |   2 +-
 drivers/net/phy/phy_device.c                       |  21 ++--
 drivers/pinctrl/pinctrl-amd.c                      |  28 +++---
 drivers/spi/spi-bcm63xx.c                          |   2 +-
 drivers/video/fbdev/au1200fb.c                     |   3 +
 drivers/video/fbdev/imxfb.c                        |   4 +-
 fs/btrfs/block-group.c                             |   1 +
 fs/btrfs/qgroup.c                                  |   1 +
 fs/ext4/xattr.c                                    |  14 +++
 fs/fuse/dir.c                                      |   2 +-
 fs/fuse/ioctl.c                                    |  21 ++--
 fs/jbd2/checkpoint.c                               | 102 ++++++-------------
 fs/jfs/jfs_dmap.c                                  |   3 +
 fs/jfs/jfs_txnmgr.c                                |   5 +
 fs/jfs/namei.c                                     |   5 +
 fs/quota/dquot.c                                   |   5 +-
 fs/udf/unicode.c                                   |   2 +-
 include/linux/etherdevice.h                        |   2 +-
 include/linux/of_net.h                             |   6 ++
 include/linux/tcp.h                                |   2 +-
 include/net/tcp.h                                  |  31 ++++--
 kernel/bpf/verifier.c                              |  11 +-
 kernel/trace/trace_events_hist.c                   |   3 +-
 net/bridge/br_stp_if.c                             |   3 +
 net/can/bcm.c                                      |  12 +--
 net/core/of_net.c                                  |  25 +++++
 net/ipv4/esp4.c                                    |   2 +-
 net/ipv4/inet_connection_sock.c                    |   2 +-
 net/ipv4/inet_hashtables.c                         |  17 +---
 net/ipv4/inet_timewait_sock.c                      |   8 +-
 net/ipv4/tcp.c                                     |  53 +++++-----
 net/ipv4/tcp_fastopen.c                            |   6 +-
 net/ipv4/tcp_ipv4.c                                |   2 +-
 net/ipv4/tcp_minisocks.c                           |   9 +-
 net/ipv4/tcp_output.c                              |   2 +-
 net/ipv6/ip6_gre.c                                 |   3 +-
 net/ipv6/tcp_ipv6.c                                |   2 +-
 net/llc/llc_input.c                                |   3 -
 net/netfilter/nf_tables_api.c                      |   8 ++
 net/netfilter/nft_set_pipapo.c                     |   6 +-
 net/sched/cls_bpf.c                                |  99 +++++++++---------
 security/keys/request_key.c                        |  35 +++++--
 security/keys/trusted-keys/trusted_tpm2.c          |   2 +-
 sound/pci/emu10k1/emufx.c                          | 112 ++-------------------
 sound/pci/hda/patch_realtek.c                      |  29 +++++-
 sound/soc/codecs/wcd-mbhc-v2.c                     |  57 ++++++++---
 sound/soc/codecs/wcd934x.c                         |  12 +++
 sound/soc/codecs/wcd938x.c                         |  76 ++++++++++++--
 sound/soc/fsl/fsl_sai.c                            |   2 +-
 sound/soc/fsl/fsl_sai.h                            |   1 +
 tools/perf/Makefile.config                         |   4 +-
 .../tests/shell/test_uprobe_from_different_cu.sh   |  77 ++++++++++++++
 tools/testing/selftests/tc-testing/config          |   2 +
 tools/testing/selftests/tc-testing/settings        |   1 +
 151 files changed, 735 insertions(+), 542 deletions(-)


