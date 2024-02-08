Return-Path: <linux-kernel+bounces-58647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BECE84E963
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 21:09:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1B2F1F28150
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 20:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A0A5383B0;
	Thu,  8 Feb 2024 20:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="brhehB14"
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A5E383A1
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 20:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707422979; cv=none; b=f0/+B4E4hZgfU5vLN6URqvwjOr8wkD81RzFNT0Kl2mUqrFw2+S29f2jqVpFc6pX+V3vioqSbgyeiiAwzELNtkuqvpfTwv47Pf53jQVcywedPAJxtLUfzhWJglFPEr+98iIS28pAgNu/jG5ZDf+VHAxRMUM1+HwLMhdKLkMaS3yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707422979; c=relaxed/simple;
	bh=l+1KqC6Vl2SkwwuqrNnRTCCETZjGFHvF2DQF/YLmkdw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rh0UjaNAzk19nCR88X5Y82bEiINez4h+G1bBIsoN59uE9itmX+cnXrtulbgpLyAic0+SL3JxmX6aHMBP+nEhVVWJfB+IRs+HUe0hMwJn+8eup3QG3Pnf1pOOkcPFxjUJ6BwsrcYIipNn0osE50duvGJnRtwLx66WU40NRPriuwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=brhehB14; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-599f5e71d85so124415eaf.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 12:09:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1707422976; x=1708027776; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xKH5oL1qOtseBqZb3p5hrNYkk6e1TeAsUmuoiqUhVVg=;
        b=brhehB14elahD2RnvVywbjIocZnnmKZMqJABY6IH0S5WXtih0zdeM+45ikdUcxAm4z
         8s6PRwy9+Qa9r+L4m+FcRLoqFfJovBwxOnj7XfTcKTY6ZltuYq7voHPbNHXDLdIVoHq+
         Tnml/IcA0rqaHWU+Dv84bliGTviG0kwtzSzaW8dPGtXiNOKeJ6qMLsrbj0kFzUAVOk/p
         BZSVsKzJ1TUZNIQIHImWJBI/G9s3tLEkGy++wp393O8ZMYzJkF0WE4hpzoCeaZ0JB5LM
         VAiIP/bsF29BCD7r/s/PBHifxNYYnYcjVmoXYpiq39X8FQWX2ajSmgcFOS230lDIw70d
         lQCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707422976; x=1708027776;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xKH5oL1qOtseBqZb3p5hrNYkk6e1TeAsUmuoiqUhVVg=;
        b=XCQA0TG60Yqd3cbWGfJ64L5yoYi+c6uZKxpjhNBC+ZDxHnQCxQbSiURixmr+t16mLR
         iReoDKiahp6ZlECDmdhqVDxXrfqLqgao7qiYXCFHY4SxqYfDKR6iG5h/5tVg5QQZInLn
         CvQCcJpQgLpwthNFs21MgKWZuO+AdOax4HgouPahYPljOsDrL3pfsbt87VXqTqIHQsD2
         8NUrBryxlmE36WWyNkEVyFUikp4toUHXhhNsPskWofmESIu5HqTAK363prrzMr07+OCm
         wkXxytfuyj8JxOO1JaWXjrwVQ34MJ+OX+dGte+saw81vDeJRx7nhJumgRLXcmuOmSNQU
         V3yw==
X-Forwarded-Encrypted: i=1; AJvYcCX5JD4KWlfSnOUEV4gOpx/NywU1hYXKavrhKTohcnXqJSKBJxru8UuEkIKxS+chdFurZTTz5dNLX7g1SjX6NZ/sx3Y6f0PKjok1t4L3
X-Gm-Message-State: AOJu0Yzgu5TlwodLcdgfCuZMt5Z4sYG6L/dQnomLmfXhtdAPGGesL+zD
	rTXGpKoIAp498hvU9or2nnW/LyIr8TSWdW4kuuJMA4oXB4MgCgCa1u6uN4egExo=
X-Google-Smtp-Source: AGHT+IHFmNpn6XpoGIwKx18m1L6l5JmRvvKkW0jLey0DFlmC56UDIGJDO0U2nyZRwnPn7Uge6WANkg==
X-Received: by 2002:a05:6358:4b52:b0:178:76f8:e626 with SMTP id ks18-20020a0563584b5200b0017876f8e626mr272975rwc.6.1707422976113;
        Thu, 08 Feb 2024 12:09:36 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXRlyEdfx+fWPYruL/qI3BcMAJJMRQUs49pDJut0FU5xDtv8mHS/ckCTwpemCT7yIXD13P6GPwrEGsRzVl/+f1LTZFOnhfCmYhE9xCXl7BojJ19ZY9QPgNBBc32ygIi9fKtAAtCS+JzChvYt5TVs9VkTHjhMRSvVCfNVPM=
Received: from ghost (mobile-166-137-160-039.mycingular.net. [166.137.160.39])
        by smtp.gmail.com with ESMTPSA id i2-20020a639d02000000b005b7dd356f75sm241326pgd.32.2024.02.08.12.09.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 12:09:35 -0800 (PST)
Date: Thu, 8 Feb 2024 12:09:33 -0800
From: Charlie Jenkins <charlie@rivosinc.com>
To: David Laight <David.Laight@aculab.com>
Cc: Guenter Roeck <linux@roeck-us.net>, Palmer Dabbelt <palmer@dabbelt.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 2/2] lib: checksum: Use aligned accesses for
 ip_fast_csum and csum_ipv6_magic tests
Message-ID: <ZcU0/ZsCAwxW/oTo@ghost>
References: <20240130-fix_sparse_errors_checksum_tests-v5-0-4d8a0a337e5e@rivosinc.com>
 <20240130-fix_sparse_errors_checksum_tests-v5-2-4d8a0a337e5e@rivosinc.com>
 <ec44bf32-8b66-40c4-bc62-4deed3702f99@roeck-us.net>
 <ZcQeyigDWwvnc4Nu@ghost>
 <0b78e69bf4ef4e52a61ffe21d2c08c96@AcuMS.aculab.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b78e69bf4ef4e52a61ffe21d2c08c96@AcuMS.aculab.com>

On Thu, Feb 08, 2024 at 09:54:39AM +0000, David Laight wrote:
> From: Charlie Jenkins
> > Sent: 08 February 2024 00:23
> > 
> > On Sun, Feb 04, 2024 at 09:41:56AM -0800, Guenter Roeck wrote:
> > > Hi,
> > >
> > > On Tue, Jan 30, 2024 at 11:10:04AM -0800, Charlie Jenkins wrote:
> > > > The test cases for ip_fast_csum and csum_ipv6_magic were using arbitrary
> > > > alignment of data to iterate through random inputs. ip_fast_csum should
> > > > have the data aligned along (14 + NET_IP_ALIGN) bytes and
> > > > csum_ipv6_magic should have data aligned along 32-bit boundaries.
> > > >
> > > >
> ...
> > >
> > > So this works on little endian systems. Unfortunately, I still get
> > >
> ...
> > >
> > > when running the test on big endian systems such as hppa/parisc or sparc.
> > 
> > Hmm okay it was easy to get this to work on big endian for
> > test_ip_fast_csum but test_csum_ipv6_magic was trickier. I will send out
> > a new version with the changes.
> 
> Instead of trying to save the expected results why not just
> calculate them with a 'really dumb' implementation.
> (eg: Add 16bit items and then fold.)
> 
> For the generic tests, IIRC:
> Your test vectors looked random.
> They should probably contain some very specific tests cases.
> eg:
> - Zero length and all zeros - checksum should be zero (not 0xffff).
> - Buffers where the final 'fold' needs the carry added in.

The existing csum test cases have three tests, one for random and then
one for each of the two specific test cases you mentioned. I figured
having the random test case would most likely catch an error if one
existed.

The additional tests can be added in a future patch but I would like to
make sure the existing test cases work first.

- Charlie

> 
> 	David
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
> 

