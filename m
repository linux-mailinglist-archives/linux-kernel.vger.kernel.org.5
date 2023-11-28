Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16C767FAF4E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 01:57:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbjK1A5f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 19:57:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjK1A5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 19:57:33 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 038CC1B1;
        Mon, 27 Nov 2023 16:57:39 -0800 (PST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AS0UNxL028151;
        Tue, 28 Nov 2023 00:57:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=wDphcBCzkGlF57moRbnrj+ShE9HczKhtiqeO3S+415o=;
 b=NHgRoC45vbXbNv/nGHBbGzA69e30/jNmntmv2ABhWRDNGs7QhUcdGx3wfCdleEr33Pp+
 PjYZKKe9CuHclKz/3TsPY4qxSRrN/QSEzqneh65hj72rSHnvlawPaEtqibDevaLY7Z49
 A56eaL5wX6kqy8O0qYlCun4TRnIWuLGQx5X9hTZ8/F5/JV6sFbs7BTK27dKWAmH+OdQX
 WrH+N216g/HmEcPBSc1V/HUsfvZtm9g8BkEeyvBRL+gC81kcymkr6SY9d5zJLXLnBhn0
 S3x6xKWGT2ZwR/O/AkNXVBPsNgW7Iysi40mc1pHCdk2UtK0GZyd05hupl1vX4GmJivEM UQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3un1atgj15-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Nov 2023 00:57:31 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AS0vUo6031191
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Nov 2023 00:57:30 GMT
Received: from [10.110.63.243] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 27 Nov
 2023 16:57:30 -0800
Message-ID: <20c7a367-2243-4e13-b023-9999dc6c6790@quicinc.com>
Date:   Mon, 27 Nov 2023 16:57:29 -0800
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
 <bdcdbd06-e9bd-4a92-b27b-d94b2d8fb52d@quicinc.com>
 <CX9YPUDTAT1N.23DMRB5O9FEAO@gmail.com>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <CX9YPUDTAT1N.23DMRB5O9FEAO@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: q2Tl_hyKAZNVKSOEYmpK3lQ2VEQi3-9f
X-Proofpoint-ORIG-GUID: q2Tl_hyKAZNVKSOEYmpK3lQ2VEQi3-9f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-27_20,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311280005
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/27/2023 2:54 PM, Nicolas Escande wrote:
> On Mon Nov 27, 2023 at 7:38 PM CET, Jeff Johnson wrote:
>> On 11/27/2023 10:05 AM, Nicolas Escande wrote:
>>> The is a layout mismatch between the bitfield representing scan_flags in
>>> struct scan_req_params & the bits as defined in the WMI_SCAN_XXX macros.
>>> Lets fix it by making the struct match the #defines.
>>>
>>> I tried to correct it by making the struct match the #define and it 
>>> worked for WMI_SCAN_FLAG_FORCE_ACTIVE_ON_DFS / scan_f_force_active_dfs_chn
>>> so I'm assuming this is the right thing to do.
>>>
>>> Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1
>>>
>>> Signed-off-by: Nicolas Escande <nico.escande@gmail.com>
>>> ---
>>>  drivers/net/wireless/ath/ath11k/wmi.h | 10 +++++-----
>>>  1 file changed, 5 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/net/wireless/ath/ath11k/wmi.h b/drivers/net/wireless/ath/ath11k/wmi.h
>>> index 100bb816b592..0b4e6c2f7860 100644
>>> --- a/drivers/net/wireless/ath/ath11k/wmi.h
>>> +++ b/drivers/net/wireless/ath/ath11k/wmi.h
>>> @@ -3348,17 +3348,17 @@ struct scan_req_params {
>>>  			    scan_f_filter_prb_req:1,
>>>  			    scan_f_bypass_dfs_chn:1,
>>>  			    scan_f_continue_on_err:1,
>>> +			    scan_f_promisc_mode:1,
>>> +			    scan_f_force_active_dfs_chn:1,
>>> +			    scan_f_add_tpc_ie_in_probe:1,
>>> +			    scan_f_add_ds_ie_in_probe:1,
>>> +			    scan_f_add_spoofed_mac_in_probe:1,
>>>  			    scan_f_offchan_mgmt_tx:1,
>>>  			    scan_f_offchan_data_tx:1,
>>> -			    scan_f_promisc_mode:1,
>>>  			    scan_f_capture_phy_err:1,
>>>  			    scan_f_strict_passive_pch:1,
>>>  			    scan_f_half_rate:1,
>>>  			    scan_f_quarter_rate:1,
>>> -			    scan_f_force_active_dfs_chn:1,
>>> -			    scan_f_add_tpc_ie_in_probe:1,
>>> -			    scan_f_add_ds_ie_in_probe:1,
>>> -			    scan_f_add_spoofed_mac_in_probe:1,
>>>  			    scan_f_add_rand_seq_in_probe:1,
>>>  			    scan_f_en_ie_whitelist_in_probe:1,
>>>  			    scan_f_forced:1,
>>
>> You are convoluting two different data structures.
> 
> So maybe I'm missing something and please correct me where I'm wrong.
> 
>> struct scan_req_params is used to represent a scan request within the
>> host driver. This does not use the WMI_SCAN_XXX macros.
>>
> 
> In mac.c when we start a scan with ath11k_mac_op_hw_scan() for example we first
> initialize a struct scan_req_params with ath11k_wmi_start_scan_init().
> ath11k_wmi_start_scan_init() by itself does use the WMI_SCAN_XXX macros
> 
> 	arg->scan_flags |= WMI_SCAN_CHAN_STAT_EVENT;
> 
> Then later on in ath11k_mac_op_hw_scan() we either use the bitfield like with
> 
> 	arg->scan_f_add_spoofed_mac_in_probe = 1;
> 
> or we directly modify scan_flags like with
> 
> 	arg->scan_flags |= WMI_SCAN_FLAG_PASSIVE;
> 
> So is it not expected to use those flags there ?

IMO it is unexpected to use those flag there.
And I'm actually surprised we have the union there.

> 
>> struct wmi_start_scan_cmd is used to represent the scan request command
>> sent to firmware. This struct uses the WMI_SCAN_XXX macros to fill some
>> members of this struct in ath11k_wmi_copy_scan_event_cntrl_flags().

And IMO that is broken. We should only be using the bitfields.

> 
> Indeed ath11k_wmi_copy_scan_event_cntrl_flags() copies from struct
> scan_req_params to struct wmi_start_scan_cmd but this time we do not use 
> scan_flags directly, only ever use the bitfield that is in the same union
> as scan_flags
> 
> So having the bitfield out of sync does cause the struct wmi_start_scan_cmd that
> gets sent to the driver to not reflect the desired state set in scan_req_params.
> 
>> So your change has no effect on the driver operation and incorrectly
>> tries to foist the firmware definition upon the host internal
>> representation.
> 
> So either we should not use WMI_SCAN_XXX with scan_req_params.scan_flags ever
> and only use the bitfield to set scan parameters or if we use WMI_SCAN_XXX with
> scan_req_params.scan_flags they need to match the corresponding bitfield.

IMO the correct thing to do is to remove the unions from that struct and
only leave behind the bitfields and not use the WMI_SCAN_XXX masks
except when filling the firmware structure.

But don't spin an update to your patches until Kalle has a chance to
give his opinion. I'm new to maintaining these drivers and Kalle may
have a different opinion on this.

/jeff



