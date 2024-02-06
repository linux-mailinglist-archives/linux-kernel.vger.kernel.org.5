Return-Path: <linux-kernel+bounces-55345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A008F84BB84
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 18:01:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58A2D285E76
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 17:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 869946FD9;
	Tue,  6 Feb 2024 17:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RffpvAQa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C383E6FB1;
	Tue,  6 Feb 2024 17:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707238861; cv=none; b=NIX4dh1UDyiXRgkXkYaZVDiVgdC9FCRRVP0xbTCFGc/49g8pWWbuEfnjmhq8ZyDqWFjRwzRe/jD2aics0Yh1niWAWQ4R8zxY1fLSY+LNKXvo0DR2v/oSaK51Fcu2+i/NbXYuR3EdjfeBd8utNr4RL2paXxWnK2/8azQ8Go+x83Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707238861; c=relaxed/simple;
	bh=BkIorsxSJVUxH1YGy6HZ2YuCtLVIQr514IOWBZXf9hs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TbAuGb355wjTrITnRt/tdCNpGIk4SnkxwbV2MI+f6KBVPcHVdtpSe3GOI7KlR4ewuT4Oqa0pZIjhgYQE+pZAt7j5kYX5GGHK9dinphXmCfoc3GXodUIfZ7jej7Pd0+oGhktgE+0cbwjDsVcnVLEaADlXuJaK1SJvzBvANSLnXp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RffpvAQa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 553C1C433F1;
	Tue,  6 Feb 2024 17:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707238861;
	bh=BkIorsxSJVUxH1YGy6HZ2YuCtLVIQr514IOWBZXf9hs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=RffpvAQa1aTBwLHIygruGLrdOCHr8skmOk5DCjFnPJ+CsdqEMjegHPwVWpGS/VMX1
	 yJQ8wysYrbg5yZ3FeDhbjeJu2HqUi4GDwB1CCCnAVWul/+Oq2eeWv0piHwTprYH8SE
	 KaVxJcqu4V4Yph7iUTVC5jir1mGCiy+NwXll7uAHexWGVoLWtFPLfMN3S8TDmVlHHK
	 KFSkIsR7V3qRf4JKKDZkpOyeZFw+fu8rbM1d7adheISb7b+WO0lyyHPLfNZO0+Lw5U
	 Fsjkv0EfVIyYSnINJl2pJYN5Zi/6fZrltMz2qFejBN0hwK63PMGEk8QGciMAyUHbzO
	 ZdJQXytJrI8EA==
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2d0a0e40672so8246741fa.0;
        Tue, 06 Feb 2024 09:01:01 -0800 (PST)
X-Gm-Message-State: AOJu0Yy7gYZXxYBSYOKjmVzH5QRDBCZ4UBzCReMuWewP9j+CFWili/mK
	uZI69+oiEdJAIJ8H99bnXluF1DNkz+HNGDRNBUrZAM3h+FSq8cxwkpzGnfmALp9MuVpvQMn2bxX
	+DbXNRaRsPGFJ09ZEwHBORnQJ5is=
X-Google-Smtp-Source: AGHT+IE3bvglp/rupXVXH4xxKZYj1bjwFm34y+1mP/JpsjW/07TWlBCkySm3T+GwJGqToWdelet70VAx5rqEeQjxF/w=
X-Received: by 2002:a2e:9154:0:b0:2cf:2c84:bcd7 with SMTP id
 q20-20020a2e9154000000b002cf2c84bcd7mr1061617ljg.18.1707238859545; Tue, 06
 Feb 2024 09:00:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231221071109.1562530-1-linan666@huaweicloud.com>
 <20231221071109.1562530-3-linan666@huaweicloud.com> <3b240652-580e-73d5-a318-612984902aad@huaweicloud.com>
 <a92ca042-b981-4f35-beec-ebf416e4239b@leemhuis.info>
In-Reply-To: <a92ca042-b981-4f35-beec-ebf416e4239b@leemhuis.info>
From: Song Liu <song@kernel.org>
Date: Tue, 6 Feb 2024 09:00:47 -0800
X-Gmail-Original-Message-ID: <CAPhsuW5ZhW3fR8LwKsMrRV6bVMbXJfonkBqVMVQqw=FAJg3V4A@mail.gmail.com>
Message-ID: <CAPhsuW5ZhW3fR8LwKsMrRV6bVMbXJfonkBqVMVQqw=FAJg3V4A@mail.gmail.com>
Subject: Re: [PATCH 2/2] md: create symlink with disk holder after mddev resume
To: Linux regressions mailing list <regressions@lists.linux.dev>
Cc: Yu Kuai <yukuai1@huaweicloud.com>, linan666@huaweicloud.com, 
	linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org, yi.zhang@huawei.com, 
	houtao1@huawei.com, yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 6, 2024 at 6:46=E2=80=AFAM Linux regression tracking (Thorsten
Leemhuis) <regressions@leemhuis.info> wrote:
>
> Hi, Thorsten here, the Linux kernel's regression tracker.
>
> On 21.12.23 09:49, Yu Kuai wrote:
> > =E5=9C=A8 2023/12/21 15:11, linan666@huaweicloud.com =E5=86=99=E9=81=93=
:
> >> From: Li Nan <linan122@huawei.com>
> >>
> >> There is a risk of deadlock when a process gets disk->open_mutex after
> >> suspending mddev, because other processes may hold open_mutex while
> >> submitting io. For example:
> >> [...]
> > Nice catch! This patch looks good except that the new flag
> > 'SymlinkCreated' doesn't look accurate, perhaps 'HolderLinked'
> > will make more sense.
> >
> >> Fix it by getting disk->open_mutex after mddev resume, iterating each
> >> mddev->disk to create symlink for rdev which has not been created yet.
> >> and moving bd_unlink_disk_holder() to mddev_unlock(), rdev has been
> >> deleted from mddev->disks here, which can avoid concurrent bind and
> >> unbind,
> >>
> >> Fixes: 1b0a2d950ee2 ("md: use new apis to suspend array for ioctls
> >> involed array reconfiguration")
>
> Hey, what happened to that patch? It looks a lot like things stalled
> here. I'm asking, because there is a regression report that claims
> 1b0a2d950ee2 to be the culprit that might or might not be causes by the
> problem this patch tries to fix:
> https://bugzilla.kernel.org/show_bug.cgi?id=3D218459

Thanks for the heads-up. Replied to the thread.

Song

