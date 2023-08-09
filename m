Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A82C77672A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 20:27:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231719AbjHIS0z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 14:26:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231555AbjHIS0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 14:26:54 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B47E11987;
        Wed,  9 Aug 2023 11:26:53 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 379Gcupr026067;
        Wed, 9 Aug 2023 18:25:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=YCgiBM4BbljO43y/sO1vpGYc+7zxImzLm/TIWJmBVVk=;
 b=b+nuwSy5/Ek76gI8mD3B51q5kPqX+r0T+TPnM6dALzZ76O+vFtNzmAdVbSNR+B9CdJsW
 N+ucxzyf9IOqoeyZTi/aOBFs/wQHwz447mI3a6CbF5bSvl8xZqenP2Bw2u0nMpAReajT
 X2p4ZfvOszsr/xCm2GYqMdAK4qiBGGqfUtG7d93RszOrzw9fZfeaRlOMlhqziZ4+7rAO
 FWBXx7JntOSm3uxUHjwgzKjZgUOUE7JCFwNVcNUbjwsKdkgkClaG6ywZP9+VT6G4NjKC
 rOzSx/D85ayP7k+aP/LeS/olxJb+aFyr3VrSs8bV8R0IF443Tzn098/T2uKi92BTy0KP kQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sc5es1juc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Aug 2023 18:25:52 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 379IPpbm021701
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 9 Aug 2023 18:25:51 GMT
Received: from [10.226.59.182] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Wed, 9 Aug
 2023 11:25:49 -0700
Message-ID: <6615b537-c98d-3df2-df30-dd6873fda685@quicinc.com>
Date:   Wed, 9 Aug 2023 12:25:48 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH v2 1/6] arm64: dts: qcom: msm8998: Drop bus clock
 reference from MMSS SMMU
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
        Imran Khan <kimran@codeaurora.org>,
        "Rajendra Nayak" <quic_rjendra@quicinc.com>,
        Joonwoo Park <joonwoop@codeaurora.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel" <joro@8bytes.org>
CC:     Marijn Suijten <marijn.suijten@somainline.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>
References: <20230531-topic-8998_mmssclk-v2-0-34273e275c51@linaro.org>
 <20230531-topic-8998_mmssclk-v2-1-34273e275c51@linaro.org>
From:   Jeffrey Hugo <quic_jhugo@quicinc.com>
In-Reply-To: <20230531-topic-8998_mmssclk-v2-1-34273e275c51@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: qTPUuL47BmDAjV_eUU6eIGiDySv95qaf
X-Proofpoint-GUID: qTPUuL47BmDAjV_eUU6eIGiDySv95qaf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-09_16,2023-08-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=932
 spamscore=0 mlxscore=0 malwarescore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 bulkscore=0 impostorscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308090161
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/8/2023 3:44 AM, Konrad Dybcio wrote:
> The MMSS SMMU has been abusingly consuming the exposed RPM interconnect
> clock. Drop it.
> 
> Fixes: 05ce21b54423 ("arm64: dts: qcom: msm8998: Configure the multimedia subsystem iommu")
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>   arch/arm64/boot/dts/qcom/msm8998.dtsi | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
