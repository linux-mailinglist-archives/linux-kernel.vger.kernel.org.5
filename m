Return-Path: <linux-kernel+bounces-140113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C723D8A0B8B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 10:43:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2AF47B24DBF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 08:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62D5E140367;
	Thu, 11 Apr 2024 08:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NiUu9lwh"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C465413CF91
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712824998; cv=none; b=ZDl2gkaWADmBdJEEybRSvdBJQBIjzp2gnsSTfzTyhcmHGiCareWAomuqmnUiWVIgc+6XkGNwjfvIJBwXUNXEcDFIpy2nJxtjFOfMJBqhF7ipjpAmT6iN2J1rBZyUkQ3B5V64iPOyGYc1+7rTMwGQkbKQLb6IV8UCpAa4HIRhD/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712824998; c=relaxed/simple;
	bh=509tLOzcoQMNLfib7BdfX6IBKnV24Z4MFZee3M0g70U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VvG3bEBuQxk47Del+jqMJ7lJ1Pvd5fZcV5PodFw76iK6EtHTf+vyHN6zMtFtxF9IbKp8A6fr81d6+Crvt2K1OFd2YdoS2Jmn/00t1OAfnYZmCM2gNe9jzYtErgU9vnhrEc6DQxou3mv85HtwlO7Sf/P28kZkLarkLClQsNqNJ5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NiUu9lwh; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-56fe8093c9eso327805a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 01:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712824995; x=1713429795; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pkj3gKmI4mkg3upyNhlsCNRZCTuzGBdlaUscEUL/TVE=;
        b=NiUu9lwhXaxf90Dm/rJZt8U/lQOI4f0S2ctHlH+Jx1+T4OI0NT6FafBUOrRLThRAGf
         USqbDw44hZFBFz4/9lpkpbo6twyN2I+8LGVsfhRvZYGp3j/AXxGmF5qnW36aBSB33gMl
         cXw5Jtla+t0NC73DCQtnDQyydGnsIhtjgUyuhVTS/nxJw4NuqXXQ+UZoT/Ly4/rECenc
         +KQFFuuyIGwJDUVbfCS6lj9FsmRfNE2YOolCgJ80ABi859Cn04Io+279O11RiQnozeS4
         8I6CvVVOZmwave88d4UD0/TqCjRdYVL7eK0IEJC9u5iExfGIoXa+XVqT/mukAPEQPbYM
         OFxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712824995; x=1713429795;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pkj3gKmI4mkg3upyNhlsCNRZCTuzGBdlaUscEUL/TVE=;
        b=dpPpg5+3jHUPQ5mi9R2cnjD6CroLMcBvbDOIpcAr1piaqiNptX5L2DD+VBQ++rX8Ol
         YhkSADMvXrDVs2jAVnWstTAvSnyG+OS0j35HtSyynqYlbEmazrBoMiIpftnoJ3krxaHG
         uT1sYf0f3tV7h38WOcGsvGi5P/F5GuY46WfLV5aLOAdPSjvjMJ+tbBOLrcQ1JGXefwqI
         hL0slFB/zc8oR//ZDKfa1guIAZDbVY6RDp5IHxqHw/nRtRWEt+FhMs5VQq9ssY/nuhNz
         gAeENvIAi0I9/YBupQ3fbZ9dC34gXgBBHuJYUcl3tPmmAQqPahQf3dFQ78xwPhYqQ/VP
         9udw==
X-Forwarded-Encrypted: i=1; AJvYcCW80lJxofL/T7wtk+t6S2mkfEDh6IL10izjwIVgtf4NdQjIRqJUsgU2zdGvKpDismdl+rH2ZUvxl4rze+xf2VNX/opZ4RhcNp7yLVY5
X-Gm-Message-State: AOJu0Yxu4cvOiyVk8VzLyAHNVQh420Axjyuz9FWoXMccnjW4aRCxzcIR
	cYTXdgHd1o5TvEb39bd2PZyKHESWizfzulwbYGlQaXTvEJAf97qJ
X-Google-Smtp-Source: AGHT+IFYsIDqOSNSnUIk23LsFp9ibh3YtKTFtVM2FUq9okoHRIzJW3fAbzYi9y6NKd3lt68gn+B8Fw==
X-Received: by 2002:a17:907:33d3:b0:a4e:5540:7c0c with SMTP id zk19-20020a17090733d300b00a4e55407c0cmr2418806ejb.70.1712824994644;
        Thu, 11 Apr 2024 01:43:14 -0700 (PDT)
Received: from gmail.com (1F2EF1A5.nat.pool.telekom.hu. [31.46.241.165])
        by smtp.gmail.com with ESMTPSA id ku21-20020a170907789500b00a517e505e3bsm527610ejc.204.2024.04.11.01.43.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 01:43:14 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Thu, 11 Apr 2024 10:43:12 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Nikita Kiryushin <kiryushin@ancud.ru>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ashok Raj <ashok.raj@intel.com>,
	David Woodhouse <dwmw@amazon.co.uk>, linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: Re: [PATCH] x86/smpboot: Add map vars allocation check in
 smp_prepare_cpus_common
Message-ID: <ZheioNCrbeT+0UHR@gmail.com>
References: <20240409182940.664482-1-kiryushin@ancud.ru>
 <ZhaUZFY5MUyy6hWK@gmail.com>
 <75c2b85a-da67-4037-b2b5-6a1dec838fa9@ancud.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <75c2b85a-da67-4037-b2b5-6a1dec838fa9@ancud.ru>


* Nikita Kiryushin <kiryushin@ancud.ru> wrote:

> But I have some questions considering __GFP_NOFAIL. It clearly shows, 
> that allocation will not fail/is not expected to fail, does it not try 
> making allocation until it succeeds? Would not it make the system hang in 
> a problematic case?

Yes, which is better than undefined behavior. This case should only happen 
on hopelessly buggy kernels or hopelessly buggy hardware - which will very 
likely crash way sooner before they get into this part of the init 
sequence.

This whole problem is a non-issue.

Thanks,

	Ingo

