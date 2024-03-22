Return-Path: <linux-kernel+bounces-112006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2637887407
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 20:53:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA2B6B21AF8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 19:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 590517EF11;
	Fri, 22 Mar 2024 19:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tyhicks.com header.i=@tyhicks.com header.b="HvCYZyr5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Rj6wfpM1"
Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D650B7A151
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 19:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711137179; cv=none; b=YKzk5u7gk1XfiYS7vXzbqisa3nbkcrSneReQJ8fYowiaMncbz1dLildgaufjmuBhwdUQLGuGMxHtdMjGfNWBrutwIJ5kbj4jBcHJitkrt65UXfroxsyjWRLGEc2cioi3a20Fb8K0IbaLTVuCI4ycw4sMkQA3sdkCGlWLaxOePUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711137179; c=relaxed/simple;
	bh=882W7BvtwuGGMvjQvWUlxevdudIOvEYZS9sbSSNidg0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ulrt+3ZNldUlt0ShP58SpXcwnXsNqtlq3yv44sbN4FSwhwO6ZToHix3Y+IeXx80n7mLttAypX997nAfKrxQgOMz2GazyrkRI2OcFRB49XU4JTQUYYl5BwUmYFdUgqrac9hTErWLnsBMl89DSKgNtw5osA4qHExyMDlwRlK8yodQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tyhicks.com; spf=pass smtp.mailfrom=tyhicks.com; dkim=pass (2048-bit key) header.d=tyhicks.com header.i=@tyhicks.com header.b=HvCYZyr5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Rj6wfpM1; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tyhicks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tyhicks.com
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id 147B913800EE;
	Fri, 22 Mar 2024 15:52:57 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 22 Mar 2024 15:52:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tyhicks.com; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1711137177; x=1711223577; bh=SDe9rNbXis
	2QKNa9pGytu06HZGUqYjzBkgt7/9/1dz8=; b=HvCYZyr5O3L/UydCTC5xfpLLy3
	KqBlUl4a1x1yS2iMt+r4mpd7R0OzkQMWuqUlCOm879HnJaGq65Trchp+6wc5fI92
	U7oiN7k1K10otaVkFjDuFz8ul528JNpjl+ehVIEIAB6Oamp3J0uqGOaE5vtul276
	MvwMKoi7TgeRmO3d0RLaq9h27YrlsfutW75c8FAF/Z/UOFUZB8PX36bCeyvZlc30
	5ZQlOZqWXmQ4vmWTVREIb+AQdLPy6jB5jLTcVGKHZKWHo5UMrw7+B+HH48Yx3LXj
	bwlQ/+SLZAlyaCb+aXBvFw0cyz+SN/OeeKJDq4LwLb8GtlP0rv6CB7fpIc4g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711137177; x=1711223577; bh=SDe9rNbXis2QKNa9pGytu06HZGUq
	YjzBkgt7/9/1dz8=; b=Rj6wfpM1eqRiPgpB3/qkn1p4txZDVo3Gcuix4+CvR0s0
	LyMFGwXmfdGrD8hg5u8sB6gLeqOyvon3JJRQjiURCIeqkmOV880Qo8hkfN3zZvX6
	7U6C0KlTwR+BNYRdXDSKmAFTH8l62k2cgmfDIy/G1qiwCigQFxtr5DFJLi+D0N6L
	K/bUC+LjfWJ5mE1jEAhu6SzeyOLY3UYM1igfZO5ObAt4NNwkBDIza1ILhm7F/1GT
	7pOOVDQBXd5uG3vH4AhdCHHbPAOzK4dR82lVdByL7MVlP3gkA/n4wR2aqUqkFfCK
	+P/8t/uGREghrQYpvI6eAB2BbrdkqCxVRGlhJvufwQ==
X-ME-Sender: <xms:mOH9ZYK7P_C5BRWKL7TPjO8rttXR9Wg68d3NwKDXUtIddObakxlomw>
    <xme:mOH9ZYK-Z202UKn-1Pv_gE5eSxnNJ-EmFFNy2wszMwSDqR5ph-kQtstZtwwJ9Q-U0
    bQkNI83ACa1mIgzmww>
X-ME-Received: <xmr:mOH9ZYtBjR0WdHHOkjHZbkgDhw9gcsy82hZWxUMACPHdwYLqo7E7PdXlA4Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddtvddgieeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepvfihlhgv
    rhcujfhitghkshcuoegtohguvgesthihhhhitghkshdrtghomheqnecuggftrfgrthhtvg
    hrnhepvdehvddttdfhfefhtdfgleehfeeggfdujeeuveekudevkedvgeejtddtfefgleei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghoug
    gvsehthihhihgtkhhsrdgtohhm
X-ME-Proxy: <xmx:mOH9ZVY2D7nL6Q6n3nz2hAozbSjd4ljcTk7BVL_-CiUzABnjNXQ1rg>
    <xmx:mOH9ZfYq11396JSQQhCQPRZGqzb1O27_TlrUhMZGDQ-s63Lvkqpm7Q>
    <xmx:mOH9ZRDr5LQGhbPR-6Q4Pp6trF_iG4L7GucSP4umgRzD40nwaG6LoA>
    <xmx:mOH9ZVYHBramSgfg78RKo25a3XJOky41l0qg-rVWe2At4Z2zv8OyDw>
    <xmx:meH9ZcRm1slLiPEn15OYe3HO9oiXL9NFkcNxhpjJzaWAz7cglbfVrg>
Feedback-ID: i78e14604:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 22 Mar 2024 15:52:55 -0400 (EDT)
Date: Fri, 22 Mar 2024 14:52:52 -0500
From: Tyler Hicks <code@tyhicks.com>
To: Will Deacon <will@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Robin Murphy <robin.murphy@arm.com>,
	Jerry Snitselaar <jsnitsel@redhat.com>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, Dexuan Cui <decui@microsoft.com>,
	Easwar Hariharan <eahariha@linux.microsoft.com>
Subject: Re: Why is the ARM SMMU v1/v2 put into bypass mode on kexec?
Message-ID: <Zf3hlOcYd7LB6Xvj@sequoia>
References: <ZfKsAIt8RY/JcL/V@sequoia>
 <ZfNKv70oqqwMwIeS@sequoia>
 <120d0dec-450f-41f8-9e05-fd763e84f6dd@arm.com>
 <20240319154756.GB2901@willie-the-truck>
 <20240319175007.GC66976@ziepe.ca>
 <20240322155529.GE5634@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240322155529.GE5634@willie-the-truck>

On 2024-03-22 15:55:29, Will Deacon wrote:
> Hey Jason,
> 
> On Tue, Mar 19, 2024 at 02:50:07PM -0300, Jason Gunthorpe wrote:
> > On Tue, Mar 19, 2024 at 03:47:56PM +0000, Will Deacon wrote:
> > 
> > > Right, it's hard to win if DMA-active devices weren't quiesced properly
> > > by the outgoing kernel. Either the SMMU was left in abort (leading to the
> > > problems you list above) or the SMMU is left in bypass (leading to possible
> > > data corruption). Which is better?
> > 
> > For whatever reason (and I really don't like this design) alot of work
> > was done on x86 so that device continues to work as-was right up until
> > the crash kernel does the first DMA operation. Including having the
> > crash kernel non disruptively inherit and retain the IOMMU
> > configuration. (eg see translation_pre_enabled() stuff in intel
> > driver)
> 
> Right, I'm also not thrilled about trying to implement that :)
> What we have at the moment seems to be good enough to avoid folks
> complaining about it.
> 
> For the case Tyler is reporting, though, I _think_ it's just a standard
> kexec() rather than a crashkernel.

That's correct.

Tyler

