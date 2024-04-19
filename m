Return-Path: <linux-kernel+bounces-151631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48FE28AB15C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 17:09:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 072AD283394
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 15:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B6D912FB1B;
	Fri, 19 Apr 2024 15:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="GwY54oRW"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F7E12D76E;
	Fri, 19 Apr 2024 15:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713539380; cv=none; b=lHH5KIamlGoxx60R4NH4fCkATCdo3p1LBu55AM3FjUzDeFf2eT077BSUaI6eYA5rF0KAU/+7gsKF0MTrFn/qNBwIsKnKCkn5eC7+2tk2sOVNSuKu95fpZkOSRm/dP6axb7Np7oa/X+QR5EIr4wYsB96gvh+2Ye7OKjW4xohJWCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713539380; c=relaxed/simple;
	bh=Ai9vvd25xbI32P9Xuhu2sj+HcwENCVnunu370YRHYH8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=XQcK65er94Bb2GOLmUo1am4mlHnb5uQn5JJH6GkfYxELcIbIv++jRmlkebYr1Mam5k7WP42qNuUOFEPHpEn9he+jGUpR1o/RoKCvfkG3C6FhdxhUZpF7Pt3faK/tlhLqdLJG80woEiYqg/Hbb86VQ8w1H63RfucmlLYjPAZYUrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=GwY54oRW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43JDggXX025508;
	Fri, 19 Apr 2024 15:09:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=9Wo8SmDNArByT9MfsI6PAGKm5TIESVSuSSafxP6REhs=; b=Gw
	Y54oRWvDGd22r7sN4dDr70BSS6ZuTzpeHt8tZSLRSyvB0AqgvKpVP7UWQS2RKnh6
	zMOA8nzYNulnCtu+m1Gj/Qw3zGnUNemcUDqtZdnBsyW+cuI9nUuFH8JCvzjgC1XT
	uJNJt3bJONyZKzkOV5V2pM5vQjgWWTRn9iR+7tLJvfxUHXRqQb1kythLwUFAZ5c9
	b9oOVF1/6B76zSAwScJ84088I6LdIula+tngT0aGUb+WoIaNJ7XdxJXVy06MpFj7
	Em0Y0t2yD76wlwgpvN6kCz3dtCmUu2TqZ3uwHae8uxk3tUyUeKtU0whc0UUJrwj3
	aQL28/Ip7Onba68fL6rg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xk9s7a51f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Apr 2024 15:09:27 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43JF9QpM020996
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Apr 2024 15:09:26 GMT
Received: from [10.110.56.161] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 19 Apr
 2024 08:09:25 -0700
Message-ID: <a4c2cb8c-dd80-457f-82b5-2eb58a9b55b5@quicinc.com>
Date: Fri, 19 Apr 2024 08:09:24 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless] wifi: ath10k: Fix an error code problem in
 ath10k_dbg_sta_write_peer_debug_trigger()
Content-Language: en-US
To: Su Hui <suhui@nfschina.com>, <kvalo@kernel.org>, <jjohnson@kernel.org>,
        <nathan@kernel.org>, <ndesaulniers@google.com>, <morbo@google.com>,
        <justinstitt@google.com>
CC: <c_mkenna@qti.qualcomm.com>, <linux-wireless@vger.kernel.org>,
        <ath10k@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <llvm@lists.linux.dev>, <kernel-janitors@vger.kernel.org>
References: <20240417081736.2226586-1-suhui@nfschina.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240417081736.2226586-1-suhui@nfschina.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: rJl189pniCvvvdIHyH8iJmr6ShUY7FCy
X-Proofpoint-ORIG-GUID: rJl189pniCvvvdIHyH8iJmr6ShUY7FCy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-19_10,2024-04-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 spamscore=0
 phishscore=0 mlxlogscore=999 priorityscore=1501 adultscore=0
 impostorscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 bulkscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404190114

On 4/17/2024 1:17 AM, Su Hui wrote:
> Clang Static Checker (scan-build) Warning:
> drivers/net/wireless/ath/ath10k/debugfs_sta.c:line 429, column 3
> Value stored to 'ret' is never read.
> 
> Return 'ret' rather than 'count' when 'ret' stores an error code.
> By the way, remove some useless code.
> 
> Fixes: ee8b08a1be82 ("ath10k: add debugfs support to get per peer tids log via tracing")
> Signed-off-by: Su Hui <suhui@nfschina.com>
> ---
>  drivers/net/wireless/ath/ath10k/debugfs_sta.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath10k/debugfs_sta.c b/drivers/net/wireless/ath/ath10k/debugfs_sta.c
> index 394bf3c32abf..5525dabe390a 100644
> --- a/drivers/net/wireless/ath/ath10k/debugfs_sta.c
> +++ b/drivers/net/wireless/ath/ath10k/debugfs_sta.c
> @@ -415,7 +415,7 @@ ath10k_dbg_sta_write_peer_debug_trigger(struct file *file,
>  	struct ath10k_sta *arsta = (struct ath10k_sta *)sta->drv_priv;
>  	struct ath10k *ar = arsta->arvif->ar;
>  	u8 peer_debug_trigger;
> -	int ret;
> +	int ret = 0;

this is unnecessary since this will be written in all paths that lead to the
return that reads it

>  
>  	if (kstrtou8_from_user(user_buf, count, 0, &peer_debug_trigger))
>  		return -EINVAL;
> @@ -432,14 +432,12 @@ ath10k_dbg_sta_write_peer_debug_trigger(struct file *file,
>  
>  	ret = ath10k_wmi_peer_set_param(ar, arsta->arvif->vdev_id, sta->addr,
>  					ar->wmi.peer_param->debug, peer_debug_trigger);
> -	if (ret) {
> +	if (ret)
>  		ath10k_warn(ar, "failed to set param to trigger peer tid logs for station ret: %d\n",
>  			    ret);
> -		goto out;
> -	}
>  out:
>  	mutex_unlock(&ar->conf_mutex);
> -	return count;
> +	return ret ?: count;
>  }
>  
>  static const struct file_operations fops_peer_debug_trigger = {

I'd suggest as an alternate solution that this function is a good candidate
for the the cleanup.h functionality. By scoping the mutex_lock() you can
simply return at each error location, and remove the explicit mutex_unlock().

But I'd accept this with the initializer change removed as well since I don't
think ath10k has any cleanup.h usages yet.

/jeff

