Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 099687EDA0F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 04:25:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344845AbjKPDZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 22:25:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235663AbjKPDZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 22:25:08 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0E331A4;
        Wed, 15 Nov 2023 19:25:04 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AG2V5Wu028597;
        Thu, 16 Nov 2023 03:24:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : from : subject : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Pkaajrilig/I3Si2Z8t9KUxUxQhnu4RWr5zriLFJEYI=;
 b=RV2SGiFbyyX7TdiTpsbpfYe2o2apDD1tm6iEeVZIBDq4VA4GSAnLefClT0ahyBZ2i/0+
 CwhEvA7kHpR0/WYd/HGNuI0upeIFnaOHbqYoIvL9g8nUuK9hTMIbycKDrln4/6WyLPzz
 Lr8Qj/1Y5NbOGwbqYcaUSoFOOCiMhTBLH6iO/IP+HLn1pYKaIpXa/RIGIWCUbvY8iTW1
 xcwFpoyChK6ZNy97uTt2IJARhD2b3fsgAeLsGXKJv35KOV4LGPCue+mO5nC8MXq8zz3o
 ys2zBKkO2dh1j+7TNneA4v24n+ayz3Nn+RhF4yQajg4fmBJGxUvzea59UNu3WFuTX4AY 3g== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ucubsa60t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Nov 2023 03:24:45 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AG3OiCG026776
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Nov 2023 03:24:44 GMT
Received: from [10.216.41.162] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Wed, 15 Nov
 2023 19:24:37 -0800
Message-ID: <7af4e497-da9b-4601-8ef4-cfa62f819477@quicinc.com>
Date:   Thu, 16 Nov 2023 08:54:34 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
From:   Jishnu Prakash <quic_jprakash@quicinc.com>
Subject: Re: [PATCH 09/11] iio: adc: Update QCOM ADC drivers for bindings path
 change
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>
CC:     <agross@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linus.walleij@linaro.org>,
        <Jonathan.Cameron@huawei.com>, <sboyd@kernel.org>,
        <quic_subbaram@quicinc.com>, <quic_collinsd@quicinc.com>,
        <quic_kamalw@quicinc.com>, <marijn.suijten@somainline.org>,
        <andriy.shevchenko@linux.intel.com>,
        <krzysztof.kozlowski@linaro.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        <linux-arm-msm@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-arm-msm-owner@vger.kernel.org>
References: <20230708072835.3035398-1-quic_jprakash@quicinc.com>
 <20230708072835.3035398-10-quic_jprakash@quicinc.com>
 <20230708162318.1e2b169f@jic23-huawei>
 <2dc93e2b-61b4-943c-f938-296922fbece4@quicinc.com>
 <CAA8EJprQFPvBdiwnnkGet7SQiv9nuo4zaDCn9kuLWS0QZ5Kc9Q@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAA8EJprQFPvBdiwnnkGet7SQiv9nuo4zaDCn9kuLWS0QZ5Kc9Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: TJhFHzsapmYyxZKTsSDed87XwyKHcGM8
X-Proofpoint-GUID: TJhFHzsapmYyxZKTsSDed87XwyKHcGM8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-15_20,2023-11-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 malwarescore=0 mlxscore=0 clxscore=1015 bulkscore=0
 suspectscore=0 lowpriorityscore=0 adultscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311160025
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan and Dmitry,

On 10/23/2023 1:28 PM, Dmitry Baryshkov wrote:
> On Mon, 23 Oct 2023 at 09:17, Jishnu Prakash<quic_jprakash@quicinc.com>  wrote:
>> Hi Jonathan,
>>
>> On 7/8/2023 8:53 PM, Jonathan Cameron wrote:
>>> On Sat, 8 Jul 2023 12:58:33 +0530
>>> Jishnu Prakash<quic_jprakash@quicinc.com>  wrote:
>>>
>>>> Update ADC dt-bindings file paths in QCOM ADC driver files to
>>>> match the dt-bindings change moving the files from 'iio' to
>>>> 'iio/adc' folder.
>>>>
>>>> Signed-off-by: Jishnu Prakash<quic_jprakash@quicinc.com>
>>> Do the move in one go.
>>>
>>> Diff rename detection will make the resulting patch more trivial
>>> to look at than this multistep version.
>>>
>>> Jonathan
>> Hi Jonathan,
>>
>> Just to recap, in patches 8-11, the intention is to move the dt-binding
>> files used for QCOM ADCs from /dt-bindings/iio folder to the
>> /dt-bindings/iio/adc folder.
>>
>> I'm just confirming, can we move the files and update documentation,
>> bindings, driver and devicetree files all in one patch? Or you mean one
>> patch for documentation, bindings and driver files and one patch for
>> devicetree files (based on the comment from Krzysztof for the next patch
>> 10 in this series)?
>>
>> Based on this patch series:
>> https://lore.kernel.org/all/cover.1646388139.git.zong.li@sifive.com/,
>> I'm wondering if I should add the files in the new location first, do
>> the file path updates and then completely remove the files in the old
>> path to avoid breaking the kernel.....or is it possible to get the
>> devicetree changes picked along with the binding changes, to avoid any
>> problems with bisectability?
> Perform git mv & fix all failing DT and drivers in a single commit.
> You might also update guarding defines, if you wish. Perform all other
> changes in a separate commit.
>
> This way git diff will actually tell what has happened, instead of us
> seeing a series of add files, perform changes, remove files. It is
> impossible to review your changes otherwise.


Thanks for your suggestion - I'll make the change to move the files and 
fix all resulting errors in one commit for now, and update further based 
on comments on it.

Thanks,

Jishnu


>>>> ---
>>>>    drivers/iio/adc/qcom-spmi-adc5-gen3.c | 2 +-
>>>>    drivers/iio/adc/qcom-spmi-adc5.c      | 2 +-
>>>>    drivers/iio/adc/qcom-spmi-vadc.c      | 2 +-
>>>>    3 files changed, 3 insertions(+), 3 deletions(-)
>>>>
>> Thanks,
>>
>> Jishnu
>>
