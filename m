Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E5957BE172
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 15:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377284AbjJINuS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 09:50:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377240AbjJINuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 09:50:13 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C6C594;
        Mon,  9 Oct 2023 06:50:11 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50A13C433CA;
        Mon,  9 Oct 2023 13:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696859410;
        bh=dRYwhUOLNiPm+gbR1QJ2/OuqCiMwBKt8gZU58jS1ARU=;
        h=From:To:Cc:Subject:Date:From;
        b=BO1Ch1TzO12cQapH9MRPII38i6P86+kSjHYrn7dnlXfaSlnJw8W8t2/GVdWnt0RwM
         9p2sgwE71acJEl4Fr1hQ4aJDIYzJbz8GLLbWnLqPUlU6qYTCYVt6eDbi3WkfQr3/Ac
         9k5KGVp8mhaOkMk8iN/DfDP0GRuzRXDe/7SmPwyI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: [PATCH 4.19 00/91] 4.19.296-rc1 review
Date:   Mon,  9 Oct 2023 15:05:32 +0200
Message-ID: <20231009130111.518916887@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.296-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.19.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.19.296-rc1
X-KernelTest-Deadline: 2023-10-11T13:01+00:00
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

This is the start of the stable review cycle for the 4.19.296 release.
There are 91 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Wed, 11 Oct 2023 13:00:55 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.296-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.19.296-rc1

Eric Dumazet <edumazet@google.com>
    dccp: fix dccp_v4_err()/dccp_v6_err() again

John David Anglin <dave@parisc-linux.org>
    parisc: Restore __ldcw_align for PA-RISC 2.0 processors

Shay Drory <shayd@nvidia.com>
    RDMA/mlx5: Fix NULL string error

Leon Romanovsky <leonro@nvidia.com>
    RDMA/cma: Fix truncation compilation warning in make_cma_ports

Duje Mihanović <duje.mihanovic@skole.hr>
    gpio: pxa: disable pinctrl calls for MMP_GPIO

Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
    gpio: aspeed: fix the GPIO number passed to pinctrl_gpio_set_config()

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    IB/mlx4: Fix the size of a buffer in add_port_entries()

Ivan Babrou <ivan@cloudflare.com>
    cpupower: add Makefile dependencies for install targets

Xin Long <lucien.xin@gmail.com>
    sctp: update hb timer immediately after users change hb_interval

Xin Long <lucien.xin@gmail.com>
    sctp: update transport state when processing a dupcook packet

Neal Cardwell <ncardwell@google.com>
    tcp: fix delayed ACKs for MSS boundary condition

Neal Cardwell <ncardwell@google.com>
    tcp: fix quick-ack counting to count actual ACKs of new data

Ben Wolsieffer <ben.wolsieffer@hefring.com>
    net: stmmac: dwmac-stm32: fix resume on STM32 MCU

Shigeru Yoshida <syoshida@redhat.com>
    net: usb: smsc75xx: Fix uninit-value access in __smsc75xx_read_reg

David Howells <dhowells@redhat.com>
    ipv4, ipv6: Fix handling of transhdrlen in __ip{,6}_append_data()

Mauricio Faria de Oliveira <mfo@canonical.com>
    modpost: add missing else to the "of" check

Junxiao Bi <junxiao.bi@oracle.com>
    scsi: target: core: Fix deadlock due to recursive locking

Richard Fitzgerald <rf@opensource.cirrus.com>
    regmap: rbtree: Fix wrong register marked as in-cache when creating new node

Alexandra Diupina <adiupina@astralinux.ru>
    drivers/net: process the result of hdlc_open() and add call of hdlc_close() in uhdlc_close()

Pin-yen Lin <treapking@chromium.org>
    wifi: mwifiex: Fix oob check condition in mwifiex_process_rx_packet

Zhihao Cheng <chengzhihao1@huawei.com>
    ubi: Refuse attaching if mtd's erasesize is 0

Qu Wenruo <wqu@suse.com>
    btrfs: reject unknown mount options early

Jordan Rife <jrife@google.com>
    net: replace calls to sock->ops->connect() with kernel_connect()

Gustavo A. R. Silva <gustavoars@kernel.org>
    wifi: mwifiex: Fix tlv_buf_left calculation

Gustavo A. R. Silva <gustavoars@kernel.org>
    qed/red_ll2: Fix undefined behavior bug in struct qed_ll2_info

Dinghao Liu <dinghao.liu@zju.edu.cn>
    scsi: zfcp: Fix a double put in zfcp_port_enqueue()

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Revert "PCI: qcom: Disable write access to read only registers for IP v2.3.3"

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    media: dvb: symbol fixup for dvb_attach() - again

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Revert "drivers core: Use sysfs_emit and sysfs_emit_at for show(device *...) functions"

Niklas Cassel <niklas.cassel@wdc.com>
    ata: libata: disallow dev-initiated LPM transitions to unsupported states

Shida Zhang <zhangshida@kylinos.cn>
    ext4: fix rec_len verify error

Greg Ungerer <gerg@kernel.org>
    fs: binfmt_elf_efpic: fix personality for ELF-FDPIC

Matthias Schiffer <mschiffer@universe-factory.net>
    ata: libata-sata: increase PMP SRST timeout to 10s

Damien Le Moal <dlemoal@kernel.org>
    ata: libata-core: Do not register PM operations for SAS ports

Damien Le Moal <dlemoal@kernel.org>
    ata: libata-core: Fix port and device removal

Damien Le Moal <dlemoal@kernel.org>
    ata: libata-core: Fix ata_port_request_pm() locking

Mika Westerberg <mika.westerberg@linux.intel.com>
    net: thunderbolt: Fix TCPv6 GSO checksum calculation

Josef Bacik <josef@toxicpanda.com>
    btrfs: properly report 0 avail for very full file systems

Heiner Kallweit <hkallweit1@gmail.com>
    i2c: i801: unregister tco_pdev in i801_probe() error path

Niklas Cassel <niklas.cassel@wdc.com>
    ata: libata-scsi: ignore reserved bits for REPORT SUPPORTED OPERATION CODES

Kailang Yang <kailang@realtek.com>
    ALSA: hda: Disable power save for solving pop issue on Lenovo ThinkCentre M70q

Pan Bian <bianpan2016@163.com>
    nilfs2: fix potential use after free in nilfs_gccache_submit_read_data()

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    serial: 8250_port: Check IRQ data before use

Roberto Sassu <roberto.sassu@huawei.com>
    smack: Record transmuting in smk_transmuted

Roberto Sassu <roberto.sassu@huawei.com>
    smack: Retrieve transmuting information in smack_inode_getsecurity()

Vishal Goel <vishal.goel@samsung.com>
    Smack:- Use overlay inode label in smack_inode_copy_up()

Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
    scsi: megaraid_sas: Enable msix_load_balance for Invader and later controllers

Felix Riemann <felix.riemann@sma.de>
    net: Fix unwanted sign extension in netdev_stats_to_stats64()

Mika Westerberg <mika.westerberg@linux.intel.com>
    watchdog: iTCO_wdt: Set NO_REBOOT if the watchdog is not already running

Mika Westerberg <mika.westerberg@linux.intel.com>
    watchdog: iTCO_wdt: No need to stop the timer in probe

Pratyush Yadav <ptyadav@amazon.de>
    nvme-pci: do not set the NUMA node of device if it has none

Thomas Zimmermann <tzimmermann@suse.de>
    fbdev/sh7760fb: Depend on FB=y

Stanislav Fomichev <sdf@google.com>
    bpf: Clarify error expectations from bpf_clone_redirect

Niklas Cassel <niklas.cassel@wdc.com>
    ata: libata-eh: do not clear ATA_PFLAG_EH_PENDING in ata_eh_reset()

Zheng Yejian <zhengyejian1@huawei.com>
    ring-buffer: Avoid softlockup in ring_buffer_resize()

Zheng Yejian <zhengyejian1@huawei.com>
    selftests/ftrace: Correctly enable event in instance-event.tc

Helge Deller <deller@gmx.de>
    parisc: irq: Make irq_stack_union static to avoid sparse warning

Helge Deller <deller@gmx.de>
    parisc: drivers: Fix sparse warning

Helge Deller <deller@gmx.de>
    parisc: iosapic.c: Fix sparse warnings

Helge Deller <deller@gmx.de>
    parisc: sba: Fix compile warning wrt list of SBA devices

Wenhua Lin <Wenhua.Lin@unisoc.com>
    gpio: pmic-eic-sprd: Add can_sleep flag for PMIC EIC chip

Tony Lindgren <tony@atomide.com>
    ARM: dts: ti: omap: motorola-mapphone: Fix abe_clkctrl warning on boot

Timo Alho <talho@nvidia.com>
    clk: tegra: fix error return case for recalc_rate

Christoph Hellwig <hch@lst.de>
    MIPS: Alchemy: only build mmc support helpers if au1xmmc is enabled

Jan Kara <jack@suse.cz>
    ext4: do not let fstrim block system suspend

Jan Kara <jack@suse.cz>
    ext4: move setting of trimmed bit into ext4_try_to_trim_range()

Kemeng Shi <shikemeng@huaweicloud.com>
    ext4: replace the traditional ternary conditional operator with with max()/min()

Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
    ext4: mark group as trimmed only if it was fully scanned

Lukas Czerner <lczerner@redhat.com>
    ext4: change s_last_trim_minblks type to unsigned long

Lukas Bulwahn <lukas.bulwahn@gmail.com>
    ext4: scope ret locally in ext4_try_to_trim_range()

Wang Jianchao <wangjianchao@kuaishou.com>
    ext4: add new helper interface ext4_try_to_trim_range()

Wang Jianchao <wangjianchao@kuaishou.com>
    ext4: remove the 'group' parameter of ext4_trim_extent

Junxiao Bi <junxiao.bi@oracle.com>
    scsi: megaraid_sas: Fix deadlock on firmware crashdump

Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
    scsi: megaraid_sas: Load balance completions across all MSI-X

Manish Rangankar <mrangankar@marvell.com>
    scsi: qla2xxx: Remove unsupported ql2xenabledif option

Martin K. Petersen <martin.petersen@oracle.com>
    scsi: qla2xxx: Add protection mask module parameters

Werner Sembach <wse@tuxedocomputers.com>
    Input: i8042 - add quirk for TUXEDO Gemini 17 Gen1/Clevo PD70PN

Xiaoke Wang <xkernel.wang@foxmail.com>
    i2c: mux: demux-pinctrl: check the return value of devm_kstrdup()

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    gpio: tb10x: Fix an error handling path in tb10x_gpio_probe()

Ziyang Xuan <william.xuanziyang@huawei.com>
    team: fix null-ptr-deref when team device type is changed

Eric Dumazet <edumazet@google.com>
    net: bridge: use DEV_STATS_INC()

Eric Dumazet <edumazet@google.com>
    net: add atomic_long_t to net_device_stats fields

Jie Wang <wangjie125@huawei.com>
    net: hns3: add 5ms delay before clear firmware reset irq source

Kajol Jain <kjain@linux.ibm.com>
    powerpc/perf/hv-24x7: Update domain value check

Kyle Zeng <zengyhkyle@gmail.com>
    ipv4: fix null-deref in ipv4_link_failure

Sabrina Dubroca <sd@queasysnail.net>
    selftests: tls: swap the TX and RX sockets in some tests

Kees Cook <keescook@chromium.org>
    selftests/tls: Add {} to avoid static checker warning

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: disallow element removal on anonymous sets

Szuying Chen <chensiying21@gmail.com>
    ata: libahci: clear pending interrupt status

Hannes Reinecke <hare@suse.de>
    ata: ahci: Drop pointless VPRINTK() calls and convert the remaining ones

Trond Myklebust <trond.myklebust@hammerspace.com>
    NFS/pNFS: Report EINVAL errors from connect() to the server


-------------

Diffstat:

 Makefile                                           |   4 +-
 arch/arm/boot/dts/omap4-droid4-xt894.dts           |   4 +-
 arch/mips/alchemy/devboards/db1000.c               |   4 +
 arch/mips/alchemy/devboards/db1200.c               |   6 +
 arch/mips/alchemy/devboards/db1300.c               |   4 +
 arch/parisc/include/asm/ldcw.h                     |  36 +++---
 arch/parisc/include/asm/ropes.h                    |   3 +
 arch/parisc/include/asm/spinlock_types.h           |   5 -
 arch/parisc/kernel/drivers.c                       |   2 +-
 arch/parisc/kernel/irq.c                           |   2 +-
 arch/powerpc/perf/hv-24x7.c                        |   2 +-
 drivers/ata/ahci.c                                 |  13 +-
 drivers/ata/ahci_xgene.c                           |   4 -
 drivers/ata/libahci.c                              |  49 ++++----
 drivers/ata/libata-core.c                          |  60 ++++++---
 drivers/ata/libata-eh.c                            |  13 +-
 drivers/ata/libata-scsi.c                          |   2 +-
 drivers/ata/libata-transport.c                     |   9 +-
 drivers/ata/libata.h                               |   2 +
 drivers/base/arch_topology.c                       |   2 +-
 drivers/base/cacheinfo.c                           |  18 +--
 drivers/base/core.c                                |   8 +-
 drivers/base/cpu.c                                 |  34 ++---
 drivers/base/firmware_loader/fallback.c            |   2 +-
 drivers/base/memory.c                              |  24 ++--
 drivers/base/node.c                                |  34 ++---
 drivers/base/platform.c                            |   2 +-
 drivers/base/power/sysfs.c                         |  50 ++++----
 drivers/base/regmap/regcache-rbtree.c              |   3 +-
 drivers/base/soc.c                                 |   8 +-
 drivers/char/agp/parisc-agp.c                      |   2 -
 drivers/clk/tegra/clk-bpmp.c                       |   2 +-
 drivers/gpio/gpio-aspeed.c                         |   2 +-
 drivers/gpio/gpio-pmic-eic-sprd.c                  |   1 +
 drivers/gpio/gpio-pxa.c                            |   1 +
 drivers/gpio/gpio-tb10x.c                          |   6 +-
 drivers/i2c/busses/i2c-i801.c                      |   1 +
 drivers/i2c/muxes/i2c-demux-pinctrl.c              |   4 +
 drivers/infiniband/core/cma_configfs.c             |   2 +-
 drivers/infiniband/hw/mlx4/sysfs.c                 |   2 +-
 drivers/infiniband/hw/mlx5/main.c                  |   2 +-
 drivers/input/serio/i8042-x86ia64io.h              |   7 ++
 drivers/media/dvb-frontends/sp8870.c               |   2 +-
 drivers/media/tuners/tuner-xc2028.c                |   2 +-
 drivers/mtd/ubi/build.c                            |   7 ++
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    |   5 +
 drivers/net/ethernet/qlogic/qed/qed_ll2.h          |   2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c  |   7 +-
 drivers/net/team/team.c                            |  10 +-
 drivers/net/thunderbolt.c                          |   3 +-
 drivers/net/usb/smsc75xx.c                         |   4 +-
 drivers/net/wan/fsl_ucc_hdlc.c                     |  12 +-
 .../net/wireless/marvell/mwifiex/11n_rxreorder.c   |   4 +-
 drivers/net/wireless/marvell/mwifiex/sta_rx.c      |  16 +--
 drivers/nvme/host/pci.c                            |   2 -
 drivers/parisc/iosapic.c                           |   4 +-
 drivers/parisc/iosapic_private.h                   |   4 +-
 drivers/pci/controller/dwc/pcie-qcom.c             |   2 -
 drivers/s390/scsi/zfcp_aux.c                       |   9 +-
 drivers/scsi/megaraid/megaraid_sas.h               |   5 +-
 drivers/scsi/megaraid/megaraid_sas_base.c          |  44 ++++---
 drivers/scsi/megaraid/megaraid_sas_fusion.c        |  18 ++-
 drivers/scsi/qla2xxx/qla_attr.c                    |   2 -
 drivers/scsi/qla2xxx/qla_dbg.c                     |   2 +-
 drivers/scsi/qla2xxx/qla_os.c                      |  45 +++++--
 drivers/target/target_core_device.c                |  11 +-
 drivers/tty/serial/8250/8250_port.c                |   5 +-
 drivers/video/fbdev/Kconfig                        |   2 +-
 drivers/watchdog/iTCO_wdt.c                        |  26 +++-
 fs/binfmt_elf_fdpic.c                              |   5 +-
 fs/btrfs/super.c                                   |   6 +-
 fs/ext4/ext4.h                                     |   2 +-
 fs/ext4/mballoc.c                                  | 138 ++++++++++++---------
 fs/ext4/namei.c                                    |  26 ++--
 fs/nfs/flexfilelayout/flexfilelayout.c             |   1 +
 fs/nilfs2/gcinode.c                                |   6 +-
 include/linux/if_team.h                            |   2 +
 include/linux/libata.h                             |   6 +-
 include/linux/netdevice.h                          |  58 +++++----
 include/net/dst.h                                  |   5 +-
 include/net/tcp.h                                  |   6 +-
 include/uapi/linux/bpf.h                           |   4 +-
 kernel/trace/ring_buffer.c                         |   2 +
 net/bridge/br_forward.c                            |   4 +-
 net/bridge/br_input.c                              |   4 +-
 net/core/dev.c                                     |  14 +--
 net/dccp/ipv4.c                                    |   9 +-
 net/dccp/ipv6.c                                    |   9 +-
 net/ipv4/route.c                                   |   4 +-
 net/ipv4/tcp_input.c                               |  13 ++
 net/ipv4/tcp_output.c                              |   7 +-
 net/l2tp/l2tp_ip6.c                                |   2 +-
 net/netfilter/ipvs/ip_vs_sync.c                    |   4 +-
 net/netfilter/nf_tables_api.c                      |   9 +-
 net/rds/tcp_connect.c                              |   2 +-
 net/sctp/associola.c                               |   3 +-
 net/sctp/socket.c                                  |   1 +
 scripts/mod/file2alias.c                           |   2 +-
 security/smack/smack.h                             |   1 +
 security/smack/smack_lsm.c                         |  65 +++++++---
 sound/pci/hda/hda_intel.c                          |   1 +
 tools/include/uapi/linux/bpf.h                     |   4 +-
 tools/power/cpupower/Makefile                      |   8 +-
 tools/power/cpupower/bench/Makefile                |   2 +-
 .../ftrace/test.d/instances/instance-event.tc      |   2 +-
 tools/testing/selftests/net/tls.c                  |  11 +-
 106 files changed, 700 insertions(+), 444 deletions(-)


