Return-Path: <linux-kernel+bounces-168141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0D1C8BB431
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 21:35:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66CD21F25808
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 19:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA5E4339A1;
	Fri,  3 May 2024 19:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eo5QI00p"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A0E2206E;
	Fri,  3 May 2024 19:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714764950; cv=none; b=p8r4sblhTg9Pkq68IxpQDeu3kttXJ3nusMSGt0+cFSdO3HWCe1LcYI/OXFj8ZeyP7frkfO4rabooUbvIDqSsM5zSLFaNDdTCfenyQO4rfC0FlzKJtRr35uDOW8n1DOLTycix9Sc+BsoUnxH/HWO1j8g7TRj16xvs6Z5B22ReYV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714764950; c=relaxed/simple;
	bh=OhK3E+a940tahvBPeiK0xswt7avRqyafDuFtSYMIobs=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N3SZTZSndJSn2TfTLHN5xPsWmep7VAaBh2rgbT5g3x6z+GM9yyKlHfyGtMsME2DzkfX0+63EkL4QaV8x2nuT+4MLijNGbzS2U+0ZIZRy9et5lzzuMu+73f+AqQ4a86PWinGqAWatZtISODIDROafQj9cXaGcBmy6BScut8KzKNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Eo5QI00p; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-34d96054375so5978f8f.2;
        Fri, 03 May 2024 12:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714764948; x=1715369748; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=U0mqsADwP2HKMLmT/kWuFaaNyNjoyU0vnELezZHXEzQ=;
        b=Eo5QI00p1NBIHgNKBOAYzVrJ9Y1VfFACJQ3IMblkIOeSiQJ4B1niWy8QPcMWgQMOuL
         FZtc2pANoDkooo5iKlv0rn53DPu/Pn7QSDZbtaT6NNQs7cSD4EsNbNUJNWNm/avgSmBZ
         ap5ry83Bt9wLh672e6YfmVsDMJoY85G0oTC++AuqmXuLGfFXfn3If2jyLdWlp6Fuk8hV
         5ZNEZZf+DeIKY9aYccVhN8Uucawb5RTngqgtEJQqeVcwYdcLkZE9/jINnAAHXm5GE8Dp
         hrx/fGogEk8puCDj/VssnRM2LAxbREtgA53j+tyzqk8zIUCosxnF5ifeRcy9hTeY2W7X
         FS+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714764948; x=1715369748;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U0mqsADwP2HKMLmT/kWuFaaNyNjoyU0vnELezZHXEzQ=;
        b=Xq3EuHbR83BxT6+UasNrlbTHrnuS/4EMi/3Oyj8/5pUi/33ibp72S3z1N1zfO86B28
         3GuUg+yCIh//r4Yc54apkayB2S855rWm/Sf5iSHyqHAnOssuovQzAjkIQlHLIUEdaQQ6
         s6MRvx4L7A9ALqYh8rt1OC/CsIBput/BULC4k0LLKD7Ay0s0Sloue9owfmlopoILrgRg
         OF/wUWS8CtGwSKNHPhgqa9RfaxSsWkjQwpIhFLGqcxV2sBVghx9IgeZ5eDVRNIZa3TTP
         xB0HSuq68vzMN9ECopSjGJZQhzQB1JR/2WvdervH8NyUPwbQ7fDa/5u/JuHwnroT7P9y
         32CA==
X-Forwarded-Encrypted: i=1; AJvYcCU5Qy6jzRIRE7Ila8VWzb7W6tZYK3Sk77HTIyTmBzd3ttZz5Ni7HStQJxvq6Azr9Us9pCgx6ZWfXjLaihsxbOvoDPuTmFMcYR30ISL5U62EJQIFFd5/Q/9eObcw6Mna1AojBq5Vh9h4T2PyWXvY7HlqwRRaLS3kV9kl9VGgVq94k4s24Zk=
X-Gm-Message-State: AOJu0YyyYOqFzyKRCLUIT2lKyCZ5dLwbAi4nM5o3vdpo45JRr7N3iTWU
	LkVPtvTxE2q6o+cW4EbLVxxOav+NFpF/KZMbneJ5KyJb4mzd59yF
X-Google-Smtp-Source: AGHT+IHo44bJgKTBq2upb63EKQBywuVxOdIxe/H649mJQj0Mlb9UwkEBkVjGLEGcFAKKFyNU3DY9+w==
X-Received: by 2002:a5d:558e:0:b0:34d:b605:ec68 with SMTP id i14-20020a5d558e000000b0034db605ec68mr2531426wrv.17.1714764946919;
        Fri, 03 May 2024 12:35:46 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-90-105.ip49.fastwebnet.it. [93.34.90.105])
        by smtp.gmail.com with ESMTPSA id s11-20020a05600c45cb00b00419f572671dsm6673868wmo.20.2024.05.03.12.35.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 12:35:46 -0700 (PDT)
Message-ID: <66353c92.050a0220.fd42f.7cfb@mx.google.com>
X-Google-Original-Message-ID: <ZjU8kKfPANkAF6gG@Ansuel-XPS.>
Date: Fri, 3 May 2024 21:35:44 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Hauke Mehrtens <hauke@hauke-m.de>,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	=?iso-8859-1?Q?=C1lvaro_Fern=E1ndez?= Rojas <noltari@gmail.com>,
	linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Daniel =?iso-8859-1?Q?Gonz=E1lez?= Cabanelas <dgcbueu@gmail.com>
Subject: Re: [PATCH 4/6] mips: bmips: setup: make CBR address configurable
References: <20240503135455.966-1-ansuelsmth@gmail.com>
 <20240503135455.966-5-ansuelsmth@gmail.com>
 <bf20e911-26db-4291-95d4-c91cc1d7f000@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf20e911-26db-4291-95d4-c91cc1d7f000@broadcom.com>

On Fri, May 03, 2024 at 12:09:02PM -0700, Florian Fainelli wrote:
> On 5/3/24 06:54, Christian Marangi wrote:
> > Add support to provide CBR address from DT to handle broken
> > SoC/Bootloader that doesn't correctly init it. This permits to use the
> > RAC flush even in these condition.
> > 
> > To provide a CBR address from DT, the property "mips-cbr-reg" needs to
> > be set in the "cpus" node. On DT init, this property presence will be
> > checked and will set the bmips_cbr_addr value accordingly. Also
> > bmips_rac_flush_disable will be set to false as RAC flush can be
> > correctly supported.
> > 
> > The CBR address from DT will be applied only if the CBR address from the
> > registers is 0, if the CBR address from the registers is not 0 and
> > is not equal to the one set in DT (if provided) a WARN is printed.
> > 
> > To ALWAYS overwrite the CBR address the additional property
> > "mips-broken-cbr-reg" needs to be set.
> > 
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > ---
> >   arch/mips/bmips/setup.c | 30 +++++++++++++++++++++++++++---
> >   1 file changed, 27 insertions(+), 3 deletions(-)
> > 
> > diff --git a/arch/mips/bmips/setup.c b/arch/mips/bmips/setup.c
> > index 18561d426f89..bef84677248e 100644
> > --- a/arch/mips/bmips/setup.c
> > +++ b/arch/mips/bmips/setup.c
> > @@ -34,7 +34,11 @@
> >   #define REG_BCM6328_OTP		((void __iomem *)CKSEG1ADDR(0x1000062c))
> >   #define BCM6328_TP1_DISABLED	BIT(9)
> > -/* CBR addr doesn't change and we can cache it */
> > +/*
> > + * CBR addr doesn't change and we can cache it.
> > + * For broken SoC/Bootloader CBR addr might also be provided via DT
> > + * with "mips-cbr-reg" in the "cpus" node.
> > + */
> >   void __iomem *bmips_cbr_addr;
> >   extern bool bmips_rac_flush_disable;
> > @@ -212,8 +216,28 @@ void __init device_tree_init(void)
> >   	/* Disable SMP boot unless both CPUs are listed in DT and !disabled */
> >   	np = of_find_node_by_name(NULL, "cpus");
> > -	if (np && of_get_available_child_count(np) <= 1)
> > -		bmips_smp_enabled = 0;
> > +	if (np) {
> 
> Please reduce the indentation with early return/gotos. There might also be a
> need to do some validation that the CBR is at least outside of the DRAM
> window, that is we cannot blindly trust the DT to have gotten the CBR right
> IMHO.

Do you have any hint on how to do the check if we are outside DRAM?

-- 
	Ansuel

