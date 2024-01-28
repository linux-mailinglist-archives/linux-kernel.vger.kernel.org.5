Return-Path: <linux-kernel+bounces-42016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3609483FAFB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 00:33:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E55FD28574E
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 23:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59A9C4595D;
	Sun, 28 Jan 2024 23:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="xkUCCe7x"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5182D446CF
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 23:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706484784; cv=none; b=aKXs3eYV2E8TFBhoEgDXobP60PMRulCZ93TMwwW7jpJzhvijcxvNfR1Q2uQrOL+DxXANW2k41O9HsRDrId2/LyZIpN3bhZbdssSbQvwTYQLf1oq9j2f5YKxuY/I5PnPUhoPam78lsvoP4Cv1WXDsi6zHjarzNbykH8GLs+KOZJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706484784; c=relaxed/simple;
	bh=SGuu+3iE4RlZQwaoMsKXScsaTohl1/2a2dg8UqbNqDA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WzsAuGVd8aq00Tw0DnbE5/rXRu0h0Cbcs3Ks04e74uU71DyW2BnmMUKiMW4RGB7IJOpgPo6zihoY/P4d3ksM4xCqm9Q+XyeS6Tf0I4aZupx9p/nBpSyIihuUTX+E4UPQbOKgIZIJv+JA+fs6eDrEIfbtTxkESFdLCCtszrjQgs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=xkUCCe7x; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40ef207c654so7850355e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 15:33:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1706484780; x=1707089580; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pAPh3t3T8gwSHK3fFX1PEbp1JEaD53zS+zqHNXDYu34=;
        b=xkUCCe7xb5hnF7/G5eC4+bjata2fEA/UsKzii51hEqa1zDVLnDZT2HgCqD9rLX9SMM
         OB+HtrVmQ20m+gQ1TCVlmKlP8VaAPlgejldZm8r3B/9Gqp0b+PLNIO9tgII2TNrAPCAr
         x6pftmPca0GpdoCeRtkJ4vgY1YyGj0eujT5cvzsMqUNWrVz5ttD71ZRNsmTjcN35KY4z
         oZRMyHXlPxqP4/ootJOKjIKv0FF5c5iuH0iACITEvzJPtxGk27zBP+ve6FUxYsGtYd4E
         TjNTmw5GoyHulYiP9/DsFPztDYmLvXomwfW7YE12P/8GzCV/8JDC6aPTGZN0JyGFlD/C
         fvVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706484780; x=1707089580;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pAPh3t3T8gwSHK3fFX1PEbp1JEaD53zS+zqHNXDYu34=;
        b=ecPtHHcgJFOjJhrYH4FRrmR+3qSkAIZFEp8dzpsdntDp6aF4sMy1aJcsRRvx3vFUl+
         qzfQTyPPAMYXiD2Kc8dy/B5zCzgkJ6znJxIDMy7s/C07mv7TC2vtu+deZSFbsDXUWReH
         y/H9HXcaZupZXojxk3VFtevFO70j4d2AvayGiBhTZDlBSrLOAnWeQtU1Lb3eSA8pUGR1
         SfgrSU+9oxTSwQbWwQ/OHi8Spwb4xaUUwLmW+yKIJMXa28Yx7pKwH8AM53ie5l/TK30t
         Pi4WSfDT9Q9JcvvIXNuPteA/28OwsIdYv3p2xXyRX2Nl0Yb25eu7EO+SArsaNfaiaDi2
         qdUg==
X-Gm-Message-State: AOJu0Ywwl2Gbk0jtVG+r6YxixT4NB5mGueO1RVG+gUW4tkuV7J1Js0f8
	kko4gZHxVWp7LGCkTTiviqRsns/qClWb6cWlO0kMAPKLGJhM5Cg4v2XGfAZdUmM=
X-Google-Smtp-Source: AGHT+IFrWEVqvNUKKq5Ig5A1BFlI/2jjIkb1Ylq5XuathEIlswwp77sRIMjCx8j8LQ3ZRkxwWCg/IQ==
X-Received: by 2002:a05:600c:4e01:b0:40e:f539:f6ca with SMTP id b1-20020a05600c4e0100b0040ef539f6camr2082703wmq.36.1706484780362;
        Sun, 28 Jan 2024 15:33:00 -0800 (PST)
Received: from airbuntu ([213.122.231.14])
        by smtp.gmail.com with ESMTPSA id fm24-20020a05600c0c1800b0040ef61dfd48sm2069918wmb.11.2024.01.28.15.32.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jan 2024 15:32:59 -0800 (PST)
Date: Sun, 28 Jan 2024 23:32:58 +0000
From: Qais Yousef <qyousef@layalina.io>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	linux-kernel@vger.kernel.org,
	Pierre Gondois <Pierre.Gondois@arm.com>
Subject: Re: [PATCH v4 1/2] sched/fair: Check a task has a fitting cpu when
 updating misfit
Message-ID: <20240128233258.wwftb36ultqdifu3@airbuntu>
References: <20240105222014.1025040-1-qyousef@layalina.io>
 <20240105222014.1025040-2-qyousef@layalina.io>
 <CAKfTPtBTbudKM3Lxv0dQ4EXchLW9G8LszArzp6phzhND4O7XSw@mail.gmail.com>
 <20240124223842.zjsolwhp26w7vowu@airbuntu>
 <CAKfTPtAHQ9vJK_GZdpDC3GzHYWnzLc9USFNW9LSONcWVxybwrA@mail.gmail.com>
 <20240126020743.tca257nvnlpyya2y@airbuntu>
 <CAKfTPtAincvMD8GGJsk32-chXCsvgMrPikf=z97kRy=5R-kXgA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKfTPtAincvMD8GGJsk32-chXCsvgMrPikf=z97kRy=5R-kXgA@mail.gmail.com>

On 01/26/24 15:15, Vincent Guittot wrote:

> > > TBH, I don't know. I would need time to think about this...
> > > May be when we set the new affinity of the task
> >
> > I was thinking to actually call update_misfit_status() from another less
> > expensive location.
> >
> > We can certainly do something to help the check less expensive if we must do it
> > in pick_next_task(). For example set a flag if the task belongs to a single
> > capacity value; and store the highest capacity its affinity belongs too. But
> > with cpuset v1, v2 and hotplug I am wary that might get messy.
> 
> I think it worth looking at such solution as this would mean parsing
> the possible max capacity for the task only once per affinity change

Okay. It might not be that bad and just need to do the parsing when we update
the cpus_ptr, which seems to happen only in set_cpus_allowed_common(). I think
I can create a wrapper for fair where we do set_cpus_allowed_common() then do
the checks to discover the max_allowed_capacity and whether the new affinity is
asymmetric or not.


Cheers

--
Qais Yousef

