Return-Path: <linux-kernel+bounces-16333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB26B823CFC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 08:50:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85CB72874C4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 07:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D81DA1F951;
	Thu,  4 Jan 2024 07:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=svenpeter.dev header.i=@svenpeter.dev header.b="WCyYGHfR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gxunz77h"
X-Original-To: linux-kernel@vger.kernel.org
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2865E1F927;
	Thu,  4 Jan 2024 07:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svenpeter.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=svenpeter.dev
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.west.internal (Postfix) with ESMTP id B62973200AFD;
	Thu,  4 Jan 2024 02:50:33 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 04 Jan 2024 02:50:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1704354633; x=1704441033; bh=oVCT/6mmwfMbt8/ULc2eXbjs5hsv2iyz
	g0YtDX0R8EY=; b=WCyYGHfRMlab7s0utl02nhZh6r6dBsdWHwlVg8kZ0pAIwwxm
	T359V9XICBCpAetn58aV9xqGiIY4cmQG+4d2WRjNFEru0Lo6Uu7j6WyNeZhbvvC9
	e9EJN6XRGTHVo+gaCeEnvXzu2t7Ww8VImNV2WxeLUebuui8UBE3/83WGUgZNLb0R
	U7ZkcMVN/7QY/4cjUusIosasJfHRyiaSJ58X5+S/SLSN3fcqkXqjQYaSFeeABY/F
	E88ng0sGDMyNVZKW2vEmaOqB8l/JFMxT+Dc7IpZKOxY6NqvHd0t3wU1KpSEymmj8
	GLtYzY4uuh89P3P6c9TmyRRj6+mXOPd7W78RYg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1704354633; x=
	1704441033; bh=oVCT/6mmwfMbt8/ULc2eXbjs5hsv2iyzg0YtDX0R8EY=; b=g
	xunz77hEf37PtaiC8VVWkxuW7X+7bHAlgaKElJQSszWvkVo/XxRGxqINTU7kV6Z8
	/k9n5IpP5cfC/ftDYrNPX3W2XgonJNQVWW0JOELW+E3mYkfx+S6UAus1cejes/lB
	OvBLzSZy3qWDOdpDWmd6MTuKpjUPf3y9KUXmdDT7LyVbpc9Xx65KXyfj9furtGVz
	fUF/cvTNJjJzvbrCAo8BPaJTF2UytIzf0L6AH+DmnLch2U9co3VrGRpGMYtM/xnB
	dOyWjyA0WzZXm4Jlkzavbj+o6rFyigw2+fRsq2UruJod1291tovdfDT8WCXQHJKe
	X27xM1QW7DQLp6eGX2m3Q==
X-ME-Sender: <xms:SGOWZWjQubEjL_KCPAWU2jYQtoww4mScEX5EhsdauSJd25nx1d39Wg>
    <xme:SGOWZXBIMTW9jIOUtmxFSDeDTHb0SYZg0rql6lB6-17NTSLMbN08wx-jaa4DOsoGg
    zjByoVa7jcom-trJVc>
X-ME-Received: <xmr:SGOWZeHPsMuvsSqH1xMLYVZvBwlEBLXaAJBsUmok7UN_rMw8b0Xeb1BO74p50AJIGBQPb2ircXHeJ2G-kN-z4yGJJMYo90ogl5kE5ZzXI7Xig-faoYU8lh-E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdegiedguddutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpegtgffhggfufffkfhevjgfvofesthhqmhdthhdtjeenucfhrhhomhepufhv
    vghnucfrvghtvghruceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrg
    htthgvrhhnpeffvdeugeegffeileegiedtkeetjeekheehhfehudelvdeuuddvleffieev
    leetkeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepshhvvghnsehsvhgvnhhpvghtvghrrdgu
    vghv
X-ME-Proxy: <xmx:SGOWZfQUXJtXe3brtCw-VZ1XNlc8kE8647VWd9eUcsMqBYUWE6W4Ug>
    <xmx:SGOWZTzoOwaej-L_CEbl88mkaI4joCemkQQlZhOeyYlS4Lwf96ak0A>
    <xmx:SGOWZd5lXhq8wjB_zeklwGn8AWhoZo3YFiv-lbR8O5GAgFztSOBYew>
    <xmx:SWOWZTm2GPa2nx6JoAbIV7mddo7UPU_KNB3WMoG5_QLcLEt4Clt2vg>
Feedback-ID: i51094778:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Jan 2024 02:50:32 -0500 (EST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Sven Peter <sven@svenpeter.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v3] Bluetooth: Fix Bluetooth for BCM4377 on T2 Intel MacBooks
Date: Thu, 4 Jan 2024 08:50:19 +0100
Message-Id: <86B7DC5B-B25A-4D55-BBC7-A1C3EE8AC703@svenpeter.dev>
References: <MA0P287MB021769BC136ED0B947683709B867A@MA0P287MB0217.INDP287.PROD.OUTLOOK.COM>
Cc: Johan Hovold <johan@kernel.org>, Paul Menzel <pmenzel@molgen.mpg.de>,
 Felix Zhang <mrman@mrman314.tech>, linux-bluetooth@vger.kernel.org,
 stable@vger.kernel.org, Johan Hovold <johan+linaro@kernel.org>,
 Hector Martin <marcan@marcan.st>, Bagas Sanjaya <bagasdotme@gmail.com>,
 Alyssa Rosenzweig <alyssa@rosenzweig.io>,
 Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Orlando Chamberlain <orlandoch.dev@gmail.com>, kekrby@gmail.com,
 admin@kodeit.net, Janne Grunau <j@jannau.net>, asahi@lists.linux.dev,
 linux-kernel@vger.kernel.org
In-Reply-To: <MA0P287MB021769BC136ED0B947683709B867A@MA0P287MB0217.INDP287.PROD.OUTLOOK.COM>
To: Aditya Garg <gargaditya08@live.com>
X-Mailer: iPhone Mail (21C66)


>=20
> On 4. Jan 2024, at 08:47, Aditya Garg <gargaditya08@live.com> wrote:
>=20
> =EF=BB=BF
>=20
>> On 28-Dec-2023, at 5:41=E2=80=AFPM, Johan Hovold <johan@kernel.org> wrote=
:
>>=20
>> =EF=BB=BFOn Thu, Dec 28, 2023 at 10:46:57AM +0100, Sven Peter wrote:
>>=20
>>>>>> On Dec 27, 2023, at 11:30, Johan Hovold <johan@kernel.org> wrote:
>>>=20
>>>>> The commit you tracked this down to restored the original semantics fo=
r
>>>> HCI_QUIRK_USE_BDADDR_PROPERTY, which means that it should only be set
>>>> for devices with an invalid address.
>>>>=20
>>>> The Broadcom BCM4377 driver has so far been setting this flag
>>>> unconditionally which now potentially results in also valid addresses
>>>> being marked as invalid.
>>>>=20
>>>> I've just sent a patch that makes sure to only mark invalid addresses a=
s
>>>> invalid:
>>>>=20
>>>> https://lore.kernel.org/lkml/20231227101003.10534-1-johan+linaro@kernel=
.org/
>>>>=20
>>>> Note however that the flag still needs to be set in case your device
>>>> lacks storage for a unique device address so you cannot simply drop it
>>>> for some device classes as you do below (unless you are certain that
>>>> these devices will always have a valid address).
>>=20
>>> We do know that though.
>>>=20
>>> BCM4377 is present on Apple=E2=80=99s x86 Macs and always has internal s=
torage
>>> for the address. If the board comes up without an address there=E2=80=99=
s nothing
>>> much we can do because the address isn=E2=80=99t provided by ACPI or any=
thing
>>> else and setting the invalid address quirk for that situation seems appr=
opriate.
>>>=20
>>> BCM4378/4387 is present on Apple=E2=80=99s ARM Macs and never has intern=
al storage.
>>> The address is always provided by our bootloader in the device tree.
>>> These should always unconditionally set HCI_QUIRK_USE_BDADDR_PROPERTY
>>> just like this patch does.
>>=20
>> Ok, good, then this patch and the one I posted are mostly equivalent
>> assuming that the BCM4378/4387 return an invalid address during setup.
>>=20
>> This patch may be preferred as it does not need to rely on such
>> assumptions, though.
>>=20
>> Johan
>=20
> So what's the final take on this? Which one is gonna be merged upstream?

I would=E2=80=99ve preferred this one (possibly with a better commit message=
) since it=E2=80=99s more explicit and doesn=E2=80=99t rely on additional as=
sumptions but it looks like Johan=E2=80=99s version was already merged.


Sven




