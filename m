Return-Path: <linux-kernel+bounces-78374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACEA78612A4
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 14:27:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41A0328543F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 13:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E89D7EEF7;
	Fri, 23 Feb 2024 13:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="xwRkhhr+"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B70F7CF07
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 13:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708694862; cv=none; b=laSlZvuQQ54UDN2eqe24HeX9DAybHoeh2bdNmMJ+uNnHqVYe4tUljXFQoeNzrCbuXbhp+Tq6uhD4QfiWuwDMqkjd69aCbEj9998T51ZrJVyjs87fC3Os+I/M6aYQuvHZrBzjo18+CscT3wwEJKlH6c6wp893K5dVx56gxF7afb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708694862; c=relaxed/simple;
	bh=vP8k20Ag1O076Uu/hwPXs6RI5WGURVuUjElcUfCfwMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e3sBmqKCv/aAvoVTonBfNZx3dOYjw56ePndzxGj60gBviV/LEsFyp3tUI4oTqXTjcC1wfC8Y2MucRTJu1i7UePRGW+MxnI7Esib9j01kz1Wu4bElVeGluRl47vHwWZueWnLTgXVrKZ7KLOHvyU9P2QEwtA2j1tZuxny0kiKq0yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=xwRkhhr+; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2d2531294faso13387181fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 05:27:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1708694858; x=1709299658; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0ncctXod7EUhdZeRvIKR8JyC0fIDHtd7Zc9VFP5vKak=;
        b=xwRkhhr+N5ps8c3gtgLANKB4vJDSeXxAnJNDPYElg79Nu/oJ07XBQz6W9qcz3rqo5p
         XFyiH9ZO9MSOBA5MBD3sAgHf6JmhZFnN19J1963kSMWPEblpGisElSVKSXy0WAEed5/s
         aMAqpjlBs1Xr2xT1i5HQlNboip2m+AlFcgyJWf21JFsImu4rPKhJipzQLSsP0DlfaGfr
         vwRYyersVCn6PkI0rstJBSiI09vhPswOX3NfNlCXR+SnTjGYUQsJcBEOb+25U+ROFxJk
         FCUMYEU72nBSVRWBYQIZ1aET6k3Mp+/+Wioq813VJGduZDyFNNz+Q59FcJ1px7HYy2xd
         CkUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708694858; x=1709299658;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0ncctXod7EUhdZeRvIKR8JyC0fIDHtd7Zc9VFP5vKak=;
        b=gR1mmaKi5d0Eq6vGPXC1a2wkG2L0A2sS+5fKLpGwWgHTtRTUStZ0xEoNP0Xae3MFPX
         iwfp6h5iVrOIon5TDaoRGJacnGOXYBTRMJla4LA0SWZ5igQnoOrf7N1S859QnMBUaEt8
         2E3nmELTxc5wvQRfQMx2mkIF+vUpNJZhtBBrmM0FRs2V81gIpUrR3DLJU0v+hU1Hp8GA
         /AZsccbactfiS04DMaZBOpSBqZpobxslK5RYfYhHMnrMP5XwqcgiAbWoUhlw6LV1o4uX
         abjgVNtzsejnN0vmF17SSBxihUkql4UWxOlIsY7ieCEmN0OsOAAwh7gONQ8YUZweq66d
         ntMg==
X-Forwarded-Encrypted: i=1; AJvYcCUNfsohNaeTkSk5boAcTB7/82ysE9ltN8eRaDHAEmELKhuqZNw6i3qRMJF8XBcOikke3ecfIzCqytjZfOW/sxhR7qZJxcgxMXYe1w2c
X-Gm-Message-State: AOJu0YxRd5SKymdFErTXiiCKtGbdNdT0Px7PO4ahY9Ohv+FrqGrKwZRX
	Pw42veM0xqmC9eQKvJi+inct5pc7bqhajQfFYqkOGU2po4s2Rs11JDJ9UaCFulU=
X-Google-Smtp-Source: AGHT+IGHJQtc7/fhy/7PUeyUCJgrv+2MPR6+rU59HBCi8qFcbLzNLCKyqDFu48LBc4YqazWm6Sw1dA==
X-Received: by 2002:a05:6512:a90:b0:512:ed29:684 with SMTP id m16-20020a0565120a9000b00512ed290684mr124852lfu.54.1708694858420;
        Fri, 23 Feb 2024 05:27:38 -0800 (PST)
Received: from airbuntu (host109-154-46-208.range109-154.btcentralplus.com. [109.154.46.208])
        by smtp.gmail.com with ESMTPSA id d18-20020a50fe92000000b0056484c0eab8sm4391485edt.57.2024.02.23.05.27.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 05:27:37 -0800 (PST)
Date: Fri, 23 Feb 2024 13:27:36 +0000
From: Qais Yousef <qyousef@layalina.io>
To: Pierre Gondois <pierre.gondois@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Christian.Loehle@arm.com
Subject: Re: [PATCH] cpufreq: Change default transition delay to 2ms
Message-ID: <20240223132736.xp3c3k4k6y2a2ep7@airbuntu>
References: <20240205022500.2232124-1-qyousef@layalina.io>
 <20240205074514.kiolurpounokalum@vireshk-i7>
 <CAJZ5v0j2rA-+Jpdv6OZ_ymiqh0+RGzmJBNncKGBwuxO3PxgSKA@mail.gmail.com>
 <ca000b2d-b552-43cb-8807-0a5f1450c6a2@arm.com>
 <20240220135037.qriyapwrznz2wdni@airbuntu>
 <d58de550-0ce1-4af9-9e2d-dedd5e73c797@arm.com>
 <20240222115557.blnm4uulkxnorrl4@airbuntu>
 <f4c3f028-b93e-4658-af28-ac2123203d68@arm.com>
 <20240222233947.sl435tvhhpe5iqzw@airbuntu>
 <fdd82ddb-82bc-4c8c-86ef-c80505881013@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fdd82ddb-82bc-4c8c-86ef-c80505881013@arm.com>

On 02/23/24 10:48, Pierre Gondois wrote:

> > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > index 66cef33c4ec7..668263c53810 100644
> > --- a/drivers/cpufreq/cpufreq.c
> > +++ b/drivers/cpufreq/cpufreq.c
> > @@ -576,8 +576,17 @@ unsigned int cpufreq_policy_transition_delay_us(struct cpufreq_policy *policy)
> >          latency = policy->cpuinfo.transition_latency / NSEC_PER_USEC;
> >          if (latency) {
> > +               unsigned int max_delay_us = 2 * MSEC_PER_SEC;;
> > +
> > +               /*
> > +                * If the platform already has high transition_latency, use it
> > +                * as-is.
> > +                */
> > +               if (latency > max_delay_us)
> > +                       return latency;
> > +
> >                  /*
> > -                * For platforms that can change the frequency very fast (< 10
> > +                * For platforms that can change the frequency very fast (< 20
> 
> I think it should be 10->2us as we do:
>   min(latency * 1000, 2ms)

Yeah I meant 2, that was a typo

Thanks

-->8--

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 66cef33c4ec7..de92a9912587 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -576,8 +576,17 @@ unsigned int cpufreq_policy_transition_delay_us(struct cpufreq_policy *policy)

        latency = policy->cpuinfo.transition_latency / NSEC_PER_USEC;
        if (latency) {
+               unsigned int max_delay_us = 2 * MSEC_PER_SEC;;
+
+               /*
+                * If the platform already has high transition_latency, use it
+                * as-is.
+                */
+               if (latency > max_delay_us)
+                       return latency;
+
                /*
-                * For platforms that can change the frequency very fast (< 10
+                * For platforms that can change the frequency very fast (< 2
                 * us), the above formula gives a decent transition delay. But
                 * for platforms where transition_latency is in milliseconds, it
                 * ends up giving unrealistic values.
@@ -586,7 +595,7 @@ unsigned int cpufreq_policy_transition_delay_us(struct cpufreq_policy *policy)
                 * a reasonable amount of time after which we should reevaluate
                 * the frequency.
                 */
-               return min(latency * LATENCY_MULTIPLIER, (unsigned int)(2 * MSEC_PER_SEC));
+               return min(latency * LATENCY_MULTIPLIER, max_delay_us);
        }

        return LATENCY_MULTIPLIER;

