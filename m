Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC50979A312
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 07:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234216AbjIKF4e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 01:56:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234180AbjIKF4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 01:56:32 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D9AB1BE;
        Sun, 10 Sep 2023 22:56:26 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38B5axoU010638;
        Mon, 11 Sep 2023 05:56:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=lmru1Sn8/VaCEKwQIAjaIi1bGOZKx2C3OftwvHyAweE=;
 b=PqQDevfbSUUL2qG8cxsRaYBJKIfah/0k/KEzTZb07ZjGUOh/KUHSbHri5JWiG6uQ2dIY
 8WcpY6KcijyYJ7hexv/Le0FpCFyi9kaUAha4ciS0QDlQoQ9sZS+LVqeamThoD+FCBL3O
 zIUAKN0lgpyT9nPf5xB6bk26pAwqP/53DJzMMjTnle7uB3A9SfziiweFBvYKy9PRvtSB
 lOCEGfyqa8EE6v9sBj+MUP4duyazPs1nKecU+bPbTYYCoLZGUN07QQqnGyeRgfPZbyAU
 /SNvGhhc3VGHo3dn/Iy8y8pcXEhOqYcIAEqQ8Zpi4VQeTw9K9oGCWN5qN0x5UBlEq3g8 iw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t0hvyjr33-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Sep 2023 05:56:13 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38B5uCoH030923
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Sep 2023 05:56:12 GMT
Received: from [10.253.14.78] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Sun, 10 Sep
 2023 22:56:09 -0700
Message-ID: <027eb591-98c9-a6c2-698e-2206fb960d21@quicinc.com>
Date:   Mon, 11 Sep 2023 13:56:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 2/2] scsi: ufs: ufs-qcom: Rename "hs_gear" to "phy_gear"
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        <jejb@linux.ibm.com>, <martin.petersen@oracle.com>
CC:     <bvanassche@acm.org>, <avri.altman@wdc.com>,
        <alim.akhtar@samsung.com>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_nitirawa@quicinc.com>
References: <20230908145329.154024-1-manivannan.sadhasivam@linaro.org>
 <20230908145329.154024-2-manivannan.sadhasivam@linaro.org>
From:   Can Guo <quic_cang@quicinc.com>
In-Reply-To: <20230908145329.154024-2-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: skZYFIVNaGl7MLNFsHa3bXIVTqHUfPUA
X-Proofpoint-GUID: skZYFIVNaGl7MLNFsHa3bXIVTqHUfPUA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-11_03,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 clxscore=1015 mlxscore=0 malwarescore=0 impostorscore=0 adultscore=0
 priorityscore=1501 mlxlogscore=999 spamscore=0 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309110054
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/8/2023 10:53 PM, Manivannan Sadhasivam wrote:
> The "hs_gear" variable is used to cache the gear setting for the PHY that
> will be used during ufs_qcom_power_up_sequence(). But it creates ambiguity
> with the gear setting used by the ufshcd driver.
>
> So let's rename it to "phy_gear" to make it explicit that this variable
> caches the gear setting for the PHY.
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>   drivers/ufs/host/ufs-qcom.c | 14 +++++++-------
>   drivers/ufs/host/ufs-qcom.h |  2 +-
>   2 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
> index ebb8054a3b3e..93a72d0a1751 100644
> --- a/drivers/ufs/host/ufs-qcom.c
> +++ b/drivers/ufs/host/ufs-qcom.c
> @@ -460,7 +460,7 @@ static int ufs_qcom_power_up_sequence(struct ufs_hba *hba)
>   		return ret;
>   	}
>   
> -	phy_set_mode_ext(phy, PHY_MODE_UFS_HS_B, host->hs_gear);
> +	phy_set_mode_ext(phy, PHY_MODE_UFS_HS_B, host->phy_gear);
>   
>   	/* power on phy - start serdes and phy's power and clocks */
>   	ret = phy_power_on(phy);
> @@ -910,12 +910,12 @@ static int ufs_qcom_pwr_change_notify(struct ufs_hba *hba,
>   		}
>   
>   		/*
> -		 * Update hs_gear only when the gears are scaled to a higher value. This is because,
> -		 * the PHY gear settings are backwards compatible and we only need to change the PHY
> -		 * settings while scaling to higher gears.
> +		 * Update phy_gear only when the gears are scaled to a higher value. This is
> +		 * because, the PHY gear settings are backwards compatible and we only need to
> +		 * change the PHY gear settings while scaling to higher gears.
>   		 */
> -		if (dev_req_params->gear_tx > host->hs_gear)
> -			host->hs_gear = dev_req_params->gear_tx;
> +		if (dev_req_params->gear_tx > host->phy_gear)
> +			host->phy_gear = dev_req_params->gear_tx;
>   
>   		/* enable the device ref clock before changing to HS mode */
>   		if (!ufshcd_is_hs_mode(&hba->pwr_info) &&
> @@ -1282,7 +1282,7 @@ static int ufs_qcom_init(struct ufs_hba *hba)
>   	 * Power up the PHY using the minimum supported gear (UFS_HS_G2).
>   	 * Switching to max gear will be performed during reinit if supported.
>   	 */
> -	host->hs_gear = UFS_HS_G2;
> +	host->phy_gear = UFS_HS_G2;
>   
>   	return 0;
>   
> diff --git a/drivers/ufs/host/ufs-qcom.h b/drivers/ufs/host/ufs-qcom.h
> index dc27395ecba1..8d8613eff959 100644
> --- a/drivers/ufs/host/ufs-qcom.h
> +++ b/drivers/ufs/host/ufs-qcom.h
> @@ -227,7 +227,7 @@ struct ufs_qcom_host {
>   
>   	struct gpio_desc *device_reset;
>   
> -	u32 hs_gear;
> +	u32 phy_gear;
>   
>   	int esi_base;
>   	bool esi_enabled;

Reviewed-by: Can Guo <quic_cang@quicinc.com>

Tested-by: Can Guo <quic_cang@quicinc.com>

