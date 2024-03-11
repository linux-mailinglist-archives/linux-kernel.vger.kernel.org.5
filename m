Return-Path: <linux-kernel+bounces-98903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17F3A8780DD
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 14:48:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 498A81C210C1
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 13:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFD3F3EA76;
	Mon, 11 Mar 2024 13:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="IsAE6hBp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eLRZZ7Kp"
Received: from wfout3-smtp.messagingengine.com (wfout3-smtp.messagingengine.com [64.147.123.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829D13D980
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 13:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710164908; cv=none; b=sBEl58NVP+t9aXqb4gkLNrG/Fz6GeOxY5slK33Zyyc6aaCJ98XRPWCotGWWI8MQJr3w0MySqlGUYiYYm+C7Oq3C+PFRSo9ZEr+hcMaJu7cIHMDn8qpVT2zklM6N/hfnAjUB0LaKC38ubTTqTkngV89Ywe12N+2ivuY/qG3ByKpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710164908; c=relaxed/simple;
	bh=JwFhNcltET/5iR5Z82DtdMceMKD4NjNi9mXexJ1CDpc=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=vAEJn2/9RiiFQ37XlNrVUu/LkP6RFFNKKg3tOxxhgytTX1UD2ntHp4OOOKwe+azUyZuLEHqqdexQwfblv7VMWumBI5v016gTK9LwuB0HUHx/6UsqfDJ8wLQ24km8tTZPRFf8l9uGLRCmwaLgpOLp8TOCehLEtDUfRs6AucmhhIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=IsAE6hBp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eLRZZ7Kp; arc=none smtp.client-ip=64.147.123.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id 0E0431C000B1;
	Mon, 11 Mar 2024 09:48:24 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Mon, 11 Mar 2024 09:48:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1710164904; x=1710251304; bh=Q8T7XcaJvG
	uNzCsIyXIKyrBjX/uVrAZPhM5aHBDGPpw=; b=IsAE6hBp0ZCG8iEiAKjtixhoP+
	/i1UkOUjHFNiFpAdAH5xjWvemKwclUBei6moHoWv2iDTulL6xFGjQvK9AeshB/0k
	EYJP0E1D70IH79rcTs8kSFTUINExqluHYsoF1s0wBabB5pKSwsYRgYiKVZ/oNYAc
	DGEXEwmFkISPMc1f6vm1wDIGOW6p8BRC+1B2Kc+ySwqtykOq1VCROQ3SUDAW1hu3
	dF1vmDOw45n67yJ08KCAPUvWlt29CnJvgRV9psbln7FD1WAJ/NRaxj9tqLqNu1r9
	HjCKJ+V8BuGDh1Yul+cqKEsjSWvsYkdzLyanTC7tvrV1P7Rf342bG5FQ/6/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1710164904; x=1710251304; bh=Q8T7XcaJvGuNzCsIyXIKyrBjX/uV
	rAZPhM5aHBDGPpw=; b=eLRZZ7KpCDeV6Ed0XWeZLbboxDSbDbbUBpktDo25cmYe
	iil348nvocGT12b+UtB9vgBOx0HZ5R3uuEiR0Gl7BiCFGu2KYHqJ0mMDZjqGxyR/
	ZO5IbmkQOvGBNfsCt8IZ+PB9b2+rRQtb5xFBGCXZFLuXEQGAEHA65zp1L1BuRVIE
	A78Ga/ojuwETCWhU1LZN8bnU4Hk7cwPZRTRhRdOSa4OS5Hj8IgkCXvWLQdb7zVjK
	qLIMwx5/WdhizIaFmdIUkpsEDZV8D52p9C2dbyTMHX8uZPMF9pPiBzNued8J4G2s
	iTxGINj2mqSPOtWocC+/8oAVGgsKOcRyE8omz6dZXg==
X-ME-Sender: <xms:qAvvZXMTOXWeEkOxj1_ivpTztBGNI3kamLRAd5a_jNSd_FUrPx6ZtQ>
    <xme:qAvvZR-2wCDeX6oGvNM7be7iMwPHB1Jpiq9w3-_6mLeZqlX6K3bwD4vIuxmJZvTZc
    qan1Y_KQMar1DdLHSE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrjedugdehiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:qAvvZWS9odMm2XRS-fddCN2QOH3zOxHsuRaAF1n1VKJtQkii6BTjTA>
    <xmx:qAvvZbvnGAEYrxAqlDycKrD3rSMd2FhjRzxVEYYzdJc9R65e69WrmA>
    <xmx:qAvvZfdwdN6xYyZ0P9DqsLE3jyo_0FWkR6bTMkELivAeZmDC71BcHw>
    <xmx:qAvvZQoGqnivnutqMo6cU6mzEq2MUZZUvq10QnDoXL7LY1j4BL83_9MfWm0>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 47BA3B6008D; Mon, 11 Mar 2024 09:48:24 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-251-g8332da0bf6-fm-20240305.001-g8332da0b
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <8f27c774-7197-48da-a6f2-6d375bd848f0@app.fastmail.com>
In-Reply-To: 
 <f713d82fe6526288f51fc138cd16681cec6b43a6.1710164592.git.geert@linux-m68k.org>
References: 
 <f713d82fe6526288f51fc138cd16681cec6b43a6.1710164592.git.geert@linux-m68k.org>
Date: Mon, 11 Mar 2024 14:47:31 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Geert Uytterhoeven" <geert@linux-m68k.org>,
 "Andrew Morton" <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fork: Use THREAD_SIZE_ORDER
Content-Type: text/plain

On Mon, Mar 11, 2024, at 14:44, Geert Uytterhoeven wrote:
> Use the existing THREAD_SIZE_ORDER definition instead of calculating it
> from THREAD_SIZE and PAGE_SIZE.
>
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
>  kernel/fork.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 0d944e92a43ffa13..e79fdfe1f0bf4953 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -252,9 +252,9 @@ static int memcg_charge_kernel_stack(struct vm_struct *vm)
>  	int ret;
>  	int nr_charged = 0;
> 
> -	BUG_ON(vm->nr_pages != THREAD_SIZE / PAGE_SIZE);
> +	BUG_ON(vm->nr_pages != THREAD_SIZE_ORDER);
> 

That doesn't look right, THREAD_SIZE_ORDER not the number of
pages but the the log2 of it, right?

I think you want '(1 << THREAD_SIZE_ORDER)', but at that point
it doesn't actually look simpler than the existing code.

    Arnd

