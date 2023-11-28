Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AC447FB11B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 06:16:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343530AbjK1FQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 00:16:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232891AbjK1FQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 00:16:28 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C3F81AD;
        Mon, 27 Nov 2023 21:16:35 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AS3hosp026595;
        Tue, 28 Nov 2023 05:10:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=/k2SFua7d7UPBIIyxU1Nje7lmTtrBOsPHghdDgoOPro=;
 b=coc2fwbKJChjJjnDg870SDOX/fhC2KdxdUSI0wgztgyH+fLdmXbzt4AtT8bSyqs9kuPG
 HsARNOwZSyMMmF4NGtTTmVGu6VxEYCPx10AjJuS+4AWCd5NujNd9rlzB2F3SzjTFW1ol
 qC48e2BCw+ZY3FvTmy+hw5Xvv43qqUGW2c+SBBw2v8qlgEyfRs6ThwyG9/oOvZkFOadH
 h5P2OVV1pPyiHWf0zsNsQc/vupuXE3MfeL1OgqdS4AUroXZSg40j/NHkH+pfmEGvBj7M
 /2LPETWL71sfkawOVm7UxKmX57EwbGJ1nY5OTG1TntWWsauzsHS2I+MXFnrFmhWbslQs aw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3umrqq2huh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Nov 2023 05:10:55 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AS5AtSD023472
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Nov 2023 05:10:55 GMT
Received: from [10.50.30.106] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 27 Nov
 2023 21:10:46 -0800
Message-ID: <a8452c90-8b2b-9ab8-9f52-f00773522b2b@quicinc.com>
Date:   Tue, 28 Nov 2023 10:40:39 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v5 02/10] scsi: ufs: ufs-qcom: No need to set hs_rate
 after ufshcd_init_host_param()
Content-Language: en-US
To:     Can Guo <quic_cang@quicinc.com>, <bvanassche@acm.org>,
        <mani@kernel.org>, <adrian.hunter@intel.com>, <beanhuo@micron.com>,
        <avri.altman@wdc.com>, <junwoo80.lee@samsung.com>,
        <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "open list" <linux-kernel@vger.kernel.org>
References: <1700729190-17268-1-git-send-email-quic_cang@quicinc.com>
 <1700729190-17268-3-git-send-email-quic_cang@quicinc.com>
From:   Nitin Rawat <quic_nitirawa@quicinc.com>
In-Reply-To: <1700729190-17268-3-git-send-email-quic_cang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 7mf-mDaKO6aVI6zeKcCS2fafjOxy5QZc
X-Proofpoint-GUID: 7mf-mDaKO6aVI6zeKcCS2fafjOxy5QZc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-28_03,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0
 priorityscore=1501 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0
 spamscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311060000 definitions=main-2311280038
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/23/2023 2:16 PM, Can Guo wrote:
> In ufs_qcom_pwr_change_notify(), host_params.hs_rate has been set to
> PA_HS_MODE_B by ufshcd_init_host_param(), hence remove the duplicated line
> of work. Meanwhile, removed the macro UFS_QCOM_LIMIT_HS_RATE as it is only
> used here.
> 
> Signed-off-by: Can Guo <quic_cang@quicinc.com>
> ---
>   drivers/ufs/host/ufs-qcom.c | 1 -
>   drivers/ufs/host/ufs-qcom.h | 2 --
>   2 files changed, 3 deletions(-)
> 
> diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
> index aee66a3..cc30ad9 100644
> --- a/drivers/ufs/host/ufs-qcom.c
> +++ b/drivers/ufs/host/ufs-qcom.c
> @@ -909,7 +909,6 @@ static int ufs_qcom_pwr_change_notify(struct ufs_hba *hba,
>   	switch (status) {
>   	case PRE_CHANGE:
>   		ufshcd_init_host_param(&host_params);
> -		host_params.hs_rate = UFS_QCOM_LIMIT_HS_RATE;
>   
>   		/* This driver only supports symmetic gear setting i.e., hs_tx_gear == hs_rx_gear */
>   		host_params.hs_tx_gear = host_params.hs_rx_gear = ufs_qcom_get_hs_gear(hba);
> diff --git a/drivers/ufs/host/ufs-qcom.h b/drivers/ufs/host/ufs-qcom.h
> index 9950a00..82cd143 100644
> --- a/drivers/ufs/host/ufs-qcom.h
> +++ b/drivers/ufs/host/ufs-qcom.h
> @@ -27,8 +27,6 @@
>   #define SLOW 1
>   #define FAST 2
>   
> -#define UFS_QCOM_LIMIT_HS_RATE		PA_HS_MODE_B
> -
>   /* QCOM UFS host controller vendor specific registers */
>   enum {
>   	REG_UFS_SYS1CLK_1US                 = 0xC0,

Reviewed-by: Nitin Rawat <quic_nitirawa@quicinc.com>
