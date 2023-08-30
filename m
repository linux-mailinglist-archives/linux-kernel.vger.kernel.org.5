Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39F5778DD90
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245085AbjH3Svw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:51:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343966AbjH3RiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 13:38:17 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E74E193;
        Wed, 30 Aug 2023 10:38:14 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37UCwtR7013946;
        Wed, 30 Aug 2023 17:38:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=unTaW1cc+E1fk9z7cI1y3TILfJHIRP/6p6MZnXpgt1s=;
 b=VMu/r1CQCVFrAbR/Kuf6SoDOjr/nkpQkJKFNDnmawYDQcyx5cNbWaYQ8geLoTo1W5wKI
 Db5t/od26CuoSSa1UjFIL+UqUNUiYMSX9NcdJFd+qkxnGbJpqs8UfWj0/9xMgcw6XQIv
 z2ZSVqs8kHVPQcFIT9Rnna/Gi0IEMnkb8KIkF+3nCtxYyWywQ+BV1JHN5C/iGJtU1jib
 m1lM8+Zw9PKN3ezcrHv8PVuIq7LEk4FWvIKKyCTPNGSSD2e140z+bFBr3N3znf+NnzK0
 trT3agiWtjtXnt3xn3ckHItZc2g0CCBn96QqVr6kw3D65cZKsSjUTuu7KY3q8jMwzQJ3 Hw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ssy5q1a7g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Aug 2023 17:38:08 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37UHc7E5004517
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Aug 2023 17:38:07 GMT
Received: from [10.216.23.190] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Wed, 30 Aug
 2023 10:38:02 -0700
Message-ID: <dbf4e4d1-ba4f-eb7b-f211-ffae7ba1ef27@quicinc.com>
Date:   Wed, 30 Aug 2023 23:07:59 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH V5 2/6] scsi: ufs: qcom: Configure
 PA_VS_CORE_CLK_40NS_CYCLES for Unipro core clk
Content-Language: en-US
To:     Manivannan Sadhasivam <mani@kernel.org>
CC:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <quic_cang@quicinc.com>,
        <quic_nguyenb@quicinc.com>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        "Naveen Kumar Goud Arepalli" <quic_narepall@quicinc.com>
References: <20230823154413.23788-1-quic_nitirawa@quicinc.com>
 <20230823154413.23788-3-quic_nitirawa@quicinc.com>
 <20230828074023.GC5148@thinkpad>
From:   Nitin Rawat <quic_nitirawa@quicinc.com>
In-Reply-To: <20230828074023.GC5148@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: E4zcC-Heco_OSnUemXojZuVqh9JKZn1r
X-Proofpoint-GUID: E4zcC-Heco_OSnUemXojZuVqh9JKZn1r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-30_14,2023-08-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 suspectscore=0 priorityscore=1501 malwarescore=0 phishscore=0
 clxscore=1015 adultscore=0 lowpriorityscore=0 mlxlogscore=999 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308300162
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/28/2023 1:10 PM, Manivannan Sadhasivam wrote:
> On Wed, Aug 23, 2023 at 09:14:09PM +0530, Nitin Rawat wrote:
>> For Qualcomm UFS controller V4.0 and above PA_VS_CORE_CLK_40NS_CYCLES
>> attribute needs to be programmed with frequency of unipro core clk.
>> Hence Configure PA_VS_CORE_CLK_40NS_CYCLES attribute for Unipro core clk.
>>
> 
> Same comment applies as patch 1.
> 
> - Mani

Sure...Will take care of this in next patchset. Thanks

-Nitin


> 
>> Co-developed-by: Naveen Kumar Goud Arepalli <quic_narepall@quicinc.com>
>> Signed-off-by: Naveen Kumar Goud Arepalli <quic_narepall@quicinc.com>
>> Signed-off-by: Nitin Rawat <quic_nitirawa@quicinc.com>
>> ---
>>   drivers/ufs/host/ufs-qcom.c | 45 ++++++++++++++++++++++++++++---------
>>   drivers/ufs/host/ufs-qcom.h |  2 ++
>>   2 files changed, 37 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
>> index 1108b0cd43b3..abc0e7f7d1b0 100644
>> --- a/drivers/ufs/host/ufs-qcom.c
>> +++ b/drivers/ufs/host/ufs-qcom.c
>> @@ -93,8 +93,9 @@ static const struct __ufs_qcom_bw_table {
>>   static struct ufs_qcom_host *ufs_qcom_hosts[MAX_UFS_QCOM_HOSTS];
>>
>>   static void ufs_qcom_get_default_testbus_cfg(struct ufs_qcom_host *host);
>> -static int ufs_qcom_set_dme_vs_core_clk_ctrl_clear_div(struct ufs_hba *hba,
>> -						       u32 clk_cycles);
>> +static int ufs_qcom_set_core_clk_ctrl(struct ufs_hba *hba,
>> +					u32 clk_cycles,
>> +					u32 clk_40ns_cycles);
>>
>>   static struct ufs_qcom_host *rcdev_to_ufs_host(struct reset_controller_dev *rcd)
>>   {
>> @@ -690,8 +691,7 @@ static int ufs_qcom_link_startup_notify(struct ufs_hba *hba,
>>   			 * set unipro core clock cycles to 150 & clear clock
>>   			 * divider
>>   			 */
>> -			err = ufs_qcom_set_dme_vs_core_clk_ctrl_clear_div(hba,
>> -									  150);
>> +			err = ufs_qcom_set_core_clk_ctrl(hba, 150, 6);
>>
>>   		/*
>>   		 * Some UFS devices (and may be host) have issues if LCC is
>> @@ -1296,12 +1296,13 @@ static void ufs_qcom_exit(struct ufs_hba *hba)
>>   	phy_exit(host->generic_phy);
>>   }
>>
>> -static int ufs_qcom_set_dme_vs_core_clk_ctrl_clear_div(struct ufs_hba *hba,
>> -						       u32 clk_1us_cycles)
>> +static int ufs_qcom_set_core_clk_ctrl(struct ufs_hba *hba,
>> +					u32 clk_1us_cycles,
>> +					u32 clk_40ns_cycles)
>>   {
>>   	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
>>   	u32 mask = DME_VS_CORE_CLK_CTRL_MAX_CORE_CLK_1US_CYCLES_MASK;
>> -	u32 core_clk_ctrl_reg;
>> +	u32 core_clk_ctrl_reg, reg;
>>   	u32 offset = 0;
>>   	int err;
>>
>> @@ -1326,9 +1327,33 @@ static int ufs_qcom_set_dme_vs_core_clk_ctrl_clear_div(struct ufs_hba *hba,
>>   	/* Clear CORE_CLK_DIV_EN */
>>   	core_clk_ctrl_reg &= ~DME_VS_CORE_CLK_CTRL_CORE_CLK_DIV_EN_BIT;
>>
>> -	return ufshcd_dme_set(hba,
>> +	err = ufshcd_dme_set(hba,
>>   			    UIC_ARG_MIB(DME_VS_CORE_CLK_CTRL),
>>   			    core_clk_ctrl_reg);
>> +	/*
>> +	 * UFS host controller V4.0.0 onwards needs to program
>> +	 * PA_VS_CORE_CLK_40NS_CYCLES attribute per programmed
>> +	 * frequency of unipro core clk of UFS host controller.
>> +	 */
>> +	if (!err && (host->hw_ver.major >= 4)) {
>> +		if (clk_40ns_cycles > PA_VS_CORE_CLK_40NS_CYCLES_MASK)
>> +			return -EINVAL;
>> +
>> +		err = ufshcd_dme_get(hba,
>> +				     UIC_ARG_MIB(PA_VS_CORE_CLK_40NS_CYCLES),
>> +				     &reg);
>> +		if (err)
>> +			return err;
>> +
>> +		reg &= ~PA_VS_CORE_CLK_40NS_CYCLES_MASK;
>> +		reg |= clk_40ns_cycles;
>> +
>> +		err = ufshcd_dme_set(hba,
>> +				     UIC_ARG_MIB(PA_VS_CORE_CLK_40NS_CYCLES),
>> +				     reg);
>> +	}
>> +
>> +	return err;
>>   }
>>
>>   static int ufs_qcom_clk_scale_up_pre_change(struct ufs_hba *hba)
>> @@ -1345,7 +1370,7 @@ static int ufs_qcom_clk_scale_up_post_change(struct ufs_hba *hba)
>>   		return 0;
>>
>>   	/* set unipro core clock cycles to 150 and clear clock divider */
>> -	return ufs_qcom_set_dme_vs_core_clk_ctrl_clear_div(hba, 150);
>> +	return ufs_qcom_set_core_clk_ctrl(hba, 150, 6);
>>   }
>>
>>   static int ufs_qcom_clk_scale_down_pre_change(struct ufs_hba *hba)
>> @@ -1381,7 +1406,7 @@ static int ufs_qcom_clk_scale_down_post_change(struct ufs_hba *hba)
>>   		return 0;
>>
>>   	/* set unipro core clock cycles to 75 and clear clock divider */
>> -	return ufs_qcom_set_dme_vs_core_clk_ctrl_clear_div(hba, 75);
>> +	return ufs_qcom_set_core_clk_ctrl(hba, 75, 3);
>>   }
>>
>>   static int ufs_qcom_clk_scale_notify(struct ufs_hba *hba,
>> diff --git a/drivers/ufs/host/ufs-qcom.h b/drivers/ufs/host/ufs-qcom.h
>> index a829296e11bb..325f08aca260 100644
>> --- a/drivers/ufs/host/ufs-qcom.h
>> +++ b/drivers/ufs/host/ufs-qcom.h
>> @@ -133,6 +133,8 @@ enum {
>>   #define MAX_CORE_CLK_1US_CYCLES_OFFSET_V4	0x10
>>   #define DME_VS_CORE_CLK_CTRL_CORE_CLK_DIV_EN_BIT		BIT(8)
>>   #define DME_VS_CORE_CLK_CTRL_MAX_CORE_CLK_1US_CYCLES_MASK	0xFF
>> +#define PA_VS_CORE_CLK_40NS_CYCLES	0x9007
>> +#define PA_VS_CORE_CLK_40NS_CYCLES_MASK	0x3F
>>
>>   static inline void
>>   ufs_qcom_get_controller_revision(struct ufs_hba *hba,
>> --
>> 2.17.1
>>
> 
