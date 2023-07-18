Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2605C758209
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 18:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232702AbjGRQXm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 12:23:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231511AbjGRQXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 12:23:35 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 148A1139;
        Tue, 18 Jul 2023 09:23:34 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36IFsRTa015227;
        Tue, 18 Jul 2023 16:22:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=9PudKBtLRGdIrG6woA6cD0ablmWghbSuQeHqb7JxJpo=;
 b=V3hWrUBHM+woS1my6mR7GJ8l5RToeNqfgquoQjxX6hkw1KKaAanxIf6/jPFsF7ifNAvS
 1vHTPwrwUqCvEGemIWxR4BS+5Vgy8EgWyM/aEFM2j6GYDfZsLCOa/wC062IsQQ8e60YO
 nY58M9LYuLrwkKYy0QwMyC9lr7E32TGVd5OZeWel5uipmEyukWZU+8ioEcyi8yf6S4Lm
 FxLgw8WEfd2SFVdakSH3aKbFwmvmMX3H01gcOa4HzXuzGDK94uxnJqTL9ji9msXIuUZC
 y5hMjcWR+DrEBvFl6znN3TEk8Zq+auOevV4dC/mJErlQcTEDSGAfWi1sGSjx/INajtzm Tg== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rwqqg92xe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Jul 2023 16:22:04 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36IGM3IM002800
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Jul 2023 16:22:03 GMT
Received: from [10.110.1.206] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Tue, 18 Jul
 2023 09:22:02 -0700
Message-ID: <38716e0a-fb99-bb71-23f4-7952a4f6e04e@quicinc.com>
Date:   Tue, 18 Jul 2023 09:22:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v4 00/21] Add Qualcomm Minidump kernel driver related
 support
To:     Greg KH <gregkh@linuxfoundation.org>,
        Mukesh Ojha <quic_mojha@quicinc.com>
CC:     <linux-samsung-soc@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <corbet@lwn.net>,
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
        <linux-gpio@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
References: <1687955688-20809-1-git-send-email-quic_mojha@quicinc.com>
 <2023062814-chance-flounder-f002@gregkh>
 <CAL_JsqLO9yey2-4FcWsaGxijiS6hGL0SH9VoMuiyei-u9=Cv=w@mail.gmail.com>
 <CACRpkda3CJ7G4-wDPkWmzg6nyCoEfG+u2cQH6KXWNjbftd90ow@mail.gmail.com>
 <355de4c7-180d-4edd-b6fd-9c8e29e40e42@quicinc.com>
 <52650970-de78-764f-28e2-ee0115b7d5c6@quicinc.com>
 <e4784d1c-73da-9cda-6aef-d02625e8efd2@quicinc.com>
 <2023071833-clamshell-drinking-188c@gregkh>
 <c8064592-bfac-67b4-1d7e-e173355c43f8@quicinc.com>
 <2023071844-promptly-swimwear-f6f9@gregkh>
Content-Language: en-US
From:   Trilok Soni <quic_tsoni@quicinc.com>
In-Reply-To: <2023071844-promptly-swimwear-f6f9@gregkh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: e8N4s61eNav6K3VmUuYrrBLypPGDxsor
X-Proofpoint-ORIG-GUID: e8N4s61eNav6K3VmUuYrrBLypPGDxsor
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-18_12,2023-07-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 clxscore=1011 impostorscore=0 bulkscore=0
 priorityscore=1501 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2306200000 definitions=main-2307180150
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/18/2023 7:41 AM, Greg KH wrote:
> On Tue, Jul 18, 2023 at 07:25:15PM +0530, Mukesh Ojha wrote:
>>
>>
>> On 7/18/2023 7:05 PM, Greg KH wrote:
>>> On Tue, Jul 18, 2023 at 11:17:12AM +0530, Mukesh Ojha wrote:
>>>> + linux-samsung-soc@vger.kernel.org
>>>> + linux-mediatek@lists.infradead.org
>>>
>>> What does that do?
>>
>> This is to seek their feedback, if they have something similar requirement
>> to debug end user device crashes.
> 
> Feedback to what?  There is no context here and no content either at
> all.
> 
> Just adding a mailing list to the top of a message doesn't actually send
> the thread there.
> 
> confused,

Mukesh, instead of adding the mailing lists here, we should send either 
the refreshed revision of this patchset (if there are enough changes) w/ 
MLs CCed or start a new discussion with these mailing list with the 
context of the minidump and refer these patches from the mailing list 
archives.

---Trilok Soni
