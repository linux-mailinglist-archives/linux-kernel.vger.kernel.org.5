Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02A84808364
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 09:43:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbjLGInm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 03:43:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjLGInl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 03:43:41 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6553AC6;
        Thu,  7 Dec 2023 00:43:47 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B77uqlv009412;
        Thu, 7 Dec 2023 08:43:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=LqmAkPe84sCo3V2CHtM4yL2anKlrinpeXglOOdS1zEw=;
 b=nB0B0SRb2+5p0h0jbqrEvlgBmtlDA//NiKqN+V4CKXDiNCwLToN/KLMEOdMI8NvGXyzP
 tqn8TJFYVt4BewdcE+a7eOb+rpAru/xeNMultXyFyiYp4GnhZ05U9D1TmNLK/zi7RDGL
 3fbOjZFHVifMBQ4sCy3gvAkliDgwIL4M8SxE10viOy5A9k/RokNSfkd9RFc7A9c52fk4
 vLmpncg7XXGpkl71IN7zkTQU2P/DAzN+DHvJTyu/6/vrwM2tjQo+QCijXwCNsLqmxDPq
 /A4UBix6s4j3EXa29OeGVZV4RO2btxXutk/3b/uDLUbIl57H3h35AnJwYD2Qcz4HykDH sA== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3utt70a8p6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Dec 2023 08:43:40 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3B78hdeY021252
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 7 Dec 2023 08:43:39 GMT
Received: from [10.218.45.181] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 7 Dec
 2023 00:43:35 -0800
Message-ID: <942760a9-ebc2-f2a9-2eb8-dd15111d3046@quicinc.com>
Date:   Thu, 7 Dec 2023 14:13:32 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH 11/13] scsi: ufs: qcom: Remove unused ufs_qcom_hosts
 struct array
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        <martin.petersen@oracle.com>, <jejb@linux.ibm.com>
CC:     <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_cang@quicinc.com>
References: <20231201151417.65500-1-manivannan.sadhasivam@linaro.org>
 <20231201151417.65500-12-manivannan.sadhasivam@linaro.org>
Content-Language: en-US
From:   Nitin Rawat <quic_nitirawa@quicinc.com>
In-Reply-To: <20231201151417.65500-12-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: cpPWLcqr8_3t2T_dq6ChWhq32NFGlw-0
X-Proofpoint-GUID: cpPWLcqr8_3t2T_dq6ChWhq32NFGlw-0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-07_06,2023-12-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 adultscore=0 phishscore=0 priorityscore=1501 mlxscore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311290000 definitions=main-2312070069
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/1/2023 8:44 PM, Manivannan Sadhasivam wrote:
> ufs_qcom_hosts array is assigned, but not used anywhere. So let's remove
> it.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>   drivers/ufs/host/ufs-qcom.c | 5 -----
>   1 file changed, 5 deletions(-)
> 
> diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
> index a86f6620abc8..824c006be093 100644
> --- a/drivers/ufs/host/ufs-qcom.c
> +++ b/drivers/ufs/host/ufs-qcom.c
> @@ -90,8 +90,6 @@ static const struct __ufs_qcom_bw_table {
>   	[MODE_MAX][0][0]		    = { 7643136,	307200 },
>   };
>   
> -static struct ufs_qcom_host *ufs_qcom_hosts[MAX_UFS_QCOM_HOSTS];
> -
>   static void ufs_qcom_get_default_testbus_cfg(struct ufs_qcom_host *host);
>   static int ufs_qcom_set_core_clk_ctrl(struct ufs_hba *hba, bool is_scale_up);
>   
> @@ -1192,9 +1190,6 @@ static int ufs_qcom_init(struct ufs_hba *hba)
>   
>   	ufs_qcom_setup_clocks(hba, true, POST_CHANGE);
>   
> -	if (hba->dev->id < MAX_UFS_QCOM_HOSTS)
> -		ufs_qcom_hosts[hba->dev->id] = host;
> -
>   	ufs_qcom_get_default_testbus_cfg(host);
>   	err = ufs_qcom_testbus_config(host);
>   	if (err)

Hi Mani,
There is plan to upstream 2nd UFS instance change which may need 
ufs_qcom_hosts. But for now this is unused and can be removed.

Anyways change Looks Good. Hence

Reviewed-by: Nitin Rawat <quic_nitirawa@quicinc.com>


Regards,
Nitin


