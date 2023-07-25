Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 620DD760E3A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 11:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233111AbjGYJSd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 05:18:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233025AbjGYJS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 05:18:26 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C9DD11B;
        Tue, 25 Jul 2023 02:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690276705; x=1721812705;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+Q06PentsIanzmdfnoZS42vyVmRdVGNF/39w4Rf8BrE=;
  b=R1HAjGzLkOuzwRsJZAoTh1ul1Pfppk/Xu1/91a8tmBbVHRpz+qWNHipg
   oY9/L1G4w6yAocYxAmo7PWqKwijRAhCvVSFVI4wIazHBDpWiuPGlEYoz/
   s375y8DVRQDp0CQHm/3AlQJrv0CL8K7mY62ztLlxSEUHu8Zy7JcI8WGJT
   H6m1sMCPtzV9vRqdD/idJXUmVNlmbAWVgEmwVcUeEIKPsEYp2vICznIIE
   XrfrR+Ih72DBr66uoqCLWYQFltRuRrXz1Zi6bV2Q3EraBjm8SrLjhx1IP
   mjAlJKlx9vBmS3E9LCDaANAsK02xj58rm7tXZkL/tsX0BCZtcJrFVZZ55
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="454048788"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="454048788"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2023 02:18:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="719980272"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="719980272"
Received: from mongola-mobl.ger.corp.intel.com (HELO [10.249.37.129]) ([10.249.37.129])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2023 02:18:17 -0700
Message-ID: <9e391c7d-f45b-42f4-fae4-72fba32482db@linux.intel.com>
Date:   Tue, 25 Jul 2023 10:10:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH v4 06/32] ASoC: Add SOC USB APIs for adding an USB backend
Content-Language: en-US
To:     Wesley Cheng <quic_wcheng@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        catalin.marinas@arm.com, will@kernel.org, mathias.nyman@intel.com,
        gregkh@linuxfoundation.org, lgirdwood@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        srinivas.kandagatla@linaro.org, bgoswami@quicinc.com,
        Thinh.Nguyen@synopsys.com
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-usb@vger.kernel.org, alsa-devel@alsa-project.org,
        quic_jackp@quicinc.com, oneukum@suse.com, albertccwang@google.com,
        o-takashi@sakamocchi.jp
References: <20230725023416.11205-1-quic_wcheng@quicinc.com>
 <20230725023416.11205-7-quic_wcheng@quicinc.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20230725023416.11205-7-quic_wcheng@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> +/**
> + * struct snd_soc_usb
> + * @list - list head for SND SOC struct list
> + * @dev - USB backend device reference
> + * @component - reference to DAPM component

ASoC component, not DAPM.

> + * @connection_status_cb - callback to notify connection events
> + * @priv_data - driver data
> + **/
> +struct snd_soc_usb {
> +	struct list_head list;
> +	struct device *dev;
> +	struct snd_soc_component *component;
> +	int (*connection_status_cb)(struct snd_soc_usb *usb, int card_idx,
> +				int connected);

It's not clear what 'connected' really refers to, is this a boolean
really or is this a "connection_event?


> +	void *priv_data;
> +};
> +
> +int snd_soc_usb_connect(struct device *usbdev, int card_idx);
> +int snd_soc_usb_disconnect(struct device *usbdev);
> +void snd_soc_usb_set_priv_data(struct device *dev, void *priv);

this function is not part of this patch, is this intentional to have a
get but not a set?

> +void *snd_soc_usb_get_priv_data(struct device *usbdev);

you are using 'usbdev' and 'dev' for the same type of parameters, why
not align on one set of definition with a consistent naming.


> +static struct snd_soc_usb *snd_soc_find_usb_ctx(struct device *dev)
> +{
> +	struct device_node *node;
> +	struct snd_soc_usb *ctx = NULL;

this init doesn't seem required?

> +
> +	node = snd_soc_find_phandle(dev);
> +	if (IS_ERR(node))
> +		return NULL;
> +
> +	mutex_lock(&ctx_mutex);
> +	list_for_each_entry(ctx, &usb_ctx_list, list) {
> +		if (ctx->dev->of_node == node) {
> +			of_node_put(node);
> +			mutex_unlock(&ctx_mutex);
> +			return ctx;
> +		}
> +	}
> +	of_node_put(node);
> +	mutex_unlock(&ctx_mutex);
> +
> +	return NULL;
> +}
> +
> +/**
> + * snd_soc_usb_get_priv_data() - Retrieve private data stored
> + * @dev: device reference
> + *
> + * Fetch the private data stored in the USB SND SOC structure.
> + *
> + */
> +void *snd_soc_usb_get_priv_data(struct device *dev)
> +{
> +	struct snd_soc_usb *ctx;
> +
> +	ctx = snd_soc_find_usb_ctx(dev);

so in this function you walk through the usb_ctx_list with locking...

> +	if (!ctx) {
> +		/* Check if backend device */
> +		list_for_each_entry(ctx, &usb_ctx_list, list) {

... and here you walk again through the list without locking.

Something's weird here, if this was intentional you need to add comments.

> +			if (dev->of_node == ctx->dev->of_node)
> +				goto out;
> +		}
> +		ctx = NULL;
> +	}
> +out:
> +	return ctx ? ctx->priv_data : NULL;
> +}
> +EXPORT_SYMBOL_GPL(snd_soc_usb_get_priv_data);
> +
> +/**
> + * snd_soc_usb_add_port() - Add a USB backend port
> + * @dev: USB backend device
> + * @priv: private data
> + * @connection_cb: connection status callback
> + *
> + * Register a USB backend device to the SND USB SOC framework.  Memory is
> + * allocated as part of the USB backend device.
> + *
> + */
> +struct snd_soc_usb *snd_soc_usb_add_port(struct device *dev, void *priv,
> +			int (*connection_cb)(struct snd_soc_usb *usb, int card_idx,
> +			int connected))
> +{
> +	struct snd_soc_usb *usb;
> +
> +	usb = devm_kzalloc(dev, sizeof(*usb), GFP_KERNEL);
> +	if (!usb)
> +		return ERR_PTR(-ENOMEM);
> +
> +	usb->connection_status_cb = connection_cb;
> +	usb->dev = dev;
> +	usb->priv_data = priv;

back to my comment above, you don't seem to need the set_priv_data() ?

> +
> +	mutex_lock(&ctx_mutex);
> +	list_add_tail(&usb->list, &usb_ctx_list);
> +	mutex_unlock(&ctx_mutex);
> +
> +	return usb;
> +}
> +EXPORT_SYMBOL_GPL(snd_soc_usb_add_port);

> +/**
> + * snd_soc_usb_connect() - Notification of USB device connection
> + * @usbdev: USB bus device
> + * @card_idx: USB SND card instance
> + *
> + * Notify of a new USB SND device connection.  The card_idx can be used to
> + * handle how the USB backend selects, which device to enable offloading on.

"USB backend" is confusing, not sure if this is the same concept as DPCM
"backend" or something else. Please try to avoid overloaded terms.

> + *
> + */
> +int snd_soc_usb_connect(struct device *usbdev, int card_idx)
> +{
> +	struct snd_soc_usb *ctx;
> +
> +	if (!usbdev)
> +		return -ENODEV;
> +
> +	ctx = snd_soc_find_usb_ctx(usbdev);
> +	if (!ctx)
> +		return -ENODEV;
> +
> +	if (ctx->connection_status_cb)
> +		ctx->connection_status_cb(ctx, card_idx, 1);

so either the 'connected' value is 1...
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(snd_soc_usb_connect);
> +
> +/**
> + * snd_soc_usb_disconnect() - Notification of USB device disconnection
> + * @usbdev: USB bus device
> + *
> + * Notify of a new USB SND device disconnection to the USB backend.
> + *
> + */
> +int snd_soc_usb_disconnect(struct device *usbdev)
> +{
> +	struct snd_soc_usb *ctx;
> +
> +	if (!usbdev)
> +		return -ENODEV;
> +
> +	ctx = snd_soc_find_usb_ctx(usbdev);
> +	if (!ctx)
> +		return -ENODEV;
> +
> +	if (ctx->connection_status_cb)
> +		ctx->connection_status_cb(ctx, -1, 0);

...and here it's zero.

should this 'connected' parameter be a boolean then with true/false
value, or do you want to add enums/defines for more flexibility down the
road?

> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(snd_soc_usb_disconnect);
