Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85E747FA905
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 19:38:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232509AbjK0Sij (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 13:38:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjK0Sih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 13:38:37 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77E83A1;
        Mon, 27 Nov 2023 10:38:44 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ARIPxdY011556;
        Mon, 27 Nov 2023 18:38:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=rYybWgokpVv90qBdPZiA3EOFqVOw/Kv9mBFSMTnnoE0=;
 b=JJLNC+ISB0x0FWeA4eViD10ZH3IkY/3cPuB/fhMFCbFS0o2RJX04zlpd6N3k833qZFc0
 rbIjTtFm054fXB+yC7V0Jkg5wdr1Lbub2D28xp3fLZ5mlNDO/F750LF91q88lehf9bDr
 SNi8RE9xf9Ljo89J585s9+H8Nr9u7TgB8+U5yjTPXI4lO6Iv8GdvbCrDB2eOTYXwXc2j
 NuGdaWOsN0eokPcbqMdusZhh7iJQHIduW59Ox5afA2kI7SXlDvs3RByI80yPIi8P5d5H
 8txNRPfIUUnDIwfRi5ukvtUfND5ulPL2iCz3bLX4Lh0EN21BEvsQJO8wFynAgxNShk29 Jg== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3umwn5rkxk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Nov 2023 18:38:25 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3ARIcPlG005701
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Nov 2023 18:38:25 GMT
Received: from [10.110.63.243] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 27 Nov
 2023 10:38:24 -0800
Message-ID: <bdcdbd06-e9bd-4a92-b27b-d94b2d8fb52d@quicinc.com>
Date:   Mon, 27 Nov 2023 10:38:24 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath11k: fix layout of scan_flags in struct
 scan_req_params
Content-Language: en-US
To:     Nicolas Escande <nico.escande@gmail.com>,
        Kalle Valo <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <ath11k@lists.infradead.org>
References: <20231127180559.1696041-1-nico.escande@gmail.com>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20231127180559.1696041-1-nico.escande@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: RXxqDYP-mVAtsxhbjw4eJ6K8kykjEYWV
X-Proofpoint-GUID: RXxqDYP-mVAtsxhbjw4eJ6K8kykjEYWV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-27_16,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=892 adultscore=0
 spamscore=0 mlxscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311060000 definitions=main-2311270129
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/27/2023 10:05 AM, Nicolas Escande wrote:
> The is a layout mismatch between the bitfield representing scan_flags in
> struct scan_req_params & the bits as defined in the WMI_SCAN_XXX macros.
> Lets fix it by making the struct match the #defines.
> 
> I tried to correct it by making the struct match the #define and it 
> worked for WMI_SCAN_FLAG_FORCE_ACTIVE_ON_DFS / scan_f_force_active_dfs_chn
> so I'm assuming this is the right thing to do.
> 
> Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Nicolas Escande <nico.escande@gmail.com>
> ---
>  drivers/net/wireless/ath/ath11k/wmi.h | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath11k/wmi.h b/drivers/net/wireless/ath/ath11k/wmi.h
> index 100bb816b592..0b4e6c2f7860 100644
> --- a/drivers/net/wireless/ath/ath11k/wmi.h
> +++ b/drivers/net/wireless/ath/ath11k/wmi.h
> @@ -3348,17 +3348,17 @@ struct scan_req_params {
>  			    scan_f_filter_prb_req:1,
>  			    scan_f_bypass_dfs_chn:1,
>  			    scan_f_continue_on_err:1,
> +			    scan_f_promisc_mode:1,
> +			    scan_f_force_active_dfs_chn:1,
> +			    scan_f_add_tpc_ie_in_probe:1,
> +			    scan_f_add_ds_ie_in_probe:1,
> +			    scan_f_add_spoofed_mac_in_probe:1,
>  			    scan_f_offchan_mgmt_tx:1,
>  			    scan_f_offchan_data_tx:1,
> -			    scan_f_promisc_mode:1,
>  			    scan_f_capture_phy_err:1,
>  			    scan_f_strict_passive_pch:1,
>  			    scan_f_half_rate:1,
>  			    scan_f_quarter_rate:1,
> -			    scan_f_force_active_dfs_chn:1,
> -			    scan_f_add_tpc_ie_in_probe:1,
> -			    scan_f_add_ds_ie_in_probe:1,
> -			    scan_f_add_spoofed_mac_in_probe:1,
>  			    scan_f_add_rand_seq_in_probe:1,
>  			    scan_f_en_ie_whitelist_in_probe:1,
>  			    scan_f_forced:1,

You are convoluting two different data structures.

struct scan_req_params is used to represent a scan request within the
host driver. This does not use the WMI_SCAN_XXX macros.

struct wmi_start_scan_cmd is used to represent the scan request command
sent to firmware. This struct uses the WMI_SCAN_XXX macros to fill some
members of this struct in ath11k_wmi_copy_scan_event_cntrl_flags().

So your change has no effect on the driver operation and incorrectly
tries to foist the firmware definition upon the host internal
representation.

So NAK to this patch.

/jeff
