Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10D0B7BDF50
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 15:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376925AbjJIN2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 09:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376806AbjJIN2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 09:28:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B70499;
        Mon,  9 Oct 2023 06:28:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E73BC433C7;
        Mon,  9 Oct 2023 13:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696858115;
        bh=g2R40YPZTGGxgPaVZw5plKGjGS6g+NUEI0z8dMzMXLQ=;
        h=From:To:Cc:Subject:Date:From;
        b=RjZDwcLAP13NS8Fop7Jwn8d9H+fNFV5PxLhhe/V+UBGCt0RdHSFxxHs4vrW+NCuFL
         mIsAECY3WLKMC8VMpaB8Z1HZqI1Cp5Pnc167boteH/apDs0ihVygLkUP36ZRGWqprm
         /jBlpRVJrBzg4pjrIL4yvLQ5QVZjIAMVB8I+WRjU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: [PATCH 5.4 000/131] 5.4.258-rc1 review
Date:   Mon,  9 Oct 2023 15:00:40 +0200
Message-ID: <20231009130116.329529591@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.258-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.4.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.4.258-rc1
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

This is the start of the stable review cycle for the 5.4.258 release.
There are 131 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Wed, 11 Oct 2023 13:00:55 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.258-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 5.4.258-rc1

Arnd Bergmann <arnd@arndb.de>
    ima: rework CONFIG_IMA dependency block

Trond Myklebust <trond.myklebust@hammerspace.com>
    NFS: Fix a race in __nfs_list_for_each_server()

John David Anglin <dave@parisc-linux.org>
    parisc: Restore __ldcw_align for PA-RISC 2.0 processors

Shay Drory <shayd@nvidia.com>
    RDMA/mlx5: Fix NULL string error

Bernard Metzler <bmt@zurich.ibm.com>
    RDMA/siw: Fix connection failure handling

Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
    RDMA/uverbs: Fix typo of sizeof argument

Leon Romanovsky <leonro@nvidia.com>
    RDMA/cma: Fix truncation compilation warning in make_cma_ports

Duje Mihanović <duje.mihanovic@skole.hr>
    gpio: pxa: disable pinctrl calls for MMP_GPIO

Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
    gpio: aspeed: fix the GPIO number passed to pinctrl_gpio_set_config()

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    IB/mlx4: Fix the size of a buffer in add_port_entries()

Leon Romanovsky <leonro@nvidia.com>
    RDMA/core: Require admin capabilities to set system parameters

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

Xin Long <lucien.xin@gmail.com>
    netfilter: handle the connecting collision properly in nf_conntrack_proto_sctp

Jeremy Cline <jeremy@jcline.org>
    net: nfc: llcp: Add lock when modifying device list

Shigeru Yoshida <syoshida@redhat.com>
    net: usb: smsc75xx: Fix uninit-value access in __smsc75xx_read_reg

Fabio Estevam <festevam@denx.de>
    net: dsa: mv88e6xxx: Avoid EEPROM timeout when EEPROM is absent

David Howells <dhowells@redhat.com>
    ipv4, ipv6: Fix handling of transhdrlen in __ip{,6}_append_data()

Eric Dumazet <edumazet@google.com>
    net: fix possible store tearing in neigh_periodic_work()

Mauricio Faria de Oliveira <mfo@canonical.com>
    modpost: add missing else to the "of" check

Trond Myklebust <trond.myklebust@hammerspace.com>
    NFSv4: Fix a nfs4_state_manager() race

Trond Myklebust <trond.myklebust@hammerspace.com>
    NFS: Add a helper nfs_client_for_each_server()

Chuck Lever <chuck.lever@oracle.com>
    NFS4: Trace state recovery operation

Junxiao Bi <junxiao.bi@oracle.com>
    scsi: target: core: Fix deadlock due to recursive locking

Oleksandr Tymoshenko <ovt@google.com>
    ima: Finish deprecation of IMA_TRUSTED_KEYRING Kconfig

Richard Fitzgerald <rf@opensource.cirrus.com>
    regmap: rbtree: Fix wrong register marked as in-cache when creating new node

Felix Fietkau <nbd@nbd.name>
    wifi: mt76: mt76x02: fix MT76x0 external LNA gain handling

Alexandra Diupina <adiupina@astralinux.ru>
    drivers/net: process the result of hdlc_open() and add call of hdlc_close() in uhdlc_close()

Pin-yen Lin <treapking@chromium.org>
    wifi: mwifiex: Fix oob check condition in mwifiex_process_rx_packet

Arnd Bergmann <arnd@arndb.de>
    wifi: iwlwifi: dbg_ini: fix structure packing

Zhihao Cheng <chengzhihao1@huawei.com>
    ubi: Refuse attaching if mtd's erasesize is 0

Jordan Rife <jrife@google.com>
    net: prevent rewrite of msg_name in sock_sendmsg()

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

Ilya Dryomov <idryomov@gmail.com>
    rbd: take header_rwsem in rbd_dev_refresh() only when updating

Ilya Dryomov <idryomov@gmail.com>
    rbd: decouple parent info read-in from updating rbd_dev

Ilya Dryomov <idryomov@gmail.com>
    rbd: decouple header read-in from updating rbd_dev->header

Ilya Dryomov <idryomov@gmail.com>
    rbd: move rbd_dev_refresh() definition

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

Steven Rostedt (Google) <rostedt@goodmis.org>
    ring-buffer: Update "shortest_full" in polling

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

Vishal Goel <vishal.goel@samsung.com>
    Smack:- Use overlay inode label in smack_inode_copy_up()

Roberto Sassu <roberto.sassu@huawei.com>
    smack: Retrieve transmuting information in smack_inode_getsecurity()

Roberto Sassu <roberto.sassu@huawei.com>
    smack: Record transmuting in smk_transmuted

Stefan Assmann <sassmann@kpanic.de>
    i40e: fix return of uninitialized aq_ret in i40e_set_vsi_promisc

Stefan Assmann <sassmann@kpanic.de>
    i40e: always propagate error value in i40e_set_vsi_promisc()

Stefan Assmann <sassmann@kpanic.de>
    i40e: improve locking of mac_filter_hash

Mika Westerberg <mika.westerberg@linux.intel.com>
    watchdog: iTCO_wdt: Set NO_REBOOT if the watchdog is not already running

Mika Westerberg <mika.westerberg@linux.intel.com>
    watchdog: iTCO_wdt: No need to stop the timer in probe

Pratyush Yadav <ptyadav@amazon.de>
    nvme-pci: do not set the NUMA node of device if it has none

Thomas Zimmermann <tzimmermann@suse.de>
    fbdev/sh7760fb: Depend on FB=y

Johnathan Mantey <johnathanx.mantey@intel.com>
    ncsi: Propagate carrier gain/loss events to the NCSI controller

Benjamin Gray <bgray@linux.ibm.com>
    powerpc/watchpoints: Annotate atomic context in more places

Stanislav Fomichev <sdf@google.com>
    bpf: Clarify error expectations from bpf_clone_redirect

Han Xu <han.xu@nxp.com>
    spi: nxp-fspi: reset the FLSHxCR1 registers

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

Max Filippov <jcmvbkbc@gmail.com>
    xtensa: boot/lib: fix function prototypes

Randy Dunlap <rdunlap@infradead.org>
    xtensa: boot: don't add include-dirs

Randy Dunlap <rdunlap@infradead.org>
    xtensa: iss/network: make functions static

Max Filippov <jcmvbkbc@gmail.com>
    xtensa: add default definition for XCHAL_HAVE_DIV32

Tony Lindgren <tony@atomide.com>
    bus: ti-sysc: Fix SYSC_QUIRK_SWSUP_SIDLE_ACT handling for uart wake-up

Tony Lindgren <tony@atomide.com>
    ARM: dts: ti: omap: motorola-mapphone: Fix abe_clkctrl warning on boot

Timo Alho <talho@nvidia.com>
    clk: tegra: fix error return case for recalc_rate

Christoph Hellwig <hch@lst.de>
    MIPS: Alchemy: only build mmc support helpers if au1xmmc is enabled

Niklas Cassel <niklas.cassel@wdc.com>
    ata: libata: disallow dev-initiated LPM transitions to unsupported states

Hamza Mahfooz <hamza.mahfooz@amd.com>
    drm/amd/display: prevent potential division by zero errors

Anthony Koo <Anthony.Koo@amd.com>
    drm/amd/display: Fix LFC multiplier changing erratically

Amanda Liu <amanda.liu@amd.com>
    drm/amd/display: Reinstate LFC optimization

Ahmad Fatoum <a.fatoum@pengutronix.de>
    clk: imx: pll14xx: dynamically configure PLL for 393216000/361267200Hz

Anson Huang <Anson.Huang@nxp.com>
    clk: imx: pll14xx: Add new frequency entries for pll1443x table

YueHaibing <yuehaibing@huawei.com>
    clk: imx: clk-pll14xx: Make two variables static

Quinn Tran <qutran@marvell.com>
    scsi: qla2xxx: Fix deletion race condition

Himanshu Madhani <hmadhani@marvell.com>
    scsi: qla2xxx: Fix update_fcport for current_topology

Werner Sembach <wse@tuxedocomputers.com>
    Input: i8042 - add quirk for TUXEDO Gemini 17 Gen1/Clevo PD70PN

Xiaoke Wang <xkernel.wang@foxmail.com>
    i2c: mux: demux-pinctrl: check the return value of devm_kstrdup()

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    gpio: tb10x: Fix an error handling path in tb10x_gpio_probe()

Jozsef Kadlecsik <kadlec@netfilter.org>
    netfilter: ipset: Fix race between IPSET_CMD_CREATE and IPSET_CMD_SWAP

Artem Chernyshev <artem.chernyshev@red-soft.ru>
    net: rds: Fix possible NULL-pointer dereference

Ziyang Xuan <william.xuanziyang@huawei.com>
    team: fix null-ptr-deref when team device type is changed

Eric Dumazet <edumazet@google.com>
    net: bridge: use DEV_STATS_INC()

Jie Wang <wangjie125@huawei.com>
    net: hns3: add 5ms delay before clear firmware reset irq source

Eric Dumazet <edumazet@google.com>
    dccp: fix dccp_v4_err()/dccp_v6_err() again

Kajol Jain <kjain@linux.ibm.com>
    powerpc/perf/hv-24x7: Update domain value check

Kyle Zeng <zengyhkyle@gmail.com>
    ipv4: fix null-deref in ipv4_link_failure

Ivan Vecera <ivecera@redhat.com>
    i40e: Fix VF VLAN offloading when port VLAN is configured

Karen Sornek <karen.sornek@intel.com>
    i40e: Fix warning message and call stack during rmmod i40e driver

Aleksandr Loktionov <aleksandr.loktionov@intel.com>
    i40e: Remove scheduling while atomic possibility

Sylwia Wnuczko <sylwia.wnuczko@intel.com>
    i40e: Fix for persistent lldp support

Shengjiu Wang <shengjiu.wang@nxp.com>
    ASoC: imx-audmix: Fix return error with devm_clk_get()

Sabrina Dubroca <sd@queasysnail.net>
    selftests: tls: swap the TX and RX sockets in some tests

Kees Cook <keescook@chromium.org>
    selftests/tls: Add {} to avoid static checker warning

Toke Høiland-Jørgensen <toke@redhat.com>
    bpf: Avoid deadlock when using queue and stack maps from NMI

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: disallow element removal on anonymous sets

Jerome Brunet <jbrunet@baylibre.com>
    ASoC: meson: spdifin: start hw on dai probe

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

Szuying Chen <chensiying21@gmail.com>
    ata: libahci: clear pending interrupt status

Steven Rostedt (Google) <rostedt@goodmis.org>
    tracing: Increase trace array ref count on enable and filter files

Trond Myklebust <trond.myklebust@hammerspace.com>
    SUNRPC: Mark the cred for revalidation if the server rejects it

Trond Myklebust <trond.myklebust@hammerspace.com>
    NFS/pNFS: Report EINVAL errors from connect() to the server


-------------

Diffstat:

 Makefile                                           |   4 +-
 arch/arm/boot/dts/omap4-droid4-xt894.dts           |   4 +-
 arch/mips/alchemy/devboards/db1000.c               |   4 +
 arch/mips/alchemy/devboards/db1200.c               |   6 +
 arch/mips/alchemy/devboards/db1300.c               |   4 +
 arch/parisc/include/asm/ldcw.h                     |  36 +-
 arch/parisc/include/asm/ropes.h                    |   3 +
 arch/parisc/include/asm/spinlock_types.h           |   5 -
 arch/parisc/kernel/drivers.c                       |   2 +-
 arch/parisc/kernel/irq.c                           |   2 +-
 arch/powerpc/kernel/hw_breakpoint.c                |   9 +
 arch/powerpc/perf/hv-24x7.c                        |   2 +-
 arch/xtensa/boot/Makefile                          |   3 +-
 arch/xtensa/boot/lib/zmem.c                        |   5 +-
 arch/xtensa/include/asm/core.h                     |   4 +
 arch/xtensa/platforms/iss/network.c                |   4 +-
 drivers/ata/ahci.c                                 |   9 +
 drivers/ata/libahci.c                              |  35 +-
 drivers/ata/libata-core.c                          |  60 ++-
 drivers/ata/libata-eh.c                            |  13 +-
 drivers/ata/libata-scsi.c                          |   2 +-
 drivers/ata/libata-transport.c                     |   9 +-
 drivers/ata/libata.h                               |   2 +
 drivers/base/regmap/regcache-rbtree.c              |   3 +-
 drivers/block/rbd.c                                | 420 +++++++++++----------
 drivers/bus/ti-sysc.c                              |  22 +-
 drivers/char/agp/parisc-agp.c                      |   2 -
 drivers/clk/imx/clk-pll14xx.c                      |   8 +-
 drivers/clk/tegra/clk-bpmp.c                       |   2 +-
 drivers/gpio/gpio-aspeed.c                         |   2 +-
 drivers/gpio/gpio-pmic-eic-sprd.c                  |   1 +
 drivers/gpio/gpio-pxa.c                            |   1 +
 drivers/gpio/gpio-tb10x.c                          |   6 +-
 .../drm/amd/display/modules/freesync/freesync.c    |  69 +++-
 .../gpu/drm/amd/display/modules/inc/mod_freesync.h |   1 +
 drivers/i2c/busses/i2c-i801.c                      |   1 +
 drivers/i2c/muxes/i2c-demux-pinctrl.c              |   4 +
 drivers/infiniband/core/cma_configfs.c             |   2 +-
 drivers/infiniband/core/nldev.c                    |   1 +
 drivers/infiniband/core/uverbs_main.c              |   2 +-
 drivers/infiniband/hw/mlx4/sysfs.c                 |   2 +-
 drivers/infiniband/hw/mlx5/main.c                  |   2 +-
 drivers/infiniband/sw/siw/siw_cm.c                 |  16 +-
 drivers/input/serio/i8042-x86ia64io.h              |   7 +
 drivers/mtd/ubi/build.c                            |   7 +
 drivers/net/dsa/mv88e6xxx/chip.c                   |   6 +-
 drivers/net/dsa/mv88e6xxx/global1.c                |  31 --
 drivers/net/dsa/mv88e6xxx/global1.h                |   1 -
 drivers/net/dsa/mv88e6xxx/global2.c                |   2 +-
 drivers/net/dsa/mv88e6xxx/global2.h                |   1 +
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    |   5 +
 drivers/net/ethernet/intel/i40e/i40e_dcb.c         |   4 +-
 drivers/net/ethernet/intel/i40e/i40e_dcb.h         |   3 +
 drivers/net/ethernet/intel/i40e/i40e_nvm.c         |  61 +--
 drivers/net/ethernet/intel/i40e/i40e_prototype.h   |  10 +-
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 319 +++++++++-------
 drivers/net/ethernet/qlogic/qed/qed_ll2.h          |   2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c  |   7 +-
 drivers/net/team/team.c                            |  10 +-
 drivers/net/thunderbolt.c                          |   3 +-
 drivers/net/usb/smsc75xx.c                         |   4 +-
 drivers/net/wan/fsl_ucc_hdlc.c                     |  12 +-
 drivers/net/wireless/intel/iwlwifi/fw/error-dump.h |   6 +-
 .../net/wireless/marvell/mwifiex/11n_rxreorder.c   |   4 +-
 drivers/net/wireless/marvell/mwifiex/sta_rx.c      |  16 +-
 .../net/wireless/mediatek/mt76/mt76x02_eeprom.c    |   7 -
 drivers/net/wireless/mediatek/mt76/mt76x2/eeprom.c |  13 +-
 drivers/nvme/host/pci.c                            |   2 -
 drivers/parisc/iosapic.c                           |   4 +-
 drivers/parisc/iosapic_private.h                   |   4 +-
 drivers/pci/controller/dwc/pcie-qcom.c             |   2 -
 drivers/s390/scsi/zfcp_aux.c                       |   9 +-
 drivers/scsi/qla2xxx/qla_init.c                    |  21 +-
 drivers/scsi/qla2xxx/qla_target.c                  |  12 +-
 drivers/spi/spi-nxp-fspi.c                         |   7 +
 drivers/target/target_core_device.c                |  11 +-
 drivers/tty/serial/8250/8250_port.c                |   5 +-
 drivers/video/fbdev/Kconfig                        |   2 +-
 drivers/watchdog/iTCO_wdt.c                        |  26 +-
 fs/binfmt_elf_fdpic.c                              |   5 +-
 fs/btrfs/super.c                                   |   6 +-
 fs/ext4/ext4.h                                     |   2 +-
 fs/ext4/mballoc.c                                  | 138 ++++---
 fs/nfs/flexfilelayout/flexfilelayout.c             |   1 +
 fs/nfs/internal.h                                  |   4 +-
 fs/nfs/nfs4state.c                                 |  10 +
 fs/nfs/nfs4trace.h                                 |  93 +++++
 fs/nfs/super.c                                     |  35 ++
 fs/nilfs2/gcinode.c                                |   6 +-
 include/linux/if_team.h                            |   2 +
 include/linux/libata.h                             |   6 +-
 include/linux/netfilter/nf_conntrack_sctp.h        |   1 +
 include/net/tcp.h                                  |   6 +-
 include/uapi/linux/bpf.h                           |   4 +-
 kernel/bpf/queue_stack_maps.c                      |  21 +-
 kernel/trace/ring_buffer.c                         |   5 +
 kernel/trace/trace.c                               |  27 ++
 kernel/trace/trace.h                               |   2 +
 kernel/trace/trace_events.c                        |   6 +-
 net/bridge/br_forward.c                            |   4 +-
 net/bridge/br_input.c                              |   4 +-
 net/core/neighbour.c                               |   4 +-
 net/dccp/ipv4.c                                    |   9 +-
 net/dccp/ipv6.c                                    |   9 +-
 net/ipv4/route.c                                   |   4 +-
 net/ipv4/tcp_input.c                               |  13 +
 net/ipv4/tcp_output.c                              |   7 +-
 net/l2tp/l2tp_ip6.c                                |   2 +-
 net/ncsi/ncsi-aen.c                                |   5 +
 net/netfilter/ipset/ip_set_core.c                  |  12 +-
 net/netfilter/ipvs/ip_vs_sync.c                    |   4 +-
 net/netfilter/nf_conntrack_proto_sctp.c            |  43 ++-
 net/netfilter/nf_tables_api.c                      |   9 +-
 net/nfc/llcp_core.c                                |   2 +
 net/rds/rdma_transport.c                           |   8 +-
 net/rds/tcp_connect.c                              |   2 +-
 net/sctp/associola.c                               |   3 +-
 net/sctp/socket.c                                  |   1 +
 net/socket.c                                       |  29 +-
 net/sunrpc/clnt.c                                  |   1 +
 scripts/mod/file2alias.c                           |   2 +-
 security/integrity/ima/Kconfig                     |  20 +-
 security/smack/smack.h                             |   1 +
 security/smack/smack_lsm.c                         |  65 +++-
 sound/pci/hda/hda_intel.c                          |   1 +
 sound/soc/fsl/imx-audmix.c                         |   2 +-
 sound/soc/meson/axg-spdifin.c                      |  49 +--
 tools/include/uapi/linux/bpf.h                     |   4 +-
 tools/power/cpupower/Makefile                      |   8 +-
 tools/power/cpupower/bench/Makefile                |   2 +-
 .../ftrace/test.d/instances/instance-event.tc      |   2 +-
 tools/testing/selftests/net/tls.c                  |  11 +-
 132 files changed, 1389 insertions(+), 773 deletions(-)


