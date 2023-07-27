Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E22F2764A01
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 10:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233757AbjG0IFT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 04:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233675AbjG0ID6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 04:03:58 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FC773C00;
        Thu, 27 Jul 2023 01:02:17 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36R6rZh5017211;
        Thu, 27 Jul 2023 08:01:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=NWEt3Gf5XIe1JMiXESztFMZIaTlUGfS2KTu3/Krr85w=;
 b=Nudrf/X+qOe5uFLIUqFfW8RwzxhqOqlNhfEDsFUZGTarW2OROiREPDzlsnLDeqBrwOW0
 A4py4NveEs1sO9X2KPECtp80NHAf8VtfFZonk7jJGQj3BsZCFBZHCeDUZrxADb2vQYEv
 GfFjYSfEetitC+ONYj50T0zyXh4I8PgEvXSqhHb+Us/QLPiKLLHOIikoIDH6koc3CJ/T
 FdWfn3Adcg8gNQxJ0+Hh1vEJ5lBRU54x8AlNsQT0/b8ciSpqwwLdHXbGv6HoNK1LYvRs
 U7NYHHmuEwv2aT0N2AACl53YR3GncqJa4i4XRuU7TvKzdNGnVuD/ylmMuWE/CfAUq6kp Rw== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s37g0hdct-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jul 2023 08:01:30 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36R81Tqq012702
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jul 2023 08:01:29 GMT
Received: from varda-linux.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Thu, 27 Jul 2023 01:01:23 -0700
Date:   Thu, 27 Jul 2023 13:31:19 +0530
From:   Varadarajan Narayanan <quic_varada@quicinc.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <vkoul@kernel.org>,
        <kishon@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <p.zabel@pengutronix.de>, <arnd@arndb.de>,
        <geert+renesas@glider.be>, <neil.armstrong@linaro.org>,
        <nfraprado@collabora.com>, <rafal@milecki.pl>,
        <john.garry@huawei.com>, <peng.fan@nxp.com>,
        <quic_srichara@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v6 1/5] dt-bindings: phy: qcom,m31: Document qcom,m31 USB
 phy
Message-ID: <20230727080118.GB15719@varda-linux.qualcomm.com>
References: <cover.1690439352.git.quic_varada@quicinc.com>
 <f88d5add717e90e136a701f39fe80d00f1052692.1690439352.git.quic_varada@quicinc.com>
 <5288c817-3cf8-2b8c-6187-30283353060f@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <5288c817-3cf8-2b8c-6187-30283353060f@linaro.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: BJIHtlvMweRfGPIoiRH10LDK0OgkG9k9
X-Proofpoint-ORIG-GUID: BJIHtlvMweRfGPIoiRH10LDK0OgkG9k9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-26_08,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 spamscore=0 impostorscore=0 mlxlogscore=999 phishscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 clxscore=1015
 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307270070
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2023 at 08:47:07AM +0200, Krzysztof Kozlowski wrote:
> On 27/07/2023 08:33, Varadarajan Narayanan wrote:
> > Document the M31 USB2 phy present in IPQ5332.
> >
> > Co-developed-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> > Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> > Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> > ---
>
>
> > +properties:
> > +  "#phy-cells":
> > +    const: 0
> > +
> > +  compatible:
> > +    items:
> > +      - const: qcom,ipq5332-usb-hsphy
>
> Please keep compatible as first property.
>
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    maxItems: 1
> > +
> > +  clock-names:
> > +    items:
> > +      - const: cfg_ahb
> > +
> > +  resets:
> > +    maxItems: 1
> > +
> > +  vdd-supply:
> > +    description:
> > +      Phandle to 5V regulator supply to PHY digital circuit.
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/clock/qcom,ipq5332-gcc.h>
> > +    usb2-phy@7b000 {
>
> This was actually better before as usb-phy, I don't know why did you
> changed. Especially that you already changed once to usb-phy and this
> got review tag. It's fine. If there is going to be resubmit then fix
> these two issues.

Based on Bjorn's and Rob's comments (https://lore.kernel.org/linux-arm-msm/20230724160136.GA3619408-robh@kernel.org/)
I assumed they preferred usb2-phy and hence changed. Will revert
back to usb-phy if I post another version.

> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Thanks
Varada
