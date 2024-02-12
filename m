Return-Path: <linux-kernel+bounces-62205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6EA8851CFE
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 19:41:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BFAA1F220E6
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 18:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCFEF41233;
	Mon, 12 Feb 2024 18:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="gynNsN1O"
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13BD941206
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 18:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707763293; cv=none; b=ppAXmJFHbJJgZnoMh0+nc/rCFGCsx3NI55Essu1qMCH7d15Vk9BTlJKWpWmfD0mN0HvSBq4kYYdoxprNlIBo5e+gFz4M0xRv4GhGs6mrgggR6c+QREUJINDqPnjmUefA3y+YG0DGdpyK521LoanyYlFal1nYrC2ktk2cZXediCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707763293; c=relaxed/simple;
	bh=3Dt864qUNEbymlghTdrDS4OLQ1vHcnhvXcqDgliILAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BJnfOChDKi1atcVdn/2Wr1bDVrR7cOg9/q+RWGK83YDkxdpepLIRGmdVIG2hN7liq2pSicUJud2+rktxjhYbtO/9giYMRnVCYmKF2TTOzac3wbrku3c1rNvWplbVi/cTkQPVDSEdB3hL/lFpjAjpFceCYpUDLE/tF61hXKawUAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=gynNsN1O; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-604966eaf6eso32022177b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 10:41:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1707763290; x=1708368090; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hZ+z4h99xk76bC0VjnOkqFzJOKFwImGd/nxclb3UUVI=;
        b=gynNsN1OFvr4vbDYEZTsj4wi7hN0ZCAF/esKZbGrnXOqoKUQV63VXp9ZXn0apYABMO
         OVzE1BfoEygUkbh48DIFM3+uFHaYpPBzoxZisz14Ll7sfgIPAaEbRwm0WttP9LT6ExSA
         ahZ3KM0rYLM+NB03TNBMUSA5tgTj5vteYFsr68zmUho/bxeIoPXaCjM2STO2siJuNI22
         UT/pKeACGFTCu230PQzEI6cp/b9JZ6AzFX7B7P0hRj6nwR19c06KuUlx/TMLdlXpW4R8
         PyN3H6OmlVKL37KLV+gHAZMKNLtm6ay9ExdchSlGyH0LmItwVSTrorocGJwJZSZWxzi1
         BTww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707763290; x=1708368090;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hZ+z4h99xk76bC0VjnOkqFzJOKFwImGd/nxclb3UUVI=;
        b=m65QtlNsma63w52xyAWbGUxZRnBTP1ngmOEprQV9H2Ze7WU4kqcSf2sHKdLpcH2AOb
         1iuAflfo8UaH7XiIR4iOxzLvVuOiG3/uvWPI25o82kV6SVG5tU2HGoj1KKKEThmXmudt
         HAqKMZFWuTD33AlRRwKDIVpInDBJJsQ7c5WM2qUiwpALvJpn9matLlGcaMqU4uwl7Na8
         4USvAddMjTRsWiqMHGhmmqaWqRUeOcPhC+qB2q9980t4DUXQishxZGV4d80ZUsQgmDUX
         kqoBM9MS4+0V68xv6moOnkImcoTWK9v1CBVKx1aVwUza6XLcNmG9p82btQvN8BWdS0eN
         fWhw==
X-Forwarded-Encrypted: i=1; AJvYcCXg6UeenDdUc6jGSur7StfF6odTNUgtXWWBL6sVPJWQhpR1iqnJtJvZX3dtxXobo+fOCvsZ+zVIZkc1RBW9Gklv+eh/Iu5NkytpsXx5
X-Gm-Message-State: AOJu0Ywie6yJNxfw/IeqHsR2zngcEBl6vfSs1sjJq77ma8OtvnkdFCLk
	S4IRsJhKKHOwqlF7wRGI/oNAQxdku8wSAKOfBA8ewalI0XD+IKj/btKoRnkIthU=
X-Google-Smtp-Source: AGHT+IHIsFqviZhvtLgF4seVNCoFdjoa68ERd+CCUKgln1WOKYsDwCXMy2+vuC1fvcTLPk8qaBkxew==
X-Received: by 2002:a81:8395:0:b0:607:7a9a:4066 with SMTP id t143-20020a818395000000b006077a9a4066mr955361ywf.2.1707763290013;
        Mon, 12 Feb 2024 10:41:30 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVcG6jKDgpj4ZPVkJTxjwMfnlr6nEbPD9QZKPNlefMcVBVjbx9R18RFoMIPeICtwnZvKJiaL/oziV4QQLRmEVQALJ1I2MGvjUCjzaUfiXi5hKgqHKRAOwLkCgH+jbecf2LkYSjX4CliKNX5Jpkb1gFfE6FLMQWQcpsGUwWfUni5qquk4rEu50Bjhbz4gRa7QA4+tIvT
Received: from ghost ([50.146.0.2])
        by smtp.gmail.com with ESMTPSA id h13-20020a81b40d000000b00604941e2f1fsm1269354ywi.130.2024.02.12.10.41.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 10:41:29 -0800 (PST)
Date: Mon, 12 Feb 2024 13:41:28 -0500
From: Charlie Jenkins <charlie@rivosinc.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	David Laight <David.Laight@aculab.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/2] lib: checksum: Use aligned accesses for
 ip_fast_csum and csum_ipv6_magic tests
Message-ID: <ZcpmWINCFWd4331h@ghost>
References: <20240207-fix_sparse_errors_checksum_tests-v6-0-4caa9629705b@rivosinc.com>
 <20240207-fix_sparse_errors_checksum_tests-v6-2-4caa9629705b@rivosinc.com>
 <20240212062614.GI608142@ZenIV>
 <52393411-8313-4e94-9618-916b57f7d52e@roeck-us.net>
 <20240212181217.GK608142@ZenIV>
 <c5d8a333-aff5-49e1-a7ee-29a023266d2d@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5d8a333-aff5-49e1-a7ee-29a023266d2d@roeck-us.net>

On Mon, Feb 12, 2024 at 10:34:10AM -0800, Guenter Roeck wrote:
> On 2/12/24 10:12, Al Viro wrote:
> > On Mon, Feb 12, 2024 at 09:18:14AM -0800, Guenter Roeck wrote:
> > 
> > > Almost. Turns out the csum parameter of csum_ipv6_magic() needs to be in
> > > network byte order, and the length parameter needs to be in host byte order.
> > > So instead of
> > > 	data.len = data_ptr->len;
> > > 	data.csum = (__force __wsum)htonl((__force u32)data_ptr->csum);
> > > it needs to be something like
> > > 	data.len = ntohl(data_ptr->len);
> > > 	data.csum = data_ptr->csum;
> > > 
> > > Also, as you mentioned, either the returned checksum or the expected
> > > checksum needs to be converted for the comparison because one is in
> > > network byte order and the other in host byte order.
> > 
> >          for (int i = 0; i < NUM_IPv6_TESTS; i++) {
> > 		struct args {
> > 			struct in6_addr saddr;
> > 			struct in6_addr daddr;
> > 			__be32 len;
> > 			__wsum csum;
> > 			unsigned char proto;
> > 		} __packed data = (struct args *)(random_buf + i);
> >                  CHECK_EQ(cpu_to_le16(expected_csum_ipv6_magic[i]),
> >                           csum_ipv6_magic(data.saddr, data.daddr, ntohl(data.len),
> > 					 data.proto, data.sum));
> >          }
> > and to hell with field-by-field copying.  __packed here will tell the compiler
> > that alignment of the entire thing is 1 - the total size of fields is 41 bytes,
> > so "no padding" translates into "can't even assume that address is even".
> > 
> 
> Except that the data pointer needs to be aligned because otherwise architectures
> not supporting unaligned accesses will bail out (as observed on mps2-an385).
> But then I am no longer sure if that is correct - maybe csum_ipv6_magic()
> is supposed to be able to handle unaligned accesses. If so, maybe it would be
> more appropriate to skip this test on the affected architectures.
> 
> Guenter
> 

We can align this against IP_ALIGNMENT since it should always be aligned
against the IP header + NET_IP_ALIGN.

- Charlie


