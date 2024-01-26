Return-Path: <linux-kernel+bounces-39514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60CFA83D236
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 02:46:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D173FB289DD
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 01:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA99A8F5C;
	Fri, 26 Jan 2024 01:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="Ai/JgQJw"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD47A8BE8
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 01:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706233569; cv=none; b=ENx/9fdnfrhcGpbpf+IjL9KWrtC3FCtBzlTte/oVjYtTm7zZ+EQRuRmM7ioDzeti6f/oMtbYmtA4ZPGaFm7dPMagkblNVorpNjXFC1FFLtwfP+nCEKVtcggqQ8SBMsxE+SpjQzb6Nr5dWVwB5OH4670NEsWta1b0uNwAesCQG6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706233569; c=relaxed/simple;
	bh=JYX8I7sQuZdH5DKb6BTrmf4vXU1Kd0Y/dHbr7Uq+Y5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NzGCRIQICijOJjCPS3nfxh8kX67oXzG3pH+1/idXfhR1XXh0M17dYcHZEFSazwpHsD60TZQtoQaNNyEK6hqV10JjSx212Uwj9cFlAQ7kEzdU9EdkeYmJb0qtWInWnmNbmNGRqM5ckL+P2j6Kl0QAcCIflpTugWSCMmBaIE2DeWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=Ai/JgQJw; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40e7065b7bdso86790145e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 17:46:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1706233565; x=1706838365; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XHIz2Qj8BSsobZbYc+he4Nb7xWfD83aYf6WySsHrTj8=;
        b=Ai/JgQJwp/K6Q76CLr/ugUFTCzceC35Yp36PCps6c407Tk/xloMcLnyd6dR13E8Iv6
         68U2S/pGSy9K3tpIy3jXOWEQHXK1BCAu1f1wmZsCckoInDUlz3Uz8GGZPMebqBhC//FE
         YLzMxm66UdAceZADkOxdNUTW2VZKxbwK2TvFOs5t44EzLv75bzM5lvhhodAANk9DIi1M
         8jOZ+NdpbSn03vxBitP2Zv5eCiY2FMqkCF/VSMm14Zj3UdLIewiJ45Pmkxdtgl1JTveu
         zl4Wu/0Y0uwY4+zDQo7vX5Osm+8Ony1q4S6CEoUEw3MFeNtvOvah43dfsHUIAjvwuQbc
         auRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706233565; x=1706838365;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XHIz2Qj8BSsobZbYc+he4Nb7xWfD83aYf6WySsHrTj8=;
        b=B4BVH7885dxo3lJB8eotcXponKvAfU7xYoeV4zKayIkB1hxw5CJkPrmOT4oNcUSlfI
         fc0cCEpghYuB1waq+spmANx2KHwNIj7eRnp9y3Twr1NnIFzvFm2dJpHknVnTHusZJWVb
         pcdWy+uGZF3cDEZ8IXC+3NOVeALodH5KGUY/OTZ3tnZr3tBdDyxgNRJkKUGdO0a0EpN6
         51432QUYTLPunZ5V1VOWHtSaOglnY2C3CMkYWhHCyFSaCzi6arkGxOWmxlzFeC9fhVCG
         juCyVIZEM7IfCGGpUUNLgtp1b8tC5EhzU4nRkiEVXvs6tAaKuDQNdaXKck9QGFsBvqEv
         NARA==
X-Gm-Message-State: AOJu0YzNC7Ww3O9ZwJZpRPRnWWHBCJqGqS52HV1YiVbw3iowSxXRkdJK
	coArvMKfinbRbkq23V7KjwORnjBbR06PCWBdjLXycC4MwipuSr9clukZVvM2TuI=
X-Google-Smtp-Source: AGHT+IGD/PcHlmxIi6p1MqQlDFHyftyuDVYtCbgR9yZUU17CiOVnfNbpq4bSPrnUssG0O47wS7qkaQ==
X-Received: by 2002:a05:600c:35c5:b0:40e:7efd:7f10 with SMTP id r5-20020a05600c35c500b0040e7efd7f10mr220133wmq.133.1706233564996;
        Thu, 25 Jan 2024 17:46:04 -0800 (PST)
Received: from airbuntu ([213.122.231.14])
        by smtp.gmail.com with ESMTPSA id c11-20020a05600c0a4b00b0040ebf603a89sm4177456wmq.11.2024.01.25.17.46.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 17:46:04 -0800 (PST)
Date: Fri, 26 Jan 2024 01:46:02 +0000
From: Qais Yousef <qyousef@layalina.io>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	linux-kernel@vger.kernel.org,
	Pierre Gondois <Pierre.Gondois@arm.com>
Subject: Re: [PATCH v4 1/2] sched/fair: Check a task has a fitting cpu when
 updating misfit
Message-ID: <20240126014602.wdcro3ajffpna4fp@airbuntu>
References: <20240105222014.1025040-1-qyousef@layalina.io>
 <20240105222014.1025040-2-qyousef@layalina.io>
 <CAKfTPtBYcVWxYOhWZjzcQUB1ebUBA-B30hvToqGBq6JnfRUZNg@mail.gmail.com>
 <20240124222959.ikwnbxkcjaxuiqp2@airbuntu>
 <CAKfTPtDxqcrf0kaBQG_zpFx-DEZTMKfyxBu_bzCuZ_UZhJwOnA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKfTPtDxqcrf0kaBQG_zpFx-DEZTMKfyxBu_bzCuZ_UZhJwOnA@mail.gmail.com>

On 01/25/24 18:40, Vincent Guittot wrote:
> On Wed, 24 Jan 2024 at 23:30, Qais Yousef <qyousef@layalina.io> wrote:
> >
> > On 01/23/24 09:26, Vincent Guittot wrote:
> > > On Fri, 5 Jan 2024 at 23:20, Qais Yousef <qyousef@layalina.io> wrote:
> > > >
> > > > From: Qais Yousef <qais.yousef@arm.com>
> > > >
> > > > If a misfit task is affined to a subset of the possible cpus, we need to
> > > > verify that one of these cpus can fit it. Otherwise the load balancer
> > > > code will continuously trigger needlessly leading the balance_interval
> > > > to increase in return and eventually end up with a situation where real
> > > > imbalances take a long time to address because of this impossible
> > > > imbalance situation.
> > >
> > > If your problem is about increasing balance_interval, it would be
> > > better to not increase the interval is such case.
> > > I mean that we are able to detect misfit_task conditions for the
> > > periodic load balance so we should be able to not increase the
> > > interval in such cases.
> > >
> > > If I'm not wrong, your problem only happens when the system is
> > > overutilized and we have disable EAS
> >
> > Yes and no. There are two concerns here:
> >
> > 1.
> >
> > So this patch is a generalized form of 0ae78eec8aa6 ("sched/eas: Don't update
> > misfit status if the task is pinned") which is when I originally noticed the
> > problem and this patch was written along side it.
> >
> > We have unlinked misfit from overutilized since then.
> >
> > And to be honest I am not sure if flattening of topology matters too since
> > I first noticed this, which was on Juno which doesn't have flat topology.
> >
> > FWIW I can still reproduce this, but I have a different setup now. On M1 mac
> > mini if I spawn a busy task affined to littles then expand the mask for
> > a single big core; I see big delays (>500ms) without the patch. But with the
> > patch it moves in few ms. The delay without the patch is too large and I can't
> > explain it. So the worry here is that generally misfit migration not happening
> > fast enough due to this fake misfit cases.
> 
> I tried a similar scenario on RB5 but I don't see any difference with
> your patch. And that could be me not testing it correctly...
> 
> I set the affinity of always running task to cpu[0-3] for a few
> seconds then extend it to [0-3,7] and the time to migrate is almost
> the same.

That matches what I do.

I write a trace_marker when I change affinity to help see when it should move.

> 
> I'm using tip/sched/core + [0]
> 
> [0] https://lore.kernel.org/all/20240108134843.429769-1-vincent.guittot@linaro.org/

I tried on pinebook pro which has a rk3399 and I can't reproduce there too.

On the M1 I get two sched domains, MC and DIE. But on the pine64 it has only
MC. Could this be the difference as lb has sched domains dependencies?

It seems we flatten topologies but not sched domains. I see all cpus shown as
core_siblings. The DT for apple silicon sets clusters in the cpu-map - which
seems the flatten topology stuff detect LLC correctly but still keeps the
sched-domains not flattened. Is this a bug? I thought we will end up with one
sched domain still.

TBH I had a bit of confirmation bias that this is a problem based on the fix
(0ae78eec8aa6) that we had in the past. So on verification I looked at
balance_interval and this reproducer which is a not the same as the original
one and it might be exposing another problem and I didn't think twice about it.

The patch did help though. So maybe there are more than one problem. The delays
are longer than I expected as I tried to highlight. I'll continue to probe.

