Return-Path: <linux-kernel+bounces-25210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF38A82CA60
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 08:13:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67CF4284851
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 07:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 851A115487;
	Sat, 13 Jan 2024 07:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K4Rms/iO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC95612E56;
	Sat, 13 Jan 2024 07:12:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A287BC43390;
	Sat, 13 Jan 2024 07:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705129975;
	bh=u43SEmtph5VFO6x6zXMUx3p5jya6o8jYGfQvOfJEvqQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=K4Rms/iOd3tzgUM8PKdv/kg18GIxz2wk8ryMwt9wmfSlZK/oulu4qL7vwIH0gADwg
	 61GwruqMiu620JlaVoNzZ+Dunf87b/q6HqrfFpX5OEx8pFJbgUiMmNVQzN9/90gtLj
	 HZlK4bUOuihyyjoRPAlfI3QcFcLTGqSwHTrUvKivE2TnBzLNMyNbzsxH1mOvsfmjn0
	 XLjxQC1ndQchEuNy62YC075ma3m9knIbqThnyftYDJlqPv7ju1RKWHQS5URU60dMLg
	 AVndfqPp39TyNdAREidATRs6JPJ5yiWzy/KFgCg7y5539jbaXjo9DMghRae18H2JG9
	 +NhllqWh6/r/w==
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-2045bedb806so5919904fac.3;
        Fri, 12 Jan 2024 23:12:55 -0800 (PST)
X-Gm-Message-State: AOJu0YzFOkBa2vOS74KQlrnt358yEW0sstOcHkwZLbsVvqrX5AdSt9kX
	CO8KFjL0CRDjblwSui4mCQaDjtI52WQsLnyYgpM=
X-Google-Smtp-Source: AGHT+IF+Df9FcQywjWxaoVjG4ORC6Z1sY0YCsGgBbUrcrDABgiegRhwktniK9x2F7hFLhKHTLqgW3eHwvsPVsb05BLQ=
X-Received: by 2002:a05:6870:348d:b0:206:b890:6bcb with SMTP id
 n13-20020a056870348d00b00206b8906bcbmr3219304oah.102.1705129975063; Fri, 12
 Jan 2024 23:12:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240103135454.376021-1-masahiroy@kernel.org> <50cf203b-eb25-4cf2-a5ea-673656310822@roeck-us.net>
In-Reply-To: <50cf203b-eb25-4cf2-a5ea-673656310822@roeck-us.net>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Sat, 13 Jan 2024 16:12:19 +0900
X-Gmail-Original-Message-ID: <CAK7LNAR81=5Z9_kebK4yDC=n-cY0zf4kSGCJXRdLB1kS1+TGUw@mail.gmail.com>
Message-ID: <CAK7LNAR81=5Z9_kebK4yDC=n-cY0zf4kSGCJXRdLB1kS1+TGUw@mail.gmail.com>
Subject: Re: [PATCH] linux/export.h: remove unneeded .balign directive
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 11, 2024 at 8:11=E2=80=AFAM Guenter Roeck <linux@roeck-us.net> =
wrote:
>
> On Wed, Jan 03, 2024 at 10:54:54PM +0900, Masahiro Yamada wrote:
> > The .export_symbol section is discarded by the linker script, hence
> > no alignment is needed. Simplify the code.
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
>
> With this patch in linux-next, all sh4 builds fail.


Thanks.
I dropped it.







>
> Building sh:defconfig ... failed
> --------------
> Error log:
> <stdin>:1519:2: warning: #warning syscall clone3 not implemented [-Wcpp]
> {standard input}: Assembler messages:
> {standard input}:6: Error: misaligned data
> {standard input}:7: Error: misaligned data
> {standard input}:8: Error: misaligned data
> make[6]: *** [scripts/Makefile.build:243: arch/sh/boards/mach-x3proto/ils=
el.o] Error 1
>
> Reverting this patch fixes the problem.
>
> Guenter
>
> ---
> # bad: [8cb47d7cd090a690c1785385b2f3d407d4a53ad0] Add linux-next specific=
 files for 20240110
> # good: [0dd3ee31125508cd67f7e7172247f05b7fd1753a] Linux 6.7
> git bisect start 'HEAD' 'v6.7'
> # bad: [b14da9dd6f977c6e18a4c81e4b92692fd9b6997f] Merge branch 'main' of =
git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git
> git bisect bad b14da9dd6f977c6e18a4c81e4b92692fd9b6997f
> # bad: [e85ebbed67d0d74e8602d11a496183d8f65e0b2f] Merge branch 'for-next'=
 of https://evilpiepirate.org/git/bcachefs.git
> git bisect bad e85ebbed67d0d74e8602d11a496183d8f65e0b2f
> # bad: [65d7e41dbca9e31017cfd36c2ce4cb8408b1f2c6] Merge branch 'perf-tool=
s-next' of git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-ne=
xt.git
> git bisect bad 65d7e41dbca9e31017cfd36c2ce4cb8408b1f2c6
> # good: [fb46e22a9e3863e08aef8815df9f17d0f4b9aede] Merge tag 'mm-stable-2=
024-01-08-15-31' of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
> git bisect good fb46e22a9e3863e08aef8815df9f17d0f4b9aede
> # good: [fd38dd6abda589a8771e7872e4dea28c99c6a6ef] kselftest/alsa - conf:=
 Stringify the printed errno in sysfs_get()
> git bisect good fd38dd6abda589a8771e7872e4dea28c99c6a6ef
> # good: [8a0bd6d47301eefd80fdfeb3a00ec09011546155] Merge branch 'mtd/fixe=
s' of git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git
> git bisect good 8a0bd6d47301eefd80fdfeb3a00ec09011546155
> # good: [16f533ade706d33e60324ff32e526bda20bccbd9] perf unwind: Use funct=
ion to add missing maps lock
> git bisect good 16f533ade706d33e60324ff32e526bda20bccbd9
> # bad: [c6113f13957f918762d54080b2e2adbe0d7889e5] linux/export.h: remove =
unneeded .balign directive
> git bisect bad c6113f13957f918762d54080b2e2adbe0d7889e5
> # good: [d821f8a26efb6789666d70ce7a8f27df6c33c12e] sparc: vdso: use $(add=
prefix ) instead of $(foreach )
> git bisect good d821f8a26efb6789666d70ce7a8f27df6c33c12e
> # good: [9c65810cfb215f40f14d2c00694911fbc5408761] kbuild: deb-pkg: split=
 debian/copyright from the mkdebian script
> git bisect good 9c65810cfb215f40f14d2c00694911fbc5408761
> # good: [5e73758b43c3defba2578df6d3a53e942fa6b41e] kbuild: deb-pkg: use m=
ore debhelper commands in builddeb
> git bisect good 5e73758b43c3defba2578df6d3a53e942fa6b41e
> # good: [343f74e7779c482c2fd4492cc6b45c64e18fe321] kbuild: deb-pkg: make =
debian/rules quiet by default
> git bisect good 343f74e7779c482c2fd4492cc6b45c64e18fe321
> # good: [0832e9bcfb0dc48833bbc8054cdc9b697afa8cd9] kbuild: deb-pkg: build=
 binary-arch in parallel
> git bisect good 0832e9bcfb0dc48833bbc8054cdc9b697afa8cd9
> # good: [53bc4fa98f8dd5ccca9a8e038660bf0d30d9e22d] kbuild: deb-pkg: call =
more misc debhelper commands
> git bisect good 53bc4fa98f8dd5ccca9a8e038660bf0d30d9e22d
> # first bad commit: [c6113f13957f918762d54080b2e2adbe0d7889e5] linux/expo=
rt.h: remove unneeded .balign directive



--=20
Best Regards
Masahiro Yamada

