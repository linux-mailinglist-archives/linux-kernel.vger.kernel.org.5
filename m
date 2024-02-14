Return-Path: <linux-kernel+bounces-65053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA6E854731
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 11:34:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CCC91F2A055
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 10:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73F4117C9E;
	Wed, 14 Feb 2024 10:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="RIpH9zGc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Av9KElcQ"
Received: from wfhigh6-smtp.messagingengine.com (wfhigh6-smtp.messagingengine.com [64.147.123.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE61EEAA;
	Wed, 14 Feb 2024 10:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707906823; cv=none; b=A/apolx+Jrt6JJvc1xhOLBvc59FfhHWh+PGsbPP7ld1AgrhjCPaHibF6+mhx+iYppf0pw+AMM9rYkYTHqlk8pWfCoovKfxQ9XN1Ed0UrOhHg16pjTMPKbvOgor7ypIRcSEYnumJDc1W+ATmPvmkjqPjP6p3IUbdQ2K55dXdG2Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707906823; c=relaxed/simple;
	bh=Wz3O9sY5Lb1tlJN6kKFsdarwvOyGVeowPGJkp2m04YQ=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=tsX8V4zPSYNqYKgzeFbw2r0aG61AxY/xtIvMFJ9rhSgiAdS6snNgS/wtHN2i1w7yu14pHtlBhvcguXW6isPKGfh3yHYiM7TO1URlHvn+2+4JopwdoJgPYCvh/2czf4UbzKIJPJUNhCpyM05LpIgNkxpAfSV3SXEtHTB4CuPnbwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=RIpH9zGc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Av9KElcQ; arc=none smtp.client-ip=64.147.123.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.west.internal (Postfix) with ESMTP id 08B241800073;
	Wed, 14 Feb 2024 05:33:40 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Wed, 14 Feb 2024 05:33:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1707906820; x=1707993220; bh=yVnERG6CD6
	OiUW+apDplUEb99Gqo14cVVGATiFwcNwo=; b=RIpH9zGcsVILCuAQGWXyxiScxo
	8cKd1tJi1zSHzJwPmGxcCvZIvO/u8HQMt/4qbbsyI9zu3zRSjOhXOGEIClnWVaY6
	zZqOGUvxrRUwpLFX1eura8piijcNb8Yo4bpvUcN2fdVlXNqRY2Nr1WMyMAHTxZSM
	DyVqBpJvN0VHVSt8wQnmlFwXo0zSsMw4avQyYOBqzap9rYzWS12Bmk9wVYjiCq0m
	ju5JOeohxo98GFU8XvUfmEbVzaMrzo4BS2YdVYIk1e4ighnOZUAwzuI663nFl4v0
	DfrAmmIrlDS909Q5th+aT5+6+zNjcYZS9BkrhDUsL5LC4r7r8pW3ro68H3fQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1707906820; x=1707993220; bh=yVnERG6CD6OiUW+apDplUEb99Gqo
	14cVVGATiFwcNwo=; b=Av9KElcQJZuy7b3CEZ5iA3c4wLLTz+scibfE7vgFX+uA
	RL2/rSNYtA5nYv908RnRVROG7PfUsc8CLp/vwaKMdKWGvcixvmHcWFNgS3wWPAKz
	cavJYYOGFIevXCwGnGY83Cc1rJ6PYQLP5ynyYHpbDWXG3rjhOH8NOGTyHLqJXv28
	DmhFUv1VwksCHRDBpSvznL806rIwUvnBgfKhQ7ZTGA0eRRZreVdDEeVnNiTv75Lh
	k0ysmnOWfUjL6JwmHcWxkR/q+Ny6HhMgUVzojvDXMhblgbTY/uNI3AQ5JBfY9wfR
	kCcBcTSaZBD2zho80BtujoS8OT0wQ0cR52JMbwrqIg==
X-ME-Sender: <xms:BJfMZWagc5TfNMixZJ8ld2hvLUYOEf-Ryoi0z255aiyDQxKtAqnbGw>
    <xme:BJfMZZYLVbGUxlwvXppk8FfBPQaUoAHukwkhbjKs-PNngxq_yycoz8oSelTflelIw
    kvIghsYNaedEoHdFG0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudejgdduiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeegteeihfejvdfhfeffhfdvvddvfffgtedvteeigfehhfehudffleejueduvdel
    gfenucffohhmrghinhepphgrshhtvggsihhnrdgtohhmnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:BJfMZQ8LR6OkvrdfHMUacfpaHXwuy-3IR1em-FnA3vTl6-v70brBfw>
    <xmx:BJfMZYqb5tEqN7XtQyQ5WwuCQMcHS5kEDnxTTh2yqkJ8bqJVBRJiqw>
    <xmx:BJfMZRr6adqIyNHGFA3X_aSaFAY9LZ8lTFLOabmR7LpxhJ97kU3eOg>
    <xmx:BJfMZaBWS7sInllRT7VElbQmtvwG2Tv6-FO8c2btfa2sw7kS-BlF8GpE6OU>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 3AFD7B6008D; Wed, 14 Feb 2024 05:33:40 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-144-ge5821d614e-fm-20240125.002-ge5821d61
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <eadeadd2-0913-4c46-8e90-8000eb45b7f8@app.fastmail.com>
In-Reply-To: <24cbf7b2-a091-440e-92cc-5c9828d52260@xs4all.nl>
References: <20240213095555.454392-1-arnd@kernel.org>
 <24cbf7b2-a091-440e-92cc-5c9828d52260@xs4all.nl>
Date: Wed, 14 Feb 2024 11:33:19 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Hans Verkuil" <hverkuil-cisco@xs4all.nl>,
 "Arnd Bergmann" <arnd@kernel.org>,
 "Sakari Ailus" <sakari.ailus@linux.intel.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 "Mauro Carvalho Chehab" <mchehab@kernel.org>
Subject: Re: [PATCH] media: v4l: marvell: select CONFIG_V4L2_ASYNC where needed
Content-Type: text/plain

On Wed, Feb 14, 2024, at 11:24, Hans Verkuil wrote:
> Arnd, Sakari,
>
> Is this something that needs to go to v6.8? Or just v6.9?
>
> Do we need a Fixes tag?
>

I'm not sure, I tried to find out what commit caused it
but could not figure it out short of doing a bisection.

I noticed the problem for the first time on linux-next
this week, but it is likely to have been hiding for a
long time. If anyone wants to bisect it, I've uploaded
my .config to [1], otherwise I'd suggest fixing it for
v6.8 without a backport or further analysis.

     Arnd

[1] https://pastebin.com/fcSLRBL8

