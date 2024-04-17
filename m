Return-Path: <linux-kernel+bounces-149046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C62B8A8AF8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 20:23:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5077B232B7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 18:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C887B173352;
	Wed, 17 Apr 2024 18:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i7dM6E+V"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31DC172BCD
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 18:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713378212; cv=none; b=Y2vEB8J1OgFEW8Q2PFCUjb1scx1xVucj7Tyn+G2vBB3ih7kNFV+WQd7ako3Z7yvnIJvdUGArL9HkIxEBIN9qciH93ZALmaaR3ex29eQ9tkhp1TW/NNMdkjO/LFNGr9bWB2D7bV2oI/d67Irvo32MV+R0x4T4Ojq2UsAyAnT56/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713378212; c=relaxed/simple;
	bh=kDwP1L3G7M8aPLsq0HVHogew29sCKSMB6PDjUw6qe0A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Br9ZKORkJ9ESf3aZllFY9b8qfgKsIgDq7vQsPTsrDP84XoXn98ehQra+VpK3B1qb/QvtV2mvKgORP70iQERt0CsRwC0bf0oB1zIXw0ZKfVlX/hNYp5wmwu1ObVPb7Kvq75OxBqh/XmQxGR31dRGoreUJ0kY43fb86JL4NhjXypc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i7dM6E+V; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dcc4563611cso67747276.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 11:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713378209; x=1713983009; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z1CFy/ZKEiF76Qb4zghHgNfCwxX8XEayNfgQQljHQcw=;
        b=i7dM6E+Vu1h5oWOHuZtDRiak9gzClD9E63ZTBumJGztd8JSotYEeEZArVB1O6LMPqK
         HOhWfpRAdiVM7Y4mE75tKKKjo3B0VPjnDODKtBvgHQnjcry2pFell2+OKuDL6MkQoqLu
         YR0lcQDgOBh7XM7yH5dypvwW35ZEy9JvCS76P8YngEBzxUCH37d9N7GFPlqtSjX1wtzM
         F385JTBuGb8IcpBwejlTkTB0BStdmk8QPR0H9B5SbF38QplMC09hRH+0KRY8at/WX9gw
         KDE5IKJvDHmiMk0y2zCWeD/VxUy7YCXuUQ7MOBKr8jD6kBwpmMZG73jJvaB41V0EmL5j
         Q7+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713378209; x=1713983009;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z1CFy/ZKEiF76Qb4zghHgNfCwxX8XEayNfgQQljHQcw=;
        b=F3+8Y72fUlU9+UNqDdLWDfPIQpi/lkrDrCPBTN2wEqY2L6QamOiwddGh4w/B5fNZv9
         FyH62HJkBeL4kjDAp1QmehSwZum7Np+0MF9ocG9mmUxJKZchAlujtvjMs0ckxd0osyZU
         zzJcmkXJ1p8VmBZIPSZ7p4AA1u+uWKmCmxO7mwjcN5gE0M7T3ddJvDhDxlV3okLNs5DO
         4BnDZcxZW0TT6WE1B5AR3Hf7upkSZ+VFLEcOGqBbuMOdvtjr0E69YUTW/mqPLKdZhnGJ
         opSv8DfivzHsGOUp8hGHW/z7fjWH5hcvjNlUbd0qNa0KAjidlGoJoNFVo7LVDeDt9FJc
         HJmw==
X-Forwarded-Encrypted: i=1; AJvYcCUqmVbiXlUa2SxxakmLvv19l7zIeVaNg0WFpljnRSiS5RdQiv8LICZwGFpkCtzBM2NHi+B2v0SA06U5h+rIRy2TBVkHa9Wir3DVtgYv
X-Gm-Message-State: AOJu0YyM0ARfAB5mR8W5id8epZ+0+UGE1+FCz0+BBUa9YMASH2ERgHsI
	Smz6CgDeHaduzckpJIEJ1/0cHS2uQAQge5EL7zASfOjaiP55fyABj1OxShm62pqNvxxwvFboQYX
	Jjw==
X-Google-Smtp-Source: AGHT+IFUBAMo/Jls1V6s88/vn2YfJYt/DplYFylK6PKi7c61GSaGI2bCDM04U7NsLYIzvHMiWi+JlHOAyL8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:1504:b0:dcc:f01f:65e1 with SMTP id
 q4-20020a056902150400b00dccf01f65e1mr34554ybu.8.1713378209573; Wed, 17 Apr
 2024 11:23:29 -0700 (PDT)
Date: Wed, 17 Apr 2024 11:23:27 -0700
In-Reply-To: <399bbc9d-ae75-4754-8ce9-af563df15a38@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240413044129.52812-1-xry111@xry111.site> <20240413044129.52812-2-xry111@xry111.site>
 <Zh8Oli5MIyekLrbu@google.com> <20240417172222.f4h2csf4xkffccqn@desk> <399bbc9d-ae75-4754-8ce9-af563df15a38@intel.com>
Message-ID: <ZiATnwBHJThDNpxk@google.com>
Subject: Re: [PATCH v8 2/2] x86/mm: Don't disable PCID if the kernel is
 running on a hypervisor
From: Sean Christopherson <seanjc@google.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Xi Ruoyao <xry111@xry111.site>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Michael Kelley <mhklinux@outlook.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	"H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, linux-kernel@vger.kernel.org, 
	Andrew Cooper <andrew.cooper3@citrix.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, Apr 17, 2024, Dave Hansen wrote:
> On 4/17/24 10:22, Pawan Gupta wrote:
> >>>  static const struct x86_cpu_id invlpg_miss_ids[] = {
> >>> +	/* Only bare-metal is affected.  PCIDs in guests are OK.  */
> >>> +	{
> >>> +	  .vendor	= X86_VENDOR_INTEL,
> >>> +	  .family	= 6,
> >>> +	  .model	= INTEL_FAM6_ANY,

Just in case we go this route (I hope we don't), this should probably be:

        /* Only bare-metal is affected.  PCIDs in guests are OK.  */
        {
          .vendor       = X86_VENDOR_ANY,
          .feature      = X86_FEATURE_HYPERVISOR,
          .driver_data  = 0,
        },

to make it clear that the goal is to match only the feature.  Matching Intel P6
suffices because that's what the other entries in the array all check, but it
makes subtle, confusing code even more subtle and confusing.

> >>> +	  .feature	= X86_FEATURE_HYPERVISOR,
> >> Isn't this inverted?  x86_match_cpu() will return NULL if the CPU doesn't have
> >> HYPERVISOR.  We want it to return NULL if the CPU *does* have HYPERVISOR.
> > I think the implementation is correct, x86_match_cpu() will not return
> > NULL if the CPU doesn't have HYPERVISOR feature *and* matches one of the
> > CPUs below. It will only return NULL if none of the entries match.

Oooh, and because it's the first entry it will always be found even if a different
entry would match the FMS.  Oof.

> I think I gave a crappy suggestion here.
> 
> Let's just do the X86_FEATURE_HYPERVISOR explicitly in the code instead
> of trying to cram it into the invlpg_miss_ids[] check.  It's way easier
> to understand with an explicit code check.

+1.  And it doesn't rely on the HYPERVISOR entry being the first entry, which
is doubly evil.

