Return-Path: <linux-kernel+bounces-111899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF43E887257
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 18:57:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D1EE1C23890
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 17:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B43A60DD5;
	Fri, 22 Mar 2024 17:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=craftyguy.net header.i=@craftyguy.net header.b="YefMcjDu"
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C8260BB7
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 17:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711130228; cv=none; b=aQ5NSfRr79kxRVBNzRU865x5l+w3mZ+rLMIpVIyB1RAX7IPzZfcsoJQoORP8CjystCFQxYpmbcGLMWSNJt04ZeKyWUVGjkOQEvptGana5A+FCFqAhWUKzHPC6dgmL/mUHWFSis8eLMsqOGMp7p3Yi2I7B2sAbA7rGlrhwakahVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711130228; c=relaxed/simple;
	bh=GOaDAfKIwYJMXMttYU5xrZYRWFH8Axb85aDlLZ/MHUc=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=hbfbAqPfzN2RdYCCudSGJOWavCiiOYlOtdD7lcSHN+F/iklw4dM/YQuXQxJ7FifX2ueeX4a+O7SFkYAFUBDt0DrxR8FfzAdgbUzgSUmE3xfH5RDhExD8a1WJvmCqTd7v/s8Hd/pqDrfJocuUgNPkSQVJ98GnFsvRfHCUGcd0BIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=craftyguy.net; spf=pass smtp.mailfrom=craftyguy.net; dkim=pass (2048-bit key) header.d=craftyguy.net header.i=@craftyguy.net header.b=YefMcjDu; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=craftyguy.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=craftyguy.net
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=craftyguy.net;
	s=key1; t=1711130224;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YudYEjU2aj1tRkCPMZdhkWAFRPscPYsfidHJdnSxDNw=;
	b=YefMcjDuxr17W58utUapTKOhMNE6r3wYwzNwUUFLzsTTppRfAOiUMgzDMQDt3H6qE7GjHu
	FHOVv6Lr2OSizsS5+GkHu6pnEJV6+XAoeqvON4HCOLfr2oqXxMdiWIYa0+5CMXPPbK/1Am
	20Dg0TGKZwsTAxWBR2vCWuyIMXPUObu6iaZlbd1hVXu+Mfn0Sar9nMHL0JmwFYJyJXW1GA
	LgmXpB9cwG2IOevOXNdKYU+IfQhsLEqp8XMZlbmGl/PDOP7tNqP2OJ6tcKhskoNJ0KluGg
	4BqM+40Gl4QTKsFwA+C1lDFDH5aIXQvhVgobWvqyxtPfz3FDAIiACtuTN1kRKw==
Date: Fri, 22 Mar 2024 17:57:01 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Clayton Craft" <clayton@craftyguy.net>
Message-ID: <fe09869c2d853bde8ce0feb537c4dab09014f5d9@craftyguy.net>
TLS-Required: No
Subject: Re: x86_64 32-bit EFI mixed mode boot broken
To: "Ard Biesheuvel" <ardb@kernel.org>
Cc: "Hans de Goede" <hdegoede@redhat.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org, "Thomas
 Gleixner" <tglx@linutronix.de>, "Ingo Molnar" <mingo@redhat.com>,
 "Borislav Petkov" <bp@alien8.de>, "Dave Hansen"
 <dave.hansen@linux.intel.com>, regressions@lists.linux.dev
In-Reply-To: <CAMj1kXFmnv+FGRMnnJMJejj5yvSybgZTNEYZz0hxb6K9VAeo1Q@mail.gmail.com>
References: <20240321150510.GI8211@craftyguy.net>
 <CAMj1kXGzH4TiwvSF3bZsJpuuWf04Ri_852fUMTdH8pLRaH3+Yg@mail.gmail.com>
 <20240321170641.GK8211@craftyguy.net>
 <CAMj1kXE-sxGM2H8akunJ1mZPDSVX1+2ehDtK-jqW--8tw9J5LA@mail.gmail.com>
 <20240322091857.GM8211@craftyguy.net>
 <CAMj1kXFmnv+FGRMnnJMJejj5yvSybgZTNEYZz0hxb6K9VAeo1Q@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

March 22, 2024 at 9:51 AM, "Ard Biesheuvel" <ardb@kernel.org> wrote:


> > As I mentioned initially, I bisected my failure to e2ab9eab32. Does t=
hat give
> >=20
>=20>  any hint about what might be the problem?
> >=20
>=20
> Not at all, unfortunately. What we might try is to back out the
>=20
>=20changes step by step. I can prepare a branch for you if you like.


Yeah sure, if you don't mind! I'd be happy to test changes in a branch to=
 try and figure out what is causing this.

-Clayton

