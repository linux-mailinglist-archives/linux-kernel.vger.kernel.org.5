Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C10F7F734D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 13:03:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbjKXMCv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 07:02:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230405AbjKXMCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 07:02:48 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F66110E4;
        Fri, 24 Nov 2023 04:02:54 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AOBfb7q026580;
        Fri, 24 Nov 2023 12:02:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=i0ZZVH2qdfKzyLqwalxXNwcgDe0aXzPSCoyjnJLopwo=;
 b=ILYUcl4LzaMI2E6uW+yrL2m3ZesUOCI2c34VwUZoUFoyrMYPDQ9RIDMGqE0qUnOr0pAs
 Lgns+x3PRQr6JG6J4bqMwU44qhSN/gXuadYoGrpTEfZKZI4TwrF8JgDwOWGO1/oMQJcF
 qLyVedsFTvxWGyGWUJOAFIdVK+ha87k/FpXcDS32KFL+rJ7XhyQPVraqfYec+OXwaK5d
 TKJWKMs0KgMewskrOkomaOVHOcL+WV8GUc7xuWkVnnlYFHaT3WdbWj6sjGMM3ZpzhY9G
 hs818YwgojKx+jM4zJKr4CaWo/1G2jrGH9kwG4EJ0rLqOsLe3Er3H2k5cIeK9QAJu4cu 2Q== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uj4hwjs43-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Nov 2023 12:02:48 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AOC2lee031400
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Nov 2023 12:02:47 GMT
Received: from [10.216.4.60] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 24 Nov
 2023 04:02:41 -0800
Message-ID: <1192d91f-11bf-44af-953a-14e08e2b6ca8@quicinc.com>
Date:   Fri, 24 Nov 2023 17:32:37 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] dt-bindings: usb: dwc3: Clean up hs_phy_irq in
 bindings
To:     Johan Hovold <johan@kernel.org>
CC:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, <quic_wcheng@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_ppratap@quicinc.com>, <quic_jackp@quicinc.com>
References: <20231122191335.3058-1-quic_kriskura@quicinc.com>
 <ZV9dYpTYRXn63tXe@hovoldconsulting.com>
Content-Language: en-US
From:   Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <ZV9dYpTYRXn63tXe@hovoldconsulting.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: GBPzJtLw6_8qhGlofgmoeSKy4TTdFYeX
X-Proofpoint-ORIG-GUID: GBPzJtLw6_8qhGlofgmoeSKy4TTdFYeX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-23_15,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 priorityscore=1501 bulkscore=0 mlxscore=0 mlxlogscore=820
 suspectscore=0 phishscore=0 spamscore=0 lowpriorityscore=0 clxscore=1015
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311240093
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Thanks for sorting this out.
> 
> It seems like we have a few combinations of these interrupts and we
> should probably try to define the order for these once and for all and
> update the current devicetrees to match (even if it means adding new
> interrupts in the middle).
> 
> Instead of adding separate compatibles for the controllers without SS
> support, I suggest keeping that interrupt last as an optional one.
> 
> But IIUC we essentially have something like:
> 
> qusb2-:
> 
> 	- const: qusb2_phy
> 	- const: pwr_event
> 	- const: ss_phy_irq	(optional)
> 
> qusb2:
> 
> 	- const: hs_phy_irq
> 	- const: qusb2_phy
> 	- const: pwr_event
> 	- const: ss_phy_irq	(optional)
> 
> qusb2+:
> 
> 	- const: hs_phy_irq
> 	- const: qusb2_phy
> 	- const: dp_hs_phy_irq
> 	- const: dm_hs_phy_irq
> 	- const: pwr_event
> 	- const: ss_phy_irq	(optional)
> 

This combination doesn't exist. So we can skip this one.

> femto-:
> 	- const: dp_hs_phy_irq
> 	- const: dm_hs_phy_irq
> 	- const: pwr_event
> 	- const: ss_phy_irq	(optional)
> 
> femto:
> 	- const: hs_phy_irq
> 	- const: dp_hs_phy_irq
> 	- const: dm_hs_phy_irq
> 	- const: pwr_event
> 	- const: ss_phy_irq	(optional)
> 
> Does this look like it would cover all of our currents SoCs?
> 
> Do all of them have the pwr_event interrupt?
> 
Yes. From whatever targets I was able to find, only one of them didn't 
have the power_event irq. Rest all of them had. I will recheck that 
particular one again.

> Note that DP comes before DM above as that seems like the natural order
> of these (plus before minus).
> 
> Now if the HS interrupt is truly unusable, I guess we can consider
> dropping it throughout and the above becomes just three permutations
> instead, which can even be expressed along the lines of:
> 

Infact, I wanted to do this but since you mentioned before that if HW 
has it, we must describe it, I kept it in. But since this functionality 
is confirmed to be mutually exclusive of qusb2/{dp/dm}, I am aligned to 
skip it in bindings and drop it in DT.

> 	- anyOf:
> 	  - items:
> 	    - const: qusb2_phy
> 	  - items:
> 	    - const: dp_hs_phy_irq
> 	    - const: dm_hs_phy_irq
> 	- const: pwr_event
> 	- const: ss_phy_irq	(optional)
> 

This must cover all cases AFAIK. How about we keep pwr_event also 
optional for time being. The ones I am not able to find also would come 
up under still binding block.

Regards,
Krishna,
