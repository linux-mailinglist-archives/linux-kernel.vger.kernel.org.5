Return-Path: <linux-kernel+bounces-58765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E804E84EB5C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 23:12:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 721B61F29854
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 22:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B0C450275;
	Thu,  8 Feb 2024 22:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="TiF3HWMr"
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE55C4F8AA
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 22:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707430279; cv=none; b=URPYBhFbhqGOysYbXyZnuz0dOx2hgrPKIrb1Ce3QWcso+/K8UKpNBh1jggEXwaD8/KN/O1zLS6jFXlJDxXQM7TtC3f1wm90P5zphqo0sJk8e/8Q3dtcgCoQp6EvWHmS0QOQ9qVS/8tsy/Nyu/yBGpOAWYt4rCN3Ah6x2/h1d5e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707430279; c=relaxed/simple;
	bh=WEf2O+BigS2jZRoOKQXdQYIoHZM4Jwq2kgMcdS0LIGc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hq5hInYrYTEmFk20gLUrcFxxLzKbOTRxhDz3QVhO+D3qSSTisZ9jSmZPuxnSWQE2weF6aciY8HK2rE10cBBtY0mrzXe2wqA1W0I2UNkGlf2clRZgssJrNa/n18lBn5y6sDgd6Zy+Cql5FORd78ot2NckYBFKYUTqJ6/1x6R3YzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=TiF3HWMr; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-dc6d5206e96so324347276.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 14:11:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1707430276; x=1708035076; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mbD3Ab67e0FuudOFI/lHLwL0zswy8Knqo0sCgR8RT4s=;
        b=TiF3HWMr9WL2SGx9LUoHoFYqtaBlWfjZ0vkXvCE3oERG3jQlmLbISOik645lGUUjPN
         FfR/UdV9vxXhmty/V8Jg1JESPNl4lgqbT9R/dGrCsMS0eMUPHcGCYEroj7JDCSqtygEZ
         wp0miv+qrYysUH/YjaygI4+cEwyoMyNJ2p5A62EjUMEu4HgeJN4WsYDXG73a1XxopkmE
         xOtJcmV3hWHWOaROE8D2i8HivQWxusJ+mHaKzbTe3WuPE7nqXI8yRQZwQpBQnmSBIUsQ
         O9vAuFEkEoX1HZ2d/5zUmg2Fi150vQzfis9cdkh3h+YYxphabPW+Ih0SqaRKU32R/IDA
         8rJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707430276; x=1708035076;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mbD3Ab67e0FuudOFI/lHLwL0zswy8Knqo0sCgR8RT4s=;
        b=paWlFItcGyjji7id860s+Tw+tW9Ojk92iMU0VPnS7v01tL2M67/g01mp3YzfBigGGd
         s9/jqCASNAvQbod9sBnM3zXf5ivPBAidl4gr3mx+mgnYlzLInPWZrFgfKvQ1tKkbTGeH
         AcZVVqteQu0LC2waBd84Yqjddi87xOKK5epjsStczQq+B2wy4PVIeifwOwSF6dWR98x0
         4kpRArzZwtr6XTEMW9n5Y9C0nzvBk6AF4fJpTQUSTce1mxguhkvZv0sHaIdNRQ/KXXry
         N/mQI3SKMFBBRvedR9Owch4UAkC82j0Up5Po2pfEq3p/LBmCUV75BjcwLAUH9A9NGm8x
         VU7A==
X-Gm-Message-State: AOJu0YyCvDSwRNncHHCxn8yr0wtEpL1V7VHrC80MjTMNn3QpC6FXlhd9
	QEnWhW4GM3YvHZvaXo7yCHvQfu59QFhURvknX1eh0XskC+y9Cb6rZwY823KQQuZ7jHh67fpdoZY
	zSxj+tHR2OZAP+44bwVJ8p6eb1Wr+Ueebt2go
X-Google-Smtp-Source: AGHT+IH7HT2xjL2wo04Ce3vG2hy8V8F1MsA5zD3w7pmCZFDAtcTdmu8xY+zNdQ7KU7jg1CfLuRNGKPXsey2rtvJaZdE=
X-Received: by 2002:a25:2606:0:b0:dc7:4cb1:6817 with SMTP id
 m6-20020a252606000000b00dc74cb16817mr876351ybm.22.1707430275645; Thu, 08 Feb
 2024 14:11:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208164244.3818498-1-leitao@debian.org> <20240208164244.3818498-8-leitao@debian.org>
In-Reply-To: <20240208164244.3818498-8-leitao@debian.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 8 Feb 2024 17:11:04 -0500
Message-ID: <CAM0EoM=A81V8X-UMAivq_u=52tbv8z+dAzE3TfYG5wqzww6ivg@mail.gmail.com>
Subject: Re: [PATCH net v3 7/9] net: fill in MODULE_DESCRIPTION()s for net/sched
To: Breno Leitao <leitao@debian.org>
Cc: kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com, 
	edumazet@google.com, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	horms@kernel.org, andrew@lunn.ch, f.fainelli@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 8, 2024 at 11:43=E2=80=AFAM Breno Leitao <leitao@debian.org> wr=
ote:
>
> W=3D1 builds now warn if module is built without a MODULE_DESCRIPTION().
> Add descriptions to the network schedulers.
>
> Suggested-by: Jamal Hadi Salim <jhs@mojatatu.com>
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>

cheers,
jamal

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
> index 5ea84decec19..5337bc462755 100644
> --- a/net/sched/em_canid.c
> +++ b/net/sched/em_canid.c
> @@ -222,6 +222,7 @@ static void __exit exit_em_canid(void)
>         tcf_em_unregister(&em_canid_ops);
>  }
>
> +MODULE_DESCRIPTION("ematch classifier to match CAN IDs embedded in skb C=
AN frames");
>  MODULE_LICENSE("GPL");
>
>  module_init(init_em_canid);
> diff --git a/net/sched/em_cmp.c b/net/sched/em_cmp.c
> index f17b049ea530..c90ad7ea26b4 100644
> --- a/net/sched/em_cmp.c
> +++ b/net/sched/em_cmp.c
> @@ -87,6 +87,7 @@ static void __exit exit_em_cmp(void)
>         tcf_em_unregister(&em_cmp_ops);
>  }
>
> +MODULE_DESCRIPTION("ematch classifier for basic data types(8/16/32 bit) =
against skb data");
>  MODULE_LICENSE("GPL");
>
>  module_init(init_em_cmp);
> diff --git a/net/sched/em_meta.c b/net/sched/em_meta.c
> index 09d8afd04a2a..8996c73c9779 100644
> --- a/net/sched/em_meta.c
> +++ b/net/sched/em_meta.c
> @@ -1006,6 +1006,7 @@ static void __exit exit_em_meta(void)
>         tcf_em_unregister(&em_meta_ops);
>  }
>
> +MODULE_DESCRIPTION("ematch classifier for various internal kernel metada=
ta, skb metadata and sk metadata");
>  MODULE_LICENSE("GPL");
>
>  module_init(init_em_meta);
> diff --git a/net/sched/em_nbyte.c b/net/sched/em_nbyte.c
> index a83b237cbeb0..4f9f21a05d5e 100644
> --- a/net/sched/em_nbyte.c
> +++ b/net/sched/em_nbyte.c
> @@ -68,6 +68,7 @@ static void __exit exit_em_nbyte(void)
>         tcf_em_unregister(&em_nbyte_ops);
>  }
>
> +MODULE_DESCRIPTION("ematch classifier for arbitrary skb multi-bytes");
>  MODULE_LICENSE("GPL");
>
>  module_init(init_em_nbyte);
> diff --git a/net/sched/em_text.c b/net/sched/em_text.c
> index f176afb70559..420c66203b17 100644
> --- a/net/sched/em_text.c
> +++ b/net/sched/em_text.c
> @@ -147,6 +147,7 @@ static void __exit exit_em_text(void)
>         tcf_em_unregister(&em_text_ops);
>  }
>
> +MODULE_DESCRIPTION("ematch classifier for embedded text in skbs");
>  MODULE_LICENSE("GPL");
>
>  module_init(init_em_text);
> diff --git a/net/sched/em_u32.c b/net/sched/em_u32.c
> index 71b070da0437..fdec4db5ec89 100644
> --- a/net/sched/em_u32.c
> +++ b/net/sched/em_u32.c
> @@ -52,6 +52,7 @@ static void __exit exit_em_u32(void)
>         tcf_em_unregister(&em_u32_ops);
>  }
>
> +MODULE_DESCRIPTION("ematch skb classifier using 32 bit chunks of data");
>  MODULE_LICENSE("GPL");
>
>  module_init(init_em_u32);
> --
> 2.39.3
>

