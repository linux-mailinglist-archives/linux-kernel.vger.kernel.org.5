Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D85D79B696
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347878AbjIKVZW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237931AbjIKNXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 09:23:11 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19A8912A;
        Mon, 11 Sep 2023 06:23:07 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38BCrlmO016521;
        Mon, 11 Sep 2023 13:22:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=R6/RHIDNrYpB6dU4Qi6RuA4BpfNijF7rWGsQ9YQ01Po=;
 b=VleQknlxy6TXagkecGv67hfIyDV+0xg+oD5olUlv/qNnzonfRnfNfm6YTvKzflYhktmv
 asurtjRJdtwkC+Fi5DL+AAY4coi/3WfjSy+QTAehOlggWMJXHg+I3MeZBNK0RSIp11YC
 BOtLZt6r+OVUj+vHywIFQCgAYAHw05gTLJOvwBAhqmcev4L+akfXtcmwKkFZ0vfO5LjY
 eCrmoGJPeH8lTOXNlIfHbYmUFuBIGkCwHeWhK/MWfwlKgWvp3qvnc1thMEVvwMjoGXLU
 Tn2ZvRzY+pkswzS9BwpH9UmpGW3wgn/pg3VLLNY3FgW7eb9UJ1ZWBPDfCOeAz1B+sa5X 8Q== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t22kpg4g9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Sep 2023 13:22:57 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38BDMuBU001025
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Sep 2023 13:22:56 GMT
Received: from [10.216.10.2] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Mon, 11 Sep
 2023 06:22:51 -0700
Message-ID: <1f96396a-558b-2272-3a71-04ed7878728a@quicinc.com>
Date:   Mon, 11 Sep 2023 18:52:46 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 2/4] firmware: qcom_scm: disable SDI if required
Content-Language: en-US
To:     Sricharan Ramabadhran <quic_srichara@quicinc.com>,
        Robert Marko <robimarko@gmail.com>
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
 <b096db3b-bb2b-5146-9b75-bcc57ae318b0@quicinc.com>
 <005459a2-8daf-1c84-0309-7dd028652909@quicinc.com>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <005459a2-8daf-1c84-0309-7dd028652909@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ZhUf0EEa9LgWl0l9oLiOJiC5n5dCz3s3
X-Proofpoint-GUID: ZhUf0EEa9LgWl0l9oLiOJiC5n5dCz3s3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-11_08,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 mlxlogscore=999
 spamscore=0 clxscore=1015 phishscore=0 suspectscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309110122
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/7/2023 12:02 PM, Sricharan Ramabadhran wrote:
> 
> <snip ..>
> 
>>>>> +     int ret;
>>>>> +     struct qcom_scm_desc desc = {
>>>>> +             .svc = QCOM_SCM_SVC_BOOT,
>>>>> +             .cmd = QCOM_SCM_BOOT_SDI_CONFIG,
>>>>> +             .args[0] = 1, /* Disable watchdog debug */
>>>>> +             .args[1] = 0, /* Disable SDI */
>>>>> +             .arginfo = QCOM_SCM_ARGS(2),
>>>>> +             .owner = ARM_SMCCC_OWNER_SIP,
>>>>> +     };
>>>>> +     struct qcom_scm_res res;
>>>>> +
>>>>> +     ret = qcom_scm_clk_enable();
>>>>> +     if (ret)
>>>>> +             return ret;
>>>>> +     ret = qcom_scm_call(__scm->dev, &desc, &res);
>>>>
>>>> Would you not be wanting this call to be atomic ?
>>>
>>> This is implemented based off the downstream 5.4 kernel as I dont have
>>> the SCM docs
>>> so I dont know if its even supported in the atomic version.
>>
>> Ok,.
>>
>> Well, Kernel version does not guarantees us whether certain things
>> are supported or not in the firmware and it is not bound to any
>> particular firmware version;
>>
>> So, whatever firmware version it is running with, we should try to
>> support.
>>
>> Should we implement certain kind of call, if fastcall(atomic) is 
>> supported go-ahead otherwise fallback to slowcalls (interruptible)
>> calls, but this is completely out of the context of this patch.
>>
> 
>   I replied on older thread, was not in CC here, just saw this.
> 
>   Agree, atomic api is out of this context and we could take it up
>   separately.
> 
>>>>
>>>>> +
>>>>> +     qcom_scm_clk_disable();
>>>>> +
>>>>> +     return ret ? : res.result[0];
>>>>> +}
>>>>> +
>>>>>    static int __qcom_scm_set_dload_mode(struct device *dev, bool 
>>>>> enable)
>>>>>    {
>>>>>        struct qcom_scm_desc desc = {
>>>>> @@ -1468,6 +1491,12 @@ static int qcom_scm_probe(struct 
>>>>> platform_device *pdev)
>>>>>        if (download_mode)
>>>>>                qcom_scm_set_download_mode(true);
>>>>>
>>>>> +     /*
>>>>> +      * Disable SDI if indicated by DT that it is enabled by default.
>>>>> +      */
>>>>> +     if (of_property_read_bool(pdev->dev.of_node, 
>>>>> "qcom,sdi-enabled"))
>>>>> +             qcom_scm_disable_sdi();
>>>>
>>>> Why don't we do this call in qcom_scm_shutdown()
>>>> also does it not conflict with above download_mode
>>>> we have enabled download mode but disabling SDI
>>>> means (hard reset) and will not be collecting
>>>> crash dump?
>>>
>>> Because doing it in SCM removal is too late, what if we have a WDT
>>> assertion and not a
>>> regular reboot?
>>> It would mean that the board will get stuck in the debug mode which is
>>> not useful for users and
>>> requires the power to be pulled in order to boot normally again.
>>
>> Agree.
> 
>   For IPQ chipsets, SDI bit is used like below,
> 
>     For abnormal resets (like WDT), should be set '1' for valid dump
>     collection.
> 
>     For reboot, should be cleared to '0' to avoid dump collection which
>     is not required in this case.
> 
>     For HLOS panic, is a don't care, dumps always get collected and
>     firmware takes care of clearing the SDI bit.
> 
>     Mukesh,  Can you confirm if its same for msm also ?

Yes, it is same in MSM as well.

-Mukesh

>>
>> Just a wild guess..
>>
>> Can we check if this call __qcom_scm_is_call_available() helps
>> to determine, if the certain soc has this SCM calls supported
>> and if it is there it can be disabled.
>>
>> __qcom_scm_is_call_available(__scm->dev, QCOM_SCM_SVC_BOOT, 
>> QCOM_SCM_BOOT_SDI_CONFIG)
>>
> 
>   Yes, as i mentioned in other thread, checking using
>   qcom_scm_is_call_available is better. That said, would require
>   testing on all IPQ/MSM socs to confirm if firmware supports it.
> 
>>>
>>> I am not sure about the download mode, this is where insight from QCA
>>> really help as I am
>>> doing this with very limited docs.
>>
>> Download mode would not be reflected unless it is debug
>> board, whatever you write will not be allowed if it is a
>> secure device.
>>
> 
>    Yes, 'download mode' bit is similar, but that is used by the firmware
>    to determining whether to collect dumps on non-secure boards.
>    Specifically, 'SDI bit' on some socs is used by firmware to determine
>    if boot is happening from a 'abnormal crash', hence put DDR to
>    self-refresh etc for valid dumps.
> 
> Regards,
>   Sricharan
