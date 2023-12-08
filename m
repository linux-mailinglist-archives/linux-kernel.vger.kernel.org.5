Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CD39809C97
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 07:50:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232875AbjLHGr2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 01:47:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjLHGrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 01:47:25 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3F2F1723
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 22:47:31 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 241D6C433C8;
        Fri,  8 Dec 2023 06:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1702018051;
        bh=aVwOp1aJPsPh7+HlQ/vujBgUZmjHqe7FfCfwGE1YeZ0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=grMw9MAilAqZVJpURavXBJKJpCfqFYqXS/93nfol1/6O4gqg8/TbHPtjeINDoQ3XL
         5o0UXU39UnthFKO8a/M6TZ5cd9D5f/5lIVWYHc3xDCUI9NjoTSRfNEWfr6eNmHJFAM
         G40GKVqdEDQ2ZeQYF3wiWqFQCn6t9VlU2zUH/HPM=
Date:   Fri, 8 Dec 2023 07:47:29 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Alexey Khoroshilov <khoroshilov@ispras.ru>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org, allen.lkml@gmail.com,
        "lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>
Subject: Re: [PATCH 5.10 000/131] 5.10.203-rc3 review
Message-ID: <2023120849-catalog-pretzel-ee8f@gregkh>
References: <20231205183249.651714114@linuxfoundation.org>
 <efdb0591-2259-f86c-0da4-781dfdae22e1@ispras.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <efdb0591-2259-f86c-0da4-781dfdae22e1@ispras.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 07, 2023 at 02:00:06AM +0300, Alexey Khoroshilov wrote:
> On 05.12.2023 22:22, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 5.10.203 release.
> > There are 131 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Thu, 07 Dec 2023 18:32:16 +0000.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.203-rc3.gz
> > or in the git tree and branch at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> > and the diffstat can be found below.
> > 
> > thanks,
> > 
> > greg k-h
> 
> 
> It seems something is seriously broken in this release.
> 
> There are patches already applied in 5.10.202 that are in 5.10.203-rc3
> transformed in some strange way, e.g.
> 
> Neil Armstrong <narmstrong@baylibre.com>
>     tty: serial: meson: retrieve port FIFO size from DT
> 
> 
> commit 980c3135f1ae6fe686a70c8ba78eb1bb4bde3060 in 5.10.202
> 
> diff --git a/drivers/tty/serial/meson_uart.c
> b/drivers/tty/serial/meson_uart.c
> index d06653493f0e..78bda91a6bf1 100644
> --- a/drivers/tty/serial/meson_uart.c
> +++ b/drivers/tty/serial/meson_uart.c
> @@ -728,6 +728,7 @@ static int meson_uart_probe(struct platform_device
> *pdev)
>  {
>         struct resource *res_mem, *res_irq;
>         struct uart_port *port;
> +       u32 fifosize = 64; /* Default is 64, 128 for EE UART_0 */
>         int ret = 0;
> 
>         if (pdev->dev.of_node)
> @@ -755,6 +756,8 @@ static int meson_uart_probe(struct platform_device
> *pdev)
>         if (!res_irq)
>                 return -ENODEV;
> 
> +       of_property_read_u32(pdev->dev.of_node, "fifo-size", &fifosize);
> +
>         if (meson_ports[pdev->id]) {
>                 dev_err(&pdev->dev, "port %d already allocated\n",
> pdev->id);
>                 return -EBUSY;
> @@ -784,7 +787,7 @@ static int meson_uart_probe(struct platform_device
> *pdev)
>         port->type = PORT_MESON;
>         port->x_char = 0;
>         port->ops = &meson_uart_ops;
> -       port->fifosize = 64;
> +       port->fifosize = fifosize;
> 
>         meson_ports[pdev->id] = port;
>         platform_set_drvdata(pdev, port);
> 
> vs.
> 
> commit 71feab929585232694b4f2fb7d70abde4edc581e in 5.10.203-rc3
> 
> diff --git a/drivers/tty/serial/meson_uart.c
> b/drivers/tty/serial/meson_uart.c
> index bb66a3f06626..c44ab21a9b7d 100644
> --- a/drivers/tty/serial/meson_uart.c
> +++ b/drivers/tty/serial/meson_uart.c
> @@ -765,6 +765,8 @@ static int meson_uart_probe(struct platform_device
> *pdev)
>         of_property_read_u32(pdev->dev.of_node, "fifo-size", &fifosize);
>         has_rtscts = of_property_read_bool(pdev->dev.of_node,
> "uart-has-rtscts");
> 
> +       of_property_read_u32(pdev->dev.of_node, "fifo-size", &fifosize);
> +
>         if (meson_ports[pdev->id]) {
>                 dev_err(&pdev->dev, "port %d already allocated\n",
> pdev->id);
>                 return -EBUSY;
> 
> 
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE
> 
> 
> 
> See also:
> 
> Qu Huang <qu.huang@linux.dev>
>     drm/amdgpu: Fix a null pointer access when the smc_rreg pointer is NULL
> 
> Axel Lin <axel.lin@ingics.com>
>     i2c: sun6i-p2wi: Prevent potential division by zero
> 
> Takashi Iwai <tiwai@suse.de>
>     media: imon: fix access to invalid resource for the second interface
> 
> 
> Also there is a strange pair:
> 
> Patrick Thompson <ptf@google.com>
>     net: r8169: Disable multicast filter for RTL8168H and RTL8107E
> 
> Heiner Kallweit <hkallweit1@gmail.com>
>     Revert "net: r8169: Disable multicast filter for RTL8168H and RTL8107E"
> 

Ok, I dropped all of these and manually verified that there were no
other duplicates.  thanks for catching them and letting us know.


greg k-h
