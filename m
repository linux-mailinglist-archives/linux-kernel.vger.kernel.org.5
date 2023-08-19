Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 751267817A7
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 08:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245740AbjHSGWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 02:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245698AbjHSGWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 02:22:02 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63CC93AB6;
        Fri, 18 Aug 2023 23:22:01 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37J6Ljq1008858;
        Sat, 19 Aug 2023 06:21:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=5pltigGTmCAd54+DBKzSWvMYWGt8jHWwbv3v95uSi3Y=;
 b=BzZXw8TDJNO5FyFPWKSZ6fKNTU9v/VWY5gQigmYkCtcSLUyWlfxu/fKh5R4x9PGW9rhm
 5jxL+XUvZIt1AJ6Ct/mFyhNvtzeFL619VPEyw3TH6guv+ETrFxqSChyoMmvAnoLWVTy2
 SbNF1QAdLV0i7x9aNlZUaD9H9Uxg9Es3CT+nph1oN9HBJHKNoCd4CH6Aq0vpmu8iIWgl
 75atVSF2oDaXdKPom/vtH6ngmNpmPBeQ5SfCOhNCVQfdTL46xFrjDFsGQa1c0KvT9uvx
 8/hx2C8TqZC6Wv7wXcUMnluOhQcTom1boSxzqLJ11d0hsaJ/v1vb5ZDoYA4oyV/2rTCA sw== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sjq1f02hw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 19 Aug 2023 06:21:45 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37J6Ljiv025217
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 19 Aug 2023 06:21:45 GMT
Received: from [10.253.35.175] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Fri, 18 Aug
 2023 23:21:40 -0700
Message-ID: <38627095-a92d-ea8b-56b6-7a4440fb6635@quicinc.com>
Date:   Sat, 19 Aug 2023 14:21:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v4 3/4] clk: qcom: common: add _qcom_cc_really_probe
To:     Bjorn Andersson <andersson@kernel.org>
CC:     <agross@kernel.org>, <konrad.dybcio@linaro.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <p.zabel@pengutronix.de>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_srichara@quicinc.com>
References: <20230815085205.9868-1-quic_luoj@quicinc.com>
 <20230815085205.9868-4-quic_luoj@quicinc.com>
 <2dcu7jjwd2bhjbzxrxbfif566nupznb5n4oadnqha4h45w2n2g@4uy2pxkj5bvj>
 <6ee2129b-04c6-4978-03d6-835e3a10e665@quicinc.com>
 <4n3vqstyhknanmzx4swwjg4ueaqq2tbrxadnyrx3bchffyf7qr@yh4bik4rfsgm>
Content-Language: en-US
From:   Jie Luo <quic_luoj@quicinc.com>
In-Reply-To: <4n3vqstyhknanmzx4swwjg4ueaqq2tbrxadnyrx3bchffyf7qr@yh4bik4rfsgm>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: IeW0Q28AeRBq6m9ZbrrPWqdojJg5Jpnn
X-Proofpoint-ORIG-GUID: IeW0Q28AeRBq6m9ZbrrPWqdojJg5Jpnn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-19_04,2023-08-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 adultscore=0 impostorscore=0 mlxlogscore=871 lowpriorityscore=0
 suspectscore=0 mlxscore=0 phishscore=0 spamscore=0 priorityscore=1501
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308190058
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/19/2023 10:54 AM, Bjorn Andersson wrote:
> On Fri, Aug 18, 2023 at 04:35:52PM +0800, Jie Luo wrote:
>> On 8/18/2023 11:14 AM, Bjorn Andersson wrote:
>>> On Tue, Aug 15, 2023 at 04:52:04PM +0800, Luo Jie wrote:
> [..]
>>>> +int qcom_cc_really_probe(struct platform_device *pdev,
>>>> +			 const struct qcom_cc_desc *desc, struct regmap *regmap)
>>>
>>> Why do we want to keep this wrapper around?
>>>
>> There are many existed clock controller drivers using this wrapper
>> qcom_cc_really_probe, so i still keep this wrapper.
>>
>> do we need to remove this wrapper and update the existed drivers to use
>> _qcom_cc_really_probe?
> 
> Yes please. The additional API does not add value, but can be confusing,
> so let's invest the extra time in fixing up all the drivers to keep the
> interface clean.
> 
> Regards,
> Bjorn

Thanks Bjorn for the suggestion, will update this patch in the next version.
