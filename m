Return-Path: <linux-kernel+bounces-38177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9AE083BC07
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 09:30:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8384B281987
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 08:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 242D2179BE;
	Thu, 25 Jan 2024 08:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dSXT5p3h"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A051717753;
	Thu, 25 Jan 2024 08:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706171415; cv=none; b=eVCZlTVO3cGg4hxpktIdrGqygsw8xQLj9zWCB8dRkmBMc2FMyCWdAPesS8ZZ78fmrc/V2MEA2aGwNOdo3J7xXv7yOcsulCa2eYoh78tz3uT3aO0B7gJztzEQz6ju38BcllYQGvWxZ62xoa0/YbVutiZaHBbGj9FjwLQIt3nEqNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706171415; c=relaxed/simple;
	bh=3XBWo2N7vPeYYFH5hJHHJ4R4cDBYgvyARsugBQmHXL4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ak7Ag7TCsVNgioU/Q7C3smx3VIn3Ab3rOgE2k+CzFchRHuMohEmf6fhv3jw4LyBaIzToK8rTETZGLGbl+wEVwVLOzVGN/lPBnJZ5JWF3ZLADWoP5A+tCsAs4yfBNuLalIrs1ltsNExnR8AtqlXjEK7qR8LWf4LZLxG1oJKkKtKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dSXT5p3h; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40P7Ws7f020363;
	Thu, 25 Jan 2024 08:30:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=jSTDG7pZUdM5R9gkBMPp9G3Ps4anJqutG/WR/2lOnuY=;
 b=dSXT5p3hpWogxlGVlcqhXejmTsB0A8TpuQr7Sc3QwCyPtqesJcJJe9ssK0KkYR1JwyA2
 l4MqVV9WxUYB/Lc0Yu6NU/njqocM9+XwRWg7kkrHl9IZ5MpaV4Uh/YAN6XM+5csSfKUz
 vnf3jJUEkoTBPAxHyEfPugyuAWYy8GHnpSYLqiF3uugJoZoQU/YqUVNKRmmYTESQXnuU
 85LZnHcPtes4vCicYTM/EXRLMFOkuNik/AUPqGR9xzAXnfg4bBbi6cIMl4LXof+i0FA3
 DBsm0UPnU2c5Xja7UCIy0L1YHkTr5p4wPzDvo22HDuD1fNBqj63/boaFSZgRCl3Dh4Im DA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vukbj18ef-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jan 2024 08:30:07 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40P85cuv022522;
	Thu, 25 Jan 2024 08:30:06 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vukbj183q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jan 2024 08:30:06 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 40P527pn010854;
	Thu, 25 Jan 2024 08:27:03 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vrrw03c88-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jan 2024 08:27:03 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 40P8R0G556754506
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Jan 2024 08:27:00 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8897220043;
	Thu, 25 Jan 2024 08:27:00 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0F95F20040;
	Thu, 25 Jan 2024 08:27:00 +0000 (GMT)
Received: from [9.152.224.38] (unknown [9.152.224.38])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 25 Jan 2024 08:27:00 +0000 (GMT)
Message-ID: <8090bb34-1b70-43ea-ae13-df5d9a5eb761@linux.ibm.com>
Date: Thu, 25 Jan 2024 09:26:59 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] v6.8 SMC-D issues
To: Wen Gu <guwen@linux.alibaba.com>, wenjia@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        jaka@linux.ibm.com, Matthew Rosato <mjrosato@linux.ibm.com>
Cc: Linux regressions mailing list <regressions@lists.linux.dev>,
        borntraeger@linux.ibm.com, svens@linux.ibm.com,
        alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
        raspl@linux.ibm.com, schnelle@linux.ibm.com,
        guangguan.wang@linux.alibaba.com, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Halil Pasic <pasic@linux.ibm.com>
References: <20231219142616.80697-1-guwen@linux.alibaba.com>
 <20231219142616.80697-8-guwen@linux.alibaba.com>
 <13579588-eb9d-4626-a063-c0b77ed80f11@linux.ibm.com>
 <530afe45-ba6b-4970-a71c-1f1255f5fca9@linux.alibaba.com>
Content-Language: en-US
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <530afe45-ba6b-4970-a71c-1f1255f5fca9@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: hL-eyvXh5IfeJnQxS3WvRFG4GCoUuQvl
X-Proofpoint-GUID: d9-pXlaTopAnnCB5pTPeUJJRJKxMjHfa
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_04,2024-01-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 spamscore=0 lowpriorityscore=0 mlxscore=0 malwarescore=0 phishscore=0
 impostorscore=0 clxscore=1015 priorityscore=1501 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401250057



On 25.01.24 05:59, Wen Gu wrote:
> After a while debug I found an elementary mistake of mine in
> b40584d ("net/smc: compatible with 128-bits extended GID of virtual ISM device")..
> 
> The operator order in smcd_lgr_match() is not as expected. It will always return
> 'true' in remote-system case.
> 
>  static bool smcd_lgr_match(struct smc_link_group *lgr,
> -                          struct smcd_dev *smcismdev, u64 peer_gid)
> +                          struct smcd_dev *smcismdev,
> +                          struct smcd_gid *peer_gid)
>  {
> -       return lgr->peer_gid == peer_gid && lgr->smcd == smcismdev;
> +       return lgr->peer_gid.gid == peer_gid->gid && lgr->smcd == smcismdev &&
> +               smc_ism_is_virtual(smcismdev) ?
> +               (lgr->peer_gid.gid_ext == peer_gid->gid_ext) : 1;
>  }
> 
> Could you please try again with this patch? to see if this is the root cause.
> Really sorry for the inconvenience.
> 
> diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
> index da6a8d9c81ea..c6a6ba56c9e3 100644
> --- a/net/smc/smc_core.c
> +++ b/net/smc/smc_core.c
> @@ -1896,8 +1896,8 @@ static bool smcd_lgr_match(struct smc_link_group *lgr,
>                            struct smcd_gid *peer_gid)
>  {
>         return lgr->peer_gid.gid == peer_gid->gid && lgr->smcd == smcismdev &&
> -               smc_ism_is_virtual(smcismdev) ?
> -               (lgr->peer_gid.gid_ext == peer_gid->gid_ext) : 1;
> +               (smc_ism_is_virtual(smcismdev) ?
> +                (lgr->peer_gid.gid_ext == peer_gid->gid_ext) : 1);
>  }
> 
> 
> Thanks,
> Wen Gu

Hello Wen Gu,

thank you for the quick resposne and for finding this nasty bug.
I can confirm that with your patch I do not see the issue anymore.
Please send a fix to the mailing lists. See
https://docs.kernel.org/process/handling-regressions.html
for some tips.

May I propose that instead of adding the brackets, you change this function 
to an if-then-else sequence for readability and maintainability?
I would still mention the missing brackets in the commit message, so
readers can quickly understand the issue.

Thanks again for the quick response.
Sandy


