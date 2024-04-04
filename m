Return-Path: <linux-kernel+bounces-131496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 412048988AD
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 15:21:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 615F11C218EB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 13:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5517186630;
	Thu,  4 Apr 2024 13:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="htyPifAL"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA1E128361
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 13:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712236836; cv=none; b=uMbghPv/ajGS++wdLdq9yu4X4kKSwoVskwazVausB+XtaH2rR+nWCWUBfmgFJmdy1WcV3DiuwhCy148z+ChMbg1oOVNR9zrGelVvYAWyJWXCH+3PPMzO2zpSn5dJJSY2qRJooWZIcQxlESk1Epxd9msBdXH3U7BDi1cc+7bUu5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712236836; c=relaxed/simple;
	bh=0joi11G0xDZ2oFlx1nqLnr2QN/Lqgq8PjUP0rm/6LuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NvE0Z4rnrYwWNJ2bsX+R9wkHityeQxHyLNxl09SsoAvor5i8Jkt5bF8ywQX1BN3phJ/V1+JnMxxAlSglsfULOBOTZDY1X0RYYBW21zluM0/DhXMziNTOX9MOQSZQ3lbogttZmzhmBrAPklxRlkG0b978+djsLi5r4S04IzzswVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=htyPifAL; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-515a68d45faso1123454e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 06:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712236832; x=1712841632; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BmxT2bmm8g0mJQONvjf7yYzlDODkFb/ewfnFEZYAOnw=;
        b=htyPifAL0OzBHt4N3dRar2BD4fflPylMfi2MDS12ZqgBiYqDfMCV+RUSJp3NeWpC5k
         PgDNTFOKUXkfwI6CnCIwDnoeNDVD1JiYtdBkUYtHEx9gCWxj8SLPwBv172wmgY3otNo4
         kA4muuKP0CPCfY8WpHmQQUsQ+T2csEbzFSwl4VluVC6bzAB1kI6SCqZfYYQ3PeFVKS+x
         DTRbxlwlTydeBkq+V5Uu40FeK9czvslRnaIlXXKcMRuScMX2wLhWt4KcZ9PQkVRk+2+l
         N/lf8vJ8VOxH0yX+u1N6jP0AkFObHd0tWoPQbDay9DkYlTo3BVuVnI1j5J29zO9PZ1C9
         IqyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712236832; x=1712841632;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BmxT2bmm8g0mJQONvjf7yYzlDODkFb/ewfnFEZYAOnw=;
        b=UjzGgmZPhb9N73D6t7qbQOg5WneyLSXOfQ/FT/OYTtEQkUiGk7MaNOAtMf0ijls2d/
         amJaXlKxx8erxrvlnFil20CGJvEdsJXNGICMMi00nL5ajGyhT9cFVR4rnCl4UluQf3Q2
         bVtKTbAzeZ2aQJMH7Sh8QOnO7t4bkUhGbKFrQjwvligYmJZp2CVEf49IRGpwZiHaEfGL
         aH/tUxVRu6mKKzJQIFWqGhC2Yz5vFwehyQ5gwgBdOOj1T1yWSar6FgcP6/+qzmYOYzxr
         z+S8jtbaXWDJ48B6Mztxt1m4y9LTJieXwdQDVnzVENNl5q3W7BsbUhufrkZ5rJCd+iy5
         8h6A==
X-Forwarded-Encrypted: i=1; AJvYcCXFc4GAdY8xcsAO2e0Pu9WRF7Cn5c2AP2CTkkoNJ/q+ZDXJ4mfvzJcVO1xgEWOalP1XSUCC4xX0z43k/KGmdPBGQTUlVBbb2XIgm1t4
X-Gm-Message-State: AOJu0Yy8PnQTbheRLL8yzk/R21SeUh38kPg0xSLYHfWalG4jbXqEc84B
	L+YVz+mpdkkc5aIxheR3fH4UcVa8F1sQ8kJWFcmqB+5//JeXd3LjwJ0spcnwNJY=
X-Google-Smtp-Source: AGHT+IFxotHqerLaFbC8q0QYoe5CGSs3NsouxaH0IHWzzx7Joqi/YVnfY+52cKFEhigEqGlEjAVhog==
X-Received: by 2002:a05:6512:488d:b0:515:d4bc:c64d with SMTP id eq13-20020a056512488d00b00515d4bcc64dmr1665084lfb.68.1712236832488;
        Thu, 04 Apr 2024 06:20:32 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzyjmhyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a00e:a300::227])
        by smtp.gmail.com with ESMTPSA id t22-20020a192d56000000b00516cbd3e982sm177550lft.178.2024.04.04.06.20.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 06:20:32 -0700 (PDT)
Date: Thu, 4 Apr 2024 16:20:30 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Pavan Holla <pholla@chromium.org>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Benson Leung <bleung@chromium.org>, 
	Tzung-Bi Shih <tzungbi@kernel.org>, Guenter Roeck <groeck@chromium.org>, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>, chrome-platform@lists.linux.dev
Subject: Re: [PATCH v3 2/2] usb: typec: ucsi: Implement ChromeOS UCSI driver
Message-ID: <oi3bwdyvyaezpmyxfdtsbiwwprxi2ufc3hlzoz23d5rxdkperl@cxpd7enatg7h>
References: <20240403-public-ucsi-h-v3-0-f848e18c8ed2@chromium.org>
 <20240403-public-ucsi-h-v3-2-f848e18c8ed2@chromium.org>
 <3ezjocthsigo3t746slmgzffnmpxw7wwf3s535basiaf2qy6io@7ocxva6ndsbt>
 <2024040449-average-foyer-defa@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024040449-average-foyer-defa@gregkh>

On Thu, Apr 04, 2024 at 03:07:15PM +0200, Greg Kroah-Hartman wrote:
> On Wed, Apr 03, 2024 at 09:58:33PM +0300, Dmitry Baryshkov wrote:
> > On Wed, Apr 03, 2024 at 06:05:22PM +0000, Pavan Holla wrote:
> > > Implementation of a UCSI transport driver for ChromeOS.
> > > This driver will be loaded if the ChromeOS EC implements a PPM.
> > > 
> > > Signed-off-by: Pavan Holla <pholla@chromium.org>
> > > ---
> > >  drivers/usb/typec/ucsi/Kconfig        |  13 ++
> > >  drivers/usb/typec/ucsi/Makefile       |   1 +
> > >  drivers/usb/typec/ucsi/cros_ec_ucsi.c | 245 ++++++++++++++++++++++++++++++++++
> > >  3 files changed, 259 insertions(+)
> > > 
> > > diff --git a/drivers/usb/typec/ucsi/Kconfig b/drivers/usb/typec/ucsi/Kconfig
> > > index bdcb1764cfae..4dceb14a66ee 100644
> > > --- a/drivers/usb/typec/ucsi/Kconfig
> > > +++ b/drivers/usb/typec/ucsi/Kconfig
> > > @@ -69,4 +69,17 @@ config UCSI_PMIC_GLINK
> > >  	  To compile the driver as a module, choose M here: the module will be
> > >  	  called ucsi_glink.
> > >  
> > > +config CROS_EC_UCSI
> > > +	tristate "UCSI Driver for ChromeOS EC"
> > > +	depends on MFD_CROS_EC_DEV
> > > +	depends on CROS_USBPD_NOTIFY
> > > +	depends on !EXTCON_TCSS_CROS_EC
> > > +	default MFD_CROS_EC_DEV
> > > +	help
> > > +	  This driver enables UCSI support for a ChromeOS EC. The EC is
> > > +	  expected to implement a PPM.
> > > +
> > > +	  To compile the driver as a module, choose M here: the module
> > > +	  will be called cros_ec_ucsi.
> > > +
> > >  endif
> > > diff --git a/drivers/usb/typec/ucsi/Makefile b/drivers/usb/typec/ucsi/Makefile
> > > index b4679f94696b..cb336eee055c 100644
> > > --- a/drivers/usb/typec/ucsi/Makefile
> > > +++ b/drivers/usb/typec/ucsi/Makefile
> > > @@ -21,3 +21,4 @@ obj-$(CONFIG_UCSI_ACPI)			+= ucsi_acpi.o
> > >  obj-$(CONFIG_UCSI_CCG)			+= ucsi_ccg.o
> > >  obj-$(CONFIG_UCSI_STM32G0)		+= ucsi_stm32g0.o
> > >  obj-$(CONFIG_UCSI_PMIC_GLINK)		+= ucsi_glink.o
> > > +obj-$(CONFIG_CROS_EC_UCSI)		+= cros_ec_ucsi.o
> > > diff --git a/drivers/usb/typec/ucsi/cros_ec_ucsi.c b/drivers/usb/typec/ucsi/cros_ec_ucsi.c
> > > new file mode 100644
> > > index 000000000000..dd46b46d430f
> > > --- /dev/null
> > > +++ b/drivers/usb/typec/ucsi/cros_ec_ucsi.c
> > > @@ -0,0 +1,245 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * UCSI driver for ChromeOS EC
> > > + *
> > > + * Copyright 2024 Google LLC.
> > > + */
> > > +
> > > +#include <linux/container_of.h>
> > > +#include <linux/dev_printk.h>
> > > +#include <linux/mod_devicetable.h>
> > > +#include <linux/module.h>
> > > +#include <linux/platform_data/cros_ec_commands.h>
> > > +#include <linux/platform_data/cros_usbpd_notify.h>
> > > +#include <linux/platform_data/cros_ec_proto.h>
> > > +#include <linux/platform_device.h>
> > > +#include <linux/slab.h>
> > > +#include <linux/wait.h>
> > > +
> > > +#include "ucsi.h"
> > > +
> > > +#define DRV_NAME "cros-ec-ucsi"
> > > +
> > > +#define MAX_EC_DATA_SIZE 256
> > > +#define WRITE_TMO_MS 500
> > > +
> > > +struct cros_ucsi_data {
> > > +	struct device *dev;
> > > +	struct ucsi *ucsi;
> > > +
> > > +	struct cros_ec_device *ec;
> > > +	struct notifier_block nb;
> > > +	struct work_struct work;
> > > +
> > > +	struct completion complete;
> > > +	unsigned long flags;
> > > +};
> > > +
> > > +static int cros_ucsi_read(struct ucsi *ucsi, unsigned int offset, void *val,
> > > +			  size_t val_len)
> > > +{
> > > +	struct cros_ucsi_data *udata = ucsi_get_drvdata(ucsi);
> > > +	struct ec_params_ucsi_ppm_get req = {
> > > +		.offset = offset,
> > > +		.size = val_len,
> > > +	};
> > > +	int ret;
> > > +
> > > +	if (val_len > MAX_EC_DATA_SIZE) {
> > > +		dev_err(udata->dev, "Can't read %zu bytes. Too big.", val_len);
> > > +		return -EINVAL;
> > > +	}
> > > +
> > > +	ret = cros_ec_cmd(udata->ec, 0, EC_CMD_UCSI_PPM_GET,
> > > +			  &req, sizeof(req), val, val_len);
> > > +	if (ret < 0) {
> > > +		dev_warn(udata->dev, "Failed to send EC message UCSI_PPM_GET: error=%d", ret);
> > > +		return ret;
> > > +	}
> > > +	return 0;
> > > +}
> > > +
> > > +static int cros_ucsi_async_write(struct ucsi *ucsi, unsigned int offset,
> > > +				 const void *val, size_t val_len)
> > > +{
> > > +	struct cros_ucsi_data *udata = ucsi_get_drvdata(ucsi);
> > > +	uint8_t ec_buffer[MAX_EC_DATA_SIZE + sizeof(struct ec_params_ucsi_ppm_set)];
> > > +	struct ec_params_ucsi_ppm_set *req = (struct ec_params_ucsi_ppm_set *)ec_buffer;
> > > +	int ret = 0;
> > > +
> > > +	if (val_len > MAX_EC_DATA_SIZE) {
> > > +		dev_err(udata->dev, "Can't write %zu bytes. Too big.", val_len);
> > 
> > I think it's better be written as
> > 
> > if (WARN_ON_ONCE(val_len > MAX_EC_DATA_SIZE))
> > 	return -EINVAL;
> 
> So if you trigger this, you just rebooted all boxes that have
> panic-on-warn enabled (hint, the HUGE majority in quantity of Linux
> systems out there.)
> 
> So don't do that, just handle it like this.

Does that mean that we should not use WARN at all? What is the best
current practice for WARN usage?

I'm asking because for me this looks like a perfect usecase. If I were
at the positiion of the driver developer, I'd like to know the whole
path leading to the bad call, not just the fact that the function was
called with the buffer being too big.

> BUT, if this can be triggered by userspace, do NOT use dev_err() as that
> will just allow userspace to flood the kernel log.
> 
> Pavan, who calls this?  If userspace, this needs to be fixed.  If it's
> only a kernel driver, it's fine as-is.
> 
> thanks,
> 
> greg k-h

-- 
With best wishes
Dmitry

