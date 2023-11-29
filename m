Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 866977FDDD8
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 18:01:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231295AbjK2RAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 12:00:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231292AbjK2RAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 12:00:52 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E39A2BC;
        Wed, 29 Nov 2023 09:00:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701277259; x=1732813259;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=M9ssJjd+HXfjISSW4felR1dBwTKed2/2pddd3sy0Bbo=;
  b=jH/cOi2DhbplREYyau/uulKgPb29GyxMO0+sLryLdtpYT7PbOKSRO70r
   OVR57oZ+TNqUoexs4teS3mTrYKpMLXJflcvImsU0bKtmBHfDTko1uo1IV
   4wj1hR5wFN2ccKSauYX44vgPpmhxhfInnSGax/fJ0jw+LnbWrXUEVPvGm
   3bQjP8GQlPLsIPE+05O6CTLAYygngUc7aZvMav3r4h6PZ3WDbNrZzV9OD
   7B1vSx8cMVnL+WsohoIpc0Ft5GIWEqe0OUuXXCBbLkyVBPzm72jFRDbrp
   /yqQaFj/hUhx4xd3XMhTdb6Kp3JD2tWRuO164VBSv3ijEenDlj9VHt+HR
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="6405651"
X-IronPort-AV: E=Sophos;i="6.04,235,1695711600"; 
   d="scan'208";a="6405651"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 09:00:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="942389594"
X-IronPort-AV: E=Sophos;i="6.04,235,1695711600"; 
   d="scan'208";a="942389594"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 09:00:49 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1r8NvY-00000000Usn-3nmv;
        Wed, 29 Nov 2023 19:00:44 +0200
Date:   Wed, 29 Nov 2023 19:00:44 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
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
        Hal Feng <hal.feng@starfivetech.com>
Subject: Re: [PATCH v4 16/23] pinctrl: imx: Convert to use grp member
Message-ID: <ZWduPKmBWkaIdLhi@smile.fi.intel.com>
References: <20231129161459.1002323-1-andriy.shevchenko@linux.intel.com>
 <20231129161459.1002323-17-andriy.shevchenko@linux.intel.com>
 <CAOMZO5CZpQjWKimNReUkwHOc-mF8vWoq2HDhjGKSu6E3g5-aVw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOMZO5CZpQjWKimNReUkwHOc-mF8vWoq2HDhjGKSu6E3g5-aVw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2023 at 01:36:49PM -0300, Fabio Estevam wrote:
> Hi Andy,
> 
> On Wed, Nov 29, 2023 at 1:15 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > Convert drivers to use grp member embedded in struct group_desc.
> 
> You explained what you did, but you did not explain the reason.

It's explained in the first paragraph in the cover letter. Do you
want to copy this into each commit message?

Note, `b4 shazam ...` has an ability to consider patch series as Git PR,
where the cover letter goes as template for the merge commit message.
That's how I plan to merge it to my tree.


-- 
With Best Regards,
Andy Shevchenko


