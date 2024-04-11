Return-Path: <linux-kernel+bounces-141281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C567F8A1C17
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:39:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F046285552
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B164152DEA;
	Thu, 11 Apr 2024 16:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=noahloomans.com header.i=@noahloomans.com header.b="TOD0wofI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="h3PumdJj"
Received: from wfout2-smtp.messagingengine.com (wfout2-smtp.messagingengine.com [64.147.123.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E169152DEB;
	Thu, 11 Apr 2024 16:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712851734; cv=none; b=X97g7RY6/CYR/zK8uWDOJ3VYoE98fiFBVPxtKh7JCxiBoVdCYjVap0YbVEoZe2IVxvVLJsX6WBMbbAKI4d/ik9bDudO1+CfZFKjp/KHwr9TQkS2gvuywaLOB+cwVSxkzkr2/rUri5hZz61FMTRe1567i7JTApBGLHfW86LleZS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712851734; c=relaxed/simple;
	bh=w02RXuK8xBWmIvBZ8bYAhzEYz1YImFWzSs5wm9gRJi4=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=A97u2sjkL7PNCtTwiH5Y97ArpHe5/+T//bJxn1kfJuTYHpGnAn8RmOtY1qI3zlrxEGXsETjqthKQx81Jm0ALM6L7izJVxK6lYHL//327fpVUgMb6GMBovpsXqX0NEnVVbNHPkqRsN8USHA9slC4lfpJ0bi2M6V6a23+NotUuK98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=noahloomans.com; spf=pass smtp.mailfrom=noahloomans.com; dkim=pass (2048-bit key) header.d=noahloomans.com header.i=@noahloomans.com header.b=TOD0wofI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=h3PumdJj; arc=none smtp.client-ip=64.147.123.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=noahloomans.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=noahloomans.com
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.west.internal (Postfix) with ESMTP id D4A3D1C000F0;
	Thu, 11 Apr 2024 12:08:51 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 11 Apr 2024 12:08:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=noahloomans.com;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1712851730; x=1712938130; bh=w02RXuK8xBWmIvBZ8bYAhzEYz1YImFWz
	Ss5wm9gRJi4=; b=TOD0wofI9Tmdhtu1dVSN3JEiuOy/oOL52Jx5NrKPkRCjkSXx
	u4gyjOjhmINXd/hM8+2vCD6BgLBj3QElI5c50AizY5pJr4AgEFkA7WGuQ9vlS9i5
	gZkeIxGkPC/tAsEGlvM6yCNmdSCl8v2ZqMhQFkIVonf2i/NJsXoHuuF9qzmIo9wL
	2rYOPor83kBKJFroRbyG8d/PL70laJAVzelUEJINXylCypQCcqOTZ9eQETQSdll3
	Xk1JOJihkD9sqNmiQn4SvQcIAeQo2RgrWYj9NbCGh5g3UooqspTnBy4qTtzcs4aS
	3OSblBE1mcn6dkfLiytiZiDpXbEtVldIoar8Ww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1712851730; x=
	1712938130; bh=w02RXuK8xBWmIvBZ8bYAhzEYz1YImFWzSs5wm9gRJi4=; b=h
	3PumdJj6zq5Pz3NOES9sc8X13DdW7cpYJRCsmfrQDPzAmOwXHf9N/sO8b+qWGDZh
	P4kOBdjWJZ99CPamjuvMW2MG1nLHgSc7l9SYNE6OxkA+efnyX4h5b0okHiLvRZMg
	R0nyuaWJNQsUHP5mFRCd6cW5s60LwiHdSdG7CZQ/g1LsGhpqIqTs/6ZUN77kO7oL
	R7IRs7Kic0tSIdBQCVF4H43jpeg7lJspneBzHRGIrrdGE92FBb8oFvyDtBwe8JPe
	pv91ddte/T5B87Ph4vTzbD3eS2FuR10rpUylN9de1rGgpMBApDQlLEqs8hn7DAbZ
	tt/+wwvjFfQDauKmiugDw==
X-ME-Sender: <xms:EgsYZm9raIUM4v5wye8GUiby6reV1O-hQajAn56E6rvhBElJ4Ki_uA>
    <xme:EgsYZmuURTK5CLL0GVcZWxQ9n6I13362gYtxfpacUdjCRDGJYcfTgS1RV0Yu11sDP
    zrg4XESlvtzyQnxjd0>
X-ME-Received: <xmr:EgsYZsCr_H6EeSEmb-beDnAP8mi148uWr-Jg14AEw55m0omF-QL3LqItfor_dkJVXGtZlfJ_vW0pF5KVm4FOMQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudehkedgleejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepggfgtgffkffvvefuhffofhgjsehtqhertdertdejnecuhfhrohhmpedfpfho
    rghhucfnohhomhgrnhhsfdcuoehnohgrhhesnhhorghhlhhoohhmrghnshdrtghomheqne
    cuggftrfgrthhtvghrnhepvdefvdehveelvefhledtveetjeejtdejteeigfehveeugeej
    gfduuddutddtuefgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepnhhorghhsehnohgrhhhlohhomhgrnhhsrdgtohhm
X-ME-Proxy: <xmx:EgsYZucMxy0alKaoGQbl5X-YUqcpMvHKWxEn9456zE4r2Ebyxu570Q>
    <xmx:EgsYZrPMj8Yy_G-eInSNH41o9jojdxdxnSXsBLZ2xgMnKYW84V57nQ>
    <xmx:EgsYZomWDS2dhfb23yhhWlNfAxW954l0VdTNQkHPzbeWqa9XlOrISQ>
    <xmx:EgsYZtu_8WrCqf2JeFDAgS7OflvPFFOgINKESLKmScFp0bzWBCS27A>
    <xmx:EgsYZmo1ZcPUF2jkLz-iVwfm1jnW-x24dHgddiBCfX2JxZNhvop6IfgO>
Feedback-ID: i93394469:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Apr 2024 12:08:47 -0400 (EDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 11 Apr 2024 18:08:45 +0200
Message-Id: <D0HF9FPTDYNC.18XQW4MJQPCGD@noahloomans.com>
To: "Guenter Roeck" <groeck@google.com>, "Tzung-Bi Shih"
 <tzungbi@kernel.org>
Cc: "Bhanu Prakash Maiya" <bhanumaiya@chromium.org>, "Benson Leung"
 <bleung@chromium.org>, "Guenter Roeck" <groeck@chromium.org>, "Robert
 Zieba" <robertzieba@google.com>, <chrome-platform@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH] platform/chrome: cros_ec_uart: properly fix race
 condition
From: "Noah Loomans" <noah@noahloomans.com>
X-Mailer: aerc 0.17.0
References: <20240410182618.169042-2-noah@noahloomans.com>
 <CABXOdTe02ALsv6sghnhWMkn7-7kidXhjvWzpDn7dGh4zKEkO8g@mail.gmail.com>
 <D0GS8UL1WKI5.1PLEUUWOD7B8@noahloomans.com> <ZhdIc3vt3DFvT066@google.com>
 <CABXOdTetbKE_VWQsK4K6PB4Lm456BO7FfWyHtBBMhP77+QhzPw@mail.gmail.com>
In-Reply-To: <CABXOdTetbKE_VWQsK4K6PB4Lm456BO7FfWyHtBBMhP77+QhzPw@mail.gmail.com>

On 2024-04-11 at 04:26 UTC+02, Guenter Roeck wrote:
> We might also consider applying the patch to all ChromeOS branches
> directly (not waiting for upstream); we do see a number of crashes
> because of it.

Heh, I did wonder how Chromebooks running Chrome OS avoided this issue.
I guess the answer is simple: they didn't :)

