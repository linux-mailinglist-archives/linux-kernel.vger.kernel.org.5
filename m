Return-Path: <linux-kernel+bounces-140252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 966B48A103C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 12:33:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48593289928
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 10:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5661D14B06B;
	Thu, 11 Apr 2024 10:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UJKo/b2Y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51AB614830D;
	Thu, 11 Apr 2024 10:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712831489; cv=none; b=jIRAheO1KCBP+kJt8ef5wM0uN2C7cL+HbBnasxIYjlG/UnySKRex/2DElhl5RIB8C6kBJlrzQ9bKe6I6oPcsJXvYbQTFej2b+S+3ogg1U63AOBtOVOzMIdeGul4JrWswEvRnFXYcQmK7KqMU13cSGadNm5Z+GK5IqpfAiMjvyEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712831489; c=relaxed/simple;
	bh=HlyuGe6MVjm65dSuuKcMNdB1a/tTajjrabOYXWghIxk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IpJW8luno6yQCxHkcQzEzLNDjCVQb/P2SNRGxUVhmuIM0scJbMZH9izdI5UmGiRbSjA5ER2Tx1p2jw+lwdcUUggyOInwwA4SjPJv6P8jOXBJc7eUkMWTAG0UDOEHf9xqHjB2mhx8sFZsusLUD2DZ+dOttezbFkLcoELd+z8JOLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UJKo/b2Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ABB8C43399;
	Thu, 11 Apr 2024 10:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712831489;
	bh=HlyuGe6MVjm65dSuuKcMNdB1a/tTajjrabOYXWghIxk=;
	h=From:To:Cc:Subject:Date:From;
	b=UJKo/b2YkWQX4iXYddxojisxsqIHRTopY431aX+qCajsBcVXzwXQ9ApfAFap903a7
	 NTnlicHEsLnLYmy2XAbd+CVUG6OvVPbSKVLYRduqIQpOrOFBfTN9stFeCqPGMD+znf
	 ZPMk2YOPJC0M9EqVcLXxUWi9DkadwpmTaVAOxlnA=
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
Subject: [PATCH 5.10 000/294] 5.10.215-rc1 review
Date: Thu, 11 Apr 2024 11:52:43 +0200
Message-ID: <20240411095435.633465671@linuxfoundation.org>
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
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.215-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.10.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.10.215-rc1
X-KernelTest-Deadline: 2024-04-13T09:54+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is the start of the stable review cycle for the 5.10.215 release.
There are 294 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Sat, 13 Apr 2024 09:53:55 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.215-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 5.10.215-rc1

Michael Roth <michael.roth@amd.com>
    x86/head/64: Re-enable stack protection

Borislav Petkov (AMD) <bp@alien8.de>
    x86/retpoline: Add NOENDBR annotation to the SRSO dummy return thunk

Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
    scsi: sd: Fix wrong zone_write_granularity value during revalidate

Michal Kubecek <mkubecek@suse.cz>
    kbuild: dummy-tools: adjust to stricter stackprotector check

Vasiliy Kovalev <kovalev@altlinux.org>
    VMCI: Fix possible memcpy() run-time warning in vmci_datagram_invoke_guest_handler()

Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
    Bluetooth: btintel: Fixe build regression

Chris Wilson <chris@chris-wilson.co.uk>
    drm/i915/gt: Reset queue_priority_hint on parking

David Hildenbrand <david@redhat.com>
    x86/mm/pat: fix VM_PAT handling in COW mappings

David Hildenbrand <david@redhat.com>
    virtio: reenable config if freezing device failed

Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
    tty: n_gsm: require CAP_NET_ADMIN to attach N_GSM0710 ldisc

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: discard table flag update with pending basechain deletion

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: release mutex after nft_gc_seq_end from abort path

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: release batch on table validation from abort path

Roman Smirnov <r.smirnov@omp.ru>
    fbmon: prevent division by zero in fb_videomode_from_videomode()

Jiawei Fu (iBug) <i@ibugone.com>
    drivers/nvme: Add quirks for device 126f:2262

Aleksandr Burakov <a.burakov@rosalinux.ru>
    fbdev: viafb: fix typo in hw_bitblt_1 and hw_bitblt_2

Colin Ian King <colin.i.king@gmail.com>
    usb: sl811-hcd: only defined function checkdone if QUIRK2 is defined

Marco Felsch <m.felsch@pengutronix.de>
    usb: typec: tcpci: add generic tcpci fallback compatible

Petre Rodan <petre.rodan@subdimension.ro>
    tools: iio: replace seekdir() in iio_generic_buffer

linke li <lilinke99@qq.com>
    ring-buffer: use READ_ONCE() to read cpu_buffer->commit_page in concurrent environment

Ricardo B. Marliere <ricardo@marliere.net>
    ktest: force $buildonly = 1 for 'make_warnings_file' test type

Alban Boyé <alban.boye@protonmail.com>
    platform/x86: touchscreen_dmi: Add an extra entry for a variant of the Chuwi Vi8 tablet

Gergo Koteles <soyer@irl.hu>
    Input: allocate keycode for Display refresh rate toggle

Manjunath Patil <manjunath.b.patil@oracle.com>
    RDMA/cm: add timeout to cm_destroy_id wait

Roman Smirnov <r.smirnov@omp.ru>
    block: prevent division by zero in blk_rq_stat_sum()

Ian Rogers <irogers@google.com>
    libperf evlist: Avoid out-of-bounds access

Daniel Drake <drake@endlessos.org>
    Revert "ACPI: PM: Block ASUS B1400CEAE from suspend to idle by default"

Dai Ngo <dai.ngo@oracle.com>
    SUNRPC: increase size of rpc_wait_queue.qlen from unsigned short to unsigned int

Aric Cyr <aric.cyr@amd.com>
    drm/amd/display: Fix nanosec stat overflow

Ye Bin <yebin10@huawei.com>
    ext4: forbid commit inconsistent quota data when errors=remount-ro

Zhang Yi <yi.zhang@huawei.com>
    ext4: add a hint for block bitmap corrupt state in mb_groups

Arnd Bergmann <arnd@arndb.de>
    media: sta2x11: fix irq handler cast

Alex Henrie <alexhenrie24@gmail.com>
    isofs: handle CDs with bad root inode but good Joliet root directory

Justin Tee <justin.tee@broadcom.com>
    scsi: lpfc: Fix possible memory leak in lpfc_rcv_padisc()

Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
    sysv: don't call sb_bread() with pointers_lock held

Geert Uytterhoeven <geert+renesas@glider.be>
    pinctrl: renesas: checker: Limit cfg reg enum checks to provided IDs

Kunwu Chan <chentao@kylinos.cn>
    Input: synaptics-rmi4 - fail probing if memory allocation for "phys" fails

Edward Adam Davis <eadavis@qq.com>
    Bluetooth: btintel: Fix null ptr deref in btintel_read_version

Eric Dumazet <edumazet@google.com>
    net/smc: reduce rtnl pressure in smc_pnet_create_pnetids_list()

David Sterba <dsterba@suse.com>
    btrfs: send: handle path ref underflow in header iterate_inode_ref()

David Sterba <dsterba@suse.com>
    btrfs: export: handle invalid inode or root reference in btrfs_get_parent()

David Sterba <dsterba@suse.com>
    btrfs: handle chunk tree lookup error in btrfs_relocate_sys_chunks()

Samasth Norway Ananda <samasth.norway.ananda@oracle.com>
    tools/power x86_energy_perf_policy: Fix file leak in get_pkg_num()

Kunwu Chan <chentao@kylinos.cn>
    pstore/zone: Add a null pointer check to the psz_kmsg_read

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

Josh Poimboeuf <jpoimboe@redhat.com>
    objtool: Add asm version of STACK_FRAME_NON_STANDARD

Sean Christopherson <seanjc@google.com>
    x86/cpufeatures: Add CPUID_LNX_5 to track recently added Linux-defined word

Davide Caratti <dcaratti@redhat.com>
    mptcp: don't account accept() of non-MPC client as fallback to TCP

Borislav Petkov (AMD) <bp@alien8.de>
    x86/retpoline: Do the necessary fixup to the Zen3/4 srso return thunk for !SRSO

Borislav Petkov (AMD) <bp@alien8.de>
    x86/bugs: Fix the SRSO mitigation on Zen3/4

Samuel Holland <samuel.holland@sifive.com>
    riscv: Fix spurious errors from __get/put_kernel_nofault

Sumanth Korikkar <sumanthk@linux.ibm.com>
    s390/entry: align system call table on 8 bytes

Borislav Petkov (AMD) <bp@alien8.de>
    x86/mce: Make sure to grab mce_sysfs_mutex in set_bank()

Herve Codina <herve.codina@bootlin.com>
    of: dynamic: Synchronize of_changeset_destroy() with the devlink removals

Herve Codina <herve.codina@bootlin.com>
    driver core: Introduce device_link_wait_removal()

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

Johan Hovold <johan+linaro@kernel.org>
    arm64: dts: qcom: sc7180-trogdor: mark bluetooth address as broken

Venkata Lakshmi Narayana Gubba <gubbaven@codeaurora.org>
    arm64: dts: qcom: sc7180: Remove clock for bluetooth on Trogdor

Paul Barker <paul.barker.ct@bp.renesas.com>
    net: ravb: Always process TX descriptor ring

Antoine Tenart <atenart@kernel.org>
    udp: do not accept non-tunnel GSO skbs landing in a tunnel

Alexander Stein <alexander.stein@ew.tq-group.com>
    Revert "usb: phy: generic: Get the vbus supply"

Bikash Hazarika <bhazarika@marvell.com>
    scsi: qla2xxx: Update manufacturer detail

Bikash Hazarika <bhazarika@marvell.com>
    scsi: qla2xxx: Update manufacturer details

Aleksandr Loktionov <aleksandr.loktionov@intel.com>
    i40e: fix vf may be used uninitialized in this function warning

Aleksandr Loktionov <aleksandr.loktionov@intel.com>
    i40e: fix i40e_count_filters() to count only active/new filters

Su Hui <suhui@nfschina.com>
    octeontx2-pf: check negative error code in otx2_open()

Antoine Tenart <atenart@kernel.org>
    udp: do not transition UDP GRO fraglist partial checksums to unnecessary

Kuniyuki Iwashima <kuniyu@amazon.com>
    ipv6: Fix infinite recursion in fib6_dump_done().

Jakub Kicinski <kuba@kernel.org>
    selftests: reuseaddr_conflict: add missing new line at the end of the output

Eric Dumazet <edumazet@google.com>
    erspan: make sure erspan_base_hdr is present in skb->head

Piotr Wejman <piotrwejman90@gmail.com>
    net: stmmac: fix rx queue priority assignment

Eric Dumazet <edumazet@google.com>
    net/sched: act_skbmod: prevent kernel-infoleak

Jakub Sitnicki <jakub@cloudflare.com>
    bpf, sockmap: Prevent lock inversion deadlock in map delete elem

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    vboxsf: Avoid an spurious warning if load_nls_xxx() fails

Eric Dumazet <edumazet@google.com>
    netfilter: validate user input for expected length

Ziyang Xuan <william.xuanziyang@huawei.com>
    netfilter: nf_tables: Fix potential data-race in __nft_flowtable_type_get()

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: flush pending destroy work before exit_net release

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: reject new basechain after table flag update

Min Li <min15.li@samsung.com>
    block: add check that partition length needs to be aligned with block size

Pu Wen <puwen@hygon.cn>
    x86/srso: Add SRSO mitigation for Hygon processors

Vlastimil Babka <vbabka@suse.cz>
    mm, vmscan: prevent infinite loop for costly GFP_NOIO | __GFP_RETRY_MAYFAIL allocations

Ingo Molnar <mingo@kernel.org>
    Revert "x86/mm/ident_map: Use gbpages only where full GB page should be mapped."

Jens Axboe <axboe@kernel.dk>
    io_uring: ensure '0' is returned on file registration success

Alex Williamson <alex.williamson@redhat.com>
    vfio/fsl-mc: Block calling interrupt handler without trigger

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

Hariprasad Kelam <hkelam@marvell.com>
    Octeontx2-af: fix pause frame configuration in GMP mode

Andrei Matei <andreimatei1@gmail.com>
    bpf: Protect against int overflow for stack access size

Nikita Kiryushin <kiryushin@ancud.ru>
    ACPICA: debugger: check status of acpi_evaluate_object() in acpi_db_walk_for_fields()

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

Mika Westerberg <mika.westerberg@linux.intel.com>
    PCI/DPC: Quirk PIO log size for Intel Ice Lake Root Ports

Kim Phillips <kim.phillips@amd.com>
    x86/cpu: Enable STIBP on AMD if Automatic IBRS is enabled

Quinn Tran <qutran@marvell.com>
    scsi: qla2xxx: Delay I/O Abort on PCI error

Quinn Tran <qutran@marvell.com>
    scsi: qla2xxx: Fix command flush on cable pull

Quinn Tran <qutran@marvell.com>
    scsi: qla2xxx: Split FCE|EFT trace control

Christian A. Ehrhardt <lk@c--e.de>
    usb: typec: ucsi: Clear UCSI_CCI_RESET_COMPLETE before reset

Christian A. Ehrhardt <lk@c--e.de>
    usb: typec: ucsi: Ack unsupported commands

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

Alan Stern <stern@rowland.harvard.edu>
    USB: core: Add hub_get() and hub_put() routines

Dan Carpenter <dan.carpenter@linaro.org>
    staging: vc04_services: fix information leak in create_component()

Arnd Bergmann <arnd@arndb.de>
    staging: vc04_services: changen strncpy() to strscpy_pad()

Guilherme G. Piccoli <gpiccoli@igalia.com>
    scsi: core: Fix unremoved procfs host directory regression

Duoming Zhou <duoming@zju.edu.cn>
    ALSA: sh: aica: reorder cleanup operations to avoid UAF bugs

Oliver Neukum <oneukum@suse.com>
    usb: cdc-wdm: close race between read and workqueue

Claus Hansen Ries <chr@terma.com>
    net: ll_temac: platform_get_resource replaced by wrong function

Mikko Rapeli <mikko.rapeli@linaro.org>
    mmc: core: Avoid negative index with array access

Mikko Rapeli <mikko.rapeli@linaro.org>
    mmc: core: Initialize mmc_blk_ioc_data

Nathan Chancellor <nathan@kernel.org>
    hexagon: vmlinux.lds.S: handle attributes section

Max Filippov <jcmvbkbc@gmail.com>
    exec: Fix NOMMU linux_binprm::exec in transfer_args_to_stack()

Felix Fietkau <nbd@nbd.name>
    wifi: mac80211: check/clear fast rx for non-4addr sta VLAN changes

John Sperbeck <jsperbeck@google.com>
    init: open /initrd.image with O_LARGEFILE

Zi Yan <ziy@nvidia.com>
    mm/migrate: set swap entry values of THP tail pages properly.

Liu Shixin <liushixin2@huawei.com>
    mm/memory-failure: fix an incorrect use of tail pages

Hugo Villeneuve <hvilleneuve@dimonoff.com>
    serial: sc16is7xx: convert from _raw_ to _noinc_ regmap functions for FIFO

Nathan Chancellor <nathan@kernel.org>
    powerpc: xor_vmx: Add '-mhard-float' to CFLAGS

Tim Schumacher <timschumi@gmx.de>
    efivarfs: Request at most 512 bytes for variable names

Yang Jihong <yangjihong1@huawei.com>
    perf/core: Fix reentry problem in perf_output_read_group()

Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
    KVM/x86: Export RFDS_NO and RFDS_CLEAR to guests

Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
    x86/rfds: Mitigate Register File Data Sampling (RFDS)

Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
    Documentation/hw-vuln: Add documentation for RFDS

Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
    x86/mmio: Disable KVM mitigation when X86_FEATURE_CLEAR_CPU_BUF is set

Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
    KVM/VMX: Move VERW closer to VMentry for MDS mitigation

Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
    KVM/VMX: Use BT+JNC, i.e. EFLAGS.CF to select VMRESUME vs. VMLAUNCH

Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
    x86/bugs: Use ALTERNATIVE() instead of mds_user_clear static key

Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
    x86/entry_32: Add VERW just before userspace transition

Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
    x86/entry_64: Add VERW just before userspace transition

Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
    x86/bugs: Add asm helpers for executing VERW

Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
    x86/asm: Add _ASM_RIP() macro for x86-64 (%rip) suffix

Goldwyn Rodrigues <rgoldwyn@suse.com>
    btrfs: allocate btrfs_ioctl_defrag_range_args on stack

John Ogness <john.ogness@linutronix.de>
    printk: Update @console_may_schedule in console_trylock_spinning()

Maximilian Heyne <mheyne@amazon.de>
    xen/events: close evtchn after mapping cleanup

Sumit Garg <sumit.garg@linaro.org>
    tee: optee: Fix kernel panic caused by incorrect error handling

Bart Van Assche <bvanassche@acm.org>
    fs/aio: Check IOCB_AIO_RW before the struct aio_kiocb conversion

Nicolas Pitre <nico@fluxnic.net>
    vt: fix unicode buffer corruption when deleting characters

Alexander Usyskin <alexander.usyskin@intel.com>
    mei: me: add arrow lake point H DID

Alexander Usyskin <alexander.usyskin@intel.com>
    mei: me: add arrow lake point S DID

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

Sean Christopherson <seanjc@google.com>
    KVM: SVM: Flush pages under kvm->lock to fix UAF in svm_register_enc_region()

Nathan Chancellor <nathan@kernel.org>
    xfrm: Avoid clang fortify warning in copy_to_user_tmpl()

Michael Kelley <mhklinux@outlook.com>
    Drivers: hv: vmbus: Calculate ring buffer size for more efficient use of memory

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: reject constant set with timeout

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: disallow anonymous set with timeout flag

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: mark set as dead when unbinding anonymous set with timeout

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    cpufreq: brcmstb-avs-cpufreq: fix up "add check for cpufreq_cpu_get's return value"

Ian Abbott <abbotti@mev.co.uk>
    comedi: comedi_test: Prevent timers rescheduling during deletion

Salvatore Bonaccorso <carnil@debian.org>
    scripts: kernel-doc: Fix syntax error due to undeclared args variable

Anton Altaparmakov <anton@tuxera.com>
    x86/pm: Work around false positive kmemleak report in msr_build_context()

Andy Lutomirski <luto@kernel.org>
    x86/stackprotector/32: Make the canary into a regular percpu variable

Xu Wang <vulab@iscas.ac.cn>
    vxge: remove unnecessary cast in kfree()

Mikulas Patocka <mpatocka@redhat.com>
    dm snapshot: fix lockup in dm_exception_table_exit

Leo Ma <hanghong.ma@amd.com>
    drm/amd/display: Fix noise issue on HDMI AV mute

Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
    drm/amd/display: Return the correct HDCP error code

Conrad Kostecki <conikost@gentoo.org>
    ahci: asm1064: asm1166: don't limit reported ports

Andrey Jr. Melnikov <temnota.am@gmail.com>
    ahci: asm1064: correct count of reported ports

Jason A. Donenfeld <Jason@zx2c4.com>
    wireguard: netlink: access device through ctx instead of peer

Jason A. Donenfeld <Jason@zx2c4.com>
    wireguard: netlink: check for dangling peer via is_dead instead of empty list

Steven Rostedt (Google) <rostedt@goodmis.org>
    net: hns3: tracing: fix hclgevf trace event strings

Borislav Petkov (AMD) <bp@alien8.de>
    x86/CPU/AMD: Update the Zenbleed microcode revisions

Marek Szyprowski <m.szyprowski@samsung.com>
    cpufreq: dt: always allocate zeroed cpumask

Ryusuke Konishi <konishi.ryusuke@gmail.com>
    nilfs2: prevent kernel bug at submit_bh_wbc()

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

Jani Nikula <jani.nikula@intel.com>
    drm/panel: do not return negative error codes from drm_panel_get_modes()

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

Steven Rostedt (Google) <rostedt@goodmis.org>
    ring-buffer: Do not set shortest_full when full target is hit

Steven Rostedt (Google) <rostedt@goodmis.org>
    ring-buffer: Fix waking up ring buffer readers

Alex Williamson <alex.williamson@redhat.com>
    vfio/platform: Disable virqfds on cleanup

Niklas Cassel <cassel@kernel.org>
    PCI: dwc: endpoint: Fix advertised resizable BAR size

Nathan Chancellor <nathan@kernel.org>
    kbuild: Move -Wenum-{compare-conditional,enum-conversion} into W=1

Josef Bacik <josef@toxicpanda.com>
    nfs: fix UAF in direct writes

Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
    PCI/AER: Block runtime suspend when handling errors

Sean V Kelley <sean.v.kelley@intel.com>
    PCI/ERR: Clear AER status only when we control AER

Samuel Thibault <samuel.thibault@ens-lyon.org>
    speakup: Fix 8bit characters from direct synth

Wayne Chang <waynec@nvidia.com>
    usb: gadget: tegra-xudc: Fix USB3 PHY retrieval logic

Jon Hunter <jonathanh@nvidia.com>
    usb: gadget: tegra-xudc: Use dev_err_probe()

Wayne Chang <waynec@nvidia.com>
    phy: tegra: xusb: Add API to retrieve the port number of phy

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    slimbus: core: Remove usage of the deprecated ida_simple_xx() API

Jerome Brunet <jbrunet@baylibre.com>
    nvmem: meson-efuse: fix function pointer type mismatch

Maximilian Heyne <mheyne@amazon.de>
    ext4: fix corruption during on-line resize

Josua Mayer <josua@solid-run.com>
    hwmon: (amc6821) add of_match table

Christian Gmeiner <cgmeiner@igalia.com>
    drm/etnaviv: Restore some id values

Dominique Martinet <dominique.martinet@atmark-techno.com>
    mmc: core: Fix switch on gp3 partition

Ryan Roberts <ryan.roberts@arm.com>
    mm: swap: fix race between free_swap_and_cache() and swapoff()

Fedor Pchelkin <pchelkin@ispras.ru>
    mac802154: fix llsec key resources release in mac802154_llsec_key_del

Yu Kuai <yukuai3@huawei.com>
    dm-raid: fix lockdep waring in "pers->hot_add_disk"

Song Liu <song@kernel.org>
    Revert "Revert "md/raid5: Wait for MD_SB_CHANGE_PENDING in raid5d""

Paul Menzel <pmenzel@molgen.mpg.de>
    PCI/DPC: Quirk PIO log size for Intel Raptor Lake Root Ports

Mika Westerberg <mika.westerberg@linux.intel.com>
    PCI/DPC: Quirk PIO log size for certain Intel Root Ports

Mika Westerberg <mika.westerberg@linux.intel.com>
    PCI/ASPM: Make Intel DG2 L1 acceptable latency unlimited

Bjorn Helgaas <bhelgaas@google.com>
    PCI: Work around Intel I210 ROM BAR overlap defect

Amey Narkhede <ameynarkhede03@gmail.com>
    PCI: Cache PCIe Device Capabilities register

Sean V Kelley <sean.v.kelley@intel.com>
    PCI/ERR: Cache RCEC EA Capability offset in pci_init_capabilities()

Rafael J. Wysocki <rafael.j.wysocki@intel.com>
    PCI/PM: Drain runtime-idle callbacks before driver removal

Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
    PCI: Drop pci_device_remove() test of pci_dev->driver

Filipe Manana <fdmanana@suse.com>
    btrfs: fix off-by-one chunk length calculation at contains_pending_extent()

Peter Collingbourne <pcc@google.com>
    serial: Lock console when calling into driver before registration

Petr Mladek <pmladek@suse.com>
    printk/console: Split out code that enables default console

Jameson Thies <jthies@google.com>
    usb: typec: ucsi: Clean up UCSI_CABLE_PROP macros

Miklos Szeredi <mszeredi@redhat.com>
    fuse: don't unhash root

Miklos Szeredi <mszeredi@redhat.com>
    fuse: fix root lookup with nonzero generation

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

Gabor Juhos <j4g8y7@gmail.com>
    clk: qcom: gcc-ipq6018: fix terminating of frequency table arrays

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

John David Anglin <dave.anglin@bell.net>
    parisc: Avoid clobbering the C/B bits in the PSW with tophys and tovirt macros

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

Matthew Wilcox (Oracle) <willy@infradead.org>
    bounds: support non-power-of-two CONFIG_NR_CPUS

Damien Le Moal <dlemoal@kernel.org>
    block: Clear zone limits for a non-zoned stacked queue

Damien Le Moal <damien.lemoal@wdc.com>
    block: introduce zone_write_granularity limit

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

Zack Rusin <zack.rusin@broadcom.com>
    drm/vmwgfx: Fix possible null pointer derefence with invalid contexts

Zack Rusin <zackr@vmware.com>
    drm/vmwgfx: Fix some static checker warnings

Lee Jones <lee.jones@linaro.org>
    drm/vmwgfx/vmwgfx_cmdbuf_res: Remove unused variable 'ret'

Christian König <christian.koenig@amd.com>
    drm/vmwgfx: switch over to the new pin interface v2

Christian König <christian.koenig@amd.com>
    drm/vmwgfx: stop using ttm_bo_create v2

Duje Mihanović <duje.mihanovic@skole.hr>
    arm: dts: marvell: Fix maxium->maxim typo in brownstone dts

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

 Documentation/ABI/testing/sysfs-devices-system-cpu |   1 +
 Documentation/admin-guide/hw-vuln/index.rst        |   1 +
 .../admin-guide/hw-vuln/reg-file-data-sampling.rst | 104 +++++++++
 Documentation/admin-guide/hw-vuln/spectre.rst      |  18 +-
 Documentation/admin-guide/kernel-parameters.txt    |  27 ++-
 Documentation/block/queue-sysfs.rst                |   7 +
 Documentation/x86/mds.rst                          |  34 ++-
 Makefile                                           |   4 +-
 arch/arm/boot/dts/mmp2-brownstone.dts              |   2 +-
 arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi       |   3 +-
 arch/arm64/boot/dts/rockchip/rk3328.dtsi           |  11 +-
 arch/arm64/boot/dts/rockchip/rk3399.dtsi           |  12 +-
 arch/hexagon/kernel/vmlinux.lds.S                  |   1 +
 arch/parisc/include/asm/assembly.h                 |  18 +-
 arch/parisc/include/asm/checksum.h                 |  10 +-
 arch/powerpc/include/asm/reg_fsl_emb.h             |  11 +-
 arch/powerpc/lib/Makefile                          |   2 +-
 arch/riscv/include/asm/uaccess.h                   |   4 +-
 arch/s390/kernel/entry.S                           |   1 +
 arch/sparc/kernel/nmi.c                            |   2 +-
 arch/sparc/vdso/vma.c                              |   7 +-
 arch/x86/Kconfig                                   |  18 +-
 arch/x86/Makefile                                  |   8 +
 arch/x86/entry/entry.S                             |  23 ++
 arch/x86/entry/entry_32.S                          |  59 +----
 arch/x86/entry/entry_64.S                          |  10 +
 arch/x86/entry/entry_64_compat.S                   |   1 +
 arch/x86/include/asm/asm-prototypes.h              |   1 +
 arch/x86/include/asm/asm.h                         |   5 +
 arch/x86/include/asm/cpufeature.h                  |   8 +-
 arch/x86/include/asm/cpufeatures.h                 |   5 +-
 arch/x86/include/asm/disabled-features.h           |   3 +-
 arch/x86/include/asm/entry-common.h                |   1 -
 arch/x86/include/asm/irqflags.h                    |   1 +
 arch/x86/include/asm/msr-index.h                   |  10 +
 arch/x86/include/asm/nospec-branch.h               |  47 ++--
 arch/x86/include/asm/processor.h                   |  15 +-
 arch/x86/include/asm/ptrace.h                      |   5 +-
 arch/x86/include/asm/required-features.h           |   3 +-
 arch/x86/include/asm/segment.h                     |  30 +--
 arch/x86/include/asm/setup.h                       |   1 -
 arch/x86/include/asm/stackprotector.h              |  79 ++-----
 arch/x86/include/asm/suspend_32.h                  |  12 +-
 arch/x86/kernel/Makefile                           |   1 -
 arch/x86/kernel/asm-offsets_32.c                   |   5 -
 arch/x86/kernel/cpu/amd.c                          |  10 +-
 arch/x86/kernel/cpu/bugs.c                         | 245 ++++++++++++++-------
 arch/x86/kernel/cpu/common.c                       |  64 ++++--
 arch/x86/kernel/cpu/mce/core.c                     |   4 +-
 arch/x86/kernel/doublefault_32.c                   |   4 +-
 arch/x86/kernel/head64.c                           |   9 -
 arch/x86/kernel/head_32.S                          |  18 +-
 arch/x86/kernel/head_64.S                          |  24 +-
 arch/x86/kernel/nmi.c                              |   3 -
 arch/x86/kernel/setup_percpu.c                     |   1 -
 arch/x86/kernel/tls.c                              |   8 +-
 arch/x86/kvm/cpuid.h                               |   2 +
 arch/x86/kvm/svm/sev.c                             |  18 +-
 arch/x86/kvm/vmx/run_flags.h                       |   7 +-
 arch/x86/kvm/vmx/vmenter.S                         |   9 +-
 arch/x86/kvm/vmx/vmx.c                             |  12 +-
 arch/x86/kvm/x86.c                                 |   5 +-
 arch/x86/lib/insn-eval.c                           |   4 -
 arch/x86/lib/retpoline.S                           |   6 +-
 arch/x86/mm/ident_map.c                            |  23 +-
 arch/x86/mm/pat/memtype.c                          |  50 +++--
 arch/x86/platform/pvh/head.S                       |  14 --
 arch/x86/power/cpu.c                               |   6 +-
 arch/x86/xen/enlighten_pv.c                        |   1 -
 block/blk-settings.c                               |  41 +++-
 block/blk-stat.c                                   |   2 +-
 block/blk-sysfs.c                                  |   8 +
 block/ioctl.c                                      |  11 +-
 drivers/accessibility/speakup/synth.c              |   4 +-
 drivers/acpi/acpica/dbnames.c                      |   8 +-
 drivers/acpi/sleep.c                               |  12 -
 drivers/ata/ahci.c                                 |   5 -
 drivers/ata/sata_mv.c                              |  63 +++---
 drivers/ata/sata_sx4.c                             |   6 +-
 drivers/base/core.c                                |  26 ++-
 drivers/base/cpu.c                                 |   8 +
 drivers/base/power/wakeirq.c                       |   4 +-
 drivers/bluetooth/btintel.c                        |   2 +-
 drivers/clk/qcom/gcc-ipq6018.c                     |   2 +
 drivers/clk/qcom/gcc-ipq8074.c                     |   2 +
 drivers/clk/qcom/gcc-sdm845.c                      |   1 +
 drivers/clk/qcom/mmcc-apq8084.c                    |   2 +
 drivers/clk/qcom/mmcc-msm8974.c                    |   2 +
 drivers/cpufreq/brcmstb-avs-cpufreq.c              |   5 +-
 drivers/cpufreq/cpufreq-dt.c                       |   2 +-
 drivers/crypto/qat/qat_common/adf_aer.c            |  23 +-
 drivers/firmware/efi/vars.c                        |  17 +-
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c |  12 +-
 .../gpu/drm/amd/display/modules/hdcp/hdcp_psp.c    |   3 +
 .../gpu/drm/amd/display/modules/inc/mod_stats.h    |   4 +-
 drivers/gpu/drm/drm_panel.c                        |  17 +-
 drivers/gpu/drm/etnaviv/etnaviv_drv.c              |   2 +-
 drivers/gpu/drm/etnaviv/etnaviv_hwdb.c             |   9 +
 drivers/gpu/drm/exynos/exynos_drm_vidi.c           |   4 +-
 drivers/gpu/drm/exynos/exynos_hdmi.c               |   4 +-
 drivers/gpu/drm/i915/gt/intel_engine_pm.c          |   3 -
 drivers/gpu/drm/i915/gt/intel_lrc.c                |   3 +
 drivers/gpu/drm/imx/parallel-display.c             |   4 +-
 drivers/gpu/drm/ttm/ttm_memory.c                   |   2 +
 drivers/gpu/drm/vc4/vc4_hdmi.c                     |   2 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_binding.c            |  20 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_blit.c               |   4 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_bo.c                 |  92 ++++++--
 drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf.c             |   8 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf_res.c         |   4 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_cotable.c            |   4 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c                |   2 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.h                |  11 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c            |  12 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_fb.c                 |   2 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_mob.c                |   4 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_msg.c                |   6 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_resource.c           |  12 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c               |   4 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_shader.c             |   4 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_so.c                 |   3 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_ttm_buffer.c         |  50 +----
 drivers/gpu/drm/vmwgfx/vmwgfx_validation.c         |   6 +-
 drivers/hwmon/amc6821.c                            |  11 +
 drivers/infiniband/core/cm.c                       |  20 +-
 drivers/input/rmi4/rmi_driver.c                    |   6 +-
 drivers/md/dm-integrity.c                          |   2 +-
 drivers/md/dm-raid.c                               |   2 +
 drivers/md/dm-snap.c                               |   4 +-
 drivers/md/raid5.c                                 |  12 +
 drivers/media/pci/sta2x11/sta2x11_vip.c            |   9 +-
 drivers/media/tuners/xc4000.c                      |   4 +-
 drivers/misc/mei/hw-me-regs.h                      |   2 +
 drivers/misc/mei/pci-me.c                          |   2 +
 drivers/misc/vmw_vmci/vmci_datagram.c              |   6 +-
 drivers/mmc/core/block.c                           |  14 +-
 drivers/mmc/host/tmio_mmc_core.c                   |   2 +
 drivers/mtd/nand/raw/meson_nand.c                  |   2 +-
 drivers/mtd/ubi/fastmap.c                          |   7 +-
 drivers/mtd/ubi/vtbl.c                             |   6 +
 .../ethernet/hisilicon/hns3/hns3pf/hclge_trace.h   |   8 +-
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_trace.h |   8 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c        |   7 +-
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |  34 ++-
 drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c     |  16 +-
 drivers/net/ethernet/marvell/octeontx2/af/cgx.c    |   5 +
 .../net/ethernet/marvell/octeontx2/nic/otx2_pf.c   |   2 +-
 drivers/net/ethernet/neterion/vxge/vxge-config.c   |   2 +-
 drivers/net/ethernet/pensando/ionic/ionic_lif.c    |   5 +-
 drivers/net/ethernet/realtek/r8169_main.c          |   9 +
 drivers/net/ethernet/renesas/ravb_main.c           |   7 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c  |  40 +++-
 .../net/ethernet/stmicro/stmmac/dwxgmac2_core.c    |  38 +++-
 drivers/net/ethernet/xilinx/ll_temac_main.c        |   2 +-
 drivers/net/wireguard/netlink.c                    |  10 +-
 drivers/net/wireless/ath/ath9k/antenna.c           |   2 +-
 .../broadcom/brcm80211/brcmfmac/cfg80211.c         |   4 +-
 drivers/nvme/host/pci.c                            |   3 +
 drivers/nvmem/meson-efuse.c                        |  25 +--
 drivers/of/dynamic.c                               |  12 +
 drivers/pci/controller/dwc/pcie-designware-ep.c    |   7 +-
 drivers/pci/pci-driver.c                           |  23 +-
 drivers/pci/pci.c                                  |   6 +-
 drivers/pci/pci.h                                  |  17 ++
 drivers/pci/pcie/Makefile                          |   2 +-
 drivers/pci/pcie/dpc.c                             |  15 +-
 drivers/pci/pcie/err.c                             |  33 ++-
 drivers/pci/pcie/rcec.c                            |  59 +++++
 drivers/pci/probe.c                                |   7 +-
 drivers/pci/quirks.c                               | 100 +++++++++
 drivers/pci/setup-res.c                            |   8 +-
 drivers/phy/tegra/xusb.c                           |  13 ++
 drivers/pinctrl/renesas/core.c                     |   4 +-
 drivers/platform/x86/touchscreen_dmi.c             |   9 +
 drivers/s390/crypto/zcrypt_api.c                   |   2 +
 drivers/scsi/hosts.c                               |   7 +-
 drivers/scsi/lpfc/lpfc_nportdisc.c                 |   6 +-
 drivers/scsi/lpfc/lpfc_nvmet.c                     |   2 +-
 drivers/scsi/myrb.c                                |  20 +-
 drivers/scsi/myrs.c                                |  24 +-
 drivers/scsi/qla2xxx/qla_attr.c                    |  14 +-
 drivers/scsi/qla2xxx/qla_def.h                     |   2 +-
 drivers/scsi/qla2xxx/qla_gs.c                      |   2 +-
 drivers/scsi/qla2xxx/qla_init.c                    | 102 ++++-----
 drivers/scsi/qla2xxx/qla_target.c                  |  10 +
 drivers/scsi/sd.c                                  |   7 +-
 drivers/slimbus/core.c                             |   4 +-
 drivers/soc/fsl/qbman/qman.c                       |  98 +++++++--
 drivers/staging/comedi/drivers/comedi_test.c       |  30 ++-
 drivers/staging/media/ipu3/ipu3-v4l2.c             |  16 +-
 .../staging/vc04_services/vchiq-mmal/mmal-vchiq.c  |   5 +-
 drivers/tee/optee/device.c                         |   3 +-
 drivers/tty/n_gsm.c                                |   3 +
 drivers/tty/serial/8250/8250_port.c                |   6 -
 drivers/tty/serial/fsl_lpuart.c                    |   7 +-
 drivers/tty/serial/max310x.c                       |   7 +-
 drivers/tty/serial/sc16is7xx.c                     |  15 +-
 drivers/tty/serial/serial_core.c                   |  12 +
 drivers/tty/vt/vt.c                                |   2 +-
 drivers/usb/class/cdc-wdm.c                        |   6 +-
 drivers/usb/core/hub.c                             |  23 +-
 drivers/usb/core/hub.h                             |   2 +
 drivers/usb/core/port.c                            |   5 +-
 drivers/usb/core/sysfs.c                           |  16 +-
 drivers/usb/dwc2/core.h                            |  14 ++
 drivers/usb/dwc2/core_intr.c                       |  63 ++++--
 drivers/usb/dwc2/gadget.c                          |   4 +
 drivers/usb/dwc2/hcd.c                             |  47 +++-
 drivers/usb/dwc2/hcd_ddma.c                        |  17 +-
 drivers/usb/dwc2/hw.h                              |   2 +-
 drivers/usb/gadget/function/f_ncm.c                |   2 +-
 drivers/usb/gadget/udc/core.c                      |   4 +-
 drivers/usb/gadget/udc/tegra-xudc.c                |  53 ++---
 drivers/usb/host/sl811-hcd.c                       |   2 +
 drivers/usb/phy/phy-generic.c                      |   7 -
 drivers/usb/serial/cp210x.c                        |   4 +
 drivers/usb/serial/ftdi_sio.c                      |   2 +
 drivers/usb/serial/ftdi_sio_ids.h                  |   6 +
 drivers/usb/serial/option.c                        |   6 +
 drivers/usb/storage/isd200.c                       |  23 +-
 drivers/usb/typec/tcpm/tcpci.c                     |   1 +
 drivers/usb/typec/ucsi/ucsi.c                      |  42 +++-
 drivers/usb/typec/ucsi/ucsi.h                      |   4 +-
 drivers/vfio/fsl-mc/vfio_fsl_mc_intr.c             |   7 +-
 drivers/vfio/pci/vfio_pci_intrs.c                  | 188 +++++++++-------
 drivers/vfio/platform/vfio_platform_irq.c          | 106 ++++++---
 drivers/vfio/virqfd.c                              |  21 ++
 drivers/video/fbdev/core/fbmon.c                   |   7 +-
 drivers/video/fbdev/via/accel.c                    |   4 +-
 drivers/virtio/virtio.c                            |  10 +-
 drivers/xen/events/events_base.c                   |   5 +-
 fs/aio.c                                           |   8 +-
 fs/btrfs/export.c                                  |   9 +-
 fs/btrfs/ioctl.c                                   |  25 +--
 fs/btrfs/send.c                                    |  10 +-
 fs/btrfs/volumes.c                                 |  14 +-
 fs/exec.c                                          |   1 +
 fs/ext4/mballoc.c                                  |  22 +-
 fs/ext4/resize.c                                   |   3 +-
 fs/ext4/super.c                                    |  12 +
 fs/fat/nfs.c                                       |   6 +
 fs/fuse/dir.c                                      |   4 +
 fs/fuse/fuse_i.h                                   |   1 -
 fs/fuse/inode.c                                    |   7 +-
 fs/isofs/inode.c                                   |  18 +-
 fs/nfs/direct.c                                    |  11 +-
 fs/nfs/write.c                                     |   2 +-
 fs/nilfs2/btree.c                                  |   9 +-
 fs/nilfs2/direct.c                                 |   9 +-
 fs/nilfs2/inode.c                                  |   2 +-
 fs/pstore/zone.c                                   |   2 +
 fs/sysv/itree.c                                    |  10 +-
 fs/ubifs/file.c                                    |  13 +-
 fs/vboxsf/super.c                                  |   3 +-
 include/linux/blkdev.h                             |  15 ++
 include/linux/cpu.h                                |   2 +
 include/linux/device.h                             |   1 +
 include/linux/gfp.h                                |   9 +
 include/linux/hyperv.h                             |  22 +-
 include/linux/nfs_fs.h                             |   1 +
 include/linux/objtool.h                            |   8 +
 include/linux/pci.h                                |   6 +
 include/linux/phy/tegra/xusb.h                     |   2 +
 include/linux/sunrpc/sched.h                       |   2 +-
 include/linux/timer.h                              |  18 +-
 include/linux/udp.h                                |  28 +++
 include/linux/vfio.h                               |   2 +
 include/net/cfg802154.h                            |   1 +
 include/net/inet_connection_sock.h                 |   1 +
 include/net/sock.h                                 |   7 +
 include/soc/fsl/qman.h                             |   9 +
 include/uapi/linux/input-event-codes.h             |   1 +
 init/initramfs.c                                   |   2 +-
 io_uring/io_uring.c                                |   2 +-
 kernel/bounds.c                                    |   2 +-
 kernel/bpf/verifier.c                              |   5 +
 kernel/events/core.c                               |   9 +
 kernel/panic.c                                     |   8 +
 kernel/power/suspend.c                             |   1 +
 kernel/printk/printk.c                             |  63 ++++--
 kernel/time/timer.c                                | 160 ++++++++------
 kernel/trace/ring_buffer.c                         | 193 +++++++++-------
 mm/compaction.c                                    |   7 +-
 mm/memory-failure.c                                |   2 +-
 mm/memory.c                                        |   4 +
 mm/memtest.c                                       |   4 +-
 mm/migrate.c                                       |   6 +-
 mm/page_alloc.c                                    |  10 +-
 mm/swapfile.c                                      |  13 +-
 mm/vmscan.c                                        |   5 +-
 net/batman-adv/distributed-arp-table.c             |   3 +-
 net/batman-adv/main.c                              |  14 +-
 net/bluetooth/hci_debugfs.c                        |  64 ++++--
 net/bluetooth/hci_event.c                          |  25 +++
 net/bridge/netfilter/ebtables.c                    |   6 +
 net/core/sock_map.c                                |   6 +
 net/ipv4/inet_connection_sock.c                    |  14 ++
 net/ipv4/ip_gre.c                                  |   5 +
 net/ipv4/netfilter/arp_tables.c                    |   4 +
 net/ipv4/netfilter/ip_tables.c                     |   4 +
 net/ipv4/tcp.c                                     |   2 +
 net/ipv4/udp.c                                     |   7 +
 net/ipv4/udp_offload.c                             |  13 +-
 net/ipv6/ip6_fib.c                                 |  14 +-
 net/ipv6/ip6_gre.c                                 |   3 +
 net/ipv6/netfilter/ip6_tables.c                    |   4 +
 net/ipv6/udp.c                                     |   2 +-
 net/ipv6/udp_offload.c                             |   8 +-
 net/mac80211/cfg.c                                 |   5 +-
 net/mac802154/llsec.c                              |  18 +-
 net/mptcp/protocol.c                               |   3 -
 net/mptcp/subflow.c                                |   3 +
 net/netfilter/nf_tables_api.c                      |  74 ++++++-
 net/nfc/nci/core.c                                 |   5 +
 net/rds/rdma.c                                     |   2 +-
 net/sched/act_skbmod.c                             |  10 +-
 net/smc/smc_pnet.c                                 |  10 +
 net/xfrm/xfrm_user.c                               |   3 +
 scripts/Makefile.extrawarn                         |   2 +
 scripts/dummy-tools/gcc                            |   6 +-
 scripts/gcc-x86_32-has-stack-protector.sh          |   6 +-
 scripts/kernel-doc                                 |   2 +-
 security/smack/smack_lsm.c                         |  12 +-
 sound/pci/hda/patch_realtek.c                      |   9 +-
 sound/sh/aica.c                                    |  17 +-
 sound/soc/soc-ops.c                                |   2 +-
 tools/iio/iio_utils.c                              |   2 +-
 tools/include/linux/objtool.h                      |   8 +
 tools/lib/perf/evlist.c                            |  18 +-
 tools/lib/perf/include/internal/evlist.h           |   4 +-
 .../x86_energy_perf_policy.c                       |   1 +
 tools/testing/ktest/ktest.pl                       |   1 +
 tools/testing/selftests/mqueue/setting             |   1 +
 tools/testing/selftests/net/reuseaddr_conflict.c   |   2 +-
 virt/kvm/async_pf.c                                |  31 ++-
 335 files changed, 3261 insertions(+), 1539 deletions(-)



