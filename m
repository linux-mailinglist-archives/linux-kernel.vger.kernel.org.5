Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83EC7791BCA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 18:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245078AbjIDQyD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 12:54:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244109AbjIDQyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 12:54:02 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27DF3CCB;
        Mon,  4 Sep 2023 09:53:59 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 384GBrgi015072;
        Mon, 4 Sep 2023 16:53:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=1YJWvGjhm2mwos0uHvBOuQE1B8xp4AZf1klUImsFbGM=;
 b=JtervzEaAhz/MWERxEMV9XzQnj1YkvCXswRR9Ucwb/anUw1+9aCiDibNb+LeqO6Z2zOm
 nPfAKU847KGq7wN2H3plR3e+SNg2D/st42+hpdbZg0PBI4msAtPS5P1+/8y8hgU4WI5L
 6+rbIRxq3EeKar4VnIx80pBNDdYjviynZT4C1iiQNx43KagdrPCCHaPaO79SRNVgzKCt
 By81B0ssiy3cMec/XahN17jKVeVsUtRu+VLSaJe/wASuToGJmNP8C3CMPt46o548GphB
 9gA/AgJuj9pyii/4SxHWFnLX6R0R1jP1c6o+LyeCuxurACnXk6UE2SG2vaX63ShVBjhG ag== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3suwedbv5w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Sep 2023 16:53:55 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 384Grsr0026222
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 4 Sep 2023 16:53:54 GMT
Received: from [10.50.40.93] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Mon, 4 Sep
 2023 09:53:50 -0700
Message-ID: <509406eb-8093-4bcf-820f-8e5210e1539d@quicinc.com>
Date:   Mon, 4 Sep 2023 22:23:47 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] remoteproc: qcom: Add NOTIFY_FATAL event type to SSR
 subdevice
Content-Language: en-US
To:     Bjorn Andersson <andersson@kernel.org>
CC:     <agross@kernel.org>, <konrad.dybcio@linaro.org>,
        <mathieu.poirier@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>,
        <quic_srichara@quicinc.com>, <quic_varada@quicinc.com>,
        <quic_kathirav@quicinc.com>, <quic_devipriy@quicinc.com>,
        <quic_sjaganat@quicinc.com>
References: <20230503062146.3891-1-quic_viswanat@quicinc.com>
 <egnmb647g7x7e74j4g2jddwho23ulmbap2q4eimcyj7y4qvdlz@zmaydxodu2a6>
From:   Vignesh Viswanathan <quic_viswanat@quicinc.com>
In-Reply-To: <egnmb647g7x7e74j4g2jddwho23ulmbap2q4eimcyj7y4qvdlz@zmaydxodu2a6>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: QTSc5zeDAyQGIZ-M6X2prj8osOc6LzJq
X-Proofpoint-GUID: QTSc5zeDAyQGIZ-M6X2prj8osOc6LzJq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-04_09,2023-08-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 mlxscore=0 adultscore=0
 mlxlogscore=809 impostorscore=0 clxscore=1011 phishscore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309040151
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/16/2023 1:50 AM, Bjorn Andersson wrote:
> On Wed, May 03, 2023 at 11:51:46AM +0530, Vignesh Viswanathan wrote:
>> Currently the SSR subdevice notifies the client driver on crash of the
>> rproc from the recovery workqueue using the BEFORE_SHUTDOWN event.
>> However the client driver might be interested to know that the device
>> has crashed immediately to pause any further transactions with the
>> rproc. This calls for an event to be sent to the driver in the IRQ
>> context as soon as the rproc crashes.
>>
> 
> Please make your argumentation more concrete, I can only guess what
> client driver you're referring to.
> 
> You can do this either by spelling out which actual problem you're
> solving, or better yet, include some patches in the series that actually
> uses this interface.
> 

Hi Bjorn,

Apologies for the delay in response.

The client driver in my scenario is a Wi-Fi driver which is continuously
queuing data to the remoteproc and needs to know if remoteproc crashes
as soon as possible to stop queuing further data and also dump some 
debug statistics on the driver side that could potentially help in debug
of why the remoteproc crashed.

Also in the case with upcoming Wi-Fi 7 targets with multi-link 
operation, the driver might need to know that the remoteproc has crashed
instantly to handle some multi-link specific handling.

The ath11k/ath12k WLAN drivers today partially have support for handling
such FATAL notification but it has not been upstreamed yet.

Reference patch: 
https://git.codelinaro.org/clo/qsdk/oss/system/feeds/wlan-open/-/blob/win.wlan_host_opensource.1.0/mac80211/patches/031-ath11k-print-stats-on-crash.patch 
-- event SUBSYS_PREPARE_FOR_FATAL_SHUTDOWN.

Also, Mukesh mentioned earlier that in some MSM targets with PCIe where 
latency cannot be tolerated, a similar downstream patch adds support for 
"early notifier". If this patch is accepted, the early notifier can also 
be replaced to use the same NOTIFY_FATAL event from SSR Subdevice

https://git.codelinaro.org/clo/la/kernel/msm-5.15/-/commit/7583d24de337aa1bf7c375a7da706af9b995b9a1#a840754ebb0e24e88adbf48177e1abd0830b72d2
https://git.codelinaro.org/clo/la/kernel/msm-5.15/-/commit/257de41c63a5a51a081cc7887cdaa4a46e4d1744

Thanks,
Vignesh

> Regards,
> Bjorn
