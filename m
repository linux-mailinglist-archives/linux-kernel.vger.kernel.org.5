Return-Path: <linux-kernel+bounces-40315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2627783DE55
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 17:08:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D42FA283145
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 16:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1C561D551;
	Fri, 26 Jan 2024 16:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="X+/cIXgn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mqUX9KzR"
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334631B59A
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 16:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706285316; cv=none; b=hM8qubOBJOGRfT2pOLtj91olyBa3WA/+DCAcmt1ylaTh4AwGSZJVbUk+aLXZujPFDKCnK/00nql3IVtfT/VBE20Gs+GbqWs0PTJMS2XIkXJEfEi6nyyC8dji8Ftf3/MOLZ7kxQARPfbbKoqDo0y3UXod4bwvyenRNmOpeJNBAwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706285316; c=relaxed/simple;
	bh=IYqERZZmOKQVDKffDj+3eu2xT6akiZ7ytkQIXTHVt+c=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=Qpt2frOaR5Bi9gxj0N9j1DY4rNye2uoJP5XO+S7Jcljrp3BITkldnhS0xa/p3iOKUEqVD80uQJR8fEYSjdfMCRaZiyxYE6ATVGCejoFzp7Ojb6m5ri9/HCs+3UcuiDMdtQ05r3kqcE5dCb4v6dLep5857i0mfh23gNK1gsp+SD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=X+/cIXgn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mqUX9KzR; arc=none smtp.client-ip=64.147.123.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id E57473200A42;
	Fri, 26 Jan 2024 11:08:32 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Fri, 26 Jan 2024 11:08:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1706285312; x=1706371712; bh=AXOZTxw+Nz
	ZSkV7+zyn81UYzxXoud75nSWLiczx6gQs=; b=X+/cIXgnf/La6/t3F11ife/yAI
	CWQkl/TvwmnI6xcDiQYosQ0/91u5+yNcAp+XliNCTHRjJB+M9tgIyaF8QgrQpg/1
	ebT8a4VjqTPjwVNec3PnW9I2OuFOqZ1g9dH6u3o/02aljX7SmdzoZnSmLxeCqOCW
	c78VRhWTJiT70XOFZQiK8A9dlRF1jBXZRSDC98NGJsMxgaMn/pPp1QgLPygp8Gi1
	Sp//XPbZ9Fk/acOpxsMrWPFzF024xn6x9n+yt5Szq5fJ370/EOl0T48nviFti/MC
	N4LzIeQhU7UEP75J2UfBhI3BEyQ9Fdb55gMmZep0uTpIuVM5hMhO7AvlGr+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706285312; x=1706371712; bh=AXOZTxw+NzZSkV7+zyn81UYzxXou
	d75nSWLiczx6gQs=; b=mqUX9KzRjAjbwfhFVDXRbPz7VKUGFu8pBsl01uXcKhwi
	62Da+CiAq0khtMGHO9k0XhpSiZlE6MnUY1G1UNxs/hJScBS4tK2cuGWWVFz19ZMt
	r4EYynZOEeJ60Cebf001gzrRNewvlegwTVCuVxDizhAK9hTTWlazH/L3oWlh7hCA
	KqbQz9st4AeRG/X7DSlz3kxSmeI8UTs981v3KXyt9UqxgPntAszx5tF7ollxSnSp
	+ba0PPfO5Mwikiz+pT7XHRWXfjMW7I6WUp3zuKjzY5ZIoocIV/gu2/zjcgFyWC+c
	LZQcB96LEbr2QauTnCGtxQ5nO8ae52jLaGxisXKW1w==
X-ME-Sender: <xms:ANmzZaARLl4GOy44giEWlaVC7Gh2iDxlZNRj-y7lfLKD6ESxA1t49g>
    <xme:ANmzZUhd6cSjOflih6caX6L0Rc0qy1kD_cFqKxpFTB2p0npa8OKqWsM5VUtkU5WN5
    VWrDTNXZ54y5KkVcjA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeljedgkedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:ANmzZdm_6-Znb5iX5YpSKJnL_sN-Mc0A31fbd9KHbMLbqz0QwOcA7A>
    <xmx:ANmzZYwRrW-kNQLFQ8kD1rancdfZUSZPowwOuppRTAGGJII2-DLkpQ>
    <xmx:ANmzZfQEyNs4jX1AKEdxERoRplexHj_C87te8qTAdS827qirhSNClg>
    <xmx:ANmzZWJCyHsn8Dzcjk-TLmFsQUCwAkf2qj6hJ7aA4QzuClZTPXzSNQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 11D8CB6008D; Fri, 26 Jan 2024 11:08:32 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-119-ga8b98d1bd8-fm-20240108.001-ga8b98d1b
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <e70be9ff-5bf8-45ab-bd31-66d4a75acce5@app.fastmail.com>
In-Reply-To: 
 <20240126072852.1.Ib065e528a8620474a72f15baa2feead1f3d89865@changeid>
References: 
 <20240126072852.1.Ib065e528a8620474a72f15baa2feead1f3d89865@changeid>
Date: Fri, 26 Jan 2024 17:08:11 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Doug Anderson" <dianders@chromium.org>,
 "Kees Cook" <keescook@chromium.org>
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lkdtm/bugs: In lkdtm_HUNG_TASK() use BUG(), not BUG_ON(1)
Content-Type: text/plain

On Fri, Jan 26, 2024, at 16:28, Douglas Anderson wrote:
> In commit edb6538da3df ("lkdtm/bugs: Adjust lkdtm_HUNG_TASK() to avoid
> tail call optimization") we marked lkdtm_HUNG_TASK() as
> __noreturn. The compiler gets unhappy if it thinks a __noreturn
> function might return, so there's a BUG_ON(1) at the end. Any human
> can see that the function won't return and the compiler can figure
> that out too. Except when it can't.
>
> The MIPS architecture defines HAVE_ARCH_BUG_ON and defines its own
> version of BUG_ON(). The MIPS version of BUG_ON() is not a macro but
> is instead an inline function. Apparently this prevents the compiler
> from realizing that the condition to BUG_ON() is constant and that the
> function will never return.
>
> Let's change the BUG_ON(1) to just BUG(), which it should have been to
> begin with. The only reason I used BUG_ON(1) to begin with was because
> I was used to using WARN_ON(1) when writing test code and WARN() and
> BUG() are oddly inconsistent in this manner. :-/
>
> Fixes: edb6538da3df ("lkdtm/bugs: Adjust lkdtm_HUNG_TASK() to avoid 
> tail call optimization")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---

Acked-by: Arnd Bergmann <arnd@arndb.de>

>  	schedule();
> -	BUG_ON(1);
> +	BUG();
>  }

Yes, this is a common problem that I've fixed in other
places before.

     Arnd

