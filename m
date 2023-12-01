Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 606F8801383
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 20:20:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379513AbjLATUT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 14:20:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379411AbjLATUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 14:20:17 -0500
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4377AF2
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 11:20:23 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3B1JJxSJ017110;
        Fri, 1 Dec 2023 13:19:59 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1701458399;
        bh=4hE0ULmqeZ9UHjJRy8A8SQgh9lDr0tGQ6QM7S2mBOaI=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=iOok+rK5zroDJMumbpaL41DjCkuMdF3uyFDHl/Awo+PxUDY2udKJM5to5TEd5SqjC
         ctjsXlV1rc2+LkSdU04ImQIjFtCibXYqMQOTCxPoNor14l8t8nOHtOjRqtN/IPH4JR
         9eyd820VtCrWZRZC8NMSNOoI8mkzlcEaKDvv1X6Q=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3B1JJxLI046494
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 1 Dec 2023 13:19:59 -0600
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 1
 Dec 2023 13:19:58 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 1 Dec 2023 13:19:58 -0600
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3B1JJwpU012447;
        Fri, 1 Dec 2023 13:19:58 -0600
Date:   Fri, 1 Dec 2023 13:19:58 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Francesco Dolcini <francesco@dolcini.it>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Tero Kristo <kristo@kernel.org>,
        Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2] arm64: defconfig: increase SERIAL_8250_NR_UARTS
Message-ID: <20231201191958.kmwkpmttmebsas47@kooky>
References: <20231201171544.1901-1-francesco@dolcini.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231201171544.1901-1-francesco@dolcini.it>
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

On 18:15-20231201, Francesco Dolcini wrote:
> Increase CONFIG_SERIAL_8250_NR_UARTS from 4 to 8, the current legacy value
> is not adequate for embedded systems that use SoCs where it's common to
> have a large number of serial ports.
> 
> No need to change CONFIG_SERIAL_8250_RUNTIME_UARTS, see commit 9d86719f8769
> ("serial: 8250: Allow using ports higher than SERIAL_8250_RUNTIME_UARTS").
> 
> The need to increase this value was noticed while working with Toradex
> Verdin AM62, this board has 4 serial UART instances available to the user
> plus an internal one that is connected to a Bluetooth module. Without this
> change the fifth UART connected to the BT module is not instantiated and BT
> is not working.
> 
> Instead of increasing the number to the bare minimum (5) that would be
> required to solve this specific issue, we increase this to 8 which seems a
> more reasonable number to have in the defconfig and should cover more valid
> use cases.

To address Arnd's concern on size increase, it will be good to add:
---
With this change kernel image increases by ~3.2k. bloat-o-meter summary:
add/remove: 1/1 grow/shrink: 7/0 up/down: 3220/-8 (3212)
---

Full bloat-o-meter report: aarch64-none-linux-gnu-gcc (11.3.1 20220712)
$ ./scripts/bloat-o-meter ./vmlinux.old vmlinux
add/remove: 1/1 grow/shrink: 7/0 up/down: 3220/-8 (3212)
Function                                     old     new   delta
serial8250_ports                            3136    6272   +3136
serial8250_register_8250_port               1176    1208     +32
serial8250_remove                            120     136     +16
serial8250_unregister_port                   288     296      +8
serial8250_suspend                           120     128      +8
serial8250_setup_port                        212     220      +8
e843419@0d28_000102dd_3a64                     -       8      +8
serial8250_init                              468     472      +4
e843419@0c0a_0000eb9e_8cc                      8       -      -8
Total: Before=28756614, After=28759826, chg +0.01%

> 
> Cc: Tony Lindgren <tony@atomide.com>
> Reviewed-by: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Francesco Dolcini <francesco@dolcini.it>
> ---
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index b60aa1f89343..ecd365cd1d87 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -448,6 +448,7 @@ CONFIG_SERIO_AMBAKMI=y
>  CONFIG_LEGACY_PTY_COUNT=16
>  CONFIG_SERIAL_8250=y
>  CONFIG_SERIAL_8250_CONSOLE=y
> +CONFIG_SERIAL_8250_NR_UARTS=8
>  CONFIG_SERIAL_8250_EXTENDED=y
>  CONFIG_SERIAL_8250_SHARE_IRQ=y
>  CONFIG_SERIAL_8250_BCM2835AUX=y
> -- 
> 2.39.2
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
