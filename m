Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B56C78E94F
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 11:21:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237747AbjHaJVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 05:21:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbjHaJVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 05:21:32 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86799194;
        Thu, 31 Aug 2023 02:21:29 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37V9Eu5s018949;
        Thu, 31 Aug 2023 09:20:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=4jZc21W9PdSI2LGKTEf86sulrI++u/6vGxp5bfDAthw=;
 b=bNx3ikZV+C2uJapJ2juSR4wJnFNEOVFrGYwUOSHewrKrjbyurYfaMUkyL9YyFDa3EJyu
 g3OILv49mLJbCW0GRdVRdtAe+81vMb0PYAUKBfmSafEelHtXg7/ji34GV3ynnZ4/OZ9+
 r1o6Bl8YHB+Z5QKE+hi20RrfY04qIfAz3glUCKQEqhF9zqlo5rd69FICnNJCQUgEKc2b
 rMAXWRiBWI+6LYOR9hklFmsCe+Dse8AuAJ9JXfNCm9Eo++9+CqEDNS+itNeWiVO3WjRl
 J7yppjkMG0fJPVIksEhao0n88/Xnzj+VHSg00BIhFY9HHwnGItyCT2pArUZR56bqTYBb 2g== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3st0tatt2q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 31 Aug 2023 09:20:55 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37V9Kspm008106
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 31 Aug 2023 09:20:54 GMT
Received: from varda-linux.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Thu, 31 Aug 2023 02:20:48 -0700
Date:   Thu, 31 Aug 2023 14:50:44 +0530
From:   Varadarajan Narayanan <quic_varada@quicinc.com>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>, <vkoul@kernel.org>,
        <kishon@kernel.org>, <arnd@arndb.de>, <geert+renesas@glider.be>,
        <nfraprado@collabora.com>, <rafal@milecki.pl>, <peng.fan@nxp.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-phy@lists.infradead.org>
Subject: Re: [PATCH v11 2/4] arm64: dts: qcom: ipq5332: Add USB related nodes
Message-ID: <20230831092043.GA29822@varda-linux.qualcomm.com>
References: <cover.1693459976.git.quic_varada@quicinc.com>
 <c914b91c82ce51023571b701a5b91606a0791025.1693459976.git.quic_varada@quicinc.com>
 <CAA8EJpqRfgh5Ss696Vi=jAR-yFmBhCrpveD8txHGHoc8gRsJxQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAA8EJpqRfgh5Ss696Vi=jAR-yFmBhCrpveD8txHGHoc8gRsJxQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: jxbLggs_uiP3RD6M3FaqYg3EljIz15Qz
X-Proofpoint-ORIG-GUID: jxbLggs_uiP3RD6M3FaqYg3EljIz15Qz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-31_07,2023-08-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 spamscore=0 suspectscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 malwarescore=0 mlxlogscore=830
 adultscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308310084
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > +               usb: usb@8af8800 {
> > +                       compatible = "qcom,ipq5332-dwc3", "qcom,dwc3";
> > +                       reg = <0x08af8800 0x400>;
> > +
> > +                       interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
> > +                       interrupt-names = "hs_phy_irq";
> > +
> > +                       clocks = <&gcc GCC_USB0_MASTER_CLK>,
> > +                                <&gcc GCC_SNOC_USB_CLK>,
> > +                                <&gcc GCC_USB0_SLEEP_CLK>,
> > +                                <&gcc GCC_USB0_MOCK_UTMI_CLK>;
> > +                       clock-names = "core",
> > +                                     "iface",
> > +                                     "sleep",
> > +                                     "mock_utmi";
> > +
> > +                       resets = <&gcc GCC_USB_BCR>;
> > +
> > +                       qcom,select-utmi-as-pipe-clk;
> > +
> > +                       #address-cells = <1>;
> > +                       #size-cells = <1>;
> > +                       ranges;
> > +
> > +                       status = "disabled";
> > +
> > +                       usb2_0_dwc: usb@8a00000 {
>
> Since we have just seen a patch series adding USB 3 support to
> ipq5332, we know that the host is not 2.0-only. Thus the `2_0` part of
> the label doesn't make sense.
>
> Could you please change the label to be just usb_dwc (or usb0_dwc)?

Have posted v12 addressing this. Please take a look.

Thanks
Varada
