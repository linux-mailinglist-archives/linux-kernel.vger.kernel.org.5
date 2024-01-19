Return-Path: <linux-kernel+bounces-30945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96EE783267A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 10:22:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D32651C22CBD
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 09:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EAB8288CE;
	Fri, 19 Jan 2024 09:22:50 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F84D26AEC;
	Fri, 19 Jan 2024 09:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705656169; cv=none; b=eOAZSc+CdXeRYJrpY5ZRVWkURy6uur2jpo88TXB2RUdEZlH/CMLBpQNrzsUR12qAJ/xnBzFn9Yx4FhuWEGDl/32XguDVPf1BYyYMOn8HFedEbl9tXbgruQWfi6sCfrsDMYgiitUXgYT58OlKmq5OwWD8UvJkAEuOhWthPrx5guM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705656169; c=relaxed/simple;
	bh=N9FUij+Gv7vcYaUX9+UtvBQrZdEYrKAc7y0cF6kUUcM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gVVAIh2P7YvlKfFxoAHEKA5musSrjIgQaFYX18CAENy70KygSOlF2KwZWD53Y5QqLC51Mz1c9hLHeaODnnUrW5TcP4IReVGsE9HtNKw7ooS0IbEE0Zw15f4tJbhuBp8/2SQS149BcnRZP2ZKJTbCFupDtSWIYy3A4PFLO0j2WRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 5eb2d7502dca4681b1c1b85464ee8963-20240119
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:645a9bb7-9aee-47af-8dff-de50fb4a484f,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-3,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:7
X-CID-INFO: VERSION:1.1.35,REQID:645a9bb7-9aee-47af-8dff-de50fb4a484f,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-3,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:7
X-CID-META: VersionHash:5d391d7,CLOUDID:e3ee877f-4f93-4875-95e7-8c66ea833d57,B
	ulkID:240119172239A7QKR7U4,BulkQuantity:0,Recheck:0,SF:17|101|24|100|38|19
	|44|64|66|102,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil
	,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 5eb2d7502dca4681b1c1b85464ee8963-20240119
Received: from mail.kylinos.cn [(39.156.73.10)] by mailgw
	(envelope-from <chentao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1484895239; Fri, 19 Jan 2024 17:22:37 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 426E3E000EB9;
	Fri, 19 Jan 2024 17:22:35 +0800 (CST)
X-ns-mid: postfix-65AA3F5B-1855721587
Received: from [172.20.15.234] (unknown [172.20.15.234])
	by mail.kylinos.cn (NSMail) with ESMTPA id 338B4E000EB9;
	Fri, 19 Jan 2024 17:22:26 +0800 (CST)
Message-ID: <517fae75-c4e7-4576-81ff-6a14a3eb9cd7@kylinos.cn>
Date: Fri, 19 Jan 2024 17:22:25 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] x86/xen: Add some null pointer checking to smp.c
To: Markus Elfring <Markus.Elfring@web.de>, xen-devel@lists.xenproject.org,
 kernel-janitors@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, kernel test robot <lkp@intel.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>, Borislav Petkov
 <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
 =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org
References: <20240117090018.152031-1-chentao@kylinos.cn>
 <1705655941162581.825.seg@mailgw>
Content-Language: en-US
From: Kunwu Chan <chentao@kylinos.cn>
In-Reply-To: <1705655941162581.825.seg@mailgw>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 2024/1/17 18:40, Markus Elfring wrote:
>> kasprintf() returns a pointer to dynamically allocated memory
>> which can be NULL upon failure. Ensure the allocation was successful
>> by checking the pointer validity.
> =E2=80=A6
>> +++ b/arch/x86/xen/smp.c
>> @@ -61,10 +61,14 @@ void xen_smp_intr_free(unsigned int cpu)
>>
>>   int xen_smp_intr_init(unsigned int cpu)
>>   {
>> -	int rc;
>> +	int rc =3D 0;
>=20
> I find the indication of a successful function execution sufficient by
> the statement =E2=80=9Creturn 0;=E2=80=9D at the end.
> How do you think about to omit such an extra variable initialisation?
Thanks, it's no need now. I'll remove it in v3.
>=20
>=20
>>   	char *resched_name, *callfunc_name, *debug_name;
>>
>>   	resched_name =3D kasprintf(GFP_KERNEL, "resched%d", cpu);
>> +	if (!resched_name) {
>> +		rc =3D -ENOMEM;
>> +		goto fail;
>> +	}
>>   	per_cpu(xen_resched_irq, cpu).name =3D resched_name;
>>   	rc =3D bind_ipi_to_irqhandler(XEN_RESCHEDULE_VECTOR,
>>   				    cpu,
>=20
> You propose to apply the same error code in four if branches.
> I suggest to avoid the specification of duplicate assignment statements
> for this purpose.
> How do you think about to use another label like =E2=80=9Ce_nomem=E2=80=
=9D?
I'll add a new label to simply the code.
>=20
> Regards,
> Markus
--=20
Thanks,
   Kunwu


