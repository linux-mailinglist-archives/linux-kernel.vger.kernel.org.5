Return-Path: <linux-kernel+bounces-91321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97ED3870E5C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 22:43:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBC9F1C20B7C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 21:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B94D4200D4;
	Mon,  4 Mar 2024 21:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JaLYwU8/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D681C6AB;
	Mon,  4 Mar 2024 21:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709588588; cv=none; b=QDDQGXnFXY61O38UrGd3mW4j6uIdg32AYyFxGdmo0LoJINNgasPDR3HQmgOb/9lnoy0pE6tAQy7A8Bw9rwpTWQxavbCxWQMcWYYEmrU4rXL5HGDewS1bMb3Rz3g5EUPyWX++l1EIPbbK+bFmEnOVEeYJ8RFYvFU964xvZ/BjkR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709588588; c=relaxed/simple;
	bh=qwjnFymrEEIplgPfuExUvAOm1yf59wGX8+YMdaHLkdY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Yi5b8DNzawH20Ww3lP0/JNwO+09so0jSs3Y4jNsrQ7OORBKRs70zG0f9pu1TFaucpavMlhCWjiGgKBRWwBvys/v68gioB+fJ9zWT7yjXTD0h3d/R4sKIeR0zEluWqxAnFN+WYA55LGbBYHigRok6+0pXJrLNXE5/H3PtCnAL8Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JaLYwU8/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF42DC433C7;
	Mon,  4 Mar 2024 21:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709588588;
	bh=qwjnFymrEEIplgPfuExUvAOm1yf59wGX8+YMdaHLkdY=;
	h=From:To:Cc:Subject:Date:From;
	b=JaLYwU8/2YaJc0i2ed3hjU48m2t3MSL8g5m1e50UjfqPS3zOiJqOptevnwv18/Fa5
	 uNFay3bCqjncfnVyN1Lyss7Hk9XI96xJBSGMxF9xLY5/u1bmKMT+QglR5UfpLol5t8
	 tUMpSrnz2wpwh2/c6G1xFoFw/EI+vaURBBQG/tWc=
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
Subject: [PATCH 6.1 000/215] 6.1.81-rc1 review
Date: Mon,  4 Mar 2024 21:21:03 +0000
Message-ID: <20240304211556.993132804@linuxfoundation.org>
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
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.81-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.1.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.1.81-rc1
X-KernelTest-Deadline: 2024-03-06T21:16+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is the start of the stable review cycle for the 6.1.81 release.
There are 215 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Wed, 06 Mar 2024 21:15:26 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.81-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 6.1.81-rc1

Maximilian Heyne <mheyne@amazon.de>
    xen/events: close evtchn after mapping cleanup

Ard Biesheuvel <ardb@kernel.org>
    x86/efistub: Give up if memory attribute protocol returns an error

Martynas Pumputis <m@lambda.lt>
    bpf: Derive source IP addr via bpf_*_fib_lookup()

Louis DeLosSantos <louis.delos.devel@gmail.com>
    bpf: Add table ID to bpf_fib_lookup BPF helper

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

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Revert "interconnect: Teach lockdep about icc_bw_lock order"

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Revert "interconnect: Fix locking for runpm vs reclaim"

Ming Lei <ming.lei@redhat.com>
    block: define bvec_iter as __packed __aligned(4)

Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
    gpio: fix resource unwinding order in error path

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    gpiolib: Fix the error path order in gpiochip_add_data_with_key()

Arturas Moskvinas <arturas.moskvinas@gmail.com>
    gpio: 74x164: Enable output pins after registers are reset

Gaurav Batra <gbatra@linux.vnet.ibm.com>
    powerpc/pseries/iommu: IOMMU table is not initialized for kdump over SR-IOV

Alexander Stein <alexander.stein@ew.tq-group.com>
    phy: freescale: phy-fsl-imx8-mipi-dphy: Fix alias name to use dashes

Kuniyuki Iwashima <kuniyu@amazon.com>
    af_unix: Drop oob_skb ref before purging queue in GC.

Ard Biesheuvel <ardb+git@google.com>
    efi/x86: Fix the missing KASLR_FLAG bit in boot_params->hdr.loadflags

Ard Biesheuvel <ardb+git@google.com>
    x86/boot: efistub: Assign global boot_params variable

Ard Biesheuvel <ardb+git@google.com>
    x86/boot: Rename conflicting 'boot_params' pointer to 'boot_params_ptr'

Ard Biesheuvel <ardb+git@google.com>
    x86/efistub: Avoid placing the kernel below LOAD_PHYSICAL_ADDR

Ard Biesheuvel <ardb+git@google.com>
    efi/x86: Avoid physical KASLR on older Dell systems

Ard Biesheuvel <ardb+git@google.com>
    x86/efistub: Avoid legacy decompressor when doing EFI boot

Ard Biesheuvel <ardb+git@google.com>
    x86/efistub: Perform SNP feature test while running in the firmware

Ard Biesheuvel <ardb+git@google.com>
    x86/efistub: Prefer EFI memory attributes protocol over DXE services

Ard Biesheuvel <ardb+git@google.com>
    x86/decompressor: Factor out kernel decompression and relocation

Ard Biesheuvel <ardb+git@google.com>
    x86/efistub: Perform 4/5 level paging switch from the stub

Ard Biesheuvel <ardb+git@google.com>
    efi/libstub: Add limit argument to efi_random_alloc()

Ard Biesheuvel <ardb+git@google.com>
    efi/libstub: Add memory attribute protocol definitions

Ard Biesheuvel <ardb+git@google.com>
    x86/efistub: Clear BSS in EFI handover protocol entrypoint

Ard Biesheuvel <ardb+git@google.com>
    x86/decompressor: Avoid magic offsets for EFI handover entrypoint

Ard Biesheuvel <ardb+git@google.com>
    x86/efistub: Simplify and clean up handover entry code

Ard Biesheuvel <ardb+git@google.com>
    efi: efivars: prevent double registration

Ard Biesheuvel <ardb+git@google.com>
    arm64: efi: Limit allocations to 48-bit addressable physical region

Jeff Layton <jlayton@kernel.org>
    nfsd: don't destroy global nfs4_file table in per-net shutdown

Dai Ngo <dai.ngo@oracle.com>
    NFSD: replace delayed_work with work_struct for nfsd_client_shrinker

Dai Ngo <dai.ngo@oracle.com>
    NFSD: register/unregister of nfsd-client shrinker at nfsd startup/shutdown time

Chuck Lever <chuck.lever@oracle.com>
    NFSD: Use set_bit(RQ_DROPME)

Kees Cook <keescook@chromium.org>
    NFSD: Avoid clashing function prototypes

Chuck Lever <chuck.lever@oracle.com>
    NFSD: Use only RQ_DROPME to signal the need to drop a reply

Dai Ngo <dai.ngo@oracle.com>
    NFSD: add CB_RECALL_ANY tracepoints

Dai Ngo <dai.ngo@oracle.com>
    NFSD: add delegation reaper to react to low memory condition

Dai Ngo <dai.ngo@oracle.com>
    NFSD: add support for sending CB_RECALL_ANY

Dai Ngo <dai.ngo@oracle.com>
    NFSD: refactoring courtesy_client_reaper to a generic low memory shrinker

Chuck Lever <chuck.lever@oracle.com>
    trace: Relocate event helper files

Jeff Layton <jlayton@kernel.org>
    lockd: fix file selection in nlmsvc_cancel_blocked

Jeff Layton <jlayton@kernel.org>
    lockd: ensure we use the correct file descriptor when unlocking

Jeff Layton <jlayton@kernel.org>
    lockd: set missing fl_flags field when retrieving args

Xiu Jianfeng <xiujianfeng@huawei.com>
    NFSD: Use struct_size() helper in alloc_session()

Jeff Layton <jlayton@kernel.org>
    nfsd: fix up the filecache laundrette scheduling

Jeff Layton <jlayton@kernel.org>
    nfsd: use locks_inode_context helper

Jeff Layton <jlayton@kernel.org>
    lockd: use locks_inode_context helper

Jeff Layton <jlayton@kernel.org>
    filelock: add a new locks_inode_context accessor function

Chuck Lever <chuck.lever@oracle.com>
    NFSD: Fix licensing header in filecache.c

Chuck Lever <chuck.lever@oracle.com>
    NFSD: Use rhashtable for managing nfs4_file objects

Chuck Lever <chuck.lever@oracle.com>
    NFSD: Refactor find_file()

Chuck Lever <chuck.lever@oracle.com>
    NFSD: Clean up find_or_add_file()

Chuck Lever <chuck.lever@oracle.com>
    NFSD: Add a nfsd4_file_hash_remove() helper

Chuck Lever <chuck.lever@oracle.com>
    NFSD: Clean up nfsd4_init_file()

Chuck Lever <chuck.lever@oracle.com>
    NFSD: Update file_hashtbl() helpers

Chuck Lever <chuck.lever@oracle.com>
    NFSD: Use const pointers as parameters to fh_ helpers

Chuck Lever <chuck.lever@oracle.com>
    NFSD: Trace delegation revocations

Chuck Lever <chuck.lever@oracle.com>
    NFSD: Trace stateids returned via DELEGRETURN

Chuck Lever <chuck.lever@oracle.com>
    NFSD: Clean up nfs4_preprocess_stateid_op() call sites

Chuck Lever <chuck.lever@oracle.com>
    NFSD: Flesh out a documenting comment for filecache.c

David Disseldorp <ddiss@suse.de>
    exportfs: use pr_debug for unreachable debug statements

Jeff Layton <jlayton@kernel.org>
    nfsd: allow disabling NFSv2 at compile time

Jeff Layton <jlayton@kernel.org>
    nfsd: move nfserrno() to vfs.c

Jeff Layton <jlayton@kernel.org>
    nfsd: ignore requests to disable unsupported versions

Colin Ian King <colin.i.king@gmail.com>
    NFSD: Remove redundant assignment to variable host_err

Anna Schumaker <Anna.Schumaker@Netapp.com>
    NFSD: Simplify READ_PLUS

NeilBrown <neilb@suse.de>
    NFS: Fix data corruption caused by congestion.

Alex Deucher <alexander.deucher@amd.com>
    drm/amd/display: Increase frame warning limit with KASAN or KCSAN in dml

Ard Biesheuvel <ardb@kernel.org>
    decompress: Use 8 byte alignment

Ard Biesheuvel <ardb@kernel.org>
    x86/decompressor: Move global symbol references to C code

Ard Biesheuvel <ardb@kernel.org>
    x86/decompressor: Merge trampoline cleanup with switching code

Ard Biesheuvel <ardb@kernel.org>
    x86/decompressor: Pass pgtable address to trampoline directly

Ard Biesheuvel <ardb@kernel.org>
    x86/decompressor: Only call the trampoline when changing paging levels

Ard Biesheuvel <ardb@kernel.org>
    x86/decompressor: Call trampoline directly from C code

Ard Biesheuvel <ardb@kernel.org>
    x86/decompressor: Avoid the need for a stack in the 32-bit trampoline

Ard Biesheuvel <ardb@kernel.org>
    x86/decompressor: Use standard calling convention for trampoline

Ard Biesheuvel <ardb@kernel.org>
    x86/decompressor: Call trampoline as a normal function

Ard Biesheuvel <ardb@kernel.org>
    x86/decompressor: Assign paging related global variables earlier

Ard Biesheuvel <ardb@kernel.org>
    x86/decompressor: Store boot_params pointer in callee save register

Ard Biesheuvel <ardb@kernel.org>
    x86/efistub: Branch straight to kernel entry point from C code

Alexander Lobakin <alexandr.lobakin@intel.com>
    x86/boot: Robustify calling startup_{32,64}() from the decompressor code

Ard Biesheuvel <ardb@kernel.org>
    x86/efi: Make the deprecated EFI handover protocol optional

Johan Hovold <johan+linaro@kernel.org>
    efi: verify that variable services are supported

Ard Biesheuvel <ardb@kernel.org>
    x86/boot/compressed: Only build mem_encrypt.S if AMD_MEM_ENCRYPT=y

Ard Biesheuvel <ardb@kernel.org>
    x86/boot/compressed: Adhere to calling convention in get_sev_encryption_bit()

Ard Biesheuvel <ardb@kernel.org>
    x86/boot/compressed: Move startup32_check_sev_cbit() out of head_64.S

Ard Biesheuvel <ardb@kernel.org>
    x86/boot/compressed: Move startup32_check_sev_cbit() into .text

Ard Biesheuvel <ardb@kernel.org>
    x86/boot/compressed: Move startup32_load_idt() out of head_64.S

Ard Biesheuvel <ardb@kernel.org>
    x86/boot/compressed: Move startup32_load_idt() into .text section

Ard Biesheuvel <ardb@kernel.org>
    x86/boot/compressed: Pull global variable reference into startup32_load_idt()

Ard Biesheuvel <ardb@kernel.org>
    x86/boot/compressed: Avoid touching ECX in startup32_set_idt_entry()

Ard Biesheuvel <ardb@kernel.org>
    x86/boot/compressed: Simplify IDT/GDT preserve/restore in the EFI thunk

Ard Biesheuvel <ardb@kernel.org>
    x86/boot/compressed, efi: Merge multiple definitions of image_offset into one

Ard Biesheuvel <ardb@kernel.org>
    x86/boot/compressed: Move efi32_pe_entry() out of head_64.S

Ard Biesheuvel <ardb@kernel.org>
    x86/boot/compressed: Move efi32_entry out of head_64.S

Ard Biesheuvel <ardb@kernel.org>
    x86/boot/compressed: Move efi32_pe_entry into .text section

Ard Biesheuvel <ardb@kernel.org>
    x86/boot/compressed: Move bootargs parsing out of 32-bit startup code

Ard Biesheuvel <ardb@kernel.org>
    x86/boot/compressed: Move 32-bit entrypoint code into .text section

Ard Biesheuvel <ardb@kernel.org>
    x86/boot/compressed: Rename efi_thunk_64.S to efi-mixed.S

Ard Biesheuvel <ardb@kernel.org>
    efi: libstub: use EFI_LOADER_CODE region when moving the kernel in memory

Shiraz Saleem <shiraz.saleem@intel.com>
    RDMA/core: Update CMA destination address on rdma_resolve_addr

Patrisious Haddad <phaddad@nvidia.com>
    RDMA/core: Refactor rdma_bind_addr

Paolo Abeni <pabeni@redhat.com>
    mptcp: fix possible deadlock in subflow diag

Davide Caratti <dcaratti@redhat.com>
    mptcp: fix double-free on socket dismantle

Paolo Abeni <pabeni@redhat.com>
    mptcp: fix snd_wnd initialization for passive socket

Geliang Tang <tanggeliang@kylinos.cn>
    selftests: mptcp: join: add ss mptcp support check

Paolo Abeni <pabeni@redhat.com>
    mptcp: push at DSS boundaries

Geliang Tang <tanggeliang@kylinos.cn>
    mptcp: map v4 address to v6 when destroying subflow

Matthieu Baerts (NGI0) <matttbe@kernel.org>
    mptcp: continue marking the first subflow as UNCONNECTED

Paolo Abeni <pabeni@redhat.com>
    mptcp: fix duplicate subflow creation

Paolo Abeni <pabeni@redhat.com>
    mptcp: fix data races on remote_id

Paolo Abeni <pabeni@redhat.com>
    mptcp: fix data races on local_id

Paolo Bonzini <pbonzini@redhat.com>
    x86/cpu/intel: Detect TME keyid bits before setting MTRR mask registers

Jiri Bohac <jbohac@suse.cz>
    x86/e820: Don't reserve SETUP_RNG_SEED in e820

Bjorn Andersson <quic_bjorande@quicinc.com>
    pmdomain: qcom: rpmhpd: Fix enabled_corner aggregation

Tim Schumacher <timschumi@gmx.de>
    efivarfs: Request at most 512 bytes for variable names

Zong Li <zong.li@sifive.com>
    riscv: add CALLER_ADDRx support

Elad Nachman <enachman@marvell.com>
    mmc: sdhci-xenon: fix PHY init clock stability

Elad Nachman <enachman@marvell.com>
    mmc: sdhci-xenon: add timeout for PHY init complete

Ivan Semenov <ivan@semenov.dev>
    mmc: core: Fix eMMC initialization with 1-bit bus connection

Christophe Kerello <christophe.kerello@foss.st.com>
    mmc: mmci: stm32: fix DMA API overlapping mappings warning

Curtis Klein <curtis.klein@hpe.com>
    dmaengine: fsl-qdma: init irq after reg initialization

Tadeusz Struk <tstruk@gigaio.com>
    dmaengine: ptdma: use consistent DMA masks

Ard Biesheuvel <ardb@kernel.org>
    crypto: arm64/neonbs - fix out-of-bounds access on short input

Peng Ma <peng.ma@nxp.com>
    dmaengine: fsl-qdma: fix SoC may hang on 16 byte unaligned read

Matthew Auld <matthew.auld@intel.com>
    drm/buddy: fix range bias

Alex Deucher <alexander.deucher@amd.com>
    Revert "drm/amd/pm: resolve reboot exception for si oland"

Filipe Manana <fdmanana@suse.com>
    btrfs: send: don't issue unnecessary zero writes for trailing hole

David Sterba <dsterba@suse.com>
    btrfs: dev-replace: properly validate device names

Filipe Manana <fdmanana@suse.com>
    btrfs: fix double free of anonymous device after snapshot creation failure

Johannes Berg <johannes.berg@intel.com>
    wifi: nl80211: reject iftype change with mesh ID change

Alexander Ofitserov <oficerovas@altlinux.org>
    gtp: fix use-after-free and null-ptr-deref in gtp_newlink()

Mickaël Salaün <mic@digikod.net>
    landlock: Fix asymmetric private inodes referring

Eniac Zhang <eniac-xw.zhang@hp.com>
    ALSA: hda/realtek: fix mute/micmute LED For HP mt440

Hans Peter <flurry123@gmx.ch>
    ALSA: hda/realtek: Enable Mute LED on HP 840 G8 (MB 8AB8)

Takashi Sakamoto <o-takashi@sakamocchi.jp>
    ALSA: firewire-lib: fix to check cycle continuity

Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
    tomoyo: fix UAF write bug in tomoyo_write_control()

Saravana Kannan <saravanak@google.com>
    of: property: fw_devlink: Fix stupid bug in remote-endpoint parsing

Dimitris Vlachos <dvlachos@ics.forth.gr>
    riscv: Sparse-Memory/vmemmap out-of-bounds fix

David Howells <dhowells@redhat.com>
    afs: Fix endless loop in directory parsing

Jiri Slaby (SUSE) <jirislaby@kernel.org>
    fbcon: always restore the old font data in fbcon_do_set_font()

Thierry Reding <treding@nvidia.com>
    drm/tegra: Remove existing framebuffer only if we support display

Takashi Iwai <tiwai@suse.de>
    ALSA: Drop leftover snd-rtctimer stuff from Makefile

Hans de Goede <hdegoede@redhat.com>
    power: supply: bq27xxx-i2c: Do not free non existing IRQ

Arnd Bergmann <arnd@arndb.de>
    efi/capsule-loader: fix incorrect allocation size

Sabrina Dubroca <sd@queasysnail.net>
    tls: fix peeking with sync+async decryption

Sabrina Dubroca <sd@queasysnail.net>
    tls: decrement decrypt_pending if no async completion will be called

Lukasz Majewski <lukma@denx.de>
    net: hsr: Use correct offset for HSR TLV values in supervisory HSR frames

Oleksij Rempel <linux@rempel-privat.de>
    igb: extend PTP timestamp adjustments to i211

Lin Ma <linma@zju.edu.cn>
    rtnetlink: fix error logic of IFLA_BRIDGE_FLAGS writing back

Florian Westphal <fw@strlen.de>
    netfilter: bridge: confirm multicast packets before passing them up the stack

Florian Westphal <fw@strlen.de>
    netfilter: let reset rules clean out conntrack entries

Ignat Korchagin <ignat@cloudflare.com>
    netfilter: nf_tables: allow NFPROTO_INET in nft_(match/target)_validate()

Janaki Ramaiah Thota <quic_janathot@quicinc.com>
    Bluetooth: hci_qca: Set BDA quirk bit if fwnode exists in DT

Neil Armstrong <neil.armstrong@linaro.org>
    Bluetooth: qca: add support for WCN7850

Neil Armstrong <neil.armstrong@linaro.org>
    Bluetooth: qca: use switch case for soc type behavior

Luca Weiss <luca.weiss@fairphone.com>
    Bluetooth: btqca: Add WCN3988 support

Min-Hua Chen <minhuadotchen@gmail.com>
    Bluetooth: btqca: use le32_to_cpu for ver.soc_id

Steev Klimaszewski <steev@kali.org>
    Bluetooth: hci_qca: Add support for QTI Bluetooth chip wcn6855

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    Bluetooth: hci_qca: mark OF related data as maybe unused

Zijun Hu <quic_zijuhu@quicinc.com>
    Bluetooth: qca: Fix wrong event type for patch config command

Kai-Heng Feng <kai.heng.feng@canonical.com>
    Bluetooth: Enforce validation on max value of connection interval

Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
    Bluetooth: hci_event: Fix handling of HCI_EV_IO_CAPA_REQUEST

Zijun Hu <quic_zijuhu@quicinc.com>
    Bluetooth: hci_event: Fix wrongly recorded wakeup BD_ADDR

Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
    Bluetooth: hci_sync: Fix accept_list when attempting to suspend

Ying Hsu <yinghsu@chromium.org>
    Bluetooth: Avoid potential use-after-free in hci_error_reset

Jonas Dreßler <verdre@v0yd.nl>
    Bluetooth: hci_sync: Check the correct flag before starting a scan

Jakub Raczynski <j.raczynski@samsung.com>
    stmmac: Clear variable when destroying workqueue

Justin Iurman <justin.iurman@uliege.be>
    uapi: in6: replace temporary label with rfc9486

Oleksij Rempel <linux@rempel-privat.de>
    net: lan78xx: fix "softirq work is pending" error

Javier Carrasco <javier.carrasco.cruz@gmail.com>
    net: usb: dm9601: fix wrong return value in dm9601_mdio_read

Jakub Kicinski <kuba@kernel.org>
    veth: try harder when allocating queue memory

Oleksij Rempel <linux@rempel-privat.de>
    lan78xx: enable auto speed configuration for LAN7850 if no EEPROM is detected

Eric Dumazet <edumazet@google.com>
    ipv6: fix potential "struct net" leak in inet6_rtm_getaddr()

Jakub Kicinski <kuba@kernel.org>
    net: veth: clear GRO when clearing XDP even when down

Doug Smythies <dsmythies@telus.net>
    cpufreq: intel_pstate: fix pstate limits enforcement for adjust_perf call back

Yunjian Wang <wangyunjian@huawei.com>
    tun: Fix xdp_rxq_info's queue_index when detaching

Jeremy Kerr <jk@codeconstruct.com.au>
    net: mctp: take ownership of skb in mctp_local_output

Florian Westphal <fw@strlen.de>
    net: ip_tunnel: prevent perpetual headroom growth

Florian Westphal <fw@strlen.de>
    netlink: add nla be16/32 types to minlen array

Ryosuke Yasuoka <ryasuoka@redhat.com>
    netlink: Fix kernel-infoleak-after-free in __skb_datagram_iter

Han Xu <han.xu@nxp.com>
    mtd: spinand: gigadevice: Fix the get ecc status issue

Yang Shi <yang@os.amperecomputing.com>
    mm: huge_memory: don't force huge page alignment on 32 bit

Gustavo A. R. Silva <gustavoars@kernel.org>
    RDMA/core: Fix multiple -Warray-bounds warnings

Manivannan Sadhasivam <mani@kernel.org>
    iommu/arm-smmu-qcom: Limit the SMR groups to 128

Ye Bin <yebin10@huawei.com>
    fs/ntfs3: Fix NULL pointer dereference in 'ni_write_inode'

Abdun Nihaal <abdun.nihaal@gmail.com>
    fs/ntfs3: Fix NULL dereference in ni_write_inode

Edward Lo <edward.lo@ambergroup.io>
    fs/ntfs3: Add length check in indx_get_root

Arnd Bergmann <arnd@arndb.de>
    clk: tegra20: fix gcc-7 constant overflow warning

Jia-Ju Bai <baijiaju1990@gmail.com>
    fs/ntfs3: Fix a possible null-pointer dereference in ni_clear()

Tomas Krcka <krckatom@amazon.de>
    iommu/arm-smmu-v3: Acknowledge pri/event queue overflow if any

Chunyan Zhang <chunyan.zhang@unisoc.com>
    iommu/sprd: Release dma buffer to avoid memory leak

Vicki Pfau <vi@endrift.com>
    Input: xpad - add constants for GIP interface numbers

Elson Roy Serrao <quic_eserrao@quicinc.com>
    usb: gadget: Properly configure the device for remote wakeup

Marek Vasut <marex@denx.de>
    ARM: dts: imx7s: Drop dma-apb interrupt-names

Stefan Wahren <stefan.wahren@i2se.com>
    ARM: dts: imx: Adjust dma-apbh node name

Xiaowei Bao <xiaowei.bao@nxp.com>
    PCI: layerscape: Add workaround for lost link capabilities during reset

Frank Li <Frank.Li@nxp.com>
    PCI: layerscape: Add the endpoint linkup notifier support

Ido Schimmel <idosch@nvidia.com>
    mlxsw: spectrum_acl_tcam: Add missing mutex_destroy()

Ido Schimmel <idosch@nvidia.com>
    mlxsw: spectrum_acl_tcam: Make fini symmetric to init

Bjorn Helgaas <bhelgaas@google.com>
    net: restore alpha order to Ethernet devices in config

Geert Uytterhoeven <geert+renesas@glider.be>
    of: overlay: Reorder struct fragment fields kerneldoc

Kuniyuki Iwashima <kuniyu@amazon.com>
    af_unix: Fix task hung while purging oob_skb in GC.

Martin K. Petersen <martin.petersen@oracle.com>
    scsi: sd: usb_storage: uas: Access media prior to querying device properties

Mike Christie <michael.christie@oracle.com>
    scsi: core: Add struct for args to execution functions

Martin Blumenstingl <martin.blumenstingl@googlemail.com>
    drm/meson: Don't remove bridges which are created by other drivers

Neil Armstrong <neil.armstrong@linaro.org>
    drm/meson: fix unbind path if HDMI fails to bind

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: disallow timeout for anonymous sets


-------------

Diffstat:

 Documentation/x86/boot.rst                         |   2 +-
 Documentation/x86/mds.rst                          |  34 +-
 MAINTAINERS                                        |   7 +
 Makefile                                           |   4 +-
 arch/arm/boot/dts/imx23.dtsi                       |   2 +-
 arch/arm/boot/dts/imx28.dtsi                       |   2 +-
 arch/arm/boot/dts/imx6qdl.dtsi                     |   2 +-
 arch/arm/boot/dts/imx6sx.dtsi                      |   2 +-
 arch/arm/boot/dts/imx6ul.dtsi                      |   2 +-
 arch/arm/boot/dts/imx7s.dtsi                       |   3 +-
 arch/arm64/crypto/aes-neonbs-glue.c                |  11 +
 arch/arm64/include/asm/efi.h                       |   1 +
 arch/powerpc/platforms/pseries/iommu.c             | 156 +++--
 arch/riscv/include/asm/ftrace.h                    |   5 +
 arch/riscv/include/asm/pgtable.h                   |   2 +-
 arch/riscv/kernel/Makefile                         |   2 +
 arch/riscv/kernel/return_address.c                 |  48 ++
 arch/x86/Kconfig                                   |  17 +
 arch/x86/boot/compressed/Makefile                  |  13 +-
 arch/x86/boot/compressed/acpi.c                    |  14 +-
 arch/x86/boot/compressed/cmdline.c                 |   4 +-
 arch/x86/boot/compressed/efi_mixed.S               | 328 +++++++++
 arch/x86/boot/compressed/efi_thunk_64.S            | 195 ------
 arch/x86/boot/compressed/head_32.S                 |  38 +-
 arch/x86/boot/compressed/head_64.S                 | 593 +++-------------
 arch/x86/boot/compressed/ident_map_64.c            |   7 +-
 arch/x86/boot/compressed/kaslr.c                   |  26 +-
 arch/x86/boot/compressed/mem_encrypt.S             | 152 +++-
 arch/x86/boot/compressed/misc.c                    |  85 ++-
 arch/x86/boot/compressed/misc.h                    |   3 -
 arch/x86/boot/compressed/pgtable.h                 |  10 +-
 arch/x86/boot/compressed/pgtable_64.c              |  94 ++-
 arch/x86/boot/compressed/sev.c                     | 114 +--
 arch/x86/boot/header.S                             |   2 +-
 arch/x86/boot/tools/build.c                        |   2 +
 arch/x86/entry/entry.S                             |  23 +
 arch/x86/entry/entry_32.S                          |   3 +
 arch/x86/entry/entry_64.S                          |  11 +
 arch/x86/entry/entry_64_compat.S                   |   1 +
 arch/x86/include/asm/boot.h                        |  10 +
 arch/x86/include/asm/cpufeatures.h                 |   2 +-
 arch/x86/include/asm/efi.h                         |  14 +-
 arch/x86/include/asm/entry-common.h                |   1 -
 arch/x86/include/asm/nospec-branch.h               |  27 +-
 arch/x86/include/asm/sev.h                         |   7 +
 arch/x86/kernel/cpu/bugs.c                         |  15 +-
 arch/x86/kernel/cpu/intel.c                        | 178 ++---
 arch/x86/kernel/e820.c                             |   8 +-
 arch/x86/kernel/nmi.c                              |   3 -
 arch/x86/kvm/vmx/run_flags.h                       |   7 +-
 arch/x86/kvm/vmx/vmenter.S                         |   9 +-
 arch/x86/kvm/vmx/vmx.c                             |  12 +-
 drivers/bluetooth/btqca.c                          | 104 ++-
 drivers/bluetooth/btqca.h                          |  23 +-
 drivers/bluetooth/hci_qca.c                        | 310 +++++++--
 drivers/clk/tegra/clk-tegra20.c                    |  26 +-
 drivers/cpufreq/intel_pstate.c                     |   3 +
 drivers/dma/fsl-qdma.c                             |  25 +-
 drivers/dma/ptdma/ptdma-dmaengine.c                |   2 -
 drivers/firmware/efi/capsule-loader.c              |   2 +-
 drivers/firmware/efi/efi.c                         |  22 +
 drivers/firmware/efi/libstub/Makefile              |   1 +
 drivers/firmware/efi/libstub/alignedmem.c          |   7 +-
 drivers/firmware/efi/libstub/arm64-stub.c          |  11 +-
 drivers/firmware/efi/libstub/efi-stub-helper.c     |   2 +
 drivers/firmware/efi/libstub/efistub.h             |  32 +-
 drivers/firmware/efi/libstub/mem.c                 |   5 +-
 drivers/firmware/efi/libstub/randomalloc.c         |  17 +-
 drivers/firmware/efi/libstub/x86-5lvl.c            |  95 +++
 drivers/firmware/efi/libstub/x86-stub.c            | 319 +++++----
 drivers/firmware/efi/libstub/x86-stub.h            |  17 +
 drivers/firmware/efi/vars.c                        |  13 +-
 drivers/gpio/gpio-74x164.c                         |   4 +-
 drivers/gpio/gpiolib.c                             |  12 +-
 drivers/gpu/drm/amd/display/dc/dml/Makefile        |   4 +
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c         |  29 +
 drivers/gpu/drm/drm_buddy.c                        |  10 +
 drivers/gpu/drm/meson/meson_drv.c                  |  23 +-
 drivers/gpu/drm/meson/meson_encoder_cvbs.c         |   1 -
 drivers/gpu/drm/meson/meson_encoder_hdmi.c         |   1 -
 drivers/gpu/drm/tegra/drm.c                        |  23 +-
 drivers/infiniband/core/cm_trace.h                 |   2 +-
 drivers/infiniband/core/cma.c                      | 255 +++----
 drivers/infiniband/core/cma_trace.h                |   2 +-
 drivers/infiniband/core/user_mad.c                 |  23 +-
 drivers/input/joystick/xpad.c                      |   5 +-
 drivers/interconnect/core.c                        |  18 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c        |  19 +-
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c         |  16 +-
 drivers/iommu/sprd-iommu.c                         |  29 +-
 drivers/mmc/core/mmc.c                             |   2 +
 drivers/mmc/host/mmci_stm32_sdmmc.c                |  24 +
 drivers/mmc/host/sdhci-xenon-phy.c                 |  48 +-
 drivers/mtd/nand/spi/gigadevice.c                  |   6 +-
 drivers/net/ethernet/Kconfig                       |   2 +-
 drivers/net/ethernet/intel/igb/igb_ptp.c           |   5 +-
 .../ethernet/mellanox/mlxsw/spectrum_acl_tcam.c    |  10 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |   4 +-
 drivers/net/gtp.c                                  |  12 +-
 drivers/net/tun.c                                  |   1 +
 drivers/net/usb/dm9601.c                           |   2 +-
 drivers/net/usb/lan78xx.c                          |   5 +-
 drivers/net/veth.c                                 |  40 +-
 drivers/of/overlay.c                               |   2 +-
 drivers/of/property.c                              |   2 +-
 drivers/pci/controller/dwc/pci-layerscape-ep.c     | 119 +++-
 drivers/phy/freescale/phy-fsl-imx8-mipi-dphy.c     |   2 +-
 drivers/power/supply/bq27xxx_battery_i2c.c         |   4 +-
 drivers/scsi/scsi_lib.c                            |  52 +-
 drivers/scsi/sd.c                                  |  26 +-
 drivers/soc/qcom/rpmhpd.c                          |   7 +-
 drivers/usb/gadget/composite.c                     |  18 +
 drivers/usb/gadget/configfs.c                      |   3 +
 drivers/usb/gadget/udc/core.c                      |  27 +
 drivers/usb/gadget/udc/trace.h                     |   5 +
 drivers/usb/storage/scsiglue.c                     |   7 +
 drivers/usb/storage/uas.c                          |   7 +
 drivers/video/fbdev/core/fbcon.c                   |   8 +-
 drivers/xen/events/events_base.c                   |   5 +-
 fs/afs/dir.c                                       |   4 +-
 fs/btrfs/dev-replace.c                             |  24 +-
 fs/btrfs/disk-io.c                                 |  22 +-
 fs/btrfs/disk-io.h                                 |   2 +-
 fs/btrfs/ioctl.c                                   |   2 +-
 fs/btrfs/send.c                                    |  17 +-
 fs/btrfs/transaction.c                             |   2 +-
 fs/efivarfs/vars.c                                 |  17 +-
 fs/exportfs/expfs.c                                |   8 +-
 fs/lockd/svc4proc.c                                |   1 +
 fs/lockd/svclock.c                                 |  17 +-
 fs/lockd/svcproc.c                                 |   1 +
 fs/lockd/svcsubs.c                                 |   4 +-
 fs/locks.c                                         |  24 +-
 fs/nfs/nfs4trace.h                                 |   6 +-
 fs/nfs/nfstrace.h                                  |   6 +-
 fs/nfs/write.c                                     |   4 +-
 fs/nfsd/Kconfig                                    |  19 +-
 fs/nfsd/Makefile                                   |   5 +-
 fs/nfsd/blocklayout.c                              |   1 +
 fs/nfsd/blocklayoutxdr.c                           |   1 +
 fs/nfsd/export.h                                   |   1 -
 fs/nfsd/filecache.c                                |  39 +-
 fs/nfsd/flexfilelayout.c                           |   1 +
 fs/nfsd/netns.h                                    |   2 +-
 fs/nfsd/nfs4callback.c                             |  72 ++
 fs/nfsd/nfs4idmap.c                                |   1 +
 fs/nfsd/nfs4proc.c                                 |  31 +-
 fs/nfsd/nfs4state.c                                | 316 ++++++---
 fs/nfsd/nfs4xdr.c                                  | 771 +++++++++++----------
 fs/nfsd/nfsctl.c                                   |  13 +-
 fs/nfsd/nfsd.h                                     |   9 +-
 fs/nfsd/nfsfh.h                                    |  10 +-
 fs/nfsd/nfsproc.c                                  |  66 +-
 fs/nfsd/nfssvc.c                                   |   8 +-
 fs/nfsd/state.h                                    |  11 +-
 fs/nfsd/trace.h                                    | 106 +++
 fs/nfsd/vfs.c                                      |  64 +-
 fs/nfsd/vfs.h                                      |   1 +
 fs/nfsd/xdr4.h                                     |   5 +
 fs/nfsd/xdr4cb.h                                   |   6 +
 fs/ntfs3/frecord.c                                 |   5 +-
 fs/ntfs3/fsntfs.c                                  |   1 +
 fs/ntfs3/index.c                                   |  11 +-
 include/linux/bvec.h                               |   2 +-
 include/linux/decompress/mm.h                      |   2 +-
 include/linux/efi.h                                |   1 +
 include/linux/fs.h                                 |  14 +
 include/linux/netfilter.h                          |   4 +
 include/linux/nfs4.h                               |  13 +
 include/linux/usb/composite.h                      |   2 +
 include/linux/usb/gadget.h                         |   8 +
 include/net/ipv6_stubs.h                           |   5 +
 include/net/mctp.h                                 |   1 +
 include/net/netfilter/nf_conntrack.h               |   8 +
 include/scsi/scsi_device.h                         |  52 +-
 include/trace/events/rpcgss.h                      |   2 +-
 include/trace/events/rpcrdma.h                     |   4 +-
 include/trace/events/sunrpc.h                      |   2 +-
 include/trace/{events => misc}/fs.h                |   0
 include/trace/{events => misc}/nfs.h               |  12 +
 include/trace/{events => misc}/rdma.h              |   0
 .../trace/{events/sunrpc_base.h => misc/sunrpc.h}  |   0
 include/uapi/linux/bpf.h                           |  31 +-
 include/uapi/linux/in6.h                           |   2 +-
 lib/nlattr.c                                       |   4 +
 mm/huge_memory.c                                   |   4 +
 net/bluetooth/hci_core.c                           |   7 +-
 net/bluetooth/hci_event.c                          |  13 +-
 net/bluetooth/hci_sync.c                           |   7 +-
 net/bluetooth/l2cap_core.c                         |   8 +-
 net/bridge/br_netfilter_hooks.c                    |  96 +++
 net/bridge/netfilter/nf_conntrack_bridge.c         |  30 +
 net/core/filter.c                                  |  30 +-
 net/core/rtnetlink.c                               |  11 +-
 net/hsr/hsr_forward.c                              |   2 +-
 net/ipv4/ip_tunnel.c                               |  28 +-
 net/ipv4/netfilter/nf_reject_ipv4.c                |   1 +
 net/ipv6/addrconf.c                                |   7 +-
 net/ipv6/af_inet6.c                                |   1 +
 net/ipv6/netfilter/nf_reject_ipv6.c                |   1 +
 net/mctp/route.c                                   |  10 +-
 net/mptcp/diag.c                                   |   5 +-
 net/mptcp/pm_netlink.c                             |  48 +-
 net/mptcp/pm_userspace.c                           |  12 +-
 net/mptcp/protocol.c                               |  56 +-
 net/mptcp/protocol.h                               |  13 +-
 net/mptcp/subflow.c                                |  15 +-
 net/netfilter/core.c                               |  16 +
 net/netfilter/nf_conntrack_core.c                  |  13 +
 net/netfilter/nf_conntrack_proto_tcp.c             |  35 +
 net/netfilter/nf_tables_api.c                      |   7 +
 net/netfilter/nft_compat.c                         |  20 +
 net/netlink/af_netlink.c                           |   2 +-
 net/tls/tls_sw.c                                   |  11 +-
 net/unix/garbage.c                                 |  21 +-
 net/wireless/nl80211.c                             |   2 +
 security/landlock/fs.c                             |   4 +-
 security/tomoyo/common.c                           |   3 +-
 sound/core/Makefile                                |   1 -
 sound/firewire/amdtp-stream.c                      |   2 +-
 sound/pci/hda/patch_realtek.c                      |   3 +
 tools/include/uapi/linux/bpf.h                     |  31 +-
 tools/testing/selftests/net/mptcp/mptcp_join.sh    |   5 +
 223 files changed, 4349 insertions(+), 2418 deletions(-)



