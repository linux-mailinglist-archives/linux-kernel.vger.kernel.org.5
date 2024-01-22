Return-Path: <linux-kernel+bounces-32462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC415835BFC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 08:48:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE8291C23F3F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 07:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0F4A1864C;
	Mon, 22 Jan 2024 07:47:24 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56DD217BDB;
	Mon, 22 Jan 2024 07:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705909644; cv=none; b=rt/OCWpt6bRbOOvTS1af7ZmYenbYCkycwrRB3NDOf+Ias4ddCqie4faRm4J+uKRJfqtoW7n5kIzj9zxouUZUOh6jTo62YYOOCpnW7bUk1XGXKWl3X7nC5DazJDhFaOeuktu3LmwpBPfJRn7w+G02W1bqKmuItMCdZDHbVuIpKWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705909644; c=relaxed/simple;
	bh=Uv+psVs71l3mYBTEtoJ9zpYjshD94k7VzSuOI7ZEPY8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iHA/WrxIV+5A2cZTjcnGOW+yo3eeqPCyh1DL6v3lYdIYaT8o+MirBWforJWCYrPqBjIa1p0pKQ3JEGUVE4Z+DZ2FIGRImjBRg1ZHSpyqEsaKTNErRG81MbkKP16Jk3nHE7yOw/c+9Oe/9rF2hMosACr9tYtf3BKdycb5m5DF0nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 565b878a508849b98085f4b287cfd53f-20240122
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:341d19ce-db61-4755-8c58-6ce5c2018139,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-3,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:7
X-CID-INFO: VERSION:1.1.35,REQID:341d19ce-db61-4755-8c58-6ce5c2018139,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-3,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:7
X-CID-META: VersionHash:5d391d7,CLOUDID:6bb26d2f-1ab8-4133-9780-81938111c800,B
	ulkID:240119184126L868QB56,BulkQuantity:15,Recheck:0,SF:66|38|24|100|19|44
	|64|17|101|102,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:40,QS:nil
	,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,
	TF_CID_SPAM_OBB
X-UUID: 565b878a508849b98085f4b287cfd53f-20240122
Received: from mail.kylinos.cn [(39.156.73.10)] by mailgw
	(envelope-from <chentao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 935448798; Mon, 22 Jan 2024 15:47:13 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id EB762E000EB9;
	Mon, 22 Jan 2024 15:47:12 +0800 (CST)
X-ns-mid: postfix-65AE1D80-872727190
Received: from [172.20.15.234] (unknown [172.20.15.234])
	by mail.kylinos.cn (NSMail) with ESMTPA id 0A1E9E000EB9;
	Mon, 22 Jan 2024 15:47:01 +0800 (CST)
Message-ID: <e7a6add0-5526-4efd-8b00-07e399e292c1@kylinos.cn>
Date: Mon, 22 Jan 2024 15:47:01 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] x86/xen: Add some null pointer checking to smp.c
Content-Language: en-US
To: Markus Elfring <Markus.Elfring@web.de>, xen-devel@lists.xenproject.org,
 kernel-janitors@vger.kernel.org, Boris Ostrovsky
 <boris.ostrovsky@oracle.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Ingo Molnar <mingo@redhat.com>, =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?=
 <jgross@suse.com>, Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org
Cc: kernel test robot <lkp@intel.com>, LKML <linux-kernel@vger.kernel.org>
References: <20240119094948.275390-1-chentao@kylinos.cn>
 <91af4a8c-d2e2-416f-b02e-5d69553c5998@web.de>
From: Kunwu Chan <chentao@kylinos.cn>
In-Reply-To: <91af4a8c-d2e2-416f-b02e-5d69553c5998@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 2024/1/19 18:40, Markus Elfring wrote:
>> kasprintf() returns a pointer to dynamically allocated memory
>> which can be NULL upon failure. Ensure the allocation was successful
>> by checking the pointer validity.
> =E2=80=A6
>> ---
>> Changes in v3:
>>      - Remove rc initialization
>>      - Simply error paths by adding a new label 'fail_mem'
> =E2=80=A6
>=20
> I became curious if you would like to simplify further source code plac=
es.
This function hasn't changed in years, so it's OK for now.
>=20
>=20
>> +++ b/arch/x86/xen/smp.c
>> @@ -65,6 +65,8 @@ int xen_smp_intr_init(unsigned int cpu)
>>   	char *resched_name, *callfunc_name, *debug_name;
>>
>>   	resched_name =3D kasprintf(GFP_KERNEL, "resched%d", cpu);
>> +	if (!resched_name)
>> +		goto fail_mem;
>=20
> Would you like to add a blank line after such a statement?
Sure, I could do it in next patch.
>=20
>=20
>>   	per_cpu(xen_resched_irq, cpu).name =3D resched_name;
> =E2=80=A6
>=20
> Please compare with your subsequent suggestion.
I=E2=80=99ve seend a reply.
>=20
> =E2=80=A6
>> @@ -101,6 +108,9 @@ int xen_smp_intr_init(unsigned int cpu)
>>   	}
>>
>>   	callfunc_name =3D kasprintf(GFP_KERNEL, "callfuncsingle%d", cpu);
>> +	if (!callfunc_name)
>> +		goto fail_mem;
>> +
>>   	per_cpu(xen_callfuncsingle_irq, cpu).name =3D callfunc_name;
> =E2=80=A6
>=20
> Regards,
> Markus
--=20
Thanks,
   Kunwu


