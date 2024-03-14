Return-Path: <linux-kernel+bounces-102792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D2C087B758
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 06:42:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CD521C22420
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 05:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC963DDDD;
	Thu, 14 Mar 2024 05:42:41 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FEA0DDA7;
	Thu, 14 Mar 2024 05:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710394961; cv=none; b=YgIIhBf0kl6Mlql4SGdOIjw2XQ2ZRWI3qgMLkD7YLw/bPFI+PABMh/2mDtIkiT0pFGJ3kWhknZX/jsZ4G5GrfqG7DXPTR14K82UqnIimjLn35wKS/UPYfS59k6AJUNfU8VOXHB/W27C7vKU99ujbC4M6QRiBHpI4txIyhixBaKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710394961; c=relaxed/simple;
	bh=q4opjsWHj+629bWbOdiv1U772HYHuAhm44wPQjZJhmQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bpoY4LnqeqTR/fPZf9w569OSU5vRTvT42fJ7rMljBPxQUkR7sfFAkM5BBhQ8ASV7NB+pOreGzhdxqNzkxJPIjeJrKgcxiFWgYgGUiXzO97xz79VFspAHcR506Ud+7k8LzBVBmX4sOoQmEtGdXUK5CAh1FIDfzhRF6oIs/7KgzQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 32181cd6d7b44b34a71fd0a955640ca6-20240314
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:a2ddc792-8023-47b7-9472-28572f865d8c,IP:10,
	URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:-10
X-CID-INFO: VERSION:1.1.37,REQID:a2ddc792-8023-47b7-9472-28572f865d8c,IP:10,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-10
X-CID-META: VersionHash:6f543d0,CLOUDID:879afc84-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:240314134234G2IK928B,BulkQuantity:0,Recheck:0,SF:24|17|19|44|64|66|3
	8|102,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,
	BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 32181cd6d7b44b34a71fd0a955640ca6-20240314
Received: from node2.com.cn [(39.156.73.10)] by mailgw
	(envelope-from <mengfanhui@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1457791164; Thu, 14 Mar 2024 13:42:33 +0800
Received: from node2.com.cn (localhost [127.0.0.1])
	by node2.com.cn (NSMail) with SMTP id F2DB9B80758A;
	Thu, 14 Mar 2024 13:42:32 +0800 (CST)
X-ns-mid: postfix-65F28E48-94542613
Received: from [172.30.60.81] (unknown [172.30.60.81])
	by node2.com.cn (NSMail) with ESMTPA id 649E3B80758A;
	Thu, 14 Mar 2024 05:42:32 +0000 (UTC)
Message-ID: <4acb6f4e-5d91-462f-a741-d7839593cbdc@kylinos.cn>
Date: Thu, 14 Mar 2024 13:42:31 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scsi: megaraid_sas: disabled shared host tagset feature
 by default
Content-Language: en-US
To: John Garry <john.g.garry@oracle.com>, kashyap.desai@broadcom.com,
 sumit.saxena@broadcom.com, shivasharan.srikanteshwara@broadcom.com,
 chandrakanth.patil@broadcom.com
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240311085412.2391632-1-mengfanhui@kylinos.cn>
 <03afee77-3d5e-44fc-9e03-eec70c9cee2a@oracle.com>
From: mengfanhui <mengfanhui@kylinos.cn>
In-Reply-To: <03afee77-3d5e-44fc-9e03-eec70c9cee2a@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

We are analyzing the kylinos issue and found that the performance degrada=
tion caused by patch 103fbf8e4020845e4fcf63819288cedb092a3c91.
It will change the working mode of the disk, It will lead to performance =
degradation.Currently driver has provision to disable host-wide=20
tags using "host_tagset_enable" module parameter.


=E5=9C=A8 2024/3/11 17:30, John Garry =E5=86=99=E9=81=93:
> On 11/03/2024 08:54, mengfanhui wrote:
>> By default, the host_tagset_enable feature is disabled=EF=BC=8CFio per=
formance
>> has improved significantly
>>
>> fio test command:
>> sudo fio -filename=3D/fio_test -direct=3D1 -iodepth 32 -thread -rw=3Dw=
rite -ioengine=3Dlibaio
>> -bs=3D4K -size=3D5120M -runtime=3D600 -numjobs=3D$CPUN -group_reportin=
g -name=3D**.result >> **.result
>>
>> The test data results bw=C2=A0 are as follows=EF=BC=9A
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 v6.8_kernel=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 v6.8_kernel_=
disable_host_tagset
>> 4k randwrite=C2=A0=C2=A0=C2=A0=C2=A0 375=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 642
>> 4k randread=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 210=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 784
>> 4k=C2=A0 write=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 306=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 387
>> 4k=C2=A0 read=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 435=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2457
>> 128k write=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 355=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 380
>> 128k read=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 976=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 3665
>> 1M=C2=A0=C2=A0 read=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 415=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 3122
>>
>=20
> There are some huge differences in those numbers. Can you find out what=
 is going on?
>=20
>> Signed-off-by: mengfanhui <mengfanhui@kylinos.cn>
>> ---
>> =C2=A0 drivers/scsi/megaraid/megaraid_sas_base.c | 4 ++--
>> =C2=A0 1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c b/drivers/scsi/=
megaraid/megaraid_sas_base.c
>> index 3d4f13da1ae8..da19c4c07f2f 100644
>> --- a/drivers/scsi/megaraid/megaraid_sas_base.c
>> +++ b/drivers/scsi/megaraid/megaraid_sas_base.c
>> @@ -123,9 +123,9 @@ MODULE_PARM_DESC(poll_queues, "Number of queues to=
 be use for io_uring poll mode
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "High iops queu=
es are not allocated &\n\t\t"
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 );
>> =C2=A0 -int host_tagset_enable =3D 1;
>> +int host_tagset_enable;
>> =C2=A0 module_param(host_tagset_enable, int, 0444);
>> -MODULE_PARM_DESC(host_tagset_enable, "Shared host tagset enable/disab=
le Default: enable(1)");
>> +MODULE_PARM_DESC(host_tagset_enable, "Shared host tagset enable/disab=
le Default: disable(0)");
>> =C2=A0 =C2=A0 MODULE_LICENSE("GPL");
>> =C2=A0 MODULE_VERSION(MEGASAS_VERSION);
>=20

