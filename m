Return-Path: <linux-kernel+bounces-131059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4234F898295
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 09:57:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8C9FB22623
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 07:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D254E5D73A;
	Thu,  4 Apr 2024 07:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mMKe+mtz"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA4345970
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 07:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712217421; cv=none; b=Zt2VKbfDUqm2u5ai7A2pdOLedXgODSn2X0j6iPeUvMdZSWWnKa9nk8QvzuB4HYiPOw23uFkGdeBg/BlpS2ldLbxVHlICtYFG88XSFGoivWvLEfjKMXuW4feEwdQvJiAzKkFQjvNXFuirML4H8xejmmk3JyE4DmTijFYRaug+hXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712217421; c=relaxed/simple;
	bh=10QNrCSrA4VuJN4sCZdigL3fgs1LMuQX/LQrpISoH78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C2yoj/KRW28nAJjTCsJa9Razpwkf9AoGL0W38dOyrzRlQ2fh2TRihmrwmp5qwTFeoGlRitq6P5UO3DMTK/Xy2Ic0yMH5YCRwvntW2UbG5ZUV1ZtaM1FG9xScbBlGNZcmmSPNMdcSKGGoDbMRDepC5HDmnLm28R/Xl5xG7d9P4mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mMKe+mtz; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4162b5ba333so1284665e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 00:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712217418; x=1712822218; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=odFAKmC43zCLxTG764+1o/hwl874kgnzDh7JyeKWm6g=;
        b=mMKe+mtzpNiodqhwF7625gIwNaYEOLcroacUP+mOEgt6TG+wzQiRL9/Bb5Fra/gSi3
         Ze8lMpT7QRVFyZOZ+ON8aXh0uO8Tt9Gy/4bhByD6ph86n7tVz6kNDR0h6Kr47zCJMmqW
         nL8uIno/7OqI+bAidGjQ8Y9EM4+447oa7rN3BdOsx14MajnjbgjZjvze04Cl8CnGbQNs
         n0o3WOrl7ItT2YWdgMV1PXQuxJAiRc/v5Bl5hxJRy0MbvEJ0sBoK3f5CfOHa5j5TtAjX
         XHwVRUHpjvuY9vuWn8rjY3WRI3V2rVJaD/WT11Y9GL8UdzHvOZuGBCOrDiU71GdpVNS7
         GHYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712217418; x=1712822218;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=odFAKmC43zCLxTG764+1o/hwl874kgnzDh7JyeKWm6g=;
        b=JIO9C/dAgc+pi3rTVomZDsf1ddN0tKAUVvYXFErwbYYj4RVVMMou3d57NEyI8U7ICm
         R+h5DkgxRX3yW7ELTa2fRRWGyDkLgVAejWebMx4roDzzulNCnVvtQqBwa0UyuH3BjL4d
         H9Vpzohazrx1OFaAw2FW5wPUxDKWADWjsYFpHRq3H7JB/lIXzxKN9R8PaNWo5nk97qgd
         KmjvO1Q/71UyIa9RhmyKpBUDGRxXVrh+CkI5GVLz60JGKXWNQEJKibPlHRUE7OBWFQWn
         f+sSB58dakDLJBkuX3DAcoay7Ye36F1LTC+Icry1p3Vz/7jFWzXZ0f1nINVFylQT3MuT
         md6g==
X-Forwarded-Encrypted: i=1; AJvYcCXN3eXTtidHzuYWUtOhR1t38sCkbdpDkJgcTxUlw9NvtuppnpZlaqiIzPALdALWOvHDx2nIlSfBw4T/lNiMzo6wu8VxAPfwwYvYaFFm
X-Gm-Message-State: AOJu0YzEO+kdDhkDBXJJALDunFzGBUPKDdF6SC2H1Q+d9ZiNtGXMW9XZ
	S0jIK4VlFx5UsD/Qw1QFsGtu8N3BYKNOc/dH+rpvT1ON3eLVAoIM
X-Google-Smtp-Source: AGHT+IFYywBlxhmXe9/Rke8hr0lTcgscNSCYmG8tkiO7FGD+Y7A/+7MGul0r2aFb1GIFIsviVpXzWA==
X-Received: by 2002:a05:600c:22c8:b0:414:e0af:9b9f with SMTP id 8-20020a05600c22c800b00414e0af9b9fmr1388695wmg.30.1712217417484;
        Thu, 04 Apr 2024 00:56:57 -0700 (PDT)
Received: from gmail.com (84-236-113-97.pool.digikabel.hu. [84.236.113.97])
        by smtp.gmail.com with ESMTPSA id u12-20020a05600c19cc00b0041469869d11sm1694549wmq.47.2024.04.04.00.56.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 00:56:56 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Thu, 4 Apr 2024 09:56:54 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Brian Gerst <brgerst@gmail.com>
Cc: Dave Hansen <dave.hansen@intel.com>, Javier Pello <devel@otheo.eu>,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 1/1] x86/mm/pae: Align up pteval_t, pmdval_t and pudval_t
 to avoid split locks
Message-ID: <Zg5dRkSncIeHsP0H@gmail.com>
References: <20240401185451.6897208962d3fc47a12ffb5a@otheo.eu>
 <20240401185712.a80deeb2fddeded0ad42cc04@otheo.eu>
 <8ee463af-fdbf-4514-bb6e-bf2fd61fbc06@intel.com>
 <20240402192314.a9b4e05637444314f47557e4@otheo.eu>
 <d7e89d23-b692-4e70-baae-5df5b3984620@intel.com>
 <Zg0L/OfuQtVgFSsG@gmail.com>
 <CAMzpN2iK0+okEKnX_EgfmdLSg9Gze_BVO4fEG3TBuzwD-yj8bA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMzpN2iK0+okEKnX_EgfmdLSg9Gze_BVO4fEG3TBuzwD-yj8bA@mail.gmail.com>


* Brian Gerst <brgerst@gmail.com> wrote:

> > > It's not a technical reason.  It's a practical one: I don't want 
> > > to spend time reviewing the fixes and dealing with the fallout 
> > > and regressions that the fixes might cause.
> >
> > Yeah, so it's an indirect technical argument: fixes *with 
> > tradeoffs* like this one have a future maintenance & robustness 
> > cost. Fixes without tradeoffs are fine of course.
> 
> What tradeoffs are there with this patch?  This would not affect the 
> page tables, since those are already properly aligned.  Forcing 
> alignment of stack variables is only a problem if it tickles a 
> compiler bug.

It creates extra constraints on stack layout that wasn't there before, 
so it can only be an invariant if the compiler can reorder variables, 
or make the stack layout worse (introducing more holes).

Thanks,

	Ingo

