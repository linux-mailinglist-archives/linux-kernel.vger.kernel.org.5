Return-Path: <linux-kernel+bounces-123223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5960E8904B0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 17:12:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3CDFB22A20
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 16:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0760912D753;
	Thu, 28 Mar 2024 16:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="pr/Moz0a";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HVMJ8PxS"
Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA3E8004E;
	Thu, 28 Mar 2024 16:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711642368; cv=none; b=QFvlC80JKXb/LouCeUVhqm9r4jwI46Pyw5eN++yCL0ko6XWTE8MPMasDyPMsIUIGo5CIAG6qE3X3ZEe56IzLDk3ia5xjtQJ7ZBvhL+OTaSj2RDx2ms+iEUBR8HB1/50zaIFv7Krlt0pQztxL9zfENmBOI7Qz6yQqk1i0Q+iZDKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711642368; c=relaxed/simple;
	bh=pGTWxtR8t55PSLe9wdn/GlKwMsqBfge9PbgnDIXZN1k=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=cGSM8gE8gF8+6CMhRNYjNX8/YWzQuy8+7En0cASS8rMsLRPZuJAi9ytsAPzUobx3efojXs0wEPKaxv9lYvHB/SPDMYFr7n34xqNZ5yZHaesurdqDIu7OdUre+FATK9G00vThteliX084xQaL5uOez/fDRN8WJMX8EKfLD3M4prI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=pr/Moz0a; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HVMJ8PxS; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id CF8511380138;
	Thu, 28 Mar 2024 12:12:44 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Thu, 28 Mar 2024 12:12:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1711642364; x=1711728764; bh=yBZLt1IotB
	ltcCRHWDdPe59/imWh5Tf9BCrIy8mVGDw=; b=pr/Moz0a71aofp46Is9vCctPWg
	dG1WvxuZpAO9jRKb+EppwbnVxIgY2B22sFnZAEFuC0rP9eYQBxIQQN6cFEFIP88B
	gEuGKY8/ItJYP3gTTY9LVF710l3TDKtwOJf0THlL8Ork1YCCeXLpH00f+C9KuPvO
	3Z9VVmEYXKeUlMIDvz417QEmglQNKgWaCPofdSn6TRk5n06/jeUjzDkfEjbeKubE
	0d7ETXD21LjC/7jOq/lio2lUgDBWoS9yT3FXYQN5/OGUJ9UAMhSuWH9o1x0M79nn
	c63TBBgUS9z8szedCPtfrIVFyLggobRbUEHKDoIDxQec45qWp7h2YLfVEdHg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711642364; x=1711728764; bh=yBZLt1IotBltcCRHWDdPe59/imWh
	5Tf9BCrIy8mVGDw=; b=HVMJ8PxSbQXFoQR5Xj5YTspS4zpHiY6/+kQvZrPhUhSV
	FGIVvwjru+16YOA/5q+RZFcWknd5F0dRLW7Fg6zv5SNeAU2HwHuxJzdRqCOmGdK5
	Inn9089mnbc/KKiPWhx1R4ihdqBIydcCF72UHU4rWbNtVfS684VgapjJpM+XUljz
	zNdz/z55QTBzwcelz9pJo56RGvTsXgTh/jiFFHoubL/E+TsVwmcKzwNqRAgtplbK
	BLVGdSD2zHxCjrFJw9h8tQdmvvFoQUb6HUB36PE0UL/uCcjnMkrugG35zqZIb3Og
	+4x036hdlSqBI+YixM36mc/jVxw7/Wull2nOgOChWQ==
X-ME-Sender: <xms:-5YFZnr665NksCT90A5BioJ6_9K7Umvncb7geZOMM753OUWq47ciHA>
    <xme:-5YFZhpe8fpM_Xs82WNvywZQgUZSClqXuK72tTCnltht3BbLtzD24RzGE9s8e-btD
    OddfkzvLTmMYpeyE-U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudduledgkeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:-5YFZkPFqPbyR-jlaOl7TvmFuhsUrVd7v39PJlUmlWR2J0uayao76Q>
    <xmx:-5YFZq6bvd8W5eJs-UAQUDOUCWKaLiemvr5tFo1jyKlSM-cahSK_5A>
    <xmx:-5YFZm5hRUJyLv8-s52LALMuyAW21UXaU1U1zqCETiYp2efKrMdC6w>
    <xmx:-5YFZijsYUMMWSdfiEH7V4DkAKVl8Otkx_0fEzoqPWd_-ipDI71RJg>
    <xmx:_JYFZlTGH9z7KqtaDtzrw3ayMMvXSEJCLO7wrThyhP25rPNaTZsZew>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id C8F92B6008F; Thu, 28 Mar 2024 12:12:43 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-333-gbfea15422e-fm-20240327.001-gbfea1542
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <e96b89e1-0fd7-44c1-a0ed-cd40a5e7af67@app.fastmail.com>
In-Reply-To: <25b5f2297c98500ed91971a61ccc4bfa5921035e.camel@redhat.com>
References: <20240328143051.1069575-1-arnd@kernel.org>
 <20240328143051.1069575-7-arnd@kernel.org>
 <25b5f2297c98500ed91971a61ccc4bfa5921035e.camel@redhat.com>
Date: Thu, 28 Mar 2024 17:12:03 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Philipp Stanner" <pstanner@redhat.com>,
 "Arnd Bergmann" <arnd@kernel.org>, linux-kernel@vger.kernel.org,
 "Ryusuke Konishi" <konishi.ryusuke@gmail.com>,
 "Nathan Chancellor" <nathan@kernel.org>
Cc: "Nick Desaulniers" <ndesaulniers@google.com>,
 "Bill Wendling" <morbo@google.com>, "Justin Stitt" <justinstitt@google.com>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Christian Brauner" <brauner@kernel.org>, "Jeff Layton" <jlayton@kernel.org>,
 "Thorsten Blum" <thorsten.blum@toblux.com>, linux-nilfs@vger.kernel.org,
 llvm@lists.linux.dev
Subject: Re: [PATCH 6/9] nilfs2: fix out-of-range warning
Content-Type: text/plain

On Thu, Mar 28, 2024, at 16:21, Philipp Stanner wrote:
> On Thu, 2024-03-28 at 15:30 +0100, Arnd Bergmann wrote:
>> 
>> This is ok, so just shut up that warning with a cast.
>
> nit:
> It's not a warning, but actually a compile error, right?

I build with CONFIG_WERROR=y, which turns all warnings
into errors. It's just a warning without that, and is
currently only enabled when building with 'make W=1',
though the point of my series is to have it always enabled.

> (no idea why they make that an error btw. Warning would be perfectly
> fine)
>
>> 
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> Should / could that be backported to stable kernels in case people
> start building those with clang-14?

It's clearly harmless and could be backported, but it
is not needed either since older kernels will keep the
option as part of W=1, not the default.

      Arnd

