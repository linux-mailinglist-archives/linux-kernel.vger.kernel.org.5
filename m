Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 074C57C78D2
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 23:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442942AbjJLVvZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 17:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442945AbjJLVvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 17:51:22 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F09CBB;
        Thu, 12 Oct 2023 14:51:20 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39CLbjch027956;
        Thu, 12 Oct 2023 21:51:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=voUltIrLrhXdVJp9/yCwFFwFBu2KkCyxDDIWBrI4Xog=;
 b=HjSHOCagbHCB6bOReW+vqK+Dfm07myfSFl8yPtmClixpKCcx4C5UnnqZmJp4EkkrDlGk
 sDingmngYmPHq+uM3HBBqPVeQGzhUBBMSXXi3SA5X0kNnLJQP6XLfqhUZ1vUA3G+umcu
 gEnsitEU8Llg9JgShMHxB3a5DvlmHMEYr5M5u84mB7GEvxhxzAQTFiqgJF+aWHmqIvr2
 9/U+wcedGEb8KGNxTmqgyc7htL3M+bz8iq1TCdvyJkUU1ehqhGC3hPkWpIqnJq0Xm8vL
 1+bDS61NU97RlA6x7NV16IlgORC6blhN3ETupnnFsJrRxkKbilBOeheB+98R4nhkHEJx pQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tnsmq4h32-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Oct 2023 21:51:03 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39CLp1Wo011405
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Oct 2023 21:51:01 GMT
Received: from [10.110.43.201] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Thu, 12 Oct
 2023 14:50:59 -0700
Message-ID: <a2781978-2081-f4cb-dfe3-0489860dab8e@quicinc.com>
Date:   Thu, 12 Oct 2023 14:50:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v5 0/7] Add support for LUT PPG
Content-Language: en-US
To:     Luca Weiss <luca.weiss@fairphone.com>, <pavel@ucw.cz>,
        <lee@kernel.org>, <thierry.reding@gmail.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <agross@kernel.org>, <andersson@kernel.org>
CC:     <konrad.dybcio@linaro.org>, <u.kleine-koenig@pengutronix.de>,
        <quic_subbaram@quicinc.com>, <quic_gurus@quicinc.com>,
        <linux-leds@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-pwm@vger.kernel.org>, <kernel@quicinc.com>
References: <20230929003901.15086-1-quic_amelende@quicinc.com>
 <CVX5ZUGU9BVE.2TA819U1AI6BZ@otso>
From:   Anjelique Melendez <quic_amelende@quicinc.com>
In-Reply-To: <CVX5ZUGU9BVE.2TA819U1AI6BZ@otso>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: PeOLq1QMggphqx9nLudVIdQ5iZgaUs-J
X-Proofpoint-ORIG-GUID: PeOLq1QMggphqx9nLudVIdQ5iZgaUs-J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-12_14,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 mlxlogscore=999 lowpriorityscore=0 adultscore=0 priorityscore=1501
 impostorscore=0 spamscore=0 bulkscore=0 clxscore=1011 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310120183
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/1/2023 7:15 AM, Luca Weiss wrote:
> On Fri Sep 29, 2023 at 2:38 AM CEST, Anjelique Melendez wrote:
>> In certain PMICs, LUT pattern and LPG configuration is stored in SDAM
>> modules instead of LUT peripheral. This feature is called PPG.
>>
>> This change series adds support for PPG. Thanks!
[..]
>>
>> Tested-by: Luca Weiss <luca.weiss@fairphone.com> # sdm632-fairphone-fp3 (pmi632)
> 
> Hi Anjelique,
> 
> Actually I've retested this now on PMI632 (and also realized that my
> previous tests weren't correct and wasn't actually using hw_pattern).
> 
> Using the following commands (after boot) I'm expecting to get a
> 500ms on 500ms off blinking pattern between white (255 255 255) and off
> (0 0 0).
> 
>   echo pattern > /sys/class/leds/rgb:status/trigger
>   echo -1 > /sys/class/leds/rgb:status/repeat
> 
>   echo "255 255 255" > /sys/class/leds/rgb:status/multi_intensity
>   echo "255 500 255 0 0 500 0 0" > /sys/class/leds/rgb:status/hw_pattern
> 
> What I actually see is it blinking between cyan (0 255 255) and red (255
> 0 0).
> At some point after playing with many patterns I got it to actually
> cycle between white and off, but I couldn't reproduce this again (or I
> didn't try hard enough).
> 
> 
> But with this example it correctly blinks red on-off.
> 
>   echo "255 0 0" > /sys/class/leds/rgb:status/multi_intensity
>   echo "255 500 255 0 0 500 0 0" > /sys/class/leds/rgb:status/hw_pattern
> 
> With "0 255 0" and "0 0 255" the other colors also work fine, it's just
> the combinations that seem somewhat broken.
> 
> Regards
> Luca
> 
> 
Hi Luca,

Thanks for testing again and the feedback!
Looks like for multicolor devices there is a small concurrency issue with
enabling pattern at the same time for all the led channels. This could be
why you observed your device blinking between red (255 0 0) and cyan (0 255 255),
instead of seeing all channels (255 255 255) blink.
The fix I'm planing to include in the next series is is to disable the multicolor led
channels first, then configure all channels, and finally re-enable channels
so that pattern is triggered at the same time for each all of the channels.

I am currently testing with pm8350c device so if you are able to test next series
on pmi632 it would be very appreciated!

Thanks,
Anjelique
