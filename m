Return-Path: <linux-kernel+bounces-130206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E5BC897560
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 18:39:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C267A1F26CE0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 16:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7629E14F9C3;
	Wed,  3 Apr 2024 16:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SJDAfjfn"
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C66E13A88B;
	Wed,  3 Apr 2024 16:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712162346; cv=none; b=NaAauvL2bJqmj2hQwz2FHKfRvavyfSsnwv0jEKVNUELm8xkfO9G+w8zpEUoREtdpcGRG7YKc2lwtlDf/wqtIEopQGPT36tQx71n/orqUk4qWZRRQ86jFxGaVcUcS/TQ7HSQzLFmHcegtd9z2bxhIcel0EozoaknJV5QyXgabgLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712162346; c=relaxed/simple;
	bh=04A2OHYO7oPpV0UwEippYwFJ8UjAkwsNYssEoylXMfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X7aU1hKbVJqFshZpyRsqEJPMGCQrBRbnJT2bMkNpOTHPA/SF88jvVjKSsEZO4qWcrSCDROmbLJRC+SPfBnXjveqCW5Eier/VF1k0gtYug1ydf8y6k5Sd39d+DM9X5OlGm46AFhB/LFq4sfgRctWZUj2ZmcqVl7hgqLSI+fXBAwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SJDAfjfn; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-61428e80f0cso321507b3.2;
        Wed, 03 Apr 2024 09:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712162344; x=1712767144; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xiQAnoqBtNMPeYbXhP6YbiPb7pzyLlVXR6yIGlyZoxw=;
        b=SJDAfjfno+xlJySt9EUd6Wx7O45W7piNHdbElBJpVpUv1tTvVVM2la9ic415Ipdy+1
         sKxHzZdoeP9GXwLfRCNkm8bEBOeGelAXUjDAtakmgpXR0Aa+JgwvQ4p+JaAcfO3ftgns
         RX3O12eOrlpGdr6MzlCz7SMmuOWlzOes0LM6XA0GF5S1dYdRPnCYT/xDf+/lH+a/jK49
         ljBcFQbrti7sYWgDmx1Ry2t5+GUQ3po1GYS5yMyJmZjaIfAubxslEMMXM/hQjT5bLtQn
         P7ize0YfRkBm+w1abzQRPwGbJxzTSKScvVgsZZMVchaAdkOg955xMo+cTAq5VZ0/+HO9
         /8Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712162344; x=1712767144;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xiQAnoqBtNMPeYbXhP6YbiPb7pzyLlVXR6yIGlyZoxw=;
        b=HBMb7OUYdedDDiEYSHxEoMUMoDqB0Nnzx3SUGnZkuRwwCfkIBlzA6L5/pc5Z87eLS0
         qAlYNrKxdVRvw+m5p0Tf1dxA8MMcNdD33ymd5QA3mYJ4zFkVjVNqT7Pm3sOxj4HSV60w
         v2Oj0TI+Z2yOUwxhVebRHHNxvAh4JiVHUs0QuuxJ8ooyvViqiqannInZ4JygIqSaOTeG
         lWEiHh2yzvty3zYgN5kbKibgptIsuwAkJ6M7YSy8GBUQNcBjhoE0sVF3G5xVwUoEwAFi
         8NIjPr3OEat6cOLCTLRMikT7bNXb+CY4jDP9YlKVdXhvPwdlbXysNu5iTuSwATdxU1/2
         g55A==
X-Forwarded-Encrypted: i=1; AJvYcCVGhBmgk2zLjAf1Yi+ZCf7H50jMLHMh3ulGwUEsdyWNIQVZPgOxAZ7OpfmGo9UOXx0xOj1GPYWFV7B24SKk3mle1qR39ZJnAN2FIkJ0KWsxihI+A0E4esfRnzWYyEy313ha8JUYFcLVvEggIQ==
X-Gm-Message-State: AOJu0Yz1TJaYRbGhMkfrpobo6wKLrFu59eyrzMOVmjGbw1DSfU9QNvhO
	wJsYvHu+wz6FTqH2VzL1gOGwQUyWvs+m5p1JAF8biRnRt1g+2Lx/
X-Google-Smtp-Source: AGHT+IEayt2KU+YUNlfHvnp9fdUlFxEUvZ1E9Dnu+VFBi44KnDiK0FddM7x7AwhX2siDCFp/NXRJXw==
X-Received: by 2002:a81:6054:0:b0:615:1860:551 with SMTP id u81-20020a816054000000b0061518600551mr3174145ywb.30.1712162344022;
        Wed, 03 Apr 2024 09:39:04 -0700 (PDT)
Received: from localhost ([2601:344:8301:57f0:e71b:60d3:a7cd:425b])
        by smtp.gmail.com with ESMTPSA id u68-20020a818447000000b006150c4478a5sm1227398ywf.102.2024.04.03.09.39.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 09:39:03 -0700 (PDT)
Date: Wed, 3 Apr 2024 09:39:01 -0700
From: Yury Norov <yury.norov@gmail.com>
To: Dawei Li <dawei.li@shingroup.cn>
Cc: Mark Rutland <mark.rutland@arm.com>, will@kernel.org,
	linux@rasmusvillemoes.dk, xueshuai@linux.alibaba.com,
	renyu.zj@linux.alibaba.com, yangyicong@hisilicon.com,
	jonathan.cameron@huawei.com, andersson@kernel.org,
	konrad.dybcio@linaro.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 00/10] perf: Avoid placing cpumask var on stack
Message-ID: <Zg2GJdio2YSAkqZr@yury-ThinkPad>
References: <20240403125109.2054881-1-dawei.li@shingroup.cn>
 <Zg1qgxqrEi3sX3CA@FVFF77S0Q05N>
 <5BCB924A8FA6320A+Zg1/xw9C493rZ868@centos8>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5BCB924A8FA6320A+Zg1/xw9C493rZ868@centos8>

On Thu, Apr 04, 2024 at 12:11:51AM +0800, Dawei Li wrote:
> Hi Mark,
> 
> On Wed, Apr 03, 2024 at 03:41:07PM +0100, Mark Rutland wrote:
> > On Wed, Apr 03, 2024 at 08:50:59PM +0800, Dawei Li wrote:
> > > Hi all,
> > 
> > Hi,
> > 
> > > This is v2 of [1] and [2] which basically eliminate cpumask var allocation
> > > on stack for perf subsystem.
> > > 
> > > Change since v1:
> > > - Change from dynamic allocation to a temporary var free helper:
> > >   cpumask_any_and_but().	[Mark]
> > > 
> > > - Some minor coding style improvements, reverse chrismas tree e.g.
> > > 
> > > - For cpumask_any_and_but() itself:
> > >   - Moved to cpumask.h, just like other helpers.
> > >   - Return value converted to unsigned int.
> > >   - Remove EXPORT_SYMBOL, for obvious reason.
> > 
> > Thanks for this!
> > 
> > The logic all looks good; if you can spin a v3 with the updated commit messages
> > I reckon we can queue this up shortly.
> 
> Thanks for review.
> 
> v3 respinned:
> https://lore.kernel.org/lkml/20240403155950.2068109-1-dawei.li@shingroup.cn/
> 
> If it's going through perf tree, do we need Acked-by from bitmap
> maintainers for patch[1]?

There's only one bitmap-related patch, so I agree - the series should
go through Mark's tree. I acked 1st patch in v3. Please go ahead.

Thanks,
Yury

