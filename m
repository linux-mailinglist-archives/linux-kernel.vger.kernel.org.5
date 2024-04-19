Return-Path: <linux-kernel+bounces-151418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69EA88AAE9A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 14:36:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 986C01C2166C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 12:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DED2B85627;
	Fri, 19 Apr 2024 12:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kNnqByRq"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA88D1E867;
	Fri, 19 Apr 2024 12:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713530197; cv=none; b=rW1FWLegEnASVXiaG043WfQaOFPKWenCwbqPnFKbnqlsF+Cp3oSspkAxnrFHq/sZ7rI9GV+pngJct69RFV097rrKz73af1rWw1lTuFXX+OyaHEpw0svP5snb3V9L1fPPukQ7mfTHEIkVAMtwja1ajkrojJW4FVlrkPKF1eIF7Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713530197; c=relaxed/simple;
	bh=hmMFJYJeLShGfYoil0Tx2J0V4mfm9GoN40TdvPb4CIs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nkVKg6ZuQaS+Xl84B/5OrDTLlEI3hY9h583fQmoeNI+FPGi1GyDelxKJIHLKnUh8p+MAFXlII0k8h7cQQYQc8ll5saVpWp0+JODmbFXZcBt9oyF4/WjjS/CvB00Un678fJhdnA4fD4WWk5D9mlyJ2MT1P9AXwogK0i5TxITqvEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kNnqByRq; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1e4c4fb6af3so14083115ad.0;
        Fri, 19 Apr 2024 05:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713530195; x=1714134995; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AJ2O6fzXkdIMQAVMScv0OWxTVLp0wpG13C0/RNc+3ls=;
        b=kNnqByRqf6SCqqseIZkDpdwgFaHPhsdi9yufxsD4pGXpfOPmvCtpuUZiJ6x00qgVFZ
         p0gi5uY+xIBpsLirMnrhds1UrVOfEi52t5EKwmsqs0ARlqZTVjZf6Ru/hrTmSIIX71xP
         pzrs92W4dbxMkAvbDwJPFaQlOA/f3h2+JfnuNU2WIZr6AmDpAJrPgoJ1Jle3z3115R7b
         MYD1ISGi9iIjFtlpfWGDiRtKPVv9ijvaWR39hOm6ga+OGerRBNu+rm1dgHGOmsG2Q8T7
         sGZK44ErhaSWzpTlDKevnfREnG1i9c7u9z0vQ+01Diui99LnODZ65mFZuX5b2h6X9ulQ
         qtag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713530195; x=1714134995;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AJ2O6fzXkdIMQAVMScv0OWxTVLp0wpG13C0/RNc+3ls=;
        b=jyyMSUsKxpgLkBt8hqf3+/Q6yMDnsTrEJLluGp64ixg3m/p8+g2WuBl7HiaP54Gfx3
         tIaQenO23G5YR7JcQOJEDVIEL2oh9fAQRpp/nsG5CUtbQt2tLNdIFkvrkD75mOH3eIV3
         1xcglbcihXxy2N7LC6jdMKsf3aNpJZkCaoSJSB3ZoBy0M/No0mq01bveFOUY7h5/e3OV
         iLNfxtF3z7Nrd5pV9M5rROGQcB/ZNh4+uHop+pgewpt56Cz4MXo51qtXAP/ZU3UvbRkC
         S84JICI9Kue27vkV02N/6Zu2LEwS9oHiaEOCaN/f/zo4Z7cYnTY0iSvXfVEHkmdBb1MD
         TU0Q==
X-Forwarded-Encrypted: i=1; AJvYcCVkSVVnBgsfesDc145wbdZIt/2g4MrVj/8Eh6c/9F+vejLuj87uXSOdXCTNNR+5Uuv891ckTn4nRJ/W9lt6HrKACixTlmj8DUOFwQG5
X-Gm-Message-State: AOJu0YxOeb9sGwXRsqZytVqkA9rR7RGyJ+IJ+c2+LzwsFF8axH9OEai5
	EEb4vLejNCK+UTliwDQBgMOMiuNBzjBXnFcu2A5fKKaREiIVpIqc
X-Google-Smtp-Source: AGHT+IFxgn0ysmSSHGx6XdXzvTnX2ZwfJP200Gp3ut8JQa89cvJ04M5UYd4nVRbx+nvCju4zW1da/g==
X-Received: by 2002:a17:903:2290:b0:1e4:7bf1:521 with SMTP id b16-20020a170903229000b001e47bf10521mr8262391plh.19.1713530195012;
        Fri, 19 Apr 2024 05:36:35 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id kh5-20020a170903064500b001e47bf10536sm3240883plb.69.2024.04.19.05.36.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 05:36:34 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Fri, 19 Apr 2024 05:36:33 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
	allen.lkml@gmail.com, broonie@kernel.org,
	Phillip Pearson <philpearson@google.com>
Subject: Re: [PATCH 5.4 000/215] 5.4.274-rc1 review
Message-ID: <a5c09590-edfe-4fef-8edc-75a39b92446e@roeck-us.net>
References: <20240411095424.875421572@linuxfoundation.org>
 <787e0ac1-cb31-47d9-8200-3f6a3b4119dd@roeck-us.net>
 <c5d0c7f7-96a0-4806-b3b6-269d9189037d@roeck-us.net>
 <2024041949-strained-steadfast-13cf@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024041949-strained-steadfast-13cf@gregkh>

On Fri, Apr 19, 2024 at 12:41:02PM +0200, Greg Kroah-Hartman wrote:
> On Thu, Apr 18, 2024 at 12:38:59PM -0700, Guenter Roeck wrote:
> > On Thu, Apr 18, 2024 at 12:25:21PM -0700, Guenter Roeck wrote:
> > > On Thu, Apr 11, 2024 at 11:53:29AM +0200, Greg Kroah-Hartman wrote:
> > > > This is the start of the stable review cycle for the 5.4.274 release.
> > > > There are 215 patches in this series, all will be posted as a response
> > > > to this one.  If anyone has any issues with these being applied, please
> > > > let me know.
> > > > 
> > > > Responses should be made by Sat, 13 Apr 2024 09:53:55 +0000.
> > > > Anything received after that time might be too late.
> > > > 
> > > [ ... ]
> > > > 
> > > > Sean Christopherson <seanjc@google.com>
> > > >     KVM: Always flush async #PF workqueue when vCPU is being destroyed
> > > > 
> > > 
> > > This backport is bad. In kvm_setup_async_pf(), it removes a call to
> > > kvm_get_kvm(). However, it does not remove the call to kvm_put_kvm()
> > > in its error handler. Also see upstream commit 7863e346e108 ("KVM:
> > > async_pf: Cleanup kvm_setup_async_pf()") which explains that one of
> > > the error paths in kvm_setup_async_pf() which is not supposed to be
> > > observed can be observed after all.
> > > 
> > 
> > Reverting the above commit from v5.4.y fixes the problem. Alternatively,
> > applying commit 7863e346e108 on top of v5.4.274 fixes it as well.
> > 
> > I added Phillip Pearson to Cc:; he did all the testing and can provide
> > additional information if needed.
> 
> So which is recommended, revert or add the other commit?
> 
We decided to apply 7863e346e108.

https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/+/5465806

Guenter

