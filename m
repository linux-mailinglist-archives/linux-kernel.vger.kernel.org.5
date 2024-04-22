Return-Path: <linux-kernel+bounces-152964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97F148AC6C4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 10:21:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEAAA1C20EC6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 08:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FFF750241;
	Mon, 22 Apr 2024 08:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="WOkUtAuA"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDCD450246;
	Mon, 22 Apr 2024 08:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713774017; cv=none; b=skLDxGMxfElbcPQepdWXLJPNBf5a7ohMtJk5udweFYMVq2AGhEi6C2j7iQS/Bm6E5BooVP4ayd/eY22XghD2gpheEoGhmCmdfxq6oTMDHXwWiLEwqp8ErH7rs58p8W1Rr4uK1FYhDA/Xei8wQ4TKF+3pUYxJvGdTEvH+wIRk4EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713774017; c=relaxed/simple;
	bh=ioLj3UjzkRxqx+PLhNZWwzoBKs9zNnUOaYxxqxPgQqA=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=mTVPMbKzr0XBMydrCYRu7iDN8uIKKf1V+B8u+WWzzxo9uWduJH66xIzGSi87WqaSfazlYgsc2fluEpaxGqHYkq5Q6XSYTHSaQI3Lau9qgxs2eZAvZ57g3aUyfEBmB+Vs0jK8eoijQyCptgJUKn6BQKdRYZtGbjhdjdJhF1jLbkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=WOkUtAuA; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from [127.0.0.1] (unknown [62.19.35.7])
	by mail11.truemail.it (Postfix) with ESMTPA id 2A6F61FE18;
	Mon, 22 Apr 2024 10:20:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1713774010;
	bh=ioLj3UjzkRxqx+PLhNZWwzoBKs9zNnUOaYxxqxPgQqA=; h=From:To:Subject;
	b=WOkUtAuAdoTxCOQ/Mybik01JY7jBtLWoI+mGP7DTldOHG/jObtD3L50hsX7kXOkef
	 CZpGH9qbSpgj2tp1IebbFNDHKi+pe7ZlHpQ/WlQr47Z+oDcsNqAljOOSljXQiZu5gg
	 ZECKatOP2H+tmbh3x6C7VJMCMICRUE+v00SnwW8AqJUDqLrDz8UcOVmFHulX9kSLiR
	 N7Pe5ImhU8LBOylsD1XzlIYsRNdKMq7qwdcLdbztnllxU0it461J+QTluPTarjS7vN
	 cgsn25zO9FC818tXPZT3+nGeUIA+RNa6mMyiXi66QdtFu+a0RLusIbsPqguTnbsu6m
	 N/jH0tmoP3RgQ==
Date: Mon, 22 Apr 2024 10:20:07 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Jan Kiszka <jan.kiszka@siemens.com>
CC: Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>,
 linux-watchdog@vger.kernel.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Tero Kristo <t-kristo@ti.com>,
 "Su, Bao Cheng (RC-CN DF FA R&D)" <baocheng.su@siemens.com>
Subject: =?US-ASCII?Q?Re=3A_=5BRFC=5D=5BPATCH=5D_watchdo?=
 =?US-ASCII?Q?g=3A_rti-wdt=3A_Provide_set=5F?=
 =?US-ASCII?Q?timeout_handler_to_make_existing_userspace_happy?=
User-Agent: K-9 Mail for Android
In-Reply-To: <9ed68e05-5761-4dc9-b81c-fc847ec6d043@siemens.com>
References: <4d82b8ce-bc34-e4b2-c5fe-9e883b0db59d@siemens.com> <20240421084916.GA4208@francesco-nb> <9ed68e05-5761-4dc9-b81c-fc847ec6d043@siemens.com>
Message-ID: <3571B71C-5748-4F1C-9186-E7F687ABF198@dolcini.it>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



Il 22 aprile 2024 07:35:52 CEST, Jan Kiszka <jan=2Ekiszka@siemens=2Ecom> h=
a scritto:
>On 21=2E04=2E24 10:49, Francesco Dolcini wrote:
>> On Mon, Sep 13, 2021 at 01:41:43PM +0200, Jan Kiszka wrote:
>>> From: Jan Kiszka <jan=2Ekiszka@siemens=2Ecom>
>>>
>>> Prominent userspace - systemd - cannot handle watchdogs without
>>> WDIOF_SETTIMEOUT, even if it was configured to the same time as the
>>> driver selected or was used by firmware to start the watchdog=2E To av=
oid
>>> failing in this case, implement a handler that only fails if a deviati=
ng
>>> set_timeout is requested=2E
>>>
>>> Signed-off-by: Jan Kiszka <jan=2Ekiszka@siemens=2Ecom>
>>=20
>> Are you aware of this patch https://lore=2Ekernel=2Eorg/all/20240417205=
700=2E3947408-1-jm@ti=2Ecom/ ?
>>=20
>
>Thanks for the heads-up, we will surely try to test things on our setups
>as well=2E But commenting on this dead and not directly related thread ma=
y
>have caused some confusion=2E=2E=2E

I was too terse=2E

We have working systemd watchdog with that patch applied, this is the reas=
on I mentioned it here, it might also solve your issue=2E

Francesco



