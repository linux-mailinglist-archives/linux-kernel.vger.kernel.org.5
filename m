Return-Path: <linux-kernel+bounces-38708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5514F83C467
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 15:12:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 889FC1C223CB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 14:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1333463405;
	Thu, 25 Jan 2024 14:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fByMSPId"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513B5633E4;
	Thu, 25 Jan 2024 14:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706191918; cv=none; b=d94LCW21qYLa8npOVF1uMQBw5e11d+brOAgl6+OWGGTEIfwRh0dDKcXER/1wE1WJIQN0waZ6HzHKthstcUUaiHzI1DjNPYMJLgcsnbotF/ck5/6ohYN6YQL2/KFDNe1MmhaODKlGnlsEUkWyP1NYWKVce8Zw10OMAjOXF5df6qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706191918; c=relaxed/simple;
	bh=/jo1CNyBcXQIcEa2M1kRwe74y/BzAkDY1EHD40eI6hA=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=AYXyUushpZDYb7U0b4t3RaZ+hPGW4jDNM5wUuzeq2p/jVKAyJ9NUtLVjN6sbgD0Ei+67RJVhXNlmIdrgamVnGSZCf6wOcYLhEcnQWXthEdkt/CGicb5tQtEsPXNxrgEp+2E9qffcSCYuWnY5jUWM9wB3di3F9GKa+0wkId/CX3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fByMSPId; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 795BEC433F1;
	Thu, 25 Jan 2024 14:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706191917;
	bh=/jo1CNyBcXQIcEa2M1kRwe74y/BzAkDY1EHD40eI6hA=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=fByMSPId8+5Rfn3HjHSUzUjVKd3flQGSKiyg90Z1fiRuDFDi+FLJZ/nmsHVAIULjs
	 MDjAOQkt3Dj+aF7L/0m9VvPClQDX3/xA8nazEUXr+5TvA4x7DgqhllxNPEVjGjmc+b
	 I/3xyesOqJCqjhqneHRiSrIT8OxbrAhjlOahL1PgH1k4c/ZK3JWD6bL3IbRIUugXww
	 NIePTnXeSLa2rxwB9Fpucwqbl9Dvo1eZnWgsY1ZdWmt8g/ADBJ7Hs8VZzcHgvVVgMk
	 /XdzspeJN5Ium/6q8PRXxkuGUQY5g/2IrKDivm8maoIwMyiE1kApDQD/1YErH2xpIp
	 C0A2EvPgoJZ5w==
From: Kalle Valo <kvalo@kernel.org>
To: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Cc: Ubisectech Sirius <bugreport@ubisectech.com>,  linux-trace-kernel
 <linux-trace-kernel@vger.kernel.org>,  linux-kernel
 <linux-kernel@vger.kernel.org>,  johannes <johannes@sipsolutions.net>,
    linux-wireless@vger.kernel.org
Subject: Re: =?utf-8?B?5Zue5aSN77yaZ2VuZXJhbA==?= protection fault in
 ath9k_wmi_event_tasklet
References: <ed1d2c66-1193-4c81-9542-d514c29ba8b8.bugreport@ubisectech.com>
	<878r4e4q69.fsf@toke.dk>
	<fb3ea26f-f9b6-4107-bb03-ca4893f0495f.bugreport@ubisectech.com>
	<87wmrx34np.fsf@toke.dk>
Date: Thu, 25 Jan 2024 16:11:54 +0200
In-Reply-To: <87wmrx34np.fsf@toke.dk> ("Toke =?utf-8?Q?H=C3=B8iland-J?=
 =?utf-8?Q?=C3=B8rgensen=22's?= message of
	"Thu, 25 Jan 2024 14:48:26 +0100")
Message-ID: <87plxp1p05.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk> writes:

> "Ubisectech Sirius" <bugreport@ubisectech.com> writes:
>
>>>Hmm, so from eyeballing the code in question, this looks like it is
>>>another initialisation race along the lines of the one fixed in commit:
>>>8b3046abc99e ("ath9k_htc: fix NULL pointer dereference at
>>> ath9k_htc_tx_get_packet()")
>>>Could you please test the patch below and see if you can still reproduce
>>>this issue with that applied?
>> Hello.
>>  I can not reproduce the issue on the Linux with the patch applied
>> Ubisectech Sirius Team
>
> Great, thank you for testing! I'll send a proper patch. How would you
> like to be credited with reporting? Just as 'Ubisectech Sirius
> <bugreport@ubisectech.com>' ?

Ubisectech, please CC linux-wireless on any wireless issues and don't
use HTML format in emails. More info in the wiki below.

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes

