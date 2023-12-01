Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 567948017BD
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 00:27:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235273AbjLAX0z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 18:26:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235261AbjLAX0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 18:26:53 -0500
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 140C3170E
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 15:26:33 -0800 (PST)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3B1NQEO8078789;
        Fri, 1 Dec 2023 17:26:14 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1701473174;
        bh=WNEqQ5+oTLmQvai2ODsZj81FFSfax59gqBr1faq3gw4=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=icDI/RioSpr//wBxnP8YIR1T74BgD+5RbcRYzLyydUMf5AGC6yc/xUJoYQtvnzKN1
         1WS4Dqoy7jWnwhPyYczxHrVzjrx/KM8NofdYt+uGoo14JaoZ+SCLy1svRFCPVW3kzQ
         sEw78coCNo5rk/8G1Uu7lepo0aAxTmHQxPcQ3mB8=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3B1NQE4q033784
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 1 Dec 2023 17:26:14 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 1
 Dec 2023 17:26:14 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 1 Dec 2023 17:26:14 -0600
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3B1NQE3v011358;
        Fri, 1 Dec 2023 17:26:14 -0600
Date:   Fri, 1 Dec 2023 17:26:14 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Francesco Dolcini <francesco@dolcini.it>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Tero Kristo <kristo@kernel.org>,
        Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2] arm64: defconfig: increase SERIAL_8250_NR_UARTS
Message-ID: <20231201232614.jvj4d5nu7j2xf5ia@ability>
References: <20231201171544.1901-1-francesco@dolcini.it>
 <20231201191958.kmwkpmttmebsas47@kooky>
 <ZWo5kVMoLTzST6F5@livingston.pivistrello.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZWo5kVMoLTzST6F5@livingston.pivistrello.it>
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

On 20:52-20231201, Francesco Dolcini wrote:
> On Fri, Dec 01, 2023 at 01:19:58PM -0600, Nishanth Menon wrote:
> > On 18:15-20231201, Francesco Dolcini wrote:
> > > Increase CONFIG_SERIAL_8250_NR_UARTS from 4 to 8, the current legacy value
> > > is not adequate for embedded systems that use SoCs where it's common to
> > > have a large number of serial ports.
> > > 
> > > No need to change CONFIG_SERIAL_8250_RUNTIME_UARTS, see commit 9d86719f8769
> > > ("serial: 8250: Allow using ports higher than SERIAL_8250_RUNTIME_UARTS").
> > > 
> > > The need to increase this value was noticed while working with Toradex
> > > Verdin AM62, this board has 4 serial UART instances available to the user
> > > plus an internal one that is connected to a Bluetooth module. Without this
> > > change the fifth UART connected to the BT module is not instantiated and BT
> > > is not working.
> > > 
> > > Instead of increasing the number to the bare minimum (5) that would be
> > > required to solve this specific issue, we increase this to 8 which seems a
> > > more reasonable number to have in the defconfig and should cover more valid
> > > use cases.
> > 
> > To address Arnd's concern on size increase, it will be good to add:
> 
> I can and I will add it in a v3 - it takes less time to do it than reply to
> this email and thanks for taking the time to provide the actual data.
> 
> With that said my understanding is that the goal of the arm64 defconfig is
> to enable the supported arm64 hardware and the related kernel development.
> It's not supposed to be a minimal config in size nor an optimal
> configuration from the performance point of view. It's a single
> configuration that includes support for each and every platform [1]
> supported by Linux arm64 ...
> 
> To me Arnd was just stating a fact, not raising a concern that was supposed
> to be addressed (just correct me if I'm wrong, of course).
> 
> [1] well, apart AMD Pensando and Bitmain, at the moment, but you get the
> point, I'm sure ;-).
> 

Hehe, thanks Francesco.

Arnd, my memory was a bit right on the topic though.. .. I think we
had gone down a similar road before in trying to increase the number
of 8250 UARTs [1] but without this strong a reason.. Been a while, I
think our v3 is much stronger case now.

[1] https://lore.kernel.org/all/CAK8P3a2VSBvOn1o+q1PYZaQ6LS9U4cz+DZGuDbisHkwNs2dAAw@mail.gmail.com/#t
-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
