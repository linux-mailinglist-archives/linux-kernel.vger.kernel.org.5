Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 615807F47F6
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 14:41:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231596AbjKVNln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 08:41:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231345AbjKVNll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 08:41:41 -0500
X-Greylist: delayed 544 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 22 Nov 2023 05:41:34 PST
Received: from post.baikalelectronics.com (post.baikalelectronics.com [213.79.110.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 207AF1A5;
        Wed, 22 Nov 2023 05:41:34 -0800 (PST)
Received: from post.baikalelectronics.com (localhost.localdomain [127.0.0.1])
        by post.baikalelectronics.com (Proxmox) with ESMTP id ABDF8E0EB9;
        Wed, 22 Nov 2023 16:32:28 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        baikalelectronics.ru; h=cc:cc:content-type:content-type:date
        :from:from:in-reply-to:message-id:mime-version:references
        :reply-to:subject:subject:to:to; s=post; bh=HbHrbH/rcUkVvlTKh1z1
        S+UWZ0eNJU9qPvTnkmX9sAo=; b=ZaSD9yzmzX2d2SuTq2gLARr4fmQLcPAm4gKl
        AYfiEFaVpXuA5Wrk7l0Ktf0fiWuiQiGIHm0k/0nIkD8vyKM+bMaEa7YSt/5js9PM
        ynIzPSyXYnF6qF8AcgteuvPHs6zCjSkTsIeI1SjurBfVjtYYaz7pHQjBWifkGn9+
        QeIruH8=
Received: from mail.baikal.int (mail.baikal.int [192.168.51.25])
        by post.baikalelectronics.com (Proxmox) with ESMTP id 74B73E0EB4;
        Wed, 22 Nov 2023 16:32:28 +0300 (MSK)
Received: from mobilestation (10.8.30.118) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 22 Nov 2023 16:32:28 +0300
Date:   Wed, 22 Nov 2023 16:32:27 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
CC:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        <linux-mips@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
Subject: Re: [PATCH] MAINTAINERS: add section MIPS BAIKAL-T1 SOC DRIVERS
Message-ID: <mku6gvd4rfkxzk2vrdjbizglte526ygyfhnwialtri44oqzikt@pq2l7mk25jgc>
References: <20231122054142.31322-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="ec57xuvyqxygqblb"
Content-Disposition: inline
In-Reply-To: <20231122054142.31322-1-lukas.bulwahn@gmail.com>
X-Originating-IP: [10.8.30.118]
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--ec57xuvyqxygqblb
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

Hi Lukas

On Wed, Nov 22, 2023 at 06:41:42AM +0100, Lukas Bulwahn wrote:
> In recent years, a number of drivers for the MIPS Baikal-T1 SoC have been
> added to the kernel tree, but there is no dedicated MAINTAINERS section for
> this SoC.
> 
> As all of the code has been contributed by Serge Semin, let us assume he is
> still the active maintainer for this code rather than marking it orphan.
> 
> Add a new section MIPS BAIKAL-T1 SOC DRIVERS in MAINTAINERS.

Thanks for submitting this patch. I was going to send a similar change
in the framework of the arch-series which is hanging up in my local
repo and alas is still under construction. I know I shouldn't have
been waiting (I'm sorry about that), but I didn't expect the entire
work would have taken so much time. On a way to finishing it up I had
to switch my efforts to the EDAC and network drivers and got sucked by
the amount of work there. But I will definitely submit the Baikal-T1
SoC arch patchset when my work on another area is finally over.

Here are several comments about this patch. (Please see my last
comment should you be ok with accepting the patches with already fixed
notes.)

> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
>  MAINTAINERS | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9613c9c3cc97..820f1ab1ee80 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14474,6 +14474,19 @@ F:	arch/mips/
>  F:	drivers/platform/mips/
>  F:	include/dt-bindings/mips/
>  
> +MIPS BAIKAL-T1 SOC DRIVERS

> +M:	Serge Semin <Sergey.Semin@baikalelectronics.ru>

It's better to change the email to
+M:	Serge Semin <fancer.lancer@gmail.com>
I quicker respond from my private inbox, than from the corporate one.
This will also be useful should the corporate email eventually change.

> +S:	Maintained

+F:	Documentation/devicetree/bindings/bus/baikal,bt1-*.yaml
+F:	Documentation/devicetree/bindings/clock/baikal,bt1-*.yaml

> +F:	Documentation/hwmon/bt1-pvt.rst

I'd prefer this and these -+ being in a separate entry (see the
attached patches), because | the respective device IP-cores have been
re-used in another SoC. So | eventually the entries will be updated to
reflect that.              +---------------------------------+
                                                             |
> +F:	drivers/ata/ahci_dwc.c                               |
                                                             |
I believe this is already listed in the MAINTAINERS file.    |
                                                             |
> +F:	drivers/bus/bt1-*.c                                  |
> +F:	drivers/clk/baikal-t1/                               |
> +F:	drivers/hwmon/bt1-pvt.[ch] <-------------------------+
> +F:	drivers/memory/bt1-l2-ctl.c                          |
> +F:	drivers/mtd/maps/physmap-bt1-rom.[ch]                |
> +F:	drivers/pci/controller/dwc/pcie-bt1.c <--------------+

> +F:	drivers/spi/spi-dw-bt1.c

This is already marked as maintained by me in the framework of the
generic DW APB SSI driver (See the "SYNOPSYS DESIGNWARE APB SSI
DRIVER" entry in the MAINTAINERS file).

Anyway in order to save your time from editing this patch. I've
prepared a series which takes into account all the comments above. If
you are ok with it, I can submit it for review. What do you think?

-Serge(y)

> +
>  MIPS BOSTON DEVELOPMENT BOARD
>  M:	Paul Burton <paulburton@kernel.org>
>  L:	linux-mips@vger.kernel.org
> -- 
> 2.17.1
> 
> 

--ec57xuvyqxygqblb
Content-Type: text/x-patch; charset="us-ascii"
Content-Disposition: attachment;
	filename="0001-MAINTAINERS-Add-maintainer-for-Baikal-T1-PVT-hwmon-d.patch"

From 3474717c649d994afade36f8117695a84120ab26 Mon Sep 17 00:00:00 2001
From: Serge Semin <fancer.lancer@gmail.com>
Date: Fri, 7 Feb 2020 12:37:59 +0300
Subject: [PATCH 1/3] MAINTAINERS: Add maintainer for Baikal-T1 PVT hwmon
 driver

Add myself as a maintainer of the Baikal-T1 PVT sensors driver.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 97f51d5ec1cf..9e50a77d746e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3467,6 +3467,14 @@ F:	drivers/video/backlight/
 F:	include/linux/backlight.h
 F:	include/linux/pwm_backlight.h
 
+BAIKAL-T1 PVT HARDWARE MONITOR DRIVER
+M:	Serge Semin <fancer.lancer@gmail.com>
+L:	linux-hwmon@vger.kernel.org
+S:	Supported
+F:	Documentation/devicetree/bindings/hwmon/baikal,bt1-pvt.yaml
+F:	Documentation/hwmon/bt1-pvt.rst
+F:	drivers/hwmon/bt1-pvt.[ch]
+
 BARCO P50 GPIO DRIVER
 M:	Santosh Kumar Yadav <santoshkumar.yadav@barco.com>
 M:	Peter Korsgaard <peter.korsgaard@barco.com>
-- 
2.42.1


--ec57xuvyqxygqblb
Content-Type: text/x-patch; charset="us-ascii"
Content-Disposition: attachment;
	filename="0002-MAINTAINERS-Add-maintainer-for-Baikal-T1-PCIe-driver.patch"

From 460caf4c02f3b9620cf63127a443e05361ff382a Mon Sep 17 00:00:00 2001
From: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Date: Tue, 22 Mar 2022 23:11:59 +0300
Subject: [PATCH 2/3] MAINTAINERS: Add maintainer for Baikal-T1 PCIe driver

Add myself as a maintainer of the Baikal-T1 PCIe Root Port driver.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9e50a77d746e..52ee905c50f4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16796,6 +16796,13 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/pci/axis,artpec*
 F:	drivers/pci/controller/dwc/*artpec*
 
+PCIE DRIVER FOR BAIKAL-T1
+M:	Serge Semin <fancer.lancer@gmail.com>
+L:	linux-pci@vger.kernel.org
+S:	Supported
+F:	Documentation/devicetree/bindings/pci/baikal,bt1-pcie.yaml
+F:	drivers/pci/controller/dwc/pcie-bt1.c
+
 PCIE DRIVER FOR CAVIUM THUNDERX
 M:	Robert Richter <rric@kernel.org>
 L:	linux-pci@vger.kernel.org
-- 
2.42.1


--ec57xuvyqxygqblb
Content-Type: text/x-patch; charset="us-ascii"
Content-Disposition: attachment;
	filename="0003-MAINTAINERS-Add-maintainer-for-MIPS-Baikal-T1-platfo.patch"

From 16297c21f443fac69bf1d60924a9ef8602de8a2e Mon Sep 17 00:00:00 2001
From: Serge Semin <fancer.lancer@gmail.com>
Date: Fri, 7 Feb 2020 12:43:00 +0300
Subject: [PATCH 3/3] MAINTAINERS: Add maintainer for MIPS Baikal-T1 platform
 code

Add myself as a maintainer of the MIPS Baikal-T1 platform-specific
drivers. The arch-code hasn't been submitted yet, but will be soon enough.
Until then it's better to have the already available drivers marked as
maintained.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
---
 MAINTAINERS | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 52ee905c50f4..a56e241608ae 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14491,6 +14491,17 @@ F:	arch/mips/
 F:	drivers/platform/mips/
 F:	include/dt-bindings/mips/
 
+MIPS BAIKAL-T1 PLATFORM
+M:	Serge Semin <fancer.lancer@gmail.com>
+L:	linux-mips@vger.kernel.org
+S:	Supported
+F:	Documentation/devicetree/bindings/bus/baikal,bt1-*.yaml
+F:	Documentation/devicetree/bindings/clock/baikal,bt1-*.yaml
+F:	drivers/bus/bt1-*.c
+F:	drivers/clk/baikal-t1/
+F:	drivers/memory/bt1-l2-ctl.c
+F:	drivers/mtd/maps/physmap-bt1-rom.[ch]
+
 MIPS BOSTON DEVELOPMENT BOARD
 M:	Paul Burton <paulburton@kernel.org>
 L:	linux-mips@vger.kernel.org
-- 
2.42.1


--ec57xuvyqxygqblb--

