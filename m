Return-Path: <linux-kernel+bounces-155957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0E5D8AFBB7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 00:29:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E52A289F52
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 22:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55BAB143C48;
	Tue, 23 Apr 2024 22:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eTs8TMTi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932A585274;
	Tue, 23 Apr 2024 22:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713911379; cv=none; b=OT8iWDdD6huWpTCydYkcJze8kTVHc5Ue6hNkPVmZl/5WMw5qCRkv/BhS44f1DIro6wtlUmc1l+w17gDeJjQf2yB4aVwGNVu+ObnvkngO/+aAm3OzotDs70U+sCeH8tVvIiXqus7hvXtYcmn1a15zbG3M9llV/INkmw1XaRw6YHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713911379; c=relaxed/simple;
	bh=QRDUbZack2LxSr01yiW9w+SrJhQfWuQp7YFWGj5HHZ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t+S3xIJ8ipB0M3E7AK1qgtLtbRApPjeoqk0FLdsvvpvr33Up8zWmHxzAe5oCsgz3DvhcndgSHBUtHps5QhniIt+q/pRg0gbUI25GWA2ZYYNTejYPYYY2015KjHe2s/ZluUBTKY0VRutQCsQc9qa9fQN4JWqrlMv6U+WJr1zjtXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eTs8TMTi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15126C32781;
	Tue, 23 Apr 2024 22:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713911379;
	bh=QRDUbZack2LxSr01yiW9w+SrJhQfWuQp7YFWGj5HHZ0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=eTs8TMTi1ZPYgxFP+M2Mxp83iY8Vf5DsBVFbudHno7/HlGlHl+zmCH/J07JAzqPkC
	 Cdu/Y1Rh91qlY/Wv9X4BriovBQSGdEO5hdkTCrtP2ucaiynnMNZdsg1Kia9NAimPQI
	 N4cqRB4kY8ISE6qTmUhpDp15BW2yPF+QSM/pZ2Eq4Fz8am/MfxSyJnLPAdnA7sy2vl
	 0DlLTeqF9LbTih0RLY3Vc0VH8WvYnC4qjtM0dIusFxjvvgcCUiLJ0VZtUZy094Yy+q
	 zQRrL//Ju2cdG6Ip5eHNNURt/blIMDuTLjGsGBmFstcIBEP/vgjXcgmWl09HnClqcq
	 o5rIUGSIlLOGw==
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2dd64d6fe94so35969101fa.0;
        Tue, 23 Apr 2024 15:29:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXXb/mLZ+Soh4tm19YOWXttnKBwSTUBZtKoA24qF4xMRmMFOYujKdVg/KhyKRuOnDq+dwlYQXcnltBZO7bXLZTZ2lcbkPAiRB2BZVvBW6ytCfzuVec6e5fHlWxvHhONUaAPgFal5qiK7Q==
X-Gm-Message-State: AOJu0Yyl6ap9ZEf7TXgOsKx8pe0iYzkI33qCJTJt25AynGDq8atm/3iR
	wbr88frsMz0RJCcjpYyCwDjRPkTSnIaADzTDlCnmPH5SqPTTCVytncikwdFIjptzzmw4YNF+ffy
	t9ytCcBzUxdWC8jhNnUBTs/bSJSE=
X-Google-Smtp-Source: AGHT+IEE8MjxKalHQM8XdEgNUc91LVZWM/6pPqr/Yz2ffINmdv3dae0mfTJKFx5pXn7+qu/Oo3vKQHFmg00ZfnrslAQ=
X-Received: by 2002:a2e:3c17:0:b0:2d6:afdc:2a18 with SMTP id
 j23-20020a2e3c17000000b002d6afdc2a18mr308281lja.16.1713911377371; Tue, 23 Apr
 2024 15:29:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240422065824.2516-1-yukuai1@huaweicloud.com>
In-Reply-To: <20240422065824.2516-1-yukuai1@huaweicloud.com>
From: Song Liu <song@kernel.org>
Date: Tue, 23 Apr 2024 15:29:25 -0700
X-Gmail-Original-Message-ID: <CAPhsuW59dA2y9vLdJMzMpP_NcDRR_TUFz6Jk8mZLziWs94vaTQ@mail.gmail.com>
Message-ID: <CAPhsuW59dA2y9vLdJMzMpP_NcDRR_TUFz6Jk8mZLziWs94vaTQ@mail.gmail.com>
Subject: Re: [PATCH -next] md: fix resync softlockup when bitmap size is less
 than array size
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: yukuai3@huawei.com, linan122@huawei.com, linux-raid@vger.kernel.org, 
	linux-kernel@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 22, 2024 at 12:07=E2=80=AFAM Yu Kuai <yukuai1@huaweicloud.com> =
wrote:
>
> From: Yu Kuai <yukuai3@huawei.com>
>
> Is is reported that for dm-raid10, lvextend + lvchange --syncaction will
> trigger following softlockup:
>
> kernel:watchdog: BUG: soft lockup - CPU#3 stuck for 26s! [mdX_resync:6976=
]
> CPU: 7 PID: 3588 Comm: mdX_resync Kdump: loaded Not tainted 6.9.0-rc4-nex=
t-20240419 #1
> RIP: 0010:_raw_spin_unlock_irq+0x13/0x30
> Call Trace:
>  <TASK>
>  md_bitmap_start_sync+0x6b/0xf0
>  raid10_sync_request+0x25c/0x1b40 [raid10]
>  md_do_sync+0x64b/0x1020
>  md_thread+0xa7/0x170
>  kthread+0xcf/0x100
>  ret_from_fork+0x30/0x50
>  ret_from_fork_asm+0x1a/0x30
>
> And the detailed process is as follows:
>
> md_do_sync
>  j =3D mddev->resync_min
>  while (j < max_sectors)
>   sectors =3D raid10_sync_request(mddev, j, &skipped)
>    if (!md_bitmap_start_sync(..., &sync_blocks))
>     // md_bitmap_start_sync set sync_blocks to 0
>     return sync_blocks + sectors_skippe;
>   // sectors =3D 0;
>   j +=3D sectors;
>   // j never change
>
> Root cause is that commit 301867b1c168 ("md/raid10: check
> slab-out-of-bounds in md_bitmap_get_counter") return early from
> md_bitmap_get_counter(), without setting returned blocks.
>
> Fix this problem by always set returned blocks from
> md_bitmap_get_counter"(), as it used to be.
>
> Noted that this patch just fix the softlockup problem in kernel, the
> case that bitmap size doesn't match array size still need to be fixed.
>
> Fixes: 301867b1c168 ("md/raid10: check slab-out-of-bounds in md_bitmap_ge=
t_counter")
> Reported-and-tested-by: Nigel Croxon <ncroxon@redhat.com>
> Closes: https://lore.kernel.org/all/71ba5272-ab07-43ba-8232-d2da642acb4e@=
redhat.com/
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Applied to md-6.10. Thanks!

Song

