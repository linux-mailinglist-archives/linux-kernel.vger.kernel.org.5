Return-Path: <linux-kernel+bounces-49372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D8EC8469A2
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 08:35:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE8BC28CF7E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 07:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 214FB487A3;
	Fri,  2 Feb 2024 07:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="L6H3UcOH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Wkdrr8qr"
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2EC848793;
	Fri,  2 Feb 2024 07:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706859124; cv=none; b=LxDPVpxr6xNk/CFMLQCvtbeDkkb5/2NiWOqkCYIdKKEJxyjkXreOJmZSKj7W4XmDQJCHUvioP2XQ0sXxf8QlD+w0L2+Rp34YdT9hkLKgGCyPaBvMWJriNSDNWtWwTu5z+PdItDJuHuQ4z19Zuwo6Rkolji49gHS/XZFValY83qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706859124; c=relaxed/simple;
	bh=NZE/u8OaAthafIr0Nr/PabOdBPPSuMqlKle4j1t38X8=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=gHyc5X17Zj+V/n5vJ8s+T4ZoMwRJ/cfSlGF0P+RBYtFNdg7ueoD8vcIjna7IDePQwrhqAfXvmSWDgsMiGUE4eA7ZGnPBDjRanKP5sTay+6Q2KykaSIxqP+1pR0m1i+HnbfnbD54EY9v/0UFAkJt9h9EMhU44mOfLqRbOB/RVUrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=L6H3UcOH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Wkdrr8qr; arc=none smtp.client-ip=66.111.4.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id D7E515C00F9;
	Fri,  2 Feb 2024 02:32:01 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Fri, 02 Feb 2024 02:32:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1706859121;
	 x=1706945521; bh=SJmpIzuAKHZ+INEN1bWvQP5Z9QjNBtitHp12HPXsmf8=; b=
	L6H3UcOHuAzD09WjbF5gleHBgnhcHfT2dE2otv+gR/eSYjiusep8d50cSyxI1UUA
	5l1epKn5hwOUy+UGHare0DiL5m47DZBK/mQHUOuUBjTef/oDlX4hOSdlkl+Mop3U
	eRKWXYDweFHjvjbJoGdiOAAVNfu+lTMGUzRp4yciNy0S1LQPedDms9dvxZxPISlD
	OyPLG7iOZn77omSpuuGzdE8c86hYj5xWM9HbcNfxs9AlbDH8aV0Nme1KOoKdbcbW
	aEILE7zyAckjkLhQVQerErVcCBpAFoajyDMa2hMd5yYc5IzNCMCdvuxOS+IrxTc+
	Vk9nuSHweYjxSek3Ck4jPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1706859121; x=
	1706945521; bh=SJmpIzuAKHZ+INEN1bWvQP5Z9QjNBtitHp12HPXsmf8=; b=W
	kdrr8qrhJaZ4sA91YWIJHn8sqPVtj85B1yf3thqqr8ze5R/cEUDicpj97TlNQZyi
	wqX/E0vbjEzn/PX80Ao3G/GOh98Rxb/wLLuYY7YCORl2On/4S96Xgb5eSoAn4AH/
	oNEV7JJsYrSJ+f/M3X2wZe0yX0HAnuZ6MU9FZqeY1os9QaRCzFL2UDwzjRdd3+1Y
	RYFr+Curcd1t7R7UpxS1pEJ3cEncAhD1brExLv4R+I+pTJffTiuuBU7EYbImpb3K
	Re86eEF9+rRSNjQWIDlujLNAvrZNu/Ct3oCYckq5a1ITcCmfg2dgQSkjVhtHDTOM
	crOefo0GBp5vOSpLkUhzQ==
X-ME-Sender: <xms:cZq8ZePh2OSDV5s8TTI0HXYunLcEyP4RGjYizsfvTp6ZbPt9fvNV3g>
    <xme:cZq8Zc87hKrd8U1h7WKxmnYVU17kMhLkqSTlyz-XJdQsOx61mhRjsc7l2a-eQYZ5D
    WMJ-ui9Nd1IweCWiEc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedufedgvdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeegfeejhedvledvffeijeeijeeivddvhfeliedvleevheejleetgedukedt
    gfejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:cZq8ZVTJPQTHr6hbBCcF_BGfY0MCZouW46-_ClDHiDLmz_j-XTgUrg>
    <xmx:cZq8ZeucgweTG8hifq4-EXMTTcnic2H-972VTjDpvVN-pCotHiDQdg>
    <xmx:cZq8ZWe27CDq7gvqo0mBTD4S90mkg0JG61S_7MzchpRVtAS--J9ubQ>
    <xmx:cZq8ZXWwmQzF9uQ5E_bmudYlNnHxr9rKDcyfKAQGrMzxkgCwV3m53A>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 26C8FB60098; Fri,  2 Feb 2024 02:32:01 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-144-ge5821d614e-fm-20240125.002-ge5821d61
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <d656a2af-6b74-465d-90a6-b79ba6c25088@app.fastmail.com>
In-Reply-To: <871q9wz2r0.fsf@toke.dk>
References: <20240131-descriptors-wireless-v1-0-e1c7c5d68746@linaro.org>
 <20240131-descriptors-wireless-v1-1-e1c7c5d68746@linaro.org>
 <613ae419-9a2c-477e-8b19-8a29d42a3164@app.fastmail.com>
 <ZbuZ_55a-qqDqkeN@smile.fi.intel.com>
 <789b7ca0-80c5-449a-99eb-8c05b5380245@app.fastmail.com>
 <871q9wz2r0.fsf@toke.dk>
Date: Fri, 02 Feb 2024 08:31:38 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
 "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>
Cc: "Linus Walleij" <linus.walleij@linaro.org>,
 "Kalle Valo" <kvalo@kernel.org>, "Arend van Spriel" <aspriel@gmail.com>,
 "Franky Lin" <franky.lin@broadcom.com>,
 "Hante Meuleman" <hante.meuleman@broadcom.com>, "Lee Jones" <lee@kernel.org>,
 "Brian Norris" <briannorris@chromium.org>,
 "Srinivasan Raju" <srini.raju@purelifi.com>, linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org, brcm80211-dev-list.pdl@broadcom.com
Subject: Re: [PATCH 1/6] wifi: ath9k: Obtain system GPIOS from descriptors
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 1, 2024, at 15:18, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> "Arnd Bergmann" <arnd@arndb.de> writes:
>
>> We could probably go a little further in the cleanup and
>> throw out the gpiolib path entirely, instead relying
>> on the existing leds-gpio driver. Since there are currently
>> no upstream users of the gpiolib path, that would likely
>> lead to cleaner code but require more changes to any
>> out-of-tree users that rely on the platform_data to
>> pass the GPIOs today.
>
> There being exactly one such out of tree user (per your up-thread
> email) in OpenWrt? Or are you aware of others?

Actually, on a closer look not even that: the ath9k LED support
in openwrt is quite different from upstream, and it just uses
gpio-led there, with a gpio provider in the driver for the
internal gpios.

We can probably just remove the gpiolib consumer side from
ath9k entirely then: it's not needed for the PCI devices
at all, and the SoC devices no longer use it upstream or
in openwrt.

     Arnd

