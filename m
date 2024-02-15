Return-Path: <linux-kernel+bounces-67775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A405857081
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 23:24:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0428A1C20C33
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 22:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F47B1420D1;
	Thu, 15 Feb 2024 22:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gBTp26tU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858D6145326;
	Thu, 15 Feb 2024 22:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708035888; cv=none; b=mGOMHC7PUe2q6ci2nympFzggrZowyRa9a9VFeEXIwrGJ3l3Xqnw5XM09wFpafTI63vOc4QjTicI8zK0fXjtIakWPOfMflBT8hpaIOHoUcDhFLUtm/O4wJVNAWjIHjZOqzJUwDSaEGoXhkrbqZaLHV2WntdfgWr3LkAi+7nL3fKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708035888; c=relaxed/simple;
	bh=f76X0AcaJVYW7+cjrWNquEpcNbSHpUPoRnOE346GUTY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cWHhdLq2TgHvcLSUoU3xYj3q1M/CprpOk6DG1jiV1lhmiUGL9raS5RzExoEB+C8+HTzAQgbdy0W13gEIqTYzhpnCqOodR+tQOwElzbfmQ7rYrLyujlCzZ041oG9wDQHuEpZnTam8Yd82ojMY4axomqlCHPGInBWhL4PwvAOTR8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gBTp26tU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 258A3C433B1;
	Thu, 15 Feb 2024 22:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708035888;
	bh=f76X0AcaJVYW7+cjrWNquEpcNbSHpUPoRnOE346GUTY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=gBTp26tUwNk41M6xgvz8ZeU+B1zWTnfMr1YmwnI31pxXz1qMOONUC74vsh5069YNm
	 mQsL4VLz2NDt0r5EZIuJgP0QSetIzPW1qKT0NzXVFUxqgp7ZbUrCZMFyIkkTkR4rWC
	 5b4qxquRmT5tPuSgrLlM5D4dcKi8rKfWFhQyetp3UeCHWsavaAFw7porbIGeX+hDsr
	 Cyc6nNScZaYH820pDa7GUD3QatVYqsCtQj95rmCTQ1K7v5+JKcNoVQa7fyksnnf9k9
	 bjI8S6/nuM2ZidZmspuimsilt72f/IkSu/kcFRUC/ULfphRDoEYSqx8slvom8p2CCd
	 Nu9Stq09QufVw==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-511831801f3so1480702e87.2;
        Thu, 15 Feb 2024 14:24:48 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVd5TlTiQQn3g1pU+vecBXJ0HKmaGsC2lHOCtN48I4KHRm+DSSslojgG/LFSSTI+N7Kw7iGzNPNvs2E0/qtj1MjmSktZAFYOfsvTrc/Eoo019K/bGkCBZQqI8v7xpewpXJDdnXpP26wOg==
X-Gm-Message-State: AOJu0Yy7+/hjVLhzYjVOzRfm2Qt4oQkgkGzeDkpArfJUyewrDGGGlodn
	vigyeR95GKVmqEEZ9dIODZ2ydVXsiKoTEjktXaPC6XFsAMha9sLtM+C3a0o8Cyn6fTJiVJxp4D6
	1lfx4nyGD/C1pcJG8Nbu9/qpuuCw=
X-Google-Smtp-Source: AGHT+IGmAosyPljzB5tpeW+wijXZ0l9rjM3TdMArpY/0JumvOxRKdXT6vWsamHhqT8Y9VwNQwEXiPmSBIbFwMthAbN0=
X-Received: by 2002:ac2:46c6:0:b0:511:7202:3938 with SMTP id
 p6-20020ac246c6000000b0051172023938mr2220592lfo.63.1708035886253; Thu, 15 Feb
 2024 14:24:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240201092559.910982-1-yukuai1@huaweicloud.com>
In-Reply-To: <20240201092559.910982-1-yukuai1@huaweicloud.com>
From: Song Liu <song@kernel.org>
Date: Thu, 15 Feb 2024 14:24:34 -0800
X-Gmail-Original-Message-ID: <CAPhsuW7u1UKHCDOBDhD7DzOVtkGemDz_QnJ4DUq_kSN-Q3G66Q@mail.gmail.com>
Message-ID: <CAPhsuW7u1UKHCDOBDhD7DzOVtkGemDz_QnJ4DUq_kSN-Q3G66Q@mail.gmail.com>
Subject: Re: [PATCH v5 00/14] dm-raid/md/raid: fix v6.7 regressions
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: mpatocka@redhat.com, heinzm@redhat.com, xni@redhat.com, 
	blazej.kucman@linux.intel.com, agk@redhat.com, snitzer@kernel.org, 
	dm-devel@lists.linux.dev, yukuai3@huawei.com, jbrassow@f14.redhat.com, 
	neilb@suse.de, shli@fb.com, akpm@osdl.org, linux-kernel@vger.kernel.org, 
	linux-raid@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 1, 2024 at 1:30=E2=80=AFAM Yu Kuai <yukuai1@huaweicloud.com> wr=
ote:
>
[...]
>
> [1] https://lore.kernel.org/all/CALTww29QO5kzmN6Vd+jT=3D-8W5F52tJjHKSgrfU=
c1Z1ZAeRKHHA@mail.gmail.com/
>
> Yu Kuai (14):
>   md: don't ignore suspended array in md_check_recovery()
>   md: don't ignore read-only array in md_check_recovery()
>   md: make sure md_do_sync() will set MD_RECOVERY_DONE
>   md: don't register sync_thread for reshape directly
>   md: don't suspend the array for interrupted reshape
>   md: fix missing release of 'active_io' for flush

Applied 1/14-5/14 to md-6.8 branch (6/14 was applied earlier).

Thanks,
Song


>   md: export helpers to stop sync_thread
>   md: export helper md_is_rdwr()
>   dm-raid: really frozen sync_thread during suspend
>   md/dm-raid: don't call md_reap_sync_thread() directly
>   dm-raid: add a new helper prepare_suspend() in md_personality
>   md/raid456: fix a deadlock for dm-raid456 while io concurrent with
>     reshape
>   dm-raid: fix lockdep waring in "pers->hot_add_disk"
>   dm-raid: remove mddev_suspend/resume()
>
>  drivers/md/dm-raid.c |  78 +++++++++++++++++++--------
>  drivers/md/md.c      | 126 +++++++++++++++++++++++++++++--------------
>  drivers/md/md.h      |  16 ++++++
>  drivers/md/raid10.c  |  16 +-----
>  drivers/md/raid5.c   |  61 +++++++++++----------
>  5 files changed, 192 insertions(+), 105 deletions(-)
>
> --
> 2.39.2
>
>

