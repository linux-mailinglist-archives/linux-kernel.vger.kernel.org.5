Return-Path: <linux-kernel+bounces-37960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1270783B8D6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 06:00:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92B4A287C94
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 05:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EFB78493;
	Thu, 25 Jan 2024 04:59:56 +0000 (UTC)
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC6D10A01;
	Thu, 25 Jan 2024 04:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706158795; cv=none; b=TiK32AVS+HttDfHrxby7qlESrzxSdGMQYhopGuCnYdvLcveTeYagTXLXdnCtF9/1E/fWvg3ftnfkhnwrFhQpUFdHhOQhAW4dUdQvEnX5i/MgsfwkT7qOq9/+u3hk9PSiCKsS56/tTSlRuahZrTroMrMsZflUDDRz52eVxABciuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706158795; c=relaxed/simple;
	bh=MW15k4O5v9QsoPaQ81Bq5JTbJg1u8U4lt6OlGTG94sc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cXVhfV+1lRIngR1OrGpHwEPuipoD20eXl+kebxoOBzqCZul0WzbrVBRVl4vm0+puHOOILqCyn41S8P3eWJwRAV9vpcz6CXW/pYhddSvJ8QD+8qT418fQWr2e71RXkRYGGl8HN0GU9SolFbJ87vPsEf/jD1fttt/oYEU8K92EXv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R611e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=23;SR=0;TI=SMTPD_---0W.J8HiD_1706158781;
Received: from 30.221.129.223(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0W.J8HiD_1706158781)
          by smtp.aliyun-inc.com;
          Thu, 25 Jan 2024 12:59:43 +0800
Message-ID: <530afe45-ba6b-4970-a71c-1f1255f5fca9@linux.alibaba.com>
Date: Thu, 25 Jan 2024 12:59:41 +0800
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
From: Wen Gu <guwen@linux.alibaba.com>
In-Reply-To: <13579588-eb9d-4626-a063-c0b77ed80f11@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/1/24 22:29, Alexandra Winter wrote:
> Hello Wen Gu,
> 
> our colleague Matthew reported that SMC-D is failing in certain scenarios on
> kernel v6.8 (thx Matt!). He bisected it to
> b40584d ("net/smc: compatible with 128-bits extended GID of virtual ISM device")
> I think the root cause could also be somewhere else in the SMC-Dv2.1 patchset.
> 
> I was able to reproduce the issue on a 6.8.0-rc1 kernel.
> I tested iperf over smc-d with:
> smc_run iperf3 -s
> smc_run iperf3 -c <IP@>
> 
> 1) Doing an iperf in a single system using 127.0.0.1 as IP@
> (System A=iperf client=iperf server)
> 2) Doing iperf to a remote system (System A=client; System B=iperf server)
> 
> The second iperf fails with an error message like:
> "iperf3: error - unable to receive cookie at server: Bad file descriptor" on the server"
> 
> If I do first 2) (iperf to remote) and then 1) (iperf to local), then the
> iperf to local fails.
> 
> I can do multiple iperf to the first server without problems.
> 
> I ran it on a debug server with KASAN, but got no reports in the Logfile.
> 
> I will try to debug further, but wanted to let you all know.
> 
> Kind regards
> Alexandra
> 
> Reported-by: Matthew Rosato <mjrosato@linux.ibm.com>
> 

Hi Alexandra and Matthew,

Thank you very much for detailed description.

I tried to reproduce this with loopback-ism, cut some checks so that the remote-system
handshake can be done. After a while debug I found an elementary mistake of mine in
b40584d ("net/smc: compatible with 128-bits extended GID of virtual ISM device")..

The operator order in smcd_lgr_match() is not as expected. It will always return
'true' in remote-system case.

  static bool smcd_lgr_match(struct smc_link_group *lgr,
-                          struct smcd_dev *smcismdev, u64 peer_gid)
+                          struct smcd_dev *smcismdev,
+                          struct smcd_gid *peer_gid)
  {
-       return lgr->peer_gid == peer_gid && lgr->smcd == smcismdev;
+       return lgr->peer_gid.gid == peer_gid->gid && lgr->smcd == smcismdev &&
+               smc_ism_is_virtual(smcismdev) ?
+               (lgr->peer_gid.gid_ext == peer_gid->gid_ext) : 1;
  }

Could you please try again with this patch? to see if this is the root cause.
Really sorry for the inconvenience.

diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index da6a8d9c81ea..c6a6ba56c9e3 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -1896,8 +1896,8 @@ static bool smcd_lgr_match(struct smc_link_group *lgr,
                            struct smcd_gid *peer_gid)
  {
         return lgr->peer_gid.gid == peer_gid->gid && lgr->smcd == smcismdev &&
-               smc_ism_is_virtual(smcismdev) ?
-               (lgr->peer_gid.gid_ext == peer_gid->gid_ext) : 1;
+               (smc_ism_is_virtual(smcismdev) ?
+                (lgr->peer_gid.gid_ext == peer_gid->gid_ext) : 1);
  }


Thanks,
Wen Gu

