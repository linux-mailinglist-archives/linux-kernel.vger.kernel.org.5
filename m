Return-Path: <linux-kernel+bounces-32449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF1FA835BDC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 08:43:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E29031C218ED
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 07:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D6FC168A2;
	Mon, 22 Jan 2024 07:43:29 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83D8182C1;
	Mon, 22 Jan 2024 07:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705909408; cv=none; b=bz11AZQqGorGuc26ZgiPa5GxUJbmchZ1rdW/yATN2WERGWo2wXKsQcS70lnKUSRSCbXL0NEavki9mK3sPDXZNFK/n/MEVR3Fr+2YgeYq8KwpdmIQdBcGSlNYJ2i4iNVeFo7ZJA5/i5P0js7CWHv68ZeJaYk/uNn8c91n2IJDssc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705909408; c=relaxed/simple;
	bh=GJqZTyh9DHsWFxIGt8PhKifM6fso8l/lQuO4c5h0oz8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t9pWjx8lC3Ve3RSR4Tarq4MF7ymGjLPPj/e+CtmLEc4XggtvtSHQ+yOFxCI7W5ivTjIEmPHbbsfir0613ZVFUkt7REcQrQsH4cqlU2xcJVxAmOH4XY6Kk+6XUTUWV2KXNFkyYeADhan5G4ROr4N3Gb+YJz+pcKy0jJ6/7U98ISw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 0b78ecab05a04d719b47471461e9eca0-20240122
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:2c7f558f-ccf3-45f4-a733-29bf9d7726bb,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-3,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:7
X-CID-INFO: VERSION:1.1.35,REQID:2c7f558f-ccf3-45f4-a733-29bf9d7726bb,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-3,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:7
X-CID-META: VersionHash:5d391d7,CLOUDID:e96f838e-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:240119184126L868QB56,BulkQuantity:10,Recheck:0,SF:64|38|24|100|17|66
	|19|44|101|102,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:40,QS:nil
	,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,
	TF_CID_SPAM_OBB
X-UUID: 0b78ecab05a04d719b47471461e9eca0-20240122
Received: from mail.kylinos.cn [(39.156.73.10)] by mailgw
	(envelope-from <chentao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1393669554; Mon, 22 Jan 2024 15:43:20 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 7F0F3E000EB9;
	Mon, 22 Jan 2024 15:43:20 +0800 (CST)
X-ns-mid: postfix-65AE1C98-394330182
Received: from [172.20.15.234] (unknown [172.20.15.234])
	by mail.kylinos.cn (NSMail) with ESMTPA id 7C470E000EB9;
	Mon, 22 Jan 2024 15:43:16 +0800 (CST)
Message-ID: <6f25f54f-eecc-4765-bdc4-248674836e77@kylinos.cn>
Date: Mon, 22 Jan 2024 15:43:15 +0800
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
Cc: kernel test robot <lkp@intel.com>, LKML <linux-kernel@vger.kernel.org>,
 Ilya Dryomov <idryomov@gmail.com>, Jean Delvare <jdelvare@suse.de>,
 Jonathan Corbet <corbet@lwn.net>
References: <20240119094948.275390-1-chentao@kylinos.cn>
 <26ef811d-214c-4ce4-a9f8-4fa4cfdefe29@web.de>
From: Kunwu Chan <chentao@kylinos.cn>
In-Reply-To: <26ef811d-214c-4ce4-a9f8-4fa4cfdefe29@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 2024/1/20 22:45, Markus Elfring wrote:
>> kasprintf() returns a pointer to dynamically allocated memory
>> which can be NULL upon failure. Ensure the allocation was successful
>> by checking the pointer validity.
>=20
> How do you think about to refer to the function name
> instead of the file name in the patch subject?
>=20
The main goal is to assign a errno to rc. So use 'fail_mem is good to=20
understand.
>=20
> =E2=80=A6
>> +++ b/arch/x86/xen/smp.c
> =E2=80=A6
>> @@ -114,6 +124,8 @@ int xen_smp_intr_init(unsigned int cpu)
>>
>>   	return 0;
>>
>> + fail_mem:
>> +	rc =3D -ENOMEM;
>>    fail:
>>   	xen_smp_intr_free(cpu);
>>   	return rc;
>=20
> Is it currently preferred to start labels in the first text column?
Just the same as the old one. I could fix it if necessary.

>=20
> Regards,
> Markus
--=20
Thanks,
   Kunwu


