Return-Path: <linux-kernel+bounces-55562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F190E84BE28
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 20:35:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3FAB1F2428C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 19:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 369BE175BB;
	Tue,  6 Feb 2024 19:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.pizza header.i=@tycho.pizza header.b="2ftn8JTt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Cqvw0PAn"
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72052175B4;
	Tue,  6 Feb 2024 19:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707248115; cv=none; b=rlxTId1w6oII4GySyIGLrl1BIWBKvhDMTHe0tAIdYEc7ldEuG7ncB5Uist8bTb+5FH4SjOsNhX1V1XECm/FlZ5psM1qSk0mlY+vxR1lKZr5CEE2Loq4U/sX7+sO9lhx7N0N2nxGzYULvkrJqON9QLwTMfBdoUGyxdi5D0Hu5OoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707248115; c=relaxed/simple;
	bh=xWAHkj6oLXesB9J7U7zS+HoVDGaRAHiH8XlBjN5iCTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bA6AweEPrcNUnUdz2kwJK0TRyA5l6RJhPOvCpxmle9Xxll0kAsZmTmrlxYGX0P3v3nZTxT562shHq6RnXHQ6Sy9E6bCFnZnEMuDW4t1/oI/0UA/M0nOSMiosHdC5bRTLLHQqGkzcoNHTfayD23YksuO9FsI5U83LEqSAkC3Yuuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.pizza; spf=pass smtp.mailfrom=tycho.pizza; dkim=pass (2048-bit key) header.d=tycho.pizza header.i=@tycho.pizza header.b=2ftn8JTt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Cqvw0PAn; arc=none smtp.client-ip=66.111.4.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.pizza
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tycho.pizza
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 60D425C01D0;
	Tue,  6 Feb 2024 14:35:12 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Tue, 06 Feb 2024 14:35:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tycho.pizza; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1707248112; x=1707334512; bh=xWAHkj6oLX
	esB9J7U7zS+HoVDGaRAHiH8XlBjN5iCTQ=; b=2ftn8JTtc0FEL/uRu0/zdm6hnh
	9I3B2gi4ZVSlhq5PA1xD9Ri+CRHRSJR4Wom5s4m38gQI4ElNpmG3aLK+j+FJcN6+
	G5h23N/omTigJxauz4MWQf9NcOwkTGwCsLwpGQLAQsm9Bq2ke2Lh7H6Q9Wgtps/L
	nEED3+NJ4gfFWa9VEsjFRE54CrHO/DD3MCJqttska0ABBc1vVCc/NVtp03lSPPWy
	DStHMq22wUGzktQu7jrSLS3NH/llobBKXklnEFN8LZWdG7zWuvWzpQR2RmDjZ9Xc
	+wj25QT6E5HE9yUUQ5oNabdxjzrNw1n9snRRiDKdbXUg5QOLIvwG73X5Y61w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1707248112; x=1707334512; bh=xWAHkj6oLXesB9J7U7zS+HoVDGaR
	AHiH8XlBjN5iCTQ=; b=Cqvw0PAnhbfxvhzKaTvH6ohivQshuONbPDBaBjTZkH+8
	gbjLXtKivBMtMSCg83sCjBWIrInwuCRPVDwYvNSPCL4YWA7udtSGPbNyc/8HXUyN
	hfSv3+ni2406B/nOfz8ALavd+yDAwPhTkWChcdDTiPgFKVx7/8MBzfQ4sLBPWZy4
	EbffNFErh/mH5nZSe4o3Vs7o97aVexIAmzxYc1TYQxHW6PHbpjy34t70VfG6SCXb
	LF53do1fOmMMM5lPbpacekFioteSmolKFf5CIqY9KyP0xM9G1d6eJJDewWAGDaFW
	2sAZg3fvdsY2vlbEfXKP9bMJ9ZIAFczFys3GhHVfCQ==
X-ME-Sender: <xms:74nCZcfEPAEEmMMjg5MnS0tjuMsg4LONWtM9XyNsemQWf5MTwt8xuQ>
    <xme:74nCZeOuFGHwmQF5susKfPJZtti1-ZM-sqL239sB7ubwwClVNHXN4B1ZERcO6VuQb
    zMgi-v1gaF4iIRpkzU>
X-ME-Received: <xmr:74nCZdjAkvVff1o7ZMUpPO5xlUvInUphL8QO9W7aYrQqQ6NS6MbGkVzJCOc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrtddtgdeljecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefvhigthhho
    ucetnhguvghrshgvnhcuoehthigthhhosehthigthhhordhpihiiiigrqeenucggtffrrg
    htthgvrhhnpeeutedttefgjeefffehffffkeejueevieefudelgeejuddtfeffteeklefh
    leelteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hthigthhhosehthigthhhordhpihiiiigr
X-ME-Proxy: <xmx:74nCZR-YwcTBaOHBLPBjTowHSS5Ts_4Hw0eAP-A0gDC-w5MRgXBuvA>
    <xmx:74nCZYtj8Q_kOTGsQSUJ12l9G-rYg8l1HtGnzxFoMZoUD5sTaHR9FQ>
    <xmx:74nCZYHgQHjY03ib78d3MIL3iCby-xTwl0ALMq5BMUCps7ZEkLFOQA>
    <xmx:8InCZSW_Bv2i8pVCn6ZjdgH3T35Y6dixGVwJYmq6WnITa622QCugrQ>
Feedback-ID: i21f147d5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Feb 2024 14:35:10 -0500 (EST)
Date: Tue, 6 Feb 2024 12:35:09 -0700
From: Tycho Andersen <tycho@tycho.pizza>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
	Tycho Andersen <tandersen@netflix.com>
Subject: Re: [PATCH] pidfd: getfd should always report ESRCH if a task is
 exiting
Message-ID: <ZcKJ7YYJK9przO8K@tycho.pizza>
References: <20240206164308.62620-1-tycho@tycho.pizza>
 <20240206173722.GA3593@redhat.com>
 <20240206180607.GB3593@redhat.com>
 <ZcJ13uLxD6rTqqZZ@tycho.pizza>
 <20240206192553.GC3593@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240206192553.GC3593@redhat.com>

On Tue, Feb 06, 2024 at 08:25:54PM +0100, Oleg Nesterov wrote:
> But Tycho, I won't insist. If you prefer to check PF_EXITING, I am fine.

Looks like we raced, I sent a v2 with PF_EXITING, mostly because I
didn't want to run into weird things I didn't understand. I'm happy to
fix it up to check ->files if that's what you prefer Christian?

Tycho

