Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D989785016
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 07:50:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232744AbjHWFuf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 01:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231815AbjHWFue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 01:50:34 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4096E57;
        Tue, 22 Aug 2023 22:50:32 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37N5V4qO000308;
        Wed, 23 Aug 2023 05:50:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=cbEULeFlYu45Guxxob7axT5sbHmGemufvkzvuYW7UIA=;
 b=OdkOWwhc2BxfXC6WRTBfPGMhGlSuo53uJqsp/xvtqeOGw5IG4kK1Ppw2zNThKE2MFKlw
 81Vsn6WVIPYOIHM0y2SigxRxWwz6AHaaVwbJv32qlz9u7TtfbWLICzIZLuCjskNUyVOb
 aocWFsl0jpQnEYNbnvFY39RAzz388r0v3/Fjtydxrph3TnMM7drBZ/lUhMQwToE8OuD5
 ehFNULUTCxPqXISURhqwM0oIh7uj97JGFAW7inOSXS6aRaQtGfNrcEFqhUhBcrM0KIjW
 nSM2x3UShIsttp0Kx8c0gkotmHgnHiU0oUMs8xN/zX9g6IpJ9Z+qArnHVNdkDQa2Ki8d Dg== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sn2cm145f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Aug 2023 05:50:17 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37N5oGlM001542
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Aug 2023 05:50:16 GMT
Received: from [10.253.13.101] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Tue, 22 Aug
 2023 22:50:12 -0700
Message-ID: <de210a27-882b-da4e-7a86-288c2caf5c7f@quicinc.com>
Date:   Wed, 23 Aug 2023 13:50:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v3 3/3] clk: qcom: add clock controller driver for
 qca8386/qca8084
To:     Stephen Boyd <sboyd@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <catalin.marinas@arm.com>,
        <conor+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <mturquette@baylibre.com>, <p.zabel@pengutronix.de>,
        <robh+dt@kernel.org>, <will@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_srichara@quicinc.com>
References: <20230810115419.25539-1-quic_luoj@quicinc.com>
 <20230810115419.25539-4-quic_luoj@quicinc.com>
 <9dec09fa-a5a3-416c-9b4d-4b4c4e10320b@linaro.org>
 <9a55016f-0049-f185-f2be-d138fe33384b@quicinc.com>
 <631d5a82-7d24-49cd-9868-74c7b3c08bcd@linaro.org>
 <6ebdcbdc-409c-0c08-1e5d-f9aa0b92c3b2@quicinc.com>
 <6e781c2d21e346cdd7f84c3b7a57dafc.sboyd@kernel.org>
Content-Language: en-US
From:   Jie Luo <quic_luoj@quicinc.com>
In-Reply-To: <6e781c2d21e346cdd7f84c3b7a57dafc.sboyd@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: _041J-ipfqwT3Y6d5iq8MMQeXuOdcKsh
X-Proofpoint-GUID: _041J-ipfqwT3Y6d5iq8MMQeXuOdcKsh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-23_03,2023-08-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0
 clxscore=1015 mlxlogscore=868 adultscore=0 priorityscore=1501 mlxscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308230052
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/23/2023 3:10 AM, Stephen Boyd wrote:
> Quoting Jie Luo (2023-08-14 03:58:26)
>>
>>
>> On 8/12/2023 6:56 PM, Konrad Dybcio wrote:
>>> My main point is, why can't you use qcom_cc_really_probe?
>>>
>>
>> Hi Konrad,
>> qcom_cc_really_probe is taking the platform_device as the input
>> parameter, but the nss_cc_qca8k_probe takes the mdio_device as the probe
>> parameter.
> 
> There's no real reason why it takes a platform device instead of a plain
> struct device. You can have an earlier patch change that function to
> take a struct device instead.

Okay, thanks Stephen for the comments, i will update it to use "struct 
device" in the next version.
