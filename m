Return-Path: <linux-kernel+bounces-111736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BEE3887019
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 16:58:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E599A286A69
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 15:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 998B756B84;
	Fri, 22 Mar 2024 15:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WvWyjI/S"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B4A54789
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 15:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711123104; cv=none; b=AAqUL2xzAEcLg0cW+OxxEIUK5n1UZSlMZae/2mTGbZoc31W8mj8N56lK8JRMAUqk7Rrav1valyya/FBHQ2q+T7CsV9uUmGHHCgaTGAVQBfrfTbXzuYOTtmhQlQgJD4WcmA2ptY0ik6y+KMxNnGqTq4CziO8MvfW8zYiIgdcDZqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711123104; c=relaxed/simple;
	bh=vtL9U/CKd2LpeI+svRtk2WSaxVrUHhSSVyb1DIS9gB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sFkkPbo1sOIhdpeI6Va1HMgYEmPCiBx3Z5V07Xv+4VLNUChbfoE4v1JDBmAe5fXpb/IdWZNVh+5I6KboJJCxK65D1iSTZc8CH5hHe3An+VyeQhjdX3T7ky3HS7jRY9w+3jHoqdXwC8khn+HLzrz+Dv/8U5N+TcO13vHU0Htxdrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WvWyjI/S; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4147b5d8a0dso5617105e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 08:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711123101; x=1711727901; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qwo8Q4aR89YXvBlc7dAQ6fc8n9z/Ax8Su/9Q4XHEyS0=;
        b=WvWyjI/ScMB7lP+u6mEhKefRtAx8CTh3nJEye3taFaKQirw9KzEakGY+IwHfTddsGc
         Xjn6gxHCJUKGXWjuM276osK5j8n++9AZYhjElpmBP+77EHmMak7gSuUE38bGzC/6eTX/
         QeqPfrkuf7sMQ1JQfX0iE/LyZREyVjXMUNY4DfJb5w2OjlUanTUPRot1fg9ZHvaSxHC4
         D1CayGc69vDYAOS/a9/msSb6kt4CgcxoXpYW2hWWtxJRx2pVXWZVwgvQt8lkf5m2YPpl
         F7BD5pTB7YHreYspnmVNjGOoToIywLCq6IEjrJqpjkQqOcXhtWb62xQ20fr9oF4R6boB
         l3Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711123101; x=1711727901;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qwo8Q4aR89YXvBlc7dAQ6fc8n9z/Ax8Su/9Q4XHEyS0=;
        b=p5aifvWisckNTwZdn/wEMgmx7ltTThWOYnMB08jKyDplNAWi2V5xYV1K34vXCQuvSd
         ejv/E6C3tc81Ev/logVuVNPfzKzy+HJO7nOANA79nLF43EdT93zJ0RB/caS8bHYu6SMP
         S4D2kvNHTxbgj2VwCrrZk4zbCX9rkBVg6a4eQ2p8w+x9czyp09ibx5cerQBn8aXa4iCV
         7B8mRLQGicKqIrP00PsEypWbJJq31aZ3UvP9XPCAQ3s6pfY3t8jJd8n2KgJS5ogZPOTQ
         aSmsyIsMMKw2DUfQukNAQTM1nO4b6N2h4bYFUJ24olxHZtOxNyUKTi7G1swyJw+7PPfx
         +FeQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdZIA7sW0reva9QHae9TRlXYJKtbkUtjL3FHshd0lA8AD5/SqFW9Y8ir/wNntbzHWSkC4QvnGcoxaUYaigTsrqYy2t9hNqFjmN4HLI
X-Gm-Message-State: AOJu0YyOCT+8MQfiQpL04zbmA89atKk29ykGHc44VEUCfYP4hbdMui+i
	l60og7EdGfsGslnAp/IOv5AIACkpXdaYULNiPa2un696GCXeHpI6vTXAc12XUIw=
X-Google-Smtp-Source: AGHT+IFJFeVPNPMK0Uw9l4wNyOYo0A3jvYSJNtfO7Nj/LFMcd/gPOb4aK2tXb1HERCLuY33xfXf2gw==
X-Received: by 2002:a05:600c:3b90:b0:413:fa31:b9f6 with SMTP id n16-20020a05600c3b9000b00413fa31b9f6mr2140784wms.2.1711123101402;
        Fri, 22 Mar 2024 08:58:21 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id q2-20020adfcd82000000b0033e7603987dsm2350941wrj.12.2024.03.22.08.58.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 08:58:20 -0700 (PDT)
Date: Fri, 22 Mar 2024 15:58:18 +0000
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Liuye <liu.yeC@h3c.com>
Cc: Jiri Slaby <jirislaby@kernel.org>,
	"dianders@chromium.org" <dianders@chromium.org>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"jason.wessel@windriver.com" <jason.wessel@windriver.com>,
	"kgdb-bugreport@lists.sourceforge.net" <kgdb-bugreport@lists.sourceforge.net>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Subject: Re: =?utf-8?B?562U5aSN?= =?utf-8?Q?=3A?= [PATCH V4] kdb: Fix the
 deadlock issue in KDB debugging.
Message-ID: <20240322155818.GD7342@aspen.lan>
References: <20240321110407.GB7342@aspen.lan>
 <20240321115017.2879691-1-liu.yec@h3c.com>
 <d3b77177-7c00-4459-9515-37afe741e9dd@kernel.org>
 <5649fa8bfbdb43ea914850794afc6cac@h3c.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5649fa8bfbdb43ea914850794afc6cac@h3c.com>

On Fri, Mar 22, 2024 at 07:50:54AM +0000, Liuye wrote:
> >On 21. 03. 24, 12:50, liu.yec@h3c.com wrote:
> >> From: LiuYe <liu.yeC@h3c.com>
> >>
> >> Currently, if CONFIG_KDB_KEYBOARD is enabled, then kgdboc will attempt
> >> to use schedule_work() to provoke a keyboard reset when transitioning
> >> out of the debugger and back to normal operation.
> >> This can cause deadlock because schedule_work() is not NMI-safe.
> >>
> >> The stack trace below shows an example of the problem. In this case
> >> the master cpu is not running from NMI but it has parked the slave
> >> CPUs using an NMI and the parked CPUs is holding spinlocks needed by
> >> schedule_work().
> >
> > I am missing here an explanation (perhaps because I cannot find any
> > docs for irq_work) why irq_work works in this case.
>
> Just need to postpone schedule_work to the slave CPU exiting the NMI
> context, and there will be no deadlock problem.  irq_work will only
> respond to handle schedule_work after master cpu exiting the current
> interrupt context.  When the master CPU exits the interrupt context,
> other CPUs will naturally exit the NMI context, so there will be no
> deadlock.
>
> > And why you need to schedule another work in the irq_work and not do
> > the job directly.
>
> In the function kgdboc_restore_input_helper , use mutex_lock for
> protection.

It is the call to input_register_handler() that forces us not to
do the work from irq_work's hardirq callback.

It is true that there are mutexes in kgdboc_restore_input_helper()
but if they were the only problem we could change the locking
strategy.


> The mutex lock cannot be used in interrupt context.  Guess
> that the process needs to run in the context of the process.
> Therefore, call schedule_work in irq_work. Keep the original flow
> unchanged.

You should answer these questions by posting a v5 with the explanation
in the patch description (otherwise the explanation of how the fix works
doesn't end up in the changelog).


Daniel.

