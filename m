Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B78127B69D9
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 15:08:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232632AbjJCNIP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 09:08:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232562AbjJCNIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 09:08:14 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D985F90;
        Tue,  3 Oct 2023 06:08:10 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 393D7xtu090568;
        Tue, 3 Oct 2023 08:07:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1696338479;
        bh=Zp1B+zFrIeVSClx3EFpcOSTc44sv/meIKlkORkGW3I4=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=GW2og72aWeylJQLIaR5npYOz2CojwYHS2ZG3DOegeb26K5qc5vB8YUqNyucAcUqZG
         X9Lk31lKtTeNENwkIz9Oj57R0kSdCSHOg/8sMbw/WHoehoXuXeUhRTJ56EUqu0Ga8a
         eMN5cq6GULauidqPkGFNU5QD8nzMnbyE4OD6D5fA=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 393D7xEG013176
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 3 Oct 2023 08:07:59 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 3
 Oct 2023 08:07:59 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 3 Oct 2023 08:07:59 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 393D7xQD010350;
        Tue, 3 Oct 2023 08:07:59 -0500
Date:   Tue, 3 Oct 2023 08:07:59 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Ayush Singh <ayushdevel1325@gmail.com>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <greybus-dev@lists.linaro.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <gregkh@linuxfoundation.org>,
        <vaishnav@beagleboard.org>, <jkridner@beagleboard.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <vigneshr@ti.com>,
        <kristo@kernel.org>, <robh+dt@kernel.org>, <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v6 1/3] dt-bindings: Add beaglecc1352
Message-ID: <20231003130759.ipr5s7n573c3ijyn@sponge>
References: <20231002182454.211165-1-ayushdevel1325@gmail.com>
 <20231002182454.211165-2-ayushdevel1325@gmail.com>
 <55f63415-781a-4107-8643-9f77c7ee38d1@linaro.org>
 <2105b93c-0502-e909-ea09-dba73d43b912@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2105b93c-0502-e909-ea09-dba73d43b912@gmail.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17:39-20231003, Ayush Singh wrote:
> > > driver.
> > > 
> > > Signed-off-by: Ayush Singh <ayushdevel1325@gmail.com>
> > > ---
> > >   .../devicetree/bindings/net/ti,cc1352p7.yaml  | 48 +++++++++++++++++++
> > >   MAINTAINERS                                   |  6 +++
> > >   2 files changed, 54 insertions(+)
> > >   create mode 100644 Documentation/devicetree/bindings/net/ti,cc1352p7.yaml
> > > 
> > > diff --git a/Documentation/devicetree/bindings/net/ti,cc1352p7.yaml b/Documentation/devicetree/bindings/net/ti,cc1352p7.yaml
> > > new file mode 100644
> > > index 000000000000..57bc2c43e5b1
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/net/ti,cc1352p7.yaml
> > > @@ -0,0 +1,48 @@
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
> > If over SPI, then the binding is incomplete. This is fine for now, I guess.
> > 
> > Best regards,
> > Krzysztof
> 
> Well, I added the line about SPI because the data sheet states that CC1352P7
> can be connected over SPI or UART when used as wireless MCU. But yes, I do
> not have much knowledge about SPI itself, so the bindings might be
> incomplete for SPI usage. Should I remove it or leave it be?

I'd suggest to leave it for now, we can expand as there is a need.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
