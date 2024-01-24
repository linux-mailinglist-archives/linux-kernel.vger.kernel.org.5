Return-Path: <linux-kernel+bounces-36581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7974483A35B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 08:45:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 317CA1F2C488
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 07:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C92351798F;
	Wed, 24 Jan 2024 07:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="DBPiIArT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jJ6pI0rk"
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EFB718048;
	Wed, 24 Jan 2024 07:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706082165; cv=none; b=N8vuwide4Md7MAO+g4ZQooq4PIuTYHh7YqwocKneyHyJ6sHChu5b8a/AiY2JFWlp3C+n1R001cVd29/UyQQFTmJOS2SaFdGcHN4qH3k5sFsQc7u6yHNaFQP+1G4zSPycj4vvgFOkiqTXGfoM4wBCsXtY46BzZZhGRCY5feihl1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706082165; c=relaxed/simple;
	bh=PcCuuppOrBjs9Lnu8OSd/Gc4sHxxj/UW6vJ8UQVEhTQ=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=mqC2NpEUDF4OloFNufRglL9PzqbTbcH9oXVrVhf7MPInMqaTs59uWgpl7YPJB++5CKBSWAlISGVtaeF/YI/5/nKleTBEuNr4fXT5bqxm+ZEtszXDnVG5iR77f8wnrE2iWI4/VZL33/m5G4zZyo1JoRazmmO9NqVPg/T4YMBRe7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=DBPiIArT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jJ6pI0rk; arc=none smtp.client-ip=64.147.123.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id B9BA13200A1D;
	Wed, 24 Jan 2024 02:42:41 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Wed, 24 Jan 2024 02:42:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1706082161; x=1706168561; bh=9frl7d0quE
	YosV82pk2Zk+QUQPaeI3HmPSHPBAWKNGs=; b=DBPiIArTARxG2MxVBtRrgx40kc
	ncYUEzgK1ODbtQyBpiKwd3fV9hU+tl5pWsupqhmtmGiuexZ1cR0VoW21q4JIhemb
	frRU0OdTm4Qq7nL5GMD+Dc2hNHYYX/T6bz4D7BujmxtR0t0ck3ToDmGBgBIIKkVn
	8sTK3fj4Og6SOYRWTleIyXMxGtE0SWtgC9XZ5t21PBJfiOjC1QS0VfVYOpI9q1r2
	O+zO+Kcv01YwBwu2ZvV7yr615Jdd9y/tGbVqrGF3gqRKlH23n49h6z25ryddumfe
	oi2lxhdHczM22FNdP1Hu5Du5Oe5QmAY1P5PQda+dXXpfOI12yRjCJSSfitkg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706082161; x=1706168561; bh=9frl7d0quEYosV82pk2Zk+QUQPae
	I3HmPSHPBAWKNGs=; b=jJ6pI0rkgQHyAf0L009dR9D5tIhOUmJKJLWfbHbbhuMQ
	pAs+XGPQzPX+M26BphAlfwVpQ2IGQnwW9abzZek5u7ncHtLnZyIWHKX0qydQpaRN
	TyUu9Fd5TtqBqEh0Lz1OBl9yY2/d5roQ4ASq3UXLE6bxTMFd6b0goz4UDGGnmQfT
	KifZ9L6oPGjOJZl8cghv3JkuLT5+sMNQk5rO6Y5yl6xMGUJStGtRwsXkATV578M7
	w/aUa2RQmbMFvzdbHRE5hCQC3IsPzdNjEzDnXrovHG+mE9E018bLd94+F+05ekpP
	aLEf7a3ZNYltn7JM78HzWDYPpytDrLTm8C+YHPksZA==
X-ME-Sender: <xms:cL-wZWlaIMW5EkLFsg17wW6a8rt0eTWrTZgitprv9nfFv29nxHIuEw>
    <xme:cL-wZd3wwq4AQCXEi_tXelv54J4AhX22Wtxz3bZxS6kkUXz7kNe0ipPKAth1va74N
    JCuS0Wbzgtrb3LDTrM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeltddgjeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:cb-wZUp0gzaSaK7QckfzGVftAtM9AiXQvE0KSeSe7eoUSbKRhVlR1Q>
    <xmx:cb-wZalrjvXl9BtY9o5GQcerwcDPGPygbh84iUEJudoTX2Ni30hGVA>
    <xmx:cb-wZU1xbYxkvk2zw7gTUcskmweinhotYhmKMh7uZD1hAvDyi2ugjg>
    <xmx:cb-wZeor7VAQesBCt-0f72anrofWAunuKoIiIX4LrXwpXOqBfyTMsg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id E04F2B6008D; Wed, 24 Jan 2024 02:42:40 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-119-ga8b98d1bd8-fm-20240108.001-ga8b98d1b
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <4027ec4c-1e11-40fc-a9af-07732d7c3c1a@app.fastmail.com>
In-Reply-To: <20240124004028.16826-9-zfigura@codeweavers.com>
References: <20240124004028.16826-1-zfigura@codeweavers.com>
 <20240124004028.16826-9-zfigura@codeweavers.com>
Date: Wed, 24 Jan 2024 08:42:19 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Elizabeth Figura" <zfigura@codeweavers.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Cc: wine-devel@winehq.org,
 =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
 "Wolfram Sang" <wsa@kernel.org>, "Arkadiusz Hiler" <ahiler@codeweavers.com>,
 "Peter Zijlstra" <peterz@infradead.org>
Subject: Re: [RFC PATCH 8/9] ntsync: Introduce NTSYNC_IOC_PUT_MUTEX.
Content-Type: text/plain

On Wed, Jan 24, 2024, at 01:40, Elizabeth Figura wrote:
> @@ -738,6 +803,8 @@ static long ntsync_char_ioctl(struct file *file, 
> diff --git a/include/uapi/linux/ntsync.h b/include/uapi/linux/ntsync.h
> index 26d1b3d4847f..2e44e7e77776 100644
> --- a/include/uapi/linux/ntsync.h
> +++ b/include/uapi/linux/ntsync.h
> @@ -46,5 +46,7 @@ struct ntsync_wait_args {
>  					      struct ntsync_wait_args)
>  #define NTSYNC_IOC_CREATE_MUTEX		_IOWR(NTSYNC_IOC_BASE, 5, \
>  					      struct ntsync_mutex_args)
> +#define NTSYNC_IOC_PUT_MUTEX		_IOWR(NTSYNC_IOC_BASE, 6, \
> +					      struct ntsync_mutex_args)
> 

In your implementation, this argument is not written back to
user space, so I think this should be _IOW rather than than _IORW.

Again, no practical difference here.

     Arnd

