Return-Path: <linux-kernel+bounces-44054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3A4F841CBC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 08:37:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F5DC284564
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 07:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C094855C1B;
	Tue, 30 Jan 2024 07:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c6/UpI4X"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024195467E;
	Tue, 30 Jan 2024 07:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706600245; cv=none; b=NOGj3+axLibIbymFpYf3b3yN4eiZzAITwXR4JRov+rnGNVJhnW+TcVHF9WeQRsi6OZ+/On0UY0AxDzkTxCKTRAM5Z/vY0LuLz3Xj6/tUWrQEdN/FLD+En/OmZd4+NPb2igwFZ1Ozfwf7VBbvY5RkoYXJy++8xT6lL0C50IaGIuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706600245; c=relaxed/simple;
	bh=VyBIx8uQjXCjBEuFOuaNwLSr8JVTC+Gwm801hDkovvw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O+XluhdCUiB7cKgRID0T8yojpxGcuREQ4LpXbdPAvpwluzhUuAFISH3Cy+0LS+X9bVP+pMGlx27ZipsIk0cDIyyuMlpltJt12FkqRY06vMNM0rSqJtuIoTVouF/2JHnTfzFKjFSmavA5Wx/BkHiQ7NrD6mtJVLrIUn2JecQxeks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c6/UpI4X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75D2CC433A6;
	Tue, 30 Jan 2024 07:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706600244;
	bh=VyBIx8uQjXCjBEuFOuaNwLSr8JVTC+Gwm801hDkovvw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=c6/UpI4Xlwxn8S8duuYTlyDfqIin31dM449IdxjYIb8RRq4UucKboaw3JF7crCuMU
	 Ehp6I2OjXtbRfdxcypCiIoKxYrCPSLKxg7y6qjSaZB3Y5H7nYrCMiWPMHOCgy3AWD3
	 Ewyz6KBuarXkFJ/BWofKFftz5mkGDHFSkuSECjNHUFHItV0ACw/k50klbzzSFptuuD
	 iis8NG9+eoa+jSxggjfFK0/0VvF3y3UuJgCJypBZJ0SJ8ROP5cWm/NkG3xNVT7+Bl+
	 S2LOLM9neOcZWd203SQHjiOJKw8EGdKrh5rJvd+Qz+E55ecSXy1nA4jdWCGj1gEong
	 0Uz2Qmkx/uBKQ==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-51114557c77so1890180e87.0;
        Mon, 29 Jan 2024 23:37:24 -0800 (PST)
X-Gm-Message-State: AOJu0YwaQO0XZUhY9/XbujZ59qLbphmbVitjp1UAGZoY6v2TbjezObg2
	VFqTEKIg9zqgtgKEaTFPJTCmwomPDZaM65+HTraXUYRLzlKG1+dbSRhIb1SyTe8xgifWB2SUMoS
	8SwZzBUoj1BXsM36hi4cothXGgTQ=
X-Google-Smtp-Source: AGHT+IHKQjZropPTzgOaCw0EtSlpjJwMBK/cD51osFQf9Ss1tYW/Xnbyxc0hbJjN+c9objJd2F5UTbILv/y5nUF8mVE=
X-Received: by 2002:a05:6512:10c2:b0:510:1487:bcb with SMTP id
 k2-20020a05651210c200b0051014870bcbmr6081674lfg.64.1706600242683; Mon, 29 Jan
 2024 23:37:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240112071017.16313-1-2045gemini@gmail.com>
In-Reply-To: <20240112071017.16313-1-2045gemini@gmail.com>
From: Song Liu <song@kernel.org>
Date: Mon, 29 Jan 2024 23:37:11 -0800
X-Gmail-Original-Message-ID: <CAPhsuW64FjJEqTFKX9WVzrXvC4rpcjojBw5A3StUq0C20F_vyA@mail.gmail.com>
Message-ID: <CAPhsuW64FjJEqTFKX9WVzrXvC4rpcjojBw5A3StUq0C20F_vyA@mail.gmail.com>
Subject: Re: [PATCH v4] md/raid5: fix atomicity violation in raid5_cache_count
To: Gui-Dong Han <2045gemini@gmail.com>
Cc: yukuai3@huawei.com, linux-raid@vger.kernel.org, 
	linux-kernel@vger.kernel.org, baijiaju1990@outlook.com, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 11, 2024 at 11:10=E2=80=AFPM Gui-Dong Han <2045gemini@gmail.com=
> wrote:
>
[...]
>
>         raid5_release_stripe(sh);
> -       conf->max_nr_stripes++;
> +       WRITE_ONCE(conf->max_nr_stripes, conf->max_nr_stripes + 1);

This is weird. We are reading max_nr_stripes without READ_ONCE.

>         return 1;
>  }
>
> @@ -2707,7 +2707,7 @@ static int drop_one_stripe(struct r5conf *conf)
>         shrink_buffers(sh);
>         free_stripe(conf->slab_cache, sh);
>         atomic_dec(&conf->active_stripes);
> -       conf->max_nr_stripes--;
> +       WRITE_ONCE(conf->max_nr_stripes, conf->max_nr_stripes - 1);

Same here.

>         return 1;
>  }
>
> @@ -6820,7 +6820,7 @@ raid5_set_cache_size(struct mddev *mddev, int size)
>         if (size <=3D 16 || size > 32768)
>                 return -EINVAL;
>
> -       conf->min_nr_stripes =3D size;
> +       WRITE_ONCE(conf->min_nr_stripes, size);
>         mutex_lock(&conf->cache_size_mutex);
>         while (size < conf->max_nr_stripes &&
>                drop_one_stripe(conf))
> @@ -6832,7 +6832,7 @@ raid5_set_cache_size(struct mddev *mddev, int size)
>         mutex_lock(&conf->cache_size_mutex);
>         while (size > conf->max_nr_stripes)
>                 if (!grow_one_stripe(conf, GFP_KERNEL)) {
> -                       conf->min_nr_stripes =3D conf->max_nr_stripes;
> +                       WRITE_ONCE(conf->min_nr_stripes, conf->max_nr_str=
ipes);

And here.

>                         result =3D -ENOMEM;
>                         break;
>                 }

Thanks,
Song

