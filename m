Return-Path: <linux-kernel+bounces-32538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D94835CDA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 09:41:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F8561F237D2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 08:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 374D33613A;
	Mon, 22 Jan 2024 08:41:29 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7269C21350;
	Mon, 22 Jan 2024 08:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705912888; cv=none; b=eTF1OKKkEDr0yl8dn3JFXf4tewOa5mnLiUj+6aavWN3Fr+vIbIamIjl/Wa5dxjv9HnDR4nNVpG5rA/lsXANZtjUKLKzq0aizV5Mtsbhxj7gsebM25TIf3JNko4xZDjrNrPHyxZS0JwKSJ6GmKOfzhP9nYjRvJBtfo/1wfM2ESYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705912888; c=relaxed/simple;
	bh=ctuCC6ALFN33W1D3yQUnrYtqv9x78RMPK2D2cHZUDMI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TITRaHrQK6jdW9YZgfj4mgmjsGbzVFJl6u4/ccUBnpT04C9NFVieZwgVHsZevAPizEkdAAd0+5UGgm/ak7c7PY6CEVkiqEYGqQH5mehNPgkyf9tFmaHBrh23FY7hnnvbFvrzBo3OW6mq2OHE/tqbWWZLCGgtFeu7cDw2D7i6IsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: d1c2b83a7e904730825e5b96ad735542-20240122
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:1c271f4d-649e-4a00-a195-b02e349e0fd6,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-3,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:7
X-CID-INFO: VERSION:1.1.35,REQID:1c271f4d-649e-4a00-a195-b02e349e0fd6,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-3,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:7
X-CID-META: VersionHash:5d391d7,CLOUDID:aa021d83-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:240122163022SO5X7JXR,BulkQuantity:4,Recheck:0,SF:64|66|24|100|17|19|
	44|101|102,TC:nil,Content:0,EDM:-3,IP:-2,URL:1,File:nil,Bulk:40,QS:nil,BEC
	:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,
	TF_CID_SPAM_ULS
X-UUID: d1c2b83a7e904730825e5b96ad735542-20240122
Received: from mail.kylinos.cn [(39.156.73.10)] by mailgw
	(envelope-from <chentao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 292773570; Mon, 22 Jan 2024 16:41:16 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 864D4E000EB9;
	Mon, 22 Jan 2024 16:41:16 +0800 (CST)
X-ns-mid: postfix-65AE2A2C-464608384
Received: from [172.20.15.234] (unknown [172.20.15.234])
	by mail.kylinos.cn (NSMail) with ESMTPA id 3F59DE000EB9;
	Mon, 22 Jan 2024 16:41:14 +0800 (CST)
Message-ID: <39c6bc5c-8c91-4c91-a694-e27fa435f082@kylinos.cn>
Date: Mon, 22 Jan 2024 16:41:14 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] x86/xen: Add some null pointer checking to smp.c
Content-Language: en-US
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Markus Elfring <Markus.Elfring@web.de>, xen-devel@lists.xenproject.org,
 kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 kernel test robot <lkp@intel.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>, Borislav Petkov
 <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
 =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org
References: <20240117090018.152031-1-chentao@kylinos.cn>
 <1705655941162581.825.seg@mailgw>
 <517fae75-c4e7-4576-81ff-6a14a3eb9cd7@kylinos.cn>
 <dfb6de51-3ebc-41fc-a750-cf5ca2ac05aa@moroto.mountain>
From: Kunwu Chan <chentao@kylinos.cn>
In-Reply-To: <dfb6de51-3ebc-41fc-a750-cf5ca2ac05aa@moroto.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 2024/1/22 16:30, Dan Carpenter wrote:
> On Fri, Jan 19, 2024 at 05:22:25PM +0800, Kunwu Chan wrote:
>> On 2024/1/17 18:40, Markus Elfring wrote:
>>>> kasprintf() returns a pointer to dynamically allocated memory
>>>> which can be NULL upon failure. Ensure the allocation was successful
>>>> by checking the pointer validity.
>>> =E2=80=A6
>>>> +++ b/arch/x86/xen/smp.c
>>>> @@ -61,10 +61,14 @@ void xen_smp_intr_free(unsigned int cpu)
>>>>
>>>>    int xen_smp_intr_init(unsigned int cpu)
>>>>    {
>>>> -	int rc;
>>>> +	int rc =3D 0;
>>>
>>> I find the indication of a successful function execution sufficient b=
y
>>> the statement =E2=80=9Creturn 0;=E2=80=9D at the end.
>>> How do you think about to omit such an extra variable initialisation?
>> Thanks, it's no need now. I'll remove it in v3.
>=20
> This advice is good.  Don't do unnecessary assignments.
Thanks for your suggestions, I'll keep it in mind.
>=20
>>>
>>>
>>>>    	char *resched_name, *callfunc_name, *debug_name;
>>>>
>>>>    	resched_name =3D kasprintf(GFP_KERNEL, "resched%d", cpu);
>>>> +	if (!resched_name) {
>>>> +		rc =3D -ENOMEM;
>>>> +		goto fail;
>>>> +	}
>>>>    	per_cpu(xen_resched_irq, cpu).name =3D resched_name;
>>>>    	rc =3D bind_ipi_to_irqhandler(XEN_RESCHEDULE_VECTOR,
>>>>    				    cpu,
>>>
>>> You propose to apply the same error code in four if branches.
>>> I suggest to avoid the specification of duplicate assignment statemen=
ts
>>> for this purpose.
>>> How do you think about to use another label like =E2=80=9Ce_nomem=E2=80=
=9D?
>> I'll add a new label to simply the code.
>=20
> I'm not a Xen maintainer so I can't really comment on their style
> choices.  However, as one of the kernel-janitors list people, I would
> say that not everyone agrees with Markus's style preferences.  Markus
> was banned from the list for a while, but we unbanned everyone when we
> transitioned to the new list infrastructure.  Do a search on lore to
> find out more.  https://lore.kernel.org/all/?q=3DElfring
>=20
> Perhaps wait for feedback from the maintainers for how to proceed?
OK, I'll wait for the feedback.
>=20
> regards,
> dan carpenter
>=20
--=20
Thanks,
   Kunwu


