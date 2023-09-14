Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0673B7A0B44
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 19:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238750AbjINRHL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 13:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232000AbjINRHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 13:07:10 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E36D11FE1;
        Thu, 14 Sep 2023 10:07:05 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38EFEPat026692;
        Thu, 14 Sep 2023 17:06:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=VS5omclDy3oniz92XfXL1gqbRojQdj9K/4l/+LddOJ0=;
 b=QAyD27Tfoq3ApMqGseXEJMgkHjxE4aLrzxF91opPn4+NvyscQ7HHOkzBCay457yTYnVc
 aRs8IqLAbp8P8pVOhhRVjtyoFRZbWYe0ox+W16SzQPOt5nPYMge+Em0dnwxZjOAEu8a4
 YEkGRcO8GJBLteYJRskkvyw6qGVk/kg+2R6JH5ElZ/BQ/HXcLmYBw6KFEZOVNoezZFC/
 Gdgl9yQ9LT3tLk6vaWQOEoGPizwhDhsmiYECWZBTk4ZVqLvLRgeYa7pDSK6Zexr7kgUH
 P2IzbMraTe+EvPTi1st8uWD6kF7uVSD5Nn0mBWQ8U0+BdD87NBLJRXVxlBgNhOL46Kis Jg== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t3wx19kps-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Sep 2023 17:06:53 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38EH6qdc004174
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Sep 2023 17:06:52 GMT
Received: from [10.111.183.186] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Thu, 14 Sep
 2023 10:06:52 -0700
Message-ID: <7427d5aa-902a-4013-8aa9-f986bb5218a4@quicinc.com>
Date:   Thu, 14 Sep 2023 10:06:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next 7/9] wifi: ath12k: Remove unnecessary
 (void*) conversions
Content-Language: en-US
To:     Wu Yunchuan <yunchuan@nfschina.com>, <kvalo@kernel.org>
CC:     <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
References: <20230914040525.1170102-1-yunchuan@nfschina.com>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20230914040525.1170102-1-yunchuan@nfschina.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Q1UfUiFg-rmx_-W3ymAyC5ujLujnkhDE
X-Proofpoint-ORIG-GUID: Q1UfUiFg-rmx_-W3ymAyC5ujLujnkhDE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-14_09,2023-09-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 mlxscore=0 bulkscore=0 adultscore=0 clxscore=1015
 phishscore=0 mlxlogscore=999 impostorscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309140148
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/13/2023 9:05 PM, Wu Yunchuan wrote:
> No need cast (void*) to (struct hal_rx_ppdu_end_user_stats *),
> (struct ath12k_rx_desc_info *) or (struct hal_tx_msdu_ext_desc *).
> 
> Signed-off-by: Wu Yunchuan <yunchuan@nfschina.com>
> ---
>   drivers/net/wireless/ath/ath12k/dp_mon.c | 6 ++----
>   drivers/net/wireless/ath/ath12k/dp_rx.c  | 2 +-
>   drivers/net/wireless/ath/ath12k/dp_tx.c  | 2 +-
>   3 files changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/dp_mon.c b/drivers/net/wireless/ath/ath12k/dp_mon.c
> index f1e57e98bdc6..41cfe7bd865f 100644
> --- a/drivers/net/wireless/ath/ath12k/dp_mon.c
> +++ b/drivers/net/wireless/ath/ath12k/dp_mon.c
> @@ -13,8 +13,7 @@
>   static void ath12k_dp_mon_rx_handle_ofdma_info(void *rx_tlv,
>   					       struct hal_rx_user_status *rx_user_status)
>   {
> -	struct hal_rx_ppdu_end_user_stats *ppdu_end_user =
> -				(struct hal_rx_ppdu_end_user_stats *)rx_tlv;
> +	struct hal_rx_ppdu_end_user_stats *ppdu_end_user = rx_tlv;
>   
>   	rx_user_status->ul_ofdma_user_v0_word0 =
>   		__le32_to_cpu(ppdu_end_user->usr_resp_ref);
> @@ -26,8 +25,7 @@ static void
>   ath12k_dp_mon_rx_populate_byte_count(void *rx_tlv, void *ppduinfo,
>   				     struct hal_rx_user_status *rx_user_status)
>   {
> -	struct hal_rx_ppdu_end_user_stats *ppdu_end_user =
> -		(struct hal_rx_ppdu_end_user_stats *)rx_tlv;
> +	struct hal_rx_ppdu_end_user_stats *ppdu_end_user = rx_tlv;
>   	u32 mpdu_ok_byte_count = __le32_to_cpu(ppdu_end_user->mpdu_ok_cnt);
>   	u32 mpdu_err_byte_count = __le32_to_cpu(ppdu_end_user->mpdu_err_cnt);
>   

for both of the above IMO the better solution is to change the prototype 
to replace void *rx_tlv with struct hal_rx_ppdu_end_user_stats 
*ppdu_end_user and to remove the local variable

further, I think you can add const to that since the TLV is only read, 
not written

this better describes that the function requires a specific flavor of RX 
TLV rather than handling any RX TLV

> diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
> index e6e64d437c47..ff5f66ca7783 100644
> --- a/drivers/net/wireless/ath/ath12k/dp_rx.c
> +++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
> @@ -3730,7 +3730,7 @@ int ath12k_dp_rx_process_wbm_err(struct ath12k_base *ab,
>   			continue;
>   		}
>   
> -		desc_info = (struct ath12k_rx_desc_info *)err_info.rx_desc;
> +		desc_info = err_info.rx_desc;

this is ok

>   
>   		/* retry manual desc retrieval if hw cc is not done */
>   		if (!desc_info) {
> diff --git a/drivers/net/wireless/ath/ath12k/dp_tx.c b/drivers/net/wireless/ath/ath12k/dp_tx.c
> index 8874c815d7fa..98ddf46b3bb9 100644
> --- a/drivers/net/wireless/ath/ath12k/dp_tx.c
> +++ b/drivers/net/wireless/ath/ath12k/dp_tx.c
> @@ -109,7 +109,7 @@ static struct ath12k_tx_desc_info *ath12k_dp_tx_assign_buffer(struct ath12k_dp *
>   static void ath12k_hal_tx_cmd_ext_desc_setup(struct ath12k_base *ab, void *cmd,

This function is only called from one place, and it is already passing a 
variable that is of type struct hal_tx_msdu_ext_desc *
so IMO a better solution is to change the prototype to replace void *cmd 
with struct hal_tx_msdu_ext_desc *tcl_ext_desc and remove the local variable

again this better describes that the function requires a specific 
payload rather than a generic opaque payload

as a general rule, use void * when the payload has some level of 
opaqueness and use a specific struct * when the payload must be of a 
specific type

>   					     struct hal_tx_info *ti)
>   {
> -	struct hal_tx_msdu_ext_desc *tcl_ext_cmd = (struct hal_tx_msdu_ext_desc *)cmd;
> +	struct hal_tx_msdu_ext_desc *tcl_ext_cmd = cmd;
>   
>   	tcl_ext_cmd->info0 = le32_encode_bits(ti->paddr,
>   					      HAL_TX_MSDU_EXT_INFO0_BUF_PTR_LO);

