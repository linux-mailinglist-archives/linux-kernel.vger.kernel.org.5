Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 428637DC5A9
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 06:06:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbjJaFGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 01:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjJaFGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 01:06:37 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DA15E4;
        Mon, 30 Oct 2023 22:06:34 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39V2apwa020072;
        Tue, 31 Oct 2023 05:06:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Bsyw35+5/YamzzseCa1ApMIxfzACug2MNhnFyQL7s20=;
 b=VI8NJ9iV5QDaJ/6DW4nsJsoo5F0mCVgSSssrkfe4NgrrZaPuV/8e+7+eRhbXXCKUcItb
 HANW3UqQsFXSp2blocs7t80jESxCiNDGtpGNJzTVafHIri3WKriUYjT2xz6rNDSColEB
 /N/13VazpKomBYlYh++JDTMqHMNDbekuXJO38Ujy0Qh9+CD/6l4fMA6yuejvOaSDaMWh
 A4IY950bkJPKE9VLygVIIByxybcI5mxy5VI9WBbSPm23xQyV34LWyjB2IHek141YsXLX
 EK3FE5hF+E507yAqs8yaTBTAmmtpotBAtYL0L3kIdciE40WtbTIOetaW26JP8VYClsgG Uw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u2chyhwte-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Oct 2023 05:06:15 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39V56E6V016906
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Oct 2023 05:06:14 GMT
Received: from [10.253.74.76] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Mon, 30 Oct
 2023 22:06:11 -0700
Message-ID: <d5ffacca-579e-83c9-148e-1fd3b6ab5aad@quicinc.com>
Date:   Tue, 31 Oct 2023 13:06:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 2/6] scsi: ufs: ufs-qcom: Add support for UFS device
 version detection
Content-Language: en-US
To:     <neil.armstrong@linaro.org>, <mani@kernel.org>,
        <quic_nguyenb@quicinc.com>, <quic_nitirawa@quicinc.com>,
        <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>, Andy Gross <agross@kernel.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "open list:UNIVERSAL FLASH STORAGE HOST CONTROLLER DRIVER..." 
        <linux-arm-msm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <1694411968-14413-1-git-send-email-quic_cang@quicinc.com>
 <1694411968-14413-3-git-send-email-quic_cang@quicinc.com>
 <ccf40aed-3acc-474e-b456-031669b4a895@linaro.org>
 <059cc112-7fb6-4da4-bc25-4eede0252f0e@linaro.org>
From:   Can Guo <quic_cang@quicinc.com>
In-Reply-To: <059cc112-7fb6-4da4-bc25-4eede0252f0e@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 5MywGzIbBri0unlUfXJkBqZ8A_URHfGd
X-Proofpoint-GUID: 5MywGzIbBri0unlUfXJkBqZ8A_URHfGd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-30_13,2023-10-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 mlxscore=0 adultscore=0 mlxlogscore=999 spamscore=0 phishscore=0
 clxscore=1011 suspectscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2310310038
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

On 10/27/2023 8:51 PM, Neil Armstrong wrote:
> On 18/10/2023 16:02, Neil Armstrong wrote:
>> On 11/09/2023 07:59, Can Guo wrote:
>>> From: "Bao D. Nguyen" <quic_nguyenb@quicinc.com>
>>>
>>> Retrieve UFS device version from UFS host controller's spare register
>>> which is populated by bootloader, and use the UFS device version 
>>> together
>>> with host controller's HW version to decide the proper power modes 
>>> which
>>> should be used to configure the UFS PHY.
>>>
>>> Signed-off-by: Bao D. Nguyen <quic_nguyenb@quicinc.com>
>>> Signed-off-by: Can Guo <quic_cang@quicinc.com>
>>> ---
>>>   drivers/ufs/host/ufs-qcom.c | 30 +++++++++++++++++++++++-------
>>>   drivers/ufs/host/ufs-qcom.h |  2 ++
>>>   2 files changed, 25 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
>>> index 710f079..8a9d54f 100644
>>> --- a/drivers/ufs/host/ufs-qcom.c
>>> +++ b/drivers/ufs/host/ufs-qcom.c
>>> @@ -1030,7 +1030,7 @@ static void ufs_qcom_advertise_quirks(struct 
>>> ufs_hba *hba)
>>>                   | UFSHCD_QUIRK_BROKEN_PA_RXHSUNTERMCAP);
>>>       }
>>> -    if (host->hw_ver.major > 0x3)
>>> +    if (host->hw_ver.major > 0x3 && host->hw_ver.major < 0x5)
>>>           hba->quirks |= UFSHCD_QUIRK_REINIT_AFTER_MAX_GEAR_SWITCH;
>>>   }
>>> @@ -1038,11 +1038,33 @@ static void 
>>> ufs_qcom_set_pwr_mode_limits(struct ufs_hba *hba)
>>>   {
>>>       struct ufs_qcom_host *host = ufshcd_get_variant(hba);
>>>       struct ufs_dev_params *host_pwr_cap = &host->host_pwr_cap;
>>> +    u32 val, dev_major = 0;
>>>       ufshcd_init_pwr_dev_param(host_pwr_cap);
>>>       /* This driver only supports symmetic gear setting i.e., 
>>> hs_tx_gear == hs_rx_gear */
>>>       host_pwr_cap->hs_tx_gear = host_pwr_cap->hs_rx_gear = 
>>> ufs_qcom_get_hs_gear(hba);
>>> +    host->phy_gear = host_pwr_cap->hs_rx_gear;
>>> +
>>> +    if (host->hw_ver.major < 0x5) {
>>
>> Here you set G2 for < 0x5
>>
>>> +        /*
>>> +         * Power up the PHY using the minimum supported gear 
>>> (UFS_HS_G2).
>>> +         * Switching to max gear will be performed during reinit if 
>>> supported.
>>> +         */
>>> +        host->phy_gear = UFS_HS_G2;
>>> +    } else {
>>
>> So here is for >= 0x5
>>
>>> +        val = ufshcd_readl(host->hba, REG_UFS_DEBUG_SPARE_CFG);
>>> +        dev_major = FIELD_GET(GENMASK(7, 4), val);
>>> +
>>> +        if (host->hw_ver.major == 0x5 && (dev_major >= 0x4 ||
>>> +                          dev_major == 0)) {
>>> +            /* For UFS 4.0 and newer, or dev version is not 
>>> populated */
>>> +            host_pwr_cap->hs_rate = PA_HS_MODE_A;
>>> +        } else if (dev_major < 0x4 && dev_major > 0) {
>>> +            /* For UFS 3.1 and older, apply HS-G4 PHY settings to 
>>> save power */
>>> +            host->phy_gear = UFS_HS_G4;
>>> +        }
>>
>> But behavior of > 0x5 is not clear here, could you clarify it in v2 ?
>
> Now SM8650 is public, could you update it for v2 ?

For HWs whose hw_ver.major is > 0x5, say SM8650, initially phy_gear == 
host_pwr_cap->hs_rx_gear, which is HS_G5.

If a UFS3.x or older UFS device is connected, we overwrite phy_gear as 
HS_G4. I don't see an impact to SM8650.

Please let me know if I misunderstand anything here.


Thanks,

Can Guo.

>
> Thanks,
> Neil
>
>>
>> Thanks,
>> Neil
>
