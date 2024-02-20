Return-Path: <linux-kernel+bounces-72958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ADFFB85BB1C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 12:56:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D18521C2173C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 11:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D65C167C58;
	Tue, 20 Feb 2024 11:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="efAxrePN"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E2F67A1E;
	Tue, 20 Feb 2024 11:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708430193; cv=none; b=YE/txpnYXLVu5wJrazUjoXl8xpdKHGh8q/xOiEpYpkw+L6zbtROwkXhUjEmoa+QtM8LOpBJm8Xp8w5kjiSHJQTtTdfX8uQwOB38XELcleDRoFDKxv5e5MMEjpY++UyikMJ6s5UYlOjS203IXB7oUuAkN8vWFvSlLluGWDfnyVA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708430193; c=relaxed/simple;
	bh=DHyNac6pqvpgWDifETaFskO4ADR2Iy/NxbY88RBFutQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bO3IgNBZb63XBtp+y8w+qxqTvmo5D1tX+J1xE4lY0nIGVXG97uSsvpSPCY8usV3t5KQNzGNCPbaXgkCYjg6MxoeX1CRj7N9zwjDhm64XRpFtbQkuaVo9H/HH4zkLT/SRxY0LTKdvAU0phfWB5tlhUhXI3A3BYMg+pQHW+02hyEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=efAxrePN; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-512b29f82d1so2942268e87.1;
        Tue, 20 Feb 2024 03:56:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708430189; x=1709034989; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=foNRqD08lE8m6cwZRG5heeFxF4dvoAE7BS0q7pzI9rg=;
        b=efAxrePN/YwnaHdxIe98K8SORbooHer7ONC2dvUfWO98DR9DElxx625kzkQVa3epKB
         7+iOLDZQ1BxTTfr5fOJHIIEZvjOPoqDAwW3qAmyd2hIpsr+drL+aKsVIWqH4DN3vf3tl
         mM48PvT9rhvpALWXOIQzB5aRmtoljkn5AJxigKiGOAu0SitwsxhQKR9pYE+1xGzlfU88
         cAbDmX1uxL+dlLTLURwwma8t90JSVpTAIgBIAW2/2ukq5Rml4x4tVy2rU1UlQoe4NiPp
         sxGjdsKBjMQ/hdpoJY2o/FH5OrqjMNvln/Uylo655vB5RuuzRGaDfeHZU49lul4z2+9p
         jq8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708430189; x=1709034989;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=foNRqD08lE8m6cwZRG5heeFxF4dvoAE7BS0q7pzI9rg=;
        b=Wvaqno9vkt/jSj9uRQLFlDT/6pqPhnUqB6blZxggwXJ2uFjpHsQhl7I5jxginFMXka
         34qgsyZAsAFwFofXMfETfDoEfwWrzXiGXNSZhXO5w4HtkXJ5ZfsmJVdnt+17oIMAOzMN
         BvixaiJq3HuSQPxwHBY7ogB76CabkwBSWqNrB6Z8zyPiDhBCbnR841ScHG7GcmabUJLe
         znUKIzRC0o+VIUNyDFLUZEPCdUbiuLBBj8beOX8ZlPWR8VM+2I9wdsAJuehJyRjER+9L
         PWfjIuC1knVnOopZdMrG//3/MBMW6uKqxQKn/6sZmUmt8HxN9HxHlR1GBSITlK7lJzk9
         MqfA==
X-Forwarded-Encrypted: i=1; AJvYcCWKPjTPj1bBbtkRfrnF+MY5YxrAfonk0RjAv3bVvolmjx3/F6yXnNn5xt5Bm/eK66TKAdrDOU16BjKOLxKRHzoX38Ud/f3GEPEIWW5tpygThBkzULWQEXyHTcbpYSmI5ISVN/GnhfO6CmQ=
X-Gm-Message-State: AOJu0YydGQEZs+g4jrV8ZpP0L/R8QXySSlBWN6QmIA72ojYc3C5FJBsC
	3irZKMlrSfll5qf5oYIw8v1BMmr0FxWMQ7VUS+UUF2H4aaZq6s9eeycXWMNcRiJAtRAzRP1dMxq
	jFc23gD3XlU8RRsP/NLFH/VCa+R4=
X-Google-Smtp-Source: AGHT+IEmhfalQ3QRFY1wEpyvoluzT6iLzF14pjVu2I1tXPKM32xK85UIwaB3SZZz+BaPx4WRiAqOi+Ehg6AMRiUzExM=
X-Received: by 2002:a05:6512:239f:b0:512:b90e:ab3a with SMTP id
 c31-20020a056512239f00b00512b90eab3amr3470779lfv.23.1708430188983; Tue, 20
 Feb 2024 03:56:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240220114536.513494-1-zhaoyang.huang@unisoc.com>
In-Reply-To: <20240220114536.513494-1-zhaoyang.huang@unisoc.com>
From: Zhaoyang Huang <huangzhaoyang@gmail.com>
Date: Tue, 20 Feb 2024 19:56:17 +0800
Message-ID: <CAGWkznGW4xUyhxySajAHginW9wz3GNB_iV5FUEkGD5h__YVUTw@mail.gmail.com>
Subject: Re: [PATCHv2 2/2] block: adjust CFS request expire time
To: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	steve.kang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Patchv2 make the adjustment work as a CFS's over-preempted guard which
only take effect for READ

On Tue, Feb 20, 2024 at 7:46=E2=80=AFPM zhaoyang.huang
<zhaoyang.huang@unisoc.com> wrote:
>
> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
>
> According to current policy, CFS's may suffer involuntary IO-latency by
> being preempted by RT/DL tasks or IRQ since they possess the privilege fo=
r
> both of CPU and IO scheduler. This commit introduce an approximate and
> light method to decrease these affection by adjusting the expire time
> via the CFS's proportion among the whole cpu active time.
> The average utilization of cpu's run queue could reflect the historical
> active proportion of different types of task that can be proved valid for
> this goal from belowing three perspective,
>
> 1. All types of sched class's load(util) are tracked and calculated in th=
e
> same way(using a geometric series which known as PELT)
> 2. Keep the legacy policy by NOT adjusting rq's position in fifo_list
> but only make changes over expire_time.
> 3. The fixed expire time(hundreds of ms) is in the same range of cpu
> avg_load's account series(the utilization will be decayed to 0.5 in 32ms)
>
> TaskA
> sched in
> |
> |
> |
> submit_bio
> |
> |
> |
> fifo_time =3D jiffies + expire
> (insert_request)
>
> TaskB
> sched in
> |
> |
> vfs_xxx
> |
> |preempted by RT,DL,IRQ
> |\
> | This period time is unfair to TaskB's IO request, should be adjust
> |/
> |
> submit_bio
> |
> |
> |
> fifo_time =3D jiffies + expire * CFS_PROPORTION(rq)
> (insert_request)
>
> Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> ---
> change of v2: introduce direction and threshold to make the hack working
> as a guard for CFS's over-preempted.
> ---
> ---
>  block/mq-deadline.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
>
> diff --git a/block/mq-deadline.c b/block/mq-deadline.c
> index f958e79277b8..b5aa544d69a3 100644
> --- a/block/mq-deadline.c
> +++ b/block/mq-deadline.c
> @@ -54,6 +54,7 @@ enum dd_prio {
>
>  enum { DD_PRIO_COUNT =3D 3 };
>
> +#define CFS_PROP_THRESHOLD 60
>  /*
>   * I/O statistics per I/O priority. It is fine if these counters overflo=
w.
>   * What matters is that these counters are at least as wide as
> @@ -802,6 +803,7 @@ static void dd_insert_request(struct blk_mq_hw_ctx *h=
ctx, struct request *rq,
>         u8 ioprio_class =3D IOPRIO_PRIO_CLASS(ioprio);
>         struct dd_per_prio *per_prio;
>         enum dd_prio prio;
> +       int fifo_expire;
>
>         lockdep_assert_held(&dd->lock);
>
> @@ -839,8 +841,20 @@ static void dd_insert_request(struct blk_mq_hw_ctx *=
hctx, struct request *rq,
>
>                 /*
>                  * set expire time and add to fifo list
> +                * The expire time is adjusted when current CFS task is
> +                * over-preempted by RT/DL/IRQ which is calculated by the
> +                * proportion of CFS's activation among whole cpu time du=
ring
> +                * last several dozen's ms.Whearas, this would NOT affect=
 the
> +                * rq's position in fifo_list but only take effect when t=
his
> +                * rq is checked for its expire time when at head.
>                  */
> -               rq->fifo_time =3D jiffies + dd->fifo_expire[data_dir];
> +               fifo_expire =3D dd->fifo_expire[data_dir];
> +               if (data_dir =3D=3D DD_READ &&
> +                       (cfs_prop_by_util(current, 100) < CFS_PROP_THRESH=
OLD))
> +                       fifo_expire =3D cfs_prop_by_util(current, dd->fif=
o_expire[data_dir]);
> +
> +               rq->fifo_time =3D jiffies + fifo_expire;
> +
>                 insert_before =3D &per_prio->fifo_list[data_dir];
>  #ifdef CONFIG_BLK_DEV_ZONED
>                 /*
> --
> 2.25.1
>

