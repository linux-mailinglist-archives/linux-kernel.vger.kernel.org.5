Return-Path: <linux-kernel+bounces-139397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 858978A02D4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 00:06:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B69051C21FAF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 22:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7E9D184122;
	Wed, 10 Apr 2024 22:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=noahloomans.com header.i=@noahloomans.com header.b="k/FASzBH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pSuCmUaH"
Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915D818410C;
	Wed, 10 Apr 2024 22:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712786803; cv=none; b=IHiQW/QLcC3sjoEdMk+DE19zjw0UiR7Ah2K9jNlKAPWA/AYd557FskP3t1ZquIRbuSNdaUCpmM6yxkj/80gxBs69YZET3sVDoZbdJJAgftO20jxCaPVD2NyUsqlQ0ViQLHqgfzZX4/O1EeESxlNj0vumz8EJ48fI8PkFIYt1loY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712786803; c=relaxed/simple;
	bh=hDr6Y9+XNRCuD5B6N5g7dzpvSY/j6WUCAujonwGLJBQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=Q4EJiGcfVsJLaXQbFaajTbTGWxD1Ti9AFV2GG8zGxEUwNs7/vJEX0UTkac6zurg0BHLtzV6NQ5ILVdhlGtI5Ev21PwwlrqCiL2z789cvnX4iPY0Q1gBjaNh+qViWQK+SsEyDvMkwpS2lfWxqawPk+vYpfco1giZ45RnZFVKhOhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=noahloomans.com; spf=pass smtp.mailfrom=noahloomans.com; dkim=pass (2048-bit key) header.d=noahloomans.com header.i=@noahloomans.com header.b=k/FASzBH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pSuCmUaH; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=noahloomans.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=noahloomans.com
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.nyi.internal (Postfix) with ESMTP id 6B4AA1380059;
	Wed, 10 Apr 2024 18:06:39 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Wed, 10 Apr 2024 18:06:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=noahloomans.com;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1712786799; x=1712873199; bh=hDr6Y9+XNRCuD5B6N5g7dzpvSY/j6WUC
	AujonwGLJBQ=; b=k/FASzBHZ+y5S2Xb4n+1dhgDrinbaAnfbBOkMOTkdHXuFhBR
	XY9y3kQCKR985aIw8u8PLMNHmcgdppdo0poKf8zvb1x9AGjqqR9C1sBxP6eFqkGi
	cD/lbG64yw1a5CcxkNv7R0+/UusYaQXy/JdnPCG+EkkQXD1xT84y+4mkJvycfxTz
	a8h+LzTTJko3i8sJScUlJqz4bGTg5Q91jAQLQoKR+wb0R7X7/Wm92V4BHaDP6hzy
	zfuDtyLFdsT5qC3nRfsxiAAMagjZUIbl8djfn6FCyv2tvogWQq7nDV5/249M4e0q
	satODWrMc2PDYqHHS5snrEapRzJxOZxfCm/vFA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1712786799; x=
	1712873199; bh=hDr6Y9+XNRCuD5B6N5g7dzpvSY/j6WUCAujonwGLJBQ=; b=p
	SuCmUaHe17M4eLknY80Qv61Qm+xxC3FaKf3661SLoVko4ue37UJvyPWYxqx9vBGg
	bb+7gErJRJw7XTLZXmoIB+pNReDnPXWxU9ytakhcIV8KZYH5LLa8X5/FbrDhN9OE
	lXWizuq8TG88xUDKgunBY7bZ+MM9N4zjBX612NrVrdY1/LA703ioKUv8pS6Dnh4P
	5nbYbfLuIi7harRfx3iUqBODvIL5sj/UVbrXT8CF0+J770vXmt3ygBBpTUTwJDAY
	ta8hvQl4BB5D7GjHFqpJajCwlDWQauzGv5AtiTqCNXhDOp1+JWVpTXBw5QABt0z0
	i2EB+FwULA/EPL9YwH02Q==
X-ME-Sender: <xms:bg0XZlrJnCOcls6IjcMw70ozNf8tEoF3Postpr-Yu22Fa6tk2sWY-g>
    <xme:bg0XZnqzlvlmnW3bwp4tsUO9r652PaseMPer6zmAIzplEivCZcvCaAjyq8qKO47dB
    37MJWxtzsNFS0VwD9A>
X-ME-Received: <xmr:bg0XZiNfQuKKLGLAYZZ3apnzIHZdgBvCMR00gpnX4jFkjO9kQMfxeeX21DDtLTOkBZHTuj-wyeVAdYLz6aIhww>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudehjedgtdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepggfgtgffkffuhffvvefofhgjsehtqhertdertdejnecuhfhrohhmpedfpfho
    rghhucfnohhomhgrnhhsfdcuoehnohgrhhesnhhorghhlhhoohhmrghnshdrtghomheqne
    cuggftrfgrthhtvghrnhepvdeijeehteeggfefkeehleehkeevgfdvtdehgefgledtieff
    ueeuleeffeeuhefgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepnhhorghhsehnohgrhhhlohhomhgrnhhsrdgtohhm
X-ME-Proxy: <xmx:bw0XZg5g40prx91R4lNAhgMe1gsbCC9THmEVprxNF2Yngq24lhcS_A>
    <xmx:bw0XZk4-SBi_0pcalrQhF8F-NZzHHiFi1uoe_LzN-M98o1iIf4zszQ>
    <xmx:bw0XZog3i9MOc0NizI0X0NQ6C3H5RNjOd9xAfNem76vJiR6BkOx1Lg>
    <xmx:bw0XZm5mKLr8aMDUJ5NchY-8cWs7cs9juvuJqkYY-5cShdW4W2oQyQ>
    <xmx:bw0XZlGg6K0TA8HL5HdhzDeGa9m6bSERYDe3NAy6Vw6uJbld6qM9d9Jl>
Feedback-ID: i93394469:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Apr 2024 18:06:36 -0400 (EDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 11 Apr 2024 00:06:33 +0200
Message-Id: <D0GS8UL1WKI5.1PLEUUWOD7B8@noahloomans.com>
Subject: Re: [PATCH] platform/chrome: cros_ec_uart: properly fix race
 condition
From: "Noah Loomans" <noah@noahloomans.com>
To: "Guenter Roeck" <groeck@google.com>
Cc: "Bhanu Prakash Maiya" <bhanumaiya@chromium.org>, "Benson Leung"
 <bleung@chromium.org>, "Tzung-Bi Shih" <tzungbi@kernel.org>, "Guenter
 Roeck" <groeck@chromium.org>, "Robert Zieba" <robertzieba@google.com>,
 <chrome-platform@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <stable@vger.kernel.org>
X-Mailer: aerc 0.17.0
References: <20240410182618.169042-2-noah@noahloomans.com>
 <CABXOdTe02ALsv6sghnhWMkn7-7kidXhjvWzpDn7dGh4zKEkO8g@mail.gmail.com>
In-Reply-To: <CABXOdTe02ALsv6sghnhWMkn7-7kidXhjvWzpDn7dGh4zKEkO8g@mail.gmail.com>

On 2024-04-10 at 21:48 UTC+02, Guenter Roeck wrote:
> On Wed, Apr 10, 2024 at 11:29=E2=80=AFAM Noah Loomans <noah@noahloomans.c=
om> wrote:
> > This is my first time contributing to Linux, I hope this is a good
> > patch. Feedback on how to improve is welcome!
>
> The commit message is a bit long, but the patch itself looks good to me.

Hmm yeah it's a bit on a long side. I'm not sure what could be removed
though, it all seems relevant for understanding the bug and the fix.

> Reviewed-by: Guenter Roeck <groeck@chromium.org>

Thanks!

-Noah

