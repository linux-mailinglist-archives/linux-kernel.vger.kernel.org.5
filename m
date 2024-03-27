Return-Path: <linux-kernel+bounces-121823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0483488EE3D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 19:26:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22DC21C32763
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 18:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85E0914F12A;
	Wed, 27 Mar 2024 18:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="FaoqlCPL"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6B014E2CE;
	Wed, 27 Mar 2024 18:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711563989; cv=none; b=VEan3LwCnLr7CeR29/oh1hFO08bPpH2lPK6QiX7/XNoPptYYDyGrlB5Dt910JfjcWGOHWkYZimzvBkoFY8HKtKTuCZzvVhRrlG8lP9Aw6VFJp071XHHL8lxeJ3Wwwdde1N4Rt+BWEw36/PzWLiJCyGsPWvTx3j2lW5qU2B+mtHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711563989; c=relaxed/simple;
	bh=S5lpD0totsV4KRoZDEAp/wgiazw+vvQTX2MXpvfKUzY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=YUIqGgZNsehN+a8eyWORTeMdTwozMxc4Lpy+ater88OBH3EBKJWnmkLfHYQ9geZ517HBZmVIE88TYDBzUAepJRiDRQvwiGje7ZUfY4bBW62Sg/Y8y36Y5yXD9D7OJ2R0H2lZg1vE6Va0pN3XAdNiCUoa1Q5fHvOgSfr4SZ3n1Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=FaoqlCPL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42RHuK8S028054;
	Wed, 27 Mar 2024 18:26:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:from:subject:to:cc:references
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=deAWrZr3uZsWt7WZFTIo1fovSqSpvhFlpEIjkFW8FnA=; b=Fa
	oqlCPLkTSVDEqOKzcLAGVIE1DoCPDbSrINPg3eY8oLsyUJp9JrF7djJI0LVowEYX
	WJs5kcF6j5HYHfjf1N1Wtg1dz+CP66GCGmT0xS1tIO/BvHAI7XdjicUG0DGYmpun
	kmKPVv8Riep75eYdCnr8EuUONznBnkHjh6oBLIbMZshkeyNV8SIrCy+NadcIcAmS
	a20v1PUAaXhAU84IIOEfjdb67wOn9UoS0jbQsIAckTKHw5BSgmchYX34l0Ovs+YT
	p+XVUREwWNHcQMQ/dVSNICLzgpOF6Dpe8IFigcK6LBksqJ/tifjI59dYUtZtQUh9
	t4QRBONhSMWzmkYP2qOw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x4h001dqc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Mar 2024 18:26:24 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42RIQNIM004200
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Mar 2024 18:26:23 GMT
Received: from [10.110.28.48] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 27 Mar
 2024 11:26:22 -0700
Message-ID: <3f19627e-4472-4ed1-9e2e-b0b427682910@quicinc.com>
Date: Wed, 27 Mar 2024 11:26:22 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Subject: Re: [PATCH v2][next] wifi: wil6210: Annotate a couple of structs with
 __counted_by()
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Kalle Valo
	<kvalo@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-hardening@vger.kernel.org>
References: <ZgRayuCJ0gQinMvr@neat>
Content-Language: en-US
In-Reply-To: <ZgRayuCJ0gQinMvr@neat>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: xSTK4iV_T6ogPey7uYf2986hFYjKNMOg
X-Proofpoint-ORIG-GUID: xSTK4iV_T6ogPey7uYf2986hFYjKNMOg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-27_14,2024-03-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 clxscore=1011 spamscore=0 mlxscore=0
 bulkscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2403270128

On 3/27/2024 10:43 AM, Gustavo A. R. Silva wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
> array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
> Changes in v2:
>  - Annotate one more struct.
>  - Update Subject line.
> 
> v1:
>  - Link: https://lore.kernel.org/linux-hardening/ZgODZOB4fOBvKl7R@neat/
> 
>  drivers/net/wireless/ath/wil6210/wmi.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/wil6210/wmi.h b/drivers/net/wireless/ath/wil6210/wmi.h
> index 71bf2ae27a98..38f64524019e 100644
> --- a/drivers/net/wireless/ath/wil6210/wmi.h
> +++ b/drivers/net/wireless/ath/wil6210/wmi.h
> @@ -474,7 +474,7 @@ struct wmi_start_scan_cmd {
>  	struct {
>  		u8 channel;
>  		u8 reserved;
> -	} channel_list[];
> +	} channel_list[] __counted_by(num_channels);
>  } __packed;

does the compiler handle the actual logic where it is modifying num_channels
concurrently with writing into the array? i.e. this will be writing into
channel_list[0] when num_channels is 0:

		cmd.cmd.channel_list[cmd.cmd.num_channels++].channel = ch - 1;

if that will cause a bounds check failure then suggest you change the logic so
that it updates num_channels before writing into channel_list

>  
>  #define WMI_MAX_PNO_SSID_NUM	(16)
> @@ -3320,7 +3320,7 @@ struct wmi_set_link_monitor_cmd {
>  	u8 rssi_hyst;
>  	u8 reserved[12];
>  	u8 rssi_thresholds_list_size;
> -	s8 rssi_thresholds_list[];
> +	s8 rssi_thresholds_list[] __counted_by(rssi_thresholds_list_size);
>  } __packed;

this looks ok to me, although I think there is another issue associated with
this, namely the way the code populates the rssi_thresholds_list is by
defining a separate anonymous struct:
	struct {
		struct wmi_set_link_monitor_cmd cmd;
		s8 rssi_thold;
	} __packed cmd = {
		.cmd = {
			.rssi_hyst = rssi_hyst,
			.rssi_thresholds_list_size = 1,
		},
		.rssi_thold = rssi_thold,
	};

I would expect gcc and clang to both complain about that s8 rssi_thold comes
after a flexible array (even though its purpose is to be the value of
rssi_thresholds_list[0])

/jeff


>  
>  /* wmi_link_monitor_event_type */


