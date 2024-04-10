Return-Path: <linux-kernel+bounces-139545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16F9D8A042D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 01:44:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0D791F24C98
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 23:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 194C73F9DD;
	Wed, 10 Apr 2024 23:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Zj0athZp"
Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307F32E40E;
	Wed, 10 Apr 2024 23:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712792641; cv=none; b=Fh7IPXMkpLwBng5vsFsheloWcTXI0TTkUc4lpB9T92Tyks/Zs3pEDr4g4j4er4MQo793I5MLctppgRsaxKv4ZB0O+SrCcrAfoL11LtDQz/dFVuRtdm9qdNdHmNnMAMs+jk8N295k7haSh+KlIxXwzNeS4kGGwqkaT8hg5w/XfgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712792641; c=relaxed/simple;
	bh=qP7KSZoehcdruqXNqC4SgP+OasDjlwzmS8iW47/Hbvk=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=sh/tT+rsnvjlYAu1yjql8mmTqdoXI4tCyqeMxOpIkk+Wf6RcWKh/psiOXhLKk6kqDzjMpnoUYiwk7bc4SfSNXjzLCMk14+O8+5k/Do9PwFh46E0Qz+sy9D4cUOH6K6fodZlChC/xnf9R+V6BOdAnp5QTjj3W/X9s+u/eSfLuxR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Zj0athZp; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id 139DA1380151;
	Wed, 10 Apr 2024 19:43:57 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 10 Apr 2024 19:43:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712792637; x=1712879037; bh=bNMg1NINdfov5fE28cnjx4gPyFXP
	b8x0Ed9EbQW+UjE=; b=Zj0athZpcBqw4LBCEYRO4uIZESXsiMfgl3Pd8ZNHvcps
	kBVQv1qftU+JxF/ifOdLCOG4EUgmQU9vc85Blaved1YE7A624xH8I+fwdviIoH+X
	gUMKZChRB29PCUHOnK2aS1qB3MVYumQZAhuyB9pc0jTf2qyLU1sJrRpj4uwu/d3J
	klrQJgor5HJZsxFTXA5d8LOct2Xh5Gh38dgAQBiqW6eAT+YI4FkI9QLdwjQKkr3D
	1K1JIlb1ji8CJk/YQ+ZbHBRA7a5SjegrP29GeJ6awYargoz56iInxEeoqboF7iEj
	kHxrsqBd+hvGkjcMXvIYwccs3nkanC0pAwDYoJJ78g==
X-ME-Sender: <xms:PCQXZq1aFKWxI1FEeOmRXl4M-GJ1JghcCXc_T0bikJfWY8a5d5qDog>
    <xme:PCQXZtEllHgyZRF0AlY-NsKIKCPnlmVq_Y1-TgbgNopqCr15gcYDCD2jK0aZ_Cc20
    mt_ZByHgSGWG_xDMrA>
X-ME-Received: <xmr:PCQXZi44GoPDMyPdy8EYkfUywqNfvxUCGVdBsbJgbZo9-IjCnPUmhq0ntLxuBtvfFZ-seZEawbTo2OMhGuqiHladoXMdc8u1k1M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudehjedgvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevufgjkfhfgggtsehttdertddttddvnecuhfhrohhmpefhihhnnhcu
    vfhhrghinhcuoehfthhhrghinheslhhinhhugidqmheikehkrdhorhhgqeenucggtffrrg
    htthgvrhhnpeelueehleehkefgueevtdevteejkefhffekfeffffdtgfejveekgeefvdeu
    heeuleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hfthhhrghinheslhhinhhugidqmheikehkrdhorhhg
X-ME-Proxy: <xmx:PCQXZr2r7lP-f9lauhFdW3EhfpUGo2an6v-N1TpsOm7xhgbuP-hXkQ>
    <xmx:PCQXZtGxap-AhhgfYTGn2_OMVV0B_v_5SU8oFx8y-9k_NUxO7C_Vsg>
    <xmx:PCQXZk8YwmdkhjuMA741W0C06uKnT9N0ZKFp29NA_U2saufjON4hqQ>
    <xmx:PCQXZinl7OwFJnFwRKYrX6ZVE06z5_Li1pxfV9Ct5P4ZXSGnf3507g>
    <xmx:PSQXZjaIn2qvY18pp2TpkVCKZY0-MeM9ewKjg7KAitwMfU_WejDyEs3U>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Apr 2024 19:43:53 -0400 (EDT)
Date: Thu, 11 Apr 2024 09:43:48 +1000 (AEST)
From: Finn Thain <fthain@linux-m68k.org>
To: Michael Ellerman <michaele@au1.ibm.com>
cc: Christophe Leroy <christophe.leroy@csgroup.eu>, 
    Andrew Donnellan <ajd@linux.ibm.com>, 
    "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, 
    "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
    "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>, 
    "fbarrat@linux.ibm.com" <fbarrat@linux.ibm.com>, 
    "ukrishn@linux.ibm.com" <ukrishn@linux.ibm.com>, 
    "manoj@linux.ibm.com" <manoj@linux.ibm.com>
Subject: Re: [PATCH 2/2] MAINTAINERS: Make cxl obsolete
In-Reply-To: <87o7aha1mj.fsf@mail.lhotse>
Message-ID: <cf03bfb4-0970-fe3a-062f-8c4e371a7afa@linux-m68k.org>
References: <20240409031027.41587-1-ajd@linux.ibm.com> <20240409031027.41587-2-ajd@linux.ibm.com> <87bk6jb17s.fsf@mail.lhotse> <0dd09e90-440d-46f0-827e-cbef93ce72c6@csgroup.eu> <87o7aha1mj.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII


On Wed, 10 Apr 2024, Michael Ellerman wrote:

> >
> > Could we do something similar, write a message at boottime when the 
> > CXL driver gets probed ?
> 
> Yeah, I think so.
> 
> There's still the problem that people tend not to look at dmesg until 
> something breaks, but at least we can try and get their attention.
> 

People would get in the habit to look for that, if all maintainers adopted 
a convention such that a boot-time message would list every newly-orphaned 
driver in each release. Maybe the maintainer of the MAINTAINERS file could 
check that every newly orphaned driver got announced.

