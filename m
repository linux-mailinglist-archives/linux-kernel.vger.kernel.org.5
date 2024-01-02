Return-Path: <linux-kernel+bounces-14315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9568821B3E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 12:53:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 579572831F0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 11:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD8E2F9EA;
	Tue,  2 Jan 2024 11:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="U6rECvbH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SZ+2iCxb"
X-Original-To: linux-kernel@vger.kernel.org
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1D8F9C3;
	Tue,  2 Jan 2024 11:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id 3DFD53200AB5;
	Tue,  2 Jan 2024 06:53:22 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Tue, 02 Jan 2024 06:53:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1704196401;
	 x=1704282801; bh=78GfTO7R2KAqCaUTBElHrc44apEjYHc36FVjq5911Xg=; b=
	U6rECvbH2toS0b0UpeBZZv4K7IAw7Ecn5LxGVIqu5d5x1FnNvR92LKTi9whWHKSY
	1jvGSv72tMjM3yfZzl8OhlP6upxv833uGXXE5sNRTwFD0xfCvpTE3R1zyz/5KqUl
	PuAVtL8ZjsCze4G6UrHZXX7a2DTDkwN4yzls6kh1Yes1B387+dnV3XIfKS46usRy
	MFk9yhmCF8ZsZZiVyevp38QKqORDNLCUZXt1FuCYrXSYRxMkIXKN7qrHdkOp/RB3
	/Y4fFMfmWVaGUExmK/L+RnJ/fqoYyHpWGnKWi/MnhO/rI0g0sFPdMwplJdNUwE6/
	ZlWxR3S7dEZ8AKrbnmT4Ow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1704196401; x=
	1704282801; bh=78GfTO7R2KAqCaUTBElHrc44apEjYHc36FVjq5911Xg=; b=S
	Z+2iCxbn55HOYCciQITpOct/bkhChuTAijeMEcS6Ym3vIqNJCpx6NWbvL/6Gu0No
	fIsAoE4bLB5B9IiImf7IW1bQoi1EgWb4V5miJzoqRbyhGj7hEbepYLTDJkWeFU4c
	1POo2gZtPOon3I3WJbj+Z7EEjYVXcKJggo756cvoeSpdDzrRq4y4Yc8RLNjHCDAx
	iPnwQtzv134BiyhI/lVjY5macUeGvN7NF+6y2S6NcIDgx1PR9yQVDYEIhnhgiDK8
	9wtx8s2GYLgb/TnmKiYPB/bABdFvHDKLqo3Bo2cL9mOeNYwSv2grCkeM+d4ceXaf
	v8aH0fBJzjAkeNBw5ZqEQ==
X-ME-Sender: <xms:MfmTZe7UKV7m538qO__Lm7XwAndWT5G-LtGxwlWJ44WOU4Dh8sluCg>
    <xme:MfmTZX6Ze6QrIdjKyS6fnlyomgJ5CkIwMJxUlmILAtdk-_Z5ASB2VpuACNCoO7b86
    FApk7-TmL4Se2onnuA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdegvddgfeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpefgkeeuleegieeghfduudeltdekfeffjeeuleehleefudettddtgfevueef
    feeigeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:MfmTZdfmD9ATIlfyfIcAW_jcKdW02ri-KA_kN6SMZS1FzxHK5DTHGg>
    <xmx:MfmTZbLfQWVswYQK9coBbIWg8kFzOqd6tIgcUKn2nqsmpT0ej6JCzw>
    <xmx:MfmTZSLvYRx3KdpusCsgMUdMvoensT-hj_0NoE37TV7DdDNdOegc7w>
    <xmx:MfmTZZX-2ua0PNgWbmJqGnWi3hXinemJtriwnXrbt0_bQBB0Uy71Bw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 9E622B6008D; Tue,  2 Jan 2024 06:53:21 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1364-ga51d5fd3b7-fm-20231219.001-ga51d5fd3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <165b800f-42bb-4578-8191-7fbddc7e106c@app.fastmail.com>
In-Reply-To: <cover.1703527372.git.u.kleine-koenig@pengutronix.de>
References: <cover.1703527372.git.u.kleine-koenig@pengutronix.de>
Date: Tue, 02 Jan 2024 12:52:59 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-kernel@vger.kernel.org,
 "Pengutronix Kernel Team" <kernel@pengutronix.de>, linux-pwm@vger.kernel.org,
 "Sebastien Bourdelin" <sebastien.bourdelin@gmail.com>
Subject: Re: [PATCH v2 0/2] bus: ts-nbus: Two improvements
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 25, 2023, at 19:12, Uwe Kleine-K=C3=B6nig wrote:
> Hello Arnd,
>
> the last changes for drivers/bus/ts-nbus.c went in via arm-soc. Would
> you pick up these two, too? Tell me if a PR would simplify things for
> you. I'd base it on top of fc540426f7baa0c7d4b477e80435d075659092a2
> then.
>
> Changes since (implicit) v1 of this series
> (https://lore.kernel.org/linux-kernel/cover.1702160838.git.u.kleine-ko=
enig@pengutronix.de):

Hi Uwe,

I can take these, but it's a little late for the 6.8 merge
window now. I've added Sebastien to Cc in case he as any
comments as the original author, I think you had a stale
email address from him in v1 and hopefully this one is still
active.

If there are no other comments, please send a pull request
or the two patches to soc@kernel.org after the merge window.

    Arnd

