Return-Path: <linux-kernel+bounces-64071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C57D78539CC
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 19:22:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7732B23144
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 18:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44400605D5;
	Tue, 13 Feb 2024 18:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CrGYWBE6"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D7A605C6;
	Tue, 13 Feb 2024 18:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707848524; cv=none; b=jxZR9eGiYqv/nyfsuoL+HXFn/fMHY3ZGeApr1hC3LROSTUE5UKqtRyRtxeO0WVkIAwzn2RLIZI0wV/eED50IxYxyLM5dDIuV2YoNr3w5lHycHy3SCTcr2i2MMiwEP22WBvrgLFiJhwj5q1jMnDMHbwmsfsAppUJJWwKa1dE2W4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707848524; c=relaxed/simple;
	bh=vVRC61c2xRGvvlEQEerWSJ2uiUzQDtj/NIkp+OxzjoA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tlkPCxJ1Xeg/Pp9TJ4Q2pnPA/eQVCxlkIu/VrJKufIylgObgetDbnMVKIhvBWUrj2axkOJ/b+E+Ie76dQekH20nNIa9Tev+lkHz/NSaBSdmCl5SWFYvubSlMOMTUWDHvhwkTih+8vV5Zqh4Q89yMCFfRGKOwlbyfVxVwJCa/Xgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CrGYWBE6; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-5cddfe0cb64so834778a12.0;
        Tue, 13 Feb 2024 10:22:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707848521; x=1708453321; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=l9hYGc3y/0icnpni5Ypc4ntYC0rWFiHuqQuiOunPnjk=;
        b=CrGYWBE6627H4tbaN5W881JQqk6T0TwAgXMl/Xh/oj0k6lz2+E4iRslV2TDIcfQc+B
         BFrNWRfnz+0DqfX7+Unx+83Z3SLgnTyPQyRquV/DB+rXi4P601dOsJ2qH08QB4y316jL
         td/AOSAGtCb0kQpW9h0sBwfSDl0wcrHZLphWlqPAOEmL/VabH2eBNR0R0Y5ZIxjkDqoo
         BSPc3pdZY5gBGHwagXeaPb+2IemjRg1p0W8JxP/bWS1x4SfF+kHcV+3dvE17uQAwC3nR
         iWwm1PRKWJ7lfRC2mIPd9B2xyydoa6QiVR7WD6jS8YdUJaCZ7Wd10pDTsXjqaNPchx9B
         KCCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707848521; x=1708453321;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l9hYGc3y/0icnpni5Ypc4ntYC0rWFiHuqQuiOunPnjk=;
        b=slx0cJGNsgFqMXU4DKr2MaQfsvl3OTRZKpxjl70mpZf+eo1Z0dFYRsQpZVOwGUzpGW
         DsxAjBHTsQSL8XLs4MpACTmLFVwW94EVdHfvhM04X6E6/xboe9THkWf66zvpamDfeiUC
         5GV3Pv2O1VL4c8v7Nf1MQSNV/X/kj8QsqZ9FLDyPplk/8swZ02rANQjZH6wrRDs+zAB0
         cmDZOBcZEu9Hw+e2x4G3ltxj+aruDKcTjXGJdd5UNRbQDunCQRodp3ub+SZCl0sMa0Hn
         CpI6jzP8ApnSbDgHmun8FqZT2mKIWU4/JSJYsMnLNqGximV8LPMFhw+KPUfFakIQOcSP
         9SHQ==
X-Forwarded-Encrypted: i=1; AJvYcCWB7Ad11y3GaqZCC0d8A43QC2L6dG1iZ6PfvtD5M5nqM7Pr5Zg09fU9E9SHX7nFUkwP7KjMpRFY5UK2x8Lf3YZC9SYj3KcEkDO07ot/
X-Gm-Message-State: AOJu0YxJROLkGOSQWkfb+lsQk3RWS3qPRMllelyoTKOl40VBnWMrh6di
	2aJ82mW5C0h2NnOTsMhwBcRiNknICvfS0y1g6edHlqB2YsyBWHW78XN9VhnqS6GCXNnTIWtlIfw
	IhISlJ5pQelmZtYmvJx/F4LKgg0A=
X-Google-Smtp-Source: AGHT+IEpZ1RnEqwZBWP9KkTJLvGb7xkouE0+djyINJ7jTS24QRkVo9Vxm9iHYJ0GJc72P+MyUHI/E/Z7bVr8PnKOQR4=
X-Received: by 2002:a17:90a:f98f:b0:298:9cd0:49e4 with SMTP id
 cq15-20020a17090af98f00b002989cd049e4mr276234pjb.39.1707848520506; Tue, 13
 Feb 2024 10:22:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240213171853.722912593@linuxfoundation.org>
In-Reply-To: <20240213171853.722912593@linuxfoundation.org>
From: Luna Jernberg <droidbittin@gmail.com>
Date: Tue, 13 Feb 2024 19:21:47 +0100
Message-ID: <CADo9pHiJade0q2=zrs=rgkPCdg0KR0RMs4G2mqRmxPt2=NU8Vw@mail.gmail.com>
Subject: Re: [PATCH 6.7 000/124] 6.7.5-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Luna Jernberg <droidbittin@gmail.com>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com
Content-Type: text/plain; charset="UTF-8"

Works fine on my desktop with model name    : AMD Ryzen 5 5600 6-Core
Processor and Arch Linux

Tested-by: Luna Jernberg <droidbittin@gmail.com>

Den tis 13 feb. 2024 kl 18:35 skrev Greg Kroah-Hartman
<gregkh@linuxfoundation.org>:
>
> This is the start of the stable review cycle for the 6.7.5 release.
> There are 124 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 15 Feb 2024 17:18:29 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.7.5-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.7.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>
> -------------
> Pseudo-Shortlog of commits:
>
> Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>     Linux 6.7.5-rc1
>
> Michael Lass <bevan@bi-co.net>
>     net: Fix from address in memcpy_to_iter_csum()
>
> Jens Axboe <axboe@kernel.dk>
>     io_uring/net: limit inline multishot retries
>
> Jens Axboe <axboe@kernel.dk>
>     io_uring/poll: add requeue return code from poll multishot handling
>
> Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>     Revert "ASoC: amd: Add new dmi entries for acp5x platform"
>
> Kent Overstreet <kent.overstreet@linux.dev>
>     bcachefs: time_stats: Check for last_event == 0 when updating freq stats
>
> Guoyu Ou <benogy@gmail.com>
>     bcachefs: unlock parent dir if entry is not found in subvolume deletion
>
> Christoph Hellwig <hch@lst.de>
>     bcachefs: fix incorrect usage of REQ_OP_FLUSH
>
> Su Yue <glass.su@suse.com>
>     bcachefs: grab s_umount only if snapshotting
>
> Su Yue <glass.su@suse.com>
>     bcachefs: kvfree bch_fs::snapshots in bch2_fs_snapshots_exit
>
> Kent Overstreet <kent.overstreet@linux.dev>
>     bcachefs: bch2_kthread_io_clock_wait() no longer sleeps until full amount
>
> Kent Overstreet <kent.overstreet@linux.dev>
>     bcachefs: Add missing bch2_moving_ctxt_flush_all()
>
> Daniel Hill <daniel@gluo.nz>
>     bcachefs: rebalance should wakeup on shutdown if disabled
>
> Kent Overstreet <kent.overstreet@linux.dev>
>     bcachefs: Don't pass memcmp() as a pointer
>
> Al Viro <viro@zeniv.linux.org.uk>
>     bch2_ioctl_subvolume_destroy(): fix locking
>
> Al Viro <viro@zeniv.linux.org.uk>
>     new helper: user_path_locked_at()
>
> Johan Hovold <johan+linaro@kernel.org>
>     PCI/ASPM: Fix deadlock when enabling ASPM
>
> Jens Axboe <axboe@kernel.dk>
>     io_uring/rw: ensure poll based multishot read retries appropriately
>
> Jens Axboe <axboe@kernel.dk>
>     io_uring/net: un-indent mshot retry path in io_recv_finish()
>
> Jens Axboe <axboe@kernel.dk>
>     io_uring/poll: move poll execution helpers higher up
>
> Jens Axboe <axboe@kernel.dk>
>     io_uring/net: fix sr->len for IORING_OP_RECV with MSG_WAITALL and buffers
>
> Emmanuel Grumbach <emmanuel.grumbach@intel.com>
>     wifi: iwlwifi: mvm: fix a battery life regression
>
> Hans de Goede <hdegoede@redhat.com>
>     Input: atkbd - skip ATKBD_CMD_SETLEDS when skipping ATKBD_CMD_GETID
>
> Werner Sembach <wse@tuxedocomputers.com>
>     Input: i8042 - fix strange behavior of touchpad on Clevo NS70PU
>
> Frederic Weisbecker <frederic@kernel.org>
>     hrtimer: Report offline hrtimer enqueue
>
> Heikki Krogerus <heikki.krogerus@linux.intel.com>
>     usb: dwc3: pci: add support for the Intel Arrow Lake-H
>
> Michal Pecio <michal.pecio@gmail.com>
>     xhci: handle isoc Babble and Buffer Overrun events properly
>
> Mathias Nyman <mathias.nyman@linux.intel.com>
>     xhci: process isoc TD properly when there was a transaction error mid TD.
>
> Prashanth K <quic_prashk@quicinc.com>
>     usb: host: xhci-plat: Add support for XHCI_SG_TRB_CACHE_SIZE_QUIRK
>
> Prashanth K <quic_prashk@quicinc.com>
>     usb: dwc3: host: Set XHCI_SG_TRB_CACHE_SIZE_QUIRK
>
> Qiuxu Zhuo <qiuxu.zhuo@intel.com>
>     x86/lib: Revert to _ASM_EXTABLE_UA() for {get,put}_user() fixups
>
> Mario Limonciello <mario.limonciello@amd.com>
>     Revert "drm/amd/pm: fix the high voltage and temperature issue"
>
> Badhri Jagan Sridharan <badhri@google.com>
>     Revert "usb: typec: tcpm: fix cc role at port reset"
>
> Leonard Dallmayr <leonard.dallmayr@mailbox.org>
>     USB: serial: cp210x: add ID for IMST iM871A-USB
>
> Puliang Lu <puliang.lu@fibocom.com>
>     USB: serial: option: add Fibocom FM101-GL variant
>
> JackBB Wu <wojackbb@gmail.com>
>     USB: serial: qcserial: add new usb-id for Dell Wireless DW5826e
>
> Sean Young <sean@mess.org>
>     ALSA: usb-audio: add quirk for RODE NT-USB+
>
> Julian Sikorski <belegdol+github@gmail.com>
>     ALSA: usb-audio: Add a quirk for Yamaha YIT-W12TX transmitter
>
> Alexander Tsoy <alexander@tsoy.me>
>     ALSA: usb-audio: Add delay quirk for MOTU M Series 2nd revision
>
> Tejun Heo <tj@kernel.org>
>     blk-iocost: Fix an UBSAN shift-out-of-bounds warning
>
> Muhammad Usama Anjum <usama.anjum@collabora.com>
>     selftests: core: include linux/close_range.h for CLOSE_RANGE_* macros
>
> Maurizio Lombardi <mlombard@redhat.com>
>     nvme-host: fix the updating of the firmware version
>
> Ben Dooks <ben.dooks@codethink.co.uk>
>     riscv: declare overflow_stack as exported from traps.c
>
> Alexandre Ghiti <alexghiti@rivosinc.com>
>     riscv: Fix arch_hugetlb_migration_supported() for NAPOT
>
> Xiubo Li <xiubli@redhat.com>
>     ceph: always set initial i_blkbits to CEPH_FSCRYPT_BLOCK_SHIFT
>
> Xiubo Li <xiubli@redhat.com>
>     libceph: just wait for more data to be available on the socket
>
> Xiubo Li <xiubli@redhat.com>
>     libceph: rename read_sparse_msg_*() to read_partial_sparse_msg_*()
>
> Alexandre Ghiti <alexghiti@rivosinc.com>
>     riscv: Flush the tlb when a page directory is freed
>
> Ming Lei <ming.lei@redhat.com>
>     scsi: core: Move scsi_host_busy() out of host lock if it is for per-command
>
> Alexandre Ghiti <alexghiti@rivosinc.com>
>     riscv: Fix hugetlb_mask_last_page() when NAPOT is enabled
>
> Alexandre Ghiti <alexghiti@rivosinc.com>
>     riscv: Fix set_huge_pte_at() for NAPOT mapping
>
> Vincent Chen <vincent.chen@sifive.com>
>     riscv: mm: execute local TLB flush after populating vmemmap
>
> Alexandre Ghiti <alexghiti@rivosinc.com>
>     mm: Introduce flush_cache_vmap_early()
>
> Dan Carpenter <dan.carpenter@linaro.org>
>     fs/ntfs3: Fix an NULL dereference bug
>
> Florian Westphal <fw@strlen.de>
>     netfilter: nft_set_pipapo: remove scratch_aligned pointer
>
> Florian Westphal <fw@strlen.de>
>     netfilter: nft_set_pipapo: add helper to release pcpu scratch area
>
> Florian Westphal <fw@strlen.de>
>     netfilter: nft_set_pipapo: store index in scratch maps
>
> Florian Westphal <fw@strlen.de>
>     netfilter: nfnetlink_queue: un-break NF_REPEAT
>
> Pablo Neira Ayuso <pablo@netfilter.org>
>     netfilter: nf_tables: use timestamp to check for set element timeout
>
> Pablo Neira Ayuso <pablo@netfilter.org>
>     netfilter: nft_ct: reject direction for ct id
>
> Pablo Neira Ayuso <pablo@netfilter.org>
>     netfilter: nft_set_pipapo: remove static in nft_pipapo_get()
>
> Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
>     drm/amd/display: Implement bounds check for stream encoder creation in DCN301
>
> Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
>     drm/amd/display: Add NULL test for 'timing generator' in 'dcn21_set_pipe()'
>
> Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
>     drm/amd/display: Fix 'panel_cntl' could be null in 'dcn21_set_backlight_level()'
>
> Pablo Neira Ayuso <pablo@netfilter.org>
>     netfilter: nft_compat: restrict match/target protocol to u16
>
> Pablo Neira Ayuso <pablo@netfilter.org>
>     netfilter: nft_compat: reject unused compat flag
>
> Pablo Neira Ayuso <pablo@netfilter.org>
>     netfilter: nft_compat: narrow down revision to unsigned 8-bits
>
> Jakub Kicinski <kuba@kernel.org>
>     selftests: cmsg_ipv6: repeat the exact packet
>
> Eric Dumazet <edumazet@google.com>
>     ppp_async: limit MRU to 64K
>
> Jiri Pirko <jiri@resnulli.us>
>     devlink: avoid potential loop in devlink_rel_nested_in_notify_work()
>
> Kuniyuki Iwashima <kuniyu@amazon.com>
>     af_unix: Call kfree_skb() for dead unix_(sk)->oob_skb in GC.
>
> Shigeru Yoshida <syoshida@redhat.com>
>     tipc: Check the bearer type before calling tipc_udp_nl_bearer_add()
>
> Paolo Abeni <pabeni@redhat.com>
>     selftests: net: let big_tcp test cope with slow env
>
> David Howells <dhowells@redhat.com>
>     rxrpc: Fix counting of new acks and nacks
>
> David Howells <dhowells@redhat.com>
>     rxrpc: Fix response to PING RESPONSE ACKs to a dead call
>
> David Howells <dhowells@redhat.com>
>     rxrpc: Fix delayed ACKs to not set the reference serial number
>
> David Howells <dhowells@redhat.com>
>     rxrpc: Fix generation of serial numbers to skip zero
>
> Ard Biesheuvel <ardb@kernel.org>
>     x86/efistub: Use 1:1 file:memory mapping for PE/COFF .compat section
>
> Dan Carpenter <dan.carpenter@linaro.org>
>     drm/i915/gvt: Fix uninitialized variable in handle_mmio()
>
> Eric Dumazet <edumazet@google.com>
>     inet: read sk->sk_family once in inet_recv_error()
>
> Zhang Rui <rui.zhang@intel.com>
>     hwmon: (coretemp) Fix bogus core_id to attr name mapping
>
> Zhang Rui <rui.zhang@intel.com>
>     hwmon: (coretemp) Fix out-of-bounds memory access
>
> Loic Prylli <lprylli@netflix.com>
>     hwmon: (aspeed-pwm-tacho) mutex for tach reading
>
> Zhipeng Lu <alexious@zju.edu.cn>
>     octeontx2-pf: Fix a memleak otx2_sq_init
>
> Zhipeng Lu <alexious@zju.edu.cn>
>     atm: idt77252: fix a memleak in open_card_ubr0
>
> Antoine Tenart <atenart@kernel.org>
>     tunnels: fix out of bounds access when building IPv6 PMTU error
>
> Gerhard Engleder <gerhard@engleder-embedded.com>
>     tsnep: Fix mapping for zero copy XDP_TX action
>
> Paolo Abeni <pabeni@redhat.com>
>     selftests: net: avoid just another constant wait
>
> Paolo Abeni <pabeni@redhat.com>
>     selftests: net: fix tcp listener handling in pmtu.sh
>
> Yujie Liu <yujie.liu@intel.com>
>     selftests/net: change shebang to bash to support "source"
>
> Hangbin Liu <liuhangbin@gmail.com>
>     selftests/net: convert pmtu.sh to run it in unique namespace
>
> Hangbin Liu <liuhangbin@gmail.com>
>     selftests/net: convert unicast_extensions.sh to run it in unique namespace
>
> Paolo Abeni <pabeni@redhat.com>
>     selftests: net: cut more slack for gro fwd tests.
>
> Ivan Vecera <ivecera@redhat.com>
>     net: atlantic: Fix DMA mapping for PTP hwts ring
>
> Eric Dumazet <edumazet@google.com>
>     netdevsim: avoid potential loop in nsim_dev_trap_report_work()
>
> Kees Cook <keescook@chromium.org>
>     wifi: brcmfmac: Adjust n_channels usage for __counted_by
>
> Miri Korenblit <miriam.rachel.korenblit@intel.com>
>     wifi: iwlwifi: exit eSR only after the FW does
>
> Johannes Berg <johannes.berg@intel.com>
>     wifi: mac80211: fix waiting for beacons logic
>
> Johannes Berg <johannes.berg@intel.com>
>     wifi: mac80211: fix unsolicited broadcast probe config
>
> Johannes Berg <johannes.berg@intel.com>
>     wifi: mac80211: fix RCU use in TDLS fast-xmit
>
> Johannes Berg <johannes.berg@intel.com>
>     wifi: mac80211: improve CSA/ECSA connection refusal
>
> Johannes Berg <johannes.berg@intel.com>
>     wifi: cfg80211: detect stuck ECSA element in probe resp
>
> Benjamin Berg <benjamin.berg@intel.com>
>     wifi: cfg80211: consume both probe response and beacon IEs
>
> Furong Xu <0x1207@gmail.com>
>     net: stmmac: xgmac: fix handling of DPP safety error for DMA channels
>
> Ard Biesheuvel <ardb@kernel.org>
>     x86/efistub: Avoid placing the kernel below LOAD_PHYSICAL_ADDR
>
> Ard Biesheuvel <ardb@kernel.org>
>     x86/efistub: Give up if memory attribute protocol returns an error
>
> Benjamin Berg <benjamin.berg@intel.com>
>     wifi: iwlwifi: mvm: skip adding debugfs symlink for reconfig
>
> Abhinav Kumar <quic_abhinavk@quicinc.com>
>     drm/msm/dpu: check for valid hw_pp in dpu_encoder_helper_phys_cleanup
>
> Kuogee Hsieh <quic_khsieh@quicinc.com>
>     drm/msm/dp: return correct Colorimetry for DP_TEST_DYNAMIC_RANGE_CEA case
>
> Kuogee Hsieh <quic_khsieh@quicinc.com>
>     drm/msms/dp: fixed link clock divider bits be over written in BPC unknown case
>
> Shyam Prasad N <sprasad@microsoft.com>
>     cifs: failure to add channel on iface should bump up weight
>
> Shyam Prasad N <sprasad@microsoft.com>
>     cifs: avoid redundant calls to disable multichannel
>
> Tony Lindgren <tony@atomide.com>
>     phy: ti: phy-omap-usb2: Fix NULL pointer dereference for SRP
>
> Frank Li <Frank.Li@nxp.com>
>     dmaengine: fix is_slave_direction() return false when DMA_DEV_TO_DEV
>
> James Clark <james.clark@arm.com>
>     perf evlist: Fix evlist__new_default() for > 1 core PMU
>
> Thomas Richter <tmricht@linux.ibm.com>
>     perf test: Fix 'perf script' tests on s390
>
> Ian Rogers <irogers@google.com>
>     perf tests: Add perf script test
>
> Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
>     phy: renesas: rcar-gen3-usb2: Fix returning wrong error code
>
> Mantas Pucka <mantas@8devices.com>
>     phy: qcom-qmp-usb: fix serdes init sequence for IPQ6018
>
> Mantas Pucka <mantas@8devices.com>
>     phy: qcom-qmp-usb: fix register offsets for ipq8074/ipq6018
>
> Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>     dmaengine: fsl-qdma: Fix a memory leak related to the queue command DMA
>
> Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>     dmaengine: fsl-qdma: Fix a memory leak related to the status queue DMA
>
> Jai Luthra <j-luthra@ti.com>
>     dmaengine: ti: k3-udma: Report short packet errors
>
> Guanhua Gao <guanhua.gao@nxp.com>
>     dmaengine: fsl-dpaa2-qdma: Fix the size of dma pools
>
> Baokun Li <libaokun1@huawei.com>
>     ext4: regenerate buddy after block freeing failed if under fc replay
>
>
> -------------
>
> Diffstat:
>
>  Makefile                                           |   4 +-
>  arch/arc/include/asm/cacheflush.h                  |   1 +
>  arch/arm/include/asm/cacheflush.h                  |   2 +
>  arch/csky/abiv1/inc/abi/cacheflush.h               |   1 +
>  arch/csky/abiv2/inc/abi/cacheflush.h               |   1 +
>  arch/m68k/include/asm/cacheflush_mm.h              |   1 +
>  arch/mips/include/asm/cacheflush.h                 |   2 +
>  arch/nios2/include/asm/cacheflush.h                |   1 +
>  arch/parisc/include/asm/cacheflush.h               |   1 +
>  arch/riscv/include/asm/cacheflush.h                |   3 +-
>  arch/riscv/include/asm/hugetlb.h                   |   3 +
>  arch/riscv/include/asm/stacktrace.h                |   5 +
>  arch/riscv/include/asm/tlb.h                       |   2 +-
>  arch/riscv/include/asm/tlbflush.h                  |   2 +
>  arch/riscv/mm/hugetlbpage.c                        |  78 ++++++++++++-
>  arch/riscv/mm/init.c                               |   4 +
>  arch/riscv/mm/tlbflush.c                           |   6 +
>  arch/sh/include/asm/cacheflush.h                   |   1 +
>  arch/sparc/include/asm/cacheflush_32.h             |   1 +
>  arch/sparc/include/asm/cacheflush_64.h             |   1 +
>  arch/x86/boot/header.S                             |  14 +--
>  arch/x86/boot/setup.ld                             |   6 +-
>  arch/x86/lib/getuser.S                             |  24 ++--
>  arch/x86/lib/putuser.S                             |  20 ++--
>  arch/xtensa/include/asm/cacheflush.h               |   6 +-
>  block/blk-iocost.c                                 |   7 ++
>  drivers/atm/idt77252.c                             |   2 +
>  drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.c            |  10 +-
>  drivers/dma/fsl-qdma.c                             |  28 ++---
>  drivers/dma/ti/k3-udma.c                           |  10 +-
>  drivers/firmware/efi/libstub/efistub.h             |   3 +-
>  drivers/firmware/efi/libstub/kaslr.c               |   2 +-
>  drivers/firmware/efi/libstub/randomalloc.c         |  12 +-
>  drivers/firmware/efi/libstub/x86-stub.c            |  25 ++--
>  drivers/firmware/efi/libstub/x86-stub.h            |   4 +-
>  drivers/firmware/efi/libstub/zboot.c               |   2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |  24 ++--
>  .../drm/amd/display/dc/dcn301/dcn301_resource.c    |   2 +-
>  .../drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.c    |  63 +++++-----
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c          |  33 +-----
>  drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h      |   1 -
>  .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c   |   8 +-
>  .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c   |   8 +-
>  drivers/gpu/drm/i915/gvt/handlers.c                |   3 +-
>  drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c        |   4 +-
>  drivers/gpu/drm/msm/dp/dp_ctrl.c                   |   5 -
>  drivers/gpu/drm/msm/dp/dp_link.c                   |  22 ++--
>  drivers/gpu/drm/msm/dp/dp_reg.h                    |   3 +
>  drivers/hwmon/aspeed-pwm-tacho.c                   |   7 ++
>  drivers/hwmon/coretemp.c                           |  40 ++++---
>  drivers/input/keyboard/atkbd.c                     |  13 ++-
>  drivers/input/serio/i8042-acpipnpio.h              |   6 +
>  drivers/net/ethernet/aquantia/atlantic/aq_ptp.c    |   4 +-
>  drivers/net/ethernet/aquantia/atlantic/aq_ring.c   |  13 +++
>  drivers/net/ethernet/aquantia/atlantic/aq_ring.h   |   1 +
>  drivers/net/ethernet/engleder/tsnep_main.c         |  16 ++-
>  .../ethernet/marvell/octeontx2/nic/otx2_common.c   |  14 ++-
>  drivers/net/ethernet/stmicro/stmmac/common.h       |   1 +
>  drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h     |   3 +
>  .../net/ethernet/stmicro/stmmac/dwxgmac2_core.c    |  57 ++++++++-
>  drivers/net/netdevsim/dev.c                        |   8 +-
>  drivers/net/ppp/ppp_async.c                        |   4 +
>  .../broadcom/brcm80211/brcmfmac/cfg80211.c         |   6 +-
>  drivers/net/wireless/intel/iwlwifi/fw/api/debug.h  |   2 +-
>  drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c  |   6 +-
>  .../net/wireless/intel/iwlwifi/mvm/mld-mac80211.c  |   9 +-
>  drivers/nvme/host/core.c                           |   7 +-
>  drivers/pci/bus.c                                  |  49 +++++---
>  drivers/pci/controller/dwc/pcie-qcom.c             |   2 +-
>  drivers/pci/pci.c                                  |  78 ++++++++-----
>  drivers/pci/pci.h                                  |   4 +-
>  drivers/pci/pcie/aspm.c                            |  13 ++-
>  drivers/phy/qualcomm/phy-qcom-qmp-usb.c            |  30 ++++-
>  drivers/phy/renesas/phy-rcar-gen3-usb2.c           |   4 -
>  drivers/phy/ti/phy-omap-usb2.c                     |   4 +-
>  drivers/scsi/scsi_error.c                          |   3 +-
>  drivers/scsi/scsi_lib.c                            |   4 +-
>  drivers/usb/dwc3/dwc3-pci.c                        |   4 +
>  drivers/usb/dwc3/host.c                            |   4 +-
>  drivers/usb/host/xhci-plat.c                       |   3 +
>  drivers/usb/host/xhci-ring.c                       |  80 ++++++++++---
>  drivers/usb/host/xhci.h                            |   1 +
>  drivers/usb/serial/cp210x.c                        |   1 +
>  drivers/usb/serial/option.c                        |   1 +
>  drivers/usb/serial/qcserial.c                      |   2 +
>  drivers/usb/typec/tcpm/tcpm.c                      |   3 +-
>  fs/bcachefs/clock.c                                |   4 +-
>  fs/bcachefs/fs-io.c                                |   2 +-
>  fs/bcachefs/fs-ioctl.c                             |  42 +++----
>  fs/bcachefs/journal_io.c                           |   3 +-
>  fs/bcachefs/move.c                                 |   2 +-
>  fs/bcachefs/move.h                                 |   1 +
>  fs/bcachefs/rebalance.c                            |  13 ++-
>  fs/bcachefs/replicas.c                             |  10 +-
>  fs/bcachefs/snapshot.c                             |   2 +-
>  fs/bcachefs/util.c                                 |   5 +-
>  fs/ceph/inode.c                                    |   2 +
>  fs/ext4/mballoc.c                                  |  20 ++++
>  fs/namei.c                                         |  16 ++-
>  fs/ntfs3/ntfs_fs.h                                 |   2 +-
>  fs/smb/client/sess.c                               |   2 +
>  fs/smb/client/smb2pdu.c                            |   2 +-
>  include/asm-generic/cacheflush.h                   |   6 +
>  include/linux/ceph/messenger.h                     |   2 +-
>  include/linux/dmaengine.h                          |   3 +-
>  include/linux/hrtimer.h                            |   4 +-
>  include/linux/namei.h                              |   1 +
>  include/linux/pci.h                                |   5 +
>  include/net/cfg80211.h                             |   4 +
>  include/net/netfilter/nf_tables.h                  |  16 ++-
>  include/trace/events/rxrpc.h                       |   8 +-
>  include/uapi/linux/netfilter/nf_tables.h           |   2 +
>  io_uring/io_uring.h                                |   7 ++
>  io_uring/net.c                                     |  54 ++++++---
>  io_uring/poll.c                                    |  49 ++++----
>  io_uring/poll.h                                    |   9 ++
>  io_uring/rw.c                                      |  10 +-
>  kernel/time/hrtimer.c                              |   3 +
>  mm/percpu.c                                        |   8 +-
>  net/ceph/messenger_v1.c                            |  33 +++---
>  net/ceph/messenger_v2.c                            |   4 +-
>  net/ceph/osd_client.c                              |   9 +-
>  net/core/datagram.c                                |   2 +-
>  net/devlink/core.c                                 |  12 +-
>  net/ipv4/af_inet.c                                 |   6 +-
>  net/ipv4/ip_tunnel_core.c                          |   2 +-
>  net/mac80211/cfg.c                                 |  14 +--
>  net/mac80211/mlme.c                                | 106 ++++++++++++-----
>  net/mac80211/tx.c                                  |   7 +-
>  net/netfilter/nf_tables_api.c                      |   4 +-
>  net/netfilter/nfnetlink_queue.c                    |  13 ++-
>  net/netfilter/nft_compat.c                         |  17 ++-
>  net/netfilter/nft_ct.c                             |   3 +
>  net/netfilter/nft_set_hash.c                       |   8 +-
>  net/netfilter/nft_set_pipapo.c                     | 128 +++++++++++----------
>  net/netfilter/nft_set_pipapo.h                     |  18 ++-
>  net/netfilter/nft_set_pipapo_avx2.c                |  17 ++-
>  net/netfilter/nft_set_rbtree.c                     |  11 +-
>  net/rxrpc/ar-internal.h                            |  37 ++++--
>  net/rxrpc/call_event.c                             |  12 +-
>  net/rxrpc/call_object.c                            |   1 +
>  net/rxrpc/conn_event.c                             |  10 +-
>  net/rxrpc/input.c                                  | 115 +++++++++++++++---
>  net/rxrpc/output.c                                 |   8 +-
>  net/rxrpc/proc.c                                   |   2 +-
>  net/rxrpc/rxkad.c                                  |   4 +-
>  net/tipc/bearer.c                                  |   6 +
>  net/unix/garbage.c                                 |  11 ++
>  net/wireless/scan.c                                |  63 +++++++++-
>  sound/soc/amd/acp-config.c                         |  15 +--
>  sound/usb/quirks.c                                 |   6 +
>  tools/perf/tests/shell/script.sh                   |  73 ++++++++++++
>  tools/perf/util/evlist.c                           |   9 +-
>  tools/testing/selftests/core/close_range_test.c    |   1 +
>  tools/testing/selftests/net/big_tcp.sh             |   4 +-
>  tools/testing/selftests/net/cmsg_ipv6.sh           |   4 +-
>  tools/testing/selftests/net/pmtu.sh                |  52 +++++----
>  tools/testing/selftests/net/udpgro_fwd.sh          |  14 ++-
>  tools/testing/selftests/net/udpgso_bench_rx.c      |   2 +-
>  tools/testing/selftests/net/unicast_extensions.sh  |  93 +++++++--------
>  160 files changed, 1538 insertions(+), 715 deletions(-)
>
>
>

