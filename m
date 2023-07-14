Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0C7475457C
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 01:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbjGNXqb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 19:46:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjGNXq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 19:46:28 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D24813A93;
        Fri, 14 Jul 2023 16:46:27 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36ELlPJL013025;
        Fri, 14 Jul 2023 23:45:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=wUjJXOLQQaP2ZEAprH4fQWl8uZ95OgFaQHeNSlopaBw=;
 b=jC/Ci3XaraVH2SUoMHwH/1LRum615P+g1b1DbzCpu8GEeJWjXs/J8ix+SyPJ2TplrYxC
 MhVHOcWoa5KRwaRsgcB3YLcQNUyHB1qRE1PW7rwWnedwQrZ/YnHEt8SmlKXYJKE/BQnz
 GtWuHs99WiWILPkSZYGoj2HMS2YqeeEv1n7rJvqwwN3qZ6PkKbMkVwRafw99JmYaLzbb
 9Ha6B7t1CvrCkQuBBECDi1K7XCRId7y8rNU4peMiSr02JsRtxlFR0WvkdGVvQZjP+Ocn
 XQlqFxjV1CzVmAETG9Z39Cni9dOcsZVJzSQTzR9sF8RAWee+nT4BfNwcBq6SXXRGGHud Kg== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rtpubb1qu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Jul 2023 23:45:33 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36ENjW4e001624
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Jul 2023 23:45:32 GMT
Received: from [10.110.114.79] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Fri, 14 Jul
 2023 16:45:31 -0700
Message-ID: <52650970-de78-764f-28e2-ee0115b7d5c6@quicinc.com>
Date:   Fri, 14 Jul 2023 16:45:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v4 00/21] Add Qualcomm Minidump kernel driver related
 support
From:   Trilok Soni <quic_tsoni@quicinc.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        "Alexander Shishkin" <alexander.shishkin@linux.intel.com>
CC:     Greg KH <gregkh@linuxfoundation.org>,
        Mukesh Ojha <quic_mojha@quicinc.com>, <corbet@lwn.net>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <keescook@chromium.org>,
        <tony.luck@intel.com>, <gpiccoli@igalia.com>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <andy.shevchenko@gmail.com>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-hardening@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-gpio@vger.kernel.org>
References: <1687955688-20809-1-git-send-email-quic_mojha@quicinc.com>
 <2023062814-chance-flounder-f002@gregkh>
 <CAL_JsqLO9yey2-4FcWsaGxijiS6hGL0SH9VoMuiyei-u9=Cv=w@mail.gmail.com>
 <CACRpkda3CJ7G4-wDPkWmzg6nyCoEfG+u2cQH6KXWNjbftd90ow@mail.gmail.com>
 <355de4c7-180d-4edd-b6fd-9c8e29e40e42@quicinc.com>
Content-Language: en-US
In-Reply-To: <355de4c7-180d-4edd-b6fd-9c8e29e40e42@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: jXG6FgGFtb_gNPqZH6g1IhhZEKBI1bZD
X-Proofpoint-GUID: jXG6FgGFtb_gNPqZH6g1IhhZEKBI1bZD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-14_11,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 priorityscore=1501 spamscore=0 mlxlogscore=999 bulkscore=0 phishscore=0
 suspectscore=0 adultscore=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307140216
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/5/2023 10:29 AM, Trilok Soni wrote:
> On 7/4/2023 2:27 AM, Linus Walleij wrote:
>> On Thu, Jun 29, 2023 at 1:12 AM Rob Herring <robh+dt@kernel.org> wrote:
>>
>>> My bigger issue with this whole series is what would this all look
>>> like if every SoC vendor upstreamed their own custom dumping
>>> mechanism. That would be a mess. (I have similar opinions on the
>>> $soc-vendor hypervisors.)
>>
>> I agree with Rob's stance.
>>
>> I think it would be useful to get input from the hwtracing developers
>> (Alexander and Mathieu) who faced this "necessarily different" issue
>> with all the hwtrace mechanisms and found a way out of it. I suspect
>> they can have an idea of how this should be abstracted.
> 
> Any mailing list you suggest we expand to so that we get inputs from the 
> hwtracing developers and maintainers or just look into the MAINTAINERS 
> file and start an email thread?
> 
> We are fine to submit the abstract for the LPC in next two weeks, but 
> prefer to have lot of good discussion before it on the mailing list, so 
> that we have code to talk about in LPC.

We have submitted abstract at LPC MC. Let's continue the discussion here 
though.

Mukesh, do you want to expand the lists as necessary to see if other 
soc-vendors are having any inputs here? May be add Exynos or MTK kernel 
mailing lists + linux-kernel? I don't know if anyone will respond or 
not, but let's try.

---Trilok Soni

