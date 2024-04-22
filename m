Return-Path: <linux-kernel+bounces-152968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD35A8AC6D8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 10:24:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5146EB207DA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 08:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D54850276;
	Mon, 22 Apr 2024 08:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="lYJOwzDq"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE31482CA;
	Mon, 22 Apr 2024 08:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713774240; cv=none; b=IzYy6dSRrtCwJqbi4AvQjyUAWM6j2DFr9bfXD38d/CKBRrvpO5HVpC/yEqb7fccEboNIdrKHILTZKc6qipCrjblmic6dUtUCkChdyMzosNNAaE9G0Ye29e/B5D0MuTgJHMVgDGtjWlfCE6lALURZDdn830f2PFYPVNyLuhb+oig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713774240; c=relaxed/simple;
	bh=qcmpMXK24ToMCaNq6MaE9YPrg0kGschS1HfQkrEgdi8=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=MTrLBl3IZGJrzZEyr9ViA3ODfXQwo54S7gbmeJJk6SSZANEfK2+imKUXruqmwNAJion1FxK7Iq0Vkq870xbV41vEiYTsPq54uzMhS/oLHvN2h9CYX9Vvo2xikh/YLR82kyL14ZNO/hKVRPFn43xcfKKzJr/hjW9hCiQbLrTCkf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=lYJOwzDq; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from [127.0.0.1] (unknown [62.19.35.7])
	by mail11.truemail.it (Postfix) with ESMTPA id 2C01D1FE18;
	Mon, 22 Apr 2024 10:23:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1713774235;
	bh=qcmpMXK24ToMCaNq6MaE9YPrg0kGschS1HfQkrEgdi8=; h=From:To:Subject;
	b=lYJOwzDqzaxEPaanJFTj8sna7+BpYkC0D7BjQlXwjl3F6yBl0lm3Pgwsm5VxYudag
	 RTTD33B256Ukwk04d9S2iJ/4tkVHL2ddazR9Iq8M9a9b1tFkQU9Ii6X0Whca4lu8+s
	 ktVJ6Jh3U8BReiGXXTgDqbfnW0bMABQy+SU+b3GMbgIDnKm1ml56W964AnCAtUPrFb
	 gG3ZQQ08Una8GIky9B5ZqbCzZi94zPyIcX79AvqE6Sp/Cic52iMOBdK7hTMaqXMCq+
	 NKlTboC3TC1t+mv7YP2bJFzkzcTlXcV0RRDbCfXvDaog6HBz/mwn2zp1Qg4DkKVYmJ
	 /RdVYlBkVxVMg==
Date: Mon, 22 Apr 2024 10:23:50 +0200
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
In-Reply-To: <3571B71C-5748-4F1C-9186-E7F687ABF198@dolcini.it>
References: <4d82b8ce-bc34-e4b2-c5fe-9e883b0db59d@siemens.com> <20240421084916.GA4208@francesco-nb> <9ed68e05-5761-4dc9-b81c-fc847ec6d043@siemens.com> <3571B71C-5748-4F1C-9186-E7F687ABF198@dolcini.it>
Message-ID: <92887F20-B0E7-41FD-A5BC-ED9A28804F2B@dolcini.it>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



Il 22 aprile 2024 10:20:07 CEST, Francesco Dolcini <francesco@dolcini=2Eit=
> ha scritto:
>
>
>Il 22 aprile 2024 07:35:52 CEST, Jan Kiszka <jan=2Ekiszka@siemens=2Ecom> =
ha scritto:
>>On 21=2E04=2E24 10:49, Francesco Dolcini wrote:
>>> On Mon, Sep 13, 2021 at 01:41:43PM +0200, Jan Kiszka wrote:
>>>> From: Jan Kiszka <jan=2Ekiszka@siemens=2Ecom>
>>>>
>>>> Prominent userspace - systemd - cannot handle watchdogs without
>>>> WDIOF_SETTIMEOUT, even if it was configured to the same time as the
>>>> driver selected or was used by firmware to start the watchdog=2E To a=
void
>>>> failing in this case, implement a handler that only fails if a deviat=
ing
>>>> set_timeout is requested=2E
>>>>
>>>> Signed-off-by: Jan Kiszka <jan=2Ekiszka@siemens=2Ecom>
>>>=20
>>> Are you aware of this patch https://lore=2Ekernel=2Eorg/all/2024041720=
5700=2E3947408-1-jm@ti=2Ecom/ ?
>>>=20
>>
>>Thanks for the heads-up, we will surely try to test things on our setups
>>as well=2E But commenting on this dead and not directly related thread m=
ay
>>have caused some confusion=2E=2E=2E
>
>I was too terse=2E

And I did not realize your patch was from 2021=2E Sorry for the confusion=
=2E


Francesco=20

