Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A49D6775DC5
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 13:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234216AbjHILlG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 07:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234211AbjHILlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 07:41:05 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B8C31FD8;
        Wed,  9 Aug 2023 04:41:04 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 379Benwh101101;
        Wed, 9 Aug 2023 06:40:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691581249;
        bh=IcfxrqvirWDKYAPqgtc4d8QimB64D14Ogs3/JsEvkn8=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=s6enfKLcUHQjTsgGQTAhk/Ris2qRnbFNhgJVgDtSohaElaUUGh7bnuQl3/sdur6wX
         AghNmriiM7FIeqaDSX+9HJD8l+s8r3f8uRbVHUAj/yydxyulHtUAewpVFsntBnbYDe
         XKCBiDsgqNCJmm7fBiDoJtS83LZQlxlyNsI+C52M=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 379Ben9w015415
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 9 Aug 2023 06:40:49 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 9
 Aug 2023 06:40:48 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 9 Aug 2023 06:40:48 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 379Bem5c129327;
        Wed, 9 Aug 2023 06:40:48 -0500
Date:   Wed, 9 Aug 2023 06:40:48 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Dhruva Gole <d-gole@ti.com>
CC:     Rob Herring <robh+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Tony Lindgren <tony@atomide.com>,
        =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Vibhore Vardhan <vibhore@ti.com>, <linux-omap@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH V3 1/2] dt-bindings: opp: Convert ti-omap5-opp-supply to
 json schema
Message-ID: <20230809114048.o3oadfytvxuxie7u@kobold>
References: <20230809023045.1870410-1-nm@ti.com>
 <20230809023045.1870410-2-nm@ti.com>
 <20230809044825.top2xma5meklzosc@dhruva>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230809044825.top2xma5meklzosc@dhruva>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10:18-20230809, Dhruva Gole wrote:
> On Aug 08, 2023 at 21:30:44 -0500, Nishanth Menon wrote:
> > Rename ti-omap5-opp-supply to be bit more generic omap-opp-supply and
> > convert the free text binding to json-schema.
> > 
> > Signed-off-by: Nishanth Menon <nm@ti.com>
> > ---
> > Changes since V2:
> > - None.
> > 
> > V2: https://lore.kernel.org/r/20230801233341.1416552-2-nm@ti.com
> > V1: https://lore.kernel.org/all/20230724153911.1376830-5-nm@ti.com/
> >  .../bindings/opp/ti,omap-opp-supply.yaml      | 103 ++++++++++++++++++
> >  .../bindings/opp/ti-omap5-opp-supply.txt      |  63 -----------
> >  2 files changed, 103 insertions(+), 63 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/opp/ti,omap-opp-supply.yaml
> >  delete mode 100644 Documentation/devicetree/bindings/opp/ti-omap5-opp-supply.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/opp/ti,omap-opp-supply.yaml b/Documentation/devicetree/bindings/opp/ti,omap-opp-supply.yaml
> > new file mode 100644
> > index 000000000000..4db80e418829
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/opp/ti,omap-opp-supply.yaml
> > @@ -0,0 +1,103 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/opp/ti,omap-opp-supply.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Texas Instruments OMAP compatible OPP supply
> > +
> > +description:
> > +  OMAP5, DRA7, and AM57 family of SoCs have Class0 AVS eFuse registers which
> > +  contain data that can be used to adjust voltages programmed for some of their
> > +  supplies for more efficient operation. This binding provides the information
> > +  needed to read these values and use them to program the main regulator during
> > +  an OPP transitions.
> > +
> > +  Also, some supplies may have an associated vbb-supply which is an Adaptive Body
> > +  Bias regulator which much be transitioned in a specific sequence with regards
> 
> s/much/must ?

Thanks.
> 
> > +  to the vdd-supply and clk when making an OPP transition. By supplying two
> > +  regulators to the device that will undergo OPP transitions we can make use
> > +  of the multi regulator binding that is part of the OPP core described
> 
> Existing txt seems to have:
> 
>  part of the OPP core described here [1]
> 
> Why get rid of the reference "[1]" here?
> 
> Going through Documentation/devicetree/bindings/opp/opp-v2.yaml didn't
> tell me much about this multi regulator binding, I only see 1 example.
> 
> Please can you explain a bit more or make this line more clear?

Example 4 in the referenced binding does explain that - consumer
examples that are already documented does'nt make sense to be replicated
here. I will add a reference to opp-v2.yaml binding along with a pointer
to example 4.

> 
> > +  to describe both regulators needed by the platform.
> > +
> > +maintainers:
> > +  - Nishanth Menon <nm@ti.com>
> > +
> > +properties:
> > +  $nodename:
> > +    pattern: '^opp-supply(@[0-9a-f]+)?$'
> [...]
> 

Thanks for the detailed review. Will repost a new rev in a few days if
there are no further review comments.


-- 

Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
