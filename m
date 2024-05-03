Return-Path: <linux-kernel+bounces-168251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 265C18BB5B5
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 23:27:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A98C31F22B53
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 21:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FEA254277;
	Fri,  3 May 2024 21:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dE1ZbsvY"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220C81E4B2;
	Fri,  3 May 2024 21:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714771663; cv=none; b=j0BBubZLBC4oFXNstf7Ix3vnnVZWZpL2y5zGGEnvuyVaRJ4d51fJnp/rov1LXA9LU43rQAk+0g6zAuPK2mDB/rJk41RCv0uUUm/8ssUv/Ex1j351R55Vn4WditAFGADRfJRQ/Mr3JupX0aj18+Av502SUFwRWONhRxDFn+j3Z1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714771663; c=relaxed/simple;
	bh=8UGuQyl1YLOhI8Kxv67deOSw/fy+Ogx3abFFRGzZn4w=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XplN5mCX6J3q2bd3bDShnOq65sz3AVXqAf7xOUQMWl7WtHUsUbSSPjwrIui5tC7Ke7ov8/X5CKoZHM79qKQHs977nSNzJSgdxQHjC5WUp7NiF1ntr9b/iQdGjQVrhhsKvipvHbr8LbYpNU1+5aG+jGacoy7xTE7bK/YjfE8y3VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dE1ZbsvY; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-41b2119da94so1616545e9.0;
        Fri, 03 May 2024 14:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714771660; x=1715376460; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=lP6SJGCFUENAZKan9UGF3hOihdCg3RIImp4IDQjfYL8=;
        b=dE1ZbsvYdZrRmSs7zkdrvANcTFaPA8+PkLeSBO9QE0/38k+4r5vtYQQplQMnf4ZoX8
         AIxOkI2Bu0hbQ5Z1J0gSuKLUMFPyYv3wtwk/Uk/ykDbUTQUfOvi6H6oBqPdcfSTu2pYy
         H8G2roIt/2aD0N/PaiWFpgOFKMOiowUBu4TD0oN9oHAdq4k6NcgfLfye+ckyHzQI/C/k
         64SPMhra2bo69L0HvDmLwU6kD3gWxyk96CjdgNcD/ynO+XGZXFAVBFQpc1PztNaX/y0O
         UVmwyMZqCHXlQyfszmr+bv4vRXMjvuQXWUbucl13FVTsuPivPQKganYhPyHx3e0n+ZH7
         98dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714771660; x=1715376460;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lP6SJGCFUENAZKan9UGF3hOihdCg3RIImp4IDQjfYL8=;
        b=k5esGYSYg2yDP871aIuMLnd/sGhZ1fIxMbZ5cRV6rVLsbEDLa9upioCiJ8TSUSrpEZ
         mbFAoqCPHB3X7eIxMAGBgKImsj4AlLjGvcTLcvoDmrbfdUOVvEQFlB3Uc2F7EWgJDhSh
         CyKyXzZqMeioJJ8nng2Xaaq8oCnOCayuRUSnSTdxXM/2F7A+K11VFqySaAxYteNm/My/
         Fuo1xpYjIMJyhqv6fyegXTbCxhNXEwVPQLCQvUGEuSgS9VekYlthjmEux6oJsJ27IsCP
         9A4PVU1wQjiOww4PXxQnD9p6lcXyX9CUhtWXGots0d23VZWCuP23CTuCm2Y33Eohyq9t
         8xxQ==
X-Forwarded-Encrypted: i=1; AJvYcCWBpQbFwIFZiDowvnPIio9i36R202z3FRcHTZkXXvZM3GTJ3a49x6FzoH7XgcRL+n+Mo/w2sekZcXCy9M1HQbQq7Uagbr6H606PxlNWGZ653i1zPp/XsjOLBU73m6ewTZLixiMRXsmjPo2WwZuVGgHbGDMIlhWmr1kUMkCmephGmf9drvg=
X-Gm-Message-State: AOJu0YyxSj3n9CApI/NvKwkp31+G+8StrHsvQIplVZjUAscMl7fChPqP
	RgLtbo7ZoDaoZKVQ07EPqcKC6ZIiTUcjt/WfTTVNl8Ta3VD3b/wD
X-Google-Smtp-Source: AGHT+IEZYot0B0Di33qEEFt7H+5/RPeGvMBEZAbjLzGwunv2i5jjiRIm2NNr7msFu9RwCfDrj5uSXw==
X-Received: by 2002:a05:600c:1d90:b0:41b:55b1:6cfc with SMTP id p16-20020a05600c1d9000b0041b55b16cfcmr3007659wms.1.1714771660285;
        Fri, 03 May 2024 14:27:40 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-90-105.ip49.fastwebnet.it. [93.34.90.105])
        by smtp.gmail.com with ESMTPSA id o10-20020a5d684a000000b0034a7a95c8cfsm4655300wrw.9.2024.05.03.14.27.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 14:27:39 -0700 (PDT)
Message-ID: <663556cb.5d0a0220.4b13a.04d5@mx.google.com>
X-Google-Original-Message-ID: <ZjVWy3ha9OTeMn9O@Ansuel-XPS.>
Date: Fri, 3 May 2024 23:27:39 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Florian Fainelli <f.fainelli@gmail.com>
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
	linux-kernel@vger.kernel.org,
	Daniel =?iso-8859-1?Q?Gonz=E1lez?= Cabanelas <dgcbueu@gmail.com>
Subject: Re: [PATCH 4/6] mips: bmips: setup: make CBR address configurable
References: <20240503135455.966-1-ansuelsmth@gmail.com>
 <20240503135455.966-5-ansuelsmth@gmail.com>
 <bf20e911-26db-4291-95d4-c91cc1d7f000@broadcom.com>
 <66353c92.050a0220.fd42f.7cfb@mx.google.com>
 <6ca4f556-28ea-4f51-a8dc-a10a94d726f0@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ca4f556-28ea-4f51-a8dc-a10a94d726f0@gmail.com>

On Fri, May 03, 2024 at 02:24:49PM -0700, Florian Fainelli wrote:
> On 5/3/24 12:35, Christian Marangi wrote:
> > On Fri, May 03, 2024 at 12:09:02PM -0700, Florian Fainelli wrote:
> > > On 5/3/24 06:54, Christian Marangi wrote:
> > > > Add support to provide CBR address from DT to handle broken
> > > > SoC/Bootloader that doesn't correctly init it. This permits to use the
> > > > RAC flush even in these condition.
> > > > 
> > > > To provide a CBR address from DT, the property "mips-cbr-reg" needs to
> > > > be set in the "cpus" node. On DT init, this property presence will be
> > > > checked and will set the bmips_cbr_addr value accordingly. Also
> > > > bmips_rac_flush_disable will be set to false as RAC flush can be
> > > > correctly supported.
> > > > 
> > > > The CBR address from DT will be applied only if the CBR address from the
> > > > registers is 0, if the CBR address from the registers is not 0 and
> > > > is not equal to the one set in DT (if provided) a WARN is printed.
> > > > 
> > > > To ALWAYS overwrite the CBR address the additional property
> > > > "mips-broken-cbr-reg" needs to be set.
> > > > 
> > > > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > > > ---
> > > >    arch/mips/bmips/setup.c | 30 +++++++++++++++++++++++++++---
> > > >    1 file changed, 27 insertions(+), 3 deletions(-)
> > > > 
> > > > diff --git a/arch/mips/bmips/setup.c b/arch/mips/bmips/setup.c
> > > > index 18561d426f89..bef84677248e 100644
> > > > --- a/arch/mips/bmips/setup.c
> > > > +++ b/arch/mips/bmips/setup.c
> > > > @@ -34,7 +34,11 @@
> > > >    #define REG_BCM6328_OTP		((void __iomem *)CKSEG1ADDR(0x1000062c))
> > > >    #define BCM6328_TP1_DISABLED	BIT(9)
> > > > -/* CBR addr doesn't change and we can cache it */
> > > > +/*
> > > > + * CBR addr doesn't change and we can cache it.
> > > > + * For broken SoC/Bootloader CBR addr might also be provided via DT
> > > > + * with "mips-cbr-reg" in the "cpus" node.
> > > > + */
> > > >    void __iomem *bmips_cbr_addr;
> > > >    extern bool bmips_rac_flush_disable;
> > > > @@ -212,8 +216,28 @@ void __init device_tree_init(void)
> > > >    	/* Disable SMP boot unless both CPUs are listed in DT and !disabled */
> > > >    	np = of_find_node_by_name(NULL, "cpus");
> > > > -	if (np && of_get_available_child_count(np) <= 1)
> > > > -		bmips_smp_enabled = 0;
> > > > +	if (np) {
> > > 
> > > Please reduce the indentation with early return/gotos. There might also be a
> > > need to do some validation that the CBR is at least outside of the DRAM
> > > window, that is we cannot blindly trust the DT to have gotten the CBR right
> > > IMHO.
> > 
> > Do you have any hint on how to do the check if we are outside DRAM?
> > 
> 
> I was going to suggest the use of memblock_start_of_DRAM() and
> memblock_end_of_DRAM() but before I sent that out your v2 already had it!

Ehehe, I was initially using mem_map and totalram_pages but then I inspected
memblock header and notice those good API.

-- 
	Ansuel

