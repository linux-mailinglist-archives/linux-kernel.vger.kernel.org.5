Return-Path: <linux-kernel+bounces-145831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0DCF8A5B96
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 21:52:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DAB71F24259
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 19:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E64B15DBA0;
	Mon, 15 Apr 2024 19:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="qYoquhNI"
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8DD156672;
	Mon, 15 Apr 2024 19:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713210428; cv=none; b=ZGxt5LaFsJWol95OhitRPFN288PZ+aj4ju6pZL5XCpP/9Z8jcPSFgdUKejWIuSiwTNCDQa7Ryv9PIB/oj9ZtOe9URs2/ihLAu0p8Uf2X1j837KvWYMQorRvAbxebWzCw4eJSOftIXJqF/zfMHouAvZ8sSkQ5S3qHfgyvySYGAgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713210428; c=relaxed/simple;
	bh=IR5twlEytFTNkH5gQ5ORDWxzjTbflwpz2VLnUrdumsI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P23rxX1gwmVrFj4jCu/caPNPILgoOwxyHKzQIKdo386NT8K6uzqYrfgeUCvWxw8xX+xsNmX7dhsv4MwBlwpVqu3pc0GleFHY2hByUJLn/cnJltyPcTNL7uszGnOHhhCoN2SG79k11Zh2/dtXaOo2zipx5TCx5u8m3lFtkWFADqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=qYoquhNI; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1713210405; x=1713815205; i=markus.elfring@web.de;
	bh=IR5twlEytFTNkH5gQ5ORDWxzjTbflwpz2VLnUrdumsI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=qYoquhNITVx87CrWIDsn1n75E4UuU3I3VuLDOuRugCP2qmvdSP2UoLOx0Qydqde/
	 trKUrgZp6s6XMP5zT3DlgdZmy2q9cmXBypueOiCFY8KbWfQVMKm0v3eSeizq+BTQB
	 f131skfZonSWNeaVeTgapII633/dguR56JMZTeyYTBwboLngE1CDItXNuF+mJ1v5E
	 XpcIVxc2TpQ7DzCWQT1Wl9DqY9nk005tdvK9+8Xbeod5mGHPQeeCghTCC3ig6SAa4
	 bKFA2br7PAciMxtuT0J04U8b2KJHjlc+tgPalPVr/7MaRgy02qpY21S1x7KmrudzU
	 d6S6mM1HG7ticlGf/Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.80.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N0ZsE-1shhI131SW-00womv; Mon, 15
 Apr 2024 21:46:45 +0200
Message-ID: <8ae97386-876f-45cf-9e82-af082d8ea338@web.de>
Date: Mon, 15 Apr 2024 21:46:44 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: bcmasp: fix memory leak when bringing down if
To: Justin Chen <justin.chen@broadcom.com>,
 bcm-kernel-feedback-list@broadcom.com, netdev@vger.kernel.org,
 kernel-janitors@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>
References: <20240412181631.3488324-1-justin.chen@broadcom.com>
 <6881c322-8fbb-422f-bdbb-392a83d0b326@web.de>
 <9afad2b3-38a5-470d-a66f-10aa2cba3bab@broadcom.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <9afad2b3-38a5-470d-a66f-10aa2cba3bab@broadcom.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gnuXHtYryBlPRJhrlOLehrxnO9M2/gNL8VR2cIDGl5QnN3+gMXV
 58rk/yNOKrbFijp6ihArZVLrih+ffN0PDvBfAvIG6dZBK/rCuYlgNxXYdyCE6BSrJpdvqoU
 WNgVCLGBlERJQiJGqOop2InTiSG24OnTtDFVx5FIfRGqSkIbSA23KB+OXtAlwb5PPoiVoXT
 Xrt34KCmCnid8D5LEMlug==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:S8T540Ipflc=;Ag+vH+MJhY/z5VIYN3FC06g0dv7
 3F0tY1VpAs03Hjg5xtDT6fb4Uf2V6LyH4lIHKZyU2eQJNNuAZcFEQ4S16N92jervJoeWw5x0/
 9ADXzgZ1NPaUhCGt2LtLNrV+h7puyJbvU4C16cFxyvGKL7weE4badp+xrGIl8zfG236xwlBYP
 PbiVYpmebywddNhnYskEf7fRu189TBY9XmPP1obRtJNjHjNLyQS1rKhkoPe5Cw3wagcSXqtGe
 N+W/CacRf3n6LMWcwNwGSUAG3GVGYUR8txUNKIrvqvtSuPSgzXtpr/RucW1DwbAvGrSqvkmaU
 fdVd23Z22BoMpbNPmZuJ4echFJfggVMxiYwpuAGoS3OZab7aT2qdxZDpsAPlc5humaDw+34v/
 srimQ9xM7Ol4Gdu6S+G0mnlwELp8KCzMYAgqMzAscA3FALW8k7qEe0ZyUFOyLLmFtmbifJinQ
 MMSSpzxXsY3sDi5Jiazn64VZPq8iTEll/6bR1/mSRoiW7Y5WeJAYPMdMJ2s0JchFYBWjfNYII
 qGn41qTBXsW+JDAQ1IeCdt9eMyn/gczGFiipIreb+879LKH8QgFkr/mTzq0+TUclgUbfSLzZ9
 xJHQALDqIoSmcxF8x0+T0jQQmYbe6Jprp0X/5Oi6+bFN7OskBc8wZouKnwKQ3ueD3dvPSiufK
 QPkXeufM9j2TpvMvAkyTOP2AVTTC/emaJVVFax0HlAy1YSkgSTwDk7F3l7FYzd2iDBaVY9xdy
 eeSGs445JhoxbCotvNK/Rq2KQn4lILL9lWeqjRICoIKDy0yRKLzhgbjup8mC/ozknZerlAg5K
 ++MGpM49LCgg8BL4pQ9pjZmkrcHHQeWssgtPWmNfP0FPE=

>>> When bringing down the TX rings we flush the rings but forget to
>>> reclaimed the flushed packets. This lead to a memory leak since we
>>> do not free the dma mapped buffers. =E2=80=A6
>>
>> I find this change description improvable.
>>
>> * How do you think about to avoid typos?
>>
>> * Would another imperative wording be more desirable?
>
> The change description makes sense to me. Can you be a bit more specific=
 as to what isn't clear here?

Spelling suggestions:
+ =E2=80=A6 forget to reclaim =E2=80=A6
+ =E2=80=A6 This leads to =E2=80=A6


Advices from a corresponding known information source:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.9-rc4#n94

Regards,
Markus

