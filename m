Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C93708034EA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 14:29:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235501AbjLDN3j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 08:29:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234136AbjLDN3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 08:29:25 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50FF12D76;
        Mon,  4 Dec 2023 05:27:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701696472; x=1733232472;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xAo1jP5xdLJDHA5y+K5s26G3/Skb6cWDEtnKHmw94sw=;
  b=lDK5++dLYq9IIOBw0RtETWA9o5/PiFweVqEdnrq6yrN0Qmsh76AmMtD7
   sSo5PT5RCtkHRH6NmDynYABDPhiiUD6qIMWwMEy0ne3JluDGmI5a8ye2T
   mQ24lgUu4fyXW2PGUHfCdEMABA1U7RhVMZWrZploP1OQfBSRh/xs9ikGS
   d6ym37BJDF08BVt7AKd2NvIBaSBIQgVapzbezmvhSj8bUU/XcPXy2t76r
   Qoc0faa/d9tDHpuIIJNQwM6iXiZvlj5XW5wOTuGCyHIeY92QO31ziCiW+
   xLDtI/q3CgLdWByockDErhKZ61c4JaJ1l3WUrhPtTue3nATLQ+ZMUQL3P
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10913"; a="12445082"
X-IronPort-AV: E=Sophos;i="6.04,249,1695711600"; 
   d="scan'208";a="12445082"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 05:27:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10913"; a="914424174"
X-IronPort-AV: E=Sophos;i="6.04,249,1695711600"; 
   d="scan'208";a="914424174"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 04 Dec 2023 05:27:45 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 04 Dec 2023 15:27:44 +0200
Date:   Mon, 4 Dec 2023 15:27:44 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Janne Grunau <j@jannau.net>, Simon Ser <contact@emersion.fr>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        freedreno@lists.freedesktop.org
Subject: Re: [PATCH RESEND 6/6] usb: typec: qcom-pmic-typec: switch to
 DRM_AUX_HPD_BRIDGE
Message-ID: <ZW3F6wdNiSc8c0FX@kuha.fi.intel.com>
References: <20231203114333.1305826-1-dmitry.baryshkov@linaro.org>
 <20231203114333.1305826-7-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231203114333.1305826-7-dmitry.baryshkov@linaro.org>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

On Sun, Dec 03, 2023 at 02:43:33PM +0300, Dmitry Baryshkov wrote:
> Use the freshly defined DRM_AUX_HPD_BRIDGE instead of open-coding the
> same functionality for the DRM bridge chain termination.
> 
> Acked-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

I'm sorry, I've completely missed this second typec patch.

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/tcpm/Kconfig                |  1 +
>  drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c | 41 +++----------------
>  2 files changed, 7 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/Kconfig b/drivers/usb/typec/tcpm/Kconfig
> index 0b2993fef564..64d5421c69e6 100644
> --- a/drivers/usb/typec/tcpm/Kconfig
> +++ b/drivers/usb/typec/tcpm/Kconfig
> @@ -80,6 +80,7 @@ config TYPEC_QCOM_PMIC
>  	tristate "Qualcomm PMIC USB Type-C Port Controller Manager driver"
>  	depends on ARCH_QCOM || COMPILE_TEST
>  	depends on DRM || DRM=n
> +	select DRM_AUX_HPD_BRIDGE if DRM_BRIDGE
>  	help
>  	  A Type-C port and Power Delivery driver which aggregates two
>  	  discrete pieces of silicon in the PM8150b PMIC block: the
> diff --git a/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c b/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c
> index 581199d37b49..1a2b4bddaa97 100644
> --- a/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c
> +++ b/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c
> @@ -18,7 +18,7 @@
>  #include <linux/usb/tcpm.h>
>  #include <linux/usb/typec_mux.h>
>  
> -#include <drm/drm_bridge.h>
> +#include <drm/bridge/aux-bridge.h>
>  
>  #include "qcom_pmic_typec_pdphy.h"
>  #include "qcom_pmic_typec_port.h"
> @@ -36,7 +36,6 @@ struct pmic_typec {
>  	struct pmic_typec_port	*pmic_typec_port;
>  	bool			vbus_enabled;
>  	struct mutex		lock;		/* VBUS state serialization */
> -	struct drm_bridge	bridge;
>  };
>  
>  #define tcpc_to_tcpm(_tcpc_) container_of(_tcpc_, struct pmic_typec, tcpc)
> @@ -150,35 +149,6 @@ static int qcom_pmic_typec_init(struct tcpc_dev *tcpc)
>  	return 0;
>  }
>  
> -#if IS_ENABLED(CONFIG_DRM)
> -static int qcom_pmic_typec_attach(struct drm_bridge *bridge,
> -				     enum drm_bridge_attach_flags flags)
> -{
> -	return flags & DRM_BRIDGE_ATTACH_NO_CONNECTOR ? 0 : -EINVAL;
> -}
> -
> -static const struct drm_bridge_funcs qcom_pmic_typec_bridge_funcs = {
> -	.attach = qcom_pmic_typec_attach,
> -};
> -
> -static int qcom_pmic_typec_init_drm(struct pmic_typec *tcpm)
> -{
> -	tcpm->bridge.funcs = &qcom_pmic_typec_bridge_funcs;
> -#ifdef CONFIG_OF
> -	tcpm->bridge.of_node = of_get_child_by_name(tcpm->dev->of_node, "connector");
> -#endif
> -	tcpm->bridge.ops = DRM_BRIDGE_OP_HPD;
> -	tcpm->bridge.type = DRM_MODE_CONNECTOR_DisplayPort;
> -
> -	return devm_drm_bridge_add(tcpm->dev, &tcpm->bridge);
> -}
> -#else
> -static int qcom_pmic_typec_init_drm(struct pmic_typec *tcpm)
> -{
> -	return 0;
> -}
> -#endif
> -
>  static int qcom_pmic_typec_probe(struct platform_device *pdev)
>  {
>  	struct pmic_typec *tcpm;
> @@ -186,6 +156,7 @@ static int qcom_pmic_typec_probe(struct platform_device *pdev)
>  	struct device_node *np = dev->of_node;
>  	const struct pmic_typec_resources *res;
>  	struct regmap *regmap;
> +	struct device *bridge_dev;
>  	u32 base[2];
>  	int ret;
>  
> @@ -241,14 +212,14 @@ static int qcom_pmic_typec_probe(struct platform_device *pdev)
>  	mutex_init(&tcpm->lock);
>  	platform_set_drvdata(pdev, tcpm);
>  
> -	ret = qcom_pmic_typec_init_drm(tcpm);
> -	if (ret)
> -		return ret;
> -
>  	tcpm->tcpc.fwnode = device_get_named_child_node(tcpm->dev, "connector");
>  	if (!tcpm->tcpc.fwnode)
>  		return -EINVAL;
>  
> +	bridge_dev = drm_dp_hpd_bridge_register(tcpm->dev, to_of_node(tcpm->tcpc.fwnode));
> +	if (IS_ERR(bridge_dev))
> +		return PTR_ERR(bridge_dev);
> +
>  	tcpm->tcpm_port = tcpm_register_port(tcpm->dev, &tcpm->tcpc);
>  	if (IS_ERR(tcpm->tcpm_port)) {
>  		ret = PTR_ERR(tcpm->tcpm_port);
> -- 
> 2.39.2

-- 
heikki
