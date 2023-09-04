Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1ACF7919B5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 16:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240162AbjIDOeM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 10:34:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbjIDOeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 10:34:10 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D75A5B6;
        Mon,  4 Sep 2023 07:34:06 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 384DlrNu025158;
        Mon, 4 Sep 2023 14:31:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Si5Vs0wbNVaSVySCyg2W45YZmGC0h6D61AL5KZFZOC0=;
 b=mceXa9MmP5nTuRI6TD0CWX1UziMliQGMAwzhby+Ym/1qGgmXCAk9rXWEXaMM7W9M0Oh7
 /1tquLyM3Nv9zRotxLd7N+CfFDqBUMB6drQ+e320j6wwxd5ZR5p/IakLiYie8Wv5OfHO
 udDd3q8gXNK1Ic3DzF+kMgRkwucxW1NU2LM6SOvAgfSGFrbPYX0oMDpg5Ila1tBf0FNi
 kSL314KQ2uejo14Xwtg4lYxbHp6RkiHkaZZs/cyOmWPdY8v/rfPbuzq5WC+nW2txwcpW
 kkOU0KmlOYcHEaaJodpsXiyzlt/RJMQDsvdhD5kYjawmK/I5RRyUZxM3tgLLOwKUc3A7 oA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sutrnm612-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Sep 2023 14:31:32 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 384EVVnf014080
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 4 Sep 2023 14:31:31 GMT
Received: from [10.218.45.181] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Mon, 4 Sep
 2023 07:31:27 -0700
Message-ID: <9a69fbb0-8a0b-ed74-1ee0-49272d180b9d@quicinc.com>
Date:   Mon, 4 Sep 2023 20:01:24 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH V6 1/6] scsi: ufs: qcom: Align mask for
 core_clk_1us_cycles
To:     Bjorn Andersson <quic_bjorande@quicinc.com>
CC:     <mani@kernel.org>, <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <quic_cang@quicinc.com>,
        <quic_nguyenb@quicinc.com>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        "Naveen Kumar Goud Arepalli" <quic_narepall@quicinc.com>
References: <20230901114336.31339-1-quic_nitirawa@quicinc.com>
 <20230901114336.31339-2-quic_nitirawa@quicinc.com>
 <20230901151713.GQ818859@hu-bjorande-lv.qualcomm.com>
Content-Language: en-US
From:   Nitin Rawat <quic_nitirawa@quicinc.com>
In-Reply-To: <20230901151713.GQ818859@hu-bjorande-lv.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: jU2zy6yJx9hGlXugnFMT3PZUNGyvQ_Dv
X-Proofpoint-ORIG-GUID: jU2zy6yJx9hGlXugnFMT3PZUNGyvQ_Dv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-04_07,2023-08-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 bulkscore=0 mlxlogscore=999
 priorityscore=1501 suspectscore=0 mlxscore=0 spamscore=0 phishscore=0
 clxscore=1015 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2308100000 definitions=main-2309040130
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/1/2023 8:47 PM, Bjorn Andersson wrote:
> On Fri, Sep 01, 2023 at 05:13:31PM +0530, Nitin Rawat wrote:
>> Align core_clk_1us_cycles mask for Qualcomm UFS Controller V4.0.0
> 
> "Align clk mask for ... as per hardware specification."? Are you trying
> to say "The DME_VS_CORE_CLK_CTRL register has changed in v4 of the
> Qualcomm UFS controller, introduce support for the new register layout"?
> 
> You're not aligning the code to match the hardware specification, you're
> fixing the code because the register has changed.
> 
>> onwards as per Hardware Specification.
>>

Hi Bjorn,

Yes, will update the commit text in next patchset



>> Co-developed-by: Naveen Kumar Goud Arepalli <quic_narepall@quicinc.com>
>> Signed-off-by: Naveen Kumar Goud Arepalli <quic_narepall@quicinc.com>
>> Signed-off-by: Nitin Rawat <quic_nitirawa@quicinc.com>
>> ---
>>   drivers/ufs/host/ufs-qcom.c | 28 ++++++++++++++++++----------
>>   drivers/ufs/host/ufs-qcom.h |  5 +++--
>>   2 files changed, 21 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
>> index f88febb23123..fe36003faaa8 100644
>> --- a/drivers/ufs/host/ufs-qcom.c
>> +++ b/drivers/ufs/host/ufs-qcom.c
>> @@ -1297,22 +1297,30 @@ static void ufs_qcom_exit(struct ufs_hba *hba)
>>   }
>>
>>   static int ufs_qcom_set_dme_vs_core_clk_ctrl_clear_div(struct ufs_hba *hba,
>> -						       u32 clk_cycles)
>> +						       u32 cycles_in_1us)
> 
> This is a nice clarification, but changing the function prototype gives
> a sense that you changed the parameters - and that's not the case.
> 
> So if you drop this rename, you make the purpose of the patch clearer.
> 
>>   {
>> -	int err;
>> +	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
>>   	u32 core_clk_ctrl_reg;
>> +	int ret;
> 
> Renaming err to ret is unrelated and only unnecessary complexity to the
> patch.
> 

ok..Would take care of this comment in next patchset.


>>
>> -	if (clk_cycles > DME_VS_CORE_CLK_CTRL_MAX_CORE_CLK_1US_CYCLES_MASK)
>> -		return -EINVAL;
>> -
>> -	err = ufshcd_dme_get(hba,
>> +	ret = ufshcd_dme_get(hba,
>>   			    UIC_ARG_MIB(DME_VS_CORE_CLK_CTRL),
>>   			    &core_clk_ctrl_reg);
>> -	if (err)
>> -		return err;
>> +	if (ret)
>> +		return ret;
>>
>> -	core_clk_ctrl_reg &= ~DME_VS_CORE_CLK_CTRL_MAX_CORE_CLK_1US_CYCLES_MASK;
>> -	core_clk_ctrl_reg |= clk_cycles;
>> +	/* Bit mask is different for UFS host controller V4.0.0 onwards */
>> +	if (host->hw_ver.major >= 4) {
>> +		if (!FIELD_FIT(CLK_1US_CYCLES_MASK_V4, cycles_in_1us))
>> +			return -ERANGE;
>> +		core_clk_ctrl_reg &= ~CLK_1US_CYCLES_MASK_V4;
>> +		core_clk_ctrl_reg |= FIELD_PREP(CLK_1US_CYCLES_MASK_V4, cycles_in_1us);
>> +	} else {
>> +		if (!FIELD_FIT(CLK_1US_CYCLES_MASK, cycles_in_1us))
>> +			return -ERANGE;
>> +		core_clk_ctrl_reg &= ~CLK_1US_CYCLES_MASK;
>> +		core_clk_ctrl_reg |= FIELD_PREP(CLK_1US_CYCLES_MASK, cycles_in_1us);
>> +	}
>>
>>   	/* Clear CORE_CLK_DIV_EN */
>>   	core_clk_ctrl_reg &= ~DME_VS_CORE_CLK_CTRL_CORE_CLK_DIV_EN_BIT;
>> diff --git a/drivers/ufs/host/ufs-qcom.h b/drivers/ufs/host/ufs-qcom.h
>> index d6f8e74bd538..8a9d3dbec297 100644
>> --- a/drivers/ufs/host/ufs-qcom.h
>> +++ b/drivers/ufs/host/ufs-qcom.h
>> @@ -129,8 +129,9 @@ enum {
>>   #define PA_VS_CONFIG_REG1	0x9000
>>   #define DME_VS_CORE_CLK_CTRL	0xD002
>>   /* bit and mask definitions for DME_VS_CORE_CLK_CTRL attribute */
>> -#define DME_VS_CORE_CLK_CTRL_CORE_CLK_DIV_EN_BIT		BIT(8)
>> -#define DME_VS_CORE_CLK_CTRL_MAX_CORE_CLK_1US_CYCLES_MASK	0xFF
>> +#define CLK_1US_CYCLES_MASK_V4				GENMASK(27, 16)
>> +#define CLK_1US_CYCLES_MASK				GENMASK(7, 0)
>> +#define DME_VS_CORE_CLK_CTRL_CORE_CLK_DIV_EN_BIT	BIT(8)
> 
> Hard to say without applying the patch, please double check that the
> values here have matching indentation level.
> 
> Thank you,
> Bjorn

-Yes I applied and confirmed it's proper.

Thanks,
Nitin


> 
>>
>>   static inline void
>>   ufs_qcom_get_controller_revision(struct ufs_hba *hba,
>> --
>> 2.17.1
>>
