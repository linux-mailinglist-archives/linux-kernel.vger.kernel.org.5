Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A8A97EDA0A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 04:25:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343654AbjKPDZD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 22:25:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjKPDZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 22:25:01 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01166199;
        Wed, 15 Nov 2023 19:24:57 -0800 (PST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AG2h7uB001020;
        Thu, 16 Nov 2023 03:24:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : from : subject : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=I4yaIbz0iC/MoFwDc9aSKAR+Xpz3oNadrypAS22c5P4=;
 b=cSBE7IyiBEMcjJWEUbcF5lxCeLmmqJcKyUa/mpYwxwhA0QhL7JXabxsI1vsdx83NiIen
 79tVXjidOstynaQrL3OVspMvTtHlJQ3Nz3R/hJdCQn9UXmKGKEm/vgXbAL0j4TVJruC5
 d5Q4ZybxlIUXF/PmDYc2pIUVAre4LaJwmp7hRyJHSjAue0kjO5wz/OYGJRZDkdpr4epT
 5Sy4Uu0h4+Pa25xHBTpZfrIqm9r6F5aYbzFVe/8w1BjXhS1N2B+wQp/VT4oqd3md4RPJ
 JrUa7LgLs45VKPFXDGiukMSEcRxE3Q0+7KNNZPmGEBbMCJTXbhEumkSpN5U3yy3crOHX IQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ucfkabny2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Nov 2023 03:24:20 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AG3OI0U026280
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Nov 2023 03:24:18 GMT
Received: from [10.216.41.162] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Wed, 15 Nov
 2023 19:24:08 -0800
Message-ID: <60a058ba-0bd3-9a5e-5021-4f80b9df65a8@quicinc.com>
Date:   Thu, 16 Nov 2023 08:54:04 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
From:   Jishnu Prakash <quic_jprakash@quicinc.com>
Subject: Re: [PATCH 07/11] iio: adc: Add support for QCOM PMIC5 Gen3 ADC
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC:     Jonathan Cameron <jic23@kernel.org>, <agross@kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linus.walleij@linaro.org>, <Jonathan.Cameron@huawei.com>,
        <sboyd@kernel.org>, <quic_subbaram@quicinc.com>,
        <quic_collinsd@quicinc.com>, <quic_kamalw@quicinc.com>,
        <marijn.suijten@somainline.org>,
        <andriy.shevchenko@linux.intel.com>,
        <krzysztof.kozlowski@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        Ramona Bolboaca <ramona.bolboaca@analog.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        Lee Jones <lee@kernel.org>,
        =?UTF-8?Q?Leonard_G=c3=b6hrs?= <l.goehrs@pengutronix.de>,
        Haibo Chen <haibo.chen@nxp.com>, <linux-iio@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>,
        <linux-arm-msm-owner@vger.kernel.org>
References: <20230708072835.3035398-1-quic_jprakash@quicinc.com>
 <20230708072835.3035398-8-quic_jprakash@quicinc.com>
 <20230708165955.08c1159c@jic23-huawei>
 <13d5dee2-1da4-2ad0-91f8-a53b43adba2b@quicinc.com>
 <CAA8EJprb=804S=GfxPw_7AxoHRO1XzC+wGPCsvNGrRpJgj+y6A@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAA8EJprb=804S=GfxPw_7AxoHRO1XzC+wGPCsvNGrRpJgj+y6A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 385GMTGPE6VVBBer0E3PHCrzfXcbmnY4
X-Proofpoint-GUID: 385GMTGPE6VVBBer0E3PHCrzfXcbmnY4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-15_20,2023-11-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 clxscore=1011 spamscore=0 bulkscore=0
 phishscore=0 mlxscore=0 mlxlogscore=934 priorityscore=1501 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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

Hi Dmitry,

On 10/23/2023 1:33 PM, Dmitry Baryshkov wrote:
> On Mon, 23 Oct 2023 at 09:15, Jishnu Prakash<quic_jprakash@quicinc.com>  wrote:
>> Hi Jonathan,
>>
>> On 7/8/2023 9:29 PM, Jonathan Cameron wrote:
>>> On Sat, 8 Jul 2023 12:58:31 +0530
>>> Jishnu Prakash<quic_jprakash@quicinc.com>  wrote:
> +
>>>> +    return devm_iio_device_register(dev, indio_dev);
>>>> +}
>>>> +
>>>> +static int adc5_gen3_exit(struct platform_device *pdev)
>>>> +{
>>> As you are mixing devm manged cleanup and the explicit sort the
>>> result is that you remove the userspace interfaces 'after' you run
>>> everything in here. I'm thinking disabling the channels at least
>>> isn't a good idea in that case.
>>>
>>> If you want to use devm (which is good) then you need to work out how
>>> to register additional callbacks during probe to tear down everything in
>>> the right order (typically the reverse of what happens in probe)
>>> devm_add_action_or_reset() is the way to add those extra callbacks.
>>>
>>> If not, just don't use devm for at least those bits that will end up
>>> running out of order (such as iio_device_register()) and manually call their
>>> cleanup routines instead.
>> I checked some other examples in the iio/adc/ folder, I think I see what
>> you mean here. It looks like drivers with a remove callback always use
>> iio_device_register and iio_device_unregister instead of the devm_*
>> variant, due to the issue with sysfs removal as you said.
>>
>> I'll update the probe and remove functions similarly, to do explicit
>> cleanups as required, avoiding devm_ usage for places where it should be
>> avoided.
> I think you got the message all wrong. There is nothing bad with using
> devm_. As a matter of fact it is a preferred form in most of the
> cases. However you have to be careful to tear down your device in the
> correct order. And as Jonathan pointed
> out, you might add necessary hooks manually by calling
> devm_add_action_or_reset().
>
> [skipped the rest]

Thanks for your comment. I checked the code again and I think we can do 
the teardown with a devm_add_action() call and drop the remove API 
entirely in favor of using devm_* APIs , I'll update this in the next 
patchset.

Thanks,

Jishnu


>
