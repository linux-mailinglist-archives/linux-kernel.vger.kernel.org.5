Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B66978006B8
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 10:22:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377883AbjLAJWG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 04:22:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjLAJWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 04:22:05 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A8531A6;
        Fri,  1 Dec 2023 01:22:12 -0800 (PST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B14sTid005013;
        Fri, 1 Dec 2023 09:21:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=tul7YL1lXXmGuJMUrSxJabsS90yyEUOoBc8g08oQ/R0=;
 b=DAPQcXtQkLZIfti1Jyr1wROlazeCVg54HBcHa4gy1g9RFOCy97J7hAbiME01eBXLYtQ7
 zWm7liMEhw5azn759WX2V7aTl5fA7tfemvfop3nx8pbPQTU6GqXTppYYbrDvim44KVON
 1KUdJiciqZ8EUkfBpX8pheeECjmgNzA7mUbq9kqH5vstp5/AewkhkdUIj43h22ItZ/S0
 +pknbFhTSxm64YW2eYrBo17pu5m8aXgJF0SdEzKKguRkFGqsmdPu/BYOKJDOUNN2VtQb
 GWthdfCuZMKLghBrbfFEwOxbpLo5J2h25yjmShEWwGXfoiCmmHCFvAbk1piF2FBntq+7 bg== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3upv482eru-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Dec 2023 09:21:53 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3B19Lq4s027065
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 1 Dec 2023 09:21:52 GMT
Received: from [10.50.0.148] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 1 Dec
 2023 01:21:46 -0800
Message-ID: <830f5586-0aec-f2ba-314b-e909f7126248@quicinc.com>
Date:   Fri, 1 Dec 2023 14:51:40 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v7 04/10] scsi: ufs: ufs-qcom: Allow the first init start
 with the maximum supported gear
Content-Language: en-US
To:     Can Guo <quic_cang@quicinc.com>, <bvanassche@acm.org>,
        <mani@kernel.org>, <adrian.hunter@intel.com>, <vkoul@kernel.org>,
        <beanhuo@micron.com>, <avri.altman@wdc.com>,
        <junwoo80.lee@samsung.com>, <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "open list" <linux-kernel@vger.kernel.org>
References: <1701407001-471-1-git-send-email-quic_cang@quicinc.com>
 <1701407001-471-5-git-send-email-quic_cang@quicinc.com>
From:   Nitin Rawat <quic_nitirawa@quicinc.com>
In-Reply-To: <1701407001-471-5-git-send-email-quic_cang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: NAltkgEwVqmUrEQrjAJSsNnA0VgCW4QL
X-Proofpoint-ORIG-GUID: NAltkgEwVqmUrEQrjAJSsNnA0VgCW4QL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-01_06,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 spamscore=0 clxscore=1011 impostorscore=0 lowpriorityscore=0 mlxscore=0
 phishscore=0 suspectscore=0 bulkscore=0 priorityscore=1501 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2312010061
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/1/2023 10:33 AM, Can Guo wrote:
> During host driver init, the phy_gear is set to the minimum supported gear
> (HS_G2). Then, during the first power mode change, the negotiated gear, say
> HS-G4, is updated to the phy_gear variable so that in the second init the
> updated phy_gear can be used to program the PHY.
> 
> But the current code only allows update the phy_gear to a higher value. If
> one wants to start the first init with the maximum support gear, say HS-G4,
> the phy_gear is not updated to HS-G3 if the device only supports HS-G3.
> 
> The original check added there is intend to make sure the phy_gear won't be
> updated when gear is scaled down (during clock scaling). Update the check
> so that one can start the first init with the maximum support gear without
> breaking the original fix by checking the ufshcd_state, that is, allow
> update to phy_gear only if power mode change is invoked from
> ufshcd_probe_hba().
> 
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Signed-off-by: Can Guo <quic_cang@quicinc.com>
> ---
>   drivers/ufs/host/ufs-qcom.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
> index 9a90019..81056b9 100644
> --- a/drivers/ufs/host/ufs-qcom.c
> +++ b/drivers/ufs/host/ufs-qcom.c
> @@ -916,11 +916,12 @@ static int ufs_qcom_pwr_change_notify(struct ufs_hba *hba,
>   		}
>   
>   		/*
> -		 * Update phy_gear only when the gears are scaled to a higher value. This is
> -		 * because, the PHY gear settings are backwards compatible and we only need to
> -		 * change the PHY gear settings while scaling to higher gears.
> +		 * During UFS driver probe, always update the PHY gear to match the negotiated
> +		 * gear, so that, if quirk UFSHCD_QUIRK_REINIT_AFTER_MAX_GEAR_SWITCH is enabled,
> +		 * the second init can program the optimal PHY settings. This allows one to start
> +		 * the first init with either the minimum or the maximum support gear.
>   		 */
> -		if (dev_req_params->gear_tx > host->phy_gear)
> +		if (hba->ufshcd_state == UFSHCD_STATE_RESET)
>   			host->phy_gear = dev_req_params->gear_tx;
>   
>   		/* enable the device ref clock before changing to HS mode */

Reviewed-by: Nitin Rawat <quic_nitirawa@quicinc.com>
