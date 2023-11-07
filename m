Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1051E7E3AB4
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 12:03:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234241AbjKGLDN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 06:03:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233987AbjKGLDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 06:03:07 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 596A7114;
        Tue,  7 Nov 2023 03:03:05 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7ADrx4029500;
        Tue, 7 Nov 2023 11:02:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=SFRYKwU5koGWL5dv8W4KKvT9e10tazgxHr6Z4LinXI8=;
 b=o6f7W2NuUH8oSnUhvHydTzahuShmT1Mny2h94uCM5ff6zpNJbMZMQOvNGZq6NZglJwlB
 S0/GavH2bfBBHDFQtSIOtcnqz2P4BVlFcQMtNgX4UC0qc0Vi4Ff/Drd9gRZkJ0Dn/fXX
 jL7+EBmbYqppZs/M3+rAJJO06N080P8sDuQjI1MQsjbep5I3pLZhd6NtZnbNyiru60GS
 5VUKR9lEcq6Yu6Q2L0ZJAI52Ew/vsy+ConhB3Ynox3x4vgDU2qvMei0Pi3VnRcjaYSVS
 K3Coyx3aBR7ev1VWTGKVFHwsFMqlnHtGGlm2B54WGx6UQmBgqM4O/umUN8Rm0P0oqKNr Jw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u6xdub4bh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Nov 2023 11:02:52 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3A7B2puZ018234
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 7 Nov 2023 11:02:51 GMT
Received: from [10.249.29.138] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Tue, 7 Nov
 2023 03:02:46 -0800
Message-ID: <70b5cdc9-f0e1-4fad-a1ab-858fff3c110c@quicinc.com>
Date:   Tue, 7 Nov 2023 16:32:43 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 2/8] usb: dwc3: core: Register vendor hooks for dwc3-qcom
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Conor Dooley" <conor+dt@kernel.org>
CC:     <linux-usb@vger.kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-kernel@vger.kernel.org>,
        "Thinh Nguyen" <Thinh.Nguyen@synopsys.com>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <quic_ppratap@quicinc.com>, <quic_jackp@quicinc.com>,
        <quic_wcheng@quicinc.com>, Andy Gross <agross@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
References: <20231017131851.8299-1-quic_kriskura@quicinc.com>
 <20231017131851.8299-3-quic_kriskura@quicinc.com>
 <e700133b-58f7-4a4d-8e5c-0d04441b789b@linaro.org>
 <5ef66bdc-9645-4bbe-8182-baa7fe4c583a@quicinc.com>
 <3be5e95f-85d2-4abf-a8b4-18b019341602@quicinc.com>
 <cf553cd8-45f8-4a61-b016-69e7a80eee9f@linaro.org>
 <ea919050-22a8-4d28-ade2-fd16a99876cb@quicinc.com>
 <105d84b6-cbea-4758-9eba-1c104fa7a670@quicinc.com>
 <f94ca738-476c-4664-a8f1-e3ef3ac8220a@linaro.org>
 <4b3e1f66-31e0-4b7a-9cc0-0b7a7a6ef2f5@linaro.org>
Content-Language: en-US
From:   Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <4b3e1f66-31e0-4b7a-9cc0-0b7a7a6ef2f5@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Mxfa6Z2ES4PVL7h7l10ERvgnqaGGyPkf
X-Proofpoint-ORIG-GUID: Mxfa6Z2ES4PVL7h7l10ERvgnqaGGyPkf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-07_01,2023-11-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=876 priorityscore=1501
 spamscore=0 impostorscore=0 mlxscore=0 malwarescore=0 clxscore=1015
 bulkscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311070091
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/7/2023 4:25 PM, Bryan O'Donoghue wrote:
> On 07/11/2023 10:41, Bryan O'Donoghue wrote:
>> On 07/11/2023 08:33, Krishna Kurapati PSSNV wrote:
>>>
>>>
>>> On 11/4/2023 10:32 PM, Krishna Kurapati PSSNV wrote:
>>>>>
>>>>> Are you saying to you require/rely on both of these series being 
>>>>> applied first ?
>>>>>
>>>>> [1]: 
>>>>> https://lore.kernel.org/all/af60c05b-4a0f-51b8-486a-1fc601602515@quicinc.com/
>>>>> [2]: 
>>>>> https://lore.kernel.org/all/20231016-dwc3-refactor-v1-0-ab4a84165470@quicinc.com/
>>>>>
>>>>> Must be, nothing applies for me in this series.
>>>>
>>>> The first one is not a patch. It is just a discussion thread I 
>>>> started to get community's opinion before on disconnect interrupt 
>>>> handling. The current series is based on top of [2] made by Bjorn 
>>>> (as you already found out) and as I mentioned in cover letter of my 
>>>> series.
>>>>
>>>
>>> Hi Bryan,
>>>
>>>    Are you able to apply the series after including Bjorn's patches ? 
>>> Also can you confirm if the comments provided to your queries on [1] 
>>> are proper and if you have any other comments w.r.t probe deferral.
>>>
>>> [1]: 
>>> https://lore.kernel.org/all/e700133b-58f7-4a4d-8e5c-0d04441b789b@linaro.org/
>>>
>>> Regards,
>>> Krishna,
>>
>> I wonder could you give a base SHA to apply the various series on ?
>>
>> Your referenced precursor doesn't apply to usb-next
> 
> Well now, that doesn't point where I thought it pointed usb-next/master 
> is extremely old
> 
>   b3a9e3b9622ae - (HEAD -> usb-next-23-10-07-usb-glue-test, tag: 
> v5.8-rc1, usb-next/master, origin/tracking-qcomlt-sm8150-gcc, 
> linaro/tracking-qcomlt-sm8150-gcc, fecked-old, delete-this-branch2, 
> delete-this-branch) Linux 5.8-rc1 (3 years, 5 months ago)
> 
> I want usb-next/main
> 
> *   d2f51b3516dad - (usb-next/usb-testing, usb-next/usb-next, 
> usb-next/main) Merge tag 'rtc-6.7' of 
> git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux (32 hours ago)
> 
> Everything applies there.

Hi Bryan,

   I should have mentioned that series is pushed on top of usb-next. 
Apologies.

> 
> Anyway, your pointing to Bjorn's series answers my question re: 
> sequencing of the probe.

Perfect. Thanks for the confirmation.

Regards,
Krishna,
