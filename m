Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 515E5800424
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 07:49:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377647AbjLAGtc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 01:49:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbjLAGta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 01:49:30 -0500
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1FC11736
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 22:49:35 -0800 (PST)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3B16nKwu090484;
        Fri, 1 Dec 2023 00:49:20 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1701413360;
        bh=8ir9SHgj+6BiqA15DG54/o7JpkjIT/ox3drhpYaelBs=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=bJpsq/nAffL13+7SKurJOWjnWoWsvZW//r8SUTHhqSd2q25K5tVZr4hchHNsxFYIa
         YytR7C4FLge0IKxOnoNt4s+aW2lo9JIKd1e+nr6GJHK94kPv3sOv+su1UwOJ0S5Pe7
         A3RU7E9eUta8Mql5ELMXQpOdFM6rz1DewjhimBOg=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3B16nKa6014568
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 1 Dec 2023 00:49:20 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 1
 Dec 2023 00:49:19 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 1 Dec 2023 00:49:19 -0600
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3B16nJTU075833;
        Fri, 1 Dec 2023 00:49:19 -0600
Date:   Fri, 1 Dec 2023 00:49:19 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Tony Lindgren <tony@atomide.com>
CC:     Francesco Dolcini <francesco@dolcini.it>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Tero Kristo <kristo@kernel.org>
Subject: Re: [PATCH] arm64: defconfig: increase SERIAL_8250_NR_UARTS
Message-ID: <20231201064919.5mbmqo5fco7n3rgq@endnote>
References: <20231130231657.12715-1-francesco@dolcini.it>
 <20231201060346.GE5169@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231201060346.GE5169@atomide.com>
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

On 08:03-20231201, Tony Lindgren wrote:
> * Francesco Dolcini <francesco@dolcini.it> [231130 23:17]:
> > Increase CONFIG_SERIAL_8250_NR_UARTS from 4 to 8, the current legacy value
> > is not adequate for embedded systems that use SoCs where it's common to
> > have a large number of serial ports.
> > 
> > No need to change CONFIG_SERIAL_8250_RUNTIME_UARTS, see commit 9d86719f8769
> > ("serial: 8250: Allow using ports higher than SERIAL_8250_RUNTIME_UARTS").
> > 
> > This enables using the UART connected Bluetooth device on Verdin AM62
> > board.
> 
> OK makes sense for distro use.
> 
> Disabling unused ports leads into port names shifting, which we still can't
> easily tolerate until we have the DEVNAME:0.0 style addressing available for
> ports. So for now we still depend CONFIG_SERIAL_8250_NR_UARTS, eventually
> that too should become just a legacy ISA port array.. Meanwhile:
> 
> Reviewed-by: Tony Lindgren <tony@atomide.com>

I'd prefer to get Arnd's view on the topic as well (I kind of
recollect some historic discussion which I am not failing to trace
that there usage model doesn't exceed 4 and aliases could be used to
map these as required for the platform). The 8250 debate has been
popping on and off over the years.. Sigh.. memories of [1] still haunt
me.

I assume you are talking of
arch/arm64/boot/dts/ti/k3-am62-verdin-wifi.dtsi which in turn uses
arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi (5 uarts) and that is where the
increase in serial port is coming from.

Now 8 or 5 (which seems to be the relevant need) is subjective :(


[1] https://lore.kernel.org/linux-arm-kernel/Y3x%2FcGYWLLB+J2zU@atomide.com/

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
