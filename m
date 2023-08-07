Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81D597729E1
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 17:55:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbjHGPzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 11:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjHGPzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 11:55:06 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D1C8E53;
        Mon,  7 Aug 2023 08:55:05 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 377FsxQT045788;
        Mon, 7 Aug 2023 10:54:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691423699;
        bh=bEjL8gjE7XadgK1Jtrg8L9mHqv6kmDcDrglY/EcATvc=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=raJIyaSwSMIOHXRmIt2YZR19Mh2iBG/FUzlK3LDy6HAua0Ml1/ji0qQAXhQn3/gxi
         agnmj1wyCjLYWDeizchn5uDCJd3pxr51oaqMyYSz2qgH8fSUupLUF1wfhGJEq7hvmd
         4YhXTkQlN8Pn5W68ZQ0udk7Y9quKoYKPpsOM7hxA=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 377FsxR8010118
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 7 Aug 2023 10:54:59 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 7
 Aug 2023 10:54:59 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 7 Aug 2023 10:54:59 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 377Fsxee011951;
        Mon, 7 Aug 2023 10:54:59 -0500
Date:   Mon, 7 Aug 2023 10:54:59 -0500
From:   Nishanth Menon <nm@ti.com>
To:     "Kumar, Udit" <u-kumar1@ti.com>
CC:     Vaishnav Achath <vaishnav.a@ti.com>, <vigneshr@ti.com>,
        <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <t-konduru@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bhavya Kapoor <b-kapoor@ti.com>
Subject: Re: [PATCH v2] arm64: dts: ti: k3-j784s4-evm: Correct Pin mux offset
 for ospi
Message-ID: <20230807155459.j36h2477xxdsigqn@overrule>
References: <20230802114126.162445-1-u-kumar1@ti.com>
 <0d311099-a93e-4270-e78f-a464b7fcaa34@ti.com>
 <5f882fff-4f68-b762-a8f3-a0f228046a52@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <5f882fff-4f68-b762-a8f3-a0f228046a52@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20:33-20230807, Kumar, Udit wrote:
> Thanks Vaishnav.
> 
> Hi Nishanth,
> 
> On 8/7/2023 8:09 PM, Vaishnav Achath wrote:
> > Hi Udit,
> > 
> > On 02/08/23 17:11, Udit Kumar wrote:
> > > [...]
> > > Thank you for the patch,
> > > 
> > > For OSPI functionality:
> > > 
> > > Tested-by: Vaishnav Achath <vaishnav.a@ti.com>
> > > 
> > > before: https://gist.github.com/vaishnavachath/c87275e53f6ae38bacc44c65ed09c733
> > > (QSPI probe fails due to wrong pinmux)
> > > after: https://gist.github.com/vaishnavachath/b5f6147cfae5218815aca94ec0dfd991
> > > (both QSPI, OSPI is functional)
> > > 
> > > heads-up :
> > > I see the following warnings for ADC:
> > > 
> > > ```
> > >   pinctrl-single 4301c068.pinctrl: mux offset out of range: 0x134 (0x120)
> > >   pinctrl-single 4301c068.pinctrl: could not add functions for
> > > mcu-adc0-default-pins 308x
> > > pinctrl-single 4301c068.pinctrl: mux offset out of range: 0x154 (0x120)
> > > pinctrl-single 4301c068.pinctrl: could not add functions for
> > > mcu-adc1-default-pins 340x
> > > ```
> > > 
> > > mcu_adc0_pins_default and mcu_adc1_pins_default entries needs to have the
> > > wkup_pmx2 base (0x68) subtracted to get the appropriate offsets, not sure if
> > > there is already a patch addressing the same or should be part of this patch.
> 
> let me know, if you are ok with other patch to address adc pin mux or I
> should respin with adc changes

adc fixes come separate on top - for the next time please:

Roll these fixes out in a single series.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
