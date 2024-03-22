Return-Path: <linux-kernel+bounces-111258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A35308869CF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 10:58:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B1B31F21EC6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 09:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4138D22611;
	Fri, 22 Mar 2024 09:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nci4RWRX"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC3B20DDB;
	Fri, 22 Mar 2024 09:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711101493; cv=none; b=NWQLefymoUr3lkYygRpUGCQluC2F1qndpWnfkoDAna67P6zc0fLRlyoWf21lld9B55KB2GAUFjfexwAHV93RXp97lcBHvB/fHclYwGY7qSpQtKNZP+HnP1ve2ieZ+SJlEHxfZKAKE+Qk7POoq1ePeRN2qoRlfuGaB5V3olKOZdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711101493; c=relaxed/simple;
	bh=mZTyWVFeEOx3cqGMfXq4zUTy9aeTI1cR1TIk16D5slo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q09ll9BfkEfOKpD8pdoBs5jNjN76RrpnimzIScFlQX0m+UDA+ejI2/f3pmpTVUFOHQnaTiENTj8BCFPq4yvG+/0njETDqMe+UTf8+vGlA1rRc2/43l8bt/sp0AM9AaKBcXNIMxeXzq4nqujasYardu+kgWYYOtNSwKN5VdzvjAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nci4RWRX; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4146a1ac117so11558615e9.0;
        Fri, 22 Mar 2024 02:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711101490; x=1711706290; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xGqEICCDmfISMN2Tgs6OomSyhnoxbbHxoKPcMA5U3Ds=;
        b=Nci4RWRX/RWHJ51etY9g5hgxnnk3wT4B1W37BR8FlFgmbMB8aOQc1rwZyozy9Si3jr
         1FKC+gc4Ps8KUjyxmagx05m6Gc4y70GU8cnSyI2Ifj0hYEjfLRT6iEzqWSuJKZvh9Em5
         Aut2r1gPnwGYzd3NGfOkuAKoMCbyA2ny3aNsLmIZdO9e5a5qILG+CTmqVPnFhpWJVHWT
         5GavHYDxPLPvpzwklZX0MpoSn79lg7eT/iHvFcdxDQsDITKZxgYb4jr6XrmOggNy5Umt
         V3pjX3iBv+wPv8AvXGsMTl8NAK6lgaEv3PYBMfiILronSV4DlRTruhn92x7zOHiWjcpv
         393A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711101490; x=1711706290;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xGqEICCDmfISMN2Tgs6OomSyhnoxbbHxoKPcMA5U3Ds=;
        b=G2nBnjqRNrMFZN8EFdz0wMV/hvHELz0VuqFwg98tz5hZOslXMSdd6MMhIoKbLGxs5g
         84X6W/OuubUTpC2ODGCetNhE5bDR04VE0MB07V2OIXwdghpF9OlR3WHF10AAdycjnq/7
         qcQ8+01AZp/bbe623LEmzcaf8dHTvpRSAWAWMVzeeR93AgTuIHsIZoIyUynMF8/xxpjp
         fWfCnny5dP6ChTisqpeT725DVDehXL+aEFxNpBWY99ITgRCalEkp58VYPXaLes/Zs0md
         zVPqcqKBT24wxE9b5i9ToZlqfJmaUG5mUsHX6WRuVIuUgg9ZNJIyTQyY/qDPzheGgRzr
         OJEQ==
X-Forwarded-Encrypted: i=1; AJvYcCX19XW8Yx1cd2dJ7ENbiiDTSBT02i0AQ+vzSo4xyJTanHFD5ncItx2G9PHXVLYwv1wa5C7ehObjsHwSP8vkteMaLtsm3gWcTPeg2vd7dOAr5vBs55gXwsKiwvBVyoj+fqem6gDt6tOY53xSevVwUZ/1FmDkTTlpBzqbCTlZKDI=
X-Gm-Message-State: AOJu0Yznzkv9akcoY8vG0ONTxLQW5L0aDogbVv9qfcn8v54VgaT1j0JQ
	kC0cwkk3NgIG71RzR3HXUBs3ETtcCZUsZNUjwmDLRDFJmtAeTgC9
X-Google-Smtp-Source: AGHT+IGVBpsURgy95iJG0WVZSv0I6xzHthi5Am+OVL/2gfunyQBb0t2g50DRG1kF8q/B9Ag+0WfCPQ==
X-Received: by 2002:a05:600c:3507:b0:414:76df:41d6 with SMTP id h7-20020a05600c350700b0041476df41d6mr1401787wmq.13.1711101489520;
        Fri, 22 Mar 2024 02:58:09 -0700 (PDT)
Received: from gmail.com (1F2EF04C.nat.pool.telekom.hu. [31.46.240.76])
        by smtp.gmail.com with ESMTPSA id fm5-20020a05600c0c0500b004146c769c79sm8087715wmb.0.2024.03.22.02.58.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 02:58:09 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Fri, 22 Mar 2024 10:58:06 +0100
From: Ingo Molnar <mingo@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Dave Hansen <dave.hansen@intel.com>,
	Anton Altaparmakov <anton@tuxera.com>, Pavel Machek <pavel@ucw.cz>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>, Chen Yu <yu.c.chen@intel.com>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Catalin Marinas <catalin.marinas@arm.com>, linux-mm@kvack.org,
	Matthieu Baerts <matthieu.baerts@tessares.net>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] x86/pm: Fix false positive kmemleak report in
 msr_build_context().
Message-ID: <Zf1WLscQHk9+w+Z+@gmail.com>
References: <20240314142656.17699-1-anton@tuxera.com>
 <70261e2a-b87e-462e-964e-95a51ecde978@intel.com>
 <CAJZ5v0hdA2PUc8cmJtCNxW-nzHdWV+pxnTEeVu_7YHsHZTmFLw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0hdA2PUc8cmJtCNxW-nzHdWV+pxnTEeVu_7YHsHZTmFLw@mail.gmail.com>


* Rafael J. Wysocki <rafael@kernel.org> wrote:

> On Thu, Mar 14, 2024 at 4:05 PM Dave Hansen <dave.hansen@intel.com> wrote:
> >
> > On 3/14/24 07:26, Anton Altaparmakov wrote:
> > >  /* image of the saved processor state */
> > >  struct saved_context {
> > > -     /*
> > > -      * On x86_32, all segment registers except gs are saved at kernel
> > > -      * entry in pt_regs.
> > > -      */
> > > -     u16 gs;
> > >       unsigned long cr0, cr2, cr3, cr4;
> > >       u64 misc_enable;
> > >       struct saved_msrs saved_msrs;
> > > @@ -27,6 +22,11 @@ struct saved_context {
> > >       unsigned long tr;
> > >       unsigned long safety;
> > >       unsigned long return_address;
> > > +     /*
> > > +      * On x86_32, all segment registers except gs are saved at kernel
> > > +      * entry in pt_regs.
> > > +      */
> > > +     u16 gs;
> > >       bool misc_enable_saved;
> > >  } __attribute__((packed));
> >
> > Isn't this just kinda poking at the symptoms?  This seems to be
> > basically the exact same bug as b0b592cf08, just with a different source
> > of unaligned structure members.
> >
> > There's nothing to keep folks from reintroducing these kinds of issues
> > and evidently no way to detect when they happen without lengthy reproducers.
> 
> This change is fine with me FWIW,

thx, I've added your:

    Acked-by: "Rafael J. Wysocki" <rafael@kernel.org>

> but I agree that making it for kmemleak reasons feels kind of misguided.

Yeah, so it's a workaround, but kmemleak is also a useful debugging 
facility that is finding memory leaks that static checkers are missing.

The fact that we don't have an easy way to prevent these problems from 
being introduced is I think properly counterbalanced by the facts that:

  1) Only kmemleak users are inconvenienced by the false positives.

  2) kmemleak users & maintainers have created the patch. There was no 
     pressure on us x86 maintainers other than to apply a root-cause 
     analyzed patch.

  2) Over a timespan of ~10 years only 2 such alignment problems were 
     introduced, and they were fixed by the kmemleak folks. I think that's 
     a fair price to pay for a useful facility.

Ie. I don't think there's any long-term maintenance burder concern.

So I've applied this workaround to x86/urgent, with a change to the title 
to make sure this isn't understood as a real bug in the PM code, but a 
workaround:

   37fb408c99af x86/pm: Work around false positive kmemleak report in msr_build_context()

.. lemme know if you feel strongly about this. :-)

Thanks,

	Ingo

