Return-Path: <linux-kernel+bounces-96260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FC84875968
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 22:33:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 980301F264DF
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 21:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 591B213B797;
	Thu,  7 Mar 2024 21:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aeHWc2uL"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2EBC634E4;
	Thu,  7 Mar 2024 21:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709847176; cv=none; b=ONJ3av8SPBCnAmSj0VJToqZhorsh5OUMnUxxsRr6Z52Lg8pW3akjR19kNJ2ZZYj0s0dbSanYgZXZANh3IHSyXFis0EjJYel5OndKn/2od5cekmb0TAymCkAALy7NFiPEvRhJGrfXJd0nI0xu3RuslbBNkW8g5k2xf4kTYJwhBbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709847176; c=relaxed/simple;
	bh=T1acbK4syDy12qynlLt3cHonJ2RsscIuuNF0FA+iwB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o9/jaDVd5v9C9UlXppOg4h59eltrHFvFdNzkxDdNwbhZc9041n/lCnbBm5bL6UpKW7mp8ASvfBEu7rw8dzfpDJs7ZHckiso7THg4H0y1y+M3yy56X6gf1/H28TZDVf7t3wRqBNa4uIKnCHNxY6xvYCaMUQUitRVZPDKS0Q6EO+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aeHWc2uL; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2d3f4fef377so18297981fa.1;
        Thu, 07 Mar 2024 13:32:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709847173; x=1710451973; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BsLM3ni1DoQObcnwbdIeTZvE2aHaqZB+Kv3fZAxgw7k=;
        b=aeHWc2uLR0vgDWgCa2Ye6ksGip32kOdbalcd0FhkrSVnbq41b6Zv2/yO1F6fixmnKH
         n1uioYJudNDPPs9rx66ICgZMquwu9yPX/FWIAHXZMoaylwwwWpj34Cac1mki8BsMfO1V
         HCulHg/O7AphBZFP6oTlm7HyoHkmyE43qokziMi0i5HVSU42aee9gGzbfPBIWHGffllU
         HEEl3FPWxcsSKqvp2GNr7cD+piJfFVnsrnkMn6nz+I8Wy+QqcKEim0Q63mElMVdMmk5o
         qMG0aP8C4PwvsBohZJF/tMwPoiOsdwPuqMEh6Kkh3BSs2Z7K9ZuiyoNzR/bUnxYVPiv/
         g8Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709847173; x=1710451973;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BsLM3ni1DoQObcnwbdIeTZvE2aHaqZB+Kv3fZAxgw7k=;
        b=FxeFCtp5CYm8yB9E+swq5yrqfVamS12FLdRzbTFIJFZdyCBnJIqFT1BrWHNled5xJ2
         c1/6VYED5o9o5eLrk8GAuLN1dsEoiM+yyNCj3kSbLaqdlwCjxkI8DQf0jEG5KY/jHuFb
         lL8Piq/QKvHWhe8xxHnyGMP+Zwi4uLpQ4Y1+nb9L9GcFVLvS3u1F13fX0HFMlIA8lH36
         it8bBiwomJFxIh+KOxIaPz5yJuB0vSTtLhcYxq9NHzKBylhbY45FHFOm+gaeSCmID/5C
         8MGtnjvd0rnlethAySlLQCAAY+qgSVsVs5eOJzJ/XmkQG5aJMRrvw4CQJny5X5XtgUAR
         IxqQ==
X-Forwarded-Encrypted: i=1; AJvYcCXc9FVgH8mESIuaQfZR+Oi8iLTabKI0DkgwYcbm8BTNSaSiOIvXkrrArrbtkDk1t6ZuB6VDVWV3tRHRlZ4g+NxIsrIv+fXOXEhMVo0oXepVpY9mWoBe4SaSck+G2tJmqNWkylh5QwPcoQGvdA==
X-Gm-Message-State: AOJu0YyeopCwRzckHhHLvzPDV7/+t7hO4FmMZTzBDKtehk2Cpb+6zIst
	a3kWW5LSVpFMi7VOmfOLgzNStuS7OZblRlxXWTQsQ6Wcjl34GSnxYh2GTdbx9zs=
X-Google-Smtp-Source: AGHT+IHVDP/rfhfesJ39r7ZJoG3nWsfYfY7twQ8eRzBQ40SS0p8G6JnivZBifvJe0eXxbZJA4aZRFw==
X-Received: by 2002:a05:651c:10d1:b0:2d2:47e0:4432 with SMTP id l17-20020a05651c10d100b002d247e04432mr2354846ljn.1.1709847167830;
        Thu, 07 Mar 2024 13:32:47 -0800 (PST)
Received: from eldamar.lan (c-82-192-242-114.customer.ggaweb.ch. [82.192.242.114])
        by smtp.gmail.com with ESMTPSA id g3-20020a056402180300b00566ea8e9f38sm6968801edy.40.2024.03.07.13.32.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 13:32:47 -0800 (PST)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id 78209BE2EE8; Thu,  7 Mar 2024 22:32:46 +0100 (CET)
Date: Thu, 7 Mar 2024 22:32:46 +0100
From: Salvatore Bonaccorso <carnil@debian.org>
To: Linux regressions mailing list <regressions@lists.linux.dev>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux x86 Platform Drivers <platform-driver-x86@vger.kernel.org>,
	Linux Stable <stable@vger.kernel.org>
Subject: Re: Fwd: Continuous ACPI errors resulting in high CPU usage by
 journald
Message-ID: <ZeoyfjOdHECxn6ck@eldamar.lan>
References: <Zd2bsV8VsFJMlbFW@archie.me>
 <f7f6bcf7-c919-4077-88f6-bfffe112ba72@leemhuis.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7f6bcf7-c919-4077-88f6-bfffe112ba72@leemhuis.info>

Hi,

On Thu, Feb 29, 2024 at 09:49:08AM +0100, Linux regression tracking #adding (Thorsten Leemhuis) wrote:
> [TLDR: I'm adding this report to the list of tracked Linux kernel
> regressions; the text you find below is based on a few templates
> paragraphs you might have encountered already in similar form.
> See link in footer if these mails annoy you.]
> 
> On 27.02.24 09:22, Bagas Sanjaya wrote:
> 
> > On Bugzilla, danilrybakov249@gmail.com reported stable-specific, ACPI error
> > regression that led into high CPU temperature [1]. He wrote:
> > [...]
> 
> #regzbot ^introduced 847e1eb30e269a094da046c08273abe3f3361cf2
> #regzbot duplicate: https://bugzilla.kernel.org/show_bug.cgi?id=218531
> #regzbot title platform/x86: p2sb: Continuous ACPI errors resulting in
> high CPU usage by journald
> #regzbot ignore-activity
> 
> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
> --
> Everything you wanna know about Linux kernel regression tracking:
> https://linux-regtracking.leemhuis.info/about/#tldr
> That page also explains what to do if mails like this annoy you.

The fix for this issue seems to have landed in mainline:

aec7d25b497c ("platform/x86: p2sb: On Goldmont only cache P2SB and SPI devfn BAR")

Regards,
Salvatore

