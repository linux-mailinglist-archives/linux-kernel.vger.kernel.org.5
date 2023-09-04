Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB5DE7919BA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 16:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244569AbjIDOho (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 10:37:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237806AbjIDOhm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 10:37:42 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01A3710F8;
        Mon,  4 Sep 2023 07:37:36 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 384CowhB022950;
        Mon, 4 Sep 2023 14:36:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=A8UAy67SMbov3lgULuyoQ7dsNYyv0heTFOxaSMtUW3o=;
 b=UVtLkAM7SGr7Q9n1/1Ys0He+xkmRx9sz7LJOsC9tnCIC+jAsg1OYqok9ZwX1CFe2II3u
 5OSRRns8HiMyKcCHZ+sHUwenw/B3iPNnljI8q97o4U+0oSuIyVEJnqz5yA1ClGJAta73
 TrdNHWX+0NMoAoruzOoDOu4owI+5QG4TDdd0JvRxkRpNcOFTxOAFsQtAMaEG3T/cIH6M
 zffkR7C6T5L9kGBJAxiOuFNfC89pmq5k1MH5RpPF90JK928eAhyiRMH6tnec4TP/3Uec
 9Nv+5IdwSdICkrSZvRvQPV03ZvRMRxUrsVGLFmJqVx6I/Kc71llFjKiSdB8H4CydLOR3 2Q== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3suxbfuwnb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Sep 2023 14:36:06 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 384Ea5wk015540
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 4 Sep 2023 14:36:05 GMT
Received: from [10.218.45.181] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Mon, 4 Sep
 2023 07:36:00 -0700
Message-ID: <ccff18d5-38a5-919b-461b-941e9a6f2817@quicinc.com>
Date:   Mon, 4 Sep 2023 20:05:57 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH V6 2/6] scsi: ufs: qcom: Configure
 PA_VS_CORE_CLK_40NS_CYCLES
Content-Language: en-US
To:     Bjorn Andersson <quic_bjorande@quicinc.com>
CC:     <mani@kernel.org>, <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <quic_cang@quicinc.com>,
        <quic_nguyenb@quicinc.com>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        "Naveen Kumar Goud Arepalli" <quic_narepall@quicinc.com>
References: <20230901114336.31339-1-quic_nitirawa@quicinc.com>
 <20230901114336.31339-3-quic_nitirawa@quicinc.com>
 <20230901153034.GS818859@hu-bjorande-lv.qualcomm.com>
From:   Nitin Rawat <quic_nitirawa@quicinc.com>
In-Reply-To: <20230901153034.GS818859@hu-bjorande-lv.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: gxprwcUt_nVdaQAa0S6mCXOgkVuVxUot
X-Proofpoint-ORIG-GUID: gxprwcUt_nVdaQAa0S6mCXOgkVuVxUot
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-04_07,2023-08-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 impostorscore=0 clxscore=1015
 suspectscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0 phishscore=0
 spamscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309040130
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/1/2023 9:00 PM, Bjorn Andersson wrote:
> On Fri, Sep 01, 2023 at 05:13:32PM +0530, Nitin Rawat wrote:
>> Configure PA_VS_CORE_CLK_40NS_CYCLES with frequency of unipro core clk
>> for Qualcomm UFS controller V4.0 and onwards to align with the hardware
>> specification.
>>
>> Co-developed-by: Naveen Kumar Goud Arepalli <quic_narepall@quicinc.com>
>> Signed-off-by: Naveen Kumar Goud Arepalli <quic_narepall@quicinc.com>
>> Signed-off-by: Nitin Rawat <quic_nitirawa@quicinc.com>
>> ---
>>   drivers/ufs/host/ufs-qcom.c | 47 ++++++++++++++++++++++++++++---------
>>   drivers/ufs/host/ufs-qcom.h |  2 ++
>>   2 files changed, 38 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
>> index fe36003faaa8..018e391c276e 100644
>> --- a/drivers/ufs/host/ufs-qcom.c
>> +++ b/drivers/ufs/host/ufs-qcom.c
>> @@ -93,8 +93,9 @@ static const struct __ufs_qcom_bw_table {
>>   static struct ufs_qcom_host *ufs_qcom_hosts[MAX_UFS_QCOM_HOSTS];
>>
>>   static void ufs_qcom_get_default_testbus_cfg(struct ufs_qcom_host *host);
>> -static int ufs_qcom_set_dme_vs_core_clk_ctrl_clear_div(struct ufs_hba *hba,
>> -						       u32 clk_cycles);
>> +static int ufs_qcom_set_core_clk_ctrl(struct ufs_hba *hba,
>> +						       u32 clk_cycles,
>> +						       u32 clk_40ns_cycles);
>>
>>   static struct ufs_qcom_host *rcdev_to_ufs_host(struct reset_controller_dev *rcd)
>>   {
>> @@ -690,8 +691,8 @@ static int ufs_qcom_link_startup_notify(struct ufs_hba *hba,
>>   			 * set unipro core clock cycles to 150 & clear clock
>>   			 * divider
>>   			 */
>> -			err = ufs_qcom_set_dme_vs_core_clk_ctrl_clear_div(hba,
>> -									  150);
>> +			err = ufs_qcom_set_core_clk_ctrl(hba,
>> +									  150, 6);
> 
> There's no reason to maintain the line wrap here, and the new
> indentation looks wrong.

   Sure..will remove it next patchset.

> 
>>
>>   		/*
>>   		 * Some UFS devices (and may be host) have issues if LCC is
>> @@ -1295,12 +1296,12 @@ static void ufs_qcom_exit(struct ufs_hba *hba)
>>   	phy_power_off(host->generic_phy);
>>   	phy_exit(host->generic_phy);
>>   }
>> -
>> -static int ufs_qcom_set_dme_vs_core_clk_ctrl_clear_div(struct ufs_hba *hba,
>> -						       u32 cycles_in_1us)
>> +static int ufs_qcom_set_core_clk_ctrl(struct ufs_hba *hba,
>> +					u32 cycles_in_1us,
> 
> Following my comment on this rename in the last commit, here you do
> change the prototype, so here you need the rename to clarify the intent,
> so make it here instead.


We will change the order of patch so that we need change the prototype 
in 1 place.

-Nitin

> 
>> +					u32 cycles_in_40ns)
>>   {
>>   	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
>> -	u32 core_clk_ctrl_reg;
>> +	u32 core_clk_ctrl_reg, reg;
> 
> Please keep one variable declaration per line, in particular when using
> names like "core_clk_ctrl_reg" which looks much more like a type than a
> variable name...
> 
> I would have preferred "reg" instead of core_clk_ctrl_reg" and you could
> have used that same variable for both sections.
> 
>>   	int ret;
>>
>>   	ret = ufshcd_dme_get(hba,
>> @@ -1325,9 +1326,33 @@ static int ufs_qcom_set_dme_vs_core_clk_ctrl_clear_div(struct ufs_hba *hba,
>>   	/* Clear CORE_CLK_DIV_EN */
>>   	core_clk_ctrl_reg &= ~DME_VS_CORE_CLK_CTRL_CORE_CLK_DIV_EN_BIT;
>>
>> -	return ufshcd_dme_set(hba,
>> +	err = ufshcd_dme_set(hba,
> 
> I might be confused, but didn't you remove "err" in patch 1? Does this
> patch compile?
> 
>>   			    UIC_ARG_MIB(DME_VS_CORE_CLK_CTRL),
>>   			    core_clk_ctrl_reg);
>> +	/*
>> +	 * UFS host controller V4.0.0 onwards needs to program
>> +	 * PA_VS_CORE_CLK_40NS_CYCLES attribute per programmed
>> +	 * frequency of unipro core clk of UFS host controller.
>> +	 */
>> +	if (!err && (host->hw_ver.major >= 4)) {
> 
> Rather than if (previous-block-didn't-fail), add an explicit return if
> err is unfavourable. That will make it more obvious that this section
> relates to version >= 4 and nothing else.

Sure..Will take care in next patchset

> 
> 
> That said, you now have one function:
> 
> core_clk_ctrl(int a, int b)
> {
> 	do stuff based on a;
> 
> 	if (version > 4)
> 		do stuff based on b;
> }
> 
> It's pretty much one function for cycles_in_1us, with a separate
> function for cycles_in_40us bolted on at the end. How about just
> splitting it in two functions instead, and provide a small wrapper that
> calls one or both functions?

Sure...Will move cycles_in_40us to different function.



> 
>> +		if (cycles_in_40ns > PA_VS_CORE_CLK_40NS_CYCLES_MASK)
>> +			return -EINVAL;
>> +
>> +		err = ufshcd_dme_get(hba,
>> +				     UIC_ARG_MIB(PA_VS_CORE_CLK_40NS_CYCLES),
>> +				     &reg);
> 
> Leaving this line unwrapped seems to end up at 89 characters wide.
> Perfectly reasonable to do, in the name of readability.
> 
  Sure..Will address this in next patchset.


>> +		if (err)
>> +			return err;
>> +
>> +		reg &= ~PA_VS_CORE_CLK_40NS_CYCLES_MASK;
>> +		reg |= cycles_in_40ns;
>> +
>> +		err = ufshcd_dme_set(hba,
>> +				     UIC_ARG_MIB(PA_VS_CORE_CLK_40NS_CYCLES),
>> +				     reg);
> 
> Same as above.
Sure..Will address this in next patchset.

> 
> Regards,
> Bjorn

Thanks,
Nitin
