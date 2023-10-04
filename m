Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D92E27B7D9A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 12:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233199AbjJDK6m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 06:58:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232814AbjJDK6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 06:58:41 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E7ADA1;
        Wed,  4 Oct 2023 03:58:38 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39469Q9j013823;
        Wed, 4 Oct 2023 10:58:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=2rmV/ARSRJlBfpZHJp2o0ucha4GQrOhHYJw/fdsnWAY=;
 b=Zy2xVcNkYmafw2P37d19rimvP//dPRK98kM7nasrwKN6tGjz681pAGmbVBV/Hg5F/pjr
 EvgoGvTyD3IwOTYZ19CpyCUe3bnaeZB25X0F3NGY8fS4PGO+bBejasUoWjQn8h9KWYk/
 HCTp6B7eJTcxmI8NVHdqlxsCP9UKzRlsTYh/NCbgCGHWmx63UJR+k/q3dcFNkQZD6e9w
 ozIM0MYv8JUBzhMp1oyqskQBdGHLGbQgmAopKc00p0k+ngH2Pxu4MReH1LSVrHWlFr8H
 gndy5OgaDMupO+ZVbYHIcdC5qPx80evUZZMQJj++76zcjDiG+qMQyHfKOYrMhyfnd3Zw ww== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3th2gq0huq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Oct 2023 10:58:33 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 394AwWat026777
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 4 Oct 2023 10:58:32 GMT
Received: from [10.217.218.207] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Wed, 4 Oct
 2023 03:58:28 -0700
Message-ID: <44bb2149-1c12-41f0-bd39-1458528aecdf@quicinc.com>
Date:   Wed, 4 Oct 2023 16:28:25 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 0/2] Add partial initialization support
Content-Language: en-US
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>
CC:     <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <quic_rampraka@quicinc.com>,
        <quic_pragalla@quicinc.com>, <quic_sayalil@quicinc.com>,
        <quic_nitirawa@quicinc.com>, <quic_sachgupt@quicinc.com>,
        <quic_bhaskarv@quicinc.com>, <quic_narepall@quicinc.com>
References: <20230929102831.9702-1-quic_sartgarg@quicinc.com>
 <f6e4413b-eac1-4c0d-9ecd-ff28138617ff@linaro.org>
From:   Sarthak Garg <quic_sartgarg@quicinc.com>
In-Reply-To: <f6e4413b-eac1-4c0d-9ecd-ff28138617ff@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: SgM0_mnGSbbwP6wjjRblvTs5sGkg2iLp
X-Proofpoint-ORIG-GUID: SgM0_mnGSbbwP6wjjRblvTs5sGkg2iLp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-04_01,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 phishscore=0 mlxlogscore=705 mlxscore=0 impostorscore=0
 malwarescore=0 suspectscore=0 clxscore=1011 bulkscore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310040079
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/29/2023 6:38 PM, Bryan O'Donoghue wrote:
> On 29/09/2023 11:28, Sarthak Garg wrote:
>> Add the ability to partially initialize the MMC device by
>> using device sleep/awake sequence (CMD5).
>> Device will be sent to sleep state during mmc runtime/system suspend
>> and will be woken up during mmc runtime/system resume.
>> By using this sequence the device doesn't need full initialization
>> which gives 25% time reduction in system/runtime resume path.
>> Also enable this feature for qualcomm controllers.
>>
>> Sarthak Garg (2):
>>    mmc: core: Add partial initialization support
>>    mmc: sdhci-msm: Enable MMC_CAP2_SLEEP_AWAKE for Qualcomm controllers
>>
>>   drivers/mmc/core/mmc.c       | 162 +++++++++++++++++++++++++++++++++--
>>   drivers/mmc/host/sdhci-msm.c |   1 +
>>   include/linux/mmc/card.h     |   4 +
>>   include/linux/mmc/host.h     |   2 +
>>   4 files changed, 160 insertions(+), 9 deletions(-)
>>
>> -- 
>> 2.17.1
>>
>
> A terrible nit pick on my part however, you should include the name of 
> the subsystem/driver in the title of the series.
>
> "mmc: Do this awesome new thing"
>
> ---
> bod


Thanks for the comment will take care in V3.

Thanks,
Sarthak



