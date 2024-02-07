Return-Path: <linux-kernel+bounces-57229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE4C884D55C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 23:07:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 383841F2B23D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 22:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EC54149DED;
	Wed,  7 Feb 2024 21:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="SNqUyqqT"
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A252C136668
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 21:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707341284; cv=none; b=pPEnNbzBA7eythAtSQ2qYkh1z+WJpotjnP9Sn/ae+tnGxolc/dajgRYNLXFkeI9AY4fbcUDdKXoBbAV2wD6s28dP0l0t+9lAxvCc/+9x6hUeOfOeF8Kru73zXPi8W5WI6P5bG0ztNk+6d2uwZkQQUh804WV5SNpaPVWW5zmKFzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707341284; c=relaxed/simple;
	bh=q31bgicYaWHpH21aqzUEXUC1pWsCHfkb+EzH4p0wWdM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s79AM1dZfiCvKBgfcs/jv/0thgh28uLCZh8+9AecK3vH028UE1/ZdszCOV5GbZfSRjlpcKJmRq0mY+RQEVe9uFHGDufsf6oDRBIrus0ggJQHLrl2pDD7zYPfcwHlB+MFlPcVo+zjUnq6t89tqzwIotsE7+eYgRcNSXrgAfZ5smQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=SNqUyqqT; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-db3a09e96daso1173232276.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 13:28:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1707341280; x=1707946080; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WNi99T1nROigThww20pAjGWc1T88MfKDCoW7KDY0Ayk=;
        b=SNqUyqqTOxpdTA/yLmR6oAeDQoJwJY4Bzw1hxgCmCDqrMrzWw8qgJolJwdtMTUq1Vu
         pn9K6qYwVFGpYZMW+dlUuJBAdXDh4uSHnti3lR8DlG9u4xtWiXJPCE1ave2a+gA1H2ry
         slMNqDfAUAKLcC/j6y6qIsClxNEXpL6cb7KnKnsE4+wU+spGUbrCd0e2/z6qJ5IzrBV7
         OljDsr5j2H9H0vW8FnYU0HI/0i4DBccF7zf69Ww1TkzlQb8iiJK08w0ShlvxHwXLR9Yd
         khUZSnMRQP6XYep4EeR4bmbIa3S/qAGU5LEHZn10vUxbLohw9meqkU3ViYCEBl8YaV5F
         MSJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707341280; x=1707946080;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WNi99T1nROigThww20pAjGWc1T88MfKDCoW7KDY0Ayk=;
        b=exF6QyFPwpp1+yMHK+WGP7Qh/Wbn02dxa7mFAod6HJNsiutuYrwCTmBJOete+3ENsM
         4LuGt20XbM+3DfzzUljZVkcffC9TKCgQXHlp2I/txc913YMK2PgeeKmAKuxRB0EYN000
         KB+O2phl/CNSQYoNzrp+oUr/0Z0siBqvMcvU4lg7kD/Tqvwlvx6D8xIIql+Bjd5xm9Wc
         ERVc1Pa2C5lq3dXpr+Pb1exstuEDL8Qb8AbJy4wniyYZeVU3RGXfOLsPeDWdvoKfNnWY
         OiZcM/z7pejoNbrsFoVTmbg4aEAM9FqFX3IoGw2hUrVnvXAA6P3LsQWH/8zKXWDEThov
         mA0A==
X-Gm-Message-State: AOJu0Yy3bkyNm39mXJMiGNPgrtlFkwp57O4HiTllj1AEg+/XvmvJobvw
	zDDrOgs1qBn6PsxjDfHjFyTF14dxhPPPXUtNsH9zF6iDV0kZgzqgXWd9rOSe6b4ib4q3NvJiPY1
	ejrQdINxvSE56pKnM6ghcsmARnbShk0nb3Ood
X-Google-Smtp-Source: AGHT+IFHQUUb9rxkBdli0M+OpewK7V4N8lqOlkAbunqI5nxoYR2FGdUbo01LW7S6k0x2Sf6cX8+w3VR5e+NNNnIOPHo=
X-Received: by 2002:a25:6843:0:b0:dc2:4397:6add with SMTP id
 d64-20020a256843000000b00dc243976addmr5669174ybc.32.1707341280567; Wed, 07
 Feb 2024 13:28:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240207101929.484681-1-leitao@debian.org> <20240207101929.484681-8-leitao@debian.org>
In-Reply-To: <20240207101929.484681-8-leitao@debian.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 7 Feb 2024 16:27:49 -0500
Message-ID: <CAM0EoMkRZJicRtYKJcOso0dZNGVM48HHqKag3AoF52zB_PRupA@mail.gmail.com>
Subject: Re: [PATCH net v2 7/9] net: fill in MODULE_DESCRIPTION()s for net/sched
To: Breno Leitao <leitao@debian.org>
Cc: kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com, 
	edumazet@google.com, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	horms@kernel.org, andrew@lunn.ch
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 7, 2024 at 5:19=E2=80=AFAM Breno Leitao <leitao@debian.org> wro=
te:
>
> W=3D1 builds now warn if module is built without a MODULE_DESCRIPTION().
> Add descriptions to the network schedulers.
>
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  net/sched/em_canid.c | 1 +
>  net/sched/em_cmp.c   | 1 +
>  net/sched/em_meta.c  | 1 +
>  net/sched/em_nbyte.c | 1 +
>  net/sched/em_text.c  | 1 +
>  net/sched/em_u32.c   | 1 +
>  6 files changed, 6 insertions(+)
>
> diff --git a/net/sched/em_canid.c b/net/sched/em_canid.c
> index 5ea84decec19..c1852d79c00a 100644
> --- a/net/sched/em_canid.c
> +++ b/net/sched/em_canid.c
> @@ -222,6 +222,7 @@ static void __exit exit_em_canid(void)
>         tcf_em_unregister(&em_canid_ops);
>  }
>
> +MODULE_DESCRIPTION("CAN Identifier comparison network helpers");

ematch classifier to match CAN IDs embedded in skb CAN frames

>  MODULE_LICENSE("GPL");
>
>  module_init(init_em_canid);
> diff --git a/net/sched/em_cmp.c b/net/sched/em_cmp.c
> index f17b049ea530..285b36c32c16 100644
> --- a/net/sched/em_cmp.c
> +++ b/net/sched/em_cmp.c
> @@ -87,6 +87,7 @@ static void __exit exit_em_cmp(void)
>         tcf_em_unregister(&em_cmp_ops);
>  }
>
> +MODULE_DESCRIPTION("Simple packet data comparison network helpers");

ematch classifier for basic data types(8/16/32 bit) against skb data

>  MODULE_LICENSE("GPL");
>
>  module_init(init_em_cmp);
> diff --git a/net/sched/em_meta.c b/net/sched/em_meta.c
> index 09d8afd04a2a..cab43356824a 100644
> --- a/net/sched/em_meta.c
> +++ b/net/sched/em_meta.c
> @@ -1006,6 +1006,7 @@ static void __exit exit_em_meta(void)
>         tcf_em_unregister(&em_meta_ops);
>  }
>
> +MODULE_DESCRIPTION("Metadata comparison network helpers");

ematch classifier for various internal kernel metadata, skb metadata
and sk metadata

>  MODULE_LICENSE("GPL");
>
>  module_init(init_em_meta);
> diff --git a/net/sched/em_nbyte.c b/net/sched/em_nbyte.c
> index a83b237cbeb0..34c6e8c8b695 100644
> --- a/net/sched/em_nbyte.c
> +++ b/net/sched/em_nbyte.c
> @@ -68,6 +68,7 @@ static void __exit exit_em_nbyte(void)
>         tcf_em_unregister(&em_nbyte_ops);
>  }
>
> +MODULE_DESCRIPTION("Multi byte comparison network helpers");

ematch classifier for arbitrary skb multi-bytes

>  MODULE_LICENSE("GPL");
>
>  module_init(init_em_nbyte);
> diff --git a/net/sched/em_text.c b/net/sched/em_text.c
> index f176afb70559..7a89db8e5409 100644
> --- a/net/sched/em_text.c
> +++ b/net/sched/em_text.c
> @@ -147,6 +147,7 @@ static void __exit exit_em_text(void)
>         tcf_em_unregister(&em_text_ops);
>  }
>
> +MODULE_DESCRIPTION("Textsearch comparison network helpers");

ematch classifier for embedded text in skbs

>  MODULE_LICENSE("GPL");
>
>  module_init(init_em_text);
> diff --git a/net/sched/em_u32.c b/net/sched/em_u32.c
> index 71b070da0437..ea32e4e12a99 100644
> --- a/net/sched/em_u32.c
> +++ b/net/sched/em_u32.c
> @@ -52,6 +52,7 @@ static void __exit exit_em_u32(void)
>         tcf_em_unregister(&em_u32_ops);
>  }
>
> +MODULE_DESCRIPTION("U32 Key comparison network helpers");

ematch skb classifier using 32 bit chunks of data

>  MODULE_LICENSE("GPL");
>
>  module_init(init_em_u32);
> --
> 2.39.3
>

