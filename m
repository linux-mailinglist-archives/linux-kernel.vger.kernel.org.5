Return-Path: <linux-kernel+bounces-91390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9C588710E1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 00:05:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A87321C22456
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 23:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD13F7C0BA;
	Mon,  4 Mar 2024 23:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YTmEdK4N"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC5D7C0B5;
	Mon,  4 Mar 2024 23:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709593549; cv=none; b=uTnhSQ6P5Fzo9EFdKDjxcMqb4qykmZjt78x2JChXxhqpsJ2LGN2kJzeZDU5v78+pSu+awXedWuTSRcTaKiqOJXeqWgCxztk2QJev3cbF25ndKVXvfD+MVm6mOByF/mkACq4UEZn78G4k8BCFD2ggRgyaRsASMhf0+aFYAoPqnkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709593549; c=relaxed/simple;
	bh=pRGVP07ilnJmLF4KLslJUTm/7cLvt0pOTlDjP9yALDc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aFaqQYvKeDaAVNIjXKwb/1K9x5VvuozSW5Mt6Gkh7haVXIfqGE4q9y7rBtgke0SyPGuMeyXR5dWTfF8rY3cEEO/tgLbzDRg3PCYLxKzcHJHFt298jL7Nk20L+SuFS47cXujWzJHcf6ublA8J+wMtO4bygtzvuKJjlVGfzEQTA40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YTmEdK4N; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-29ae4c7da02so3271714a91.2;
        Mon, 04 Mar 2024 15:05:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709593546; x=1710198346; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=94VO5VSfBbhMqWKVT1INERLTOk6iNbs+9HtRzlUVIOQ=;
        b=YTmEdK4NgyX9aHpcR7OVHcLZEBRgP2OyyqvEHlVHCTP0DvESBgw31wqSnDpNWUMQ3B
         iWSUSWgmRz5Dm3eSs8iIeoBDWwyPnRlZiDEjMGpsgzKlIWqnsZw6xb4kM/4WXBOtsjhG
         /govEfrv1SRiDdFgVLyOy3kH1KIeAhG57TxYJQq6S0o0CBobj2YhR2SIOeW47jY9R63L
         4y3asfVsmW123ecufxuoPhYX4stK+cJjFjlsrbMjPFqVlGGAEx6lNtm/OOSBNNwyaWmd
         +Dw6UyRLg4UKZXL2q47yE3uaGkzJ/WIAXOsDe4Ck5Y/sBiY7aVOo9swD+WpZ22IL0zX8
         ftYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709593546; x=1710198346;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=94VO5VSfBbhMqWKVT1INERLTOk6iNbs+9HtRzlUVIOQ=;
        b=sq6ri4Uee4YDKWndLOjEbXe9LNmz2cNksLwtfVtzfyro9U0CdXJ5eUCyO2MYO2ZAfy
         ozE8g00Y0oDMYwAiMCh1OlcB00TUOvKl/4TKqA4+R2x4DH+fCsbcPXpfbuhaixEGq+cN
         eUJqpuGyypTtfUbgA3cQrRfv0FYtomdM1RmUEPJaccTWt9dDnMKhJ/F+UzF5PeL1FyxW
         yT8Ax/lniSp7ck+JGvvUlcI0Mv7mUkcydps2mcBa0eBSoqezuW40VXiQgTJ3I/jT4OnS
         cjeJ1XPd6Hn5VpbxaBJZ/Sm1U+TOgWTeN+B7NIe4lCA5drZvjXfDrqLJBm7sYH3kWQ1E
         7HZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVSSEWnAkU7+o+yc2hlFMYdDleSYjKnJOrj5d9gcEipGzSO+ZPjuTDSbYxw3v4NvMPVzZDrRT+GELK1FA0NmDtMn/26OYnj2f5urucuM/L77J5Qj9RU+Nkv68jeZDA1BLouhIpQ
X-Gm-Message-State: AOJu0YwbouSl0nSaGrvM/kYKWOVZV1mexH0eRDrq0T0J7x0NTj9AL2fy
	yrSQNyppkZx2UqaAuVYUpzTrc/napmMBNfBB9uEEa0EPlNXfFAVWw8kpJnEG+wPmwPwz+Gb/h9F
	wgLNVBjRaxfxCp4o+I3wn3Gel5pc=
X-Google-Smtp-Source: AGHT+IFU6wGe8LUboiIVob1DUkFoAn3TgjaROsKBSFUZVlNuZiB5QzcXusrtlcs57qHCjDZWoev1aYGdv4D1uqjXe4Q=
X-Received: by 2002:a17:90a:d90e:b0:29a:f195:70d9 with SMTP id
 c14-20020a17090ad90e00b0029af19570d9mr7530089pjv.8.1709593546246; Mon, 04 Mar
 2024 15:05:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240304211551.833500257@linuxfoundation.org> <20240304224813.73380-1-sj@kernel.org>
In-Reply-To: <20240304224813.73380-1-sj@kernel.org>
From: Luna Jernberg <droidbittin@gmail.com>
Date: Tue, 5 Mar 2024 00:05:33 +0100
Message-ID: <CADo9pHi0az-CL_hktmpCVcuoiDaUJn2U208=TwAvBM6YQhfFqw@mail.gmail.com>
Subject: Re: [PATCH 6.7 000/162] 6.7.9-rc1 review
To: SeongJae Park <sj@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org, 
	patches@lists.linux.dev, linux-kernel@vger.kernel.org, 
	torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net, 
	shuah@kernel.org, patches@kernelci.org, lkft-triage@lists.linaro.org, 
	pavel@denx.de, jonathanh@nvidia.com, f.fainelli@gmail.com, 
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de, 
	conor@kernel.org, allen.lkml@gmail.com, damon@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Den m=C3=A5n 4 mars 2024 kl 23:48 skrev SeongJae Park <sj@kernel.org>:
>
> Hello,
>
> On Mon,  4 Mar 2024 21:21:05 +0000 Greg Kroah-Hartman <gregkh@linuxfounda=
tion.org> wrote:
>
> > This is the start of the stable review cycle for the 6.7.9 release.
> > There are 162 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Wed, 06 Mar 2024 21:15:26 +0000.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >       https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.7.9-rc1.gz
> > or in the git tree and branch at:
> >       git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.7.y
> > and the diffstat can be found below.
>
> This rc kernel passes DAMON functionality test[1] on my test machine.
> Attaching the test results summary below.  Please note that I retrieved t=
he
> kernel from linux-stable-rc tree[2].
>
> Tested-by: SeongJae Park <sj@kernel.org>
>
> [1] https://github.com/awslabs/damon-tests/tree/next/corr
> [2] a8588364073d ("Linux 6.7.9-rc1")
>
> Thanks,
> SJ
>
> [...]
>
> ---
>
> ok 1 selftests: damon: debugfs_attrs.sh
> ok 2 selftests: damon: debugfs_schemes.sh
> ok 3 selftests: damon: debugfs_target_ids.sh
> ok 4 selftests: damon: debugfs_empty_targets.sh
> ok 5 selftests: damon: debugfs_huge_count_read_write.sh
> ok 6 selftests: damon: debugfs_duplicate_context_creation.sh
> ok 7 selftests: damon: debugfs_rm_non_contexts.sh
> ok 8 selftests: damon: sysfs.sh
> ok 9 selftests: damon: sysfs_update_removed_scheme_dir.sh
> ok 10 selftests: damon: reclaim.sh
> ok 11 selftests: damon: lru_sort.sh
> ok 1 selftests: damon-tests: kunit.sh
> ok 2 selftests: damon-tests: huge_count_read_write.sh
> ok 3 selftests: damon-tests: buffer_overflow.sh
> ok 4 selftests: damon-tests: rm_contexts.sh
> ok 5 selftests: damon-tests: record_null_deref.sh
> ok 6 selftests: damon-tests: dbgfs_target_ids_read_before_terminate_race.=
sh
> ok 7 selftests: damon-tests: dbgfs_target_ids_pid_leak.sh
> ok 8 selftests: damon-tests: damo_tests.sh
> ok 9 selftests: damon-tests: masim-record.sh
> ok 10 selftests: damon-tests: build_i386.sh
> ok 11 selftests: damon-tests: build_arm64.sh
> ok 12 selftests: damon-tests: build_m68k.sh
> ok 13 selftests: damon-tests: build_i386_idle_flag.sh
> ok 14 selftests: damon-tests: build_i386_highpte.sh
> ok 15 selftests: damon-tests: build_nomemcg.sh
>  [33m
>  [92mPASS [39m
>

Works fine on my Arch Linux desktop with model name    : AMD Ryzen 5
5600 6-Core Processor
after the Arch Linux manual intervention for new mkinitcpio settings
and version in Arch

Tested by: Luna Jernberg <droidbittin@gmail.com>

