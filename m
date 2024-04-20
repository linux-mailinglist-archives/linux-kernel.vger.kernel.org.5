Return-Path: <linux-kernel+bounces-152394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D1BD8ABDCA
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 01:49:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83C1E1C20B33
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 23:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A64384CE19;
	Sat, 20 Apr 2024 23:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="w+bjmnBw"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90F21DA4E
	for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2024 23:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713656951; cv=none; b=bhXshMxJTD8HzZeBmnWktH352Ozirte6n4w8+/ZckutNcTrcM+NCErigXjkVDPEAWnjXA5J1AnKSM3J1xhWAEqI8BYocfO39EladCQ+j3wo6jMiyUW/Gm7xpOZOwNppgVez1/Vfowbx4xviUCA6NcCaGhhXYF2T4OpOvHGX8/mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713656951; c=relaxed/simple;
	bh=PyaPYZf6623DB/27XqYxlERaHE9mu7nYrpu/WoT80js=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o4M2niZlavSaQU+VOTDpzTbADAjm7WIWWkHg24FZD1dGevpc/dZa20rR3ZU06nQIIFWB1pGNTTcJn21+BJATH3eQfi/8Shye+lbFOKXpzKgszFQtyTsuZDw2MnI1y2Az5Ie8mgwqL/7yx/5A66LanAvPsVb1SgSZ+V0x0OGuasg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=w+bjmnBw; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6f16b8625fbso830559b3a.1
        for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2024 16:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713656949; x=1714261749; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=C/b2A47DmXz7lQZfnSKxkSzxCtMQVov/QukuhmmaVQU=;
        b=w+bjmnBw4waMwR1u3ehaz6fboS+b8G32rNWL0x4/oehZRueL4ECFr4zOxlGY7KCHc+
         QNxWejnmvO2Q2HNXKM0aCJXeHaOkFxam9/1pjq1+KKff8IjZMtIrpCwmmn++VhaTvkG2
         H9dfI9E2Nz3qLCImRc8pkFsoz2YmE/iv7hNmj9PsR3VwUNDJpEkHFPIPS/4X7KEKlIfP
         k7a1OtL6mYYOnoxj8c1q2BVC1/r5PU3QrPi0CDqrF0w+gYs45cH36OiHgcvloUYBA3+H
         jOtXA3x+imlI6acH9gT0pDNvx5iVuhemV1X/Qob71gBb6Ejef4SbPAJ8YWVGWtpmb9Ot
         OvrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713656949; x=1714261749;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C/b2A47DmXz7lQZfnSKxkSzxCtMQVov/QukuhmmaVQU=;
        b=B+tAm8jTt1PEm3seo0t8HTr9ziui02arxCz0iHMbCjJ+8eSiobuow39orC2FVzYDvh
         FLRbzDUBGMCKcjxMDvCNYiXgkzJ56NkQy+6oi3tgMHCqKziT8NNsPYssFMMkiyLIR7vV
         PFnqWP/reoqjtKKvD0rgfMcmjc8e8R8W2kycYFod/ZRNmjgrJlT2XjD1hyzVY/0jC05Z
         7rMy/fYpVXGtOYDcph/OdCHDf2F13WW5aQ8HKY8XLUu/KZWol2VCoKbuORcvIwCeQpdn
         uFdhGTh3eyDEONhM05XR9Z13Jr2VVfO8oXuYzYPVEG2kmXGlc2JTwVXs4gPm7dspIvrV
         O09A==
X-Forwarded-Encrypted: i=1; AJvYcCVrqfieEVHyCEq1hdDIkuDD7LNiQFsV/bRaQVlVJHsJc7muF3SzRSdyjI5V3+AlhoPTqrf+C7aZI9N7p70qEer8HGbqz2tsG7peaiLQ
X-Gm-Message-State: AOJu0YxRDHcq8pKjeuMEkFXHl+PjkTqMUkDtpGDKnhWTk0BGBvM9UUqO
	5EGqBtyouF02H1vGZdEraIjtG+Ma4hdZ03/hPsVLwIk5uFlMdUVyIScwgitXEw==
X-Google-Smtp-Source: AGHT+IE+3UxUIIohDNgk4hf44ojoKMmEf6yYiLrR5aBvJaogVvGWUFJrFDOOIUN/v5QcRV7c6CuFmA==
X-Received: by 2002:a05:6a00:939d:b0:6ea:89e5:99a3 with SMTP id ka29-20020a056a00939d00b006ea89e599a3mr7670360pfb.8.1713656948666;
        Sat, 20 Apr 2024 16:49:08 -0700 (PDT)
Received: from google.com (139.69.82.34.bc.googleusercontent.com. [34.82.69.139])
        by smtp.gmail.com with ESMTPSA id h17-20020aa79f51000000b006e71aec34a8sm5336676pfr.167.2024.04.20.16.49.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Apr 2024 16:49:08 -0700 (PDT)
Date: Sat, 20 Apr 2024 23:49:04 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: arve@android.com, brauner@kernel.org, gregkh@linuxfoundation.org,
	joel@joelfernandes.org, kernel-team@android.com,
	linux-kernel@vger.kernel.org, maco@android.com, surenb@google.com,
	tkjos@android.com
Subject: Re: [PATCH 2/4] binder: migrate ioctl to new PF_SPAM_DETECTION
Message-ID: <ZiRUcEtIypy1n4Xj@google.com>
References: <20240417191418.1341988-3-cmllamas@google.com>
 <20240418081222.3871629-1-aliceryhl@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418081222.3871629-1-aliceryhl@google.com>

On Thu, Apr 18, 2024 at 08:12:22AM +0000, Alice Ryhl wrote:
> Carlos Llamas <cmllamas@google.com> writes:
> > @@ -5553,7 +5553,8 @@ static long binder_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
> >  			goto err;
> >  		}
> >  		binder_inner_proc_lock(proc);
> > -		proc->oneway_spam_detection_enabled = (bool)enable;
> > +		proc->flags &= ~PF_SPAM_DETECTION;
> > +		proc->flags |= enable & PF_SPAM_DETECTION;
> 
> The bitwise and in `enable & PF_SPAM_DETECTION` only works because
> PF_SPAM_DETECTION happens to be equal to 1. This seems pretty fragile to
> me. Would you be willing to do this instead?
> 
> proc->flags &= ~PF_SPAM_DETECTION;
> if (enable)
> 	proc->flags |= PF_SPAM_DETECTION;
> 

I don't think it is fragile since PF_SPAM_DETECTION is fixed. However,
I agree the code is missing context about the flag being bit 0 and your
version addresses this problem. So I'll take it for v2, thanks! 

> 
> Carlos Llamas <cmllamas@google.com> writes:
> > -			if (proc->oneway_spam_detection_enabled &&
> > -				   w->type == BINDER_WORK_TRANSACTION_ONEWAY_SPAM_SUSPECT)
> > +			if (proc->flags & PF_SPAM_DETECTION &&
> > +			    w->type == BINDER_WORK_TRANSACTION_ONEWAY_SPAM_SUSPECT)
> 
> Maybe I am just not sufficiently familiar with C, but I had to look up
> the operator precedence rules for this one. Could we add parenthesises
> around `proc->flags & PF_SPAM_DETECTION`? Or even define a macro for it?

I think this is fairly common in C but I can definitly add the extra
paranthesis if it helps.

--
Carlos Llamas

