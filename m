Return-Path: <linux-kernel+bounces-111266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B8898869E2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 11:03:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01F161F24976
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 10:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ADB239867;
	Fri, 22 Mar 2024 10:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N8cWfxpB"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8835D24A0D;
	Fri, 22 Mar 2024 10:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711101787; cv=none; b=ofGe/io8sZOAoboVChMZqrJQw8CJp1KxxhClBpDL/VQkPR4kUjOgGxPfR8WdcjKPGHhAZ0B5lTZtbUT4uMW3I+6g8NEZwbKWWwp7qt3JgvsDLr/8fB7AQSiiMP2prxUDYKRcXyR2lmTyowaxq7gS7ZbHwOSQYAI1jTzSoc6WNq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711101787; c=relaxed/simple;
	bh=SrReY5iepclyQRLfL9xUjmut2TW0t7HyjKa/FmYIh+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hTifuf3QqP2qZvEpPBrmQyeCqXeb0uZdttF7XLC/vCHx1YjktJwD54ZnFsBBh5PqnsGaVsH85vsKJYv86i0fmC9rissejFt3xDSGkqrNvJ/kAfmecZaHvuz0fkJ2dLzW7VQIaItq1WuhsjCsyQlc7QKXoBW0YVllLnICJNgCYg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N8cWfxpB; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-33fd8a2a407so1044591f8f.2;
        Fri, 22 Mar 2024 03:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711101784; x=1711706584; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DcwNtDxsn4iutaQGAJ+vxh8SXtvPdgtKbGJ3VpVPuo0=;
        b=N8cWfxpBBJIVXQLzqg2AnAty+FrS4MehDcwyFJOb9Tn8Ng8jGCNMwrx9HP80YUOqps
         5CcQ1ZxKztyyWa0e8keoffiODE04J0kqvccLGdfBrRQ1p1WElQN4xegyMOYgVG8L5slb
         D4HaIUFW/hHv5r4JJvzyFQBFBRFniJjY2YwZefTvaPRTtMD0zfBn8PDc2d4oYelIr/aG
         gqQwkf6j3+/mADjqqVDKZYNQFPUyJj1phYI1+WirzU17lD6eLBVRTNWXv+jO0KkfL+rV
         orlETYPmYP79zIXsBUTTW4Yd4gbSz9KmJaSUEBPxmoGkRfmpIk/DM2pdsz3tmwjRwiH+
         CEAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711101784; x=1711706584;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DcwNtDxsn4iutaQGAJ+vxh8SXtvPdgtKbGJ3VpVPuo0=;
        b=Qz61au3Gd06X+hZpvp8VNRkX3QA2mwZbwZX0Rbjn8/j/Lf18OuChd0lRqoalecMcw9
         vONM291N7v2Dd8VEIAhPu9X6KniR2Qrqx0a5MPBCZXqsgvpFOUlBE31AgOwgpKRz6332
         R8/W+OZwRVSufuiG9fyC3arJ+n5iV65/sPuCTQ0nZTqK1iGfvZd24G2kolpavkSn87BN
         2IliZW7Jh1PcONG44ypWIp1p6b4DpnbYtZUz1uSrufjO45gb5L5kon2II39Cx+W9P7E7
         dA6NVfWj/+sqxpwVOYlH4g65ERwcnpryJKcJ/roiJnglOXeaeYcVJBOGH/4PwIjAnIua
         QSlA==
X-Forwarded-Encrypted: i=1; AJvYcCXfqt8a2bM04L/hU0cKZG8wm90XRbKMQPTv4jHbc7vukVTY1Ld2sd4qn2q+iBIJVl5SsM23d3giynmiyS6LIhqhoaTYiL7vVlIYPhfX+eHXR9yUWTFN09+L46rtq6J68YYWe+I6Cdtbfi4r4zIAXwCwTuHgrSpNxPulnc3XGBA=
X-Gm-Message-State: AOJu0YwId3HKmPw5ilPc4ZdovLaIGYn7tHhNnmxnr2P13Y5j1+iZu2YD
	NCrVuVj08l52jztqb+NyghocXVFYfgFL8oHR+rgfT4Kk6x9bxrkE
X-Google-Smtp-Source: AGHT+IE2ICqUa/rZAmBl7E/hfsVmtG+zHnF5G3wg6d4I4m2ox/W1hTACC7I2VKaC/5R6C4CsFBXSlg==
X-Received: by 2002:a05:6000:e92:b0:33e:c7e3:b1bb with SMTP id dz18-20020a0560000e9200b0033ec7e3b1bbmr1139362wrb.16.1711101783349;
        Fri, 22 Mar 2024 03:03:03 -0700 (PDT)
Received: from gmail.com (1F2EF04C.nat.pool.telekom.hu. [31.46.240.76])
        by smtp.gmail.com with ESMTPSA id w17-20020adfcd11000000b0033e786abf84sm1695832wrm.54.2024.03.22.03.03.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 03:03:02 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Fri, 22 Mar 2024 11:03:00 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Anton Altaparmakov <anton@tuxera.com>
Cc: Dave Hansen <dave.hansen@intel.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@ucw.cz>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>, Chen Yu <yu.c.chen@intel.com>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Linux Memory Management <linux-mm@kvack.org>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] x86/pm: Fix false positive kmemleak report in
 msr_build_context().
Message-ID: <Zf1XVPicqdJ3VBcl@gmail.com>
References: <20240314142656.17699-1-anton@tuxera.com>
 <70261e2a-b87e-462e-964e-95a51ecde978@intel.com>
 <653BCAC0-8A79-400F-B496-23A2FA169786@tuxera.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <653BCAC0-8A79-400F-B496-23A2FA169786@tuxera.com>


* Anton Altaparmakov <anton@tuxera.com> wrote:

> Hi Dave,
> 
> > On 14 Mar 2024, at 15:05, Dave Hansen <dave.hansen@intel.com> wrote:
> > 
> > On 3/14/24 07:26, Anton Altaparmakov wrote:
> >> /* image of the saved processor state */
> >> struct saved_context {
> >> - /*
> >> - * On x86_32, all segment registers except gs are saved at kernel
> >> - * entry in pt_regs.
> >> - */
> >> - u16 gs;
> >> unsigned long cr0, cr2, cr3, cr4;
> >> u64 misc_enable;
> >> struct saved_msrs saved_msrs;
> >> @@ -27,6 +22,11 @@ struct saved_context {
> >> unsigned long tr;
> >> unsigned long safety;
> >> unsigned long return_address;
> >> + /*
> >> + * On x86_32, all segment registers except gs are saved at kernel
> >> + * entry in pt_regs.
> >> + */
> >> + u16 gs;
> >> bool misc_enable_saved;
> >> } __attribute__((packed));
> > 
> > Isn't this just kinda poking at the symptoms?  This seems to be
> > basically the exact same bug as b0b592cf08, just with a different source
> > of unaligned structure members.
> 
> Yes, that is exactly the same bug.  That's how we figured out the solution in fact - it is totally the same problem with another struct member...
> 
> > There's nothing to keep folks from reintroducing these kinds of issues
> > and evidently no way to detect when they happen without lengthy reproducers.
> 
> Correct.  But short of adding asserts / documentation that pointers must be aligned or kmemleak won't work or fixing kmemleak (which I expect is not tractical as it would become a lot slower if nothing else) not sure what else can be done.
> 
> Given I cannot see any alternative to fixing the kmemleak failures I think it is worth applying this fix.
> 
> Unless you have better ideas how to fix this issue?
> 
> What I can say is that we run a lot of tests with our CI and applying 
> this fix we do not see any kmemleak issues any more whilst without it we 
> see hundreds of the above - from a single, simple test run consisting of 
> 416 individual test cases on kernel 5.10 x86 with kmemleak enabled we got 
> 20 failures due to this which is quite a lot.  With this fix applied we 
> get zero kmemleak related failures.

I turned this tidbit into the following paragraph in the commit:

    Testing:
    
    We run a lot of tests with our CI, and after applying this fix we do not
    see any kmemleak issues any more whilst without it we see hundreds of
    the above report. From a single, simple test run consisting of 416 individual test
    cases on kernel 5.10 x86 with kmemleak enabled we got 20 failures due to this,
    which is quite a lot. With this fix applied we get zero kmemleak related failures.

Describing the impact of a fix in a changelog is always helpful.

Thanks,

	Ingo

