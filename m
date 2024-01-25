Return-Path: <linux-kernel+bounces-38823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 88C7783C689
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 16:26:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F196EB2361A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 15:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82BAD73169;
	Thu, 25 Jan 2024 15:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BiskYp0Q"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9FD4F5EC;
	Thu, 25 Jan 2024 15:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706196391; cv=none; b=UYECDZm0KJEG+d/iKittjZGeFkzFldnjna8WvDx4HWn5MBr612lLU9leFzfjmOPkAp1vc5aE4EMhM22NHNnbR7/+2S6eQ5IgZiaMHZ+kcKVKnhucE3+ABxVczUpoxQ3oECJeWRkQltQ8Pkgr9HnBnEivpFfYJ4wBf36DnaD+lGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706196391; c=relaxed/simple;
	bh=kKJHwTZjVPIvLUahnyXdGBA6zUdviPYDck1gqUnhDCk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Wd1UEenaHl5Jdl3YMRrjDG1N4TLUJ3DYIMWLTJRjjhTc2qQcS4JCF+Jg4YpGxdjhyaZx8r94UHOKtdsOdprvUDcDyoMWjTM5ssaC9kFrkUvsV49zsQSgU97L3jBhRlXjuWCBEuM0dSDFETQ/+2kcx/llhuZwfVxBq1e98wag6a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BiskYp0Q; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40PFOlYr007361;
	Thu, 25 Jan 2024 15:26:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=WHSc3yPwnhvCd0JqWDdGNTNdMiGjojp3CArrvdSDsSM=;
 b=BiskYp0Qglr+vooCK0aiSnkfWUmO5LKsc6E9tEiELGPRaXv0BzAjIN7aWm+JSoAj7yQO
 px+mbcak8jLVUGj+1AVc4NYRaiZLLnfSIWF+9Puu6dHuX8TGwX9KcKMZsorTBvSiGueu
 UwrEqglUn4mux307p7NpYyn1/0+Q5a2ViGg3fsY/BZxkF6IXaTNsnnXL7MJoW3UDbNNg
 Z93mZLYs5F+0kaIKhm9imfKYDh4cTsqgG2Ns8fl7p27y4TZ2c5hsn+muISSugAMQmmbV
 jLuIqjxP4v/BjvPi9IPyHzVTv7W8KTtUKYbISCXK4lU7X/atoLMbNLJ29LpNhAzonVD3 kA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vukuujc99-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jan 2024 15:26:27 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40PFQQ2u013544;
	Thu, 25 Jan 2024 15:26:26 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vukuujc8r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jan 2024 15:26:26 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 40PE7NoD028254;
	Thu, 25 Jan 2024 15:26:25 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vru72vng2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jan 2024 15:26:25 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 40PFQNi019530410
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Jan 2024 15:26:23 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DF1002004E;
	Thu, 25 Jan 2024 15:26:22 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9C77720043;
	Thu, 25 Jan 2024 15:26:22 +0000 (GMT)
Received: from [9.152.224.38] (unknown [9.152.224.38])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 25 Jan 2024 15:26:22 +0000 (GMT)
Message-ID: <54f9622f-7e62-4089-91dc-df541f8f37f8@linux.ibm.com>
Date: Thu, 25 Jan 2024 16:26:22 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/smc: fix incorrect SMC-D link group matching
 logic
Content-Language: en-US
To: Wen Gu <guwen@linux.alibaba.com>, mjrosato@linux.ibm.com,
        wenjia@linux.ibm.com, jaka@linux.ibm.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20240125123916.77928-1-guwen@linux.alibaba.com>
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <20240125123916.77928-1-guwen@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: P-NaMQmv7l-_SX-N2BAOssk_iWlxmhBo
X-Proofpoint-GUID: KeDWvOgbQQhBo5Sfj83dArfJiAIclZhO
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
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 impostorscore=0 malwarescore=0 adultscore=0 phishscore=0
 bulkscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401250108



On 25.01.24 13:39, Wen Gu wrote:
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

Thank you Wen Gu

Reviewed-by: Alexandra Winter <wintera@linux.ibm.com>

