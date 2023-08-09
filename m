Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A33F775C53
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 13:26:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233716AbjHIL0D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 07:26:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233703AbjHIL0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 07:26:02 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0B5B1BFA;
        Wed,  9 Aug 2023 04:26:00 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 379BPmDJ030649;
        Wed, 9 Aug 2023 06:25:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691580348;
        bh=cWz4NGyNUy8El8zxWZq8xRMxA/ymzzfHRBdrRbIlWlc=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=Se1iRQczej6fZ8SJw31vlbm4qE/P3AxYtFliQOCX0r4jJSiNCgB1MVzmySuOF+EEu
         jaU1Q2rOhEKa6QXJk8K1kQtIYtiVink0zFadSTuA+eCtAn0m9Fqq4UbDNrgHkfNmPQ
         MNaSHfIif4UAda0JhF2sjUNUQVi3L/4oVRC4OLcU=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 379BPmr4031434
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 9 Aug 2023 06:25:48 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 9
 Aug 2023 06:25:48 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 9 Aug 2023 06:25:48 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 379BPmGg116542;
        Wed, 9 Aug 2023 06:25:48 -0500
Date:   Wed, 9 Aug 2023 06:25:48 -0500
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
Subject: Re: [PATCH V3 2/2] dt-bindings: cpufreq: Convert ti-cpufreq to json
 schema
Message-ID: <20230809112548.cf5o7yxqeu3nfqdq@kobold>
References: <20230809023045.1870410-1-nm@ti.com>
 <20230809023045.1870410-3-nm@ti.com>
 <20230809043012.gcsnn5bfr7j25ow7@dhruva>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230809043012.gcsnn5bfr7j25ow7@dhruva>
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

On 10:00-20230809, Dhruva Gole wrote:
[..]

> > +description:
> > +  Certain TI SoCs, like those in the am335x, am437x, am57xx, am62x and dra7xx
> > +  families support different OPPs depending on the silicon variant in use.
> > +  The ti-cpufreq driver can use revision and an efuse value from the SoC to
> 
> Just learned about this yesterday, hence missed it in my earlier review.
> Looks like the kernel docs [0] say that we DON'T refer to Linux or
> "device driver" in bindings.
> 
> Bindings should be based on what the hardware has, not what an OS and
> driver currently support.

Thanks for catching this. will fix in the next rev.
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
