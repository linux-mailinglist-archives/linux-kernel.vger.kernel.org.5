Return-Path: <linux-kernel+bounces-38263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C709983BD54
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 10:30:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74C59291DA4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 09:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55B9E1C2A3;
	Thu, 25 Jan 2024 09:28:57 +0000 (UTC)
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262B31BF27;
	Thu, 25 Jan 2024 09:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706174936; cv=none; b=Zf1Akv7mbTTGODF5U1IdeCRtP0qqVDWoVWvnRTJBI4EuI/I2rcuIjiERYfQqq6f70JOh6LRuFIBg0pASGeMfuJE3kNDpuCaFLXdmGo4w0A0HX/VROcGoUkRVc/iuZwmxJftYgIEFr6vaUVJ7edn3kkx7wqftjZ6uDqtO9tSmYqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706174936; c=relaxed/simple;
	bh=4oi/mDvJ66W3EHJcJkd6l/BObOrE9wC8bVqVRycPZXw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vd0aQ9L3dDL95q88bABdBJfvQp6407F3UedP2glwDYuwTQkYPG51WOmkMI+2pQOp6a9ulvOHB6IsTY7okbeaHUuiCpC8NuPI5wGfDFpcqZ2AP9FHWcc+w/LHqwzqCe21RFnalBDzLp+55HwEZdZ/lgg+Rg5HXSWd28p2ZnXx7AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=23;SR=0;TI=SMTPD_---0W.JurKr_1706174923;
Received: from 30.221.129.223(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0W.JurKr_1706174923)
          by smtp.aliyun-inc.com;
          Thu, 25 Jan 2024 17:28:44 +0800
Message-ID: <d93bdf89-d724-4f2a-a3fc-f3a46e54202c@linux.alibaba.com>
Date: Thu, 25 Jan 2024 17:28:43 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] v6.8 SMC-D issues
To: Alexandra Winter <wintera@linux.ibm.com>, wenjia@linux.ibm.com,
 hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, jaka@linux.ibm.com,
 Matthew Rosato <mjrosato@linux.ibm.com>
Cc: Linux regressions mailing list <regressions@lists.linux.dev>,
 borntraeger@linux.ibm.com, svens@linux.ibm.com, alibuda@linux.alibaba.com,
 tonylu@linux.alibaba.com, raspl@linux.ibm.com, schnelle@linux.ibm.com,
 guangguan.wang@linux.alibaba.com, linux-s390@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Halil Pasic <pasic@linux.ibm.com>
References: <20231219142616.80697-1-guwen@linux.alibaba.com>
 <20231219142616.80697-8-guwen@linux.alibaba.com>
 <13579588-eb9d-4626-a063-c0b77ed80f11@linux.ibm.com>
 <530afe45-ba6b-4970-a71c-1f1255f5fca9@linux.alibaba.com>
 <8090bb34-1b70-43ea-ae13-df5d9a5eb761@linux.ibm.com>
From: Wen Gu <guwen@linux.alibaba.com>
In-Reply-To: <8090bb34-1b70-43ea-ae13-df5d9a5eb761@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/1/25 16:26, Alexandra Winter wrote:
> 
> 
> On 25.01.24 05:59, Wen Gu wrote:
>> After a while debug I found an elementary mistake of mine in
>> b40584d ("net/smc: compatible with 128-bits extended GID of virtual ISM device")..
>>
>> The operator order in smcd_lgr_match() is not as expected. It will always return
>> 'true' in remote-system case.
>>
>>   static bool smcd_lgr_match(struct smc_link_group *lgr,
>> -                          struct smcd_dev *smcismdev, u64 peer_gid)
>> +                          struct smcd_dev *smcismdev,
>> +                          struct smcd_gid *peer_gid)
>>   {
>> -       return lgr->peer_gid == peer_gid && lgr->smcd == smcismdev;
>> +       return lgr->peer_gid.gid == peer_gid->gid && lgr->smcd == smcismdev &&
>> +               smc_ism_is_virtual(smcismdev) ?
>> +               (lgr->peer_gid.gid_ext == peer_gid->gid_ext) : 1;
>>   }
>>
>> Could you please try again with this patch? to see if this is the root cause.
>> Really sorry for the inconvenience.
>>
>> diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
>> index da6a8d9c81ea..c6a6ba56c9e3 100644
>> --- a/net/smc/smc_core.c
>> +++ b/net/smc/smc_core.c
>> @@ -1896,8 +1896,8 @@ static bool smcd_lgr_match(struct smc_link_group *lgr,
>>                             struct smcd_gid *peer_gid)
>>   {
>>          return lgr->peer_gid.gid == peer_gid->gid && lgr->smcd == smcismdev &&
>> -               smc_ism_is_virtual(smcismdev) ?
>> -               (lgr->peer_gid.gid_ext == peer_gid->gid_ext) : 1;
>> +               (smc_ism_is_virtual(smcismdev) ?
>> +                (lgr->peer_gid.gid_ext == peer_gid->gid_ext) : 1);
>>   }
>>
>>
>> Thanks,
>> Wen Gu
> 
> Hello Wen Gu,
> 
> thank you for the quick resposne and for finding this nasty bug.
> I can confirm that with your patch I do not see the issue anymore.

Thank you very much for your confirmation, Alexandra.

> Please send a fix to the mailing lists. See
> https://docs.kernel.org/process/handling-regressions.html
> for some tips.
> 

Thank you. Will do.

> May I propose that instead of adding the brackets, you change this function
> to an if-then-else sequence for readability and maintainability?
> I would still mention the missing brackets in the commit message, so
> readers can quickly understand the issue.

I agree. if-then-else will make it clearer. I will fix it like this:

diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index da6a8d9c81ea..1d5bce82d4d8 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -1895,9 +1895,15 @@ static bool smcd_lgr_match(struct smc_link_group *lgr,
                            struct smcd_dev *smcismdev,
                            struct smcd_gid *peer_gid)
  {
-       return lgr->peer_gid.gid == peer_gid->gid && lgr->smcd == smcismdev &&
-               smc_ism_is_virtual(smcismdev) ?
-               (lgr->peer_gid.gid_ext == peer_gid->gid_ext) : 1;
+       if (lgr->peer_gid.gid != peer_gid->gid ||
+           lgr->smcd != smcismdev)
+               return false;
+
+       if (smc_ism_is_virtual(smcismdev) &&
+           lgr->peer_gid.gid_ext != peer_gid->gid_ext)
+               return false;
+
+       return true;
  }

Thanks again,
Wen Gu

> 
> Thanks again for the quick response.
> Sandy

