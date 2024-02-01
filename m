Return-Path: <linux-kernel+bounces-48025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 09116845665
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 12:40:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B4BD1C24364
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 11:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7933115D5B1;
	Thu,  1 Feb 2024 11:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=public-files.de header.i=frank-w@public-files.de header.b="Gb/4rflU"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C7A15B99C;
	Thu,  1 Feb 2024 11:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706787648; cv=none; b=VVXqwWIIFR7xJNQKdR8UYruPgKn+K1JvrZOO+WMvLdtITChwjlhXNsxquPJ3hBrqa7cmZ1S/l8dzbzoNcGju5NmI6RG5LgHHTp25DRBtJH4iHRKN8krK344uddQQGaV2CvpLq1ZY2IGpSqeprAtDGWWXcBorMNvPQlb2KcWwBi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706787648; c=relaxed/simple;
	bh=0ml7viK80JH0Jva8+KAcBgTkHRB2cpSTmxKESK/H3VU=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=trAiznzWYuaGF1BRolSievI5f+Iaxjk2OKXl/8oAEhNlcBOj4ZSqmjFY4b4MPZFRtEIcfydJOWAJ7IFKAoiP2ayT+3X6sX8d50H9kt3z1N6f5Eh1yyvTjvfBGUQcOqf1Ten2hbnM38APx92xQ82FlswE/tetK9VE3sCq4uD0YVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=public-files.de; spf=pass smtp.mailfrom=public-files.de; dkim=pass (2048-bit key) header.d=public-files.de header.i=frank-w@public-files.de header.b=Gb/4rflU; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=public-files.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=public-files.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=public-files.de;
	s=s31663417; t=1706787620; x=1707392420; i=frank-w@public-files.de;
	bh=0ml7viK80JH0Jva8+KAcBgTkHRB2cpSTmxKESK/H3VU=;
	h=X-UI-Sender-Class:Date:From:To:CC:Subject:Reply-to:In-Reply-To:
	 References;
	b=Gb/4rflUUnnLFGxlwx6g6lBB1v1L7/XE05d5gFvf5JXZD7yB752i0+4ejoMT8y30
	 69ogzd1P38x2+Rc8ve5u6nMotZgucM57eRVVHJCa0cLPtKIce0/ROZlfNILk3zCRD
	 OylAaGWJmzLcuRn2ZvwqsAmNkOQYQAIxObILRNe7juejwjKGanUqP4EK3dLIM2bzF
	 YPWSx0CGQ+6GQODxfYQlaqsuK+b3u2nOoBQhII6+pJaRXciasb3c89dIDIakNUWDn
	 XsEEZoitD5ZTN+76CAjLk/N/5TPARvNcZF/ipWTXmGWLcaWK/yQ4/aXCIzDyQhY/8
	 c1tWUYoABVhf4CR8/g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([217.61.148.248]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mw9UK-1rEwXw1fXg-00s97s; Thu, 01
 Feb 2024 12:40:20 +0100
Date: Thu, 01 Feb 2024 12:40:17 +0100
From: Frank Wunderlich <frank-w@public-files.de>
To: Conor Dooley <conor@kernel.org>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
CC: Frank Wunderlich <linux@fw-web.de>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Sam Shih <sam.shih@mediatek.com>,
 Daniel Golle <daniel@makrotopia.org>, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: =?US-ASCII?Q?Re=3A_Aw=3A_Re=3A_=5BPATCH_v3_1/2=5D_dt-bindings?= =?US-ASCII?Q?=3A_reset=3A_mediatek=3A_add_MT7988_reset_IDs?=
User-Agent: K-9 Mail for Android
Reply-to: frank-w@public-files.de
In-Reply-To: <20240119-dupe-obligate-707b3a01b356@spud>
References: <20240117184111.62371-1-linux@fw-web.de> <20240117184111.62371-2-linux@fw-web.de> <20240118-calcium-krypton-3c787b8d1912@spud> <trinity-afc4f48e-65e1-46ee-a78b-1d670cc0f310-1705615200900@3c-app-gmx-bap21> <43f946cc-07e1-48c5-9b31-40fc9bc93037@collabora.com> <20240119-dupe-obligate-707b3a01b356@spud>
Message-ID: <0EA6A126-DDC0-4E9F-BEBC-FD018B08CA84@public-files.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:y1z6Q7jXj+pqO1HZuYlxzuYbo5XGWT2nhBglJsaS3D/jXYPHO/E
 fqQckoUFrqWOYtFnR0avV/83ZiKtvFzTv0jNqDkQ4JQkSYb1R4TamPDpKXNjN/ArOiiFzUw
 zz54ZZENgvZguVYhLrfnI8TdVnyLp9SGIgiAOMryKrfSKWWH0/gDELEWzHvIOTEo1pVI+ZW
 WyQJhWE01UcOjxOi5rADA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:pWne6h6kXCc=;pZaGvfKj0LTWoHMsy0FDDU4zrVI
 CewLpa8CIG3a3PXERoJlwqw5wE5gAL0HhZsj4pEcxrPQvzVCVfQSNrL5EPhEoFZmJRbcplvbO
 Cr4RQGG+PggquRYr3QnqvRhEEVsNfJ8blN83TiVomrrbUE3tDo4rfMOVLX+J9/QPtGxjP8KRG
 X6sTL5tZgtMjmONbS3Tfusw12GL9d9uwaIj7kiWolOyx8dOozA4MGW10/cc0NECcImpwo1yrI
 TgksSBZihpqet5jMBEa9imsZUFvGFEh3md2Bitg5AOQw0pr8AQ6dMlxasEC+ADew9ZTSSZmck
 IwZGJCEkg5gK6DcwhV8JS/fnCNn5Pa6YF5Qa6Tnpa/VMzZVvVUY/PaxM/mOuL79OacrFDYkI3
 co5g4gco8F/LJ4AuBIwUTlXWrWTL0Nsv0IHVXnOlvvQUP124TL6mMPoENzEu5oS+kKiW1kdZc
 4Dt4u/J3rW4/3ZGBLUeUF07OwXya0By3rfTCafR6UDBECjR7bLTD86S55bn9DrqmTblL/GjQY
 a68XW1M7h0d6ifO/98UR2YXp2eqP6G9RJu3nV155M86fPK4vA/DZfn5EopIz653pDnT/QYm/m
 nWFeupFQLb9JJuaH/GIhFjVJvpJhop7gU1Tc2vIt6S5iiAB6LZ6sSbJXw5ye/z8CeC/8XHC4s
 yrDK6lXHTNF1F27cFzLy+g9fvkKb9dDCRHaWSL9SsO68hLAFJQCy2zQ3uAZP9GT9UuyI74oPU
 X97C3XhX/ZKHMTvnfzMGtaQbu59TuCB5C/Rm2QQxZyXBZMuq+QrjQetUoOxTgU2GFJx3wSGbN
 8bo840wwR7QOQi3H0YvPAUJzHxtS6gyeYT+fooHIZAwYw=

Am 19=2E Januar 2024 18:04:36 MEZ schrieb Conor Dooley <conor@kernel=2Eorg>=
:
>On Fri, Jan 19, 2024 at 10:28:30AM +0100, AngeloGioacchino Del Regno wrot=
e:
>>
>> The resets are organized on a per-reset-controller basis, so, the ETHWA=
RP
>> reset controller's first reset is RST_SWITCH, the second one is RST_som=
ething_else,
>> etc=2E while the first reset of the INFRA reset controller is PEXTP_MAC=
_SWRST=2E
>>=20
>> That's why ETHWARP has a reset index 0 and INFRA also starts at 0=2E
>> I think that the numbering is good as it is, and having one driver star=
t at index 5
>> while the other starts at index 12 would only overcomplicate registerin=
g the resets
>> in each driver, or waste bytes by making unnecessarily large arrays, fo=
r (imo) no
>> good reason=2E
>>=20
>> This is one header, but it should "in theory" be more than one=2E=2E=2E=
 so we would have
>> one for each hardware block - but that'd make the reset directory over-=
crowded, as
>> other MediaTek SoCs have got even more resets in even more hardware blo=
cks than the
>> MT7988=2E That'd be something like ~4 reset headers per SoC (and will i=
ncrease with
>> newer ones)=2E=2E=2E
>> =2E=2E=2Eand this is why we have one binding header for resets=2E
>
>That's okay=2E The commit message leaves me, who clearly isn't a mediatek
>guy, with no information as to why these are not one contiguous set=2E
>IMO being for different reset controllers entirely is fine=2E
>
>> On the topic of leaving space to allow grouping RST0/RST1: -> No=2E <-
>> The indices have to start from zero and have to be sequential, with no =
holes=2E
>
>Agreed=2E

Hi,

Just a friendly reminder=2E

As far as i understood, Patches are fine so far and do not need any rework=
,right?

But i have not seen them picked up yet in linux-next=2E
regards Frank

