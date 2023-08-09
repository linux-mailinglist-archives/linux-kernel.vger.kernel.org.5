Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F05DD775C6E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 13:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233748AbjHIL1Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 07:27:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233740AbjHIL1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 07:27:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEC88ED;
        Wed,  9 Aug 2023 04:27:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6BBEE632A7;
        Wed,  9 Aug 2023 11:27:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BB59C433C8;
        Wed,  9 Aug 2023 11:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691580432;
        bh=n1tUqYVvKIUJUKUp72uJrhQA7xipt0pE+oKlFG+BRnY=;
        h=From:To:Cc:Subject:Date:From;
        b=HdZV4icRvOv8zCCT3nGkdd4o3tSUbJX+Qe59GAvBEEwvlCkbVJUfwN519rRK1ccne
         3Td/ob2XYeXMBUn4o6JQ4nO1ANpJf3kDOCpdVMLg3Id3Tze6rSwCFEEXWP5bU+Dwuw
         FAteGTEzkhq6ZhjZzjkSmpouy8HeQ2tMaYTEmGOI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: [PATCH 5.4 000/154] 5.4.253-rc1 review
Date:   Wed,  9 Aug 2023 12:40:31 +0200
Message-ID: <20230809103636.887175326@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.253-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.4.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.4.253-rc1
X-KernelTest-Deadline: 2023-08-11T10:36+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 5.4.253 release.
There are 154 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Fri, 11 Aug 2023 10:36:10 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.253-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 5.4.253-rc1

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Revert "driver core: Annotate dev_err_probe() with __must_check"

Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
    drivers: core: fix kernel-doc markup for dev_err_probe()

Michał Mirosław <mirq-linux@rere.qmqm.pl>
    driver code: print symbolic error code

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    driver core: Annotate dev_err_probe() with __must_check

Xu Yang <xu.yang_2@nxp.com>
    ARM: dts: nxp/imx6sll: fix wrong property name in usbphy node

Andreas Kemnade <andreas@kemnade.info>
    ARM: dts: imx6sll: fixup of operating points

Peng Fan <peng.fan@nxp.com>
    ARM: dts: imx: add usb alias

Krzysztof Kozlowski <krzk@kernel.org>
    ARM: dts: imx: Align L2 cache-controller nodename with dtschema

Shengjiu Wang <shengjiu.wang@nxp.com>
    ARM: dts: imx6sll: Make ssi node name same as other platforms

Dinh Nguyen <dinguyen@kernel.org>
    arm64: dts: stratix10: fix incorrect I2C property for SCL signal

Xiubo Li <xiubli@redhat.com>
    ceph: defer stopping mdsc delayed_work

Jeff Layton <jlayton@kernel.org>
    ceph: use kill_anon_super helper

Jeff Layton <jlayton@kernel.org>
    ceph: show tasks waiting on caps in debugfs caps file

Johan Hovold <johan+linaro@kernel.org>
    PM: sleep: wakeirq: fix wake irq arming

Chunfeng Yun <chunfeng.yun@mediatek.com>
    PM / wakeirq: support enabling wake-up irq after runtime_suspend called

Sean Christopherson <seanjc@google.com>
    selftests/rseq: Play nice with binaries statically linked against glibc 2.35+

Michael Jeanson <mjeanson@efficios.com>
    selftests/rseq: check if libc rseq support is registered

Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
    powerpc/mm/altmap: Fix altmap boundary check

Roger Quadros <rogerq@kernel.org>
    mtd: rawnand: omap_elm: Fix incorrect type in assignment

Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
    test_firmware: return ENOMEM instead of ENOSPC on failed memory allocation

Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
    test_firmware: prevent race conditions by a correct implementation of locking

Jan Kara <jack@suse.cz>
    ext2: Drop fragment support

Jan Kara <jack@suse.cz>
    fs: Protect reconfiguration of sb read-write from racing writes

Alan Stern <stern@rowland.harvard.edu>
    net: usbnet: Fix WARNING in usbnet_start_xmit/usb_submit_urb

Sungwoo Kim <iam@sung-woo.kim>
    Bluetooth: L2CAP: Fix use-after-free in l2cap_sock_ready_cb

Prince Kumar Maurya <princekumarmaurya06@gmail.com>
    fs/sysv: Null check to prevent null-ptr-deref bug

Laszlo Ersek <lersek@redhat.com>
    net: tap_open(): set sk_uid from current_fsuid()

Laszlo Ersek <lersek@redhat.com>
    net: tun_chr_open(): set sk_uid from current_fsuid()

Arseniy Krasnov <AVKrasnov@sberdevices.ru>
    mtd: rawnand: meson: fix OOB available bytes for ECC

Olivier Maignial <olivier.maignial@hotmail.fr>
    mtd: spinand: toshiba: Fix ecc_get_status

Ross Maynard <bids.7405@bigpond.com>
    USB: zaurus: Add ID for A-300/B-500/C-700

Ilya Dryomov <idryomov@gmail.com>
    libceph: fix potential hang in ceph_osdc_notify()

Steffen Maier <maier@linux.ibm.com>
    scsi: zfcp: Defer fc_rport blocking until after ADISC response

Eric Dumazet <edumazet@google.com>
    tcp_metrics: fix data-race in tcpm_suck_dst() vs fastopen

Eric Dumazet <edumazet@google.com>
    tcp_metrics: annotate data-races around tm->tcpm_net

Eric Dumazet <edumazet@google.com>
    tcp_metrics: annotate data-races around tm->tcpm_vals[]

Eric Dumazet <edumazet@google.com>
    tcp_metrics: annotate data-races around tm->tcpm_lock

Eric Dumazet <edumazet@google.com>
    tcp_metrics: annotate data-races around tm->tcpm_stamp

Eric Dumazet <edumazet@google.com>
    tcp_metrics: fix addr_same() helper

Yue Haibing <yuehaibing@huawei.com>
    ip6mr: Fix skb_under_panic in ip6mr_cache_report()

Lin Ma <linma@zju.edu.cn>
    net: dcb: choose correct policy to parse DCB_ATTR_BCN

Dan Carpenter <dan.carpenter@linaro.org>
    net: ll_temac: fix error checking of irq_of_parse_and_map()

Yang Yingliang <yangyingliang@huawei.com>
    net: ll_temac: Switch to use dev_err_probe() helper

Andrzej Hajda <a.hajda@samsung.com>
    driver core: add device probe log helper

Tomas Glozar <tglozar@redhat.com>
    bpf: sockmap: Remove preempt_disable in sock_map_sk_acquire

valis <sec@valis.email>
    net/sched: cls_route: No longer copy tcf_result on update to avoid use-after-free

valis <sec@valis.email>
    net/sched: cls_fw: No longer copy tcf_result on update to avoid use-after-free

valis <sec@valis.email>
    net/sched: cls_u32: No longer copy tcf_result on update to avoid use-after-free

Eric Dumazet <edumazet@google.com>
    net: add missing data-race annotation for sk_ll_usec

Eric Dumazet <edumazet@google.com>
    net: add missing data-race annotations around sk->sk_peek_off

Eric Dumazet <edumazet@google.com>
    net: add missing READ_ONCE(sk->sk_rcvbuf) annotation

Eric Dumazet <edumazet@google.com>
    net: add missing READ_ONCE(sk->sk_sndbuf) annotation

Eric Dumazet <edumazet@google.com>
    net: add missing READ_ONCE(sk->sk_rcvlowat) annotation

Eric Dumazet <edumazet@google.com>
    net: annotate data-races around sk->sk_max_pacing_rate

Chengfeng Ye <dg573847474@gmail.com>
    mISDN: hfcpci: Fix potential deadlock on &hc->lock

Jamal Hadi Salim <jhs@mojatatu.com>
    net: sched: cls_u32: Fix match key mis-addressing

Georg Müller <georgmueller@gmx.net>
    perf test uprobe_from_different_cu: Skip if there is no gcc

Lin Ma <linma@zju.edu.cn>
    rtnetlink: let rtnl_bridge_setlink checks IFLA_BRIDGE_MODE length

Yuanjun Gong <ruc_gongyuanjun@163.com>
    net/mlx5e: fix return value check in mlx5e_ipsec_remove_trailer()

Zhengchao Shao <shaozhengchao@huawei.com>
    net/mlx5: DR, fix memory leak in mlx5dr_cmd_create_reformat_ctx

Heiko Carstens <hca@linux.ibm.com>
    KVM: s390: fix sthyi error handling

ndesaulniers@google.com <ndesaulniers@google.com>
    word-at-a-time: use the same return type for has_zero regardless of endianness

Bart Van Assche <bvanassche@acm.org>
    loop: Select I/O scheduler 'none' from inside add_disk()

Peter Zijlstra <peterz@infradead.org>
    perf: Fix function pointer case

D Scott Phillips <scott@os.amperecomputing.com>
    arm64: Fix bit-shifting UB in the MIDR_CPU_MODEL() macro

D Scott Phillips <scott@os.amperecomputing.com>
    arm64: Add AMPERE1 to the Spectre-BHB affected list

Thomas Petazzoni <thomas.petazzoni@bootlin.com>
    ASoC: cs42l51: fix driver to properly autoload with automatic module loading

Pedro Tammela <pctammela@mojatatu.com>
    net/sched: sch_qfq: account for stab overhead in qfq_enqueue

Filipe Manana <fdmanana@suse.com>
    btrfs: fix race between quota disable and quota assign ioctls

Marcos Paulo de Souza <mpdesouza@suse.com>
    btrfs: qgroup: return ENOTCONN instead of EINVAL when quotas are not enabled

Marcos Paulo de Souza <mpdesouza@suse.com>
    btrfs: qgroup: remove one-time use variables for quota_root checks

Rafael J. Wysocki <rafael.j.wysocki@intel.com>
    cpufreq: intel_pstate: Drop ACPI _PSS states table patching

Rafael J. Wysocki <rafael.j.wysocki@intel.com>
    ACPI: processor: perflib: Avoid updating frequency QoS unnecessarily

Rafael J. Wysocki <rafael.j.wysocki@intel.com>
    ACPI: processor: perflib: Use the "no limit" frequency QoS

Joe Thornber <ejt@redhat.com>
    dm cache policy smq: ensure IO doesn't prevent cleaner policy progress

Mark Brown <broonie@kernel.org>
    ASoC: wm8904: Fill the cache for WM8904_ADC_TEST_0 register

Stefan Haberland <sth@linux.ibm.com>
    s390/dasd: fix hanging device after quiesce/resume

Jason Wang <jasowang@redhat.com>
    virtio-net: fix race between set queues and probe

Filipe Manana <fdmanana@suse.com>
    btrfs: check if the transaction was aborted at btrfs_wait_for_commit()

Jonas Gorski <jonas.gorski@gmail.com>
    irq-bcm6345-l1: Do not assume a fixed block to cpu mapping

Alexander Steffen <Alexander.Steffen@infineon.com>
    tpm_tis: Explicitly check for error code

Filipe Manana <fdmanana@suse.com>
    btrfs: check for commit error at btrfs_attach_transaction_barrier()

Gilles Buloz <Gilles.Buloz@kontron.com>
    hwmon: (nct7802) Fix for temp6 (PECI1) processed even if PECI1 disabled

Zhang Shurong <zhang_shurong@foxmail.com>
    staging: ks7010: potential buffer overflow in ks_wlan_set_encode_ext()

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Documentation: security-bugs.rst: clarify CVE handling

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Documentation: security-bugs.rst: update preferences when dealing with the linux-distros group

Dan Carpenter <dan.carpenter@linaro.org>
    Revert "usb: xhci: tegra: Fix error check"

Ricardo Ribalda <ribalda@chromium.org>
    usb: xhci-mtk: set the dma max_seg_size

Łukasz Bartosik <lb@semihalf.com>
    USB: quirks: add quirk for Focusrite Scarlett

Guiting Shen <aarongt.shen@gmail.com>
    usb: ohci-at91: Fix the unhandle interrupt when resume

Jisheng Zhang <jszhang@kernel.org>
    usb: dwc3: don't reset device side if dwc3 was configured as host-only

Gratian Crisan <gratian.crisan@ni.com>
    usb: dwc3: pci: skip BYT GPIO lookup table for hardwired phy

Jakub Vanek <linuxtardis@gmail.com>
    Revert "usb: dwc3: core: Enable AutoRetry feature in the controller"

Marc Kleine-Budde <mkl@pengutronix.de>
    can: gs_usb: gs_can_close(): add missing set of CAN state to CAN_STATE_STOPPED

Johan Hovold <johan@kernel.org>
    USB: serial: simple: sort driver entries

Oliver Neukum <oneukum@suse.com>
    USB: serial: simple: add Kaufmann RKS+CAN VCP

Mohsen Tahmasebi <moh53n@moh53n.ir>
    USB: serial: option: add Quectel EC200A module support

Jerry Meng <jerry-meng@foxmail.com>
    USB: serial: option: support Quectel EM060K_128

Samuel Holland <samuel.holland@sifive.com>
    serial: sifive: Fix sifive_serial_console_setup() section

Ruihong Luo <colorsu1922@gmail.com>
    serial: 8250_dw: Preserve original value of DLF register

Zheng Yejian <zhengyejian1@huawei.com>
    tracing: Fix warning in trace_buffered_event_disable()

Zheng Yejian <zhengyejian1@huawei.com>
    ring-buffer: Fix wrong stat of cpu_buffer->read

Arnd Bergmann <arnd@arndb.de>
    ata: pata_ns87415: mark ns87560_tf_read static

Yu Kuai <yukuai3@huawei.com>
    dm raid: fix missing reconfig_mutex unlock in raid_ctr() error paths

Bart Van Assche <bvanassche@acm.org>
    block: Fix a source code comment in include/uapi/linux/blkzoned.h

Matus Gajdos <matuszpd@gmail.com>
    ASoC: fsl_spdif: Silence output on stop

Gaosheng Cui <cuigaosheng1@huawei.com>
    drm/msm: Fix IS_ERR_OR_NULL() vs NULL check in a5xx_submit_in_rb()

Rob Clark <robdclark@chromium.org>
    drm/msm/adreno: Fix snapshot BINDLESS_DATA size

Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
    drm/msm/dpu: drop enum dpu_core_perf_data_bus_id

Dan Carpenter <dan.carpenter@linaro.org>
    RDMA/mlx4: Make check for invalid flags stricter

Yuanjun Gong <ruc_gongyuanjun@163.com>
    benet: fix return value check in be_lancer_xmit_workarounds()

Lin Ma <linma@zju.edu.cn>
    net/sched: mqprio: Add length check for TCA_MQPRIO_{MAX/MIN}_RATE64

Vladimir Oltean <vladimir.oltean@nxp.com>
    net/sched: mqprio: add extack to mqprio_parse_nlattr()

Vladimir Oltean <vladimir.oltean@nxp.com>
    net/sched: mqprio: refactor nlattr parsing to a separate function

Maxim Mikityanskiy <maxtram95@gmail.com>
    platform/x86: msi-laptop: Fix rfkill out-of-sync on MSI Wind U100

Hangbin Liu <liuhangbin@gmail.com>
    team: reset team's flags when down link is P2P device

Hangbin Liu <liuhangbin@gmail.com>
    bonding: reset bond's flags when down link is P2P device

Stewart Smith <trawets@amazon.com>
    tcp: Reduce chance of collisions in inet6_hashfn().

Maciej Żenczykowski <maze@google.com>
    ipv6 addrconf: fix bug where deleting a mngtmpaddr can create a new temporary address

Yuanjun Gong <ruc_gongyuanjun@163.com>
    ethernet: atheros: fix return value check in atl1e_tso_csum()

Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
    phy: hisilicon: Fix an out of bounds check in hisi_inno_phy_probe()

Jiri Benc <jbenc@redhat.com>
    vxlan: calculate correct header length for GPE

Wang Ming <machel@vivo.com>
    i40e: Fix an NULL vs IS_ERR() bug for debugfs_create_dir()

Chao Yu <chao@kernel.org>
    ext4: fix to check return value of freeze_bdev() in ext4_shutdown()

Petr Pavlu <petr.pavlu@suse.com>
    keys: Fix linking a duplicate key to a keyring's assoc_array

David Howells <dhowells@redhat.com>
    uapi: General notification queue definitions

Nilesh Javali <njavali@marvell.com>
    scsi: qla2xxx: Array index may go out of bound

Ye Bin <yebin10@huawei.com>
    scsi: qla2xxx: Fix inconsistent format argument type in qla_os.c

Heiner Kallweit <hkallweit1@gmail.com>
    pwm: meson: fix handling of period/duty if greater than UINT_MAX

Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
    pwm: meson: Simplify duplicated per-channel tracking

Colin Ian King <colin.king@canonical.com>
    pwm: meson: Remove redundant assignment to variable fin_freq

Zheng Yejian <zhengyejian1@huawei.com>
    ftrace: Fix possible warning on checking all pages used in ftrace_process_locs()

Linus Torvalds <torvalds@linux-foundation.org>
    ftrace: Store the order of pages allocated in ftrace_page

Steven Rostedt (VMware) <rostedt@goodmis.org>
    ftrace: Check if pages were allocated before calling free_pages()

Steven Rostedt (VMware) <rostedt@goodmis.org>
    ftrace: Add information on number of page groups allocated

Alexander Aring <aahringo@redhat.com>
    fs: dlm: interrupt posix locks only when process is killed

Alexander Aring <aahringo@redhat.com>
    dlm: rearrange async condition return

Alexander Aring <aahringo@redhat.com>
    dlm: cleanup plock_op vs plock_xop

Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
    PCI/ASPM: Avoid link retraining race

Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
    PCI/ASPM: Factor out pcie_wait_for_retrain()

Bjorn Helgaas <bhelgaas@google.com>
    PCI/ASPM: Return 0 or -ETIMEDOUT from pcie_retrain_link()

Zhihao Cheng <chengzhihao1@huawei.com>
    ext4: Fix reusing stale buffer heads from last failed mounting

Chunguang Xu <brookxu@tencent.com>
    ext4: rename journal_dev to s_journal_dev inside ext4_sb_info

Filipe Manana <fdmanana@suse.com>
    btrfs: fix extent buffer leak after tree mod log failure at split_node()

Filipe Manana <fdmanana@suse.com>
    btrfs: fix race between quota disable and relocation

Qu Wenruo <wqu@suse.com>
    btrfs: qgroup: catch reserved space leaks at unmount time

Zheng Wang <zyytlz.wz@163.com>
    bcache: Fix __bch_btree_node_alloc to make the failure behavior consistent

Coly Li <colyli@suse.de>
    bcache: remove 'int n' from parameter list of bch_bucket_alloc_set()

Hans de Goede <hdegoede@redhat.com>
    gpio: tps68470: Make tps68470_gpio_output() always set the initial value

Zhihao Cheng <chengzhihao1@huawei.com>
    jbd2: Fix wrongly judgement for buffer head removing while doing checkpoint

Zhang Yi <yi.zhang@huawei.com>
    jbd2: recheck chechpointing non-dirty buffer

Zhang Yi <yi.zhang@huawei.com>
    jbd2: remove redundant buffer io error checks

Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
    jbd2: fix kernel-doc markups

Xianting Tian <xianting_tian@126.com>
    jbd2: fix incorrect code style


-------------

Diffstat:

 Documentation/admin-guide/security-bugs.rst        |  37 +++---
 Makefile                                           |   4 +-
 arch/arm/boot/dts/imx35.dtsi                       |   2 +-
 arch/arm/boot/dts/imx6qdl.dtsi                     |   6 +-
 arch/arm/boot/dts/imx6sl.dtsi                      |   5 +-
 arch/arm/boot/dts/imx6sll.dtsi                     |  34 ++---
 arch/arm/boot/dts/imx6sx.dtsi                      |   5 +-
 arch/arm/boot/dts/imx6ul.dtsi                      |   2 +
 arch/arm/boot/dts/imx7d.dtsi                       |   6 +
 arch/arm/boot/dts/imx7s.dtsi                       |   2 +
 .../boot/dts/altera/socfpga_stratix10_socdk.dts    |   2 +-
 arch/arm64/include/asm/cputype.h                   |   6 +-
 arch/arm64/kernel/cpu_errata.c                     |   6 +
 arch/powerpc/include/asm/word-at-a-time.h          |   2 +-
 arch/powerpc/mm/init_64.c                          |   3 +-
 arch/s390/kernel/sthyi.c                           |   6 +-
 arch/s390/kvm/intercept.c                          |   9 +-
 drivers/acpi/processor_perflib.c                   |  42 ++++--
 drivers/ata/pata_ns87415.c                         |   2 +-
 drivers/base/core.c                                |  44 +++++++
 drivers/base/power/power.h                         |   8 +-
 drivers/base/power/runtime.c                       |   6 +-
 drivers/base/power/wakeirq.c                       | 111 ++++++++++++----
 drivers/block/loop.c                               |   2 +-
 drivers/char/tpm/tpm_tis_core.c                    |  10 +-
 drivers/cpufreq/intel_pstate.c                     |  14 --
 drivers/gpio/gpio-tps68470.c                       |   6 +-
 drivers/gpu/drm/msm/adreno/a5xx_gpu.c              |   2 +-
 drivers/gpu/drm/msm/adreno/a6xx_gpu_state.h        |   2 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.h      |  13 --
 drivers/hwmon/nct7802.c                            |   2 +-
 drivers/infiniband/hw/mlx4/qp.c                    |  18 +--
 drivers/irqchip/irq-bcm6345-l1.c                   |  14 +-
 drivers/isdn/hardware/mISDN/hfcpci.c               |  10 +-
 drivers/md/bcache/alloc.c                          |  35 +++--
 drivers/md/bcache/bcache.h                         |   4 +-
 drivers/md/bcache/btree.c                          |   6 +-
 drivers/md/bcache/super.c                          |   2 +-
 drivers/md/dm-cache-policy-smq.c                   |  28 ++--
 drivers/md/dm-raid.c                               |   9 +-
 drivers/mtd/nand/raw/meson_nand.c                  |   3 +-
 drivers/mtd/nand/raw/omap_elm.c                    |  24 ++--
 drivers/mtd/nand/spi/toshiba.c                     |   4 +-
 drivers/net/bonding/bond_main.c                    |   5 +
 drivers/net/can/usb/gs_usb.c                       |   2 +
 drivers/net/ethernet/atheros/atl1e/atl1e_main.c    |   7 +-
 drivers/net/ethernet/emulex/benet/be_main.c        |   3 +-
 drivers/net/ethernet/intel/i40e/i40e_debugfs.c     |   2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c      |   2 +-
 .../mellanox/mlx5/core/en_accel/ipsec_rxtx.c       |   4 +-
 .../ethernet/mellanox/mlx5/core/steering/dr_cmd.c  |   5 +-
 drivers/net/ethernet/xilinx/ll_temac_main.c        |  16 +--
 drivers/net/tap.c                                  |   2 +-
 drivers/net/team/team.c                            |   9 ++
 drivers/net/tun.c                                  |   2 +-
 drivers/net/usb/cdc_ether.c                        |  21 +++
 drivers/net/usb/usbnet.c                           |   6 +
 drivers/net/usb/zaurus.c                           |  21 +++
 drivers/net/virtio_net.c                           |   4 +-
 drivers/net/vxlan.c                                |  22 ++--
 drivers/pci/pcie/aspm.c                            |  55 +++++---
 drivers/phy/hisilicon/phy-hisi-inno-usb2.c         |   2 +-
 drivers/platform/x86/msi-laptop.c                  |   8 +-
 drivers/pwm/pwm-meson.c                            |  27 ++--
 drivers/s390/block/dasd_ioctl.c                    |   1 +
 drivers/s390/scsi/zfcp_fc.c                        |   6 +-
 drivers/scsi/qla2xxx/qla_os.c                      |   5 +-
 drivers/staging/ks7010/ks_wlan_net.c               |   6 +-
 drivers/tty/serial/8250/8250_dwlib.c               |   6 +-
 drivers/tty/serial/sifive.c                        |   2 +-
 drivers/usb/core/quirks.c                          |   4 +
 drivers/usb/dwc3/core.c                            |  20 +--
 drivers/usb/dwc3/core.h                            |   3 -
 drivers/usb/dwc3/dwc3-pci.c                        |   6 +-
 drivers/usb/host/ohci-at91.c                       |   8 +-
 drivers/usb/host/xhci-mtk.c                        |   1 +
 drivers/usb/host/xhci-tegra.c                      |   8 +-
 drivers/usb/serial/option.c                        |   6 +
 drivers/usb/serial/usb-serial-simple.c             |  73 ++++++-----
 fs/btrfs/ctree.c                                   |   2 +
 fs/btrfs/disk-io.c                                 |   5 +
 fs/btrfs/ioctl.c                                   |   2 +
 fs/btrfs/qgroup.c                                  | 116 ++++++++++++-----
 fs/btrfs/qgroup.h                                  |   1 +
 fs/btrfs/transaction.c                             |  10 +-
 fs/ceph/caps.c                                     |  17 +++
 fs/ceph/debugfs.c                                  |  13 ++
 fs/ceph/mds_client.c                               |   5 +-
 fs/ceph/mds_client.h                               |  14 ++
 fs/ceph/super.c                                    |  14 +-
 fs/dlm/plock.c                                     | 100 ++++++++------
 fs/ext2/ext2.h                                     |  12 --
 fs/ext2/super.c                                    |  23 +---
 fs/ext4/ext4.h                                     |   2 +-
 fs/ext4/fsmap.c                                    |   8 +-
 fs/ext4/ioctl.c                                    |   5 +-
 fs/ext4/super.c                                    |  25 ++--
 fs/jbd2/checkpoint.c                               | 137 ++++++--------------
 fs/jbd2/journal.c                                  |  42 +++---
 fs/jbd2/transaction.c                              |  31 ++---
 fs/super.c                                         |  11 +-
 fs/sysv/itree.c                                    |   4 +
 include/asm-generic/word-at-a-time.h               |   2 +-
 include/linux/device.h                             |   3 +
 include/linux/jbd2.h                               |   2 +-
 include/linux/pm_wakeirq.h                         |   9 +-
 include/net/ipv6.h                                 |   8 +-
 include/net/vxlan.h                                |  13 +-
 include/uapi/linux/blkzoned.h                      |  10 +-
 include/uapi/linux/watch_queue.h                   |  55 ++++++++
 kernel/events/core.c                               |   8 +-
 kernel/trace/ftrace.c                              |  75 ++++++++---
 kernel/trace/ring_buffer.c                         |  22 ++--
 kernel/trace/trace.c                               |  21 ++-
 kernel/trace/trace.h                               |   2 +
 kernel/trace/trace_events.c                        |  14 +-
 lib/test_firmware.c                                |  49 ++++---
 net/bluetooth/l2cap_sock.c                         |   2 +
 net/ceph/osd_client.c                              |  20 ++-
 net/core/rtnetlink.c                               |   8 +-
 net/core/sock.c                                    |  21 +--
 net/core/sock_map.c                                |   2 -
 net/dcb/dcbnl.c                                    |   2 +-
 net/ipv4/tcp_metrics.c                             |  70 ++++++----
 net/ipv6/addrconf.c                                |  14 +-
 net/ipv6/ip6mr.c                                   |   2 +-
 net/sched/cls_fw.c                                 |   1 -
 net/sched/cls_route.c                              |   1 -
 net/sched/cls_u32.c                                |  57 +++++++-
 net/sched/sch_mqprio.c                             | 144 +++++++++++++--------
 net/sched/sch_qfq.c                                |   7 +-
 net/unix/af_unix.c                                 |   2 +-
 security/keys/request_key.c                        |  35 +++--
 sound/soc/codecs/cs42l51-i2c.c                     |   6 +
 sound/soc/codecs/cs42l51.c                         |   7 -
 sound/soc/codecs/cs42l51.h                         |   1 -
 sound/soc/codecs/wm8904.c                          |   3 +
 sound/soc/fsl/fsl_spdif.c                          |   2 +
 .../tests/shell/test_uprobe_from_different_cu.sh   |   8 +-
 tools/testing/selftests/rseq/rseq.c                |  31 ++++-
 140 files changed, 1444 insertions(+), 832 deletions(-)


