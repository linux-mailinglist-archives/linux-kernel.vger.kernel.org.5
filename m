Return-Path: <linux-kernel+bounces-90934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E5F18706FB
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 17:26:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33D3A1F22F5B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 16:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D36384C62A;
	Mon,  4 Mar 2024 16:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="c78ABoY2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FFKDJGxM"
Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50201482E2
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 16:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709569607; cv=none; b=ncgsVRP/B32Qz8jF4nYy4nsjVXn4xCVlBJaDziLZ5BfZ3Wled1jrK1i7z2yDVE6KTxEuqKkt+paEz3OHC5ClmBATYUhIKoLk3D4e5HcQQzUPixGwJydKaMRQ4tOTcP35t5H4XyWq3TdFgsJzhS4tMmRcIA2f8aLOaxzyxwaL5B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709569607; c=relaxed/simple;
	bh=l5dQN4JbBVqAZev1YvAkAYxAUvuA4j4+RiBqcrU8OwI=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=AdS7k3Y7NiUkfYfseCRqTqMiv7y7gaFEnW24kr8hTinEwn+t9c26OgRLIjdtrFtrohxwq9hS43FSqHTyxSdhOGFA4Rtb2jNaUz3gPmvC/5EydYyduWf6WOkHgDAFb5w+DRFElFBrA2bOQwEalco0NLkuqNCeV2HbReHSkdJkSgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=c78ABoY2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FFKDJGxM; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 5DD2B11400AD;
	Mon,  4 Mar 2024 11:26:44 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Mon, 04 Mar 2024 11:26:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1709569604; x=1709656004; bh=SJo0UieZld
	f0HO8FjodcJafHBVBLs+ULn11Koofn42k=; b=c78ABoY2z7m3rPmuWJoTw5/MxF
	NT3nO+OHxXoB4f/g/o/8KB3buoiG5OhZyJPY1YYpM/Wd6QZr8IR8pdZ18LDwRt4+
	+NsQyQnwJ9G2I8Gvt/RkCXXTojHzafuNvlxjwnyiNqChTLQkj3/ZmghoRt6JAIzC
	APN3ugWgdbkb+Cr5xSgW4TgPXxczQGZrEvWOtIAa/FhAykl/tew8+81mqyoMGlM8
	ZrYNvEwHmCqCVE8rRAxpBlZEcKMKn4g9aRqr3enbunGmSGCSgVaGZ1rALcM82Ebm
	NsQzSYyK6ec2m3tyBUGMpFABLX2BI/zkajQZtdRkKAPUCMVanUwrR7gR9IJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709569604; x=1709656004; bh=SJo0UieZldf0HO8FjodcJafHBVBL
	s+ULn11Koofn42k=; b=FFKDJGxM0DAPeUNRC4zEwbPjOvGE8p/D7r20mCfmTff8
	awK1cul8qyXjNVHt9bpOFoU4usua7k2+PaHXvn4dUlFiUjZtHINT+yQOBsTBlr6i
	Gq6YxZEQ7hq61QdAy7/3A7VZv05v2sLZ+2/ls7WZ6ofTFFZ16eoMMuMmE8eQESlc
	c4TfPSFt4P2JMbmuANHhJaHsOllQl4IHwm7MInkt3cnJphpz8UwmgwUel3cg2yCp
	qwKJ3Exom40JcbVRW47Hv8T6BDWy7qXBDBiw2AaLFJz5br7uWsnqCAribZ8DlDg/
	AXe15OjPqzSnB/MPZlG3jZhXs0gXaF/G1FO3DOHV8Q==
X-ME-Sender: <xms:RPblZW83VcqtbCVJjxD5AyUYRAsSQQVUVq1Nz0Tz3cSOkKZvGxopyg>
    <xme:RPblZWtwYFpSoo0x8aLE_vsbLGeVgXqd4Js_cYMjwbGCHFk4feopMqM5iRGI8AdpM
    J8UtNjhg15gLMGIJ8E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrheejgdekiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpefhtdelhfettdetvdetvdeuueegvdeuleeuudevhfeuhfeugfdvtdevvedvfffh
    udenucffohhmrghinheplhhinhgrrhhordhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:RPblZcBXFISARMmyhfzu34p8oNzI4W88CFyf0PWr88a-l7Hm52xIqA>
    <xmx:RPblZedIYy2U1PjUZA5S1j74rUPrB7d9ivcU6R35bqs1Hr8PNiLrRA>
    <xmx:RPblZbNY_UnxzuwlJaeC5JsnbSVV5itefiKSmGMO1Rmf-zAMJbq2Cg>
    <xmx:RPblZQo7M9kHpPhPQp3L5CM5Br2H4hAxPT_o9TaFUrXvpCcdflgbBQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 15152B6008D; Mon,  4 Mar 2024 11:26:43 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-208-g3f1d79aedb-fm-20240301.002-g3f1d79ae
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <560b697d-4343-4e69-986d-6c3f4daa637c@app.fastmail.com>
In-Reply-To: <20240216142700.GA3863398@rayden>
References: <20240216142700.GA3863398@rayden>
Date: Mon, 04 Mar 2024 17:26:23 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Jens Wiklander" <jens.wiklander@linaro.org>, arm <arm@kernel.org>,
 soc@kernel.org
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
 op-tee@lists.trustedfirmware.org
Subject: Re: [GIT PULL] Make tee_bus_type const for v6.9
Content-Type: text/plain

On Fri, Feb 16, 2024, at 15:27, Jens Wiklander wrote:
> Hello arm-soc maitainers,
>
> Please pull this small patch making tee_bus_type const.
>
> Thanks,
> Jens
>
> The following changes since commit 41bccc98fb7931d63d03f326a746ac4d429c1dd3:
>
>   Linux 6.8-rc2 (2024-01-28 17:01:12 -0800)
>
> are available in the Git repository at:
>
>   https://git.linaro.org/people/jens.wiklander/linux-tee.git/ 
> tags/tee-bus-type-for-v6.9
>
> for you to fetch changes up to 1d044941d53855ca06e4fa34936ff7273c8641dd:
>
>   tee: make tee_bus_type const (2024-02-15 08:28:24 +0100)
>
> ----------------------------------------------------------------
> tee: make tee_bus_type const
>

My soc/drivers branch was based on -rc1, not -rc2, and
I did not want to do a backmerge of the rc2 contents into
it, so I ended up just cherry-picking this trivial change.

I hope that's ok.

     Arnd

