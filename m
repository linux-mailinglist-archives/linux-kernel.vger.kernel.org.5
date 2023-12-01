Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 109C380066B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 10:00:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377925AbjLAJAL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 04:00:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjLAJAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 04:00:10 -0500
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FA0ACC
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 01:00:16 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3B18xvHB089747;
        Fri, 1 Dec 2023 02:59:57 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1701421197;
        bh=QSSFERr3q7Bzs0oMEM4CyTggXCnhfwRRixsLjWUDTA8=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=mNmAIfdCTS1rvEEYpQ3fpOFYWZXaB7fLLUyEQkIbiJ8L4FWwjY2LkzHK5q+QBYCLn
         2v0ppi0QSty9iTSvU9GTIQCTgF2bav2vlQGEF+YqDtyYzxviGPF631ShsoPhyo3cmq
         eLPTs/8fL4N5k/w4qtJyaUvlj9lK6VkpmoxndP98=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3B18xv09029280
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 1 Dec 2023 02:59:57 -0600
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 1
 Dec 2023 02:59:57 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 1 Dec 2023 02:59:57 -0600
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3B18xvtZ066193;
        Fri, 1 Dec 2023 02:59:57 -0600
Date:   Fri, 1 Dec 2023 02:59:57 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Francesco Dolcini <francesco@dolcini.it>
CC:     Tony Lindgren <tony@atomide.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Tero Kristo <kristo@kernel.org>
Subject: Re: [PATCH] arm64: defconfig: increase SERIAL_8250_NR_UARTS
Message-ID: <20231201085957.uxvwe3l33n5fxfw4@unrushed>
References: <20231130231657.12715-1-francesco@dolcini.it>
 <20231201060346.GE5169@atomide.com>
 <20231201064919.5mbmqo5fco7n3rgq@endnote>
 <ZWmdyenBpqI1S8HG@francesco-nb.int.toradex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZWmdyenBpqI1S8HG@francesco-nb.int.toradex.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09:48-20231201, Francesco Dolcini wrote:
> On Fri, Dec 01, 2023 at 12:49:19AM -0600, Nishanth Menon wrote:
> > On 08:03-20231201, Tony Lindgren wrote:
> > > * Francesco Dolcini <francesco@dolcini.it> [231130 23:17]:
> > > > Increase CONFIG_SERIAL_8250_NR_UARTS from 4 to 8, the current legacy value
> > > > is not adequate for embedded systems that use SoCs where it's common to
> > > > have a large number of serial ports.
> > > > 
> > > > No need to change CONFIG_SERIAL_8250_RUNTIME_UARTS, see commit 9d86719f8769
> > > > ("serial: 8250: Allow using ports higher than SERIAL_8250_RUNTIME_UARTS").
> > > > 
> > > > This enables using the UART connected Bluetooth device on Verdin AM62
> > > > board.
> > > 
> > > OK makes sense for distro use.
> > > 
> > > Disabling unused ports leads into port names shifting, which we still can't
> > > easily tolerate until we have the DEVNAME:0.0 style addressing available for
> > > ports. So for now we still depend CONFIG_SERIAL_8250_NR_UARTS, eventually
> > > that too should become just a legacy ISA port array.. Meanwhile:
> > > 
> > > Reviewed-by: Tony Lindgren <tony@atomide.com>
> > 
> > I'd prefer to get Arnd's view on the topic as well (I kind of
> > recollect some historic discussion which I am not failing to trace
> > that there usage model doesn't exceed 4 and aliases could be used to
> > map these as required for the platform).
> 
> The usage model that triggered this change exceed 4, we >4 uart in
> use at the same time.
> 
> And the issue is not really "distro use", and I do not think anything
> about aliases matter (the BT device is described as a child of the uart
> in the DT).
> 
>   &main_uart5 {
>     bluetooth {
>       compatible = "nxp,88w8987-bt";
>     };
>   };
> 
> The change here is required to have basic hardware functionalities
> working for kernel development and debugging using the in-tree
> defconfig.
> 
> 
> > Now 8 or 5 (which seems to be the relevant need) is subjective :(
> 

I'd suggest to elaborate on "This enables using the UART connected
Bluetooth device on Verdin AM62 board."
Commit message a bit more to indicate what each of the uarts are used
for - this will help explain that we have a real platform that needs
more than 4 uarts simultaneously. we seem to have survived quite a few
years with count of 4.. so we need to defend why this change now and why
it helps the ecosystem.. just my 2 cents.

Yes, I did indeed look and found the case you are indicating, but for
rest of the community, commit message should indicate why (it will help
if other boards benefit as well, but I personally feel this case, if
elaborated is sufficient enough reason by itself).


-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
