Return-Path: <linux-kernel+bounces-153087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C2CC8AC8D8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 11:25:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC1F2281DB3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 09:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 893C254FB8;
	Mon, 22 Apr 2024 09:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="KO4nUOlL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hM0X5/fq"
Received: from wfhigh3-smtp.messagingengine.com (wfhigh3-smtp.messagingengine.com [64.147.123.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D243537F1
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 09:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713777949; cv=none; b=QRdnhnAb/ePgUShNAAuyykZBRVEBrDIW8rYwsEzEd0KWp1EQoLJejdBGSH5CyuGV7XKsOjZnp2NRtF950Sx22TdlHbtP8fNEuNuRu2wLa3k+AGFRH0BImRkt9VzHWvuLIfTsXsYoBeuOYtrX3g7QZyqYSbNpwm7h6ZDFQU04xyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713777949; c=relaxed/simple;
	bh=X8BGpeU+eQ7X1ojjLda2lfTR6V29ngxLbpsjhMhmC9o=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=t2auwMUnoFfMxXQtwzYEXRQx+fsxeSv5oeF4/cTur27w7xPFKKR0QQtxcdmZi3TW3Cqc4Ej78pfPmmid70GtcuxaUy8+P4e4ru8QXOOIkAlRkDzzBj7/RvKlYlcF9JGuUxJx8qKHqNsKVDDNAT5mNFQzFQ0CnIg8RU8GxqV+pcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=KO4nUOlL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hM0X5/fq; arc=none smtp.client-ip=64.147.123.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.west.internal (Postfix) with ESMTP id AD0A31800128;
	Mon, 22 Apr 2024 05:25:46 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Mon, 22 Apr 2024 05:25:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1713777946; x=1713864346; bh=jcigpvahlt
	MO4FU7N5bgktFn4b0XcFmmk3Vf7CUJJaQ=; b=KO4nUOlL5KxvhoHb9dtP3FehDl
	A8Rb3uKH8Oqjt5sdrrrVOwqSLJ3wNfBPnPELNWWD/ltg3N8nbci849ComJyHs15r
	svo7bCtPiRJWi36+9TO7s3+x5b3KRtrOJvDIR1+rWqdBXUJ32gmaHE3jTYLKYleo
	ZOixi8R4JkhWckWaqa4lklEfH7dcG7QGNI3lfFlhxv10uK9c38LJKs6PW2HI0EFL
	PYsPYBns+EhaoCv7fEXQ6sB0KAT/A/QwiCelbt+EUiFm2pB+9Ip3xr7iyuBrN28q
	NT2/ucQ7v4QKDmAMLOdqGJuLedwwSP3e2hMX7eqPWxOXKBkgo5o7Hk/gdzCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1713777946; x=1713864346; bh=jcigpvahltMO4FU7N5bgktFn4b0X
	cFmmk3Vf7CUJJaQ=; b=hM0X5/fqaJ540RwsBjAI166UEJbFyHVAVEAK8q+0qt2p
	vl7WL7iayNoQnJs6DWfLAvORf9Y7mZDaKI1jiVuINnQENKEyYHsHA3pHtxSIHkFi
	b6wOQSy+34IGkdHc2luwkIOf+AceFA8ppiZ9r7WpEIolFKz6TnJnoaFl0AFeGgg8
	tLXxyw9XTbZYkDMVqMdWxg01D+1N5oG7Vr1arySxqg/NUM3TxCi89WXgnUh/03z/
	fECjjBhsJbHe7FQc8PDBZOFRJzxjucQvoJQZOgcEdydh19O68OwBOLsAo50QPhyt
	2mtd2c63jv1XlNyKAa/IHnwZznoheqTjPBU8fGwdSg==
X-ME-Sender: <xms:GS0mZvmKsCZ-0TsbQxkMbfG8eaW8KX1AsS5AeLE79MtkivC8HCYcew>
    <xme:GS0mZi3-iGkLBaMecUzZuZs_iaHaQUrADl55FpPZet0gwa440J0hvW9QgE3YhGw40
    6GtfH8kJr-Ke0riYbg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudekledgudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:GS0mZlr_jFIKImxfz3VOsLoe6780aghZ3FQUGb0jqjBt5MqGiKtdqw>
    <xmx:GS0mZnkBT4tJDxvmeWJ4k-26ATUVy5F7FcmHu7o3m-wEDnBhng8KcA>
    <xmx:GS0mZt0axtGYGNSuF9wd0Q2gBVrN2toPqmK2eAII81slgItjg8zIPw>
    <xmx:GS0mZmuaHjhRWrj8tW5ODSPLrRHC4AiPHiUemL2lUEKIFA35EzOZ6g>
    <xmx:Gi0mZnxy-yTh9Nz1Bq8KydxA0v2uoZFaQtmf7f5kcJbmexnPrHaTshew>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 7E460B6008D; Mon, 22 Apr 2024 05:25:45 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-379-gabd37849b7-fm-20240408.001-gabd37849
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <cd172d05-15f6-427c-b6e3-d68fc746b940@app.fastmail.com>
In-Reply-To: <ZiYqV-5BWmPwgqbU@FVFF77S0Q05N>
References: 
 <CA+G9fYsCL5j-9JzqNH5X03kikL=O+BaCQQ8Ao3ADQvxDuZvqcg@mail.gmail.com>
 <ZiYqV-5BWmPwgqbU@FVFF77S0Q05N>
Date: Mon, 22 Apr 2024 11:25:25 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Mark Rutland" <mark.rutland@arm.com>,
 "Naresh Kamboju" <naresh.kamboju@linaro.org>
Cc: "open list" <linux-kernel@vger.kernel.org>,
 "Linux ARM" <linux-arm-kernel@lists.infradead.org>,
 lkft-triage@lists.linaro.org,
 "Linux Regressions" <regressions@lists.linux.dev>,
 "Anders Roxell" <anders.roxell@linaro.org>, "Marc Zyngier" <maz@kernel.org>,
 joey.gouly@arm.com, "Oliver Upton" <oliver.upton@linux.dev>
Subject: Re: gcc-8: arm64/kvm/pauth.: Error: unknown architectural extension `pauth'
Content-Type: text/plain

On Mon, Apr 22, 2024, at 11:13, Mark Rutland wrote:
> On Mon, Apr 22, 2024 at 02:04:43PM +0530, Naresh Kamboju wrote:
> Given the minimum supported toolchain comes with an assembler that doesn't
> necessarily support ARMv8.3, I reckon we'll either have to make NV pauth
> support depend upon AS_HAS_ARMV8_3, or manually assemble the PACGA instruction.
>
> I suspect the latter is the better option.

The .config linked from the report shows

CONFIG_AS_VERSION=23101
CONFIG_ARM64_PTR_AUTH_KERNEL=y
CONFIG_AS_HAS_ARMV8_3=y

So it gets detected as supporting ARMv8.3. Is this the wrong
conditional to check, or does it get misdetected for an unsupported
assembler?

     Arnd

