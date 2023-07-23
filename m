Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83E0975E59A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 00:37:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbjGWWhi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 18:37:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbjGWWhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 18:37:36 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6BF3E5C
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 15:37:28 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-99357737980so642521466b.2
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 15:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1690151847; x=1690756647;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=U8G1VNBd4ovFAG2/JHhjCE16X/LwRLrKrhoP26lEX/8=;
        b=ODh3HCAkmJ/9sKwIxcqHi/QDFV9LKEdjqf88pj04v9VWPbU1z3WeKXotLIucoDZZFk
         r6QrIBhSPQ53z2Zll3cw6tz2IpKEhbdkOrFjDW8d/xxvU9d6af19mkJYG6uxy8ji7ABr
         UiPzPop7hmVgddUOvAzkmFhgD7Md49yYXKsG4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690151847; x=1690756647;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U8G1VNBd4ovFAG2/JHhjCE16X/LwRLrKrhoP26lEX/8=;
        b=W0bZDlIWiReduoYUlJGi6w7rBMDRnZu4pwcHdGzwxLPqJ41A74Mi55PkObMy+lMJgL
         1aTsELuBrlB9Jm7iPON+FVQ2KNlY+mcrsGIyECHoKc5t/svSRln5X0mZgAx/QN1fr/8d
         3yYgGZZtmclpG0Wqq4Dr8+REBGVxmiiAGUdAJXbWv81BeQdmBy+BBg3HmC4dgWnoRm2E
         5NJIP9rE7C7MFvzdMB+Kgu4xh7q372M53FqSIVF1T1a+om2yoq6CGeI21y8A08JCMl5b
         XpPUwsLO8t6a1jhNsfVk93SATS47EORWfbw3+vHxV5VtZ13w4biUxaY2F/5PMkpH+bKJ
         07Wg==
X-Gm-Message-State: ABy/qLaWwpdRScx8bKW154s+kvfRvdn3G43xQ4FhOae+OR33WQm/0ffS
        mFSVB9Odj3kpvQZqoSPMeRIWr++QrmZi7OXrLrCIyg==
X-Google-Smtp-Source: APBJJlHnCO4EW3AHvvOsL0cJESqaePsrZWUyJfDrh+zf8kLLe9zGFRe6RClMr71xAkhnIOJGWwFxCg==
X-Received: by 2002:a17:906:142:b0:99b:4378:a5aa with SMTP id 2-20020a170906014200b0099b4378a5aamr8983467ejh.49.1690151846903;
        Sun, 23 Jul 2023 15:37:26 -0700 (PDT)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id jx16-20020a170906ca5000b00993664a9987sm5760614ejb.103.2023.07.23.15.37.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Jul 2023 15:37:26 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-52229f084beso1048939a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 15:37:26 -0700 (PDT)
X-Received: by 2002:aa7:dd11:0:b0:522:1d4c:6ea2 with SMTP id
 i17-20020aa7dd11000000b005221d4c6ea2mr4097809edv.26.1690151845520; Sun, 23
 Jul 2023 15:37:25 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 23 Jul 2023 15:37:08 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi4Yau-3Bsv2rXYmtXMTLaj3=Wyf4cdM6d89czFvkVsRQ@mail.gmail.com>
Message-ID: <CAHk-=wi4Yau-3Bsv2rXYmtXMTLaj3=Wyf4cdM6d89czFvkVsRQ@mail.gmail.com>
Subject: Linux 6.5-rc3
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Things continue to look pretty normal - there's nothing here that
would seem to stand out, with both the commit counts and the diffs
looking pretty much normal for rc3.

We've got the usual driver updates being about half the diff  (with
gpu, networking and sound drivers dominating as always). The other
half is a pretty random mixed bag of small fixes all over - core
networking, some tooling header updates, various filesystem fixes,
some minor architecture fixes...

Full shortlog appended,

              Linus

---

Ahmed Zaki (3):
      iavf: use internal state to free traffic IRQs
      iavf: fix a deadlock caused by rtnl and driver's lock circular
dependencies
      iavf: fix reset task race with iavf_remove()

Alan Stern (1):
      net: usbnet: Fix WARNING in usbnet_start_xmit/usb_submit_urb

Alex Deucher (2):
      drm/amdgpu/pm: make gfxclock consistent for sienna cichlid
      drm/amdgpu/pm: make mclk consistent for smu 13.0.7

Alexander Duyck (1):
      bpf, arm64: Fix BTI type used for freplace attached functions

Alexander Sverdlin (2):
      tpm: tis_i2c: Limit read bursts to I2C_SMBUS_BLOCK_MAX (32) bytes
      tpm: tis_i2c: Limit write bursts to I2C_SMBUS_BLOCK_MAX (32) bytes

Alexey Dobriyan (1):
      kbuild: flatten KBUILD_CFLAGS

Andrew Donnellan (1):
      Revert "powerpc/64s: Remove support for ELFv1 little endian userspace=
"

Andrzej Hajda (1):
      drm/i915/perf: add sentinel to xehp_oa_b_counters

Andy Shevchenko (1):
      Bluetooth: MGMT: Use correct address for memcpy()

Arnaldo Carvalho de Melo (11):
      tools headers UAPI: Sync drm/i915_drm.h with the kernel sources
      tools headers UAPI: Sync files changed by new cachestat syscall
with the kernel sources
      tools headers uapi: Sync linux/fcntl.h with the kernel sources
      tools headers UAPI: Sync linux/kvm.h with the kernel sources
      tools include UAPI: Sync linux/mount.h copy with the kernel sources
      tools headers UAPI: Sync linux/prctl.h with the kernel sources
      perf beauty: Update copy of linux/socket.h with the kernel sources
      tools include UAPI: Sync linux/vhost.h with the kernel sources
      tools include UAPI: Sync the sound/asound.h copy with the kernel sour=
ces
      tools headers arm64: Sync arm64's cputype.h with the kernel sources
      perf test task_exit: No need for a cycles event to check if we
get an PERF_RECORD_EXIT

Arnd Bergmann (2):
      accel/habanalabs: add more debugfs stub helpers
      Bluetooth: coredump: fix building with coredump disabled

Aurabindo Pillai (2):
      drm/amd/display: export some optc function for reuse
      drm/amd/display: add DCN301 specific logic for OTG programming

Baoquan He (1):
      of: make OF_EARLY_FLATTREE depend on HAS_IOMEM

Bartosz Golaszewski (1):
      gpio: mvebu: fix irq domain leak

Ben Skeggs (3):
      drm/nouveau/i2c: fix number of aux event slots
      drm/nouveau/disp: PIOR DP uses GPIO for HPD, not PMGR AUX interrupts
      drm/nouveau/kms/nv50-: init hpd_irq_lock for PIOR DP

Benjamin Gray (2):
      powerpc/kasan: Disable KCOV in KASAN code
      gen_compile_commands: add assembly files to compilation database

Bernd Schubert (1):
      fuse: Apply flags2 only when userspace set the FUSE_INIT_EXT

Candice Li (1):
      drm/amdgpu: Allow the initramfs generator to include psp_13_0_6_ta

Chen Lin (1):
      ring-buffer: Do not swap cpu_buffer during resize process

Chengming Zhou (2):
      blk-mq: delete dead struct blk_mq_hw_ctx->queued field
      blk-iocost: skip empty flush bio in iocost

Christian Hesse (2):
      tpm/tpm_tis: Disable interrupts for Framework Laptop Intel 12th gen
      tpm/tpm_tis: Disable interrupts for Framework Laptop Intel 13th gen

Christoffer Sandberg (1):
      ALSA: hda/realtek: Add quirk for Clevo NS70AU

Christoph Hellwig (4):
      btrfs: be a bit more careful when setting mirror_num_ret in
btrfs_map_block
      iomap: fix a regression for partial write errors
      iomap: micro optimize the ki_pos assignment in iomap_file_buffered_wr=
ite
      btrfs: fix ordered extent split error handling in btrfs_dio_submit_io

Christophe Leroy (1):
      Revert "powerpc/bug: Provide better flexibility to
WARN_ON/__WARN_FLAGS() with asm goto"

Claudio Imbrenda (2):
      KVM: s390: pv: simplify shutdown and fix race
      KVM: s390: pv: fix index value of replaced ASCE

Colin Ian King (3):
      selftests: ALSA: Fix fclose on an already fclosed file pointer
      selftests/mm: mkdirty: fix incorrect position of #endif
      fbdev: kyro: make some const read-only arrays static and reduce type =
size

Damien Le Moal (1):
      ata: pata_parport: Add missing protocol modules description

Dan Carpenter (5):
      accel/qaic: tighten bounds checking in encode_message()
      accel/qaic: tighten bounds checking in decode_message()
      accel/qaic: Add consistent integer overflow checks
      accel/qaic: Fix a leak in map_user_pages()
      ASoC: SOF: ipc3-dtrace: uninitialized data in
dfsentry_trace_filter_write()

Daniel Golle (2):
      net: ethernet: mtk_eth_soc: handle probe deferral
      net: ethernet: mtk_eth_soc: always mtk_get_ib1_pkt_type

Daniel Miess (1):
      drm/amd/display: Prevent vtotal from being set to 0

Daniel Vetter (1):
      drm/atomic: Fix potential use-after-free in nonblocking commits

Darrick J. Wong (3):
      xfs: convert flex-array declarations in struct xfs_attrlist*
      xfs: convert flex-array declarations in xfs attr leaf blocks
      xfs: convert flex-array declarations in xfs attr shortform objects

David Jeffery (1):
      sbitmap: fix batching wakeup

Derek Fang (1):
      ASoC: rt5640: Fix the issue of speaker noise

Ding Hui (2):
      iavf: Fix use-after-free in free_netdev
      iavf: Fix out-of-bounds when setting channels on remove

Douglas Anderson (1):
      Bluetooth: hci_sync: Avoid use-after-free in dbg for
hci_remove_adv_monitor()

Eric Dumazet (13):
      tcp: annotate data-races around tcp_rsk(req)->txhash
      tcp: annotate data-races around tcp_rsk(req)->ts_recent
      tcp: annotate data-races around tp->tcp_tx_delay
      tcp: annotate data-races around tp->tsoffset
      tcp: annotate data-races around tp->keepalive_time
      tcp: annotate data-races around tp->keepalive_intvl
      tcp: annotate data-races around tp->keepalive_probes
      tcp: annotate data-races around icsk->icsk_syn_retries
      tcp: annotate data-races around tp->linger2
      tcp: annotate data-races around rskq_defer_accept
      tcp: annotate data-races around tp->notsent_lowat
      tcp: annotate data-races around icsk->icsk_user_timeout
      tcp: annotate data-races around fastopenq.max_qlen

Eric Whitney (1):
      ext4: correct inline offset when handling xattrs in inode body

Fabio Estevam (1):
      ASoC: fsl_sai: Revert "ASoC: fsl_sai: Enable MCTL_MCLK_EN bit
for master mode"

Fedor Ross (1):
      can: mcp251xfd: __mcp251xfd_chip_set_mode(): increase poll timeout

Filipe Manana (6):
      btrfs: fix use-after-free of new block group that became unused
      btrfs: zoned: fix memory leak after finding block group with super bl=
ocks
      btrfs: fix double iput() on inode after an error during orphan cleanu=
p
      btrfs: fix iput() on error pointer after error during orphan cleanup
      btrfs: use irq safe locking when running and adding delayed iputs
      btrfs: fix warning when putting transaction with qgroups enabled
after abort

Florian Bezdeka (1):
      tpm/tpm_tis: Disable interrupts for Lenovo L590 devices

Florian Kauer (1):
      igc: Prevent garbled TX queue with XDP ZEROCOPY

Florian Westphal (3):
      netfilter: nf_tables: fix spurious set element insertion failure
      netfilter: nf_tables: can't schedule in nft_chain_validate
      netfilter: nft_set_pipapo: fix improper element removal

Geert Uytterhoeven (1):
      ASoC: codecs: SND_SOC_WCD934X should select REGMAP_IRQ

Geetha sowjanya (1):
      octeontx2-pf: Dont allocate BPIDs for LBK interfaces

Georg M=C3=BCller (2):
      perf probe: Add test for regression introduced by switch to
die_get_decl_file()
      perf probe: Read DWARF files from the correct CU

Guchun Chen (5):
      drm/amdgpu/vkms: relax timer deactivation by hrtimer_try_to_cancel
      drm/amdgpu: Allocate root PD on correct partition
      drm/amdgpu: fix slab-out-of-bounds issue in amdgpu_vm_pt_create
      drm/amdgpu/vm: use the same xcp_id from root PD
      drm/amdgpu: use a macro to define no xcp partition case

Guenter Roeck (1):
      regmap: Disable locking for RBTREE and MAPLE unit tests

Hans de Goede (1):
      gpio: tps68470: Make tps68470_gpio_output() always set the initial va=
lue

Harald Freudenberger (1):
      s390/zcrypt: fix reply buffer calculations for CCA replies

Haren Myneni (1):
      powerpc/pseries/vas: Hold mmap_mutex after mmap lock during window cl=
ose

Heiner Kallweit (3):
      r8169: fix ASPM-related problem for chip version 42 and 43
      r8169: revert 2ab19de62d67 ("r8169: remove ASPM restrictions now
that ASPM is disabled during NAPI poll")
      Revert "r8169: disable ASPM during NAPI poll"

Helge Deller (2):
      io_uring: Fix io_uring mmap() by using architecture-provided
get_unmapped_area()
      ia64: mmap: Consider pgoff when searching for free mapping

Ian Rogers (2):
      libsubcmd: Avoid SEGV/use-after-free when commands aren't excluded
      perf parse-events: Avoid SEGV if PMU lookup fails for legacy cache te=
rms

Ido Schimmel (1):
      vrf: Fix lockdep splat in output path

James Clark (1):
      perf build: Fix library not found error when using CSLIBS

Jani Nikula (1):
      Revert "drm/i915: use localized __diag_ignore_all() instead of per fi=
le"

Jarkko Sakkinen (1):
      tpm: tpm_vtpm_proxy: fix a race condition in /dev/vtpmx creation

Jens Axboe (1):
      io_uring: treat -EAGAIN for REQ_F_NOWAIT as final for io-wq

Jerry Snitselaar (1):
      tpm: return false from tpm_amd_is_rng_defective on non-x86 platforms

Jiapeng Chong (1):
      security: keys: Modify mismatched function name

Jiri Slaby (SUSE) (7):
      vgacon: switch vgacon_scrolldelta() and vgacon_restore_screen()
      vgacon: remove unneeded forward declarations
      vgacon: remove unused xpos from vgacon_set_cursor_size()
      vgacon: let vgacon_doresize() return void
      vgacon: cache vc_cell_height in vgacon_cursor()
      sticon: make sticon_set_def_font() void and remove op parameter
      fbcon: remove unused display (p) from fbcon_redraw()

Jocelyn Falempe (2):
      drm/client: Fix memory leak in drm_client_target_cloned
      drm/client: Fix memory leak in drm_client_modeset_probe

Johan Hovold (15):
      ASoC: codecs: wcd938x: fix codec initialisation race
      ASoC: codecs: wcd938x: fix mbhc impedance loglevel
      ASoC: codecs: wcd938x: drop inline keywords
      ASoC: codecs: wcd938x: use dev_printk() for impedance logging
      ASoC: codecs: wcd934x: demote impedance printk
      ASoC: codecs: wcd934x: drop inline keywords
      ASoC: codecs: wcd938x: fix soundwire initialisation race
      ASoC: codecs: wcd938x: fix missing mbhc init error handling
      ASoC: qdsp6: audioreach: fix topology probe deferral
      ASoC: codecs: wcd938x: fix missing clsh ctrl error handling
      ASoC: codecs: wcd938x: fix resource leaks on component remove
      ASoC: codecs: wcd934x: fix resource leaks on component remove
      ASoC: codecs: wcd-mbhc-v2: fix resource leaks on component remove
      ASoC: topology: suppress probe deferral errors
      ASoC: core: suppress probe deferral errors

John Fastabend (1):
      mailmap: Add entry for old intel email

John Hubbard (2):
      selftests/riscv: fix potential build failure during the "emit_tests" =
step
      selftests/arm64: fix build failure during the "emit_tests" step

Josef Bacik (2):
      btrfs: fix race between balance and cancel/pause
      btrfs: set_page_extent_mapped after read_folio in btrfs_cont_expand

Kailang Yang (1):
      ALSA: hda/realtek - remove 3k pull low procedure

Krzysztof Kozlowski (1):
      dt-bindings: hwmon: moortec,mr75203: fix multipleOf for coefficients

Kumar Kartikeya Dwivedi (3):
      bpf: Fix subprog idx logic in check_max_stack_depth
      bpf: Repeat check_max_stack_depth for async callbacks
      selftests/bpf: Add more tests for check_max_stack_depth bug

Kuniyuki Iwashima (6):
      bridge: Add extack warning when enabling STP in netns.
      Revert "tcp: avoid the lookup process failing to get sk in ehash tabl=
e"
      llc: Check netns in llc_dgram_match().
      llc: Check netns in llc_estab_match() and llc_listener_match().
      llc: Don't drop packet from non-root netns.
      Revert "bridge: Add extack warning when enabling STP in netns."

Liam R. Howlett (3):
      mm/mlock: fix vma iterator conversion of apply_vma_lock_flags()
      maple_tree: fix 32 bit mas_next testing
      maple_tree: fix node allocation testing on 32 bit

Lino Sanfilippo (1):
      tpm,tpm_tis: Disable interrupts after 1000 unhandled IRQs

Linus Torvalds (1):
      Linux 6.5-rc3

Linus Walleij (1):
      dsa: mv88e6xxx: Do a final check before timing out

Luka Guzenko (1):
      ALSA: hda/realtek: Enable Mute LED on HP Laptop 15s-eq2xxx

Marc Kleine-Budde (2):
      can: gs_usb: gs_can_open(): improve error handling
      can: gs_usb: fix time stamp counter initialization

Marc Zyngier (4):
      KVM: arm64: timers: Use CNTHCTL_EL2 when setting non-CNTKCTL_EL1 bits
      KVM: arm64: Disable preemption in kvm_arch_hardware_enable()
      arm64: Fix HFGxTR_EL2 field naming
      KVM: arm64: vgic-v4: Make the doorbell request robust w.r.t preemptio=
n

Marcin Szycik (3):
      iavf: Wait for reset in callbacks which trigger it
      Revert "iavf: Detach device during reset task"
      Revert "iavf: Do not restart Tx queues after reset task failure"

Mario Limonciello (2):
      ASoC: amd: ps: Fix extraneous error messages
      drm/amd: Use amdgpu_device_pcie_dynamic_switching_supported() for SMU=
7

Mark Brown (5):
      net: dsa: ar9331: Use explict flags for regmap single read/write
      regmap: Drop initial version of maximum transfer length fixes
      regmap: Account for register length in SMBus I/O limits
      regcache: Push async I/O request down into the rbtree cache
      arm64/fpsimd: Ensure SME storage is allocated after SVE VL changes

Martin Fuzzey (1):
      regulator: da9063: fix null pointer deref with partial DT config

Martin Kaiser (2):
      fbdev: imxfb: warn about invalid left/right margin
      fbdev: imxfb: switch to DEFINE_SIMPLE_DEV_PM_OPS

Martin Povi=C5=A1er (1):
      MAINTAINERS: Redo addition of ssm3515 to APPLE SOUND

Mastan Katragadda (1):
      ASoC: SOF: amd: add revision check for sending sha dma completion com=
mand

Matthias Reichl (1):
      ASoC: hdmi-codec: fix channel info for compressed formats

Matthieu Baerts (3):
      selftests: tc: set timeout to 15 minutes
      selftests: tc: add 'ct' action kconfig dep
      selftests: tc: add ConnTrack procfs kconfig

Matus Gajdos (1):
      ASoC: fsl_sai: Disable bit clock with transmitter

Mauricio Faria de Oliveira (2):
      loop: deprecate autoloading callback loop_probe()
      loop: do not enforce max_loop hard limit by (new) default

Michal Swiatkowski (1):
      ice: prevent NULL pointer deref during reload

Miguel Ojeda (2):
      prctl: move PR_GET_AUXV out of PR_MCE_KILL
      kbuild: rust: avoid creating temporary files

Miklos Szeredi (3):
      fuse: add feature flag for expire-only
      fuse: revalidate: don't invalidate if interrupted
      fuse: ioctl: translate ENOSYS in outarg

Minjie Du (1):
      tools: timers: fix freq average calculation

Mohamed Khalfella (1):
      tracing/histograms: Return an error if we fail to add histogram
to hist_vars list

Mostafa Saleh (1):
      KVM: arm64: Add missing BTI instructions

Nathan Chancellor (1):
      ASoC: cs35l45: Select REGMAP_IRQ

Nicholas Kazlauskas (1):
      drm/amd/display: Keep PHY active for DP displays on DCN31

Nikhil V (1):
      arm64: mm: Make hibernation aware of KFENCE

Ojaswin Mujoo (2):
      ext4: fix off by one issue in ext4_mb_choose_next_group_best_avail()
      ext4: fix rbtree traversal bug in ext4_mb_use_preallocated

Oliver Upton (2):
      KVM: arm64: Correctly handle page aging notifiers for unaligned memsl=
ot
      KVM: arm64: Correctly handle RES0 bits PMEVTYPER<n>_EL0.evtCount

Ondrej Mosnacek (1):
      io_uring: don't audit the capability check in io_uring_create()

Pablo Neira Ayuso (2):
      netfilter: nf_tables: skip bound chain in netns release path
      netfilter: nf_tables: skip bound chain on rule flush

Pauli Virtanen (4):
      Bluetooth: use RCU for hci_conn_params and iterate safely in hci_sync
      Bluetooth: hci_event: call disconnect callback before deleting conn
      Bluetooth: ISO: fix iso_conn related locking and validity issues
      Bluetooth: SCO: fix sco_conn related locking and validity issues

Peijie Shao (1):
      tpm_tis_spi: Release chip select when flow control fails

Peng Zhang (1):
      maple_tree: set the node limit when creating a new root node

Peter Ujfalusi (1):
      tpm: tpm_tis: Disable interrupts *only* for AEON UPX-i11

Petr Oros (1):
      ice: Unregister netdev and devlink_port only once

Petr Pavlu (1):
      keys: Fix linking a duplicate key to a keyring's assoc_array

Qu Wenruo (1):
      btrfs: raid56: always verify the P/Q contents for scrub

Rafael J. Wysocki (3):
      Revert "intel_idle: Add __init annotation to
matchup_vm_state_with_baremetal()"
      Revert "intel_idle: Add a "Long HLT" C1 state for the VM guest mode"
      Revert "intel_idle: Add support for using intel_idle in a VM
guest using just hlt"

Randy Dunlap (11):
      kconfig: gconfig: drop the Show Debug Info help text
      kconfig: gconfig: correct program name in help text
      net: bonding: remove kernel-doc comment marker
      net: cfg802154: fix kernel-doc notation warnings
      codel: fix kernel-doc notation warnings
      devlink: fix kernel-doc notation warnings
      inet: frags: eliminate kernel-doc warning
      net: llc: fix kernel-doc notation warnings
      net: NSH: fix kernel-doc notation warning
      pie: fix kernel-doc notation warning
      rsi: remove kernel-doc comment marker

Ricardo Ca=C3=B1uelo (1):
      selftests/mincore: fix skip condition for check_huge_pages test

Rob Herring (5):
      ASoC: dt-bindings: audio-graph-card2: Drop incomplete example
      of: Preserve "of-display" device name for compatibility
      fbdev: Explicitly include correct DT includes
      dt-bindings: serial: Remove obsolete cavium-uart.txt
      dt-bindings: serial: Remove obsolete nxp,lpc1850-uart.txt

Rohit kumar (1):
      ASoC: dt-bindings: Update maintainer email id

Ross Lagerwall (1):
      blk-mq: Fix stall due to recursive flush plug

Russell Currey (1):
      powerpc/crypto: Add gitignore for generated P10 AES/GCM .S files

Ryan Roberts (1):
      selftests/mm: give scripts execute permission

Sameer Pujar (1):
      ASoC: rt5640: Fix sleep in atomic context

Sandipan Das (1):
      perf vendor events amd: Fix large metrics

Shannon Nelson (1):
      mailmap: add entries for past lives

Sheetal (2):
      ASoC: tegra: Fix AMX byte map
      ASoC: tegra: Fix ADX byte map

Shuming Fan (1):
      ASoC: rt5645: check return value after reading device id

Shyam Prasad N (1):
      cifs: allow dumping keys for directories too

Siddh Raman Pant (1):
      Bluetooth: hci_conn: return ERR_PTR instead of NULL when there is no =
link

Simon Ser (1):
      drm/amd/display: only accept async flips for fast updates

Srinivas Kandagatla (4):
      ASoC: qdsp6: q6apm: use dai link pcm id as pcm device number
      ASoC: qcom: q6afe-dai: fix Display Port Playback stream name
      ASoC: codecs: wcd938x: fix dB range for HPHL and HPHR
      ASoC: qcom: q6apm: do not close GPR port before closing graph

Srinivasan Shanmugam (1):
      drm/amd/display: Clean up errors & warnings in amdgpu_dm.c

Steve French (1):
      cifs: update internal module version number for cifs.ko

Subbaraya Sundeep (1):
      octeontx2-pf: mcs: Generate hash key using ecb(aes)

Sudeep Holla (1):
      KVM: arm64: Handle kvm_arm_init failure correctly in finalize_pkvm

Sven Schnelle (1):
      s390/mm: fix per vma lock fault handling

Taimur Hassan (1):
      drm/amd/display: check TG is non-null before checking if enabled

Takashi Iwai (2):
      ALSA: seq: Fix memory leak at error path in snd_seq_create_port()
      selftests: ALSA: Add test-pcmtest-driver to .gitignore

Tanmay Patil (1):
      net: ethernet: ti: cpsw_ale: Fix cpsw_ale_get_field()/cpsw_ale_set_fi=
eld()

Thomas Petazzoni (1):
      ASoC: cs42l51: fix driver to properly autoload with automatic
module loading

Thomas Richter (1):
      perf build: Fix broken feature check for libtracefs due to
external lib changes

Tomasz Mo=C5=84 (1):
      Bluetooth: btusb: Fix bluetooth on Intel Macbook 2014

Tristram Ha (1):
      net: dsa: microchip: correct KSZ8795 static MAC table access

Uwe Kleine-K=C3=B6nig (4):
      ALSA: pcmtest: Convert to platform remove callback returning void
      ALSA: pcmtest: Don't use static storage to track per device data
      powerpc/512x: lpbfifo: Convert to platform remove callback returning =
void
      gpio: mvebu: Make use of devm_pwmchip_add

Valentin David (1):
      tpm: Do not remap from ACPI resources again for Pluton TPM

Victor Nogueira (5):
      net: sched: cls_matchall: Undo tcf_bind_filter in case of
failure after mall_set_parms
      net: sched: cls_u32: Undo tcf_bind_filter if u32_replace_hw_knode
      net: sched: cls_u32: Undo refcount decrement in case update failed
      net: sched: cls_bpf: Undo tcf_bind_filter in case of an error
      net: sched: cls_flower: Undo tcf_bind_filter in case of an error

Vijendar Mukunda (6):
      ASoC: amd: ps: add comments for DMA irq bits mapping
      ASoC: amd: ps: add fix for dma irq mask for rx streams for SDW0 insta=
nce
      ASoC: amd: ps: fix for position register set for AUDIO0 RX stream
      ASoC: amd: ps: add comments for DMA register mapping
      ASoC: amd: ps: fix byte count return value for invalid SoundWire
manager instance
      ASoC: amd: acp: fix for invalid dai id handling in acp_get_byte_count=
()

Ville Syrj=C3=A4l=C3=A4 (1):
      dma-buf/dma-resv: Stop leaking on krealloc() failure

Vitaly Rodionov (2):
      ALSA: hda/realtek: Fix generic fixup definition for cs35l41 amp
      ALSA: hda/realtek: Add support for DELL Oasis 13/14/16 laptops

Vladimir Oltean (1):
      net: phy: prevent stale pointer dereference in phy_init()

Wang Ming (4):
      bna: Remove error checking for debugfs_create_dir()
      net: ethernet: Remove repeating expression
      net: ipv4: Use kfree_sensitive instead of kfree
      s390/crypto: use kfree_sensitive() instead of kfree()

Wayne Lin (1):
      drm/amd/display: Add polling method to handle MST reply packet

Xiang Chen (1):
      KVM: arm64: Fix the name of sys_reg_desc related to PMU

Yan Zhai (1):
      gso: fix dodgy bit handling for GSO_UDP_L4

Yangtao Li (4):
      fbdev: imxfb: Removed unneeded release_mem_region
      fbdev: imxfb: Convert to devm_kmalloc_array()
      fbdev: imxfb: Convert to devm_platform_ioremap_resource()
      fbdev: imxfb: remove unneeded labels

Yuanjun Gong (6):
      net:ipv6: check return value of pskb_trim()
      drivers: net: fix return value check in emac_tso_csum()
      drivers:net: fix return value check in ocelot_fdma_receive_skb
      ipv4: ip_gre: fix return value check in erspan_fb_xmit()
      ipv4: ip_gre: fix return value check in erspan_xmit()
      fbdev: ep93xx-fb: fix return value check in ep93xxfb_probe

YueHaibing (2):
      can: bcm: Fix UAF in bcm_proc_show()
      tracing: Remove unused extern declaration tracing_map_set_field_descr=
()

Zhang Shurong (1):
      fbdev: au1200fb: Fix missing IRQ check in au1200fb_drv_probe

Zhang Yi (5):
      jbd2: recheck chechpointing non-dirty buffer
      jbd2: remove t_checkpoint_io_list
      jbd2: remove journal_clean_one_cp_list()
      jbd2: fix a race when checking checkpoint buffer busy
      jbd2: remove __journal_try_to_free_buffer()

Zhen Lei (1):
      arm64: vdso: Clear common make C=3D2 warnings

Zhihao Cheng (1):
      jbd2: Fix wrongly judgement for buffer head removing while doing
checkpoint

Zhikai Zhai (1):
      drm/amd/display: Disable MPC split by default on special asic

Ziyang Xuan (1):
      can: raw: fix receiver memory leak

zyfjeff (1):
      fuse: remove duplicate check for nodeid
