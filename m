Return-Path: <linux-kernel+bounces-68896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B6DF85819C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:43:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51D6C288BA9
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C4BF12FB1D;
	Fri, 16 Feb 2024 15:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="ZuspdC6U";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CdpuErcc"
Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A5D12F58E
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 15:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708098127; cv=none; b=BFZJ/lw+fqGH0gx63+Q/O48JCZeWpYfmeCopxLLRgSeY1cwO4EQi1HkIQfTYEQ9s1rsBqOWwTkDHiSuEwhHhDYasQ6kEz6l2tRQME5mi0Hzyg//PdSyYWJ6HXP3nmwruUACAG6vfD5MD9Nsx0+zGNACBbEmHMxZwlavrY2YjRl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708098127; c=relaxed/simple;
	bh=YwWFU5uOs8zzSn6GrqtN3NGSiqYfpg74Nr/4T8Vgy6Y=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=WI0QXLAgCq2B84jApXbp4WGWCmJj4OFjVPFUBbPbhj//NpXAbMW/giUA4f2+K31zYjTOaM5EEg0IFkFTscDG8B+KCvHYTlK6bUWtlsKJ61tA0nlSJ3ZdfnRcvhcfM7fQIiJ+wCgfiG/VlDLM0Be/vSs0wWbc6XmZo8gb3Cneaq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=ZuspdC6U; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CdpuErcc; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 7E5CD11400B1;
	Fri, 16 Feb 2024 10:42:04 -0500 (EST)
Received: from imap50 ([10.202.2.100])
  by compute3.internal (MEProxy); Fri, 16 Feb 2024 10:42:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1708098124; x=1708184524; bh=sUxjDTmnmG
	gAl2CwI/6tSDR1ZH3j5RSpbJn+uyf5Z1k=; b=ZuspdC6ULYqPpjDbug1L1BO9M0
	y97ssMlKCIs63CQCwhr7wnd5YtxtUV5MDcZdwuUTuvw62Lg3NEpN5I50Da+tC4X8
	UGXgVLPqbVge/IwHjjy1ltXTV0/DbFobkc/iVwdZMFypCv/xF8dtJPLNo1HKn7u9
	CT3doUkUzeRBq/k+lr+URzGuNShi8soKUXlliAynBMIvZER407o60B3UWjzG//uG
	yVu8Q9FhQK+w/BUaEQd10mLGxUekO4hHXDdmzMqkMeR2cY/ORBvUTCJJkB4Qtl4V
	mxonLR8kJ9gHiJCJ44PI+Oel1r13EXLuI7Rv+cO9ffQe9p4qNKpUWxksIHCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1708098124; x=1708184524; bh=sUxjDTmnmGgAl2CwI/6tSDR1ZH3j
	5RSpbJn+uyf5Z1k=; b=CdpuErccI8WCZEtHbmtA5kRBEv8/H16Hf7+IkEJhaKc7
	ZU91a6PSs2lf/fF6cXSWTw2lvLLLrojjDpmdVuBQPKFbEw7DKtWPn8s+7DNQ62+0
	HLvUP+4Q1c2MXZXSM7PbtSwB/DFxebztDvivGujZ0GZzOUcGU2mfC7upnBJmK32r
	BSAF+GL+LXdg/cDOD7dupq6mMphym3gC64NA0NYwnGpisC0TAFfaih9/0qQI0XCk
	icNL9VHjkxvey+kPMxh/SQvMvB2yXrdpoIAeiQjTSqnskLh4EYSvh2ClKajwmDjG
	+UMZO4gUJoQ44NWxfIwZ+xeCRbaKkVGy2hcMQjxPbg==
X-ME-Sender: <xms:TILPZVue59Wm_fswr80hlYOic2knwPbIh6T7V21-8zD0iCWafZmA5A>
    <xme:TILPZedKvlkWmyIH0NC8cKxPtc3Ko4BS1luEp5TXeWpGw8yB5ufUR_1GZK2y7iLCk
    lFNYrWt3bWIPmM3eA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddvgdejlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdfuthgv
    fhgrnhcuqfdktfgvrghrfdcuoehsohhrvggrrhesfhgrshhtmhgrihhlrdgtohhmqeenuc
    ggtffrrghtthgvrhhnpeejueehgedtueetgefhheejjeeigffhieefjeehuddvueegtdfh
    heevgfeggfektdenucffohhmrghinhepihhnfhhrrgguvggrugdrohhrghenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsohhrvggrrhesfhgr
    shhtmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:TILPZYzGpYN5iZmIF7Xz88mqp6ndTTW2vN-S_wJLztyZTrOk73bXjw>
    <xmx:TILPZcO96rMeOMp02vucsrpn5orH_glWnR7TarDV6rcPxqlnKmvLOQ>
    <xmx:TILPZV_Cd8cwXYOoufHJsKUXqQcypAQQitJj4CWwfnA_zJetQjGhSw>
    <xmx:TILPZYkzXE5hWx4TEuyAIpNdZCvTwW3up4DuMC0fFNHdEDBkod27rA>
Feedback-ID: i84414492:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 36A631700096; Fri, 16 Feb 2024 10:42:04 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-144-ge5821d614e-fm-20240125.002-ge5821d61
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <4931a861-551f-43b7-bc9d-a48810b686e5@app.fastmail.com>
In-Reply-To: <20240215-icy-oblong-67adb68a4074@spud>
References: <20240213033744.4069020-1-samuel.holland@sifive.com>
 <20240213033744.4069020-3-samuel.holland@sifive.com>
 <20240213-88c9d65fd2b6465fc4793f56@orel>
 <20240215-icy-oblong-67adb68a4074@spud>
Date: Fri, 16 Feb 2024 10:41:43 -0500
From: "Stefan O'Rear" <sorear@fastmail.com>
To: "Conor Dooley" <conor@kernel.org>,
 "Andrew Jones" <ajones@ventanamicro.com>
Cc: "Samuel Holland" <samuel.holland@sifive.com>,
 "Palmer Dabbelt" <palmer@dabbelt.com>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH -fixes v2 2/4] dt-bindings: riscv: Add ratified privileged ISA
 versions
Content-Type: text/plain

On Thu, Feb 15, 2024, at 8:14 AM, Conor Dooley wrote:
> On Tue, Feb 13, 2024 at 03:25:44PM +0100, Andrew Jones wrote:
>> On Mon, Feb 12, 2024 at 07:37:33PM -0800, Samuel Holland wrote:
>
>> Note, QEMU doesn't add these extensions to the ISA string yet, but I think
>> it should start, particularly the profile CPU types which should ensure
>> all the profile's mandatory extensions are added to the ISA string in
>> order to avoid any confusion.
>
> Something to note about these "mandatory extensions" that are names for
> things we already assumed were present - they're utterly useless and any
> DT property should note their absence, not presence, in order to be of any
> use. Anything parsing a DT cannot see "svbare" and gain any new
> information, since the lack of it could be something that predates the
> definition of "svbare" or something without "svbare".

This is consistent with the way we handle other extensions that are assumed
at compile time - if you build with RISCV_ISA_C=y, omitting "c" from
riscv,isa-extensions will not cause an error.

It's also the case for any extension whatsoever that if that extension is
not present in the device tree, no information is provided.

It might be useful for diagnostic purposes to have a "binding version"
somewhere to indicate which extensions _would_ be documented; not sure if
there is already a mechanism for this.  For extensions that the kernel has
a hard requirement on like svbare, see above.

> Shit, but that's exactly why I deprecated riscv,isa.

If zicsr and zifencei were broken out from i today, there would not be a
problem, because i as specified by riscv,isa-extensions would refer to a
specific version that included zicsr and zifencei with a new name for the
new, smaller version of i.

It's not working here because privileged architecture versions aren't (yet)
included in riscv,isa-extensions.

-s

> Cheers,
> Conor.
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
>
> Attachments:
> * signature.asc

