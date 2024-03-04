Return-Path: <linux-kernel+bounces-90980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B00078707F8
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 18:05:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 518551F21723
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 17:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1BEC60258;
	Mon,  4 Mar 2024 17:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="jKIXvk/q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QL3Ydt+C"
Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7137B5D46B;
	Mon,  4 Mar 2024 17:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709571938; cv=none; b=ex45MhTmhz7/sTzu+Gulgqv9LxKuNnS330sGjFX2lfDCJu86yeLQQOY2uSYvRMRrGFAKg0KoLBzj/5R/27QG6UtM07HtamJRYX6Kx073nqUrvskiwLFLhJ7o8HK5sTa8jxkdm8Mr/TMGYDxcf5wDXpWbLupRFnb8GNJiKsiK8Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709571938; c=relaxed/simple;
	bh=bAxF3+bDIcfrGGelILj1Qq9m8KuwIsrpvnjfbPcYWv4=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=GNUY0DybEdIafUmZWuuFromYYAqsKaGiy3lgovNXMoluX5nyr8H6G556HzqVjEZMm6BCN3nJBvloSZFy1ySXZ9D2S/X7GcRyqreGr8AHH/qnoSgB3Yn3X4hKi6BhPvPfoVC/sqEd3ZTsnMyzB1f8r5hwmc8y/oO4HPUulHNdLek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=jKIXvk/q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QL3Ydt+C; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 8548213800D4;
	Mon,  4 Mar 2024 12:05:35 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Mon, 04 Mar 2024 12:05:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1709571935; x=1709658335; bh=xj0q1W803R
	TENWNzmNaubc8SeyqQDOk+5c2s3TShtxQ=; b=jKIXvk/q5Bumjt8wHs5FDI0Ivi
	F+YZpm94Bg2PN/W3gwy0ODgD0nQ1puN5cG3BGyu2I90fAKEVe+d+DPiHCD9OQRIh
	TmtlfUxn6ZhnqLjB+xVe3Rw5Z8eQ5hKOcDzURPUBdnwYn2Rzq2rlJ40NwLhbg0Xq
	xTq9tFlpXWEH0irzqX8zvqeBaZMPr9K9ITHQYAz1d1ppI5KoTc0PKPtWeNfZWkjC
	gZjVrK8Ix50ZRgtZcU5MxxgbpB4+rd2z089+n/s1P/ye63KXn9+QzBtMeXVZhQ8S
	Z0ljLfyTBpViv9hjYmCZFrp6lI2VYqSzz3Yq1qQ3yuhWtPMO5YmMQcscLKww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709571935; x=1709658335; bh=xj0q1W803RTENWNzmNaubc8SeyqQ
	DOk+5c2s3TShtxQ=; b=QL3Ydt+CTYREz2EGuMAt1VeOUWZDxLytD+P84Q3LwUqt
	WtAK1o+9A4hAEaOMEhZwMEuPHAkuSJwH48DUi2oVbLMWIteRCBx6gwPT1NHwepKc
	Ph4REDtGFrORK1444QBcalG+nDLLwwkxGCuPsGfOxEHgVnaoySzc92mZXtHqgbRN
	8vhJu6xo3zYj8tE8arXqMdFcAtJA3EuEWDVgNfpr3lV1lPd5xpn3jY8QGMVfZVJd
	RGuJUXAB7d8xayUXpV1qIW1vq8kWIj9iCcnoiGbsgQMsdR21wT7Ghl5TxH3dF9RD
	fwrBC4Ai1UIuksTKO/DGLhJV46ltHUAhbCONTxWFYw==
X-ME-Sender: <xms:X__lZT3r7n892uvsXlUT-4Xfto46P8jMXI5UJPDFmuC3Ovh8fCVkxg>
    <xme:X__lZSETRSp37fZUlxswgaQJxJAFopPx9PP0uTEe_Tw0Rszmx7Sa8EhipXcHrey7t
    95D7Dgh6_nk9k7h56w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrheejgdelhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeevhfffledtgeehfeffhfdtgedvheejtdfgkeeuvefgudffteettdekkeeufeeh
    udenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:X__lZT4jZUaLo2T6DO6VC47R6hmyr-6zUHAXA98ecaTBsWNGTqwmYQ>
    <xmx:X__lZY0hxVzKuOw--XVUyCb1p4R2X06ijjnS-KKgL3Icd-OPog3sZQ>
    <xmx:X__lZWG7UwzHV1YBeQpMJq2E0Dj8N2GiaI0uD_6hhgTzN4pt7ZoZ3g>
    <xmx:X__lZZ2nDUO-3D04bb7mORJF3RQFBR1w1vEtvCdZ-3yTs81Ui0C7Hg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 3BFCEB6008D; Mon,  4 Mar 2024 12:05:35 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-208-g3f1d79aedb-fm-20240301.002-g3f1d79ae
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <f539dd73-96bd-41e7-8227-fbf1ffba068b@app.fastmail.com>
In-Reply-To: 
 <CAFA6WYOdyPG8xNCwchSzGW+KiaXZJ8LTYuKpyEbhV=tdYz=gUg@mail.gmail.com>
References: <20240301143731.3494455-1-sumit.garg@linaro.org>
 <CAFA6WYOdyPG8xNCwchSzGW+KiaXZJ8LTYuKpyEbhV=tdYz=gUg@mail.gmail.com>
Date: Mon, 04 Mar 2024 18:05:13 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Sumit Garg" <sumit.garg@linaro.org>,
 "Jens Wiklander" <jens.wiklander@linaro.org>
Cc: op-tee@lists.trustedfirmware.org,
 "Ilias Apalodimas" <ilias.apalodimas@linaro.org>,
 jerome.forissier@linaro.org, linux-kernel@vger.kernel.org,
 mikko.rapeli@linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH] tee: optee: Fix kernel panic caused by incorrect error handling
Content-Type: text/plain

On Mon, Mar 4, 2024, at 06:45, Sumit Garg wrote:
> + Arnd
>
> On Fri, 1 Mar 2024 at 20:07, Sumit Garg <sumit.garg@linaro.org> wrote:
>>
>> The error path while failing to register devices on the TEE bus has a
>> bug leading to kernel panic as follows:
>>
>> [   15.398930] Unable to handle kernel paging request at virtual address ffff07ed00626d7c
>> [   15.406913] Mem abort info:
>> [   15.409722]   ESR = 0x0000000096000005
>> [   15.413490]   EC = 0x25: DABT (current EL), IL = 32 bits
>> [   15.418814]   SET = 0, FnV = 0
>> [   15.421878]   EA = 0, S1PTW = 0
>> [   15.425031]   FSC = 0x05: level 1 translation fault
>> [   15.429922] Data abort info:
>> [   15.432813]   ISV = 0, ISS = 0x00000005, ISS2 = 0x00000000
>> [   15.438310]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
>> [   15.443372]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
>> [   15.448697] swapper pgtable: 4k pages, 48-bit VAs, pgdp=00000000d9e3e000
>> [   15.455413] [ffff07ed00626d7c] pgd=1800000bffdf9003, p4d=1800000bffdf9003, pud=0000000000000000
>> [   15.464146] Internal error: Oops: 0000000096000005 [#1] PREEMPT SMP
>>
>> Commit 7269cba53d90 ("tee: optee: Fix supplicant based device enumeration")
>> lead to the introduction of this bug. So fix it appropriately.
>>
>> Reported-by: Mikko Rapeli <mikko.rapeli@linaro.org>
>> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218542
>> Fixes: 7269cba53d90 ("tee: optee: Fix supplicant based device enumeration")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
>> ---
>>  drivers/tee/optee/device.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>
> Jens, Arnd,
>
> Is there any chance for this fix to make it into v6.8 release?

I merged the pull request into my arm/fixes branch now, will
send the branch on once it passes CI.

     Arnd

