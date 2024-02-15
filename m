Return-Path: <linux-kernel+bounces-66263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A347855977
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 04:20:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4CCFB21EC4
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 03:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 633CD611B;
	Thu, 15 Feb 2024 03:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bell.net header.i=@bell.net header.b="5DI3mSQV"
Received: from cmx-mtlrgo001.bell.net (mta-mtl-003.bell.net [209.71.208.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D7528E6;
	Thu, 15 Feb 2024 03:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.71.208.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707967212; cv=none; b=G98hnGN/TTafGdo1DxLq18asulzvCwXX3aimHFNt/qpypW/+KdCinWqUHO4DTCMd8icQ84Md5kTXrx5wwRn0SApWzd7/tsNfm8y4ec7/Po1eVIPILalEqcJI2ZHe1sTBdPA1EbCoSTDu8oHP/zU3jRccN3IbPKfL56toyngUxf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707967212; c=relaxed/simple;
	bh=IrqKlg0QgVjfakroNteNZ/rwHZR2Ky1rH9zrdcNLZp4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BOHP1zEJUL6dYYLAYH0/6nTmNq1e3uBUa78ZsHum49lB+P2++uCVh6FrzUTB7/pRAWN2+FsFU2wYt3CovcbzTnknloX3+IdR8oY/qRVHnfovVIBjr3HsPKRTElPua/akf8mfSfxYlMMsHhAZfZUh3WS4OIKWXJYgBLhiab63fqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bell.net; spf=pass smtp.mailfrom=bell.net; dkim=pass (2048-bit key) header.d=bell.net header.i=@bell.net header.b=5DI3mSQV; arc=none smtp.client-ip=209.71.208.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bell.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bell.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bell.net; s=selector1; t=1707967210; 
        bh=j7ny1h4tTwMoY9otL2Ft1oAXAdRzqVgab/AOorB5XCo=;
        h=Message-ID:Date:MIME-Version:Subject:To:References:From:In-Reply-To:Content-Type;
        b=5DI3mSQVacpPI+YClncPFgwNuxcpcxdoNz6pVna2tZBv4OYmG+sGKmU8UQ8LsvDC1CoHqnQ7a1BcFroNNnVg/bxaOwaUuFFoUpD/cL7zHHOpeDl8pyMSfDSpc0hDyQxJVXs/tYMAfKv7orzSnKnZFip7k3LZ9jJWOCkfYzwBII755/6835dJmg7k4/dod9XHMxPIe+hrcNlqkAIV43vyvH/iGndnetEt0NbOZ7Jcmtj9NaaeP/Ql0P1cFWfa1uRHimwhtcFDRz9uc8oBJhvZ1il+aIA3lCtEtjIHv745AVEmx+8R9UjrPetYe4DFSZbqPZg/5ITHR7t+NhJaDTgU+Q==
X-RG-SOPHOS: Clean
X-RG-VADE-SC: 0
X-RG-VADE: Clean
X-RG-Env-Sender: dave.anglin@bell.net
X-RG-Rigid: 65CD749C0000A605
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvledrudekgdehvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceugffnnfdpqfgfvfenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpeflohhhnhcuffgrvhhiugcutehnghhlihhnuceouggrvhgvrdgrnhhglhhinhessggvlhhlrdhnvghtqeenucggtffrrghtthgvrhhnpeejleffffejhefggfeuheelgeefgeeuieegtdekffegudeuteffgeffjedukefgueenucfkphepudegvddruddviedrudduvddrvdeffeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopegludelvddrudeikedrvddrgeelngdpihhnvghtpedugedvrdduvdeirdduuddvrddvfeefpdhmrghilhhfrhhomhepuggrvhgvrdgrnhhglhhinhessggvlhhlrdhnvghtpdhnsggprhgtphhtthhopeduuddprhgtphhtthhopeffrghvihgurdfnrghighhhthesrggtuhhlrggsrdgtohhmpdhrtghpthhtoheplfgrmhgvshdruehothhtohhmlhgvhieshhgrnhhsvghnphgrrhhtnhgvrhhshhhiphdrtghomhdprhgtphhtthhopegrkhhpmheslhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtoheptghhrghrlhhivgesrhhivhhoshhinhgtrdgtohhmpdhrtghpthhtohepuggrvhgvrdgrnhhglhhinhessggv
	lhhlrdhnvghtpdhrtghpthhtohepuggvlhhlvghrsehgmhigrdguvg
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from [192.168.2.49] (142.126.112.233) by cmx-mtlrgo001.bell.net (5.8.814) (authenticated as dave.anglin@bell.net)
        id 65CD749C0000A605; Wed, 14 Feb 2024 22:00:37 -0500
Message-ID: <1d5e059e-5b31-415d-ae41-593415812e94@bell.net>
Date: Wed, 14 Feb 2024 22:00:37 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/2] lib: checksum: Use aligned accesses for
 ip_fast_csum and csum_ipv6_magic tests
Content-Language: en-US
To: Guenter Roeck <linux@roeck-us.net>, Charlie Jenkins <charlie@rivosinc.com>
Cc: David Laight <David.Laight@aculab.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Andrew Morton <akpm@linux-foundation.org>, Helge Deller <deller@gmx.de>,
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
 Parisc List <linux-parisc@vger.kernel.org>, Al Viro
 <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org
References: <20240214-fix_sparse_errors_checksum_tests-v8-0-36b60e673593@rivosinc.com>
 <20240214-fix_sparse_errors_checksum_tests-v8-2-36b60e673593@rivosinc.com>
 <2ec91b11-23c7-4beb-8cef-c68367c8f029@roeck-us.net> <Zc1pSi59aDOnqz++@ghost>
 <cb4e358b-3fd0-4ca4-bf53-9cc379087304@roeck-us.net>
From: John David Anglin <dave.anglin@bell.net>
Autocrypt: addr=dave.anglin@bell.net; keydata=
 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
 T70V9SSrl2hiw38vRzsl
In-Reply-To: <cb4e358b-3fd0-4ca4-bf53-9cc379087304@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024-02-14 8:58 p.m., Guenter Roeck wrote:
> Specifically: Yes, the carry/borrow bits should be restored. Question is
> if the Linux kernel's interrupt handler doesn't restore the carry bits
> or if the problem is on the qemu side.
The carry/borrow bits in the PSW should be saved and restored by the save_specials
and rest_specials macros.  They are defined in arch/parisc/include/asm/assembly.h.

However, it appears the tophys macro might clobber the carry bits before they
are saved in intr_save.

Dave

-- 
John David Anglin  dave.anglin@bell.net


