Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E49D675173E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 06:15:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233619AbjGMEPh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 00:15:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232553AbjGMEPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 00:15:34 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EBAE170E;
        Wed, 12 Jul 2023 21:15:33 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36D2vfb6014648;
        Thu, 13 Jul 2023 04:14:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=lo5w9wU2QVl/tyJfc7XjBLXmBUMX7AYxuEXj6BLmjOw=;
 b=RfJI/uHotS5VcQYzMhAvjsVGoNiIK8lHB5pLA6Qg+J2uCLSvE94HUSv/FD2rCBBIgTyx
 bjzCVzpI8e8seTTIe+KUrPKzItIXxwf2ezh+wtgmHqDlsO9/utLqFeSV7rWtmTAtFVfk
 tyiTqK+nu+fA8fToeTuDstoQZxNgj/w/cs6HWg6XyfLA9/bvpxPFDMrsCDZlrEOP3RQs
 QoNCifMWsVgEPd/BwHdrIaWw0RWXFyTkARM1DuWXLTIGDdK0BhsGSxhzmZSIv5TF4jHb
 3pZpk7Ee/JajV6jGPtFa3iP1nmKn3MfbYFB7hDiMAv8l9OzQGc+whcWSp3FKuCRDztIW 5A== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rse45kama-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Jul 2023 04:14:54 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36D4Eqjv023263
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Jul 2023 04:14:52 GMT
Received: from varda-linux.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 12 Jul 2023 21:14:44 -0700
Date:   Thu, 13 Jul 2023 09:44:40 +0530
From:   Varadarajan Narayanan <quic_varada@quicinc.com>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <vkoul@kernel.org>,
        <kishon@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <gregkh@linuxfoundation.org>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <p.zabel@pengutronix.de>, <arnd@arndb.de>,
        <geert+renesas@glider.be>, <neil.armstrong@linaro.org>,
        <nfraprado@collabora.com>, <rafal@milecki.pl>,
        <quic_srichara@quicinc.com>, <quic_varada@quicinc.org>,
        <quic_wcheng@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v4 4/6] arm64: dts: qcom: ipq5332: Add USB related nodes
Message-ID: <20230713041439.GA24906@varda-linux.qualcomm.com>
References: <cover.1689160067.git.quic_varada@quicinc.com>
 <1f99805b6437aa8d6eaa4663e8d27b98ee595f00.1689160067.git.quic_varada@quicinc.com>
 <13555184-1708-befd-1f2c-5e6f7e04a6ce@linaro.org>
 <0f98360a-6d88-9a8b-5d60-3d6120e0640f@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <0f98360a-6d88-9a8b-5d60-3d6120e0640f@linaro.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: AhuY4QKQugtt-AIl-fWparknQC9pZlTV
X-Proofpoint-ORIG-GUID: AhuY4QKQugtt-AIl-fWparknQC9pZlTV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-13_01,2023-07-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 spamscore=0 malwarescore=0 mlxlogscore=762
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307130036
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2023 at 03:28:43PM +0300, Dmitry Baryshkov wrote:
> On 12/07/2023 15:04, Krzysztof Kozlowski wrote:
> >On 12/07/2023 13:38, Varadarajan Narayanan wrote:
> >>Add USB phy and controller nodes.
> >>
> >>Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> >>---
> >>v4:
> >>	Change node name
> >>	Remove blank line
> >>	'make CHECK_DTBS=y DT_SCHEMA_FILES=qcom qcom/ipq5332-rdp441.dtb' passed
> >>v1:
> >>	Rename phy node
> >>	Change compatible from m31,ipq5332-usb-hsphy -> qcom,ipq5332-usb-hsphy
> >>	Remove 'qscratch' from phy node
> >>	Fix alignment and upper-case hex no.s
> >>	Add clock definition for the phy
> >>	Remove snps,ref-clock-period-ns as it is not used. dwc3_ref_clk_period()
> >>	in dwc3/core.c takes the frequency from ref clock and calculates fladj
> >>	as appropriate.
> >>---
> >>  arch/arm64/boot/dts/qcom/ipq5332.dtsi | 53 +++++++++++++++++++++++++++++++++++
> >>  1 file changed, 53 insertions(+)
> >>
> >>diff --git a/arch/arm64/boot/dts/qcom/ipq5332.dtsi b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
> >>index 8bfc2db..8118356 100644
> >>--- a/arch/arm64/boot/dts/qcom/ipq5332.dtsi
> >>+++ b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
> >>@@ -405,6 +405,59 @@
> >>  				status = "disabled";
> >>  			};
> >>  		};
> >>+
> >>+		usbphy0: usb-phy@7b000 {
> >>+			compatible = "qcom,ipq5332-usb-hsphy";
> >>+			reg = <0x0007b000 0x12c>;
> >>+
> >>+			clocks = <&gcc GCC_USB0_PHY_CFG_AHB_CLK>;
> >>+			clock-names = "cfg_ahb";
> >>+
> >>+			resets = <&gcc GCC_QUSB2_0_PHY_BCR>;
> >>+
> >>+			status = "disabled";
> >>+		};
> >>+
> >>+		usb2: usb2@8a00000 {
> >
> >So you responded to my comments, wait ten minutes and send v2? No need
> >to wait for my feedback, right?
> >
> >No, it's not ok. This is "usb", not "usb2". Are you saying you have
> >second device with the same address?
>
> Just to emphasise, it's the node name `usb2', which is not fine. DT label
> `usb2' is (hopefully) fine.

Thanks for the clarification. Will post a new patch.

-Varada
