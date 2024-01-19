Return-Path: <linux-kernel+bounces-31635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D10A8331AE
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 00:48:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 230361F22CBC
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 23:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B1FE59B61;
	Fri, 19 Jan 2024 23:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="FVdItDo9"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F34551C4B;
	Fri, 19 Jan 2024 23:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705708088; cv=none; b=LBVW/DmE0YQQDRiPmJZlWps41KHz19lfjE4G9jEykTa6ut6X3I14oiNR+s8uzv98waetlaAs2634vcLCM4r3OHVIgd0N4aGEcUFbQ1ux39eTnlniHk8FmKB0OMII+3bZyTuHrn0RBI0S0x577u+eeRWSbiKgaKFPHB8i2cJ1284=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705708088; c=relaxed/simple;
	bh=PmzDnE+QmOepAVj/EtZNKea8NQzM9a3BI1a1+JJjs6w=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Q+MkeLa3X26UJBGQ1F1//6MuzyfcEZ/ixyAwdmm14fL/zS9+GtzTWfSBfgNT/gsJ2SfKPPLSs1XGMfbQkjYGY2u3mAZOJu4TFcj7BKB2ni+qqupf1XKwulwBC8A3uGtIuGmib+Mg2DIhf5OZIGIEzAhmM8QsCzX4cD81nd5Ztq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=FVdItDo9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40JNNKdA010923;
	Fri, 19 Jan 2024 23:47:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=7OdlWbHAsWvuCUbuBHpHnDwMbx/eAJa3USyKbg8pm/Q=; b=FV
	dItDo9EZ0RF5YXn2USHbafvh0oBa15QMHVYRyClmGznf6XKicP/cGvhh9hvcSCWK
	hAv0QB0S//GNSjTpVRoODReehFcpeD7qlqSWT13MQvKAWw9sNqpv+GmmeleAWfc7
	2Y2DtIl16k9nDmcvxGQQlesvqYi4BJGLktTZkDxTlcfYMhABXmFUweXyoo4xBS0m
	K5+qQSrbcTHom24OCUtjBd+fLDG4Shtq4Xz31P5kwXkVaX9p4jZ8qLSivK+X5jWY
	ZoVpABF7cQ2090smRa0ASN3AR7hKj93y2JdAJPPyP9mFic0h7848IZ6aB6rT5Txm
	SeA11dP67rJnt1+y/YMw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vqn89hr21-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jan 2024 23:47:55 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40JNlsRq019760
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jan 2024 23:47:54 GMT
Received: from [10.110.26.199] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 19 Jan
 2024 15:47:53 -0800
Message-ID: <9e1db7f3-fd18-4b3b-a912-3cf6efd96fed@quicinc.com>
Date: Fri, 19 Jan 2024 15:47:53 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless v2] nl80211/cfg80211: add nla_policy for S1G band
Content-Language: en-US
To: Lin Ma <linma@zju.edu.cn>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>,
        <linux-wireless@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kvalo@kernel.org>
References: <20240119151201.8670-1-linma@zju.edu.cn>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240119151201.8670-1-linma@zju.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: sucXXr2AirEFxqH5hm5BGeFfrzOShU7o
X-Proofpoint-ORIG-GUID: sucXXr2AirEFxqH5hm5BGeFfrzOShU7o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-19_12,2024-01-19_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 clxscore=1011
 suspectscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0
 mlxscore=0 malwarescore=0 impostorscore=0 adultscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401190147

On 1/19/2024 7:12 AM, Lin Ma wrote:
> Our detector has identified another case of an incomplete policy.
> Specifically, the commit df78a0c0b67d ("nl80211: S1G band and channel
> definitions") introduced the NL80211_BAND_S1GHZ attribute to
> nl80211_band, but it neglected to update the
> nl80211_match_band_rssi_policy accordingly.
> 
> Similar commits that add new band types, such as the initial
> commit 1e1b11b6a111 ("nl80211/cfg80211: Specify band specific min RSSI
> thresholds with sched scan"), the commit e548a1c36b11 ("cfg80211: add 6GHz
> in code handling array with NUM_NL80211_BANDS entries"), and the
> commit 63fa04266629 ("nl80211: Add LC placeholder band definition to
> nl80211_band"), all require updates to the policy.
> Failure to do so could result in accessing an attribute of unexpected
> length in the function nl80211_parse_sched_scan_per_band_rssi.
> 
> To resolve this issue, this commit adds the policy for the
> NL80211_BAND_S1GHZ attribute.
> 
> Fixes: df78a0c0b67d ("nl80211: S1G band and channel definitions")
> Signed-off-by: Lin Ma <linma@zju.edu.cn>
> ---
> V1 -> V2: change net-next to wireless as suggested
> 
>  net/wireless/nl80211.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
> index 60877b532993..980300621a60 100644
> --- a/net/wireless/nl80211.c
> +++ b/net/wireless/nl80211.c
> @@ -911,6 +911,7 @@ nl80211_match_band_rssi_policy[NUM_NL80211_BANDS] = {
>  	[NL80211_BAND_5GHZ] = { .type = NLA_S32 },
>  	[NL80211_BAND_6GHZ] = { .type = NLA_S32 },
>  	[NL80211_BAND_60GHZ] = { .type = NLA_S32 },
> +	[NL80211_BAND_S1GHZ] = { .type = NLA_S32 },
>  	[NL80211_BAND_LC]    = { .type = NLA_S32 },
>  };
>  
something is really suspicious since the NL80211_BAND_* enums are
*value* enums, not attribute ID enums, and hence they should never be
used in an nla_policy.

what is actually using these as attribute IDs, noting that
NL80211_BAND_2GHZ == 0 and hence cannot be used as an attribute ID

seems the logic that introduced this policy needs to be revisited.


