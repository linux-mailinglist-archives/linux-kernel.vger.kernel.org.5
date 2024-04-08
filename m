Return-Path: <linux-kernel+bounces-135816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DA6789CBB7
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 20:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C5841C21D17
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 18:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E1A01DA3A;
	Mon,  8 Apr 2024 18:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="mfK9enkX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uP7v9bHu"
Received: from wfhigh7-smtp.messagingengine.com (wfhigh7-smtp.messagingengine.com [64.147.123.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38AB9847B
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 18:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712601029; cv=none; b=YF+0wpseO5QCREiJdoCfhlri2LHsU8mZxcB5Ok/IPNUrxky1yfxLcJhLAipeKtkQhhivEZt0GyCjVc+aVvpPM8OQgGaKVr4hdNEy4JWWe0cwZ1y9tXnLCECsMg6d+xQBzJiypOZtRBbS05pY/OHE6P+5+TmmpXD5fsAo5hQHe88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712601029; c=relaxed/simple;
	bh=eAuPjPnMl8lqtdSr5YO+FTr8OdGjykhUZ07H1EI9oIY=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=UDD8PevcSBFG2Za3HEOAllgfMnTZ7xDh8SCEMCBCyUpMPXdD7STzjsRhnPNiA4+jF8Sf1cOTtV+LnEfq2ISI12QidwNvyML291TuE1JRzbr7FTe5ggwzsqDaw74zsGx1K2m0w0TVXGJLt8K2BaTIe8pQFaUReHObuaO3Zf+wvyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=mfK9enkX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uP7v9bHu; arc=none smtp.client-ip=64.147.123.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.west.internal (Postfix) with ESMTP id B2A7618000FF;
	Mon,  8 Apr 2024 14:30:26 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Mon, 08 Apr 2024 14:30:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712601026; x=1712687426; bh=fXxNckLzjc
	Pn37VK3Vmo5LPJa5sdva5WveaKb5nJYi4=; b=mfK9enkX8ouYxGvYuixu29BvEM
	CzmKtHLrOt/V4LeNwWdzfOB9Rmfc7Wqk93Z8/2tSMELejs5r0snTS/X75oQ0Ud2H
	/dYLUc/DS6FOfusFu8w4OF9CkK2Zzq2PrjIPWtolpy6A0BTeUaxVU30O44K4Y/H/
	whQSjk9pl4hu4jFPwB0Dm5nMVAlYsIEa06FOWY8+BsrVTW5iASRmriT/kYdMb77y
	UnY6wvn+14z115rJpwsF4fnnNtP3doqutRa8zsF7rCBxHl6fLIHjAXse2N6/tbH5
	PHlpq9LygPKmnN2+OSXIANln175e/SKwjV3+Dai4yrzVGf8bib9J1N224WCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712601026; x=1712687426; bh=fXxNckLzjcPn37VK3Vmo5LPJa5sd
	va5WveaKb5nJYi4=; b=uP7v9bHuYcP2iHfTVcQJB5gsUqdkT+IlQ3lgMGme0qx2
	in1ueb+a2lMy0zo5rW8mD4JYrNLPpg1R1xI284Tk/48DSxxvgyg52c8BGOt4sal4
	NeyUZeY5X+EBf8VoltXknMmwt0eiues1qBmAeTZnKe0hKXimkZdMZpEQNLXdAUvX
	hZMMXLFlVkI6UNeSRk2QG+PbdASQsGhzyyJtZ/R5kQtYI4GvNI2uMyeDjtkjiaqw
	IOqkNV6gTM9Q/7zLdZGLohbnK4V3sZ72LFZ25jzNVMk/GEGMk8cbwqT1ETJeMeH/
	akuyA98qvVoNoWkbw5Pv5eHS+rp91nmOvKeIzUHF4w==
X-ME-Sender: <xms:wTcUZu-k6fUSFYc5bGHuQmD0i3256fZX9KPtaXXhGbCtwkkZZNe9AQ>
    <xme:wTcUZusP9DTAWST8MwFZJgNC8owUlHWL_07d788p9SC_fmHYls8W-4ngpFZewJ6aW
    SEEmkPgyurz-pzLXBQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudegiedguddvhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeejvddvvdduleduheejiedtheehiedvjefgleelffeigfevhffhueduhfeg
    feefheenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:wjcUZkBBPED_4TdOGA4Xc_0MpiGJwcebpVvddp6bHW7xswGBF0NUuA>
    <xmx:wjcUZme0KmgXY3DkOn1xjetkuWVwNnIbvFkTWRXOBG6mF1EWJhQBQQ>
    <xmx:wjcUZjMee5XpAU6bSgVIwPJ3yhyOSdcbeJp1Q3yLEQCy5nomRtdF2Q>
    <xmx:wjcUZglKeNQ4KZgVXZhfRNS8q3la1wjdLq-Nb_4CqkTHcIcEbsixUQ>
    <xmx:wjcUZuq8AUQF22q65uxq1oxTtRub2cbJ1BXaS2-GLDtqqTFn87G2_HXh>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id D3982B60089; Mon,  8 Apr 2024 14:30:25 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-368-gc733b1d8df-fm-20240402.001-gc733b1d8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <72780460-f0cf-4ad1-bf88-f49cb37f0de8@app.fastmail.com>
In-Reply-To: 
 <uejqjxh3ntjdyziy3avisav7ghhb3s66iccfwchjkm534zy3ja@3kxet4bu2ck3>
References: <20240328140512.4148825-1-arnd@kernel.org>
 <20240328140512.4148825-11-arnd@kernel.org>
 <uejqjxh3ntjdyziy3avisav7ghhb3s66iccfwchjkm534zy3ja@3kxet4bu2ck3>
Date: Mon, 08 Apr 2024 20:30:05 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Justin Stitt" <justinstitt@google.com>, "Arnd Bergmann" <arnd@kernel.org>
Cc: linux-kernel@vger.kernel.org, "Viresh Kumar" <vireshk@kernel.org>,
 "Johan Hovold" <johan@kernel.org>, "Alex Elder" <elder@kernel.org>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Christophe JAILLET" <christophe.jaillet@wanadoo.fr>,
 greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH 10/11] staging: greybus: change strncpy() to strscpy()
Content-Type: text/plain

On Fri, Mar 29, 2024, at 00:28, Justin Stitt wrote:
> On Thu, Mar 28, 2024 at 03:04:54PM +0100, Arnd Bergmann wrote:
>>
>>
> Arnd, I see 4 instances of strncpy() in this file. Could you clean them
> all up at once which would help GREATLY towards:
> https://github.com/KSPP/linux/issues/90

Right, I see they all operate on the same string, so it makes
sense to keep these changes together. As Dan suggested, I'm using
the padding variant for all of these here, even though I'm not
entirely sure if this is required.

     Arnd

