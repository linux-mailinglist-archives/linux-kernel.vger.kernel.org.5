Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 946A47DCEB6
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 15:06:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233664AbjJaOGI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 10:06:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344503AbjJaNOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 09:14:36 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB4B4F4;
        Tue, 31 Oct 2023 06:14:30 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39VA9Qnh028229;
        Tue, 31 Oct 2023 13:10:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=QZDiUQ6Gd5tCZvX8du+TNXmzhX9TFsug2LQGOoCKTUs=;
 b=j7N9op6P/rBREnEuVkZb90tTrccWL+efPxZ49RcqzLe3Ntb2KpHrWSc5kqY3hmdp/AcV
 zgOqNctzsq8PNpSFvYZoV+YlinZs7lwLSgBmJuZ2Ra0Xj4Gs7wdEf6UpBJylrkEJ01iN
 qQoQamlYXVQNUY5xtVYQl/YwHgT3t1pWT9MVayvDv66zx+gQk8D0hJLMsTeOAKl+GM6K
 3C/nUHsqMUG3ySnzuDFYqRpdEI43Wyb0jc7M24kI1F2IiI3cxdED4h3Dj4A8rex2nwu2
 ur/vhkr+4FaJeglmNiJC9gxd5o1qkCszx9WdMZy3wfZzWu1+ynpHF1SdlkigKNsWrqkD 2A== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u2mcyhwun-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Oct 2023 13:10:07 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39VDA6j4013727
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Oct 2023 13:10:06 GMT
Received: from [10.253.76.255] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Tue, 31 Oct
 2023 06:10:02 -0700
Message-ID: <09c030d5-05b7-5f92-94e3-5ea5afbbed40@quicinc.com>
Date:   Tue, 31 Oct 2023 21:09:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 1/6] scsi: ufs: ufs-qcom: Setup host power mode during
 init
Content-Language: en-US
To:     Manivannan Sadhasivam <mani@kernel.org>
CC:     <quic_nguyenb@quicinc.com>, <quic_nitirawa@quicinc.com>,
        <martin.petersen@oracle.com>, <linux-scsi@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "open list:UNIVERSAL FLASH STORAGE HOST CONTROLLER DRIVER..." 
        <linux-arm-msm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <1694411968-14413-1-git-send-email-quic_cang@quicinc.com>
 <1694411968-14413-2-git-send-email-quic_cang@quicinc.com>
 <20230919103607.GA4732@thinkpad>
From:   Can Guo <quic_cang@quicinc.com>
In-Reply-To: <20230919103607.GA4732@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: YJ31Ri0TDqdbyv77AAjQt6sc-MgtZ-dS
X-Proofpoint-ORIG-GUID: YJ31Ri0TDqdbyv77AAjQt6sc-MgtZ-dS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-31_01,2023-10-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 mlxscore=0 impostorscore=0 mlxlogscore=999 phishscore=0
 suspectscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0 clxscore=1015
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2310310104
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mani,

On 9/19/2023 6:36 PM, Manivannan Sadhasivam wrote:
> On Sun, Sep 10, 2023 at 10:59:22PM -0700, Can Guo wrote:
>> Setup host power mode and its limitations during UFS host driver init to
>> avoid repetitive work during every power mode change.
>>
>> Co-developed-by: Bao D. Nguyen <quic_nguyenb@quicinc.com>
>> Signed-off-by: Can Guo <quic_cang@quicinc.com>
>> Signed-off-by: Bao D. Nguyen <quic_nguyenb@quicinc.com>
>> ---
>>   drivers/ufs/host/ufs-qcom.c | 27 ++++++++++++++++++---------
>>   drivers/ufs/host/ufs-qcom.h |  1 +
>>   2 files changed, 19 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
>> index c3215d3..710f079 100644
>> --- a/drivers/ufs/host/ufs-qcom.c
>> +++ b/drivers/ufs/host/ufs-qcom.c
>> @@ -443,7 +443,11 @@ static u32 ufs_qcom_get_hs_gear(struct ufs_hba *hba)
>>   static int ufs_qcom_power_up_sequence(struct ufs_hba *hba)
>>   {
>>   	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
>> +	struct ufs_dev_params *host_pwr_cap = &host->host_pwr_cap;
>>   	struct phy *phy = host->generic_phy;
>> +	enum phy_mode mode = host_pwr_cap->hs_rate == PA_HS_MODE_B ?
>> +							PHY_MODE_UFS_HS_B :
>> +							PHY_MODE_UFS_HS_A;
> I do not see anyone passing PA_HS_MODE_A in this patch, so this change is not
> required now. If you are doing this as a preparatory work, please do it in a
> separate patch.
Sure.
>
>>   	int ret;
>>   
>>   	/* Reset UFS Host Controller and PHY */
>> @@ -460,7 +464,7 @@ static int ufs_qcom_power_up_sequence(struct ufs_hba *hba)
>>   		return ret;
>>   	}
>>   
>> -	phy_set_mode_ext(phy, PHY_MODE_UFS_HS_B, host->phy_gear);
>> +	phy_set_mode_ext(phy, mode, host->phy_gear);
> Same as above.
Sure.
>
>>   
>>   	/* power on phy - start serdes and phy's power and clocks */
>>   	ret = phy_power_on(phy);
>> @@ -884,7 +888,6 @@ static int ufs_qcom_pwr_change_notify(struct ufs_hba *hba,
>>   				struct ufs_pa_layer_attr *dev_req_params)
>>   {
>>   	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
>> -	struct ufs_dev_params ufs_qcom_cap;
>>   	int ret = 0;
>>   
>>   	if (!dev_req_params) {
>> @@ -894,13 +897,7 @@ static int ufs_qcom_pwr_change_notify(struct ufs_hba *hba,
>>   
>>   	switch (status) {
>>   	case PRE_CHANGE:
>> -		ufshcd_init_pwr_dev_param(&ufs_qcom_cap);
>> -		ufs_qcom_cap.hs_rate = UFS_QCOM_LIMIT_HS_RATE;
>> -
>> -		/* This driver only supports symmetic gear setting i.e., hs_tx_gear == hs_rx_gear */
>> -		ufs_qcom_cap.hs_tx_gear = ufs_qcom_cap.hs_rx_gear = ufs_qcom_get_hs_gear(hba);
>> -
>> -		ret = ufshcd_get_pwr_dev_param(&ufs_qcom_cap,
>> +		ret = ufshcd_get_pwr_dev_param(&host->host_pwr_cap,
>>   					       dev_max_params,
>>   					       dev_req_params);
>>   		if (ret) {
>> @@ -1037,6 +1034,17 @@ static void ufs_qcom_advertise_quirks(struct ufs_hba *hba)
>>   		hba->quirks |= UFSHCD_QUIRK_REINIT_AFTER_MAX_GEAR_SWITCH;
>>   }
>>   
>> +static void ufs_qcom_set_pwr_mode_limits(struct ufs_hba *hba)
> It's good that you are moving the setting to init() as they are static, but I'm
> worried about the different naming conventions used all over the place.
>
> The intention here is to set host parameters and then get the agreed one between
> host and the device. But different names are being used. The structure itself is
> named as "ufs_dev_params" even though it targets host and the vendor drivers are
> naming it as "ufs_<vendor>_cap" or "host_cap". And now you've given a new name,
> "host_pwr_cap", which makes things even worse.
>
> So we should rename the struct itself as "ufs_host_params" and all the vendor
> drivers should stick to "host_params".

I like the name 'ufs_host_params', will unify the declaration of it in 
all vendor drivers in next version.


Thanks,

Can Guo.

