Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABBD97EAF8E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 13:00:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232729AbjKNMAB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 07:00:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjKNMAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 07:00:00 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 800ECF0;
        Tue, 14 Nov 2023 03:59:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699963198; x=1731499198;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4oG9wyBXREt5cXyC/2Vusxe5M3z5bDE6E1zqLZgoIlg=;
  b=hrh0o4/FsKGI+MgQ1tvDWU4ked0P9UzZCNV8WP7VdfR25sWaAjG8+vn4
   31mB34MKwmngajc14FlGAzxfue88Ae37eG25zov+ZeVizmBgcBJ7uEql7
   VtFYvognt+WDU7xkGKK525f9No1cSjy4AE7dlJJ0E4bi/83zTjFyWmM72
   EGtbb4+RH5ePKlLbVDFBm6qUw/dBnEyfOC+f2DcCh22nylR0zgubgYToN
   mbgoGKj1ZQhlVKti91/MMJAdKtfqWTOCUVdJ1Hum3cHh4wsgFHtut9ZV4
   gGUnJCtjhLx0w2FGoRtP/npc8n9ZJsBZ7jD0rE5AFuqd9uc/cNW6+02di
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="9279316"
X-IronPort-AV: E=Sophos;i="6.03,302,1694761200"; 
   d="scan'208";a="9279316"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2023 03:59:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="1096074144"
X-IronPort-AV: E=Sophos;i="6.03,302,1694761200"; 
   d="scan'208";a="1096074144"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 14 Nov 2023 03:59:54 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 19158761; Tue, 14 Nov 2023 13:59:53 +0200 (EET)
Date:   Tue, 14 Nov 2023 13:59:52 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Raag Jadav <raag.jadav@intel.com>
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl,
        andriy.shevchenko@linux.intel.com, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        mallikarjunappa.sangannavar@intel.com, bala.senthil@intel.com
Subject: Re: [PATCH v1 0/3] Use the standard _PM_OPS() export macro in Intel
 Tangier GPIO driver
Message-ID: <20231114115952.GW17433@black.fi.intel.com>
References: <20231113131600.10828-1-raag.jadav@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231113131600.10828-1-raag.jadav@intel.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 13, 2023 at 06:45:57PM +0530, Raag Jadav wrote:
> This series exports pm_ops structure from Intel Tangier GPIO driver using
> EXPORT_NS_GPL_SIMPLE_DEV_PM_OPS() helper and reuses it into its users.
> 
> Raag Jadav (3):
>   gpio: tangier: use EXPORT_NS_GPL_SIMPLE_DEV_PM_OPS() helper
>   gpio: elkhartlake: reuse pm_ops from Intel Tangier driver
>   gpio: tangier: unexport suspend/resume handles
> 
>  drivers/gpio/gpio-elkhartlake.c | 14 +-------------
>  drivers/gpio/gpio-tangier.c     |  9 +++++----
>  drivers/gpio/gpio-tangier.h     |  4 ++--
>  3 files changed, 8 insertions(+), 19 deletions(-)

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
