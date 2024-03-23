Return-Path: <linux-kernel+bounces-112512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C0B5887AB5
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 23:55:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 304721C20B48
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 22:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 756BF5B5D3;
	Sat, 23 Mar 2024 22:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="WIWbc/hi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="G56/I1KP"
Received: from wfout3-smtp.messagingengine.com (wfout3-smtp.messagingengine.com [64.147.123.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D2C2CA4
	for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 22:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711234545; cv=none; b=LQA4sS+ACZdj2mGDw5H0xTeA5qd4wresyOXv6JF78tAhDdXUrHKpmtNM4G125pXPxoHEQSu/PYyE7jwCkf7B8R0uJLa9qxfZQ39i0WEHgYZKHPu2SWUBiH36WCFBIjpWSybiaikChsgNng5l6H+yYdbDzFvspfrxPe0FDAVpkgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711234545; c=relaxed/simple;
	bh=WpbkNjAnUQfibmG0zhPT63E357okTaSIiF0QU2QjOdo=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=rkmrumeYAT+kg8cvLaTi4eitoeg7qXzrcgT50CfKZ5YoA3P4ZReaF0UGWCTgbRnfqKDG/E5VNdRhFv0nEi0aPu9gzbZ3lqgqb1bIdHWvoxyvjOS2KsUhYQAYVYJCxtKaJau8S10cGu3Wb4BYc8R0BsRCw012YQiPUICl9sEoY9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=WIWbc/hi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=G56/I1KP; arc=none smtp.client-ip=64.147.123.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id C19951C00092;
	Sat, 23 Mar 2024 18:55:40 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Sat, 23 Mar 2024 18:55:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1711234540; x=1711320940; bh=bC1rTRA0oE
	547pSYiwYtjsGg7PPu/f1OalliEsTl7PI=; b=WIWbc/hiea+CS/WIkittN8hHGx
	DH6Og8XtjHZhGxKn+arzh1TE2C4wIJkNkPF3SeOTDsablj32GhmWNJLRSe5rtpAP
	SQp53mE+TCNy34HQspFsHNQBDt0AYtkb4C4SHqn0zTlXGuJVwQ414lyjj61xx9of
	rf6IhEYx/RcQeCr6nJf5kQ77eQRjewRkf5YSCFrb+ZC+/WujZcIRutvpr0OkKJGg
	V7QDdblF/ZTX6y6qsSHLS/dbeqyv9/N6xK1G0KJK/Lrf6c0iDZE7rucB56CnNGuB
	v43qefShg2oL/Klia+C2tdufiHQiVEJPFYJ1T1t4nowIZ4WsOEuWwdKI0QWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711234540; x=1711320940; bh=bC1rTRA0oE547pSYiwYtjsGg7PPu
	/f1OalliEsTl7PI=; b=G56/I1KPmOY012xO860qT80NrNUc51+kEZOcbaoWkz1L
	5BvBZ656OAwBcKBvBgmCL8kZ9/Dxq+tk4W3LrmcXTKg4qQKzYImlmnUu/fxtNpdh
	NDS2d6xShQCCITxA3BQ7KfEA/yviZpig/AP1gM+4Z/7DNmvzcz7HlJM+pzC8kyXa
	mRDJIa8dp5bPPzgAU5tSTYQi3CUepdeL7CyKqBz4WYDp90Y0Ki70Jduscgeih/us
	k+DlFmVCBYNiqRdEbaPsDfnSP4pjNiUUtvmjZ/RxdF2omUgitK8kgySeDa6aL2zp
	1XDWhU653GfCe+IxmP3SWpOU2cMqUUT93P2sQP2t4g==
X-ME-Sender: <xms:613_ZbJ_YDftEHf7Xliu8lYqPOHNR7-NdcYtsxpNjP8BZWwWMBSZeQ>
    <xme:613_ZfJm3qIGz7PxiW4tfu_02eZn2TRJXLSSwCYptzXSbO3_EVRGB9jfQslN3hqRb
    0Cobj5cRURulMgOvh0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddthedgtdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:613_ZTuZp-Mb9iPFcADbEJ3NleDAbVsYiMBF01d0TMUAxtNeeQ_oYw>
    <xmx:613_ZUasTjNBcNzKbVxyPwLlKua3rKu28l7c5q39xn8PlHxTQcj8Gw>
    <xmx:613_ZSYCEkgonCbdDgJKn0e0gbfPhbXkV-iy6yVO_MuhMExaUTPV1w>
    <xmx:613_ZYCqh03IWsWf77Q0ZMpBV8hR4AzZ3IVcTI4xxL1ZlT9yCy6O2A>
    <xmx:7F3_ZaqfAKmmFGEjQYerRraMyUb3XlHoJ-e5xQw3fRQTVdW_CTN3-dUDBJI>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 72409B6008F; Sat, 23 Mar 2024 18:55:39 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-332-gdeb4194079-fm-20240319.002-gdeb41940
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <d82bebfc-3eaa-406d-8ea6-22113da30ed5@app.fastmail.com>
In-Reply-To: 
 <CAHk-=wi0arqxMFFdM+jGv1YXXhY+ehxsmcfv+iAndD_dmpYjMA@mail.gmail.com>
References: <20240322165233.71698-1-brgerst@gmail.com>
 <CAFULd4bCufzKjaUyOcJ5MfsPBcVTj1zQiP3+FFCGo6SbxTpK2A@mail.gmail.com>
 <CAMzpN2gOZEddWUgncaLutVDihcEK-oEUdSVxsgaaX9xiMWfqPw@mail.gmail.com>
 <CAHk-=wi0arqxMFFdM+jGv1YXXhY+ehxsmcfv+iAndD_dmpYjMA@mail.gmail.com>
Date: Sat, 23 Mar 2024 23:55:02 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Brian Gerst" <brgerst@gmail.com>
Cc: "Uros Bizjak" <ubizjak@gmail.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org, "Ingo Molnar" <mingo@kernel.org>,
 "Thomas Gleixner" <tglx@linutronix.de>, "Borislav Petkov" <bp@alien8.de>,
 "H. Peter Anvin" <hpa@zytor.com>, "David Laight" <David.Laight@aculab.com>,
 "Ard Biesheuvel" <ardb@kernel.org>, "Kees Cook" <keescook@chromium.org>,
 "Nathan Chancellor" <nathan@kernel.org>
Subject: Re: [PATCH v4 00/16] x86-64: Stack protector and percpu improvements
Content-Type: text/plain

On Sat, Mar 23, 2024, at 17:16, Linus Torvalds wrote:
>
> That said, we don't actually have all that many gcc version checks
> around any more, so I think the jump to 5.1 got rid of the worst of
> the horrors. Most of the GCC_VERSION checks are either in gcc-plugins
> (which we should just remove, imnsho - not the version checks, the
> plugins entirely), or for various random minor details (warnign
> enablement and the asm goto workaround).

There are also a bunch of feature checks in Kconfig that don't
check the version number but instead try if something works.

At least three of the six plugins can be removed with sufficiently
new compilers: GCC_PLUGIN_SANCOV after gcc-6, and both
GCC_PLUGIN_STRUCTLEAK and GCC_PLUGIN_ARM_SSP_PER_TASK after
gcc-12.

> So there doesn't seem to be a major reason to up the versioning, since
> the stack protector thing can just be disabled for older versions.
>
> But maybe even enterprise distros have upgraded anyway, and we should
> be proactive.
>
> Cc'ing Arnd, who has historically been one of the people pushing this.
> He may no longer care because we haven't had huge issues.

I'm not aware of any major issues, but it keeps coming up and
a number of people have asked me about it because of smaller
ones. Unfortunately I didn't write down what the problems
were.

I think based on what compiler versions are shipped
by LTS distros, gcc-8.1 is the next logical step when we
do it, covering Debian 10, RHEL 8 and Ubuntu 20.04, which
are probably the oldest we still need to support.

RHEL 7 and SLES 12 are still technically supported distros
as well, but those shipped with gcc-4.8, so we dropped them
in 2020 with the move to gcc-4.9.

So in short, not a lot to gain or lose from raising the
minimum to 8.1, but it would be nice to reduce the possible
test matrix from 10 gcc versions back to the 7 we had in
the past, as well as clean up a few version dependencies.
Similarly we can probably raise the oldest binutils version
to 2.30, as that seems to be the earliest version that was
paired with gcc-8 (in RHEL-8).

     Arnd

