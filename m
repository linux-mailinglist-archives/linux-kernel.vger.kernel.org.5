Return-Path: <linux-kernel+bounces-146600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7DDA8A67C0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 12:08:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98A5E281DE8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 10:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6CEE126F3A;
	Tue, 16 Apr 2024 10:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jDLJUUdq"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5278E126F1A;
	Tue, 16 Apr 2024 10:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713261977; cv=none; b=eTBYxgjhpF2k07S1Qs8yOx0bvu/xJtyg46zEdRwdeJPB7MB4/T1QLRBmLnVgkum/eqbIirA+6NI7J5hh6KWwpkmmC604RmQNN708vo9rdby8H3WEe4kD7o+LiO+X/N03FpyFbZqmeBOQMjTELsO6II1esJqgqKMI5gX/w0tyVnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713261977; c=relaxed/simple;
	bh=nBBotrIM2lFGTIsxj5wDVXzp2X8PeuUCAsxecut+ziE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K23wsXyg32DUilyyDWaCiMu0r5RV1mGcUmrXJVjc2or8oNrE4O8QJX2HBxim2N3FUa7rGl3MJunt9WJKz5dsDm4h0iR5ZkaMNw3m2kx862t83CgmMl3f/ytQ/9v74TLag1QU53KLBLLTA7FyOWplo8EAvASfWVEnErJbhqTLhxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jDLJUUdq; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2da888330b1so29934811fa.1;
        Tue, 16 Apr 2024 03:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713261974; x=1713866774; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nP2LCZsRsH5bYgeFYdk4867lfoKEy6YA3N7zU3b+vLA=;
        b=jDLJUUdq32q8dZX39ASrEdMt+Y1iQvmhnfuAp9qaASPVCCiXCyJeAg8YkxawgvxQkf
         +7aE/G/uYM9hLkfaPk1BnM51mkdqETCwRggmoGZrYuf3n6tfCNQDVUw8fepZbwsDr6XI
         ZPaJ6cSPgHLLwRTkxzcSNsu96qa5wuedaEVJG0U/9ZA1Z7ghTGf+/YwljHXfy7ny1/0R
         OsOiRDdFRQ6UWWwQkjDLqZlju5eGF09np4fbr/990NMg4wV7LP9uojmhaNm7jT/TY8o0
         fVJfFZLzRdJ+5SG5ekectWTpuR7V/tiBKB0O6B/bMAseM4CmWmDG0NV11711ocXoiklq
         HcwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713261974; x=1713866774;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nP2LCZsRsH5bYgeFYdk4867lfoKEy6YA3N7zU3b+vLA=;
        b=suJUcbLXlKpgfGyVK3jW/T+rLmhglSfLXhCE/yuT0bR/fLOFa3DIldB4tuCM3edIoJ
         moB4NHpGaqHzHNMoJ0G02QKQL2S84rxCiAcrxQ4DxU1avT9AKr3oPpW0FE5X+LmFdPDu
         TGXKEkIY+eAtU5TlOygU2HtJKLGu0739PVyWjWyC22R8GSJC6ptZSwolo5CZr/gIOQT7
         UdSNi/9kEouovBQprYbcBmrccfxXeuV7Ee41qiBEMUpO/q420VOL0zzBIz1gXOZ1+/iz
         C+L6m2U7fMSDfSHfiKHkKti9DIfwwIV89YfiH07j8u0kXEAmjDHhEF5k66qm0Dx4/6Z7
         J8Ew==
X-Forwarded-Encrypted: i=1; AJvYcCWmoC0doU/kGiGjnKOuVSnq6mCfa7J3w51CQgH3ISXdd9+Wp5nroaLj0HYXlSxD5+gJZ9KHQXVd/Ax4Sou01BgTeeaRuve42d8g9vUz9FpYXyvUlm1YoNiGBzuMglWHw/vkhG1aF5gsoA==
X-Gm-Message-State: AOJu0YwZ2u0AFGmznI645GdtoXf65aCVJpEWZhqogjuGrPM9uWMtKcLL
	lrjzD3Dh4xrigiX60KpNPADnpsDfY2K4KNiHsHovsaGxstC+r8uA
X-Google-Smtp-Source: AGHT+IEmWC/z8EFlVE+HoCkIloIhvUAFQzXxLgzyzEHCnE8uXw9ceWaakfk6BtoyjpyiKgmGyZlSzg==
X-Received: by 2002:a2e:a370:0:b0:2d4:7003:fc6c with SMTP id i16-20020a2ea370000000b002d47003fc6cmr7746075ljn.10.1713261974200;
        Tue, 16 Apr 2024 03:06:14 -0700 (PDT)
Received: from mobilestation ([213.79.110.82])
        by smtp.gmail.com with ESMTPSA id e6-20020a05651c04c600b002d8ecc42115sm1501883lji.87.2024.04.16.03.06.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 03:06:13 -0700 (PDT)
Date: Tue, 16 Apr 2024 13:06:11 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Michal Simek <michal.simek@amd.com>, 
	Alexander Stein <alexander.stein@ew.tq-group.com>, Tony Luck <tony.luck@intel.com>, 
	James Morse <james.morse@arm.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Robert Richter <rric@kernel.org>, Dinh Nguyen <dinguyen@kernel.org>, 
	Punnaiah Choudary Kalluri <punnaiah.choudary.kalluri@xilinx.com>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-arm-kernel@lists.infradead.org, linux-edac@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Sherry Sun <sherry.sun@nxp.com>, Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH v5 01/20] EDAC/synopsys: Fix ECC status data and IRQ
 disable race condition
Message-ID: <szcie4giwjykne4su6uu5wsmtsl3e3jd53rjfiwir6hm3ju7as@6eqh2xmj35ie>
References: <20240222181324.28242-1-fancer.lancer@gmail.com>
 <20240222181324.28242-2-fancer.lancer@gmail.com>
 <20240415183616.GDZh1zoFsBzvAEduRo@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240415183616.GDZh1zoFsBzvAEduRo@fat_crate.local>

On Mon, Apr 15, 2024 at 08:36:16PM +0200, Borislav Petkov wrote:
> On Thu, Feb 22, 2024 at 09:12:46PM +0300, Serge Semin wrote:
> > The race condition around the ECCCLR register access happens in the IRQ
> > disable method called in the device remove() procedure and in the ECC IRQ
> > handler:
> > 1. Enable IRQ:
> >    a. ECCCLR = EN_CE | EN_UE
> > 2. Disable IRQ:
> >    a. ECCCLR = 0
> > 3. IRQ handler:
> >    a. ECCCLR = CLR_CE | CLR_CE_CNT | CLR_CE | CLR_CE_CNT
> >    b. ECCCLR = 0
> >    c. ECCCLR = EN_CE | EN_UE
> > So if the IRQ disabling procedure is called concurrently with the IRQ
> > handler method the IRQ might be actually left enabled due to the
> > statement 3c.
> > 
> > The root cause of the problem is that ECCCLR register (which since v3.10a
> > has been called as ECCCTL) has intermixed ECC status data clear flags and
> > the IRQ enable/disable flags. Thus the IRQ disabling (clear EN flags) and
> > handling (write 1 to clear ECC status data) procedures must be serialised
> > around the ECCCTL register modification to prevent the race.
> > 
> > So fix the problem described above by adding the spin-lock around the
> > ECCCLR modifications and preventing the IRQ-handler from modifying the
> > IRQs enable flags (there is no point in disabling the IRQ and then
> > re-enabling it again within a single IRQ handler call, see the statements
> > 3a/3b and 3c above).
> 

> So I'm looking at the code and am looking at this and wondering how we
> even ended up in this mess?!
> 
> An interrupt handler should not *enable* the interrupt again - that's
> just crazy. And I should've seen that in
> 
>   4bcffe941758 ("EDAC/synopsys: Re-enable the error interrupts on v3 hw")
> 
> and stopped it right there. But well, it is what it is...

It looks indeed crazy because the method is called enable_intr() and
is called in the IRQ handler. Right, re-enabling the IRQ in the handler
doesn't look good. But under the hood it was just a way to fix the
problem described in the commit you cited. enable_intr() just gets
back the IRQ Enable flags cleared a bit before in the
zynqmp_get_error_info() method.

The root cause of the problem is that the IRQ status/clear flags:
ECCCLR.ecc_corrected_err_clr	(R/W1C)
ECCCLR.ecc_uncorrected_err_clr	(R/W1C)
ECCCLR.ecc_corr_err_cnt_clr	(R/W1C)
ECCCLR.ecc_uncorr_err_cnt_clr	(R/W1C)
etc

and the IRQ enable/disable flags (since v3.10a):
ECCCLR.ecc_corrected_err_intr_en	(R/W)
ECCCLR.ecc_uncorrected_err_intr_en	(R/W)

reside in a single register - ECCCLR (Synopsys has renamed it to
ECCCTL since v3.10a due to adding the IRQ En/Dis flags).

Thus any concurrent access to that CSR like "Clear IRQ
status/counters" and "IRQ disable/enable" need to be protected from
the race condition.

> 
> So I'd like to see the following flow:
> 
> * on init, the interrupt is enabled with enable_intr() *after*
> registering the interrupt handler.
> 
> * on exit, the interrupt is disabled with disable_intr() and then no
> interrupts are coming in anymore.
> 
> And then I don't think you'll need the spinlock and it'll be sane
> design.
> 
> Right?

This is what is implemented at the moment and it's racy. IRQ-handler
clears the IRQ status/counters by writing 1s to the respective flags
in the ECCCLR register. This inevitable causes writing to the IRQ
Enable/disable bits. Thus if during the IRQ handling the driver/device
gets to be removed (disable_intr() is called), the IRQ might be left
enabled despite of having the disable_intr() method executed. In its
turn that may cause fatal problems if the IRQ handler is executed once
again before the IRQ line is freed and disabled in the GIC side.

If we wish to avoid using the atomic spin-lock we'll need to change
the order:
0. Enable ECC IRQ in ECCCLR/ECCCTL CSR
1. Request IRQ line and register the IRQ handler
..
2. Free IRQ line
3. Disable ECC IRQ in ECCCLR/ECCCTL CSR

But if that path is decided to be taken the next aspects will need to
be taken into account:

1. If the IRQ line is shared, then the ECC IRQ might be delivered
somewhere between steps 0 and 1, which won't make the IRQ subsystem
happy. (Although this isn't actual for the current driver because it
requests the non-shared IRQ line for ECC, but who knows how the
situation will change in future).

2. A bit later (in the patchset #3) I am adding the ECC Scrubber
support, which will need the spin-lock anyway to protect another two
CSRs access. These CSRs are touched in run-time to enable/disable the
scrubbing and set/get the scrub rate.

So since we'll need to have a spin-lock anyway and from the
scalability point of view, it sounds reasonable to keep what is
suggested in my patch. What do you think?

-Serge(y)

> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette

