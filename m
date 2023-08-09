Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BAD9775E23
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 13:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231782AbjHILt0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 07:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbjHILtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 07:49:24 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1436C10C;
        Wed,  9 Aug 2023 04:49:24 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 379BnDox102401;
        Wed, 9 Aug 2023 06:49:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691581753;
        bh=NHaMV8AQ458hXfrujPP7b8dUqu4ww4eGJkczmu6Nivg=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=G4Dq5pM+rVVvdmIHaDyd04wFiCgC/U7fP21ZTNxhToV8d+2vHDXSY/Twcr9/DiPMd
         QRG+6FJVAEXajoyUYtW1eFwrxQOLBvBUVdsDMU3eXnE+Kq84Tn/bXwnjgjU2QOrIAO
         UDEWJjb4khJ95kPOnKheDsFHfFJwNG495QO5mS58=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 379BnDDL014024
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 9 Aug 2023 06:49:13 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 9
 Aug 2023 06:49:13 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 9 Aug 2023 06:49:13 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 379BnDAx013045;
        Wed, 9 Aug 2023 06:49:13 -0500
Date:   Wed, 9 Aug 2023 06:49:13 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Dhruva Gole <d-gole@ti.com>
CC:     Tony Lindgren <tony@atomide.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-gpio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-omap@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Haojian Zhuang <haojian.zhuang@linaro.org>
Subject: Re: [PATCH 0/2] pinctrl-single: introduce am654-padconf compatible
Message-ID: <20230809114913.xr6cvz4h2zsobwou@kobold>
References: <20230808102207.130177-1-d-gole@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230808102207.130177-1-d-gole@ti.com>
User-Agent: NeoMutt/20171215
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

On 15:52-20230808, Dhruva Gole wrote:
> The K3 family of SOCs use certain bits of the padconfig registers like
> WKUP_EVT and WKUP_EN to enable daisychain wakeups.
> 
> For example, these bits are described in the AM654 TRM [0] under
> "Table 5-517. Description Of The Pad Configuration Register Bits"
> 
> This series adds the DT binding changes for adding the compatible and
> also the driver changes which make use of this compatible.
> 
> NOTE: Some K3 SoCs may have these bits marked as reserved which means
> that they don't support IO daisychain. Such SOCs are not expected to use
> this compatible.
> 
> The general expected usage is when the device is in a suspended state like Deep
> Sleep or Suspend to RAM, and any IO activity on configured pads can
> trigger a wakeup.
> 
> Link to complete series:
> https://lore.kernel.org/all/20230808102207.130177-1-d-gole@ti.com
> 
> Base commit:
> 71cd4fc492ec (tag: next-20230808, linux-next/master) Add linux-next specific files for 20230808
> 
> depends on:
> https://lore.kernel.org/r/20230721082654.27036-1-tony@atomide.com
> 
> which has been picked up by Linus Walleij in his tree here:
> https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git/commit/?h=devel&id=677a62482bd6e584f83d0342e78735e3cd449ba4
> 
> However, it hasn't reflected in -next yet so specifying the depends on
> above.

next-20230809 has it today - so just a day or two of sync.. no biggie.

> 
> [0] https://www.ti.com/lit/pdf/spruid7
> 
> Cc: Nishanth Menon <nm@ti.com>
> Cc: Vignesh Raghavendra <vigneshr@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Conor Dooley <conor.dooley@microchip.com>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Haojian Zhuang <haojian.zhuang@linaro.org>

For the series:

Reviewed-by: Nishanth Menon <nm@ti.com>

Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
