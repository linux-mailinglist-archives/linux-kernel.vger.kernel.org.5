Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D9FD77B445
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 10:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234064AbjHNIgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 04:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232346AbjHNIfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 04:35:52 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B71E19C;
        Mon, 14 Aug 2023 01:35:51 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37E8Dlfo014154;
        Mon, 14 Aug 2023 08:35:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=qwGYKRRRJZy7n3umlavxW3NBP3HkUrUEnBJxfTTq5Mc=;
 b=eqmEe3xSGlfUQFPs7o1HW5VsB2Jmd37g/ylM8wjaj/W6Hh+ArlJ3pluPLlPZvIff9TKl
 vOOKTDpbVoRY6QvuGw48f1qltR+1e1ZKvo0TDRfW+l6dBmf20FcUnEt3fezYacfTxTnj
 GfaWaMTMvGvge9ccpN+kOuFz8hyImqaO26OeGLESlC1+4gJOIxDzgYlyCaBFnoD3ktgv
 CRtZKkMS4xkb5UaKfYa2QZ8lTgVMXImElPXBCVffyPxcW7VpT3tGILIFPxNZjBVBFvJx
 QrjPvMg7a5gSH3M+2sxxuEXdlKQs5jG7CdRNZG04iRktnjEjhRlg9a+/Wq+oDmo/T+9l 1A== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sffxt83k3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Aug 2023 08:35:15 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37E8ZEjU000903
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Aug 2023 08:35:14 GMT
Received: from varda-linux.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Mon, 14 Aug 2023 01:35:07 -0700
Date:   Mon, 14 Aug 2023 14:05:04 +0530
From:   Varadarajan Narayanan <quic_varada@quicinc.com>
To:     Vinod Koul <vkoul@kernel.org>
CC:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <kishon@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <p.zabel@pengutronix.de>, <arnd@arndb.de>,
        <geert+renesas@glider.be>, <nfraprado@collabora.com>,
        <rafal@milecki.pl>, <peng.fan@nxp.com>,
        <quic_srichara@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v7 2/5] phy: qcom-m31: Introduce qcom,m31 USB phy driver
Message-ID: <20230814083503.GA3490@varda-linux.qualcomm.com>
References: <cover.1691660905.git.quic_varada@quicinc.com>
 <b17b55b2ff2277bb9bfa99acdb2f98ed420dfb6e.1691660905.git.quic_varada@quicinc.com>
 <ZNXxja5HvVOtgliL@matsya>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZNXxja5HvVOtgliL@matsya>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: DZ06qSZka_sIK-LlSDnwfR2sZa7D37gN
X-Proofpoint-GUID: DZ06qSZka_sIK-LlSDnwfR2sZa7D37gN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-14_03,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=899 spamscore=0
 malwarescore=0 clxscore=1015 suspectscore=0 adultscore=0 bulkscore=0
 mlxscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308140079
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 11, 2023 at 09:30:05AM +0100, Vinod Koul wrote:
> On 10-08-23, 15:26, Varadarajan Narayanan wrote:
> > Add the M31 USB2 phy driver.
>	.
>	.
>	.
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/of_platform.h>
> > +#include <linux/of.h>
>
> do you need both headers..?
>
>	.
>	.
>	.
> > + #define FREQ_24MHZ			(GENMASK(6, 6) | GENMASK(4, 4))
>
> why not use bit :-)
>	.
>	.
>	.
> > +struct m31_phy_regs m31_ipq5332_regs[] = {
> > +	{ USB_PHY_CFG0, UTMI_PHY_OVERRIDE_EN, 0 },
> > +	{ USB_PHY_UTMI_CTRL5, POR_EN, 15 },
> > +	{ USB_PHY_FSEL_SEL, FREQ_SEL, 0 },
> > +	{ USB_PHY_HS_PHY_CTRL_COMMON0, COMMONONN | FREQ_24MHZ | RETENABLEN, 0 },
> > +	{ USB_PHY_UTMI_CTRL5, POR_EN, 0 },
> > +	{ USB_PHY_HS_PHY_CTRL2, USB2_SUSPEND_N_SEL | USB2_SUSPEND_N | USB2_UTMI_CLK_EN, 0 },
> > +	{ USB2PHY_USB_PHY_M31_XCFGI_11, XCFG_COARSE_TUNE_NUM  | XCFG_FINE_TUNE_NUM, 0 },
> > +	{ USB2PHY_USB_PHY_M31_XCFGI_4, HSTX_SLEW_RATE_565PS | PLL_CHARGING_PUMP_CURRENT_35UA |
> > +				       ODT_VALUE_38_02_OHM, 0 },
> > +	{ USB2PHY_USB_PHY_M31_XCFGI_1, USB2_0_TX_ENABLE, 0 },
> > +	{ USB2PHY_USB_PHY_M31_XCFGI_5, ODT_VALUE_45_02_OHM | HSTX_PRE_EMPHASIS_LEVEL_0_55MA, 4 },
> > +	{ USB_PHY_UTMI_CTRL5, 0x0, 0 },
> > +	{ USB_PHY_HS_PHY_CTRL2, USB2_SUSPEND_N | USB2_UTMI_CLK_EN, 0 },
>
> More readable way to code
>                 USB_PHY_CFG0,
>                 UTMI_PHY_OVERRIDE_EN,
>                 0
>
> and so on, makes a better read and check for errors, one line for off,
> one for val and one for delay
>
> --
> `~Vinod

Have posted a new version addressing these (and Konrad's and Bjorn's) issues.
Please review.

Thanks
Varada
