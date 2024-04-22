Return-Path: <linux-kernel+bounces-153365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 369A48ACD2B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 14:46:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2D5A284BAB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 12:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29E0014F12D;
	Mon, 22 Apr 2024 12:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dAgOEWdK"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0BE147C82
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 12:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713789928; cv=none; b=uQFxz8xlsow2tkxlx/ptci0wsKY9z99YPMXFmdat8GcaK/IcBx4n6Ash7DtSTGp+i4JXEZ5y5shq98F592y4FZn0Y7JVgct3q9mKPUA0l9lbqUY4H/Ooa24unCPE0SE5cJMnPikB1ARjTzb0mry4OgcbYDHiabJggAxVN593qIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713789928; c=relaxed/simple;
	bh=7swys0gIUQCA8MyBNxRzR4CgEVC6QbULAKLQhq+trVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZoWRHlqsRr87jW/iGKOpOVSc4wp11NSE5Mnb3hZQJe0F7OCk/UWKHcfvQHO8lidK9XvyRHqKYn4TX5/2oJ6+ecp8/DKjrR9dfhN7eFu3tTiGk3gL2fza//KQ7Eka1+mtuI5facWVpnXhAQDYDvvggMg7BH4Lh04D4KMUNI/EVR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dAgOEWdK; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-516ef30b16eso5408148e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 05:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713789925; x=1714394725; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=D4xGjGmCM1dKlkvc8xI8Q2SlpqnDstcnL9eCefAdYpM=;
        b=dAgOEWdKaB7NzAmbSw8CIUIf9cDXElGtE7WqULSgePIi0n8DB1Lwl1pgBxCsq6OESD
         nvvoTIp4RnonSeAUgSUtzfxufVEoJ0ftaEZFqlhQbw1gWQhHnJXHC/GLziUTH342DBOB
         7832ceOv7qVL51v5RdG06FFGFy5KKx+iL7C98d5hMxk8iyClcDyvLN090M9VAQasmLG2
         TbDbNPcI5+rSUwmv7f2B7GqoEtDNeB2YQfa0wBWSQ6fXEEfXf8fIblxcd38SVYmin8Uj
         4BtFkgX6+v/6G7dOURLW2IaGHDXoo4nT4qOcGC+r0lS7M69giNP9WxBX8YAHi0eaOOrq
         bYbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713789925; x=1714394725;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D4xGjGmCM1dKlkvc8xI8Q2SlpqnDstcnL9eCefAdYpM=;
        b=w0/aMNKOgYcT0ubCJtAUB9hqSVFR4NIYK5M9Xqb7aPB1WpeNsn0bX59HE4sxDGTAo/
         thJ8MQ9VP3Sqr7Mk1KSG7n8HzTIKM99qhfaiI7GoelAPWI7zvAzdlQ8fTYFf2PIND0wV
         BoQBO6LMtDi2/d7S3nQ9WMS2/oIa7RjlugIn+tj9YnfU/m5iHwh85+JycqDqFGa9T/Jh
         p6JJY3mi4OB5Vtp2qG4e73RvJyYZfOxXfVNBc/h4qkcXrqbPi9aMrUalRFdp26YO2wyA
         Ku0y8tX9G0WIYboEDFPH+cw7tGVbHGaoCGuKix5wWWoT0oFlNPwjLPeZz8Z83TZB3OVu
         tECQ==
X-Forwarded-Encrypted: i=1; AJvYcCVF5j/8Q1xPNXBdnYy4gdj9hGaxdPuwinBGLc1Md8wla993E+NqZVBRZs0dNDhk8gPf8i6hB7RKrbg4kStuO47Mi1yXs/lLTIug6SRi
X-Gm-Message-State: AOJu0YzI+WhzHfPhin9wCg2JR1aQVNxo6RbpsBUOE9F2s394nZLBk1E2
	og9GaDrCckKAb4KNs2X8uJSi94yeEjjaoEB2fRud0LABINjWmAJVc9soAfpGujtqbIN1iegGM7O
	y
X-Google-Smtp-Source: AGHT+IER5n3zd+unC2/+nLZFWA6BJ20dL00ykgO9rIro/Yb6KEoRo+IQMxzDziptwJXENT0sBonYaw==
X-Received: by 2002:a05:6512:1595:b0:518:ddc3:b3a8 with SMTP id bp21-20020a056512159500b00518ddc3b3a8mr7249634lfb.61.1713789924617;
        Mon, 22 Apr 2024 05:45:24 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::8a5])
        by smtp.gmail.com with ESMTPSA id d16-20020a05651233d000b00517806dccdfsm1742524lfg.34.2024.04.22.05.45.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 05:45:24 -0700 (PDT)
Date: Mon, 22 Apr 2024 15:45:22 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 7/8] usb: typec: ucsi: glink: merge pmic_glink_altmode
 driver
Message-ID: <46fktwtp3xers6tcpov3qo4zswptvajewsdltm45zbz2kmmpzp@cthu6ylttup3>
References: <20240416-ucsi-glink-altmode-v1-0-890db00877ac@linaro.org>
 <20240416-ucsi-glink-altmode-v1-7-890db00877ac@linaro.org>
 <ZiZC/l9nOmzWx+j6@kuha.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZiZC/l9nOmzWx+j6@kuha.fi.intel.com>

On Mon, Apr 22, 2024 at 01:59:10PM +0300, Heikki Krogerus wrote:
> Hi Dmitry,
> 
> On Tue, Apr 16, 2024 at 05:20:56AM +0300, Dmitry Baryshkov wrote:
> > Move handling of USB Altmode to the ucsi_glink driver. This way the
> > altmode is properly registered in the Type-C framework, the altmode
> > handlers can use generic typec calls, the UCSI driver can use
> > orientation information from altmode messages and vice versa, the
> > altmode handlers can use GPIO-based orientation inormation from UCSI
> > GLINK driver.
> > 
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > ---
> >  drivers/soc/qcom/Makefile             |   1 -
> >  drivers/soc/qcom/pmic_glink_altmode.c | 546 ----------------------------------
> >  drivers/usb/typec/ucsi/ucsi_glink.c   | 495 ++++++++++++++++++++++++++++--
> >  3 files changed, 475 insertions(+), 567 deletions(-)
> > 

[skipped the patch]

> > +
> > +static void pmic_glink_ucsi_register_altmode(struct ucsi_connector *con)
> > +{
> > +	static const u8 all_assignments = BIT(DP_PIN_ASSIGN_C) | BIT(DP_PIN_ASSIGN_D) |
> > +			     BIT(DP_PIN_ASSIGN_E);
> > +	struct typec_altmode_desc desc;
> > +	struct typec_altmode *alt;
> > +
> > +	mutex_lock(&con->lock);
> > +
> > +	if (con->port_altmode[0])
> > +		goto out;
> > +
> > +	memset(&desc, 0, sizeof(desc));
> > +	desc.svid = USB_TYPEC_DP_SID;
> > +	desc.mode = USB_TYPEC_DP_MODE;
> > +
> > +	desc.vdo = DP_CAP_CAPABILITY(DP_CAP_DFP_D);
> > +
> > +	/* We can't rely on the firmware with the capabilities. */
> > +	desc.vdo |= DP_CAP_DP_SIGNALLING(0) | DP_CAP_RECEPTACLE;
> > +
> > +	/* Claiming that we support all pin assignments */
> > +	desc.vdo |= all_assignments << 8;
> > +	desc.vdo |= all_assignments << 16;
> > +
> > +	alt = typec_port_register_altmode(con->port, &desc);
> 
>         alt = ucsi_register_displayport(con, 0, 0, &desc);

Note, the existing UCSI displayport AltMode driver depends on the UCSI
actually handling the altomode. It needs a partner, etc.

> 
> You need to export that function, but that should not be a problem:
> 
> diff --git a/drivers/usb/typec/ucsi/displayport.c b/drivers/usb/typec/ucsi/displayport.c
> index d9d3c91125ca..f2754d7b5876 100644
> --- a/drivers/usb/typec/ucsi/displayport.c
> +++ b/drivers/usb/typec/ucsi/displayport.c
> @@ -315,11 +315,13 @@ struct typec_altmode *ucsi_register_displayport(struct ucsi_connector *con,
>         struct ucsi_dp *dp;
>  
>         /* We can't rely on the firmware with the capabilities. */
> -       desc->vdo |= DP_CAP_DP_SIGNALLING(0) | DP_CAP_RECEPTACLE;
> +       if (!desc->vdo) {
> +               desc->vdo = DP_CAP_DP_SIGNALLING(0) | DP_CAP_RECEPTACLE;
>  
> -       /* Claiming that we support all pin assignments */
> -       desc->vdo |= all_assignments << 8;
> -       desc->vdo |= all_assignments << 16;
> +               /* Claiming that we support all pin assignments */
> +               desc->vdo |= all_assignments << 8;
> +               desc->vdo |= all_assignments << 16;
> +       }
>  
>         alt = typec_port_register_altmode(con->port, desc);
>         if (IS_ERR(alt))
> @@ -342,3 +344,4 @@ struct typec_altmode *ucsi_register_displayport(struct ucsi_connector *con,
>  
>         return alt;
>  }
> +EXPORT_SYMBOL_GPL(ucsi_register_displayport);
> 
> <snip>
> 
> > +static void pmic_glink_ucsi_set_state(struct ucsi_connector *con,
> > +				      struct pmic_glink_ucsi_port *port)
> > +{
> > +	struct typec_displayport_data dp_data = {};
> > +	struct typec_altmode *altmode = NULL;
> > +	unsigned long flags;
> > +	void *data = NULL;
> > +	int mode;
> > +
> > +	spin_lock_irqsave(&port->lock, flags);
> > +
> > +	if (port->svid == USB_SID_PD) {
> > +		mode = TYPEC_STATE_USB;
> > +	} else if (port->svid == USB_TYPEC_DP_SID && port->mode == DPAM_HPD_OUT) {
> > +		mode = TYPEC_STATE_SAFE;
> > +	} else if (port->svid == USB_TYPEC_DP_SID) {
> > +		altmode = find_altmode(con, port->svid);
> > +		if (!altmode) {
> > +			dev_err(con->ucsi->dev, "altmode woth SVID 0x%04x not found\n",
> > +				port->svid);
> > +			spin_unlock_irqrestore(&port->lock, flags);
> > +			return;
> > +		}
> > +
> > +		mode = TYPEC_MODAL_STATE(port->mode - DPAM_HPD_A);
> > +
> > +		dp_data.status = DP_STATUS_ENABLED;
> > +		dp_data.status |= DP_STATUS_CON_DFP_D;
> > +		if (port->hpd_state)
> > +			dp_data.status |= DP_STATUS_HPD_STATE;
> > +		if (port->hpd_irq)
> > +			dp_data.status |= DP_STATUS_IRQ_HPD;
> > +		dp_data.conf = DP_CONF_SET_PIN_ASSIGN(port->mode - DPAM_HPD_A);
> > +
> > +		data = &dp_data;
> > +	} else {
> > +		dev_err(con->ucsi->dev, "Unsupported SVID 0x%04x\n", port->svid);
> > +		spin_unlock_irqrestore(&port->lock, flags);
> > +		return;
> > +	}
> > +
> > +	spin_unlock_irqrestore(&port->lock, flags);
> > +
> > +	if (altmode)
> > +		typec_altmode_set_port(altmode, mode, data);
> 
> So if the port altmode is using the ucsi_displayport_ops, you can
> simply register the partner altmode here instead. That should
> guarantee that it'll bind to the DP altmode driver which will take
> care of typec_altmode_enter() etc.

In our case the altmode is unfortunately completely hidden inside the
firmware. It is not exported via the native UCSI interface. Even if I
plug the DP dongle, there is no partner / altmode being reported by the
PPM. All DP events are reported via additional GLINK messages.

The goal is to use the core Type-C altmode handling, while keeping UCSI
out of the altmode business.

This allows the core to handle switches / muxes / retimers, report the
altmode to the userspace via sysfs, keep the link between the DP part of
the stack and the typec port, but at the same time we don't get errors
from UCSI because of the PPM reporting unsupported commands, etc.

> 
> This will also allow the user space to see the altmode normally in
> sysfs.
> 
> > +	else
> > +		typec_set_mode(con->port, mode);
> > +
> > +	if (port->bridge)
> > +		drm_aux_hpd_bridge_notify(&port->bridge->dev,
> > +					  port->hpd_state ?
> > +					  connector_status_connected :
> > +					  connector_status_disconnected);
> > +
> > +}
> 
> thanks,
> 
> -- 
> heikki

-- 
With best wishes
Dmitry

