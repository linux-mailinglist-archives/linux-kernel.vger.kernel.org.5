Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 086AE80113F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 18:21:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378403AbjLAQbv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 11:31:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbjLAQbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 11:31:47 -0500
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15872D48
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 08:31:51 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3B1GVQau093115;
        Fri, 1 Dec 2023 10:31:26 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1701448286;
        bh=yK0mxR+iuP9kIWX/jvKS63AchZZ0hCSmlqRwB4k0HjE=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=Il9Bu7J6W2EQt1ldiD4vpqHP6a2xSD08YBoE9jmI33f5rgBv2UrMDIiEZ2d9pwbXa
         Kdi9hKaedloT6TSeRgfis8D31QOZA8L5dMQRABraWE3e2um3dihw+yrdGCl4/pZzm+
         1OP4iaRBxzBobBRSvHRqAKRecnOZITRym+QMsrG8=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3B1GVQuB082051
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 1 Dec 2023 10:31:26 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 1
 Dec 2023 10:31:26 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 1 Dec 2023 10:31:25 -0600
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3B1GVQJT003915;
        Fri, 1 Dec 2023 10:31:26 -0600
Date:   Fri, 1 Dec 2023 10:31:26 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Arnd Bergmann <arnd@arndb.de>
CC:     Tony Lindgren <tony@atomide.com>,
        Francesco Dolcini <francesco@dolcini.it>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Tero Kristo <kristo@kernel.org>
Subject: Re: [PATCH] arm64: defconfig: increase SERIAL_8250_NR_UARTS
Message-ID: <20231201163126.oaixjeo4i3gvmsyt@molar>
References: <20231130231657.12715-1-francesco@dolcini.it>
 <20231201060346.GE5169@atomide.com>
 <20231201064919.5mbmqo5fco7n3rgq@endnote>
 <855dfa50-a3a3-415a-8612-4da59f995ef0@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <855dfa50-a3a3-415a-8612-4da59f995ef0@app.fastmail.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16:31-20231201, Arnd Bergmann wrote:
> On Fri, Dec 1, 2023, at 07:49, Nishanth Menon wrote:
> > On 08:03-20231201, Tony Lindgren wrote:
> >> * Francesco Dolcini <francesco@dolcini.it> [231130 23:17]:
> >> > Increase CONFIG_SERIAL_8250_NR_UARTS from 4 to 8, the current legacy value
> >> > is not adequate for embedded systems that use SoCs where it's common to
> >> > have a large number of serial ports.
> >> > 
> >> > No need to change CONFIG_SERIAL_8250_RUNTIME_UARTS, see commit 9d86719f8769
> >> > ("serial: 8250: Allow using ports higher than SERIAL_8250_RUNTIME_UARTS").
> >> > 
> >> > This enables using the UART connected Bluetooth device on Verdin AM62
> >> > board.
> >> 
> >> OK makes sense for distro use.
> >> 
> >> Disabling unused ports leads into port names shifting, which we still can't
> >> easily tolerate until we have the DEVNAME:0.0 style addressing available for
> >> ports. So for now we still depend CONFIG_SERIAL_8250_NR_UARTS, eventually
> >> that too should become just a legacy ISA port array.. Meanwhile:
> >> 
> >> Reviewed-by: Tony Lindgren <tony@atomide.com>
> >
> > I'd prefer to get Arnd's view on the topic as well (I kind of
> > recollect some historic discussion which I am not failing to trace
> > that there usage model doesn't exceed 4 and aliases could be used to
> > map these as required for the platform). The 8250 debate has been
> > popping on and off over the years.. Sigh.. memories of [1] still haunt
> > me.
> 
> I don't recall any reason to have the limit set to the default
> of 4, other than possibly using excessive amounts of .data in
> vmlinux, but we have other serial port drivers that just hardcode
> a much larger value.

Thanks Arnd, we will queue this up.

Francesco: Could you respin with a more clear commit message to indicate
actual board usage instance.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
