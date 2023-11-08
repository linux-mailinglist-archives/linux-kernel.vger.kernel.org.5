Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A8557E5158
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 08:49:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232404AbjKHHtq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 02:49:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbjKHHtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 02:49:43 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCEB4113;
        Tue,  7 Nov 2023 23:49:41 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A84RObF008885;
        Wed, 8 Nov 2023 07:49:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=D/dxczvvsYMr70g43cKzL3igpf+UjlHp4+Ee7UJnllU=;
 b=l+uk7QZDvNc8jP1YMs5hPUuXUatbQFZxc0Rys3VgEHl8rzwI8KF0PU+oycOY8jxtpyR8
 NqvuxITx9crlasRm+qW1haxRKcwQ4iH+bn2NecyNiI5YygArdlSIZFnv8iysZ0j/ce6L
 rqwrbVyBgxfFghipmpWIXC8jWpENbe82Sc49Pl+PDOG2dk/vI1PAfjUGGkcKQ5HzBjc9
 BbHsPiokz+XbitrcG1BInnwXDqqZfbCKorVEO0cdn99Z5B5RZWBKNNzzDT/790Lh4kfG
 ZyzwmhLP51p/BIfoEZDZnYAMaJRr2WM8DQXuwn3YHugkM2xK4tuBrTNDYj3Bbr9q9oH0 7A== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u7w2ch0t0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Nov 2023 07:49:08 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3A87mjiA007746
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 8 Nov 2023 07:48:45 GMT
Received: from [10.253.34.202] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Tue, 7 Nov
 2023 23:48:40 -0800
Message-ID: <351a7a54-1aeb-f226-855b-30291e9edd80@quicinc.com>
Date:   Wed, 8 Nov 2023 15:48:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 1/7] scsi: ufs: host: Rename structure ufs_dev_params
 to ufs_host_params
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>,
        Can Guo <cang@qti.qualcomm.com>, <mani@kernel.org>,
        <stanley.chu@mediatek.com>, <adrian.hunter@intel.com>,
        <beanhuo@micron.com>, <avri.altman@wdc.com>,
        <junwoo80.lee@samsung.com>, <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>,
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
 <74f98f63-3200-4485-bbf0-819800837ee9@acm.org>
From:   Can Guo <quic_cang@quicinc.com>
In-Reply-To: <74f98f63-3200-4485-bbf0-819800837ee9@acm.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: UYbZiAHeFoDrEtDh_Tq4xe_sc4f_RE9k
X-Proofpoint-ORIG-GUID: UYbZiAHeFoDrEtDh_Tq4xe_sc4f_RE9k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-08_01,2023-11-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 malwarescore=0 phishscore=0
 bulkscore=0 mlxlogscore=999 suspectscore=0 adultscore=0 priorityscore=1501
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311080064
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bart,

On 11/8/2023 4:56 AM, Bart Van Assche wrote:
> On 11/6/23 20:46, Can Guo wrote:
>>   /**
>> - * ufshcd_get_pwr_dev_param - get finally agreed attributes for
>> + * ufshcd_negotiate_pwr_param - get finally agreed attributes for
>>    *                            power mode change
>
> Since you are renaming the function, please also change the description
> of the function into something more meaningful, e.g. "find power mode
> settings that are supported by both the controller and the device".
Sure, will do.
>
>> - * @pltfrm_param: pointer to platform parameters
>> + * @host_param: pointer to platform parameters
>
> Please make sure that the argument name and argument description are in
> sync.
Sure.
>
> Thanks,
>
> Bart.


Thanks,

Can Guo.

