Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EEC17BE12D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 15:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377441AbjJINrp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 09:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377427AbjJINrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 09:47:43 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 011F494;
        Mon,  9 Oct 2023 06:47:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06EE9C433C8;
        Mon,  9 Oct 2023 13:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696859260;
        bh=w1mG/xq00c5zIGwwH/VZbNgMYSYP9IqTAB8syuFeWEc=;
        h=From:To:Cc:Subject:Date:From;
        b=Pvix1SWTZoWPX0LMpbr3+G+cGIZem3HbWGNO5wfbTQ+Nvl3sUBQ5AFAo2ke3ygGVy
         endeMJ681Y4bXLU4nfxS2v1z4S/4j5dfYZfpzUnqgz6hAbhBYH2xPfiG4FlOG2n6Rx
         qHnqlWeo/3S5NwxEiPl79iVSVRCo/WBh+YpZm1V4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: [PATCH 4.14 00/55] 4.14.327-rc1 review
Date:   Mon,  9 Oct 2023 15:05:59 +0200
Message-ID: <20231009130107.717692466@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.327-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.14.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.14.327-rc1
X-KernelTest-Deadline: 2023-10-11T13:01+00:00
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.14.327 release.
There are 55 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Wed, 11 Oct 2023 13:00:55 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.327-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.14.327-rc1

John David Anglin <dave@parisc-linux.org>
    parisc: Restore __ldcw_align for PA-RISC 2.0 processors

Shay Drory <shayd@nvidia.com>
    RDMA/mlx5: Fix NULL string error

Leon Romanovsky <leonro@nvidia.com>
    RDMA/cma: Fix truncation compilation warning in make_cma_ports

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

Gustavo A. R. Silva <gustavoars@kernel.org>
    wifi: mwifiex: Fix tlv_buf_left calculation

Dinghao Liu <dinghao.liu@zju.edu.cn>
    scsi: zfcp: Fix a double put in zfcp_port_enqueue()

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    media: dvb: symbol fixup for dvb_attach() - again

Niklas Cassel <niklas.cassel@wdc.com>
    ata: libata: disallow dev-initiated LPM transitions to unsupported states

Budimir Markovic <markovicbudimir@gmail.com>
    net/sched: sch_hfsc: Ensure inner classes have fsc curve

Shida Zhang <zhangshida@kylinos.cn>
    ext4: fix rec_len verify error

George Kennedy <george.kennedy@oracle.com>
    vc_screen: reload load of struct vc_data pointer in vcs_write() to avoid UAF

Greg Ungerer <gerg@kernel.org>
    fs: binfmt_elf_efpic: fix personality for ELF-FDPIC

Matthias Schiffer <mschiffer@universe-factory.net>
    ata: libata-sata: increase PMP SRST timeout to 10s

Damien Le Moal <dlemoal@kernel.org>
    ata: libata-core: Fix port and device removal

Damien Le Moal <dlemoal@kernel.org>
    ata: libata-core: Fix ata_port_request_pm() locking

Josef Bacik <josef@toxicpanda.com>
    btrfs: properly report 0 avail for very full file systems

Heiner Kallweit <hkallweit1@gmail.com>
    i2c: i801: unregister tco_pdev in i801_probe() error path

Niklas Cassel <niklas.cassel@wdc.com>
    ata: libata-scsi: ignore reserved bits for REPORT SUPPORTED OPERATION CODES

Pan Bian <bianpan2016@163.com>
    nilfs2: fix potential use after free in nilfs_gccache_submit_read_data()

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    serial: 8250_port: Check IRQ data before use

Mika Westerberg <mika.westerberg@linux.intel.com>
    watchdog: iTCO_wdt: Set NO_REBOOT if the watchdog is not already running

Mika Westerberg <mika.westerberg@linux.intel.com>
    watchdog: iTCO_wdt: No need to stop the timer in probe

Szuying Chen <chensiying21@gmail.com>
    ata: libahci: clear pending interrupt status

Hannes Reinecke <hare@suse.de>
    ata: ahci: Drop pointless VPRINTK() calls and convert the remaining ones

Thomas Zimmermann <tzimmermann@suse.de>
    fbdev/sh7760fb: Depend on FB=y

Niklas Cassel <niklas.cassel@wdc.com>
    ata: libata-eh: do not clear ATA_PFLAG_EH_PENDING in ata_eh_reset()

Zheng Yejian <zhengyejian1@huawei.com>
    ring-buffer: Avoid softlockup in ring_buffer_resize()

Zheng Yejian <zhengyejian1@huawei.com>
    selftests/ftrace: Correctly enable event in instance-event.tc

Helge Deller <deller@gmx.de>
    parisc: irq: Make irq_stack_union static to avoid sparse warning

Helge Deller <deller@gmx.de>
    parisc: iosapic.c: Fix sparse warnings

Helge Deller <deller@gmx.de>
    parisc: sba: Fix compile warning wrt list of SBA devices

Max Filippov <jcmvbkbc@gmail.com>
    xtensa: boot/lib: fix function prototypes

Randy Dunlap <rdunlap@infradead.org>
    xtensa: boot: don't add include-dirs

Timo Alho <talho@nvidia.com>
    clk: tegra: fix error return case for recalc_rate

Xiaoke Wang <xkernel.wang@foxmail.com>
    i2c: mux: demux-pinctrl: check the return value of devm_kstrdup()

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    gpio: tb10x: Fix an error handling path in tb10x_gpio_probe()

Ziyang Xuan <william.xuanziyang@huawei.com>
    team: fix null-ptr-deref when team device type is changed

Eric Dumazet <edumazet@google.com>
    dccp: fix dccp_v4_err()/dccp_v6_err() again

Kajol Jain <kjain@linux.ibm.com>
    powerpc/perf/hv-24x7: Update domain value check

Kyle Zeng <zengyhkyle@gmail.com>
    ipv4: fix null-deref in ipv4_link_failure

Trond Myklebust <trond.myklebust@hammerspace.com>
    NFS/pNFS: Report EINVAL errors from connect() to the server


-------------

Diffstat:

 Makefile                                           |  4 +-
 arch/parisc/include/asm/ldcw.h                     | 36 ++++++++------
 arch/parisc/include/asm/ropes.h                    |  3 ++
 arch/parisc/include/asm/spinlock_types.h           |  5 --
 arch/parisc/kernel/irq.c                           |  2 +-
 arch/powerpc/perf/hv-24x7.c                        |  2 +-
 arch/xtensa/boot/Makefile                          |  3 +-
 arch/xtensa/boot/lib/zmem.c                        |  5 +-
 drivers/ata/ahci.c                                 | 13 +++--
 drivers/ata/ahci_xgene.c                           |  4 --
 drivers/ata/libahci.c                              | 49 +++++++++---------
 drivers/ata/libata-core.c                          | 58 +++++++++++++++++-----
 drivers/ata/libata-eh.c                            | 13 ++---
 drivers/ata/libata-scsi.c                          |  2 +-
 drivers/base/regmap/regcache-rbtree.c              |  3 +-
 drivers/char/agp/parisc-agp.c                      |  2 -
 drivers/clk/tegra/clk-bpmp.c                       |  2 +-
 drivers/gpio/gpio-aspeed.c                         |  2 +-
 drivers/gpio/gpio-tb10x.c                          |  6 ++-
 drivers/i2c/busses/i2c-i801.c                      |  1 +
 drivers/i2c/muxes/i2c-demux-pinctrl.c              |  4 ++
 drivers/infiniband/core/cma_configfs.c             |  2 +-
 drivers/infiniband/hw/mlx4/sysfs.c                 |  2 +-
 drivers/infiniband/hw/mlx5/main.c                  |  2 +-
 drivers/media/dvb-frontends/sp8870.c               |  2 +-
 drivers/media/tuners/tuner-xc2028.c                |  2 +-
 drivers/mtd/ubi/build.c                            |  7 +++
 drivers/net/team/team.c                            | 10 +++-
 drivers/net/usb/smsc75xx.c                         |  4 +-
 drivers/net/wan/fsl_ucc_hdlc.c                     | 12 ++++-
 .../net/wireless/marvell/mwifiex/11n_rxreorder.c   |  4 +-
 drivers/net/wireless/marvell/mwifiex/sta_rx.c      | 16 +++---
 drivers/parisc/iosapic.c                           |  4 +-
 drivers/parisc/iosapic_private.h                   |  4 +-
 drivers/s390/scsi/zfcp_aux.c                       |  9 ++--
 drivers/target/target_core_device.c                | 11 ++--
 drivers/tty/serial/8250/8250_port.c                |  5 +-
 drivers/tty/vt/vc_screen.c                         | 11 +++-
 drivers/video/fbdev/Kconfig                        |  2 +-
 drivers/watchdog/iTCO_wdt.c                        | 26 ++++++++--
 fs/binfmt_elf_fdpic.c                              |  5 +-
 fs/btrfs/super.c                                   |  6 ++-
 fs/ext4/namei.c                                    | 26 ++++++----
 fs/nfs/flexfilelayout/flexfilelayout.c             |  1 +
 fs/nilfs2/gcinode.c                                |  6 +--
 include/linux/if_team.h                            |  2 +
 include/linux/libata.h                             |  6 ++-
 kernel/trace/ring_buffer.c                         |  2 +
 net/dccp/ipv4.c                                    |  9 +---
 net/dccp/ipv6.c                                    |  9 +---
 net/ipv4/route.c                                   |  4 +-
 net/ipv4/tcp_input.c                               | 13 +++++
 net/l2tp/l2tp_ip6.c                                |  2 +-
 net/sched/sch_hfsc.c                               |  2 +
 net/sctp/associola.c                               |  3 +-
 net/sctp/socket.c                                  |  1 +
 scripts/mod/file2alias.c                           |  2 +-
 tools/power/cpupower/Makefile                      |  8 +--
 tools/power/cpupower/bench/Makefile                |  2 +-
 .../ftrace/test.d/instances/instance-event.tc      |  2 +-
 60 files changed, 289 insertions(+), 176 deletions(-)


