Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E84EA7D089E
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 08:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376326AbjJTGkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 02:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjJTGkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 02:40:45 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CD8BB8;
        Thu, 19 Oct 2023 23:40:44 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39K5RU0O001069;
        Fri, 20 Oct 2023 06:40:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=eRrvJZQUDGz35stEjap4Jn3iAMh2bG2D1penMsVbK4U=;
 b=OzPJ+G1nMgXK1V87E45faALCgB7lzLwwuWnptdiDXwOxNIyMqNCAB3GWp0fAgkcjge8f
 LjwWOmVII0Er9MUCe8sUu7UlAI5U/4UY59QTV8P33OSCjdiNIIsuoGF81zqca+IejPw2
 JxE2NahEhVhSxWPNAU6dsYi7u1Aak31OlII9PCdtr6wxusav+Qlz3Jjltk4ohAbgnXwc
 7+Dov5XOr94WsLE+fGTsIsHum5bOl0g9TnpTWq1y1yneOmqSTGaEk5KayaMkgHvvRPVP
 RYTaD3+LeZ0QBR6Xvtwg96UknYCnLOvhzKkYmsSQI5AXAVyZlAZeYWQT0ZSZKQj4FA3g cQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tubwms15k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Oct 2023 06:40:40 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39K6edbv005792
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Oct 2023 06:40:39 GMT
Received: from [10.201.2.96] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Thu, 19 Oct
 2023 23:40:36 -0700
Message-ID: <b4ce1fdf-0a05-479d-90f8-3a2a2e40b07f@quicinc.com>
Date:   Fri, 20 Oct 2023 12:10:32 +0530
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
From:   Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
In-Reply-To: <CAOX2RU4n8caVL33KkqgYK1_mTZv-oZtd0p=_dzPh-ntBBfH1zA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: jmVBjfrzfd__PmLg_5gwU4WK0We3gjZk
X-Proofpoint-ORIG-GUID: jmVBjfrzfd__PmLg_5gwU4WK0We3gjZk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-20_05,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 clxscore=1015 impostorscore=0 malwarescore=0 suspectscore=0
 mlxlogscore=881 adultscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2310170001 definitions=main-2310200056
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/19/2023 7:53 PM, Robert Marko wrote:
> On Thu, 19 Oct 2023 at 08:46, Kathiravan Thirumoorthy
> <quic_kathirav@quicinc.com> wrote:
>>
>> On 10/19/2023 1:59 AM, Konrad Dybcio wrote:
>>>
>>> On 10/15/23 18:20, Robert Marko wrote:
>>>> QUP6 I2C clock is listed in the dt bindings but it was never included in
>>>> the GCC driver.
>>>> So lets add support for it, its intentionally marked to never be
>>>> disabled
>>>> as its somehow affecting DVFS and if disabled it sometimes crashes the
>>>> board.
>>>>
>>>> Signed-off-by: Robert Marko <robimarko@gmail.com>
>>>> ---
>>> Bjorn, would you be able to get an idea of what could be sitting
>>> on that bus?
>>>
>>> Or maybe the IPQ folks could know?
>>>
>> Konrad / Robert,
>>
>> Similar to IPQ9574, RPM needs this clock to communicate with PMIC over
>> I2C interface. Discussion happened here[1] is pretty much applicable to
>> IPQ6018 as well. Based on previous experience, we may need to document
>> the reason for CLK_IGNORE_UNUSED in driver as well. Nevertheless,
>>
>> Reviewed-by: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
> Thanks for the explanation, it makes sense as I used to control the
> MP5496 directly
> via I2C.
>
> Is it possible to disable RPM so it doesn't conflict and just use the
> full MP5496 driver instead?
> I find the RPM quite limiting as there is no way to actually retrieve
> the current-voltage.


Robert, checked with the team and currently we don't have any option to 
disable the RPM as such.


>
> Regards,
> Robert
>> [1]
>> https://lore.kernel.org/linux-arm-msm/2852fc37-284f-6534-f163-45b37b153db1@quicinc.com/
>>
>>
>>> Konrad
