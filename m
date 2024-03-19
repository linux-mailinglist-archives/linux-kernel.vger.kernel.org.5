Return-Path: <linux-kernel+bounces-108055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 207A488054A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 20:15:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B408F1F23933
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 19:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1110839FD8;
	Tue, 19 Mar 2024 19:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tyhicks.com header.i=@tyhicks.com header.b="f1typ6jn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="w+/WRv1B"
Received: from wfhigh6-smtp.messagingengine.com (wfhigh6-smtp.messagingengine.com [64.147.123.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4E43A8C2
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 19:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710875697; cv=none; b=eAT7GB8OnvR8kEcyitbdSLtuiFOKSf4THkgl+rHSIDkoAPscwU9SsuFYMIupxM62VqOOAy2VXI788XLcKGzrUuD1UXTmuJ6mCMUQHNd0ELb2qLfYzSHYKym/uP+F9Jb4nzYE61YalwN73ntMTQlGBsvSz3WuJaNXKoDInSUQBUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710875697; c=relaxed/simple;
	bh=mIfTKsSciwJcMOvjOyzfSjDgGmSkwsc13Md+d9u6QJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q1XtYmrJKFx6opqiyJtrci8yZ/IMkc4D70sBCOXlw8+cMvxbEkjdQes4QQ8KlgzKLVPudmczi1Ed4N9mhGn+3BQ2kWYyylBGP5sw7YMvtNlb/c+cjFAD92dIUZj4A04XsKmCE7N195WAwYE3EpY4oKpfgmM7j0INPpNT0y4d0mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tyhicks.com; spf=pass smtp.mailfrom=tyhicks.com; dkim=pass (2048-bit key) header.d=tyhicks.com header.i=@tyhicks.com header.b=f1typ6jn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=w+/WRv1B; arc=none smtp.client-ip=64.147.123.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tyhicks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tyhicks.com
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.west.internal (Postfix) with ESMTP id A358618000E5;
	Tue, 19 Mar 2024 15:14:53 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 19 Mar 2024 15:14:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tyhicks.com; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1710875693; x=1710962093; bh=xGm0zjbmfX
	bFVPto+4v59X+3OdhXgzvRm9zT7AK86qM=; b=f1typ6jn+tQliNPQM72wKjsL1u
	DjfH4ga5pkmBPdskzl0IKbxNf6nHgJxvg/951gNak26e22y60wFeVz0KZBizRcz8
	7mpIvvpmAhYnv+G8hE/z+NzIADNl0MLSbCv2CUSscbVAuJ9BcUgkyW21sE5ohO3V
	pxFb7kQVFb1uWQt1rMRGbyrjCPHGXuCjt3Ryx8kJLc2Lafy50d6qY+cfyl+VHa+/
	CXqtgKV0bPhB1uUpu4kSMZd5rViLCQvdjIjmWEFSLfuIbn6eAj5yDzIqBcmwWdNl
	17H1pW5a3AIWqy/5eq2gQfZMqrZZzsk8SOxb2q0mid+kCik6tF7uoD27CyZw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1710875693; x=1710962093; bh=xGm0zjbmfXbFVPto+4v59X+3OdhX
	gzvRm9zT7AK86qM=; b=w+/WRv1B/tsfZrLuXlkBJ5oNBUCnmDhL/0dffSylcdj3
	c9BKFmjgww9P2Geix0ok8jLU3IUKXfPX8pgdNatKHAOTXe/VTlJumvucK2dWuKzM
	b3epcnVFhgwXBUDaTMTE4OsqE3f1t8wnzxaC3o5xEWiUWY7nS6oA0LQNP25wzesV
	VPUdGEwNTRAU7yYlm1ZTNhn5kE54OMfvjXJ8RYFa54pkuGsrGPB+UKFTTwgTnrI5
	gc90Gm6NoO9A8HmZZ+YqH7BraaWeQTpb8vytc8L6yrjq4cZLBJqTvZCdEaiqEXER
	ODyiLhGeZC1TS7F2cJA88FJsVyo8Wc2f0bW7NvovpQ==
X-ME-Sender: <xms:LOT5ZQdXi0PgPRa1t-aYGBmc3TD0whNhXIzrKZVir-sJKptJU1MNzg>
    <xme:LOT5ZSN07oZ0wSpUZiNQqwpYhttwp6rG-C_5r0EQ4kRjHHxahHE_Bq5ycQNM3wYCL
    x7ILdcqJ4jMbYf50pc>
X-ME-Received: <xmr:LOT5ZRg9gxHpMij7UGT69jXRux61_NhPpFJzq9dUw64Q-T0MzL83NM1BopU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrledtgdeliecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefvhihlvghr
    ucfjihgtkhhsuceotghouggvsehthihhihgtkhhsrdgtohhmqeenucggtffrrghtthgvrh
    hnpedvhedvtddthfefhfdtgfelheefgefgudejueevkeduveekvdegjedttdefgfelieen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegtohguvg
    esthihhhhitghkshdrtghomh
X-ME-Proxy: <xmx:LOT5ZV__x8TL_AIIgQFE_JJ_S6OY1S2n1lIbKpb_VvdamJV9YJgzvg>
    <xmx:LOT5ZcvZboJofQpLwW4UGP50SsxlCc0Gno51ghkzyMoRLlOTkMFCgA>
    <xmx:LOT5ZcG56XLETAoG0jsspMoeWkjOaY5iLHFvWBUTpUlB5e3JF0Op7w>
    <xmx:LOT5ZbMO8fggV9LH5VKajW8VswLDj6td-xOL3e2WwYiHs5jzpF3DKQ>
    <xmx:LeT5Zdl0O1xzebFACgACqQ72cTNXvVYZVAjRqka5yFz0lQWMD4ykGpXqw0c>
Feedback-ID: i78e14604:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 Mar 2024 15:14:51 -0400 (EDT)
Date: Tue, 19 Mar 2024 14:14:26 -0500
From: Tyler Hicks <code@tyhicks.com>
To: Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Jerry Snitselaar <jsnitsel@redhat.com>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, Dexuan Cui <decui@microsoft.com>,
	Easwar Hariharan <eahariha@linux.microsoft.com>
Subject: Re: Why is the ARM SMMU v1/v2 put into bypass mode on kexec?
Message-ID: <ZfnkEqglNPRzH3Zk@sequoia>
References: <ZfKsAIt8RY/JcL/V@sequoia>
 <ZfNKv70oqqwMwIeS@sequoia>
 <120d0dec-450f-41f8-9e05-fd763e84f6dd@arm.com>
 <20240319154756.GB2901@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240319154756.GB2901@willie-the-truck>

On 2024-03-19 15:47:56, Will Deacon wrote:
> On Tue, Mar 19, 2024 at 12:57:52PM +0000, Robin Murphy wrote:
> > Beyond properly quiescing and resetting the system back to a boot-time
> > state, the outgoing kernel in a kexec can only really do things which affect
> > itself. Sure, we *could* configure the SMMU to block all traffic and disable
> > the interrupt to avoid getting stuck in a storm of faults on the way out,
> > but what does that mean for the incoming kexec payload? That it can have the
> > pleasure of discovering the SMMU, innocently enabling the interrupt and
> > getting stuck in an unexpected storm of faults. Or perhaps just resetting
> > the SMMU into a disabled state and thus still unwittingly allowing its
> > memory to be corrupted by the previous kernel not supporting kexec properly.
> 
> Right, it's hard to win if DMA-active devices weren't quiesced properly
> by the outgoing kernel. Either the SMMU was left in abort (leading to the
> problems you list above) or the SMMU is left in bypass (leading to possible
> data corruption). Which is better?

My thoughts are that a loud and obvious failure (via unidentified stream
fault messages and/or a possible interrupt storm preventing the new
kernel from booting) is favorable to silent and subtle data corruption
of the target kernel.

> The best solution is obviously to implement those missing ->shutdown()
> callbacks.

Completely agree here but it can be difficult to even identify that a
missing ->shutdown hook is the root cause without code changes to put
the SMMU into abort mode and sleep for a bit in the SMMU's ->shutdown
hook.

Tyler

