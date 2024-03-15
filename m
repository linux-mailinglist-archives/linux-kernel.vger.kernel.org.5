Return-Path: <linux-kernel+bounces-104926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E37287D5F4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 22:13:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C00121C20B85
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 21:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2CCB5478B;
	Fri, 15 Mar 2024 21:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="vAdRHLBF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QrmC1J83"
Received: from fhigh7-smtp.messagingengine.com (fhigh7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E179E38F91;
	Fri, 15 Mar 2024 21:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710537197; cv=none; b=oEgNU/H3ni5CZDyNcHUZEHnW9l5Ktw+cVROXoD18N8UKtZybLSD95JxG5aephM+aNyB7jmP/4BLjdF7BPDi1YOdy220zBypW6GuRGdgY2n8TI1IeicVjYHktNy5hmS7Ywg1e5zPOdtehu8REXqxSva2Ue/tMTQOFTXQA4fZ4Kbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710537197; c=relaxed/simple;
	bh=Qe14ES57LnDJMzNgiulgnbt3HkhIrulW+OUOvIcqjlo=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=QkPWbxedxYPcOZOfDBc+HigzI43MZ9FN+epSbMnTRZ1BfyYGGsF47GZFPYLsrF1rhFrxRCWZo0x/YNJIiZxNyWFjFxaC8nHDv56KFh4ZZ2L5YasR6neGZorbj9NUO6TxKnxzXv6PCOflrDmHjVLm8S25Y1xNd0JDfKdCaHWouEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=vAdRHLBF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QrmC1J83; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id B664511400BE;
	Fri, 15 Mar 2024 17:13:12 -0400 (EDT)
Received: from imap52 ([10.202.2.102])
  by compute3.internal (MEProxy); Fri, 15 Mar 2024 17:13:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1710537192; x=1710623592; bh=oRGEn3mS1/
	2ZP8orTOHuju7iTXXOg6ii/BcgsBUPnN8=; b=vAdRHLBFZEbpour7B+orQbBq+c
	zhXjMcxUE7Svlzr72JxjIVGuQdgw2+1nWeUU9ALiIM58oNpO3SlpADw6DUgMKtEM
	rhonNlpxlaZSEye1E9XqlMd6rGQN8xTuE6bWSrT1faXS0WoOrKXxFZmwHtwJcx/h
	GNesBO7KoytzIcxmEBW02mMruk0PMWTszYp35zlDfWjkSVZRQ73wUBQJAQah1Fji
	QVdZhRtKdfXzYdftwqrecWjNgLP2Y938/3zwqdu2Q8sqF+GDhdjX3Ngojb4j8lug
	vIbu1jq2xbpj1Pseh75IXDhe+cWbZJTn0uqREK1oa178CvWufw4yf8b0jEEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1710537192; x=1710623592; bh=oRGEn3mS1/2ZP8orTOHuju7iTXXO
	g6ii/BcgsBUPnN8=; b=QrmC1J83Grbsm1u2R276V/Ru+q8Dc1aC9NHkSzH3GFx1
	3nkoil/fP2jEhmXHSgLlA5nkYcCrKYe2KQD5uH9QjQVjgOPawPJ+7rvUFbXD0lCK
	L2SLAQww8pvXF9xtEf7nenLep33A3QZw8iGbxYTACgEwEqOOPsB7Z/Zrljse2t9+
	jkNhzI3G7Md7TQgJHgydbpqrBI0fJEU3O7eRk2zT+bVFzS12H1JPVvbqmUEB1KsY
	Nfl2FAapVx2ZCMMCteayZQKYYgwGvHiIdeJ0XOo/YhSSTQMGGK+8ES92u0UXxDQp
	15/hVnaN2f8ShYFMZa/ikfs5YV4y6x6U7eTLj+JWjA==
X-ME-Sender: <xms:57n0ZbWNg5dNsT58tJEuzh-4MWUVLW8d28E7gla6yVdoRyBfn0SmjA>
    <xme:57n0ZTkQJpWToQUlkTMfNKnGKooiMqAMz0hpwqq0RC8jioizlHAlqEolu2zpd4tpe
    3Qbq_JRfbQTeEdm0Kc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrjeelgddugeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedfofgr
    rhhkucfrvggrrhhsohhnfdcuoehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssg
    drtggrqeenucggtffrrghtthgvrhhnpeeiueefjeeiveetuddvkeetfeeltdevffevudeh
    ffefjedufedvieejgedugeekhfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdrtggr
X-ME-Proxy: <xmx:57n0ZXZ2tA3xjGm64dr5fl8n-DRAbb_UetAMp-R2iZwNPWF4ZupKWw>
    <xmx:57n0ZWXg78WoYuHz4qb9FonKNuRf9QPl9qVqmNOMBkoTHIFM1GQF_g>
    <xmx:57n0ZVkNHXpIlsfC8N6-RC0uExagNBzTaij--qEhRBefCZbYd1m8mA>
    <xmx:57n0ZTdBTxVDwvhfEgLMWlD0iyMf4NnG897ropIc4htg_qqast97qQ>
    <xmx:6Ln0ZYt06_DwUFEk_pLveVxgn9bpBFpVWizc0DBQ6jNoTZ_6VH11Lw>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 745B9C60098; Fri, 15 Mar 2024 17:13:11 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-300-gdee1775a43-fm-20240315.001-gdee1775a
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <d8529238-8e3e-4d70-a1d4-40dc134f3d97@app.fastmail.com>
In-Reply-To: <75b89923-f78b-4661-bc6a-fee6c15367da@roeck-us.net>
References: <mpearson-lenovo@squebb.ca>
 <20240315195227.91282-1-mpearson-lenovo@squebb.ca>
 <75b89923-f78b-4661-bc6a-fee6c15367da@roeck-us.net>
Date: Fri, 15 Mar 2024 17:12:51 -0400
From: "Mark Pearson" <mpearson-lenovo@squebb.ca>
To: "Guenter Roeck" <linux@roeck-us.net>
Cc: wim@linux-watchdog.org, linux-watchdog@vger.kernel.org,
 linux-kernel@vger.kernel.org, "David Ober" <dober@lenovo.com>
Subject: Re: [PATCH] watchdog: lenovo_se10_wdt: Watchdog driver for Lenovo SE10
 platform
Content-Type: text/plain

On Fri, Mar 15, 2024, at 4:05 PM, Guenter Roeck wrote:
> On 3/15/24 12:52, Mark Pearson wrote:
>> Watchdog driver implementation for Lenovo SE10 platform.
>> 
>> Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>
>> Signed-off-by: David Ober <dober@lenovo.com>
>
> I don't like the "Found Lenovo SE10" noise in the probe function,
> but that isn't worth arguing about.
>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
>
If I get any other feedback, and need to do a v2, I will remove that.

Many thanks for the review.

Mark

