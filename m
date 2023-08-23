Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAB44784FF5
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 07:19:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232656AbjHWFT5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 01:19:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjHWFT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 01:19:56 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 859F6E54;
        Tue, 22 Aug 2023 22:19:54 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37N5AdRQ008203;
        Wed, 23 Aug 2023 05:19:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=ffU8XLwHia6pXSWwNF3YYdt/MwTvusfnebAOPFWSH+g=;
 b=LmgmENtWB8wH0bxjVxUvTX8z7TZzCsfy6HxKpunUSOOWBP3/CSy8IlNPBtMzC1Ic+76a
 x02Yy3kZEBX6zAo5UpNzxlsVBeekvLGe4KOO1+2lBzm+ScgFz3Iz6pPYHG9o25QMk7dw
 EIBWEEOV/GuGLPwYKslH1/Vq29PXmPXL+cozpY8xLWzO5QOAB+jPI12XX7L+PEsmPdyG
 4c4we+2Y88+QUbMgQO2HeJLmmYL/atwZmSSiL6NcNLu2AuHLVYdibMYYVivR3u+C3xw0
 nVtf2UZHuxBdHwId8h3f0xLfKtiBhcxn/Tko35g8zotSqwfXKaU7/DN1A8gnF+/k2+fr vA== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sn25vh727-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Aug 2023 05:19:21 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37N5IxSI015450
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Aug 2023 05:18:59 GMT
Received: from varda-linux.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Tue, 22 Aug 2023 22:18:54 -0700
Date:   Wed, 23 Aug 2023 10:48:50 +0530
From:   Varadarajan Narayanan <quic_varada@quicinc.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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
Subject: Re: [PATCH v9 2/4] arm64: dts: qcom: ipq5332: Add USB related nodes
Message-ID: <20230823051849.GA15057@varda-linux.qualcomm.com>
References: <cover.1692699472.git.quic_varada@quicinc.com>
 <556ee6c73a4235f52d071d98a344792daeadd228.1692699472.git.quic_varada@quicinc.com>
 <8792cced-62bc-d887-8b14-05f967f7f4ed@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <8792cced-62bc-d887-8b14-05f967f7f4ed@linaro.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: zhU1Oy1q33ZNz89i1CNqFb4iLHVsE2Hz
X-Proofpoint-GUID: zhU1Oy1q33ZNz89i1CNqFb4iLHVsE2Hz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-23_02,2023-08-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=812
 phishscore=0 adultscore=0 clxscore=1015 malwarescore=0 suspectscore=0
 bulkscore=0 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308230049
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 22, 2023 at 01:40:57PM +0200, Krzysztof Kozlowski wrote:
> On 22/08/2023 12:29, Varadarajan Narayanan wrote:
> > Add USB phy and controller nodes.
> >
> > Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> > ---
> > v9:
> > 	usb2@8a00000 -> usb@8a00000
> > 	"make ARCH=arm64 -j 16 CHECK_DTBS=y DT_SCHEMA_FILES=qcom,ipq5332-usb-hsphy.yaml dtbs_check" passed
>
> I asked about W=1.
>
>
> > v6:
> > 	Remove clock names
> > 	Move the nodes to address sorted location
> > v5:
> > 	Use generic phy instead of usb-phy
> > 	'make CHECK_DTBS=y DT_SCHEMA_FILES=qcom dtbs_check' passed
> > 	'DT_CHECKER_FLAGS='-v -m' DT_SCHEMA_FILES=qcom dt_binding_check' passed
> > v4:
> > 	Change node name
> > 	Remove blank line
> > 	'make CHECK_DTBS=y DT_SCHEMA_FILES=qcom qcom/ipq5332-rdp441.dtb' passed
> > v1:
> > 	Rename phy node
> > 	Change compatible from m31,ipq5332-usb-hsphy -> qcom,ipq5332-usb-hsphy
> > 	Remove 'qscratch' from phy node
> > 	Fix alignment and upper-case hex no.s
> > 	Add clock definition for the phy
> > 	Remove snps,ref-clock-period-ns as it is not used. dwc3_ref_clk_period()
> > 	in dwc3/core.c takes the frequency from ref clock and calculates fladj
> > 	as appropriate.
> > ---
> >  arch/arm64/boot/dts/qcom/ipq5332.dtsi | 55 +++++++++++++++++++++++++++++++++++
> >  1 file changed, 55 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/ipq5332.dtsi b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
> > index 8bfc2db..e6baf69 100644
> > --- a/arch/arm64/boot/dts/qcom/ipq5332.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
> > @@ -145,6 +145,19 @@
> >  		#size-cells = <1>;
> >  		ranges = <0 0 0 0xffffffff>;
> >
> > +		usbphy0: phy@7b000 {
> > +			compatible = "qcom,ipq5332-usb-hsphy";
> > +			reg = <0x0007b000 0x12c>;
> > +
> > +			clocks = <&gcc GCC_USB0_PHY_CFG_AHB_CLK>;
> > +
> > +			resets = <&gcc GCC_QUSB2_0_PHY_BCR>;
> > +
> > +			#phy-cells = <0>;
> > +
> > +			status = "disabled";
> > +		};
> > +
> >  		qfprom: efuse@a4000 {
> >  			compatible = "qcom,ipq5332-qfprom", "qcom,qfprom";
> >  			reg = <0x000a4000 0x721>;
> > @@ -290,6 +303,48 @@
> >  			status = "disabled";
> >  		};
> >
> > +		usb: usb@8a00000 {
> > +			compatible = "qcom,ipq5332-dwc3", "qcom,dwc3";
> > +			reg = <0x08af8800 0x400>;
>
> Still wrong address. I pointed it last time. Please fix it instead of
> just sending the same. If you do not agree, keep discussing. I could
> have make a mistake, but ignoring error and not responding is not the way.

Sorry, my mistake. I changed usb2 to usb and missed this.

Thanks
Varada
