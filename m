Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23C3375BD1D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 06:10:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbjGUEKc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 00:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjGUEKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 00:10:30 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB58A1BC1;
        Thu, 20 Jul 2023 21:10:29 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36L1kaEL009547;
        Fri, 21 Jul 2023 04:10:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=pZ5sjngT65EZooyVN6g2/yFN3ZXMQjg0re0eMmcGzL4=;
 b=ceq1RuXMFjJ0G06tlCo78vsD5gzf3Z+3e9c3YG4V86k+5TwijC5zF9ZO7tTGeOiLaBy6
 Cu9suzQPUxwb1/Xty8jdlC8LP0r6vUtRwGgZkgys5o8S++skD2dDnV+ZoOtYLFjHPVj8
 EwckVvbazLz2XQbLjknWDmf8kwWBp5DMw8c3P/rquyke4RRfilSrvCWv/doZPatxtKRc
 QpNezGbHNTSXnyzhAVgVQjc1po1ceCSDwV6xt4iOczFZ2qJzvQE/k0lVA1wfhjq8TTb9
 yGOb9TwAybjf3DDEri6KWMhjdrtSdobhn5rbq0SQ7J3gVSYtmosEB3r5F4NqicezGeb9 Qw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rya4sh2a3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Jul 2023 04:10:12 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36L4ABeZ026215
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Jul 2023 04:10:11 GMT
Received: from [10.216.41.167] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Thu, 20 Jul
 2023 21:10:04 -0700
Message-ID: <b4e34150-e231-b92c-253e-9f0fa1878b9d@quicinc.com>
Date:   Fri, 21 Jul 2023 09:40:01 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [v11 5/6] arm64: dts: Add ipq5018 SoC and rdp432-c2 board support
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <ulf.hansson@linaro.org>,
        <linus.walleij@linaro.org>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <p.zabel@pengutronix.de>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <robimarko@gmail.com>,
        <andy.shevchenko@gmail.com>
References: <20230616101749.2083974-1-quic_srichara@quicinc.com>
 <20230616101749.2083974-6-quic_srichara@quicinc.com>
 <53721566-2a85-76cb-a4cf-2819f08dfc85@linaro.org>
 <8e209cd1-aa52-b947-bffd-15931af58391@quicinc.com>
 <159e36d6-7806-0424-4e9c-2e07584450fc@linaro.org>
From:   Sricharan Ramabadhran <quic_srichara@quicinc.com>
In-Reply-To: <159e36d6-7806-0424-4e9c-2e07584450fc@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: wR3NPGESCtnC_4eMxCGTAGiU11UPfF_n
X-Proofpoint-GUID: wR3NPGESCtnC_4eMxCGTAGiU11UPfF_n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-21_01,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 mlxscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0 phishscore=0
 adultscore=0 suspectscore=0 malwarescore=0 mlxlogscore=832 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307210038
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/20/2023 5:03 PM, Krzysztof Kozlowski wrote:
> On 20/07/2023 12:51, Sricharan Ramabadhran wrote:
>>>>    arch/arm64/boot/dts/qcom/Makefile             |   1 +
>>>>    .../arm64/boot/dts/qcom/ipq5018-rdp432-c2.dts |  72 +++++
>>>>    arch/arm64/boot/dts/qcom/ipq5018.dtsi         | 250 ++++++++++++++++++
>>>>    3 files changed, 323 insertions(+)
>>>>    create mode 100644 arch/arm64/boot/dts/qcom/ipq5018-rdp432-c2.dts
>>>>    create mode 100644 arch/arm64/boot/dts/qcom/ipq5018.dtsi
>>>>
>>>
>>> NAK, please do not merge.
>>>
>>> It turns out there are some problems here (pointed out by Hariharan K).
>>
>>     The changes from Hariharan K to rename the dts compatibles is not
>>     correct. So the compatibles/names in this series should be used.
>>     Hariharan can fix his series and re-post.
> 
> Thanks. Conflicting patches touching similar boards is however confusing
> me a bit...

  ok sure. Hariharan will fix his patches. I will anyways send V12 with
  your reviewed-tags just to avoid any confusion.

Regards,
  Sricharan
