Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F07B7DB4FE
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 09:19:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232055AbjJ3ITV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 04:19:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232022AbjJ3ITT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 04:19:19 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 872C8A7;
        Mon, 30 Oct 2023 01:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698653957; x=1730189957;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AcMF9VjShgicwfllFdfbQHLrf8Zoz2LK1NqqErPLinU=;
  b=RTDhkre3+QR0eOJngUiQl+yjiVULYaVysaOwCaQGCTga+eMLi8vBpSIQ
   V40GW8uUgsgJPLXMfKRT7LwR4BmEULjvsRkAoK2JS4mnN5IhM5SJALZ1q
   p7GXWeEHjWtJl96lNrpqc+r0W/i6aiInoEAjXR6QB3KorO1PTkAnvLRsy
   /ILk38yodkjV0VyQziYFU8y9ypML5iJ2F1BB+jnxiikqBIyKu/Q25fWlO
   sb91FvBPRmEzUSLICj3HHqcrcSFWLShfvq3TL9zu02EqTwcE1M5UAQML9
   wxktCNPwxCGeZYOjdsaIHtiFLtCD+xlMlMCMqImd1/lCqGPNXWk7Jh2wu
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10878"; a="871673"
X-IronPort-AV: E=Sophos;i="6.03,263,1694761200"; 
   d="scan'208";a="871673"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2023 01:19:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10878"; a="753716240"
X-IronPort-AV: E=Sophos;i="6.03,263,1694761200"; 
   d="scan'208";a="753716240"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by orsmga007.jf.intel.com with SMTP; 30 Oct 2023 01:19:09 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 30 Oct 2023 10:19:08 +0200
Date:   Mon, 30 Oct 2023 10:19:08 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
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
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        freedreno@lists.freedesktop.org
Subject: Re: [RFC PATCH v1 12/12] usb: typec: qcom: define the bridge's path
Message-ID: <ZT9m/OoFUiZaWy9s@kuha.fi.intel.com>
References: <20230903214150.2877023-1-dmitry.baryshkov@linaro.org>
 <20230903214150.2877023-13-dmitry.baryshkov@linaro.org>
 <ZQRKq7K8jKlH/Y4X@kuha.fi.intel.com>
 <0F1BE090-92C4-4233-A77A-9B4C653DA1A7@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0F1BE090-92C4-4233-A77A-9B4C653DA1A7@linaro.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23, 2023 at 09:24:33PM +0300, Dmitry Baryshkov wrote:
> On 15 September 2023 15:14:35 EEST, Heikki Krogerus <heikki.krogerus@linux.intel.com> wrote:
> >Hi Dmitry,
> >
> >On Mon, Sep 04, 2023 at 12:41:50AM +0300, Dmitry Baryshkov wrote:
> >> In order to notify the userspace about the DRM connector's USB-C port,
> >> export the corresponding port's name as the bridge's path field.
> >> 
> >> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> >> ---
> >>  drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c     | 11 +++++++----
> >>  drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_drm.c |  4 +++-
> >>  drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_drm.h |  6 ++++--
> >>  3 files changed, 14 insertions(+), 7 deletions(-)
> >> 
> >> diff --git a/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c b/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c
> >> index b9d4856101c7..452dc6437861 100644
> >> --- a/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c
> >> +++ b/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c
> >> @@ -156,6 +156,7 @@ static int qcom_pmic_typec_probe(struct platform_device *pdev)
> >>  	struct device_node *np = dev->of_node;
> >>  	const struct pmic_typec_resources *res;
> >>  	struct regmap *regmap;
> >> +	char *tcpm_name;
> >>  	u32 base[2];
> >>  	int ret;
> >>  
> >> @@ -211,10 +212,6 @@ static int qcom_pmic_typec_probe(struct platform_device *pdev)
> >>  	mutex_init(&tcpm->lock);
> >>  	platform_set_drvdata(pdev, tcpm);
> >>  
> >> -	tcpm->pmic_typec_drm = qcom_pmic_typec_init_drm(dev);
> >> -	if (IS_ERR(tcpm->pmic_typec_drm))
> >> -		return PTR_ERR(tcpm->pmic_typec_drm);
> >> -
> >>  	tcpm->tcpc.fwnode = device_get_named_child_node(tcpm->dev, "connector");
> >>  	if (!tcpm->tcpc.fwnode)
> >>  		return -EINVAL;
> >> @@ -225,6 +222,12 @@ static int qcom_pmic_typec_probe(struct platform_device *pdev)
> >>  		goto fwnode_remove;
> >>  	}
> >>  
> >> +	tcpm_name = tcpm_port_get_name(tcpm->tcpm_port);
> >> +	tcpm->pmic_typec_drm = qcom_pmic_typec_init_drm(dev, tcpm_name);
> >
> >So I got some questions and concerns off-list. This was one of the
> >concerns. That tcpm_name is now the actual port device name, so I'm
> >afraid this is not acceptable.
> >
> >You can't use device name as a reference, ever. There is no way to
> >guarantee that a device with a specific name is what you meant it to
> >be by the time it's accessed.
> 
> Hmm, could you please be more specific, why? I mean, class devices are not
> that easy to be renamed in sysfs, are they? Or are you concerned about the
> device being destroyed behind userspace's back? At least for MSM this will be
> a huge problem already, with the bridge driver suddenly being removed.

The race exists even in your case, but please do not look at this as a
solution for only your platform.

This is about showing the user space a link between two device
instances (struct device), and the way you do that is by creating a
symlink. That way the kernel can take care of reference counting and
guarantee that the link always points to the correct device. That way
the link will also be always visible in user space without requirement
for any specific ABI like it should.

thanks,

-- 
heikki
