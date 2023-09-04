Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A7167919D7
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 16:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345104AbjIDOmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 10:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343739AbjIDOmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 10:42:13 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 811ACCFD;
        Mon,  4 Sep 2023 07:42:06 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 384EQ2kP031943;
        Mon, 4 Sep 2023 14:41:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=dDLWGOpZ/H5HCAoc7g1SR9Yfuhf0pgQzrnTk37mU3oU=;
 b=hY1NCXKoIrPkYyII3qqwKmRNWUw4Sp7SdzNWSn7OwWQk2E9IUxb1SE/TFD9BIf6M9dKo
 5FgepCNs75cYUvoMs/vzKrOBPRfhVlrSxrBJuEePN5AdeXCneCWn6ZW7Bu99BuZWiTbu
 uaYyQ4QnU65FNqxl7jTypYjWRRHnS0/h0nYpsTKyZs6YgfcmsbbbOD9fpBAInVREzIEB
 nfP8PLipTJNIR/rvNbG5+Ha2APYsSSuGXHZYWHyo4MAAzm9e80pYlNV2nltCwRAJCNys
 RzAnQZd4p0iGOh2WbApfYtb61nqEsgvFhdIW02bwLh69RH9MooWhSCvxMz0CwqMZ59Yr hw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3suxbfux3g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Sep 2023 14:41:56 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 384EftiE028025
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 4 Sep 2023 14:41:55 GMT
Received: from [10.218.45.181] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Mon, 4 Sep
 2023 07:41:51 -0700
Message-ID: <c2c2a2d7-9ff4-cb97-f0e4-f46695e213cb@quicinc.com>
Date:   Mon, 4 Sep 2023 20:11:47 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH V6 3/6] scsi: ufs: qcom: Add multiple frequency support
 for unipro clk attributes
Content-Language: en-US
To:     Bjorn Andersson <quic_bjorande@quicinc.com>
CC:     <mani@kernel.org>, <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <quic_cang@quicinc.com>,
        <quic_nguyenb@quicinc.com>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        "Naveen Kumar Goud Arepalli" <quic_narepall@quicinc.com>
References: <20230901114336.31339-1-quic_nitirawa@quicinc.com>
 <20230901114336.31339-4-quic_nitirawa@quicinc.com>
 <20230901154029.GT818859@hu-bjorande-lv.qualcomm.com>
From:   Nitin Rawat <quic_nitirawa@quicinc.com>
In-Reply-To: <20230901154029.GT818859@hu-bjorande-lv.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: w3kFggwHImeUvNbOrwwxpmcakTy-aKBT
X-Proofpoint-ORIG-GUID: w3kFggwHImeUvNbOrwwxpmcakTy-aKBT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-04_07,2023-08-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 impostorscore=0 clxscore=1015
 suspectscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0 phishscore=0
 spamscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309040131
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/1/2023 9:10 PM, Bjorn Andersson wrote:
> On Fri, Sep 01, 2023 at 05:13:33PM +0530, Nitin Rawat wrote:
>> Add Support to configure CORE_CLK_1US_CYCLES, PA_VS_CORE_CLK_40NS_CYCLES
>> for multiple unipro clock frequencies. Currently this is handled only for
>> only 150Mhz and 75MHz.
>>
>> Since different qualcomm targets support different unipro frequency, add
>> support to handle all other frequencies like 403MHz, 300MHz, 202MHz,
>> 150 MHz, 75Mhz, 37.5 MHz.
>>
> 
> Please flip your commit message around, start with the problem
> description (the second paragraph), then the description of what you're
> changing.

Sure will address this in next patchset.

> 
>> Co-developed-by: Naveen Kumar Goud Arepalli <quic_narepall@quicinc.com>
>> Signed-off-by: Naveen Kumar Goud Arepalli <quic_narepall@quicinc.com>
>> Signed-off-by: Nitin Rawat <quic_nitirawa@quicinc.com>
>> ---
>>   drivers/ufs/host/ufs-qcom.c | 96 ++++++++++++++++++++++++++++---------
>>   drivers/ufs/host/ufs-qcom.h | 10 ++++
>>   2 files changed, 84 insertions(+), 22 deletions(-)
>>
>> diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
>> index 018e391c276e..e3648e936498 100644
>> --- a/drivers/ufs/host/ufs-qcom.c
>> +++ b/drivers/ufs/host/ufs-qcom.c
>> @@ -94,8 +94,7 @@ static struct ufs_qcom_host *ufs_qcom_hosts[MAX_UFS_QCOM_HOSTS];
>>
>>   static void ufs_qcom_get_default_testbus_cfg(struct ufs_qcom_host *host);
>>   static int ufs_qcom_set_core_clk_ctrl(struct ufs_hba *hba,
>> -						       u32 clk_cycles,
>> -						       u32 clk_40ns_cycles);
>> +					bool is_max_freq);
> 
> Odd indentation here. That said, I doubt that you need the line wrap
> now.

Sure will address this in next patchset.

> 
>>
>>   static struct ufs_qcom_host *rcdev_to_ufs_host(struct reset_controller_dev *rcd)
>>   {
>> @@ -686,13 +685,14 @@ static int ufs_qcom_link_startup_notify(struct ufs_hba *hba,
>>   			return -EINVAL;
>>   		}
>>
>> -		if (ufs_qcom_cap_qunipro(host))
>> -			/*
>> -			 * set unipro core clock cycles to 150 & clear clock
>> -			 * divider
>> -			 */
>> -			err = ufs_qcom_set_core_clk_ctrl(hba,
>> -									  150, 6);
>> +		if (ufs_qcom_cap_qunipro(host)) {
>> +			err = ufs_qcom_set_core_clk_ctrl(hba, true);
>> +			if (err) {
>> +				dev_err(hba->dev,
>> +				"%s cfg core clk ctrl failed\n",
>> +				__func__);
> 
> Please don't build error messages using __func__, describe the actual
> error, in English.

Sure will address this in next patchset.

> 
>> +			}
>> +		}
>>
>>   		/*
>>   		 * Some UFS devices (and may be host) have issues if LCC is
>> @@ -1297,13 +1297,67 @@ static void ufs_qcom_exit(struct ufs_hba *hba)
>>   	phy_exit(host->generic_phy);
>>   }
>>   static int ufs_qcom_set_core_clk_ctrl(struct ufs_hba *hba,
>> -					u32 cycles_in_1us,
>> -					u32 cycles_in_40ns)
>> +					bool is_max_freq)
> 
> You changed this function prototype in both patch 1 and patch 2, and now
> you're changing it again. What if you make this transition in patch 1,
> then you only need to change the prototype once.

Sure we will change the order of patch so that prototype will change in 
1 place.

> 
>>   {
>>   	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
>> +	struct list_head *head = &hba->clk_list_head;
>>   	u32 core_clk_ctrl_reg, reg;
>> +	struct ufs_clk_info *clki;
>> +	u32 cycles_in_1us, cycles_in_40ns;
>>   	int ret;
>>
>> +	list_for_each_entry(clki, head, list) {
>> +		if (!IS_ERR_OR_NULL(clki->clk) &&
>> +			!strcmp(clki->name, "core_clk_unipro")) {
>> +			if (is_max_freq)
>> +				cycles_in_1us = clki->max_freq;
>> +			else
>> +				cycles_in_1us = clk_get_rate(clki->clk);
>> +			break;
>> +		}
>> +	}
>> +
>> +	if ((cycles_in_1us % (1000 * 1000)) != 0)
>> +		cycles_in_1us = cycles_in_1us/(1000 * 1000) + 1;
>> +	else
>> +		cycles_in_1us = cycles_in_1us/(1000 * 1000);
>> +
> 
> Iiuc, the following 34 lines only apply to hw_ver >= 4.
Sure...Will address this in next patchset.

> 
>> +	/*
>> +	 * Generic formulae for cycles_in_40ns = (freq_unipro/25) is not
>> +	 * applicable for all frequencies. For ex: ceil(37.5 MHz/25) will
>> +	 * be 2 and ceil(403 MHZ/25) will be 17 whereas Hardware
>> +	 * specification expect to be 16. Hence use exact hardware spec
>> +	 * mandated value for cycles_in_40ns instead of calculating using
>> +	 * generic formulae.
>> +	 */
>> +	switch (cycles_in_1us) {
>> +	case UNIPRO_CORE_CLK_FREQ_403_MHZ:
>> +		cycles_in_40ns = 16;
>> +		break;
>> +	case UNIPRO_CORE_CLK_FREQ_300_MHZ:
>> +		cycles_in_40ns = 12;
>> +		break;
>> +	case UNIPRO_CORE_CLK_FREQ_201_5_MHZ:
>> +		cycles_in_40ns = 8;
>> +		break;
>> +	case UNIPRO_CORE_CLK_FREQ_150_MHZ:
>> +		cycles_in_40ns = 6;
>> +		break;
>> +	case UNIPRO_CORE_CLK_FREQ_100_MHZ:
>> +		cycles_in_40ns = 4;
>> +		break;
>> +	case  UNIPRO_CORE_CLK_FREQ_75_MHZ:
>> +		cycles_in_40ns = 3;
>> +		break;
>> +	case UNIPRO_CORE_CLK_FREQ_37_5_MHZ:
>> +		cycles_in_40ns = 2;
>> +		break;
>> +	default:
>> +		ret = -EINVAL;
> 
- In next patchset we are returning Error from default case.

> 5 lines below, you're overwriting this value and moving on as if nothing
> happened. Doesn't your compiler complain that you then will use
> cycles_in_40ns without first initializing it in this case?
> 
>> +		dev_err(hba->dev, "UNIPRO clk freq %u MHz not supported\n",
>> +					cycles_in_1us);
>> +	}
>> +
>>   	ret = ufshcd_dme_get(hba,
>>   			    UIC_ARG_MIB(DME_VS_CORE_CLK_CTRL),
>>   			    &core_clk_ctrl_reg);
>> @@ -1326,7 +1380,7 @@ static int ufs_qcom_set_core_clk_ctrl(struct ufs_hba *hba,
>>   	/* Clear CORE_CLK_DIV_EN */
>>   	core_clk_ctrl_reg &= ~DME_VS_CORE_CLK_CTRL_CORE_CLK_DIV_EN_BIT;
> 
> The following 6 changes just corrects the compilation error you
> shouldn't have introduced in the previous patch.
> 
>>
>> -	err = ufshcd_dme_set(hba,
>> +	ret = ufshcd_dme_set(hba,
>>   			    UIC_ARG_MIB(DME_VS_CORE_CLK_CTRL),
>>   			    core_clk_ctrl_reg);
>>   	/*
>> @@ -1334,25 +1388,25 @@ static int ufs_qcom_set_core_clk_ctrl(struct ufs_hba *hba,
>>   	 * PA_VS_CORE_CLK_40NS_CYCLES attribute per programmed
>>   	 * frequency of unipro core clk of UFS host controller.
>>   	 */
>> -	if (!err && (host->hw_ver.major >= 4)) {
>> +	if (!ret && (host->hw_ver.major >= 4)) {
>>   		if (cycles_in_40ns > PA_VS_CORE_CLK_40NS_CYCLES_MASK)
>>   			return -EINVAL;
>>
>> -		err = ufshcd_dme_get(hba,
>> +		ret = ufshcd_dme_get(hba,
>>   				     UIC_ARG_MIB(PA_VS_CORE_CLK_40NS_CYCLES),
>>   				     &reg);
>> -		if (err)
>> -			return err;
>> +		if (ret)
>> +			return ret;
>>
>>   		reg &= ~PA_VS_CORE_CLK_40NS_CYCLES_MASK;
>>   		reg |= cycles_in_40ns;
>>
>> -		err = ufshcd_dme_set(hba,
>> +		ret = ufshcd_dme_set(hba,
>>   				     UIC_ARG_MIB(PA_VS_CORE_CLK_40NS_CYCLES),
>>   				     reg);
>>   	}
>>
>> -	return err;
>> +	return ret;
>>   }
>>
>>   static int ufs_qcom_clk_scale_up_pre_change(struct ufs_hba *hba)
>> @@ -1368,8 +1422,7 @@ static int ufs_qcom_clk_scale_up_post_change(struct ufs_hba *hba)
>>   	if (!ufs_qcom_cap_qunipro(host))
>>   		return 0;
>>
>> -	/* set unipro core clock cycles to 150 and clear clock divider */
>> -	return ufs_qcom_set_core_clk_ctrl(hba, 150, 6);
>> +	return ufs_qcom_set_core_clk_ctrl(hba, true);
>>   }
>>
>>   static int ufs_qcom_clk_scale_down_pre_change(struct ufs_hba *hba)
>> @@ -1404,8 +1457,7 @@ static int ufs_qcom_clk_scale_down_post_change(struct ufs_hba *hba)
>>   	if (!ufs_qcom_cap_qunipro(host))
>>   		return 0;
>>
>> -	/* set unipro core clock cycles to 75 and clear clock divider */
>> -	return ufs_qcom_set_core_clk_ctrl(hba, 75, 3);
>> +	return ufs_qcom_set_core_clk_ctrl(hba, false);
>>   }
>>
>>   static int ufs_qcom_clk_scale_notify(struct ufs_hba *hba,
>> diff --git a/drivers/ufs/host/ufs-qcom.h b/drivers/ufs/host/ufs-qcom.h
>> index d81bf1a1b77a..bc176ef58e3e 100644
>> --- a/drivers/ufs/host/ufs-qcom.h
>> +++ b/drivers/ufs/host/ufs-qcom.h
>> @@ -9,6 +9,7 @@
>>   #include <linux/reset.h>
>>   #include <soc/qcom/ice.h>
>>   #include <ufs/ufshcd.h>
>> +#include <linux/math.h>
> 
> Why is math.h needed in this header file now?
Removed it.
> 
> Regards,
> Bjorn
> 
>>
>>   #define MAX_UFS_QCOM_HOSTS	1
>>   #define MAX_U32                 (~(u32)0)
>> @@ -79,6 +80,15 @@ enum {
>>   	UFS_MEM_CQIS_VS		= 0x8,
>>   };
>>
>> +/* QCOM UFS host controller core clk frequencies */
>> +#define UNIPRO_CORE_CLK_FREQ_37_5_MHZ		38
>> +#define UNIPRO_CORE_CLK_FREQ_75_MHZ		75
>> +#define UNIPRO_CORE_CLK_FREQ_100_MHZ		100
>> +#define UNIPRO_CORE_CLK_FREQ_150_MHZ		150
>> +#define UNIPRO_CORE_CLK_FREQ_300_MHZ		300
>> +#define UNIPRO_CORE_CLK_FREQ_201_5_MHZ		202
>> +#define UNIPRO_CORE_CLK_FREQ_403_MHZ		403
>> +
>>   #define UFS_CNTLR_2_x_x_VEN_REGS_OFFSET(x)	(0x000 + x)
>>   #define UFS_CNTLR_3_x_x_VEN_REGS_OFFSET(x)	(0x400 + x)
>>
>> --
>> 2.17.1
>>
