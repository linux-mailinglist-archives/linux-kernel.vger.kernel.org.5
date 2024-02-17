Return-Path: <linux-kernel+bounces-69982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 148E485913F
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 17:57:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C462A283021
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 16:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF2FD7D41D;
	Sat, 17 Feb 2024 16:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="i5lDGlZv"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91E01D681;
	Sat, 17 Feb 2024 16:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708189011; cv=none; b=t6OYMLcJZa4/eeHC2qchsmdcHpOS9zTB4ZRU+jbP5uPFlkDjZ/RswGFBfHl+MBU/bW1fdAwZAN4CZYL81eXZ0ceZdG6H8ZSmIdowcPDvollizqEruQs2+iuCKKWSscWtCh76Gq/1+gPPsl8Q8cAPeE35A4VNImeZfoeX8gcjpeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708189011; c=relaxed/simple;
	bh=vtmXWJQTR268I6elGXGKji5aKARKWQW9ZTVxDl8jpeU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oC/sBT+QXFP9X7GSJkxgWCuYhOzMvaOFMrlIorTIm6rG9ZhaHzm4rM0CyqHoFr7eclnf8H+LBUzuhJejg9pu+6leKUTs27pnWzsQgxVxHniqCdVWRQDBWdsd7HWsWeTDVM2/eYjK97cGBwELhVngnbctdNaFnvdX2kUh96fkmmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=i5lDGlZv; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=qd91KUgzbRfv5CXyfjyN+hHquWgLzp7zTWKp3UEEcTg=; b=i5lDGlZv5FdNZ1Ckf6vz+JUgQS
	BB+GB8c8sugSGZHevFFC9r7kp4+bqTQYD7U6NJxjdXMIJ7xqF/2n16yS1ss/4n8RZSFf+VsBOfBgX
	b2cVpEI18XZ97m2+oyc6hdyVv513B6abddzVsV/zujha6xH5+fpdgNmz4cwmZE7jtnxds6tgm74RD
	iVhCr4LQAzBQ0qpsnVAFZ6YYp6jk6cZkB5Bn3xY2JYPECjtn9b9rM5PTGkL2C4Y9zLDWtKmrth40u
	yUX4zMa5etynd0U8zD29W/tBgYpD+Ho9pJnUWO0xR31D6rSg1uUqRzm2hxH1Sdl5BWnPSJmznS4/L
	v2DnwhBA==;
Received: from [50.53.50.0] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rbNzd-000000062mg-0xap;
	Sat, 17 Feb 2024 16:56:49 +0000
Message-ID: <8992c7f0-b0b1-4bbb-b5a3-2906159e2e24@infradead.org>
Date: Sat, 17 Feb 2024 08:56:48 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: CONFIG_JITTERENTROPY needs more explanation?
Content-Language: en-US
To: Bagas Sanjaya <bagasdotme@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Crypto <linux-crypto@vger.kernel.org>
Cc: Robert Elliott <elliott@hpe.com>, Herbert Xu
 <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>,
 Christoph Biedl <bugzilla.kernel.bpeb@manchmal.in-ulm.de>
References: <ZcJBk_NQvLzwzprn@archie.me>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <ZcJBk_NQvLzwzprn@archie.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/6/24 06:26, Bagas Sanjaya wrote:
> Hi,
> 
> On Bugzilla,  Christoph Biedl <bugzilla.kernel.bpeb@manchmal.in-ulm.de>
> wrote a question on CRYPTO_JITTERENTROPY description [1]:
> 
>> The desciption of the CRYPTO_JITTERENTROPY kernel option in crypto/Kconfig has an incomplete sentence:
>>
>> | This RNG does not perform any cryptographic whitening of the generated
>> |
>> | See https://www.chronox.de/jent.html
>>
>> This was introduced in a9a98d49da52 ("crypto: Kconfig - simplify compression/RNG entries") - please fix when convenient.
> 
> Can you explain why the Kconfig description says so?
> 
> Thanks.
> 
> [1]: https://bugzilla.kernel.org/show_bug.cgi?id=218458
> 

Hi,
Fixup patch has been posted.
Thanks for the report.

Subject: should be CRYPTO_JITTERENTRY.

-- 
#Randy

