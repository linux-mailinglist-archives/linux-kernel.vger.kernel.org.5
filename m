Return-Path: <linux-kernel+bounces-49500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A28F846B28
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 09:48:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4599C1C26942
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 08:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAE4A5FDDA;
	Fri,  2 Feb 2024 08:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xZ4Uhek5"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204315FDC2
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 08:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706863658; cv=none; b=LI8zuz98F7uUmPBKJ5TCS2g8Cskkm/8OPejlgabP8QQ+4urjXNBey6ZTrUxaVus1zfchgxr0P2tvhNXxScGT1ulehiP0An4xra4wOk+lC8MiwX/cZFjDbTPzTCw256sRltIbvTzw7Zuzz6y+Edr6R9U6Y98bAYLb1n9hf4uDRXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706863658; c=relaxed/simple;
	bh=1mTopl9VLOGdS2RiO2GLhg5Njwg3uxDYSi6ORPCdnl8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FcS49AONR++0am+RkricH4/Jw4MKtHMN++PDzwUFqZlW2zxMGPPC2zh2iIU2f+mIwQss/DXd4e/b3Fxfwh/pz/NiKv3Vpz6g76RprdbGr/AauLJfNTKRVcnYvxIL4v8JVR/vFNH3pBOwoUCmAYNVVA1DER+VIk7dy3ZEUGlHC/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xZ4Uhek5; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-557dcb0f870so2641796a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 00:47:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706863655; x=1707468455; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UU7vpIEOWdL0eNMIVr22ERtNoYOBOT1NOSw2MYNThw4=;
        b=xZ4Uhek58k5pY8l5zMELIeVhunGnOLnGBMHnT44nn8e27rPCYDrXwohpRFsYxYqLon
         RppL0hE15kFu4ljI9P91FeOF/3puRgtHJPAf5k3JaPY3q+9PPDdOwc1nEsddOsmUBppw
         +prDQTOAoGU5e4cTLCLyzcQKPt1hmc0BMoyZUZtQx/Ar35P8sUS2W586lfW+HgXTPrH+
         RVb7imdfud+irBeQKLj2m7QS40Jtf1mm0AtRN9bYO6K15KxtcXWpcUopHAWcG4CgYwWb
         pn2QzAgowIHE69qofZbjTZBc/hDlUxePuo67gllbWpU7TGXYHq5Cx6jsfYpfVSBeRAVB
         03IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706863655; x=1707468455;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UU7vpIEOWdL0eNMIVr22ERtNoYOBOT1NOSw2MYNThw4=;
        b=uZ0+cfU9eY9h7tPvhKTARHKS8XGLrKHmvBcfpDXx3shQZCKyEx/X5ULpx/s5QoDo1R
         4LvYMMD2Gr/sFlZWdMzdV06HWN70iWbmzSpK51ZiqwWu8SE2asBlTp25LZ5HCDjoN5SL
         R60UxJgzOytqoiUrGXA9p8QB3kb0wa1uZpoL4nkf5u61qQldqy1U15vvYvTB4AzxWHFn
         uA+4jNzRNdVDzR/pPLyTHbUx5fU0qEAMjpKHx/e2FajZsF8lEG4b67eBngsJguV46Hpr
         YhT0BziYXwm06ff04AaG82ogNT1DN/snfmRu3s7Mg/WyFfZJsutjx2q847JevTQQbrNC
         JbbQ==
X-Gm-Message-State: AOJu0YzBpivlStxOsL0OyWU/JHx4tmp7z5Mi5wHiuSpHCXThWkhDzUPy
	2lwn63s+VwWk3iWuO217eMz+hZrS/Kgib1URsifOCYDzE65Fwdl1U89ZsSCDxvs=
X-Google-Smtp-Source: AGHT+IGVHVbNZmhYQYVfyePv44qYjb5PPl8mmxSRJulBwcvo1VFvBGlYYT9E3lEzAdxIKl5CLgylgQ==
X-Received: by 2002:a05:6402:353:b0:55f:84a9:9000 with SMTP id r19-20020a056402035300b0055f84a99000mr4779574edw.3.1706863655200;
        Fri, 02 Feb 2024 00:47:35 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCV3ZID9R5HJqZMO3+DpWFeR8Cs3JOVwVQMtQGzJeHwx/XILkDBRfT9e8ocmg+df6JmNMfWY0XJmeoYazqDNNcfZRNhnSAMdS+vJ8BJVeNlq2xdHf/XjihNgR4qz5aTcO5JrVxa4N0NcdBqtgQMkt1+/3mUq8yhEvu+Eg7Zn5nLp9ki11iuux4xx0mgc/vdLPefmGSw264NxmD/4qTvxsnE8JLrmTgGCEZRowYpboQfXfQE5HyOSBFZLHcmO6ZkPgOgJTk4ddiTu2NYy7s3HHzxgjixFMmFnEmPwjYq42BwsLIryKiWWY4fN5zYNmACwFV/jMLwKmkSZIhZQS/Wiyvd0HhK+sk8FyUTDCaSnqm313T5S3FMipqbOtARb1X8NxcpV/rqYwj12OlEEKTtu5BvoUXqLvPMwhe0yHPUQjqGZl8IIFjo2zM5Wlu4TkSQnGeXEy2eQoGVaR3ep6jA1PEvFYn+g7xJRXJj5yisSuzJr+VkZETe75l/UDXFlUx1ATxwo4OYCgw+cPcMa1mhO3ShJ5s2JkDqnoKXyClmKAdFvtgbz9aomdQ2PnpFiGPxi9bJ4EVfaQrwQcme3x/qnF28pHtmS5i1mZrUpWEcMwjfm4HqDXbLxffMpY9wTX3XwCQLUX1VPXV1iJcNBUZ4BZZhM8nBNhIUoE6iZbpp9LbpteJ9ftfD6yjg7Ke11jkWMBYimUrvpTYjOGED7VsfsMw5/vDiCDCHzcomytbb87u1unnwqPZ2mS0GI7a5dQjNUSWrT0mkCTktTBA9alkPfeClAQMzJkntduc9ETpnNecdNzoJlNfclm8K7JCQnVaOKBMjzLWHaplwJjYFUz4Us839dlBZ4Gy7kHRJTwBQLuu46fqN2piUGkIkeLtDS8yvbUnS9p7wVZ1mAaq6O+qbHiwUaLy6weSAg5MxrJwLcIVlaG/82XYtsnEr8mNsa9D2wByM/Xn
 XBE0mN8ItoGTxZOt642QrMnqj57B4yBqR46p4bpN3BGxmR6b4mvK0raP/rnLOeuhw8rbd/DP+TV1plHwvguxPPKxfzjE2vbibOkJT67WpWmZy242jHsAhsexEllqmy3gAmQmfI+l/H+FZM606dNfyKeb37eTx5l1rz4a9ciueY2w9ohPXLWWr5J762fPLxWvYYXnbF6ewcWWKP8SK+c8gEJwXoX9oeVFCgTch287/uDO8GtogzppODfJ8oxs7d/f6zuq4xrebdlyJxoqh/ni6J
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id ek23-20020a056402371700b0055ff9299f71sm246348edb.46.2024.02.02.00.47.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 00:47:34 -0800 (PST)
Date: Fri, 2 Feb 2024 11:47:30 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	daniel.lezcano@linaro.org, miquel.raynal@bootlin.com,
	rui.zhang@intel.com, lukasz.luba@arm.com,
	support.opensource@diasemi.com, shawnguo@kernel.org,
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
	linux-imx@nxp.com, andersson@kernel.org, konrad.dybcio@linaro.org,
	amitk@kernel.org, thara.gopinath@gmail.com,
	niklas.soderlund@ragnatech.se, srinivas.pandruvada@linux.intel.com,
	baolin.wang@linux.alibaba.com, u.kleine-koenig@pengutronix.de,
	hayashi.kunihiko@socionext.com, d-gole@ti.com,
	linus.walleij@linaro.org, DLG-Adam.Ward.opensource@dm.renesas.com,
	error27@gmail.com, heiko@sntech.de, hdegoede@redhat.com,
	jernej.skrabec@gmail.com, f.fainelli@gmail.com,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH v1 02/18] thermal: Add new structures and
 thermal_zone_device_register()
Message-ID: <e4359d2c-e686-4a97-9d21-d10908e9df61@moroto.mountain>
References: <20240130111250.185718-1-angelogioacchino.delregno@collabora.com>
 <20240130111250.185718-3-angelogioacchino.delregno@collabora.com>
 <CAJZ5v0jzaGpK8LnsFDtjuPoURrwrUgM1Z2QfZhK_FUzDeK3wcw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0jzaGpK8LnsFDtjuPoURrwrUgM1Z2QfZhK_FUzDeK3wcw@mail.gmail.com>

On Thu, Feb 01, 2024 at 08:24:15PM +0100, Rafael J. Wysocki wrote:
> On Tue, Jan 30, 2024 at 12:13 PM AngeloGioacchino Del Regno
> > diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> > index 65d8f92a9a0d..7a540b746703 100644
> > --- a/include/linux/thermal.h
> > +++ b/include/linux/thermal.h
> > @@ -149,7 +149,8 @@ struct thermal_cooling_device {
> >                         passive trip point.
> >   * @need_update:       if equals 1, thermal_zone_device_update needs to be invoked.
> >   * @ops:       operations this &thermal_zone_device supports
> > - * @tzp:       thermal zone parameters
> > + * @tzp:               Thermal zone parameters
> > + * @tgp:               Thermal zone governor parameters
> >   * @governor:  pointer to the governor for this thermal zone
> >   * @governor_data:     private pointer for governor data
> >   * @thermal_instances: list of &struct thermal_instance of this thermal zone
> > @@ -184,7 +185,8 @@ struct thermal_zone_device {
> >         int prev_high_trip;
> >         atomic_t need_update;
> >         struct thermal_zone_device_ops *ops;
> > -       struct thermal_zone_params *tzp;
> > +       struct thermal_zone_platform_params *tzp;
> > +       struct thermal_governor_params *tgp;
> 
> I agree with doing a split here, but I'm not sure about moving items
> from the arg list to struct thermal_zone_platform_params (as mentioned
> above).
> 
> Also the naming is quite inconsistent.  IMO it would be better to call
> the first pointer "tzpp", rename struct thermal_governor_params to
> struct thermal_zone_governor_params and call the second pointer
> "tzgp".
> 

The names "tzgp" and "tzpp" look almost identical at first glance.
Could we increase the hamming distance somehow?

regards,
dan carpenter


