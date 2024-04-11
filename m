Return-Path: <linux-kernel+bounces-140229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 483258A0E85
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 12:15:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F182C286C42
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 10:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BB69145353;
	Thu, 11 Apr 2024 10:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FeSyXqxc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3245313F452;
	Thu, 11 Apr 2024 10:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712830525; cv=none; b=lVUScp4ChDQj4ato/tX4P/V+YkULTL4f4egTPDrz0cK94Qk/lvvemhRatQNQQh3FgdNP4kp/mEItpI17iqyKR38U2cp54jk5M/nJ8rDlp87/jcJZWx5qUmnKdpgkP2v2Fmnruh2ejDnIESVqTksIbibCcZoWbu+xdNu8UNQFnxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712830525; c=relaxed/simple;
	bh=b05sTv6JM7WoqM4Uuwrc8y337BSZqOL9EJ03Qjchgn8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SiCW2AD9Yb0du2cZOAySXd66EzjLLMjnLAgfuAKXaYjZaZxje6x+xdY6c/RvEKfzrvhaQum3Qw+nRUDwea+E7SA6i2IUl0+5zCkSgaZ0yOM9bzOTgypLD2/j3WphXB12jGQpbFEo8VcXf0v10SmDFuyGMsNVh3fjEQYNWChsX9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FeSyXqxc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A9D1C433F1;
	Thu, 11 Apr 2024 10:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712830525;
	bh=b05sTv6JM7WoqM4Uuwrc8y337BSZqOL9EJ03Qjchgn8=;
	h=From:To:Cc:Subject:Date:From;
	b=FeSyXqxcho16ocx4c1CzeZhDUo7jd8f1EoVqk4wkmWjb1Y8FfOeGBAfUlXACAfwrN
	 yYW530B6ITdzt3qplkSBVA2UArK6y2fVQAMiaUU9W+q6lSwksktnzALd+5ApOVIYr3
	 zcI6jMsmqohhrqHbncH0+wpAECGSqcm9uuAvxZSI=
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
	allen.lkml@gmail.com,
	broonie@kernel.org
Subject: [PATCH 5.4 000/215] 5.4.274-rc1 review
Date: Thu, 11 Apr 2024 11:53:29 +0200
Message-ID: <20240411095424.875421572@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.274-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.4.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.4.274-rc1
X-KernelTest-Deadline: 2024-04-13T09:54+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is the start of the stable review cycle for the 5.4.274 release.
There are 215 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Sat, 13 Apr 2024 09:53:55 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.274-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 5.4.274-rc1

Zhang Shurong <zhang_shurong@foxmail.com>
    firmware: meson_sm: fix to avoid potential NULL pointer dereference

Hangbin Liu <liuhangbin@gmail.com>
    ip_gre: do not report erspan version on GRE interface

William Tu <u9012063@gmail.com>
    erspan: Check IFLA_GRE_ERSPAN_VER is set.

Vasiliy Kovalev <kovalev@altlinux.org>
    VMCI: Fix possible memcpy() run-time warning in vmci_datagram_invoke_guest_handler()

Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
    Bluetooth: btintel: Fixe build regression

Juergen Gross <jgross@suse.com>
    x86/alternative: Don't call text_poke() in lazy TLB mode

Chris Wilson <chris@chris-wilson.co.uk>
    drm/i915/gt: Reset queue_priority_hint on parking

David Hildenbrand <david@redhat.com>
    x86/mm/pat: fix VM_PAT handling in COW mappings

David Hildenbrand <david@redhat.com>
    virtio: reenable config if freezing device failed

Guo Mengqi <guomengqi3@huawei.com>
    drm/vkms: call drm_atomic_helper_shutdown before drm_dev_put()

Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
    tty: n_gsm: require CAP_NET_ADMIN to attach N_GSM0710 ldisc

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: discard table flag update with pending basechain deletion

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: release mutex after nft_gc_seq_end from abort path

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: release batch on table validation from abort path

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: reject new basechain after table flag update

Roman Smirnov <r.smirnov@omp.ru>
    fbmon: prevent division by zero in fb_videomode_from_videomode()

Aleksandr Burakov <a.burakov@rosalinux.ru>
    fbdev: viafb: fix typo in hw_bitblt_1 and hw_bitblt_2

Colin Ian King <colin.i.king@gmail.com>
    usb: sl811-hcd: only defined function checkdone if QUIRK2 is defined

Marco Felsch <m.felsch@pengutronix.de>
    usb: typec: tcpci: add generic tcpci fallback compatible

Petre Rodan <petre.rodan@subdimension.ro>
    tools: iio: replace seekdir() in iio_generic_buffer

Ricardo B. Marliere <ricardo@marliere.net>
    ktest: force $buildonly = 1 for 'make_warnings_file' test type

Gergo Koteles <soyer@irl.hu>
    Input: allocate keycode for Display refresh rate toggle

Roman Smirnov <r.smirnov@omp.ru>
    block: prevent division by zero in blk_rq_stat_sum()

Daniel Drake <drake@endlessos.org>
    Revert "ACPI: PM: Block ASUS B1400CEAE from suspend to idle by default"

Dai Ngo <dai.ngo@oracle.com>
    SUNRPC: increase size of rpc_wait_queue.qlen from unsigned short to unsigned int

Aric Cyr <aric.cyr@amd.com>
    drm/amd/display: Fix nanosec stat overflow

Arnd Bergmann <arnd@arndb.de>
    media: sta2x11: fix irq handler cast

Alex Henrie <alexhenrie24@gmail.com>
    isofs: handle CDs with bad root inode but good Joliet root directory

Justin Tee <justin.tee@broadcom.com>
    scsi: lpfc: Fix possible memory leak in lpfc_rcv_padisc()

Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
    sysv: don't call sb_bread() with pointers_lock held

Kunwu Chan <chentao@kylinos.cn>
    Input: synaptics-rmi4 - fail probing if memory allocation for "phys" fails

Edward Adam Davis <eadavis@qq.com>
    Bluetooth: btintel: Fix null ptr deref in btintel_read_version

David Sterba <dsterba@suse.com>
    btrfs: send: handle path ref underflow in header iterate_inode_ref()

David Sterba <dsterba@suse.com>
    btrfs: export: handle invalid inode or root reference in btrfs_get_parent()

David Sterba <dsterba@suse.com>
    btrfs: handle chunk tree lookup error in btrfs_relocate_sys_chunks()

Samasth Norway Ananda <samasth.norway.ananda@oracle.com>
    tools/power x86_energy_perf_policy: Fix file leak in get_pkg_num()

Shannon Nelson <shannon.nelson@amd.com>
    ionic: set adminq irq affinity

Johan Jonker <jbx6244@gmail.com>
    arm64: dts: rockchip: fix rk3399 hdmi ports node

Johan Jonker <jbx6244@gmail.com>
    arm64: dts: rockchip: fix rk3328 hdmi ports node

John Ogness <john.ogness@linutronix.de>
    panic: Flush kernel log buffer at the end

Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
    VMCI: Fix memcpy() run-time warning in dg_dispatch_as_host()

Markus Elfring <elfring@users.sourceforge.net>
    batman-adv: Improve exception handling in batadv_throw_uevent()

Markus Elfring <elfring@users.sourceforge.net>
    batman-adv: Return directly after a failed batadv_dat_select_candidates() in batadv_dat_forward_data()

Dmitry Antipov <dmantipov@yandex.ru>
    wifi: ath9k: fix LNA selection in ath_ant_try_scan()

Sumanth Korikkar <sumanthk@linux.ibm.com>
    s390/entry: align system call table on 8 bytes

Borislav Petkov (AMD) <bp@alien8.de>
    x86/mce: Make sure to grab mce_sysfs_mutex in set_bank()

I Gede Agastya Darma Laksana <gedeagas22@gmail.com>
    ALSA: hda/realtek: Update Panasonic CF-SZ6 quirk to support headset with microphone

Arnd Bergmann <arnd@arndb.de>
    ata: sata_mv: Fix PCI device ID table declaration compilation warning

Arnd Bergmann <arnd@arndb.de>
    scsi: mylex: Fix sysfs buffer lengths

Arnd Bergmann <arnd@arndb.de>
    ata: sata_sx4: fix pdc20621_get_from_dimm() on 64-bit

Stephen Lee <slee08177@gmail.com>
    ASoC: ops: Fix wraparound for mask in snd_soc_get_volsw

Paul Barker <paul.barker.ct@bp.renesas.com>
    net: ravb: Always process TX descriptor ring

Eric Dumazet <edumazet@google.com>
    erspan: make sure erspan_base_hdr is present in skb->head

William Tu <u9012063@gmail.com>
    erspan: Add type I version 0 support.

John Sperbeck <jsperbeck@google.com>
    init: open /initrd.image with O_LARGEFILE

Christoph Hellwig <hch@lst.de>
    initramfs: switch initramfs unpacking to struct file based APIs

Christoph Hellwig <hch@lst.de>
    fs: add a vfs_fchmod helper

Christoph Hellwig <hch@lst.de>
    fs: add a vfs_fchown helper

Dan Carpenter <dan.carpenter@linaro.org>
    staging: vc04_services: fix information leak in create_component()

Arnd Bergmann <arnd@arndb.de>
    staging: vc04_services: changen strncpy() to strscpy_pad()

Dave Stevenson <dave.stevenson@raspberrypi.org>
    staging: mmal-vchiq: Fix client_component for 64 bit kernel

Dave Stevenson <dave.stevenson@raspberrypi.org>
    staging: mmal-vchiq: Allocate and free components as required

Aleksandr Loktionov <aleksandr.loktionov@intel.com>
    i40e: fix vf may be used uninitialized in this function warning

Kuniyuki Iwashima <kuniyu@amazon.com>
    ipv6: Fix infinite recursion in fib6_dump_done().

Jakub Kicinski <kuba@kernel.org>
    selftests: reuseaddr_conflict: add missing new line at the end of the output

Piotr Wejman <piotrwejman90@gmail.com>
    net: stmmac: fix rx queue priority assignment

Eric Dumazet <edumazet@google.com>
    net/sched: act_skbmod: prevent kernel-infoleak

Jakub Sitnicki <jakub@cloudflare.com>
    bpf, sockmap: Prevent lock inversion deadlock in map delete elem

Ziyang Xuan <william.xuanziyang@huawei.com>
    netfilter: nf_tables: Fix potential data-race in __nft_flowtable_type_get()

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: flush pending destroy work before exit_net release

Vlastimil Babka <vbabka@suse.cz>
    mm, vmscan: prevent infinite loop for costly GFP_NOIO | __GFP_RETRY_MAYFAIL allocations

Ingo Molnar <mingo@kernel.org>
    Revert "x86/mm/ident_map: Use gbpages only where full GB page should be mapped."

Alex Williamson <alex.williamson@redhat.com>
    vfio/platform: Create persistent IRQ handlers

Alex Williamson <alex.williamson@redhat.com>
    vfio/pci: Create persistent INTx handler

Alex Williamson <alex.williamson@redhat.com>
    vfio: Introduce interface to flush virqfd inject workqueue

Alex Williamson <alex.williamson@redhat.com>
    vfio/pci: Lock external INTx masking ops

Alex Williamson <alex.williamson@redhat.com>
    vfio/pci: Disable auto-enable of exclusive INTx IRQ

Mahmoud Adam <mngyadam@amazon.com>
    net/rds: fix possible cp null dereference

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: disallow timeout for anonymous sets

Bastien Nocera <hadess@hadess.net>
    Bluetooth: Fix TOCTOU in HCI debugfs implementation

Hui Wang <hui.wang@canonical.com>
    Bluetooth: hci_event: set the conn encrypted before conn establishes

Sandipan Das <sandipan.das@amd.com>
    x86/cpufeatures: Add new word for scattered features

Heiner Kallweit <hkallweit1@gmail.com>
    r8169: fix issue caused by buggy BIOS on certain boards with RTL8168d

Arnd Bergmann <arnd@arndb.de>
    dm integrity: fix out-of-range warning

Eric Dumazet <edumazet@google.com>
    tcp: properly terminate timers for kernel sockets

Przemek Kitszel <przemyslaw.kitszel@intel.com>
    ixgbe: avoid sleeping allocation in ixgbe_ipsec_vf_add_sa()

Ryosuke Yasuoka <ryasuoka@redhat.com>
    nfc: nci: Fix uninit-value in nci_dev_up and nci_ntf_packet

Alan Stern <stern@rowland.harvard.edu>
    USB: core: Fix deadlock in usb_deauthorize_interface()

Muhammad Usama Anjum <usama.anjum@collabora.com>
    scsi: lpfc: Correct size for wqe for memset()

Kim Phillips <kim.phillips@amd.com>
    x86/cpu: Enable STIBP on AMD if Automatic IBRS is enabled

Quinn Tran <qutran@marvell.com>
    scsi: qla2xxx: Fix command flush on cable pull

yuan linyu <yuanlinyu@hihonor.com>
    usb: udc: remove warning when queue disabled ep

Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
    usb: dwc2: gadget: LPM flow fix

Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
    usb: dwc2: host: Fix ISOC flow in DDMA mode

Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
    usb: dwc2: host: Fix hibernation flow

Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
    usb: dwc2: host: Fix remote wakeup from hibernation

Guilherme G. Piccoli <gpiccoli@igalia.com>
    scsi: core: Fix unremoved procfs host directory regression

Duoming Zhou <duoming@zju.edu.cn>
    ALSA: sh: aica: reorder cleanup operations to avoid UAF bugs

Oliver Neukum <oneukum@suse.com>
    usb: cdc-wdm: close race between read and workqueue

Mikko Rapeli <mikko.rapeli@linaro.org>
    mmc: core: Avoid negative index with array access

Mikko Rapeli <mikko.rapeli@linaro.org>
    mmc: core: Initialize mmc_blk_ioc_data

Max Filippov <jcmvbkbc@gmail.com>
    exec: Fix NOMMU linux_binprm::exec in transfer_args_to_stack()

Felix Fietkau <nbd@nbd.name>
    wifi: mac80211: check/clear fast rx for non-4addr sta VLAN changes

Zi Yan <ziy@nvidia.com>
    mm/migrate: set swap entry values of THP tail pages properly.

Liu Shixin <liushixin2@huawei.com>
    mm/memory-failure: fix an incorrect use of tail pages

Yangxi Xiang <xyangxi5@gmail.com>
    vt: fix memory overlapping when deleting chars in the buffer

Matthew Wilcox (Oracle) <willy@infradead.org>
    bounds: support non-power-of-two CONFIG_NR_CPUS

Nathan Chancellor <nathan@kernel.org>
    powerpc: xor_vmx: Add '-mhard-float' to CFLAGS

Tim Schumacher <timschumi@gmx.de>
    efivarfs: Request at most 512 bytes for variable names

Yang Jihong <yangjihong1@huawei.com>
    perf/core: Fix reentry problem in perf_output_read_group()

Zhong Jinghua <zhongjinghua@huawei.com>
    loop: loop_set_status_from_info() check before assignment

Siddh Raman Pant <code@siddh.me>
    loop: Check for overflow while configuring loop

Martijn Coenen <maco@android.com>
    loop: Factor out configuring loop from status

Martijn Coenen <maco@android.com>
    loop: Refactor loop_set_status() size calculation

Martijn Coenen <maco@android.com>
    loop: Factor out setting loop device size

Martijn Coenen <maco@android.com>
    loop: Remove sector_t truncation checks

Martijn Coenen <maco@android.com>
    loop: Call loop_config_discard() only after new config is applied

Genjian Zhang <zhanggenjian@kylinos.cn>
    Revert "loop: Check for overflow while configuring loop"

Goldwyn Rodrigues <rgoldwyn@suse.com>
    btrfs: allocate btrfs_ioctl_defrag_range_args on stack

John Ogness <john.ogness@linutronix.de>
    printk: Update @console_may_schedule in console_trylock_spinning()

Maximilian Heyne <mheyne@amazon.de>
    xen/events: close evtchn after mapping cleanup

Rui Qi <qirui.001@bytedance.com>
    x86/speculation: Support intra-function call validation

Alexandre Chartre <alexandre.chartre@oracle.com>
    objtool: Add support for intra-function calls

Alexandre Chartre <alexandre.chartre@oracle.com>
    objtool: is_fentry_call() crashes if call has no destination

Bart Van Assche <bvanassche@acm.org>
    fs/aio: Check IOCB_AIO_RW before the struct aio_kiocb conversion

Nicolas Pitre <nico@fluxnic.net>
    vt: fix unicode buffer corruption when deleting characters

Sherry Sun <sherry.sun@nxp.com>
    tty: serial: fsl_lpuart: avoid idle preamble pending if CTS is enabled

Mathias Nyman <mathias.nyman@linux.intel.com>
    usb: port: Don't try to peer unused USB ports based on location

Krishna Kurapati <quic_kriskura@quicinc.com>
    usb: gadget: ncm: Fix handling of zero block length packets

Alan Stern <stern@rowland.harvard.edu>
    USB: usb-storage: Prevent divide-by-0 error in isd200_ata_command

Kailang Yang <kailang@realtek.com>
    ALSA: hda/realtek - Fix headset Mic no show at resume back for Lenovo ALC897 platform

Nathan Chancellor <nathan@kernel.org>
    xfrm: Avoid clang fortify warning in copy_to_user_tmpl()

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: reject constant set with timeout

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: disallow anonymous set with timeout flag

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: mark set as dead when unbinding anonymous set with timeout

Ian Abbott <abbotti@mev.co.uk>
    comedi: comedi_test: Prevent timers rescheduling during deletion

Mikulas Patocka <mpatocka@redhat.com>
    dm snapshot: fix lockup in dm_exception_table_exit

Conrad Kostecki <conikost@gentoo.org>
    ahci: asm1064: asm1166: don't limit reported ports

Andrey Jr. Melnikov <temnota.am@gmail.com>
    ahci: asm1064: correct count of reported ports

Borislav Petkov (AMD) <bp@alien8.de>
    x86/CPU/AMD: Update the Zenbleed microcode revisions

Ryusuke Konishi <konishi.ryusuke@gmail.com>
    nilfs2: prevent kernel bug at submit_bh_wbc()

Joe Perches <joe@perches.com>
    nilfs2: use a more common logging style

Ryusuke Konishi <konishi.ryusuke@gmail.com>
    nilfs2: fix failure to detect DAT corruption in btree and direct mappings

Qiang Zhang <qiang4.zhang@intel.com>
    memtest: use {READ,WRITE}_ONCE in memory scanning

Jani Nikula <jani.nikula@intel.com>
    drm/vc4: hdmi: do not return negative values from .get_modes()

Jani Nikula <jani.nikula@intel.com>
    drm/imx/ipuv3: do not return negative values from .get_modes()

Jani Nikula <jani.nikula@intel.com>
    drm/exynos: do not return negative values from .get_modes()

Harald Freudenberger <freude@linux.ibm.com>
    s390/zcrypt: fix reference counting on zcrypt card objects

Sean Anderson <sean.anderson@linux.dev>
    soc: fsl: qbman: Use raw spinlock for cgr_lock

Sean Anderson <sean.anderson@seco.com>
    soc: fsl: qbman: Add CGR update function

Sean Anderson <sean.anderson@seco.com>
    soc: fsl: qbman: Add helper for sanity checking cgr ops

Sean Anderson <sean.anderson@linux.dev>
    soc: fsl: qbman: Always disable interrupts when taking cgr_lock

Steven Rostedt (Google) <rostedt@goodmis.org>
    ring-buffer: Fix full_waiters_pending in poll

Steven Rostedt (Google) <rostedt@goodmis.org>
    ring-buffer: Fix resetting of shortest_full

Alex Williamson <alex.williamson@redhat.com>
    vfio/platform: Disable virqfds on cleanup

Nathan Chancellor <nathan@kernel.org>
    kbuild: Move -Wenum-{compare-conditional,enum-conversion} into W=1

Samuel Thibault <samuel.thibault@ens-lyon.org>
    speakup: Fix 8bit characters from direct synth

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    slimbus: core: Remove usage of the deprecated ida_simple_xx() API

Jerome Brunet <jbrunet@baylibre.com>
    nvmem: meson-efuse: fix function pointer type mismatch

Carlo Caione <ccaione@baylibre.com>
    firmware: meson_sm: Rework driver as a proper platform driver

Maximilian Heyne <mheyne@amazon.de>
    ext4: fix corruption during on-line resize

Josua Mayer <josua@solid-run.com>
    hwmon: (amc6821) add of_match table

Dominique Martinet <dominique.martinet@atmark-techno.com>
    mmc: core: Fix switch on gp3 partition

Yu Kuai <yukuai3@huawei.com>
    dm-raid: fix lockdep waring in "pers->hot_add_disk"

Song Liu <song@kernel.org>
    Revert "Revert "md/raid5: Wait for MD_SB_CHANGE_PENDING in raid5d""

Rafael J. Wysocki <rafael.j.wysocki@intel.com>
    PCI/PM: Drain runtime-idle callbacks before driver removal

Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
    PCI: Drop pci_device_remove() test of pci_dev->driver

Filipe Manana <fdmanana@suse.com>
    btrfs: fix off-by-one chunk length calculation at contains_pending_extent()

Miklos Szeredi <mszeredi@redhat.com>
    fuse: don't unhash root

Max Reitz <mreitz@redhat.com>
    fuse: drop fuse_conn parameter where possible

Max Reitz <mreitz@redhat.com>
    fuse: store fuse_conn in fuse_req

Wolfram Sang <wsa+renesas@sang-engineering.com>
    mmc: tmio: avoid concurrent runs of mmc_request_done()

Qingliang Li <qingliang.li@mediatek.com>
    PM: sleep: wakeirq: fix wake irq warning in system suspend

Toru Katagiri <Toru.Katagiri@tdk.com>
    USB: serial: cp210x: add pid/vid for TDK NC0110013M and MM0110113M

Aurélien Jacobs <aurel@gnuage.org>
    USB: serial: option: add MeiG Smart SLM320 product

Christian Häggström <christian.haggstrom@orexplore.com>
    USB: serial: cp210x: add ID for MGP Instruments PDS100

Cameron Williams <cang1@live.co.uk>
    USB: serial: add device ID for VeriFone adapter

Daniel Vogelbacher <daniel@chaospixel.com>
    USB: serial: ftdi_sio: add support for GMC Z216C Adapter IR-USB

Michael Ellerman <mpe@ellerman.id.au>
    powerpc/fsl: Fix mfpmr build errors with newer binutils

Gabor Juhos <j4g8y7@gmail.com>
    clk: qcom: mmcc-msm8974: fix terminating of frequency table arrays

Gabor Juhos <j4g8y7@gmail.com>
    clk: qcom: mmcc-apq8084: fix terminating of frequency table arrays

Gabor Juhos <j4g8y7@gmail.com>
    clk: qcom: gcc-ipq8074: fix terminating of frequency table arrays

Maulik Shah <quic_mkshah@quicinc.com>
    PM: suspend: Set mem_sleep_current during kernel command line setup

Guenter Roeck <linux@roeck-us.net>
    parisc: Strip upper 32 bit of sum in csum_ipv6_magic for 64-bit builds

Guenter Roeck <linux@roeck-us.net>
    parisc: Fix csum_ipv6_magic on 64-bit systems

Guenter Roeck <linux@roeck-us.net>
    parisc: Fix csum_ipv6_magic on 32-bit systems

Guenter Roeck <linux@roeck-us.net>
    parisc: Fix ip_fast_csum

Helge Deller <deller@gmx.de>
    parisc: Do not hardcode registers in checksum functions

Arseniy Krasnov <avkrasnov@salutedevices.com>
    mtd: rawnand: meson: fix scrambling mode value in command macro

Zhang Yi <yi.zhang@huawei.com>
    ubi: correct the calculation of fastmap size

Richard Weinberger <richard@nod.at>
    ubi: Check for too small LEB size in VTBL code

Matthew Wilcox (Oracle) <willy@infradead.org>
    ubifs: Set page uptodate in the correct place

Jan Kara <jack@suse.cz>
    fat: fix uninitialized field in nostale filehandles

Baokun Li <libaokun1@huawei.com>
    ext4: correct best extent lstart adjustment logic

SeongJae Park <sj@kernel.org>
    selftests/mqueue: Set timeout to 180 seconds

Damian Muszynski <damian.muszynski@intel.com>
    crypto: qat - resolve race condition during AER recovery

Svyatoslav Pankratov <svyatoslav.pankratov@intel.com>
    crypto: qat - fix double free during reset

Randy Dunlap <rdunlap@infradead.org>
    sparc: vDSO: fix return value of __setup handler

Randy Dunlap <rdunlap@infradead.org>
    sparc64: NMI watchdog: fix return value of __setup handler

Sean Christopherson <seanjc@google.com>
    KVM: Always flush async #PF workqueue when vCPU is being destroyed

Gui-Dong Han <2045gemini@gmail.com>
    media: xc4000: Fix atomicity violation in xc4000_get_frequency

Hugo Villeneuve <hvilleneuve@dimonoff.com>
    serial: max310x: fix NULL pointer dereference in I2C instantiation

Duje Mihanović <duje.mihanovic@skole.hr>
    arm: dts: marvell: Fix maxium->maxim typo in brownstone dts

Lubomir Rintel <lkundrak@v3.sk>
    ARM: dts: mmp2-brownstone: Don't redeclare phandle references

Roberto Sassu <roberto.sassu@huawei.com>
    smack: Handle SMACK64TRANSMUTE in smack_inode_setsecurity()

Roberto Sassu <roberto.sassu@huawei.com>
    smack: Set SMACK64TRANSMUTE only for dirs in smack_inode_setxattr()

Amit Pundir <amit.pundir@linaro.org>
    clk: qcom: gcc-sdm845: Add soft dependency on rpmhpd

Hidenori Kobayashi <hidenorik@chromium.org>
    media: staging: ipu3-imgu: Set fields before media_entity_pads_init()

Zheng Wang <zyytlz.wz@163.com>
    wifi: brcmfmac: Fix use-after-free bug in brcmf_cfg80211_detach

Thomas Gleixner <tglx@linutronix.de>
    timers: Rename del_timer_sync() to timer_delete_sync()

Thomas Gleixner <tglx@linutronix.de>
    timers: Use del_timer_sync() even on UP

Thomas Gleixner <tglx@linutronix.de>
    timers: Update kernel-doc for various functions

Borislav Petkov <bp@suse.de>
    x86/bugs: Use sysfs_emit()

Kim Phillips <kim.phillips@amd.com>
    x86/cpu: Support AMD Automatic IBRS

Lin Yujun <linyujun809@huawei.com>
    Documentation/hw-vuln: Update spectre doc


-------------

Diffstat:

 Documentation/admin-guide/hw-vuln/spectre.rst      |  18 +-
 Documentation/admin-guide/kernel-parameters.txt    |   6 +-
 Makefile                                           |   4 +-
 arch/arm/boot/dts/mmp2-brownstone.dts              | 330 ++++++++++-----------
 arch/arm64/boot/dts/rockchip/rk3328.dtsi           |  11 +-
 arch/arm64/boot/dts/rockchip/rk3399.dtsi           |  12 +-
 arch/parisc/include/asm/checksum.h                 | 107 +++----
 arch/powerpc/include/asm/reg_fsl_emb.h             |  11 +-
 arch/powerpc/lib/Makefile                          |   2 +-
 arch/s390/kernel/entry.S                           |   1 +
 arch/sparc/kernel/nmi.c                            |   2 +-
 arch/sparc/vdso/vma.c                              |   7 +-
 arch/x86/include/asm/cpufeature.h                  |   6 +-
 arch/x86/include/asm/cpufeatures.h                 |   4 +-
 arch/x86/include/asm/disabled-features.h           |   3 +-
 arch/x86/include/asm/mmu_context.h                 |   9 +
 arch/x86/include/asm/msr-index.h                   |   2 +
 arch/x86/include/asm/nospec-branch.h               |   7 +
 arch/x86/include/asm/required-features.h           |   3 +-
 arch/x86/include/asm/unwind_hints.h                |   2 +-
 arch/x86/kernel/cpu/amd.c                          |  10 +-
 arch/x86/kernel/cpu/bugs.c                         | 117 ++++----
 arch/x86/kernel/cpu/common.c                       |  19 +-
 arch/x86/kernel/cpu/mce/core.c                     |   4 +-
 arch/x86/mm/ident_map.c                            |  23 +-
 arch/x86/mm/pat.c                                  |  50 +++-
 block/blk-stat.c                                   |   2 +-
 drivers/acpi/sleep.c                               |  12 -
 drivers/ata/ahci.c                                 |   5 -
 drivers/ata/sata_mv.c                              |  63 ++--
 drivers/ata/sata_sx4.c                             |   6 +-
 drivers/base/power/wakeirq.c                       |   4 +-
 drivers/block/loop.c                               | 187 +++++++-----
 drivers/bluetooth/btintel.c                        |   2 +-
 drivers/clk/qcom/gcc-ipq8074.c                     |   2 +
 drivers/clk/qcom/gcc-sdm845.c                      |   1 +
 drivers/clk/qcom/mmcc-apq8084.c                    |   2 +
 drivers/clk/qcom/mmcc-msm8974.c                    |   2 +
 drivers/crypto/qat/qat_common/adf_aer.c            |  23 +-
 drivers/firmware/efi/vars.c                        |  17 +-
 drivers/firmware/meson/meson_sm.c                  |  96 ++++--
 .../gpu/drm/amd/display/modules/inc/mod_stats.h    |   4 +-
 drivers/gpu/drm/exynos/exynos_drm_vidi.c           |   4 +-
 drivers/gpu/drm/exynos/exynos_hdmi.c               |   4 +-
 drivers/gpu/drm/i915/gt/intel_engine_pm.c          |   3 -
 drivers/gpu/drm/i915/gt/intel_lrc.c                |   3 +
 drivers/gpu/drm/imx/parallel-display.c             |   4 +-
 drivers/gpu/drm/vc4/vc4_hdmi.c                     |   2 +-
 drivers/gpu/drm/vkms/vkms_drv.c                    |   2 +-
 drivers/hwmon/amc6821.c                            |  11 +
 drivers/input/rmi4/rmi_driver.c                    |   6 +-
 drivers/md/dm-integrity.c                          |   2 +-
 drivers/md/dm-raid.c                               |   2 +
 drivers/md/dm-snap.c                               |   4 +-
 drivers/md/raid5.c                                 |  12 +
 drivers/media/pci/sta2x11/sta2x11_vip.c            |   9 +-
 drivers/media/tuners/xc4000.c                      |   4 +-
 drivers/misc/vmw_vmci/vmci_datagram.c              |   6 +-
 drivers/mmc/core/block.c                           |  14 +-
 drivers/mmc/host/tmio_mmc_core.c                   |   2 +
 drivers/mtd/nand/raw/meson_nand.c                  |   2 +-
 drivers/mtd/ubi/fastmap.c                          |   7 +-
 drivers/mtd/ubi/vtbl.c                             |   6 +
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |  34 +--
 drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c     |  16 +-
 drivers/net/ethernet/pensando/ionic/ionic_lif.c    |   5 +-
 drivers/net/ethernet/realtek/r8169_main.c          |   9 +
 drivers/net/ethernet/renesas/ravb_main.c           |   7 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c  |  40 ++-
 .../net/ethernet/stmicro/stmmac/dwxgmac2_core.c    |  38 ++-
 drivers/net/wireless/ath/ath9k/antenna.c           |   2 +-
 .../broadcom/brcm80211/brcmfmac/cfg80211.c         |   4 +-
 drivers/nvmem/meson-efuse.c                        |  43 ++-
 drivers/pci/pci-driver.c                           |  23 +-
 drivers/s390/crypto/zcrypt_api.c                   |   2 +
 drivers/scsi/hosts.c                               |   7 +-
 drivers/scsi/lpfc/lpfc_nportdisc.c                 |   6 +-
 drivers/scsi/lpfc/lpfc_nvmet.c                     |   2 +-
 drivers/scsi/myrb.c                                |  20 +-
 drivers/scsi/myrs.c                                |  24 +-
 drivers/scsi/qla2xxx/qla_target.c                  |  10 +
 drivers/slimbus/core.c                             |   4 +-
 drivers/soc/fsl/qbman/qman.c                       |  98 ++++--
 drivers/staging/comedi/drivers/comedi_test.c       |  30 +-
 drivers/staging/media/ipu3/ipu3-v4l2.c             |  16 +-
 drivers/staging/speakup/synth.c                    |   4 +-
 .../vc04_services/bcm2835-camera/mmal-vchiq.c      |  40 ++-
 .../vc04_services/bcm2835-camera/mmal-vchiq.h      |   2 +
 drivers/tty/n_gsm.c                                |   3 +
 drivers/tty/serial/fsl_lpuart.c                    |   7 +-
 drivers/tty/serial/max310x.c                       |   7 +-
 drivers/tty/vt/vt.c                                |   4 +-
 drivers/usb/class/cdc-wdm.c                        |   6 +-
 drivers/usb/core/port.c                            |   5 +-
 drivers/usb/core/sysfs.c                           |  16 +-
 drivers/usb/dwc2/core.h                            |  14 +
 drivers/usb/dwc2/core_intr.c                       |  63 ++--
 drivers/usb/dwc2/gadget.c                          |   4 +
 drivers/usb/dwc2/hcd.c                             |  47 ++-
 drivers/usb/dwc2/hcd_ddma.c                        |  17 +-
 drivers/usb/dwc2/hw.h                              |   2 +-
 drivers/usb/gadget/function/f_ncm.c                |   2 +-
 drivers/usb/gadget/udc/core.c                      |   4 +-
 drivers/usb/host/sl811-hcd.c                       |   2 +
 drivers/usb/serial/cp210x.c                        |   4 +
 drivers/usb/serial/ftdi_sio.c                      |   2 +
 drivers/usb/serial/ftdi_sio_ids.h                  |   6 +
 drivers/usb/serial/option.c                        |   6 +
 drivers/usb/storage/isd200.c                       |  23 +-
 drivers/usb/typec/tcpm/tcpci.c                     |   1 +
 drivers/vfio/pci/vfio_pci_intrs.c                  | 188 +++++++-----
 drivers/vfio/platform/vfio_platform_irq.c          | 106 ++++---
 drivers/vfio/virqfd.c                              |  21 ++
 drivers/video/fbdev/core/fbmon.c                   |   7 +-
 drivers/video/fbdev/via/accel.c                    |   4 +-
 drivers/virtio/virtio.c                            |  10 +-
 drivers/xen/events/events_base.c                   |   5 +-
 fs/aio.c                                           |   8 +-
 fs/btrfs/export.c                                  |   9 +-
 fs/btrfs/ioctl.c                                   |  25 +-
 fs/btrfs/send.c                                    |  10 +-
 fs/btrfs/volumes.c                                 |  14 +-
 fs/exec.c                                          |   1 +
 fs/ext4/mballoc.c                                  |  17 +-
 fs/ext4/resize.c                                   |   3 +-
 fs/fat/nfs.c                                       |   6 +
 fs/fuse/dev.c                                      |  83 +++---
 fs/fuse/fuse_i.h                                   |   6 +-
 fs/fuse/inode.c                                    |   7 +-
 fs/fuse/virtio_fs.c                                |   8 +-
 fs/isofs/inode.c                                   |  18 +-
 fs/nilfs2/alloc.c                                  |  38 +--
 fs/nilfs2/btree.c                                  |  51 ++--
 fs/nilfs2/cpfile.c                                 |  10 +-
 fs/nilfs2/dat.c                                    |  14 +-
 fs/nilfs2/direct.c                                 |  23 +-
 fs/nilfs2/gcinode.c                                |   2 +-
 fs/nilfs2/ifile.c                                  |   4 +-
 fs/nilfs2/inode.c                                  |  31 +-
 fs/nilfs2/ioctl.c                                  |  37 ++-
 fs/nilfs2/mdt.c                                    |   2 +-
 fs/nilfs2/namei.c                                  |   6 +-
 fs/nilfs2/nilfs.h                                  |   9 +
 fs/nilfs2/page.c                                   |  11 +-
 fs/nilfs2/recovery.c                               |  32 +-
 fs/nilfs2/segbuf.c                                 |   2 +-
 fs/nilfs2/segment.c                                |  38 +--
 fs/nilfs2/sufile.c                                 |  29 +-
 fs/nilfs2/super.c                                  |  57 ++--
 fs/nilfs2/sysfs.c                                  |  29 +-
 fs/nilfs2/the_nilfs.c                              |  85 +++---
 fs/open.c                                          |  38 ++-
 fs/sysv/itree.c                                    |  10 +-
 fs/ubifs/file.c                                    |  13 +-
 include/linux/firmware/meson/meson_sm.h            |  15 +-
 include/linux/frame.h                              |  11 +
 include/linux/fs.h                                 |   3 +
 include/linux/gfp.h                                |   9 +
 include/linux/sunrpc/sched.h                       |   2 +-
 include/linux/timer.h                              |  18 +-
 include/linux/vfio.h                               |   2 +
 include/net/erspan.h                               |  19 +-
 include/net/inet_connection_sock.h                 |   1 +
 include/net/sock.h                                 |   7 +
 include/soc/fsl/qman.h                             |   9 +
 include/uapi/linux/input-event-codes.h             |   1 +
 init/initramfs.c                                   |  45 +--
 kernel/bounds.c                                    |   2 +-
 kernel/events/core.c                               |   9 +
 kernel/panic.c                                     |   8 +
 kernel/power/suspend.c                             |   1 +
 kernel/printk/printk.c                             |   6 +
 kernel/time/timer.c                                | 160 ++++++----
 kernel/trace/ring_buffer.c                         |  51 +++-
 mm/compaction.c                                    |   7 +-
 mm/memory-failure.c                                |   2 +-
 mm/memory.c                                        |   4 +
 mm/memtest.c                                       |   4 +-
 mm/migrate.c                                       |   6 +-
 mm/page_alloc.c                                    |  10 +-
 mm/vmscan.c                                        |   5 +-
 net/batman-adv/distributed-arp-table.c             |   3 +-
 net/batman-adv/main.c                              |  14 +-
 net/bluetooth/hci_debugfs.c                        |  64 ++--
 net/bluetooth/hci_event.c                          |  25 ++
 net/core/sock_map.c                                |   6 +
 net/ipv4/inet_connection_sock.c                    |  14 +
 net/ipv4/ip_gre.c                                  | 104 +++++--
 net/ipv4/tcp.c                                     |   2 +
 net/ipv6/ip6_fib.c                                 |  14 +-
 net/ipv6/ip6_gre.c                                 |   3 +
 net/mac80211/cfg.c                                 |   5 +-
 net/netfilter/nf_tables_api.c                      |  74 ++++-
 net/nfc/nci/core.c                                 |   5 +
 net/rds/rdma.c                                     |   2 +-
 net/sched/act_skbmod.c                             |  10 +-
 net/xfrm/xfrm_user.c                               |   3 +
 scripts/Makefile.extrawarn                         |   2 +
 security/smack/smack_lsm.c                         |  12 +-
 sound/pci/hda/patch_realtek.c                      |   9 +-
 sound/sh/aica.c                                    |  17 +-
 sound/soc/soc-ops.c                                |   2 +-
 tools/iio/iio_utils.c                              |   2 +-
 tools/objtool/Documentation/stack-validation.txt   |   8 +
 tools/objtool/arch/x86/decode.c                    |   6 +
 tools/objtool/check.c                              |  64 +++-
 .../x86_energy_perf_policy.c                       |   1 +
 tools/testing/ktest/ktest.pl                       |   1 +
 tools/testing/selftests/mqueue/setting             |   1 +
 tools/testing/selftests/net/reuseaddr_conflict.c   |   2 +-
 virt/kvm/async_pf.c                                |  31 +-
 211 files changed, 2599 insertions(+), 1489 deletions(-)



