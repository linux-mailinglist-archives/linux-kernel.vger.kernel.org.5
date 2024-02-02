Return-Path: <linux-kernel+bounces-50221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35EC28475E2
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 18:13:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7A261F23FA7
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 17:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD8BD14AD13;
	Fri,  2 Feb 2024 17:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GpidqCUY"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6F214A4E9;
	Fri,  2 Feb 2024 17:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706894000; cv=none; b=PB8TwYQp8mG9/tio9Wnfg0TVZ6CfW4YyuoWcLUb7j0MQwcfrlLoU22WBnAmiAFJCB+e0ZuZb7Chlnj1koQ+4qwnez/qdwICC/tZrRrgWPipnkidbQ4LmA+45994GQxfNm75pD9c/SIMqPUyIlzny60GeP/sRwVqkN5CZEEa62RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706894000; c=relaxed/simple;
	bh=8c6EpFuSL/RCfyj8FhDfnXzj0voM3VashKovRfGqikU=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gSezZnbFI43qGWMS1hX3ZdcpccBT6xMkfVVzis00QT2bp5fABZxUCRN1yvgUFygaNl/T1g62fgttyHendJVXLweKUPV94wy0RsiwXitFNXyJrs9EzWakAWLbu7LpIxt10ExVO2CbqkdxrlFSA/SHUcuLujRQFxhhZ9gERe8whZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GpidqCUY; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40fcb6ebe24so3690035e9.0;
        Fri, 02 Feb 2024 09:13:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706893992; x=1707498792; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=w5nhOibo/PIgA624XGefYyKKp7xyU3/pWyQClEA0ccA=;
        b=GpidqCUYALDEN4LVVBTG9vR5Afbom1eQSOGAxL08yH6fqlwtg2bA6d/mF+MkyLw9FW
         Th1cfvx//ixw6rZlpv8TTbml/Gc0lneXMM0e2wUzg4ESd3R9zVHJ6rMal/E5iqauwSeI
         NP/9GsQAlAc1ZNuRh/nJjX9KPvZcbb83CrlXcCw22vBM2JI9XQa1u/evVDOVu9PwsxTs
         PJthdxqpjEucVqlLZ1+92o3oPGIad962mdxUCy18GjSRmKVfQ6P+tWuMkC1Lg+rIft4M
         mzpfzYtekuVyeh+3GsSRptaiHf5T1GcgsIq/DkM1Ica4c3RVSE38hgkLgMk7dK3uiLFc
         2YIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706893992; x=1707498792;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w5nhOibo/PIgA624XGefYyKKp7xyU3/pWyQClEA0ccA=;
        b=EXe3xh3yl8XJULr2/yeEi4S18IATiFFZo6brRaK7gH/5QN+kmPmFZfgxzD1OmOAN+A
         tckJHXTfyYjtgUHp1sWRgrv80BC+0/hE+I/QnXaTgMkk0+fGAXS9DgLL3O6gWF8LVKyd
         5TSuHL7ORvA0cuIsBb2Gd8Qd8KzqlsOAcSzt8zV5zGje9bA9qAhHqW4B4xW7bafbKEeI
         h/YFHgjFpOeJWcRNd8J0mGXG7tJiXro+TYUrcfQ6+dS1bhMpXDf0wNkHYyAa0BeGX6Vf
         6lI0fLv+Ymc5iZ8urasmI4J0+Mx9DQ/wgHwUxyKnOLKYW6EuvXVnUvEeldHUvGeEAOvl
         BKuw==
X-Gm-Message-State: AOJu0YwJnZDXvjj1+JG5YwDum1/rwk4iVFsVxs1osthwCI5YqxF8uxj+
	zLjl0nxSpavvodaJac6FQ9MwGFdJsAapHcQGSBtot8NpbzkX05FA
X-Google-Smtp-Source: AGHT+IENpzsVWWWp51ExAgYEKKZAwBks2nkSTfruZeJSPkfyAxKIpKRuxHSRbEhcU/GRyf/mNdiStg==
X-Received: by 2002:a05:600c:3110:b0:40f:b772:c37c with SMTP id g16-20020a05600c311000b0040fb772c37cmr5118335wmo.31.1706893992093;
        Fri, 02 Feb 2024 09:13:12 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXqTf4U+29R5VScw69iqcfqY4TUSJsaI6YeRW+S4WWB61TsvPJW4hEk3WZd0rgYA/KDdl3JgIqSZGY9ttMdMftyxVJhrZLj+aHAr9quiIUQgFHuTleOpASwXOWRGxBXiZ22WCwf71DN3rbV5jzJxk84eylvtK3JH1AkNrwd5PeMGS9iZnu7rVmhVtk2gVDKzfbmXlUFQ4Xag27VYP6OMhsQ9TFE6FyG0SgMXysclky1/RAEZjFAL0m2jPLzHxYobqiMiRBQeAR0hy6Sks4TLG7QOBuTJyB1Z9fJyRYpWyceAeA3FScCCKs3NVYF88sy0RhVixZ0spGfHSmjz8CxNDGaaYShgt1dF+UmDOeJ3LYIU/pXvkdewehXV7e6xxpzxuNEWjnuoi8cIoHV2bUopLttCVvwryja566ozmylAKnzuPIyVVfwpOjvUP3YQcBWR5VrT5gFTY0nNJ+IwjCrqNdcwEO7/NYd442br3Z+L8jPPpUB92RGoZwMB9NEu4jq21q9G+9FIwNZEOMbfDHxbquzDC6Ux0FkgOyHAieyttI4KZdc46FYngv5xpo5zHgEnV2FBg==
Received: from Ansuel-xps. (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.gmail.com with ESMTPSA id r2-20020a05600c35c200b0040efbdd2376sm441610wmq.41.2024.02.02.09.13.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 09:13:11 -0800 (PST)
Message-ID: <65bd22a7.050a0220.39d07.2fd4@mx.google.com>
X-Google-Original-Message-ID: <Zb0ipFb8y6gzMH1A@Ansuel-xps.>
Date: Fri, 2 Feb 2024 18:13:08 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Frank Rowand <frowand.list@gmail.com>,
	Robert Marko <robert.marko@sartura.hr>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: Re: [net-next PATCH v5 9/9] net: phy: qca807x: add support for
 configurable LED
References: <20240201151747.7524-1-ansuelsmth@gmail.com>
 <20240201151747.7524-10-ansuelsmth@gmail.com>
 <46085abf-8e82-4fd9-95b8-95cbfde6e5c2@lunn.ch>
 <65bd1af9.df0a0220.c0618.9f8d@mx.google.com>
 <8bbff46a-f316-49b7-82f8-44dbdd452b0d@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8bbff46a-f316-49b7-82f8-44dbdd452b0d@lunn.ch>

On Fri, Feb 02, 2024 at 06:08:33PM +0100, Andrew Lunn wrote:
> On Fri, Feb 02, 2024 at 05:40:21PM +0100, Christian Marangi wrote:
> > On Fri, Feb 02, 2024 at 02:43:37AM +0100, Andrew Lunn wrote:
> > > > +
> > > > +			phydev->drv->led_brightness_set = NULL;
> > > > +			phydev->drv->led_blink_set = NULL;
> > > > +			phydev->drv->led_hw_is_supported = NULL;
> > > > +			phydev->drv->led_hw_control_set = NULL;
> > > > +			phydev->drv->led_hw_control_get = NULL;
> > > 
> > > I don't see how that works. You have multiple PHYs using this
> > > driver. Some might have LEDs, some might have GPOs. But if you modify
> > > the driver structure like this, you prevent all PHYs from having LEDs,
> > > and maybe cause a Opps if a PHY device has already registered its
> > > LEDs?
> > >
> > 
> > God you are right! Off-topic but given the effects this may cause, why
> > the thing is not const?
> 
> I would like it to be, but its not easy. There are fields in the
> driver structure that phylib needs to modify. e.g. mdiodrv.driver gets
> passed to the driver core when registering the driver, and it modifies
> it. mdiodrv.flags is also manipulated. So we cannot make the whole
> structure const.
>

Maybe the ops part can be detached and just that made const? (and
introduce something like struct phy_driver_ops)
It would require a big conversion but assuming nobody adds OPs in probe
function everything should be static and easy to convert.

-- 
	Ansuel

