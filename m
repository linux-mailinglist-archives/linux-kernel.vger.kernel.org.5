Return-Path: <linux-kernel+bounces-96069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13C828756BD
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 20:10:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C33CC282F61
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 19:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B07B813699A;
	Thu,  7 Mar 2024 19:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b="qWS5xXLl"
Received: from mx1.t-argos.ru (mx1.t-argos.ru [109.73.34.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4BC136675;
	Thu,  7 Mar 2024 19:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.73.34.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709838399; cv=none; b=AOpnAFdKt6oO5xyWnXXulCflS/m67RApz0Xq/XXzPaVDRu4M1MCcMH0FVyt50/HqMvYv4jHgNxqy8On+SzZWFvtBVtphLxecB9XzOyRYp5Qi5wFV5bOL1ZascmQKLSrwrscmsrx9YvjSCC/sQM2g0aWQEjqgbUya4dRqpwFFUcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709838399; c=relaxed/simple;
	bh=jF6iduJGIE+O3Bkq9YrSC7eRZxghqOnr34T4ybioEe4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=m7zxx9YX6JagZPfZ12XHdp4sXt82iFQ0vpRKNwgtm0NJaj7NFZnrGJN13f4kOR4RNFrAOVsBczZ7Jun/VzD49Pc2yVdb/+hNGFcteb6Ia0DRs3qrR2raJORJ99ywi8fXSGYJG4cFkKC/HgdKTbONeIFfqrtCLl9Jq4svxRA5H3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru; spf=pass smtp.mailfrom=t-argos.ru; dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b=qWS5xXLl; arc=none smtp.client-ip=109.73.34.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-argos.ru
Received: from mx1.t-argos.ru (localhost [127.0.0.1])
	by mx1.t-argos.ru (Postfix) with ESMTP id 31C0E100003;
	Thu,  7 Mar 2024 22:06:15 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=t-argos.ru; s=mail;
	t=1709838375; bh=CAvOEPtPFq6+eIgzAFJWMtkJyr4bIU2xSPDi8uBAnuY=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	b=qWS5xXLl/V8vg8BJGHCJyaCIZChoxxuFF7FxrzEvzeFH7qBluOf1TpBh2p61QagHe
	 QFgXChfsedVWvDwmgLQh5zYwXjbeaQ09meG5lx0yPk/8DYTdMtk1U2hQ+4Oclpcux7
	 vxf8Grtn+KaP5xBq2DQiTw9txrm1YZrrKGYZr63Vay/oaSvok+yMN4e1w9qkCqbzRe
	 we4SS4Yu2ZmKCb1uEOndz5xevCCdxCMdemI4O/1qlE21Nxe+5CAP1pcB1+G+zAnLgX
	 JeVf411fPOff5qZVTzQq+DT/95W4N2qV0GSIU8kAPYDTH/g1Y/p5WjAso/yitCXX5k
	 lFlLRjjnHU0iQ==
Received: from mx1.t-argos.ru.ru (mail.t-argos.ru [172.17.13.212])
	by mx1.t-argos.ru (Postfix) with ESMTP;
	Thu,  7 Mar 2024 22:05:33 +0300 (MSK)
Received: from [172.17.214.6] (172.17.214.6) by ta-mail-02 (172.17.13.212)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 7 Mar 2024
 22:05:13 +0300
Message-ID: <98dea36b-41dc-4d2e-aec6-56c849e1d58b@t-argos.ru>
Date: Thu, 7 Mar 2024 22:02:56 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: dw_mmc: Fix potential null pointer risk
To: Ulf Hansson <ulf.hansson@linaro.org>
CC: Jaehoon Chung <jh80.chung@samsung.com>, Wen Zhiwei <wenzhiwei@kylinos.cn>,
	<linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<lvc-project@linuxtesting.org>
References: <20240307085135.16245-1-amishin@t-argos.ru>
 <CAPDyKFoYRT=P+4L+5ciNPxEHcS7hoXPef__NQoodxkSy=39Teg@mail.gmail.com>
Content-Language: ru
From: Aleksandr Mishin <amishin@t-argos.ru>
In-Reply-To: <CAPDyKFoYRT=P+4L+5ciNPxEHcS7hoXPef__NQoodxkSy=39Teg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ta-mail-02.ta.t-argos.ru (172.17.13.212) To ta-mail-02
 (172.17.13.212)
X-KSMG-Rule-ID: 1
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 184049 [Mar 07 2024]
X-KSMG-AntiSpam-Version: 6.1.0.3
X-KSMG-AntiSpam-Envelope-From: amishin@t-argos.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 9 0.3.9 e923e63e431b6489f12901471775b2d1b59df0ba, {Tracking_from_domain_doesnt_match_to}, mx1.t-argos.ru.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;t-argos.ru:7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/03/07 17:51:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2024/03/07 17:21:00 #24036814
X-KSMG-AntiVirus-Status: Clean, skipped



07.03.2024 13:57, Ulf Hansson wrote:
> On Thu, 7 Mar 2024 at 09:53, Aleksandr Mishin <amishin@t-argos.ru> wrote:
>>
>> In dw_mci_runtime_resume() 'host->slot' could be null, but check is not cover all corresponding code.
>> Fix this bug by changing check place.
> 
> In fact host->slot can never be NULL in dw_mci_runtime_resume() or in
> dw_mci_runtime_suspend().
> 
> A better fix would thus be to remove the redundant checks.
> 
> Kind regards
> Uffe
> 
>>
>> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>>
>> Fixes: 4a835afd808a (mmc: dw_mmc: Fix potential null pointer risk)
>> Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
>> ---
>>   drivers/mmc/host/dw_mmc.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
>> index 829af2c98a44..a4f124452abc 100644
>> --- a/drivers/mmc/host/dw_mmc.c
>> +++ b/drivers/mmc/host/dw_mmc.c
>> @@ -3570,8 +3570,10 @@ int dw_mci_runtime_resume(struct device *dev)
>>                     DW_MCI_ERROR_FLAGS);
>>          mci_writel(host, CTRL, SDMMC_CTRL_INT_ENABLE);
>>
>> +       if (!host->slot)
>> +               goto err;
>>
>> -       if (host->slot && host->slot->mmc->pm_flags & MMC_PM_KEEP_POWER)
>> +       if (host->slot->mmc->pm_flags & MMC_PM_KEEP_POWER)
>>                  dw_mci_set_ios(host->slot->mmc, &host->slot->mmc->ios);
>>
>>          /* Force setup bus to guarantee available clock output */
>> --
>> 2.30.2
>>
>>
> 

At the same time there are few checks such as "if (host->slot)" in 
dw_mci_runtime_resume() and commit 
4a835afd808a3dbbac44bb399a902b822dc7445c message contains: "we 
previously assumed 'host->slot' could be null, null pointer judgment 
should be added" and replaces "if (host->slot->mmc->pm_flags & 
MMC_PM_KEEP_POWER)" with "if (host->slot && host->slot->mmc->pm_flags & 
MMC_PM_KEEP_POWER)"
So where is the truth?

-- 
Kind regadrds
Aleksandr

