Return-Path: <linux-kernel+bounces-168231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37AC28BB573
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 23:15:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8CA628709B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 21:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54E1851037;
	Fri,  3 May 2024 21:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YERctwCO"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03CB33398A;
	Fri,  3 May 2024 21:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714770951; cv=none; b=aOeXW7dpp1Fv9HR6xw815hT+sKTppNX+sSH8tp6W3exX2z0x0TpKJ8GRVzEa0IpcgZBhnD1Gtu/r7GsF7E7AlPO6Pk0iaJzFdo3IA3l17h1e86ONATZf/nHTVzh+/a/8wvYwxz7zKfPWezrNZzeYJK7BHm2QXpmhaM9WMwl0oX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714770951; c=relaxed/simple;
	bh=qX2JrN7LPZz2LWMctbRdx7bB6AHruIc6M8AyeNAMD6c=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cCJcINlXhS1nC9W2SAl/20uqXhcrt8vU6SaIdeKZiLxnhvaCsIYXZXmVcU+JIyTA0ir5h+UWd/m0oozmPAxX39Hshnoo0OED2oTq1DYkYWejbf2/qG9agIaEpCQk1RP6mJLJUThk9XPQ0YVYnplUKCUEvlS/cPO0hAVTKLhI+5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YERctwCO; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-41b79451153so1638935e9.2;
        Fri, 03 May 2024 14:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714770948; x=1715375748; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DdRwCTQkpz/X1YLepvfqvCk3WkFRHQQui17+dk3FXrk=;
        b=YERctwCOgEFp1A1gJ3ihIlDUaPJiAoL/+3yfrX7kraZKH7pfvnmQ8uQmycgtViIhYc
         kMSlP6R8Tw3XW0sU2dnZjRRvIBplMylX75uOJWBkT5NCIwQSvxRqlhrFSBGxJ956vKPo
         91tYLLwmp+9sWxvURgUvgTLq5+V4CzwtoT6bvGv0CLIibN63DaaxthhmnqCm10LvJdZC
         BLP9u4adhvf9wXH9WkhUoCSeR6arQIrfZ592suLQ7UCvCPW8T2XpIt6bgoEB9m5B0BI4
         h63PAuiV83C0Qfi4u1L9Zvm+uZbtqpIurIvBFdS496JzLpBgij5iv4b9OMSxZopcXOBl
         xP2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714770948; x=1715375748;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DdRwCTQkpz/X1YLepvfqvCk3WkFRHQQui17+dk3FXrk=;
        b=IXH1nBHREXCv4OfI+ReX02eypbleuEJNhNEhdOVD/girunDti9g/36hisKqTP+BJvi
         3+FwZydHzt+hHHxAYFMc2Wnsap/Cfc33Qnd8di8BC48Bk9HpRwrwqSQEVZ/insH5HL8h
         FPhRPU6ifhXaxPn3PQt1gnJdtW8eKeXgYiw/CHqgLsb61OfXVuKxUZFm13OkTLviYXd3
         A50X3qXRC35a5GpJBOiqvXY1c6K+CmHUBPNHKuDnUhRjIuhjGS/Sn6fu/qtLrtAsdaf4
         uCCWiG/bD8YuVTQPiFOwcThq+mkPTAstgQknFreCV4I+yTizvO/KaBH6+WKDH1GI4v98
         /iIQ==
X-Forwarded-Encrypted: i=1; AJvYcCW8jqWiI7lbgGnaxsHe19Jc52x3rE13EhxARC03dwRlYv8ta0p+Jf4QZi2DT/5avfjNq66JxBCuvcsb/MQK3H2rkpLIK++3xA6TzV5AwCbpp7wJTVzR5xvAyyQNIilmMIL+1gkEE6uskSVeQmyWWe40AYw6qX7wza+04yJh0br8PHVe0sY=
X-Gm-Message-State: AOJu0YxjlYbpj0KPPUKVDsyE8hPcONCKD9NbhDBIMK0cXPXjfRQpK7/G
	J2WXSYCuk9zU04foXNkfavAFoZG0xR4KI46fYwLODzp/Nb4zo1xafAhr3w==
X-Google-Smtp-Source: AGHT+IHfJcsIdR4IPILvS4nrstE+9NvBJwAtT6mSLwFJ5ugig1jZ6Ptoock8Xc2qIFROLfblGsVTjA==
X-Received: by 2002:a05:600c:4692:b0:418:2b26:47a3 with SMTP id p18-20020a05600c469200b004182b2647a3mr2935080wmo.32.1714770948071;
        Fri, 03 May 2024 14:15:48 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-90-105.ip49.fastwebnet.it. [93.34.90.105])
        by smtp.gmail.com with ESMTPSA id p12-20020a05600c1d8c00b0041bcb898984sm6908672wms.31.2024.05.03.14.15.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 14:15:47 -0700 (PDT)
Message-ID: <66355403.050a0220.9e59a.8031@mx.google.com>
X-Google-Original-Message-ID: <ZjVUAgtN1J-ddApK@Ansuel-XPS.>
Date: Fri, 3 May 2024 23:15:46 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Daniel =?iso-8859-1?Q?Gonz=E1lez?= Cabanelas <dgcbueu@gmail.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Hauke Mehrtens <hauke@hauke-m.de>,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	=?iso-8859-1?Q?=C1lvaro_Fern=E1ndez?= Rojas <noltari@gmail.com>,
	linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] mips: bmips: enable RAC on BMIPS4350
References: <20240503135455.966-1-ansuelsmth@gmail.com>
 <20240503135455.966-6-ansuelsmth@gmail.com>
 <5529fe79-e2f8-47ab-a0cf-2b37bb13bbd7@broadcom.com>
 <CABwr4_sz4DKjp_cJqTNBCyQSUhXGJM4_h1JSiK-h=8uAbPPoVQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABwr4_sz4DKjp_cJqTNBCyQSUhXGJM4_h1JSiK-h=8uAbPPoVQ@mail.gmail.com>

On Fri, May 03, 2024 at 11:11:13PM +0200, Daniel González Cabanelas wrote:
> El vie, 3 may 2024 a las 20:56, Florian Fainelli
> (<florian.fainelli@broadcom.com>) escribió:
> >
> > On 5/3/24 06:54, Christian Marangi wrote:
> > > From: Daniel González Cabanelas <dgcbueu@gmail.com>
> > >
> > > The data RAC is left disabled by the bootloader in some SoCs, at least in
> > > the core it boots from.
> > > Enabling this feature increases the performance up to +30% depending on the
> > > task.
> > >
> > > Signed-off-by: Daniel González Cabanelas <dgcbueu@gmail.com>
> > > Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
> > > [ rework code and reduce code duplication ]
> > > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > > ---
> > >   arch/mips/kernel/smp-bmips.c | 12 ++++++++++++
> > >   1 file changed, 12 insertions(+)
> > >
> > > diff --git a/arch/mips/kernel/smp-bmips.c b/arch/mips/kernel/smp-bmips.c
> > > index 6048c471b5ee..7bde6bbaa41f 100644
> > > --- a/arch/mips/kernel/smp-bmips.c
> > > +++ b/arch/mips/kernel/smp-bmips.c
> > > @@ -617,6 +617,18 @@ void bmips_cpu_setup(void)
> > >               __raw_readl(bmips_cbr_addr + BMIPS_RAC_ADDRESS_RANGE);
> > >               break;
> > >
> > > +     case CPU_BMIPS4350:
> > > +             u32 rac_addr = BMIPS_RAC_CONFIG_1;
> > > +
> > > +             if (!(read_c0_brcm_cmt_local() & (1 << 31)))
> > > +                     rac_addr = BMIPS_RAC_CONFIG;
> > > +
> > > +             /* Enable data RAC */
> > > +             cfg = __raw_readl(bmips_cbr_addr + rac_addr);
> > > +             __raw_writel(cfg | 0xa, bmips_cbr_addr + rac_addr);
> >
> > This enables data pre-fetching (bit 3) and data-caching (bit 1), have
> > you tried with 0xF to see if this provides any additional speed-up?
> >
> > Looks correct to me otherwise, I wonder if a flush would be in order
> > right after enabling, though I did not see any specific instructions
> > towards that part in the programming notes.
> >
> > > +             __raw_readl(bmips_cbr_addr + rac_addr);
> > > +             break;
> > > +
> > >       case CPU_BMIPS4380:
> > >               /* CBG workaround for early BMIPS4380 CPUs */
> > >               switch (read_c0_prid()) {
> >
> Hi Florian.
> Bits 0 and 1 are already enabled by the bootloader, so no need to
> write 0xF. I checked it on some devices with BCM6328, 6358, 6368 SoCs.
>
> Example, without the patch, reading the RAC Configuration Register 0 and 1:
>
> - BCM6368 booting from TP0:
> root@OpenWrt:/# devmem 0xff400000
> 0x02A07015
> root@OpenWrt:/# devmem 0xff400008
> 0x0000000F
>
> - BCM6368 booting from TP1:
> root@OpenWrt:/# devmem 0xff400000
> 0x02A0701F
> root@OpenWrt:/# devmem 0xff400008
> 0x00000005
> root@OpenWrt:/#
>

[ fixed the top-post ]

If that's the case then i'm setting 0xf since we verified it doesn't
cause problem and it's already set.

-- 
	Ansuel

