Return-Path: <linux-kernel+bounces-74750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 322A485D8A2
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 14:03:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9535F1F23C4A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 13:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3006E4F885;
	Wed, 21 Feb 2024 13:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pie14dPO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26BC469962;
	Wed, 21 Feb 2024 13:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708520604; cv=none; b=UW7I7XWvQ3Z4ms4APFDhQ035zcJhtymW7BgVA76rRAECJsCq0TTJEixlTlrKvOPCiLJ2pt4xdENHfJbi/QR3jMPDkfLvFBdQnhUsqHG+ZiyT9Wox8T3QHkPrnBL4i4UCgUwGj4CRUzqnBpIBkSEwEecfYu+kVaibvhm+CSAz25Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708520604; c=relaxed/simple;
	bh=BRMDxBmqWL2JdRh9+DGpwGwV2aHpre1oW6NmoruYEtE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=muq+CAcwz1kkEEDHety0EkRdYJ+ehtGB6K6KFYZ8SviZuIRUhKIcudVfR8hbv4bMHfzmV3sybwd9yIZy8aRxbT2pN58BfUT0JXftYcEMfYvr6stxLOR9s/6Z+1Zk+NCZY5GiR8W6YD+Nii+s0Zzv4dTdvEMaFt8j27tPoo0LUhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pie14dPO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E30D0C433F1;
	Wed, 21 Feb 2024 13:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708520603;
	bh=BRMDxBmqWL2JdRh9+DGpwGwV2aHpre1oW6NmoruYEtE=;
	h=From:To:Cc:Subject:Date:From;
	b=pie14dPOEIE6h/LaCJ919pEg+Y5MFdDwGDPYRr+4gQOTFYvCsnf3dDyQxUoU54GtG
	 xICv6AuLx9TVJ2iDGJ9bI+siYxcQ2pPRV/MPM3weh2SgnrMw2jqlr5nd6b7WNE85js
	 rArvzeP2ioDJrtUiqhBcsuABksooTUjHx/1JOhTg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org,
	akpm@linux-foundation.org,
	linux@roeck-us.net,
	shuah@kernel.org,
	patches@kernelci.org,
	lkft-triage@lists.linaro.org,
	pavel@denx.de,
	jonathanh@nvidia.com,
	f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net,
	rwarsow@gmx.de,
	conor@kernel.org,
	allen.lkml@gmail.com
Subject: [PATCH 6.1 000/206] 6.1.79-rc2 review
Date: Wed, 21 Feb 2024 14:03:19 +0100
Message-ID: <20240221130223.073542172@linuxfoundation.org>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.79-rc2.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.1.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.1.79-rc2
X-KernelTest-Deadline: 2024-02-23T13:02+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is the start of the stable review cycle for the 6.1.79 release.
There are 206 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Fri, 23 Feb 2024 13:01:46 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.79-rc2.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 6.1.79-rc2

Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
    fs/ntfs3: Add null pointer checks

Easwar Hariharan <eahariha@linux.microsoft.com>
    arm64: Subscribe Microsoft Azure Cobalt 100 to ARM Neoverse N2 errata

Mikulas Patocka <mpatocka@redhat.com>
    dm: limit the number of targets and parameter size area

Ryusuke Konishi <konishi.ryusuke@gmail.com>
    nilfs2: replace WARN_ONs for invalid DAT metadata block requests

Ryusuke Konishi <konishi.ryusuke@gmail.com>
    nilfs2: fix potential bug in end_buffer_async_write

Saravana Kannan <saravanak@google.com>
    of: property: Add in-ports/out-ports support to of_graph_get_port_parent()

Linus Torvalds <torvalds@linuxfoundation.org>
    sched/membarrier: reduce the ability to hammer on sys_membarrier

Peter Zijlstra <peterz@infradead.org>
    kbuild: Drop -Wdeclaration-after-statement

Peter Zijlstra <peterz@infradead.org>
    locking: Introduce __cleanup() based infrastructure

Peter Zijlstra <peterz@infradead.org>
    apparmor: Free up __cleanup() name

Peter Zijlstra <peterz@infradead.org>
    dmaengine: ioat: Free up __cleanup() name

Lokesh Gidra <lokeshgidra@google.com>
    userfaultfd: fix mmap_changing checking in mfill_atomic_hugetlb

Jiri Olsa <jolsa@kernel.org>
    bpf: Remove trace_printk_lock

Jiri Olsa <jolsa@kernel.org>
    bpf: Do cleanup in bpf_bprintf_cleanup only when needed

Jiri Olsa <jolsa@kernel.org>
    bpf: Add struct for bin_args arg in bpf_bprintf_prepare

Eric Dumazet <edumazet@google.com>
    net: prevent mss overflow in skb_segment()

Paulo Alcantara <pc@manguebit.com>
    smb: client: fix parsing of SMB3.1.1 POSIX create context

Paulo Alcantara <pc@manguebit.com>
    smb: client: fix potential OOBs in smb2_parse_contexts()

Mike Marciniszyn <mike.marciniszyn@intel.com>
    RDMA/irdma: Ensure iWarp QP queue memory is OS paged aligned

Davidlohr Bueso <dave@stgolabs.net>
    hrtimer: Ignore slack time for RT tasks in schedule_hrtimeout_range()

NeilBrown <neilb@suse.de>
    nfsd: don't take fi_lock in nfsd_break_deleg_cb()

NeilBrown <neilb@suse.de>
    nfsd: fix RELEASE_LOCKOWNER

Helge Deller <deller@gmx.de>
    parisc: Fix random data corruption from exception handler

Jozsef Kadlecsik <kadlec@netfilter.org>
    netfilter: ipset: Missing gc cancellations fixed

Jozsef Kadlecsik <kadlec@netfilter.org>
    netfilter: ipset: fix performance regression in swap operation

Damien Le Moal <dlemoal@kernel.org>
    block: fix partial zone append completion handling in req_bio_endio()

Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
    crypto: lib/mpi - Fix unexpected pointer access in mpi_ec_init

David Lin <yu-hao.lin@nxp.com>
    wifi: mwifiex: fix uninitialized firmware_stat

Johan Hovold <johan+linaro@kernel.org>
    arm64: dts: qcom: sm8150: fix USB SS wakeup

Johan Hovold <johan+linaro@kernel.org>
    arm64: dts: qcom: sdm845: fix USB SS wakeup

Stephan Gerhold <stephan@gerhold.net>
    arm64: dts: qcom: msm8916: Make blsp_dma controlled-remotely

Stephan Gerhold <stephan@gerhold.net>
    arm64: dts: qcom: msm8916: Enable blsp_dma by default

Sjoerd Simons <sjoerd@collabora.com>
    bus: moxtet: Add spi device table

David Lin <yu-hao.lin@nxp.com>
    wifi: mwifiex: add extra delay for firmware ready

Lukas Wunner <lukas@wunner.de>
    wifi: mwifiex: Support SD8978 chipset

Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
    ARM: dts: imx6q-apalis: add can power-up delay on ixora board

Junxiao Bi <junxiao.bi@oracle.com>
    md: bypass block throttle for superblock update

Audra Mitchell <audra@redhat.com>
    selftests/mm: Update va_high_addr_switch.sh to check CPU for la57 flag

Ryan Roberts <ryan.roberts@arm.com>
    selftests/mm: ksm_tests should only MADV_HUGEPAGE valid memory

Jann Horn <jannh@google.com>
    tls: fix NULL deref on tls_sw_splice_eof() with empty record

Herbert Xu <herbert@gondor.apana.org.au>
    xfrm: Silence warnings triggerable by bad packets

Herbert Xu <herbert@gondor.apana.org.au>
    xfrm: Use xfrm_state selector for BEET input

Steven Rostedt (Google) <rostedt@goodmis.org>
    tracing: Inform kmemleak of saved_cmdlines allocation

Oleg Nesterov <oleg@redhat.com>
    fs/proc: do_task_stat: move thread_group_cputime_adjusted() outside of lock_task_sighand()

Konrad Dybcio <konrad.dybcio@linaro.org>
    pmdomain: core: Move the unused cleanup to a _sync initcall

Oleksij Rempel <linux@rempel-privat.de>
    can: j1939: Fix UAF in j1939_sk_match_filter during setsockopt(SO_J1939_FILTER)

Ziqi Zhao <astrajoan@yahoo.com>
    can: j1939: prevent deadlock by changing j1939_socks_lock to rwlock

Maxime Jayat <maxime.jayat@mobile-devices.fr>
    can: netlink: Fix TDCO calculation using the old data bittiming

Nuno Sa <nuno.sa@analog.com>
    of: property: fix typo in io-channels

Prakash Sangappa <prakash.sangappa@oracle.com>
    mm: hugetlb pages should not be reserved by shmat() if SHM_NORESERVE

Oscar Salvador <osalvador@suse.de>
    fs,hugetlb: fix NULL pointer dereference in hugetlbs_fill_super

Rishabh Dave <ridave@redhat.com>
    ceph: prevent use-after-free in encode_cap_msg()

Shradha Gupta <shradhagupta@linux.microsoft.com>
    hv_netvsc: Register VF in netvsc_probe if NET_DEVICE_REGISTER missed

Sinthu Raja <sinthu.raja@ti.com>
    net: ethernet: ti: cpsw_new: enable mac_managed_pm to fix mdio

Alexandra Winter <wintera@linux.ibm.com>
    s390/qeth: Fix potential loss of L3-IP@ in case of network issues

Sinthu Raja <sinthu.raja@ti.com>
    net: ethernet: ti: cpsw: enable mac_managed_pm to fix mdio

Christian Brauner <brauner@kernel.org>
    fs: relax mount_setattr() permission checks

Daniel Bristot de Oliveira <bristot@kernel.org>
    tools/rtla: Fix Makefile compiler options for clang

Daniel Bristot de Oliveira <bristot@kernel.org>
    tools/rtla: Fix uninitialized bucket/data->bucket_size warning

John Kacur <jkacur@redhat.com>
    tools/rtla: Exit with EXIT_SUCCESS when help is invoked

limingming3 <limingming890315@gmail.com>
    tools/rtla: Replace setting prio with nice for SCHED_OTHER

Daniel Bristot de Oliveira <bristot@kernel.org>
    tools/rtla: Remove unused sched_getattr() function

Mario Limonciello <mario.limonciello@amd.com>
    ASoC: amd: yc: Add DMI quirk for Lenovo Ideapad Pro 5 16ARP8

Fred Ai <fred.ai@bayhubtech.com>
    mmc: sdhci-pci-o2micro: Fix a warm reboot issue that disk can't be detected by BIOS

Damien Le Moal <dlemoal@kernel.org>
    zonefs: Improve error handling

Marc Zyngier <maz@kernel.org>
    irqchip/gic-v3-its: Fix GICv4.1 VPE affinity update

Doug Berger <opendmb@gmail.com>
    irqchip/irq-brcmstb-l2: Add write memory barrier before exit

Johannes Berg <johannes.berg@intel.com>
    wifi: mac80211: reload info pointer in ieee80211_tx_dequeue()

Johannes Berg <johannes.berg@intel.com>
    wifi: cfg80211: fix wiphy delayed work queueing

Daniel de Villiers <daniel.devilliers@corigine.com>
    nfp: flower: prevent re-adding mac index for bonded port

Daniel Basilio <daniel.basilio@corigine.com>
    nfp: use correct macro for LengthSelect in BAR config

Kim Phillips <kim.phillips@amd.com>
    crypto: ccp - Fix null pointer dereference in __sev_platform_shutdown_locked

Ryusuke Konishi <konishi.ryusuke@gmail.com>
    nilfs2: fix hang in nilfs_lookup_dirty_data_buffers()

Ryusuke Konishi <konishi.ryusuke@gmail.com>
    nilfs2: fix data corruption in dsync block recovery for small block sizes

bo liu <bo.liu@senarytech.com>
    ALSA: hda/conexant: Add quirk for SWS JS201D

Eniac Zhang <eniac-xw.zhang@hp.com>
    ALSA: hda/realtek: fix mute/micmute LED For HP mt645

Alexander Stein <alexander.stein@ew.tq-group.com>
    mmc: slot-gpio: Allow non-sleeping GPIO ro

Jens Axboe <axboe@kernel.dk>
    io_uring/net: fix multishot accept overflow handling

Steve Wahl <steve.wahl@hpe.com>
    x86/mm/ident_map: Use gbpages only where full GB page should be mapped.

Mingwei Zhang <mizhang@google.com>
    KVM: x86/pmu: Fix type length error when reading pmu->fixed_ctr_ctrl

Andrei Vagin <avagin@google.com>
    x86/fpu: Stop relying on userspace for info to fault in xsave buffer

Aleksander Mazur <deweloper@wp.pl>
    x86/Kconfig: Transmeta Crusoe is CPU family 5, not 6

Shrikanth Hegde <sshegde@linux.ibm.com>
    powerpc/pseries: fix accuracy of stolen time

David Engraf <david.engraf@sysgo.com>
    powerpc/cputable: Add missing PPC_FEATURE_BOOKE on PPC64 Book-E

Naveen N Rao <naveen@kernel.org>
    powerpc/64: Set task pt_regs->link to the LR value on scv entry

Hugo Villeneuve <hvilleneuve@dimonoff.com>
    serial: max310x: prevent infinite while() loop in port startup

Hugo Villeneuve <hvilleneuve@dimonoff.com>
    serial: max310x: fail probe if clock crystal is unstable

Hugo Villeneuve <hvilleneuve@dimonoff.com>
    serial: max310x: improve crystal stable clock detection

Hugo Villeneuve <hvilleneuve@dimonoff.com>
    serial: max310x: set default value when reading clock ready bit

Hui Zhou <hui.zhou@corigine.com>
    nfp: flower: fix hardware offload for the transfer layer port

Vincent Donnefort <vdonnefort@google.com>
    ring-buffer: Clean ring_buffer_poll_wait() error return

Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
    hv_netvsc: Fix race condition between netvsc_probe and netvsc_remove

Tom Chung <chiahsuan.chung@amd.com>
    drm/amd/display: Preserve original aspect ratio in create stream

Nathan Chancellor <nathan@kernel.org>
    drm/amd/display: Increase frame-larger-than for all display_mode_vba files

Philip Yang <Philip.Yang@amd.com>
    drm/prime: Support page array >= 4GB

Rob Clark <robdclark@chromium.org>
    drm/msm: Wire up tlb ops

Herbert Xu <herbert@gondor.apana.org.au>
    xfrm: Remove inner/outer modes from input path

Herbert Xu <herbert@gondor.apana.org.au>
    xfrm: Remove inner/outer modes from output path

Fedor Pchelkin <pchelkin@ispras.ru>
    ksmbd: free aux buffer if ksmbd_iov_pin_rsp_read fails

Sean Young <sean@mess.org>
    media: rc: bpf attach/detach requires write permission

Randy Dunlap <rdunlap@infradead.org>
    iio: imu: bno055: serdev requires REGMAP

Nuno Sa <nuno.sa@analog.com>
    iio: imu: adis: ensure proper DMA alignment

Nuno Sa <nuno.sa@analog.com>
    iio: adc: ad_sigma_delta: ensure proper DMA alignment

Mario Limonciello <mario.limonciello@amd.com>
    iio: accel: bma400: Fix a compilation problem

Nuno Sa <nuno.sa@analog.com>
    iio: commom: st_sensors: ensure proper DMA alignment

Dinghao Liu <dinghao.liu@zju.edu.cn>
    iio: core: fix memleak in iio_device_register_sysfs

zhili.liu <zhili.liu@ucas.com.cn>
    iio: magnetometer: rm3100: add boundary check for the value read from RM3100_REG_TMRC

David Schiller <david.schiller@jku.at>
    staging: iio: ad5933: fix type mismatch regression

Steven Rostedt (Google) <rostedt@goodmis.org>
    tracing: Fix wasted memory in saved_cmdlines logic

Baokun Li <libaokun1@huawei.com>
    ext4: avoid bb_free and bb_fragments inconsistency in mb_free_blocks()

Baokun Li <libaokun1@huawei.com>
    ext4: fix double-free of blocks due to wrong extents moved_len

Ekansh Gupta <quic_ekangupt@quicinc.com>
    misc: fastrpc: Mark all sessions as invalid in cb_remove

Carlos Llamas <cmllamas@google.com>
    binder: signal epoll threads of self-work

Andy Chi <andy.chi@canonical.com>
    ALSA: hda/realtek: fix mute/micmute LEDs for HP ZBook Power

Vitaly Rodionov <vitalyr@opensource.cirrus.com>
    ALSA: hda/cs8409: Suppress vmaster control for Dolphin models

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    ASoC: codecs: wcd938x: handle deferred probe

Edson Juliano Drosdeck <edson.drosdeck@gmail.com>
    ALSA: hda/realtek: Enable headset mic on Vaio VJFE-ADL

Nathan Chancellor <nathan@kernel.org>
    modpost: Add '.ltext' and '.ltext.*' to TEXT_SECTIONS

Nathan Chancellor <nathan@kernel.org>
    um: Fix adding '-no-pie' for clang

Nathan Chancellor <nathan@kernel.org>
    modpost: Include '.text.*' in TEXT_SECTIONS

Masahiro Yamada <masahiroy@kernel.org>
    linux/init: remove __memexit* annotations

Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
    modpost: Don't let "driver"s reference .exit.*

Masahiro Yamada <masahiroy@kernel.org>
    modpost: propagate W=1 build option to modpost

Jan Beulich <jbeulich@suse.com>
    xen-netback: properly sync TX responses

Esben Haabendal <esben@geanix.com>
    net: stmmac: do not clear TBS enable bit on link up/down

Nikita Zhandarovich <n.zhandarovich@fintech.ru>
    net: hsr: remove WARN_ONCE() in send_hsr_supervision_frame()

Fedor Pchelkin <pchelkin@ispras.ru>
    nfc: nci: free rx_data_reassembly skb on NCI device cleanup

Nathan Chancellor <nathan@kernel.org>
    kbuild: Fix changing ELF file type for output of gen_btf for big endian

José Relvas <josemonsantorelvas@gmail.com>
    ALSA: hda/realtek: Apply headset jack quirk for non-bass alc287 thinkpads

Takashi Sakamoto <o-takashi@sakamocchi.jp>
    firewire: core: correct documentation of fw_csr_string() kernel API

Ondrej Mosnacek <omosnace@redhat.com>
    lsm: fix the logic in security_inode_getsecctx()

Sebastian Ott <sebott@redhat.com>
    drm/virtio: Set segment size for virtio_gpu device

Mario Limonciello <mario.limonciello@amd.com>
    Revert "drm/amd: flush any delayed gfxoff on suspend entry"

Lee Duncan <lduncan@suse.com>
    scsi: Revert "scsi: fcoe: Fix potential deadlock on &fip->ctlr_lock"

Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
    media: Revert "media: rkisp1: Drop IRQF_SHARED"

Geliang Tang <geliang@kernel.org>
    mptcp: check addrs list in userspace_pm_get_local_id

Paolo Abeni <pabeni@redhat.com>
    mptcp: drop the push_pending field

Matthieu Baerts (NGI0) <matttbe@kernel.org>
    selftests: mptcp: increase timeout to 30 min

Matthieu Baerts (NGI0) <matttbe@kernel.org>
    selftests: mptcp: add missing kconfig for NF Mangle

Matthieu Baerts (NGI0) <matttbe@kernel.org>
    selftests: mptcp: add missing kconfig for NF Filter in v6

Matthieu Baerts (NGI0) <matttbe@kernel.org>
    selftests: mptcp: add missing kconfig for NF Filter

Paolo Abeni <pabeni@redhat.com>
    mptcp: fix data re-injection from stale subflow

Paolo Abeni <pabeni@redhat.com>
    mptcp: get rid of msk->subflow

Radek Krejci <radek.krejci@oracle.com>
    modpost: trim leading spaces when processing source files list

Jean Delvare <jdelvare@suse.de>
    i2c: i801: Fix block process call transactions

Arnd Bergmann <arnd@arndb.de>
    i2c: pasemi: split driver into two separate modules

Michael Ellerman <mpe@ellerman.id.au>
    powerpc/kasan: Limit KASAN thread size increase to 32KB

Bibo Mao <maobibo@loongson.cn>
    irqchip/loongson-eiointc: Use correct struct type in eiointc_domain_alloc()

Viken Dadhaniya <quic_vdadhani@quicinc.com>
    i2c: qcom-geni: Correct I2C TRE sequence

Dan Carpenter <dan.carpenter@linaro.org>
    cifs: fix underflow in parse_server_interfaces()

Jiangfeng Xiao <xiaojiangfeng@huawei.com>
    powerpc/kasan: Fix addr error caused by page alignment

Saravana Kannan <saravanak@google.com>
    driver core: fw_devlink: Improve detection of overlapping cycles

Zhipeng Lu <alexious@zju.edu.cn>
    media: ir_toy: fix a memleak in irtoy_tx

Konrad Dybcio <konrad.dybcio@linaro.org>
    interconnect: qcom: sc8180x: Mark CO0 BCM keepalive

Uttkarsh Aggarwal <quic_uaggarwa@quicinc.com>
    usb: dwc3: gadget: Fix NULL pointer dereference in dwc3_gadget_suspend

yuan linyu <yuanlinyu@hihonor.com>
    usb: f_mass_storage: forbid async queue when shutdown happen

Oliver Neukum <oneukum@suse.com>
    USB: hub: check for alternate port before enabling A_ALT_HNP_SUPPORT

Christian A. Ehrhardt <lk@c--e.de>
    usb: ucsi_acpi: Fix command completion handling

Sean Anderson <sean.anderson@seco.com>
    usb: ulpi: Fix debugfs directory leak

Christian A. Ehrhardt <lk@c--e.de>
    usb: ucsi: Add missing ppm_lock

Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
    iio: hid-sensor-als: Return 0 for HID_USAGE_SENSOR_TIME_TIMESTAMP

Jason Gerecke <killertofu@gmail.com>
    HID: wacom: Do not register input devices until after hid_hw_start

Tatsunosuke Tobita <tatsunosuke.tobita@wacom.com>
    HID: wacom: generic: Avoid reporting a serial of '0' to userspace

Johan Hovold <johan+linaro@kernel.org>
    HID: i2c-hid-of: fix NULL-deref on failed power up

Luka Guzenko <l.guzenko@web.de>
    ALSA: hda/realtek: Enable Mute LED on HP Laptop 14-fq0xxx

David Senoner <seda18@rolmail.net>
    ALSA: hda/realtek: Fix the external mic not being recognised for Acer Swift 1 SF114-32

Helge Deller <deller@gmx.de>
    parisc: Prevent hung tasks when printing inventory on serial console

Techno Mooney <techno.mooney@gmail.com>
    ASoC: amd: yc: Add DMI quirk for MSI Bravo 15 C7VF

Mikulas Patocka <mpatocka@redhat.com>
    dm-crypt, dm-verity: disable tasklets

Michael Kelley <mhklinux@outlook.com>
    scsi: storvsc: Fix ring buffer size calculation

Zach O'Keefe <zokeefe@google.com>
    mm/writeback: fix possible divide-by-zero in wb_dirty_limits(), again

Masami Hiramatsu (Google) <mhiramat@kernel.org>
    tracing/trigger: Fix to return error if failed to alloc snapshot

Samuel Holland <samuel.holland@sifive.com>
    scs: add CONFIG_MMU dependency for vfree_atomic()

Ivan Vecera <ivecera@redhat.com>
    i40e: Fix waiting for queues of all VSIs to be disabled

Ivan Vecera <ivecera@redhat.com>
    i40e: Do not allow untrusted VF to remove administratively set MAC

Guenter Roeck <linux@roeck-us.net>
    MIPS: Add 'memory' clobber to csum_ipv6_magic() inline assembler

Arnd Bergmann <arnd@arndb.de>
    nouveau/svm: fix kvcalloc() argument order

Breno Leitao <leitao@debian.org>
    net: sysfs: Fix /sys/class/net/<iface> path for statistics

Alexey Khoroshilov <khoroshilov@ispras.ru>
    ASoC: rt5645: Fix deadlock in rt5645_jack_detect_work()

Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
    spi: ppc4xx: Drop write-only variable

Jakub Kicinski <kuba@kernel.org>
    net: tls: fix returned read length with async decrypt

Sabrina Dubroca <sd@queasysnail.net>
    net: tls: fix use-after-free with partial reads and async decrypt

Jakub Kicinski <kuba@kernel.org>
    tls: fix race between async notify and socket close

Jakub Kicinski <kuba@kernel.org>
    net: tls: factor out tls_*crypt_async_wait()

Sabrina Dubroca <sd@queasysnail.net>
    tls: extract context alloc/initialization out of tls_set_sw_offload

David Howells <dhowells@redhat.com>
    tls/sw: Use splice_eof() to flush

Horatiu Vultur <horatiu.vultur@microchip.com>
    lan966x: Fix crash when adding interface under a lag

Aaron Conole <aconole@redhat.com>
    net: openvswitch: limit the number of recursions from action sets

Saravana Kannan <saravanak@google.com>
    of: property: Improve finding the supplier of a remote-endpoint property

Dan Carpenter <dan.carpenter@linaro.org>
    wifi: iwlwifi: uninitialized variable in iwl_acpi_get_ppag_table()

Dan Carpenter <dan.carpenter@linaro.org>
    wifi: iwlwifi: Fix some error codes

Sean Christopherson <seanjc@google.com>
    KVM: selftests: Fix a semaphore imbalance in the dirty ring logging test

Gavin Shan <gshan@redhat.com>
    KVM: selftests: Clear dirty ring states between two modes in dirty_log_test

Christian A. Ehrhardt <lk@c--e.de>
    of: unittest: Fix compile in the non-dynamic case

Saravana Kannan <saravanak@google.com>
    driver core: Fix device_link_flag_is_sync_state_only()

Josef Bacik <josef@toxicpanda.com>
    btrfs: don't drop extent_map for free space inode on write error

Filipe Manana <fdmanana@suse.com>
    btrfs: reject encoded write if inode has nodatasum flag set

Filipe Manana <fdmanana@suse.com>
    btrfs: don't reserve space for checksums when writing to nocow files

David Sterba <dsterba@suse.com>
    btrfs: send: return EOPNOTSUPP on unknown flags

Boris Burkov <boris@bur.io>
    btrfs: forbid deleting live subvol qgroup

Qu Wenruo <wqu@suse.com>
    btrfs: do not ASSERT() if the newly created subvolume already got read

Boris Burkov <boris@bur.io>
    btrfs: forbid creating subvol qgroups

Filipe Manana <fdmanana@suse.com>
    btrfs: do not delete unused block group if it may be used soon

Filipe Manana <fdmanana@suse.com>
    btrfs: add and use helper to check if block group is used

Linus Torvalds <torvalds@linux-foundation.org>
    update workarounds for gcc "asm goto" issue

Linus Torvalds <torvalds@linux-foundation.org>
    work around gcc bugs with 'asm goto' with outputs


-------------

Diffstat:

 .../ABI/testing/sysfs-class-net-statistics         |  48 ++---
 Documentation/arm64/silicon-errata.rst             |   7 +
 .../bindings/net/wireless/marvell-8xxx.txt         |   4 +-
 Makefile                                           |  10 +-
 arch/Kconfig                                       |   1 +
 arch/arc/include/asm/jump_label.h                  |   4 +-
 arch/arm/boot/dts/imx6q-apalis-ixora-v1.2.dts      |   2 +
 arch/arm/include/asm/jump_label.h                  |   4 +-
 arch/arm64/boot/dts/qcom/apq8016-sbc.dts           |   4 -
 arch/arm64/boot/dts/qcom/msm8916.dtsi              |   2 +-
 arch/arm64/boot/dts/qcom/sdm845.dtsi               |   4 +-
 arch/arm64/boot/dts/qcom/sm8150.dtsi               |   4 +-
 arch/arm64/include/asm/alternative-macros.h        |   4 +-
 arch/arm64/include/asm/cputype.h                   |   4 +
 arch/arm64/include/asm/jump_label.h                |   4 +-
 arch/arm64/kernel/cpu_errata.c                     |   3 +
 arch/arm64/kernel/vdso32/Makefile                  |   2 -
 arch/csky/include/asm/jump_label.h                 |   4 +-
 arch/mips/include/asm/checksum.h                   |   3 +-
 arch/mips/include/asm/jump_label.h                 |   4 +-
 arch/parisc/Kconfig                                |   1 -
 arch/parisc/include/asm/assembly.h                 |   1 +
 arch/parisc/include/asm/extable.h                  |  64 ++++++
 arch/parisc/include/asm/jump_label.h               |   4 +-
 arch/parisc/include/asm/special_insns.h            |   6 +-
 arch/parisc/include/asm/uaccess.h                  |  48 +----
 arch/parisc/kernel/drivers.c                       |   3 +
 arch/parisc/kernel/unaligned.c                     |  44 ++--
 arch/parisc/mm/fault.c                             |  11 +-
 arch/powerpc/include/asm/bug.h                     |   2 +-
 arch/powerpc/include/asm/jump_label.h              |   4 +-
 arch/powerpc/include/asm/thread_info.h             |   2 +-
 arch/powerpc/include/asm/uaccess.h                 |   8 +-
 arch/powerpc/kernel/cpu_specs_e500mc.h             |   3 +-
 arch/powerpc/kernel/interrupt_64.S                 |   4 +-
 arch/powerpc/kernel/irq_64.c                       |   2 +-
 arch/powerpc/mm/kasan/init_32.c                    |   1 +
 arch/powerpc/platforms/pseries/lpar.c              |   8 +-
 arch/riscv/include/asm/jump_label.h                |   4 +-
 arch/s390/include/asm/jump_label.h                 |   4 +-
 arch/sparc/include/asm/jump_label.h                |   4 +-
 arch/um/Makefile                                   |   4 +-
 arch/um/include/asm/cpufeature.h                   |   2 +-
 arch/x86/Kconfig.cpu                               |   2 +-
 arch/x86/include/asm/cpufeature.h                  |   2 +-
 arch/x86/include/asm/jump_label.h                  |   6 +-
 arch/x86/include/asm/rmwcc.h                       |   2 +-
 arch/x86/include/asm/uaccess.h                     |  10 +-
 arch/x86/include/asm/virtext.h                     |  12 +-
 arch/x86/kernel/fpu/signal.c                       |  13 +-
 arch/x86/kvm/svm/svm_ops.h                         |   6 +-
 arch/x86/kvm/vmx/pmu_intel.c                       |   2 +-
 arch/x86/kvm/vmx/vmx.c                             |   8 +-
 arch/x86/kvm/vmx/vmx_ops.h                         |   6 +-
 arch/x86/mm/ident_map.c                            |  23 ++-
 arch/xtensa/include/asm/jump_label.h               |   4 +-
 block/blk-mq.c                                     |   9 +-
 drivers/android/binder.c                           |  10 +
 drivers/base/core.c                                |  15 +-
 drivers/base/power/domain.c                        |   2 +-
 drivers/bus/moxtet.c                               |   7 +
 drivers/crypto/ccp/sev-dev.c                       |  10 +-
 drivers/dma/ioat/dma.c                             |  12 +-
 drivers/firewire/core-device.c                     |   7 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |   1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c            |   9 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |   2 +
 drivers/gpu/drm/amd/display/dc/dml/Makefile        |   6 +-
 drivers/gpu/drm/drm_prime.c                        |   2 +-
 drivers/gpu/drm/msm/msm_iommu.c                    |  32 ++-
 drivers/gpu/drm/nouveau/nouveau_svm.c              |   2 +-
 drivers/gpu/drm/virtio/virtgpu_drv.c               |   1 +
 drivers/hid/i2c-hid/i2c-hid-of.c                   |   1 +
 drivers/hid/wacom_sys.c                            |  63 ++++--
 drivers/hid/wacom_wac.c                            |   9 +-
 drivers/i2c/busses/Makefile                        |   6 +-
 drivers/i2c/busses/i2c-i801.c                      |   4 +-
 drivers/i2c/busses/i2c-pasemi-core.c               |   5 +
 drivers/i2c/busses/i2c-qcom-geni.c                 |  16 +-
 drivers/iio/accel/Kconfig                          |   2 +
 drivers/iio/imu/bno055/Kconfig                     |   1 +
 drivers/iio/industrialio-core.c                    |   5 +-
 drivers/iio/light/hid-sensor-als.c                 |   1 +
 drivers/iio/magnetometer/rm3100-core.c             |  10 +-
 drivers/infiniband/hw/irdma/verbs.c                |   7 +
 drivers/interconnect/qcom/sc8180x.c                |   1 +
 drivers/irqchip/irq-brcmstb-l2.c                   |   5 +-
 drivers/irqchip/irq-gic-v3-its.c                   |  22 +-
 drivers/irqchip/irq-loongson-eiointc.c             |   2 +-
 drivers/md/dm-core.h                               |   2 +
 drivers/md/dm-crypt.c                              |  37 +---
 drivers/md/dm-ioctl.c                              |   3 +-
 drivers/md/dm-table.c                              |   9 +-
 drivers/md/dm-verity-target.c                      |  26 +--
 drivers/md/dm-verity.h                             |   1 -
 drivers/md/md.c                                    |   7 +-
 .../media/platform/rockchip/rkisp1/rkisp1-dev.c    |   2 +-
 drivers/media/rc/bpf-lirc.c                        |   6 +-
 drivers/media/rc/ir_toy.c                          |   2 +
 drivers/media/rc/lirc_dev.c                        |   5 +-
 drivers/media/rc/rc-core-priv.h                    |   2 +-
 drivers/misc/fastrpc.c                             |   2 +-
 drivers/mmc/core/slot-gpio.c                       |   6 +-
 drivers/mmc/host/sdhci-pci-o2micro.c               |  30 +++
 drivers/net/can/dev/netlink.c                      |   2 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c        |   2 +-
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |  38 +++-
 .../net/ethernet/microchip/lan966x/lan966x_lag.c   |   9 +-
 .../net/ethernet/netronome/nfp/flower/conntrack.c  |  24 ++-
 .../ethernet/netronome/nfp/flower/tunnel_conf.c    |   2 +-
 .../ethernet/netronome/nfp/nfpcore/nfp6000_pcie.c  |   6 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |   3 +
 drivers/net/ethernet/ti/cpsw.c                     |   2 +
 drivers/net/ethernet/ti/cpsw_new.c                 |   3 +
 drivers/net/hyperv/netvsc.c                        |   5 +-
 drivers/net/hyperv/netvsc_drv.c                    |  82 ++++++--
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c       |  15 +-
 drivers/net/wireless/marvell/mwifiex/Kconfig       |   5 +-
 drivers/net/wireless/marvell/mwifiex/sdio.c        |  46 ++++-
 drivers/net/wireless/marvell/mwifiex/sdio.h        |   3 +
 drivers/net/xen-netback/netback.c                  | 100 +++++----
 drivers/of/property.c                              |  18 +-
 drivers/of/unittest.c                              |  12 +-
 drivers/s390/net/qeth_l3_main.c                    |   9 +-
 drivers/scsi/fcoe/fcoe_ctlr.c                      |  20 +-
 drivers/scsi/storvsc_drv.c                         |  12 +-
 drivers/spi/spi-ppc4xx.c                           |   5 -
 drivers/staging/iio/impedance-analyzer/ad5933.c    |   2 +-
 drivers/tty/serial/max310x.c                       |  53 ++++-
 drivers/usb/common/ulpi.c                          |   2 +-
 drivers/usb/core/hub.c                             |  30 ++-
 drivers/usb/dwc3/gadget.c                          |   6 +-
 drivers/usb/gadget/function/f_mass_storage.c       |  20 +-
 drivers/usb/typec/ucsi/ucsi.c                      |   2 +
 drivers/usb/typec/ucsi/ucsi_acpi.c                 |  17 +-
 fs/btrfs/block-group.c                             |  49 ++++-
 fs/btrfs/block-group.h                             |   7 +
 fs/btrfs/delalloc-space.c                          |  29 ++-
 fs/btrfs/disk-io.c                                 |  13 +-
 fs/btrfs/inode.c                                   |  26 ++-
 fs/btrfs/ioctl.c                                   |   5 +
 fs/btrfs/qgroup.c                                  |  14 ++
 fs/btrfs/send.c                                    |   2 +-
 fs/ceph/caps.c                                     |   3 +-
 fs/ext4/mballoc.c                                  |  39 ++--
 fs/ext4/move_extent.c                              |   6 +-
 fs/hugetlbfs/inode.c                               |  19 +-
 fs/namespace.c                                     |  11 +-
 fs/nfsd/nfs4state.c                                |  37 ++--
 fs/nilfs2/dat.c                                    |  27 ++-
 fs/nilfs2/file.c                                   |   8 +-
 fs/nilfs2/recovery.c                               |   7 +-
 fs/nilfs2/segment.c                                |   8 +-
 fs/ntfs3/fsntfs.c                                  |  16 +-
 fs/ntfs3/index.c                                   |   3 +-
 fs/proc/array.c                                    |  10 +-
 fs/smb/client/cached_dir.c                         |   8 +-
 fs/smb/client/smb2ops.c                            |   2 +-
 fs/smb/client/smb2pdu.c                            |  95 +++++----
 fs/smb/client/smb2proto.h                          |  12 +-
 fs/smb/server/smb2pdu.c                            |   8 +-
 fs/zonefs/file.c                                   |  42 ++--
 fs/zonefs/super.c                                  |  66 +++---
 include/asm-generic/vmlinux.lds.h                  |   6 -
 include/linux/bpf.h                                |  12 +-
 include/linux/cleanup.h                            | 171 ++++++++++++++++
 include/linux/compiler-clang.h                     |   9 +
 include/linux/compiler-gcc.h                       |  20 ++
 include/linux/compiler_attributes.h                |   6 +
 include/linux/compiler_types.h                     |  11 +-
 include/linux/device.h                             |   7 +
 include/linux/file.h                               |   6 +
 include/linux/iio/adc/ad_sigma_delta.h             |   4 +-
 include/linux/iio/common/st_sensors.h              |   4 +-
 include/linux/iio/imu/adis.h                       |   3 +-
 include/linux/init.h                               |   3 -
 include/linux/irqflags.h                           |   7 +
 include/linux/mmc/sdio_ids.h                       |   1 +
 include/linux/mutex.h                              |   4 +
 include/linux/netfilter/ipset/ip_set.h             |   4 +
 include/linux/percpu.h                             |   4 +
 include/linux/preempt.h                            |   5 +
 include/linux/rcupdate.h                           |   3 +
 include/linux/rwsem.h                              |   8 +
 include/linux/sched/task.h                         |   2 +
 include/linux/slab.h                               |   3 +
 include/linux/spinlock.h                           |  31 +++
 include/linux/srcu.h                               |   5 +
 include/net/tls.h                                  |   5 -
 init/Kconfig                                       |   9 +
 io_uring/net.c                                     |   5 +-
 kernel/bpf/helpers.c                               |  67 +++---
 kernel/bpf/verifier.c                              |   3 +-
 kernel/sched/membarrier.c                          |   6 +
 kernel/time/hrtimer.c                              |  14 +-
 kernel/trace/bpf_trace.c                           |  56 +++--
 kernel/trace/ring_buffer.c                         |   2 +-
 kernel/trace/trace.c                               |  78 +++----
 kernel/trace/trace_events_trigger.c                |   6 +-
 lib/mpi/ec.c                                       |   3 +
 mm/page-writeback.c                                |   2 +-
 mm/userfaultfd.c                                   |  15 +-
 net/can/j1939/j1939-priv.h                         |   3 +-
 net/can/j1939/main.c                               |   2 +-
 net/can/j1939/socket.c                             |  46 +++--
 net/core/skbuff.c                                  |   3 +-
 net/hsr/hsr_device.c                               |   4 +-
 net/mac80211/tx.c                                  |   5 +-
 net/mptcp/pm_userspace.c                           |  13 +-
 net/mptcp/protocol.c                               |  24 +--
 net/mptcp/protocol.h                               |   4 +-
 net/netfilter/ipset/ip_set_bitmap_gen.h            |  14 +-
 net/netfilter/ipset/ip_set_core.c                  |  39 +++-
 net/netfilter/ipset/ip_set_hash_gen.h              |  19 +-
 net/netfilter/ipset/ip_set_list_set.c              |  13 +-
 net/netfilter/nft_set_pipapo_avx2.c                |   2 +-
 net/nfc/nci/core.c                                 |   4 +
 net/openvswitch/flow_netlink.c                     |  49 +++--
 net/tls/tls.h                                      |   1 +
 net/tls/tls_main.c                                 |   2 +
 net/tls/tls_sw.c                                   | 226 +++++++++++++--------
 net/wireless/core.c                                |   1 +
 net/xfrm/xfrm_input.c                              |  77 +++----
 net/xfrm/xfrm_output.c                             |  33 +--
 samples/bpf/asm_goto_workaround.h                  |   8 +-
 scripts/Makefile.modpost                           |   1 +
 scripts/checkpatch.pl                              |   2 +-
 scripts/link-vmlinux.sh                            |   9 +-
 scripts/mod/modpost.c                              |  43 ++--
 scripts/mod/sumversion.c                           |   7 +-
 security/apparmor/include/lib.h                    |   6 +-
 security/security.c                                |  14 +-
 sound/pci/hda/patch_conexant.c                     |  18 ++
 sound/pci/hda/patch_cs8409.c                       |   1 +
 sound/pci/hda/patch_realtek.c                      |  11 +-
 sound/soc/amd/yc/acp6x-mach.c                      |  14 ++
 sound/soc/codecs/rt5645.c                          |   1 +
 sound/soc/codecs/wcd938x.c                         |   2 +-
 tools/arch/x86/include/asm/rmwcc.h                 |   2 +-
 tools/include/linux/compiler_types.h               |   4 +-
 tools/testing/selftests/kvm/dirty_log_test.c       |  77 ++++---
 tools/testing/selftests/net/mptcp/config           |   3 +
 tools/testing/selftests/net/mptcp/settings         |   2 +-
 tools/testing/selftests/vm/ksm_tests.c             |   2 +-
 tools/testing/selftests/vm/va_128TBswitch.sh       |   6 +
 tools/tracing/rtla/Makefile                        |   7 +-
 tools/tracing/rtla/src/osnoise_hist.c              |   9 +-
 tools/tracing/rtla/src/osnoise_top.c               |   6 +-
 tools/tracing/rtla/src/timerlat_hist.c             |   9 +-
 tools/tracing/rtla/src/timerlat_top.c              |   6 +-
 tools/tracing/rtla/src/utils.c                     |  12 +-
 tools/tracing/rtla/src/utils.h                     |   2 +
 252 files changed, 2347 insertions(+), 1137 deletions(-)



