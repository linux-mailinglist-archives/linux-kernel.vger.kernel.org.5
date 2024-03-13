Return-Path: <linux-kernel+bounces-101612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1857887A959
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 15:17:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8797289D62
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 14:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4554246436;
	Wed, 13 Mar 2024 14:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y3c6tY4n"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C249146441
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 14:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710339471; cv=none; b=ZPUMRA6ZenaMMiTryS0j6N/siDwGLO+9NQhcasrVkkPnMlFRyAoM4t0mMmIvKZKI2doDbWRWg/ar40wNmclevbSExO3U3AhCRpJuxWUkEc8tCYgFEugRLwaz63aAmpiTAyJ5WOQvJr2L8E14XKlK0JDSsN0KjGvzgiefnGEk9+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710339471; c=relaxed/simple;
	bh=DI5UQKmJ6ci320U8du68tPIQjhz0EADiePzyf3FHvw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BaOc3aklsTu1Hgyw8KYiWWBqRpAqX4Lin/B6c5x19+AB3Nbh9X4CCS2N7xwl+RVbg2eQhJ4HXRyH9xvq+WeC603jbNemvuxYBOebJi5ACNIpkNA1TGf+doftAXifQbh9fbLb9P8kXJYATmwDf0a3bsTNFM2lioMurXRV8PnMheo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Y3c6tY4n; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-513a08f2263so4264427e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 07:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710339468; x=1710944268; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DI5UQKmJ6ci320U8du68tPIQjhz0EADiePzyf3FHvw4=;
        b=Y3c6tY4nc5ZcnIU7xal9B4x7B8tqM0ly+9JTLwWArNoqbBCpvbW/BWUgdES3O22yMC
         2nmjpcDUgrxFjLHGrjbDhpuyCG9GfMaSYGNhoEErZDBqQ7Lrp10LFd8cCVXwL2+XEwP0
         rzPCRkSJy5aE8hiihTlT0pUlzES4B31+ohj9h+v4RdtyWaxLcXPVfgrAki7xiTjGmcGi
         AY/MtUFCdwl9tf2u4PTkAw3j/J6Z1Y3PizN2s14zZiEyR747ZuRDx6/rX1TwUTsiX4yP
         Yjis24LyK2DqskLlTfFIWyIc/2cPooVswf+VDGstxpx+qr3HWWpg+cV+EbSLV9SnjRgI
         CWTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710339468; x=1710944268;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DI5UQKmJ6ci320U8du68tPIQjhz0EADiePzyf3FHvw4=;
        b=lEn2E8xrbGQ4oGpRPDI4k/v7uBZatgrYDYz29wFSXf/wevQT75rBA0g0iMX+ccXweR
         PI/GtmhkjzgC/p2aY9X3q6Kj8UrQyo1jBmtD2PC6AfmwjKAUjsDLt4pX7ZvgKTfzyVza
         oiHFf1nXnZdaX8/P6njlq3DkSRozi6LPg1wU/C174gAL+KlZby09o3ERlDL6PtQIg1vb
         b2w0eyto7l929sdn/lzwbOVuqzxbCLqcLCYv8BdSCBkcJhDGwr7DjrXD5xmGfi7rUrUC
         WqX9/UjIpXPm4+ev4qwHRmgmL3pysmicnWDXP00tsNO6JWPxgK45qIz7I1YZMiVZNIad
         AZRQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkcqtZd2Xwq/oqVvNVIGXfwEdtTc39BPfh4O+1eHmvxgswWdIB5XqPJOlyWV8HXsKdNA6NTPRI3OGtFQB9HIIxfLyl8yAtP/HmasTb
X-Gm-Message-State: AOJu0Yz7lhdlaeOM7kwvXzITejahROCAumjWHVujnkF8kmHXpfNqomA7
	I++J0bqmAuwiTECQTjsJklDRPIwvE52XyvxNZzEY4ouPfwrDJ7VffujNxQNaZxA=
X-Google-Smtp-Source: AGHT+IFx+Ru8HLmNgnvlGtS2WaPtuNHppwpho5k+Bj3WbKN3ZgQ4vuHCgkqhvKsxNRYrcFFpxU5muw==
X-Received: by 2002:a05:6512:3baa:b0:513:b102:7d93 with SMTP id g42-20020a0565123baa00b00513b1027d93mr7524047lfv.24.1710339467939;
        Wed, 13 Mar 2024 07:17:47 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id v11-20020a05600c444b00b00412f016a151sm2492507wmn.9.2024.03.13.07.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 07:17:47 -0700 (PDT)
Date: Wed, 13 Mar 2024 14:17:45 +0000
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Liuye <liu.yeC@h3c.com>
Cc: "jason.wessel@windriver.com" <jason.wessel@windriver.com>,
	"dianders@chromium.org" <dianders@chromium.org>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"jirislaby@kernel.org" <jirislaby@kernel.org>,
	"kgdb-bugreport@lists.sourceforge.net" <kgdb-bugreport@lists.sourceforge.net>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Subject: Re: =?utf-8?B?562U5aSNOiDnrZTlpI06IOetlA==?=
 =?utf-8?B?5aSNOiDnrZTlpI0=?= =?utf-8?Q?=3A?= [PATCH] kdb: Fix the deadlock
 issue in KDB debugging.
Message-ID: <20240313141745.GD202685@aspen.lan>
References: <20240228025602.3087748-1-liu.yeC@h3c.com>
 <20240228120516.GA22898@aspen.lan>
 <8b41d34adaef4ddcacde2dd00d4e3541@h3c.com>
 <20240301105931.GB5795@aspen.lan>
 <2ea381e7407a49aaa0b08fa7d4ff62d3@h3c.com>
 <20240312095756.GB202685@aspen.lan>
 <06cfa3459ed848cf8f228997b983cf53@h3c.com>
 <20240312102419.GC202685@aspen.lan>
 <410a443612e8441cb729c640a0d606c6@h3c.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <410a443612e8441cb729c640a0d606c6@h3c.com>

On Wed, Mar 13, 2024 at 01:22:17AM +0000, Liuye wrote:
> >On Tue, Mar 12, 2024 at 10:04:54AM +0000, Liuye wrote:
> >> >On Tue, Mar 12, 2024 at 08:37:11AM +0000, Liuye wrote:
> >> >> I know that you said schedule_work is not NMI save, which is the
> >> >> first issue. Perhaps it can be fixed using irq_work_queue. But
> >> >> even if irq_work_queue is used to implement it, there will still
> >> >> be a deadlock problem because slave cpu1 still has not released
> >> >> the running queue lock of master CPU0.
> >> >
> >> >This doesn't sound right to me. Why do you think CPU1 won't
> >> >release the run queue lock?
> >>
> >> In this example, CPU1 is waiting for CPU0 to release
> >> dbg_slave_lock.
> >
> >That shouldn't be a problem. CPU0 will have released that lock by the
> >time the irq work is dispatched.
>
> Release dbg_slave_lock in CPU0. Before that, shcedule_work needs to be
> handled, and we are back to the previous issue.

Sorry but I still don't understand what problem you think can happen
here. What is wrong with calling schedule_work() from the IRQ work
handler?

Both irq_work_queue() and schedule_work() are calls to queue deferred
work. It does not matter when the work is queued (providing we are lock
safe). What matters is when the work is actually executed.

Please can you describe the problem you think exists based on when the
work is executed.


Daniel.

