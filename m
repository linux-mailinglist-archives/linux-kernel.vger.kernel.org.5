Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B5C07796E6
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 20:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234786AbjHKSMl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 14:12:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbjHKSMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 14:12:38 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 923E3120;
        Fri, 11 Aug 2023 11:12:38 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37BICNbU061004;
        Fri, 11 Aug 2023 13:12:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691777543;
        bh=4YvTLyGDAu1gN4H0np67zfxOOtC7PqKgoQJ/1Z8O9XE=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=o4xarZkzLlPD2L7VNX/gvSyaJhLKrfoyKHelrWVTjM4o89bp+ui+Xb1ZbVbeBqsJP
         zwjQdC2EUKgLG7mq+d/L5lx8KRu4HO7wHT5q6VHMzV0GDbQg/fPSHOjuiuxx5pPAtE
         sE66IJq+Bzj7X8H/CHPLZD1vSqVytUwlO/b+GIKg=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37BICNcW021816
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 11 Aug 2023 13:12:23 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 11
 Aug 2023 13:12:22 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 11 Aug 2023 13:12:22 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37BICMqo024531;
        Fri, 11 Aug 2023 13:12:22 -0500
Date:   Fri, 11 Aug 2023 13:12:22 -0500
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
Message-ID: <20230811181222.qtbl4quvs4ieu2ad@founding>
References: <20230811151644.3216621-1-a-nandan@ti.com>
 <20230811151644.3216621-4-a-nandan@ti.com>
 <638d5883-5b95-403e-ecb9-8122d8774675@ti.com>
 <20230811175459.nxi65bu4bbjki5xe@duller>
 <f41102bb-134a-50cc-bb98-7950260c7aa6@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <f41102bb-134a-50cc-bb98-7950260c7aa6@ti.com>
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

On 23:35-20230811, Kumar, Udit wrote:
> 
> On 8/11/2023 11:24 PM, Nishanth Menon wrote:
> > On 23:05-20230811, Kumar, Udit wrote:
> > > Hi Apurva
> > > 
> > > On 8/11/2023 8:46 PM, Apurva Nandan wrote:
> > > > bootph-all as phase tag was added to dt-schema
> > > > (dtschema/schemas/bootph.yaml) to cover U-Boot challenges with DT.
> > > > That's why add it also to Linux to be aligned with bootloader requirement.
> > > > 
> > > > wkup_uart0, wkup_i2c0, mcu_uart0, main_uart8, main_sdhci0 and main_sdhci1
> > > > are required for bootloader operation on TI K3 AM69-SK EVM. These IPs
> > > > along with pinmuxes need to be marked for all bootloader phases, hence add
> > > > bootph-all to these nodes in kernel dts.
> > > > 
> > > > Signed-off-by: Apurva Nandan <a-nandan@ti.com>
> > > > ---
> > > > [...]
> > > >    &wkup_uart0 {
> > > > +	bootph-all;
> > > >    	/* Firmware usage */
> > > >    	status = "reserved";
> > > >    	pinctrl-names = "default";
> > > I am not sure, if you want to treat wkup_uart in same way as you are
> > > treating secure_proxy_mcu in patch 1 of this series.
> > You should'nt. wkup_uart0 or what ever peripherals are specifically
> > board dependent. This patch does it the right way. I do have other
> > platforms on other K3 SoCs where the TIFS uart logs are actually
> > disabled.
> 
> Sorry, if i was not clear in my previous response.
> 
> This node is marked as reserved, adding bootph is not adding any value.
> 
> We can drop bootph from this node here.


Aah - yes. makes sense. Thanks for catching this. reserved nodes dont
make sense to have bootph in kernel dts. zephyr or u-boot r5 view will
probably enable them, and they should call it out.

> 
> > > IMO, where we are making this node status is okay, mark booth-all at that
> > > place only.
> > > 
> > > Otherwise for rest of series
> > > 
> > > LGTM
> > Do i take that as a Reviewed-by: for the series?
> 
> 
> With above change,
> 
> Reviewed-by: Udit Kumar <u-kumar1@ti.com>
> 
> > > 
> > [...]
> > 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
