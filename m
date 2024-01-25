Return-Path: <linux-kernel+bounces-38097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A569A83BAE6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 08:42:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45F1E1F2595E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 07:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AADCF134AB;
	Thu, 25 Jan 2024 07:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="hT6aRS7r"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C247134A6;
	Thu, 25 Jan 2024 07:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706168553; cv=none; b=H9JGoaIRQLIeoXdZV+FhQDh+D9FOIOFOq4fU9rYque43ckSOegkAC7FhDOex79Sg2fOHmaKv50Rta6xkecFxpPOsCVv8AjvPZIrRTRelrJgCZSYJEdYsD8VkhtNTcL9O3R9ARd249UJp+HeS3yfGZqLiA/8P+7TrYrMQPvHOFH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706168553; c=relaxed/simple;
	bh=FS06XLbVUpyptdWZN0ztRC3/JzSUCcsW9mTaH7hlj4E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=suMoWQ95DNHwlRVLdgguUG6/US9m/O+OGwUunbZ3DfI3VKodqfq5oLta8e4U+bIksFaja5L9Q6PZ/nuDNx4/8wk2hqp3GN1W2HJdO+UCBCX8ec0bk+yPUHYbMygxR7EAYUtgyTg+HY0ze3PNG2lkWrW/1cJ6J1qaCZlAlpuj4tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=hT6aRS7r; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=s31663417; t=1706168511; x=1706773311; i=wahrenst@gmx.net;
	bh=FS06XLbVUpyptdWZN0ztRC3/JzSUCcsW9mTaH7hlj4E=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=hT6aRS7reMlz4gaK6u+q5kIKo6h9Gu9ei1ol6dMGW95Gi5H20BybLRGlPivTGnBo
	 0KLeRf/uKdnCbAA/yDxbncwDUtwEAopp35UCfxdPg1mL406dvoVfEFYt8MQxKhkln
	 mkEhGcSwuRHqiFWiqpjt8/1KBAfdW+3Ij/SajFCAzWMyfjzx1NKO/8do5SnWM4oV5
	 J47Nfx/ozARSOVnaWudKjKE/uzzugoSGfFfM+I5BsZXdTyQ7eXSEIW0N7OdPcTfzT
	 Dqu3EodeyW+iiiy1E/lUaCYOpFC/ntgv9OEU0sf2CVSCg9abPVOLyBarW8lg02zIl
	 hXIZ0FchvR4kpq8++g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.167] ([37.4.248.43]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MqJqN-1qgOSK06N9-00nSW1; Thu, 25
 Jan 2024 08:41:51 +0100
Message-ID: <f35363e3-55f4-4489-822d-049881c27e93@gmx.net>
Date: Thu, 25 Jan 2024 08:41:45 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] arm64: dts: imx93: Add phyBOARD-Segin-i.MX93
 support
Content-Language: en-US
To: Wadim Egorov <w.egorov@phytec.de>, Mathieu Othacehe <othacehe@gnu.org>
Cc: Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>,
 Li Yang <leoyang.li@nxp.com>, Primoz Fiser <primoz.fiser@norik.com>,
 Christoph Stoidner <c.stoidner@phytec.de>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 upstream@lists.phytec.de
References: <20240122095306.14084-1-othacehe@gnu.org>
 <20240122095306.14084-4-othacehe@gnu.org>
 <537266fe-0bf7-4208-a9f3-ae27f462c6ed@phytec.de>
 <85fe8c8b-ea08-4f24-9a06-33a5678c1a0a@gmx.net>
 <7944bd80-32d7-4ac3-9c0a-806394262f1c@phytec.de>
 <08ef805a-b041-4db0-aaf7-51d5d06596ff@gmx.net>
 <008317aa-4dd1-4889-8c64-5e4396d83931@phytec.de>
 <47c79a0a-5be0-4ee8-87d4-fd03809a9664@gmx.net> <87o7da4zc1.fsf@gnu.org>
 <f2fcb4d4-b1d7-4d82-a3b0-d06c0ffd906b@gmx.net>
 <13f6edd6-f3ae-4e32-88e9-03355d78153c@phytec.de>
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <13f6edd6-f3ae-4e32-88e9-03355d78153c@phytec.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xf49PKOcDA914fWukdGhtya7hcQZw77jSf8Icz3Y9DDSxO1roE9
 ygKQs1sPP1kTZU3n5xR2V/92w9kEGsQp4Y9Aby2eUvDCfNwh9uvf80DY/sHVY+d4BiImIuh
 PQKm+o3u5AuwUnitKqq91oVjtl37H2ai2/J1WkjDfVPt0DzIdhEZpwhd43WVLbHcfwPnthi
 /OC36j8AQuxHalKovgz7g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:pGxbpOB9Efw=;/O8Puk8jEbr5eyoAafpe90FCCVB
 NptTLXr9RxoHR5f6wF7DKc5QnnSVirM5sFAQvTKjopoCOt4pcD2w+xA5nRKyNKlZagIcJ2My1
 BAJ3hHs3rk/U9QyAwbgHX1wdCyLuNSjqtRTyJumViYfO3yFsfdWTZzog6taKPz3E0xfjgG50k
 ZvQpXDqEfy9n2Ttro9vkDdOXtJjVgjw3z//65Btj8Exd/54pHYemxGpWv1+lF1xLac/XLx2Yj
 JSAFSSRJILqzKxPFEJa8I/5xN2nb/D5IcoIdevPfhXS6bom0Cd7eedPdwv2pc3tTiCba88LUW
 4rUBRtuPd6GN3h4T4t8D7x6xFAcyPfZlUF8/yLvChgauoTryFK4Lk558d7WlUXX3K87h/nTqv
 uvV1V2CKiR4OYQ8vWudnaAdrhDdy2wdAYOZeNTAZSbkieMg0XWNBbXUqmV/O8W7uBYhLxEKfP
 G2YNwpqayE4x8GD/rLCgPMXQ5a2reGpOiGJ3NNFEHekqI2gtHtrbe+xwsEILxeof0Uy/eBRB+
 p9SBdjRYj5y6cV+OrNnr/Ihv6cCdLVK9jB/psavOAbAgaYbi0gs+0cvAV+pDxoV87MV8t/9ra
 SwqJ022IhL7CZyuriMjS+asEtGmJEtI2mx5XMn0qslwWEui6Dkbvg/6pPE7o54qz03yKmV7Df
 712Ct8q6EbgCdy5j8OvBiZPDvf3LSrPr/2AyZVMAffcwfXRnoJBeCP04XiY3AcHUXu0QxC/bq
 nIlchWIF02kUs3U2SujmwT4FYL65IKF5Qk8ti0Om2IEbk5PYFAOh3VecfN7wQxJuBBwx084Lk
 NBcJDDvxIvyfi84871mY8R+TkV4zb/SQeMyV+oDMzYyLfTF/9FhM/kjHCwOsW2pduBBYa9uQt
 SOLqJfymJR+tNxK1mPj21nwB2jOhHNPcJw5NXKLGi91e8fpfXiF5+grNwX8wcrpZH+UVHHbpF
 88ZiZ0eKGU4gcdD7QZXaGQx1Xj4=

Am 25.01.24 um 07:05 schrieb Wadim Egorov:
>
> Am 24.01.24 um 18:28 schrieb Stefan Wahren:
>> Hello Mathieu,
>>
>> Am 24.01.24 um 14:48 schrieb Mathieu Othacehe:
>>> Hello Stefan,
>>>
>>>>> Defining line names should be fine. But I would still prefer to have
>>>>> the muxing in an overlay bound to a specific use case.
>>>> I'm fine with this. Unfortunately Mathieu dropped the line names in V=
5
>>>> today :-(
>>>>
>>>> AFAIR reviewers should have 2 weeks time maximum. This was just 2
>>>> days.
>>> I am sorry but it is not easy for me to deal with contradictory
>>> input. I
>>> chose to remove the gpio-line-names even though it also seemed like a
>>> nice addition to me. The idea was to not interfere with Phytec plans i=
n
>>> the future.
>> tbh sending v5 before the discussion between Wadim and me was finished
>> made it more complicated. Please keep in mind that some reviewers do
>> this in their spare time, so a response could take some time.
>>
>> In this particular case Wadim and me agreed on a solution, so no action
>> from your side was necessary except a little bit patience.
>>
>> The reason why i suggested the gpio-line-names in the first place is
>> that users doesn't need to care about different versions of the DT file=
s
>> (except the downstream one). Changing the line names afterwards leads t=
o
>> confusion.
>>
>> So before we discuss on a v6, just a question: are on the X16 connector
>> just 2 pins muxable as GPIO? This is hard to believe.
>
> In theory you can use more of the Pins as GPIOs. But at this point I
> should mention that the Segin board became slightly more complicated
> since it started to support more SoMs with different SoCs. We have
> routings for various pins to help with the compatibility. So the
> naming in the schematics is not really trivial. And IMO the dt should
> follow the naming of the schematics.
Thanks for the explanation
>
> I would prefer to go with v5 without having any namings for now.
Okay
>
> Regards,
> Wadim
>

