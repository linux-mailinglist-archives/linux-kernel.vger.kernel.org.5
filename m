Return-Path: <linux-kernel+bounces-134987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A81E589B9A1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 10:02:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FE651F211D0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 08:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB17B2BB16;
	Mon,  8 Apr 2024 08:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="nsKkW6FL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EWrFlLHI"
Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279E433981;
	Mon,  8 Apr 2024 08:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712563359; cv=none; b=KdVhCle2Q9t4Jy6eyBNFOO611rAaoXLEJupcfdg7sWc5Qc40CIi3PRnf14u7qXHvO0j+447PLgunBg/0Tk6HHiZT5BBbzfKeIHOLLKx9yfOc5Q8LHJKW0M+guUQGsILWc5yF3RaV2emUvh7HNX9QNtuFU44oKPEx0WWj8zx4XQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712563359; c=relaxed/simple;
	bh=ONVCO97q0NUpcIKzKBU0FPe0s0GFuXeW+BnFifgu3xY=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=QVyzkOqG764kzRnlbZwCCPoN/iAb1C9DDFPEhIGUWFEU4LB8F1aRkB78mF/ojZ0aHmkLlzVNZaS6uYwgScAfVCWepTlZSXBqaCaNSTPtxcM4HI04+VAd3b9kCSA3CzQLBH9t/Of2Y+VguxvcmvCLr18236yNrIdD7BffUyKdQkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=nsKkW6FL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EWrFlLHI; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 3767E1140083;
	Mon,  8 Apr 2024 04:02:37 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Mon, 08 Apr 2024 04:02:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712563357; x=1712649757; bh=353KQRVAV2
	Vp7+I9XXlJcOEzq1lBks9gDh0CvvTWW/0=; b=nsKkW6FL2r2tnPuQpDnAidkQhs
	LL3HSoM+e6C0oZ0OxTM1WH0kFDXQaplxMk/9onG4HREKvUBpbU/3NN0N0jm+zp+N
	FUFbrPs7xjZYr0zG0rLD/m0rcGNGliVJ6gOYX5NTp+aL2Ze+R2pa0b7LfoXcbfF1
	m0k2WzRL1cf81/4qPYCtiZurlwDMFsCVX+kVd5nv9h08sIYvtEIiHxjenGtH7Yfv
	wdDEgSo+vODN2Ys7GvcmbXeWBN3yEG7KqoQSDgNzDgcO6pXM6vP0QmtrMa18F/re
	kwaUvKF+GQLnbxPxjaFyGgWPvmevwb5YLUbibrMWL8OMky7Q341Mbf/hGzVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712563357; x=1712649757; bh=353KQRVAV2Vp7+I9XXlJcOEzq1lB
	ks9gDh0CvvTWW/0=; b=EWrFlLHIQsyNwfytwwCpBq0y8szxw6wp9EfltAmhQPCm
	S1vxG9bnKhMz+C8zoQcj1EANhgy/Eo02LOpryePrQZJTNVesalw8a+cP29zsBRiF
	mzQjnnzOCJcOwxAxXh89X9NmiH+yR9PKdljGGIoRpId/LkX32B8VbYM9KPo5U+AS
	ypP170QCiytQurLxkdsxx3aU40Nnf5dX2dUP/3Z6StDR4N+0zoEQ+HgH3b8YQ7E9
	dSb/u9DkwmRiwwJhXyeHku50DBmx/fxFX2N3zT+6CgxP7TjU7fVCUCZjLd4YJNe/
	6cu6qUJLmm1YJr5YXbFsY/rPZVf9VWe4REA5RINQ1w==
X-ME-Sender: <xms:nKQTZn7sg9fuxydSPC6aiQfrfhiJkZiSLxO8zK7A5DsiUT-f6e13vA>
    <xme:nKQTZs4Bw9liDbbsD1ztXiHAuQAyw4lu-Lb6TSAKzBLGvdfZap6fkBJHTFa0WJzeo
    vJ9aqWMmRbCXfZZJZQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudeghedguddvhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:nKQTZucw7zC7JFdoAQvzJD_OFSiA76Bk8p6P9-ZZhj6Fb6J_PCFSOw>
    <xmx:nKQTZoLInmefylyxgIHB3_Pa4Tv6Qr2cUZaRBXB5qFm0NyMUhzEY1Q>
    <xmx:nKQTZrLv25aXlJLG5lT8QSsmJl8oXRkzn0ucTRSBTdH2KJLCNAzR4A>
    <xmx:nKQTZhyX_alJkF3znDEalp8iB2OtaaI1tHjFYU_7UemBToHNw3-xXg>
    <xmx:naQTZi8heEtIapVsAtsq_vsYUD0nePLv0HZ_PUNWsqIRwgxhgsEbeIVR>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 6CE04B6008F; Mon,  8 Apr 2024 04:02:36 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-368-gc733b1d8df-fm-20240402.001-gc733b1d8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <b08dbd71-b5b1-41aa-847e-46149dda2ab7@app.fastmail.com>
In-Reply-To: <ZgLpyDIsHThTT_KG@smile.fi.intel.com>
References: <20240326145733.3413024-1-arnd@kernel.org>
 <ZgLpyDIsHThTT_KG@smile.fi.intel.com>
Date: Mon, 08 Apr 2024 10:02:15 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
 "Arnd Bergmann" <arnd@kernel.org>
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Luis Chamberlain" <mcgrof@kernel.org>, linux-modules@vger.kernel.org,
 "Rafael J . Wysocki" <rafael@kernel.org>, "Jens Axboe" <axboe@kernel.dk>,
 "Ricardo B. Marliere" <ricardo@marliere.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v3] module: don't ignore sysfs_create_link() failures
Content-Type: text/plain

On Tue, Mar 26, 2024, at 16:29, Andy Shevchenko wrote:
> On Tue, Mar 26, 2024 at 03:57:18PM +0100, Arnd Bergmann wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>> 
>> The sysfs_create_link() return code is marked as __must_check, but the
>> module_add_driver() function tries hard to not care, by assigning the
>> return code to a variable. When building with 'make W=1', gcc still
>> warns because this variable is only assigned but not used:
>> 
>> drivers/base/module.c: In function 'module_add_driver':
>> drivers/base/module.c:36:6: warning: variable 'no_warn' set but not used [-Wunused-but-set-variable]
>> 
>> Rework the code to properly unwind and return the error code to the
>> caller. My reading of the original code was that it tries to
>> not fail when the links already exist, so keep ignoring -EEXIST
>> errors.
>
>> Cc: Luis Chamberlain <mcgrof@kernel.org>
>> Cc: linux-modules@vger.kernel.org
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
>
> Wondering if you can move these to be after --- to avoid polluting commit
> message. This will have the same effect and be archived on lore. But on
> pros side it will unload the commit message(s) from unneeded noise.

Done

>
>> +	error = module_add_driver(drv->owner, drv);
>> +	if (error) {
>> +		printk(KERN_ERR "%s: failed to create module links for %s\n",
>> +			__func__, drv->name);
>
> What's wrong with pr_err()? Even if it's not a style used, in a new pieces of
> code this can be improved beforehand. So, we will reduce a technical debt, and
> not adding to it.

I think that would be more confusing, and would rather keep the
style consistent. There is no practical difference here.

>> +int module_add_driver(struct module *mod, struct device_driver *drv)
>>  {
>>  	char *driver_name;
>> -	int no_warn;
>> +	int ret;
>
> I would move it...
>
>>  	struct module_kobject *mk = NULL;
>
> ...to be here.

Done

     Arnd

