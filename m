Return-Path: <linux-kernel+bounces-118357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AB3788B974
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 05:33:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FDA51F3E244
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 04:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7791C5A110;
	Tue, 26 Mar 2024 04:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="j++kSQ/g";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="L2eG5ok8"
Received: from wfout5-smtp.messagingengine.com (wfout5-smtp.messagingengine.com [64.147.123.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9073033FD;
	Tue, 26 Mar 2024 04:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711427606; cv=none; b=MbCOjV1Nr0LfrSzhpW3J+0ljS9Pu4O7kLx+wed6Andk4WXLZPitAkmp0l++BZVyhj0gPwdtzRlyqlxjBmE8YI/i/I3mJ+VAOHwhw3IQsbuEHppuTQoPb8aZeEto5X16iWw6HBv/f9fpVIJJlmEXGGkFfIckB2KbWGr0kum3NWtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711427606; c=relaxed/simple;
	bh=IhgcPJahWSRqfjJwBrShpUw5E2m43EnaA2Mt/ATePLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n62D9sa1fWfGYkCQVw5vBa7GonRGWzhNfW5HwEH9MhJYKHQCejevpmRPMVNOyk3BVEWDhzINXBxB5Z5Uz3+4csD09QcxcZDEORJevD5fdmnj7X27wOu1qJ4VvAOVamIUS/0gAu7lOAZg3AEHQdvRoJOst9HMRwcskZgzsLZQToo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=j++kSQ/g; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=L2eG5ok8; arc=none smtp.client-ip=64.147.123.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.west.internal (Postfix) with ESMTP id 044F31C000A7;
	Tue, 26 Mar 2024 00:33:22 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Tue, 26 Mar 2024 00:33:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1711427602; x=
	1711514002; bh=J1PIXRG0tyhvH3hge9TpL3+zsAlh+77DoXH9DaFIs9c=; b=j
	++kSQ/g5nHKE5YjDucGr5xoVotGPBsW1jkMQtS0eDswn6msQijgd4Vgo/P2R2FSU
	hgI7URMx3qkYKaA1g7IAkFTGTjrxAXHVhgeRnwVuBV9Z+4KdVM5lJbdj4ZIk/4SI
	2WxJRNhJu4npw8B8AUwCAxmzDikeIa2MPOZrlFUz4Gmsq92rmtCwxUT/tGObRyVZ
	fRUpM+JObVAR4Qv+bLcvPDPjdMiCgjt1yhxdxVedJeifkJIx4RCr5jG12E3wY3gS
	XSRN7BVsgV4fv74/xDdDCUwYAwBiHVJ+Dq8MMwHv/MDlBwxjxpQahyys7e5cj8g5
	cg+xCtI4E8qO8T3aGIl6A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711427602; x=1711514002; bh=J1PIXRG0tyhvH3hge9TpL3+zsAlh
	+77DoXH9DaFIs9c=; b=L2eG5ok8zkYt4QDNArV9lwAs2w4HfoYNzvCcifPRkmfT
	Y5rOJq5blihrVCwwU8BpIj3xEAJcFXLnsThOcfytE9m1aHGcl1U+CRC1J2eT0Lq7
	Hoaut4xU1plVUTK/oGB1gg9fVpJa7aAKnSDyMgYCu1KHx+GacRjqxG+8NwNO/Do/
	RCucjFJS5kTM0SYHMwpkMc80aFXpfJhuyJirl+YA0K4t0EUOEQVxlkf9B+eUTkSC
	ZUCE9ote0WSb/3hhx6K/NUqwzV8q4VYHI0pVi04R9eAGSg9shGbUxYCSP/5Uugxo
	/aIYpqUCRpU9BaBoktENTVr8iaYe6KY8ayDjpkIs7Q==
X-ME-Sender: <xms:EVACZmgHmhDsH4I1C3WHZh-z4rNYFVh9a7dQbSHrqgRMjOdLWlB8mA>
    <xme:EVACZnCzEsBhx9Dp0icVi0CTTdMN37RGzryk_rsbsUuMDDu61ZCc6jdUKb6amDKS-
    qkY791PODvpa4tujic>
X-ME-Received: <xmr:EVACZuFezRcNC_YeXn6eKh_1lQ_nbsM_Ruxm57yZua5pI2GYzk6cQnZmyPXZAFflgyvBOFbhqn3hccBZ2OHKX2fIQW5bAsdsCxY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudduvddgjedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepvfgrkhgr
    shhhihcuufgrkhgrmhhothhouceoohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhird
    hjpheqnecuggftrfgrthhtvghrnhepvdeugeejleeuhfeggeehieejhfefheeuledvfedv
    fedtfeduvefgheehgefftddtnecuffhomhgrihhnpehgihhthhhusgdrtghomhdpkhgvrh
    hnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhf
    rhhomhepohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhirdhjph
X-ME-Proxy: <xmx:EVACZvT3_n-MhYpbtkopfVa5aZ3_ChW1_xcuI1taeMxraG_A6z-law>
    <xmx:EVACZjyPiPvXPNr5STCXdOFtnkJ0hW-UPBWnCFLcVyvBaGLpkuPbQQ>
    <xmx:EVACZt6AC14-EPQIMlS7NHcR6Jmjz9pe4cu4D3B6t_JzAs_zFHXlbg>
    <xmx:EVACZgzk8iMyCUJn2XlB2cwWZnF3pgw2zrXhxFgAFxsfCor3l7yb4A>
    <xmx:ElACZrf9UXW5o6B7lug2NVk4d3lvchLaArWvU7KUl69nHzrVjwb0VgCeDAc>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Mar 2024 00:33:19 -0400 (EDT)
Date: Tue, 26 Mar 2024 13:33:17 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Clemens Ladisch <clemens@ladisch.de>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2][next] ALSA: firewire-lib: Avoid
 -Wflex-array-member-not-at-end warning
Message-ID: <20240326043317.GA125304@workstation.local>
Mail-Followup-To: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Clemens Ladisch <clemens@ladisch.de>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <ZgIsBqoMb7p3fMDr@neat>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZgIsBqoMb7p3fMDr@neat>

Hi,

On Mon, Mar 25, 2024 at 07:59:34PM -0600, Gustavo A. R. Silva wrote:
> Use the `DEFINE_FLEX()` helper for an on-stack definition of a
> flexible structure where the size of the flexible-array member
> is known at compile-time, and refactor the rest of the code,
> accordingly.
> 
> So, with these changes, fix the following warning:
> sound/firewire/amdtp-stream.c:1184:46: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 
> Link: https://github.com/KSPP/linux/issues/202
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
> Changes in v2:
>  - Use DEFINE_FLEX() helper instead of a new tagged struct.
> 
> v1:
>  - Link: https://lore.kernel.org/linux-hardening/d3a764eb76909b16b8a22d9ff530e5edf0e59e6b.1709658886.git.gustavoars@kernel.org/
> 
>  sound/firewire/amdtp-stream.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)

It looks good to me.

Reviewed-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>

I remark that the change requires a commit d8e45f2929b9 "overflow: Change
DEFINE_FLEX to take __counted_by member"), added to v6.9-rc1.


Thanks

Takashi Sakamoto

