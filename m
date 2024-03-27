Return-Path: <linux-kernel+bounces-122014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 162A188F0BF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 22:18:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F37E1C2C8E0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 21:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAC62153566;
	Wed, 27 Mar 2024 21:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="JFTmVSZP"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40AB04CB38;
	Wed, 27 Mar 2024 21:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711574306; cv=none; b=hnlS8KXiEYSA3R9GNg0U+IMcDtmyhK4rPkH3+kVqZINhOTkIeSHsPGf0V7TEy1QsabhAXWxZinCA2EzWLrh7bB/TZmmA8ySQyVRR9MFczaVW5nx6mHT0KLMoXlJe58flxIsFk3E1Tfz3vcbNLiuJF2MeVSwn/fpUgjCdEpcjd4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711574306; c=relaxed/simple;
	bh=ipR9hzWi9zOw+0dtltYaJnP36cAh8+wgGS76t0QXEmo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=MOTQANzB/PTpLicc6yDwkqxIzFZ4kLvzaCXxrQMubZAI5Pp3oHltb0x4DTSBaaXx8/EjVRt8t1bnLyX5ebev31QpEs+QwKZAtbxsfj1Mf3S7vr78aDRT807cB+Lk9CC4eu9FGmp5EDhAHgd8pvEKPQCAc9czBl1M1KhRbPMRZ/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=JFTmVSZP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42RLEeJT013323;
	Wed, 27 Mar 2024 21:18:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=5odMItVmcOfOMhCJL0bB7D3uH/Ex4aUfIXFkrQuBSoI=; b=JF
	TmVSZPz493vFHJYMBdxskWf8HTu0AE5M/KHCEFtBaQ4bMEtGTl3aR/qzmREsZ6pm
	SSJi4o5kpyrDR97J+rKavntKImyb7AWN+f95C92bQ+I1bI02GAf3cUaLq4jMkvBy
	CKwQ/8jUZlnY+S16hGnKUD6w0RpkBXWr2XXbR67W79+6/Bn6BLgGVCz7jjdzwIFQ
	1lNN1IRFV6vbSTABSXG9Ocmn2sbNdKOQbRmO8/SUaQYatvOo6ood+JE0s+kk1OZz
	TVmQEiEQL+jp0mt1P/EIXYV/2tVmn8tgvqw3+gRNalo0B3q2E+tGHVcLGJMumw9D
	vAMSa/EHia/Q3od4AKGA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x4u1yr0wx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Mar 2024 21:18:21 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42RLIKYc024990
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Mar 2024 21:18:20 GMT
Received: from [10.227.110.203] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 27 Mar
 2024 14:18:20 -0700
Message-ID: <3670c9af-3266-4b9b-928e-e91a68db7123@quicinc.com>
Date: Wed, 27 Mar 2024 14:18:19 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] wifi: cfg80211: Use __counted_by() in struct
 wmi_start_scan_cmd and avoid -Wfamnae warning
Content-Language: en-US
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Kalle Valo
	<kvalo@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-hardening@vger.kernel.org>
References: <ZgRqjGShTl3y5FFB@neat>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <ZgRqjGShTl3y5FFB@neat>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: avsc72lS1iUa_AjePAihMSqXGNNMmh_8
X-Proofpoint-GUID: avsc72lS1iUa_AjePAihMSqXGNNMmh_8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-27_18,2024-03-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 mlxscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 mlxlogscore=999 spamscore=0 adultscore=0 malwarescore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2403270151

On 3/27/2024 11:50 AM, Gustavo A. R. Silva wrote:
> Prepare for the coming implementation by GCC and Clang of the
> __counted_by attribute. Flexible array members annotated with
> __counted_by can have their accesses bounds-checked at run-time
> via CONFIG_UBSAN_BOUNDS (for array indexing) and CONFIG_FORTIFY_SOURCE
> (for strcpy/memcpy-family functions).
> 
> Also, -Wflex-array-member-not-at-end is coming in GCC-14, and we are
> getting ready to enable it globally.
> 
> So, use the `DEFINE_FLEX()` helper for an on-stack definition of
> a flexible structure where the size of the flexible-array member
> is known at compile-time, and refactor the rest of the code,
> accordingly.
> 
> So, with these changes, fix the following warning:
> drivers/net/wireless/ath/wil6210/cfg80211.c:896:43: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 
> Link: https://github.com/KSPP/linux/issues/202
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  drivers/net/wireless/ath/wil6210/cfg80211.c | 22 ++++++++++-----------
>  drivers/net/wireless/ath/wil6210/wmi.h      |  2 +-
>  2 files changed, 11 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/wil6210/cfg80211.c b/drivers/net/wireless/ath/wil6210/cfg80211.c
> index dbe4b3478f03..836b49954171 100644
> --- a/drivers/net/wireless/ath/wil6210/cfg80211.c
> +++ b/drivers/net/wireless/ath/wil6210/cfg80211.c
> @@ -892,10 +892,8 @@ static int wil_cfg80211_scan(struct wiphy *wiphy,
>  	struct wil6210_priv *wil = wiphy_to_wil(wiphy);
>  	struct wireless_dev *wdev = request->wdev;
>  	struct wil6210_vif *vif = wdev_to_vif(wil, wdev);
> -	struct {
> -		struct wmi_start_scan_cmd cmd;
> -		u16 chnl[4];
> -	} __packed cmd;
> +	DEFINE_FLEX(struct wmi_start_scan_cmd, cmd,
> +		    channel_list, num_channels, 4);
>  	uint i, n;
>  	int rc;
>  
> @@ -977,9 +975,9 @@ static int wil_cfg80211_scan(struct wiphy *wiphy,
>  	vif->scan_request = request;
>  	mod_timer(&vif->scan_timer, jiffies + WIL6210_SCAN_TO);
>  
> -	memset(&cmd, 0, sizeof(cmd));
> -	cmd.cmd.scan_type = WMI_ACTIVE_SCAN;
> -	cmd.cmd.num_channels = 0;
> +	memset(cmd, 0, sizeof(*cmd));

Isn't this unnecessary since DEFINE_FLEX() logic "{ .obj.COUNTER = COUNT, }"
should result in everything else being zeroed?

And if that isn't sufficient, DEFINE_FLEX() itself says we should "Use
__struct_size(@NAME) to get compile-time size of it afterwards"

Note the current memset won't zero the flex array and hence if the actual
number of channels is less than 4 then kernel stack contents could be exposed
to firmware.

> +	cmd->scan_type = WMI_ACTIVE_SCAN;
> +	cmd->num_channels = 0;
>  	n = min(request->n_channels, 4U);
>  	for (i = 0; i < n; i++) {
>  		int ch = request->channels[i]->hw_value;
> @@ -991,7 +989,8 @@ static int wil_cfg80211_scan(struct wiphy *wiphy,
>  			continue;
>  		}
>  		/* 0-based channel indexes */
> -		cmd.cmd.channel_list[cmd.cmd.num_channels++].channel = ch - 1;
> +		cmd->num_channels++;
> +		cmd->channel_list[cmd->num_channels - 1].channel = ch - 1;
>  		wil_dbg_misc(wil, "Scan for ch %d  : %d MHz\n", ch,
>  			     request->channels[i]->center_freq);
>  	}
> @@ -1007,16 +1006,15 @@ static int wil_cfg80211_scan(struct wiphy *wiphy,
>  	if (rc)
>  		goto out_restore;
>  
> -	if (wil->discovery_mode && cmd.cmd.scan_type == WMI_ACTIVE_SCAN) {
> -		cmd.cmd.discovery_mode = 1;
> +	if (wil->discovery_mode && cmd->scan_type == WMI_ACTIVE_SCAN) {
> +		cmd->discovery_mode = 1;
>  		wil_dbg_misc(wil, "active scan with discovery_mode=1\n");
>  	}
>  
>  	if (vif->mid == 0)
>  		wil->radio_wdev = wdev;
>  	rc = wmi_send(wil, WMI_START_SCAN_CMDID, vif->mid,
> -		      &cmd, sizeof(cmd.cmd) +
> -		      cmd.cmd.num_channels * sizeof(cmd.cmd.channel_list[0]));
> +		      cmd, struct_size(cmd, channel_list, cmd->num_channels));
>  
>  out_restore:
>  	if (rc) {
> diff --git a/drivers/net/wireless/ath/wil6210/wmi.h b/drivers/net/wireless/ath/wil6210/wmi.h
> index 71bf2ae27a98..b47606d9068c 100644
> --- a/drivers/net/wireless/ath/wil6210/wmi.h
> +++ b/drivers/net/wireless/ath/wil6210/wmi.h
> @@ -474,7 +474,7 @@ struct wmi_start_scan_cmd {
>  	struct {
>  		u8 channel;
>  		u8 reserved;
> -	} channel_list[];
> +	} channel_list[] __counted_by(num_channels);
>  } __packed;
>  
>  #define WMI_MAX_PNO_SSID_NUM	(16)


