Return-Path: <linux-kernel+bounces-139813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 045938A080A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 08:07:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE1381F2596D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 06:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C8DC13CA9A;
	Thu, 11 Apr 2024 06:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="Hksxhob8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="p/CmgsMN"
Received: from wfout4-smtp.messagingengine.com (wfout4-smtp.messagingengine.com [64.147.123.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C3B13C3ED
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 06:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712815628; cv=none; b=LMNJdbBg24/y0qN7Jx37qBYDDi2q8SeK7gfm9yb8bXLko4P4lBqixkyAiOdSe/LCunuQaFpYXTj8V5oNpzgNZ9HgxWLV1jlwzsr1V6f2C5K8j/SUk9Qc9JDha+KsRRaFIVfbqzAGpnX0cBhQxZa0aN+ML1mwuPoI24SOd+0bmLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712815628; c=relaxed/simple;
	bh=F4MaVQ7pKoe7lUsUYa8MyhWTCFlXuCihjUDokKL4acc=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=G3K6WMbYQlUqy5OZK4e/M22LTLCoxqex2y/rcnEUH9YcgMC96qLReAjGFFEmhNz/2SdWRkxvsga/0mFuh/+qTpa0ARQnfPCAQu4WH6vPNJhE293hylS1xvZPgRO5YwKGr0NUCOOspAbXNbiRhclpU/Ns+NqRXIG+7bh+1QarQ5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=Hksxhob8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=p/CmgsMN; arc=none smtp.client-ip=64.147.123.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id 57DF01C000D1;
	Thu, 11 Apr 2024 02:07:05 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Thu, 11 Apr 2024 02:07:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712815624; x=1712902024; bh=feFU2U3jUo
	M8TSdlpJrca4UZF2kzeN8mwV/FEH7SomY=; b=Hksxhob8ya9CDW+zgnHMKadxcV
	YoEn0Wg6as2ZmQYrcoeblFVIUDNsDNBvhmIe0+PH419P3I8C762MTfU8pYnIW0/O
	sV3orsvvV+c8vOQgWR6AuFDPyrWhf3pa9sMRhTRs6NOljBSnBs73DN0fHrkk3ZXD
	d8iFQPlWhr8R3Hi5DXNgJnhtwgkGxAa2wjwNz6yCyEtoSWexGqZF3kBbOf6VkxIf
	KHYcCAO05dXHld+msEhEbl73x8F8uW9KL/lRuadcVqW9JXbXFKAE5zpqcEnYjGMb
	AqBYA7ogKfdFByzam4bUh+PSHN5jN2uKzWTySlu5BEXQVnIITdzFem+swS5w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712815624; x=1712902024; bh=feFU2U3jUoM8TSdlpJrca4UZF2kz
	eN8mwV/FEH7SomY=; b=p/CmgsMNIhZkFvuuGipuBi9xtI53wdCVYTh89ELOmtK6
	Sqlgs1IfAn2G6/dLbLScmHJGcWlHdJCdQUKs5cGHytnzNwjBqUwy1T7bFzm7MIAS
	Ip6Y0Dn4dksNNwGO8AoqrTQB7QfOvmUINZg3B/pntcYzuDENMRfqEHKaFLV42FFj
	8uF9SEGI2dDZqI6aL3HBcr07LcLTmWyLggGaEZxVwbY3RSgLuCFhIk5sU988jxoH
	p5k27Z5HG9rhfExte9SnokO0oVtikR5zJS4ND5I5NSMHKu5WaROfpD3cbr/k+DGF
	T5R4FU2uA/EMs9SemDo1Y4uV38x78elSq8wn1QwK5A==
X-ME-Sender: <xms:B34XZpP6WngeL3EnSz8dClCizh8DVdGuwUvBUUBiOARml-Huux7aDQ>
    <xme:B34XZr_eVr2oeYyTjnkHflLaNRU_KIfVa310nxcbwU0-jNGDR9tliakkviQFN9_qt
    9Tmbequ6nDn6JzAbDM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudehjedguddtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:B34XZoTJkJvmR8TF4eE2EWju2ry5hIB5TJEPy0SlFPqvifnCRW11nQ>
    <xmx:B34XZlvRRdRX7K_jI9nWH9GxdYgY_sMSLxAbDzuCuZSOwvuD4KNeVg>
    <xmx:B34XZheq-UG7GBVXdJyZCwCDkfgcorjY2U_nsJef5L9GXLVZHIephA>
    <xmx:B34XZh2yOKYhLUc1QtapjserGZNYMYQ6ioaGEs8zTpD9B9w1gYBHmA>
    <xmx:CH4XZpQqGJux8MMYqWnYy31HZCN_tT5FtRDozZDMiEb0kxrXHisMoK8p>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 766FFB60093; Thu, 11 Apr 2024 02:07:03 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-379-gabd37849b7-fm-20240408.001-gabd37849
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <b752273b-0e94-4325-9cf8-6f16a204818b@app.fastmail.com>
In-Reply-To: 
 <CAAhV-H6bHudfUVE4SWY88mxmLhFok9DS8UyODSZEdUJ816V8Rg@mail.gmail.com>
References: <20240411010510.22135-1-yangtiezhu@loongson.cn>
 <CAAhV-H6bHudfUVE4SWY88mxmLhFok9DS8UyODSZEdUJ816V8Rg@mail.gmail.com>
Date: Thu, 11 Apr 2024 08:06:43 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Huacai Chen" <chenhuacai@kernel.org>, "Marc Zyngier" <maz@kernel.org>,
 "Tiezhu Yang" <yangtiezhu@loongson.cn>
Cc: "Thomas Gleixner" <tglx@linutronix.de>, loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn
Subject: Re: [PATCH v3 0/4] Give chance to build under !CONFIG_SMP for LoongArch
Content-Type: text/plain

On Thu, Apr 11, 2024, at 06:26, Huacai Chen wrote:
>
> I remember that you both suggested not introducing NOSMP support for a
> modern architecture which brings additional complexity. I wonder if
> you still have the same attitude now. I will merge this series only if
> you think it is worthy to introduce NOSMP now.

It's an interesting question, as we have recently discussed two
opposite ideas and may end up doing both (or possible neither)
in the future:

- On x86, there is no real reason to need non-SMP kernels as the
  memory savings are fairly small, and it tends to break because
  of lack of users testing it.

- On arm64, we have never supported non-SMP kernels, but I have
  looked at possibly adding this because there are still popular
  ARM based system-in-package products with less than 128MB of
  built-in RAM and only a single CPU. As these are moving from
  32-bit to 64-bit cores, it becomes more interesting to build
  a 64-bit UP kernel and save multiple megabytes.

I think loongarch64 is in the same place as arm64 and riscv64
(which does allow non-SMP builds) here, and there are good
reasons to allow it on all of them now, even if we previously
never had a need for it.

That said, both the 9% observed performance improvements that
Tiezhu Yang reported, and the memory savings that I saw are
probably higher than they should be, so we may also want to
investigate that further to see if we can improve the SMP
kernel to better support UP runs.

    Arnd

