Return-Path: <linux-kernel+bounces-132187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18D41899115
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 00:16:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 465851C21370
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 22:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA2713C3F1;
	Thu,  4 Apr 2024 22:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Jw1DfUkh"
Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E6C13C3DE;
	Thu,  4 Apr 2024 22:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712268955; cv=none; b=IoPg3KEXHRsqOwaxk7vTMrImxDdHCVWbqh4p538+ZPQ49W8ABXznQQdCVHP2eOBPvPR830PWiKt+THyWElHOExGN2wIRaccQyobg/BvmGzW/gmibXFgAA9rDrWT6CcltIY4GUvLMok5QNz873xVSFjx7afkKwVKRqsVBZYwFV7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712268955; c=relaxed/simple;
	bh=pTp5edkZdZb3eEOWCrTxXu87gsPr0RabVB3/ii9vNkw=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=QNL80t3Rk2hBjiwoPpdNuoEoE9j7aU75ZwA25mCwD3LjBW97CjrcyUhidBoV3kASyhdYkuJKsH8BfqNL9GGNhD+Y6sF087UqJY2t6JlVkGa06cPakYRfCxkYQH6LzWc8VSX2Oa3G1IPoY6QxDwAtBRgMchmGZIx8s8KPcLth8Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Jw1DfUkh; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id CCFB913800B8;
	Thu,  4 Apr 2024 18:15:51 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 04 Apr 2024 18:15:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712268951; x=1712355351; bh=2BjsJg1F1jsrIqkTlwXi7zvS9Quc
	1lTtGbFTjSTDfA4=; b=Jw1DfUkhxICYlaH25P8sNWWfmviY9fTgQD1YAkM+b7J5
	MLDoXeSGk6Ppi2vjNecFMnDMVAWH3cOI51tY25oyukCw05gCNvfiUFjjdFECZNKa
	m6kmayGHiHqRDj+AaubmnhfiCBKbgp2EmGoAOKgnyeAbKRBH5uvrTSwHI0OfjCwQ
	sZh1VGtktjiIk6Q4UAII8BrPseCAW5jBPLkOcHDgMsoDrbctl0ul4GLZPzSG5ny8
	mmslf+tCky2hCQa0gvjwvW1FFj6Ec3CgKxiQvwc14ovTWKx/Vzmm0GWlRDGYB8L6
	J2450RXPLz9cVmVP+dLv4twnNIQ7ApXzz/femDFrSA==
X-ME-Sender: <xms:liYPZvsdxUwhpSDsLAJ15Ck6MEr4JUZhkhvSW4-OJWf8qCgqKfkCUQ>
    <xme:liYPZgdiN14S6lFyxmsaXVP1Hp8-WL0eiNV1Fs9pOJoeOMZHRJlDbJJ0O2oibCxNs
    5ZKoTv0O3_tFUol8pQ>
X-ME-Received: <xmr:liYPZixfe0dvx1nFnKAy4_YRH4ksESFowbNWe2tzbjOn8zuQkuw-FiJ-igtn_J_2x6-zBWbj4Zzu_ZzR2n1MSy-jpDuL28_WP_g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefledgtdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevufgjkfhfgggtsehttdertddttddvnecuhfhrohhmpefhihhnnhcu
    vfhhrghinhcuoehfthhhrghinheslhhinhhugidqmheikehkrdhorhhgqeenucggtffrrg
    htthgvrhhnpeelueehleehkefgueevtdevteejkefhffekfeffffdtgfejveekgeefvdeu
    heeuleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hfthhhrghinheslhhinhhugidqmheikehkrdhorhhg
X-ME-Proxy: <xmx:liYPZuN5fHDfdNiFMxbrhi9Y_PDp_oI2lNBNnq2OQbPrGu25iHDF_A>
    <xmx:liYPZv-bCS5UZc1XWxuLXceT-WG_8FC5MZT1S7WDvlPmVScgt2-J_A>
    <xmx:liYPZuUhOa5q13FGdcikfp-_luhQxgFEaFh2XZhOxBrX5T4JeBFzqQ>
    <xmx:liYPZge-gMrPjOIYZNYccbqHomnavk-glqv0v4MXwVjv-HW12g49cw>
    <xmx:lyYPZlf_hyBptrtbhf2hDfT4IkUpmoIs8cEwLP9MQkAFhP5RVpNysbGG>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Apr 2024 18:15:47 -0400 (EDT)
Date: Fri, 5 Apr 2024 09:17:27 +1100 (AEDT)
From: Finn Thain <fthain@linux-m68k.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>, 
    Benjamin Herrenschmidt <benh@kernel.crashing.org>, 
    Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
    Christophe Leroy <christophe.leroy@csgroup.eu>, 
    "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
    "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, 
    linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org, 
    linux-serial@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] serial/pmac_zilog: Remove flawed mitigation for rx irq
 flood
In-Reply-To: <CAHp75VcxLez_Nm0N8=gpWd7SKGd9JF2QXEOOB_gvX3ZtTzj6HQ@mail.gmail.com>
Message-ID: <5dd285bd-b9a8-c85c-9bd9-a839c10e78fd@linux-m68k.org>
References: <dda2187e128bfaaf092351812e4538e2e41c17f6.1711599093.git.fthain@linux-m68k.org> <Zg3YZN-QupyVaTPm@surfacebook.localdomain> <8f234f26-d5e3-66ed-ab0c-86d3c9852b4a@linux-m68k.org>
 <CAHp75VcxLez_Nm0N8=gpWd7SKGd9JF2QXEOOB_gvX3ZtTzj6HQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII


On Thu, 4 Apr 2024, Andy Shevchenko wrote:

> 
> > > > ---
> > > (here is a good location for Cc:)
> >
> > Documentation/process/submitting-patches.rst indicats that it should 
> > be above the "---" separator together with Acked-by etc. Has this 
> > convention changed recently?
> 
> I see, I will prepare a patch to discuss this aspect.
> 

If you are going to veto patches on the basis of rules yet unwritten, I 
think you risk turning the kernel development process into a lottery.

How many other patches presently under review will need to be dropped just 
in case they don't conform with possible future rules?

