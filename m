Return-Path: <linux-kernel+bounces-42674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E72DC8404BB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 13:14:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53E06283E4B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 12:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D94CA604C6;
	Mon, 29 Jan 2024 12:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PTISgWzx"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5D5604B8
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 12:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706530405; cv=none; b=XQ8+4jV9h0SDHQZSuPxUvIAby5oN3lU+V5gEHo/0fy53RKOkxkKPQYZYHjVkmGn04eO1x0ZzSzziZXRODbnHn2vp3qYHhsAxDtP8cV0ymbbsussWbws7EArlGxd20nh7TyDKtrjYXOqWGNPZWimLnvUn6LpYWigyGRQRkxlrLlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706530405; c=relaxed/simple;
	bh=WLvrHrbgSBFuvT4E7HlrAAw1sNsWn7JBXxbApEH6mhE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=REA3vx9KqQnRxCUlh4dyrfbEZvVguvBDXHpMdsfukbumbAPw90ZgSS2Vev8i0bmhXzqigOZcyaruEHb+nogiGMBmAwY4mnCeTMtcSwSwKP8lkrtgjPLCWNx6MSSzPx+4GDMrYSKKHDeGNaACU1WMC/RPex5gwXyQi5jmbsD4f7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PTISgWzx; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d8da50bfd9so3077245ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 04:13:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706530403; x=1707135203; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hoaRRVJZbpwuRBmsx74Q+sew1YTbfPVtekdObdLjHlE=;
        b=PTISgWzxBsKKdQOw2Xjf2BD9ijlLC1o1mW8m50l42sJGPHEHkrPHFud0PTHj/XmCUp
         X9C+idBG4yUYOAORQp8HieTBxfWnS8OZN7OkraLFZTsPDjs/8GP2tMvD3FnkqP7AY3i8
         z+A5QJaChkoFPIKIHIi1MrfKkjfLqbW6gAK1MjsRyL+5+Qo2Ju/dxVVb0usZVTf5B1ZV
         RQBOrJSiDvzBrQSKu4bGz1rogX3+jhUAHzaV/iFCZoeW3ldfw2oKybmIqMUegm24ovku
         ngQ0DVJi8ZKbGYP511lDiyU0j75Ee/fYk4EZCcqeiYha24EIxCIfL1Ek/uLOqaUqGmnl
         vlAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706530403; x=1707135203;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hoaRRVJZbpwuRBmsx74Q+sew1YTbfPVtekdObdLjHlE=;
        b=mAqAw4L2q0e+kQrRg1YE/ypoasOxX6nADJEkpwW8otC8qqmhZWok+SxEnMTJA3owXh
         onOnprCfRqJ9TeKU+0wEEoqasfeUfzG1e5Ph0YWj2z9I3wDJ2EROb6trow8U0hYBevr5
         wYqjnEA3RYRPESwMVTWkcw+V2D1yRCL2v+kt15kpCHLrd1EcVhCAekLpAeuJqbNWCPCF
         PswsYsCUu+1KlVfZWmS6oAVzKmpI5FKEIJDI8oE/ZZpZNj3038gzHXdBo0B9sWk3P+4w
         tfLUAmqXIE0X9iJEQFE3KJ/jZJ4ddhB37xRNImDD3ELhZutZSMG9D+2uJplhj15AAJlB
         gA2g==
X-Gm-Message-State: AOJu0YyOn4Sj5Sv+Cw8Mbxuz7SS2YDkxjB+GRYxdS43nCIqerfGzx2Jv
	oMiWh1pnHmm5rpxnIKHIevyVx4neHNagPpTkKgdrdNWKsBvNT7I2gMfiED5u
X-Google-Smtp-Source: AGHT+IGe75wXRfHfhKAZFoV1YLgi2pirWtWkd84BfMTXVJ46oMR/sFEsWExHX0KeLGpQuF/FiHFUMA==
X-Received: by 2002:a17:902:6804:b0:1d4:e04b:4742 with SMTP id h4-20020a170902680400b001d4e04b4742mr2117030plk.58.1706530403008;
        Mon, 29 Jan 2024 04:13:23 -0800 (PST)
Received: from cuiyangpei ([43.224.245.227])
        by smtp.gmail.com with ESMTPSA id s10-20020a170902ea0a00b001d714a1530bsm5242067plg.176.2024.01.29.04.13.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Jan 2024 04:13:22 -0800 (PST)
Date: Mon, 29 Jan 2024 20:13:16 +0800
From: cuiyangpei <cuiyangpei@gmail.com>
To: SeongJae Park <sj@kernel.org>
Cc: akpm@linux-foundation.org, damon@lists.linux.dev, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, xiongping1@xiaomi.com
Subject: Re: [PATCH 1/2] mm/damon/sysfs: Implement recording feature
Message-ID: <20240129121316.GA9706@cuiyangpei>
References: <ZbYanPU16klwz0HA@cyp-ubuntu>
 <20240128162804.17866-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240128162804.17866-1-sj@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)

On Sun, Jan 28, 2024 at 08:28:04AM -0800, SeongJae Park wrote:
> On Sun, 28 Jan 2024 17:13:00 +0800 cuiyangpei <cuiyangpei@gmail.com> wrote:
> 
> > On Fri, Jan 26, 2024 at 12:04:54AM -0800, SeongJae Park wrote:
> [...]
> > > So, 'update_schemes_tried_regions' command is firstly handled by
> > > 'damon_sysfs_cmd_request_callback()', which is registered as
> > > after_wmarks_check() and after_aggregation() callback.  Hence
> > > 'update_schemes_tried_regions' command is still effectively working in
> > > aggregation interval granularity.  I think this is what you found, right?
> > > 
> > Yes.
> > > If I'm not wrongly understanding your point, I think the concern is valid.  I
> > > think we should make it works in sampling interval granularity.  I will try to
> > > make so.  Would that work for your use case?
> > > 
> > It's much better than working in aggregation interval.
> 
> Thank you for confirming.  I will start working on this.
> 

Great, looking forward to seeing the progress.

> > 
> > I have a question. Why does the 'update_schemes_tried_regions' command need to work
> > in the sampling time or aggregation time? 'update_schemes_tried_regions' is a
> > relatively special state that updates the regions that corresponding operation scheme.
> > Can it be separated from other states and controlled by sysfs node to respond immediately
> > after being written?
> 
> Mainly because the region data is updated by a kdamond thread.  To safely
> access the region, the accessor should do some kind of synchronization with the
> kdamond thread.  To minimize such synchronization overhead, DAMON let the API
> users (kernel components) to register callbacks which kdamond invokes under
> specific events including 'after_sampling' or 'after_aggregate'.  Because the
> callback is executed in the kdamond thread, callbacks can safely access the
> data without additional synchronization.  DAMON sysfs interface is using the
> callback mechanism, and hence need to work in the sampling or aggregation
> times.
> 
Thank you for the detailed explanation.

> Thanks,
> SJ
> 
> [...]

