Return-Path: <linux-kernel+bounces-29844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 66C44831448
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 09:13:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08395B24E43
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 08:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAE2F11CAD;
	Thu, 18 Jan 2024 08:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="E1DEYTOE"
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BAC2BE67;
	Thu, 18 Jan 2024 08:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705565618; cv=none; b=px4bDbw7Bq6yp+gFQ/kvHWQB01rqWO0Gdc3FVgyZZ7yp5DT4+OPJ4O+YR+Lpfxj6hlqRjtJhFe475f2+ERIk3oSO+qf2UbgMZVbtjgUv6vJcO7Huj+ln8mbSC0EJodZ0S3Ng2MEx6JB+bGpEMw2u5AGJJ13FWIgcjkSEF8QUneQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705565618; c=relaxed/simple;
	bh=kCvOPst4rgL73b7SHnvOPtJ94GynuOZeJpfzDrg2Bpg=;
	h=DKIM-Signature:X-UI-Sender-Class:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Provags-ID:X-Spam-Flag:UI-OutboundReport; b=LZfLEFacz5IkAXkkbZ1Yl0Gt/3AkyzdOiPvMRuvnympr2sywfrldVVnGpYgueOdZRiZkpKw+4yK+BX5MiF+PtCLv2OCRUw4MPazxMMDAHHRs5rQkQHKp+lE/85xyU+EEMp+sM9DjxPumPa99diXJQMBpcMWGpxl85SvdNUYWdRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=E1DEYTOE; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1705565610; x=1706170410; i=markus.elfring@web.de;
	bh=kCvOPst4rgL73b7SHnvOPtJ94GynuOZeJpfzDrg2Bpg=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=E1DEYTOEdkkFLXcLzj5DUS+2aaHQQnoafCRqPQRfKxooC/Crbxo9QCcVLHBRzp/O
	 Y1TKLzdMhnHX1cEytTsL9RVhB7AX3h8hvJF8mutUSeKIqYSiPrtejTgOGeY9t36BH
	 W1n01pdEdnfLA5rXlFSyrSTAh5/jbc6naq0usZsXYvPhc3BohjSMw65t5FamTqQJG
	 yaSECSbHrBt2C4KwYxNk9HN9prlwiDSxNyRJ3CRnZGqLXe8eouILQc6To5JRdpYgG
	 KVL1d+kyPtzb4IpjSpAAm0SfM9IyUxTpb6FRRkKERaA63Eaba8dILCGuursz5+J5U
	 LrlPDeLCL8tWD7QQzw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.91.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MGQGH-1rL9pL1EfV-00GYra; Thu, 18
 Jan 2024 09:07:02 +0100
Message-ID: <efc748d7-1a67-476a-82a4-206a9ed252cb@web.de>
Date: Thu, 18 Jan 2024 09:06:50 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/msm/adreno: Add a null pointer check in
 zap_shader_load_mdt()
To: Kunwu Chan <chentao@kylinos.cn>, freedreno@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 kernel-janitors@vger.kernel.org, Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20240116032732.65262-1-chentao@kylinos.cn>
 <9e390783-05c5-47fc-a0c6-b95e249fe691@web.de>
 <4d4f4ae4-e5e9-4d9e-ac25-d262e7ea23fc@kylinos.cn>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <4d4f4ae4-e5e9-4d9e-ac25-d262e7ea23fc@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZAEHwbx6jQbZDr47gR/LgiXdS/Bw50dDuaXFMDByxqzOIN1swLJ
 Mp+oX0pb+WvOI6eOHDSGZI5vLw+JbCX0bkaCENs9ZKXZyacQrMdHeVe+7tWGuHhc2Pe4FsV
 MJZHADguhSiLqcwGyZ1wXvkTqYVhdDdCkhih01UaY2Ld0R1QUmARwKVi3yGNybAewP8+yTU
 IPQxfj9JZW/BZk9Z74qcA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:18ZZnxsG3g8=;b24lAmbYFzSGdfKDOiYpU/Be2jm
 QMSpsqM4qlNwDmDXCamIfP5CrdkxIwQ9i0lr34c0ts6NUR273+ajaQ6psrjP84YyImtl6ZsJV
 0CDVAarmiQfPQUcD8PqSF6AfSZ8ZZ5vvSs3X0WwgZV6XHYT7bBXzxapU4rw38Hlyxyz2Xu51v
 rQd3Uevo1E3t/9GYTRLh0GKK+Y6egUCILRHenil2fqYVDCau6FerYRu3Xl9UK/iMnaI6QUNa7
 78LNOloCvwz2om2K1IOMQhhmjVQF/6CO3Doljyt34R4Q36aUknoxQos6h9MNtji3rbiPlrU0I
 URqLa/AhzBElY8yskiPXD1oe6el+PptLeNGrFhy5gAQTCq8WDR2sztea620dlWDSrXR/JSpnp
 7m/1cP7VsstjmMA+9AgVSnE5+qxvbEIhJr9qi6fGUq5ZJzAj0igir8+magl2aA1CBEZzvoLzZ
 /O8NH2WjmaJdXCdOy5NTkm5QZgQIKRekcZvMUt/dxXUGtHz8EXP5s3CQkqzx9Rk3hi9F11nHJ
 XesEvME19ykj/83a/7rc6gvWoxngWfehQVzBF1ZJ6Q0HX6pQBJ5c1jscLdDFnwpE6jEVklS/v
 tPRdt3MiSWMbfxxHXzNi14/nhPtZDo05rOP5mS6Qzx46MhW8oCS9fFLCPXO5eTx/AL16Y/9yW
 tJEFAAOWbUbGaTIu2x4QWB0IBdQj023UhjVb46fwjhQB5hC0pdzTw2tfUY6qM74e/9JPqniQ9
 GxJMWvi61sJejsuxcK7b8qXR0CiPr9oLv2NarKmudEAkFTKTPegiDtVlgpZU81E0mYhZAh3kC
 uM9TGebh1Dccv9QMHzijeANwnGeyc1L5ss2Cg/YaJG18XQeHclIj9Ipe0jJ01p0jhSrHLWsL0
 PuF2aPJ1Qo+j+rnv6EiaFyi7zSSckePNnmvbGWA7XtDV0TQd/wQnWV6s3CJ8Y7iiOps84DmPG
 blH2lA==

>>> kasprintf() returns a pointer to dynamically allocated memory
>>> which can be NULL upon failure. Ensure the allocation was successful
>>> by checking the pointer validity.
>> =E2=80=A6
>>> +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
>>> @@ -144,6 +144,10 @@ static int zap_shader_load_mdt(struct msm_gpu *gp=
u, const char *fwname,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char *newname;
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 newname =3D kas=
printf(GFP_KERNEL, "qcom/%s", fwname);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!newname) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
t =3D -ENOMEM;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 go=
to out;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =E2=80=A6
>>
>> How do you think about to avoid the repetition of the pointer check
>> for the variable =E2=80=9Cmem_region=E2=80=9D?
> "mem_region"? Is this a clerical error, do you mean 'newname'?

Please take another look at implementation details:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/dr=
ivers/gpu/drm/msm/adreno/adreno_gpu.c?h=3Dv6.7#n124


=E2=80=A6
>> Can the usage of other labels become more appropriate?

I propose to reconsider also the influence of the label =E2=80=9Cout=E2=80=
=9D here.
https://elixir.bootlin.com/linux/v6.7/source/drivers/gpu/drm/msm/adreno/ad=
reno_gpu.c#L167

Regards,
Markus

