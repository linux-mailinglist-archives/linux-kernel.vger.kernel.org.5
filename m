Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F57378EFBA
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 16:44:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345890AbjHaOoL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 10:44:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345449AbjHaOoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 10:44:08 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A24E71B1;
        Thu, 31 Aug 2023 07:44:05 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37VAbeoD018388;
        Thu, 31 Aug 2023 14:43:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=p7l318Sl2nLKRUHc57tXS6XzkNyECHMFWb2IAHq0GZs=;
 b=J2nDQlo+snL0CebkK8XwWZQavxZRYT5Qnw9wr1IEaulPhAMA9IT9HUHKetuBhflb0zVI
 mBJ4ntsXBY4jVSSaQ/QfEJXAmY8StpDyeDP/4GEBwd6WLymItIdeVvIj6ltNfryKWX4L
 p2HZgOixFMF0B3WkEnWfRofZl/iKePjeZ4C/Joir2Got7Kqq3lhR7Aps+eD3a0DL8zWm
 02K7wX/1eGnS/YbcOYFCX2za8rnh9cAp+aQSKAn0a/2RYVm/fcM5xFIlvEUZ5E3reRmh
 JDfiUUQsJIY4KrB8+wDdII2eOR+wcQkNE9FuU7Nlg+9d0kk+GPktshl6hZOWMLxh3gOh QA== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3st28abgb1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 31 Aug 2023 14:43:33 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37VEhXrD007757
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 31 Aug 2023 14:43:33 GMT
Received: from [10.216.37.211] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Thu, 31 Aug
 2023 07:43:29 -0700
Message-ID: <b096db3b-bb2b-5146-9b75-bcc57ae318b0@quicinc.com>
Date:   Thu, 31 Aug 2023 20:13:25 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 2/4] firmware: qcom_scm: disable SDI if required
Content-Language: en-US
To:     Robert Marko <robimarko@gmail.com>
CC:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <quic_gurus@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <computersforpeace@gmail.com>
References: <20230816164641.3371878-1-robimarko@gmail.com>
 <20230816164641.3371878-2-robimarko@gmail.com>
 <ff9ec6f5-9c7c-546b-5814-159d7e2843a8@quicinc.com>
 <CAOX2RU7wbZopGErQ71frXFMz4+Y9QU6SjfrYbZPT_3yd0gU73A@mail.gmail.com>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <CAOX2RU7wbZopGErQ71frXFMz4+Y9QU6SjfrYbZPT_3yd0gU73A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: bSNMNJb8QpDGIpuU0Rwk3wR-IPDs7x3J
X-Proofpoint-GUID: bSNMNJb8QpDGIpuU0Rwk3wR-IPDs7x3J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-31_12,2023-08-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 phishscore=0 malwarescore=0 impostorscore=0
 suspectscore=0 spamscore=0 adultscore=0 bulkscore=0 mlxlogscore=999
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308310131
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/25/2023 3:11 PM, Robert Marko wrote:
> On Tue, 22 Aug 2023 at 17:38, Mukesh Ojha <quic_mojha@quicinc.com> wrote:
>>
>>
>>
>> On 8/16/2023 10:15 PM, Robert Marko wrote:
>>> IPQ5018 has SDI (Secure Debug Image) enabled by TZ by default, and that
>>> means that WDT being asserted or just trying to reboot will hang the board
>>> in the debug mode and only pulling the power and repowering will help.
>>> Some IPQ4019 boards like Google WiFI have it enabled as well.
>>>
>>> Luckily, SDI can be disabled via an SCM call.
>>>
>>> So, lets use the boolean DT property to identify boards that have SDI
>>> enabled by default and use the SCM call to disable SDI during SCM probe.
>>> It is important to disable it as soon as possible as we might have a WDT
>>> assertion at any time which would then leave the board in debug mode,
>>> thus disabling it during SCM removal is not enough.
>>>
>>> Signed-off-by: Robert Marko <robimarko@gmail.com>
>>> ---
>>> Changes in v3:
>>> * Squashed ("firmware: qcom: scm: Add SDI disable support") and
>>> ("firmware: qcom_scm: disable SDI if required")
>>> ---
>>>    drivers/firmware/qcom_scm.c | 29 +++++++++++++++++++++++++++++
>>>    drivers/firmware/qcom_scm.h |  1 +
>>>    2 files changed, 30 insertions(+)
>>>
>>> diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
>>> index 06fe8aca870d..de9d1a11d097 100644
>>> --- a/drivers/firmware/qcom_scm.c
>>> +++ b/drivers/firmware/qcom_scm.c
>>> @@ -403,6 +403,29 @@ int qcom_scm_set_remote_state(u32 state, u32 id)
>>>    }
>>>    EXPORT_SYMBOL_GPL(qcom_scm_set_remote_state);
>>>
>>> +static int qcom_scm_disable_sdi(void)
>>> +{
>>> +     int ret;
>>> +     struct qcom_scm_desc desc = {
>>> +             .svc = QCOM_SCM_SVC_BOOT,
>>> +             .cmd = QCOM_SCM_BOOT_SDI_CONFIG,
>>> +             .args[0] = 1, /* Disable watchdog debug */
>>> +             .args[1] = 0, /* Disable SDI */
>>> +             .arginfo = QCOM_SCM_ARGS(2),
>>> +             .owner = ARM_SMCCC_OWNER_SIP,
>>> +     };
>>> +     struct qcom_scm_res res;
>>> +
>>> +     ret = qcom_scm_clk_enable();
>>> +     if (ret)
>>> +             return ret;
>>> +     ret = qcom_scm_call(__scm->dev, &desc, &res);
>>
>> Would you not be wanting this call to be atomic ?
> 
> This is implemented based off the downstream 5.4 kernel as I dont have
> the SCM docs
> so I dont know if its even supported in the atomic version.

Ok,.

Well, Kernel version does not guarantees us whether certain things
are supported or not in the firmware and it is not bound to any
particular firmware version;

So, whatever firmware version it is running with, we should try to
support.

Should we implement certain kind of call, if fastcall(atomic) is 
supported go-ahead otherwise fallback to slowcalls (interruptible)
calls, but this is completely out of the context of this patch.

>>
>>> +
>>> +     qcom_scm_clk_disable();
>>> +
>>> +     return ret ? : res.result[0];
>>> +}
>>> +
>>>    static int __qcom_scm_set_dload_mode(struct device *dev, bool enable)
>>>    {
>>>        struct qcom_scm_desc desc = {
>>> @@ -1468,6 +1491,12 @@ static int qcom_scm_probe(struct platform_device *pdev)
>>>        if (download_mode)
>>>                qcom_scm_set_download_mode(true);
>>>
>>> +     /*
>>> +      * Disable SDI if indicated by DT that it is enabled by default.
>>> +      */
>>> +     if (of_property_read_bool(pdev->dev.of_node, "qcom,sdi-enabled"))
>>> +             qcom_scm_disable_sdi();
>>
>> Why don't we do this call in qcom_scm_shutdown()
>> also does it not conflict with above download_mode
>> we have enabled download mode but disabling SDI
>> means (hard reset) and will not be collecting
>> crash dump?
> 
> Because doing it in SCM removal is too late, what if we have a WDT
> assertion and not a
> regular reboot?
> It would mean that the board will get stuck in the debug mode which is
> not useful for users and
> requires the power to be pulled in order to boot normally again.

Agree.

Just a wild guess..

Can we check if this call __qcom_scm_is_call_available() helps
to determine, if the certain soc has this SCM calls supported
and if it is there it can be disabled.

__qcom_scm_is_call_available(__scm->dev, QCOM_SCM_SVC_BOOT, 
QCOM_SCM_BOOT_SDI_CONFIG)

> 
> I am not sure about the download mode, this is where insight from QCA
> really help as I am
> doing this with very limited docs.

Download mode would not be reflected unless it is debug
board, whatever you write will not be allowed if it is a
secure device.

-Mukesh
> 
> Regards,
> Robert
>>
>> -Mukesh
>>
>>> +
>>>        return 0;
>>>    }
>>>
>>> diff --git a/drivers/firmware/qcom_scm.h b/drivers/firmware/qcom_scm.h
>>> index e6e512bd57d1..7b68fa820495 100644
>>> --- a/drivers/firmware/qcom_scm.h
>>> +++ b/drivers/firmware/qcom_scm.h
>>> @@ -80,6 +80,7 @@ extern int scm_legacy_call(struct device *dev, const struct qcom_scm_desc *desc,
>>>    #define QCOM_SCM_SVC_BOOT           0x01
>>>    #define QCOM_SCM_BOOT_SET_ADDR              0x01
>>>    #define QCOM_SCM_BOOT_TERMINATE_PC  0x02
>>> +#define QCOM_SCM_BOOT_SDI_CONFIG     0x09
>>>    #define QCOM_SCM_BOOT_SET_DLOAD_MODE        0x10
>>>    #define QCOM_SCM_BOOT_SET_ADDR_MC   0x11
>>>    #define QCOM_SCM_BOOT_SET_REMOTE_STATE      0x0a
