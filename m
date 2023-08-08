Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6352773D71
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 18:18:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232239AbjHHQRn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 12:17:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232223AbjHHQPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 12:15:30 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAD37213C;
        Tue,  8 Aug 2023 08:41:12 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 378EHQp3099674;
        Tue, 8 Aug 2023 09:17:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691504246;
        bh=vDwbrgkiFCdsXJUkgA3+nB2QUD46dzcCrCqhjQczf10=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=ZEJp2vGvJEEwApJkfh1Q6gLvP1plm0NI0i6Dqc2Lkf6+LnuxkygIa4CIma6WCVUZA
         LqZ0mUAfN+BJ+aldexhsT1g5S3icPgw3NtYBIeS6OAeSOW8Thc2BKeo38t06o74Gv6
         0OPn6RIQEnpPbzDDVmK0DMxi+/vDzsfIL7ecOS5M=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 378EHQuP031327
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 8 Aug 2023 09:17:26 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 8
 Aug 2023 09:17:25 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 8 Aug 2023 09:17:25 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 378EHPSd103861;
        Tue, 8 Aug 2023 09:17:25 -0500
Date:   Tue, 8 Aug 2023 09:17:25 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Andrew Davis <afd@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Dhruva Gole <d-gole@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 07/13] arm64: dts: ti: k3-am64: Enable OSPI nodes at
 the board level
Message-ID: <20230808141725.65r25aoot54zcwex@turbojet>
References: <20230808133457.25060-1-afd@ti.com>
 <20230808133457.25060-8-afd@ti.com>
 <58daf644-7b16-4768-8885-bd60aa6c014f@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <58daf644-7b16-4768-8885-bd60aa6c014f@ti.com>
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

On 09:13-20230808, Andrew Davis wrote:
> On 8/8/23 8:34 AM, Andrew Davis wrote:
> > OSPI nodes defined in the top-level AM64 SoC dtsi files are incomplete
> > and may not be functional unless they are extended with pinmux and
> > device information.
> > 
> > As the attached OSPI device is only known about at the board integration
> > level, these nodes should only be enabled when provided with this
> > information.
> > 
> > Disable the OSPI nodes in the dtsi files and only enable the ones that
> > are actually pinned out on a given board.
> > 
> > Signed-off-by: Andrew Davis <afd@ti.com>
> > Reviewed-by: Dhruva Gole <d-gole@ti.com>
> > ---
> 
> Oops, I see we have a new AM64 board in -next (tqma64xxl), I can either
> rebase this again and enable the nodes in there. Or you can skip this
> and the other AM64 patch in this series and I'll resend them next cycle
> when that new board is settled.

we should respin this series taking the new boards into consideration -
am64 and am62 both have new boards.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
