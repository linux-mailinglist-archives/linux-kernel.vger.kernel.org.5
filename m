Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62E4776234E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 22:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbjGYU1i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 16:27:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbjGYU1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 16:27:36 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68CFD268D;
        Tue, 25 Jul 2023 13:27:25 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36PJIShn014114;
        Tue, 25 Jul 2023 20:27:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=J5GVlSSAhoTLUBI0opme3fy6DfaiQXzK/JQ14KRTgTA=;
 b=VAUQPq/07BwSx3yufgPtX0+B4xfVOQcfTu1xWdxvpu0kh8gKJntGo+XY33a4pagDrt1t
 guxwtmO7r4HhObzuSV/W1kZCo6c+9wxw/iDJJW75Qb4m9B+OeCaqKxckyXB5LR5FXaME
 Vm/F4FuDzvD+XpQ3k3LeRB+1mWtzGzy9c8zv/5k2GYafla/J+FaXwDJ1EAHDTcnase8P
 PMTBHlS+sy+2EWMilbFunmSnGj7ceWpBwTTR5Xj9MXVoQ4qflH/Ueypn+JG+90AfFJyz
 blT/5nsvFUQS+BW/OMMdyX9rsWAYMMCOAQkRozE2GUhvZ1Zp2z5UjAW5/1khl+7rBkde Zg== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s1v6ubdem-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jul 2023 20:27:16 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36PKRFJq031949
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jul 2023 20:27:15 GMT
Received: from [10.71.109.50] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Tue, 25 Jul
 2023 13:27:14 -0700
Message-ID: <7b2f5af5-a704-ede7-1c6f-a2f0eb5b988f@quicinc.com>
Date:   Tue, 25 Jul 2023 13:27:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [RFC PATCH 0/4] Implement a PSCI SYSTEM_RESET2 reboot-mode driver
Content-Language: en-US
To:     Florian Fainelli <florian.fainelli@broadcom.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        "Sebastian Reichel" <sre@kernel.org>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <kernel@quicinc.com>,
        "Satya Durga Srinivasu Prabhala" <quic_satyap@quicinc.com>,
        Melody Olvera <quic_molvera@quicinc.com>,
        Prasad Sodagudi <quic_psodagud@quicinc.com>
References: <20230724223057.1208122-1-quic_eberman@quicinc.com>
 <65afff8f-fd02-1344-56b5-f9e3deda1d47@broadcom.com>
From:   Elliot Berman <quic_eberman@quicinc.com>
In-Reply-To: <65afff8f-fd02-1344-56b5-f9e3deda1d47@broadcom.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: NwQAFfX2ImznLSH0lf6YCxdXCdTwQvZe
X-Proofpoint-GUID: NwQAFfX2ImznLSH0lf6YCxdXCdTwQvZe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-25_11,2023-07-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 suspectscore=0
 priorityscore=1501 mlxlogscore=999 lowpriorityscore=0 impostorscore=0
 mlxscore=0 spamscore=0 adultscore=0 phishscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307250173
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/25/2023 12:12 PM, Florian Fainelli wrote:
> Hello,
> 
> On 7/24/23 15:30, Elliot Berman wrote:
>> PSCI implements a restart notifier for architectural defined resets.
>> The SYSTEM_RESET2 call allows vendor firmware to define additional reset
>> types which could be mapped to the reboot reason.
>>
>> Implement a driver to wire the reboot-mode framework to make vendor
>> SYSTEM_RESET2 calls on reboot.
>>
>> This is a continuation from 
>> https://lore.kernel.org/all/4a679542-b48d-7e11-f33a-63535a5c68cb@quicinc.com/
> 
> Would appreciate being CC'd on a the non-RFC postings of this patch. 
> FWIW, my use case is better described with this earlier submission:
> 
> https://lore.kernel.org/lkml/20220122035421.4086618-1-f.fainelli@gmail.com/T/#m74e4243c1af3a8d896e19b573b58f562fa09961d
> 
> It would be neat if I could leverage your driver in order to implement 
> this custom "reboot powercycle" implementation. Towards that goal, we 
> would likely need to specify the desired reboot "sub" operation 
> alongside its PSCI SYSTEM_RESET2 reboot type argument?
> 
> Thanks!

I think you you want to describe the PSCI vendor reset under a warm 
reboot with command "powercycle"? In other words, my series only lets DT 
describe either reboot_mode (warm) or cmd (powercycle) but not both 
simultaneously?

Please correct me if I got it wrong! Otherwise, I can incorporate way to 
describe vendor reset type matching both reboot_mode and cmd in the DT.

- Elliot
