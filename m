Return-Path: <linux-kernel+bounces-97282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED13A876838
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 17:16:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BBAE1C216E5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 16:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05EAA2D03D;
	Fri,  8 Mar 2024 16:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="Pnp7/IDh"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2772567A;
	Fri,  8 Mar 2024 16:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709914591; cv=none; b=DZgCfLcZTJu/lwJDjvZMaBK/IfJtEVI5OMaAviKOSsCm1sRTeqwbHt6ml3fErNZGu19uWsXGQhR+vDzCAlkomBrp8jIJYE5fp8W1cNx9Fl0eiKXFk3l8q9jE1C96kbcnXSSetJKVvlMtFRl5+9PaKE0KuEiPHzCPDES3BRcnCjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709914591; c=relaxed/simple;
	bh=nl8BmuRwYvsr+bu7CuRQ/ADaxAD0pyS3qoMsQf8QLk8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=OCSc8D8DYxKRJKL9m4ZemK6WGYHNVcCyJi1PlH8HnryHN7J5CVceez9ZPEUL6sgeEImSJ9jPaU8Fz7EwXIqTBh1QwvlB515VcCmxXvk1zIMaBB3XQbsm2Gt2UPytmpXP7/j7/8gthlSTFgXs718TiRpkHhqfbYwMus/GHwY1wH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=Pnp7/IDh; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1709914555; x=1710519355; i=w_armin@gmx.de;
	bh=nl8BmuRwYvsr+bu7CuRQ/ADaxAD0pyS3qoMsQf8QLk8=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:Cc:
	 In-Reply-To;
	b=Pnp7/IDhh4PdaOl5dzP5k5ENdZA7YVeJWmuUeShyF24i8MqrPaooOTwqusKGojas
	 uECBk2NGzpxMd4hn4w/EjvRatWk0YcCm55ZFlR1v4KGKe6KcyUOpdx73Eeu1TTAC9
	 XGrYd75qRIAKQwuAydw+KuFxoD1L7aWxl+yOaoSnGBN7ofF3eOG8ZrMyBm7JNYRDa
	 RGWi4z+nBKfNo67xp2vt3tevacUAY48vOjqDfXbw4spI+BbL8cRQAPA4N3rFDeGgN
	 JKzPPbjYNBLm1WooopyT5FFG8EQG6ARU+qGfsjFn0q9A2pyMY10q5nQiIt+77RuJf
	 kOmNjsyDtLSr0PIF4Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MfpOd-1rBSmw37dZ-00gD67; Fri, 08
 Mar 2024 17:15:55 +0100
Message-ID: <c07dedf3-175c-4748-b6d3-e1effe9cad41@gmx.de>
Date: Fri, 8 Mar 2024 17:15:48 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] platform/x86: add lenovo wmi camera button driver
Content-Language: en-US
To: =?UTF-8?B?6Im+6LaF?= <aichao@kylinos.cn>, hdegoede <hdegoede@redhat.com>,
 "ilpo.jarvinen" <ilpo.jarvinen@linux.intel.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 platform-driver-x86 <platform-driver-x86@vger.kernel.org>
References: <1vk29ojvhrf-1vk4tk6plf0@nsmail7.0.0--kylin--1>
From: Armin Wolf <W_Armin@gmx.de>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <1vk29ojvhrf-1vk4tk6plf0@nsmail7.0.0--kylin--1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KWHWcfVt4TiOkAIHEN1Jf4Wok0DkXphNbM6k/8m4y1cBlp3266u
 BrB0jP7XcxvI9+k/5GROjS5rPmqcgfX4MDnzxTN2Fw9jtohQ0QehezJUlXHN49qg7GClTyE
 bEUb1NDcw97Ims6L7XP0iu1r2ac3Z+vxRid1s46WXKzPXZq9nb9rbfLqysVY/Kp+NntPd/B
 zBfv80713vl12eQHtBt0Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:updG3xWEY4c=;9ZsCzdJLgPU7szJBd1nGgnSXEdQ
 N+p22wL6oERTwSOAUan8ckv2xSSj8VqUUZLvOFAyohBffMKA6YESa9IXl7Ae5u2iGiQDiwvW1
 q37IOLbQD/4eOLYCyrOb59aUiokt1ZJ72p35akEKb2sGwg3EsxcLMqtwZSkfHl+0opIqeH3mV
 SVyLFocXCvmDBQS9pkxuD3xy6Vmk2iSbohM13/+xnqDFB4QQBNQ86HnvinM2THFrLngEybF18
 IwQAc3JB9sOnbdh44xZS/ZfOOcxFl2uQvQ0lVKneCu3/sk+H3Er6P3PKmGfe8OQn2GsnipVSY
 Sp79TE+MpX3bDJ34ttbKSgFeya9HcFIc8BlWrjrNVVTVS7Ie1SDZowa0e3I7rwW/Bq4AARSCS
 TK0OpN3hvEzfd7+UW2n2bOi68m/ePKnFDP3IkbD/Y+dDfN002jptksxmZCmen7G6ZjbW42sb7
 5jcJw217HcXF9Yd4Ypk4/dSa/mTMxiCOcOtuPH1MolMsunUaPsKYEG4YFx5cSCJtYHIFhWhrz
 ZpfduQjhd8iKguuwyiHI3kAg6953kHq3g13HzCRniN2QF4DU02Xd/wodeh/K83MqqaTdyHFU5
 PXYLtv/SpLQvjQ97lQiUeT2Jn1HsaqmLG6vZ1w7auyQmuwT3R647BVYdv4Xbxj+y3Pv9dxfuD
 OQobQd7RYDo8dnK9BWl5PYYIZrVKVj5nLbwdKkPFQQ8dnHt2TyqGl9KedqC2TGUygUKP3lV/h
 oLy9MVSYDiV8S3Arot7PZnHsZAmNES9YHQUZRSbjWwwIqxoS7cKx1boVNhCQjLiTtBJ7qYFTM
 Y5B0gTMTIRJylUdCAE+NRqSpXs126OKGThOtNmAhgtbaI=

Am 08.03.24 um 09:40 schrieb =E8=89=BE=E8=B6=85:

> Hi
>
> =C2=A0=C2=A0=C2=A0 thanks for your help.
>
> > Is there a way to determine the current state of the camera switch
> without having
> > to wait for an WMI event?
>
> There is no other way to detemine the current state of the camera
> switch without
>
> a WMI event.
>
>
> > If its not possible to determine the current state of the camera
> switch, then your
> > driver has to defer the initialization of the input device until it
> knows the current
> > state of the camera switch. Otherwise the initial switch state
> reported by the
> > input device might be wrong.
>
> > In this case, that means your driver must initialize the input
> device when receiving
> > a valid WMI event for the first time.
>
> > Basically when your driver receives a WMI event, it has to check if
> the input device
> > is already initialized. If this is not the case, then the input
> device is initialized.
> > Please protect this check and the input device initialization with a
> mutex, since WMI
> > event handling is multithreaded.
>
>
> This Camera is a UVC device, and the Carema device is already
> initialized before the WMI
>
> event .=C2=A0 Whether the camera switch is on or off, we can used lsusb =
to
> check the Camera.
>
> This wmi-camera driver only need to report the current state of the
> camera switch.
>
>
> Thanks.
>
> =C2=A0=C2=A0=C2=A0 Ai Chao
>
I see, so userspace will notice when the camera is disabled. Since the cam=
era disappears from
the USB bus when the switch is activated, i wonder if SW_CAMERA_LENS_COVER=
 is the right thing
to use in this case after all.

I CCed the maintainer of the input subsystem so that he can maybe provide =
some advise.
I for example would, taking the above information above the UVC device int=
o account, say that
KEY_CAMERA_ACCESS_ENABLE/KEY_CAMERA_ACCESS_DISABLE is more suitable. Then =
userspace has to
keep track of the camera state (through lsusb for example).

Maybe someone knowing the input subsystem can provide some advise on what =
to do in this case?

Thanks,
Armin Wolf


