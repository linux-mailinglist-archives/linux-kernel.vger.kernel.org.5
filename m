Return-Path: <linux-kernel+bounces-160696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B0B1C8B413D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 23:32:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 132F5B22342
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 21:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28A7E38DF9;
	Fri, 26 Apr 2024 21:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="wZwUszsK"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4032038DC0
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 21:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714167043; cv=none; b=FSYFZHV464blv8qsWk9Winnl2EK43iJzLZkk56aYYo2LqxAHbHfIptpR1dzHZMQqhhgxWiRm1W1p98q+RGdgQxojlQnMKB8GhL+bO2jj1HscSBiVD2BA41lV6HNAqP2ndJpuftiUFHj5qs9GBliw4SfNGjTqG+jHgqNWkoARO8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714167043; c=relaxed/simple;
	bh=4IW4rnhNZePeFIrf82Vd39slgc2j2xg72o/4HCVwEDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mMUSmRIBZjsvQ5PwnYV06mNiT6Qd+FKCZ6VkYP3J+17M86n+4fXeELYFGsPlGtJ8KeVrF7r7Yunu86jyYd1MDaooqNG14U9i3sLV5h0EoJhgU5A0CeOACAOsiVrrs81WCUywG2q3arCEa1rauqD/2mBcB2N7EZ+Y6o+y3WQV2X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=wZwUszsK; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1e3e84a302eso21066675ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 14:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1714167042; x=1714771842; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/H8e5hlV+/I4+TPtXJEmnSVpBl2vd7RDe12C8rr7Cys=;
        b=wZwUszsKUJiO/KIl4+TmYPfVdLG0ao/ZLmrIEAEPzaHrrps/0WbTtTnoSrxnk5yRgz
         H9AW80Bg6rbYh6ba43PdvqkLYuhwuUOWRduG0uwnvQLn52ELto2tiiqAildU1CHWZhMq
         Jqe/vmT/2pTn+fhxV+PPbbE+R1TuVCh/ongPX8J9qLYwNfapunv1bc+O1RL+BoHiYeMy
         XHyvHBpGJZahWfyRe7JdwR1vUlPCnNA5VTscqBq5Gpy9h0yVzWt74TNCGcSS/qGAU5by
         PhXnRFzugKh0h77XXNUGX7q+D83nxgiy5r7uCBLN4tcpg4jsYJaRo/AqI/N/mZdWDuCj
         DXvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714167042; x=1714771842;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/H8e5hlV+/I4+TPtXJEmnSVpBl2vd7RDe12C8rr7Cys=;
        b=sS2QduEZ1shSwzGcaZc4Uon870djW6JixefjAkAzUegUZaDu+59iH89GR7dWlL+LZx
         411RU5GpYP7QEROPEA9T44zXS0NR416JP7BrpbmGq2fdHNaoicaCe5+J5uo4Ly6Pm4+m
         ebzScCbsJUcGcYrBgRg/WN0KxgXHBChx5G0eA/o8Tu4Bx1sl4FkfY8Ywmf39fs6ppOkK
         ARuqghSO6A7rdLcuC7LS45tLVyOYicCUbeiBb50q8cXLDkqbY9YH3U+SslaRPqFRIxvJ
         osfDWjitSzsDl6IfwBIZjkzJC6P1rixyoEgtJ4X5jp5bB94BTrdgcJzcz16QxGlLbQs9
         3cpg==
X-Forwarded-Encrypted: i=1; AJvYcCWPO6MejtXLnpZchEe5jIu31WfKipiCp+Y0uCE9tZ/YhZLp0JvLOfV0yHUw44zOtIVlgbZEC7mRy4TyWiHU0XxpxOjas9pnlPfOZ4pk
X-Gm-Message-State: AOJu0YwNIzHXkzztTPQ7SeMkqJz7+95XrALTo5XdkhUBAsvl4bKKOg39
	ncpKv7e3nvOqZUsEN3ZAEP9g0/M3tTUBr3EH9I9XI499TyrJWjqngCqMGMac07A=
X-Google-Smtp-Source: AGHT+IG6SE8OrSd9ojcqff1UuWL+xPFCFrexq7q4C0vjAZm0SbmrYw9oyQfoJcf054h7/OJCN6VARw==
X-Received: by 2002:a17:90b:4c85:b0:2b0:b535:4721 with SMTP id my5-20020a17090b4c8500b002b0b5354721mr1533883pjb.1.1714167041775;
        Fri, 26 Apr 2024 14:30:41 -0700 (PDT)
Received: from ghost ([2601:647:5700:6860:3b15:3aba:70a1:7ce9])
        by smtp.gmail.com with ESMTPSA id s4-20020a17090aa10400b002a54632931bsm16694006pjp.23.2024.04.26.14.30.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 14:30:40 -0700 (PDT)
Date: Fri, 26 Apr 2024 14:30:37 -0700
From: Charlie Jenkins <charlie@rivosinc.com>
To: Andrew Jones <ajones@ventanamicro.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
	Conor Dooley <conor@kernel.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	=?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>,
	Evan Green <evan@rivosinc.com>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] riscv: cpufeature: Fix thead vector hwcap removal
Message-ID: <Ziwc/SnWVITvsFgZ@ghost>
References: <20240424-cpufeature_fixes-v1-0-585e73d2226b@rivosinc.com>
 <20240424-cpufeature_fixes-v1-1-585e73d2226b@rivosinc.com>
 <20240426-d8aba0211e882568ccc761df@orel>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240426-d8aba0211e882568ccc761df@orel>

On Fri, Apr 26, 2024 at 11:02:30AM +0200, Andrew Jones wrote:
> On Wed, Apr 24, 2024 at 09:19:54AM GMT, Charlie Jenkins wrote:
> ...
> > +	/*
> > +	 * Naively assume that all harts have the same mvendorid/marchid as the
> > +	 * boot hart.
> 
> This comment isn't necessary, since we don't have to assume all harts have
> the same IDs. This information is currently being collected specifically
> for thead. So, we can state in a comment below, where the information is
> used, that we assume when the boot hart is thead, then we don't want to
> enable V on any hart (whatever their IDs are).

Yes you are correct, I will do as you suggest.

- Charlie

> 
> Thanks,
> drew
> 
> > +	 */
> > +	boot_vendorid = riscv_get_mvendorid();
> > +	boot_archid = riscv_get_marchid();
> > +
> >  	for_each_possible_cpu(cpu) {
> >  		struct riscv_isainfo *isainfo = &hart_isa[cpu];
> >  		unsigned long this_hwcap = 0;
> > @@ -544,8 +553,7 @@ static void __init riscv_fill_hwcap_from_isa_string(unsigned long *isa2hwcap)
> >  		 * CPU cores with the ratified spec will contain non-zero
> >  		 * marchid.
> >  		 */
> > -		if (acpi_disabled && riscv_cached_mvendorid(cpu) == THEAD_VENDOR_ID &&
> > -		    riscv_cached_marchid(cpu) == 0x0) {
> > +		if (acpi_disabled && boot_vendorid == THEAD_VENDOR_ID && boot_archid == 0x0) {
> >  			this_hwcap &= ~isa2hwcap[RISCV_ISA_EXT_v];
> >  			clear_bit(RISCV_ISA_EXT_v, isainfo->isa);
> >  		}
> > 
> > -- 
> > 2.44.0
> > 
> > 
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv

