Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44F7F7A0414
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 14:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238399AbjINMkb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 08:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbjINMk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 08:40:29 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A22351FCC;
        Thu, 14 Sep 2023 05:40:25 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38E5XEqF028349;
        Thu, 14 Sep 2023 12:40:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=qez4CXnGUw1IypJ0y5ikMWPHFvJWDjjYZe2toiWMvUU=;
 b=BWZsMU2gH4P8heNOb6AkE8zY4pcGgw8aLNU87BpwPNysTKj2P+LevDJuKDH1ezuolFWw
 gg3p1ItaVprjh0za0BfyLBLa0PCuoAg836F4CdSk9qFSzZ5STwQe4mH0E91M11J8+Ntz
 YYhKCbXUm5Wx7SONjVtMz7ickLeCBVHD6E/GT39zksYUBwaF4TIZyohVqKHrfa+MXOX9
 rDu3yTu1Z7Ke91h6xP6Q5I9Ujtog1mnJli438Tx199s+Cn2kHheZVn9SxGhNtUSpjIrW
 V785793+cqP2sQqlxScbzkBczZsjDVOPxzxOyZpugiusGagu4UWvHGrLaRly8EHIYZ/x fw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t3v4h94q8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Sep 2023 12:40:16 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38ECeF9X015297
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Sep 2023 12:40:15 GMT
Received: from [10.218.45.181] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Thu, 14 Sep
 2023 05:40:11 -0700
Message-ID: <5a2dc1a8-6a69-2eaa-aa20-127b2ee3d4d0@quicinc.com>
Date:   Thu, 14 Sep 2023 18:10:08 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH 1/6] scsi: ufs: ufs-qcom: Setup host power mode during
 init
Content-Language: en-US
To:     Can Guo <quic_cang@quicinc.com>, <mani@kernel.org>,
        <quic_nguyenb@quicinc.com>, <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>, Andy Gross <agross@kernel.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "open list:UNIVERSAL FLASH STORAGE HOST CONTROLLER DRIVER..." 
        <linux-arm-msm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <1694411968-14413-1-git-send-email-quic_cang@quicinc.com>
 <1694411968-14413-2-git-send-email-quic_cang@quicinc.com>
From:   Nitin Rawat <quic_nitirawa@quicinc.com>
In-Reply-To: <1694411968-14413-2-git-send-email-quic_cang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: T-PizfkFyaJOGysut6OsFsnTAyCdceIq
X-Proofpoint-GUID: T-PizfkFyaJOGysut6OsFsnTAyCdceIq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-14_09,2023-09-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 clxscore=1015 spamscore=0 impostorscore=0 malwarescore=0
 lowpriorityscore=0 mlxscore=0 bulkscore=0 mlxlogscore=999 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309140109
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/11/2023 11:29 AM, Can Guo wrote:
> Setup host power mode and its limitations during UFS host driver init to
> avoid repetitive work during every power mode change.
> 
> Co-developed-by: Bao D. Nguyen <quic_nguyenb@quicinc.com>
> Signed-off-by: Can Guo <quic_cang@quicinc.com>
> Signed-off-by: Bao D. Nguyen <quic_nguyenb@quicinc.com>

Hi Can,

Patch looks good. Please can you just change the order of Signed-off-by.
I think it should be like below:

Co-developed-by: Bao D. Nguyen <quic_nguyenb@quicinc.com>
Signed-off-by: Bao D. Nguyen <quic_nguyenb@quicinc.com>
Signed-off-by: Can Guo <quic_cang@quicinc.com>

--Nitin

> ---
>   drivers/ufs/host/ufs-qcom.c | 27 ++++++++++++++++++---------
>   drivers/ufs/host/ufs-qcom.h |  1 +
>   2 files changed, 19 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
> index c3215d3..710f079 100644
> --- a/drivers/ufs/host/ufs-qcom.c
> +++ b/drivers/ufs/host/ufs-qcom.c
> @@ -443,7 +443,11 @@ static u32 ufs_qcom_get_hs_gear(struct ufs_hba *hba)
>   static int ufs_qcom_power_up_sequence(struct ufs_hba *hba)
>   {
>   	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
> +	struct ufs_dev_params *host_pwr_cap = &host->host_pwr_cap;
>   	struct phy *phy = host->generic_phy;
> +	enum phy_mode mode = host_pwr_cap->hs_rate == PA_HS_MODE_B ?
> +							PHY_MODE_UFS_HS_B :
> +							PHY_MODE_UFS_HS_A;
>   	int ret;
>   
>   	/* Reset UFS Host Controller and PHY */
> @@ -460,7 +464,7 @@ static int ufs_qcom_power_up_sequence(struct ufs_hba *hba)
>   		return ret;
>   	}
>   
> -	phy_set_mode_ext(phy, PHY_MODE_UFS_HS_B, host->phy_gear);
> +	phy_set_mode_ext(phy, mode, host->phy_gear);
>   
>   	/* power on phy - start serdes and phy's power and clocks */
>   	ret = phy_power_on(phy);
> @@ -884,7 +888,6 @@ static int ufs_qcom_pwr_change_notify(struct ufs_hba *hba,
>   				struct ufs_pa_layer_attr *dev_req_params)
>   {
>   	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
> -	struct ufs_dev_params ufs_qcom_cap;
>   	int ret = 0;
>   
>   	if (!dev_req_params) {
> @@ -894,13 +897,7 @@ static int ufs_qcom_pwr_change_notify(struct ufs_hba *hba,
>   
>   	switch (status) {
>   	case PRE_CHANGE:
> -		ufshcd_init_pwr_dev_param(&ufs_qcom_cap);
> -		ufs_qcom_cap.hs_rate = UFS_QCOM_LIMIT_HS_RATE;
> -
> -		/* This driver only supports symmetic gear setting i.e., hs_tx_gear == hs_rx_gear */
> -		ufs_qcom_cap.hs_tx_gear = ufs_qcom_cap.hs_rx_gear = ufs_qcom_get_hs_gear(hba);
> -
> -		ret = ufshcd_get_pwr_dev_param(&ufs_qcom_cap,
> +		ret = ufshcd_get_pwr_dev_param(&host->host_pwr_cap,
>   					       dev_max_params,
>   					       dev_req_params);
>   		if (ret) {
> @@ -1037,6 +1034,17 @@ static void ufs_qcom_advertise_quirks(struct ufs_hba *hba)
>   		hba->quirks |= UFSHCD_QUIRK_REINIT_AFTER_MAX_GEAR_SWITCH;
>   }
>   
> +static void ufs_qcom_set_pwr_mode_limits(struct ufs_hba *hba)
> +{
> +	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
> +	struct ufs_dev_params *host_pwr_cap = &host->host_pwr_cap;
> +
> +	ufshcd_init_pwr_dev_param(host_pwr_cap);
> +
> +	/* This driver only supports symmetic gear setting i.e., hs_tx_gear == hs_rx_gear */
> +	host_pwr_cap->hs_tx_gear = host_pwr_cap->hs_rx_gear = ufs_qcom_get_hs_gear(hba);
> +}
> +
>   static void ufs_qcom_set_caps(struct ufs_hba *hba)
>   {
>   	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
> @@ -1259,6 +1267,7 @@ static int ufs_qcom_init(struct ufs_hba *hba)
>   	if (err)
>   		goto out_variant_clear;
>   
> +	ufs_qcom_set_pwr_mode_limits(hba);
>   	ufs_qcom_set_caps(hba);
>   	ufs_qcom_advertise_quirks(hba);
>   
> diff --git a/drivers/ufs/host/ufs-qcom.h b/drivers/ufs/host/ufs-qcom.h
> index fa54248..4db64d9 100644
> --- a/drivers/ufs/host/ufs-qcom.h
> +++ b/drivers/ufs/host/ufs-qcom.h
> @@ -227,6 +227,7 @@ struct ufs_qcom_host {
>   
>   	struct gpio_desc *device_reset;
>   
> +	struct ufs_dev_params host_pwr_cap;
>   	u32 phy_gear;
>   
>   	bool esi_enabled;
