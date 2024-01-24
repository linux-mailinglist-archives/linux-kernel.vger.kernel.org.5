Return-Path: <linux-kernel+bounces-36908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A2FA283A884
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 12:50:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DDF82B2BC41
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 11:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30DEC51C2F;
	Wed, 24 Jan 2024 11:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="m/eYrZ3J"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4182250A8A;
	Wed, 24 Jan 2024 11:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706096922; cv=none; b=KzDlMLNjM3/z3bch/oL+ikNm2RCU6Yi5+kWKrRBNcNT4EAAOoEoa+LFJEmy1O9NchnFtP8KyGSLAuF9qTcDCFBECwaoipB4y8vF2D++ybtp/vASUrUusxNBt0hzSEyIDbZ2bETTRh98Sv0Jk9rQRJ4AZ6UTuKjWqR3b8e67keFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706096922; c=relaxed/simple;
	bh=MBGq51n4k5tu2zEso/Kfv3zeWxFZhKEtwDi8kZYYhgA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LK2x5j6tUkIJmuFSl3hnni6tGfFDhJUHv0helYerPVu3zdgveyjUcjDz5pliUzlBxY7HkvIaLxzFV7A2E2hT6zh2AnEX3KQhaSQRjkLJDKKBvFwRmsQm1jVCGS5XKSXdqW4lHVe9epFGjDnYMx4rI7uZZWdM0yootkVlPeRXSaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=m/eYrZ3J; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=s31663417; t=1706096902; x=1706701702; i=wahrenst@gmx.net;
	bh=MBGq51n4k5tu2zEso/Kfv3zeWxFZhKEtwDi8kZYYhgA=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=m/eYrZ3JQYCDHbdHp5EU37fzcvr7dqLkeOx+WMCRFn14Nrbwb9S0mhTMgSt+EkW6
	 fZDZl+6tZNohK/F4S809YHlree85LtK6h1GY6sFiwcn57adxE/iJJ5X5UaIhnkXrE
	 +28zQIzrzmqcnFzW0rAZfISMuo1hTBBnIFFKP/4M260520u1RE0HaC1ysfUDkGxAx
	 FT7d3qj3RaFQnwvE0urMLBqBG5YWlI+7188RneOWlIL34Cspl0RWLrA8H829zF7xr
	 r+TGyNcxxbLpshinTEYPPfzV6ZhQf68Q5r8ABvck73E8oqNuMP+wWtoLCyK2SVmpP
	 lumrOrcHYgV+T5O6tA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.167] ([37.4.248.43]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N6siz-1r1fsP2i1X-018Mfh; Wed, 24
 Jan 2024 12:48:22 +0100
Message-ID: <71426744-7223-448c-bd5b-ff786c5f8e65@gmx.net>
Date: Wed, 24 Jan 2024 12:48:21 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] pwm: imx27: workaround of the pwm output bug
Content-Language: en-US
To: Francesco Dolcini <francesco@dolcini.it>, pratikmanvar09@gmail.com,
 u.kleine-koenig@pengutronix.de
Cc: festevam@gmail.com, jun.li@nxp.com, kernel@pengutronix.de,
 linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
 linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
 oe-kbuild-all@lists.linux.dev, pratik.manvar@ifm.com,
 s.hauer@pengutronix.de, shawnguo@kernel.org, thierry.reding@gmail.com,
 xiaoning.wang@nxp.com
References: <20240103103421.GA3758@francesco-nb>
 <20240103110200.1018-1-pratikmanvar09@gmail.com>
 <20240103122005.GA3347@francesco-nb>
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <20240103122005.GA3347@francesco-nb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rwJl8DHAumo4SDx3Jesd/2R8eqWN2kGR0ljliIKNuWvjhijl3Pd
 k5LxJeQZdrrRrV7BFQL1oddhIxKGqKTir+8OWK1aSOsFfylZJ+IZBfrPaQNSLyRS7Djp6sj
 FzQrCEb94+9vnGjq5SLlYZKeUviDG0jRPBBvOGzz2fb4H1xM5zNWEQYOdKnbRFj4Vuwh02k
 bD3ktbFoHsg8cuAc1ksFQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:FpBdyYjUWIo=;jFb/N0V408yet10BGR49UXehfay
 FudKxEWyxwbw3NNEzeMb1N/TVWJUmQV4dZfffaXO76sdWA8FvJZSB+0d4L5TSRbEccHRpmyWo
 viIrbtGCxK3Sutk1uEdYWsoIqDNP+tfTNAuPvySvUn7nWuQpzgBdQNPXVfi9KnfaiUswvpNdJ
 zuzy/AeEi9gfWidRmizzULC/keCwxb2Bd+2DYWnwxv7q3xueD2D4OVV7lkC49HA3wiwMnPqhP
 BtkEsaXw6aJAgGYeQ2qS45B8OOi8p7f+uEb/5dmPPrNfWLvJd6tzyISnFVT4NjMxJq0rw/5Bp
 cneQYp73tFiX6WbDGWU2RLR7nmX3MDLUWTn3Xd7tCIILDWsMvFKIdy6E8LHv1FOsOqq+P+A1O
 U0Iitj5isxkf71y+T87PMfNgU/loe7Z8tmdXcUGqRLUevKW3oo8eZEm46TpgIMYbi/WJ4Y3dv
 OLQ6hiB7Vx8bfBQq+IjqhF+idw67whxd31jtj4EGtZa/PYcDDLi0jP9YIF18ZPq+Py5wqDyYW
 T6VZYoyj3KojJLRn0vJMXEkvdoXpEp80HklJ/eS79G1OQ5XyyIjUzDd+rPGo6HbTLXwy9Hl2k
 TW+jfBKiOJSmeuculO+DIREzlPAxKy5mZN+jkqJ3MQNcfSihqVQyYsTaZ46z7mu6bOtfZEUux
 0jLiO4epT4OTMtEgokXfRlXd15eAnlVQJ4sHXJwKV5AZqtH10HmwPUsol+0rm91MAYSD4f2Qe
 LVxgfWBMkWj+eLaEBHCoxO+s5wmbZ4WG/QN8KXBzDq3lTkc2nGueDKv3KT0MbedBMbepu26be
 Dr0KLkcpUlLVHs4Y8E2fLPhkM8KyNE5vCLGGJW5uyEw7km0pX/7XZCsz3l0xo7bqtutIcwD1u
 /GEGbmZN8TBGe5R3+68ENQkQgvTTPv6qfjttVVg5G2SnfrpwGJ8ewG2FAlsBG43/+X4zpHkaE
 MX9p91fmephZdWeHAL3vT/G+Q0A=

Hi,

Am 03.01.24 um 13:20 schrieb Francesco Dolcini:
> Hello Pratik,
>
> On Wed, Jan 03, 2024 at 04:32:00PM +0530, pratikmanvar09@gmail.com wrote=
:
>> From: Clark Wang <xiaoning.wang@nxp.com>
>>
>> This fixes the pwm output bug when decrease the duty cycle.
>> This is a limited workaround for the PWM IP issue TKT0577206.
>>
>> Root cause:
>> When the SAR FIFO is empty, the new write value will be directly applie=
d
>> to SAR even the current period is not over.
>> If the new SAR value is less than the old one, and the counter is
>> greater than the new SAR value, the current period will not filp the
>> level. This will result in a pulse with a duty cycle of 100%.
>>
>> Workaround:
>> Add an old value SAR write before updating the new duty cycle to SAR.
>> This will keep the new value is always in a not empty fifo, and can be
>> wait to update after a period finished.
>>
>> Limitation:
>> This workaround can only solve this issue when the PWM period is longer
>> than 2us(or <500KHz).
>>
>> Reviewed-by: Jun Li <jun.li@nxp.com>
>> Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
>> Link: https://github.com/nxp-imx/linux-imx/commit/16181cc4eee61d87cbaba=
0e5a479990507816317
>> Tested-by: Pratik Manvar <pratik.manvar@ifm.com>
>> Signed-off-by: Pratik Manvar <pratik.manvar@ifm.com>
> A very similar patch was already send in 2021 [1], did it had review
> comments not addressed? Please have a look.
>
> In general please refrain from sending a new patch version every other
> day, while every Linux kernel subsystem has different rules and a
> difference pace of development, in this specific case sending a v3 just
> adding your signed-off-by without allowing a little bit of time to wait
> for more feedback is just not sane.
>
> [1] https://lore.kernel.org/all/?q=3Ddfn%3Adrivers%2Fpwm%2Fpwm-imx27.c+A=
ND+b%3A%22Clark+Wang%22
thank you, this is very helpful. Unfortunately i don't have the
knowledge and resources to continue this work.

@Uwe It seems that you were able to reproduce this issue. Is it possible
to trigger this via sysfs and some kind of script?

