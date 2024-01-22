Return-Path: <linux-kernel+bounces-33008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10731836323
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 13:24:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42D341C22928
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 12:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 096D23BB37;
	Mon, 22 Jan 2024 12:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TRNzik+5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6743B290;
	Mon, 22 Jan 2024 12:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705926144; cv=none; b=siiqDzHTycOhBWxcxQqQbJb5LonlPZB5XdNBHfSS9NzTi2wWPnTUKGd0hyDUWCLRRA49pLmVKs4bcT+QhEsfdYl3I0++CjYKJ+RA6WPKNU4BfaQpAFkfadUyoM4WuQ4SIDjkFfJp/zlVpctZ2RcTsRVQM8QiUatnpM530VgXdHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705926144; c=relaxed/simple;
	bh=3FFt8SSpVUT/GHTKltUwl1wgL2n2OngX2hrrhAwjZps=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MMnNCf+8jqj63e+Z1FfTbJajfWe3/g5sCe5Yz5Uh7yUbSv717OVU7WFHkmP3+yH9sFD0jaIr8ceXOzXkqyBU28rT2r1fmtEWtg4iD2vwJsVUopZqe0AwRhquJJPbg2i+2Y1ylnWJuY60uaYMnuhtKNLQ2wfk48DG/ixB7OTVHpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TRNzik+5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C534CC43390;
	Mon, 22 Jan 2024 12:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705926143;
	bh=3FFt8SSpVUT/GHTKltUwl1wgL2n2OngX2hrrhAwjZps=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=TRNzik+5Fsp1kUhZwA4nbRBPfN00Jip/FSBBp4lQKE0ud0pSjazwIARwe19RTfMtk
	 KuT3QGmeZGE6M5WmT6zmG9UJJz2c25BWULeXdLLXt7/WxRiZAiPDx6wtPv95I9+ZwR
	 ctREPM14caIVHwDDD0YFy+ma83qVvlGpVHqCkwki48r099J05ngNauCh8ZiImnVxID
	 qPhPAHWfjBh8vIHrYXn5RqunY0P+dXzQk8UC5IZPzRBzHuGjOVqM3xzZLh9w9jG/47
	 XEpLYfyu+MWaOV9CZPgJADv4nXksOwP8QFYZq7RMTUA+91SdyidR1diDRfmiY6+cyG
	 fEvtO3xu8lx4g==
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6e0e99adb3bso701435a34.3;
        Mon, 22 Jan 2024 04:22:23 -0800 (PST)
X-Gm-Message-State: AOJu0Yxr9stM1AVxgqFohSH+EWiNB5mRJnJguuf1lM4cLRe10nI+MYuJ
	m1juGR99HX2cMLjCu+1+spf7ydzDHuqC/V87AlO3YiySv+UdhX3GQrF+rEGLqEFVIbyi1o0gYlC
	f2Ioy/jR9uohLPu9759yq66Kjf9k=
X-Google-Smtp-Source: AGHT+IFnNAe3IguRgQdsiUA9LkC30HR7r3lHg+/oSBbAnsi0vW7h+GN1Qy+y+Ku72f6/QvbQpW99t/9BtlrE06lkX44=
X-Received: by 2002:a05:6870:96aa:b0:205:fd5a:9ca0 with SMTP id
 o42-20020a05687096aa00b00205fd5a9ca0mr1957281oaq.73.1705926143200; Mon, 22
 Jan 2024 04:22:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <be1abcda-4cf0-4441-9a27-831eaef28f2e@linux.alibaba.com>
In-Reply-To: <be1abcda-4cf0-4441-9a27-831eaef28f2e@linux.alibaba.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Mon, 22 Jan 2024 21:21:46 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQQLP2jmy=mwvi9euFM=YOtKBDOJWQcO4Pr_J=Gtu5MFA@mail.gmail.com>
Message-ID: <CAK7LNAQQLP2jmy=mwvi9euFM=YOtKBDOJWQcO4Pr_J=Gtu5MFA@mail.gmail.com>
Subject: Re: [MAYBE REGRESSION] kbuild time of kernel compiling
To: Jingbo Xu <jefflexu@linux.alibaba.com>
Cc: linux-kbuild@vger.kernel.org, nathan@kernel.org, ndesaulniers@google.com, 
	nicolas@fjasle.eu, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 5:32=E2=80=AFPM Jingbo Xu <jefflexu@linux.alibaba.c=
om> wrote:
>
> Hi,
>
> I noticed a regression of kbuild time in v6.7, especially when running
> `make` command when all images have already been compiled.  In v6.6 it
> takes ~3s, while in v6.7 it takes ~18s.
>
> I'm not sure if it's a known issue, or an extra action configurable with
> a "CONFIG_XX" option.
>
>
> Following is the kbuild time in v6.6 versus v7.7, with
> arch/x86/configs/x86_64_defconfig used here:
>
>
> v6.6
> ```
> make clean
> make olddefconfig
>
> # first full compiling
> $time make bzImage -j128 -s
>
> real    1m9.896s
> user    36m56.153s
> sys     4m21.748s
>
> # second time with image already compiled
> $time make bzImage -j128 -s
>
> real    0m2.776s
> user    0m13.823s
> sys     0m3.936s
> ```
>
>
> v6.7
> ```
> make clean
> make olddefconfig
>
> # first full compiling
> $time make bzImage -j128 -s
>
> real    1m22.865s
> user    37m25.977s
> sys     4m22.094s
>
> # second time with image already compiled
> $time make bzImage -j128 -s
>
> real    0m18.209s
> user    0m29.243s
> sys     0m4.330s
> ```
>
>
> I tried to bisect, while commit d4e175f2c460 ("Merge tag 'vfs-6.7.super'
> of gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs") is identified
> as the first bad commit, which is obviously wrong.  As I'm not familiar
> with the structure of the merge commit, the further investigation has
> not been made yet.




If you use olddefconfig, git-bisect will not produce the correct result.

'make olddefconfig' updates the existing .config.
The resulting .config depends on what you had
before running 'make olddefconfig'.

You need to use a deterministic target (e.g. defconfig)
during the git-bisect.





>
>
> Besides, it seems that it will take most of the time before "CALL
> scripts/checksyscalls.sh" is printed (with "INSTALL libsubcmd_headers"
> has already printed).
>
> $time make bzImage -j128
>   DESCEND objtool
>   INSTALL libsubcmd_headers
>
>   CALL    scripts/checksyscalls.sh
>   BUILD   arch/x86/boot/bzImage
> Kernel: arch/x86/boot/bzImage is ready  (#437)
>
> --
> Thanks,
> Jingbo
>


--
Best Regards
Masahiro Yamada

