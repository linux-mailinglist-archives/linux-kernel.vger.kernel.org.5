Return-Path: <linux-kernel+bounces-95055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 896448748AE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 08:29:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB4EE1C21A08
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 07:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4965662A1D;
	Thu,  7 Mar 2024 07:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="1StaH82k";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ljVgD5ij"
Received: from wfhigh4-smtp.messagingengine.com (wfhigh4-smtp.messagingengine.com [64.147.123.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C8538DEF
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 07:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709796570; cv=none; b=Af2Tk+P9PbXHPyhg4rNW2BBSQU147vjMV6fIFaIpr1iLIPAW4k9b2nALD/xLdOyK3JmN01hkiJv2m6lNxNJ6gRXAXxeesrCx1I5tXs1h+PHIyQ/g4hmPLx1zhqrnzwH5k9MgxC2rg5GNWtVIBPOyPB119CR43AKDCQ20PUksONA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709796570; c=relaxed/simple;
	bh=dfJlQLT8+ltJfZIFM600pmdukikNttPcV9jp5u/c9Z0=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=qPgQZNVbCvw2xZNAOB/9ZWz9R0xcwlPuOD+Pt3G74RBpiG/uGPQZ+VzmJawubYzqPSBdLouxNnL8LClHB5ipZgS5LFhJFU26d4yZtvcItrHHUtN/ugM4uKC3EuQteMHj0g+W0aIAvydrjYrLcFJFsvkuXy4QwS7w0SRK8MTqij0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=1StaH82k; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ljVgD5ij; arc=none smtp.client-ip=64.147.123.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.west.internal (Postfix) with ESMTP id 160461800089;
	Thu,  7 Mar 2024 02:29:26 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Thu, 07 Mar 2024 02:29:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1709796565; x=1709882965; bh=3O89/o2X9G
	0HSspETym6AApVeP6naElvegz/4zl4DdE=; b=1StaH82kOU+/ZC0LeiWE6rLYDs
	I5B34u3TXsfDcZFV3Rdpv7CFLWqnIm/AeUq+1/EglPX5JO0TARprMsDTF6f+JxZU
	Lv6/K/PYzWwp/qMXaedomRA5+j5LCkC5e1pZQjfrohUoMGE/84EnRUqcjKqNCuKP
	RdoCY/vKrnbjrl9y2CRd1YD3o7xxqpKv8A4RA79bxzP5m9bgFZp9JkRBCkRsEjYx
	IIHWjN2PF6M0kdQqOGo8parR2y73UJgOYoclxRJyl9+NO93LlTGLEFzC+S3a6+bt
	+jFXiIcwVrKT5bF9lWd+VYkGI6SkW+E4fyFMQr6QyUjoJZgIiyehP6Q4sfZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709796565; x=1709882965; bh=3O89/o2X9G0HSspETym6AApVeP6n
	aElvegz/4zl4DdE=; b=ljVgD5ij9MY+EUJF47cE0EYATblOkVXtZ4bGS0+SE2T/
	8whL3HyCFc0wRj0MVzAR/W2fmbCFTkI6h8HHKvWOhca+gbeEgiri1IuPfCgOwAJ7
	nx7STDjTs+7cJ2URJ47jvQiG2k26cBmw7hunHTJWne5rH20tLPKK6XwOSPmbh9lT
	OmJiNsYEjmphdSV9ZegmScQTnBMm+WnoQiJFbu7w32XBpHfhOClCBBtTpE1Nc2zg
	ZCNaX0K80ig+xqf2BN5erGPa6DKs44533WYBCa5IPCRy9SSdpK6a7s8KaftOKjQB
	/033o09v9xUkfUQzfQ+Lu/DsqBx3KxBWx2K3XfcZVQ==
X-ME-Sender: <xms:1WzpZdlF9ISbvb0FfxWXLA-T5N4xbLhTgu5dABWfSWH1BzmRQOFG5Q>
    <xme:1WzpZY3PxOwY3TmDULz1ogk3wufTfzfVhqH5GTdWma50Bcjfdd18ZmlXFyt1Ru1ew
    Dv7KJrDwpxvL3zJvpI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledriedvgddutdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:1WzpZTploTU-sC0iT7i01GRsxyF0xcPEROf4fq3Zj5FeQnubO-_hlA>
    <xmx:1WzpZdmhBbmer6I1aUFKwHRR4bqWqdPmuSWQeGPcDXOmSLhK4LLyTw>
    <xmx:1WzpZb2jHnWBncweZGkqE9zjDge2QWjqQFSHDc05exFVIhZWmFtWvw>
    <xmx:1WzpZZP-oXmbl3S5o7ncNxsNa-Cc1Egn2NcI6xdE7P8Rsgxo9t1W1Tva6jc>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id E662AB6008D; Thu,  7 Mar 2024 02:29:24 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-251-g8332da0bf6-fm-20240305.001-g8332da0b
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <76cf345f-2a7f-49cb-a31b-f9db1f23a615@app.fastmail.com>
In-Reply-To: <0255a8e9-d973-497c-9011-5651e0002a9c@huawei.com>
References: <20240220081527.23408-1-liuyuntao12@huawei.com>
 <1342759e-b967-4ec4-98d5-48146f81f695@app.fastmail.com>
 <38c09a4b-69cc-4dc5-8a68-e5f5597613ac@huawei.com>
 <30b01c65-12f2-4ee0-81d5-c7a2da2c36b4@app.fastmail.com>
 <4e9396ca-460b-49ca-818e-73f0a8997b15@huawei.com>
 <58297ee9-4f33-4b3b-bd00-b44e86965892@app.fastmail.com>
 <2397d8dd-8053-4167-9aac-f5d7c05a98da@huawei.com>
 <0255a8e9-d973-497c-9011-5651e0002a9c@huawei.com>
Date: Thu, 07 Mar 2024 08:29:04 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Yuntao Liu" <liuyuntao12@huawei.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: "Russell King" <linux@armlinux.org.uk>, "Andrew Davis" <afd@ti.com>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 "Geert Uytterhoeven" <geert+renesas@glider.be>,
 "Jonathan Corbet" <corbet@lwn.net>, "Mike Rapoport" <rppt@kernel.org>,
 "Rob Herring" <robh@kernel.org>, "Thomas Gleixner" <tglx@linutronix.de>,
 "Linus Walleij" <linus.walleij@linaro.org>
Subject: Re: [PATCH -next] arm32: enable HAVE_LD_DEAD_CODE_DATA_ELIMINATION
Content-Type: text/plain

On Thu, Mar 7, 2024, at 04:09, liuyuntao (F) wrote:
> On 2024/2/27 16:06, liuyuntao (F) wrote:
>> 
>> 
>> On 2024/2/23 0:04, Arnd Bergmann wrote:
>>> On Thu, Feb 22, 2024, at 12:24, liuyuntao (F) wrote:
>>>>
>>>> The position of the caret has been moved below the right brace
>>>> of { KEEP(*(.vectors.bhb.loop8)) }, indicating that lld is treating
>>>> the entire `KEEP(*(.vectors))` as a file name. This could potentially be
>>>> a bug in lld. Perhaps we can temporarily
>>>> enable the DCE option only when option LD_IS_LLD is disabled,
>>>> like risc-v:
>>>>
>>>> `select HAVE_LD_DEAD_CODE_DATA_ELIMINATION if !LD_IS_LLD`.
>>>
>>> I would really like to see this working with lld if at all
>>> possible, as it allows the combination of gc-sections with
>>> lto and CONFIG_TRIM_UNUSED_KSYMS.
>> 
> Another way to preserve .vector sections without using KEEP annotation.
> It boots well. How do you feel about this approach? and, could I submit 
> a v2 patch?

Yes, if that works, please submit it as v2, we'll see if anyone
has concerns about the new version then.

     Arnd

