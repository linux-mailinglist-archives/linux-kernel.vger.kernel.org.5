Return-Path: <linux-kernel+bounces-138452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A6E5289F179
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 13:54:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6AD9B24B74
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 11:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CE5415ADBF;
	Wed, 10 Apr 2024 11:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b="RQliOMsu"
Received: from mx1.t-argos.ru (mx1.t-argos.ru [109.73.34.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8790C159909;
	Wed, 10 Apr 2024 11:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.73.34.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712749989; cv=none; b=tMxe1UZtoRCPsvm8lJX8aO/E7IGBxOOa0LVeWHQtUlRrkhJvNk8PcS/6GrGFITaNRcwZTwMCSbH1/nUEVNotxExYDsqVOZbmmNoI+5EI+IF+wWhmbndderTmnj4V1x8qMqnSb7c3udeKUUWA4IjwZNKAEsPLaRz85cwDbFwSN8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712749989; c=relaxed/simple;
	bh=N84XgSg1KHPNSkXpmcgoVPYP9AWL9ZJCU/gwTzWn3Bo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=lOB6iQQdicq6FnHF8kRyH4tVrIp/aUpV7VJoXc3hlFHBEzZDBj5XvEtq3XSbVxgc1NnJGwzXpOHz7gktqYMJnvimkt3oghoudJXE84U+dvsA4QO2klH1x0AxIQ/wvb9ggRj4i0F7qpelBWAFYiginfxEuf9m8vYCxciHWxUTjYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru; spf=pass smtp.mailfrom=t-argos.ru; dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b=RQliOMsu; arc=none smtp.client-ip=109.73.34.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-argos.ru
Received: from mx1.t-argos.ru (localhost [127.0.0.1])
	by mx1.t-argos.ru (Postfix) with ESMTP id EE41D100002;
	Wed, 10 Apr 2024 14:52:47 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=t-argos.ru; s=mail;
	t=1712749968; bh=WJUH5RzBi6ThGn7KLoC7JkfiYKeYqyZ7xZhKdtRWAfI=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	b=RQliOMsu1CsL31rk+zQjPobaWvn+7OwssPGXLDAJ+1nrXH73GfJMiDa40pyBFnRgX
	 VxOKnIToEshOUVnEKsNPRAp0Mn3NshZS8btJeySsDzHwq/aB/9qbr7GnBmnxg0BE8x
	 kFiKKS5PAoSbjPpqGWmO0wU1NPII/F6aIJK1glUeZXWXb/9OeBjYjD8RgcjUlk5bJA
	 poHWEuPxI90WUuhK1z7Sk987Qw5HhcY84iVNmX1gpBQimVp6jV+OUlAB34cQ8mNCyV
	 1KFcLby75BVoh6OUZQjHDgTMwrkLcMW+xdSf3dOTjKLpuaX5tw3C9VCtZVRUixszSN
	 yjJxeVhcGyngQ==
Received: from mx1.t-argos.ru.ru (mail.t-argos.ru [172.17.13.212])
	by mx1.t-argos.ru (Postfix) with ESMTP;
	Wed, 10 Apr 2024 14:51:29 +0300 (MSK)
Received: from [172.17.214.6] (172.17.214.6) by ta-mail-02 (172.17.13.212)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 10 Apr
 2024 14:51:09 +0300
Message-ID: <2b06e6b2-6fa0-48fa-800b-7aad6735daa6@t-argos.ru>
Date: Wed, 10 Apr 2024 14:48:41 +0300
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
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: Rob Clark <robdclark@gmail.com>, Abhinav Kumar
	<quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, Marijn Suijten
	<marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, Daniel
 Vetter <daniel@ffwll.ch>, Neil Armstrong <neil.armstrong@linaro.org>, Stephen
 Boyd <swboyd@chromium.org>, <linux-arm-msm@vger.kernel.org>,
	<dri-devel@lists.freedesktop.org>, <freedreno@lists.freedesktop.org>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>
References: <20240408085523.12231-1-amishin@t-argos.ru>
 <CAA8EJppTM4tpsFaZKupPe=0Oc9qDp7dBqHyHGP4E5bTHKT=hSw@mail.gmail.com>
From: Aleksandr Mishin <amishin@t-argos.ru>
In-Reply-To: <CAA8EJppTM4tpsFaZKupPe=0Oc9qDp7dBqHyHGP4E5bTHKT=hSw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
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
X-KSMG-AntiSpam-Info: LuaCore: 16 0.3.16 6e64c33514fcbd07e515710c86ba61de7f56194e, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, t-argos.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;mx1.t-argos.ru.ru:7.1.1;git.kernel.org:7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/04/10 07:25:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2024/04/10 08:25:00 #24735279
X-KSMG-AntiVirus-Status: Clean, skipped



On 08.04.2024 12:03, Dmitry Baryshkov wrote:
> On Mon, 8 Apr 2024 at 11:57, Aleksandr Mishin <amishin@t-argos.ru> wrote:
>>
>> In dpu_core_irq_callback_handler() callback function pointer is compared to NULL,
>> but then callback function is unconditionally called by this pointer.
>> Fix this bug by adding conditional return.
>>
>> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> This should be converted to a proper Reported-by: trailer.
> 

It is an established practice for our project, you can find 700+ applied
patches with similar line:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/log/?qt=grep&q=linuxtesting.org

>>
>> Fixes: c929ac60b3ed ("drm/msm/dpu: allow just single IRQ callback")
>> Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
>> ---
>>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c
>> index 946dd0135dff..03a16fbd4c99 100644
>> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c
>> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c
>> @@ -223,9 +223,11 @@ static void dpu_core_irq_callback_handler(struct dpu_kms *dpu_kms, unsigned int
>>
>>          VERB("IRQ=[%d, %d]\n", DPU_IRQ_REG(irq_idx), DPU_IRQ_BIT(irq_idx));
>>
>> -       if (!irq_entry->cb)
>> +       if (!irq_entry->cb) {
>>                  DRM_ERROR("no registered cb, IRQ=[%d, %d]\n",
>>                            DPU_IRQ_REG(irq_idx), DPU_IRQ_BIT(irq_idx));
>> +               return;
>> +       }
>>
>>          atomic_inc(&irq_entry->count);
>>
>> --
>> 2.30.2
>>
>>
> 
> 

-- 
Kind regards
Aleksandr

