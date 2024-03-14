Return-Path: <linux-kernel+bounces-102693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1D8187B5FB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 02:01:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A114128764F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 01:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B8A64A15;
	Thu, 14 Mar 2024 01:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ddw5jJVU"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52BF61113
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 01:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710378063; cv=none; b=iIVx4EIk8L4t/b2Hf4eq91NWO4pqIz2I4ZYypDsbwsmsJdyaudr6ylzJHvp5Hg4+aDZSBsuFj9nLTaEp0mF8BxQfKWGFlbB9lgOC6jwTv6YVTDq+Dh0h6x1/ZY9GkpBcNzYRiDK+eBuJTt+iTppxGx+6E49+X38fLC6XYlc1k2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710378063; c=relaxed/simple;
	bh=NtwzHxfvcWxMXOxe3H7rgf2iCheFJhPEn3nXY32Pjhw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fA0JVbcxArsvIItHkzI6fZ4H2w4apKWkc2PrNp9Ewfn67Ldw3+nt2T7902ZSoBKXJGXh2awzZ2ttRdouyasSH5WDKUWfHBSwnbIBuzOMnTHSkQutzCJU+y/W+WPGJVuedzybGxMoSNaoOO1pDF9rG6JL3DbTxxZ2v/3dE0Oqu7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ddw5jJVU; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-1dddb2b6892so4197285ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 18:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710378062; x=1710982862; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EQTEleojd5viC5A5AYPDJGsPN8oibgqc8we/hfPKc/g=;
        b=ddw5jJVUrsBidKHTIbrc9ZF4eb+CloaekevIZWK8oOc/foux+tTmIbBFPzzMrn+vUd
         3XYJac/vhtQuid9nXvVln5S1tiIkjCEmdspZaNeZ6bNSdlzhGlgeHD3VHj+D9VIir0Hm
         7Z8IZoduYPmQtu8lxa+WDyOBLRRcpUHEJBmnEUnwzorTAHt0FJVqvo+59Bj1zhQOn58G
         fQahXV9fm2fTIND2CrRlkrretq7vZNDb+DEyW2flbFUZfIF/39yLObSDi08Ryc9LDH6F
         0KN0qd429eFtESqTo0d8+P5VvGV15A9y5uJI0x9lLPvgo+wA/LN+vn1GpEV2TFNDdOPu
         VMjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710378062; x=1710982862;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EQTEleojd5viC5A5AYPDJGsPN8oibgqc8we/hfPKc/g=;
        b=ZrC5ZX9THDZRgEW2UmAQyPEdUq8vPM9YIQG3A+NXNWRUfHGuO/zks4pnww/R0rU0ys
         zdGn6uUnrLFOa/EG5P0UMHKwj8FCfewLOsJOfcBBef2xJbmiB8hHLE5iKl5xHYccT8Xa
         BPUms8T+K6D7tPw24X5l4NtCDNqsPi61lR29RxQtPfAovUGRdCUpXSwXwdBxk9NCGuuX
         faAt/iTKS6czXIn7Jts89gL8NoQUZSAmDdC/xBNv7D92oqGnWYtKFvrdPPfkFxPoD6xR
         xNE2GUI6IgKct82uIHi9j9BSGVX+4GwDbHnyO9YFV4hc2azmXmNmMG3Qwzd6DdB7Sr0e
         r9Cw==
X-Forwarded-Encrypted: i=1; AJvYcCVYIRH0Co1lt7AbbMR5Wj5M2RYyKjqjJAN7j6YSousZrvzSu13mgCtpFdPzOgUVl0RrBOuCiIjFMX4hK6G3jP2SKCdKVdSjXZkWPIjn
X-Gm-Message-State: AOJu0YwjFnsj+60mn2QOAV5gBBymA1LN9p3RIwvo42B5FN5S86K8ZWFX
	hZvCZoxx+WNF0u9JAE4jhQK1f0kw0QCgrcJVj6zBi9GH7BRMrwKHjhNinhhCQ6Zlcoqp1BSgD0K
	U8A==
X-Google-Smtp-Source: AGHT+IEbfpQupzITGwOB3jYT6JWViwHBjL3w3EJsB6cDh5GZAUKltsAsyIQL3Y7yOWKCB7t0jXD1dXx+/7k=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:903:2309:b0:1dc:b333:f2a4 with SMTP id
 d9-20020a170903230900b001dcb333f2a4mr1246plh.12.1710378061383; Wed, 13 Mar
 2024 18:01:01 -0700 (PDT)
Date: Wed, 13 Mar 2024 18:00:59 -0700
In-Reply-To: <ZfJA3AaLga5OXoL1@yzhao56-desk.sh.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240309010929.1403984-6-seanjc@google.com> <Ze5bee/qJ41IESdk@yzhao56-desk.sh.intel.com>
 <Ze-hC8NozVbOQQIT@google.com> <BN9PR11MB527600EC915D668127B97E3C8C2B2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZfB9rzqOWmbaOeHd@google.com> <ZfD++pl/3pvyi0xD@yzhao56-desk.sh.intel.com>
 <BN9PR11MB527688657D92896F1B19C2F98C2A2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZfFp6HtYSmO4Q6sW@yzhao56-desk.sh.intel.com> <ZfHBqNzaoh36PXDn@google.com> <ZfJA3AaLga5OXoL1@yzhao56-desk.sh.intel.com>
Message-ID: <ZfJMS9ac-MA8mV9u@google.com>
Subject: Re: [PATCH 5/5] KVM: VMX: Always honor guest PAT on CPUs that support self-snoop
From: Sean Christopherson <seanjc@google.com>
To: Yan Zhao <yan.y.zhao@intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>, "jgg@nvidia.com" <jgg@nvidia.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Josh Triplett <josh@joshtriplett.org>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "rcu@vger.kernel.org" <rcu@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Yiwei Zhang <zzyiwei@google.com>
Content-Type: text/plain; charset="us-ascii"

On Thu, Mar 14, 2024, Yan Zhao wrote:
> On Wed, Mar 13, 2024 at 08:09:28AM -0700, Sean Christopherson wrote:
> > On Wed, Mar 13, 2024, Yan Zhao wrote:
> > > > We'll certain fix the security hole on CPUs w/ self-snoop. In this case
> > > > CPU accesses are guaranteed to be coherent and the vulnerability can
> > > > only be exposed via non-coherent DMA which is supposed to be fixed
> > > > by your coming series. 
> > > > 
> > > > But for old CPUs w/o self-snoop the hole can be exploited using either CPU
> > > > or non-coherent DMA once the guest PAT is honored. As long as nobody
> > > > is willing to actually fix the CPU path (is it possible?) I'm kind of convinced
> > > We can cook a patch to check CPU self-snoop and force WB in EPT even for
> > > non-coherent DMA if no self-snoop. Then back porting such a patch together
> > > with the IOMMU side mitigation for non-coherent DMA.
> > 
> > Please don't.  This is a "let sleeping dogs lie" situation.
> > 
> >   let sleeping dogs lie - avoid interfering in a situation that is currently
> >   causing no problems but might do so as a result of such interference.
> > 
> > Yes, there is technically a flaw, but we have zero evidence that anyone cares or
> > that it is actually problematic in practice.  On the other hand, any functional
> > change we make has a non-zero changes of breaking existing setups that have worked
> > for many years. 
> > 
> > > Otherwise, IOMMU side mitigation alone is meaningless for platforms of CPU of
> > > no self-snoop.
> > > 
> > > > by Sean that sustaining the old behavior is probably the best option...
> > > Yes, as long as we think exposing secuirty hole on those platforms is acceptable. 
> > 
> > Yes, I think it's acceptable.  Obviously not ideal, but given the alternatives,
> > I think it is a reasonable risk.
> > 
> > Being 100% secure is simply not possible.  Security is often about balancing the
> > risk/threat against the cost.  In this case, the risk is low (old hardware,
> > uncommon setup for untrusted guests, small window of opportunity, and limited
> > data exposure), whereas the cost is high (decent chance of breaking existing VMs).
> Ok, thanks for explanation!
> I still have one last question: if in future there are CPUs with no selfsnoop
> (for some unknown reason, or just paranoid),

Don't jinx us :-)

> do we allow this unsafe honoring of guest memory type for non-coherent DMAs? 

Hmm, no?  AIUI, the intent is that all future CPUs will support self-snoop.
Assuming that's the case, then I think it's fair to put the onus on Intel to not
have escapes, i.e. to not end up shipping CPUs with erratas.  Then, if an erratum
does come along, we can make a decision, e.g. allow older CPUs by default, but
require an admin opt-in for new CPUs.

But let's just hope that's a problem we never have to deal with.  :-D

