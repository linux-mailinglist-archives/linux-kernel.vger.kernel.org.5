Return-Path: <linux-kernel+bounces-142427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE0B78A2B70
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 11:43:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFA991C21099
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 09:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1070751C50;
	Fri, 12 Apr 2024 09:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="EA3tIKSi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ENAXvBVs"
Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C6B537E6;
	Fri, 12 Apr 2024 09:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712914966; cv=none; b=E80UlBBzUiMXlfMmSNbpvrbtKCEgKecJGMPb0+OEi5Coky86V9ihw5xkGPYWy4kc6Qw8mZE2ZM2BboT3ZOXF8G7uWspSFX4uunB0ACzzDIqjqyYTitE2fUG2etR/lz+z7DwB9bR3LHCJOs5ar8EwfHro+OuUyFmegw98LuZy7y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712914966; c=relaxed/simple;
	bh=//iFiHbyhHvw1sXW+wAD3eCZqlpxGs2kRqaiJyXFFZY=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=Dl9RlcbYGP8P/1CRgodrh5Mj5gAIk7BJsCaGkXELia5SaKJsdSHTkOqja8u7oRVxD00g15+ekK6bYq5NDlw5/mQO7kFJRYxoIqPqtbpOoFl0TeRa0jN1N3u+SpHxLJYqwheqbUfasyyi8RySmO9SG7fvVcvCGiftNlB2j1bzt4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=EA3tIKSi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ENAXvBVs; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 23B1F114011E;
	Fri, 12 Apr 2024 05:42:42 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Fri, 12 Apr 2024 05:42:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712914962; x=1713001362; bh=XbU/AZ+gZD
	CVmQA/PPYNv1+/JbFuqZg5h0CHdzEfuV4=; b=EA3tIKSi8AOB8M4nSwfVaEuqPl
	pQyAfNI/xy1Cs/ofuN4SNSMnPVOTfGemxIHOz+Yg5kBfgMxHPPdv/c+hT8ep/P0D
	NuVVN+sI7M4wkm87qmj7X2VT2NBzRYkE45pHV5T2XMwdKuMgiRXpFG156hkW5EUD
	QoItRVGjl+gPFVbqL9mqeY8YAbYxDf/U3D1oJ6tVh9Mwd/fvqoBzyuiV132nQTed
	4vvw1gv97KEA9qhY7K190JKY+flc8O7f/APvNIk/+dSKB/D6qLfFIjFM6HKtG0SC
	SB640XIAREvkw8foxkdBF4KYd5EUd2c6/6NSBuFBWgR3u6RXQsAsyZwZnjPw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712914962; x=1713001362; bh=XbU/AZ+gZDCVmQA/PPYNv1+/JbFu
	qZg5h0CHdzEfuV4=; b=ENAXvBVswfVESs0z3kBlT2dR7Osl//AkQTrHMJiOr+bl
	18fZzueicpGulHnaUeQTUsZbKjXtHQhrfeQye7Z9eDMXtdN16kFXKLF8RVhpyY4H
	UrQIJ9rjPezrAhnCqSbTD/ebceotr+Zx/yJzpf0O69ipvNsc0C28xvrG4fi/H+Qa
	KLFnQJl+8mfrkfwSiSU7rEjf1+d5Wz6ew+kjU30mBcz73zvdjTJh4cfIySTvG2O6
	i59cN/Xg4tDlVAyNgAa3yKzmQcOFs9LJLk9FBttAycf+FU44+iybR22/i+94KH1z
	4p6Zf44/bE3NnBNv+dYVDc5FKAN+wf2/TRcuseqJ2w==
X-ME-Sender: <xms:EAIZZo4PBaB0bACdlu7P9z116WAoz4TVPCChsQQ56qXFOTXzPEVxUA>
    <xme:EAIZZp5P_3AXv6ZLGTjAr3wGscMpYUpfJoeyey65lINxFsGVCzg3WDI7LX_4qbWd1
    b0ET3mjbmBX_VSUVKM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudeiuddgudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepvefhffeltdegheeffffhtdegvdehjedtgfekueevgfduffettedtkeekueef
    hedunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:EAIZZncyRd-Y5dyR_Re0zlrPysmgTdPJCIw7QiGZoyVo-XRL1ZGyBg>
    <xmx:EAIZZtLSZDgHM3pdRkPGqlM-7mnE_gcD0y-JbhAlzoeJ2WZ60eScpg>
    <xmx:EAIZZsIzMkpePCbZFirbxmnnvjRqVirP440k_B2RTQ2Ar_G75Wycvg>
    <xmx:EAIZZuzxniUa044csIRCh2YJ7romr1-n7fL3sUXvuDka2FOvnKMdDA>
    <xmx:EgIZZvaN7kz3UpA2_dAV2GEAZLwGil-9yRzXEJE2wJnReDUOLPwxdPd0>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 4CD1CB6008D; Fri, 12 Apr 2024 05:42:40 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-379-gabd37849b7-fm-20240408.001-gabd37849
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <28ba40ea-7f48-41b0-ae57-99a870e68fb8@app.fastmail.com>
In-Reply-To: <20240408095943.48e6c0cc@endymion.delvare>
References: <20240326144741.3094687-1-arnd@kernel.org>
 <20240326145140.3257163-4-arnd@kernel.org>
 <20240329134917.579c3557@endymion.delvare>
 <63909b0a-7d76-418d-a54c-1061bd3b6e11@app.fastmail.com>
 <20240408095943.48e6c0cc@endymion.delvare>
Date: Fri, 12 Apr 2024 11:42:03 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Jean Delvare" <jdelvare@suse.de>
Cc: "Arnd Bergmann" <arnd@kernel.org>, linux-kbuild@vger.kernel.org,
 "Masahiro Yamada" <masahiroy@kernel.org>,
 "Nathan Chancellor" <nathan@kernel.org>,
 "Greg Kroah-Hartman" <gregkh@suse.de>, "Nicolas Schier" <nicolas@fjasle.eu>,
 "Nick Desaulniers" <ndesaulniers@google.com>,
 "Bill Wendling" <morbo@google.com>, "Justin Stitt" <justinstitt@google.com>,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
 "Stephen Rothwell" <sfr@canb.auug.org.au>,
 "Andrew Morton" <akpm@linux-foundation.org>
Subject: Re: [PATCH 05/12] firmware: dmi-id: add a release callback function
Content-Type: text/plain

On Mon, Apr 8, 2024, at 09:59, Jean Delvare wrote:
> On Thu, 04 Apr 2024 16:07:55 +0200, Arnd Bergmann wrote:
>> On Fri, Mar 29, 2024, at 13:49, Jean Delvare wrote:
>> > Will you get this upstream, or do you expect me to take it in my
>> > dmi/for-next branch?  
>> 
>> It would help me if you can apply it to your tree directly.
>
> OK, it's in my dmi-for-next branch now:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/jdelvare/staging.git/log/?h=dmi-for-next

Hi Jean,

I see it's in your tree, but I don't see your tree in linux-next.

As all the other fixes from my series got merged, I would like to
merge the patches that turn the warnings on, but that still
causes a build-time regression.

Is there a reason for the dmi-next tree not being part of
linux-next, or should we ask Stephen (added to Cc) to add it?

     Arnd

