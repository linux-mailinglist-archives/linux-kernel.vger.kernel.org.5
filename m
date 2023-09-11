Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 598D879BF80
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:19:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347224AbjIKVYe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:24:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237438AbjIKMuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 08:50:52 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 40BA5CEB;
        Mon, 11 Sep 2023 05:50:48 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 6F29580A2;
        Mon, 11 Sep 2023 12:50:47 +0000 (UTC)
Date:   Mon, 11 Sep 2023 15:50:46 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Russell King <linux@armlinux.org.uk>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dipen Patel <dipenp@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-acpi@vger.kernel.org, timestamp@lists.linux.dev,
        linux-tegra@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [RFT PATCH 15/21] arm: omap1: ams-delta: stop using
 gpiochip_find()
Message-ID: <20230911125046.GA5285@atomide.com>
References: <20230905185309.131295-1-brgl@bgdev.pl>
 <20230905185309.131295-16-brgl@bgdev.pl>
 <CACRpkdaVUPNYVjAi2XsNKVhwmtk2qpVp62Lke4xeDOwhhBXLtg@mail.gmail.com>
 <6555932.G0QQBjFxQf@dell>
 <CAMRc=Mfrk9q6fJyEAuxDXYPpbjVHeLJaTjHEcKiYHzrE3r+_7A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=Mfrk9q6fJyEAuxDXYPpbjVHeLJaTjHEcKiYHzrE3r+_7A@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Bartosz Golaszewski <brgl@bgdev.pl> [230911 11:10]:
> On Fri, Sep 8, 2023 at 8:07 PM Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote:
> >
> > Dnia czwartek, 7 września 2023 09:31:01 CEST Linus Walleij pisze:
> > > On Tue, Sep 5, 2023 at 8:53 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> > >
> > > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > > >
> > > > gpiochip_find() is going away as it's not hot-unplug safe. This platform
> > > > is not affected by any of the related problems as this GPIO controller
> > > > cannot really go away but in order to finally remove this function, we
> > > > need to convert it to using gpio_device_find() as well.
> > > >
> > > > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > >
> > > I was cleaning this one just some merge cycle ago, now it
> > > looks even better!
> > > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> >
> > Acked-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
> >
> 
> Janusz,
> 
> Is it fine if I take it through the GPIO tree?

Works for me at least:

Acked-by: Tony Lindgren <tony@atomide.com>
