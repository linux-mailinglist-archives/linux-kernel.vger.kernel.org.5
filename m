Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD7C175805F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 17:05:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231848AbjGRPFd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 11:05:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbjGRPFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 11:05:30 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3483510CB;
        Tue, 18 Jul 2023 08:05:29 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36I6REAM009677;
        Tue, 18 Jul 2023 15:03:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=l8jXQmV2PvUFWpCgMtL+9QUJ1C8Jq0rbIFdYtG4s468=;
 b=HQ9Dgbuumrk6U3TYMHXPq+XpXX9aBMnpORf4iEOsVGRbBqub7T8X+mfRSz0DyoLXaIjn
 xkLGBiYDNLsy00U0pnVKVirunJmzSzCLpz3rp4dAHEIqpNKSlGQ19d+FUgDiJnxxGA7i
 nLBhulwd1tMkmF2XEFKUBXnAtLsOVY8ljQGFD7eM4JzaZ+y9RRs1U0N4gXLwkTuxbtDK
 ALjGS3NomUPnCVtonoSLZq2+59J3WycjQbkdM3LY/4L7I/ZVFzCbJRFUhXoqexqHtiQ4
 0D9Q4nBsNOViMtNAXINSLB6ynVIz/koB8TI4dTE3JuAJnt+SA0str0xN8Wp62oQ1HUOA ug== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rwfj79vw4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Jul 2023 15:03:59 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36IF3wiL010970
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Jul 2023 15:03:58 GMT
Received: from [10.216.47.173] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Tue, 18 Jul
 2023 08:03:49 -0700
Message-ID: <c0284d98-4cb2-cb78-9123-54d83fc31101@quicinc.com>
Date:   Tue, 18 Jul 2023 20:33:44 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 00/21] Add Qualcomm Minidump kernel driver related
 support
Content-Language: en-US
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Trilok Soni <quic_tsoni@quicinc.com>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>, <corbet@lwn.net>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <keescook@chromium.org>,
        <tony.luck@intel.com>, <gpiccoli@igalia.com>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <linus.walleij@linaro.org>, <andy.shevchenko@gmail.com>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-hardening@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-gpio@vger.kernel.org>, Alex Elder <elder@linaro.org>
References: <1687955688-20809-1-git-send-email-quic_mojha@quicinc.com>
 <2023062814-chance-flounder-f002@gregkh>
 <CAL_JsqLO9yey2-4FcWsaGxijiS6hGL0SH9VoMuiyei-u9=Cv=w@mail.gmail.com>
 <cc30660f-dd72-aade-6346-a93c6ad4b695@quicinc.com>
 <29af84dc-7db8-0c43-07b6-eb743cf25e57@linaro.org>
 <957a3cdb-6091-8679-ddb0-296db2347291@quicinc.com> <ZKb3wz2eXS6h1yIW@p14s>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <ZKb3wz2eXS6h1yIW@p14s>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 5wVB4_xXDRj5tnrwuwAq9UgRU4sEv_dd
X-Proofpoint-ORIG-GUID: 5wVB4_xXDRj5tnrwuwAq9UgRU4sEv_dd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-18_11,2023-07-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 mlxlogscore=999 impostorscore=0 clxscore=1011 phishscore=0 spamscore=0
 lowpriorityscore=0 priorityscore=1501 mlxscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307180138
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/6/2023 10:50 PM, Mathieu Poirier wrote:
> On Mon, Jul 03, 2023 at 02:05:58PM -0700, Trilok Soni wrote:
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
>> LPC is far out and in November. Can we not have others speak up if they have
>> the similar solution now? We can expand this to linux-kernel and ask for the
>> other SOC vendors to chime in. I am sure that we may have existing solutions
>> which came in for the one user first like Intel RDT if I remember. I am sure
>> ARM MPAM usecase was present at that time but Intel RDT based solution which
>> was x86 specific but accepted.
> 
> I am not familiar with Intel RDT and Arm MPAM but the community is always
> improving on the way it does things.
> 
> LPC is indeed far out in November but it is an opportunity to cover the
> groundwork needed to have this discussion.  It is always best to improve on
> something then introduce something new.  Even better if something specific such
> as Intel RDT and Arm MPAM can be made more generic.  A perfect example is
> hwtracing Linus referred to.  The perf framework wasn't a perfect fit but it was
> enhanced to accommodate our requirements.  I suggest to look at what is currently
> available and come up with a strategy to be presented at LPC - event better if
> you have a prototype.  If you can't find anything or the drawbacks inherent to
> each avenue outweigh the benefits then we can have that conversation at LPC.

I was checking hwtracing[1] and pmu interface introduction of
address filtering[3] from analogy point of view, which i think you
meant that perf framework was extended to accommodate this.

Minidump is quite different and simple in its way to address the problem
of debugging on end user devices with minimum data captured to debug 
crashes and this patch series is inline with similar (core + backend)
implementation done for stm patches[1] where stm core was developed
and intel trace hub get hooked into it and later it got reused in [2] by 
coresight-stm driver.

I am still exploring if something available we can reuse but it seems 
unlikely at the moment to already available something in the kernel with
similar use case.

-Mukesh

[1]
https://lwn.net/Articles/650245/

[2]
https://lwn.net/Articles/674201/

[3]
https://lore.kernel.org/lkml/1461771888-10409-1-git-send-email-alexander.shishkin@linux.intel.com/


> 
>>
>> ---Trilok Soni
