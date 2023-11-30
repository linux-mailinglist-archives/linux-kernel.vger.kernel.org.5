Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E16297FE8DB
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 06:56:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344554AbjK3FxF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 00:53:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjK3FxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 00:53:02 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40BEDD66;
        Wed, 29 Nov 2023 21:53:09 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AU5Dcc3009566;
        Thu, 30 Nov 2023 05:52:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=VTf+Odf4uwv7DcH0svA0NNpwMVuLtuZJUMEGbWOSwBs=;
 b=T8449V5amdq2KLKignwDgYR+dLlJQbMEe+1kM6gJMdXTsSm+l58LUjwcpYaHW3Odj480
 kCBAdDMRS6WI0s53ej8H1oG6HdpcT4toXiwwsre8UPyOCrHEFwBqyEIzs71+Sm4GWQnA
 Vfwin+ndEfw2h0CpBg6R732HNkf3CzKqI3QDIR4CDhkYTa0aB0bYq2MS6LXjzgC2fn+4
 gP5UYxIkdfRFKrJmhe2a7hLB9Tirk8XpJUZ/hjhpvU3F3haRtd/giRCmlNrWZZUMrMP8
 seAgfMl0qvcphC5iic17Q55rNVMXnOszY8BNkiMUBc7g4RizHbAohZ1o41SsmnmgyLZZ 6A== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3up4cfae08-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Nov 2023 05:52:54 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AU5qr9g019608
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Nov 2023 05:52:53 GMT
Received: from [10.50.17.88] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 29 Nov
 2023 21:52:48 -0800
Message-ID: <db1e6532-efc6-d78c-2cf5-166a6c371076@quicinc.com>
Date:   Thu, 30 Nov 2023 11:22:45 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v6 06/10] scsi: ufs: ufs-qcom: Set initial PHY gear to max
 HS gear for HW ver 4 and newer
Content-Language: en-US
To:     Can Guo <quic_cang@quicinc.com>, <bvanassche@acm.org>,
        <mani@kernel.org>, <adrian.hunter@intel.com>, <cmd4@qualcomm.com>,
        <beanhuo@micron.com>, <avri.altman@wdc.com>,
        <junwoo80.lee@samsung.com>, <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "open list" <linux-kernel@vger.kernel.org>
References: <1701246516-11626-1-git-send-email-quic_cang@quicinc.com>
 <1701246516-11626-7-git-send-email-quic_cang@quicinc.com>
From:   Nitin Rawat <quic_nitirawa@quicinc.com>
In-Reply-To: <1701246516-11626-7-git-send-email-quic_cang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ZyZ9H8e31KsPs7S9A1woJm_-Xzu7mhiC
X-Proofpoint-ORIG-GUID: ZyZ9H8e31KsPs7S9A1woJm_-Xzu7mhiC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-30_02,2023-11-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 malwarescore=0 impostorscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999
 clxscore=1015 phishscore=0 priorityscore=1501 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311300043
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/29/2023 1:58 PM, Can Guo wrote:
> Since HW ver 4, max HS gear can be get from UFS host controller's register,
> use the max HS gear as the initial PHY gear instead of UFS_HS_G2, so that
> we don't need to update the hard code for newer targets in future.
> 
> Signed-off-by: Can Guo <quic_cang@quicinc.com>
> ---
>   drivers/ufs/host/ufs-qcom.c | 21 +++++++++++++++------
>   1 file changed, 15 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
> index aca6199..30f4ca6 100644
> --- a/drivers/ufs/host/ufs-qcom.c
> +++ b/drivers/ufs/host/ufs-qcom.c
> @@ -1060,6 +1060,20 @@ static void ufs_qcom_advertise_quirks(struct ufs_hba *hba)
>   		hba->quirks |= UFSHCD_QUIRK_REINIT_AFTER_MAX_GEAR_SWITCH;
>   }
>   
> +static void ufs_qcom_set_phy_gear(struct ufs_qcom_host *host)
> +{
> +	struct ufs_host_params *host_params = &host->host_params;
> +
> +	host->phy_gear = host_params->hs_tx_gear;
> +
> +	/*
> +	 * Power up the PHY using the minimum supported gear (UFS_HS_G2).
> +	 * Switching to max gear will be performed during reinit if supported.
> +	 */
> +	if (host->hw_ver.major < 0x4)
> +		host->phy_gear = UFS_HS_G2;
> +}
> +
>   static void ufs_qcom_set_host_params(struct ufs_hba *hba)
>   {
>   	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
> @@ -1296,6 +1310,7 @@ static int ufs_qcom_init(struct ufs_hba *hba)
>   	ufs_qcom_set_caps(hba);
>   	ufs_qcom_advertise_quirks(hba);
>   	ufs_qcom_set_host_params(hba);
> +	ufs_qcom_set_phy_gear(host);
>   
>   	err = ufs_qcom_ice_init(host);
>   	if (err)
> @@ -1313,12 +1328,6 @@ static int ufs_qcom_init(struct ufs_hba *hba)
>   		dev_warn(dev, "%s: failed to configure the testbus %d\n",
>   				__func__, err);
>   
> -	/*
> -	 * Power up the PHY using the minimum supported gear (UFS_HS_G2).
> -	 * Switching to max gear will be performed during reinit if supported.
> -	 */
> -	host->phy_gear = UFS_HS_G2;
> -
>   	return 0;
>   
>   out_variant_clear:

Reviewed-by: Nitin Rawat <quic_nitirawa@quicinc.com>
