Return-Path: <linux-kernel+bounces-65382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C723854C2A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 16:07:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2832F28C9A9
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 15:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 961DD5BADB;
	Wed, 14 Feb 2024 15:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="vXbfXUMK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nC7KHPYT"
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35DAD5B5DB;
	Wed, 14 Feb 2024 15:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707923246; cv=none; b=LJ3979lJiJ4xwZ8JICAuJXSasnOVOm2N2Z7mRvTFWnb/xESvhnzuYnCDhL9/ajkDXyLSJrBM3hfcDYTuE2CIfUx1ikPTFTo33ZAOPs+RwnRJGsKDCrh7987xA1uf/a0YLRaapuoTt3PCr3GYmKlteujOD50xIQdlm4wqlS1yJjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707923246; c=relaxed/simple;
	bh=EkvVOPPnCFk/hyssrPlfM7oBLOoM7URKkRX378IAYG4=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=CxJM8iMDQiCnAYowIM2HdWkybbqCHo5FlNmo1brib3lUVzffto1YqTlqLJLzK63HesDzvl+udSmFtVKKxriuNS+dxzKxsK5ncqA2trwKe1K2JXNd2uXh17NS9n3riG8R5mzGCq/pRWXIvEYRhxYaiLczMGLGwNNrl533ertQJw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=vXbfXUMK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nC7KHPYT; arc=none smtp.client-ip=64.147.123.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id 213113200406;
	Wed, 14 Feb 2024 10:07:23 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Wed, 14 Feb 2024 10:07:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1707923242; x=1708009642; bh=k14qTSuVKV
	AB2YnlzxbQcFVIAQUz1+6sVcwSBNJ+Dw8=; b=vXbfXUMKvGE5joKax4FsSA1TMd
	JR8uldw6+ZUxoWU5Vqqp2jL6OkMV/tDtyS47HsUk3YiRMjHFjMLSGiNdhorPFgGO
	RRy7xGSCP5QBlMWCPFHTEhRSGxJoruukbxpo5kEYnhEB5PQ7zxgnifWtnxcCC0L6
	e1xFLZKlE2IkPwRdCiV38KXsGHFWXuvP60FqECB1matsjb2oTeSztyvQmshjE2IP
	tGfvBjEk40OFqSdiqImYh48iFxaqQ4c9MDC6tH9DkgigCmVZuWK4vWy+mn16c0F9
	3ubz5cvzYUNiI0AxSnEWjahmfE2fLSbYDI33wWa1XEZ0ihaM7HFNlVXLbPbA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1707923242; x=1708009642; bh=k14qTSuVKVAB2YnlzxbQcFVIAQUz
	1+6sVcwSBNJ+Dw8=; b=nC7KHPYThl+xCy2/bCpYs3ACWcqSE8AUyfBBeR9TjIgP
	pboNZMEppHDh4WyStVYV7i1R/JdhdoyzmAKoLvxkLoTDkQskmZUzK0t7iecRASH/
	ERM1R60KVdZ1pBu3rKjVgbnZ0VPYnxGaK1txGzckO8qyNCLNANk/JHvo8pVgiJX/
	FeXA8EWghnY13KZO+MvOyo+xP2snoYGQSbDqUHBPPMT8Nfh1PxlijLYBB8+fPNeX
	xiLdc9xE0Rp06XxjCsewG1QOl1JJ6bGjZPxBRivWC2/XmW3+fcHELppw3xS9PMeY
	usyBfyE5oBKiB4UNhbqmw0bPr5Gsr9DZSTVeyJK+mg==
X-ME-Sender: <xms:KdfMZazRfSPYKA-lIEWo-QU4HTXq6YFCuQyf9ckgMNvM45f0_vWpTA>
    <xme:KdfMZWTqeOFNmEevtYYy2hKSM0M0aVxfAGkMQZ0qYj2mscC-Gq3Ac2DrzHdR46nUA
    oYhQfjN76fHRdpEKds>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudejgdejfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:KdfMZcX8oWYDH5y0Bi0OFhKJNj-B3Z1FIOmgBxKbuY-AxrcGWWkw6Q>
    <xmx:KdfMZQgKkVytMwY2klCuFD94I4wclrLpjOoUbYMVCjoXsbXugSY8bQ>
    <xmx:KdfMZcA5aCSb163aEsKznyV0tczpRtMUrbqPiUWj-WMH0fq9JvP_lw>
    <xmx:KtfMZUZSwBP8nUi7MPJLCo_x-0c39bB7cFnLfd78jejOz1HaEKnstA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 759D8B6008D; Wed, 14 Feb 2024 10:07:21 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-144-ge5821d614e-fm-20240125.002-ge5821d61
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <3f1c2d5a-ba98-4ae5-a7a0-0328b7552113@app.fastmail.com>
In-Reply-To: <fd36f032-3bf6-4cae-a0d0-213604cef024@broadcom.com>
References: <20240213100548.457854-1-arnd@kernel.org>
 <170790035300.3179441.9169506478575963188.kvalo@kernel.org>
 <fd36f032-3bf6-4cae-a0d0-213604cef024@broadcom.com>
Date: Wed, 14 Feb 2024 16:07:00 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Arend van Spriel" <arend.vanspriel@broadcom.com>,
 "Kalle Valo" <kvalo@kernel.org>, "Arnd Bergmann" <arnd@kernel.org>
Cc: "Nathan Chancellor" <nathan@kernel.org>,
 "Greg Kroah-Hartman" <gregkh@suse.de>,
 "Pieter-Paul Giesberts" <pieterpg@broadcom.com>,
 "Nick Desaulniers" <ndesaulniers@google.com>,
 "Bill Wendling" <morbo@google.com>, "Justin Stitt" <justinstitt@google.com>,
 "Artem Chernyshev" <artem.chernyshev@red-soft.ru>,
 "Jonas Gorski" <jonas.gorski@gmail.com>, linux-wireless@vger.kernel.org,
 brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] brcmsmac: avoid function pointer casts
Content-Type: text/plain

On Wed, Feb 14, 2024, at 10:23, Arend van Spriel wrote:
> On 2/14/2024 9:45 AM, Kalle Valo wrote:
>> Arnd Bergmann <arnd@kernel.org> wrote:
>> 
>>> From: Arnd Bergmann <arnd@arndb.de>
>>>
>>> An old cleanup went a little too far and causes a warning with clang-16
>>> and higher as it breaks control flow integrity (KCFI) rules:
>>>
>>> drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy_shim.c:64:34: error: cast from 'void (*)(struct brcms_phy *)' to 'void (*)(void *)' converts to incompatible function type [-Werror,-Wcast-function-type-strict]
>>>     64 |                         brcms_init_timer(physhim->wl, (void (*)(void *))fn,
>>>        |                                                       ^~~~~~~~~~~~~~~~~~~~
>>>
>>> Change this one instance back to passing a void pointer so it can be
>>> used with the timer callback interface.
>>>
>>> Fixes: d89a4c80601d ("staging: brcm80211: removed void * from softmac phy")
>>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> 
>> I guess this should go to wireless tree?
>
> This has been like this forever looking at the "staging" part in the 
> Fixes tag. Is it really so urgent now? On the other hand I have no real 
> problem with moving this to the wireless tree. Just wondering out loud.

It's probably fine either way. Some maintainers like to backport
the warning fixes to stable kernels, others don't. Since the
warning is currently only enabled at W=1 level, it's probably fine
to fix it for linux-next only, but if we want the fix backported,
it should also go into 6.8.

    Arnd

