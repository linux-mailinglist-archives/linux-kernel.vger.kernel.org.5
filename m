Return-Path: <linux-kernel+bounces-165723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 161608B9039
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 21:48:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47BE01C20924
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 19:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65BA716191B;
	Wed,  1 May 2024 19:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="iwWN7QxB"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6117C16132E
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 19:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714592899; cv=none; b=AgzoZfnutO41QxCP5Zbb1Ecn6DfOTdfePtVldqFBS33vMuO2x0ljqRhjKrIjbXx7tKXyvg3Xxx1M8LWJIerix8yLbUi+z91pBP43rNZKzOYKL9TpK0tf63U7FGS3tDAGYIgRUsu+XgkeWIUx0NDNlCPeEGE93pLTxBi+z/yaVZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714592899; c=relaxed/simple;
	bh=0xusBx4mvpGkzkWD4XBTeQoGUcYyDndMqcZwmTR7iPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XwchsWL1R7We7fXi7GgV1OY4gufJaDEXSZPeAMQjtYebH38XsgpDbu7kBi8L+wJcUi0gQYN5YGJBTB1hms8P0u4IFBJ0O/BeQdF9zq8iUUUjh3T9DrCkbhYfOOc/dzN7d+BuphzSeWd2C/pEHPomEC67iK2hVkOtUcbidJxxQls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=iwWN7QxB; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1ec92e355bfso9847295ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2024 12:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1714592897; x=1715197697; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JtC8dm20imTdKCQqTW5smBrp6Y6uvCPu1xFL49hxPB8=;
        b=iwWN7QxBz4DTHm1qm4OvpmvNaVrshOl+oNlLUJKpgpYips6mizmNWeGngZ7RT2SCYn
         6kyWULXJJiRSqRABB3YLom9mKVl7O1GRH3fO9iv+zXLQZvX8IujkF5/OkVWuuIxYIvHk
         czSTItxHcV3PGWm9icjiVq4AXktjZRr5Kg93KsO6cUnLQ2Jc5ZldYY/TJ7lZNBsay4yN
         104GtD7bPaL5esKEKFEBLc2v7xelq7wUgkZrgAtJs7G50S0j5ehcLdzzk9mP//qrHDox
         kvR0sCoMr2n5O61swCfODCxdsx5HGrewfmkIb63uTPTpCi4pYISkNFaS/0d+8/TuLx3b
         8NGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714592897; x=1715197697;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JtC8dm20imTdKCQqTW5smBrp6Y6uvCPu1xFL49hxPB8=;
        b=sxB5jjRDQ8A75/KsgeBD7qXyFRuEHtXPy8T3nxCN+3t/iSwlSoD56MHX7FQbw4LcL0
         hKBso9be9UCaAcQjF8qORqMk1gQNh77SzL5mqCxz5Rh5+4iL9Sv94g7i1u5bOv1PuXsD
         +ZfCJQEATsdMFjN9ZFVVrxONPgg9s/kb+k7tY0t7heUsqfaC77qFtZafC8cFuUyGXkYv
         Z2mGMUSRu+ldgFX3IzFpju9RM+15ZSS8C7aeZxiygqsgCB65tXPTppvy9QkZpOjbq9wc
         nJYMmgs8K6kPLxGyryR4SiYOKkRGYObtgaedrKr0qWQ1CkTBKdM1XzNMxxvTfzLTGTtr
         ngag==
X-Forwarded-Encrypted: i=1; AJvYcCUHWk6p0n6SXejON5prg0F1/BH4IbclAAKtxT2hOTSf5S+JHwJgl62H6K7tzYQ9mfutY4/IFOgln6XGhYGCnLh2Z7sMq/yDiwBXPsuS
X-Gm-Message-State: AOJu0YzjEdfIBk+O2Mbw5DPGXsxYJkoIPlPGeCYSr/jntiDYfFIjH2uM
	B0ggU3+qq4LCK1JGBUFyY7ObzanCE9KG3A39nqKSB5GMuyZyGa6X36L7nkqjLLw=
X-Google-Smtp-Source: AGHT+IHqE9T7lF1XvjCAtRw9iaYnvm5Bt1x7gAa4owqnGBOgOTMkA2A37jDPqx0fFTLOHQocKAXYtQ==
X-Received: by 2002:a17:902:d506:b0:1eb:2fa0:c56f with SMTP id b6-20020a170902d50600b001eb2fa0c56fmr4034243plg.35.1714592897320;
        Wed, 01 May 2024 12:48:17 -0700 (PDT)
Received: from ghost ([2601:647:5700:6860:1dcc:e03e:dc61:895d])
        by smtp.gmail.com with ESMTPSA id j10-20020a17090276ca00b001dd69aca213sm24321702plt.270.2024.05.01.12.48.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 12:48:16 -0700 (PDT)
Date: Wed, 1 May 2024 12:48:13 -0700
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
Subject: Re: [PATCH v4 07/16] riscv: cpufeature: Extract common elements from
 extension checking
Message-ID: <ZjKcfZsWgR1AY3AZ@ghost>
References: <20240426-dev-charlie-support_thead_vector_6_9-v4-0-b692f3c516ec@rivosinc.com>
 <20240426-dev-charlie-support_thead_vector_6_9-v4-7-b692f3c516ec@rivosinc.com>
 <20240501-probable-unfunded-746ef6ae1853@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240501-probable-unfunded-746ef6ae1853@spud>

On Wed, May 01, 2024 at 12:37:14PM +0100, Conor Dooley wrote:
> On Fri, Apr 26, 2024 at 02:29:21PM -0700, Charlie Jenkins wrote:
> > The __riscv_has_extension_likely() and __riscv_has_extension_unlikely()
> > functions from the vendor_extensions.h can be used to simplify the
> > standard extension checking code as well. Migrate those functions to
> > cpufeature.h and reorganize the code in the file to use the functions.
> > 
> > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > ---
> >  arch/riscv/include/asm/cpufeature.h        | 78 +++++++++++++++++-------------
> >  arch/riscv/include/asm/vendor_extensions.h | 28 -----------
> >  2 files changed, 44 insertions(+), 62 deletions(-)
> > 
> > diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm/cpufeature.h
> > index fedd479ccfd1..17896ec9ec11 100644
> > --- a/arch/riscv/include/asm/cpufeature.h
> > +++ b/arch/riscv/include/asm/cpufeature.h
> > @@ -98,59 +98,66 @@ extern bool riscv_isa_fallback;
> >  
> >  unsigned long riscv_isa_extension_base(const unsigned long *isa_bitmap);
> >  
> > +#define EXT_ALL_VENDORS		0
> 
> It's not really "all vendors", it's standard. Otherwise, this seems all

This hooks up into the alternatives:

ALTERNATIVE("nop", "j	%l[l_yes]", %[vendor], %[ext], 1)

Where the "vendor" argument is supposed to be 0 if the alternative is
applicable to all vendors. Is there a better way to convey this?

- Charlie

> grand to me,
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> 
> Cheers,
> Conor.



