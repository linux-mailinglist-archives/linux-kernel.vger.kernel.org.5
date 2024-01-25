Return-Path: <linux-kernel+bounces-38825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1701783C690
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 16:29:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4EE428D5E1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 15:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDCB273165;
	Thu, 25 Jan 2024 15:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gpKLwjDk"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91FDC4F5EC;
	Thu, 25 Jan 2024 15:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706196551; cv=none; b=BoaVRCMxdE7DtvGKzsZZ1wy7Ef9U7wWcXQsbfMpUs80Ykw56IHChy3rtrTFLgDBBKedgB/P1fbwEnCb1FpH+sGTE/RiO4r/Q+JG8NL4yZO58aTslBvGG8rhl357cY04kta3kUdTuOnnQ4wxU4MlZjt/9+PDYqYk1fHLNuhCdTgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706196551; c=relaxed/simple;
	bh=CbLQHdj21PM2VFD6yau7Lr9GMfCs+oNfwxMJn4g2Nh4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cVjWKocCLHiRb1kOx0eWz8kgpoQ0O4PnVtWeHOGF/fBQ4L71j9PH07Bi8RHxWEzU8ptGTBq7jfj/BcdRyW89E28fZcJMIPQUGTncwadFS9NZy9iyZsfp7YGNSZsI/rOcBlCx3GrKjpX31rwirx291Tqsjd9ur19Qi3m2SKiah8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gpKLwjDk; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40PF2F15027454;
	Thu, 25 Jan 2024 15:29:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=ODcscHlU88qXSsIkGxqnDgOeC6AODRwonK04jiN1EFA=;
 b=gpKLwjDkQAi4GfA7XMFPFT5e+9g34nrppOU2x0ESFN6S0Jd2xskcFYhpyiSg9ZnCwqnG
 kj+zaF7ER+DsCEcbcmqh3MQr2PW+6OpnGwGuLN8ZihEYD9kUh0m68ej8SvlHFWadNR7E
 sbgcLE94tYx1e1gv6VAKKU5Zxwr6Y2FJw4e3rsoddoJFpWybLxJbkOXJReC2S9jjFuU+
 uNgxkMHJ3qu7qM47Y1Q/4rxblMU5TDFn1RwFS6Wq+Jy/EACm3HiwZxE30loteGoVt9lx
 /Q/Mg9P9twMWP3r/LHKluLcnpox4pBIfqFCiPl5af6GBIuSgaw1QMQJs137QPB553Ugn wA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vusxb8xg0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jan 2024 15:29:06 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40PF2UVm029097;
	Thu, 25 Jan 2024 15:29:06 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vusxb8xfa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jan 2024 15:29:06 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 40PFG5qs025892;
	Thu, 25 Jan 2024 15:29:04 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vrsgpd4ap-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jan 2024 15:29:04 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 40PFT3Q922610392
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Jan 2024 15:29:04 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DF5FA58056;
	Thu, 25 Jan 2024 15:29:03 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EBEFF58060;
	Thu, 25 Jan 2024 15:29:02 +0000 (GMT)
Received: from [9.61.119.211] (unknown [9.61.119.211])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 25 Jan 2024 15:29:02 +0000 (GMT)
Message-ID: <05f26b9a-9fbb-40ed-8a8a-3cb3549b1097@linux.ibm.com>
Date: Thu, 25 Jan 2024 10:29:02 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/smc: fix incorrect SMC-D link group matching
 logic
Content-Language: en-US
To: Wen Gu <guwen@linux.alibaba.com>, wintera@linux.ibm.com,
        wenjia@linux.ibm.com, jaka@linux.ibm.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20240125123916.77928-1-guwen@linux.alibaba.com>
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20240125123916.77928-1-guwen@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 32LXY7_zfF_ZZ4M5yrNUAKcefZO73nsM
X-Proofpoint-GUID: 6mzWfiKtdkmXFyAPbPs7U7Hc_H34YLju
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_09,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 clxscore=1011
 phishscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0 mlxscore=0
 spamscore=0 bulkscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401250108

On 1/25/24 7:39 AM, Wen Gu wrote:
> The logic to determine if SMC-D link group matches is incorrect. The
> correct logic should be that it only returns true when the GID is the
> same, and the SMC-D device is the same and the extended GID is the same
> (in the case of virtual ISM).
> 
> It can be fixed by adding brackets around the conditional (or ternary)
> operator expression. But for better readability and maintainability, it
> has been changed to an if-else statement.
> 
> Reported-by: Matthew Rosato <mjrosato@linux.ibm.com>
> Closes: https://lore.kernel.org/r/13579588-eb9d-4626-a063-c0b77ed80f11@linux.ibm.com
> Fixes: b40584d14570 ("net/smc: compatible with 128-bits extended GID of virtual ISM device")
> Link: https://lore.kernel.org/r/13579588-eb9d-4626-a063-c0b77ed80f11@linux.ibm.com
> Signed-off-by: Wen Gu <guwen@linux.alibaba.com>

Hi Wen Gu,

I just ran the same series of tests with this patch applied and it resolves the issue for me.  Thanks for the quick fix!

Thanks,
Matt


> ---
>  net/smc/smc_core.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
> index 95cc95458e2d..e4c858411207 100644
> --- a/net/smc/smc_core.c
> +++ b/net/smc/smc_core.c
> @@ -1877,9 +1877,15 @@ static bool smcd_lgr_match(struct smc_link_group *lgr,
>  			   struct smcd_dev *smcismdev,
>  			   struct smcd_gid *peer_gid)
>  {
> -	return lgr->peer_gid.gid == peer_gid->gid && lgr->smcd == smcismdev &&
> -		smc_ism_is_virtual(smcismdev) ?
> -		(lgr->peer_gid.gid_ext == peer_gid->gid_ext) : 1;
> +	if (lgr->peer_gid.gid != peer_gid->gid ||
> +	    lgr->smcd != smcismdev)
> +		return false;
> +
> +	if (smc_ism_is_virtual(smcismdev) &&
> +	    lgr->peer_gid.gid_ext != peer_gid->gid_ext)
> +		return false;
> +
> +	return true;
>  }
>  
>  /* create a new SMC connection (and a new link group if necessary) */


