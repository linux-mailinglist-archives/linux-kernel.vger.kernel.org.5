Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 867C27E1A49
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 07:39:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230409AbjKFGjz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 01:39:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbjKFGjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 01:39:53 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62693F2
        for <linux-kernel@vger.kernel.org>; Sun,  5 Nov 2023 22:39:50 -0800 (PST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A64TkVu017523;
        Mon, 6 Nov 2023 06:39:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=c3kjkWQlNwcEFxzjlS9Qs34MYis6hXyiIoEcJZeXQgw=;
 b=i/xhgnoY6DrfqzvfTiu1XSSc6ViwKRMIFfWLFtoI4T5zg3VL3smXi591k3ZorL2eRS8f
 hmIi0BdNfimbrYcwLJRYwccWoy90DVmzQjT+GYAbxbNfdOTW+ZIrQQWHODrtE0Ycimjf
 nXC3KKLm91zyEQPjOSiuughg/lTVtEF4M/ZY/k55rgTzmqXjC7B9p4X2jEvumFvHBQhc
 zKdEXaaQcT1LFFM906m7aFPvd9FnDscAnDg28UJD0JrNxeziFy8xe6sd89ERHvEReke7
 5qStytPrZ1/ZeMamaEI5ScdgtZFxI/EJQhJtyuncK6tPXyIiqXjSYIbmGv9wjxT+388y ow== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u5f8du8ck-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Nov 2023 06:39:36 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3A66dacg013940
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 6 Nov 2023 06:39:36 GMT
Received: from [10.214.227.50] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Sun, 5 Nov
 2023 22:39:30 -0800
Message-ID: <6c4bd8fd-624a-4c2f-a9a8-dfdbd8281010@quicinc.com>
Date:   Mon, 6 Nov 2023 12:09:26 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] iommu/arm-smmu: introduction of ACTLR implementation
 for Qualcomm SoCs
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC:     <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
        <a39.skl@gmail.com>, <konrad.dybcio@linaro.org>,
        <quic_saipraka@quicinc.com>, <quic_pkondeti@quicinc.com>,
        <quic_molvera@quicinc.com>, <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <qipl.kernel.upstream@quicinc.com>
References: <20231103215124.1095-1-quic_bibekkum@quicinc.com>
 <CAA8EJpqtZXNSz2-VEdQL2XTxi6GnZBkLABLe1qSUcwCbfoEHVQ@mail.gmail.com>
From:   Bibek Kumar Patro <quic_bibekkum@quicinc.com>
In-Reply-To: <CAA8EJpqtZXNSz2-VEdQL2XTxi6GnZBkLABLe1qSUcwCbfoEHVQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: JmLINs9g8SS7nRI1aHSSon2bII_xhLjt
X-Proofpoint-GUID: JmLINs9g8SS7nRI1aHSSon2bII_xhLjt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-06_04,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 adultscore=0
 mlxscore=0 suspectscore=0 phishscore=0 mlxlogscore=999 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311060057
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/4/2023 4:14 AM, Dmitry Baryshkov wrote:
> On Fri, 3 Nov 2023 at 23:53, Bibek Kumar Patro
> <quic_bibekkum@quicinc.com> wrote:
>>
>> This patch series consists of three parts and covers the following:
>>
>> 1. Introducing intital set of driver changes to implement ACTLR register
>> for custom prefetcher settings in Qualcomm SoCs.
>>
>> 2. Adding ACTLR data and implementation operations for SM8550.
>>
>> 3. Re-enabling context caching for Qualcomm SoCs to retain prefetcher
>> settings during reset and runtime suspend.
>>
>> Link to discussion on RFC posted on ACTLR implementation:
>> https://lore.kernel.org/all/a01e7e60-6ead-4a9e-ba90-22a8a6bbd03f@quicinc.com/
> 
> First two patches in that thread were not archived for some reason.
> 
> However, as there was a previous iteration, it is suggested to include
> the changelog between RFC and v1.
> 

Right, in the initial RFC sent somehow only the replies were archived.
Although the RFC patch was a WIP patch in rough state, sent to take 
upstream inputs.
Will try adding the changelog in v2.
To give a context, in the RFC patch, we we're initially proposing a dt
based approach to set the actlr property, where we would piggyback on 
the iommus property to store actlr value and set the property during
smmu device probe.

>>
>> Bibek Kumar Patro (3):
>>    iommu/arm-smmu: introduction of ACTLR for custom prefetcher settings
>>    iommu/arm-smmu: add ACTLR data and support for sm8550
>>    iommu/arm-smmu: re-enable context caching in smmu reset operation
>>
>>   drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 143 ++++++++++++++++++++-
>>   drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h |   2 +
> 
> Although it is not mentioned in the MAINTAINERS file, could you please
> CC linux-arm-msm when sending v2?
> 

Sure Dmitry, will take care of this and CC linux-arm-msm while sending v2.

>>   drivers/iommu/arm/arm-smmu/arm-smmu.c      |   5 +-
>>   drivers/iommu/arm/arm-smmu/arm-smmu.h      |   5 +
>>   4 files changed, 146 insertions(+), 9 deletions(-)
>>
>> --
>> 2.17.1
>>
> 
> 
