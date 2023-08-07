Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D8F377266C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 15:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234298AbjHGNre (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 09:47:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233434AbjHGNrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 09:47:22 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 633F110DB;
        Mon,  7 Aug 2023 06:47:18 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3778a7wG025126;
        Mon, 7 Aug 2023 13:46:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=p+rpL5NjFVV5WSitXR2jia2C5Z06+rZ1kuNE5pQqw7w=;
 b=FmQeFFve0SO2ejC+Uz+TxribeYBOtp9llapgDeg5elVLua60KvNzqohuktnKXOn7GMSk
 rosPmXqoH16nJnPH1Pkg/Qn6I2JGpGzeoY/mO3hfVxsFsnhT86jGiVno5WnNUPpA6PAm
 mQCb0Q22LsDMGrNCRpo2gpBUCE+QiMGCMAPa0gyPjvQKd0LWERQ8oIyLPemwt5LmXcgl
 x9tS0YzvGmGtkmlZChZQ72JbGbbBg0kMl6S2GQgBxGKaYRATopqr2N9eyOOGJRNayQKe
 WBRhSoeS4bEoqqp9Kv5HoMq5XR2DLid/5rTTnYW1zZmnlrWNixT1yL6IdojLwa9YBFow ow== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s9deekmn8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Aug 2023 13:46:56 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 377Dktnj018001
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 7 Aug 2023 13:46:55 GMT
Received: from [10.214.66.81] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Mon, 7 Aug
 2023 06:46:48 -0700
Message-ID: <632c5b97-4a91-c3e8-1e6c-33d6c4f6454f@quicinc.com>
Date:   Mon, 7 Aug 2023 19:16:45 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 00/21] Add Qualcomm Minidump kernel driver related
 support
Content-Language: en-US
From:   Mukesh Ojha <quic_mojha@quicinc.com>
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
 <c0284d98-4cb2-cb78-9123-54d83fc31101@quicinc.com>
In-Reply-To: <c0284d98-4cb2-cb78-9123-54d83fc31101@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Luzsc6SdMQLdX7JpjvPFQ5f6xCkwCQ8m
X-Proofpoint-ORIG-GUID: Luzsc6SdMQLdX7JpjvPFQ5f6xCkwCQ8m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-07_13,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 malwarescore=0 impostorscore=0 spamscore=0 clxscore=1011 mlxlogscore=999
 mlxscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308070128
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/18/2023 8:33 PM, Mukesh Ojha wrote:
> 
> 
> On 7/6/2023 10:50 PM, Mathieu Poirier wrote:
>> On Mon, Jul 03, 2023 at 02:05:58PM -0700, Trilok Soni wrote:
>>> On 7/2/2023 1:29 AM, Krzysztof Kozlowski wrote:
>>>> On 30/06/2023 18:04, Mukesh Ojha wrote:
>>>>>>
>>>>>>> We don't add layers when they are not needed, and never when 
>>>>>>> there is no
>>>>>>> actual user.  If you need the extra "complexity" later, then add it
>>>>>>> later when it is needed as who knows when that will ever be.
>>>>>>>
>>>>>>> Please redo this series based on that, thanks.
>>>>>>
>>>>>> My bigger issue with this whole series is what would this all look
>>>>>> like if every SoC vendor upstreamed their own custom dumping
>>>>>> mechanism. That would be a mess. (I have similar opinions on the
>>>>>> $soc-vendor hypervisors.)
>>>>
>>>> Mukesh,
>>>>
>>>> LPC CFP is still open. There will be also Android and Kernel Debugging
>>>> LPC microconference tracks. Coming with a unified solution could be a
>>>> great topic for LPC. Solutions targeting only one user are quite often
>>>> frowned upon.
>>>
>>> LPC is far out and in November. Can we not have others speak up if 
>>> they have
>>> the similar solution now? We can expand this to linux-kernel and ask 
>>> for the
>>> other SOC vendors to chime in. I am sure that we may have existing 
>>> solutions
>>> which came in for the one user first like Intel RDT if I remember. I 
>>> am sure
>>> ARM MPAM usecase was present at that time but Intel RDT based 
>>> solution which
>>> was x86 specific but accepted.
>>
>> I am not familiar with Intel RDT and Arm MPAM but the community is always
>> improving on the way it does things.
>>
>> LPC is indeed far out in November but it is an opportunity to cover the
>> groundwork needed to have this discussion.  It is always best to 
>> improve on
>> something then introduce something new.  Even better if something 
>> specific such
>> as Intel RDT and Arm MPAM can be made more generic.  A perfect example is
>> hwtracing Linus referred to.  The perf framework wasn't a perfect fit 
>> but it was
>> enhanced to accommodate our requirements.  I suggest to look at what 
>> is currently
>> available and come up with a strategy to be presented at LPC - event 
>> better if
>> you have a prototype.  If you can't find anything or the drawbacks 
>> inherent to
>> each avenue outweigh the benefits then we can have that conversation 
>> at LPC.
> 
> I was checking hwtracing[1] and pmu interface introduction of
> address filtering[3] from analogy point of view, which i think you
> meant that perf framework was extended to accommodate this.
> 
> Minidump is quite different and simple in its way to address the problem
> of debugging on end user devices with minimum data captured to debug 
> crashes and this patch series is inline with similar (core + backend)
> implementation done for stm patches[1] where stm core was developed
> and intel trace hub get hooked into it and later it got reused in [2] by 
> coresight-stm driver.
> 
> I am still exploring if something available we can reuse but it seems 
> unlikely at the moment to already available something in the kernel with
> similar use case.


I explored about kdump and fadump(PPC) but they take another route to 
boot capture kernel, FAdump is even optimized and do not even boot
capture kernel instead reboot the same kernel with minimal
memory and once the reading of crash kernel region is complete
from user space it release the memories.

Latency in booting another kernel may not acceptable to boot time
sensitive devices like mobile, tablet etc., also to boot another
kernel will have security implication with user data..

So, Minidump is limited in its capability and uses firmware infra
to dump registered entries and boot afresh. So, it need to be
presented what need to be dumped via Minidump registration API.

If there is no comments, would like to go ahead with the next
revision of the patchset.

-Mukesh
> 
> -Mukesh
> 
> [1]
> https://lwn.net/Articles/650245/
> 
> [2]
> https://lwn.net/Articles/674201/
> 
> [3]
> https://lore.kernel.org/lkml/1461771888-10409-1-git-send-email-alexander.shishkin@linux.intel.com/
> 
> 
>>
>>>
>>> ---Trilok Soni
