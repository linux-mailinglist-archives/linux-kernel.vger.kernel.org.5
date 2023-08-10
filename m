Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5686777E9B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 18:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234597AbjHJQtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 12:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjHJQtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 12:49:00 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C6B910C4;
        Thu, 10 Aug 2023 09:49:00 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37A722FV007831;
        Thu, 10 Aug 2023 16:47:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=zAuUK+FUAKV1TK/43Krl8I0W9ZUqbAWCf5CKaQkFMEs=;
 b=T2IWYsPH96HEItjOrzS28ONVuqktQ1xJYBi+VdIlEwkue4tsysm4O15YHDEIltQtuzkl
 aIrz4TQfz/MEyQ+aoNqu2znZ6Xuin0QFfcPFcBet+ZGb9tGdTHtiVTw+GbNOmYzO5AGG
 xo+OXMFEfmuraggReqkwazE7OP5+Ze870eQBjEqnyBb6txyeJ8hWysxkInpZv9hsWnxC
 bpq9z0FUAhNRpxizqs+rFl/J/6+zxs+H0K3wGcgvrXSIazOFNXkEmHr3Jc1NNvjNtEAG
 WMTRYy/5Vb8JVBoc0jpj8FhtoXo3mS51IQroc4MlqYbqHlWpqJRsRO3BR/+TOtKLZG72 MQ== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3scbd4k5kh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Aug 2023 16:47:59 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37AGlwu8003647
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Aug 2023 16:47:58 GMT
Received: from [10.216.45.127] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Thu, 10 Aug
 2023 09:47:50 -0700
Message-ID: <695133e6-105f-de2a-5559-555cea0a0462@quicinc.com>
Date:   Thu, 10 Aug 2023 22:17:47 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 00/21] Add Qualcomm Minidump kernel driver related
 support
Content-Language: en-US
To:     Rob Herring <robh+dt@kernel.org>,
        Trilok Soni <quic_tsoni@quicinc.com>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Greg KH <gregkh@linuxfoundation.org>, <corbet@lwn.net>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <keescook@chromium.org>,
        <tony.luck@intel.com>, <gpiccoli@igalia.com>,
        <mathieu.poirier@linaro.org>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <linus.walleij@linaro.org>,
        <andy.shevchenko@gmail.com>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-hardening@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-gpio@vger.kernel.org>, "Alex Elder" <elder@linaro.org>
References: <1687955688-20809-1-git-send-email-quic_mojha@quicinc.com>
 <2023062814-chance-flounder-f002@gregkh>
 <CAL_JsqLO9yey2-4FcWsaGxijiS6hGL0SH9VoMuiyei-u9=Cv=w@mail.gmail.com>
 <cc30660f-dd72-aade-6346-a93c6ad4b695@quicinc.com>
 <29af84dc-7db8-0c43-07b6-eb743cf25e57@linaro.org>
 <957a3cdb-6091-8679-ddb0-296db2347291@quicinc.com>
 <CAL_JsqK7MHR09U5h01=Gf1ZLeDVCgZdN-W1hQRH3AX+E94_uUg@mail.gmail.com>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <CAL_JsqK7MHR09U5h01=Gf1ZLeDVCgZdN-W1hQRH3AX+E94_uUg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: L6jmcWyk6X3XoJP6P5sO18G5atidhdNt
X-Proofpoint-ORIG-GUID: L6jmcWyk6X3XoJP6P5sO18G5atidhdNt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-10_14,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 phishscore=0 bulkscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0
 adultscore=0 mlxlogscore=999 impostorscore=0 priorityscore=1501 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308100144
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/6/2023 11:10 PM, Rob Herring wrote:
> On Mon, Jul 3, 2023 at 3:06 PM Trilok Soni <quic_tsoni@quicinc.com> wrote:
>>
>> On 7/2/2023 1:29 AM, Krzysztof Kozlowski wrote:
>>> On 30/06/2023 18:04, Mukesh Ojha wrote:
>>>>>
>>>>>> We don't add layers when they are not needed, and never when there is no
>>>>>> actual user.  If you need the extra "complexity" later, then add it
>>>>>> later when it is needed as who knows when that will ever be.
>>>>>>
>>>>>> Please redo this series based on that, thanks.
>>>>>
>>>>> My bigger issue with this whole series is what would this all look
>>>>> like if every SoC vendor upstreamed their own custom dumping
>>>>> mechanism. That would be a mess. (I have similar opinions on the
>>>>> $soc-vendor hypervisors.)
>>>
>>> Mukesh,
>>>
>>> LPC CFP is still open. There will be also Android and Kernel Debugging
>>> LPC microconference tracks. Coming with a unified solution could be a
>>> great topic for LPC. Solutions targeting only one user are quite often
>>> frowned upon.
>>
>> LPC is far out and in November. Can we not have others speak up if they
>> have the similar solution now? We can expand this to linux-kernel and
>> ask for the other SOC vendors to chime in. I am sure that we may have
>> existing solutions which came in for the one user first like Intel RDT
>> if I remember. I am sure ARM MPAM usecase was present at that time but
>> Intel RDT based solution which was x86 specific but accepted.
> 
> RDT predated MPAM. resctrl is the kernel feature, and it supports
> Intel and AMD which are not identical. resctrl is being (extensively)
> refactored to add in MPAM support.
> 
> You are not the first here like Intel RDT, so I fail to see the
> parallel with minidump. We have an existing logging to persistent
> storage mechanism which is pstore. You should integrate into that
> rather than grafting something on to the side or underneath.

Most of the Qualcomm SoCs does not support *warm boot* and that is the
base requirement for pstore(ram) to work to preserve the content of
fixed region during the reboot. So, it will not work those SOCs.

Minidump in its capability can do more than what is available
through pstore, it can dump ramoops region as one of data point
for debugging but it can dump anything given the size and address.

We can make minidump it another backend of pstore(ram), and improve
pstore with more debug data collection during panic like timer data or 
irqstats etc. which was our final goal with minidump that way pstore
also gets benefit and minidump will just collect what is there in
pstore(ram). but for that we need base infrastructure driver to
merge.

One of the proposal made here..
https://lore.kernel.org/lkml/1683561060-2197-1-git-send-email-quic_mojha@quicinc.com/

-Mukesh
> 
> Rob
