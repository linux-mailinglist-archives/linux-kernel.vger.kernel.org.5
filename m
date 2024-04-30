Return-Path: <linux-kernel+bounces-164592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3198B8B7FCB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 20:38:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60D3D1C228B6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 18:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE338180A7C;
	Tue, 30 Apr 2024 18:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="rnjMChfi"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3672F23C9
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 18:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714502299; cv=none; b=GBSbkiL/3UOME+DLLMERh88MzsM+XQkgdEVZoNbwOqrbBEW2EipAI9MHtnkp0RONOwHfMgivC6vG4hiLGZmsLGTQHYtjiMDGCO04fbdPJLSB+kIJ2gtv+UlenNJfTFyc3TEq43o/+RGf+tqBHMonhL/3AlhjqZGB3RqaWSSHmnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714502299; c=relaxed/simple;
	bh=EHewurBx2AMPQUT06vASr1weugukBXU7zjHEuhuZQ6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WT5c4LHi7bK6shFnbKc4R7lYzRDk9lmHU5RGcDU8iIy9ElXLWEQx4/05euFGRdRTIqjW/cr0l7dkqxZhzlKNK6g3Miy5B2k+CTLErhfYtwf8nxmaF291ySETuuRKmBRvSMYC9YkhnTb0oODW+Ric6W6zIYZd4Y2YhwgUyMdzwlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=rnjMChfi; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6f074520c8cso5821694b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 11:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1714502296; x=1715107096; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+xFFNyvJRBStVKiZvJgpzL4WEEIzaE/N0wvWYH0AAbU=;
        b=rnjMChfibWDiLohflxwp9S+1eFUkG2w6M1RpCnqZqc/pNgcXaFYWB5ntCoeUkxWaSA
         0Jh4VYqB0iZNJT7j56iAUHnUxpTNYCk94BIcw6QxaallfHX/4QM4vhgr4r6geFH6DRj4
         k1TDzanAAvYC/b4u7cWu7+pugucQEzfDrFJ/01TtNjD+vZLN7m0061e3ZRr5m9BnedMB
         OMVTgpJ72UZiT/MUk7MuwUdblKKaaEodl7V6RS0sYY9v9jQHR/hD/U0d3vhEKWqqxHCe
         kUMrALVduOq6uxhQC7ipfF0wWb+6zpc5QKcOrvEryMiJ50IIthF/pk6HSZ3YkjPBBwPO
         9SbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714502296; x=1715107096;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+xFFNyvJRBStVKiZvJgpzL4WEEIzaE/N0wvWYH0AAbU=;
        b=K9J1zcj4w8+EBJ7giQB5Dt0+2Ho+fgzH9Rr9cuxFSPQDS5O1y1w37K/Acm+QqY9eJm
         8EBz4Y0IKshdumR8rWebQUekjujCNfIjEk45imGZnR7jXBuW1kylwmuYva2/Q1mNB0y7
         gRILjfknuOLMXorDOnqMnBxf/g8qxmN0nVQ6G/NgTDL85nQekGXZjonnPHCGqiQF3Lsc
         xSQw1qTzdXu3P6l+Cj/wDwtjDNoJSzp2sjgL9N63ZQO4ppysS/hbOEfhYFyEFUp0Xxk+
         AyFOM/daoZydVfHsp0jPvPsF1oHIXeTDM04HTOTNUcVEpzZ4lHxucEzE5A3/ZzE0HLCC
         KQrA==
X-Forwarded-Encrypted: i=1; AJvYcCVnsj7jcq2/Jc/2BLAHX+MaMq/jY6yaiIgg0YoHLhTE0S629dWhqeJ/LuLG16MuVuP/LEy9fNLPwkit5T24M3owlp4gKMWggfBIqNTZ
X-Gm-Message-State: AOJu0YxvUN2JNYiH4tQd4uOSF/CxikQh+8mE1EV30rmsAh1/QSqKQlc9
	LbI9z8z9xI+GSjAMKbg83rNWY48sCOPcKoYW0jvb+lozEzLMS8g2RedOLgtV2jc=
X-Google-Smtp-Source: AGHT+IEAb8YNwNMBc7V5kulQjE/hD4v1bwrN1gT1wqu/osrvWEeW+ChqYczlkXqTDwcnz+KuEOG2gw==
X-Received: by 2002:a05:6a20:3d8c:b0:1a9:c4cc:721d with SMTP id s12-20020a056a203d8c00b001a9c4cc721dmr879056pzi.57.1714502296448;
        Tue, 30 Apr 2024 11:38:16 -0700 (PDT)
Received: from ghost (mobile-166-137-160-039.mycingular.net. [166.137.160.39])
        by smtp.gmail.com with ESMTPSA id r16-20020a056a00217000b006ed87983f95sm21338288pff.52.2024.04.30.11.38.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 11:38:15 -0700 (PDT)
Date: Tue, 30 Apr 2024 11:38:12 -0700
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
Subject: Re: [PATCH v3 1/2] riscv: cpufeature: Fix thead vector hwcap removal
Message-ID: <ZjE6lAMy/6+HAB4X@ghost>
References: <20240429-cpufeature_fixes-v3-0-6aa11dde513b@rivosinc.com>
 <20240429-cpufeature_fixes-v3-1-6aa11dde513b@rivosinc.com>
 <20240430-6781cbaa0a929246cb77dafd@orel>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240430-6781cbaa0a929246cb77dafd@orel>

On Tue, Apr 30, 2024 at 12:07:26PM +0200, Andrew Jones wrote:
> On Mon, Apr 29, 2024 at 03:29:51PM GMT, Charlie Jenkins wrote:
> ...
> > +		 *
> > +		 * Disable vector if the boot hart has a T-Head mvendorid and an marchid of 0.
> 
> I probably would have added the 'why' to this comment, i.e. T-Head doesn't
> have standard V so things will break if we try to use it, or whatever. The
> 'what' alone is just putting the easy to read condition below into
> English, making it an unnecessary comment.

The 'why' is directly above this comment. I'll just get rid of this
addition.

- Charlie

> 
> Thanks,
> drew
> 
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

