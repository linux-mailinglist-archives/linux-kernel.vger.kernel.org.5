Return-Path: <linux-kernel+bounces-62548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC0248522A3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 00:38:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 740BB1F23ACB
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 23:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 728175024D;
	Mon, 12 Feb 2024 23:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KC6g57XH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD764F894;
	Mon, 12 Feb 2024 23:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707781030; cv=none; b=g34Hc+xR/DFIUQwi8Ic/oPLleoY+PZjl8bzGvjVba97gBk1FS9ZCcLHrFlFtVjNGBMf4JJbfVTT7ZSPHRYnTh+DPSgMPtrtdYRe2/DehHYBz+JNfkN3NhSY41rJJhUD7uKxlqIhw2GtVuHJBtd2RaV3HEvokaHxrMoE+NYp/F7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707781030; c=relaxed/simple;
	bh=m7SE+hlCtBtb3IlhPvvEXPX6CE31ZA44ZY0MoUwNa78=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D1+Gl20tP9eRf4ClfnZ8EAmT5iT5y4wibMZfHLeWn+WRS9g6iT+9nnGEOz3EHanoDyabSxH6mpvi9o/Gy+zi/UFrz6vnexwGI/ZrALtm8k6EPEL4sVWiyUTa20YsmuH9Yli7+pL4jyyAIXdLQdt89eGlWL4ozxcyZC8dDHGWTfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KC6g57XH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C790C43390;
	Mon, 12 Feb 2024 23:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707781030;
	bh=m7SE+hlCtBtb3IlhPvvEXPX6CE31ZA44ZY0MoUwNa78=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=KC6g57XHdGbJo73oXcNvpOjej08py6XiO+tc2vsK4lOiYHFm7n5d+rxU9PETChsAP
	 RGmwRJxeVv+vaU5BwgzuGdjQnDwZ8TjD/4t7DznkkdFUlq8eZw53h1sipgJMsgtZ4R
	 6TCeUTvdo15Zwbz/iDca6ZltoICEuPPU62gGKDkc1Wl7H7mHax9bqST9HuPpRyza1N
	 5LH2M1FEuZURLiB8xnYHk5Cs9vxM71OXJQtNS7+dKKI3vfI0eB2f/6UwOSTsV9LewK
	 F9gnNNw5r8ULkjbljxtoA9Tku/h4Ng+6BlMzKV0/SVyRXTmYJLVMVdfm1qCPMh0CPX
	 uqlWN2+8Mj9LA==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-51197ca63f5so287708e87.1;
        Mon, 12 Feb 2024 15:37:10 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU7l5TTxRI7xE4Bi2Z6wwzFG3knQrHyEgpzdSIfjjaN04gkIkFGurRXjC3RbiuKh4xVFTttIETey8n98xEBvT4JUj3beBfAd/vUVg+p0NSyZzXaipfZFjejY0vuBhyQmi6HZU1vUTxGhg==
X-Gm-Message-State: AOJu0Yx72WzWC1iqDKoe9ZtmoRUDQWL1VzXNX+DPMeAUdVJ5Ied+lyaP
	0O2McriJoiOi4I/GR6itlonzSjqDOpwhI8DfrO6uYW7mlMkpYfnwycIpJponrsxzNsFrlIuekug
	BdreI2pMvZJb4P4nkq8KNg1LYV54=
X-Google-Smtp-Source: AGHT+IEY6ErJSaMUDlk5RYilASd/X1g0R+KLBBByh/07oWdRRXnDCHwLuA55FLF/Z8dy4zSBZbvMZdL1982Em8n+xO8=
X-Received: by 2002:a05:6512:214e:b0:511:82ab:9c88 with SMTP id
 s14-20020a056512214e00b0051182ab9c88mr3668851lfr.68.1707781028513; Mon, 12
 Feb 2024 15:37:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240206085511.2841555-1-linan666@huaweicloud.com>
In-Reply-To: <20240206085511.2841555-1-linan666@huaweicloud.com>
From: Song Liu <song@kernel.org>
Date: Mon, 12 Feb 2024 15:36:56 -0800
X-Gmail-Original-Message-ID: <CAPhsuW49cOvAK2+0c94sp2T3ZLoNf=P89X1tXoq6VNoJWNbv9A@mail.gmail.com>
Message-ID: <CAPhsuW49cOvAK2+0c94sp2T3ZLoNf=P89X1tXoq6VNoJWNbv9A@mail.gmail.com>
Subject: Re: [PATCH v6 0/9] bugfix of MD_CLOSING and clean up md_ioctl()
To: linan666@huaweicloud.com
Cc: mariusz.tkaczyk@linux.intel.com, shli@fb.com, neilb@suse.com, 
	linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org, yukuai3@huawei.com, 
	yi.zhang@huawei.com, houtao1@huawei.com, yangerkun@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Li Nan,

On Tue, Feb 6, 2024 at 1:00=E2=80=AFAM <linan666@huaweicloud.com> wrote:
>
> From: Li Nan <linan122@huawei.com>
>
> Changes in v6:
>  - in patch 2, return directly.
>  - in patch 4, return directly in case GET_DISK_INFO and GET_ARRAY_INFO.
>  - in patch 7, rewrite commit message.
>  - add patch 8, clean up openers check.
>
> Changes in v5:
>  - add patches 1-4 to clean up md_ioct(), pathc 4 can help us clean up
>    local variable 'clear_md_closing'.
>  - in patches 5 and 7, clean up local variable 'clear_md_closing'.
>
> By the way, md_ioctl() is not readable now, I wanna to re-write it later
> to make it only have one 'switch' like other drivers.

Thanks for the patchset, and sorry for the delay.

The patchset looks good to me. However, it doesn't apply to md-6.9
branch. Could you please resend or let me know the base branch/commit
of the set?

Thanks,
Song

