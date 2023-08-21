Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69FF17827CC
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 13:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231983AbjHULTo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 07:19:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231925AbjHULTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 07:19:42 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A631DF;
        Mon, 21 Aug 2023 04:19:41 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37LApbL2025772;
        Mon, 21 Aug 2023 11:19:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=bOyxypRSIGKt6D/e7LEaYFk9t4eLni0qi1Sh8IwYmjc=;
 b=l8QUZ5bULMehgiPHW/7h3ZCF50i3SzgCqH1yvXwXLM0dplBV3u23BgozkpOUUDOdIu7g
 hvyoJmeOb0+HmzD8udeieZExg8Q28bFxQIcw6DHNFim30kRjvP+fxe2fJnRhmU4AKx1W
 GrKIP7X2+sAhYKgQocr83BlOrScjR6xM0wFAvVV9mtcSdDWn9cz2Y/msKBo2R81QYjIb
 vlhoKNFdTmJ09p71oscD1aDEloNole66qex57sI+6Ri46V0Qv7D5kpXC46n5fUe01Qlk
 F0UybH7NrkmopqALbXfPqtnWtlen47tFSgs0HjKvs1z0hwwaVJJ+qu1+skyGWcHtW+zu oQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sm6f9r1st-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Aug 2023 11:19:31 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37LBJUCL007775
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Aug 2023 11:19:30 GMT
Received: from [10.216.38.78] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Mon, 21 Aug
 2023 04:19:25 -0700
Message-ID: <3fa6ba13-d5cc-c733-bf38-e862380d97df@quicinc.com>
Date:   Mon, 21 Aug 2023 16:49:20 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH] scsi: ufs: ufs-qcom: clear qunipro_g4_sel for HW major
 version > 5
To:     Manivannan Sadhasivam <mani@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
CC:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230821-topic-sm8x50-upstream-ufs-major-5-plus-v1-1-c14cce209f21@linaro.org>
 <20230821103851.GB36455@thinkpad>
Content-Language: en-US
From:   Nitin Rawat <quic_nitirawa@quicinc.com>
In-Reply-To: <20230821103851.GB36455@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: VhXuiBwq7vEaVzng-kZdm7yv_JAHSRfg
X-Proofpoint-ORIG-GUID: VhXuiBwq7vEaVzng-kZdm7yv_JAHSRfg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-21_01,2023-08-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 impostorscore=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 mlxscore=0
 priorityscore=1501 mlxlogscore=999 adultscore=0 bulkscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308210105
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/21/2023 4:08 PM, Manivannan Sadhasivam wrote:
> On Mon, Aug 21, 2023 at 09:41:54AM +0200, Neil Armstrong wrote:
>> The qunipro_g4_sel clear is also needed for new platforms with
>> major version > 5, fix the version check to take this in account.
>>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> 
> This is a fix, isn't it? With the fixes tag for 9c02aa24bf40,
> 
> Acked-by: Manivannan Sadhasivam <mani@kernel.org>
> 
> - Mani
> 
>> ---
>>   drivers/ufs/host/ufs-qcom.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
>> index f88febb23123..d1149b1c3ed5 100644
>> --- a/drivers/ufs/host/ufs-qcom.c
>> +++ b/drivers/ufs/host/ufs-qcom.c
>> @@ -365,7 +365,7 @@ static void ufs_qcom_select_unipro_mode(struct ufs_qcom_host *host)
>>   		   ufs_qcom_cap_qunipro(host) ? QUNIPRO_SEL : 0,
>>   		   REG_UFS_CFG1);
>>   
>> -	if (host->hw_ver.major == 0x05)
>> +	if (host->hw_ver.major >= 0x05)
>>   		ufshcd_rmwl(host->hba, QUNIPRO_G4_SEL, 0, REG_UFS_CFG0);
>>   
>>   	/* make sure above configuration is applied before we return */
>>
>> ---
>> base-commit: 47d9bb711707d15b19fad18c8e2b4b027a264a3a
>> change-id: 20230821-topic-sm8x50-upstream-ufs-major-5-plus-4eaad3f3d857
>>
>> Best regards,
>> -- 
>> Neil Armstrong <neil.armstrong@linaro.org>
>>
> 


Reviewed-by: Nitin Rawat <quic_nitirawa@quicinc.com>

Regards,
Nitin
