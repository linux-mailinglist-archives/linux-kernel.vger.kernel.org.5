Return-Path: <linux-kernel+bounces-35437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36DFE839117
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 15:16:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDB161F2A692
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 14:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E924B5DF0E;
	Tue, 23 Jan 2024 14:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="bkZ0rzXP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Zmu5XaEi"
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019A85FDB1;
	Tue, 23 Jan 2024 14:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706019281; cv=none; b=VDg0dnB9lU+i9w6BJFlVjF3UFHlZyQFqgjWtRZtkRCU/pI1H4wXfYkD2BX2jTli+JCWybY8v0Vs9/2I/tl0ireOYO7GjkqTld3bcTHIOne6kKT7eNApBymeQyFRt7i13P8KIBWK24MgnKrsGQtOJHspN+lwEX2SOz8gBxnNKJB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706019281; c=relaxed/simple;
	bh=lWkMMocOvfes+g5V2utdF5jBD0MEtS/bswwdDGcZGKs=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=n31qmOLPQR0NmE9C7VmS1R7VOVSM0X1dQzRYf/g0AxUPX5nILQMA+o5WMcEOjDa6k9ztkdpBV8ssvAMRAwszXepFT2DOuOC32QLASrDJh5ppucr8+6hWDerIDMKKl5GFalZRyI410x/jAjsmxdvq6etanyESvs3TsTUIZSA7gKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=bkZ0rzXP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Zmu5XaEi; arc=none smtp.client-ip=64.147.123.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id 73B243200AE1;
	Tue, 23 Jan 2024 09:14:37 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Tue, 23 Jan 2024 09:14:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1706019276; x=1706105676; bh=d4pIxWNynI
	YT3Te0hZUQ5p/KQ9LDcVc3qWXc5mhGEyU=; b=bkZ0rzXPvbSFyYP2ANDLn6MSLH
	KUddIjOomdwE9AeUmbATWpaLlsFmXZ9LREdbQD8pPkY/qp2NxF3DHcVsWpWrwrMI
	NugTh+15n/qCae+NH4PL3ROE8Dq1VINE8gUMloTIvY1Z0URwuLCElYp3SEXqOaoT
	bBDZ6EL6PSkip1/BuGFKbXdnYm3eFPQk723kLhiRzzQHlzp+Gn8dB/DEukAzalJr
	fDQM7ssCFPtWAm1N9qAn1soVl77dfiN5Zhoxn0A9XjEIPv5KsznvW3Cl1viFLa3c
	CwGzTY0NgRApU3ixnpWCOCEnmxeqfVKggzBxJ2bY4eNm5ZUWkYYIOccIxLPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706019276; x=1706105676; bh=d4pIxWNynIYT3Te0hZUQ5p/KQ9LD
	cVc3qWXc5mhGEyU=; b=Zmu5XaEigsBCc1ydxeSrS9m1l8LY4z0XBdWFCoV7EWNx
	aJseoq4yg1mAivcgOECYbIYjBaG5blllyoxWy9VbMOBftCTjIrOHOayYTotTcgV2
	uunmP8lst8woYFfCmhBCGviwQHo3rAiOyQqxAsytpkshhXAH7Q97fmISn0uvvK76
	QeI7bq8ddy3E9GN0E/cLmsOeHkPcLafX95ObduDVbIu1r0Y14aGJXxX7JgDAIqfR
	t8wVcTvHDaAJydgR0KL7yMqCIyEWZzoGZB3qFLDdDX8+j9li2n8/OTNT808S/dwY
	U+DPAOx0uzRGfMa6Xr5k5wQK05hATROEnxlX6bQywQ==
X-ME-Sender: <xms:zMmvZa2hbZoJO6WbSZXgBJAkZO7ZhxMwgwyaGloBtMcXcr84enxxSQ>
    <xme:zMmvZdFgYZlBQNjTDiq1B2nI2NYFhIEX8HaObz6pXw3C56TYXLsYfZ1gL09fLH2PC
    wgXqkhjcXmZAIyQ9c0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdekkedgiedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:zMmvZS5XfkG5lIodfJrXzuKi8MIWx2MonVJKa6tUCAacM-zljcuADw>
    <xmx:zMmvZb3eaexeDL8cuzGzwVPZzJwkjbFfS3AduTu7pH7vqy9mmoztuA>
    <xmx:zMmvZdFosT_ukRVqeY7PuSC-Dsyq17cAGB_-isVjYj7U-YBDCwmG8w>
    <xmx:zMmvZRh_FipElD_lSFfAKewurYFZt8soexcRUx2psCZPoVqrVXVoUQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 36969B6008D; Tue, 23 Jan 2024 09:14:36 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-119-ga8b98d1bd8-fm-20240108.001-ga8b98d1b
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <8d37ad26-efdf-4e10-9a72-d49e37de0307@app.fastmail.com>
In-Reply-To: 
 <1ab7594855718e24ddc629ebbab1edc8bdcd799a.camel@physik.fu-berlin.de>
References: <20240123132335.2034611-1-arnd@kernel.org>
 <1ab7594855718e24ddc629ebbab1edc8bdcd799a.camel@physik.fu-berlin.de>
Date: Tue, 23 Jan 2024 15:14:04 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "John Paul Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>,
 "Arnd Bergmann" <arnd@kernel.org>,
 "Yoshinori Sato" <ysato@users.sourceforge.jp>,
 "Rich Felker" <dalias@libc.org>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org
Subject: Re: [PATCH] sh: use generic uaccess
Content-Type: text/plain

On Tue, Jan 23, 2024, at 14:55, John Paul Adrian Glaubitz wrote:
>
> Wouldn't that make these operations slower or do you think that GCC is able
> to optimize this well enough?

It's only single load/store instructions, so it should make no
difference. If anything, the generic code should allow the compiler
to have better register allocation and produce better output than
the assembler version (which is how this avoids the ICE), but it's
unlikely to be noticeably either.

> Also, this is something that should definitely be boot-tested to make sure
> this doesn't introduce any regressions.

Agree.

      Arnd

