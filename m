Return-Path: <linux-kernel+bounces-139379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91BD88A023B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 23:35:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55F78288694
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 21:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD79F184111;
	Wed, 10 Apr 2024 21:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jg8erTdu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271D8181CE4;
	Wed, 10 Apr 2024 21:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712784929; cv=none; b=k/DGcBo0YeCMpfBORw7IQBYHdRzgphjGDNy1+CKe5Tdd7yW5SkY8iXH57NEOrQmu1eaqxJZa3uRIgIqiMc0due3S8KWFMyMKkYwHhyCiSkQ2E0EyBmyhdA24oe151vS0lAu6/9eBIhWBaPVmlq7a6/sHuSw2Rwidy0LCV/lrdTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712784929; c=relaxed/simple;
	bh=OXgBqlxk0qfqjPkRHk2SQ7gLnxvgx2Y9gMbYHf2KM4A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ip76GaWQH0a4wlq8Up5fpM02LKi0YcQognKlDqi46XZGgPwaFJGpuWEacZl1hjN78nqcSerpi+/v6AeqULpFqe8DInvgmG/OVY/LGdEYegpMF+px7fyg071RfnhWw5j0pVJIDthBVyA46U70XY9Q/fgFEyvgtg7h4lrLl6qlvug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jg8erTdu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF0AAC433F1;
	Wed, 10 Apr 2024 21:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712784928;
	bh=OXgBqlxk0qfqjPkRHk2SQ7gLnxvgx2Y9gMbYHf2KM4A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Jg8erTduvZwcjaZJ0Id3S7iHPRio9XT7hrg3QZgtjc+l1rc/WUyIuXTNxEgUPeqP7
	 8j6ye0W7zGuDAwZx1iTY8Zu9mONJR/ol1Mu1W5P/NZKdDJS1ptXIfNRBhSL9EyG+eh
	 BMABOmOJzcRK2QsRjm21cDzPjssR2AcjxIlwTkaKz7/VUzOIIB2i3oAh0HoxXVoTUF
	 cLEcj2MksNJ/5rM3wlo0lr6qzbWy4AuHamTrOELIY3+hULbuzbFvk6HrHfqRw1kIA4
	 iBQmq1R6xSuSG9s+BkpPENsDsNM/3obksxP9vtDcRRRDAtZb31/4Z5Pcp8kIpFbCc/
	 FGCkYJs25FlTw==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-516cbf3fd3dso8348786e87.2;
        Wed, 10 Apr 2024 14:35:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW/Ro3Ykewu/4TYjBlYEnLoGAmji/2f2ZpNsDOtOW1hc6kjH989nc0sg+1B7uJ5hHbNZ9+IPpEBw4DPjpjoz4yAqxTr6lHQT7K+PgZjv/0WvZrOYRYHt0Zx8oAsiQ1SEoWzZOuZPGVffTScMmp12sxTQ/joRnXpd0WLrNNDyqi7wU3SQePU
X-Gm-Message-State: AOJu0Yy/Dvwbsj+FCjSQWkU0Xr8ORzNUw6iTovbOl7l6ZLN4zlxRc/RZ
	8phC6eQ5rZlyluAm0bnGU4ALnafoi1qt3IRhVcEjzLXTAhgX7LAEQP3+Qh+SOd2ALOebTeJrlzo
	o2yQplQTVE6B7IfFVzDfxhL7eqwc=
X-Google-Smtp-Source: AGHT+IGLYP6IXrn5tCbA98R6PCrGHmaai+mo4RkNrl8YoflBpWV+5J4Q5aOsRBZPCvCQt8Iw/pw55F/JZnjRMqEHeZg=
X-Received: by 2002:a05:6512:2c95:b0:516:c600:64e8 with SMTP id
 dw21-20020a0565122c9500b00516c60064e8mr3017080lfb.1.1712784927037; Wed, 10
 Apr 2024 14:35:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117031946.2324519-1-linan666@huaweicloud.com>
In-Reply-To: <20240117031946.2324519-1-linan666@huaweicloud.com>
From: Song Liu <song@kernel.org>
Date: Wed, 10 Apr 2024 14:35:15 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5uWPGUNCf_49Vo5paX+T05XnJRR4_PzKyms3g9eEa6Dg@mail.gmail.com>
Message-ID: <CAPhsuW5uWPGUNCf_49Vo5paX+T05XnJRR4_PzKyms3g9eEa6Dg@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] md: fix is_mddev_idle()
To: linan666@huaweicloud.com
Cc: axboe@kernel.dk, linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, yukuai3@huawei.com, yi.zhang@huawei.com, 
	houtao1@huawei.com, yangerkun@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 16, 2024 at 7:23=E2=80=AFPM <linan666@huaweicloud.com> wrote:
>
> From: Li Nan <linan122@huawei.com>
>
> Changes in v4:
>  - patch 2, add the check of 'init', update last_events even if iostat
>    is disabled.
>
> Li Nan (2):
>   md: Fix overflow in is_mddev_idle
>   md: don't account sync_io if iostats of the disk is disabled

Applied to md-6.10. Thanks!

Song

