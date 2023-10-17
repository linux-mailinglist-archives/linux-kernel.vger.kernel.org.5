Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E1AA7CD018
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 00:54:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343829AbjJQWyv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 18:54:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjJQWyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 18:54:50 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F27AF0;
        Tue, 17 Oct 2023 15:54:48 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39HMKYaw010936;
        Tue, 17 Oct 2023 22:54:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=QmkSjAQT6/UOwV1H46ZV5rNieSvZTeLgkEC3zgH2Rbk=;
 b=cGU8pgRTyn8EvwX5nYL+tj8v0QZI+49iczx2c6VbfVga61jwKXwzrmDbCkosb5hZQAX8
 1uP5i0Hz4RtTQNpwT4xVXL7IJJYFZlrdKX+F/pp9FUWmgbLeeWju7HSUC6uaHE3Udc23
 YCWVH4RgYM2zrPrTF3x8yQF+1BIsFRQSFIWrrRxLHCU0M+QOVpd0TJmemVMGydlhlNRX
 pOqFFqXDUwKGRf0JGjuLUjUDprtwgsXwWY+hHsludZmnrSt4gtfAWmFlH7KmXuhSTA4b
 s9tzIwSjG4h9YeMY8aOhsigCp7tElbqXZyudiYXp0xChwIJ7vhtELKbHLMlp7vDue+ht XQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tt14008u9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Oct 2023 22:54:38 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39HMsZO7015831
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Oct 2023 22:54:35 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Tue, 17 Oct 2023 15:54:34 -0700
Date:   Tue, 17 Oct 2023 15:54:33 -0700
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Felipe Balbi <balbi@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        <linux-arm-msm@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Johan Hovold <johan@kernel.org>,
        "Krishna Kurapati PSSNV" <quic_kriskura@quicinc.com>
Subject: Re: [PATCH 10/12] dt-bindings: usb: qcom,dwc3: Introduce flattened
 qcom,dwc3 binding
Message-ID: <20231017225433.GW3553829@hu-bjorande-lv.qualcomm.com>
References: <20231016-dwc3-refactor-v1-0-ab4a84165470@quicinc.com>
 <20231016-dwc3-refactor-v1-10-ab4a84165470@quicinc.com>
 <9f53e647-7c38-435f-bc74-e4f417445830@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <9f53e647-7c38-435f-bc74-e4f417445830@linaro.org>
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: bDq5BbIqjHZt77dWStEfmDtmVLprR4JF
X-Proofpoint-ORIG-GUID: bDq5BbIqjHZt77dWStEfmDtmVLprR4JF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-17_06,2023-10-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=522 mlxscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 phishscore=0 adultscore=0
 impostorscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2309180000 definitions=main-2310170194
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2023 at 08:11:45AM +0200, Krzysztof Kozlowski wrote:
> On 17/10/2023 05:11, Bjorn Andersson wrote:
> > diff --git a/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml b/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
[..]
> > +select:
> > +  properties:
> > +    compatible:
> > +      items:
> > +        - enum:
> > +            - qcom,ipq4019-dwc3
[..]
> > +            - qcom,sm8550-dwc3
> 
> This enum could be replaced with '{}'. Alternatively, drop enum entire
> select replaced with:
> - contains
>   - items:
>       - const: qcom,dwc3
>       - const: snps,dwc3
> 

I thought this would be what I needed as well, but unfortunately this
select matches either qcom,dwc3, snps,dwc3, or both. With the result
that e.g. the example in the snps,dwc3 binding matches against this and
as expected fails when validated against this binding.

Taking yet another look at this, and reading more about json validation
I figured out that the following matches nodes with both the
compatibles:

select:
  properties:
    compatible:
      items:
        - const: qcom,dwc3
        - const: snps,dwc3
  required:
    - compatible

[..]
> > +
> > +# Required child node:
> 
> Drop
> 

Of course.

> 
> ...
> 
> > diff --git a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> > index d81c2e849ca9..d6914b8cef6a 100644
> > --- a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> > +++ b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> > @@ -44,14 +44,18 @@ properties:
> >        It's either a single common DWC3 interrupt (dwc_usb3) or individual
> >        interrupts for the host, gadget and DRD modes.
> >      minItems: 1
> > -    maxItems: 4
> > +    maxItems: 5
> >  
> >    interrupt-names:
> > -    minItems: 1
> > -    maxItems: 4
> >      oneOf:
> > -      - const: dwc_usb3
> > -      - items:
> > +      - minItems: 1
> > +        maxItems: 5
> > +        items:
> > +          - const: dwc_usb3
> > +        additionalItems: true
> 
> This is not correct change. Before, one dwc_usb3 interrupt was combined
> allowed, or a set of host+peripheral+otg+wakeup. Now, you allow combined
> dwc_usb3 with anything.
> 

My intention here is to make below list of 5 strings be valid according
to the snps,dwc3 (i.e. dwc_usb3 being the first item), and valid
according to the qcom,dwc3 binding with all 5 defined.

  interrupt-names = "dwc_usb3", "hs_phy_irq", "ss_phy_irq",
		    "dm_hs_phy_irq", "dp_hs_phy_irq";

When I express this as:

  interrupt-names:
    minItems: 1
    maxItems: 5
    oneOf:
      - const: dwc_usb3
      - items:
          enum: [host, peripheral, otg, wakeup]

I get:

/local/mnt/workspace/bjorande/linux/Documentation/devicetree/bindings/usb/qcom,dwc3.example.dtb: usb@a600000: interrupt-names: 'oneOf' conditional failed, one must be fixed:
        ['dwc_usb3', 'hs_phy_irq', 'ss_phy_irq', 'dm_hs_phy_irq', 'dp_hs_phy_irq'] is too long
        'dwc_usb3' is not one of ['host', 'peripheral', 'otg', 'wakeup']
        'hs_phy_irq' is not one of ['host', 'peripheral', 'otg', 'wakeup']
        'ss_phy_irq' is not one of ['host', 'peripheral', 'otg', 'wakeup']
        'dm_hs_phy_irq' is not one of ['host', 'peripheral', 'otg', 'wakeup']
        'dp_hs_phy_irq' is not one of ['host', 'peripheral', 'otg', 'wakeup']
        from schema $id: http://devicetree.org/schemas/usb/snps,dwc3.yaml#

Which to me sounds like the two oneOf branches allow me a single entry,
or items from the set given here. In contrast, I believe that my
proposal allow 1-5 items, where the first needs to be dwc_usb3.

But the proposal does look messy, so I'd appreciate some guidance on
this one.

Thanks,
Bjorn
