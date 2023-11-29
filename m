Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 946097FD111
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 09:39:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbjK2Ii7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 03:38:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjK2Iiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 03:38:54 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E274AF;
        Wed, 29 Nov 2023 00:38:57 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AT3IZJR023797;
        Wed, 29 Nov 2023 08:38:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=8hNsqrcucfaRbaEy3r+FknKId6ZfrP9jn3JDUL3i7j4=;
 b=ZDmMX2DSc06YI/X4RVC/3Un1/zbcH/r5sQP/TlT2F4tvF0t3NnVdOaRIQuZAnnwKq/xM
 Hu9L/SQf/xmoClWzJb5WKKsLRUufOeN+ANxSeLUCwuVMqT0yxGF0rfOL7TiFU4dLAam+
 gwEIVFdC6lA7wI8PW60ZJqLBMWuNhGb727pB17wKFoRq0lK0Olyu8kAld61fywoL3k5P
 Fxoa87O6hOBmyarhrv/hCBrQNXlLELaxPVliV72chYx0cT3N8GhFhWvDi+7pkQj9EA2z
 RuLon/94GYug3SqG+9IDYAQ3hwIUKDlhajy6fxuzepEbLq11dRJYGYCAhvkdxXbzRwmo FQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3unkent466-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Nov 2023 08:38:43 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AT8cgnl001314
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Nov 2023 08:38:42 GMT
Received: from [10.218.45.181] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 29 Nov
 2023 00:38:37 -0800
Message-ID: <25cdc471-fe0e-3e87-0e41-bc3b7f7d2ade@quicinc.com>
Date:   Wed, 29 Nov 2023 14:08:34 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v6 09/10] scsi: ufs: ufs-qcom: Check return value of
 phy_set_mode_ext()
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
 <1701246516-11626-10-git-send-email-quic_cang@quicinc.com>
From:   Nitin Rawat <quic_nitirawa@quicinc.com>
In-Reply-To: <1701246516-11626-10-git-send-email-quic_cang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: I3c3AWMSl6_pcOjyWbJK5jN_WXmn-O2c
X-Proofpoint-ORIG-GUID: I3c3AWMSl6_pcOjyWbJK5jN_WXmn-O2c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-29_06,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 impostorscore=0 mlxscore=0 phishscore=0 spamscore=0 priorityscore=1501
 bulkscore=0 mlxlogscore=999 lowpriorityscore=0 adultscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311290063
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/29/2023 1:58 PM, Can Guo wrote:
> In ufs_qcom_power_up_sequence(), check return value of phy_set_mode_ext()
> and stop proceeding if phy_set_mode_ext() fails.
> 
> Signed-off-by: Can Guo <quic_cang@quicinc.com>
> ---
>   drivers/ufs/host/ufs-qcom.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
> index 30f4ca6..9c0ebbc 100644
> --- a/drivers/ufs/host/ufs-qcom.c
> +++ b/drivers/ufs/host/ufs-qcom.c
> @@ -475,7 +475,12 @@ static int ufs_qcom_power_up_sequence(struct ufs_hba *hba)
>   		return ret;
>   	}
>   
> -	phy_set_mode_ext(phy, mode, host->phy_gear);
> +	ret = phy_set_mode_ext(phy, mode, host->phy_gear);
> +	if (ret) {
> +		dev_err(hba->dev, "%s: phy set mode failed, ret = %d\n",
> +			__func__, ret);
> +		goto out_disable_phy;
> +	}
>   
>   	/* power on phy - start serdes and phy's power and clocks */
>   	ret = phy_power_on(phy);

Reviewed-by: Nitin Rawat <quic_nitirawa@quicinc.com>
