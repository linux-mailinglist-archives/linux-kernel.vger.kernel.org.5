Return-Path: <linux-kernel+bounces-160441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FD448B3D87
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 19:03:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A13651F21F8F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 17:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26A8315B107;
	Fri, 26 Apr 2024 17:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="xFDqRb5S"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9761598F5
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 17:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714150990; cv=none; b=cX3IDwzufQVRGgEV5a3/WH0jgck85Vxp11tnLNsbbVDFZoXuOENF29kxYm3TfJog9NBzp99vGC9JFPxm13sCtDQWz9PE2HJMCXrC5HEYCR9yY9h6KdK2e6YIsXxxqm5l9sef8LHkyVmHZnQMtGzkkBQzkr8+ZDr01FUmt1ZRSJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714150990; c=relaxed/simple;
	bh=IIUidfl+uxE8HqCjRrfbr3H1JmrlbwQllqwYZd4nwsU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=szxTvh+isA10F7LmBRWpIKhQRgdHmTZHOzetPJjgHtw4gLgsJKEVHlixmqd0XMKRmaqa1IbkEF2+lLu658a4AY56VBgZkvGKqqz4WvCPEDe44eIk/QpkdSPyvCObP5GPu7c20SEcgCAl3bo3+WUyyqwuN6pN+qfT38tA7lrjU+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=xFDqRb5S; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6ed0e9ccca1so2272923b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 10:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1714150987; x=1714755787; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iQOEs8kmpRBE5AbT4DjWE8lg43hpZ4efabp/bR8JqV4=;
        b=xFDqRb5Sn8aI5sAY6MsuhuMpoKujOim3RKrKx3CXKhM9FiGMrD8T189G5i9oBgaAkP
         6tCoGrUUdGRIx8XvxwTHHuKgFQGC8H4Hd9vBlsEVRutINva4ElvU2Ppjg+7GhwnvOyef
         QFIz096z581ISPn/b7uPfV3WLC7cdcO/HCLcaoaVdjAhQw+rfSiMgsmPtg4aCyVIvjEs
         P9z3rbu1yUo9tUMpIUHqNhOMxo638RCPnfiYF2zQDI7l5rrOvqirSU+mDaykHvciNmQr
         5eQcjEMpMNJ7d1e2N3e42yNsX0TmHRv5ChFjFaluw51Jx9YOnAPVtL7EGXND5oc3uog+
         lziQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714150987; x=1714755787;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iQOEs8kmpRBE5AbT4DjWE8lg43hpZ4efabp/bR8JqV4=;
        b=EeSZFNBd++4QkYBKI07knWk9QeLIFTY+fljKtseZ+asqKK5xo4w+nm+8Ltf5h6YOdf
         piLXRk0GhS+sdhlNQiwaVr5buE9PUjhsDq6Uv/8Yf1QVDbi0n+CCMFMKY3YzhDQ8kKG6
         dN5GeJJcMG4AMx8SakjTlmlFjJReVCJYqW5Q9DbI3U635/e1d7bKE4TOub84nQyxJMp0
         kK6el3M8Yb/0p5Knf2EKO+qabTcYi/7pBlZMuOdQiKihr5KOd7j/Bd0fSALPu6Jbrymc
         7xOVXUg4PPSPiibH+aj53tnFtqvocqddgNbvRTHBuJQcWzP656PxlMgMeXUHVOmsUR4d
         AY4w==
X-Forwarded-Encrypted: i=1; AJvYcCUJCIYnlGxUHHY+CX88aaiqt3Q5rSDCErPtRTqALGRlIo2nf2HoINTo5hWOKgjX1ua20Khfp5ZPgxzCtQw67pN+sED14mscaoKxm0+D
X-Gm-Message-State: AOJu0YxnVIi1y6HZPi2VJNH+qI2GUZJ5wWrZzfz/3UOk9CH3vjF8FniO
	NxqPn4LmNISU0nyGHzn6T4NfjEKr5CnZFEIJbS3LtLx53ZyA3sH+4j8nBudYLXg=
X-Google-Smtp-Source: AGHT+IFR6N5kNo831LY2QDvVk1TR2PcWNxJi2WUcYOuXc/kYMYtASUjQSOGqHJvgWIKCX9dNVAjTRg==
X-Received: by 2002:a05:6a20:1050:b0:1ad:7c58:6a74 with SMTP id gt16-20020a056a20105000b001ad7c586a74mr3664735pzc.23.1714150986909;
        Fri, 26 Apr 2024 10:03:06 -0700 (PDT)
Received: from ghost ([2601:647:5700:6860:4d29:d34e:e48:a550])
        by smtp.gmail.com with ESMTPSA id i6-20020aa787c6000000b006e6b52eb59asm15022967pfo.126.2024.04.26.10.03.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 10:03:06 -0700 (PDT)
Date: Fri, 26 Apr 2024 10:03:02 -0700
From: Charlie Jenkins <charlie@rivosinc.com>
To: Conor Dooley <conor@kernel.org>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Evan Green <evan@rivosinc.com>,
	=?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 04/17] riscv: vector: Use vlenb from DT
Message-ID: <ZiveRt5Ebw0dvO5h@ghost>
References: <20240420-dev-charlie-support_thead_vector_6_9-v3-0-67cff4271d1d@rivosinc.com>
 <20240420-dev-charlie-support_thead_vector_6_9-v3-4-67cff4271d1d@rivosinc.com>
 <20240426-unfocused-amount-e4e74e66962f@spud>
 <20240426-unfixed-mournful-0a71fb3972b4@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240426-unfixed-mournful-0a71fb3972b4@spud>

On Fri, Apr 26, 2024 at 05:21:16PM +0100, Conor Dooley wrote:
> On Fri, Apr 26, 2024 at 04:17:52PM +0100, Conor Dooley wrote:
> > On Sat, Apr 20, 2024 at 06:04:36PM -0700, Charlie Jenkins wrote:
> > > If vlenb is provided in the device tree, prefer that over reading the
> > > vlenb csr.
> > > 
> > > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > > ---
> > >  arch/riscv/include/asm/cpufeature.h |  2 ++
> > >  arch/riscv/kernel/cpufeature.c      | 26 ++++++++++++++++++++++++++
> > >  arch/riscv/kernel/vector.c          | 13 +++++++++----
> > >  3 files changed, 37 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm/cpufeature.h
> > > index 347805446151..809f61ffb667 100644
> > > --- a/arch/riscv/include/asm/cpufeature.h
> > > +++ b/arch/riscv/include/asm/cpufeature.h
> > > @@ -31,6 +31,8 @@ DECLARE_PER_CPU(struct riscv_cpuinfo, riscv_cpuinfo);
> > >  /* Per-cpu ISA extensions. */
> > >  extern struct riscv_isainfo hart_isa[NR_CPUS];
> > >  
> > > +extern u32 riscv_vlenb_dt[NR_CPUS];
> > > +
> > >  void riscv_user_isa_enable(void);
> > >  
> > >  #if defined(CONFIG_RISCV_MISALIGNED)
> > > diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> > > index c6e27b45e192..48874aac4871 100644
> > > --- a/arch/riscv/kernel/cpufeature.c
> > > +++ b/arch/riscv/kernel/cpufeature.c
> > > @@ -35,6 +35,8 @@ static DECLARE_BITMAP(riscv_isa, RISCV_ISA_EXT_MAX) __read_mostly;
> > >  /* Per-cpu ISA extensions. */
> > >  struct riscv_isainfo hart_isa[NR_CPUS];
> > >  
> > > +u32 riscv_vlenb_dt[NR_CPUS];
> > > +
> > >  /**
> > >   * riscv_isa_extension_base() - Get base extension word
> > >   *
> > > @@ -656,6 +658,28 @@ static int __init riscv_isa_fallback_setup(char *__unused)
> > >  early_param("riscv_isa_fallback", riscv_isa_fallback_setup);
> > >  #endif
> > >  
> > > +static void riscv_set_vlenb_from_dt(void)
> > 
> > I'd expect to see a name here that had "of" in it, not "dt".
> 
> Also, "set" - I think "get" is more suitable here given that this
> doesn't actually set the vlen, we only do any setting later on in
> riscv_v_set_vsize().
> 
> > 
> > > +{
> > > +	int cpu;
> > > +
> > > +	for_each_possible_cpu(cpu) {
> > > +		struct device_node *cpu_node;
> > > +
> > > +		cpu_node = of_cpu_device_node_get(cpu);
> > > +		if (!cpu_node) {
> > > +			pr_warn("Unable to find cpu node\n");
> > > +			continue;
> > > +		}
> > > +
> > > +		if (!of_property_read_u32(cpu_node, "riscv,vlenb", &riscv_vlenb_dt[cpu])) {
> > > +			of_node_put(cpu_node);
> > > +			continue;
> > > +		}
> > > +
> > > +		of_node_put(cpu_node);
> > > +	}
> > > +}
> > > +
> > >  void __init riscv_fill_hwcap(void)
> > >  {
> > >  	char print_str[NUM_ALPHA_EXTS + 1];
> > > @@ -675,6 +699,8 @@ void __init riscv_fill_hwcap(void)
> > >  	} else {
> > >  		int ret = riscv_fill_hwcap_from_ext_list(isa2hwcap);
> > >  
> > > +		riscv_set_vlenb_from_dt();
> > 
> > Hmm, I think we can go a step further here. We know all of the CPUs
> > widths by the time we get to the first call to riscv_v_setup_vsize(), can
> > we examine the whole list and decide not to enable vector if they do
> > not match, rather than continuing and failing to online CPUs that having
> > the mismatched size?
> > 
> > I guess that can go into the `if (elf_hwcap & COMPAT_HWCAP_ISA_V)`
> > condition we already have, and would require clearing the bit from the
> > mask we have at the moment.

Good point, thank you. Since this is not supported with ACPI, I will
clear the COMPAT_HWCAP_ISA_V bit from elf_hwcap if
riscv_set_vlenb_from_dt() (which will be renamed) determines that the
the riscv,vlenb field changes between CPU entries. 

- Charlie

> > 
> > Cheers,
> > Conor.
> > 
> > > +
> > >  		if (ret && riscv_isa_fallback) {
> > >  			pr_info("Falling back to deprecated \"riscv,isa\"\n");
> > >  			riscv_fill_hwcap_from_isa_string(isa2hwcap);
> > > diff --git a/arch/riscv/kernel/vector.c b/arch/riscv/kernel/vector.c
> > > index 6727d1d3b8f2..fb7f3ca80d9e 100644
> > > --- a/arch/riscv/kernel/vector.c
> > > +++ b/arch/riscv/kernel/vector.c
> > > @@ -32,11 +32,16 @@ EXPORT_SYMBOL_GPL(riscv_v_vsize);
> > >  int riscv_v_setup_vsize(void)
> > >  {
> > >  	unsigned long this_vsize;
> > > +	int cpu = smp_processor_id();
> > >  
> > > -	/* There are 32 vector registers with vlenb length. */
> > > -	riscv_v_enable();
> > > -	this_vsize = csr_read(CSR_VLENB) * 32;
> > > -	riscv_v_disable();
> > > +	if (riscv_vlenb_dt[cpu]) {
> > > +		this_vsize = riscv_vlenb_dt[cpu];
> > 
> > > +	} else {
> > > +		/* There are 32 vector registers with vlenb length. */
> > > +		riscv_v_enable();
> > > +		this_vsize = csr_read(CSR_VLENB) * 32;
> > > +		riscv_v_disable();
> > > +	}
> > >  
> > >  	if (!riscv_v_vsize) {
> > >  		riscv_v_vsize = this_vsize;
> > > 
> > > -- 
> > > 2.44.0
> > > 
> 
> 



