Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03411757883
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 11:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232351AbjGRJy1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 05:54:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230376AbjGRJyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 05:54:03 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A8AC172E;
        Tue, 18 Jul 2023 02:53:02 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36I7v7VI010277;
        Tue, 18 Jul 2023 09:52:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=2d/966OWnkvOyNnR/my+wrb0gN+xG4kEv8BAnNhK44Y=;
 b=ptN0fe4j4F9thQYVMSKotlpxI9eLw7Kevy3uRlrMJbMm9rhXRQxXVunZzlIpdi3Qq0bU
 o+8woEt5YThDiA76a6fDXKXA+4aCPScICnbO0SzQK0k563OwJK4zaPVD6cJCOYJ9bPGL
 9TTOzk7s+7e8UnmMMkrvNTsQDBBBSBuxTVjkelQ9P07G2ZaYY6FW+GbeGg5ONg0Ic6AJ
 86SJUUkhb4snOZkmebwQ4IrRq6oGI8zNcE8pYbAaJDxrHnfcvI/6Us0L7fIetbVIle1A
 oiOQ5on+MGQhTpDLMfC3twQsTgULl2sd56womWoHRdTImzDiga3VC0YTDVZlxGPGT46M xg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rwps5882y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Jul 2023 09:52:22 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36I9qKSj000884
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Jul 2023 09:52:21 GMT
Received: from [10.239.154.73] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Tue, 18 Jul
 2023 02:52:17 -0700
Message-ID: <e420f2c9-4c29-e2c4-4312-291b05c97224@quicinc.com>
Date:   Tue, 18 Jul 2023 17:52:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v1] led: flash: various minor fixes for leds-qcom-flash
 driver
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lee@kernel.org>, <pavel@ucw.cz>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        "Alice Chen" <alice_chen@richtek.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        "Dylan Van Assche" <me@dylanvanassche.be>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Tom Rix <trix@redhat.com>, <linux-leds@vger.kernel.org>
CC:     <quic_collinsd@quicinc.com>, <quic_subbaram@quicinc.com>
References: <20230718092439.2482320-1-quic_fenglinw@quicinc.com>
 <d246292b-c0df-fa70-7561-9523e4db6138@linaro.org>
From:   Fenglin Wu <quic_fenglinw@quicinc.com>
In-Reply-To: <d246292b-c0df-fa70-7561-9523e4db6138@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: znqBGfnqHkdSNITSJDykir-4j7LPbjUk
X-Proofpoint-ORIG-GUID: znqBGfnqHkdSNITSJDykir-4j7LPbjUk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-17_15,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 mlxlogscore=549 lowpriorityscore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 adultscore=0 impostorscore=0 phishscore=0 clxscore=1015
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307180089
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/18/2023 5:32 PM, Krzysztof Kozlowski wrote:
> On 18/07/2023 11:24, Fenglin Wu wrote:
>> Update the driver to address following minor issues:
>>   - Add a sentence in Kconfig to explain the driver can be compiled
>>     as a module
>>   - strobe off the LED channel before setting flash current to prevent
>>     the flash LED being lit with an incorrect brightness if it was
>>     already active in torch mode
>>   - put the child node if register any flash LED device failed.
> 
> Don't mix different fixes and changes in one commit.
> 
> Also, please use scripts/get_maintainers.pl to get a list of necessary
> people and lists to CC (and consider --no-git-fallback argument). I
> really do not see a point why I am cc-ed here.
> 
> Best regards,
> Krzysztof

I understood that we should separate the changes for different fixes.

I am trying to address the review comment from Pavel that was coming 
late after the original changes were applied: 
https://lore.kernel.org/linux-arm-msm/20230325170957.GA2904@bug/ (sorry 
for just got time to work on this), since all of them are small ones and 
all related with the same driver, so I thought it might be good to put 
them together and update with a single patch?

BTW, you are copied because you also reviewed the original changes.
Thanks



> 
