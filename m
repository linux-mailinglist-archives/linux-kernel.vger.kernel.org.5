Return-Path: <linux-kernel+bounces-56964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FD0C84D1DF
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 19:58:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04F551F26129
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 18:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B06A785266;
	Wed,  7 Feb 2024 18:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jIM8ZpIc"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925AE84FCC;
	Wed,  7 Feb 2024 18:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707332286; cv=none; b=Rq4UjJU844ewQSkbnNDxBBZIxCj8Sb1oq+m/sNJfF4hllPFnqjMaYrh8k3QNhZirod7J1ZVLkjtfWNJVKZmmRsZ1R1FsNSkGMKFvinjFNmvDjXNg6C1stA9ByxVb/XlT5EZvTY9wKbzAYMKFBoh4sYItXu286wjdGzUgbRsp4Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707332286; c=relaxed/simple;
	bh=pAOj+DSJjz+jvCbGKZ44IvbjjglxWKMYA2+il8mYawo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P5ZJXAxPUoIepW2pLV0VpA1xtE5wWp0fTyiDpU688JLgdk+mtAka7BBgp0A3GGRDQpK9QzaxHTCYKrTI3i+aIP0WP+rUZL4nkCLpbzFE6yQwavBYHHlfPC1UQaQXOMQaSeVtNuvPwDMRc1HbgupQ1fPNvPD+yX8GhjjdxxvsINk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jIM8ZpIc; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-5d8b519e438so821915a12.1;
        Wed, 07 Feb 2024 10:58:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707332284; x=1707937084; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nq0e4pOcA//e/KkGEcUuu94EhWD+e4sWk9MIHyJok5U=;
        b=jIM8ZpIcVNoZ3L9flfBLte7UlQsJtdJBe85SplOGCbdZ7ajVTyPLE7FjkwniQkt13G
         f0Dd4Qcm71RyHrWn31P3YrNYxqtF2k8EmBUFfxmEVx96nhm+aldgT3k3DQqzuxHzBE/u
         ryOzqgFWQEDR3326+uqpDyyFahh7Fu0NV4gWBSEF+v8GJZi6h3/4FrdOZ7g0N9FLIMa2
         PASlRdMnjlkCsXgIGQ/nhxvaMR++13kVJqNT307ExUppdnx7k3nNTNRzhD/BovOnUSmw
         6JFGmcYohDkuCkUI7BMYzghCyzh7FDXp2haNXR0MH931qfrX9u/+pToZ8JtZsBQ4R83q
         Itaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707332284; x=1707937084;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nq0e4pOcA//e/KkGEcUuu94EhWD+e4sWk9MIHyJok5U=;
        b=BfeaIYJmTqrHzJSoxu0jjIHlq3wbGhsjjcr+Z/SXBdZYg4X5T/ktnQKA6JvWkrrkbg
         uIbJ8TYGCkw5e8PAcSMiDU0hbrWjk+pwfipreAMC1ar6bcnCLLNHsPZLjjTIuhXRz02s
         g5KDYDDGTI0l0IHYLk2vlePI3Id2BDLjtVK2uNRCGEbs9Q2SNkq6YC36nOEyrEGKszCk
         IZJfUMjjNM3bSPT+/o9b2CrOfrkqU7CyEGwHk3SZh/cQDRajiplhzSm8dv7c/iGYze+A
         Ck5x0+oJUoPtpQxvd3jRBZFZB0hpMUz8ESIJKRkV6zcy003xk0PADw2zXvvLE3ukXn2R
         Cqpg==
X-Gm-Message-State: AOJu0Yzz6xJiWILOmHDaduM2gcmnUZZe1qIJ7LNEAYoGRCEJ5mXfu3JS
	25emQC4m2gmmgJcBfAiyu3dHfx4M2b22VSAo8l9c5IHTPNr/c5K6
X-Google-Smtp-Source: AGHT+IFrezsfR3ZUFYCsjd3IteHZ8Q9Kx3xJByT+pvxVb2EZlj0Kj4RCrKcGYQOuxSTmjdUAGB7fRg==
X-Received: by 2002:a05:6a20:e115:b0:19c:6a60:b433 with SMTP id kr21-20020a056a20e11500b0019c6a60b433mr6774647pzb.3.1707332283658;
        Wed, 07 Feb 2024 10:58:03 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWYuIp9BWufSitnIyIH4En+BA2qY7vSL4td8JDn4aiFmRGgjot/RSULtT7k/Qkvi9ei3uqUbAaBcfR5tRF0kTpUuID7lLqJH0FlPyEeXUnrLUlaRaA0L8m1ntPvwljRgOHp2unUl7Y0rfKs3UD8AsiBblTlEjMyFd/id75DwqTdj54ZYyAobf7hR8+V6x/DRigcFnS09vLtx6RfQp7lH7n8AVpDQtpBYQ0hsOZsAdFQdDt2vx819zc0o+n78DNtg7NwRzgmCGidM+b4zTCmNhjnay+e4Yhrr21bvR5SjXH7Time5rpFw91/etESICon0Q/iQs/tNjJH1EXYiAsY1YJPSa0XpSCirC3b393y0/N98+/j/ljLVVRbmnxrDdM=
Received: from localhost ([2620:10d:c090:400::4:3c45])
        by smtp.gmail.com with ESMTPSA id m4-20020a632604000000b005dbe22202fbsm1984724pgm.42.2024.02.07.10.58.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 10:58:03 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 7 Feb 2024 08:58:01 -1000
From: Tejun Heo <tj@kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Linux PM <linux-pm@vger.kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Nathan Chancellor <nathan@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>, Naohiro.Aota@wdc.com,
	kernel-team@meta.com
Subject: Re: [PATCH v1] PM: sleep: Restore asynchronous device resume
 optimization
Message-ID: <ZcPSuUBoL_EDvcTF@slm.duckdns.org>
References: <CGME20240207103144eucas1p16b601a73ff347d2542f8380b25921491@eucas1p1.samsung.com>
 <10423008.nUPlyArG6x@kreacher>
 <708a65cc-79ec-44a6-8454-a93d0f3114c3@samsung.com>
 <CAJZ5v0hn=KgaWn9pwtLsH2a8n61BNxzb1xrNoxUfEi3o9OAZGw@mail.gmail.com>
 <4a043533-009f-4db9-b107-c8374be28d2b@samsung.com>
 <CAJZ5v0hDmwaFEtLc8yDc4cXn2wODXAqATe0+_Hpm9QPODUPMQw@mail.gmail.com>
 <ZcOyW_Q1FC35oxob@slm.duckdns.org>
 <2f125955-8c7c-465c-938c-8768f7ca360b@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f125955-8c7c-465c-938c-8768f7ca360b@samsung.com>

On Wed, Feb 07, 2024 at 07:55:51PM +0100, Marek Szyprowski wrote:
> On 07.02.2024 17:39, Tejun Heo wrote:
> > On Wed, Feb 07, 2024 at 12:25:46PM +0100, Rafael J. Wysocki wrote:
> >> The other one is that what happens during async resume does not meet
> >> the assumptions of commit 5797b1c18919 (for example, it can easily
> >> produce a chain of interdependent work items longer than 8) and so it
> >> breaks things.
> > Ah, that's fascinating. But aren't CPUs all brought up online before devices
> > are resumed? If so, the max_active should already be way higher than the
> > WQ_DFL_MIN_ACTIVE. Also, are these multi node NUMA machines? Otherwise, it
> > really shouldn't affect anything. One easy way to verify would be just
> > bumping up WQ_DFL_MIN_ACTIVE and see what happens.
> 
> I've increased WQ_DFL_MIN_ACTIVE from 8 to 32 and all the system 
> suspend/resume issues went away. :)

Ah, okay, that's surprising. Lemme look at the code again. I gotta be
missing something.

Thanks.

-- 
tejun

