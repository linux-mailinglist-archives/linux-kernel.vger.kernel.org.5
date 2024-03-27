Return-Path: <linux-kernel+bounces-121294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E32EC88E4C0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:12:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F12671C29422
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FCAA13280D;
	Wed, 27 Mar 2024 12:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="dBv1cgco"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5C0132818
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 12:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711543282; cv=none; b=i512k+6scJ3updJ0y2awwCuHzW3dGwwOzgJaZL0zKsvWxLdZGKfcSaEqucg0QmXVVa1sA7aaEUggitaofGL6JFxUKOZd0w+YVhpzHbR+KhjKEn1UtJWbu39adVqRVk7PW6ZyDcdOsT8e/fZKJEGOjG2aTKrqFYg9PYEaBhenK4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711543282; c=relaxed/simple;
	bh=LL6XPyotWsfgmCQQzZX+trz3I9UfoOMeLDQgQTP/GxI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gi+wLqzdlaLSeUgoaKB9NSeC3b+nqYGPRhoDEkbBsbMm9IjtQfR9ICnmBEn7lDPXjuuCsJfxTZF+s0UvKzE678mP+h7WyXyOpEPASWW2pioX8X5tfNL+35CWjfIe5kv9OtAStTVWvfvWMrai+C+G3Z+qTU4ISvB99zfAXN8hezc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=dBv1cgco; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-56c441e66a5so207870a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 05:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1711543279; x=1712148079; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PHep0KDGNPKHj7j/FkavEsM3r82OS0BTBGoOUdBs53M=;
        b=dBv1cgcoILrCKwwTq9SyxRtmjhSvfJlisrzyETRx4kM/55DYJSX8a9x05TAcotQMC8
         J86lCiXM0dtrGWnxDlJ9pDtPEd+/uv8LikLpPZzq5ZAVHvfEl6Kdqu0DmYod3DysvjpD
         /Jq/BdYTBegEocJk0VIROqTM0mj2HHqq0/8Ln09n0/k/9LcTrYM6fAyoSiMTcIoOtH6S
         evYx1xWRH6aXxFMeoF0oaujCBa5l1vysiKYCnNEscAti7UGIRalXbKeWeRsjD9pHCxg8
         nQcniqogp4SLhNHc+3dumSE+TDzeXgZnIKuzDdW69KTNFpUaFn7siRdrX2TaHNPAOaRU
         R+/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711543279; x=1712148079;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PHep0KDGNPKHj7j/FkavEsM3r82OS0BTBGoOUdBs53M=;
        b=OnYALWlgLEPRc11dFOeYusMWxUHc4g+yZqLL/AZvT55TnSBnqLut/DKFxqfSfHWKJb
         w6INBem6PCDVyjG2hCQvIZp2DaBuTxM/B7EulgICkXl70A0I6OLCp6Q5p6v6Ii6ftIDV
         ty7ZZsi04mY8CDTwdzjOtyHSluF/eBBTo9LDfKKDeVzxS1/JcddStobtn/S/QdCrt5zq
         vmzImK/es91pwCiPNO2N/Aqf+sN5lILh/iBEPgafdO/5VJt8Cq9Is0zIq/LqRPyQgNsg
         Zuz0mzXazED8GxvfaxP07zcITcmjBx6zzYEcKFP+ZRCQnC5cBEY4gKS94SxGVFKa327Q
         4+pw==
X-Forwarded-Encrypted: i=1; AJvYcCWrqHsb7OuCFKdagLJ3+VICPYCW5nUFceEraTDldhCapemSCTwHJc5bMK/4ijLx7xwrNa6FWiUwr61t8oNbImIexGr7pQ0COMalXrNV
X-Gm-Message-State: AOJu0YyweoUjz3ySZgAab+WbWEko/GFPR0uqBhRbB9uLDBr2vvUCCqd/
	k5PNsh7Hi4DvLJQtr53uLvQGe9WfVEJY/fuC2N0cinN2xWhDYf0p0lmCFebLNHo=
X-Google-Smtp-Source: AGHT+IH16FiBrAz090hSXLYCPne/V1EiO5zts+X08jD19VgBvwS67tYjF6SM9T8jru5MiNUSj8WtYQ==
X-Received: by 2002:a17:906:c046:b0:a4d:f56a:199c with SMTP id bm6-20020a170906c04600b00a4df56a199cmr2051653ejb.4.1711543278860;
        Wed, 27 Mar 2024 05:41:18 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id e25-20020a170906845900b00a4673706b4dsm5418758ejy.78.2024.03.27.05.41.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 05:41:18 -0700 (PDT)
Date: Wed, 27 Mar 2024 13:41:17 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Conor Dooley <conor@kernel.org>
Cc: Christoph =?utf-8?Q?M=C3=BCllner?= <christoph.muellner@vrull.eu>, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Philipp Tomsich <philipp.tomsich@vrull.eu>, 
	=?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
	Heiko Stuebner <heiko@sntech.de>, Cooper Qu <cooper.qu@linux.alibaba.com>, 
	Zhiwei Liu <zhiwei_liu@linux.alibaba.com>, Huang Tao <eric.huang@linux.alibaba.com>, 
	Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH 2/2] riscv: T-Head: Test availability bit before enabling
 MAEE errata
Message-ID: <20240327-77a6b64153a68452d0438999@orel>
References: <20240327103130.3651950-1-christoph.muellner@vrull.eu>
 <20240327103130.3651950-3-christoph.muellner@vrull.eu>
 <20240327-imperfect-washbowl-d95e57cef0ef@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240327-imperfect-washbowl-d95e57cef0ef@spud>

On Wed, Mar 27, 2024 at 11:03:06AM +0000, Conor Dooley wrote:
> On Wed, Mar 27, 2024 at 11:31:30AM +0100, Christoph Müllner wrote:
> > T-Head's MAEE mechanism (non-compatible equivalent of RVI's Svpbmt)
> > is currently assumed for all T-Head harts. However, QEMU recently
> > decided to drop acceptance of guests that write reserved bits in PTEs.
> > As MAEE uses reserved bits in PTEs and Linux applies the MAEE errata
> > for all T-Head harts, this broke the Linux startup on QEMU emulations
> > of the C906 emulation.
> > 
> > This patch attempts to address this issue by testing the MAEE bit
> > in TH_MXSTATUS CSR. As the TH_MXSTATUS CSR is only accessible in M-mode
> > this patch depends on M-mode firmware that handles this for us
> > transparently.
> > 
> 
> > As this patch breaks Linux bootup on all C9xx machines with MAEE,
> > which don't have M-mode firmware that handles the access to the
> > TH_MXSTATUS CSR, this patch is marked as RFC.

Can we wrap the csr access in a _ASM_EXTABLE()? If firmware handles it,
then we return true/false based on the value. If firmware doesn't handle
it, and we get an illegal instruction exception, then we assume the bit
is set, which is the current behavior.

> 
> I think this is gonna be unacceptable in its current state given that it
> causes problems for every other version of the firmware. Breaking real
> systems for the sake of emulation isn't something we can reasonably do.
> 
> To make this sort of change acceptable, you're gonna have to add some way
> to differentiate between systems that do and do not support reading this
> CSR. I think we either a) need to check the version of the SBI
> implementation to see if it hits the threshold for supporting this
> feature, or b) add a specific SBI call for this so that we can
> differentiate between firmware not supporting the function and the

The FWFT SBI extension is being developed as a mechanism for S-mode to ask
M-mode things like this, but I think that extension should be used for
features that have potential to be changed by S-mode (even if not
everything will be changeable on all platforms), whereas anything that's
read-only would be better with...

> quote-unquote "hardware" not supporting it. I don't really like option a)
> as it could grow to several different options (each for a different SBI
> implementation) and support for reading the CSR would need to be
> unconditional. I have a feeling that I am missing something though,
> that'd make it doable without introducing a new call.
> 
> Thanks,
> Conor.
> 
> If only we'd made enabling this be controlled by a specific DT property,
> then disabling it in QEMU would be as simple as not setting that
> property :(

..this, where "DT property" is "ISA extension name". I wonder if we
shouldn't start considering the invention of xlinux_vendor_xyz type
extension names which firmware could add to the ISA string / array,
in order to communicate read-only information like this?

Thanks,
drew

> 
> > 
> > Signed-off-by: Christoph Müllner <christoph.muellner@vrull.eu>
> > ---
> >  arch/riscv/errata/thead/errata.c | 14 ++++++++++----
> >  1 file changed, 10 insertions(+), 4 deletions(-)
> > 
> > diff --git a/arch/riscv/errata/thead/errata.c b/arch/riscv/errata/thead/errata.c
> > index 8c8a8a4b0421..dd7bf6c62a35 100644
> > --- a/arch/riscv/errata/thead/errata.c
> > +++ b/arch/riscv/errata/thead/errata.c
> > @@ -19,6 +19,9 @@
> >  #include <asm/patch.h>
> >  #include <asm/vendorid_list.h>
> >  
> > +#define CSR_TH_MXSTATUS		0x7c0
> > +#define MXSTATUS_MAEE		_AC(0x200000, UL)
> > +
> >  static bool errata_probe_maee(unsigned int stage,
> >  			      unsigned long arch_id, unsigned long impid)
> >  {
> > @@ -28,11 +31,14 @@ static bool errata_probe_maee(unsigned int stage,
> >  	if (arch_id != 0 || impid != 0)
> >  		return false;
> >  
> > -	if (stage == RISCV_ALTERNATIVES_EARLY_BOOT ||
> > -	    stage == RISCV_ALTERNATIVES_MODULE)
> > -		return true;
> > +	if (stage != RISCV_ALTERNATIVES_EARLY_BOOT &&
> > +	    stage != RISCV_ALTERNATIVES_MODULE)
> > +		return false;
> >  
> > -	return false;
> > +	if (!(csr_read(CSR_TH_MXSTATUS) & MXSTATUS_MAEE))
> > +		return false;
> > +
> > +	return true;
> >  }
> >  
> >  /*
> > -- 
> > 2.44.0
> > 



