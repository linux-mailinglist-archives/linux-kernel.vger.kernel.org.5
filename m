Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 714C47D040C
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 23:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346591AbjJSV3H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 17:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346602AbjJSV3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 17:29:06 -0400
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 19 Oct 2023 14:29:04 PDT
Received: from fgw22-7.mail.saunalahti.fi (fgw22-7.mail.saunalahti.fi [62.142.5.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D2A393
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 14:29:04 -0700 (PDT)
Received: from localhost (88-113-24-34.elisa-laajakaista.fi [88.113.24.34])
        by fgw22.mail.saunalahti.fi (Halon) with ESMTP
        id 5fac9ca2-6ec6-11ee-a9de-005056bdf889;
        Fri, 20 Oct 2023 00:27:58 +0300 (EEST)
From:   andy.shevchenko@gmail.com
Date:   Fri, 20 Oct 2023 00:27:58 +0300
To:     AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc:     sudeep.holla@arm.com, cristian.marussi@arm.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linus.walleij@linaro.org, Oleksii_Moisieiev@epam.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [RFC v2 0/5] gpio: add pinctrl based generic gpio driver
Message-ID: <ZTGfXsLc_Z6yj_HB@surfacebook.localdomain>
References: <20231005025843.508689-1-takahiro.akashi@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231005025843.508689-1-takahiro.akashi@linaro.org>
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thu, Oct 05, 2023 at 11:58:38AM +0900, AKASHI Takahiro kirjoitti:
> This is a revised version of my previous RFC[1]. Although I modified
> the commits to make them look SCMI-independent, they are still posted
> as RFC because I have never tested them on real hardware.
> 
> (background)
> I'm currently working on implementing SCMI pinctrl/gpio drivers
> on U-Boot[2]. Although the pinctrl driver for the kernel[3] was submitted
> by EPAM, it doesn't contain the gpio driver and I believe that we should
> discuss a couple of points on the kernel side to finalize my design for
> U-Boot. 
> 
> So this RFC is intended for reviews, especially to raise some issues.
> 
> 1) how to obtain a value on an input pin
>    All the existing gpio drivers are set to obtain a value on an input
>    pin by accessing the hardware directly. In SCMI case, however, this is
>    just impossible in its nature and must be supported via a protocol
>    using "Input-value" configuration type. (See the spec[4], table-23.)
> 
>    The current pinconf framework is missing the feature (the pinconf
>    parameter and a helper function). See patch#1, #2 and #3.
> 
>    Please note that there is an issue around the pin configuration in
>    EPAM's current pinctrl driver as I commented[5].
> 
> 2) DT bindings
>    I would like to propose a generic binding for pinctrl based gpio driver.
>    This allows a "consumer" driver to handle gpio pins like as other
>    normal gpio controllers support. (patch#5)
> 
> 3) generic GPIO driver
>    Based on (2), I tried to prototype a generic driver in patch#4.
>    Thanks to a set of existing pinctrl_gpio helper functions, except (1),
>    It seems that the driver can be implemented not relying on pin controller
>    specific code, at least for SCMI pinctrl.
> 
> I will appreciate any comments.

Any comment here: I'm listed as a designated reviewer of GPIO patches, why am I
not Cc'ed on this? I definitely have some comments against the code (no DT,
though). Please, use (up-to-date) MAINTAINERS in your v3.

-- 
With Best Regards,
Andy Shevchenko


