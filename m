Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50E77793874
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 11:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237366AbjIFJjU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 05:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbjIFJjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 05:39:18 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB08E170E;
        Wed,  6 Sep 2023 02:39:14 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3869QNGv030584;
        Wed, 6 Sep 2023 09:39:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=WcoaMstEcb9PYJs3c0I4Hwl2EMVk75QAJ5EMvaI1MG8=;
 b=epy1vVLjlBoWHZI6euEDpxRmXr71IE9HdrHqrk9fPruS1P85i1D9tKSDtKaKUO9dCjSQ
 UXNR6QG596+8HtYsyJy7UYYfu2xMGrjIEyWIsYNEXA52dl3iJaNDChojLeVBpLDVBSIS
 8RgJJoDrAqpnp6a355uUUk1Mi2xGZoCA9IPrBwx4AO6F2THTmtYRnT8RQLlphCGa6gZK
 z/Rgo2H4sEKPdr+7BpDjWuU7kEac7VRMcAgYBiuhfc8xu1BZ3Rh225l50yi3bTAVEY5g
 Hfc4aEEGVVoOvWvpTYOG5eNKQytMe9IbRJ1a8+OEtRNz8mcVOUSPbhiFn40xh2AYTmFJ Fw== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sww32ugs9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Sep 2023 09:39:10 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3869d8KU015556
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 6 Sep 2023 09:39:08 GMT
Received: from [10.201.2.96] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Wed, 6 Sep
 2023 02:39:02 -0700
Message-ID: <75abfafd-2065-258d-0964-e1c50f094ee5@quicinc.com>
Date:   Wed, 6 Sep 2023 15:08:59 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH RESEND 7/7] arm64: dts: qcom: include the GPLL0 as clock
 provider for IPQ mailbox
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        "Stephen Boyd" <sboyd@kernel.org>,
        Sricharan Ramabadhran <quic_srichara@quicinc.com>,
        Anusha Rao <quic_anusha@quicinc.com>,
        Devi Priya <quic_devipriy@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-clk@vger.kernel.org>
References: <20230904-gpll_cleanup-v1-0-de2c448f1188@quicinc.com>
 <20230904-gpll_cleanup-v1-7-de2c448f1188@quicinc.com>
 <cbb530b9-224b-4b6f-8551-dd8340a59408@linaro.org>
From:   Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
In-Reply-To: <cbb530b9-224b-4b6f-8551-dd8340a59408@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: NpWrelN3wKnrjE-udJJW4keua5sE6v5n
X-Proofpoint-GUID: NpWrelN3wKnrjE-udJJW4keua5sE6v5n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-06_03,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 clxscore=1015 suspectscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0
 mlxlogscore=736 mlxscore=0 priorityscore=1501 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309060081
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/6/2023 3:03 PM, Konrad Dybcio wrote:
> On 6.09.2023 06:56, Kathiravan Thirumoorthy wrote:
>> While the kernel is booting up, APSS PLL will be running at 800MHz with
>> GPLL0 as source. Once the cpufreq driver is available, APSS PLL will be
>> configured to the rate based on the opp table and the source also will be
>> changed to APSS_PLL_EARLY.
>>
>> Also, dynamic scaling of CPUFreq is not supported on IPQ5332, so to switch
>> between the frequencies we need to park the APSS PLL in safe source,
>> here it is GPLL0 and then shutdown and bring up the APSS PLL in the
>> desired rate. So this patch is preparatory one to enable the CPUFreq on
>> IPQ5332.
>>
>> Signed-off-by: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
>> ---
> Please split this. Somebody reverting this in the future will have
> a hard time resolving conflicts.


Ack, will split it out in V2.


>
> Konrad
