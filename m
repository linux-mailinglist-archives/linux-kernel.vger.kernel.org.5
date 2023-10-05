Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFC637BA11B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235458AbjJEOph (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 10:45:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238539AbjJEOkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:40:40 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ACA477644;
        Thu,  5 Oct 2023 07:12:58 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3958A1lg012152;
        Thu, 5 Oct 2023 09:57:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=TULmcO8l188rP5vtjqFrkpttdGmBezWswKLwM6tqT+k=;
 b=Qj7I3eeKQbICxxNLcDf5mcOHdj3UtQIdHYHW2wnUCyZU6x6xlHzHPqqBsPyfiY3rOw9A
 0b03WbvtDQ3foBmuYteEiAO4in9C/+s9ZBh/4D9ICpLfNdRljEkkN1OEanDWjzgsel8z
 iOS/6pFb3Tdht6vV4XSmSWp91aKKZos440p/+oTTJhIDQ6VMhhgAjtNNq1oHIqIk6B93
 iCfHE3/F6fwZpB8mi7iRyRs86dQGDqc7MSmKTViYighBvUG19YiOAhqV5cliyTt0oYKD
 GJau/y+OshTswMi4sZMfaI8RLcyJCpK5o6/k7tgysj3CB8AbYw8FLeVcE9qd5TKZmyPv mA== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3th8e1teue-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 Oct 2023 09:57:56 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3959vtAJ028265
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 5 Oct 2023 09:57:55 GMT
Received: from varda-linux.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Thu, 5 Oct 2023 02:57:49 -0700
Date:   Thu, 5 Oct 2023 15:27:45 +0530
From:   Varadarajan Narayanan <quic_varada@quicinc.com>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC:     <ilia.lin@kernel.org>, <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <rafael@kernel.org>,
        <viresh.kumar@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <quic_kathirav@quicinc.com>, <linux-pm@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>
Subject: Re: [PATCH v1 07/10] arm64: dts: qcom: ipq5332: populate the opp
 table based on the eFuse
Message-ID: <20231005095744.GA29795@varda-linux.qualcomm.com>
References: <cover.1693996662.git.quic_varada@quicinc.com>
 <a6d12e3b253d6a55d85f66979ba8b7d9c9ff6072.1693996662.git.quic_varada@quicinc.com>
 <CAA8EJppNsgUNgwadq9oM0_KyORNR5PBZGVZukN6MzAm2KPzC9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAA8EJppNsgUNgwadq9oM0_KyORNR5PBZGVZukN6MzAm2KPzC9g@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: oIcgO5TZ66_7muH1tFN8rHdOi-fpZKDV
X-Proofpoint-ORIG-GUID: oIcgO5TZ66_7muH1tFN8rHdOi-fpZKDV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-05_06,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 adultscore=0 priorityscore=1501 mlxscore=0 lowpriorityscore=0 spamscore=0
 bulkscore=0 mlxlogscore=999 malwarescore=0 impostorscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310050077
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 07, 2023 at 04:59:28PM +0300, Dmitry Baryshkov wrote:
> On Thu, 7 Sept 2023 at 08:23, Varadarajan Narayanan
> <quic_varada@quicinc.com> wrote:
> >
> > IPQ53xx have different OPPs available for the CPU based on
> > SoC variant. This can be determined through use of an eFuse
> > register present in the silicon.
> >
> > Add support to read the eFuse and populate the OPPs based on it.
> >
> > Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
> > Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> > ---
> >  arch/arm64/boot/dts/qcom/ipq5332.dtsi | 34 +++++++++++++++++++++++++++++++---
> >  1 file changed, 31 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/ipq5332.dtsi b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
> > index 82761ae..3ca3f34 100644
> > --- a/arch/arm64/boot/dts/qcom/ipq5332.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
> > @@ -91,11 +91,34 @@
> >         };
> >
> >         cpu_opp_table: opp-table-cpu {
> > -               compatible = "operating-points-v2";
> > +               compatible = "operating-points-v2-kryo-cpu";
> >                 opp-shared;
> > +               nvmem-cells = <&cpu_speed_bin>;
> > +               nvmem-cell-names = "speed_bin";
> > +
> > +               /*
> > +                * Listed all supported CPU frequencies and opp-supported-hw
> > +                * values to select CPU frequencies based on the limits fused.
> > +                * ------------------------------------------------------------
> > +                * Frequency     BIT3   BIT2   BIT1    BIT0    opp-supported-hw
> > +                *              1.0GHz 1.2GHz 1.5GHz No Limit
> > +                * ------------------------------------------------------------
> > +                * 1100000000     1      1      1       1            0xF
> > +                * 1500000000     0      0      1       1            0x3
> > +                * -----------------------------------------------------------
> > +                */
>
> This can probably go to the commit message instead.

Ok

> > +
> > +               opp-1100000000 {
> > +                       opp-hz = /bits/ 64 <1100000000>;
>
> But your table shows 1.0 GHz and 1.2 GHz instead of 1.1 GHz

Will update it.

> > +                       opp-microvolt = <850000>;
> > +                       opp-supported-hw = <0xF>;
> > +                       clock-latency-ns = <200000>;
> > +               };
> >
> > -               opp-1488000000 {
> > -                       opp-hz = /bits/ 64 <1488000000>;
> > +               opp-1500000000 {
> > +                       opp-hz = /bits/ 64 <1500000000>;
>
> So, 1.488 GHz or 1.5 GHz?

1.5 GHz

> > +                       opp-microvolt = <950000>;
>
> Which regulator is controlled by this microvolt?

Based on the SKU, the XBL sets up the regulator to provide 950000uV
on CPUs capable of running 1.5G and 850000uV on other SKUs. Linux
doesn't control it.

Thanks
Varada
> > +                       opp-supported-hw = <0x3>;
> >                         clock-latency-ns = <200000>;
> >                 };
> >         };
> > @@ -150,6 +173,11 @@
> >                         reg = <0x000a4000 0x721>;
> >                         #address-cells = <1>;
> >                         #size-cells = <1>;
> > +
> > +                       cpu_speed_bin: cpu_speed_bin@1d {
> > +                               reg = <0x1d 0x2>;
> > +                               bits = <7 2>;
> > +                       };
> >                 };
> >
> >                 rng: rng@e3000 {
> > --
> > 2.7.4
> >
>
>
> --
> With best wishes
> Dmitry
