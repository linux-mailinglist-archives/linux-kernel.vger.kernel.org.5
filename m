Return-Path: <linux-kernel+bounces-79899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D5AF86286E
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 00:06:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 346511F20ECD
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 23:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7FC14EB3C;
	Sat, 24 Feb 2024 23:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="KOixnNfK"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9D54D9F5
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 23:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708815990; cv=none; b=TMRFLdpdwmJ4LeC4McZnJOhjE+esVLJa88aFTG6Ehoti0yieDl1vvzEFEriyEr+dSrXhSBwKBPMBxYHFmbXlO3zKOJZcWQxJL5o9Hf2Hp4W0S1Z+RNuwIeHAI6wTmqdc4RohUCA3bQXavY/SzK2vqMSkvrCZizfSQ2RFFp01EZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708815990; c=relaxed/simple;
	bh=kmA44JGlXCXr3hZ+2v5RomkzveC40+e4T6lxFB1zYms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UrZWnmO3/FZdUIfanoAaLSOTnx2/YUuJtvszYDoxuAJyrsy3wsadhkq+0bB7JEAjT+b87WSoUjQPNmME1OPneBDOGCir4xsgPe24scBRvIkI3VjKUPMIUDz3GflLs8WD+2Qhtts61HgrvOB/vZ4gh/aEHEJyi5NAmkpfik5AV10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=KOixnNfK; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4128f5ec9b7so14541775e9.3
        for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 15:06:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1708815987; x=1709420787; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=STRW+sDRKgDfYJ1/C7WIi910D5D2SyAksTFspCka2rw=;
        b=KOixnNfKmo2/odIIn5pMB5Sbj4C+GhG3hUzG8DsseQnmCC8JVbtMDNUthcGZDpICzb
         TltFkYyywNstc6GlyT351Eh0jQ3DAIKXWeHV5c+IX9J/etYzzwCDcSB1+cS6qQF/UPPG
         s8TXD8LSSV/DizWuckxU19GUskjGQ4nw7kT7FSiQlf4cyx9LQHOWwA+AGf/4ERAbc0lW
         i7QCgnj/n4Vm4B2gT+/pYUYiZkxqcg2HLgbMVW8XJ7sitRvocxz8ARbNs2NVUio1uTe+
         iucDlPAhgmdYeaausY+sS3asxuWmV87H+bAQmSxIqU+cGkeHfzi7/eUQSqWK2wbVamaA
         JCVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708815987; x=1709420787;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=STRW+sDRKgDfYJ1/C7WIi910D5D2SyAksTFspCka2rw=;
        b=rfse+KAL4U1+84dsyaXjnvGF6QyEcKHXSBj/7zX+RywIv1LYllgLLM0qLqiQddp3X+
         GrbuJMVyB2XOoKWuEDrZNj4axX2tzC9WkVHMjfYUfeBQEsDDoxpcdYLUoA50tasOxyGP
         TbzX6hsZ6oi8YLy1CGIwmjxd1JbNft35sTvwlBUNtneOy8/bo0ku1PRO0qP/8Qw/I6AD
         cNad6k1wiLScl13czVkLdfnpFqJY+YCUFU0LEq91m1s4rlVHPsqqw/wZhyJoKsVluXIO
         aqIZiRqpEe/BzPtp5P1CAOVVU6v0XFzLcr9zoUYbZhs1y2SeHzTW337hrB2e/3f3BfHX
         ajRw==
X-Forwarded-Encrypted: i=1; AJvYcCVZGVxxYQIdl5ogtw3hXHLtRwNGNcggGMKc920kfoyeRJanxXqNuXta7b3UTHEWFdRXh1flta4s8KRBQhH0bMoW98XdYWxbczjqX5CD
X-Gm-Message-State: AOJu0YwUBe6DLIkqO/wT19UwOQbhI7POFXDWAljuY9POGwu+22Jsk/6A
	aZSH3lakPscVgAfix/TxPaxCAK5yKII3LnjG1lLOsQCg/RSE912k0mE83w+GamY=
X-Google-Smtp-Source: AGHT+IEvQspgkkNJog6GXKb1zuOkkB3e9OVOtJyq3aKqvY6fQ0XbacweAbTHzk40zRVnU7XEU7uXOA==
X-Received: by 2002:a05:600c:3d09:b0:412:a1eb:4ef1 with SMTP id bh9-20020a05600c3d0900b00412a1eb4ef1mr231783wmb.9.1708815986783;
        Sat, 24 Feb 2024 15:06:26 -0800 (PST)
Received: from airbuntu (host109-154-46-208.range109-154.btcentralplus.com. [109.154.46.208])
        by smtp.gmail.com with ESMTPSA id 20-20020a05600c229400b004120675e057sm3415928wmf.0.2024.02.24.15.06.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Feb 2024 15:06:26 -0800 (PST)
Date: Sat, 24 Feb 2024 23:06:24 +0000
From: Qais Yousef <qyousef@layalina.io>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	Sudeep Holla <sudeep.holla@arm.com>, Wei Wang <wvw@google.com>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2 2/2] block/blk-mq: Don't complete locally if
 capacities are different
Message-ID: <20240224230624.3sk3b5pmhoi67c3r@airbuntu>
References: <20240223155749.2958009-1-qyousef@layalina.io>
 <20240223155749.2958009-3-qyousef@layalina.io>
 <8fc70827-9785-48d0-9a43-e1e3674317e9@acm.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8fc70827-9785-48d0-9a43-e1e3674317e9@acm.org>

On 02/23/24 08:09, Bart Van Assche wrote:
> On 2/23/24 07:57, Qais Yousef wrote:
> > diff --git a/block/blk-mq.c b/block/blk-mq.c
> > index 2dc01551e27c..ea69047e12f7 100644
> > --- a/block/blk-mq.c
> > +++ b/block/blk-mq.c
> > @@ -1167,10 +1167,11 @@ static inline bool blk_mq_complete_need_ipi(struct request *rq)
> >   	if (force_irqthreads())
> >   		return false;
> > -	/* same CPU or cache domain?  Complete locally */
> > +	/* same CPU or cache domain and capacity?  Complete locally */
> >   	if (cpu == rq->mq_ctx->cpu ||
> >   	    (!test_bit(QUEUE_FLAG_SAME_FORCE, &rq->q->queue_flags) &&
> > -	     cpus_share_cache(cpu, rq->mq_ctx->cpu)))
> > +	     cpus_share_cache(cpu, rq->mq_ctx->cpu) &&
> > +	     cpus_equal_capacity(cpu, rq->mq_ctx->cpu)))
> >   		return false;
> >   	/* don't try to IPI to an offline CPU */
> 
> I think it's worth mentioning that this change is intended for storage
> controllers that only support a single completion interrupt. Anyway:

Sorry I didn't realize it is only applied for this scenario.

> 
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>

Thanks for the reviews!

