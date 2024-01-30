Return-Path: <linux-kernel+bounces-45255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5E15842DAD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 21:21:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 119DAB233C1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 20:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8119C71B5B;
	Tue, 30 Jan 2024 20:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Box42nac"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953AC71B4C;
	Tue, 30 Jan 2024 20:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706646091; cv=none; b=ezZabuNz1aFE4OffxIHbD9od7UGvj92gTcHzYuTzHQcAcN7sulM34npiYka7ABeYhiUN5Ph6Qax57EPzKoWIgtDpfyuWoIMH8qWvJNIEWjevXeqBolUrH21l/NEjuSacqVVUXqf0CrtizZqyrY4/eaSTrxmo6AMaYcLcbQB6j2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706646091; c=relaxed/simple;
	bh=K1dqR4VR58Lvh/54G+9Wzu18PKLLsr0ACThJ+ZITAuE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OCHwwovnntTCRxayMU2hmt+ATZKHGjsHs8DPEbsPtkXXjp3LmyvKo3nv3bqE5sVEgx0AQQxd9s8lld1Vpkte/dnca5Wnmtz0Rw1HznJrV2CX2gOplaPaEq6n52ioL4ZynmjKtHsJ9FXhVPlgfCOsdDnpj8kWm6cNfsd4ExiVEGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Box42nac; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21F41C433C7;
	Tue, 30 Jan 2024 20:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706646091;
	bh=K1dqR4VR58Lvh/54G+9Wzu18PKLLsr0ACThJ+ZITAuE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Box42nacqJdXum86Z1u5OSSAv/IWNwJ2icIEoz/9i9KYIZvWaexZtcnvQmSyzWt7B
	 m9xMLQBUrsQm1f/kbw7xfrzjwRQxXJsZMZvR1/AgA321SOPe9eBdkYjzhms4S6R/d/
	 hkjGgK4obeZhQ2IPmuQIvgNB21m9Qxbtj+SK4cq7nhe/aF824OMRVPuYSXgh4huVFt
	 SPKv4OizdRCLoojT+faLul06649fptrj9FFPA7DaHmadpQLpyJ4ZFSyGnQud68eEev
	 zytfXhHhpjOpIR2Gs4dpbb+bPNWKSxhTv5DBAh7Qo92oBlLbC3jVJDPYauMHOLaibO
	 BhjoqorDKZvKg==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5100cb238bcso8002022e87.3;
        Tue, 30 Jan 2024 12:21:31 -0800 (PST)
X-Gm-Message-State: AOJu0YyxoeyikDecGhWTYrWannpZMML6ZrN8JV3poA2Fbg7FJdrNPL6+
	mMU5waLVt6XoUIll/yfpx/Ei2EQoDxBkVIMgAB+ZVbalvSlPCtouKHGzlYC4seZ4aE82NnSgyYL
	EaKVW6ulLXgiAi748phdAqrfNs4U=
X-Google-Smtp-Source: AGHT+IGIzSOPTAgcoO+x3nc9NOI8WGDTHOwXIPN+/lnKknFfbutL9Bs2LEKaBRqOFvD9QJOYTyerSYTK8fmlH/try2U=
X-Received: by 2002:a05:6512:2256:b0:510:28a9:9b27 with SMTP id
 i22-20020a056512225600b0051028a99b27mr7493631lfu.66.1706646089208; Tue, 30
 Jan 2024 12:21:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZbMnZnvyIyoWeIro@fisica.ufpr.br> <20240126154610.24755-1-dan@danm.net>
 <20240130172524.0000417b@linux.intel.com>
In-Reply-To: <20240130172524.0000417b@linux.intel.com>
From: Song Liu <song@kernel.org>
Date: Tue, 30 Jan 2024 12:21:16 -0800
X-Gmail-Original-Message-ID: <CAPhsuW7jtQP+qsWYE4Nt3bA7P4SvUjGr9L0orrPY5rYWFW=jPw@mail.gmail.com>
Message-ID: <CAPhsuW7jtQP+qsWYE4Nt3bA7P4SvUjGr9L0orrPY5rYWFW=jPw@mail.gmail.com>
Subject: Re: [REGRESSION] 6.7.1: md: raid5 hang and unresponsive system;
 successfully bisected
To: Blazej Kucman <blazej.kucman@linux.intel.com>
Cc: Dan Moulding <dan@danm.net>, carlos@fisica.ufpr.br, gregkh@linuxfoundation.org, 
	junxiao.bi@oracle.com, linux-kernel@vger.kernel.org, 
	linux-raid@vger.kernel.org, regressions@lists.linux.dev, 
	stable@vger.kernel.org, yukuai1@huaweicloud.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Blazej,

On Tue, Jan 30, 2024 at 8:27=E2=80=AFAM Blazej Kucman
<blazej.kucman@linux.intel.com> wrote:
>
> Hi,
>
> On Fri, 26 Jan 2024 08:46:10 -0700
> Dan Moulding <dan@danm.net> wrote:
> >
> > That's a good suggestion, so I switched it to use XFS. It can still
> > reproduce the hang. Sounds like this is probably a different problem
> > than the known ext4 one.
> >
>
> Our daily tests directed at mdadm/md also detected a problem with
> identical symptoms as described in the thread.
>
> Issue detected with IMSM metadata but it also reproduces with native
> metadata.
> NVMe disks under VMD controller were used.
>
> Scenario:
> 1. Create raid10:
> mdadm --create /dev/md/r10d4s128-15_A --level=3D10 --chunk=3D128
> --raid-devices=3D4 /dev/nvme6n1 /dev/nvme2n1 /dev/nvme3n1 /dev/nvme0n1
> --size=3D7864320 --run
> 2. Create FS
> mkfs.ext4 /dev/md/r10d4s128-15_A
> 3. Set faulty one raid member:
> mdadm --set-faulty /dev/md/r10d4s128-15_A /dev/nvme3n1
> 4. Stop raid devies:
> mdadm -Ss

Thanks for the report. I can reproduce the issue locally.

The revert [1] cannot fix this one, because the revert is for raid5 (and
the repro is on raid10). I will look into this.

Thanks again!

Song


[1] https://lore.kernel.org/linux-raid/20240125082131.788600-1-song@kernel.=
org/


>
> Expected result:
> The raid stops without kernel hangs and errors.
>
> Actual result:
> command "mdadm -Ss" hangs,
> hung_task occurs in OS.
>
> [   62.770472] md: resync of RAID array md127
> [  140.893329] md: md127: resync done.
> [  204.100490] md/raid10:md127: Disk failure on nvme3n1, disabling
> device. md/raid10:md127: Operation continuing on 3 devices.
> [  244.625393] INFO: task kworker/48:1:755 blocked for more than 30
> seconds. [  244.632294]       Tainted: G S
> 6.8.0-rc1-20240129.intel.13479453+ #1 [  244.640157] "echo 0 >
> /proc/sys/kernel/hung_task_timeout_secs" disables this message. [
> 244.648105] task:kworker/48:1    state:D stack:14592 pid:755   tgid:755
>   ppid:2      flags:0x00004000 [  244.657552] Workqueue: md_misc
> md_start_sync [md_mod] [  244.662688] Call Trace: [  244.665176]  <TASK>
> [  244.667316]  __schedule+0x2f0/0x9c0
> [  244.670868]  ? sched_clock+0x10/0x20
> [  244.674510]  schedule+0x28/0x90
> [  244.677703]  mddev_suspend+0x11d/0x1e0 [md_mod]
> [  244.682313]  ? __update_idle_core+0x29/0xc0
> [  244.686574]  ? swake_up_all+0xe0/0xe0
> [  244.690302]  md_start_sync+0x3c/0x280 [md_mod]
> [  244.694825]  process_scheduled_works+0x87/0x320
> [  244.699427]  worker_thread+0x147/0x2a0
> [  244.703237]  ? rescuer_thread+0x2d0/0x2d0
> [  244.707313]  kthread+0xe5/0x120
> [  244.710504]  ? kthread_complete_and_exit+0x20/0x20
> [  244.715370]  ret_from_fork+0x31/0x40
> [  244.719007]  ? kthread_complete_and_exit+0x20/0x20
> [  244.723879]  ret_from_fork_asm+0x11/0x20
> [  244.727872]  </TASK>
> [  244.730117] INFO: task mdadm:8457 blocked for more than 30 seconds.
> [  244.736486]       Tainted: G S
> 6.8.0-rc1-20240129.intel.13479453+ #1 [  244.744345] "echo 0 >
> /proc/sys/kernel/hung_task_timeout_secs" disables this message. [
> 244.752293] task:mdadm           state:D stack:13512 pid:8457
> tgid:8457  ppid:8276   flags:0x00000000 [  244.761736] Call Trace: [
> 244.764241]  <TASK> [  244.766389]  __schedule+0x2f0/0x9c0
> [  244.773224]  schedule+0x28/0x90
> [  244.779690]  stop_sync_thread+0xfa/0x170 [md_mod]
> [  244.787737]  ? swake_up_all+0xe0/0xe0
> [  244.794705]  do_md_stop+0x51/0x4c0 [md_mod]
> [  244.802166]  md_ioctl+0x59d/0x10a0 [md_mod]
> [  244.809567]  blkdev_ioctl+0x1bb/0x270
> [  244.816417]  __x64_sys_ioctl+0x7a/0xb0
> [  244.823720]  do_syscall_64+0x4e/0x110
> [  244.830481]  entry_SYSCALL_64_after_hwframe+0x63/0x6b
> [  244.838700] RIP: 0033:0x7f2c540c97cb
> [  244.845457] RSP: 002b:00007fff4ad6a8f8 EFLAGS: 00000246 ORIG_RAX:
> 0000000000000010 [  244.856265] RAX: ffffffffffffffda RBX:
> 0000000000000003 RCX: 00007f2c540c97cb [  244.866659] RDX:
> 0000000000000000 RSI: 0000000000000932 RDI: 0000000000000003 [
> 244.877031] RBP: 0000000000000019 R08: 0000000000200000 R09:
> 00007fff4ad6a4c5 [  244.887382] R10: 0000000000000000 R11:
> 0000000000000246 R12: 00007fff4ad6a9c0 [  244.897723] R13:
> 00007fff4ad6a9a0 R14: 000055724d0990e0 R15: 000055724efaa780 [
> 244.908018]  </TASK> [  275.345375] INFO: task kworker/48:1:755 blocked
> for more than 60 seconds. [  275.355363]       Tainted: G S
>     6.8.0-rc1-20240129.intel.13479453+ #1 [  275.366306] "echo 0 >
> /proc/sys/kernel/hung_task_timeout_secs" disables this message. [
> 275.377334] task:kworker/48:1    state:D stack:14592 pid:755   tgid:755
>   ppid:2      flags:0x00004000 [  275.389863] Workqueue: md_misc
> md_start_sync [md_mod] [  275.398102] Call Trace: [  275.403673]  <TASK>
>
>
> Also reproduces with XFS FS, does not reproduce when there is no FS on
> RAID.
>
> Repository used for testing:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/
> Branch: master
>
> Last working build: kernel branch HEAD: acc657692aed ("keys, dns: Fix
> size check of V1 server-list header")
>
> I see one merge commit touching md after the above one:
> 01d550f0fcc0 ("Merge tag 'for-6.8/block-2024-01-08' of
> git://git.kernel.dk/linux")
>
> I hope these additional logs will help find the cause.
>
> Thanks,
> Blazej
>

