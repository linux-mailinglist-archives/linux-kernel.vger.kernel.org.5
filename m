Return-Path: <linux-kernel+bounces-74935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C45285E032
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 15:47:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 345471C22BBF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 14:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 952237FBAD;
	Wed, 21 Feb 2024 14:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b="Iq5WhoK1"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292097EF03;
	Wed, 21 Feb 2024 14:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708526850; cv=none; b=g0VdB0+jYChN40x5lLkY6a9CnoQRMZhfnUh3vxIcSurSesYO/AOyXT4zw1ii5RJqpQnbBx5qwhHKoZ/w+A8yIKh/BxM5wvb9JgW0EJ/KdjTVR1UK34JZZik4sR+OjDboFnvdyVT8ufaGK212wEHoZnr13RvgoGwRWAs8/eIFdxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708526850; c=relaxed/simple;
	bh=9og4WWPF+xnEe/tmLQY9eA9wdGamFn3Kri3F4sczeZM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R9gGLi1+duEn2tMuCpk0BpSjeRpcOQDnwjuIC50UTCR5wU4MUYf6GpxdmunYOFec+wIrhfRjLRpvykSCjv2xAkfpiz2d5aALS/iiiIWf6n9JtyDvZUjrxQ2W0NdfHHNBPUevIpR3mwQEPFBG+zHZZM4HMHgWR5LVKiugUHdyzII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b=Iq5WhoK1; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1708526845; x=1709131645; i=rwarsow@gmx.de;
	bh=9og4WWPF+xnEe/tmLQY9eA9wdGamFn3Kri3F4sczeZM=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=Iq5WhoK1vKq1vSvMqFgwNe7kK1q0BM79/M+oAfTrL/kJVs0Ktu92sWCllWZISDR6
	 xa6W1A4590qaX3bS1AG8WelO9P4JX8Ys5MlSX4YgAedAmqOEBCf8MXciIFl8SQ+3Z
	 MIY0q6tbXoJZcznEf6+SHmA0FAMIKQs+lB/kDqz3IlXDVOs+20zxe120wiQdbNKbM
	 gtHwonJq46IKjgNqHqX7cEzv3NWVAzP/g+icKkflu/rlxODZ2VfRVr1jwRMvFgefJ
	 iHdbbfzrZ8fpGsQrSmEg+1e7BQfLeBsQF3OxbojnSCptwlGb85M8/0jLUxABk9W3G
	 G0FZvbHKtYvLmRgkUw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.100.20] ([46.142.35.10]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MSc1B-1rWZef47IH-00SvTo; Wed, 21
 Feb 2024 15:47:25 +0100
Message-ID: <2cc27421-8791-47bd-a3d6-83188332ad3c@gmx.de>
Date: Wed, 21 Feb 2024 15:47:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.7 000/313] 6.7.6-rc2 review
Content-Language: de-DE, en-US
To: Luna Jernberg <droidbittin@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <ed9e1bca-d07b-42fa-9ceb-d0eef3976168@gmx.de>
 <CADo9pHg2jgYqE1qxpV40E6GHL1s+G+mNm1JCcB9GgA-4XM59+w@mail.gmail.com>
From: Ronald Warsow <rwarsow@gmx.de>
In-Reply-To: <CADo9pHg2jgYqE1qxpV40E6GHL1s+G+mNm1JCcB9GgA-4XM59+w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6qBb6lE7ryyqGfoevmJBjZsvkWVd5Lv08+njlEABeejarAwHy7V
 Jy8bRvwKb/J521PXxy1DLTqI3BhkuBOFtm+g+O57wgXH10OhCQgWpydD9gdFYQEWja5B0cP
 zwtm/McdzQKiTHowhVT0upBatnDkKIoR+jOBZyXKVlr89itt8+nLZ3VwU9kslyMZOA8awqp
 m6/z6a5f8Ves7Ib6Vl7Ig==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:HfbXWP8WQfo=;yU4TXNtTTeD48SYsiIl2ECddhcq
 AAbvwpTMOEh1HZ0GjvPV4m2Hc/Y0La3F1ytvu6bKLFgNQYc1tR/vjRKrpE51D7Phm5E33VX1D
 eE3CSdqvE+BQaVzFIVSMrfKUdyM2RM8Cv+kX6fplvqtAw26ROdELBUFWBrGSnugxEjMI9tWLL
 8P5yd3fooC9A8QGpbJskGSCguBz7gIui++yDfs7mqzkRI+jMnpzsoSeXxp2FCu9AHLzumu51u
 apUp1kyZDeokvw22KSEYa/M0CZ5Xn482bPjiSyvMEGX8Mxm7cEvquDpThIUNFKvDmZZBxDbKB
 4XFbeCmAHGZuQagHMacLGwi001MAEWNkAE2kkAo5wOQYaENVplvH1aeNq28rYxahn3inxmna9
 CrMospaNT1JWB9FUDybm6ZBgwd3SSAql4Tz5on3qB68RsPuuZLb787ipQlwtpaDFNtGYL3lUf
 GGkkYwE3XVxTmxK5emvG4+TWVbgFMFPIanC4WbJG07Kg553XtaNlEXOUWSFkYSLiUfjzlspzW
 d6MxkwdXx/5UZmLqDbeEoBpce+muahV9hVo4HRPLV4UODf+PGMz4rno/Ix9vALugBqjfFC0Cm
 EI8xRcVj2VzGg7wUOcXWtq+NqALhubdU2cI7SqwnYPEXbkKvVP+XcyFZiePuTCMtCDUmnZo62
 LZbTMKCYB6pzVQVTo6N3PmLa94l1qU4NtAXC2ucbNntVhRaH4kis/IhHemmq8q8kd8cM17WoJ
 C3YuoVnYZD/mFBgZ7UFBQxA0vIl2GPmnqEfVB4IoRSDucOi1Z10f7CTDnsdrwTpn7R3qmMrjR
 tUy7ZIbDeflaSbo9jI+CwBMfV9e0odSVJ8QL5+EXR6yDA=

On 21.02.24 15:25, Luna Jernberg wrote:
> Works fine on my desktop with model name    : AMD Ryzen 5 5600 6-Core
> Processor and Arch Linux
>
> Tested-by: Luna Jernberg <droidbittin@gmail.com>
>

du meine deinem Scheiss Top Posting immer !!!
:-(

get the fuck out of it !



>>
>> Tested-by: Ronald Warsow <rwarsow@gmx.de>


