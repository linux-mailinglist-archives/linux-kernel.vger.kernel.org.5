Return-Path: <linux-kernel+bounces-45960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97166843863
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 08:57:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 546C92830D7
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 07:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ABA35674C;
	Wed, 31 Jan 2024 07:57:13 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3329D5810E;
	Wed, 31 Jan 2024 07:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706687833; cv=none; b=mGVCPpUwIFMUSAqBFw89KldYZ80a6eWqxHAkiCAF43dTFrlyU89wyiEz2h1UDFhvxrUPuZL34N4mMVGt7h+nt4tSnSQHC4dnNXQlhstycTjTvlRDXjQtQZxkSIxEi8UvblG/km3Pye+VrQRONN1JJsHo3HA1kbiNetxipsGfY9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706687833; c=relaxed/simple;
	bh=99SeZatDMPtezDmzO6oEg456DIbwULn5JFXOtMUUqwY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cI+A+QnSAtqZ8nJVJ4+pMCeVLv+RB3h4cqAVwftCXQ9v8BIeCklaR/OB6THXlee0Dgq3F8J4Pc9E13R+iaZ8SehryU2hztEax5A1QhvBSTQM2MMARKYDrwE3X8VVicB1djYY6XnjsIgZeQnV1ZUXq6jRHJeFDT08XbyJgj0iRtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 1ade5341a11146fa9152a9d51dd07ba5-20240131
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:85a113a6-6761-4665-86db-e241333da25f,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-5
X-CID-INFO: VERSION:1.1.35,REQID:85a113a6-6761-4665-86db-e241333da25f,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:5d391d7,CLOUDID:1760f47f-4f93-4875-95e7-8c66ea833d57,B
	ulkID:240130180543X6ZRP1RW,BulkQuantity:6,Recheck:0,SF:44|66|24|17|19|102,
	TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:40,QS:nil,BEC:nil,COL:0,
	OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 1ade5341a11146fa9152a9d51dd07ba5-20240131
Received: from mail.kylinos.cn [(39.156.73.10)] by mailgw
	(envelope-from <chentao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1754181887; Wed, 31 Jan 2024 15:57:00 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 1EB22E000EB9;
	Wed, 31 Jan 2024 15:57:00 +0800 (CST)
X-ns-mid: postfix-65B9FD4C-45236581
Received: from [172.20.15.254] (unknown [172.20.15.254])
	by mail.kylinos.cn (NSMail) with ESMTPA id 10088E000EB9;
	Wed, 31 Jan 2024 15:56:58 +0800 (CST)
Message-ID: <202e349f-a45a-46cb-ab8e-ff44c12b3628@kylinos.cn>
Date: Wed, 31 Jan 2024 15:56:58 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: ipv4: Simplify the allocation of slab
 caches in inet_initpeers
To: jiri@resnulli.us
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com
References: <20240130092255.73078-1-chentao@kylinos.cn>
Content-Language: en-US
From: Kunwu Chan <chentao@kylinos.cn>
In-Reply-To: <20240130092255.73078-1-chentao@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Thanks for your reply.

As the code say, the name is only for human beings and to identify a 
cache, so it's ok.

"A string which is used in /proc/slabinfo to identify this cache."
-- 
Thanks,
   Kunwu


