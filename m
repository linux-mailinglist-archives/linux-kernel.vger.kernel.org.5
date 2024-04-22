Return-Path: <linux-kernel+bounces-153514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF0A08ACEF8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 16:07:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F0C72824C0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 14:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B5AB1509A1;
	Mon, 22 Apr 2024 14:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=linosanfilippo@gmx.de header.b="XPffQVsN"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98CEC14F9EB;
	Mon, 22 Apr 2024 14:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713794858; cv=none; b=Ux3fEk/AxkweFNj3Fqju1jehtS7ceZWEvq+FoCBuSmJTbVYio8sxXoR9rFM/Jz2cIMmR3wo2g7BHx9TLUwtK7Q6alRXMNXQErhitPucNCu5FqhnO8DIvf+WW4pz/43RyxP8w0mnXRnCTfRDNdPWz5igRJ9hjhHrd5jWuuqX/d2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713794858; c=relaxed/simple;
	bh=ve02Zx0DBJoDKc5rI106J1bI09M6d7pR7u1ui5cF1Ww=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gLEoVImhq6UxgdAkUeSrpuYZuUhleo+3EokW00P8vTbbTh1BfXsHWKNXVUlgpbW9oBNB7mIFcnfCB5W80ariaD2kLgE5okn3L1COVc1/JAHyfX8IUa+47d3hVVfQAZk2+e1lPoP3AOpeMw9WP0Fdz9AUSkP+x/C0xUjBROr47tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=linosanfilippo@gmx.de header.b=XPffQVsN; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1713794816; x=1714399616; i=linosanfilippo@gmx.de;
	bh=ve02Zx0DBJoDKc5rI106J1bI09M6d7pR7u1ui5cF1Ww=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=XPffQVsN1ZwZceb8b15PHbHXbdJbq7GQQYaM21EzNI7U0se4CJxsrSIgZs5Wnnh0
	 Y57qMr4doz/BoVWyFoF4THKGViEL9NzL0YBJIiPh0WM5T2rTc7Joh0RslWoNP1kUE
	 M0aUHswqo7xuQhQFTxDc9euJemgPj2q87SL5Hq3MuMOXwtIIbfa4ZZlx1SM4pbdvY
	 CycsCJWdFrYdnHQDuFC8ey0c96L9SyPV5vDNC9dVaBVM9p+2upcbF+nvF4a6fJ90+
	 0gUs0qHbOtBvxrdCg5D9qywqbEMQumv1ZJPzO9xgArkwOvueyBpoyOoXvDHYwwQsu
	 y2Z7GgX+EUjlvuDKXQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.2.42] ([84.162.15.238]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MAOJP-1rrzM43hZT-00Bw36; Mon, 22
 Apr 2024 16:06:56 +0200
Message-ID: <64ce1c2e-4771-42d9-8ffe-9d03b09a61d2@gmx.de>
Date: Mon, 22 Apr 2024 16:06:49 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/3] serial: sc16is7xx: announce support of
 SER_RS485_RTS_ON_SEND
Content-Language: en-US
To: "Konstantin P." <ria.freelander@gmail.com>,
 Andy Shevchenko <andy@kernel.org>
Cc: Konstantin Pugin <rilian.la.te@ya.ru>, krzk@kernel.org, conor@kernel.org,
 lkp@intel.com, vz@mleia.com, robh@kernel.org, jcmvbkbc@gmail.com,
 nicolas.ferre@microchip.com, manikanta.guntupalli@amd.com, corbet@lwn.net,
 ychuang3@nuvoton.com, u.kleine-koenig@pengutronix.de,
 Maarten.Brock@sttls.nl, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Hugo Villeneuve
 <hvilleneuve@dimonoff.com>, Lech Perczak <lech.perczak@camlingroup.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
References: <20240422123801.2695129-1-rilian.la.te@ya.ru>
 <20240422123801.2695129-2-rilian.la.te@ya.ru>
 <ZiZcyhoKRgfteO5d@smile.fi.intel.com>
 <CAF1WSuxPmzWYhCQU3tiA_GYMLowxMuvEJWRv83atithv8NCRxg@mail.gmail.com>
From: Lino Sanfilippo <LinoSanfilippo@gmx.de>
In-Reply-To: <CAF1WSuxPmzWYhCQU3tiA_GYMLowxMuvEJWRv83atithv8NCRxg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XW0kg7CnrpDJpSfJCIc3DEYwd3644An2+y7KxStItsSe+Mw81ex
 BHjDh2i8ok/uu8nFL3H9gNz0MjTc4ImDX6jGgZ9xuUaxL1x9dg4I4fcY0j+Yq2l0cLKnAas
 mOVVfo4pN+RCVxlioCoT7u5m/vIhOiu75r1ogDLeSEVpTfDZopSnmjfO3HtOZT642t/1p/3
 QtOcsX6gCjwzp/NNmzhpg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:E0kV41HQXSw=;yFfTPRk3CsiuWltp8fUOsYrIhQu
 8gcC2Ao++R+zzBLGcDiuhWqrTsuiwyd+iASW6VnCMgTJX3wNAbZopbfqviHc42hdZceck6y4X
 6iWxOLWB58FfEEmEZ7kYl1TSEzBb3gPrG6IEdwuYsXukGL6uSOXsCQihaJdjQ2j37hr6FXG2P
 WODmapJ13KTCDZ5dlSfzRw7/0D/ySqeSerBRS86Qngxc3zTbKf4dmKszuuh28/9VwlfxlGMhE
 KwKZSsldkEp6iYFPva3zZVS46+98US0Zcl3lLhBLAqbRXaZ6OS0eKvLxeVGPV1itAnhkN8Jik
 vFfmlODUwVEYF2AggUsvHrT57jsQbGxbMnZiLypsushgnaFS5s2IZp+X5Wc92etEJ66CC2rHE
 dlnixO548jD9d23HebysuGcgEIuCWXzBIC91lqNvSNuhm2tafuhq4RRtWbVMmeGjqW63FRR4V
 tg896Z20qMN90+hrDL6wGS8Yk3SxpLvW5E/M4GwreOZneyedw1s4Uwfw/X3ukrtwF53z0CWx5
 ntb9SXISLa3uqa3LGItL0v+U25pFI4jGp/cdgOisu/cpqBev7cNvq7txMhRByMGrJmhw15roL
 21oQEL7u51TIKFrT++6QPINv3CJZVUgCYY/JP0D/ZpR6zL9wVV0DptKwsnmuMtO8GLZvzc3/b
 0n9Yi+HD3xFEgPsQGCffUSYikZdT/6ou0jds4yXanQpUyeyVAFJ03mfNtzLdadVXFWCIiIAlE
 f1AgCdqtRSGWpJfgGImxWCir7E1LdqVBjD+yrQMsfD6PbHQxGjmD7D4kyElxNPTjE3tqDhKak
 ihfuivw9MJkYIJZzKB77buRUQ5UHkBRN1FJ4LvUuYa5Zg=

Hi,

On 22.04.24 15:20, Konstantin P. wrote:
> On Mon, Apr 22, 2024 at 3:56=E2=80=AFPM Andy Shevchenko <andy@kernel.org=
> wrote:
>>
>> On Mon, Apr 22, 2024 at 03:37:55PM +0300, Konstantin Pugin wrote:
>>> From: Konstantin Pugin <ria.freelander@gmail.com>
>>>
>>> The hardware supports both RTS_ON_SEND and RTS_AFTER_SEND modes, but
>>> after the commit 4afeced55baa ("serial: core: fix sanitizing check for
>>> RTS settings") we always end up with SER_RS485_RTS_AFTER_SEND set and
>>> always write to the register field SC16IS7XX_EFCR_RTS_INVERT_BIT, whic=
h
>>> breaks some hardware using these chips.
>>
>> LGTM, but I leave it to Hugo for testing and other comments, if any,
>> as I don't have a HW.
>>
>> Reviewed-by: Andy Shevchenko <andy@kernel.org>
>>
>> --
>> With Best Regards,
>> Andy Shevchenko
>>
>>
>
> Andy, I need to do v7 (because there is a missed fix), but Yandex do
> not allow me to send more mail( So, can it be sent next day?
>

Please add at least the linux-serial mailing list the next time. As far as=
 I am
concerned, I was only aware of this issue because of Andys response which =
added
linux-serial. Furthermore shouldnt this also got to stable?

Regards,
Lino

