Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA07980871C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 12:56:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379083AbjLGLxr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 06:53:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232523AbjLGLxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 06:53:44 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D81CD10C0;
        Thu,  7 Dec 2023 03:53:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701950029; x=1733486029;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3EFdU9bF0fb0rJIymq1oYQWqxw2gxZ/VsdFmjDVVlnY=;
  b=dFql21k8fKtQ/AKcGvh7AfA7qYgY2Fe72g3WK56ZSGu/ddqVRdTUXpST
   A9umcs8L8gOmsv5xjWLjf+aL7kD0AppnLluAheM2H6QicC+YTPHrjVl5t
   NVeGYlF7vBOJ2kaIcWdO0MlhZAUFAgvAgxU54R1D6LWjkTLa9lYaHSsN9
   V0jaRgIl7ORX8mbH2i2nJdp3OK1UvpK+ljjvWxANr/dyrZjCnmKvzjl11
   NbWpnOZjPmumiHFOvhM8femVXPVZBTsH3cwsDS5Hbm1kWLEzxWs5sUJgF
   Rud/+1jkrSLqMCWbJCaBkP5S7XnvNMXPZtwpvpz5P+IvDFuLoy9N0bQ/D
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="7579699"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="7579699"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 03:53:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="895122755"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="895122755"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by orsmga004.jf.intel.com with SMTP; 07 Dec 2023 03:53:45 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 07 Dec 2023 13:53:44 +0200
Date:   Thu, 7 Dec 2023 13:53:44 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: typec: nb7vpq904m: add CONFIG_OF dependency
Message-ID: <ZXGySCtdsxW4qCel@kuha.fi.intel.com>
References: <20231206123828.587065-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231206123828.587065-1-arnd@kernel.org>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 06, 2023 at 01:38:14PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> DRM_AUX_BRIDGE depends on CONFIG_OF, so the same dependency is needed
> here to avoid a build failure:
> 
> WARNING: unmet direct dependencies detected for DRM_AUX_BRIDGE
>   Depends on [n]: HAS_IOMEM [=y] && DRM_BRIDGE [=y] && OF [=n]
>   Selected by [y]:
>   - TYPEC_MUX_NB7VPQ904M [=y] && USB_SUPPORT [=y] && TYPEC [=y] && I2C [=y] && (DRM [=y] || DRM [=y]=n) && DRM_BRIDGE [=y]
> x86_64-linux-ld: drivers/gpu/drm/bridge/aux-bridge.o: in function `drm_aux_bridge_register':
> aux-bridge.c:(.text+0x13b): undefined reference to `auxiliary_device_init'
> x86_64-linux-ld: aux-bridge.c:(.text+0x14d): undefined reference to `__auxiliary_device_add'
> x86_64-linux-ld: drivers/gpu/drm/bridge/aux-bridge.o: in function `drm_aux_bridge_drv_init':
> aux-bridge.c:(.init.text+0x15): undefined reference to `__auxiliary_driver_register'
> x86_64-linux-ld: drivers/gpu/drm/bridge/aux-bridge.o: in function `drm_aux_bridge_drv_exit':
> aux-bridge.c:(.exit.text+0x9): undefined reference to `auxiliary_driver_unregister'
> 
> Fixes: c5d296bad640 ("usb: typec: nb7vpq904m: switch to DRM_AUX_BRIDGE")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/usb/typec/mux/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/usb/typec/mux/Kconfig b/drivers/usb/typec/mux/Kconfig
> index 5120942f309d..818624f59120 100644
> --- a/drivers/usb/typec/mux/Kconfig
> +++ b/drivers/usb/typec/mux/Kconfig
> @@ -40,6 +40,7 @@ config TYPEC_MUX_NB7VPQ904M
>  	tristate "On Semiconductor NB7VPQ904M Type-C redriver driver"
>  	depends on I2C
>  	depends on DRM || DRM=n
> +	depends on OF
>  	select DRM_AUX_BRIDGE if DRM_BRIDGE
>  	select REGMAP_I2C
>  	help

Shouldn't DRM_BRIDGE depend on OF instead?

thanks,

-- 
heikki
