Return-Path: <linux-kernel+bounces-129959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C440A8972BD
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 16:36:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 138C5B29C1F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 14:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A30243AB4;
	Wed,  3 Apr 2024 14:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="SiG5xiHB"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4F77317F;
	Wed,  3 Apr 2024 14:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712154381; cv=none; b=HJpHn14+8FLDTIPuttj4CQRpGix7G3cgssQHeSMmefGW21bqt9G1QLE0H0j/W9liPLJ9wPYH6u9MKx2hDrBgThGy6LMLD+yKlfvPY0mvxF3adlPmeR8RXmEpqpr/n1y5OfYe7nsgb8wI2Wek/ogUSi0a09w6JwMpRTBb4OyZX14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712154381; c=relaxed/simple;
	bh=fkTHuuIlizFLfJEW/hGdq6DrsghcH2/JNKr3v+ckPxc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ddHXuouoZeWMVeTGnZasYbCGgkvqnMQ6KkDQ5OjZF/dov90KjAfmtZxpGgg6VD6xpUFAZsY0KHLdEnfOS6hmOCIQVGrYl91ZiDvPECzhXaM6OzISV58EagP0X45o8Z8myjTFI8+iU4LQYx1NbH8Qv0ZuQYmiRVSEg97tAQOguYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=SiG5xiHB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4339T68j003830;
	Wed, 3 Apr 2024 14:26:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=dlV/Xaqd+s+Wl3Cs/arDiJ6Ugx4On9Q/h5cNnVIYRng=; b=Si
	G5xiHBmRYpkJwEWAFWV0kc1Aor5KQgtL+Wwx03amkBaXCyfTFJxy9LU0YN/ZJCTK
	QnZu+1KpDpTFbWmFiXHUpYo/RLxaZYgAi3bfinDmEPwU1OBCx3/JIzpAkKDU7Sjg
	YyAuqFOHgygNPFf1IZBBYSIkBhfGJo8TvZ0QVpe0MosleR1Q08PIukjyA8RYoHsZ
	AZudKggWqpm9z4TGWYkxSXI/hhJXxGESDSKP9gVlBIbuAe08k9sU4OdJj3kQCVXK
	MFmyDDEeHOF1Hm4EHDYLazXDUbQqdHum9XnXHGPFZ53wbNz2mQpGsRm8H6/X/sym
	s0H3XIZaC66o8hE7nB1A==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x93n3gwfq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Apr 2024 14:26:12 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 433EQBYu005071
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 3 Apr 2024 14:26:11 GMT
Received: from [10.227.110.203] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 3 Apr 2024
 07:26:11 -0700
Message-ID: <0987ae32-911e-4770-bdd0-ba099fb3bd72@quicinc.com>
Date: Wed, 3 Apr 2024 07:26:10 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 21/34] iwlegacy: don't warn for unused variables with
 DEBUG_FS=n
Content-Language: en-US
To: Arnd Bergmann <arnd@kernel.org>, <linux-kernel@vger.kernel.org>,
        Stanislaw
 Gruszka <stf_xl@wp.pl>, Kalle Valo <kvalo@kernel.org>
CC: Arnd Bergmann <arnd@arndb.de>, <linux-wireless@vger.kernel.org>
References: <20240403080702.3509288-1-arnd@kernel.org>
 <20240403080702.3509288-22-arnd@kernel.org>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240403080702.3509288-22-arnd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: iJsxOlE_fcP_5P3VIbKm5-gy_qpTZfcR
X-Proofpoint-ORIG-GUID: iJsxOlE_fcP_5P3VIbKm5-gy_qpTZfcR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-03_13,2024-04-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 bulkscore=0 lowpriorityscore=0 adultscore=0 spamscore=0 priorityscore=1501
 malwarescore=0 impostorscore=0 mlxlogscore=821 suspectscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2404030098

On 4/3/2024 1:06 AM, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The reference to il_rate_mcs is inside of an #ifdef, causing a W=1 warning:
> 
> drivers/net/wireless/intel/iwlegacy/4965-rs.c:189:38: error: unused variable 'il_rate_mcs' [-Werror,-Wunused-const-variable]
> static const struct il_rate_mcs_info il_rate_mcs[RATE_COUNT] = {
> 
> Replace the #ifdef with a PTR_IF() for better compile time analysis.
> The dead code will still get eliminated, but the warning goes away.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/net/wireless/intel/iwlegacy/4965-rs.c | 15 ++-------------
>  drivers/net/wireless/intel/iwlegacy/common.h  |  2 --
>  2 files changed, 2 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/net/wireless/intel/iwlegacy/4965-rs.c b/drivers/net/wireless/intel/iwlegacy/4965-rs.c
> index 718efb1aa1b0..1aa2cee5d131 100644
> --- a/drivers/net/wireless/intel/iwlegacy/4965-rs.c
> +++ b/drivers/net/wireless/intel/iwlegacy/4965-rs.c
> @@ -132,15 +132,8 @@ static void il4965_rs_fill_link_cmd(struct il_priv *il,
>  static void il4965_rs_stay_in_table(struct il_lq_sta *lq_sta,
>  				    bool force_search);
>  
> -#ifdef CONFIG_MAC80211_DEBUGFS
>  static void il4965_rs_dbgfs_set_mcs(struct il_lq_sta *lq_sta,
>  				    u32 *rate_n_flags, int idx);
> -#else
> -static void
> -il4965_rs_dbgfs_set_mcs(struct il_lq_sta *lq_sta, u32 * rate_n_flags, int idx)
> -{
> -}
> -#endif
>  
>  /*
>   * The following tables contain the expected throughput metrics for all rates
> @@ -2495,8 +2488,6 @@ il4965_rs_free_sta(void *il_r, struct ieee80211_sta *sta, void *il_sta)
>  	D_RATE("leave\n");
>  }
>  
> -#ifdef CONFIG_MAC80211_DEBUGFS
> -

if the const table is only used by this function, why not do the trivial thing
and relocate it to be inside this #ifdef, or even to be within the function
itself?

>  static void
>  il4965_rs_dbgfs_set_mcs(struct il_lq_sta *lq_sta, u32 * rate_n_flags, int idx)
>  {
> @@ -2758,7 +2749,6 @@ il4965_rs_add_debugfs(void *il, void *il_sta, struct dentry *dir)
>  	debugfs_create_u8("tx_agg_tid_enable", 0600, dir,
>  			  &lq_sta->tx_agg_tid_en);
>  }
> -#endif
>  
>  /*
>   * Initialization of rate scaling information is done by driver after
> @@ -2781,9 +2771,8 @@ static const struct rate_control_ops rs_4965_ops = {
>  	.free = il4965_rs_free,
>  	.alloc_sta = il4965_rs_alloc_sta,
>  	.free_sta = il4965_rs_free_sta,
> -#ifdef CONFIG_MAC80211_DEBUGFS
> -	.add_sta_debugfs = il4965_rs_add_debugfs,
> -#endif
> +	.add_sta_debugfs = PTR_IF(IS_ENABLED(CONFIG_DEBUG_FS),

CONFIG_DEBUG_FS != CONFIG_MAC80211_DEBUGFS, is that intentional?

> +				  il4965_rs_add_debugfs),

so using this you don't get a warning about all those static functions and
tables being unused when the feature is disabled? that's pretty cool.
is that because the compiler sees them instead of the preprocessor stripping
them out?

>  };
>  
>  int
> diff --git a/drivers/net/wireless/intel/iwlegacy/common.h b/drivers/net/wireless/intel/iwlegacy/common.h
> index 69687fcf963f..b9f1daf0901b 100644
> --- a/drivers/net/wireless/intel/iwlegacy/common.h
> +++ b/drivers/net/wireless/intel/iwlegacy/common.h
> @@ -2804,9 +2804,7 @@ struct il_lq_sta {
>  	struct il_scale_tbl_info lq_info[LQ_SIZE];	/* "active", "search" */
>  	struct il_traffic_load load[TID_MAX_LOAD_COUNT];
>  	u8 tx_agg_tid_en;
> -#ifdef CONFIG_MAC80211_DEBUGFS
>  	u32 dbg_fixed_rate;
> -#endif

and yes it is trivial, but we now waste this memory when the feature is not
enabled

>  	struct il_priv *drv;
>  
>  	/* used to be in sta_info */


