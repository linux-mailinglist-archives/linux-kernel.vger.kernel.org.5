Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88A3F79FC63
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 08:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233411AbjINGza (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 02:55:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235722AbjINGz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 02:55:29 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3199CD8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 23:55:24 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-403004a96a4so6369645e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 23:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694674523; x=1695279323; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JdJtSip6jueHWIKrIxuq/3ErqyWztQHlLvahC0B+skk=;
        b=KfDP9okeHdz6WYyhPYr+eKtjJ/NzNcwvdZ/U8pWxo6ufOEWIHKDGHMzyODXrjArU4j
         bPrPIle2ah5/QJC/RykooapNsc9YA8kLxrLN9aNEZS2Xfj3G6bYbzCFiJ7MCHK9Fqan7
         I5eqhGietipvwvX8yDyfR6TKySCyhrpP34DG5UFYh8sMOmgD+x3RLmVjPjoQE08uB1MO
         y07TAYHqWucA6Y9FhhfPSDs71u7twCHe+X/PWOmssJnu2Gd8jcEr18ydF39FAMsaOoPC
         pY+Rbc0lNuQRZbK8aoahxL+zrhT/+dochC0IJrT2ERSbHVmhBON2pdeLjq5dvcJYmSRL
         N7og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694674523; x=1695279323;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JdJtSip6jueHWIKrIxuq/3ErqyWztQHlLvahC0B+skk=;
        b=f9tiNpqz10Uq0xiYHwzR2Qb8i6GsYZInZ+3dltAod2z7NbRYCh/Vyo00wbJ4yDlX+h
         adYvnIFKt60WZmRHCe64QD89vjlYp2W8S22lBkGohgVkEWeW8RWdGZS3GF7ZGOJoUy9g
         xkJTJX23HVQxELR3J2VZ9zoCTOxVzNc35hDWpiqTH0Z4HI9B5qg61BFXmY+CyMQkr5+D
         llpC7wWQVJ4YdK0bv8TxnANb5bkpuQfVKPioenC3bG5pLb2p5prL/93hinOcdno7BfQI
         8SgkiT4t+9kBgk9vekkW6ep61ejcHs8dSlq02GMzDUh1TGakbcqKXHdmjpYf5+vPNGV4
         XWMA==
X-Gm-Message-State: AOJu0YxnwW1rTHJpjarcmNeXO9IbQXOeJ0aaQIDD37GHaWMt8C0sqC/j
        I0ScMPOVavuyR7e26NqktlYLag==
X-Google-Smtp-Source: AGHT+IFOZXhoecDP9qmvD/AMxMEBbJgx3W49iO7bgz4TRdWNNWKhcPAvmDSxEp5Co0lMcqsrM6Wu8Q==
X-Received: by 2002:adf:ed8e:0:b0:319:66b2:6798 with SMTP id c14-20020adfed8e000000b0031966b26798mr4017253wro.43.1694674523195;
        Wed, 13 Sep 2023 23:55:23 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id u25-20020a05600c00d900b003feff926fc5sm1074430wmm.17.2023.09.13.23.55.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 23:55:22 -0700 (PDT)
Date:   Thu, 14 Sep 2023 09:55:20 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Umang Jain <umang.jain@ideasonboard.com>
Cc:     linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Adrien Thierry <athierry@redhat.com>,
        Dan Carpenter <error27@gmail.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH v11 1/5] staging: vc04_services: vchiq_arm: Add new bus
 type and device type
Message-ID: <e815e9d6-450c-4dcf-b562-f302dd9e22e5@kadam.mountain>
References: <20230913195354.835884-1-umang.jain@ideasonboard.com>
 <20230913195354.835884-2-umang.jain@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230913195354.835884-2-umang.jain@ideasonboard.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 14, 2023 at 01:23:50AM +0530, Umang Jain wrote:
> +static int vchiq_bus_type_match(struct device *dev, struct device_driver *drv)
> +{
> +	if (dev->bus == &vchiq_bus_type &&
> +	    strcmp(dev_name(dev), drv->name) == 0)
> +		return 1;
> +
> +	return 0;
> +}

I was not going to comment on this, because it's unfair to nitpick a
v11 patch...  But since you're going to have to redo it anyway, could
you make this function bool and change it to return true/false.

static bool vchiq_bus_type_match(struct device *dev, struct device_driver *drv)
{
	if (dev->bus == &vchiq_bus_type &&
	    strcmp(dev_name(dev), drv->name) == 0)
		return true;

	return false;
}

> +static int vchiq_bus_probe(struct device *dev)
> +{
> +	struct vchiq_device *device = to_vchiq_device(dev);
> +	struct vchiq_driver *driver = to_vchiq_driver(dev->driver);
> +	int ret;
> +
> +	ret = driver->probe(device);
> +	if (ret == 0)
> +		return 0;
> +
> +	return ret;

Ugh...  I was going to ignore this as well, but later there is a
checkpatch warning so then I decided nitpicking was ok.  Always do
error handling.  if (ret).  Never do success handling.  if (!ret).  But
here it can be done on one line.

	return driver->probe(device);

> +}
> +
> +struct bus_type vchiq_bus_type = {
> +	.name   = "vchiq-bus",
> +	.match  = vchiq_bus_type_match,
> +	.uevent = vchiq_bus_uevent,
> +	.probe  = vchiq_bus_probe,
> +};
> +
> +static void vchiq_device_release(struct device *dev)
> +{
> +	struct vchiq_device *device = to_vchiq_device(dev);
> +
> +	kfree(device);
> +}
> +
> +struct vchiq_device *
> +vchiq_device_register(struct device *parent, const char *name)
> +{
> +	struct vchiq_device *device;
> +	int ret;
> +
> +	device = kzalloc(sizeof(*device), GFP_KERNEL);
> +	if (!device) {
> +		dev_err(parent, "Cannot register %s: Insufficient memory\n",
> +			name);

Run checkpatch.pl -f on your files.

> +		return NULL;
> +	}

Stefan already commented on the other stuff I was going to say.

regards,
dan carpenter

