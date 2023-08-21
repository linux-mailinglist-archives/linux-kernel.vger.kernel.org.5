Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7BED7820FE
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 02:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232228AbjHUAwk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 20:52:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231135AbjHUAwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 20:52:38 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CFA7A3;
        Sun, 20 Aug 2023 17:52:37 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37L0d0on018178;
        Mon, 21 Aug 2023 00:52:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=0cAXe53tynITfz5RBKpIn/dZnQaVzOOKvHce/rdR030=;
 b=A5qEpc0Wk9lvh55XlCYAE9tJvNshWn1c7SnsRFGPqskC7EKQLCiM8AW1Uz128+ERBQPE
 Cg8Vj2nQUF1vo9Xl6zkYTg/nfp44U37+jy7bV2oya6hXqT2HXsD+L0KUFO/pSKPxwbP/
 vfSIcRBhbNgA0kV8uMLlWvyUhC/eJksawyvq5/katLQHhFI605mp+i6j8mE/WXTc3+Fs
 P1XFyWhvtN/VruIZd+xQ5Xb/gn8FuHt6IxKPR91trn1VSPuf4vuJF3TYqmuDTDMD6Srg
 3v9KOWSKAMtraZFtWCVVS9m3LWKfxbSGyZUnz7ABjIiPAk5wcj9IIgzvQvXbW61GbDNZ KA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sjn2rac6d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Aug 2023 00:52:18 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37L0qHwL013652
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Aug 2023 00:52:17 GMT
Received: from [10.216.58.121] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Sun, 20 Aug
 2023 17:52:12 -0700
Message-ID: <1cadb40e-b655-4b9b-9189-dfdb22a2c234@quicinc.com>
Date:   Mon, 21 Aug 2023 06:22:09 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: crypto: qcom,prng: Add SM8450
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <konrad.dybcio@linaro.org>
CC:     <agross@kernel.org>, <andersson@kernel.org>, <conor+dt@kernel.org>,
        <davem@davemloft.net>, <devicetree@vger.kernel.org>,
        <herbert@gondor.apana.org.au>, <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <marijn.suijten@somainline.org>,
        <robh+dt@kernel.org>, <vkoul@kernel.org>
References: <20230811-topic-8450_prng-v1-1-01becceeb1ee@linaro.org>
 <20230818161720.3644424-1-quic_omprsing@quicinc.com>
 <2c208796-5ad6-c362-dabc-1228b978ca1d@linaro.org>
From:   Om Prakash Singh <quic_omprsing@quicinc.com>
In-Reply-To: <2c208796-5ad6-c362-dabc-1228b978ca1d@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 8gTHG1kh6CWdCEErtRFgcVdUnY8bE_yt
X-Proofpoint-ORIG-GUID: 8gTHG1kh6CWdCEErtRFgcVdUnY8bE_yt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-20_15,2023-08-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1011
 lowpriorityscore=0 mlxlogscore=999 spamscore=0 priorityscore=1501
 phishscore=0 suspectscore=0 mlxscore=0 impostorscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308210005
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I meant first one. using "qcom,rng-ee".

I am looking for generic compatible string for all SoCs for which core 
clock can be optional, same as we have "qcom,prng-ee".

If we are using SoC name in compatible string, for each SoC support we 
need to update qcom,prng.yaml file.

Please suggest approach that we can followed!

Thanks,
Om

On 8/19/2023 1:15 PM, Krzysztof Kozlowski wrote:
> On 18/08/2023 18:17, Om Prakash Singh wrote:
>> Instead of having SoC name "qcom,sm8450-prng-ee" we could use "qcom,rng-ee" as
>> new IP core is not longer pseudo random number generator. so "prng" can be
>> changed to "rng". Clock configuration is not needed on sm8550 as well. So it is
>> better to use generic compatible string.
> 
> I am not sure if I understand your point. You mean drop "p" in "prng" or
> drop specific compatible? The first depends in the block - if it is
> still pseudo. The second - why? That's contradictory to what is in the
> guidelines and what we have been pushing for very long time. Going
> against guidelines would require proper justification (and not some
> usual justification "I don't need it", because we talked about this many
> many times). One should not bring downstream poor practices to upstream,
> but the other way. You should fix downstream code.
> 
> Best regards,
> Krzysztof
> 
