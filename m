Return-Path: <linux-kernel+bounces-45971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 708C9843884
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 09:08:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA833B25C5C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 08:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C476B57339;
	Wed, 31 Jan 2024 08:08:36 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24DE056764;
	Wed, 31 Jan 2024 08:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706688516; cv=none; b=uBoNBk4SUQoWm9ZTPmBTGx+svELnujWYV8klkxgJebVlPLHXxncak/yhxvMhHY8B+of8QiVddJVAKLrlICCOCww6bzXI9Qu5xjEde4I0w+FLyl3ZqOV7O2quDNmRRr73G/d2WA4kRFxrPZeN9k1HUeVtojIaX49qiwB6wx8tsVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706688516; c=relaxed/simple;
	bh=G4dAeJ5kCvQzeN0A5w86Z0GzB46gXNMSBgm2ul8jzYU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ADiU0CUwxqRxFpV4+c38Z/9ZZEnhIXLUpc16HbNOSennGOSLi8vXV7pcCg9Bfzf1EUXoNL1kCz8q5b1kjKhYV18xvsl5RyjlgdOSepuNH2jiBw7GtWjLX/R7T6Z4fro7LpNEqW/gs9hmpuy56/+sXN0DUipb1owFNz6J85yCvEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: ed0d14b154d54eb1ae0b785bda2e0da9-20240131
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:377727a2-5796-43f2-8290-e051e0669773,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-5
X-CID-INFO: VERSION:1.1.35,REQID:377727a2-5796-43f2-8290-e051e0669773,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:5d391d7,CLOUDID:d485f47f-4f93-4875-95e7-8c66ea833d57,B
	ulkID:2401301729259Y99PEWY,BulkQuantity:12,Recheck:0,SF:66|24|17|19|44|102
	,TC:nil,Content:0,EDM:-3,IP:-2,URL:1,File:nil,Bulk:40,QS:nil,BEC:nil,COL:0
	,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,
	TF_CID_SPAM_OBB,TF_CID_SPAM_ULS
X-UUID: ed0d14b154d54eb1ae0b785bda2e0da9-20240131
Received: from mail.kylinos.cn [(39.156.73.10)] by mailgw
	(envelope-from <chentao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1820458699; Wed, 31 Jan 2024 16:08:26 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 1C737E000EB9;
	Wed, 31 Jan 2024 16:08:26 +0800 (CST)
X-ns-mid: postfix-65B9FFFA-36836629
Received: from [172.20.15.254] (unknown [172.20.15.254])
	by mail.kylinos.cn (NSMail) with ESMTPA id AF57DE000EB9;
	Wed, 31 Jan 2024 16:08:24 +0800 (CST)
Message-ID: <42df0817-9d45-4bda-b5ec-51482df8d2be@kylinos.cn>
Date: Wed, 31 Jan 2024 16:08:23 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: bridge: Use KMEM_CACHE instead of
 kmem_cache_create
Content-Language: en-US
To: jiri@resnulli.us
Cc: bridge@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, roopa@nvidia.com, razor@blackwall.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
References: <20240130092536.73623-1-chentao@kylinos.cn>
From: Kunwu Chan <chentao@kylinos.cn>
In-Reply-To: <20240130092536.73623-1-chentao@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Thanks again for your atttention.

The same reason as 
https://lore.kernel.org/all/202e349f-a45a-46cb-ab8e-ff44c12b3628@kylinos.cn/

-- 
Thanks,
   Kunwu


