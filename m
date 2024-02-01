Return-Path: <linux-kernel+bounces-48629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB56F845F08
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 19:00:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 063201C24AA4
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 18:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F69C7C6C4;
	Thu,  1 Feb 2024 17:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="q+Fs1l+E"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D493782C9C;
	Thu,  1 Feb 2024 17:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706810394; cv=none; b=RV+ba4BHQ7acpkSAbCdJZOxXXmdudIHvMgRqEl1s2F8wQwBtmobn5It6TV+2iACuJOPW7bjvNJgiz/kGJuDTsptZ/I8rvZ1GXwaohXrauKgqOE8ETQ+9vegMlQy6btqFm3gVnWRWO6czEEBgNjk41Trd0HdOI42S0O6eXnIrhGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706810394; c=relaxed/simple;
	bh=rIrh059PrpeyXbaJr/t3/vTFAkpJFqhcp54WmRwO6II=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=smrwhwVESSMibG+E4mEQjNS2pM0KojKmGH4/Z/BV4ttyjlqwgTAZACp2BkUnjTPMsQvV8W3zPDM/IvpKDnuyWW2Fir8AYi8Wsxsonj6W8op4QssMXoUATUVc3wrgwYReQuy8xzbgjoevipdXI34MHX4gU9/H+yj3+r0PU03UIzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=q+Fs1l+E; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=s31663417; t=1706810378; x=1707415178; i=wahrenst@gmx.net;
	bh=rIrh059PrpeyXbaJr/t3/vTFAkpJFqhcp54WmRwO6II=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=q+Fs1l+Eh6RRfby/tGba/XuicnWTiMYKuAnqLqYVoVWLCTaFlGRCQymVSHD2GudZ
	 mrcLBA9SuVwFDw97oXl7dvDU7oKCkEj8zU0rISnOvcA9xOgJ131ns9nc3klkk9ZrS
	 sPaif2Q8U3RjDQ9yO2c/ynGFIp8/tGOWo+g2uR9vghLWUG7EkgeigeeLrK+5F75Tb
	 djXXf1PmxfG4RzvMuFThjxqDgOQUwAJpHnNorVVGUZWt/qMXkZwJpt+KHV193Dagw
	 RJvZc0jcUKz33McF9x9WiqvjsxdWiqTfuEl3bWr2c4LZpxWJYBXn+JBMulv0ZshJw
	 PSBuqRWFdQ9WzyF4TQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.167] ([37.4.248.43]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MWRVh-1rWv5e49AB-00XpU5; Thu, 01
 Feb 2024 18:59:38 +0100
Message-ID: <aba9744f-977c-4306-9cdf-104800344b5d@gmx.net>
Date: Thu, 1 Feb 2024 18:59:37 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] serial: mxs-auart: fix tx
Content-Language: en-US
To: Jiri Slaby <jirislaby@kernel.org>, gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
 Emil Kronborg <emil.kronborg@protonmail.com>, Shawn Guo
 <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
References: <20240201105557.28043-1-jirislaby@kernel.org>
 <20240201105557.28043-2-jirislaby@kernel.org>
 <3935b841-77b7-4265-a727-98a358cd56be@kernel.org>
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <3935b841-77b7-4265-a727-98a358cd56be@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sXH13v5sOclhojjCcbDB3ZiwD232n6qyAlzp6uIb51/p5gQDxPC
 /LWgrH1BsvCbGKHIdMZaebaawSvaK1uVuCyVoE7dPDCdZzoPzRcz2GX7FoBBSEnFoYAHCVr
 7bkcBbchWMzIp0FP49HIxL/UcxiFi2oqknqpKg54uP5QOBeWPEoqQXvRK2LLGbKmueE4yO8
 Esp96CrFy6HKm2I/SgNlA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:0cadcR9eHiw=;Hi1bLUCBqnOjcfDicUxDZLbsY1C
 hEXa/uBP8PB/Siux9/71IqwlWbG6kvNmigcI2Inq+ONUGkdstpHWVVOEobmT9qVTlcjR6zWNB
 DgmJeVtIQa6ywrslbKb0zGN2ZU/ffNXzOqqjQaoeNImEKYjpzFhY5fYTg5dx1xuve0gKdNQMI
 JrzEMcG0ONkP32xkh2noS7ZPjG9NGk7RHN5ZGYfSXEO8pMm17/m8Aq707ptZGQmNONUCOoA3k
 mZ4Xt2YxeGG+j8uEg4eTscFVKuQyOT8dWB/KWpqUjkSgLpSVZsX1rdtiSbZbE6c5vzi4E/j6k
 iU7lo1naqFgslX/f59L/gi4B5ov3YRi9F96BCltOkSY/IiVBd8zgT/gizf98ev1//7vRxT+mh
 qK9GhbL5CRrrMRoXKnDHbvuhxmUTME8uzm6g5XFWq0w8O42HIrWG+qm4PG4M5RrYxSKwkqaOe
 F5PWvRlVbqHBGqAsWtmfx9kS6IQSMhzaGmF107Bi3WT4XArFjP6biNX5+f1i+HZOkvXB43AkS
 pEfQnXEBcIdd8As84L4SQF+VFNGIOpAoV2Tt3NwbeBCL3fkKnByj6R0Xk9gHs3b4xEMweAZrK
 waVTliagtJBhs3c+cBpVosA5usS9pXP/cx0OXmDa5nGUqx4PIeYA0t8V09ihUGRLd0Ek+aKiX
 pWra6O1A05UEiD/dQC6asRx7KLZ6p1RPwJMspdw89Sx/lDU9Bqxz4y6C+4/8pXuo3JXYg/NyB
 Vt+o9iZksm0C2lNcwR9jFS3byiiFntyycUFDEg3CAJd7T+stjlzhJ/2Y7WLxZx/ArEM9RPbzQ
 OfZRMDwxTZW7KpFAo2aZVJBDJxnbRWimK4UTbqK2uNWr4=

Am 01.02.24 um 13:05 schrieb Jiri Slaby:
> On 01. 02. 24, 11:55, Jiri Slaby (SUSE) wrote:
>> Emil reports:
>> =C2=A0=C2=A0 After updating Linux on an i.MX28 board, serial communicat=
ion over
>> =C2=A0=C2=A0 AUART broke. When I TX from the board and measure on the T=
X pin, it
>> =C2=A0=C2=A0 seems like the HW fifo is not emptied before the transmiss=
ion is
>> =C2=A0=C2=A0 stopped.
>>
>> MXS performs weird things with stop_tx(). The driver makes it
>> conditional on uart_tx_stopped().
>>
>> So the driver needs special handling. Pass the brand new UART_TX_NOSTOP
>> to uart_port_tx_flags() and handle the stop on its own.
>>
>> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
>> Reported-by: Emil Kronborg <emil.kronborg@protonmail.com>
>> Fixes: 2d141e683e9a ("tty: serial: use uart_port_tx() helper")
>> Closes:
>> https://lore.kernel.org/all/miwgbnvy3hjpnricubg76ytpn7xoceehwahupy25bub=
bduu23s@om2lptpa26xw/
>
Tested-by: Stefan Wahren <wahrenst@gmx.net>

Thanks

