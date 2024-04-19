Return-Path: <linux-kernel+bounces-151692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62B668AB227
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 17:41:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FDA8286147
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 15:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59D2612FF8C;
	Fri, 19 Apr 2024 15:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O4uW65Rh"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67169127B72
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 15:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713541255; cv=none; b=czZW5IpzcBjiCYz40SZVdK+PWGU3quybxVCF1WaxCkFjbpXcaYXB2TVRMNgNqgmL6Q1bX19mfu3fqNLEa8+DuvPCIhSjD6YF7tSr/zuGMrQdkU+5ng9Xp3s1n7H7GcKzqZ3d82ZAwpRKHQsTOfd+kMBh/4o+ZRGtAHtgNiTElQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713541255; c=relaxed/simple;
	bh=UiZy0WR1xVKTmKeEkD53TQth3wFjxVhwyQXMhAZgQ/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ito4YDX178L+twsjavZ2M119ak/WsdTWYFdSxfs5JUm4LYgMenfAOVOPK1C7xx09yk1c8TZV8pmpxBTeuhn8PhmBvVOpJZ62vL2SFjFykdYC43hgOx3Ka1DtQitVgM/RrO/ghAbDLkPWUQyTELjPwC51jQeKfhjLQX/9zIsgwqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O4uW65Rh; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1e36b7e7dd2so19483465ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 08:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713541254; x=1714146054; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2KNb7hURw628rOhLJDyvPT2Y9i+jl0k+DgwnKwzk8KI=;
        b=O4uW65RhYIEAE2ZbC0E43bDgQ/JYlxTFnPoYKQaLOewkEceUVqm9aNgRnPDitpzNBW
         PjEX17k00lVtNqbNT1nUwn/rpQ9MjKO8jIak0kmP6nJeBJaBrFnj20jmf/OTjEZ4cxkt
         bUGSBxjHpSg3s612KEl5bHXoC5DpYxIYoZxYYCnbkmjFth+IicILx6gK8H8RsTuHJJ54
         DAAx3YIUoQhPegelc2Ywe8tQuQdgbyQhzNyZRI8sViDFnKHD3VBEwnUk0KJvMWAcbtUf
         B96RSD2bhDW5U7BgNQCryKqVhLP/wxmjYSqqTuYrnWMJyg8S0CMPka5jWN+xvBRqWGiT
         NT2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713541254; x=1714146054;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2KNb7hURw628rOhLJDyvPT2Y9i+jl0k+DgwnKwzk8KI=;
        b=GJPLsRnS8zHfzfMz26JFE7V593bFSUI0Y7oRryOcumAiUOQCiYbjwXCa7r/dQmDUFC
         DaGEHTFBP2gGFtGyyR88Y5aN3dtLjxVcu5G2d1K5r+HxHbdkmo6QSI0B5I0LjJveJ1TC
         BYebW45XzCX4mGeakZz/FLwuyptdE6EMwLana3nmzY5XBICm6ObKRlYhgDZzZXYMIlFC
         ym2Ve33IAuAPC13VeGgHLVh8Bfh+8GfPX6R5c8AAOILYpQu/2CPzmLMagH10n0TPFQZJ
         7EjGp1EKogd3hHpwl4oX2wKF/NKzP+wa735KycgevHXS9ajpYi22hTtRxio8oMv/WUMd
         ydWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSwHb1Lw3ZAP6uZ1WGKCCpg+tzgA57bw5iWf3E1kfG41hC4yeONn5/eqfI0xfxcD1WkS8i4oFsNkNOtw6MUvzLI0EyLJmSQ8KIVlvV
X-Gm-Message-State: AOJu0Yw6WMsi0qRgUE39vtjjmQs0ft2mE6uKOp8gNYHWcLKy7iiuiDWF
	SY1SFuvuZRvGzpijnjvAhE8ujaXGOiaWcFF9bzLrWJhDChEM8usUHu8xYM0K
X-Google-Smtp-Source: AGHT+IHxpo0G7xYzi2NbO6qX3zNkH0rErE4LYBibDOHzeSj96P1T2oOu84Vs6NQyr4DLgYhUA2dDsw==
X-Received: by 2002:a17:902:ecc1:b0:1e5:b82:3c24 with SMTP id a1-20020a170902ecc100b001e50b823c24mr3154050plh.53.1713541253557;
        Fri, 19 Apr 2024 08:40:53 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:6f51])
        by smtp.gmail.com with ESMTPSA id f14-20020a170902684e00b001e4008127a7sm3544116pln.137.2024.04.19.08.40.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 08:40:52 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Fri, 19 Apr 2024 05:40:51 -1000
From: Tejun Heo <tj@kernel.org>
To: Sven Schnelle <svens@linux.ibm.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>, linux-kernel@vger.kernel.org,
	Heiko Carstens <hca@linux.ibm.com>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] workqueue: fix selection of wake_cpu in kick_pool()
Message-ID: <ZiKQg6fxn6OxAmr5@slm.duckdns.org>
References: <20240415053550.538722-1-svens@linux.ibm.com>
 <Zh8EfxdVdiIj_27H@slm.duckdns.org>
 <yt9dpluogfw9.fsf@linux.ibm.com>
 <ZiB9rYBu-0qjsCbF@slm.duckdns.org>
 <yt9dzftp3gh2.fsf@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yt9dzftp3gh2.fsf@linux.ibm.com>

Hello, Sven.

On Fri, Apr 19, 2024 at 10:27:05AM +0200, Sven Schnelle wrote:
> > Probably by wrapping determining the wake_cpu and the wake_up inside
> > cpu_read_lock() section.
> 
> Do you mean rcu_read_lock()? cpus_read_lock() takes a mutex, and the
> crash happens in softirq context - so cpus_read_lock() can't be the
> correct lock.

I meant cpus_read_lock() but yeah we can't use that here.

> If i read the code correctly, cpu hotplug uses stop_machine_cpuslocked()
> - so rcu_read_lock() should be sufficient for non-atomic context.
>
> Looking at the backtrace the crash is actually happening in
> arch_vpu_is_preempted(). I don't know the semantics of that function,
> whether it is ok to call it for offline CPUs, or whether the calling
> code should make sure that the cpu is online (which would be my guess).
> 
> Following the backtrace from my initial mail, I can't find a place where
> a check is done whether p->wake_cpu is actually online. Eventually
> available_idle_cpu() is calling vcpu_is_preempted(). I wonder whether
> available_idle_cpu() should do a cpu_online() check right at the
> beginning?

Yeah, adding a cpu_online() test there makes more sense to me.

> Adding Peter to CC, he probably knows.

Peter?

Thanks.

-- 
tejun

