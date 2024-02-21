Return-Path: <linux-kernel+bounces-74788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E5185DA13
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 14:26:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FE7C1F21668
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 13:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15E5B7C081;
	Wed, 21 Feb 2024 13:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EU8EjL2b"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C6B7BB14;
	Wed, 21 Feb 2024 13:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708521907; cv=none; b=kpE76WJL9LWFvLxk/3BIlSTY2zN45BpVanj3diZLVAxpXzRl4XVyjXh7s+dHl6eXW8Ms40uyvfAS6Dv33zGALkzoOFtjTg1DYvLQuh3YUa7Q5sb9JNUC8QFd6+aKxbTRQMuh8eqiqqfWhPDtU4kAthh/CFsy0DEPnumrsYai+G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708521907; c=relaxed/simple;
	bh=Obha6iozwK83ZXgUY/A24Uq6vAgmldeBG4t8Vh2Y7DQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MPl12RZnX9oArWTnINTjk6mjx3I2r1MVxQFd1qlAoEWFCnxvNgvddWyLvrxriNV+avvHuZeqAXO5ZVqLqVkt/pmsljOY2yNuOihSJ4tLCMsxP9Uc5D0Ga1D4IgLLgumTj2QDigvIPnh5VxQkgmQnj+KWxxgwaQ3P3wUacsF926c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EU8EjL2b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B82FAC433F1;
	Wed, 21 Feb 2024 13:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708521906;
	bh=Obha6iozwK83ZXgUY/A24Uq6vAgmldeBG4t8Vh2Y7DQ=;
	h=From:To:Cc:Subject:Date:From;
	b=EU8EjL2bhP2NRXkcPD1NYQwXRaO/6rGgzur63qlYVNU4kcPD4ZBcGKkWZnpNQRyOG
	 swxQ66/bnr1BFucwxxq50tyyGzP51tcQ3yOcr8isTA/UcGVzmbW+MoZUuulBW/QSPU
	 0w2dn6dXoJ1JhytRZ1fL+Fil6qkY0JRwfFe+O9uc=
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
Subject: [PATCH 5.15 000/476] 5.15.149-rc1 review
Date: Wed, 21 Feb 2024 14:00:51 +0100
Message-ID: <20240221130007.738356493@linuxfoundation.org>
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
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.149-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.15.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.15.149-rc1
X-KernelTest-Deadline: 2024-02-23T13:00+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is the start of the stable review cycle for the 5.15.149 release.
There are 476 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Fri, 23 Feb 2024 12:59:02 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.149-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 5.15.149-rc1

Thinh Nguyen <Thinh.Nguyen@synopsys.com>
    usb: dwc3: gadget: Ignore End Transfer delay on teardown

Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
    media: Revert "media: rkisp1: Drop IRQF_SHARED"

Wesley Cheng <quic_wcheng@quicinc.com>
    usb: dwc3: gadget: Execute gadget stop after halting the controller

Thinh Nguyen <Thinh.Nguyen@synopsys.com>
    usb: dwc3: gadget: Don't delay End Transfer on delayed_status

Peter Suti <peter.suti@streamunlimited.com>
    staging: fbtft: core: set smem_len before fb_deferred_io_init call

Kees Cook <keescook@chromium.org>
    smb3: Replace smb2pdu 1-element arrays with flex-arrays

Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
    fs/ntfs3: Add null pointer checks

Florian Fainelli <florian.fainelli@broadcom.com>
    net: bcmgenet: Fix EEE implementation

Samasth Norway Ananda <samasth.norway.ananda@oracle.com>
    Revert "selftests/bpf: Test tail call counting with bpf2bpf and data on stack"

Konrad Dybcio <konrad.dybcio@linaro.org>
    drm/msm/dsi: Enable runtime PM

Douglas Anderson <dianders@chromium.org>
    PM: runtime: Have devm_pm_runtime_enable() handle pm_runtime_dont_use_autosuspend()

Easwar Hariharan <eahariha@linux.microsoft.com>
    arm64: Subscribe Microsoft Azure Cobalt 100 to ARM Neoverse N2 errata

Mikulas Patocka <mpatocka@redhat.com>
    dm: limit the number of targets and parameter size area

Ryusuke Konishi <konishi.ryusuke@gmail.com>
    nilfs2: replace WARN_ONs for invalid DAT metadata block requests

Ryusuke Konishi <konishi.ryusuke@gmail.com>
    nilfs2: fix potential bug in end_buffer_async_write

Linus Torvalds <torvalds@linuxfoundation.org>
    sched/membarrier: reduce the ability to hammer on sys_membarrier

Jozsef Kadlecsik <kadlec@netfilter.org>
    netfilter: ipset: Missing gc cancellations fixed

Eric Dumazet <edumazet@google.com>
    net: prevent mss overflow in skb_segment()

Davidlohr Bueso <dave@stgolabs.net>
    hrtimer: Ignore slack time for RT tasks in schedule_hrtimeout_range()

Jozsef Kadlecsik <kadlec@netfilter.org>
    netfilter: ipset: fix performance regression in swap operation

Carlos Llamas <cmllamas@google.com>
    scripts/decode_stacktrace.sh: optionally use LLVM utilities

Miguel Ojeda <ojeda@kernel.org>
    scripts: decode_stacktrace: demangle Rust symbols

Schspa Shi <schspa@gmail.com>
    scripts/decode_stacktrace.sh: support old bash version

Nam Cao <namcao@linutronix.de>
    fbdev: flush deferred IO before closing

Takashi Iwai <tiwai@suse.de>
    fbdev: Fix incorrect page mapping clearance at fb_deferred_io_release()

Takashi Iwai <tiwai@suse.de>
    fbdev: Fix invalid page access after closing deferred I/O devices

Thomas Zimmermann <tzimmermann@suse.de>
    fbdev: Rename pagelist to pagereflist for deferred I/O

Thomas Zimmermann <tzimmermann@suse.de>
    fbdev: Track deferred-I/O pages in pageref struct

Chuansheng Liu <chuansheng.liu@intel.com>
    fbdev: defio: fix the pagelist corruption

Thomas Zimmermann <tzimmermann@suse.de>
    fbdev: Don't sort deferred-I/O pages by default

Thomas Zimmermann <tzimmermann@suse.de>
    fbdev/defio: Early-out if page is already enlisted

Lino Sanfilippo <l.sanfilippo@kunbus.com>
    serial: 8250_exar: Set missing rs485_supported flag

Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
    serial: 8250_exar: Fill in rs485_supported

Wesley Cheng <quic_wcheng@quicinc.com>
    usb: dwc3: gadget: Queue PM runtime idle on disconnect event

Wesley Cheng <quic_wcheng@quicinc.com>
    usb: dwc3: gadget: Handle EP0 request dequeuing properly

Wesley Cheng <quic_wcheng@quicinc.com>
    usb: dwc3: gadget: Refactor EP0 forced stall/restart into a separate API

Wesley Cheng <quic_wcheng@quicinc.com>
    usb: dwc3: gadget: Stall and restart EP0 if host is unresponsive

Wesley Cheng <quic_wcheng@quicinc.com>
    usb: dwc3: gadget: Submit endxfer command if delayed during disconnect

Wesley Cheng <quic_wcheng@quicinc.com>
    usb: dwc3: gadget: Force sending delayed status during soft disconnect

Mayank Rana <quic_mrana@quicinc.com>
    usb: dwc3: Fix ep0 handling when getting reset while doing control transfer

Thinh Nguyen <Thinh.Nguyen@synopsys.com>
    usb: dwc3: gadget: Delay issuing End Transfer

Thinh Nguyen <Thinh.Nguyen@synopsys.com>
    usb: dwc3: gadget: Only End Transfer for ep0 data phase

Thinh Nguyen <Thinh.Nguyen@synopsys.com>
    usb: dwc3: ep0: Don't prepare beyond Setup stage

Thinh Nguyen <Thinh.Nguyen@synopsys.com>
    usb: dwc3: gadget: Wait for ep0 xfers to complete during dequeue

Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
    crypto: lib/mpi - Fix unexpected pointer access in mpi_ec_init

David Lin <yu-hao.lin@nxp.com>
    wifi: mwifiex: fix uninitialized firmware_stat

Sjoerd Simons <sjoerd@collabora.com>
    bus: moxtet: Add spi device table

David Lin <yu-hao.lin@nxp.com>
    wifi: mwifiex: add extra delay for firmware ready

Lukas Wunner <lukas@wunner.de>
    wifi: mwifiex: Support SD8978 chipset

Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
    mwifiex: Select firmware based on strapping

Christian König <christian.koenig@amd.com>
    dma-buf: add dma_fence_timestamp helper

Kuniyuki Iwashima <kuniyu@amazon.com>
    af_unix: Fix task hung while purging oob_skb in GC.

Steven Rostedt (Google) <rostedt@goodmis.org>
    tracing: Inform kmemleak of saved_cmdlines allocation

Konrad Dybcio <konrad.dybcio@linaro.org>
    pmdomain: core: Move the unused cleanup to a _sync initcall

Oleksij Rempel <linux@rempel-privat.de>
    can: j1939: Fix UAF in j1939_sk_match_filter during setsockopt(SO_J1939_FILTER)

Ziqi Zhao <astrajoan@yahoo.com>
    can: j1939: prevent deadlock by changing j1939_socks_lock to rwlock

Nuno Sa <nuno.sa@analog.com>
    of: property: fix typo in io-channels

Prakash Sangappa <prakash.sangappa@oracle.com>
    mm: hugetlb pages should not be reserved by shmat() if SHM_NORESERVE

Rishabh Dave <ridave@redhat.com>
    ceph: prevent use-after-free in encode_cap_msg()

Sinthu Raja <sinthu.raja@ti.com>
    net: ethernet: ti: cpsw_new: enable mac_managed_pm to fix mdio

Alexandra Winter <wintera@linux.ibm.com>
    s390/qeth: Fix potential loss of L3-IP@ in case of network issues

Sinthu Raja <sinthu.raja@ti.com>
    net: ethernet: ti: cpsw: enable mac_managed_pm to fix mdio

Marc Zyngier <maz@kernel.org>
    irqchip/gic-v3-its: Fix GICv4.1 VPE affinity update

Doug Berger <opendmb@gmail.com>
    irqchip/irq-brcmstb-l2: Add write memory barrier before exit

Johannes Berg <johannes.berg@intel.com>
    wifi: mac80211: reload info pointer in ieee80211_tx_dequeue()

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

Alexander Stein <alexander.stein@ew.tq-group.com>
    mmc: slot-gpio: Allow non-sleeping GPIO ro

Steve Wahl <steve.wahl@hpe.com>
    x86/mm/ident_map: Use gbpages only where full GB page should be mapped.

Aleksander Mazur <deweloper@wp.pl>
    x86/Kconfig: Transmeta Crusoe is CPU family 5, not 6

Naveen N Rao <naveen@kernel.org>
    powerpc/64: Set task pt_regs->link to the LR value on scv entry

Hugo Villeneuve <hvilleneuve@dimonoff.com>
    serial: max310x: fail probe if clock crystal is unstable

Hugo Villeneuve <hvilleneuve@dimonoff.com>
    serial: max310x: improve crystal stable clock detection

Hugo Villeneuve <hvilleneuve@dimonoff.com>
    serial: max310x: set default value when reading clock ready bit

Vincent Donnefort <vdonnefort@google.com>
    ring-buffer: Clean ring_buffer_poll_wait() error return

Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
    hv_netvsc: Fix race condition between netvsc_probe and netvsc_remove

Philip Yang <Philip.Yang@amd.com>
    drm/prime: Support page array >= 4GB

Sean Young <sean@mess.org>
    media: rc: bpf attach/detach requires write permission

Mario Limonciello <mario.limonciello@amd.com>
    iio: accel: bma400: Fix a compilation problem

Dinghao Liu <dinghao.liu@zju.edu.cn>
    iio: core: fix memleak in iio_device_register_sysfs

zhili.liu <zhili.liu@ucas.com.cn>
    iio: magnetometer: rm3100: add boundary check for the value read from RM3100_REG_TMRC

David Schiller <david.schiller@jku.at>
    staging: iio: ad5933: fix type mismatch regression

Steven Rostedt (Google) <rostedt@goodmis.org>
    tracing: Fix wasted memory in saved_cmdlines logic

Baokun Li <libaokun1@huawei.com>
    ext4: fix double-free of blocks due to wrong extents moved_len

Ekansh Gupta <quic_ekangupt@quicinc.com>
    misc: fastrpc: Mark all sessions as invalid in cb_remove

Carlos Llamas <cmllamas@google.com>
    binder: signal epoll threads of self-work

Vitaly Rodionov <vitalyr@opensource.cirrus.com>
    ALSA: hda/cs8409: Suppress vmaster control for Dolphin models

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    ASoC: codecs: wcd938x: handle deferred probe

Edson Juliano Drosdeck <edson.drosdeck@gmail.com>
    ALSA: hda/realtek: Enable headset mic on Vaio VJFE-ADL

Jan Beulich <jbeulich@suse.com>
    xen-netback: properly sync TX responses

Nikita Zhandarovich <n.zhandarovich@fintech.ru>
    net: hsr: remove WARN_ONCE() in send_hsr_supervision_frame()

Fedor Pchelkin <pchelkin@ispras.ru>
    nfc: nci: free rx_data_reassembly skb on NCI device cleanup

Nathan Chancellor <nathan@kernel.org>
    kbuild: Fix changing ELF file type for output of gen_btf for big endian

Takashi Sakamoto <o-takashi@sakamocchi.jp>
    firewire: core: correct documentation of fw_csr_string() kernel API

Ondrej Mosnacek <omosnace@redhat.com>
    lsm: fix the logic in security_inode_getsecctx()

Mario Limonciello <mario.limonciello@amd.com>
    Revert "drm/amd: flush any delayed gfxoff on suspend entry"

Lee Duncan <lduncan@suse.com>
    scsi: Revert "scsi: fcoe: Fix potential deadlock on &fip->ctlr_lock"

Paolo Abeni <pabeni@redhat.com>
    mptcp: fix data re-injection from stale subflow

Radek Krejci <radek.krejci@oracle.com>
    modpost: trim leading spaces when processing source files list

Jean Delvare <jdelvare@suse.de>
    i2c: i801: Fix block process call transactions

Heiner Kallweit <hkallweit1@gmail.com>
    i2c: i801: Remove i801_set_block_buffer_mode

Jiangfeng Xiao <xiaojiangfeng@huawei.com>
    powerpc/kasan: Fix addr error caused by page alignment

Zhipeng Lu <alexious@zju.edu.cn>
    media: ir_toy: fix a memleak in irtoy_tx

Uttkarsh Aggarwal <quic_uaggarwa@quicinc.com>
    usb: dwc3: gadget: Fix NULL pointer dereference in dwc3_gadget_suspend

yuan linyu <yuanlinyu@hihonor.com>
    usb: f_mass_storage: forbid async queue when shutdown happen

Oliver Neukum <oneukum@suse.com>
    USB: hub: check for alternate port before enabling A_ALT_HNP_SUPPORT

Christian A. Ehrhardt <lk@c--e.de>
    usb: ucsi_acpi: Fix command completion handling

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

Guenter Roeck <linux@roeck-us.net>
    MIPS: Add 'memory' clobber to csum_ipv6_magic() inline assembler

Breno Leitao <leitao@debian.org>
    net: sysfs: Fix /sys/class/net/<iface> path for statistics

Alexey Khoroshilov <khoroshilov@ispras.ru>
    ASoC: rt5645: Fix deadlock in rt5645_jack_detect_work()

Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
    spi: ppc4xx: Drop write-only variable

Aaron Conole <aconole@redhat.com>
    net: openvswitch: limit the number of recursions from action sets

Dan Carpenter <dan.carpenter@linaro.org>
    wifi: iwlwifi: Fix some error codes

Christian A. Ehrhardt <lk@c--e.de>
    of: unittest: Fix compile in the non-dynamic case

David Sterba <dsterba@suse.com>
    btrfs: send: return EOPNOTSUPP on unknown flags

Boris Burkov <boris@bur.io>
    btrfs: forbid deleting live subvol qgroup

Qu Wenruo <wqu@suse.com>
    btrfs: do not ASSERT() if the newly created subvolume already got read

Boris Burkov <boris@bur.io>
    btrfs: forbid creating subvol qgroups

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nft_set_rbtree: skip end interval element from gc

Furong Xu <0x1207@gmail.com>
    net: stmmac: xgmac: fix a typo of register name in DPP safety handling

Simon Horman <horms@kernel.org>
    net: stmmac: xgmac: use #define for string constants

Jiri Wiesner <jwiesner@suse.de>
    clocksource: Skip watchdog check for large watchdog intervals

Prathu Baronia <prathubaronia2011@gmail.com>
    vhost: use kzalloc() instead of kmalloc() followed by memset()

Hans de Goede <hdegoede@redhat.com>
    Input: atkbd - skip ATKBD_CMD_SETLEDS when skipping ATKBD_CMD_GETID

Werner Sembach <wse@tuxedocomputers.com>
    Input: i8042 - fix strange behavior of touchpad on Clevo NS70PU

Frederic Weisbecker <frederic@kernel.org>
    hrtimer: Report offline hrtimer enqueue

Prashanth K <quic_prashk@quicinc.com>
    usb: host: xhci-plat: Add support for XHCI_SG_TRB_CACHE_SIZE_QUIRK

Prashanth K <quic_prashk@quicinc.com>
    usb: dwc3: host: Set XHCI_SG_TRB_CACHE_SIZE_QUIRK

Leonard Dallmayr <leonard.dallmayr@mailbox.org>
    USB: serial: cp210x: add ID for IMST iM871A-USB

Puliang Lu <puliang.lu@fibocom.com>
    USB: serial: option: add Fibocom FM101-GL variant

JackBB Wu <wojackbb@gmail.com>
    USB: serial: qcserial: add new usb-id for Dell Wireless DW5826e

Julian Sikorski <belegdol+github@gmail.com>
    ALSA: usb-audio: Add a quirk for Yamaha YIT-W12TX transmitter

Justin Stitt <justinstitt@google.com>
    drivers: lkdtm: fix clang -Wformat warning

Tejun Heo <tj@kernel.org>
    blk-iocost: Fix an UBSAN shift-out-of-bounds warning

Ming Lei <ming.lei@redhat.com>
    scsi: core: Move scsi_host_busy() out of host lock if it is for per-command

Dan Carpenter <dan.carpenter@linaro.org>
    fs/ntfs3: Fix an NULL dereference bug

Florian Westphal <fw@strlen.de>
    netfilter: nft_set_pipapo: remove scratch_aligned pointer

Florian Westphal <fw@strlen.de>
    netfilter: nft_set_pipapo: add helper to release pcpu scratch area

Florian Westphal <fw@strlen.de>
    netfilter: nft_set_pipapo: store index in scratch maps

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nft_ct: reject direction for ct id

Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
    drm/amd/display: Implement bounds check for stream encoder creation in DCN301

Anson Jacob <Anson.Jacob@amd.com>
    drm/amd/display: Fix multiple memory leaks reported by coverity

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nft_compat: restrict match/target protocol to u16

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nft_compat: reject unused compat flag

Eric Dumazet <edumazet@google.com>
    ppp_async: limit MRU to 64K

Kuniyuki Iwashima <kuniyu@amazon.com>
    af_unix: Call kfree_skb() for dead unix_(sk)->oob_skb in GC.

Shigeru Yoshida <syoshida@redhat.com>
    tipc: Check the bearer type before calling tipc_udp_nl_bearer_add()

David Howells <dhowells@redhat.com>
    rxrpc: Fix response to PING RESPONSE ACKs to a dead call

Eric Dumazet <edumazet@google.com>
    inet: read sk->sk_family once in inet_recv_error()

Zhang Rui <rui.zhang@intel.com>
    hwmon: (coretemp) Fix bogus core_id to attr name mapping

Zhang Rui <rui.zhang@intel.com>
    hwmon: (coretemp) Fix out-of-bounds memory access

Loic Prylli <lprylli@netflix.com>
    hwmon: (aspeed-pwm-tacho) mutex for tach reading

Zhipeng Lu <alexious@zju.edu.cn>
    octeontx2-pf: Fix a memleak otx2_sq_init

Zhipeng Lu <alexious@zju.edu.cn>
    atm: idt77252: fix a memleak in open_card_ubr0

Antoine Tenart <atenart@kernel.org>
    tunnels: fix out of bounds access when building IPv6 PMTU error

Paolo Abeni <pabeni@redhat.com>
    selftests: net: avoid just another constant wait

Paolo Abeni <pabeni@redhat.com>
    selftests: net: cut more slack for gro fwd tests.

Furong Xu <0x1207@gmail.com>
    net: stmmac: xgmac: fix handling of DPP safety error for DMA channels

Kuogee Hsieh <quic_khsieh@quicinc.com>
    drm/msm/dp: return correct Colorimetry for DP_TEST_DYNAMIC_RANGE_CEA case

Tony Lindgren <tony@atomide.com>
    phy: ti: phy-omap-usb2: Fix NULL pointer dereference for SRP

Frank Li <Frank.Li@nxp.com>
    dmaengine: fix is_slave_direction() return false when DMA_DEV_TO_DEV

Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
    phy: renesas: rcar-gen3-usb2: Fix returning wrong error code

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    dmaengine: fsl-qdma: Fix a memory leak related to the queue command DMA

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    dmaengine: fsl-qdma: Fix a memory leak related to the status queue DMA

Jai Luthra <j-luthra@ti.com>
    dmaengine: ti: k3-udma: Report short packet errors

Guanhua Gao <guanhua.gao@nxp.com>
    dmaengine: fsl-dpaa2-qdma: Fix the size of dma pools

Johan Hovold <johan+linaro@kernel.org>
    ASoC: codecs: lpass-wsa-macro: fix compander volume hack

Zhengchao Shao <shaozhengchao@huawei.com>
    bonding: remove print in bond_verify_device_path

Benjamin Berg <bberg@redhat.com>
    HID: apple: Add 2021 magic keyboard FN key mapping

Alex Henrie <alexhenrie24@gmail.com>
    HID: apple: Add support for the 2021 Magic Keyboard

Praveen Kaligineedi <pkaligineedi@google.com>
    gve: Fix use-after-free vulnerability

Huang Shijie <shijie@os.amperecomputing.com>
    arm64: irq: set the correct node for shadow call stack

Breno Leitao <leitao@debian.org>
    net: sysfs: Fix /sys/class/net/<iface> path

Paolo Abeni <pabeni@redhat.com>
    selftests: net: fix available tunnels detection

Eric Dumazet <edumazet@google.com>
    af_unix: fix lockdep positive in sk_diag_dump_icons()

Zhipeng Lu <alexious@zju.edu.cn>
    net: ipv4: fix a memleak in ip_setup_cork

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nft_ct: sanitize layer 3 and 4 protocol number in custom expectations

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_log: replace BUG_ON by WARN_ON_ONCE when putting logger

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: restrict tunnel object to NFPROTO_NETDEV

Linus Lüssing <linus.luessing@c0d3.blue>
    bridge: mcast: fix disabled snooping after long uptime

Eric Dumazet <edumazet@google.com>
    llc: call sock_orphan() at release time

Helge Deller <deller@kernel.org>
    ipv6: Ensure natural alignment of const ipv6 loopback and router addresses

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    ixgbe: Fix an error handling path in ixgbe_read_iosf_sb_reg_x550()

Jedrzej Jagielski <jedrzej.jagielski@intel.com>
    ixgbe: Refactor overtemp event handling

Jedrzej Jagielski <jedrzej.jagielski@intel.com>
    ixgbe: Refactor returning internal error codes

Piotr Skajewski <piotrx.skajewski@intel.com>
    ixgbe: Remove non-inclusive language

Eric Dumazet <edumazet@google.com>
    tcp: add sanity checks to rx zerocopy

Eric Dumazet <edumazet@google.com>
    ip6_tunnel: make sure to pull inner header in __ip6_tnl_rcv()

Eric Dumazet <edumazet@google.com>
    ip6_tunnel: use dev_sw_netstats_rx_add()

Paolo Abeni <pabeni@redhat.com>
    selftests: net: give more time for GRO aggregation

Ming Lei <ming.lei@redhat.com>
    scsi: core: Move scsi_host_busy() out of host lock for waking up EH handler

Su Hui <suhui@nfschina.com>
    scsi: isci: Fix an error code problem in isci_io_request_build()

Stephen Rothwell <sfr@canb.auug.org.au>
    drm: using mul_u32_u32() requires linux/math64.h

Edward Adam Davis <eadavis@qq.com>
    wifi: cfg80211: fix RCU dereference in __cfg80211_bss_update

Peter Zijlstra <peterz@infradead.org>
    perf: Fix the nr_addr_filters fix

Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
    drm/amdkfd: Fix 'node' NULL check in 'svm_range_get_range_boundaries()'

Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
    drm/amdgpu: Release 'adev->pm.fw' before return in 'amdgpu_device_need_post()'

Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
    drm/amd/powerplay: Fix kzalloc parameter 'ATOM_Tonga_PPM_Table' in 'get_platform_power_management_table()'

Xiubo Li <xiubli@redhat.com>
    ceph: fix deadlock or deadcode of misusing dget()

Ming Lei <ming.lei@redhat.com>
    blk-mq: fix IO hang from sbitmap wakeup race

Zhu Yanjun <yanjun.zhu@linux.dev>
    virtio_net: Fix "‘%d’ directive writing between 1 and 11 bytes into a region of size 10" warnings

Felix Kuehling <felix.kuehling@amd.com>
    drm/amdkfd: Fix lock dependency warning

Ian Rogers <irogers@google.com>
    libsubcmd: Fix memory leak in uniq()

Hans de Goede <hdegoede@redhat.com>
    misc: lis3lv02d_i2c: Add missing setting of the reg_ctrl callback

Bjorn Helgaas <bhelgaas@google.com>
    PCI/AER: Decode Requester ID when no error info found

Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
    PCI: Fix 64GT/s effective data rate calculation

Max Kellermann <max.kellermann@ionos.com>
    fs/kernfs/dir: obey S_ISGID

Adrian Reber <areber@redhat.com>
    tty: allow TIOCSLCKTRMIOS with CAP_CHECKPOINT_RESTORE

Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
    selftests/sgx: Fix linker script asserts

Hardik Gajjar <hgajjar@de.adit-jv.com>
    usb: hub: Replace hardcoded quirk value with BIT() macro

James Clark <james.clark@arm.com>
    perf cs-etm: Bump minimum OpenCSD version to ensure a bugfix is present

Daniel Stodden <dns@arista.com>
    PCI: switchtec: Fix stdev_release() crash after surprise hot remove

Guilherme G. Piccoli <gpiccoli@igalia.com>
    PCI: Only override AMD USB controller if required

Xiaowu.ding <xiaowu.ding@jaguarmicro.com>
    mailbox: arm_mhuv2: Fix a bug for mhuv2_sender_interrupt

Peter Robinson <pbrobinson@gmail.com>
    mfd: ti_am335x_tscadc: Fix TI SoC dependencies

Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
    xen/gntdev: Fix the abuse of underlying struct page in DMA-buf import

Harshit Shah <harshitshah.opendev@gmail.com>
    i3c: master: cdns: Update maximum prescaler value for i2c clock

Johannes Berg <johannes.berg@intel.com>
    um: time-travel: fix time corruption

Nathan Chancellor <nathan@kernel.org>
    um: net: Fix return type of uml_net_start_xmit()

Benjamin Berg <benjamin@sipsolutions.net>
    um: Don't use vfprintf() for os_info()

Anton Ivanov <anton.ivanov@cambridgegreys.com>
    um: Fix naming clash between UML and scheduler

Heiner Kallweit <hkallweit1@gmail.com>
    leds: trigger: panic: Don't register panic notifier if creating the trigger failed

bo liu <bo.liu@senarytech.com>
    ALSA: hda/conexant: Fix headset auto detect fail in cx8070 and SN6140

Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
    drm/amdgpu: Drop 'fence' check in 'to_amdgpu_amdkfd_fence()'

Felix Kuehling <Felix.Kuehling@amd.com>
    drm/amdgpu: Let KFD sync with VM fences

Alexander Stein <alexander.stein@ew.tq-group.com>
    clk: imx: clk-imx8qxp: fix LVDS bypass, pixel and phy clocks

Kuan-Wei Chiu <visitorckw@gmail.com>
    clk: imx: scu: Fix memory leak in __imx_clk_gpr_scu()

Josip Pavic <josip.pavic@amd.com>
    drm/amd/display: make flip_timestamp_in_us a 64-bit variable

Werner Fischer <devlists@wefi.net>
    watchdog: it87_wdt: Keep WDTCTRL bit 3 unmodified for IT8784/IT8786

Kuan-Wei Chiu <visitorckw@gmail.com>
    clk: mmp: pxa168: Fix memory leak in pxa168_clk_init()

Kuan-Wei Chiu <visitorckw@gmail.com>
    clk: hi3620: Fix memory leak in hi3620_mmc_clk_init()

Wang, Beyond <Wang.Beyond@amd.com>
    drm/amdgpu: fix ftrace event amdgpu_bo_move always move on same heap

Rob Clark <robdclark@chromium.org>
    drm/msm/dpu: Ratelimit framedone timeout msgs

Kieran Bingham <kieran.bingham@ideasonboard.com>
    media: i2c: imx335: Fix hblank min/max values

Su Hui <suhui@nfschina.com>
    media: ddbridge: fix an error code problem in ddb_probe

Daniel Vacek <neelx@redhat.com>
    IB/ipoib: Fix mcast list locking

Douglas Anderson <dianders@chromium.org>
    drm/exynos: Call drm_atomic_helper_shutdown() at shutdown/unbind time

Chao Yu <chao@kernel.org>
    f2fs: fix to tag gcing flag on page during block migration

Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
    media: rkisp1: Drop IRQF_SHARED

Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
    ALSA: hda: intel-dspcfg: add filters for ARL-S and ARL

Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
    ALSA: hda: Intel: add HDA_ARL PCI ID support

Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
    PCI: add INTEL_HDA_ARL to pci_ids.h

Michael Tretter <m.tretter@pengutronix.de>
    media: rockchip: rga: fix swizzling for RGB formats

Ghanshyam Agrawal <ghanshyam1898@gmail.com>
    media: stk1160: Fixed high volume of stk1160_dbg messages

Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
    drm/mipi-dsi: Fix detach call without attach

Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
    drm/framebuffer: Fix use of uninitialized variable

Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
    drm/drm_file: fix use of uninitialized variable

Jaegeuk Kim <jaegeuk@kernel.org>
    f2fs: fix write pointers on zoned device after roll forward

Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>
    drm/amd/display: Fix tiled display misalignment

Jack Wang <jinpu.wang@ionos.com>
    RDMA/IPoIB: Fix error code return in ipoib_mcast_join

Al Viro <viro@zeniv.linux.org.uk>
    fast_dput(): handle underflows gracefully

Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
    ASoC: doc: Fix undefined SND_SOC_DAPM_NOPM argument

Takashi Iwai <tiwai@suse.de>
    ALSA: hda: Refer to correct stream index at loops

Chao Yu <chao@kernel.org>
    f2fs: fix to check return value of f2fs_reserve_new_block()

Suman Ghosh <sumang@marvell.com>
    octeontx2-af: Fix max NPC MCAM entry check while validating ref_entry

Andrii Staikov <andrii.staikov@intel.com>
    i40e: Fix VF disable behavior to block all traffic

Lin Ma <linma@zju.edu.cn>
    bridge: cfm: fix enum typo in br_cc_ccm_tx_parse

Frédéric Danis <frederic.danis@collabora.com>
    Bluetooth: L2CAP: Fix possible multiple reject send

Zijun Hu <quic_zijuhu@quicinc.com>
    Bluetooth: qca: Set both WIDEBAND_SPEECH and LE_STATES quirks for QCA2066

Benjamin Berg <benjamin.berg@intel.com>
    wifi: cfg80211: free beacon_ies when overridden from hidden BSS

Su Hui <suhui@nfschina.com>
    wifi: rtlwifi: rtl8723{be,ae}: using calculate_bit_shift()

Alexander Tsoy <alexander@tsoy.me>
    ALSA: usb-audio: Add delay quirk for MOTU M Series 2nd revision

Mingyi Zhang <zhangmingyi5@huawei.com>
    libbpf: Fix NULL pointer dereference in bpf_object__collect_prog_relos

Zenm Chen <zenmchen@gmail.com>
    wifi: rtl8xxxu: Add additional USB IDs for RTL8192EU devices

Mao Jinlong <quic_jinlmao@quicinc.com>
    arm64: dts: qcom: msm8998: Fix 'out-ports' is a required property

Mao Jinlong <quic_jinlmao@quicinc.com>
    arm64: dts: qcom: msm8996: Fix 'in-ports' is a required property

Alex Lyakas <alex.lyakas@zadara.com>
    md: Whenassemble the array, consult the superblock of the freshest device

Christoph Hellwig <hch@lst.de>
    block: prevent an integer overflow in bvec_try_merge_hw_page

Tobias Waldekranz <tobias@waldekranz.com>
    net: dsa: mv88e6xxx: Fix mv88e6352_serdes_get_stats error path

Fabio Estevam <festevam@denx.de>
    ARM: dts: imx23/28: Fix the DMA controller node name

Fabio Estevam <festevam@denx.de>
    ARM: dts: imx23-sansa: Use preferred i2c-gpios properties

Fabio Estevam <festevam@denx.de>
    ARM: dts: imx27-apf27dev: Fix LED name

Fabio Estevam <festevam@denx.de>
    ARM: dts: imx25/27: Pass timing0

Fabio Estevam <festevam@denx.de>
    ARM: dts: imx25: Fix the iim compatible string

Kees Cook <keescook@chromium.org>
    block/rnbd-srv: Check for unlikely string overflow

Shannon Nelson <shannon.nelson@amd.com>
    ionic: pass opcode to devcmd_wait

Fabio Estevam <festevam@denx.de>
    ARM: dts: imx1: Fix sram node

Fabio Estevam <festevam@denx.de>
    ARM: dts: imx27: Fix sram node

Fabio Estevam <festevam@denx.de>
    ARM: dts: imx: Use flash@0,0 pattern

Fabio Estevam <festevam@denx.de>
    ARM: dts: imx25/27-eukrea: Fix RTC node name

Johan Jonker <jbx6244@gmail.com>
    ARM: dts: rockchip: fix rk3036 hdmi ports node

Hou Tao <houtao1@huawei.com>
    bpf: Set uattr->batch.count as zero before batched update or deletion

Hannes Reinecke <hare@suse.de>
    scsi: libfc: Fix up timeout error in fc_fcp_rec_error()

Hannes Reinecke <hare@suse.de>
    scsi: libfc: Don't schedule abort twice

Hou Tao <houtao1@huawei.com>
    bpf: Add map and need_defer parameters to .map_fd_put_ptr()

Minsuk Kang <linuxlovemin@yonsei.ac.kr>
    wifi: ath9k: Fix potential array-index-out-of-bounds read in ath9k_htc_txstatus()

Alexander Stein <alexander.stein@ew.tq-group.com>
    ARM: dts: imx7s: Fix nand-controller #size-cells

Alexander Stein <alexander.stein@ew.tq-group.com>
    ARM: dts: imx7s: Fix lcdif compatible

Alexander Stein <alexander.stein@ew.tq-group.com>
    ARM: dts: imx7d: Fix coresight funnel ports

ching Huang <ching2048@areca.com.tw>
    scsi: arcmsr: Support new PCI device IDs 1883 and 1886

Zhengchao Shao <shaozhengchao@huawei.com>
    bonding: return -ENOMEM instead of BUG in alb_upper_dev_walk

Ido Schimmel <idosch@nvidia.com>
    PCI: Add no PM reset quirk for NVIDIA Spectrum devices

Justin Tee <justin.tee@broadcom.com>
    scsi: lpfc: Fix possible file string name overflow when updating firmware

Yafang Shao <laoar.shao@gmail.com>
    selftests/bpf: Fix issues in setup_classid_environment()

Yonghong Song <yonghong.song@linux.dev>
    selftests/bpf: Fix pyperf180 compilation failure with clang18

Andrii Nakryiko <andrii@kernel.org>
    selftests/bpf: satisfy compiler by having explicit return in btf test

Shiji Yang <yangshiji66@outlook.com>
    wifi: rt2x00: restart beacon queue when hardware reset

Baokun Li <libaokun1@huawei.com>
    ext4: avoid online resizing failures due to oversized flex bg

Baokun Li <libaokun1@huawei.com>
    ext4: remove unnecessary check from alloc_flex_gd()

Baokun Li <libaokun1@huawei.com>
    ext4: unify the type of flexbg_size to unsigned int

Ye Bin <yebin10@huawei.com>
    ext4: fix inconsistent between segment fstrim and full fstrim

Gabriel Krisman Bertazi <krisman@suse.de>
    ecryptfs: Reject casefold directory inodes

Anna Schumaker <Anna.Schumaker@Netapp.com>
    SUNRPC: Fix a suspicious RCU usage warning

Heiko Carstens <hca@linux.ibm.com>
    KVM: s390: fix setting of fpc register

Heiko Carstens <hca@linux.ibm.com>
    s390/ptrace: handle setting of fpc register correctly

Arnd Bergmann <arnd@arndb.de>
    arch: consolidate arch_irq_work_raise prototypes

Edward Adam Davis <eadavis@qq.com>
    jfs: fix array-index-out-of-bounds in diNewExt

Oleg Nesterov <oleg@redhat.com>
    rxrpc_find_service_conn_rcu: fix the usage of read_seqbegin_or_lock()

Oleg Nesterov <oleg@redhat.com>
    afs: fix the usage of read_seqbegin_or_lock() in afs_find_server*()

Oleg Nesterov <oleg@redhat.com>
    afs: fix the usage of read_seqbegin_or_lock() in afs_lookup_volume_rcu()

Thomas Bourgoin <thomas.bourgoin@foss.st.com>
    crypto: stm32/crc32 - fix parsing list of devices

Bharat Bhushan <bbhushan2@marvell.com>
    crypto: octeontx2 - Fix cptvf driver cleanup

Weichen Chen <weichen.chen@mediatek.com>
    pstore/ram: Fix crash when setting number of cpus to an odd number

Edward Adam Davis <eadavis@qq.com>
    jfs: fix uaf in jfs_evict_inode

Manas Ghandat <ghandatmanas@gmail.com>
    jfs: fix array-index-out-of-bounds in dbAdjTree

Manas Ghandat <ghandatmanas@gmail.com>
    jfs: fix slab-out-of-bounds Read in dtSearch

Osama Muhammad <osmtendev@gmail.com>
    UBSAN: array-index-out-of-bounds in dtSplitRoot

Osama Muhammad <osmtendev@gmail.com>
    FS:JFS:UBSAN:array-index-out-of-bounds in dbAdjTree

Shuai Xue <xueshuai@linux.alibaba.com>
    ACPI: APEI: set memory failure flags as MF_ACTION_REQUIRED on synchronous events

Mukesh Ojha <quic_mojha@quicinc.com>
    PM / devfreq: Synchronize devfreq_monitor_[start/stop]

Prarit Bhargava <prarit@redhat.com>
    ACPI: extlog: fix NULL pointer dereference check

Dmitry Antipov <dmantipov@yandex.ru>
    PNP: ACPI: fix fortify warning

Yuluo Qiu <qyl27@outlook.com>
    ACPI: video: Add quirk for the Colorful X15 AT 23 Laptop

Chris Riches <chris.riches@nutanix.com>
    audit: Send netlink ACK before setting connection in auditd_set

Rui Zhang <zr.zhang@vivo.com>
    regulator: core: Only increment use_count when enable_count changes

Andrzej Hajda <andrzej.hajda@intel.com>
    debugobjects: Stop accessing objects after releasing hash bucket lock

Greg KH <gregkh@linuxfoundation.org>
    perf/core: Fix narrow startup race when creating the perf nr_addr_filters sysfs file

Zhiquan Li <zhiquan1.li@intel.com>
    x86/mce: Mark fatal MCE's page as poison to avoid panic in the kdump kernel

Naveen N Rao <naveen@kernel.org>
    powerpc/lib: Validate size for vector operations

Stephen Rothwell <sfr@canb.auug.org.au>
    powerpc: pmd_move_must_withdraw() is only needed for CONFIG_TRANSPARENT_HUGEPAGE

Jun'ichi Nomura <junichi.nomura@nec.com>
    x86/boot: Ignore NMIs during very early boot

Michael Ellerman <mpe@ellerman.id.au>
    powerpc/64s: Fix CONFIG_NUMA=n build due to create_section_mapping()

Michael Ellerman <mpe@ellerman.id.au>
    powerpc/mm: Fix build failures due to arch_reserved_kernel_pages()

Michael Ellerman <mpe@ellerman.id.au>
    powerpc: Fix build error due to is_valid_bugaddr()

Mark Rutland <mark.rutland@arm.com>
    drivers/perf: pmuv3: don't expose SW_INCR event in sysfs

Huang Shijie <shijie@os.amperecomputing.com>
    arm64: irq: set the correct node for VMAP stack

Kunwu Chan <chentao@kylinos.cn>
    powerpc/mm: Fix null-pointer dereference in pgtable_cache_add

Richard Palethorpe <rpalethorpe@suse.com>
    x86/entry/ia32: Ensure s32 is sign extended to s64

Tim Chen <tim.c.chen@linux.intel.com>
    tick/sched: Preserve number of idle sleeps across CPU hotplug events

Xi Ruoyao <xry111@xry111.site>
    mips: Call lose_fpu(0) before initializing fcr31 in mips_set_personality_nan

Kamal Dasu <kamal.dasu@broadcom.com>
    spi: bcm-qspi: fix SFDP BFPT read by usig mspi read

Li Lingfeng <lilingfeng3@huawei.com>
    block: Move checking GENHD_FL_NO_PART to bdev_add_partition()

Wenhua Lin <Wenhua.Lin@unisoc.com>
    gpio: eic-sprd: Clear interrupt after set the interrupt type

Fedor Pchelkin <pchelkin@ispras.ru>
    drm/exynos: gsc: minor fix for loop iteration in gsc_runtime_resume

Arnd Bergmann <arnd@arndb.de>
    drm/exynos: fix accidental on-stack copy of exynos_drm_plane

Markus Niebel <Markus.Niebel@ew.tq-group.com>
    drm: panel-simple: add missing bus flags for Tianma tm070jvhg[30/33]

Rafael J. Wysocki <rafael.j.wysocki@intel.com>
    cpufreq: intel_pstate: Refine computation of P-state for given frequency

Rafael J. Wysocki <rafael.j.wysocki@intel.com>
    cpufreq: intel_pstate: Drop redundant intel_pstate_get_hwp_cap() call

Lin Ma <linma@zju.edu.cn>
    ksmbd: fix global oob in ksmbd_nl_policy

Chuck Lever <chuck.lever@oracle.com>
    NFSD: Add documenting comment for nfsd4_release_lockowner()

Chuck Lever <chuck.lever@oracle.com>
    NFSD: Modernize nfsd4_release_lockowner()

Josef Bacik <josef@toxicpanda.com>
    btrfs: add definition for EXTENT_TREE_V2

Christian Marangi <ansuelsmth@gmail.com>
    PM / devfreq: Fix buffer overflow in trans_stat_show

Charan Teja Kalla <quic_charante@quicinc.com>
    mm/sparsemem: fix race in accessing memory_section->usage

Rolf Eike Beer <eb@emlix.com>
    mm: use __pfn_to_section() instead of open coding it

Zheng Wang <zyytlz.wz@163.com>
    media: mtk-jpeg: Fix use after free bug due to error path handling in mtk_jpeg_dec_device_run

Johan Hovold <johan+linaro@kernel.org>
    ARM: dts: qcom: sdx55: fix USB SS wakeup

Johan Hovold <johan+linaro@kernel.org>
    ARM: dts: qcom: sdx55: fix USB DP/DM HS PHY interrupts

Johan Hovold <johan+linaro@kernel.org>
    ARM: dts: qcom: sdx55: fix pdc '#interrupt-cells'

Paul Cercueil <paul@crapouillou.net>
    ARM: dts: samsung: exynos4210-i9100: Unconditionally enable LDO12

Johan Hovold <johan+linaro@kernel.org>
    ARM: dts: qcom: sdx55: fix USB wakeup interrupt types

Lukas Schauer <lukas@schauer.dev>
    pipe: wakeup wr_wait after setting max_usage

Max Kellermann <max.kellermann@ionos.com>
    fs/pipe: move check to pipe_has_watch_queue()

Krishna chaitanya chundru <quic_krichai@quicinc.com>
    bus: mhi: host: Add alignment check for event ring read pointer

Manivannan Sadhasivam <mani@kernel.org>
    bus: mhi: host: Rename "struct mhi_tre" to "struct mhi_ring_element"

Rafael J. Wysocki <rafael.j.wysocki@intel.com>
    PM: sleep: Fix possible deadlocks in core system-wide PM code

Li zeming <zeming@nfschina.com>
    PM: core: Remove unnecessary (void *) conversions

Dan Carpenter <dan.carpenter@linaro.org>
    drm/bridge: nxp-ptn3460: simplify some error checking

Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
    drm/tidss: Fix atomic_flush check

Dan Carpenter <dan.carpenter@linaro.org>
    drm/bridge: nxp-ptn3460: fix i2c_master_send() error checking

Ville Syrjälä <ville.syrjala@linux.intel.com>
    drm: Don't unref the same fb many times by mistake due to deadlock handling

Mario Limonciello <mario.limonciello@amd.com>
    gpiolib: acpi: Ignore touchpad wakeup on GPD G1619-04

Dave Chinner <dchinner@redhat.com>
    xfs: read only mounts with fsopen mount API are busted

Cristian Marussi <cristian.marussi@arm.com>
    firmware: arm_scmi: Check mailbox/SMT channel for consistency

Florian Westphal <fw@strlen.de>
    netfilter: nf_tables: reject QUEUE/DROP verdict parameters

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nft_chain_filter: handle NETDEV_UNREGISTER for inet/ingress basechain

Michael Kelley <mhklinux@outlook.com>
    hv_netvsc: Calculate correct ring size when PAGE_SIZE is not 4 Kbytes

Emmanuel Grumbach <emmanuel.grumbach@intel.com>
    wifi: iwlwifi: fix a memory corruption

Bernd Edlinger <bernd.edlinger@hotmail.de>
    exec: Fix error handling in begin_new_exec()

Ilya Dryomov <idryomov@gmail.com>
    rbd: don't move requests to the running list on errors

Omar Sandoval <osandov@fb.com>
    btrfs: don't abort filesystem when attempting to snapshot deleted subvolume

Qu Wenruo <wqu@suse.com>
    btrfs: defrag: reject unknown flags of btrfs_ioctl_defrag_range_args

David Sterba <dsterba@suse.com>
    btrfs: don't warn if discard range is not aligned to sector

Chung-Chiang Cheng <cccheng@synology.com>
    btrfs: tree-checker: fix inline ref size in error messages

Fedor Pchelkin <pchelkin@ispras.ru>
    btrfs: ref-verify: free ref cache before clearing mount opt

Omar Sandoval <osandov@fb.com>
    btrfs: avoid copying BTRFS_ROOT_SUBVOL_DEAD flag to snapshot of subvolume being deleted

Filipe Manana <fdmanana@suse.com>
    btrfs: fix race between reading a directory and adding entries to it

Filipe Manana <fdmanana@suse.com>
    btrfs: refresh dir last index during a rewinddir(3) call

Filipe Manana <fdmanana@suse.com>
    btrfs: set last dir index to the current last index when opening dir

Filipe Manana <fdmanana@suse.com>
    btrfs: fix infinite directory reads

Shenwei Wang <shenwei.wang@nxp.com>
    net: fec: fix the unhandled context fault from smmu

Zhipeng Lu <alexious@zju.edu.cn>
    fjes: fix memleaks in fjes_hw_setup

Jakub Kicinski <kuba@kernel.org>
    selftests: netdevsim: fix the udp_tunnel_nic test

Jenishkumar Maheshbhai Patel <jpatel2@marvell.com>
    net: mvpp2: clear BM pool before initialization

Bernd Edlinger <bernd.edlinger@hotmail.de>
    net: stmmac: Wait a bit for the reset to take effect

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: validate NFPROTO_* family

Florian Westphal <fw@strlen.de>
    netfilter: nf_tables: restrict anonymous set and map names to 16 bytes

Florian Westphal <fw@strlen.de>
    netfilter: nft_limit: reject configurations that cause integer overflow

Kees Cook <keescook@chromium.org>
    overflow: Allow mixed type arguments

Dinghao Liu <dinghao.liu@zju.edu.cn>
    net/mlx5e: fix a potential double-free in fs_any_create_groups

Zhipeng Lu <alexious@zju.edu.cn>
    net/mlx5e: fix a double-free in arfs_create_groups

Yevgeny Kliteynik <kliteyn@nvidia.com>
    net/mlx5: DR, Can't go to uplink vport on RX rule

Shun Hao <shunh@nvidia.com>
    net/mlx5: DR, Align mlx5dv_dr API vport action with FW behavior

Yevgeny Kliteynik <kliteyn@nvidia.com>
    net/mlx5: DR, Replace local WIRE_PORT macro with the existing MLX5_VPORT_UPLINK

Yevgeny Kliteynik <kliteyn@nvidia.com>
    net/mlx5: DR, Use the right GVMI number for drop action

Zhengchao Shao <shaozhengchao@huawei.com>
    ipv6: init the accept_queue's spinlocks in inet6_create

Zhengchao Shao <shaozhengchao@huawei.com>
    netlink: fix potential sleeping issue in mqueue_flush_file

Salvatore Dipietro <dipiets@amazon.com>
    tcp: Add memory barrier to tcp_push()

David Howells <dhowells@redhat.com>
    afs: Hide silly-rename files from userspace

Petr Pavlu <petr.pavlu@suse.com>
    tracing: Ensure visibility when inserting an element into tracing_map

Sharath Srinivasan <sharath.srinivasan@oracle.com>
    net/rds: Fix UBSAN: array-index-out-of-bounds in rds_cmsg_recv

Kuniyuki Iwashima <kuniyu@amazon.com>
    llc: Drop support for ETH_P_TR_802_2.

Eric Dumazet <edumazet@google.com>
    llc: make llc_ui_sendmsg() more robust against bonding changes

Lin Ma <linma@zju.edu.cn>
    vlan: skip nested type that is not IFLA_VLAN_QOS_MAPPING

Michael Chan <michael.chan@broadcom.com>
    bnxt_en: Wait for FLR to complete during probe

Zhengchao Shao <shaozhengchao@huawei.com>
    tcp: make sure init the accept_queue's spinlocks once

Wen Gu <guwen@linux.alibaba.com>
    net/smc: fix illegal rmb_desc access in SMC-D connection dump

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: Add missing set_freezable() for freezable kthread

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: send lease break notification on FILE_RENAME_INFORMATION

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: don't increment epoch if current state and request state are same

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: fix potential circular locking issue in smb2_set_ea()

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: set v2 lease version on lease upgrade

Al Viro <viro@zeniv.linux.org.uk>
    rename(): fix the locking of subdirectories

Zhihao Cheng <chengzhihao1@huawei.com>
    ubifs: ubifs_symlink: Fix memleak of inode->i_link in error path

Dave Airlie <airlied@redhat.com>
    nouveau/vmm: don't set addr on the fail path to avoid warning

Mario Limonciello <mario.limonciello@amd.com>
    rtc: Adjust failure return code for cmos_set_alarm()

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    mmc: mmc_spi: remove custom DMA mapped buffers

Avri Altman <avri.altman@wdc.com>
    mmc: core: Use mrq.sbc in close-ended ffu

Vegard Nossum <vegard.nossum@oracle.com>
    scripts/get_abi: fix source path leak

Alfred Piccioni <alpic@google.com>
    lsm: new security_file_ioctl_compat() hook

Johan Hovold <johan+linaro@kernel.org>
    arm64: dts: qcom: sdm845: fix USB DP/DM HS PHY interrupts

Johan Hovold <johan+linaro@kernel.org>
    arm64: dts: qcom: sm8150: fix USB wakeup interrupt types

Johan Hovold <johan+linaro@kernel.org>
    arm64: dts: qcom: sdm845: fix USB wakeup interrupt types

Johan Hovold <johan+linaro@kernel.org>
    arm64: dts: qcom: sc7180: fix USB wakeup interrupt types

Rafael J. Wysocki <rafael.j.wysocki@intel.com>
    async: Introduce async_schedule_dev_nocall()

Rafael J. Wysocki <rafael.j.wysocki@intel.com>
    async: Split async_schedule_node_domain()

Helge Deller <deller@gmx.de>
    parisc/firmware: Fix F-extend for PDC addresses

Bhaumik Bhatt <bbhatt@codeaurora.org>
    bus: mhi: host: Add spinlock to protect WP access when queueing TREs

Qiang Yu <quic_qianyu@quicinc.com>
    bus: mhi: host: Drop chan lock before queuing buffers

Serge Semin <fancer.lancer@gmail.com>
    mips: Fix max_mapnr being uninitialized on early stages

Bingbu Cao <bingbu.cao@intel.com>
    media: ov9734: Enable runtime PM before registering async sub-device

Xiaolei Wang <xiaolei.wang@windriver.com>
    rpmsg: virtio: Free driver_override when rpmsg_remove()

Bingbu Cao <bingbu.cao@intel.com>
    media: imx355: Enable runtime PM before registering async sub-device

Herbert Xu <herbert@gondor.apana.org.au>
    crypto: s390/aes - Fix buffer overread in CTR mode

Herbert Xu <herbert@gondor.apana.org.au>
    hwrng: core - Fix page fault dead lock on mmap-ed hwrng

Hongchen Zhang <zhanghongchen@loongson.cn>
    PM: hibernate: Enforce ordering during image compression/decompression

Herbert Xu <herbert@gondor.apana.org.au>
    crypto: api - Disallow identical driver names

David Disseldorp <ddiss@suse.de>
    btrfs: sysfs: validate scrub_speed_max value

Suraj Jitindar Singh <surajjs@amazon.com>
    ext4: allow for the last group to be marked as trimmed

Jonathan Cameron <Jonathan.Cameron@huawei.com>
    iio:adc:ad7091r: Move exports into IIO_AD7091R namespace.

Bart Van Assche <bvanassche@acm.org>
    scsi: ufs: core: Remove the ufshcd_hba_exit() call from ufshcd_async_scan()

Bart Van Assche <bvanassche@acm.org>
    scsi: ufs: core: Simplify power management during async scan

Amelie Delaunay <amelie.delaunay@foss.st.com>
    dmaengine: fix NULL pointer in channel unregistration function

Marcelo Schmitt <marcelo.schmitt@analog.com>
    iio: adc: ad7091r: Enable internal vref if external vref is not supplied

Marcelo Schmitt <marcelo.schmitt@analog.com>
    iio: adc: ad7091r: Allow users to configure device events

Marcelo Schmitt <marcelo.schmitt@analog.com>
    iio: adc: ad7091r: Set alert bit in config register

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: only v2 leases handle the directory

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: fix UAF issue in ksmbd_tcp_new_connection()

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: validate mech token in session setup

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: don't allow O_TRUNC open on read-only share

Fedor Pchelkin <pchelkin@ispras.ru>
    ksmbd: free ppace array on error in parse_dacl


-------------

Diffstat:

 Documentation/ABI/testing/sysfs-class-devfreq      |   3 +
 Documentation/ABI/testing/sysfs-class-net-queues   |  22 +--
 .../ABI/testing/sysfs-class-net-statistics         |  48 ++---
 Documentation/arm64/silicon-errata.rst             |   7 +
 .../bindings/net/wireless/marvell-8xxx.txt         |   4 +-
 Documentation/filesystems/directory-locking.rst    |  29 +--
 Documentation/filesystems/locking.rst              |   5 +-
 Documentation/filesystems/porting.rst              |  18 ++
 Documentation/sound/soc/dapm.rst                   |   2 +-
 Makefile                                           |   4 +-
 arch/Kconfig                                       |   1 +
 arch/arm/boot/dts/exynos4210-i9100.dts             |   8 +
 arch/arm/boot/dts/imx1-ads.dts                     |   2 +-
 arch/arm/boot/dts/imx1-apf9328.dts                 |   2 +-
 arch/arm/boot/dts/imx1.dtsi                        |   5 +-
 arch/arm/boot/dts/imx23-sansa.dts                  |  12 +-
 arch/arm/boot/dts/imx23.dtsi                       |   2 +-
 arch/arm/boot/dts/imx25-eukrea-cpuimx25.dtsi       |   2 +-
 .../imx25-eukrea-mbimxsd25-baseboard-cmo-qvga.dts  |   2 +-
 .../imx25-eukrea-mbimxsd25-baseboard-dvi-svga.dts  |   2 +-
 .../imx25-eukrea-mbimxsd25-baseboard-dvi-vga.dts   |   2 +-
 arch/arm/boot/dts/imx25-pdk.dts                    |   2 +-
 arch/arm/boot/dts/imx25.dtsi                       |   2 +-
 arch/arm/boot/dts/imx27-apf27dev.dts               |   4 +-
 arch/arm/boot/dts/imx27-eukrea-cpuimx27.dtsi       |   4 +-
 .../boot/dts/imx27-eukrea-mbimxsd27-baseboard.dts  |   2 +-
 arch/arm/boot/dts/imx27-phytec-phycard-s-rdk.dts   |   2 +-
 arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts     |   2 +-
 arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi    |   2 +-
 arch/arm/boot/dts/imx27.dtsi                       |   3 +
 arch/arm/boot/dts/imx28.dtsi                       |   2 +-
 arch/arm/boot/dts/imx7d.dtsi                       |   3 -
 arch/arm/boot/dts/imx7s.dtsi                       |  10 +-
 arch/arm/boot/dts/qcom-sdx55.dtsi                  |  10 +-
 arch/arm/boot/dts/rk3036.dtsi                      |  14 +-
 arch/arm64/boot/dts/qcom/msm8996.dtsi              |  21 +++
 arch/arm64/boot/dts/qcom/msm8998.dtsi              |  32 ++--
 arch/arm64/boot/dts/qcom/sc7180.dtsi               |   4 +-
 arch/arm64/boot/dts/qcom/sdm845.dtsi               |  16 +-
 arch/arm64/boot/dts/qcom/sm8150.dtsi               |   8 +-
 arch/arm64/include/asm/cputype.h                   |   4 +
 arch/arm64/include/asm/irq_work.h                  |   2 -
 arch/arm64/kernel/cpu_errata.c                     |   3 +
 arch/arm64/kernel/irq.c                            |   7 +-
 arch/arm64/kernel/perf_event.c                     |   6 +-
 arch/csky/include/asm/irq_work.h                   |   2 +-
 arch/mips/include/asm/checksum.h                   |   3 +-
 arch/mips/kernel/elf.c                             |   6 +
 arch/mips/mm/init.c                                |  12 +-
 arch/parisc/kernel/firmware.c                      |   4 +-
 arch/powerpc/include/asm/irq_work.h                |   1 -
 arch/powerpc/include/asm/mmu.h                     |   4 +
 arch/powerpc/include/asm/mmzone.h                  |   8 -
 arch/powerpc/kernel/interrupt_64.S                 |   4 +-
 arch/powerpc/kernel/traps.c                        |   2 +
 arch/powerpc/lib/sstep.c                           |  10 +
 arch/powerpc/mm/book3s64/pgtable.c                 |   2 +
 arch/powerpc/mm/init-common.c                      |   5 +-
 arch/powerpc/mm/kasan/kasan_init_32.c              |   1 +
 arch/powerpc/mm/mmu_decl.h                         |   5 +
 arch/riscv/include/asm/irq_work.h                  |   2 +-
 arch/s390/crypto/aes_s390.c                        |   4 +-
 arch/s390/crypto/paes_s390.c                       |   4 +-
 arch/s390/include/asm/irq_work.h                   |   2 -
 arch/s390/kernel/ptrace.c                          |   6 +-
 arch/s390/kvm/kvm-s390.c                           |   5 -
 arch/um/drivers/net_kern.c                         |   2 +-
 arch/um/include/shared/kern_util.h                 |   2 +-
 arch/um/kernel/process.c                           |   2 +-
 arch/um/kernel/time.c                              |  32 +++-
 arch/um/os-Linux/helper.c                          |   6 +-
 arch/um/os-Linux/util.c                            |  19 +-
 arch/x86/Kconfig.cpu                               |   2 +-
 arch/x86/boot/compressed/ident_map_64.c            |   5 +
 arch/x86/boot/compressed/idt_64.c                  |   1 +
 arch/x86/boot/compressed/idt_handlers_64.S         |   1 +
 arch/x86/boot/compressed/misc.h                    |   1 +
 arch/x86/include/asm/irq_work.h                    |   1 -
 arch/x86/include/asm/syscall_wrapper.h             |  25 ++-
 arch/x86/kernel/cpu/mce/core.c                     |  16 ++
 arch/x86/mm/ident_map.c                            |  23 ++-
 block/bio.c                                        |   2 +-
 block/blk-iocost.c                                 |   7 +
 block/blk-mq.c                                     |  16 ++
 block/ioctl.c                                      |   2 -
 block/partitions/core.c                            |   5 +
 crypto/algapi.c                                    |   1 +
 drivers/acpi/acpi_extlog.c                         |   5 +-
 drivers/acpi/acpi_video.c                          |   9 +
 drivers/acpi/apei/ghes.c                           |  29 ++-
 drivers/android/binder.c                           |  10 +
 drivers/atm/idt77252.c                             |   2 +
 drivers/base/arch_numa.c                           |   2 +-
 drivers/base/power/domain.c                        |   2 +-
 drivers/base/power/main.c                          | 160 ++++++++--------
 drivers/base/power/runtime.c                       |   5 +
 drivers/block/rbd.c                                |  22 ++-
 drivers/block/rnbd/rnbd-srv.c                      |  19 +-
 drivers/bluetooth/hci_qca.c                        |   1 +
 drivers/bus/mhi/host/init.c                        |   6 +-
 drivers/bus/mhi/host/internal.h                    |   2 +-
 drivers/bus/mhi/host/main.c                        |  49 +++--
 drivers/bus/moxtet.c                               |   7 +
 drivers/char/hw_random/core.c                      |  36 ++--
 drivers/clk/hisilicon/clk-hi3620.c                 |   4 +-
 drivers/clk/imx/clk-imx8qxp.c                      |  24 ++-
 drivers/clk/imx/clk-scu.c                          |   4 +-
 drivers/clk/mmp/clk-of-pxa168.c                    |   3 +
 drivers/cpufreq/intel_pstate.c                     |  67 ++++---
 drivers/crypto/ccp/sev-dev.c                       |  10 +-
 drivers/crypto/marvell/octeontx2/otx2_cptlf.c      |   6 +-
 drivers/crypto/marvell/octeontx2/otx2_cptvf_main.c |   3 +
 drivers/crypto/stm32/stm32-crc32.c                 |   2 +-
 drivers/devfreq/devfreq.c                          |  83 ++++++---
 drivers/dma-buf/dma-fence-unwrap.c                 | 176 ++++++++++++++++++
 drivers/dma-buf/sync_file.c                        |   9 +-
 drivers/dma/dmaengine.c                            |   3 +
 drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.c            |  10 +-
 drivers/dma/fsl-qdma.c                             |  27 +--
 drivers/dma/ti/k3-udma.c                           |  10 +-
 drivers/firewire/core-device.c                     |   7 +-
 drivers/firmware/arm_scmi/common.h                 |   1 +
 drivers/firmware/arm_scmi/mailbox.c                |  14 ++
 drivers/firmware/arm_scmi/shmem.c                  |   6 +
 drivers/gpio/gpio-eic-sprd.c                       |  32 +++-
 drivers/gpio/gpiolib-acpi.c                        |  14 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c   |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c            |   9 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c         |  13 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h         |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c           |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c            |   5 +-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c               |  36 ++--
 drivers/gpu/drm/amd/display/dc/core/dc.c           |   4 +
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h       |   2 +-
 .../gpu/drm/amd/display/dc/dcn30/dcn30_resource.c  |   6 +-
 .../drm/amd/display/dc/dcn301/dcn301_resource.c    |   6 +-
 .../drm/amd/display/dc/dcn302/dcn302_resource.c    |   6 +-
 .../gpu/drm/amd/display/dc/dcn31/dcn31_resource.c  |   6 +-
 .../amd/pm/powerplay/hwmgr/process_pptables_v1_0.c |   2 +-
 drivers/gpu/drm/bridge/nxp-ptn3460.c               |   6 +-
 drivers/gpu/drm/drm_fb_helper.c                    |  11 +-
 drivers/gpu/drm/drm_file.c                         |   2 +-
 drivers/gpu/drm/drm_framebuffer.c                  |   2 +-
 drivers/gpu/drm/drm_mipi_dsi.c                     |  17 +-
 drivers/gpu/drm/drm_plane.c                        |   1 +
 drivers/gpu/drm/drm_prime.c                        |   2 +-
 drivers/gpu/drm/exynos/exynos5433_drm_decon.c      |   4 +-
 drivers/gpu/drm/exynos/exynos_drm_drv.c            |  11 ++
 drivers/gpu/drm/exynos/exynos_drm_fimd.c           |   4 +-
 drivers/gpu/drm/exynos/exynos_drm_gsc.c            |   2 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c        |   5 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h            |   1 +
 drivers/gpu/drm/msm/dp/dp_link.c                   |  12 +-
 drivers/gpu/drm/msm/dp/dp_reg.h                    |   3 +
 drivers/gpu/drm/msm/dsi/phy/dsi_phy.c              |   4 +
 drivers/gpu/drm/nouveau/nouveau_vmm.c              |   3 +
 drivers/gpu/drm/panel/panel-simple.c               |   2 +
 drivers/gpu/drm/scheduler/sched_main.c             |   3 +-
 drivers/gpu/drm/tidss/tidss_crtc.c                 |  10 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_fb.c                 |   8 +-
 drivers/hid/hid-apple.c                            |  33 +++-
 drivers/hid/hid-ids.h                              |   1 +
 drivers/hid/hid-picolcd_fb.c                       |   2 +-
 drivers/hid/hid-quirks.c                           |   1 +
 drivers/hid/i2c-hid/i2c-hid-of.c                   |   1 +
 drivers/hid/wacom_sys.c                            |  63 +++++--
 drivers/hid/wacom_wac.c                            |   9 +-
 drivers/hwmon/aspeed-pwm-tacho.c                   |   7 +
 drivers/hwmon/coretemp.c                           |  40 ++--
 drivers/i2c/busses/i2c-i801.c                      |  19 +-
 drivers/i3c/master/i3c-master-cdns.c               |   7 +-
 drivers/iio/accel/Kconfig                          |   2 +
 drivers/iio/adc/ad7091r-base.c                     | 173 ++++++++++++++++-
 drivers/iio/adc/ad7091r-base.h                     |   8 +
 drivers/iio/adc/ad7091r5.c                         |  29 +--
 drivers/iio/industrialio-core.c                    |   5 +-
 drivers/iio/light/hid-sensor-als.c                 |   1 +
 drivers/iio/magnetometer/rm3100-core.c             |  10 +-
 drivers/infiniband/ulp/ipoib/ipoib_multicast.c     |   7 +-
 drivers/input/keyboard/atkbd.c                     |  13 +-
 drivers/input/serio/i8042-acpipnpio.h              |   6 +
 drivers/irqchip/irq-brcmstb-l2.c                   |   5 +-
 drivers/irqchip/irq-gic-v3-its.c                   |  22 ++-
 drivers/leds/trigger/ledtrig-panic.c               |   5 +-
 drivers/mailbox/arm_mhuv2.c                        |   3 +-
 drivers/md/dm-core.h                               |   2 +
 drivers/md/dm-ioctl.c                              |   3 +-
 drivers/md/dm-table.c                              |   9 +-
 drivers/md/md.c                                    |  54 +++++-
 drivers/media/i2c/imx335.c                         |   4 +-
 drivers/media/i2c/imx355.c                         |  12 +-
 drivers/media/i2c/ov9734.c                         |  19 +-
 drivers/media/pci/ddbridge/ddbridge-main.c         |   2 +-
 drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c    |   6 +-
 drivers/media/platform/rockchip/rga/rga.c          |  15 +-
 drivers/media/rc/bpf-lirc.c                        |   6 +-
 drivers/media/rc/ir_toy.c                          |   2 +
 drivers/media/rc/lirc_dev.c                        |   5 +-
 drivers/media/rc/rc-core-priv.h                    |   2 +-
 drivers/media/usb/stk1160/stk1160-video.c          |   5 +-
 drivers/mfd/Kconfig                                |   1 +
 drivers/misc/fastrpc.c                             |   2 +-
 drivers/misc/lis3lv02d/lis3lv02d_i2c.c             |   1 +
 drivers/misc/lkdtm/bugs.c                          |   2 +-
 drivers/mmc/core/block.c                           |  46 ++++-
 drivers/mmc/core/slot-gpio.c                       |   6 +-
 drivers/mmc/host/mmc_spi.c                         | 186 +------------------
 drivers/net/bonding/bond_alb.c                     |   3 +-
 drivers/net/dsa/mv88e6xxx/chip.h                   |   4 +-
 drivers/net/dsa/mv88e6xxx/serdes.c                 |   8 +-
 drivers/net/dsa/mv88e6xxx/serdes.h                 |   8 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c          |   5 +
 drivers/net/ethernet/broadcom/genet/bcmgenet.c     |  22 +--
 drivers/net/ethernet/broadcom/genet/bcmgenet.h     |   3 +
 drivers/net/ethernet/broadcom/genet/bcmmii.c       |   6 +
 drivers/net/ethernet/freescale/fec_main.c          |   2 +
 drivers/net/ethernet/google/gve/gve_tx_dqo.c       |   5 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c        |   2 +-
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |  32 ++++
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h |   1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_82598.c     |  36 ++--
 drivers/net/ethernet/intel/ixgbe/ixgbe_82599.c     |  61 +++---
 drivers/net/ethernet/intel/ixgbe/ixgbe_common.c    | 177 +++++++++---------
 drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c   |   2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c      |  44 ++---
 drivers/net/ethernet/intel/ixgbe/ixgbe_mbx.c       |  34 ++--
 drivers/net/ethernet/intel/ixgbe/ixgbe_mbx.h       |   1 -
 drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c       | 105 +++++------
 drivers/net/ethernet/intel/ixgbe/ixgbe_phy.h       |   2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c     |   2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h      |  51 +-----
 drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c      |  44 ++---
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c      | 149 +++++++--------
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c    |  27 ++-
 .../net/ethernet/marvell/octeontx2/af/rvu_npc.c    |  13 +-
 .../ethernet/marvell/octeontx2/nic/otx2_common.c   |  14 +-
 .../mellanox/mlx5/core/en/fs_tt_redirect.c         |   1 +
 drivers/net/ethernet/mellanox/mlx5/core/en_arfs.c  |  26 +--
 .../mellanox/mlx5/core/steering/dr_action.c        |  19 +-
 .../mellanox/mlx5/core/steering/dr_domain.c        |   2 +-
 .../ethernet/mellanox/mlx5/core/steering/dr_rule.c |   4 +-
 .../mellanox/mlx5/core/steering/dr_types.h         |   7 +-
 .../ethernet/netronome/nfp/flower/tunnel_conf.c    |   2 +-
 .../ethernet/netronome/nfp/nfpcore/nfp6000_pcie.c  |   6 +-
 drivers/net/ethernet/pensando/ionic/ionic_dev.c    |   1 +
 drivers/net/ethernet/pensando/ionic/ionic_dev.h    |   1 +
 drivers/net/ethernet/pensando/ionic/ionic_main.c   |   2 +-
 drivers/net/ethernet/stmicro/stmmac/common.h       |   1 +
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h     |   3 +
 .../net/ethernet/stmicro/stmmac/dwxgmac2_core.c    |  58 +++++-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |   3 +
 drivers/net/ethernet/ti/cpsw.c                     |   2 +
 drivers/net/ethernet/ti/cpsw_new.c                 |   3 +
 drivers/net/fjes/fjes_hw.c                         |  37 +++-
 drivers/net/hyperv/netvsc.c                        |   5 +-
 drivers/net/hyperv/netvsc_drv.c                    |   4 +-
 drivers/net/ppp/ppp_async.c                        |   4 +
 drivers/net/virtio_net.c                           |   9 +-
 drivers/net/wireless/ath/ath9k/htc_drv_txrx.c      |   5 +-
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c       |  12 +-
 drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c   |   2 +-
 drivers/net/wireless/marvell/mwifiex/Kconfig       |   5 +-
 drivers/net/wireless/marvell/mwifiex/sdio.c        |  67 ++++++-
 drivers/net/wireless/marvell/mwifiex/sdio.h        |   8 +
 drivers/net/wireless/ralink/rt2x00/rt2x00dev.c     |   3 +
 drivers/net/wireless/ralink/rt2x00/rt2x00mac.c     |  11 ++
 .../net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c  |  12 ++
 .../net/wireless/realtek/rtlwifi/rtl8723ae/phy.c   |   6 +-
 .../net/wireless/realtek/rtlwifi/rtl8723be/phy.c   |   4 +-
 drivers/net/xen-netback/netback.c                  | 100 +++++-----
 drivers/of/property.c                              |   2 +-
 drivers/of/unittest.c                              |  12 +-
 drivers/pci/pci.h                                  |   2 +-
 drivers/pci/pcie/aer.c                             |   9 +-
 drivers/pci/quirks.c                               |  24 ++-
 drivers/pci/switch/switchtec.c                     |  25 ++-
 drivers/phy/renesas/phy-rcar-gen3-usb2.c           |   4 -
 drivers/phy/ti/phy-omap-usb2.c                     |   4 +-
 drivers/pnp/pnpacpi/rsparser.c                     |  12 +-
 drivers/regulator/core.c                           |  52 +++---
 drivers/rpmsg/virtio_rpmsg_bus.c                   |   1 +
 drivers/rtc/rtc-cmos.c                             |   4 +-
 drivers/s390/net/qeth_l3_main.c                    |   9 +-
 drivers/scsi/arcmsr/arcmsr.h                       |   4 +
 drivers/scsi/arcmsr/arcmsr_hba.c                   |   6 +
 drivers/scsi/fcoe/fcoe_ctlr.c                      |  20 +-
 drivers/scsi/isci/request.c                        |   2 +-
 drivers/scsi/libfc/fc_fcp.c                        |  18 +-
 drivers/scsi/lpfc/lpfc.h                           |   1 +
 drivers/scsi/lpfc/lpfc_init.c                      |   4 +-
 drivers/scsi/scsi_error.c                          |   9 +-
 drivers/scsi/scsi_lib.c                            |   4 +-
 drivers/scsi/scsi_priv.h                           |   2 +-
 drivers/scsi/storvsc_drv.c                         |  12 +-
 drivers/scsi/ufs/ufshcd.c                          |  14 +-
 drivers/spi/spi-bcm-qspi.c                         |   4 +-
 drivers/spi/spi-ppc4xx.c                           |   5 -
 drivers/staging/fbtft/fbtft-core.c                 |  14 +-
 drivers/staging/iio/impedance-analyzer/ad5933.c    |   2 +-
 drivers/tty/serial/8250/8250_exar.c                |  13 ++
 drivers/tty/serial/max310x.c                       |  33 +++-
 drivers/tty/tty_ioctl.c                            |   4 +-
 drivers/usb/core/hub.c                             |  34 ++--
 drivers/usb/dwc3/core.h                            |   1 +
 drivers/usb/dwc3/ep0.c                             |  27 ++-
 drivers/usb/dwc3/gadget.c                          | 162 +++++++++++++---
 drivers/usb/dwc3/gadget.h                          |   3 +
 drivers/usb/dwc3/host.c                            |   4 +-
 drivers/usb/gadget/function/f_mass_storage.c       |  20 +-
 drivers/usb/host/xhci-plat.c                       |   3 +
 drivers/usb/serial/cp210x.c                        |   1 +
 drivers/usb/serial/option.c                        |   1 +
 drivers/usb/serial/qcserial.c                      |   2 +
 drivers/usb/typec/ucsi/ucsi_acpi.c                 |  17 +-
 drivers/vhost/vhost.c                              |   5 +-
 drivers/video/fbdev/broadsheetfb.c                 |  14 +-
 drivers/video/fbdev/core/fb_defio.c                | 168 +++++++++++++----
 drivers/video/fbdev/core/fbmem.c                   |   4 +
 drivers/video/fbdev/hecubafb.c                     |   3 +-
 drivers/video/fbdev/hyperv_fb.c                    |   8 +-
 drivers/video/fbdev/metronomefb.c                  |  14 +-
 drivers/video/fbdev/sh_mobile_lcdcfb.c             |  20 +-
 drivers/video/fbdev/smscufx.c                      |   9 +-
 drivers/video/fbdev/ssd1307fb.c                    |   3 +-
 drivers/video/fbdev/udlfb.c                        |  10 +-
 drivers/video/fbdev/xen-fbfront.c                  |   8 +-
 drivers/watchdog/it87_wdt.c                        |  14 +-
 drivers/xen/gntdev-dmabuf.c                        |  54 +++---
 fs/afs/callback.c                                  |   3 +-
 fs/afs/dir.c                                       |   8 +
 fs/afs/server.c                                    |   7 +-
 fs/btrfs/ctree.h                                   |  22 +++
 fs/btrfs/delayed-inode.c                           |   5 +-
 fs/btrfs/delayed-inode.h                           |   1 +
 fs/btrfs/disk-io.c                                 |  13 +-
 fs/btrfs/extent-tree.c                             |   3 +-
 fs/btrfs/inode.c                                   | 172 ++++++++++-------
 fs/btrfs/ioctl.c                                   |  12 ++
 fs/btrfs/qgroup.c                                  |  14 ++
 fs/btrfs/ref-verify.c                              |   6 +-
 fs/btrfs/send.c                                    |   2 +-
 fs/btrfs/sysfs.c                                   |   9 +-
 fs/btrfs/tree-checker.c                            |   2 +-
 fs/ceph/caps.c                                     |  12 +-
 fs/cifs/smb2misc.c                                 |   2 +-
 fs/cifs/smb2ops.c                                  |  14 +-
 fs/cifs/smb2pdu.c                                  |  13 +-
 fs/cifs/smb2pdu.h                                  |  42 +++--
 fs/dcache.c                                        |   7 +-
 fs/ecryptfs/inode.c                                |   8 +
 fs/exec.c                                          |   3 +
 fs/ext4/mballoc.c                                  |  26 ++-
 fs/ext4/move_extent.c                              |   6 +-
 fs/ext4/resize.c                                   |  37 ++--
 fs/f2fs/compress.c                                 |   4 +-
 fs/f2fs/file.c                                     |   2 +
 fs/f2fs/recovery.c                                 |  25 ++-
 fs/hugetlbfs/inode.c                               |  13 +-
 fs/ioctl.c                                         |   3 +-
 fs/jfs/jfs_dmap.c                                  |  57 +++---
 fs/jfs/jfs_dtree.c                                 |   7 +-
 fs/jfs/jfs_imap.c                                  |   3 +
 fs/jfs/jfs_mount.c                                 |   6 +-
 fs/kernfs/dir.c                                    |  12 ++
 fs/ksmbd/asn1.c                                    |   5 +
 fs/ksmbd/connection.c                              |   7 +-
 fs/ksmbd/connection.h                              |   2 +-
 fs/ksmbd/ksmbd_netlink.h                           |   3 +-
 fs/ksmbd/oplock.c                                  |  22 ++-
 fs/ksmbd/smb2pdu.c                                 |  53 +++---
 fs/ksmbd/smbacl.c                                  |  11 +-
 fs/ksmbd/transport_ipc.c                           |   4 +-
 fs/ksmbd/transport_rdma.c                          |  11 +-
 fs/ksmbd/transport_tcp.c                           |  13 +-
 fs/namei.c                                         |  60 +++---
 fs/nfsd/nfs4state.c                                |  61 +++---
 fs/nilfs2/dat.c                                    |  27 ++-
 fs/nilfs2/file.c                                   |   8 +-
 fs/nilfs2/recovery.c                               |   7 +-
 fs/nilfs2/segment.c                                |   8 +-
 fs/ntfs3/fsntfs.c                                  |  16 +-
 fs/ntfs3/index.c                                   |   3 +-
 fs/ntfs3/ntfs_fs.h                                 |   2 +-
 fs/pipe.c                                          |  19 +-
 fs/pstore/ram.c                                    |   1 +
 fs/ubifs/dir.c                                     |   2 +
 fs/xfs/xfs_super.c                                 |  27 ++-
 include/asm-generic/numa.h                         |   2 +
 include/drm/drm_color_mgmt.h                       |   1 +
 include/drm/drm_fb_helper.h                        |   3 +-
 include/drm/drm_mipi_dsi.h                         |   2 +
 include/linux/async.h                              |   2 +
 include/linux/bpf.h                                |   6 +-
 include/linux/dma-fence.h                          |  19 ++
 include/linux/dmaengine.h                          |   3 +-
 include/linux/fb.h                                 |  18 +-
 include/linux/hrtimer.h                            |   4 +-
 include/linux/irq_work.h                           |   3 +
 include/linux/lsm_hook_defs.h                      |   2 +
 include/linux/mmc/sdio_ids.h                       |   1 +
 include/linux/mmzone.h                             |  18 +-
 include/linux/netfilter/ipset/ip_set.h             |   4 +
 include/linux/overflow.h                           |  72 ++++----
 include/linux/pci_ids.h                            |   1 +
 include/linux/pipe_fs_i.h                          |  16 ++
 include/linux/pm_runtime.h                         |   4 +
 include/linux/security.h                           |   9 +
 include/linux/syscalls.h                           |   1 +
 include/net/af_unix.h                              |  20 +-
 include/net/inet_connection_sock.h                 |   8 +
 include/net/llc_pdu.h                              |   6 +-
 include/net/netfilter/nf_tables.h                  |   2 +
 include/uapi/linux/btrfs.h                         |   4 +
 include/uapi/linux/netfilter/nf_tables.h           |   2 +
 kernel/async.c                                     |  85 ++++++---
 kernel/audit.c                                     |  31 +++-
 kernel/bpf/arraymap.c                              |  12 +-
 kernel/bpf/hashtab.c                               |   6 +-
 kernel/bpf/map_in_map.c                            |   2 +-
 kernel/bpf/map_in_map.h                            |   2 +-
 kernel/bpf/syscall.c                               |   6 +
 kernel/events/core.c                               |  38 ++--
 kernel/power/swap.c                                |  38 ++--
 kernel/sched/membarrier.c                          |   9 +
 kernel/time/clocksource.c                          |  25 ++-
 kernel/time/hrtimer.c                              |  17 +-
 kernel/time/tick-sched.c                           |   5 +
 kernel/trace/ring_buffer.c                         |   2 +-
 kernel/trace/trace.c                               |  78 ++++----
 kernel/trace/trace_events_trigger.c                |   6 +-
 kernel/trace/tracing_map.c                         |   7 +-
 lib/debugobjects.c                                 | 204 ++++++++-------------
 lib/mpi/ec.c                                       |   3 +
 mm/page-writeback.c                                |   2 +-
 mm/sparse.c                                        |  17 +-
 net/8021q/vlan_netlink.c                           |   4 +
 net/bluetooth/l2cap_core.c                         |   3 +-
 net/bridge/br_cfm_netlink.c                        |   2 +-
 net/bridge/br_multicast.c                          |  20 +-
 net/bridge/br_private.h                            |   4 +-
 net/can/j1939/j1939-priv.h                         |   3 +-
 net/can/j1939/main.c                               |   2 +-
 net/can/j1939/socket.c                             |  46 +++--
 net/core/request_sock.c                            |   3 -
 net/core/skbuff.c                                  |   3 +-
 net/hsr/hsr_device.c                               |   4 +-
 net/ipv4/af_inet.c                                 |   9 +-
 net/ipv4/inet_connection_sock.c                    |   4 +
 net/ipv4/ip_output.c                               |  12 +-
 net/ipv4/ip_tunnel_core.c                          |   2 +-
 net/ipv4/tcp.c                                     |  13 +-
 net/ipv6/addrconf_core.c                           |  21 ++-
 net/ipv6/af_inet6.c                                |   3 +
 net/ipv6/ip6_tunnel.c                              |  28 ++-
 net/llc/af_llc.c                                   |  26 ++-
 net/llc/llc_core.c                                 |   7 -
 net/mac80211/tx.c                                  |   3 +-
 net/mptcp/protocol.c                               |   3 -
 net/netfilter/ipset/ip_set_bitmap_gen.h            |  14 +-
 net/netfilter/ipset/ip_set_core.c                  |  39 +++-
 net/netfilter/ipset/ip_set_hash_gen.h              |  19 +-
 net/netfilter/ipset/ip_set_list_set.c              |  13 +-
 net/netfilter/nf_log.c                             |   7 +-
 net/netfilter/nf_tables_api.c                      |  34 ++--
 net/netfilter/nft_chain_filter.c                   |  11 +-
 net/netfilter/nft_compat.c                         |  23 ++-
 net/netfilter/nft_ct.c                             |  27 +++
 net/netfilter/nft_flow_offload.c                   |   5 +
 net/netfilter/nft_limit.c                          |  23 ++-
 net/netfilter/nft_nat.c                            |   5 +
 net/netfilter/nft_rt.c                             |   5 +
 net/netfilter/nft_set_pipapo.c                     | 108 +++++------
 net/netfilter/nft_set_pipapo.h                     |  18 +-
 net/netfilter/nft_set_pipapo_avx2.c                |  17 +-
 net/netfilter/nft_set_rbtree.c                     |   6 +-
 net/netfilter/nft_socket.c                         |   5 +
 net/netfilter/nft_synproxy.c                       |   7 +-
 net/netfilter/nft_tproxy.c                         |   5 +
 net/netfilter/nft_tunnel.c                         |   1 +
 net/netfilter/nft_xfrm.c                           |   5 +
 net/netlink/af_netlink.c                           |   2 +-
 net/nfc/nci/core.c                                 |   4 +
 net/openvswitch/flow_netlink.c                     |  49 +++--
 net/rds/af_rds.c                                   |   2 +-
 net/rxrpc/conn_event.c                             |   8 +
 net/rxrpc/conn_service.c                           |   3 +-
 net/smc/smc_diag.c                                 |   2 +-
 net/sunrpc/xprtmultipath.c                         |  17 +-
 net/tipc/bearer.c                                  |   6 +
 net/unix/af_unix.c                                 |  14 +-
 net/unix/diag.c                                    |   2 +-
 net/unix/garbage.c                                 |  12 ++
 net/wireless/scan.c                                |   4 +
 scripts/decode_stacktrace.sh                       |  60 +++++-
 scripts/get_abi.pl                                 |   2 +-
 scripts/link-vmlinux.sh                            |   9 +-
 scripts/mod/sumversion.c                           |   7 +-
 security/security.c                                |  32 +++-
 security/selinux/hooks.c                           |  28 +++
 security/smack/smack_lsm.c                         |   1 +
 security/tomoyo/tomoyo.c                           |   1 +
 sound/hda/hdac_stream.c                            |   9 +-
 sound/hda/intel-dsp-config.c                       |  10 +
 sound/pci/hda/hda_intel.c                          |   2 +
 sound/pci/hda/patch_conexant.c                     | 133 +++++++++++++-
 sound/pci/hda/patch_cs8409.c                       |   1 +
 sound/pci/hda/patch_realtek.c                      |   3 +
 sound/soc/codecs/lpass-wsa-macro.c                 |   7 -
 sound/soc/codecs/rt5645.c                          |   1 +
 sound/soc/codecs/wcd938x.c                         |   2 +-
 sound/usb/quirks.c                                 |   4 +
 tools/build/feature/test-libopencsd.c              |   4 +-
 tools/lib/bpf/libbpf.c                             |   2 +
 tools/lib/subcmd/help.c                            |  18 +-
 tools/testing/selftests/bpf/cgroup_helpers.c       |  18 +-
 tools/testing/selftests/bpf/prog_tests/btf.c       |   1 +
 tools/testing/selftests/bpf/prog_tests/tailcalls.c |  55 ------
 tools/testing/selftests/bpf/progs/pyperf180.c      |  22 +++
 .../selftests/bpf/progs/tailcall_bpf2bpf6.c        |  42 -----
 .../drivers/net/netdevsim/udp_tunnel_nic.sh        |   9 +
 tools/testing/selftests/net/pmtu.sh                |  34 ++--
 tools/testing/selftests/net/setup_veth.sh          |   2 +-
 tools/testing/selftests/net/udpgro_fwd.sh          |  14 +-
 tools/testing/selftests/net/udpgso_bench_rx.c      |   2 +-
 tools/testing/selftests/sgx/test_encl.lds          |   6 +-
 527 files changed, 5153 insertions(+), 2726 deletions(-)



