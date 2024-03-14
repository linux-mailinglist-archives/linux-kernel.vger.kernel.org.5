Return-Path: <linux-kernel+bounces-102868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2A0A87B7D6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 07:14:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E2BC282A8F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 06:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A44EFC0E;
	Thu, 14 Mar 2024 06:13:57 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC71BFBF7
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 06:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710396837; cv=none; b=IfpqAhDdtBGWSBXBUe2c8ObdJ9AuKwRBfxXo8Qe78B3ovKv5KD+MTqn9hvSUgSzBP8uaLFccVYeIF5rEpwQgYK6KI6joKeAyjrnIMsg0Q0J577ikYFpfxX0XH3SsDNVzD00AJE4bYKVkcDEXe0ZIBUfuAenAyovcIRkX9KU+4ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710396837; c=relaxed/simple;
	bh=LpEQ15/BcP/fjuXF4e27uGFBrsT+jVtbbeHCru6Nh3o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RdY/LRBDuJqmF9Gpv0WeKnmZ8SkZskOkhLNbI54F9wozHLl5AA1mkRXY/gLZf8waRkP7arUwH0+JS9jZxnA5R/CO6BqRsmXRrijNLf7q4CZbvyKR+CNWnauSz44AWhudEGwVnmnj/3wneVhRwNzHZhpGbVMZAotRlbfdjC32PwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 87f24640804442478ab4c0c41f2ed086-20240314
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:6431f97b-90c6-43f5-83bc-0e24c63277cb,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-5
X-CID-INFO: VERSION:1.1.37,REQID:6431f97b-90c6-43f5-83bc-0e24c63277cb,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:6f543d0,CLOUDID:dbb96390-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:240314141347PQQTX76M,BulkQuantity:0,Recheck:0,SF:64|66|38|24|17|19|4
	4|102,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,
	BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 87f24640804442478ab4c0c41f2ed086-20240314
Received: from node2.com.cn [(39.156.73.10)] by mailgw
	(envelope-from <mengfanhui@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 657671404; Thu, 14 Mar 2024 14:13:46 +0800
Received: from node2.com.cn (localhost [127.0.0.1])
	by node2.com.cn (NSMail) with SMTP id 5C173B80758A;
	Thu, 14 Mar 2024 14:13:46 +0800 (CST)
X-ns-mid: postfix-65F2959A-259172168
Received: from [172.30.60.81] (unknown [172.30.60.81])
	by node2.com.cn (NSMail) with ESMTPA id 1CA6CB80758A;
	Thu, 14 Mar 2024 06:13:40 +0000 (UTC)
Message-ID: <c934831a-ec84-4ea4-a156-782880086ffe@kylinos.cn>
Date: Thu, 14 Mar 2024 14:13:39 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-multipath: fix bogus request queue reference put
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: kbusch@kernel.org, axboe@kernel.dk, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <20240117065043.79192-1-mengfanhui@kylinos.cn>
 <b926d754-130d-424e-b099-001e14badc50@grimberg.me>
 <20240117143952.GA27918@lst.de>
From: mengfanhui <mengfanhui@kylinos.cn>
In-Reply-To: <20240117143952.GA27918@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Purpose that to check if we ever added a live path (using
NVME_NS_HEAD_HAS_DISK flag) and if not, clear the disk->queue
reference.The purpose is to perform security checks and remove the disk.


=E5=9C=A8 2024/1/17 22:39, Christoph Hellwig =E5=86=99=E9=81=93:
> On Wed, Jan 17, 2024 at 04:04:12PM +0200, Sagi Grimberg wrote:
>> How did you see this? disk->queue is allocated in blk_alloc_disk calle=
d
>> in nvme_mpath_alloc_disk... I don't understand how you saw the same
>> dereference that was addressed by this commit.
>=20
> This looks like a backport of an old patch of yours to a geriatric
> kernel to me..

