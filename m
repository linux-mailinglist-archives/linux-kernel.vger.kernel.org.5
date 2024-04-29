Return-Path: <linux-kernel+bounces-162129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DFE68B5656
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 13:18:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59AC72844B2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 11:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67601200D5;
	Mon, 29 Apr 2024 11:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="KWFbG9dj"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34ECF3EA96
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 11:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714389502; cv=none; b=W9iOeMCgWAPnlpFJWyx8KmlJcefjuF2W6xUYyQh3DTSAuscltzLl2E+78nBqIwSOhGOP9pniQAc79K+xNMAOO3SFYUyqCajRZf133Jy6biGGLsVw/jimTv3nNc0rvNnSz+Zp1U4sx1P3xUphW1Vry8IbzYsStZpXiAX/8lWcP+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714389502; c=relaxed/simple;
	bh=8xa84trj/OuvBERyOQRKPGpd53bzPZEwz+4yWpMegVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lERqAetVsb86uOGZNWRrtgoRQj6iRpXRvnoAY1qA/OLNd2EqwvofXBh6+000aTt2T5aBqcWg4n9a7IXsh2+lU5M3/32Q6Pn5ILM8Q6FpmwjPBFKBr2QQPag2IsjvUzNE0cPXfgWYF2DlmML9shmooYxAy9yoMaXbG3gsqHel9Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=KWFbG9dj; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-34d0c053bf0so554762f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 04:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1714389499; x=1714994299; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uwDsJlGHU7QiLVD+kND22vviKRi7S24br0n3yPE4cXE=;
        b=KWFbG9dj7UkjtPcsI5lavdxL+hL9i54r/5Pp6Vmw7k18AMRXLJq2ZsMHJrtk+MuUv4
         BjBSIq1i1lyJzBUscvc1y1CT+Z8N3OEMRw2zJPtMx1fZU6CLdvV9nw+DJ8CDHvbYtDfI
         7rq9cvES3hksKYfN+AxrlShoKJij7vhF7Vi0XsEjC83W7czF0fIqB1H4fTpeK0xFt7UO
         YZjgWez7/lFtQtvceCTlPEJaQgwemhgXEKGzB9ZYcRZJtJL2syv6GawAyo08rVn5MfLx
         rw0U+fXLyUi71RrRgZ0Dc1U8SymSVTZxAk/uaSoBAmFv320Weaq9aVwLIStarwcDV6tc
         oFqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714389500; x=1714994300;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uwDsJlGHU7QiLVD+kND22vviKRi7S24br0n3yPE4cXE=;
        b=QwTtl24CCUbLQVafAGcjfAZe7KUmDdcsl27K+Y3ArDz8pRON3Zd6p0tQhSWi5s5dxA
         aLcD/xfl5YlNGLUqCIO0O0bBZAlMrHOOO+PHvoyBxH6k76KggerEkzrZq/1h+f3o634R
         7fjbEkJpfXXAwmuQUNIu22IdlvnochKJQGbCnShWb3CDMB9spqc/kLUgAaFT/f6ubOJf
         FN9q7xNPQiUhT+plA3Q8YcA+HaWMvZ62phqQ/GFHCVUc2qRvdzbwuuY1zGlebbazLAcs
         gLpXSYA16qRtj23q08EvE6kpKTWbBX0RkLIRj1wdm3uVe+R0MG6kC1ACdFWNUXA50r97
         kNhQ==
X-Forwarded-Encrypted: i=1; AJvYcCXA1OaP7zg5oVnLXv6QAilGUnpYSE3lYnZhJ6mZPekauD2n9vXEv6ZjxPgXizr3Z5KWkl1oMrJAkEx6biNPoTS1sQ0EfjSNizRj40KZ
X-Gm-Message-State: AOJu0YzG/lySDvq4pFSrxmE9ZZ2IucFowd+VN2I77I2y22DhzfX/sLiY
	Fyq2BSPBHSCwjw9bgSaK9RG+y0a4kfDAPU+b04AioB9+VpZNKgsrHQdAvw3k4xA=
X-Google-Smtp-Source: AGHT+IESIaZKXHhTxatqFCL9Fa90Gl/4hES0owFvuG9oTUJHLtxjWYX9ULzmGc4TJhqz9pbve+0cMg==
X-Received: by 2002:a5d:4b44:0:b0:34c:9a24:7a40 with SMTP id w4-20020a5d4b44000000b0034c9a247a40mr4607842wrs.56.1714389499309;
        Mon, 29 Apr 2024 04:18:19 -0700 (PDT)
Received: from airbuntu (host81-157-90-255.range81-157.btcentralplus.com. [81.157.90.255])
        by smtp.gmail.com with ESMTPSA id x8-20020a5d60c8000000b0034cf39c64bdsm3229404wrt.101.2024.04.29.04.18.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 04:18:18 -0700 (PDT)
Date: Mon, 29 Apr 2024 12:18:16 +0100
From: Qais Yousef <qyousef@layalina.io>
To: Christian Loehle <christian.loehle@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org,
	peterz@infradead.org, juri.lelli@redhat.com, mingo@redhat.com,
	dietmar.eggemann@arm.com, vschneid@redhat.com,
	vincent.guittot@linaro.org, Johannes.Thumshirn@wdc.com,
	adrian.hunter@intel.com, ulf.hansson@linaro.org, andres@anarazel.de,
	asml.silence@gmail.com, linux-pm@vger.kernel.org,
	linux-block@vger.kernel.org, io-uring@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] cpufreq/schedutil: Remove iowait boost
Message-ID: <20240429111816.mqok5biihvy46eba@airbuntu>
References: <20240304201625.100619-1-christian.loehle@arm.com>
 <20240304201625.100619-3-christian.loehle@arm.com>
 <CAJZ5v0gMni0QJTBJXoVOav=kOtQ9W--NyXAgq+dXA+m-bciG8w@mail.gmail.com>
 <5060c335-e90a-430f-bca5-c0ee46a49249@arm.com>
 <CAJZ5v0janPrWRkjcLkFeP9gmTC-nVRF-NQCh6CTET6ENy-_knQ@mail.gmail.com>
 <20240325023726.itkhlg66uo5kbljx@airbuntu>
 <d99fd27a-dac5-4c71-b644-1213f51f2ba0@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d99fd27a-dac5-4c71-b644-1213f51f2ba0@arm.com>

On 04/19/24 14:42, Christian Loehle wrote:

> > I think the major thing we need to be careful about is the behavior when the
> > task is sleeping. I think the boosting will be removed when the task is
> > dequeued and I can bet there will be systems out there where the BLOCK softirq
> > being boosted when the task is sleeping will matter.
> 
> Currently I see this mainly protected by the sugov rate_limit_us.
> With the enqueue's being the dominating cpufreq updates it's not really an
> issue, the boost is expected to survive the sleep duration, during which it
> wouldn't be active.
> I did experiment with some sort of 'stickiness' of the boost to the rq, but
> it is somewhat of a pain to deal with if we want to remove it once enqueued
> on a different rq. A sugov 1ms timer is much simpler of course.
> Currently it's not necessary IMO, but for the sake of being future-proof in
> terms of more frequent freq updates I might include it in v2.

Making sure things work with purpose would be really great. This implicit
dependency is not great IMHO and make both testing and reasoning about why
things are good or bad harder when analysing real workloads. Especially by non
kernel developers.

> 
> > 
> > FWIW I do have an implementation for per-task iowait boost where I went a step
> > further and converted intel_pstate too and like Christian didn't notice
> > a regression. But I am not sure (rather don't think) I triggered this use case.
> > I can't tell when the systems truly have per-cpu cpufreq control or just appear
> > so and they are actually shared but not visible at linux level.
> 
> Please do share your intel_pstate proposal!

This is what I had. I haven't been working on this for the past few months, but
I remember tried several tests on different machines then without a problem.
I tried to re-order patches at some point though and I hope I didn't break
something accidentally and forgot the state.

https://github.com/torvalds/linux/compare/master...qais-yousef:linux:uclamp-max-aggregation

