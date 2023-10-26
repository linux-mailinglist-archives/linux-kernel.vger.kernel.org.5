Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B50997D81DD
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 13:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344816AbjJZLfR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 07:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjJZLfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 07:35:16 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5C621A7;
        Thu, 26 Oct 2023 04:35:12 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39QBZ2Oh035567;
        Thu, 26 Oct 2023 06:35:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1698320102;
        bh=JwHjpqFRV88wTNr38a0PSsE3yATWOgEaDdqW7SNjHvM=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=ff55jYOwr2nkd5YEvJ2Ds6lAOmLCrAoLFMpprZFcEDe6zqLwBnnCs/hLN/j/lK2m+
         MZUb1hzc7ZAlAI5nEsbqEmFrwFTg/3WkGbl5287tDcb7EfVVn1Ghq4qjN84088OPNW
         0txdWUprQpwgxzbb27Nuk5hrgIlzAHQMaVyAQYbw=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39QBZ2fH031525
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 26 Oct 2023 06:35:02 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 26
 Oct 2023 06:35:02 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 26 Oct 2023 06:35:02 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39QBZ29Q093559;
        Thu, 26 Oct 2023 06:35:02 -0500
Date:   Thu, 26 Oct 2023 06:35:02 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Nitin Yadav <n-yadav@ti.com>
CC:     <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: boot: dts: ti: k3-am62a-main: Fix GPIO pin count
 in DT nodes.
Message-ID: <20231026113502.mubbq3ajwudaeqlk@curtain>
References: <20231025110252.1089979-1-n-yadav@ti.com>
 <20231025155743.nk7un6pvib7swtxg@decorator>
 <e8271648-e29f-80d2-4896-2d0d5c951c6f@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <e8271648-e29f-80d2-4896-2d0d5c951c6f@ti.com>
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

On 12:17-20231026, Nitin Yadav wrote:
> On 25/10/23 21:27, Nishanth Menon wrote:
> > On 16:32-20231025, Nitin Yadav wrote:
> >> Fix number of gpio pins in main_gpio0 & main_gpio1 DT nodes according
> >> to AM62a SK datasheet. The Link of datasheet is in the following line:
> > 
> > SK? line?
> > 
> > Please rephrase above and just mention the section of the data sheet to
> > refer to.
> > 
> >>
> >> https://www.ti.com/lit/gpn/am62a3
> >>
> >> Section: 6.3.10 GPIO (Page No. 52-55)
> > 
> >>
> >> Fixes: '5fc6b1b62639c ("arm64: dts: ti: Introduce AM62A7 family of SoCs")'
> > 
> > What is the single quote for?
> > Also note the additional comment in the list to drop the extra EoL.
> > 
> > 
> > Did you check the MCU and WKUP GPIO count as well? if there are bugs
> > around it, fix it in a single commit please.
> yes, checked they are good.

OK, Thanks for checking, please respin once rc1 is out.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
