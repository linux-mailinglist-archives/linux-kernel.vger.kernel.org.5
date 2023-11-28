Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCEE87FB32E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 08:50:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234118AbjK1HuT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 02:50:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234627AbjK1HuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 02:50:13 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E8251BB;
        Mon, 27 Nov 2023 23:50:19 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AS4stMr007950;
        Tue, 28 Nov 2023 07:49:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=OZoJos7LnjFHs8azFtepxxDLx6KAhcY7VaAcZeBfbGA=;
 b=iObV9evCcG9Nuz1CFltTkvrTMOWE3JTMl63yRBY7yZnEjt/6mtz5s35xF1fBOdxDV0ZE
 FKMsvWH+WZlRZTVmut4ltVdFJdqO+Pn7wJY+hf/hySL6KMszqLPJeL5RPjEIGxzk7QMy
 5kwoY6LkiMu9MYwh7K4ybQn+NzoUm7rbNFk6asX2tDdrQNo7gq6x47dTtyNBSdSq00m2
 7UUkXLVl3mzroX6agwdFhOOm3rTdZPzXfwcbF6soFNeYHWdZqKI2Nsy0qRi2Bj+InQaq
 khlgWMaeKlc8k2HFnqfgXSOF2M3RziATqWX2radFX+Cx09yAw6ZMVbxmpctwhqyfRtFI 2g== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3umt632pgv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Nov 2023 07:49:42 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AS7nfIJ031048
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Nov 2023 07:49:41 GMT
Received: from [10.253.11.37] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 27 Nov
 2023 23:49:36 -0800
Message-ID: <86c27d90-9280-489e-b00e-187977657ee4@quicinc.com>
Date:   Tue, 28 Nov 2023 15:49:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 01/10] scsi: ufs: host: Rename structure ufs_dev_params
 to ufs_host_params
Content-Language: en-US
To:     Manivannan Sadhasivam <mani@kernel.org>
CC:     <bvanassche@acm.org>, <adrian.hunter@intel.com>,
        <beanhuo@micron.com>, <avri.altman@wdc.com>,
        <junwoo80.lee@samsung.com>, <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Andrew Halaney <ahalaney@redhat.com>,
        =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Brian Masney <bmasney@redhat.com>,
        "moderated list:ARM/SAMSUNG S3C, S5P AND EXYNOS ARM ARCHITECTURES" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/SAMSUNG S3C, S5P AND EXYNOS ARM ARCHITECTURES" 
        <linux-samsung-soc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:UNIVERSAL FLASH STORAGE HOST CONTROLLER DRIVER..." 
        <linux-mediatek@lists.infradead.org>
References: <1700729190-17268-1-git-send-email-quic_cang@quicinc.com>
 <1700729190-17268-2-git-send-email-quic_cang@quicinc.com>
 <20231128051917.GB3088@thinkpad> <20231128053136.GE3088@thinkpad>
From:   Can Guo <quic_cang@quicinc.com>
In-Reply-To: <20231128053136.GE3088@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: cQtYOPYbCBB3cCs87Zz2fyuHqhFm4fzF
X-Proofpoint-ORIG-GUID: cQtYOPYbCBB3cCs87Zz2fyuHqhFm4fzF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-28_06,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0
 malwarescore=0 phishscore=0 clxscore=1015 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311280059
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/28/2023 1:31 PM, Manivannan Sadhasivam wrote:
> On Tue, Nov 28, 2023 at 10:49:36AM +0530, Manivannan Sadhasivam wrote:
>> On Thu, Nov 23, 2023 at 12:46:21AM -0800, Can Guo wrote:
>>> Structure ufs_dev_params is actually used in UFS host vendor drivers to
>>> declare host specific power mode parameters, like ufs_<vendor>_params or
>>> host_cap, which makes the code not very straightforward to read. Rename the
>>> structure ufs_dev_params to ufs_host_params and unify the declarations in
>>> all vendor drivers to host_params.
>>>
>>> In addition, rename the two functions ufshcd_init_pwr_dev_param() and
>>> ufshcd_get_pwr_dev_param() which work based on the ufs_host_params to
>>> ufshcd_init_host_param() and ufshcd_negotiate_pwr_param() respectively to
>>> avoid confusions.
>>>
>>> This change does not change any functionalities or logic.
>>>
>>> Acked-by: Andrew Halaney <ahalaney@redhat.com>
>>> Signed-off-by: Can Guo <quic_cang@quicinc.com>
>>
>> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>>
>> - Mani
>>
>>> ---
>>>   drivers/ufs/host/ufs-exynos.c    |  7 ++--
>>>   drivers/ufs/host/ufs-hisi.c      | 11 +++----
>>>   drivers/ufs/host/ufs-mediatek.c  | 12 +++----
>>>   drivers/ufs/host/ufs-qcom.c      | 12 +++----
>>>   drivers/ufs/host/ufshcd-pltfrm.c | 69 ++++++++++++++++++++--------------------
>>>   drivers/ufs/host/ufshcd-pltfrm.h | 10 +++---
>>>   6 files changed, 57 insertions(+), 64 deletions(-)
>>>
> 
> [...]
> 
>>> diff --git a/drivers/ufs/host/ufshcd-pltfrm.h b/drivers/ufs/host/ufshcd-pltfrm.h
>>> index a86a3ad..2d4d047 100644
>>> --- a/drivers/ufs/host/ufshcd-pltfrm.h
>>> +++ b/drivers/ufs/host/ufshcd-pltfrm.h
>>> @@ -10,7 +10,7 @@
>>>   #define UFS_PWM_MODE 1
>>>   #define UFS_HS_MODE  2
>>>   
>>> -struct ufs_dev_params {
>>> +struct ufs_host_params {
>>>   	u32 pwm_rx_gear;        /* pwm rx gear to work in */
>>>   	u32 pwm_tx_gear;        /* pwm tx gear to work in */
>>>   	u32 hs_rx_gear;         /* hs rx gear to work in */
>>> @@ -25,10 +25,10 @@ struct ufs_dev_params {
>>>   	u32 desired_working_mode;
>>>   };
>>>   
>>> -int ufshcd_get_pwr_dev_param(const struct ufs_dev_params *dev_param,
>>> -			     const struct ufs_pa_layer_attr *dev_max,
>>> -			     struct ufs_pa_layer_attr *agreed_pwr);
>>> -void ufshcd_init_pwr_dev_param(struct ufs_dev_params *dev_param);
>>> +int ufshcd_negotiate_pwr_param(const struct ufs_host_params *host_param,
>>> +			       const struct ufs_pa_layer_attr *dev_max,
>>> +			       struct ufs_pa_layer_attr *agreed_pwr);
>>> +void ufshcd_init_host_param(struct ufs_host_params *host_param);
> 
> Noticed this after giving my R-b tag. Could you please rename the functions to:
> 
> int ufshcd_negotiate_pwr_params(const struct ufs_host_params *host_params,...
> void ufshcd_init_host_params(struct ufs_host_params *host_params);
> 
> Not a big deal, but since the argument passed to both functions are 'params',
> it'd be good if the function definition also use the same plural form.
> 

No worries, will do in next version.

Thanks,
Can Guo.

> - Mani
> 
