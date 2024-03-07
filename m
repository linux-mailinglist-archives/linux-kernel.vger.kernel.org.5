Return-Path: <linux-kernel+bounces-96298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 876468759DF
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 23:03:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9ADA1C21999
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 22:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0EEA13C9C6;
	Thu,  7 Mar 2024 22:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="K1b/5dgZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QaTlkbED"
Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE031EF13;
	Thu,  7 Mar 2024 22:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709848989; cv=none; b=M2OC8y5a9hkqAlac2c2ap19Q69FYD3iq9H+vqxLNCDIoE2otkiHGkEyNiCXOdL9sO3z8RyYkbPqbtCp/6cwrKmIp6qbDIE5T5xEEYyXq8KIqU5g/niPK4ZOjIMkmerbxsvzXOHWLLQa5D9VROX1dt4adl9oPdzalPf1btxhhgq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709848989; c=relaxed/simple;
	bh=h13ZTm7u1JJO+VYJXOBDXxxL9HqoMuypkPU5m6JDQhI=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=KkkUWvk37UjAtYSp7VDFI/Je+zq2jGxhTFOR+y9hjWMaxtJH0VO6hRm7/6L9dHO7L7EfoW7cCuHZ4QxHXpbbgIQ8N3fkA4mKWTR30i4hPo9sN2pvigxmBc2Jl0G5+wppMnQ9ww7iNsqCNLLFLbgTc0gfyvBg1WzFNIPC01Quic4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=K1b/5dgZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QaTlkbED; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 684421140136;
	Thu,  7 Mar 2024 17:03:06 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Thu, 07 Mar 2024 17:03:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1709848986; x=1709935386; bh=+n2iTlu6tj
	T5UsntdZxAxAKK1QgtXH1QkeKDQAid2y0=; b=K1b/5dgZW2uu76h53FmTmy2+/D
	2rRUzv03JAQLx1lnDHeQ4Msl2DvrLXftlyo0HXwUac460xIlDdJE00fYT0VLpL5l
	dGB0352RafPBh+JVAneFaUJzHlKEO7FBznvilElJWKuN+kIz7FJZlJ3hrvIdyWzD
	paAGlp6lh4/0y6n4fCNfhT9XboGcB4pfwSgHCmK0Clw+hmbw3n4rcJz5JdRf/Eb5
	KGsAEHr+61+d9zoL96Wy3o7HdG23MkCfwPfWv71ctvHnpFhNHR3JXO28hUKbijPF
	RHWl0rEHi4C+F2NoxFMyofOA8x723nO/elfv/ZU76fArFObpmzK4Dph6N4aQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709848986; x=1709935386; bh=+n2iTlu6tjT5UsntdZxAxAKK1Qgt
	XH1QkeKDQAid2y0=; b=QaTlkbED+EM4DSEeBXiBZVbSI3osgFvi3OXEKseEbX0G
	OuQFHmURvXMQSrkSnaEYkU0b35Xcz1bjKA2msnKuKNsWEmZQpVPmv7BCnUV7qUNz
	ZzS8MYN+VjWyPjuy8+j70hlkD8IN2nWcMGGpH7neOIRqc1Hh/nrHvYfM9YK8S9aa
	ij86MkyLjmxgT2bT068MaPVYo9qAOtP1VkDlwN1NLWBjpNSxIeYX8GHuTlAOWwh5
	+GLfim7bd1M55uWNWjSXeri8INLufBBDUCMTkMekobe4v803Mmskt96XVIJVrmKK
	DgJ+x6Gn7fEWncyoldP7pDmi7wkWEFNTq3HIjf3fHw==
X-ME-Sender: <xms:mjnqZbC6NOjHp83n4Y0SnafZs3bXxNp2SH_F9_MZoEkKqgJjsizgVA>
    <xme:mjnqZRi5Y0C8Ya9NEZy_Lrq25GnKEYgVylqcrg7zPTZsmKuMfEf3N906_-BVZ4aN_
    DrQTdYGm5tlWIzEUEo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrieefgdduheehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:mjnqZWm3QWz2WI1zK066S-mjC94Fj0BqnHXLUq2XTHXh9XTqgUyKdg>
    <xmx:mjnqZdzZcorw4PN2gRFwGDqhnzqwzoo0EEmvcONC-PB72qz58EtBFg>
    <xmx:mjnqZQQvtv0qEi-GAVlwVdX0SuAweSztF1CnBo9xT9dLm3Yujk7Rug>
    <xmx:mjnqZdgb4rZgBFb5WgJ3gqdrHtj0Io2FM5cvmpdA83knl485-DTesQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id E8C54B6008D; Thu,  7 Mar 2024 17:03:05 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-251-g8332da0bf6-fm-20240305.001-g8332da0b
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <db9bc2dc-6a66-4248-b8ab-abc2723af053@app.fastmail.com>
In-Reply-To: <202403071112.01B4579@keescook>
References: <20240305221824.3300322-1-jeremy.linton@arm.com>
 <20240305221824.3300322-2-jeremy.linton@arm.com>
 <202403051526.0BE26F99E@keescook>
 <34351804-ad1d-498f-932a-c1844b78589f@app.fastmail.com>
 <38f9541b-dd88-4d49-af3b-bc7880a4e2f4@arm.com>
 <f1dd15ce-69af-4315-8d7c-b7a480e541aa@app.fastmail.com>
 <202403071112.01B4579@keescook>
Date: Thu, 07 Mar 2024 23:02:44 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Kees Cook" <keescook@chromium.org>
Cc: "Jeremy Linton" <jeremy.linton@arm.com>,
 linux-arm-kernel@lists.infradead.org,
 "Catalin Marinas" <catalin.marinas@arm.com>, "Will Deacon" <will@kernel.org>,
 "Jason A . Donenfeld" <Jason@zx2c4.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 "Mark Rutland" <mark.rutland@arm.com>,
 "Steven Rostedt" <rostedt@goodmis.org>, "Mark Brown" <broonie@kernel.org>,
 "Guo Hui" <guohui@uniontech.com>, Manoj.Iyer@arm.com,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
 "James Yang" <james.yang@arm.com>, "Shiyou Huang" <shiyou.huang@arm.com>
Subject: Re: [PATCH 1/1] arm64: syscall: Direct PRNG kstack randomization
Content-Type: text/plain

On Thu, Mar 7, 2024, at 20:15, Kees Cook wrote:
> On Thu, Mar 07, 2024 at 12:10:34PM +0100, Arnd Bergmann wrote:
>> There is not even any attempt to use the most random bits of
>> the cycle counter, as both the high 22 to 24 bits get masked
>> out (to keep the wasted stack space small) and the low 3 or 4
>> bits get ignored because of stack alignment. If there was
>> any desire to make it more random, a trivial improvement
>> would be:
>> 
>> +++ b/include/linux/randomize_kstack.h
>> @@ -80,7 +80,7 @@ DECLARE_PER_CPU(u32, kstack_offset);
>>         if (static_branch_maybe(CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT, \
>>                                 &randomize_kstack_offset)) {            \
>>                 u32 offset = raw_cpu_read(kstack_offset);               \
>> -               offset ^= (rand);                                       \
>> +               offset = ror32(offset, 5) & (rand);                     \
>
> Shouldn't this stay ^ instead of & ?

Yes, my mistake.

>>                 raw_cpu_write(kstack_offset, offset);                   \
>>         }                                                               \
>>  } while (0)
>
> But yeah, we should likely make this change regardless.

Ok, do you want to send a patch, or should I?

     Arnd

