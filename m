Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE75D7778DD
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 14:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235481AbjHJMxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 08:53:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233199AbjHJMxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 08:53:51 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BB6F2698;
        Thu, 10 Aug 2023 05:53:49 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37ACrRub048755;
        Thu, 10 Aug 2023 07:53:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691672007;
        bh=uYZTDKeU4rsKqk+u8ek7UbQLVm8hR2nUi3uxOCTh2hk=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=kX7GRbrD+5zRm5zUc3Yi0QiZgUVjtXylr+atGu4O2uN0uj3Y03YFgAjKg7gRdPUjN
         Tp1PbcqNQ62lHkts5PN9B4Qjwijow8KO59kkhAS9kC22YNE9lkngf7CHxuISNH3vLG
         KVv/cWTCTAtDandZVhcX6zrAx9yNjonEjgLpWyAs=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37ACrRC3129971
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 10 Aug 2023 07:53:27 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 10
 Aug 2023 07:53:27 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 10 Aug 2023 07:53:27 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37ACrR3l130327;
        Thu, 10 Aug 2023 07:53:27 -0500
Date:   Thu, 10 Aug 2023 07:53:27 -0500
From:   Nishanth Menon <nm@ti.com>
To:     "Kumar, Udit" <u-kumar1@ti.com>
CC:     Apurva Nandan <a-nandan@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Rafael J Wysocki <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, Keerthy J <j-keerthy@ti.com>
Subject: Re: [PATCH 2/3] arm64: dts: ti: k3-j7200: Add the supported
 frequencies for A72
Message-ID: <20230810125327.pq2fxda7dpv2qf7t@seizing>
References: <20230809173905.1844132-1-a-nandan@ti.com>
 <20230809173905.1844132-3-a-nandan@ti.com>
 <20230809190943.unpcbrinyn5ppei7@hydrated>
 <ab69c4df-708f-8fff-a58b-a6531e15627b@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ab69c4df-708f-8fff-a58b-a6531e15627b@ti.com>
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

On 17:23-20230810, Kumar, Udit wrote:
[..]
> > > +		opp1-750000000 {
> > > +			opp-hz = /bits/ 64 <750000000>;
> > >   		};
> > >   	};
> > > -- 
> > > 2.34.1
> > > 
> > Are you sure this is correct to enable all OPPs without efuse bit checks?
> > 
> > https://www.ti.com/lit/ds/symlink/dra821u-q1.pdf
> > 7.5 Operating Performance Points
> > DRA821xC operates only upto 750MHz
> > DRA821xE at 1GHz
> > DRA821xL upto 1.5GHz and
> > DRA821xT upto 2GHz
> 
> Looks, top SKUs is considered here .
> 
> After detecting which SKU we are running (I hope TRM should have this
> information- through efuse or some other register)
> 
> I think, we can follow two approaches.

Both of these are wrong approaches.

> 
> 1) have OPP table for each SKU and select based SKUs type or

This proliferates cpu dtsi to make it hard to manage

> 
> 2) Do run time fixup by u-boot based upon SKU type

This wont work:

a) in u-boot's falcon boot mode and puts unrelated responsibility to
bootloader (u-boot is not the only bootloader in the party here).
b) Further, the reason for doing the opp detection in the kernel is
due to the severity of consequence of attempting to run a lower rated
chip at higher frequency - PoH (Power on Hours) or physical damage can
result.
c) Finally, in a virtualized environment: TISCI will get DM (Device
Manager) to arbitrate between the each of the VM's request, but if
the VM's are'nt self sufficient, we will have DM making wrong choices
resulting in (b) condition again.

This is the reason why drivers/cpufreq/ti-cpufreq.c exists and all SoCs
that have OPPs from TI is handled in the kernel itself.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
