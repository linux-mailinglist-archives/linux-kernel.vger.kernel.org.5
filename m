Return-Path: <linux-kernel+bounces-62530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B833F852266
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 00:24:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA0F91C2311C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 23:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E3AF4F88D;
	Mon, 12 Feb 2024 23:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f4XO+q5Q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0DBE50A66;
	Mon, 12 Feb 2024 23:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707780252; cv=none; b=cswKuf//UE5PcSHc+YXJOCIax0gPSENSvldzbdrp9uGrV4da75WB6FPBgHGzlZQTPLmIHIDKo4ffvctYYi7EwVQyOTewnDCS7Av/XA59DL8DfaUxgTdrxNlhRJpXoBYv9o4gX4fJz//7BGKkcQ8k4tzy24p6dfEqEaZJUe3efFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707780252; c=relaxed/simple;
	bh=rg+nB+xbUpk8eNsf81ws5afCJXtegVecuitVQqWzda8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PDqbSZ0v5iv5Yh34S60mr88YVmTUQi2X3W/u1wYh8ks8tGAaFmnPVUnAcuMbRRaaH5zqtr2fBvUJG3O7CvvL4jz3WptD+80/nvRG+aH5H4Er7Rue0r5mOn6T4dy7xXqtsXAIUHYVMAF08194GCpJzzqMGP3n2RlnfTBPsVPi5Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f4XO+q5Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45E54C43394;
	Mon, 12 Feb 2024 23:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707780252;
	bh=rg+nB+xbUpk8eNsf81ws5afCJXtegVecuitVQqWzda8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=f4XO+q5QeWcrn8sC/ST4oigu65Ln/ll/yn31lHtvnOWzl5xkxMDzOjKENl3tduTRQ
	 lu3PzC5fC4nDl5uic0kR5aWRDgYHG7wOqS8ClflRMrtE5mCQuaX/QNZmFcRWhYWpqR
	 Du59yQTWkyGpo3RCgBhEk0ajqKelMa9GcrmD5hg7AGNu31EO1lAPqJuSMRnzvls5PI
	 juw+otDR3rBPDuTY2K6RDuf8cMUd1aAITLL8Dwds9AihJT0QZ/g00hOt+R5gsRHIn0
	 wOcEvGebG2yYRXBiqNWXVxKGXSWiG1qhhPf8tvhV8fmE5iIUEFeKDCbXJp23SpGPed
	 ruNsNQoGjhHMQ==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5116bf4dcf4so4500563e87.0;
        Mon, 12 Feb 2024 15:24:12 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX2xOEAUD0jUky4pofpa5cwRKMdpPYPNVxXW5irraVSqUIDdH1AleRN5JdSD25qAj3Bgl4ifYK5zYZwgX17It5XunKpYRrIuEr2ZV3XkflUTcD/gZsoADngZw6mCcFFxm/7jeNsXHsvhw==
X-Gm-Message-State: AOJu0Yw00/dSckm1FWDJOCeAVtnV4H78G3lyhQW1r7etfjgg1FrL9MRa
	j015OpwfO2W3DFHwPRSOgtiSb+vTp91eHV04Cs2Elfvds7h+/KanSB11G4Hji1zKAgSFvkPY6bN
	qAq6zyU87HnpylklRdAogNQGueuo=
X-Google-Smtp-Source: AGHT+IGmqleed24pli951JAX9NV0TZ8rB5kQM1ybn8JCYc+K0DbZ3tDbqfTVyGVVw5xQimEwGBQi8OIyAyPHcC13Nq4=
X-Received: by 2002:a05:6512:2092:b0:511:2e7c:768f with SMTP id
 t18-20020a056512209200b005112e7c768fmr5266869lfr.46.1707780250287; Mon, 12
 Feb 2024 15:24:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208085556.2412922-1-linan666@huaweicloud.com>
In-Reply-To: <20240208085556.2412922-1-linan666@huaweicloud.com>
From: Song Liu <song@kernel.org>
Date: Mon, 12 Feb 2024 15:23:59 -0800
X-Gmail-Original-Message-ID: <CAPhsuW4_CX8tiRrZFMxUXK+E-=izTncqmwvrqX-pXG1wOLs=qg@mail.gmail.com>
Message-ID: <CAPhsuW4_CX8tiRrZFMxUXK+E-=izTncqmwvrqX-pXG1wOLs=qg@mail.gmail.com>
Subject: Re: [PATCH] md: fix kmemleak of rdev->serial
To: linan666@huaweicloud.com
Cc: gqjiang@suse.com, neilb@suse.com, linux-raid@vger.kernel.org, 
	linux-kernel@vger.kernel.org, yukuai3@huawei.com, yi.zhang@huawei.com, 
	houtao1@huawei.com, yangerkun@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 8, 2024 at 1:00=E2=80=AFAM <linan666@huaweicloud.com> wrote:
>
> From: Li Nan <linan122@huawei.com>
>
> If kobject_add() is fail in bind_rdev_to_array(), 'rdev->serial' will be
> alloc not be freed, and kmemleak occurs.
>
> unreferenced object 0xffff88815a350000 (size 49152):
>   comm "mdadm", pid 789, jiffies 4294716910
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace (crc f773277a):
>     [<0000000058b0a453>] kmemleak_alloc+0x61/0xe0
>     [<00000000366adf14>] __kmalloc_large_node+0x15e/0x270
>     [<000000002e82961b>] __kmalloc_node.cold+0x11/0x7f
>     [<00000000f206d60a>] kvmalloc_node+0x74/0x150
>     [<0000000034bf3363>] rdev_init_serial+0x67/0x170
>     [<0000000010e08fe9>] mddev_create_serial_pool+0x62/0x220
>     [<00000000c3837bf0>] bind_rdev_to_array+0x2af/0x630
>     [<0000000073c28560>] md_add_new_disk+0x400/0x9f0
>     [<00000000770e30ff>] md_ioctl+0x15bf/0x1c10
>     [<000000006cfab718>] blkdev_ioctl+0x191/0x3f0
>     [<0000000085086a11>] vfs_ioctl+0x22/0x60
>     [<0000000018b656fe>] __x64_sys_ioctl+0xba/0xe0
>     [<00000000e54e675e>] do_syscall_64+0x71/0x150
>     [<000000008b0ad622>] entry_SYSCALL_64_after_hwframe+0x6c/0x74
>
> Fixes: 963c555e75b0 ("md: introduce mddev_create/destroy_wb_pool for the =
change of member device")
> Signed-off-by: Li Nan <linan122@huawei.com>

LGTM. Applied to md-6.9.

Thanks,
Song

