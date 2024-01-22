Return-Path: <linux-kernel+bounces-32707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B2071835F36
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:12:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B64A8B25107
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 10:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 439033A1AE;
	Mon, 22 Jan 2024 10:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pE6PNA+e"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852B939FF7;
	Mon, 22 Jan 2024 10:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705918186; cv=none; b=fygt2uPejxhgNyLEbIBVz94wkMWb/W/qouCKuMXhOCT2YZTrvOg29dVsF6tf4bb8EWSO81sUvfTs41B0wPc+jegIJmuj8hGmVvM0WDEZEkmWWbeBbsEtWTQkva1xAQ2pDOcJP4S4W0BxHrGsbtOWDeVQJI7FkuDQO2wWGEt9ecI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705918186; c=relaxed/simple;
	bh=XE5sibT07MUtktKYn3gvfIB8/LptzZOVCxCJLPHfZrs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GbXYj9/m2l5tKNhgzaAhZdEWzLxYi5IH3N5NsyPpKCVTCdtKQnacV9bN2NcObZqjvzvVrgBaU/kTEjUQFtu1QBIZghZVluo5FVL7kdI1cc9YTrUfKDhtW7RiZ2A6TiJTDammpcKMHz2aphR0Vn/T2KAz+DWihOScxj0lu+WZnIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pE6PNA+e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29AF3C43399;
	Mon, 22 Jan 2024 10:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705918186;
	bh=XE5sibT07MUtktKYn3gvfIB8/LptzZOVCxCJLPHfZrs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=pE6PNA+eLZyYw0TapmmcWDXjWfdMjlnLhXiY9/+R2rWvkRGdRh1DUl/DdvQ5+l7HP
	 2e9+ak5ovFNBt2Tjti0K4KXWIOV6CN7CpPZhtp7T27LDUPcqnMTUroB81UDu6SJduo
	 vGEq6FMMLuqq7jBGBRmDDpfod3dVbEO98BJdTp2ac0k+94fJtK/poI9i7UKJXZh2a/
	 LirqchStvbjQdb7ArfZ10z7ouhBfXAhH8vpNnIuB7JwIS7e73yFxCB5B3hYNj++IEm
	 K0Eo+aMRM3FIEohcby8udgcsK5LOm6EzCkkxl+VPEG/zO2ZW2jHS164fJHvtcctyFd
	 bfZkzmqHtbmJw==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-50ff9bde634so646195e87.2;
        Mon, 22 Jan 2024 02:09:46 -0800 (PST)
X-Gm-Message-State: AOJu0YxXlr3kCZ3GQ9M0/yV++KgWY2Sxw9Mn9BRa7sKjcJMggZRR+IJQ
	0Bn6gdizDgU0CpNqbyGMonud55FCUKYI0jFTaF60f+tafMG6NO//60LvT9PP8898tv2N/71oVsG
	b7/565E+RBrvaPaZd/rUA1MPzm5Y=
X-Google-Smtp-Source: AGHT+IFTfhxWMWLtxGAHctQc939UBRXnunfcyPtj4pRi1fRakd+7q0rE30I0aMY6W+/fJlYYtH8KkeqTkMVR+zsnMYM=
X-Received: by 2002:ac2:48a6:0:b0:50e:88d0:447b with SMTP id
 u6-20020ac248a6000000b0050e88d0447bmr1202146lfg.31.1705918184370; Mon, 22 Jan
 2024 02:09:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240120103734.4155446-1-yukuai1@huaweicloud.com>
 <CAPhsuW7trizGqWcBWQ1R1mrxyA6sNTuwXOK-0vxtCHO6fqcTbQ@mail.gmail.com> <354941c2-17bd-ce04-f8c8-645d7c4de4cc@huaweicloud.com>
In-Reply-To: <354941c2-17bd-ce04-f8c8-645d7c4de4cc@huaweicloud.com>
From: Song Liu <song@kernel.org>
Date: Mon, 22 Jan 2024 02:09:31 -0800
X-Gmail-Original-Message-ID: <CAPhsuW68RTGBSFpnyePTX5ydo+erh7mKJt2UD64VX5g6JfR4sA@mail.gmail.com>
Message-ID: <CAPhsuW68RTGBSFpnyePTX5ydo+erh7mKJt2UD64VX5g6JfR4sA@mail.gmail.com>
Subject: Re: [PATCH 0/5] md: fix/prevent dm-raid regressions
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: Mikulas Patocka <mpatocka@redhat.com>, dm-devel@lists.linux.dev, msnitzer@redhat.com, 
	heinzm@redhat.com, linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org, 
	yi.zhang@huawei.com, yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 12:24=E2=80=AFAM Yu Kuai <yukuai1@huaweicloud.com> =
wrote:
>
> Hi,
>
> =E5=9C=A8 2024/01/21 12:41, Song Liu =E5=86=99=E9=81=93:
> > On Sat, Jan 20, 2024 at 2:41=E2=80=AFAM Yu Kuai <yukuai1@huaweicloud.co=
m> wrote:
> >>
> >> From: Yu Kuai <yukuai3@huawei.com>
> >>
> >> There are some problems that we fixed in md/raid, and some apis is cha=
nged.
> >> However, dm-raid rely the old apis(noted that old apis is problematic =
in
> >> corner cases), and now there are regressions in lvm2 testsuite.
> >>
> >> This patchset fix some regressions(patch 1-3), and revert changes to
> >> prevent regressions(patch 4,5). Noted that the problems in patch 4,5 i=
s
> >> not clear yet, and I'm not able to locate the root cause ASAP, hence I
> >> decide to revert changes to prevent regressions first.
> >
> > Thanks for looking into this!
> >
> > Patch 1-3 look good to me. But since we need to back port these fixes
> > to 6.7 kernels, let's make it very clear what issues are being fixed.
> > Please:
>
> I'm attaching my test result here, before I send the next version.
>
> The tested patched add following changes for patch 5:
>
> @@ -9379,6 +9387,15 @@ static void md_start_sync(struct work_struct *ws)
>          suspend ? mddev_suspend_and_lock_nointr(mddev) :
>                    mddev_lock_nointr(mddev);
>
> +       if (!test_bit(MD_RECOVERY_RUNNING, &mddev->recovery)) {
> +               /*
> +                * dm-raid calls md_reap_sync_thread() directly to
> unregister
> +                * sync_thread, and md/raid should never trigger this.
> +                */
> +               WARN_ON_ONCE(mddev->gendisk);
> +               goto not_running;;
> +       }
> +
>          if (!md_is_rdwr(mddev)) {
>
> Failed tests for v6.6:
> ###       failed: [ndev-vanilla] shell/duplicate-vgid.sh
> ###       failed: [ndev-vanilla] shell/fsadm-crypt.sh
> ###       failed: [ndev-vanilla] shell/lvchange-raid1-writemostly.sh
> ###       failed: [ndev-vanilla] shell/lvconvert-cache-abort.sh
> ###       failed: [ndev-vanilla] shell/lvconvert-repair-raid.sh
> ###       failed: [ndev-vanilla] shell/lvcreate-large-raid.sh
> ###       failed: [ndev-vanilla] shell/lvextend-raid.sh
> ###       failed: [ndev-vanilla] shell/select-report.sh
>
> Failed tests for next-20240117(latest linux-next, between v6.7 to v6.8-rc=
1)
> ###       failed: [ndev-vanilla] shell/duplicate-vgid.sh
> ###       failed: [ndev-vanilla] shell/fsadm-crypt.sh
> ###       failed: [ndev-vanilla] shell/lvchange-raid1-writemostly.sh
> ###       failed: [ndev-vanilla] shell/lvconvert-repair-raid.sh
> ###       failed: [ndev-vanilla] shell/lvextend-raid.sh
> ###       failed: [ndev-vanilla] shell/select-report.sh
>
> Please noted that the test lvconvert-raid-reshape.sh is still possible
> to fail due to commit c467e97f079f ("md/raid6: use valid sector values
> to determine if an I/O should wait on the reshape").

Thanks for the information!

I will look closer into the raid6 issue.

Song

