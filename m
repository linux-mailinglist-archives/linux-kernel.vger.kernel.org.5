Return-Path: <linux-kernel+bounces-107553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A52AF87FE09
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 14:05:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0122AB20C03
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 13:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBCEA40BF0;
	Tue, 19 Mar 2024 13:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O4nqZynV"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B363FB89;
	Tue, 19 Mar 2024 13:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710853538; cv=none; b=JDAWVjyiMtyJ5LxlWgjcJADGCFVQU8bXbDZLIHswslkE5Nn1vCWnZCKSSkPS4h6/f/TvAMF4CVjXxFjJ8lUlu5PEw9ZCoUM4jgDFO5bFvHx40TXbW5YcnbLTyB8Az5KqY2A+rlGJqL0X0QlT+xnAiNDA4Woz7KEHkOHYPhVptjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710853538; c=relaxed/simple;
	bh=TXD8ENN6EsOKfpXCrEzmdZ3YAUwaICWDB++s3TcnFpY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pS6A+fHYtgWHPUi0wyybjxkPKdXh64oe7z23oUGEOfH3PrwziOYZLQc1OX8ETX9RK8B1Um6+QFtCs1Rb+dQGOD4A1crlVu1IXUC7wQjMCtLZQzHFCOlQpLPH2wgyXakQj3oZyeq2aSHhJMJKEzf2pce1pH8hzBWBHkeTWe9Tv5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O4nqZynV; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5658082d2c4so6976799a12.1;
        Tue, 19 Mar 2024 06:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710853535; x=1711458335; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=buHRSmThstc3lB/h829bc4UnKHIltSZp3sHBDY/iNLs=;
        b=O4nqZynVxbgudOzN2Qf9qGalAzdWj8tbekFhHc6g0FxRGVOkFY7PXx0DbQThh8G5Ch
         4kCdcjTkwtnFsSM2PiJpKVEU9bOmagIdDtM6DNpSgHeSrcpzA65EZdaHivPNqkb6Euzg
         ww70rZDMRIeHjTUMUc6KAlBz1iim4vPhTKJ76A0UmGvjOI7J2pSKFLl4OPIl9bAmcfgt
         CcTe+NS0Ku86mtpq2thfS4iCp78EaHOh7gYER8YeGOi7ijBs8IbUkvGvzBEUeLpv0zUE
         keANB0LLI3ds2vtDdRPeqDnQedSBLGdaOv+igwymre5AzrBbpyGe2AtAVogPAqfMistg
         5sbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710853535; x=1711458335;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=buHRSmThstc3lB/h829bc4UnKHIltSZp3sHBDY/iNLs=;
        b=B5sVtCIRlN6FrJj8hCkSpUHt7hr+SNon7lRy5l0/UTtkye8dp9I3qscB/VYqCEd/Gv
         vTvOSwzC1gWn3KEzSOxkW1c69MlaK513CI/F5JCHAxa/aM65cXfLa/uRIu6jbtGdnvXQ
         afyDaeRj4Tx+2gfz4g/gdflHOwtxNu9ssdkojrG4bAG4+kWqZLAa0cJRbGjWx986IHRQ
         r7fmmgs1nr+7vbkHI0sXT3+077Hr5MVVB6DclCDBlah3P1ZiCA3moTTvh8n4m8eVOIql
         3UvjSR9XvvePgofhCzHhlCvhbxdRUBnzwJxFaoCnO5IfLbZDjEWcdf9bAvg8wpQOo1gF
         8zAA==
X-Forwarded-Encrypted: i=1; AJvYcCXbfwuZVBAsNyxjeLw9xNUqb17IwuaIYYDjXUEz1HnE/0iicVvAfQuOKVTJGu7S8bCP5cG/kQJdXM1mEdzLC7k9pBAAEJlq393cDugspDy1lJRiFzbyJIMp1JAoI0UcD9eIDIfqtQ9OsFPBbjWiIAg=
X-Gm-Message-State: AOJu0YyXW3NnBFZ53d4p/ONm2Bk+3Pml+s4zmnY73rfMdaM2nzBcpY+G
	nEMPIn/KNkkNrDWiBFYiYXOoHe05NMlVNhd3CfyP+ex/qfvwa/bNiGjnSGNQpTI=
X-Google-Smtp-Source: AGHT+IH87ob9aKhTfYC+e4tVKQHPd3tZDG/2GDLUXzxZrcLFzVPPWGy2p4OWw/GBDuvRqQNyXBX3FA==
X-Received: by 2002:a05:6402:1586:b0:567:de59:e93e with SMTP id ij6-20020a056402158600b00567de59e93emr9129004edb.25.1710853534465;
        Tue, 19 Mar 2024 06:05:34 -0700 (PDT)
Received: from gmail.com (1F2EF04C.nat.pool.telekom.hu. [31.46.240.76])
        by smtp.gmail.com with ESMTPSA id v17-20020a056402175100b005651ae4ac91sm5718075edx.41.2024.03.19.06.05.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 06:05:33 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Tue, 19 Mar 2024 14:05:31 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: Sandipan Das <sandipan.das@amd.com>, linux-kernel@vger.kernel.org,
	linux-tip-commits@vger.kernel.org, x86@kernel.org
Subject: Re: [tip: perf/urgent] x86/cpufeatures: Add dedicated feature word
 for CPUID leaf 0x80000022[EAX]
Message-ID: <ZfmNmzuCDaTJO3jC@gmail.com>
References: <171084456107.10875.4104379273551108641.tip-bot2@tip-bot2>
 <20240319130054.GCZfmMhp-7Qa0eDaTC@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240319130054.GCZfmMhp-7Qa0eDaTC@fat_crate.local>


* Borislav Petkov <bp@alien8.de> wrote:

> On Tue, Mar 19, 2024 at 10:36:01AM -0000, tip-bot2 for Sandipan Das wrote:
> > The following commit has been merged into the perf/urgent branch of tip:
> > 
> > Commit-ID:     f0a22ea644717fa21698a32d342fcd307e53a935
> > Gitweb:        https://git.kernel.org/tip/f0a22ea644717fa21698a32d342fcd307e53a935
> > Author:        Sandipan Das <sandipan.das@amd.com>
> > AuthorDate:    Tue, 19 Mar 2024 13:48:16 +05:30
> > Committer:     Ingo Molnar <mingo@kernel.org>
> > CommitterDate: Tue, 19 Mar 2024 11:23:47 +01:00
> > 
> > x86/cpufeatures: Add dedicated feature word for CPUID leaf 0x80000022[EAX]
> > 
> > Move the existing scattered performance monitoring related feature bits
> > from CPUID leaf 0x80000022[EAX] into a dedicated word since additional
> > bits will be defined from the same leaf in the future. This includes
> > X86_FEATURE_PERFMON_V2 and X86_FEATURE_AMD_LBR_V2.
> 
> That CPUID leaf has a whopping three bits defined and the rest is
> reserved. You should do a dedicated leaf when we use at least 50% of the
> bits in the leaf. But not like this.
> 
> Please do simply another synthetic leaf and put your bits there.

Yeah, that was my original suggestion too, so fully agreed - I got 
distracted by the cleanup factor, but it's not worth spreading out the 
cpuinfo.x86_capability[] bits unnecessarily.

Thanks,

	Ingo

