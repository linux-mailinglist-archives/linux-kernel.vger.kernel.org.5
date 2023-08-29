Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70E3F78BD53
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 05:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235606AbjH2DoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 23:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232060AbjH2Dnk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 23:43:40 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33C6D132;
        Mon, 28 Aug 2023 20:43:38 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37T2jaS8010235;
        Tue, 29 Aug 2023 03:42:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Z6CQKthXnBocwvIyxiIGc9/KIuGkX0kydGJoMOjm8zk=;
 b=a+eUH+0+XNXwRU0hScjX9+oYCzGrMPW1DoXPBQ81O67wAMpzytAfEIwDi6tBs5G3hbDE
 DbIKXo50qwfcbro6dUuYPEQgsvARqgWMYdGZfvQ28bap9K6xDCd9sPrVsK3N+0aH7Opt
 x/7/n5tMJizIXZSC4TzazDpy83kPGXuhB4gg/FY8xHdvSxr+nvCMhq2xoR5w0G4yc6Oe
 H+3S4cvHYXvRFEf6mLZXsxsxRNPeEBn352Xb/Xu/GFHFlAvbjXFYJCh2Xv443YLmRY4r
 Eq8ClJYV+Df07gYjwVCaRT9JgN561b19VP4vZ7HMOt8uaN5x/Za3efao4EWhZsYXAwxC qw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3srt8s1utx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Aug 2023 03:42:58 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37T3gvEq018719
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Aug 2023 03:42:57 GMT
Received: from [10.216.21.12] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Mon, 28 Aug
 2023 20:42:49 -0700
Message-ID: <4e772f6b-93ae-2e82-265a-4a0a923250d9@quicinc.com>
Date:   Tue, 29 Aug 2023 09:12:45 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH V2 5/7] clk: qcom: Add NSS clock Controller driver for
 IPQ9574
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>, <andersson@kernel.org>,
        <agross@kernel.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <p.zabel@pengutronix.de>,
        <richardcochran@gmail.com>, <arnd@arndb.de>,
        <geert+renesas@glider.be>, <nfraprado@collabora.com>,
        <rafal@milecki.pl>, <peng.fan@nxp.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>
CC:     <quic_saahtoma@quicinc.com>
References: <20230825091234.32713-1-quic_devipriy@quicinc.com>
 <20230825091234.32713-6-quic_devipriy@quicinc.com>
 <790ead1e-7b15-4f88-bdf9-738b24531ef0@linaro.org>
From:   Devi Priya <quic_devipriy@quicinc.com>
In-Reply-To: <790ead1e-7b15-4f88-bdf9-738b24531ef0@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: PIhbqHLXmlV1da5t1ZROxDaLGYWmcxam
X-Proofpoint-GUID: PIhbqHLXmlV1da5t1ZROxDaLGYWmcxam
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-28_20,2023-08-28_04,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 priorityscore=1501 mlxlogscore=783 adultscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308290032
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/28/2023 6:05 PM, Konrad Dybcio wrote:
> On 25.08.2023 11:12, Devi Priya wrote:
>> Add Networking Sub System Clock Controller(NSSCC) driver for ipq9574 based
>> devices.
>>
>> Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
>> ---
> [...]
> 
>> +	[UBI3_CLKRST_CLAMP_ENABLE] = { 0x28A04, 9 },
> Please make all hex lowercase.
Okay
> 
> [...]
> 
>> +	[PPE_FULL_RESET] = { 0x28A08, 0, 1, 0x1E0000 },
> { .reg = 0x28a08, .bitmask = GENMASK(foo,bar) },
Sure, okay
> 
> [...]
> 
>> +	ret = devm_pm_runtime_enable(&pdev->dev);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	ret = devm_pm_clk_create(&pdev->dev);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	ret = of_pm_clk_add_clk(&pdev->dev, "nssnoc_nsscc");
>> +	if (ret < 0) {
>> +		dev_err(&pdev->dev, "Failed to acquire nssnoc_nsscc clock\n");
>> +		return ret;
> dev_err_probe, everywhere?
Okay

Thanks,
Devi Priya
> 
> Konrad
