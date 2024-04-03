Return-Path: <linux-kernel+bounces-129229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 666B889675A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 09:58:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 892251C25EED
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 07:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD5476BFBF;
	Wed,  3 Apr 2024 07:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Aq5/oDpX"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46FD286A6
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 07:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712131075; cv=none; b=sigdTeJVLB4RCrJDsjzwX2M7MkglbNZmBJ0McGQYaafCTH8uchK8bF3vsd8HbLxzPnK+8ZvzJXY5cmyha8lV3BUaSrQ9ognIBER8Jk74dOW/fhZhWsryKhA5A98gWv9Qdv3qOXQeayQ0WLwBRLlr4txASQIsLX1xrGjT0wwkYiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712131075; c=relaxed/simple;
	bh=E8ss3MKIHOBgstVicyKl00CKbmaJrfx9migXcfA+hn4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G11h2uw6j+ZsZwMchqXmYeZef1Zu5Cx55OOYInOlGPBWoNyR0zM7lXRe21rSWNiy4NRalUvGMTNnY3C2vb3s9usdwbeBkFm6OPMN4ORXTbRI4A/ycJTRhbmohfU1Q2jTeOVZSNOqFAQfI/umCsS5H4frEIm+hHHhztnb1SKza6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Aq5/oDpX; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-513e6777af4so9979315e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 00:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712131071; x=1712735871; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FMWoeyQa1124JpdxiXhj601YtR1/Z6dTGW+njbp1Gjg=;
        b=Aq5/oDpXQb1YvMM0DaGozh/QgZbhskl0OzunqBM82t5Ta77lyR0YW/j0abKw1ci94h
         x80JITPPCWLmCoVdv1GDwI2hCue8g3Kr0MmTk+2z/ILFsMAdMrXRaSGrplxmmges4H5E
         ow9bDWzJblgLsPGT4mztmOcPmF9/fWnEtbxeeZG5GDNqRSEEFcVEgeLC38yGg6UScu3B
         EU7KhTlPuJzg4Oh/fzAJ5scG6NCYNQmyWHVzJC+9hgVUBiPGmO8aiVmpv27XvnVvBDiA
         lgv7Yi0VxEqvmdjomgAbSe5RC5tQ478v8E8VeiWL0wqbor/pbywypzGoaj9ArfBg3S6u
         p4RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712131071; x=1712735871;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FMWoeyQa1124JpdxiXhj601YtR1/Z6dTGW+njbp1Gjg=;
        b=nw74pqHxgjkvCrL8K1E9PBDNZiPMFA2aWNDMUiZywCKVGjsapi27tmf5ufYzye7LHW
         1yKmcLcEhn29RRLZOMfG00xZ8PwVBDfXrNKP8HbQCkkxzaSQh5BrBmwnf6rLE3j39/4u
         S6JKBaFZoV3c8HUAE62ARPGsJRtqo+/uVh7801UTqmDHwb/XqMoSmhJqEEzNL4G3Zjd6
         u5C1mgn5EEqN0RXtuIn4xVBHU/9N0bDLjJ5KBXBgIxxOkQlxKoSIX+F/Iy8wSwrTh6zy
         +I5zoBeERzuD0zapy0JYkfIj29nEZbqs3mJw3H7RBNnrKVEBp5gb/bJcD2exbsx8GN9V
         /rbA==
X-Forwarded-Encrypted: i=1; AJvYcCX1vnSFvSD1NOvtnjK8cMREcXftUXMZ3rby2eCpBGwAReKiBTLkVnqzje+ATiMlgA4Ikdw27eiatSjYtOWq6Zd43OCycJpf1zzhBcdK
X-Gm-Message-State: AOJu0YxCurena3nTX0CPMFAIxBen2Lw87nXyEjw3CTitkYyKTXPw0ClC
	ClrhNhIYxLAQ/AyDVW1uVvS5fcp9xkqcOgmuzaMVVaCwN7nXc112
X-Google-Smtp-Source: AGHT+IEcB0ZJBcBL8NLSG5dsFDeY+C4mhzUH0tKIh0ehClYiQpoQnF0Arz/hVaqMuU45UpvMilUJMw==
X-Received: by 2002:a2e:8e8f:0:b0:2d8:3ccc:60e8 with SMTP id z15-20020a2e8e8f000000b002d83ccc60e8mr987700ljk.48.1712131070557;
        Wed, 03 Apr 2024 00:57:50 -0700 (PDT)
Received: from gmail.com (84-236-113-97.pool.digikabel.hu. [84.236.113.97])
        by smtp.gmail.com with ESMTPSA id f6-20020a170906ef0600b00a46af0fbf5dsm7394647ejs.103.2024.04.03.00.57.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 00:57:50 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Wed, 3 Apr 2024 09:57:48 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Javier Pello <devel@otheo.eu>, linux-kernel@vger.kernel.org,
	x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 1/1] x86/mm/pae: Align up pteval_t, pmdval_t and pudval_t
 to avoid split locks
Message-ID: <Zg0L/OfuQtVgFSsG@gmail.com>
References: <20240401185451.6897208962d3fc47a12ffb5a@otheo.eu>
 <20240401185712.a80deeb2fddeded0ad42cc04@otheo.eu>
 <8ee463af-fdbf-4514-bb6e-bf2fd61fbc06@intel.com>
 <20240402192314.a9b4e05637444314f47557e4@otheo.eu>
 <d7e89d23-b692-4e70-baae-5df5b3984620@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7e89d23-b692-4e70-baae-5df5b3984620@intel.com>


* Dave Hansen <dave.hansen@intel.com> wrote:

> On 4/2/24 10:23, Javier Pello wrote:
> > On Mon, 1 Apr 2024 10:56:14 -0700 Dave Hansen wrote:
> >> First of all, how is it that you're running a PAE kernel on new,
> >> 64-bit hardware?  That's rather odd.
> > 
> > I got this motherboard and cpu fairly recently to replace old
> > hardware, and I just plugged my old hard disk and went along with
> > it, because I did not feel like bootstrapping a 64-bit system.
> 
> Fair enough.  I can totally understand wanting the convenience.  But
> you're leaving _so_ much performance on the floor that split locks are
> the least of your problems.
> 
> >> The case that you're hitting is actually an on-stack pmd_t.  The
> >> fun part is that it's not shared and doesn't even _need_ atomics.
> >> I think it's just using pmd_populate() because it's convenient.
> > 
> > I see. So just annotating the variable on the stack with
> > __aligned(8) should do it? But the code is under mm/, so it should
> > be arch-agnostic, right? What would the correct fix be, then? I take
> > from your message that using atomics through pmd_populate() here is
> > not needed, but what accessors should be used instead? I am not
> > familiar at all with this part of the kernel.
> 
> I don't think there's a better accessor.
> 
> >> I'd honestly much rather just disable split lock support in 32-bit
> >> builds than mess with this stuff.  You really shouldn't be running
> >> 32-but kernels on this hardware.
> > 
> > Why? Is it unsupported?
> 
> Yes, it's effectively unsupported.  We're not adding new hardware 
> features to 32-bit.  The fact that split lock detection got enabled 
> was an accident.

We do accept well-tested fixes and minor enablement patches though, 
within reason - but indeed this page table entry alignment quirk added 
for the sake of a split-lock debugging false positive doesn't seem to 
be worth it.

> It's not a technical reason.  It's a practical one: I don't want to 
> spend time reviewing the fixes and dealing with the fallout and 
> regressions that the fixes might cause.

Yeah, so it's an indirect technical argument: fixes *with tradeoffs* 
like this one have a future maintenance & robustness cost. Fixes 
without tradeoffs are fine of course.

Thanks,

	Ingo

