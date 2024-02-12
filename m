Return-Path: <linux-kernel+bounces-62162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EFDB851C7C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 19:09:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3443A1C21442
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 18:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64FDB41202;
	Mon, 12 Feb 2024 18:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="ptV7i8BC"
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366C540C03
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 18:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707761375; cv=none; b=Qb7fQfGiD09nj/MwLX0mz771aqADTHMr07Fj98DetmVgrxILzaEwqgNNwjY83DT7h01oB0RXI6HX5Jllep4k/UJ4EGpm5GVCL0r1opJGivoPVeOBgHmdBN0mF+u6e6iBHuYjeBfqlIxUEbFkA+D2YeodikCuBk57uOrAa+pwWwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707761375; c=relaxed/simple;
	bh=gRuSKBOYTpOhumtH7yjdK5bdWFyLj8VQskN97z+Bwi0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MBEl31ZWtW5erX1XlWjnrpU8doiQq53h5PiBR1LDIMnAGlwcZc9XElc7hwd30DqKQaFsRsI26vpKS4hWFaMvJfaOxiNB88Va4a83czIbB1HN1jW+YzIJgFNpGPzuWeaXyWyxaystaPN1Gr7fKSBPZkDWS5ek0eoI3pA53zm0tl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=ptV7i8BC; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-60757c46e34so913317b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 10:09:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1707761372; x=1708366172; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LgHEWN/9ibe7PSimy9tUv0TwC6oTt5ihEg494Xlo1nQ=;
        b=ptV7i8BCGWZGY6RSKiFzmSp7Bv+hDijTEVUBnsHI9hy1e2eafk9HtAadDIAJr7MRCe
         7qX//h0FafbzSOsYTsMHJkhh6qyu4itU0epwhkd+Boyx+WHWNmaiuXU9O8u5Zy+Kyi/J
         +qw2HoX8y522KmtfGpHJVwasdRQQTrXG31bTf6+YOyUDf2cs9be0bJIOQ6042otGkNJc
         cx/gmhtZmkFlXmLBBF2InpQjwOxSr+NU2FVCz+uDH8ToV2rKecZg28+yqKjmVNMVynMX
         wMQUdJqjQmJFmxDpGoUlrve3XKkRvNeX9tUSwnEOwbBXoKs5JwY/punsdsbG5HaJfDk6
         gaWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707761372; x=1708366172;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LgHEWN/9ibe7PSimy9tUv0TwC6oTt5ihEg494Xlo1nQ=;
        b=AJtrtphv/OgCkVttYp35W8ZaHZ9UX9hPuP2xheV8FaxdKo3uKCis61J7/6R6/1mUb9
         9+c2oQC1F1K+LRlVDU5rk/cLNqwplfUWlapgnklgLOdj70syIZnhEB0edA10NEgn7hU9
         iceVPR9+F5/bQyJmINWSV13yPcxiZVm12ZMv8RRHkJn/W8Jf//ji/toPorUTsWOd2GkT
         sAtAbhu6EIgJgaQebIn1FZAtU+oVlnVuE0txe7LfCkVjorzF0uBME1PW7qCTo+7KkZAO
         tXll2GHvTfBSHoRx/FW63hDvDQ95+zCbEr4Hk0c5uUpn3QQGoWt7UT9xshpYsexkVxC4
         /3yQ==
X-Gm-Message-State: AOJu0YxwZfiYd21MJHDLx7kRHC3UW6QADt9WwFj4IDpqU/fS5qebHiCM
	/XuquooVmR5AyHBhK1DnBDYpN0QfM2diV77q5KVvdZlQynHFUpHdgG82TH/Vqus=
X-Google-Smtp-Source: AGHT+IF4NH6hubgV3ijWRgRsPLEYf8DbaMN2+BpEJqS/wrIO4Mnpt332eRpqriYqg10EkROXVZ3kYQ==
X-Received: by 2002:a05:690c:428c:b0:604:dd57:7845 with SMTP id gj12-20020a05690c428c00b00604dd577845mr4496765ywb.2.1707761371992;
        Mon, 12 Feb 2024 10:09:31 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUb2VbWgM3lFMkGXCcqUUy8SUWKynyGXZZcdaarGyjT6833ChZ1134evE2E8uQjdAVTpI1XSfSiDkYi8+VqoBNtzjuUKfy+0xOf5M92SQYTtg98wqsxP+Y5y55SvPglYY31WwYsk6vRA+pmTTG/e9ibyLEYnPkb6NYhIIlY4bs4aKtQMMm0nBmP6/09YFmVvFCZ+kZK
Received: from ghost ([50.146.0.2])
        by smtp.gmail.com with ESMTPSA id i5-20020a0ddf05000000b0060484467cddsm1286447ywe.32.2024.02.12.10.09.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 10:09:31 -0800 (PST)
Date: Mon, 12 Feb 2024 13:09:29 -0500
From: Charlie Jenkins <charlie@rivosinc.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	David Laight <David.Laight@aculab.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/2] lib: checksum: Use aligned accesses for
 ip_fast_csum and csum_ipv6_magic tests
Message-ID: <Zcpe2ZthpFf1BVGg@ghost>
References: <20240207-fix_sparse_errors_checksum_tests-v6-0-4caa9629705b@rivosinc.com>
 <20240207-fix_sparse_errors_checksum_tests-v6-2-4caa9629705b@rivosinc.com>
 <20240212062614.GI608142@ZenIV>
 <52393411-8313-4e94-9618-916b57f7d52e@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52393411-8313-4e94-9618-916b57f7d52e@roeck-us.net>

On Mon, Feb 12, 2024 at 09:18:14AM -0800, Guenter Roeck wrote:
> On Mon, Feb 12, 2024 at 06:26:14AM +0000, Al Viro wrote:
> > On Wed, Feb 07, 2024 at 04:22:51PM -0800, Charlie Jenkins wrote:
> > > +	struct csum_ipv6_magic_data {
> > > +		const struct in6_addr saddr;
> > > +		const struct in6_addr daddr;
> > > +		unsigned int len;
> > > +		__wsum csum;
> > > +		unsigned char proto;
> > > +	} data, *data_ptr;
> > 
> > Huh?
> > 
> > > +	int num_tests = MAX_LEN / WORD_ALIGNMENT - sizeof(struct csum_ipv6_magic_data);
> > > +
> > > +	for (int i = 0; i < num_tests; i++) {
> > > +		data_ptr = (struct csum_ipv6_magic_data *)(random_buf + (i * WORD_ALIGNMENT));
> > > +
> > > +		cpu_to_be32_array((__be32 *)&data.saddr, (const u32 *)&data_ptr->saddr,
> > > +				  sizeof_field(struct csum_ipv6_magic_data, saddr) / 4);
> > > +		cpu_to_be32_array((__be32 *)&data.daddr, (const u32 *)&data_ptr->daddr,
> > > +				  sizeof_field(struct csum_ipv6_magic_data, daddr) / 4);
> > > +		data.len = data_ptr->len;
> > > +		data.csum = (__force __wsum)htonl((__force u32)data_ptr->csum);
> > 
> > What are those cpu_to_be32() about?  Checksum calculations *DO* *NOT* involve
> > any endianness conversions.  At any point.
> > 
> > Replace those assignments with memcpy() and be done with that - that will take
> > care of unaligned accesses.
> > 
> > Result will have host-independent memory representation.  The only place where you
> > might want to play with byteswaps (only 16-bit ones) is if you initialized the
> > array of expected results with u16 constants.  That will have opposite memory
> > representations on l-e and b-e, so you'll need to byteswap to compare with
> > what you get from function.  Alternatively, make it an array of bytes and
> > do
> > 	sum16 = csum_ipv6_magic(saddr, daddr, len, proto, csum);
> > 	if (memcmp(sum16, expected_csum_ipv6_magic + i * 2, 2))
> > 		complain
> > 
> > That's it.
> 
> Almost. Turns out the csum parameter of csum_ipv6_magic() needs to be in
> network byte order, and the length parameter needs to be in host byte order.
> So instead of
> 	data.len = data_ptr->len;
> 	data.csum = (__force __wsum)htonl((__force u32)data_ptr->csum);
> it needs to be something like
> 	data.len = ntohl(data_ptr->len);
> 	data.csum = data_ptr->csum;
> 
> Also, as you mentioned, either the returned checksum or the expected
> checksum needs to be converted for the comparison because one is in
> network byte order and the other in host byte order.
> 
> Address conversions are indeed not needed.
> 
> Thanks,
> Guenter

Aww that makes sense thank you. I was reversing everything except len
and the solution was to only reverse len... Thank you for figuring that
out for me.

I will send out another version with your change. Should I add a
signed-off-by with your tag for this patch?

- Charlie


