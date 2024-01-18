Return-Path: <linux-kernel+bounces-29652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B1BA831153
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 03:17:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1D921F248A2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 02:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEF86566D;
	Thu, 18 Jan 2024 02:17:10 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFCC14688;
	Thu, 18 Jan 2024 02:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705544230; cv=none; b=RJNZbros9eI4DWn+QznziL3ZW+xUPLYwx0ney71VSG8hn2Hon4ZzIvdch6laCDDxtMfWe9YhDGm7PoP/c3R/GLaoXM0eTAAgK1+Wku4uLbJV49U1v+HUO9puVc0r1jGUSG3D4urgMiTtInK+Fc+7XooSSSw6gJPJRoFRNpQ9zyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705544230; c=relaxed/simple;
	bh=6momQ9QB/Y9Ip/Db3KbIXMpQk/LKk7SNvyM7o6RGisk=;
	h=X-UUID:X-CID-P-RULE:X-CID-O-INFO:X-CID-INFO:X-CID-META:X-CID-BVR:
	 X-CID-BAS:X-CID-FACTOR:X-UUID:Received:Received:X-ns-mid:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:
	 To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding; b=rgu7TsCqdaabG4yBgPdns6tQAbMOuTsVju0H4YZ68MRVCJM+IXiUWYNOJ0kWD6tv2OTnXN+9Vco+wc4Eu/BzDnOWl6JuQ/FV5wlnKn/tkVfy/qRwaiiVDnE9tSosKNrwC98KnD1H8zfKboz6EYnyxPNWxGkoue5wRzFv6kA8XYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 43d0795174294d89904cf0b7504238dd-20240118
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:1c0bfad0-7b29-415b-9fa2-010a6f2d21e5,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-9,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:1
X-CID-INFO: VERSION:1.1.35,REQID:1c0bfad0-7b29-415b-9fa2-010a6f2d21e5,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-9,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:1
X-CID-META: VersionHash:5d391d7,CLOUDID:7c56f882-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:240118101702QKGYL0XV,BulkQuantity:0,Recheck:0,SF:38|24|17|19|42|74|6
	4|66|102,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:
	nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 43d0795174294d89904cf0b7504238dd-20240118
Received: from mail.kylinos.cn [(39.156.73.10)] by mailgw
	(envelope-from <chentao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1202952070; Thu, 18 Jan 2024 10:17:02 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id B3C66E000EB9;
	Thu, 18 Jan 2024 10:17:01 +0800 (CST)
X-ns-mid: postfix-65A88A1D-552403442
Received: from [172.20.15.234] (unknown [172.20.15.234])
	by mail.kylinos.cn (NSMail) with ESMTPA id 36366E000EB9;
	Thu, 18 Jan 2024 10:16:58 +0800 (CST)
Message-ID: <4d4f4ae4-e5e9-4d9e-ac25-d262e7ea23fc@kylinos.cn>
Date: Thu, 18 Jan 2024 10:16:57 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/msm/adreno: Add a null pointer check in
 zap_shader_load_mdt()
Content-Language: en-US
To: Markus Elfring <Markus.Elfring@web.de>, freedreno@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 kernel-janitors@vger.kernel.org, Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20240116032732.65262-1-chentao@kylinos.cn>
 <9e390783-05c5-47fc-a0c6-b95e249fe691@web.de>
From: Kunwu Chan <chentao@kylinos.cn>
In-Reply-To: <9e390783-05c5-47fc-a0c6-b95e249fe691@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 2024/1/18 02:50, Markus Elfring wrote:
>> kasprintf() returns a pointer to dynamically allocated memory
>> which can be NULL upon failure. Ensure the allocation was successful
>> by checking the pointer validity.
> =E2=80=A6
>> +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
>> @@ -144,6 +144,10 @@ static int zap_shader_load_mdt(struct msm_gpu *gp=
u, const char *fwname,
>>   		char *newname;
>>
>>   		newname =3D kasprintf(GFP_KERNEL, "qcom/%s", fwname);
>> +		if (!newname) {
>> +			ret =3D -ENOMEM;
>> +			goto out;
>> +		}
> =E2=80=A6
>=20
> How do you think about to avoid the repetition of the pointer check
> for the variable =E2=80=9Cmem_region=E2=80=9D?
"mem_region"? Is this a clerical error, do you mean 'newname'?

No check found in __qcom_mdt_load for 'newname'.
'newname' is used for printing in '__qcom_mdt_load' in some cases, which=20
is a bit dangerous.
So it's necessary check it before using it.

> Can the usage of other labels become more appropriate?
>=20
> Regards,
> Markus
--=20
Thanks,
   Kunwu


