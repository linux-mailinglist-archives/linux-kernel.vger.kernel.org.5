Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A6F67902D5
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 22:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350729AbjIAU3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 16:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242521AbjIAU3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 16:29:22 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9FD4E7E;
        Fri,  1 Sep 2023 13:29:19 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 381ItjDG005899;
        Fri, 1 Sep 2023 20:29:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=2FYXvMmpReuPlYSmTDcvNg1rIzAmGZtkeMDCuhzAtGw=;
 b=RpGMbsimYgMc3eNR7ei7vHPVzYUwHYGYWfqvFd5Hm0dfsshzelWMpDIZ1rnuLnmPTBJW
 QrE9r0G9055pwpCfvVOPDMYtRHxC1oQjdFF+Gqzr4/3Fj+LWLC7Ub9J9K4ZZKtKtFbum
 sHYN6I0cLw7UKq0OoSob97cywjNlU+qDOZ1qNg1FPayvbNvP7zzH3hwGYkQ+kG9Bx9jv
 pkoE04KD1f8QglapQUr69SaBGB43NBDRiCuHqw/3ZSvJVuKYp2UadZBnGPAgApX2FtyJ
 dkQahInoVqPNSAkfaD2bOsDEwD7LSCXJ9CVg7yTTQ0XSZVrP7POVtWlVknMqnRdcBF39 TQ== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3suc22hupp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Sep 2023 20:29:05 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 381KT4X3011614
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 1 Sep 2023 20:29:04 GMT
Received: from [10.110.95.146] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Fri, 1 Sep
 2023 13:29:04 -0700
Message-ID: <deeefaf8-2ac9-cee0-eed4-687e36ac6f10@quicinc.com>
Date:   Fri, 1 Sep 2023 13:29:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 02/11] nvmem: qfprom: Mark core clk as optional
Content-Language: en-US
To:     Luca Weiss <luca.weiss@fairphone.com>,
        Doug Anderson <dianders@chromium.org>
CC:     <cros-qcom-dts-watchers@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        <~postmarketos/upstreaming@lists.sr.ht>,
        <phone-devel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linux-pm@vger.kernel.org>
References: <20230830-fp5-initial-v1-0-5a954519bbad@fairphone.com>
 <20230830-fp5-initial-v1-2-5a954519bbad@fairphone.com>
 <CAD=FV=WS2hgY=bQjLOs3Fdp8pbZyMsaS-0BpoxPq90Etfi+Xuw@mail.gmail.com>
 <CV5YJVXIL8OT.1ZWW3KVCHPTA5@otso>
From:   Trilok Soni <quic_tsoni@quicinc.com>
In-Reply-To: <CV5YJVXIL8OT.1ZWW3KVCHPTA5@otso>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 9Ar9RfHXW3BZTXygIUaxyBxzbbtd8VRn
X-Proofpoint-ORIG-GUID: 9Ar9RfHXW3BZTXygIUaxyBxzbbtd8VRn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-01_17,2023-08-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 clxscore=1011 mlxscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 lowpriorityscore=0 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309010192
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/30/2023 7:43 AM, Luca Weiss wrote:
> On Wed Aug 30, 2023 at 4:30 PM CEST, Doug Anderson wrote:
>> Hi,
>>
>> On Wed, Aug 30, 2023 at 2:58 AM Luca Weiss <luca.weiss@fairphone.com> wrote:
>>>
>>> On some platforms like sc7280 on non-ChromeOS devices the core clock
>>> cannot be touched by Linux so we cannot provide it. Mark it as optional
>>> as accessing qfprom works without it.
>>>
>>> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
>>> ---
>>>  drivers/nvmem/qfprom.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> Are you actually testing burning fuses from the OS, or are you just
>> using the nvmem in "read-only" mode? From comments in the bindings, if
>> you're trying to burn the fuses then the clock is required. If things
>> are in read-only mode then the clock isn't required.
> 
> Hi Doug,
> 
> I definitely don't plan on burning any fuses on this phone. Not even
> sure that's allowed by the TZ / boot stack.
> 
>>
>> When I compare to the driver, it seems like the driver assumes that if
>> more than one memory region is provided then you must be supporting
>> burning fuses. The bindings agree that having 4 memory regions
>> specified means that the nvmem supports burning and 1 memory region
>> specified means read-only. The extra 3 memory regions in the nvmem are
>> all about fuse burning, I believe.
>>
>> So maybe the right fix here is to just change your dts to specify one
>> memory region?
> 
> I got feedback from Konrad that this here would be the preferred
> approach compared to having a different dts for ChromeOS vs non-ChromeOS
> devices. I don't feel strongly to either, for me it's also okay to
> remove the extra memory regions and only have the main one used on
> regular qcom devices.
> 
> Let me know what you think.

I would prefer to re-use the sc7280 DT as well. Thank you for your patches. We plan to use your patches for platform on the same part. 

-- 
---Trilok Soni

