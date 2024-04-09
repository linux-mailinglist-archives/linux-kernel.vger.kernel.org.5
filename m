Return-Path: <linux-kernel+bounces-137407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D24289E19B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 19:31:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 860F61F24DD9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 17:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D188115667C;
	Tue,  9 Apr 2024 17:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PJUFY4S7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D9313C66C;
	Tue,  9 Apr 2024 17:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712683857; cv=none; b=sz7XGBIwHFloaAA0ILCw1i3jyiSmACIBAtCU8tJPM49RcUKn0oE75kDNh0FNsWjOFPUNgBkPPwDSJ9FGB3mPoEQipY49zPXllYUxuq99+2Sh25HoFEIAuozcoq+haWu+uQmKUPuEXly8q6wY2bFOc2d9WE76NBFtnMV2isdDSv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712683857; c=relaxed/simple;
	bh=FEn636DDuMprI197Mc3pS7Bp5rOx1Ebd+rtIorlQRVs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=A4lDLsFS4ibkErKellQI/lLynDTO8lxjnCBpuox4Z5KZa/oh+b2flpbPR6/DxS9nRXJRbLNPI2TPeR6Z4iv03QfIbmciUiuGnVyeD3I5EfxCPCHvZlFJvcH/quoGbJ2czs57R+oEMQ6f+k02C0kEaqeQHU/Wp1+BdvnsLXhrvVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PJUFY4S7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF65CC43390;
	Tue,  9 Apr 2024 17:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712683857;
	bh=FEn636DDuMprI197Mc3pS7Bp5rOx1Ebd+rtIorlQRVs=;
	h=From:To:Cc:Subject:Date:From;
	b=PJUFY4S7n4MVA1zOem8d4G9/XZ2iuoduCY/9QDJ2wXBsYezYnXk2Oxyqpe+MBZR3v
	 JGLffStceNXgG9GbbTeH0Xo9JEbPQrZgLSy/wVL7CJIX84PdcboIoALkiabTCFQGGO
	 4HNDsD/rmuEUCC9yQjh51OdG4dFTCSf9VLz+1izk=
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
Subject: [PATCH 6.8 000/279] 6.8.5-rc2 review
Date: Tue,  9 Apr 2024 19:30:53 +0200
Message-ID: <20240409172824.552652165@linuxfoundation.org>
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
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.8.5-rc2.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.8.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.8.5-rc2
X-KernelTest-Deadline: 2024-04-11T17:28+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is the start of the stable review cycle for the 6.8.5 release.
There are 279 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Thu, 11 Apr 2024 17:27:40 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.8.5-rc2.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.8.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 6.8.5-rc2

Daniel Sneddon <daniel.sneddon@linux.intel.com>
    KVM: x86: Add BHI_NO

Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
    x86/bhi: Mitigate KVM by default

Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
    x86/bhi: Add BHI mitigation knob

Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
    x86/bhi: Enumerate Branch History Injection (BHI) bug

Daniel Sneddon <daniel.sneddon@linux.intel.com>
    x86/bhi: Define SPEC_CTRL_BHI_DIS_S

Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
    x86/bhi: Add support for clearing branch history at syscall entry

Linus Torvalds <torvalds@linux-foundation.org>
    x86/syscall: Don't force use of indirect calls for system calls

Josh Poimboeuf <jpoimboe@kernel.org>
    x86/bugs: Change commas to semicolons in 'spectre_v2' sysfs file

Ard Biesheuvel <ardb@kernel.org>
    x86/efistub: Remap kernel text read-only before dropping NX attribute

Ard Biesheuvel <ardb@kernel.org>
    x86/sev: Move early startup code into .head.text section

Ard Biesheuvel <ardb@kernel.org>
    x86/sme: Move early SME kernel encryption handling into .head.text

Ard Biesheuvel <ardb@kernel.org>
    x86/boot: Move mem_encrypt= parsing to the decompressor

Ard Biesheuvel <ardb@kernel.org>
    efi/libstub: Add generic support for parsing mem_encrypt=

Andrii Nakryiko <andrii@kernel.org>
    bpf: support deferring bpf_link dealloc to after RCU grace period

Andrii Nakryiko <andrii@kernel.org>
    bpf: put uprobe link's path and task in release callback

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Revert "x86/mpparse: Register APIC address only once"

Thomas Hellström <thomas.hellstrom@linux.intel.com>
    drm/xe: Rework rebinding

Thomas Hellström <thomas.hellstrom@linux.intel.com>
    drm/xe: Use ring ops TLB invalidation for rebinds

Andi Shyti <andi.shyti@linux.intel.com>
    drm/i915/gt: Enable only one CCS for compute workload

Andi Shyti <andi.shyti@linux.intel.com>
    drm/i915/gt: Do not generate the command streamer for all the CCS

Andi Shyti <andi.shyti@linux.intel.com>
    drm/i915/gt: Disable HW load balancing for CCS

Ankit Nautiyal <ankit.k.nautiyal@intel.com>
    drm/i915/dp: Fix the computation for compressed_bpp for DISPLAY < 13

Ville Syrjälä <ville.syrjala@linux.intel.com>
    drm/i915/mst: Reject FEC+MST on ICL

Ville Syrjälä <ville.syrjala@linux.intel.com>
    drm/i915/mst: Limit MST+DSC to TGL+

Paulo Alcantara <pc@manguebit.com>
    smb: client: fix potential UAF in cifs_signal_cifsd_for_reconnect()

Paulo Alcantara <pc@manguebit.com>
    smb: client: fix potential UAF in smb2_is_network_name_deleted()

Paulo Alcantara <pc@manguebit.com>
    smb: client: fix potential UAF in is_valid_oplock_break()

Paulo Alcantara <pc@manguebit.com>
    smb: client: fix potential UAF in smb2_is_valid_lease_break()

Paulo Alcantara <pc@manguebit.com>
    smb: client: fix potential UAF in smb2_is_valid_oplock_break()

Paulo Alcantara <pc@manguebit.com>
    smb: client: fix potential UAF in cifs_dump_full_key()

Paulo Alcantara <pc@manguebit.com>
    smb: client: fix potential UAF in cifs_stats_proc_show()

Paulo Alcantara <pc@manguebit.com>
    smb: client: fix potential UAF in cifs_stats_proc_write()

Paulo Alcantara <pc@manguebit.com>
    smb: client: fix potential UAF in cifs_debug_files_proc_show()

Ritvik Budhiraja <rbudhiraja@microsoft.com>
    smb3: retrying on failed server close

Paulo Alcantara <pc@manguebit.com>
    smb: client: serialise cifs_construct_tcon() with cifs_mount_mutex

Paulo Alcantara <pc@manguebit.com>
    smb: client: handle DFS tcons in cifs_construct_tcon()

Paulo Alcantara <pc@manguebit.com>
    smb: client: refresh referral without acquiring refpath_lock

Paulo Alcantara <pc@manguebit.com>
    smb: client: guarantee refcounted children from parent session

Paulo Alcantara <pc@manguebit.com>
    smb: client: fix UAF in smb2_reconnect_server()

Stefan O'Rear <sorear@fastmail.com>
    riscv: process: Fix kernel gp leakage

Samuel Holland <samuel.holland@sifive.com>
    riscv: Fix spurious errors from __get/put_kernel_nofault

Sumanth Korikkar <sumanthk@linux.ibm.com>
    s390/entry: align system call table on 8 bytes

Edward Liaw <edliaw@google.com>
    selftests/mm: include strings.h for ffsl

David Hildenbrand <david@redhat.com>
    mm/secretmem: fix GUP-fast succeeding on secretmem folios

Mark Brown <broonie@kernel.org>
    arm64/ptrace: Use saved floating point state type to determine SVE layout

Björn Töpel <bjorn@rivosinc.com>
    riscv: Fix vector state restore in rt_sigreturn()

Kent Overstreet <kent.overstreet@linux.dev>
    aio: Fix null ptr deref in aio_complete() wakeup

Kan Liang <kan.liang@linux.intel.com>
    perf/x86/intel/ds: Don't clear ->pebs_data_cfg for the last PEBS event

Jason A. Donenfeld <Jason@zx2c4.com>
    x86/coco: Require seeding RNG with RDRAND on CoCo systems

Borislav Petkov (AMD) <bp@alien8.de>
    x86/mce: Make sure to grab mce_sysfs_mutex in set_bank()

David Hildenbrand <david@redhat.com>
    x86/mm/pat: fix VM_PAT handling in COW mappings

Sergey Shtylyov <s.shtylyov@omp.ru>
    of: module: prevent NULL pointer dereference in vsnprintf()

Herve Codina <herve.codina@bootlin.com>
    of: dynamic: Synchronize of_changeset_destroy() with the devlink removals

Herve Codina <herve.codina@bootlin.com>
    driver core: Introduce device_link_wait_removal()

Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
    ASoC: SOF: Intel: hda: Compensate LLP in case it is not reset

Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
    ASoC: SOF: ipc4-pcm: Correct the delay calculation

Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
    ASoC: SOF: sof-pcm: Add pointer callback to sof_ipc_pcm_ops

Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
    ASoC: SOF: ipc4-pcm: Invalidate the stream_start_offset in PAUSED state

Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
    ASoC: SOF: ipc4-pcm: Combine the SOF_IPC4_PIPE_PAUSED cases in pcm_trigger

Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
    ASoC: SOF: ipc4-pcm: Move struct sof_ipc4_timestamp_info definition locally

Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
    ASoC: SOF: Remove the get_stream_position callback

Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
    ASoC: SOF: ipc4-pcm: Use the snd_sof_pcm_get_dai_frame_counter() for pcm_delay

Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
    ASoC: SOF: Intel: hda-common-ops: Do not set the get_stream_position callback

Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
    ASoC: SOF: Intel: Set the dai/host get frame/byte counter callbacks

Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
    ASoC: SOF: Introduce a new callback pair to be used for PCM delay reporting

Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
    ASoC: SOF: Intel: mtl/lnl: Use the generic get_stream_position callback

Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
    ASoC: SOF: Intel: hda: Implement get_stream_position (Linear Link Position)

Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
    ASoC: SOF: Intel: hda-pcm: Use dsp_max_burst_size_in_ms to place constraint

Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
    ASoC: SOF: ipc4-topology: Save the DMA maximum burst size for PCMs

Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
    ASoC: SOF: Add dsp_max_burst_size_in_ms member to snd_sof_pcm_stream

Jens Axboe <axboe@kernel.dk>
    io_uring/kbuf: hold io_buffer_list reference over mmap

Jens Axboe <axboe@kernel.dk>
    io_uring: use private workqueue for exit work

Jens Axboe <axboe@kernel.dk>
    io_uring/rw: don't allow multishot reads without NOWAIT support

Jens Axboe <axboe@kernel.dk>
    io_uring/kbuf: protect io_buffer_list teardown with a reference

Jens Axboe <axboe@kernel.dk>
    io_uring/kbuf: get rid of bl->is_ready

Jens Axboe <axboe@kernel.dk>
    io_uring/kbuf: get rid of lower BGID lists

I Gede Agastya Darma Laksana <gedeagas22@gmail.com>
    ALSA: hda/realtek: Update Panasonic CF-SZ6 quirk to support headset with microphone

Luke D. Jones <luke@ljones.dev>
    ALSA: hda/realtek: cs35l41: Support ASUS ROG G634JYR

Christian Bendiksen <christian@bendiksen.me>
    ALSA: hda/realtek: Add sound quirks for Lenovo Legion slim 7 16ARHA7 models

Christoffer Sandberg <cs@tuxedo.de>
    ALSA: hda/realtek - Fix inactive headset mic jack

Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
    ALSA: hda: Add pplcllpl/u members to hdac_ext_stream

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: do not set SMB2_GLOBAL_CAP_ENCRYPTION for SMB 3.1.1

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: validate payload size in ipc response

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: don't send oplock break if rename fails

Kent Gibson <warthog618@gmail.com>
    gpio: cdev: fix missed label sanitizing in debounce_setup()

Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
    gpio: cdev: check for NULL labels when sanitizing them for irqs

Gabe Teeger <gabe.teeger@amd.com>
    Revert "drm/amd/display: Send DTBCLK disable message on first commit"

Borislav Petkov (AMD) <bp@alien8.de>
    x86/retpoline: Add NOENDBR annotation to the SRSO dummy return thunk

Peter Collingbourne <pcc@google.com>
    stackdepot: rename pool_index to pool_index_plus_1

Oscar Salvador <osalvador@suse.de>
    lib/stackdepot: move stack_record struct definition into the header

Jeff Layton <jlayton@kernel.org>
    nfsd: hold a lighter-weight client reference over CB_RECALL_ANY

Alexandre Ghiti <alexghiti@rivosinc.com>
    riscv: Disable preemption when using patch_map()

Alexandre Ghiti <alexghiti@rivosinc.com>
    riscv: Fix warning by declaring arch_cpu_idle() as noinstr

Andreas Schwab <schwab@suse.de>
    riscv: use KERN_INFO in do_trap

Chuck Lever <chuck.lever@oracle.com>
    SUNRPC: Fix a slow server-side memory leak with RPC-over-TCP

Vijendar Mukunda <Vijendar.Mukunda@amd.com>
    ASoC: SOF: amd: fix for false dsp interrupts

Arnd Bergmann <arnd@arndb.de>
    ata: sata_mv: Fix PCI device ID table declaration compilation warning

Andi Shyti <andi.shyti@linux.intel.com>
    drm/i915/gt: Limit the reserved VM space to only the platforms that need it

Nikita Travkin <nikita@trvn.ru>
    thermal: gov_power_allocator: Allow binding without trip points

Nikita Travkin <nikita@trvn.ru>
    thermal: gov_power_allocator: Allow binding without cooling devices

Thomas Richter <tmricht@linux.ibm.com>
    s390/pai: fix sampling event removal for PMU device driver

Huai-Yuan Liu <qq810974084@gmail.com>
    spi: mchp-pci1xxx: Fix a possible null pointer dereference in pci1xxx_spi_probe

David Howells <dhowells@redhat.com>
    cifs: Fix caching to try to do open O_WRONLY as rdwr on server

Imre Deak <imre.deak@intel.com>
    drm/i915/dp: Fix DSC state HW readout for SST connectors

Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
    Revert "ALSA: emu10k1: fix synthesizer sample playback position and caching"

Li Nan <linan122@huawei.com>
    scsi: sd: Unregister device if device_add_disk() failed in sd_probe()

Arnd Bergmann <arnd@arndb.de>
    scsi: mylex: Fix sysfs buffer lengths

Arnd Bergmann <arnd@arndb.de>
    ata: sata_sx4: fix pdc20621_get_from_dimm() on 64-bit

Richard Fitzgerald <rf@opensource.cirrus.com>
    regmap: maple: Fix uninitialized symbol 'ret' warnings

Vijendar Mukunda <Vijendar.Mukunda@amd.com>
    ASoC: amd: acp: fix for acp_init function error handling

Jaewon Kim <jaewon02.kim@samsung.com>
    spi: s3c64xx: Use DMA mode from fifo size

Tudor Ambarus <tudor.ambarus@linaro.org>
    spi: s3c64xx: determine the fifo depth only once

Tudor Ambarus <tudor.ambarus@linaro.org>
    spi: s3c64xx: allow full FIFO masks

Tudor Ambarus <tudor.ambarus@linaro.org>
    spi: s3c64xx: define a magic value

Tudor Ambarus <tudor.ambarus@linaro.org>
    spi: s3c64xx: remove else after return

Tudor Ambarus <tudor.ambarus@linaro.org>
    spi: s3c64xx: explicitly include <linux/bits.h>

Tudor Ambarus <tudor.ambarus@linaro.org>
    spi: s3c64xx: sort headers alphabetically

Sam Protsenko <semen.protsenko@linaro.org>
    spi: s3c64xx: Extract FIFO depth calculation to a dedicated macro

Stephen Lee <slee08177@gmail.com>
    ASoC: ops: Fix wraparound for mask in snd_soc_get_volsw

Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
    ASoC: rt722-sdca-sdw: fix locking sequence

Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
    ASoC: rt712-sdca-sdw: fix locking sequence

Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
    ASoC: rt711-sdw: fix locking sequence

Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
    ASoC: rt711-sdca: fix locking sequence

Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
    ASoC: rt5682-sdw: fix locking sequence

Rob Clark <robdclark@chromium.org>
    drm/prime: Unbreak virtgpu dma-buf export

Dave Airlie <airlied@redhat.com>
    nouveau/uvmm: fix addr/range calcs for remap operations

Christian Hewitt <christianshewitt@gmail.com>
    drm/panfrost: fix power transition timeout warnings

Simon Trimmer <simont@opensource.cirrus.com>
    ALSA: hda: cs35l56: Add ACPI device match tables

Richard Fitzgerald <rf@opensource.cirrus.com>
    regmap: maple: Fix cache corruption in regcache_maple_drop()

Vijendar Mukunda <Vijendar.Mukunda@amd.com>
    ASoC: amd: acp: fix for acp pdm configuration check

Victor Isaev <victor@torrio.net>
    RISC-V: Update AT_VECTOR_SIZE_ARCH for new AT_MINSIGSTKSZ

Christian Brauner <brauner@kernel.org>
    block: count BLK_OPEN_RESTRICT_WRITES openers

Pu Lehui <pulehui@huawei.com>
    drivers/perf: riscv: Disable PERF_SAMPLE_BRANCH_* while not supported

Vladimir Isaev <vladimir.isaev@syntacore.com>
    riscv: hwprobe: do not produce frtace relocation

Samuel Holland <samuel.holland@sifive.com>
    riscv: mm: Fix prototype to avoid discarding const

Charles Keepax <ckeepax@opensource.cirrus.com>
    ASoC: cs42l43: Correct extraction of data pointer in suspend/resume

Richard Fitzgerald <rf@opensource.cirrus.com>
    ASoC: wm_adsp: Fix missing mutex_lock in wm_adsp_write_ctl()

Dominique Martinet <asmadeus@codewreck.org>
    9p: Fix read/write debug statements to report server reply

Davide Caratti <dcaratti@redhat.com>
    mptcp: don't account accept() of non-MPC client as fallback to TCP

Geliang Tang <tanggeliang@kylinos.cn>
    selftests: mptcp: use += operator to append strings

Matthieu Baerts (NGI0) <matttbe@kernel.org>
    selftests: mptcp: connect: fix shellcheck warnings

Ashish Kalra <ashish.kalra@amd.com>
    KVM: SVM: Add support for allowing zero SEV ASIDs

Sean Christopherson <seanjc@google.com>
    KVM: SVM: Use unsigned integers when dealing with ASIDs

Paul Barker <paul.barker.ct@bp.renesas.com>
    net: ravb: Always update error counters

Paul Barker <paul.barker.ct@bp.renesas.com>
    net: ravb: Always process TX descriptor ring

Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
    net: ravb: Let IP-specific receive function to interrogate descriptors

Guenter Roeck <linux@roeck-us.net>
    mean_and_variance: Drop always failing tests

Vitaly Lifshits <vitaly.lifshits@intel.com>
    e1000e: move force SMBUS from enable ulp function to avoid PHY loss issue

Vitaly Lifshits <vitaly.lifshits@intel.com>
    e1000e: Minor flow correction in e1000_shutdown function

Mario Limonciello <mario.limonciello@amd.com>
    drm/amd: Flush GFXOFF requests in prepare stage

Ivan Vecera <ivecera@redhat.com>
    i40e: Enforce software interrupt during busy-poll exit

Aleksandr Loktionov <aleksandr.loktionov@intel.com>
    i40e: fix vf may be used uninitialized in this function warning

Aleksandr Loktionov <aleksandr.loktionov@intel.com>
    i40e: fix i40e_count_filters() to count only active/new filters

Aleksandr Mishin <amishin@t-argos.ru>
    octeontx2-af: Add array index check

Su Hui <suhui@nfschina.com>
    octeontx2-pf: check negative error code in otx2_open()

Hariprasad Kelam <hkelam@marvell.com>
    octeontx2-af: Fix issue with loading coalesced KPU profiles

Antoine Tenart <atenart@kernel.org>
    udp: prevent local UDP tunnel packets from being GROed

Antoine Tenart <atenart@kernel.org>
    udp: do not transition UDP GRO fraglist partial checksums to unnecessary

Antoine Tenart <atenart@kernel.org>
    udp: do not accept non-tunnel GSO skbs landing in a tunnel

Atlas Yu <atlas.yu@canonical.com>
    r8169: skip DASH fw status checks when DASH is disabled

David Thompson <davthompson@nvidia.com>
    mlxbf_gige: stop interface during shutdown

Kuniyuki Iwashima <kuniyu@amazon.com>
    ipv6: Fix infinite recursion in fib6_dump_done().

Vitaly Lifshits <vitaly.lifshits@intel.com>
    e1000e: Workaround for sporadic MDI error on Meteor Lake systems

Duoming Zhou <duoming@zju.edu.cn>
    ax25: fix use-after-free bugs caused by ax25_ds_del_timer

Kuniyuki Iwashima <kuniyu@amazon.com>
    tcp: Fix bind() regression for v6-only wildcard and v4(-mapped-v6) non-wildcard addresses.

Jakub Kicinski <kuba@kernel.org>
    selftests: reuseaddr_conflict: add missing new line at the end of the output

Eric Dumazet <edumazet@google.com>
    erspan: make sure erspan_base_hdr is present in skb->head

Kuniyuki Iwashima <kuniyu@amazon.com>
    tcp: Fix bind() regression for v6-only wildcard and v4-mapped-v6 non-wildcard addresses.

Ivan Vecera <ivecera@redhat.com>
    i40e: Fix VF MAC filter removal

Petr Oros <poros@redhat.com>
    ice: fix enabling RX VLAN filtering

Joshua Hay <joshua.a.hay@intel.com>
    idpf: fix kernel panic on unknown packet types

Antoine Tenart <atenart@kernel.org>
    gro: fix ownership transfer

Antoine Tenart <atenart@kernel.org>
    selftests: net: gro fwd: update vxlan GRO test expectations

Michael Krummsdorf <michael.krummsdorf@tq-group.com>
    net: dsa: mv88e6xxx: fix usable ports on 88e6020

Aleksandr Mishin <amishin@t-argos.ru>
    net: phy: micrel: Fix potential null pointer dereference

Wei Fang <wei.fang@nxp.com>
    net: fec: Set mac_managed_pm during probe

Duanqiang Wen <duanqiangwen@net-swift.com>
    net: txgbe: fix i2c dev name cannot match clkdev

Horatiu Vultur <horatiu.vultur@microchip.com>
    net: phy: micrel: lan8814: Fix when enabling/disabling 1-step timestamping

Piotr Wejman <piotrwejman90@gmail.com>
    net: stmmac: fix rx queue priority assignment

Eric Dumazet <edumazet@google.com>
    net/sched: fix lockdep splat in qdisc_tree_reduce_backlog()

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    net: dsa: sja1105: Fix parameters order in sja1110_pcs_mdio_write_c45()

Eric Dumazet <edumazet@google.com>
    net/sched: act_skbmod: prevent kernel-infoleak

Will Deacon <will@kernel.org>
    KVM: arm64: Ensure target address is granule-aligned for range TLBI

Will Deacon <will@kernel.org>
    KVM: arm64: Use TLBI_TTL_UNKNOWN in __kvm_tlb_flush_vmid_range()

Borislav Petkov (AMD) <bp@alien8.de>
    x86/retpoline: Do the necessary fixup to the Zen3/4 srso return thunk for !SRSO

Paolo Abeni <pabeni@redhat.com>
    mptcp: prevent BPF accessing lowat from a subflow socket.

Jakub Sitnicki <jakub@cloudflare.com>
    bpf, sockmap: Prevent lock inversion deadlock in map delete elem

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    vboxsf: Avoid an spurious warning if load_nls_xxx() fails

Eric Dumazet <edumazet@google.com>
    netfilter: validate user input for expected length

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: discard table flag update with pending basechain deletion

Ziyang Xuan <william.xuanziyang@huawei.com>
    netfilter: nf_tables: Fix potential data-race in __nft_flowtable_type_get()

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: flush pending destroy work before exit_net release

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: reject new basechain after table flag update

Marco Pinna <marco.pinn95@gmail.com>
    vsock/virtio: fix packet delivery to tap device

Haiyang Zhang <haiyangz@microsoft.com>
    net: mana: Fix Rx DMA datasize and skb_over_panic

Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
    net: usb: ax88179_178a: avoid the interface always configured as random address

Mahmoud Adam <mngyadam@amazon.com>
    net/rds: fix possible cp null dereference

Jesper Dangaard Brouer <hawk@kernel.org>
    xen-netfront: Add missing skb_mark_for_recycle

Geliang Tang <tanggeliang@kylinos.cn>
    selftests: mptcp: join: fix dev in check_endpoint

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: release mutex after nft_gc_seq_end from abort path

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: release batch on table validation from abort path

Bastien Nocera <hadess@hadess.net>
    Bluetooth: Fix TOCTOU in HCI debugfs implementation

Hui Wang <hui.wang@canonical.com>
    Bluetooth: hci_event: set the conn encrypted before conn establishes

Johan Hovold <johan+linaro@kernel.org>
    Bluetooth: add quirk for broken address properties

Johan Hovold <johan+linaro@kernel.org>
    Bluetooth: qca: fix device-address endianness

Johan Hovold <johan+linaro@kernel.org>
    arm64: dts: qcom: sc7180-trogdor: mark bluetooth address as broken

Johan Hovold <johan+linaro@kernel.org>
    Revert "Bluetooth: hci_qca: Set BDA quirk bit if fwnode exists in DT"

Uros Bizjak <ubizjak@gmail.com>
    x86/bpf: Fix IP after emitting call depth accounting

Sean Christopherson <seanjc@google.com>
    x86/cpufeatures: Add CPUID_LNX_5 to track recently added Linux-defined word

Sandipan Das <sandipan.das@amd.com>
    x86/cpufeatures: Add new word for scattered features

Heiner Kallweit <hkallweit1@gmail.com>
    r8169: fix issue caused by buggy BIOS on certain boards with RTL8168d

Christian Göttsche <cgzones@googlemail.com>
    selinux: avoid dereference of garbage after mount failure

Wujie Duan <wjduan@linx-info.com>
    KVM: arm64: Fix out-of-IPA space translation fault handling

Oliver Upton <oliver.upton@linux.dev>
    KVM: arm64: Fix host-programmed guest events in nVHE

Anup Patel <apatel@ventanamicro.com>
    RISC-V: KVM: Fix APLIC in_clrip[x] read emulation

Anup Patel <apatel@ventanamicro.com>
    RISC-V: KVM: Fix APLIC setipnum_le/be write emulation

Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
    gpio: cdev: sanitize the label before requesting the interrupt

Ingo Molnar <mingo@kernel.org>
    Revert "x86/mm/ident_map: Use gbpages only where full GB page should be mapped."

Peter Xu <peterx@redhat.com>
    mm/treewide: replace pud_large() with pud_leaf()

Arnd Bergmann <arnd@arndb.de>
    kbuild: make -Woverride-init warnings more consistent

Masahiro Yamada <masahiroy@kernel.org>
    modpost: do not make find_tosym() return NULL

Arnd Bergmann <arnd@arndb.de>
    dm integrity: fix out-of-range warning

José Roberto de Souza <jose.souza@intel.com>
    drm/i915: Do not print 'pxp init failed with 0' when it succeed

Tejas Upadhyay <tejas.upadhyay@intel.com>
    drm/i915/mtl: Update workaround 14018575942

Matt Roper <matthew.d.roper@intel.com>
    drm/i915/xelpg: Extend some workarounds/tuning to gfx version 12.74

Juha-Pekka Heikkila <juhapekka.heikkila@gmail.com>
    drm/i915/display: Disable AuxCCS framebuffers if built for Xe

Ville Syrjälä <ville.syrjala@linux.intel.com>
    drm/i915: Stop doing double audio enable/disable on SDVO and g4x+ DP

Florian Westphal <fw@strlen.de>
    inet: inet_defrag: prevent sk release while still in use

Hariprasad Kelam <hkelam@marvell.com>
    Octeontx2-af: fix pause frame configuration in GMP mode

Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
    net: lan743x: Add set RFE read fifo threshold for PCI1x1x chips

Justin Chen <justin.chen@broadcom.com>
    net: bcmasp: Bring up unimac after PHY link up

Jason Gunthorpe <jgg@ziepe.ca>
    iommu: Validate the PASID in iommu_attach_device_pasid()

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: skip netdev hook unregistration if table is dormant

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: reject table flag and netdev basechain updates

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: reject destroy command to remove basechain hooks

David Howells <dhowells@redhat.com>
    cifs: Fix duplicate fscache cookie warnings

Andrei Matei <andreimatei1@gmail.com>
    bpf: Protect against int overflow for stack access size

Taimur Hassan <syed.hassan@amd.com>
    drm/amd/display: Send DTBCLK disable message on first commit

Charlene Liu <charlene.liu@amd.com>
    drm/amd/display: Update P010 scaling cap

David Thompson <davthompson@nvidia.com>
    mlxbf_gige: call request_irq() after NAPI initialized

Sabrina Dubroca <sd@queasysnail.net>
    tls: get psock ref after taking rxlock to avoid leak

Sabrina Dubroca <sd@queasysnail.net>
    tls: adjust recv return with async crypto and failed copy to userspace

Sabrina Dubroca <sd@queasysnail.net>
    tls: recv: process_rx_list shouldn't use an offset with kvec

Jian Shen <shenjian15@huawei.com>
    net: hns3: mark unexcuted loopback test result as UNEXECUTED

Yonglong Liu <liuyonglong@huawei.com>
    net: hns3: fix kernel crash when devlink reload during pf initialization

Jie Wang <wangjie125@huawei.com>
    net: hns3: fix index limit to support all queue stats

Nikita Kiryushin <kiryushin@ancud.ru>
    ACPICA: debugger: check status of acpi_evaluate_object() in acpi_db_walk_for_fields()

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    gpiolib: Fix debug messaging in gpiod_find_and_request()

Ido Schimmel <idosch@nvidia.com>
    selftests: vxlan_mdb: Fix failures with old libnet

Andy Yan <andy.yan@rock-chips.com>
    drm/rockchip: vop2: Remove AR30 and AB30 format support

Bjørn Mork <bjorn@mork.no>
    net: wwan: t7xx: Split 64bit accesses to fix alignment issues

Eric Dumazet <edumazet@google.com>
    tcp: properly terminate timers for kernel sockets

Ravi Gunasekaran <r-gunasekaran@ti.com>
    net: hsr: hsr_slave: Fix the promiscuous mode in offload mode

Alexandra Winter <wintera@linux.ibm.com>
    s390/qeth: handle deferred cc1

Prasad Pandit <pjp@fedoraproject.org>
    dpll: indent DPLL option type by a tab

Matthew Auld <matthew.auld@intel.com>
    drm/xe/device: fix XE_MAX_TILES_PER_DEVICE check

Matthew Auld <matthew.auld@intel.com>
    drm/xe/device: fix XE_MAX_GT_PER_TILE check

Matthew Auld <matthew.auld@intel.com>
    drm/xe/queue: fix engine_class bounds check

Matthew Auld <matthew.auld@intel.com>
    drm/xe/guc_submit: use jiffies for job timeout

Brian Welty <brian.welty@intel.com>
    drm/xe: Add exec_queue.sched_props.job_timeout_ms

Nirmoy Das <nirmoy.das@intel.com>
    drm/xe: Remove unused xe_bo->props struct

Kurt Kanzenbach <kurt@linutronix.de>
    igc: Remove stale comment about Tx timestamping

Przemek Kitszel <przemyslaw.kitszel@intel.com>
    ixgbe: avoid sleeping allocation in ixgbe_ipsec_vf_add_sa()

Jesse Brandeburg <jesse.brandeburg@intel.com>
    ice: fix memory corruption bug with suspend and rebuild

Steven Zou <steven.zou@intel.com>
    ice: Refactor FW data type and fix bitmap casting issue

Simon Trimmer <simont@opensource.cirrus.com>
    ALSA: hda: cs35l56: Set the init_done flag before component_add()

Benjamin Berg <benjamin.berg@intel.com>
    wifi: iwlwifi: mvm: include link ID when releasing frames

Johannes Berg <johannes.berg@intel.com>
    wifi: iwlwifi: mvm: rfi: fix potential response leaks

Emmanuel Grumbach <emmanuel.grumbach@intel.com>
    wifi: iwlwifi: mvm: pick the version of SESSION_PROTECTION_NOTIF

David Thompson <davthompson@nvidia.com>
    mlxbf_gige: stop PHY during open() error paths

Jakub Kicinski <kuba@kernel.org>
    tools: ynl: fix setting presence bits in simple nests

Jan Kara <jack@suse.cz>
    nfsd: Fix error cleanup path in nfsd_rename()

Ryosuke Yasuoka <ryasuoka@redhat.com>
    nfc: nci: Fix uninit-value in nci_dev_up and nci_ntf_packet

Artem Savkov <asavkov@redhat.com>
    arm64: bpf: fix 32bit unconditional bswap

Pavel Sakharov <p.sakharov@ispras.ru>
    dma-buf: Fix NULL pointer dereference in sanitycheck()

Puranjay Mohan <puranjay12@gmail.com>
    bpf, arm64: fix bug in BPF_LDX_MEMSX

Ilya Leoshkevich <iii@linux.ibm.com>
    s390/bpf: Fix bpf_plt pointer arithmetic

Stanislav Fomichev <sdf@google.com>
    xsk: Don't assume metadata is always requested in TX completion

Hangbin Liu <liuhangbin@gmail.com>
    scripts/bpf_doc: Use silent mode when exec make cmd


-------------

Diffstat:

 Documentation/admin-guide/hw-vuln/spectre.rst      |  48 ++++-
 Documentation/admin-guide/kernel-parameters.txt    |  12 ++
 Makefile                                           |   4 +-
 arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi       |   2 +
 arch/arm64/kernel/ptrace.c                         |   5 +-
 arch/arm64/kvm/hyp/nvhe/tlb.c                      |   3 +-
 arch/arm64/kvm/hyp/pgtable.c                       |  11 +-
 arch/arm64/kvm/hyp/vhe/tlb.c                       |   3 +-
 arch/arm64/kvm/mmu.c                               |   2 +-
 arch/arm64/net/bpf_jit_comp.c                      |   4 +-
 arch/powerpc/mm/book3s64/pgtable.c                 |   2 +-
 arch/riscv/include/asm/uaccess.h                   |   4 +-
 arch/riscv/include/uapi/asm/auxvec.h               |   2 +-
 arch/riscv/kernel/patch.c                          |   8 +
 arch/riscv/kernel/process.c                        |   5 +-
 arch/riscv/kernel/signal.c                         |  15 +-
 arch/riscv/kernel/traps.c                          |   2 +-
 arch/riscv/kernel/vdso/Makefile                    |   1 +
 arch/riscv/kvm/aia_aplic.c                         |  37 +++-
 arch/riscv/mm/tlbflush.c                           |   4 +-
 arch/s390/boot/vmem.c                              |   2 +-
 arch/s390/include/asm/pgtable.h                    |   4 +-
 arch/s390/kernel/entry.S                           |   1 +
 arch/s390/kernel/perf_pai_crypto.c                 |  10 +-
 arch/s390/kernel/perf_pai_ext.c                    |  10 +-
 arch/s390/mm/gmap.c                                |   2 +-
 arch/s390/mm/hugetlbpage.c                         |   4 +-
 arch/s390/mm/pageattr.c                            |   2 +-
 arch/s390/mm/pgtable.c                             |   2 +-
 arch/s390/mm/vmem.c                                |   6 +-
 arch/s390/net/bpf_jit_comp.c                       |  46 ++---
 arch/sparc/mm/init_64.c                            |   2 +-
 arch/x86/Kconfig                                   |  25 +++
 arch/x86/boot/compressed/Makefile                  |   2 +-
 arch/x86/boot/compressed/misc.c                    |  16 ++
 arch/x86/boot/compressed/sev.c                     |   3 +
 arch/x86/coco/core.c                               |  41 +++++
 arch/x86/entry/common.c                            |  10 +-
 arch/x86/entry/entry_64.S                          |  61 ++++++
 arch/x86/entry/entry_64_compat.S                   |  16 ++
 arch/x86/entry/syscall_32.c                        |  21 ++-
 arch/x86/entry/syscall_64.c                        |  19 +-
 arch/x86/entry/syscall_x32.c                       |  10 +-
 arch/x86/events/intel/ds.c                         |   8 +-
 arch/x86/include/asm/boot.h                        |   1 +
 arch/x86/include/asm/coco.h                        |   2 +
 arch/x86/include/asm/cpufeature.h                  |   8 +-
 arch/x86/include/asm/cpufeatures.h                 |  14 +-
 arch/x86/include/asm/disabled-features.h           |   3 +-
 arch/x86/include/asm/mem_encrypt.h                 |   8 +-
 arch/x86/include/asm/msr-index.h                   |   9 +-
 arch/x86/include/asm/nospec-branch.h               |  17 ++
 arch/x86/include/asm/required-features.h           |   3 +-
 arch/x86/include/asm/sev.h                         |  10 +-
 arch/x86/include/asm/syscall.h                     |  11 +-
 arch/x86/include/uapi/asm/bootparam.h              |   1 +
 arch/x86/kernel/cpu/bugs.c                         | 121 ++++++++++--
 arch/x86/kernel/cpu/common.c                       |  24 ++-
 arch/x86/kernel/cpu/mce/core.c                     |   4 +-
 arch/x86/kernel/cpu/scattered.c                    |   1 +
 arch/x86/kernel/mpparse.c                          |  10 +-
 arch/x86/kernel/setup.c                            |   2 +
 arch/x86/kernel/sev-shared.c                       |  23 +--
 arch/x86/kernel/sev.c                              |  14 +-
 arch/x86/kvm/mmu/mmu.c                             |   2 +-
 arch/x86/kvm/reverse_cpuid.h                       |   5 +-
 arch/x86/kvm/svm/sev.c                             |  45 +++--
 arch/x86/kvm/trace.h                               |  10 +-
 arch/x86/kvm/vmx/vmenter.S                         |   2 +
 arch/x86/kvm/x86.c                                 |   2 +-
 arch/x86/lib/Makefile                              |  13 --
 arch/x86/lib/retpoline.S                           |   6 +-
 arch/x86/mm/fault.c                                |   4 +-
 arch/x86/mm/ident_map.c                            |  23 +--
 arch/x86/mm/init_64.c                              |   4 +-
 arch/x86/mm/kasan_init_64.c                        |   2 +-
 arch/x86/mm/mem_encrypt_identity.c                 |  76 +++-----
 arch/x86/mm/pat/memtype.c                          |  49 +++--
 arch/x86/mm/pat/set_memory.c                       |   6 +-
 arch/x86/mm/pgtable.c                              |   2 +-
 arch/x86/mm/pti.c                                  |   2 +-
 arch/x86/net/bpf_jit_comp.c                        |   2 +-
 arch/x86/power/hibernate.c                         |   2 +-
 arch/x86/xen/mmu_pv.c                              |   4 +-
 block/bdev.c                                       |   6 +-
 drivers/acpi/acpica/dbnames.c                      |   8 +-
 drivers/ata/sata_mv.c                              |  63 ++++---
 drivers/ata/sata_sx4.c                             |   6 +-
 drivers/base/core.c                                |  26 ++-
 drivers/base/regmap/regcache-maple.c               |   6 +-
 drivers/bluetooth/btqca.c                          |   8 +-
 drivers/bluetooth/hci_qca.c                        |  19 +-
 drivers/dma-buf/st-dma-fence-chain.c               |   6 +-
 drivers/dpll/Kconfig                               |   2 +-
 drivers/firmware/efi/libstub/efi-stub-helper.c     |   8 +
 drivers/firmware/efi/libstub/efistub.h             |   2 +-
 drivers/firmware/efi/libstub/x86-stub.c            |  14 +-
 drivers/gpio/gpiolib-cdev.c                        |  58 +++++-
 drivers/gpio/gpiolib.c                             |  31 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |   2 +
 .../amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c   |  25 ++-
 drivers/gpu/drm/amd/display/dc/dce110/Makefile     |   2 +-
 drivers/gpu/drm/amd/display/dc/dce112/Makefile     |   2 +-
 drivers/gpu/drm/amd/display/dc/dce120/Makefile     |   2 +-
 drivers/gpu/drm/amd/display/dc/dce60/Makefile      |   2 +-
 drivers/gpu/drm/amd/display/dc/dce80/Makefile      |   2 +-
 .../amd/display/dc/resource/dcn35/dcn35_resource.c |   2 +-
 drivers/gpu/drm/drm_prime.c                        |   7 +-
 drivers/gpu/drm/i915/Makefile                      |   7 +-
 drivers/gpu/drm/i915/display/g4x_dp.c              |   2 -
 .../gpu/drm/i915/display/intel_display_device.h    |   1 +
 drivers/gpu/drm/i915/display/intel_dp.c            |   9 +-
 drivers/gpu/drm/i915/display/intel_dp_mst.c        |   2 +-
 drivers/gpu/drm/i915/display/intel_sdvo.c          |   4 -
 drivers/gpu/drm/i915/display/skl_universal_plane.c |   3 +
 drivers/gpu/drm/i915/gt/gen8_engine_cs.c           |   4 +-
 drivers/gpu/drm/i915/gt/gen8_ppgtt.c               |   3 +
 drivers/gpu/drm/i915/gt/intel_engine_cs.c          |  17 ++
 drivers/gpu/drm/i915/gt/intel_gt.c                 |   6 +
 drivers/gpu/drm/i915/gt/intel_gt.h                 |   9 +-
 drivers/gpu/drm/i915/gt/intel_gt_ccs_mode.c        |  39 ++++
 drivers/gpu/drm/i915/gt/intel_gt_ccs_mode.h        |  13 ++
 drivers/gpu/drm/i915/gt/intel_gt_regs.h            |   6 +
 drivers/gpu/drm/i915/gt/intel_workarounds.c        |  55 ++++--
 drivers/gpu/drm/i915/i915_driver.c                 |   2 +-
 drivers/gpu/drm/i915/i915_perf.c                   |   2 +-
 drivers/gpu/drm/nouveau/nouveau_uvmm.c             |   6 +-
 drivers/gpu/drm/panfrost/panfrost_gpu.c            |   6 +-
 drivers/gpu/drm/rockchip/rockchip_vop2_reg.c       |   2 -
 drivers/gpu/drm/xe/Makefile                        |   4 +-
 drivers/gpu/drm/xe/xe_bo.c                         |  59 +-----
 drivers/gpu/drm/xe/xe_bo_types.h                   |  19 --
 drivers/gpu/drm/xe/xe_device.h                     |   4 +-
 drivers/gpu/drm/xe/xe_exec.c                       |  31 +---
 drivers/gpu/drm/xe/xe_exec_queue.c                 |   4 +-
 drivers/gpu/drm/xe/xe_exec_queue_types.h           |   7 +
 drivers/gpu/drm/xe/xe_guc_submit.c                 |   2 +-
 drivers/gpu/drm/xe/xe_pt.c                         |   8 +-
 drivers/gpu/drm/xe/xe_ring_ops.c                   |  11 +-
 drivers/gpu/drm/xe/xe_sched_job.c                  |  10 +
 drivers/gpu/drm/xe/xe_sched_job_types.h            |   2 +
 drivers/gpu/drm/xe/xe_vm.c                         |  27 +--
 drivers/gpu/drm/xe/xe_vm.h                         |   2 +-
 drivers/gpu/drm/xe/xe_vm_types.h                   |   8 +-
 drivers/iommu/iommu.c                              |  11 +-
 drivers/md/dm-integrity.c                          |   2 +-
 drivers/net/dsa/mv88e6xxx/chip.c                   |   6 +-
 drivers/net/dsa/sja1105/sja1105_mdio.c             |   2 +-
 drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c   |  28 ++-
 drivers/net/ethernet/freescale/fec_main.c          |  11 +-
 .../hns3/hns3_common/hclge_comm_tqp_stats.c        |   2 +-
 drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c |  19 +-
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    |   4 +
 drivers/net/ethernet/intel/e1000e/hw.h             |   2 +
 drivers/net/ethernet/intel/e1000e/ich8lan.c        |  38 ++--
 drivers/net/ethernet/intel/e1000e/netdev.c         |  24 ++-
 drivers/net/ethernet/intel/e1000e/phy.c            | 184 +++++++++++-------
 drivers/net/ethernet/intel/e1000e/phy.h            |   2 +
 drivers/net/ethernet/intel/i40e/i40e.h             |   1 +
 drivers/net/ethernet/intel/i40e/i40e_main.c        |  13 +-
 drivers/net/ethernet/intel/i40e/i40e_register.h    |   3 +
 drivers/net/ethernet/intel/i40e/i40e_txrx.c        |  82 ++++++---
 drivers/net/ethernet/intel/i40e/i40e_txrx.h        |   1 +
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |  45 +++--
 drivers/net/ethernet/intel/ice/ice_adminq_cmd.h    |   3 +-
 drivers/net/ethernet/intel/ice/ice_lag.c           |   4 +-
 drivers/net/ethernet/intel/ice/ice_lib.c           |  18 +-
 drivers/net/ethernet/intel/ice/ice_switch.c        |  24 ++-
 drivers/net/ethernet/intel/ice/ice_switch.h        |   4 +-
 .../net/ethernet/intel/ice/ice_vf_vsi_vlan_ops.c   |  18 +-
 drivers/net/ethernet/intel/idpf/idpf_txrx.c        |   4 +-
 drivers/net/ethernet/intel/igc/igc_main.c          |   4 -
 drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c     |  16 +-
 drivers/net/ethernet/marvell/octeontx2/af/cgx.c    |   5 +
 .../net/ethernet/marvell/octeontx2/af/rvu_cgx.c    |   2 +
 .../net/ethernet/marvell/octeontx2/af/rvu_npc.c    |   2 +-
 .../net/ethernet/marvell/octeontx2/nic/otx2_pf.c   |   2 +-
 .../ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c |  31 +++-
 drivers/net/ethernet/microchip/lan743x_main.c      |  18 ++
 drivers/net/ethernet/microchip/lan743x_main.h      |   4 +
 drivers/net/ethernet/microsoft/mana/mana_en.c      |   2 +-
 drivers/net/ethernet/realtek/r8169_main.c          |  40 +++-
 drivers/net/ethernet/renesas/ravb_main.c           |  33 ++--
 drivers/net/ethernet/renesas/sh_eth.c              |   2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c  |  40 +++-
 .../net/ethernet/stmicro/stmmac/dwxgmac2_core.c    |  38 +++-
 drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c     |   8 +-
 drivers/net/phy/micrel.c                           |  31 +++-
 drivers/net/usb/ax88179_178a.c                     |   2 +
 drivers/net/wireless/intel/iwlwifi/mvm/rfi.c       |   8 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c      |  20 +-
 .../net/wireless/intel/iwlwifi/mvm/time-event.c    |   5 +-
 drivers/net/wwan/t7xx/t7xx_cldma.c                 |   4 +-
 drivers/net/wwan/t7xx/t7xx_hif_cldma.c             |   9 +-
 drivers/net/wwan/t7xx/t7xx_pcie_mac.c              |   8 +-
 drivers/net/xen-netfront.c                         |   1 +
 drivers/of/dynamic.c                               |  12 ++
 drivers/of/module.c                                |   8 +
 drivers/perf/riscv_pmu.c                           |   4 +
 drivers/pinctrl/aspeed/Makefile                    |   2 +-
 drivers/s390/net/qeth_core_main.c                  |  38 +++-
 drivers/scsi/myrb.c                                |  20 +-
 drivers/scsi/myrs.c                                |  24 +--
 drivers/scsi/sd.c                                  |   2 +-
 drivers/spi/spi-pci1xxxx.c                         |   2 +
 drivers/spi/spi-s3c64xx.c                          |  80 +++++---
 drivers/thermal/gov_power_allocator.c              |  14 +-
 fs/aio.c                                           |   2 +-
 fs/bcachefs/mean_and_variance_test.c               |  28 +--
 fs/nfsd/nfs4state.c                                |   7 +-
 fs/nfsd/vfs.c                                      |   3 +-
 fs/proc/Makefile                                   |   2 +-
 fs/smb/client/cached_dir.c                         |   6 +-
 fs/smb/client/cifs_debug.c                         |   6 +
 fs/smb/client/cifsfs.c                             |  11 ++
 fs/smb/client/cifsglob.h                           |  19 +-
 fs/smb/client/cifsproto.h                          |  20 +-
 fs/smb/client/connect.c                            | 157 ++++++++++------
 fs/smb/client/dfs.c                                |  51 +++--
 fs/smb/client/dfs.h                                |  33 ++--
 fs/smb/client/dfs_cache.c                          |  53 +++---
 fs/smb/client/dir.c                                |  15 ++
 fs/smb/client/file.c                               | 111 +++++++++--
 fs/smb/client/fs_context.c                         |   6 +-
 fs/smb/client/fs_context.h                         |  12 ++
 fs/smb/client/fscache.c                            |  16 +-
 fs/smb/client/fscache.h                            |   6 +
 fs/smb/client/inode.c                              |   2 +
 fs/smb/client/ioctl.c                              |   6 +-
 fs/smb/client/misc.c                               |   8 +-
 fs/smb/client/smb1ops.c                            |   4 +-
 fs/smb/client/smb2misc.c                           |   4 +
 fs/smb/client/smb2ops.c                            |  11 +-
 fs/smb/client/smb2pdu.c                            |   2 +-
 fs/smb/server/ksmbd_netlink.h                      |   3 +-
 fs/smb/server/mgmt/share_config.c                  |   7 +-
 fs/smb/server/smb2ops.c                            |  10 +-
 fs/smb/server/smb2pdu.c                            |   3 +-
 fs/smb/server/transport_ipc.c                      |  37 ++++
 fs/vboxsf/super.c                                  |   3 +-
 include/kvm/arm_pmu.h                              |   2 +-
 include/linux/bpf.h                                |  16 +-
 include/linux/device.h                             |   1 +
 include/linux/io_uring_types.h                     |   1 -
 include/linux/secretmem.h                          |   4 +-
 include/linux/skbuff.h                             |   7 +-
 include/linux/stackdepot.h                         |  46 +++++
 include/linux/udp.h                                |  28 +++
 include/net/bluetooth/hci.h                        |   9 +
 include/net/inet_connection_sock.h                 |   1 +
 include/net/mana/mana.h                            |   1 -
 include/net/sock.h                                 |   7 +
 include/net/xdp_sock.h                             |   2 +
 include/sound/hdaudio_ext.h                        |   3 +
 io_uring/io_uring.c                                |  18 +-
 io_uring/kbuf.c                                    | 116 ++++--------
 io_uring/kbuf.h                                    |   8 +-
 io_uring/rw.c                                      |   9 +-
 kernel/bpf/Makefile                                |   2 +-
 kernel/bpf/syscall.c                               |  35 +++-
 kernel/bpf/verifier.c                              |   5 +
 kernel/trace/bpf_trace.c                           |  10 +-
 lib/stackdepot.c                                   |  47 +----
 mm/Makefile                                        |   3 +-
 mm/memory.c                                        |   4 +
 net/9p/client.c                                    |  10 +-
 net/ax25/ax25_dev.c                                |   2 +-
 net/bluetooth/hci_debugfs.c                        |  64 ++++---
 net/bluetooth/hci_event.c                          |  25 +++
 net/bluetooth/hci_sync.c                           |   5 +-
 net/bridge/netfilter/ebtables.c                    |   6 +
 net/core/gro.c                                     |   3 +-
 net/core/sock_map.c                                |   6 +
 net/hsr/hsr_slave.c                                |   3 +-
 net/ipv4/inet_connection_sock.c                    |  44 ++++-
 net/ipv4/inet_fragment.c                           |  70 +++++--
 net/ipv4/ip_fragment.c                             |   2 +-
 net/ipv4/ip_gre.c                                  |   5 +
 net/ipv4/netfilter/arp_tables.c                    |   4 +
 net/ipv4/netfilter/ip_tables.c                     |   4 +
 net/ipv4/tcp.c                                     |   2 +
 net/ipv4/udp.c                                     |   7 +
 net/ipv4/udp_offload.c                             |  23 ++-
 net/ipv6/ip6_fib.c                                 |  14 +-
 net/ipv6/ip6_gre.c                                 |   3 +
 net/ipv6/netfilter/ip6_tables.c                    |   4 +
 net/ipv6/netfilter/nf_conntrack_reasm.c            |   2 +-
 net/ipv6/udp.c                                     |   2 +-
 net/ipv6/udp_offload.c                             |   8 +-
 net/mptcp/protocol.c                               |   2 -
 net/mptcp/sockopt.c                                |   4 +
 net/mptcp/subflow.c                                |   2 +
 net/netfilter/nf_tables_api.c                      |  92 +++++++--
 net/nfc/nci/core.c                                 |   5 +
 net/rds/rdma.c                                     |   2 +-
 net/sched/act_skbmod.c                             |  10 +-
 net/sched/sch_api.c                                |   2 +-
 net/sunrpc/svcsock.c                               |  10 +-
 net/tls/tls_sw.c                                   |   7 +-
 net/vmw_vsock/virtio_transport.c                   |   3 +-
 scripts/Makefile.extrawarn                         |  10 +-
 scripts/bpf_doc.py                                 |   4 +-
 scripts/mod/modpost.c                              |   7 +-
 security/selinux/selinuxfs.c                       |  12 +-
 sound/pci/emu10k1/emu10k1_callback.c               |   7 +-
 sound/pci/hda/cs35l41_hda_property.c               |   6 +
 sound/pci/hda/cs35l56_hda.c                        |   4 +-
 sound/pci/hda/cs35l56_hda_i2c.c                    |  13 +-
 sound/pci/hda/cs35l56_hda_spi.c                    |  13 +-
 sound/pci/hda/patch_realtek.c                      |   7 +-
 sound/soc/amd/acp/acp-pci.c                        |  13 +-
 sound/soc/codecs/cs42l43.c                         |  12 +-
 sound/soc/codecs/rt5682-sdw.c                      |   4 +-
 sound/soc/codecs/rt711-sdca-sdw.c                  |   4 +-
 sound/soc/codecs/rt711-sdw.c                       |   4 +-
 sound/soc/codecs/rt712-sdca-sdw.c                  |   5 +-
 sound/soc/codecs/rt722-sdca-sdw.c                  |   4 +-
 sound/soc/codecs/wm_adsp.c                         |   3 +-
 sound/soc/soc-ops.c                                |   2 +-
 sound/soc/sof/amd/acp.c                            |   8 +-
 sound/soc/sof/intel/hda-common-ops.c               |   3 +
 sound/soc/sof/intel/hda-dai-ops.c                  |  11 ++
 sound/soc/sof/intel/hda-pcm.c                      |  29 +++
 sound/soc/sof/intel/hda-stream.c                   |  70 +++++++
 sound/soc/sof/intel/hda.h                          |   6 +
 sound/soc/sof/intel/lnl.c                          |   2 -
 sound/soc/sof/intel/mtl.c                          |  14 --
 sound/soc/sof/intel/mtl.h                          |  10 -
 sound/soc/sof/ipc4-pcm.c                           | 193 +++++++++++++++----
 sound/soc/sof/ipc4-priv.h                          |  14 --
 sound/soc/sof/ipc4-topology.c                      |  22 ++-
 sound/soc/sof/ops.h                                |  24 ++-
 sound/soc/sof/pcm.c                                |   8 +
 sound/soc/sof/sof-audio.h                          |   9 +-
 sound/soc/sof/sof-priv.h                           |  24 ++-
 tools/net/ynl/ynl-gen-c.py                         |   7 +-
 tools/testing/selftests/mm/vm_util.h               |   2 +-
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 134 ++++++++------
 tools/testing/selftests/net/mptcp/mptcp_join.sh    |  34 ++--
 tools/testing/selftests/net/reuseaddr_conflict.c   |   2 +-
 tools/testing/selftests/net/test_vxlan_mdb.sh      | 205 +++++++++++++--------
 tools/testing/selftests/net/udpgro_fwd.sh          |  10 +-
 342 files changed, 3587 insertions(+), 1739 deletions(-)



