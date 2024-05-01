Return-Path: <linux-kernel+bounces-165600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3627D8B8E6E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 18:46:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B81681F23578
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 16:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61A2912E4D;
	Wed,  1 May 2024 16:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="eoop2eVD"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637B6DDC9
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 16:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714581972; cv=none; b=WtU8cDI1BFEyoN+qmH4r2tIl5dMAfsyzWj/sWbPRs2Z/dK3qDKDqrLhyic7hD5Tix6/tpDTeoqd38s5TPOdw+2U6lx35ZwqNt8cWTLkQE3dlkpoVIJghTD5FYEUw2iiX6H+eG7pfEf5G13nUO2jir6xNfVw3eLKELn4C8WKk1AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714581972; c=relaxed/simple;
	bh=krDJy1o6nlqSmGBvYIH6mBjLgfXcSgWyqs7rmpIkNjI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BXCmBUeScsUch5n5ZfIDXO+RZlwsdcSvx4CuMVExZmfk9pxzBizZH5ENbtPsgjzeyULLIyr1HPFsxE+xQWhkBTsZURciM7zmvC9n5nfk6pQorXLJ3wUuyZKKH0mOY/H1MnCQJGccUSQIGJN8hKNnRNFw/I7NVUJuCTxTpQTDL40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=eoop2eVD; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2b38f2e95aeso2014a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2024 09:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1714581970; x=1715186770; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HNAlEVQt8bQKb4hVjkj/tzVzfjylPjyKPm1CNtyCLJI=;
        b=eoop2eVDk48ExcE0bVPSW1rCgmLVpjyQVEDmghnYayVtrHC0td9Ii5c04MmvmqsiwL
         G2rN8mR0x2PXM4TCpWU5JLRYDBeTX+bn+hlrNKoPt4SaBmNc/IbAmm+qAZT8Ch7cQPc2
         b0sWDkV7pq5C3YNK0WXJi1BXdR/CvVsjGbGcnUr3g+xUeb+ZX1q27f4us1sDAnqGe3LK
         l72eIyJZYL0x/SY7JkFL98OZSgFWoX5i3SyvfDefSeiTw4N/DnYmhOuuKcfrtxs462Z0
         ol7SwrA6uViYVzANofHxCgMWTOkzHtz9rSGCDG7vx/6KSHL1VbWmqZC9wCkOaC7DD119
         BAHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714581970; x=1715186770;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HNAlEVQt8bQKb4hVjkj/tzVzfjylPjyKPm1CNtyCLJI=;
        b=v+JzwHsv/E9Rgz34FoTAOPbCXX/6FKcb8cs10wAP0qCxY/X0aIO9KEEA5zcApDM3NN
         DtqVxz8KhFPal45mM1tHE+rz432UqloMfziZRktDkN/kU/Wwn+xDmpFZkls7TzOUZzwz
         LD2GGWEpIC2Iz7dY1hIlfGLZzhfQloVDSvcjUm2sU+hdC4+capEPhMSE3vbgzCIIQ5LI
         cGW/HMuARpmS9+sXwcMN3rMItLmBANG5IR6QeniyaCeJ7IMmdXImtikn+3fMkqlYe2aS
         F9HREyu7DvouOz9atLSgZtjOQ7FwTYFJSW5aT50ETiIcPPxs0Zhh90eg+rKD3gqhWgkx
         4M/w==
X-Forwarded-Encrypted: i=1; AJvYcCU2FF/sH3A/81Lo2/lI+scl0AiE/ynSSA9YhMSb7iv1czafJ4jM0h7QrQL4ZAUfmKe6KRNRyaeBPtOVpgX47Nx9X96Pug6+ZnbrZtAZ
X-Gm-Message-State: AOJu0YyK9QyVF9j03SWu1MiFhdZe8kcnK2aNpUCDnbAV9DDZNUuhpRSG
	8XmyaFOqZ6kwzRYajan1T2MP/UltjKHUJ9n/osiWQm4kmnqhcjjQkoJw98gLAss=
X-Google-Smtp-Source: AGHT+IH65t3T7Cre6ETXiixVNrR9oMbdBgpbTRkUxmtEpcotJ4qRMx/UYqqnRRVgQ7nCUV3kiM8/gw==
X-Received: by 2002:a17:90a:c78f:b0:2a5:3f30:f5f6 with SMTP id gn15-20020a17090ac78f00b002a53f30f5f6mr274501pjb.20.1714581969579;
        Wed, 01 May 2024 09:46:09 -0700 (PDT)
Received: from ghost ([2601:647:5700:6860:1dcc:e03e:dc61:895d])
        by smtp.gmail.com with ESMTPSA id g2-20020a170902934200b001e25da6f2f2sm24328716plp.68.2024.05.01.09.46.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 09:46:08 -0700 (PDT)
Date: Wed, 1 May 2024 09:46:04 -0700
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
Subject: Re: [PATCH v4 03/16] riscv: vector: Use vlenb from DT
Message-ID: <ZjJxzKUHkrVUv9zm@ghost>
References: <20240426-dev-charlie-support_thead_vector_6_9-v4-0-b692f3c516ec@rivosinc.com>
 <20240426-dev-charlie-support_thead_vector_6_9-v4-3-b692f3c516ec@rivosinc.com>
 <20240501-showroom-rephrase-66c0929011b3@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240501-showroom-rephrase-66c0929011b3@spud>

On Wed, May 01, 2024 at 11:31:45AM +0100, Conor Dooley wrote:
> On Fri, Apr 26, 2024 at 02:29:17PM -0700, Charlie Jenkins wrote:
> > If vlenb is provided in the device tree, prefer that over reading the
> > vlenb csr.
> > 
> > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > ---
> >  arch/riscv/include/asm/cpufeature.h |  2 ++
> >  arch/riscv/kernel/cpufeature.c      | 43 +++++++++++++++++++++++++++++++++++++
> >  arch/riscv/kernel/vector.c          | 12 ++++++++++-
> >  3 files changed, 56 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm/cpufeature.h
> > index 347805446151..0c4f08577015 100644
> > --- a/arch/riscv/include/asm/cpufeature.h
> > +++ b/arch/riscv/include/asm/cpufeature.h
> > @@ -31,6 +31,8 @@ DECLARE_PER_CPU(struct riscv_cpuinfo, riscv_cpuinfo);
> >  /* Per-cpu ISA extensions. */
> >  extern struct riscv_isainfo hart_isa[NR_CPUS];
> >  
> > +extern u32 riscv_vlenb_of;
> > +
> >  void riscv_user_isa_enable(void);
> >  
> >  #if defined(CONFIG_RISCV_MISALIGNED)
> > diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> > index 3ed2359eae35..8158f34c3e36 100644
> > --- a/arch/riscv/kernel/cpufeature.c
> > +++ b/arch/riscv/kernel/cpufeature.c
> > @@ -35,6 +35,8 @@ static DECLARE_BITMAP(riscv_isa, RISCV_ISA_EXT_MAX) __read_mostly;
> >  /* Per-cpu ISA extensions. */
> >  struct riscv_isainfo hart_isa[NR_CPUS];
> >  
> > +u32 riscv_vlenb_of;
> > +
> >  /**
> >   * riscv_isa_extension_base() - Get base extension word
> >   *
> > @@ -648,6 +650,42 @@ static int __init riscv_isa_fallback_setup(char *__unused)
> >  early_param("riscv_isa_fallback", riscv_isa_fallback_setup);
> >  #endif
> >  
> > +static int riscv_homogeneous_vlenb(void)
> 
> Without a verb, this function name is rather odd.
> 

Maybe has_riscv_homogeneous_vlenb() is better.

> > +{
> > +	int cpu;
> > +	u32 prev_vlenb = 0;
> > +	u32 vlenb;
> > +
> > +	for_each_possible_cpu(cpu) {
> > +		struct device_node *cpu_node;
> > +
> > +		cpu_node = of_cpu_device_node_get(cpu);
> > +		if (!cpu_node) {
> > +			pr_warn("Unable to find cpu node\n");
> > +			continue;
> 
> Hmm, if we fail to find the cpu node, then shouldn't we be returning an
> error?

Yes, I will change that.

> 
> > +		}
> > +
> > +		if (of_property_read_u32(cpu_node, "riscv,vlenb", &vlenb)) {
> > +			of_node_put(cpu_node);
> > +
> > +			if (prev_vlenb)
> > +				return -1;
> 
> Can you return an errno here and below please?
> 

Sounds good.

> > +			continue;
> > +		}
> > +
> > +		if (prev_vlenb && vlenb != prev_vlenb) {
> > +			of_node_put(cpu_node);
> > +			return -1;
> > +		}
> > +
> > +		prev_vlenb = vlenb;
> > +		of_node_put(cpu_node);
> > +	}
> > +
> > +	riscv_vlenb_of = vlenb;
> > +	return 0;
> > +}
> > +
> >  void __init riscv_fill_hwcap(void)
> >  {
> >  	char print_str[NUM_ALPHA_EXTS + 1];
> > @@ -671,6 +709,11 @@ void __init riscv_fill_hwcap(void)
> >  			pr_info("Falling back to deprecated \"riscv,isa\"\n");
> >  			riscv_fill_hwcap_from_isa_string(isa2hwcap);
> >  		}
> > +
> > +		if (riscv_homogeneous_vlenb() < 0) {
> > +			pr_warn("RISCV_ISA_V only supports one vlenb on SMP systems. Please ensure that the riscv,vlenb devicetree property is the same across all CPUs. Either all CPUs must have the riscv,vlenb property, or none. If no CPUs in the devicetree use riscv,vlenb then vlenb will be probed from the vlenb CSR. Disabling vector.\n");
> 
> Oh dear, that's a bit unwieldy... I think you could get away with a far
> more basic message - and you should be able to break this over lines,
> adjacent string literals should get concatenated.
> I'd probably say something like "unsupported heterogeneous vlen detected,
> vector extension disabled", however we should actually check that the
> vector extension has been detected on all CPUs and that kernel support
> for vector is enabled before emitting a warning for this.

Haha yeah I wanted to provide as much information as possible, but I
will shorten it.

I can add an if-statement to only run this code if check if V is
contained in elf_hwcap.

- Charlie

> 
> Cheers,
> Conor.
> 
> > +			elf_hwcap &= ~COMPAT_HWCAP_ISA_V;
> > +		}
> >  	}
> >  
> >  	/*
> > diff --git a/arch/riscv/kernel/vector.c b/arch/riscv/kernel/vector.c
> > index 6727d1d3b8f2..e04586cdb7f0 100644
> > --- a/arch/riscv/kernel/vector.c
> > +++ b/arch/riscv/kernel/vector.c
> > @@ -33,7 +33,17 @@ int riscv_v_setup_vsize(void)
> >  {
> >  	unsigned long this_vsize;
> >  
> > -	/* There are 32 vector registers with vlenb length. */
> > +	/*
> > +	 * There are 32 vector registers with vlenb length.
> > +	 *
> > +	 * If the riscv,vlenb property was provided by the firmware, use that
> > +	 * instead of probing the CSRs.
> > +	 */
> > +	if (riscv_vlenb_of) {
> > +		this_vsize = riscv_vlenb_of * 32;
> > +		return 0;
> > +	}
> > +
> >  	riscv_v_enable();
> >  	this_vsize = csr_read(CSR_VLENB) * 32;
> >  	riscv_v_disable();
> > 
> > -- 
> > 2.44.0
> > 



