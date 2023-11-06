Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE99B7E2A5C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 17:51:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232869AbjKFQvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 11:51:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbjKFQvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 11:51:10 -0500
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77CA9B8;
        Mon,  6 Nov 2023 08:51:03 -0800 (PST)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3A6C6bjB004731;
        Mon, 6 Nov 2023 17:50:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=selector1; bh=b1Xh2LilT7GMG6HQY5JGB
        /PrQK61B1TX/eGNos2qtjw=; b=3kC6Bxk7/M9HIXm9lapWmkT9q9pgZRDJuca40
        uT/kHarRSWfvGr1UrDvKtqdnV+xcFGuQoYb0nPtj0xfksGhtiLjWfHtX3/5xaDGB
        9fDAqd8q+hWFw1V14r0tzsckwBTd7p6R3Xlf+2kDTa4NDL698ixRHuP8rftm0A0f
        BiORIzaq2aLl0RYLXUrGdvclPuNBVapYAJGAopkH1JDFPbeYSBTQMw4C0VtneBpR
        Rgf8x81qy2798Zp8kAW+8NS1S5DdEnTQE8VLEUHRU82uBo1ITkX73BLJVsCBa10p
        OXOlWoJXXTB7MiF95Kfet65UEreVWhEBPtocBEufexH5Qx1Zg==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3u5ej0qxrm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Nov 2023 17:50:50 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 75E62100059;
        Mon,  6 Nov 2023 17:50:48 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 65D5026C075;
        Mon,  6 Nov 2023 17:50:48 +0100 (CET)
Received: from gnbcxd0016.gnb.st.com (10.129.178.213) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 6 Nov
 2023 17:50:48 +0100
Date:   Mon, 6 Nov 2023 17:50:40 +0100
From:   Alain Volmat <alain.volmat@foss.st.com>
To:     Sakari Ailus <sakari.ailus@iki.fi>
CC:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Rob Herring <robh@kernel.org>, <linux-media@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] dt-bindings: media: i2c: add galaxycore,gc2145
 dt-bindings
Message-ID: <20231106165040.GA3075668@gnbcxd0016.gnb.st.com>
Mail-Followup-To: Sakari Ailus <sakari.ailus@iki.fi>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Rob Herring <robh@kernel.org>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231011175735.1824782-1-alain.volmat@foss.st.com>
 <20231011175735.1824782-3-alain.volmat@foss.st.com>
 <ZUJRbI9ff83gH6Ng@valkosipuli.retiisi.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZUJRbI9ff83gH6Ng@valkosipuli.retiisi.eu>
X-Disclaimer: ce message est personnel / this message is private
X-Originating-IP: [10.129.178.213]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-06_12,2023-11-02_03,2023-05-22_02
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sakari,

On Wed, Nov 01, 2023 at 01:23:56PM +0000, Sakari Ailus wrote:
> Hi Alain,
> 
> On Wed, Oct 11, 2023 at 07:57:29PM +0200, Alain Volmat wrote:
> > Introduction of the Galaxy Core GC2145 XVGA CMOS camera sensor.
> > 
> > Signed-off-by: Alain Volmat <alain.volmat@foss.st.com>
> > ---
> >  .../bindings/media/i2c/galaxycore,gc2145.yaml | 104 ++++++++++++++++++
> >  1 file changed, 104 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/media/i2c/galaxycore,gc2145.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/media/i2c/galaxycore,gc2145.yaml b/Documentation/devicetree/bindings/media/i2c/galaxycore,gc2145.yaml
> > new file mode 100644
> > index 000000000000..94d194cf5452
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/media/i2c/galaxycore,gc2145.yaml
> > @@ -0,0 +1,104 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/media/i2c/galaxycore,gc2145.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Galaxy Core 1/5'' UXGA CMOS Image Sensor
> > +
> > +maintainers:
> > +  - Alain Volmat <alain.volmat@foss.st.com>
> > +
> > +description:
> > +  The Galaxy Core GC2145 is a high quality 2 Mega CMOS image sensor, for mobile
> > +  phone camera applications and digital camera products. GC2145 incorporates a
> > +  1616V x 1232H active pixel array, on-chip 10-bit ADC, and image signal
> > +  processor. It is programmable through an I2C interface. Image data is sent
> > +  either through a parallel interface or through MIPI CSI-2.
> > +
> > +allOf:
> > +  - $ref: ../video-interface-devices.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    const: galaxycore,gc2145
> > +
> > +  reg:
> > +    const: 0x3c
> > +
> > +  clocks:
> > +    maxItems: 1
> > +
> > +  powerdown-gpios:
> > +    maxItems: 1
> > +
> > +  reset-gpios:
> > +    maxItems: 1
> > +
> > +  iovdd-supply:
> > +    description: Power Supply for I/O circuits (1.7 - 3V).
> > +
> > +  avdd-supply:
> > +    description: Power for analog circuit/sensor array (2.7 - 3V).
> > +
> > +  dvdd-supply:
> > +    description: Power for digital core (1.7 - 1.9V).
> > +
> > +  orientation: true
> > +
> > +  rotation: true
> > +
> > +  port:
> > +    $ref: /schemas/graph.yaml#/$defs/port-base
> > +
> > +    properties:
> > +      endpoint:
> > +        $ref: /schemas/media/video-interfaces.yaml#
> > +        unevaluatedProperties: false
> > +
> > +    required:
> > +      - endpoint
> 
> Could you add link-frequencies here, too?

This sensor is only used for the time being (as far as I know) on the
the stm32mp135f-dk board which can well handle the 3 link-frequencies.
(some other usages exist, however in parallel mode, which this driver
doesn't support yet).
I was hoping to only add the link-frequencies check when it becomes
necessary to use it on another board.
Do that make sense ?

Regards,
Alain
