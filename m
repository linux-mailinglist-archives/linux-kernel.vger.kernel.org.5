Return-Path: <linux-kernel+bounces-46143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07F5A843B30
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 10:33:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B77E82894E5
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 09:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 277426350C;
	Wed, 31 Jan 2024 09:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="bSn4THvb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oigmsgoI"
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE306774E;
	Wed, 31 Jan 2024 09:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706693607; cv=none; b=a4W0WkU9cYM3HmwvB+flTV0/EP/0u6tIX1K6uTBqxHXCHY7EPm9Iy1R49UfOQuakN+27e8QdsQYbDPZvo7yHD1GvTpt77oStcVbSDQ79hVx2ooRvV2y1NQkVe+A76OvLFd6t73V3Ot27BgGAvfbcRVvTjkTZ5c1Dok2Vslaankw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706693607; c=relaxed/simple;
	bh=SAcxu58CKy8uuW+Xv3xqsXot/kKkgjf2e5FL6zSemnE=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=YJiIhfCM6coYvAiksxfTxqFzGsw1F0dXJt+oGzfYvftM4Z7gnNBIQSP2+yt0TEttG5/9KJF1Q/G6HUsDrWk8dGeCjhp0pRigYMZRtyqnfrwFVRV5sgmu9e2Pg0I8Dq9acdFeGnDy4WDKWLxvabn2k2I/a4TDEXMQq3hOEWYHc1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=bSn4THvb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oigmsgoI; arc=none smtp.client-ip=66.111.4.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 04E625C00CE;
	Wed, 31 Jan 2024 04:33:23 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Wed, 31 Jan 2024 04:33:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1706693602; x=1706780002; bh=zfFTIJuMke
	XWXqP1X9CM0AfUVjTJrLkI22bHlsMbmtw=; b=bSn4THvb3TNzacAXhTziKRl5rh
	em6ZTUsdUJUsNMIzHZAlPH/1xeZqsrJAi5uO+4udjh12g5xLfLgQYDe1mO2XxRtB
	1TLw9nJgsgXCa6Ev2O9ki1haskqZrxDBf0aCheZRxM0Tfq/kC/l6rE4Uxp5V/mop
	Uyc05OnShT3Ow1NJGsuVkNMx1l7NYmOx50NA+QID4bpVIGiPWD+dSe4zYGnijSYG
	75hR5solZGQXgJKEUL4wKhqTMrinzElUNUPLcsj6Fjifv9uedR+hDdCuk8VTNfqq
	h5C98oj021rWDFM5haCHo4IrDgXT/CRQv1fNSgbjJ4ho/6yffnKI1ArjyvrQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706693602; x=1706780002; bh=zfFTIJuMkeXWXqP1X9CM0AfUVjTJ
	rLkI22bHlsMbmtw=; b=oigmsgoIRcR/hClDiIcHKTJBEMKvbpFKKx6R3l8pRfdI
	Vx74VCDzlM85cr2ridYUVdbvEsZ1NiVUeJGYBwjb/KQeIKieImcZgWJNTNoKdori
	ZMW2efPJoF9tTfewUgPygwdom4VHTEmR3mMaGkFEr8i6TItuuYIrACXLT2xBzGKJ
	rniO4Az8EBb5KRXnavAIh7qJSEQbqGFMx2TYgYmd8zoSOem22M6SlRrBVJCqpRia
	TVK7v0RecAJOOLIXvuJOFk+AcsEjniiqZLBnHkSbD92jo2HYsjoDkwbVPwssYmzn
	XwFUvCZzXE7X7zhYSWhCx74CzGgOXMIhh+ZDvah73g==
X-ME-Sender: <xms:4hO6ZSDyts5aymwbcqXhOpRv0NxSxSa2UKeaCznOpdlSQVr4IJCxqQ>
    <xme:4hO6Zcjz454H0hMy7oS-pS7TI1rnKjkNJ4UsVwOBJjIjr6EqnnZBz5WseBxtWDRXk
    RmoDtpqmmRCmPSYfhA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedtledgtdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:4hO6ZVnU1Je3RbLMfWXzYNYVf-vOuAmn3LwXu_JuyFMU2WcH8KegxA>
    <xmx:4hO6ZQzMVRFHjHlgoA45o1frQlsonOJJIG8Hrr_yDlxoNc-Xz9HDvA>
    <xmx:4hO6ZXRtLjYqwGq6bwLd4PgDubiIaysXdJ2KLX5fkULA2lJA-syrdQ>
    <xmx:4hO6Za9ZjHmo9sg797cPxDJg4WV7uKUAbwDU7WfE4Ho3o2nuVuC0BA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 08CC4B6008D; Wed, 31 Jan 2024 04:33:21 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-144-ge5821d614e-fm-20240125.002-ge5821d61
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <682f037e-0efe-4d73-b867-f1f86a244836@app.fastmail.com>
In-Reply-To: 
 <0be49d4d7d7e43933534aad6f72b35d3380519fd.1706603678.git.haibo1.xu@intel.com>
References: <cover.1706603678.git.haibo1.xu@intel.com>
 <0be49d4d7d7e43933534aad6f72b35d3380519fd.1706603678.git.haibo1.xu@intel.com>
Date: Wed, 31 Jan 2024 10:33:01 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Haibo Xu" <haibo1.xu@intel.com>
Cc: "Alison Schofield" <alison.schofield@intel.com>,
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
 xiaobo55x@gmail.com, "Anup Patel" <apatel@ventanamicro.com>,
 "Tony Luck" <tony.luck@intel.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Russell King" <rmk+kernel@armlinux.org.uk>,
 "Samuel Holland" <samuel.holland@sifive.com>,
 "Evan Green" <evan@rivosinc.com>, "Palmer Dabbelt" <palmer@dabbelt.com>,
 "Andrew Jones" <ajones@ventanamicro.com>
Subject: Re: [PATCH 4/4] ACPI: RISCV: Enable ACPI based NUMA
Content-Type: text/plain

On Wed, Jan 31, 2024, at 03:32, Haibo Xu wrote:
> diff --git a/drivers/acpi/numa/Kconfig b/drivers/acpi/numa/Kconfig
> index 849c2bd820b9..525297c44250 100644
> --- a/drivers/acpi/numa/Kconfig
> +++ b/drivers/acpi/numa/Kconfig
> @@ -2,7 +2,7 @@
>  config ACPI_NUMA
>  	bool "NUMA support"
>  	depends on NUMA
> -	depends on (X86 || ARM64 || LOONGARCH)
> +	depends on (X86 || ARM64 || LOONGARCH || RISCV)

The dependency is no longer needed now since these are
the four architectures that support ACPI now that IA64
is gone.

All of them also 'select ACPI_NUMA' by default, though on
x86 this can still be disabled by manually turning off
CONFIG_X86_64_ACPI_NUMA. I suspect we don't actually ever
want to turn it off on x86 either, so I guess the Kconfig
option can just be removed entirely.

     Arnd

