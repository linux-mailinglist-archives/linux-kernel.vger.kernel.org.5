Return-Path: <linux-kernel+bounces-143836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CC028A3E0B
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 19:42:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8CD4CB215CB
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 17:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B84752F67;
	Sat, 13 Apr 2024 17:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="egTKU0dr"
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574CB524B1
	for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 17:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713030131; cv=none; b=e4mqCFUnr7kIaT5byMUlWp/VHwYfhmunIQrvWgI/BQ047/JKIzs/aEmVjnazWiiwwMmbWnV3SHoJu+FBE0YMNIR19MREA0APEL4OUdu/ju6trUGtKsvhxV/o9HII94+E1RxHsBE8tA6dkI3Ol2/uG2roFCowb+TPWbLDvNMZ9tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713030131; c=relaxed/simple;
	bh=GTS9oVLDrtt9tcFbhrZl19tHIjDRvQteb6rTXtibcgI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b7oRk/kYbGBgD3iWE+UiNvm2ZdUiwSobDjbsH348cWPTjHXOHEnw2Zq3YdBrBTSJzsItl/fDY+SdCwuXr1yqiB9F22zxAbsDq9/dWJryP1Jo0KcMYybybmUCk6F9u4OORc6W64kPOVshUBx7udc2WEXXexxPX7UlbxhgEmzw1fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=egTKU0dr; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-617cd7bd929so21446517b3.3
        for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 10:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713030129; x=1713634929; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=m5YN+LPEWI/wtloecJEBj7h2gi2t8HMK1Cd/XJgJf+A=;
        b=egTKU0dr2OLfPYDXiSurS9THIAYdPcIypdlNDN7XmByToHcuk3PtNZI//vIWbwErbO
         Ow/xVpFM/0+TtObcovPIbZCYqIEkiUr4c2215MHavIs3gXNYnhwj1jmNwpumR5zguc+M
         v0OayafznExjVt6iNYvpn2CsAAyuIBTAgbnj91+8fn299vMN0u7L21BUGEN+JoC2Plo7
         LRT2Tbf4W7HI0/trbnRx+nHLqTJ9T24rJEPtasi0t8IMZyHzcBTi/MgyhJ+q63gOms5G
         W6HIqtXOh8clYsCxInbbxoQLvcK21y/i8fz64Xeno/fRwGdlJyCtN1ie/nyxy7W+LFoO
         NY0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713030129; x=1713634929;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m5YN+LPEWI/wtloecJEBj7h2gi2t8HMK1Cd/XJgJf+A=;
        b=MFcKoohxmwHIuHlZm0YmvfJ+FhYbL84NN4xVe3ZhHLbyObFyKs9NiY7VXFZr0MeIGb
         sgXGi5zMAFUwcSCIaiFI/b7G0SGXMWFm2jo1gVsZuITIaRqlH9YgXjw2CwdG6Y9hWKR5
         nDo4GbpeFH/uGeJrazr7teudk2sd2H7a3Ug0+etSuguhcMJpJyIWEA+AK4pcWIFHAGj5
         dVq6LT0AgKOpbePkKRhrJ9xpUDAluJubnTQw/LNRx3gKXTg37gp3hioJ082fHAqh0rQK
         jfpmvoVrYeJ+Ym78oJTVv0uaQ7CDj3zH2g52EEAheMuR1YJyjREmErBxqUofxEnzvEHl
         9LCg==
X-Forwarded-Encrypted: i=1; AJvYcCX08JQQscITai23pdBIBfsH5mp5SP7X18lb+PDdBuKIZoCv4czciv9gaYNsOQvD699KHgxsTj/3MuWG6oEeWGLlZBXWRztHljm3TzYG
X-Gm-Message-State: AOJu0YyRMdYxvcnF7qkQ8B0XsyxKiPbNe0duik+04OWmFcq+SBhR1mDC
	y5aMfSiQrWpGizjYtaSuK+uqbETyIvGoT33ouPaU1EfrpRRX6Tf4
X-Google-Smtp-Source: AGHT+IF67EdrWT4CYqGMNvQra5UkonT+A5/c/6XPdOZ5V/ewtmkhj05DYfc+YuP8T7fGDItnc0bsCg==
X-Received: by 2002:a81:49cd:0:b0:61a:b3da:c079 with SMTP id w196-20020a8149cd000000b0061ab3dac079mr1176059ywa.2.1713030129281;
        Sat, 13 Apr 2024 10:42:09 -0700 (PDT)
Received: from localhost ([69.73.66.55])
        by smtp.gmail.com with ESMTPSA id s7-20020a819f07000000b0061824f9a78esm1325812ywn.79.2024.04.13.10.42.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Apr 2024 10:42:08 -0700 (PDT)
Date: Sat, 13 Apr 2024 10:42:07 -0700
From: Yury Norov <yury.norov@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Kyle Meyer <kyle.meyer@hpe.com>, linux-kernel@vger.kernel.org,
	linux@rasmusvillemoes.dk, mingo@redhat.com, peterz@infradead.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
	russ.anderson@hpe.com, dimitri.sivanich@hpe.com, steve.wahl@hpe.com
Subject: Re: [PATCH v2 2/2] sched/topology: Optimize topology_span_sane()
Message-ID: <ZhrD6NLFU1X6F/74@yury-ThinkPad>
References: <20240410213311.511470-1-kyle.meyer@hpe.com>
 <20240410213311.511470-3-kyle.meyer@hpe.com>
 <Zhe9ttm9Ppv2wT3S@smile.fi.intel.com>
 <ZhhcPwFCgxDUhndo@DESKTOP-IR8JFSN.>
 <ZhlEVoW6FJC6uBVE@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZhlEVoW6FJC6uBVE@smile.fi.intel.com>

On Fri, Apr 12, 2024 at 05:25:26PM +0300, Andy Shevchenko wrote:
> On Thu, Apr 11, 2024 at 04:55:11PM -0500, Kyle Meyer wrote:
> > On Thu, Apr 11, 2024 at 01:38:46PM +0300, Andy Shevchenko wrote:
> > > On Wed, Apr 10, 2024 at 04:33:11PM -0500, Kyle Meyer wrote:
> 
> ...
> 
> > > > Since topology_span_sane() is called inside of for_each_cpu(), each
> > > > pervious CPU has already been compared against every other CPU. The
> > > 
> > > previous
> > 
> > Thank you for pointing that out. Should I send an updated version or can
> > a maintainer correct my mistake?
> 
> Depends on the maintainer. I'm not the one here, don't expect answer from me.

I like this rework, and I'll take it in bitmap-for-next for testing.

I see Vincent already acked it, so I can also move it upstream, if no
objections from Peter, Juri and Ingo.

Thanks,
Yury


