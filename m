Return-Path: <linux-kernel+bounces-23285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E7CF82AA71
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 10:05:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D51E286B69
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 09:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6600712E7B;
	Thu, 11 Jan 2024 09:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="Q2/5Zox5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="5ltSvgMB"
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662FE12E6C
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 09:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id 4A1EA3200A47;
	Thu, 11 Jan 2024 04:04:13 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Thu, 11 Jan 2024 04:04:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1704963852; x=1705050252; bh=JV6BAPap0a
	6BcTDa5ga4zov1Rd+qHqRGx5ynfNxxT5U=; b=Q2/5Zox5GMS8piVdb39d2NKQVB
	GUnNbkdXsmt9vrBI3E5vebOleTKe24E3WcaejRQeYKuH2oJlBkcg3ceqUxIfPXZb
	tYFlc2fFaRF9JUdxpeG1Y4ZRtRzgeDtR7raJ8DJVNmRcIgkSUBz8mcDNf/MW3fAu
	tJLYJcUEGqzOaqm/9ckIq8+/y8zBzOAjnIzxc4ld0Ewtof2vM0/hUkxNszHSRTq2
	QtpqQ6BHtrXkCDKMdU93xtKgyn2ExxsGQqkksMT7u0DkfnVgdO+XT0PqoTvf7qvV
	lCc75KdMU0B9MFFYzG2xbZmLyOW1v5U2GI95vndaVH5NRIqGXfcOU3sZuFYw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1704963852; x=1705050252; bh=JV6BAPap0a6BcTDa5ga4zov1Rd+q
	HqRGx5ynfNxxT5U=; b=5ltSvgMBj+3kuEKCsbyRebVqP2pZhI9CWyPuJGfAIPjL
	T6PUVgpz3Br89DG1+1RM+lG/TbFIx6ObOxcDLr6LGmkCHiTtPIoJsTxE8TKb27x2
	r0c7QUFK2gfJryBzEj6yf6as4xur2hs1QOc2oLH2bD2dz9wZu7ZLwyfglfTkNqnb
	10WjxQOQziSO1JfSvmv/M8WK80bIGNrUpePYf0Q69vSJa9/a2ipabnTjl2pwISsN
	k9tfE9ralIJixFh1eOK/OBd87ygJVHw3R3wIhkke0x04J6YPPqxrGXFVOT8Htj7h
	8lvGWpy23W/WqfA68JfjOE3y55dzjn5phGY6hlR74g==
X-ME-Sender: <xms:DK-fZQfDel0ekaZMsoiNx7qT6gcDsV1R5iB5Q1pUbo6NMSPuVAudPw>
    <xme:DK-fZSNw5zwI4gEmPetT2bZXUss8dxz4RH05aeQTq3X8L6OxHgdJGk9i_6PVRT7_S
    b2Gl79xg6D6GPom6IQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeivddguddvfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepofgfggfkjghffffhvfevufgtse
    httdertderredtnecuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgu
    segrrhhnuggsrdguvgeqnecuggftrfgrthhtvghrnhepffehueegteeihfegtefhjefgtd
    eugfegjeelheejueethfefgeeghfektdekteffnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:DK-fZRiJ7o5EXTCcRQbxr7FK9ek8oAc0ppuRUxMlEjDcRqlCr7nt3w>
    <xmx:DK-fZV9bv6H_lbw-uu2EDrsE7voTkinYmOtnGpzKCThoHiM-aE3kmw>
    <xmx:DK-fZcsFaaSS_6sLenRmUjsh5ZeZPdkE9rkB3GrHeeUmJMKXjy7-Ug>
    <xmx:DK-fZV5kTvoTfvNbgqjPemWKktsjs-9sYcItk4IU4nZkj7VYO5VINw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 8F3C4B6008D; Thu, 11 Jan 2024 04:04:12 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1374-gc37f3abe3d-fm-20240102.001-gc37f3abe
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <ed6820e1-d294-4e70-ba3e-459311e4a8b5@app.fastmail.com>
In-Reply-To: <f8e84ac04537b2c7d02c1515d2f94f7c66216a04.camel@gmx.de>
References: <f8e84ac04537b2c7d02c1515d2f94f7c66216a04.camel@gmx.de>
Date: Thu, 11 Jan 2024 10:03:42 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Mike Galbraith" <efault@gmx.de>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: fallout: 0fcb70851fbf ("Makefile.extrawarn: turn on missing-prototypes
 globally")
Content-Type: text/plain

On Thu, Jan 11, 2024, at 08:09, Mike Galbraith wrote:
> Greetings,
>
> FYI, $subject inspires moaning in kernel/bpf with attached config.

You may need to wait for 689b097a06ba ("compiler-gcc: Suppress
-Wmissing-prototypes warning for all supported GCC") to hit mainline,
or add the prototypes.

     Arnd

