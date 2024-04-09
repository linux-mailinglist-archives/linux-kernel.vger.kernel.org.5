Return-Path: <linux-kernel+bounces-137306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97AAF89E06B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 18:31:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D788B2C940
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 16:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2690B13DDAD;
	Tue,  9 Apr 2024 16:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=hardfalcon.net header.i=@hardfalcon.net header.b="3W8F8xLo"
Received: from 0.smtp.remotehost.it (0.smtp.remotehost.it [213.190.28.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F4513D8BD;
	Tue,  9 Apr 2024 16:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.190.28.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712679522; cv=none; b=UQKdbVlbXOrXZCn9be2uJtk23GlPszXfav4PF18PLylyBDyDtz1I9G3sdC/Yq0RRGVmQl5vpVd99O13sLFCp0IZLHa3Qs5QlhukxC93KUEgIhiWCW0Uqlw9QW0nMzfL+D9nVMFm7WhX3nBbDKmUOVU9oan0xVmu2t3XWA+500pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712679522; c=relaxed/simple;
	bh=Uu6e1cCzKdI2QExRiM34Zcroy4QPn+nZ88gVIJb3CrM=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=M+FP7vL7hyN2ceWJ9p18/XelDxf1z5I0dPRw/T15p65C7E0qd2FJqD8+s4cEsCjqRqTvHWgqXnQhOmuVejO+ge7A4LuPmehdbt1ZbomnpErwm9jpq1J6dgiW/1e91czanag9ky5jSq+Az9TvEM6cN87Hwvcphl/+bJHKVjpyOLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hardfalcon.net; spf=pass smtp.mailfrom=hardfalcon.net; dkim=permerror (0-bit key) header.d=hardfalcon.net header.i=@hardfalcon.net header.b=3W8F8xLo; arc=none smtp.client-ip=213.190.28.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hardfalcon.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hardfalcon.net
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=hardfalcon.net;
	s=dkim_2024-02-03; t=1712679507;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6cCf8vtc+R9SyWkYfbTLwYvKtOFCg101xlHkj2xGY4A=;
	b=3W8F8xLo1RTQbjpxKAhblb8oPFQSJs3Ws3QdaLSwXa2/4u4q5EIAb9ucjseI0le4NRxKST
	ENJbHflrakcrZtAQ==
Content-Type: multipart/mixed; boundary="------------HlDbtagZu4zoMt7iuC50CuDk"
Message-ID: <fd186a2b-0c62-4942-bed3-a27d72930310@hardfalcon.net>
Date: Tue, 9 Apr 2024 18:18:21 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 6.8 000/273] 6.8.5-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240408125309.280181634@linuxfoundation.org>
 <09b7807c-c0e7-49be-9de3-e41b7dbc6140@hardfalcon.net>
Content-Language: en-US
From: Pascal Ernster <git@hardfalcon.net>
In-Reply-To: <09b7807c-c0e7-49be-9de3-e41b7dbc6140@hardfalcon.net>

This is a multi-part message in MIME format.
--------------HlDbtagZu4zoMt7iuC50CuDk
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

[2024-04-09 07:03] Pascal Ernster:
> [2024-04-08 14:54] Greg Kroah-Hartman:
>> This is the start of the stable review cycle for the 6.8.5 release.
>> There are 273 patches in this series, all will be posted as a response
>> to this one.  If anyone has any issues with these being applied, please
>> let me know.
>>
>> Responses should be made by Wed, 10 Apr 2024 12:52:23 +0000.
>> Anything received after that time might be too late.
>>
>> The whole patch series can be found in one patch at:
>>     https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.8.5-rc1.gz
>> or in the git tree and branch at:
>>     git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.8.y
>> and the diffstat can be found below.
>>
>> thanks,
>>
>> greg k-h
>>
>> -------------
>> Pseudo-Shortlog of commits:
>>
>> Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>      Linux 6.8.5-rc1
>>
>> Ard Biesheuvel <ardb@kernel.org>
>>      x86/efistub: Remap kernel text read-only before dropping NX 
>> attribute
>>
>> Ard Biesheuvel <ardb@kernel.org>
>>      x86/sev: Move early startup code into .head.text section
>>
>> Ard Biesheuvel <ardb@kernel.org>
>>      x86/sme: Move early SME kernel encryption handling into .head.text
>>
>> Ard Biesheuvel <ardb@kernel.org>
>>      x86/boot: Move mem_encrypt= parsing to the decompressor
>>
>> Ard Biesheuvel <ardb@kernel.org>
>>      efi/libstub: Add generic support for parsing mem_encrypt=
>>
>> Andrii Nakryiko <andrii@kernel.org>
>>      bpf: support deferring bpf_link dealloc to after RCU grace period
>>
>> Andrii Nakryiko <andrii@kernel.org>
>>      bpf: put uprobe link's path and task in release callback
>>
>> Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>      Revert "x86/mpparse: Register APIC address only once"
>>
>> Thomas Hellström <thomas.hellstrom@linux.intel.com>
>>      drm/xe: Rework rebinding
>>
>> Thomas Hellström <thomas.hellstrom@linux.intel.com>
>>      drm/xe: Use ring ops TLB invalidation for rebinds
>>
>> Andi Shyti <andi.shyti@linux.intel.com>
>>      drm/i915/gt: Enable only one CCS for compute workload
>>
>> Andi Shyti <andi.shyti@linux.intel.com>
>>      drm/i915/gt: Do not generate the command streamer for all the CCS
>>
>> Andi Shyti <andi.shyti@linux.intel.com>
>>      drm/i915/gt: Disable HW load balancing for CCS
>>
>> Ankit Nautiyal <ankit.k.nautiyal@intel.com>
>>      drm/i915/dp: Fix the computation for compressed_bpp for DISPLAY < 13
>>
>> Ville Syrjälä <ville.syrjala@linux.intel.com>
>>      drm/i915/mst: Reject FEC+MST on ICL
>>
>> Ville Syrjälä <ville.syrjala@linux.intel.com>
>>      drm/i915/mst: Limit MST+DSC to TGL+
>>
>> Paulo Alcantara <pc@manguebit.com>
>>      smb: client: fix potential UAF in cifs_signal_cifsd_for_reconnect()
>>
>> Paulo Alcantara <pc@manguebit.com>
>>      smb: client: fix potential UAF in smb2_is_network_name_deleted()
>>
>> Paulo Alcantara <pc@manguebit.com>
>>      smb: client: fix potential UAF in is_valid_oplock_break()
>>
>> Paulo Alcantara <pc@manguebit.com>
>>      smb: client: fix potential UAF in smb2_is_valid_lease_break()
>>
>> Paulo Alcantara <pc@manguebit.com>
>>      smb: client: fix potential UAF in smb2_is_valid_oplock_break()
>>
>> Paulo Alcantara <pc@manguebit.com>
>>      smb: client: fix potential UAF in cifs_dump_full_key()
>>
>> Paulo Alcantara <pc@manguebit.com>
>>      smb: client: fix potential UAF in cifs_stats_proc_show()
>>
>> Paulo Alcantara <pc@manguebit.com>
>>      smb: client: fix potential UAF in cifs_stats_proc_write()
>>
>> Paulo Alcantara <pc@manguebit.com>
>>      smb: client: fix potential UAF in cifs_debug_files_proc_show()
>>
>> Ritvik Budhiraja <rbudhiraja@microsoft.com>
>>      smb3: retrying on failed server close
>>
>> Paulo Alcantara <pc@manguebit.com>
>>      smb: client: serialise cifs_construct_tcon() with cifs_mount_mutex
>>
>> Paulo Alcantara <pc@manguebit.com>
>>      smb: client: handle DFS tcons in cifs_construct_tcon()
>>
>> Paulo Alcantara <pc@manguebit.com>
>>      smb: client: refresh referral without acquiring refpath_lock
>>
>> Paulo Alcantara <pc@manguebit.com>
>>      smb: client: guarantee refcounted children from parent session
>>
>> Paulo Alcantara <pc@manguebit.com>
>>      smb: client: fix UAF in smb2_reconnect_server()
>>
>> Stefan O'Rear <sorear@fastmail.com>
>>      riscv: process: Fix kernel gp leakage
>>
>> Samuel Holland <samuel.holland@sifive.com>
>>      riscv: Fix spurious errors from __get/put_kernel_nofault
>>
>> Sumanth Korikkar <sumanthk@linux.ibm.com>
>>      s390/entry: align system call table on 8 bytes
>>
>> Edward Liaw <edliaw@google.com>
>>      selftests/mm: include strings.h for ffsl
>>
>> David Hildenbrand <david@redhat.com>
>>      mm/secretmem: fix GUP-fast succeeding on secretmem folios
>>
>> Mark Brown <broonie@kernel.org>
>>      arm64/ptrace: Use saved floating point state type to determine 
>> SVE layout
>>
>> Björn Töpel <bjorn@rivosinc.com>
>>      riscv: Fix vector state restore in rt_sigreturn()
>>
>> Kent Overstreet <kent.overstreet@linux.dev>
>>      aio: Fix null ptr deref in aio_complete() wakeup
>>
>> Kan Liang <kan.liang@linux.intel.com>
>>      perf/x86/intel/ds: Don't clear ->pebs_data_cfg for the last PEBS 
>> event
>>
>> Jason A. Donenfeld <Jason@zx2c4.com>
>>      x86/coco: Require seeding RNG with RDRAND on CoCo systems
>>
>> Borislav Petkov (AMD) <bp@alien8.de>
>>      x86/mce: Make sure to grab mce_sysfs_mutex in set_bank()
>>
>> David Hildenbrand <david@redhat.com>
>>      x86/mm/pat: fix VM_PAT handling in COW mappings
>>
>> Sergey Shtylyov <s.shtylyov@omp.ru>
>>      of: module: prevent NULL pointer dereference in vsnprintf()
>>
>> Herve Codina <herve.codina@bootlin.com>
>>      of: dynamic: Synchronize of_changeset_destroy() with the devlink 
>> removals
>>
>> Herve Codina <herve.codina@bootlin.com>
>>      driver core: Introduce device_link_wait_removal()
>>
>> Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
>>      ASoC: SOF: Intel: hda: Compensate LLP in case it is not reset
>>
>> Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
>>      ASoC: SOF: ipc4-pcm: Correct the delay calculation
>>
>> Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
>>      ASoC: SOF: sof-pcm: Add pointer callback to sof_ipc_pcm_ops
>>
>> Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
>>      ASoC: SOF: ipc4-pcm: Invalidate the stream_start_offset in PAUSED 
>> state
>>
>> Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
>>      ASoC: SOF: ipc4-pcm: Combine the SOF_IPC4_PIPE_PAUSED cases in 
>> pcm_trigger
>>
>> Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
>>      ASoC: SOF: ipc4-pcm: Move struct sof_ipc4_timestamp_info 
>> definition locally
>>
>> Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
>>      ASoC: SOF: Remove the get_stream_position callback
>>
>> Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
>>      ASoC: SOF: ipc4-pcm: Use the snd_sof_pcm_get_dai_frame_counter() 
>> for pcm_delay
>>
>> Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
>>      ASoC: SOF: Intel: hda-common-ops: Do not set the 
>> get_stream_position callback
>>
>> Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
>>      ASoC: SOF: Intel: Set the dai/host get frame/byte counter callbacks
>>
>> Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
>>      ASoC: SOF: Introduce a new callback pair to be used for PCM delay 
>> reporting
>>
>> Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
>>      ASoC: SOF: Intel: mtl/lnl: Use the generic get_stream_position 
>> callback
>>
>> Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
>>      ASoC: SOF: Intel: hda: Implement get_stream_position (Linear Link 
>> Position)
>>
>> Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
>>      ASoC: SOF: Intel: hda-pcm: Use dsp_max_burst_size_in_ms to place 
>> constraint
>>
>> Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
>>      ASoC: SOF: ipc4-topology: Save the DMA maximum burst size for PCMs
>>
>> Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
>>      ASoC: SOF: Add dsp_max_burst_size_in_ms member to snd_sof_pcm_stream
>>
>> Jens Axboe <axboe@kernel.dk>
>>      io_uring/kbuf: hold io_buffer_list reference over mmap
>>
>> Jens Axboe <axboe@kernel.dk>
>>      io_uring: use private workqueue for exit work
>>
>> Jens Axboe <axboe@kernel.dk>
>>      io_uring/rw: don't allow multishot reads without NOWAIT support
>>
>> Jens Axboe <axboe@kernel.dk>
>>      io_uring/kbuf: protect io_buffer_list teardown with a reference
>>
>> Jens Axboe <axboe@kernel.dk>
>>      io_uring/kbuf: get rid of bl->is_ready
>>
>> Jens Axboe <axboe@kernel.dk>
>>      io_uring/kbuf: get rid of lower BGID lists
>>
>> I Gede Agastya Darma Laksana <gedeagas22@gmail.com>
>>      ALSA: hda/realtek: Update Panasonic CF-SZ6 quirk to support 
>> headset with microphone
>>
>> Luke D. Jones <luke@ljones.dev>
>>      ALSA: hda/realtek: cs35l41: Support ASUS ROG G634JYR
>>
>> Christian Bendiksen <christian@bendiksen.me>
>>      ALSA: hda/realtek: Add sound quirks for Lenovo Legion slim 7 
>> 16ARHA7 models
>>
>> Christoffer Sandberg <cs@tuxedo.de>
>>      ALSA: hda/realtek - Fix inactive headset mic jack
>>
>> Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
>>      ALSA: hda: Add pplcllpl/u members to hdac_ext_stream
>>
>> Namjae Jeon <linkinjeon@kernel.org>
>>      ksmbd: do not set SMB2_GLOBAL_CAP_ENCRYPTION for SMB 3.1.1
>>
>> Namjae Jeon <linkinjeon@kernel.org>
>>      ksmbd: validate payload size in ipc response
>>
>> Namjae Jeon <linkinjeon@kernel.org>
>>      ksmbd: don't send oplock break if rename fails
>>
>> Kent Gibson <warthog618@gmail.com>
>>      gpio: cdev: fix missed label sanitizing in debounce_setup()
>>
>> Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>      gpio: cdev: check for NULL labels when sanitizing them for irqs
>>
>> Gabe Teeger <gabe.teeger@amd.com>
>>      Revert "drm/amd/display: Send DTBCLK disable message on first 
>> commit"
>>
>> Borislav Petkov (AMD) <bp@alien8.de>
>>      x86/retpoline: Add NOENDBR annotation to the SRSO dummy return thunk
>>
>> Peter Collingbourne <pcc@google.com>
>>      stackdepot: rename pool_index to pool_index_plus_1
>>
>> Oscar Salvador <osalvador@suse.de>
>>      lib/stackdepot: move stack_record struct definition into the header
>>
>> Jeff Layton <jlayton@kernel.org>
>>      nfsd: hold a lighter-weight client reference over CB_RECALL_ANY
>>
>> Alexandre Ghiti <alexghiti@rivosinc.com>
>>      riscv: Disable preemption when using patch_map()
>>
>> Alexandre Ghiti <alexghiti@rivosinc.com>
>>      riscv: Fix warning by declaring arch_cpu_idle() as noinstr
>>
>> Andreas Schwab <schwab@suse.de>
>>      riscv: use KERN_INFO in do_trap
>>
>> Chuck Lever <chuck.lever@oracle.com>
>>      SUNRPC: Fix a slow server-side memory leak with RPC-over-TCP
>>
>> Vijendar Mukunda <Vijendar.Mukunda@amd.com>
>>      ASoC: SOF: amd: fix for false dsp interrupts
>>
>> Arnd Bergmann <arnd@arndb.de>
>>      ata: sata_mv: Fix PCI device ID table declaration compilation 
>> warning
>>
>> Andi Shyti <andi.shyti@linux.intel.com>
>>      drm/i915/gt: Limit the reserved VM space to only the platforms 
>> that need it
>>
>> Nikita Travkin <nikita@trvn.ru>
>>      thermal: gov_power_allocator: Allow binding without trip points
>>
>> Nikita Travkin <nikita@trvn.ru>
>>      thermal: gov_power_allocator: Allow binding without cooling devices
>>
>> Thomas Richter <tmricht@linux.ibm.com>
>>      s390/pai: fix sampling event removal for PMU device driver
>>
>> Huai-Yuan Liu <qq810974084@gmail.com>
>>      spi: mchp-pci1xxx: Fix a possible null pointer dereference in 
>> pci1xxx_spi_probe
>>
>> David Howells <dhowells@redhat.com>
>>      cifs: Fix caching to try to do open O_WRONLY as rdwr on server
>>
>> Imre Deak <imre.deak@intel.com>
>>      drm/i915/dp: Fix DSC state HW readout for SST connectors
>>
>> Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
>>      Revert "ALSA: emu10k1: fix synthesizer sample playback position 
>> and caching"
>>
>> Li Nan <linan122@huawei.com>
>>      scsi: sd: Unregister device if device_add_disk() failed in 
>> sd_probe()
>>
>> Arnd Bergmann <arnd@arndb.de>
>>      scsi: mylex: Fix sysfs buffer lengths
>>
>> Arnd Bergmann <arnd@arndb.de>
>>      ata: sata_sx4: fix pdc20621_get_from_dimm() on 64-bit
>>
>> Richard Fitzgerald <rf@opensource.cirrus.com>
>>      regmap: maple: Fix uninitialized symbol 'ret' warnings
>>
>> Vijendar Mukunda <Vijendar.Mukunda@amd.com>
>>      ASoC: amd: acp: fix for acp_init function error handling
>>
>> Jaewon Kim <jaewon02.kim@samsung.com>
>>      spi: s3c64xx: Use DMA mode from fifo size
>>
>> Tudor Ambarus <tudor.ambarus@linaro.org>
>>      spi: s3c64xx: determine the fifo depth only once
>>
>> Tudor Ambarus <tudor.ambarus@linaro.org>
>>      spi: s3c64xx: allow full FIFO masks
>>
>> Tudor Ambarus <tudor.ambarus@linaro.org>
>>      spi: s3c64xx: define a magic value
>>
>> Tudor Ambarus <tudor.ambarus@linaro.org>
>>      spi: s3c64xx: remove else after return
>>
>> Tudor Ambarus <tudor.ambarus@linaro.org>
>>      spi: s3c64xx: explicitly include <linux/bits.h>
>>
>> Tudor Ambarus <tudor.ambarus@linaro.org>
>>      spi: s3c64xx: sort headers alphabetically
>>
>> Sam Protsenko <semen.protsenko@linaro.org>
>>      spi: s3c64xx: Extract FIFO depth calculation to a dedicated macro
>>
>> Stephen Lee <slee08177@gmail.com>
>>      ASoC: ops: Fix wraparound for mask in snd_soc_get_volsw
>>
>> Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>>      ASoC: rt722-sdca-sdw: fix locking sequence
>>
>> Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>>      ASoC: rt712-sdca-sdw: fix locking sequence
>>
>> Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>>      ASoC: rt711-sdw: fix locking sequence
>>
>> Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>>      ASoC: rt711-sdca: fix locking sequence
>>
>> Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>>      ASoC: rt5682-sdw: fix locking sequence
>>
>> Rob Clark <robdclark@chromium.org>
>>      drm/prime: Unbreak virtgpu dma-buf export
>>
>> Dave Airlie <airlied@redhat.com>
>>      nouveau/uvmm: fix addr/range calcs for remap operations
>>
>> Christian Hewitt <christianshewitt@gmail.com>
>>      drm/panfrost: fix power transition timeout warnings
>>
>> Simon Trimmer <simont@opensource.cirrus.com>
>>      ALSA: hda: cs35l56: Add ACPI device match tables
>>
>> Richard Fitzgerald <rf@opensource.cirrus.com>
>>      regmap: maple: Fix cache corruption in regcache_maple_drop()
>>
>> Vijendar Mukunda <Vijendar.Mukunda@amd.com>
>>      ASoC: amd: acp: fix for acp pdm configuration check
>>
>> Victor Isaev <victor@torrio.net>
>>      RISC-V: Update AT_VECTOR_SIZE_ARCH for new AT_MINSIGSTKSZ
>>
>> Christian Brauner <brauner@kernel.org>
>>      block: count BLK_OPEN_RESTRICT_WRITES openers
>>
>> Pu Lehui <pulehui@huawei.com>
>>      drivers/perf: riscv: Disable PERF_SAMPLE_BRANCH_* while not 
>> supported
>>
>> Vladimir Isaev <vladimir.isaev@syntacore.com>
>>      riscv: hwprobe: do not produce frtace relocation
>>
>> Samuel Holland <samuel.holland@sifive.com>
>>      riscv: mm: Fix prototype to avoid discarding const
>>
>> Charles Keepax <ckeepax@opensource.cirrus.com>
>>      ASoC: cs42l43: Correct extraction of data pointer in suspend/resume
>>
>> Richard Fitzgerald <rf@opensource.cirrus.com>
>>      ASoC: wm_adsp: Fix missing mutex_lock in wm_adsp_write_ctl()
>>
>> Dominique Martinet <asmadeus@codewreck.org>
>>      9p: Fix read/write debug statements to report server reply
>>
>> Davide Caratti <dcaratti@redhat.com>
>>      mptcp: don't account accept() of non-MPC client as fallback to TCP
>>
>> Geliang Tang <tanggeliang@kylinos.cn>
>>      selftests: mptcp: use += operator to append strings
>>
>> Matthieu Baerts (NGI0) <matttbe@kernel.org>
>>      selftests: mptcp: connect: fix shellcheck warnings
>>
>> Ashish Kalra <ashish.kalra@amd.com>
>>      KVM: SVM: Add support for allowing zero SEV ASIDs
>>
>> Sean Christopherson <seanjc@google.com>
>>      KVM: SVM: Use unsigned integers when dealing with ASIDs
>>
>> Paul Barker <paul.barker.ct@bp.renesas.com>
>>      net: ravb: Always update error counters
>>
>> Paul Barker <paul.barker.ct@bp.renesas.com>
>>      net: ravb: Always process TX descriptor ring
>>
>> Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>      net: ravb: Let IP-specific receive function to interrogate 
>> descriptors
>>
>> Guenter Roeck <linux@roeck-us.net>
>>      mean_and_variance: Drop always failing tests
>>
>> Vitaly Lifshits <vitaly.lifshits@intel.com>
>>      e1000e: move force SMBUS from enable ulp function to avoid PHY 
>> loss issue
>>
>> Vitaly Lifshits <vitaly.lifshits@intel.com>
>>      e1000e: Minor flow correction in e1000_shutdown function
>>
>> Mario Limonciello <mario.limonciello@amd.com>
>>      drm/amd: Flush GFXOFF requests in prepare stage
>>
>> Christian A. Ehrhardt <lk@c--e.de>
>>      usb: typec: ucsi: Check for notifications after init
>>
>> Alexander Wetzel <Alexander@wetzel-home.de>
>>      scsi: sg: Avoid sg device teardown race
>>
>> Ivan Vecera <ivecera@redhat.com>
>>      i40e: Enforce software interrupt during busy-poll exit
>>
>> Aleksandr Loktionov <aleksandr.loktionov@intel.com>
>>      i40e: fix vf may be used uninitialized in this function warning
>>
>> Aleksandr Loktionov <aleksandr.loktionov@intel.com>
>>      i40e: fix i40e_count_filters() to count only active/new filters
>>
>> Aleksandr Mishin <amishin@t-argos.ru>
>>      octeontx2-af: Add array index check
>>
>> Su Hui <suhui@nfschina.com>
>>      octeontx2-pf: check negative error code in otx2_open()
>>
>> Hariprasad Kelam <hkelam@marvell.com>
>>      octeontx2-af: Fix issue with loading coalesced KPU profiles
>>
>> Antoine Tenart <atenart@kernel.org>
>>      udp: prevent local UDP tunnel packets from being GROed
>>
>> Antoine Tenart <atenart@kernel.org>
>>      udp: do not transition UDP GRO fraglist partial checksums to 
>> unnecessary
>>
>> Antoine Tenart <atenart@kernel.org>
>>      udp: do not accept non-tunnel GSO skbs landing in a tunnel
>>
>> Atlas Yu <atlas.yu@canonical.com>
>>      r8169: skip DASH fw status checks when DASH is disabled
>>
>> David Thompson <davthompson@nvidia.com>
>>      mlxbf_gige: stop interface during shutdown
>>
>> Kuniyuki Iwashima <kuniyu@amazon.com>
>>      ipv6: Fix infinite recursion in fib6_dump_done().
>>
>> Vitaly Lifshits <vitaly.lifshits@intel.com>
>>      e1000e: Workaround for sporadic MDI error on Meteor Lake systems
>>
>> Duoming Zhou <duoming@zju.edu.cn>
>>      ax25: fix use-after-free bugs caused by ax25_ds_del_timer
>>
>> Kuniyuki Iwashima <kuniyu@amazon.com>
>>      tcp: Fix bind() regression for v6-only wildcard and 
>> v4(-mapped-v6) non-wildcard addresses.
>>
>> Jakub Kicinski <kuba@kernel.org>
>>      selftests: reuseaddr_conflict: add missing new line at the end of 
>> the output
>>
>> Eric Dumazet <edumazet@google.com>
>>      erspan: make sure erspan_base_hdr is present in skb->head
>>
>> Kuniyuki Iwashima <kuniyu@amazon.com>
>>      tcp: Fix bind() regression for v6-only wildcard and v4-mapped-v6 
>> non-wildcard addresses.
>>
>> Ivan Vecera <ivecera@redhat.com>
>>      i40e: Fix VF MAC filter removal
>>
>> Petr Oros <poros@redhat.com>
>>      ice: fix enabling RX VLAN filtering
>>
>> Joshua Hay <joshua.a.hay@intel.com>
>>      idpf: fix kernel panic on unknown packet types
>>
>> Antoine Tenart <atenart@kernel.org>
>>      gro: fix ownership transfer
>>
>> Antoine Tenart <atenart@kernel.org>
>>      selftests: net: gro fwd: update vxlan GRO test expectations
>>
>> Michael Krummsdorf <michael.krummsdorf@tq-group.com>
>>      net: dsa: mv88e6xxx: fix usable ports on 88e6020
>>
>> Aleksandr Mishin <amishin@t-argos.ru>
>>      net: phy: micrel: Fix potential null pointer dereference
>>
>> Wei Fang <wei.fang@nxp.com>
>>      net: fec: Set mac_managed_pm during probe
>>
>> Duanqiang Wen <duanqiangwen@net-swift.com>
>>      net: txgbe: fix i2c dev name cannot match clkdev
>>
>> Horatiu Vultur <horatiu.vultur@microchip.com>
>>      net: phy: micrel: lan8814: Fix when enabling/disabling 1-step 
>> timestamping
>>
>> Piotr Wejman <piotrwejman90@gmail.com>
>>      net: stmmac: fix rx queue priority assignment
>>
>> Eric Dumazet <edumazet@google.com>
>>      net/sched: fix lockdep splat in qdisc_tree_reduce_backlog()
>>
>> Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>>      net: dsa: sja1105: Fix parameters order in 
>> sja1110_pcs_mdio_write_c45()
>>
>> Eric Dumazet <edumazet@google.com>
>>      net/sched: act_skbmod: prevent kernel-infoleak
>>
>> Will Deacon <will@kernel.org>
>>      KVM: arm64: Ensure target address is granule-aligned for range TLBI
>>
>> Will Deacon <will@kernel.org>
>>      KVM: arm64: Use TLBI_TTL_UNKNOWN in __kvm_tlb_flush_vmid_range()
>>
>> Borislav Petkov (AMD) <bp@alien8.de>
>>      x86/retpoline: Do the necessary fixup to the Zen3/4 srso return 
>> thunk for !SRSO
>>
>> Paolo Abeni <pabeni@redhat.com>
>>      mptcp: prevent BPF accessing lowat from a subflow socket.
>>
>> Jakub Sitnicki <jakub@cloudflare.com>
>>      bpf, sockmap: Prevent lock inversion deadlock in map delete elem
>>
>> Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>>      vboxsf: Avoid an spurious warning if load_nls_xxx() fails
>>
>> Eric Dumazet <edumazet@google.com>
>>      netfilter: validate user input for expected length
>>
>> Pablo Neira Ayuso <pablo@netfilter.org>
>>      netfilter: nf_tables: discard table flag update with pending 
>> basechain deletion
>>
>> Ziyang Xuan <william.xuanziyang@huawei.com>
>>      netfilter: nf_tables: Fix potential data-race in 
>> __nft_flowtable_type_get()
>>
>> Pablo Neira Ayuso <pablo@netfilter.org>
>>      netfilter: nf_tables: flush pending destroy work before exit_net 
>> release
>>
>> Pablo Neira Ayuso <pablo@netfilter.org>
>>      netfilter: nf_tables: reject new basechain after table flag update
>>
>> Marco Pinna <marco.pinn95@gmail.com>
>>      vsock/virtio: fix packet delivery to tap device
>>
>> Haiyang Zhang <haiyangz@microsoft.com>
>>      net: mana: Fix Rx DMA datasize and skb_over_panic
>>
>> Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
>>      net: usb: ax88179_178a: avoid the interface always configured as 
>> random address
>>
>> Mahmoud Adam <mngyadam@amazon.com>
>>      net/rds: fix possible cp null dereference
>>
>> Jesper Dangaard Brouer <hawk@kernel.org>
>>      xen-netfront: Add missing skb_mark_for_recycle
>>
>> Geliang Tang <tanggeliang@kylinos.cn>
>>      selftests: mptcp: join: fix dev in check_endpoint
>>
>> Pablo Neira Ayuso <pablo@netfilter.org>
>>      netfilter: nf_tables: release mutex after nft_gc_seq_end from 
>> abort path
>>
>> Pablo Neira Ayuso <pablo@netfilter.org>
>>      netfilter: nf_tables: release batch on table validation from 
>> abort path
>>
>> Bastien Nocera <hadess@hadess.net>
>>      Bluetooth: Fix TOCTOU in HCI debugfs implementation
>>
>> Hui Wang <hui.wang@canonical.com>
>>      Bluetooth: hci_event: set the conn encrypted before conn establishes
>>
>> Johan Hovold <johan+linaro@kernel.org>
>>      Bluetooth: add quirk for broken address properties
>>
>> Johan Hovold <johan+linaro@kernel.org>
>>      Bluetooth: qca: fix device-address endianness
>>
>> Johan Hovold <johan+linaro@kernel.org>
>>      arm64: dts: qcom: sc7180-trogdor: mark bluetooth address as broken
>>
>> Johan Hovold <johan+linaro@kernel.org>
>>      Revert "Bluetooth: hci_qca: Set BDA quirk bit if fwnode exists in 
>> DT"
>>
>> Uros Bizjak <ubizjak@gmail.com>
>>      x86/bpf: Fix IP after emitting call depth accounting
>>
>> Sean Christopherson <seanjc@google.com>
>>      x86/cpufeatures: Add CPUID_LNX_5 to track recently added 
>> Linux-defined word
>>
>> Sandipan Das <sandipan.das@amd.com>
>>      x86/cpufeatures: Add new word for scattered features
>>
>> Heiner Kallweit <hkallweit1@gmail.com>
>>      r8169: fix issue caused by buggy BIOS on certain boards with 
>> RTL8168d
>>
>> Christian Göttsche <cgzones@googlemail.com>
>>      selinux: avoid dereference of garbage after mount failure
>>
>> Wujie Duan <wjduan@linx-info.com>
>>      KVM: arm64: Fix out-of-IPA space translation fault handling
>>
>> Oliver Upton <oliver.upton@linux.dev>
>>      KVM: arm64: Fix host-programmed guest events in nVHE
>>
>> Anup Patel <apatel@ventanamicro.com>
>>      RISC-V: KVM: Fix APLIC in_clrip[x] read emulation
>>
>> Anup Patel <apatel@ventanamicro.com>
>>      RISC-V: KVM: Fix APLIC setipnum_le/be write emulation
>>
>> Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>      gpio: cdev: sanitize the label before requesting the interrupt
>>
>> Ingo Molnar <mingo@kernel.org>
>>      Revert "x86/mm/ident_map: Use gbpages only where full GB page 
>> should be mapped."
>>
>> Peter Xu <peterx@redhat.com>
>>      mm/treewide: replace pud_large() with pud_leaf()
>>
>> Arnd Bergmann <arnd@arndb.de>
>>      kbuild: make -Woverride-init warnings more consistent
>>
>> Masahiro Yamada <masahiroy@kernel.org>
>>      modpost: do not make find_tosym() return NULL
>>
>> Arnd Bergmann <arnd@arndb.de>
>>      dm integrity: fix out-of-range warning
>>
>> José Roberto de Souza <jose.souza@intel.com>
>>      drm/i915: Do not print 'pxp init failed with 0' when it succeed
>>
>> Tejas Upadhyay <tejas.upadhyay@intel.com>
>>      drm/i915/mtl: Update workaround 14018575942
>>
>> Matt Roper <matthew.d.roper@intel.com>
>>      drm/i915/xelpg: Extend some workarounds/tuning to gfx version 12.74
>>
>> Juha-Pekka Heikkila <juhapekka.heikkila@gmail.com>
>>      drm/i915/display: Disable AuxCCS framebuffers if built for Xe
>>
>> Ville Syrjälä <ville.syrjala@linux.intel.com>
>>      drm/i915: Stop doing double audio enable/disable on SDVO and g4x+ DP
>>
>> Florian Westphal <fw@strlen.de>
>>      inet: inet_defrag: prevent sk release while still in use
>>
>> Hariprasad Kelam <hkelam@marvell.com>
>>      Octeontx2-af: fix pause frame configuration in GMP mode
>>
>> Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
>>      net: lan743x: Add set RFE read fifo threshold for PCI1x1x chips
>>
>> Justin Chen <justin.chen@broadcom.com>
>>      net: bcmasp: Bring up unimac after PHY link up
>>
>> Jason Gunthorpe <jgg@ziepe.ca>
>>      iommu: Validate the PASID in iommu_attach_device_pasid()
>>
>> Pablo Neira Ayuso <pablo@netfilter.org>
>>      netfilter: nf_tables: skip netdev hook unregistration if table is 
>> dormant
>>
>> Pablo Neira Ayuso <pablo@netfilter.org>
>>      netfilter: nf_tables: reject table flag and netdev basechain updates
>>
>> Pablo Neira Ayuso <pablo@netfilter.org>
>>      netfilter: nf_tables: reject destroy command to remove basechain 
>> hooks
>>
>> David Howells <dhowells@redhat.com>
>>      cifs: Fix duplicate fscache cookie warnings
>>
>> Andrei Matei <andreimatei1@gmail.com>
>>      bpf: Protect against int overflow for stack access size
>>
>> Taimur Hassan <syed.hassan@amd.com>
>>      drm/amd/display: Send DTBCLK disable message on first commit
>>
>> Charlene Liu <charlene.liu@amd.com>
>>      drm/amd/display: Update P010 scaling cap
>>
>> David Thompson <davthompson@nvidia.com>
>>      mlxbf_gige: call request_irq() after NAPI initialized
>>
>> Sabrina Dubroca <sd@queasysnail.net>
>>      tls: get psock ref after taking rxlock to avoid leak
>>
>> Sabrina Dubroca <sd@queasysnail.net>
>>      tls: adjust recv return with async crypto and failed copy to 
>> userspace
>>
>> Sabrina Dubroca <sd@queasysnail.net>
>>      tls: recv: process_rx_list shouldn't use an offset with kvec
>>
>> Jian Shen <shenjian15@huawei.com>
>>      net: hns3: mark unexcuted loopback test result as UNEXECUTED
>>
>> Yonglong Liu <liuyonglong@huawei.com>
>>      net: hns3: fix kernel crash when devlink reload during pf 
>> initialization
>>
>> Jie Wang <wangjie125@huawei.com>
>>      net: hns3: fix index limit to support all queue stats
>>
>> Nikita Kiryushin <kiryushin@ancud.ru>
>>      ACPICA: debugger: check status of acpi_evaluate_object() in 
>> acpi_db_walk_for_fields()
>>
>> Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>>      gpiolib: Fix debug messaging in gpiod_find_and_request()
>>
>> Ido Schimmel <idosch@nvidia.com>
>>      selftests: vxlan_mdb: Fix failures with old libnet
>>
>> Andy Yan <andy.yan@rock-chips.com>
>>      drm/rockchip: vop2: Remove AR30 and AB30 format support
>>
>> Bjørn Mork <bjorn@mork.no>
>>      net: wwan: t7xx: Split 64bit accesses to fix alignment issues
>>
>> Eric Dumazet <edumazet@google.com>
>>      tcp: properly terminate timers for kernel sockets
>>
>> Ravi Gunasekaran <r-gunasekaran@ti.com>
>>      net: hsr: hsr_slave: Fix the promiscuous mode in offload mode
>>
>> Alexandra Winter <wintera@linux.ibm.com>
>>      s390/qeth: handle deferred cc1
>>
>> Prasad Pandit <pjp@fedoraproject.org>
>>      dpll: indent DPLL option type by a tab
>>
>> Matthew Auld <matthew.auld@intel.com>
>>      drm/xe/device: fix XE_MAX_TILES_PER_DEVICE check
>>
>> Matthew Auld <matthew.auld@intel.com>
>>      drm/xe/device: fix XE_MAX_GT_PER_TILE check
>>
>> Matthew Auld <matthew.auld@intel.com>
>>      drm/xe/queue: fix engine_class bounds check
>>
>> Matthew Auld <matthew.auld@intel.com>
>>      drm/xe/guc_submit: use jiffies for job timeout
>>
>> Brian Welty <brian.welty@intel.com>
>>      drm/xe: Add exec_queue.sched_props.job_timeout_ms
>>
>> Nirmoy Das <nirmoy.das@intel.com>
>>      drm/xe: Remove unused xe_bo->props struct
>>
>> Kurt Kanzenbach <kurt@linutronix.de>
>>      igc: Remove stale comment about Tx timestamping
>>
>> Przemek Kitszel <przemyslaw.kitszel@intel.com>
>>      ixgbe: avoid sleeping allocation in ixgbe_ipsec_vf_add_sa()
>>
>> Jesse Brandeburg <jesse.brandeburg@intel.com>
>>      ice: fix memory corruption bug with suspend and rebuild
>>
>> Steven Zou <steven.zou@intel.com>
>>      ice: Refactor FW data type and fix bitmap casting issue
>>
>> Simon Trimmer <simont@opensource.cirrus.com>
>>      ALSA: hda: cs35l56: Set the init_done flag before component_add()
>>
>> Benjamin Berg <benjamin.berg@intel.com>
>>      wifi: iwlwifi: mvm: include link ID when releasing frames
>>
>> Johannes Berg <johannes.berg@intel.com>
>>      wifi: iwlwifi: mvm: rfi: fix potential response leaks
>>
>> Emmanuel Grumbach <emmanuel.grumbach@intel.com>
>>      wifi: iwlwifi: mvm: pick the version of SESSION_PROTECTION_NOTIF
>>
>> David Thompson <davthompson@nvidia.com>
>>      mlxbf_gige: stop PHY during open() error paths
>>
>> Jakub Kicinski <kuba@kernel.org>
>>      tools: ynl: fix setting presence bits in simple nests
>>
>> Jan Kara <jack@suse.cz>
>>      nfsd: Fix error cleanup path in nfsd_rename()
>>
>> Ryosuke Yasuoka <ryasuoka@redhat.com>
>>      nfc: nci: Fix uninit-value in nci_dev_up and nci_ntf_packet
>>
>> Artem Savkov <asavkov@redhat.com>
>>      arm64: bpf: fix 32bit unconditional bswap
>>
>> Pavel Sakharov <p.sakharov@ispras.ru>
>>      dma-buf: Fix NULL pointer dereference in sanitycheck()
>>
>> Puranjay Mohan <puranjay12@gmail.com>
>>      bpf, arm64: fix bug in BPF_LDX_MEMSX
>>
>> Ilya Leoshkevich <iii@linux.ibm.com>
>>      s390/bpf: Fix bpf_plt pointer arithmetic
>>
>> Stanislav Fomichev <sdf@google.com>
>>      xsk: Don't assume metadata is always requested in TX completion
>>
>> Hangbin Liu <liuhangbin@gmail.com>
>>      scripts/bpf_doc: Use silent mode when exec make cmd
>>
>>
>> -------------
>>
>> Diffstat:
>>
>>   Makefile                                           |   4 +-
>>   arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi       |   2 +
>>   arch/arm64/kernel/ptrace.c                         |   5 +-
>>   arch/arm64/kvm/hyp/nvhe/tlb.c                      |   3 +-
>>   arch/arm64/kvm/hyp/pgtable.c                       |  11 +-
>>   arch/arm64/kvm/hyp/vhe/tlb.c                       |   3 +-
>>   arch/arm64/kvm/mmu.c                               |   2 +-
>>   arch/arm64/net/bpf_jit_comp.c                      |   4 +-
>>   arch/powerpc/mm/book3s64/pgtable.c                 |   2 +-
>>   arch/riscv/include/asm/uaccess.h                   |   4 +-
>>   arch/riscv/include/uapi/asm/auxvec.h               |   2 +-
>>   arch/riscv/kernel/patch.c                          |   8 +
>>   arch/riscv/kernel/process.c                        |   5 +-
>>   arch/riscv/kernel/signal.c                         |  15 +-
>>   arch/riscv/kernel/traps.c                          |   2 +-
>>   arch/riscv/kernel/vdso/Makefile                    |   1 +
>>   arch/riscv/kvm/aia_aplic.c                         |  37 +++-
>>   arch/riscv/mm/tlbflush.c                           |   4 +-
>>   arch/s390/boot/vmem.c                              |   2 +-
>>   arch/s390/include/asm/pgtable.h                    |   4 +-
>>   arch/s390/kernel/entry.S                           |   1 +
>>   arch/s390/kernel/perf_pai_crypto.c                 |  10 +-
>>   arch/s390/kernel/perf_pai_ext.c                    |  10 +-
>>   arch/s390/mm/gmap.c                                |   2 +-
>>   arch/s390/mm/hugetlbpage.c                         |   4 +-
>>   arch/s390/mm/pageattr.c                            |   2 +-
>>   arch/s390/mm/pgtable.c                             |   2 +-
>>   arch/s390/mm/vmem.c                                |   6 +-
>>   arch/s390/net/bpf_jit_comp.c                       |  46 ++---
>>   arch/sparc/mm/init_64.c                            |   2 +-
>>   arch/x86/boot/compressed/Makefile                  |   2 +-
>>   arch/x86/boot/compressed/misc.c                    |  16 ++
>>   arch/x86/boot/compressed/sev.c                     |   3 +
>>   arch/x86/coco/core.c                               |  41 +++++
>>   arch/x86/events/intel/ds.c                         |   8 +-
>>   arch/x86/include/asm/boot.h                        |   1 +
>>   arch/x86/include/asm/coco.h                        |   2 +
>>   arch/x86/include/asm/cpufeature.h                  |   8 +-
>>   arch/x86/include/asm/cpufeatures.h                 |   2 +-
>>   arch/x86/include/asm/disabled-features.h           |   3 +-
>>   arch/x86/include/asm/mem_encrypt.h                 |   8 +-
>>   arch/x86/include/asm/required-features.h           |   3 +-
>>   arch/x86/include/asm/sev.h                         |  10 +-
>>   arch/x86/include/uapi/asm/bootparam.h              |   1 +
>>   arch/x86/kernel/cpu/mce/core.c                     |   4 +-
>>   arch/x86/kernel/mpparse.c                          |  10 +-
>>   arch/x86/kernel/setup.c                            |   2 +
>>   arch/x86/kernel/sev-shared.c                       |  23 +--
>>   arch/x86/kernel/sev.c                              |  14 +-
>>   arch/x86/kvm/mmu/mmu.c                             |   2 +-
>>   arch/x86/kvm/reverse_cpuid.h                       |   2 +
>>   arch/x86/kvm/svm/sev.c                             |  45 +++--
>>   arch/x86/kvm/trace.h                               |  10 +-
>>   arch/x86/lib/Makefile                              |  13 --
>>   arch/x86/lib/retpoline.S                           |   6 +-
>>   arch/x86/mm/fault.c                                |   4 +-
>>   arch/x86/mm/ident_map.c                            |  23 +--
>>   arch/x86/mm/init_64.c                              |   4 +-
>>   arch/x86/mm/kasan_init_64.c                        |   2 +-
>>   arch/x86/mm/mem_encrypt_identity.c                 |  76 +++-----
>>   arch/x86/mm/pat/memtype.c                          |  49 +++--
>>   arch/x86/mm/pat/set_memory.c                       |   6 +-
>>   arch/x86/mm/pgtable.c                              |   2 +-
>>   arch/x86/mm/pti.c                                  |   2 +-
>>   arch/x86/net/bpf_jit_comp.c                        |   2 +-
>>   arch/x86/power/hibernate.c                         |   2 +-
>>   arch/x86/xen/mmu_pv.c                              |   4 +-
>>   block/bdev.c                                       |   6 +-
>>   drivers/acpi/acpica/dbnames.c                      |   8 +-
>>   drivers/ata/sata_mv.c                              |  63 ++++---
>>   drivers/ata/sata_sx4.c                             |   6 +-
>>   drivers/base/core.c                                |  26 ++-
>>   drivers/base/regmap/regcache-maple.c               |   6 +-
>>   drivers/bluetooth/btqca.c                          |   8 +-
>>   drivers/bluetooth/hci_qca.c                        |  19 +-
>>   drivers/dma-buf/st-dma-fence-chain.c               |   6 +-
>>   drivers/dpll/Kconfig                               |   2 +-
>>   drivers/firmware/efi/libstub/efi-stub-helper.c     |   8 +
>>   drivers/firmware/efi/libstub/efistub.h             |   2 +-
>>   drivers/firmware/efi/libstub/x86-stub.c            |  14 +-
>>   drivers/gpio/gpiolib-cdev.c                        |  58 +++++-
>>   drivers/gpio/gpiolib.c                             |  31 ++--
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |   2 +
>>   .../amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c   |  25 ++-
>>   drivers/gpu/drm/amd/display/dc/dce110/Makefile     |   2 +-
>>   drivers/gpu/drm/amd/display/dc/dce112/Makefile     |   2 +-
>>   drivers/gpu/drm/amd/display/dc/dce120/Makefile     |   2 +-
>>   drivers/gpu/drm/amd/display/dc/dce60/Makefile      |   2 +-
>>   drivers/gpu/drm/amd/display/dc/dce80/Makefile      |   2 +-
>>   .../amd/display/dc/resource/dcn35/dcn35_resource.c |   2 +-
>>   drivers/gpu/drm/drm_prime.c                        |   7 +-
>>   drivers/gpu/drm/i915/Makefile                      |   7 +-
>>   drivers/gpu/drm/i915/display/g4x_dp.c              |   2 -
>>   .../gpu/drm/i915/display/intel_display_device.h    |   1 +
>>   drivers/gpu/drm/i915/display/intel_dp.c            |   9 +-
>>   drivers/gpu/drm/i915/display/intel_dp_mst.c        |   2 +-
>>   drivers/gpu/drm/i915/display/intel_sdvo.c          |   4 -
>>   drivers/gpu/drm/i915/display/skl_universal_plane.c |   3 +
>>   drivers/gpu/drm/i915/gt/gen8_engine_cs.c           |   4 +-
>>   drivers/gpu/drm/i915/gt/gen8_ppgtt.c               |   3 +
>>   drivers/gpu/drm/i915/gt/intel_engine_cs.c          |  17 ++
>>   drivers/gpu/drm/i915/gt/intel_gt.c                 |   6 +
>>   drivers/gpu/drm/i915/gt/intel_gt.h                 |   9 +-
>>   drivers/gpu/drm/i915/gt/intel_gt_ccs_mode.c        |  39 ++++
>>   drivers/gpu/drm/i915/gt/intel_gt_ccs_mode.h        |  13 ++
>>   drivers/gpu/drm/i915/gt/intel_gt_regs.h            |   6 +
>>   drivers/gpu/drm/i915/gt/intel_workarounds.c        |  55 ++++--
>>   drivers/gpu/drm/i915/i915_driver.c                 |   2 +-
>>   drivers/gpu/drm/i915/i915_perf.c                   |   2 +-
>>   drivers/gpu/drm/nouveau/nouveau_uvmm.c             |   6 +-
>>   drivers/gpu/drm/panfrost/panfrost_gpu.c            |   6 +-
>>   drivers/gpu/drm/rockchip/rockchip_vop2_reg.c       |   2 -
>>   drivers/gpu/drm/xe/Makefile                        |   4 +-
>>   drivers/gpu/drm/xe/xe_bo.c                         |  59 +-----
>>   drivers/gpu/drm/xe/xe_bo_types.h                   |  19 --
>>   drivers/gpu/drm/xe/xe_device.h                     |   4 +-
>>   drivers/gpu/drm/xe/xe_exec.c                       |  31 +---
>>   drivers/gpu/drm/xe/xe_exec_queue.c                 |   4 +-
>>   drivers/gpu/drm/xe/xe_exec_queue_types.h           |   7 +
>>   drivers/gpu/drm/xe/xe_guc_submit.c                 |   2 +-
>>   drivers/gpu/drm/xe/xe_pt.c                         |   8 +-
>>   drivers/gpu/drm/xe/xe_ring_ops.c                   |  11 +-
>>   drivers/gpu/drm/xe/xe_sched_job.c                  |  10 +
>>   drivers/gpu/drm/xe/xe_sched_job_types.h            |   2 +
>>   drivers/gpu/drm/xe/xe_vm.c                         |  27 +--
>>   drivers/gpu/drm/xe/xe_vm.h                         |   2 +-
>>   drivers/gpu/drm/xe/xe_vm_types.h                   |   8 +-
>>   drivers/iommu/iommu.c                              |  11 +-
>>   drivers/md/dm-integrity.c                          |   2 +-
>>   drivers/net/dsa/mv88e6xxx/chip.c                   |   6 +-
>>   drivers/net/dsa/sja1105/sja1105_mdio.c             |   2 +-
>>   drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c   |  28 ++-
>>   drivers/net/ethernet/freescale/fec_main.c          |  11 +-
>>   .../hns3/hns3_common/hclge_comm_tqp_stats.c        |   2 +-
>>   drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c |  19 +-
>>   .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    |   4 +
>>   drivers/net/ethernet/intel/e1000e/hw.h             |   2 +
>>   drivers/net/ethernet/intel/e1000e/ich8lan.c        |  38 ++--
>>   drivers/net/ethernet/intel/e1000e/netdev.c         |  24 ++-
>>   drivers/net/ethernet/intel/e1000e/phy.c            | 184 
>> +++++++++++-------
>>   drivers/net/ethernet/intel/e1000e/phy.h            |   2 +
>>   drivers/net/ethernet/intel/i40e/i40e.h             |   1 +
>>   drivers/net/ethernet/intel/i40e/i40e_main.c        |  13 +-
>>   drivers/net/ethernet/intel/i40e/i40e_register.h    |   3 +
>>   drivers/net/ethernet/intel/i40e/i40e_txrx.c        |  82 ++++++---
>>   drivers/net/ethernet/intel/i40e/i40e_txrx.h        |   1 +
>>   drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |  45 +++--
>>   drivers/net/ethernet/intel/ice/ice_adminq_cmd.h    |   3 +-
>>   drivers/net/ethernet/intel/ice/ice_lag.c           |   4 +-
>>   drivers/net/ethernet/intel/ice/ice_lib.c           |  18 +-
>>   drivers/net/ethernet/intel/ice/ice_switch.c        |  24 ++-
>>   drivers/net/ethernet/intel/ice/ice_switch.h        |   4 +-
>>   .../net/ethernet/intel/ice/ice_vf_vsi_vlan_ops.c   |  18 +-
>>   drivers/net/ethernet/intel/idpf/idpf_txrx.c        |   4 +-
>>   drivers/net/ethernet/intel/igc/igc_main.c          |   4 -
>>   drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c     |  16 +-
>>   drivers/net/ethernet/marvell/octeontx2/af/cgx.c    |   5 +
>>   .../net/ethernet/marvell/octeontx2/af/rvu_cgx.c    |   2 +
>>   .../net/ethernet/marvell/octeontx2/af/rvu_npc.c    |   2 +-
>>   .../net/ethernet/marvell/octeontx2/nic/otx2_pf.c   |   2 +-
>>   .../ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c |  31 +++-
>>   drivers/net/ethernet/microchip/lan743x_main.c      |  18 ++
>>   drivers/net/ethernet/microchip/lan743x_main.h      |   4 +
>>   drivers/net/ethernet/microsoft/mana/mana_en.c      |   2 +-
>>   drivers/net/ethernet/realtek/r8169_main.c          |  40 +++-
>>   drivers/net/ethernet/renesas/ravb_main.c           |  33 ++--
>>   drivers/net/ethernet/renesas/sh_eth.c              |   2 +-
>>   drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c  |  40 +++-
>>   .../net/ethernet/stmicro/stmmac/dwxgmac2_core.c    |  38 +++-
>>   drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c     |   8 +-
>>   drivers/net/phy/micrel.c                           |  31 +++-
>>   drivers/net/usb/ax88179_178a.c                     |   2 +
>>   drivers/net/wireless/intel/iwlwifi/mvm/rfi.c       |   8 +-
>>   drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c      |  20 +-
>>   .../net/wireless/intel/iwlwifi/mvm/time-event.c    |   5 +-
>>   drivers/net/wwan/t7xx/t7xx_cldma.c                 |   4 +-
>>   drivers/net/wwan/t7xx/t7xx_hif_cldma.c             |   9 +-
>>   drivers/net/wwan/t7xx/t7xx_pcie_mac.c              |   8 +-
>>   drivers/net/xen-netfront.c                         |   1 +
>>   drivers/of/dynamic.c                               |  12 ++
>>   drivers/of/module.c                                |   8 +
>>   drivers/perf/riscv_pmu.c                           |   4 +
>>   drivers/pinctrl/aspeed/Makefile                    |   2 +-
>>   drivers/s390/net/qeth_core_main.c                  |  38 +++-
>>   drivers/scsi/myrb.c                                |  20 +-
>>   drivers/scsi/myrs.c                                |  24 +--
>>   drivers/scsi/sd.c                                  |   2 +-
>>   drivers/scsi/sg.c                                  |   4 +-
>>   drivers/spi/spi-pci1xxxx.c                         |   2 +
>>   drivers/spi/spi-s3c64xx.c                          |  80 +++++---
>>   drivers/thermal/gov_power_allocator.c              |  14 +-
>>   drivers/usb/typec/ucsi/ucsi.c                      |  10 +-
>>   fs/aio.c                                           |   2 +-
>>   fs/bcachefs/mean_and_variance_test.c               |  28 +--
>>   fs/nfsd/nfs4state.c                                |   7 +-
>>   fs/nfsd/vfs.c                                      |   3 +-
>>   fs/proc/Makefile                                   |   2 +-
>>   fs/smb/client/cached_dir.c                         |   6 +-
>>   fs/smb/client/cifs_debug.c                         |   6 +
>>   fs/smb/client/cifsfs.c                             |  11 ++
>>   fs/smb/client/cifsglob.h                           |  19 +-
>>   fs/smb/client/cifsproto.h                          |  20 +-
>>   fs/smb/client/connect.c                            | 157 
>> ++++++++++------
>>   fs/smb/client/dfs.c                                |  51 +++--
>>   fs/smb/client/dfs.h                                |  33 ++--
>>   fs/smb/client/dfs_cache.c                          |  53 +++---
>>   fs/smb/client/dir.c                                |  15 ++
>>   fs/smb/client/file.c                               | 111 +++++++++--
>>   fs/smb/client/fs_context.c                         |   6 +-
>>   fs/smb/client/fs_context.h                         |  12 ++
>>   fs/smb/client/fscache.c                            |  16 +-
>>   fs/smb/client/fscache.h                            |   6 +
>>   fs/smb/client/inode.c                              |   2 +
>>   fs/smb/client/ioctl.c                              |   6 +-
>>   fs/smb/client/misc.c                               |   8 +-
>>   fs/smb/client/smb1ops.c                            |   4 +-
>>   fs/smb/client/smb2misc.c                           |   4 +
>>   fs/smb/client/smb2ops.c                            |  11 +-
>>   fs/smb/client/smb2pdu.c                            |   2 +-
>>   fs/smb/server/ksmbd_netlink.h                      |   3 +-
>>   fs/smb/server/mgmt/share_config.c                  |   7 +-
>>   fs/smb/server/smb2ops.c                            |  10 +-
>>   fs/smb/server/smb2pdu.c                            |   3 +-
>>   fs/smb/server/transport_ipc.c                      |  37 ++++
>>   fs/vboxsf/super.c                                  |   3 +-
>>   include/kvm/arm_pmu.h                              |   2 +-
>>   include/linux/bpf.h                                |  16 +-
>>   include/linux/device.h                             |   1 +
>>   include/linux/io_uring_types.h                     |   1 -
>>   include/linux/secretmem.h                          |   4 +-
>>   include/linux/skbuff.h                             |   7 +-
>>   include/linux/stackdepot.h                         |  46 +++++
>>   include/linux/udp.h                                |  28 +++
>>   include/net/bluetooth/hci.h                        |   9 +
>>   include/net/inet_connection_sock.h                 |   1 +
>>   include/net/mana/mana.h                            |   1 -
>>   include/net/sock.h                                 |   7 +
>>   include/net/xdp_sock.h                             |   2 +
>>   include/sound/hdaudio_ext.h                        |   3 +
>>   io_uring/io_uring.c                                |  18 +-
>>   io_uring/kbuf.c                                    | 116 ++++--------
>>   io_uring/kbuf.h                                    |   8 +-
>>   io_uring/rw.c                                      |   9 +-
>>   kernel/bpf/Makefile                                |   2 +-
>>   kernel/bpf/syscall.c                               |  35 +++-
>>   kernel/bpf/verifier.c                              |   5 +
>>   kernel/trace/bpf_trace.c                           |  10 +-
>>   lib/stackdepot.c                                   |  47 +----
>>   mm/Makefile                                        |   3 +-
>>   mm/memory.c                                        |   4 +
>>   net/9p/client.c                                    |  10 +-
>>   net/ax25/ax25_dev.c                                |   2 +-
>>   net/bluetooth/hci_debugfs.c                        |  64 ++++---
>>   net/bluetooth/hci_event.c                          |  25 +++
>>   net/bluetooth/hci_sync.c                           |   5 +-
>>   net/bridge/netfilter/ebtables.c                    |   6 +
>>   net/core/gro.c                                     |   3 +-
>>   net/core/sock_map.c                                |   6 +
>>   net/hsr/hsr_slave.c                                |   3 +-
>>   net/ipv4/inet_connection_sock.c                    |  44 ++++-
>>   net/ipv4/inet_fragment.c                           |  70 +++++--
>>   net/ipv4/ip_fragment.c                             |   2 +-
>>   net/ipv4/ip_gre.c                                  |   5 +
>>   net/ipv4/netfilter/arp_tables.c                    |   4 +
>>   net/ipv4/netfilter/ip_tables.c                     |   4 +
>>   net/ipv4/tcp.c                                     |   2 +
>>   net/ipv4/udp.c                                     |   7 +
>>   net/ipv4/udp_offload.c                             |  23 ++-
>>   net/ipv6/ip6_fib.c                                 |  14 +-
>>   net/ipv6/ip6_gre.c                                 |   3 +
>>   net/ipv6/netfilter/ip6_tables.c                    |   4 +
>>   net/ipv6/netfilter/nf_conntrack_reasm.c            |   2 +-
>>   net/ipv6/udp.c                                     |   2 +-
>>   net/ipv6/udp_offload.c                             |   8 +-
>>   net/mptcp/protocol.c                               |   2 -
>>   net/mptcp/sockopt.c                                |   4 +
>>   net/mptcp/subflow.c                                |   2 +
>>   net/netfilter/nf_tables_api.c                      |  92 +++++++--
>>   net/nfc/nci/core.c                                 |   5 +
>>   net/rds/rdma.c                                     |   2 +-
>>   net/sched/act_skbmod.c                             |  10 +-
>>   net/sched/sch_api.c                                |   2 +-
>>   net/sunrpc/svcsock.c                               |  10 +-
>>   net/tls/tls_sw.c                                   |   7 +-
>>   net/vmw_vsock/virtio_transport.c                   |   3 +-
>>   scripts/Makefile.extrawarn                         |  10 +-
>>   scripts/bpf_doc.py                                 |   4 +-
>>   scripts/mod/modpost.c                              |   7 +-
>>   security/selinux/selinuxfs.c                       |  12 +-
>>   sound/pci/emu10k1/emu10k1_callback.c               |   7 +-
>>   sound/pci/hda/cs35l41_hda_property.c               |   6 +
>>   sound/pci/hda/cs35l56_hda.c                        |   4 +-
>>   sound/pci/hda/cs35l56_hda_i2c.c                    |  13 +-
>>   sound/pci/hda/cs35l56_hda_spi.c                    |  13 +-
>>   sound/pci/hda/patch_realtek.c                      |   7 +-
>>   sound/soc/amd/acp/acp-pci.c                        |  13 +-
>>   sound/soc/codecs/cs42l43.c                         |  12 +-
>>   sound/soc/codecs/rt5682-sdw.c                      |   4 +-
>>   sound/soc/codecs/rt711-sdca-sdw.c                  |   4 +-
>>   sound/soc/codecs/rt711-sdw.c                       |   4 +-
>>   sound/soc/codecs/rt712-sdca-sdw.c                  |   5 +-
>>   sound/soc/codecs/rt722-sdca-sdw.c                  |   4 +-
>>   sound/soc/codecs/wm_adsp.c                         |   3 +-
>>   sound/soc/soc-ops.c                                |   2 +-
>>   sound/soc/sof/amd/acp.c                            |   8 +-
>>   sound/soc/sof/intel/hda-common-ops.c               |   3 +
>>   sound/soc/sof/intel/hda-dai-ops.c                  |  11 ++
>>   sound/soc/sof/intel/hda-pcm.c                      |  29 +++
>>   sound/soc/sof/intel/hda-stream.c                   |  70 +++++++
>>   sound/soc/sof/intel/hda.h                          |   6 +
>>   sound/soc/sof/intel/lnl.c                          |   2 -
>>   sound/soc/sof/intel/mtl.c                          |  14 --
>>   sound/soc/sof/intel/mtl.h                          |  10 -
>>   sound/soc/sof/ipc4-pcm.c                           | 193 
>> +++++++++++++++----
>>   sound/soc/sof/ipc4-priv.h                          |  14 --
>>   sound/soc/sof/ipc4-topology.c                      |  22 ++-
>>   sound/soc/sof/ops.h                                |  24 ++-
>>   sound/soc/sof/pcm.c                                |   8 +
>>   sound/soc/sof/sof-audio.h                          |   9 +-
>>   sound/soc/sof/sof-priv.h                           |  24 ++-
>>   tools/net/ynl/ynl-gen-c.py                         |   7 +-
>>   tools/testing/selftests/mm/vm_util.h               |   2 +-
>>   tools/testing/selftests/net/mptcp/mptcp_connect.sh | 134 ++++++++------
>>   tools/testing/selftests/net/mptcp/mptcp_join.sh    |  34 ++--
>>   tools/testing/selftests/net/reuseaddr_conflict.c   |   2 +-
>>   tools/testing/selftests/net/test_vxlan_mdb.sh      | 205 
>> +++++++++++++--------
>>   tools/testing/selftests/net/udpgro_fwd.sh          |  10 +-
>>   327 files changed, 3223 insertions(+), 1693 deletions(-)
> 
> 
> Something introduced between
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/tree/queue-6.8?id=c003a296efd53b6830d037c304b84ce71b6f755e
> 
> and
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/tree/queue-6.8?id=abc15de2dec1d9c24268266af2c096d5ca336407
> 
> makes the kernel reproducibly reboot during early boot on an Hetzner VM 
> with x86_64 Intel CPU that is running in UEFI mode.
> 
> I haven't found out yet which specific patch is causing the issue, but 
> I'm seeing no output on the VM's video output, it just reboots after a 
> few seconds.


I've been able to track this down to 
"x86-sme-move-early-sme-kernel-encryption-handling-into-.head.text.patch" 
from here:

https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/tree/queue-6.8/x86-sme-move-early-sme-kernel-encryption-handling-into-.head.text.patch?id=a0f0ce228535b3de1d61302e9dd4a59595bc1ccf

I've attached a kernel config that triggers the issue in an x86_64 Q35 
libvirt/qemu VM regardless of whether the VM is running in BIOS or UEFI 
mode. I've used the following cmdline parameters to boot the kernel:

root=/dev/vda rootfstype=btrfs rootflags=discard rw console=ttyS0,115200 
add_efi_memmap intel_iommu=on lockdown=confidentiality ia32_emulation=0 
usbcore.nousb loglevel=7 earlyprintk=serial,ttyS0,115200

I've also attached two PKGBUILD scripts - "PKGBUILD_0.1" is for building 
the broken kernel with the patch in question, and "PKGBUILD_0.2" is for 
building a non-broken kernel without the patch but with an otherwise 
identical setup. I've used Archlinux x86_64 with testing repos enabled 
for building, more specifically gcc 13.2.1-5 and mold 2.30.0-1. The 
broken kernel doesn't output a single line when I try to boot it, even 
with "earlyprintk=serial,ttyS0,115200".


Regards
Pascal
--------------HlDbtagZu4zoMt7iuC50CuDk
Content-Type: text/plain; charset=UTF-8; name="config"
Content-Disposition: attachment; filename="config"
Content-Transfer-Encoding: base64

IwojIEF1dG9tYXRpY2FsbHkgZ2VuZXJhdGVkIGZpbGU7IERPIE5PVCBFRElULgojIExpbnV4
L3g4NiA2LjguNCBLZXJuZWwgQ29uZmlndXJhdGlvbgojCkNPTkZJR19DQ19WRVJTSU9OX1RF
WFQ9ImdjYyAoR0NDKSAxMy4yLjEgMjAyMzA4MDEiCkNPTkZJR19DQ19JU19HQ0M9eQpDT05G
SUdfR0NDX1ZFUlNJT049MTMwMjAxCkNPTkZJR19DTEFOR19WRVJTSU9OPTAKQ09ORklHX0FT
X0lTX0dOVT15CkNPTkZJR19BU19WRVJTSU9OPTI0MjAwCkNPTkZJR19MRF9JU19CRkQ9eQpD
T05GSUdfTERfVkVSU0lPTj0yNDIwMApDT05GSUdfTExEX1ZFUlNJT049MApDT05GSUdfQ0Nf
Q0FOX0xJTks9eQpDT05GSUdfQ0NfQ0FOX0xJTktfU1RBVElDPXkKQ09ORklHX0NDX0hBU19B
U01fR09UT19PVVRQVVQ9eQpDT05GSUdfQ0NfSEFTX0FTTV9HT1RPX1RJRURfT1VUUFVUPXkK
Q09ORklHX0dDQ19BU01fR09UT19PVVRQVVRfV09SS0FST1VORD15CkNPTkZJR19UT09MU19T
VVBQT1JUX1JFTFI9eQpDT05GSUdfQ0NfSEFTX0FTTV9JTkxJTkU9eQpDT05GSUdfQ0NfSEFT
X05PX1BST0ZJTEVfRk5fQVRUUj15CkNPTkZJR19QQUhPTEVfVkVSU0lPTj0xMjYKQ09ORklH
X0lSUV9XT1JLPXkKQ09ORklHX0JVSUxEVElNRV9UQUJMRV9TT1JUPXkKQ09ORklHX1RIUkVB
RF9JTkZPX0lOX1RBU0s9eQoKIwojIEdlbmVyYWwgc2V0dXAKIwpDT05GSUdfSU5JVF9FTlZf
QVJHX0xJTUlUPTMyCiMgQ09ORklHX0NPTVBJTEVfVEVTVCBpcyBub3Qgc2V0CiMgQ09ORklH
X1dFUlJPUiBpcyBub3Qgc2V0CkNPTkZJR19MT0NBTFZFUlNJT049IiIKQ09ORklHX0xPQ0FM
VkVSU0lPTl9BVVRPPXkKQ09ORklHX0JVSUxEX1NBTFQ9IiIKQ09ORklHX0hBVkVfS0VSTkVM
X0daSVA9eQpDT05GSUdfSEFWRV9LRVJORUxfQlpJUDI9eQpDT05GSUdfSEFWRV9LRVJORUxf
TFpNQT15CkNPTkZJR19IQVZFX0tFUk5FTF9YWj15CkNPTkZJR19IQVZFX0tFUk5FTF9MWk89
eQpDT05GSUdfSEFWRV9LRVJORUxfTFo0PXkKQ09ORklHX0hBVkVfS0VSTkVMX1pTVEQ9eQoj
IENPTkZJR19LRVJORUxfR1pJUCBpcyBub3Qgc2V0CiMgQ09ORklHX0tFUk5FTF9CWklQMiBp
cyBub3Qgc2V0CiMgQ09ORklHX0tFUk5FTF9MWk1BIGlzIG5vdCBzZXQKIyBDT05GSUdfS0VS
TkVMX1haIGlzIG5vdCBzZXQKIyBDT05GSUdfS0VSTkVMX0xaTyBpcyBub3Qgc2V0CiMgQ09O
RklHX0tFUk5FTF9MWjQgaXMgbm90IHNldApDT05GSUdfS0VSTkVMX1pTVEQ9eQpDT05GSUdf
REVGQVVMVF9JTklUPSIiCkNPTkZJR19ERUZBVUxUX0hPU1ROQU1FPSJhcmNobGludXgiCkNP
TkZJR19TWVNWSVBDPXkKQ09ORklHX1NZU1ZJUENfU1lTQ1RMPXkKQ09ORklHX1NZU1ZJUENf
Q09NUEFUPXkKQ09ORklHX1BPU0lYX01RVUVVRT15CkNPTkZJR19QT1NJWF9NUVVFVUVfU1lT
Q1RMPXkKQ09ORklHX1dBVENIX1FVRVVFPXkKQ09ORklHX0NST1NTX01FTU9SWV9BVFRBQ0g9
eQojIENPTkZJR19VU0VMSUIgaXMgbm90IHNldApDT05GSUdfQVVESVQ9eQpDT05GSUdfSEFW
RV9BUkNIX0FVRElUU1lTQ0FMTD15CkNPTkZJR19BVURJVFNZU0NBTEw9eQoKIwojIElSUSBz
dWJzeXN0ZW0KIwpDT05GSUdfR0VORVJJQ19JUlFfUFJPQkU9eQpDT05GSUdfR0VORVJJQ19J
UlFfU0hPVz15CkNPTkZJR19HRU5FUklDX0lSUV9FRkZFQ1RJVkVfQUZGX01BU0s9eQpDT05G
SUdfR0VORVJJQ19QRU5ESU5HX0lSUT15CkNPTkZJR19HRU5FUklDX0lSUV9NSUdSQVRJT049
eQpDT05GSUdfSEFSRElSUVNfU1dfUkVTRU5EPXkKQ09ORklHX0lSUV9ET01BSU49eQpDT05G
SUdfSVJRX0RPTUFJTl9ISUVSQVJDSFk9eQpDT05GSUdfR0VORVJJQ19NU0lfSVJRPXkKQ09O
RklHX0lSUV9NU0lfSU9NTVU9eQpDT05GSUdfR0VORVJJQ19JUlFfTUFUUklYX0FMTE9DQVRP
Uj15CkNPTkZJR19HRU5FUklDX0lSUV9SRVNFUlZBVElPTl9NT0RFPXkKQ09ORklHX0lSUV9G
T1JDRURfVEhSRUFESU5HPXkKQ09ORklHX1NQQVJTRV9JUlE9eQojIENPTkZJR19HRU5FUklD
X0lSUV9ERUJVR0ZTIGlzIG5vdCBzZXQKIyBlbmQgb2YgSVJRIHN1YnN5c3RlbQoKQ09ORklH
X0NMT0NLU09VUkNFX1dBVENIRE9HPXkKQ09ORklHX0FSQ0hfQ0xPQ0tTT1VSQ0VfSU5JVD15
CkNPTkZJR19DTE9DS1NPVVJDRV9WQUxJREFURV9MQVNUX0NZQ0xFPXkKQ09ORklHX0dFTkVS
SUNfVElNRV9WU1lTQ0FMTD15CkNPTkZJR19HRU5FUklDX0NMT0NLRVZFTlRTPXkKQ09ORklH
X0dFTkVSSUNfQ0xPQ0tFVkVOVFNfQlJPQURDQVNUPXkKQ09ORklHX0dFTkVSSUNfQ0xPQ0tF
VkVOVFNfTUlOX0FESlVTVD15CkNPTkZJR19HRU5FUklDX0NNT1NfVVBEQVRFPXkKQ09ORklH
X0hBVkVfUE9TSVhfQ1BVX1RJTUVSU19UQVNLX1dPUks9eQpDT05GSUdfUE9TSVhfQ1BVX1RJ
TUVSU19UQVNLX1dPUks9eQpDT05GSUdfQ09OVEVYVF9UUkFDS0lORz15CkNPTkZJR19DT05U
RVhUX1RSQUNLSU5HX0lETEU9eQoKIwojIFRpbWVycyBzdWJzeXN0ZW0KIwpDT05GSUdfVElD
S19PTkVTSE9UPXkKQ09ORklHX05PX0haX0NPTU1PTj15CiMgQ09ORklHX0haX1BFUklPRElD
IGlzIG5vdCBzZXQKIyBDT05GSUdfTk9fSFpfSURMRSBpcyBub3Qgc2V0CkNPTkZJR19OT19I
Wl9GVUxMPXkKQ09ORklHX0NPTlRFWFRfVFJBQ0tJTkdfVVNFUj15CiMgQ09ORklHX0NPTlRF
WFRfVFJBQ0tJTkdfVVNFUl9GT1JDRSBpcyBub3Qgc2V0CkNPTkZJR19OT19IWj15CkNPTkZJ
R19ISUdIX1JFU19USU1FUlM9eQpDT05GSUdfQ0xPQ0tTT1VSQ0VfV0FUQ0hET0dfTUFYX1NL
RVdfVVM9MTAwCiMgZW5kIG9mIFRpbWVycyBzdWJzeXN0ZW0KCkNPTkZJR19CUEY9eQpDT05G
SUdfSEFWRV9FQlBGX0pJVD15CkNPTkZJR19BUkNIX1dBTlRfREVGQVVMVF9CUEZfSklUPXkK
CiMKIyBCUEYgc3Vic3lzdGVtCiMKQ09ORklHX0JQRl9TWVNDQUxMPXkKQ09ORklHX0JQRl9K
SVQ9eQpDT05GSUdfQlBGX0pJVF9BTFdBWVNfT049eQpDT05GSUdfQlBGX0pJVF9ERUZBVUxU
X09OPXkKQ09ORklHX0JQRl9VTlBSSVZfREVGQVVMVF9PRkY9eQojIENPTkZJR19CUEZfUFJF
TE9BRCBpcyBub3Qgc2V0CkNPTkZJR19CUEZfTFNNPXkKIyBlbmQgb2YgQlBGIHN1YnN5c3Rl
bQoKQ09ORklHX1BSRUVNUFRfQlVJTEQ9eQojIENPTkZJR19QUkVFTVBUX05PTkUgaXMgbm90
IHNldAojIENPTkZJR19QUkVFTVBUX1ZPTFVOVEFSWSBpcyBub3Qgc2V0CkNPTkZJR19QUkVF
TVBUPXkKQ09ORklHX1BSRUVNUFRfQ09VTlQ9eQpDT05GSUdfUFJFRU1QVElPTj15CkNPTkZJ
R19QUkVFTVBUX0RZTkFNSUM9eQpDT05GSUdfU0NIRURfQ09SRT15CgojCiMgQ1BVL1Rhc2sg
dGltZSBhbmQgc3RhdHMgYWNjb3VudGluZwojCkNPTkZJR19WSVJUX0NQVV9BQ0NPVU5USU5H
PXkKQ09ORklHX1ZJUlRfQ1BVX0FDQ09VTlRJTkdfR0VOPXkKQ09ORklHX0lSUV9USU1FX0FD
Q09VTlRJTkc9eQpDT05GSUdfSEFWRV9TQ0hFRF9BVkdfSVJRPXkKQ09ORklHX0JTRF9QUk9D
RVNTX0FDQ1Q9eQpDT05GSUdfQlNEX1BST0NFU1NfQUNDVF9WMz15CkNPTkZJR19UQVNLU1RB
VFM9eQpDT05GSUdfVEFTS19ERUxBWV9BQ0NUPXkKQ09ORklHX1RBU0tfWEFDQ1Q9eQpDT05G
SUdfVEFTS19JT19BQ0NPVU5USU5HPXkKQ09ORklHX1BTST15CiMgQ09ORklHX1BTSV9ERUZB
VUxUX0RJU0FCTEVEIGlzIG5vdCBzZXQKIyBlbmQgb2YgQ1BVL1Rhc2sgdGltZSBhbmQgc3Rh
dHMgYWNjb3VudGluZwoKQ09ORklHX0NQVV9JU09MQVRJT049eQoKIwojIFJDVSBTdWJzeXN0
ZW0KIwpDT05GSUdfVFJFRV9SQ1U9eQpDT05GSUdfUFJFRU1QVF9SQ1U9eQpDT05GSUdfUkNV
X0VYUEVSVD15CkNPTkZJR19UUkVFX1NSQ1U9eQpDT05GSUdfVEFTS1NfUkNVX0dFTkVSSUM9
eQojIENPTkZJR19GT1JDRV9UQVNLU19SQ1UgaXMgbm90IHNldApDT05GSUdfVEFTS1NfUkNV
PXkKIyBDT05GSUdfRk9SQ0VfVEFTS1NfUlVERV9SQ1UgaXMgbm90IHNldApDT05GSUdfVEFT
S1NfUlVERV9SQ1U9eQojIENPTkZJR19GT1JDRV9UQVNLU19UUkFDRV9SQ1UgaXMgbm90IHNl
dApDT05GSUdfVEFTS1NfVFJBQ0VfUkNVPXkKQ09ORklHX1JDVV9TVEFMTF9DT01NT049eQpD
T05GSUdfUkNVX05FRURfU0VHQ0JMSVNUPXkKQ09ORklHX1JDVV9GQU5PVVQ9NjQKQ09ORklH
X1JDVV9GQU5PVVRfTEVBRj0xNgpDT05GSUdfUkNVX0JPT1NUPXkKQ09ORklHX1JDVV9CT09T
VF9ERUxBWT01MDAKIyBDT05GSUdfUkNVX0VYUF9LVEhSRUFEIGlzIG5vdCBzZXQKQ09ORklH
X1JDVV9OT0NCX0NQVT15CiMgQ09ORklHX1JDVV9OT0NCX0NQVV9ERUZBVUxUX0FMTCBpcyBu
b3Qgc2V0CiMgQ09ORklHX1JDVV9OT0NCX0NQVV9DQl9CT09TVCBpcyBub3Qgc2V0CiMgQ09O
RklHX1RBU0tTX1RSQUNFX1JDVV9SRUFEX01CIGlzIG5vdCBzZXQKQ09ORklHX1JDVV9MQVpZ
PXkKQ09ORklHX1JDVV9ET1VCTEVfQ0hFQ0tfQ0JfVElNRT15CiMgZW5kIG9mIFJDVSBTdWJz
eXN0ZW0KCkNPTkZJR19JS0NPTkZJRz15CkNPTkZJR19JS0NPTkZJR19QUk9DPXkKIyBDT05G
SUdfSUtIRUFERVJTIGlzIG5vdCBzZXQKQ09ORklHX0xPR19CVUZfU0hJRlQ9MTcKQ09ORklH
X0xPR19DUFVfTUFYX0JVRl9TSElGVD0xMgpDT05GSUdfUFJJTlRLX0lOREVYPXkKQ09ORklH
X0hBVkVfVU5TVEFCTEVfU0NIRURfQ0xPQ0s9eQoKIwojIFNjaGVkdWxlciBmZWF0dXJlcwoj
CkNPTkZJR19VQ0xBTVBfVEFTSz15CkNPTkZJR19VQ0xBTVBfQlVDS0VUU19DT1VOVD01CiMg
ZW5kIG9mIFNjaGVkdWxlciBmZWF0dXJlcwoKQ09ORklHX0FSQ0hfU1VQUE9SVFNfTlVNQV9C
QUxBTkNJTkc9eQpDT05GSUdfQVJDSF9XQU5UX0JBVENIRURfVU5NQVBfVExCX0ZMVVNIPXkK
Q09ORklHX0NDX0hBU19JTlQxMjg9eQpDT05GSUdfQ0NfSU1QTElDSVRfRkFMTFRIUk9VR0g9
Ii1XaW1wbGljaXQtZmFsbHRocm91Z2g9NSIKQ09ORklHX0dDQzEwX05PX0FSUkFZX0JPVU5E
Uz15CkNPTkZJR19DQ19OT19BUlJBWV9CT1VORFM9eQpDT05GSUdfR0NDX05PX1NUUklOR09Q
X09WRVJGTE9XPXkKQ09ORklHX0NDX05PX1NUUklOR09QX09WRVJGTE9XPXkKQ09ORklHX0FS
Q0hfU1VQUE9SVFNfSU5UMTI4PXkKQ09ORklHX05VTUFfQkFMQU5DSU5HPXkKQ09ORklHX05V
TUFfQkFMQU5DSU5HX0RFRkFVTFRfRU5BQkxFRD15CkNPTkZJR19DR1JPVVBTPXkKQ09ORklH
X1BBR0VfQ09VTlRFUj15CiMgQ09ORklHX0NHUk9VUF9GQVZPUl9EWU5NT0RTIGlzIG5vdCBz
ZXQKQ09ORklHX01FTUNHPXkKQ09ORklHX01FTUNHX0tNRU09eQpDT05GSUdfQkxLX0NHUk9V
UD15CkNPTkZJR19DR1JPVVBfV1JJVEVCQUNLPXkKQ09ORklHX0NHUk9VUF9TQ0hFRD15CkNP
TkZJR19GQUlSX0dST1VQX1NDSEVEPXkKQ09ORklHX0NGU19CQU5EV0lEVEg9eQojIENPTkZJ
R19SVF9HUk9VUF9TQ0hFRCBpcyBub3Qgc2V0CkNPTkZJR19TQ0hFRF9NTV9DSUQ9eQpDT05G
SUdfVUNMQU1QX1RBU0tfR1JPVVA9eQpDT05GSUdfQ0dST1VQX1BJRFM9eQpDT05GSUdfQ0dS
T1VQX1JETUE9eQpDT05GSUdfQ0dST1VQX0ZSRUVaRVI9eQpDT05GSUdfQ0dST1VQX0hVR0VU
TEI9eQpDT05GSUdfQ1BVU0VUUz15CkNPTkZJR19QUk9DX1BJRF9DUFVTRVQ9eQpDT05GSUdf
Q0dST1VQX0RFVklDRT15CkNPTkZJR19DR1JPVVBfQ1BVQUNDVD15CkNPTkZJR19DR1JPVVBf
UEVSRj15CkNPTkZJR19DR1JPVVBfQlBGPXkKQ09ORklHX0NHUk9VUF9NSVNDPXkKIyBDT05G
SUdfQ0dST1VQX0RFQlVHIGlzIG5vdCBzZXQKQ09ORklHX1NPQ0tfQ0dST1VQX0RBVEE9eQpD
T05GSUdfTkFNRVNQQUNFUz15CkNPTkZJR19VVFNfTlM9eQpDT05GSUdfVElNRV9OUz15CkNP
TkZJR19JUENfTlM9eQpDT05GSUdfVVNFUl9OUz15CkNPTkZJR19QSURfTlM9eQpDT05GSUdf
TkVUX05TPXkKIyBDT05GSUdfQ0hFQ0tQT0lOVF9SRVNUT1JFIGlzIG5vdCBzZXQKQ09ORklH
X1NDSEVEX0FVVE9HUk9VUD15CkNPTkZJR19SRUxBWT15CkNPTkZJR19CTEtfREVWX0lOSVRS
RD15CkNPTkZJR19JTklUUkFNRlNfU09VUkNFPSIiCkNPTkZJR19SRF9HWklQPXkKQ09ORklH
X1JEX0JaSVAyPXkKQ09ORklHX1JEX0xaTUE9eQpDT05GSUdfUkRfWFo9eQpDT05GSUdfUkRf
TFpPPXkKQ09ORklHX1JEX0xaND15CkNPTkZJR19SRF9aU1REPXkKQ09ORklHX0JPT1RfQ09O
RklHPXkKIyBDT05GSUdfQk9PVF9DT05GSUdfRk9SQ0UgaXMgbm90IHNldAojIENPTkZJR19C
T09UX0NPTkZJR19FTUJFRCBpcyBub3Qgc2V0CkNPTkZJR19JTklUUkFNRlNfUFJFU0VSVkVf
TVRJTUU9eQpDT05GSUdfQ0NfT1BUSU1JWkVfRk9SX1BFUkZPUk1BTkNFPXkKIyBDT05GSUdf
Q0NfT1BUSU1JWkVfRk9SX1NJWkUgaXMgbm90IHNldApDT05GSUdfTERfT1JQSEFOX1dBUk49
eQpDT05GSUdfTERfT1JQSEFOX1dBUk5fTEVWRUw9Indhcm4iCkNPTkZJR19TWVNDVEw9eQpD
T05GSUdfSEFWRV9VSUQxNj15CkNPTkZJR19TWVNDVExfRVhDRVBUSU9OX1RSQUNFPXkKQ09O
RklHX0hBVkVfUENTUEtSX1BMQVRGT1JNPXkKIyBDT05GSUdfRVhQRVJUIGlzIG5vdCBzZXQK
Q09ORklHX1VJRDE2PXkKQ09ORklHX01VTFRJVVNFUj15CkNPTkZJR19TR0VUTUFTS19TWVND
QUxMPXkKQ09ORklHX1NZU0ZTX1NZU0NBTEw9eQpDT05GSUdfRkhBTkRMRT15CkNPTkZJR19Q
T1NJWF9USU1FUlM9eQpDT05GSUdfUFJJTlRLPXkKQ09ORklHX0JVRz15CkNPTkZJR19FTEZf
Q09SRT15CkNPTkZJR19QQ1NQS1JfUExBVEZPUk09eQpDT05GSUdfQkFTRV9GVUxMPXkKQ09O
RklHX0ZVVEVYPXkKQ09ORklHX0ZVVEVYX1BJPXkKQ09ORklHX0VQT0xMPXkKQ09ORklHX1NJ
R05BTEZEPXkKQ09ORklHX1RJTUVSRkQ9eQpDT05GSUdfRVZFTlRGRD15CkNPTkZJR19TSE1F
TT15CkNPTkZJR19BSU89eQpDT05GSUdfSU9fVVJJTkc9eQpDT05GSUdfQURWSVNFX1NZU0NB
TExTPXkKQ09ORklHX01FTUJBUlJJRVI9eQpDT05GSUdfS0NNUD15CkNPTkZJR19SU0VRPXkK
Q09ORklHX0NBQ0hFU1RBVF9TWVNDQUxMPXkKQ09ORklHX0tBTExTWU1TPXkKIyBDT05GSUdf
S0FMTFNZTVNfU0VMRlRFU1QgaXMgbm90IHNldApDT05GSUdfS0FMTFNZTVNfQUxMPXkKQ09O
RklHX0tBTExTWU1TX0FCU09MVVRFX1BFUkNQVT15CkNPTkZJR19LQUxMU1lNU19CQVNFX1JF
TEFUSVZFPXkKQ09ORklHX0FSQ0hfSEFTX01FTUJBUlJJRVJfU1lOQ19DT1JFPXkKQ09ORklH
X0hBVkVfUEVSRl9FVkVOVFM9eQpDT05GSUdfR1VFU1RfUEVSRl9FVkVOVFM9eQoKIwojIEtl
cm5lbCBQZXJmb3JtYW5jZSBFdmVudHMgQW5kIENvdW50ZXJzCiMKQ09ORklHX1BFUkZfRVZF
TlRTPXkKIyBDT05GSUdfREVCVUdfUEVSRl9VU0VfVk1BTExPQyBpcyBub3Qgc2V0CiMgZW5k
IG9mIEtlcm5lbCBQZXJmb3JtYW5jZSBFdmVudHMgQW5kIENvdW50ZXJzCgpDT05GSUdfU1lT
VEVNX0RBVEFfVkVSSUZJQ0FUSU9OPXkKQ09ORklHX1BST0ZJTElORz15CkNPTkZJR19UUkFD
RVBPSU5UUz15CgojCiMgS2V4ZWMgYW5kIGNyYXNoIGZlYXR1cmVzCiMKIyBDT05GSUdfS0VY
RUMgaXMgbm90IHNldAojIENPTkZJR19LRVhFQ19GSUxFIGlzIG5vdCBzZXQKIyBDT05GSUdf
Q1JBU0hfRFVNUCBpcyBub3Qgc2V0CiMgZW5kIG9mIEtleGVjIGFuZCBjcmFzaCBmZWF0dXJl
cwojIGVuZCBvZiBHZW5lcmFsIHNldHVwCgpDT05GSUdfNjRCSVQ9eQpDT05GSUdfWDg2XzY0
PXkKQ09ORklHX1g4Nj15CkNPTkZJR19JTlNUUlVDVElPTl9ERUNPREVSPXkKQ09ORklHX09V
VFBVVF9GT1JNQVQ9ImVsZjY0LXg4Ni02NCIKQ09ORklHX0xPQ0tERVBfU1VQUE9SVD15CkNP
TkZJR19TVEFDS1RSQUNFX1NVUFBPUlQ9eQpDT05GSUdfTU1VPXkKQ09ORklHX0FSQ0hfTU1B
UF9STkRfQklUU19NSU49MjgKQ09ORklHX0FSQ0hfTU1BUF9STkRfQklUU19NQVg9MzIKQ09O
RklHX0FSQ0hfTU1BUF9STkRfQ09NUEFUX0JJVFNfTUlOPTgKQ09ORklHX0FSQ0hfTU1BUF9S
TkRfQ09NUEFUX0JJVFNfTUFYPTE2CkNPTkZJR19HRU5FUklDX0lTQV9ETUE9eQpDT05GSUdf
R0VORVJJQ19CVUc9eQpDT05GSUdfR0VORVJJQ19CVUdfUkVMQVRJVkVfUE9JTlRFUlM9eQpD
T05GSUdfQVJDSF9NQVlfSEFWRV9QQ19GREM9eQpDT05GSUdfR0VORVJJQ19DQUxJQlJBVEVf
REVMQVk9eQpDT05GSUdfQVJDSF9IQVNfQ1BVX1JFTEFYPXkKQ09ORklHX0FSQ0hfSElCRVJO
QVRJT05fUE9TU0lCTEU9eQpDT05GSUdfQVJDSF9TVVNQRU5EX1BPU1NJQkxFPXkKQ09ORklH
X0FVRElUX0FSQ0g9eQpDT05GSUdfSEFWRV9JTlRFTF9UWFQ9eQpDT05GSUdfWDg2XzY0X1NN
UD15CkNPTkZJR19BUkNIX1NVUFBPUlRTX1VQUk9CRVM9eQpDT05GSUdfRklYX0VBUkxZQ09O
X01FTT15CkNPTkZJR19EWU5BTUlDX1BIWVNJQ0FMX01BU0s9eQpDT05GSUdfUEdUQUJMRV9M
RVZFTFM9NQpDT05GSUdfQ0NfSEFTX1NBTkVfU1RBQ0tQUk9URUNUT1I9eQoKIwojIFByb2Nl
c3NvciB0eXBlIGFuZCBmZWF0dXJlcwojCkNPTkZJR19TTVA9eQpDT05GSUdfWDg2X1gyQVBJ
Qz15CkNPTkZJR19YODZfTVBQQVJTRT15CiMgQ09ORklHX0dPTERGSVNIIGlzIG5vdCBzZXQK
Q09ORklHX1g4Nl9DUFVfUkVTQ1RSTD15CiMgQ09ORklHX1g4Nl9FWFRFTkRFRF9QTEFURk9S
TSBpcyBub3Qgc2V0CkNPTkZJR19YODZfSU5URUxfTFBTUz15CkNPTkZJR19YODZfQU1EX1BM
QVRGT1JNX0RFVklDRT15CkNPTkZJR19JT1NGX01CST15CiMgQ09ORklHX0lPU0ZfTUJJX0RF
QlVHIGlzIG5vdCBzZXQKQ09ORklHX1g4Nl9TVVBQT1JUU19NRU1PUllfRkFJTFVSRT15CkNP
TkZJR19TQ0hFRF9PTUlUX0ZSQU1FX1BPSU5URVI9eQpDT05GSUdfSFlQRVJWSVNPUl9HVUVT
VD15CkNPTkZJR19QQVJBVklSVD15CkNPTkZJR19QQVJBVklSVF9YWEw9eQojIENPTkZJR19Q
QVJBVklSVF9ERUJVRyBpcyBub3Qgc2V0CkNPTkZJR19QQVJBVklSVF9TUElOTE9DS1M9eQpD
T05GSUdfWDg2X0hWX0NBTExCQUNLX1ZFQ1RPUj15CkNPTkZJR19YRU49eQpDT05GSUdfWEVO
X1BWPXkKQ09ORklHX1hFTl81MTJHQj15CkNPTkZJR19YRU5fUFZfU01QPXkKQ09ORklHX1hF
Tl9QVl9ET00wPXkKQ09ORklHX1hFTl9QVkhWTT15CkNPTkZJR19YRU5fUFZIVk1fU01QPXkK
Q09ORklHX1hFTl9QVkhWTV9HVUVTVD15CkNPTkZJR19YRU5fU0FWRV9SRVNUT1JFPXkKIyBD
T05GSUdfWEVOX0RFQlVHX0ZTIGlzIG5vdCBzZXQKQ09ORklHX1hFTl9QVkg9eQpDT05GSUdf
WEVOX0RPTTA9eQpDT05GSUdfWEVOX1BWX01TUl9TQUZFPXkKQ09ORklHX0tWTV9HVUVTVD15
CkNPTkZJR19BUkNIX0NQVUlETEVfSEFMVFBPTEw9eQpDT05GSUdfUFZIPXkKQ09ORklHX1BB
UkFWSVJUX1RJTUVfQUNDT1VOVElORz15CkNPTkZJR19QQVJBVklSVF9DTE9DSz15CkNPTkZJ
R19KQUlMSE9VU0VfR1VFU1Q9eQpDT05GSUdfQUNSTl9HVUVTVD15CkNPTkZJR19JTlRFTF9U
RFhfR1VFU1Q9eQojIENPTkZJR19NSzggaXMgbm90IHNldAojIENPTkZJR19NUFNDIGlzIG5v
dCBzZXQKIyBDT05GSUdfTUNPUkUyIGlzIG5vdCBzZXQKIyBDT05GSUdfTUFUT00gaXMgbm90
IHNldApDT05GSUdfR0VORVJJQ19DUFU9eQpDT05GSUdfWDg2X0lOVEVSTk9ERV9DQUNIRV9T
SElGVD02CkNPTkZJR19YODZfTDFfQ0FDSEVfU0hJRlQ9NgpDT05GSUdfWDg2X1RTQz15CkNP
TkZJR19YODZfSEFWRV9QQUU9eQpDT05GSUdfWDg2X0NNUFhDSEc2ND15CkNPTkZJR19YODZf
Q01PVj15CkNPTkZJR19YODZfTUlOSU1VTV9DUFVfRkFNSUxZPTY0CkNPTkZJR19YODZfREVC
VUdDVExNU1I9eQpDT05GSUdfSUEzMl9GRUFUX0NUTD15CkNPTkZJR19YODZfVk1YX0ZFQVRV
UkVfTkFNRVM9eQpDT05GSUdfQ1BVX1NVUF9JTlRFTD15CkNPTkZJR19DUFVfU1VQX0FNRD15
CkNPTkZJR19DUFVfU1VQX0hZR09OPXkKQ09ORklHX0NQVV9TVVBfQ0VOVEFVUj15CkNPTkZJ
R19DUFVfU1VQX1pIQU9YSU49eQpDT05GSUdfSFBFVF9USU1FUj15CkNPTkZJR19IUEVUX0VN
VUxBVEVfUlRDPXkKQ09ORklHX0RNST15CiMgQ09ORklHX0dBUlRfSU9NTVUgaXMgbm90IHNl
dApDT05GSUdfQk9PVF9WRVNBX1NVUFBPUlQ9eQojIENPTkZJR19NQVhTTVAgaXMgbm90IHNl
dApDT05GSUdfTlJfQ1BVU19SQU5HRV9CRUdJTj0yCkNPTkZJR19OUl9DUFVTX1JBTkdFX0VO
RD01MTIKQ09ORklHX05SX0NQVVNfREVGQVVMVD02NApDT05GSUdfTlJfQ1BVUz0zMjAKQ09O
RklHX1NDSEVEX0NMVVNURVI9eQpDT05GSUdfU0NIRURfU01UPXkKQ09ORklHX1NDSEVEX01D
PXkKQ09ORklHX1NDSEVEX01DX1BSSU89eQpDT05GSUdfWDg2X0xPQ0FMX0FQSUM9eQpDT05G
SUdfWDg2X0lPX0FQSUM9eQpDT05GSUdfWDg2X1JFUk9VVEVfRk9SX0JST0tFTl9CT09UX0lS
UVM9eQpDT05GSUdfWDg2X01DRT15CiMgQ09ORklHX1g4Nl9NQ0VMT0dfTEVHQUNZIGlzIG5v
dCBzZXQKQ09ORklHX1g4Nl9NQ0VfSU5URUw9eQpDT05GSUdfWDg2X01DRV9BTUQ9eQpDT05G
SUdfWDg2X01DRV9USFJFU0hPTEQ9eQojIENPTkZJR19YODZfTUNFX0lOSkVDVCBpcyBub3Qg
c2V0CgojCiMgUGVyZm9ybWFuY2UgbW9uaXRvcmluZwojCiMgQ09ORklHX1BFUkZfRVZFTlRT
X0lOVEVMX1VOQ09SRSBpcyBub3Qgc2V0CkNPTkZJR19QRVJGX0VWRU5UU19JTlRFTF9SQVBM
PW0KIyBDT05GSUdfUEVSRl9FVkVOVFNfSU5URUxfQ1NUQVRFIGlzIG5vdCBzZXQKIyBDT05G
SUdfUEVSRl9FVkVOVFNfQU1EX1BPV0VSIGlzIG5vdCBzZXQKIyBDT05GSUdfUEVSRl9FVkVO
VFNfQU1EX1VOQ09SRSBpcyBub3Qgc2V0CkNPTkZJR19QRVJGX0VWRU5UU19BTURfQlJTPXkK
IyBlbmQgb2YgUGVyZm9ybWFuY2UgbW9uaXRvcmluZwoKQ09ORklHX1g4Nl8xNkJJVD15CkNP
TkZJR19YODZfRVNQRklYNjQ9eQpDT05GSUdfWDg2X1ZTWVNDQUxMX0VNVUxBVElPTj15CkNP
TkZJR19YODZfSU9QTF9JT1BFUk09eQpDT05GSUdfTUlDUk9DT0RFPXkKIyBDT05GSUdfTUlD
Uk9DT0RFX0xBVEVfTE9BRElORyBpcyBub3Qgc2V0CiMgQ09ORklHX1g4Nl9NU1IgaXMgbm90
IHNldAojIENPTkZJR19YODZfQ1BVSUQgaXMgbm90IHNldApDT05GSUdfWDg2XzVMRVZFTD15
CkNPTkZJR19YODZfRElSRUNUX0dCUEFHRVM9eQojIENPTkZJR19YODZfQ1BBX1NUQVRJU1RJ
Q1MgaXMgbm90IHNldApDT05GSUdfWDg2X01FTV9FTkNSWVBUPXkKQ09ORklHX0FNRF9NRU1f
RU5DUllQVD15CkNPTkZJR19OVU1BPXkKQ09ORklHX0FNRF9OVU1BPXkKQ09ORklHX1g4Nl82
NF9BQ1BJX05VTUE9eQojIENPTkZJR19OVU1BX0VNVSBpcyBub3Qgc2V0CkNPTkZJR19OT0RF
U19TSElGVD01CkNPTkZJR19BUkNIX1NQQVJTRU1FTV9FTkFCTEU9eQpDT05GSUdfQVJDSF9T
UEFSU0VNRU1fREVGQVVMVD15CiMgQ09ORklHX0FSQ0hfTUVNT1JZX1BST0JFIGlzIG5vdCBz
ZXQKQ09ORklHX0lMTEVHQUxfUE9JTlRFUl9WQUxVRT0weGRlYWQwMDAwMDAwMDAwMDAKIyBD
T05GSUdfWDg2X1BNRU1fTEVHQUNZIGlzIG5vdCBzZXQKQ09ORklHX1g4Nl9DSEVDS19CSU9T
X0NPUlJVUFRJT049eQpDT05GSUdfWDg2X0JPT1RQQVJBTV9NRU1PUllfQ09SUlVQVElPTl9D
SEVDSz15CkNPTkZJR19NVFJSPXkKQ09ORklHX01UUlJfU0FOSVRJWkVSPXkKQ09ORklHX01U
UlJfU0FOSVRJWkVSX0VOQUJMRV9ERUZBVUxUPTEKQ09ORklHX01UUlJfU0FOSVRJWkVSX1NQ
QVJFX1JFR19OUl9ERUZBVUxUPTAKQ09ORklHX1g4Nl9QQVQ9eQpDT05GSUdfQVJDSF9VU0VT
X1BHX1VOQ0FDSEVEPXkKQ09ORklHX1g4Nl9VTUlQPXkKQ09ORklHX0NDX0hBU19JQlQ9eQpD
T05GSUdfWDg2X0NFVD15CkNPTkZJR19YODZfS0VSTkVMX0lCVD15CkNPTkZJR19YODZfSU5U
RUxfTUVNT1JZX1BST1RFQ1RJT05fS0VZUz15CiMgQ09ORklHX1g4Nl9JTlRFTF9UU1hfTU9E
RV9PRkYgaXMgbm90IHNldAojIENPTkZJR19YODZfSU5URUxfVFNYX01PREVfT04gaXMgbm90
IHNldApDT05GSUdfWDg2X0lOVEVMX1RTWF9NT0RFX0FVVE89eQpDT05GSUdfWDg2X1NHWD15
CkNPTkZJR19YODZfVVNFUl9TSEFET1dfU1RBQ0s9eQpDT05GSUdfSU5URUxfVERYX0hPU1Q9
eQpDT05GSUdfRUZJPXkKQ09ORklHX0VGSV9TVFVCPXkKQ09ORklHX0VGSV9IQU5ET1ZFUl9Q
Uk9UT0NPTD15CkNPTkZJR19FRklfTUlYRUQ9eQojIENPTkZJR19FRklfRkFLRV9NRU1NQVAg
aXMgbm90IHNldAojIENPTkZJR19IWl8xMDAgaXMgbm90IHNldAojIENPTkZJR19IWl8yNTAg
aXMgbm90IHNldApDT05GSUdfSFpfMzAwPXkKIyBDT05GSUdfSFpfMTAwMCBpcyBub3Qgc2V0
CkNPTkZJR19IWj0zMDAKQ09ORklHX1NDSEVEX0hSVElDSz15CkNPTkZJR19BUkNIX1NVUFBP
UlRTX0tFWEVDPXkKQ09ORklHX0FSQ0hfU1VQUE9SVFNfS0VYRUNfRklMRT15CkNPTkZJR19B
UkNIX1NVUFBPUlRTX0tFWEVDX1BVUkdBVE9SWT15CkNPTkZJR19BUkNIX1NVUFBPUlRTX0tF
WEVDX1NJRz15CkNPTkZJR19BUkNIX1NVUFBPUlRTX0tFWEVDX1NJR19GT1JDRT15CkNPTkZJ
R19BUkNIX1NVUFBPUlRTX0tFWEVDX0JaSU1BR0VfVkVSSUZZX1NJRz15CkNPTkZJR19BUkNI
X1NVUFBPUlRTX0tFWEVDX0pVTVA9eQpDT05GSUdfQVJDSF9TVVBQT1JUU19DUkFTSF9EVU1Q
PXkKQ09ORklHX0FSQ0hfU1VQUE9SVFNfQ1JBU0hfSE9UUExVRz15CkNPTkZJR19QSFlTSUNB
TF9TVEFSVD0weDEwMDAwMDAKQ09ORklHX1JFTE9DQVRBQkxFPXkKQ09ORklHX1JBTkRPTUla
RV9CQVNFPXkKQ09ORklHX1g4Nl9ORUVEX1JFTE9DUz15CkNPTkZJR19QSFlTSUNBTF9BTElH
Tj0weDEwMDAwMDAKQ09ORklHX0RZTkFNSUNfTUVNT1JZX0xBWU9VVD15CkNPTkZJR19SQU5E
T01JWkVfTUVNT1JZPXkKQ09ORklHX1JBTkRPTUlaRV9NRU1PUllfUEhZU0lDQUxfUEFERElO
Rz0weGEKIyBDT05GSUdfQUREUkVTU19NQVNLSU5HIGlzIG5vdCBzZXQKQ09ORklHX0hPVFBM
VUdfQ1BVPXkKIyBDT05GSUdfQ09NUEFUX1ZEU08gaXMgbm90IHNldAojIENPTkZJR19MRUdB
Q1lfVlNZU0NBTExfWE9OTFkgaXMgbm90IHNldApDT05GSUdfTEVHQUNZX1ZTWVNDQUxMX05P
TkU9eQpDT05GSUdfQ01ETElORV9CT09MPXkKQ09ORklHX0NNRExJTkU9InB0aT1vbiBwYWdl
X2FsbG9jLnNodWZmbGU9MSIKIyBDT05GSUdfQ01ETElORV9PVkVSUklERSBpcyBub3Qgc2V0
CkNPTkZJR19NT0RJRllfTERUX1NZU0NBTEw9eQojIENPTkZJR19TVFJJQ1RfU0lHQUxUU1RB
Q0tfU0laRSBpcyBub3Qgc2V0CkNPTkZJR19IQVZFX0xJVkVQQVRDSD15CiMgQ09ORklHX0xJ
VkVQQVRDSCBpcyBub3Qgc2V0CiMgZW5kIG9mIFByb2Nlc3NvciB0eXBlIGFuZCBmZWF0dXJl
cwoKQ09ORklHX0NDX0hBU19TTFM9eQpDT05GSUdfQ0NfSEFTX1JFVFVSTl9USFVOSz15CkNP
TkZJR19DQ19IQVNfRU5UUllfUEFERElORz15CkNPTkZJR19GVU5DVElPTl9QQURESU5HX0NG
ST0xMQpDT05GSUdfRlVOQ1RJT05fUEFERElOR19CWVRFUz0xNgpDT05GSUdfQ0FMTF9QQURE
SU5HPXkKQ09ORklHX0hBVkVfQ0FMTF9USFVOS1M9eQpDT05GSUdfQ0FMTF9USFVOS1M9eQpD
T05GSUdfUFJFRklYX1NZTUJPTFM9eQpDT05GSUdfU1BFQ1VMQVRJT05fTUlUSUdBVElPTlM9
eQpDT05GSUdfUEFHRV9UQUJMRV9JU09MQVRJT049eQpDT05GSUdfUkVUUE9MSU5FPXkKQ09O
RklHX1JFVEhVTks9eQpDT05GSUdfQ1BVX1VOUkVUX0VOVFJZPXkKQ09ORklHX0NBTExfREVQ
VEhfVFJBQ0tJTkc9eQojIENPTkZJR19DQUxMX1RIVU5LU19ERUJVRyBpcyBub3Qgc2V0CkNP
TkZJR19DUFVfSUJQQl9FTlRSWT15CkNPTkZJR19DUFVfSUJSU19FTlRSWT15CkNPTkZJR19D
UFVfU1JTTz15CkNPTkZJR19TTFM9eQpDT05GSUdfR0RTX0ZPUkNFX01JVElHQVRJT049eQpD
T05GSUdfTUlUSUdBVElPTl9SRkRTPXkKQ09ORklHX0FSQ0hfSEFTX0FERF9QQUdFUz15Cgoj
CiMgUG93ZXIgbWFuYWdlbWVudCBhbmQgQUNQSSBvcHRpb25zCiMKQ09ORklHX1NVU1BFTkQ9
eQpDT05GSUdfU1VTUEVORF9GUkVFWkVSPXkKQ09ORklHX0hJQkVSTkFURV9DQUxMQkFDS1M9
eQojIENPTkZJR19ISUJFUk5BVElPTiBpcyBub3Qgc2V0CkNPTkZJR19QTV9TTEVFUD15CkNP
TkZJR19QTV9TTEVFUF9TTVA9eQojIENPTkZJR19QTV9BVVRPU0xFRVAgaXMgbm90IHNldAoj
IENPTkZJR19QTV9VU0VSU1BBQ0VfQVVUT1NMRUVQIGlzIG5vdCBzZXQKIyBDT05GSUdfUE1f
V0FLRUxPQ0tTIGlzIG5vdCBzZXQKQ09ORklHX1BNPXkKQ09ORklHX1BNX0RFQlVHPXkKIyBD
T05GSUdfUE1fQURWQU5DRURfREVCVUcgaXMgbm90IHNldAojIENPTkZJR19QTV9URVNUX1NV
U1BFTkQgaXMgbm90IHNldApDT05GSUdfUE1fU0xFRVBfREVCVUc9eQpDT05GSUdfUE1fVFJB
Q0U9eQpDT05GSUdfUE1fVFJBQ0VfUlRDPXkKQ09ORklHX1BNX0NMSz15CkNPTkZJR19XUV9Q
T1dFUl9FRkZJQ0lFTlRfREVGQVVMVD15CkNPTkZJR19FTkVSR1lfTU9ERUw9eQpDT05GSUdf
QVJDSF9TVVBQT1JUU19BQ1BJPXkKQ09ORklHX0FDUEk9eQpDT05GSUdfQUNQSV9MRUdBQ1lf
VEFCTEVTX0xPT0tVUD15CkNPTkZJR19BUkNIX01JR0hUX0hBVkVfQUNQSV9QREM9eQpDT05G
SUdfQUNQSV9TWVNURU1fUE9XRVJfU1RBVEVTX1NVUFBPUlQ9eQpDT05GSUdfQUNQSV9USEVS
TUFMX0xJQj15CiMgQ09ORklHX0FDUElfREVCVUdHRVIgaXMgbm90IHNldApDT05GSUdfQUNQ
SV9TUENSX1RBQkxFPXkKQ09ORklHX0FDUElfRlBEVD15CkNPTkZJR19BQ1BJX0xQSVQ9eQpD
T05GSUdfQUNQSV9TTEVFUD15CkNPTkZJR19BQ1BJX1JFVl9PVkVSUklERV9QT1NTSUJMRT15
CiMgQ09ORklHX0FDUElfRUNfREVCVUdGUyBpcyBub3Qgc2V0CiMgQ09ORklHX0FDUElfQUMg
aXMgbm90IHNldAojIENPTkZJR19BQ1BJX0JBVFRFUlkgaXMgbm90IHNldApDT05GSUdfQUNQ
SV9CVVRUT049eQpDT05GSUdfQUNQSV9GQU49eQojIENPTkZJR19BQ1BJX1RBRCBpcyBub3Qg
c2V0CkNPTkZJR19BQ1BJX0RPQ0s9eQpDT05GSUdfQUNQSV9DUFVfRlJFUV9QU1M9eQpDT05G
SUdfQUNQSV9QUk9DRVNTT1JfQ1NUQVRFPXkKQ09ORklHX0FDUElfUFJPQ0VTU09SX0lETEU9
eQpDT05GSUdfQUNQSV9DUFBDX0xJQj15CkNPTkZJR19BQ1BJX1BST0NFU1NPUj15CkNPTkZJ
R19BQ1BJX0hPVFBMVUdfQ1BVPXkKIyBDT05GSUdfQUNQSV9QUk9DRVNTT1JfQUdHUkVHQVRP
UiBpcyBub3Qgc2V0CkNPTkZJR19BQ1BJX1RIRVJNQUw9eQpDT05GSUdfQVJDSF9IQVNfQUNQ
SV9UQUJMRV9VUEdSQURFPXkKQ09ORklHX0FDUElfVEFCTEVfVVBHUkFERT15CiMgQ09ORklH
X0FDUElfREVCVUcgaXMgbm90IHNldApDT05GSUdfQUNQSV9QQ0lfU0xPVD15CkNPTkZJR19B
Q1BJX0NPTlRBSU5FUj15CkNPTkZJR19BQ1BJX0hPVFBMVUdfTUVNT1JZPXkKQ09ORklHX0FD
UElfSE9UUExVR19JT0FQSUM9eQojIENPTkZJR19BQ1BJX1NCUyBpcyBub3Qgc2V0CkNPTkZJ
R19BQ1BJX0hFRD15CiMgQ09ORklHX0FDUElfQ1VTVE9NX01FVEhPRCBpcyBub3Qgc2V0CkNP
TkZJR19BQ1BJX0JHUlQ9eQojIENPTkZJR19BQ1BJX05GSVQgaXMgbm90IHNldApDT05GSUdf
QUNQSV9OVU1BPXkKQ09ORklHX0FDUElfSE1BVD15CkNPTkZJR19IQVZFX0FDUElfQVBFST15
CkNPTkZJR19IQVZFX0FDUElfQVBFSV9OTUk9eQpDT05GSUdfQUNQSV9BUEVJPXkKQ09ORklH
X0FDUElfQVBFSV9HSEVTPXkKQ09ORklHX0FDUElfQVBFSV9QQ0lFQUVSPXkKQ09ORklHX0FD
UElfQVBFSV9NRU1PUllfRkFJTFVSRT15CiMgQ09ORklHX0FDUElfQVBFSV9FSU5KIGlzIG5v
dCBzZXQKIyBDT05GSUdfQUNQSV9BUEVJX0VSU1RfREVCVUcgaXMgbm90IHNldApDT05GSUdf
QUNQSV9EUFRGPXkKIyBDT05GSUdfRFBURl9QT1dFUiBpcyBub3Qgc2V0CiMgQ09ORklHX0RQ
VEZfUENIX0ZJVlIgaXMgbm90IHNldAojIENPTkZJR19BQ1BJX0VYVExPRyBpcyBub3Qgc2V0
CiMgQ09ORklHX0FDUElfQ09ORklHRlMgaXMgbm90IHNldAojIENPTkZJR19BQ1BJX1BGUlVU
IGlzIG5vdCBzZXQKQ09ORklHX0FDUElfUENDPXkKQ09ORklHX0FDUElfRkZIPXkKQ09ORklH
X1BNSUNfT1BSRUdJT049eQpDT05GSUdfQllUQ1JDX1BNSUNfT1BSRUdJT049eQpDT05GSUdf
Q0hUQ1JDX1BNSUNfT1BSRUdJT049eQpDT05GSUdfQ0hUX1dDX1BNSUNfT1BSRUdJT049eQpD
T05GSUdfQUNQSV9QUk1UPXkKQ09ORklHX1g4Nl9QTV9USU1FUj15CgojCiMgQ1BVIEZyZXF1
ZW5jeSBzY2FsaW5nCiMKQ09ORklHX0NQVV9GUkVRPXkKQ09ORklHX0NQVV9GUkVRX0dPVl9B
VFRSX1NFVD15CkNPTkZJR19DUFVfRlJFUV9HT1ZfQ09NTU9OPXkKQ09ORklHX0NQVV9GUkVR
X1NUQVQ9eQojIENPTkZJR19DUFVfRlJFUV9ERUZBVUxUX0dPVl9QRVJGT1JNQU5DRSBpcyBu
b3Qgc2V0CiMgQ09ORklHX0NQVV9GUkVRX0RFRkFVTFRfR09WX1BPV0VSU0FWRSBpcyBub3Qg
c2V0CiMgQ09ORklHX0NQVV9GUkVRX0RFRkFVTFRfR09WX1VTRVJTUEFDRSBpcyBub3Qgc2V0
CkNPTkZJR19DUFVfRlJFUV9ERUZBVUxUX0dPVl9TQ0hFRFVUSUw9eQpDT05GSUdfQ1BVX0ZS
RVFfR09WX1BFUkZPUk1BTkNFPXkKQ09ORklHX0NQVV9GUkVRX0dPVl9QT1dFUlNBVkU9eQpD
T05GSUdfQ1BVX0ZSRVFfR09WX1VTRVJTUEFDRT15CkNPTkZJR19DUFVfRlJFUV9HT1ZfT05E
RU1BTkQ9eQpDT05GSUdfQ1BVX0ZSRVFfR09WX0NPTlNFUlZBVElWRT15CkNPTkZJR19DUFVf
RlJFUV9HT1ZfU0NIRURVVElMPXkKCiMKIyBDUFUgZnJlcXVlbmN5IHNjYWxpbmcgZHJpdmVy
cwojCkNPTkZJR19YODZfSU5URUxfUFNUQVRFPXkKIyBDT05GSUdfWDg2X1BDQ19DUFVGUkVR
IGlzIG5vdCBzZXQKQ09ORklHX1g4Nl9BTURfUFNUQVRFPXkKQ09ORklHX1g4Nl9BTURfUFNU
QVRFX0RFRkFVTFRfTU9ERT0zCiMgQ09ORklHX1g4Nl9BTURfUFNUQVRFX1VUIGlzIG5vdCBz
ZXQKIyBDT05GSUdfWDg2X0FDUElfQ1BVRlJFUSBpcyBub3Qgc2V0CiMgQ09ORklHX1g4Nl9T
UEVFRFNURVBfQ0VOVFJJTk8gaXMgbm90IHNldAojIENPTkZJR19YODZfUDRfQ0xPQ0tNT0Qg
aXMgbm90IHNldAoKIwojIHNoYXJlZCBvcHRpb25zCiMKIyBlbmQgb2YgQ1BVIEZyZXF1ZW5j
eSBzY2FsaW5nCgojCiMgQ1BVIElkbGUKIwpDT05GSUdfQ1BVX0lETEU9eQpDT05GSUdfQ1BV
X0lETEVfR09WX0xBRERFUj15CkNPTkZJR19DUFVfSURMRV9HT1ZfTUVOVT15CkNPTkZJR19D
UFVfSURMRV9HT1ZfVEVPPXkKQ09ORklHX0NQVV9JRExFX0dPVl9IQUxUUE9MTD15CiMgQ09O
RklHX0hBTFRQT0xMX0NQVUlETEUgaXMgbm90IHNldAojIGVuZCBvZiBDUFUgSWRsZQoKQ09O
RklHX0lOVEVMX0lETEU9eQojIGVuZCBvZiBQb3dlciBtYW5hZ2VtZW50IGFuZCBBQ1BJIG9w
dGlvbnMKCiMKIyBCdXMgb3B0aW9ucyAoUENJIGV0Yy4pCiMKQ09ORklHX1BDSV9ESVJFQ1Q9
eQpDT05GSUdfUENJX01NQ09ORklHPXkKQ09ORklHX1BDSV9YRU49eQpDT05GSUdfTU1DT05G
X0ZBTTEwSD15CkNPTkZJR19JU0FfRE1BX0FQST15CkNPTkZJR19BTURfTkI9eQojIGVuZCBv
ZiBCdXMgb3B0aW9ucyAoUENJIGV0Yy4pCgojCiMgQmluYXJ5IEVtdWxhdGlvbnMKIwpDT05G
SUdfSUEzMl9FTVVMQVRJT049eQpDT05GSUdfSUEzMl9FTVVMQVRJT05fREVGQVVMVF9ESVNB
QkxFRD15CiMgQ09ORklHX1g4Nl9YMzJfQUJJIGlzIG5vdCBzZXQKQ09ORklHX0NPTVBBVF8z
Mj15CkNPTkZJR19DT01QQVQ9eQpDT05GSUdfQ09NUEFUX0ZPUl9VNjRfQUxJR05NRU5UPXkK
IyBlbmQgb2YgQmluYXJ5IEVtdWxhdGlvbnMKCkNPTkZJR19IQVZFX0tWTT15CkNPTkZJR19L
Vk1fQ09NTU9OPXkKQ09ORklHX0hBVkVfS1ZNX1BGTkNBQ0hFPXkKQ09ORklHX0hBVkVfS1ZN
X0lSUUNISVA9eQpDT05GSUdfSEFWRV9LVk1fSVJRX1JPVVRJTkc9eQpDT05GSUdfSEFWRV9L
Vk1fRElSVFlfUklORz15CkNPTkZJR19IQVZFX0tWTV9ESVJUWV9SSU5HX1RTTz15CkNPTkZJ
R19IQVZFX0tWTV9ESVJUWV9SSU5HX0FDUV9SRUw9eQpDT05GSUdfS1ZNX01NSU89eQpDT05G
SUdfS1ZNX0FTWU5DX1BGPXkKQ09ORklHX0hBVkVfS1ZNX01TST15CkNPTkZJR19IQVZFX0tW
TV9DUFVfUkVMQVhfSU5URVJDRVBUPXkKQ09ORklHX0tWTV9WRklPPXkKQ09ORklHX0tWTV9H
RU5FUklDX0RJUlRZTE9HX1JFQURfUFJPVEVDVD15CkNPTkZJR19LVk1fQ09NUEFUPXkKQ09O
RklHX0hBVkVfS1ZNX0lSUV9CWVBBU1M9eQpDT05GSUdfSEFWRV9LVk1fTk9fUE9MTD15CkNP
TkZJR19LVk1fWEZFUl9UT19HVUVTVF9XT1JLPXkKQ09ORklHX0hBVkVfS1ZNX1BNX05PVElG
SUVSPXkKQ09ORklHX0tWTV9HRU5FUklDX0hBUkRXQVJFX0VOQUJMSU5HPXkKQ09ORklHX0tW
TV9HRU5FUklDX01NVV9OT1RJRklFUj15CkNPTkZJR19WSVJUVUFMSVpBVElPTj15CkNPTkZJ
R19LVk09bQpDT05GSUdfS1ZNX0lOVEVMPW0KQ09ORklHX1g4Nl9TR1hfS1ZNPXkKIyBDT05G
SUdfS1ZNX0FNRCBpcyBub3Qgc2V0CkNPTkZJR19LVk1fU01NPXkKQ09ORklHX0tWTV9IWVBF
UlY9eQpDT05GSUdfS1ZNX1hFTj15CkNPTkZJR19LVk1fTUFYX05SX1ZDUFVTPTEwMjQKQ09O
RklHX0FTX0FWWDUxMj15CkNPTkZJR19BU19TSEExX05JPXkKQ09ORklHX0FTX1NIQTI1Nl9O
ST15CkNPTkZJR19BU19UUEFVU0U9eQpDT05GSUdfQVNfR0ZOST15CkNPTkZJR19BU19XUlVT
Uz15CgojCiMgR2VuZXJhbCBhcmNoaXRlY3R1cmUtZGVwZW5kZW50IG9wdGlvbnMKIwpDT05G
SUdfSE9UUExVR19TTVQ9eQpDT05GSUdfSE9UUExVR19DT1JFX1NZTkM9eQpDT05GSUdfSE9U
UExVR19DT1JFX1NZTkNfREVBRD15CkNPTkZJR19IT1RQTFVHX0NPUkVfU1lOQ19GVUxMPXkK
Q09ORklHX0hPVFBMVUdfU1BMSVRfU1RBUlRVUD15CkNPTkZJR19IT1RQTFVHX1BBUkFMTEVM
PXkKQ09ORklHX0dFTkVSSUNfRU5UUlk9eQpDT05GSUdfS1BST0JFUz15CkNPTkZJR19KVU1Q
X0xBQkVMPXkKIyBDT05GSUdfU1RBVElDX0tFWVNfU0VMRlRFU1QgaXMgbm90IHNldAojIENP
TkZJR19TVEFUSUNfQ0FMTF9TRUxGVEVTVCBpcyBub3Qgc2V0CkNPTkZJR19PUFRQUk9CRVM9
eQpDT05GSUdfS1BST0JFU19PTl9GVFJBQ0U9eQpDT05GSUdfVVBST0JFUz15CkNPTkZJR19I
QVZFX0VGRklDSUVOVF9VTkFMSUdORURfQUNDRVNTPXkKQ09ORklHX0FSQ0hfVVNFX0JVSUxU
SU5fQlNXQVA9eQpDT05GSUdfS1JFVFBST0JFUz15CkNPTkZJR19LUkVUUFJPQkVfT05fUkVU
SE9PSz15CkNPTkZJR19VU0VSX1JFVFVSTl9OT1RJRklFUj15CkNPTkZJR19IQVZFX0lPUkVN
QVBfUFJPVD15CkNPTkZJR19IQVZFX0tQUk9CRVM9eQpDT05GSUdfSEFWRV9LUkVUUFJPQkVT
PXkKQ09ORklHX0hBVkVfT1BUUFJPQkVTPXkKQ09ORklHX0hBVkVfS1BST0JFU19PTl9GVFJB
Q0U9eQpDT05GSUdfQVJDSF9DT1JSRUNUX1NUQUNLVFJBQ0VfT05fS1JFVFBST0JFPXkKQ09O
RklHX0hBVkVfRlVOQ1RJT05fRVJST1JfSU5KRUNUSU9OPXkKQ09ORklHX0hBVkVfTk1JPXkK
Q09ORklHX1RSQUNFX0lSUUZMQUdTX1NVUFBPUlQ9eQpDT05GSUdfVFJBQ0VfSVJRRkxBR1Nf
Tk1JX1NVUFBPUlQ9eQpDT05GSUdfSEFWRV9BUkNIX1RSQUNFSE9PSz15CkNPTkZJR19IQVZF
X0RNQV9DT05USUdVT1VTPXkKQ09ORklHX0dFTkVSSUNfU01QX0lETEVfVEhSRUFEPXkKQ09O
RklHX0FSQ0hfSEFTX0ZPUlRJRllfU09VUkNFPXkKQ09ORklHX0FSQ0hfSEFTX1NFVF9NRU1P
Ulk9eQpDT05GSUdfQVJDSF9IQVNfU0VUX0RJUkVDVF9NQVA9eQpDT05GSUdfQVJDSF9IQVNf
Q1BVX0ZJTkFMSVpFX0lOSVQ9eQpDT05GSUdfQVJDSF9IQVNfQ1BVX1BBU0lEPXkKQ09ORklH
X0hBVkVfQVJDSF9USFJFQURfU1RSVUNUX1dISVRFTElTVD15CkNPTkZJR19BUkNIX1dBTlRT
X0RZTkFNSUNfVEFTS19TVFJVQ1Q9eQpDT05GSUdfQVJDSF9XQU5UU19OT19JTlNUUj15CkNP
TkZJR19IQVZFX0FTTV9NT0RWRVJTSU9OUz15CkNPTkZJR19IQVZFX1JFR1NfQU5EX1NUQUNL
X0FDQ0VTU19BUEk9eQpDT05GSUdfSEFWRV9SU0VRPXkKQ09ORklHX0hBVkVfUlVTVD15CkNP
TkZJR19IQVZFX0ZVTkNUSU9OX0FSR19BQ0NFU1NfQVBJPXkKQ09ORklHX0hBVkVfSFdfQlJF
QUtQT0lOVD15CkNPTkZJR19IQVZFX01JWEVEX0JSRUFLUE9JTlRTX1JFR1M9eQpDT05GSUdf
SEFWRV9VU0VSX1JFVFVSTl9OT1RJRklFUj15CkNPTkZJR19IQVZFX1BFUkZfRVZFTlRTX05N
ST15CkNPTkZJR19IQVZFX0hBUkRMT0NLVVBfREVURUNUT1JfUEVSRj15CkNPTkZJR19IQVZF
X1BFUkZfUkVHUz15CkNPTkZJR19IQVZFX1BFUkZfVVNFUl9TVEFDS19EVU1QPXkKQ09ORklH
X0hBVkVfQVJDSF9KVU1QX0xBQkVMPXkKQ09ORklHX0hBVkVfQVJDSF9KVU1QX0xBQkVMX1JF
TEFUSVZFPXkKQ09ORklHX01NVV9HQVRIRVJfVEFCTEVfRlJFRT15CkNPTkZJR19NTVVfR0FU
SEVSX1JDVV9UQUJMRV9GUkVFPXkKQ09ORklHX01NVV9HQVRIRVJfTUVSR0VfVk1BUz15CkNP
TkZJR19NTVVfTEFaWV9UTEJfUkVGQ09VTlQ9eQpDT05GSUdfQVJDSF9IQVZFX05NSV9TQUZF
X0NNUFhDSEc9eQpDT05GSUdfQVJDSF9IQVNfTk1JX1NBRkVfVEhJU19DUFVfT1BTPXkKQ09O
RklHX0hBVkVfQUxJR05FRF9TVFJVQ1RfUEFHRT15CkNPTkZJR19IQVZFX0NNUFhDSEdfTE9D
QUw9eQpDT05GSUdfSEFWRV9DTVBYQ0hHX0RPVUJMRT15CkNPTkZJR19BUkNIX1dBTlRfQ09N
UEFUX0lQQ19QQVJTRV9WRVJTSU9OPXkKQ09ORklHX0FSQ0hfV0FOVF9PTERfQ09NUEFUX0lQ
Qz15CkNPTkZJR19IQVZFX0FSQ0hfU0VDQ09NUD15CkNPTkZJR19IQVZFX0FSQ0hfU0VDQ09N
UF9GSUxURVI9eQpDT05GSUdfU0VDQ09NUD15CkNPTkZJR19TRUNDT01QX0ZJTFRFUj15CiMg
Q09ORklHX1NFQ0NPTVBfQ0FDSEVfREVCVUcgaXMgbm90IHNldApDT05GSUdfSEFWRV9BUkNI
X1NUQUNLTEVBSz15CkNPTkZJR19IQVZFX1NUQUNLUFJPVEVDVE9SPXkKQ09ORklHX1NUQUNL
UFJPVEVDVE9SPXkKQ09ORklHX1NUQUNLUFJPVEVDVE9SX1NUUk9ORz15CkNPTkZJR19BUkNI
X1NVUFBPUlRTX0xUT19DTEFORz15CkNPTkZJR19BUkNIX1NVUFBPUlRTX0xUT19DTEFOR19U
SElOPXkKQ09ORklHX0xUT19OT05FPXkKQ09ORklHX0FSQ0hfU1VQUE9SVFNfQ0ZJX0NMQU5H
PXkKQ09ORklHX0hBVkVfQVJDSF9XSVRISU5fU1RBQ0tfRlJBTUVTPXkKQ09ORklHX0hBVkVf
Q09OVEVYVF9UUkFDS0lOR19VU0VSPXkKQ09ORklHX0hBVkVfQ09OVEVYVF9UUkFDS0lOR19V
U0VSX09GRlNUQUNLPXkKQ09ORklHX0hBVkVfVklSVF9DUFVfQUNDT1VOVElOR19HRU49eQpD
T05GSUdfSEFWRV9JUlFfVElNRV9BQ0NPVU5USU5HPXkKQ09ORklHX0hBVkVfTU9WRV9QVUQ9
eQpDT05GSUdfSEFWRV9NT1ZFX1BNRD15CkNPTkZJR19IQVZFX0FSQ0hfVFJBTlNQQVJFTlRf
SFVHRVBBR0U9eQpDT05GSUdfSEFWRV9BUkNIX1RSQU5TUEFSRU5UX0hVR0VQQUdFX1BVRD15
CkNPTkZJR19IQVZFX0FSQ0hfSFVHRV9WTUFQPXkKQ09ORklHX0hBVkVfQVJDSF9IVUdFX1ZN
QUxMT0M9eQpDT05GSUdfQVJDSF9XQU5UX0hVR0VfUE1EX1NIQVJFPXkKQ09ORklHX0FSQ0hf
V0FOVF9QTURfTUtXUklURT15CkNPTkZJR19IQVZFX0FSQ0hfU09GVF9ESVJUWT15CkNPTkZJ
R19IQVZFX01PRF9BUkNIX1NQRUNJRklDPXkKQ09ORklHX01PRFVMRVNfVVNFX0VMRl9SRUxB
PXkKQ09ORklHX0hBVkVfSVJRX0VYSVRfT05fSVJRX1NUQUNLPXkKQ09ORklHX0hBVkVfU09G
VElSUV9PTl9PV05fU1RBQ0s9eQpDT05GSUdfU09GVElSUV9PTl9PV05fU1RBQ0s9eQpDT05G
SUdfQVJDSF9IQVNfRUxGX1JBTkRPTUlaRT15CkNPTkZJR19IQVZFX0FSQ0hfTU1BUF9STkRf
QklUUz15CkNPTkZJR19IQVZFX0VYSVRfVEhSRUFEPXkKQ09ORklHX0FSQ0hfTU1BUF9STkRf
QklUUz0yOApDT05GSUdfSEFWRV9BUkNIX01NQVBfUk5EX0NPTVBBVF9CSVRTPXkKQ09ORklH
X0FSQ0hfTU1BUF9STkRfQ09NUEFUX0JJVFM9OApDT05GSUdfSEFWRV9BUkNIX0NPTVBBVF9N
TUFQX0JBU0VTPXkKQ09ORklHX1BBR0VfU0laRV9MRVNTX1RIQU5fNjRLQj15CkNPTkZJR19Q
QUdFX1NJWkVfTEVTU19USEFOXzI1NktCPXkKQ09ORklHX0hBVkVfT0JKVE9PTD15CkNPTkZJ
R19IQVZFX0pVTVBfTEFCRUxfSEFDSz15CkNPTkZJR19IQVZFX05PSU5TVFJfSEFDSz15CkNP
TkZJR19IQVZFX05PSU5TVFJfVkFMSURBVElPTj15CkNPTkZJR19IQVZFX1VBQ0NFU1NfVkFM
SURBVElPTj15CkNPTkZJR19IQVZFX1NUQUNLX1ZBTElEQVRJT049eQpDT05GSUdfSEFWRV9S
RUxJQUJMRV9TVEFDS1RSQUNFPXkKQ09ORklHX09MRF9TSUdTVVNQRU5EMz15CkNPTkZJR19D
T01QQVRfT0xEX1NJR0FDVElPTj15CkNPTkZJR19DT01QQVRfMzJCSVRfVElNRT15CkNPTkZJ
R19IQVZFX0FSQ0hfVk1BUF9TVEFDSz15CkNPTkZJR19WTUFQX1NUQUNLPXkKQ09ORklHX0hB
VkVfQVJDSF9SQU5ET01JWkVfS1NUQUNLX09GRlNFVD15CkNPTkZJR19SQU5ET01JWkVfS1NU
QUNLX09GRlNFVD15CkNPTkZJR19SQU5ET01JWkVfS1NUQUNLX09GRlNFVF9ERUZBVUxUPXkK
Q09ORklHX0FSQ0hfSEFTX1NUUklDVF9LRVJORUxfUldYPXkKQ09ORklHX1NUUklDVF9LRVJO
RUxfUldYPXkKQ09ORklHX0FSQ0hfSEFTX1NUUklDVF9NT0RVTEVfUldYPXkKQ09ORklHX1NU
UklDVF9NT0RVTEVfUldYPXkKQ09ORklHX0hBVkVfQVJDSF9QUkVMMzJfUkVMT0NBVElPTlM9
eQpDT05GSUdfQVJDSF9VU0VfTUVNUkVNQVBfUFJPVD15CkNPTkZJR19MT0NLX0VWRU5UX0NP
VU5UUz15CkNPTkZJR19BUkNIX0hBU19NRU1fRU5DUllQVD15CkNPTkZJR19BUkNIX0hBU19D
Q19QTEFURk9STT15CkNPTkZJR19IQVZFX1NUQVRJQ19DQUxMPXkKQ09ORklHX0hBVkVfU1RB
VElDX0NBTExfSU5MSU5FPXkKQ09ORklHX0hBVkVfUFJFRU1QVF9EWU5BTUlDPXkKQ09ORklH
X0hBVkVfUFJFRU1QVF9EWU5BTUlDX0NBTEw9eQpDT05GSUdfQVJDSF9XQU5UX0xEX09SUEhB
Tl9XQVJOPXkKQ09ORklHX0FSQ0hfU1VQUE9SVFNfREVCVUdfUEFHRUFMTE9DPXkKQ09ORklH
X0FSQ0hfU1VQUE9SVFNfUEFHRV9UQUJMRV9DSEVDSz15CkNPTkZJR19BUkNIX0hBU19FTEZD
T1JFX0NPTVBBVD15CkNPTkZJR19BUkNIX0hBU19QQVJBTk9JRF9MMURfRkxVU0g9eQpDT05G
SUdfRFlOQU1JQ19TSUdGUkFNRT15CkNPTkZJR19IQVZFX0FSQ0hfTk9ERV9ERVZfR1JPVVA9
eQpDT05GSUdfQVJDSF9IQVNfSFdfUFRFX1lPVU5HPXkKQ09ORklHX0FSQ0hfSEFTX05PTkxF
QUZfUE1EX1lPVU5HPXkKCiMKIyBHQ09WLWJhc2VkIGtlcm5lbCBwcm9maWxpbmcKIwojIENP
TkZJR19HQ09WX0tFUk5FTCBpcyBub3Qgc2V0CkNPTkZJR19BUkNIX0hBU19HQ09WX1BST0ZJ
TEVfQUxMPXkKIyBlbmQgb2YgR0NPVi1iYXNlZCBrZXJuZWwgcHJvZmlsaW5nCgpDT05GSUdf
SEFWRV9HQ0NfUExVR0lOUz15CkNPTkZJR19HQ0NfUExVR0lOUz15CkNPTkZJR19HQ0NfUExV
R0lOX0xBVEVOVF9FTlRST1BZPXkKQ09ORklHX0ZVTkNUSU9OX0FMSUdOTUVOVF80Qj15CkNP
TkZJR19GVU5DVElPTl9BTElHTk1FTlRfMTZCPXkKQ09ORklHX0ZVTkNUSU9OX0FMSUdOTUVO
VD0xNgojIGVuZCBvZiBHZW5lcmFsIGFyY2hpdGVjdHVyZS1kZXBlbmRlbnQgb3B0aW9ucwoK
Q09ORklHX1JUX01VVEVYRVM9eQpDT05GSUdfQkFTRV9TTUFMTD0wCkNPTkZJR19NT0RVTEVf
U0lHX0ZPUk1BVD15CkNPTkZJR19NT0RVTEVTPXkKQ09ORklHX01PRFVMRV9ERUJVR0ZTPXkK
IyBDT05GSUdfTU9EVUxFX0RFQlVHIGlzIG5vdCBzZXQKQ09ORklHX01PRFVMRV9GT1JDRV9M
T0FEPXkKQ09ORklHX01PRFVMRV9VTkxPQUQ9eQpDT05GSUdfTU9EVUxFX0ZPUkNFX1VOTE9B
RD15CkNPTkZJR19NT0RVTEVfVU5MT0FEX1RBSU5UX1RSQUNLSU5HPXkKQ09ORklHX01PRFZF
UlNJT05TPXkKQ09ORklHX0FTTV9NT0RWRVJTSU9OUz15CkNPTkZJR19NT0RVTEVfU1JDVkVS
U0lPTl9BTEw9eQpDT05GSUdfTU9EVUxFX1NJRz15CiMgQ09ORklHX01PRFVMRV9TSUdfRk9S
Q0UgaXMgbm90IHNldApDT05GSUdfTU9EVUxFX1NJR19BTEw9eQojIENPTkZJR19NT0RVTEVf
U0lHX1NIQTEgaXMgbm90IHNldAojIENPTkZJR19NT0RVTEVfU0lHX1NIQTI1NiBpcyBub3Qg
c2V0CiMgQ09ORklHX01PRFVMRV9TSUdfU0hBMzg0IGlzIG5vdCBzZXQKQ09ORklHX01PRFVM
RV9TSUdfU0hBNTEyPXkKIyBDT05GSUdfTU9EVUxFX1NJR19TSEEzXzI1NiBpcyBub3Qgc2V0
CiMgQ09ORklHX01PRFVMRV9TSUdfU0hBM18zODQgaXMgbm90IHNldAojIENPTkZJR19NT0RV
TEVfU0lHX1NIQTNfNTEyIGlzIG5vdCBzZXQKQ09ORklHX01PRFVMRV9TSUdfSEFTSD0ic2hh
NTEyIgojIENPTkZJR19NT0RVTEVfQ09NUFJFU1NfTk9ORSBpcyBub3Qgc2V0CiMgQ09ORklH
X01PRFVMRV9DT01QUkVTU19HWklQIGlzIG5vdCBzZXQKIyBDT05GSUdfTU9EVUxFX0NPTVBS
RVNTX1haIGlzIG5vdCBzZXQKQ09ORklHX01PRFVMRV9DT01QUkVTU19aU1REPXkKQ09ORklH
X01PRFVMRV9ERUNPTVBSRVNTPXkKIyBDT05GSUdfTU9EVUxFX0FMTE9XX01JU1NJTkdfTkFN
RVNQQUNFX0lNUE9SVFMgaXMgbm90IHNldApDT05GSUdfTU9EUFJPQkVfUEFUSD0iL3NiaW4v
bW9kcHJvYmUiCkNPTkZJR19NT0RVTEVTX1RSRUVfTE9PS1VQPXkKQ09ORklHX0JMT0NLPXkK
Q09ORklHX0JMT0NLX0xFR0FDWV9BVVRPTE9BRD15CkNPTkZJR19CTEtfUlFfQUxMT0NfVElN
RT15CkNPTkZJR19CTEtfQ0dST1VQX1JXU1RBVD15CkNPTkZJR19CTEtfQ0dST1VQX1BVTlRf
QklPPXkKQ09ORklHX0JMS19ERVZfQlNHX0NPTU1PTj15CkNPTkZJR19CTEtfSUNRPXkKQ09O
RklHX0JMS19ERVZfQlNHTElCPXkKQ09ORklHX0JMS19ERVZfSU5URUdSSVRZPXkKQ09ORklH
X0JMS19ERVZfSU5URUdSSVRZX1QxMD15CkNPTkZJR19CTEtfREVWX1dSSVRFX01PVU5URUQ9
eQpDT05GSUdfQkxLX0RFVl9aT05FRD15CkNPTkZJR19CTEtfREVWX1RIUk9UVExJTkc9eQpD
T05GSUdfQkxLX0RFVl9USFJPVFRMSU5HX0xPVz15CkNPTkZJR19CTEtfV0JUPXkKQ09ORklH
X0JMS19XQlRfTVE9eQpDT05GSUdfQkxLX0NHUk9VUF9JT0xBVEVOQ1k9eQpDT05GSUdfQkxL
X0NHUk9VUF9JT0NPU1Q9eQpDT05GSUdfQkxLX0NHUk9VUF9JT1BSSU89eQpDT05GSUdfQkxL
X0RFQlVHX0ZTPXkKQ09ORklHX0JMS19ERUJVR19GU19aT05FRD15CkNPTkZJR19CTEtfU0VE
X09QQUw9eQpDT05GSUdfQkxLX0lOTElORV9FTkNSWVBUSU9OPXkKQ09ORklHX0JMS19JTkxJ
TkVfRU5DUllQVElPTl9GQUxMQkFDSz15CgojCiMgUGFydGl0aW9uIFR5cGVzCiMKQ09ORklH
X1BBUlRJVElPTl9BRFZBTkNFRD15CiMgQ09ORklHX0FDT1JOX1BBUlRJVElPTiBpcyBub3Qg
c2V0CkNPTkZJR19BSVhfUEFSVElUSU9OPXkKIyBDT05GSUdfT1NGX1BBUlRJVElPTiBpcyBu
b3Qgc2V0CiMgQ09ORklHX0FNSUdBX1BBUlRJVElPTiBpcyBub3Qgc2V0CiMgQ09ORklHX0FU
QVJJX1BBUlRJVElPTiBpcyBub3Qgc2V0CkNPTkZJR19NQUNfUEFSVElUSU9OPXkKQ09ORklH
X01TRE9TX1BBUlRJVElPTj15CkNPTkZJR19CU0RfRElTS0xBQkVMPXkKQ09ORklHX01JTklY
X1NVQlBBUlRJVElPTj15CkNPTkZJR19TT0xBUklTX1g4Nl9QQVJUSVRJT049eQojIENPTkZJ
R19VTklYV0FSRV9ESVNLTEFCRUwgaXMgbm90IHNldApDT05GSUdfTERNX1BBUlRJVElPTj15
CiMgQ09ORklHX0xETV9ERUJVRyBpcyBub3Qgc2V0CiMgQ09ORklHX1NHSV9QQVJUSVRJT04g
aXMgbm90IHNldAojIENPTkZJR19VTFRSSVhfUEFSVElUSU9OIGlzIG5vdCBzZXQKIyBDT05G
SUdfU1VOX1BBUlRJVElPTiBpcyBub3Qgc2V0CkNPTkZJR19LQVJNQV9QQVJUSVRJT049eQpD
T05GSUdfRUZJX1BBUlRJVElPTj15CiMgQ09ORklHX1NZU1Y2OF9QQVJUSVRJT04gaXMgbm90
IHNldAojIENPTkZJR19DTURMSU5FX1BBUlRJVElPTiBpcyBub3Qgc2V0CiMgZW5kIG9mIFBh
cnRpdGlvbiBUeXBlcwoKQ09ORklHX0JMS19NUV9QQ0k9eQpDT05GSUdfQkxLX01RX1ZJUlRJ
Tz15CkNPTkZJR19CTEtfUE09eQpDT05GSUdfQkxPQ0tfSE9MREVSX0RFUFJFQ0FURUQ9eQpD
T05GSUdfQkxLX01RX1NUQUNLSU5HPXkKCiMKIyBJTyBTY2hlZHVsZXJzCiMKQ09ORklHX01R
X0lPU0NIRURfREVBRExJTkU9eQpDT05GSUdfTVFfSU9TQ0hFRF9LWUJFUj15CkNPTkZJR19J
T1NDSEVEX0JGUT15CkNPTkZJR19CRlFfR1JPVVBfSU9TQ0hFRD15CiMgQ09ORklHX0JGUV9D
R1JPVVBfREVCVUcgaXMgbm90IHNldAojIGVuZCBvZiBJTyBTY2hlZHVsZXJzCgpDT05GSUdf
UFJFRU1QVF9OT1RJRklFUlM9eQpDT05GSUdfQVNOMT15CkNPTkZJR19VTklOTElORV9TUElO
X1VOTE9DSz15CkNPTkZJR19BUkNIX1NVUFBPUlRTX0FUT01JQ19STVc9eQpDT05GSUdfTVVU
RVhfU1BJTl9PTl9PV05FUj15CkNPTkZJR19SV1NFTV9TUElOX09OX09XTkVSPXkKQ09ORklH
X0xPQ0tfU1BJTl9PTl9PV05FUj15CkNPTkZJR19BUkNIX1VTRV9RVUVVRURfU1BJTkxPQ0tT
PXkKQ09ORklHX1FVRVVFRF9TUElOTE9DS1M9eQpDT05GSUdfQVJDSF9VU0VfUVVFVUVEX1JX
TE9DS1M9eQpDT05GSUdfUVVFVUVEX1JXTE9DS1M9eQpDT05GSUdfQVJDSF9IQVNfTk9OX09W
RVJMQVBQSU5HX0FERFJFU1NfU1BBQ0U9eQpDT05GSUdfQVJDSF9IQVNfU1lOQ19DT1JFX0JF
Rk9SRV9VU0VSTU9ERT15CkNPTkZJR19BUkNIX0hBU19TWVNDQUxMX1dSQVBQRVI9eQpDT05G
SUdfRlJFRVpFUj15CgojCiMgRXhlY3V0YWJsZSBmaWxlIGZvcm1hdHMKIwpDT05GSUdfQklO
Rk1UX0VMRj15CkNPTkZJR19DT01QQVRfQklORk1UX0VMRj15CkNPTkZJR19FTEZDT1JFPXkK
Q09ORklHX0NPUkVfRFVNUF9ERUZBVUxUX0VMRl9IRUFERVJTPXkKQ09ORklHX0JJTkZNVF9T
Q1JJUFQ9eQpDT05GSUdfQklORk1UX01JU0M9eQpDT05GSUdfQ09SRURVTVA9eQojIGVuZCBv
ZiBFeGVjdXRhYmxlIGZpbGUgZm9ybWF0cwoKIwojIE1lbW9yeSBNYW5hZ2VtZW50IG9wdGlv
bnMKIwpDT05GSUdfWlBPT0w9eQpDT05GSUdfU1dBUD15CkNPTkZJR19aU1dBUD15CkNPTkZJ
R19aU1dBUF9ERUZBVUxUX09OPXkKIyBDT05GSUdfWlNXQVBfRVhDTFVTSVZFX0xPQURTX0RF
RkFVTFRfT04gaXMgbm90IHNldAojIENPTkZJR19aU1dBUF9TSFJJTktFUl9ERUZBVUxUX09O
IGlzIG5vdCBzZXQKIyBDT05GSUdfWlNXQVBfQ09NUFJFU1NPUl9ERUZBVUxUX0RFRkxBVEUg
aXMgbm90IHNldAojIENPTkZJR19aU1dBUF9DT01QUkVTU09SX0RFRkFVTFRfTFpPIGlzIG5v
dCBzZXQKIyBDT05GSUdfWlNXQVBfQ09NUFJFU1NPUl9ERUZBVUxUXzg0MiBpcyBub3Qgc2V0
CiMgQ09ORklHX1pTV0FQX0NPTVBSRVNTT1JfREVGQVVMVF9MWjQgaXMgbm90IHNldAojIENP
TkZJR19aU1dBUF9DT01QUkVTU09SX0RFRkFVTFRfTFo0SEMgaXMgbm90IHNldApDT05GSUdf
WlNXQVBfQ09NUFJFU1NPUl9ERUZBVUxUX1pTVEQ9eQpDT05GSUdfWlNXQVBfQ09NUFJFU1NP
Ul9ERUZBVUxUPSJ6c3RkIgojIENPTkZJR19aU1dBUF9aUE9PTF9ERUZBVUxUX1pCVUQgaXMg
bm90IHNldAojIENPTkZJR19aU1dBUF9aUE9PTF9ERUZBVUxUX1ozRk9MRCBpcyBub3Qgc2V0
CkNPTkZJR19aU1dBUF9aUE9PTF9ERUZBVUxUX1pTTUFMTE9DPXkKQ09ORklHX1pTV0FQX1pQ
T09MX0RFRkFVTFQ9InpzbWFsbG9jIgpDT05GSUdfWkJVRD15CkNPTkZJR19aM0ZPTEQ9eQpD
T05GSUdfWlNNQUxMT0M9eQpDT05GSUdfWlNNQUxMT0NfU1RBVD15CkNPTkZJR19aU01BTExP
Q19DSEFJTl9TSVpFPTgKCiMKIyBTbGFiIGFsbG9jYXRvciBvcHRpb25zCiMKQ09ORklHX1NM
VUI9eQojIENPTkZJR19TTEFCX01FUkdFX0RFRkFVTFQgaXMgbm90IHNldApDT05GSUdfU0xB
Ql9GUkVFTElTVF9SQU5ET009eQpDT05GSUdfU0xBQl9GUkVFTElTVF9IQVJERU5FRD15CiMg
Q09ORklHX1NMVUJfU1RBVFMgaXMgbm90IHNldApDT05GSUdfU0xVQl9DUFVfUEFSVElBTD15
CkNPTkZJR19SQU5ET01fS01BTExPQ19DQUNIRVM9eQojIGVuZCBvZiBTbGFiIGFsbG9jYXRv
ciBvcHRpb25zCgpDT05GSUdfU0hVRkZMRV9QQUdFX0FMTE9DQVRPUj15CiMgQ09ORklHX0NP
TVBBVF9CUksgaXMgbm90IHNldApDT05GSUdfU1BBUlNFTUVNPXkKQ09ORklHX1NQQVJTRU1F
TV9FWFRSRU1FPXkKQ09ORklHX1NQQVJTRU1FTV9WTUVNTUFQX0VOQUJMRT15CkNPTkZJR19T
UEFSU0VNRU1fVk1FTU1BUD15CkNPTkZJR19BUkNIX1dBTlRfT1BUSU1JWkVfREFYX1ZNRU1N
QVA9eQpDT05GSUdfQVJDSF9XQU5UX09QVElNSVpFX0hVR0VUTEJfVk1FTU1BUD15CkNPTkZJ
R19IQVZFX0ZBU1RfR1VQPXkKQ09ORklHX0FSQ0hfS0VFUF9NRU1CTE9DSz15CkNPTkZJR19O
VU1BX0tFRVBfTUVNSU5GTz15CkNPTkZJR19NRU1PUllfSVNPTEFUSU9OPXkKQ09ORklHX0VY
Q0xVU0lWRV9TWVNURU1fUkFNPXkKQ09ORklHX0hBVkVfQk9PVE1FTV9JTkZPX05PREU9eQpD
T05GSUdfQVJDSF9FTkFCTEVfTUVNT1JZX0hPVFBMVUc9eQpDT05GSUdfQVJDSF9FTkFCTEVf
TUVNT1JZX0hPVFJFTU9WRT15CkNPTkZJR19NRU1PUllfSE9UUExVRz15CkNPTkZJR19NRU1P
UllfSE9UUExVR19ERUZBVUxUX09OTElORT15CkNPTkZJR19NRU1PUllfSE9UUkVNT1ZFPXkK
Q09ORklHX01IUF9NRU1NQVBfT05fTUVNT1JZPXkKQ09ORklHX0FSQ0hfTUhQX01FTU1BUF9P
Tl9NRU1PUllfRU5BQkxFPXkKQ09ORklHX1NQTElUX1BUTE9DS19DUFVTPTQKQ09ORklHX0FS
Q0hfRU5BQkxFX1NQTElUX1BNRF9QVExPQ0s9eQpDT05GSUdfTUVNT1JZX0JBTExPT049eQpD
T05GSUdfQkFMTE9PTl9DT01QQUNUSU9OPXkKQ09ORklHX0NPTVBBQ1RJT049eQpDT05GSUdf
Q09NUEFDVF9VTkVWSUNUQUJMRV9ERUZBVUxUPTEKQ09ORklHX1BBR0VfUkVQT1JUSU5HPXkK
Q09ORklHX01JR1JBVElPTj15CkNPTkZJR19ERVZJQ0VfTUlHUkFUSU9OPXkKQ09ORklHX0FS
Q0hfRU5BQkxFX0hVR0VQQUdFX01JR1JBVElPTj15CkNPTkZJR19BUkNIX0VOQUJMRV9USFBf
TUlHUkFUSU9OPXkKQ09ORklHX0NPTlRJR19BTExPQz15CkNPTkZJR19QQ1BfQkFUQ0hfU0NB
TEVfTUFYPTUKQ09ORklHX1BIWVNfQUREUl9UXzY0QklUPXkKQ09ORklHX01NVV9OT1RJRklF
Uj15CkNPTkZJR19LU009eQpDT05GSUdfREVGQVVMVF9NTUFQX01JTl9BRERSPTY1NTM2CkNP
TkZJR19BUkNIX1NVUFBPUlRTX01FTU9SWV9GQUlMVVJFPXkKQ09ORklHX01FTU9SWV9GQUlM
VVJFPXkKIyBDT05GSUdfSFdQT0lTT05fSU5KRUNUIGlzIG5vdCBzZXQKQ09ORklHX0FSQ0hf
V0FOVF9HRU5FUkFMX0hVR0VUTEI9eQpDT05GSUdfQVJDSF9XQU5UU19USFBfU1dBUD15CkNP
TkZJR19UUkFOU1BBUkVOVF9IVUdFUEFHRT15CiMgQ09ORklHX1RSQU5TUEFSRU5UX0hVR0VQ
QUdFX0FMV0FZUyBpcyBub3Qgc2V0CkNPTkZJR19UUkFOU1BBUkVOVF9IVUdFUEFHRV9NQURW
SVNFPXkKIyBDT05GSUdfVFJBTlNQQVJFTlRfSFVHRVBBR0VfTkVWRVIgaXMgbm90IHNldApD
T05GSUdfVEhQX1NXQVA9eQpDT05GSUdfUkVBRF9PTkxZX1RIUF9GT1JfRlM9eQpDT05GSUdf
TkVFRF9QRVJfQ1BVX0VNQkVEX0ZJUlNUX0NIVU5LPXkKQ09ORklHX05FRURfUEVSX0NQVV9Q
QUdFX0ZJUlNUX0NIVU5LPXkKQ09ORklHX1VTRV9QRVJDUFVfTlVNQV9OT0RFX0lEPXkKQ09O
RklHX0hBVkVfU0VUVVBfUEVSX0NQVV9BUkVBPXkKQ09ORklHX0NNQT15CiMgQ09ORklHX0NN
QV9ERUJVRyBpcyBub3Qgc2V0CiMgQ09ORklHX0NNQV9ERUJVR0ZTIGlzIG5vdCBzZXQKQ09O
RklHX0NNQV9TWVNGUz15CkNPTkZJR19DTUFfQVJFQVM9NwpDT05GSUdfR0VORVJJQ19FQVJM
WV9JT1JFTUFQPXkKIyBDT05GSUdfREVGRVJSRURfU1RSVUNUX1BBR0VfSU5JVCBpcyBub3Qg
c2V0CkNPTkZJR19QQUdFX0lETEVfRkxBRz15CkNPTkZJR19JRExFX1BBR0VfVFJBQ0tJTkc9
eQpDT05GSUdfQVJDSF9IQVNfQ0FDSEVfTElORV9TSVpFPXkKQ09ORklHX0FSQ0hfSEFTX0NV
UlJFTlRfU1RBQ0tfUE9JTlRFUj15CkNPTkZJR19BUkNIX0hBU19QVEVfREVWTUFQPXkKQ09O
RklHX1pPTkVfRE1BPXkKQ09ORklHX1pPTkVfRE1BMzI9eQpDT05GSUdfWk9ORV9ERVZJQ0U9
eQpDT05GSUdfR0VUX0ZSRUVfUkVHSU9OPXkKQ09ORklHX0RFVklDRV9QUklWQVRFPXkKQ09O
RklHX0FSQ0hfVVNFU19ISUdIX1ZNQV9GTEFHUz15CkNPTkZJR19BUkNIX0hBU19QS0VZUz15
CkNPTkZJR19WTV9FVkVOVF9DT1VOVEVSUz15CiMgQ09ORklHX1BFUkNQVV9TVEFUUyBpcyBu
b3Qgc2V0CiMgQ09ORklHX0dVUF9URVNUIGlzIG5vdCBzZXQKIyBDT05GSUdfRE1BUE9PTF9U
RVNUIGlzIG5vdCBzZXQKQ09ORklHX0FSQ0hfSEFTX1BURV9TUEVDSUFMPXkKQ09ORklHX01F
TUZEX0NSRUFURT15CkNPTkZJR19TRUNSRVRNRU09eQpDT05GSUdfQU5PTl9WTUFfTkFNRT15
CiMgQ09ORklHX1VTRVJGQVVMVEZEIGlzIG5vdCBzZXQKQ09ORklHX0xSVV9HRU49eQpDT05G
SUdfTFJVX0dFTl9FTkFCTEVEPXkKIyBDT05GSUdfTFJVX0dFTl9TVEFUUyBpcyBub3Qgc2V0
CkNPTkZJR19MUlVfR0VOX1dBTEtTX01NVT15CkNPTkZJR19BUkNIX1NVUFBPUlRTX1BFUl9W
TUFfTE9DSz15CkNPTkZJR19QRVJfVk1BX0xPQ0s9eQpDT05GSUdfTE9DS19NTV9BTkRfRklO
RF9WTUE9eQpDT05GSUdfSU9NTVVfTU1fREFUQT15CgojCiMgRGF0YSBBY2Nlc3MgTW9uaXRv
cmluZwojCkNPTkZJR19EQU1PTj15CkNPTkZJR19EQU1PTl9WQUREUj15CkNPTkZJR19EQU1P
Tl9QQUREUj15CkNPTkZJR19EQU1PTl9TWVNGUz15CkNPTkZJR19EQU1PTl9EQkdGUz15CkNP
TkZJR19EQU1PTl9SRUNMQUlNPXkKQ09ORklHX0RBTU9OX0xSVV9TT1JUPXkKIyBlbmQgb2Yg
RGF0YSBBY2Nlc3MgTW9uaXRvcmluZwojIGVuZCBvZiBNZW1vcnkgTWFuYWdlbWVudCBvcHRp
b25zCgpDT05GSUdfTkVUPXkKQ09ORklHX0NPTVBBVF9ORVRMSU5LX01FU1NBR0VTPXkKQ09O
RklHX05FVF9JTkdSRVNTPXkKQ09ORklHX05FVF9FR1JFU1M9eQpDT05GSUdfTkVUX1hHUkVT
Uz15CkNPTkZJR19TS0JfRVhURU5TSU9OUz15CgojCiMgTmV0d29ya2luZyBvcHRpb25zCiMK
Q09ORklHX1BBQ0tFVD15CiMgQ09ORklHX1BBQ0tFVF9ESUFHIGlzIG5vdCBzZXQKQ09ORklH
X1VOSVg9eQpDT05GSUdfVU5JWF9TQ009eQpDT05GSUdfQUZfVU5JWF9PT0I9eQojIENPTkZJ
R19VTklYX0RJQUcgaXMgbm90IHNldAojIENPTkZJR19UTFMgaXMgbm90IHNldAojIENPTkZJ
R19YRlJNX1VTRVIgaXMgbm90IHNldAojIENPTkZJR19ORVRfS0VZIGlzIG5vdCBzZXQKQ09O
RklHX1hEUF9TT0NLRVRTPXkKIyBDT05GSUdfWERQX1NPQ0tFVFNfRElBRyBpcyBub3Qgc2V0
CkNPTkZJR19JTkVUPXkKQ09ORklHX0lQX01VTFRJQ0FTVD15CkNPTkZJR19JUF9BRFZBTkNF
RF9ST1VURVI9eQojIENPTkZJR19JUF9GSUJfVFJJRV9TVEFUUyBpcyBub3Qgc2V0CkNPTkZJ
R19JUF9NVUxUSVBMRV9UQUJMRVM9eQpDT05GSUdfSVBfUk9VVEVfTVVMVElQQVRIPXkKQ09O
RklHX0lQX1JPVVRFX1ZFUkJPU0U9eQojIENPTkZJR19JUF9QTlAgaXMgbm90IHNldAojIENP
TkZJR19ORVRfSVBJUCBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9JUEdSRV9ERU1VWCBpcyBu
b3Qgc2V0CkNPTkZJR19ORVRfSVBfVFVOTkVMPW0KQ09ORklHX0lQX01ST1VURV9DT01NT049
eQpDT05GSUdfSVBfTVJPVVRFPXkKQ09ORklHX0lQX01ST1VURV9NVUxUSVBMRV9UQUJMRVM9
eQpDT05GSUdfSVBfUElNU01fVjE9eQpDT05GSUdfSVBfUElNU01fVjI9eQpDT05GSUdfU1lO
X0NPT0tJRVM9eQojIENPTkZJR19ORVRfSVBWVEkgaXMgbm90IHNldApDT05GSUdfTkVUX1VE
UF9UVU5ORUw9bQojIENPTkZJR19ORVRfRk9VIGlzIG5vdCBzZXQKIyBDT05GSUdfSU5FVF9B
SCBpcyBub3Qgc2V0CiMgQ09ORklHX0lORVRfRVNQIGlzIG5vdCBzZXQKIyBDT05GSUdfSU5F
VF9JUENPTVAgaXMgbm90IHNldApDT05GSUdfSU5FVF9UQUJMRV9QRVJUVVJCX09SREVSPTE2
CiMgQ09ORklHX0lORVRfRElBRyBpcyBub3Qgc2V0CkNPTkZJR19UQ1BfQ09OR19BRFZBTkNF
RD15CiMgQ09ORklHX1RDUF9DT05HX0JJQyBpcyBub3Qgc2V0CkNPTkZJR19UQ1BfQ09OR19D
VUJJQz15CiMgQ09ORklHX1RDUF9DT05HX1dFU1RXT09EIGlzIG5vdCBzZXQKIyBDT05GSUdf
VENQX0NPTkdfSFRDUCBpcyBub3Qgc2V0CiMgQ09ORklHX1RDUF9DT05HX0hTVENQIGlzIG5v
dCBzZXQKIyBDT05GSUdfVENQX0NPTkdfSFlCTEEgaXMgbm90IHNldAojIENPTkZJR19UQ1Bf
Q09OR19WRUdBUyBpcyBub3Qgc2V0CiMgQ09ORklHX1RDUF9DT05HX05WIGlzIG5vdCBzZXQK
IyBDT05GSUdfVENQX0NPTkdfU0NBTEFCTEUgaXMgbm90IHNldAojIENPTkZJR19UQ1BfQ09O
R19MUCBpcyBub3Qgc2V0CiMgQ09ORklHX1RDUF9DT05HX1ZFTk8gaXMgbm90IHNldAojIENP
TkZJR19UQ1BfQ09OR19ZRUFIIGlzIG5vdCBzZXQKIyBDT05GSUdfVENQX0NPTkdfSUxMSU5P
SVMgaXMgbm90IHNldAojIENPTkZJR19UQ1BfQ09OR19EQ1RDUCBpcyBub3Qgc2V0CiMgQ09O
RklHX1RDUF9DT05HX0NERyBpcyBub3Qgc2V0CiMgQ09ORklHX1RDUF9DT05HX0JCUiBpcyBu
b3Qgc2V0CkNPTkZJR19ERUZBVUxUX0NVQklDPXkKIyBDT05GSUdfREVGQVVMVF9SRU5PIGlz
IG5vdCBzZXQKQ09ORklHX0RFRkFVTFRfVENQX0NPTkc9ImN1YmljIgpDT05GSUdfVENQX1NJ
R1BPT0w9eQpDT05GSUdfVENQX0FPPXkKQ09ORklHX1RDUF9NRDVTSUc9eQpDT05GSUdfSVBW
Nj15CkNPTkZJR19JUFY2X1JPVVRFUl9QUkVGPXkKQ09ORklHX0lQVjZfUk9VVEVfSU5GTz15
CkNPTkZJR19JUFY2X09QVElNSVNUSUNfREFEPXkKIyBDT05GSUdfSU5FVDZfQUggaXMgbm90
IHNldAojIENPTkZJR19JTkVUNl9FU1AgaXMgbm90IHNldAojIENPTkZJR19JTkVUNl9JUENP
TVAgaXMgbm90IHNldAojIENPTkZJR19JUFY2X01JUDYgaXMgbm90IHNldAojIENPTkZJR19J
UFY2X0lMQSBpcyBub3Qgc2V0CiMgQ09ORklHX0lQVjZfVlRJIGlzIG5vdCBzZXQKIyBDT05G
SUdfSVBWNl9TSVQgaXMgbm90IHNldAojIENPTkZJR19JUFY2X1RVTk5FTCBpcyBub3Qgc2V0
CkNPTkZJR19JUFY2X01VTFRJUExFX1RBQkxFUz15CkNPTkZJR19JUFY2X1NVQlRSRUVTPXkK
Q09ORklHX0lQVjZfTVJPVVRFPXkKQ09ORklHX0lQVjZfTVJPVVRFX01VTFRJUExFX1RBQkxF
Uz15CkNPTkZJR19JUFY2X1BJTVNNX1YyPXkKQ09ORklHX0lQVjZfU0VHNl9MV1RVTk5FTD15
CkNPTkZJR19JUFY2X1NFRzZfSE1BQz15CkNPTkZJR19JUFY2X1NFRzZfQlBGPXkKQ09ORklH
X0lQVjZfUlBMX0xXVFVOTkVMPXkKQ09ORklHX0lQVjZfSU9BTTZfTFdUVU5ORUw9eQpDT05G
SUdfTkVUTEFCRUw9eQpDT05GSUdfTVBUQ1A9eQpDT05GSUdfTVBUQ1BfSVBWNj15CkNPTkZJ
R19ORVRXT1JLX1NFQ01BUks9eQpDT05GSUdfTkVUX1BUUF9DTEFTU0lGWT15CkNPTkZJR19O
RVRXT1JLX1BIWV9USU1FU1RBTVBJTkc9eQpDT05GSUdfTkVURklMVEVSPXkKQ09ORklHX05F
VEZJTFRFUl9BRFZBTkNFRD15CgojCiMgQ29yZSBOZXRmaWx0ZXIgQ29uZmlndXJhdGlvbgoj
CkNPTkZJR19ORVRGSUxURVJfSU5HUkVTUz15CkNPTkZJR19ORVRGSUxURVJfRUdSRVNTPXkK
Q09ORklHX05FVEZJTFRFUl9TS0lQX0VHUkVTUz15CkNPTkZJR19ORVRGSUxURVJfTkVUTElO
Sz1tCkNPTkZJR19ORVRGSUxURVJfRkFNSUxZX0FSUD15CkNPTkZJR19ORVRGSUxURVJfQlBG
X0xJTks9eQpDT05GSUdfTkVURklMVEVSX05FVExJTktfSE9PSz1tCiMgQ09ORklHX05FVEZJ
TFRFUl9ORVRMSU5LX0FDQ1QgaXMgbm90IHNldAojIENPTkZJR19ORVRGSUxURVJfTkVUTElO
S19RVUVVRSBpcyBub3Qgc2V0CiMgQ09ORklHX05FVEZJTFRFUl9ORVRMSU5LX0xPRyBpcyBu
b3Qgc2V0CiMgQ09ORklHX05FVEZJTFRFUl9ORVRMSU5LX09TRiBpcyBub3Qgc2V0CiMgQ09O
RklHX05GX0NPTk5UUkFDSyBpcyBub3Qgc2V0CiMgQ09ORklHX05GX0xPR19TWVNMT0cgaXMg
bm90IHNldApDT05GSUdfTkZfVEFCTEVTPW0KQ09ORklHX05GX1RBQkxFU19JTkVUPXkKQ09O
RklHX05GX1RBQkxFU19ORVRERVY9eQojIENPTkZJR19ORlRfTlVNR0VOIGlzIG5vdCBzZXQK
IyBDT05GSUdfTkZUX0xPRyBpcyBub3Qgc2V0CiMgQ09ORklHX05GVF9MSU1JVCBpcyBub3Qg
c2V0CiMgQ09ORklHX05GVF9UVU5ORUwgaXMgbm90IHNldAojIENPTkZJR19ORlRfUVVPVEEg
aXMgbm90IHNldAojIENPTkZJR19ORlRfUkVKRUNUIGlzIG5vdCBzZXQKIyBDT05GSUdfTkZU
X0NPTVBBVCBpcyBub3Qgc2V0CiMgQ09ORklHX05GVF9IQVNIIGlzIG5vdCBzZXQKIyBDT05G
SUdfTkZUX1NPQ0tFVCBpcyBub3Qgc2V0CiMgQ09ORklHX05GVF9PU0YgaXMgbm90IHNldAoj
IENPTkZJR19ORlRfVFBST1hZIGlzIG5vdCBzZXQKIyBDT05GSUdfTkZfRFVQX05FVERFViBp
cyBub3Qgc2V0CiMgQ09ORklHX05GVF9EVVBfTkVUREVWIGlzIG5vdCBzZXQKIyBDT05GSUdf
TkZUX0ZXRF9ORVRERVYgaXMgbm90IHNldApDT05GSUdfTkVURklMVEVSX1hUQUJMRVM9bQpD
T05GSUdfTkVURklMVEVSX1hUQUJMRVNfQ09NUEFUPXkKCiMKIyBYdGFibGVzIGNvbWJpbmVk
IG1vZHVsZXMKIwojIENPTkZJR19ORVRGSUxURVJfWFRfTUFSSyBpcyBub3Qgc2V0CgojCiMg
WHRhYmxlcyB0YXJnZXRzCiMKIyBDT05GSUdfTkVURklMVEVSX1hUX1RBUkdFVF9BVURJVCBp
cyBub3Qgc2V0CiMgQ09ORklHX05FVEZJTFRFUl9YVF9UQVJHRVRfQ0xBU1NJRlkgaXMgbm90
IHNldAojIENPTkZJR19ORVRGSUxURVJfWFRfVEFSR0VUX0hNQVJLIGlzIG5vdCBzZXQKIyBD
T05GSUdfTkVURklMVEVSX1hUX1RBUkdFVF9JRExFVElNRVIgaXMgbm90IHNldAojIENPTkZJ
R19ORVRGSUxURVJfWFRfVEFSR0VUX0xFRCBpcyBub3Qgc2V0CiMgQ09ORklHX05FVEZJTFRF
Ul9YVF9UQVJHRVRfTE9HIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVURklMVEVSX1hUX1RBUkdF
VF9NQVJLIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVURklMVEVSX1hUX1RBUkdFVF9ORkxPRyBp
cyBub3Qgc2V0CiMgQ09ORklHX05FVEZJTFRFUl9YVF9UQVJHRVRfTkZRVUVVRSBpcyBub3Qg
c2V0CiMgQ09ORklHX05FVEZJTFRFUl9YVF9UQVJHRVRfUkFURUVTVCBpcyBub3Qgc2V0CiMg
Q09ORklHX05FVEZJTFRFUl9YVF9UQVJHRVRfVEVFIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVU
RklMVEVSX1hUX1RBUkdFVF9TRUNNQVJLIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVURklMVEVS
X1hUX1RBUkdFVF9UQ1BNU1MgaXMgbm90IHNldAoKIwojIFh0YWJsZXMgbWF0Y2hlcwojCiMg
Q09ORklHX05FVEZJTFRFUl9YVF9NQVRDSF9BRERSVFlQRSBpcyBub3Qgc2V0CiMgQ09ORklH
X05FVEZJTFRFUl9YVF9NQVRDSF9CUEYgaXMgbm90IHNldAojIENPTkZJR19ORVRGSUxURVJf
WFRfTUFUQ0hfQ0dST1VQIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVURklMVEVSX1hUX01BVENI
X0NPTU1FTlQgaXMgbm90IHNldAojIENPTkZJR19ORVRGSUxURVJfWFRfTUFUQ0hfQ1BVIGlz
IG5vdCBzZXQKIyBDT05GSUdfTkVURklMVEVSX1hUX01BVENIX0RDQ1AgaXMgbm90IHNldAoj
IENPTkZJR19ORVRGSUxURVJfWFRfTUFUQ0hfREVWR1JPVVAgaXMgbm90IHNldAojIENPTkZJ
R19ORVRGSUxURVJfWFRfTUFUQ0hfRFNDUCBpcyBub3Qgc2V0CiMgQ09ORklHX05FVEZJTFRF
Ul9YVF9NQVRDSF9FQ04gaXMgbm90IHNldAojIENPTkZJR19ORVRGSUxURVJfWFRfTUFUQ0hf
RVNQIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVURklMVEVSX1hUX01BVENIX0hBU0hMSU1JVCBp
cyBub3Qgc2V0CiMgQ09ORklHX05FVEZJTFRFUl9YVF9NQVRDSF9ITCBpcyBub3Qgc2V0CiMg
Q09ORklHX05FVEZJTFRFUl9YVF9NQVRDSF9JUENPTVAgaXMgbm90IHNldAojIENPTkZJR19O
RVRGSUxURVJfWFRfTUFUQ0hfSVBSQU5HRSBpcyBub3Qgc2V0CiMgQ09ORklHX05FVEZJTFRF
Ul9YVF9NQVRDSF9MMlRQIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVURklMVEVSX1hUX01BVENI
X0xFTkdUSCBpcyBub3Qgc2V0CiMgQ09ORklHX05FVEZJTFRFUl9YVF9NQVRDSF9MSU1JVCBp
cyBub3Qgc2V0CiMgQ09ORklHX05FVEZJTFRFUl9YVF9NQVRDSF9NQUMgaXMgbm90IHNldAoj
IENPTkZJR19ORVRGSUxURVJfWFRfTUFUQ0hfTUFSSyBpcyBub3Qgc2V0CiMgQ09ORklHX05F
VEZJTFRFUl9YVF9NQVRDSF9NVUxUSVBPUlQgaXMgbm90IHNldAojIENPTkZJR19ORVRGSUxU
RVJfWFRfTUFUQ0hfTkZBQ0NUIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVURklMVEVSX1hUX01B
VENIX09TRiBpcyBub3Qgc2V0CiMgQ09ORklHX05FVEZJTFRFUl9YVF9NQVRDSF9PV05FUiBp
cyBub3Qgc2V0CiMgQ09ORklHX05FVEZJTFRFUl9YVF9NQVRDSF9QS1RUWVBFIGlzIG5vdCBz
ZXQKIyBDT05GSUdfTkVURklMVEVSX1hUX01BVENIX1FVT1RBIGlzIG5vdCBzZXQKIyBDT05G
SUdfTkVURklMVEVSX1hUX01BVENIX1JBVEVFU1QgaXMgbm90IHNldAojIENPTkZJR19ORVRG
SUxURVJfWFRfTUFUQ0hfUkVBTE0gaXMgbm90IHNldAojIENPTkZJR19ORVRGSUxURVJfWFRf
TUFUQ0hfUkVDRU5UIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVURklMVEVSX1hUX01BVENIX1ND
VFAgaXMgbm90IHNldAojIENPTkZJR19ORVRGSUxURVJfWFRfTUFUQ0hfU09DS0VUIGlzIG5v
dCBzZXQKIyBDT05GSUdfTkVURklMVEVSX1hUX01BVENIX1NUQVRJU1RJQyBpcyBub3Qgc2V0
CiMgQ09ORklHX05FVEZJTFRFUl9YVF9NQVRDSF9TVFJJTkcgaXMgbm90IHNldAojIENPTkZJ
R19ORVRGSUxURVJfWFRfTUFUQ0hfVENQTVNTIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVURklM
VEVSX1hUX01BVENIX1RJTUUgaXMgbm90IHNldAojIENPTkZJR19ORVRGSUxURVJfWFRfTUFU
Q0hfVTMyIGlzIG5vdCBzZXQKIyBlbmQgb2YgQ29yZSBOZXRmaWx0ZXIgQ29uZmlndXJhdGlv
bgoKIyBDT05GSUdfSVBfU0VUIGlzIG5vdCBzZXQKIyBDT05GSUdfSVBfVlMgaXMgbm90IHNl
dAoKIwojIElQOiBOZXRmaWx0ZXIgQ29uZmlndXJhdGlvbgojCiMgQ09ORklHX05GX1NPQ0tF
VF9JUFY0IGlzIG5vdCBzZXQKIyBDT05GSUdfTkZfVFBST1hZX0lQVjQgaXMgbm90IHNldApD
T05GSUdfTkZfVEFCTEVTX0lQVjQ9eQojIENPTkZJR19ORlRfRFVQX0lQVjQgaXMgbm90IHNl
dAojIENPTkZJR19ORlRfRklCX0lQVjQgaXMgbm90IHNldApDT05GSUdfTkZfVEFCTEVTX0FS
UD15CiMgQ09ORklHX05GX0RVUF9JUFY0IGlzIG5vdCBzZXQKIyBDT05GSUdfTkZfTE9HX0FS
UCBpcyBub3Qgc2V0CiMgQ09ORklHX05GX0xPR19JUFY0IGlzIG5vdCBzZXQKIyBDT05GSUdf
TkZfUkVKRUNUX0lQVjQgaXMgbm90IHNldApDT05GSUdfSVBfTkZfSVBUQUJMRVM9bQojIENP
TkZJR19JUF9ORl9NQVRDSF9BSCBpcyBub3Qgc2V0CiMgQ09ORklHX0lQX05GX01BVENIX0VD
TiBpcyBub3Qgc2V0CiMgQ09ORklHX0lQX05GX01BVENIX1RUTCBpcyBub3Qgc2V0CiMgQ09O
RklHX0lQX05GX0ZJTFRFUiBpcyBub3Qgc2V0CiMgQ09ORklHX0lQX05GX01BTkdMRSBpcyBu
b3Qgc2V0CiMgQ09ORklHX0lQX05GX1JBVyBpcyBub3Qgc2V0CiMgQ09ORklHX0lQX05GX1NF
Q1VSSVRZIGlzIG5vdCBzZXQKIyBDT05GSUdfSVBfTkZfQVJQVEFCTEVTIGlzIG5vdCBzZXQK
IyBlbmQgb2YgSVA6IE5ldGZpbHRlciBDb25maWd1cmF0aW9uCgojCiMgSVB2NjogTmV0Zmls
dGVyIENvbmZpZ3VyYXRpb24KIwojIENPTkZJR19ORl9TT0NLRVRfSVBWNiBpcyBub3Qgc2V0
CiMgQ09ORklHX05GX1RQUk9YWV9JUFY2IGlzIG5vdCBzZXQKQ09ORklHX05GX1RBQkxFU19J
UFY2PXkKIyBDT05GSUdfTkZUX0RVUF9JUFY2IGlzIG5vdCBzZXQKIyBDT05GSUdfTkZUX0ZJ
Ql9JUFY2IGlzIG5vdCBzZXQKIyBDT05GSUdfTkZfRFVQX0lQVjYgaXMgbm90IHNldAojIENP
TkZJR19ORl9SRUpFQ1RfSVBWNiBpcyBub3Qgc2V0CiMgQ09ORklHX05GX0xPR19JUFY2IGlz
IG5vdCBzZXQKIyBDT05GSUdfSVA2X05GX0lQVEFCTEVTIGlzIG5vdCBzZXQKIyBlbmQgb2Yg
SVB2NjogTmV0ZmlsdGVyIENvbmZpZ3VyYXRpb24KCiMgQ09ORklHX0lQX0RDQ1AgaXMgbm90
IHNldAojIENPTkZJR19JUF9TQ1RQIGlzIG5vdCBzZXQKIyBDT05GSUdfUkRTIGlzIG5vdCBz
ZXQKIyBDT05GSUdfVElQQyBpcyBub3Qgc2V0CiMgQ09ORklHX0FUTSBpcyBub3Qgc2V0CiMg
Q09ORklHX0wyVFAgaXMgbm90IHNldAojIENPTkZJR19CUklER0UgaXMgbm90IHNldAojIENP
TkZJR19ORVRfRFNBIGlzIG5vdCBzZXQKIyBDT05GSUdfVkxBTl84MDIxUSBpcyBub3Qgc2V0
CiMgQ09ORklHX0xMQzIgaXMgbm90IHNldAojIENPTkZJR19BVEFMSyBpcyBub3Qgc2V0CiMg
Q09ORklHX1gyNSBpcyBub3Qgc2V0CiMgQ09ORklHX0xBUEIgaXMgbm90IHNldAojIENPTkZJ
R19QSE9ORVQgaXMgbm90IHNldAojIENPTkZJR182TE9XUEFOIGlzIG5vdCBzZXQKIyBDT05G
SUdfSUVFRTgwMjE1NCBpcyBub3Qgc2V0CkNPTkZJR19ORVRfU0NIRUQ9eQoKIwojIFF1ZXVl
aW5nL1NjaGVkdWxpbmcKIwojIENPTkZJR19ORVRfU0NIX0hUQiBpcyBub3Qgc2V0CiMgQ09O
RklHX05FVF9TQ0hfSEZTQyBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9TQ0hfUFJJTyBpcyBu
b3Qgc2V0CiMgQ09ORklHX05FVF9TQ0hfTVVMVElRIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVU
X1NDSF9SRUQgaXMgbm90IHNldAojIENPTkZJR19ORVRfU0NIX1NGQiBpcyBub3Qgc2V0CiMg
Q09ORklHX05FVF9TQ0hfU0ZRIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX1NDSF9URVFMIGlz
IG5vdCBzZXQKIyBDT05GSUdfTkVUX1NDSF9UQkYgaXMgbm90IHNldAojIENPTkZJR19ORVRf
U0NIX0NCUyBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9TQ0hfRVRGIGlzIG5vdCBzZXQKIyBD
T05GSUdfTkVUX1NDSF9UQVBSSU8gaXMgbm90IHNldAojIENPTkZJR19ORVRfU0NIX0dSRUQg
aXMgbm90IHNldAojIENPTkZJR19ORVRfU0NIX05FVEVNIGlzIG5vdCBzZXQKIyBDT05GSUdf
TkVUX1NDSF9EUlIgaXMgbm90IHNldAojIENPTkZJR19ORVRfU0NIX01RUFJJTyBpcyBub3Qg
c2V0CiMgQ09ORklHX05FVF9TQ0hfU0tCUFJJTyBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9T
Q0hfQ0hPS0UgaXMgbm90IHNldAojIENPTkZJR19ORVRfU0NIX1FGUSBpcyBub3Qgc2V0CiMg
Q09ORklHX05FVF9TQ0hfQ09ERUwgaXMgbm90IHNldApDT05GSUdfTkVUX1NDSF9GUV9DT0RF
TD15CiMgQ09ORklHX05FVF9TQ0hfQ0FLRSBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9TQ0hf
RlEgaXMgbm90IHNldAojIENPTkZJR19ORVRfU0NIX0hIRiBpcyBub3Qgc2V0CiMgQ09ORklH
X05FVF9TQ0hfUElFIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX1NDSF9JTkdSRVNTIGlzIG5v
dCBzZXQKIyBDT05GSUdfTkVUX1NDSF9QTFVHIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX1ND
SF9FVFMgaXMgbm90IHNldApDT05GSUdfTkVUX1NDSF9ERUZBVUxUPXkKQ09ORklHX0RFRkFV
TFRfRlFfQ09ERUw9eQojIENPTkZJR19ERUZBVUxUX1BGSUZPX0ZBU1QgaXMgbm90IHNldApD
T05GSUdfREVGQVVMVF9ORVRfU0NIPSJmcV9jb2RlbCIKCiMKIyBDbGFzc2lmaWNhdGlvbgoj
CkNPTkZJR19ORVRfQ0xTPXkKIyBDT05GSUdfTkVUX0NMU19CQVNJQyBpcyBub3Qgc2V0CiMg
Q09ORklHX05FVF9DTFNfUk9VVEU0IGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX0NMU19GVyBp
cyBub3Qgc2V0CiMgQ09ORklHX05FVF9DTFNfVTMyIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVU
X0NMU19GTE9XIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX0NMU19DR1JPVVAgaXMgbm90IHNl
dAojIENPTkZJR19ORVRfQ0xTX0JQRiBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9DTFNfRkxP
V0VSIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX0NMU19NQVRDSEFMTCBpcyBub3Qgc2V0CkNP
TkZJR19ORVRfRU1BVENIPXkKQ09ORklHX05FVF9FTUFUQ0hfU1RBQ0s9MzIKIyBDT05GSUdf
TkVUX0VNQVRDSF9DTVAgaXMgbm90IHNldAojIENPTkZJR19ORVRfRU1BVENIX05CWVRFIGlz
IG5vdCBzZXQKIyBDT05GSUdfTkVUX0VNQVRDSF9VMzIgaXMgbm90IHNldAojIENPTkZJR19O
RVRfRU1BVENIX01FVEEgaXMgbm90IHNldAojIENPTkZJR19ORVRfRU1BVENIX1RFWFQgaXMg
bm90IHNldAojIENPTkZJR19ORVRfRU1BVENIX0lQVCBpcyBub3Qgc2V0CkNPTkZJR19ORVRf
Q0xTX0FDVD15CiMgQ09ORklHX05FVF9BQ1RfUE9MSUNFIGlzIG5vdCBzZXQKIyBDT05GSUdf
TkVUX0FDVF9HQUNUIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX0FDVF9NSVJSRUQgaXMgbm90
IHNldAojIENPTkZJR19ORVRfQUNUX1NBTVBMRSBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9B
Q1RfSVBUIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX0FDVF9OQVQgaXMgbm90IHNldAojIENP
TkZJR19ORVRfQUNUX1BFRElUIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX0FDVF9TSU1QIGlz
IG5vdCBzZXQKIyBDT05GSUdfTkVUX0FDVF9TS0JFRElUIGlzIG5vdCBzZXQKIyBDT05GSUdf
TkVUX0FDVF9DU1VNIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX0FDVF9NUExTIGlzIG5vdCBz
ZXQKIyBDT05GSUdfTkVUX0FDVF9WTEFOIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX0FDVF9C
UEYgaXMgbm90IHNldAojIENPTkZJR19ORVRfQUNUX1NLQk1PRCBpcyBub3Qgc2V0CiMgQ09O
RklHX05FVF9BQ1RfSUZFIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX0FDVF9UVU5ORUxfS0VZ
IGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX0FDVF9HQVRFIGlzIG5vdCBzZXQKQ09ORklHX05F
VF9UQ19TS0JfRVhUPXkKQ09ORklHX05FVF9TQ0hfRklGTz15CkNPTkZJR19EQ0I9eQojIENP
TkZJR19ETlNfUkVTT0xWRVIgaXMgbm90IHNldAojIENPTkZJR19CQVRNQU5fQURWIGlzIG5v
dCBzZXQKIyBDT05GSUdfT1BFTlZTV0lUQ0ggaXMgbm90IHNldAojIENPTkZJR19WU09DS0VU
UyBpcyBub3Qgc2V0CiMgQ09ORklHX05FVExJTktfRElBRyBpcyBub3Qgc2V0CkNPTkZJR19N
UExTPXkKIyBDT05GSUdfTkVUX01QTFNfR1NPIGlzIG5vdCBzZXQKIyBDT05GSUdfTVBMU19S
T1VUSU5HIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX05TSCBpcyBub3Qgc2V0CiMgQ09ORklH
X0hTUiBpcyBub3Qgc2V0CkNPTkZJR19ORVRfU1dJVENIREVWPXkKQ09ORklHX05FVF9MM19N
QVNURVJfREVWPXkKIyBDT05GSUdfUVJUUiBpcyBub3Qgc2V0CkNPTkZJR19ORVRfTkNTST15
CkNPTkZJR19OQ1NJX09FTV9DTURfR0VUX01BQz15CkNPTkZJR19OQ1NJX09FTV9DTURfS0VF
UF9QSFk9eQpDT05GSUdfUENQVV9ERVZfUkVGQ05UPXkKQ09ORklHX01BWF9TS0JfRlJBR1M9
MTcKQ09ORklHX1JQUz15CkNPTkZJR19SRlNfQUNDRUw9eQpDT05GSUdfU09DS19SWF9RVUVV
RV9NQVBQSU5HPXkKQ09ORklHX1hQUz15CkNPTkZJR19DR1JPVVBfTkVUX1BSSU89eQpDT05G
SUdfQ0dST1VQX05FVF9DTEFTU0lEPXkKQ09ORklHX05FVF9SWF9CVVNZX1BPTEw9eQpDT05G
SUdfQlFMPXkKQ09ORklHX0JQRl9TVFJFQU1fUEFSU0VSPXkKQ09ORklHX05FVF9GTE9XX0xJ
TUlUPXkKCiMKIyBOZXR3b3JrIHRlc3RpbmcKIwojIENPTkZJR19ORVRfUEtUR0VOIGlzIG5v
dCBzZXQKQ09ORklHX05FVF9EUk9QX01PTklUT1I9eQojIGVuZCBvZiBOZXR3b3JrIHRlc3Rp
bmcKIyBlbmQgb2YgTmV0d29ya2luZyBvcHRpb25zCgpDT05GSUdfSEFNUkFESU89eQoKIwoj
IFBhY2tldCBSYWRpbyBwcm90b2NvbHMKIwojIENPTkZJR19BWDI1IGlzIG5vdCBzZXQKIyBD
T05GSUdfQ0FOIGlzIG5vdCBzZXQKIyBDT05GSUdfQlQgaXMgbm90IHNldAojIENPTkZJR19B
Rl9SWFJQQyBpcyBub3Qgc2V0CiMgQ09ORklHX0FGX0tDTSBpcyBub3Qgc2V0CkNPTkZJR19T
VFJFQU1fUEFSU0VSPXkKQ09ORklHX01DVFA9eQpDT05GSUdfRklCX1JVTEVTPXkKQ09ORklH
X1dJUkVMRVNTPXkKQ09ORklHX1dFWFRfQ09SRT15CkNPTkZJR19XRVhUX1BST0M9eQpDT05G
SUdfQ0ZHODAyMTE9bQojIENPTkZJR19OTDgwMjExX1RFU1RNT0RFIGlzIG5vdCBzZXQKIyBD
T05GSUdfQ0ZHODAyMTFfREVWRUxPUEVSX1dBUk5JTkdTIGlzIG5vdCBzZXQKQ09ORklHX0NG
RzgwMjExX1JFUVVJUkVfU0lHTkVEX1JFR0RCPXkKQ09ORklHX0NGRzgwMjExX1VTRV9LRVJO
RUxfUkVHREJfS0VZUz15CkNPTkZJR19DRkc4MDIxMV9ERUZBVUxUX1BTPXkKIyBDT05GSUdf
Q0ZHODAyMTFfREVCVUdGUyBpcyBub3Qgc2V0CkNPTkZJR19DRkc4MDIxMV9DUkRBX1NVUFBP
UlQ9eQpDT05GSUdfQ0ZHODAyMTFfV0VYVD15CiMgQ09ORklHX01BQzgwMjExIGlzIG5vdCBz
ZXQKQ09ORklHX01BQzgwMjExX1NUQV9IQVNIX01BWF9TSVpFPTAKQ09ORklHX1JGS0lMTD1t
CkNPTkZJR19SRktJTExfTEVEUz15CkNPTkZJR19SRktJTExfSU5QVVQ9eQojIENPTkZJR19S
RktJTExfR1BJTyBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF85UCBpcyBub3Qgc2V0CiMgQ09O
RklHX0NBSUYgaXMgbm90IHNldAojIENPTkZJR19DRVBIX0xJQiBpcyBub3Qgc2V0CiMgQ09O
RklHX05GQyBpcyBub3Qgc2V0CiMgQ09ORklHX1BTQU1QTEUgaXMgbm90IHNldAojIENPTkZJ
R19ORVRfSUZFIGlzIG5vdCBzZXQKQ09ORklHX0xXVFVOTkVMPXkKQ09ORklHX0xXVFVOTkVM
X0JQRj15CkNPTkZJR19EU1RfQ0FDSEU9eQpDT05GSUdfR1JPX0NFTExTPXkKQ09ORklHX05F
VF9TT0NLX01TRz15CkNPTkZJR19QQUdFX1BPT0w9eQpDT05GSUdfUEFHRV9QT09MX1NUQVRT
PXkKQ09ORklHX0ZBSUxPVkVSPW0KQ09ORklHX0VUSFRPT0xfTkVUTElOSz15CgojCiMgRGV2
aWNlIERyaXZlcnMKIwpDT05GSUdfSEFWRV9FSVNBPXkKIyBDT05GSUdfRUlTQSBpcyBub3Qg
c2V0CkNPTkZJR19IQVZFX1BDST15CkNPTkZJR19QQ0k9eQpDT05GSUdfUENJX0RPTUFJTlM9
eQpDT05GSUdfUENJRVBPUlRCVVM9eQpDT05GSUdfSE9UUExVR19QQ0lfUENJRT15CkNPTkZJ
R19QQ0lFQUVSPXkKIyBDT05GSUdfUENJRUFFUl9JTkpFQ1QgaXMgbm90IHNldApDT05GSUdf
UENJRV9FQ1JDPXkKQ09ORklHX1BDSUVBU1BNPXkKQ09ORklHX1BDSUVBU1BNX0RFRkFVTFQ9
eQojIENPTkZJR19QQ0lFQVNQTV9QT1dFUlNBVkUgaXMgbm90IHNldAojIENPTkZJR19QQ0lF
QVNQTV9QT1dFUl9TVVBFUlNBVkUgaXMgbm90IHNldAojIENPTkZJR19QQ0lFQVNQTV9QRVJG
T1JNQU5DRSBpcyBub3Qgc2V0CkNPTkZJR19QQ0lFX1BNRT15CkNPTkZJR19QQ0lFX0RQQz15
CkNPTkZJR19QQ0lFX1BUTT15CkNPTkZJR19QQ0lFX0VEUj15CkNPTkZJR19QQ0lfTVNJPXkK
Q09ORklHX1BDSV9RVUlSS1M9eQojIENPTkZJR19QQ0lfREVCVUcgaXMgbm90IHNldAojIENP
TkZJR19QQ0lfUkVBTExPQ19FTkFCTEVfQVVUTyBpcyBub3Qgc2V0CkNPTkZJR19QQ0lfU1RV
Qj15CiMgQ09ORklHX1BDSV9QRl9TVFVCIGlzIG5vdCBzZXQKIyBDT05GSUdfWEVOX1BDSURF
Vl9GUk9OVEVORCBpcyBub3Qgc2V0CkNPTkZJR19QQ0lfQVRTPXkKQ09ORklHX1BDSV9MT0NL
TEVTU19DT05GSUc9eQpDT05GSUdfUENJX0lPVj15CkNPTkZJR19QQ0lfUFJJPXkKQ09ORklH
X1BDSV9QQVNJRD15CkNPTkZJR19QQ0lfUDJQRE1BPXkKQ09ORklHX1BDSV9MQUJFTD15CkNP
TkZJR19WR0FfQVJCPXkKQ09ORklHX1ZHQV9BUkJfTUFYX0dQVVM9MTAKQ09ORklHX0hPVFBM
VUdfUENJPXkKQ09ORklHX0hPVFBMVUdfUENJX0FDUEk9eQojIENPTkZJR19IT1RQTFVHX1BD
SV9BQ1BJX0lCTSBpcyBub3Qgc2V0CkNPTkZJR19IT1RQTFVHX1BDSV9DUENJPXkKIyBDT05G
SUdfSE9UUExVR19QQ0lfQ1BDSV9aVDU1NTAgaXMgbm90IHNldAojIENPTkZJR19IT1RQTFVH
X1BDSV9DUENJX0dFTkVSSUMgaXMgbm90IHNldApDT05GSUdfSE9UUExVR19QQ0lfU0hQQz15
CgojCiMgUENJIGNvbnRyb2xsZXIgZHJpdmVycwojCiMgQ09ORklHX1ZNRCBpcyBub3Qgc2V0
CgojCiMgQ2FkZW5jZS1iYXNlZCBQQ0llIGNvbnRyb2xsZXJzCiMKIyBlbmQgb2YgQ2FkZW5j
ZS1iYXNlZCBQQ0llIGNvbnRyb2xsZXJzCgojCiMgRGVzaWduV2FyZS1iYXNlZCBQQ0llIGNv
bnRyb2xsZXJzCiMKQ09ORklHX1BDSUVfRFc9eQpDT05GSUdfUENJRV9EV19IT1NUPXkKQ09O
RklHX1BDSV9NRVNPTj15CkNPTkZJR19QQ0lFX0RXX1BMQVQ9eQpDT05GSUdfUENJRV9EV19Q
TEFUX0hPU1Q9eQojIGVuZCBvZiBEZXNpZ25XYXJlLWJhc2VkIFBDSWUgY29udHJvbGxlcnMK
CiMKIyBNb2JpdmVpbC1iYXNlZCBQQ0llIGNvbnRyb2xsZXJzCiMKIyBlbmQgb2YgTW9iaXZl
aWwtYmFzZWQgUENJZSBjb250cm9sbGVycwojIGVuZCBvZiBQQ0kgY29udHJvbGxlciBkcml2
ZXJzCgojCiMgUENJIEVuZHBvaW50CiMKIyBDT05GSUdfUENJX0VORFBPSU5UIGlzIG5vdCBz
ZXQKIyBlbmQgb2YgUENJIEVuZHBvaW50CgojCiMgUENJIHN3aXRjaCBjb250cm9sbGVyIGRy
aXZlcnMKIwojIENPTkZJR19QQ0lfU1dfU1dJVENIVEVDIGlzIG5vdCBzZXQKIyBlbmQgb2Yg
UENJIHN3aXRjaCBjb250cm9sbGVyIGRyaXZlcnMKCiMgQ09ORklHX0NYTF9CVVMgaXMgbm90
IHNldAojIENPTkZJR19QQ0NBUkQgaXMgbm90IHNldAojIENPTkZJR19SQVBJRElPIGlzIG5v
dCBzZXQKCiMKIyBHZW5lcmljIERyaXZlciBPcHRpb25zCiMKQ09ORklHX0FVWElMSUFSWV9C
VVM9eQojIENPTkZJR19VRVZFTlRfSEVMUEVSIGlzIG5vdCBzZXQKQ09ORklHX0RFVlRNUEZT
PXkKQ09ORklHX0RFVlRNUEZTX01PVU5UPXkKQ09ORklHX0RFVlRNUEZTX1NBRkU9eQpDT05G
SUdfU1RBTkRBTE9ORT15CkNPTkZJR19QUkVWRU5UX0ZJUk1XQVJFX0JVSUxEPXkKCiMKIyBG
aXJtd2FyZSBsb2FkZXIKIwpDT05GSUdfRldfTE9BREVSPXkKQ09ORklHX0ZXX0xPQURFUl9E
RUJVRz15CkNPTkZJR19GV19MT0FERVJfUEFHRURfQlVGPXkKQ09ORklHX0ZXX0xPQURFUl9T
WVNGUz15CkNPTkZJR19FWFRSQV9GSVJNV0FSRT0iIgojIENPTkZJR19GV19MT0FERVJfVVNF
Ul9IRUxQRVIgaXMgbm90IHNldApDT05GSUdfRldfTE9BREVSX0NPTVBSRVNTPXkKQ09ORklH
X0ZXX0xPQURFUl9DT01QUkVTU19YWj15CkNPTkZJR19GV19MT0FERVJfQ09NUFJFU1NfWlNU
RD15CkNPTkZJR19GV19DQUNIRT15CkNPTkZJR19GV19VUExPQUQ9eQojIGVuZCBvZiBGaXJt
d2FyZSBsb2FkZXIKCkNPTkZJR19XQU5UX0RFVl9DT1JFRFVNUD15CkNPTkZJR19BTExPV19E
RVZfQ09SRURVTVA9eQpDT05GSUdfREVWX0NPUkVEVU1QPXkKIyBDT05GSUdfREVCVUdfRFJJ
VkVSIGlzIG5vdCBzZXQKIyBDT05GSUdfREVCVUdfREVWUkVTIGlzIG5vdCBzZXQKIyBDT05G
SUdfREVCVUdfVEVTVF9EUklWRVJfUkVNT1ZFIGlzIG5vdCBzZXQKQ09ORklHX0hNRU1fUkVQ
T1JUSU5HPXkKIyBDT05GSUdfVEVTVF9BU1lOQ19EUklWRVJfUFJPQkUgaXMgbm90IHNldApD
T05GSUdfU1lTX0hZUEVSVklTT1I9eQpDT05GSUdfR0VORVJJQ19DUFVfREVWSUNFUz15CkNP
TkZJR19HRU5FUklDX0NQVV9BVVRPUFJPQkU9eQpDT05GSUdfR0VORVJJQ19DUFVfVlVMTkVS
QUJJTElUSUVTPXkKQ09ORklHX1JFR01BUD15CkNPTkZJR19SRUdNQVBfSTJDPXkKQ09ORklH
X1JFR01BUF9TUEk9eQpDT05GSUdfUkVHTUFQX01NSU89eQpDT05GSUdfUkVHTUFQX0lSUT15
CkNPTkZJR19ETUFfU0hBUkVEX0JVRkZFUj15CiMgQ09ORklHX0RNQV9GRU5DRV9UUkFDRSBp
cyBub3Qgc2V0CiMgQ09ORklHX0ZXX0RFVkxJTktfU1lOQ19TVEFURV9USU1FT1VUIGlzIG5v
dCBzZXQKIyBlbmQgb2YgR2VuZXJpYyBEcml2ZXIgT3B0aW9ucwoKIwojIEJ1cyBkZXZpY2Vz
CiMKIyBDT05GSUdfTUhJX0JVUyBpcyBub3Qgc2V0CiMgQ09ORklHX01ISV9CVVNfRVAgaXMg
bm90IHNldAojIGVuZCBvZiBCdXMgZGV2aWNlcwoKIwojIENhY2hlIERyaXZlcnMKIwojIGVu
ZCBvZiBDYWNoZSBEcml2ZXJzCgpDT05GSUdfQ09OTkVDVE9SPXkKQ09ORklHX1BST0NfRVZF
TlRTPXkKCiMKIyBGaXJtd2FyZSBEcml2ZXJzCiMKCiMKIyBBUk0gU3lzdGVtIENvbnRyb2wg
YW5kIE1hbmFnZW1lbnQgSW50ZXJmYWNlIFByb3RvY29sCiMKIyBlbmQgb2YgQVJNIFN5c3Rl
bSBDb250cm9sIGFuZCBNYW5hZ2VtZW50IEludGVyZmFjZSBQcm90b2NvbAoKIyBDT05GSUdf
RUREIGlzIG5vdCBzZXQKQ09ORklHX0ZJUk1XQVJFX01FTU1BUD15CkNPTkZJR19ETUlJRD15
CkNPTkZJR19ETUlfU1lTRlM9bQpDT05GSUdfRE1JX1NDQU5fTUFDSElORV9OT05fRUZJX0ZB
TExCQUNLPXkKIyBDT05GSUdfSVNDU0lfSUJGVCBpcyBub3Qgc2V0CkNPTkZJR19GV19DRkdf
U1lTRlM9bQojIENPTkZJR19GV19DRkdfU1lTRlNfQ01ETElORSBpcyBub3Qgc2V0CkNPTkZJ
R19TWVNGQj15CkNPTkZJR19TWVNGQl9TSU1QTEVGQj15CkNPTkZJR19HT09HTEVfRklSTVdB
UkU9eQojIENPTkZJR19HT09HTEVfU01JIGlzIG5vdCBzZXQKIyBDT05GSUdfR09PR0xFX0NP
UkVCT09UX1RBQkxFIGlzIG5vdCBzZXQKIyBDT05GSUdfR09PR0xFX01FTUNPTlNPTEVfWDg2
X0xFR0FDWSBpcyBub3Qgc2V0CgojCiMgRUZJIChFeHRlbnNpYmxlIEZpcm13YXJlIEludGVy
ZmFjZSkgU3VwcG9ydAojCkNPTkZJR19FRklfRVNSVD15CkNPTkZJR19FRklfVkFSU19QU1RP
UkU9eQpDT05GSUdfRUZJX1ZBUlNfUFNUT1JFX0RFRkFVTFRfRElTQUJMRT15CkNPTkZJR19F
RklfU09GVF9SRVNFUlZFPXkKQ09ORklHX0VGSV9EWEVfTUVNX0FUVFJJQlVURVM9eQpDT05G
SUdfRUZJX1JVTlRJTUVfV1JBUFBFUlM9eQojIENPTkZJR19FRklfQk9PVExPQURFUl9DT05U
Uk9MIGlzIG5vdCBzZXQKIyBDT05GSUdfRUZJX0NBUFNVTEVfTE9BREVSIGlzIG5vdCBzZXQK
IyBDT05GSUdfRUZJX1RFU1QgaXMgbm90IHNldApDT05GSUdfRUZJX0RFVl9QQVRIX1BBUlNF
Uj15CkNPTkZJR19BUFBMRV9QUk9QRVJUSUVTPXkKQ09ORklHX1JFU0VUX0FUVEFDS19NSVRJ
R0FUSU9OPXkKQ09ORklHX0VGSV9SQ0kyX1RBQkxFPXkKQ09ORklHX0VGSV9ESVNBQkxFX1BD
SV9ETUE9eQpDT05GSUdfRUZJX0VBUkxZQ09OPXkKQ09ORklHX0VGSV9DVVNUT01fU1NEVF9P
VkVSTEFZUz15CiMgQ09ORklHX0VGSV9ESVNBQkxFX1JVTlRJTUUgaXMgbm90IHNldApDT05G
SUdfRUZJX0NPQ09fU0VDUkVUPXkKQ09ORklHX1VOQUNDRVBURURfTUVNT1JZPXkKIyBlbmQg
b2YgRUZJIChFeHRlbnNpYmxlIEZpcm13YXJlIEludGVyZmFjZSkgU3VwcG9ydAoKQ09ORklH
X1VFRklfQ1BFUj15CkNPTkZJR19VRUZJX0NQRVJfWDg2PXkKCiMKIyBRdWFsY29tbSBmaXJt
d2FyZSBkcml2ZXJzCiMKIyBlbmQgb2YgUXVhbGNvbW0gZmlybXdhcmUgZHJpdmVycwoKIwoj
IFRlZ3JhIGZpcm13YXJlIGRyaXZlcgojCiMgZW5kIG9mIFRlZ3JhIGZpcm13YXJlIGRyaXZl
cgojIGVuZCBvZiBGaXJtd2FyZSBEcml2ZXJzCgojIENPTkZJR19HTlNTIGlzIG5vdCBzZXQK
IyBDT05GSUdfTVREIGlzIG5vdCBzZXQKIyBDT05GSUdfT0YgaXMgbm90IHNldApDT05GSUdf
QVJDSF9NSUdIVF9IQVZFX1BDX1BBUlBPUlQ9eQojIENPTkZJR19QQVJQT1JUIGlzIG5vdCBz
ZXQKQ09ORklHX1BOUD15CkNPTkZJR19QTlBfREVCVUdfTUVTU0FHRVM9eQoKIwojIFByb3Rv
Y29scwojCkNPTkZJR19QTlBBQ1BJPXkKQ09ORklHX0JMS19ERVY9eQojIENPTkZJR19CTEtf
REVWX05VTExfQkxLIGlzIG5vdCBzZXQKIyBDT05GSUdfQkxLX0RFVl9GRCBpcyBub3Qgc2V0
CiMgQ09ORklHX0JMS19ERVZfUENJRVNTRF9NVElQMzJYWCBpcyBub3Qgc2V0CiMgQ09ORklH
X1pSQU0gaXMgbm90IHNldApDT05GSUdfQkxLX0RFVl9MT09QPW0KQ09ORklHX0JMS19ERVZf
TE9PUF9NSU5fQ09VTlQ9MAojIENPTkZJR19CTEtfREVWX0RSQkQgaXMgbm90IHNldAojIENP
TkZJR19CTEtfREVWX05CRCBpcyBub3Qgc2V0CiMgQ09ORklHX0JMS19ERVZfUkFNIGlzIG5v
dCBzZXQKIyBDT05GSUdfQ0RST01fUEtUQ0RWRCBpcyBub3Qgc2V0CiMgQ09ORklHX0FUQV9P
VkVSX0VUSCBpcyBub3Qgc2V0CiMgQ09ORklHX1hFTl9CTEtERVZfRlJPTlRFTkQgaXMgbm90
IHNldAojIENPTkZJR19YRU5fQkxLREVWX0JBQ0tFTkQgaXMgbm90IHNldApDT05GSUdfVklS
VElPX0JMSz1tCiMgQ09ORklHX0JMS19ERVZfUkJEIGlzIG5vdCBzZXQKIyBDT05GSUdfQkxL
X0RFVl9VQkxLIGlzIG5vdCBzZXQKCiMKIyBOVk1FIFN1cHBvcnQKIwojIENPTkZJR19CTEtf
REVWX05WTUUgaXMgbm90IHNldAojIENPTkZJR19OVk1FX0ZDIGlzIG5vdCBzZXQKIyBDT05G
SUdfTlZNRV9UQ1AgaXMgbm90IHNldAojIENPTkZJR19OVk1FX1RBUkdFVCBpcyBub3Qgc2V0
CiMgZW5kIG9mIE5WTUUgU3VwcG9ydAoKIwojIE1pc2MgZGV2aWNlcwojCiMgQ09ORklHX0FE
NTI1WF9EUE9UIGlzIG5vdCBzZXQKIyBDT05GSUdfRFVNTVlfSVJRIGlzIG5vdCBzZXQKIyBD
T05GSUdfSUJNX0FTTSBpcyBub3Qgc2V0CiMgQ09ORklHX1BIQU5UT00gaXMgbm90IHNldAoj
IENPTkZJR19USUZNX0NPUkUgaXMgbm90IHNldAojIENPTkZJR19JQ1M5MzJTNDAxIGlzIG5v
dCBzZXQKIyBDT05GSUdfRU5DTE9TVVJFX1NFUlZJQ0VTIGlzIG5vdCBzZXQKIyBDT05GSUdf
SFBfSUxPIGlzIG5vdCBzZXQKIyBDT05GSUdfQVBEUzk4MDJBTFMgaXMgbm90IHNldAojIENP
TkZJR19JU0wyOTAwMyBpcyBub3Qgc2V0CiMgQ09ORklHX0lTTDI5MDIwIGlzIG5vdCBzZXQK
IyBDT05GSUdfU0VOU09SU19UU0wyNTUwIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19C
SDE3NzAgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX0FQRFM5OTBYIGlzIG5vdCBzZXQK
IyBDT05GSUdfSE1DNjM1MiBpcyBub3Qgc2V0CiMgQ09ORklHX0RTMTY4MiBpcyBub3Qgc2V0
CiMgQ09ORklHX0xBVFRJQ0VfRUNQM19DT05GSUcgaXMgbm90IHNldAojIENPTkZJR19TUkFN
IGlzIG5vdCBzZXQKIyBDT05GSUdfRFdfWERBVEFfUENJRSBpcyBub3Qgc2V0CiMgQ09ORklH
X1BDSV9FTkRQT0lOVF9URVNUIGlzIG5vdCBzZXQKIyBDT05GSUdfWElMSU5YX1NERkVDIGlz
IG5vdCBzZXQKIyBDT05GSUdfTlNNIGlzIG5vdCBzZXQKIyBDT05GSUdfQzJQT1JUIGlzIG5v
dCBzZXQKCiMKIyBFRVBST00gc3VwcG9ydAojCiMgQ09ORklHX0VFUFJPTV9BVDI0IGlzIG5v
dCBzZXQKIyBDT05GSUdfRUVQUk9NX0FUMjUgaXMgbm90IHNldAojIENPTkZJR19FRVBST01f
TUFYNjg3NSBpcyBub3Qgc2V0CiMgQ09ORklHX0VFUFJPTV85M0NYNiBpcyBub3Qgc2V0CiMg
Q09ORklHX0VFUFJPTV85M1hYNDYgaXMgbm90IHNldAojIENPTkZJR19FRVBST01fSURUXzg5
SFBFU1ggaXMgbm90IHNldAojIENPTkZJR19FRVBST01fRUUxMDA0IGlzIG5vdCBzZXQKIyBl
bmQgb2YgRUVQUk9NIHN1cHBvcnQKCiMgQ09ORklHX0NCNzEwX0NPUkUgaXMgbm90IHNldAoK
IwojIFRleGFzIEluc3RydW1lbnRzIHNoYXJlZCB0cmFuc3BvcnQgbGluZSBkaXNjaXBsaW5l
CiMKIyBDT05GSUdfVElfU1QgaXMgbm90IHNldAojIGVuZCBvZiBUZXhhcyBJbnN0cnVtZW50
cyBzaGFyZWQgdHJhbnNwb3J0IGxpbmUgZGlzY2lwbGluZQoKIyBDT05GSUdfU0VOU09SU19M
SVMzX0kyQyBpcyBub3Qgc2V0CiMgQ09ORklHX0FMVEVSQV9TVEFQTCBpcyBub3Qgc2V0CiMg
Q09ORklHX0lOVEVMX01FSSBpcyBub3Qgc2V0CiMgQ09ORklHX1ZNV0FSRV9WTUNJIGlzIG5v
dCBzZXQKIyBDT05GSUdfR0VOV1FFIGlzIG5vdCBzZXQKIyBDT05GSUdfRUNITyBpcyBub3Qg
c2V0CiMgQ09ORklHX0JDTV9WSyBpcyBub3Qgc2V0CiMgQ09ORklHX01JU0NfQUxDT1JfUENJ
IGlzIG5vdCBzZXQKIyBDT05GSUdfTUlTQ19SVFNYX1BDSSBpcyBub3Qgc2V0CiMgQ09ORklH
X01JU0NfUlRTWF9VU0IgaXMgbm90IHNldAojIENPTkZJR19VQUNDRSBpcyBub3Qgc2V0CkNP
TkZJR19QVlBBTklDPXkKIyBDT05GSUdfUFZQQU5JQ19NTUlPIGlzIG5vdCBzZXQKIyBDT05G
SUdfUFZQQU5JQ19QQ0kgaXMgbm90IHNldAojIENPTkZJR19HUF9QQ0kxWFhYWCBpcyBub3Qg
c2V0CiMgZW5kIG9mIE1pc2MgZGV2aWNlcwoKIwojIFNDU0kgZGV2aWNlIHN1cHBvcnQKIwpD
T05GSUdfU0NTSV9NT0Q9eQojIENPTkZJR19SQUlEX0FUVFJTIGlzIG5vdCBzZXQKQ09ORklH
X1NDU0lfQ09NTU9OPXkKQ09ORklHX1NDU0k9eQpDT05GSUdfU0NTSV9ETUE9eQpDT05GSUdf
U0NTSV9QUk9DX0ZTPXkKCiMKIyBTQ1NJIHN1cHBvcnQgdHlwZSAoZGlzaywgdGFwZSwgQ0Qt
Uk9NKQojCkNPTkZJR19CTEtfREVWX1NEPXkKIyBDT05GSUdfQ0hSX0RFVl9TVCBpcyBub3Qg
c2V0CiMgQ09ORklHX0JMS19ERVZfU1IgaXMgbm90IHNldAojIENPTkZJR19DSFJfREVWX1NH
IGlzIG5vdCBzZXQKQ09ORklHX0JMS19ERVZfQlNHPXkKIyBDT05GSUdfQ0hSX0RFVl9TQ0gg
aXMgbm90IHNldApDT05GSUdfU0NTSV9DT05TVEFOVFM9eQpDT05GSUdfU0NTSV9MT0dHSU5H
PXkKQ09ORklHX1NDU0lfU0NBTl9BU1lOQz15CgojCiMgU0NTSSBUcmFuc3BvcnRzCiMKIyBD
T05GSUdfU0NTSV9TUElfQVRUUlMgaXMgbm90IHNldAojIENPTkZJR19TQ1NJX0ZDX0FUVFJT
IGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9JU0NTSV9BVFRSUyBpcyBub3Qgc2V0CiMgQ09O
RklHX1NDU0lfU0FTX0FUVFJTIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9TQVNfTElCU0FT
IGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9TUlBfQVRUUlMgaXMgbm90IHNldAojIGVuZCBv
ZiBTQ1NJIFRyYW5zcG9ydHMKCkNPTkZJR19TQ1NJX0xPV0xFVkVMPXkKIyBDT05GSUdfSVND
U0lfVENQIGlzIG5vdCBzZXQKIyBDT05GSUdfSVNDU0lfQk9PVF9TWVNGUyBpcyBub3Qgc2V0
CiMgQ09ORklHX1NDU0lfQ1hHQjNfSVNDU0kgaXMgbm90IHNldAojIENPTkZJR19TQ1NJX0NY
R0I0X0lTQ1NJIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9CTlgyX0lTQ1NJIGlzIG5vdCBz
ZXQKIyBDT05GSUdfQkUySVNDU0kgaXMgbm90IHNldAojIENPTkZJR19CTEtfREVWXzNXX1hY
WFhfUkFJRCBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfSFBTQSBpcyBub3Qgc2V0CiMgQ09O
RklHX1NDU0lfM1dfOVhYWCBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfM1dfU0FTIGlzIG5v
dCBzZXQKIyBDT05GSUdfU0NTSV9BQ0FSRCBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfQUFD
UkFJRCBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfQUlDN1hYWCBpcyBub3Qgc2V0CiMgQ09O
RklHX1NDU0lfQUlDNzlYWCBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfQUlDOTRYWCBpcyBu
b3Qgc2V0CiMgQ09ORklHX1NDU0lfTVZTQVMgaXMgbm90IHNldAojIENPTkZJR19TQ1NJX01W
VU1JIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9BRFZBTlNZUyBpcyBub3Qgc2V0CiMgQ09O
RklHX1NDU0lfQVJDTVNSIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9FU0FTMlIgaXMgbm90
IHNldApDT05GSUdfTUVHQVJBSURfTkVXR0VOPXkKIyBDT05GSUdfTUVHQVJBSURfTU0gaXMg
bm90IHNldAojIENPTkZJR19NRUdBUkFJRF9MRUdBQ1kgaXMgbm90IHNldAojIENPTkZJR19N
RUdBUkFJRF9TQVMgaXMgbm90IHNldAojIENPTkZJR19TQ1NJX01QVDNTQVMgaXMgbm90IHNl
dAojIENPTkZJR19TQ1NJX01QVDJTQVMgaXMgbm90IHNldAojIENPTkZJR19TQ1NJX01QSTNN
UiBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfU01BUlRQUUkgaXMgbm90IHNldAojIENPTkZJ
R19TQ1NJX0hQVElPUCBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfQlVTTE9HSUMgaXMgbm90
IHNldAojIENPTkZJR19TQ1NJX01ZUkIgaXMgbm90IHNldAojIENPTkZJR19TQ1NJX01ZUlMg
aXMgbm90IHNldAojIENPTkZJR19WTVdBUkVfUFZTQ1NJIGlzIG5vdCBzZXQKIyBDT05GSUdf
WEVOX1NDU0lfRlJPTlRFTkQgaXMgbm90IHNldAojIENPTkZJR19TQ1NJX1NOSUMgaXMgbm90
IHNldAojIENPTkZJR19TQ1NJX0RNWDMxOTFEIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9G
RE9NQUlOX1BDSSBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfSVNDSSBpcyBub3Qgc2V0CiMg
Q09ORklHX1NDU0lfSVBTIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9JTklUSU8gaXMgbm90
IHNldAojIENPTkZJR19TQ1NJX0lOSUExMDAgaXMgbm90IHNldAojIENPTkZJR19TQ1NJX1NU
RVggaXMgbm90IHNldAojIENPTkZJR19TQ1NJX1NZTTUzQzhYWF8yIGlzIG5vdCBzZXQKIyBD
T05GSUdfU0NTSV9JUFIgaXMgbm90IHNldAojIENPTkZJR19TQ1NJX1FMT0dJQ18xMjgwIGlz
IG5vdCBzZXQKIyBDT05GSUdfU0NTSV9RTEFfSVNDU0kgaXMgbm90IHNldAojIENPTkZJR19T
Q1NJX0RDMzk1eCBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfQU01M0M5NzQgaXMgbm90IHNl
dAojIENPTkZJR19TQ1NJX1dENzE5WCBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfREVCVUcg
aXMgbm90IHNldAojIENPTkZJR19TQ1NJX1BNQ1JBSUQgaXMgbm90IHNldAojIENPTkZJR19T
Q1NJX1BNODAwMSBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfVklSVElPIGlzIG5vdCBzZXQK
Q09ORklHX1NDU0lfREg9eQojIENPTkZJR19TQ1NJX0RIX1JEQUMgaXMgbm90IHNldAojIENP
TkZJR19TQ1NJX0RIX0hQX1NXIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9ESF9FTUMgaXMg
bm90IHNldAojIENPTkZJR19TQ1NJX0RIX0FMVUEgaXMgbm90IHNldAojIGVuZCBvZiBTQ1NJ
IGRldmljZSBzdXBwb3J0CgpDT05GSUdfQVRBPXkKQ09ORklHX1NBVEFfSE9TVD15CkNPTkZJ
R19QQVRBX1RJTUlOR1M9eQpDT05GSUdfQVRBX1ZFUkJPU0VfRVJST1I9eQpDT05GSUdfQVRB
X0ZPUkNFPXkKQ09ORklHX0FUQV9BQ1BJPXkKQ09ORklHX1NBVEFfWlBPREQ9eQpDT05GSUdf
U0FUQV9QTVA9eQoKIwojIENvbnRyb2xsZXJzIHdpdGggbm9uLVNGRiBuYXRpdmUgaW50ZXJm
YWNlCiMKQ09ORklHX1NBVEFfQUhDST15CkNPTkZJR19TQVRBX01PQklMRV9MUE1fUE9MSUNZ
PTMKIyBDT05GSUdfU0FUQV9BSENJX1BMQVRGT1JNIGlzIG5vdCBzZXQKIyBDT05GSUdfQUhD
SV9EV0MgaXMgbm90IHNldAojIENPTkZJR19TQVRBX0lOSUMxNjJYIGlzIG5vdCBzZXQKIyBD
T05GSUdfU0FUQV9BQ0FSRF9BSENJIGlzIG5vdCBzZXQKIyBDT05GSUdfU0FUQV9TSUwyNCBp
cyBub3Qgc2V0CkNPTkZJR19BVEFfU0ZGPXkKCiMKIyBTRkYgY29udHJvbGxlcnMgd2l0aCBj
dXN0b20gRE1BIGludGVyZmFjZQojCiMgQ09ORklHX1BEQ19BRE1BIGlzIG5vdCBzZXQKIyBD
T05GSUdfU0FUQV9RU1RPUiBpcyBub3Qgc2V0CiMgQ09ORklHX1NBVEFfU1g0IGlzIG5vdCBz
ZXQKQ09ORklHX0FUQV9CTURNQT15CgojCiMgU0FUQSBTRkYgY29udHJvbGxlcnMgd2l0aCBC
TURNQQojCiMgQ09ORklHX0FUQV9QSUlYIGlzIG5vdCBzZXQKIyBDT05GSUdfU0FUQV9EV0Mg
aXMgbm90IHNldAojIENPTkZJR19TQVRBX01WIGlzIG5vdCBzZXQKIyBDT05GSUdfU0FUQV9O
ViBpcyBub3Qgc2V0CiMgQ09ORklHX1NBVEFfUFJPTUlTRSBpcyBub3Qgc2V0CiMgQ09ORklH
X1NBVEFfU0lMIGlzIG5vdCBzZXQKIyBDT05GSUdfU0FUQV9TSVMgaXMgbm90IHNldAojIENP
TkZJR19TQVRBX1NWVyBpcyBub3Qgc2V0CiMgQ09ORklHX1NBVEFfVUxJIGlzIG5vdCBzZXQK
IyBDT05GSUdfU0FUQV9WSUEgaXMgbm90IHNldAojIENPTkZJR19TQVRBX1ZJVEVTU0UgaXMg
bm90IHNldAoKIwojIFBBVEEgU0ZGIGNvbnRyb2xsZXJzIHdpdGggQk1ETUEKIwojIENPTkZJ
R19QQVRBX0FMSSBpcyBub3Qgc2V0CiMgQ09ORklHX1BBVEFfQU1EIGlzIG5vdCBzZXQKIyBD
T05GSUdfUEFUQV9BUlRPUCBpcyBub3Qgc2V0CiMgQ09ORklHX1BBVEFfQVRJSVhQIGlzIG5v
dCBzZXQKIyBDT05GSUdfUEFUQV9BVFA4NjdYIGlzIG5vdCBzZXQKIyBDT05GSUdfUEFUQV9D
TUQ2NFggaXMgbm90IHNldAojIENPTkZJR19QQVRBX0NZUFJFU1MgaXMgbm90IHNldAojIENP
TkZJR19QQVRBX0VGQVIgaXMgbm90IHNldAojIENPTkZJR19QQVRBX0hQVDM2NiBpcyBub3Qg
c2V0CiMgQ09ORklHX1BBVEFfSFBUMzdYIGlzIG5vdCBzZXQKIyBDT05GSUdfUEFUQV9IUFQz
WDJOIGlzIG5vdCBzZXQKIyBDT05GSUdfUEFUQV9IUFQzWDMgaXMgbm90IHNldAojIENPTkZJ
R19QQVRBX0lUODIxMyBpcyBub3Qgc2V0CiMgQ09ORklHX1BBVEFfSVQ4MjFYIGlzIG5vdCBz
ZXQKIyBDT05GSUdfUEFUQV9KTUlDUk9OIGlzIG5vdCBzZXQKIyBDT05GSUdfUEFUQV9NQVJW
RUxMIGlzIG5vdCBzZXQKIyBDT05GSUdfUEFUQV9ORVRDRUxMIGlzIG5vdCBzZXQKIyBDT05G
SUdfUEFUQV9OSU5KQTMyIGlzIG5vdCBzZXQKIyBDT05GSUdfUEFUQV9OUzg3NDE1IGlzIG5v
dCBzZXQKIyBDT05GSUdfUEFUQV9PTERQSUlYIGlzIG5vdCBzZXQKIyBDT05GSUdfUEFUQV9P
UFRJRE1BIGlzIG5vdCBzZXQKIyBDT05GSUdfUEFUQV9QREMyMDI3WCBpcyBub3Qgc2V0CiMg
Q09ORklHX1BBVEFfUERDX09MRCBpcyBub3Qgc2V0CiMgQ09ORklHX1BBVEFfUkFESVNZUyBp
cyBub3Qgc2V0CiMgQ09ORklHX1BBVEFfUkRDIGlzIG5vdCBzZXQKIyBDT05GSUdfUEFUQV9T
Q0ggaXMgbm90IHNldAojIENPTkZJR19QQVRBX1NFUlZFUldPUktTIGlzIG5vdCBzZXQKIyBD
T05GSUdfUEFUQV9TSUw2ODAgaXMgbm90IHNldAojIENPTkZJR19QQVRBX1NJUyBpcyBub3Qg
c2V0CiMgQ09ORklHX1BBVEFfVE9TSElCQSBpcyBub3Qgc2V0CiMgQ09ORklHX1BBVEFfVFJJ
RkxFWCBpcyBub3Qgc2V0CiMgQ09ORklHX1BBVEFfVklBIGlzIG5vdCBzZXQKIyBDT05GSUdf
UEFUQV9XSU5CT05EIGlzIG5vdCBzZXQKCiMKIyBQSU8tb25seSBTRkYgY29udHJvbGxlcnMK
IwojIENPTkZJR19QQVRBX0NNRDY0MF9QQ0kgaXMgbm90IHNldAojIENPTkZJR19QQVRBX01Q
SUlYIGlzIG5vdCBzZXQKIyBDT05GSUdfUEFUQV9OUzg3NDEwIGlzIG5vdCBzZXQKIyBDT05G
SUdfUEFUQV9PUFRJIGlzIG5vdCBzZXQKIyBDT05GSUdfUEFUQV9SWjEwMDAgaXMgbm90IHNl
dAoKIwojIEdlbmVyaWMgZmFsbGJhY2sgLyBsZWdhY3kgZHJpdmVycwojCiMgQ09ORklHX1BB
VEFfQUNQSSBpcyBub3Qgc2V0CiMgQ09ORklHX0FUQV9HRU5FUklDIGlzIG5vdCBzZXQKIyBD
T05GSUdfUEFUQV9MRUdBQ1kgaXMgbm90IHNldApDT05GSUdfTUQ9eQojIENPTkZJR19CTEtf
REVWX01EIGlzIG5vdCBzZXQKQ09ORklHX01EX0JJVE1BUF9GSUxFPXkKIyBDT05GSUdfQkNB
Q0hFIGlzIG5vdCBzZXQKQ09ORklHX0JMS19ERVZfRE1fQlVJTFRJTj15CkNPTkZJR19CTEtf
REVWX0RNPW0KIyBDT05GSUdfRE1fREVCVUcgaXMgbm90IHNldAojIENPTkZJR19ETV9VTlNU
UklQRUQgaXMgbm90IHNldAojIENPTkZJR19ETV9DUllQVCBpcyBub3Qgc2V0CiMgQ09ORklH
X0RNX1NOQVBTSE9UIGlzIG5vdCBzZXQKIyBDT05GSUdfRE1fVEhJTl9QUk9WSVNJT05JTkcg
aXMgbm90IHNldAojIENPTkZJR19ETV9DQUNIRSBpcyBub3Qgc2V0CiMgQ09ORklHX0RNX1dS
SVRFQ0FDSEUgaXMgbm90IHNldAojIENPTkZJR19ETV9FQlMgaXMgbm90IHNldAojIENPTkZJ
R19ETV9FUkEgaXMgbm90IHNldAojIENPTkZJR19ETV9DTE9ORSBpcyBub3Qgc2V0CiMgQ09O
RklHX0RNX01JUlJPUiBpcyBub3Qgc2V0CiMgQ09ORklHX0RNX1JBSUQgaXMgbm90IHNldAoj
IENPTkZJR19ETV9aRVJPIGlzIG5vdCBzZXQKIyBDT05GSUdfRE1fTVVMVElQQVRIIGlzIG5v
dCBzZXQKIyBDT05GSUdfRE1fREVMQVkgaXMgbm90IHNldAojIENPTkZJR19ETV9EVVNUIGlz
IG5vdCBzZXQKQ09ORklHX0RNX1VFVkVOVD15CiMgQ09ORklHX0RNX0ZMQUtFWSBpcyBub3Qg
c2V0CiMgQ09ORklHX0RNX1ZFUklUWSBpcyBub3Qgc2V0CiMgQ09ORklHX0RNX1NXSVRDSCBp
cyBub3Qgc2V0CiMgQ09ORklHX0RNX0xPR19XUklURVMgaXMgbm90IHNldAojIENPTkZJR19E
TV9JTlRFR1JJVFkgaXMgbm90IHNldAojIENPTkZJR19ETV9aT05FRCBpcyBub3Qgc2V0CkNP
TkZJR19ETV9BVURJVD15CiMgQ09ORklHX1RBUkdFVF9DT1JFIGlzIG5vdCBzZXQKQ09ORklH
X0ZVU0lPTj15CiMgQ09ORklHX0ZVU0lPTl9TUEkgaXMgbm90IHNldAojIENPTkZJR19GVVNJ
T05fU0FTIGlzIG5vdCBzZXQKQ09ORklHX0ZVU0lPTl9NQVhfU0dFPTEyOAojIENPTkZJR19G
VVNJT05fTE9HR0lORyBpcyBub3Qgc2V0CgojCiMgSUVFRSAxMzk0IChGaXJlV2lyZSkgc3Vw
cG9ydAojCiMgQ09ORklHX0ZJUkVXSVJFIGlzIG5vdCBzZXQKIyBDT05GSUdfRklSRVdJUkVf
Tk9TWSBpcyBub3Qgc2V0CiMgZW5kIG9mIElFRUUgMTM5NCAoRmlyZVdpcmUpIHN1cHBvcnQK
CkNPTkZJR19NQUNJTlRPU0hfRFJJVkVSUz15CkNPTkZJR19NQUNfRU1VTU9VU0VCVE49bQpD
T05GSUdfTkVUREVWSUNFUz15CkNPTkZJR19ORVRfQ09SRT15CiMgQ09ORklHX0JPTkRJTkcg
aXMgbm90IHNldAojIENPTkZJR19EVU1NWSBpcyBub3Qgc2V0CkNPTkZJR19XSVJFR1VBUkQ9
bQojIENPTkZJR19XSVJFR1VBUkRfREVCVUcgaXMgbm90IHNldAojIENPTkZJR19FUVVBTEla
RVIgaXMgbm90IHNldApDT05GSUdfTkVUX0ZDPXkKIyBDT05GSUdfTkVUX1RFQU0gaXMgbm90
IHNldAojIENPTkZJR19NQUNWTEFOIGlzIG5vdCBzZXQKIyBDT05GSUdfSVBWTEFOIGlzIG5v
dCBzZXQKIyBDT05GSUdfVlhMQU4gaXMgbm90IHNldAojIENPTkZJR19HRU5FVkUgaXMgbm90
IHNldAojIENPTkZJR19CQVJFVURQIGlzIG5vdCBzZXQKIyBDT05GSUdfR1RQIGlzIG5vdCBz
ZXQKIyBDT05GSUdfQU1UIGlzIG5vdCBzZXQKIyBDT05GSUdfTUFDU0VDIGlzIG5vdCBzZXQK
IyBDT05GSUdfTkVUQ09OU09MRSBpcyBub3Qgc2V0CiMgQ09ORklHX1RVTiBpcyBub3Qgc2V0
CiMgQ09ORklHX1RVTl9WTkVUX0NST1NTX0xFIGlzIG5vdCBzZXQKIyBDT05GSUdfVkVUSCBp
cyBub3Qgc2V0CkNPTkZJR19WSVJUSU9fTkVUPW0KIyBDT05GSUdfTkxNT04gaXMgbm90IHNl
dApDT05GSUdfTkVUS0lUPXkKIyBDT05GSUdfTkVUX1ZSRiBpcyBub3Qgc2V0CiMgQ09ORklH
X0FSQ05FVCBpcyBub3Qgc2V0CkNPTkZJR19FVEhFUk5FVD15CkNPTkZJR19ORVRfVkVORE9S
XzNDT009eQojIENPTkZJR19WT1JURVggaXMgbm90IHNldAojIENPTkZJR19UWVBIT09OIGlz
IG5vdCBzZXQKQ09ORklHX05FVF9WRU5ET1JfQURBUFRFQz15CiMgQ09ORklHX0FEQVBURUNf
U1RBUkZJUkUgaXMgbm90IHNldApDT05GSUdfTkVUX1ZFTkRPUl9BR0VSRT15CiMgQ09ORklH
X0VUMTMxWCBpcyBub3Qgc2V0CkNPTkZJR19ORVRfVkVORE9SX0FMQUNSSVRFQ0g9eQojIENP
TkZJR19TTElDT1NTIGlzIG5vdCBzZXQKQ09ORklHX05FVF9WRU5ET1JfQUxURU9OPXkKIyBD
T05GSUdfQUNFTklDIGlzIG5vdCBzZXQKIyBDT05GSUdfQUxURVJBX1RTRSBpcyBub3Qgc2V0
CkNPTkZJR19ORVRfVkVORE9SX0FNQVpPTj15CiMgQ09ORklHX0VOQV9FVEhFUk5FVCBpcyBu
b3Qgc2V0CkNPTkZJR19ORVRfVkVORE9SX0FNRD15CiMgQ09ORklHX0FNRDgxMTFfRVRIIGlz
IG5vdCBzZXQKIyBDT05GSUdfUENORVQzMiBpcyBub3Qgc2V0CiMgQ09ORklHX0FNRF9YR0JF
IGlzIG5vdCBzZXQKIyBDT05GSUdfUERTX0NPUkUgaXMgbm90IHNldApDT05GSUdfTkVUX1ZF
TkRPUl9BUVVBTlRJQT15CiMgQ09ORklHX0FRVElPTiBpcyBub3Qgc2V0CkNPTkZJR19ORVRf
VkVORE9SX0FSQz15CkNPTkZJR19ORVRfVkVORE9SX0FTSVg9eQojIENPTkZJR19TUElfQVg4
ODc5NkMgaXMgbm90IHNldApDT05GSUdfTkVUX1ZFTkRPUl9BVEhFUk9TPXkKIyBDT05GSUdf
QVRMMiBpcyBub3Qgc2V0CiMgQ09ORklHX0FUTDEgaXMgbm90IHNldAojIENPTkZJR19BVEwx
RSBpcyBub3Qgc2V0CiMgQ09ORklHX0FUTDFDIGlzIG5vdCBzZXQKIyBDT05GSUdfQUxYIGlz
IG5vdCBzZXQKIyBDT05GSUdfQ1hfRUNBVCBpcyBub3Qgc2V0CkNPTkZJR19ORVRfVkVORE9S
X0JST0FEQ09NPXkKIyBDT05GSUdfQjQ0IGlzIG5vdCBzZXQKIyBDT05GSUdfQkNNR0VORVQg
aXMgbm90IHNldAojIENPTkZJR19CTlgyIGlzIG5vdCBzZXQKIyBDT05GSUdfQ05JQyBpcyBu
b3Qgc2V0CiMgQ09ORklHX1RJR09OMyBpcyBub3Qgc2V0CiMgQ09ORklHX0JOWDJYIGlzIG5v
dCBzZXQKIyBDT05GSUdfU1lTVEVNUE9SVCBpcyBub3Qgc2V0CiMgQ09ORklHX0JOWFQgaXMg
bm90IHNldApDT05GSUdfTkVUX1ZFTkRPUl9DQURFTkNFPXkKIyBDT05GSUdfTUFDQiBpcyBu
b3Qgc2V0CkNPTkZJR19ORVRfVkVORE9SX0NBVklVTT15CiMgQ09ORklHX1RIVU5ERVJfTklD
X1BGIGlzIG5vdCBzZXQKIyBDT05GSUdfVEhVTkRFUl9OSUNfVkYgaXMgbm90IHNldAojIENP
TkZJR19USFVOREVSX05JQ19CR1ggaXMgbm90IHNldAojIENPTkZJR19USFVOREVSX05JQ19S
R1ggaXMgbm90IHNldAojIENPTkZJR19DQVZJVU1fUFRQIGlzIG5vdCBzZXQKIyBDT05GSUdf
TElRVUlESU8gaXMgbm90IHNldAojIENPTkZJR19MSVFVSURJT19WRiBpcyBub3Qgc2V0CkNP
TkZJR19ORVRfVkVORE9SX0NIRUxTSU89eQojIENPTkZJR19DSEVMU0lPX1QxIGlzIG5vdCBz
ZXQKIyBDT05GSUdfQ0hFTFNJT19UMyBpcyBub3Qgc2V0CiMgQ09ORklHX0NIRUxTSU9fVDQg
aXMgbm90IHNldAojIENPTkZJR19DSEVMU0lPX1Q0VkYgaXMgbm90IHNldApDT05GSUdfTkVU
X1ZFTkRPUl9DSVNDTz15CiMgQ09ORklHX0VOSUMgaXMgbm90IHNldApDT05GSUdfTkVUX1ZF
TkRPUl9DT1JUSU5BPXkKQ09ORklHX05FVF9WRU5ET1JfREFWSUNPTT15CiMgQ09ORklHX0RN
OTA1MSBpcyBub3Qgc2V0CiMgQ09ORklHX0RORVQgaXMgbm90IHNldApDT05GSUdfTkVUX1ZF
TkRPUl9ERUM9eQpDT05GSUdfTkVUX1RVTElQPXkKIyBDT05GSUdfREUyMTA0WCBpcyBub3Qg
c2V0CiMgQ09ORklHX1RVTElQIGlzIG5vdCBzZXQKIyBDT05GSUdfV0lOQk9ORF84NDAgaXMg
bm90IHNldAojIENPTkZJR19ETTkxMDIgaXMgbm90IHNldAojIENPTkZJR19VTEk1MjZYIGlz
IG5vdCBzZXQKQ09ORklHX05FVF9WRU5ET1JfRExJTks9eQojIENPTkZJR19ETDJLIGlzIG5v
dCBzZXQKIyBDT05GSUdfU1VOREFOQ0UgaXMgbm90IHNldApDT05GSUdfTkVUX1ZFTkRPUl9F
TVVMRVg9eQojIENPTkZJR19CRTJORVQgaXMgbm90IHNldApDT05GSUdfTkVUX1ZFTkRPUl9F
TkdMRURFUj15CiMgQ09ORklHX1RTTkVQIGlzIG5vdCBzZXQKQ09ORklHX05FVF9WRU5ET1Jf
RVpDSElQPXkKQ09ORklHX05FVF9WRU5ET1JfRlVOR0lCTEU9eQojIENPTkZJR19GVU5fRVRI
IGlzIG5vdCBzZXQKQ09ORklHX05FVF9WRU5ET1JfR09PR0xFPXkKIyBDT05GSUdfR1ZFIGlz
IG5vdCBzZXQKQ09ORklHX05FVF9WRU5ET1JfSFVBV0VJPXkKIyBDT05GSUdfSElOSUMgaXMg
bm90IHNldApDT05GSUdfTkVUX1ZFTkRPUl9JODI1WFg9eQpDT05GSUdfTkVUX1ZFTkRPUl9J
TlRFTD15CiMgQ09ORklHX0UxMDAgaXMgbm90IHNldAojIENPTkZJR19FMTAwMCBpcyBub3Qg
c2V0CiMgQ09ORklHX0UxMDAwRSBpcyBub3Qgc2V0CiMgQ09ORklHX0lHQiBpcyBub3Qgc2V0
CiMgQ09ORklHX0lHQlZGIGlzIG5vdCBzZXQKIyBDT05GSUdfSVhHQkUgaXMgbm90IHNldAoj
IENPTkZJR19JWEdCRVZGIGlzIG5vdCBzZXQKIyBDT05GSUdfSTQwRSBpcyBub3Qgc2V0CiMg
Q09ORklHX0k0MEVWRiBpcyBub3Qgc2V0CiMgQ09ORklHX0lDRSBpcyBub3Qgc2V0CiMgQ09O
RklHX0ZNMTBLIGlzIG5vdCBzZXQKIyBDT05GSUdfSUdDIGlzIG5vdCBzZXQKIyBDT05GSUdf
SURQRiBpcyBub3Qgc2V0CiMgQ09ORklHX0pNRSBpcyBub3Qgc2V0CkNPTkZJR19ORVRfVkVO
RE9SX0FEST15CiMgQ09ORklHX0FESU4xMTEwIGlzIG5vdCBzZXQKQ09ORklHX05FVF9WRU5E
T1JfTElURVg9eQpDT05GSUdfTkVUX1ZFTkRPUl9NQVJWRUxMPXkKIyBDT05GSUdfTVZNRElP
IGlzIG5vdCBzZXQKIyBDT05GSUdfU0tHRSBpcyBub3Qgc2V0CiMgQ09ORklHX1NLWTIgaXMg
bm90IHNldAojIENPTkZJR19PQ1RFT05fRVAgaXMgbm90IHNldApDT05GSUdfTkVUX1ZFTkRP
Ul9NRUxMQU5PWD15CiMgQ09ORklHX01MWDRfRU4gaXMgbm90IHNldAojIENPTkZJR19NTFg1
X0NPUkUgaXMgbm90IHNldAojIENPTkZJR19NTFhTV19DT1JFIGlzIG5vdCBzZXQKIyBDT05G
SUdfTUxYRlcgaXMgbm90IHNldApDT05GSUdfTkVUX1ZFTkRPUl9NSUNSRUw9eQojIENPTkZJ
R19LUzg4NDIgaXMgbm90IHNldAojIENPTkZJR19LUzg4NTEgaXMgbm90IHNldAojIENPTkZJ
R19LUzg4NTFfTUxMIGlzIG5vdCBzZXQKIyBDT05GSUdfS1NaODg0WF9QQ0kgaXMgbm90IHNl
dApDT05GSUdfTkVUX1ZFTkRPUl9NSUNST0NISVA9eQojIENPTkZJR19FTkMyOEo2MCBpcyBu
b3Qgc2V0CiMgQ09ORklHX0VOQ1gyNEo2MDAgaXMgbm90IHNldAojIENPTkZJR19MQU43NDNY
IGlzIG5vdCBzZXQKQ09ORklHX1ZDQVA9eQpDT05GSUdfTkVUX1ZFTkRPUl9NSUNST1NFTUk9
eQpDT05GSUdfTkVUX1ZFTkRPUl9NSUNST1NPRlQ9eQpDT05GSUdfTkVUX1ZFTkRPUl9NWVJJ
PXkKIyBDT05GSUdfTVlSSTEwR0UgaXMgbm90IHNldAojIENPTkZJR19GRUFMTlggaXMgbm90
IHNldApDT05GSUdfTkVUX1ZFTkRPUl9OST15CiMgQ09ORklHX05JX1hHRV9NQU5BR0VNRU5U
X0VORVQgaXMgbm90IHNldApDT05GSUdfTkVUX1ZFTkRPUl9OQVRTRU1JPXkKIyBDT05GSUdf
TkFUU0VNSSBpcyBub3Qgc2V0CiMgQ09ORklHX05TODM4MjAgaXMgbm90IHNldApDT05GSUdf
TkVUX1ZFTkRPUl9ORVRFUklPTj15CiMgQ09ORklHX1MySU8gaXMgbm90IHNldApDT05GSUdf
TkVUX1ZFTkRPUl9ORVRST05PTUU9eQojIENPTkZJR19ORlAgaXMgbm90IHNldApDT05GSUdf
TkVUX1ZFTkRPUl84MzkwPXkKIyBDT05GSUdfTkUyS19QQ0kgaXMgbm90IHNldApDT05GSUdf
TkVUX1ZFTkRPUl9OVklESUE9eQojIENPTkZJR19GT1JDRURFVEggaXMgbm90IHNldApDT05G
SUdfTkVUX1ZFTkRPUl9PS0k9eQojIENPTkZJR19FVEhPQyBpcyBub3Qgc2V0CkNPTkZJR19O
RVRfVkVORE9SX1BBQ0tFVF9FTkdJTkVTPXkKIyBDT05GSUdfSEFNQUNISSBpcyBub3Qgc2V0
CiMgQ09ORklHX1lFTExPV0ZJTiBpcyBub3Qgc2V0CkNPTkZJR19ORVRfVkVORE9SX1BFTlNB
TkRPPXkKIyBDT05GSUdfSU9OSUMgaXMgbm90IHNldApDT05GSUdfTkVUX1ZFTkRPUl9RTE9H
SUM9eQojIENPTkZJR19RTEEzWFhYIGlzIG5vdCBzZXQKIyBDT05GSUdfUUxDTklDIGlzIG5v
dCBzZXQKIyBDT05GSUdfTkVUWEVOX05JQyBpcyBub3Qgc2V0CiMgQ09ORklHX1FFRCBpcyBu
b3Qgc2V0CkNPTkZJR19ORVRfVkVORE9SX0JST0NBREU9eQojIENPTkZJR19CTkEgaXMgbm90
IHNldApDT05GSUdfTkVUX1ZFTkRPUl9RVUFMQ09NTT15CiMgQ09ORklHX1FDT01fRU1BQyBp
cyBub3Qgc2V0CiMgQ09ORklHX1JNTkVUIGlzIG5vdCBzZXQKQ09ORklHX05FVF9WRU5ET1Jf
UkRDPXkKIyBDT05GSUdfUjYwNDAgaXMgbm90IHNldApDT05GSUdfTkVUX1ZFTkRPUl9SRUFM
VEVLPXkKIyBDT05GSUdfODEzOUNQIGlzIG5vdCBzZXQKIyBDT05GSUdfODEzOVRPTyBpcyBu
b3Qgc2V0CiMgQ09ORklHX1I4MTY5IGlzIG5vdCBzZXQKQ09ORklHX05FVF9WRU5ET1JfUkVO
RVNBUz15CkNPTkZJR19ORVRfVkVORE9SX1JPQ0tFUj15CkNPTkZJR19ORVRfVkVORE9SX1NB
TVNVTkc9eQojIENPTkZJR19TWEdCRV9FVEggaXMgbm90IHNldApDT05GSUdfTkVUX1ZFTkRP
Ul9TRUVRPXkKQ09ORklHX05FVF9WRU5ET1JfU0lMQU49eQojIENPTkZJR19TQzkyMDMxIGlz
IG5vdCBzZXQKQ09ORklHX05FVF9WRU5ET1JfU0lTPXkKIyBDT05GSUdfU0lTOTAwIGlzIG5v
dCBzZXQKIyBDT05GSUdfU0lTMTkwIGlzIG5vdCBzZXQKQ09ORklHX05FVF9WRU5ET1JfU09M
QVJGTEFSRT15CiMgQ09ORklHX1NGQyBpcyBub3Qgc2V0CiMgQ09ORklHX1NGQ19GQUxDT04g
aXMgbm90IHNldAojIENPTkZJR19TRkNfU0lFTkEgaXMgbm90IHNldApDT05GSUdfTkVUX1ZF
TkRPUl9TTVNDPXkKIyBDT05GSUdfRVBJQzEwMCBpcyBub3Qgc2V0CiMgQ09ORklHX1NNU0M5
MTFYIGlzIG5vdCBzZXQKIyBDT05GSUdfU01TQzk0MjAgaXMgbm90IHNldApDT05GSUdfTkVU
X1ZFTkRPUl9TT0NJT05FWFQ9eQpDT05GSUdfTkVUX1ZFTkRPUl9TVE1JQ1JPPXkKIyBDT05G
SUdfU1RNTUFDX0VUSCBpcyBub3Qgc2V0CkNPTkZJR19ORVRfVkVORE9SX1NVTj15CiMgQ09O
RklHX0hBUFBZTUVBTCBpcyBub3Qgc2V0CiMgQ09ORklHX1NVTkdFTSBpcyBub3Qgc2V0CiMg
Q09ORklHX0NBU1NJTkkgaXMgbm90IHNldAojIENPTkZJR19OSVUgaXMgbm90IHNldApDT05G
SUdfTkVUX1ZFTkRPUl9TWU5PUFNZUz15CiMgQ09ORklHX0RXQ19YTEdNQUMgaXMgbm90IHNl
dApDT05GSUdfTkVUX1ZFTkRPUl9URUhVVEk9eQojIENPTkZJR19URUhVVEkgaXMgbm90IHNl
dApDT05GSUdfTkVUX1ZFTkRPUl9UST15CiMgQ09ORklHX1RJX0NQU1dfUEhZX1NFTCBpcyBu
b3Qgc2V0CiMgQ09ORklHX1RMQU4gaXMgbm90IHNldApDT05GSUdfTkVUX1ZFTkRPUl9WRVJU
RVhDT009eQojIENPTkZJR19NU0UxMDJYIGlzIG5vdCBzZXQKQ09ORklHX05FVF9WRU5ET1Jf
VklBPXkKIyBDT05GSUdfVklBX1JISU5FIGlzIG5vdCBzZXQKIyBDT05GSUdfVklBX1ZFTE9D
SVRZIGlzIG5vdCBzZXQKQ09ORklHX05FVF9WRU5ET1JfV0FOR1hVTj15CiMgQ09ORklHX05H
QkUgaXMgbm90IHNldAojIENPTkZJR19UWEdCRSBpcyBub3Qgc2V0CkNPTkZJR19ORVRfVkVO
RE9SX1dJWk5FVD15CiMgQ09ORklHX1dJWk5FVF9XNTEwMCBpcyBub3Qgc2V0CiMgQ09ORklH
X1dJWk5FVF9XNTMwMCBpcyBub3Qgc2V0CkNPTkZJR19ORVRfVkVORE9SX1hJTElOWD15CiMg
Q09ORklHX1hJTElOWF9FTUFDTElURSBpcyBub3Qgc2V0CiMgQ09ORklHX1hJTElOWF9MTF9U
RU1BQyBpcyBub3Qgc2V0CiMgQ09ORklHX0ZEREkgaXMgbm90IHNldAojIENPTkZJR19ISVBQ
SSBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9TQjEwMDAgaXMgbm90IHNldAojIENPTkZJR19Q
SFlMSUIgaXMgbm90IHNldAojIENPTkZJR19NSUNSRUxfS1M4OTk1TUEgaXMgbm90IHNldApD
T05GSUdfUFNFX0NPTlRST0xMRVI9eQojIENPTkZJR19QU0VfUkVHVUxBVE9SIGlzIG5vdCBz
ZXQKCiMKIyBNQ1RQIERldmljZSBEcml2ZXJzCiMKIyBDT05GSUdfTUNUUF9TRVJJQUwgaXMg
bm90IHNldAojIENPTkZJR19NQ1RQX1RSQU5TUE9SVF9JMkMgaXMgbm90IHNldAojIGVuZCBv
ZiBNQ1RQIERldmljZSBEcml2ZXJzCgojIENPTkZJR19NRElPX0RFVklDRSBpcyBub3Qgc2V0
CgojCiMgUENTIGRldmljZSBkcml2ZXJzCiMKIyBlbmQgb2YgUENTIGRldmljZSBkcml2ZXJz
CgojIENPTkZJR19QUFAgaXMgbm90IHNldAojIENPTkZJR19TTElQIGlzIG5vdCBzZXQKIyBD
T05GSUdfVVNCX05FVF9EUklWRVJTIGlzIG5vdCBzZXQKQ09ORklHX1dMQU49eQpDT05GSUdf
V0xBTl9WRU5ET1JfQURNVEVLPXkKQ09ORklHX1dMQU5fVkVORE9SX0FUSD15CiMgQ09ORklH
X0FUSF9ERUJVRyBpcyBub3Qgc2V0CkNPTkZJR19BVEg1S19QQ0k9eQojIENPTkZJR19BVEg2
S0wgaXMgbm90IHNldAojIENPTkZJR19XSUw2MjEwIGlzIG5vdCBzZXQKQ09ORklHX1dMQU5f
VkVORE9SX0FUTUVMPXkKQ09ORklHX1dMQU5fVkVORE9SX0JST0FEQ09NPXkKIyBDT05GSUdf
QlJDTUZNQUMgaXMgbm90IHNldApDT05GSUdfV0xBTl9WRU5ET1JfSU5URUw9eQojIENPTkZJ
R19JUFcyMTAwIGlzIG5vdCBzZXQKIyBDT05GSUdfSVBXMjIwMCBpcyBub3Qgc2V0CiMgQ09O
RklHX0lXTFdJRkkgaXMgbm90IHNldApDT05GSUdfV0xBTl9WRU5ET1JfSU5URVJTSUw9eQpD
T05GSUdfV0xBTl9WRU5ET1JfTUFSVkVMTD15CiMgQ09ORklHX0xJQkVSVEFTIGlzIG5vdCBz
ZXQKIyBDT05GSUdfTVdJRklFWCBpcyBub3Qgc2V0CkNPTkZJR19XTEFOX1ZFTkRPUl9NRURJ
QVRFSz15CkNPTkZJR19XTEFOX1ZFTkRPUl9NSUNST0NISVA9eQojIENPTkZJR19XSUxDMTAw
MF9TUEkgaXMgbm90IHNldApDT05GSUdfV0xBTl9WRU5ET1JfUFVSRUxJRkk9eQpDT05GSUdf
V0xBTl9WRU5ET1JfUkFMSU5LPXkKQ09ORklHX1dMQU5fVkVORE9SX1JFQUxURUs9eQpDT05G
SUdfV0xBTl9WRU5ET1JfUlNJPXkKQ09ORklHX1dMQU5fVkVORE9SX1NJTEFCUz15CkNPTkZJ
R19XTEFOX1ZFTkRPUl9TVD15CkNPTkZJR19XTEFOX1ZFTkRPUl9UST15CkNPTkZJR19XTEFO
X1ZFTkRPUl9aWURBUz15CkNPTkZJR19XTEFOX1ZFTkRPUl9RVUFOVEVOTkE9eQojIENPTkZJ
R19RVE5GTUFDX1BDSUUgaXMgbm90IHNldAojIENPTkZJR19WSVJUX1dJRkkgaXMgbm90IHNl
dAojIENPTkZJR19XQU4gaXMgbm90IHNldAoKIwojIFdpcmVsZXNzIFdBTgojCkNPTkZJR19X
V0FOPXkKQ09ORklHX1dXQU5fREVCVUdGUz15CiMgQ09ORklHX1dXQU5fSFdTSU0gaXMgbm90
IHNldAojIENPTkZJR19JT1NNIGlzIG5vdCBzZXQKIyBDT05GSUdfTVRLX1Q3WFggaXMgbm90
IHNldAojIGVuZCBvZiBXaXJlbGVzcyBXQU4KCiMgQ09ORklHX1hFTl9ORVRERVZfRlJPTlRF
TkQgaXMgbm90IHNldAojIENPTkZJR19YRU5fTkVUREVWX0JBQ0tFTkQgaXMgbm90IHNldAoj
IENPTkZJR19WTVhORVQzIGlzIG5vdCBzZXQKIyBDT05GSUdfRlVKSVRTVV9FUyBpcyBub3Qg
c2V0CiMgQ09ORklHX05FVERFVlNJTSBpcyBub3Qgc2V0CkNPTkZJR19ORVRfRkFJTE9WRVI9
bQpDT05GSUdfSVNETj15CiMgQ09ORklHX01JU0ROIGlzIG5vdCBzZXQKCiMKIyBJbnB1dCBk
ZXZpY2Ugc3VwcG9ydAojCkNPTkZJR19JTlBVVD15CkNPTkZJR19JTlBVVF9MRURTPW0KIyBD
T05GSUdfSU5QVVRfRkZfTUVNTEVTUyBpcyBub3Qgc2V0CiMgQ09ORklHX0lOUFVUX1NQQVJT
RUtNQVAgaXMgbm90IHNldAojIENPTkZJR19JTlBVVF9NQVRSSVhLTUFQIGlzIG5vdCBzZXQK
Q09ORklHX0lOUFVUX1ZJVkFMRElGTUFQPW0KCiMKIyBVc2VybGFuZCBpbnRlcmZhY2VzCiMK
Q09ORklHX0lOUFVUX01PVVNFREVWPW0KQ09ORklHX0lOUFVUX01PVVNFREVWX1BTQVVYPXkK
Q09ORklHX0lOUFVUX01PVVNFREVWX1NDUkVFTl9YPTEwMjQKQ09ORklHX0lOUFVUX01PVVNF
REVWX1NDUkVFTl9ZPTc2OApDT05GSUdfSU5QVVRfSk9ZREVWPW0KQ09ORklHX0lOUFVUX0VW
REVWPW0KIyBDT05GSUdfSU5QVVRfRVZCVUcgaXMgbm90IHNldAoKIwojIElucHV0IERldmlj
ZSBEcml2ZXJzCiMKQ09ORklHX0lOUFVUX0tFWUJPQVJEPXkKIyBDT05GSUdfS0VZQk9BUkRf
QURQNTUyMCBpcyBub3Qgc2V0CiMgQ09ORklHX0tFWUJPQVJEX0FEUDU1ODggaXMgbm90IHNl
dAojIENPTkZJR19LRVlCT0FSRF9BRFA1NTg5IGlzIG5vdCBzZXQKIyBDT05GSUdfS0VZQk9B
UkRfQVBQTEVTUEkgaXMgbm90IHNldApDT05GSUdfS0VZQk9BUkRfQVRLQkQ9bQojIENPTkZJ
R19LRVlCT0FSRF9RVDEwNTAgaXMgbm90IHNldAojIENPTkZJR19LRVlCT0FSRF9RVDEwNzAg
aXMgbm90IHNldAojIENPTkZJR19LRVlCT0FSRF9RVDIxNjAgaXMgbm90IHNldAojIENPTkZJ
R19LRVlCT0FSRF9ETElOS19ESVI2ODUgaXMgbm90IHNldAojIENPTkZJR19LRVlCT0FSRF9M
S0tCRCBpcyBub3Qgc2V0CiMgQ09ORklHX0tFWUJPQVJEX0dQSU8gaXMgbm90IHNldAojIENP
TkZJR19LRVlCT0FSRF9HUElPX1BPTExFRCBpcyBub3Qgc2V0CiMgQ09ORklHX0tFWUJPQVJE
X1RDQTY0MTYgaXMgbm90IHNldAojIENPTkZJR19LRVlCT0FSRF9UQ0E4NDE4IGlzIG5vdCBz
ZXQKIyBDT05GSUdfS0VZQk9BUkRfTUFUUklYIGlzIG5vdCBzZXQKIyBDT05GSUdfS0VZQk9B
UkRfTE04MzIzIGlzIG5vdCBzZXQKIyBDT05GSUdfS0VZQk9BUkRfTE04MzMzIGlzIG5vdCBz
ZXQKIyBDT05GSUdfS0VZQk9BUkRfTUFYNzM1OSBpcyBub3Qgc2V0CiMgQ09ORklHX0tFWUJP
QVJEX01DUyBpcyBub3Qgc2V0CiMgQ09ORklHX0tFWUJPQVJEX01QUjEyMSBpcyBub3Qgc2V0
CiMgQ09ORklHX0tFWUJPQVJEX05FV1RPTiBpcyBub3Qgc2V0CiMgQ09ORklHX0tFWUJPQVJE
X09QRU5DT1JFUyBpcyBub3Qgc2V0CiMgQ09ORklHX0tFWUJPQVJEX1BJTkVQSE9ORSBpcyBu
b3Qgc2V0CiMgQ09ORklHX0tFWUJPQVJEX1NBTVNVTkcgaXMgbm90IHNldAojIENPTkZJR19L
RVlCT0FSRF9TVE9XQVdBWSBpcyBub3Qgc2V0CiMgQ09ORklHX0tFWUJPQVJEX1NVTktCRCBp
cyBub3Qgc2V0CiMgQ09ORklHX0tFWUJPQVJEX1RNMl9UT1VDSEtFWSBpcyBub3Qgc2V0CiMg
Q09ORklHX0tFWUJPQVJEX1RXTDQwMzAgaXMgbm90IHNldAojIENPTkZJR19LRVlCT0FSRF9Y
VEtCRCBpcyBub3Qgc2V0CiMgQ09ORklHX0tFWUJPQVJEX0NZUFJFU1NfU0YgaXMgbm90IHNl
dApDT05GSUdfSU5QVVRfTU9VU0U9eQpDT05GSUdfTU9VU0VfUFMyPW0KQ09ORklHX01PVVNF
X1BTMl9BTFBTPXkKQ09ORklHX01PVVNFX1BTMl9CWUQ9eQpDT05GSUdfTU9VU0VfUFMyX0xP
R0lQUzJQUD15CkNPTkZJR19NT1VTRV9QUzJfU1lOQVBUSUNTPXkKQ09ORklHX01PVVNFX1BT
Ml9TWU5BUFRJQ1NfU01CVVM9eQpDT05GSUdfTU9VU0VfUFMyX0NZUFJFU1M9eQpDT05GSUdf
TU9VU0VfUFMyX0xJRkVCT09LPXkKQ09ORklHX01PVVNFX1BTMl9UUkFDS1BPSU5UPXkKQ09O
RklHX01PVVNFX1BTMl9FTEFOVEVDSD15CkNPTkZJR19NT1VTRV9QUzJfRUxBTlRFQ0hfU01C
VVM9eQpDT05GSUdfTU9VU0VfUFMyX1NFTlRFTElDPXkKQ09ORklHX01PVVNFX1BTMl9UT1VD
SEtJVD15CkNPTkZJR19NT1VTRV9QUzJfRk9DQUxURUNIPXkKQ09ORklHX01PVVNFX1BTMl9W
TU1PVVNFPXkKQ09ORklHX01PVVNFX1BTMl9TTUJVUz15CiMgQ09ORklHX01PVVNFX1NFUklB
TCBpcyBub3Qgc2V0CiMgQ09ORklHX01PVVNFX0FQUExFVE9VQ0ggaXMgbm90IHNldAojIENP
TkZJR19NT1VTRV9CQ001OTc0IGlzIG5vdCBzZXQKIyBDT05GSUdfTU9VU0VfQ1lBUEEgaXMg
bm90IHNldAojIENPTkZJR19NT1VTRV9FTEFOX0kyQyBpcyBub3Qgc2V0CiMgQ09ORklHX01P
VVNFX1ZTWFhYQUEgaXMgbm90IHNldAojIENPTkZJR19NT1VTRV9HUElPIGlzIG5vdCBzZXQK
IyBDT05GSUdfTU9VU0VfU1lOQVBUSUNTX0kyQyBpcyBub3Qgc2V0CiMgQ09ORklHX01PVVNF
X1NZTkFQVElDU19VU0IgaXMgbm90IHNldApDT05GSUdfSU5QVVRfSk9ZU1RJQ0s9eQojIENP
TkZJR19KT1lTVElDS19BTkFMT0cgaXMgbm90IHNldAojIENPTkZJR19KT1lTVElDS19BM0Qg
aXMgbm90IHNldAojIENPTkZJR19KT1lTVElDS19BREkgaXMgbm90IHNldAojIENPTkZJR19K
T1lTVElDS19DT0JSQSBpcyBub3Qgc2V0CiMgQ09ORklHX0pPWVNUSUNLX0dGMksgaXMgbm90
IHNldAojIENPTkZJR19KT1lTVElDS19HUklQIGlzIG5vdCBzZXQKIyBDT05GSUdfSk9ZU1RJ
Q0tfR1JJUF9NUCBpcyBub3Qgc2V0CiMgQ09ORklHX0pPWVNUSUNLX0dVSUxMRU1PVCBpcyBu
b3Qgc2V0CiMgQ09ORklHX0pPWVNUSUNLX0lOVEVSQUNUIGlzIG5vdCBzZXQKIyBDT05GSUdf
Sk9ZU1RJQ0tfU0lERVdJTkRFUiBpcyBub3Qgc2V0CiMgQ09ORklHX0pPWVNUSUNLX1RNREMg
aXMgbm90IHNldAojIENPTkZJR19KT1lTVElDS19JRk9SQ0UgaXMgbm90IHNldAojIENPTkZJ
R19KT1lTVElDS19XQVJSSU9SIGlzIG5vdCBzZXQKIyBDT05GSUdfSk9ZU1RJQ0tfTUFHRUxM
QU4gaXMgbm90IHNldAojIENPTkZJR19KT1lTVElDS19TUEFDRU9SQiBpcyBub3Qgc2V0CiMg
Q09ORklHX0pPWVNUSUNLX1NQQUNFQkFMTCBpcyBub3Qgc2V0CiMgQ09ORklHX0pPWVNUSUNL
X1NUSU5HRVIgaXMgbm90IHNldAojIENPTkZJR19KT1lTVElDS19UV0lESk9ZIGlzIG5vdCBz
ZXQKIyBDT05GSUdfSk9ZU1RJQ0tfWkhFTkhVQSBpcyBub3Qgc2V0CiMgQ09ORklHX0pPWVNU
SUNLX0FTNTAxMSBpcyBub3Qgc2V0CiMgQ09ORklHX0pPWVNUSUNLX0pPWURVTVAgaXMgbm90
IHNldAojIENPTkZJR19KT1lTVElDS19YUEFEIGlzIG5vdCBzZXQKIyBDT05GSUdfSk9ZU1RJ
Q0tfUFNYUEFEX1NQSSBpcyBub3Qgc2V0CiMgQ09ORklHX0pPWVNUSUNLX1BYUkMgaXMgbm90
IHNldAojIENPTkZJR19KT1lTVElDS19RV0lJQyBpcyBub3Qgc2V0CiMgQ09ORklHX0pPWVNU
SUNLX0ZTSUE2QiBpcyBub3Qgc2V0CiMgQ09ORklHX0pPWVNUSUNLX1NFTlNFSEFUIGlzIG5v
dCBzZXQKIyBDT05GSUdfSk9ZU1RJQ0tfU0VFU0FXIGlzIG5vdCBzZXQKQ09ORklHX0lOUFVU
X1RBQkxFVD15CiMgQ09ORklHX1RBQkxFVF9VU0JfQUNFQ0FEIGlzIG5vdCBzZXQKIyBDT05G
SUdfVEFCTEVUX1VTQl9BSVBURUsgaXMgbm90IHNldAojIENPTkZJR19UQUJMRVRfVVNCX0hB
TldBTkcgaXMgbm90IHNldAojIENPTkZJR19UQUJMRVRfVVNCX0tCVEFCIGlzIG5vdCBzZXQK
IyBDT05GSUdfVEFCTEVUX1VTQl9QRUdBU1VTIGlzIG5vdCBzZXQKIyBDT05GSUdfVEFCTEVU
X1NFUklBTF9XQUNPTTQgaXMgbm90IHNldApDT05GSUdfSU5QVVRfVE9VQ0hTQ1JFRU49eQoj
IENPTkZJR19UT1VDSFNDUkVFTl84OFBNODYwWCBpcyBub3Qgc2V0CiMgQ09ORklHX1RPVUNI
U0NSRUVOX0FEUzc4NDYgaXMgbm90IHNldAojIENPTkZJR19UT1VDSFNDUkVFTl9BRDc4Nzcg
aXMgbm90IHNldAojIENPTkZJR19UT1VDSFNDUkVFTl9BRDc4NzkgaXMgbm90IHNldAojIENP
TkZJR19UT1VDSFNDUkVFTl9BVE1FTF9NWFQgaXMgbm90IHNldAojIENPTkZJR19UT1VDSFND
UkVFTl9BVU9fUElYQ0lSIGlzIG5vdCBzZXQKIyBDT05GSUdfVE9VQ0hTQ1JFRU5fQlUyMTAx
MyBpcyBub3Qgc2V0CiMgQ09ORklHX1RPVUNIU0NSRUVOX0JVMjEwMjkgaXMgbm90IHNldAoj
IENPTkZJR19UT1VDSFNDUkVFTl9DSElQT05FX0lDTjg1MDUgaXMgbm90IHNldAojIENPTkZJ
R19UT1VDSFNDUkVFTl9DWThDVE1BMTQwIGlzIG5vdCBzZXQKIyBDT05GSUdfVE9VQ0hTQ1JF
RU5fQ1k4Q1RNRzExMCBpcyBub3Qgc2V0CiMgQ09ORklHX1RPVUNIU0NSRUVOX0NZVFRTUF9D
T1JFIGlzIG5vdCBzZXQKIyBDT05GSUdfVE9VQ0hTQ1JFRU5fQ1lUVFNQNF9DT1JFIGlzIG5v
dCBzZXQKIyBDT05GSUdfVE9VQ0hTQ1JFRU5fQ1lUVFNQNSBpcyBub3Qgc2V0CiMgQ09ORklH
X1RPVUNIU0NSRUVOX0RBOTAzNCBpcyBub3Qgc2V0CiMgQ09ORklHX1RPVUNIU0NSRUVOX0RB
OTA1MiBpcyBub3Qgc2V0CiMgQ09ORklHX1RPVUNIU0NSRUVOX0RZTkFQUk8gaXMgbm90IHNl
dAojIENPTkZJR19UT1VDSFNDUkVFTl9IQU1QU0hJUkUgaXMgbm90IHNldAojIENPTkZJR19U
T1VDSFNDUkVFTl9FRVRJIGlzIG5vdCBzZXQKIyBDT05GSUdfVE9VQ0hTQ1JFRU5fRUdBTEFY
X1NFUklBTCBpcyBub3Qgc2V0CiMgQ09ORklHX1RPVUNIU0NSRUVOX0VYQzMwMDAgaXMgbm90
IHNldAojIENPTkZJR19UT1VDSFNDUkVFTl9GVUpJVFNVIGlzIG5vdCBzZXQKIyBDT05GSUdf
VE9VQ0hTQ1JFRU5fR09PRElYIGlzIG5vdCBzZXQKIyBDT05GSUdfVE9VQ0hTQ1JFRU5fSElE
RUVQIGlzIG5vdCBzZXQKIyBDT05GSUdfVE9VQ0hTQ1JFRU5fSFlDT05fSFk0NlhYIGlzIG5v
dCBzZXQKIyBDT05GSUdfVE9VQ0hTQ1JFRU5fSFlOSVRST05fQ1NUWFhYIGlzIG5vdCBzZXQK
IyBDT05GSUdfVE9VQ0hTQ1JFRU5fSUxJMjEwWCBpcyBub3Qgc2V0CiMgQ09ORklHX1RPVUNI
U0NSRUVOX0lMSVRFSyBpcyBub3Qgc2V0CiMgQ09ORklHX1RPVUNIU0NSRUVOX1M2U1k3NjEg
aXMgbm90IHNldAojIENPTkZJR19UT1VDSFNDUkVFTl9HVU5aRSBpcyBub3Qgc2V0CiMgQ09O
RklHX1RPVUNIU0NSRUVOX0VLVEYyMTI3IGlzIG5vdCBzZXQKIyBDT05GSUdfVE9VQ0hTQ1JF
RU5fRUxBTiBpcyBub3Qgc2V0CiMgQ09ORklHX1RPVUNIU0NSRUVOX0VMTyBpcyBub3Qgc2V0
CiMgQ09ORklHX1RPVUNIU0NSRUVOX1dBQ09NX1c4MDAxIGlzIG5vdCBzZXQKIyBDT05GSUdf
VE9VQ0hTQ1JFRU5fV0FDT01fSTJDIGlzIG5vdCBzZXQKIyBDT05GSUdfVE9VQ0hTQ1JFRU5f
TUFYMTE4MDEgaXMgbm90IHNldAojIENPTkZJR19UT1VDSFNDUkVFTl9NQ1M1MDAwIGlzIG5v
dCBzZXQKIyBDT05GSUdfVE9VQ0hTQ1JFRU5fTU1TMTE0IGlzIG5vdCBzZXQKIyBDT05GSUdf
VE9VQ0hTQ1JFRU5fTUVMRkFTX01JUDQgaXMgbm90IHNldAojIENPTkZJR19UT1VDSFNDUkVF
Tl9NU0cyNjM4IGlzIG5vdCBzZXQKIyBDT05GSUdfVE9VQ0hTQ1JFRU5fTVRPVUNIIGlzIG5v
dCBzZXQKIyBDT05GSUdfVE9VQ0hTQ1JFRU5fTk9WQVRFS19OVlRfVFMgaXMgbm90IHNldAoj
IENPTkZJR19UT1VDSFNDUkVFTl9JTUFHSVMgaXMgbm90IHNldAojIENPTkZJR19UT1VDSFND
UkVFTl9JTkVYSU8gaXMgbm90IHNldAojIENPTkZJR19UT1VDSFNDUkVFTl9QRU5NT1VOVCBp
cyBub3Qgc2V0CiMgQ09ORklHX1RPVUNIU0NSRUVOX0VEVF9GVDVYMDYgaXMgbm90IHNldAoj
IENPTkZJR19UT1VDSFNDUkVFTl9UT1VDSFJJR0hUIGlzIG5vdCBzZXQKIyBDT05GSUdfVE9V
Q0hTQ1JFRU5fVE9VQ0hXSU4gaXMgbm90IHNldAojIENPTkZJR19UT1VDSFNDUkVFTl9QSVhD
SVIgaXMgbm90IHNldAojIENPTkZJR19UT1VDSFNDUkVFTl9XRFQ4N1hYX0kyQyBpcyBub3Qg
c2V0CiMgQ09ORklHX1RPVUNIU0NSRUVOX1dNODMxWCBpcyBub3Qgc2V0CiMgQ09ORklHX1RP
VUNIU0NSRUVOX1VTQl9DT01QT1NJVEUgaXMgbm90IHNldAojIENPTkZJR19UT1VDSFNDUkVF
Tl9UT1VDSElUMjEzIGlzIG5vdCBzZXQKIyBDT05GSUdfVE9VQ0hTQ1JFRU5fVFNDX1NFUklP
IGlzIG5vdCBzZXQKIyBDT05GSUdfVE9VQ0hTQ1JFRU5fVFNDMjAwNCBpcyBub3Qgc2V0CiMg
Q09ORklHX1RPVUNIU0NSRUVOX1RTQzIwMDUgaXMgbm90IHNldAojIENPTkZJR19UT1VDSFND
UkVFTl9UU0MyMDA3IGlzIG5vdCBzZXQKIyBDT05GSUdfVE9VQ0hTQ1JFRU5fUENBUCBpcyBu
b3Qgc2V0CiMgQ09ORklHX1RPVUNIU0NSRUVOX1JNX1RTIGlzIG5vdCBzZXQKIyBDT05GSUdf
VE9VQ0hTQ1JFRU5fU0lMRUFEIGlzIG5vdCBzZXQKIyBDT05GSUdfVE9VQ0hTQ1JFRU5fU0lT
X0kyQyBpcyBub3Qgc2V0CiMgQ09ORklHX1RPVUNIU0NSRUVOX1NUMTIzMiBpcyBub3Qgc2V0
CiMgQ09ORklHX1RPVUNIU0NSRUVOX1NUTUZUUyBpcyBub3Qgc2V0CiMgQ09ORklHX1RPVUNI
U0NSRUVOX1NVUkZBQ0UzX1NQSSBpcyBub3Qgc2V0CiMgQ09ORklHX1RPVUNIU0NSRUVOX1NY
ODY1NCBpcyBub3Qgc2V0CiMgQ09ORklHX1RPVUNIU0NSRUVOX1RQUzY1MDdYIGlzIG5vdCBz
ZXQKIyBDT05GSUdfVE9VQ0hTQ1JFRU5fWkVUNjIyMyBpcyBub3Qgc2V0CiMgQ09ORklHX1RP
VUNIU0NSRUVOX1pGT1JDRSBpcyBub3Qgc2V0CiMgQ09ORklHX1RPVUNIU0NSRUVOX1JPSE1f
QlUyMTAyMyBpcyBub3Qgc2V0CiMgQ09ORklHX1RPVUNIU0NSRUVOX0lRUzVYWCBpcyBub3Qg
c2V0CiMgQ09ORklHX1RPVUNIU0NSRUVOX0lRUzcyMTEgaXMgbm90IHNldAojIENPTkZJR19U
T1VDSFNDUkVFTl9aSU5JVElYIGlzIG5vdCBzZXQKIyBDT05GSUdfVE9VQ0hTQ1JFRU5fSElN
QVhfSFg4MzExMkIgaXMgbm90IHNldApDT05GSUdfSU5QVVRfTUlTQz15CiMgQ09ORklHX0lO
UFVUXzg4UE04NjBYX09OS0VZIGlzIG5vdCBzZXQKIyBDT05GSUdfSU5QVVRfQUQ3MTRYIGlz
IG5vdCBzZXQKIyBDT05GSUdfSU5QVVRfQk1BMTUwIGlzIG5vdCBzZXQKIyBDT05GSUdfSU5Q
VVRfRTNYMF9CVVRUT04gaXMgbm90IHNldApDT05GSUdfSU5QVVRfUENTUEtSPW0KIyBDT05G
SUdfSU5QVVRfTUFYNzc2OTNfSEFQVElDIGlzIG5vdCBzZXQKIyBDT05GSUdfSU5QVVRfTUFY
ODkyNV9PTktFWSBpcyBub3Qgc2V0CiMgQ09ORklHX0lOUFVUX01BWDg5OTdfSEFQVElDIGlz
IG5vdCBzZXQKIyBDT05GSUdfSU5QVVRfTU1BODQ1MCBpcyBub3Qgc2V0CiMgQ09ORklHX0lO
UFVUX0FQQU5FTCBpcyBub3Qgc2V0CiMgQ09ORklHX0lOUFVUX0dQSU9fQkVFUEVSIGlzIG5v
dCBzZXQKIyBDT05GSUdfSU5QVVRfR1BJT19ERUNPREVSIGlzIG5vdCBzZXQKIyBDT05GSUdf
SU5QVVRfR1BJT19WSUJSQSBpcyBub3Qgc2V0CiMgQ09ORklHX0lOUFVUX0FUTEFTX0JUTlMg
aXMgbm90IHNldAojIENPTkZJR19JTlBVVF9BVElfUkVNT1RFMiBpcyBub3Qgc2V0CiMgQ09O
RklHX0lOUFVUX0tFWVNQQU5fUkVNT1RFIGlzIG5vdCBzZXQKIyBDT05GSUdfSU5QVVRfS1hU
SjkgaXMgbm90IHNldAojIENPTkZJR19JTlBVVF9QT1dFUk1BVEUgaXMgbm90IHNldAojIENP
TkZJR19JTlBVVF9ZRUFMSU5LIGlzIG5vdCBzZXQKIyBDT05GSUdfSU5QVVRfQ00xMDkgaXMg
bm90IHNldAojIENPTkZJR19JTlBVVF9SRUdVTEFUT1JfSEFQVElDIGlzIG5vdCBzZXQKIyBD
T05GSUdfSU5QVVRfVFdMNDAzMF9QV1JCVVRUT04gaXMgbm90IHNldAojIENPTkZJR19JTlBV
VF9UV0w0MDMwX1ZJQlJBIGlzIG5vdCBzZXQKIyBDT05GSUdfSU5QVVRfVFdMNjA0MF9WSUJS
QSBpcyBub3Qgc2V0CiMgQ09ORklHX0lOUFVUX1VJTlBVVCBpcyBub3Qgc2V0CiMgQ09ORklH
X0lOUFVUX1BBTE1BU19QV1JCVVRUT04gaXMgbm90IHNldAojIENPTkZJR19JTlBVVF9QQ0Y4
NTc0IGlzIG5vdCBzZXQKIyBDT05GSUdfSU5QVVRfUFdNX0JFRVBFUiBpcyBub3Qgc2V0CiMg
Q09ORklHX0lOUFVUX1BXTV9WSUJSQSBpcyBub3Qgc2V0CiMgQ09ORklHX0lOUFVUX0dQSU9f
Uk9UQVJZX0VOQ09ERVIgaXMgbm90IHNldAojIENPTkZJR19JTlBVVF9EQTcyODBfSEFQVElD
UyBpcyBub3Qgc2V0CiMgQ09ORklHX0lOUFVUX0RBOTA1Ml9PTktFWSBpcyBub3Qgc2V0CiMg
Q09ORklHX0lOUFVUX0RBOTA1NV9PTktFWSBpcyBub3Qgc2V0CiMgQ09ORklHX0lOUFVUX1dN
ODMxWF9PTiBpcyBub3Qgc2V0CiMgQ09ORklHX0lOUFVUX1BDQVAgaXMgbm90IHNldAojIENP
TkZJR19JTlBVVF9BRFhMMzRYIGlzIG5vdCBzZXQKIyBDT05GSUdfSU5QVVRfSUJNX1BBTkVM
IGlzIG5vdCBzZXQKIyBDT05GSUdfSU5QVVRfSU1TX1BDVSBpcyBub3Qgc2V0CiMgQ09ORklH
X0lOUFVUX0lRUzI2OUEgaXMgbm90IHNldAojIENPTkZJR19JTlBVVF9JUVM2MjZBIGlzIG5v
dCBzZXQKIyBDT05GSUdfSU5QVVRfSVFTNzIyMiBpcyBub3Qgc2V0CiMgQ09ORklHX0lOUFVU
X0NNQTMwMDAgaXMgbm90IHNldAojIENPTkZJR19JTlBVVF9YRU5fS0JEREVWX0ZST05URU5E
IGlzIG5vdCBzZXQKIyBDT05GSUdfSU5QVVRfSURFQVBBRF9TTElERUJBUiBpcyBub3Qgc2V0
CiMgQ09ORklHX0lOUFVUX0RSVjI2MFhfSEFQVElDUyBpcyBub3Qgc2V0CiMgQ09ORklHX0lO
UFVUX0RSVjI2NjVfSEFQVElDUyBpcyBub3Qgc2V0CiMgQ09ORklHX0lOUFVUX0RSVjI2Njdf
SEFQVElDUyBpcyBub3Qgc2V0CiMgQ09ORklHX1JNSTRfQ09SRSBpcyBub3Qgc2V0CgojCiMg
SGFyZHdhcmUgSS9PIHBvcnRzCiMKQ09ORklHX1NFUklPPW0KQ09ORklHX0FSQ0hfTUlHSFRf
SEFWRV9QQ19TRVJJTz15CkNPTkZJR19TRVJJT19JODA0Mj1tCiMgQ09ORklHX1NFUklPX1NF
UlBPUlQgaXMgbm90IHNldAojIENPTkZJR19TRVJJT19DVDgyQzcxMCBpcyBub3Qgc2V0CiMg
Q09ORklHX1NFUklPX1BDSVBTMiBpcyBub3Qgc2V0CkNPTkZJR19TRVJJT19MSUJQUzI9bQpD
T05GSUdfU0VSSU9fUkFXPW0KIyBDT05GSUdfU0VSSU9fQUxURVJBX1BTMiBpcyBub3Qgc2V0
CiMgQ09ORklHX1NFUklPX1BTMk1VTFQgaXMgbm90IHNldAojIENPTkZJR19TRVJJT19BUkNf
UFMyIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VSSU9fR1BJT19QUzIgaXMgbm90IHNldAojIENP
TkZJR19VU0VSSU8gaXMgbm90IHNldAojIENPTkZJR19HQU1FUE9SVCBpcyBub3Qgc2V0CiMg
ZW5kIG9mIEhhcmR3YXJlIEkvTyBwb3J0cwojIGVuZCBvZiBJbnB1dCBkZXZpY2Ugc3VwcG9y
dAoKIwojIENoYXJhY3RlciBkZXZpY2VzCiMKQ09ORklHX1RUWT15CkNPTkZJR19WVD15CkNP
TkZJR19DT05TT0xFX1RSQU5TTEFUSU9OUz15CkNPTkZJR19WVF9DT05TT0xFPXkKQ09ORklH
X1ZUX0NPTlNPTEVfU0xFRVA9eQpDT05GSUdfSFdfQ09OU09MRT15CkNPTkZJR19WVF9IV19D
T05TT0xFX0JJTkRJTkc9eQpDT05GSUdfVU5JWDk4X1BUWVM9eQojIENPTkZJR19MRUdBQ1lf
UFRZUyBpcyBub3Qgc2V0CiMgQ09ORklHX0xFR0FDWV9USU9DU1RJIGlzIG5vdCBzZXQKQ09O
RklHX0xESVNDX0FVVE9MT0FEPXkKCiMKIyBTZXJpYWwgZHJpdmVycwojCkNPTkZJR19TRVJJ
QUxfRUFSTFlDT049eQpDT05GSUdfU0VSSUFMXzgyNTA9eQojIENPTkZJR19TRVJJQUxfODI1
MF9ERVBSRUNBVEVEX09QVElPTlMgaXMgbm90IHNldApDT05GSUdfU0VSSUFMXzgyNTBfUE5Q
PXkKIyBDT05GSUdfU0VSSUFMXzgyNTBfMTY1NTBBX1ZBUklBTlRTIGlzIG5vdCBzZXQKQ09O
RklHX1NFUklBTF84MjUwX0ZJTlRFSz15CkNPTkZJR19TRVJJQUxfODI1MF9DT05TT0xFPXkK
Q09ORklHX1NFUklBTF84MjUwX0RNQT15CkNPTkZJR19TRVJJQUxfODI1MF9QQ0lMSUI9eQpD
T05GSUdfU0VSSUFMXzgyNTBfUENJPXkKIyBDT05GSUdfU0VSSUFMXzgyNTBfRVhBUiBpcyBu
b3Qgc2V0CkNPTkZJR19TRVJJQUxfODI1MF9OUl9VQVJUUz0zMgpDT05GSUdfU0VSSUFMXzgy
NTBfUlVOVElNRV9VQVJUUz0zMgpDT05GSUdfU0VSSUFMXzgyNTBfRVhURU5ERUQ9eQpDT05G
SUdfU0VSSUFMXzgyNTBfTUFOWV9QT1JUUz15CiMgQ09ORklHX1NFUklBTF84MjUwX1BDSTFY
WFhYIGlzIG5vdCBzZXQKQ09ORklHX1NFUklBTF84MjUwX1NIQVJFX0lSUT15CiMgQ09ORklH
X1NFUklBTF84MjUwX0RFVEVDVF9JUlEgaXMgbm90IHNldApDT05GSUdfU0VSSUFMXzgyNTBf
UlNBPXkKQ09ORklHX1NFUklBTF84MjUwX0RXTElCPXkKIyBDT05GSUdfU0VSSUFMXzgyNTBf
RFcgaXMgbm90IHNldApDT05GSUdfU0VSSUFMXzgyNTBfUlQyODhYPXkKQ09ORklHX1NFUklB
TF84MjUwX0xQU1M9eQpDT05GSUdfU0VSSUFMXzgyNTBfTUlEPXkKQ09ORklHX1NFUklBTF84
MjUwX1BFUklDT009eQoKIwojIE5vbi04MjUwIHNlcmlhbCBwb3J0IHN1cHBvcnQKIwojIENP
TkZJR19TRVJJQUxfTUFYMzEwMCBpcyBub3Qgc2V0CiMgQ09ORklHX1NFUklBTF9NQVgzMTBY
IGlzIG5vdCBzZXQKIyBDT05GSUdfU0VSSUFMX1VBUlRMSVRFIGlzIG5vdCBzZXQKQ09ORklH
X1NFUklBTF9DT1JFPXkKQ09ORklHX1NFUklBTF9DT1JFX0NPTlNPTEU9eQojIENPTkZJR19T
RVJJQUxfSlNNIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VSSUFMX0xBTlRJUSBpcyBub3Qgc2V0
CiMgQ09ORklHX1NFUklBTF9TQ0NOWFAgaXMgbm90IHNldAojIENPTkZJR19TRVJJQUxfU0Mx
NklTN1hYIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VSSUFMX0FMVEVSQV9KVEFHVUFSVCBpcyBu
b3Qgc2V0CiMgQ09ORklHX1NFUklBTF9BTFRFUkFfVUFSVCBpcyBub3Qgc2V0CiMgQ09ORklH
X1NFUklBTF9BUkMgaXMgbm90IHNldAojIENPTkZJR19TRVJJQUxfUlAyIGlzIG5vdCBzZXQK
IyBDT05GSUdfU0VSSUFMX0ZTTF9MUFVBUlQgaXMgbm90IHNldAojIENPTkZJR19TRVJJQUxf
RlNMX0xJTkZMRVhVQVJUIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VSSUFMX1NQUkQgaXMgbm90
IHNldAojIGVuZCBvZiBTZXJpYWwgZHJpdmVycwoKQ09ORklHX1NFUklBTF9NQ1RSTF9HUElP
PXkKQ09ORklHX1NFUklBTF9OT05TVEFOREFSRD15CiMgQ09ORklHX01PWEFfSU5URUxMSU8g
aXMgbm90IHNldAojIENPTkZJR19NT1hBX1NNQVJUSU8gaXMgbm90IHNldAojIENPTkZJR19O
X0hETEMgaXMgbm90IHNldAojIENPTkZJR19OX0dTTSBpcyBub3Qgc2V0CiMgQ09ORklHX05P
Wk9NSSBpcyBub3Qgc2V0CiMgQ09ORklHX05VTExfVFRZIGlzIG5vdCBzZXQKQ09ORklHX0hW
Q19EUklWRVI9eQpDT05GSUdfSFZDX0lSUT15CkNPTkZJR19IVkNfWEVOPXkKQ09ORklHX0hW
Q19YRU5fRlJPTlRFTkQ9eQpDT05GSUdfU0VSSUFMX0RFVl9CVVM9eQpDT05GSUdfU0VSSUFM
X0RFVl9DVFJMX1RUWVBPUlQ9eQojIENPTkZJR19WSVJUSU9fQ09OU09MRSBpcyBub3Qgc2V0
CiMgQ09ORklHX0lQTUlfSEFORExFUiBpcyBub3Qgc2V0CiMgQ09ORklHX1NTSUZfSVBNSV9C
TUMgaXMgbm90IHNldAojIENPTkZJR19JUE1CX0RFVklDRV9JTlRFUkZBQ0UgaXMgbm90IHNl
dApDT05GSUdfSFdfUkFORE9NPXkKIyBDT05GSUdfSFdfUkFORE9NX1RJTUVSSU9NRU0gaXMg
bm90IHNldAojIENPTkZJR19IV19SQU5ET01fSU5URUwgaXMgbm90IHNldAojIENPTkZJR19I
V19SQU5ET01fQU1EIGlzIG5vdCBzZXQKIyBDT05GSUdfSFdfUkFORE9NX0JBNDMxIGlzIG5v
dCBzZXQKIyBDT05GSUdfSFdfUkFORE9NX1ZJQSBpcyBub3Qgc2V0CkNPTkZJR19IV19SQU5E
T01fVklSVElPPW0KIyBDT05GSUdfSFdfUkFORE9NX1hJUEhFUkEgaXMgbm90IHNldAojIENP
TkZJR19BUFBMSUNPTSBpcyBub3Qgc2V0CiMgQ09ORklHX01XQVZFIGlzIG5vdCBzZXQKIyBD
T05GSUdfREVWTUVNIGlzIG5vdCBzZXQKIyBDT05GSUdfTlZSQU0gaXMgbm90IHNldAojIENP
TkZJR19ERVZQT1JUIGlzIG5vdCBzZXQKQ09ORklHX0hQRVQ9eQojIENPTkZJR19IUEVUX01N
QVAgaXMgbm90IHNldAojIENPTkZJR19IQU5HQ0hFQ0tfVElNRVIgaXMgbm90IHNldApDT05G
SUdfVENHX1RQTT15CkNPTkZJR19IV19SQU5ET01fVFBNPXkKQ09ORklHX1RDR19USVNfQ09S
RT15CkNPTkZJR19UQ0dfVElTPXkKIyBDT05GSUdfVENHX1RJU19TUEkgaXMgbm90IHNldAoj
IENPTkZJR19UQ0dfVElTX0kyQyBpcyBub3Qgc2V0CiMgQ09ORklHX1RDR19USVNfSTJDX0NS
NTAgaXMgbm90IHNldAojIENPTkZJR19UQ0dfVElTX0kyQ19BVE1FTCBpcyBub3Qgc2V0CiMg
Q09ORklHX1RDR19USVNfSTJDX0lORklORU9OIGlzIG5vdCBzZXQKIyBDT05GSUdfVENHX1RJ
U19JMkNfTlVWT1RPTiBpcyBub3Qgc2V0CiMgQ09ORklHX1RDR19OU0MgaXMgbm90IHNldAoj
IENPTkZJR19UQ0dfQVRNRUwgaXMgbm90IHNldAojIENPTkZJR19UQ0dfSU5GSU5FT04gaXMg
bm90IHNldAojIENPTkZJR19UQ0dfWEVOIGlzIG5vdCBzZXQKQ09ORklHX1RDR19DUkI9eQoj
IENPTkZJR19UQ0dfVlRQTV9QUk9YWSBpcyBub3Qgc2V0CiMgQ09ORklHX1RDR19USVNfU1Qz
M1pQMjRfSTJDIGlzIG5vdCBzZXQKIyBDT05GSUdfVENHX1RJU19TVDMzWlAyNF9TUEkgaXMg
bm90IHNldAojIENPTkZJR19URUxDTE9DSyBpcyBub3Qgc2V0CiMgQ09ORklHX1hJTExZQlVT
IGlzIG5vdCBzZXQKIyBDT05GSUdfWElMTFlVU0IgaXMgbm90IHNldAojIGVuZCBvZiBDaGFy
YWN0ZXIgZGV2aWNlcwoKIwojIEkyQyBzdXBwb3J0CiMKQ09ORklHX0kyQz15CkNPTkZJR19B
Q1BJX0kyQ19PUFJFR0lPTj15CkNPTkZJR19JMkNfQk9BUkRJTkZPPXkKQ09ORklHX0kyQ19D
T01QQVQ9eQojIENPTkZJR19JMkNfQ0hBUkRFViBpcyBub3Qgc2V0CiMgQ09ORklHX0kyQ19N
VVggaXMgbm90IHNldApDT05GSUdfSTJDX0hFTFBFUl9BVVRPPXkKQ09ORklHX0kyQ19TTUJV
Uz1tCgojCiMgSTJDIEhhcmR3YXJlIEJ1cyBzdXBwb3J0CiMKCiMKIyBQQyBTTUJ1cyBob3N0
IGNvbnRyb2xsZXIgZHJpdmVycwojCiMgQ09ORklHX0kyQ19BTEkxNTM1IGlzIG5vdCBzZXQK
IyBDT05GSUdfSTJDX0FMSTE1NjMgaXMgbm90IHNldAojIENPTkZJR19JMkNfQUxJMTVYMyBp
cyBub3Qgc2V0CiMgQ09ORklHX0kyQ19BTUQ3NTYgaXMgbm90IHNldAojIENPTkZJR19JMkNf
QU1EODExMSBpcyBub3Qgc2V0CiMgQ09ORklHX0kyQ19BTURfTVAyIGlzIG5vdCBzZXQKQ09O
RklHX0kyQ19JODAxPW0KIyBDT05GSUdfSTJDX0lTQ0ggaXMgbm90IHNldAojIENPTkZJR19J
MkNfSVNNVCBpcyBub3Qgc2V0CiMgQ09ORklHX0kyQ19QSUlYNCBpcyBub3Qgc2V0CiMgQ09O
RklHX0kyQ19DSFRfV0MgaXMgbm90IHNldAojIENPTkZJR19JMkNfTkZPUkNFMiBpcyBub3Qg
c2V0CiMgQ09ORklHX0kyQ19OVklESUFfR1BVIGlzIG5vdCBzZXQKIyBDT05GSUdfSTJDX1NJ
UzU1OTUgaXMgbm90IHNldAojIENPTkZJR19JMkNfU0lTNjMwIGlzIG5vdCBzZXQKIyBDT05G
SUdfSTJDX1NJUzk2WCBpcyBub3Qgc2V0CiMgQ09ORklHX0kyQ19WSUEgaXMgbm90IHNldAoj
IENPTkZJR19JMkNfVklBUFJPIGlzIG5vdCBzZXQKCiMKIyBBQ1BJIGRyaXZlcnMKIwojIENP
TkZJR19JMkNfU0NNSSBpcyBub3Qgc2V0CgojCiMgSTJDIHN5c3RlbSBidXMgZHJpdmVycyAo
bW9zdGx5IGVtYmVkZGVkIC8gc3lzdGVtLW9uLWNoaXApCiMKIyBDT05GSUdfSTJDX0NCVVNf
R1BJTyBpcyBub3Qgc2V0CkNPTkZJR19JMkNfREVTSUdOV0FSRV9DT1JFPXkKQ09ORklHX0ky
Q19ERVNJR05XQVJFX1NMQVZFPXkKQ09ORklHX0kyQ19ERVNJR05XQVJFX1BMQVRGT1JNPXkK
Q09ORklHX0kyQ19ERVNJR05XQVJFX0JBWVRSQUlMPXkKIyBDT05GSUdfSTJDX0RFU0lHTldB
UkVfUENJIGlzIG5vdCBzZXQKIyBDT05GSUdfSTJDX0VNRVYyIGlzIG5vdCBzZXQKIyBDT05G
SUdfSTJDX0dQSU8gaXMgbm90IHNldAojIENPTkZJR19JMkNfT0NPUkVTIGlzIG5vdCBzZXQK
IyBDT05GSUdfSTJDX1BDQV9QTEFURk9STSBpcyBub3Qgc2V0CiMgQ09ORklHX0kyQ19TSU1U
RUMgaXMgbm90IHNldAojIENPTkZJR19JMkNfWElMSU5YIGlzIG5vdCBzZXQKCiMKIyBFeHRl
cm5hbCBJMkMvU01CdXMgYWRhcHRlciBkcml2ZXJzCiMKIyBDT05GSUdfSTJDX0RJT0xBTl9V
MkMgaXMgbm90IHNldAojIENPTkZJR19JMkNfQ1AyNjE1IGlzIG5vdCBzZXQKIyBDT05GSUdf
STJDX1BDSTFYWFhYIGlzIG5vdCBzZXQKIyBDT05GSUdfSTJDX1JPQk9URlVaWl9PU0lGIGlz
IG5vdCBzZXQKIyBDT05GSUdfSTJDX1RBT1NfRVZNIGlzIG5vdCBzZXQKIyBDT05GSUdfSTJD
X1RJTllfVVNCIGlzIG5vdCBzZXQKCiMKIyBPdGhlciBJMkMvU01CdXMgYnVzIGRyaXZlcnMK
IwojIENPTkZJR19JMkNfTUxYQ1BMRCBpcyBub3Qgc2V0CiMgQ09ORklHX0kyQ19WSVJUSU8g
aXMgbm90IHNldAojIGVuZCBvZiBJMkMgSGFyZHdhcmUgQnVzIHN1cHBvcnQKCiMgQ09ORklH
X0kyQ19TVFVCIGlzIG5vdCBzZXQKQ09ORklHX0kyQ19TTEFWRT15CiMgQ09ORklHX0kyQ19T
TEFWRV9FRVBST00gaXMgbm90IHNldAojIENPTkZJR19JMkNfU0xBVkVfVEVTVFVOSVQgaXMg
bm90IHNldAojIENPTkZJR19JMkNfREVCVUdfQ09SRSBpcyBub3Qgc2V0CiMgQ09ORklHX0ky
Q19ERUJVR19BTEdPIGlzIG5vdCBzZXQKIyBDT05GSUdfSTJDX0RFQlVHX0JVUyBpcyBub3Qg
c2V0CiMgZW5kIG9mIEkyQyBzdXBwb3J0CgojIENPTkZJR19JM0MgaXMgbm90IHNldApDT05G
SUdfU1BJPXkKIyBDT05GSUdfU1BJX0RFQlVHIGlzIG5vdCBzZXQKQ09ORklHX1NQSV9NQVNU
RVI9eQpDT05GSUdfU1BJX01FTT15CgojCiMgU1BJIE1hc3RlciBDb250cm9sbGVyIERyaXZl
cnMKIwojIENPTkZJR19TUElfQUxURVJBIGlzIG5vdCBzZXQKIyBDT05GSUdfU1BJX0FYSV9T
UElfRU5HSU5FIGlzIG5vdCBzZXQKIyBDT05GSUdfU1BJX0JJVEJBTkcgaXMgbm90IHNldAoj
IENPTkZJR19TUElfQ0FERU5DRSBpcyBub3Qgc2V0CiMgQ09ORklHX1NQSV9ERVNJR05XQVJF
IGlzIG5vdCBzZXQKIyBDT05GSUdfU1BJX0dQSU8gaXMgbm90IHNldAojIENPTkZJR19TUElf
SU5URUxfUENJIGlzIG5vdCBzZXQKIyBDT05GSUdfU1BJX0lOVEVMX1BMQVRGT1JNIGlzIG5v
dCBzZXQKIyBDT05GSUdfU1BJX01JQ1JPQ0hJUF9DT1JFIGlzIG5vdCBzZXQKIyBDT05GSUdf
U1BJX01JQ1JPQ0hJUF9DT1JFX1FTUEkgaXMgbm90IHNldAojIENPTkZJR19TUElfTEFOVElR
X1NTQyBpcyBub3Qgc2V0CiMgQ09ORklHX1NQSV9PQ19USU5ZIGlzIG5vdCBzZXQKIyBDT05G
SUdfU1BJX1BDSTFYWFhYIGlzIG5vdCBzZXQKIyBDT05GSUdfU1BJX1BYQTJYWCBpcyBub3Qg
c2V0CiMgQ09ORklHX1NQSV9TQzE4SVM2MDIgaXMgbm90IHNldAojIENPTkZJR19TUElfU0lG
SVZFIGlzIG5vdCBzZXQKIyBDT05GSUdfU1BJX01YSUMgaXMgbm90IHNldAojIENPTkZJR19T
UElfWENPTU0gaXMgbm90IHNldAojIENPTkZJR19TUElfWElMSU5YIGlzIG5vdCBzZXQKIyBD
T05GSUdfU1BJX1pZTlFNUF9HUVNQSSBpcyBub3Qgc2V0CiMgQ09ORklHX1NQSV9BTUQgaXMg
bm90IHNldAoKIwojIFNQSSBNdWx0aXBsZXhlciBzdXBwb3J0CiMKIyBDT05GSUdfU1BJX01V
WCBpcyBub3Qgc2V0CgojCiMgU1BJIFByb3RvY29sIE1hc3RlcnMKIwojIENPTkZJR19TUElf
U1BJREVWIGlzIG5vdCBzZXQKIyBDT05GSUdfU1BJX0xPT1BCQUNLX1RFU1QgaXMgbm90IHNl
dAojIENPTkZJR19TUElfVExFNjJYMCBpcyBub3Qgc2V0CkNPTkZJR19TUElfU0xBVkU9eQoj
IENPTkZJR19TUElfU0xBVkVfVElNRSBpcyBub3Qgc2V0CiMgQ09ORklHX1NQSV9TTEFWRV9T
WVNURU1fQ09OVFJPTCBpcyBub3Qgc2V0CkNPTkZJR19TUElfRFlOQU1JQz15CiMgQ09ORklH
X1NQTUkgaXMgbm90IHNldAojIENPTkZJR19IU0kgaXMgbm90IHNldApDT05GSUdfUFBTPXkK
IyBDT05GSUdfUFBTX0RFQlVHIGlzIG5vdCBzZXQKCiMKIyBQUFMgY2xpZW50cyBzdXBwb3J0
CiMKIyBDT05GSUdfUFBTX0NMSUVOVF9LVElNRVIgaXMgbm90IHNldAojIENPTkZJR19QUFNf
Q0xJRU5UX0xESVNDIGlzIG5vdCBzZXQKIyBDT05GSUdfUFBTX0NMSUVOVF9HUElPIGlzIG5v
dCBzZXQKCiMKIyBQUFMgZ2VuZXJhdG9ycyBzdXBwb3J0CiMKCiMKIyBQVFAgY2xvY2sgc3Vw
cG9ydAojCkNPTkZJR19QVFBfMTU4OF9DTE9DSz15CkNPTkZJR19QVFBfMTU4OF9DTE9DS19P
UFRJT05BTD15CgojCiMgRW5hYmxlIFBIWUxJQiBhbmQgTkVUV09SS19QSFlfVElNRVNUQU1Q
SU5HIHRvIHNlZSB0aGUgYWRkaXRpb25hbCBjbG9ja3MuCiMKQ09ORklHX1BUUF8xNTg4X0NM
T0NLX0tWTT1tCiMgQ09ORklHX1BUUF8xNTg4X0NMT0NLX0lEVDgyUDMzIGlzIG5vdCBzZXQK
IyBDT05GSUdfUFRQXzE1ODhfQ0xPQ0tfSURUQ00gaXMgbm90IHNldAojIENPTkZJR19QVFBf
MTU4OF9DTE9DS19NT0NLIGlzIG5vdCBzZXQKIyBDT05GSUdfUFRQXzE1ODhfQ0xPQ0tfVk1X
IGlzIG5vdCBzZXQKIyBlbmQgb2YgUFRQIGNsb2NrIHN1cHBvcnQKCkNPTkZJR19QSU5DVFJM
PXkKQ09ORklHX1BJTk1VWD15CkNPTkZJR19QSU5DT05GPXkKQ09ORklHX0dFTkVSSUNfUElO
Q09ORj15CiMgQ09ORklHX0RFQlVHX1BJTkNUUkwgaXMgbm90IHNldApDT05GSUdfUElOQ1RS
TF9BTUQ9eQojIENPTkZJR19QSU5DVFJMX0NZOEM5NVgwIGlzIG5vdCBzZXQKIyBDT05GSUdf
UElOQ1RSTF9NQ1AyM1MwOCBpcyBub3Qgc2V0CkNPTkZJR19QSU5DVFJMX1NYMTUwWD15Cgoj
CiMgSW50ZWwgcGluY3RybCBkcml2ZXJzCiMKQ09ORklHX1BJTkNUUkxfQkFZVFJBSUw9eQpD
T05GSUdfUElOQ1RSTF9DSEVSUllWSUVXPXkKQ09ORklHX1BJTkNUUkxfTFlOWFBPSU5UPXkK
Q09ORklHX1BJTkNUUkxfSU5URUw9eQojIENPTkZJR19QSU5DVFJMX0lOVEVMX1BMQVRGT1JN
IGlzIG5vdCBzZXQKQ09ORklHX1BJTkNUUkxfQUxERVJMQUtFPXkKQ09ORklHX1BJTkNUUkxf
QlJPWFRPTj15CkNPTkZJR19QSU5DVFJMX0NBTk5PTkxBS0U9eQpDT05GSUdfUElOQ1RSTF9D
RURBUkZPUks9eQpDT05GSUdfUElOQ1RSTF9ERU5WRVJUT049eQpDT05GSUdfUElOQ1RSTF9F
TEtIQVJUTEFLRT15CkNPTkZJR19QSU5DVFJMX0VNTUlUU0JVUkc9eQpDT05GSUdfUElOQ1RS
TF9HRU1JTklMQUtFPXkKQ09ORklHX1BJTkNUUkxfSUNFTEFLRT15CkNPTkZJR19QSU5DVFJM
X0pBU1BFUkxBS0U9eQpDT05GSUdfUElOQ1RSTF9MQUtFRklFTEQ9eQpDT05GSUdfUElOQ1RS
TF9MRVdJU0JVUkc9eQpDT05GSUdfUElOQ1RSTF9NRVRFT1JMQUtFPXkKIyBDT05GSUdfUElO
Q1RSTF9NRVRFT1JQT0lOVCBpcyBub3Qgc2V0CkNPTkZJR19QSU5DVFJMX1NVTlJJU0VQT0lO
VD15CkNPTkZJR19QSU5DVFJMX1RJR0VSTEFLRT15CiMgZW5kIG9mIEludGVsIHBpbmN0cmwg
ZHJpdmVycwoKIwojIFJlbmVzYXMgcGluY3RybCBkcml2ZXJzCiMKIyBlbmQgb2YgUmVuZXNh
cyBwaW5jdHJsIGRyaXZlcnMKCkNPTkZJR19HUElPTElCPXkKQ09ORklHX0dQSU9MSUJfRkFT
VFBBVEhfTElNSVQ9NTEyCkNPTkZJR19HUElPX0FDUEk9eQpDT05GSUdfR1BJT0xJQl9JUlFD
SElQPXkKIyBDT05GSUdfREVCVUdfR1BJTyBpcyBub3Qgc2V0CkNPTkZJR19HUElPX0NERVY9
eQpDT05GSUdfR1BJT19DREVWX1YxPXkKCiMKIyBNZW1vcnkgbWFwcGVkIEdQSU8gZHJpdmVy
cwojCiMgQ09ORklHX0dQSU9fQU1EUFQgaXMgbm90IHNldAojIENPTkZJR19HUElPX0RXQVBC
IGlzIG5vdCBzZXQKIyBDT05GSUdfR1BJT19HRU5FUklDX1BMQVRGT1JNIGlzIG5vdCBzZXQK
IyBDT05GSUdfR1BJT19JQ0ggaXMgbm90IHNldAojIENPTkZJR19HUElPX01CODZTN1ggaXMg
bm90IHNldAojIENPTkZJR19HUElPX0FNRF9GQ0ggaXMgbm90IHNldAojIGVuZCBvZiBNZW1v
cnkgbWFwcGVkIEdQSU8gZHJpdmVycwoKIwojIFBvcnQtbWFwcGVkIEkvTyBHUElPIGRyaXZl
cnMKIwojIENPTkZJR19HUElPX1ZYODU1IGlzIG5vdCBzZXQKIyBDT05GSUdfR1BJT19GNzE4
OFggaXMgbm90IHNldAojIENPTkZJR19HUElPX0lUODcgaXMgbm90IHNldAojIENPTkZJR19H
UElPX1NDSDMxMVggaXMgbm90IHNldAojIENPTkZJR19HUElPX1dJTkJPTkQgaXMgbm90IHNl
dAojIENPTkZJR19HUElPX1dTMTZDNDggaXMgbm90IHNldAojIGVuZCBvZiBQb3J0LW1hcHBl
ZCBJL08gR1BJTyBkcml2ZXJzCgojCiMgSTJDIEdQSU8gZXhwYW5kZXJzCiMKIyBDT05GSUdf
R1BJT19GWEw2NDA4IGlzIG5vdCBzZXQKIyBDT05GSUdfR1BJT19EUzQ1MjAgaXMgbm90IHNl
dAojIENPTkZJR19HUElPX01BWDczMDAgaXMgbm90IHNldAojIENPTkZJR19HUElPX01BWDcz
MlggaXMgbm90IHNldAojIENPTkZJR19HUElPX1BDQTk1M1ggaXMgbm90IHNldAojIENPTkZJ
R19HUElPX1BDQTk1NzAgaXMgbm90IHNldAojIENPTkZJR19HUElPX1BDRjg1N1ggaXMgbm90
IHNldAojIENPTkZJR19HUElPX1RQSUMyODEwIGlzIG5vdCBzZXQKIyBlbmQgb2YgSTJDIEdQ
SU8gZXhwYW5kZXJzCgojCiMgTUZEIEdQSU8gZXhwYW5kZXJzCiMKIyBDT05GSUdfR1BJT19B
RFA1NTIwIGlzIG5vdCBzZXQKIyBDT05GSUdfR1BJT19DUllTVEFMX0NPVkUgaXMgbm90IHNl
dAojIENPTkZJR19HUElPX0RBOTA1MiBpcyBub3Qgc2V0CiMgQ09ORklHX0dQSU9fREE5MDU1
IGlzIG5vdCBzZXQKIyBDT05GSUdfR1BJT19FTEtIQVJUTEFLRSBpcyBub3Qgc2V0CkNPTkZJ
R19HUElPX1BBTE1BUz15CkNPTkZJR19HUElPX1JDNVQ1ODM9eQpDT05GSUdfR1BJT19UUFM2
NTg2WD15CkNPTkZJR19HUElPX1RQUzY1OTEwPXkKIyBDT05GSUdfR1BJT19UV0w0MDMwIGlz
IG5vdCBzZXQKIyBDT05GSUdfR1BJT19UV0w2MDQwIGlzIG5vdCBzZXQKIyBDT05GSUdfR1BJ
T19XTTgzMVggaXMgbm90IHNldAojIENPTkZJR19HUElPX1dNODM1MCBpcyBub3Qgc2V0CiMg
ZW5kIG9mIE1GRCBHUElPIGV4cGFuZGVycwoKIwojIFBDSSBHUElPIGV4cGFuZGVycwojCiMg
Q09ORklHX0dQSU9fQU1EODExMSBpcyBub3Qgc2V0CiMgQ09ORklHX0dQSU9fQlQ4WFggaXMg
bm90IHNldAojIENPTkZJR19HUElPX01MX0lPSCBpcyBub3Qgc2V0CiMgQ09ORklHX0dQSU9f
UENJX0lESU9fMTYgaXMgbm90IHNldAojIENPTkZJR19HUElPX1BDSUVfSURJT18yNCBpcyBu
b3Qgc2V0CiMgQ09ORklHX0dQSU9fUkRDMzIxWCBpcyBub3Qgc2V0CiMgZW5kIG9mIFBDSSBH
UElPIGV4cGFuZGVycwoKIwojIFNQSSBHUElPIGV4cGFuZGVycwojCiMgQ09ORklHX0dQSU9f
TUFYMzE5MVggaXMgbm90IHNldAojIENPTkZJR19HUElPX01BWDczMDEgaXMgbm90IHNldAoj
IENPTkZJR19HUElPX01DMzM4ODAgaXMgbm90IHNldAojIENPTkZJR19HUElPX1BJU09TUiBp
cyBub3Qgc2V0CiMgQ09ORklHX0dQSU9fWFJBMTQwMyBpcyBub3Qgc2V0CiMgZW5kIG9mIFNQ
SSBHUElPIGV4cGFuZGVycwoKIwojIFVTQiBHUElPIGV4cGFuZGVycwojCiMgZW5kIG9mIFVT
QiBHUElPIGV4cGFuZGVycwoKIwojIFZpcnR1YWwgR1BJTyBkcml2ZXJzCiMKIyBDT05GSUdf
R1BJT19BR0dSRUdBVE9SIGlzIG5vdCBzZXQKIyBDT05GSUdfR1BJT19MQVRDSCBpcyBub3Qg
c2V0CiMgQ09ORklHX0dQSU9fTU9DS1VQIGlzIG5vdCBzZXQKIyBDT05GSUdfR1BJT19WSVJU
SU8gaXMgbm90IHNldAojIENPTkZJR19HUElPX1NJTSBpcyBub3Qgc2V0CiMgZW5kIG9mIFZp
cnR1YWwgR1BJTyBkcml2ZXJzCgojIENPTkZJR19XMSBpcyBub3Qgc2V0CkNPTkZJR19QT1dF
Ul9SRVNFVD15CkNPTkZJR19QT1dFUl9SRVNFVF9SRVNUQVJUPXkKQ09ORklHX1BPV0VSX1NV
UFBMWT15CiMgQ09ORklHX1BPV0VSX1NVUFBMWV9ERUJVRyBpcyBub3Qgc2V0CkNPTkZJR19Q
T1dFUl9TVVBQTFlfSFdNT049eQojIENPTkZJR19JUDVYWFhfUE9XRVIgaXMgbm90IHNldAoj
IENPTkZJR19NQVg4OTI1X1BPV0VSIGlzIG5vdCBzZXQKIyBDT05GSUdfV004MzFYX0JBQ0tV
UCBpcyBub3Qgc2V0CiMgQ09ORklHX1dNODMxWF9QT1dFUiBpcyBub3Qgc2V0CiMgQ09ORklH
X1dNODM1MF9QT1dFUiBpcyBub3Qgc2V0CiMgQ09ORklHX1RFU1RfUE9XRVIgaXMgbm90IHNl
dAojIENPTkZJR19CQVRURVJZXzg4UE04NjBYIGlzIG5vdCBzZXQKIyBDT05GSUdfQ0hBUkdF
Ul9BRFA1MDYxIGlzIG5vdCBzZXQKIyBDT05GSUdfQkFUVEVSWV9DVzIwMTUgaXMgbm90IHNl
dAojIENPTkZJR19CQVRURVJZX0RTMjc4MCBpcyBub3Qgc2V0CiMgQ09ORklHX0JBVFRFUllf
RFMyNzgxIGlzIG5vdCBzZXQKIyBDT05GSUdfQkFUVEVSWV9EUzI3ODIgaXMgbm90IHNldAoj
IENPTkZJR19CQVRURVJZX1NBTVNVTkdfU0RJIGlzIG5vdCBzZXQKIyBDT05GSUdfQkFUVEVS
WV9TQlMgaXMgbm90IHNldAojIENPTkZJR19DSEFSR0VSX1NCUyBpcyBub3Qgc2V0CiMgQ09O
RklHX0JBVFRFUllfQlEyN1hYWCBpcyBub3Qgc2V0CiMgQ09ORklHX0JBVFRFUllfREE5MDMw
IGlzIG5vdCBzZXQKIyBDT05GSUdfQkFUVEVSWV9EQTkwNTIgaXMgbm90IHNldAojIENPTkZJ
R19CQVRURVJZX01BWDE3MDQyIGlzIG5vdCBzZXQKIyBDT05GSUdfQ0hBUkdFUl9NQVg4OTAz
IGlzIG5vdCBzZXQKIyBDT05GSUdfQ0hBUkdFUl9MUDg3MjcgaXMgbm90IHNldAojIENPTkZJ
R19DSEFSR0VSX0dQSU8gaXMgbm90IHNldApDT05GSUdfQ0hBUkdFUl9NQU5BR0VSPXkKIyBD
T05GSUdfQ0hBUkdFUl9MVDM2NTEgaXMgbm90IHNldAojIENPTkZJR19DSEFSR0VSX0xUQzQx
NjJMIGlzIG5vdCBzZXQKIyBDT05GSUdfQ0hBUkdFUl9NQVg3Nzk3NiBpcyBub3Qgc2V0CiMg
Q09ORklHX0NIQVJHRVJfQlEyNDE1WCBpcyBub3Qgc2V0CiMgQ09ORklHX0NIQVJHRVJfQlEy
NDE5MCBpcyBub3Qgc2V0CiMgQ09ORklHX0NIQVJHRVJfQlEyNDI1NyBpcyBub3Qgc2V0CiMg
Q09ORklHX0NIQVJHRVJfQlEyNDczNSBpcyBub3Qgc2V0CiMgQ09ORklHX0NIQVJHRVJfQlEy
NTE1WCBpcyBub3Qgc2V0CiMgQ09ORklHX0NIQVJHRVJfQlEyNTg5MCBpcyBub3Qgc2V0CiMg
Q09ORklHX0NIQVJHRVJfQlEyNTk4MCBpcyBub3Qgc2V0CiMgQ09ORklHX0NIQVJHRVJfQlEy
NTZYWCBpcyBub3Qgc2V0CiMgQ09ORklHX0NIQVJHRVJfU01CMzQ3IGlzIG5vdCBzZXQKIyBD
T05GSUdfQ0hBUkdFUl9UUFM2NTA5MCBpcyBub3Qgc2V0CiMgQ09ORklHX0JBVFRFUllfR0FV
R0VfTFRDMjk0MSBpcyBub3Qgc2V0CiMgQ09ORklHX0JBVFRFUllfR09MREZJU0ggaXMgbm90
IHNldAojIENPTkZJR19CQVRURVJZX1JUNTAzMyBpcyBub3Qgc2V0CiMgQ09ORklHX0NIQVJH
RVJfUlQ5NDU1IGlzIG5vdCBzZXQKIyBDT05GSUdfQ0hBUkdFUl9SVDk0NjcgaXMgbm90IHNl
dAojIENPTkZJR19DSEFSR0VSX1JUOTQ3MSBpcyBub3Qgc2V0CiMgQ09ORklHX0NIQVJHRVJf
QkQ5OTk1NCBpcyBub3Qgc2V0CiMgQ09ORklHX0JBVFRFUllfVUczMTA1IGlzIG5vdCBzZXQK
IyBDT05GSUdfRlVFTF9HQVVHRV9NTTgwMTMgaXMgbm90IHNldApDT05GSUdfSFdNT049eQoj
IENPTkZJR19IV01PTl9ERUJVR19DSElQIGlzIG5vdCBzZXQKCiMKIyBOYXRpdmUgZHJpdmVy
cwojCiMgQ09ORklHX1NFTlNPUlNfQUJJVFVHVVJVIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VO
U09SU19BQklUVUdVUlUzIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19BRDczMTQgaXMg
bm90IHNldAojIENPTkZJR19TRU5TT1JTX0FENzQxNCBpcyBub3Qgc2V0CiMgQ09ORklHX1NF
TlNPUlNfQUQ3NDE4IGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19BRE0xMDIxIGlzIG5v
dCBzZXQKIyBDT05GSUdfU0VOU09SU19BRE0xMDI1IGlzIG5vdCBzZXQKIyBDT05GSUdfU0VO
U09SU19BRE0xMDI2IGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19BRE0xMDI5IGlzIG5v
dCBzZXQKIyBDT05GSUdfU0VOU09SU19BRE0xMDMxIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VO
U09SU19BRE0xMTc3IGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19BRE05MjQwIGlzIG5v
dCBzZXQKIyBDT05GSUdfU0VOU09SU19BRFQ3MzEwIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VO
U09SU19BRFQ3NDEwIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19BRFQ3NDExIGlzIG5v
dCBzZXQKIyBDT05GSUdfU0VOU09SU19BRFQ3NDYyIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VO
U09SU19BRFQ3NDcwIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19BRFQ3NDc1IGlzIG5v
dCBzZXQKIyBDT05GSUdfU0VOU09SU19BSFQxMCBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNP
UlNfQVMzNzAgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX0FTQzc2MjEgaXMgbm90IHNl
dAojIENPTkZJR19TRU5TT1JTX0FYSV9GQU5fQ09OVFJPTCBpcyBub3Qgc2V0CiMgQ09ORklH
X1NFTlNPUlNfSzhURU1QIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19LMTBURU1QIGlz
IG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19GQU0xNUhfUE9XRVIgaXMgbm90IHNldAojIENP
TkZJR19TRU5TT1JTX0FQUExFU01DIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19BU0Ix
MDAgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX0FUWFAxIGlzIG5vdCBzZXQKIyBDT05G
SUdfU0VOU09SU19DT1JTQUlSX0NQUk8gaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX0NP
UlNBSVJfUFNVIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19EUklWRVRFTVAgaXMgbm90
IHNldAojIENPTkZJR19TRU5TT1JTX0RTNjIwIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09S
U19EUzE2MjEgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX0RBOTA1Ml9BREMgaXMgbm90
IHNldAojIENPTkZJR19TRU5TT1JTX0RBOTA1NSBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNP
UlNfSTVLX0FNQiBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfRjcxODA1RiBpcyBub3Qg
c2V0CiMgQ09ORklHX1NFTlNPUlNfRjcxODgyRkcgaXMgbm90IHNldAojIENPTkZJR19TRU5T
T1JTX0Y3NTM3NVMgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX0ZTQ0hNRCBpcyBub3Qg
c2V0CiMgQ09ORklHX1NFTlNPUlNfRlRTVEVVVEFURVMgaXMgbm90IHNldAojIENPTkZJR19T
RU5TT1JTX0dMNTE4U00gaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX0dMNTIwU00gaXMg
bm90IHNldAojIENPTkZJR19TRU5TT1JTX0c3NjBBIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VO
U09SU19HNzYyIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19ISUg2MTMwIGlzIG5vdCBz
ZXQKIyBDT05GSUdfU0VOU09SU19IUzMwMDEgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JT
X0k1NTAwIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19DT1JFVEVNUCBpcyBub3Qgc2V0
CiMgQ09ORklHX1NFTlNPUlNfSVQ4NyBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfSkM0
MiBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfUE9XRVJaIGlzIG5vdCBzZXQKIyBDT05G
SUdfU0VOU09SU19QT1dSMTIyMCBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfTElORUFH
RSBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfTFRDMjk0NSBpcyBub3Qgc2V0CiMgQ09O
RklHX1NFTlNPUlNfTFRDMjk0N19JMkMgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX0xU
QzI5NDdfU1BJIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19MVEMyOTkwIGlzIG5vdCBz
ZXQKIyBDT05GSUdfU0VOU09SU19MVEMyOTkxIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09S
U19MVEMyOTkyIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19MVEM0MTUxIGlzIG5vdCBz
ZXQKIyBDT05GSUdfU0VOU09SU19MVEM0MjE1IGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09S
U19MVEM0MjIyIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19MVEM0MjQ1IGlzIG5vdCBz
ZXQKIyBDT05GSUdfU0VOU09SU19MVEM0MjYwIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09S
U19MVEM0MjYxIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19NQVgxMTExIGlzIG5vdCBz
ZXQKIyBDT05GSUdfU0VOU09SU19NQVgxMjcgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JT
X01BWDE2MDY1IGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19NQVgxNjE5IGlzIG5vdCBz
ZXQKIyBDT05GSUdfU0VOU09SU19NQVgxNjY4IGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09S
U19NQVgxOTcgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX01BWDMxNzIyIGlzIG5vdCBz
ZXQKIyBDT05GSUdfU0VOU09SU19NQVgzMTczMCBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNP
UlNfTUFYMzE3NjAgaXMgbm90IHNldAojIENPTkZJR19NQVgzMTgyNyBpcyBub3Qgc2V0CiMg
Q09ORklHX1NFTlNPUlNfTUFYNjYyMCBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfTUFY
NjYyMSBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfTUFYNjYzOSBpcyBub3Qgc2V0CiMg
Q09ORklHX1NFTlNPUlNfTUFYNjY0MiBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfTUFY
NjY1MCBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfTUFYNjY5NyBpcyBub3Qgc2V0CiMg
Q09ORklHX1NFTlNPUlNfTUFYMzE3OTAgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX01D
MzRWUjUwMCBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfTUNQMzAyMSBpcyBub3Qgc2V0
CiMgQ09ORklHX1NFTlNPUlNfTUxYUkVHX0ZBTiBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNP
UlNfVEM2NTQgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX1RQUzIzODYxIGlzIG5vdCBz
ZXQKIyBDT05GSUdfU0VOU09SU19NUjc1MjAzIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09S
U19BRENYWCBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfTE02MyBpcyBub3Qgc2V0CiMg
Q09ORklHX1NFTlNPUlNfTE03MCBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfTE03MyBp
cyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfTE03NSBpcyBub3Qgc2V0CiMgQ09ORklHX1NF
TlNPUlNfTE03NyBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfTE03OCBpcyBub3Qgc2V0
CiMgQ09ORklHX1NFTlNPUlNfTE04MCBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfTE04
MyBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfTE04NSBpcyBub3Qgc2V0CiMgQ09ORklH
X1NFTlNPUlNfTE04NyBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfTE05MCBpcyBub3Qg
c2V0CiMgQ09ORklHX1NFTlNPUlNfTE05MiBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNf
TE05MyBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfTE05NTIzNCBpcyBub3Qgc2V0CiMg
Q09ORklHX1NFTlNPUlNfTE05NTI0MSBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfTE05
NTI0NSBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfUEM4NzM2MCBpcyBub3Qgc2V0CiMg
Q09ORklHX1NFTlNPUlNfUEM4NzQyNyBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfTkNU
NjY4MyBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfTkNUNjc3NSBpcyBub3Qgc2V0CiMg
Q09ORklHX1NFTlNPUlNfTkNUNjc3NV9JMkMgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JT
X05DVDc4MDIgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX05DVDc5MDQgaXMgbm90IHNl
dAojIENPTkZJR19TRU5TT1JTX05QQ003WFggaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JT
X09DQ19QOF9JMkMgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX09YUCBpcyBub3Qgc2V0
CiMgQ09ORklHX1NFTlNPUlNfUENGODU5MSBpcyBub3Qgc2V0CiMgQ09ORklHX1BNQlVTIGlz
IG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19TQlRTSSBpcyBub3Qgc2V0CiMgQ09ORklHX1NF
TlNPUlNfU0JSTUkgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX1NIVDE1IGlzIG5vdCBz
ZXQKIyBDT05GSUdfU0VOU09SU19TSFQyMSBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNf
U0hUM3ggaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX1NIVDR4IGlzIG5vdCBzZXQKIyBD
T05GSUdfU0VOU09SU19TSFRDMSBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfU0lTNTU5
NSBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfRE1FMTczNyBpcyBub3Qgc2V0CiMgQ09O
RklHX1NFTlNPUlNfRU1DMTQwMyBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfRU1DMjEw
MyBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfRU1DMjMwNSBpcyBub3Qgc2V0CiMgQ09O
RklHX1NFTlNPUlNfRU1DNlcyMDEgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX1NNU0M0
N00xIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19TTVNDNDdNMTkyIGlzIG5vdCBzZXQK
IyBDT05GSUdfU0VOU09SU19TTVNDNDdCMzk3IGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09S
U19TQ0g1NjI3IGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19TQ0g1NjM2IGlzIG5vdCBz
ZXQKIyBDT05GSUdfU0VOU09SU19TVFRTNzUxIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09S
U19BREMxMjhEODE4IGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19BRFM3ODI4IGlzIG5v
dCBzZXQKIyBDT05GSUdfU0VOU09SU19BRFM3ODcxIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VO
U09SU19BTUM2ODIxIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19JTkEyMDkgaXMgbm90
IHNldAojIENPTkZJR19TRU5TT1JTX0lOQTJYWCBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNP
UlNfSU5BMjM4IGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19JTkEzMjIxIGlzIG5vdCBz
ZXQKIyBDT05GSUdfU0VOU09SU19UQzc0IGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19U
SE1DNTAgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX1RNUDEwMiBpcyBub3Qgc2V0CiMg
Q09ORklHX1NFTlNPUlNfVE1QMTAzIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19UTVAx
MDggaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX1RNUDQwMSBpcyBub3Qgc2V0CiMgQ09O
RklHX1NFTlNPUlNfVE1QNDIxIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19UTVA0NjQg
aXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX1RNUDUxMyBpcyBub3Qgc2V0CiMgQ09ORklH
X1NFTlNPUlNfVklBX0NQVVRFTVAgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX1ZJQTY4
NkEgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX1ZUMTIxMSBpcyBub3Qgc2V0CiMgQ09O
RklHX1NFTlNPUlNfVlQ4MjMxIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19XODM3NzNH
IGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19XODM3ODFEIGlzIG5vdCBzZXQKIyBDT05G
SUdfU0VOU09SU19XODM3OTFEIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19XODM3OTJE
IGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19XODM3OTMgaXMgbm90IHNldAojIENPTkZJ
R19TRU5TT1JTX1c4Mzc5NSBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfVzgzTDc4NVRT
IGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19XODNMNzg2TkcgaXMgbm90IHNldAojIENP
TkZJR19TRU5TT1JTX1c4MzYyN0hGIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19XODM2
MjdFSEYgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX1dNODMxWCBpcyBub3Qgc2V0CiMg
Q09ORklHX1NFTlNPUlNfV004MzUwIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19YR0VO
RSBpcyBub3Qgc2V0CgojCiMgQUNQSSBkcml2ZXJzCiMKIyBDT05GSUdfU0VOU09SU19BQ1BJ
X1BPV0VSIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19BVEswMTEwIGlzIG5vdCBzZXQK
IyBDT05GSUdfU0VOU09SU19BU1VTX0VDIGlzIG5vdCBzZXQKQ09ORklHX1RIRVJNQUw9eQpD
T05GSUdfVEhFUk1BTF9ORVRMSU5LPXkKIyBDT05GSUdfVEhFUk1BTF9TVEFUSVNUSUNTIGlz
IG5vdCBzZXQKIyBDT05GSUdfVEhFUk1BTF9ERUJVR0ZTIGlzIG5vdCBzZXQKQ09ORklHX1RI
RVJNQUxfRU1FUkdFTkNZX1BPV0VST0ZGX0RFTEFZX01TPTEwMApDT05GSUdfVEhFUk1BTF9I
V01PTj15CkNPTkZJR19USEVSTUFMX1dSSVRBQkxFX1RSSVBTPXkKQ09ORklHX1RIRVJNQUxf
REVGQVVMVF9HT1ZfU1RFUF9XSVNFPXkKIyBDT05GSUdfVEhFUk1BTF9ERUZBVUxUX0dPVl9G
QUlSX1NIQVJFIGlzIG5vdCBzZXQKIyBDT05GSUdfVEhFUk1BTF9ERUZBVUxUX0dPVl9VU0VS
X1NQQUNFIGlzIG5vdCBzZXQKIyBDT05GSUdfVEhFUk1BTF9ERUZBVUxUX0dPVl9QT1dFUl9B
TExPQ0FUT1IgaXMgbm90IHNldAojIENPTkZJR19USEVSTUFMX0RFRkFVTFRfR09WX0JBTkdf
QkFORyBpcyBub3Qgc2V0CkNPTkZJR19USEVSTUFMX0dPVl9GQUlSX1NIQVJFPXkKQ09ORklH
X1RIRVJNQUxfR09WX1NURVBfV0lTRT15CkNPTkZJR19USEVSTUFMX0dPVl9CQU5HX0JBTkc9
eQpDT05GSUdfVEhFUk1BTF9HT1ZfVVNFUl9TUEFDRT15CkNPTkZJR19USEVSTUFMX0dPVl9Q
T1dFUl9BTExPQ0FUT1I9eQpDT05GSUdfREVWRlJFUV9USEVSTUFMPXkKIyBDT05GSUdfVEhF
Uk1BTF9FTVVMQVRJT04gaXMgbm90IHNldAoKIwojIEludGVsIHRoZXJtYWwgZHJpdmVycwoj
CiMgQ09ORklHX0lOVEVMX1BPV0VSQ0xBTVAgaXMgbm90IHNldApDT05GSUdfWDg2X1RIRVJN
QUxfVkVDVE9SPXkKIyBDT05GSUdfWDg2X1BLR19URU1QX1RIRVJNQUwgaXMgbm90IHNldAoj
IENPTkZJR19JTlRFTF9TT0NfRFRTX1RIRVJNQUwgaXMgbm90IHNldAoKIwojIEFDUEkgSU5U
MzQwWCB0aGVybWFsIGRyaXZlcnMKIwojIENPTkZJR19JTlQzNDBYX1RIRVJNQUwgaXMgbm90
IHNldAojIGVuZCBvZiBBQ1BJIElOVDM0MFggdGhlcm1hbCBkcml2ZXJzCgojIENPTkZJR19J
TlRFTF9QQ0hfVEhFUk1BTCBpcyBub3Qgc2V0CiMgQ09ORklHX0lOVEVMX1RDQ19DT09MSU5H
IGlzIG5vdCBzZXQKQ09ORklHX0lOVEVMX0hGSV9USEVSTUFMPXkKIyBlbmQgb2YgSW50ZWwg
dGhlcm1hbCBkcml2ZXJzCgpDT05GSUdfV0FUQ0hET0c9eQpDT05GSUdfV0FUQ0hET0dfQ09S
RT15CiMgQ09ORklHX1dBVENIRE9HX05PV0FZT1VUIGlzIG5vdCBzZXQKQ09ORklHX1dBVENI
RE9HX0hBTkRMRV9CT09UX0VOQUJMRUQ9eQpDT05GSUdfV0FUQ0hET0dfT1BFTl9USU1FT1VU
PTAKQ09ORklHX1dBVENIRE9HX1NZU0ZTPXkKIyBDT05GSUdfV0FUQ0hET0dfSFJUSU1FUl9Q
UkVUSU1FT1VUIGlzIG5vdCBzZXQKCiMKIyBXYXRjaGRvZyBQcmV0aW1lb3V0IEdvdmVybm9y
cwojCkNPTkZJR19XQVRDSERPR19QUkVUSU1FT1VUX0dPVj15CkNPTkZJR19XQVRDSERPR19Q
UkVUSU1FT1VUX0dPVl9TRUw9bQojIENPTkZJR19XQVRDSERPR19QUkVUSU1FT1VUX0dPVl9O
T09QIGlzIG5vdCBzZXQKQ09ORklHX1dBVENIRE9HX1BSRVRJTUVPVVRfR09WX1BBTklDPXkK
Q09ORklHX1dBVENIRE9HX1BSRVRJTUVPVVRfREVGQVVMVF9HT1ZfUEFOSUM9eQoKIwojIFdh
dGNoZG9nIERldmljZSBEcml2ZXJzCiMKIyBDT05GSUdfU09GVF9XQVRDSERPRyBpcyBub3Qg
c2V0CiMgQ09ORklHX0RBOTA1Ml9XQVRDSERPRyBpcyBub3Qgc2V0CiMgQ09ORklHX0RBOTA1
NV9XQVRDSERPRyBpcyBub3Qgc2V0CiMgQ09ORklHX1dEQVRfV0RUIGlzIG5vdCBzZXQKIyBD
T05GSUdfV004MzFYX1dBVENIRE9HIGlzIG5vdCBzZXQKIyBDT05GSUdfV004MzUwX1dBVENI
RE9HIGlzIG5vdCBzZXQKIyBDT05GSUdfWElMSU5YX1dBVENIRE9HIGlzIG5vdCBzZXQKIyBD
T05GSUdfWklJUkFWRV9XQVRDSERPRyBpcyBub3Qgc2V0CiMgQ09ORklHX01MWF9XRFQgaXMg
bm90IHNldAojIENPTkZJR19DQURFTkNFX1dBVENIRE9HIGlzIG5vdCBzZXQKIyBDT05GSUdf
RFdfV0FUQ0hET0cgaXMgbm90IHNldAojIENPTkZJR19UV0w0MDMwX1dBVENIRE9HIGlzIG5v
dCBzZXQKIyBDT05GSUdfTUFYNjNYWF9XQVRDSERPRyBpcyBub3Qgc2V0CiMgQ09ORklHX0FD
UVVJUkVfV0RUIGlzIG5vdCBzZXQKIyBDT05GSUdfQURWQU5URUNIX1dEVCBpcyBub3Qgc2V0
CiMgQ09ORklHX0FEVkFOVEVDSF9FQ19XRFQgaXMgbm90IHNldAojIENPTkZJR19BTElNMTUz
NV9XRFQgaXMgbm90IHNldAojIENPTkZJR19BTElNNzEwMV9XRFQgaXMgbm90IHNldAojIENP
TkZJR19FQkNfQzM4NF9XRFQgaXMgbm90IHNldAojIENPTkZJR19FWEFSX1dEVCBpcyBub3Qg
c2V0CiMgQ09ORklHX0Y3MTgwOEVfV0RUIGlzIG5vdCBzZXQKIyBDT05GSUdfU1A1MTAwX1RD
TyBpcyBub3Qgc2V0CiMgQ09ORklHX1NCQ19GSVRQQzJfV0FUQ0hET0cgaXMgbm90IHNldAoj
IENPTkZJR19FVVJPVEVDSF9XRFQgaXMgbm90IHNldAojIENPTkZJR19JQjcwMF9XRFQgaXMg
bm90IHNldAojIENPTkZJR19JQk1BU1IgaXMgbm90IHNldAojIENPTkZJR19XQUZFUl9XRFQg
aXMgbm90IHNldAojIENPTkZJR19JNjMwMEVTQl9XRFQgaXMgbm90IHNldAojIENPTkZJR19J
RTZYWF9XRFQgaXMgbm90IHNldApDT05GSUdfSVRDT19XRFQ9bQpDT05GSUdfSVRDT19WRU5E
T1JfU1VQUE9SVD15CiMgQ09ORklHX0lUODcxMkZfV0RUIGlzIG5vdCBzZXQKIyBDT05GSUdf
SVQ4N19XRFQgaXMgbm90IHNldAojIENPTkZJR19IUF9XQVRDSERPRyBpcyBub3Qgc2V0CiMg
Q09ORklHX1NDMTIwMF9XRFQgaXMgbm90IHNldAojIENPTkZJR19QQzg3NDEzX1dEVCBpcyBu
b3Qgc2V0CiMgQ09ORklHX05WX1RDTyBpcyBub3Qgc2V0CiMgQ09ORklHXzYwWFhfV0RUIGlz
IG5vdCBzZXQKIyBDT05GSUdfQ1BVNV9XRFQgaXMgbm90IHNldAojIENPTkZJR19TTVNDX1ND
SDMxMVhfV0RUIGlzIG5vdCBzZXQKIyBDT05GSUdfU01TQzM3Qjc4N19XRFQgaXMgbm90IHNl
dAojIENPTkZJR19UUU1YODZfV0RUIGlzIG5vdCBzZXQKIyBDT05GSUdfVklBX1dEVCBpcyBu
b3Qgc2V0CiMgQ09ORklHX1c4MzYyN0hGX1dEVCBpcyBub3Qgc2V0CiMgQ09ORklHX1c4Mzg3
N0ZfV0RUIGlzIG5vdCBzZXQKIyBDT05GSUdfVzgzOTc3Rl9XRFQgaXMgbm90IHNldAojIENP
TkZJR19NQUNIWl9XRFQgaXMgbm90IHNldAojIENPTkZJR19TQkNfRVBYX0MzX1dBVENIRE9H
IGlzIG5vdCBzZXQKIyBDT05GSUdfTkk5MDNYX1dEVCBpcyBub3Qgc2V0CiMgQ09ORklHX05J
QzcwMThfV0RUIGlzIG5vdCBzZXQKIyBDT05GSUdfTUVOX0EyMV9XRFQgaXMgbm90IHNldAoj
IENPTkZJR19YRU5fV0RUIGlzIG5vdCBzZXQKCiMKIyBQQ0ktYmFzZWQgV2F0Y2hkb2cgQ2Fy
ZHMKIwojIENPTkZJR19QQ0lQQ1dBVENIRE9HIGlzIG5vdCBzZXQKIyBDT05GSUdfV0RUUENJ
IGlzIG5vdCBzZXQKCiMKIyBVU0ItYmFzZWQgV2F0Y2hkb2cgQ2FyZHMKIwojIENPTkZJR19V
U0JQQ1dBVENIRE9HIGlzIG5vdCBzZXQKQ09ORklHX1NTQl9QT1NTSUJMRT15CiMgQ09ORklH
X1NTQiBpcyBub3Qgc2V0CkNPTkZJR19CQ01BX1BPU1NJQkxFPXkKIyBDT05GSUdfQkNNQSBp
cyBub3Qgc2V0CgojCiMgTXVsdGlmdW5jdGlvbiBkZXZpY2UgZHJpdmVycwojCkNPTkZJR19N
RkRfQ09SRT15CkNPTkZJR19NRkRfQVMzNzExPXkKIyBDT05GSUdfTUZEX1NNUFJPIGlzIG5v
dCBzZXQKQ09ORklHX1BNSUNfQURQNTUyMD15CkNPTkZJR19NRkRfQUFUMjg3MF9DT1JFPXkK
IyBDT05GSUdfTUZEX0JDTTU5MFhYIGlzIG5vdCBzZXQKIyBDT05GSUdfTUZEX0JEOTU3MU1X
ViBpcyBub3Qgc2V0CiMgQ09ORklHX01GRF9BWFAyMFhfSTJDIGlzIG5vdCBzZXQKIyBDT05G
SUdfTUZEX0NTNDJMNDNfSTJDIGlzIG5vdCBzZXQKIyBDT05GSUdfTUZEX01BREVSQSBpcyBu
b3Qgc2V0CkNPTkZJR19QTUlDX0RBOTAzWD15CkNPTkZJR19QTUlDX0RBOTA1Mj15CkNPTkZJ
R19NRkRfREE5MDUyX1NQST15CkNPTkZJR19NRkRfREE5MDUyX0kyQz15CkNPTkZJR19NRkRf
REE5MDU1PXkKIyBDT05GSUdfTUZEX0RBOTA2MiBpcyBub3Qgc2V0CiMgQ09ORklHX01GRF9E
QTkwNjMgaXMgbm90IHNldAojIENPTkZJR19NRkRfREE5MTUwIGlzIG5vdCBzZXQKIyBDT05G
SUdfTUZEX0RMTjIgaXMgbm90IHNldAojIENPTkZJR19NRkRfTUMxM1hYWF9TUEkgaXMgbm90
IHNldAojIENPTkZJR19NRkRfTUMxM1hYWF9JMkMgaXMgbm90IHNldAojIENPTkZJR19NRkRf
TVAyNjI5IGlzIG5vdCBzZXQKIyBDT05GSUdfTUZEX0lOVEVMX1FVQVJLX0kyQ19HUElPIGlz
IG5vdCBzZXQKQ09ORklHX0xQQ19JQ0g9bQojIENPTkZJR19MUENfU0NIIGlzIG5vdCBzZXQK
Q09ORklHX0lOVEVMX1NPQ19QTUlDPXkKIyBDT05GSUdfSU5URUxfU09DX1BNSUNfQlhUV0Mg
aXMgbm90IHNldApDT05GSUdfSU5URUxfU09DX1BNSUNfQ0hUV0M9eQojIENPTkZJR19JTlRF
TF9TT0NfUE1JQ19DSFREQ19USSBpcyBub3Qgc2V0CiMgQ09ORklHX0lOVEVMX1NPQ19QTUlD
X01SRkxEIGlzIG5vdCBzZXQKIyBDT05GSUdfTUZEX0lOVEVMX0xQU1NfQUNQSSBpcyBub3Qg
c2V0CiMgQ09ORklHX01GRF9JTlRFTF9MUFNTX1BDSSBpcyBub3Qgc2V0CkNPTkZJR19NRkRf
SU5URUxfUE1DX0JYVD1tCiMgQ09ORklHX01GRF9JUVM2MlggaXMgbm90IHNldAojIENPTkZJ
R19NRkRfSkFOWl9DTU9ESU8gaXMgbm90IHNldAojIENPTkZJR19NRkRfS0VNUExEIGlzIG5v
dCBzZXQKIyBDT05GSUdfTUZEXzg4UE04MDAgaXMgbm90IHNldAojIENPTkZJR19NRkRfODhQ
TTgwNSBpcyBub3Qgc2V0CkNPTkZJR19NRkRfODhQTTg2MFg9eQojIENPTkZJR19NRkRfTUFY
MTQ1NzcgaXMgbm90IHNldAojIENPTkZJR19NRkRfTUFYNzc1NDEgaXMgbm90IHNldAojIENP
TkZJR19NRkRfTUFYNzc2OTMgaXMgbm90IHNldApDT05GSUdfTUZEX01BWDc3ODQzPXkKIyBD
T05GSUdfTUZEX01BWDg5MDcgaXMgbm90IHNldApDT05GSUdfTUZEX01BWDg5MjU9eQpDT05G
SUdfTUZEX01BWDg5OTc9eQpDT05GSUdfTUZEX01BWDg5OTg9eQojIENPTkZJR19NRkRfTVQ2
MzYwIGlzIG5vdCBzZXQKIyBDT05GSUdfTUZEX01UNjM3MCBpcyBub3Qgc2V0CiMgQ09ORklH
X01GRF9NVDYzOTcgaXMgbm90IHNldAojIENPTkZJR19NRkRfTUVORjIxQk1DIGlzIG5vdCBz
ZXQKIyBDT05GSUdfTUZEX09DRUxPVCBpcyBub3Qgc2V0CkNPTkZJR19FWlhfUENBUD15CiMg
Q09ORklHX01GRF9WSVBFUkJPQVJEIGlzIG5vdCBzZXQKIyBDT05GSUdfTUZEX1JFVFUgaXMg
bm90IHNldAojIENPTkZJR19NRkRfUENGNTA2MzMgaXMgbm90IHNldAojIENPTkZJR19NRkRf
U1k3NjM2QSBpcyBub3Qgc2V0CiMgQ09ORklHX01GRF9SREMzMjFYIGlzIG5vdCBzZXQKIyBD
T05GSUdfTUZEX1JUNDgzMSBpcyBub3Qgc2V0CiMgQ09ORklHX01GRF9SVDUwMzMgaXMgbm90
IHNldAojIENPTkZJR19NRkRfUlQ1MTIwIGlzIG5vdCBzZXQKQ09ORklHX01GRF9SQzVUNTgz
PXkKIyBDT05GSUdfTUZEX1NJNDc2WF9DT1JFIGlzIG5vdCBzZXQKIyBDT05GSUdfTUZEX1NN
NTAxIGlzIG5vdCBzZXQKIyBDT05GSUdfTUZEX1NLWTgxNDUyIGlzIG5vdCBzZXQKQ09ORklH
X01GRF9TWVNDT049eQojIENPTkZJR19NRkRfTFAzOTQzIGlzIG5vdCBzZXQKQ09ORklHX01G
RF9MUDg3ODg9eQojIENPTkZJR19NRkRfVElfTE1VIGlzIG5vdCBzZXQKQ09ORklHX01GRF9Q
QUxNQVM9eQojIENPTkZJR19UUFM2MTA1WCBpcyBub3Qgc2V0CiMgQ09ORklHX1RQUzY1MDEw
IGlzIG5vdCBzZXQKIyBDT05GSUdfVFBTNjUwN1ggaXMgbm90IHNldAojIENPTkZJR19NRkRf
VFBTNjUwODYgaXMgbm90IHNldApDT05GSUdfTUZEX1RQUzY1MDkwPXkKIyBDT05GSUdfTUZE
X1RJX0xQODczWCBpcyBub3Qgc2V0CkNPTkZJR19NRkRfVFBTNjU4Nlg9eQpDT05GSUdfTUZE
X1RQUzY1OTEwPXkKIyBDT05GSUdfTUZEX1RQUzY1OTEyX0kyQyBpcyBub3Qgc2V0CiMgQ09O
RklHX01GRF9UUFM2NTkxMl9TUEkgaXMgbm90IHNldAojIENPTkZJR19NRkRfVFBTNjU5NF9J
MkMgaXMgbm90IHNldAojIENPTkZJR19NRkRfVFBTNjU5NF9TUEkgaXMgbm90IHNldApDT05G
SUdfVFdMNDAzMF9DT1JFPXkKQ09ORklHX01GRF9UV0w0MDMwX0FVRElPPXkKQ09ORklHX1RX
TDYwNDBfQ09SRT15CiMgQ09ORklHX01GRF9XTDEyNzNfQ09SRSBpcyBub3Qgc2V0CiMgQ09O
RklHX01GRF9MTTM1MzMgaXMgbm90IHNldAojIENPTkZJR19NRkRfVFFNWDg2IGlzIG5vdCBz
ZXQKIyBDT05GSUdfTUZEX1ZYODU1IGlzIG5vdCBzZXQKIyBDT05GSUdfTUZEX0FSSVpPTkFf
STJDIGlzIG5vdCBzZXQKIyBDT05GSUdfTUZEX0FSSVpPTkFfU1BJIGlzIG5vdCBzZXQKQ09O
RklHX01GRF9XTTg0MDA9eQpDT05GSUdfTUZEX1dNODMxWD15CkNPTkZJR19NRkRfV004MzFY
X0kyQz15CkNPTkZJR19NRkRfV004MzFYX1NQST15CkNPTkZJR19NRkRfV004MzUwPXkKQ09O
RklHX01GRF9XTTgzNTBfSTJDPXkKIyBDT05GSUdfTUZEX1dNODk5NCBpcyBub3Qgc2V0CiMg
Q09ORklHX01GRF9BVEMyNjBYX0kyQyBpcyBub3Qgc2V0CiMgQ09ORklHX1JBVkVfU1BfQ09S
RSBpcyBub3Qgc2V0CiMgQ09ORklHX01GRF9JTlRFTF9NMTBfQk1DX1NQSSBpcyBub3Qgc2V0
CiMgZW5kIG9mIE11bHRpZnVuY3Rpb24gZGV2aWNlIGRyaXZlcnMKCkNPTkZJR19SRUdVTEFU
T1I9eQojIENPTkZJR19SRUdVTEFUT1JfREVCVUcgaXMgbm90IHNldAojIENPTkZJR19SRUdV
TEFUT1JfRklYRURfVk9MVEFHRSBpcyBub3Qgc2V0CiMgQ09ORklHX1JFR1VMQVRPUl9WSVJU
VUFMX0NPTlNVTUVSIGlzIG5vdCBzZXQKIyBDT05GSUdfUkVHVUxBVE9SX1VTRVJTUEFDRV9D
T05TVU1FUiBpcyBub3Qgc2V0CiMgQ09ORklHX1JFR1VMQVRPUl9ORVRMSU5LX0VWRU5UUyBp
cyBub3Qgc2V0CiMgQ09ORklHX1JFR1VMQVRPUl84OFBHODZYIGlzIG5vdCBzZXQKIyBDT05G
SUdfUkVHVUxBVE9SXzg4UE04NjA3IGlzIG5vdCBzZXQKIyBDT05GSUdfUkVHVUxBVE9SX0FD
VDg4NjUgaXMgbm90IHNldAojIENPTkZJR19SRUdVTEFUT1JfQUQ1Mzk4IGlzIG5vdCBzZXQK
IyBDT05GSUdfUkVHVUxBVE9SX0FBVDI4NzAgaXMgbm90IHNldAojIENPTkZJR19SRUdVTEFU
T1JfQVMzNzExIGlzIG5vdCBzZXQKIyBDT05GSUdfUkVHVUxBVE9SX0FXMzc1MDMgaXMgbm90
IHNldAojIENPTkZJR19SRUdVTEFUT1JfREE5MDNYIGlzIG5vdCBzZXQKIyBDT05GSUdfUkVH
VUxBVE9SX0RBOTA1MiBpcyBub3Qgc2V0CiMgQ09ORklHX1JFR1VMQVRPUl9EQTkwNTUgaXMg
bm90IHNldAojIENPTkZJR19SRUdVTEFUT1JfREE5MjEwIGlzIG5vdCBzZXQKIyBDT05GSUdf
UkVHVUxBVE9SX0RBOTIxMSBpcyBub3Qgc2V0CiMgQ09ORklHX1JFR1VMQVRPUl9GQU41MzU1
NSBpcyBub3Qgc2V0CiMgQ09ORklHX1JFR1VMQVRPUl9HUElPIGlzIG5vdCBzZXQKIyBDT05G
SUdfUkVHVUxBVE9SX0lTTDkzMDUgaXMgbm90IHNldAojIENPTkZJR19SRUdVTEFUT1JfSVNM
NjI3MUEgaXMgbm90IHNldAojIENPTkZJR19SRUdVTEFUT1JfTFAzOTcxIGlzIG5vdCBzZXQK
IyBDT05GSUdfUkVHVUxBVE9SX0xQMzk3MiBpcyBub3Qgc2V0CiMgQ09ORklHX1JFR1VMQVRP
Ul9MUDg3MlggaXMgbm90IHNldAojIENPTkZJR19SRUdVTEFUT1JfTFA4NzU1IGlzIG5vdCBz
ZXQKIyBDT05GSUdfUkVHVUxBVE9SX0xQODc4OCBpcyBub3Qgc2V0CiMgQ09ORklHX1JFR1VM
QVRPUl9MVEMzNTg5IGlzIG5vdCBzZXQKIyBDT05GSUdfUkVHVUxBVE9SX0xUQzM2NzYgaXMg
bm90IHNldAojIENPTkZJR19SRUdVTEFUT1JfTUFYMTU4NiBpcyBub3Qgc2V0CiMgQ09ORklH
X1JFR1VMQVRPUl9NQVg3NzUwMyBpcyBub3Qgc2V0CiMgQ09ORklHX1JFR1VMQVRPUl9NQVg3
Nzg1NyBpcyBub3Qgc2V0CiMgQ09ORklHX1JFR1VMQVRPUl9NQVg4NjQ5IGlzIG5vdCBzZXQK
IyBDT05GSUdfUkVHVUxBVE9SX01BWDg2NjAgaXMgbm90IHNldAojIENPTkZJR19SRUdVTEFU
T1JfTUFYODg5MyBpcyBub3Qgc2V0CiMgQ09ORklHX1JFR1VMQVRPUl9NQVg4OTI1IGlzIG5v
dCBzZXQKIyBDT05GSUdfUkVHVUxBVE9SX01BWDg5NTIgaXMgbm90IHNldAojIENPTkZJR19S
RUdVTEFUT1JfTUFYODk5NyBpcyBub3Qgc2V0CiMgQ09ORklHX1JFR1VMQVRPUl9NQVg4OTk4
IGlzIG5vdCBzZXQKIyBDT05GSUdfUkVHVUxBVE9SX01BWDIwMDg2IGlzIG5vdCBzZXQKIyBD
T05GSUdfUkVHVUxBVE9SX01BWDIwNDExIGlzIG5vdCBzZXQKIyBDT05GSUdfUkVHVUxBVE9S
X01BWDc3NjkzIGlzIG5vdCBzZXQKIyBDT05GSUdfUkVHVUxBVE9SX01BWDc3ODI2IGlzIG5v
dCBzZXQKIyBDT05GSUdfUkVHVUxBVE9SX01QODg1OSBpcyBub3Qgc2V0CiMgQ09ORklHX1JF
R1VMQVRPUl9NVDYzMTEgaXMgbm90IHNldAojIENPTkZJR19SRUdVTEFUT1JfUEFMTUFTIGlz
IG5vdCBzZXQKIyBDT05GSUdfUkVHVUxBVE9SX1BDQTk0NTAgaXMgbm90IHNldAojIENPTkZJ
R19SRUdVTEFUT1JfUENBUCBpcyBub3Qgc2V0CiMgQ09ORklHX1JFR1VMQVRPUl9QVjg4MDYw
IGlzIG5vdCBzZXQKIyBDT05GSUdfUkVHVUxBVE9SX1BWODgwODAgaXMgbm90IHNldAojIENP
TkZJR19SRUdVTEFUT1JfUFY4ODA5MCBpcyBub3Qgc2V0CiMgQ09ORklHX1JFR1VMQVRPUl9Q
V00gaXMgbm90IHNldAojIENPTkZJR19SRUdVTEFUT1JfUkFBMjE1MzAwIGlzIG5vdCBzZXQK
IyBDT05GSUdfUkVHVUxBVE9SX1JDNVQ1ODMgaXMgbm90IHNldAojIENPTkZJR19SRUdVTEFU
T1JfUlQ0ODAxIGlzIG5vdCBzZXQKIyBDT05GSUdfUkVHVUxBVE9SX1JUNDgwMyBpcyBub3Qg
c2V0CiMgQ09ORklHX1JFR1VMQVRPUl9SVDUxOTBBIGlzIG5vdCBzZXQKIyBDT05GSUdfUkVH
VUxBVE9SX1JUNTczOSBpcyBub3Qgc2V0CiMgQ09ORklHX1JFR1VMQVRPUl9SVDU3NTkgaXMg
bm90IHNldAojIENPTkZJR19SRUdVTEFUT1JfUlQ2MTYwIGlzIG5vdCBzZXQKIyBDT05GSUdf
UkVHVUxBVE9SX1JUNjE5MCBpcyBub3Qgc2V0CiMgQ09ORklHX1JFR1VMQVRPUl9SVDYyNDUg
aXMgbm90IHNldAojIENPTkZJR19SRUdVTEFUT1JfUlRRMjEzNCBpcyBub3Qgc2V0CiMgQ09O
RklHX1JFR1VMQVRPUl9SVE1WMjAgaXMgbm90IHNldAojIENPTkZJR19SRUdVTEFUT1JfUlRR
Njc1MiBpcyBub3Qgc2V0CiMgQ09ORklHX1JFR1VMQVRPUl9SVFEyMjA4IGlzIG5vdCBzZXQK
IyBDT05GSUdfUkVHVUxBVE9SX1NMRzUxMDAwIGlzIG5vdCBzZXQKIyBDT05GSUdfUkVHVUxB
VE9SX1RQUzUxNjMyIGlzIG5vdCBzZXQKIyBDT05GSUdfUkVHVUxBVE9SX1RQUzYyMzYwIGlz
IG5vdCBzZXQKIyBDT05GSUdfUkVHVUxBVE9SX1RQUzY1MDIzIGlzIG5vdCBzZXQKIyBDT05G
SUdfUkVHVUxBVE9SX1RQUzY1MDdYIGlzIG5vdCBzZXQKIyBDT05GSUdfUkVHVUxBVE9SX1RQ
UzY1MDkwIGlzIG5vdCBzZXQKIyBDT05GSUdfUkVHVUxBVE9SX1RQUzY1MTMyIGlzIG5vdCBz
ZXQKIyBDT05GSUdfUkVHVUxBVE9SX1RQUzY1MjRYIGlzIG5vdCBzZXQKIyBDT05GSUdfUkVH
VUxBVE9SX1RQUzY1ODZYIGlzIG5vdCBzZXQKIyBDT05GSUdfUkVHVUxBVE9SX1RQUzY1OTEw
IGlzIG5vdCBzZXQKIyBDT05GSUdfUkVHVUxBVE9SX1RXTDQwMzAgaXMgbm90IHNldAojIENP
TkZJR19SRUdVTEFUT1JfV004MzFYIGlzIG5vdCBzZXQKIyBDT05GSUdfUkVHVUxBVE9SX1dN
ODM1MCBpcyBub3Qgc2V0CiMgQ09ORklHX1JFR1VMQVRPUl9XTTg0MDAgaXMgbm90IHNldAoj
IENPTkZJR19SQ19DT1JFIGlzIG5vdCBzZXQKCiMKIyBDRUMgc3VwcG9ydAojCkNPTkZJR19N
RURJQV9DRUNfU1VQUE9SVD15CiMgQ09ORklHX0NFQ19DSDczMjIgaXMgbm90IHNldAojIENP
TkZJR19DRUNfR1BJTyBpcyBub3Qgc2V0CiMgQ09ORklHX0NFQ19TRUNPIGlzIG5vdCBzZXQK
IyBDT05GSUdfVVNCX1BVTFNFOF9DRUMgaXMgbm90IHNldAojIENPTkZJR19VU0JfUkFJTlNI
QURPV19DRUMgaXMgbm90IHNldAojIGVuZCBvZiBDRUMgc3VwcG9ydAoKIyBDT05GSUdfTUVE
SUFfU1VQUE9SVCBpcyBub3Qgc2V0CgojCiMgR3JhcGhpY3Mgc3VwcG9ydAojCkNPTkZJR19B
UEVSVFVSRV9IRUxQRVJTPXkKQ09ORklHX1ZJREVPX0NNRExJTkU9eQpDT05GSUdfVklERU9f
Tk9NT0RFU0VUPXkKIyBDT05GSUdfQVVYRElTUExBWSBpcyBub3Qgc2V0CkNPTkZJR19BR1A9
eQojIENPTkZJR19BR1BfQU1ENjQgaXMgbm90IHNldApDT05GSUdfQUdQX0lOVEVMPW0KIyBD
T05GSUdfQUdQX1NJUyBpcyBub3Qgc2V0CiMgQ09ORklHX0FHUF9WSUEgaXMgbm90IHNldApD
T05GSUdfSU5URUxfR1RUPW0KQ09ORklHX1ZHQV9TV0lUQ0hFUk9PPXkKQ09ORklHX0RSTT15
CiMgQ09ORklHX0RSTV9ERUJVR19NTSBpcyBub3Qgc2V0CkNPTkZJR19EUk1fS01TX0hFTFBF
Uj15CkNPTkZJR19EUk1fRkJERVZfRU1VTEFUSU9OPXkKQ09ORklHX0RSTV9GQkRFVl9PVkVS
QUxMT0M9MTAwCkNPTkZJR19EUk1fTE9BRF9FRElEX0ZJUk1XQVJFPXkKQ09ORklHX0RSTV9H
RU1fU0hNRU1fSEVMUEVSPXkKCiMKIyBJMkMgZW5jb2RlciBvciBoZWxwZXIgY2hpcHMKIwoj
IENPTkZJR19EUk1fSTJDX0NINzAwNiBpcyBub3Qgc2V0CiMgQ09ORklHX0RSTV9JMkNfU0lM
MTY0IGlzIG5vdCBzZXQKIyBDT05GSUdfRFJNX0kyQ19OWFBfVERBOTk4WCBpcyBub3Qgc2V0
CiMgQ09ORklHX0RSTV9JMkNfTlhQX1REQTk5NTAgaXMgbm90IHNldAojIGVuZCBvZiBJMkMg
ZW5jb2RlciBvciBoZWxwZXIgY2hpcHMKCiMKIyBBUk0gZGV2aWNlcwojCiMgZW5kIG9mIEFS
TSBkZXZpY2VzCgojIENPTkZJR19EUk1fUkFERU9OIGlzIG5vdCBzZXQKIyBDT05GSUdfRFJN
X0FNREdQVSBpcyBub3Qgc2V0CiMgQ09ORklHX0RSTV9OT1VWRUFVIGlzIG5vdCBzZXQKIyBD
T05GSUdfRFJNX0k5MTUgaXMgbm90IHNldAojIENPTkZJR19EUk1fWEUgaXMgbm90IHNldAoj
IENPTkZJR19EUk1fVkdFTSBpcyBub3Qgc2V0CiMgQ09ORklHX0RSTV9WS01TIGlzIG5vdCBz
ZXQKIyBDT05GSUdfRFJNX1ZNV0dGWCBpcyBub3Qgc2V0CiMgQ09ORklHX0RSTV9HTUE1MDAg
aXMgbm90IHNldAojIENPTkZJR19EUk1fVURMIGlzIG5vdCBzZXQKIyBDT05GSUdfRFJNX0FT
VCBpcyBub3Qgc2V0CiMgQ09ORklHX0RSTV9NR0FHMjAwIGlzIG5vdCBzZXQKIyBDT05GSUdf
RFJNX1FYTCBpcyBub3Qgc2V0CiMgQ09ORklHX0RSTV9WSVJUSU9fR1BVIGlzIG5vdCBzZXQK
Q09ORklHX0RSTV9QQU5FTD15CgojCiMgRGlzcGxheSBQYW5lbHMKIwojIENPTkZJR19EUk1f
UEFORUxfQVVPX0EwMzBKVE4wMSBpcyBub3Qgc2V0CiMgQ09ORklHX0RSTV9QQU5FTF9PUklT
RVRFQ0hfT1RBNTYwMUEgaXMgbm90IHNldAojIENPTkZJR19EUk1fUEFORUxfV0lERUNISVBT
X1dTMjQwMSBpcyBub3Qgc2V0CiMgZW5kIG9mIERpc3BsYXkgUGFuZWxzCgpDT05GSUdfRFJN
X0JSSURHRT15CkNPTkZJR19EUk1fUEFORUxfQlJJREdFPXkKCiMKIyBEaXNwbGF5IEludGVy
ZmFjZSBCcmlkZ2VzCiMKIyBDT05GSUdfRFJNX0FOQUxPR0lYX0FOWDc4WFggaXMgbm90IHNl
dAojIGVuZCBvZiBEaXNwbGF5IEludGVyZmFjZSBCcmlkZ2VzCgojIENPTkZJR19EUk1fRVRO
QVZJViBpcyBub3Qgc2V0CiMgQ09ORklHX0RSTV9CT0NIUyBpcyBub3Qgc2V0CiMgQ09ORklH
X0RSTV9DSVJSVVNfUUVNVSBpcyBub3Qgc2V0CiMgQ09ORklHX0RSTV9HTTEyVTMyMCBpcyBu
b3Qgc2V0CiMgQ09ORklHX0RSTV9QQU5FTF9NSVBJX0RCSSBpcyBub3Qgc2V0CkNPTkZJR19E
Uk1fU0lNUExFRFJNPXkKIyBDT05GSUdfVElOWURSTV9IWDgzNTdEIGlzIG5vdCBzZXQKIyBD
T05GSUdfVElOWURSTV9JTEk5MTYzIGlzIG5vdCBzZXQKIyBDT05GSUdfVElOWURSTV9JTEk5
MjI1IGlzIG5vdCBzZXQKIyBDT05GSUdfVElOWURSTV9JTEk5MzQxIGlzIG5vdCBzZXQKIyBD
T05GSUdfVElOWURSTV9JTEk5NDg2IGlzIG5vdCBzZXQKIyBDT05GSUdfVElOWURSTV9NSTAy
ODNRVCBpcyBub3Qgc2V0CiMgQ09ORklHX1RJTllEUk1fUkVQQVBFUiBpcyBub3Qgc2V0CiMg
Q09ORklHX1RJTllEUk1fU1Q3NTg2IGlzIG5vdCBzZXQKIyBDT05GSUdfVElOWURSTV9TVDc3
MzVSIGlzIG5vdCBzZXQKIyBDT05GSUdfRFJNX1hFTl9GUk9OVEVORCBpcyBub3Qgc2V0CiMg
Q09ORklHX0RSTV9WQk9YVklERU8gaXMgbm90IHNldAojIENPTkZJR19EUk1fR1VEIGlzIG5v
dCBzZXQKIyBDT05GSUdfRFJNX1NTRDEzMFggaXMgbm90IHNldApDT05GSUdfRFJNX1BBTkVM
X09SSUVOVEFUSU9OX1FVSVJLUz15CgojCiMgRnJhbWUgYnVmZmVyIERldmljZXMKIwpDT05G
SUdfRkI9eQojIENPTkZJR19GQl9DSVJSVVMgaXMgbm90IHNldAojIENPTkZJR19GQl9QTTIg
aXMgbm90IHNldAojIENPTkZJR19GQl9DWUJFUjIwMDAgaXMgbm90IHNldAojIENPTkZJR19G
Ql9BUkMgaXMgbm90IHNldAojIENPTkZJR19GQl9BU0lMSUFOVCBpcyBub3Qgc2V0CiMgQ09O
RklHX0ZCX0lNU1RUIGlzIG5vdCBzZXQKIyBDT05GSUdfRkJfVkdBMTYgaXMgbm90IHNldAoj
IENPTkZJR19GQl9VVkVTQSBpcyBub3Qgc2V0CkNPTkZJR19GQl9WRVNBPXkKQ09ORklHX0ZC
X0VGST15CiMgQ09ORklHX0ZCX040MTEgaXMgbm90IHNldAojIENPTkZJR19GQl9IR0EgaXMg
bm90IHNldAojIENPTkZJR19GQl9PUEVOQ09SRVMgaXMgbm90IHNldAojIENPTkZJR19GQl9T
MUQxM1hYWCBpcyBub3Qgc2V0CiMgQ09ORklHX0ZCX05WSURJQSBpcyBub3Qgc2V0CiMgQ09O
RklHX0ZCX1JJVkEgaXMgbm90IHNldAojIENPTkZJR19GQl9JNzQwIGlzIG5vdCBzZXQKIyBD
T05GSUdfRkJfTUFUUk9YIGlzIG5vdCBzZXQKIyBDT05GSUdfRkJfUkFERU9OIGlzIG5vdCBz
ZXQKIyBDT05GSUdfRkJfQVRZMTI4IGlzIG5vdCBzZXQKIyBDT05GSUdfRkJfQVRZIGlzIG5v
dCBzZXQKIyBDT05GSUdfRkJfUzMgaXMgbm90IHNldAojIENPTkZJR19GQl9TQVZBR0UgaXMg
bm90IHNldAojIENPTkZJR19GQl9TSVMgaXMgbm90IHNldAojIENPTkZJR19GQl9WSUEgaXMg
bm90IHNldAojIENPTkZJR19GQl9ORU9NQUdJQyBpcyBub3Qgc2V0CiMgQ09ORklHX0ZCX0tZ
Uk8gaXMgbm90IHNldAojIENPTkZJR19GQl8zREZYIGlzIG5vdCBzZXQKIyBDT05GSUdfRkJf
Vk9PRE9PMSBpcyBub3Qgc2V0CiMgQ09ORklHX0ZCX1ZUODYyMyBpcyBub3Qgc2V0CiMgQ09O
RklHX0ZCX1RSSURFTlQgaXMgbm90IHNldAojIENPTkZJR19GQl9BUksgaXMgbm90IHNldAoj
IENPTkZJR19GQl9QTTMgaXMgbm90IHNldAojIENPTkZJR19GQl9DQVJNSU5FIGlzIG5vdCBz
ZXQKIyBDT05GSUdfRkJfU01TQ1VGWCBpcyBub3Qgc2V0CiMgQ09ORklHX0ZCX1VETCBpcyBu
b3Qgc2V0CiMgQ09ORklHX0ZCX0lCTV9HWFQ0NTAwIGlzIG5vdCBzZXQKIyBDT05GSUdfRkJf
VklSVFVBTCBpcyBub3Qgc2V0CiMgQ09ORklHX1hFTl9GQkRFVl9GUk9OVEVORCBpcyBub3Qg
c2V0CiMgQ09ORklHX0ZCX01FVFJPTk9NRSBpcyBub3Qgc2V0CiMgQ09ORklHX0ZCX01CODYy
WFggaXMgbm90IHNldAojIENPTkZJR19GQl9TU0QxMzA3IGlzIG5vdCBzZXQKIyBDT05GSUdf
RkJfU003MTIgaXMgbm90IHNldApDT05GSUdfRkJfQ09SRT15CkNPTkZJR19GQl9OT1RJRlk9
eQojIENPTkZJR19GSVJNV0FSRV9FRElEIGlzIG5vdCBzZXQKQ09ORklHX0ZCX0RFVklDRT15
CkNPTkZJR19GQl9DRkJfRklMTFJFQ1Q9eQpDT05GSUdfRkJfQ0ZCX0NPUFlBUkVBPXkKQ09O
RklHX0ZCX0NGQl9JTUFHRUJMSVQ9eQpDT05GSUdfRkJfU1lTX0ZJTExSRUNUPXkKQ09ORklH
X0ZCX1NZU19DT1BZQVJFQT15CkNPTkZJR19GQl9TWVNfSU1BR0VCTElUPXkKIyBDT05GSUdf
RkJfRk9SRUlHTl9FTkRJQU4gaXMgbm90IHNldApDT05GSUdfRkJfU1lTTUVNX0ZPUFM9eQpD
T05GSUdfRkJfREVGRVJSRURfSU89eQpDT05GSUdfRkJfSU9NRU1fRk9QUz15CkNPTkZJR19G
Ql9JT01FTV9IRUxQRVJTPXkKQ09ORklHX0ZCX1NZU01FTV9IRUxQRVJTPXkKQ09ORklHX0ZC
X1NZU01FTV9IRUxQRVJTX0RFRkVSUkVEPXkKIyBDT05GSUdfRkJfTU9ERV9IRUxQRVJTIGlz
IG5vdCBzZXQKIyBDT05GSUdfRkJfVElMRUJMSVRUSU5HIGlzIG5vdCBzZXQKIyBlbmQgb2Yg
RnJhbWUgYnVmZmVyIERldmljZXMKCiMKIyBCYWNrbGlnaHQgJiBMQ0QgZGV2aWNlIHN1cHBv
cnQKIwojIENPTkZJR19MQ0RfQ0xBU1NfREVWSUNFIGlzIG5vdCBzZXQKQ09ORklHX0JBQ0tM
SUdIVF9DTEFTU19ERVZJQ0U9eQojIENPTkZJR19CQUNLTElHSFRfS1REMjUzIGlzIG5vdCBz
ZXQKIyBDT05GSUdfQkFDS0xJR0hUX0tUWjg4NjYgaXMgbm90IHNldAojIENPTkZJR19CQUNL
TElHSFRfUFdNIGlzIG5vdCBzZXQKIyBDT05GSUdfQkFDS0xJR0hUX0RBOTAzWCBpcyBub3Qg
c2V0CiMgQ09ORklHX0JBQ0tMSUdIVF9EQTkwNTIgaXMgbm90IHNldAojIENPTkZJR19CQUNL
TElHSFRfTUFYODkyNSBpcyBub3Qgc2V0CiMgQ09ORklHX0JBQ0tMSUdIVF9BUFBMRSBpcyBu
b3Qgc2V0CiMgQ09ORklHX0JBQ0tMSUdIVF9RQ09NX1dMRUQgaXMgbm90IHNldAojIENPTkZJ
R19CQUNLTElHSFRfU0FIQVJBIGlzIG5vdCBzZXQKIyBDT05GSUdfQkFDS0xJR0hUX1dNODMx
WCBpcyBub3Qgc2V0CiMgQ09ORklHX0JBQ0tMSUdIVF9BRFA1NTIwIGlzIG5vdCBzZXQKIyBD
T05GSUdfQkFDS0xJR0hUX0FEUDg4NjAgaXMgbm90IHNldAojIENPTkZJR19CQUNLTElHSFRf
QURQODg3MCBpcyBub3Qgc2V0CiMgQ09ORklHX0JBQ0tMSUdIVF84OFBNODYwWCBpcyBub3Qg
c2V0CiMgQ09ORklHX0JBQ0tMSUdIVF9BQVQyODcwIGlzIG5vdCBzZXQKIyBDT05GSUdfQkFD
S0xJR0hUX0xNMzYzMEEgaXMgbm90IHNldAojIENPTkZJR19CQUNLTElHSFRfTE0zNjM5IGlz
IG5vdCBzZXQKIyBDT05GSUdfQkFDS0xJR0hUX0xQODU1WCBpcyBub3Qgc2V0CiMgQ09ORklH
X0JBQ0tMSUdIVF9MUDg3ODggaXMgbm90IHNldAojIENPTkZJR19CQUNLTElHSFRfTVAzMzA5
QyBpcyBub3Qgc2V0CiMgQ09ORklHX0JBQ0tMSUdIVF9QQU5ET1JBIGlzIG5vdCBzZXQKIyBD
T05GSUdfQkFDS0xJR0hUX0FTMzcxMSBpcyBub3Qgc2V0CiMgQ09ORklHX0JBQ0tMSUdIVF9H
UElPIGlzIG5vdCBzZXQKIyBDT05GSUdfQkFDS0xJR0hUX0xWNTIwN0xQIGlzIG5vdCBzZXQK
IyBDT05GSUdfQkFDS0xJR0hUX0JENjEwNyBpcyBub3Qgc2V0CiMgQ09ORklHX0JBQ0tMSUdI
VF9BUkNYQ05OIGlzIG5vdCBzZXQKIyBlbmQgb2YgQmFja2xpZ2h0ICYgTENEIGRldmljZSBz
dXBwb3J0CgpDT05GSUdfSERNST15CgojCiMgQ29uc29sZSBkaXNwbGF5IGRyaXZlciBzdXBw
b3J0CiMKQ09ORklHX1ZHQV9DT05TT0xFPXkKQ09ORklHX0RVTU1ZX0NPTlNPTEU9eQpDT05G
SUdfRFVNTVlfQ09OU09MRV9DT0xVTU5TPTgwCkNPTkZJR19EVU1NWV9DT05TT0xFX1JPV1M9
MjUKQ09ORklHX0ZSQU1FQlVGRkVSX0NPTlNPTEU9eQojIENPTkZJR19GUkFNRUJVRkZFUl9D
T05TT0xFX0xFR0FDWV9BQ0NFTEVSQVRJT04gaXMgbm90IHNldApDT05GSUdfRlJBTUVCVUZG
RVJfQ09OU09MRV9ERVRFQ1RfUFJJTUFSWT15CkNPTkZJR19GUkFNRUJVRkZFUl9DT05TT0xF
X1JPVEFUSU9OPXkKQ09ORklHX0ZSQU1FQlVGRkVSX0NPTlNPTEVfREVGRVJSRURfVEFLRU9W
RVI9eQojIGVuZCBvZiBDb25zb2xlIGRpc3BsYXkgZHJpdmVyIHN1cHBvcnQKCiMgQ09ORklH
X0xPR08gaXMgbm90IHNldAojIGVuZCBvZiBHcmFwaGljcyBzdXBwb3J0CgpDT05GSUdfRFJN
X0FDQ0VMPXkKIyBDT05GSUdfRFJNX0FDQ0VMX0hBQkFOQUxBQlMgaXMgbm90IHNldAojIENP
TkZJR19EUk1fQUNDRUxfSVZQVSBpcyBub3Qgc2V0CiMgQ09ORklHX1NPVU5EIGlzIG5vdCBz
ZXQKQ09ORklHX0hJRF9TVVBQT1JUPXkKQ09ORklHX0hJRD15CkNPTkZJR19ISURfQkFUVEVS
WV9TVFJFTkdUSD15CkNPTkZJR19ISURSQVc9eQojIENPTkZJR19VSElEIGlzIG5vdCBzZXQK
Q09ORklHX0hJRF9HRU5FUklDPXkKCiMKIyBTcGVjaWFsIEhJRCBkcml2ZXJzCiMKIyBDT05G
SUdfSElEX0E0VEVDSCBpcyBub3Qgc2V0CiMgQ09ORklHX0hJRF9BQ1JVWCBpcyBub3Qgc2V0
CiMgQ09ORklHX0hJRF9BUFBMRSBpcyBub3Qgc2V0CiMgQ09ORklHX0hJRF9BVVJFQUwgaXMg
bm90IHNldAojIENPTkZJR19ISURfQkVMS0lOIGlzIG5vdCBzZXQKIyBDT05GSUdfSElEX0NI
RVJSWSBpcyBub3Qgc2V0CiMgQ09ORklHX0hJRF9DT1VHQVIgaXMgbm90IHNldAojIENPTkZJ
R19ISURfTUFDQUxMWSBpcyBub3Qgc2V0CiMgQ09ORklHX0hJRF9DTUVESUEgaXMgbm90IHNl
dAojIENPTkZJR19ISURfQ1lQUkVTUyBpcyBub3Qgc2V0CiMgQ09ORklHX0hJRF9EUkFHT05S
SVNFIGlzIG5vdCBzZXQKIyBDT05GSUdfSElEX0VNU19GRiBpcyBub3Qgc2V0CiMgQ09ORklH
X0hJRF9FTEVDT00gaXMgbm90IHNldAojIENPTkZJR19ISURfRVZJU0lPTiBpcyBub3Qgc2V0
CiMgQ09ORklHX0hJRF9FWktFWSBpcyBub3Qgc2V0CiMgQ09ORklHX0hJRF9HRU1CSVJEIGlz
IG5vdCBzZXQKIyBDT05GSUdfSElEX0dGUk0gaXMgbm90IHNldAojIENPTkZJR19ISURfR0xP
UklPVVMgaXMgbm90IHNldAojIENPTkZJR19ISURfR09PR0xFX1NUQURJQV9GRiBpcyBub3Qg
c2V0CiMgQ09ORklHX0hJRF9WSVZBTERJIGlzIG5vdCBzZXQKIyBDT05GSUdfSElEX0tFWVRP
VUNIIGlzIG5vdCBzZXQKIyBDT05GSUdfSElEX0tZRSBpcyBub3Qgc2V0CiMgQ09ORklHX0hJ
RF9XQUxUT1AgaXMgbm90IHNldAojIENPTkZJR19ISURfVklFV1NPTklDIGlzIG5vdCBzZXQK
IyBDT05GSUdfSElEX1ZSQzIgaXMgbm90IHNldAojIENPTkZJR19ISURfWElBT01JIGlzIG5v
dCBzZXQKIyBDT05GSUdfSElEX0dZUkFUSU9OIGlzIG5vdCBzZXQKIyBDT05GSUdfSElEX0lD
QURFIGlzIG5vdCBzZXQKIyBDT05GSUdfSElEX0lURSBpcyBub3Qgc2V0CiMgQ09ORklHX0hJ
RF9KQUJSQSBpcyBub3Qgc2V0CiMgQ09ORklHX0hJRF9UV0lOSEFOIGlzIG5vdCBzZXQKIyBD
T05GSUdfSElEX0tFTlNJTkdUT04gaXMgbm90IHNldAojIENPTkZJR19ISURfTENQT1dFUiBp
cyBub3Qgc2V0CiMgQ09ORklHX0hJRF9MRUQgaXMgbm90IHNldAojIENPTkZJR19ISURfTEVO
T1ZPIGlzIG5vdCBzZXQKIyBDT05GSUdfSElEX01BR0lDTU9VU0UgaXMgbm90IHNldAojIENP
TkZJR19ISURfTUFMVFJPTiBpcyBub3Qgc2V0CiMgQ09ORklHX0hJRF9NQVlGTEFTSCBpcyBu
b3Qgc2V0CiMgQ09ORklHX0hJRF9SRURSQUdPTiBpcyBub3Qgc2V0CiMgQ09ORklHX0hJRF9N
SUNST1NPRlQgaXMgbm90IHNldAojIENPTkZJR19ISURfTU9OVEVSRVkgaXMgbm90IHNldAoj
IENPTkZJR19ISURfTVVMVElUT1VDSCBpcyBub3Qgc2V0CiMgQ09ORklHX0hJRF9OSU5URU5E
TyBpcyBub3Qgc2V0CiMgQ09ORklHX0hJRF9OVEkgaXMgbm90IHNldAojIENPTkZJR19ISURf
T1JURUsgaXMgbm90IHNldAojIENPTkZJR19ISURfUEFOVEhFUkxPUkQgaXMgbm90IHNldAoj
IENPTkZJR19ISURfUEVUQUxZTlggaXMgbm90IHNldAojIENPTkZJR19ISURfUElDT0xDRCBp
cyBub3Qgc2V0CiMgQ09ORklHX0hJRF9QTEFOVFJPTklDUyBpcyBub3Qgc2V0CiMgQ09ORklH
X0hJRF9QWFJDIGlzIG5vdCBzZXQKIyBDT05GSUdfSElEX1JBWkVSIGlzIG5vdCBzZXQKIyBD
T05GSUdfSElEX1BSSU1BWCBpcyBub3Qgc2V0CiMgQ09ORklHX0hJRF9TQUlURUsgaXMgbm90
IHNldAojIENPTkZJR19ISURfU0VNSVRFSyBpcyBub3Qgc2V0CiMgQ09ORklHX0hJRF9TUEVF
RExJTksgaXMgbm90IHNldAojIENPTkZJR19ISURfU1RFQU0gaXMgbm90IHNldAojIENPTkZJ
R19ISURfU1VOUExVUyBpcyBub3Qgc2V0CiMgQ09ORklHX0hJRF9STUkgaXMgbm90IHNldAoj
IENPTkZJR19ISURfR1JFRU5BU0lBIGlzIG5vdCBzZXQKIyBDT05GSUdfSElEX1NNQVJUSk9Z
UExVUyBpcyBub3Qgc2V0CiMgQ09ORklHX0hJRF9USVZPIGlzIG5vdCBzZXQKIyBDT05GSUdf
SElEX1RPUFNFRUQgaXMgbm90IHNldAojIENPTkZJR19ISURfVE9QUkUgaXMgbm90IHNldAoj
IENPTkZJR19ISURfVEhJTkdNIGlzIG5vdCBzZXQKIyBDT05GSUdfSElEX1VEUkFXX1BTMyBp
cyBub3Qgc2V0CiMgQ09ORklHX0hJRF9XSUlNT1RFIGlzIG5vdCBzZXQKIyBDT05GSUdfSElE
X1hJTk1PIGlzIG5vdCBzZXQKIyBDT05GSUdfSElEX1pFUk9QTFVTIGlzIG5vdCBzZXQKIyBD
T05GSUdfSElEX1pZREFDUk9OIGlzIG5vdCBzZXQKIyBDT05GSUdfSElEX1NFTlNPUl9IVUIg
aXMgbm90IHNldAojIENPTkZJR19ISURfQUxQUyBpcyBub3Qgc2V0CiMgZW5kIG9mIFNwZWNp
YWwgSElEIGRyaXZlcnMKCiMKIyBISUQtQlBGIHN1cHBvcnQKIwpDT05GSUdfSElEX0JQRj15
CiMgZW5kIG9mIEhJRC1CUEYgc3VwcG9ydAoKIwojIFVTQiBISUQgc3VwcG9ydAojCiMgQ09O
RklHX1VTQl9ISUQgaXMgbm90IHNldApDT05GSUdfSElEX1BJRD15CiMgZW5kIG9mIFVTQiBI
SUQgc3VwcG9ydAoKIyBDT05GSUdfSTJDX0hJRCBpcyBub3Qgc2V0CgojCiMgSW50ZWwgSVNI
IEhJRCBzdXBwb3J0CiMKIyBDT05GSUdfSU5URUxfSVNIX0hJRCBpcyBub3Qgc2V0CiMgZW5k
IG9mIEludGVsIElTSCBISUQgc3VwcG9ydAoKIwojIEFNRCBTRkggSElEIFN1cHBvcnQKIwoj
IENPTkZJR19BTURfU0ZIX0hJRCBpcyBub3Qgc2V0CiMgZW5kIG9mIEFNRCBTRkggSElEIFN1
cHBvcnQKCkNPTkZJR19VU0JfT0hDSV9MSVRUTEVfRU5ESUFOPXkKQ09ORklHX1VTQl9TVVBQ
T1JUPXkKQ09ORklHX1VTQl9DT01NT049eQpDT05GSUdfVVNCX0xFRF9UUklHPXkKIyBDT05G
SUdfVVNCX1VMUElfQlVTIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX0NPTk5fR1BJTyBpcyBu
b3Qgc2V0CkNPTkZJR19VU0JfQVJDSF9IQVNfSENEPXkKQ09ORklHX1VTQj15CkNPTkZJR19V
U0JfUENJPXkKQ09ORklHX1VTQl9QQ0lfQU1EPXkKQ09ORklHX1VTQl9BTk5PVU5DRV9ORVdf
REVWSUNFUz15CgojCiMgTWlzY2VsbGFuZW91cyBVU0Igb3B0aW9ucwojCkNPTkZJR19VU0Jf
REVGQVVMVF9QRVJTSVNUPXkKIyBDT05GSUdfVVNCX0ZFV19JTklUX1JFVFJJRVMgaXMgbm90
IHNldAojIENPTkZJR19VU0JfRFlOQU1JQ19NSU5PUlMgaXMgbm90IHNldAojIENPTkZJR19V
U0JfT1RHIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX09UR19QUk9EVUNUTElTVCBpcyBub3Qg
c2V0CiMgQ09ORklHX1VTQl9MRURTX1RSSUdHRVJfVVNCUE9SVCBpcyBub3Qgc2V0CkNPTkZJ
R19VU0JfQVVUT1NVU1BFTkRfREVMQVk9MgojIENPTkZJR19VU0JfTU9OIGlzIG5vdCBzZXQK
CiMKIyBVU0IgSG9zdCBDb250cm9sbGVyIERyaXZlcnMKIwojIENPTkZJR19VU0JfQzY3WDAw
X0hDRCBpcyBub3Qgc2V0CkNPTkZJR19VU0JfWEhDSV9IQ0Q9eQojIENPTkZJR19VU0JfWEhD
SV9EQkdDQVAgaXMgbm90IHNldApDT05GSUdfVVNCX1hIQ0lfUENJPXkKIyBDT05GSUdfVVNC
X1hIQ0lfUENJX1JFTkVTQVMgaXMgbm90IHNldAojIENPTkZJR19VU0JfWEhDSV9QTEFURk9S
TSBpcyBub3Qgc2V0CkNPTkZJR19VU0JfRUhDSV9IQ0Q9eQpDT05GSUdfVVNCX0VIQ0lfUk9P
VF9IVUJfVFQ9eQpDT05GSUdfVVNCX0VIQ0lfVFRfTkVXU0NIRUQ9eQpDT05GSUdfVVNCX0VI
Q0lfUENJPXkKIyBDT05GSUdfVVNCX0VIQ0lfRlNMIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNC
X0VIQ0lfSENEX1BMQVRGT1JNIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX09YVTIxMEhQX0hD
RCBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9JU1AxMTZYX0hDRCBpcyBub3Qgc2V0CiMgQ09O
RklHX1VTQl9NQVgzNDIxX0hDRCBpcyBub3Qgc2V0CkNPTkZJR19VU0JfT0hDSV9IQ0Q9eQpD
T05GSUdfVVNCX09IQ0lfSENEX1BDST15CiMgQ09ORklHX1VTQl9PSENJX0hDRF9QTEFURk9S
TSBpcyBub3Qgc2V0CkNPTkZJR19VU0JfVUhDSV9IQ0Q9eQojIENPTkZJR19VU0JfU0w4MTFf
SENEIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1I4QTY2NTk3X0hDRCBpcyBub3Qgc2V0CiMg
Q09ORklHX1VTQl9IQ0RfVEVTVF9NT0RFIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1hFTl9I
Q0QgaXMgbm90IHNldAoKIwojIFVTQiBEZXZpY2UgQ2xhc3MgZHJpdmVycwojCiMgQ09ORklH
X1VTQl9BQ00gaXMgbm90IHNldAojIENPTkZJR19VU0JfUFJJTlRFUiBpcyBub3Qgc2V0CiMg
Q09ORklHX1VTQl9XRE0gaXMgbm90IHNldAojIENPTkZJR19VU0JfVE1DIGlzIG5vdCBzZXQK
CiMKIyBOT1RFOiBVU0JfU1RPUkFHRSBkZXBlbmRzIG9uIFNDU0kgYnV0IEJMS19ERVZfU0Qg
bWF5CiMKCiMKIyBhbHNvIGJlIG5lZWRlZDsgc2VlIFVTQl9TVE9SQUdFIEhlbHAgZm9yIG1v
cmUgaW5mbwojCiMgQ09ORklHX1VTQl9TVE9SQUdFIGlzIG5vdCBzZXQKCiMKIyBVU0IgSW1h
Z2luZyBkZXZpY2VzCiMKIyBDT05GSUdfVVNCX01EQzgwMCBpcyBub3Qgc2V0CiMgQ09ORklH
X1VTQl9NSUNST1RFSyBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQklQX0NPUkUgaXMgbm90IHNl
dAoKIwojIFVTQiBkdWFsLW1vZGUgY29udHJvbGxlciBkcml2ZXJzCiMKIyBDT05GSUdfVVNC
X0NETlNfU1VQUE9SVCBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9NVVNCX0hEUkMgaXMgbm90
IHNldAojIENPTkZJR19VU0JfRFdDMyBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9EV0MyIGlz
IG5vdCBzZXQKIyBDT05GSUdfVVNCX0NISVBJREVBIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNC
X0lTUDE3NjAgaXMgbm90IHNldAoKIwojIFVTQiBwb3J0IGRyaXZlcnMKIwpDT05GSUdfVVNC
X1NFUklBTD15CkNPTkZJR19VU0JfU0VSSUFMX0NPTlNPTEU9eQpDT05GSUdfVVNCX1NFUklB
TF9HRU5FUklDPXkKIyBDT05GSUdfVVNCX1NFUklBTF9TSU1QTEUgaXMgbm90IHNldAojIENP
TkZJR19VU0JfU0VSSUFMX0FJUkNBQkxFIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1NFUklB
TF9BUkszMTE2IGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1NFUklBTF9CRUxLSU4gaXMgbm90
IHNldAojIENPTkZJR19VU0JfU0VSSUFMX0NIMzQxIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNC
X1NFUklBTF9XSElURUhFQVQgaXMgbm90IHNldAojIENPTkZJR19VU0JfU0VSSUFMX0RJR0lf
QUNDRUxFUE9SVCBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9TRVJJQUxfQ1AyMTBYIGlzIG5v
dCBzZXQKIyBDT05GSUdfVVNCX1NFUklBTF9DWVBSRVNTX004IGlzIG5vdCBzZXQKIyBDT05G
SUdfVVNCX1NFUklBTF9FTVBFRyBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9TRVJJQUxfRlRE
SV9TSU8gaXMgbm90IHNldAojIENPTkZJR19VU0JfU0VSSUFMX1ZJU09SIGlzIG5vdCBzZXQK
IyBDT05GSUdfVVNCX1NFUklBTF9JUEFRIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1NFUklB
TF9JUiBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9TRVJJQUxfRURHRVBPUlQgaXMgbm90IHNl
dAojIENPTkZJR19VU0JfU0VSSUFMX0VER0VQT1JUX1RJIGlzIG5vdCBzZXQKIyBDT05GSUdf
VVNCX1NFUklBTF9GODEyMzIgaXMgbm90IHNldAojIENPTkZJR19VU0JfU0VSSUFMX0Y4MTUz
WCBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9TRVJJQUxfR0FSTUlOIGlzIG5vdCBzZXQKIyBD
T05GSUdfVVNCX1NFUklBTF9JUFcgaXMgbm90IHNldAojIENPTkZJR19VU0JfU0VSSUFMX0lV
VSBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9TRVJJQUxfS0VZU1BBTl9QREEgaXMgbm90IHNl
dAojIENPTkZJR19VU0JfU0VSSUFMX0tFWVNQQU4gaXMgbm90IHNldAojIENPTkZJR19VU0Jf
U0VSSUFMX0tMU0kgaXMgbm90IHNldAojIENPTkZJR19VU0JfU0VSSUFMX0tPQklMX1NDVCBp
cyBub3Qgc2V0CiMgQ09ORklHX1VTQl9TRVJJQUxfTUNUX1UyMzIgaXMgbm90IHNldAojIENP
TkZJR19VU0JfU0VSSUFMX01FVFJPIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1NFUklBTF9N
T1M3NzIwIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1NFUklBTF9NT1M3ODQwIGlzIG5vdCBz
ZXQKIyBDT05GSUdfVVNCX1NFUklBTF9NWFVQT1JUIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNC
X1NFUklBTF9OQVZNQU4gaXMgbm90IHNldAojIENPTkZJR19VU0JfU0VSSUFMX1BMMjMwMyBp
cyBub3Qgc2V0CiMgQ09ORklHX1VTQl9TRVJJQUxfT1RJNjg1OCBpcyBub3Qgc2V0CiMgQ09O
RklHX1VTQl9TRVJJQUxfUUNBVVggaXMgbm90IHNldAojIENPTkZJR19VU0JfU0VSSUFMX1FV
QUxDT01NIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1NFUklBTF9TUENQOFg1IGlzIG5vdCBz
ZXQKIyBDT05GSUdfVVNCX1NFUklBTF9TQUZFIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1NF
UklBTF9TSUVSUkFXSVJFTEVTUyBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9TRVJJQUxfU1lN
Qk9MIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1NFUklBTF9USSBpcyBub3Qgc2V0CiMgQ09O
RklHX1VTQl9TRVJJQUxfQ1lCRVJKQUNLIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1NFUklB
TF9PUFRJT04gaXMgbm90IHNldAojIENPTkZJR19VU0JfU0VSSUFMX09NTklORVQgaXMgbm90
IHNldAojIENPTkZJR19VU0JfU0VSSUFMX09QVElDT04gaXMgbm90IHNldAojIENPTkZJR19V
U0JfU0VSSUFMX1hTRU5TX01UIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1NFUklBTF9XSVNI
Qk9ORSBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9TRVJJQUxfU1NVMTAwIGlzIG5vdCBzZXQK
IyBDT05GSUdfVVNCX1NFUklBTF9RVDIgaXMgbm90IHNldAojIENPTkZJR19VU0JfU0VSSUFM
X1VQRDc4RjA3MzAgaXMgbm90IHNldAojIENPTkZJR19VU0JfU0VSSUFMX1hSIGlzIG5vdCBz
ZXQKIyBDT05GSUdfVVNCX1NFUklBTF9ERUJVRyBpcyBub3Qgc2V0CgojCiMgVVNCIE1pc2Nl
bGxhbmVvdXMgZHJpdmVycwojCiMgQ09ORklHX1VTQl9FTUk2MiBpcyBub3Qgc2V0CiMgQ09O
RklHX1VTQl9FTUkyNiBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9BRFVUVVggaXMgbm90IHNl
dAojIENPTkZJR19VU0JfU0VWU0VHIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX0xFR09UT1dF
UiBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9MQ0QgaXMgbm90IHNldAojIENPTkZJR19VU0Jf
Q1lQUkVTU19DWTdDNjMgaXMgbm90IHNldAojIENPTkZJR19VU0JfQ1lUSEVSTSBpcyBub3Qg
c2V0CiMgQ09ORklHX1VTQl9JRE1PVVNFIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX0FQUExF
RElTUExBWSBpcyBub3Qgc2V0CiMgQ09ORklHX0FQUExFX01GSV9GQVNUQ0hBUkdFIGlzIG5v
dCBzZXQKIyBDT05GSUdfVVNCX0xKQ0EgaXMgbm90IHNldAojIENPTkZJR19VU0JfU0lTVVNC
VkdBIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX0xEIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNC
X1RSQU5DRVZJQlJBVE9SIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX0lPV0FSUklPUiBpcyBu
b3Qgc2V0CiMgQ09ORklHX1VTQl9URVNUIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX0VIU0VU
X1RFU1RfRklYVFVSRSBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9JU0lHSFRGVyBpcyBub3Qg
c2V0CiMgQ09ORklHX1VTQl9ZVVJFWCBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9FWlVTQl9G
WDIgaXMgbm90IHNldAojIENPTkZJR19VU0JfSFVCX1VTQjI1MVhCIGlzIG5vdCBzZXQKIyBD
T05GSUdfVVNCX0hTSUNfVVNCMzUwMyBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9IU0lDX1VT
QjQ2MDQgaXMgbm90IHNldAojIENPTkZJR19VU0JfTElOS19MQVlFUl9URVNUIGlzIG5vdCBz
ZXQKIyBDT05GSUdfVVNCX0NIQU9TS0VZIGlzIG5vdCBzZXQKCiMKIyBVU0IgUGh5c2ljYWwg
TGF5ZXIgZHJpdmVycwojCiMgQ09ORklHX05PUF9VU0JfWENFSVYgaXMgbm90IHNldAojIENP
TkZJR19VU0JfR1BJT19WQlVTIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX0lTUDEzMDEgaXMg
bm90IHNldAojIGVuZCBvZiBVU0IgUGh5c2ljYWwgTGF5ZXIgZHJpdmVycwoKIyBDT05GSUdf
VVNCX0dBREdFVCBpcyBub3Qgc2V0CiMgQ09ORklHX1RZUEVDIGlzIG5vdCBzZXQKIyBDT05G
SUdfVVNCX1JPTEVfU1dJVENIIGlzIG5vdCBzZXQKIyBDT05GSUdfTU1DIGlzIG5vdCBzZXQK
IyBDT05GSUdfU0NTSV9VRlNIQ0QgaXMgbm90IHNldAojIENPTkZJR19NRU1TVElDSyBpcyBu
b3Qgc2V0CkNPTkZJR19ORVdfTEVEUz15CkNPTkZJR19MRURTX0NMQVNTPXkKIyBDT05GSUdf
TEVEU19DTEFTU19GTEFTSCBpcyBub3Qgc2V0CiMgQ09ORklHX0xFRFNfQ0xBU1NfTVVMVElD
T0xPUiBpcyBub3Qgc2V0CkNPTkZJR19MRURTX0JSSUdIVE5FU1NfSFdfQ0hBTkdFRD15Cgoj
CiMgTEVEIGRyaXZlcnMKIwojIENPTkZJR19MRURTXzg4UE04NjBYIGlzIG5vdCBzZXQKIyBD
T05GSUdfTEVEU19BUFUgaXMgbm90IHNldAojIENPTkZJR19MRURTX0FXMjAwWFggaXMgbm90
IHNldAojIENPTkZJR19MRURTX0NIVF9XQ09WRSBpcyBub3Qgc2V0CiMgQ09ORklHX0xFRFNf
TE0zNTMwIGlzIG5vdCBzZXQKIyBDT05GSUdfTEVEU19MTTM1MzIgaXMgbm90IHNldAojIENP
TkZJR19MRURTX0xNMzY0MiBpcyBub3Qgc2V0CiMgQ09ORklHX0xFRFNfUENBOTUzMiBpcyBu
b3Qgc2V0CiMgQ09ORklHX0xFRFNfR1BJTyBpcyBub3Qgc2V0CiMgQ09ORklHX0xFRFNfTFAz
OTQ0IGlzIG5vdCBzZXQKIyBDT05GSUdfTEVEU19MUDM5NTIgaXMgbm90IHNldAojIENPTkZJ
R19MRURTX0xQNTBYWCBpcyBub3Qgc2V0CiMgQ09ORklHX0xFRFNfTFA4Nzg4IGlzIG5vdCBz
ZXQKIyBDT05GSUdfTEVEU19QQ0E5NTVYIGlzIG5vdCBzZXQKIyBDT05GSUdfTEVEU19QQ0E5
NjNYIGlzIG5vdCBzZXQKIyBDT05GSUdfTEVEU19QQ0E5OTVYIGlzIG5vdCBzZXQKIyBDT05G
SUdfTEVEU19XTTgzMVhfU1RBVFVTIGlzIG5vdCBzZXQKIyBDT05GSUdfTEVEU19XTTgzNTAg
aXMgbm90IHNldAojIENPTkZJR19MRURTX0RBOTAzWCBpcyBub3Qgc2V0CiMgQ09ORklHX0xF
RFNfREE5MDUyIGlzIG5vdCBzZXQKIyBDT05GSUdfTEVEU19EQUMxMjRTMDg1IGlzIG5vdCBz
ZXQKIyBDT05GSUdfTEVEU19QV00gaXMgbm90IHNldAojIENPTkZJR19MRURTX1JFR1VMQVRP
UiBpcyBub3Qgc2V0CiMgQ09ORklHX0xFRFNfQkQyNjA2TVZWIGlzIG5vdCBzZXQKIyBDT05G
SUdfTEVEU19CRDI4MDIgaXMgbm90IHNldAojIENPTkZJR19MRURTX0lOVEVMX1NTNDIwMCBp
cyBub3Qgc2V0CiMgQ09ORklHX0xFRFNfTFQzNTkzIGlzIG5vdCBzZXQKIyBDT05GSUdfTEVE
U19BRFA1NTIwIGlzIG5vdCBzZXQKIyBDT05GSUdfTEVEU19UQ0E2NTA3IGlzIG5vdCBzZXQK
IyBDT05GSUdfTEVEU19UTEM1OTFYWCBpcyBub3Qgc2V0CiMgQ09ORklHX0xFRFNfTUFYODk5
NyBpcyBub3Qgc2V0CiMgQ09ORklHX0xFRFNfTE0zNTV4IGlzIG5vdCBzZXQKIyBDT05GSUdf
TEVEU19JUzMxRkwzMTlYIGlzIG5vdCBzZXQKCiMKIyBMRUQgZHJpdmVyIGZvciBibGluaygx
KSBVU0IgUkdCIExFRCBpcyB1bmRlciBTcGVjaWFsIEhJRCBkcml2ZXJzIChISURfVEhJTkdN
KQojCiMgQ09ORklHX0xFRFNfQkxJTktNIGlzIG5vdCBzZXQKIyBDT05GSUdfTEVEU19NTFhD
UExEIGlzIG5vdCBzZXQKIyBDT05GSUdfTEVEU19NTFhSRUcgaXMgbm90IHNldAojIENPTkZJ
R19MRURTX1VTRVIgaXMgbm90IHNldAojIENPTkZJR19MRURTX05JQzc4QlggaXMgbm90IHNl
dAoKIwojIEZsYXNoIGFuZCBUb3JjaCBMRUQgZHJpdmVycwojCgojCiMgUkdCIExFRCBkcml2
ZXJzCiMKCiMKIyBMRUQgVHJpZ2dlcnMKIwpDT05GSUdfTEVEU19UUklHR0VSUz15CiMgQ09O
RklHX0xFRFNfVFJJR0dFUl9USU1FUiBpcyBub3Qgc2V0CiMgQ09ORklHX0xFRFNfVFJJR0dF
Ul9PTkVTSE9UIGlzIG5vdCBzZXQKQ09ORklHX0xFRFNfVFJJR0dFUl9ESVNLPXkKIyBDT05G
SUdfTEVEU19UUklHR0VSX0hFQVJUQkVBVCBpcyBub3Qgc2V0CiMgQ09ORklHX0xFRFNfVFJJ
R0dFUl9CQUNLTElHSFQgaXMgbm90IHNldApDT05GSUdfTEVEU19UUklHR0VSX0NQVT15CiMg
Q09ORklHX0xFRFNfVFJJR0dFUl9BQ1RJVklUWSBpcyBub3Qgc2V0CiMgQ09ORklHX0xFRFNf
VFJJR0dFUl9HUElPIGlzIG5vdCBzZXQKIyBDT05GSUdfTEVEU19UUklHR0VSX0RFRkFVTFRf
T04gaXMgbm90IHNldAoKIwojIGlwdGFibGVzIHRyaWdnZXIgaXMgdW5kZXIgTmV0ZmlsdGVy
IGNvbmZpZyAoTEVEIHRhcmdldCkKIwojIENPTkZJR19MRURTX1RSSUdHRVJfVFJBTlNJRU5U
IGlzIG5vdCBzZXQKIyBDT05GSUdfTEVEU19UUklHR0VSX0NBTUVSQSBpcyBub3Qgc2V0CkNP
TkZJR19MRURTX1RSSUdHRVJfUEFOSUM9eQojIENPTkZJR19MRURTX1RSSUdHRVJfTkVUREVW
IGlzIG5vdCBzZXQKIyBDT05GSUdfTEVEU19UUklHR0VSX1BBVFRFUk4gaXMgbm90IHNldAoj
IENPTkZJR19MRURTX1RSSUdHRVJfQVVESU8gaXMgbm90IHNldAojIENPTkZJR19MRURTX1RS
SUdHRVJfVFRZIGlzIG5vdCBzZXQKCiMKIyBTaW1wbGUgTEVEIGRyaXZlcnMKIwpDT05GSUdf
QUNDRVNTSUJJTElUWT15CkNPTkZJR19BMTFZX0JSQUlMTEVfQ09OU09MRT15CgojCiMgU3Bl
YWt1cCBjb25zb2xlIHNwZWVjaAojCiMgQ09ORklHX1NQRUFLVVAgaXMgbm90IHNldAojIGVu
ZCBvZiBTcGVha3VwIGNvbnNvbGUgc3BlZWNoCgojIENPTkZJR19JTkZJTklCQU5EIGlzIG5v
dCBzZXQKQ09ORklHX0VEQUNfQVRPTUlDX1NDUlVCPXkKQ09ORklHX0VEQUNfU1VQUE9SVD15
CkNPTkZJR19FREFDPXkKQ09ORklHX0VEQUNfTEVHQUNZX1NZU0ZTPXkKIyBDT05GSUdfRURB
Q19ERUJVRyBpcyBub3Qgc2V0CiMgQ09ORklHX0VEQUNfREVDT0RFX01DRSBpcyBub3Qgc2V0
CkNPTkZJR19FREFDX0dIRVM9eQojIENPTkZJR19FREFDX0U3NTJYIGlzIG5vdCBzZXQKIyBD
T05GSUdfRURBQ19JODI5NzVYIGlzIG5vdCBzZXQKIyBDT05GSUdfRURBQ19JMzAwMCBpcyBu
b3Qgc2V0CiMgQ09ORklHX0VEQUNfSTMyMDAgaXMgbm90IHNldAojIENPTkZJR19FREFDX0lF
MzEyMDAgaXMgbm90IHNldAojIENPTkZJR19FREFDX1gzOCBpcyBub3Qgc2V0CiMgQ09ORklH
X0VEQUNfSTU0MDAgaXMgbm90IHNldAojIENPTkZJR19FREFDX0k3Q09SRSBpcyBub3Qgc2V0
CiMgQ09ORklHX0VEQUNfSTUxMDAgaXMgbm90IHNldAojIENPTkZJR19FREFDX0k3MzAwIGlz
IG5vdCBzZXQKIyBDT05GSUdfRURBQ19TQlJJREdFIGlzIG5vdCBzZXQKIyBDT05GSUdfRURB
Q19TS1ggaXMgbm90IHNldAojIENPTkZJR19FREFDX0kxME5NIGlzIG5vdCBzZXQKIyBDT05G
SUdfRURBQ19QTkQyIGlzIG5vdCBzZXQKIyBDT05GSUdfRURBQ19JR0VONiBpcyBub3Qgc2V0
CkNPTkZJR19SVENfTElCPXkKQ09ORklHX1JUQ19NQzE0NjgxOF9MSUI9eQpDT05GSUdfUlRD
X0NMQVNTPXkKQ09ORklHX1JUQ19IQ1RPU1lTPXkKQ09ORklHX1JUQ19IQ1RPU1lTX0RFVklD
RT0icnRjMCIKQ09ORklHX1JUQ19TWVNUT0hDPXkKQ09ORklHX1JUQ19TWVNUT0hDX0RFVklD
RT0icnRjMCIKIyBDT05GSUdfUlRDX0RFQlVHIGlzIG5vdCBzZXQKQ09ORklHX1JUQ19OVk1F
TT15CgojCiMgUlRDIGludGVyZmFjZXMKIwpDT05GSUdfUlRDX0lOVEZfU1lTRlM9eQpDT05G
SUdfUlRDX0lOVEZfUFJPQz15CkNPTkZJR19SVENfSU5URl9ERVY9eQpDT05GSUdfUlRDX0lO
VEZfREVWX1VJRV9FTVVMPXkKIyBDT05GSUdfUlRDX0RSVl9URVNUIGlzIG5vdCBzZXQKCiMK
IyBJMkMgUlRDIGRyaXZlcnMKIwojIENPTkZJR19SVENfRFJWXzg4UE04NjBYIGlzIG5vdCBz
ZXQKIyBDT05GSUdfUlRDX0RSVl9BQkI1WkVTMyBpcyBub3Qgc2V0CiMgQ09ORklHX1JUQ19E
UlZfQUJFT1o5IGlzIG5vdCBzZXQKIyBDT05GSUdfUlRDX0RSVl9BQlg4MFggaXMgbm90IHNl
dAojIENPTkZJR19SVENfRFJWX0RTMTMwNyBpcyBub3Qgc2V0CiMgQ09ORklHX1JUQ19EUlZf
RFMxMzc0IGlzIG5vdCBzZXQKIyBDT05GSUdfUlRDX0RSVl9EUzE2NzIgaXMgbm90IHNldAoj
IENPTkZJR19SVENfRFJWX0xQODc4OCBpcyBub3Qgc2V0CiMgQ09ORklHX1JUQ19EUlZfTUFY
NjkwMCBpcyBub3Qgc2V0CiMgQ09ORklHX1JUQ19EUlZfTUFYODkyNSBpcyBub3Qgc2V0CiMg
Q09ORklHX1JUQ19EUlZfTUFYODk5OCBpcyBub3Qgc2V0CiMgQ09ORklHX1JUQ19EUlZfTUFY
ODk5NyBpcyBub3Qgc2V0CiMgQ09ORklHX1JUQ19EUlZfTUFYMzEzMzUgaXMgbm90IHNldAoj
IENPTkZJR19SVENfRFJWX1JTNUMzNzIgaXMgbm90IHNldAojIENPTkZJR19SVENfRFJWX0lT
TDEyMDggaXMgbm90IHNldAojIENPTkZJR19SVENfRFJWX0lTTDEyMDIyIGlzIG5vdCBzZXQK
IyBDT05GSUdfUlRDX0RSVl9YMTIwNSBpcyBub3Qgc2V0CiMgQ09ORklHX1JUQ19EUlZfUENG
ODUyMyBpcyBub3Qgc2V0CiMgQ09ORklHX1JUQ19EUlZfUENGODUwNjMgaXMgbm90IHNldAoj
IENPTkZJR19SVENfRFJWX1BDRjg1MzYzIGlzIG5vdCBzZXQKIyBDT05GSUdfUlRDX0RSVl9Q
Q0Y4NTYzIGlzIG5vdCBzZXQKIyBDT05GSUdfUlRDX0RSVl9QQ0Y4NTgzIGlzIG5vdCBzZXQK
IyBDT05GSUdfUlRDX0RSVl9NNDFUODAgaXMgbm90IHNldAojIENPTkZJR19SVENfRFJWX0JR
MzJLIGlzIG5vdCBzZXQKIyBDT05GSUdfUlRDX0RSVl9QQUxNQVMgaXMgbm90IHNldAojIENP
TkZJR19SVENfRFJWX1RQUzY1ODZYIGlzIG5vdCBzZXQKIyBDT05GSUdfUlRDX0RSVl9UUFM2
NTkxMCBpcyBub3Qgc2V0CiMgQ09ORklHX1JUQ19EUlZfUkM1VDU4MyBpcyBub3Qgc2V0CiMg
Q09ORklHX1JUQ19EUlZfUzM1MzkwQSBpcyBub3Qgc2V0CiMgQ09ORklHX1JUQ19EUlZfRk0z
MTMwIGlzIG5vdCBzZXQKIyBDT05GSUdfUlRDX0RSVl9SWDgwMTAgaXMgbm90IHNldAojIENP
TkZJR19SVENfRFJWX1JYODU4MSBpcyBub3Qgc2V0CiMgQ09ORklHX1JUQ19EUlZfUlg4MDI1
IGlzIG5vdCBzZXQKIyBDT05GSUdfUlRDX0RSVl9FTTMwMjcgaXMgbm90IHNldAojIENPTkZJ
R19SVENfRFJWX1JWMzAyOCBpcyBub3Qgc2V0CiMgQ09ORklHX1JUQ19EUlZfUlYzMDMyIGlz
IG5vdCBzZXQKIyBDT05GSUdfUlRDX0RSVl9SVjg4MDMgaXMgbm90IHNldAojIENPTkZJR19S
VENfRFJWX1NEMzA3OCBpcyBub3Qgc2V0CgojCiMgU1BJIFJUQyBkcml2ZXJzCiMKIyBDT05G
SUdfUlRDX0RSVl9NNDFUOTMgaXMgbm90IHNldAojIENPTkZJR19SVENfRFJWX000MVQ5NCBp
cyBub3Qgc2V0CiMgQ09ORklHX1JUQ19EUlZfRFMxMzAyIGlzIG5vdCBzZXQKIyBDT05GSUdf
UlRDX0RSVl9EUzEzMDUgaXMgbm90IHNldAojIENPTkZJR19SVENfRFJWX0RTMTM0MyBpcyBu
b3Qgc2V0CiMgQ09ORklHX1JUQ19EUlZfRFMxMzQ3IGlzIG5vdCBzZXQKIyBDT05GSUdfUlRD
X0RSVl9EUzEzOTAgaXMgbm90IHNldAojIENPTkZJR19SVENfRFJWX01BWDY5MTYgaXMgbm90
IHNldAojIENPTkZJR19SVENfRFJWX1I5NzAxIGlzIG5vdCBzZXQKIyBDT05GSUdfUlRDX0RS
Vl9SWDQ1ODEgaXMgbm90IHNldAojIENPTkZJR19SVENfRFJWX1JTNUMzNDggaXMgbm90IHNl
dAojIENPTkZJR19SVENfRFJWX01BWDY5MDIgaXMgbm90IHNldAojIENPTkZJR19SVENfRFJW
X1BDRjIxMjMgaXMgbm90IHNldAojIENPTkZJR19SVENfRFJWX01DUDc5NSBpcyBub3Qgc2V0
CkNPTkZJR19SVENfSTJDX0FORF9TUEk9eQoKIwojIFNQSSBhbmQgSTJDIFJUQyBkcml2ZXJz
CiMKIyBDT05GSUdfUlRDX0RSVl9EUzMyMzIgaXMgbm90IHNldAojIENPTkZJR19SVENfRFJW
X1BDRjIxMjcgaXMgbm90IHNldAojIENPTkZJR19SVENfRFJWX1JWMzAyOUMyIGlzIG5vdCBz
ZXQKIyBDT05GSUdfUlRDX0RSVl9SWDYxMTAgaXMgbm90IHNldAoKIwojIFBsYXRmb3JtIFJU
QyBkcml2ZXJzCiMKQ09ORklHX1JUQ19EUlZfQ01PUz15CiMgQ09ORklHX1JUQ19EUlZfRFMx
Mjg2IGlzIG5vdCBzZXQKIyBDT05GSUdfUlRDX0RSVl9EUzE1MTEgaXMgbm90IHNldAojIENP
TkZJR19SVENfRFJWX0RTMTU1MyBpcyBub3Qgc2V0CiMgQ09ORklHX1JUQ19EUlZfRFMxNjg1
X0ZBTUlMWSBpcyBub3Qgc2V0CiMgQ09ORklHX1JUQ19EUlZfRFMxNzQyIGlzIG5vdCBzZXQK
IyBDT05GSUdfUlRDX0RSVl9EUzI0MDQgaXMgbm90IHNldAojIENPTkZJR19SVENfRFJWX0RB
OTA1MiBpcyBub3Qgc2V0CiMgQ09ORklHX1JUQ19EUlZfREE5MDU1IGlzIG5vdCBzZXQKIyBD
T05GSUdfUlRDX0RSVl9TVEsxN1RBOCBpcyBub3Qgc2V0CiMgQ09ORklHX1JUQ19EUlZfTTQ4
VDg2IGlzIG5vdCBzZXQKIyBDT05GSUdfUlRDX0RSVl9NNDhUMzUgaXMgbm90IHNldAojIENP
TkZJR19SVENfRFJWX000OFQ1OSBpcyBub3Qgc2V0CiMgQ09ORklHX1JUQ19EUlZfTVNNNjI0
MiBpcyBub3Qgc2V0CiMgQ09ORklHX1JUQ19EUlZfUlA1QzAxIGlzIG5vdCBzZXQKIyBDT05G
SUdfUlRDX0RSVl9XTTgzMVggaXMgbm90IHNldAojIENPTkZJR19SVENfRFJWX1dNODM1MCBp
cyBub3Qgc2V0CgojCiMgb24tQ1BVIFJUQyBkcml2ZXJzCiMKIyBDT05GSUdfUlRDX0RSVl9G
VFJUQzAxMCBpcyBub3Qgc2V0CiMgQ09ORklHX1JUQ19EUlZfUENBUCBpcyBub3Qgc2V0Cgoj
CiMgSElEIFNlbnNvciBSVEMgZHJpdmVycwojCiMgQ09ORklHX1JUQ19EUlZfR09MREZJU0gg
aXMgbm90IHNldApDT05GSUdfRE1BREVWSUNFUz15CiMgQ09ORklHX0RNQURFVklDRVNfREVC
VUcgaXMgbm90IHNldAoKIwojIERNQSBEZXZpY2VzCiMKQ09ORklHX0RNQV9FTkdJTkU9eQpD
T05GSUdfRE1BX1ZJUlRVQUxfQ0hBTk5FTFM9eQpDT05GSUdfRE1BX0FDUEk9eQojIENPTkZJ
R19BTFRFUkFfTVNHRE1BIGlzIG5vdCBzZXQKIyBDT05GSUdfSU5URUxfSURNQTY0IGlzIG5v
dCBzZXQKIyBDT05GSUdfSU5URUxfSURYRCBpcyBub3Qgc2V0CiMgQ09ORklHX0lOVEVMX0lE
WERfQ09NUEFUIGlzIG5vdCBzZXQKIyBDT05GSUdfSU5URUxfSU9BVERNQSBpcyBub3Qgc2V0
CiMgQ09ORklHX1BMWF9ETUEgaXMgbm90IHNldAojIENPTkZJR19YSUxJTlhfRE1BIGlzIG5v
dCBzZXQKIyBDT05GSUdfWElMSU5YX1hETUEgaXMgbm90IHNldAojIENPTkZJR19BTURfUFRE
TUEgaXMgbm90IHNldAojIENPTkZJR19RQ09NX0hJRE1BX01HTVQgaXMgbm90IHNldAojIENP
TkZJR19RQ09NX0hJRE1BIGlzIG5vdCBzZXQKQ09ORklHX0RXX0RNQUNfQ09SRT15CiMgQ09O
RklHX0RXX0RNQUMgaXMgbm90IHNldApDT05GSUdfRFdfRE1BQ19QQ0k9eQojIENPTkZJR19E
V19FRE1BIGlzIG5vdCBzZXQKQ09ORklHX0hTVV9ETUE9eQojIENPTkZJR19TRl9QRE1BIGlz
IG5vdCBzZXQKQ09ORklHX0lOVEVMX0xETUE9eQoKIwojIERNQSBDbGllbnRzCiMKQ09ORklH
X0FTWU5DX1RYX0RNQT15CiMgQ09ORklHX0RNQVRFU1QgaXMgbm90IHNldAoKIwojIERNQUJV
RiBvcHRpb25zCiMKQ09ORklHX1NZTkNfRklMRT15CiMgQ09ORklHX1NXX1NZTkMgaXMgbm90
IHNldApDT05GSUdfVURNQUJVRj15CiMgQ09ORklHX0RNQUJVRl9NT1ZFX05PVElGWSBpcyBu
b3Qgc2V0CiMgQ09ORklHX0RNQUJVRl9ERUJVRyBpcyBub3Qgc2V0CiMgQ09ORklHX0RNQUJV
Rl9TRUxGVEVTVFMgaXMgbm90IHNldApDT05GSUdfRE1BQlVGX0hFQVBTPXkKQ09ORklHX0RN
QUJVRl9TWVNGU19TVEFUUz15CkNPTkZJR19ETUFCVUZfSEVBUFNfU1lTVEVNPXkKQ09ORklH
X0RNQUJVRl9IRUFQU19DTUE9eQojIGVuZCBvZiBETUFCVUYgb3B0aW9ucwoKIyBDT05GSUdf
VUlPIGlzIG5vdCBzZXQKIyBDT05GSUdfVkZJTyBpcyBub3Qgc2V0CkNPTkZJR19JUlFfQllQ
QVNTX01BTkFHRVI9bQpDT05GSUdfVklSVF9EUklWRVJTPXkKQ09ORklHX1ZNR0VOSUQ9eQoj
IENPTkZJR19WQk9YR1VFU1QgaXMgbm90IHNldAojIENPTkZJR19OSVRST19FTkNMQVZFUyBp
cyBub3Qgc2V0CiMgQ09ORklHX0FDUk5fSFNNIGlzIG5vdCBzZXQKIyBDT05GSUdfRUZJX1NF
Q1JFVCBpcyBub3Qgc2V0CiMgQ09ORklHX1NFVl9HVUVTVCBpcyBub3Qgc2V0CiMgQ09ORklH
X1REWF9HVUVTVF9EUklWRVIgaXMgbm90IHNldApDT05GSUdfVklSVElPX0FOQ0hPUj15CkNP
TkZJR19WSVJUSU89eQpDT05GSUdfVklSVElPX1BDSV9MSUI9bQpDT05GSUdfVklSVElPX1BD
SV9MSUJfTEVHQUNZPW0KQ09ORklHX1ZJUlRJT19NRU5VPXkKQ09ORklHX1ZJUlRJT19QQ0k9
bQpDT05GSUdfVklSVElPX1BDSV9BRE1JTl9MRUdBQ1k9eQpDT05GSUdfVklSVElPX1BDSV9M
RUdBQ1k9eQojIENPTkZJR19WSVJUSU9fUE1FTSBpcyBub3Qgc2V0CkNPTkZJR19WSVJUSU9f
QkFMTE9PTj1tCiMgQ09ORklHX1ZJUlRJT19NRU0gaXMgbm90IHNldAojIENPTkZJR19WSVJU
SU9fSU5QVVQgaXMgbm90IHNldAojIENPTkZJR19WSVJUSU9fTU1JTyBpcyBub3Qgc2V0CiMg
Q09ORklHX1ZEUEEgaXMgbm90IHNldApDT05GSUdfVkhPU1RfTUVOVT15CiMgQ09ORklHX1ZI
T1NUX05FVCBpcyBub3Qgc2V0CiMgQ09ORklHX1ZIT1NUX0NST1NTX0VORElBTl9MRUdBQ1kg
aXMgbm90IHNldAoKIwojIE1pY3Jvc29mdCBIeXBlci1WIGd1ZXN0IHN1cHBvcnQKIwojIENP
TkZJR19IWVBFUlYgaXMgbm90IHNldAojIGVuZCBvZiBNaWNyb3NvZnQgSHlwZXItViBndWVz
dCBzdXBwb3J0CgojCiMgWGVuIGRyaXZlciBzdXBwb3J0CiMKQ09ORklHX1hFTl9CQUxMT09O
PXkKQ09ORklHX1hFTl9CQUxMT09OX01FTU9SWV9IT1RQTFVHPXkKQ09ORklHX1hFTl9NRU1P
UllfSE9UUExVR19MSU1JVD01MTIKQ09ORklHX1hFTl9TQ1JVQl9QQUdFU19ERUZBVUxUPXkK
IyBDT05GSUdfWEVOX0RFVl9FVlRDSE4gaXMgbm90IHNldApDT05GSUdfWEVOX0JBQ0tFTkQ9
eQojIENPTkZJR19YRU5GUyBpcyBub3Qgc2V0CkNPTkZJR19YRU5fU1lTX0hZUEVSVklTT1I9
eQpDT05GSUdfWEVOX1hFTkJVU19GUk9OVEVORD15CiMgQ09ORklHX1hFTl9HTlRERVYgaXMg
bm90IHNldAojIENPTkZJR19YRU5fR1JBTlRfREVWX0FMTE9DIGlzIG5vdCBzZXQKQ09ORklH
X1hFTl9HUkFOVF9ETUFfQUxMT0M9eQpDT05GSUdfU1dJT1RMQl9YRU49eQojIENPTkZJR19Y
RU5fUENJREVWX0JBQ0tFTkQgaXMgbm90IHNldAojIENPTkZJR19YRU5fUFZDQUxMU19GUk9O
VEVORCBpcyBub3Qgc2V0CkNPTkZJR19YRU5fUFZDQUxMU19CQUNLRU5EPXkKIyBDT05GSUdf
WEVOX1BSSVZDTUQgaXMgbm90IHNldAojIENPTkZJR19YRU5fQUNQSV9QUk9DRVNTT1IgaXMg
bm90IHNldApDT05GSUdfWEVOX01DRV9MT0c9eQpDT05GSUdfWEVOX0hBVkVfUFZNTVU9eQpD
T05GSUdfWEVOX0VGST15CkNPTkZJR19YRU5fQVVUT19YTEFURT15CkNPTkZJR19YRU5fQUNQ
ST15CkNPTkZJR19YRU5fSEFWRV9WUE1VPXkKQ09ORklHX1hFTl9VTlBPUFVMQVRFRF9BTExP
Qz15CkNPTkZJR19YRU5fR1JBTlRfRE1BX09QUz15CkNPTkZJR19YRU5fVklSVElPPXkKIyBD
T05GSUdfWEVOX1ZJUlRJT19GT1JDRV9HUkFOVCBpcyBub3Qgc2V0CiMgZW5kIG9mIFhlbiBk
cml2ZXIgc3VwcG9ydAoKIyBDT05GSUdfR1JFWUJVUyBpcyBub3Qgc2V0CiMgQ09ORklHX0NP
TUVESSBpcyBub3Qgc2V0CkNPTkZJR19TVEFHSU5HPXkKIyBDT05GSUdfUFJJU00yX1VTQiBp
cyBub3Qgc2V0CiMgQ09ORklHX1JUTExJQiBpcyBub3Qgc2V0CiMgQ09ORklHX1I4NzEyVSBp
cyBub3Qgc2V0CiMgQ09ORklHX1JUUzUyMDggaXMgbm90IHNldAojIENPTkZJR19GQl9TTTc1
MCBpcyBub3Qgc2V0CkNPTkZJR19TVEFHSU5HX01FRElBPXkKIyBDT05GSUdfTFRFX0dETTcy
NFggaXMgbm90IHNldAojIENPTkZJR19GQl9URlQgaXMgbm90IHNldAojIENPTkZJR19QSTQz
MyBpcyBub3Qgc2V0CiMgQ09ORklHX0ZJRUxEQlVTX0RFViBpcyBub3Qgc2V0CiMgQ09ORklH
X1ZNRV9CVVMgaXMgbm90IHNldApDT05GSUdfQ0hST01FX1BMQVRGT1JNUz15CiMgQ09ORklH
X0NIUk9NRU9TX0FDUEkgaXMgbm90IHNldAojIENPTkZJR19DSFJPTUVPU19MQVBUT1AgaXMg
bm90IHNldAojIENPTkZJR19DSFJPTUVPU19QU1RPUkUgaXMgbm90IHNldAojIENPTkZJR19D
SFJPTUVPU19UQk1DIGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JPU19FQyBpcyBub3Qgc2V0CiMg
Q09ORklHX0NST1NfS0JEX0xFRF9CQUNLTElHSFQgaXMgbm90IHNldAojIENPTkZJR19DUk9T
X0hQU19JMkMgaXMgbm90IHNldAojIENPTkZJR19DSFJPTUVPU19QUklWQUNZX1NDUkVFTiBp
cyBub3Qgc2V0CkNPTkZJR19NRUxMQU5PWF9QTEFURk9STT15CiMgQ09ORklHX01MWFJFR19I
T1RQTFVHIGlzIG5vdCBzZXQKIyBDT05GSUdfTUxYUkVHX0lPIGlzIG5vdCBzZXQKIyBDT05G
SUdfTUxYUkVHX0xDIGlzIG5vdCBzZXQKIyBDT05GSUdfTlZTV19TTjIyMDEgaXMgbm90IHNl
dApDT05GSUdfU1VSRkFDRV9QTEFURk9STVM9eQojIENPTkZJR19TVVJGQUNFXzNfUE9XRVJf
T1BSRUdJT04gaXMgbm90IHNldAojIENPTkZJR19TVVJGQUNFX0dQRSBpcyBub3Qgc2V0CiMg
Q09ORklHX1NVUkZBQ0VfSE9UUExVRyBpcyBub3Qgc2V0CiMgQ09ORklHX1NVUkZBQ0VfUFJP
M19CVVRUT04gaXMgbm90IHNldAojIENPTkZJR19TVVJGQUNFX0FHR1JFR0FUT1IgaXMgbm90
IHNldApDT05GSUdfWDg2X1BMQVRGT1JNX0RFVklDRVM9eQojIENPTkZJR19BQ1BJX1dNSSBp
cyBub3Qgc2V0CiMgQ09ORklHX0FDRVJIREYgaXMgbm90IHNldAojIENPTkZJR19BQ0VSX1dJ
UkVMRVNTIGlzIG5vdCBzZXQKIyBDT05GSUdfQU1EX1BNQyBpcyBub3Qgc2V0CiMgQ09ORklH
X0FNRF9IU01QIGlzIG5vdCBzZXQKIyBDT05GSUdfQU1EX1dCUkYgaXMgbm90IHNldAojIENP
TkZJR19BRFZfU1dCVVRUT04gaXMgbm90IHNldAojIENPTkZJR19BUFBMRV9HTVVYIGlzIG5v
dCBzZXQKIyBDT05GSUdfQVNVU19MQVBUT1AgaXMgbm90IHNldAojIENPTkZJR19BU1VTX1dJ
UkVMRVNTIGlzIG5vdCBzZXQKIyBDT05GSUdfQVNVU19URjEwM0NfRE9DSyBpcyBub3Qgc2V0
CiMgQ09ORklHX0VFRVBDX0xBUFRPUCBpcyBub3Qgc2V0CkNPTkZJR19YODZfUExBVEZPUk1f
RFJJVkVSU19ERUxMPXkKIyBDT05GSUdfRENEQkFTIGlzIG5vdCBzZXQKIyBDT05GSUdfREVM
TF9SQlUgaXMgbm90IHNldAojIENPTkZJR19ERUxMX1JCVE4gaXMgbm90IHNldAojIENPTkZJ
R19ERUxMX1NNQklPUyBpcyBub3Qgc2V0CiMgQ09ORklHX0RFTExfU01PODgwMCBpcyBub3Qg
c2V0CiMgQ09ORklHX0FNSUxPX1JGS0lMTCBpcyBub3Qgc2V0CiMgQ09ORklHX0ZVSklUU1Vf
TEFQVE9QIGlzIG5vdCBzZXQKIyBDT05GSUdfRlVKSVRTVV9UQUJMRVQgaXMgbm90IHNldAoj
IENPTkZJR19HUERfUE9DS0VUX0ZBTiBpcyBub3Qgc2V0CkNPTkZJR19YODZfUExBVEZPUk1f
RFJJVkVSU19IUD15CiMgQ09ORklHX0hQX0FDQ0VMIGlzIG5vdCBzZXQKIyBDT05GSUdfV0lS
RUxFU1NfSE9US0VZIGlzIG5vdCBzZXQKIyBDT05GSUdfSUJNX1JUTCBpcyBub3Qgc2V0CiMg
Q09ORklHX0lERUFQQURfTEFQVE9QIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19IREFQ
UyBpcyBub3Qgc2V0CiMgQ09ORklHX0lOVEVMX0FUT01JU1AyX1BNIGlzIG5vdCBzZXQKIyBD
T05GSUdfSU5URUxfSUZTIGlzIG5vdCBzZXQKIyBDT05GSUdfSU5URUxfU0FSX0lOVDEwOTIg
aXMgbm90IHNldAojIENPTkZJR19JTlRFTF9TS0xfSU5UMzQ3MiBpcyBub3Qgc2V0CkNPTkZJ
R19JTlRFTF9QTUNfQ09SRT1tCkNPTkZJR19JTlRFTF9QTVRfQ0xBU1M9bQpDT05GSUdfSU5U
RUxfUE1UX1RFTEVNRVRSWT1tCiMgQ09ORklHX0lOVEVMX1BNVF9DUkFTSExPRyBpcyBub3Qg
c2V0CgojCiMgSW50ZWwgU3BlZWQgU2VsZWN0IFRlY2hub2xvZ3kgaW50ZXJmYWNlIHN1cHBv
cnQKIwojIENPTkZJR19JTlRFTF9TUEVFRF9TRUxFQ1RfSU5URVJGQUNFIGlzIG5vdCBzZXQK
IyBlbmQgb2YgSW50ZWwgU3BlZWQgU2VsZWN0IFRlY2hub2xvZ3kgaW50ZXJmYWNlIHN1cHBv
cnQKCiMKIyBJbnRlbCBVbmNvcmUgRnJlcXVlbmN5IENvbnRyb2wKIwpDT05GSUdfSU5URUxf
VU5DT1JFX0ZSRVFfQ09OVFJPTD1tCiMgZW5kIG9mIEludGVsIFVuY29yZSBGcmVxdWVuY3kg
Q29udHJvbAoKIyBDT05GSUdfSU5URUxfSElEX0VWRU5UIGlzIG5vdCBzZXQKIyBDT05GSUdf
SU5URUxfVkJUTiBpcyBub3Qgc2V0CiMgQ09ORklHX0lOVEVMX0lOVDAwMDJfVkdQSU8gaXMg
bm90IHNldAojIENPTkZJR19JTlRFTF9PQUtUUkFJTCBpcyBub3Qgc2V0CiMgQ09ORklHX0lO
VEVMX0JZVENSQ19QV1JTUkMgaXMgbm90IHNldAojIENPTkZJR19JTlRFTF9QVU5JVF9JUEMg
aXMgbm90IHNldAojIENPTkZJR19JTlRFTF9SU1QgaXMgbm90IHNldAojIENPTkZJR19JTlRF
TF9TRFNJIGlzIG5vdCBzZXQKIyBDT05GSUdfSU5URUxfU01BUlRDT05ORUNUIGlzIG5vdCBz
ZXQKIyBDT05GSUdfSU5URUxfVFBNSSBpcyBub3Qgc2V0CkNPTkZJR19JTlRFTF9UVVJCT19N
QVhfMz15CkNPTkZJR19JTlRFTF9WU0VDPW0KIyBDT05GSUdfTVNJX0xBUFRPUCBpcyBub3Qg
c2V0CiMgQ09ORklHX1BDRU5HSU5FU19BUFUyIGlzIG5vdCBzZXQKIyBDT05GSUdfQkFSQ09f
UDUwX0dQSU8gaXMgbm90IHNldAojIENPTkZJR19TQU1TVU5HX0xBUFRPUCBpcyBub3Qgc2V0
CiMgQ09ORklHX1NBTVNVTkdfUTEwIGlzIG5vdCBzZXQKIyBDT05GSUdfVE9TSElCQV9CVF9S
RktJTEwgaXMgbm90IHNldAojIENPTkZJR19UT1NISUJBX0hBUFMgaXMgbm90IHNldAojIENP
TkZJR19BQ1BJX0NNUEMgaXMgbm90IHNldAojIENPTkZJR19DT01QQUxfTEFQVE9QIGlzIG5v
dCBzZXQKIyBDT05GSUdfUEFOQVNPTklDX0xBUFRPUCBpcyBub3Qgc2V0CiMgQ09ORklHX1NP
TllfTEFQVE9QIGlzIG5vdCBzZXQKIyBDT05GSUdfVE9QU1RBUl9MQVBUT1AgaXMgbm90IHNl
dAojIENPTkZJR19TRVJJQUxfTVVMVElfSU5TVEFOVElBVEUgaXMgbm90IHNldAojIENPTkZJ
R19NTFhfUExBVEZPUk0gaXMgbm90IHNldAojIENPTkZJR19YODZfQU5EUk9JRF9UQUJMRVRT
IGlzIG5vdCBzZXQKIyBDT05GSUdfSU5URUxfSVBTIGlzIG5vdCBzZXQKQ09ORklHX0lOVEVM
X1NDVV9JUEM9eQpDT05GSUdfSU5URUxfU0NVPXkKQ09ORklHX0lOVEVMX1NDVV9QQ0k9eQoj
IENPTkZJR19JTlRFTF9TQ1VfUExBVEZPUk0gaXMgbm90IHNldAojIENPTkZJR19JTlRFTF9T
Q1VfSVBDX1VUSUwgaXMgbm90IHNldAojIENPTkZJR19TSUVNRU5TX1NJTUFUSUNfSVBDIGlz
IG5vdCBzZXQKIyBDT05GSUdfV0lOTUFURV9GTTA3X0tFWVMgaXMgbm90IHNldAojIENPTkZJ
R19TRUwzMzUwX1BMQVRGT1JNIGlzIG5vdCBzZXQKQ09ORklHX1AyU0I9eQpDT05GSUdfSEFW
RV9DTEs9eQpDT05GSUdfSEFWRV9DTEtfUFJFUEFSRT15CkNPTkZJR19DT01NT05fQ0xLPXkK
IyBDT05GSUdfQ09NTU9OX0NMS19XTTgzMVggaXMgbm90IHNldAojIENPTkZJR19MTUswNDgz
MiBpcyBub3Qgc2V0CiMgQ09ORklHX0NPTU1PTl9DTEtfTUFYOTQ4NSBpcyBub3Qgc2V0CiMg
Q09ORklHX0NPTU1PTl9DTEtfU0k1MzQxIGlzIG5vdCBzZXQKIyBDT05GSUdfQ09NTU9OX0NM
S19TSTUzNTEgaXMgbm90IHNldAojIENPTkZJR19DT01NT05fQ0xLX1NJNTQ0IGlzIG5vdCBz
ZXQKIyBDT05GSUdfQ09NTU9OX0NMS19DRENFNzA2IGlzIG5vdCBzZXQKIyBDT05GSUdfQ09N
TU9OX0NMS19DUzIwMDBfQ1AgaXMgbm90IHNldAojIENPTkZJR19DTEtfVFdMIGlzIG5vdCBz
ZXQKIyBDT05GSUdfQ0xLX1RXTDYwNDAgaXMgbm90IHNldAojIENPTkZJR19DT01NT05fQ0xL
X1BBTE1BUyBpcyBub3Qgc2V0CiMgQ09ORklHX0NPTU1PTl9DTEtfUFdNIGlzIG5vdCBzZXQK
IyBDT05GSUdfWElMSU5YX1ZDVSBpcyBub3Qgc2V0CkNPTkZJR19IV1NQSU5MT0NLPXkKCiMK
IyBDbG9jayBTb3VyY2UgZHJpdmVycwojCkNPTkZJR19DTEtFVlRfSTgyNTM9eQpDT05GSUdf
STgyNTNfTE9DSz15CkNPTkZJR19DTEtCTERfSTgyNTM9eQojIGVuZCBvZiBDbG9jayBTb3Vy
Y2UgZHJpdmVycwoKQ09ORklHX01BSUxCT1g9eQpDT05GSUdfUENDPXkKIyBDT05GSUdfQUxU
RVJBX01CT1ggaXMgbm90IHNldApDT05GSUdfSU9NTVVfSU9WQT15CkNPTkZJR19JT01NVV9B
UEk9eQpDT05GSUdfSU9NTVVfU1VQUE9SVD15CgojCiMgR2VuZXJpYyBJT01NVSBQYWdldGFi
bGUgU3VwcG9ydAojCkNPTkZJR19JT01NVV9JT19QR1RBQkxFPXkKIyBlbmQgb2YgR2VuZXJp
YyBJT01NVSBQYWdldGFibGUgU3VwcG9ydAoKIyBDT05GSUdfSU9NTVVfREVCVUdGUyBpcyBu
b3Qgc2V0CkNPTkZJR19JT01NVV9ERUZBVUxUX0RNQV9TVFJJQ1Q9eQojIENPTkZJR19JT01N
VV9ERUZBVUxUX0RNQV9MQVpZIGlzIG5vdCBzZXQKIyBDT05GSUdfSU9NTVVfREVGQVVMVF9Q
QVNTVEhST1VHSCBpcyBub3Qgc2V0CkNPTkZJR19JT01NVV9ETUE9eQpDT05GSUdfSU9NTVVf
U1ZBPXkKQ09ORklHX0FNRF9JT01NVT15CkNPTkZJR19ETUFSX1RBQkxFPXkKQ09ORklHX0lO
VEVMX0lPTU1VPXkKQ09ORklHX0lOVEVMX0lPTU1VX1NWTT15CkNPTkZJR19JTlRFTF9JT01N
VV9ERUZBVUxUX09OPXkKQ09ORklHX0lOVEVMX0lPTU1VX0ZMT1BQWV9XQT15CkNPTkZJR19J
TlRFTF9JT01NVV9TQ0FMQUJMRV9NT0RFX0RFRkFVTFRfT049eQpDT05GSUdfSU5URUxfSU9N
TVVfUEVSRl9FVkVOVFM9eQojIENPTkZJR19JT01NVUZEIGlzIG5vdCBzZXQKQ09ORklHX0lS
UV9SRU1BUD15CiMgQ09ORklHX1ZJUlRJT19JT01NVSBpcyBub3Qgc2V0CgojCiMgUmVtb3Rl
cHJvYyBkcml2ZXJzCiMKQ09ORklHX1JFTU9URVBST0M9eQpDT05GSUdfUkVNT1RFUFJPQ19D
REVWPXkKIyBlbmQgb2YgUmVtb3RlcHJvYyBkcml2ZXJzCgojCiMgUnBtc2cgZHJpdmVycwoj
CiMgQ09ORklHX1JQTVNHX1FDT01fR0xJTktfUlBNIGlzIG5vdCBzZXQKIyBDT05GSUdfUlBN
U0dfVklSVElPIGlzIG5vdCBzZXQKIyBlbmQgb2YgUnBtc2cgZHJpdmVycwoKIyBDT05GSUdf
U09VTkRXSVJFIGlzIG5vdCBzZXQKCiMKIyBTT0MgKFN5c3RlbSBPbiBDaGlwKSBzcGVjaWZp
YyBEcml2ZXJzCiMKCiMKIyBBbWxvZ2ljIFNvQyBkcml2ZXJzCiMKIyBlbmQgb2YgQW1sb2dp
YyBTb0MgZHJpdmVycwoKIwojIEJyb2FkY29tIFNvQyBkcml2ZXJzCiMKIyBlbmQgb2YgQnJv
YWRjb20gU29DIGRyaXZlcnMKCiMKIyBOWFAvRnJlZXNjYWxlIFFvcklRIFNvQyBkcml2ZXJz
CiMKIyBlbmQgb2YgTlhQL0ZyZWVzY2FsZSBRb3JJUSBTb0MgZHJpdmVycwoKIwojIGZ1aml0
c3UgU29DIGRyaXZlcnMKIwojIGVuZCBvZiBmdWppdHN1IFNvQyBkcml2ZXJzCgojCiMgaS5N
WCBTb0MgZHJpdmVycwojCiMgZW5kIG9mIGkuTVggU29DIGRyaXZlcnMKCiMKIyBFbmFibGUg
TGl0ZVggU29DIEJ1aWxkZXIgc3BlY2lmaWMgZHJpdmVycwojCiMgZW5kIG9mIEVuYWJsZSBM
aXRlWCBTb0MgQnVpbGRlciBzcGVjaWZpYyBkcml2ZXJzCgojIENPTkZJR19XUENNNDUwX1NP
QyBpcyBub3Qgc2V0CgojCiMgUXVhbGNvbW0gU29DIGRyaXZlcnMKIwojIGVuZCBvZiBRdWFs
Y29tbSBTb0MgZHJpdmVycwoKQ09ORklHX1NPQ19UST15CgojCiMgWGlsaW54IFNvQyBkcml2
ZXJzCiMKIyBlbmQgb2YgWGlsaW54IFNvQyBkcml2ZXJzCiMgZW5kIG9mIFNPQyAoU3lzdGVt
IE9uIENoaXApIHNwZWNpZmljIERyaXZlcnMKCiMKIyBQTSBEb21haW5zCiMKCiMKIyBBbWxv
Z2ljIFBNIERvbWFpbnMKIwojIGVuZCBvZiBBbWxvZ2ljIFBNIERvbWFpbnMKCiMKIyBCcm9h
ZGNvbSBQTSBEb21haW5zCiMKIyBlbmQgb2YgQnJvYWRjb20gUE0gRG9tYWlucwoKIwojIGku
TVggUE0gRG9tYWlucwojCiMgZW5kIG9mIGkuTVggUE0gRG9tYWlucwoKIwojIFF1YWxjb21t
IFBNIERvbWFpbnMKIwojIGVuZCBvZiBRdWFsY29tbSBQTSBEb21haW5zCiMgZW5kIG9mIFBN
IERvbWFpbnMKCkNPTkZJR19QTV9ERVZGUkVRPXkKCiMKIyBERVZGUkVRIEdvdmVybm9ycwoj
CiMgQ09ORklHX0RFVkZSRVFfR09WX1NJTVBMRV9PTkRFTUFORCBpcyBub3Qgc2V0CiMgQ09O
RklHX0RFVkZSRVFfR09WX1BFUkZPUk1BTkNFIGlzIG5vdCBzZXQKIyBDT05GSUdfREVWRlJF
UV9HT1ZfUE9XRVJTQVZFIGlzIG5vdCBzZXQKIyBDT05GSUdfREVWRlJFUV9HT1ZfVVNFUlNQ
QUNFIGlzIG5vdCBzZXQKIyBDT05GSUdfREVWRlJFUV9HT1ZfUEFTU0lWRSBpcyBub3Qgc2V0
CgojCiMgREVWRlJFUSBEcml2ZXJzCiMKQ09ORklHX1BNX0RFVkZSRVFfRVZFTlQ9eQpDT05G
SUdfRVhUQ09OPXkKCiMKIyBFeHRjb24gRGV2aWNlIERyaXZlcnMKIwojIENPTkZJR19FWFRD
T05fRlNBOTQ4MCBpcyBub3Qgc2V0CiMgQ09ORklHX0VYVENPTl9HUElPIGlzIG5vdCBzZXQK
IyBDT05GSUdfRVhUQ09OX0lOVEVMX0lOVDM0OTYgaXMgbm90IHNldAojIENPTkZJR19FWFRD
T05fSU5URUxfQ0hUX1dDIGlzIG5vdCBzZXQKIyBDT05GSUdfRVhUQ09OX01BWDMzNTUgaXMg
bm90IHNldAojIENPTkZJR19FWFRDT05fTUFYNzc4NDMgaXMgbm90IHNldAojIENPTkZJR19F
WFRDT05fTUFYODk5NyBpcyBub3Qgc2V0CiMgQ09ORklHX0VYVENPTl9QQUxNQVMgaXMgbm90
IHNldAojIENPTkZJR19FWFRDT05fUFRONTE1MCBpcyBub3Qgc2V0CiMgQ09ORklHX0VYVENP
Tl9SVDg5NzNBIGlzIG5vdCBzZXQKIyBDT05GSUdfRVhUQ09OX1NNNTUwMiBpcyBub3Qgc2V0
CiMgQ09ORklHX0VYVENPTl9VU0JfR1BJTyBpcyBub3Qgc2V0CkNPTkZJR19NRU1PUlk9eQoj
IENPTkZJR19JSU8gaXMgbm90IHNldAojIENPTkZJR19OVEIgaXMgbm90IHNldApDT05GSUdf
UFdNPXkKQ09ORklHX1BXTV9TWVNGUz15CiMgQ09ORklHX1BXTV9ERUJVRyBpcyBub3Qgc2V0
CiMgQ09ORklHX1BXTV9DTEsgaXMgbm90IHNldApDT05GSUdfUFdNX0NSQz15CiMgQ09ORklH
X1BXTV9EV0MgaXMgbm90IHNldAojIENPTkZJR19QV01fTFBTU19QQ0kgaXMgbm90IHNldAoj
IENPTkZJR19QV01fTFBTU19QTEFURk9STSBpcyBub3Qgc2V0CiMgQ09ORklHX1BXTV9QQ0E5
Njg1IGlzIG5vdCBzZXQKIyBDT05GSUdfUFdNX1RXTCBpcyBub3Qgc2V0CiMgQ09ORklHX1BX
TV9UV0xfTEVEIGlzIG5vdCBzZXQKCiMKIyBJUlEgY2hpcCBzdXBwb3J0CiMKIyBlbmQgb2Yg
SVJRIGNoaXAgc3VwcG9ydAoKIyBDT05GSUdfSVBBQ0tfQlVTIGlzIG5vdCBzZXQKQ09ORklH
X1JFU0VUX0NPTlRST0xMRVI9eQojIENPTkZJR19SRVNFVF9USV9TWVNDT04gaXMgbm90IHNl
dAojIENPTkZJR19SRVNFVF9USV9UUFMzODBYIGlzIG5vdCBzZXQKCiMKIyBQSFkgU3Vic3lz
dGVtCiMKQ09ORklHX0dFTkVSSUNfUEhZPXkKIyBDT05GSUdfVVNCX0xHTV9QSFkgaXMgbm90
IHNldAojIENPTkZJR19QSFlfQ0FOX1RSQU5TQ0VJVkVSIGlzIG5vdCBzZXQKCiMKIyBQSFkg
ZHJpdmVycyBmb3IgQnJvYWRjb20gcGxhdGZvcm1zCiMKIyBDT05GSUdfQkNNX0tPTkFfVVNC
Ml9QSFkgaXMgbm90IHNldAojIGVuZCBvZiBQSFkgZHJpdmVycyBmb3IgQnJvYWRjb20gcGxh
dGZvcm1zCgojIENPTkZJR19QSFlfUFhBXzI4Tk1fSFNJQyBpcyBub3Qgc2V0CiMgQ09ORklH
X1BIWV9QWEFfMjhOTV9VU0IyIGlzIG5vdCBzZXQKIyBDT05GSUdfUEhZX0lOVEVMX0xHTV9F
TU1DIGlzIG5vdCBzZXQKIyBlbmQgb2YgUEhZIFN1YnN5c3RlbQoKQ09ORklHX1BPV0VSQ0FQ
PXkKQ09ORklHX0lOVEVMX1JBUExfQ09SRT1tCkNPTkZJR19JTlRFTF9SQVBMPW0KQ09ORklH
X0lETEVfSU5KRUNUPXkKIyBDT05GSUdfTUNCIGlzIG5vdCBzZXQKCiMKIyBQZXJmb3JtYW5j
ZSBtb25pdG9yIHN1cHBvcnQKIwojIENPTkZJR19EV0NfUENJRV9QTVUgaXMgbm90IHNldAoj
IGVuZCBvZiBQZXJmb3JtYW5jZSBtb25pdG9yIHN1cHBvcnQKCkNPTkZJR19SQVM9eQpDT05G
SUdfUkFTX0NFQz15CiMgQ09ORklHX1JBU19DRUNfREVCVUcgaXMgbm90IHNldAojIENPTkZJ
R19VU0I0IGlzIG5vdCBzZXQKCiMKIyBBbmRyb2lkCiMKIyBDT05GSUdfQU5EUk9JRF9CSU5E
RVJfSVBDIGlzIG5vdCBzZXQKIyBlbmQgb2YgQW5kcm9pZAoKQ09ORklHX0xJQk5WRElNTT15
CiMgQ09ORklHX0JMS19ERVZfUE1FTSBpcyBub3Qgc2V0CkNPTkZJR19ORF9DTEFJTT15CkNP
TkZJR19CVFQ9eQpDT05GSUdfTlZESU1NX1BGTj15CkNPTkZJR19OVkRJTU1fREFYPXkKQ09O
RklHX0RBWD15CiMgQ09ORklHX0RFVl9EQVggaXMgbm90IHNldAojIENPTkZJR19ERVZfREFY
X0hNRU0gaXMgbm90IHNldApDT05GSUdfTlZNRU09eQpDT05GSUdfTlZNRU1fU1lTRlM9eQoj
IENPTkZJR19OVk1FTV9MQVlPVVRTIGlzIG5vdCBzZXQKIyBDT05GSUdfTlZNRU1fUk1FTSBp
cyBub3Qgc2V0CgojCiMgSFcgdHJhY2luZyBzdXBwb3J0CiMKIyBDT05GSUdfU1RNIGlzIG5v
dCBzZXQKIyBDT05GSUdfSU5URUxfVEggaXMgbm90IHNldAojIGVuZCBvZiBIVyB0cmFjaW5n
IHN1cHBvcnQKCiMgQ09ORklHX0ZQR0EgaXMgbm90IHNldAojIENPTkZJR19URUUgaXMgbm90
IHNldApDT05GSUdfUE1fT1BQPXkKIyBDT05GSUdfU0lPWCBpcyBub3Qgc2V0CiMgQ09ORklH
X1NMSU1CVVMgaXMgbm90IHNldApDT05GSUdfSU5URVJDT05ORUNUPXkKIyBDT05GSUdfQ09V
TlRFUiBpcyBub3Qgc2V0CiMgQ09ORklHX01PU1QgaXMgbm90IHNldAojIENPTkZJR19QRUNJ
IGlzIG5vdCBzZXQKQ09ORklHX0hURT15CiMgZW5kIG9mIERldmljZSBEcml2ZXJzCgojCiMg
RmlsZSBzeXN0ZW1zCiMKQ09ORklHX0RDQUNIRV9XT1JEX0FDQ0VTUz15CkNPTkZJR19WQUxJ
REFURV9GU19QQVJTRVI9eQpDT05GSUdfRlNfSU9NQVA9eQojIENPTkZJR19FWFQyX0ZTIGlz
IG5vdCBzZXQKIyBDT05GSUdfRVhUM19GUyBpcyBub3Qgc2V0CiMgQ09ORklHX0VYVDRfRlMg
aXMgbm90IHNldAojIENPTkZJR19SRUlTRVJGU19GUyBpcyBub3Qgc2V0CiMgQ09ORklHX0pG
U19GUyBpcyBub3Qgc2V0CiMgQ09ORklHX1hGU19GUyBpcyBub3Qgc2V0CiMgQ09ORklHX0dG
UzJfRlMgaXMgbm90IHNldAojIENPTkZJR19PQ0ZTMl9GUyBpcyBub3Qgc2V0CkNPTkZJR19C
VFJGU19GUz1tCkNPTkZJR19CVFJGU19GU19QT1NJWF9BQ0w9eQojIENPTkZJR19CVFJGU19G
U19SVU5fU0FOSVRZX1RFU1RTIGlzIG5vdCBzZXQKIyBDT05GSUdfQlRSRlNfREVCVUcgaXMg
bm90IHNldAojIENPTkZJR19CVFJGU19BU1NFUlQgaXMgbm90IHNldAojIENPTkZJR19CVFJG
U19GU19SRUZfVkVSSUZZIGlzIG5vdCBzZXQKIyBDT05GSUdfTklMRlMyX0ZTIGlzIG5vdCBz
ZXQKIyBDT05GSUdfRjJGU19GUyBpcyBub3Qgc2V0CiMgQ09ORklHX0JDQUNIRUZTX0ZTIGlz
IG5vdCBzZXQKIyBDT05GSUdfWk9ORUZTX0ZTIGlzIG5vdCBzZXQKQ09ORklHX0ZTX0RBWD15
CkNPTkZJR19GU19EQVhfUE1EPXkKQ09ORklHX0ZTX1BPU0lYX0FDTD15CkNPTkZJR19FWFBP
UlRGUz15CkNPTkZJR19FWFBPUlRGU19CTE9DS19PUFM9eQpDT05GSUdfRklMRV9MT0NLSU5H
PXkKQ09ORklHX0ZTX0VOQ1JZUFRJT049eQpDT05GSUdfRlNfRU5DUllQVElPTl9JTkxJTkVf
Q1JZUFQ9eQpDT05GSUdfRlNfVkVSSVRZPXkKQ09ORklHX0ZTX1ZFUklUWV9CVUlMVElOX1NJ
R05BVFVSRVM9eQpDT05GSUdfRlNOT1RJRlk9eQpDT05GSUdfRE5PVElGWT15CkNPTkZJR19J
Tk9USUZZX1VTRVI9eQpDT05GSUdfRkFOT1RJRlk9eQpDT05GSUdfRkFOT1RJRllfQUNDRVNT
X1BFUk1JU1NJT05TPXkKQ09ORklHX1FVT1RBPXkKQ09ORklHX1FVT1RBX05FVExJTktfSU5U
RVJGQUNFPXkKIyBDT05GSUdfUVVPVEFfREVCVUcgaXMgbm90IHNldAojIENPTkZJR19RRk1U
X1YxIGlzIG5vdCBzZXQKIyBDT05GSUdfUUZNVF9WMiBpcyBub3Qgc2V0CkNPTkZJR19RVU9U
QUNUTD15CkNPTkZJR19BVVRPRlNfRlM9eQpDT05GSUdfRlVTRV9GUz1tCiMgQ09ORklHX0NV
U0UgaXMgbm90IHNldAojIENPTkZJR19WSVJUSU9fRlMgaXMgbm90IHNldAojIENPTkZJR19P
VkVSTEFZX0ZTIGlzIG5vdCBzZXQKCiMKIyBDYWNoZXMKIwojIGVuZCBvZiBDYWNoZXMKCiMK
IyBDRC1ST00vRFZEIEZpbGVzeXN0ZW1zCiMKIyBDT05GSUdfSVNPOTY2MF9GUyBpcyBub3Qg
c2V0CiMgQ09ORklHX1VERl9GUyBpcyBub3Qgc2V0CiMgZW5kIG9mIENELVJPTS9EVkQgRmls
ZXN5c3RlbXMKCiMKIyBET1MvRkFUL0VYRkFUL05UIEZpbGVzeXN0ZW1zCiMKIyBDT05GSUdf
TVNET1NfRlMgaXMgbm90IHNldAojIENPTkZJR19WRkFUX0ZTIGlzIG5vdCBzZXQKIyBDT05G
SUdfRVhGQVRfRlMgaXMgbm90IHNldAojIENPTkZJR19OVEZTX0ZTIGlzIG5vdCBzZXQKIyBD
T05GSUdfTlRGUzNfRlMgaXMgbm90IHNldAojIGVuZCBvZiBET1MvRkFUL0VYRkFUL05UIEZp
bGVzeXN0ZW1zCgojCiMgUHNldWRvIGZpbGVzeXN0ZW1zCiMKQ09ORklHX1BST0NfRlM9eQoj
IENPTkZJR19QUk9DX0tDT1JFIGlzIG5vdCBzZXQKQ09ORklHX1BST0NfU1lTQ1RMPXkKQ09O
RklHX1BST0NfUEFHRV9NT05JVE9SPXkKQ09ORklHX1BST0NfQ0hJTERSRU49eQpDT05GSUdf
UFJPQ19QSURfQVJDSF9TVEFUVVM9eQpDT05GSUdfUFJPQ19DUFVfUkVTQ1RSTD15CkNPTkZJ
R19LRVJORlM9eQpDT05GSUdfU1lTRlM9eQpDT05GSUdfVE1QRlM9eQpDT05GSUdfVE1QRlNf
UE9TSVhfQUNMPXkKQ09ORklHX1RNUEZTX1hBVFRSPXkKQ09ORklHX1RNUEZTX0lOT0RFNjQ9
eQpDT05GSUdfVE1QRlNfUVVPVEE9eQpDT05GSUdfSFVHRVRMQkZTPXkKIyBDT05GSUdfSFVH
RVRMQl9QQUdFX09QVElNSVpFX1ZNRU1NQVBfREVGQVVMVF9PTiBpcyBub3Qgc2V0CkNPTkZJ
R19IVUdFVExCX1BBR0U9eQpDT05GSUdfSFVHRVRMQl9QQUdFX09QVElNSVpFX1ZNRU1NQVA9
eQpDT05GSUdfQVJDSF9IQVNfR0lHQU5USUNfUEFHRT15CkNPTkZJR19DT05GSUdGU19GUz15
CkNPTkZJR19FRklWQVJfRlM9eQojIGVuZCBvZiBQc2V1ZG8gZmlsZXN5c3RlbXMKCkNPTkZJ
R19NSVNDX0ZJTEVTWVNURU1TPXkKIyBDT05GSUdfT1JBTkdFRlNfRlMgaXMgbm90IHNldAoj
IENPTkZJR19BREZTX0ZTIGlzIG5vdCBzZXQKIyBDT05GSUdfQUZGU19GUyBpcyBub3Qgc2V0
CiMgQ09ORklHX0VDUllQVF9GUyBpcyBub3Qgc2V0CiMgQ09ORklHX0hGU19GUyBpcyBub3Qg
c2V0CiMgQ09ORklHX0hGU1BMVVNfRlMgaXMgbm90IHNldAojIENPTkZJR19CRUZTX0ZTIGlz
IG5vdCBzZXQKIyBDT05GSUdfQkZTX0ZTIGlzIG5vdCBzZXQKIyBDT05GSUdfRUZTX0ZTIGlz
IG5vdCBzZXQKIyBDT05GSUdfQ1JBTUZTIGlzIG5vdCBzZXQKIyBDT05GSUdfU1FVQVNIRlMg
aXMgbm90IHNldAojIENPTkZJR19WWEZTX0ZTIGlzIG5vdCBzZXQKIyBDT05GSUdfTUlOSVhf
RlMgaXMgbm90IHNldAojIENPTkZJR19PTUZTX0ZTIGlzIG5vdCBzZXQKIyBDT05GSUdfSFBG
U19GUyBpcyBub3Qgc2V0CiMgQ09ORklHX1FOWDRGU19GUyBpcyBub3Qgc2V0CiMgQ09ORklH
X1FOWDZGU19GUyBpcyBub3Qgc2V0CiMgQ09ORklHX1JPTUZTX0ZTIGlzIG5vdCBzZXQKQ09O
RklHX1BTVE9SRT15CkNPTkZJR19QU1RPUkVfREVGQVVMVF9LTVNHX0JZVEVTPTEwMjQwCkNP
TkZJR19QU1RPUkVfQ09NUFJFU1M9eQojIENPTkZJR19QU1RPUkVfQ09OU09MRSBpcyBub3Qg
c2V0CiMgQ09ORklHX1BTVE9SRV9QTVNHIGlzIG5vdCBzZXQKIyBDT05GSUdfUFNUT1JFX0ZU
UkFDRSBpcyBub3Qgc2V0CiMgQ09ORklHX1BTVE9SRV9SQU0gaXMgbm90IHNldAojIENPTkZJ
R19QU1RPUkVfQkxLIGlzIG5vdCBzZXQKIyBDT05GSUdfU1lTVl9GUyBpcyBub3Qgc2V0CiMg
Q09ORklHX1VGU19GUyBpcyBub3Qgc2V0CiMgQ09ORklHX0VST0ZTX0ZTIGlzIG5vdCBzZXQK
Q09ORklHX05FVFdPUktfRklMRVNZU1RFTVM9eQojIENPTkZJR19ORlNfRlMgaXMgbm90IHNl
dAojIENPTkZJR19ORlNEIGlzIG5vdCBzZXQKIyBDT05GSUdfQ0VQSF9GUyBpcyBub3Qgc2V0
CiMgQ09ORklHX0NJRlMgaXMgbm90IHNldAojIENPTkZJR19TTUJfU0VSVkVSIGlzIG5vdCBz
ZXQKIyBDT05GSUdfQ09EQV9GUyBpcyBub3Qgc2V0CiMgQ09ORklHX0FGU19GUyBpcyBub3Qg
c2V0CkNPTkZJR19OTFM9eQpDT05GSUdfTkxTX0RFRkFVTFQ9InV0ZjgiCkNPTkZJR19OTFNf
Q09ERVBBR0VfNDM3PXkKIyBDT05GSUdfTkxTX0NPREVQQUdFXzczNyBpcyBub3Qgc2V0CiMg
Q09ORklHX05MU19DT0RFUEFHRV83NzUgaXMgbm90IHNldAojIENPTkZJR19OTFNfQ09ERVBB
R0VfODUwIGlzIG5vdCBzZXQKIyBDT05GSUdfTkxTX0NPREVQQUdFXzg1MiBpcyBub3Qgc2V0
CiMgQ09ORklHX05MU19DT0RFUEFHRV84NTUgaXMgbm90IHNldAojIENPTkZJR19OTFNfQ09E
RVBBR0VfODU3IGlzIG5vdCBzZXQKIyBDT05GSUdfTkxTX0NPREVQQUdFXzg2MCBpcyBub3Qg
c2V0CiMgQ09ORklHX05MU19DT0RFUEFHRV84NjEgaXMgbm90IHNldAojIENPTkZJR19OTFNf
Q09ERVBBR0VfODYyIGlzIG5vdCBzZXQKIyBDT05GSUdfTkxTX0NPREVQQUdFXzg2MyBpcyBu
b3Qgc2V0CiMgQ09ORklHX05MU19DT0RFUEFHRV84NjQgaXMgbm90IHNldAojIENPTkZJR19O
TFNfQ09ERVBBR0VfODY1IGlzIG5vdCBzZXQKIyBDT05GSUdfTkxTX0NPREVQQUdFXzg2NiBp
cyBub3Qgc2V0CiMgQ09ORklHX05MU19DT0RFUEFHRV84NjkgaXMgbm90IHNldAojIENPTkZJ
R19OTFNfQ09ERVBBR0VfOTM2IGlzIG5vdCBzZXQKIyBDT05GSUdfTkxTX0NPREVQQUdFXzk1
MCBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19DT0RFUEFHRV85MzIgaXMgbm90IHNldAojIENP
TkZJR19OTFNfQ09ERVBBR0VfOTQ5IGlzIG5vdCBzZXQKIyBDT05GSUdfTkxTX0NPREVQQUdF
Xzg3NCBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19JU084ODU5XzggaXMgbm90IHNldAojIENP
TkZJR19OTFNfQ09ERVBBR0VfMTI1MCBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19DT0RFUEFH
RV8xMjUxIGlzIG5vdCBzZXQKQ09ORklHX05MU19BU0NJST15CiMgQ09ORklHX05MU19JU084
ODU5XzEgaXMgbm90IHNldAojIENPTkZJR19OTFNfSVNPODg1OV8yIGlzIG5vdCBzZXQKIyBD
T05GSUdfTkxTX0lTTzg4NTlfMyBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19JU084ODU5XzQg
aXMgbm90IHNldAojIENPTkZJR19OTFNfSVNPODg1OV81IGlzIG5vdCBzZXQKIyBDT05GSUdf
TkxTX0lTTzg4NTlfNiBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19JU084ODU5XzcgaXMgbm90
IHNldAojIENPTkZJR19OTFNfSVNPODg1OV85IGlzIG5vdCBzZXQKIyBDT05GSUdfTkxTX0lT
Tzg4NTlfMTMgaXMgbm90IHNldAojIENPTkZJR19OTFNfSVNPODg1OV8xNCBpcyBub3Qgc2V0
CiMgQ09ORklHX05MU19JU084ODU5XzE1IGlzIG5vdCBzZXQKIyBDT05GSUdfTkxTX0tPSThf
UiBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19LT0k4X1UgaXMgbm90IHNldAojIENPTkZJR19O
TFNfTUFDX1JPTUFOIGlzIG5vdCBzZXQKIyBDT05GSUdfTkxTX01BQ19DRUxUSUMgaXMgbm90
IHNldAojIENPTkZJR19OTFNfTUFDX0NFTlRFVVJPIGlzIG5vdCBzZXQKIyBDT05GSUdfTkxT
X01BQ19DUk9BVElBTiBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19NQUNfQ1lSSUxMSUMgaXMg
bm90IHNldAojIENPTkZJR19OTFNfTUFDX0dBRUxJQyBpcyBub3Qgc2V0CiMgQ09ORklHX05M
U19NQUNfR1JFRUsgaXMgbm90IHNldAojIENPTkZJR19OTFNfTUFDX0lDRUxBTkQgaXMgbm90
IHNldAojIENPTkZJR19OTFNfTUFDX0lOVUlUIGlzIG5vdCBzZXQKIyBDT05GSUdfTkxTX01B
Q19ST01BTklBTiBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19NQUNfVFVSS0lTSCBpcyBub3Qg
c2V0CiMgQ09ORklHX05MU19VVEY4IGlzIG5vdCBzZXQKIyBDT05GSUdfRExNIGlzIG5vdCBz
ZXQKQ09ORklHX1VOSUNPREU9eQojIENPTkZJR19VTklDT0RFX05PUk1BTElaQVRJT05fU0VM
RlRFU1QgaXMgbm90IHNldApDT05GSUdfSU9fV1E9eQojIGVuZCBvZiBGaWxlIHN5c3RlbXMK
CiMKIyBTZWN1cml0eSBvcHRpb25zCiMKQ09ORklHX0tFWVM9eQpDT05GSUdfS0VZU19SRVFV
RVNUX0NBQ0hFPXkKQ09ORklHX1BFUlNJU1RFTlRfS0VZUklOR1M9eQojIENPTkZJR19UUlVT
VEVEX0tFWVMgaXMgbm90IHNldAojIENPTkZJR19FTkNSWVBURURfS0VZUyBpcyBub3Qgc2V0
CkNPTkZJR19LRVlfREhfT1BFUkFUSU9OUz15CkNPTkZJR19LRVlfTk9USUZJQ0FUSU9OUz15
CkNPTkZJR19TRUNVUklUWV9ETUVTR19SRVNUUklDVD15CkNPTkZJR19TRUNVUklUWT15CkNP
TkZJR19TRUNVUklUWUZTPXkKQ09ORklHX1NFQ1VSSVRZX05FVFdPUks9eQpDT05GSUdfU0VD
VVJJVFlfUEFUSD15CiMgQ09ORklHX0lOVEVMX1RYVCBpcyBub3Qgc2V0CkNPTkZJR19MU01f
TU1BUF9NSU5fQUREUj02NTUzNgpDT05GSUdfSEFSREVORURfVVNFUkNPUFk9eQpDT05GSUdf
Rk9SVElGWV9TT1VSQ0U9eQojIENPTkZJR19TVEFUSUNfVVNFUk1PREVIRUxQRVIgaXMgbm90
IHNldApDT05GSUdfU0VDVVJJVFlfU0VMSU5VWD15CkNPTkZJR19TRUNVUklUWV9TRUxJTlVY
X0JPT1RQQVJBTT15CkNPTkZJR19TRUNVUklUWV9TRUxJTlVYX0RFVkVMT1A9eQpDT05GSUdf
U0VDVVJJVFlfU0VMSU5VWF9BVkNfU1RBVFM9eQpDT05GSUdfU0VDVVJJVFlfU0VMSU5VWF9T
SURUQUJfSEFTSF9CSVRTPTkKQ09ORklHX1NFQ1VSSVRZX1NFTElOVVhfU0lEMlNUUl9DQUNI
RV9TSVpFPTI1NgojIENPTkZJR19TRUNVUklUWV9TRUxJTlVYX0RFQlVHIGlzIG5vdCBzZXQK
Q09ORklHX1NFQ1VSSVRZX1NNQUNLPXkKQ09ORklHX1NFQ1VSSVRZX1NNQUNLX0JSSU5HVVA9
eQpDT05GSUdfU0VDVVJJVFlfU01BQ0tfTkVURklMVEVSPXkKQ09ORklHX1NFQ1VSSVRZX1NN
QUNLX0FQUEVORF9TSUdOQUxTPXkKQ09ORklHX1NFQ1VSSVRZX1RPTU9ZTz15CkNPTkZJR19T
RUNVUklUWV9UT01PWU9fTUFYX0FDQ0VQVF9FTlRSWT0yMDQ4CkNPTkZJR19TRUNVUklUWV9U
T01PWU9fTUFYX0FVRElUX0xPRz0xMDI0CiMgQ09ORklHX1NFQ1VSSVRZX1RPTU9ZT19PTUlU
X1VTRVJTUEFDRV9MT0FERVIgaXMgbm90IHNldApDT05GSUdfU0VDVVJJVFlfVE9NT1lPX1BP
TElDWV9MT0FERVI9Ii91c3IvYmluL3RvbW95by1pbml0IgpDT05GSUdfU0VDVVJJVFlfVE9N
T1lPX0FDVElWQVRJT05fVFJJR0dFUj0iL3Vzci9saWIvc3lzdGVtZC9zeXN0ZW1kIgojIENP
TkZJR19TRUNVUklUWV9UT01PWU9fSU5TRUNVUkVfQlVJTFRJTl9TRVRUSU5HIGlzIG5vdCBz
ZXQKQ09ORklHX1NFQ1VSSVRZX0FQUEFSTU9SPXkKIyBDT05GSUdfU0VDVVJJVFlfQVBQQVJN
T1JfREVCVUcgaXMgbm90IHNldApDT05GSUdfU0VDVVJJVFlfQVBQQVJNT1JfSU5UUk9TUEVD
VF9QT0xJQ1k9eQpDT05GSUdfU0VDVVJJVFlfQVBQQVJNT1JfSEFTSD15CkNPTkZJR19TRUNV
UklUWV9BUFBBUk1PUl9IQVNIX0RFRkFVTFQ9eQpDT05GSUdfU0VDVVJJVFlfQVBQQVJNT1Jf
RVhQT1JUX0JJTkFSWT15CkNPTkZJR19TRUNVUklUWV9BUFBBUk1PUl9QQVJBTk9JRF9MT0FE
PXkKQ09ORklHX1NFQ1VSSVRZX0xPQURQSU49eQpDT05GSUdfU0VDVVJJVFlfTE9BRFBJTl9F
TkZPUkNFPXkKQ09ORklHX1NFQ1VSSVRZX1lBTUE9eQpDT05GSUdfU0VDVVJJVFlfU0FGRVNF
VElEPXkKQ09ORklHX1NFQ1VSSVRZX0xPQ0tET1dOX0xTTT15CiMgQ09ORklHX1NFQ1VSSVRZ
X0xPQ0tET1dOX0xTTV9FQVJMWSBpcyBub3Qgc2V0CkNPTkZJR19MT0NLX0RPV05fS0VSTkVM
X0ZPUkNFX05PTkU9eQojIENPTkZJR19MT0NLX0RPV05fS0VSTkVMX0ZPUkNFX0lOVEVHUklU
WSBpcyBub3Qgc2V0CiMgQ09ORklHX0xPQ0tfRE9XTl9LRVJORUxfRk9SQ0VfQ09ORklERU5U
SUFMSVRZIGlzIG5vdCBzZXQKQ09ORklHX1NFQ1VSSVRZX0xBTkRMT0NLPXkKQ09ORklHX0lO
VEVHUklUWT15CkNPTkZJR19JTlRFR1JJVFlfU0lHTkFUVVJFPXkKQ09ORklHX0lOVEVHUklU
WV9BU1lNTUVUUklDX0tFWVM9eQpDT05GSUdfSU5URUdSSVRZX1RSVVNURURfS0VZUklORz15
CkNPTkZJR19JTlRFR1JJVFlfUExBVEZPUk1fS0VZUklORz15CkNPTkZJR19JTlRFR1JJVFlf
TUFDSElORV9LRVlSSU5HPXkKIyBDT05GSUdfSU5URUdSSVRZX0NBX01BQ0hJTkVfS0VZUklO
RyBpcyBub3Qgc2V0CkNPTkZJR19MT0FEX1VFRklfS0VZUz15CkNPTkZJR19JTlRFR1JJVFlf
QVVESVQ9eQojIENPTkZJR19JTUEgaXMgbm90IHNldAojIENPTkZJR19JTUFfU0VDVVJFX0FO
RF9PUl9UUlVTVEVEX0JPT1QgaXMgbm90IHNldAojIENPTkZJR19FVk0gaXMgbm90IHNldAoj
IENPTkZJR19ERUZBVUxUX1NFQ1VSSVRZX1NFTElOVVggaXMgbm90IHNldAojIENPTkZJR19E
RUZBVUxUX1NFQ1VSSVRZX1NNQUNLIGlzIG5vdCBzZXQKIyBDT05GSUdfREVGQVVMVF9TRUNV
UklUWV9UT01PWU8gaXMgbm90IHNldAojIENPTkZJR19ERUZBVUxUX1NFQ1VSSVRZX0FQUEFS
TU9SIGlzIG5vdCBzZXQKQ09ORklHX0RFRkFVTFRfU0VDVVJJVFlfREFDPXkKQ09ORklHX0xT
TT0ibGFuZGxvY2ssbG9ja2Rvd24seWFtYSxpbnRlZ3JpdHksYnBmIgoKIwojIEtlcm5lbCBo
YXJkZW5pbmcgb3B0aW9ucwojCgojCiMgTWVtb3J5IGluaXRpYWxpemF0aW9uCiMKQ09ORklH
X0NDX0hBU19BVVRPX1ZBUl9JTklUX1BBVFRFUk49eQpDT05GSUdfQ0NfSEFTX0FVVE9fVkFS
X0lOSVRfWkVST19CQVJFPXkKQ09ORklHX0NDX0hBU19BVVRPX1ZBUl9JTklUX1pFUk89eQoj
IENPTkZJR19JTklUX1NUQUNLX05PTkUgaXMgbm90IHNldAojIENPTkZJR19JTklUX1NUQUNL
X0FMTF9QQVRURVJOIGlzIG5vdCBzZXQKQ09ORklHX0lOSVRfU1RBQ0tfQUxMX1pFUk89eQpD
T05GSUdfR0NDX1BMVUdJTl9TVEFDS0xFQUs9eQpDT05GSUdfU1RBQ0tMRUFLX1RSQUNLX01J
Tl9TSVpFPTEwMAojIENPTkZJR19TVEFDS0xFQUtfTUVUUklDUyBpcyBub3Qgc2V0CiMgQ09O
RklHX1NUQUNLTEVBS19SVU5USU1FX0RJU0FCTEUgaXMgbm90IHNldApDT05GSUdfSU5JVF9P
Tl9BTExPQ19ERUZBVUxUX09OPXkKQ09ORklHX0lOSVRfT05fRlJFRV9ERUZBVUxUX09OPXkK
Q09ORklHX0NDX0hBU19aRVJPX0NBTExfVVNFRF9SRUdTPXkKIyBDT05GSUdfWkVST19DQUxM
X1VTRURfUkVHUyBpcyBub3Qgc2V0CiMgZW5kIG9mIE1lbW9yeSBpbml0aWFsaXphdGlvbgoK
IwojIEhhcmRlbmluZyBvZiBrZXJuZWwgZGF0YSBzdHJ1Y3R1cmVzCiMKQ09ORklHX0xJU1Rf
SEFSREVORUQ9eQpDT05GSUdfQlVHX09OX0RBVEFfQ09SUlVQVElPTj15CiMgZW5kIG9mIEhh
cmRlbmluZyBvZiBrZXJuZWwgZGF0YSBzdHJ1Y3R1cmVzCgojIENPTkZJR19SQU5EU1RSVUNU
X05PTkUgaXMgbm90IHNldApDT05GSUdfUkFORFNUUlVDVF9GVUxMPXkKIyBDT05GSUdfUkFO
RFNUUlVDVF9QRVJGT1JNQU5DRSBpcyBub3Qgc2V0CkNPTkZJR19SQU5EU1RSVUNUPXkKQ09O
RklHX0dDQ19QTFVHSU5fUkFORFNUUlVDVD15CiMgZW5kIG9mIEtlcm5lbCBoYXJkZW5pbmcg
b3B0aW9ucwojIGVuZCBvZiBTZWN1cml0eSBvcHRpb25zCgpDT05GSUdfWE9SX0JMT0NLUz1t
CkNPTkZJR19DUllQVE89eQoKIwojIENyeXB0byBjb3JlIG9yIGhlbHBlcgojCkNPTkZJR19D
UllQVE9fQUxHQVBJPXkKQ09ORklHX0NSWVBUT19BTEdBUEkyPXkKQ09ORklHX0NSWVBUT19B
RUFEPW0KQ09ORklHX0NSWVBUT19BRUFEMj15CkNPTkZJR19DUllQVE9fU0lHMj15CkNPTkZJ
R19DUllQVE9fU0tDSVBIRVI9eQpDT05GSUdfQ1JZUFRPX1NLQ0lQSEVSMj15CkNPTkZJR19D
UllQVE9fSEFTSD15CkNPTkZJR19DUllQVE9fSEFTSDI9eQpDT05GSUdfQ1JZUFRPX1JORz15
CkNPTkZJR19DUllQVE9fUk5HMj15CkNPTkZJR19DUllQVE9fUk5HX0RFRkFVTFQ9eQpDT05G
SUdfQ1JZUFRPX0FLQ0lQSEVSMj15CkNPTkZJR19DUllQVE9fQUtDSVBIRVI9eQpDT05GSUdf
Q1JZUFRPX0tQUDI9eQpDT05GSUdfQ1JZUFRPX0tQUD15CkNPTkZJR19DUllQVE9fQUNPTVAy
PXkKQ09ORklHX0NSWVBUT19NQU5BR0VSPXkKQ09ORklHX0NSWVBUT19NQU5BR0VSMj15CiMg
Q09ORklHX0NSWVBUT19VU0VSIGlzIG5vdCBzZXQKQ09ORklHX0NSWVBUT19NQU5BR0VSX0RJ
U0FCTEVfVEVTVFM9eQojIENPTkZJR19DUllQVE9fTlVMTCBpcyBub3Qgc2V0CiMgQ09ORklH
X0NSWVBUT19QQ1JZUFQgaXMgbm90IHNldApDT05GSUdfQ1JZUFRPX0NSWVBURD1tCiMgQ09O
RklHX0NSWVBUT19BVVRIRU5DIGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRPX1RFU1QgaXMg
bm90IHNldApDT05GSUdfQ1JZUFRPX1NJTUQ9bQojIGVuZCBvZiBDcnlwdG8gY29yZSBvciBo
ZWxwZXIKCiMKIyBQdWJsaWMta2V5IGNyeXB0b2dyYXBoeQojCkNPTkZJR19DUllQVE9fUlNB
PXkKQ09ORklHX0NSWVBUT19ESD15CkNPTkZJR19DUllQVE9fREhfUkZDNzkxOV9HUk9VUFM9
eQpDT05GSUdfQ1JZUFRPX0VDQz15CiMgQ09ORklHX0NSWVBUT19FQ0RIIGlzIG5vdCBzZXQK
Q09ORklHX0NSWVBUT19FQ0RTQT15CiMgQ09ORklHX0NSWVBUT19FQ1JEU0EgaXMgbm90IHNl
dAojIENPTkZJR19DUllQVE9fU00yIGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRPX0NVUlZF
MjU1MTkgaXMgbm90IHNldAojIGVuZCBvZiBQdWJsaWMta2V5IGNyeXB0b2dyYXBoeQoKIwoj
IEJsb2NrIGNpcGhlcnMKIwpDT05GSUdfQ1JZUFRPX0FFUz15CiMgQ09ORklHX0NSWVBUT19B
RVNfVEkgaXMgbm90IHNldAojIENPTkZJR19DUllQVE9fQVJJQSBpcyBub3Qgc2V0CiMgQ09O
RklHX0NSWVBUT19CTE9XRklTSCBpcyBub3Qgc2V0CiMgQ09ORklHX0NSWVBUT19DQU1FTExJ
QSBpcyBub3Qgc2V0CiMgQ09ORklHX0NSWVBUT19DQVNUNSBpcyBub3Qgc2V0CiMgQ09ORklH
X0NSWVBUT19DQVNUNiBpcyBub3Qgc2V0CiMgQ09ORklHX0NSWVBUT19ERVMgaXMgbm90IHNl
dAojIENPTkZJR19DUllQVE9fRkNSWVBUIGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRPX1NF
UlBFTlQgaXMgbm90IHNldAojIENPTkZJR19DUllQVE9fU000X0dFTkVSSUMgaXMgbm90IHNl
dAojIENPTkZJR19DUllQVE9fVFdPRklTSCBpcyBub3Qgc2V0CiMgZW5kIG9mIEJsb2NrIGNp
cGhlcnMKCiMKIyBMZW5ndGgtcHJlc2VydmluZyBjaXBoZXJzIGFuZCBtb2RlcwojCiMgQ09O
RklHX0NSWVBUT19BRElBTlRVTSBpcyBub3Qgc2V0CiMgQ09ORklHX0NSWVBUT19DSEFDSEEy
MCBpcyBub3Qgc2V0CiMgQ09ORklHX0NSWVBUT19DQkMgaXMgbm90IHNldApDT05GSUdfQ1JZ
UFRPX0NUUj15CiMgQ09ORklHX0NSWVBUT19DVFMgaXMgbm90IHNldApDT05GSUdfQ1JZUFRP
X0VDQj15CiMgQ09ORklHX0NSWVBUT19IQ1RSMiBpcyBub3Qgc2V0CiMgQ09ORklHX0NSWVBU
T19LRVlXUkFQIGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRPX0xSVyBpcyBub3Qgc2V0CiMg
Q09ORklHX0NSWVBUT19QQ0JDIGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRPX1hUUyBpcyBu
b3Qgc2V0CiMgZW5kIG9mIExlbmd0aC1wcmVzZXJ2aW5nIGNpcGhlcnMgYW5kIG1vZGVzCgoj
CiMgQUVBRCAoYXV0aGVudGljYXRlZCBlbmNyeXB0aW9uIHdpdGggYXNzb2NpYXRlZCBkYXRh
KSBjaXBoZXJzCiMKIyBDT05GSUdfQ1JZUFRPX0FFR0lTMTI4IGlzIG5vdCBzZXQKIyBDT05G
SUdfQ1JZUFRPX0NIQUNIQTIwUE9MWTEzMDUgaXMgbm90IHNldAojIENPTkZJR19DUllQVE9f
Q0NNIGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRPX0dDTSBpcyBub3Qgc2V0CiMgQ09ORklH
X0NSWVBUT19TRVFJViBpcyBub3Qgc2V0CiMgQ09ORklHX0NSWVBUT19FQ0hBSU5JViBpcyBu
b3Qgc2V0CiMgQ09ORklHX0NSWVBUT19FU1NJViBpcyBub3Qgc2V0CiMgZW5kIG9mIEFFQUQg
KGF1dGhlbnRpY2F0ZWQgZW5jcnlwdGlvbiB3aXRoIGFzc29jaWF0ZWQgZGF0YSkgY2lwaGVy
cwoKIwojIEhhc2hlcywgZGlnZXN0cywgYW5kIE1BQ3MKIwpDT05GSUdfQ1JZUFRPX0JMQUtF
MkI9bQojIENPTkZJR19DUllQVE9fQ01BQyBpcyBub3Qgc2V0CiMgQ09ORklHX0NSWVBUT19H
SEFTSCBpcyBub3Qgc2V0CkNPTkZJR19DUllQVE9fSE1BQz15CiMgQ09ORklHX0NSWVBUT19N
RDQgaXMgbm90IHNldApDT05GSUdfQ1JZUFRPX01ENT15CiMgQ09ORklHX0NSWVBUT19NSUNI
QUVMX01JQyBpcyBub3Qgc2V0CkNPTkZJR19DUllQVE9fUE9MWVZBTD1tCiMgQ09ORklHX0NS
WVBUT19QT0xZMTMwNSBpcyBub3Qgc2V0CiMgQ09ORklHX0NSWVBUT19STUQxNjAgaXMgbm90
IHNldApDT05GSUdfQ1JZUFRPX1NIQTE9eQpDT05GSUdfQ1JZUFRPX1NIQTI1Nj15CkNPTkZJ
R19DUllQVE9fU0hBNTEyPXkKQ09ORklHX0NSWVBUT19TSEEzPXkKIyBDT05GSUdfQ1JZUFRP
X1NNM19HRU5FUklDIGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRPX1NUUkVFQk9HIGlzIG5v
dCBzZXQKIyBDT05GSUdfQ1JZUFRPX1ZNQUMgaXMgbm90IHNldAojIENPTkZJR19DUllQVE9f
V1A1MTIgaXMgbm90IHNldAojIENPTkZJR19DUllQVE9fWENCQyBpcyBub3Qgc2V0CkNPTkZJ
R19DUllQVE9fWFhIQVNIPW0KIyBlbmQgb2YgSGFzaGVzLCBkaWdlc3RzLCBhbmQgTUFDcwoK
IwojIENSQ3MgKGN5Y2xpYyByZWR1bmRhbmN5IGNoZWNrcykKIwpDT05GSUdfQ1JZUFRPX0NS
QzMyQz1tCiMgQ09ORklHX0NSWVBUT19DUkMzMiBpcyBub3Qgc2V0CkNPTkZJR19DUllQVE9f
Q1JDVDEwRElGPXkKQ09ORklHX0NSWVBUT19DUkM2NF9ST0NLU09GVD15CiMgZW5kIG9mIENS
Q3MgKGN5Y2xpYyByZWR1bmRhbmN5IGNoZWNrcykKCiMKIyBDb21wcmVzc2lvbgojCiMgQ09O
RklHX0NSWVBUT19ERUZMQVRFIGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRPX0xaTyBpcyBu
b3Qgc2V0CiMgQ09ORklHX0NSWVBUT184NDIgaXMgbm90IHNldAojIENPTkZJR19DUllQVE9f
TFo0IGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRPX0xaNEhDIGlzIG5vdCBzZXQKQ09ORklH
X0NSWVBUT19aU1REPXkKIyBlbmQgb2YgQ29tcHJlc3Npb24KCiMKIyBSYW5kb20gbnVtYmVy
IGdlbmVyYXRpb24KIwojIENPTkZJR19DUllQVE9fQU5TSV9DUFJORyBpcyBub3Qgc2V0CkNP
TkZJR19DUllQVE9fRFJCR19NRU5VPXkKQ09ORklHX0NSWVBUT19EUkJHX0hNQUM9eQpDT05G
SUdfQ1JZUFRPX0RSQkdfSEFTSD15CkNPTkZJR19DUllQVE9fRFJCR19DVFI9eQpDT05GSUdf
Q1JZUFRPX0RSQkc9eQpDT05GSUdfQ1JZUFRPX0pJVFRFUkVOVFJPUFk9eQpDT05GSUdfQ1JZ
UFRPX0pJVFRFUkVOVFJPUFlfTUVNT1JZX0JMT0NLUz02NApDT05GSUdfQ1JZUFRPX0pJVFRF
UkVOVFJPUFlfTUVNT1JZX0JMT0NLU0laRT0zMgpDT05GSUdfQ1JZUFRPX0pJVFRFUkVOVFJP
UFlfT1NSPTEKQ09ORklHX0NSWVBUT19LREY4MDAxMDhfQ1RSPXkKIyBlbmQgb2YgUmFuZG9t
IG51bWJlciBnZW5lcmF0aW9uCgojCiMgVXNlcnNwYWNlIGludGVyZmFjZQojCiMgQ09ORklH
X0NSWVBUT19VU0VSX0FQSV9IQVNIIGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRPX1VTRVJf
QVBJX1NLQ0lQSEVSIGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRPX1VTRVJfQVBJX1JORyBp
cyBub3Qgc2V0CiMgQ09ORklHX0NSWVBUT19VU0VSX0FQSV9BRUFEIGlzIG5vdCBzZXQKIyBl
bmQgb2YgVXNlcnNwYWNlIGludGVyZmFjZQoKQ09ORklHX0NSWVBUT19IQVNIX0lORk89eQoK
IwojIEFjY2VsZXJhdGVkIENyeXB0b2dyYXBoaWMgQWxnb3JpdGhtcyBmb3IgQ1BVICh4ODYp
CiMKQ09ORklHX0NSWVBUT19DVVJWRTI1NTE5X1g4Nj1tCkNPTkZJR19DUllQVE9fQUVTX05J
X0lOVEVMPW0KIyBDT05GSUdfQ1JZUFRPX0JMT1dGSVNIX1g4Nl82NCBpcyBub3Qgc2V0CiMg
Q09ORklHX0NSWVBUT19DQU1FTExJQV9YODZfNjQgaXMgbm90IHNldAojIENPTkZJR19DUllQ
VE9fQ0FNRUxMSUFfQUVTTklfQVZYX1g4Nl82NCBpcyBub3Qgc2V0CiMgQ09ORklHX0NSWVBU
T19DQU1FTExJQV9BRVNOSV9BVlgyX1g4Nl82NCBpcyBub3Qgc2V0CiMgQ09ORklHX0NSWVBU
T19DQVNUNV9BVlhfWDg2XzY0IGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRPX0NBU1Q2X0FW
WF9YODZfNjQgaXMgbm90IHNldAojIENPTkZJR19DUllQVE9fREVTM19FREVfWDg2XzY0IGlz
IG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRPX1NFUlBFTlRfU1NFMl9YODZfNjQgaXMgbm90IHNl
dAojIENPTkZJR19DUllQVE9fU0VSUEVOVF9BVlhfWDg2XzY0IGlzIG5vdCBzZXQKIyBDT05G
SUdfQ1JZUFRPX1NFUlBFTlRfQVZYMl9YODZfNjQgaXMgbm90IHNldAojIENPTkZJR19DUllQ
VE9fU000X0FFU05JX0FWWF9YODZfNjQgaXMgbm90IHNldAojIENPTkZJR19DUllQVE9fU000
X0FFU05JX0FWWDJfWDg2XzY0IGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRPX1RXT0ZJU0hf
WDg2XzY0IGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRPX1RXT0ZJU0hfWDg2XzY0XzNXQVkg
aXMgbm90IHNldAojIENPTkZJR19DUllQVE9fVFdPRklTSF9BVlhfWDg2XzY0IGlzIG5vdCBz
ZXQKIyBDT05GSUdfQ1JZUFRPX0FSSUFfQUVTTklfQVZYX1g4Nl82NCBpcyBub3Qgc2V0CiMg
Q09ORklHX0NSWVBUT19BUklBX0FFU05JX0FWWDJfWDg2XzY0IGlzIG5vdCBzZXQKIyBDT05G
SUdfQ1JZUFRPX0FSSUFfR0ZOSV9BVlg1MTJfWDg2XzY0IGlzIG5vdCBzZXQKQ09ORklHX0NS
WVBUT19DSEFDSEEyMF9YODZfNjQ9bQojIENPTkZJR19DUllQVE9fQUVHSVMxMjhfQUVTTklf
U1NFMiBpcyBub3Qgc2V0CiMgQ09ORklHX0NSWVBUT19OSFBPTFkxMzA1X1NTRTIgaXMgbm90
IHNldAojIENPTkZJR19DUllQVE9fTkhQT0xZMTMwNV9BVlgyIGlzIG5vdCBzZXQKQ09ORklH
X0NSWVBUT19CTEFLRTJTX1g4Nj15CkNPTkZJR19DUllQVE9fUE9MWVZBTF9DTE1VTF9OST1t
CkNPTkZJR19DUllQVE9fUE9MWTEzMDVfWDg2XzY0PW0KQ09ORklHX0NSWVBUT19TSEExX1NT
U0UzPW0KQ09ORklHX0NSWVBUT19TSEEyNTZfU1NTRTM9bQpDT05GSUdfQ1JZUFRPX1NIQTUx
Ml9TU1NFMz1tCiMgQ09ORklHX0NSWVBUT19TTTNfQVZYX1g4Nl82NCBpcyBub3Qgc2V0CkNP
TkZJR19DUllQVE9fR0hBU0hfQ0xNVUxfTklfSU5URUw9bQpDT05GSUdfQ1JZUFRPX0NSQzMy
Q19JTlRFTD1tCkNPTkZJR19DUllQVE9fQ1JDMzJfUENMTVVMPW0KQ09ORklHX0NSWVBUT19D
UkNUMTBESUZfUENMTVVMPW0KIyBlbmQgb2YgQWNjZWxlcmF0ZWQgQ3J5cHRvZ3JhcGhpYyBB
bGdvcml0aG1zIGZvciBDUFUgKHg4NikKCkNPTkZJR19DUllQVE9fSFc9eQojIENPTkZJR19D
UllQVE9fREVWX1BBRExPQ0sgaXMgbm90IHNldAojIENPTkZJR19DUllQVE9fREVWX0FUTUVM
X0VDQyBpcyBub3Qgc2V0CiMgQ09ORklHX0NSWVBUT19ERVZfQVRNRUxfU0hBMjA0QSBpcyBu
b3Qgc2V0CkNPTkZJR19DUllQVE9fREVWX0NDUD15CiMgQ09ORklHX0NSWVBUT19ERVZfQ0NQ
X0REIGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRPX0RFVl9OSVRST1hfQ05ONTVYWCBpcyBu
b3Qgc2V0CiMgQ09ORklHX0NSWVBUT19ERVZfUUFUX0RIODk1eENDIGlzIG5vdCBzZXQKIyBD
T05GSUdfQ1JZUFRPX0RFVl9RQVRfQzNYWFggaXMgbm90IHNldAojIENPTkZJR19DUllQVE9f
REVWX1FBVF9DNjJYIGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRPX0RFVl9RQVRfNFhYWCBp
cyBub3Qgc2V0CiMgQ09ORklHX0NSWVBUT19ERVZfUUFUXzQyMFhYIGlzIG5vdCBzZXQKIyBD
T05GSUdfQ1JZUFRPX0RFVl9RQVRfREg4OTV4Q0NWRiBpcyBub3Qgc2V0CiMgQ09ORklHX0NS
WVBUT19ERVZfUUFUX0MzWFhYVkYgaXMgbm90IHNldAojIENPTkZJR19DUllQVE9fREVWX1FB
VF9DNjJYVkYgaXMgbm90IHNldAojIENPTkZJR19DUllQVE9fREVWX1ZJUlRJTyBpcyBub3Qg
c2V0CiMgQ09ORklHX0NSWVBUT19ERVZfU0FGRVhDRUwgaXMgbm90IHNldAojIENPTkZJR19D
UllQVE9fREVWX0FNTE9HSUNfR1hMIGlzIG5vdCBzZXQKQ09ORklHX0FTWU1NRVRSSUNfS0VZ
X1RZUEU9eQpDT05GSUdfQVNZTU1FVFJJQ19QVUJMSUNfS0VZX1NVQlRZUEU9eQpDT05GSUdf
WDUwOV9DRVJUSUZJQ0FURV9QQVJTRVI9eQojIENPTkZJR19QS0NTOF9QUklWQVRFX0tFWV9Q
QVJTRVIgaXMgbm90IHNldApDT05GSUdfUEtDUzdfTUVTU0FHRV9QQVJTRVI9eQojIENPTkZJ
R19QS0NTN19URVNUX0tFWSBpcyBub3Qgc2V0CkNPTkZJR19TSUdORURfUEVfRklMRV9WRVJJ
RklDQVRJT049eQojIENPTkZJR19GSVBTX1NJR05BVFVSRV9TRUxGVEVTVCBpcyBub3Qgc2V0
CgojCiMgQ2VydGlmaWNhdGVzIGZvciBzaWduYXR1cmUgY2hlY2tpbmcKIwpDT05GSUdfTU9E
VUxFX1NJR19LRVk9ImNlcnRzL3NpZ25pbmdfa2V5LnBlbSIKIyBDT05GSUdfTU9EVUxFX1NJ
R19LRVlfVFlQRV9SU0EgaXMgbm90IHNldApDT05GSUdfTU9EVUxFX1NJR19LRVlfVFlQRV9F
Q0RTQT15CkNPTkZJR19TWVNURU1fVFJVU1RFRF9LRVlSSU5HPXkKQ09ORklHX1NZU1RFTV9U
UlVTVEVEX0tFWVM9IiIKIyBDT05GSUdfU1lTVEVNX0VYVFJBX0NFUlRJRklDQVRFIGlzIG5v
dCBzZXQKQ09ORklHX1NFQ09OREFSWV9UUlVTVEVEX0tFWVJJTkc9eQojIENPTkZJR19TRUNP
TkRBUllfVFJVU1RFRF9LRVlSSU5HX1NJR05FRF9CWV9CVUlMVElOIGlzIG5vdCBzZXQKQ09O
RklHX1NZU1RFTV9CTEFDS0xJU1RfS0VZUklORz15CkNPTkZJR19TWVNURU1fQkxBQ0tMSVNU
X0hBU0hfTElTVD0iIgpDT05GSUdfU1lTVEVNX1JFVk9DQVRJT05fTElTVD15CkNPTkZJR19T
WVNURU1fUkVWT0NBVElPTl9LRVlTPSIiCkNPTkZJR19TWVNURU1fQkxBQ0tMSVNUX0FVVEhf
VVBEQVRFPXkKIyBlbmQgb2YgQ2VydGlmaWNhdGVzIGZvciBzaWduYXR1cmUgY2hlY2tpbmcK
CkNPTkZJR19CSU5BUllfUFJJTlRGPXkKCiMKIyBMaWJyYXJ5IHJvdXRpbmVzCiMKQ09ORklH
X1JBSUQ2X1BRPW0KIyBDT05GSUdfUkFJRDZfUFFfQkVOQ0hNQVJLIGlzIG5vdCBzZXQKQ09O
RklHX0xJTkVBUl9SQU5HRVM9eQpDT05GSUdfUEFDS0lORz15CkNPTkZJR19CSVRSRVZFUlNF
PXkKQ09ORklHX0dFTkVSSUNfU1RSTkNQWV9GUk9NX1VTRVI9eQpDT05GSUdfR0VORVJJQ19T
VFJOTEVOX1VTRVI9eQpDT05GSUdfR0VORVJJQ19ORVRfVVRJTFM9eQojIENPTkZJR19DT1JE
SUMgaXMgbm90IHNldAojIENPTkZJR19QUklNRV9OVU1CRVJTIGlzIG5vdCBzZXQKQ09ORklH
X1JBVElPTkFMPXkKQ09ORklHX0dFTkVSSUNfUENJX0lPTUFQPXkKQ09ORklHX0dFTkVSSUNf
SU9NQVA9eQpDT05GSUdfQVJDSF9VU0VfQ01QWENIR19MT0NLUkVGPXkKQ09ORklHX0FSQ0hf
SEFTX0ZBU1RfTVVMVElQTElFUj15CkNPTkZJR19BUkNIX1VTRV9TWU1fQU5OT1RBVElPTlM9
eQoKIwojIENyeXB0byBsaWJyYXJ5IHJvdXRpbmVzCiMKQ09ORklHX0NSWVBUT19MSUJfVVRJ
TFM9eQpDT05GSUdfQ1JZUFRPX0xJQl9BRVM9eQpDT05GSUdfQ1JZUFRPX0xJQl9HRjEyOE1V
TD1tCkNPTkZJR19DUllQVE9fQVJDSF9IQVZFX0xJQl9CTEFLRTJTPXkKQ09ORklHX0NSWVBU
T19MSUJfQkxBS0UyU19HRU5FUklDPXkKQ09ORklHX0NSWVBUT19BUkNIX0hBVkVfTElCX0NI
QUNIQT1tCkNPTkZJR19DUllQVE9fTElCX0NIQUNIQV9HRU5FUklDPW0KQ09ORklHX0NSWVBU
T19MSUJfQ0hBQ0hBPW0KQ09ORklHX0NSWVBUT19BUkNIX0hBVkVfTElCX0NVUlZFMjU1MTk9
bQpDT05GSUdfQ1JZUFRPX0xJQl9DVVJWRTI1NTE5X0dFTkVSSUM9bQpDT05GSUdfQ1JZUFRP
X0xJQl9DVVJWRTI1NTE5PW0KQ09ORklHX0NSWVBUT19MSUJfUE9MWTEzMDVfUlNJWkU9MTEK
Q09ORklHX0NSWVBUT19BUkNIX0hBVkVfTElCX1BPTFkxMzA1PW0KQ09ORklHX0NSWVBUT19M
SUJfUE9MWTEzMDVfR0VORVJJQz1tCkNPTkZJR19DUllQVE9fTElCX1BPTFkxMzA1PW0KQ09O
RklHX0NSWVBUT19MSUJfQ0hBQ0hBMjBQT0xZMTMwNT1tCkNPTkZJR19DUllQVE9fTElCX1NI
QTE9eQpDT05GSUdfQ1JZUFRPX0xJQl9TSEEyNTY9eQojIGVuZCBvZiBDcnlwdG8gbGlicmFy
eSByb3V0aW5lcwoKQ09ORklHX0NSQ19DQ0lUVD15CiMgQ09ORklHX0NSQzE2IGlzIG5vdCBz
ZXQKQ09ORklHX0NSQ19UMTBESUY9eQpDT05GSUdfQ1JDNjRfUk9DS1NPRlQ9eQojIENPTkZJ
R19DUkNfSVRVX1QgaXMgbm90IHNldApDT05GSUdfQ1JDMzI9eQojIENPTkZJR19DUkMzMl9T
RUxGVEVTVCBpcyBub3Qgc2V0CkNPTkZJR19DUkMzMl9TTElDRUJZOD15CiMgQ09ORklHX0NS
QzMyX1NMSUNFQlk0IGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JDMzJfU0FSV0FURSBpcyBub3Qg
c2V0CiMgQ09ORklHX0NSQzMyX0JJVCBpcyBub3Qgc2V0CkNPTkZJR19DUkM2ND15CiMgQ09O
RklHX0NSQzQgaXMgbm90IHNldAojIENPTkZJR19DUkM3IGlzIG5vdCBzZXQKQ09ORklHX0xJ
QkNSQzMyQz1tCiMgQ09ORklHX0NSQzggaXMgbm90IHNldApDT05GSUdfWFhIQVNIPXkKIyBD
T05GSUdfUkFORE9NMzJfU0VMRlRFU1QgaXMgbm90IHNldApDT05GSUdfWkxJQl9JTkZMQVRF
PXkKQ09ORklHX1pMSUJfREVGTEFURT15CkNPTkZJR19MWk9fQ09NUFJFU1M9bQpDT05GSUdf
TFpPX0RFQ09NUFJFU1M9eQpDT05GSUdfTFo0X0RFQ09NUFJFU1M9eQpDT05GSUdfWlNURF9D
T01NT049eQpDT05GSUdfWlNURF9DT01QUkVTUz15CkNPTkZJR19aU1REX0RFQ09NUFJFU1M9
eQpDT05GSUdfWFpfREVDPXkKQ09ORklHX1haX0RFQ19YODY9eQpDT05GSUdfWFpfREVDX1BP
V0VSUEM9eQpDT05GSUdfWFpfREVDX0FSTT15CkNPTkZJR19YWl9ERUNfQVJNVEhVTUI9eQpD
T05GSUdfWFpfREVDX1NQQVJDPXkKQ09ORklHX1haX0RFQ19NSUNST0xaTUE9eQpDT05GSUdf
WFpfREVDX0JDSj15CiMgQ09ORklHX1haX0RFQ19URVNUIGlzIG5vdCBzZXQKQ09ORklHX0RF
Q09NUFJFU1NfR1pJUD15CkNPTkZJR19ERUNPTVBSRVNTX0JaSVAyPXkKQ09ORklHX0RFQ09N
UFJFU1NfTFpNQT15CkNPTkZJR19ERUNPTVBSRVNTX1haPXkKQ09ORklHX0RFQ09NUFJFU1Nf
TFpPPXkKQ09ORklHX0RFQ09NUFJFU1NfTFo0PXkKQ09ORklHX0RFQ09NUFJFU1NfWlNURD15
CkNPTkZJR19HRU5FUklDX0FMTE9DQVRPUj15CkNPTkZJR19JTlRFUlZBTF9UUkVFPXkKQ09O
RklHX1hBUlJBWV9NVUxUST15CkNPTkZJR19BU1NPQ0lBVElWRV9BUlJBWT15CkNPTkZJR19I
QVNfSU9NRU09eQpDT05GSUdfSEFTX0lPUE9SVD15CkNPTkZJR19IQVNfSU9QT1JUX01BUD15
CkNPTkZJR19IQVNfRE1BPXkKQ09ORklHX0RNQV9PUFM9eQpDT05GSUdfTkVFRF9TR19ETUFf
RkxBR1M9eQpDT05GSUdfTkVFRF9TR19ETUFfTEVOR1RIPXkKQ09ORklHX05FRURfRE1BX01B
UF9TVEFURT15CkNPTkZJR19BUkNIX0RNQV9BRERSX1RfNjRCSVQ9eQpDT05GSUdfQVJDSF9I
QVNfRk9SQ0VfRE1BX1VORU5DUllQVEVEPXkKQ09ORklHX1NXSU9UTEI9eQojIENPTkZJR19T
V0lPVExCX0RZTkFNSUMgaXMgbm90IHNldApDT05GSUdfRE1BX0NPSEVSRU5UX1BPT0w9eQpD
T05GSUdfRE1BX0NNQT15CiMgQ09ORklHX0RNQV9OVU1BX0NNQSBpcyBub3Qgc2V0CgojCiMg
RGVmYXVsdCBjb250aWd1b3VzIG1lbW9yeSBhcmVhIHNpemU6CiMKQ09ORklHX0NNQV9TSVpF
X01CWVRFUz0wCkNPTkZJR19DTUFfU0laRV9TRUxfTUJZVEVTPXkKIyBDT05GSUdfQ01BX1NJ
WkVfU0VMX1BFUkNFTlRBR0UgaXMgbm90IHNldAojIENPTkZJR19DTUFfU0laRV9TRUxfTUlO
IGlzIG5vdCBzZXQKIyBDT05GSUdfQ01BX1NJWkVfU0VMX01BWCBpcyBub3Qgc2V0CkNPTkZJ
R19DTUFfQUxJR05NRU5UPTgKIyBDT05GSUdfRE1BX0FQSV9ERUJVRyBpcyBub3Qgc2V0CiMg
Q09ORklHX0RNQV9NQVBfQkVOQ0hNQVJLIGlzIG5vdCBzZXQKQ09ORklHX1NHTF9BTExPQz15
CkNPTkZJR19DSEVDS19TSUdOQVRVUkU9eQpDT05GSUdfQ1BVX1JNQVA9eQpDT05GSUdfRFFM
PXkKQ09ORklHX0dMT0I9eQojIENPTkZJR19HTE9CX1NFTEZURVNUIGlzIG5vdCBzZXQKQ09O
RklHX05MQVRUUj15CkNPTkZJR19DTFpfVEFCPXkKQ09ORklHX0lSUV9QT0xMPXkKQ09ORklH
X01QSUxJQj15CkNPTkZJR19TSUdOQVRVUkU9eQpDT05GSUdfRElNTElCPXkKQ09ORklHX09J
RF9SRUdJU1RSWT15CkNPTkZJR19VQ1MyX1NUUklORz15CkNPTkZJR19IQVZFX0dFTkVSSUNf
VkRTTz15CkNPTkZJR19HRU5FUklDX0dFVFRJTUVPRkRBWT15CkNPTkZJR19HRU5FUklDX1ZE
U09fVElNRV9OUz15CkNPTkZJR19GT05UX1NVUFBPUlQ9eQpDT05GSUdfRk9OVFM9eQojIENP
TkZJR19GT05UXzh4OCBpcyBub3Qgc2V0CkNPTkZJR19GT05UXzh4MTY9eQojIENPTkZJR19G
T05UXzZ4MTEgaXMgbm90IHNldAojIENPTkZJR19GT05UXzd4MTQgaXMgbm90IHNldAojIENP
TkZJR19GT05UX1BFQVJMXzh4OCBpcyBub3Qgc2V0CiMgQ09ORklHX0ZPTlRfQUNPUk5fOHg4
IGlzIG5vdCBzZXQKIyBDT05GSUdfRk9OVF9NSU5JXzR4NiBpcyBub3Qgc2V0CiMgQ09ORklH
X0ZPTlRfNngxMCBpcyBub3Qgc2V0CiMgQ09ORklHX0ZPTlRfMTB4MTggaXMgbm90IHNldAoj
IENPTkZJR19GT05UX1NVTjh4MTYgaXMgbm90IHNldAojIENPTkZJR19GT05UX1NVTjEyeDIy
IGlzIG5vdCBzZXQKQ09ORklHX0ZPTlRfVEVSMTZ4MzI9eQojIENPTkZJR19GT05UXzZ4OCBp
cyBub3Qgc2V0CkNPTkZJR19TR19QT09MPXkKQ09ORklHX0FSQ0hfSEFTX1BNRU1fQVBJPXkK
Q09ORklHX01FTVJFR0lPTj15CkNPTkZJR19BUkNIX0hBU19DUFVfQ0FDSEVfSU5WQUxJREFU
RV9NRU1SRUdJT049eQpDT05GSUdfQVJDSF9IQVNfVUFDQ0VTU19GTFVTSENBQ0hFPXkKQ09O
RklHX0FSQ0hfSEFTX0NPUFlfTUM9eQpDT05GSUdfQVJDSF9TVEFDS1dBTEs9eQpDT05GSUdf
U1RBQ0tERVBPVD15CkNPTkZJR19TVEFDS0RFUE9UX01BWF9GUkFNRVM9NjQKQ09ORklHX1NC
SVRNQVA9eQojIENPTkZJR19MV1FfVEVTVCBpcyBub3Qgc2V0CiMgZW5kIG9mIExpYnJhcnkg
cm91dGluZXMKCkNPTkZJR19GSVJNV0FSRV9UQUJMRT15CgojCiMgS2VybmVsIGhhY2tpbmcK
IwoKIwojIHByaW50ayBhbmQgZG1lc2cgb3B0aW9ucwojCkNPTkZJR19QUklOVEtfVElNRT15
CiMgQ09ORklHX1BSSU5US19DQUxMRVIgaXMgbm90IHNldAojIENPTkZJR19TVEFDS1RSQUNF
X0JVSUxEX0lEIGlzIG5vdCBzZXQKQ09ORklHX0NPTlNPTEVfTE9HTEVWRUxfREVGQVVMVD00
CkNPTkZJR19DT05TT0xFX0xPR0xFVkVMX1FVSUVUPTEKQ09ORklHX01FU1NBR0VfTE9HTEVW
RUxfREVGQVVMVD00CkNPTkZJR19CT09UX1BSSU5US19ERUxBWT15CkNPTkZJR19EWU5BTUlD
X0RFQlVHPXkKQ09ORklHX0RZTkFNSUNfREVCVUdfQ09SRT15CkNPTkZJR19TWU1CT0xJQ19F
UlJOQU1FPXkKQ09ORklHX0RFQlVHX0JVR1ZFUkJPU0U9eQojIGVuZCBvZiBwcmludGsgYW5k
IGRtZXNnIG9wdGlvbnMKCkNPTkZJR19ERUJVR19LRVJORUw9eQpDT05GSUdfREVCVUdfTUlT
Qz15CgojCiMgQ29tcGlsZS10aW1lIGNoZWNrcyBhbmQgY29tcGlsZXIgb3B0aW9ucwojCkNP
TkZJR19BU19IQVNfTk9OX0NPTlNUX1VMRUIxMjg9eQpDT05GSUdfREVCVUdfSU5GT19OT05F
PXkKIyBDT05GSUdfREVCVUdfSU5GT19EV0FSRl9UT09MQ0hBSU5fREVGQVVMVCBpcyBub3Qg
c2V0CiMgQ09ORklHX0RFQlVHX0lORk9fRFdBUkY0IGlzIG5vdCBzZXQKIyBDT05GSUdfREVC
VUdfSU5GT19EV0FSRjUgaXMgbm90IHNldApDT05GSUdfRlJBTUVfV0FSTj0yMDQ4CkNPTkZJ
R19TVFJJUF9BU01fU1lNUz15CiMgQ09ORklHX1JFQURBQkxFX0FTTSBpcyBub3Qgc2V0CiMg
Q09ORklHX0hFQURFUlNfSU5TVEFMTCBpcyBub3Qgc2V0CiMgQ09ORklHX0RFQlVHX1NFQ1RJ
T05fTUlTTUFUQ0ggaXMgbm90IHNldApDT05GSUdfU0VDVElPTl9NSVNNQVRDSF9XQVJOX09O
TFk9eQpDT05GSUdfT0JKVE9PTD15CiMgQ09ORklHX0RFQlVHX0ZPUkNFX1dFQUtfUEVSX0NQ
VSBpcyBub3Qgc2V0CiMgZW5kIG9mIENvbXBpbGUtdGltZSBjaGVja3MgYW5kIGNvbXBpbGVy
IG9wdGlvbnMKCiMKIyBHZW5lcmljIEtlcm5lbCBEZWJ1Z2dpbmcgSW5zdHJ1bWVudHMKIwpD
T05GSUdfTUFHSUNfU1lTUlE9eQpDT05GSUdfTUFHSUNfU1lTUlFfREVGQVVMVF9FTkFCTEU9
MHgwCkNPTkZJR19NQUdJQ19TWVNSUV9TRVJJQUw9eQpDT05GSUdfTUFHSUNfU1lTUlFfU0VS
SUFMX1NFUVVFTkNFPSIiCkNPTkZJR19ERUJVR19GUz15CiMgQ09ORklHX0RFQlVHX0ZTX0FM
TE9XX0FMTCBpcyBub3Qgc2V0CiMgQ09ORklHX0RFQlVHX0ZTX0RJU0FMTE9XX01PVU5UIGlz
IG5vdCBzZXQKQ09ORklHX0RFQlVHX0ZTX0FMTE9XX05PTkU9eQpDT05GSUdfSEFWRV9BUkNI
X0tHREI9eQojIENPTkZJR19LR0RCIGlzIG5vdCBzZXQKQ09ORklHX0FSQ0hfSEFTX1VCU0FO
X1NBTklUSVpFX0FMTD15CiMgQ09ORklHX1VCU0FOIGlzIG5vdCBzZXQKQ09ORklHX0hBVkVf
QVJDSF9LQ1NBTj15CkNPTkZJR19IQVZFX0tDU0FOX0NPTVBJTEVSPXkKIyBDT05GSUdfS0NT
QU4gaXMgbm90IHNldAojIGVuZCBvZiBHZW5lcmljIEtlcm5lbCBEZWJ1Z2dpbmcgSW5zdHJ1
bWVudHMKCiMKIyBOZXR3b3JraW5nIERlYnVnZ2luZwojCiMgQ09ORklHX05FVF9ERVZfUkVG
Q05UX1RSQUNLRVIgaXMgbm90IHNldAojIENPTkZJR19ORVRfTlNfUkVGQ05UX1RSQUNLRVIg
aXMgbm90IHNldAojIENPTkZJR19ERUJVR19ORVQgaXMgbm90IHNldAojIGVuZCBvZiBOZXR3
b3JraW5nIERlYnVnZ2luZwoKIwojIE1lbW9yeSBEZWJ1Z2dpbmcKIwojIENPTkZJR19QQUdF
X0VYVEVOU0lPTiBpcyBub3Qgc2V0CiMgQ09ORklHX0RFQlVHX1BBR0VBTExPQyBpcyBub3Qg
c2V0CkNPTkZJR19TTFVCX0RFQlVHPXkKIyBDT05GSUdfU0xVQl9ERUJVR19PTiBpcyBub3Qg
c2V0CiMgQ09ORklHX1BBR0VfT1dORVIgaXMgbm90IHNldAojIENPTkZJR19QQUdFX1RBQkxF
X0NIRUNLIGlzIG5vdCBzZXQKIyBDT05GSUdfUEFHRV9QT0lTT05JTkcgaXMgbm90IHNldAoj
IENPTkZJR19ERUJVR19QQUdFX1JFRiBpcyBub3Qgc2V0CkNPTkZJR19ERUJVR19ST0RBVEFf
VEVTVD15CkNPTkZJR19BUkNIX0hBU19ERUJVR19XWD15CkNPTkZJR19ERUJVR19XWD15CkNP
TkZJR19HRU5FUklDX1BURFVNUD15CkNPTkZJR19QVERVTVBfQ09SRT15CiMgQ09ORklHX1BU
RFVNUF9ERUJVR0ZTIGlzIG5vdCBzZXQKQ09ORklHX0hBVkVfREVCVUdfS01FTUxFQUs9eQoj
IENPTkZJR19ERUJVR19LTUVNTEVBSyBpcyBub3Qgc2V0CiMgQ09ORklHX1BFUl9WTUFfTE9D
S19TVEFUUyBpcyBub3Qgc2V0CiMgQ09ORklHX0RFQlVHX09CSkVDVFMgaXMgbm90IHNldApD
T05GSUdfU0hSSU5LRVJfREVCVUc9eQojIENPTkZJR19ERUJVR19TVEFDS19VU0FHRSBpcyBu
b3Qgc2V0CkNPTkZJR19TQ0hFRF9TVEFDS19FTkRfQ0hFQ0s9eQpDT05GSUdfQVJDSF9IQVNf
REVCVUdfVk1fUEdUQUJMRT15CkNPTkZJR19ERUJVR19WTV9JUlFTT0ZGPXkKQ09ORklHX0RF
QlVHX1ZNPXkKIyBDT05GSUdfREVCVUdfVk1fTUFQTEVfVFJFRSBpcyBub3Qgc2V0CiMgQ09O
RklHX0RFQlVHX1ZNX1JCIGlzIG5vdCBzZXQKIyBDT05GSUdfREVCVUdfVk1fUEdGTEFHUyBp
cyBub3Qgc2V0CiMgQ09ORklHX0RFQlVHX1ZNX1BHVEFCTEUgaXMgbm90IHNldApDT05GSUdf
QVJDSF9IQVNfREVCVUdfVklSVFVBTD15CkNPTkZJR19ERUJVR19WSVJUVUFMPXkKQ09ORklH
X0RFQlVHX01FTU9SWV9JTklUPXkKIyBDT05GSUdfREVCVUdfUEVSX0NQVV9NQVBTIGlzIG5v
dCBzZXQKQ09ORklHX0FSQ0hfU1VQUE9SVFNfS01BUF9MT0NBTF9GT1JDRV9NQVA9eQojIENP
TkZJR19ERUJVR19LTUFQX0xPQ0FMX0ZPUkNFX01BUCBpcyBub3Qgc2V0CkNPTkZJR19IQVZF
X0FSQ0hfS0FTQU49eQpDT05GSUdfSEFWRV9BUkNIX0tBU0FOX1ZNQUxMT0M9eQpDT05GSUdf
Q0NfSEFTX0tBU0FOX0dFTkVSSUM9eQpDT05GSUdfQ0NfSEFTX1dPUktJTkdfTk9TQU5JVEla
RV9BRERSRVNTPXkKIyBDT05GSUdfS0FTQU4gaXMgbm90IHNldApDT05GSUdfSEFWRV9BUkNI
X0tGRU5DRT15CkNPTkZJR19LRkVOQ0U9eQpDT05GSUdfS0ZFTkNFX1NBTVBMRV9JTlRFUlZB
TD0xMDAKQ09ORklHX0tGRU5DRV9OVU1fT0JKRUNUUz0yNTUKQ09ORklHX0tGRU5DRV9ERUZF
UlJBQkxFPXkKQ09ORklHX0tGRU5DRV9TVFJFU1NfVEVTVF9GQVVMVFM9MApDT05GSUdfSEFW
RV9BUkNIX0tNU0FOPXkKIyBlbmQgb2YgTWVtb3J5IERlYnVnZ2luZwoKQ09ORklHX0RFQlVH
X1NISVJRPXkKCiMKIyBEZWJ1ZyBPb3BzLCBMb2NrdXBzIGFuZCBIYW5ncwojCkNPTkZJR19Q
QU5JQ19PTl9PT1BTPXkKQ09ORklHX1BBTklDX09OX09PUFNfVkFMVUU9MQpDT05GSUdfUEFO
SUNfVElNRU9VVD0wCkNPTkZJR19MT0NLVVBfREVURUNUT1I9eQpDT05GSUdfU09GVExPQ0tV
UF9ERVRFQ1RPUj15CiMgQ09ORklHX0JPT1RQQVJBTV9TT0ZUTE9DS1VQX1BBTklDIGlzIG5v
dCBzZXQKQ09ORklHX0hBVkVfSEFSRExPQ0tVUF9ERVRFQ1RPUl9CVUREWT15CkNPTkZJR19I
QVJETE9DS1VQX0RFVEVDVE9SPXkKIyBDT05GSUdfSEFSRExPQ0tVUF9ERVRFQ1RPUl9QUkVG
RVJfQlVERFkgaXMgbm90IHNldApDT05GSUdfSEFSRExPQ0tVUF9ERVRFQ1RPUl9QRVJGPXkK
IyBDT05GSUdfSEFSRExPQ0tVUF9ERVRFQ1RPUl9CVUREWSBpcyBub3Qgc2V0CiMgQ09ORklH
X0hBUkRMT0NLVVBfREVURUNUT1JfQVJDSCBpcyBub3Qgc2V0CkNPTkZJR19IQVJETE9DS1VQ
X0RFVEVDVE9SX0NPVU5UU19IUlRJTUVSPXkKQ09ORklHX0hBUkRMT0NLVVBfQ0hFQ0tfVElN
RVNUQU1QPXkKIyBDT05GSUdfQk9PVFBBUkFNX0hBUkRMT0NLVVBfUEFOSUMgaXMgbm90IHNl
dApDT05GSUdfREVURUNUX0hVTkdfVEFTSz15CkNPTkZJR19ERUZBVUxUX0hVTkdfVEFTS19U
SU1FT1VUPTEyMAojIENPTkZJR19CT09UUEFSQU1fSFVOR19UQVNLX1BBTklDIGlzIG5vdCBz
ZXQKIyBDT05GSUdfV1FfV0FUQ0hET0cgaXMgbm90IHNldAojIENPTkZJR19XUV9DUFVfSU5U
RU5TSVZFX1JFUE9SVCBpcyBub3Qgc2V0CiMgQ09ORklHX1RFU1RfTE9DS1VQIGlzIG5vdCBz
ZXQKIyBlbmQgb2YgRGVidWcgT29wcywgTG9ja3VwcyBhbmQgSGFuZ3MKCiMKIyBTY2hlZHVs
ZXIgRGVidWdnaW5nCiMKQ09ORklHX1NDSEVEX0RFQlVHPXkKQ09ORklHX1NDSEVEX0lORk89
eQpDT05GSUdfU0NIRURTVEFUUz15CiMgZW5kIG9mIFNjaGVkdWxlciBEZWJ1Z2dpbmcKCiMg
Q09ORklHX0RFQlVHX1RJTUVLRUVQSU5HIGlzIG5vdCBzZXQKQ09ORklHX0RFQlVHX1BSRUVN
UFQ9eQoKIwojIExvY2sgRGVidWdnaW5nIChzcGlubG9ja3MsIG11dGV4ZXMsIGV0Yy4uLikK
IwpDT05GSUdfTE9DS19ERUJVR0dJTkdfU1VQUE9SVD15CiMgQ09ORklHX1BST1ZFX0xPQ0tJ
TkcgaXMgbm90IHNldAojIENPTkZJR19MT0NLX1NUQVQgaXMgbm90IHNldAojIENPTkZJR19E
RUJVR19SVF9NVVRFWEVTIGlzIG5vdCBzZXQKIyBDT05GSUdfREVCVUdfU1BJTkxPQ0sgaXMg
bm90IHNldAojIENPTkZJR19ERUJVR19NVVRFWEVTIGlzIG5vdCBzZXQKIyBDT05GSUdfREVC
VUdfV1dfTVVURVhfU0xPV1BBVEggaXMgbm90IHNldAojIENPTkZJR19ERUJVR19SV1NFTVMg
aXMgbm90IHNldAojIENPTkZJR19ERUJVR19MT0NLX0FMTE9DIGlzIG5vdCBzZXQKIyBDT05G
SUdfREVCVUdfQVRPTUlDX1NMRUVQIGlzIG5vdCBzZXQKIyBDT05GSUdfREVCVUdfTE9DS0lO
R19BUElfU0VMRlRFU1RTIGlzIG5vdCBzZXQKIyBDT05GSUdfTE9DS19UT1JUVVJFX1RFU1Qg
aXMgbm90IHNldAojIENPTkZJR19XV19NVVRFWF9TRUxGVEVTVCBpcyBub3Qgc2V0CiMgQ09O
RklHX1NDRl9UT1JUVVJFX1RFU1QgaXMgbm90IHNldAojIENPTkZJR19DU0RfTE9DS19XQUlU
X0RFQlVHIGlzIG5vdCBzZXQKIyBlbmQgb2YgTG9jayBEZWJ1Z2dpbmcgKHNwaW5sb2Nrcywg
bXV0ZXhlcywgZXRjLi4uKQoKIyBDT05GSUdfTk1JX0NIRUNLX0NQVSBpcyBub3Qgc2V0CiMg
Q09ORklHX0RFQlVHX0lSUUZMQUdTIGlzIG5vdCBzZXQKQ09ORklHX1NUQUNLVFJBQ0U9eQoj
IENPTkZJR19XQVJOX0FMTF9VTlNFRURFRF9SQU5ET00gaXMgbm90IHNldAojIENPTkZJR19E
RUJVR19LT0JKRUNUIGlzIG5vdCBzZXQKCiMKIyBEZWJ1ZyBrZXJuZWwgZGF0YSBzdHJ1Y3R1
cmVzCiMKQ09ORklHX0RFQlVHX0xJU1Q9eQojIENPTkZJR19ERUJVR19QTElTVCBpcyBub3Qg
c2V0CkNPTkZJR19ERUJVR19TRz15CkNPTkZJR19ERUJVR19OT1RJRklFUlM9eQojIENPTkZJ
R19ERUJVR19NQVBMRV9UUkVFIGlzIG5vdCBzZXQKIyBlbmQgb2YgRGVidWcga2VybmVsIGRh
dGEgc3RydWN0dXJlcwoKIwojIFJDVSBEZWJ1Z2dpbmcKIwojIENPTkZJR19SQ1VfU0NBTEVf
VEVTVCBpcyBub3Qgc2V0CiMgQ09ORklHX1JDVV9UT1JUVVJFX1RFU1QgaXMgbm90IHNldAoj
IENPTkZJR19SQ1VfUkVGX1NDQUxFX1RFU1QgaXMgbm90IHNldApDT05GSUdfUkNVX0NQVV9T
VEFMTF9USU1FT1VUPTYwCkNPTkZJR19SQ1VfRVhQX0NQVV9TVEFMTF9USU1FT1VUPTAKIyBD
T05GSUdfUkNVX0NQVV9TVEFMTF9DUFVUSU1FIGlzIG5vdCBzZXQKIyBDT05GSUdfUkNVX0NQ
VV9TVEFMTF9OT1RJRklFUiBpcyBub3Qgc2V0CiMgQ09ORklHX1JDVV9UUkFDRSBpcyBub3Qg
c2V0CiMgQ09ORklHX1JDVV9FUVNfREVCVUcgaXMgbm90IHNldAojIGVuZCBvZiBSQ1UgRGVi
dWdnaW5nCgojIENPTkZJR19ERUJVR19XUV9GT1JDRV9SUl9DUFUgaXMgbm90IHNldAojIENP
TkZJR19DUFVfSE9UUExVR19TVEFURV9DT05UUk9MIGlzIG5vdCBzZXQKQ09ORklHX0xBVEVO
Q1lUT1A9eQojIENPTkZJR19ERUJVR19DR1JPVVBfUkVGIGlzIG5vdCBzZXQKQ09ORklHX1VT
RVJfU1RBQ0tUUkFDRV9TVVBQT1JUPXkKQ09ORklHX05PUF9UUkFDRVI9eQpDT05GSUdfSEFW
RV9SRVRIT09LPXkKQ09ORklHX1JFVEhPT0s9eQpDT05GSUdfSEFWRV9GVU5DVElPTl9UUkFD
RVI9eQpDT05GSUdfSEFWRV9GVU5DVElPTl9HUkFQSF9UUkFDRVI9eQpDT05GSUdfSEFWRV9G
VU5DVElPTl9HUkFQSF9SRVRWQUw9eQpDT05GSUdfSEFWRV9EWU5BTUlDX0ZUUkFDRT15CkNP
TkZJR19IQVZFX0RZTkFNSUNfRlRSQUNFX1dJVEhfUkVHUz15CkNPTkZJR19IQVZFX0RZTkFN
SUNfRlRSQUNFX1dJVEhfRElSRUNUX0NBTExTPXkKQ09ORklHX0hBVkVfRFlOQU1JQ19GVFJB
Q0VfV0lUSF9BUkdTPXkKQ09ORklHX0hBVkVfRFlOQU1JQ19GVFJBQ0VfTk9fUEFUQ0hBQkxF
PXkKQ09ORklHX0hBVkVfRlRSQUNFX01DT1VOVF9SRUNPUkQ9eQpDT05GSUdfSEFWRV9TWVND
QUxMX1RSQUNFUE9JTlRTPXkKQ09ORklHX0hBVkVfRkVOVFJZPXkKQ09ORklHX0hBVkVfT0JK
VE9PTF9NQ09VTlQ9eQpDT05GSUdfSEFWRV9PQkpUT09MX05PUF9NQ09VTlQ9eQpDT05GSUdf
SEFWRV9DX1JFQ09SRE1DT1VOVD15CkNPTkZJR19IQVZFX0JVSUxEVElNRV9NQ09VTlRfU09S
VD15CkNPTkZJR19CVUlMRFRJTUVfTUNPVU5UX1NPUlQ9eQpDT05GSUdfVFJBQ0VSX01BWF9U
UkFDRT15CkNPTkZJR19UUkFDRV9DTE9DSz15CkNPTkZJR19SSU5HX0JVRkZFUj15CkNPTkZJ
R19FVkVOVF9UUkFDSU5HPXkKQ09ORklHX0NPTlRFWFRfU1dJVENIX1RSQUNFUj15CkNPTkZJ
R19UUkFDSU5HPXkKQ09ORklHX0dFTkVSSUNfVFJBQ0VSPXkKQ09ORklHX1RSQUNJTkdfU1VQ
UE9SVD15CkNPTkZJR19GVFJBQ0U9eQojIENPTkZJR19CT09UVElNRV9UUkFDSU5HIGlzIG5v
dCBzZXQKQ09ORklHX0ZVTkNUSU9OX1RSQUNFUj15CkNPTkZJR19GVU5DVElPTl9HUkFQSF9U
UkFDRVI9eQpDT05GSUdfRlVOQ1RJT05fR1JBUEhfUkVUVkFMPXkKQ09ORklHX0RZTkFNSUNf
RlRSQUNFPXkKQ09ORklHX0RZTkFNSUNfRlRSQUNFX1dJVEhfUkVHUz15CkNPTkZJR19EWU5B
TUlDX0ZUUkFDRV9XSVRIX0RJUkVDVF9DQUxMUz15CkNPTkZJR19EWU5BTUlDX0ZUUkFDRV9X
SVRIX0FSR1M9eQpDT05GSUdfRlBST0JFPXkKQ09ORklHX0ZVTkNUSU9OX1BST0ZJTEVSPXkK
Q09ORklHX1NUQUNLX1RSQUNFUj15CiMgQ09ORklHX0lSUVNPRkZfVFJBQ0VSIGlzIG5vdCBz
ZXQKIyBDT05GSUdfUFJFRU1QVF9UUkFDRVIgaXMgbm90IHNldApDT05GSUdfU0NIRURfVFJB
Q0VSPXkKQ09ORklHX0hXTEFUX1RSQUNFUj15CkNPTkZJR19PU05PSVNFX1RSQUNFUj15CkNP
TkZJR19USU1FUkxBVF9UUkFDRVI9eQpDT05GSUdfTU1JT1RSQUNFPXkKQ09ORklHX0ZUUkFD
RV9TWVNDQUxMUz15CkNPTkZJR19UUkFDRVJfU05BUFNIT1Q9eQojIENPTkZJR19UUkFDRVJf
U05BUFNIT1RfUEVSX0NQVV9TV0FQIGlzIG5vdCBzZXQKQ09ORklHX0JSQU5DSF9QUk9GSUxF
X05PTkU9eQojIENPTkZJR19QUk9GSUxFX0FOTk9UQVRFRF9CUkFOQ0hFUyBpcyBub3Qgc2V0
CkNPTkZJR19CTEtfREVWX0lPX1RSQUNFPXkKQ09ORklHX0ZQUk9CRV9FVkVOVFM9eQpDT05G
SUdfS1BST0JFX0VWRU5UUz15CiMgQ09ORklHX0tQUk9CRV9FVkVOVFNfT05fTk9UUkFDRSBp
cyBub3Qgc2V0CkNPTkZJR19VUFJPQkVfRVZFTlRTPXkKQ09ORklHX0JQRl9FVkVOVFM9eQpD
T05GSUdfRFlOQU1JQ19FVkVOVFM9eQpDT05GSUdfUFJPQkVfRVZFTlRTPXkKIyBDT05GSUdf
QlBGX0tQUk9CRV9PVkVSUklERSBpcyBub3Qgc2V0CkNPTkZJR19GVFJBQ0VfTUNPVU5UX1JF
Q09SRD15CkNPTkZJR19GVFJBQ0VfTUNPVU5UX1VTRV9DQz15CkNPTkZJR19TWU5USF9FVkVO
VFM9eQojIENPTkZJR19VU0VSX0VWRU5UUyBpcyBub3Qgc2V0CiMgQ09ORklHX0hJU1RfVFJJ
R0dFUlMgaXMgbm90IHNldAojIENPTkZJR19UUkFDRV9FVkVOVF9JTkpFQ1QgaXMgbm90IHNl
dAojIENPTkZJR19UUkFDRVBPSU5UX0JFTkNITUFSSyBpcyBub3Qgc2V0CiMgQ09ORklHX1JJ
TkdfQlVGRkVSX0JFTkNITUFSSyBpcyBub3Qgc2V0CiMgQ09ORklHX1RSQUNFX0VWQUxfTUFQ
X0ZJTEUgaXMgbm90IHNldAojIENPTkZJR19GVFJBQ0VfUkVDT1JEX1JFQ1VSU0lPTiBpcyBu
b3Qgc2V0CiMgQ09ORklHX0ZUUkFDRV9TVEFSVFVQX1RFU1QgaXMgbm90IHNldAojIENPTkZJ
R19GVFJBQ0VfU09SVF9TVEFSVFVQX1RFU1QgaXMgbm90IHNldAojIENPTkZJR19SSU5HX0JV
RkZFUl9TVEFSVFVQX1RFU1QgaXMgbm90IHNldAojIENPTkZJR19SSU5HX0JVRkZFUl9WQUxJ
REFURV9USU1FX0RFTFRBUyBpcyBub3Qgc2V0CiMgQ09ORklHX01NSU9UUkFDRV9URVNUIGlz
IG5vdCBzZXQKIyBDT05GSUdfUFJFRU1QVElSUV9ERUxBWV9URVNUIGlzIG5vdCBzZXQKIyBD
T05GSUdfU1lOVEhfRVZFTlRfR0VOX1RFU1QgaXMgbm90IHNldAojIENPTkZJR19LUFJPQkVf
RVZFTlRfR0VOX1RFU1QgaXMgbm90IHNldAojIENPTkZJR19SViBpcyBub3Qgc2V0CiMgQ09O
RklHX1BST1ZJREVfT0hDSTEzOTRfRE1BX0lOSVQgaXMgbm90IHNldAojIENPTkZJR19TQU1Q
TEVTIGlzIG5vdCBzZXQKQ09ORklHX0hBVkVfU0FNUExFX0ZUUkFDRV9ESVJFQ1Q9eQpDT05G
SUdfSEFWRV9TQU1QTEVfRlRSQUNFX0RJUkVDVF9NVUxUST15CkNPTkZJR19BUkNIX0hBU19E
RVZNRU1fSVNfQUxMT1dFRD15CiMgQ09ORklHX1NUUklDVF9ERVZNRU0gaXMgbm90IHNldAoK
IwojIHg4NiBEZWJ1Z2dpbmcKIwojIENPTkZJR19YODZfVkVSQk9TRV9CT09UVVAgaXMgbm90
IHNldApDT05GSUdfRUFSTFlfUFJJTlRLPXkKIyBDT05GSUdfRUFSTFlfUFJJTlRLX0RCR1Ag
aXMgbm90IHNldAojIENPTkZJR19FQVJMWV9QUklOVEtfVVNCX1hEQkMgaXMgbm90IHNldAoj
IENPTkZJR19FRklfUEdUX0RVTVAgaXMgbm90IHNldAojIENPTkZJR19ERUJVR19UTEJGTFVT
SCBpcyBub3Qgc2V0CkNPTkZJR19IQVZFX01NSU9UUkFDRV9TVVBQT1JUPXkKQ09ORklHX1g4
Nl9ERUNPREVSX1NFTEZURVNUPXkKQ09ORklHX0lPX0RFTEFZXzBYODA9eQojIENPTkZJR19J
T19ERUxBWV8wWEVEIGlzIG5vdCBzZXQKIyBDT05GSUdfSU9fREVMQVlfVURFTEFZIGlzIG5v
dCBzZXQKIyBDT05GSUdfSU9fREVMQVlfTk9ORSBpcyBub3Qgc2V0CkNPTkZJR19ERUJVR19C
T09UX1BBUkFNUz15CiMgQ09ORklHX0NQQV9ERUJVRyBpcyBub3Qgc2V0CiMgQ09ORklHX0RF
QlVHX0VOVFJZIGlzIG5vdCBzZXQKIyBDT05GSUdfREVCVUdfTk1JX1NFTEZURVNUIGlzIG5v
dCBzZXQKIyBDT05GSUdfWDg2X0RFQlVHX0ZQVSBpcyBub3Qgc2V0CiMgQ09ORklHX1BVTklU
X0FUT01fREVCVUcgaXMgbm90IHNldApDT05GSUdfVU5XSU5ERVJfT1JDPXkKIyBDT05GSUdf
VU5XSU5ERVJfRlJBTUVfUE9JTlRFUiBpcyBub3Qgc2V0CiMgZW5kIG9mIHg4NiBEZWJ1Z2dp
bmcKCiMKIyBLZXJuZWwgVGVzdGluZyBhbmQgQ292ZXJhZ2UKIwojIENPTkZJR19LVU5JVCBp
cyBub3Qgc2V0CiMgQ09ORklHX05PVElGSUVSX0VSUk9SX0lOSkVDVElPTiBpcyBub3Qgc2V0
CkNPTkZJR19GVU5DVElPTl9FUlJPUl9JTkpFQ1RJT049eQojIENPTkZJR19GQVVMVF9JTkpF
Q1RJT04gaXMgbm90IHNldApDT05GSUdfQVJDSF9IQVNfS0NPVj15CkNPTkZJR19DQ19IQVNf
U0FOQ09WX1RSQUNFX1BDPXkKIyBDT05GSUdfS0NPViBpcyBub3Qgc2V0CkNPTkZJR19SVU5U
SU1FX1RFU1RJTkdfTUVOVT15CiMgQ09ORklHX1RFU1RfREhSWSBpcyBub3Qgc2V0CiMgQ09O
RklHX0xLRFRNIGlzIG5vdCBzZXQKIyBDT05GSUdfVEVTVF9NSU5fSEVBUCBpcyBub3Qgc2V0
CiMgQ09ORklHX1RFU1RfRElWNjQgaXMgbm90IHNldAojIENPTkZJR19CQUNLVFJBQ0VfU0VM
Rl9URVNUIGlzIG5vdCBzZXQKIyBDT05GSUdfVEVTVF9SRUZfVFJBQ0tFUiBpcyBub3Qgc2V0
CiMgQ09ORklHX1JCVFJFRV9URVNUIGlzIG5vdCBzZXQKIyBDT05GSUdfUkVFRF9TT0xPTU9O
X1RFU1QgaXMgbm90IHNldAojIENPTkZJR19JTlRFUlZBTF9UUkVFX1RFU1QgaXMgbm90IHNl
dAojIENPTkZJR19QRVJDUFVfVEVTVCBpcyBub3Qgc2V0CkNPTkZJR19BVE9NSUM2NF9TRUxG
VEVTVD15CiMgQ09ORklHX1RFU1RfSEVYRFVNUCBpcyBub3Qgc2V0CiMgQ09ORklHX1NUUklO
R19TRUxGVEVTVCBpcyBub3Qgc2V0CiMgQ09ORklHX1RFU1RfU1RSSU5HX0hFTFBFUlMgaXMg
bm90IHNldApDT05GSUdfVEVTVF9LU1RSVE9YPXkKIyBDT05GSUdfVEVTVF9QUklOVEYgaXMg
bm90IHNldAojIENPTkZJR19URVNUX1NDQU5GIGlzIG5vdCBzZXQKIyBDT05GSUdfVEVTVF9C
SVRNQVAgaXMgbm90IHNldAojIENPTkZJR19URVNUX1VVSUQgaXMgbm90IHNldAojIENPTkZJ
R19URVNUX1hBUlJBWSBpcyBub3Qgc2V0CiMgQ09ORklHX1RFU1RfTUFQTEVfVFJFRSBpcyBu
b3Qgc2V0CiMgQ09ORklHX1RFU1RfUkhBU0hUQUJMRSBpcyBub3Qgc2V0CiMgQ09ORklHX1RF
U1RfSURBIGlzIG5vdCBzZXQKIyBDT05GSUdfVEVTVF9MS00gaXMgbm90IHNldAojIENPTkZJ
R19URVNUX0JJVE9QUyBpcyBub3Qgc2V0CiMgQ09ORklHX1RFU1RfVk1BTExPQyBpcyBub3Qg
c2V0CiMgQ09ORklHX1RFU1RfVVNFUl9DT1BZIGlzIG5vdCBzZXQKIyBDT05GSUdfVEVTVF9C
UEYgaXMgbm90IHNldAojIENPTkZJR19URVNUX0JMQUNLSE9MRV9ERVYgaXMgbm90IHNldAoj
IENPTkZJR19GSU5EX0JJVF9CRU5DSE1BUksgaXMgbm90IHNldAojIENPTkZJR19URVNUX0ZJ
Uk1XQVJFIGlzIG5vdCBzZXQKIyBDT05GSUdfVEVTVF9TWVNDVEwgaXMgbm90IHNldAojIENP
TkZJR19URVNUX1VERUxBWSBpcyBub3Qgc2V0CiMgQ09ORklHX1RFU1RfU1RBVElDX0tFWVMg
aXMgbm90IHNldAojIENPTkZJR19URVNUX0RZTkFNSUNfREVCVUcgaXMgbm90IHNldAojIENP
TkZJR19URVNUX0tNT0QgaXMgbm90IHNldAojIENPTkZJR19URVNUX0RFQlVHX1ZJUlRVQUwg
aXMgbm90IHNldAojIENPTkZJR19URVNUX01FTUNBVF9QIGlzIG5vdCBzZXQKIyBDT05GSUdf
VEVTVF9NRU1JTklUIGlzIG5vdCBzZXQKIyBDT05GSUdfVEVTVF9ITU0gaXMgbm90IHNldAoj
IENPTkZJR19URVNUX0ZSRUVfUEFHRVMgaXMgbm90IHNldAojIENPTkZJR19URVNUX0ZQVSBp
cyBub3Qgc2V0CiMgQ09ORklHX1RFU1RfQ0xPQ0tTT1VSQ0VfV0FUQ0hET0cgaXMgbm90IHNl
dAojIENPTkZJR19URVNUX09CSlBPT0wgaXMgbm90IHNldApDT05GSUdfQVJDSF9VU0VfTUVN
VEVTVD15CkNPTkZJR19NRU1URVNUPXkKIyBlbmQgb2YgS2VybmVsIFRlc3RpbmcgYW5kIENv
dmVyYWdlCgojCiMgUnVzdCBoYWNraW5nCiMKIyBlbmQgb2YgUnVzdCBoYWNraW5nCiMgZW5k
IG9mIEtlcm5lbCBoYWNraW5nCg==
--------------HlDbtagZu4zoMt7iuC50CuDk
Content-Type: application/x-troff-man; name="PKGBUILD_0.1"
Content-Disposition: attachment; filename="PKGBUILD_0.1"
Content-Transfer-Encoding: 7bit

# Maintainer: Levente Polyak <anthraxx[at]archlinux[dot]org>
# Contributor: Daniel Micay <danielmicay@gmail.com>
# Contributor: Tobias Powalowski <tpowa@archlinux.org>
# Contributor: Thomas Baechler <thomas@archlinux.org>

pkgbase=linux-hardened
pkgver=6.8.4.hardened1
pkgrel=0.1
pkgdesc='Security-Hardened Linux (does not boot)'
url='https://github.com/anthraxx/linux-hardened'
arch=(x86_64)
license=(GPL-2.0-only)
makedepends=(
  bc
  cpio
  gettext
  libelf
  mold
  pahole
  perl
  python
  tar
  xz
)
options=(
  !debug
  !strip
)
_srcname=linux-${pkgver%.*}
_srctag=${pkgver%.*}-${pkgver##*.}
source=(
  https://cdn.kernel.org/pub/linux/kernel/v${pkgver%%.*}.x/${_srcname}.tar.{xz,sign}

# stable-queue patches go into here
# https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/tree/queue-6.8?id=a0f0ce228535b3de1d61302e9dd4a59595bc1ccf
scripts-bpf_doc-use-silent-mode-when-exec-make-cmd.patch
xsk-don-t-assume-metadata-is-always-requested-in-tx-.patch
s390-bpf-fix-bpf_plt-pointer-arithmetic.patch
bpf-arm64-fix-bug-in-bpf_ldx_memsx.patch
dma-buf-fix-null-pointer-dereference-in-sanitycheck.patch
arm64-bpf-fix-32bit-unconditional-bswap.patch
nfc-nci-fix-uninit-value-in-nci_dev_up-and-nci_ntf_p.patch
nfsd-fix-error-cleanup-path-in-nfsd_rename.patch
tools-ynl-fix-setting-presence-bits-in-simple-nests.patch
mlxbf_gige-stop-phy-during-open-error-paths.patch
wifi-iwlwifi-mvm-pick-the-version-of-session_protect.patch
wifi-iwlwifi-mvm-rfi-fix-potential-response-leaks.patch
wifi-iwlwifi-mvm-include-link-id-when-releasing-fram.patch
alsa-hda-cs35l56-set-the-init_done-flag-before-compo.patch
ice-refactor-fw-data-type-and-fix-bitmap-casting-iss.patch
ice-fix-memory-corruption-bug-with-suspend-and-rebui.patch
ixgbe-avoid-sleeping-allocation-in-ixgbe_ipsec_vf_ad.patch
igc-remove-stale-comment-about-tx-timestamping.patch
drm-xe-remove-unused-xe_bo-props-struct.patch
drm-xe-add-exec_queue.sched_props.job_timeout_ms.patch
drm-xe-guc_submit-use-jiffies-for-job-timeout.patch
drm-xe-queue-fix-engine_class-bounds-check.patch
drm-xe-device-fix-xe_max_gt_per_tile-check.patch
drm-xe-device-fix-xe_max_tiles_per_device-check.patch
dpll-indent-dpll-option-type-by-a-tab.patch
s390-qeth-handle-deferred-cc1.patch
net-hsr-hsr_slave-fix-the-promiscuous-mode-in-offloa.patch
tcp-properly-terminate-timers-for-kernel-sockets.patch
net-wwan-t7xx-split-64bit-accesses-to-fix-alignment-.patch
drm-rockchip-vop2-remove-ar30-and-ab30-format-suppor.patch
selftests-vxlan_mdb-fix-failures-with-old-libnet.patch
gpiolib-fix-debug-messaging-in-gpiod_find_and_reques.patch
acpica-debugger-check-status-of-acpi_evaluate_object.patch
net-hns3-fix-index-limit-to-support-all-queue-stats.patch
net-hns3-fix-kernel-crash-when-devlink-reload-during.patch
net-hns3-mark-unexcuted-loopback-test-result-as-unex.patch
tls-recv-process_rx_list-shouldn-t-use-an-offset-wit.patch
tls-adjust-recv-return-with-async-crypto-and-failed-.patch
tls-get-psock-ref-after-taking-rxlock-to-avoid-leak.patch
mlxbf_gige-call-request_irq-after-napi-initialized.patch
drm-amd-display-update-p010-scaling-cap.patch
drm-amd-display-send-dtbclk-disable-message-on-first.patch
bpf-protect-against-int-overflow-for-stack-access-si.patch
cifs-fix-duplicate-fscache-cookie-warnings.patch
netfilter-nf_tables-reject-destroy-command-to-remove.patch
netfilter-nf_tables-reject-table-flag-and-netdev-bas.patch
netfilter-nf_tables-skip-netdev-hook-unregistration-.patch
iommu-validate-the-pasid-in-iommu_attach_device_pasi.patch
net-bcmasp-bring-up-unimac-after-phy-link-up.patch
net-lan743x-add-set-rfe-read-fifo-threshold-for-pci1.patch
octeontx2-af-fix-pause-frame-configuration-in-gmp-mo.patch
inet-inet_defrag-prevent-sk-release-while-still-in-u.patch
drm-i915-stop-doing-double-audio-enable-disable-on-s.patch
drm-i915-display-disable-auxccs-framebuffers-if-buil.patch
drm-i915-xelpg-extend-some-workarounds-tuning-to-gfx.patch
drm-i915-mtl-update-workaround-14018575942.patch
drm-i915-do-not-print-pxp-init-failed-with-0-when-it.patch
dm-integrity-fix-out-of-range-warning.patch
modpost-do-not-make-find_tosym-return-null.patch
kbuild-make-woverride-init-warnings-more-consistent.patch
mm-treewide-replace-pud_large-with-pud_leaf.patch
revert-x86-mm-ident_map-use-gbpages-only-where-full-.patch
gpio-cdev-sanitize-the-label-before-requesting-the-interrupt.patch
risc-v-kvm-fix-aplic-setipnum_le-be-write-emulation.patch
risc-v-kvm-fix-aplic-in_clrip-read-emulation.patch
kvm-arm64-fix-host-programmed-guest-events-in-nvhe.patch
kvm-arm64-fix-out-of-ipa-space-translation-fault-handling.patch
selinux-avoid-dereference-of-garbage-after-mount-failure.patch
r8169-fix-issue-caused-by-buggy-bios-on-certain-boards-with-rtl8168d.patch
x86-cpufeatures-add-new-word-for-scattered-features.patch
x86-cpufeatures-add-cpuid_lnx_5-to-track-recently-added-linux-defined-word.patch
x86-bpf-fix-ip-after-emitting-call-depth-accounting.patch
revert-bluetooth-hci_qca-set-bda-quirk-bit-if-fwnode-exists-in-dt.patch
arm64-dts-qcom-sc7180-trogdor-mark-bluetooth-address-as-broken.patch
bluetooth-qca-fix-device-address-endianness.patch
bluetooth-add-quirk-for-broken-address-properties.patch
bluetooth-hci_event-set-the-conn-encrypted-before-conn-establishes.patch
bluetooth-fix-toctou-in-hci-debugfs-implementation.patch
netfilter-nf_tables-release-batch-on-table-validation-from-abort-path.patch
netfilter-nf_tables-release-mutex-after-nft_gc_seq_end-from-abort-path.patch
selftests-mptcp-join-fix-dev-in-check_endpoint.patch
xen-netfront-add-missing-skb_mark_for_recycle.patch
net-rds-fix-possible-cp-null-dereference.patch
net-usb-ax88179_178a-avoid-the-interface-always-configured-as-random-address.patch
net-mana-fix-rx-dma-datasize-and-skb_over_panic.patch
vsock-virtio-fix-packet-delivery-to-tap-device.patch
netfilter-nf_tables-reject-new-basechain-after-table-flag-update.patch
netfilter-nf_tables-flush-pending-destroy-work-before-exit_net-release.patch
netfilter-nf_tables-fix-potential-data-race-in-__nft_flowtable_type_get.patch
netfilter-nf_tables-discard-table-flag-update-with-pending-basechain-deletion.patch
netfilter-validate-user-input-for-expected-length.patch
vboxsf-avoid-an-spurious-warning-if-load_nls_xxx-fails.patch
bpf-sockmap-prevent-lock-inversion-deadlock-in-map-delete-elem.patch
mptcp-prevent-bpf-accessing-lowat-from-a-subflow-socket.patch
x86-retpoline-do-the-necessary-fixup-to-the-zen3-4-srso-return-thunk-for-srso.patch
kvm-arm64-use-tlbi_ttl_unknown-in-__kvm_tlb_flush_vmid_range.patch
kvm-arm64-ensure-target-address-is-granule-aligned-for-range-tlbi.patch
net-sched-act_skbmod-prevent-kernel-infoleak.patch
net-dsa-sja1105-fix-parameters-order-in-sja1110_pcs_mdio_write_c45.patch
net-sched-fix-lockdep-splat-in-qdisc_tree_reduce_backlog.patch
net-stmmac-fix-rx-queue-priority-assignment.patch
net-phy-micrel-lan8814-fix-when-enabling-disabling-1-step-timestamping.patch
net-txgbe-fix-i2c-dev-name-cannot-match-clkdev.patch
net-fec-set-mac_managed_pm-during-probe.patch
net-phy-micrel-fix-potential-null-pointer-dereference.patch
net-dsa-mv88e6xxx-fix-usable-ports-on-88e6020.patch
selftests-net-gro-fwd-update-vxlan-gro-test-expectations.patch
gro-fix-ownership-transfer.patch
idpf-fix-kernel-panic-on-unknown-packet-types.patch
ice-fix-enabling-rx-vlan-filtering.patch
i40e-fix-vf-mac-filter-removal.patch
tcp-fix-bind-regression-for-v6-only-wildcard-and-v4-mapped-v6-non-wildcard-addresses.patch
erspan-make-sure-erspan_base_hdr-is-present-in-skb-head.patch
selftests-reuseaddr_conflict-add-missing-new-line-at-the-end-of-the-output.patch
tcp-fix-bind-regression-for-v6-only-wildcard-and-v4-mapped-v6-non-wildcard-addresses-again.patch
ax25-fix-use-after-free-bugs-caused-by-ax25_ds_del_timer.patch
e1000e-workaround-for-sporadic-mdi-error-on-meteor-lake-systems.patch
ipv6-fix-infinite-recursion-in-fib6_dump_done.patch
mlxbf_gige-stop-interface-during-shutdown.patch
r8169-skip-dash-fw-status-checks-when-dash-is-disabled.patch
udp-do-not-accept-non-tunnel-gso-skbs-landing-in-a-tunnel.patch
udp-do-not-transition-udp-gro-fraglist-partial-checksums-to-unnecessary.patch
udp-prevent-local-udp-tunnel-packets-from-being-groed.patch
octeontx2-af-fix-issue-with-loading-coalesced-kpu-profiles.patch
octeontx2-pf-check-negative-error-code-in-otx2_open.patch
octeontx2-af-add-array-index-check.patch
i40e-fix-i40e_count_filters-to-count-only-active-new-filters.patch
i40e-fix-vf-may-be-used-uninitialized-in-this-function-warning.patch
i40e-enforce-software-interrupt-during-busy-poll-exit.patch
drm-amd-flush-gfxoff-requests-in-prepare-stage.patch
e1000e-minor-flow-correction-in-e1000_shutdown-funct.patch
e1000e-move-force-smbus-from-enable-ulp-function-to-.patch
mean_and_variance-drop-always-failing-tests.patch
net-ravb-let-ip-specific-receive-function-to-interro.patch
net-ravb-always-process-tx-descriptor-ring.patch
net-ravb-always-update-error-counters.patch
kvm-svm-use-unsigned-integers-when-dealing-with-asid.patch
kvm-svm-add-support-for-allowing-zero-sev-asids.patch
selftests-mptcp-connect-fix-shellcheck-warnings.patch
selftests-mptcp-use-operator-to-append-strings.patch
mptcp-don-t-account-accept-of-non-mpc-client-as-fall.patch
9p-fix-read-write-debug-statements-to-report-server-.patch
asoc-wm_adsp-fix-missing-mutex_lock-in-wm_adsp_write.patch
asoc-cs42l43-correct-extraction-of-data-pointer-in-s.patch
riscv-mm-fix-prototype-to-avoid-discarding-const.patch
riscv-hwprobe-do-not-produce-frtace-relocation.patch
drivers-perf-riscv-disable-perf_sample_branch_-while.patch
block-count-blk_open_restrict_writes-openers.patch
risc-v-update-at_vector_size_arch-for-new-at_minsigs.patch
asoc-amd-acp-fix-for-acp-pdm-configuration-check.patch
regmap-maple-fix-cache-corruption-in-regcache_maple_.patch
alsa-hda-cs35l56-add-acpi-device-match-tables.patch
drm-panfrost-fix-power-transition-timeout-warnings.patch
nouveau-uvmm-fix-addr-range-calcs-for-remap-operatio.patch
drm-prime-unbreak-virtgpu-dma-buf-export.patch
asoc-rt5682-sdw-fix-locking-sequence.patch
asoc-rt711-sdca-fix-locking-sequence.patch
asoc-rt711-sdw-fix-locking-sequence.patch
asoc-rt712-sdca-sdw-fix-locking-sequence.patch
asoc-rt722-sdca-sdw-fix-locking-sequence.patch
asoc-ops-fix-wraparound-for-mask-in-snd_soc_get_vols.patch
spi-s3c64xx-extract-fifo-depth-calculation-to-a-dedi.patch
spi-s3c64xx-sort-headers-alphabetically.patch
spi-s3c64xx-explicitly-include-linux-bits.h.patch
spi-s3c64xx-remove-else-after-return.patch
spi-s3c64xx-define-a-magic-value.patch
spi-s3c64xx-allow-full-fifo-masks.patch
spi-s3c64xx-determine-the-fifo-depth-only-once.patch
spi-s3c64xx-use-dma-mode-from-fifo-size.patch
asoc-amd-acp-fix-for-acp_init-function-error-handlin.patch
regmap-maple-fix-uninitialized-symbol-ret-warnings.patch
ata-sata_sx4-fix-pdc20621_get_from_dimm-on-64-bit.patch
scsi-mylex-fix-sysfs-buffer-lengths.patch
scsi-sd-unregister-device-if-device_add_disk-failed-.patch
revert-alsa-emu10k1-fix-synthesizer-sample-playback-.patch
drm-i915-dp-fix-dsc-state-hw-readout-for-sst-connect.patch
cifs-fix-caching-to-try-to-do-open-o_wronly-as-rdwr-.patch
spi-mchp-pci1xxx-fix-a-possible-null-pointer-derefer.patch
s390-pai-fix-sampling-event-removal-for-pmu-device-d.patch
thermal-gov_power_allocator-allow-binding-without-co.patch
thermal-gov_power_allocator-allow-binding-without-tr.patch
drm-i915-gt-limit-the-reserved-vm-space-to-only-the-.patch
ata-sata_mv-fix-pci-device-id-table-declaration-comp.patch
asoc-sof-amd-fix-for-false-dsp-interrupts.patch
sunrpc-fix-a-slow-server-side-memory-leak-with-rpc-o.patch
riscv-use-kern_info-in-do_trap.patch
riscv-fix-warning-by-declaring-arch_cpu_idle-as-noin.patch
riscv-disable-preemption-when-using-patch_map.patch
nfsd-hold-a-lighter-weight-client-reference-over-cb_.patch
lib-stackdepot-move-stack_record-struct-definition-i.patch
stackdepot-rename-pool_index-to-pool_index_plus_1.patch
x86-retpoline-add-noendbr-annotation-to-the-srso-dummy-return-thunk.patch
revert-drm-amd-display-send-dtbclk-disable-message-on-first-commit.patch
gpio-cdev-check-for-null-labels-when-sanitizing-them-for-irqs.patch
gpio-cdev-fix-missed-label-sanitizing-in-debounce_setup.patch
ksmbd-don-t-send-oplock-break-if-rename-fails.patch
ksmbd-validate-payload-size-in-ipc-response.patch
ksmbd-do-not-set-smb2_global_cap_encryption-for-smb-3.1.1.patch
alsa-hda-add-pplcllpl-u-members-to-hdac_ext_stream.patch
alsa-hda-realtek-fix-inactive-headset-mic-jack.patch
alsa-hda-realtek-add-sound-quirks-for-lenovo-legion-slim-7-16arha7-models.patch
alsa-hda-realtek-cs35l41-support-asus-rog-g634jyr.patch
alsa-hda-realtek-update-panasonic-cf-sz6-quirk-to-support-headset-with-microphone.patch
io_uring-kbuf-get-rid-of-lower-bgid-lists.patch
io_uring-kbuf-get-rid-of-bl-is_ready.patch
io_uring-kbuf-protect-io_buffer_list-teardown-with-a-reference.patch
io_uring-rw-don-t-allow-multishot-reads-without-nowait-support.patch
io_uring-use-private-workqueue-for-exit-work.patch
io_uring-kbuf-hold-io_buffer_list-reference-over-mmap.patch
asoc-sof-add-dsp_max_burst_size_in_ms-member-to-snd_sof_pcm_stream.patch
asoc-sof-ipc4-topology-save-the-dma-maximum-burst-size-for-pcms.patch
asoc-sof-intel-hda-pcm-use-dsp_max_burst_size_in_ms-to-place-constraint.patch
asoc-sof-intel-hda-implement-get_stream_position-linear-link-position.patch
asoc-sof-intel-mtl-lnl-use-the-generic-get_stream_position-callback.patch
asoc-sof-introduce-a-new-callback-pair-to-be-used-for-pcm-delay-reporting.patch
asoc-sof-intel-set-the-dai-host-get-frame-byte-counter-callbacks.patch
asoc-sof-intel-hda-common-ops-do-not-set-the-get_stream_position-callback.patch
asoc-sof-ipc4-pcm-use-the-snd_sof_pcm_get_dai_frame_counter-for-pcm_delay.patch
asoc-sof-remove-the-get_stream_position-callback.patch
asoc-sof-ipc4-pcm-move-struct-sof_ipc4_timestamp_info-definition-locally.patch
asoc-sof-ipc4-pcm-combine-the-sof_ipc4_pipe_paused-cases-in-pcm_trigger.patch
asoc-sof-ipc4-pcm-invalidate-the-stream_start_offset-in-paused-state.patch
asoc-sof-sof-pcm-add-pointer-callback-to-sof_ipc_pcm_ops.patch
asoc-sof-ipc4-pcm-correct-the-delay-calculation.patch
asoc-sof-intel-hda-compensate-llp-in-case-it-is-not-reset.patch
driver-core-introduce-device_link_wait_removal.patch
of-dynamic-synchronize-of_changeset_destroy-with-the-devlink-removals.patch
of-module-prevent-null-pointer-dereference-in-vsnprintf.patch
x86-mm-pat-fix-vm_pat-handling-in-cow-mappings.patch
x86-mce-make-sure-to-grab-mce_sysfs_mutex-in-set_bank.patch
x86-coco-require-seeding-rng-with-rdrand-on-coco-systems.patch
perf-x86-intel-ds-don-t-clear-pebs_data_cfg-for-the-last-pebs-event.patch
aio-fix-null-ptr-deref-in-aio_complete-wakeup.patch
riscv-fix-vector-state-restore-in-rt_sigreturn.patch
arm64-ptrace-use-saved-floating-point-state-type-to-determine-sve-layout.patch
mm-secretmem-fix-gup-fast-succeeding-on-secretmem-folios.patch
selftests-mm-include-strings.h-for-ffsl.patch
s390-entry-align-system-call-table-on-8-bytes.patch
riscv-fix-spurious-errors-from-__get-put_kernel_nofault.patch
riscv-process-fix-kernel-gp-leakage.patch
smb-client-fix-uaf-in-smb2_reconnect_server.patch
smb-client-guarantee-refcounted-children-from-parent-session.patch
smb-client-refresh-referral-without-acquiring-refpath_lock.patch
smb-client-handle-dfs-tcons-in-cifs_construct_tcon.patch
smb-client-serialise-cifs_construct_tcon-with-cifs_mount_mutex.patch
smb3-retrying-on-failed-server-close.patch
smb-client-fix-potential-uaf-in-cifs_debug_files_proc_show.patch
smb-client-fix-potential-uaf-in-cifs_stats_proc_write.patch
smb-client-fix-potential-uaf-in-cifs_stats_proc_show.patch
smb-client-fix-potential-uaf-in-cifs_dump_full_key.patch
smb-client-fix-potential-uaf-in-smb2_is_valid_oplock_break.patch
smb-client-fix-potential-uaf-in-smb2_is_valid_lease_break.patch
smb-client-fix-potential-uaf-in-is_valid_oplock_break.patch
smb-client-fix-potential-uaf-in-smb2_is_network_name_deleted.patch
smb-client-fix-potential-uaf-in-cifs_signal_cifsd_for_reconnect.patch
drm-i915-mst-limit-mst-dsc-to-tgl.patch
drm-i915-mst-reject-fec-mst-on-icl.patch
drm-i915-dp-fix-the-computation-for-compressed_bpp-for-display-13.patch
drm-i915-gt-disable-hw-load-balancing-for-ccs.patch
drm-i915-gt-do-not-generate-the-command-streamer-for-all-the-ccs.patch
drm-i915-gt-enable-only-one-ccs-for-compute-workload.patch
drm-xe-use-ring-ops-tlb-invalidation-for-rebinds.patch
drm-xe-rework-rebinding.patch
revert-x86-mpparse-register-apic-address-only-once.patch
bpf-put-uprobe-link-s-path-and-task-in-release-callback.patch
bpf-support-deferring-bpf_link-dealloc-to-after-rcu-grace-period.patch
efi-libstub-add-generic-support-for-parsing-mem_encrypt.patch
x86-boot-move-mem_encrypt-parsing-to-the-decompressor.patch
x86-sme-move-early-sme-kernel-encryption-handling-into-.head.text.patch
x86-sev-move-early-startup-code-into-.head.text-section.patch
x86-efistub-remap-kernel-text-read-only-before-dropping-nx-attribute.patch

#'usb-disable-all-rndis-protocol-drivers.patch::https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git/patch/?id=c97ce1438f9aed84551eac5a4519112b2edd06c6'

# Derived from https://github.com/anthraxx/linux-hardened/tree/a2acd673a7c689b56db904d5903d197986aaa922
#  ${url}/releases/download/${_srctag}/${pkgbase}-${_srctag}.patch{,.sig}

  config  # the main kernel config file
)
validpgpkeys=(
  ABAF11C65A2970B130ABE3C479BE3E4300411886  # Linus Torvalds
  647F28654894E3BD457199BE38DBBDC86092693E  # Greg Kroah-Hartman
  E240B57E2C4630BA768E2F26FC1B547C8D8172C8  # Levente Polyak
)
sha256sums=('d5dec495fc00605fa9e04114df547fbc92b33d9ea7a4a2b7073c589590e79e63'
            'SKIP'
            '3ef13587965b9c0738f066ac9be9d5673a759fbbd481db26cb67e54ff765fe26'
            'c7956edd0dd2f657fe1c267c11c190d8edb5664bc96ca0cfff8d756fcd4bb1b4'
            '3468e371ce50930a02f0945a2bc9fcc2c8865f637493cf8e6173d38026752cf4'
            '15fd39cc6e9fd38a5eeb313c0f28208c7716fe87d8a3c818eefa2c0337bbf450'
            'caf58e8a3422d142bc79f1ee761cb51a0065a0d9c6c15c2848cafee257bdd18d'
            'cae7c1e42ca35c7fd0216563b8dd9c265d5929943c1376a598f1d0b5b4708798'
            '80e2e5d04cb1c186eaeab90bcfa0be20043ac4d65eba6983c6842a31b2492683'
            '39529f0674f664dd6cb3903e2b69a9f6b67627079fc9de38b51abebe69f8b1ab'
            'fd5a0e8ae545f1e1e38154697a87ec36fc67201bcf21a08513f53ac01efbcaba'
            'c517b7b800b100127613a2a26c2f4a07d5b93de3a2153f86fdfd9894e30a0c99'
            '150ba2f0ec16cfd923715557763ab4fc2acb607cc7ad01f08588f3d21b3c9d90'
            '44213f4d4dd959979de648dd6d31db9bc5d67cb91d809aedee31108eaf09aa74'
            '5a971f6056a67ea6b7be906e7770414c10855fa98d276e6bbf9144598563d56a'
            'cfdf524914b0c5dc6d5ad95518c57f76f22de0876aa99a87cf99bd0cae052cbf'
            '3ab975a7e3bcd9ab1bcc39e3f59bb68febdaf3ddc91a6d5176ad82cee5cdf439'
            '5c29d53efebb43186fc25bd244f9cb567307ffc05a6365180efd824fe899c8e8'
            'b0b2f2268387fedba24e98c5bc7997e42c0d09fa552000a25f40f27a882f3161'
            '72f95b679c3554436bcd084279c87d3a1f17fd951723e5aa5527fc1a0c40f511'
            'a19da464916582e81b57e02610a9257397138ac20e26f6c6a6bb124cb51eb4b1'
            'c28c78824370c5bc1f6f4499b157d00fc4b5635fbdd20be3e270208ad5d56682'
            '246419c0c29dfe7705cfd9c2cd8390fa7db4c402f14cd34dfbcd3b8573e431df'
            'a117676146437bcb8362ad2d33c2b4bc1a621efdf6b938b1ee7ed5bf65f294c4'
            'db3618e56608cbaf619d99b4da5b721e5de1fe2e5c5edc7216521e1e67ac6ffa'
            'aed2110637c1966d8b5e4d231998a0e2315a346a9f47f5b03e03dd1dcc8e46e1'
            '14f4c3202ce9a0bb8652ba04a5c3aaa267382c810c46478775f52efbd81d69a4'
            '6a4c03b73ec16a9ee3a1ecbbac5d5c52bd965d7a6723c55040f7912fc146e4e8'
            'eaaabf37a70ba6792bc7c089503e0309d0b574e1fa00f0f8a35a524503c6888a'
            '659616ce1ff4c47012c878102ed2a9bcd65be78e401e031ab53d748cc01e997e'
            '02fe847a64a00326731e46cf430c1227f95d6d6cba5ed51271b8dbddb0414c0f'
            '7fc7d0126fd6b3e39f8c5acaf8b0f994f42006b2fb18326bf92f81052b768900'
            'b8f95c2acb5fcf47554b2f2913f6205c33dcc86b7c2da6be520f7e57f42c7c65'
            '534b8b82671a1937eecd19592c98834071c231827373ac9a76766fda32d19dbd'
            '4ec1cd059f676088fd134c5091bf79eaf9bea5367e30c4481ef5d64560f81ecb'
            '61fbb1961346ea2d2770e7f34fb09af0dddd3b7e919f5c063843973829c682a9'
            '4a947d0f1bdcd80d102715946dd8bd5d7673a5ad7c59913860d03fc72aa04d22'
            'e7a5a44c19f92dfa78fcde718b069d875528ee522c7a9e28b81ad9859b74f0f3'
            '5d432f7a2f32a8a44d060f0d42a28075413f469b6ec9bf106b63d5d89aa7764b'
            '4ca4eafff1d8867fb8a9ee018fef42692e247ba7cf6959d910f499be6f0da59e'
            '4395ae7945fe335c4eaaddc2fd00e8f40dd8f7bdb029bb55dc1798c749800e7c'
            'b063ab2c74cb92561f55aa334129cc199bac8a73de33f03bf1b8fe1f349dc991'
            '681fcb45db80a57806b37dfb4dae55e0d711b1c1e024fecb325feeb8432864bc'
            '5ff34f1ab794cf3c005af4cf4c175014981d3036f5bf76018d353b6ca41cb708'
            'e201913a3beead60d5e05bf62b6ec43b8ee8c7ed4ceca5d8739f90a29c7e5fd8'
            '571533f5484315942598291ce3cafb54de26b7d54206f6c30a43c07c6c2d91db'
            'ee2ab9996d06a937eae0eaa8e0a799f6a8c68d3998708beb9b82af859f8b442e'
            '2beab0b1ed9d3eb01b8adef6bcd97f58b68fc9b32ec29a3fd4f6606ee3f12d35'
            'e8284cd9f1cf069098e881672266a4845cd81a18a3e50a94730fa1be913080e7'
            'bfc0beb29460639d37e53df7244bb37c34d7bb355523944db31bf94270ec46b4'
            '69eaa07804cc1ae7bba1dcf032d6c58fe82698361489337d7ed3d1f1956420a4'
            'd7c831a6f2201af41c0153587bbaf854928a3f04ab0ece7d90bae317d9920108'
            'cdf46f16e4897e7d0afc06e47e7241344b81bd854056c27195385e245c4bb250'
            'f1add1750678b77b8dee2034bdd75e59028adb8075c44629fbf769e24e86e5c2'
            '876314ef779f77a737c1d5a62858f63d761e7cda5b22753e3f18ae5a23291af6'
            '177bcc7aca2188f349824c9200b5c1e4d430a0b712bf010547a0cbba3840ad90'
            '2830ede0e92a5a318bea5a71445a7c819df24ea8aa15a3e39ccab8c7bd816846'
            'cbf25cc0202ef8552f7179538b879dae2de3d0cc3db28f9de0970bc12c6e05d4'
            'cdb6d33eb182c9ed3efbc99b6d9f7b7af85a1e640a8889a8509985e29b502b98'
            '75a77083478e8b651b8040f0bf42dd6c2d86754aad91a1509ca94ee844d74928'
            '37b53f22119e1d991d4ffc7eaada004f5f31df5c8b335f2cc5747cb169e663ee'
            'ebe3855fc0fb079def132d275d05c821dc68d10e9f495dea839b768740667f7c'
            'bba8b770c8d01494a33c85226197fa51f07de4e93d7c53eb9d45fb46c8f159f2'
            'dd411a84fe996956f05007e430ae42cd43d8723acd73410dd709672b1826506b'
            '1635eb9d69aacc554cea48767bdc9e84788a965823b5197d0c87db93d5fc8c57'
            'cfc2c59e061d4ae1196c8bd05e7634b9c1e38e0a3607da65b76976df05c9dfc5'
            '14eb19d142f769f31f03c14b328849e7a0452a94fc374749572327bec8a7c30b'
            '0b27a0d5430a6469bf3dc7a6c940b00593ecb5256fa56279e75769fcee6e6f5d'
            'a59bc42d9771b72e00cbc6bb05e5c0caa747abc58f49cf53baf05e68de9f3b8b'
            'c56893da4c380629046f1e55d3397f5be69c7e7c44c291f9ae320c5ef5ee7e6f'
            'aca2ec0ddbbd6004f359189fe645e4d78ba8861f2d45c7b8d9568815c52ef012'
            '3ee990372d24499c182f7f6bfaf84c32d00aed2e8288ce283ec8b167afd391a7'
            'bd600e63369039388dbfe3505f7c0811a198868bb1a48ccae14abfdfb921e569'
            'f0a4ace46401e4814c7512ec0558ee159b5b8297d15a7d011319ced9b7cd5d20'
            'daea2e09a6e603e314466eb6c61042ecfaf88c2c3189a93b9da66148486f11d5'
            'df52e8e003f31b481e992a0d6467afd6e44fd99dce06ac38257e176394ca6b50'
            'a189e7fcd2a85e9f4236c4e271541e283550eb5512d86013e0daab0103353745'
            '0b172ceae65f46b10589d62c5e3ec1498cebb8c951a338c112c52d23c55f02de'
            'f0410a5d4ca18391d1dd51fab54dbc63d7f0b683997284afabd5b650a56afb03'
            'c1e1df8aab21c887ed303e030b7782b2431555712d1f034d98b48e31d4849b3e'
            '95b1de9ed302174df30e871e58e241f021e840e1161341f85740d283321d0e04'
            '4da3f60168e1ed84f4bb7d71dce92faacc7005608269dfd4e725dc94e677afd6'
            'f739d2fb98aca1a0dee6ee066bc7c9fd70ebbe503fb2b9e1e4662d1fc34cff4f'
            '9758a3e8ca366f0b15023d614bd35e6f99aa06d4a1c35519bfb1ca2c4f48f21d'
            'd54efaf68d588936cb73faea830ef46c0aaf69a47a8b012b10c8fe673ce0f4b8'
            '8ff9524a79b80b60c7816635d3ef863aa0488658d06d43a6ea7de255c13eb3ba'
            '3b604b2afbfc8795cdedbfb666efd9fcc95804fa426d5c3ec4863be68caf5477'
            'f399c241dc1a87dd017bf19c70b4ef0748db7002a07e22ea0371f1925f1cb1f8'
            '0d3318bc1733a93ee9978582360390dbfa79376a945db13aa9c4288a93dfe8ae'
            'fee969b79295293a367208eec8cf1ffacd45ca48bb69c13d1e39bdeca7255a7d'
            '502b65013e916774fc834315aa4b2c2bbc5ede3f277c6a0318d2bb8e2a6f5663'
            'b216dff8de78d22e4f4fefe52db4ac4d9a57c6e9e9b5ddcd8d1bb4467bcb32cf'
            '75a4028c4e151c1d0b37f5ba7ff1b51164f61c88d620afb1b196a6ac06cd8437'
            'd1f45d31a974da3740b8f8b644d2bac54ff27cf8eb60ebc12481d4caee987ac4'
            '473ac2c06a07fc58766346b1fab92a6ce554af4dfe03e484a6c251dd260f1291'
            '320ac636b0fb96058790deb15b08a19ed31a97af21049e50e6a000e4bd76f607'
            '42d58c53aa87dfac943f980048f97c1c336b662c5c98869169842b820f9b77b7'
            'b05437e5d268152ba6f279e0c37f14ff9cb7d9c6f2865b9cc447f74d93cbe8bf'
            'b2718df5e3f7316d4a6025b384e8b04592aa88950d3b0f8507184eb84ab00af7'
            '667ca2bddfaae2707f4d357f3e7ec811de297e39de30367ff5da52624abc35d5'
            '572d0c8ef1f73a6e6a6a32c01ad89ba6542992ff7330f0e801c253cd17b6f3f4'
            '3650a439bd2ef6f230954aca1c7194f0d20c09734f1ff987f95272769384fe4f'
            '26a3a12e28747ae6e01014a08c72d2f45001c9ce932356af48ff7ae85dc02b22'
            '8b52f346785e9482e5c6614fb703efd48ea6f5cb89d1ca54fa546d0b9026b893'
            'dd60310f44cdf72be9e3b818ae795eaa7bfb6e4a6dad07764bed496ae5b4bc2b'
            'b4b8d1573d884cb04157b54e144334dd2e7635dec77a9d7ed224f0e91c94d80b'
            '8cbfa3a59d377013c23f498e441eac420b6849c4fab4609515ec0e2a5511cd78'
            'f859d00a2b839ea88218771d7b80d9e290379184841ba5f34bb6f819b8c0cd7e'
            '8e540b700e9e7e77ed1fba288f3b83c2b8b1eb3da3ec2fb1b1aec9b469e6ff66'
            'f724ca611402642040ef0393e8fec5e4375293d1de453be6021c272f38b15827'
            '78259696d079935bead2a3180ff42a2c1b409aa5249f63b46a0366eeef124b38'
            '277f562aeed2fb183c572706ea6a0ced42a6d94500835c7b88e8f618acbca6ab'
            'cad7edfa2cc24ca911c0dae42bbceebc982bcc6986f5792c2f6d3030647c563e'
            '172c150fe0e9b1603fe53e1e776ab6680c81e17ce4753a00d1c160959ac8c0f2'
            '8ea6b7add2d74c3f3b7e5531548e7de37224c60b76288a0e095e81bb25aab803'
            '50261af539eb742af31606f445f4a4c75a8fed11955d026a6c4199d4d20962a2'
            '4057a7ca97b72e65341285208f973698491918f27eeb5767c905458273be7b47'
            '0c699f363a6277f141358227eb29ea22d28f6088d7401e4cdfd339d8265bfeb6'
            '719bd1267bb7ac12d1b68ea7fc6ef9b0811809e06a5077990775da1616322a70'
            '5503a9ce389d975ed7297e6fa64b62d018106745d9bce75b399b0a63bd4dc435'
            'e5614b0bdc8dbaa2912335257f9faadd115dbd0eba14291b2a0caa2e81b1adf0'
            '5fd5613abd070ccb0783f56e5018840579d4693f2e7517d0399beec2dadadc6b'
            '1a3ed169c3f367b08da86f9939e671da5f373986f5601bef5292e5eb2dfea0a2'
            '75a48a288ec9a2855360667b34f68a49440ae9a4ac06594027e681fddd32bad0'
            'adc5e82801107d5dedb974aa81355bf75b57b6a6bbfbd76bc632ec63ca85994b'
            '0e8418a42f45a030207e537736158d596b4010ec9dd9f909f7700fc6ecd4839a'
            '76810ea58728e6876d426eaf4cfa547fe38d2126eb4e366506f09d74c320f090'
            'f2ea3600f0dbd9cf92c30e909209e1e75a19747f19fced2190090e54ee51d37d'
            '0c5d113586f241fe4edefe6e0903b2e616dc0bdb3caf6119b139c0a6617a9916'
            '89b768f48302cf18cf1cce022151980b72a9151eb68778c234d9ddca5601aeeb'
            '65721474b58e7f073b1f92b08f4691f91383eff146441d53ef1cb9fd4431124a'
            '9eb1118d9419f1413bdc89be91f30e03dc898a6847a66975dcb969748a9d2269'
            '9624a003b4265c3c3228a929cc2c7c8e0b2f23af7f8f4d7fbc7302c2538780f7'
            '99eb96deb3b935631b73ccfb0011deaef9e1bcfcb21324ed30cdcae4eaa684c7'
            '53522322dbfd81fa696c73ea0ecdf66a445b57a533c568d6c694fa447ce28ea9'
            '1b82c31cca8d789b89434514b3fe6f2d482ce86cfebc13d9ae4897bacfb2800b'
            '010589b0ad4d71aa067c0265fac39c902971cb917453d4d719babda570d1b9bb'
            '87389526d46c4834211636487c733b99761a4ad392f349e13839f6fe78666a5c'
            'c43a1908261b49ebf7e19c6333bb5605756b4915e9de4057ed28795516a40c44'
            'dc91ba1e0db3abc987e47c204faa68b81483eaa78e48b131e842e8229c038455'
            '8ceb61c82ab6ad9557edd1b93d2c270eefaff8b5e7aa07c2be0f8c7059bc4bc0'
            '5d0b185ec4ed770b88fe079dfd92f340d636eb2883b1c9abc1a3f64bff7f0a98'
            'a87c38f82a586023a3327c8d7155be974c996f0b63407ce7beb3c94cae312dbb'
            '8932dd0c04e571e01ce1a4924a0477318f3b1c9e5803ef4089411ec8ff18ba48'
            '8d5d068a1a9bd5feedd8b2ae3c651e66c3a2554d77964fd805ba344211ad0ed6'
            'f98619dde0649dcb0446890d9276e7c6bcdc45aac59ed9f6de79e4b6555712b6'
            '523365f15a94f8e3000532ef3c1c00e33d47d0585fa6752ec0e7bdcf58395311'
            '554b442a3f4b5dd13dda0c1787e958ac01a959802e48ef5a5462f5b15ee131c4'
            '04b3aab50f5a48ca4d785c7fbc7d23e4f98d649fed3f272ffca7712ef6d10787'
            'd6e9cec57b586ae38325b48977cc73998d3b2280de3eb01db8975f2980304abf'
            '384851869cae4ec19c7b4a8fbcb9a8127cb146cc046bb52ad24e82bfaaa13117'
            'e1be9ca689e56130c2fd771400188cb4385cbc4ed34a17b71eed4a53dea2747d'
            '0a5190176066242abd09800fc715e763803f075516769c552a846410178691cc'
            '096f1c78e6d9346d83187643dbe05209d4e0bf30e100b9257e6f54d7bcb1901e'
            '14e60886929d442227ff9a1aba6a34af6ac148020bb0c2ebcb83230e8b2aafe1'
            'a698cdd489ca0ce0e10f9e18203fac37525ce5c9c5f879e4c28626f861a77092'
            '97064fa35845ae3a17b8437cabc80ca458bad39aad5894a951e1d866d14e5d29'
            '1f88f754f67348c82b9ad8be3bbb7fb45103b96112d840a1524304a86956fea0'
            'ac24913fbb2fc9d2a4973df38bdaaa54ec7ee05766e4ac7ea9b117e120be5c47'
            '13da7ed568f70bb8098a225ae015ba52c34090df04d630d8a2932b04cc330cac'
            '26b0676c6d631c2f2757afaf31b301255137ae170897f5c5c5eccb23fbfeb43b'
            '3a8eafc1164c5ffe5c16d852144e5ef5d595fb3b08fc313c40efdb702568eac3'
            '1b82b51eae3c729d7686fef9dea9fcac3e4053dad2b786c66dce9ca5a0193393'
            'b39f9b573e3c771d3d5139353b01640aa10c05cc7abc3f31a0ebe882112ad9bb'
            '67e8b3ebc49f1db2c1047903cd2ac349fb11cc3251036f68c6b64279f138873b'
            '875ae02c14798b6b757a51897f4b8de56ce5f27ee73d0cc8f32d9b47bf7e8d82'
            '7869d0d9ae34e94244250a415b86d148ccaa8fc4b5b84ef3f995122c45580c8d'
            'f72fc96a43b32ce1c551d8c792fb6998c481f56d1a1d76b46bc4bfb2be031d27'
            'cc2e9d174815e33d0eed16e642d3dd3a6d802842b0880c4572e7250f2cfb8344'
            'd6540b42f65ec57809cb04dab71f18392762579c5d43a42d368c0ee44f754576'
            'f04128d5b11c4e8370ce157126c0384b26a63f554b8ccfbb15a30652179d8286'
            'b288737040976c9433c4eb5d599bb2bc723a4148fd81b1177f262a0eb24da383'
            '8241ce80d50afab8e359af4c2a45b9cf2fb27574200c21c7de34f4fb9b240067'
            '59a61ec7c78afe1205d7cbc109f18d5ebe86436992165bb6d2ecc354e4c2c8a8'
            '03bf70c3fcbfb751fbc6b5235771bd9faa2002c6bf4218af20d523b29cb36f66'
            '4f0f9d92bbcc224f059710bbe69c395322a6d470054b432dd811abdb786d52ba'
            'e3ff3c8accc6b1ccbea973921383b451ad6fdf2a60f23f6f5d01ad594701bd99'
            '12b70c856f661c5764c914bbd5c532e70367a832f7876ba1ed5c246e8798c259'
            '9d28f9784b9fc7956fc476cb4d86dbfc4d3fa2fad1f0a0abfab627882d8c6f63'
            '888840ffce08989eb5c772ca174983055b978040b287614c5cfd28d555e275a5'
            '16799b800c2e3c567d314cb43a41ddbfe33063697b5f31f7f61e5b1797aa958f'
            '2d8173c0a0e56f5000b86c2249d9e272fff6870ea051b8412d7313d70a315333'
            '34e32888f68a69802a99685ab3a82f72174a58620faec9eae4285e99983ff45b'
            'dcdc7fc7cc448d5794db71ec9874b241c8c24494ec0be844f3c4baf5cfc0542c'
            'fa5b7188243cc11204a9e727ac39e2aa0ca06fc5deef02fbe046218b339d5043'
            '4ccb22d22a0ff15510d7d070d55aeac608adc8c647c3e59462c18c4bd1bd525d'
            '9060af7239cce73665ff21ab07e32444eada5a22744cb90507b0acf6b4cc3f38'
            'e604a9fd55d400b7e8ea2aad4a5e3badd432f10b20f456a2bcd99591fd310d5b'
            '7f0c7d97bef877f80c684c38816f6ecbe826f9e933b0d73a5fddfdc6dd76ed6b'
            'd492d3b07891da81addc204dd92b070a81ff2c3559142cde192ecc601709953a'
            'da64450c67aa5a84a53d6b89df017187d5d2d354eb5260cef36e516b54cc188c'
            '43b8e5abeff6e09e3deb1d57d5fe9df32f640fda4d68bd0eb31e79de969da03c'
            '3437233b2b7dc175261544adece08f9fc8a0ca182c47d6d2c018a9c85dcfd25d'
            '079b3be39fcc304798d7d146b5069aeaa472dccb68e4bb94b0012de78873c441'
            'd5b5e69136362b4fea580a311655ee15454c52193f721ef51ea5e25d6b148851'
            '683ff4e746fc9c924e0702c033608a690e022d0a823fb8bd52216bc3ddc745d6'
            '65c3580473498448532aa3dc47d080893ad94f46abb84cb0a7e1ec6812b42029'
            '75d7c8bfd904ebc8a1075ae029cc730be302cd020a6a8e2ead468febc03d7739'
            '3eac3a68d22c85662c161345de4e9f6ea94215f045da8b91217573bb992236fd'
            '12af1e6329522d7a74fc09da1c719efab3ef50f9ade731bab3e981888bf7e7ca'
            'f4d90350080b1c4a30a3264ac1b738f88ab05924a0ae8ac70b33e396c6e34a84'
            'a097b9086653656e24da94519bf8d47c661e5d70e93f704cadbf64e8e3c857ee'
            '7c1b3e9d287170b7116e0a4efdc488792d413f3bf7fc85d573f9db18d7843472'
            '25c77dcacfe93fa183fdf6d095c6c7ae87b0b880f6eaa1d467fbea7c80a390f3'
            'e892a703a8f5d116275a07b49de80e7f9e6ae781e721a820918d5fb94f888af2'
            '79732dbe97e89cad4d0abd5126b2ec09edc8f3759d64fb32df7c27989bc5ade1'
            '953b90a6e926218d66357106f13e0145ddb0257d639ad4fdefaed9210699a4a9'
            'b09a5f613f75e85810fc9fb455005cee2069bd6e821c1194123bf5944640b097'
            '13305240f27236d73b15bc8ae43e901ae0266418a694920537e9b962d91c32ed'
            '67cfd46082c6cda5b1bb25df8aa813eca7840d785da793f5bd85508e1dbbaf50'
            'a987fd58ba2f5e5fd0cec4dc1ddef5a01f7008435f78d6fd962a235aa7153e1d'
            '35e4d220f9c1736ab032c265f1f533d57445febff602773a9103af2a1e3eb531'
            '2cd86aa94993cfa7c66e387c0b882e6ca640806a5b5acbd3410395c3f4a5f385'
            '6d0bbf16322a01434ea9dbb38c633ee6b713d231888d63b4eda004fd59b98b52'
            '399c77213740398994d62d444c6a145649c3f62417746c340e7adf57b58e2192'
            '33b5ed26ad3c6fede74d4b5f73f1b8e10ad8531a272fcb9eaf0b7b9d095c9c6c'
            '25a3fae0206d7d7a78267fce47fceb7fe844267ae451bc716e30b3d471becf89'
            '76e0a5e7b7a6243c7c17bcc158aee2633630e7fa387d540c1bcdff102acc0566'
            '7af26884c92b7cb4df72a98c3387ef349d7ef1d0b00a4dfe3818ed6bf1f39e00'
            '9fb7ced14ff8d1f7d702eeb0b84179f14f5e5e11e821fdd47e1b3e4141402451'
            '5dd67d9b8afbf3fa57955a26d93084121691d2a14f7c17ad5715f4bff1cd5330'
            '647565715d073094a0996dd77eb766109f98ffbd97a49c5c376ca41909f61a48'
            '33e8f7c0c85c1104a488add25f4a4415f591c2a754210e7f5de6e313ee48ea20'
            'bee6336beec94c74fea921ea61688d391772fd105e0b96ab9c4e978f7f1385a6'
            'ce4d52f108a66289ee7a6fb00d3c83d77d843994aa49b264d5c0dbc272adfe34'
            '41a0308b308c05b6dde38894a001fecd61f987a4d02c1e855f50c0e240d325a9'
            '9473a270c6e211eee6761f573481c23deb3923a1e1d94e622626ecf74a1f4d67'
            '4f69406e663b91cb65a7593055c7ca76c4adcb5c78859b795cc1a4197d8f1f36'
            '2d64e6284bedae82a99eafd32905cf6e5a0192c8db04fc5b5dcb5b3e59bc6473'
            '8f54573ab4ae7dc4345816039c37f1d52c8ec3f6957aa8087628a4eacd386a4a'
            '34ba7cb9db09c70f4c585b8b01424e793a4a3fbe29bb64ab630077d9259f8ce1'
            'bdf3ea76ee384997d7ea356eb43f1caa387abf3ca776e13de17a5a75fafcbb75'
            '8f288620213c9d92d3e023fa6e979aafb41f453dde94258c4c4d843a84e5381b'
            'ca72697361316dca22edb88342a7f0299d047492b2919f741ef4a3644f6fa6d9'
            '12059faa3c8dee1eef6d09db9ec172da3027a0e3d4af15d370bd751453dda620'
            '81b9abe6fcc1f421beaffa966bd228571ee9a27ee1305e1bb1b0967ede1df167'
            '7f63b22708f890f04dac5ed353fd551cedc6137513ffe6c2c12a0a8c6ef0ab25'
            '3664c80dc0d6cdb925d8283fddca419205fbde752b93e95799d3e988c7604761'
            '7a0feebdd401e8fabaae73830bbc29c376100b51fd71eece87fc7a10d15c6a9a'
            '899f01031f00a39d28d946cdaaf9f7a79b17f68c3b04dbe663697a9309273052'
            '5a13046e76468d7180d02fb1da8bf00dc67727552b1428d3be279443a22a1957'
            '7cfbf24da23bff08c1375470198c3a9378e3f21ac4da2b9ee9798081c65b8a50'
            '9e4c9add56dac68821df183ee253da6d4368bcfc8845852d0452eec0a2ce1802'
            'daa14e755e91f545c2fa6e251c3de5b72dc577f6a27e37a34a6347c78c58b6d8'
            'f2c3a97b8207d8b2c5f64d1f00bee7dc5bda02e7b5c19142a0643184addaabd9'
            '35a691cad588daecdbdf1166a184e7dbf0a6277ebfa651de3cedb3a801817c37'
            '7b33c6dbacd6f6fc12ab102099ae1a7a408af15b0bd9ab8c141653a20e4d1c8c'
            '1fbd424679fc72139a9430f1f4665d42e16b5609f225347c680cad65a9b25262'
            'bf1dd1562a754c2b8ab68ec9075943fd89a286480f1727f02db2624257f0b476'
            '2024c962d847e1eaf47b3f94552cd97c74dd09f46ad5051e6cd6127902551661'
            'd8aa7299d016f08926d7b78acecafe5c1e67f9e7188de22fc11ab06d502ce407'
            'fdacb1ac84a10be231bcde5ca74b69fddfcedfae5f3cbf97878100c64cd5b96f'
            '1023ed0321b777b9d56409b2bc9264cdda28166f2efd6f4315f3b3f1ecece3ea'
            '3e3dbd9f5995659cba542886dc83a75f3ab375d4420addebc9feb87cff91aea7'
            '1def3a02a4ed74d9a91617ef252fb7df732d0c5c1d2b244a341dec58c170ddde'
            '56e06f25c13dc8792ee76bcfed7a0375f7c4d2b0ba69253dac72c2d1873a00e8'
            '195029d39902a2f1902d6eaf8cc5ce67e77c9ae6f268f6c6f6249bfe000c2978'
            '3df1896a2233f4c91116ece4f9c88e79164311cf8a99f1a0fbb0532e81ab29ee'
            '3b3e3e71d9135e41ecc21625c1d81887c35037457fee6d977cba4030bb6f32c4'
            'fcf88624fd60101ac4c8f76131d71ab9cfe989781cfea56a7b1d688efdb92d1c'
            '8b19509a8807fad386dcf440e2eedb5287ce86b8c6d319c16508f5feee5abdac'
            '15b3cc7803af320773abaa3b111d46ff211d6f87aac69f08ff988c2beba12c7b'
            'a5c0d8c85502a615b06ddd66932c803c6e536457a97fd1ef1d0452a0a81c6528'
            'ce2e1bcff6e2f4b8ed00c990063e62a40e1ed8c2d208b997b39524870d96adba'
            'ef890c6a6798373fcfe734994004f49c7bdca634e75037f6af7a44b2acfc878d'
            '09cabcca55a435205a7aabe8c680b3f931f47e8b37b98395a896e8c045d92fb2'
            'ada6d1cd152f0ccd830332003ce3760074a12eb468d32757b4b152aaa36d2eeb'
            '40c5567f9e24fddd5d40f5495031bbc8844cd5b5359e768504123c4aa16b7588'
            'e6381866714757393ccc2dc6ef40d91538e48260dc902ddd9fc1cddbdcbfc0da'
            '1e2f9c8db375709df5415d036c0d41741200b079d7e0b26482c2820ff6c98fa0'
            'be30b605f5f4c21385913ed0d0cb0360f748ef9a269002114be24dc9eac1d8c7'
            '74dee8e7d3be0ff21c15be2bde9045b4e255da66e076438364c1ae44a862f883'
            'cba48a5c89132825fe928940bf0de52b28dc5ed8d63d66d21a292817e9aa5e3b'
            '4c7df659c09d3d8e5e5e94c87c4ab0af41b49bbc7808f0331e98ce44e5722e8a')
b2sums=('cf58732397bfa11988b79901092887d53c3367d09f63da51ebdcc83518be3a7e9a638fbbb1ff080cd7abed633fadff03d1d7a3928b772de57b14e46e552f9462'
        'SKIP'
        '60be524612cd85dfb9e0f59a1a20c57c9d6e6d53c58338a3aede47afe1c7df6c5cca388960fd280f47137df7256e4fab3d5ff13af6690e8c3d94b2df4bf1c966'
        '0b50728bc255451bc931394a3f0587d531336a5f83136aeb54f6a8b8ad27d7782523f36e4d797900a7b12e62221f6699b2f905c89295b2f0a3ecef19497fc2f2'
        'b542c43f64a7951b939f8bd4e452b46b88c1e538187f855adf46f78200b09738b2639c7f9ec62cdfa59b4b35c5be8941eba4e6b9e48bf7d09e0eb5d7fd4dd163'
        '4b0d9ff14fbe7d7be018e7cd946ebfa5b1a650bf1240e915024f54d430fae8f5772cbb2ff6a0cdeba55481bd43591c17095758df6bb386b9e7d7c52c15ecee7a'
        'be5512cc4670f0114bd23f25e3a8e3a8604874ef80b9fc2b1cf92047b05a9fda250c8dbdaca93480d44ead6fdcab84dccfedeba79e9a6928e1b8cfffbff75458'
        '9c3565b30dae3a55b6a45eb2a09b89931b21a4a027c3e06487c8db3dcafb0db7e6209eabb5a6735f96c3e7154e47ed2db0a8ef93a3255de4aeda395c68d7b7b5'
        '9350cbc5bf2ca7205dc8eda8c3f8dba26c1a37f8091d88ece050e30726bc818293641668b27287aa4dc524a9b6797357ae366208bf24d7591311836f7bf925c4'
        '5e772ad8aac94cc8cae4f323061a06c896007812d0489177917c72b1005fa22fd2bc571940b35755acbf407872e61ebff1b2a3d8c1198447f656f56cdc471fb2'
        'baa971bea24c128cf42945dcbc8e9b4a3121c0b8181750b1631bb61ee71bfcd27acaf92a3c2ed008ae800f1975e71ec05467901d83c5dfe51497cbaf8309fe2b'
        '8784259647c8aee9d51c289705bfe959bc8791d7333ac6bffdb3bb548fcee9273ab442a4f50b24c156576a55122c3ecbab7df3235b42b0506144490fc2788741'
        '744de45bea461d6c755c21d38ac80fbd640c2da6e179f80725f180d41ce1db1a0c7069728bb3b0edc466864c83dc1984e538a4b7c6391e50bf9bd2a2094be05e'
        '44e8343bbc2281889eb96f5217af28a438cb79aa0533ac3f1585117c1599dcddbce4dabc10b9971c124f506d200add986b3cc018f8d3051301085c55a9102d7f'
        'b5798d646ba3342b2eaaf83d71fcd35051244ab8580e0f6701a59c07ffc83e15146991b8bd0b030a179da75c4ab172c6e00f3554acdeacbfe78462e0a3ebed1d'
        '15d88d92e54ec3a158bb4362724831cbbcbc3233bbaae4e2bb452e2c1382a0899a8043dd31f2349785fe3095d8433f7b368573db97f97326d75cfa1278488eef'
        'd048a7b15f9e4c5afd21a64c84cd424655e9e69d38f75c2334ec01eea653cc2ac7e6a02212b723a60f3de48d98162eaed76b4ea43d21855ff78f0741aaeae678'
        '9e66d21178b0567a4318a6b6c2f2c289a0cd526aa632cf9326f258783a967149e9234e56075897981f99ac0c3a9b699926f2e660f8762db58ae5bb2594f6e87e'
        '9e57a19c75a437352da8e0355ceef82741362efe3b55e110523c4084faa5c0a30647526c855965ffb282d360623fbf9ed12e3fe524a406f2a2cc8628b083919e'
        '0cc7926dc3974de8a37f18c86841a315a6263fc1341dcd07def99d5b915079fbe47acf8bb417a9c58233cd268236ff7e1d2dcf6ac3015d258d802eb9083cb6ff'
        'a278d1647686a2b7c94c0b8e01bc966fc2047cb516d62ada828a6ba015cb33a14951a87fe0f9d58512c4bccfe7f19735fd59c5feee51e5dccf321e9b3cfd152c'
        'c0137d0c82f7efb30deb539d4e361d6080d84d32a4596bcc3a72128bdcdcc859bc7fbd718ff10026ad9774272ca67e6e88a4846e300094132e59316d23617b80'
        'be69ab1c02a538988ac62658713e6e1b192311f603845596f8b9dc1f2d1b9632cad50b9e8fba84b5bfdfde53bfc2610f6b3f2c884205e931b9ba321d963052f8'
        'f1898d67e4e2c429dd61ed1533604bce926fadd43289dba178899b746b80520d09aaf02105fc928e6290459c03356921244824016d6ce6934840d8e183b34a59'
        'eb80b96ddf4151acfe9ac02d593b19bd4c9e051d3bb891e504e5435d3dd28f50c0f36dac156f7d2e93d1705fd6bb176304dd3b6a1232b828a2eb3d0e297c730b'
        '23468bb232a5626faccb818d6f87a40c7990e0ee53f9c277189435782b699bf5be85dd8201ee0c7f82f286decc711a23303c6edf230d2a883e5d68b86c283d1b'
        'b30210e18315b790b2c1b53d2b5a023ab1ae49b65b420a1e72d105589c52efc46983a0ad920dc2e33def89c00e6999ce5041d4c77789d687f4a87928a8b36c99'
        'e45fb6ba29e62a5b13bfebf8242aec8f3ce6b9f40bc17f8232a3e23cdf1633b751a3ef64582801a41492a6f3276d4dcda131e4540b357e360339ab7e830cf7d8'
        '4381303d5e0bc0012f429198c371bc96a63ae7be5957ff6ee0c0f459753878a1e8f8a3f2484cfaa9162ad8b1d7760f35948361782b109d25092f0447a3b04ecf'
        '040b1153f6251896a27e575ba55af39d93078da982679680f8b024357c99c6e5294254c67d295e09cbfae102033cbdc75bed1ed40056b45df239d8e338dc2c34'
        '52acd97f22503e32d94031b08d68aff0fd470aa6ae93361a2e9b530d62d063420d89a835114366e972c65c41b47bf4d12f5122d12e11e6bc75145aaf64d462bd'
        '9c7041114c6d3d5034424294163a6d90a88dcff75cdabc4ddd1faad0eeb5b9e6edf3a26906a772b7b989086d40fdaea1f75c2411ed4f8c80f13d6f30429ae1f6'
        'fd44174bfee8210aade09f921193faae7850e709529f3cdf5078e4bd4e544551b5cb63597022d2a83d6f712536b0659ae9dcaa12516d6dfbcae94c8a1f0f46fa'
        '2d97e38c7455b46c378a54f75aa0340f4b5a154867c8041fdd32eded1ebcc7ab8f3f72550021c5f80c333445c6ec537ced20b94d82bd067c59a8139ea7ec6b49'
        '253c268557f678e4219969288130013d2f7869f0df5d283f4ff5778a8c809f8a8c23cf302e225ffa962657510e41f0d432348233678f5afd21568cec06341412'
        '9d5c6cec31dbd2947d459fe0153c70c12d7f1e61a430b48876dffe5e87fe1d02d32bc31ceb7e69d8a46c983f4798833de802a13e26877fca391a22299c148ce7'
        'cb8472cb011b95f7d2a06b1b1f7c374a785e372845d705e2e2c411517fd94df030482592da309dd410dde9a05e0d6f59a6bf7546360e07f7b79a007cf876ea95'
        'b33f193d95ff8fb99438af47f319e6d2c65820bc5c573b25767f7c3ef95cd23703fdade7ad1654490c4523cea2a2748bd27ea03c0d71103985dfc2e18bcffa09'
        'ee3cb1f7e3c9057862a4887de39ae75c48c57e215b33a95f117a9fee70d708dd025068c695a233cb6768e65c3c0506ae3efbc63400eed0d2742bdd1c9eb9961c'
        'aa4967a847887c280f7b32633a6b0745ae9ef6375de7877250cb0d4cbaf313e12b641e2384393230712d0e6c44cdb2bcfef71fbe453fc0b848d7be5299f92de4'
        'ee97e17c0af42d82a0832d99c68185ee8b71135df1b6f373a8c99c174814c4dac41c0b61fc06b739ff8944bddb2e9d8390c15660175edb11e2bd1facde6c869c'
        '6f32d433f5c94a79b5266d2c46d536c00fea121d0ce64d44a934a5ca75d6b46e783e3d6cb770ee490e58fcc306978bd67513defb98cfe744b9f740c25a16ee5d'
        '3e5e9c4c253da8b5ab69857252bcea2feb4b01e01d13baf2e7ee5d52451f90338b6387e56b62a3f02ec4f33cf703cfebd41b1833923f6af5591fe505ecbe56f3'
        '48078b73c5783e567d8a9e749f3dd2bd49ebab61508f6952ce67df1474f0709a1fa7bed4c3f14db6a35906b253b7743283ede59a926cd47158b43efe44eccf90'
        '51bd9fcd9e127c7ab23eaeeb7739e6ccd5b1b69a689fd8cc75150a2c99895c47be773ed39b54e3ec9547e66accdb985f21db1de9a77c7a3f81dd5f01b1c75e8b'
        '47fe04793bc57d00eff2e421238b764da08b000ee716173fa3286873537d28c8848fbcd7426c9b6f6bc74c2a262114e205fb87deab2f915e8db21102439ae1e0'
        'fc7d202054198b6108a3fca4f298932675ddc72cb16543dbcdf9c6398e01b5e1608cb079d1bef0fd48e85ee0fedf5bc0357e433c828b7b6578832530f8655349'
        'f6ccdcffc87b8fd8597d962942b25a7c684a667041d9baf6d39cbce198d119de0443d3824c652e7c9ba330398dcaf9c18635e025b9edbf0f5b46a6e44a657ec9'
        'd193e59d0add2610039370f675eed0df5f6e21d6b8e0fe03f17acd0b252dadc5920179711503b5562322c4fc3d5f4c0f1178ad614942e02aaeb31bbef89159d0'
        'e44079f947c57ba206a1680599c8f5b2ffe6f16aa0f2c55536a362ff3012c49265b019ba113b6c4ed43951e22ce71a971f0e2402118f1453527a4345fddde6c8'
        '256c82753379e71c60eecc99e3fce1b2d7a159e5fe607447ded373f14d62a488db8d6731b149627044dd78db08288777007de6deadd1eb99d8d08cee45eab6bd'
        '3fba31d22da30327f50837f2079ebebf82b74f9b27660692b233f68db1ae907b882993557f4477ebf339a6d6bc6aa9664a6474237f3d760d89429fbb5bd3283f'
        '6d0a6af132bcbf2480c4864ddd315f2625258bea94d7168286350c773bd4a64687785ff9a5ca78938620791b2959c04b3414a233ec0c6a37d9fe565f39e7c781'
        '7930e5df3c3f750fb781f4b7aedd051a6d8561ca63e12b0f2baf80b1eae5df1f1f29b840bc25f2b45e93bc232c42d7cbbf32d4dfb47fad7e8c45d70e67926afe'
        '81a8e8ba86da5a52a0dcacba3aaeb53f645c83f0d4c2b5bc2c997862f3403ce458dc2a09d5c03eac60ba62b7673ce70854239f0be6ade2fbfaa9d6537bc7093b'
        '572d478666ad962cbfdb51da1b96dfcd4327a2a8487ecd7574873524a2acfb25a22f6355ea1340b10748e6adf72ebabcaa249671dbe23b28d4d462d543477097'
        'cfe8b1ac641baf8018e401a6b121bfb68bc5ff908a6d5128d254ec47446084aba05bef1aa8364491ce5a7c276c68410b536f611e414063c3d409a1a53a1961ea'
        '17a81ac870970a96127b1fa04a253a9fcbe98247740420ce60db451d7c718c4b58e5052ed71081a2d2edcd81d34e2737e6b8761abb8b43fa93f2b937462de0bb'
        '05751d86a505361ec60b1388ccc8da41a67f9c5066216cc4949dd16425279a5c46d6d574ce18dbe7cc9f3523d6b8121da62ced9e02d8940a692744d740d044d9'
        'facbd8d5429d062068190b6c105ecb11cddb0388c25a1596df2b58833c83822cc37e08657b858050de107abf045ed4d83e8644393e77e203bde3698c72517d85'
        '37fb5bb6f2a4b05a2c92bfe1f7dedab7376f80a65081451b6753316f5deea7dd139c89fbbb1aab57ecce226b47131106c43ca714a764e99e9bbf9b8c13bd48ca'
        '4ce5fc614d397c7879c86e64ee35d41ffdb9ccb500f7c6b3e2f26a1d9564eab2d32a9105a4fefbcdfd9e690414678057929a8294212ee1c6a2dc7ba4ce49d304'
        'c8d7ea0a0c15ace1502fd3f05ce7b6c17763bcb8e718e625638c1d468f6fed913ad70843f674ebb403e1f1139b28186108a9385602f8441d11131d0455ba5c63'
        'ef32500c0e817efac77cc0305675d72c8cb4c01ca9bd046e1ba7f2fb41b27661370e7cdc0740318a899e24b0f3cb8b36d37edc7c3431f8d598d393f7c620ecf6'
        '7ddfccddb41bb7d8fe65cda6f0ff0e75d8d3077e8e6ba4b18eab14d07e7445e53eaf1df8d4d24b92857dab466e1971e98602ffd997ac8f8a6e8daa62dd378195'
        '363a0822baa650f72d0570d8100f1325ca9edf26cdeb9fa15ad89af9d15deb76dc0db876fbbd71ba18775743bf96d5cdad0be7d438b29545a91e89e241519f69'
        'a49474416a1cc30b18032d92fb0d8c13ad03b295d55b774df8940f7e8424bf84392e95945b2326bf741ade8ec742a0df964009dfd555100221a6ddd9426633c3'
        '0e5ec8ec5a59db4c8c2e0b53dc83f07dec49dcf064ef0a27d61af55e746498ef31efb6809dcb8a97d20f5de538772a0df6c9e873d567b11f5fa540ee29a7cf90'
        '1dcfe22f07d33fa8a20dcb1e4104a5a4282a1cd63879f177e3e9d1908eb2474917b24903edfd26fa610f68cad7bc071be2e9ec09e4219ab6afc43216943db204'
        '273fb410774bfae4b602e9a13779300a21c538feacf207bb18d227b9410b4181b66e5bc7aa91cf41833adbb894bce88159ec7dcd61482814e1f9f27453fd8f14'
        '87c6eb6123c50f0659fcedd342970afb2d4327ae2ccaafd0e2fb853a2af9e7a20829360807789fd9e7eff7e145421b749d27bdb52b1a5e53027fdae7b5a6723c'
        '6100121356830db7306499409b3b2d52312bbc9426475423ac7d38369bde21df41e16fcbca02bff4535d56d9d4239fd25e5e3da654f0f5d9c5fa6d23eb8fd18b'
        'b85ede3756acdda5a6e7a429562ef89e320de4ff3066d6df37854633cb6846eda6522c249aff22c3246bdd902691813d14f6ae942b17bd646a94752f83bd0105'
        '3a0d787697081218b5a108e8f99dcf74c76fda1a8dcdfa86657911c7af9b8d695a5ea6aa3794eef43f637ddaa76ef6f50addd3d22038968ad891372c4f680ea4'
        '71d53e431251381f0ef43625d1e796fa205eda273a54721d350c27c930b11b1a242fd4c81a026d9edcf53c32f9222b2c79436ebbf4567b882b0dd3cc02c52219'
        '6ba8517d7f688a6b32d2621fdc5686bb36528bdabdad34af8124ecab031912ea498d37f1ce1abbbe83658eb5bc0da9ab7d2f094f7c99f7de065756943aeb7c2c'
        'e8de718e94e81d235ba40ce5caf8dfb3ea59d4a0464c03c1b727b1896cde8cbd28db4153cdde0d3c02a06bd5de94f919e5189488368bf62d2daa5ec9728a88f8'
        '297c700f745c4af5e92291dcd07ff6d9aefaeadd80bd96b972a2fb761e132dc1771594effda7427c300ec4ff03625dbfa46ac6e2fa2f2aa8996d6c5c80107d17'
        '6176a003573fc3bfe95c2298ccaa4b6427af3ce59cca3809e8ffcaa1604a7109176e945f6c83f3a310b1316db28eef6207c468f34a38fdc4621f755b8370e4e0'
        'ba36f493916603f8e0922a095cb672782e67dd1c10a0314c08433f1865b32b9d25bdcc3d4a6c1e917aec517a4e97e549c48c25837d3573251a638879dc36a734'
        'd0f3de323d06d2dff5a19ee85d4335611014150a825d00f9cce81439d33c38d26fac3f6d548082e315c7dc8cbb1a29d8c5dd407286088dc807ebd0c4437b7741'
        '378a6d1bedbfaf6cf1878f32ec7b8f6f5e4944caef69a56a20ffd3b5a9fce7a4cf4a7f5ed161d1859ee145c8c8f1923e3a65e8a7447dc0df9739e63b10dfb85a'
        '330f2e210a0cb3aa9aa598db04556064e138031fa9bf3dc2c9c479bf202a7603f6bd18dbd853c6e49fe92e8a33b20b48af76e4511966dcd9a2986ceea6c828b6'
        '1492d83f2e78517daa64b4d8a4d0a9eb528d5a11b6a06580cf21a33418ce9d700c431076609435ac4f1dd6f14ed77db107ff813b041f0ec2e3c0b64442b8e3d9'
        '76f6302b396e987e644a2677fb2325da6aced49d2e861dda60220e1534f14e517aefb0a8a3ccaec8e7abdd322ab9d0be0efa02626af025131db0d099fc4a0c22'
        'a4b9e2903ac370f51f609f9a8d185cb17b31db56be1ae4a75ae3035ead75c1d0edc2f7b370f6b0de344f5f04e12549b288d150b9925c16f57f7a61ad4adaac4b'
        '82a12b13f6db2fa7a2df5669323b25d7149902bad67aa7be8b3024d5d798a0b1ece2e6ea04f54f5b5b304edc3a7579a38e2fc3f32a1ef9e69e3fe90b361aee9d'
        '19d7cb9e71632d629b11fb520ee4a12f28afb9c4940e7dc573bc3639ec33f59ee1efd8b8988ae7aa283a76219196040ea17dc79bb422119113ca3cba8c7ed152'
        '7ac493a15a0b42cfa0c577e7574dd2031b7611a9916dda5b7e124fa50cd8c3c4574870cff5322be3ff912a27991654f9f3379fa79f29055a4424aa087d60c4f9'
        'af1c86234ef40f51ed166a374c1322f6a0ba71352186473b6a93b15d1abd542fcd976513060937e04944024c64b4106c56bac16a179e912a74c3d6174f62e4ae'
        'c99e94516b4eebfd7670485eef44517afc07d1a3c8bb27fdb3472a32950ce9b33dd5390adf5d02fc03d3a9390b9d6a9704f1103002cdfb1e4af623ba13b76c11'
        'd087d7dc5059864c01502765df45d5c50041e731a8d4149e0768c368a10811fdcab6cc83bd6295329fcb0fcea5f930dbd02ec7ace080f7716f85972ad69e88b9'
        '48706c5cd818852c1039a838e2ce8d690bf8b21508f6949086adc000a82c726440051b46e89d053471f8d5afc2ee69e2b1d078000f5668e1916b2cd8cbe4a63d'
        'fb1d14f568d3c41eea09c2b309204d38a415c7b3accedc4e698c01562090e900122e6b4cd67be1de665153c7493d168f0294851774a665319e564786816ebebe'
        'b39690eca5858330bacb4780efef734460147ec37550b753d2aa87b711d79952e9740687d67a623dba48788e08ac8df780618cb22205922146939eac8d6ca59c'
        'a10367ca29da28e3d4ce37ec9597166fb1a6ab41d4d314103fcf1bd3e1525dae875fe53016d7ee6a1fcbbf029137dda0087a688480ef269898dc9156d67f16d3'
        'eb1ac70b2ce0d4216b85c9a33ea7d70a06b73cfd9eb3c500202dbe9eb8834251077c438cf63b6baaa04844b570ef0888c974316defa804ab6aaf54e5f50ecfc9'
        'e659ad24e3aeedafc5edf048a4f525866e899420432c271905269b39dfb1ae29c15db803d537b48044e1d9d7c4ba6d6f558853513cb1a19cd663cfb73cef65f4'
        'bcb2dafe8bb3887a20dc2003430545ff66c021d710527fddc774a7bdd2d4c89f4775c1bcc079ac17bf4efbf07d46cf3d21d2382ca2fa9696b8217a3d83b35279'
        '3d1b054fc09474401e7013fe04fe4575e1408d700c09d0e534f95e400001c498502550ffda3df5ed42667b0bd72d6eec89059b0dfa49bb8c249c570d8655c288'
        '9cee2c218e915fc1c178808d5c78ed28310b2b3fc184798852bea12516b65663cac7d28c2c7e454834deeb9ccf14c834c32e261c5c76db01e9aa366f6b749cc0'
        '041343ed0904a314c02d6d352c580e81854ced3b309567d9ec7f2512b3bead26021a0ffd59f7f9e391b55a11fc79eaa23204d42429528d05d7292f94eb24d2fd'
        '509d9d93dd773a5d6c742dd6eed118a6e9f8c8af520f756cc825fafad349b4f9b853e872b1653735e3cfd1d66e185b654f7fdd335c2402b618f3c34860481022'
        '909d5c2f7506ad0859976ba0ad88ce4cc82d6b2bcdbf3f4bc83d554a516fe1d92ab189c1199ba97484353c2e343926f55d2d7acd38bab0832283210599488ed7'
        'e089e95ffe16c1f2c02afb5831bc69d35407f46a932672e297408975a0dec94adc712d677b622c70077341a4b81dea06c71d137f33f6a220f19deba791ec0da5'
        'a1846d376c779b44c27e6011d34fa13fe817233abb61e04097c1afc5a5cb04dbe0dd9b9b18a0364ca5886a85f3c129202b336e32e7929eeb80116017b7c42e85'
        '7d7440f644bf81b5ca343bbbfddf76d31652ac29455120ad2d2c81adfe022c08b7308d8bfda2bf33320916f1ef46bf2e3cccda50d28df616f8be3a35e9b36724'
        'af024f792328bae7cbda449aba8113d52b35c1f15d1ae55685c02e138ec6c19edda090453026f4082788926ac6255d640e770db27267d69cae4253bdc49f8aa0'
        '2ded3ffcd74db1713cefca1c8d416c3340265fecd9e1deeddf65dfb200db1889be91e3e1b9c82ed7a8312e3f2be7235637fbcbcb8714de19d20fcc1cfbe0d72c'
        'fb73c42401f466d3801fe09b074bcb84b5d95cdb7a480981f5f95bec21568ad8b1b1927c478832371de66bcb6796f2362c18114f8b8d5ff64b73651b9b433f69'
        '1400a3e4c20b63cd817c5801f381c9935d7d783e8c1e3a0f31748b535f0daeb618486a15fc99503b69493cc9ebd7aa02feb8bccb6de21c733acfa08a8998bf9b'
        '56e770067273e2697bf460a6bd61c8b1ad1de02c97e9524776e3cef195bef2e503542d50a40711b2017be56e4e42e6a9f9c6172871b29be4ec778517c541acf6'
        '273a8ca6cd305a7599254856f46c9033685438ee336c6520b948c007d66bded7555030d2fd8914d784fa5e1d76e6c5853f12f84003810d5c370433f807b6f54f'
        '8094fe701cf33c5e2c524c9f315a3e5d04d4d93f78c5373625bf08b66b9d4f0223e5ff43b015d7fc6f5f39be9923d8cda2937b7949402e5c4582341fa639407a'
        '074388b50f399dbb3d7bdd19e8aa82fff42b9b7d8035a86c62ebc3b74528675931f898bab7ec968729dd68ad9a8ec85961b576beb82c9b5dfe3d61751c60c7a1'
        '10b9be87258cd0bdd2716eec6cea366529ea685d7c4f1f1b252b2615048c303f298b9b3ce6245b137684a36e4000a25890d49a8ebe1cb40139469f80f14bb61f'
        '1c745a5871dab8255132ab66c2efa8aac2f439e99aa92a41714c311fd7a3b7dcc155b919bee6ba234144d7d100b30e7945d5eb406b37ccdb978eacc72a50a757'
        '25fa2d9978d6314ce1156918bae7cf4ae29d38c73454965249da4de313d0e7b0ebc8e19fe08b2aa11aca788c2532d974587d7020bbb63a302ea3e89294208322'
        'cc8358e11a617fe2d5edfe59089b202363645539dc901ca9d8c1e8f96aa2199a82ac12009eb8cc080b741f7794cfdffe5d79c282ab51d40b3dcf3865ac5cec23'
        'bcad8b119d04cf31255346f47409ce33698720d9c7c0dc14422cc2c884673c38924a7b227a698cf19474fcac32e22ac62e9e546291949793a501cdaf72864f0a'
        'd35e50d1f75e04b79cc71d1a1e2911e7e2c16e14882983bbf014d0602dc249ec45dc93cb62b5bf1cf07b9a6afc4bc0d87ed771b03b16616ee9527a703ce4ef82'
        'c2875812ab464ca95f5c27ebf55c7f269318a6f999acfbe313016b8f473824e9ae00595a1e4c764c206a1ed06497f99614de0476fdba4e9fea7b2e753b6e94e5'
        '358d7b4035ebd7d7ebad841a5d4cd32a6c610901c7fa76d35717cba576cffba5efb5a64fa242974d346136c5712aff076375b491b64faa7618363a6cf7044aca'
        '1a56b1ce4d7595de83feb106e5066309ff9e1837498463b8186685fe723146f6a22ad7297e5bc4745daa1cb13adae7e9d56fc4d3464248c28f461b1c081c59f6'
        '11e687119222f88ed025325416100ff22848f70a0305d31ed6f8284cd6db05014c4300c2113c17212ae06a6119a494d13781618ffc7857db78caa970101c3172'
        'cef1cfb786da1696004d5d27d421e10177c3290b1f85cd44e964249f5a86dfa338268c17808ed61641c134801a84b9d357d61b99454c5a52ddebcf160c98c393'
        'b1f6b0c32e115ebf7fb81103e8639467359e3a46b36419b64103db61a790a51ad2c7f1a8d0d6920a48f4714fc241b09bd753ae98b94d8ddb3dae29add0f4c028'
        '0003cf34ad9112c9a35995d851eabab5d730f121ed940bdf53b2f1e7ab70ce48d5e7f904e308a80664c408a28b6a67e4de16413b5d9850d022d8065b6cae56d0'
        '23d1f763c56ef3511750a624d0bbb601ed0211b9f22642892cfbf07eaf6ef45690074773dc5a73649cee904f12c0beca61d6a6cf68f4b93e3d1c37e1840da096'
        '703effc681ffb7204acbbe5429b8eee45f525da94a47139f8de5084122dd26660878d993852043fd8910ccc657975ca043957167a6999c49c44c09c5bc7a715f'
        '911a2d2baccc5d03e4ce49ffbbdf6e6288012ea2607e30698fc36f236d47ae21a23ce9b6633e7d7e17329c4206ff245a8ed954b5f3b1172f4b50e2ab23da2803'
        '1a0d7de0c799c3930d6bc379d84e5049d2010945c75026e5582616b3e9160406de31861fd1f06b1adc3c287f9db5758e08aadc24a9ac40684790ceb860fe0348'
        '6be075d850631377644dd72db47d121e3f3387c15abcfb7233b26eacc1915e8b3ac276c651527ad7146c0dc73afcd5be77f03057e65e1c18f863428de79fafad'
        '242e9ec6ddd3244e2398e6571ea692be327cc6be2a34b1376f699a67a31a615e4ea3229b021830252674f34c15e6285659cd9639731ee480720b2aa43c481581'
        'd9fcaba41d0dcb13276a57658218d143aff75580a1ee97af00c7a842793579556bb7d34f2e27323e6747fee0b74f741eafa27c4c6bfc9b21c313c8ac3bcf98db'
        '46182843198b7a801b6da4b74c169407082b0b82a6dd99a4ca6816b03a88f5c84c5ad9c6be932b167b70b5c978449064bef46a7ec60f4c51430f5edd2b70ec7b'
        '5cde4db70f3d24426ba41a67e736fe17d3b38c8df8ab6a33a1508c0f4fc9eb861879edeba2f91639440fb1f1e4d617f05194b52d73e6c1d5d3c00457b4abb553'
        '42642ff606c17b75996251e84c3e286d240355a7d54adfb0b89b0868afda87f511988e8562c471c7d5c2cd7f06a71bf5d62b2b1216990106e2d0b4495d76b197'
        '76732fc05ddce8d6bd588a5eca44a778364f2e2535f29afb5d7c3ad69e27c9c0a53d261884bc115f2931810e4395c5d21a282156008791bcc626196155fce60c'
        'c03196fbbaadb068c42f5d00bac818299ac362e9cf5c9e14965f9b45c20b8c504eae2b79ca271548064f8cc2beb709ab1f0dbbe52f4cdffc170484be22a2a439'
        '5ee36037f221a99fb905fd3439607ca3f718a086aa9b1deb9c5c67f23b8fff6b4801ccfbb12bb363fc3744260408a8e1cc6ed5616aa377a58ec509d5bff6f0a6'
        '56b37c90639203d9262c72230369de9eb5d16e9a7104c5cd7707225b71bb5a2579dc76c60caa030608d0ff5899e3b91d418065485b114b3e4e3cfdafdd73885f'
        'fc97198ba50f3f36abda8d45afc17e0075d9e18af603480b5798e28aa037894dd9dba2d536c61d29a31353a9fe8d6cb04106f5e9a245422f6551f11629bf6f1b'
        '6f41d36e8c1b65164e706409ef2d32e81bc27b1955553c89410e54cc3326c29b6b97fb08bb7dd970a2c37e0bd88e08cf563755bcfc5cf3b87f727a1bb89dd3b9'
        '89ebbee8f5f56d8ff549d68abaa8d673e23f2191e87f1b23fe7bb537ae303c640d530354caf3f3f209b254ee202d8f7977afcefaccd18fbfe9592ef5cc4e830d'
        '695e9b8158da8ca38ee92f1c82cb7ea280b29e727a1b4fa4ef28d54ede00c57af3149ec60f75c3c994243356fd88816ddfcba66f9cf86c2130c476fcdd67c938'
        'ceef4a697f77b117244885b595f8a9902e3a702babdda711b0f63eac48c787a53248f37534a3c319884a42fd07374c58184ff815b23950a2504efd1e2d44d3d3'
        'dde856c205447cd2d5dd6537cc1b21e68088332c6798a1755b1c8b8a3c42bcd592999ad43e9b1d0e3edd23503127f11f9cb77b87cebead144b183b438639072d'
        '06d1075c8260aad91706f24a73d4e2630a14bf8e019aa39b857d8a9a20910914556d9b9271161531a530dd05197736fd634cf988ef0e01e4a0cbe9827718b2ee'
        '204714ee9b8c9e628d546cf61e27b004b5f250e0dbf977c93f6786e6f66da0c56eadb4ab9b52a4673bbfbc4cbe60aaeb96edc25797bc22d4b72933b0cf2df242'
        'a7fe0e04cf03303b7b5017299022d7512f6e2a554fc4f0c6e8e83cfdb906ab51a7959b5dd321f53554d8efdeba049c49bccf6b6075ed6950fb99ecec4f741c59'
        'd3098e03dfc2cd96c4ec0cfc8f36f331c7979bc9a0a1f23e34bb87c2f0c762b7aa176e8b1516d740037d0c2a3719bb9d27a3a853fc9052e88e3e28dc5501d1f6'
        '0d860623674ba4b8ccc3191ea2d051ceec2c9f7a47c69d1a09195256882d05c0530fe55bfb0c55e346f8e92e2522831baf1f06df5c5aa80b5c8b2470bb290fed'
        'a107dc9764f1477c368061392a336809ff1f769d3bc2c2fb2b4252977397b29bdb9920c42e86e22bbda1dcfb2b3c67895f8d5dca09ef492bd4888bd1b3b84616'
        '287d04a11e5e77559692dacaff6ad9cdf8a345d4b916f12469dc4494a590da68b50401be403375f78d44c9e5d5934d307dabf6a067326060514db0cca6cd1c89'
        '0c94854e9370f65b6d5d4c5ea793c455f5db97a7f95b3e267d4b6fc2e0f5021558a10dd5c3756fcba33a3cabeab9f4504364cc4e8ba791466682234ce0403593'
        'f2e0e37741a9c27f969e2cfd77ff2bc2a30ceae01c49b6635491ce1283790b11c523af7ae8d451e547b119422e2d649c77e1dc071bf62d84e871ff7d4e736400'
        '929dc53e060984c6ed0a49699264823cfdadd8ce0251c90f2d310d7697c8bd55275824f3950ef765ce4ed4fb9be6df98ca84c7de3d3ca466ae4904030f7e9533'
        '8b6202ccc6346e80cb09963faee65eb6eee68f05c66aaa8299042d2461d236f8678d551498fad713a90957b625c3a803056b613647c0e0fe74b2aad7feba61f9'
        '9bd1b7a8728e48b0e66bcbcdf6a50f823b9ee30f307c51b0bf1753614df7f048c08da2fb6bac8d16b2ceaefa9a6438ab43fa61892e688e9e1e4ba0fb2077fb69'
        '867d93771086c5822eaab35ee23712de97671cb29dab9f14bf4019c583b162a6dea98ebfffc6ee811ef890f7fdd70a2e304e0bcf2a47c1f2bbc85178e66fc155'
        'ebc58902886dd4d50e718067bf28178af4466209bd8a8bf3e7d847ad810643c33ac781bc35be2bc4d0b6e17cd901eb3166775136f229047f8597414259055766'
        '0b08a82571b709da4bf9e27cc38f330220fc170285add28b59d6c1938d0404ee76276bc229f3f2516b6315115aa571e057965724d0a4202063f1b9cf985fc807'
        '3292c04d411cfafd55f5b107915748ba5ce8dbfbd6f717ba1ec32e5709bd31df5da774f4473842d95fec955e23a0c5a7bbfe4c1241c3371b8ce430470b32b276'
        '309b52ce12edcc885d75fe5c1456b22f42c5d6f12d00562bc7a3aacb7608f1e9c4e51edfb466f416b1ef8a7a4c84d4946fc9203c7465dda29a4f414c36a280f0'
        '4392275e68e9ebf7b1c99968724f549fa6d2cadc68c29a128a8d73ef1c52b0ed0f88d391d41d676251854a00c88caa199c883e576e48098abfb9471d3354a46d'
        '571a34989c3bbda69d9a175f81b6381347e4a7fc3a10f3f765c49a68cd628b8c5917db5305a7246e750f759b040810ab2764886c25433dfc81e8f6fd7fd0863c'
        '7de6f2c1d2a195e0640876e0f547c868cca5f1a314a8d2db11409dfae30c5e67aa4ddc84c289fe86f46cdfb9b98b6c206a2917e9119d4e26c58c0104c99f82d8'
        '899cf46e905abb0b98fad0a488c9c2bad696dbb4fe006427a2624a6b78e5794b7e1406291bd8aa5885c2f09286cabc6fd2ccaf6f7a52c2ec71dc8d5ec8831199'
        '4f03858dc0bfe4fa482178d112a15dee98ebbbc1c7e2081a4bc650b4e24cd7accb3a99b25cf39d0cfc7be75799c9e67459c5c8b44e82783b10fe9e7ac99e3ba4'
        '47de52fbf7136547fa8905c53a1105069cbd815bf1ef23aa723a3e02c54190d41798187490a1d303602a44f45f07e5a75b4572de249dc164014526a48af25387'
        '4ea587c72d669b3333534689b8fe4b0697140392d5b4e9f521b5c60ccfbe9577d7e19f5b7faf92adc7760095dc2adc5667038958dfe8b80a98a53d13b328f29c'
        '362c5ae5525984a38dc1a0e2be82243df46d362e22685e9ad0ffbf1fdbe91594385b18ca0d44921063db27261ed7889b3b14a3bc7030f59c4b971fd7a7391cfd'
        'e7fe5abd721995172f3c869476654035130c70edc2381d72e1477aad7dd23f03ab0d9d3b4a3953762cb5e8256d1a72b40dee40b36006404379f02ff74bb8cb26'
        '41ddfda5e68c132cbbf190da7d8564f4d3e31e4372f9af3ce96140f900c7bb7677c26a3bb99285ecf7bd8de2b6de72598dda23588591161b99734e1e1bd7b45d'
        '627e9799b7df46859dc3d8c222a0d0d65adc2387bdcf4cebf8e66ecf882613eae60717c186c0d707988a7638d1d70db26b041fc984d1a3f11b58db19285a9cc5'
        '83a54390d25e4be1350fc085c333ef482b46de0d6b04777f5fa0e811e2d86d3958b99e44102a04830801f0c957e12538c9b44073b4e2dd67d16810614d530a6f'
        '3af7e9be9f81217efccba233e4fee23cd2296d0080a80fc517a72729c19540a4411bacf824f8046ecfd82de78f7e162f0f2155dcdcd9a9a3eadea9388c47fdb3'
        '9f48f4a7867e4049fdd11c48344977375dc509b337530758d2ed586c4ee78689d0b84bdeef74ec003fae181fc61ca09847e25f30a425e6059e6c16426025c203'
        '70b5b35ba0690f46a9c86694a5e1440ebdac420b95a63f33ad2bd35371d708af2ad4dc49fbe37dd3e0e6b6452433d121311f4031b099c0df2e2c9d0e303c9c7c'
        '007cc51df1e5981df8983a5bcb7b940e03d0eb5786020a4d154bfb038781e50831f6b7db5d011cdc85e7287d08611edacbefc0b828533f2c042112ab3e534316'
        '112be36e9dd272fc0dca41721b67d685920532536d0ae69a107b2b1ad9705cd97e170c85e79e825bdaa60acc7c60b1e0e5bdff7b043f016e2e49a7b60d3ad89c'
        '20faf5d86206c0a7eeec39e27fb7f50d5e73e221e212a2318d6af07d2c5e82e855afd0b79e91b611ce6c20ac46000799ad7a2eecc04dd36a24fa8a612c775828'
        '92637f534d1b3462f6c3526f901398f6c3267428f3b8f2d2bebea43314cea2affa1fa4f07f63dd6ebc1be2af2f8239e6f7d82fd342bd64a7fd9d8e7a9e7a28a7'
        '2f8ba9070261739a7cbeb559200faa89413a0a5930f22d2bb70872c81a9021113987009e28bfa206618f05cf9d3042ecfd8a837a8ef4c6a1175b6dc5b8b13f12'
        '78b8aad18b501205a3ef9bd771ff4dda233fb17a8114b9018aa0ad3a461a227d531e660a020d2d3b2a87a3ffd4927e1f3d567b8cded41bded578b880aa2ec826'
        '8ee11f8510acb0e122bfdd923855e6f2ca6b456f4af53ff0812447aa517cbb629b5eaf006b6b453e51b1df9a43f4d0554bdb20d142001f05065ddfc62d2b2c81'
        '858ce4ab75ec741fdd449c603a4a3a522118214cbf69a234fbe0618813b0ecda8d6ab910d1c03dc71f4f7074b3cdcb879e3c782c3173bd459939d0bc970828f6'
        'ad7ad0920eacfed812c6ea6ccc0b4f2f61302acaf84346dbfa60afd241bdc913728dad44516255d6c339dbfc8ecf6df0b8c5d6886b56b1c71f0d6e7c3b4259db'
        '4f7e55566de6e4ed8bee5068b6db7556490577697cfaa4965f8ee33969653d6daf87f8f47b9c1992f985676f50341b623958ac0f362bdfa5e4b13277b2d361a9'
        'bad692d4cf013878f9a91b6ff747fdb102537c4e1be265be58767c65cffabc07fd874eed92b6a0a1985ed3a9dda3b15ea8a325f8d31538651d62e0752c3e148c'
        '9a11e677c9e49176afac0b8b678bc8393bf89aa9777c6bf2390e2b1d5b6f0327b4a964387f522c2d1dcbf7bed17ccfd4d1d66f61f121f9aa7edc78f664c1bc25'
        '0cc5c8ba0a3e780f5a9b53db75dd5c7439cae3438d4523cb6b4d030583803827aacf866f81806fc20586c565308c3c2f4ed294ae28a9c07c4790c76075d9b798'
        '4fee7539c14470234d1fd9091611f0fedf76842d7590fac52b5402ea1eef844cbc1d7ff937422194246245c2d4db412df8e561e8ba0bcc4ca779a8793d1e8d7a'
        '172d3895485a6f320ec5071378e5d60a15cd27d87ff6c62ad3fce3d2e2e6892d838a5b3a36b949004cadf601678b3d966cc3bf53f8a3c55a32ed2c3674440109'
        '165492e8451d60b9ddf75cd7ca1216ee9e5a024f2644567a081612da209d98f770b6cb0017bef6f50e8048b825dde53f0ce94054fb15ab0ae70cfea4432227b1'
        'f63bd7f0c0bebc15ad5204a3a62105cb54ecee48999dbf044d6de32113fae59e198b670b4a11194d10ff9ec71b858262df631deed016f887e388cea0e4e7a194'
        '7f5ee5c8adcb41b0c8d212e79b6a5cafb69e1e9c727f69bf2e81a15833744836d85c1d7cc11916f80a3420210afa25f889f876a6fd8f91d6badf7d27de4d5f02'
        '39fd83ec371102315d8c72b8b1e32a06100fb065da3413791beba8b5f71175f19eba34201e65f41c2f046a5cc17900afd26bff7df617324df7030290ac7e67d8'
        '20727324a7c0c2d0d89bc0d0d7f71a74879196e59dd2824dddc301ff6beea7bb901a68d6182e364a79e98dbac8e68fafac7e25468a2b07ba448c9e77c746bca0'
        '13292feea36fba8220305180a05edfe905d0784d0aa0ce19535ac565b315e887235e8526530c734c7cb9be7e73eb6b5e3314e173d5fc4fcdf42057becac17b13'
        'dfae6eff7c18bed2fa0c37041c2cebe110bc73c26f3d4d9a47721c386f27d8bb1b1485021b33eeddc397284d02715b21e0c54ea048c9f95979816b1965b3ef89'
        '24f54ef5b3dbe6e655ec861a1e4c0af4051a86d884f5ca1c2d16aa0c3766add2522aa4b5726afbae713bd0a8c9b877e62c805e2284d6bf35bc313ea73820c846'
        '8af4e5da41423ee0e899630037cc68db3e55f2418ac2f21a12eb6c8088e487c47a8433960ac4cfdacb074f56c118d2089145049a09313ba00bd9154c34904825'
        '3e9ef59536237ec3c7d61142a8c8743520dc263eec724deb0020baf1981d4e04de423514af3acb579932c919c3964ea694050d65005e0cd477d328f42676318c'
        'abaf29c43c46406fcf582cc7c6e3843dd74fa9c49d8acf2bae8b05422e153d8fbf740c66980e97e05e565344f569aa27d5c57002634b3b4023bcc7218d2d9ef3'
        'b162d47430204fa64f7610d99762fd0ddd69fff5f9a328a56308fe953cb25bd080fa54538971aa79123b985cb9f1f3b799fbc30bad85e2c1f54bf8cbd3865f97'
        '3781c9331b1d8688a4d5f5b80e9c02d9bcefd2c50addc4fcb6dc3c4124df60464747472fc6a6b95d83e990ad1dd4b17d809cc628e434a6b35d94499af63741e1'
        'b65d2e9d0697b402fa26387a3c658ddb5d24b0180444ef38afe453858978e90d79e1aa05ec6c1e284538e329b4576aa23efecb0414f2932e731d5d3b2788b1ef'
        '599cbd6e0252e196b11cd13bec840e920554d3d529024c613d5628aa097e5024f0bd582f23245bdb2e04ef6e6077a04379737e45a5e58087516c6d792b801e99'
        '669fa2e4dad0207f0562ec2a883b66dc6e7b118ed62ed30a4bf57a99f7b4897a6ca27d6ca5185bef071e91ebec1f9469f631653cd63fd313be1421cad3a338d0'
        '651ef21017d8e2d049ab587f6898ab64c997fd1ea0489fdf32bb336ecd4b9d82fadcba3b84fc8f43c3c77df00825260362490f93f3f56e592dfb6ec40d277d89'
        '668c0f1d14845ef9e6a1fc2ec094d406b4ca94d970d53ac3e0a6a319c7cba1f4548de2875a3aac4b681f262f246c549cdd58574539e362ff8a7e18795a7cb619'
        'b3e72b935afffdb7d9769d39d22aa38da5cfe036caacb47d5ec9b4ea2cd23c38e56b8f44db29ea664527d0fb1e46c5a3db9ab998f6e15a94fbf040109292e9cc'
        '28a883a27d317e097436ac6c3d137eac86c5fa3dba7561ef9fd654595a5969d16b6651801324f59ef5198a2f3130e6a9b6cc14e85c76651c8c5b061a3f5f38c0'
        '06966259c19e6b1c6c4977b8e55a2abaa8d000bef9cc71d7ee380d23ad769d1f1f24aa16ed9acccde4b5c9891314d9581e6236dbfec4423cdc06c9b264bb2480'
        '97c71f6cc9839f2d7aac692836980f79d60816d3d4368bc7dce4105d677c468c493de346b888312a2e57f124b51f80f99e7bbc93d58ddc3447b07b214637c4cd'
        '41d8805637c51071cf8393e01294a9f9a23c3f1cc3547d93fe32082d5bbe3eb728ac3be20bf63c20d0f1039ae37d0240f43de68038d5b58144a049919cf66a6e'
        'ae116b02a4b84110f6831d439376da5e420f86626acf4790918895af00899b54982237f442d3be5059162bcc244985c3135e12c12a2cc82d95b9b80066ed5f30'
        '7f6eabdbcca1dd9c5df621e7d689e6e4090339654dca634c12cbb86e21708f944b0c14082db4dad03955c389ce113b59702526d652d7f73e013c8ecee0630d4d'
        '30c6ea681053e035085d9041abca134426061ce61fb012d6b4917e12990f513a83bca9218cddaf1bc21b0afc14eaf09e36d873ac5981ba1c37254e674d3e7edf'
        'c937cf9e5f5bbe6f1e269d05b34c668413edbee95f8ce4683599ca2a51950d2e21f7b35187def08b140154b1ee0eed9b744ecb2442e5f129213bd3db3c7315e3'
        '5d6222786302ef8d7bbf0a28426e87f60654cd50a5ce4fadb468baaef3fb920a7a316df6995793c070f3202159075faa9810374bdec40a9aa99a5d49e3bc358f'
        'b3706d5a72d60b06606df85920a276b46ed0d17ef6ccd9845d0c975d66f85c6883924eb0d9b59689e4430a613a4290b6db81849f4f46f34e5dd8f2967550424f'
        '6bf0726ab98e101e9c3727124f2740f77fb6d7a4b3bef57fa7f6d0f60e6c74903db7483799d6fe49644689fa3554f9d9081e6f7df5378bd9b382b3258bcb80d5'
        'aed9a5c49be69c059d47baf20b5c9ddd19742261bb00266c7c2c6fd285734f0584b63a7800d84a27e13d84f3972952a09cfca3cc08f6a620680827bea4b997d6'
        'b1450205da5b94be5db25391b0b7f72352d7452d5bae681e9361469ce542bf38961d44edfb010b83551b1d5aca35559393d181e95e11c9c4d6a73e9efc9bf394'
        '55c7815ec870d3161f4704dc2618bd2bcedc10dd9efcce971eb63c0fef77c38a52296b5a9c27621a6981f832c8a443141361d742e9c5e49af8ba5f8ba340047a'
        'e44b761685a00127dead0fe6d14f84c6a793674a1aaec2445e0408057b59b9ccc4fabe48fd86945321408cdfdc06acb41c6511407617a5633dd058ab8844302a'
        '248fcb3199af82d7de0ac23399ecfeff0918cfc1a5e9112926e7c5980b50150af9af83c3af6a4214228cb541107177213e46bde96fff848d51674f2803fc462f'
        'd33b18d1ad038bf0650f7abcd8e9224acf7c0047c2e40cc68f0adaf57f314428aef31f42a3189ed7690b9db9185e66d6d9a5f12b492a72d2fe0ae311344d3e77'
        'ebda6f788e98e4b6de2682b4515f0bab5416b7deef11748fa8f5566a18e7213d6e0f0ca962923e10989bcb5dd46edf305222a408d24b3efcd033bb7ee3d1eeb3'
        '5a2d7f3eb93958ed9bc2746357bc176d79accb14bcbf129c52bba7894462505b7a49e3ade2562286d88d969eff007ff69905d411f7ba20c26f45032760616dd8'
        '5ea13b68ba398bb83036cd86896ad33edbd92750d1a58f51c23fac5845d419008f46dc0e5610998bd879ee19cfb379b8815e218678185529bd43deab4f5d56eb'
        'a79b60722b8dece23f7803069d885910eb33b47c4f56e29485e6c76b33dd5f6e9a04820baedc277d730e8f37f61320baa05ec935a877126a18a1406d6d6225f6'
        'bc6eaff673d09e0f4e7750d73403ae488e2a3016f0df7900c7429cf42bb3128fc0c7d6772150d7006bea4d0225725e8606f33654582526bcbf2529e0d335fdf1'
        '8db5c970326fe74ab1b56c12fe5d6c97e3a960ac51440537247d9af5b6ee12f5560dd0b7ec9f9f7658346792e5eb65f5ce50e4c9e5524b9cce8424f2aa719b4e'
        '4ae252091182ac33534bba235642b9348e9a8add973ded302335c33ddb8c5a47e799421500c06ebc20aa0363da5a60bc036fe5b22ec70d2eb38dff66b39f4b59'
        'df2a4f3f27e156b7b748c7420baf6c32ffa77966d20dccdfea8e4044c82886ab800ded1d43cf920e16d469a40b260cb2fb90fdb80a04d3cb86feac6cbfa806ff'
        'eed84a0e071c2bc56c81e444bd3cc96264db1b0b1571a8ad0812ad4660b2482a914bca1833c383217b72834149a1f600fcac71a742e72d2ebca8c575800f5661'
        '2c62a1cab5b27ba713328c59d4bb7af4c4bf5e6f3f8d81e4f0660c3645e30a54861bca53e56802ca21c1eab8260f749400c7181440c7544ecfcef33162b9ea46'
        'dfa0ae6fa56c0355b4c2ea7f35ecf759e515701222a12f77e9bc5295f9811682689c246f0588b4905dcebb5fc3dfce1cf091a4620a127a0c6acf34e148b7e059'
        'b16756de045a134b7c2a2f3493029a3550ae6e126c494411dcbb3a7f0525a5ac36744c1883f20cb9c2e1b272bee3461522ae009891b672ba5bf0007a96bde762'
        '3115376dab89ce4e5f1777a5e8a1ec62e0cba642c8a9f2b5237c59d32c479f31795e9b3bf7c96f2eb18f9a64b4a94f9c9fc80f316c14364098a173c04d391c36'
        '57f4d40f6925c089731e1739c8b2be4223568b7ad612c15b919446583362f7f59414a21d33eee6ff7fdb63a3fb2c8e9425375d273e1731e1a21fd39ab847c2c3'
        'caef820cbfd49a3caaa87159fe0dac824e7751e571330dd774bc0e2c9cc5ae9dd17a5ad5f55b30af3c10410bc7de0532186a0eca6e77c6cec8981496bd9013a8'
        'dad353f0ffa28ff3cc2dc283f88239afbc8dbb166cbea6814d27ca444e7f7c74bcde97a29360482eb727922bdf40981e920bcc54d38d212f3545c46d399b98f5'
        '724f6926352782f716d880b277d9ba32fbf61adaaf480717fb90bda6fed0e885976449121a6c1a486d28db4dbdb2b67e87c1137ce09ba1ff193f8d68a7e384a4'
        'ee176a4c64946966857861caf5c98be88689e6305b12c944ee9faa312ba98df61ad19f216137d4c902c6a3b0999b196e4b5a9c8cd404cd292c4ef1bd63e0c576'
        'c2f24180a23098dc06141d35515387d33110dfa8d8aaafd5f616ebe5573ac97889e568ebc4a569a69d38ec03a7e2ae4220995d6f8f4de97bd6fadef93178d74d'
        '1c2136d6012f44b62f8cc1854715576c60a8e12e877a78de8cbcf21a13994bf9c22d12f329688ffa8c41311d325f4d7364ec537c408d59c5a81fcff93b5f6426'
        '78885f8987e2f685ce17ae94226bf2ddf2876f047cf568189e00abb829edb9a3d71f233dfc5d67f3f954cedffeaf43e934a497c7efaa70e0868156ce8896d91d'
        'c4357c0af0189806ce13e648a8124ea1ce7742eb3bb213d64be116b37c5d933241a62cbedd3493d2a206900e45c7500d883dbf06d37b9a81bc2f15ae94ee878a'
        '082706f6ca8bdadaacf7edc1886c7715424e01ab167bfdc44b544bc7053f5a226cca21610c490fc8a5df52e254b0084c5811e102b435fdd32048307b210e583a'
        '5304d0bfb892a48e7c6d7041a4ee7da7dff1212ddbd39300cca2aa4398bf72e106c6aec3af5956759e53c317b3c4fbd5e7db5cb981b3f26238951d5322ba4b8b'
        '36d23be8c8c2c22f552e14f735e3d80615847658f43598de160ee5917ef9fa3972f3b15e11618f302f6e5aead81c45cfcebfe4bcd5caae0d5444bef779009a35'
        'b7ec961b1bbb2ea9955f08fab51620e6613dab82e9389135ad49ccb1704b1702ded535a7802bb4b7f7e2749a8e287e6cd071311f3136322ae9260cdf3a1c093f'
        '5ac94c7ff117829106bc7b5b4f484a5902d7442caf119b143c03903707cef6a1df8a9bc2d75e38de8a5797f928e4645710aa426373831cedd0bade9c8a5c087c'
        'a78a1144033fbaafe211d748622204ffde23f7be2add6aaaa7bb4ab04cf387e55b017fa3ae228d045864f71120f1ce446e6b939564eea6368ece73d7941cf28e'
        'fa84fd76405cf04c2a2726c0ca0bf462ed540b16bbb44094167ea995420ffee656bf5338540dfad874b148736b2a5a9a2f9faee34a9502df4d9e85ad28257c67'
        '36094a1e1d5163a935497a7ae43d49b32d867b871266197d15fec179746f770edbe99a8ecd5559f152f69a8cd5a4de2d8a7a55470e37e83f84bfd2c990c21403'
        '6368658b1ef8a98ed880840a788c5313d560528426c57ddbc91f8811588a5f3cc931aacd46b7b8d226a84b27aca0edb7bca6428350e1bd7981afa22cd36ef9bd'
        'f6e6aa728149254f199e95dbd6c4aaa92336d5414a16cf382ce10c68f275548583a856b0c17a2da6e4f19e75717cc9928b5bc1fe58ea5b59fe79f5a63593680c'
        'bc9643c5783dec5f30d99322c44cef0d768c55f85b63aedd0af13fe84f81c2f145a1aa1ff5808c113c71c8c4454f6d8c755128138d959140494b4d5f62a146da'
        '1ad2d14edcb8f1bbc805a8b0b4d82e46d1921ab4cb109079b7854431c62a0f7eca99f331badd70ab3baf77a969a35d3219138aa7f29c9e623b29e14f82a9efb9'
        'cbbad0393da3bee29cd7c842ffa3e74e0f44ad733bf5305a876b7637fda4294931c8ca5be02d67c9b0df0070d619c8e2d3abe873425b9783c6b0088d2cc804ab'
        'c5065ad3e74fec2de062aa8896cd96fcba3a7ec6eb885d552b1c616e1f7e2984e6357c250819ff646960e334b9ba83a3f1f1c0be00e5f0b7277fbc6892ae3f79'
        '4d40ca7f5064fbfd01f2fbae3f040daa139b8e8f54b7db102ee21cc14e9c253e583fd159c7e91ddebc9e8e7fa9e0c2284282654d1b4f9386b562f6636555ae75'
        '11968f1bb12f9b2aaa83bc74d75e8e707af1eadadebfd39a7c51603347e17e7d735bd87f59c446038e4f94f65e22f7fcfbbb93fd87ebbfabe7dbec1b83a6b17d'
        '816898ef9503ea4c8f3fbc0a6b0c725428ea5bb8fe07148cc5d8afb27b3d0a838a70440ad744d2516f927cf8159386b3466870d01a57491ff74791eac9d07cfa'
        '7a71dec235e172a2d4cfee960f6eabd5de4bb7e9bc0bc9e6273c3a13d11fc95a5ad2f4200ae5211a1d6f9f355224e3b4266c94c494679a2c277d79eba3159423'
        'd2025c33be8dc0b941660f1ad3afbb0cc46e659e5d0003304c26beb05aa0dc14fc21bf99962cc06e8a4332d3342e68aa14800d35a1970d837353e58950ae6e57'
        'c26bcd3ada9e0c56a1522b84d1cef0e4cec3b8770ae10afd24e40b15aeb8de6d6f7a012d1bf326c1eb4faec6797104729eec90ce10fd9da87a921abad4d143ea'
        '46c9cb21e94228c423fd389b20b6d286a3d61fbc4ffafebdbb55d845fa12b175b7baa230c166966536861fcd883a99d1196a292e8a1bf314b2804d672808e9d5')

export KBUILD_BUILD_HOST=archlinux
export KBUILD_BUILD_USER=$pkgbase
export KBUILD_BUILD_TIMESTAMP="$(date -Ru${SOURCE_DATE_EPOCH:+d @$SOURCE_DATE_EPOCH})"
export MAKEFLAGS="${MAKEFLAGS} -j8"
export CFLAGS="${CFLAGS} -fuse-ld=mold"
export CXXFLAGS="${CXXFLAGS} -fuse-ld=mold"

prepare() {
  cd $_srcname

  echo "Setting version..."
  echo "-$pkgrel" > localversion.10-pkgrel
  echo "${pkgbase#linux}" > localversion.20-pkgname

  local src
  for src in "${source[@]}"; do
    src="${src%%::*}"
    src="${src##*/}"
    src="${src%.zst}"
    [[ $src = *.patch ]] || continue
    echo "Applying patch $src..."
    patch -Np1 < "../$src"
  done

  unset src

  echo "Setting config..."
  cp ../config .config
  make olddefconfig
  diff -u ../config .config || :

  make -s kernelrelease > version
  echo "Prepared $pkgbase version $(<version)"
}

build() {
  cd $_srcname

  make all
}

_package() {
  pkgdesc="The $pkgdesc kernel and modules"
  depends=(
    coreutils
    initramfs
    kmod
  )
  optdepends=(
    'wireless-regdb: to set the correct wireless channels of your country'
    'linux-firmware: firmware images needed for some devices'
    'usbctl: deny_new_usb control'
  )
  provides=(
    KSMBD-MODULE
    VIRTUALBOX-GUEST-MODULES
    WIREGUARD-MODULE
  )
  replaces=(
  )

  cd $_srcname
  local modulesdir="$pkgdir/usr/lib/modules/$(<version)"

  echo "Installing boot image..."
  # systemd expects to find the kernel here to allow hibernation
  # https://github.com/systemd/systemd/commit/edda44605f06a41fb86b7ab8128dcf99161d2344
  install -Dm644 "$(make -s image_name)" "$modulesdir/vmlinuz"

  # Used by mkinitcpio to name the kernel
  echo "$pkgbase" | install -Dm644 /dev/stdin "$modulesdir/pkgbase"

  echo "Installing modules..."
  ZSTD_CLEVEL=19 make INSTALL_MOD_PATH="$pkgdir/usr" INSTALL_MOD_STRIP=1 \
    DEPMOD=/doesnt/exist modules_install  # Suppress depmod

  # remove build link
  rm "$modulesdir"/build
}

_package-headers() {
  pkgdesc="Headers and scripts for building modules for the $pkgdesc kernel"
  depends=(pahole)

  cd $_srcname
  local builddir="$pkgdir/usr/lib/modules/$(<version)/build"

  echo "Installing build files..."
  install -Dt "$builddir" -m644 .config Makefile Module.symvers System.map \
    localversion.* version vmlinux
  install -Dt "$builddir/kernel" -m644 kernel/Makefile
  install -Dt "$builddir/arch/x86" -m644 arch/x86/Makefile
  cp -t "$builddir" -a scripts

  # required when STACK_VALIDATION is enabled
  install -Dt "$builddir/tools/objtool" tools/objtool/objtool

  # required when DEBUG_INFO_BTF_MODULES is enabled
  # install -Dt "$builddir/tools/bpf/resolve_btfids" tools/bpf/resolve_btfids/resolve_btfids

  echo "Installing headers..."
  cp -t "$builddir" -a include
  cp -t "$builddir/arch/x86" -a arch/x86/include
  install -Dt "$builddir/arch/x86/kernel" -m644 arch/x86/kernel/asm-offsets.s

  install -Dt "$builddir/drivers/md" -m644 drivers/md/*.h
  install -Dt "$builddir/net/mac80211" -m644 net/mac80211/*.h

  # https://bugs.archlinux.org/task/13146
  install -Dt "$builddir/drivers/media/i2c" -m644 drivers/media/i2c/msp3400-driver.h

  # https://bugs.archlinux.org/task/20402
  install -Dt "$builddir/drivers/media/usb/dvb-usb" -m644 drivers/media/usb/dvb-usb/*.h
  install -Dt "$builddir/drivers/media/dvb-frontends" -m644 drivers/media/dvb-frontends/*.h
  install -Dt "$builddir/drivers/media/tuners" -m644 drivers/media/tuners/*.h

  # https://bugs.archlinux.org/task/71392
  install -Dt "$builddir/drivers/iio/common/hid-sensors" -m644 drivers/iio/common/hid-sensors/*.h

  echo "Installing KConfig files..."
  find . -name 'Kconfig*' -exec install -Dm644 {} "$builddir/{}" \;

  echo "Removing unneeded architectures..."
  local arch
  for arch in "$builddir"/arch/*/; do
    [[ $arch = */x86/ ]] && continue
    echo "Removing $(basename "$arch")"
    rm -r "$arch"
  done

  echo "Removing documentation..."
  rm -r "$builddir/Documentation"

  echo "Removing broken symlinks..."
  find -L "$builddir" -type l -printf 'Removing %P\n' -delete

  echo "Removing loose objects..."
  find "$builddir" -type f -name '*.o' -printf 'Removing %P\n' -delete

  echo "Stripping build tools..."
  local file
  while read -rd '' file; do
    case "$(file -Sib "$file")" in
      application/x-sharedlib\;*)      # Libraries (.so)
        strip -v $STRIP_SHARED "$file" ;;
      application/x-archive\;*)        # Libraries (.a)
        strip -v $STRIP_STATIC "$file" ;;
      application/x-executable\;*)     # Binaries
        strip -v $STRIP_BINARIES "$file" ;;
      application/x-pie-executable\;*) # Relocatable binaries
        strip -v $STRIP_SHARED "$file" ;;
    esac
  done < <(find "$builddir" -type f -perm -u+x ! -name vmlinux -print0)

  echo "Stripping vmlinux..."
  strip -v $STRIP_STATIC "$builddir/vmlinux"

  echo "Adding symlink..."
  mkdir -p "$pkgdir/usr/src"
  ln -sr "$builddir" "$pkgdir/usr/src/$pkgbase"
}

pkgname=(
  "$pkgbase"
  "$pkgbase-headers"
)
for _p in "${pkgname[@]}"; do
  eval "package_$_p() {
    $(declare -f "_package${_p#$pkgbase}")
    _package${_p#$pkgbase}
  }"
done
--------------HlDbtagZu4zoMt7iuC50CuDk
Content-Type: application/x-troff-man; name="PKGBUILD_0.2"
Content-Disposition: attachment; filename="PKGBUILD_0.2"
Content-Transfer-Encoding: 7bit

# Maintainer: Levente Polyak <anthraxx[at]archlinux[dot]org>
# Contributor: Daniel Micay <danielmicay@gmail.com>
# Contributor: Tobias Powalowski <tpowa@archlinux.org>
# Contributor: Thomas Baechler <thomas@archlinux.org>

pkgbase=linux-hardened
pkgver=6.8.4.hardened1
pkgrel=0.2
pkgdesc='Security-Hardened Linux (does boot)'
url='https://github.com/anthraxx/linux-hardened'
arch=(x86_64)
license=(GPL-2.0-only)
makedepends=(
  bc
  cpio
  gettext
  libelf
  mold
  pahole
  perl
  python
  tar
  xz
)
options=(
  !debug
  !strip
)
_srcname=linux-${pkgver%.*}
_srctag=${pkgver%.*}-${pkgver##*.}
source=(
  https://cdn.kernel.org/pub/linux/kernel/v${pkgver%%.*}.x/${_srcname}.tar.{xz,sign}

# stable-queue patches go into here
# https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/tree/queue-6.8?id=a0f0ce228535b3de1d61302e9dd4a59595bc1ccf
scripts-bpf_doc-use-silent-mode-when-exec-make-cmd.patch
xsk-don-t-assume-metadata-is-always-requested-in-tx-.patch
s390-bpf-fix-bpf_plt-pointer-arithmetic.patch
bpf-arm64-fix-bug-in-bpf_ldx_memsx.patch
dma-buf-fix-null-pointer-dereference-in-sanitycheck.patch
arm64-bpf-fix-32bit-unconditional-bswap.patch
nfc-nci-fix-uninit-value-in-nci_dev_up-and-nci_ntf_p.patch
nfsd-fix-error-cleanup-path-in-nfsd_rename.patch
tools-ynl-fix-setting-presence-bits-in-simple-nests.patch
mlxbf_gige-stop-phy-during-open-error-paths.patch
wifi-iwlwifi-mvm-pick-the-version-of-session_protect.patch
wifi-iwlwifi-mvm-rfi-fix-potential-response-leaks.patch
wifi-iwlwifi-mvm-include-link-id-when-releasing-fram.patch
alsa-hda-cs35l56-set-the-init_done-flag-before-compo.patch
ice-refactor-fw-data-type-and-fix-bitmap-casting-iss.patch
ice-fix-memory-corruption-bug-with-suspend-and-rebui.patch
ixgbe-avoid-sleeping-allocation-in-ixgbe_ipsec_vf_ad.patch
igc-remove-stale-comment-about-tx-timestamping.patch
drm-xe-remove-unused-xe_bo-props-struct.patch
drm-xe-add-exec_queue.sched_props.job_timeout_ms.patch
drm-xe-guc_submit-use-jiffies-for-job-timeout.patch
drm-xe-queue-fix-engine_class-bounds-check.patch
drm-xe-device-fix-xe_max_gt_per_tile-check.patch
drm-xe-device-fix-xe_max_tiles_per_device-check.patch
dpll-indent-dpll-option-type-by-a-tab.patch
s390-qeth-handle-deferred-cc1.patch
net-hsr-hsr_slave-fix-the-promiscuous-mode-in-offloa.patch
tcp-properly-terminate-timers-for-kernel-sockets.patch
net-wwan-t7xx-split-64bit-accesses-to-fix-alignment-.patch
drm-rockchip-vop2-remove-ar30-and-ab30-format-suppor.patch
selftests-vxlan_mdb-fix-failures-with-old-libnet.patch
gpiolib-fix-debug-messaging-in-gpiod_find_and_reques.patch
acpica-debugger-check-status-of-acpi_evaluate_object.patch
net-hns3-fix-index-limit-to-support-all-queue-stats.patch
net-hns3-fix-kernel-crash-when-devlink-reload-during.patch
net-hns3-mark-unexcuted-loopback-test-result-as-unex.patch
tls-recv-process_rx_list-shouldn-t-use-an-offset-wit.patch
tls-adjust-recv-return-with-async-crypto-and-failed-.patch
tls-get-psock-ref-after-taking-rxlock-to-avoid-leak.patch
mlxbf_gige-call-request_irq-after-napi-initialized.patch
drm-amd-display-update-p010-scaling-cap.patch
drm-amd-display-send-dtbclk-disable-message-on-first.patch
bpf-protect-against-int-overflow-for-stack-access-si.patch
cifs-fix-duplicate-fscache-cookie-warnings.patch
netfilter-nf_tables-reject-destroy-command-to-remove.patch
netfilter-nf_tables-reject-table-flag-and-netdev-bas.patch
netfilter-nf_tables-skip-netdev-hook-unregistration-.patch
iommu-validate-the-pasid-in-iommu_attach_device_pasi.patch
net-bcmasp-bring-up-unimac-after-phy-link-up.patch
net-lan743x-add-set-rfe-read-fifo-threshold-for-pci1.patch
octeontx2-af-fix-pause-frame-configuration-in-gmp-mo.patch
inet-inet_defrag-prevent-sk-release-while-still-in-u.patch
drm-i915-stop-doing-double-audio-enable-disable-on-s.patch
drm-i915-display-disable-auxccs-framebuffers-if-buil.patch
drm-i915-xelpg-extend-some-workarounds-tuning-to-gfx.patch
drm-i915-mtl-update-workaround-14018575942.patch
drm-i915-do-not-print-pxp-init-failed-with-0-when-it.patch
dm-integrity-fix-out-of-range-warning.patch
modpost-do-not-make-find_tosym-return-null.patch
kbuild-make-woverride-init-warnings-more-consistent.patch
mm-treewide-replace-pud_large-with-pud_leaf.patch
revert-x86-mm-ident_map-use-gbpages-only-where-full-.patch
gpio-cdev-sanitize-the-label-before-requesting-the-interrupt.patch
risc-v-kvm-fix-aplic-setipnum_le-be-write-emulation.patch
risc-v-kvm-fix-aplic-in_clrip-read-emulation.patch
kvm-arm64-fix-host-programmed-guest-events-in-nvhe.patch
kvm-arm64-fix-out-of-ipa-space-translation-fault-handling.patch
selinux-avoid-dereference-of-garbage-after-mount-failure.patch
r8169-fix-issue-caused-by-buggy-bios-on-certain-boards-with-rtl8168d.patch
x86-cpufeatures-add-new-word-for-scattered-features.patch
x86-cpufeatures-add-cpuid_lnx_5-to-track-recently-added-linux-defined-word.patch
x86-bpf-fix-ip-after-emitting-call-depth-accounting.patch
revert-bluetooth-hci_qca-set-bda-quirk-bit-if-fwnode-exists-in-dt.patch
arm64-dts-qcom-sc7180-trogdor-mark-bluetooth-address-as-broken.patch
bluetooth-qca-fix-device-address-endianness.patch
bluetooth-add-quirk-for-broken-address-properties.patch
bluetooth-hci_event-set-the-conn-encrypted-before-conn-establishes.patch
bluetooth-fix-toctou-in-hci-debugfs-implementation.patch
netfilter-nf_tables-release-batch-on-table-validation-from-abort-path.patch
netfilter-nf_tables-release-mutex-after-nft_gc_seq_end-from-abort-path.patch
selftests-mptcp-join-fix-dev-in-check_endpoint.patch
xen-netfront-add-missing-skb_mark_for_recycle.patch
net-rds-fix-possible-cp-null-dereference.patch
net-usb-ax88179_178a-avoid-the-interface-always-configured-as-random-address.patch
net-mana-fix-rx-dma-datasize-and-skb_over_panic.patch
vsock-virtio-fix-packet-delivery-to-tap-device.patch
netfilter-nf_tables-reject-new-basechain-after-table-flag-update.patch
netfilter-nf_tables-flush-pending-destroy-work-before-exit_net-release.patch
netfilter-nf_tables-fix-potential-data-race-in-__nft_flowtable_type_get.patch
netfilter-nf_tables-discard-table-flag-update-with-pending-basechain-deletion.patch
netfilter-validate-user-input-for-expected-length.patch
vboxsf-avoid-an-spurious-warning-if-load_nls_xxx-fails.patch
bpf-sockmap-prevent-lock-inversion-deadlock-in-map-delete-elem.patch
mptcp-prevent-bpf-accessing-lowat-from-a-subflow-socket.patch
x86-retpoline-do-the-necessary-fixup-to-the-zen3-4-srso-return-thunk-for-srso.patch
kvm-arm64-use-tlbi_ttl_unknown-in-__kvm_tlb_flush_vmid_range.patch
kvm-arm64-ensure-target-address-is-granule-aligned-for-range-tlbi.patch
net-sched-act_skbmod-prevent-kernel-infoleak.patch
net-dsa-sja1105-fix-parameters-order-in-sja1110_pcs_mdio_write_c45.patch
net-sched-fix-lockdep-splat-in-qdisc_tree_reduce_backlog.patch
net-stmmac-fix-rx-queue-priority-assignment.patch
net-phy-micrel-lan8814-fix-when-enabling-disabling-1-step-timestamping.patch
net-txgbe-fix-i2c-dev-name-cannot-match-clkdev.patch
net-fec-set-mac_managed_pm-during-probe.patch
net-phy-micrel-fix-potential-null-pointer-dereference.patch
net-dsa-mv88e6xxx-fix-usable-ports-on-88e6020.patch
selftests-net-gro-fwd-update-vxlan-gro-test-expectations.patch
gro-fix-ownership-transfer.patch
idpf-fix-kernel-panic-on-unknown-packet-types.patch
ice-fix-enabling-rx-vlan-filtering.patch
i40e-fix-vf-mac-filter-removal.patch
tcp-fix-bind-regression-for-v6-only-wildcard-and-v4-mapped-v6-non-wildcard-addresses.patch
erspan-make-sure-erspan_base_hdr-is-present-in-skb-head.patch
selftests-reuseaddr_conflict-add-missing-new-line-at-the-end-of-the-output.patch
tcp-fix-bind-regression-for-v6-only-wildcard-and-v4-mapped-v6-non-wildcard-addresses-again.patch
ax25-fix-use-after-free-bugs-caused-by-ax25_ds_del_timer.patch
e1000e-workaround-for-sporadic-mdi-error-on-meteor-lake-systems.patch
ipv6-fix-infinite-recursion-in-fib6_dump_done.patch
mlxbf_gige-stop-interface-during-shutdown.patch
r8169-skip-dash-fw-status-checks-when-dash-is-disabled.patch
udp-do-not-accept-non-tunnel-gso-skbs-landing-in-a-tunnel.patch
udp-do-not-transition-udp-gro-fraglist-partial-checksums-to-unnecessary.patch
udp-prevent-local-udp-tunnel-packets-from-being-groed.patch
octeontx2-af-fix-issue-with-loading-coalesced-kpu-profiles.patch
octeontx2-pf-check-negative-error-code-in-otx2_open.patch
octeontx2-af-add-array-index-check.patch
i40e-fix-i40e_count_filters-to-count-only-active-new-filters.patch
i40e-fix-vf-may-be-used-uninitialized-in-this-function-warning.patch
i40e-enforce-software-interrupt-during-busy-poll-exit.patch
drm-amd-flush-gfxoff-requests-in-prepare-stage.patch
e1000e-minor-flow-correction-in-e1000_shutdown-funct.patch
e1000e-move-force-smbus-from-enable-ulp-function-to-.patch
mean_and_variance-drop-always-failing-tests.patch
net-ravb-let-ip-specific-receive-function-to-interro.patch
net-ravb-always-process-tx-descriptor-ring.patch
net-ravb-always-update-error-counters.patch
kvm-svm-use-unsigned-integers-when-dealing-with-asid.patch
kvm-svm-add-support-for-allowing-zero-sev-asids.patch
selftests-mptcp-connect-fix-shellcheck-warnings.patch
selftests-mptcp-use-operator-to-append-strings.patch
mptcp-don-t-account-accept-of-non-mpc-client-as-fall.patch
9p-fix-read-write-debug-statements-to-report-server-.patch
asoc-wm_adsp-fix-missing-mutex_lock-in-wm_adsp_write.patch
asoc-cs42l43-correct-extraction-of-data-pointer-in-s.patch
riscv-mm-fix-prototype-to-avoid-discarding-const.patch
riscv-hwprobe-do-not-produce-frtace-relocation.patch
drivers-perf-riscv-disable-perf_sample_branch_-while.patch
block-count-blk_open_restrict_writes-openers.patch
risc-v-update-at_vector_size_arch-for-new-at_minsigs.patch
asoc-amd-acp-fix-for-acp-pdm-configuration-check.patch
regmap-maple-fix-cache-corruption-in-regcache_maple_.patch
alsa-hda-cs35l56-add-acpi-device-match-tables.patch
drm-panfrost-fix-power-transition-timeout-warnings.patch
nouveau-uvmm-fix-addr-range-calcs-for-remap-operatio.patch
drm-prime-unbreak-virtgpu-dma-buf-export.patch
asoc-rt5682-sdw-fix-locking-sequence.patch
asoc-rt711-sdca-fix-locking-sequence.patch
asoc-rt711-sdw-fix-locking-sequence.patch
asoc-rt712-sdca-sdw-fix-locking-sequence.patch
asoc-rt722-sdca-sdw-fix-locking-sequence.patch
asoc-ops-fix-wraparound-for-mask-in-snd_soc_get_vols.patch
spi-s3c64xx-extract-fifo-depth-calculation-to-a-dedi.patch
spi-s3c64xx-sort-headers-alphabetically.patch
spi-s3c64xx-explicitly-include-linux-bits.h.patch
spi-s3c64xx-remove-else-after-return.patch
spi-s3c64xx-define-a-magic-value.patch
spi-s3c64xx-allow-full-fifo-masks.patch
spi-s3c64xx-determine-the-fifo-depth-only-once.patch
spi-s3c64xx-use-dma-mode-from-fifo-size.patch
asoc-amd-acp-fix-for-acp_init-function-error-handlin.patch
regmap-maple-fix-uninitialized-symbol-ret-warnings.patch
ata-sata_sx4-fix-pdc20621_get_from_dimm-on-64-bit.patch
scsi-mylex-fix-sysfs-buffer-lengths.patch
scsi-sd-unregister-device-if-device_add_disk-failed-.patch
revert-alsa-emu10k1-fix-synthesizer-sample-playback-.patch
drm-i915-dp-fix-dsc-state-hw-readout-for-sst-connect.patch
cifs-fix-caching-to-try-to-do-open-o_wronly-as-rdwr-.patch
spi-mchp-pci1xxx-fix-a-possible-null-pointer-derefer.patch
s390-pai-fix-sampling-event-removal-for-pmu-device-d.patch
thermal-gov_power_allocator-allow-binding-without-co.patch
thermal-gov_power_allocator-allow-binding-without-tr.patch
drm-i915-gt-limit-the-reserved-vm-space-to-only-the-.patch
ata-sata_mv-fix-pci-device-id-table-declaration-comp.patch
asoc-sof-amd-fix-for-false-dsp-interrupts.patch
sunrpc-fix-a-slow-server-side-memory-leak-with-rpc-o.patch
riscv-use-kern_info-in-do_trap.patch
riscv-fix-warning-by-declaring-arch_cpu_idle-as-noin.patch
riscv-disable-preemption-when-using-patch_map.patch
nfsd-hold-a-lighter-weight-client-reference-over-cb_.patch
lib-stackdepot-move-stack_record-struct-definition-i.patch
stackdepot-rename-pool_index-to-pool_index_plus_1.patch
x86-retpoline-add-noendbr-annotation-to-the-srso-dummy-return-thunk.patch
revert-drm-amd-display-send-dtbclk-disable-message-on-first-commit.patch
gpio-cdev-check-for-null-labels-when-sanitizing-them-for-irqs.patch
gpio-cdev-fix-missed-label-sanitizing-in-debounce_setup.patch
ksmbd-don-t-send-oplock-break-if-rename-fails.patch
ksmbd-validate-payload-size-in-ipc-response.patch
ksmbd-do-not-set-smb2_global_cap_encryption-for-smb-3.1.1.patch
alsa-hda-add-pplcllpl-u-members-to-hdac_ext_stream.patch
alsa-hda-realtek-fix-inactive-headset-mic-jack.patch
alsa-hda-realtek-add-sound-quirks-for-lenovo-legion-slim-7-16arha7-models.patch
alsa-hda-realtek-cs35l41-support-asus-rog-g634jyr.patch
alsa-hda-realtek-update-panasonic-cf-sz6-quirk-to-support-headset-with-microphone.patch
io_uring-kbuf-get-rid-of-lower-bgid-lists.patch
io_uring-kbuf-get-rid-of-bl-is_ready.patch
io_uring-kbuf-protect-io_buffer_list-teardown-with-a-reference.patch
io_uring-rw-don-t-allow-multishot-reads-without-nowait-support.patch
io_uring-use-private-workqueue-for-exit-work.patch
io_uring-kbuf-hold-io_buffer_list-reference-over-mmap.patch
asoc-sof-add-dsp_max_burst_size_in_ms-member-to-snd_sof_pcm_stream.patch
asoc-sof-ipc4-topology-save-the-dma-maximum-burst-size-for-pcms.patch
asoc-sof-intel-hda-pcm-use-dsp_max_burst_size_in_ms-to-place-constraint.patch
asoc-sof-intel-hda-implement-get_stream_position-linear-link-position.patch
asoc-sof-intel-mtl-lnl-use-the-generic-get_stream_position-callback.patch
asoc-sof-introduce-a-new-callback-pair-to-be-used-for-pcm-delay-reporting.patch
asoc-sof-intel-set-the-dai-host-get-frame-byte-counter-callbacks.patch
asoc-sof-intel-hda-common-ops-do-not-set-the-get_stream_position-callback.patch
asoc-sof-ipc4-pcm-use-the-snd_sof_pcm_get_dai_frame_counter-for-pcm_delay.patch
asoc-sof-remove-the-get_stream_position-callback.patch
asoc-sof-ipc4-pcm-move-struct-sof_ipc4_timestamp_info-definition-locally.patch
asoc-sof-ipc4-pcm-combine-the-sof_ipc4_pipe_paused-cases-in-pcm_trigger.patch
asoc-sof-ipc4-pcm-invalidate-the-stream_start_offset-in-paused-state.patch
asoc-sof-sof-pcm-add-pointer-callback-to-sof_ipc_pcm_ops.patch
asoc-sof-ipc4-pcm-correct-the-delay-calculation.patch
asoc-sof-intel-hda-compensate-llp-in-case-it-is-not-reset.patch
driver-core-introduce-device_link_wait_removal.patch
of-dynamic-synchronize-of_changeset_destroy-with-the-devlink-removals.patch
of-module-prevent-null-pointer-dereference-in-vsnprintf.patch
x86-mm-pat-fix-vm_pat-handling-in-cow-mappings.patch
x86-mce-make-sure-to-grab-mce_sysfs_mutex-in-set_bank.patch
x86-coco-require-seeding-rng-with-rdrand-on-coco-systems.patch
perf-x86-intel-ds-don-t-clear-pebs_data_cfg-for-the-last-pebs-event.patch
aio-fix-null-ptr-deref-in-aio_complete-wakeup.patch
riscv-fix-vector-state-restore-in-rt_sigreturn.patch
arm64-ptrace-use-saved-floating-point-state-type-to-determine-sve-layout.patch
mm-secretmem-fix-gup-fast-succeeding-on-secretmem-folios.patch
selftests-mm-include-strings.h-for-ffsl.patch
s390-entry-align-system-call-table-on-8-bytes.patch
riscv-fix-spurious-errors-from-__get-put_kernel_nofault.patch
riscv-process-fix-kernel-gp-leakage.patch
smb-client-fix-uaf-in-smb2_reconnect_server.patch
smb-client-guarantee-refcounted-children-from-parent-session.patch
smb-client-refresh-referral-without-acquiring-refpath_lock.patch
smb-client-handle-dfs-tcons-in-cifs_construct_tcon.patch
smb-client-serialise-cifs_construct_tcon-with-cifs_mount_mutex.patch
smb3-retrying-on-failed-server-close.patch
smb-client-fix-potential-uaf-in-cifs_debug_files_proc_show.patch
smb-client-fix-potential-uaf-in-cifs_stats_proc_write.patch
smb-client-fix-potential-uaf-in-cifs_stats_proc_show.patch
smb-client-fix-potential-uaf-in-cifs_dump_full_key.patch
smb-client-fix-potential-uaf-in-smb2_is_valid_oplock_break.patch
smb-client-fix-potential-uaf-in-smb2_is_valid_lease_break.patch
smb-client-fix-potential-uaf-in-is_valid_oplock_break.patch
smb-client-fix-potential-uaf-in-smb2_is_network_name_deleted.patch
smb-client-fix-potential-uaf-in-cifs_signal_cifsd_for_reconnect.patch
drm-i915-mst-limit-mst-dsc-to-tgl.patch
drm-i915-mst-reject-fec-mst-on-icl.patch
drm-i915-dp-fix-the-computation-for-compressed_bpp-for-display-13.patch
drm-i915-gt-disable-hw-load-balancing-for-ccs.patch
drm-i915-gt-do-not-generate-the-command-streamer-for-all-the-ccs.patch
drm-i915-gt-enable-only-one-ccs-for-compute-workload.patch
drm-xe-use-ring-ops-tlb-invalidation-for-rebinds.patch
drm-xe-rework-rebinding.patch
revert-x86-mpparse-register-apic-address-only-once.patch
bpf-put-uprobe-link-s-path-and-task-in-release-callback.patch
bpf-support-deferring-bpf_link-dealloc-to-after-rcu-grace-period.patch
efi-libstub-add-generic-support-for-parsing-mem_encrypt.patch
x86-boot-move-mem_encrypt-parsing-to-the-decompressor.patch
# x86-sme-move-early-sme-kernel-encryption-handling-into-.head.text.patch
x86-sev-move-early-startup-code-into-.head.text-section.patch
x86-efistub-remap-kernel-text-read-only-before-dropping-nx-attribute.patch

#'usb-disable-all-rndis-protocol-drivers.patch::https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git/patch/?id=c97ce1438f9aed84551eac5a4519112b2edd06c6'

# Derived from https://github.com/anthraxx/linux-hardened/tree/a2acd673a7c689b56db904d5903d197986aaa922
#  ${url}/releases/download/${_srctag}/${pkgbase}-${_srctag}.patch{,.sig}

  config  # the main kernel config file
)
validpgpkeys=(
  ABAF11C65A2970B130ABE3C479BE3E4300411886  # Linus Torvalds
  647F28654894E3BD457199BE38DBBDC86092693E  # Greg Kroah-Hartman
  E240B57E2C4630BA768E2F26FC1B547C8D8172C8  # Levente Polyak
)
sha256sums=('d5dec495fc00605fa9e04114df547fbc92b33d9ea7a4a2b7073c589590e79e63'
            'SKIP'
            '3ef13587965b9c0738f066ac9be9d5673a759fbbd481db26cb67e54ff765fe26'
            'c7956edd0dd2f657fe1c267c11c190d8edb5664bc96ca0cfff8d756fcd4bb1b4'
            '3468e371ce50930a02f0945a2bc9fcc2c8865f637493cf8e6173d38026752cf4'
            '15fd39cc6e9fd38a5eeb313c0f28208c7716fe87d8a3c818eefa2c0337bbf450'
            'caf58e8a3422d142bc79f1ee761cb51a0065a0d9c6c15c2848cafee257bdd18d'
            'cae7c1e42ca35c7fd0216563b8dd9c265d5929943c1376a598f1d0b5b4708798'
            '80e2e5d04cb1c186eaeab90bcfa0be20043ac4d65eba6983c6842a31b2492683'
            '39529f0674f664dd6cb3903e2b69a9f6b67627079fc9de38b51abebe69f8b1ab'
            'fd5a0e8ae545f1e1e38154697a87ec36fc67201bcf21a08513f53ac01efbcaba'
            'c517b7b800b100127613a2a26c2f4a07d5b93de3a2153f86fdfd9894e30a0c99'
            '150ba2f0ec16cfd923715557763ab4fc2acb607cc7ad01f08588f3d21b3c9d90'
            '44213f4d4dd959979de648dd6d31db9bc5d67cb91d809aedee31108eaf09aa74'
            '5a971f6056a67ea6b7be906e7770414c10855fa98d276e6bbf9144598563d56a'
            'cfdf524914b0c5dc6d5ad95518c57f76f22de0876aa99a87cf99bd0cae052cbf'
            '3ab975a7e3bcd9ab1bcc39e3f59bb68febdaf3ddc91a6d5176ad82cee5cdf439'
            '5c29d53efebb43186fc25bd244f9cb567307ffc05a6365180efd824fe899c8e8'
            'b0b2f2268387fedba24e98c5bc7997e42c0d09fa552000a25f40f27a882f3161'
            '72f95b679c3554436bcd084279c87d3a1f17fd951723e5aa5527fc1a0c40f511'
            'a19da464916582e81b57e02610a9257397138ac20e26f6c6a6bb124cb51eb4b1'
            'c28c78824370c5bc1f6f4499b157d00fc4b5635fbdd20be3e270208ad5d56682'
            '246419c0c29dfe7705cfd9c2cd8390fa7db4c402f14cd34dfbcd3b8573e431df'
            'a117676146437bcb8362ad2d33c2b4bc1a621efdf6b938b1ee7ed5bf65f294c4'
            'db3618e56608cbaf619d99b4da5b721e5de1fe2e5c5edc7216521e1e67ac6ffa'
            'aed2110637c1966d8b5e4d231998a0e2315a346a9f47f5b03e03dd1dcc8e46e1'
            '14f4c3202ce9a0bb8652ba04a5c3aaa267382c810c46478775f52efbd81d69a4'
            '6a4c03b73ec16a9ee3a1ecbbac5d5c52bd965d7a6723c55040f7912fc146e4e8'
            'eaaabf37a70ba6792bc7c089503e0309d0b574e1fa00f0f8a35a524503c6888a'
            '659616ce1ff4c47012c878102ed2a9bcd65be78e401e031ab53d748cc01e997e'
            '02fe847a64a00326731e46cf430c1227f95d6d6cba5ed51271b8dbddb0414c0f'
            '7fc7d0126fd6b3e39f8c5acaf8b0f994f42006b2fb18326bf92f81052b768900'
            'b8f95c2acb5fcf47554b2f2913f6205c33dcc86b7c2da6be520f7e57f42c7c65'
            '534b8b82671a1937eecd19592c98834071c231827373ac9a76766fda32d19dbd'
            '4ec1cd059f676088fd134c5091bf79eaf9bea5367e30c4481ef5d64560f81ecb'
            '61fbb1961346ea2d2770e7f34fb09af0dddd3b7e919f5c063843973829c682a9'
            '4a947d0f1bdcd80d102715946dd8bd5d7673a5ad7c59913860d03fc72aa04d22'
            'e7a5a44c19f92dfa78fcde718b069d875528ee522c7a9e28b81ad9859b74f0f3'
            '5d432f7a2f32a8a44d060f0d42a28075413f469b6ec9bf106b63d5d89aa7764b'
            '4ca4eafff1d8867fb8a9ee018fef42692e247ba7cf6959d910f499be6f0da59e'
            '4395ae7945fe335c4eaaddc2fd00e8f40dd8f7bdb029bb55dc1798c749800e7c'
            'b063ab2c74cb92561f55aa334129cc199bac8a73de33f03bf1b8fe1f349dc991'
            '681fcb45db80a57806b37dfb4dae55e0d711b1c1e024fecb325feeb8432864bc'
            '5ff34f1ab794cf3c005af4cf4c175014981d3036f5bf76018d353b6ca41cb708'
            'e201913a3beead60d5e05bf62b6ec43b8ee8c7ed4ceca5d8739f90a29c7e5fd8'
            '571533f5484315942598291ce3cafb54de26b7d54206f6c30a43c07c6c2d91db'
            'ee2ab9996d06a937eae0eaa8e0a799f6a8c68d3998708beb9b82af859f8b442e'
            '2beab0b1ed9d3eb01b8adef6bcd97f58b68fc9b32ec29a3fd4f6606ee3f12d35'
            'e8284cd9f1cf069098e881672266a4845cd81a18a3e50a94730fa1be913080e7'
            'bfc0beb29460639d37e53df7244bb37c34d7bb355523944db31bf94270ec46b4'
            '69eaa07804cc1ae7bba1dcf032d6c58fe82698361489337d7ed3d1f1956420a4'
            'd7c831a6f2201af41c0153587bbaf854928a3f04ab0ece7d90bae317d9920108'
            'cdf46f16e4897e7d0afc06e47e7241344b81bd854056c27195385e245c4bb250'
            'f1add1750678b77b8dee2034bdd75e59028adb8075c44629fbf769e24e86e5c2'
            '876314ef779f77a737c1d5a62858f63d761e7cda5b22753e3f18ae5a23291af6'
            '177bcc7aca2188f349824c9200b5c1e4d430a0b712bf010547a0cbba3840ad90'
            '2830ede0e92a5a318bea5a71445a7c819df24ea8aa15a3e39ccab8c7bd816846'
            'cbf25cc0202ef8552f7179538b879dae2de3d0cc3db28f9de0970bc12c6e05d4'
            'cdb6d33eb182c9ed3efbc99b6d9f7b7af85a1e640a8889a8509985e29b502b98'
            '75a77083478e8b651b8040f0bf42dd6c2d86754aad91a1509ca94ee844d74928'
            '37b53f22119e1d991d4ffc7eaada004f5f31df5c8b335f2cc5747cb169e663ee'
            'ebe3855fc0fb079def132d275d05c821dc68d10e9f495dea839b768740667f7c'
            'bba8b770c8d01494a33c85226197fa51f07de4e93d7c53eb9d45fb46c8f159f2'
            'dd411a84fe996956f05007e430ae42cd43d8723acd73410dd709672b1826506b'
            '1635eb9d69aacc554cea48767bdc9e84788a965823b5197d0c87db93d5fc8c57'
            'cfc2c59e061d4ae1196c8bd05e7634b9c1e38e0a3607da65b76976df05c9dfc5'
            '14eb19d142f769f31f03c14b328849e7a0452a94fc374749572327bec8a7c30b'
            '0b27a0d5430a6469bf3dc7a6c940b00593ecb5256fa56279e75769fcee6e6f5d'
            'a59bc42d9771b72e00cbc6bb05e5c0caa747abc58f49cf53baf05e68de9f3b8b'
            'c56893da4c380629046f1e55d3397f5be69c7e7c44c291f9ae320c5ef5ee7e6f'
            'aca2ec0ddbbd6004f359189fe645e4d78ba8861f2d45c7b8d9568815c52ef012'
            '3ee990372d24499c182f7f6bfaf84c32d00aed2e8288ce283ec8b167afd391a7'
            'bd600e63369039388dbfe3505f7c0811a198868bb1a48ccae14abfdfb921e569'
            'f0a4ace46401e4814c7512ec0558ee159b5b8297d15a7d011319ced9b7cd5d20'
            'daea2e09a6e603e314466eb6c61042ecfaf88c2c3189a93b9da66148486f11d5'
            'df52e8e003f31b481e992a0d6467afd6e44fd99dce06ac38257e176394ca6b50'
            'a189e7fcd2a85e9f4236c4e271541e283550eb5512d86013e0daab0103353745'
            '0b172ceae65f46b10589d62c5e3ec1498cebb8c951a338c112c52d23c55f02de'
            'f0410a5d4ca18391d1dd51fab54dbc63d7f0b683997284afabd5b650a56afb03'
            'c1e1df8aab21c887ed303e030b7782b2431555712d1f034d98b48e31d4849b3e'
            '95b1de9ed302174df30e871e58e241f021e840e1161341f85740d283321d0e04'
            '4da3f60168e1ed84f4bb7d71dce92faacc7005608269dfd4e725dc94e677afd6'
            'f739d2fb98aca1a0dee6ee066bc7c9fd70ebbe503fb2b9e1e4662d1fc34cff4f'
            '9758a3e8ca366f0b15023d614bd35e6f99aa06d4a1c35519bfb1ca2c4f48f21d'
            'd54efaf68d588936cb73faea830ef46c0aaf69a47a8b012b10c8fe673ce0f4b8'
            '8ff9524a79b80b60c7816635d3ef863aa0488658d06d43a6ea7de255c13eb3ba'
            '3b604b2afbfc8795cdedbfb666efd9fcc95804fa426d5c3ec4863be68caf5477'
            'f399c241dc1a87dd017bf19c70b4ef0748db7002a07e22ea0371f1925f1cb1f8'
            '0d3318bc1733a93ee9978582360390dbfa79376a945db13aa9c4288a93dfe8ae'
            'fee969b79295293a367208eec8cf1ffacd45ca48bb69c13d1e39bdeca7255a7d'
            '502b65013e916774fc834315aa4b2c2bbc5ede3f277c6a0318d2bb8e2a6f5663'
            'b216dff8de78d22e4f4fefe52db4ac4d9a57c6e9e9b5ddcd8d1bb4467bcb32cf'
            '75a4028c4e151c1d0b37f5ba7ff1b51164f61c88d620afb1b196a6ac06cd8437'
            'd1f45d31a974da3740b8f8b644d2bac54ff27cf8eb60ebc12481d4caee987ac4'
            '473ac2c06a07fc58766346b1fab92a6ce554af4dfe03e484a6c251dd260f1291'
            '320ac636b0fb96058790deb15b08a19ed31a97af21049e50e6a000e4bd76f607'
            '42d58c53aa87dfac943f980048f97c1c336b662c5c98869169842b820f9b77b7'
            'b05437e5d268152ba6f279e0c37f14ff9cb7d9c6f2865b9cc447f74d93cbe8bf'
            'b2718df5e3f7316d4a6025b384e8b04592aa88950d3b0f8507184eb84ab00af7'
            '667ca2bddfaae2707f4d357f3e7ec811de297e39de30367ff5da52624abc35d5'
            '572d0c8ef1f73a6e6a6a32c01ad89ba6542992ff7330f0e801c253cd17b6f3f4'
            '3650a439bd2ef6f230954aca1c7194f0d20c09734f1ff987f95272769384fe4f'
            '26a3a12e28747ae6e01014a08c72d2f45001c9ce932356af48ff7ae85dc02b22'
            '8b52f346785e9482e5c6614fb703efd48ea6f5cb89d1ca54fa546d0b9026b893'
            'dd60310f44cdf72be9e3b818ae795eaa7bfb6e4a6dad07764bed496ae5b4bc2b'
            'b4b8d1573d884cb04157b54e144334dd2e7635dec77a9d7ed224f0e91c94d80b'
            '8cbfa3a59d377013c23f498e441eac420b6849c4fab4609515ec0e2a5511cd78'
            'f859d00a2b839ea88218771d7b80d9e290379184841ba5f34bb6f819b8c0cd7e'
            '8e540b700e9e7e77ed1fba288f3b83c2b8b1eb3da3ec2fb1b1aec9b469e6ff66'
            'f724ca611402642040ef0393e8fec5e4375293d1de453be6021c272f38b15827'
            '78259696d079935bead2a3180ff42a2c1b409aa5249f63b46a0366eeef124b38'
            '277f562aeed2fb183c572706ea6a0ced42a6d94500835c7b88e8f618acbca6ab'
            'cad7edfa2cc24ca911c0dae42bbceebc982bcc6986f5792c2f6d3030647c563e'
            '172c150fe0e9b1603fe53e1e776ab6680c81e17ce4753a00d1c160959ac8c0f2'
            '8ea6b7add2d74c3f3b7e5531548e7de37224c60b76288a0e095e81bb25aab803'
            '50261af539eb742af31606f445f4a4c75a8fed11955d026a6c4199d4d20962a2'
            '4057a7ca97b72e65341285208f973698491918f27eeb5767c905458273be7b47'
            '0c699f363a6277f141358227eb29ea22d28f6088d7401e4cdfd339d8265bfeb6'
            '719bd1267bb7ac12d1b68ea7fc6ef9b0811809e06a5077990775da1616322a70'
            '5503a9ce389d975ed7297e6fa64b62d018106745d9bce75b399b0a63bd4dc435'
            'e5614b0bdc8dbaa2912335257f9faadd115dbd0eba14291b2a0caa2e81b1adf0'
            '5fd5613abd070ccb0783f56e5018840579d4693f2e7517d0399beec2dadadc6b'
            '1a3ed169c3f367b08da86f9939e671da5f373986f5601bef5292e5eb2dfea0a2'
            '75a48a288ec9a2855360667b34f68a49440ae9a4ac06594027e681fddd32bad0'
            'adc5e82801107d5dedb974aa81355bf75b57b6a6bbfbd76bc632ec63ca85994b'
            '0e8418a42f45a030207e537736158d596b4010ec9dd9f909f7700fc6ecd4839a'
            '76810ea58728e6876d426eaf4cfa547fe38d2126eb4e366506f09d74c320f090'
            'f2ea3600f0dbd9cf92c30e909209e1e75a19747f19fced2190090e54ee51d37d'
            '0c5d113586f241fe4edefe6e0903b2e616dc0bdb3caf6119b139c0a6617a9916'
            '89b768f48302cf18cf1cce022151980b72a9151eb68778c234d9ddca5601aeeb'
            '65721474b58e7f073b1f92b08f4691f91383eff146441d53ef1cb9fd4431124a'
            '9eb1118d9419f1413bdc89be91f30e03dc898a6847a66975dcb969748a9d2269'
            '9624a003b4265c3c3228a929cc2c7c8e0b2f23af7f8f4d7fbc7302c2538780f7'
            '99eb96deb3b935631b73ccfb0011deaef9e1bcfcb21324ed30cdcae4eaa684c7'
            '53522322dbfd81fa696c73ea0ecdf66a445b57a533c568d6c694fa447ce28ea9'
            '1b82c31cca8d789b89434514b3fe6f2d482ce86cfebc13d9ae4897bacfb2800b'
            '010589b0ad4d71aa067c0265fac39c902971cb917453d4d719babda570d1b9bb'
            '87389526d46c4834211636487c733b99761a4ad392f349e13839f6fe78666a5c'
            'c43a1908261b49ebf7e19c6333bb5605756b4915e9de4057ed28795516a40c44'
            'dc91ba1e0db3abc987e47c204faa68b81483eaa78e48b131e842e8229c038455'
            '8ceb61c82ab6ad9557edd1b93d2c270eefaff8b5e7aa07c2be0f8c7059bc4bc0'
            '5d0b185ec4ed770b88fe079dfd92f340d636eb2883b1c9abc1a3f64bff7f0a98'
            'a87c38f82a586023a3327c8d7155be974c996f0b63407ce7beb3c94cae312dbb'
            '8932dd0c04e571e01ce1a4924a0477318f3b1c9e5803ef4089411ec8ff18ba48'
            '8d5d068a1a9bd5feedd8b2ae3c651e66c3a2554d77964fd805ba344211ad0ed6'
            'f98619dde0649dcb0446890d9276e7c6bcdc45aac59ed9f6de79e4b6555712b6'
            '523365f15a94f8e3000532ef3c1c00e33d47d0585fa6752ec0e7bdcf58395311'
            '554b442a3f4b5dd13dda0c1787e958ac01a959802e48ef5a5462f5b15ee131c4'
            '04b3aab50f5a48ca4d785c7fbc7d23e4f98d649fed3f272ffca7712ef6d10787'
            'd6e9cec57b586ae38325b48977cc73998d3b2280de3eb01db8975f2980304abf'
            '384851869cae4ec19c7b4a8fbcb9a8127cb146cc046bb52ad24e82bfaaa13117'
            'e1be9ca689e56130c2fd771400188cb4385cbc4ed34a17b71eed4a53dea2747d'
            '0a5190176066242abd09800fc715e763803f075516769c552a846410178691cc'
            '096f1c78e6d9346d83187643dbe05209d4e0bf30e100b9257e6f54d7bcb1901e'
            '14e60886929d442227ff9a1aba6a34af6ac148020bb0c2ebcb83230e8b2aafe1'
            'a698cdd489ca0ce0e10f9e18203fac37525ce5c9c5f879e4c28626f861a77092'
            '97064fa35845ae3a17b8437cabc80ca458bad39aad5894a951e1d866d14e5d29'
            '1f88f754f67348c82b9ad8be3bbb7fb45103b96112d840a1524304a86956fea0'
            'ac24913fbb2fc9d2a4973df38bdaaa54ec7ee05766e4ac7ea9b117e120be5c47'
            '13da7ed568f70bb8098a225ae015ba52c34090df04d630d8a2932b04cc330cac'
            '26b0676c6d631c2f2757afaf31b301255137ae170897f5c5c5eccb23fbfeb43b'
            '3a8eafc1164c5ffe5c16d852144e5ef5d595fb3b08fc313c40efdb702568eac3'
            '1b82b51eae3c729d7686fef9dea9fcac3e4053dad2b786c66dce9ca5a0193393'
            'b39f9b573e3c771d3d5139353b01640aa10c05cc7abc3f31a0ebe882112ad9bb'
            '67e8b3ebc49f1db2c1047903cd2ac349fb11cc3251036f68c6b64279f138873b'
            '875ae02c14798b6b757a51897f4b8de56ce5f27ee73d0cc8f32d9b47bf7e8d82'
            '7869d0d9ae34e94244250a415b86d148ccaa8fc4b5b84ef3f995122c45580c8d'
            'f72fc96a43b32ce1c551d8c792fb6998c481f56d1a1d76b46bc4bfb2be031d27'
            'cc2e9d174815e33d0eed16e642d3dd3a6d802842b0880c4572e7250f2cfb8344'
            'd6540b42f65ec57809cb04dab71f18392762579c5d43a42d368c0ee44f754576'
            'f04128d5b11c4e8370ce157126c0384b26a63f554b8ccfbb15a30652179d8286'
            'b288737040976c9433c4eb5d599bb2bc723a4148fd81b1177f262a0eb24da383'
            '8241ce80d50afab8e359af4c2a45b9cf2fb27574200c21c7de34f4fb9b240067'
            '59a61ec7c78afe1205d7cbc109f18d5ebe86436992165bb6d2ecc354e4c2c8a8'
            '03bf70c3fcbfb751fbc6b5235771bd9faa2002c6bf4218af20d523b29cb36f66'
            '4f0f9d92bbcc224f059710bbe69c395322a6d470054b432dd811abdb786d52ba'
            'e3ff3c8accc6b1ccbea973921383b451ad6fdf2a60f23f6f5d01ad594701bd99'
            '12b70c856f661c5764c914bbd5c532e70367a832f7876ba1ed5c246e8798c259'
            '9d28f9784b9fc7956fc476cb4d86dbfc4d3fa2fad1f0a0abfab627882d8c6f63'
            '888840ffce08989eb5c772ca174983055b978040b287614c5cfd28d555e275a5'
            '16799b800c2e3c567d314cb43a41ddbfe33063697b5f31f7f61e5b1797aa958f'
            '2d8173c0a0e56f5000b86c2249d9e272fff6870ea051b8412d7313d70a315333'
            '34e32888f68a69802a99685ab3a82f72174a58620faec9eae4285e99983ff45b'
            'dcdc7fc7cc448d5794db71ec9874b241c8c24494ec0be844f3c4baf5cfc0542c'
            'fa5b7188243cc11204a9e727ac39e2aa0ca06fc5deef02fbe046218b339d5043'
            '4ccb22d22a0ff15510d7d070d55aeac608adc8c647c3e59462c18c4bd1bd525d'
            '9060af7239cce73665ff21ab07e32444eada5a22744cb90507b0acf6b4cc3f38'
            'e604a9fd55d400b7e8ea2aad4a5e3badd432f10b20f456a2bcd99591fd310d5b'
            '7f0c7d97bef877f80c684c38816f6ecbe826f9e933b0d73a5fddfdc6dd76ed6b'
            'd492d3b07891da81addc204dd92b070a81ff2c3559142cde192ecc601709953a'
            'da64450c67aa5a84a53d6b89df017187d5d2d354eb5260cef36e516b54cc188c'
            '43b8e5abeff6e09e3deb1d57d5fe9df32f640fda4d68bd0eb31e79de969da03c'
            '3437233b2b7dc175261544adece08f9fc8a0ca182c47d6d2c018a9c85dcfd25d'
            '079b3be39fcc304798d7d146b5069aeaa472dccb68e4bb94b0012de78873c441'
            'd5b5e69136362b4fea580a311655ee15454c52193f721ef51ea5e25d6b148851'
            '683ff4e746fc9c924e0702c033608a690e022d0a823fb8bd52216bc3ddc745d6'
            '65c3580473498448532aa3dc47d080893ad94f46abb84cb0a7e1ec6812b42029'
            '75d7c8bfd904ebc8a1075ae029cc730be302cd020a6a8e2ead468febc03d7739'
            '3eac3a68d22c85662c161345de4e9f6ea94215f045da8b91217573bb992236fd'
            '12af1e6329522d7a74fc09da1c719efab3ef50f9ade731bab3e981888bf7e7ca'
            'f4d90350080b1c4a30a3264ac1b738f88ab05924a0ae8ac70b33e396c6e34a84'
            'a097b9086653656e24da94519bf8d47c661e5d70e93f704cadbf64e8e3c857ee'
            '7c1b3e9d287170b7116e0a4efdc488792d413f3bf7fc85d573f9db18d7843472'
            '25c77dcacfe93fa183fdf6d095c6c7ae87b0b880f6eaa1d467fbea7c80a390f3'
            'e892a703a8f5d116275a07b49de80e7f9e6ae781e721a820918d5fb94f888af2'
            '79732dbe97e89cad4d0abd5126b2ec09edc8f3759d64fb32df7c27989bc5ade1'
            '953b90a6e926218d66357106f13e0145ddb0257d639ad4fdefaed9210699a4a9'
            'b09a5f613f75e85810fc9fb455005cee2069bd6e821c1194123bf5944640b097'
            '13305240f27236d73b15bc8ae43e901ae0266418a694920537e9b962d91c32ed'
            '67cfd46082c6cda5b1bb25df8aa813eca7840d785da793f5bd85508e1dbbaf50'
            'a987fd58ba2f5e5fd0cec4dc1ddef5a01f7008435f78d6fd962a235aa7153e1d'
            '35e4d220f9c1736ab032c265f1f533d57445febff602773a9103af2a1e3eb531'
            '2cd86aa94993cfa7c66e387c0b882e6ca640806a5b5acbd3410395c3f4a5f385'
            '6d0bbf16322a01434ea9dbb38c633ee6b713d231888d63b4eda004fd59b98b52'
            '399c77213740398994d62d444c6a145649c3f62417746c340e7adf57b58e2192'
            '33b5ed26ad3c6fede74d4b5f73f1b8e10ad8531a272fcb9eaf0b7b9d095c9c6c'
            '25a3fae0206d7d7a78267fce47fceb7fe844267ae451bc716e30b3d471becf89'
            '76e0a5e7b7a6243c7c17bcc158aee2633630e7fa387d540c1bcdff102acc0566'
            '7af26884c92b7cb4df72a98c3387ef349d7ef1d0b00a4dfe3818ed6bf1f39e00'
            '9fb7ced14ff8d1f7d702eeb0b84179f14f5e5e11e821fdd47e1b3e4141402451'
            '5dd67d9b8afbf3fa57955a26d93084121691d2a14f7c17ad5715f4bff1cd5330'
            '647565715d073094a0996dd77eb766109f98ffbd97a49c5c376ca41909f61a48'
            '33e8f7c0c85c1104a488add25f4a4415f591c2a754210e7f5de6e313ee48ea20'
            'bee6336beec94c74fea921ea61688d391772fd105e0b96ab9c4e978f7f1385a6'
            'ce4d52f108a66289ee7a6fb00d3c83d77d843994aa49b264d5c0dbc272adfe34'
            '41a0308b308c05b6dde38894a001fecd61f987a4d02c1e855f50c0e240d325a9'
            '9473a270c6e211eee6761f573481c23deb3923a1e1d94e622626ecf74a1f4d67'
            '4f69406e663b91cb65a7593055c7ca76c4adcb5c78859b795cc1a4197d8f1f36'
            '2d64e6284bedae82a99eafd32905cf6e5a0192c8db04fc5b5dcb5b3e59bc6473'
            '8f54573ab4ae7dc4345816039c37f1d52c8ec3f6957aa8087628a4eacd386a4a'
            '34ba7cb9db09c70f4c585b8b01424e793a4a3fbe29bb64ab630077d9259f8ce1'
            'bdf3ea76ee384997d7ea356eb43f1caa387abf3ca776e13de17a5a75fafcbb75'
            '8f288620213c9d92d3e023fa6e979aafb41f453dde94258c4c4d843a84e5381b'
            'ca72697361316dca22edb88342a7f0299d047492b2919f741ef4a3644f6fa6d9'
            '12059faa3c8dee1eef6d09db9ec172da3027a0e3d4af15d370bd751453dda620'
            '81b9abe6fcc1f421beaffa966bd228571ee9a27ee1305e1bb1b0967ede1df167'
            '7f63b22708f890f04dac5ed353fd551cedc6137513ffe6c2c12a0a8c6ef0ab25'
            '3664c80dc0d6cdb925d8283fddca419205fbde752b93e95799d3e988c7604761'
            '7a0feebdd401e8fabaae73830bbc29c376100b51fd71eece87fc7a10d15c6a9a'
            '899f01031f00a39d28d946cdaaf9f7a79b17f68c3b04dbe663697a9309273052'
            '5a13046e76468d7180d02fb1da8bf00dc67727552b1428d3be279443a22a1957'
            '7cfbf24da23bff08c1375470198c3a9378e3f21ac4da2b9ee9798081c65b8a50'
            '9e4c9add56dac68821df183ee253da6d4368bcfc8845852d0452eec0a2ce1802'
            'daa14e755e91f545c2fa6e251c3de5b72dc577f6a27e37a34a6347c78c58b6d8'
            'f2c3a97b8207d8b2c5f64d1f00bee7dc5bda02e7b5c19142a0643184addaabd9'
            '35a691cad588daecdbdf1166a184e7dbf0a6277ebfa651de3cedb3a801817c37'
            '7b33c6dbacd6f6fc12ab102099ae1a7a408af15b0bd9ab8c141653a20e4d1c8c'
            '1fbd424679fc72139a9430f1f4665d42e16b5609f225347c680cad65a9b25262'
            'bf1dd1562a754c2b8ab68ec9075943fd89a286480f1727f02db2624257f0b476'
            '2024c962d847e1eaf47b3f94552cd97c74dd09f46ad5051e6cd6127902551661'
            'd8aa7299d016f08926d7b78acecafe5c1e67f9e7188de22fc11ab06d502ce407'
            'fdacb1ac84a10be231bcde5ca74b69fddfcedfae5f3cbf97878100c64cd5b96f'
            '1023ed0321b777b9d56409b2bc9264cdda28166f2efd6f4315f3b3f1ecece3ea'
            '3e3dbd9f5995659cba542886dc83a75f3ab375d4420addebc9feb87cff91aea7'
            '1def3a02a4ed74d9a91617ef252fb7df732d0c5c1d2b244a341dec58c170ddde'
            '56e06f25c13dc8792ee76bcfed7a0375f7c4d2b0ba69253dac72c2d1873a00e8'
            '195029d39902a2f1902d6eaf8cc5ce67e77c9ae6f268f6c6f6249bfe000c2978'
            '3df1896a2233f4c91116ece4f9c88e79164311cf8a99f1a0fbb0532e81ab29ee'
            '3b3e3e71d9135e41ecc21625c1d81887c35037457fee6d977cba4030bb6f32c4'
            'fcf88624fd60101ac4c8f76131d71ab9cfe989781cfea56a7b1d688efdb92d1c'
            '8b19509a8807fad386dcf440e2eedb5287ce86b8c6d319c16508f5feee5abdac'
            '15b3cc7803af320773abaa3b111d46ff211d6f87aac69f08ff988c2beba12c7b'
            'a5c0d8c85502a615b06ddd66932c803c6e536457a97fd1ef1d0452a0a81c6528'
            'ce2e1bcff6e2f4b8ed00c990063e62a40e1ed8c2d208b997b39524870d96adba'
            'ef890c6a6798373fcfe734994004f49c7bdca634e75037f6af7a44b2acfc878d'
            '09cabcca55a435205a7aabe8c680b3f931f47e8b37b98395a896e8c045d92fb2'
            'ada6d1cd152f0ccd830332003ce3760074a12eb468d32757b4b152aaa36d2eeb'
            '40c5567f9e24fddd5d40f5495031bbc8844cd5b5359e768504123c4aa16b7588'
            'e6381866714757393ccc2dc6ef40d91538e48260dc902ddd9fc1cddbdcbfc0da'
            '1e2f9c8db375709df5415d036c0d41741200b079d7e0b26482c2820ff6c98fa0'
#            'be30b605f5f4c21385913ed0d0cb0360f748ef9a269002114be24dc9eac1d8c7'
            '74dee8e7d3be0ff21c15be2bde9045b4e255da66e076438364c1ae44a862f883'
            'cba48a5c89132825fe928940bf0de52b28dc5ed8d63d66d21a292817e9aa5e3b'
            '4c7df659c09d3d8e5e5e94c87c4ab0af41b49bbc7808f0331e98ce44e5722e8a')
b2sums=('cf58732397bfa11988b79901092887d53c3367d09f63da51ebdcc83518be3a7e9a638fbbb1ff080cd7abed633fadff03d1d7a3928b772de57b14e46e552f9462'
        'SKIP'
        '60be524612cd85dfb9e0f59a1a20c57c9d6e6d53c58338a3aede47afe1c7df6c5cca388960fd280f47137df7256e4fab3d5ff13af6690e8c3d94b2df4bf1c966'
        '0b50728bc255451bc931394a3f0587d531336a5f83136aeb54f6a8b8ad27d7782523f36e4d797900a7b12e62221f6699b2f905c89295b2f0a3ecef19497fc2f2'
        'b542c43f64a7951b939f8bd4e452b46b88c1e538187f855adf46f78200b09738b2639c7f9ec62cdfa59b4b35c5be8941eba4e6b9e48bf7d09e0eb5d7fd4dd163'
        '4b0d9ff14fbe7d7be018e7cd946ebfa5b1a650bf1240e915024f54d430fae8f5772cbb2ff6a0cdeba55481bd43591c17095758df6bb386b9e7d7c52c15ecee7a'
        'be5512cc4670f0114bd23f25e3a8e3a8604874ef80b9fc2b1cf92047b05a9fda250c8dbdaca93480d44ead6fdcab84dccfedeba79e9a6928e1b8cfffbff75458'
        '9c3565b30dae3a55b6a45eb2a09b89931b21a4a027c3e06487c8db3dcafb0db7e6209eabb5a6735f96c3e7154e47ed2db0a8ef93a3255de4aeda395c68d7b7b5'
        '9350cbc5bf2ca7205dc8eda8c3f8dba26c1a37f8091d88ece050e30726bc818293641668b27287aa4dc524a9b6797357ae366208bf24d7591311836f7bf925c4'
        '5e772ad8aac94cc8cae4f323061a06c896007812d0489177917c72b1005fa22fd2bc571940b35755acbf407872e61ebff1b2a3d8c1198447f656f56cdc471fb2'
        'baa971bea24c128cf42945dcbc8e9b4a3121c0b8181750b1631bb61ee71bfcd27acaf92a3c2ed008ae800f1975e71ec05467901d83c5dfe51497cbaf8309fe2b'
        '8784259647c8aee9d51c289705bfe959bc8791d7333ac6bffdb3bb548fcee9273ab442a4f50b24c156576a55122c3ecbab7df3235b42b0506144490fc2788741'
        '744de45bea461d6c755c21d38ac80fbd640c2da6e179f80725f180d41ce1db1a0c7069728bb3b0edc466864c83dc1984e538a4b7c6391e50bf9bd2a2094be05e'
        '44e8343bbc2281889eb96f5217af28a438cb79aa0533ac3f1585117c1599dcddbce4dabc10b9971c124f506d200add986b3cc018f8d3051301085c55a9102d7f'
        'b5798d646ba3342b2eaaf83d71fcd35051244ab8580e0f6701a59c07ffc83e15146991b8bd0b030a179da75c4ab172c6e00f3554acdeacbfe78462e0a3ebed1d'
        '15d88d92e54ec3a158bb4362724831cbbcbc3233bbaae4e2bb452e2c1382a0899a8043dd31f2349785fe3095d8433f7b368573db97f97326d75cfa1278488eef'
        'd048a7b15f9e4c5afd21a64c84cd424655e9e69d38f75c2334ec01eea653cc2ac7e6a02212b723a60f3de48d98162eaed76b4ea43d21855ff78f0741aaeae678'
        '9e66d21178b0567a4318a6b6c2f2c289a0cd526aa632cf9326f258783a967149e9234e56075897981f99ac0c3a9b699926f2e660f8762db58ae5bb2594f6e87e'
        '9e57a19c75a437352da8e0355ceef82741362efe3b55e110523c4084faa5c0a30647526c855965ffb282d360623fbf9ed12e3fe524a406f2a2cc8628b083919e'
        '0cc7926dc3974de8a37f18c86841a315a6263fc1341dcd07def99d5b915079fbe47acf8bb417a9c58233cd268236ff7e1d2dcf6ac3015d258d802eb9083cb6ff'
        'a278d1647686a2b7c94c0b8e01bc966fc2047cb516d62ada828a6ba015cb33a14951a87fe0f9d58512c4bccfe7f19735fd59c5feee51e5dccf321e9b3cfd152c'
        'c0137d0c82f7efb30deb539d4e361d6080d84d32a4596bcc3a72128bdcdcc859bc7fbd718ff10026ad9774272ca67e6e88a4846e300094132e59316d23617b80'
        'be69ab1c02a538988ac62658713e6e1b192311f603845596f8b9dc1f2d1b9632cad50b9e8fba84b5bfdfde53bfc2610f6b3f2c884205e931b9ba321d963052f8'
        'f1898d67e4e2c429dd61ed1533604bce926fadd43289dba178899b746b80520d09aaf02105fc928e6290459c03356921244824016d6ce6934840d8e183b34a59'
        'eb80b96ddf4151acfe9ac02d593b19bd4c9e051d3bb891e504e5435d3dd28f50c0f36dac156f7d2e93d1705fd6bb176304dd3b6a1232b828a2eb3d0e297c730b'
        '23468bb232a5626faccb818d6f87a40c7990e0ee53f9c277189435782b699bf5be85dd8201ee0c7f82f286decc711a23303c6edf230d2a883e5d68b86c283d1b'
        'b30210e18315b790b2c1b53d2b5a023ab1ae49b65b420a1e72d105589c52efc46983a0ad920dc2e33def89c00e6999ce5041d4c77789d687f4a87928a8b36c99'
        'e45fb6ba29e62a5b13bfebf8242aec8f3ce6b9f40bc17f8232a3e23cdf1633b751a3ef64582801a41492a6f3276d4dcda131e4540b357e360339ab7e830cf7d8'
        '4381303d5e0bc0012f429198c371bc96a63ae7be5957ff6ee0c0f459753878a1e8f8a3f2484cfaa9162ad8b1d7760f35948361782b109d25092f0447a3b04ecf'
        '040b1153f6251896a27e575ba55af39d93078da982679680f8b024357c99c6e5294254c67d295e09cbfae102033cbdc75bed1ed40056b45df239d8e338dc2c34'
        '52acd97f22503e32d94031b08d68aff0fd470aa6ae93361a2e9b530d62d063420d89a835114366e972c65c41b47bf4d12f5122d12e11e6bc75145aaf64d462bd'
        '9c7041114c6d3d5034424294163a6d90a88dcff75cdabc4ddd1faad0eeb5b9e6edf3a26906a772b7b989086d40fdaea1f75c2411ed4f8c80f13d6f30429ae1f6'
        'fd44174bfee8210aade09f921193faae7850e709529f3cdf5078e4bd4e544551b5cb63597022d2a83d6f712536b0659ae9dcaa12516d6dfbcae94c8a1f0f46fa'
        '2d97e38c7455b46c378a54f75aa0340f4b5a154867c8041fdd32eded1ebcc7ab8f3f72550021c5f80c333445c6ec537ced20b94d82bd067c59a8139ea7ec6b49'
        '253c268557f678e4219969288130013d2f7869f0df5d283f4ff5778a8c809f8a8c23cf302e225ffa962657510e41f0d432348233678f5afd21568cec06341412'
        '9d5c6cec31dbd2947d459fe0153c70c12d7f1e61a430b48876dffe5e87fe1d02d32bc31ceb7e69d8a46c983f4798833de802a13e26877fca391a22299c148ce7'
        'cb8472cb011b95f7d2a06b1b1f7c374a785e372845d705e2e2c411517fd94df030482592da309dd410dde9a05e0d6f59a6bf7546360e07f7b79a007cf876ea95'
        'b33f193d95ff8fb99438af47f319e6d2c65820bc5c573b25767f7c3ef95cd23703fdade7ad1654490c4523cea2a2748bd27ea03c0d71103985dfc2e18bcffa09'
        'ee3cb1f7e3c9057862a4887de39ae75c48c57e215b33a95f117a9fee70d708dd025068c695a233cb6768e65c3c0506ae3efbc63400eed0d2742bdd1c9eb9961c'
        'aa4967a847887c280f7b32633a6b0745ae9ef6375de7877250cb0d4cbaf313e12b641e2384393230712d0e6c44cdb2bcfef71fbe453fc0b848d7be5299f92de4'
        'ee97e17c0af42d82a0832d99c68185ee8b71135df1b6f373a8c99c174814c4dac41c0b61fc06b739ff8944bddb2e9d8390c15660175edb11e2bd1facde6c869c'
        '6f32d433f5c94a79b5266d2c46d536c00fea121d0ce64d44a934a5ca75d6b46e783e3d6cb770ee490e58fcc306978bd67513defb98cfe744b9f740c25a16ee5d'
        '3e5e9c4c253da8b5ab69857252bcea2feb4b01e01d13baf2e7ee5d52451f90338b6387e56b62a3f02ec4f33cf703cfebd41b1833923f6af5591fe505ecbe56f3'
        '48078b73c5783e567d8a9e749f3dd2bd49ebab61508f6952ce67df1474f0709a1fa7bed4c3f14db6a35906b253b7743283ede59a926cd47158b43efe44eccf90'
        '51bd9fcd9e127c7ab23eaeeb7739e6ccd5b1b69a689fd8cc75150a2c99895c47be773ed39b54e3ec9547e66accdb985f21db1de9a77c7a3f81dd5f01b1c75e8b'
        '47fe04793bc57d00eff2e421238b764da08b000ee716173fa3286873537d28c8848fbcd7426c9b6f6bc74c2a262114e205fb87deab2f915e8db21102439ae1e0'
        'fc7d202054198b6108a3fca4f298932675ddc72cb16543dbcdf9c6398e01b5e1608cb079d1bef0fd48e85ee0fedf5bc0357e433c828b7b6578832530f8655349'
        'f6ccdcffc87b8fd8597d962942b25a7c684a667041d9baf6d39cbce198d119de0443d3824c652e7c9ba330398dcaf9c18635e025b9edbf0f5b46a6e44a657ec9'
        'd193e59d0add2610039370f675eed0df5f6e21d6b8e0fe03f17acd0b252dadc5920179711503b5562322c4fc3d5f4c0f1178ad614942e02aaeb31bbef89159d0'
        'e44079f947c57ba206a1680599c8f5b2ffe6f16aa0f2c55536a362ff3012c49265b019ba113b6c4ed43951e22ce71a971f0e2402118f1453527a4345fddde6c8'
        '256c82753379e71c60eecc99e3fce1b2d7a159e5fe607447ded373f14d62a488db8d6731b149627044dd78db08288777007de6deadd1eb99d8d08cee45eab6bd'
        '3fba31d22da30327f50837f2079ebebf82b74f9b27660692b233f68db1ae907b882993557f4477ebf339a6d6bc6aa9664a6474237f3d760d89429fbb5bd3283f'
        '6d0a6af132bcbf2480c4864ddd315f2625258bea94d7168286350c773bd4a64687785ff9a5ca78938620791b2959c04b3414a233ec0c6a37d9fe565f39e7c781'
        '7930e5df3c3f750fb781f4b7aedd051a6d8561ca63e12b0f2baf80b1eae5df1f1f29b840bc25f2b45e93bc232c42d7cbbf32d4dfb47fad7e8c45d70e67926afe'
        '81a8e8ba86da5a52a0dcacba3aaeb53f645c83f0d4c2b5bc2c997862f3403ce458dc2a09d5c03eac60ba62b7673ce70854239f0be6ade2fbfaa9d6537bc7093b'
        '572d478666ad962cbfdb51da1b96dfcd4327a2a8487ecd7574873524a2acfb25a22f6355ea1340b10748e6adf72ebabcaa249671dbe23b28d4d462d543477097'
        'cfe8b1ac641baf8018e401a6b121bfb68bc5ff908a6d5128d254ec47446084aba05bef1aa8364491ce5a7c276c68410b536f611e414063c3d409a1a53a1961ea'
        '17a81ac870970a96127b1fa04a253a9fcbe98247740420ce60db451d7c718c4b58e5052ed71081a2d2edcd81d34e2737e6b8761abb8b43fa93f2b937462de0bb'
        '05751d86a505361ec60b1388ccc8da41a67f9c5066216cc4949dd16425279a5c46d6d574ce18dbe7cc9f3523d6b8121da62ced9e02d8940a692744d740d044d9'
        'facbd8d5429d062068190b6c105ecb11cddb0388c25a1596df2b58833c83822cc37e08657b858050de107abf045ed4d83e8644393e77e203bde3698c72517d85'
        '37fb5bb6f2a4b05a2c92bfe1f7dedab7376f80a65081451b6753316f5deea7dd139c89fbbb1aab57ecce226b47131106c43ca714a764e99e9bbf9b8c13bd48ca'
        '4ce5fc614d397c7879c86e64ee35d41ffdb9ccb500f7c6b3e2f26a1d9564eab2d32a9105a4fefbcdfd9e690414678057929a8294212ee1c6a2dc7ba4ce49d304'
        'c8d7ea0a0c15ace1502fd3f05ce7b6c17763bcb8e718e625638c1d468f6fed913ad70843f674ebb403e1f1139b28186108a9385602f8441d11131d0455ba5c63'
        'ef32500c0e817efac77cc0305675d72c8cb4c01ca9bd046e1ba7f2fb41b27661370e7cdc0740318a899e24b0f3cb8b36d37edc7c3431f8d598d393f7c620ecf6'
        '7ddfccddb41bb7d8fe65cda6f0ff0e75d8d3077e8e6ba4b18eab14d07e7445e53eaf1df8d4d24b92857dab466e1971e98602ffd997ac8f8a6e8daa62dd378195'
        '363a0822baa650f72d0570d8100f1325ca9edf26cdeb9fa15ad89af9d15deb76dc0db876fbbd71ba18775743bf96d5cdad0be7d438b29545a91e89e241519f69'
        'a49474416a1cc30b18032d92fb0d8c13ad03b295d55b774df8940f7e8424bf84392e95945b2326bf741ade8ec742a0df964009dfd555100221a6ddd9426633c3'
        '0e5ec8ec5a59db4c8c2e0b53dc83f07dec49dcf064ef0a27d61af55e746498ef31efb6809dcb8a97d20f5de538772a0df6c9e873d567b11f5fa540ee29a7cf90'
        '1dcfe22f07d33fa8a20dcb1e4104a5a4282a1cd63879f177e3e9d1908eb2474917b24903edfd26fa610f68cad7bc071be2e9ec09e4219ab6afc43216943db204'
        '273fb410774bfae4b602e9a13779300a21c538feacf207bb18d227b9410b4181b66e5bc7aa91cf41833adbb894bce88159ec7dcd61482814e1f9f27453fd8f14'
        '87c6eb6123c50f0659fcedd342970afb2d4327ae2ccaafd0e2fb853a2af9e7a20829360807789fd9e7eff7e145421b749d27bdb52b1a5e53027fdae7b5a6723c'
        '6100121356830db7306499409b3b2d52312bbc9426475423ac7d38369bde21df41e16fcbca02bff4535d56d9d4239fd25e5e3da654f0f5d9c5fa6d23eb8fd18b'
        'b85ede3756acdda5a6e7a429562ef89e320de4ff3066d6df37854633cb6846eda6522c249aff22c3246bdd902691813d14f6ae942b17bd646a94752f83bd0105'
        '3a0d787697081218b5a108e8f99dcf74c76fda1a8dcdfa86657911c7af9b8d695a5ea6aa3794eef43f637ddaa76ef6f50addd3d22038968ad891372c4f680ea4'
        '71d53e431251381f0ef43625d1e796fa205eda273a54721d350c27c930b11b1a242fd4c81a026d9edcf53c32f9222b2c79436ebbf4567b882b0dd3cc02c52219'
        '6ba8517d7f688a6b32d2621fdc5686bb36528bdabdad34af8124ecab031912ea498d37f1ce1abbbe83658eb5bc0da9ab7d2f094f7c99f7de065756943aeb7c2c'
        'e8de718e94e81d235ba40ce5caf8dfb3ea59d4a0464c03c1b727b1896cde8cbd28db4153cdde0d3c02a06bd5de94f919e5189488368bf62d2daa5ec9728a88f8'
        '297c700f745c4af5e92291dcd07ff6d9aefaeadd80bd96b972a2fb761e132dc1771594effda7427c300ec4ff03625dbfa46ac6e2fa2f2aa8996d6c5c80107d17'
        '6176a003573fc3bfe95c2298ccaa4b6427af3ce59cca3809e8ffcaa1604a7109176e945f6c83f3a310b1316db28eef6207c468f34a38fdc4621f755b8370e4e0'
        'ba36f493916603f8e0922a095cb672782e67dd1c10a0314c08433f1865b32b9d25bdcc3d4a6c1e917aec517a4e97e549c48c25837d3573251a638879dc36a734'
        'd0f3de323d06d2dff5a19ee85d4335611014150a825d00f9cce81439d33c38d26fac3f6d548082e315c7dc8cbb1a29d8c5dd407286088dc807ebd0c4437b7741'
        '378a6d1bedbfaf6cf1878f32ec7b8f6f5e4944caef69a56a20ffd3b5a9fce7a4cf4a7f5ed161d1859ee145c8c8f1923e3a65e8a7447dc0df9739e63b10dfb85a'
        '330f2e210a0cb3aa9aa598db04556064e138031fa9bf3dc2c9c479bf202a7603f6bd18dbd853c6e49fe92e8a33b20b48af76e4511966dcd9a2986ceea6c828b6'
        '1492d83f2e78517daa64b4d8a4d0a9eb528d5a11b6a06580cf21a33418ce9d700c431076609435ac4f1dd6f14ed77db107ff813b041f0ec2e3c0b64442b8e3d9'
        '76f6302b396e987e644a2677fb2325da6aced49d2e861dda60220e1534f14e517aefb0a8a3ccaec8e7abdd322ab9d0be0efa02626af025131db0d099fc4a0c22'
        'a4b9e2903ac370f51f609f9a8d185cb17b31db56be1ae4a75ae3035ead75c1d0edc2f7b370f6b0de344f5f04e12549b288d150b9925c16f57f7a61ad4adaac4b'
        '82a12b13f6db2fa7a2df5669323b25d7149902bad67aa7be8b3024d5d798a0b1ece2e6ea04f54f5b5b304edc3a7579a38e2fc3f32a1ef9e69e3fe90b361aee9d'
        '19d7cb9e71632d629b11fb520ee4a12f28afb9c4940e7dc573bc3639ec33f59ee1efd8b8988ae7aa283a76219196040ea17dc79bb422119113ca3cba8c7ed152'
        '7ac493a15a0b42cfa0c577e7574dd2031b7611a9916dda5b7e124fa50cd8c3c4574870cff5322be3ff912a27991654f9f3379fa79f29055a4424aa087d60c4f9'
        'af1c86234ef40f51ed166a374c1322f6a0ba71352186473b6a93b15d1abd542fcd976513060937e04944024c64b4106c56bac16a179e912a74c3d6174f62e4ae'
        'c99e94516b4eebfd7670485eef44517afc07d1a3c8bb27fdb3472a32950ce9b33dd5390adf5d02fc03d3a9390b9d6a9704f1103002cdfb1e4af623ba13b76c11'
        'd087d7dc5059864c01502765df45d5c50041e731a8d4149e0768c368a10811fdcab6cc83bd6295329fcb0fcea5f930dbd02ec7ace080f7716f85972ad69e88b9'
        '48706c5cd818852c1039a838e2ce8d690bf8b21508f6949086adc000a82c726440051b46e89d053471f8d5afc2ee69e2b1d078000f5668e1916b2cd8cbe4a63d'
        'fb1d14f568d3c41eea09c2b309204d38a415c7b3accedc4e698c01562090e900122e6b4cd67be1de665153c7493d168f0294851774a665319e564786816ebebe'
        'b39690eca5858330bacb4780efef734460147ec37550b753d2aa87b711d79952e9740687d67a623dba48788e08ac8df780618cb22205922146939eac8d6ca59c'
        'a10367ca29da28e3d4ce37ec9597166fb1a6ab41d4d314103fcf1bd3e1525dae875fe53016d7ee6a1fcbbf029137dda0087a688480ef269898dc9156d67f16d3'
        'eb1ac70b2ce0d4216b85c9a33ea7d70a06b73cfd9eb3c500202dbe9eb8834251077c438cf63b6baaa04844b570ef0888c974316defa804ab6aaf54e5f50ecfc9'
        'e659ad24e3aeedafc5edf048a4f525866e899420432c271905269b39dfb1ae29c15db803d537b48044e1d9d7c4ba6d6f558853513cb1a19cd663cfb73cef65f4'
        'bcb2dafe8bb3887a20dc2003430545ff66c021d710527fddc774a7bdd2d4c89f4775c1bcc079ac17bf4efbf07d46cf3d21d2382ca2fa9696b8217a3d83b35279'
        '3d1b054fc09474401e7013fe04fe4575e1408d700c09d0e534f95e400001c498502550ffda3df5ed42667b0bd72d6eec89059b0dfa49bb8c249c570d8655c288'
        '9cee2c218e915fc1c178808d5c78ed28310b2b3fc184798852bea12516b65663cac7d28c2c7e454834deeb9ccf14c834c32e261c5c76db01e9aa366f6b749cc0'
        '041343ed0904a314c02d6d352c580e81854ced3b309567d9ec7f2512b3bead26021a0ffd59f7f9e391b55a11fc79eaa23204d42429528d05d7292f94eb24d2fd'
        '509d9d93dd773a5d6c742dd6eed118a6e9f8c8af520f756cc825fafad349b4f9b853e872b1653735e3cfd1d66e185b654f7fdd335c2402b618f3c34860481022'
        '909d5c2f7506ad0859976ba0ad88ce4cc82d6b2bcdbf3f4bc83d554a516fe1d92ab189c1199ba97484353c2e343926f55d2d7acd38bab0832283210599488ed7'
        'e089e95ffe16c1f2c02afb5831bc69d35407f46a932672e297408975a0dec94adc712d677b622c70077341a4b81dea06c71d137f33f6a220f19deba791ec0da5'
        'a1846d376c779b44c27e6011d34fa13fe817233abb61e04097c1afc5a5cb04dbe0dd9b9b18a0364ca5886a85f3c129202b336e32e7929eeb80116017b7c42e85'
        '7d7440f644bf81b5ca343bbbfddf76d31652ac29455120ad2d2c81adfe022c08b7308d8bfda2bf33320916f1ef46bf2e3cccda50d28df616f8be3a35e9b36724'
        'af024f792328bae7cbda449aba8113d52b35c1f15d1ae55685c02e138ec6c19edda090453026f4082788926ac6255d640e770db27267d69cae4253bdc49f8aa0'
        '2ded3ffcd74db1713cefca1c8d416c3340265fecd9e1deeddf65dfb200db1889be91e3e1b9c82ed7a8312e3f2be7235637fbcbcb8714de19d20fcc1cfbe0d72c'
        'fb73c42401f466d3801fe09b074bcb84b5d95cdb7a480981f5f95bec21568ad8b1b1927c478832371de66bcb6796f2362c18114f8b8d5ff64b73651b9b433f69'
        '1400a3e4c20b63cd817c5801f381c9935d7d783e8c1e3a0f31748b535f0daeb618486a15fc99503b69493cc9ebd7aa02feb8bccb6de21c733acfa08a8998bf9b'
        '56e770067273e2697bf460a6bd61c8b1ad1de02c97e9524776e3cef195bef2e503542d50a40711b2017be56e4e42e6a9f9c6172871b29be4ec778517c541acf6'
        '273a8ca6cd305a7599254856f46c9033685438ee336c6520b948c007d66bded7555030d2fd8914d784fa5e1d76e6c5853f12f84003810d5c370433f807b6f54f'
        '8094fe701cf33c5e2c524c9f315a3e5d04d4d93f78c5373625bf08b66b9d4f0223e5ff43b015d7fc6f5f39be9923d8cda2937b7949402e5c4582341fa639407a'
        '074388b50f399dbb3d7bdd19e8aa82fff42b9b7d8035a86c62ebc3b74528675931f898bab7ec968729dd68ad9a8ec85961b576beb82c9b5dfe3d61751c60c7a1'
        '10b9be87258cd0bdd2716eec6cea366529ea685d7c4f1f1b252b2615048c303f298b9b3ce6245b137684a36e4000a25890d49a8ebe1cb40139469f80f14bb61f'
        '1c745a5871dab8255132ab66c2efa8aac2f439e99aa92a41714c311fd7a3b7dcc155b919bee6ba234144d7d100b30e7945d5eb406b37ccdb978eacc72a50a757'
        '25fa2d9978d6314ce1156918bae7cf4ae29d38c73454965249da4de313d0e7b0ebc8e19fe08b2aa11aca788c2532d974587d7020bbb63a302ea3e89294208322'
        'cc8358e11a617fe2d5edfe59089b202363645539dc901ca9d8c1e8f96aa2199a82ac12009eb8cc080b741f7794cfdffe5d79c282ab51d40b3dcf3865ac5cec23'
        'bcad8b119d04cf31255346f47409ce33698720d9c7c0dc14422cc2c884673c38924a7b227a698cf19474fcac32e22ac62e9e546291949793a501cdaf72864f0a'
        'd35e50d1f75e04b79cc71d1a1e2911e7e2c16e14882983bbf014d0602dc249ec45dc93cb62b5bf1cf07b9a6afc4bc0d87ed771b03b16616ee9527a703ce4ef82'
        'c2875812ab464ca95f5c27ebf55c7f269318a6f999acfbe313016b8f473824e9ae00595a1e4c764c206a1ed06497f99614de0476fdba4e9fea7b2e753b6e94e5'
        '358d7b4035ebd7d7ebad841a5d4cd32a6c610901c7fa76d35717cba576cffba5efb5a64fa242974d346136c5712aff076375b491b64faa7618363a6cf7044aca'
        '1a56b1ce4d7595de83feb106e5066309ff9e1837498463b8186685fe723146f6a22ad7297e5bc4745daa1cb13adae7e9d56fc4d3464248c28f461b1c081c59f6'
        '11e687119222f88ed025325416100ff22848f70a0305d31ed6f8284cd6db05014c4300c2113c17212ae06a6119a494d13781618ffc7857db78caa970101c3172'
        'cef1cfb786da1696004d5d27d421e10177c3290b1f85cd44e964249f5a86dfa338268c17808ed61641c134801a84b9d357d61b99454c5a52ddebcf160c98c393'
        'b1f6b0c32e115ebf7fb81103e8639467359e3a46b36419b64103db61a790a51ad2c7f1a8d0d6920a48f4714fc241b09bd753ae98b94d8ddb3dae29add0f4c028'
        '0003cf34ad9112c9a35995d851eabab5d730f121ed940bdf53b2f1e7ab70ce48d5e7f904e308a80664c408a28b6a67e4de16413b5d9850d022d8065b6cae56d0'
        '23d1f763c56ef3511750a624d0bbb601ed0211b9f22642892cfbf07eaf6ef45690074773dc5a73649cee904f12c0beca61d6a6cf68f4b93e3d1c37e1840da096'
        '703effc681ffb7204acbbe5429b8eee45f525da94a47139f8de5084122dd26660878d993852043fd8910ccc657975ca043957167a6999c49c44c09c5bc7a715f'
        '911a2d2baccc5d03e4ce49ffbbdf6e6288012ea2607e30698fc36f236d47ae21a23ce9b6633e7d7e17329c4206ff245a8ed954b5f3b1172f4b50e2ab23da2803'
        '1a0d7de0c799c3930d6bc379d84e5049d2010945c75026e5582616b3e9160406de31861fd1f06b1adc3c287f9db5758e08aadc24a9ac40684790ceb860fe0348'
        '6be075d850631377644dd72db47d121e3f3387c15abcfb7233b26eacc1915e8b3ac276c651527ad7146c0dc73afcd5be77f03057e65e1c18f863428de79fafad'
        '242e9ec6ddd3244e2398e6571ea692be327cc6be2a34b1376f699a67a31a615e4ea3229b021830252674f34c15e6285659cd9639731ee480720b2aa43c481581'
        'd9fcaba41d0dcb13276a57658218d143aff75580a1ee97af00c7a842793579556bb7d34f2e27323e6747fee0b74f741eafa27c4c6bfc9b21c313c8ac3bcf98db'
        '46182843198b7a801b6da4b74c169407082b0b82a6dd99a4ca6816b03a88f5c84c5ad9c6be932b167b70b5c978449064bef46a7ec60f4c51430f5edd2b70ec7b'
        '5cde4db70f3d24426ba41a67e736fe17d3b38c8df8ab6a33a1508c0f4fc9eb861879edeba2f91639440fb1f1e4d617f05194b52d73e6c1d5d3c00457b4abb553'
        '42642ff606c17b75996251e84c3e286d240355a7d54adfb0b89b0868afda87f511988e8562c471c7d5c2cd7f06a71bf5d62b2b1216990106e2d0b4495d76b197'
        '76732fc05ddce8d6bd588a5eca44a778364f2e2535f29afb5d7c3ad69e27c9c0a53d261884bc115f2931810e4395c5d21a282156008791bcc626196155fce60c'
        'c03196fbbaadb068c42f5d00bac818299ac362e9cf5c9e14965f9b45c20b8c504eae2b79ca271548064f8cc2beb709ab1f0dbbe52f4cdffc170484be22a2a439'
        '5ee36037f221a99fb905fd3439607ca3f718a086aa9b1deb9c5c67f23b8fff6b4801ccfbb12bb363fc3744260408a8e1cc6ed5616aa377a58ec509d5bff6f0a6'
        '56b37c90639203d9262c72230369de9eb5d16e9a7104c5cd7707225b71bb5a2579dc76c60caa030608d0ff5899e3b91d418065485b114b3e4e3cfdafdd73885f'
        'fc97198ba50f3f36abda8d45afc17e0075d9e18af603480b5798e28aa037894dd9dba2d536c61d29a31353a9fe8d6cb04106f5e9a245422f6551f11629bf6f1b'
        '6f41d36e8c1b65164e706409ef2d32e81bc27b1955553c89410e54cc3326c29b6b97fb08bb7dd970a2c37e0bd88e08cf563755bcfc5cf3b87f727a1bb89dd3b9'
        '89ebbee8f5f56d8ff549d68abaa8d673e23f2191e87f1b23fe7bb537ae303c640d530354caf3f3f209b254ee202d8f7977afcefaccd18fbfe9592ef5cc4e830d'
        '695e9b8158da8ca38ee92f1c82cb7ea280b29e727a1b4fa4ef28d54ede00c57af3149ec60f75c3c994243356fd88816ddfcba66f9cf86c2130c476fcdd67c938'
        'ceef4a697f77b117244885b595f8a9902e3a702babdda711b0f63eac48c787a53248f37534a3c319884a42fd07374c58184ff815b23950a2504efd1e2d44d3d3'
        'dde856c205447cd2d5dd6537cc1b21e68088332c6798a1755b1c8b8a3c42bcd592999ad43e9b1d0e3edd23503127f11f9cb77b87cebead144b183b438639072d'
        '06d1075c8260aad91706f24a73d4e2630a14bf8e019aa39b857d8a9a20910914556d9b9271161531a530dd05197736fd634cf988ef0e01e4a0cbe9827718b2ee'
        '204714ee9b8c9e628d546cf61e27b004b5f250e0dbf977c93f6786e6f66da0c56eadb4ab9b52a4673bbfbc4cbe60aaeb96edc25797bc22d4b72933b0cf2df242'
        'a7fe0e04cf03303b7b5017299022d7512f6e2a554fc4f0c6e8e83cfdb906ab51a7959b5dd321f53554d8efdeba049c49bccf6b6075ed6950fb99ecec4f741c59'
        'd3098e03dfc2cd96c4ec0cfc8f36f331c7979bc9a0a1f23e34bb87c2f0c762b7aa176e8b1516d740037d0c2a3719bb9d27a3a853fc9052e88e3e28dc5501d1f6'
        '0d860623674ba4b8ccc3191ea2d051ceec2c9f7a47c69d1a09195256882d05c0530fe55bfb0c55e346f8e92e2522831baf1f06df5c5aa80b5c8b2470bb290fed'
        'a107dc9764f1477c368061392a336809ff1f769d3bc2c2fb2b4252977397b29bdb9920c42e86e22bbda1dcfb2b3c67895f8d5dca09ef492bd4888bd1b3b84616'
        '287d04a11e5e77559692dacaff6ad9cdf8a345d4b916f12469dc4494a590da68b50401be403375f78d44c9e5d5934d307dabf6a067326060514db0cca6cd1c89'
        '0c94854e9370f65b6d5d4c5ea793c455f5db97a7f95b3e267d4b6fc2e0f5021558a10dd5c3756fcba33a3cabeab9f4504364cc4e8ba791466682234ce0403593'
        'f2e0e37741a9c27f969e2cfd77ff2bc2a30ceae01c49b6635491ce1283790b11c523af7ae8d451e547b119422e2d649c77e1dc071bf62d84e871ff7d4e736400'
        '929dc53e060984c6ed0a49699264823cfdadd8ce0251c90f2d310d7697c8bd55275824f3950ef765ce4ed4fb9be6df98ca84c7de3d3ca466ae4904030f7e9533'
        '8b6202ccc6346e80cb09963faee65eb6eee68f05c66aaa8299042d2461d236f8678d551498fad713a90957b625c3a803056b613647c0e0fe74b2aad7feba61f9'
        '9bd1b7a8728e48b0e66bcbcdf6a50f823b9ee30f307c51b0bf1753614df7f048c08da2fb6bac8d16b2ceaefa9a6438ab43fa61892e688e9e1e4ba0fb2077fb69'
        '867d93771086c5822eaab35ee23712de97671cb29dab9f14bf4019c583b162a6dea98ebfffc6ee811ef890f7fdd70a2e304e0bcf2a47c1f2bbc85178e66fc155'
        'ebc58902886dd4d50e718067bf28178af4466209bd8a8bf3e7d847ad810643c33ac781bc35be2bc4d0b6e17cd901eb3166775136f229047f8597414259055766'
        '0b08a82571b709da4bf9e27cc38f330220fc170285add28b59d6c1938d0404ee76276bc229f3f2516b6315115aa571e057965724d0a4202063f1b9cf985fc807'
        '3292c04d411cfafd55f5b107915748ba5ce8dbfbd6f717ba1ec32e5709bd31df5da774f4473842d95fec955e23a0c5a7bbfe4c1241c3371b8ce430470b32b276'
        '309b52ce12edcc885d75fe5c1456b22f42c5d6f12d00562bc7a3aacb7608f1e9c4e51edfb466f416b1ef8a7a4c84d4946fc9203c7465dda29a4f414c36a280f0'
        '4392275e68e9ebf7b1c99968724f549fa6d2cadc68c29a128a8d73ef1c52b0ed0f88d391d41d676251854a00c88caa199c883e576e48098abfb9471d3354a46d'
        '571a34989c3bbda69d9a175f81b6381347e4a7fc3a10f3f765c49a68cd628b8c5917db5305a7246e750f759b040810ab2764886c25433dfc81e8f6fd7fd0863c'
        '7de6f2c1d2a195e0640876e0f547c868cca5f1a314a8d2db11409dfae30c5e67aa4ddc84c289fe86f46cdfb9b98b6c206a2917e9119d4e26c58c0104c99f82d8'
        '899cf46e905abb0b98fad0a488c9c2bad696dbb4fe006427a2624a6b78e5794b7e1406291bd8aa5885c2f09286cabc6fd2ccaf6f7a52c2ec71dc8d5ec8831199'
        '4f03858dc0bfe4fa482178d112a15dee98ebbbc1c7e2081a4bc650b4e24cd7accb3a99b25cf39d0cfc7be75799c9e67459c5c8b44e82783b10fe9e7ac99e3ba4'
        '47de52fbf7136547fa8905c53a1105069cbd815bf1ef23aa723a3e02c54190d41798187490a1d303602a44f45f07e5a75b4572de249dc164014526a48af25387'
        '4ea587c72d669b3333534689b8fe4b0697140392d5b4e9f521b5c60ccfbe9577d7e19f5b7faf92adc7760095dc2adc5667038958dfe8b80a98a53d13b328f29c'
        '362c5ae5525984a38dc1a0e2be82243df46d362e22685e9ad0ffbf1fdbe91594385b18ca0d44921063db27261ed7889b3b14a3bc7030f59c4b971fd7a7391cfd'
        'e7fe5abd721995172f3c869476654035130c70edc2381d72e1477aad7dd23f03ab0d9d3b4a3953762cb5e8256d1a72b40dee40b36006404379f02ff74bb8cb26'
        '41ddfda5e68c132cbbf190da7d8564f4d3e31e4372f9af3ce96140f900c7bb7677c26a3bb99285ecf7bd8de2b6de72598dda23588591161b99734e1e1bd7b45d'
        '627e9799b7df46859dc3d8c222a0d0d65adc2387bdcf4cebf8e66ecf882613eae60717c186c0d707988a7638d1d70db26b041fc984d1a3f11b58db19285a9cc5'
        '83a54390d25e4be1350fc085c333ef482b46de0d6b04777f5fa0e811e2d86d3958b99e44102a04830801f0c957e12538c9b44073b4e2dd67d16810614d530a6f'
        '3af7e9be9f81217efccba233e4fee23cd2296d0080a80fc517a72729c19540a4411bacf824f8046ecfd82de78f7e162f0f2155dcdcd9a9a3eadea9388c47fdb3'
        '9f48f4a7867e4049fdd11c48344977375dc509b337530758d2ed586c4ee78689d0b84bdeef74ec003fae181fc61ca09847e25f30a425e6059e6c16426025c203'
        '70b5b35ba0690f46a9c86694a5e1440ebdac420b95a63f33ad2bd35371d708af2ad4dc49fbe37dd3e0e6b6452433d121311f4031b099c0df2e2c9d0e303c9c7c'
        '007cc51df1e5981df8983a5bcb7b940e03d0eb5786020a4d154bfb038781e50831f6b7db5d011cdc85e7287d08611edacbefc0b828533f2c042112ab3e534316'
        '112be36e9dd272fc0dca41721b67d685920532536d0ae69a107b2b1ad9705cd97e170c85e79e825bdaa60acc7c60b1e0e5bdff7b043f016e2e49a7b60d3ad89c'
        '20faf5d86206c0a7eeec39e27fb7f50d5e73e221e212a2318d6af07d2c5e82e855afd0b79e91b611ce6c20ac46000799ad7a2eecc04dd36a24fa8a612c775828'
        '92637f534d1b3462f6c3526f901398f6c3267428f3b8f2d2bebea43314cea2affa1fa4f07f63dd6ebc1be2af2f8239e6f7d82fd342bd64a7fd9d8e7a9e7a28a7'
        '2f8ba9070261739a7cbeb559200faa89413a0a5930f22d2bb70872c81a9021113987009e28bfa206618f05cf9d3042ecfd8a837a8ef4c6a1175b6dc5b8b13f12'
        '78b8aad18b501205a3ef9bd771ff4dda233fb17a8114b9018aa0ad3a461a227d531e660a020d2d3b2a87a3ffd4927e1f3d567b8cded41bded578b880aa2ec826'
        '8ee11f8510acb0e122bfdd923855e6f2ca6b456f4af53ff0812447aa517cbb629b5eaf006b6b453e51b1df9a43f4d0554bdb20d142001f05065ddfc62d2b2c81'
        '858ce4ab75ec741fdd449c603a4a3a522118214cbf69a234fbe0618813b0ecda8d6ab910d1c03dc71f4f7074b3cdcb879e3c782c3173bd459939d0bc970828f6'
        'ad7ad0920eacfed812c6ea6ccc0b4f2f61302acaf84346dbfa60afd241bdc913728dad44516255d6c339dbfc8ecf6df0b8c5d6886b56b1c71f0d6e7c3b4259db'
        '4f7e55566de6e4ed8bee5068b6db7556490577697cfaa4965f8ee33969653d6daf87f8f47b9c1992f985676f50341b623958ac0f362bdfa5e4b13277b2d361a9'
        'bad692d4cf013878f9a91b6ff747fdb102537c4e1be265be58767c65cffabc07fd874eed92b6a0a1985ed3a9dda3b15ea8a325f8d31538651d62e0752c3e148c'
        '9a11e677c9e49176afac0b8b678bc8393bf89aa9777c6bf2390e2b1d5b6f0327b4a964387f522c2d1dcbf7bed17ccfd4d1d66f61f121f9aa7edc78f664c1bc25'
        '0cc5c8ba0a3e780f5a9b53db75dd5c7439cae3438d4523cb6b4d030583803827aacf866f81806fc20586c565308c3c2f4ed294ae28a9c07c4790c76075d9b798'
        '4fee7539c14470234d1fd9091611f0fedf76842d7590fac52b5402ea1eef844cbc1d7ff937422194246245c2d4db412df8e561e8ba0bcc4ca779a8793d1e8d7a'
        '172d3895485a6f320ec5071378e5d60a15cd27d87ff6c62ad3fce3d2e2e6892d838a5b3a36b949004cadf601678b3d966cc3bf53f8a3c55a32ed2c3674440109'
        '165492e8451d60b9ddf75cd7ca1216ee9e5a024f2644567a081612da209d98f770b6cb0017bef6f50e8048b825dde53f0ce94054fb15ab0ae70cfea4432227b1'
        'f63bd7f0c0bebc15ad5204a3a62105cb54ecee48999dbf044d6de32113fae59e198b670b4a11194d10ff9ec71b858262df631deed016f887e388cea0e4e7a194'
        '7f5ee5c8adcb41b0c8d212e79b6a5cafb69e1e9c727f69bf2e81a15833744836d85c1d7cc11916f80a3420210afa25f889f876a6fd8f91d6badf7d27de4d5f02'
        '39fd83ec371102315d8c72b8b1e32a06100fb065da3413791beba8b5f71175f19eba34201e65f41c2f046a5cc17900afd26bff7df617324df7030290ac7e67d8'
        '20727324a7c0c2d0d89bc0d0d7f71a74879196e59dd2824dddc301ff6beea7bb901a68d6182e364a79e98dbac8e68fafac7e25468a2b07ba448c9e77c746bca0'
        '13292feea36fba8220305180a05edfe905d0784d0aa0ce19535ac565b315e887235e8526530c734c7cb9be7e73eb6b5e3314e173d5fc4fcdf42057becac17b13'
        'dfae6eff7c18bed2fa0c37041c2cebe110bc73c26f3d4d9a47721c386f27d8bb1b1485021b33eeddc397284d02715b21e0c54ea048c9f95979816b1965b3ef89'
        '24f54ef5b3dbe6e655ec861a1e4c0af4051a86d884f5ca1c2d16aa0c3766add2522aa4b5726afbae713bd0a8c9b877e62c805e2284d6bf35bc313ea73820c846'
        '8af4e5da41423ee0e899630037cc68db3e55f2418ac2f21a12eb6c8088e487c47a8433960ac4cfdacb074f56c118d2089145049a09313ba00bd9154c34904825'
        '3e9ef59536237ec3c7d61142a8c8743520dc263eec724deb0020baf1981d4e04de423514af3acb579932c919c3964ea694050d65005e0cd477d328f42676318c'
        'abaf29c43c46406fcf582cc7c6e3843dd74fa9c49d8acf2bae8b05422e153d8fbf740c66980e97e05e565344f569aa27d5c57002634b3b4023bcc7218d2d9ef3'
        'b162d47430204fa64f7610d99762fd0ddd69fff5f9a328a56308fe953cb25bd080fa54538971aa79123b985cb9f1f3b799fbc30bad85e2c1f54bf8cbd3865f97'
        '3781c9331b1d8688a4d5f5b80e9c02d9bcefd2c50addc4fcb6dc3c4124df60464747472fc6a6b95d83e990ad1dd4b17d809cc628e434a6b35d94499af63741e1'
        'b65d2e9d0697b402fa26387a3c658ddb5d24b0180444ef38afe453858978e90d79e1aa05ec6c1e284538e329b4576aa23efecb0414f2932e731d5d3b2788b1ef'
        '599cbd6e0252e196b11cd13bec840e920554d3d529024c613d5628aa097e5024f0bd582f23245bdb2e04ef6e6077a04379737e45a5e58087516c6d792b801e99'
        '669fa2e4dad0207f0562ec2a883b66dc6e7b118ed62ed30a4bf57a99f7b4897a6ca27d6ca5185bef071e91ebec1f9469f631653cd63fd313be1421cad3a338d0'
        '651ef21017d8e2d049ab587f6898ab64c997fd1ea0489fdf32bb336ecd4b9d82fadcba3b84fc8f43c3c77df00825260362490f93f3f56e592dfb6ec40d277d89'
        '668c0f1d14845ef9e6a1fc2ec094d406b4ca94d970d53ac3e0a6a319c7cba1f4548de2875a3aac4b681f262f246c549cdd58574539e362ff8a7e18795a7cb619'
        'b3e72b935afffdb7d9769d39d22aa38da5cfe036caacb47d5ec9b4ea2cd23c38e56b8f44db29ea664527d0fb1e46c5a3db9ab998f6e15a94fbf040109292e9cc'
        '28a883a27d317e097436ac6c3d137eac86c5fa3dba7561ef9fd654595a5969d16b6651801324f59ef5198a2f3130e6a9b6cc14e85c76651c8c5b061a3f5f38c0'
        '06966259c19e6b1c6c4977b8e55a2abaa8d000bef9cc71d7ee380d23ad769d1f1f24aa16ed9acccde4b5c9891314d9581e6236dbfec4423cdc06c9b264bb2480'
        '97c71f6cc9839f2d7aac692836980f79d60816d3d4368bc7dce4105d677c468c493de346b888312a2e57f124b51f80f99e7bbc93d58ddc3447b07b214637c4cd'
        '41d8805637c51071cf8393e01294a9f9a23c3f1cc3547d93fe32082d5bbe3eb728ac3be20bf63c20d0f1039ae37d0240f43de68038d5b58144a049919cf66a6e'
        'ae116b02a4b84110f6831d439376da5e420f86626acf4790918895af00899b54982237f442d3be5059162bcc244985c3135e12c12a2cc82d95b9b80066ed5f30'
        '7f6eabdbcca1dd9c5df621e7d689e6e4090339654dca634c12cbb86e21708f944b0c14082db4dad03955c389ce113b59702526d652d7f73e013c8ecee0630d4d'
        '30c6ea681053e035085d9041abca134426061ce61fb012d6b4917e12990f513a83bca9218cddaf1bc21b0afc14eaf09e36d873ac5981ba1c37254e674d3e7edf'
        'c937cf9e5f5bbe6f1e269d05b34c668413edbee95f8ce4683599ca2a51950d2e21f7b35187def08b140154b1ee0eed9b744ecb2442e5f129213bd3db3c7315e3'
        '5d6222786302ef8d7bbf0a28426e87f60654cd50a5ce4fadb468baaef3fb920a7a316df6995793c070f3202159075faa9810374bdec40a9aa99a5d49e3bc358f'
        'b3706d5a72d60b06606df85920a276b46ed0d17ef6ccd9845d0c975d66f85c6883924eb0d9b59689e4430a613a4290b6db81849f4f46f34e5dd8f2967550424f'
        '6bf0726ab98e101e9c3727124f2740f77fb6d7a4b3bef57fa7f6d0f60e6c74903db7483799d6fe49644689fa3554f9d9081e6f7df5378bd9b382b3258bcb80d5'
        'aed9a5c49be69c059d47baf20b5c9ddd19742261bb00266c7c2c6fd285734f0584b63a7800d84a27e13d84f3972952a09cfca3cc08f6a620680827bea4b997d6'
        'b1450205da5b94be5db25391b0b7f72352d7452d5bae681e9361469ce542bf38961d44edfb010b83551b1d5aca35559393d181e95e11c9c4d6a73e9efc9bf394'
        '55c7815ec870d3161f4704dc2618bd2bcedc10dd9efcce971eb63c0fef77c38a52296b5a9c27621a6981f832c8a443141361d742e9c5e49af8ba5f8ba340047a'
        'e44b761685a00127dead0fe6d14f84c6a793674a1aaec2445e0408057b59b9ccc4fabe48fd86945321408cdfdc06acb41c6511407617a5633dd058ab8844302a'
        '248fcb3199af82d7de0ac23399ecfeff0918cfc1a5e9112926e7c5980b50150af9af83c3af6a4214228cb541107177213e46bde96fff848d51674f2803fc462f'
        'd33b18d1ad038bf0650f7abcd8e9224acf7c0047c2e40cc68f0adaf57f314428aef31f42a3189ed7690b9db9185e66d6d9a5f12b492a72d2fe0ae311344d3e77'
        'ebda6f788e98e4b6de2682b4515f0bab5416b7deef11748fa8f5566a18e7213d6e0f0ca962923e10989bcb5dd46edf305222a408d24b3efcd033bb7ee3d1eeb3'
        '5a2d7f3eb93958ed9bc2746357bc176d79accb14bcbf129c52bba7894462505b7a49e3ade2562286d88d969eff007ff69905d411f7ba20c26f45032760616dd8'
        '5ea13b68ba398bb83036cd86896ad33edbd92750d1a58f51c23fac5845d419008f46dc0e5610998bd879ee19cfb379b8815e218678185529bd43deab4f5d56eb'
        'a79b60722b8dece23f7803069d885910eb33b47c4f56e29485e6c76b33dd5f6e9a04820baedc277d730e8f37f61320baa05ec935a877126a18a1406d6d6225f6'
        'bc6eaff673d09e0f4e7750d73403ae488e2a3016f0df7900c7429cf42bb3128fc0c7d6772150d7006bea4d0225725e8606f33654582526bcbf2529e0d335fdf1'
        '8db5c970326fe74ab1b56c12fe5d6c97e3a960ac51440537247d9af5b6ee12f5560dd0b7ec9f9f7658346792e5eb65f5ce50e4c9e5524b9cce8424f2aa719b4e'
        '4ae252091182ac33534bba235642b9348e9a8add973ded302335c33ddb8c5a47e799421500c06ebc20aa0363da5a60bc036fe5b22ec70d2eb38dff66b39f4b59'
        'df2a4f3f27e156b7b748c7420baf6c32ffa77966d20dccdfea8e4044c82886ab800ded1d43cf920e16d469a40b260cb2fb90fdb80a04d3cb86feac6cbfa806ff'
        'eed84a0e071c2bc56c81e444bd3cc96264db1b0b1571a8ad0812ad4660b2482a914bca1833c383217b72834149a1f600fcac71a742e72d2ebca8c575800f5661'
        '2c62a1cab5b27ba713328c59d4bb7af4c4bf5e6f3f8d81e4f0660c3645e30a54861bca53e56802ca21c1eab8260f749400c7181440c7544ecfcef33162b9ea46'
        'dfa0ae6fa56c0355b4c2ea7f35ecf759e515701222a12f77e9bc5295f9811682689c246f0588b4905dcebb5fc3dfce1cf091a4620a127a0c6acf34e148b7e059'
        'b16756de045a134b7c2a2f3493029a3550ae6e126c494411dcbb3a7f0525a5ac36744c1883f20cb9c2e1b272bee3461522ae009891b672ba5bf0007a96bde762'
        '3115376dab89ce4e5f1777a5e8a1ec62e0cba642c8a9f2b5237c59d32c479f31795e9b3bf7c96f2eb18f9a64b4a94f9c9fc80f316c14364098a173c04d391c36'
        '57f4d40f6925c089731e1739c8b2be4223568b7ad612c15b919446583362f7f59414a21d33eee6ff7fdb63a3fb2c8e9425375d273e1731e1a21fd39ab847c2c3'
        'caef820cbfd49a3caaa87159fe0dac824e7751e571330dd774bc0e2c9cc5ae9dd17a5ad5f55b30af3c10410bc7de0532186a0eca6e77c6cec8981496bd9013a8'
        'dad353f0ffa28ff3cc2dc283f88239afbc8dbb166cbea6814d27ca444e7f7c74bcde97a29360482eb727922bdf40981e920bcc54d38d212f3545c46d399b98f5'
        '724f6926352782f716d880b277d9ba32fbf61adaaf480717fb90bda6fed0e885976449121a6c1a486d28db4dbdb2b67e87c1137ce09ba1ff193f8d68a7e384a4'
        'ee176a4c64946966857861caf5c98be88689e6305b12c944ee9faa312ba98df61ad19f216137d4c902c6a3b0999b196e4b5a9c8cd404cd292c4ef1bd63e0c576'
        'c2f24180a23098dc06141d35515387d33110dfa8d8aaafd5f616ebe5573ac97889e568ebc4a569a69d38ec03a7e2ae4220995d6f8f4de97bd6fadef93178d74d'
        '1c2136d6012f44b62f8cc1854715576c60a8e12e877a78de8cbcf21a13994bf9c22d12f329688ffa8c41311d325f4d7364ec537c408d59c5a81fcff93b5f6426'
        '78885f8987e2f685ce17ae94226bf2ddf2876f047cf568189e00abb829edb9a3d71f233dfc5d67f3f954cedffeaf43e934a497c7efaa70e0868156ce8896d91d'
        'c4357c0af0189806ce13e648a8124ea1ce7742eb3bb213d64be116b37c5d933241a62cbedd3493d2a206900e45c7500d883dbf06d37b9a81bc2f15ae94ee878a'
        '082706f6ca8bdadaacf7edc1886c7715424e01ab167bfdc44b544bc7053f5a226cca21610c490fc8a5df52e254b0084c5811e102b435fdd32048307b210e583a'
        '5304d0bfb892a48e7c6d7041a4ee7da7dff1212ddbd39300cca2aa4398bf72e106c6aec3af5956759e53c317b3c4fbd5e7db5cb981b3f26238951d5322ba4b8b'
        '36d23be8c8c2c22f552e14f735e3d80615847658f43598de160ee5917ef9fa3972f3b15e11618f302f6e5aead81c45cfcebfe4bcd5caae0d5444bef779009a35'
        'b7ec961b1bbb2ea9955f08fab51620e6613dab82e9389135ad49ccb1704b1702ded535a7802bb4b7f7e2749a8e287e6cd071311f3136322ae9260cdf3a1c093f'
        '5ac94c7ff117829106bc7b5b4f484a5902d7442caf119b143c03903707cef6a1df8a9bc2d75e38de8a5797f928e4645710aa426373831cedd0bade9c8a5c087c'
        'a78a1144033fbaafe211d748622204ffde23f7be2add6aaaa7bb4ab04cf387e55b017fa3ae228d045864f71120f1ce446e6b939564eea6368ece73d7941cf28e'
        'fa84fd76405cf04c2a2726c0ca0bf462ed540b16bbb44094167ea995420ffee656bf5338540dfad874b148736b2a5a9a2f9faee34a9502df4d9e85ad28257c67'
        '36094a1e1d5163a935497a7ae43d49b32d867b871266197d15fec179746f770edbe99a8ecd5559f152f69a8cd5a4de2d8a7a55470e37e83f84bfd2c990c21403'
        '6368658b1ef8a98ed880840a788c5313d560528426c57ddbc91f8811588a5f3cc931aacd46b7b8d226a84b27aca0edb7bca6428350e1bd7981afa22cd36ef9bd'
        'f6e6aa728149254f199e95dbd6c4aaa92336d5414a16cf382ce10c68f275548583a856b0c17a2da6e4f19e75717cc9928b5bc1fe58ea5b59fe79f5a63593680c'
        'bc9643c5783dec5f30d99322c44cef0d768c55f85b63aedd0af13fe84f81c2f145a1aa1ff5808c113c71c8c4454f6d8c755128138d959140494b4d5f62a146da'
        '1ad2d14edcb8f1bbc805a8b0b4d82e46d1921ab4cb109079b7854431c62a0f7eca99f331badd70ab3baf77a969a35d3219138aa7f29c9e623b29e14f82a9efb9'
        'cbbad0393da3bee29cd7c842ffa3e74e0f44ad733bf5305a876b7637fda4294931c8ca5be02d67c9b0df0070d619c8e2d3abe873425b9783c6b0088d2cc804ab'
        'c5065ad3e74fec2de062aa8896cd96fcba3a7ec6eb885d552b1c616e1f7e2984e6357c250819ff646960e334b9ba83a3f1f1c0be00e5f0b7277fbc6892ae3f79'
        '4d40ca7f5064fbfd01f2fbae3f040daa139b8e8f54b7db102ee21cc14e9c253e583fd159c7e91ddebc9e8e7fa9e0c2284282654d1b4f9386b562f6636555ae75'
        '11968f1bb12f9b2aaa83bc74d75e8e707af1eadadebfd39a7c51603347e17e7d735bd87f59c446038e4f94f65e22f7fcfbbb93fd87ebbfabe7dbec1b83a6b17d'
        '816898ef9503ea4c8f3fbc0a6b0c725428ea5bb8fe07148cc5d8afb27b3d0a838a70440ad744d2516f927cf8159386b3466870d01a57491ff74791eac9d07cfa'
#        '7a71dec235e172a2d4cfee960f6eabd5de4bb7e9bc0bc9e6273c3a13d11fc95a5ad2f4200ae5211a1d6f9f355224e3b4266c94c494679a2c277d79eba3159423'
        'd2025c33be8dc0b941660f1ad3afbb0cc46e659e5d0003304c26beb05aa0dc14fc21bf99962cc06e8a4332d3342e68aa14800d35a1970d837353e58950ae6e57'
        'c26bcd3ada9e0c56a1522b84d1cef0e4cec3b8770ae10afd24e40b15aeb8de6d6f7a012d1bf326c1eb4faec6797104729eec90ce10fd9da87a921abad4d143ea'
        '46c9cb21e94228c423fd389b20b6d286a3d61fbc4ffafebdbb55d845fa12b175b7baa230c166966536861fcd883a99d1196a292e8a1bf314b2804d672808e9d5')

export KBUILD_BUILD_HOST=archlinux
export KBUILD_BUILD_USER=$pkgbase
export KBUILD_BUILD_TIMESTAMP="$(date -Ru${SOURCE_DATE_EPOCH:+d @$SOURCE_DATE_EPOCH})"
export MAKEFLAGS="${MAKEFLAGS} -j8"
export CFLAGS="${CFLAGS} -fuse-ld=mold"
export CXXFLAGS="${CXXFLAGS} -fuse-ld=mold"

prepare() {
  cd $_srcname

  echo "Setting version..."
  echo "-$pkgrel" > localversion.10-pkgrel
  echo "${pkgbase#linux}" > localversion.20-pkgname

  local src
  for src in "${source[@]}"; do
    src="${src%%::*}"
    src="${src##*/}"
    src="${src%.zst}"
    [[ $src = *.patch ]] || continue
    echo "Applying patch $src..."
    patch -Np1 < "../$src"
  done

  unset src

  echo "Setting config..."
  cp ../config .config
  make olddefconfig
  diff -u ../config .config || :

  make -s kernelrelease > version
  echo "Prepared $pkgbase version $(<version)"
}

build() {
  cd $_srcname

  make all
}

_package() {
  pkgdesc="The $pkgdesc kernel and modules"
  depends=(
    coreutils
    initramfs
    kmod
  )
  optdepends=(
    'wireless-regdb: to set the correct wireless channels of your country'
    'linux-firmware: firmware images needed for some devices'
    'usbctl: deny_new_usb control'
  )
  provides=(
    KSMBD-MODULE
    VIRTUALBOX-GUEST-MODULES
    WIREGUARD-MODULE
  )
  replaces=(
  )

  cd $_srcname
  local modulesdir="$pkgdir/usr/lib/modules/$(<version)"

  echo "Installing boot image..."
  # systemd expects to find the kernel here to allow hibernation
  # https://github.com/systemd/systemd/commit/edda44605f06a41fb86b7ab8128dcf99161d2344
  install -Dm644 "$(make -s image_name)" "$modulesdir/vmlinuz"

  # Used by mkinitcpio to name the kernel
  echo "$pkgbase" | install -Dm644 /dev/stdin "$modulesdir/pkgbase"

  echo "Installing modules..."
  ZSTD_CLEVEL=19 make INSTALL_MOD_PATH="$pkgdir/usr" INSTALL_MOD_STRIP=1 \
    DEPMOD=/doesnt/exist modules_install  # Suppress depmod

  # remove build link
  rm "$modulesdir"/build
}

_package-headers() {
  pkgdesc="Headers and scripts for building modules for the $pkgdesc kernel"
  depends=(pahole)

  cd $_srcname
  local builddir="$pkgdir/usr/lib/modules/$(<version)/build"

  echo "Installing build files..."
  install -Dt "$builddir" -m644 .config Makefile Module.symvers System.map \
    localversion.* version vmlinux
  install -Dt "$builddir/kernel" -m644 kernel/Makefile
  install -Dt "$builddir/arch/x86" -m644 arch/x86/Makefile
  cp -t "$builddir" -a scripts

  # required when STACK_VALIDATION is enabled
  install -Dt "$builddir/tools/objtool" tools/objtool/objtool

  # required when DEBUG_INFO_BTF_MODULES is enabled
  # install -Dt "$builddir/tools/bpf/resolve_btfids" tools/bpf/resolve_btfids/resolve_btfids

  echo "Installing headers..."
  cp -t "$builddir" -a include
  cp -t "$builddir/arch/x86" -a arch/x86/include
  install -Dt "$builddir/arch/x86/kernel" -m644 arch/x86/kernel/asm-offsets.s

  install -Dt "$builddir/drivers/md" -m644 drivers/md/*.h
  install -Dt "$builddir/net/mac80211" -m644 net/mac80211/*.h

  # https://bugs.archlinux.org/task/13146
  install -Dt "$builddir/drivers/media/i2c" -m644 drivers/media/i2c/msp3400-driver.h

  # https://bugs.archlinux.org/task/20402
  install -Dt "$builddir/drivers/media/usb/dvb-usb" -m644 drivers/media/usb/dvb-usb/*.h
  install -Dt "$builddir/drivers/media/dvb-frontends" -m644 drivers/media/dvb-frontends/*.h
  install -Dt "$builddir/drivers/media/tuners" -m644 drivers/media/tuners/*.h

  # https://bugs.archlinux.org/task/71392
  install -Dt "$builddir/drivers/iio/common/hid-sensors" -m644 drivers/iio/common/hid-sensors/*.h

  echo "Installing KConfig files..."
  find . -name 'Kconfig*' -exec install -Dm644 {} "$builddir/{}" \;

  echo "Removing unneeded architectures..."
  local arch
  for arch in "$builddir"/arch/*/; do
    [[ $arch = */x86/ ]] && continue
    echo "Removing $(basename "$arch")"
    rm -r "$arch"
  done

  echo "Removing documentation..."
  rm -r "$builddir/Documentation"

  echo "Removing broken symlinks..."
  find -L "$builddir" -type l -printf 'Removing %P\n' -delete

  echo "Removing loose objects..."
  find "$builddir" -type f -name '*.o' -printf 'Removing %P\n' -delete

  echo "Stripping build tools..."
  local file
  while read -rd '' file; do
    case "$(file -Sib "$file")" in
      application/x-sharedlib\;*)      # Libraries (.so)
        strip -v $STRIP_SHARED "$file" ;;
      application/x-archive\;*)        # Libraries (.a)
        strip -v $STRIP_STATIC "$file" ;;
      application/x-executable\;*)     # Binaries
        strip -v $STRIP_BINARIES "$file" ;;
      application/x-pie-executable\;*) # Relocatable binaries
        strip -v $STRIP_SHARED "$file" ;;
    esac
  done < <(find "$builddir" -type f -perm -u+x ! -name vmlinux -print0)

  echo "Stripping vmlinux..."
  strip -v $STRIP_STATIC "$builddir/vmlinux"

  echo "Adding symlink..."
  mkdir -p "$pkgdir/usr/src"
  ln -sr "$builddir" "$pkgdir/usr/src/$pkgbase"
}

pkgname=(
  "$pkgbase"
  "$pkgbase-headers"
)
for _p in "${pkgname[@]}"; do
  eval "package_$_p() {
    $(declare -f "_package${_p#$pkgbase}")
    _package${_p#$pkgbase}
  }"
done

--------------HlDbtagZu4zoMt7iuC50CuDk--

