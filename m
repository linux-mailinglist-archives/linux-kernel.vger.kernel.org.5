Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D247A75BFED
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 09:39:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbjGUHi7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 03:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbjGUHip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 03:38:45 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9B5052733
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 00:38:38 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id E3DAB807E;
        Fri, 21 Jul 2023 07:38:37 +0000 (UTC)
Date:   Fri, 21 Jul 2023 10:38:36 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Julien Panis <jpanis@baylibre.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        vigneshr@ti.com, afd@ti.com
Subject: Re: [PATCH v2] ARM: multi_v7_defconfig: Enable OMAP watchdog support
Message-ID: <20230721073836.GS5194@atomide.com>
References: <20230718-enable-omap-wd-v2-1-921f829bc0a5@baylibre.com>
 <4db1d958-7b11-40d9-3f68-3e9390539cbe@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4db1d958-7b11-40d9-3f68-3e9390539cbe@baylibre.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Julien Panis <jpanis@baylibre.com> [230719 10:09]:
> On 7/18/23 16:58, Julien Panis wrote:
> > Increase build and test coverage by enabling support for OMAP watchdog,
> > as used on TI OMAP based boards.
> > 
> > The watchdog timer is an upward counter capable of generating a pulse on
> > the reset pin and an interrupt to the device system modules following an
> > overflow condition.
> > 
> > Signed-off-by: Julien Panis <jpanis@baylibre.com>

Looks good to me:

Reviewed-by: Tony Lindgren <tony@atomide.com>

> Maybe this patch should not be applied actually. I have 2 questions:
> 
> [Q1] Using the following cmd sequence leads to a modified 'multi_v7_defconfig' file:
>       'make multi_v7_defconfig'
>       'make savedefconfig'
>       'mv defconfig arch/arm/configs/multi_v7_defconfig'
> ...even without modifying CONFIG_OMAP_WATCHDOG flag.
> I guess it's due to modifications in various Kconfig files (dependencies for instance).
> And perhaps it's also due to previous modifications of 'multi_v7_defconfig' file that
> were not done by using 'make savedefconfig' (?)
> How should I handle that for this patch ? This v2 has been created by modifying
> 'multi_v7_defconfig' file manually. Using 'make savedefconfig' would be cleaner,
> but as a result many flags would be re-organized whereas the commit intends to
> enable 1 flag only.

After make savedefconfig you can take a look where the new option got placed
and then throw away the changes and add the entry manually :)

> [Q2] I would like to add another flag in order to enable CONFIG_RTC_DRV_OMAP.
> Is it better grouping CONFIG_OMAP_WATCHDOG and CONFIG_RTC_DRV_OMAP in
> a single commit ? What's recommended ?

Adding both is fine for the defconfig change, just try to place them where
they would end up after savedefconfig to avoid it getting more out of sync.

Regards,

Tony
