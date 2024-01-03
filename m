Return-Path: <linux-kernel+bounces-16034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93A08823747
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 22:50:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36C59B249DD
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 21:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2318D1DA30;
	Wed,  3 Jan 2024 21:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bE7I7rp2"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE521DA21;
	Wed,  3 Jan 2024 21:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2cce6bb9b48so57363931fa.1;
        Wed, 03 Jan 2024 13:50:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704318618; x=1704923418; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aUL3qmp8YyJgWnCTGwj76mcYbxOhNMbAwT7dZHuyZLE=;
        b=bE7I7rp2ZHRU3CiKEqNmMClEw6oEJfJ8+g/soopZC78zongH3Otu/1nWacM0YJowDg
         IdDdznCojwhdeyp2i8Ypbg98d62RcgExtvSm7VuA3kDeYfFQBfVDEdpvT99PnqemOpKe
         drJD70+0OaSqhMg8OosDA60A26d0yUMKQVP2/v5nbgYtWDwK48hFledUx0ajuv0UtcRx
         CB2hWHbTuTN4MnkFSJtlQ+nWYSpJxt38XUTzyRlHLCE7yg220bSJkaWkU3f30k7Rwz8r
         Fn8TM/aqRYGEO98mh1b+8yUyVH2R9ifhvRaX69KR0VKMMuvD6XywT7glTMu6kn2SFgsn
         QN3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704318618; x=1704923418;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aUL3qmp8YyJgWnCTGwj76mcYbxOhNMbAwT7dZHuyZLE=;
        b=q2VlWJYqKCAARPkq2gb9X5jcXrsDFTT0kTqg7OAFVJOxP2IKHNCOOij1LYnIJQPA6r
         RkThbWsNwOX4JpyGoE4sadROUrbq8bPm9OHR+ureq04gUXO2WzOh10FvamihCEuQgZKP
         4cxqE7jQ750A++x+ql4TonotDRdttE9z9kVS5H6Md6SV6apw3tS9RHKQ9B9yQw0GBLFn
         P7QT/tM40O0g2FZCy0LwTcxDi9/YTFveH5kdqWkTQ+v4IcBIA049NwWC4e2CKJyarLVI
         MBIZcfZbx7CrpFhVTwvM17tX3a+Z+eclrlN2o3Jy1Pe+llG8QqKFJS3aQNS6H+7m5vsJ
         NpmQ==
X-Gm-Message-State: AOJu0YwBOw6db9BQyB4g66kvH1KoDnBQ6+7XcBomZplj5y0ijKUaK+Ar
	M46mTAy4KfkmSlE/ZTte/WtrJvUN8gs+Q3PqoH8=
X-Google-Smtp-Source: AGHT+IHDPheYVtEU2gvbcDYItqdryUAsUg7Fw8MTJXuIYUjp1Z93npevJoMlhK+cRfgkblV86K8SbtYNNXfYeFatlxQ=
X-Received: by 2002:a2e:9684:0:b0:2cc:1e7b:3612 with SMTP id
 q4-20020a2e9684000000b002cc1e7b3612mr4209336lji.65.1704318617657; Wed, 03 Jan
 2024 13:50:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231220045228.27079-2-luizluca@gmail.com> <ZZPtUIRerqTI2/yh@shell.armlinux.org.uk>
 <CAJq09z61JRNOBy6zLJ+D2pOVP-FCkofLjNghHSOkFJ=5q=6utQ@mail.gmail.com>
 <ZZU1SJlKpeU38c9I@shell.armlinux.org.uk> <ZZVMiPCoDyv/NZXN@shell.armlinux.org.uk>
In-Reply-To: <ZZVMiPCoDyv/NZXN@shell.armlinux.org.uk>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Wed, 3 Jan 2024 18:50:06 -0300
Message-ID: <CAJq09z56GmDhbZUWR_s+thOfu0WB47o66X3_Ko3KyTk44inMCg@mail.gmail.com>
Subject: Re: [PATCH net-next] net: mdio: get/put device node during (un)registration
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: kuba@kernel.org, netdev@vger.kernel.org, andrew@lunn.ch, 
	hkallweit1@gmail.com, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Please test to check that this addresses your issue. Thanks.
>
> diff --git a/drivers/net/phy/mdio_bus.c b/drivers/net/phy/mdio_bus.c
> index 6cf73c15635b..afbad1ad8683 100644
> --- a/drivers/net/phy/mdio_bus.c
> +++ b/drivers/net/phy/mdio_bus.c
> @@ -193,6 +193,10 @@ static void mdiobus_release(struct device *d)
>              bus->state != MDIOBUS_ALLOCATED,
>              "%s: not in RELEASED or ALLOCATED state\n",
>              bus->id);
> +
> +       if (bus->state == MDIOBUS_RELEASED)
> +               fwnode_handle_put(dev_fwnode(d));
> +
>         kfree(bus);
>  }
>
> @@ -684,6 +688,15 @@ int __mdiobus_register(struct mii_bus *bus, struct module *owner)
>         bus->dev.groups = NULL;
>         dev_set_name(&bus->dev, "%s", bus->id);
>
> +       /* If the bus state is allocated, we're registering a fresh bus
> +        * that may have a fwnode associated with it. Grab a reference
> +        * to the fwnode. This will be dropped when the bus is released.
> +        * If the bus was set to unregistered, it means that the bus was
> +        * previously registered, and we've already grabbed a reference.
> +        */
> +       if (bus->state == MDIOBUS_ALLOCATED)
> +               fwnode_handle_get(dev_fwnode(&bus->dev));
> +
>         /* We need to set state to MDIOBUS_UNREGISTERED to correctly release
>          * the device in mdiobus_free()
>          *
> --

Thanks Russel. It is much better than my approach. You simply get/put
during registration/unregistration when a node is defined, no matter
who defined it (of_mdiobus_register or anything else). Clean and
simple.

Regards,

Luiz

