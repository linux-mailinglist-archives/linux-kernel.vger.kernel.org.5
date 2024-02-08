Return-Path: <linux-kernel+bounces-57579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB08B84DAF2
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 09:05:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A1F31C20C5C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 08:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61BA26A025;
	Thu,  8 Feb 2024 08:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C1kKwziR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E166A00C;
	Thu,  8 Feb 2024 08:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707379499; cv=none; b=iVZ+XzGAIZk4najzX85ZnMI+Q9zZRayAgHkfPFvM2SlDyrB7DVUbS6Qhi9StQ1PLDjIy3pMCm5/TFQpMmG1cb9sUd5g+20ZG8HJq7s8caq98fywtK2zDt+22xo+fmtC20cuwOeRt45XIMAuBQCIJF0tCe4jWNxT6HxfN/L2A2xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707379499; c=relaxed/simple;
	bh=987LamE2hoEYsIxcVaDf9AVrqwlJJKTBlW3xcybR3jg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PPPbJYiC+KSoa6aMYprxU5kPq3uMtOLsQZCHSW6Gcc5oplobUmQacz4uvzYwKk+fTLz/siXeSduqr8Dcbuoj0p7ZNixWddqgdmdzxY/ZxnWtZ+ZoRiDyGeL3kgG5Ocrlp/7GBh10smfFRDmjDJbOpOKMG3niTLJp+eKBzemzWOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C1kKwziR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32D8FC433B1;
	Thu,  8 Feb 2024 08:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707379499;
	bh=987LamE2hoEYsIxcVaDf9AVrqwlJJKTBlW3xcybR3jg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=C1kKwziRE6HLVhmLLbdOQ3JMdqicW+jaEj3q+lJ05NQnFdvYOLaItsZQlpE61LS6S
	 w+ApCHpbSVO/5Ll9XC/tDvBPyXsO9CxRHzzpEnYKYqPO1dgl9nKq45vA7EhwuuUKvk
	 aWjNsK83+i6lvTPF0DYAz9lwDp/s7lyBxtu/wJCUivAs9hmQ4GXJs/5JMrXhRpNgR5
	 vW8a9Lj2Kwoq+c1B/S0mC25j2vNv/j38ELT3gN6P/uUVYVFFckOzVBkIxaN7XXIiVA
	 NdmZTHHfxgHV6KhD5A1/JnwGtrGSs7DdpO6x5yCWYTf2MTJdcIV9SeQ/Ib/JtWFgbr
	 ttgQ5YcqKVosA==
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2d0a0873404so16253971fa.2;
        Thu, 08 Feb 2024 00:04:59 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVgygSlLDzD03NZVTBrxWCsuy09ZdryNuzdMWVx7Poj43eIkOMg90p0gxeq4dSDRawL+hG3EUw/S5tM1cynzA81A+dQ3T9Eg3/Xflwp4uNtHdEsUAfg+ka93TmLBzpeSQvXI6nc74LfPQ==
X-Gm-Message-State: AOJu0YyBzH7k4ezdXeTdbhgg4jvkU/yQrCvGu7YwYeEHvV1JBTOY39Pt
	kM0IEwgGFunRk29aYO2dz8+dZ21qOsyFNJ750dacpUaUXMT+UFuLNVuO65yyrHhdAP5hzL54YV+
	Q6vUDI+OGIfMOME52lCsx0krhRVc=
X-Google-Smtp-Source: AGHT+IHhd7nYhLwZxzPnQ41aIE/TXjpjTzflGJ8ROY9ZKiYoUkmqdPeIHXnD3Bvvo4wnv41GIfnQ9bykXZu4mR1vI84=
X-Received: by 2002:a05:651c:210d:b0:2d0:bf38:d2d6 with SMTP id
 a13-20020a05651c210d00b002d0bf38d2d6mr5970301ljq.48.1707379497350; Thu, 08
 Feb 2024 00:04:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240201092559.910982-1-yukuai1@huaweicloud.com>
 <Zb2wxIpf7uYV6Vya@bmarzins-01.fast.eng.rdu2.dc.redhat.com>
 <528ce926-6f17-c1ea-8e77-c7d5d7f56022@huaweicloud.com> <ZcE4mGXCDwjqBXgf@bmarzins-01.fast.eng.rdu2.dc.redhat.com>
 <1fdbfcf8-1ee9-4079-e84e-6e2c1121491b@huaweicloud.com> <ZcGuRIrZJaEtXjPh@bmarzins-01.fast.eng.rdu2.dc.redhat.com>
In-Reply-To: <ZcGuRIrZJaEtXjPh@bmarzins-01.fast.eng.rdu2.dc.redhat.com>
From: Song Liu <song@kernel.org>
Date: Thu, 8 Feb 2024 00:04:45 -0800
X-Gmail-Original-Message-ID: <CAPhsuW6arbEmRUK3xG1XVjra3BtSx9_wFe+QKDBbTgb3DgYXig@mail.gmail.com>
Message-ID: <CAPhsuW6arbEmRUK3xG1XVjra3BtSx9_wFe+QKDBbTgb3DgYXig@mail.gmail.com>
Subject: Re: [PATCH v5 00/14] dm-raid/md/raid: fix v6.7 regressions
To: Benjamin Marzinski <bmarzins@redhat.com>
Cc: Yu Kuai <yukuai1@huaweicloud.com>, mpatocka@redhat.com, heinzm@redhat.com, 
	xni@redhat.com, blazej.kucman@linux.intel.com, agk@redhat.com, 
	snitzer@kernel.org, dm-devel@lists.linux.dev, jbrassow@f14.redhat.com, 
	neilb@suse.de, shli@fb.com, akpm@osdl.org, linux-kernel@vger.kernel.org, 
	linux-raid@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com, 
	"yukuai (C)" <yukuai3@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Benjamin,

On Mon, Feb 5, 2024 at 7:58=E2=80=AFPM Benjamin Marzinski <bmarzins@redhat.=
com> wrote:
>
> On Tue, Feb 06, 2024 at 09:36:18AM +0800, Yu Kuai wrote:
> > Hi!
> >
> > =E5=9C=A8 2024/02/06 3:35, Benjamin Marzinski =E5=86=99=E9=81=93:
> > > Could you run the test with something like
> > >
> > > # make check_local T=3Dlvconvert-repair-raid.sh VERBOSE=3D1 > out 2>&=
1
> > >
> > > and post the output.
> >
> > Attached is the output from my VM.
>
> Instead of running the tests from the lvm2 git repo, if you run
>
> # make -C test install
>
> to install the tests, and then create a results directory and run the
> test from there, do you still see the error in the 6.6 kernel?
>
> # make ~/results
> # cd ~/results
> # lvm2-testsuite --only lvconvert-repair-raid.sh
>
> Running the tests this way will test the installed lvm2 binaries on your
> system, instead of the ones in the lvm2 git repo. They may be compiled
> differently.

I am not able to get reliable results from shell/lvconvert-repair-raid.sh
either. For 6.6.0 kernel, the test fails. On 6.8-rc1 kernel, the test fails
sometimes.

Could you please share more information about your test setup?
Specifically:
1. Which tree/branch/tag are you testing?
2. What's the .config used in the tests?
3. How do you run the test suite? One test at a time, or all of them
together?
4. How do you handle "test passes sometimes" cases?

Thanks,
Song

