Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DCF4810C05
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 09:09:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378766AbjLMIJG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 03:09:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378750AbjLMIJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 03:09:04 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B83E4B2;
        Wed, 13 Dec 2023 00:09:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702454950; x=1733990950;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rMiaJC8fgXzWBq5kjwXOvMEA3/jbQN1IRhkx7p5yyeY=;
  b=ZZ+bSEYToSIFTSiAIhY1VyxczpJCLyhYdbMqpH09RW8sW0qCCV3pGg+q
   lU8iCTFbNOz4kGexFuelPYE+MIsay9xHCldwsr7UnMy/gx0TapX2b32O+
   AYXIit1fXAOc1ij+8ylKTtR394tXEL/mffwS8B41QsbIuyGGHOocL4k1K
   C3GM2tgIiBtEWlkOoDi7c4J7hV6f2Q9NYoZ6J2HsI8sRrLF0mv/HPrIOI
   neCeF0uUs09C0S5U6ezhMkwowCGiEvNLhj7zuboLxke9Sv6FUoR8ffIJY
   +4J4wmscB5gZDY04PIOLIcYn3HrtQAX58MH63Gr4CZ/2qe7eo8PbR8NTV
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="392103661"
X-IronPort-AV: E=Sophos;i="6.04,272,1695711600"; 
   d="scan'208";a="392103661"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 00:09:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="750025415"
X-IronPort-AV: E=Sophos;i="6.04,272,1695711600"; 
   d="scan'208";a="750025415"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 00:09:05 -0800
Received: from kekkonen.localdomain (localhost [127.0.0.1])
        by kekkonen.fi.intel.com (Postfix) with SMTP id E8FCC11FC21;
        Wed, 13 Dec 2023 10:09:02 +0200 (EET)
Date:   Wed, 13 Dec 2023 08:09:02 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Bill Wendling <morbo@google.com>,
        Justin Stitt <justinstitt@google.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH] media: i2c: mt9m114: add CONFIG_COMMON_CLK dependency
Message-ID: <ZXlmnmGepRnMyNfr@kekkonen.localdomain>
References: <20231212213625.3653558-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212213625.3653558-1-arnd@kernel.org>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Tue, Dec 12, 2023 at 10:18:04PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> With clang-16, building without COMMON_CLK triggers a range check on
> udelay() because of a constant division-by-zero calculation:
> 
> ld.lld: error: undefined symbol: __bad_udelay
> >>> referenced by mt9m114.c
> >>>               drivers/media/i2c/mt9m114.o:(mt9m114_power_on) in archive vmlinux.a
> 
> Avoid this by adding a Kconfig dependency that avoids the broken build.

This sounds like an odd way to fix an issue with udelay(). On which arch
does it happen? Wouldn't it be better to fix the udelay() problem in the
source?

A quick check reveals there are about 2400 files using udelay.

> 
> Fixes: 24d756e914fc ("media: i2c: Add driver for onsemi MT9M114 camera sensor")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/media/i2c/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/media/i2c/Kconfig b/drivers/media/i2c/Kconfig
> index aae05142e191..b224c37bfd77 100644
> --- a/drivers/media/i2c/Kconfig
> +++ b/drivers/media/i2c/Kconfig
> @@ -228,6 +228,7 @@ config VIDEO_MT9M111
>  
>  config VIDEO_MT9M114
>  	tristate "onsemi MT9M114 sensor support"
> +	depends on COMMON_CLK
>  	select V4L2_CCI_I2C
>  	help
>  	  This is a Video4Linux2 sensor-level driver for the onsemi MT9M114

-- 
Regards,

Sakari Ailus
