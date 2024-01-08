Return-Path: <linux-kernel+bounces-19958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B304827773
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 19:27:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A1272847B1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 18:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6428354BDB;
	Mon,  8 Jan 2024 18:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="gyCpfHha"
X-Original-To: linux-kernel@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC2154BC0;
	Mon,  8 Jan 2024 18:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Received: from localhost (unknown [IPv6:2601:280:5e00:7e19::646])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 31CC5377;
	Mon,  8 Jan 2024 18:27:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 31CC5377
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1704738443; bh=6A53Fmc3sg36fdjFQCDXxbk/Zai3VfsgTloQdrPblU0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=gyCpfHhaEHCNty4eBaRFlalLNy3XXk1BRuvXBCi6xxtRGX5KwOVyclDy4guaOSw7X
	 hxIXok/dNoDMJuNKSoxwdhio+8ayHPmNZhr65tB3MQuTHHbwUWT9n3f9sqtR4FggeW
	 ZvONN6KwAVI/Awylp+0zxcaH7pf87kDzKthJpZnT/wRj8dWCX86u3vMwf5XiNty2A2
	 3OMeYNKCl7rtqtiz4HiDtG0+XUw7z/AhpfoXSnI5kipWoIVjJ0i2rJwh5UO1kc/HEJ
	 3hEJKM6lQja22SRObdBIGpnu88ntRCqFryGKE3sR99+jmVfAQC50g3QUZfRULRXLbl
	 naMYuT7+fdC5w==
From: Jonathan Corbet <corbet@lwn.net>
To: Yueh-Shun Li <shamrocklee@posteo.net>
Cc: Hu Haowen <src.res.211@gmail.com>, Alex Shi <alexs@kernel.org>, Yanteng
 Si <siyanteng@loongson.cn>, Randy Dunlap <rdunlap@infradead.org>,
 workflows@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] coding-style: show how reusing macros prevents
 naming collisions
In-Reply-To: <eecb9fa3e0cd84fce0b2f9e5449888a0@posteo.net>
References: <107b6b5e-ca14-4b2b-ba2e-38ecd74c0ad3@infradead.org>
 <20240108160746.177421-1-shamrocklee@posteo.net>
 <20240108160746.177421-3-shamrocklee@posteo.net>
 <871qaryel9.fsf@meer.lwn.net>
 <eecb9fa3e0cd84fce0b2f9e5449888a0@posteo.net>
Date: Mon, 08 Jan 2024 11:27:22 -0700
Message-ID: <87ederwuid.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Yueh-Shun Li <shamrocklee@posteo.net> writes:

>> So everything we add to our documentation has a cost in terms of reader
>> attention.  We ask people to read through a lot of material now, and
>> should only increase that ask for good reason.
>> 
>> With that context, I have to wonder whether we really need to tell our
>> readers, who are supposed to be capable developers, that reuse can help
>> to avoid name collisions?
>> 
>
> The motivation comes from existing inconsistency of the "__stringify()" 
> macro
> definition between e.g. "samples/bpf/tracex5.bpf.c" and other files.
>
> I agree that increasing the length of the documentation without
> substantial benefits would not be helpful for the readers, and
> doubling the length of a section is too much for its purpose.
>
> Should I shorten it into one sentence, like
>
> ```
> On the other hand, locally-defined variants, such as ``#define 
> __stringify(x) #x``,
> could lead to naming collisions that break otherwise functioning 
> facilities.
> ```
>
> or just omit it in the next version of patches?

My own feeling (others may well disagree) is that this isn't worth
mentioning in the coding-style document.  What you *could* do is to fix
the redefinitions (if that hasn't happened yet) and make sure that the
macros in question are covered in our kernel documentation.

Thanks,

jon

