Return-Path: <linux-kernel+bounces-143099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A668A8A3434
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 18:58:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BC6A2844BD
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 16:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FA4614BFB0;
	Fri, 12 Apr 2024 16:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="O7oFQ6hj"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3378414B075
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 16:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712941090; cv=none; b=qisBc/E/EYVDG1Yxpa+sLYuwdVNJjijcYCXP4+Yjnc4tYKqrOwTvEWhIVMnhougpuQbOseZb8IqAlhI5rkT9pYrjdJOqb0uYSbxxenk/7d2vAr7X7MLiIg0z0E7PJlnpnLjt5jqNRqreSjKINEJ3RihJY2HzHvOy/M9wpIvA9S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712941090; c=relaxed/simple;
	bh=z//6a/ujrWe0aR0i6I+FUKPGioDXc9HHkfE1eqzCmDM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e7AtXhJ79LJQEdeNU2zToIlztWdGtCwbXjx2t5ElRKNaF03Ntodz+GYsXIZsMeXn6FfkTSPt/qsBjVrfQcXNdXV6/pO00xjBt1jOZ3ZO1C3kGWCcjcyAqakUP3lE4bxvhwaPronNfCF6soVoYVnEHTzTMT1h/Iw9fugpj2UCD24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=O7oFQ6hj; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6ed691fb83eso982315b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 09:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1712941088; x=1713545888; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FJWVQnWLX/pkislYxbbN5qnILpyF7P63m18zWA+EsbY=;
        b=O7oFQ6hjTUPaAqQqZaOUsB82dNIB1k6axYtvjal5tXBpSPDjdt7niGcj0HvFrnvcPG
         pYP1LO23fgTE2EBAXmQw4O4s81ywaGJpVIDxAmTgmuzlItNDOn2s+RuO2mVwigN0CxzA
         n7dmqBlZORo6xkna1SQZNWnh7gIqmqfGnWzllab4a+coSEgs5HsuSgjasJmmzUyHWUoW
         qnAF7tjpi67dVUFjYCXvIQpobXCBawdeoyO2vbhcu1f+FyJl9pHKW52n/YEsjvK8jrPu
         mnuIrbjDmxSa6Uyo+bKu4QJq1DoRwwoN0WMk1ODbUPFm5eMdn/XsW4X1WdE99oaFUZrj
         4SWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712941088; x=1713545888;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FJWVQnWLX/pkislYxbbN5qnILpyF7P63m18zWA+EsbY=;
        b=ZvPwDMuRWyMmtHr+LaDnuDpXk9Opgg6mhatStD/M+N3fqykPRyZGF5PGh6obWCJxCi
         BmgHFy6FqAp2F2UonIGNTqvHLKQm9GfPrVl1LzxjwmKz5KJxDU2UzWlu2m0pMvPAjwEQ
         8GgmYJFIoQRjwaOwJp2HS7zbVC9JHyyv5ni1FszLLDxhtL7j7EqmFBoMeR+S6DtJLYzK
         TeA2ZxFeQ012FI/71SpSJmq3CfDhxWOVumnHPs68xVBNwT0+Gc7y3sxuLcn8M0fhJNWZ
         7mgmR+wNpH/YSEHSM1lTN3sg4ze4hQxCz1auLOvhKv842jZAYC+//mDpd3/5KXorLV3q
         wuwg==
X-Forwarded-Encrypted: i=1; AJvYcCVfsXGT7niilFxJtejC7VTnBI83zPaeBTnxMVH3WfXIZeT8Obc6hP7IBmUwPrT1Jl6rH/qJMLSA8mRinB8XSLln4vSsi5j+mtzBRgoQ
X-Gm-Message-State: AOJu0YxbD67NjQABtcfp6qiXhZXmzl6lfCXEXEf2f9gmlcNHdDHYkFeL
	kZa6lyWwEuGiSVrYie8Lq23yA8bCaytcEosKG0vnCLmXSL8atykB+/zzdMMxZQI=
X-Google-Smtp-Source: AGHT+IGPCmN3W2HTZ0QmJ+6REUIlwbvOotgDE2tr5rxL5ipmW/2VnsTgQx/xnNwczxd72R2Uusa6Og==
X-Received: by 2002:a05:6a20:5648:b0:1a7:4b6f:7934 with SMTP id is8-20020a056a20564800b001a74b6f7934mr3088514pzc.17.1712941088421;
        Fri, 12 Apr 2024 09:58:08 -0700 (PDT)
Received: from ghost ([2601:647:5700:6860:121b:da6b:94f1:304])
        by smtp.gmail.com with ESMTPSA id a26-20020aa7865a000000b006ea8ba9902asm3085131pfo.28.2024.04.12.09.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 09:58:07 -0700 (PDT)
Date: Fri, 12 Apr 2024 09:58:04 -0700
From: Charlie Jenkins <charlie@rivosinc.com>
To: Conor Dooley <conor.dooley@microchip.com>
Cc: Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Evan Green <evan@rivosinc.com>,
	=?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 06/19] riscv: Extend cpufeature.c to detect vendor
 extensions
Message-ID: <ZhloHGxa5jRRR9xg@ghost>
References: <20240411-dev-charlie-support_thead_vector_6_9-v1-0-4af9815ec746@rivosinc.com>
 <20240411-dev-charlie-support_thead_vector_6_9-v1-6-4af9815ec746@rivosinc.com>
 <20240412-sprawl-product-1e1d02e25bca@wendy>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240412-sprawl-product-1e1d02e25bca@wendy>

On Fri, Apr 12, 2024 at 01:30:08PM +0100, Conor Dooley wrote:
> On Thu, Apr 11, 2024 at 09:11:12PM -0700, Charlie Jenkins wrote:
> >  static void __init riscv_parse_isa_string(unsigned long *this_hwcap, struct riscv_isainfo *isainfo,
> 
> > -					  unsigned long *isa2hwcap, const char *isa)
> > +					struct riscv_isainfo *isavendorinfo, unsigned long vendorid,
> > +					unsigned long *isa2hwcap, const char *isa)
> >  {
> >  	/*
> >  	 * For all possible cpus, we have already validated in
> > @@ -349,8 +384,30 @@ static void __init riscv_parse_isa_string(unsigned long *this_hwcap, struct risc
> >  		const char *ext = isa++;
> >  		const char *ext_end = isa;
> >  		bool ext_long = false, ext_err = false;
> > +		struct riscv_isainfo *selected_isainfo = isainfo;
> > +		const struct riscv_isa_ext_data *selected_riscv_isa_ext = riscv_isa_ext;
> > +		size_t selected_riscv_isa_ext_count = riscv_isa_ext_count;
> > +		unsigned int id_offset = 0;
> >  
> >  		switch (*ext) {
> > +		case 'x':
> > +		case 'X':
> 
> One quick remark is that we should not go and support this stuff via
> riscv,isa in my opinion, only allowing it for the riscv,isa-extensions
> parsing. We don't have a way to define meanings for vendor extensions in
> this way. ACPI also uses this codepath and at the moment the kernel's
> docs say we're gonna follow isa string parsing rules in a specific version
> of the ISA manual. While that manual provides a format for the string and
> meanings for standard extensions, there's nothing in there that allows us
> to get consistent meanings for specific vendor extensions, so I think we
> should avoid intentionally supporting this here.

Getting a "consistent meaning" is managed by a vendor. If a vendor
supports a vendor extension and puts it in their DT/ACPI table it's up
to them to ensure that it works. How does riscv,isa-extensions allow for
a consistent meaning?

> 
> I'd probably go as far as to actively skip vendor extensions in
> riscv_parse_isa_string() to avoid any potential issues.
> 
> > +			bool found;
> > +
> > +			found = get_isa_vendor_ext(vendorid,
> > +						   &selected_riscv_isa_ext,
> > +						   &selected_riscv_isa_ext_count);
> > +			selected_isainfo = isavendorinfo;
> > +			id_offset = RISCV_ISA_VENDOR_EXT_BASE;
> > +			if (!found) {
> > +				pr_warn("No associated vendor extensions with vendor id: %lx\n",
> > +					vendorid);
> 
> This should not be a warning, anything we don't understand should be
> silently ignored to avoid spamming just because the kernel has not grown
> support for it yet.

Sounds good.

- Charlie

> 
> Thanks,
> Conor.
> 
> > +				for (; *isa && *isa != '_'; ++isa)
> > +					;
> > +				ext_err = true;
> > +				break;
> > +			}
> > +			fallthrough;
> >  		case 's':
> >  			/*
> >  			 * Workaround for invalid single-letter 's' & 'u' (QEMU).
> > @@ -366,8 +423,6 @@ static void __init riscv_parse_isa_string(unsigned long *this_hwcap, struct risc
> >  			}
> >  			fallthrough;
> >  		case 'S':
> > -		case 'x':
> > -		case 'X':
> >  		case 'z':
> >  		case 'Z':
> >  			/*
> > @@ -476,8 +531,10 @@ static void __init riscv_parse_isa_string(unsigned long *this_hwcap, struct risc
> >  				set_bit(nr, isainfo->isa);
> >  			}
> >  		} else {
> > -			for (int i = 0; i < riscv_isa_ext_count; i++)
> > -				match_isa_ext(&riscv_isa_ext[i], ext, ext_end, isainfo);
> > +			for (int i = 0; i < selected_riscv_isa_ext_count; i++)
> > +				match_isa_ext(&selected_riscv_isa_ext[i], ext,
> > +					      ext_end, selected_isainfo,
> > +					      id_offset);
> >  		}
> >  	}
> >  }



