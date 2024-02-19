Return-Path: <linux-kernel+bounces-70901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B5A3859DC2
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 09:02:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D489D1F23754
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 08:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5266428DC0;
	Mon, 19 Feb 2024 07:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="iqHr9/Oe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RVELYMGV"
Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329D928DA7;
	Mon, 19 Feb 2024 07:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708329443; cv=none; b=rhvg3bSzgznFnFKUJqmoZTQZ7g6xtnHJkBDPtTaeIwbkq5HEF4+zzkuwjZpzFeGPnzQqCRahxgxrEjAQ71TPGuxBsH3LqFb4SASGg23cUvmtZdXrP8Yvaus8iATNP8r+QSWUcdO6RxKUjS+/lmc+ZmFIpO3uOPRaCb1mgmmqKP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708329443; c=relaxed/simple;
	bh=R351teBCaIZBraoQMQ7o6QtixbLRhIaIfdXsiDV0M1Q=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=XWReH2Kp3JGbo3YfN1gzVPVEnMq0wJV40BOewtYiZeyqcEGoP6t+bFuZntEHtPPkRRlB5DVUVsEXHS2jd5ueJhEpTJBQPo06pDnn2qNeF881m3NayGxhryx+t4qewtvixc6QqAf8G6jEChOdKCTXcVAZESNWeRbdjXHJ9119Zro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=iqHr9/Oe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RVELYMGV; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 2C00711400B4;
	Mon, 19 Feb 2024 02:57:20 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Mon, 19 Feb 2024 02:57:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1708329440; x=1708415840; bh=LF+R2ufZgU
	yCJvXqnj1dT61AxvaaLi9q1G7F23mtRdU=; b=iqHr9/OeA05YA0MFVi47yyPA4z
	p0Vnyq0ciQoKo7oktZlSJCfpWAS6mHsTgkeY9iVUDUDBFYcaSua/VYZc6nX17zLf
	pV3GrYWnM2YYmFhEHSqO1838Anp9937ReSQ+PEJPmuRBF0+CTIstqB17fJaoGdG6
	lmMtSQGodLUeHOkKSabbe1q4IrNI4z2FVnpJIklZ8PmJNXre8VTLHb8HV+gUsW9E
	ML4wafDwv9V/j8uVT84rXf0zTdl6cUV4yc/TlXFpmCPMNkcJmUaNNbW/E+Y1V7/v
	VsG/PLPwI29LKArDc7es2MhEd/KWRyUNoGvTV5gFSZdRf58SUAf8xwin1G5A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1708329440; x=1708415840; bh=LF+R2ufZgUyCJvXqnj1dT61Axvaa
	Li9q1G7F23mtRdU=; b=RVELYMGVXVqAaJ6dYSgGaFfVZP0hEp+uL+tqNWG4TOwf
	u9FkFMoaXR5isl3Bwgf3RYKoiA1Nb/XW9NtQ/wSd0xpBHq2WnZ56d6dw1QROIvE+
	75yBDh5cMDImicKx/BifTF9fiTRCC7gF+4V5aUg1hu/POsm1FLrGxDA5L+Zamn0/
	0wUC0nK4BbcXSWsMKmlLQmOSZYjuaKLheFd4/y2iukTZT6IUQF+NadD49WtxOXym
	LyW7cxMp8YLZ3E2Sy4au4sKnFszGCB7MKtm48wv1ZI6XPmlO5PdbOtqCYQm6JMUY
	8kridWV23MBArHrDMcyQlnVfEiV253QchxycDfsuEw==
X-ME-Sender: <xms:3wnTZQYz5opi0nTkmLg7CKWaeWcWy_c6_4b77xA2LbOBrJmzJAyg8A>
    <xme:3wnTZbY5WXtTkJYOvohqIsxEQ1OyFRt9sksrZYvf37OsXfA3_JI8QJAiUrwEyGQ0S
    KHs_nJfrevLj5Epr84>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdejgdduudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:3wnTZa9u_61XTqKZpjl79_YMtSx7tIKygdBhoFw-TwkjDsHtXZE8XA>
    <xmx:3wnTZarGaqOdL6diMYhp9JSSU1Z_9R2shxA7qHQZTMP2Q-LoVibYzw>
    <xmx:3wnTZboW708Kk2tAmQnWECjeHKbIJFLGoj3tDByISFtK9uxbZnJQ-g>
    <xmx:4AnTZcdl_hqZ3tCU3yZTHFRCC5BQm9rYLMmJ-fJ6lLkZy7-vPCftRg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id B940AB6008D; Mon, 19 Feb 2024 02:57:19 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-144-ge5821d614e-fm-20240125.002-ge5821d61
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <4997c865-fc6f-4d8c-b73f-a649b6257ed0@app.fastmail.com>
In-Reply-To: 
 <k6cclnrqu2h6mh4wb33hpakhfasq7jec7dnbaiaxlpw525adan@cor5l3bi35u2>
References: 
 <fe51512baa18e1480ce997fc535813ce6a0b0721.1708286962.git.jcalvinowens@gmail.com>
 <431dd956-ad31-4da8-ad42-34f7380824bb@app.fastmail.com>
 <k6cclnrqu2h6mh4wb33hpakhfasq7jec7dnbaiaxlpw525adan@cor5l3bi35u2>
Date: Mon, 19 Feb 2024 08:56:59 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Kent Overstreet" <kent.overstreet@linux.dev>
Cc: "Calvin Owens" <jcalvinowens@gmail.com>,
 "Russell King" <linux@armlinux.org.uk>, "Dave Martin" <Dave.Martin@arm.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 "linux-bcachefs@vger.kernel.org" <linux-bcachefs@vger.kernel.org>
Subject: Re: [PATCH] arm: Silence gcc warnings about arch ABI drift
Content-Type: text/plain

On Mon, Feb 19, 2024, at 07:25, Kent Overstreet wrote:
> On Mon, Feb 19, 2024 at 07:21:11AM +0100, Arnd Bergmann wrote:
>> 
>> This is not something that should ever be passed by value
>> into a function.
>
> Why?

Mostly because of the size, as 8 registers (on 32-bit) or
4 registers (on 64 bit) mean that even in the best case
passing these through argument registers is going to cause
spills if anything else gets passed as well. Passing them
through the stack in turn requires the same number of
registers to get copied in and out for every call, which
in turn can evict other registers that hold local variables.

On top of that, you have all the complications that make
passing them inconsistent and possibly worse depending
on how exactly a particular ABI passes structures:

- If each struct member is passed individually, you always
  need eight registers
- bitfields tend to get the compiler into corner cases
  that are not as optimized
- __u64 members tend to need even/odd register pairs on
  many 32-bit architectures.
- on big-endian kernels, two __u64 members are
  misaligned, which causes them to be in two halves
  of separate registers if the struct gets passed as
  four 64-bit regs.
  
I can't think of any platform where passing the structure
through a const pointer ends up worse than passing
by value.

    Arnd

