Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 167707710E1
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 19:17:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbjHERRn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 13:17:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjHERRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 13:17:38 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98A864228;
        Sat,  5 Aug 2023 10:17:22 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 375HH5AP016470;
        Sat, 5 Aug 2023 12:17:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691255825;
        bh=4jQZBB3DlVCu77H3Axbkc2fb17BRIk/4s588muh0kUM=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=vGUjn6I8z5eeFajASFHWqfCv4+oNLsbxdDMrSrFA/yamgylh7G8NtRbC6agxWdmEl
         eNXIbtYsxortpLbvDCw4qnIwKoZCj59xZFMkzNouI2Zs4y0fEEyEm4ATS0yMCQLXfW
         orP7PHk+KGjeLzL/nAc0ui41sJnaz8WNNpsyLunQ=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 375HH5Ta081641
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 5 Aug 2023 12:17:05 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 5
 Aug 2023 12:17:02 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 5 Aug 2023 12:17:02 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 375HH2K7036810;
        Sat, 5 Aug 2023 12:17:02 -0500
Date:   Sat, 5 Aug 2023 12:17:02 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Dhruva Gole <d-gole@ti.com>
CC:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Tony Lindgren <tony@atomide.com>, <linux-gpio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-omap@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH V3] dt-bindings: pinctrl: pinctrl-single: add am625
 compatible
Message-ID: <20230805171702.hmlu7hb7sia44pd7@blouse>
References: <20230804050737.635186-1-d-gole@ti.com>
 <20230804211432.xxyf74h6a2e5x4qi@reenter>
 <20230805051455.dag3ualnj7udyf76@dhruva>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230805051455.dag3ualnj7udyf76@dhruva>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10:44-20230805, Dhruva Gole wrote:
> On Aug 04, 2023 at 16:14:32 -0500, Nishanth Menon wrote:
> > On 10:37-20230804, Dhruva Gole wrote:
> > > Add the am625 compatible property to add support for the new
> > > wakeup enable and status bits positions
> > > 
> > > Cc: Nishanth Menon <nm@ti.com>
> > > Cc: Vignesh Raghavendra <vigneshr@ti.com>
> > > CC: Tony Lindgren <tony@atomide.com>
> > > Acked-by: Conor Dooley <conor.dooley@microchip.com>
> > > Signed-off-by: Dhruva Gole <d-gole@ti.com>
> > > ---
> > 
> > How about the driver changes to actually support this compatible?
> 
> Wanted to post this patch before I posted the driver changes,
> have posted them here now:
> 
> https://lore.kernel.org/all/20230805045554.786092-1-d-gole@ti.com
> 

Please dont patches piecemeal - it makes no sense to review without
context.

Please send future series organized as follows:
* binding
* driver updates
* if any dts updates are relevant - mark them as DONOTMERGE to let the
  driver maintainer know that the dts patches go via SoC tree - most
  maintainers know this, but it is better to be safe.
-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
