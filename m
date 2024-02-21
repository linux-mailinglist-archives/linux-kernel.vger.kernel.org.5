Return-Path: <linux-kernel+bounces-75155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0387685E3ED
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 18:02:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3599C1C21E23
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 17:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E82F4D9FD;
	Wed, 21 Feb 2024 17:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b="FpjNgQaB"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9EA82D9E;
	Wed, 21 Feb 2024 17:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708534937; cv=none; b=CYK6/RQ+MwmvZobH3Add63+PkJiDEMODdgJwPSN3ximJEvY4sastlYIZgW9p2oQ9ErpAPXhwwO2/ckTdafEWeCkJl5ucUxEUhybX/pAh0dNqcG3DgWGC00fEEdAEZP4lTbH7KBtgGIwudhe7PRCJRg7lxX0IkBs7qa/FccHaiUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708534937; c=relaxed/simple;
	bh=jo1YNSt/j/OZDpBh6SK+QccKcB0PIW2wS3FQPNZWkl0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=qkxcZYyBozvjzsjgw4+4+urYwtn0FLEWOn8evUA2aM/7e0CM5mQBB/KvFH5oI9cxwhnLd3FrqFfzLpg1pYccqOZ3qSOtmwOPpwhtldlaJS7ge7ZgdtqguvzBJMwDavpfdNztdTejl1svEQ8nW5QKo4EWA5BHObj+AmvqlcA5lpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b=FpjNgQaB; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1708534932; x=1709139732; i=rwarsow@gmx.de;
	bh=jo1YNSt/j/OZDpBh6SK+QccKcB0PIW2wS3FQPNZWkl0=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:
	 In-Reply-To;
	b=FpjNgQaBRudSSH376FGJ/6I8jfj+SBWGJeNeNbh0ROithsLJXIc2OX4cv9nYUFkT
	 rdTEyYK9TsxiibhX+d+BvvSREUAnFalEcQTF78h+ZH4F9n+UsQeVAkWj40+pTxPE3
	 tr5rtzQCyiX1zNo5eQH1Gqsl3m/qya5VlBLJuEWgkfqStOZIE0RjpDUkGLVPSs6Dh
	 ckQQAKULtsBa6vyIfK4ePX/NjPbKyk+IZW7XCEMKgTqbIBvQ1F7HWNPdeK+3oXl6h
	 +og1z88JjRps3FUovudhjfzTMNnZDY4/xDSzeqf13xKDZU+NIfEcOFguCmJNeodtK
	 VhTxugQ9JPXUINnJeg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.100.20] ([46.142.35.10]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MNswE-1rJ7Gu2mm8-00OFr4; Wed, 21
 Feb 2024 18:02:12 +0100
Message-ID: <720ce42b-fce3-457b-ac79-59ef23c59d9d@gmx.de>
Date: Wed, 21 Feb 2024 18:02:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.7 000/313] 6.7.6-rc2 review
Content-Language: de-DE, en-US
From: Ronald Warsow <rwarsow@gmx.de>
To: Luna Jernberg <droidbittin@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <ed9e1bca-d07b-42fa-9ceb-d0eef3976168@gmx.de>
 <CADo9pHg2jgYqE1qxpV40E6GHL1s+G+mNm1JCcB9GgA-4XM59+w@mail.gmail.com>
 <2cc27421-8791-47bd-a3d6-83188332ad3c@gmx.de>
In-Reply-To: <2cc27421-8791-47bd-a3d6-83188332ad3c@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:A1SeL7uzXlgFRWUN+SghY9wXJVvvOf4RombKteAXFZQkduleSAa
 a+QPuiKTiO8UuhklloJUYmK/CYZVwPBGYoo6mbRIQI9xDUzCb1+w2Z+XT1Kp77yA/uv7W1b
 yAN0sTRIgVf8ya+WteFkNPf55va5jTop8dGbR9uxjNZ4rl8t5/NwRddxE2TTZ2avyDAMNtj
 FAEZHy1Xz3mYr41DnprAQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:yRHQ4O78brI=;nuR89hUUzWKw6JD3lJz114oISFf
 d3AQbwDzI/9c1k69mgGINRPRQG17IpwZoftJMh4+CpFNj0+ogifkgWLf8IwvMhVWpQmKeoJ4y
 XcDC1B6rmfWux3S6s+ELFk45KFjO23UEm/gTlLpGbAQUBberSVyvVb7VP5tDlYMlMWCv99w1+
 8ST9Wj//kPMQqyEQ1cV4LRjeL4wDrTsm9958cA7R0NCQDUocP6CqbhqeJG8ugWXmFSXUKmBPQ
 u8mFCAWFEhq/k6Vsqas811WIIVG7zDyatd9I7WnWymIUcc6uAcO+fxphMuPJG03NLrYjQY3fI
 03Nm0V/C/MBnyDI+de+KLQqKRTaX/GXOp+dKkEf7XVMrPXQomFTA1C2T+u9mEpTSN5tsd3qua
 HayfIUZzMEpxA5JuTi8ZxknwA/W+NbCByldb4yuKm23TOqQoXCXR8i/xVgqub2ecNUbaikfxf
 QxepkyHTn35YxEcbTBcjIrHX2CXCTdFeZJJE6ISQa99xjDkJ/gm+v6M3pOD2Q+vmpuFZuyW1S
 Xz1U5SfPZTz8yuPLudGTpR1CNCHNNeoVMKiArznRJydGA37bdDZSPO+8SpSISRtNk8Xu34wLK
 747yFXrnW5eDxtm+2KZ84VvNEjlFkOvGs9X0Rkcmz7ihY4DTf+y8r5VV2n9uKcov848FLjgQl
 W40wp2x5VLghpc866xhPzPOBIs+PyK7AySCLv7MOV+droQehx54NBdZOXXZrKuDEYHHvsJ0wV
 ncAdNZF6crb716hqYcLheTRJWMsA+f0YKKOLcEbsISp4/g21ki3kw8l5V9oBV4SFBK8ap8tgt
 4k7NQOE6d9h+wyr4/tDaiT8v+I5+2d3m1JV8MMxGpyWDg=

On 21.02.24 15:47, Ronald Warsow wrote:
> On 21.02.24 15:25, Luna Jernberg wrote:
>> Works fine on my desktop with model name=C2=A0=C2=A0=C2=A0 : AMD Ryzen =
5 5600 6-Core
>> Processor and Arch Linux
>>
>> Tested-by: Luna Jernberg <droidbittin@gmail.com>
>>
>
> du meine deinem Scheiss Top Posting immer !!!
> :-(

s/meine/mit/g

