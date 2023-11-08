Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1D9D7E514D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 08:45:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231397AbjKHHpv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 02:45:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjKHHps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 02:45:48 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C15411706;
        Tue,  7 Nov 2023 23:45:46 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A86Gk58009326;
        Wed, 8 Nov 2023 07:44:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=oGKLdo3NPJ5cRCFZ+eE7FWQBivkD2Wt2J//M4dNAs/s=;
 b=kz3HEavag4zn6s677HTpkQTx00RiNurPkmS/Q1ACbgPCk1FnlVj9X9DVVP1RQNlG/KUO
 xxqtQsbkQ4I7u4Lkg03kzGO6q6TQSj3ssMpUCsGIFV3u0kTNZqqetqDp/OAoRe8tTl2F
 DVe8rbIUO3swkT4+W1pwDkeyobbROnoQLPaCUItY3dVQXuev6aycBQuoy8/OI190/Tmb
 47GNJY/E2Jkf+Ne4A8/LdgqJLLhRN7xpf1mL9lwtBzY4amROdcxE9JDkTHIk3GmNuIyM
 f6T0TH/EmXGyf7vOjYS0SYZHZwwAX/kxsj6iivIi5oCKuy5CyDEBaN8dH14580tdWEVG Yw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u7xyu0sex-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Nov 2023 07:44:58 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3A87ivZs002711
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 8 Nov 2023 07:44:57 GMT
Received: from [10.253.34.202] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Tue, 7 Nov
 2023 23:44:51 -0800
Message-ID: <cbe26ea4-07b9-9922-07f5-d4b96f910b56@quicinc.com>
Date:   Wed, 8 Nov 2023 15:44:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 1/7] scsi: ufs: host: Rename structure ufs_dev_params
 to ufs_host_params
To:     Andrew Halaney <ahalaney@redhat.com>,
        Can Guo <cang@qti.qualcomm.com>
CC:     <bvanassche@acm.org>, <mani@kernel.org>,
        <stanley.chu@mediatek.com>, <adrian.hunter@intel.com>,
        <beanhuo@micron.com>, <avri.altman@wdc.com>,
        <junwoo80.lee@samsung.com>, <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Brian Masney <bmasney@redhat.com>,
        "moderated list:ARM/SAMSUNG S3C, S5P AND EXYNOS ARM ARCHITECTURES" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/SAMSUNG S3C, S5P AND EXYNOS ARM ARCHITECTURES" 
        <linux-samsung-soc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:UNIVERSAL FLASH STORAGE HOST CONTROLLER DRIVER..." 
        <linux-mediatek@lists.infradead.org>,
        "open list:UNIVERSAL FLASH STORAGE HOST CONTROLLER DRIVER..." 
        <linux-arm-msm@vger.kernel.org>
References: <1699332374-9324-1-git-send-email-cang@qti.qualcomm.com>
 <1699332374-9324-2-git-send-email-cang@qti.qualcomm.com>
 <fcovysoo6vxvqdrypfbnfyclrmifibio46rne5zhiqnmqhzd7k@5ltemasdhfxp>
Content-Language: en-US
From:   Can Guo <quic_cang@quicinc.com>
In-Reply-To: <fcovysoo6vxvqdrypfbnfyclrmifibio46rne5zhiqnmqhzd7k@5ltemasdhfxp>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Zg3DmZ3qNhekEerDGSpqD2-ivhjgznXo
X-Proofpoint-GUID: Zg3DmZ3qNhekEerDGSpqD2-ivhjgznXo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-08_01,2023-11-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 impostorscore=0 priorityscore=1501 mlxlogscore=999 adultscore=0
 suspectscore=0 clxscore=1011 malwarescore=0 phishscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311080062
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On 11/8/2023 3:36 AM, Andrew Halaney wrote:
> On Mon, Nov 06, 2023 at 08:46:07PM -0800, Can Guo wrote:
>> From: Can Guo <quic_cang@quicinc.com>
>>
>> Structure ufs_dev_params is actually used in UFS host vendor drivers to
>> declare host specific power mode parameters, like ufs_<vendor>_params or
>> host_cap, which makes the code not very straightforward to read. Rename the
>> structure ufs_dev_params to ufs_host_params and unify the declarations in
>> all vendor drivers to host_params.
>>
>> In addition, rename the two functions ufshcd_init_dev_pwr_param() and
> nit: s/ufshcd_init_dev_pwr_param/ufshcd_init_pwr_dev_param/
sure
>
>> ufshcd_get_dev_pwr_param() which work based on the ufs_host_params to
> nit: s/ufshcd_get_dev_pwr_param/ufshcd_get_pwr_dev_param/
sure
>
>> ufshcd_init_host_param() and ufshcd_negotiate_pwr_param() respectively to
>> avoid confusions.
>>
>> This change does not change any functionalities or logic.
>>
>> Signed-off-by: Can Guo <quic_cang@quicinc.com>
>> ---
>>   drivers/ufs/host/ufs-exynos.c    |  7 +++---
>>   drivers/ufs/host/ufs-hisi.c      | 11 ++++-----
>>   drivers/ufs/host/ufs-mediatek.c  | 12 ++++------
>>   drivers/ufs/host/ufs-qcom.c      | 12 ++++------
>>   drivers/ufs/host/ufshcd-pltfrm.c | 49 ++++++++++++++++++++--------------------
>>   drivers/ufs/host/ufshcd-pltfrm.h | 10 ++++----
>>   6 files changed, 47 insertions(+), 54 deletions(-)
>>
> <snip>
>
>> diff --git a/drivers/ufs/host/ufshcd-pltfrm.c b/drivers/ufs/host/ufshcd-pltfrm.c
>> index da2558e..6e65b61 100644
>> --- a/drivers/ufs/host/ufshcd-pltfrm.c
>> +++ b/drivers/ufs/host/ufshcd-pltfrm.c
>> @@ -285,17 +285,17 @@ static int ufshcd_parse_operating_points(struct ufs_hba *hba)
>>   }
>>   
>>   /**
>> - * ufshcd_get_pwr_dev_param - get finally agreed attributes for
>> + * ufshcd_negotiate_pwr_param - get finally agreed attributes for
>>    *                            power mode change
>> - * @pltfrm_param: pointer to platform parameters
>> + * @host_param: pointer to platform parameters
>>    * @dev_max: pointer to device attributes
>>    * @agreed_pwr: returned agreed attributes
>>    *
>>    * Return: 0 on success, non-zero value on failure.
>>    */
>> -int ufshcd_get_pwr_dev_param(const struct ufs_dev_params *pltfrm_param,
>> -			     const struct ufs_pa_layer_attr *dev_max,
>> -			     struct ufs_pa_layer_attr *agreed_pwr)
>> +int ufshcd_negotiate_pwr_param(const struct ufs_host_params *host_param,
>> +			       const struct ufs_pa_layer_attr *dev_max,
>> +			       struct ufs_pa_layer_attr *agreed_pwr)
>>   {
>>   	int min_pltfrm_gear;
> If you're going to change pltfrm -> host, maybe do so for
> min_pltfrm_gear too? I think this all reads nicer with the functions
> changed as is, but the consistency would be nice in my opinion.

Sure, will address in next version.

>
> Outside of those nits, I think this reads nicer now as well.
>
> Acked-by: Andrew Halaney <ahalaney@redhat.com>


Thanks,

Can Guo

