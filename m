Return-Path: <linux-kernel+bounces-84696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7FD786AA54
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 09:44:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7C001C237A1
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 08:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ABDC2D606;
	Wed, 28 Feb 2024 08:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="sur7Hj1K"
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3132CCB3;
	Wed, 28 Feb 2024 08:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709109852; cv=none; b=uzIKTXhopsWeO/25E9dnbaHd7S3VT+rTpveLcE1LNhc7pTDnymTz0/xiQKK7GBVQnP0+mLOnPAn+UfvZ/aYwVPtHM6hFOMZcpkUpyOwVTTD4SRmGGClPnbsKjkfJLWY1BtGohTDzVgJHF8jZuarLxjDpzpQMH3Ewv6KMn8jHIJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709109852; c=relaxed/simple;
	bh=cHIS1svXb6d/RpoB/Li5PbPLE1lQzEq1C87i6qaodzY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ld/fNsJfMTWcK9b5yO75ksZLZbd5BECrNJ41/jJeqStBm4TyQFonVXjngNIu0qreraB1U023sMQoOfos1ZxXjnKOzxYze0/EdjRoHlbgzGrf4qQ61HHH5vOj1gmU1WBuqOD5FcrmfgM9TWpPkI8YQDEAkn5J/Yu7glLDBcFODLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=sur7Hj1K; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1709109826; x=1709714626; i=markus.elfring@web.de;
	bh=cHIS1svXb6d/RpoB/Li5PbPLE1lQzEq1C87i6qaodzY=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=sur7Hj1Kl1YB2neskONQG2q7PC6AzVx2JuxowRHZCqh9yJMYM9sd4A+K1jEF3nKO
	 +0ftNVar+jSf0OaUH92joGYT+MKdMaYJaQ54MOWE6mBP/rMpZ3+vFhX25Fq50iCap
	 EkkksCvUihJDDBwq6g4drzQF7E+H+S4WbKZirKT+V2rc4a5wDc0djK7O46VDPiPWt
	 KArIx5XwMV9/whj30Y6QvqrDeaSHO9XIwhxtYprays6ZxmRXbIXksZRh3D4k5BoR7
	 d8sfDHu79ok7EFPoa7nSCeoikk4LNo4ia4ntAc8s3J2THdavm8wks/i0z6pX6pNNI
	 qjR8YkDg+HOBkAZcag==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.91.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N3ouw-1qx0oz11rE-00ze7P; Wed, 28
 Feb 2024 09:43:45 +0100
Message-ID: <99ea976a-2a37-4656-b370-53daaff54c49@web.de>
Date: Wed, 28 Feb 2024 09:43:35 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: net: fman: Use common error handling code in dtsec_init()
Content-Language: en-GB
To: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
 kernel-janitors@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jiri Pirko <jiri@resnulli.us>,
 Madalin Bucur <madalin.bucur@nxp.com>, Paolo Abeni <pabeni@redhat.com>,
 Sean Anderson <sean.anderson@seco.com>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <9b879c8d-4c28-4748-acf6-18dc69d8ebdf@web.de>
 <20240227184657.76ec4e82@kernel.org>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240227184657.76ec4e82@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UEhwDiFFYhbgpCNlbJ0nMLLlJiSUwR7HvrCgVPbeGeuv1ho1Hzh
 QP/LE3Kre6ApUfuUlw5Nn+7yogjHSg/EXBCsTU+9TVnN87aeHhjoyy3rzkHUkUumGqXQkTe
 noa/DF3Rs6RyBKTtI6Ba3lWR2F2SHeqg3SV31381zPJpDNDNy79RaQEFds1WrB0WGi2Bmh3
 8m3y6T8aGHM/HAvZONfww==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:/QhjLhitUUU=;rpelHu5AhkcwITbez8ZWCQrQC7b
 cM963v/AgxcIb1xtJ+crDhpAq5n3CRYqVV+sHvn0UPun/cNWovVu+VnOeuQxFOsYJ8MvCGAmx
 XfoMDZo7K5lKrrncjVeUeXfFFAjaxBpzBSv0lzqgU/zuixrBNJUoX333Axca14zNmgY3yGq62
 4M9kY00bAqA49lwDDYQRzsPdbnrwvu9ryZBi0ph6UzoMQsIO2JnvkOh+SdiO/A8PDiGkCIy+l
 WNEbVna/k6mqcLsgu1G6/QW/eBY8FXYAwQGOysQfsuGQVWN4sBNVo4e3TN4OChriGavyjayF4
 JLvejHRVIAVD4pS9iEgDwVLQOhekpwbLYMYnnRganTPWeBaFyfWBaMrMCZ+ymOgsP1EsmtvbZ
 XULtruU8D4KZ5sEkE1xQRSmr0zw2771g1XwNBZMiooc+4WJObWs3zv1r68tuOocAWfjDE29/N
 bOluLQpIcJ0D9par2AouOalclthzqGyv42J3QuT5XjD18DFnsAum1YmV3212wWRa1r/b32EVC
 v2tAY4NSImADiVyn9aPL/3hRXplipHUr35JQiS8KzgzuCqygh33FO4c7dcAlzSs4fMxPYIHRu
 kOtGSGBdg+x4hqDwlxa4rMILEqhYw+sEQB2WhEzcnWi1xl1gmgsimEhtLQEjSan6O4qSfoW/W
 foGI0QWSv8ikyH7D624KiE72UAU0GNqSE1/JJYY2+utt4pXIX4NMIGASFDvGzjfiFZDzUEDgN
 C/qToK8EDYF

>> Adjust jump targets so that a bit of exception handling can be better
>> reused at the end of this function implementation.
>
> Okay, but..
>
>>  .../net/ethernet/freescale/fman/fman_dtsec.c  | 19 +++++++++++--------
>>  1 file changed, 11 insertions(+), 8 deletions(-)
>
> ..you've added more lines than you've removed so what's the point.

* Can the change acceptance grow any more for attempts to improve error ha=
ndling
  another bit?

* Would you like to fiddle with scope-based resource management?
  https://elixir.bootlin.com/linux/v6.8-rc6/source/include/linux/cleanup.h=
#L8

  See also:
  Article by Jonathan Corbet from 2023-06-15
  https://lwn.net/Articles/934679/


> --
> pw-bot: reject

Can such an reaction be reconsidered once more?

Regards,
Markus

