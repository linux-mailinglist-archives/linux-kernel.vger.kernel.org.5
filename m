Return-Path: <linux-kernel+bounces-100747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61438879CA5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 21:09:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92ED31C21A09
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 20:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE50F142907;
	Tue, 12 Mar 2024 20:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="dHCVtnEz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="R/wuoD4N"
Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F3114265A;
	Tue, 12 Mar 2024 20:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710274194; cv=none; b=KrJdIYPgqo7Pq98yoTT27EmqXmYTmaL2lpfV/DsopACfcDJBQ4hdj0nJnqsf/+wW+MGDEdX3ORsdOeLp0qWDaf0YeRgzFT+l/+cKbD03L2JS6FfATAgmHarmkhsA3mWi/ubHzGhXHAflJFeo3KDCD+fGjyXURKF+6HLamF1hPO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710274194; c=relaxed/simple;
	bh=jpeWJ3RaIA/bcq+vrOksDn30PLA9sLMpriHUnDviXaA=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=jDyRVK5WkA6TqKe+xM/tbMF+yuTM/G4VBjrr+1gzpJsvvOudNe30qLCH4iE9V+wGd+ogKvHlGIfL99btUc+9mDZDgygWRZ74+OoQr0b8TJO1Nj2MfitZ1VzKd3vjtayOHape3YYuwrzqAYBqW0JjsHN0WgrV29aletPrZB+qG84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=dHCVtnEz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=R/wuoD4N; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id BCD7813800C1;
	Tue, 12 Mar 2024 16:09:51 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Tue, 12 Mar 2024 16:09:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1710274191;
	 x=1710360591; bh=JvyS36dgrFwt51pid3LyHJNrqlRZGupc/3d306PFVYw=; b=
	dHCVtnEzG4pegO0MfMNzjCRi7Gb8ULpCe6ooI7gAbCLQbMJAZ7fGMc2ek28w0dmP
	n609raXrb8heJnWk4iT/tzlRoFXxfSDyGTfNecdRJ4cOKPodwHXXa5EXHcM7mZoA
	OaktmtkpzoAy67Ee6E+Cmle8/13SXtYjs8zNLaEbaS6A9HcabtMAwssPhzQN6MAc
	aFMiDsDmGywUrAZkaUu9mQ1uYPNtROyymnjQldWoYs9wIPfljb4lYHNZ6ZBY09mQ
	LcbVxQDgNHYX2r5vuHnZPEe+ZwyQoP7uV3r6xAbvW+VFBU5K8i82o4gnJs4VstUG
	MDhHRJkKs0sOYvBoxqhZKA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1710274191; x=
	1710360591; bh=JvyS36dgrFwt51pid3LyHJNrqlRZGupc/3d306PFVYw=; b=R
	/wuoD4NRetU+n7kx4NajRyAzx+191uaUZghXmzrKd7t3xAIGfhj/DcernUy7YEPS
	xvJA62+B5ToznvtC8mzcDNqnhxC6x0YKW91UqfGfVs5A3rXy1qKbnMz7/pNhVifH
	+KVpToUBRVi84129Yafenes+495lgqiiIFUrN3dJjcgPkhJC1u2qYa4iQeVkhY+n
	i71DigL8p4pvLftmvW3MvdyD9jCKH4T7gcatrUOqh6Dk/1K8lcLvQZdkJ/j9tgL3
	y2XGyu4eTnjA8ryNMPtFsyKcX1SSHUrKUXuZP0PWS/qa+9nnLdyGe6g6s0O50696
	VfEzIA8oys/U2R10EVjYA==
X-ME-Sender: <xms:j7bwZcgtfn-7IxAtEdEzh5TfphxHlIwNErs5oj-ERFMdFOocvO5Vkw>
    <xme:j7bwZVBKMZJ4cLMbZkgxTsl37eSVA2BX43S6qL-ZIGRp74TdtCD2fV1ucOpFv7n00
    QKdfvtjBXPaoI6q5VQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrjeefgddufeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeegfeejhedvledvffeijeeijeeivddvhfeliedvleevheejleetgedukedt
    gfejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:j7bwZUHc4GAL7cdXFWfa3HDR4jcAXF18vP2KJTGkUf4OrFILK8VKRg>
    <xmx:j7bwZdSZb_ReaSfIeue_lUm_ovX880s6fqih3eMRzi19YaqTi9Jeww>
    <xmx:j7bwZZy7bDvXIZsNEp7vP_zzvEvtG19nfyGmHGmQMYTc14tGD1y7Gg>
    <xmx:j7bwZb6lkLqu4u4meMaWe14f49YydZt8j9vxRge4AWE1YHr0f51_ig>
    <xmx:j7bwZQmVcsUKntRHdo40akcfT-WmqV_VDyB5cKK1WC9qhHvSHrFUNg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 70AB8B6008D; Tue, 12 Mar 2024 16:09:51 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-251-g8332da0bf6-fm-20240305.001-g8332da0b
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <cedfda68-d9fe-4051-bb23-ecf6ddab853b@app.fastmail.com>
In-Reply-To: 
 <4c9621d72bf6a7dc427e174edde6c1b0ae7a0469.1706083174.git.u.kleine-koenig@pengutronix.de>
References: <cover.1706083174.git.u.kleine-koenig@pengutronix.de>
 <4c9621d72bf6a7dc427e174edde6c1b0ae7a0469.1706083174.git.u.kleine-koenig@pengutronix.de>
Date: Tue, 12 Mar 2024 21:09:28 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 soc@kernel.org
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
 "Pengutronix Kernel Team" <kernel@pengutronix.de>,
 "Sebastien Bourdelin" <sebastien.bourdelin@gmail.com>
Subject: Re: [PATCH v3 1/2] bus: ts-nbus: Convert to atomic pwm API
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 24, 2024, at 09:12, Uwe Kleine-K=C3=B6nig wrote:
> With this change the PWM hardware is only configured once (instead of
> three times).
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

I'm not sure what happened here, but I just noticed that I missed
these in my pull requests. I still have a soc/late branch that
I was planning to send out in a couple of days, so I ended up
merging it into that now.

     Arnd

