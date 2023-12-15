Return-Path: <linux-kernel+bounces-1824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6D1D81548A
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 00:31:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14C201C23AB8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 23:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1851A30138;
	Fri, 15 Dec 2023 23:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="svkCN4ao"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654202C699;
	Fri, 15 Dec 2023 23:31:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAEEBC433C8;
	Fri, 15 Dec 2023 23:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702683077;
	bh=8vuBe28Hp3dJiXwpDuxt10walGUsS6E6bLz5BamOg38=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=svkCN4aoTr0Nau1NuvvW1ehkW4tGbbX58IKkV3kMRark4x2lk1FX57a2IBN4nx/7i
	 qJEF1xSsKnm2pzQEVN8HcI/P9ihiEtUzpjBv0VnwKGCqFBxuTII9p6IMSQkwAaUKlW
	 KXT3dwT9jZQdEBbr0rBVcVl4BtjEZ63ZF/sntsSATN850a0+Wzo/UT/mcmf8Eo0zl5
	 WsrFIfLiucJVFDvHgW/ZVO9Vb/wgaKhj1FApySVVGxUHuXnEcv6P09bgy51YAi9YGl
	 LxoWb76ykMR03r0gys2L5N5SMaUL1qUoIpktuHZ/cBsc4MlgPYES3wnXPgUMMAq53g
	 p9h024NCJrOjg==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-50bdec453c8so1359924e87.3;
        Fri, 15 Dec 2023 15:31:17 -0800 (PST)
X-Gm-Message-State: AOJu0YxYNKIxZdcKgQ+rPhoB56YwKA9M1dQxSGq7PLy0kJu/0rBEOo7c
	utqWLOzTPcdauqDmNNPMtJIjfkFy10EAbHs0d3E=
X-Google-Smtp-Source: AGHT+IGvN1Aom7Bvl1CDgcH/Hk02HUZayJ54ctvNg7jL/MLayG/FUhxNCVMQTCy6+9FWVxEsCetyxQpbfTgrxMe6SSw=
X-Received: by 2002:ac2:419a:0:b0:50d:13f5:9bca with SMTP id
 z26-20020ac2419a000000b0050d13f59bcamr5327104lfh.63.1702683076075; Fri, 15
 Dec 2023 15:31:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231214151458.28970-1-gouhao@uniontech.com>
In-Reply-To: <20231214151458.28970-1-gouhao@uniontech.com>
From: Song Liu <song@kernel.org>
Date: Fri, 15 Dec 2023 15:31:04 -0800
X-Gmail-Original-Message-ID: <CAPhsuW5Oj67XR6EhndSXCkd52h8P4nAXipxrhG31fy7YNOZg6g@mail.gmail.com>
Message-ID: <CAPhsuW5Oj67XR6EhndSXCkd52h8P4nAXipxrhG31fy7YNOZg6g@mail.gmail.com>
Subject: Re: [PATCH] md/raid1: remove unnecessary null checking
To: Gou Hao <gouhao@uniontech.com>
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org, 
	gouhaojake@163.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2023 at 7:15=E2=80=AFAM Gou Hao <gouhao@uniontech.com> wrot=
e:
>
> If %__GFP_DIRECT_RECLAIM is set then bio_alloc_bioset will always
> be able to allocate a bio. See comment of bio_alloc_bioset.
>
> Signed-off-by: Gou Hao <gouhao@uniontech.com>

Applied to md-next. Thanks!

Song

> ---
>  drivers/md/raid1.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
> index 35d12948e0a9..e77dc95d4a75 100644
> --- a/drivers/md/raid1.c
> +++ b/drivers/md/raid1.c
> @@ -1126,8 +1126,6 @@ static void alloc_behind_master_bio(struct r1bio *r=
1_bio,
>
>         behind_bio =3D bio_alloc_bioset(NULL, vcnt, 0, GFP_NOIO,
>                                       &r1_bio->mddev->bio_set);
> -       if (!behind_bio)
> -               return;
>
>         /* discard op, we don't support writezero/writesame yet */
>         if (!bio_has_data(bio)) {
> --
> 2.34.1
>
>

