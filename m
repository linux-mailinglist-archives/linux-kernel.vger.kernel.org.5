Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80A5C7D6568
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 10:42:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233700AbjJYImI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 04:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230217AbjJYImG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 04:42:06 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EE07116;
        Wed, 25 Oct 2023 01:42:04 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39P8ELMe008097;
        Wed, 25 Oct 2023 08:41:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=piw4ASk/F6MXM5znsVtEgx59dMp8hWKsUBoemdSAOTM=;
 b=MpOF5jGbtHenZ/IUcHv9CbtBFdhKtxFiXxiLNPORku5RA3RbHdOLn72hXEuc3/6HKs6R
 k4yUN3KPOqQWxZxbWcep0S+BkcKwExJTH1bh0GmcGEF7eSMB2un8nsH5czjQevuX0Hvp
 GeCE3vWMrGy6+lMytLTxeDMDCdjb8AP1UzPB8yjM8JR6tVKuAq7dfdyHCySZI5FjS/8g
 sWQvlOVX8EPumtQae11EnEmt0dYz7sATS7kf2e9WZxIS7/CQd4e3omuUGR3oOtUY1xms
 rT1etO8VjImWLrK29hWOP+OLhmNu1+vsaEey7vn9XsqGTq3SE63EV0EqDdIy5ZUYlr/7 1g== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3txmhx96a2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Oct 2023 08:41:58 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39P8fv6O017316
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Oct 2023 08:41:57 GMT
Received: from [10.201.2.96] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Wed, 25 Oct
 2023 01:41:53 -0700
Message-ID: <444ef41e-632c-4402-849d-80e8876b6e72@quicinc.com>
Date:   Wed, 25 Oct 2023 14:11:50 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: qcom: gcc-ipq6018: add QUP6 I2C clock
Content-Language: en-US
To:     Robert Marko <robimarko@gmail.com>
CC:     Konrad Dybcio <konrad.dybcio@linaro.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20231015162114.976202-1-robimarko@gmail.com>
 <f27ff251-58b1-4fc5-8ad5-cd365b7eb976@linaro.org>
 <8dce62b2-562c-4e00-840b-68e1cc865972@quicinc.com>
 <CAOX2RU4n8caVL33KkqgYK1_mTZv-oZtd0p=_dzPh-ntBBfH1zA@mail.gmail.com>
 <b4ce1fdf-0a05-479d-90f8-3a2a2e40b07f@quicinc.com>
 <CAOX2RU7Z1BS0u_k=cx58oq8RODPV=a3kV26OsbYpkDaN1atixg@mail.gmail.com>
From:   Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
In-Reply-To: <CAOX2RU7Z1BS0u_k=cx58oq8RODPV=a3kV26OsbYpkDaN1atixg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: a0pLzSUo_K5mzzQ3IhRA65xhyKIDjsbM
X-Proofpoint-GUID: a0pLzSUo_K5mzzQ3IhRA65xhyKIDjsbM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-25_01,2023-10-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 phishscore=0 malwarescore=0 spamscore=0 adultscore=0 mlxscore=0
 priorityscore=1501 mlxlogscore=970 impostorscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310250074
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/21/2023 5:27 PM, Robert Marko wrote:
> On Fri, 20 Oct 2023 at 08:40, Kathiravan Thirumoorthy
> <quic_kathirav@quicinc.com> wrote:
>>
>>
>> On 10/19/2023 7:53 PM, Robert Marko wrote:
>>> On Thu, 19 Oct 2023 at 08:46, Kathiravan Thirumoorthy
>>> <quic_kathirav@quicinc.com> wrote:
>>>>
>>>> On 10/19/2023 1:59 AM, Konrad Dybcio wrote:
>>>>>
>>>>> On 10/15/23 18:20, Robert Marko wrote:
>>>>>> QUP6 I2C clock is listed in the dt bindings but it was never included in
>>>>>> the GCC driver.
>>>>>> So lets add support for it, its intentionally marked to never be
>>>>>> disabled
>>>>>> as its somehow affecting DVFS and if disabled it sometimes crashes the
>>>>>> board.
>>>>>>
>>>>>> Signed-off-by: Robert Marko <robimarko@gmail.com>
>>>>>> ---
>>>>> Bjorn, would you be able to get an idea of what could be sitting
>>>>> on that bus?
>>>>>
>>>>> Or maybe the IPQ folks could know?
>>>>>
>>>> Konrad / Robert,
>>>>
>>>> Similar to IPQ9574, RPM needs this clock to communicate with PMIC over
>>>> I2C interface. Discussion happened here[1] is pretty much applicable to
>>>> IPQ6018 as well. Based on previous experience, we may need to document
>>>> the reason for CLK_IGNORE_UNUSED in driver as well. Nevertheless,
>>>>
>>>> Reviewed-by: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
>>> Thanks for the explanation, it makes sense as I used to control the
>>> MP5496 directly
>>> via I2C.
>>>
>>> Is it possible to disable RPM so it doesn't conflict and just use the
>>> full MP5496 driver instead?
>>> I find the RPM quite limiting as there is no way to actually retrieve
>>> the current-voltage.
>>
>>
>> Robert, checked with the team and currently we don't have any option to
>> disable the RPM as such.
> 
> Thanks for checking.
> 
> BTW, is there any information you could share on the USB GDSC-s?
> I tried converting them to GDSC-s like IPQ8074 has, but it seems that
> they have different features.
> It would be great to use proper GSDC support instead of manually
> setting bits during GCC probe.


Could you please explain the issue which you are facing? Based on quick 
look at the HW documentation, seems there is no difference between 
IPQ8074 and IPQ6018 GDSC-s.

Thanks,
