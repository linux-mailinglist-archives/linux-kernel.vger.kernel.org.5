Return-Path: <linux-kernel+bounces-45585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 073528432B8
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 02:27:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 993FF1F2742F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 01:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A897417F8;
	Wed, 31 Jan 2024 01:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rP3u6tZI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBED9EA4;
	Wed, 31 Jan 2024 01:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706664420; cv=none; b=FxvCQfC3LJqXAfdRlA/qaCJ1pzIiI4EEsUSqGQ6zCoMz++fGTZfwhZTDcI6Ip1QTtYwNTemJPi/AZ2q+0b8UzmwWNwp4trXuERlG8xftup71NpjWVdji4IhHG5/SveWXl+GgXJwUY2TGOOIeZve8CYYZGy+g2cAIsfBLDdPTP2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706664420; c=relaxed/simple;
	bh=jETDXb67b9fXT9d1zEIke0A7APUk2FwU3Q90DBkleP4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MLFUwfq2EonmVrBH42z09aiaurfAoOwUaG4E+HCn3VdUs5Kzp5/0aZgjaPdM8sDW1JGKxvknQYANw3kOc+FYo3ghH1uUjZI69mp0PUCfDGVVCrHqM8aCZI25pgJfDwYjk8IT+FNzv1V6pgPafpFKmYLaMlCQ5VO1PTSTAOwu2L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rP3u6tZI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EF57C433B1;
	Wed, 31 Jan 2024 01:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706664419;
	bh=jETDXb67b9fXT9d1zEIke0A7APUk2FwU3Q90DBkleP4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=rP3u6tZIDEYzidQ4WX+aeqHhYiotA0VKTq3WBD9MMFOXUd9Y0FlRokOCBGJKEradu
	 Q5PIKrMdz7crm5h20KYwirSXfQe2ZnkgahNHsn75QLU5pUG//T5xqGL9LUsH98Er8N
	 N9Af12Fp/xiV0acbJXb77WGkjpoAlF3FxlokcahRVaq150KXhZ804VID9+W66KYogx
	 6YTZ/QqP8SQ70kIr9YE0qUaShXRG8j+s27rFYRWow8NGHXUFdoJeCtwN5iU79gWZhh
	 JS81PViUW5FkRPiueTR9SoZn9lU6dJnRr/HVryriJ1fjr/R87EEo9zH9bazx2nG32Z
	 887qOPAbLx/Lg==
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2cf4d2175b2so44839951fa.0;
        Tue, 30 Jan 2024 17:26:59 -0800 (PST)
X-Gm-Message-State: AOJu0Ywd7fQDP4riQC9Mjm1bYbjpmijW1vhkr2rjrx1F8I8Si78ZytK9
	Zj2EQCjiQ/tfcFOCnfzaIVGLi6aigan80+mKZF17zc0m+QdeqftHmVpymd2llICXlrCq3ep36ks
	ivMFLyY23AQyQiWsBWqx9YS83gCY=
X-Google-Smtp-Source: AGHT+IG+5ZcVUPSIuoD++nF0u0CCm+eVM+wlnavJV596sCcwTQkB3Ou7hw9YpnqV5nR9T+9q9VC+1pBNJsn5G/eIwNA=
X-Received: by 2002:a2e:b058:0:b0:2d0:5f2e:5b3d with SMTP id
 d24-20020a2eb058000000b002d05f2e5b3dmr123274ljl.11.1706664417626; Tue, 30 Jan
 2024 17:26:57 -0800 (PST)
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
Date: Tue, 30 Jan 2024 17:26:45 -0800
X-Gmail-Original-Message-ID: <CAPhsuW5S7H-P9NiBxk=EVrzYSC6esBxiEg-pR=QMeASWh_S5GA@mail.gmail.com>
Message-ID: <CAPhsuW5S7H-P9NiBxk=EVrzYSC6esBxiEg-pR=QMeASWh_S5GA@mail.gmail.com>
Subject: Re: [REGRESSION] 6.7.1: md: raid5 hang and unresponsive system;
 successfully bisected
To: Blazej Kucman <blazej.kucman@linux.intel.com>, Yu Kuai <yukuai1@huaweicloud.com>
Cc: Dan Moulding <dan@danm.net>, carlos@fisica.ufpr.br, gregkh@linuxfoundation.org, 
	junxiao.bi@oracle.com, linux-kernel@vger.kernel.org, 
	linux-raid@vger.kernel.org, regressions@lists.linux.dev, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Update my findings so far.

On Tue, Jan 30, 2024 at 8:27=E2=80=AFAM Blazej Kucman
<blazej.kucman@linux.intel.com> wrote:
[...]
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

With a failed drive, md_thread calls md_check_recovery() and kicks
off mddev->sync_work, which is =EF=BB=BF=EF=BB=BFmd_start_sync().
md_check_recovery() also sets MD_RECOVERY_RUNNING.

md_start_sync() calls mddev_suspend() and waits for
mddev->active_io to become zero.

> 4. Stop raid devies:
> mdadm -Ss

This command calls stop_sync_thread() and waits for
MD_RECOVERY_RUNNING to be cleared.

Given we need a working file system to reproduce the issue, I
suspect the problem comes from active_io.

Yu Kuai, I guess we missed this case in the recent refactoring.
I don't have a good idea to fix this. Please also take a look into
this.

Thanks,
Song

