Return-Path: <linux-kernel+bounces-96928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35110876343
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 12:26:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B44361F220DA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 11:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DE6D55C27;
	Fri,  8 Mar 2024 11:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HGLkbCIi"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C975555C3F
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 11:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709897129; cv=none; b=B9hHXFUImkF2LdOKpkyr4tPWzWj68adJ3JcYPZlKC8KrTH+Ah0tw8CBQg5qtGlpg/8yYkCesoRGBIVuskp8EENs1lgGJq6lC/lCxhvRhMkANVZcEAorfIeXsyM/l2OHpgUw//tqtuqWNKFV7kfG2hH39gfCh1t8UrLz+x0wqqX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709897129; c=relaxed/simple;
	bh=/cOUoq0pPmQJ/61Wbw6wQLXN/7hfj8X2V4O0MdPSRCo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ImGbc4/jMEHASkSDLbWQJU4lnHcER1VOUsprxC/11yohr9PaDIgAX45XwxBBypd5xvk5u008g7tvDaKygh9cpcK41PrOJcxWCcnKQn9CVpgXxWaXvHMdoauUxdBLyu30m9XAj3XGAsx4ibkCAq6gOIHkjntanNnB9CmDYiiLFbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HGLkbCIi; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-412f0655d81so5684235e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 03:25:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709897126; x=1710501926; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fNeg4yhr/3u8GpTRBFZQZ6wGSUgg4jp42cdMOAyaLTI=;
        b=HGLkbCIiPU6WjM39f6VeRQH8p8CgXf587j/18uvf3Txyx/4bB/hByu3gbj+ydl+IIA
         qzZ+pw3NOYc+lBW9wnBXQPCZF1q3VwHicJgockk9xZkMrP2ERJy1T3BqQI76lv1K4UW0
         6apJM6TPiIsBGxXUKQwENpiGELP49611MjiDY3DVo7lH7w4QJUD643pldXoUTCgmVqJW
         CqjVBUDrYXZ0Au9TDwzusALSASgpFPjB7zHq79weKI2Jb+j2su150sGFbUuydKFp2eEG
         +cyrC3JxB2y+ZBXwlg3NBVpOCE0KxBA7EELcjZ6SwSHLLIxcN/+gskI1MJWswR6YQJEG
         82jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709897126; x=1710501926;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fNeg4yhr/3u8GpTRBFZQZ6wGSUgg4jp42cdMOAyaLTI=;
        b=lsRoMWz6sBo9k+p/jh0G58ePgPohbgA5Hdle5IMgOfJH5KQXAYADLynxmmAxHhqBXA
         p0he2/STyIDsYsJeL7RFZRoAigTBPUn1UWI83kl1mf4ucT0bgz8MMgC6/IJuXTd2WHEt
         vV+RYh6iTNVa3NySKojTUHRuVMXSkAifn5vLFImGzBTyZlsI9ElP0Lw+PknjRXUUS1ha
         5nQQnxs4QWPT5iBW5/2MsGYpnterCsni5Uvs2InLjuYCeYwz5EnXQMvzzy8ajpXi3QD+
         s65pvJbsQ41DzW3Z2O3EwdV5t22GEtBUTE3gP9Ne4CY6DuZ2cEpV2ldzAyUHzoe85Aar
         ftTw==
X-Gm-Message-State: AOJu0YwPB6uzT9lRp+G+RWFghHKAAW2kT0hkzD0RiqTm9HNkCgfWClA1
	i4S4de7CjwKPdy97q7h8HTZYiJODn3cZ1ZHdeHTEidEzQJdbg9VYlYC3EQLPfck=
X-Google-Smtp-Source: AGHT+IF1o0ARx6QuADTerrZixpK7ROXUJEOweAJ3Mbwtdo5g8jTYpI9ABpgoUirtJDSn8bJfJRqnKw==
X-Received: by 2002:a05:600c:1c0a:b0:412:eef2:f92c with SMTP id j10-20020a05600c1c0a00b00412eef2f92cmr6845785wms.31.1709897125996;
        Fri, 08 Mar 2024 03:25:25 -0800 (PST)
Received: from gmail.com (1F2EF3E5.nat.pool.telekom.hu. [31.46.243.229])
        by smtp.gmail.com with ESMTPSA id bq26-20020a5d5a1a000000b0033e2777f313sm18040865wrb.72.2024.03.08.03.25.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 03:25:25 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Fri, 8 Mar 2024 12:25:23 +0100
From: Ingo Molnar <mingo@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH -v1 00/13] sched/balancing: Standardize the naming of
 scheduler load-balancing functions
Message-ID: <Zer1o5bhkiq1cxaj@gmail.com>
References: <20240308111819.1101550-1-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240308111819.1101550-1-mingo@kernel.org>


* Ingo Molnar <mingo@kernel.org> wrote:

> Over the years we've grown a colorful zoo of scheduler
> load-balancing function names - both following random,
> idiosyncratic patterns, and gaining historic misnomers
> that are not accurate anymore.
> 
> We have 'newidle_balance()' to rebalance newly idle tasks,
> but 'balance_domains()' to rebalance domains. We have
> a find_idlest_cpu() function whose purpose is not to find
> the idlest CPU anymore, and a find_busiest_queue() function
> whose purpose is not to find the busiest runqueue anymore.
> 
> Fix most of the misnomers and organize the functions along the
> sched_balance_*() namespace:
> 
>   scheduler_tick()		=> sched_tick()
>   run_rebalance_domains()	=> sched_balance_softirq()
>   trigger_load_balance()	=> sched_balance_trigger()
>   rebalance_domains()		=> sched_balance_domains()
>   load_balance()		=> sched_balance_rq()
>   newidle_balance()		=> sched_balance_newidle()
>   find_busiest_queue()	=> sched_balance_find_src_rq()
>   find_busiest_group()	=> sched_balance_find_src_group()
>   find_idlest_group_cpu()	=> sched_balance_find_dst_group_cpu()
>   find_idlest_group()		=> sched_balance_find_dst_group()
>   find_idlest_cpu()		=> sched_balance_find_dst_cpu()
>   update_blocked_averages()	=> sched_balance_update_blocked_averages()

Forgot to mention that this series is on top of the scheduler tree 
(tip:sched/core) plus my other pending queue:

   https://lore.kernel.org/r/20240308105901.1096078-1-mingo@kernel.org

Thanks,

	Ingo

