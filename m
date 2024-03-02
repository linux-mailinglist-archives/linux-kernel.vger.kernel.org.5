Return-Path: <linux-kernel+bounces-89605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23AB986F293
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 22:36:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 561FF1C213DF
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 21:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53D9D41AAC;
	Sat,  2 Mar 2024 21:36:29 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F1842075
	for <linux-kernel@vger.kernel.org>; Sat,  2 Mar 2024 21:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709415388; cv=none; b=N5ifvDMDo6yB2wX1l6KOs/W1wMDhh5QLt2oQmOyYlzCG3zpVYZYMdIb5Nii/eBKygC2yRMqYjr6a8AsH1ln2/28cNh0kBKEalxF3p93Jc2VZK1m33+QGhzvJMNWwpZty4djKJIaF5RENc3EOXT1gyplhjD66+mCMOmiPFYNsrMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709415388; c=relaxed/simple;
	bh=af46Yr3Vb2hiX+yZOFs27VKI6N5KKu4Ek9FA6gmL6Vg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=agJszakpcEFCaFFJ99HJL6t3SuJOEIEkCkHm5+nn1jOxMAXJkN0HU7ZXr6xyLA4QHgzv97ILJ14IptU5L1W+5KJWJSU049GkrpMR3ovfErcpnlvnikFDQzaOtxk3+7Yrw4L2+1VuPCN9U+yQy9e1zbOIQNrVGr/MJPNM6eczzm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1rgX1R-0008Jm-5w; Sat, 02 Mar 2024 22:35:57 +0100
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1rgX1M-0042gf-JN; Sat, 02 Mar 2024 22:35:52 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1rgX1M-00Gf66-1a;
	Sat, 02 Mar 2024 22:35:52 +0100
Date: Sat, 2 Mar 2024 22:35:52 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Russ Weight <russ.weight@linux.dev>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, devicetree@vger.kernel.org,
	Dent Project <dentproject@linuxfoundation.org>
Subject: Re: [PATCH net-next v5 13/17] net: pse-pd: Use regulator framework
 within PSE framework
Message-ID: <ZeObuKHkPN3tiWz_@pengutronix.de>
References: <20240227-feature_poe-v5-0-28f0aa48246d@bootlin.com>
 <20240227-feature_poe-v5-13-28f0aa48246d@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240227-feature_poe-v5-13-28f0aa48246d@bootlin.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Tue, Feb 27, 2024 at 03:42:55PM +0100, Kory Maincent wrote:
> Integrate the regulator framework to the PSE framework for enhanced
> access to features such as voltage, power measurement, and limits, which
> are akin to regulators. Additionally, PSE features like port priorities
> could potentially enhance the regulator framework. Note that this
> integration introduces some implementation complexity, including wrapper
> callbacks and nested locks, but the potential benefits make it worthwhile.
> 
> Regulator are using enable counter with specific behavior.
> Two calls to regulator_disable will trigger kernel warnings.
> If the counter exceeds one, regulator_disable call won't disable the
> PSE PI. These behavior isn't suitable for PSE control.
> Added a boolean 'enabled' state to prevent multiple calls to

Please rename rename "enabled" to "admin_state_enabled". This variable
do not reflect real device state, it reflects only user configuration.

..  
> @@ -120,15 +118,9 @@ int fwnode_mdiobus_register_phy(struct mii_bus *bus,
>  	u32 phy_id;
>  	int rc;
>  
> -	psec = fwnode_find_pse_control(child);
> -	if (IS_ERR(psec))
> -		return PTR_ERR(psec);
> -
>  	mii_ts = fwnode_find_mii_timestamper(child);
> -	if (IS_ERR(mii_ts)) {
> -		rc = PTR_ERR(mii_ts);
> -		goto clean_pse;
> -	}
> +	if (IS_ERR(mii_ts))
> +		return PTR_ERR(mii_ts);
>  
>  	is_c45 = fwnode_device_is_compatible(child, "ethernet-phy-ieee802.3-c45");
>  	if (is_c45 || fwnode_get_phy_id(child, &phy_id))
> @@ -161,6 +153,12 @@ int fwnode_mdiobus_register_phy(struct mii_bus *bus,
>  			goto clean_phy;
>  	}
>  
> +	psec = dev_find_pse_control(&phy->mdio.dev);
> +	if (IS_ERR(psec)) {
> +		rc = PTR_ERR(psec);
> +		goto unregister_phy;
> +	}
> +

I do not think it is a good idea to make PSE controller depend on
phy->mdio.dev. The only reason why we have fwnode_find_pse_control()
here was the missing port abstraction.

..
> +static int
> +devm_pse_pi_regulator_register(struct pse_controller_dev *pcdev,
> +			       char *name, int id)
> +{
> +	struct regulator_config rconfig = {0};
> +	struct regulator_desc *rdesc;
> +	struct regulator_dev *rdev;
> +
> +	rdesc = devm_kzalloc(pcdev->dev, sizeof(*rdesc), GFP_KERNEL);
> +	if (!rdesc)
> +		return -ENOMEM;
> +
> +	/* Regulator descriptor id have to be the same as its associated
> +	 * PSE PI id for the well functioning of the PSE controls.
> +	 */
> +	rdesc->id = id;
> +	rdesc->name = name;
> +	rdesc->type = REGULATOR_CURRENT;
> +	rdesc->ops = &pse_pi_ops;
> +	rdesc->owner = pcdev->owner;
> +
> +	rconfig.dev = pcdev->dev;
> +	rconfig.driver_data = pcdev;
> +	rconfig.init_data = &pse_pi_initdata;

Please add input supply to track all dependencies:
        if (of_property_present(np, "vin-supply"))                                                                    
	                config->input_supply = "vin";

May be better to make it not optional...

Should be tested, but if, instead of "vin-supply", we will use
"pse-supply" it will make most part of pse_regulator.c obsolete.

...  
> @@ -310,6 +452,20 @@ pse_control_get_internal(struct pse_controller_dev *pcdev, unsigned int index)
>  		return ERR_PTR(-ENODEV);
>  	}
>  
> +	psec->ps = devm_regulator_get_exclusive(dev,
> +						rdev_get_name(pcdev->pi[index].rdev));
> +	if (IS_ERR(psec->ps)) {
> +		kfree(psec);
> +		return ERR_CAST(psec->ps);
> +	}
> +
> +	ret = regulator_is_enabled(psec->ps);
> +	if (ret < 0) {
> +		kfree(psec);
> +		return ERR_PTR(ret);
> +	}
> +	pcdev->pi[index].enabled = ret;

If I see it correctly, it will prevent us to refcount a request from
user space. So, the runtime PM may suspend PI.

> +
>  	psec->pcdev = pcdev;
>  	list_add(&psec->list, &pcdev->pse_control_head);
>  	psec->id = index;
> @@ -344,7 +500,8 @@ static int psec_id_legacy_xlate(struct pse_controller_dev *pcdev,
>  	return pse_spec->args[0];
>  }
>  
> -struct pse_control *of_pse_control_get(struct device_node *node)
> +struct pse_control *of_pse_control_get(struct device *dev,
> +				       struct device_node *node)
>  {
>  	struct pse_controller_dev *r, *pcdev;
>  	struct of_phandle_args args;
> @@ -394,7 +551,7 @@ struct pse_control *of_pse_control_get(struct device_node *node)
>  	}
>  
>  	/* pse_list_mutex also protects the pcdev's pse_control list */
> -	psec = pse_control_get_internal(pcdev, psec_id);
> +	psec = pse_control_get_internal(dev, pcdev, psec_id);
>  
>  out:
>  	mutex_unlock(&pse_list_mutex);
> @@ -443,21 +600,24 @@ int pse_ethtool_set_config(struct pse_control *psec,
>  			   struct netlink_ext_ack *extack,
>  			   const struct pse_control_config *config)
>  {
> -	const struct pse_controller_ops *ops;
> -	int err;
> -
> -	ops = psec->pcdev->ops;
> +	int err = 0;
>  
> -	if (!ops->ethtool_set_config) {
> -		NL_SET_ERR_MSG(extack,
> -			       "PSE driver does not configuration");
> -		return -EOPNOTSUPP;
> +	/* Look at enabled status to not call regulator_enable or
> +	 * regulator_disable twice creating a regulator counter mismatch
> +	 */
> +	switch (config->c33_admin_control) {
> +	case ETHTOOL_C33_PSE_ADMIN_STATE_ENABLED:
> +		if (!psec->pcdev->pi[psec->id].enabled)
> +			err = regulator_enable(psec->ps);
> +		break;
> +	case ETHTOOL_C33_PSE_ADMIN_STATE_DISABLED:
> +		if (psec->pcdev->pi[psec->id].enabled)
> +			err = regulator_disable(psec->ps);
> +		break;
> +	default:
> +		err = -EOPNOTSUPP;
>  	}

This change seems to break PoDL support

> -	mutex_lock(&psec->pcdev->lock);
> -	err = ops->ethtool_set_config(psec->pcdev, psec->id, extack, config);
> -	mutex_unlock(&psec->pcdev->lock);
> -
>  	return err;

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

