Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 228467C4AF1
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 08:48:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345642AbjJKGrx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 02:47:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344451AbjJKGrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 02:47:51 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8F9E93;
        Tue, 10 Oct 2023 23:47:46 -0700 (PDT)
Received: from dggpeml500006.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4S53Bn2PrJzkY0X;
        Wed, 11 Oct 2023 14:43:45 +0800 (CST)
Received: from [10.174.176.127] (10.174.176.127) by
 dggpeml500006.china.huawei.com (7.185.36.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Wed, 11 Oct 2023 14:47:42 +0800
Subject: Re: [PATCH 5.10 000/226] 5.10.198-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <stable@vger.kernel.org>
CC:     <patches@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <torvalds@linux-foundation.org>, <akpm@linux-foundation.org>,
        <linux@roeck-us.net>, <shuah@kernel.org>, <patches@kernelci.org>,
        <lkft-triage@lists.linaro.org>, <pavel@denx.de>,
        <jonathanh@nvidia.com>, <f.fainelli@gmail.com>,
        <sudipm.mukherjee@gmail.com>, <srw@sladewatkins.net>,
        <rwarsow@gmx.de>, <conor@kernel.org>
References: <20231009130126.697995596@linuxfoundation.org>
From:   luomeng <luomeng12@huawei.com>
Message-ID: <6c75e3a4-916a-9474-0361-ed80dc77c03e@huawei.com>
Date:   Wed, 11 Oct 2023 14:47:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20231009130126.697995596@linuxfoundation.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.127]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500006.china.huawei.com (7.185.36.76)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tested on arm64 and x86 for 5.10.198-rc1,

Kernel 
repo:https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
Branch: linux-5.10.y
Version: 5.10.198-rc1
Commit: 18c65c1b4996e3f6f8986a05eceaf427355a7a4f
Compiler: gcc version 7.3.0 (GCC)

arm64:
--------------------------------------------------------------------
Testcase Result Summary:
total: 9023
passed: 9023
failed: 0
timeout: 0
--------------------------------------------------------------------

x86:
--------------------------------------------------------------------
Testcase Result Summary:
total: 9023
passed: 9023
failed: 0
timeout: 0
--------------------------------------------------------------------
Tested-by: Hulk Robot <hulkrobot@huawei.com>

在 2023/10/9 20:59, Greg Kroah-Hartman 写道:
> This is the start of the stable review cycle for the 5.10.198 release.
> There are 226 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 11 Oct 2023 13:00:55 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.198-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 
> -------------
> Pseudo-Shortlog of commits:
> 
> Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>      Linux 5.10.198-rc1
> 
> Florian Westphal <fw@strlen.de>
>      netfilter: nftables: exthdr: fix 4-byte stack OOB write
> 
> Florian Westphal <fw@strlen.de>
>      netfilter: nf_tables: fix kdoc warnings after gc rework
> 
> John David Anglin <dave@parisc-linux.org>
>      parisc: Restore __ldcw_align for PA-RISC 2.0 processors
> 
> Shay Drory <shayd@nvidia.com>
>      RDMA/mlx5: Fix NULL string error
> 
> Bernard Metzler <bmt@zurich.ibm.com>
>      RDMA/siw: Fix connection failure handling
> 
> Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
>      RDMA/uverbs: Fix typo of sizeof argument
> 
> Leon Romanovsky <leon@kernel.org>
>      RDMA/cma: Fix truncation compilation warning in make_cma_ports
> 
> Mark Zhang <markzhang@nvidia.com>
>      RDMA/cma: Initialize ib_sa_multicast structure to 0 when join
> 
> Duje Mihanović <duje.mihanovic@skole.hr>
>      gpio: pxa: disable pinctrl calls for MMP_GPIO
> 
> Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>      gpio: aspeed: fix the GPIO number passed to pinctrl_gpio_set_config()
> 
> Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>      IB/mlx4: Fix the size of a buffer in add_port_entries()
> 
> Dan Carpenter <dan.carpenter@linaro.org>
>      of: dynamic: Fix potential memory leak in of_changeset_action()
> 
> Leon Romanovsky <leon@kernel.org>
>      RDMA/core: Require admin capabilities to set system parameters
> 
> Fedor Pchelkin <pchelkin@ispras.ru>
>      dm zoned: free dmz->ddev array in dmz_put_zoned_devices
> 
> Ivan Babrou <ivan@cloudflare.com>
>      cpupower: add Makefile dependencies for install targets
> 
> Xin Long <lucien.xin@gmail.com>
>      sctp: update hb timer immediately after users change hb_interval
> 
> Xin Long <lucien.xin@gmail.com>
>      sctp: update transport state when processing a dupcook packet
> 
> Neal Cardwell <ncardwell@google.com>
>      tcp: fix delayed ACKs for MSS boundary condition
> 
> Neal Cardwell <ncardwell@google.com>
>      tcp: fix quick-ack counting to count actual ACKs of new data
> 
> Chengfeng Ye <dg573847474@gmail.com>
>      tipc: fix a potential deadlock on &tx->lock
> 
> Ben Wolsieffer <ben.wolsieffer@hefring.com>
>      net: stmmac: dwmac-stm32: fix resume on STM32 MCU
> 
> Florian Westphal <fw@strlen.de>
>      netfilter: nf_tables: nft_set_rbtree: fix spurious insertion failure
> 
> Xin Long <lucien.xin@gmail.com>
>      netfilter: handle the connecting collision properly in nf_conntrack_proto_sctp
> 
> Dan Carpenter <dan.carpenter@linaro.org>
>      net: ethernet: ti: am65-cpsw: Fix error code in am65_cpsw_nuss_init_tx_chns()
> 
> Jeremy Cline <jeremy@jcline.org>
>      net: nfc: llcp: Add lock when modifying device list
> 
> Shigeru Yoshida <syoshida@redhat.com>
>      net: usb: smsc75xx: Fix uninit-value access in __smsc75xx_read_reg
> 
> Fabio Estevam <festevam@denx.de>
>      net: dsa: mv88e6xxx: Avoid EEPROM timeout when EEPROM is absent
> 
> David Howells <dhowells@redhat.com>
>      ipv4, ipv6: Fix handling of transhdrlen in __ip{,6}_append_data()
> 
> Eric Dumazet <edumazet@google.com>
>      net: fix possible store tearing in neigh_periodic_work()
> 
> Mauricio Faria de Oliveira <mfo@canonical.com>
>      modpost: add missing else to the "of" check
> 
> Trond Myklebust <trond.myklebust@hammerspace.com>
>      NFSv4: Fix a nfs4_state_manager() race
> 
> Arnd Bergmann <arnd@arndb.de>
>      ima: rework CONFIG_IMA dependency block
> 
> Junxiao Bi <junxiao.bi@oracle.com>
>      scsi: target: core: Fix deadlock due to recursive locking
> 
> Oleksandr Tymoshenko <ovt@google.com>
>      ima: Finish deprecation of IMA_TRUSTED_KEYRING Kconfig
> 
> Richard Fitzgerald <rf@opensource.cirrus.com>
>      regmap: rbtree: Fix wrong register marked as in-cache when creating new node
> 
> Felix Fietkau <nbd@nbd.name>
>      wifi: mt76: mt76x02: fix MT76x0 external LNA gain handling
> 
> Alexandra Diupina <adiupina@astralinux.ru>
>      drivers/net: process the result of hdlc_open() and add call of hdlc_close() in uhdlc_close()
> 
> Leon Hwang <hffilwlqm@gmail.com>
>      bpf: Fix tr dereferencing
> 
> Pin-yen Lin <treapking@chromium.org>
>      wifi: mwifiex: Fix oob check condition in mwifiex_process_rx_packet
> 
> Arnd Bergmann <arnd@arndb.de>
>      wifi: iwlwifi: dbg_ini: fix structure packing
> 
> Zhihao Cheng <chengzhihao1@huawei.com>
>      ubi: Refuse attaching if mtd's erasesize is 0
> 
> Rob Herring <robh@kernel.org>
>      arm64: Add Cortex-A520 CPU part definition
> 
> Jordan Rife <jrife@google.com>
>      net: prevent rewrite of msg_name in sock_sendmsg()
> 
> Qu Wenruo <wqu@suse.com>
>      btrfs: reject unknown mount options early
> 
> Jordan Rife <jrife@google.com>
>      net: replace calls to sock->ops->connect() with kernel_connect()
> 
> Gustavo A. R. Silva <gustavoars@kernel.org>
>      wifi: mwifiex: Fix tlv_buf_left calculation
> 
> Gustavo A. R. Silva <gustavoars@kernel.org>
>      qed/red_ll2: Fix undefined behavior bug in struct qed_ll2_info
> 
> Dinghao Liu <dinghao.liu@zju.edu.cn>
>      scsi: zfcp: Fix a double put in zfcp_port_enqueue()
> 
> Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>      Revert "PCI: qcom: Disable write access to read only registers for IP v2.3.3"
> 
> Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>      Revert "clk: imx: pll14xx: dynamically configure PLL for 393216000/361267200Hz"
> 
> Ming Lei <ming.lei@redhat.com>
>      block: fix use-after-free of q->q_usage_counter
> 
> Ilya Dryomov <idryomov@gmail.com>
>      rbd: take header_rwsem in rbd_dev_refresh() only when updating
> 
> Ilya Dryomov <idryomov@gmail.com>
>      rbd: decouple parent info read-in from updating rbd_dev
> 
> Ilya Dryomov <idryomov@gmail.com>
>      rbd: decouple header read-in from updating rbd_dev->header
> 
> Ilya Dryomov <idryomov@gmail.com>
>      rbd: move rbd_dev_refresh() definition
> 
> Nathan Chancellor <nathan@kernel.org>
>      drm/mediatek: Fix backport issue in mtk_drm_gem_prime_vmap()
> 
> Zheng Yejian <zhengyejian1@huawei.com>
>      ring-buffer: Fix bytes info in per_cpu buffer stats
> 
> Vlastimil Babka <vbabka@suse.cz>
>      ring-buffer: remove obsolete comment for free_buffer_page()
> 
> Trond Myklebust <trond.myklebust@hammerspace.com>
>      NFSv4: Fix a state manager thread deadlock regression
> 
> Benjamin Coddington <bcodding@redhat.com>
>      NFS: rename nfs_client_kset to nfs_kset
> 
> Benjamin Coddington <bcodding@redhat.com>
>      NFS: Cleanup unused rpc_clnt variable
> 
> Johan Hovold <johan+linaro@kernel.org>
>      spi: zynqmp-gqspi: fix clock imbalance on probe failure
> 
> Dinghao Liu <dinghao.liu@zju.edu.cn>
>      spi: spi-zynqmp-gqspi: Fix runtime PM imbalance in zynqmp_qspi_probe
> 
> Greg Ungerer <gerg@kernel.org>
>      fs: binfmt_elf_efpic: fix personality for ELF-FDPIC
> 
> Matthias Schiffer <mschiffer@universe-factory.net>
>      ata: libata-sata: increase PMP SRST timeout to 10s
> 
> Damien Le Moal <dlemoal@kernel.org>
>      ata: libata-core: Do not register PM operations for SAS ports
> 
> Damien Le Moal <dlemoal@kernel.org>
>      ata: libata-core: Fix port and device removal
> 
> Damien Le Moal <dlemoal@kernel.org>
>      ata: libata-core: Fix ata_port_request_pm() locking
> 
> Mika Westerberg <mika.westerberg@linux.intel.com>
>      net: thunderbolt: Fix TCPv6 GSO checksum calculation
> 
> Nick Desaulniers <ndesaulniers@google.com>
>      bpf: Fix BTF_ID symbol generation collision in tools/
> 
> Jiri Olsa <jolsa@kernel.org>
>      bpf: Fix BTF_ID symbol generation collision
> 
> Josef Bacik <josef@toxicpanda.com>
>      btrfs: properly report 0 avail for very full file systems
> 
> Steven Rostedt (Google) <rostedt@goodmis.org>
>      ring-buffer: Update "shortest_full" in polling
> 
> Ben Wolsieffer <Ben.Wolsieffer@hefring.com>
>      proc: nommu: /proc/<pid>/maps: release mmap read lock
> 
> Trond Myklebust <trond.myklebust@hammerspace.com>
>      Revert "SUNRPC dont update timeout value on connection reset"
> 
> Heiner Kallweit <hkallweit1@gmail.com>
>      i2c: i801: unregister tco_pdev in i801_probe() error path
> 
> Niklas Cassel <niklas.cassel@wdc.com>
>      ata: libata-scsi: ignore reserved bits for REPORT SUPPORTED OPERATION CODES
> 
> Kailang Yang <kailang@realtek.com>
>      ALSA: hda: Disable power save for solving pop issue on Lenovo ThinkCentre M70q
> 
> Pablo Neira Ayuso <pablo@netfilter.org>
>      netfilter: nf_tables: disallow rule removal from chain binding
> 
> Pan Bian <bianpan2016@163.com>
>      nilfs2: fix potential use after free in nilfs_gccache_submit_read_data()
> 
> Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>      serial: 8250_port: Check IRQ data before use
> 
> Daniel Starke <daniel.starke@siemens.com>
>      Revert "tty: n_gsm: fix UAF in gsm_cleanup_mux"
> 
> Vishal Goel <vishal.goel@samsung.com>
>      Smack:- Use overlay inode label in smack_inode_copy_up()
> 
> Roberto Sassu <roberto.sassu@huawei.com>
>      smack: Retrieve transmuting information in smack_inode_getsecurity()
> 
> Roberto Sassu <roberto.sassu@huawei.com>
>      smack: Record transmuting in smk_transmuted
> 
> Irvin Cote <irvin.cote@insa-lyon.fr>
>      nvme-pci: always return an ERR_PTR from nvme_pci_alloc_dev
> 
> Phil Sutter <phil@nwl.cc>
>      netfilter: nft_exthdr: Fix for unsafe packet data read
> 
> Phil Sutter <phil@nwl.cc>
>      netfilter: nft_exthdr: Search chunks in SCTP packets only
> 
> Mika Westerberg <mika.westerberg@linux.intel.com>
>      watchdog: iTCO_wdt: Set NO_REBOOT if the watchdog is not already running
> 
> Mika Westerberg <mika.westerberg@linux.intel.com>
>      watchdog: iTCO_wdt: No need to stop the timer in probe
> 
> Pratyush Yadav <ptyadav@amazon.de>
>      nvme-pci: do not set the NUMA node of device if it has none
> 
> Christoph Hellwig <hch@lst.de>
>      nvme-pci: factor out a nvme_pci_alloc_dev helper
> 
> Christoph Hellwig <hch@lst.de>
>      nvme-pci: factor the iod mempool creation into a helper
> 
> Mario Limonciello <mario.limonciello@amd.com>
>      ACPI: Check StorageD3Enable _DSD property in ACPI code
> 
> Chengming Zhou <zhouchengming@bytedance.com>
>      cgroup: Fix suspicious rcu_dereference_check() usage warning
> 
> Chengming Zhou <zhouchengming@bytedance.com>
>      sched/cpuacct: Optimize away RCU read lock
> 
> Chengming Zhou <zhouchengming@bytedance.com>
>      sched/cpuacct: Fix charge percpu cpuusage
> 
> Andrey Ryabinin <arbn@yandex-team.com>
>      sched/cpuacct: Fix user/system in shown cpuacct.usage*
> 
> Arnaldo Carvalho de Melo <acme@redhat.com>
>      perf build: Define YYNOMEM as YYNOABORT for bison < 3.81
> 
> Thomas Zimmermann <tzimmermann@suse.de>
>      fbdev/sh7760fb: Depend on FB=y
> 
> Johnathan Mantey <johnathanx.mantey@intel.com>
>      ncsi: Propagate carrier gain/loss events to the NCSI controller
> 
> Benjamin Gray <bgray@linux.ibm.com>
>      powerpc/watchpoints: Disable preemption in thread_change_pc()
> 
> Hans Verkuil <hverkuil-cisco@xs4all.nl>
>      media: vb2: frame_vector.c: replace WARN_ONCE with a comment
> 
> Stanislav Fomichev <sdf@google.com>
>      bpf: Clarify error expectations from bpf_clone_redirect
> 
> Han Xu <han.xu@nxp.com>
>      spi: nxp-fspi: reset the FLSHxCR1 registers
> 
> Niklas Cassel <niklas.cassel@wdc.com>
>      ata: libata-eh: do not clear ATA_PFLAG_EH_PENDING in ata_eh_reset()
> 
> Michal Grzedzicki <mge@meta.com>
>      scsi: pm80xx: Avoid leaking tags when processing OPC_INB_SET_CONTROLLER_CONFIG command
> 
> Michal Grzedzicki <mge@meta.com>
>      scsi: pm80xx: Use phy-specific SAS address when sending PHY_START command
> 
> David Thompson <davthompson@nvidia.com>
>      platform/mellanox: mlxbf-bootctl: add NET dependency into Kconfig
> 
> Steven Rostedt (Google) <rostedt@goodmis.org>
>      ring-buffer: Do not attempt to read past "commit"
> 
> Ricardo B. Marliere <rbmarliere@gmail.com>
>      selftests: fix dependency checker script
> 
> Zheng Yejian <zhengyejian1@huawei.com>
>      ring-buffer: Avoid softlockup in ring_buffer_resize()
> 
> Zheng Yejian <zhengyejian1@huawei.com>
>      selftests/ftrace: Correctly enable event in instance-event.tc
> 
> Javed Hasan <jhasan@marvell.com>
>      scsi: qedf: Add synchronization between I/O completions and abort
> 
> Helge Deller <deller@gmx.de>
>      parisc: irq: Make irq_stack_union static to avoid sparse warning
> 
> Helge Deller <deller@gmx.de>
>      parisc: drivers: Fix sparse warning
> 
> Helge Deller <deller@gmx.de>
>      parisc: iosapic.c: Fix sparse warnings
> 
> Helge Deller <deller@gmx.de>
>      parisc: sba: Fix compile warning wrt list of SBA devices
> 
> Sergey Senozhatsky <senozhatsky@chromium.org>
>      dma-debug: don't call __dma_entry_alloc_check_leak() under free_entries_lock
> 
> William A. Kennington III <william@wkennington.com>
>      i2c: npcm7xx: Fix callback completion ordering
> 
> Wenhua Lin <Wenhua.Lin@unisoc.com>
>      gpio: pmic-eic-sprd: Add can_sleep flag for PMIC EIC chip
> 
> Max Filippov <jcmvbkbc@gmail.com>
>      xtensa: boot/lib: fix function prototypes
> 
> Randy Dunlap <rdunlap@infradead.org>
>      xtensa: boot: don't add include-dirs
> 
> Randy Dunlap <rdunlap@infradead.org>
>      xtensa: iss/network: make functions static
> 
> Max Filippov <jcmvbkbc@gmail.com>
>      xtensa: add default definition for XCHAL_HAVE_DIV32
> 
> Dan Carpenter <dan.carpenter@linaro.org>
>      power: supply: ucs1002: fix error code in ucs1002_get_property()
> 
> Tony Lindgren <tony@atomide.com>
>      bus: ti-sysc: Fix SYSC_QUIRK_SWSUP_SIDLE_ACT handling for uart wake-up
> 
> Tony Lindgren <tony@atomide.com>
>      ARM: dts: ti: omap: motorola-mapphone: Fix abe_clkctrl warning on boot
> 
> Tony Lindgren <tony@atomide.com>
>      ARM: dts: Unify pwm-omap-dmtimer node names
> 
> Gireesh Hiremath <Gireesh.Hiremath@in.bosch.com>
>      ARM: dts: am335x: Guardian: Update beeper label
> 
> Geert Uytterhoeven <geert+renesas@glider.be>
>      ARM: dts: motorola-mapphone: Drop second ti,wlcore compatible value
> 
> Carl Philipp Klemm <philipp@uvos.xyz>
>      ARM: dts: motorola-mapphone: Add 1.2GHz OPP
> 
> Tony Lindgren <tony@atomide.com>
>      ARM: dts: motorola-mapphone: Configure lower temperature passive cooling
> 
> Tony Lindgren <tony@atomide.com>
>      ARM: dts: ti: omap: Fix bandgap thermal cells addressing for omap3/4
> 
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>      ARM: dts: omap: correct indentation
> 
> Timo Alho <talho@nvidia.com>
>      clk: tegra: fix error return case for recalc_rate
> 
> Adam Ford <aford173@gmail.com>
>      bus: ti-sysc: Fix missing AM35xx SoC matching
> 
> Julien Panis <jpanis@baylibre.com>
>      bus: ti-sysc: Use fsleep() instead of usleep_range() in sysc_reset()
> 
> Christoph Hellwig <hch@lst.de>
>      MIPS: Alchemy: only build mmc support helpers if au1xmmc is enabled
> 
> Qu Wenruo <wqu@suse.com>
>      btrfs: reset destination buffer when read_extent_buffer() gets invalid range
> 
> Werner Fischer <devlists@wefi.net>
>      ata: ahci: Add Elkhart Lake AHCI controller
> 
> Mario Limonciello <mario.limonciello@amd.com>
>      ata: ahci: Rename board_ahci_mobile
> 
> Paul Menzel <pmenzel@molgen.mpg.de>
>      ata: ahci: Add support for AMD A85 FCH (Hudson D4)
> 
> Paul Menzel <pmenzel@molgen.mpg.de>
>      ata: libata: Rename link flag ATA_LFLAG_NO_DB_DELAY
> 
> Xiao Liang <shaw.leon@gmail.com>
>      netfilter: nft_exthdr: Fix non-linear header modification
> 
> Florian Westphal <fw@strlen.de>
>      netfilter: exthdr: add support for tcp option removal
> 
> Pablo Neira Ayuso <pablo@netfilter.org>
>      netfilter: nft_exthdr: break evaluation if setting TCP option fails
> 
> Florian Westphal <fw@strlen.de>
>      netfilter: nf_tables: add and use nft_thoff helper
> 
> Florian Westphal <fw@strlen.de>
>      netfilter: nf_tables: add and use nft_sk helper
> 
> Phil Sutter <phil@nwl.cc>
>      netfilter: nft_exthdr: Support SCTP chunks
> 
> Jan Engelhardt <jengelh@inai.de>
>      netfilter: use actual socket sk for REJECT action
> 
> Konrad Dybcio <konrad.dybcio@linaro.org>
>      media: venus: hfi_venus: Write to VIDC_CTRL_INIT after unmasking interrupts
> 
> Dikshita Agarwal <dikshita@codeaurora.org>
>      media: venus: hfi: Add a 6xx boot logic
> 
> Bryan O'Donoghue <bryan.odonoghue@linaro.org>
>      media: venus: core: Add differentiator IS_V6(core)
> 
> Dikshita Agarwal <dikshita@codeaurora.org>
>      media: venus: hfi: Define additional 6xx registers
> 
> Bryan O'Donoghue <bryan.odonoghue@linaro.org>
>      media: venus: hfi,pm,firmware: Convert to block relative addressing
> 
> Bryan O'Donoghue <bryan.odonoghue@linaro.org>
>      media: venus: core: Add io base variables for each block
> 
> Wolfram Sang <wsa+renesas@sang-engineering.com>
>      mmc: renesas_sdhi: register irqs before registering controller
> 
> Wolfram Sang <wsa+renesas@sang-engineering.com>
>      mmc: tmio: support custom irq masks
> 
> Wolfram Sang <wsa+renesas@sang-engineering.com>
>      mmc: renesas_sdhi: populate SCC pointer at the proper place
> 
> Wolfram Sang <wsa+renesas@sang-engineering.com>
>      mmc: renesas_sdhi: probe into TMIO after SCC parameters have been setup
> 
> Werner Sembach <wse@tuxedocomputers.com>
>      Input: i8042 - add quirk for TUXEDO Gemini 17 Gen1/Clevo PD70PN
> 
> Huacai Chen <chenhuacai@loongson.cn>
>      Input: i8042 - rename i8042-x86ia64io.h to i8042-acpipnpio.h
> 
> Pablo Neira Ayuso <pablo@netfilter.org>
>      netfilter: nf_tables: double hook unregistration in netns path
> 
> Pablo Neira Ayuso <pablo@netfilter.org>
>      netfilter: nf_tables: unregister flowtable hooks on netns exit
> 
> Xiaoke Wang <xkernel.wang@foxmail.com>
>      i2c: mux: demux-pinctrl: check the return value of devm_kstrdup()
> 
> Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>      gpio: tb10x: Fix an error handling path in tb10x_gpio_probe()
> 
> Artem Chernyshev <artem.chernyshev@red-soft.ru>
>      net: rds: Fix possible NULL-pointer dereference
> 
> Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>      bnxt_en: Flush XDP for bnxt_poll_nitroa0()'s NAPI
> 
> Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>      locking/seqlock: Do the lockdep annotation before locking in do_write_seqcount_begin_nested()
> 
> Ahmed S. Darwish <a.darwish@linutronix.de>
>      seqlock: Prefix internal seqcount_t-only macros with a "do_"
> 
> Peter Zijlstra <peterz@infradead.org>
>      seqlock: Rename __seqprop() users
> 
> Arnd Bergmann <arnd@arndb.de>
>      seqlock: avoid -Wshadow warnings
> 
> Jozsef Kadlecsik <kadlec@netfilter.org>
>      netfilter: ipset: Fix race between IPSET_CMD_CREATE and IPSET_CMD_SWAP
> 
> Ziyang Xuan <william.xuanziyang@huawei.com>
>      team: fix null-ptr-deref when team device type is changed
> 
> Eric Dumazet <edumazet@google.com>
>      net: bridge: use DEV_STATS_INC()
> 
> Jie Wang <wangjie125@huawei.com>
>      net: hns3: add 5ms delay before clear firmware reset irq source
> 
> Jian Shen <shenjian15@huawei.com>
>      net: hns3: only enable unicast promisc when mac table full
> 
> Josh Poimboeuf <jpoimboe@kernel.org>
>      x86/srso: Fix SBPB enablement for spec_rstack_overflow=off
> 
> Josh Poimboeuf <jpoimboe@kernel.org>
>      x86/srso: Fix srso_show_state() side effect
> 
> Stephen Boyd <swboyd@chromium.org>
>      platform/x86: intel_scu_ipc: Fail IPC send if still busy
> 
> Stephen Boyd <swboyd@chromium.org>
>      platform/x86: intel_scu_ipc: Don't override scu in intel_scu_ipc_dev_simple_command()
> 
> Stephen Boyd <swboyd@chromium.org>
>      platform/x86: intel_scu_ipc: Check status upon timeout in ipc_wait_for_interrupt()
> 
> Stephen Boyd <swboyd@chromium.org>
>      platform/x86: intel_scu_ipc: Check status after timeout in busy_loop()
> 
> Eric Dumazet <edumazet@google.com>
>      dccp: fix dccp_v4_err()/dccp_v6_err() again
> 
> Kajol Jain <kjain@linux.ibm.com>
>      powerpc/perf/hv-24x7: Update domain value check
> 
> Kyle Zeng <zengyhkyle@gmail.com>
>      ipv4: fix null-deref in ipv4_link_failure
> 
> Ivan Vecera <ivecera@redhat.com>
>      i40e: Fix VF VLAN offloading when port VLAN is configured
> 
> Shengjiu Wang <shengjiu.wang@nxp.com>
>      ASoC: imx-audmix: Fix return error with devm_clk_get()
> 
> Sabrina Dubroca <sd@queasysnail.net>
>      selftests: tls: swap the TX and RX sockets in some tests
> 
> Kees Cook <keescook@chromium.org>
>      selftests/tls: Add {} to avoid static checker warning
> 
> Toke Høiland-Jørgensen <toke@redhat.com>
>      bpf: Avoid deadlock when using queue and stack maps from NMI
> 
> Pablo Neira Ayuso <pablo@netfilter.org>
>      netfilter: nf_tables: disallow element removal on anonymous sets
> 
> Jerome Brunet <jbrunet@baylibre.com>
>      ASoC: meson: spdifin: start hw on dai probe
> 
> Florian Westphal <fw@strlen.de>
>      netfilter: nf_tables: fix memleak when more than 255 elements expired
> 
> Pablo Neira Ayuso <pablo@netfilter.org>
>      netfilter: nft_set_hash: try later when GC hits EAGAIN on iteration
> 
> Pablo Neira Ayuso <pablo@netfilter.org>
>      netfilter: nft_set_pipapo: stop GC iteration if GC transaction allocation fails
> 
> Pablo Neira Ayuso <pablo@netfilter.org>
>      netfilter: nft_set_rbtree: use read spinlock to avoid datapath contention
> 
> Pablo Neira Ayuso <pablo@netfilter.org>
>      netfilter: nft_set_rbtree: skip sync GC for new elements in this transaction
> 
> Florian Westphal <fw@strlen.de>
>      netfilter: nf_tables: defer gc run if previous batch is still pending
> 
> Pablo Neira Ayuso <pablo@netfilter.org>
>      netfilter: nf_tables: use correct lock to protect gc_list
> 
> Pablo Neira Ayuso <pablo@netfilter.org>
>      netfilter: nf_tables: GC transaction race with abort path
> 
> Pablo Neira Ayuso <pablo@netfilter.org>
>      netfilter: nf_tables: GC transaction race with netns dismantle
> 
> Pablo Neira Ayuso <pablo@netfilter.org>
>      netfilter: nf_tables: fix GC transaction races with netns and netlink event exit path
> 
> Florian Westphal <fw@strlen.de>
>      netfilter: nf_tables: don't fail inserts if duplicate has expired
> 
> Pablo Neira Ayuso <pablo@netfilter.org>
>      netfilter: nf_tables: remove busy mark and gc batch API
> 
> Pablo Neira Ayuso <pablo@netfilter.org>
>      netfilter: nft_set_hash: mark set element as dead when deleting from packet path
> 
> Pablo Neira Ayuso <pablo@netfilter.org>
>      netfilter: nf_tables: adapt set backend to use GC transaction API
> 
> Pablo Neira Ayuso <pablo@netfilter.org>
>      netfilter: nf_tables: GC transaction API to avoid race with control plane
> 
> Florian Westphal <fw@strlen.de>
>      netfilter: nf_tables: don't skip expired elements during walk
> 
> Pablo Neira Ayuso <pablo@netfilter.org>
>      netfilter: nf_tables: integrate pipapo into commit protocol
> 
> Steven Rostedt (Google) <rostedt@goodmis.org>
>      tracing: Have event inject files inc the trace array ref count
> 
> Jan Kara <jack@suse.cz>
>      ext4: do not let fstrim block system suspend
> 
> Jan Kara <jack@suse.cz>
>      ext4: move setting of trimmed bit into ext4_try_to_trim_range()
> 
> Kemeng Shi <shikemeng@huaweicloud.com>
>      ext4: replace the traditional ternary conditional operator with with max()/min()
> 
> Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
>      ext4: mark group as trimmed only if it was fully scanned
> 
> Lukas Czerner <lczerner@redhat.com>
>      ext4: change s_last_trim_minblks type to unsigned long
> 
> Lukas Bulwahn <lukas.bulwahn@gmail.com>
>      ext4: scope ret locally in ext4_try_to_trim_range()
> 
> Wang Jianchao <wangjianchao@kuaishou.com>
>      ext4: add new helper interface ext4_try_to_trim_range()
> 
> Wang Jianchao <wangjianchao@kuaishou.com>
>      ext4: remove the 'group' parameter of ext4_trim_extent
> 
> Szuying Chen <chensiying21@gmail.com>
>      ata: libahci: clear pending interrupt status
> 
> Hannes Reinecke <hare@suse.de>
>      ata: ahci: Drop pointless VPRINTK() calls and convert the remaining ones
> 
> Steven Rostedt (Google) <rostedt@goodmis.org>
>      tracing: Increase trace array ref count on enable and filter files
> 
> Trond Myklebust <trond.myklebust@hammerspace.com>
>      SUNRPC: Mark the cred for revalidation if the server rejects it
> 
> Trond Myklebust <trond.myklebust@hammerspace.com>
>      NFS/pNFS: Report EINVAL errors from connect() to the server
> 
> Trond Myklebust <trond.myklebust@hammerspace.com>
>      NFS: Use the correct commit info in nfs_join_page_group()
> 
> 
> -------------
> 
> Diffstat:
> 
>   Makefile                                           |   4 +-
>   arch/arm/boot/dts/am335x-guardian.dts              |   9 +-
>   arch/arm/boot/dts/am3517-evm.dts                   |   2 +-
>   arch/arm/boot/dts/logicpd-torpedo-baseboard.dtsi   |   2 +-
>   arch/arm/boot/dts/motorola-mapphone-common.dtsi    |  33 +-
>   arch/arm/boot/dts/omap-gpmc-smsc911x.dtsi          |   6 +-
>   arch/arm/boot/dts/omap-gpmc-smsc9221.dtsi          |   6 +-
>   arch/arm/boot/dts/omap3-cm-t3517.dts               |  12 +-
>   arch/arm/boot/dts/omap3-cpu-thermal.dtsi           |   3 +-
>   arch/arm/boot/dts/omap3-gta04.dtsi                 |   8 +-
>   arch/arm/boot/dts/omap3-ldp.dts                    |   2 +-
>   arch/arm/boot/dts/omap3-n900.dts                   |  40 +-
>   arch/arm/boot/dts/omap3-zoom3.dts                  |  44 +--
>   arch/arm/boot/dts/omap4-cpu-thermal.dtsi           |  29 +-
>   arch/arm/boot/dts/omap443x.dtsi                    |   1 +
>   arch/arm/boot/dts/omap4460.dtsi                    |   1 +
>   arch/arm/boot/dts/omap5-cm-t54.dts                 |  64 +--
>   arch/arm64/include/asm/cputype.h                   |   2 +
>   arch/mips/alchemy/devboards/db1000.c               |   4 +
>   arch/mips/alchemy/devboards/db1200.c               |   6 +
>   arch/mips/alchemy/devboards/db1300.c               |   4 +
>   arch/parisc/include/asm/ldcw.h                     |  36 +-
>   arch/parisc/include/asm/ropes.h                    |   3 +
>   arch/parisc/include/asm/spinlock_types.h           |   5 -
>   arch/parisc/kernel/drivers.c                       |   2 +-
>   arch/parisc/kernel/irq.c                           |   2 +-
>   arch/powerpc/kernel/hw_breakpoint.c                |   7 +-
>   arch/powerpc/perf/hv-24x7.c                        |   2 +-
>   arch/x86/kernel/cpu/bugs.c                         |   4 +-
>   arch/xtensa/boot/Makefile                          |   3 +-
>   arch/xtensa/boot/lib/zmem.c                        |   5 +-
>   arch/xtensa/include/asm/core.h                     |   4 +
>   arch/xtensa/platforms/iss/network.c                |   4 +-
>   block/blk-core.c                                   |   2 -
>   block/blk-sysfs.c                                  |   2 +
>   drivers/acpi/device_pm.c                           |  29 ++
>   drivers/ata/ahci.c                                 | 111 +++---
>   drivers/ata/ahci_brcm.c                            |   2 +-
>   drivers/ata/ahci_xgene.c                           |   4 -
>   drivers/ata/libahci.c                              |  49 +--
>   drivers/ata/libata-core.c                          |  41 +-
>   drivers/ata/libata-eh.c                            |  13 +-
>   drivers/ata/libata-sata.c                          |   2 +-
>   drivers/ata/libata-scsi.c                          |   2 +-
>   drivers/ata/libata-transport.c                     |   9 +-
>   drivers/ata/libata.h                               |   2 +
>   drivers/base/regmap/regcache-rbtree.c              |   3 +-
>   drivers/block/rbd.c                                | 412 ++++++++++---------
>   drivers/bus/ti-sysc.c                              |  31 +-
>   drivers/char/agp/parisc-agp.c                      |   2 -
>   drivers/clk/imx/clk-pll14xx.c                      |   2 +
>   drivers/clk/tegra/clk-bpmp.c                       |   2 +-
>   drivers/gpio/gpio-aspeed.c                         |   2 +-
>   drivers/gpio/gpio-pmic-eic-sprd.c                  |   1 +
>   drivers/gpio/gpio-pxa.c                            |   1 +
>   drivers/gpio/gpio-tb10x.c                          |   6 +-
>   drivers/gpu/drm/mediatek/mtk_drm_gem.c             |   2 +-
>   drivers/i2c/busses/i2c-i801.c                      |   1 +
>   drivers/i2c/busses/i2c-npcm7xx.c                   |  17 +-
>   drivers/i2c/muxes/i2c-demux-pinctrl.c              |   4 +
>   drivers/infiniband/core/cma.c                      |   2 +-
>   drivers/infiniband/core/cma_configfs.c             |   2 +-
>   drivers/infiniband/core/nldev.c                    |   1 +
>   drivers/infiniband/core/uverbs_main.c              |   2 +-
>   drivers/infiniband/hw/mlx4/sysfs.c                 |   2 +-
>   drivers/infiniband/hw/mlx5/main.c                  |   2 +-
>   drivers/infiniband/sw/siw/siw_cm.c                 |  16 +-
>   .../serio/{i8042-x86ia64io.h => i8042-acpipnpio.h} |  13 +-
>   drivers/input/serio/i8042.h                        |   2 +-
>   drivers/md/dm-zoned-target.c                       |  15 +-
>   drivers/media/platform/qcom/venus/core.c           |  12 +
>   drivers/media/platform/qcom/venus/core.h           |  11 +
>   drivers/media/platform/qcom/venus/firmware.c       |  28 +-
>   drivers/media/platform/qcom/venus/hfi_venus.c      |  94 +++--
>   drivers/media/platform/qcom/venus/hfi_venus_io.h   | 114 ++++--
>   drivers/media/platform/qcom/venus/pm_helpers.c     |  12 +-
>   drivers/mmc/host/renesas_sdhi_core.c               |  19 +-
>   drivers/mmc/host/tmio_mmc.h                        |   1 +
>   drivers/mmc/host/tmio_mmc_core.c                   |   8 +-
>   drivers/mtd/ubi/build.c                            |   7 +
>   drivers/net/dsa/mv88e6xxx/chip.c                   |   6 +-
>   drivers/net/dsa/mv88e6xxx/global1.c                |  31 --
>   drivers/net/dsa/mv88e6xxx/global1.h                |   1 -
>   drivers/net/dsa/mv88e6xxx/global2.c                |   2 +-
>   drivers/net/dsa/mv88e6xxx/global2.h                |   1 +
>   drivers/net/ethernet/broadcom/bnxt/bnxt.c          |   5 +
>   .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    |   7 +-
>   drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |   7 +-
>   drivers/net/ethernet/qlogic/qed/qed_ll2.h          |   2 +-
>   drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c  |   7 +-
>   drivers/net/ethernet/ti/am65-cpsw-nuss.c           |   1 +
>   drivers/net/team/team.c                            |  10 +-
>   drivers/net/thunderbolt.c                          |   3 +-
>   drivers/net/usb/smsc75xx.c                         |   4 +-
>   drivers/net/wan/fsl_ucc_hdlc.c                     |  12 +-
>   drivers/net/wireless/intel/iwlwifi/fw/error-dump.h |   6 +-
>   .../net/wireless/marvell/mwifiex/11n_rxreorder.c   |   4 +-
>   drivers/net/wireless/marvell/mwifiex/sta_rx.c      |  16 +-
>   .../net/wireless/mediatek/mt76/mt76x02_eeprom.c    |   7 -
>   drivers/net/wireless/mediatek/mt76/mt76x2/eeprom.c |  13 +-
>   drivers/nvme/host/pci.c                            | 149 +++----
>   drivers/of/dynamic.c                               |   6 +-
>   drivers/parisc/iosapic.c                           |   4 +-
>   drivers/parisc/iosapic_private.h                   |   4 +-
>   drivers/pci/controller/dwc/pcie-qcom.c             |   2 -
>   drivers/platform/mellanox/Kconfig                  |   1 +
>   drivers/platform/x86/intel_scu_ipc.c               |  66 ++--
>   drivers/power/supply/ucs1002_power.c               |   3 +-
>   drivers/s390/scsi/zfcp_aux.c                       |   9 +-
>   drivers/scsi/pm8001/pm8001_hwi.c                   |   2 +-
>   drivers/scsi/pm8001/pm80xx_hwi.c                   |   4 +-
>   drivers/scsi/qedf/qedf_io.c                        |  10 +-
>   drivers/scsi/qedf/qedf_main.c                      |   7 +-
>   drivers/spi/spi-nxp-fspi.c                         |   7 +
>   drivers/spi/spi-zynqmp-gqspi.c                     |  24 +-
>   drivers/target/target_core_device.c                |  11 +-
>   drivers/tty/n_gsm.c                                |   4 +-
>   drivers/tty/serial/8250/8250_port.c                |   5 +-
>   drivers/video/fbdev/Kconfig                        |   2 +-
>   drivers/watchdog/iTCO_wdt.c                        |  26 +-
>   fs/binfmt_elf_fdpic.c                              |   5 +-
>   fs/btrfs/extent_io.c                               |   8 +-
>   fs/btrfs/super.c                                   |   6 +-
>   fs/ext4/ext4.h                                     |   2 +-
>   fs/ext4/mballoc.c                                  | 138 ++++---
>   fs/nfs/direct.c                                    |   8 +-
>   fs/nfs/flexfilelayout/flexfilelayout.c             |   1 +
>   fs/nfs/nfs4proc.c                                  |   4 +-
>   fs/nfs/nfs4state.c                                 |  47 ++-
>   fs/nfs/sysfs.c                                     |  16 +-
>   fs/nfs/write.c                                     |  23 +-
>   fs/nilfs2/gcinode.c                                |   6 +-
>   fs/proc/task_nommu.c                               |  27 +-
>   include/linux/acpi.h                               |   5 +
>   include/linux/bpf.h                                |   2 +-
>   include/linux/btf_ids.h                            |   2 +-
>   include/linux/cgroup.h                             |   3 +-
>   include/linux/if_team.h                            |   2 +
>   include/linux/libata.h                             |   4 +-
>   include/linux/netfilter/nf_conntrack_sctp.h        |   1 +
>   include/linux/nfs_page.h                           |   4 +-
>   include/linux/seqlock.h                            | 104 ++---
>   include/net/netfilter/ipv4/nf_reject.h             |   4 +-
>   include/net/netfilter/ipv6/nf_reject.h             |   5 +-
>   include/net/netfilter/nf_tables.h                  | 136 +++----
>   include/net/tcp.h                                  |   6 +-
>   include/uapi/linux/bpf.h                           |   4 +-
>   include/uapi/linux/netfilter/nf_tables.h           |   2 +
>   kernel/bpf/queue_stack_maps.c                      |  21 +-
>   kernel/dma/debug.c                                 |  20 +-
>   kernel/sched/cpuacct.c                             |  84 ++--
>   kernel/trace/ring_buffer.c                         |  42 +-
>   kernel/trace/trace.c                               |  27 ++
>   kernel/trace/trace.h                               |   2 +
>   kernel/trace/trace_events.c                        |   6 +-
>   kernel/trace/trace_events_inject.c                 |   3 +-
>   mm/frame_vector.c                                  |   6 +-
>   net/bridge/br_forward.c                            |   4 +-
>   net/bridge/br_input.c                              |   4 +-
>   net/core/neighbour.c                               |   4 +-
>   net/dccp/ipv4.c                                    |   9 +-
>   net/dccp/ipv6.c                                    |   9 +-
>   net/ipv4/netfilter/ipt_REJECT.c                    |   3 +-
>   net/ipv4/netfilter/nf_reject_ipv4.c                |   6 +-
>   net/ipv4/netfilter/nft_reject_ipv4.c               |   3 +-
>   net/ipv4/route.c                                   |   4 +-
>   net/ipv4/tcp_input.c                               |  13 +
>   net/ipv4/tcp_output.c                              |   7 +-
>   net/ipv6/netfilter/ip6t_REJECT.c                   |   2 +-
>   net/ipv6/netfilter/nf_reject_ipv6.c                |   5 +-
>   net/ipv6/netfilter/nft_reject_ipv6.c               |   3 +-
>   net/l2tp/l2tp_ip6.c                                |   2 +-
>   net/ncsi/ncsi-aen.c                                |   5 +
>   net/netfilter/ipset/ip_set_core.c                  |  12 +-
>   net/netfilter/ipvs/ip_vs_sync.c                    |   4 +-
>   net/netfilter/nf_conntrack_proto_sctp.c            |  43 +-
>   net/netfilter/nf_tables_api.c                      | 436 ++++++++++++++++++---
>   net/netfilter/nf_tables_core.c                     |   2 +-
>   net/netfilter/nf_tables_trace.c                    |   6 +-
>   net/netfilter/nft_exthdr.c                         | 193 ++++++++-
>   net/netfilter/nft_flow_offload.c                   |   2 +-
>   net/netfilter/nft_payload.c                        |  10 +-
>   net/netfilter/nft_reject_inet.c                    |   6 +-
>   net/netfilter/nft_set_hash.c                       |  87 ++--
>   net/netfilter/nft_set_pipapo.c                     | 115 ++++--
>   net/netfilter/nft_set_rbtree.c                     | 199 ++++++----
>   net/netfilter/nft_synproxy.c                       |   4 +-
>   net/netfilter/nft_tproxy.c                         |   4 +-
>   net/nfc/llcp_core.c                                |   2 +
>   net/rds/rdma_transport.c                           |   8 +-
>   net/rds/tcp_connect.c                              |   2 +-
>   net/sctp/associola.c                               |   3 +-
>   net/sctp/socket.c                                  |   1 +
>   net/socket.c                                       |  29 +-
>   net/sunrpc/clnt.c                                  |   4 +-
>   net/tipc/crypto.c                                  |   4 +-
>   scripts/mod/file2alias.c                           |   2 +-
>   security/integrity/ima/Kconfig                     |  21 +-
>   security/smack/smack.h                             |   1 +
>   security/smack/smack_lsm.c                         |  65 ++-
>   sound/pci/hda/hda_intel.c                          |   1 +
>   sound/soc/fsl/imx-audmix.c                         |   2 +-
>   sound/soc/meson/axg-spdifin.c                      |  49 +--
>   tools/include/linux/btf_ids.h                      |   2 +-
>   tools/include/uapi/linux/bpf.h                     |   4 +-
>   tools/perf/util/Build                              |   6 +
>   tools/power/cpupower/Makefile                      |   8 +-
>   tools/power/cpupower/bench/Makefile                |   2 +-
>   .../ftrace/test.d/instances/instance-event.tc      |   2 +-
>   tools/testing/selftests/kselftest_deps.sh          |  77 +++-
>   tools/testing/selftests/net/tls.c                  |  11 +-
>   211 files changed, 2713 insertions(+), 1552 deletions(-)
> 
> 
> .
> 
