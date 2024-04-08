Return-Path: <linux-kernel+bounces-135731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7804489CA83
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 19:12:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E45C21F2545B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 17:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44707143888;
	Mon,  8 Apr 2024 17:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XsgXaK3B"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCCCF142906
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 17:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712596341; cv=none; b=BclPxHLf8xGZOFqBncjA/QrNO21a7DxRIfSbiYs+iksjlcAw/Vziv7xudisSFZToCqxSRrnbZy6KqPmFgD11iQSL0ZCvEaJ+41O8NVoqMwSKjoHz88YTH3e2gw8aw7pfYmMDcbdmO0TX0dVZCqSU4FbZ5FoYGgXhNXWqDKYMlx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712596341; c=relaxed/simple;
	bh=oJ9mT+vwINWrYV759TkgfgMbkpyg67bL62cpIdVNlF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MOxEZy+ENGvSKL3mFsYfjwSxiv40L02MQw8DQoXWBdPzhUeEtSPpToWpHgNkot2H+JvBkojtxKVr9+PtZ5w39tSwGlF/9yERtnYipNCnfubEIJxEYP2bx24lU0TyWG1E34VFHcv0rOGnTDfrZsET9eqgBA0ZSc+AZ7OLiq8bq2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XsgXaK3B; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-516d04fc04bso7030040e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 10:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712596338; x=1713201138; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=T8TRMrj5ggtPr7yueS0y7TsmLoLHnTwJgZ1LoVKqCBE=;
        b=XsgXaK3BWIHwpxfooljCkxPs3MoOdtZhpSKU6RE6g+jKcBUPHDOetLcAoN43Y+uZCh
         l9slml0lqf69WkmW1j1BnvaUWsn/mU/4gA/DtZaxrNM75Qfnbrqxwmwy7Zw29jQmU4Dh
         X4WEA6two1XsP7YTDlj6nmqT40o1dhIMd/1uFkjfp1LG4R3QxIB+VH6poMid2m6I7PqO
         IpO2ySm0BiRZnlQvvwTw9m2pfP4IslTrRFoWhFCa0qRXAg/99OuYrh5T4vv/8Zj9cPU9
         5qYD9GvqYHkTIONS6+pCmHKURt5UwHLoAcPI3sTX94cUucZwAVtLIjO4fttlrAhdxoap
         xF4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712596338; x=1713201138;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T8TRMrj5ggtPr7yueS0y7TsmLoLHnTwJgZ1LoVKqCBE=;
        b=fox6RGjEci+r3iwD5XeR0riK4AAfqOHShPqD9Xvraaho3B0j8ztGhTpZbc1eAjmOZ1
         lc3ecuKcYuD1MoC/pBf+UtlWJaaMmXBeS7iZ4km8C1e/eA1MeIK+yAqfQbNurnjY8ome
         SI1hMf7egVMqInut85Rye5zHhfHvn72EDGf6WpP0yodB7dgkwjDtXzWVe+Shd/5YLEJP
         nufRra2ILqqx31hfn9ya/jchFKvZbsDurKNsEXQUXlIKddxQVkWRQ9WAeUzRvEPjjczU
         zeSZfYNpnMitcW7XD2Pn+xAxoTKRKn8AA7sLpdrbQ9ocO0kNoTpJpHMjpbg2NbR34+xv
         ScKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGq+2zDqnvka0I1xvJltWJM0NV0SF6Cr2oCi5/vTuU8FXL0nbUPJT3rmxe5/0FxutIKO6ub7IPnjnGvzsHetd1WHT/yDKUNqeNz/uO
X-Gm-Message-State: AOJu0YzMlCcJ3klGFiiyD+cMBZ3nv+cs9oCHwro2xYk9GktePT+Bgqlj
	Xb2MqJSkBLG5zuRTYHvmn9/nm5e2cRZuz4ZG0esqaaU41iVHUCUELEvnD7VgcEk=
X-Google-Smtp-Source: AGHT+IHfa69MVbZoX1KR17DtI3oUMVnY5gNXSX0c37nh4zmNkLTwhqWTjIaOwFa2GYGnzTRLv8lHXQ==
X-Received: by 2002:a05:6512:52b:b0:516:c1b9:316b with SMTP id o11-20020a056512052b00b00516c1b9316bmr8096374lfc.15.1712596338037;
        Mon, 08 Apr 2024 10:12:18 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzyjmhyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a00e:a300::227])
        by smtp.gmail.com with ESMTPSA id k6-20020ac257c6000000b00515cfc0e324sm1231930lfo.237.2024.04.08.10.12.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 10:12:17 -0700 (PDT)
Date: Mon, 8 Apr 2024 20:12:16 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Guenter Roeck <groeck@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Pavan Holla <pholla@chromium.org>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Benson Leung <bleung@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>, 
	Guenter Roeck <groeck@chromium.org>, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>, chrome-platform@lists.linux.dev
Subject: Re: [PATCH v3 2/2] usb: typec: ucsi: Implement ChromeOS UCSI driver
Message-ID: <txdq6cmnep2zokrwykdsnpho3k76pangzxbv7ydxpdnyohczxo@2jc4cyakrmez>
References: <20240403-public-ucsi-h-v3-0-f848e18c8ed2@chromium.org>
 <20240403-public-ucsi-h-v3-2-f848e18c8ed2@chromium.org>
 <3ezjocthsigo3t746slmgzffnmpxw7wwf3s535basiaf2qy6io@7ocxva6ndsbt>
 <2024040449-average-foyer-defa@gregkh>
 <oi3bwdyvyaezpmyxfdtsbiwwprxi2ufc3hlzoz23d5rxdkperl@cxpd7enatg7h>
 <2024040422-ripcord-bladder-bdda@gregkh>
 <CABXOdTeqz5Kza5tYXbCdTyPT66xtezai4C5TFkqmOpQc+1r8Xg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABXOdTeqz5Kza5tYXbCdTyPT66xtezai4C5TFkqmOpQc+1r8Xg@mail.gmail.com>

On Mon, Apr 08, 2024 at 06:04:22AM -0700, Guenter Roeck wrote:
> On Thu, Apr 4, 2024 at 6:30 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> [ ... ]
> 
> > > > > if (WARN_ON_ONCE(val_len > MAX_EC_DATA_SIZE))
> > > > >   return -EINVAL;
> > > >
> > > > So if you trigger this, you just rebooted all boxes that have
> > > > panic-on-warn enabled (hint, the HUGE majority in quantity of Linux
> > > > systems out there.)
> > > >
> > > > So don't do that, just handle it like this.
> > >
> > > Does that mean that we should not use WARN at all? What is the best
> > > current practice for WARN usage?
> >
> > To never use it.  Handle the issue and recover properly.
> >
> > > I'm asking because for me this looks like a perfect usecase. If I were
> > > at the positiion of the driver developer, I'd like to know the whole
> > > path leading to the bad call, not just the fact that the function was
> > > called with the buffer being too big.
> >
> > Then use ftrace if you are a driver developer, don't crash users boxes
> > please.
> >
> > If you REALLY need a traceback, then provide that, but do NOT use WARN()
> > for just normal debugging calls that you want to leave around in the
> > system for users to trip over.
> >
> 
> That is not common practice.
> 
> $ git grep WARN_ON drivers/gpu | wc
>    3004   11999  246545
> $ git grep WARN_ON drivers/net/ | wc
>    3679   14564  308230
> $ git grep WARN_ON drivers/net/wireless | wc
>    1985    8112  166081
> 
> We get hundreds of thousands of reports with warning backtraces from
> Chromebooks in the field _every single day_. Most of those are from
> drm and wireless subsystems. We even had to scale back the percentage
> of reported warning backtraces because the large volume overwhelmed
> the reporting system. When approached about it, developers usually
> respond with "this backtrace is absolutely necessary", but nothing
> ever happens to fix the reported problems. In practice, they are just
> ignored.

That's sad.

> 
> This means that any system using drm or wireless interfaces just can
> not really enable panic-on-warn because that would crash the system
> all the time.

And this is good from my point of view. If I remember correctly,
initially panic-on-warn was added to simplify debugging of the warnings
rather than to disallow using WARN_ON(). The system is not supposed to
continue running after BUG(), so panic/reset on BUG is a safe approach.
But the WARN is different. It means that the system was able to cope
with it. And as such there is no need to panic. Whoever enabled
panic-on-warn is doing a strange thing from my POV.

-- 
With best wishes
Dmitry

