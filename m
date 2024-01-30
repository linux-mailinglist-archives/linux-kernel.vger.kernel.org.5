Return-Path: <linux-kernel+bounces-44049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 776E3841CA7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 08:35:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A88561C252E0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 07:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01A0C537E8;
	Tue, 30 Jan 2024 07:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fUH9ODaA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E7050A70;
	Tue, 30 Jan 2024 07:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706600095; cv=none; b=UUNrq/+7OcKYmnGBtap52mjjaLgNfdur8tQH8kEPjPcli9VJveWM8YfcmgHjCAG7lHKzRvPTeCsCDjz1o6I3CrmtpwgbMYeds3jWNj4feKZkBExduVMd5GJ1E2ZBmynPXAOFgvjqg1xAuNe/d90SVOxnOALpCWaqxn57k7K+XQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706600095; c=relaxed/simple;
	bh=+IitaL70UEF1t6zrG6EiCU/A4cZoDZjvNxzIBHHtxwU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pXSNqKsuKUtFd0VGg7YjgQJq046mh8KgwhSxVOt+ePEHfx+QRpnnyKUrc8ZA6nY9kLXpTVqREBa1rW0sLRxzjSRGcYKcIe6pA8VbjwhKpwHDWvktLdbHGf+PRQ0KEglXwr+01yaDfY6bDpjRYlRU0VoAiFmYAvXF3mBhbzIATBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fUH9ODaA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF28DC433C7;
	Tue, 30 Jan 2024 07:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706600094;
	bh=+IitaL70UEF1t6zrG6EiCU/A4cZoDZjvNxzIBHHtxwU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=fUH9ODaA6KMFHk8ZZMI2XMd6FeBC0koIc9yyrKMr8ds1sD5HpL2o+ni7OhzTgmzxj
	 4LmTg8+6YLvG2F+KQuzAO8N/LLiVqwgTri5EHIIxiaYiAyzfgQw75nQQAJp16JCGRG
	 QzdkyK3FzH76ZqI+vQY5ZdCjqkMaS26ivTUf4wAYjvWd96OKGsEI8GGI36qVIs8JRg
	 ja87hmrw5++mWUGRZNHzwzbX/EEj4jjdjzyIW3SlIDVJTw1FWOuTbWkyEnVwWtKlES
	 Fxpb7OKsVYqBydClN22VNLGAxNS7sbuBrEEXSh4rhuXlqcLFQfOFlBbXtsO9aezdMD
	 Yg0b3Pf2gtoQg==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2cf33b909e8so46732271fa.0;
        Mon, 29 Jan 2024 23:34:54 -0800 (PST)
X-Gm-Message-State: AOJu0Ywv6cDDu2/CApvL1DgIW73PlKxUgc+0jmmw+w6OY5pA+VzhVr1a
	PDxZaaX18u7IbTCAVNCDa9j2sCxPC+zTeio3+1TNv11MkhO5hPoAQa05s7miiS73JghzIfdpKci
	/Cdv3QL4C0KlUhfDP2lvM+qktxyI=
X-Google-Smtp-Source: AGHT+IEqner9VzfT/ruq28vxshs7jIKd4pqYd+oRUq4i5ox81Xer+2MlL7LWieqQzZXE7Rdj4UvhvutRLtH9rf5oQWw=
X-Received: by 2002:a05:651c:2db:b0:2ce:fc69:47fd with SMTP id
 f27-20020a05651c02db00b002cefc6947fdmr281501ljo.16.1706600092822; Mon, 29 Jan
 2024 23:34:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231228125553.2697765-1-yukuai1@huaweicloud.com>
 <20231228125553.2697765-4-yukuai1@huaweicloud.com> <CAPhsuW5ck33wdFznkpXzZmyW3ux3gCf-yhQnevdirjVJkmzmEA@mail.gmail.com>
 <864b3e44-ba1b-3bfe-c17e-3e6048fbea01@huaweicloud.com>
In-Reply-To: <864b3e44-ba1b-3bfe-c17e-3e6048fbea01@huaweicloud.com>
From: Song Liu <song@kernel.org>
Date: Mon, 29 Jan 2024 23:34:41 -0800
X-Gmail-Original-Message-ID: <CAPhsuW5-Rg8F2R-zkA5YWbjdz7TcNUsXUivDMwH+s-PxjKjAcg@mail.gmail.com>
Message-ID: <CAPhsuW5-Rg8F2R-zkA5YWbjdz7TcNUsXUivDMwH+s-PxjKjAcg@mail.gmail.com>
Subject: Re: [PATCH -next 3/3] md: use interruptible apis in idle/frozen_sync_thread()
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: neilb@suse.de, linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org, 
	yi.zhang@huawei.com, yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 29, 2024 at 11:04=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.com> =
wrote:
>
> Hi,
>
> =E5=9C=A8 2024/01/30 14:37, Song Liu =E5=86=99=E9=81=93:
> > Hi,
> >
> > Sorry for the late reply.
> >
> > The first two patches of the set look good, so I applied them to
> > md-tmp-6.9 branch. However, this one needs a respin.
>
> We are fixing dm-raid regressions, so I'll not send a new version until
> that work is done. :)

Sure. Fixing the regression is more urgent.

> >
> > On Thu, Dec 28, 2023 at 4:58=E2=80=AFAM Yu Kuai <yukuai1@huaweicloud.co=
m> wrote:
> >>
> >> From: Yu Kuai <yukuai3@huawei.com>
[...]
> > I found prepare_to_stop_sync_thread very hard to reason. Please try to
> > rephrase the comment or refactor the code. Maybe it makes sense to put
> > the following logic and its variations to a separate function:
> >
> >          if (prepare_to_stop_sync_thread(mddev, false)) {
> >                  wait_event(resync_wait, sync_thread_stopped(mddev, NUL=
L));
> >                  mddev_lock_nointr(mddev);
> >          }
>
> I can do this, but there are 5 callers and only two of them can use the
> separate caller. Pehaps something like this?
>
> void stop_sync_thread(struct mddev *mddev, bool wait_sb)
> {
>         if (prepare_to_stop_sync_thread(mddev, wait_sb)) {
>                 wait_event(resync_wait, ...);
>                 if (!wait_sb) {
>                         mddev_lock_nointr(mddev);
>                         return;
>                 }
>         }
>
>         if (wait_sb) {
>                 wait_event(sb_wait, ...);
>                 mddev_lock_nointr(mddev);
>         }
> }

I don't really like this version either. Let's think more about this
after fixing the dm-raid regressions.

Thanks,
Song

>
> int stop_sync_thread_interruptible(struct mddev *mddev, bool check_sync_s=
eq)
> {
> ...
> }

