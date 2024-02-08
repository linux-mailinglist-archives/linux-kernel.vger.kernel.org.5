Return-Path: <linux-kernel+bounces-58883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D841484EE12
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 00:52:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9648C2884BB
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 23:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E3FC50A8C;
	Thu,  8 Feb 2024 23:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cH4ZUeii"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97541E883;
	Thu,  8 Feb 2024 23:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707436356; cv=none; b=la15E18EcX6vkFM3pqrBZlVLnmEflK5V4U4K5Pj7dVez3lIbcB3pfFMAvTtkGesBaq0A1Zzn8ffk+Wh4RO087yqgOBRD980kYiTb0ceaGCDc6AOi0CRLDgkANjUgmqu86zJwR8Loax0b6UlxD9DSTwL6QKYYXMd/3NQ93j8osCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707436356; c=relaxed/simple;
	bh=0TuJ81rwQVLgk6bEkwPrrgalWDSWS4LrIpoBucqU9M8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E8o4Y1bBt9KD1/qKMbjlyllmVTWl5CawhRQygGVRgvZLcaMmTUah8c88ilZ3OL1/Zf+aPMyEfXNLJN6yEKdrTY5Yc8sCMDN4JKykhsFjpDR+Yw/oQOxDaKVQkBgJ3hjONFvDD1zqfhUfd2AMH3sd6EyCwgC67wGpI5A0shTjMxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cH4ZUeii; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2d09cf00214so4980671fa.0;
        Thu, 08 Feb 2024 15:52:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707436353; x=1708041153; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m6wMFe6NQrnI4rL+5ph8w/QElo3FYa1DxN0fAFRr46I=;
        b=cH4ZUeiiWrerqbW+vDPe10V8AziGwv2IS5ecDT3/EXRM60hEdkycCfcJi+Urz/h7j0
         0IqEWja/nfaO9T0LeaR991lmUKpEF4K1T5evKL9o/+t4X69qLFTF4+Y1auA/MjsR7Gcu
         eYutEAkt9lhP7TKnHAVgnrizEAyGNXUyLF87/UzICmvzu/DXNexxl+AKSOHQC9IEI1h5
         Cbi6Z/DvmmliO+8J/riVvgnGNq+W+n8MA8j9ZXiXAKJgXQvkRRQOR2OTqPXHWb149HVr
         FfMtAHCnyRuWKRT564kEmC8aICiunDHizU6cTUbXEJMeHy9Sjsbf33HFqlC0S/wJAcTs
         LX5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707436353; x=1708041153;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m6wMFe6NQrnI4rL+5ph8w/QElo3FYa1DxN0fAFRr46I=;
        b=PZ6x4iW1Mx5j3p8r8qq/yFIUGDnub2RWuFi8cmeMPCsSZq1EgK92tKbfxNQbVOq5Bm
         WItbP3fG3BzHXg3F6bp0fBv+J2JhkF3DxMsOALZbz2XGO0uiYUc10R83ExulntXBQNIN
         ZnKa17Untc9xbSt3Bjw+cVA1JPr8qK1grqNauqUIkqeQD1qK8trAyeuhYZM311rI/F45
         8nBHqFVXOZ4n7pGwEk78DWbEZq4aQivu+heixfRA4XgYT0g63y9zIUozFV3hlE422Bib
         eFYD/N7MtezcKx2ztDy5i++WZgPstuRDJIrP8x+axIMovkG32UXU7uK/Z9NVsMDND1Gl
         YfKw==
X-Gm-Message-State: AOJu0YwlDSYmLMXNy+mHpekWkl9fVyaSQ/oE5XaDfqr17BpEDcqhz6jo
	pScGXYECC6ET2ra8sgOaTpGE+zVCZHEAPCmKLZ7exH3Jo3RdWparR+GqDuQZA6rtluR5qLL1mQy
	YmuSkgHIgHonkxHhW9Bv3BXC9/eg=
X-Google-Smtp-Source: AGHT+IFPcxdRVAxjhMcMjYR3MMd5br9sMGHnjaUL+RmdGQeL+yFqdWj56QUVnvIu5llXHFQLjelSsJmy6JIpifSUWS0=
X-Received: by 2002:a2e:a9a2:0:b0:2d0:c0d0:d4ed with SMTP id
 x34-20020a2ea9a2000000b002d0c0d0d4edmr94867ljq.0.1707436352580; Thu, 08 Feb
 2024 15:52:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208093136.178797-1-zhaoyang.huang@unisoc.com>
 <20240208093136.178797-3-zhaoyang.huang@unisoc.com> <5f934ebf-4e2a-44f9-993f-8b2c8d358370@acm.org>
In-Reply-To: <5f934ebf-4e2a-44f9-993f-8b2c8d358370@acm.org>
From: Zhaoyang Huang <huangzhaoyang@gmail.com>
Date: Fri, 9 Feb 2024 07:52:21 +0800
Message-ID: <CAGWkznGvwBZWv+g7=0JxRpeQ+chMoN27TDmuSAVU2O37fGNCDg@mail.gmail.com>
Subject: Re: [PATCH 3/3] block: introducing a bias over deadline's fifo_time
To: Bart Van Assche <bvanassche@acm.org>
Cc: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>, Jens Axboe <axboe@kernel.dk>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Yu Zhao <yuzhao@google.com>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, steve.kang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 9, 2024 at 1:46=E2=80=AFAM Bart Van Assche <bvanassche@acm.org>=
 wrote:
>
> On 2/8/24 01:31, zhaoyang.huang wrote:
> > diff --git a/block/mq-deadline.c b/block/mq-deadline.c
> > index f958e79277b8..43c08c3d6f18 100644
> > --- a/block/mq-deadline.c
> > +++ b/block/mq-deadline.c
> > @@ -15,6 +15,7 @@
> >   #include <linux/compiler.h>
> >   #include <linux/rbtree.h>
> >   #include <linux/sbitmap.h>
> > +#include "../kernel/sched/sched.h"
>
> Is kernel/sched/sched.h perhaps a private scheduler kernel header file? S=
houldn't
> block layer code only include public scheduler header files?
>
> > @@ -840,7 +842,9 @@ static void dd_insert_request(struct blk_mq_hw_ctx =
*hctx, struct request *rq,
> >               /*
> >                * set expire time and add to fifo list
> >                */
> > -             rq->fifo_time =3D jiffies + dd->fifo_expire[data_dir];
> > +             fifo_expire =3D task_is_realtime(current) ? dd->fifo_expi=
re[data_dir] :
> > +                     CFS_PROPORTION(current, dd->fifo_expire[data_dir]=
);
> > +             rq->fifo_time =3D jiffies + fifo_expire;
> >               insert_before =3D &per_prio->fifo_list[data_dir];
> >   #ifdef CONFIG_BLK_DEV_ZONED
> >               /*
>
> Making the mq-deadline request expiry time dependent on the task priority=
 seems wrong
> to me.
But bio_set_ioprio has done this before
>
> Thanks,
>
> Bart.

