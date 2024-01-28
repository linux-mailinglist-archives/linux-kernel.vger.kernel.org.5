Return-Path: <linux-kernel+bounces-41916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AF0E683F98E
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 20:52:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05025B21408
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 19:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4257136AE1;
	Sun, 28 Jan 2024 19:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="k6eS+Jqh"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F73528E34;
	Sun, 28 Jan 2024 19:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706471539; cv=none; b=iMWpdr8HRTN6MhGTNG65299CrgdHEwjIWL8ljwCwbhnyV51QSaD0fQIjkjWdWCj4v0z7v/282va9kJS3MGal/mk/X+QuORA4NqZrTKTsvBwmT099QisWgrm9aProcrnp30LuMtoPMnTKAPAtINdq8hD9Bb67LUlqWjXm/Mi4628=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706471539; c=relaxed/simple;
	bh=XN+UyRHggajKOjpCssvw2790TXAKAkFvBUvkFhyl96E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FXZiAJVtjGGJMYnEp4WMNdXgKXM/eQQ5GvDfbwQybInzuFWIqrDL7A+cnzqy1iiN2wCDXWvRPQus3k7hS91MZVyWcJJOTcE2TVDfQfygKJ3nA8cSwE5MuwJncW5QQ44LMZGeJ1b6jkFhUxo0Q4kCH0edAzkDFkxrUlJzoU/nArM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=k6eS+Jqh; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=s31663417; t=1706471523; x=1707076323; i=wahrenst@gmx.net;
	bh=XN+UyRHggajKOjpCssvw2790TXAKAkFvBUvkFhyl96E=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=k6eS+Jqh99fuLVl15IHOI0rKG2fZWFA1xD/uaw6fTmBPJ/Sb0SKeb3MgLxUzN7sd
	 6iLLSY4RbI5ES8hCIxhWRIrVfuHzdNMdIiyody4Qkh6sBxNfzYKI1s1w11a9i6b/l
	 CnctQmYTeNVhlzzsMVnON84AmU0NvgVq9N9jvPvNoIyQS+JQChnbF+okVr/DnKD7S
	 XQrwlXNU8dRvOQJQWlPP6aPBAHV1CwXGC1ea4rM5QjAp9+kxXQ0mjDF0gLax6M9AE
	 YMFFy3TRm5HV6a1++8z6sH4WrSQJx5fKBSl6CnX6lpiq+c9l3RO0zOHUHYJvz9tKL
	 ziMGH4YRbBnkEbuuSA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.167] ([37.4.248.43]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MRTN9-1rgbuo1pdV-00NSQQ; Sun, 28
 Jan 2024 20:52:03 +0100
Message-ID: <309c899d-551c-41a8-a574-421a796e79cf@gmx.net>
Date: Sun, 28 Jan 2024 20:52:02 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 01/14 next] qca_spi: Improve SPI thread creation
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Lino Sanfilippo <LinoSanfilippo@gmx.de>,
 Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240124223211.4687-1-wahrenst@gmx.net>
 <20240124223211.4687-2-wahrenst@gmx.net> <20240125183639.585ec73f@kernel.org>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <20240125183639.585ec73f@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QgQ7x7NJvc52CZk+n++xkBDbbZpS2r3wMkA7O/F2gmDP2qV3fNt
 oNXMkVR2ShknWjYSaEU+4fhBiJIW0NlsqIlOTQBanH6T0s8wXwgZBU2Pxr7hky9PHZpc82p
 qT5gbKoYFy7alaNYcoU95jfQ2gre7t1W+zsL0b8zqtgMeFIcLCvUBjiOk9CNkRnbEEbhLLf
 G1SooQBvjRiyF7ywPGKcg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:AQKGmC8yLQA=;/V0VdTOAuT6gvYHWNvvRthNQ5kC
 TrF7KSmzhCIlZJDEdwCu7AfEMW8Gi/gcgQAxAq9k0pYAF3JGflNGy8cANF3HrYHi+rNyPC8GL
 WBceOdcmGYRBlyeI5ZIDQhrkDe8+IFMMjLvldcn26l8Yw0vbxIATcxuulI0K4sGcS8VngDIQ2
 3mLG6+4yVxima2E/wBBHxIp5YWulVYVLFHyAWEyuBkZ58StDiDKi8SqZeXAut65a7Biv3XdV8
 GK4+7QnOBCkQUv1myZfi+kk4pw1AFc40ldQU9SskSlxm3CJhELSioXqy5tX1gM9BRlQMSg1//
 z0RYMzDmOLvFbx1lD7iJmEZdJ7wz0ucOdPwW4Pp/c/N/RlwTH2UmyyqjSUzp2bramDjJeV+6G
 ayeXoGNlm+1y/4dmoAYvBqEtOcRhv6+Q7i3D3FkHDczcgEZIOMmidPtuWQXtnkGRh0y+HOKfY
 exRBVDe875FKVYuaXrK9hAYSo1MFjz62GDPoHxA6rdkPGW4oaS/sxXT6Okx/JoxhB7YniwCxH
 2BkI9zDkh9YSQ/1hD1eMUyfoBpyLqt7Avskn8gH3SfjupvU+xDMUi1xL2KHSuoT5+1WZJA46Z
 QRCG3jg290CNiQO6GT5IKc309b/dn+OS8Wf5DM84DNabuOG84Zu6eBOmdSUClIxh8cshnEdjq
 pSogK56flOEfTxsZ37r1GigzzWS0RHfGiUPK8wM0IiD+AR4C6TLIA+eiREDHf3iFRsxjjA3E2
 mv3OyWDso025RtlLN3EhvVGxWE+Xa+/hdN9K+hIxlslxKnC8g85pMs7Mxvlcu5lWerX118SVz
 UmY8AVJljR8EuAGVU+1MJ1VTLiaNdk6COObCbC7/eZhw3sn8p8EF32RIYlm0D9bR/GZ6MP2HO
 xJxxyib6jKNni62vAM4d+K3HPPlk4cP711o3CaUeU4+qAiG3QAFwlMgSDTMjSxYb7SJfaWxGH
 rqEmPLUxItTTi8FEG+2RTjiHRPk=

Hi Jakub,

Am 26.01.24 um 03:36 schrieb Jakub Kicinski:
> On Wed, 24 Jan 2024 23:31:58 +0100 Stefan Wahren wrote:
>> The qca_spi driver create/stop the SPI kernel thread in case
>> of netdev_open/close. This isn't optimal because there is no
>> need for such an expensive operation.
>>
>> So improve this by moving create/stop of the SPI kernel into
>> the init/uninit ops. The open/close ops could just
>> 'park/unpark' the SPI kernel thread.
> What's the concern? I don't think that creating a thread is all
> expensive. And we shouldn't have a thread sitting around when
> the interface isn't use. I mean - if you ask me what's better
> a small chance that the creation will fail at open or having
> a parked and unused thread when device is down - I'd pick
> the former.. But I may well be missing the point.
there is actually another reason for this change which is not mentioned
in the commit message. The pointer spi_thread can have 3 states:
- valid thread
- error pointer
- NULL

So the second motivation was to eliminate the possibility of an error
pointer
by using a local variable. So we only have to care about NULL.

I will change this in V4.
>
>> @@ -825,6 +813,7 @@ static int
>>   qcaspi_netdev_init(struct net_device *dev)
>>   {
>>   	struct qcaspi *qca =3D netdev_priv(dev);
>> +	struct task_struct *thread;
>>
>>   	dev->mtu =3D QCAFRM_MAX_MTU;
>>   	dev->type =3D ARPHRD_ETHER;
>> @@ -848,6 +837,15 @@ qcaspi_netdev_init(struct net_device *dev)
>>   		return -ENOBUFS;
>>   	}
>>
>> +	thread =3D kthread_create(qcaspi_spi_thread, qca, "%s", dev->name);
>> +	if (IS_ERR(thread)) {
>> +		netdev_err(dev, "%s: unable to start kernel thread.\n",
>> +			   QCASPI_DRV_NAME);
>> +		return PTR_ERR(thread);
> I'm 90% sure this leaks resources on failure, too.
Oops

Best regards
>
> Rest of the series LGTM!


