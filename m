Return-Path: <linux-kernel+bounces-23608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7161382AF02
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 13:56:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1165BB227E1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 12:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB1DB15E95;
	Thu, 11 Jan 2024 12:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="BMV4yOHv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nrUdzr6x"
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60C315AE9;
	Thu, 11 Jan 2024 12:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id F2A543200258;
	Thu, 11 Jan 2024 07:55:47 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Thu, 11 Jan 2024 07:55:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1704977747; x=1705064147; bh=n7Flv4sDP2
	we1RAcMNYutGo+Ms3cmgPKVxBB6NzlfbI=; b=BMV4yOHvD6RNJ4gKwjz8eJiho5
	MuZnwjbYPMPctC3x5+8khcxrp10wy43dm0CuDs41cIlUu1itHZpeur4ThCGOpH5Q
	R/PAKoF4uJsOX0MEAnGqPwYGrnWO/p/+j95ZAZ+QDHBUq4tJmU7oKoKgsLrD6kO8
	iEctsAHd4R903F/Xwo8lb5OS5qB4dLUOi8kYU4qEsdY0Uwcv+7JOkjxJZ2MEVfUG
	YbkpODU5INMHIbc5FoF9BBrOn/RvuYPryRLHuudMvQ5ZmjfPLczg+vVFgj1Jg1UJ
	Wj8SrRapaSTz/aQkcPW6qo37nPlfqjQmK3PQptDu2j/IjRNAX6B2yr5+cggw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1704977747; x=1705064147; bh=n7Flv4sDP2we1RAcMNYutGo+Ms3c
	mgPKVxBB6NzlfbI=; b=nrUdzr6x4aT4f4aJSErB7UJYRsMkiISvZnY5PXbhtgpb
	EfBhv9SmKahvHIaV88z+Of1ai0prhzzuGiVJs4rB2qkZWdI7nFwoZ+J9xqORqhpi
	q71KiRfmqJW6Wqn3TjQg54RZBrf7eALnwotOd1wW7baIjdpwRinDtkt/Yn0Th5ik
	3STJ5Q5Gk4sLmlbyXfZAGxdRErWdtzIElfFVCzQpCnNu1/SDftDdLxbOvfuyaQT7
	5Recd5pmgvGuJsAUyeo3OgFRQgYO0Oa4BixRO0eMUPzByzyTD9Y3lMZ4zmCeeHVj
	R84jonajBxTqt2W2eiQzAOlQ4pCDKgOOkwh5dZ6yfA==
X-ME-Sender: <xms:U-WfZUkRqQAutNFK73pQAn7MN559CMu1_vFdfU49PTOKXBRatGLlEA>
    <xme:U-WfZT0OxrL_6yIlikHv9O7Im9GiUAccdFCDTSpVTE620IimfHTKZJHWPyf-4CSds
    YgTU5j6WvBSU6ghLcE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeifedggeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:U-WfZSo2uwxG5HPRm8WLuHIXFz4D6xNqec1BKzgyXsAxM8qiBWVikg>
    <xmx:U-WfZQk4-z096u_Db9SFTtSs4VkclUiZ19G40qwhZvtO_mr237SLbw>
    <xmx:U-WfZS223sqdo6C1OMDpB0yg51BEwUzP2uKLxgqd4RGCiJ5fsUHMgw>
    <xmx:U-WfZcpakV0xlJAzGCgiWztRhmxp5WRLdfsSsTaGZQ9f6qInK9BX-w>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 1A00CB6008D; Thu, 11 Jan 2024 07:55:47 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1374-gc37f3abe3d-fm-20240102.001-gc37f3abe
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <908325ed-08af-4b0c-926e-da9afba25772@app.fastmail.com>
In-Reply-To: <628bf675-77fc-4ccc-be2f-9c3ec8a7b0b8@moroto.mountain>
References: 
 <CA+G9fYvDNksfKNvtfERaBa9t2MJNucfD_s3LgKGw_z2otW+nyw@mail.gmail.com>
 <628bf675-77fc-4ccc-be2f-9c3ec8a7b0b8@moroto.mountain>
Date: Thu, 11 Jan 2024 13:55:15 +0100
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

On Thu, Jan 11, 2024, at 12:16, Dan Carpenter wrote:
> On Thu, Jan 11, 2024 at 04:23:09PM +0530, Naresh Kamboju wrote:
>> Following build failures noticed on i386 and x86 with clang builds on the
>> Linux next-20240111 tag.
>> 
>> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>> 
>> Build error:
>> ----------
>> mm/vmalloc.c:4691:25: error: variable 'addr' is uninitialized when
>> used here [-Werror,-Wuninitialized]
>>  4691 |                 va = __find_vmap_area(addr, &vn->busy.root);
>>       |                                       ^~~~
>> mm/vmalloc.c:4684:20: note: initialize the variable 'addr' to silence
>> this warning
>>  4684 |         unsigned long addr;
>>       |                           ^
>>       |                            = 0
>> 1 error generated.
>
> We turned off uninitialized variable warnings for GCC a long time ago...
> :/ I don't know if we'll be able to re-enable it in a -Werror world
> although Clang seems to be managing alright so perhaps there is hope.

The problem with gcc's warning is that it is non-deterministic and
in recent versions actually got more false-positives even without
-Os or -fsanitize=. Clang does not catch all that gcc does because
it doesn't track state across inline functions, but at least its
output is always the same regardless of optimization and other
options.

At least this particular one is an obvious bug and easily gets
caught by lkft and lkp even if gcc's -Wuninitilized doesn't
flag it.

    Arnd

