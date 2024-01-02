Return-Path: <linux-kernel+bounces-14184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E96EF8218DF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 10:26:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97AB0283098
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 09:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88ABAD27F;
	Tue,  2 Jan 2024 09:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="JwsCzyxC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="74SXa/MK"
X-Original-To: linux-kernel@vger.kernel.org
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1518DD266
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 09:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id 1255F3200B30;
	Tue,  2 Jan 2024 04:26:00 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Tue, 02 Jan 2024 04:26:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1704187560; x=1704273960; bh=ViLgRlnLWu
	ci24k/dFf7bBBJBPAedmBrtbXTtjEH0X0=; b=JwsCzyxClajDiO4m4iB52Av3uy
	c8eXztBEeTLkyvpN5mryM79Cgv21cJ4caGeW764iSBQbAN5AiohpjxpJYuZ6wJsa
	M5NccVn+G/0zw6YxGjESsnNU6FXT0DCJR7go2wEkAEpDw8lBVLjTHqqkBib+0xoh
	Q2BPMeTV317b1Dh538zJUQYAs+NzfGMcYZqyI0ablbyXwqO6me7/IvX+jlrqr92b
	Dh75kAY0vse3JON7m+8FYTkUlyudcr2QOlnCl3BYp69BPGEhKkKXAvBdFyttXAiz
	csjhsf+dPtF8/5gE0dwvEBAkkGupdysgo3SoPFDTrSa+W7miekedIqUwAveA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1704187560; x=1704273960; bh=ViLgRlnLWuci24k/dFf7bBBJBPAe
	dmBrtbXTtjEH0X0=; b=74SXa/MKxNy9XDyRnCdFhN9np/nleql+t3mEgFrNJ5Hq
	9DSDiHpqtz8B0BUzizOFNqIUlUkfpH0+UfCu+Y7mHrMd0GQNIssPIrpYqdbtDoiT
	0hbvn/6zoedjcrhX6/nlOrDdabHSxYpzzSD3/1LXFJKfRkZ/HMzPbp5SZpVOFqar
	WGErKihLl38OYRZVDFZ14o7Yo3JaBxv1oZwFIV6xzLcME7AWKLKeqn6uEjbrld6o
	HRup/C/vPydL9U3emXvhWVUdUOBqmNKojQehCgKXVaj/d4OqaGqAU5udsmHjtQCt
	ZhXE/01KDErD7J3LnC4nFJv+0/vHscTluMipbKst5w==
X-ME-Sender: <xms:p9aTZXpz1cRa3DClnb0s6CSlNcG791SnoEHGE7ohvineH6x3SoLriw>
    <xme:p9aTZRrjDx2cbX66Ig4Thla9W9aQSAaseMxjuv5M6agyE2wr4m7yzQA1LmwugrGtE
    f9nPgzcNo-aX3JwD-c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdegvddgtddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:p9aTZUNmJYVmuPcnamhbzO-zlUkLAJ44WbP7HkAf-_qcswkYovLb4A>
    <xmx:p9aTZa4odO-EN-l2lrbvMfYx_ZW0dLbdkt_HbfATy6GlcdjNH8exYg>
    <xmx:p9aTZW5qrfHvEQrzol92uUAkbas2SPSqt8Tb-kitEYS9ojG6vlndlw>
    <xmx:qNaTZfHQvICUFvyS7W0Erii5bh4QFZYIxV1GSsTTkE5JNt-sS9JFNw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id C2FE9B6008D; Tue,  2 Jan 2024 04:25:59 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1364-ga51d5fd3b7-fm-20231219.001-ga51d5fd3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <eb2fa9be-8ef1-4ebf-a8c0-ede082bbe1a4@app.fastmail.com>
In-Reply-To: <aaeb97f1-075e-44b9-874d-f66763ef8866@linaro.org>
References: <20231218134532.50599-1-krzysztof.kozlowski@linaro.org>
 <24e92cfc-8dc8-47b8-b379-ed8b1b776fba@app.fastmail.com>
 <aaeb97f1-075e-44b9-874d-f66763ef8866@linaro.org>
Date: Tue, 02 Jan 2024 10:25:32 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 arm <arm@kernel.org>, soc@kernel.org, "Olof Johansson" <olof@lixom.net>
Cc: "Lennert Buytenhek" <kernel@wantstofly.org>,
 "Steve Sakoman" <sakoman@gmail.com>,
 "Mark F . Brown" <mark.brown314@gmail.com>,
 "Robert Jarzmik" <robert.jarzmik@free.fr>,
 "Florian Fainelli" <florian@openwrt.org>,
 "Simtec Linux Team" <linux@simtec.co.uk>
Subject: Re: [PATCH] ARM: MAINTAINERS: drop empty entries for removed boards
Content-Type: text/plain

On Mon, Dec 18, 2023, at 15:39, Krzysztof Kozlowski wrote:
> On 18/12/2023 15:21, Arnd Bergmann wrote:
>> On Mon, Dec 18, 2023, at 13:45, Krzysztof Kozlowski wrote:
>> 
>> drivers/mmc/host/pxamci.c and drivers/rtc/rtc-pxa.c
>> are still in use.
>
> MMCI does not have maintainer.
>
> For the RTC, I guess the intention of 57f63bc8fe79 ("rtc: update
> maintainership of pxa rtc driver") was to maintain the driver.
>
> The actual problem is that all of these entries (and R-321X below) come
> from the times people were not putting any file paths to MAINTAINERS.
> They stayed like this for 15-17 years, thus being effectively noop.
>
> Let's maybe wait till any of Cc-ed people respond and confirm they want
> to grow the maintainer entry to cover the files? If they don't come, I
> propose to remove them.

Nobody else replied now, so for the moment, I applied a partial
patch removing the EDB9315A, TS7250, TETON and CATS entries that
are for files that were removed or are in the process.

For the other ones, I would still prefer to just list the files.

   Arnd

