Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DB6F76470C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 08:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232881AbjG0GkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 02:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232494AbjG0Gj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 02:39:59 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F0330C2;
        Wed, 26 Jul 2023 23:39:51 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36R5uBcH023086;
        Thu, 27 Jul 2023 06:39:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=8WqSueMpyPR36uQqgpRx0xEa9Qkbf693u9xUJNMsytM=;
 b=l8XYvbETL29fbcpIbD6HK1+vcqGqgyz+mGHY4bdJNxBHU5/ME+umt4U473DOoDatoyOF
 XSGEFXsMTM94otNOzN83CquuStG9FIa/qzQof7u+fFpKrr50KFPFnsYb2QpYXE3yuWqj
 kk56EibTSzfK/qwQ/smtpSzj6X+ZRBAlD+RleCykYOcyUrXR7idLYYIv6ppmBzWFlmrN
 XcdxRlV68QDQ6qFOYDfHli0pK5oteqLB3pTIJXGyns1haXM/ysjZ/YIgffP04PT044y8
 PLOFWtGiMMfaGeUbQ0/n811D9HN0NDGRqF96hqdhPon6BVMeR2dKs/ttVTh4ttnQzb0D 7w== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s37g0h88w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jul 2023 06:39:21 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36R6dKsj029405
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jul 2023 06:39:20 GMT
Received: from varda-linux.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 26 Jul 2023 23:39:13 -0700
Date:   Thu, 27 Jul 2023 12:09:09 +0530
From:   Varadarajan Narayanan <quic_varada@quicinc.com>
To:     Bjorn Andersson <andersson@kernel.org>
CC:     Rob Herring <robh@kernel.org>, <agross@kernel.org>,
        <konrad.dybcio@linaro.org>, <vkoul@kernel.org>,
        <kishon@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <gregkh@linuxfoundation.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <p.zabel@pengutronix.de>, <arnd@arndb.de>,
        <geert+renesas@glider.be>, <neil.armstrong@linaro.org>,
        <nfraprado@collabora.com>, <rafal@milecki.pl>,
        <quic_srichara@quicinc.com>, <quic_wcheng@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v5 2/6] dt-bindings: phy: qcom,m31: Document qcom,m31 USB
 phy
Message-ID: <20230727063908.GA15719@varda-linux.qualcomm.com>
References: <cover.1689913334.git.quic_varada@quicinc.com>
 <131eb1694229436919ac88bb9920fb54d6808388.1689913334.git.quic_varada@quicinc.com>
 <ymbcafqqhc6hgrfhpef4byehvfyjzovs5zeprmj343erdv5ti5@tj2iunu6whvi>
 <20230724160136.GA3619408-robh@kernel.org>
 <cst3d76ong32lzcatxlcr5gbakmh3grm5tehvd36wrdza5ozd5@gfl4ysu7hdo6>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cst3d76ong32lzcatxlcr5gbakmh3grm5tehvd36wrdza5ozd5@gfl4ysu7hdo6>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: NZdzKQSQBtvcYzpROXyG5HPaYZxpeTJ1
X-Proofpoint-ORIG-GUID: NZdzKQSQBtvcYzpROXyG5HPaYZxpeTJ1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-26_08,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 spamscore=0 impostorscore=0 mlxlogscore=875 phishscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 clxscore=1015
 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307270059
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bjorn & Rob,

On Tue, Jul 25, 2023 at 10:24:15PM -0700, Bjorn Andersson wrote:
> On Mon, Jul 24, 2023 at 10:01:36AM -0600, Rob Herring wrote:
> > On Fri, Jul 21, 2023 at 10:10:57PM -0700, Bjorn Andersson wrote:
> > > On Fri, Jul 21, 2023 at 10:05:27AM +0530, Varadarajan Narayanan wrote:
> > > [..]
> > > > diff --git a/Documentation/devicetree/bindings/phy/qcom,ipq5332-usb-hsphy.yaml b/Documentation/devicetree/bindings/phy/qcom,ipq5332-usb-hsphy.yaml
> [..]
> > > > +examples:
> > > > +  - |
> > > > +    #include <dt-bindings/clock/qcom,ipq5332-gcc.h>
> > > > +    usbphy0: usb-phy@7b000 {
> > >
> > > usb@
> >
> > You mean phy@? But 'usb2-phy' is accepted too.
> >
>
> Yes, had the controller in mind, sorry about that.

Have posted a new patchset addressing the comments.
Please provide your feedback.

Thanks
Varada
