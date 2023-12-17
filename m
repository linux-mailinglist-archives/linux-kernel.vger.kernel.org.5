Return-Path: <linux-kernel+bounces-4238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8851D81797E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 19:19:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7315284161
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 18:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C6CD5D746;
	Mon, 18 Dec 2023 18:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="Axs4Ivw/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8025BFAC
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 18:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40d12ade25dso21718755e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 10:19:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1702923575; x=1703528375; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wngOefNv+z6F34iAlT1vTTC0xRYTMvpTjWKXnGOQBpw=;
        b=Axs4Ivw/LVR6wXDIgkeETJk8VxIH2znyzG0XGSSY5wb20qZpTkjoMTNjKy1yLysnL0
         RZOc7uLW55tJ1Kj6W0J6I+nDtpRnN2n6Lh8/Lw3hy1Lgimm9Un3ol2fI05D7y2qthquB
         NIwcAJyXs42v9hzhASLi6oQKzbDIOy/r9D3486ur2kNtY8kuMKE6vrP5o1bMFvHouKis
         WJmfSRQrbUjn1vy1puM4zEd/uSOQYnREl/E/V+Ly01NqFNll3IIwGuvHwWcl4GiwABqX
         5N7iJcUY/OIioJwVSp0ZjcjaqsTsWjFDLKNTpc5hkmvFehlM9mQ3D8i/ev7Zeraod7ly
         sD4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702923575; x=1703528375;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wngOefNv+z6F34iAlT1vTTC0xRYTMvpTjWKXnGOQBpw=;
        b=aZUrSEBqWZzofRA9QtBHOeerLDRNMBi57Ai+S+odPJjqbFQkz3Q8+0FQbBf/Q3XJ0G
         eM71kQD4n2r/PVGsgLm2m2p2pBIyzgXBWwWCFfKr1vSuxrA/QGXBWZYjYxSF4nVpYFV0
         W9lGv96gkULv/6F6EEjnvRiaRNUeqA+lHLJldeFbuc6TPhIpofyRGW78mjMEsRPDyz/w
         VTFTvJQRHMR6piRi+5XnqhcqeR4y7d9q4QSUJv28CqCTfjsa78+HkRHY0G49ZGKDADWZ
         qdTeaA7GHt4dWLrNlkJeEaeFg0oS/icGv2XbXbk5RnIe6vjbbZGoC99N1THxbt2rJGXT
         5e8w==
X-Gm-Message-State: AOJu0YwU+K/BEBVCxOl2xRAWDlEQMJQHPVtSdDl70s7uy2sy6kTz09QQ
	Fh4S7DPjZgwoYMtCNTOf7N+CpQ==
X-Google-Smtp-Source: AGHT+IE8TGKpR7h58VoFinOm8qiIsJoctzMe6kl9K+yyn18hvEFRCCJaQY587qUcggqnBYSzX1gryg==
X-Received: by 2002:a7b:ce08:0:b0:40c:2964:5570 with SMTP id m8-20020a7bce08000000b0040c29645570mr8591538wmc.61.1702923575256;
        Mon, 18 Dec 2023 10:19:35 -0800 (PST)
Received: from airbuntu (host86-135-101-43.range86-135.btcentralplus.com. [86.135.101.43])
        by smtp.gmail.com with ESMTPSA id v6-20020a05600c444600b0040c4886f254sm32817208wmn.13.2023.12.18.10.19.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 10:19:34 -0800 (PST)
Date: Sun, 17 Dec 2023 21:44:55 +0000
From: Qais Yousef <qyousef@layalina.io>
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	Lukasz Luba <lukasz.luba@arm.com>, Wei Wang <wvw@google.com>,
	Rick Yiu <rickyiu@google.com>, Chung-Kai Mei <chungkai@google.com>,
	Hongyan Xia <hongyan.xia2@arm.com>
Subject: Re: [PATCH 1/4] sched/fair: Be less aggressive in calling
 cpufreq_update_util()
Message-ID: <20231217214455.5rf67ezdrwqdvwwh@airbuntu>
References: <20231208015242.385103-1-qyousef@layalina.io>
 <20231208015242.385103-2-qyousef@layalina.io>
 <212396c7-8c36-4850-8871-ea4c757a9324@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <212396c7-8c36-4850-8871-ea4c757a9324@arm.com>

On 12/18/23 09:51, Dietmar Eggemann wrote:
> On 08/12/2023 02:52, Qais Yousef wrote:
> > Due to the way code is structured, it makes a lot of sense to trigger
> > cpufreq_update_util() from update_load_avg(). But this is too aggressive
> > as in most cases we are iterating through entities in a loop to
> > update_load_avg() in the hierarchy. So we end up sending too many
> > request in an loop as we're updating the hierarchy.
> > 
> > Combine this with the rate limit in schedutil, we could end up
> > prematurely send up a wrong frequency update before we have actually
> > updated all entities appropriately.
> > 
> > Be smarter about it by limiting the trigger to perform frequency updates
> > after all accounting logic has done. This ended up being in the
> 
> What are the boundaries of the 'accounting logic' here? Is this related
> to the update of all sched_entities and cfs_rq's involved when a task is
> attached/detached (or enqueued/dequeued)?

Yes.

> 
> I can't see that there are any premature cfs_rq_util_change() in the
> current code when we consider this.

Thanks for checking. I'll revisit the problem as indicated previously. This
patch is still needed; I'll update rationale at least and fix highlighted
issues with decay.

> 
> And avoiding updates for a smaller task to make sure updates for a
> bigger task go through is IMHO not feasible.

Where did this line of thought come from? This patch is about consolidating
how scheduler request frequency updates. And later patches requires the single
update at tick to pass the new SCHED_CPUFREQ_PERF_HINTS.

If you're referring to the logic in later patches about ignore_short_tasks();
then we only ignore the performance hints for this task.

Why not feasible? What's the rationale?

> 
> I wonder how much influence does this patch has on the test results
> presented the patch header?

The only change of behavior is how we deal with decay. Which I thought wouldn't
introduce a functional change, but as caught to by Christian, it did. No
functional changes are supposed to happen that can affect the test results
AFAICT.


Cheers

--
Qais Yousef

