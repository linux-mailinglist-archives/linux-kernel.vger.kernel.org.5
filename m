Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 126947A473A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 12:36:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241141AbjIRKgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 06:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240944AbjIRKfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 06:35:41 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81D59E4A;
        Mon, 18 Sep 2023 03:34:54 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38I9hXZg027122;
        Mon, 18 Sep 2023 10:34:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=T+txr2ye61IUfnpU9SRWfUYE35JY6BsBVJV5qifYwjc=;
 b=fkz3niR0S7/BLwO9foPYw/q6W3YKKfvyvLR/yup5Rdlryxz7IoGCZdYK16nB4gPJ+Xnc
 WnLLz67vUVOIKNl9ze9sOD1QeESe3/h4cTBr/d9WXqdUqde5K9xI24NDGgKF/YMwlFMH
 WZfCle+dScSwNSeYLulVOo/koFrKdTH6Hx+WeRjNuWi/OiKoc/5VLNghxGT96wB7NWAR
 H/y+aZX4JS7gVxMvxxkPv7WhRlUJr4xOlTC+Pzgff3s3shDC0OKpUs0D/TVTaceXYxR+
 EJvWWXBVjSCijj2TgRU9EG+yJQHbBRxLoAnHQXoST6ZCfkbW+3yVVW7fp2QyEkOVlu4x WQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t53ps2trg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Sep 2023 10:34:18 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38IAYGlN005858
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Sep 2023 10:34:16 GMT
Received: from [10.239.132.204] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Mon, 18 Sep
 2023 03:34:08 -0700
Message-ID: <1a7fdafb-e75e-46a1-94be-36a9c3c94c15@quicinc.com>
Date:   Mon, 18 Sep 2023 18:34:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/8] arm64: dts: qcom: sm4450: Add RPMH and Global
 clock controller
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <catalin.marinas@arm.com>
CC:     <geert+renesas@glider.be>, <arnd@arndb.de>,
        <neil.armstrong@linaro.org>, <nfraprado@collabora.com>,
        <rafal@milecki.pl>, <peng.fan@nxp.com>,
        <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <quic_tsoni@quicinc.com>,
        <quic_shashim@quicinc.com>, <quic_kaushalk@quicinc.com>,
        <quic_tdas@quicinc.com>, <quic_tingweiz@quicinc.com>,
        <quic_aiquny@quicinc.com>, <kernel@quicinc.com>,
        Ajit Pandey <quic_ajipan@quicinc.com>
References: <20230915021509.25773-1-quic_tengfan@quicinc.com>
 <20230915021509.25773-8-quic_tengfan@quicinc.com>
 <c4e95307-3f09-5704-e5ea-cb42befb9921@linaro.org>
From:   Tengfei Fan <quic_tengfan@quicinc.com>
In-Reply-To: <c4e95307-3f09-5704-e5ea-cb42befb9921@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: UJ96XdCTDZ-UeHyYLrp6swZMtqUMmrad
X-Proofpoint-GUID: UJ96XdCTDZ-UeHyYLrp6swZMtqUMmrad
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-18_02,2023-09-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 malwarescore=0 mlxlogscore=482 spamscore=0 bulkscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309180092
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 9/15/2023 3:22 PM, Krzysztof Kozlowski 写道:
> On 15/09/2023 04:15, Tengfei Fan wrote:
>> From: Ajit Pandey <quic_ajipan@quicinc.com>
>>
>> Add device node for RPMH and Global clock controller on Qualcomm
>> SM4450 platform.
>>
>> Signed-off-by: Ajit Pandey <quic_ajipan@quicinc.com>
>> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
> 
> Warnings in your code:
> sm4450-qrd.dtb: clock-controller@100000: clocks: [[28, 0], [29]] is too
> short
> 
> 
> 
> Best regards,
> Krzysztof
> 
Hi Krzyszrof,
Want to know how did you find this warning?
I cannot find this warning when I do dt check(make ARCH=arm64 
DT_CHECKER_FLAGS=-m dtbs_check) or kernel compile(make -j8 ARCH=arm64 
CROSS_COMPILE=aarch64-linux-gnu- Image.gz dtbs modules).

-- 
Thx and BRs,
Tengfei Fan
