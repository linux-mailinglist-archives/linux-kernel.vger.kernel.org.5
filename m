Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 192A47CEF3F
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 07:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232614AbjJSFp7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 01:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbjJSFp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 01:45:58 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3948B112;
        Wed, 18 Oct 2023 22:45:56 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39J4Pcov009803;
        Thu, 19 Oct 2023 05:45:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=iCBFaE9+zDenL5zSLDNt+FvMR6CJHoJMzI5B7X9ngNw=;
 b=GrqrBXgwNUzsaRP8hqtu3JpIQUiUQDE2wApgPBefqChJMB0ApAaiXJaurzulKbGlvDP8
 eQLdnHPviZvcKOR7qSC2gZnnUW3R5kOC3wrvB3olPvejbnmuPtgU7W9Tf2KRXkqc8KAW
 73SQoQwQsEbEN1+9A2f+mDEIb4EekOtWpu66YjBaO+7akUtUaKPIEnc+R4zC3qSr5av6
 uJB0lnBnP/uMoCiY7OBDAO2LoLg6GyAviUlLjkxHt51nlf9IQMpLqVgYxhI4F99G0Gya
 nx7o5+j6hU0Gzyzvo87AGsE20OjLuVfdaURDxWXryMX6EsXEmeCTVsOz+ZqOrmoMpHme KA== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tt9kjttjj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Oct 2023 05:45:50 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39J5jn62023695
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Oct 2023 05:45:49 GMT
Received: from [10.217.218.207] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Wed, 18 Oct
 2023 22:45:41 -0700
Message-ID: <928acdad-2c8c-4cdf-ad96-7cf44e8ebc99@quicinc.com>
Date:   Thu, 19 Oct 2023 11:15:38 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 0/3] mmc: Add partial initialization support
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <quic_cang@quicinc.com>,
        <quic_nguyenb@quicinc.com>, <quic_rampraka@quicinc.com>,
        <quic_pragalla@quicinc.com>, <quic_sayalil@quicinc.com>,
        <quic_nitirawa@quicinc.com>, <quic_sachgupt@quicinc.com>,
        <quic_bhaskarv@quicinc.com>, <quic_narepall@quicinc.com>,
        <kernel@quicinc.com>
References: <20231017061336.9355-1-quic_sartgarg@quicinc.com>
 <CAPDyKFrxf4wAyJ94g5LYymSZgDJRWvSCy6C73xyYBfxiV+L83g@mail.gmail.com>
Content-Language: en-US
From:   Sarthak Garg <quic_sartgarg@quicinc.com>
In-Reply-To: <CAPDyKFrxf4wAyJ94g5LYymSZgDJRWvSCy6C73xyYBfxiV+L83g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: xZIGrsUzURHYH8vlvU9OSx-5cyeui5nz
X-Proofpoint-GUID: xZIGrsUzURHYH8vlvU9OSx-5cyeui5nz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-19_04,2023-10-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 phishscore=0 mlxlogscore=758 spamscore=0 mlxscore=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310190049
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/17/2023 5:09 PM, Ulf Hansson wrote:
> On Tue, 17 Oct 2023 at 08:13, Sarthak Garg <quic_sartgarg@quicinc.com> wrote:
>>
>> Add the ability to partially initialize the MMC device by
>> using device sleep/awake sequence (CMD5).
>> Device will be sent to sleep state during mmc runtime/system suspend
>> and will be woken up during mmc runtime/system resume.
>> By using this sequence the device doesn't need full initialization
>> which gives 25% time reduction in system/runtime resume path.
>> Also enable this feature along with mmc runtime PM for qualcomm
>> controllers.
>>
>> Sarthak Garg (3):
>>    mmc: core: Add partial initialization support
>>    mmc: sdhci-msm: Enable MMC_CAP_AGGRESSIVE_PM for Qualcomm controllers
>>    mmc: sdhci-msm: Enable MMC_CAP2_SLEEP_AWAKE for Qualcomm controllers
>>
>>   drivers/mmc/core/mmc.c       | 163 +++++++++++++++++++++++++++++++++--
>>   drivers/mmc/host/sdhci-msm.c |   2 +
>>   include/linux/mmc/card.h     |   4 +
>>   include/linux/mmc/host.h     |   2 +
>>   4 files changed, 162 insertions(+), 9 deletions(-)
> 
> Would mind resending this version and while doing that, please add
> some version information to each patch in the series. This helps while
> reviewing.
> 
> Kind regards
> Uffe

Sure will repost with the version history.

Thanks,
Sarthak
