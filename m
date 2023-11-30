Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 642A17FEA5C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 09:22:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344771AbjK3IVy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 03:21:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjK3IVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 03:21:53 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCB3E1AD;
        Thu, 30 Nov 2023 00:21:59 -0800 (PST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AU5v4JZ018781;
        Thu, 30 Nov 2023 08:21:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=dz8Optkq+LLXjSlAMAJedfk4pp3gq4gJbQyoOa7Wxb0=;
 b=jg8A98k2IRr/kyRnzTwR97GtuMF2I30BrR8aWtw72TncpTomGZ4pbE5cQr5B969Ytw6U
 k4a0wBzjnZw6FUdWhPGQYePet+OarTi8JkG8kD9Har8PAOJvVSXsYjy9SZGXIbBNTi8Z
 AONqkeKWZYBxMG/DycNnYJs/L3CnfOZB2vjVmb7meDhc39VK8zA06KrJYHGQi5EqeQq9
 +vaukmPaym39UQKa7ct3DzEgcyi6UszRECXIUHkp9uwcFiKzV2hiQOhHK32eMbgSDTjr
 m3LQGEEhGdS7qbfIkdvoTq26rvdihIK9XRRHg1VOdeidxV9IaanLml5ZhbyjwpueWk1f pg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uph8x0vcd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Nov 2023 08:21:45 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AU8Ljsw007555
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Nov 2023 08:21:45 GMT
Received: from [10.253.11.15] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 30 Nov
 2023 00:21:41 -0800
Message-ID: <a8eef2d5-5ac5-45bb-97ba-1d6acd5a6a5c@quicinc.com>
Date:   Thu, 30 Nov 2023 16:21:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 10/10] scsi: ufs: ufs-qcom: Add support for UFS device
 version detection
Content-Language: en-US
To:     Manivannan Sadhasivam <mani@kernel.org>
CC:     <bvanassche@acm.org>, <adrian.hunter@intel.com>,
        <cmd4@qualcomm.com>, <beanhuo@micron.com>, <avri.altman@wdc.com>,
        <junwoo80.lee@samsung.com>, <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        "Bao D. Nguyen" <quic_nguyenb@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        open list <linux-kernel@vger.kernel.org>
References: <1701246516-11626-1-git-send-email-quic_cang@quicinc.com>
 <1701246516-11626-11-git-send-email-quic_cang@quicinc.com>
 <20231130072529.GI3043@thinkpad>
From:   Can Guo <quic_cang@quicinc.com>
In-Reply-To: <20231130072529.GI3043@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: E5yLY68PX5AwXiwVZAXBawojO9SgJj7f
X-Proofpoint-GUID: E5yLY68PX5AwXiwVZAXBawojO9SgJj7f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-30_06,2023-11-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 mlxscore=0 impostorscore=0
 priorityscore=1501 clxscore=1015 malwarescore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311300061
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/30/2023 3:25 PM, Manivannan Sadhasivam wrote:
> On Wed, Nov 29, 2023 at 12:28:35AM -0800, Can Guo wrote:
>> From: "Bao D. Nguyen" <quic_nguyenb@quicinc.com>
>>
>> A spare register in UFS host controller is used to indicate the UFS device
>> version. The spare register is populated by bootloader for now, but in
>> future it will be populated by HW automatically during link startup with
>> its best efforts in any boot stages prior to Linux.
>>
>> During host driver init, read the spare register, if it is not populated
>> with a UFS device version, go ahead with the dual init mechanism. If a UFS
>> device version is in there, use the UFS device version together with host
>> controller's HW version to decide the proper PHY gear which should be used
>> to configure the UFS PHY without going through the second init.
>>
>> Signed-off-by: Bao D. Nguyen <quic_nguyenb@quicinc.com>
>> Signed-off-by: Can Guo <quic_cang@quicinc.com>
>> ---
>>   drivers/ufs/host/ufs-qcom.c | 23 ++++++++++++++++++-----
>>   drivers/ufs/host/ufs-qcom.h |  2 ++
>>   2 files changed, 20 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
>> index 9c0ebbc..e94dea2 100644
>> --- a/drivers/ufs/host/ufs-qcom.c
>> +++ b/drivers/ufs/host/ufs-qcom.c
>> @@ -1068,15 +1068,28 @@ static void ufs_qcom_advertise_quirks(struct ufs_hba *hba)
>>   static void ufs_qcom_set_phy_gear(struct ufs_qcom_host *host)
>>   {
>>   	struct ufs_host_params *host_params = &host->host_params;
>> +	u32 val, dev_major = 0;
> 
> No need to initialize dev_major.

True.

> 
>>   
>>   	host->phy_gear = host_params->hs_tx_gear;
>>   
>> -	/*
>> -	 * Power up the PHY using the minimum supported gear (UFS_HS_G2).
>> -	 * Switching to max gear will be performed during reinit if supported.
>> -	 */
>> -	if (host->hw_ver.major < 0x4)
>> +	if (host->hw_ver.major < 0x4) {
>> +		/*
>> +		 * Power up the PHY using the minimum supported gear (UFS_HS_G2).
>> +		 * Switching to max gear will be performed during reinit if supported.
>> +		 */
>>   		host->phy_gear = UFS_HS_G2;
>> +	} else {
> 
> Can you please add a comment here to describe what is happening?

Will do.

> 
>> +		val = ufshcd_readl(host->hba, REG_UFS_DEBUG_SPARE_CFG);
>> +		dev_major = FIELD_GET(GENMASK(7, 4), val);
> 
> It'd be good to add a macro for GENMASK().

OK

> 
>> +
>> +		/* UFS device version populated, no need to do init twice */
> 
> "Since the UFS device version is populated, let's remove the REINIT quirk as the
> negotiated gear won't change during boot. So there is no need to do reinit."
> 

Nice comment.

>> +		if (dev_major != 0)
> 
> 0x0

Done

> 
>> +			host->hba->quirks &= ~UFSHCD_QUIRK_REINIT_AFTER_MAX_GEAR_SWITCH;
>> +
>> +		/* For UFS 3.1 and older, apply HS-G4 PHY gear to save power */
>> +		if (dev_major < 0x4 && dev_major > 0)
> 
> if (dev_major > 0x0 && dev_major < 0x4)
> 

Sure.

Thanks,
Can Guo.

> - Mani
> 
>> +			host->phy_gear = UFS_HS_G4;
>> +	}
>>   }
>>   
>>   static void ufs_qcom_set_host_params(struct ufs_hba *hba)
>> diff --git a/drivers/ufs/host/ufs-qcom.h b/drivers/ufs/host/ufs-qcom.h
>> index 11419eb..d12fc5a 100644
>> --- a/drivers/ufs/host/ufs-qcom.h
>> +++ b/drivers/ufs/host/ufs-qcom.h
>> @@ -54,6 +54,8 @@ enum {
>>   	UFS_AH8_CFG				= 0xFC,
>>   
>>   	REG_UFS_CFG3				= 0x271C,
>> +
>> +	REG_UFS_DEBUG_SPARE_CFG			= 0x284C,
>>   };
>>   
>>   /* QCOM UFS host controller vendor specific debug registers */
>> -- 
>> 2.7.4
>>
>>
> 
