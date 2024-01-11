Return-Path: <linux-kernel+bounces-23877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C39B82B31F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 17:37:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30F921C24445
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 16:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 417CA50268;
	Thu, 11 Jan 2024 16:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="pIoaubWI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mlHrRsJ9"
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375715024E;
	Thu, 11 Jan 2024 16:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id 9FC743200A0F;
	Thu, 11 Jan 2024 11:37:33 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Thu, 11 Jan 2024 11:37:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1704991053; x=1705077453; bh=LSf0SiijIV
	zkqraaNl7VZeYKE9TrQNnQYNEHNGLb4m8=; b=pIoaubWIow5E/9yD4EaILySIjh
	GpbArRXiopDzKgj/x5OSJP1/XrLuOiFYpW2OCZrAxPlGEEDEnMaQspUVvdGYNBeZ
	9eqSS6uRBInNQjp0mSFBeMRycMepS2IZ/LumKkG2hovNWwHSfnNwg0V/cT1TiPKm
	OY99U7plvUSsrXJF2u8wITKGJ4ybLeKw5PtBGzi8j4ry4SCDC6b0NP+EPr+8Z61l
	C81i8xYvoW5uLVnjSzOSawclt2UYMTQKgHgi274QAuKVYsPYN2YLZCZrzUpjHyHB
	sbd7NZEkdctr+xwi6R6vTMxc6rWcxKHsdmsM68DKRwi14iDGbyEtey+UqdQg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1704991053; x=1705077453; bh=LSf0SiijIVzkqraaNl7VZeYKE9Tr
	QNnQYNEHNGLb4m8=; b=mlHrRsJ9xxJZ9UagtFXuT/OJT5doT6uscqzyrs+n0D4Y
	Pyg0iG1906ueZkDsppl4UAurbfyC3HKQNOjlZSZlcZEHrtbZO2+cgQC83edJ6T8Z
	NFWyfkJwRaNGRD149FEE7YAdAMxJjupM8dNCDvrWRLlQuHUS9XNaD32Y6xPIxiQ5
	TtubAhgrRmuHjBbClF4HGf3MT+BZj21t/Wg5XrEFzwz3+Yitjyz2zoPQFnP7fh4T
	2hVTWhD+Jn91CKM8U03V1S2P+STQq+ODDAMzRmybN/CllIr8SPcsFbkzGoJI3Y7Q
	9mZeahCRYW00ajKxKM9ijfioL7FN04QX74eg5RGsnQ==
X-ME-Sender: <xms:TBmgZU229WBGtd_QXI9TXSe2-4gRumcA3JyJ-44zqCTcHXy7Shg4bw>
    <xme:TBmgZfHoWScO662orEBhvNW6DT1eb6mQnRq4PmYyBtLTc31Y5QxHAz7mNwChOPO7H
    tj-0msC_ic9l30ZK14>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeifedgkeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepvefhffeltdegheeffffhtdegvdehjedtgfekueevgfduffettedtkeekueef
    hedunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:TBmgZc4MHTy5-w9E7CFl6SQFvCiemLxW0lZhVSStFo-FBXYolIEu8w>
    <xmx:TBmgZd3zqmj_j6cZVMftC_8YVk7uWgmoaLjtztaPthkuXd2yxW0Xig>
    <xmx:TBmgZXEn4tnFkThHXyWwySxBN6U76OIeB-V2Or0mf985HK2yGWN0QQ>
    <xmx:TRmgZc5IIbD0bZI_q2xGVAEOfKenrHdn_PdlPA_kAS68eWmjFC0eug>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id C0B46B6008D; Thu, 11 Jan 2024 11:37:32 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1374-gc37f3abe3d-fm-20240102.001-gc37f3abe
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <bb175a67-462b-41a7-804a-ec990291a00e@app.fastmail.com>
In-Reply-To: <908325ed-08af-4b0c-926e-da9afba25772@app.fastmail.com>
References: 
 <CA+G9fYvDNksfKNvtfERaBa9t2MJNucfD_s3LgKGw_z2otW+nyw@mail.gmail.com>
 <628bf675-77fc-4ccc-be2f-9c3ec8a7b0b8@moroto.mountain>
 <908325ed-08af-4b0c-926e-da9afba25772@app.fastmail.com>
Date: Thu, 11 Jan 2024 17:37:12 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Dan Carpenter" <dan.carpenter@linaro.org>,
 "Naresh Kamboju" <naresh.kamboju@linaro.org>,
 "Uladzislau Rezki" <urezki@gmail.com>
Cc: linux-next <linux-next@vger.kernel.org>,
 "open list" <linux-kernel@vger.kernel.org>,
 "Linux Regressions" <regressions@lists.linux.dev>,
 clang-built-linux <llvm@lists.linux.dev>, lkft-triage@lists.linaro.org,
 "Andrew Morton" <akpm@linux-foundation.org>
Subject: Re: mm/vmalloc.c:4691:25: error: variable 'addr' is uninitialized when used
 here [-Werror,-Wuninitialized]
Content-Type: text/plain

On Thu, Jan 11, 2024, at 13:55, Arnd Bergmann wrote:
> On Thu, Jan 11, 2024, at 12:16, Dan Carpenter wrote:
>> On Thu, Jan 11, 2024 at 04:23:09PM +0530, Naresh Kamboju wrote:
>>> Following build failures noticed on i386 and x86 with clang builds on the
>>> Linux next-20240111 tag.
>>> 
>>> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>>> 
>>> Build error:
>>> ----------
>>> mm/vmalloc.c:4691:25: error: variable 'addr' is uninitialized when
>>> used here [-Werror,-Wuninitialized]
>>>  4691 |                 va = __find_vmap_area(addr, &vn->busy.root);
>>>       |                                       ^~~~
>>> mm/vmalloc.c:4684:20: note: initialize the variable 'addr' to silence
>>> this warning
>>>  4684 |         unsigned long addr;
>>>       |                           ^
>>>       |                            = 0
>>> 1 error generated.
>>
>> We turned off uninitialized variable warnings for GCC a long time ago...
>> :/ I don't know if we'll be able to re-enable it in a -Werror world
>> although Clang seems to be managing alright so perhaps there is hope.
>
> The problem with gcc's warning is that it is non-deterministic and
> in recent versions actually got more false-positives even without
> -Os or -fsanitize=. Clang does not catch all that gcc does because
> it doesn't track state across inline functions, but at least its
> output is always the same regardless of optimization and other
> options.
>
> At least this particular one is an obvious bug and easily gets
> caught by lkft and lkp even if gcc's -Wuninitilized doesn't
> flag it.

As it turns out, gcc did find this one in the default -Wuninitialized
regardless of -Wmaybe-uninitialized:

mm/vmalloc.c: In function 'vmalloc_dump_obj':
mm/vmalloc.c:4691:22: error: 'addr' is used uninitialized [-Werror=uninitialized]
 4691 |                 va = __find_vmap_area(addr, &vn->busy.root);
      |                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
mm/vmalloc.c:4684:23: note: 'addr' was declared here
 4684 |         unsigned long addr;
      |                       ^~~~

and I see that Uladzislau Rezki already sent a fix, which
is the same that I tried out in my randconfig tree:
https://lore.kernel.org/lkml/ZaARXdbigD1hWuOS@pc638.lan/

    Arnd

