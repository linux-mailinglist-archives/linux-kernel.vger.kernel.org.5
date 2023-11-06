Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21F277E1EC0
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 11:45:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231293AbjKFKpZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 05:45:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjKFKpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 05:45:24 -0500
Received: from mx.gpxsee.org (mx.gpxsee.org [37.205.14.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1CDEBA1;
        Mon,  6 Nov 2023 02:45:20 -0800 (PST)
Received: from [192.168.4.14] (unknown [62.77.71.229])
        by mx.gpxsee.org (Postfix) with ESMTPSA id C540D5D2CC;
        Mon,  6 Nov 2023 11:45:17 +0100 (CET)
Message-ID: <51ae3a0b-9c89-4b85-b44c-ea42d7eb7a20@gpxsee.org>
Date:   Mon, 6 Nov 2023 11:45:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] media: pci: mgb4: add COMMON_CLK dependency
Content-Language: en-US
To:     Arnd Bergmann <arnd@kernel.org>,
        Martin Tuma <martin.tuma@digiteqautomotive.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231023160539.1537355-1-arnd@kernel.org>
From:   =?UTF-8?Q?Martin_T=C5=AFma?= <tumic@gpxsee.org>
In-Reply-To: <20231023160539.1537355-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23. 10. 23 18:05, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> This driver fails to build when HAVE_CLK and COMMON_CLK are disabled:
> 
> x86_64-linux-ld: vmlinux.o: in function `mgb4_remove':
> mgb4_core.c:(.text+0x1915e8c): undefined reference to `clkdev_drop'
> x86_64-linux-ld: mgb4_core.c:(.text+0x1915e98): undefined reference to `clk_hw_unregister'
> 
> Add a Kconfig dependency to enforce a clean build.
> 
> Fixes: 0ab13674a9bd ("media: pci: mgb4: Added Digiteq Automotive MGB4 driver")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   drivers/media/pci/mgb4/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/media/pci/mgb4/Kconfig b/drivers/media/pci/mgb4/Kconfig
> index 13fad15a434c..f2a05a1c8ffa 100644
> --- a/drivers/media/pci/mgb4/Kconfig
> +++ b/drivers/media/pci/mgb4/Kconfig
> @@ -2,6 +2,7 @@
>   config VIDEO_MGB4
>   	tristate "Digiteq Automotive MGB4 support"
>   	depends on VIDEO_DEV && PCI && I2C && DMADEVICES && SPI && MTD && IIO
> +	depends on COMMON_CLK
>   	select VIDEOBUF2_DMA_SG
>   	select IIO_BUFFER
>   	select IIO_TRIGGERED_BUFFER

Reviewed-by: Martin Tůma <martin.tuma@digiteqautomotive.com>

