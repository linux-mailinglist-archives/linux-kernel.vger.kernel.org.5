Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F3BD779940
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 23:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236246AbjHKVPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 17:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjHKVPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 17:15:01 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C1AD171F;
        Fri, 11 Aug 2023 14:15:00 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37BLEo4j086332;
        Fri, 11 Aug 2023 16:14:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691788490;
        bh=3FiBFHExBQrDVeeYuHKo+/tmEj7jNIisdfEiRNPw2Lo=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=jh1T2uHU1Sde8pmv7BxksOhE/uEHsEuPga7q3q+6tyCOFjbgGiVSi8pJKehDGQGmg
         b7TtpWadME3zUQp+TCy0UJLAS0VQphb1dO1973gNdSniv4ZNY/2LDQySdZVNZfnHNE
         oUW1gMoi5QI+hDaNHovbSFW1F+gO8/prDnPU/bSs=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37BLEohd088187
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 11 Aug 2023 16:14:50 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 11
 Aug 2023 16:14:50 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 11 Aug 2023 16:14:50 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37BLEoCe031975;
        Fri, 11 Aug 2023 16:14:50 -0500
Date:   Fri, 11 Aug 2023 16:14:50 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Andrew Davis <afd@ti.com>
CC:     Apurva Nandan <a-nandan@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Hari Nagalla <hnagalla@ti.com>, Udit Kumar <u-kumar1@ti.com>
Subject: Re: [PATCH v3 0/5] Add R5F and C7x DSP nodes for J721S2 SoC.
Message-ID: <20230811211450.psoe6wjvncwxoqe2@enlarged>
References: <20230811202252.3586926-1-a-nandan@ti.com>
 <a5731a6b-f97b-a1c7-4322-a50c538ad11b@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <a5731a6b-f97b-a1c7-4322-a50c538ad11b@ti.com>
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

On 15:31-20230811, Andrew Davis wrote:
> On 8/11/23 3:22 PM, Apurva Nandan wrote:
> > This series adds the R5F processor nodes and C7x DSP nodes for
> > J721S2 SoC.
> > 
> > The first three patches adds the remote proc nodes to the SoC device
> > tree and the last two patches reserves the memory for remote proc IPCs
> > on J721S2 EVM board.
> > 
> > Test log: https://gist.githubusercontent.com/apurvanandan1997/556b4148651ae74b50dda993ad07f1e5/raw/
> > 
> > v3: Changelog:
> > 1) Disabled c7x in k3-j721s2-main.dtsi and enabled in k3-j721s2-som-p0.dtsi
> >     which fixes the following dtbs_check for k3-am69-sk.dts
> >     - dsp@64800000: 'mboxes' is a required property
> >     - dsp@64800000: 'memory-region' is a required property
> > 2) Split into separate patches for C7x and R5F
> 
> Thanks for taking care of these details, series LGTM,
> 
> Reviewed-by: Andrew Davis <afd@ti.com>
> 
> > 
> > Link to v2:
> > https://lore.kernel.org/lkml/20230808201842.292911-1-a-nandan@ti.com/
> > 
> > v2:Changelog:
> > 1) Added status = "disabled"; in soc dtsi files, and removed it from som dts
> > 2) Fixed mboxes property in for all cores in som dts
> > 
> > Link to v1:
> > https://lore.kernel.org/all/20230529220941.10801-1-hnagalla@ti.com/
> > 
> > Apurva Nandan (4):
> >    arm64: dts: ti: k3-j721s2-main: Add MAIN R5F remote processsor nodes
> >    arm64: dts: ti: k3-j721s2-main: Add C7x remote processsor nodes
> >    arm64: dts : ti: k3-j721s2-som-p0: Add DDR carveout memory nodes for
> >      R5F
> >    arm64: dts : ti: k3-j721s2-som-p0: Add DDR carveout memory nodes for
> >      C71x DSPs
> > 
> > Hari Nagalla (1):
> >    arm64: dts: ti: k3-j721s2-mcu: Add MCU R5F cluster nodes

We are still missing arch/arm64/boot/dts/ti/k3-am68-sk-som.dtsi which is
a TI product.

So, lets hold this series off from the immediate merge set at least.

> > 
> >   arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi    | 106 +++++++++
> >   .../boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi     |  40 ++++
> >   arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi  | 208 ++++++++++++++++++
> >   3 files changed, 354 insertions(+)
> > 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
