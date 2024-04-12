Return-Path: <linux-kernel+bounces-142041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 542728A26A7
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 08:33:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0ACB5287B39
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 06:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADB85168A8;
	Fri, 12 Apr 2024 06:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ueViv4fc"
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2FA18C15
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 06:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712903572; cv=none; b=Q7tK0zR9t7OPL+aTWJZm2fQEb11/prcWFSkcFDEckdrejfJ6WFlenbcAljHt5tvfjVWFUkeK4rL0IEgxBQkeX9k6eMvWeBkMB68+mwuJwBDvDeBZSpV58POxxLKyKYMubCo3KefKYHcLhhycsj/+RfZrGCE1xmHvyMe95gNeP9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712903572; c=relaxed/simple;
	bh=uxgkGq0IyS6tdhfrvKhR3900zGHBdDLE3NA0/IJa7u4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uuTO9NExv4bnPnyMIxz6B+LyKe/4JssXHX4W1ofRB18uaE6ISJGlymcWuJToKzI8bZabBO6xJzLoBOYj1UejZdd2PoxcBkkYJujne/t2aNsIwzucS/CjxoQxUZl5pWm3Oj5IUH+mvSt+pXMoWLfdipt+o24W+0F0NrmKrPFmtM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ueViv4fc; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-6ea2ac4607aso371461a34.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 23:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712903570; x=1713508370; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1gOcCS7A/vf1M4eu5npCTxNSh214bCEI8cslchyUmXs=;
        b=ueViv4fcJ+UKCH12lF9EWdGk8miFn+ZBZYjTAFy6/WU92xkPAoadlvU9xIeZIuFTm8
         2yFEQ8TmBnf4RjTlj5Wlz96Tys/I0niRHWDzoeaJdKHMxelurbg8Ejv1Y9LMFB4JgFRl
         FQJzUK0Gv4EKnVsfHikd7VZUCR34LIcOzOFRF3SKMhy1BUX+lM9Nqi+4K0rO9xoZtTOS
         jk3Y0ui2EEVgBXpUzYjpLnUZZ+cFUjZ8R5phHKlthOOd4+RkFi2fcHjUg8koDRBUw/Jw
         bcT+N2UXqVCB4ALUWbTaCvJgTFmBerk9r2z1NXPxRxUgTMHXgcKNGBkGLAqxQTIhIdb+
         jx1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712903570; x=1713508370;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1gOcCS7A/vf1M4eu5npCTxNSh214bCEI8cslchyUmXs=;
        b=g+jCBVDatm3t/w1WLXMSMmoFbDiNjj2F4p6/3FmrHZEY+B+TdtuLUtI2n2LaN+bpYA
         /T7jToFck464W4ugL74QyOXLVTrhQPOVXUKlemku0UNpebeIfGDDU6CE+r1+ksWdZKKo
         NpAUugYGUT6byStNVAHhPaUoZRK64oZenVCWG02h4omuJ6Xrzv4istBD8vj9pgweIQ4h
         hIGn3JlwjMdRSffRPrQDfhZD2QbPDKzOfAH3koSj345enIxrDj46UsRW1ezvl8Vvaa9z
         5RjRP0gyYfnQtH7DvCsMMQ0M730RzSCryXmkRCvoLUY2hLU0BeQinauc6Iw6Nvf5wViu
         JqHw==
X-Forwarded-Encrypted: i=1; AJvYcCVfEBKdPSLBojkWYfAFEi73SMcfQz9y8cjbjXFrChVKtgxc7bS62BitwYfTUdu0yK40dmjVOeiRCMBqo6lR1+dirRduo6zYuXszS61x
X-Gm-Message-State: AOJu0YxQyAkstIkIu6o5MPnrcj3D7jhbBQSQFf+1puCWxISyDKsk/k6c
	vyKatEOH4E+1icsLOw+qONTnE9hZM3fCF3wPrFvQaVtHg1pqsYEyJ5r6OUl8Cew=
X-Google-Smtp-Source: AGHT+IGBxBOg4TEsrK4sE46CjyZBiwV0uRDNuCX52Ny7ovU474/OKXO1O6Hb1DpNkthFrxyKZZXJIQ==
X-Received: by 2002:a05:6830:4790:b0:6ea:2a61:176f with SMTP id df16-20020a056830479000b006ea2a61176fmr1779921otb.18.1712903569570;
        Thu, 11 Apr 2024 23:32:49 -0700 (PDT)
Received: from localhost ([122.172.85.136])
        by smtp.gmail.com with ESMTPSA id k28-20020a63ba1c000000b005f0793db2ebsm1793984pgf.74.2024.04.11.23.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 23:32:49 -0700 (PDT)
Date: Fri, 12 Apr 2024 12:02:46 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: gregkh@linuxfoundation.org
Cc: lizhe <sensor1010@163.com>, rafael <rafael@kernel.org>,
	linux-pm <linux-pm@vger.kernel.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cpufreq: exit() callback is optional
Message-ID: <20240412063246.tk5z245miakbxws4@vireshk-i7>
References: <b97964653d02225f061e0c2a650b365c354b98c8.1712900945.git.viresh.kumar@linaro.org>
 <5759bc29.32d04.18ed0ef5037.Coremail.sensor1010@163.com>
 <20240412062407.ntahibzv6xsbrnxs@vireshk-i7>
 <1b53a162.32e95.18ed0fdb13e.Coremail.sensor1010@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1b53a162.32e95.18ed0fdb13e.Coremail.sensor1010@163.com>

Getting the Cc list back, + Greg.

Greg,

Looks like another one of those experiments with the community ?

:)

On 12-04-24, 14:27, lizhe wrote:
> You are really disgusting and have no manners at all. This makes people feel disgusted with your company.
> 
> 
> 
> ---- Replied Message ----
> | From | Viresh Kumar<viresh.kumar@linaro.org> |
> | Date | 04/12/2024 14:24 |
> | To | lizhe<sensor1010@163.com> |
> | Cc | rafael<rafael@kernel.org>、linux-pm<linux-pm@vger.kernel.org>、Vincent Guittot<vincent.guittot@linaro.org>、linux-kernel<linux-kernel@vger.kernel.org> |
> | Subject | Re: [PATCH] cpufreq: exit() callback is optional |
> On 12-04-24, 14:12, lizhe wrote:
> > I was the first one to find this problem, so the patch should be submitted by me.
> 
> :)
> 
> This patch doesn't take away any of the work you have done. What you are trying
> to do is simplify drivers with empty exit callback and the unused return value
> of the callback.
> 
> And what I am trying to do is fix a bug in the cpufreq core, which only makes
> your other patches more acceptable.
> 
> So no, you never identified the problem this patch is trying to solve.
> 
> Please don't feel that anyone is trying to take away your hardwork. That's not
> how things are done here. We appreciate anyone who is spending time to make the
> kernel better.
> 
> If I were to take credit of your work, then I would have sent a big patch to fix
> the exit() callback issue you are trying to solve, with randomly sent patches.

-- 
viresh

