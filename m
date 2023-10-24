Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EF0A7D49F0
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 10:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233705AbjJXI0O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 04:26:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233122AbjJXI0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 04:26:12 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2B8799;
        Tue, 24 Oct 2023 01:26:10 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9CAAC433C7;
        Tue, 24 Oct 2023 08:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698135970;
        bh=gm0drRnvD+4lU1NBJfDjluSiLt5PHG26cjTrB3u6d+k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PdnGvoWu8TSJChVrRJLSe0c1bdp1X2/VlSV5Hh1ythDQQSBeHPn/XmnRJsIKlK0kw
         w8ueo5aXHvPEbPEyKtg8w9ZbEMkopnPkCi4rP4r4UMqwCTz3sdE9q/MljQSb2gLwkQ
         l8SVwgDGrC3jfYWmTbL6fbJEzDv6BQzBwYy9l+g0=
Date:   Tue, 24 Oct 2023 10:26:07 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 5.4 000/123] 5.4.259-rc1 review
Message-ID: <2023102452-tainted-mandolin-8c33@gregkh>
References: <20231023104817.691299567@linuxfoundation.org>
 <5bd191c3-a58a-e6b4-12a6-64efb9b03f2e@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5bd191c3-a58a-e6b4-12a6-64efb9b03f2e@roeck-us.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23, 2023 at 07:36:25AM -0700, Guenter Roeck wrote:
> On 10/23/23 03:55, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 5.4.259 release.
> > There are 123 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Wed, 25 Oct 2023 10:47:57 +0000.
> > Anything received after that time might be too late.
> > 
> 
> drivers/gpio/gpio-vf610.c:249:18: error: 'IRQCHIP_IMMUTABLE' undeclared here (not in a function); did you mean 'IS_IMMUTABLE'?
>   249 |         .flags = IRQCHIP_IMMUTABLE | IRQCHIP_MASK_ON_SUSPEND
>       |                  ^~~~~~~~~~~~~~~~~
>       |                  IS_IMMUTABLE
> drivers/gpio/gpio-vf610.c:250:27: error: 'IRQCHIP_ENABLE_WAKEUP_ON_SUSPEND' undeclared here (not in a function); did you mean 'IRQCHIP_MASK_ON_SUSPEND'?
>   250 |                         | IRQCHIP_ENABLE_WAKEUP_ON_SUSPEND,
>       |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>       |                           IRQCHIP_MASK_ON_SUSPEND
> drivers/gpio/gpio-vf610.c:251:9: error: 'GPIOCHIP_IRQ_RESOURCE_HELPERS' undeclared here (not in a function)
>   251 |         GPIOCHIP_IRQ_RESOURCE_HELPERS,
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/gpio/gpio-vf610.c:251:9: warning: excess elements in struct initializer
> drivers/gpio/gpio-vf610.c:251:9: note: (near initialization for 'vf610_irqchip')
> drivers/gpio/gpio-vf610.c: In function 'vf610_gpio_probe':
> drivers/gpio/gpio-vf610.c:340:9: error: implicit declaration of function 'gpio_irq_chip_set_chip'
> 
> Also affects v5.10.y and v5.15.y.

Thanks, I'll go drop the offending patches from all of these trees now
and push out some -rc2 releases.

greg k-h
