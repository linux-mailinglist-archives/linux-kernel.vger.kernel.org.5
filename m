Return-Path: <linux-kernel+bounces-129726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6C8E896F14
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 14:42:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05A5F1C261ED
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 12:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B5941482E0;
	Wed,  3 Apr 2024 12:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CqqIT3v9"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C155C5B05E;
	Wed,  3 Apr 2024 12:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712148106; cv=none; b=qWkQS8Gb9O8NgkCUUUCDN/imh00R169Gmrh5rKTIJQWTgGvqu6tgLgT9LtVAHyc5lRsCMJ4OabPk8HD0UvQPhCSnNkGrn+lSWG0dX2Skwzdev4k7qQNYDLPvf9LN0tay+xRDBovUfo1qjnyXj510BCEW/C0vDFsg3C9gJaZ7vz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712148106; c=relaxed/simple;
	bh=4LdezfRohLDwiQJGR9wslgydZEdUGpcVaPaT2+7yROg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WvoJVANyvFLAyCaL+lVKG2kHo2VTD38MLs43BWybGbt1kwEhmrv7ddKTsFgqybveSUBacnzKfnt67bkP3V3mmsWBNHrR1w2TxFJyeE4kLeSMPi7WKCHtzP7pndX5c+BLjBZlGX1be+ppwGtE8Rp/1LcoovEgvtr9eruNFfypyW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CqqIT3v9; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1dff837d674so49888035ad.3;
        Wed, 03 Apr 2024 05:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712148104; x=1712752904; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LegyacEHrLw0exuWMYz7mVagVL/ivvgsfQicrbS4J3E=;
        b=CqqIT3v9TYuIAYt5H+YL9lqo+hhGBvGpQQLKLfTRdhbhH5YtBdaJjnqOpGCCholptg
         MVJyde4ZQo5lHOAO6iFycQsj5zs0G1rdUcEpVpqEYJtSLCP94JTGyH/3HaMaKcOnb8zw
         MSoJrBpgQc7Q7rb4w7a6SJ+/1Mn4RShY3U4ct88/JDBxxYFkGuoP3aWRuLoHEsw7zTEW
         ug5wwZRWOmZlywzk3t7XH/fdQnh1PIfu8JvO4lTKn7ARhKSP41MTipENdOQoiuC0NXSP
         WyzFwJn+pF4oAZpFAlYI7kPnNiapXKpUGQIOU8jCE7ydvydAuMXbYwAbfdXI/T6ewm1R
         CXOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712148104; x=1712752904;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LegyacEHrLw0exuWMYz7mVagVL/ivvgsfQicrbS4J3E=;
        b=vw5wj78OMdzxDWqlu6ktdwxDlU6rD5S1gRgrcqBADJtIOEUOimWOWGtHsfj4PRpJx4
         wlskJ4NJVuSs+3emd6a0igvrf0uEnx29Iq6RGmTKVkFSU1wqmOoa7LR/5NkEzLoDW9TV
         ldEVuO2JM8pnTY1cGMk6flPWFvmMOL8CSSJoorOT0HqC6yXfsPO/jqCV4CeLFOF1PrnC
         /gElv8KUDcxtes93CCZQBUybgbBbbZQkhzAH39+iBOzGYJFXGc4DRMPsXE6kjQHoQLXN
         F0gemkDhZhftYiqx4dm3rpex7yOw//Dolj3FsFrPNADMPR4hMKBZEqb7TeVc595ZMDd/
         VQdA==
X-Forwarded-Encrypted: i=1; AJvYcCWLSFKq2QOLEqXZMltKIvShiqeys0rRLyVQQp9ZXs0eJ925NuEov8YEM10OfS45eA9A+urXwys+nLQeyo7mllUkd6YpS09+hvLEe8c2G5zFUk0fRYi6qnJXqaj3W6ZFNMf+A0/sUiMGJLQS7icaup/QENEaEggS+GwTkBNOpBnv4tdNZlqGQb76
X-Gm-Message-State: AOJu0Yz7K8b6Jyyt+c4aYOZDDWA26rJSPdJb1Zn6DxDe2znUxIUyNeRV
	25dTQWlDz+ThR4bFyihIgV1P+Whh1CDEEbyFLLlrkItmlpYL7Dk6
X-Google-Smtp-Source: AGHT+IGuj7F88Ztl6J+2YZCPyQ+J8i6U/HfwKVd62W0ZFgBlt7d/Xsa+I2YwXm5q43DCvaCxKaPRQQ==
X-Received: by 2002:a17:902:e94f:b0:1e2:88c9:6c08 with SMTP id b15-20020a170902e94f00b001e288c96c08mr3839019pll.49.1712148103885;
        Wed, 03 Apr 2024 05:41:43 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c12-20020a170902c1cc00b001e27dcfdf15sm3243944plc.145.2024.04.03.05.41.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 05:41:42 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 3 Apr 2024 05:41:41 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Lee Jones <lee@kernel.org>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-watchdog@vger.kernel.org
Subject: Re: [RFC PATCH 5/6] watchdog: ROHM BD96801 PMIC WDG driver
Message-ID: <d2ab33e6-4d3e-472a-b4d7-b703955989ba@roeck-us.net>
References: <cover.1712058690.git.mazziesaccount@gmail.com>
 <f8e743a6c49607de0dd7a27778383477e051b130.1712058690.git.mazziesaccount@gmail.com>
 <4fa3a64b-60fb-4e5e-8785-0f14da37eea2@roeck-us.net>
 <279336b3-f28d-48ee-a10f-47abba7b0b89@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <279336b3-f28d-48ee-a10f-47abba7b0b89@gmail.com>

On Wed, Apr 03, 2024 at 09:34:35AM +0300, Matti Vaittinen wrote:
> Hi Guenter,
> 
> First of all, thanks for the review. It was quick! Especially when we speak
> of a RFC series. Very much appreciated.
> 
> On 4/2/24 20:11, Guenter Roeck wrote:
> > On Tue, Apr 02, 2024 at 04:11:41PM +0300, Matti Vaittinen wrote >> +static int init_wdg_hw(struct wdtbd96801 *w)
> > > +{
> > > +	u32 hw_margin[2];
> > > +	int count, ret;
> > > +	u32 hw_margin_max = BD96801_WDT_DEFAULT_MARGIN, hw_margin_min = 0;
> > > +
> > > +	count = device_property_count_u32(w->dev->parent, "rohm,hw-timeout-ms");
> > > +	if (count < 0 && count != -EINVAL)
> > > +		return count;
> > > +
> > > +	if (count > 0) {
> > > +		if (count > ARRAY_SIZE(hw_margin))
> > > +			return -EINVAL;
> > > +
> > > +		ret = device_property_read_u32_array(w->dev->parent,
> > > +						     "rohm,hw-timeout-ms",
> > > +						     &hw_margin[0], count);
> > > +		if (ret < 0)
> > > +			return ret;
> > > +
> > > +		if (count == 1)
> > > +			hw_margin_max = hw_margin[0];
> > > +
> > > +		if (count == 2) {
> > > +			hw_margin_max = hw_margin[1];
> > > +			hw_margin_min = hw_margin[0];
> > > +		}
> > > +	}
> > > +
> > > +	ret = bd96801_set_wdt_mode(w, hw_margin_max, hw_margin_min);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	ret = device_property_match_string(w->dev->parent, "rohm,wdg-action",
> > > +					   "prstb");
> > > +	if (ret >= 0) {
> > > +		ret = regmap_update_bits(w->regmap, BD96801_REG_WD_CONF,
> > > +				 BD96801_WD_ASSERT_MASK,
> > > +				 BD96801_WD_ASSERT_RST);
> > > +		return ret;
> > > +	}
> > > +
> > > +	ret = device_property_match_string(w->dev->parent, "rohm,wdg-action",
> > > +					   "intb-only");
> > > +	if (ret >= 0) {
> > > +		ret = regmap_update_bits(w->regmap, BD96801_REG_WD_CONF,
> > > +				 BD96801_WD_ASSERT_MASK,
> > > +				 BD96801_WD_ASSERT_IRQ);
> > > +		return ret;
> > > +	}
> > 
> > I don't see the devicetree bindings documented in the series.
> 
> Seems like I have missed this WDG binding. But after reading your comment
> below, I am wondering if I should just drop the binding and default to
> "prstb" (shutdown should the feeding be skipped) - and leave the "intb-only"
> case for one who actually needs such.
> 
> > I am also a bit surprised that the interrupt isn't handled in the driver.
> > Please explain.
> 
> Basically, I just had no idea what the IRQ should do in the generic case. If
> we get an interrupt, it means the WDG feeding has failed. My thinking is
> that, what should happen is forced reset. I don't see how that can be done
> in reliably manner from an IRQ handler.
> 
> When the "prstb WDG action" is set (please, see the above DT binding
> handling), the PMIC shall shut down power outputs. This should get the
> watchdog's job done.
> 
> With the "intb-only"-option, PMIC will not turn off the power. I'd expect
> there to be some external HW connection which handles the reset by HW.
> 
> After all this being said, I wonder if I should just unconditionally
> configure the PMIC to always turn off the power (prstb option) should the
> feeding fail? Or do someone have some suggestion what the IRQ handler should
> do (except maybe print an error msg)?
> 

Other watchdog drivers call emergency_restart() if the watchdog times out
and triggers an interrupt. Are you saying this won't work for this system ?
If so, please explain.

Thanks,
Guenter

