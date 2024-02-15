Return-Path: <linux-kernel+bounces-67778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C75D7857088
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 23:28:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D587AB21B99
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 22:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 850AB13DBA4;
	Thu, 15 Feb 2024 22:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MV1Uofan"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58D01419A1;
	Thu, 15 Feb 2024 22:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708036070; cv=none; b=f3lL4PIv5QNfK9tbM/LMsT4DQt45J0007+lqZgMCe9lj/JDIJRuHLvV7rqiBXcCkM13J0pfPLoJxsDmfAsKBs3U9UTvisECxHL7XKptryfMnbId4FXtD0QObXN0/mBA9+sUu0zpqSpz+4Nb+3WaBPsQWyVGV41oCymrcY50iboE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708036070; c=relaxed/simple;
	bh=uvH2i4SVPliKwq4Y+bHK5L9Eh/vCMiyg9iLCm0F+h3U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lXcHQJZBtimynxKY57EbvJe6E9EumWmoA/1wIpI66jYGiKvU7ETTkKH9PpXcwBAKaz9YJ+CxZ9/YzvGfrFln/cf9HilB8kYPFQgwmUtP6pSt/61qKS9A4jU8uX4yM3Xez9icA9FjnjYQBITljL1OPAAoLBcsvH7uGhMUQj4JPTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MV1Uofan; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DD1BC43330;
	Thu, 15 Feb 2024 22:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708036070;
	bh=uvH2i4SVPliKwq4Y+bHK5L9Eh/vCMiyg9iLCm0F+h3U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=MV1UofanRyw8U9jIb/tAYn/gCTMFLFpe/Tf8TO3gruCTWMKmqwN0RqYdEX0l0kyh2
	 IYkwFtVf0+JZhFkdZINhevE2TjEOH0VGex7vjqeZ4K9dhcgnIrJZjLaGnRdJIAneml
	 pPrIbsGqfQtctANE0p6aI5hwSwAOheLElkTfHZTLgvrMC9ye3cetJspnQfAJLjIGJ4
	 40Q9Bgjfjxrp13PErn/1Eotuko7CTn8+rQOx2WaG2cbYFXaW5Q1CFTU2+YE3zuTwJ3
	 uJchtg0B6/Ra6ztXvGVKy7HiTL1jZmd4/mLJ8IChvSU435opBUARdiHWZmZzzohzNi
	 tIsSVBOgNfbLQ==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5128812662eso192646e87.0;
        Thu, 15 Feb 2024 14:27:50 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWBxJ5X9m6BQCeETwMnD//T9Kd345E6EDSYylLtl74HH9bsyX3NcTpwSuLVCsckVjDR6garjLO5IRfnp1RtpKDH+RrQD7MGCzM7L1ssOmUMuG/9gUGBmKHcI/v3tg/TunAs0NKSlkFB6Q==
X-Gm-Message-State: AOJu0Yyhng1Xy9odoY3XuzGVXlExQadDSTwZQh9yU/3qMTznkAZipKqh
	4hXVK51ucho8bxrAV3bULFrVQfs8uwV6Ak55zE0nQZMw1t+fKq1u8MZJPnBGZ9GPJqapXkqWepN
	NFKAs+AXtAzgKyo7JP86IcoWuYDE=
X-Google-Smtp-Source: AGHT+IGC59CIx+18FvhmoXIg3RlOVJ/oIazfClCL//AhJ/1+PEr2ep6lZAuyT2j7MQwdoyVKmli2wj5EYwsFFLYYAfo=
X-Received: by 2002:a05:6512:613:b0:511:62f7:14fa with SMTP id
 b19-20020a056512061300b0051162f714famr2579567lfe.29.1708036068658; Thu, 15
 Feb 2024 14:27:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240201092559.910982-1-yukuai1@huaweicloud.com> <20240201092559.910982-8-yukuai1@huaweicloud.com>
In-Reply-To: <20240201092559.910982-8-yukuai1@huaweicloud.com>
From: Song Liu <song@kernel.org>
Date: Thu, 15 Feb 2024 14:27:37 -0800
X-Gmail-Original-Message-ID: <CAPhsuW6+Sc9VSWoyQ=ydEo+PPNV1Z+1VOBJqhZ3GZTY0UrPKig@mail.gmail.com>
Message-ID: <CAPhsuW6+Sc9VSWoyQ=ydEo+PPNV1Z+1VOBJqhZ3GZTY0UrPKig@mail.gmail.com>
Subject: Re: [PATCH v5 07/14] md: export helpers to stop sync_thread
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
> +
>  static void idle_sync_thread(struct mddev *mddev)
>  {
>         mutex_lock(&mddev->sync_mutex);
> -       clear_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
>
>         if (mddev_lock(mddev)) {
>                 mutex_unlock(&mddev->sync_mutex);
>                 return;
>         }
>
> +       clear_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
>         stop_sync_thread(mddev, false, true);
>         mutex_unlock(&mddev->sync_mutex);
>  }
> @@ -4936,13 +4965,13 @@ static void idle_sync_thread(struct mddev *mddev)
>  static void frozen_sync_thread(struct mddev *mddev)
>  {
>         mutex_lock(&mddev->sync_mutex);
> -       set_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
>
>         if (mddev_lock(mddev)) {
>                 mutex_unlock(&mddev->sync_mutex);
>                 return;
>         }
>
> +       set_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
>         stop_sync_thread(mddev, false, false);
>         mutex_unlock(&mddev->sync_mutex);
>  }

The two changes above (moving set_bit) don't seem to belong
to this patch. If they are still needed, please submit a separate
patch.

Thanks,
Song

