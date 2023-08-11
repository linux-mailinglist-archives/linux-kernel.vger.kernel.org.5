Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A91E779686
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 19:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236857AbjHKRzM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 13:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232158AbjHKRzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 13:55:11 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 936052D70;
        Fri, 11 Aug 2023 10:55:10 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37BHsxJN052577;
        Fri, 11 Aug 2023 12:54:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691776499;
        bh=+h0szykeuT5J9rl7gKB8ajJUY7A2HmWdbv0G4z8QJPU=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=xd5z7c72CNW4mf3S3S69UMiV6jtT6eW+KgVm8Cn3Z76kE0MlH7bOdaeeF+go2qiOx
         n6VaOMYoNWL9kFCaybiBqbTKbYCYLvNKW+tv3KiPxOTrS5fz2eGfMthDlu954f9Hkx
         wC2OWfSBvp6kyyXoaFtyGoerLNgm8zGeGv6TE5yw=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37BHsxwl010586
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 11 Aug 2023 12:54:59 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 11
 Aug 2023 12:54:59 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 11 Aug 2023 12:54:59 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37BHsxDQ007835;
        Fri, 11 Aug 2023 12:54:59 -0500
Date:   Fri, 11 Aug 2023 12:54:59 -0500
From:   Nishanth Menon <nm@ti.com>
To:     "Kumar, Udit" <u-kumar1@ti.com>
CC:     Apurva Nandan <a-nandan@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Hari Nagalla <hnagalla@ti.com>,
        Dasnavis Sabiya <sabiya.d@mistralsolutions.com>
Subject: Re: [PATCH v4 3/3] arm64: dts: ti: k3-am69-sk: Add phase tags marking
Message-ID: <20230811175459.nxi65bu4bbjki5xe@duller>
References: <20230811151644.3216621-1-a-nandan@ti.com>
 <20230811151644.3216621-4-a-nandan@ti.com>
 <638d5883-5b95-403e-ecb9-8122d8774675@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <638d5883-5b95-403e-ecb9-8122d8774675@ti.com>
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

On 23:05-20230811, Kumar, Udit wrote:
> Hi Apurva
> 
> On 8/11/2023 8:46 PM, Apurva Nandan wrote:
> > bootph-all as phase tag was added to dt-schema
> > (dtschema/schemas/bootph.yaml) to cover U-Boot challenges with DT.
> > That's why add it also to Linux to be aligned with bootloader requirement.
> > 
> > wkup_uart0, wkup_i2c0, mcu_uart0, main_uart8, main_sdhci0 and main_sdhci1
> > are required for bootloader operation on TI K3 AM69-SK EVM. These IPs
> > along with pinmuxes need to be marked for all bootloader phases, hence add
> > bootph-all to these nodes in kernel dts.
> > 
> > Signed-off-by: Apurva Nandan <a-nandan@ti.com>
> > ---
> > [...]
> >   &wkup_uart0 {
> > +	bootph-all;
> >   	/* Firmware usage */
> >   	status = "reserved";
> >   	pinctrl-names = "default";
> 
> I am not sure, if you want to treat wkup_uart in same way as you are
> treating secure_proxy_mcu in patch 1 of this series.

You should'nt. wkup_uart0 or what ever peripherals are specifically
board dependent. This patch does it the right way. I do have other
platforms on other K3 SoCs where the TIFS uart logs are actually
disabled.

> 
> IMO, where we are making this node status is okay, mark booth-all at that
> place only.
> 
> Otherwise for rest of series
> 
> LGTM

Do i take that as a Reviewed-by: for the series?
> 
> 
[...]

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
