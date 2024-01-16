Return-Path: <linux-kernel+bounces-28287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12EB382FC91
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 23:23:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4B091F2AD24
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 376B92D791;
	Tue, 16 Jan 2024 21:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=fiona.klute@gmx.de header.b="agA+JFZ1"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58B91BDFF;
	Tue, 16 Jan 2024 21:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705439714; cv=none; b=dyqOUuykEJktBsW9CScyARKZvuvSO9I+U6Ni8Y7Fp9FKw4Li9n5zw9l2Q8l2oFkHgAKnHxMSxgmOAuG5mnkniu4T3/Lrrc57vUEvDMN7N9HfsuEBAU4+jI/AElHVJb2dkwmyLmkQ1xfK1PThNuZ2qptzwmZ/4aSzBGIwzUoxdDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705439714; c=relaxed/simple;
	bh=C2+za83C8Vy97mXGWtsv2kboAABymcwoRKxexre2OqI=;
	h=DKIM-Signature:X-UI-Sender-Class:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:Autocrypt:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Provags-ID:X-Spam-Flag:UI-OutboundReport; b=s1iB4MqJFQg7Am7dJ9Zi7uY5vuBttSC5P+Lm04BJRTfMKPVwh7rJDSlqCgEtv+SflZf3AB/at5pVZzJZFoyNj0aBH2oZ4ZqJ1Sh2tjgDaAaDd9aOZGdh5uLxoGUWrDlLHvoH2m4/VwBqU4U+xOvqIMqEVcmehESVOxUs57gbb50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=fiona.klute@gmx.de header.b=agA+JFZ1; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1705439695; x=1706044495; i=fiona.klute@gmx.de;
	bh=C2+za83C8Vy97mXGWtsv2kboAABymcwoRKxexre2OqI=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=agA+JFZ1l4mFGWAbX8XqZt9NXpUM1Wf+M2O6SEqFRWV9rPLNYfZxcZ8Phm+6Qn7D
	 C1avn3N7rvx0uPQcWqjW7zeqZWhIhFYZVSsH6e+OmaZ5bG8LntZgaDtZCnvlS1OM1
	 5vIaoeG/sTWLHV8wie5S8+Q+imJsG2VvZzozAKI250m4kBTlzgzfNrNkbadbHtrEB
	 dOD5uIga07zRl7qWDuXefxOLpQjjKEjQS9Oej9RvZVwQNR9158FdsvIYy5oFI45Jp
	 skKmbd/qq1v7RGndI30hymXAyRYu3gfP6gLhn+WA5s4GSdWFifS6Vw1RMozsrRsrD
	 FZ6wehhPlnZycucMNw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.7.2] ([85.22.132.29]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MLR1f-1rh6dg2M8B-00ITEs; Tue, 16
 Jan 2024 22:14:55 +0100
Message-ID: <3f60d01d-b047-4e5d-a8d8-1debe3466629@gmx.de>
Date: Tue, 16 Jan 2024 22:14:53 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Front camera on pinephone
To: Pavel Machek <pavel@ucw.cz>, phone-devel@vger.kernel.org,
 icenowy@aosc.xyz, martijn@brixit.nl, megous@megous.com,
 kernel list <linux-kernel@vger.kernel.org>
Cc: alain.volmat@foss.st.com, sakari.ailus@linux.intel.com,
 linux-media@vger.kernel.org
References: <ZaY44AHISMIh8fHM@duo.ucw.cz>
Content-Language: de-DE, en-US
From: Fiona Klute <fiona.klute@gmx.de>
Autocrypt: addr=fiona.klute@gmx.de; keydata=
 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
In-Reply-To: <ZaY44AHISMIh8fHM@duo.ucw.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8Hln6Gm6THNL1D2MgZysJP3j89HFAms0xQStxEXyqDnEutr4Qsm
 Pa48/UyI/Ml/DKSxCy4UU1o7j0AuEHYfxWd0Zjz0TCfcCbEXTbnZ0auwSg4VV/0plTRPdhL
 pyVYTPcm4T5P8Y9Qz7IAezWMvXxguqNy/vu/SykYwo1B9WXbu+EI8rn3j8JntZpjY6JF0gx
 xswXbVDJy8riCnkW7d21A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:LeUNXm4kJDA=;k5vk5utJUQ+IpGgAIiyPl+UCtvw
 LKm4S1hlnlDrw1bCt4k8VUpVIuLaBqOhQ9CaG1TF7H6MKIZxvRR5Gt9bSfIeaRO8RGRf+PW5b
 plcvSL1vS8rWLB/w1jY081moWwM3SJMrdUCT463t9P9LWUWFo6SZxjIZJ/+mEjeiYGGvSYDK0
 +TJMs+JHMBPfAflb7HMaG9Zf+FFdbrFDUB7gdgOti/KMluT8vcy5f4gSeymEvhS6nCLso/KHo
 77xrqq1lthL8TzmDYxc53HMW0Pf3SUdfjVzt1i0hhbFSKwyR+3A3Xgyc8wKLUK8lSA9HC0//o
 rNJQKfuyt4KedIMEyCajPVgc/XYnaAzIrJBLj8Oi2hMrv6skcNtKQ/v18QxYU0+t0f51UlbGn
 qUXknfnNWIWgDIjpMzTP6KFTLAPjDbno70vNBsw8dhQbLAb+NkfjQW85HVyRpFFL46YO7oBrs
 4kR3mZo0HEQuvVbGnUHIoOFzJS+WgC05yga4Yuo6FWEjjPRNeNG6ActD81Mj5JPW+nVa+PVfq
 Kjuw9QYQywe2LPQHXX15g0sCrQgmYOcZnWNpJKb5DzS/Bu3ZW1eNNrbikaaM8CCRZBAUquun/
 xKBm2JdEQPmAhA+hmDD/UtFkI1Vuer9dFFtLRX97g8bid6zQ89c44hFP5xTMCKaiBiLi/S0J5
 J9pi/GdSnnhjCJvPSRue89cUOoK+0mbiC4OQJndlH4NGEDm7vwO3vBZ/Qo+4GaAMNIo2Y0um8
 okaQzq/4Fhgl25ASgFKLNyr0oYwN4UKPmKdT/ZzT8YEXj5mdifZje+TjoJ6JcgA6FYNreQONQ
 50E6j1jU4olVBJT9HzQ9+XTavcWhQUeXZd/7wftiMY3GzapBmUZuZi8PiFtM6zIlCon+Ilvoc
 UpRLeIBzDb4bMxDdfD/1xZQDx9MyqaCh/QhEJHQap8AkfoBTnI2vDIiG1CzGg7INEIC3wDYTk
 ug9gLA==

Am 16.01.24 um 09:05 schrieb Pavel Machek:
> [If you have hints how to set-up pinephone for kernel development,
> that would be welcome. Currently I have mobian with rather old 6.1
> kernel on it, and lack of keyboard/ethernet makes things tricky.]

So far I'm mostly using "pmbootstrap build --src" [1], which essentially
builds the pmOS kernel package but replaces the source with the tree I
point at. I keep thinking I should try envkernel.sh [2], which is
supposed to set up cross-compiling with the usual make flow. Maybe
that'd work with bindeb-pkg?

I don't know how well an unpatched mainline kernel would run, I'm
currently using megi's 6.7 tree [3] plus the pmOS patches as the basis
for my rtw88_8723cs development [4] (if you look at the history, it's
v6.7 -> orangepi-6.7 -> pmos-6.7 -> rtw88_8723cs). I know megi's kernel
has some DTS patches but haven't looked too deeply into the changes,
maybe some could be upstreamed together with the camera part.

Regards,
Fiona

[1] https://wiki.postmarketos.org/wiki/Pmbootstrap#Building_packages
[2] https://wiki.postmarketos.org/wiki/Compiling_kernels_with_envkernel.sh
[3] https://xff.cz/git/linux/log/?h=3Dorange-pi-6.7
[4] https://github.com/airtower-luna/linux/commits/rtw88_8723cs/


