Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2EA27DD826
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 23:19:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346475AbjJaWT0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 18:19:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344925AbjJaWTY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 18:19:24 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 792CCFE;
        Tue, 31 Oct 2023 15:19:21 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39VJOBuL029799;
        Tue, 31 Oct 2023 22:19:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Aphlc6s8NtUMz0AnqPtvlfqApJgy5j7VA/4sgYsahRU=;
 b=a+TcgrrRXjpCN5SqROM/bvVf8A6ELksisLPxyrzPnKzvxS5+/JmhvJmvNvEXcXrdcJ87
 O7zUFbzID42C88I7t5x5Ci6H20sTRkMhmvgY5kpy4pnaQuAcviHKWf1fG8E6Ul8V2O16
 SquzGStAoaq5vWx6Mm1yZAxvMv/TKH3UANC8NINeUwAbYe7vDV0zPTRb7cke/jG9o6d/
 hbmsLITZJQ2/NYldQmEsVdgJBls1qkSanPpq7ZeKRbv5QpLS1U4eLkE61e4VfwR+pm75
 wMe/CNyCCGv3UkY/2wZDht21WkwoFA/JBMdS/he6p9a14VkhHLeb47fjdQMc2SIKSnbM IQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u34sc0v4c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Oct 2023 22:19:09 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39VMJ8dP020242
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Oct 2023 22:19:08 GMT
Received: from [10.110.20.112] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Tue, 31 Oct
 2023 15:19:07 -0700
Message-ID: <7b074eaf-ab65-c03b-dcb6-92a0848c2291@quicinc.com>
Date:   Tue, 31 Oct 2023 15:18:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v6 3/7] soc: qcom: add QCOM PBS driver
Content-Language: en-US
To:     Lee Jones <lee@kernel.org>
CC:     <pavel@ucw.cz>, <thierry.reding@gmail.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <luca.weiss@fairphone.com>, <konrad.dybcio@linaro.org>,
        <u.kleine-koenig@pengutronix.de>, <quic_subbaram@quicinc.com>,
        <quic_gurus@quicinc.com>, <linux-leds@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-pwm@vger.kernel.org>
References: <20231020182218.22217-1-quic_amelende@quicinc.com>
 <20231020182218.22217-4-quic_amelende@quicinc.com>
 <20231025121255.GM8909@google.com>
From:   Anjelique Melendez <quic_amelende@quicinc.com>
In-Reply-To: <20231025121255.GM8909@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 6iHWD_z0aisOaV3YVZEc3yd2VvNJ9BrR
X-Proofpoint-GUID: 6iHWD_z0aisOaV3YVZEc3yd2VvNJ9BrR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-31_09,2023-10-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 mlxlogscore=749 bulkscore=0 phishscore=0 priorityscore=1501
 mlxscore=0 spamscore=0 clxscore=1011 adultscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2310310184
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/25/2023 5:12 AM, Lee Jones wrote:
> On Fri, 20 Oct 2023, Anjelique Melendez wrote:
> 
>> Add the Qualcomm PBS (Programmable Boot Sequencer) driver. The QCOM PBS
>> driver supports configuring software PBS trigger events through PBS RAM
>> on Qualcomm Technologies, Inc (QTI) PMICs.
>>
>> Signed-off-by: Anjelique Melendez <quic_amelende@quicinc.com>
>> ---
>>  drivers/soc/qcom/Kconfig          |   9 ++
>>  drivers/soc/qcom/Makefile         |   1 +
>>  drivers/soc/qcom/qcom-pbs.c       | 243 ++++++++++++++++++++++++++++++
>>  include/linux/soc/qcom/qcom-pbs.h |  30 ++++
>>  4 files changed, 283 insertions(+)
>>  create mode 100644 drivers/soc/qcom/qcom-pbs.c
>>  create mode 100644 include/linux/soc/qcom/qcom-pbs.h
> 
> The LED patches look good to go.
> 
> What's the plan for the SoC driver?
> 
>   * Who will review it?
>   * Shall I take it via LED with an Ack?
> 
QCOM PBS driver should be reviewed by linux-arm-msm maintainers/reviewers.
Will give them another week or so to take a look at this series before I
resend to them.
