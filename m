Return-Path: <linux-kernel+bounces-133222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01DD489A0C0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 17:14:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7FE7283ABE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 15:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C5CB16F851;
	Fri,  5 Apr 2024 15:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dK9l+6jq"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A41343170;
	Fri,  5 Apr 2024 15:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712330046; cv=none; b=XA6tsE1EtO4h+7Fm4jKvR8uEobSuX2GjOgX8A6FEDW+OOMBR3RyBLJLHspEY4vt/W8NpXBvyTEFUIEonsepkzpIaUFE0qGPkTBEh6JBPEVEJ5iMkDXplGtLavXGFI4bQEaB4WVVHD/lN2EMkO1v7mekhZx4IVaIWlh/aWbtbyNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712330046; c=relaxed/simple;
	bh=iwj0KP+eanKsQzXfz4LZn/8GeEnuSPo+VMKDJLnxQ2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pt8ApqLKFPNUGYlLeP1A+DKiOtQ9erG3NuDlCGEtrSj58Z+YMruVnDLMws8+oKyCWn6vAm4gQXELpmtam/nX/hQRNpcYEDho5X6ULhuun9DCGe3FhOpbHzVzWGdRmxd9gPxUsOUVV3fSYdLe437Y4/2B0vYA9yDjqTQCRIuUGEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dK9l+6jq; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-56e0c00e7fcso2629068a12.2;
        Fri, 05 Apr 2024 08:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712330044; x=1712934844; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cW66Xi9N1jJiiCbW5+5cftF5AQ4e7QDnxMyMEgeBBJg=;
        b=dK9l+6jqI6WCpO1EXPkADspupHr2IK5YfXtNThm72Hjh6qrJut80XmaBR/y/0Mv4GD
         bfcBb8KQ/EXzw/uqhoi8r/RiwTmSVncMVRIzUt2l+vmWxPl4A/XfDEyeu+mM80HOteL1
         ZWx8hnVDdWGPb1/N3IuPaY/g62wSEAIVw2FGUDp1zwqzoVFHtuI47CaNtm9cXKLZ3rv+
         qo6AgGAvtDlJEFUCTicJi6a1huQJQgfu29juImatsUmpFvD9+lzig7Yt3mf51nab1iYj
         hd1LWkNrYAl5dDtmLeiz1LeB11qx90ceHrbunadzgMSk89OyPuurr5BjZvM/3qWYEMAh
         5enA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712330044; x=1712934844;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cW66Xi9N1jJiiCbW5+5cftF5AQ4e7QDnxMyMEgeBBJg=;
        b=pBNhF5AQDl+6dXhHrZuR5cfCdiNadZPdB224hM+XC9iKNd1qnYg3qPsrdlFFA5Li9M
         0UiIvwXTnBI8PS06w1vSxOrVb0qbK/D4w27f8UAiI7ttf9Uvfj+tjUKz5kB/nOba7KBI
         X/uIWbkx+A7aI0ACF6yTAceAA4h6cwrg8jctTY/2ZJ40sUHA3TZK1IcfumTGJBiZ25pN
         K2ABiIHvT73RPrnw1pZ7QBhQjBfk4FwAi4AbEC5n3rJvuAiQEaDTlzMsI5cOWNkAM5LS
         uPGW2+S2W+tSz6eRQzMIg0RenKYgsxQvHsaLhXcN8dXL9Yt9Em8nsJCo7gwcYcNggzUS
         rzkw==
X-Forwarded-Encrypted: i=1; AJvYcCUYZHNlqgRsF31vlWZZYNCvT/UUzq7ULplxKhtIhE7AhZU65JFbDVhj4lYgy0IIA2ttsgW5PJhQLtVknY0MX5V+3bTdWeOb0JvuJdZh
X-Gm-Message-State: AOJu0YylXxYGz51YjhgNbTN8b39YGqB0LdpLl/8dgnz8ZXQcZIqfK9wm
	s1hDkunWhKZaq7eERjkNv7Jqtlzhpu8casXByronDQn+4qRPWD1N
X-Google-Smtp-Source: AGHT+IGf6gsO6qok4Nna0hC54XT64mpjfs9iUxB4KTpAuEkyHm9kRwvOf3KZdMSyoJMxH72kh56D0A==
X-Received: by 2002:a50:8acd:0:b0:56b:9029:dd48 with SMTP id k13-20020a508acd000000b0056b9029dd48mr1207020edk.5.1712330043498;
        Fri, 05 Apr 2024 08:14:03 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d700:2000::b2c])
        by smtp.gmail.com with ESMTPSA id o9-20020aa7c509000000b0056bf6287f32sm883472edq.26.2024.04.05.08.14.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 08:14:02 -0700 (PDT)
Date: Fri, 5 Apr 2024 18:13:59 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Pawel Dembicki <paweldembicki@gmail.com>
Cc: netdev@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
	Simon Horman <horms@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com, Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v8 13/16] net: dsa: vsc73xx: Implement the
 tag_8021q VLAN operations
Message-ID: <20240405151359.3kuawi4ylug6ryfc@skbuf>
References: <20240403103734.3033398-1-paweldembicki@gmail.com>
 <20240403103734.3033398-1-paweldembicki@gmail.com>
 <20240403103734.3033398-14-paweldembicki@gmail.com>
 <20240403103734.3033398-14-paweldembicki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403103734.3033398-14-paweldembicki@gmail.com>
 <20240403103734.3033398-14-paweldembicki@gmail.com>

On Wed, Apr 03, 2024 at 12:37:29PM +0200, Pawel Dembicki wrote:
> @@ -756,6 +756,12 @@ static int vsc73xx_setup(struct dsa_switch *ds)
>  
>  	mdelay(50);
>  
> +	rtnl_lock();
> +	ret = dsa_tag_8021q_register(ds, htons(ETH_P_8021Q));
> +	rtnl_unlock();
> +	if (ret)
> +		return ret;
> +

No dsa_tag_8021q_unregister() in vsc73xx_teardown()?

Also, a bit odd placement, while the resets haven't all finished (this
falls in between the IP multicast flood mask and the PHY resets. It
makes future refactoring of the other code harder.

Additionally (and much worse), even later in vsc73xx_setup(), you clear
the VLAN table with portmaps of 0. Doesn't this wipe out the
configuration made by
dsa_tag_8021q_register()
-> dsa_tag_8021q_setup()
   -> dsa_tag_8021q_port_setup()
      -> dsa_port_tag_8021q_vlan_add()
         -> dsa_switch_tag_8021q_vlan_add()
            -> dsa_port_do_tag_8021q_vlan_add()
               -> vsc73xx_tag_8021q_vlan_add()
                  -> vsc73xx_tag_8021q_vlan_add()
?

