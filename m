Return-Path: <linux-kernel+bounces-36220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7EC5839DA8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 01:25:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E8AF28AA14
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 00:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E08B115D2;
	Wed, 24 Jan 2024 00:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="GD8m5pAf"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2D2627
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 00:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706055882; cv=none; b=lsxzV1DAAg3MEv5H0+fFhpbiWRcQpx1MFW6Scxd6szb6lI7PGJStKtSpODsuvMcLOVNqTzkeKxUGrk+ifZOtDaArNvlOYvTVBBm/Pmr5phS/pET1+9k/pfN2q0fAEifpsv+qKY0VtJnLN17gJV+2p0AIHgha9HpMzH56FCsIvQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706055882; c=relaxed/simple;
	bh=hMh6ehSMtCLiTnXPJTwHRtndnydv9lJWmV6MQHsynhs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YPshepfKK05hx0WAX+eMHtkR1qO3vK04R05LMrVzBhiHg9MvoCtzcoZI6+3VF3eB4VMik7iNBxxN8HtvAnoj+hnn06RQCigz6ntStXvD0HVfD5zSEAC515AFagsQL1jXF6HmpfVWMHMjfPygap14hIrQ0E1TGjx0a/dkS3i2EoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=GD8m5pAf; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-337d5480a6aso4681159f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 16:24:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1706055878; x=1706660678; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oYTN8ome+CxuG7BZfLTx74gUUZSxMsFlzHcqYkFKxT8=;
        b=GD8m5pAfyOo9iUby3bTRSx21BPUEfdEbVbNqKmiJsALBZAcjwokmC89H0HsCihCPlX
         7MniI/ulDEy1YhUuIj1XNvH0AGF4+Bu6vSjAbwa912pvvcBmQEXijUtIVAYvuecjdaCB
         7MJB/GEcFJZcooXc4rLHmWFe71T6qbSKBXIafjhP+Km3Lqn88mBfTVisZL9xItVtm6TH
         Z8PUy5cuTuTukSRxqawi8kWxjGeL/aSYwaDnkRMxEL1A8qp4Wo2X8Jxux2BR6TunLWu+
         /WRK4a0WxKXWjaxjovMqPMfs880PXhf4pls+5GdoTU6BAVShOpLflY21POjzSjGlY5A0
         7NIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706055878; x=1706660678;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oYTN8ome+CxuG7BZfLTx74gUUZSxMsFlzHcqYkFKxT8=;
        b=Cyx+suOXBTY5muPAT7Y9WKN8Z4gRo6mdEUINNARrNAVyR52oVb8LTMRnRj2rsxrCJO
         RVQhID/1DWv53MfSC/aCeNquB75E74K/hhBoYI2v9bVbb23JKyt7Hvm0PPGySw1vUThv
         /8tOtw8bIEHtuSEGH023cscs0mGRgrSPfpeF9HhjQu0Caid0NQN5BGOGJEiljiiVC0gW
         xvPVOQvHxY/zkIlMho4lFeRpZBCq708TZJV2XoesuwUwYp/MUkY5+zXVSm2pYDU7ltaP
         iHY5ojY35EpK3U57RxwTKU3JLlEyMdWDouWCnph3FwrWvPrQX1KumQAbCwbWC5cjjj2w
         81QQ==
X-Gm-Message-State: AOJu0Yz2GvXCjgKBqsF4VIv+Z/mB3DWntYbCVa5VzUCBDpL+beexzJn7
	o7fyYszVdqyNrIamDG+PuJ3Ypc6Ek5XcTSqh7aGJiDck7IhUCiigBuK2WxfbfgM=
X-Google-Smtp-Source: AGHT+IEQEHnFx8D7dWd7qppBAry9oTyW6DVU6m4DstaCMTezb1yu1bJDpuzDp/n0gGRM1R0enN1Hmg==
X-Received: by 2002:a05:600c:2203:b0:40e:869b:4c12 with SMTP id z3-20020a05600c220300b0040e869b4c12mr568787wml.162.1706055878546;
        Tue, 23 Jan 2024 16:24:38 -0800 (PST)
Received: from airbuntu ([213.122.231.14])
        by smtp.gmail.com with ESMTPSA id f6-20020a05600c154600b0040e880ac6ecsm24156066wmg.35.2024.01.23.16.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 16:24:37 -0800 (PST)
Date: Wed, 24 Jan 2024 00:24:36 +0000
From: Qais Yousef <qyousef@layalina.io>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@infradead.org>, Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	Sudeep Holla <sudeep.holla@arm.com>, Wei Wang <wvw@google.com>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH] block/blk-mq: Don't complete locally if capacities are
 different
Message-ID: <20240124002436.dj5lpjpdc3uttbx4@airbuntu>
References: <20240122224220.1206234-1-qyousef@layalina.io>
 <Za99LKnQE/M6pVfM@infradead.org>
 <c85898de-0780-4690-adfa-99332eae0090@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c85898de-0780-4690-adfa-99332eae0090@kernel.dk>

On 01/23/24 08:58, Jens Axboe wrote:
> On 1/23/24 1:47 AM, Christoph Hellwig wrote:
> > On Mon, Jan 22, 2024 at 10:42:20PM +0000, Qais Yousef wrote:
> >> The logic in blk_mq_complete_need_ipi() assumes SMP systems where all
> >> CPUs have equal capacities
> > 
> > What is a capacity here?
> 
> It seems to be the chosen word to describe the performance potential of
> the core in question, we use it elsewhere in the kernel. But yes, could
> do with a bit more of an explanation.

Is referring to it as compute capacity makes it clearer? Sorry I thought that's
a common term.

> 
> >> +	return arch_scale_cpu_capacity(this_cpu) >= arch_scale_cpu_capacity(that_cpu);
> > 
> > oerly long line here.

This is consistent with similar long lines in the same file and it's more
readable as one line. checkpatch doesn't complain about this being long;
I think they look for 100 or 120 now. This is 86.

> > 
> > Also pleas split patches for different subsystems.
> 
> Yes please, the sched/topology thing should be a separate prep patch.

Okay. I thought the norm to keep such small patches self contained as adding
dead code followed by a one liner isn't always seen as better. But a split it
is :)

I'll give the sched/arm folks time to have a look before I post a new version.


Thanks!

--
Qais Yousef

