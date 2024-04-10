Return-Path: <linux-kernel+bounces-138448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B84689F16C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 13:53:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC2E6285A3A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 11:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3429915D5AF;
	Wed, 10 Apr 2024 11:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b="bLGU83b9"
Received: from mx1.t-argos.ru (mx1.t-argos.ru [109.73.34.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323C915B990;
	Wed, 10 Apr 2024 11:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.73.34.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712749800; cv=none; b=aWFZcnQt+/vi2Ze0PLm20sBUNeu477rvdCwU1xABG9c/roH5ozgFDEiPx1meX5jzdQtZXkezejGxlli2E0hyLA1x+vR6Aq3ID2RZgTfJp4I7xg95rOUfp8TqIjL9dJIbOTwf4JklXm33fUavJcSvWMR5aLxh8dKlN3xk9sSBDLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712749800; c=relaxed/simple;
	bh=lzh1zOL2GZaC9KvS1/2NH2b4sklK+RWokY0RHqFrW4M=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=o2vQRlq7T2QEDlNVyhpufVblhu3v8D6MEDl5JR+bFtBfqM7Mbou2dXQ1sor1JOlmqPv1jyutjcKhsrrOwA1FkzqMK+MEfx3CJvN3aPic/aGIXwdaIo5aH/fHxYjUSbcRhXPYIzReNF/yMu8KvdY8flV6NNJcuQNWvJfAijts9xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru; spf=pass smtp.mailfrom=t-argos.ru; dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b=bLGU83b9; arc=none smtp.client-ip=109.73.34.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-argos.ru
Received: from mx1.t-argos.ru (localhost [127.0.0.1])
	by mx1.t-argos.ru (Postfix) with ESMTP id 1A576100002;
	Wed, 10 Apr 2024 14:49:32 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=t-argos.ru; s=mail;
	t=1712749772; bh=orBTxthOmkOLw2GzZM5dy/q8ncQT8wiwTCAtBDly8Wc=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	b=bLGU83b9vUGLxKi2GmvKDE6DRQDyOKuTFPnxvRnvhwInt8CuRWsslY10v4N2Z40k7
	 Yg9CWMFWZN8IiXf+VteYUYx9kVh4dCfPHTY6A7ofG9rxYMH21WQUshbiB+pvM1RTj8
	 wmEUX+CZti1oggowfyE8QNJIYevf0Z61p51qgAygq5eGKoI/o+lBEM1iOrOdKGThgl
	 p3FrTWg9K/wj5xUHEI93Hj131J9hnbz7VYuDCekvkeXT5RokY8mwqJTwr3TM1+D5YE
	 11QJqWblkPW9OTBXXeaVs/H8b2SyMciyGZSnDnQYw+XZkrCnq9S1WqswSz+INpcUUu
	 rfgNcC555wGdw==
Received: from mx1.t-argos.ru.ru (mail.t-argos.ru [172.17.13.212])
	by mx1.t-argos.ru (Postfix) with ESMTP;
	Wed, 10 Apr 2024 14:48:10 +0300 (MSK)
Received: from [172.17.214.6] (172.17.214.6) by ta-mail-02 (172.17.13.212)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 10 Apr
 2024 14:47:50 +0300
Message-ID: <6151dd67-702b-41e7-8e54-43d4d1178442@t-argos.ru>
Date: Wed, 10 Apr 2024 14:45:13 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/msm/dpu: Add callback function pointer check before
 its call
Content-Language: ru
To: Abhinav Kumar <quic_abhinavk@quicinc.com>, Dmitry Baryshkov
	<dmitry.baryshkov@linaro.org>
CC: Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, Marijn
 Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>, Neil Armstrong <neil.armstrong@linaro.org>,
	Stephen Boyd <swboyd@chromium.org>, <linux-arm-msm@vger.kernel.org>,
	<dri-devel@lists.freedesktop.org>, <freedreno@lists.freedesktop.org>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>
References: <20240408085523.12231-1-amishin@t-argos.ru>
 <c2c3b573-0e62-4452-e657-fbef9abb9430@quicinc.com>
From: Aleksandr Mishin <amishin@t-argos.ru>
In-Reply-To: <c2c3b573-0e62-4452-e657-fbef9abb9430@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ta-mail-02.ta.t-argos.ru (172.17.13.212) To ta-mail-02
 (172.17.13.212)
X-KSMG-Rule-ID: 1
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 184651 [Apr 10 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: amishin@t-argos.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 16 0.3.16 6e64c33514fcbd07e515710c86ba61de7f56194e, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, t-argos.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;git.kernel.org:7.1.1;127.0.0.199:7.1.2;mx1.t-argos.ru.ru:7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/04/10 07:25:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2024/04/10 08:25:00 #24735279
X-KSMG-AntiVirus-Status: Clean, skipped



On 08.04.2024 19:51, Abhinav Kumar wrote:
> 
> 
> On 4/8/2024 1:55 AM, Aleksandr Mishin wrote:
>> In dpu_core_irq_callback_handler() callback function pointer is 
>> compared to NULL,
>> but then callback function is unconditionally called by this pointer.
>> Fix this bug by adding conditional return.
>>
>> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>>
> 
> Yes , as dmitry wrote, this should be Reported-by.
> 

It is an established practice for our project, you can find 700+ applied
patches with similar line:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/log/?qt=grep&q=linuxtesting.org

> But rest LGTM.
> 
>> Fixes: c929ac60b3ed ("drm/msm/dpu: allow just single IRQ callback")
>> Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
>> ---
>>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c 
>> b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c
>> index 946dd0135dff..03a16fbd4c99 100644
>> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c
>> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c
>> @@ -223,9 +223,11 @@ static void dpu_core_irq_callback_handler(struct 
>> dpu_kms *dpu_kms, unsigned int
>>       VERB("IRQ=[%d, %d]\n", DPU_IRQ_REG(irq_idx), DPU_IRQ_BIT(irq_idx));
>> -    if (!irq_entry->cb)
>> +    if (!irq_entry->cb) {
>>           DRM_ERROR("no registered cb, IRQ=[%d, %d]\n",
>>                 DPU_IRQ_REG(irq_idx), DPU_IRQ_BIT(irq_idx));
>> +        return;
>> +    }
>>       atomic_inc(&irq_entry->count);

-- 
Kind regards
Aleksandr

