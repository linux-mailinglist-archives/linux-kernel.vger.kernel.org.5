Return-Path: <linux-kernel+bounces-108336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B1E7880957
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 03:04:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCEA31C2289D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 02:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 978A0DDB6;
	Wed, 20 Mar 2024 02:04:10 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD04CA47
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 02:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710900250; cv=none; b=VQ/KWwOzVxOB6G1T6YqupwyCoUuKiI+EJRX/wNJl4A0SndLOaTmLEgGotCF3VqUQvgRAMVKDsLNL0hW+Ufs/5qMe8atjNqXTuMzBOGj0mMBfKpdy8bOT2ZuiS7XwfNM3MIETJvRNxEjDzGAId1+AXqEaaG3fkJI+AP4w3TGw+y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710900250; c=relaxed/simple;
	bh=PjjczS54NogO0z+rb8DGB1jcxiUuzEJDgOVttCWNf7Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pCSdMnQN3VEP4h5gYXCKhqU1xmWH1Dyh7wpqs4aAIWh6dxYMkkNCSWFEk73J9l1D+LZlBPQffLT3OinX8hEQecHBr5kGUPpl9baxfaC2eSuuM0skDDRgw2OIb+DQmJcuyEDh1Lwf4zdDy7/REF9aHYEivGjH3WsGT1wvDG1VcAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 31e0712471394ab2a45d5f3a5156d8c5-20240320
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:f39104b1-0722-46ae-85ff-dcacc47790f9,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-5
X-CID-INFO: VERSION:1.1.37,REQID:f39104b1-0722-46ae-85ff-dcacc47790f9,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:6f543d0,CLOUDID:54d9b281-4f93-4875-95e7-8c66ea833d57,B
	ulkID:240320100359XVS0S5PH,BulkQuantity:0,Recheck:0,SF:24|17|19|44|64|66|3
	8|102,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,
	BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 31e0712471394ab2a45d5f3a5156d8c5-20240320
Received: from node2.com.cn [(39.156.73.10)] by mailgw
	(envelope-from <mengfanhui@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 568160103; Wed, 20 Mar 2024 10:03:58 +0800
Received: from node2.com.cn (localhost [127.0.0.1])
	by node2.com.cn (NSMail) with SMTP id 6073AB803C9B;
	Wed, 20 Mar 2024 10:03:58 +0800 (CST)
X-ns-mid: postfix-65FA440E-300850206
Received: from [172.30.60.81] (unknown [172.30.60.81])
	by node2.com.cn (NSMail) with ESMTPA id 72654B80758A;
	Wed, 20 Mar 2024 02:03:55 +0000 (UTC)
Message-ID: <4b9e1f54-9032-48b6-bfbb-d47a4b7857e3@kylinos.cn>
Date: Wed, 20 Mar 2024 10:03:54 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-multipath: fix bogus request queue reference put
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
Cc: kbusch@kernel.org, axboe@kernel.dk, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <20240117065043.79192-1-mengfanhui@kylinos.cn>
 <b926d754-130d-424e-b099-001e14badc50@grimberg.me>
 <20240117143952.GA27918@lst.de>
 <c934831a-ec84-4ea4-a156-782880086ffe@kylinos.cn>
 <2db9e75c-7c17-4f1d-9328-5eb18fd86d23@grimberg.me>
From: mengfanhui <mengfanhui@kylinos.cn>
In-Reply-To: <2db9e75c-7c17-4f1d-9328-5eb18fd86d23@grimberg.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

In this scenario. upstream should also appear.

=E5=9C=A8 2024/3/17 15:33, Sagi Grimberg =E5=86=99=E9=81=93:
>=20
>=20
> On 14/03/2024 8:13, mengfanhui wrote:
>> Purpose that to check if we ever added a live path (using
>> NVME_NS_HEAD_HAS_DISK flag) and if not, clear the disk->queue
>> reference.The purpose is to perform security checks and remove the dis=
k.
>=20
> Does this issue happen in upstream? If it isn't I don't see a reason to=
 fix
> a non-existing bug here.

