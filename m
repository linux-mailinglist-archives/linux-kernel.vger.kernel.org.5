Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6B8F7C6AA4
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 12:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343772AbjJLKLm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 06:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347073AbjJLKLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 06:11:39 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03CBDD8;
        Thu, 12 Oct 2023 03:11:36 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39CA7OIX001877;
        Thu, 12 Oct 2023 10:11:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=vAX90PP85Yb4sr/auFBh5RzBVFlgXiKa9q/nycAJa5g=;
 b=dMQGfWSYHjhl7XPE/2tqtRx5/2iUAS/M3MR4ZuTmIvjGMUsXO9JZE9NgJ8xFgCYo1yC+
 iBT4t+X5Vk6WSAPPpVT829+mfU7ERHTbCR9xFChNpY67/64Umq+LBLHA/IbS7TjIPPSq
 OYdAyA9uRiN+ZI1pL0Cla9ygLpV/Gi226QFR+WxqPi9yvNLclRdx3r2hWJnukbqrXKnp
 w6ohUgosodf31LPX4l2R61cfBbxZCGgxvlPeW5i5tUhRsAyGDRyz/sv/v6eiIP9N0jJ4
 JG+Rinwak9SldUNYGRdAMK74cQtVks16AP5/3m6xkggh3bdYbEWlfhCJYsPv9mwovfDQ VQ== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tnv1raj0h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Oct 2023 10:11:31 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39CABU8O027544
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Oct 2023 10:11:30 GMT
Received: from varda-linux.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Thu, 12 Oct 2023 03:11:24 -0700
Date:   Thu, 12 Oct 2023 15:41:20 +0530
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
Message-ID: <20231012101119.GA32310@varda-linux.qualcomm.com>
References: <cover.1693996662.git.quic_varada@quicinc.com>
 <a6d12e3b253d6a55d85f66979ba8b7d9c9ff6072.1693996662.git.quic_varada@quicinc.com>
 <CAA8EJppNsgUNgwadq9oM0_KyORNR5PBZGVZukN6MzAm2KPzC9g@mail.gmail.com>
 <20231005095744.GA29795@varda-linux.qualcomm.com>
 <CAA8EJpr124fymnbZ1bO=Dbbxavn3Z=1xOPmFRPnfSp-UB3p6OQ@mail.gmail.com>
 <20231005144205.GB29795@varda-linux.qualcomm.com>
 <CAA8EJppJVzjyKjggkmi8uHGSPaHJ2ChsUV4Bfd0yNNDu3R+Kow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAA8EJppJVzjyKjggkmi8uHGSPaHJ2ChsUV4Bfd0yNNDu3R+Kow@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: IdE7GPfk822aRGIe1QEeTC7ZFG-hDa_t
X-Proofpoint-GUID: IdE7GPfk822aRGIe1QEeTC7ZFG-hDa_t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-12_05,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 phishscore=0
 mlxscore=0 clxscore=1015 spamscore=0 suspectscore=0 adultscore=0
 bulkscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2309180000 definitions=main-2310120083
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 05, 2023 at 10:39:55PM +0300, Dmitry Baryshkov wrote:
> On Thu, 5 Oct 2023 at 17:42, Varadarajan Narayanan
> <quic_varada@quicinc.com> wrote:
> >
> > On Thu, Oct 05, 2023 at 02:39:43PM +0300, Dmitry Baryshkov wrote:
> > > On Thu, 5 Oct 2023 at 12:58, Varadarajan Narayanan
> > > <quic_varada@quicinc.com> wrote:
> > > >
> > > > On Thu, Sep 07, 2023 at 04:59:28PM +0300, Dmitry Baryshkov wrote:
> > > > > On Thu, 7 Sept 2023 at 08:23, Varadarajan Narayanan
> > > > > <quic_varada@quicinc.com> wrote:
> > > > > >
> > > > > > IPQ53xx have different OPPs available for the CPU based on
> > > > > > SoC variant. This can be determined through use of an eFuse
> > > > > > register present in the silicon.
> > > > > >
> > > > > > Add support to read the eFuse and populate the OPPs based on it.
> > > > > >
> > > > > > Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
> > > > > > Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> > > > > > ---
> > > > > >  arch/arm64/boot/dts/qcom/ipq5332.dtsi | 34 +++++++++++++++++++++++++++++++---
> > > > > >  1 file changed, 31 insertions(+), 3 deletions(-)
> > > > > >
> > > > > > diff --git a/arch/arm64/boot/dts/qcom/ipq5332.dtsi b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
> > > > > > index 82761ae..3ca3f34 100644
> > > > > > --- a/arch/arm64/boot/dts/qcom/ipq5332.dtsi
> > > > > > +++ b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
> > > > > > @@ -91,11 +91,34 @@
> > > > > >         };
> > > > > >
> > > > > >         cpu_opp_table: opp-table-cpu {
> > > > > > -               compatible = "operating-points-v2";
> > > > > > +               compatible = "operating-points-v2-kryo-cpu";
> > > > > >                 opp-shared;
> > > > > > +               nvmem-cells = <&cpu_speed_bin>;
> > > > > > +               nvmem-cell-names = "speed_bin";
> > > > > > +
> > > > > > +               /*
> > > > > > +                * Listed all supported CPU frequencies and opp-supported-hw
> > > > > > +                * values to select CPU frequencies based on the limits fused.
> > > > > > +                * ------------------------------------------------------------
> > > > > > +                * Frequency     BIT3   BIT2   BIT1    BIT0    opp-supported-hw
> > > > > > +                *              1.0GHz 1.2GHz 1.5GHz No Limit
> > > > > > +                * ------------------------------------------------------------
> > > > > > +                * 1100000000     1      1      1       1            0xF
> > > > > > +                * 1500000000     0      0      1       1            0x3
> > > > > > +                * -----------------------------------------------------------
> > > > > > +                */
> > > > >
> > > > > This can probably go to the commit message instead.
> > > >
> > > > Ok
> > > >
> > > > > > +
> > > > > > +               opp-1100000000 {
> > > > > > +                       opp-hz = /bits/ 64 <1100000000>;
> > > > >
> > > > > But your table shows 1.0 GHz and 1.2 GHz instead of 1.1 GHz
> > > >
> > > > Will update it.
> > > >
> > > > > > +                       opp-microvolt = <850000>;
> > > > > > +                       opp-supported-hw = <0xF>;
> > > > > > +                       clock-latency-ns = <200000>;
> > > > > > +               };
> > > > > >
> > > > > > -               opp-1488000000 {
> > > > > > -                       opp-hz = /bits/ 64 <1488000000>;
> > > > > > +               opp-1500000000 {
> > > > > > +                       opp-hz = /bits/ 64 <1500000000>;
> > > > >
> > > > > So, 1.488 GHz or 1.5 GHz?
> > > >
> > > > 1.5 GHz
> > > >
> > > > > > +                       opp-microvolt = <950000>;
> > > > >
> > > > > Which regulator is controlled by this microvolt?
> > > >
> > > > Based on the SKU, the XBL sets up the regulator to provide 950000uV
> > > > on CPUs capable of running 1.5G and 850000uV on other SKUs. Linux
> > > > doesn't control it.
> > >
> > > Then why do you need this property here in the first place?
> >
> > I get these errors without this property
> >
> > [    1.018065] cpu cpu0: opp_parse_microvolt: opp-microvolt missing although OPP managing regulators
>
> But you have said that "Linux doesn't control it" [the regulator]!

Got confused between the ipq9574 and ipq5332 patches.
Have removed and addressed other comments too and
posted v2 - https://lore.kernel.org/linux-arm-msm/cover.1697101543.git.quic_varada@quicinc.com/

Please take a look.

Thanks
Varada
>
> > [    1.018074] cpu cpu0: _of_add_opp_table_v2: Failed to add OPP, -22
