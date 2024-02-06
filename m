Return-Path: <linux-kernel+bounces-54254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 594AD84ACDA
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 04:27:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AFE11C2265A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 03:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69B6373180;
	Tue,  6 Feb 2024 03:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WFrXd+Kc"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E58A6EB68
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 03:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707190026; cv=none; b=BngH4JxpmwIsdp1BaeIXO1vV1duuPG22xoM+aEkPuVvcor1abzVbqRGNLCK/3drTgBJysqwPBrMA7/AgUp3GEAvwocbND7l/gWlx8TmXtIgLOmMWl1wRgX0812iKewD4Akg9L+O71oKn3APXL4gWD+/GUcwVKDgWCvnA2FCO8ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707190026; c=relaxed/simple;
	bh=Z/8kCrneIaAo61lJzR1eoZAFPuxh04I96DLlFzqiKkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TGrYeZor7FzCmxObOdd/lo4R/s7D//0OuC01v0LP9eIvsO8nTTrGHSAi+EYHvDIXNheQIgsjhGyWQigGz+FaoKlGo88z2iDtqDtDDCP/Oq0WNFj1yE8Sk0yN+Y7Q/bY3qc//3MQGpOlehw1bB6F8a9aqNVT0WsziFupjutAFexg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WFrXd+Kc; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6e054f674b3so413496b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 19:27:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707190024; x=1707794824; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EWmE4W0F6JzWR2V7Cfi7Q0WB8ukiHYzdqVQ4h9OXpcs=;
        b=WFrXd+KcmqB2cYPdWXof0tpZt8P06xdhUzxSAACAgYDqQAn4DNI0CMCRYiK3x6eg04
         EkdprninHJnu2rwBH/C1aV38Ej9ycny5mKxPN3VdEfriT5BQHE9YdScs7QJbtkVRzTWA
         /e6h7zJJtWUl7mdZ/bq5wH8+xO5pqz3YP8Gk09eQ0Es2QxFh1PgC7c2Nwq8IrQMboGTW
         0gFuCUYpmgurxsbny4HhgDCHmxQ68keZfACnFct8XxUFF47BpMKUt0YcIHELAPfSdyNz
         f2hQClHOgd7G02NrDBQ834EQQ45mlIIa7Rsxfm82PDVKh1BAqqinTwIDw8Tb7zfdMJRP
         a2kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707190024; x=1707794824;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EWmE4W0F6JzWR2V7Cfi7Q0WB8ukiHYzdqVQ4h9OXpcs=;
        b=oxrLnWqytnC0V91E1PMU4c2T9fUtkP8/dYXPD5TET8xX7yqVYS05/4fGHkZK5LgWO8
         2wlsdwv4TTu8UpkyAFWbl4fZSLXJdA7XOHv8ptzBMfAIqKE26CkjI9rKFWPbF9u+yWhr
         wHmPlgZYZH+Hp31iZy/mPAvI6R7M8ZUxPNhL9INNXDM9yut4ea0tf8t/Qyux1EWqrtgJ
         2BN1yq49bLcB+ooK5jpvNoo14ZR0p9R0kQ4neoqjy0yMrTGLw36EfT0wuWh3DN7gK5fo
         K4K3qdndzLVyorV1+BxI3KpFd5pISyu/tX0IP6Z2cN8ltrZPwZ6Wa8rXTaXdlvk+N/vN
         nViA==
X-Gm-Message-State: AOJu0YwbiL7okFL5iMOvMJ5c/6Uo+TED+OAIB6AzEOnwlK6IANO0iHpz
	uexM74DLub7aAuywhiMrkw/cM6FJsd/62Ar1iwEDvUytfYN2UNJu
X-Google-Smtp-Source: AGHT+IFcLAO3UlSWN5NwuxhRD3zbinWJslbqmyaRKdP55n6E6QCBvshFD0VOa6+HmXyocmdEJv6olA==
X-Received: by 2002:a05:6a00:1acf:b0:6dd:c7ea:29e with SMTP id f15-20020a056a001acf00b006ddc7ea029emr1709495pfv.12.1707190024482;
        Mon, 05 Feb 2024 19:27:04 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVOoTZB6QeEbsv+OMvjJIOJR9yNONXJ6Fa3btU7RT25GjtJvKHYD/g7kMHQrmp3NKnj1SzGTJg3zPzz98MjmbnGyyYQqNTjKP0uCCkgGrx2mW8D1APiQCivyRJsioj30os47Nz01o3SGML1y64mrfMzQOPzFNiB+8HzAb9UL1AgPK9i/uRuyGb4nRAtZcnJ
Received: from cuiyangpei ([43.224.245.227])
        by smtp.gmail.com with ESMTPSA id t12-20020a62d14c000000b006dfef3ed2d4sm689223pfl.110.2024.02.05.19.27.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2024 19:27:04 -0800 (PST)
Date: Tue, 6 Feb 2024 11:26:59 +0800
From: cuiyangpei <cuiyangpei@gmail.com>
To: SeongJae Park <sj@kernel.org>
Cc: akpm@linux-foundation.org, damon@lists.linux.dev, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, xiongping1@xiaomi.com
Subject: Re: [PATCH 1/2] mm/damon/sysfs: Implement recording feature
Message-ID: <20240206032659.GA6910@cuiyangpei>
References: <20240129121316.GA9706@cuiyangpei>
 <20240206025659.203155-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240206025659.203155-1-sj@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)

On Mon, Feb 05, 2024 at 06:56:59PM -0800, SeongJae Park wrote:
> Hi Cuiyangpei,
> 
> On Mon, 29 Jan 2024 20:13:16 +0800 cuiyangpei <cuiyangpei@gmail.com> wrote:
> 
> > On Sun, Jan 28, 2024 at 08:28:04AM -0800, SeongJae Park wrote:
> > > On Sun, 28 Jan 2024 17:13:00 +0800 cuiyangpei <cuiyangpei@gmail.com> wrote:
> > > 
> > > > On Fri, Jan 26, 2024 at 12:04:54AM -0800, SeongJae Park wrote:
> > > [...]
> > > > > So, 'update_schemes_tried_regions' command is firstly handled by
> > > > > 'damon_sysfs_cmd_request_callback()', which is registered as
> > > > > after_wmarks_check() and after_aggregation() callback.  Hence
> > > > > 'update_schemes_tried_regions' command is still effectively working in
> > > > > aggregation interval granularity.  I think this is what you found, right?
> > > > > 
> > > > Yes.
> > > > > If I'm not wrongly understanding your point, I think the concern is valid.  I
> > > > > think we should make it works in sampling interval granularity.  I will try to
> > > > > make so.  Would that work for your use case?
> > > > > 
> > > > It's much better than working in aggregation interval.
> > > 
> > > Thank you for confirming.  I will start working on this.
> > > 
> > 
> > Great, looking forward to seeing the progress.
> 
> Just sent a patch[1] for this.
> 
> I also updated DAMON user-space tool, damo, to use this improvement[2].  I hope
> that to help others who using DAMON with their own tool to easily understand
> how they can get the improvement from this patch.
> 
> Also, please feel free to ask any questions and/or help.
> 
> [1] https://lore.kernel.org/r/20240206025158.203097-1-sj@kernel.org
> [2] https://github.com/awslabs/damo/commit/75af3a1c0b3e79cd3207f0f8df5b5ac39f887450
> 
> 
> Thanks,
> SJ
> 
> [...]

Hi SeongJae,

Thank you for sending the patch. I will verify this feature on the phone and reach out
if I have any questions or require assistance.

Thanks.

