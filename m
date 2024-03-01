Return-Path: <linux-kernel+bounces-87999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFC9986DBF3
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 08:16:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7932D1F2565F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 07:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84B2C6931B;
	Fri,  1 Mar 2024 07:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iEbWaJaV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6FF267E6E;
	Fri,  1 Mar 2024 07:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709277397; cv=none; b=oI/0tiy+jFvKahdKTdSWVjvNzwkZDVA3kTzINS3hNuvAcg00540xe12ifPSICZjPdbd0s1IpLbeRdRgHsBkRLDZ7+V216x+7KUW9HQONSbaiGvxnAv/M1+2OLk/AJW9v28j8raG9TU8c0nsM84bixV4IcqQ+q8Sz5SbYvt/TP0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709277397; c=relaxed/simple;
	bh=0BzsnNiaInfdu/nXYGE6MX7l+SAOmxghjMCRTvbovxs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EagoD6nn7KVx23towAU/qbTG2hv+1I+rI1Z/sofrc21KKECiYmqu1QTjjHxD9IR03ZwWyeWEIZ9tkiFl382fIwHdAU6VCm76lOR1/MHaKnAA2+TVn6FbSCr2JME25YnJHRDPVgsImuoatlC2DqZuSnsfSmqMK9TijFXVasujtF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iEbWaJaV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68A68C433F1;
	Fri,  1 Mar 2024 07:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709277397;
	bh=0BzsnNiaInfdu/nXYGE6MX7l+SAOmxghjMCRTvbovxs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=iEbWaJaVt29hajza7a5ZZr3HwkMnT/Ma+OORF4y9QU1h6Rm2g3yxiNNszd7huK8Om
	 Rcry4kS1gWvz327xVmNKRzpw9hI27Am+vNOgji+KEakd/H2dd3aVpWICEDhPsUTRVs
	 urtZdhxE7B6EvimsTxN1JgyA/ES92e9IwoJS+6eqWDiwPiZetr/W56wq6QIvFpv2mG
	 asE6e5egpg2WfecbRyn/xxEwf/6tHfyIhi+MNe+WQUeqKHwRPx4/lVdEN3cz7WemWX
	 EPctPRrcbqAT9iO1BMRYu0yZf+8Q0BEx+AK/pYLydd0vsOh4yAZacNW45FCqEwef8I
	 nghLJN1tsRY1A==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-51325c38d10so1226806e87.1;
        Thu, 29 Feb 2024 23:16:37 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV6W7tmIIuBoUGiln/rEgOR275ZvVehF5L3sDNePvqrYgQWjSreUFOTrltj6Qgkw/+oPM5fSPyfNgMLPXhQ1889kAzWoFOKqjA3I0J8l3Gc8Y6kXcPP4j7fHbQU13Fg15OMqYH7pbXvkw==
X-Gm-Message-State: AOJu0Yw/AUFr0s4bTB1jq6qngW7Wbohd8cK9j0UkmNsKcV9Ce+uiujHJ
	QQ4xQX57UEGvabucFzThnzAFUqeumK0ozK0NEEkS+JVdju37E5jHpZem+iAgosG2yI+7Au7d3aF
	UOKq4Io6xq14K5mN440aTQUZ0fIo=
X-Google-Smtp-Source: AGHT+IFJT4sCIg13B9hnSSV+tE/g5OU8O2Suok8YTMEpleJ+GEZU36Kg1YYOlXUJ8j0jzlI0ctezXEVj+rpqK5kz+X4=
X-Received: by 2002:a05:6512:1110:b0:513:26d3:c1e9 with SMTP id
 l16-20020a056512111000b0051326d3c1e9mr2007013lfg.19.1709277395586; Thu, 29
 Feb 2024 23:16:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240229095714.926789-1-yukuai1@huaweicloud.com>
In-Reply-To: <20240229095714.926789-1-yukuai1@huaweicloud.com>
From: Song Liu <song@kernel.org>
Date: Thu, 29 Feb 2024 23:16:24 -0800
X-Gmail-Original-Message-ID: <CAPhsuW5ZiaRBPKVpO758TocoHbAfav8MORzvBhobjOiVaCcyXA@mail.gmail.com>
Message-ID: <CAPhsuW5ZiaRBPKVpO758TocoHbAfav8MORzvBhobjOiVaCcyXA@mail.gmail.com>
Subject: Re: [PATCH md-6.9 v4 00/11] md/raid1: refactor read_balance() and
 some minor fix
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: xni@redhat.com, paul.e.luse@linux.intel.com, neilb@suse.com, shli@fb.com, 
	linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org, yukuai3@huawei.com, 
	yi.zhang@huawei.com, yangerkun@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 2:03=E2=80=AFAM Yu Kuai <yukuai1@huaweicloud.com> w=
rote:
>
> From: Yu Kuai <yukuai3@huawei.com>
>
> Changes in v4:
>  - fix a problem in v2, that replacement rdev->raid_disk is set to
>  raid_disk + conf->mirros, which will cause test 01replace to run
>  forever, and mdadm tests looks good now(no new regression);
> Changes in v3:
>  - add patch 2, and fix that setup_conf() is missing in patch3;
>  - add some review tag from Xiao Ni(other than patch 2,3);
> Changes in v2:
>  - add new conter in conf for patch 2;
>  - fix the case choose next idle while there is no other idle disk in
>  patch 3;
>  - add some review tag from Xiao Ni for patch 1, 4-8
>
> The original idea is that Paul want to optimize raid1 read
> performance([1]), however, we think that the original code for
> read_balance() is quite complex, and we don't want to add more
> complexity. Hence we decide to refactor read_balance() first, to make
> code cleaner and easier for follow up.
>
> Before this patchset, read_balance() has many local variables and many
> branches, it want to consider all the scenarios in one iteration. The
> idea of this patch is to divide them into 4 different steps:
>
> 1) If resync is in progress, find the first usable disk, patch 5;
> Otherwise:
> 2) Loop through all disks and skipping slow disks and disks with bad
> blocks, choose the best disk, patch 10. If no disk is found:
> 3) Look for disks with bad blocks and choose the one with most number of
> sectors, patch 8. If no disk is found:
> 4) Choose first found slow disk with no bad blocks, or slow disk with
> most number of sectors, patch 7.
>
> Note that step 3) and step 4) are super code path, and performance
> should not be considered.
>
> And after this patchset, we'll continue to optimize read_balance for
> step 2), specifically how to choose the best rdev to read.
>
> [1] https://lore.kernel.org/all/20240102125115.129261-1-paul.e.luse@linux=
intel.com/
>
> Yu Kuai (11):
>   md: add a new helper rdev_has_badblock()
>   md/raid1: factor out helpers to add rdev to conf
>   md/raid1: record nonrot rdevs while adding/removing rdevs to conf
>   md/raid1: fix choose next idle in read_balance()
>   md/raid1-10: add a helper raid1_check_read_range()
>   md/raid1-10: factor out a new helper raid1_should_read_first()
>   md/raid1: factor out read_first_rdev() from read_balance()
>   md/raid1: factor out choose_slow_rdev() from read_balance()
>   md/raid1: factor out choose_bb_rdev() from read_balance()
>   md/raid1: factor out the code to manage sequential IO
>   md/raid1: factor out helpers to choose the best rdev from
>     read_balance()

Applied v4 of the set to md-6.9 branch.

Thanks,
Song

