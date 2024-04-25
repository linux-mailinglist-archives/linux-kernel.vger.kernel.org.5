Return-Path: <linux-kernel+bounces-158554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A917C8B21FA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 14:52:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C70061C208CA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 12:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A9F0149C40;
	Thu, 25 Apr 2024 12:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WQ/fxeKn"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64721494BC;
	Thu, 25 Apr 2024 12:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714049566; cv=none; b=gPpx5mPbizl/5KG1yuzKD9XDmETgYE8AN/hTaITxHPUk3KSp8mVzJYdBXomAEVEBfFfijI6pzkQ+joH8VowgaCnHNH5BK4tIuOWKvmuUfeGCZ/RyT+s2mdBLtPRc4JOBuLiMTZg8JxsigQ/7VfJuQMk6UlHaKC/Hm1Qw34pgNPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714049566; c=relaxed/simple;
	bh=gwekB6RaRxlS2eDN29F2xhmseDxkCdGf0FrbJqw4PTE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mIXSXkm36WMUnd+HgTMyyuYBu0Z5G51/c9d2McMln+mlo888oh6D92hLtfJtMO3h3yEhlJWT5uRENot5x5pTDF1jtnJ/1nHkGNMmnLqLxb4Yajq9g0HY4/K/7x0vbwJkukrnr1jkz5dQ89YA2kdpSZXEYadIn09niLkwrAPV9rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WQ/fxeKn; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-518f8a69f82so1035525e87.2;
        Thu, 25 Apr 2024 05:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714049563; x=1714654363; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=N68U3YqC3rWgap6HAasJ+BwSMTaiU5pcUurN9g7aQI8=;
        b=WQ/fxeKnZEMEyq3mtjpxAoBvyxKqd3PbW9lXR3pZxfz9DezyTzJjG2aVokSl1BvIQ0
         Mt9tQoRgxMeAgQttu5FumNKrH3w01Mb0bbhqfBtx15euq5ovard6VFnuMTmAvOr0XKUa
         nMHxuiRHdsLwAZYSMUXq6HuLhS/IO52ugi3oeAQXFDbNBAzvXFz9VjkKUt76/o9LSNDe
         kVcSzX71gAg9k5qIWe8TvIMfmAe7qVltCTpkawvHHkXd6kHF8XqDK8YqMainJlovTh+O
         PIHZs5RMAlKQcwsjIQwFaQdsxPek/5/psWv2hswqwKJPHl9ipo1N3fo14ltg2rbCQ+BM
         LLJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714049563; x=1714654363;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N68U3YqC3rWgap6HAasJ+BwSMTaiU5pcUurN9g7aQI8=;
        b=odHEQqc6WJZOLhrrLdS9jEdUKldV4euej52xo6gXfZtwPUxVPn7nz646RAXb4bst/e
         bZCcRX2B1OJrCgC9FOg0VL3PLN7EbQ6smsJppU8fSYoVvTIIXsU6FTH5O7DDED9hHESP
         yVYurgj4dTIAdzTy8Lb/a8fg2BM2MtHVX9W3otLHaKW4tMXlC+2Vg20oZzsd+XRne4Rn
         LeeMPYTeFOGaz7GG4ekPEZqnfregQ42GXQySEGgZ1WUF0atN6KfRm4rlYDzahYxnlh5B
         oVAKWaazV0M2xl5pXCv2Ooh7Umc+Y0hzFUeg+JgleeWTGaJo5CIIFwCtOA4WcHt5FKej
         PvYA==
X-Forwarded-Encrypted: i=1; AJvYcCXfaz7rrGPgYghkRFUjIuYV2/puihm7rAeICOoB01NocCdVNvS79dTGbHzMpggGN9jczjMSqgwvONGPk1krx4iDNvClfpC1a4Bt5DfeABjcbKO1ogGlCxvNWp2qMxYTHC3tfqVNsJwLuQ==
X-Gm-Message-State: AOJu0YwBgKUGd/+07QMJAQJVqzlJ6a+Whl4mgJg0Sv/rQhJwE2yP6LH3
	Jc3d/fKlyI6sAbPcWzB6Hp91gswEfXWIfQ+WlP52S+x1I2nPowt1
X-Google-Smtp-Source: AGHT+IFuK6e4i06UOQNj7wogVGGgvwPVDzRokotzll1IQA8y85iZylmImbqf3eVrgV+eDhnOJy6oig==
X-Received: by 2002:a05:6512:3f6:b0:51c:2012:f046 with SMTP id n22-20020a05651203f600b0051c2012f046mr2208675lfq.15.1714049562475;
        Thu, 25 Apr 2024 05:52:42 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id f9-20020a0565123b0900b00516c403d243sm2810511lfv.60.2024.04.25.05.52.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 05:52:41 -0700 (PDT)
Date: Thu, 25 Apr 2024 15:52:38 +0300
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
Message-ID: <whgp2xx4dv3szezz3bvmgutgazz6kvie3q7rgpr35zqzuzsygk@wppqzusteru4>
References: <20240222181324.28242-1-fancer.lancer@gmail.com>
 <20240222181324.28242-2-fancer.lancer@gmail.com>
 <20240415183616.GDZh1zoFsBzvAEduRo@fat_crate.local>
 <szcie4giwjykne4su6uu5wsmtsl3e3jd53rjfiwir6hm3ju7as@6eqh2xmj35ie>
 <20240421100712.GAZiTlUOm1hrLQvaMi@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240421100712.GAZiTlUOm1hrLQvaMi@fat_crate.local>

On Sun, Apr 21, 2024 at 12:07:30PM +0200, Borislav Petkov wrote:
> On Tue, Apr 16, 2024 at 01:06:11PM +0300, Serge Semin wrote:
> > It looks indeed crazy because the method is called enable_intr() and
> > is called in the IRQ handler. Right, re-enabling the IRQ in the handler
> > doesn't look good. But under the hood it was just a way to fix the
> > problem described in the commit you cited. enable_intr() just gets
> > back the IRQ Enable flags cleared a bit before in the
> > zynqmp_get_error_info() method.
> > 
> > The root cause of the problem is that the IRQ status/clear flags:
> > ECCCLR.ecc_corrected_err_clr	(R/W1C)
> > ECCCLR.ecc_uncorrected_err_clr	(R/W1C)
> > ECCCLR.ecc_corr_err_cnt_clr	(R/W1C)
> > ECCCLR.ecc_uncorr_err_cnt_clr	(R/W1C)
> > etc
> > 
> > and the IRQ enable/disable flags (since v3.10a):
> > ECCCLR.ecc_corrected_err_intr_en	(R/W)
> > ECCCLR.ecc_uncorrected_err_intr_en	(R/W)
> > 
> > reside in a single register - ECCCLR (Synopsys has renamed it to
> > ECCCTL since v3.10a due to adding the IRQ En/Dis flags).
> > 
> > Thus any concurrent access to that CSR like "Clear IRQ
> > status/counters" and "IRQ disable/enable" need to be protected from
> > the race condition.
> 
> Ok, let's pick this apart one-by-one. I'll return to the rest you're
> explaining as needed.
> 
> So, can writes to the status/counter bits while writing the *same* bit
> to the IRQ enable/disable bit prevent any race conditions?

No, because the clear and enable/disable bits belong to the same CSR.
While you are writing the clear+same/enable bits, the concurrent IO
may have changed the same/enable bits. Like this:

     IRQ-handler                        |    IRQ-disabler
                                        |
 tmp = clear_sts_bits | enable_irq_bits;|
                                        | ECCCLR = 0; // disable IRQ
 ECCCLR = tmp;                          |
----------------------------------------+--------------------------------------

As a result even though the IRQ-disabler cleared the IRQ-enable bits,
the IRQ-handler got them back to being set. The same will happen if we
get to write the *same* bits in the handler:

     IRQ-handler                        |    IRQ-disabler
                                        |
 tmp = ECCCLR | clear_sts_bits;         |
                                        | ECCCLR = 0; // disable IRQs
 ECCCLR = tmp;                          |
----------------------------------------+--------------------------------------

The last example is almost the same as what happens at the moment and
what I am fixing in this patch. The difference is that there is a
greater number of ECCCLR CSR changes performed in the IRQ-handler
context, which makes the critical section even wider than it could be:

     IRQ-handler                        |    IRQ-disabler
                                        |
zynqmp_get_error_info:                  |
 ECCCLR = clear_sts_bits;               |
 ECCCLR = 0; // actually redundant      |
..                                     | ECCCLR = 0; // disable IRQs
enable_intr:                            |
 ECCCLR = enable_irq_bits;              |
----------------------------------------+--------------------------------------

> 
> Meaning, you only change the status and counter bits and you preserve
> the same value in the IRQ disable/enable bit?

AFAICS this won't help to solve the race condition because writing the
preserved value of the enable/disable bits is the cause of the race
condition. The critical section is in concurrent flushing of different
values to the ECCCLR.*en bits. The only ways to solve that are:
1. prevent the concurrent access
2. serialize the critical section

> 
> IOW, I'm thinking of shadowing that ECCCTL in software so that we update
> it from the shadowed value.

I don't see the shadowing will help to prevent what is happening
unless you know some shadow-register pattern I am not aware of. AFAIR
the shadow register is normally utilized for the cases of:
1. read ops returns an incorrect value or a CSR couldn't be read
2. IO bus is too slow in order to speed-up the RMW-pattern
In any case the shadowed value and the process of the data flushing
would need to be protected with a lock anyway in order to sync the
shadow register content and the actual value written to the CSR.

> 
> Because, AFAIU, the spinlock won't help if you grab it, clear the
> status/counter bits and disable the interrupt in the process. You want
> to only clear the status/counter bits and leave the interrupt enabled.
> 
> Right?

Right, but the spinlock will help. What I need to do deal with two
concurrent operations:
IRQ-handler:  clear the status/counter bits and leave the IRQ enable
              bits as is.
IRQ-disabler: clear the IRQ enable bits
These actions need to be serialized in order to prevent the race
condition.

> 
> IOW, in one single write you do:
> 
> ECCCLR.ecc_corrected_err_clr=1
> ECCCLR.ecc_uncorrected_err_clr=1
> ECCCLR.ecc_corr_err_cnt_clr=1
> ECCCLR.ecc_uncorr_err_cnt_clr=1
> ECCCLR.ecc_corrected_err_intr_en=1
> ECCCLR.ecc_uncorrected_err_intr_en=1
> 
> ?

This won't be help because the concurrent IRQ-disabler could have
already cleared the IRQ enable bits while the IRQ-handler is being
executed and about to write to the ECCCLR register. Like this:

     IRQ-handler                        |    IRQ-disabler
                                        |
 tmp = clear_sts_bits | enable_irq_bits;|
                                        | ECCCLR = 0; // disable IRQ
 ECCCLR = tmp;                          |
----------------------------------------+--------------------------------------

Even if we get to add the spin-lock serializing the ECCCLR writes it
won't solve the problem since the IRQ-disabler critical section could
be executed a bit before the IRQ-handler critical section so the later
one will just re-enable the IRQs disabled by the former one.

Here is what is suggested in my patch to fix the problem:

     IRQ-handler                        |    IRQ-disabler
                                        |
zynqmp_get_error_info:                  |
                                        | lock_irqsave
                                        | ECCCLR = 0; // disable IRQs
                                        | unlock_irqrestore
 lock_irqsave;                          |
 tmp = ECCCLR | clear_sts_bits;         |
 ECCCLR = tmp;                          |
 unlock_irqrestore;                     |
----------------------------------------+--------------------------------------

See, the IRQ-status/counters clearing and IRQ disabling processes are
serialized so the former one wouldn't override the values written by
the later one.

Here is the way it would have looked in case of the shadow-register
implementation:

     IRQ-handler                        |    IRQ-disabler
                                        |
zynqmp_get_error_info:                  |
                                        | lock_irqsave
                                        | shadow_en_bits = 0;
                                        | ECCCLR = shadow_en_bits; // disable IRQs
                                        | unlock_irqrestore
 lock_irqsave;                          |
 tmp = clear_sts_bits | shadow_en_bits; |
 ECCCLR = tmp;                          |
 unlock_irqrestore;                     |
----------------------------------------+--------------------------------------

The shadow-register pattern just prevents one ECCCLR read op. The
shadowed data sync would have needed the serialization anyway. Seeing
the DW DDR uMCTL2 controller CSRs are always memory mapped, I don't
see using the shadow-register CSR would worth being implemented unless
you meant something different.

-Serge(y)

> 
> Thx.
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette

