Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFCE47A1B96
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 12:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234123AbjIOKAs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 06:00:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231341AbjIOKAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 06:00:43 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F12912D77;
        Fri, 15 Sep 2023 02:58:17 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38F6fTpL022594;
        Fri, 15 Sep 2023 09:58:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=O2ltSwAUi5DTn1NPduao40RCeYP4memzJu1C30yBptQ=;
 b=YH7IvOSDzsMsza2FLr10/uDJBw6X8wymtZMwm4ezvv9UuPboK5N2adYYAFsdNCNVUW0d
 /M+JDlVGRsqTBh5GRkNIykYFuyYvJ9H/YKANfNVohKkAgTcS4bM2ScF/AZZDmp3tC2Mg
 kjpgfZ1MSK4EbEAgrmUNk6Xtfp1BCoOjIzw6jyuCtuHn3EGQ91o0myFVcHvAlRmPPJX7
 bhpC8x3fBGLHH05cSVvVAtJ/3X11K5dY/bfONLKyl6AC4z8fSYEhBtYtZ2GMARv3Ln4/
 30/iFeRUQoanz07VdqgiYRxaXzM/OLG/LhYO91n9n8wj+yGYmwvrWguqJLPYvJQhdR3U gg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t4g070rav-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Sep 2023 09:58:02 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38F9w2vq026994
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Sep 2023 09:58:02 GMT
Received: from [10.253.32.174] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Fri, 15 Sep
 2023 02:57:58 -0700
Message-ID: <a1bb3ba8-0e46-c266-2cac-a45ab478032e@quicinc.com>
Date:   Fri, 15 Sep 2023 17:57:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v6 4/4] clk: qcom: add clock controller driver for
 qca8386/qca8084
Content-Language: en-US
To:     Stephen Boyd <sboyd@kernel.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <catalin.marinas@arm.com>,
        <conor+dt@kernel.org>, <konrad.dybcio@linaro.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <mturquette@baylibre.com>,
        <p.zabel@pengutronix.de>, <robh+dt@kernel.org>, <will@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_srichara@quicinc.com>
References: <20230901091823.30242-1-quic_luoj@quicinc.com>
 <20230901091823.30242-5-quic_luoj@quicinc.com>
 <27ae3297ad161fd67706db70b402db04.sboyd@kernel.org>
 <16d09acf-7bdd-04ee-6faf-936c0366df03@quicinc.com>
 <17681a9f756cc70a190c674c51b90140.sboyd@kernel.org>
 <5a4805f7-f802-b1ba-9804-59c0fe6c7f26@quicinc.com>
 <92058c25fb11b75ee0a2298a684825e9.sboyd@kernel.org>
 <f67b354c-8a4b-49f5-6275-66b7d614301a@quicinc.com>
 <82adb75659e0d278e25b65b0e81df99a.sboyd@kernel.org>
 <9952fa20-a27f-3240-cc49-5c5109febfc1@quicinc.com>
 <580f3934ab1171e27d785db7362c342d.sboyd@kernel.org>
From:   Jie Luo <quic_luoj@quicinc.com>
In-Reply-To: <580f3934ab1171e27d785db7362c342d.sboyd@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: JOaKFwz-EPgPvmgH2Avg06GT5vGa4hU9
X-Proofpoint-ORIG-GUID: JOaKFwz-EPgPvmgH2Avg06GT5vGa4hU9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-15_05,2023-09-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 clxscore=1015 phishscore=0 spamscore=0 mlxscore=0
 adultscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309150087
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/15/2023 12:30 AM, Stephen Boyd wrote:
> Quoting Jie Luo (2023-09-12 20:27:25)
>>
>>
>> On 9/13/2023 1:18 AM, Stephen Boyd wrote:
>>> Quoting Jie Luo (2023-09-12 05:07:02)
>>>>
>>>> and freq_tbl are necessary to this clock.
>>>
>>> I still don't see why the freq_tbl is necessary.
>>
>> Hi Stephen,
>> For clk_rcg2_ops, freq_tbl is used to find the closest rate to decided
>> the parent clock, the configuration of clock source and clock divider
>> are saved in the freq_tbl to configure the RCG hardware register, the
>> mapping of parent clock and hardware register value is decided by the
>> freq_tbl for the RCG clock.
> 
> The divider is always 1. The frequency is the frequency of the parent.
> The two pieces of information are already known without the frequency
> table. Why is it needed?

Hi Stephen,
For mac0 and mac5 RCG clock, it is true with divider 1, since these two 
MACs are connected with CPU port, which is always the fix link speed, 
the clock rate is always 312.5M or 125M, in this case with multiple 
parent clocks and divider 1, it seems there is no special RCG clock ops 
for it currently, so we leverage the clock ops clk_rcg2_ops.

For other MACs(1-4), which are connected with physical port, the link 
speed is dynamically changed, and the divider is different for the 
different link speed, such as the mac1 clock freq table as below.

static const struct freq_tbl ftbl_nss_cc_mac1_tx_clk_src[] = { 

         F(25000000, P_UNIPHY1_TX312P5M, 12.5, 0, 0), 

         F(25000000, P_UNIPHY1_RX312P5M, 12.5, 0, 0), 

         F(50000000, P_XO, 1, 0, 0), 

         F(125000000, P_UNIPHY1_TX312P5M, 2.5, 0, 0), 

         F(125000000, P_UNIPHY1_RX312P5M, 2.5, 0, 0), 

         F(312500000, P_UNIPHY1_TX312P5M, 1, 0, 0), 

         F(312500000, P_UNIPHY1_RX312P5M, 1, 0, 0), 

         { } 

};

Thanks,
Jie.
