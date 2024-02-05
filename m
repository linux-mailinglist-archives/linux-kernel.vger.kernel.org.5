Return-Path: <linux-kernel+bounces-53104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F66D84A0BA
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 18:29:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E60A0B24D6D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 17:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3437E44C90;
	Mon,  5 Feb 2024 17:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="PNUfyyDl"
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B60A41218;
	Mon,  5 Feb 2024 17:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707154138; cv=none; b=pAZEof2kt3sSGdmva5rZTFS4m/3eyJs+ZmPyLws4lhwy6URZCWMOEX/Q42gEW6ECmMULkPTqygpJQEYpLA0xtMplfctiotLDDXk36+t7z63dfI1dc5Rp6a3B24rCAVx2kpDrDIlo+ECuBw/6NgEAtif2vMwQBPlzXPbfckesWps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707154138; c=relaxed/simple;
	bh=GnkX8qqYvyQMd2mJCkO1YmK0GeiquaSlbUasLbvc4nA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kPxDhnUi+5pxf1UDn2RcEizILdVF+R8MiIcJ3NADzumNSv/Ip+BdkJ3SPei4xMffhTpHllhtnjGpzSuYfa5O+dKnxXUWxaUC3S3o7DCVu4n82pnnqu3orkIHjnWwvdkmt8VdptSSWWLt1IuC/MESuKzxeDUDy0V7jd0Q4KFZCSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=PNUfyyDl; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1707154114; x=1707758914; i=markus.elfring@web.de;
	bh=GnkX8qqYvyQMd2mJCkO1YmK0GeiquaSlbUasLbvc4nA=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=PNUfyyDluiMQQZVE+qA9Hqx95hEFp//dcIyvG0wGtxmV3LvCwYKU2R+pdTBGShU8
	 RDqfUCVUHjupWNUOl/OpLlssMf0lwO8U06H8xiAUOqN9OANoBs78cM+SqpeK2Y9e3
	 fU5o75MsbYxnX0T7DGi2VBtPjhg7VFkUnPoFIfF/S8x9X/Bv7W38SxvTmoN3KSA6P
	 7xbf0eL4JajawtohwX13xiE/QGAMTJiZvofEyTsRCiNXrXIj5gkI8pOGTMofb7xaz
	 l3vmgIZuIaIT947FW9E/bzR0fkRRGxedFeZTTYSvacRgXpwvW1kXMVNHNO/diu2oy
	 /KjvN9HlOUDVO5sdZg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mgzeb-1r5O3z1pBl-00h3rE; Mon, 05
 Feb 2024 18:28:34 +0100
Message-ID: <8f011126-c95a-4c71-8bc9-a6b0a5823c96@web.de>
Date: Mon, 5 Feb 2024 18:28:31 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pmdomain: mediatek: Use
 devm_platform_get_and_ioremap_resource() in init_scp()
Content-Language: en-GB
To: Geert Uytterhoeven <geert@linux-m68k.org>,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-pm@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Angelo Gioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Matthias Brugger <matthias.bgg@gmail.com>, Rob Herring <robh@kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <da6af483-5ee9-45cd-922e-d9d5364674dc@web.de>
 <CAMuHMdUxn4Ne7kmEfONz8Uk3Why3m9r83GdM5RzTxm_4Gj_a6g@mail.gmail.com>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <CAMuHMdUxn4Ne7kmEfONz8Uk3Why3m9r83GdM5RzTxm_4Gj_a6g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JR4A/TH7VX+6fxHtk4rBvyvu9uUzxS01ZNx7ukYZ+MXC2RD7iz7
 c42oLIJFBks9maC2WA3glXfX3Svisu5ANYahLTso2aXW7mLjmwcYCJMJjCjzHEzeZJt6o6G
 zZj/nCidCVTYzvfmzykuHQbQLNO2dHYvbi2EPNp/VRZXpNiUP9D11s7VHKEIr0iWPurbLvr
 +QqHuwTptTwqS+UVH7r8g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:U2xZDLOeXpg=;fiB8cvep5CQVXtqba7Q5BfUhD2n
 Kn0QoQ0j4AV5Wcko1+RW7eX0D5E53NTnVgm1TD1FESs3mxO+h7kMG8Y/6TVaciCY3d+2ZoQX9
 spEGXByyM8BA1MKx81+VFpWCpyYpksKtipQwFuiFLyZdKbVwzRURG2ODI+h9u09BBot418fzC
 msjvLu0mB7fA2Pr/iJCCfnPT8Bvks2t7O+UOWj2maJvMCfVfWGfNLr4HTwvjyfEk/3KUCMH2s
 HIiE3IYrsKJU/XzhztMSg8zbbSJPrgjmTP1X8hW/wi5HAOMrUHp5cUv/g8xa65Y6BgmxBxtmj
 1nfirQExAMlakx9sUxINFMfg6Icm2IWCVVVt/yhfF5mwYXXarp59XHYQmK3M8t/6MYdTgysad
 hs68CuYMQIgUxoD+el9yj3VGcor41CP7jAQlY7jVNka5RwPk8dpAgMxOZVIjBvae3T8mR4uVO
 kZ57mNYhOLzCPnU0zXOMO5OXA77saYa4t8EroUBgxEJl0YBJ1NYM2uqE9EqP7i0EmLVT09SRj
 GNPB/ky2OT/3p9+etLKJY+Q9X/udwNIsGpo4WZIQNfQ9UakV8+AlN8bcnjNPYkfGhEFlBNoN9
 D2mhuOldIaU8EqVqWlZA3F0uziKFPHjJV/nIn6tp8uDVl3ZqvH2aoJi1dUR6PafLGuzFh9te1
 vz2vrjGn9c55cDJqiLT3UvaQl4jZ4WS74bliP7p3JJsbbHCgtxLnBD7MG6l0pUYG3E95B5n3E
 +3ohmiFxOuab3yKNOdfgc4gCjfZrdr4wKgSp5FL4pMWcmk7MajTatjPSoU9x8uBXMf6hilusd
 /a5JN9G96FsHN9OybCn6V1gSCb1bLOauvZiKYv6N1U2a8=

>> +++ b/drivers/pmdomain/mediatek/mtk-scpsys.c
>> @@ -441,8 +441,7 @@ static struct scp *init_scp(struct platform_device =
*pdev,
>>
>>         scp->dev =3D &pdev->dev;
>>
>> -       res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> -       scp->base =3D devm_ioremap_resource(&pdev->dev, res);
>> +       scp->base =3D devm_platform_get_and_ioremap_resource(pdev, 0, &=
res);
>
> Given res is further unused, please use devm_platform_ioremap_resource()
> instead, and remove the local variable res.

I got another idea after looking at the implementation of the function
=E2=80=9Cdevm_platform_get_and_ioremap_resource=E2=80=9D once more.
https://elixir.bootlin.com/linux/v6.8-rc3/source/drivers/base/platform.c#L=
87

It seems that it is supported to pass a null pointer for the last paramete=
r
(while this possibility is not mentioned in the interface description so f=
ar).
How do you think about to benefit from such a design option any more
(instead of the determination of a corresponding platform device)?

Regards,
Markus

