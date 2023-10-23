Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47A6F7D41FC
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 23:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231352AbjJWVzo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 17:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbjJWVzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 17:55:42 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41DDA98;
        Mon, 23 Oct 2023 14:55:40 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39NJdt1X002491;
        Mon, 23 Oct 2023 21:54:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=hVa/mq2VQpyWbZU8AbMbE350it4l72isr/X7+dQsCVw=;
 b=WRksQS2ghff9LS+dck6Eb9LoSUZajKXQPzLoN0iBfuMrRhwp9+whWjZLG9kV2ZI0bq84
 BkICQs1jVcdFakCj/zkMJUHVeHEwhCS3XBgSSmE4DCyRD+XJxCWadFRbSO0upGibuy9M
 dxxApoyvDi9By5YP6R5SoPb7fKm4z7Mpl1b4vNX4Z/+gluYx3X/5f+F5n/DZ3qH6KbZM
 f9O2u8AK+hAK7QJHcFqCOdMXgh09FxnTL/LpsSaN9syXq9cB4wbPDtSvpeezjmOU2zsM
 j33mz0FYjGZUPgfX1ogdrb5icHmvjIKa5KCc9NqHXO8d/m9luRO9RmrzGjedjf/EYRHe EQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tv40ungua-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Oct 2023 21:54:57 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39NLsupN031852
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Oct 2023 21:54:56 GMT
Received: from [10.110.22.156] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Mon, 23 Oct
 2023 14:54:55 -0700
Message-ID: <6409c486-7393-4352-489c-ecd488597c4c@quicinc.com>
Date:   Mon, 23 Oct 2023 14:54:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v9 34/34] ASoC: usb: Rediscover USB SND devices on USB
 port add
Content-Language: en-US
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        <mathias.nyman@intel.com>, <gregkh@linuxfoundation.org>,
        <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <srinivas.kandagatla@linaro.org>, <bgoswami@quicinc.com>,
        <Thinh.Nguyen@synopsys.com>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <alsa-devel@alsa-project.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>
References: <20231017200109.11407-1-quic_wcheng@quicinc.com>
 <20231017200109.11407-35-quic_wcheng@quicinc.com>
 <b503058d-e23f-4a63-99b8-f0a62b2a2557@linux.intel.com>
From:   Wesley Cheng <quic_wcheng@quicinc.com>
In-Reply-To: <b503058d-e23f-4a63-99b8-f0a62b2a2557@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 3O20EUy7dwzYWHIPEZCZdjjATpyogG3y
X-Proofpoint-ORIG-GUID: 3O20EUy7dwzYWHIPEZCZdjjATpyogG3y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-23_21,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 phishscore=0 adultscore=0 clxscore=1015 spamscore=0 suspectscore=0
 impostorscore=0 priorityscore=1501 malwarescore=0 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310230192
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pierre,

On 10/17/2023 4:11 PM, Pierre-Louis Bossart wrote:
> 
> 
> On 10/17/23 15:01, Wesley Cheng wrote:
>> In case the USB backend device has not been initialized/probed, USB SND
>> device connections can still occur.  When the USB backend is eventually
>> made available, previous USB SND device connections are not communicated to
>> the USB backend.  Call snd_usb_rediscover_devices() to generate the connect
>> callbacks for all USB SND devices connected.  This will allow for the USB
>> backend to be updated with the current set of devices available.
>>
>> The chip array entries are all populated and removed while under the
>> register_mutex, so going over potential race conditions:
>>
>> Thread#1:
>>    q6usb_component_probe()
>>      --> snd_soc_usb_add_port()
>>        --> snd_usb_rediscover_devices()
>>          --> mutex_lock(register_mutex)
>>
>> Thread#2
>>    --> usb_audio_disconnect()
>>      --> mutex_lock(register_mutex)
>>
>> So either thread#1 or thread#2 will complete first.  If
>>
>> Thread#1 completes before thread#2:
>>    SOC USB will notify DPCM backend of the device connection.  Shortly
>>    after, once thread#2 runs, we will get a disconnect event for the
>>    connected device.
>>
>> Thread#2 completes before thread#1:
>>    Then during snd_usb_rediscover_devices() it won't notify of any
>>    connection for that particular chip index.
> Looks like you are assuming the regular USB audio stuff is probed first?
> 
> What if it's not the case? Have you tested with a manual 'blacklist' and
> "modprobe" sequence long after all the DSP stuff is initialized?
> 
> It really reminds me of audio+display issues, and the same opens apply IMHO.

Not necessarily...if the USB audio driver is not probed, then that is 
the same scenario as when there is no USB audio capable device plugged 
in, while the offload path is waiting for the connect event. I think 
this is the standard scenario.

In the situation where the platform sound card hasn't probed yet and USB 
audio devices are being identified, then that is basically the scenario 
that would be more of an issue, since its USB SND that notifies of the 
connection state (at the time of connect/disconnect).

I've tried with building these drivers as modules and probing them at 
different times/sequences, and I haven't seen an issue so far.

Thanks
Wesley Cheng
