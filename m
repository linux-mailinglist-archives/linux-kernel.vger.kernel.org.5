Return-Path: <linux-kernel+bounces-138886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E22989FBA8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 17:33:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F5F31C21465
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 15:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10D9B16F0EF;
	Wed, 10 Apr 2024 15:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LytFKXN0"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8779816E87C;
	Wed, 10 Apr 2024 15:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712763164; cv=none; b=JrjeLH5Yi3xaiq3bsurrugT84PDAe/5erbcjaxXUIhoYCeJeOUthnvCSzV5fTmWKidUrExCEmBQnncGyS4SymflUP77XG0K9M/HGOEHh3aT/wWIsqcGQQdiGwgymEHpNqZqoB1lU1dVspnBrR6E0Zxu91mDugsY21IC1926sI5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712763164; c=relaxed/simple;
	bh=aSCpDH/F4R0DSA6FAKET7AmPuGmk0OGo1JZYB3F1/M4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ngjY89NXoW1Y/mS9jYUvZfxo7qgdrIF8KdA85qscHZEgYXOrdWdwQ92oMybVEeyCQqX0zwN/K1Y/JLgTWHTaCbpeZS/CUD2udFZ784Xp5OkkQyXeJwPMVk7PnHo4zdcya9jubpxCgkezufWL1RGua6b/EMYFtL9GiAldBtuL+M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LytFKXN0; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a51d05c50b2so456946466b.0;
        Wed, 10 Apr 2024 08:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712763161; x=1713367961; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NIoZdroObHcn0ilUnP99WXP7c8tNf1PTNXOqonjBdzs=;
        b=LytFKXN0RLSc3GaL7m7WMMMsS/OnROeV/7t1EjlE5NNdfnxev7Sydk2DjxrdEJnkid
         nADG0cILZjGe+LGXfSgedBPsTkR6Ircv5FcgouTQjuL3XtO2mPoKxdChOSX41dyMpfhW
         mWpalYBHHeku+QL2/mgCI2d2GqhQPtMxkYyGuvT2Ri4r6u1qwao1/8rdBTD9FV8pjbrT
         m3MH80mlbqw9dTGpuua9sF4bwym3qwSaeM2PzggqjCr4Z4CXz4aQf6y0HI1sV8FEPzzD
         L/uO06b0KJCbX6qFcR+w41Ba/2mTslxj8LM68S6niOeLGh9yT5XprS36WahIQ+lAtwZc
         D6Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712763161; x=1713367961;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NIoZdroObHcn0ilUnP99WXP7c8tNf1PTNXOqonjBdzs=;
        b=j3gdAr4BxrAbrpelcH59977iL5rVXhSsVPO5he/M+CZLFHilhG9BimkTa1W1YHSA8G
         SywAjG+hPqEnKUyqIB5cIY8MoMqHjVaF1Vb0Dmmv83fv5KF8I+fL7qUIYjMVxbJadjlf
         aQLrJRsd0u7mCAnlSBqKVmpkegj5qE+o/d6hhSeqNqHoJXgbYVgunguuLRq8vLq18Klx
         1HW+OhqTFVSp4NGVgHkqU+YTYWUG9RmfJ1M2B7XeLJn0BwFPIE0iFws/SKHlhheTJTSz
         IIBzydjVzayiwONItTykK+ZLDKI/UvpzQghjbJWRVM44FtAIg3GJZpUCmxzvVRTDNDUR
         fbYw==
X-Forwarded-Encrypted: i=1; AJvYcCVbMU4pe8wg5L2C/NLYmQF65HSpG035IyBgKqmNtjVmrybcaHJFFYQbL0vxPzLgr9EoBY1HyulBeVNycy8yRiPSWtqxDKu2hsETcar2rSbGkn1AQIeOYrs79f2CNl3ruKm68FNs
X-Gm-Message-State: AOJu0YwEe3ur/KaCi9irEvTecv6Wgc0oCWLm3H5gEe2ni32s5I8gGx8V
	Q9vynxGRG9JE9o7so0WHFNVQz3fvwwqYAPggQiJrAzURV0Tf0wCs
X-Google-Smtp-Source: AGHT+IFCvCk24d1vqHgUtpGPRpXznj4t6uQg0+kcFcV3Q2ZHEsnQlRvc/21H7pZ+1pW4Fa8GmM/QZA==
X-Received: by 2002:a17:906:8308:b0:a4e:390f:c6ce with SMTP id j8-20020a170906830800b00a4e390fc6cemr1669666ejx.65.1712763160458;
        Wed, 10 Apr 2024 08:32:40 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d201:1f00::b2c])
        by smtp.gmail.com with ESMTPSA id bv4-20020a170906b1c400b00a51e452fe0esm2750028ejb.170.2024.04.10.08.32.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 08:32:39 -0700 (PDT)
Date: Wed, 10 Apr 2024 18:32:36 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Arun Ramadoss <arun.ramadoss@microchip.com>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com, David Ahern <dsahern@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	=?utf-8?B?U8O4cmVu?= Andersen <san@skov.dk>
Subject: Re: [PATCH net-next v6 5/9] net: dsa: microchip: add support for
 different DCB app configurations
Message-ID: <20240410153236.d3ncotfhzwv4dlb7@skbuf>
References: <20240410080556.1241048-1-o.rempel@pengutronix.de>
 <20240410080556.1241048-6-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240410080556.1241048-6-o.rempel@pengutronix.de>

On Wed, Apr 10, 2024 at 10:05:52AM +0200, Oleksij Rempel wrote:
> diff --git a/drivers/net/dsa/microchip/ksz_dcb.c b/drivers/net/dsa/microchip/ksz_dcb.c
> new file mode 100644
> index 0000000000000..d2122f844c80b
> --- /dev/null
> +++ b/drivers/net/dsa/microchip/ksz_dcb.c
> +/**
> + * ksz_supported_apptrust[] - Supported apptrust selectors and Priority Order
> + *			      of Internal Priority Value (IPV) sources.
> + *
> + * This array defines the apptrust selectors supported by the hardware, where
> + * the index within the array indicates the priority of the selector - lower
> + * indices correspond to higher priority. This fixed priority scheme is due to
> + * the hardware's design, which does not support configurable priority among
> + * different priority sources.
> + *
> + * The priority sources, including Tail Tag, ACL, VLAN PCP and DSCP are ordered
> + * by the hardware's fixed logic, as detailed below. The order reflects a
> + * non-configurable precedence where certain types of priority information
> + * override others:
> + *
> + * 1. Tail Tag - Highest priority, overrides ACL, VLAN PCP, and DSCP priorities.
> + * 2. ACL - Overrides VLAN PCP and DSCP priorities.
> + * 3. VLAN PCP - Overrides DSCP priority.
> + * 4. DSCP - Lowest priority, does not override any other priority source.
> + *
> + * In this context, the array's lower index (higher priority) for
> + * 'DCB_APP_SEL_PCP' suggests its relative priority over
> + * 'IEEE_8021QAZ_APP_SEL_DSCP' within the system's fixed priority scheme.
> + *
> + * DCB_APP_SEL_PCP - Priority Code Point selector
> + * IEEE_8021QAZ_APP_SEL_DSCP - Differentiated Services Code Point selector
> + */
> +static const u8 ksz_supported_apptrust[] = {
> +	DCB_APP_SEL_PCP,
> +	IEEE_8021QAZ_APP_SEL_DSCP,
> +};

I've no idea how kernel-doc is supposed to document arrays. But this
generates a scripts/kernel-doc warning:

  CHECK   ../drivers/net/dsa/microchip/ksz_dcb.c
./drivers/net/dsa/microchip/ksz_dcb.c:81: warning: cannot understand function prototype: 'const u8 ksz_supported_apptrust[] = '

Worst case, it doesn't need to be a kernel-doc?

