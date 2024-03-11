Return-Path: <linux-kernel+bounces-99338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFDE28786DE
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 19:00:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AFBE281281
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 18:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB69654BD8;
	Mon, 11 Mar 2024 18:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WyL2tVQD"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B767537E3;
	Mon, 11 Mar 2024 17:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710180001; cv=none; b=SfzUEy21WwUOg/R44JGpJf+LNyeUeFCEbDpXFja7pHcC118Ie3grjwgEkY8QY2r2JzpT6+Tf8V55EANDjfaOa0FfugCCoxVFbd/mfuGcoXOS8+EU5JfTzoPRtSmnoe0ZD7GgDarYyXs9BPrf4PhKVT67LC3cOTApay51MzKTLTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710180001; c=relaxed/simple;
	bh=2c3lV2jTzoYOBHWiSD2R429XF1UT/AUT774OAIhD9X8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QcwXC5lyEoSZd5Maf3RdfscjqxkSQ/g1/N27L0f2D9mFUVtV2MEjVF7usR7aCJKTS0T4IKE55VW951XCBf7xTWtzYzLCnv0x4/wlYFzs9acsMbdnEqmY41f8vCTUNX0+DSXmghm3rwYoSJd0v0jh70+Tpt0PD7bEQ/MqBbQY6Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WyL2tVQD; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-29bd4dfbf56so1228973a91.3;
        Mon, 11 Mar 2024 10:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710179998; x=1710784798; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VwzG5Nm3k5sScApQNXJxPh63PgQB/wEWtXh54ZIc9U4=;
        b=WyL2tVQDdnLp2RXaf9XmW3L95i8laY0WpA1CdpZc57wlJCJSiXFZPyKdR620TgqGPS
         tWMXcm8klEg2eDW7dxeA2BOSdKdFgHZvL17t8CpUqmvCov5fu//whn/92vmjwHQSV2d6
         yO6jTnwShrbycRXcGiJbe4WVm3OfrflxWg/pMH57cdA8tIWcLGbj/KXhNkm2/qgVLNiw
         uvN2IQqN5Qdl5yQQDfq+TbaNgJ0GPtdlAsMTKm1RCqyRdvi9FTWaCS0gb7dpWMRNGXvC
         McYqnpGzNz5hy5TVFElA9VDtvkBvmnoHNVmEQed/JGtvn8kViLHSmiPuMUEDRd5RBJyp
         LlQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710179998; x=1710784798;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VwzG5Nm3k5sScApQNXJxPh63PgQB/wEWtXh54ZIc9U4=;
        b=I2XNp68b7/GznZyVXjTAZ5eq99FQFfMqhiz+P9qBXzN3/qdrJ2TM3xpQajsMDt+pdT
         d86BwwgCaBI2f1OqP8spbAu+Rg91Zw81OfApDin5QIAskc/5b0gFooW5b3WH8q00VytC
         zymrqlUN9ESkCvp22dwwDmL3MSTE2Q8odmxQIvyoV5sR/UX4klV6BKWTvTPM9kgJ1tJc
         cLpctmMar/sq+MEYrSyLcneb6FniR3bjxfDMzbd6zEaj/RCuixa2g+wJqLRKlPjjQYrW
         nIbQu63ifyfJGK3RQqDgSd5+hhg5iFSkk94QfMuPVOnE6zKUb0oUeSe/keSg8JvnIJM7
         ghLA==
X-Forwarded-Encrypted: i=1; AJvYcCUlCkUh8Bx/MAYKrzXcLKJvpGc48FfCla9vA4DMgYqTtVwoFUlNtUw+MpamY5eOtY/z/wQxSQL52yAKyrNnnRCInvAf4VjGRf5Ip2E/J+uf8bbo8XYlrM5ynOM+4MCO8tEFgKK+u1Id
X-Gm-Message-State: AOJu0YzcZhE1/GX/NZPh62ft1Us+RsrEndVGE8WkZPCUkdREaQypdE/o
	bT9qbs9zJoO66cOSO8jdMVvLG84ZQWunpjn0FRmLLZCFeIPUrcpR
X-Google-Smtp-Source: AGHT+IFKY6YUN4OMd42c8vr9KnFOMejKrxTjFewl0BixWINQ9UOKdO7REdZ3namD0GMu3pRqLoLQpQ==
X-Received: by 2002:a17:90a:df82:b0:299:4269:b8c9 with SMTP id p2-20020a17090adf8200b002994269b8c9mr5500216pjv.26.1710179998530;
        Mon, 11 Mar 2024 10:59:58 -0700 (PDT)
Received: from gmail.com ([205.251.233.182])
        by smtp.gmail.com with ESMTPSA id z24-20020a17090ab11800b0029bacd0f271sm5952429pjq.31.2024.03.11.10.59.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 10:59:56 -0700 (PDT)
Sender: Matt Wilson <mswilson@gmail.com>
Received: by gmail.com (sSMTP sendmail emulation); Mon, 11 Mar 2024 10:59:54 -0700
Date: Mon, 11 Mar 2024 10:59:54 -0700
From: Matt Wilson <msw@linux.com>
To: Vegard Nossum <vegard.nossum@oracle.com>
Cc: Jonathan Corbet <corbet@lwn.net>, cve@kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	security@kernel.org, Kees Cook <keescook@chromium.org>,
	Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	Sasha Levin <sashal@kernel.org>, Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@denx.de>, John Haxby <john.haxby@oracle.com>,
	Marcus Meissner <meissner@suse.de>,
	Vlastimil Babka <vbabka@suse.cz>,
	Roxana Bradescu <roxabee@chromium.org>,
	Solar Designer <solar@openwall.com>, Matt Wilson <msw@amazon.com>,
	Matt Wilson <msw@linux.com>
Subject: Re: [RFC PATCH 2/2] doc: distros: new document about assessing
 security vulnerabilities
Message-ID: <Ze9GmrqiW18GMkU6@uba002e82b7465e.ant.amazon.com>
References: <20240311150054.2945210-1-vegard.nossum@oracle.com>
 <20240311150054.2945210-2-vegard.nossum@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240311150054.2945210-2-vegard.nossum@oracle.com>

On Mon, Mar 11, 2024 at 04:00:54PM +0100, Vegard Nossum wrote:
> On February 13, kernel.org became a CVE Numbering Authority (CNA):
> 
>   https://www.cve.org/Media/News/item/news/2024/02/13/kernel-org-Added-as-CNA
> 
> The kernel.org CNA/CVE team does not provide any kind of assessment of
> the allocated CVEs or patches. However, this is something that many
> distributions want and need.
>
> Provide a new document that can be used as a guide when assessing
> vulnerabilities. The hope is to have a common point of reference that
> can standardize or harmonize the process and hopefully enable more
> cross-distribution collaboration when it comes to assessing bugfixes.
> 
> We deliberately emphasize the difficulty of assessing security impact
> in the wide variety of configurations and deployments.
> 
> Since what most distros probably ultimately want is a type of CVSS score,
> the guide is written with that in mind. CVSS provides its own "contextual"
> modifiers, but these are not accurate or nuanced enough to capture the
> wide variety of kernel configurations and deployments. We therefore focus
> on practical evaluation under different sets of assumptions.

(sending from my msw@linux.com account to emphasize that I am speaking
only for myself, not my current employer.)

I'm not sure that Linux distributions particularly *want* a CVSS base
score for kernel CVEs. It is something that downstream _users_ of
software have come to expect, especially those that operate under
compliance regimes that suggest or require the use of CVSS in an
enterprise's vulnerability management function.

Those compliance regimes often suggest using CVSS scores as found in
the NVD in search of an objective third party assessment of a
vulnerability. Unfortunately the text of these regulations suggests
that the base scores generated by the CVSS system, and found in the
NVD, are a measure of "risk" rather than a contextless measure of
"impact".

There have been occurrences where a CVSSv3.1 score produced by a
vendor of software are ignored when the score in the NVD is higher
(often 9.8 due to NIST's standard practice in producing CVSS scores
from "Incomplete Data" [1]). I don't know that harmonizing the
practice of producing CVSSv3.1 base scores across Linux vendors will
address the problem unless scores that are made available in the NVD
match.

But, stepping back for a moment I want to make sure that we are
putting energy into a system that is fit for the Linux community's
needs. CVSS lacks a strong scientific and statistical basis as an
information capture and conveyance system. A study of the distribution
of CVSSv3.1 base scores historically generated [2] shows that while
the system was designed to resemble a normal distribution, in practice
it is anything but.

A guide that helps a practitioner evaluate the legitimate risks that
may be present in a given version, configuration, and use case for the
Linux kernel could be a very helpful thing. This guide is an excellent
start for one! But as you rightly call out, CVSS is not a system that
has an ability to capture all the nuance and context of software the
likes of the Linux kernel, therefore the focus should be on practical
evaluation under common use cases.

> Create a new top-level (admittedly rather thin) "book" for information
> for distros and place the document there as this document is not meant
> for either developers or users.
> 
> See the rendered document at:
> 
>   https://vegard.github.io/linux/2024-03-11/security-assessment.html

[...]

> +
> +CVEs and CVSS scores for the kernel
> +===================================
> +
> +CVSS (`Common Vulnerability Scoring System <https://en.wikipedia.org/wiki/Common_Vulnerability_Scoring_System>`_)
> +is an open standard for vulnerability scoring and the system which is
> +commonly used by Linux distributions and various industry and government
> +bodies.
> +
> +We won't go into the details of CVSS here, except to give a guide on how
> +it could be applied most effectively in the context of the kernel.

If the guide has something to say about CVSS, I (speaking only for
myself) would like for it to call out the hazards that the system
presents. I am not convinced that CVSS can be applied effectively in
the context of the kernel, and would rather this section call out all
the reasons why it's a fool's errand to try.

--msw

[1] https://nvd.nist.gov/vuln-metrics/cvss
[2] https://theoryof.predictable.software/articles/a-closer-look-at-cvss-scores/#the-distribution-of-actual-scores

