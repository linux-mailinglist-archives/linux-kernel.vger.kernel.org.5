Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8521C75FC5E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 18:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231465AbjGXQlb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 12:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjGXQl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 12:41:29 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB2DCE49;
        Mon, 24 Jul 2023 09:41:26 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 36OGfEWn014181;
        Mon, 24 Jul 2023 11:41:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1690216874;
        bh=2GPEo1rqnHBKiCNjLBpfs0l54VjBPT7NExPSQ+AG53k=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=XqEHUrAcB0546V9D6T7STv/LMPGD8eRf6mhrbYIN5G0fFy8jaqBfU0UFN0isg6WWr
         dIANTTRVyLd94QqRgoyuGlq+2hBhn9/fv6kVrgAl9CJ3p1TGNbCFjv8dEN9IjQa/4t
         xKGiCbBj3M6O/0uh8ExAR/iZKpA/hi6LfOZjQTiI=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 36OGfEVe101728
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 24 Jul 2023 11:41:14 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 24
 Jul 2023 11:41:12 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 24 Jul 2023 11:41:12 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 36OGfCWZ028330;
        Mon, 24 Jul 2023 11:41:12 -0500
Date:   Mon, 24 Jul 2023 11:41:12 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Peter Rosin <peda@axentia.se>
CC:     Jayesh Choudhary <j-choudhary@ti.com>, <vigneshr@ti.com>,
        <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <rogerq@kernel.org>, <s-vadapalli@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] dt-bindings: ti-serdes-mux: Deprecate header with
 constants
Message-ID: <20230724164112.hbzc3rey5otm4a5u@march>
References: <20230721125732.122421-1-j-choudhary@ti.com>
 <20230721125732.122421-3-j-choudhary@ti.com>
 <c1a68e10-6530-d0d1-663f-61b3b01e8834@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <c1a68e10-6530-d0d1-663f-61b3b01e8834@axentia.se>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12:18-20230722, Peter Rosin wrote:
> Hi!
> 
> 2023-07-21 at 14:57, Jayesh Choudhary wrote:
> > The constants to define the idle state of SERDES MUX were defined in
> > bindings header. They are used only in DTS and driver uses the dt property
> > to set the idle state making it unsuitable for bindings.
> > The constants are moved to header next to DTS ("arch/arm64/boot/dts/ti/")
> > and all the references to bindings header are removed.
> > So add a warning to mark this bindings header as deprecated.
> > 
> > Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
> > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > Acked-by: Roger Quadros <rogerq@kernel.org>
> 
> Best to keep this patch together with 1/2, so I'm assuming they will
> take the same path to Linus, and that an ack from me will suffice.
> Thanks again!
> 
> Acked-by: Peter Rosin <peda@axentia.se>

Thank you. I can take it via TI SoC dts tree unless there is any objection.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
