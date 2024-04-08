Return-Path: <linux-kernel+bounces-135798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D892889CB71
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 20:05:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7827D1F27836
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 18:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEAEB1448C1;
	Mon,  8 Apr 2024 18:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="Xuzsq5sO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="a76WxLYW"
Received: from wfhigh7-smtp.messagingengine.com (wfhigh7-smtp.messagingengine.com [64.147.123.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1810E433A9;
	Mon,  8 Apr 2024 18:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712599537; cv=none; b=ftfUvZ+x8IXRGAXCvn6qfImCYv/gsq41dkwmCcnSwE3rsnZ0bqWP/3L9Ryf8tZQnQ6NQxdDc01ZMyQ6XeMho3iM1laWCeiDkJgF2RTN+35ku82QsfsKV7wo65gd9xqlBC3KkB3xhtzMBzG8iES7n8ZXzWxChnKyx4RtAa33IMdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712599537; c=relaxed/simple;
	bh=PLP2UVK/7a5fC42DAjpkpGkvVPaV+2lnuMzTDN603l8=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=pQ8jiHRh/1FMXS0jk+F3L6ND1oeGhOWrRzHHllkGWyIefYOCK/MwKalZAFBy1FOIH70EcL0R6p0NaAPzCYR/aVQ2w5GzQ2H1dKkKy/y2vBDy1ZF3FCXtg8d3d7+30/ruuR7Am3dp2Bq/oPTXfy6LhnC4bOFzJ/ThmcFHAHyR1dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=Xuzsq5sO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=a76WxLYW; arc=none smtp.client-ip=64.147.123.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.west.internal (Postfix) with ESMTP id 8E4F918000FB;
	Mon,  8 Apr 2024 14:05:34 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Mon, 08 Apr 2024 14:05:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712599534; x=1712685934; bh=PJwIR6tKpg
	7jOqh/bzOaK5yAmP9nnbueAasCvlzwCdQ=; b=Xuzsq5sOIPcE9Ql19RZOrsaRi4
	/9YvSlpm84mODIJZ+NSxNT4N8Cr0GyB3vdYVcwcKGL4MV1GdHaBk5o7kLKtRuNZG
	xQxEBGacZPI2ixvzqT92TLJOFu60Zp71xoathwjfaTJC0f6YknYmn2NPXQv9E4Gd
	AwO1j2fziebPrH9KGwETiwlDO0ERPj4mRi5gAjiUhgdk+kO9U3HqVdUiEY1G9qjq
	So8syYlgtuA28tUs9zL3X10G8llvL1mwVi7yq/QD4wHvLl9yv2NStJOCO19n31x/
	PMbdZo9gNhTv/jqhK8QXKbqdL+saOrPrxJXWTIOb1o1nY4yzReO2+uhjOE5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712599534; x=1712685934; bh=PJwIR6tKpg7jOqh/bzOaK5yAmP9n
	nbueAasCvlzwCdQ=; b=a76WxLYWJq80MbHVnbTM/cyBUYoWthFRsRk3zN0qwVka
	WnmY/s+DOwUUnHSUrFKo9cG8j/k5c+CrgQ8BDtkVac7fH2woxwffBT4muiXfsM9Q
	vtnZrt6da+4WqgLkcCPvL2jGNHyvk6bDnaYxAO5qoNMix3IJVAu/cRZS3zEinKoU
	joyetow+77DFZQKPnrCV7GGMrGjkqmn6yNLHk7Un8afjKkZkeRMLquZapdmHZnKc
	M85Hpbx04G/NOmdnDL30K7C8THbNLlusEkUVziS/vRNSw3A6DXq3Aj0A1Cx48czD
	azPyYZPpJqeHcb9104evNrvMJfObeTJu6e+Gu3+a7g==
X-ME-Sender: <xms:7TEUZpQqBp7cKqPJm9LG07QBmv6qh_e3gt6oAC8I3QCDwaxzxG6SYA>
    <xme:7TEUZiw1R7Nu10P4p5UiWT0iAaS7ex_Gsam9N6WxAXZbnxbhWnuoB0pb4tg7uMGMm
    l-BJSabdNbmfyieAn4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudegiedguddvtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:7TEUZu2DB3PrzMKXOirHLKim6odGpn5I2LYsdINFtRk1ZRWpPESceA>
    <xmx:7TEUZhCGGST4MWib6psuVfMAG3TyOVbemIfuux1XV0C-PtEc0js4cA>
    <xmx:7TEUZig5VADc9K14BlEo4K9NzbjcTGzBvaEJq3Wx2bx8m_RAsibYtg>
    <xmx:7TEUZlri_LABSW5F2bPs4wjI0Zq1CmQN3i5gxslBpLmmo0bzIpY_eg>
    <xmx:7jEUZmhi2J3D0s2bmKbWGbla_BytcPaxVLLfRf1DHRzImhNXxEicx95K>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 522B2B6008D; Mon,  8 Apr 2024 14:05:33 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-368-gc733b1d8df-fm-20240402.001-gc733b1d8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <3cd7ef89-0a41-427c-880f-faa48a9b7d62@app.fastmail.com>
In-Reply-To: <20240328101422.37e1c4f0@gandalf.local.home>
References: <20240328140512.4148825-1-arnd@kernel.org>
 <20240328140512.4148825-9-arnd@kernel.org>
 <20240328101422.37e1c4f0@gandalf.local.home>
Date: Mon, 08 Apr 2024 20:05:12 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Steven Rostedt" <rostedt@goodmis.org>, "Arnd Bergmann" <arnd@kernel.org>
Cc: linux-kernel@vger.kernel.org, "Jens Axboe" <axboe@kernel.dk>,
 "Masami Hiramatsu" <mhiramat@kernel.org>,
 "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>,
 linux-block@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 08/11] blktrace: convert strncpy() to strscpy_pad()
Content-Type: text/plain

On Thu, Mar 28, 2024, at 15:14, Steven Rostedt wrote:
> On Thu, 28 Mar 2024 15:04:52 +0100
>> 
>> diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
>> index d5d94510afd3..95a00160d465 100644
>> --- a/kernel/trace/blktrace.c
>> +++ b/kernel/trace/blktrace.c
>> @@ -524,8 +524,7 @@ static int do_blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
>>  	if (!buts->buf_size || !buts->buf_nr)
>>  		return -EINVAL;
>>  
>> -	strncpy(buts->name, name, BLKTRACE_BDEV_SIZE);
>> -	buts->name[BLKTRACE_BDEV_SIZE - 1] = '\0';
>> +	strscpy(buts->name, name, BLKTRACE_BDEV_SIZE);
>
> The commit message says "Using strscpy_pad()" but it doesn't do so in the
> patch.
>
> Rule 12 of debugging: "When the comment and the code do not match, they are
>                        probably both wrong"

Thanks for double-checking this, I had a hard time deciding which
one to use here and ended up with an obviously inconsistent version.

I've changed it now to strscpy_pad() for v2, which is the slightly
safer choice here. The non-padding version would still not leak
kernel data but would write back user-provided data after the
padding instead of always zeroing it.

    Arnd

