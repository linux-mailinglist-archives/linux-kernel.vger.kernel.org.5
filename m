Return-Path: <linux-kernel+bounces-141280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 023E68A1C15
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:38:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACF3F1F22800
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4B72152522;
	Thu, 11 Apr 2024 16:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=noahloomans.com header.i=@noahloomans.com header.b="kS0Ve0XF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hjjVcvF5"
Received: from wfhigh2-smtp.messagingengine.com (wfhigh2-smtp.messagingengine.com [64.147.123.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC91A152194;
	Thu, 11 Apr 2024 16:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712851724; cv=none; b=FT9HFvOroCjZC0B2UMZKt/Vv3OfTe/IFWAjgoSpG1Z2yoBDrbwMeTqduNCz/s6c5Hpl1zCnbaH2UZjxX2o7+YqoOQ6e7GEBKPB7G1GxTJWrS4gDBBmg0j/A/7IW3fOevxa2UCvBNTkw8YIG7dLsPyDwRWIqMwvCYqdkzJsEZIOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712851724; c=relaxed/simple;
	bh=ImrXUuZ0WGMytlcwc8lLkwT1Du6KGgvdTCqqY2gB6UM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=jspdqSGL0hnTZSrah7tOcKL0gVoUeOilXtobvO8266A19+egzn/C24iLnfvTqV6g640OYrZn7XQClqh9sgjxlR4iw5e36xju5pM7y8nso/p6kOC5QTL1e652lSqkUkvoMSoUXlLV0pxkhR3PN54YEq1Rz/YFj6r7DGmMQfGW6yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=noahloomans.com; spf=pass smtp.mailfrom=noahloomans.com; dkim=pass (2048-bit key) header.d=noahloomans.com header.i=@noahloomans.com header.b=kS0Ve0XF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hjjVcvF5; arc=none smtp.client-ip=64.147.123.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=noahloomans.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=noahloomans.com
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfhigh.west.internal (Postfix) with ESMTP id DE60F180013C;
	Thu, 11 Apr 2024 12:08:39 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 11 Apr 2024 12:08:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=noahloomans.com;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1712851719; x=1712938119; bh=ImrXUuZ0WGMytlcwc8lLkwT1Du6KGgvd
	TCqqY2gB6UM=; b=kS0Ve0XFF5wLrlEVfnlQvJypHSpOOpEt/v0N+RNdLrXWwaXD
	ANOz/39cLbb135uDSaO3/OXrHhFRM7xDETzMX3CCY6vuUV5h+k3r80F9VhHtvybi
	SPYiktn5rrsarJ/Ioucpwt5AedLs0bpTocdAS8oXuCWio30xVX9lZWqv7fB60S+g
	34LUdj/oeQZtGSwBQQMy20jibrECUutlXSCGGImSKjKwTEMmoxzjmGxMAQ5Qt7fL
	yj4NJqZDF3so+eBvsoLC8nfEoZduucfK+YZw62lTTZYLIuueYdXVMz87arKJeaQ8
	bL47Ulf3AJ6BJ1faAIxsglojU34a2yBplgWMRw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1712851719; x=
	1712938119; bh=ImrXUuZ0WGMytlcwc8lLkwT1Du6KGgvdTCqqY2gB6UM=; b=h
	jjVcvF5GCBtbcH6A5dYcoSZyYsNKbKquJAMJCzP/7zhWvBAj2yuixB5ot0FSglKd
	A7hPOaSra3V0N5fOmmKPMEEZSuWXY1VfJUAACO+rEjJUrvRTSkQjp4wAUl5vxD+9
	pZIV0ox51Oudii+l0ABhz1D8I+hMZwv7jF4SkzDkJ50Ur5xPpJxg4BntR6HxrjlO
	YFUhnX8DohSTLHMeH+Qhsj1KLif4ORcgGMnQMy3JF5RAq21Vsl/b7P29LoDmHlfn
	ruXnyFwYmj4TwTiShMw+QrjteCFhyUxssQDWlrK0OJOdaHTJkCSWZ12zY4TFJ1NM
	kbKLS+HfyXoVvMvJ6fSLQ==
X-ME-Sender: <xms:BgsYZto6oaytwKLefj_jdcCPRbTJWwfCJ-GqKwaeKTf2YLidRBQOUQ>
    <xme:BgsYZvoGdPB4dYvbndQwQWM_Fe7sPq8I2jtA7Rfdl5xSU9jRbuLiHFzEi4s250byj
    vUuV5tX6xAKX4q3dQ0>
X-ME-Received: <xmr:BgsYZqPsg9Gu0kZm_5z_7LyDYDPwLNELs1LQn5caGpLDaPgpqTxVQtxN5byKijZZrANR1NYdItfM_r2ZBORLmw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudehkedgleejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepggfgtgffkffuhffvvefofhgjsehtqhertdertdejnecuhfhrohhmpedfpfho
    rghhucfnohhomhgrnhhsfdcuoehnohgrhhesnhhorghhlhhoohhmrghnshdrtghomheqne
    cuggftrfgrthhtvghrnhepvdeijeehteeggfefkeehleehkeevgfdvtdehgefgledtieff
    ueeuleeffeeuhefgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepnhhorghhsehnohgrhhhlohhomhgrnhhsrdgtohhm
X-ME-Proxy: <xmx:BgsYZo6f7YAbukDz_iAphc_sYfKsmjMKQpv96LnUrubU8zYt3cNiJg>
    <xmx:BgsYZs5HstnKWnlOOndA7_-nPhXP59jtiy1l8TkxAoY7SQaag2ccMw>
    <xmx:BgsYZghDOjT5oKHVZuYdE0WMRlBC2KNIi6GcXoglttN4L5Y670bBAg>
    <xmx:BgsYZu5LBcM540UgAvuqQi-p7FLZTEqgoIEV0xyGjx9jTseIq-Iq3Q>
    <xmx:BwsYZtG_AUFLsZkM8UrMQkYekvaJwWq-9VQVcadv6KydI1OxrOm-NJv8>
Feedback-ID: i93394469:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Apr 2024 12:08:35 -0400 (EDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 11 Apr 2024 18:08:31 +0200
Message-Id: <D0HF99KRQ7X4.274XNUDX5NVAF@noahloomans.com>
Subject: Re: [PATCH] platform/chrome: cros_ec_uart: properly fix race
 condition
From: "Noah Loomans" <noah@noahloomans.com>
To: "Tzung-Bi Shih" <tzungbi@kernel.org>
Cc: "Guenter Roeck" <groeck@google.com>, "Bhanu Prakash Maiya"
 <bhanumaiya@chromium.org>, "Benson Leung" <bleung@chromium.org>, "Guenter
 Roeck" <groeck@chromium.org>, "Robert Zieba" <robertzieba@google.com>,
 <chrome-platform@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <stable@vger.kernel.org>
X-Mailer: aerc 0.17.0
References: <20240410182618.169042-2-noah@noahloomans.com>
 <CABXOdTe02ALsv6sghnhWMkn7-7kidXhjvWzpDn7dGh4zKEkO8g@mail.gmail.com>
 <D0GS8UL1WKI5.1PLEUUWOD7B8@noahloomans.com> <ZhdIc3vt3DFvT066@google.com>
In-Reply-To: <ZhdIc3vt3DFvT066@google.com>

On 2024-04-11 at 04:18 UTC+02, Tzung-Bi Shih wrote:
> Applied with shortening the message slightly.

Thanks! And I see you already sent a pull request to Linus. That's nice,
didn't expect that to happen so quickly.

