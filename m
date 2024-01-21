Return-Path: <linux-kernel+bounces-31963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A025883546F
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 05:41:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C9E8281E34
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 04:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83C2228E17;
	Sun, 21 Jan 2024 04:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uXMrvdUw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6FEC26AF5;
	Sun, 21 Jan 2024 04:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705812101; cv=none; b=ceBvmBvNwHXrAg8L6bVBrzeoA/SuCkGNNLzk4M3mACb4zlSOdVa9CW1WZxvQqDbDxjTnT90TMg53xE6SgMAQOJ36W2yZrS7SFk7SnlysCcgN/25Ul7CRP+QAkp82CqkhFEUBq55ZGDDbJORWX439TBsQQjNA2AEPDB4mdjUbqh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705812101; c=relaxed/simple;
	bh=CLoBcUg0M1rW7KdYcGww7VUJ+qhz8K1YgEbTrTVDmU4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rNVOmcVq+q+SeAgc8wzzzKNaSN8nsS6Va88eFLbU2JMpn84bb636crYgllFOYnZqGnxBDme6VFiaG1UMFgKGLnmtCHZvDlkaf28x8JiI3AZyQSqs3O9AlEN/04B0m6fAUKGz7kM/vty1mIXnklugIc4OA+wLiOgzBX2ZfNLnsVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uXMrvdUw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56B5AC43399;
	Sun, 21 Jan 2024 04:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705812101;
	bh=CLoBcUg0M1rW7KdYcGww7VUJ+qhz8K1YgEbTrTVDmU4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=uXMrvdUwySsWCTlFCfNRpqxg2YIa4hG0aFEAw8+EG+U8xuWReAk1o2vuJ5J+MAY4I
	 pR3nY8T+N19UbZ9l36z6UIbE7f+zoEGuQfsrLyj4bP1VDIQKN2S8M62G7AU7ojftbY
	 TUGY1F8tSDxTneUjazIO4MAMar/jrqJbqQRm1tjjO7/1H99Ea9ydkJvWoXua9wRExS
	 2ST0D63lrmPUWoYqPJBLMheaLJZLHJHv36wkwkWQq+svJlaxXlQLwro9hfsgF4abp2
	 GOIsbfpC0dBbr5mZyehNr2ooi7fZ4unVF1SWnIIOzzdyfOOnuO5SpdoBdZGxRMjGVm
	 uz4sW6E2lPPjw==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-50e72e3d435so1935262e87.2;
        Sat, 20 Jan 2024 20:41:41 -0800 (PST)
X-Gm-Message-State: AOJu0YykvYbCE08zBh/e+gXEqXZKbB4oBeaaP1Ka5Phl4co/OzXOihiQ
	9S+ujeNI4pKrA6k/OE4r/k1X/8aF+GqJbbhDuyUquwCwlyX31WdnmWrWyJE4JVZJuLL9e3hzaI+
	N//DYWhp+kymJ/Gmwdl1IqGTO5ac=
X-Google-Smtp-Source: AGHT+IEwi8R/zySvtTMK4LGF0oiFWjRhGybo+7mnsI0ANF/O090kSSpksEK1uexddbW+BVMFtBTaMDYijmeHJ7NZSJg=
X-Received: by 2002:a05:6512:2112:b0:50e:3fbb:e5e4 with SMTP id
 q18-20020a056512211200b0050e3fbbe5e4mr525465lfr.164.1705812099509; Sat, 20
 Jan 2024 20:41:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240120103734.4155446-1-yukuai1@huaweicloud.com>
In-Reply-To: <20240120103734.4155446-1-yukuai1@huaweicloud.com>
From: Song Liu <song@kernel.org>
Date: Sat, 20 Jan 2024 20:41:28 -0800
X-Gmail-Original-Message-ID: <CAPhsuW7trizGqWcBWQ1R1mrxyA6sNTuwXOK-0vxtCHO6fqcTbQ@mail.gmail.com>
Message-ID: <CAPhsuW7trizGqWcBWQ1R1mrxyA6sNTuwXOK-0vxtCHO6fqcTbQ@mail.gmail.com>
Subject: Re: [PATCH 0/5] md: fix/prevent dm-raid regressions
To: Yu Kuai <yukuai1@huaweicloud.com>, Mikulas Patocka <mpatocka@redhat.com>
Cc: dm-devel@lists.linux.dev, msnitzer@redhat.com, heinzm@redhat.com, 
	yukuai3@huawei.com, linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org, 
	yi.zhang@huawei.com, yangerkun@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 20, 2024 at 2:41=E2=80=AFAM Yu Kuai <yukuai1@huaweicloud.com> w=
rote:
>
> From: Yu Kuai <yukuai3@huawei.com>
>
> There are some problems that we fixed in md/raid, and some apis is change=
d.
> However, dm-raid rely the old apis(noted that old apis is problematic in
> corner cases), and now there are regressions in lvm2 testsuite.
>
> This patchset fix some regressions(patch 1-3), and revert changes to
> prevent regressions(patch 4,5). Noted that the problems in patch 4,5 is
> not clear yet, and I'm not able to locate the root cause ASAP, hence I
> decide to revert changes to prevent regressions first.

Thanks for looking into this!

Patch 1-3 look good to me. But since we need to back port these fixes
to 6.7 kernels, let's make it very clear what issues are being fixed.
Please:
1. Test on both Linus' master branch and 6.7.y, and explain which tests
are failing before the fixes. (From my tests, the two branches don't have
the same test results). We can put these results in the cover letter and
include them in a merge commit.
2. If possible, add Fixes tag to all patches.
3. Add more details in the commit log, so it is clear what is being fixed.
4. Add "reported-by" and maybe also "closes" tag.

For patch 4-5, especially 5, I wonder whether the same issue also
happens with md. We can probably ship 4-5 now, with the same
improvements as patch 1-3.

I will run more tests on my side.

Mykulas, please also review and test these patches.

Thanks,
Song



>
> Yu Kuai (5):
>   md: don't ignore suspended array in md_check_recovery()
>   md: don't ignore read-only array in md_check_recovery()
>   md: make sure md_do_sync() will set MD_RECOVERY_DONE
>   md: revert commit fa2bbff7b0b4 ("md: synchronize flush io with array
>     reconfiguration") for dm-raid
>   md: use md_reap_sync_thread() directly for dm-raid
>
>  drivers/md/md.c | 58 ++++++++++++++++++++++++++++++-------------------
>  1 file changed, 36 insertions(+), 22 deletions(-)
>
> --
> 2.39.2
>
>

