Return-Path: <linux-kernel+bounces-100113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 542238791F3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 11:26:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E77261F22B57
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 10:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA0C279B7F;
	Tue, 12 Mar 2024 10:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GLPtZCbX"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884877A73B
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 10:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710239066; cv=none; b=kC261WBzy7NI+x+rSJ4tg8ZSBFg6c3c8+OWAa5l8F6Iz/bnUR/pxNa6/ZO+n0svJA+Otxf8518RsQjYYJrmxs1Jy87WubIsNtlsjJxqvptOeceGwMbmxi8naYrzIkDLIsiMnmHuaCKw0PjfeKkqgJ4n+A1uL5cJzjBuS3xe75Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710239066; c=relaxed/simple;
	bh=pWToFqxwxMP42zLNN1JswkakPz03dZF3hN1TWqvA7VY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sb89ZjsLj67hKE8Up+F4igy5Prv1FuaPF7tq5e5u4HK6wvsy+7Mofl3tSOEj5sHFKunsu0UR9jO3H9OegVeu2nqLqfd+2z27jXb2Lcm5C349mk9LXJMyBQVMEFJg/lvkLLkYofuex8tkBhIy9QnNOrhjSuJr4gQFTL/8tnIcIgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GLPtZCbX; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-33e9dfd343fso801132f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 03:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710239062; x=1710843862; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pWToFqxwxMP42zLNN1JswkakPz03dZF3hN1TWqvA7VY=;
        b=GLPtZCbXjc7HGIotwyZxSQJEoIuAXnwF7SPlBEaecnTszdy4QamRfz7DAEX4+9pz3c
         iLh0JwCPxOOukqJC6agpASasGuZ3Yjbtn600lql2SEzZxe2noDgTuWxjXwb2CLO4tZtO
         PtD/LEZK68VTcmFLR2KK8NEvRkL90nax3xU4l013PG/+HtJnZsrphsGgqukjpSMIczaA
         kMoi1YiRQs0WxGCRppj+yJ6z+d0Zb/TPepdpETxb0LSKiJmPpFtI2U2kuqIl7shT+BtD
         LpzhpHkCMnwEttusq6L0AB1Nz0VALZy8wTH4CsdPYu4uF3ivctEpkhoNpR6Cw89BkpAq
         2apA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710239062; x=1710843862;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pWToFqxwxMP42zLNN1JswkakPz03dZF3hN1TWqvA7VY=;
        b=NLnNwHhlfM05uEUIy/e5AZYPosa/EnaO/JhYnMEW9ADzB13cPh6x4nxDA69p8RNp8h
         rz5lOM3Go+8SnHXtRZR0bu/AKYYsH811LbQUjtMdtJ1oMfj2mv7YQN1ha8mdlQSMWAjP
         JtTFXCQSamEIHWlFAVf4bIEzC36hUEBcmsn+GdSX3tqGzUbeex8HdUiNMJh1+s4i8Ihy
         ArjIWd7SP779Sj+kTMm5hKZv4tNlLliUVFx/25rmRNwfpxLNKApf5SsLzvCrnIEL0kaL
         hxhkE3Y06hFBmXdBDzyAehGRQAmGXKRNydutz0nxc8R/8fMjUu5P7ovetawuiigix3kg
         IgRA==
X-Forwarded-Encrypted: i=1; AJvYcCXfZSGaHJSQ09aoLOqDB212UE/yMopK/iN1UGyjoHwQVTha+X2L1rKxeHL/frHHjYaanjf7c6xjjey3yEA8QzGgJ2Kv2OeowPm/y8q2
X-Gm-Message-State: AOJu0Yx6pIdpoObMEabHNvHkbF4Nz/sgUmXi02ImqBGwcn4cwwCDw2yr
	IjCdDqicCAOXOymlbGZsI2GM0/kMokydNO+ETXUiZsVsIqPbolCKnlKqzoOaD1Q=
X-Google-Smtp-Source: AGHT+IEtPsZ31O/nfjwsFgmU1AR9CggAYhpn6AzzX6lCg3bxmADP9OSMaPt2DsKWyzfXRygCg/rVqA==
X-Received: by 2002:a5d:6882:0:b0:33e:767a:c39f with SMTP id h2-20020a5d6882000000b0033e767ac39fmr6499492wru.15.1710239061776;
        Tue, 12 Mar 2024 03:24:21 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id n2-20020a5d4002000000b0033de2f2a88dsm8586219wrp.103.2024.03.12.03.24.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 03:24:21 -0700 (PDT)
Date: Tue, 12 Mar 2024 10:24:19 +0000
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Liuye <liu.yeC@h3c.com>
Cc: "jason.wessel@windriver.com" <jason.wessel@windriver.com>,
	"dianders@chromium.org" <dianders@chromium.org>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"jirislaby@kernel.org" <jirislaby@kernel.org>,
	"kgdb-bugreport@lists.sourceforge.net" <kgdb-bugreport@lists.sourceforge.net>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Subject: Re: =?utf-8?B?562U5aSNOiDnrZTlpI06IOetlA==?= =?utf-8?B?5aSNOg==?=
 [PATCH] kdb: Fix the deadlock issue in KDB debugging.
Message-ID: <20240312102419.GC202685@aspen.lan>
References: <20240228025602.3087748-1-liu.yeC@h3c.com>
 <20240228120516.GA22898@aspen.lan>
 <8b41d34adaef4ddcacde2dd00d4e3541@h3c.com>
 <20240301105931.GB5795@aspen.lan>
 <2ea381e7407a49aaa0b08fa7d4ff62d3@h3c.com>
 <20240312095756.GB202685@aspen.lan>
 <06cfa3459ed848cf8f228997b983cf53@h3c.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06cfa3459ed848cf8f228997b983cf53@h3c.com>

On Tue, Mar 12, 2024 at 10:04:54AM +0000, Liuye wrote:
> >On Tue, Mar 12, 2024 at 08:37:11AM +0000, Liuye wrote:
> >> I know that you said schedule_work is not NMI save, which is the first
> >> issue. Perhaps it can be fixed using irq_work_queue. But even if
> >> irq_work_queue is used to implement it, there will still be a deadlock
> >> problem because slave cpu1 still has not released the running queue
> >> lock of master CPU0.
> >
> >This doesn't sound right to me. Why do you think CPU1 won't release
> >the run queue lock?
>
> In this example, CPU1 is waiting for CPU0 to release dbg_slave_lock.

That shouldn't be a problem. CPU0 will have released that lock by
the time the irq work is dispatched.


Daniel.

