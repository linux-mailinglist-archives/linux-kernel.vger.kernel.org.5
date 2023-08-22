Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66756784286
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 15:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236198AbjHVNz4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 09:55:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236188AbjHVNzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 09:55:55 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9A8CCD7;
        Tue, 22 Aug 2023 06:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692712548; x=1724248548;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=A7SThdgLDBFPI4b+iW4JgHR4fhUZb3+Hg0rG9D+Hvag=;
  b=N5hx5JYvVoxxu8RA6VhDAKPFtR4TuiXYSqK7RvWDoq/8wVCEFrSNViiI
   ITTpMCvyX40hbBQSKftu+UCCxBu0GLhwi9Hfg27pnpqawkHtzqQD5bXyb
   4c3/zv2aYgBn8EPECrM+IwG7eilv8M9r+PYmZbWO4MPruoGUZUe0Ura6J
   Jmp5n6bzN2QV0Vtppk068/NAbUgKd34KUyOY44UiY/VioHjo2rA/GRw1Y
   lSeTc5lElZIOS8x43OrBG+yUAgAUWxJev+juOGkMQAfqcA/kroPbzr+34
   NteC2tz/gE3Hm6HQhOtIiMAURNMT+Heafb5nx6JxHdmjrLVz62qqsiJoU
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="376622168"
X-IronPort-AV: E=Sophos;i="6.01,193,1684825200"; 
   d="scan'208";a="376622168"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2023 06:54:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="879961568"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 22 Aug 2023 06:54:40 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 22 Aug 2023 16:54:34 +0300
Date:   Tue, 22 Aug 2023 16:54:34 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/2] usb: typec: qcom-pmic-typec: register drm_bridge
Message-ID: <ZOS+GnLeV6JJgpp8@kuha.fi.intel.com>
References: <20230817150824.14371-1-dmitry.baryshkov@linaro.org>
 <20230817150824.14371-3-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230817150824.14371-3-dmitry.baryshkov@linaro.org>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2023 at 06:08:24PM +0300, Dmitry Baryshkov wrote:
> The current approach to handling DP on bridge-enabled platforms requires
> a chain of DP bridges up to the USB-C connector. Register a last DRM
> bridge for such chain.
> 
> Acked-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  drivers/usb/typec/tcpm/Kconfig                |  1 +
>  drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c | 37 +++++++++++++++++++
>  2 files changed, 38 insertions(+)
> 
> diff --git a/drivers/usb/typec/tcpm/Kconfig b/drivers/usb/typec/tcpm/Kconfig
> index 5d393f520fc2..0b2993fef564 100644
> --- a/drivers/usb/typec/tcpm/Kconfig
> +++ b/drivers/usb/typec/tcpm/Kconfig
> @@ -79,6 +79,7 @@ config TYPEC_WCOVE
>  config TYPEC_QCOM_PMIC
>  	tristate "Qualcomm PMIC USB Type-C Port Controller Manager driver"
>  	depends on ARCH_QCOM || COMPILE_TEST
> +	depends on DRM || DRM=n
>  	help
>  	  A Type-C port and Power Delivery driver which aggregates two
>  	  discrete pieces of silicon in the PM8150b PMIC block: the

Would it be an option to put the below in separate c file that you
just compile based on CONFIG_DRM?

        obj-$(CONFIG_TYPEC_QCOM_PMIC)           += qcom_pmic_tcpm.o
        qcom_pmic_tcpm-y                        += qcom_pmic_typec.o \
                                                   qcom_pmic_typec_port.o \
                                                   qcom_pmic_typec_pdphy.o
        ifneq ($(CONFIG_DRM),)
               qcom_pmic_tcpm-y                 += qcom_pmic_bridge_func.o
        endif

Thouse ifdefs in c file just look a bit rough to me.

> diff --git a/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c b/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c
> index af44ee4e6e86..581199d37b49 100644
> --- a/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c
> +++ b/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c
> @@ -17,6 +17,9 @@
>  #include <linux/usb/role.h>
>  #include <linux/usb/tcpm.h>
>  #include <linux/usb/typec_mux.h>
> +
> +#include <drm/drm_bridge.h>
> +
>  #include "qcom_pmic_typec_pdphy.h"
>  #include "qcom_pmic_typec_port.h"
>  
> @@ -33,6 +36,7 @@ struct pmic_typec {
>  	struct pmic_typec_port	*pmic_typec_port;
>  	bool			vbus_enabled;
>  	struct mutex		lock;		/* VBUS state serialization */
> +	struct drm_bridge	bridge;
>  };
>  
>  #define tcpc_to_tcpm(_tcpc_) container_of(_tcpc_, struct pmic_typec, tcpc)
> @@ -146,6 +150,35 @@ static int qcom_pmic_typec_init(struct tcpc_dev *tcpc)
>  	return 0;
>  }
>  
> +#if IS_ENABLED(CONFIG_DRM)
> +static int qcom_pmic_typec_attach(struct drm_bridge *bridge,
> +				     enum drm_bridge_attach_flags flags)
> +{
> +	return flags & DRM_BRIDGE_ATTACH_NO_CONNECTOR ? 0 : -EINVAL;
> +}
> +
> +static const struct drm_bridge_funcs qcom_pmic_typec_bridge_funcs = {
> +	.attach = qcom_pmic_typec_attach,
> +};
> +
> +static int qcom_pmic_typec_init_drm(struct pmic_typec *tcpm)
> +{
> +	tcpm->bridge.funcs = &qcom_pmic_typec_bridge_funcs;
> +#ifdef CONFIG_OF
> +	tcpm->bridge.of_node = of_get_child_by_name(tcpm->dev->of_node, "connector");
> +#endif
> +	tcpm->bridge.ops = DRM_BRIDGE_OP_HPD;
> +	tcpm->bridge.type = DRM_MODE_CONNECTOR_DisplayPort;
> +
> +	return devm_drm_bridge_add(tcpm->dev, &tcpm->bridge);
> +}
> +#else
> +static int qcom_pmic_typec_init_drm(struct pmic_typec *tcpm)
> +{
> +	return 0;
> +}
> +#endif
> +
>  static int qcom_pmic_typec_probe(struct platform_device *pdev)
>  {
>  	struct pmic_typec *tcpm;
> @@ -208,6 +241,10 @@ static int qcom_pmic_typec_probe(struct platform_device *pdev)
>  	mutex_init(&tcpm->lock);
>  	platform_set_drvdata(pdev, tcpm);
>  
> +	ret = qcom_pmic_typec_init_drm(tcpm);
> +	if (ret)
> +		return ret;
> +
>  	tcpm->tcpc.fwnode = device_get_named_child_node(tcpm->dev, "connector");
>  	if (!tcpm->tcpc.fwnode)
>  		return -EINVAL;

thanks,

-- 
heikki
