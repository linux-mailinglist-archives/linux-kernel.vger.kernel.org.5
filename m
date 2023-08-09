Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E50AE775D2F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 13:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234028AbjHILeh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 07:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234022AbjHILeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 07:34:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B48B173A;
        Wed,  9 Aug 2023 04:34:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 808CA634AB;
        Wed,  9 Aug 2023 11:34:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32728C433C8;
        Wed,  9 Aug 2023 11:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691580872;
        bh=SLOIBOXGeNr5wncmUKjUDGaFbZatYkT+sYR0vC30OJI=;
        h=From:To:Cc:Subject:Date:From;
        b=DztneuUCuyXcNu3yfqgBPubKDMG+hgMwxAXDjZxgeqv5/T6faoYheiBc8Mi2Ey7VG
         3P9ZBGTGwFCMXcoM7bHsrnHaRXOPtiQhMxPzSSWFAUsYnMHPsRzX2pJWKMf8uPELQj
         KWAFga4vjZ+Z9fw/QPZB1rcubHMFx+iMJ+6doRjA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: [PATCH 5.10 000/201] 5.10.190-rc1 review
Date:   Wed,  9 Aug 2023 12:40:02 +0200
Message-ID: <20230809103643.799166053@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.190-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.10.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.10.190-rc1
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

This is the start of the stable review cycle for the 5.10.190 release.
There are 201 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Fri, 11 Aug 2023 10:36:10 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.190-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 5.10.190-rc1

Xu Yang <xu.yang_2@nxp.com>
    ARM: dts: nxp/imx6sll: fix wrong property name in usbphy node

Andreas Kemnade <andreas@kemnade.info>
    ARM: dts: imx6sll: fixup of operating points

Peng Fan <peng.fan@nxp.com>
    ARM: dts: imx: add usb alias

Paul Fertser <fercerpav@gmail.com>
    wifi: mt76: mt7615: do not advertise 5 GHz on first phy of MT7615D (DBDC)

Gustavo A. R. Silva <gustavoars@kernel.org>
    mt76: mt7615: Fix fall-through warnings for Clang

Lorenzo Bianconi <lorenzo@kernel.org>
    mt76: move band capabilities in mt76_phy

Namjae Jeon <linkinjeon@kernel.org>
    exfat: check if filename entries exceeds max filename length

Yuezhang Mo <Yuezhang.Mo@sony.com>
    exfat: support dynamic allocate bh for exfat_entry_set_cache

Hyeongseok Kim <hyeongseok@gmail.com>
    exfat: speed up iterate/lookup by fixing start point of traversing cluster chain

Johan Hovold <johan+linaro@kernel.org>
    PM: sleep: wakeirq: fix wake irq arming

Chunfeng Yun <chunfeng.yun@mediatek.com>
    PM / wakeirq: support enabling wake-up irq after runtime_suspend called

Johan Hovold <johan+linaro@kernel.org>
    soundwire: fix enumeration completion

Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
    soundwire: bus: pm_runtime_request_resume on peripheral attachment

Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
    soundwire: bus: add better dev_dbg to track complete() calls

Sean Christopherson <seanjc@google.com>
    selftests/rseq: Play nice with binaries statically linked against glibc 2.35+

Michael Jeanson <mjeanson@efficios.com>
    selftests/rseq: check if libc rseq support is registered

Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
    powerpc/mm/altmap: Fix altmap boundary check

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    mtd: rawnand: fsl_upm: Fix an off-by one test in fun_exec_op()

Roger Quadros <rogerq@kernel.org>
    mtd: rawnand: omap_elm: Fix incorrect type in assignment

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

Douglas Anderson <dianders@chromium.org>
    tracing: Fix sleeping while atomic in kdb ftdump

Linus Torvalds <torvalds@linux-foundation.org>
    file: reinstate f_pos locking optimization for regular files

Guchun Chen <guchun.chen@amd.com>
    drm/ttm: check null pointer before accessing when swapping

Aleksa Sarai <cyphar@cyphar.com>
    open: make RESOLVE_CACHED correctly test for O_TMPFILE

Jiri Olsa <jolsa@kernel.org>
    bpf: Disable preemption in bpf_event_output

Laszlo Ersek <lersek@redhat.com>
    net: tap_open(): set sk_uid from current_fsuid()

Laszlo Ersek <lersek@redhat.com>
    net: tun_chr_open(): set sk_uid from current_fsuid()

Dinh Nguyen <dinguyen@kernel.org>
    arm64: dts: stratix10: fix incorrect I2C property for SCL signal

Arseniy Krasnov <AVKrasnov@sberdevices.ru>
    mtd: rawnand: meson: fix OOB available bytes for ECC

Olivier Maignial <olivier.maignial@hotmail.fr>
    mtd: spinand: toshiba: Fix ecc_get_status

Sungjong Seo <sj1557.seo@samsung.com>
    exfat: release s_lock before calling dir_emit()

gaoming <gaoming20@hihonor.com>
    exfat: use kvmalloc_array/kvfree instead of kmalloc_array/kfree

Xiubo Li <xiubli@redhat.com>
    ceph: defer stopping mdsc delayed_work

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

Jianbo Liu <jianbol@nvidia.com>
    net/mlx5: fs_core: Skip the FTs in the same FS_TYPE_PRIO_CHAINS fs_prio

Jianbo Liu <jianbol@nvidia.com>
    net/mlx5: fs_core: Make find_closest_ft more generic

Benjamin Poirier <bpoirier@nvidia.com>
    vxlan: Fix nexthop hash size

Yue Haibing <yuehaibing@huawei.com>
    ip6mr: Fix skb_under_panic in ip6mr_cache_report()

Alexandra Winter <wintera@linux.ibm.com>
    s390/qeth: Don't call dev_close/dev_open (DOWN/UP)

Lin Ma <linma@zju.edu.cn>
    net: dcb: choose correct policy to parse DCB_ATTR_BCN

Mark Brown <broonie@kernel.org>
    net: netsec: Ignore 'phy-mode' on SynQuacer in DT mode

Dan Carpenter <dan.carpenter@linaro.org>
    net: ll_temac: fix error checking of irq_of_parse_and_map()

Yang Yingliang <yangyingliang@huawei.com>
    net: ll_temac: Switch to use dev_err_probe() helper

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

Yuanjun Gong <ruc_gongyuanjun@163.com>
    net: dsa: fix value check in bcm_sf2_sw_probe()

Lin Ma <linma@zju.edu.cn>
    rtnetlink: let rtnl_bridge_setlink checks IFLA_BRIDGE_MODE length

Lin Ma <linma@zju.edu.cn>
    bpf: Add length check for SK_DIAG_BPF_STORAGE_REQ_MAP_FD parsing

Yuanjun Gong <ruc_gongyuanjun@163.com>
    net/mlx5e: fix return value check in mlx5e_ipsec_remove_trailer()

Zhengchao Shao <shaozhengchao@huawei.com>
    net/mlx5: DR, fix memory leak in mlx5dr_cmd_create_reformat_ctx

Ilan Peer <ilan.peer@intel.com>
    wifi: cfg80211: Fix return value in scan logic

Heiko Carstens <hca@linux.ibm.com>
    KVM: s390: fix sthyi error handling

ndesaulniers@google.com <ndesaulniers@google.com>
    word-at-a-time: use the same return type for has_zero regardless of endianness

Hugo Villeneuve <hvilleneuve@dimonoff.com>
    arm64: dts: imx8mn-var-som: add missing pull-up for onboard PHY reset pinmux

Bart Van Assche <bvanassche@acm.org>
    loop: Select I/O scheduler 'none' from inside add_disk()

Peter Zijlstra <peterz@infradead.org>
    perf: Fix function pointer case

Jens Axboe <axboe@kernel.dk>
    io_uring: gate iowait schedule on having pending requests

Nadav Amit <namit@vmware.com>
    x86/kprobes: Fix JNG/JNLE emulation

Masami Hiramatsu (Google) <mhiramat@kernel.org>
    x86/kprobes: Update kcb status flag after singlestepping

Wei Yongjun <weiyongjun1@huawei.com>
    x86/kprobes: Move 'inline' to the beginning of the kprobe_is_ss() declaration

Masami Hiramatsu <mhiramat@kernel.org>
    x86/kprobes: Fix to identify indirect jmp and others using range case

Masami Hiramatsu <mhiramat@kernel.org>
    x86/kprobes: Use int3 instead of debug trap for single-step

Masami Hiramatsu <mhiramat@kernel.org>
    x86/kprobes: Identify far indirect JMP correctly

Masami Hiramatsu <mhiramat@kernel.org>
    x86/kprobes: Retrieve correct opcode for group instruction

Masami Hiramatsu <mhiramat@kernel.org>
    x86/kprobes: Do not decode opcode in resume_execution()

Gustavo A. R. Silva <gustavoars@kernel.org>
    kprobes/x86: Fix fall-through warnings for Clang

Thomas Petazzoni <thomas.petazzoni@bootlin.com>
    ASoC: cs42l51: fix driver to properly autoload with automatic module loading

Jens Axboe <axboe@kernel.dk>
    io_uring: treat -EAGAIN for REQ_F_NOWAIT as final for io-wq

Matthieu Baerts <matthieu.baerts@tessares.net>
    selftests: mptcp: depend on SYN_COOKIES

Rafael J. Wysocki <rafael.j.wysocki@intel.com>
    cpufreq: intel_pstate: Drop ACPI _PSS states table patching

Rafael J. Wysocki <rafael.j.wysocki@intel.com>
    ACPI: processor: perflib: Avoid updating frequency QoS unnecessarily

Rafael J. Wysocki <rafael.j.wysocki@intel.com>
    ACPI: processor: perflib: Use the "no limit" frequency QoS

Christian König <christian.koenig@amd.com>
    drm/ttm: make ttm_bo_unpin more defensive

Joe Thornber <ejt@redhat.com>
    dm cache policy smq: ensure IO doesn't prevent cleaner policy progress

Xiubo Li <xiubli@redhat.com>
    ceph: never send metrics if disable_send_metrics is set

Mark Brown <broonie@kernel.org>
    ASoC: wm8904: Fill the cache for WM8904_ADC_TEST_0 register

Stefan Haberland <sth@linux.ibm.com>
    s390/dasd: fix hanging device after quiesce/resume

Jason Wang <jasowang@redhat.com>
    virtio-net: fix race between set queues and probe

Filipe Manana <fdmanana@suse.com>
    btrfs: check if the transaction was aborted at btrfs_wait_for_commit()

Larry Finger <Larry.Finger@lwfinger.net>
    staging: r8712: Fix memory leak in _r8712_init_xmit_priv()

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    staging: rtl8712: Use constants from <linux/ieee80211.h>

Sean Christopherson <seanjc@google.com>
    KVM: VMX: Don't fudge CR0 and CR4 for restricted L2 guest

Sean Christopherson <seanjc@google.com>
    KVM: nVMX: Do not clear CR3 load/store exiting bits if L1 wants 'em

Sean Christopherson <seanjc@google.com>
    KVM: VMX: Fold ept_update_paging_mode_cr0() back into vmx_set_cr0()

Sean Christopherson <seanjc@google.com>
    KVM: VMX: Invert handling of CR0.WP for EPT without unrestricted guest

Marc Zyngier <maz@kernel.org>
    irqchip/gic-v4.1: Properly lock VPEs when doing a directLPI invalidation

Jonas Gorski <jonas.gorski@gmail.com>
    irq-bcm6345-l1: Do not assume a fixed block to cpu mapping

Alexander Steffen <Alexander.Steffen@infineon.com>
    tpm_tis: Explicitly check for error code

Trond Myklebust <trond.myklebust@hammerspace.com>
    nfsd: Remove incorrect check in nfsd4_validate_stateid

Christian Brauner <brauner@kernel.org>
    file: always lock position for FMODE_ATOMIC_POS

Filipe Manana <fdmanana@suse.com>
    btrfs: check for commit error at btrfs_attach_transaction_barrier()

Gilles Buloz <Gilles.Buloz@kontron.com>
    hwmon: (nct7802) Fix for temp6 (PECI1) processed even if PECI1 disabled

Luka Guzenko <l.guzenko@web.de>
    ALSA: hda/relatek: Enable Mute LED on HP 250 G8

Chaoyuan Peng <hedonistsmith@gmail.com>
    tty: n_gsm: fix UAF in gsm_cleanup_mux

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

Johan Hovold <johan+linaro@kernel.org>
    serial: qcom-geni: drop bogus runtime pm state update

Zqiang <qiang.zhang1211@gmail.com>
    USB: gadget: Fix the memory leak in raw_gadget driver

Dan Carpenter <dan.carpenter@linaro.org>
    Revert "usb: gadget: tegra-xudc: Fix error check in tegra_xudc_powerdomain_init()"

Zheng Yejian <zhengyejian1@huawei.com>
    tracing: Fix warning in trace_buffered_event_disable()

Zheng Yejian <zhengyejian1@huawei.com>
    ring-buffer: Fix wrong stat of cpu_buffer->read

Arnd Bergmann <arnd@arndb.de>
    ata: pata_ns87415: mark ns87560_tf_read static

Yu Kuai <yukuai3@huawei.com>
    dm raid: protect md_stop() with 'reconfig_mutex'

Yu Kuai <yukuai3@huawei.com>
    dm raid: clean up four equivalent goto tags in raid_ctr()

Yu Kuai <yukuai3@huawei.com>
    dm raid: fix missing reconfig_mutex unlock in raid_ctr() error paths

Bart Van Assche <bvanassche@acm.org>
    block: Fix a source code comment in include/uapi/linux/blkzoned.h

Matus Gajdos <matuszpd@gmail.com>
    ASoC: fsl_spdif: Silence output on stop

Gaosheng Cui <cuigaosheng1@huawei.com>
    drm/msm: Fix IS_ERR_OR_NULL() vs NULL check in a5xx_submit_in_rb()

Thomas Bogendoerfer <tbogendoerfer@suse.de>
    RDMA/mthca: Fix crash when polling CQ for shared QPs

Rob Clark <robdclark@chromium.org>
    drm/msm/adreno: Fix snapshot BINDLESS_DATA size

Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
    drm/msm/dpu: drop enum dpu_core_perf_data_bus_id

Dan Carpenter <dan.carpenter@linaro.org>
    RDMA/mlx4: Make check for invalid flags stricter

Fedor Pchelkin <pchelkin@ispras.ru>
    tipc: stop tipc crypto on failure in tipc_node_create

Yuanjun Gong <ruc_gongyuanjun@163.com>
    tipc: check return value of pskb_trim()

Yuanjun Gong <ruc_gongyuanjun@163.com>
    benet: fix return value check in be_lancer_xmit_workarounds()

Lin Ma <linma@zju.edu.cn>
    net/sched: mqprio: Add length check for TCA_MQPRIO_{MAX/MIN}_RATE64

Vladimir Oltean <vladimir.oltean@nxp.com>
    net/sched: mqprio: add extack to mqprio_parse_nlattr()

Vladimir Oltean <vladimir.oltean@nxp.com>
    net/sched: mqprio: refactor nlattr parsing to a separate function

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: disallow rule addition to bound chain via NFTA_RULE_CHAIN_ID

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: skip immediate deactivate in _PREPARE_ERROR

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nftables: add helper function to validate set element data

Florian Westphal <fw@strlen.de>
    netfilter: nft_set_rbtree: fix overlap expiration walk

Maxim Mikityanskiy <maxtram95@gmail.com>
    platform/x86: msi-laptop: Fix rfkill out-of-sync on MSI Wind U100

Hangbin Liu <liuhangbin@gmail.com>
    team: reset team's flags when down link is P2P device

Hangbin Liu <liuhangbin@gmail.com>
    bonding: reset bond's flags when down link is P2P device

Jedrzej Jagielski <jedrzej.jagielski@intel.com>
    ice: Fix memory management in ice_ethtool_fdir.c

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

Roopa Prabhu <roopa@nvidia.com>
    vxlan: move to its own directory

Jijie Shao <shaojijie@huawei.com>
    net: hns3: fix wrong bw weight of disabled tc issue

Guangbin Huang <huangguangbin2@huawei.com>
    net: hns3: reconstruct function hclge_ets_validate()

Jiawen Wu <jiawenwu@trustnetic.com>
    net: phy: marvell10g: fix 88x3310 power up

Wang Ming <machel@vivo.com>
    i40e: Fix an NULL vs IS_ERR() bug for debugfs_create_dir()

Sakari Ailus <sakari.ailus@linux.intel.com>
    media: staging: atomisp: select V4L2_FWNODE

Adrien Thierry <athierry@redhat.com>
    phy: qcom-snps-femto-v2: properly enable ref clock

Adrien Thierry <athierry@redhat.com>
    phy: qcom-snps-femto-v2: keep cfg_ahb_clk enabled during runtime suspend

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    phy: qcom-snps: correct struct qcom_snps_hsphy kerneldoc

Yuan Can <yuancan@huawei.com>
    phy: qcom-snps: Use dev_err_probe() to simplify code

Chao Yu <chao@kernel.org>
    ext4: fix to check return value of freeze_bdev() in ext4_shutdown()

Heiner Kallweit <hkallweit1@gmail.com>
    pwm: meson: fix handling of period/duty if greater than UINT_MAX

Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
    pwm: meson: Simplify duplicated per-channel tracking

Masami Hiramatsu <mhiramat@kernel.org>
    tracing: Show real address for trace event arguments

Christian König <christian.koenig@amd.com>
    drm/ttm: never consider pinned BOs for eviction&swap

Christian König <christian.koenig@amd.com>
    drm/ttm: add ttm_bo_pin()/ttm_bo_unpin() v2

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

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    i2c: nomadik: Remove a useless call in the remove function

Andi Shyti <andi.shyti@kernel.org>
    i2c: nomadik: Use devm_clk_get_enabled()

Andi Shyti <andi.shyti@kernel.org>
    i2c: nomadik: Remove unnecessary goto label

Markus Elfring <elfring@users.sourceforge.net>
    i2c: Improve size determinations

Markus Elfring <elfring@users.sourceforge.net>
    i2c: Delete error messages for failed memory allocations

Filipe Manana <fdmanana@suse.com>
    btrfs: fix extent buffer leak after tree mod log failure at split_node()

Filipe Manana <fdmanana@suse.com>
    btrfs: fix race between quota disable and relocation

Hans de Goede <hdegoede@redhat.com>
    gpio: tps68470: Make tps68470_gpio_output() always set the initial value

Ondrej Mosnacek <omosnace@redhat.com>
    io_uring: don't audit the capability check in io_uring_create()

Claudio Imbrenda <imbrenda@linux.ibm.com>
    KVM: s390: pv: fix index value of replaced ASCE


-------------

Diffstat:

 Documentation/admin-guide/security-bugs.rst        |  37 +-
 Makefile                                           |   4 +-
 arch/arm/boot/dts/imx6qdl.dtsi                     |   4 +
 arch/arm/boot/dts/imx6sl.dtsi                      |   3 +
 arch/arm/boot/dts/imx6sll.dtsi                     |  26 +-
 arch/arm/boot/dts/imx6sx.dtsi                      |   3 +
 arch/arm/boot/dts/imx6ul.dtsi                      |   2 +
 arch/arm/boot/dts/imx7d.dtsi                       |   6 +
 arch/arm/boot/dts/imx7s.dtsi                       |   2 +
 .../boot/dts/altera/socfpga_stratix10_socdk.dts    |   2 +-
 .../dts/altera/socfpga_stratix10_socdk_nand.dts    |   2 +-
 arch/arm64/boot/dts/freescale/imx8mn-var-som.dtsi  |   2 +-
 arch/powerpc/include/asm/word-at-a-time.h          |   2 +-
 arch/powerpc/mm/init_64.c                          |   3 +-
 arch/s390/kernel/sthyi.c                           |   6 +-
 arch/s390/kvm/intercept.c                          |   9 +-
 arch/s390/mm/gmap.c                                |   1 +
 arch/x86/include/asm/kprobes.h                     |  24 +-
 arch/x86/kernel/kprobes/core.c                     | 639 +++++++++++++--------
 arch/x86/kernel/traps.c                            |   3 -
 arch/x86/kvm/vmx/vmx.c                             |  87 +--
 drivers/acpi/processor_perflib.c                   |  42 +-
 drivers/ata/pata_ns87415.c                         |   2 +-
 drivers/base/power/power.h                         |   8 +-
 drivers/base/power/runtime.c                       |   6 +-
 drivers/base/power/wakeirq.c                       | 111 +++-
 drivers/block/loop.c                               |   3 +-
 drivers/char/tpm/tpm_tis_core.c                    |  10 +-
 drivers/cpufreq/intel_pstate.c                     |  14 -
 drivers/gpio/gpio-tps68470.c                       |   6 +-
 drivers/gpu/drm/msm/adreno/a5xx_gpu.c              |   2 +-
 drivers/gpu/drm/msm/adreno/a6xx_gpu_state.h        |   2 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.h      |  13 -
 drivers/gpu/drm/ttm/ttm_bo.c                       |  16 +-
 drivers/gpu/drm/ttm/ttm_bo_util.c                  |   2 +-
 drivers/hwmon/nct7802.c                            |   2 +-
 drivers/i2c/busses/i2c-ibm_iic.c                   |   4 +-
 drivers/i2c/busses/i2c-nomadik.c                   |  42 +-
 drivers/i2c/busses/i2c-sh7760.c                    |   3 +-
 drivers/i2c/busses/i2c-tiny-usb.c                  |   4 +-
 drivers/infiniband/hw/mlx4/qp.c                    |  18 +-
 drivers/infiniband/hw/mthca/mthca_qp.c             |   2 +-
 drivers/irqchip/irq-bcm6345-l1.c                   |  14 +-
 drivers/irqchip/irq-gic-v3-its.c                   |  75 ++-
 drivers/isdn/hardware/mISDN/hfcpci.c               |  10 +-
 drivers/md/dm-cache-policy-smq.c                   |  28 +-
 drivers/md/dm-raid.c                               |  20 +-
 drivers/md/md.c                                    |   2 +
 drivers/mtd/nand/raw/fsl_upm.c                     |   2 +-
 drivers/mtd/nand/raw/meson_nand.c                  |   3 +-
 drivers/mtd/nand/raw/omap_elm.c                    |  24 +-
 drivers/mtd/nand/spi/toshiba.c                     |   4 +-
 drivers/net/Makefile                               |   2 +-
 drivers/net/bonding/bond_main.c                    |   5 +
 drivers/net/can/usb/gs_usb.c                       |   2 +
 drivers/net/dsa/bcm_sf2.c                          |   8 +-
 drivers/net/ethernet/atheros/atl1e/atl1e_main.c    |   7 +-
 drivers/net/ethernet/emulex/benet/be_main.c        |   3 +-
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c |  60 +-
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c  |   3 +-
 drivers/net/ethernet/intel/i40e/i40e_debugfs.c     |   2 +-
 drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c  |  26 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c      |   2 +-
 .../mellanox/mlx5/core/en_accel/ipsec_rxtx.c       |   4 +-
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.c  | 105 +++-
 .../ethernet/mellanox/mlx5/core/steering/dr_cmd.c  |   5 +-
 drivers/net/ethernet/socionext/netsec.c            |  11 +
 drivers/net/ethernet/xilinx/ll_temac_main.c        |  16 +-
 drivers/net/phy/marvell10g.c                       |   7 +
 drivers/net/tap.c                                  |   2 +-
 drivers/net/team/team.c                            |   9 +
 drivers/net/tun.c                                  |   2 +-
 drivers/net/usb/cdc_ether.c                        |  21 +
 drivers/net/usb/usbnet.c                           |   6 +
 drivers/net/usb/zaurus.c                           |  21 +
 drivers/net/virtio_net.c                           |   4 +-
 drivers/net/vxlan/Makefile                         |   7 +
 drivers/net/{vxlan.c => vxlan/vxlan_core.c}        |  23 +-
 drivers/net/wireless/mediatek/mt76/mac80211.c      |   8 +-
 drivers/net/wireless/mediatek/mt76/mt76.h          |   2 +-
 drivers/net/wireless/mediatek/mt76/mt7603/eeprom.c |   2 +-
 drivers/net/wireless/mediatek/mt76/mt7615/dma.c    |   2 +-
 drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c |  22 +-
 drivers/net/wireless/mediatek/mt76/mt76x0/eeprom.c |   6 +-
 drivers/net/wireless/mediatek/mt76/mt76x0/init.c   |   4 +-
 drivers/net/wireless/mediatek/mt76/mt76x0/phy.c    |   4 +-
 .../net/wireless/mediatek/mt76/mt76x02_eeprom.c    |   8 +-
 drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c |   8 +-
 drivers/net/wireless/mediatek/mt76/mt7915/init.c   |   5 +-
 drivers/pci/pcie/aspm.c                            |  55 +-
 drivers/phy/hisilicon/phy-hisi-inno-usb2.c         |   2 +-
 drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c      |  86 +--
 drivers/platform/x86/msi-laptop.c                  |   8 +-
 drivers/pwm/pwm-meson.c                            |  25 +-
 drivers/s390/block/dasd_ioctl.c                    |   1 +
 drivers/s390/net/qeth_core.h                       |   1 -
 drivers/s390/net/qeth_core_main.c                  |   2 -
 drivers/s390/net/qeth_l2_main.c                    |   9 +-
 drivers/s390/net/qeth_l3_main.c                    |   8 +-
 drivers/s390/scsi/zfcp_fc.c                        |   6 +-
 drivers/soundwire/bus.c                            |  31 +-
 drivers/staging/ks7010/ks_wlan_net.c               |   6 +-
 drivers/staging/media/atomisp/Kconfig              |   1 +
 drivers/staging/rtl8712/ieee80211.c                |  12 +-
 drivers/staging/rtl8712/rtl871x_ioctl_linux.c      |   8 +-
 drivers/staging/rtl8712/rtl871x_mlme.c             |  10 +-
 drivers/staging/rtl8712/rtl871x_xmit.c             |  46 +-
 drivers/staging/rtl8712/wifi.h                     |  15 -
 drivers/staging/rtl8712/xmit_linux.c               |   6 +
 drivers/tty/n_gsm.c                                |   4 +-
 drivers/tty/serial/8250/8250_dwlib.c               |   6 +-
 drivers/tty/serial/qcom_geni_serial.c              |   7 -
 drivers/tty/serial/sifive.c                        |   2 +-
 drivers/usb/core/quirks.c                          |   4 +
 drivers/usb/dwc3/core.c                            |  20 +-
 drivers/usb/dwc3/core.h                            |   3 -
 drivers/usb/dwc3/dwc3-pci.c                        |   6 +-
 drivers/usb/gadget/legacy/raw_gadget.c             |  12 +-
 drivers/usb/gadget/udc/tegra-xudc.c                |   8 +-
 drivers/usb/host/ohci-at91.c                       |   8 +-
 drivers/usb/host/xhci-mtk.c                        |   1 +
 drivers/usb/host/xhci-tegra.c                      |   8 +-
 drivers/usb/serial/option.c                        |   6 +
 drivers/usb/serial/usb-serial-simple.c             |  73 +--
 fs/btrfs/ctree.c                                   |   2 +
 fs/btrfs/qgroup.c                                  |  18 +-
 fs/btrfs/transaction.c                             |  10 +-
 fs/ceph/mds_client.c                               |   4 +-
 fs/ceph/mds_client.h                               |   5 +
 fs/ceph/metric.c                                   |   2 +-
 fs/ceph/super.c                                    |  10 +
 fs/dlm/plock.c                                     | 100 ++--
 fs/exfat/balloc.c                                  |   6 +-
 fs/exfat/dir.c                                     |  70 ++-
 fs/exfat/exfat_fs.h                                |   7 +-
 fs/exfat/namei.c                                   |   9 +-
 fs/ext2/ext2.h                                     |  12 -
 fs/ext2/super.c                                    |  23 +-
 fs/ext4/ioctl.c                                    |   5 +-
 fs/file.c                                          |  24 +-
 fs/nfsd/nfs4state.c                                |   2 -
 fs/open.c                                          |   2 +-
 fs/super.c                                         |  11 +-
 fs/sysv/itree.c                                    |   4 +
 include/asm-generic/word-at-a-time.h               |   2 +-
 include/drm/ttm/ttm_bo_api.h                       |  28 +
 include/linux/pm_wakeirq.h                         |   9 +-
 include/linux/trace_events.h                       |   4 +
 include/net/ipv6.h                                 |   8 +-
 include/net/vxlan.h                                |  17 +-
 include/trace/trace_events.h                       |   2 +-
 include/uapi/linux/blkzoned.h                      |  10 +-
 io_uring/io_uring.c                                |  33 +-
 kernel/events/core.c                               |   8 +-
 kernel/trace/bpf_trace.c                           |   6 +-
 kernel/trace/ring_buffer.c                         |  22 +-
 kernel/trace/trace.c                               |  76 ++-
 kernel/trace/trace.h                               |   2 +
 kernel/trace/trace_events.c                        |  14 +-
 kernel/trace/trace_output.c                        |  12 +-
 net/bluetooth/l2cap_sock.c                         |   2 +
 net/ceph/osd_client.c                              |  20 +-
 net/core/bpf_sk_storage.c                          |   5 +-
 net/core/rtnetlink.c                               |   8 +-
 net/core/sock.c                                    |  21 +-
 net/core/sock_map.c                                |   2 -
 net/dcb/dcbnl.c                                    |   2 +-
 net/ipv4/tcp_metrics.c                             |  70 ++-
 net/ipv6/addrconf.c                                |  14 +-
 net/ipv6/ip6mr.c                                   |   2 +-
 net/netfilter/nf_tables_api.c                      |  20 +-
 net/netfilter/nft_immediate.c                      |  27 +-
 net/netfilter/nft_set_rbtree.c                     |  20 +-
 net/sched/cls_fw.c                                 |   1 -
 net/sched/cls_route.c                              |   1 -
 net/sched/cls_u32.c                                |  57 +-
 net/sched/sch_mqprio.c                             | 144 +++--
 net/tipc/crypto.c                                  |   3 +-
 net/tipc/node.c                                    |   2 +-
 net/unix/af_unix.c                                 |   2 +-
 net/wireless/scan.c                                |   2 +-
 sound/pci/hda/patch_realtek.c                      |   1 +
 sound/soc/codecs/cs42l51-i2c.c                     |   6 +
 sound/soc/codecs/cs42l51.c                         |   7 -
 sound/soc/codecs/cs42l51.h                         |   1 -
 sound/soc/codecs/wm8904.c                          |   3 +
 sound/soc/fsl/fsl_spdif.c                          |   2 +
 .../tests/shell/test_uprobe_from_different_cu.sh   |   8 +-
 tools/testing/selftests/net/mptcp/config           |   1 +
 tools/testing/selftests/rseq/rseq.c                |  31 +-
 190 files changed, 2159 insertions(+), 1206 deletions(-)


