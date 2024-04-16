Return-Path: <linux-kernel+bounces-146731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EED958A69FE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 13:56:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B7761C20FD7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 11:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 185F512A174;
	Tue, 16 Apr 2024 11:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="TZBJaeaO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YWD6x8Ms"
Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B461292DB
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 11:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713268580; cv=none; b=OV6Gx9/nW3si6grFKXLz37kgil4OUI42owvvu5vKDog38QbCFerjrOmNUEweTbCYdyViarbOKPqtRRvinIkIzWfgiGOb9zQeZDkkZLur/tZqxgWasbtoYadVdePyoGGpK5fSCcPhQP2uPWpY2snBwE1LkUJCT1G0Op0gqpWYaDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713268580; c=relaxed/simple;
	bh=bsPGy+NGN3PslT5YVV+jNDgdS2kXGSlLU5Q3qCgog9k=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=lwNr9dK9ruiuO4vMMpJIPW9qu11qNsJjun4PNjJ/cYifk8fTKOLnOd1TIDgAUUL4h+0yd616RJxDSoJNrVi0LysjNuCOouCAQRiaT2+14k0mEK9Ps4xscylU0mUSqQEwvMtk/XJmIavwb9p6iA8mNlh3uoE0II10sDLTMdH2d7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=TZBJaeaO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YWD6x8Ms; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id C71911380923;
	Tue, 16 Apr 2024 07:56:17 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Tue, 16 Apr 2024 07:56:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1713268577; x=1713354977; bh=h7Ln9pZ+NP
	UuES0mE7CzS9ETsJon3TNjqsNEMWr/MVg=; b=TZBJaeaOb0soz5m3pqRKVJFAZ6
	6izkxtQ1BDmlqo+a9lvABlWI6XZmJM8qlnZKzuMq8rea5riO39xA3OBN4tiahpGW
	efy9MR+77P2HzmVYrevSldIlU9fc5UEECnXiCA6U7pFSY12n2/ebCjTlIAHLy9DP
	EEPbqNrUOkIeFJxdPC4KEZRDMRcHw5ggujpkUUwlm/y4yZal8urYAuMTYcrewhm4
	8pDsV2/teineypM1QjXrEmEV9etIThOBOBxYp77YVf/8DD/pzewhdiWREj7z8+MX
	8jtSqPRqyYZDdE8wqobU8M1wwApTNcd7Pclztq2XxPE2C+eA4C/iGbND+icQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1713268577; x=1713354977; bh=h7Ln9pZ+NPUuES0mE7CzS9ETsJon
	3TNjqsNEMWr/MVg=; b=YWD6x8MsxAjQlo1yywyXxb3v/kbjviAjfzyzz5IMQX7Y
	VJaaE3UTITJwIXJ6e52Eq+zWeAinVDNBWRenMLn64W1dv1iQRd1FWWW/xdy/s6nI
	c1gofNB7RhaIcHjYiqH69J9FJq8wtAKma0mcRbV/dJBAIGGouMFQWC1XemA4Dlyn
	BO2AwB4DkQEJ5tCLA3yoy4+vPOTBgEGWL6zlx5dOYkRuH1Pbjp/22Zy23hlo9n3L
	l5hZUk581ge5R5027gTa7CoEy53TD+Ew9pUYfslcEgC2kCO3NAziKb/agzg5XzCM
	wRNCSDhsIOjafW04RN2r7ImLnCApwjUCyIh21gqBUQ==
X-ME-Sender: <xms:YWceZtbf-_WHpoVzfU21gFsABKry4JZb8IitZfqUBfOJBKNMnPMpFw>
    <xme:YWceZkauljyiD1MeCrigtaDtBFFowPqi2BXKFolY-Z9QhxAKjZlJ4qTYbHAjYT8Tw
    bGneYsrH6C01xbIFLw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudejhedgvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:YWceZv9vo4AHySWT_OZdZsnc4uBjJ-ictSJYEKgQwE-xwrvbmxaXqw>
    <xmx:YWceZro1LUIDNMKlrR6h-juc8AN9RAkY2cSftGwM78qGav_AI7CuXA>
    <xmx:YWceZorAQNt07Imz0vMyVoPhjdGGM53gL2IAbe4FDFglVKL9J0mejQ>
    <xmx:YWceZhSTrDOAKvkeiAbNO8_dDUy--R25lICa1a3kYAz4-ptVKWQBzg>
    <xmx:YWceZjBqMyo36wIOh3Ce_9N3NZFvSm46pPP3yKZ8KbhUmbY8xCDe6ibk>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 4441BB6008D; Tue, 16 Apr 2024 07:56:17 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-379-gabd37849b7-fm-20240408.001-gabd37849
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <f7d8cd55-5a14-4391-884f-0b072790fa41@app.fastmail.com>
In-Reply-To: <3d139886-9549-4384-918a-2d18480eb758@app.fastmail.com>
References: 
 <CA+G9fYtEh8zmq8k8wE-8RZwW-Qr927RLTn+KqGnq1F=ptaaNsA@mail.gmail.com>
 <3d139886-9549-4384-918a-2d18480eb758@app.fastmail.com>
Date: Tue, 16 Apr 2024 13:55:57 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Naresh Kamboju" <naresh.kamboju@linaro.org>,
 "open list" <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org,
 "Linux Regressions" <regressions@lists.linux.dev>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 "Anders Roxell" <anders.roxell@linaro.org>,
 "Kees Cook" <keescook@chromium.org>,
 "Niklas Schnelle" <schnelle@linux.ibm.com>,
 clang-built-linux <llvm@lists.linux.dev>,
 "Nick Desaulniers" <ndesaulniers@google.com>,
 "Nathan Chancellor" <nathan@kernel.org>, "Jeff Xu" <jeffxu@chromium.org>,
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
 "Dan Carpenter" <dan.carpenter@linaro.org>
Subject: Re: powerpc: io-defs.h:43:1: error: performing pointer arithmetic on a null
 pointer has undefined behavior [-Werror,-Wnull-pointer-arithmetic]
Content-Type: text/plain

On Tue, Apr 16, 2024, at 13:01, Arnd Bergmann wrote:
> On Tue, Apr 16, 2024, at 11:32, Naresh Kamboju wrote:
>> The Powerpc clang builds failed due to following warnings / errors on the
>> Linux next-20240416 tag.
>>
>> Powerpc:
>>  - tqm8xx_defconfig + clang-17 - Failed
>>  - allnoconfig + clang-17 - Failed
>>  - tinyconfig + clang-17 - Failed
>>
>> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>
> I'm not sure why this showed up now, but there is a series from
> in progress that will avoid this in the future, as the same
> issue is present on a couple of other architectures.
>

I see now, it was introduced by my patch to turn on -Wextra
by default. I had tested that patch on all architectures
with allmodconfig and defconfig, but I did not test any
powerpc configs with PCI disabled.

     Arnd

