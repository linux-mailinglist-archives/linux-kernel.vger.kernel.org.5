Return-Path: <linux-kernel+bounces-47672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7CC784510B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 06:53:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAD701C2638B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 05:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2359823BF;
	Thu,  1 Feb 2024 05:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="eZ9y/iTI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="acM4PUYP"
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F142823BE;
	Thu,  1 Feb 2024 05:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706766755; cv=none; b=h5Twd/6Q0o7g8tTKrOZMr+WJbn/QeHWWAMEtloELu6c3nhVHlmAC9uCGJFHgDsa2PZaIZNtgAA7KDC52JOVSlnHYtiqU1R6UHod5u0MuHMlvX066ySJ0iUo+jUgPXcezXqffLS6z6fRp4Q4+swj1y3fuxp4PDlU7XC+3u2x/0ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706766755; c=relaxed/simple;
	bh=UbH1LhRiDI0ioxkNf9RPkubc5YaMrjdhQUmIQIMkHwU=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=D9fMm4sASJ3Q9I5IDk4nmu8ZFAPwWZyd94qaVnZ1NZWS0xXyylaQEcCtY1rPrgtU+xig0xI4IW7zqW3LaMTc+X8aJt2WHYxeP9GmJY3SxufNPiJlzJf/ZI6W4e92GJQY+I9oOt+5l8QF0rY/kBWpI4/Qy2GnHgiNedSy/bYqrkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=eZ9y/iTI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=acM4PUYP; arc=none smtp.client-ip=66.111.4.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 6154D5C00CD;
	Thu,  1 Feb 2024 00:52:32 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Thu, 01 Feb 2024 00:52:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1706766752;
	 x=1706853152; bh=zEgYM9ib8uGx7d/JTunm4wFeCd5N9eP8RpFnlN/mwpA=; b=
	eZ9y/iTIat4bvibXxHDOZNu8+z/foRAjW1+VrEi6mBJ0me+ew8hwvF7N0yvAZrB1
	uBVZ7wxx/MnXWORGF2Bvd/tIBNuM+15CaQLOAP6gP4+Qu7XxJo/cf+YWtQa8mX29
	nsaV8xWk6jZlqUz5R+vHNjzS6IbmCyxaPPu6fuY1tXzgchxnZJqX3D6JEwiZFATA
	R2qV9mo33w1D7TB1DtYIt+LPCOkUGx7iZ+dAWXJNjYVdqLEsahLFDCCiUs0tUR1W
	r84xxbG+OEVsP0FsrP68IqEIgfd0kfn4hLbe8a0waMaUF5XY/58bEGwhuOrfx/0y
	qpnMrff43l2O3faJa8UhYw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1706766752; x=
	1706853152; bh=zEgYM9ib8uGx7d/JTunm4wFeCd5N9eP8RpFnlN/mwpA=; b=a
	cM4PUYPSdqNYiCoOnCbyCcMPcJCaqjfk70ukJFUoi+P8EAwb4tn6fhn7s8pShigj
	yEug/zu/+8Ls4i4Fg5BOi60wbYh+y8Qgu76RjZCbBglrd+Jurt+TnCo6/8132io5
	IKQtROMxazV1ndOp1v670HoJgX9fR3TB6Fw9t/x0fsSoEg4VIZxlYgZgr2bVBvs8
	J8JLEDgSwPjNQIRQ6yUJELu5Do1iKEMd/BplhgRYwUFO4nsWVDgRAgM6hIHVsj/W
	Z9/WNwvpfG+Ram++QTG2eAtIkVDKozIObQKPK4/83xUBs7f01S6n/SJcJmcTm+dO
	oBWtSqVO0mzqw/OGY3K0Q==
X-ME-Sender: <xms:njG7ZW3gFFkAEClduSd1WA3yuVUi2pRf-kG1dAZ42lccSVmkoNMnAg>
    <xme:njG7ZZGY92FC9hk9ptv04xX9IhLOfxssTxcROt2rk2cchjCcDftz5MdnANR2Pe4aX
    BrD9o_y9T9THpdIsS4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedutddgkeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeegfeejhedvledvffeijeeijeeivddvhfeliedvleevheejleetgedukedt
    gfejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:njG7Ze6TioQfgIdzUhVynFTxGZNUYJ80nhGOc4H3Xry9oz_qyiXQBQ>
    <xmx:njG7ZX08NPgCi5esQhZfiJOQXJ9EIMkGM5io1nY5rkqE9tolAtfjjA>
    <xmx:njG7ZZHTFQLCCFJSF1P-Cqx31v8Ftxw63nzvu4LFfVD4zB6F80YHIg>
    <xmx:oDG7ZRgX3MDz0o7mz_-Hi4SELgNbYMUDEzt3Ijx_0hPL4gmIV_4yVg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id BDCBAB60092; Thu,  1 Feb 2024 00:52:30 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-144-ge5821d614e-fm-20240125.002-ge5821d61
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <6abae3ef-fc91-4283-b6a3-20810ececfe8@app.fastmail.com>
In-Reply-To: 
 <CAJve8okV_9qs6urESw2N-v8LT2-QP40jc1WhHYci7n-r9EoA9Q@mail.gmail.com>
References: <cover.1706603678.git.haibo1.xu@intel.com>
 <0be49d4d7d7e43933534aad6f72b35d3380519fd.1706603678.git.haibo1.xu@intel.com>
 <682f037e-0efe-4d73-b867-f1f86a244836@app.fastmail.com>
 <CAJve8okV_9qs6urESw2N-v8LT2-QP40jc1WhHYci7n-r9EoA9Q@mail.gmail.com>
Date: Thu, 01 Feb 2024 06:52:10 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Haibo Xu" <xiaobo55x@gmail.com>
Cc: "Haibo Xu" <haibo1.xu@intel.com>,
 "Alison Schofield" <alison.schofield@intel.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 "Dave Hansen" <dave.hansen@linux.intel.com>,
 linux-kernel@vger.kernel.org,
 "Conor.Dooley" <conor.dooley@microchip.com>, guoren <guoren@kernel.org>,
 "Jisheng Zhang" <jszhang@kernel.org>,
 "James Morse" <james.morse@arm.com>, linux-riscv@lists.infradead.org,
 "Ard Biesheuvel" <ardb@kernel.org>, "Baoquan He" <bhe@redhat.com>,
 acpica-devel@lists.linux.dev, "Robert Moore" <robert.moore@intel.com>,
 linux-acpi@vger.kernel.org, "Sami Tolvanen" <samitolvanen@google.com>,
 "Greentime Hu" <greentime.hu@sifive.com>, "Len Brown" <lenb@kernel.org>,
 "Albert Ou" <aou@eecs.berkeley.edu>,
 "Alexandre Ghiti" <alexghiti@rivosinc.com>,
 "Dan Williams" <dan.j.williams@intel.com>,
 "Chen Jiahao" <chenjiahao16@huawei.com>,
 "Yuntao Wang" <ytcoode@gmail.com>,
 "Paul Walmsley" <paul.walmsley@sifive.com>,
 =?UTF-8?Q?Cl=C3=A9ment_L=C3=A9ger?= <cleger@rivosinc.com>,
 "Anup Patel" <apatel@ventanamicro.com>,
 "Tony Luck" <tony.luck@intel.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Russell King" <rmk+kernel@armlinux.org.uk>,
 "Samuel Holland" <samuel.holland@sifive.com>,
 "Evan Green" <evan@rivosinc.com>, "Palmer Dabbelt" <palmer@dabbelt.com>,
 "Andrew Jones" <ajones@ventanamicro.com>
Subject: Re: [PATCH 4/4] ACPI: RISCV: Enable ACPI based NUMA
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 1, 2024, at 03:58, Haibo Xu wrote:
> On Wed, Jan 31, 2024 at 5:33=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> =
wrote:
>>
>> On Wed, Jan 31, 2024, at 03:32, Haibo Xu wrote:
>> > diff --git a/drivers/acpi/numa/Kconfig b/drivers/acpi/numa/Kconfig
>> > index 849c2bd820b9..525297c44250 100644
>> > --- a/drivers/acpi/numa/Kconfig
>> > +++ b/drivers/acpi/numa/Kconfig
>> > @@ -2,7 +2,7 @@
>> >  config ACPI_NUMA
>> >       bool "NUMA support"
>> >       depends on NUMA
>> > -     depends on (X86 || ARM64 || LOONGARCH)
>> > +     depends on (X86 || ARM64 || LOONGARCH || RISCV)
>>
>> The dependency is no longer needed now since these are
>> the four architectures that support ACPI now that IA64
>> is gone.
>>
>> All of them also 'select ACPI_NUMA' by default, though on
>> x86 this can still be disabled by manually turning off
>> CONFIG_X86_64_ACPI_NUMA. I suspect we don't actually ever
>> want to turn it off on x86 either, so I guess the Kconfig
>> option can just be removed entirely.
>>
>
> Good catch! Will revert the change in the next version.
>
> To remove the dependency entirely, I think we need a separate patch fo=
r it.
> What's your opinion?

Agreed, that last bit would need to be acked by the x86
maintainers then, as it only affects them in practice.

     Arnd

