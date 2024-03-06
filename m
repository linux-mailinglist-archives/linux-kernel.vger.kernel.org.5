Return-Path: <linux-kernel+bounces-94403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F64D873EDF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 19:28:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01B19B20DC3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 18:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A779513EFFF;
	Wed,  6 Mar 2024 18:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="AxsmY1NC"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508E1145353
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 18:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709749512; cv=none; b=lyWO+iQmjhGbgNJ1g8noB8dW9ZIm1/JculBJDTS0vX5749X44d2YCIMAJ/ioN3GYYTgr0gZr8LOwWp9tUQxcu/13F6+Sh03mSi9VPI616KWGTsQM0Sa7YegduLJzuV3GspbNXUI82skvmtqmYNu8xH04/nlGlHS1liuso4bgBW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709749512; c=relaxed/simple;
	bh=6QmO9SZfOYGCQNYv4ZynnxE5IKMUsPX/PaEUiiJ1CpM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZdB7lGtlNL4v2fI6X7V0EnVNpxwndE4a6MDUjEL+Ako0cVQK+Ps72+DvJWLCvrYA1bijBR9eGhZDU0zPW6gaCqedNC/CEKX6sa8eyRFKpROx/8SfGgOEVURxWYodubw397Owd1SEgTLlcIAHn4aR3bgpyZtfQAIs5AuWRaxoF+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=AxsmY1NC; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6e5760eeb7aso15464b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 10:25:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1709749509; x=1710354309; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2Y5GuVIgcMEMa1wdjCxyxHdeavu9gb67/KgkXVHvPFs=;
        b=AxsmY1NC9fuaUQo1Br5pKJHLR38CTsfblqW1GsR4i8zDylW1c0UI3m3754PzQ+2hqW
         3uQCoP+fvV5ck+lnuWdTfWyrhFq14qC+8ei3NURS7FHfbRWGaacIz9lLYpNB0r+Vipdo
         5Aowlhr/2xNhjl6alyczQ1DPjillipWYnniZy6ddIZVe8b+ckdmzI8kdf4d4XCG6a4Qd
         I01SYaBGcOMcvG9zhsobLnw+zDJkWFpujStHW9ijAWES2Q9UFmUHYiL4GeWx2ANHoRo8
         gsyMhxy3fyhdDDT5HchsVvpe22h/1ZvH9qGeNbSF7szNHWGWUb60tFn0lca1l9/7++lE
         JIhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709749509; x=1710354309;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Y5GuVIgcMEMa1wdjCxyxHdeavu9gb67/KgkXVHvPFs=;
        b=Q/+k0R7LGC4bV4nhc9kX0h4pq+lSBaS94Faqs+9csdYRS7GNaxahn+MQcwAvbehBGq
         gkRKezakznGGZEAzcjeYmtwCSjluiZkwjl4HSCrmPLqv6VX8QVbOYG2T9RiA+dte5Azr
         Zt+IeH3zVTI1Kl2QxiEUKp3UStw5f5DdJdJNJ+cfva19Sxp30sA44YpoNQ+6qcE0IBsk
         K6IMmSis3l2kQtUdyp/hjdLs33axUBaJQgfRwJ+HcxtxdzPzFGjca6CnoAXbC2hWXbOH
         BU3wREEJoA2IqXOQuwH13RL9bZOKkzUtDXlJf/kong7gqdPdfbr+TBjWAtu/MjJ84lKj
         IYFw==
X-Forwarded-Encrypted: i=1; AJvYcCVloCKT1katws2bQOEtvynpJqLbYNckbryFVFatdRaUORTg5Af/ODsF/xNjMIbXsJQ9BMrkHln8kVg4dryQhcYxrufrSy9x6HLbbbVZ
X-Gm-Message-State: AOJu0YxuJbQHHzFZm+AcHkYaUACrEE3MbnUY8jttObgch17AG+fOF3kM
	Q4yjaPz86qwo2iVTtZri3F38x6/r2L+hYM+QQqyJO8NImPNtsqUwHDtlCU0kGx8rTFi80VpqvgD
	kkvo=
X-Google-Smtp-Source: AGHT+IFzBSLMGaJ08Dnj/BOlVEgA32D3g8w6QsqRlEsrWvsKtK4rYL3jf902EvY1b1GzhFtzX6klyA==
X-Received: by 2002:a05:6a00:a86:b0:6e6:5374:411a with SMTP id b6-20020a056a000a8600b006e65374411amr1699696pfl.18.1709749509245;
        Wed, 06 Mar 2024 10:25:09 -0800 (PST)
Received: from ghost ([2600:1010:b05d:dc52:3fa4:a88f:2bde:e9a])
        by smtp.gmail.com with ESMTPSA id f17-20020a63e311000000b005dc4da2121fsm11201406pgh.6.2024.03.06.10.25.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 10:25:08 -0800 (PST)
Date: Wed, 6 Mar 2024 10:25:05 -0800
From: Charlie Jenkins <charlie@rivosinc.com>
To: Conor Dooley <conor.dooley@microchip.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Jisheng Zhang <jszhang@kernel.org>, Evan Green <evan@rivosinc.com>,
	=?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>,
	Eric Biggers <ebiggers@kernel.org>,
	Elliot Berman <quic_eberman@quicinc.com>,
	Charles Lohr <lohr85@gmail.com>, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 3/4] riscv: Decouple emulated unaligned accesses from
 access speed
Message-ID: <Zei1Ac8RKNJu01Fs@ghost>
References: <20240301-disable_misaligned_probe_config-v6-0-612ebd69f430@rivosinc.com>
 <20240301-disable_misaligned_probe_config-v6-3-612ebd69f430@rivosinc.com>
 <20240306-tactless-decathlon-b0df16517b1b@wendy>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240306-tactless-decathlon-b0df16517b1b@wendy>

On Wed, Mar 06, 2024 at 01:19:37PM +0000, Conor Dooley wrote:
> On Fri, Mar 01, 2024 at 05:45:34PM -0800, Charlie Jenkins wrote:
> 
> > -void unaligned_emulation_finish(void)
> > +bool check_unaligned_access_emulated_all_cpus(void)
> >  {
> >  	int cpu;
> >  
> > -	/*
> > -	 * We can only support PR_UNALIGN controls if all CPUs have misaligned
> > -	 * accesses emulated since tasks requesting such control can run on any
> > -	 * CPU.
> > -	 */
> 
> Why was this comment removed? This patch doesn't change the situations
> in which PR_UNALIGN is allowed, right?

I'll add it back, that was unintentional. Thank you.

- Charlie

> 
> > -	for_each_online_cpu(cpu) {
> > -		if (per_cpu(misaligned_access_speed, cpu) !=
> > -					RISCV_HWPROBE_MISALIGNED_EMULATED) {
> > -			return;
> > -		}
> > -	}
> > +	for_each_online_cpu(cpu)
> > +		if (check_unaligned_access_emulated(cpu))
> > +			return false;
> > +
> >  	unaligned_ctl = true;
> > +	return true;
> >  }
> 



