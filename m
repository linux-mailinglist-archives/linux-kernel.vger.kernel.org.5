Return-Path: <linux-kernel+bounces-49740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7B40846ED2
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 12:20:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 731531F28F85
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 11:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93B4913D50A;
	Fri,  2 Feb 2024 11:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="m6GsUc01";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ajEqIUc3"
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D47513D505
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 11:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706872843; cv=none; b=T+SyD7y31LQnz37Fch+ISnwzKYgL5lY7CMkKb2MwxxKo78mZ1ELtbo/aVs+8DyDfpQ/7/5Vo4C1k8APgzMzZ/RKKWtub9enbVvbewNnGMZPLqzEOqXi0NPq4mmemHwAu3s40jJ8qXEWeEK6EmCOyllGP5sDosQwlYaOTX2cdQl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706872843; c=relaxed/simple;
	bh=ZRlR5bK4g1KoBRuVLx8hi2H5DNjuSx/IKHzhpfVu0ZI=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=Wap1WhxNnZKlTannACdOSimUmDJQoG2xqYDBrDasfPxwYqjyAW5WsVmqN1tiHlOivm/pR76fOxmZ/phAkX3LijkpIylXvB22GKJj5x5zUeQ0RV01QuoUzqIJheGlflVPqZLz9RflD/iSGb+v83l6AcxfGFCytz+teqvo6RZ+uZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=m6GsUc01; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ajEqIUc3; arc=none smtp.client-ip=66.111.4.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 21E555C012E;
	Fri,  2 Feb 2024 06:20:40 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Fri, 02 Feb 2024 06:20:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1706872840;
	 x=1706959240; bh=pp95Alah+MaXEWfGhGkN/3RO+Gp93mL6PvidT9UVU+8=; b=
	m6GsUc01cCOikIG1qWo/D1HZ88MAECXHJb/Tc8RvS6pTM/JeW4YAqvaQcIkjG2nF
	GTidOWWcanjQESfKC1uK20OWByiCPuhWo64uSKZSd1nnAPmwFNCZKv1uUbzgchvC
	kl8ygko70U2ji5Z577BHEagXSUg3iMToeQanbqiksSwpHiX8Pamu3uopqZqm+/jX
	gpDKQX0XSZQAFglHyt53Kk3JKj9KSg9ovOBqFPQOeFHe0QA/Y0E46HiF0f7Yu0IP
	jbGozR0/wFeoy4i2wSz/h8cJSYOoVHS90CJqWICqlAQIaTXEs6+6DwDyjQiMO/4H
	pN4Y4F4ZrHdUb//9D5kLTg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1706872840; x=
	1706959240; bh=pp95Alah+MaXEWfGhGkN/3RO+Gp93mL6PvidT9UVU+8=; b=a
	jEqIUc3JtiXd7PLK0ZHIUpsi8vPTWWKcyQlUF8jLjQlj/C6N7UH5r1djOxAVMHlw
	dTh2WLzZQMYq/CnrR2ysHLEF17XoFsylJljKDBIXcyR+SFsgxbwCRIUMKe43fD74
	e9MTZnNiv+NzvbIegoAzSSkKPmQBHi3FVzp7dLQmDvyJN0JatUV4+yw/E+6fdPjM
	01+96GcEA194C+G3f0jHV4sGOfU5AUvNtLZBZnctcecZ/d20SrnHR4A7YgbxH2yz
	+HUYPJZlIi3GUOpUj/7mnW7mGH/pWLuXFDj5zhY3IKyDPbnFc3l+cTzWpkJfNj03
	uyYdUFrY6mzxUK6G3QSfw==
X-ME-Sender: <xms:B9C8ZfKSUGv55RP7tEPFqJqwLTyaoUDCk308GAmNknC47HkX3oS2rw>
    <xme:B9C8ZTIZYrDQcV6JKQuzuChdMwmhG5YsuyS0yUWqv6WXmLkvVTCQFNgfjlddz2jo8
    EXRsOdtfOKn7KBEmlw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedugedgvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeegfeejhedvledvffeijeeijeeivddvhfeliedvleevheejleetgedukedt
    gfejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:B9C8ZXv-38leow7NGlaV9d8uGW2A3ByBKlY7gF4a6pfWq-bzGeaZ5g>
    <xmx:B9C8ZYZISbuQIA8dyii_cuoMVJNl0mWxO-99h6AEd0WYhly61VzLGQ>
    <xmx:B9C8ZWYJKOGhWX-wCezeDUuWbbtqBgWCpnLm_ExCtAgNpkwn_zRDxA>
    <xmx:CNC8ZepP6dBu09wHOoKw4KyNQq0M8OuYTbPM0BOZJabqZGTActG0zA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 8E525B6008D; Fri,  2 Feb 2024 06:20:39 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-144-ge5821d614e-fm-20240125.002-ge5821d61
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <ebab6070-5f3c-4706-9fe8-11f530bb1054@app.fastmail.com>
In-Reply-To: 
 <CAMuHMdVk0YOUFKy-ZjMHWCGkNMeBGU5Zs6VxtNH38emBnAR9xA@mail.gmail.com>
References: 
 <CGME20240202095104eucas1p2df4522cc4a7ee29540db1fb61d8e19fc@eucas1p2.samsung.com>
 <20240202095044.1980696-1-m.szyprowski@samsung.com>
 <CAMuHMdVk0YOUFKy-ZjMHWCGkNMeBGU5Zs6VxtNH38emBnAR9xA@mail.gmail.com>
Date: Fri, 02 Feb 2024 11:20:19 +0000
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Geert Uytterhoeven" <geert@linux-m68k.org>,
 "Marek Szyprowski" <m.szyprowski@samsung.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, "Russell King" <linux@armlinux.org.uk>,
 "Geert Uytterhoeven" <geert+renesas@glider.be>,
 "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>,
 "Alexandre Torgue" <alexandre.torgue@foss.st.com>,
 "Andrew Davis" <afd@ti.com>, "Mark Brown" <broonie@kernel.org>,
 "Lee Jones" <lee@kernel.org>, "Daniel Thompson" <daniel.thompson@linaro.org>,
 "Jingoo Han" <jingoohan1@gmail.com>, "Dave Airlie" <airlied@gmail.com>,
 "Daniel Vetter" <daniel@ffwll.ch>
Subject: Re: [PATCH] ARM: multi_v7_defconfig: Enable BACKLIGHT_CLASS_DEVICE
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 2, 2024, at 11:07, Geert Uytterhoeven wrote:
> On Fri, Feb 2, 2024 at 10:51=E2=80=AFAM Marek Szyprowski <m.szyprowski=
@samsung.com> wrote:
>> core, because the DRM core is set to be compiled-in in this defconfig.
>> This leaves all DRM display panels without integrated backlight contr=
ol,
>> even if the needed modules have been properly loaded and probed.
>
> Hmm, that's bad.
>
> Is there any way to fix this in DRM?
> A quick grep shows that DRM is using the full monty of
> IS_{BUILTIN,ENABLED,MODULE,REACHABLE}(CONFIG_BACKLIGHT_CLASS_DEVICE).
> Probably not all of them are in perfect sync?

The IS_REACHABLE() ones are almost certainly bugs, as are the
'select BACKLIGHT_CLASS_DEVICE' ones we have in drivers/gpu.

> Several DRM drivers do select BACKLIGHT_CLASS_DEVICE, but if that
> does not work in the modular case, it should be fixed.

The select should do the right thing in principle, but mixing
it with depends is what causes circular dependencies. Unfortunately
trying to fix it likely also causes those, but I think it's worth
revisiting.

It should be possible to change it like this:

- change all DRM drivers that require the class to 'depends on
  BACKLIGHT_CLASS_DEVICE'

- change all those drivers that can optionally use it to
  'depends on BACKLIGHT_CLASS_DEVICE || !BACKLIGHT_CLASS_DEVICE'
  to avoid the dependency on a loadable module

- Make BACKLIGHT_CLASS_DEVICE itself default to 'DRM' in order
  to avoid regressions in defconfig files but still make it
  possible to turn it off.

>> Fix this by selecting BACKLIGHT_CLASS_DEVICE to be compiled-in in
>> multi_v7_defconfig.
>>
>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
>
> Sounds like a good interim solution.
>
> Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks, I've applied it to the soc/defconfig branch now.

     Arnd

