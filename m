Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 612E4763F62
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 21:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232183AbjGZTRa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 15:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbjGZTR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 15:17:29 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B1011FF0;
        Wed, 26 Jul 2023 12:17:28 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 36QJHBgL036759;
        Wed, 26 Jul 2023 14:17:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1690399032;
        bh=30OZa93bnPYjdB9Z7EidvFI/Njos2YOm2OYVk4nEI7c=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=YZ/rlcEvVA9x5o4LeNzlCg0iFYBPJaFJsdk4+todPcTAog36yFDh2djn2CQHi/TsK
         f141/Rn+Gox1JZYZynp5Z2digCZC0DWtjTvVCjJNDCLv2okaJ8ZYi1mnMHszLRYivx
         nlRYyey7Ewzk8X4tjNSfDi48IYZtaZMU/odJLRB4=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 36QJHBua111636
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 26 Jul 2023 14:17:11 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 26
 Jul 2023 14:17:11 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 26 Jul 2023 14:17:11 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 36QJHBJx010864;
        Wed, 26 Jul 2023 14:17:11 -0500
Date:   Wed, 26 Jul 2023 14:17:11 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Rob Herring <robh@kernel.org>
CC:     Tony Lindgren <tony@atomide.com>,
        =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Vibhore Vardhan <vibhore@ti.com>, Dhruva Gole <d-gole@ti.com>,
        <linux-omap@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 5/5] dt-bindings: cpufreq: Convert ti-cpufreq.txt to yaml
 binding
Message-ID: <20230726191711.nsrs6n3zbubzad7j@maternal>
References: <20230724153911.1376830-1-nm@ti.com>
 <20230724153911.1376830-6-nm@ti.com>
 <20230726171436.GA1609063-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230726171436.GA1609063-robh@kernel.org>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11:14-20230726, Rob Herring wrote:
> > diff --git a/Documentation/devicetree/bindings/opp/opp-v2-ti-cpu.yaml b/Documentation/devicetree/bindings/opp/opp-v2-ti-cpu.yaml
> > new file mode 100644
> > index 000000000000..758f6da619a8
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/opp/opp-v2-ti-cpu.yaml
> 
> Filename matching the compatible.

operating-points-v2-ti-cpu.yaml, OK

> 
> > @@ -0,0 +1,88 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/opp/opp-v2-ti-cpu.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: TI CPU OPP
> > +
> > +description: |
> 
> Don't need '|'.

OK

> 
[..]

> > +
> > +examples:
> > +  - |
> > +    cpu0_opp_table: opp-table {
> 
> Drop unused labels

Uggh.. yep, thanks.

[...]

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
