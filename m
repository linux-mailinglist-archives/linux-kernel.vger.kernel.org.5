Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F12C67CF059
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 08:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344773AbjJSGrI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 02:47:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232822AbjJSGrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 02:47:02 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF433129;
        Wed, 18 Oct 2023 23:46:59 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39J6Ax0q021596;
        Thu, 19 Oct 2023 06:46:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=br6+Z//OonCZjY0jaV7sAbQUXzyAjhH/ygBUQZbeG4U=;
 b=TEAKw5U2QoeW3rF1haljhCE/8K7XIM25b7TkXQiezKC/wTWppp8+Szs30nZI/Wtyu/Fj
 el+92SEAXVCCkYruqstH4p2sfQ+waRZMeK7cJE1jckFMwUQuX8dvrG1+Z8PZQmpKQcGq
 RUh+cl8e0giuvcMxn6k6TYtRB/Pgzb1QXXMwqNyrcv5PTjcVXE5YfOlcWfDndBt+cBIS
 mtNQ9D6Z9VhbH8aFdOPk8RDns3oBRHffVCEzrko873BLileKwnhEELNXzKm06fzwM87d
 /nVskQ1zhskUX4QtIrCHqr64CfmHdlvJ7fkuztZ4zG96Dkc6DNQtmNvu17yxHPoFz/W3 Sw== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tt5v839vh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Oct 2023 06:46:51 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39J6koYE022328
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Oct 2023 06:46:50 GMT
Received: from [10.201.2.96] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Wed, 18 Oct
 2023 23:46:47 -0700
Message-ID: <8dce62b2-562c-4e00-840b-68e1cc865972@quicinc.com>
Date:   Thu, 19 Oct 2023 12:16:09 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: qcom: gcc-ipq6018: add QUP6 I2C clock
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Robert Marko <robimarko@gmail.com>, <agross@kernel.org>,
        <andersson@kernel.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20231015162114.976202-1-robimarko@gmail.com>
 <f27ff251-58b1-4fc5-8ad5-cd365b7eb976@linaro.org>
Content-Language: en-US
From:   Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
In-Reply-To: <f27ff251-58b1-4fc5-8ad5-cd365b7eb976@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: j_RNWGCpKnB_l9CD9omjLei1tVFOzZbY
X-Proofpoint-ORIG-GUID: j_RNWGCpKnB_l9CD9omjLei1tVFOzZbY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-19_05,2023-10-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=911 lowpriorityscore=0 phishscore=0 impostorscore=0
 suspectscore=0 mlxscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 spamscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310190057
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/19/2023 1:59 AM, Konrad Dybcio wrote:
>
>
> On 10/15/23 18:20, Robert Marko wrote:
>> QUP6 I2C clock is listed in the dt bindings but it was never included in
>> the GCC driver.
>> So lets add support for it, its intentionally marked to never be 
>> disabled
>> as its somehow affecting DVFS and if disabled it sometimes crashes the
>> board.
>>
>> Signed-off-by: Robert Marko <robimarko@gmail.com>
>> ---
> Bjorn, would you be able to get an idea of what could be sitting
> on that bus?
>
> Or maybe the IPQ folks could know?
>

Konrad / Robert,

Similar to IPQ9574, RPM needs this clock to communicate with PMIC over 
I2C interface. Discussion happened here[1] is pretty much applicable to 
IPQ6018 as well. Based on previous experience, we may need to document 
the reason for CLK_IGNORE_UNUSED in driver as well. Nevertheless,

Reviewed-by: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>

[1] 
https://lore.kernel.org/linux-arm-msm/2852fc37-284f-6534-f163-45b37b153db1@quicinc.com/


> Konrad
