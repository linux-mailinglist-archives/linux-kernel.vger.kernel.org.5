Return-Path: <linux-kernel+bounces-25952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A6782D8BB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 13:09:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68CE41C21AA0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 12:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA3312C69B;
	Mon, 15 Jan 2024 12:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="RCi34D8z"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D3582C68E
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 12:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-336dcebcdb9so8138278f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 04:09:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1705320557; x=1705925357; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lHqStiU3DTr4MEjcnV54wjLfvfW45DqHZ0To2Q8HWU4=;
        b=RCi34D8zn4wQneAy8vwapJErXPDGUH1HRV8LiXo6vDpSeatW7gLgAUAlMP9eVGR0TH
         Jnm8F5+OgBHwXKUGFZwLKxFWvLz695aiWv2zstnZnOKEUlWV71Bjq6XSQazdBDkUkIpo
         3W8YNQD6gnVhfvkCeLjbQMiXuwuofNfl+GfARTTFe9/YXbPf4B4sRJak/h6a+EO3qinA
         GDE+egA/aQbk+0siDMqrpCQh9l92Y0PIAI+cB8dIICOqKVfCRqSkYVYZbrwwXz7s495V
         yGutAEVot0spSLELCnWKjVYpx4ulLzHJkkVCoThsWcOYXUCDbJS+Bc50pEx25PHJM2aE
         qa7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705320557; x=1705925357;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lHqStiU3DTr4MEjcnV54wjLfvfW45DqHZ0To2Q8HWU4=;
        b=BCG7U7i6Lr76hHc3D0fbsJ657/OXZfaXdn1PZyisjntd/mg8WUpjetDWO9T4lkjPrY
         NL6ALiQvaG25a4e9VVqM3r/KF7k3jX9iFR2Za+6aJzPxYjzamJVkpozyBlr/IyLTAaYr
         VJNBHgoZ3hHD8HcsH5mmnbDRuPwTZ2WNiT/fM4kml90pE+0XT4K6V1JjFn4IwnGG1CZK
         eqoYnbjLwl3BkCn5nk7iy/+OBgjsHW8jrpXYxhNT4L/XVKQhD5cZaGe9M8E3Ugw2gtJE
         TE23HFRfmMdgtd7u7Sl2M3k1CR96+qYNvlrmRJAXZ9Z4JqMrRFDK+9K06muE/+/E4xz3
         9SCA==
X-Gm-Message-State: AOJu0Yw/f0tZ3xMPPQZ1SutfnGb/mOcqs5Nto2mzFAUJfwwNpQ/crUBd
	mWmrpOErjFt2N+M661LyLtMv243AEnkuGA==
X-Google-Smtp-Source: AGHT+IHgNGzHpuByqYHr3BXOy6HeZPr5PStHsIMl5dJOL3BEM+vGj4exiMepi1u8RI6pZXEK+X5c4g==
X-Received: by 2002:a05:6000:1e8c:b0:337:5a17:86fa with SMTP id dd12-20020a0560001e8c00b003375a1786famr1549571wrb.108.1705320556684;
        Mon, 15 Jan 2024 04:09:16 -0800 (PST)
Received: from airbuntu (host109-154-205-127.range109-154.btcentralplus.com. [109.154.205.127])
        by smtp.gmail.com with ESMTPSA id v2-20020a5d5902000000b00337a6feab88sm3421977wrd.100.2024.01.15.04.09.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 04:09:16 -0800 (PST)
Date: Mon, 15 Jan 2024 12:09:15 +0000
From: Qais Yousef <qyousef@layalina.io>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Wyes Karny <wkarny@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Juri Lelli <juri.lelli@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>
Subject: Re: [GIT PULL] Scheduler changes for v6.8
Message-ID: <20240115120915.fukpcdumntdsllwi@airbuntu>
References: <CAHk-=wiXpsxMcQb7MhL-AxOityTajK0G8eWeBOzX-qBJ9X2DSw@mail.gmail.com>
 <CAHk-=wjK28MUqBZzBSMEM8vdJhDOuXGSWPmmp04GEt9CXtW6Pw@mail.gmail.com>
 <20240114091240.xzdvqk75ifgfj5yx@wyes-pc>
 <ZaPC7o44lEswxOXp@vingu-book>
 <20240114123759.pjs7ctexcpc6pshl@wyes-pc>
 <CAKfTPtCz+95dR38c_u6_7JbkVt=czj5N2dKYVV-zk9dgbk16hw@mail.gmail.com>
 <20240114151250.5wfexq44o3mdm3nh@airbuntu>
 <CAKfTPtAMxiTbvAYav1JQw+MhjzDPCZDrMLL2JOfsc0GWp+FnOA@mail.gmail.com>
 <20240114195815.nes4bn53tc25djbh@airbuntu>
 <CAKfTPtCGgJiFDrZYpynCiHBnQx48A9RsAY9-6Hshduo4ymGJLQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKfTPtCGgJiFDrZYpynCiHBnQx48A9RsAY9-6Hshduo4ymGJLQ@mail.gmail.com>

On 01/15/24 09:21, Vincent Guittot wrote:

> > Or I've done the math wrong :-) But the two don't behave the same for the same
> > kernel with and without CPPC.
> 
> They will never behave the same because they can't
> - with invariance, the utilization is the utilization at max capacity
> so we can easily jump several OPP to go directly to the right one
> - without invariance, the utilization is the utilization at current
> OPP so we can only jump to a limited number of OPP

I am probably missing some subtlty, but the  behavior looks more sensible to
me when we divide by current capacity instead of max one.

It seems what you're saying is that the capacity range for each OPP is 0-1024.
And that's when we know that we saturated the current capacity level we decide
to move on.

As I am trying to remove the hardcoded headroom values I am wary of another
one. But it seems this is bandaid scenario anyway; so maybe I shouldn't worry
too much about it.


Cheers

--
Qais Yousef

