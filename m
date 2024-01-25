Return-Path: <linux-kernel+bounces-38716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C587583C498
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 15:22:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04BD71C231F9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 14:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB2AB6341F;
	Thu, 25 Jan 2024 14:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b="Y6Ok/gLP"
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B426340D;
	Thu, 25 Jan 2024 14:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706192534; cv=none; b=k5Vh44XM+hP1nAaXnXiz5Z4XNsHfStEyfBqZkDQwl6FU6xlKwLtHlAe3o1XAfACuWOCntHY1edqDRDE4P2hxBcr6x8H09/PqRcN7BucDFC0Vrf01u7jU6vrtIQIPGAPM5R+h1IC3mixN29tTj6bxt3hSfX/8xb0W9tbtOlMV7eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706192534; c=relaxed/simple;
	bh=BlFlnN5qxYKRyaYqgmmBhqDJtczdzc9S8thYktBe64E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NEjASiv3KS8zW1ezR490NKi4T2eDrq2CqGWcy3sIZ11OGk8lPtcUVP8E9ubRUc15gm9HhNNAy4EWJqShlPO3qjMKmithDb6xVg11Pt9seEZ3otJYJppLPH2U76MSwVRpq3YnXDH9PlSdByiwjCFrjcbn0uGaEJWWrjKH8siqirI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b=Y6Ok/gLP; arc=none smtp.client-ip=45.145.95.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
	t=1706192529; bh=BlFlnN5qxYKRyaYqgmmBhqDJtczdzc9S8thYktBe64E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Y6Ok/gLP5jvnH33oYT6TW7oClfxA5PvOAVDjcwKEBvtXq5qm8pVEruhm8I0v1s4In
	 KVsXmXNzC1d2pmdEvnHurE/b3wEapH/eQVFprvEyFhBOpD1z5EvrhbUQELthvCigV9
	 oFCowBTiAd2MNn8/9bwiYygOAm5H90tVSpAobN6SfnMsZOn8nUG8DD9xzrIYrmF+C/
	 X2cJRVwVem8kV4KYTJ+9By+AM7ofrF0U8QBd6hkyqsWSXUmY0Bn2QEHOUoA0fltzMs
	 Gt4TI7miaoXRQp2yLjgVUOX8vAQ4ygZnxOGZNovv4TW56xCYFM1TtpOXbAr22HWnRr
	 h2dIHCBvOMU+A==
To: Kalle Valo <kvalo@kernel.org>
Cc: Ubisectech Sirius <bugreport@ubisectech.com>, linux-trace-kernel
 <linux-trace-kernel@vger.kernel.org>, linux-kernel
 <linux-kernel@vger.kernel.org>, johannes <johannes@sipsolutions.net>,
 linux-wireless@vger.kernel.org
Subject: Re: =?utf-8?B?5Zue5aSN77yaZ2VuZXJhbA==?= protection fault in
 ath9k_wmi_event_tasklet
In-Reply-To: <87plxp1p05.fsf@kernel.org>
References: <ed1d2c66-1193-4c81-9542-d514c29ba8b8.bugreport@ubisectech.com>
 <878r4e4q69.fsf@toke.dk>
 <fb3ea26f-f9b6-4107-bb03-ca4893f0495f.bugreport@ubisectech.com>
 <87wmrx34np.fsf@toke.dk> <87plxp1p05.fsf@kernel.org>
Date: Thu, 25 Jan 2024 15:22:08 +0100
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87ttn1333j.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Kalle Valo <kvalo@kernel.org> writes:

> Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk> writes:
>
>> "Ubisectech Sirius" <bugreport@ubisectech.com> writes:
>>
>>>>Hmm, so from eyeballing the code in question, this looks like it is
>>>>another initialisation race along the lines of the one fixed in commit:
>>>>8b3046abc99e ("ath9k_htc: fix NULL pointer dereference at
>>>> ath9k_htc_tx_get_packet()")
>>>>Could you please test the patch below and see if you can still reproduce
>>>>this issue with that applied?
>>> Hello.
>>>  I can not reproduce the issue on the Linux with the patch applied
>>> Ubisectech Sirius Team
>>
>> Great, thank you for testing! I'll send a proper patch. How would you
>> like to be credited with reporting? Just as 'Ubisectech Sirius
>> <bugreport@ubisectech.com>' ?
>
> Ubisectech, please CC linux-wireless on any wireless issues and don't
> use HTML format in emails. More info in the wiki below.

Doh, didn't even notice that linux-wireless was not in Cc. Sorry about
that! :(

-Toke

