Return-Path: <linux-kernel+bounces-161330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5732E8B4AC0
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 10:42:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5B191F216D2
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 08:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 275FD5491A;
	Sun, 28 Apr 2024 08:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kpzVYe6r"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D569C524AD
	for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 08:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714293772; cv=none; b=Fko4zX4V6vfRDSCABc7iduWsYP/W+a32kg8nlImbTsUGxvNSb9V07jaIb1s8K4b1K+MgDLZxm3UpUxVLovZHUzVLjPzTZlmbxDk/0qvcxfhu1/ElZ1Mzh+YcW9EAUbpGT96e4gTMoX5oz4cwJKcfT9fTSKNGjNLWRYqj9OUtuko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714293772; c=relaxed/simple;
	bh=02/K2HAr+D2x3ulPFagrkel5yK4Aw5aa/BEdv3Rb40E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T8oUmbWVeC6SAH/lj1/vHsOKCoLa2k7elKrH1VV4WovjRFJ8ARAP84gcXWge8vUqtKVGhZlgsw9mO5ZxTT0rVjOHONSFP5udZwo3O7Q17ph6Yc5zqNNxvW1LOZ41NIdAl0Q35fHUo8+rc5GMz2Bkv0QVplZ/5K+hDFhz5zKF7GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kpzVYe6r; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-41b5e74fa83so22881755e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 01:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714293769; x=1714898569; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o8JSNHwNP9YtLUhkcZUuebpXqTH8QF8IgqhXrTUgnlI=;
        b=kpzVYe6r6wNiy5eVf2HSPEbBOhGa2hZ5T6mFGMWEmlANPNs11/Ch3ogFzc1K/7Iew5
         ew8JYcPht1/0q0XV003Rb+I3seaAdaJmFTFt2/kZj0H7YdzllvvYG2yGkTDSHAvmp2Yj
         Osc1uprMw7v9RDA+P3FbC7ZMnm+7k3/35qiAVwlOp/qWbvnVOskure2+zCFw4JSB7rYZ
         fJ1Jbi0pPu8KoLO/DTkYA7nQkHti5PwPPxWpXxDY+ASVn9jO+21OLo7NgwLEpwpY3HAc
         WwQzg++HNrIa1LpIKkvpBZUecISyqT9Eq0Z0+GaXnyOuwgL3kD49m9H72bmGBVtKkESn
         iZBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714293769; x=1714898569;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o8JSNHwNP9YtLUhkcZUuebpXqTH8QF8IgqhXrTUgnlI=;
        b=TXZxVhmKuXMiCMJVfk5E3vTjPVMv2bxYe7hUtMLjwols5L+LgJ47rd/K5xvIcpqWOY
         /9wh1/i9julCDt0H87Wqo0sfNd+JqndWQm/KqW2d1VSpWoRDqPKH7R+4vAqSyxU/GYHb
         3qms9W1X0e1LgV+Yndhm/fxeuaz1RDkUg5VPv8v9/yvvsn6tq4ntVulew+ktkP3EHWTQ
         utysf1F2+uQqM1sQAbCRs/18cGYpDpb35suppnCnX+ZePadhXrJIrGtadHRUjeoyH3iD
         cxDvBAR9jkG19xETIq0ATdA/e/byOJC3tsyTFm2ZpVCjwn0v8x0GboQsG7csjjEqhT3T
         w0ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWAZP/k2yfkUL7PzeDoyRakQaEY0sgyW9a1vDRC2q+iQ0BOhqUryVqzFYmLv57yE6PSiaLVcxO8gPz/BmnuXFTy83cTdboY4lIFeiyy
X-Gm-Message-State: AOJu0YzunA6xYqAhi9FqCI1Usw7AyjyYsKCe1In16SC8TQH3Czmk+adb
	iqDp4h/CXK7pfuOO+Hk4K+DYRZ415WSdJvCN/BljyRL1dkmc0sQq
X-Google-Smtp-Source: AGHT+IEaBq2tr9A7C78fJt6INHzVxNDDqc9867XotYY/NwSnau49yX4c7uYWXTMCRPpCkVVglndLLg==
X-Received: by 2002:a05:600c:470d:b0:41a:1b3f:b465 with SMTP id v13-20020a05600c470d00b0041a1b3fb465mr3550070wmo.26.1714293768655;
        Sun, 28 Apr 2024 01:42:48 -0700 (PDT)
Received: from gmail.com (1F2EF175.nat.pool.telekom.hu. [31.46.241.117])
        by smtp.gmail.com with ESMTPSA id v10-20020a05600c470a00b0041bfa349cadsm3037202wmo.16.2024.04.28.01.42.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Apr 2024 01:42:48 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Sun, 28 Apr 2024 10:42:46 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
	linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Juri Lelli <juri.lelli@redhat.com>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>
Subject: Re: [GIT PULL] scheduler fixes
Message-ID: <Zi4MBjmqMr0Ndwpf@gmail.com>
References: <Zi4HyMFJBwm+JIKZ@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zi4HyMFJBwm+JIKZ@gmail.com>


* Ingo Molnar <mingo@kernel.org> wrote:

> Linus,
> 
> Please pull the latest sched/urgent Git tree from:
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-2024-04-28
> 
>    # HEAD: 257bf89d84121280904800acd25cc2c444c717ae sched/isolation: Fix boot crash when maxcpus < first housekeeping CPU
> 
> Misc fixes:
> 
>  - Fix EEVDF corner cases
> 
>  - Fix two nohz_full= related bugs that can cause boot crashes
>    and warnings.
> 
>  Thanks,
> 
>	Ingo
> 
> ------------------>
> Oleg Nesterov (2):
>       sched/isolation: Prevent boot crash when the boot CPU is nohz_full
>       sched/isolation: Fix boot crash when maxcpus < first housekeeping CPU

Merge note: in case you are wondering about the timestamps, I ninja-rebased 
these two commits shortly before the pull request to fix an annoying typo 
in a commit title.

Thanks,

	Ingo

