Return-Path: <linux-kernel+bounces-85016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78EE986AF2E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 13:28:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07945281FD6
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 12:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14B5F12F387;
	Wed, 28 Feb 2024 12:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="hTJOvhKL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LwGTjde4"
Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95D712D766
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 12:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709123229; cv=none; b=V7ugzBWRU8i1kndbNa1F9jm36lW3Ja/XrNz/76QqNFJLtCw3qg4hw01o0GInSooId0kRNRcqumQ1Ag/acamLNZFSHtAzrnd0x/rvuP4//g+nQwyPSY//ZsnuQAi0RxSWBh6AeD9PyJXrIVul6W+kGMg3HmbNM5LS8pnNezaSydc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709123229; c=relaxed/simple;
	bh=ZiKlFrPZMfX/lsr8iqUEwVSWJ6ckpPINlGEk3Y7SK40=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=n5fn3VyPVop9AJsXzaWaQjmewL/Sg7y3kc9/GsdZz+vPg2cG3rovvmZGeRjAMrsgw75VLLWyqWedqJchqCtO8YJ1j3nFE8Ap4Tc+YeS4Xfq/iK4xysnrPj5IooTCDkyK0R3NYO0DJKHK391Yghc2QYX0cgDKJpKXcMAdfTlVIFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=hTJOvhKL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LwGTjde4; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id EC53811400B2;
	Wed, 28 Feb 2024 07:27:05 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Wed, 28 Feb 2024 07:27:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1709123225; x=1709209625; bh=NvXreyBpDp
	tssmYJWYfiUdp7AMo/Vkt6KKjFpA50xek=; b=hTJOvhKLUIRULLUpBy0nU4WxD2
	LNOikhUWSV4dZ4K3XVFdwx5vFRUFtZhPKQMmSHGL3Em9BZefNI3opWoomZPO3cuK
	dDti8ZykaispBUIihQCaJJISsMBcoIyFqI3PqldO2FQq2mlg26qawbG8jV3233Gi
	WWth2SR68Ao6/iSuYfCkP9+Q+HGAp8dI/T2c6uF8GjM0G0uXqT9oPVrnDo0Bxx5e
	Ymy3TBza9zjNR2Kn21fkUgQBGXph0bqUtouo2CYPAPT2kcWVbz1Ls8JktvoSaHcs
	8SZJcFjB4rWjBUfzzyyMg+Iz4isKniR4+H8ldpQRWVdxWAyzAD5NApKmZhow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709123225; x=1709209625; bh=NvXreyBpDptssmYJWYfiUdp7AMo/
	Vkt6KKjFpA50xek=; b=LwGTjde4yuDMXoy0vchb84skXNMkqtmVTCm4LsaKwi+W
	Ra0vJ3LHJNQ396P+w5maIIV6OxDj+d69cLuJ3mF8oKsyaZOLe5hE76qBFJWwf8bk
	ADN88i7s8Wlj9jV6NdQ2hLd3c/T14apsWfCYrjvE0oIfKDiq6R0xoaSUtXaPOkxD
	gSrHgruCyj/CyM1SwPogTKUj8cKX2A9K32AcpRBIA3qpjf5SrphJLJslgxmRjO2y
	3nCmfbuObMgjR7HYByPZbVeMG07ys4UMs5YooF+vMUtHTm2ayj+FtyhyTqMTsDcK
	3lPn8TRYIKeymhPmVHjkePj3DoKJwHDbEvQg8BL8uw==
X-ME-Sender: <xms:mSbfZZQuIwMkl6tnbBxHGj0eIpl4i43TVltp0-45yGCPjW_K5pbG0Q>
    <xme:mSbfZSzpOYJkm3U5uhSkWAYY5WOZ1e3bATNd_yggZmjGNcjqPYbH17cTcQwmfydYo
    NXtg8T1IMYH8nMO_Uk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrgeejgdefiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:mSbfZe0nFo7etxjN5tiz5X-sskqp_-8Y4zmh7qmJAzhw64qDOQwmgw>
    <xmx:mSbfZRBarQB6eEKB82mrB9aI0M7u43KL-jzPUbafWLhHf8GK66OSUA>
    <xmx:mSbfZSh9vSvBFLtoVDuIMgMwveJBnRhOH9jffZ-khp40oO_VTWFZIA>
    <xmx:mSbfZS6u1fwf3B3fgkKLB_bwvXKxE3IHgr0IV0X-4_8et7Kh09ohSw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 2B6F2B6008D; Wed, 28 Feb 2024 07:27:05 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-182-gaab6630818-fm-20240222.002-gaab66308
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <0c6127da-53d8-4c37-8337-e64e3e91bbaf@app.fastmail.com>
In-Reply-To: 
 <kq3cpbz4ctqvfhtlh7f7wxd7ub3izdjovhv2jqkjasre7u6y2k@exaw42ber3f6>
References: <20240226124736.1272949-1-arnd@kernel.org>
 <20240226124736.1272949-3-arnd@kernel.org>
 <kq3cpbz4ctqvfhtlh7f7wxd7ub3izdjovhv2jqkjasre7u6y2k@exaw42ber3f6>
Date: Wed, 28 Feb 2024 13:26:29 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Lucas De Marchi" <lucas.demarchi@intel.com>,
 "Arnd Bergmann" <arnd@kernel.org>
Cc: "Oded Gabbay" <ogabbay@kernel.org>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
 "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "Dave Airlie" <airlied@gmail.com>,
 "Daniel Vetter" <daniel@ffwll.ch>, "Rodrigo Vivi" <rodrigo.vivi@intel.com>,
 "Matt Roper" <matthew.d.roper@intel.com>,
 "Matthew Brost" <matthew.brost@intel.com>, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] [v2] drm/xe/xe2: fix 64-bit division in pte_update_size
Content-Type: text/plain

On Mon, Feb 26, 2024, at 17:40, Lucas De Marchi wrote:
> On Mon, Feb 26, 2024 at 01:46:38PM +0100, Arnd Bergmann wrote:
>>
>>Fixes: 237412e45390 ("drm/xe: Enable 32bits build")
>>Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>>---
>>v2: use correct Fixes tag
>
> but what about the other comment? How are we supposed to use
> DIV_ROUND_UP() but then in some places (which?) have to open code it?

The problem is not DIV_ROUND_UP() but the division but the 64-bit
division itself. There is a DIV_ROUND_UP_ULL() macro that would
address the build failure as well, but doing the shift is much
more efficient here since it can be done in a couple of instructions.

> What compiler does this fail on?

I saw it with clang-19 on 32-bit arm, but I assume it happens
on others as well.

>> drivers/gpu/drm/xe/xe_migrate.c | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>
>>diff --git a/drivers/gpu/drm/xe/xe_migrate.c b/drivers/gpu/drm/xe/xe_migrate.c
>>index a66fdf2d2991..ee1bb938c493 100644
>>--- a/drivers/gpu/drm/xe/xe_migrate.c
>>+++ b/drivers/gpu/drm/xe/xe_migrate.c
>>@@ -462,7 +462,7 @@ static u32 pte_update_size(struct xe_migrate *m,
>> 	} else {
>> 		/* Clip L0 to available size */
>> 		u64 size = min(*L0, (u64)avail_pts * SZ_2M);
>>-		u64 num_4k_pages = DIV_ROUND_UP(size, XE_PAGE_SIZE);
>>+		u32 num_4k_pages = (size + XE_PAGE_SIZE - 1) >> XE_PTE_SHIFT;
>
> also the commit message doesn't seem to match the patch as you are only
> changing one instance.

Not sure what you mean. As I wrote in the changelog, the
second instance is fixed by using a 32-bit division here,
which does not cause link failures.

      Arnd

