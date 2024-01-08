Return-Path: <linux-kernel+bounces-19955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42F86827754
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 19:24:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 688511C22E3B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 18:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AA005577B;
	Mon,  8 Jan 2024 18:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="A/pEiq0N"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A21A55778
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 18:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 5E9A4240028
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 19:23:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1704738205; bh=fwt/GANjNvWWtupqWsOG0MztgpT1y2UeL0pOsAIRuPg=;
	h=MIME-Version:Content-Transfer-Encoding:Date:From:To:Cc:Subject:
	 Message-ID:From;
	b=A/pEiq0NY9RP7r3bCBdSIk7irRHQ7Gr3qKUQ4103zHQ+p4HvwshIxw84GG0tY2vVq
	 bcCTmvSerBeDSl6t402vFLikEyLPzDxIcem1wllgvDlK1LQGOnt44zOTYjlffuEK4a
	 7fAOIKEo/XO+dRK4Q4tiSK231fdTEY/Gu/GFM4IkV32oBOjCcgtuhKYXL1sljpErWH
	 bQ6lM4BUN4bnzq7ydIIF+n8HHsOs3XzZsGR1tyekrErKGoIzkM9G2txrQZQ7+V5IUZ
	 bwImo7b7wrOKlVHzgpd6nTtbKrS8IngZ0jYBo5AbYWCB5GutT9FgL0tb8iV+mwkeg3
	 AXRMGYk1V/w4A==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4T82Vy2MWRz6twD;
	Mon,  8 Jan 2024 19:23:21 +0100 (CET)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Mon, 08 Jan 2024 18:23:21 +0000
From: Yueh-Shun Li <shamrocklee@posteo.net>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Hu Haowen <src.res.211@gmail.com>, Alex Shi <alexs@kernel.org>, Yanteng
 Si <siyanteng@loongson.cn>, Randy Dunlap <rdunlap@infradead.org>,
 workflows@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] coding-style: show how reusing macros prevents
 naming collisions
In-Reply-To: <871qaryel9.fsf@meer.lwn.net>
References: <107b6b5e-ca14-4b2b-ba2e-38ecd74c0ad3@infradead.org>
 <20240108160746.177421-1-shamrocklee@posteo.net>
 <20240108160746.177421-3-shamrocklee@posteo.net>
 <871qaryel9.fsf@meer.lwn.net>
Message-ID: <eecb9fa3e0cd84fce0b2f9e5449888a0@posteo.net>

Dear Mr. Corbet,

Thank you very much for your feed back.

On 2024-01-09 00:28, Jonathan Corbet wrote:
> Yueh-Shun Li <shamrocklee@posteo.net> writes:
> 
>> In section "18) Don't re-invent the kernel macros" in "Linux kernel
>> coding style":
>> 
>> Show how reusing macros from shared headers prevents naming collisions
>> using "stringify", the one of the most widely reinvented macro, as an
>> example.
>> 
>> This patch aims to provide a stronger reason to reuse shared macros,
>> by showing the risk of improvised macro variants.
>> 
>> Signed-off-by: Yueh-Shun Li <shamrocklee@posteo.net>
>> ---
>>  Documentation/process/coding-style.rst | 22 ++++++++++++++++++++++
>>  1 file changed, 22 insertions(+)
>> 
>> diff --git a/Documentation/process/coding-style.rst 
>> b/Documentation/process/coding-style.rst
>> index 2504cb00a961..1e79aba4b346 100644
>> --- a/Documentation/process/coding-style.rst
>> +++ b/Documentation/process/coding-style.rst
>> @@ -1070,6 +1070,28 @@ Similarly, if you need to calculate the size of 
>> some structure member, use
>>  There are also ``min()`` and ``max()`` macros in 
>> ``include/linux/minmax.h``
>>  that do strict type checking if you need them.
>> 
>> +Using existing macros provided by the shared headers also prevents 
>> naming
>> +collisions. For example, if one developer define in ``foo.h``
>> +
>> +.. code-block:: c
>> +
>> +	#define __stringify(x) __stringify_1(x)
>> +	#define __stringify_1(x) #x
>> +
>> +and another define in ``bar.h``
>> +
>> +.. code-block:: c
>> +
>> +	#define stringify(x) __stringify(x)
>> +	#define __stringify(x) #x
>> +
>> +When both headers are ``#include``-d into the same file, the 
>> facilities provided
>> +by ``foo.h`` might be broken by ``bar.h``.
>> +
>> +If both ``foo.h`` and ``bar.h``  use the macro ``__stringify()`` 
>> provided by
>> +``include/linux/stringify.h``, they wouldn't have stepped onto each 
>> other's
>> +toes.
>> +
> 
> So everything we add to our documentation has a cost in terms of reader
> attention.  We ask people to read through a lot of material now, and
> should only increase that ask for good reason.
> 
> With that context, I have to wonder whether we really need to tell our
> readers, who are supposed to be capable developers, that reuse can help
> to avoid name collisions?
> 

The motivation comes from existing inconsistency of the "__stringify()" 
macro
definition between e.g. "samples/bpf/tracex5.bpf.c" and other files.

I agree that increasing the length of the documentation without 
substantial
benefits would not be helpful for the readers, and doubling the length 
of a
section is too much for its purpose.

Should I shorten it into one sentence, like

```
On the other hand, locally-defined variants, such as ``#define 
__stringify(x) #x``,
could lead to naming collisions that break otherwise functioning 
facilities.
```

or just omit it in the next version of patches?

> Thanks,
> 
> jon

Thank you for your time and guidance.

Shamrock

