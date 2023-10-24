Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D96F7D4A09
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 10:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233804AbjJXI2r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 04:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233122AbjJXI2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 04:28:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32D14120;
        Tue, 24 Oct 2023 01:28:43 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46726C433C8;
        Tue, 24 Oct 2023 08:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698136122;
        bh=o/bhBD7x66xOviqK2rso+3X+laO9UIhD9yITFlGEQZ0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nIod6esvAdneOu4+xyrt1MZ8kt/YfXrZcb00FWPQ4UAUDQ4aXSkb+zkB+QHBrjFIh
         +csukHiO0UhZH/Pak7TAEXqyrR/NcvasDfAiWmdsFXokhaqo5XZqtSaZGObneIQa7I
         HXp+lIZ213h71x662bq9BV0yBT5sgU+kpJONg+yc=
Date:   Tue, 24 Oct 2023 10:28:40 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Daniel =?iso-8859-1?Q?D=EDaz?= <daniel.diaz@linaro.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 5.4 000/123] 5.4.259-rc1 review
Message-ID: <2023102434-dreamless-parting-35ed@gregkh>
References: <20231023104817.691299567@linuxfoundation.org>
 <eb759f41-db11-4f2e-b3a0-e9e92dea3196@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <eb759f41-db11-4f2e-b3a0-e9e92dea3196@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23, 2023 at 09:53:08AM -0600, Daniel Díaz wrote:
> Same problems on Arm 32-bits as with 5.10 and 5.15:
> 
> -----8<-----
> /builds/linux/drivers/gpio/gpio-vf610.c:249:11: error: use of undeclared identifier 'IRQCHIP_IMMUTABLE'
>   249 |         .flags = IRQCHIP_IMMUTABLE | IRQCHIP_MASK_ON_SUSPEND
>       |                  ^
> /builds/linux/drivers/gpio/gpio-vf610.c:250:6: error: use of undeclared identifier 'IRQCHIP_ENABLE_WAKEUP_ON_SUSPEND'
>   250 |                         | IRQCHIP_ENABLE_WAKEUP_ON_SUSPEND,
>       |                           ^
> /builds/linux/drivers/gpio/gpio-vf610.c:251:2: error: use of undeclared identifier 'GPIOCHIP_IRQ_RESOURCE_HELPERS'
>   251 |         GPIOCHIP_IRQ_RESOURCE_HELPERS,
>       |         ^
> /builds/linux/drivers/gpio/gpio-vf610.c:340:2: error: implicit declaration of function 'gpio_irq_chip_set_chip' [-Werror,-Wimplicit-function-declaration]
>   340 |         gpio_irq_chip_set_chip(girq, &vf610_irqchip);
>       |         ^
> 4 errors generated.
> make[3]: *** [/builds/linux/scripts/Makefile.build:262: drivers/gpio/gpio-vf610.o] Error 1
> make[3]: Target '__build' not remade because of errors.
> make[2]: *** [/builds/linux/scripts/Makefile.build:497: drivers/gpio] Error 2

Now fixed up, thanks.


> /builds/linux/drivers/gpu/drm/drm_lock.c:363:6: warning: misleading indentation; statement is not part of the previous 'if' [-Wmisleading-indentation]
>   363 |          */     mutex_lock(&dev->struct_mutex);
>       |                 ^
> /builds/linux/drivers/gpu/drm/drm_lock.c:357:2: note: previous statement is here
>   357 |         if (!drm_core_check_feature(dev, DRIVER_LEGACY))
>       |         ^
> 1 warning generated.
> ----->8-----

This can't be a new warning as no patches in this -rc touch this file,
right?

thanks,

greg k-h
