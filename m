Return-Path: <linux-kernel+bounces-23556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BA0C82AE65
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 13:08:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49E821C22BE4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 12:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B60316415;
	Thu, 11 Jan 2024 12:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="MReblS0X"
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810C7156C1;
	Thu, 11 Jan 2024 12:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1704974640; x=1705579440; i=markus.elfring@web.de;
	bh=XPHM31/TfKCxRDz0ZIth51Z9vULocFfBJjxf1ByCGxM=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=MReblS0Xa1Lw1gy5z6IuAQWXzQ57Bwbd0y/lwQxOMULwtYZ6fg5FYZyWP3rsMc+2
	 HVhRiawwCKRSTLIRz6aDoiGMvXBK8taczd6ZUW+o8I3HczwtAMs+ajPbZWZ0CDrbj
	 dYUqT3VKZ3D+whh3Fb86WI94kbyhklGe1j3Y9tbC8jgACrszCd6EKb3C7yQYbiQhi
	 ilP14+NMVzxJ6yEm1ObNKH4HfjKl4eRMPTR002cBbXLC6Pp73h+gZyxTvWeo4FSSC
	 3SbM3Ft30XxNtCduiLMpUScr3k7p9ZsBDQaB+hFQc6NmadfpxZPSwXcR4GgzPJWsN
	 QanFhIRW06xeKzi7hg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.86.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MPaMQ-1raSrC2av4-00MgMN; Thu, 11
 Jan 2024 13:04:00 +0100
Message-ID: <58d6b9d0-a2d6-4d8d-bc36-fe783839ca79@web.de>
Date: Thu, 11 Jan 2024 13:03:51 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: leds: trigger: oneshot: One function call less in pattern_init()
 after error detection
Content-Language: en-GB
To: Lee Jones <lee@kernel.org>, linux-leds@vger.kernel.org,
 kernel-janitors@vger.kernel.org
Cc: Pavel Machek <pavel@ucw.cz>, LKML <linux-kernel@vger.kernel.org>,
 cocci@inria.fr
References: <c73761c5-7150-4f20-9b3e-1da680400250@web.de>
 <20240111104109.GB1665043@google.com>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240111104109.GB1665043@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qumbmpRY/AvugoD+arzlfhgcwcM2WMYsUP+tFvej/BAbGvxkk0Z
 e8y7OICMQuzVRm8s5LQRo1FexoABXySiyHNy+QXWnLInWQUoNRaEGBLQPWpeFOOKawso4Nx
 LYmrOyL4cSHDzg+r5Y8tNV40c0u16U87YhMfqfpaBg0Cgn/th+CAubmnVYsk0l1+9nAwQD0
 bJHdPeEaL5RwzIKQ/PzgA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:HUQG9nPB8vc=;kuYbAD82Z4Urm4GTFEM8Jzm2C9x
 Bvt3YOEdxzFMzVCuRkW4I83vAgEuJgmyCqOOtZiTlY2C/5cZxfSuU8ZXoBj7JTbfbgppXSeJa
 TmlOceBYybxxkFptQHGSYLjnBEZtPG4l4PRJ1qmYIEuKpEmBxneh3s426HXBex2yikHXegBVc
 aq3srAR1GTS8IEnKgiRHVofcT808PmVM3U5a0wd5D8oqgKN580E8SkQT0xtrnshNV+6vHoGVx
 Oxck1zZn/mcGuWYU4A4vsJgJjX/j7FH+RMIHjukpXmP/ezEKI9EZn3E/BiNySVEAM5b63Mc+p
 ZZ+xm4qT42XdltpLGZagpqbY0c7nDbQEBPw3M46Shj6Goe24vf1GjSI6qJIb11K5jmr8E9c5/
 yV/1AtH94uYeK8Dho7ZT4fEetj+OXnCMSsAbU2C/ioGpnxtnqCGzT2kXI7CpnCqwmvnTXWUXE
 si1pdIruNdI9cnWLQY3JHZRrTw4Ft/yiCp8rijGO5qvw4OiuwY0TYbbMuJSDUGz4UYLWuZiGM
 zmMUBdpgG/yjMo3ynhcSVoqh/DUpQsP7xancrSafgZLtW8TMv60gao8wmmDoc9+9cuXXZv97o
 C1HC6rYO9bAjGvGgtc4Zm4wzL3IOs1VO1+G2gV9fQaSboxlA/81anFma5zQECwl3Wrdl+RqoA
 ZN+uMLnbXikCmVPXnrKGbKrVRpJhYviTwgVbEhJyPvdlosF7CcFrzfv6HPTIBqPxgfvy4Bwx2
 P+He0VFCSb042PrRyNOwUYhiTwIVhbfVNzvZS/SQY6fM16LPyIrzvgueCWbbS8fvEaz20QXGE
 SlnCkVupTKyBeXhvif9cBAq1ufBYpTUvOzpBr9gnzjwKZENhIbDpuQFy1M4wXEOssbc3IGqmN
 pV/fr7iHzCdyva18wZOG5s4dBi67P1f2MkCrOs34Et34nj1xwGCnxKJuq3n4gAAVXkZSfPqLF
 KHxEcTKxb6mhV2YVdzEXjkYSQ5k=

>> The kfree() function was called in one case by
>> the pattern_init() function during error handling
>> even if the passed variable contained a null pointer.
>
> It's totally valid to call kfree() on a NULL pointer:
>
>   * If @object is NULL, no operation is performed.
>
> Why do we care all that much?

Would you dare to categorise such special function calls as redundant?

Should they be skipped in more cases?

See also:
https://wiki.sei.cmu.edu/confluence/display/c/MEM12-C.+Consider+using+a+go=
to+chain+when+leaving+a+function+on+error+when+using+and+releasing+resourc=
es


Regards,
Markus

