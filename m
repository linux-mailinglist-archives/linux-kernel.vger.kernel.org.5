Return-Path: <linux-kernel+bounces-137513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2A8489E32A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 21:18:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D914288BCA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 19:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23EDA156F28;
	Tue,  9 Apr 2024 19:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="BN+2ubYN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PqsFDpNi"
Received: from wfhigh6-smtp.messagingengine.com (wfhigh6-smtp.messagingengine.com [64.147.123.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D131386C0;
	Tue,  9 Apr 2024 19:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712690300; cv=none; b=u6pbo4nnSC/YKdXvjd5qBq9z/1ZCFfa1bckh95QNgOCylPILruYU5EwDacSUlF3WxaZEr+W0+TalAu9TKMlmw8ZbV75/3BpdFujJ8MLXfu1ODzBquiVGBBzAJbgf30CguwOAF2Pkpw3nbKLn+rf511Ci6lpGHxvSltmgvOybg1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712690300; c=relaxed/simple;
	bh=vIPEq0qMiHclQVvq8xpETzbQ931z4s7f7vlrnFlBVzw=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=pYEBQYc0h9O6PcdGDfNsNFl6uqkst62tjhDSMWlGO4OlnZFxvZ0l72gU0YUPx79SXW4K7XDscWZr5nwpq/UFlALbFb9t1YSzOu5HsA4JitcNdlNc+UabDeRZe6NIzUCd04R2waCZoASF3AO+9IG0n4+RjnxKw52TToi6krSLHHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=BN+2ubYN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PqsFDpNi; arc=none smtp.client-ip=64.147.123.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.west.internal (Postfix) with ESMTP id EB7F3180013F;
	Tue,  9 Apr 2024 15:18:16 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Tue, 09 Apr 2024 15:18:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712690296; x=1712776696; bh=o8lxh9R6h5
	L5tAhymZmWIAm7eTkGHdYv7aBWmufujxo=; b=BN+2ubYNzJbcOg64RW9QkZWmZY
	vKXfdXM6cPnX4GZW1Px+oZkJm6qvDk5wj/eVxTo99Sz9jSsk7f/B6rmlIfZQSsbA
	ksf6e9kRTyp+aZcV695TiOefx+LP136U8nIVWIW/P6p5vE/EnjtmOHH6k4QwmhXH
	KS6Mj5YGFNhyWkhZ7ENkv9ekchR4AEpF57hukM+fnqbwmoF1TT7DH23gHXsmlRCZ
	1u2miU9/NvQzK+MQmjX5pm/qEKbfP304ShI4lso1Z3+/JP4N1nkRdCMrw4gJ5Jwp
	t/aE8qlFBAr+5pSKouUEklJDGj6j1Byp0we7cXMA1B1Fw+XWxp3ZarJn1bGQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712690296; x=1712776696; bh=o8lxh9R6h5L5tAhymZmWIAm7eTkG
	HdYv7aBWmufujxo=; b=PqsFDpNi6OfyhZ3pP+Q+OOSkeeGlHrolUQ175qlMQdy3
	I+A1GIYKKDyM3rV5gY4FyKpINAfFDpnDD+T6XLLkevn6V23qx9r0aC2dgS7q5jsD
	l2c/FOCnKYalqtVU9LkBCzUObjDOFcHhUVaUtrjhlhcb5AZEWZz7wX3frHPkqGT+
	h82Fhm6DUxrOMegjoCQLvTHSD2K7iIO31uYi7qhthsFqh4azm10ZWcB4haW/PIWL
	dEBO8QqsgtfDHOuKKJUzaakHr/5+fzRpJRmTlAbLUm5ohQExhLT8KQKhp1oPGzd7
	q6YiBvxx7wBgeE3/H0bMaBaBxBPzVnlBrm4UMZ9KMg==
X-ME-Sender: <xms:d5QVZniExI9Sel0DM1-NxYGXRs7oyhqA5HFohICGhH78p-IsBNbDkg>
    <xme:d5QVZkBTRjxj6yeFrsxCjK5sa9JDGPEZFYzbYFEZPpaVqI2Y2OZhiXENrXPhG3gxK
    HWppJ0ObDIcqSfuwck>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudehgedgtdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:d5QVZnFKHQ8CutuWgJqFzzWTdreE7d9vyedoUUMHBZquqH06UOZXMw>
    <xmx:d5QVZkSkaaPr8X68unUCUfRODOCsDau2OgPHpeUvXDSHDYrk_rUTRQ>
    <xmx:d5QVZkzNgyArw6vyoDlKsTYL2pf_aSt4DGX0VM0ScXID_M1v_PN3OQ>
    <xmx:d5QVZq5Nh-35WCDSryDKskyaozM_iHkNM_liZRrB9lAMKr2pN6qTGA>
    <xmx:eJQVZrn3u7uGmA3JyNa65s45Fr1C6vaem8M6Q8ATYbHUMO53GcGccKmn>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 219A5B6008D; Tue,  9 Apr 2024 15:18:15 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-379-gabd37849b7-fm-20240408.001-gabd37849
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <1f2e1994-408a-41d3-9b0b-a08d9478e8b8@app.fastmail.com>
In-Reply-To: <20240409162521.GB3219862@dev-arch.thelio-3990X>
References: <20240404151713.3493098-1-arnd@kernel.org>
 <20240404151713.3493098-2-arnd@kernel.org>
 <20240409162521.GB3219862@dev-arch.thelio-3990X>
Date: Tue, 09 Apr 2024 20:42:23 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Nathan Chancellor" <nathan@kernel.org>, "Arnd Bergmann" <arnd@kernel.org>
Cc: "Masahiro Yamada" <masahiroy@kernel.org>,
 "Nicolas Schier" <nicolas@fjasle.eu>, linux-kbuild@vger.kernel.org,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH 1/4] kbuild: turn on -Wextra by default
Content-Type: text/plain

On Tue, Apr 9, 2024, at 18:25, Nathan Chancellor wrote:
> On Thu, Apr 04, 2024 at 05:16:54PM +0200, Arnd Bergmann wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>
> I have not done any LLVM builds with this change but if this is going to
> be in -next for a little bit, we should be able to get any regressions
> handled quickly.
>
> I am in favor of more warnings but I am a little nervous this will make
> compiler upgrades (or tracking their mainline) even more difficult. I do
> not have a feeling for how often warnings are added to -Wall and -Wextra
> so this may be unfounded but the kernel's -Werror use complicates this
> in my opinion. I can engage with the clang folks to try and be given a
> heads up when a warning is going to be added to -Wextra, it would be
> good to have someone do something similar for GCC, so that those
> upgrades do not cause something like this change to be rolled back.

My impression is that most new warnings get added to -Wall rather than
-Wextra anyway. If they are added to -Wextra, it's still easy enough
to turn them off individually unless W=1 is set.

> It is easy enough to back out of this if necessary though, so:
>
> Acked-by: Nathan Chancellor <nathan@kernel.org>

Thanks!

     Arnd

