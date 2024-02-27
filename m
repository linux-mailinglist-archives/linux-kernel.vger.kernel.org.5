Return-Path: <linux-kernel+bounces-82465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80D338684FD
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 01:28:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEE93284C10
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 00:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF5E8A23;
	Tue, 27 Feb 2024 00:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NkHvVptb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0218236D;
	Tue, 27 Feb 2024 00:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708993678; cv=none; b=k9HMMIhxBglm6IHfeJMATuNJvyuVPEFxNYI3niwZDa0NwgfdZxr7YOLKYBCjsrOheO7wp+IzQUiC3E1FbT01n/1XI8iiKdw1khYegR3wd886FToVtVMzRf4+vR7guMKdEjAVo8zeOmEDINLQn5QYMm8N+fCnSk6CH06K9OevD5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708993678; c=relaxed/simple;
	bh=C+Zj4ZeRl9xniul0YQKQvDPTEYnuZcbWMVmxB4YKIx4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nqta7OdEIvwP8gtxaLFyYsDQ8UGF9gHs/p5+6u3AdnjXsqi0JvRflQBYF4kInrjSAPaa7oiltB1M5e2zlzdKWialhrq3HJV3By43siSxZ7w3Jhdckw9VrY2tOyDon21SXehK/kpqBjMvGI24KdVQaAIK3B6nX5KWFB8hqPbHvdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NkHvVptb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D53EC433F1;
	Tue, 27 Feb 2024 00:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708993677;
	bh=C+Zj4ZeRl9xniul0YQKQvDPTEYnuZcbWMVmxB4YKIx4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=NkHvVptbCa+YYCoeu9gbS7T8svI//6e2fW16F86blmbRjli3ub+4RuexZOZ44W/HN
	 0eWoIQaG0pMogT43b3pXqApDemu88EaqZM3iEzPWHGSE6Uw+Qh9B1ydgXmA4bn7i4o
	 ugn1NR6NMI+YMfjyvFlmOt0QbMnopgrkNnJYGB+Atrsf97Q0tclPhE9QouoK/l12I7
	 Wgce593jWf3VdRNHrVgIWj9KyHdepJytMeppch5q1Yj/2aJN5BPL6Ox3z3BxIdaZqv
	 MBfK+P6KSwiHlMhSEkhuV4HnGApdkVDNy93RGPSg/MYuFw8uT/t8SDax4bCYYT9ugP
	 KVA4dBDSxArzg==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-512fe342841so1260271e87.0;
        Mon, 26 Feb 2024 16:27:57 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVnVM75WUq9Lu2elP/B9k3462xTefJObiMf6FYdW22FfOPpylt6Wg7WLikeQtk5/DKqsxdNQe1pM2tOw6k5QBibKGktmst0tLJDna2LnSBUJ3jGYnXfkDhAy6b8cUhmJqocOKXE3yEqHw==
X-Gm-Message-State: AOJu0Yw5i+Cxrkb2U50Gh9kmtnUT/Ryg97cdPSFxIbXY8DRNHZqK0VRb
	ytjxCsx72Heiq2/leEg8ZrZIT3yhPk16QobGsNjbTeulsky8lWaX8uXXzgUH/kcdYBY5QHudDrj
	lK07Q7ZSOnSNdBA/BPorLSfMf9Mw=
X-Google-Smtp-Source: AGHT+IEs+1Bn+/oBw+BUvr3HUrMB2elDEsi0IlffSIp5wGuK7riMbQ3u2yWmhC3iYeotiZ8y8N5sey2PafUeH8H9hEI=
X-Received: by 2002:a05:6512:3b07:b0:512:f6d8:834f with SMTP id
 f7-20020a0565123b0700b00512f6d8834fmr2470425lfv.8.1708993675689; Mon, 26 Feb
 2024 16:27:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240222075806.1816400-1-yukuai1@huaweicloud.com>
In-Reply-To: <20240222075806.1816400-1-yukuai1@huaweicloud.com>
From: Song Liu <song@kernel.org>
Date: Mon, 26 Feb 2024 16:27:43 -0800
X-Gmail-Original-Message-ID: <CAPhsuW4JM7YbGtKsd35hNgSsaF2=Er+y5TRNBBRNJDxDWjJ6vQ@mail.gmail.com>
Message-ID: <CAPhsuW4JM7YbGtKsd35hNgSsaF2=Er+y5TRNBBRNJDxDWjJ6vQ@mail.gmail.com>
Subject: Re: [PATCH md-6.9 00/10] md/raid1: refactor read_balance() and some
 minor fix
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: paul.e.luse@linux.intel.com, neilb@suse.com, shli@fb.com, 
	linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org, yukuai3@huawei.com, 
	yi.zhang@huawei.com, yangerkun@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kuai and Paul,

On Thu, Feb 22, 2024 at 12:03=E2=80=AFAM Yu Kuai <yukuai1@huaweicloud.com> =
wrote:
>
> From: Yu Kuai <yukuai3@huawei.com>
>
> The orignial idea is that Paul want to optimize raid1 read
> performance([1]), however, we think that the orignial code for
> read_balance() is quite complex, and we don't want to add more
> complexity. Hence we decide to refactor read_balance() first, to make
> code cleaner and easier for follow up.
>
> Before this patchset, read_balance() has many local variables and many
> braches, it want to consider all the scenarios in one iteration. The
> idea of this patch is to devide them into 4 different steps:
>
> 1) If resync is in progress, find the first usable disk, patch 5;
> Otherwise:
> 2) Loop through all disks and skipping slow disks and disks with bad
> blocks, choose the best disk, patch 10. If no disk is found:
> 3) Look for disks with bad blocks and choose the one with most number of
> sectors, patch 8. If no disk is found:
> 4) Choose first found slow disk with no bad blocks, or slow disk with
> most number of sectors, patch 7.

Thanks for your great work in this set. It looks great.

Please address feedback from folks and send v2. We can still get this in
6.9 merge window.

Thanks,
Song

