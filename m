Return-Path: <linux-kernel+bounces-66185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C8A4855842
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 01:18:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE9991C223C8
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 00:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1C80A50;
	Thu, 15 Feb 2024 00:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e06LkZy1"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89BA919A;
	Thu, 15 Feb 2024 00:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707956307; cv=none; b=FQL8l6FQi65Lk2eE1X/GbMD7caOLgq/zddj7dGEaUXnQM/IP4sq+Xp7ZfHxHvdj1SBALvPw3AgFYRd1VCyjWbGbOK+jdKK0f8zh+Qw+lx61/5d3y9HzET9tvd/cyEUYebqTskkxUfYEH5q7eJzol9BS45h1VeoVfOdoSpamEA2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707956307; c=relaxed/simple;
	bh=5/2H0Yqj5KqIJzkLAajFyEjqEW/tttRMNXtirbDNtRM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vs5WS7BnmuEtgfVwNCNoWv4O4hyBIqYGDiYdIT42528dGUgPoJoBox5ZACtwqnejnxgBeg2Q3LXe3JsmPyct63JMOPh8WQTHMAwXrppACN95/fbs77BaOxxAUyjSMNuQ0rMCBluCtygFiO3+cdlTwY3+NLrQC9wuBo/3uxloKSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e06LkZy1; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-561f8b8c058so2714001a12.0;
        Wed, 14 Feb 2024 16:18:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707956304; x=1708561104; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MDUiP0CfrdH82XvRhUToTU8I51WwH3NDeo9Oz8FL4D8=;
        b=e06LkZy1V8aT7dyUItJRivubbO4/d7E7v+6FB1mSYwdUKyRhYAwE5iguWHaBnW2D+o
         xk0FhPzJp4GWL7neBYGiQc1XhSpXOfre92x7SKh3NEyAz50kwvNXelotNxsdfn30y6sg
         98FDazKLMzzgzMw1iNt2rqz7umW5EKv/evueEdZ1r+JyToPADhzkkuWKTyzIXhSkphq5
         IA6xLWdMIYNxEPsZ/DncgNi18qMEaxHJA2EB0yn+xy5rNsXv/zg3KybEMRvZCK43DxMj
         lSgNqSxQNou7dQMpUEGn+qaWMb4082BMoWPhrl3SdOCAhbGnVYlqEo3EN0bLrUhQ2ICw
         tPag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707956304; x=1708561104;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MDUiP0CfrdH82XvRhUToTU8I51WwH3NDeo9Oz8FL4D8=;
        b=uvX5udYFK+kfLlgYg8bd4PB6lYOVGBazZL585LNuMKm8rTtaJPUmHkl4P9z7GKuabc
         25Mwo2y+GxA9vdx/VcfaafRIEt9SO6Ow0A3esr64Yh2g679nuN3zOfuco+aiVdk3Wboa
         8qAPVfuJ8S/ogwYZhToCHwVPWwiQC7wVXKj14IanIvSGe4+zJbNEUZwpZH0oVwxs2PfH
         vs42yX7oHxTlvtBfHL2UsqNI7/ZCmPKK0wzQV8GiZYyzen+tmIxdLBfKc8h0XDQUe5FP
         0Ckdw1S7W1LZrfboHWdFwf6yTBEiTsnFZ+mEdK0y3hNCEDi7rZYhUuwXE/kGT9/wh0wh
         PluA==
X-Forwarded-Encrypted: i=1; AJvYcCVY6qYnVj5vAawqHTkLpm9DtEJWJRv2gzEwrMd4lIRNeZbKaPpSkGxidmD06svElwPNBJwygwyiz6vHJdK5T8JJEGNiWZksvkO1+H+6
X-Gm-Message-State: AOJu0Yw+C0juD0tQ9XbVAp5ApNQdc8OlKLrsI8B3BoMo2Feji8VFUeVz
	fiAa/PmGJnUQjR8bz2GJ1CJmLyw0dZZJavzgHRLmhGyvRovf6kT9
X-Google-Smtp-Source: AGHT+IH1G+2dH7b67vZbhBNISgxs9hbXighfMJVJw23PIg7yKCCD6bszYiYZx56T7FTg5kTlnYvknQ==
X-Received: by 2002:a05:6402:528c:b0:55f:d6b9:245f with SMTP id en12-20020a056402528c00b0055fd6b9245fmr3479932edb.6.1707956303756;
        Wed, 14 Feb 2024 16:18:23 -0800 (PST)
Received: from skbuf ([188.25.173.195])
        by smtp.gmail.com with ESMTPSA id u13-20020aa7d98d000000b0056394048da7sm45609eds.7.2024.02.14.16.18.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 16:18:23 -0800 (PST)
Date: Thu, 15 Feb 2024 02:18:21 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Pawel Dembicki <paweldembicki@gmail.com>
Cc: netdev@vger.kernel.org, linus.walleij@linaro.org,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com, Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 05/15] net: dsa: vsc73xx: add structure
 descriptions
Message-ID: <20240215001821.5ze77fdr5wuipudd@skbuf>
References: <20240213220331.239031-1-paweldembicki@gmail.com>
 <20240213220331.239031-6-paweldembicki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213220331.239031-6-paweldembicki@gmail.com>

On Tue, Feb 13, 2024 at 11:03:18PM +0100, Pawel Dembicki wrote:
> diff --git a/drivers/net/dsa/vitesse-vsc73xx.h b/drivers/net/dsa/vitesse-vsc73xx.h
> index fee1378508b5..99c5c24ffde0 100644
> --- a/drivers/net/dsa/vitesse-vsc73xx.h
> +++ b/drivers/net/dsa/vitesse-vsc73xx.h
> @@ -15,7 +15,15 @@
>  #define VSC73XX_MAX_NUM_PORTS	8
>  
>  /**
> - * struct vsc73xx - VSC73xx state container
> + * struct vsc73xx - VSC73xx state container: main data structure
> + * @dev: The device pointer
> + * @reset: The descriptor for the GPIO line tied to the reset pin
> + * @ds: Pointer to the DSA core structure
> + * @gc: Main structure of the GPIO controller
> + * @chipid: Storage for the Chip ID value read from the CHIPID register of the switch
> + * @addr: MAC address used in flow control frames
> + * @ops: Structure with hardware-dependent operations
> + * @priv: Pointer to the configuration interface structure
>   */
>  struct vsc73xx {
>  	struct device			*dev;
> @@ -28,6 +36,11 @@ struct vsc73xx {
>  	void				*priv;
>  };
>  
> +/**
> + * struct vsc73xx_ops - VSC73xx methods container: pointers to hardware-dependent functions

The netdev coding style still sticks to the "80 characters per line" rule.
I can't find other deviations from this rule in the driver.

Maybe you can cut down on the boilerplate a little bit. Like:

/**
 * struct vsc73xx_ops - VSC73xx methods container
 * @read: Method for register reading over the hardware-dependent interface
 * @write: Method for register writing over the hardware-dependent interface

> + * @read: Pointer to the read function from the hardware-dependent interface
> + * @write: Pointer to the write function from the hardware-dependent interface
> + */
>  struct vsc73xx_ops {
>  	int (*read)(struct vsc73xx *vsc, u8 block, u8 subblock, u8 reg,
>  		    u32 *val);
> -- 
> 2.34.1
> 

