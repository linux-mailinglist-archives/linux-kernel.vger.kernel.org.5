Return-Path: <linux-kernel+bounces-15415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0631822BAC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 11:55:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FF85285949
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 10:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24F5118C3A;
	Wed,  3 Jan 2024 10:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KqBg61WR"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EECC518C2A
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 10:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a271a28aeb4so643816466b.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 02:55:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704279312; x=1704884112; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9RoJq5yTtCKUytZCCg8Irk7RzUuo1lo3zkz770UR28M=;
        b=KqBg61WRUniGOu1HHG/u2Tf9/64J/GVrGzC205xlCcMohFA8+EpWVuh1Hnc4+JwRds
         95k2+NAcG68YsUHv5r3mu5et/XZ5z0wD5AToUY29cLiANPq2XFJyoXuVX6Y3Vo/sJ6x9
         ixqkSOazpbYMXGQ3HPt47PbWVv81RcJgec2kV5asHnGZnvvKl3ntMWRfYh0t4rNXVaox
         UvTcSEmMmJVMO/3hQbFliC1u8yatxXo/WGuQe0Hv2kgdf9Z4TimiAGcThFcH+YIXElGQ
         4EQ+QSTQ4gAhGec+1Zp4JAjGJsoxIPCWiqAG2y5W9f2M35cIl/6n0utEgKww6hS/t3kJ
         od9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704279312; x=1704884112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9RoJq5yTtCKUytZCCg8Irk7RzUuo1lo3zkz770UR28M=;
        b=SDV1TYFBF9lLkvwJ4SWU5fNqvmglPBYtc3enH+olGxJ1fDwqbVz7JZgnjHv09qbEvA
         lhdtwJ1IY0fCRI+WimDvGOYOeUZSlNITA4cMC7X2qsEaKTerGocgqyTc8t7/yYbrowwb
         irIhdQQNg8GkhZFaetjTPoDtenI3xSKbyiKKrhyKnsFzzstfugngqAP6+fh7FY793VpE
         1sL34vV8+hY6BjeitRUySNRiPdp+UDKAjTbtTUggWVGNTQIEfj/rCf4zhdVGGLzdccRL
         r09Ptl9bv4wN32/LNs0uv/vWkHufys3CIMBnHIeQWr8Z7jAwB2DZ9qALTLCZVQKW/V/g
         Y7SA==
X-Gm-Message-State: AOJu0YwjQszuBPnzn237B0JmzF7UEypQJOkmZKYJH+s4ljCGJ2FdqsUM
	JqEITh6xRL39dwF2ljCAV0TeF/ojjq4=
X-Google-Smtp-Source: AGHT+IFjDxSQq/pQZomkyJ4EG+HEcz5EKO73mA1EQkSsuZgGLnvOX554V+IygFZKZj/IdIGmhs9yZA==
X-Received: by 2002:a17:906:f848:b0:a28:33a9:8784 with SMTP id ks8-20020a170906f84800b00a2833a98784mr1410125ejb.85.1704279311884;
        Wed, 03 Jan 2024 02:55:11 -0800 (PST)
Received: from gmail.com (195-38-113-95.pool.digikabel.hu. [195.38.113.95])
        by smtp.gmail.com with ESMTPSA id j1-20020a170906094100b00a26ae006522sm11942677ejd.122.2024.01.03.02.55.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 02:55:11 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Wed, 3 Jan 2024 11:55:09 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] arch/x86: Fix typos
Message-ID: <ZZU9DW2Aqlt3w1mU@gmail.com>
References: <20240103004011.1758650-1-helgaas@kernel.org>
 <fc7f44bd-e4e9-42db-abbe-c55469d43506@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc7f44bd-e4e9-42db-abbe-c55469d43506@infradead.org>


* Randy Dunlap <rdunlap@infradead.org> wrote:

> On 1/2/24 16:40, Bjorn Helgaas wrote:
> > From: Bjorn Helgaas <bhelgaas@google.com>
> > 
> > Fix typos, most reported by "codespell arch/x86".  Only touches comments,
> > no code changes.
> > 
> > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > ---
> >  60 files changed, 71 insertions(+), 71 deletions(-)
> > 
> > diff --git a/arch/x86/kernel/apic/vector.c b/arch/x86/kernel/apic/vector.c
> > index 319448d87b99..dbd15a67e9df 100644
> > --- a/arch/x86/kernel/apic/vector.c
> > +++ b/arch/x86/kernel/apic/vector.c
> > @@ -738,7 +738,7 @@ int __init arch_probe_nr_irqs(void)
> >  void lapic_assign_legacy_vector(unsigned int irq, bool replace)
> >  {
> >  	/*
> > -	 * Use assign system here so it wont get accounted as allocated
> > +	 * Use assign system here so it won't get accounted as allocated
> >  	 * and moveable in the cpu hotplug check and it prevents managed
> 
> OK, but        movable      is preferred.

Ok, I've added this to the patch too.

> >  	 * irq reservation from touching it.
> >  	 */
> 
> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Applied this patch to tip:x86/cleanups, thanks guys!

	Ingo

