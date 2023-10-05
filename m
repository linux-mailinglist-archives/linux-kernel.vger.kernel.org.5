Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8179A7BA320
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 17:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235491AbjJEPwC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 11:52:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233917AbjJEPu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 11:50:57 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5903C63EFE;
        Thu,  5 Oct 2023 07:08:44 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 395BJ7DL114262;
        Thu, 5 Oct 2023 06:19:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1696504747;
        bh=O3H9updDdRZA1n9r7jo5xac1dzx6YqsbyUPWoem2bi0=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=F4FE1PjJyNXeVo5vS5nYLlEjPCgoMzZB0fZgXYnwEzzveDo6GFhwZI972eUp8mZMa
         cY+PSWWN52Cyfp2F1fa36KCEjG3A2zRRfb1dolG4rzP8ZK52WspFONbokepOoD96bo
         FmRdi58lXtE9dGFBR5rsnUnASOZM6mE23nNjKX5c=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 395BJ7ip073088
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 5 Oct 2023 06:19:07 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 5
 Oct 2023 06:19:07 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 5 Oct 2023 06:19:07 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 395BJ70q073832;
        Thu, 5 Oct 2023 06:19:07 -0500
Date:   Thu, 5 Oct 2023 06:19:07 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Ayush Singh <ayushdevel1325@gmail.com>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <greybus-dev@lists.linaro.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <gregkh@linuxfoundation.org>,
        <vaishnav@beagleboard.org>, <jkridner@beagleboard.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <vigneshr@ti.com>,
        <kristo@kernel.org>, <robh+dt@kernel.org>, <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v7 1/3] dt-bindings: net: Add ti,cc1352p7
Message-ID: <20231005111907.ck6rhmuhicrjkifr@elderly>
References: <20231004184639.462510-1-ayushdevel1325@gmail.com>
 <20231004184639.462510-2-ayushdevel1325@gmail.com>
 <a171cc72-98cf-4f7f-ba86-6da2ac45ea22@linaro.org>
 <aa63918f-3a95-5e86-d61d-91a59cf643ad@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aa63918f-3a95-5e86-d61d-91a59cf643ad@gmail.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13:51-20231005, Ayush Singh wrote:
> > > Signed-off-by: Ayush Singh <ayushdevel1325@gmail.com>
> > > ---
> > >   .../devicetree/bindings/net/ti,cc1352p7.yaml  | 51 +++++++++++++++++++
> > >   MAINTAINERS                                   |  6 +++
> > >   2 files changed, 57 insertions(+)
> > >   create mode 100644 Documentation/devicetree/bindings/net/ti,cc1352p7.yaml
> > > 
> > > diff --git a/Documentation/devicetree/bindings/net/ti,cc1352p7.yaml b/Documentation/devicetree/bindings/net/ti,cc1352p7.yaml
> > > new file mode 100644
> > > index 000000000000..291ba34c389b
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/net/ti,cc1352p7.yaml
> > > @@ -0,0 +1,51 @@
> > > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/net/ti,cc1352p7.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Texas Instruments Simplelink CC1352P7 wireless MCU
> > > +
> > > +description:
> > > +  The cc1352p7 mcu can be connected via SPI or UART.
> > > +
> > > +maintainers:
> > > +  - Ayush Singh <ayushdevel1325@gmail.com>
> > > +
> > > +properties:
> > > +  compatible:
> > > +    const: ti,cc1352p7
> > > +
> > > +  clocks:
> > > +    maxItems: 2
> > > +
> > > +  clock-names:
> > > +    description:
> > > +      sclk_hf is the main system (mcu and peripherals) clock
> > > +      sclk_lf is low-frequency system clock
> > This does no go here, but to clocks. I wrote how it should be done.
> > Don't ignore the feedback.
> It was suggested to use `clock-names` by Nishanth Menon in the previous
> email, so I thought this was what it meant. I will remove clock-names if
> that's better.

Krzysztof was mentioning that the description should be with clocks.
clock-names would allow for more descriptive dts

> > > +    items:
> > > +      - const: sclk_hf
> > > +      - const: sclk_lf
> > > +
> > > +  reset-gpios: true
> > 
> > No, really, why do you change correct code into incorrect one? Who asked
> > you to drop maxItems?
> I found that many bindings (`display/ilitek,ili9486.yaml`,
> `iio/dac/adi,ad5758.yaml`) use this pattern instead of `maxItems` for
> `reset-gpios`. So I assumed it was some sort of convention. I will change it
> back to `maxItems`.

maxItems restrict the number of GPIOs to the ones that are actually
needed for the peripheral.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
