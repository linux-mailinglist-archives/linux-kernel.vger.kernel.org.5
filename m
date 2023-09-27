Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A8FF7B03A6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 14:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231654AbjI0MNM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 08:13:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231638AbjI0MNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 08:13:06 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23046CFA;
        Wed, 27 Sep 2023 05:12:51 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38RATCso031345;
        Wed, 27 Sep 2023 12:12:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=GfLxy6NW7pVVRzAZZfz4B4qGDlxBa3LB37XO0ccyL3E=;
 b=C4IlZT8w51smZExqQpUoLSMuMxq52LFsTU5ZUqV67eODTFOQj7fOu2+AYURxeoxfeATz
 LFldxRo1Id3GnE3ARKLYpyGKw/UIZ9HR12Sjtdp7d4dX1szp/3W3FDhOgEIUWk9Rsg4Z
 cv8r5YLzUV4/A2a7Rj/AAwFVqXqXGgKuV3M29EukafiDS6fvcLH5VzD2IB7RRkrSi0g3
 g/NuxMKTZ1HHDCw0nGHj4zJmX1l47K69WCUh6Tu3+FEIG9MhVPGN3CGMkBJhWuUvYJYJ
 Rk9xlKA5PUzEOe89gJGsODrwqs3jVPLdw9fulLCsGkJ2tUsjZPRe18A7IuFVl/Xk456L Aw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tbv6638wy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Sep 2023 12:12:38 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38RCCbZr010161
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Sep 2023 12:12:37 GMT
Received: from [10.216.29.85] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Wed, 27 Sep
 2023 05:12:30 -0700
Message-ID: <f3eba136-74d4-4f54-b35d-ce3236db9f67@quicinc.com>
Date:   Wed, 27 Sep 2023 17:42:25 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/11] arm64: dts: qcom: ipq8074: include the GPLL0 as
 clock provider for mailbox
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Sricharan Ramabadhran" <quic_srichara@quicinc.com>,
        Gokul Sriram Palanisamy <quic_gokulsri@quicinc.com>,
        Varadarajan Narayanan <quic_varada@quicinc.com>,
        Anusha Rao <quic_anusha@quicinc.com>,
        Devi Priya <quic_devipriy@quicinc.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
References: <20230913-gpll_cleanup-v2-0-c8ceb1a37680@quicinc.com>
 <20230913-gpll_cleanup-v2-8-c8ceb1a37680@quicinc.com>
 <731f4e05-6205-432b-8cd5-29d5e1c2222d@linaro.org>
From:   Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
In-Reply-To: <731f4e05-6205-432b-8cd5-29d5e1c2222d@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: bgerQsRCE6GkEYH4JuOKW_26eZUJDDRV
X-Proofpoint-GUID: bgerQsRCE6GkEYH4JuOKW_26eZUJDDRV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-27_06,2023-09-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 mlxlogscore=730 bulkscore=0 phishscore=0 suspectscore=0
 clxscore=1015 impostorscore=0 mlxscore=0 adultscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309270102
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/27/2023 5:03 PM, Konrad Dybcio wrote:
> On 14.09.2023 08:59, Kathiravan Thirumoorthy wrote:
>> While the kernel is booting up, APSS PLL will be running at 800MHz with
>> GPLL0 as source. Once the cpufreq driver is available, APSS PLL will be
>> configured to the rate based on the opp table and the source also will
>> be changed to APSS_PLL_EARLY. So allow the mailbox to consume the GPLL0,
>> with this inclusion, CPU Freq correctly reports that CPU is running at
>> 800MHz rather than 24MHz.
>>
>> Signed-off-by: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
>> ---
> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>
> Konrad

Thanks Konrad.

I just realized that, in commit message, the statement "APSS PLL will be 
running at 800MHz" should be "APSS clock / CPU clock will be running at 
800MHz".

Bjorn, will you be able to fix it up while applying (all 4 DTS changes 
needs update) or shall I respin it?

Thanks,

Kathiravan T.

