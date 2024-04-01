Return-Path: <linux-kernel+bounces-126387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9034A8936A9
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 02:58:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85F0C1C20A02
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 00:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 222981362;
	Mon,  1 Apr 2024 00:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dY5jGM/v"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D330B623;
	Mon,  1 Apr 2024 00:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711933098; cv=none; b=twPzO28ayDoth9mMOUpDaDcxEBbKr+BjRvx5Ox0zWghnPP5saU1uBoBw83owIzX+hWno1NNbKV/IDFNaeIQ7ELCquOfRmEqEdCgHBMreAVcUPpNoCkppWeMGQefvloPrQr5hzidHp6CGSIZqjZ+4Ht8WCxkYPtdsFpldm4Uhf4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711933098; c=relaxed/simple;
	bh=7ec8tLzayKz/i3ICOnmxgEe8M2qYShQ4ccWZtm2xZPM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=el9WAh7xAwwDEkhlcAsLHbBccXdjqPOdHqofAK9N+0a9dSQiZaaswfFr9VFEIQVYxOnPPZlFHVwxdT8n83KPo70nnzSGKtomn8RX01GgfDPDYiWX4Yf9wu5C1CuAZ4vWcnPeHH3u01FCxUZ8Wy+qE6uCXmZETYEJo/0S+VaU/ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dY5jGM/v; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-41569f28ac7so241645e9.1;
        Sun, 31 Mar 2024 17:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711933095; x=1712537895; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tKCbnU5V2ussTHQYPVGho5TNL75Ygsv7wl5gKI6gMsc=;
        b=dY5jGM/vMyXZcE9FY+ixOoBWbrHNzQg47LLg6vS6ZTmGsDATcSavusCDLhg2NS5Gr3
         c2WhmO21aag9/s0O/nTG1W9KK9jfVnblPtCMMH5uHRpfg7gyn1ngy5EtqokwbmpM6Tbc
         RQ2CT7Z1QnGNSGK4HsdQwM5/Jw954a0Z94BnNZuFPICxis+1P685Gclm0f78IpiSR9SG
         3GlTf2vNx+bscqGBEtQO3InrGL9xRGlhpYFfsZD9fSBBcpwlIfm+/wcEP69iZh02zg+C
         7FZ3g7YRtKfj061qFSPP8CM+aw4addB9eKyIMIEwkPdhhOT2K7RB71fmm0Cu9rn0baN8
         PEOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711933095; x=1712537895;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tKCbnU5V2ussTHQYPVGho5TNL75Ygsv7wl5gKI6gMsc=;
        b=ejkQYvYMkZ3w6xeigdgh2jGABPs+ulwURULk7G7WTxe36/biad3qK4EVbIGtA4kSbu
         NvUx6+yMO7ArJkb/4fXMLEZD+tXbn8wtqsz28NjK6RrgC6P7YyVWPN7U5XJ17ccjUrit
         3WjBL2ag+Z8MDbyb4jDm/UN5N+5Ba0G5nocO2bOSqa1m8fTWB6ICYrJ2m1NYTVdIjE8a
         0fSmfM4/30v886J+fZx4oNcKHbullO/p8P4vI+OXp073aE5FXiJWDe1S0XXyBp6tLMN6
         d/abNdypwfhzLCOHgXRfiafNGNlczTp+zEhojgACZ+/LRwIYlfkgeAJxRgCuzj4zqWtt
         2R2w==
X-Forwarded-Encrypted: i=1; AJvYcCUJzr/DDfWdQah3/uJcWf/WDdsaKwmktws/eqpA550VUq2NMPx/vrNjArK2x9qzznjYIsqvy4UXdL738LxuPA6Y8jLRkm4OtYn1MAeh/KKFfOCy//rtQvryDq+Be5FYO++ddnqUvnUBdrM=
X-Gm-Message-State: AOJu0Yxq3r/WVqJN8wD6We3vPwhq2kHP6O6HTj5td42KgbGPZ7HwpRnZ
	oDIyJne46RSZmGbfgM1+ScARnSWqXARcvTNRN1ommz+X59g+LvsTRhdBGghDssvAljyWuVgWRUj
	jJeICu5tD7zkmgX8H70Nts+r7cZCnfM4YxMw=
X-Google-Smtp-Source: AGHT+IH4ZVSFRhShOQbM9PPFDMzGfjdnw8Kzs3ViXAtO82P5FiP4dmhmb4ZGnbfET5ou0r5FR1slYuMlSlVNCNe2JQY=
X-Received: by 2002:a05:600c:1c07:b0:414:6865:b5bc with SMTP id
 j7-20020a05600c1c0700b004146865b5bcmr5279380wms.28.1711933095081; Sun, 31 Mar
 2024 17:58:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1711680261-5789-1-git-send-email-zhiguo.niu@unisoc.com> <890bd06d-2a94-4138-9854-4a7ed74e0e51@acm.org>
In-Reply-To: <890bd06d-2a94-4138-9854-4a7ed74e0e51@acm.org>
From: Zhiguo Niu <niuzhiguo84@gmail.com>
Date: Mon, 1 Apr 2024 08:58:04 +0800
Message-ID: <CAHJ8P3K9OL6MHNrSrqmf0esbr2h1HJ3mVRmxDNVpf95ZMHQcqg@mail.gmail.com>
Subject: Re: [PATCH] block/mq-deadline: Fix WARN when set async_depth by sysfs
To: Bart Van Assche <bvanassche@acm.org>
Cc: Zhiguo Niu <zhiguo.niu@unisoc.com>, axboe@kernel.dk, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, ke.wang@unisoc.com, hongyu.jin@unisoc.com, 
	Damien Le Moal <dlemoal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 30, 2024 at 2:08=E2=80=AFAM Bart Van Assche <bvanassche@acm.org=
> wrote:
>
> On 3/28/24 7:44 PM, Zhiguo Niu wrote:
> > diff --git a/block/mq-deadline.c b/block/mq-deadline.c
> > index 02a916b..89c516e 100644
> > --- a/block/mq-deadline.c
> > +++ b/block/mq-deadline.c
> > @@ -646,10 +646,12 @@ static void dd_depth_updated(struct blk_mq_hw_ctx=
 *hctx)
> >       struct request_queue *q =3D hctx->queue;
> >       struct deadline_data *dd =3D q->elevator->elevator_data;
> >       struct blk_mq_tags *tags =3D hctx->sched_tags;
> > +     unsigned int shift =3D tags->bitmap_tags.sb.shift;
> > +     unsigned int dd_min_depth =3D max(1U, 3 * (1U << shift)  / 4);
> >
> >       dd->async_depth =3D max(1UL, 3 * q->nr_requests / 4);
> >
> > -     sbitmap_queue_min_shallow_depth(&tags->bitmap_tags, dd->async_dep=
th);
> > +     sbitmap_queue_min_shallow_depth(&tags->bitmap_tags, dd_min_depth)=
;
> >   }
>
> The above patch sets min_shallow_depth to the same value as commit
> d47f9717e5cf ("block/mq-deadline: use correct way to throttling write
> requests"). That commit got reverted because it was causing performance
> problems. So the above patch reintroduces the performance problem that
> has been fixed by commit 256aab46e316 ("Revert "block/mq-deadline: use
> correct way to throttling write requests"").
Hi Bart Van Assche,

This  patch only modifies the initial minimum value of
min_shallow_depth and does not change "dd->async_depth",
so it will not cause performance problems like the previous patch
(d47f9717e5cf ("block/mq-deadline: use correct way to throttling write
> requests")).
>
> Thank you for attempting to reintroduce a problem that just got fixed
> without even mentioning that this is an attempt to reintroduce a
> performance problem.

So what are your suggestions for fixing the warning shown in commit
msg if dd->async_depth is set by the user from sysfs?
thanks
>
> Bart.
>
>

