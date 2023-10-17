Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FEE87CB948
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 05:28:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233654AbjJQD2U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 23:28:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233862AbjJQD2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 23:28:17 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C471FE6;
        Mon, 16 Oct 2023 20:28:14 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39H2qYUf002265;
        Tue, 17 Oct 2023 03:28:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=fL4H8TL5+txWPFaXBE5aic9CLYqUBwi67Zhj8Tspef8=;
 b=XV5VFjTgV8spOQ+LInk6JpA/Vahe13nWaqV9/g6FhVNc6PhEOcBTOo8XgVpAot/vSTis
 WuAULixWI+m+MEzdJCbQUliGi4+C1otpx9fKi5A90lsAavwBmiEEMsGKLMlWkfTy4Ki9
 r+bb8JrahnwYZvgMIGnZPZwb7mVJjrm4BlpSBbJryLVw7lUtcaUtN5YeWIEKO6fiuDok
 mKbABageJASNJVPNVUiFXVmfNC3+uD13EZXDIRhSE3r8PAJCjFia8E5WV97dc91pkk5Q
 AY7/bmC6hjM7s4h9RNLCVKbSsraom4eLI98gU3Ry8DTfYB0eibx8PpOw6brn9k+gOSoL UA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tsb3xrtuh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Oct 2023 03:28:12 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39H3SBLZ023500
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Oct 2023 03:28:11 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Mon, 16 Oct 2023 20:28:11 -0700
Date:   Mon, 16 Oct 2023 20:28:10 -0700
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC:     Johan Hovold <johan@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: qcom: sc8280xp-x13s: Use the correct DP PHY
 compatible
Message-ID: <20231017032810.GP3553829@hu-bjorande-lv.qualcomm.com>
References: <20230929-topic-x13s_edpphy-v1-1-ce59f9eb4226@linaro.org>
 <CAA8EJprXCzVyaU49qgVcVfF0-FJ3QqAfTMZj5CEZm187hoi4=g@mail.gmail.com>
 <ZSz7---IW_7Oj2Zr@hovoldconsulting.com>
 <CAA8EJpr=HQOs8Ho_s_34y0-krCHwq3MThMkUzhOkPVdOSMQ62A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAA8EJpr=HQOs8Ho_s_34y0-krCHwq3MThMkUzhOkPVdOSMQ62A@mail.gmail.com>
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: TaJjh2-uffEi-W6ynQ3vHC9OWJ6fFZpf
X-Proofpoint-ORIG-GUID: TaJjh2-uffEi-W6ynQ3vHC9OWJ6fFZpf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-16_13,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 phishscore=0 mlxlogscore=989 malwarescore=0
 priorityscore=1501 mlxscore=0 adultscore=0 bulkscore=0 clxscore=1011
 lowpriorityscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2309180000 definitions=main-2310170028
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2023 at 12:10:18PM +0300, Dmitry Baryshkov wrote:
> On Mon, 16 Oct 2023 at 12:01, Johan Hovold <johan@kernel.org> wrote:
> >
> > On Mon, Oct 16, 2023 at 11:51:33AM +0300, Dmitry Baryshkov wrote:
> > > On Fri, 29 Sept 2023 at 19:03, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
> > > >
> > > > The DP PHY needs different settings when an eDP display is used.
> > > > Make sure these apply on the X13s.
> > >
> > > Could you please clarify, is it the same PHY type, just being
> > > repurposed for eDP or is it a different PHY type?
> >
> > Same PHY, just different settings AFAIK.
> >
> > > If the former is the case (and the same PHY can be used for both DP
> > > and eDP), it should carry the same compatible string and use software
> > > mechanisms (e.g. phy_set_mode_ext()) to be programmed for the correct
> > > operation mode.
> >
> > Possibly, but that's not how the current binding and implementation
> > works:
> >
> >         6993c079cd58 ("dt-bindings: phy: qcom-edp: Add SC8280XP PHY compatibles")
> >         2300d1cb24b3 ("phy: qcom: edp: Introduce support for DisplayPort")
> >         3b7267dec445 ("phy: qcom: edp: Add SC8280XP eDP and DP PHYs")
> >
> >         https://lore.kernel.org/lkml/20220810040745.3582985-1-bjorn.andersson@linaro.org/
> >
> > And you'd still need to infer the mode from DT somehow.
> 
> If it is the same hardware block, it seems incorrect to have two
> different compat entries. For example, for PCIe RC vs PCIe EP we
> specify the PHY mode from the host controller driver.
> I'd say, we need to fix the bindings for both DP/eDP controller and
> the PHY.  See the `phy-mode` DT property for example.
> 

It is one hardware block, supporting both eDP and DP, so I like your
suggestion of having a single compatible instead and using some other
means of defining the configuration. I just wasn't able to find a
better way to do so back when I wrote the binding/driver...

Regards,
Bjorn
