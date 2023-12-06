Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49E35807C00
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 00:00:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379400AbjLFXAG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 18:00:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377430AbjLFXAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 18:00:04 -0500
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8874218D;
        Wed,  6 Dec 2023 15:00:09 -0800 (PST)
Received: from [192.168.1.114] (unknown [185.145.125.130])
        by mail.ispras.ru (Postfix) with ESMTPSA id 0E78540F1DDC;
        Wed,  6 Dec 2023 23:00:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 0E78540F1DDC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1701903607;
        bh=gUdGQ25NEZtDnT8qJMC/puEY2uW/SpYlK1LVVHGS4a4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=QuTg6aubCVRROB8lnn112HUtFi9VQ56WIHGmGpE7A7MDloZqtJRiweOAXn4x38efN
         OXCNhU/OfkSO7RdwIv8g00nTpnGz6h+FIXA69wB5tEf0roYSE5LJnolbeEX/Q+Ohog
         U99fayMnuZHMOqZwuWeLaD6KS9UE3ITtqMqpPgoI=
Subject: Re: [PATCH 5.10 000/131] 5.10.203-rc3 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        allen.lkml@gmail.com,
        "lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>
References: <20231205183249.651714114@linuxfoundation.org>
From:   Alexey Khoroshilov <khoroshilov@ispras.ru>
Message-ID: <efdb0591-2259-f86c-0da4-781dfdae22e1@ispras.ru>
Date:   Thu, 7 Dec 2023 02:00:06 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20231205183249.651714114@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.12.2023 22:22, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.203 release.
> There are 131 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 07 Dec 2023 18:32:16 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.203-rc3.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h


It seems something is seriously broken in this release.

There are patches already applied in 5.10.202 that are in 5.10.203-rc3
transformed in some strange way, e.g.

Neil Armstrong <narmstrong@baylibre.com>
    tty: serial: meson: retrieve port FIFO size from DT


commit 980c3135f1ae6fe686a70c8ba78eb1bb4bde3060 in 5.10.202

diff --git a/drivers/tty/serial/meson_uart.c
b/drivers/tty/serial/meson_uart.c
index d06653493f0e..78bda91a6bf1 100644
--- a/drivers/tty/serial/meson_uart.c
+++ b/drivers/tty/serial/meson_uart.c
@@ -728,6 +728,7 @@ static int meson_uart_probe(struct platform_device
*pdev)
 {
        struct resource *res_mem, *res_irq;
        struct uart_port *port;
+       u32 fifosize = 64; /* Default is 64, 128 for EE UART_0 */
        int ret = 0;

        if (pdev->dev.of_node)
@@ -755,6 +756,8 @@ static int meson_uart_probe(struct platform_device
*pdev)
        if (!res_irq)
                return -ENODEV;

+       of_property_read_u32(pdev->dev.of_node, "fifo-size", &fifosize);
+
        if (meson_ports[pdev->id]) {
                dev_err(&pdev->dev, "port %d already allocated\n",
pdev->id);
                return -EBUSY;
@@ -784,7 +787,7 @@ static int meson_uart_probe(struct platform_device
*pdev)
        port->type = PORT_MESON;
        port->x_char = 0;
        port->ops = &meson_uart_ops;
-       port->fifosize = 64;
+       port->fifosize = fifosize;

        meson_ports[pdev->id] = port;
        platform_set_drvdata(pdev, port);

vs.

commit 71feab929585232694b4f2fb7d70abde4edc581e in 5.10.203-rc3

diff --git a/drivers/tty/serial/meson_uart.c
b/drivers/tty/serial/meson_uart.c
index bb66a3f06626..c44ab21a9b7d 100644
--- a/drivers/tty/serial/meson_uart.c
+++ b/drivers/tty/serial/meson_uart.c
@@ -765,6 +765,8 @@ static int meson_uart_probe(struct platform_device
*pdev)
        of_property_read_u32(pdev->dev.of_node, "fifo-size", &fifosize);
        has_rtscts = of_property_read_bool(pdev->dev.of_node,
"uart-has-rtscts");

+       of_property_read_u32(pdev->dev.of_node, "fifo-size", &fifosize);
+
        if (meson_ports[pdev->id]) {
                dev_err(&pdev->dev, "port %d already allocated\n",
pdev->id);
                return -EBUSY;



Found by Linux Verification Center (linuxtesting.org) with SVACE



See also:

Qu Huang <qu.huang@linux.dev>
    drm/amdgpu: Fix a null pointer access when the smc_rreg pointer is NULL

Axel Lin <axel.lin@ingics.com>
    i2c: sun6i-p2wi: Prevent potential division by zero

Takashi Iwai <tiwai@suse.de>
    media: imon: fix access to invalid resource for the second interface


Also there is a strange pair:

Patrick Thompson <ptf@google.com>
    net: r8169: Disable multicast filter for RTL8168H and RTL8107E

Heiner Kallweit <hkallweit1@gmail.com>
    Revert "net: r8169: Disable multicast filter for RTL8168H and RTL8107E"


--
Alexey Khoroshilov
Linux Verification Center, ISPRAS
