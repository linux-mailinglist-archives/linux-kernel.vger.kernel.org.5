Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 926928034FD
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 14:32:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233924AbjLDNcc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 08:32:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233683AbjLDNcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 08:32:31 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A76DB2;
        Mon,  4 Dec 2023 05:32:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701696758; x=1733232758;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Dkr4auhuaXm/2CFkaCr6ysuuxc8iZhZ8/KeupfzqlRg=;
  b=laBeXsEBWrrgfDWBwIBfDhhrlg+aCO5FYS76PfYZuT4mZBvVewWCm4Z4
   7nPsV3Zz3WlYa+VmKRi/qlh7x4ELsjvce8vw4F5sybk/ALUMfIKLQIieC
   l/eKbL/G7bMHqtitgNJ9qtMcXSObPh/a/0lrWXHzL+TbrkcWw4PYhmQhR
   wCFLZDYRoF5ORb7cvpNZiqvbNnx4xszvY5KXxjCnwTfcxkgzIiBe775zo
   I6WpUv6lgVRgXK0ctKfcxIwS6+F+FFGgzLv4BCJvWFPeQ8Wf9DtBKLFcC
   XZ+xDqxJEY1eDSKQFp8Pru+yzObEY09ouY/2RQwMWO8O2jC0aMzf0+4kC
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10913"; a="7059246"
X-IronPort-AV: E=Sophos;i="6.04,249,1695711600"; 
   d="scan'208";a="7059246"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 05:32:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10913"; a="720323840"
X-IronPort-AV: E=Sophos;i="6.04,249,1695711600"; 
   d="scan'208";a="720323840"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 05:32:27 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1rA93f-00000001lCW-1RPq;
        Mon, 04 Dec 2023 15:32:23 +0200
Date:   Mon, 4 Dec 2023 15:32:23 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
        Jianlong Huang <jianlong.huang@starfivetech.com>,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        openbmc@lists.ozlabs.org, linux-mips@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>, Jacky Bai <ping.bai@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sean Wang <sean.wang@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Hal Feng <hal.feng@starfivetech.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v4 12/23] pinctrl: mediatek: Make use of
 PINCTRL_GROUP_DESC()
Message-ID: <ZW3U5-LBqWiyxB6-@smile.fi.intel.com>
References: <20231129161459.1002323-1-andriy.shevchenko@linux.intel.com>
 <20231129161459.1002323-13-andriy.shevchenko@linux.intel.com>
 <CGME20231204114039eucas1p29c6f8a162191e58ff658d3a1c44429bf@eucas1p2.samsung.com>
 <9e4e65de-7234-4234-8091-796277a1f1c5@samsung.com>
 <ZW3PrSQWyZvvhN66@smile.fi.intel.com>
 <CAMuHMdU-E7jemjAS0EunWFPq1LfF9vcNE+50ah4WH9oD1TXYew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdU-E7jemjAS0EunWFPq1LfF9vcNE+50ah4WH9oD1TXYew@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 04, 2023 at 02:19:10PM +0100, Geert Uytterhoeven wrote:
> Hi Andy,
> 
> On Mon, Dec 4, 2023 at 2:10 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Mon, Dec 04, 2023 at 12:40:38PM +0100, Marek Szyprowski wrote:
> > > On 29.11.2023 17:06, Andy Shevchenko wrote:
> > > > Make use of PINCTRL_GROUP_DESC() instead of open coding it.
> >
> > > PINCTRL_GROUP_DESC() macro from drivers/pinctrl/core.h contains a cast
> > > to (struct group_desc), what breaks users of the above macros.
> >
> > There is no cast (*).
> > Thanks for report, I will check.
> >
> > But this was v4 of the series and LKP actually sent a positive feedback.
> > Besides that I have tested this locally with modules enabled.
> >
> > *) It's a compound literal, _not_ a cast.
> >    Taking above into consideration I'm wondering what compilers
> >    are in use?
> 
> kisskb reported the following m68k failures to me:
>     linux-next/m68k-allmodconfig/m68k-gcc8
>     linux-next/m68k-allmodconfig/m68k-gcc11
>     linux-next/m68k-allmodconfig/m68k-gcc12
> 
> However, according to [1], linux-next/m68k-allmodconfig/m68k-gcc13
> did succeed, so I guess you are using gcc13?

Yes, I compiled with these:

$ gcc --version
gcc (Debian 13.2.0-5) 13.2.0
Copyright (C) 2023 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

$ clang --version
Debian clang version 16.0.6 (16)
	Target: x86_64-pc-linux-gnu
	Thread model: posix
	InstalledDir: /usr/bin


-- 
With Best Regards,
Andy Shevchenko


