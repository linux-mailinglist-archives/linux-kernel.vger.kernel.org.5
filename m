Return-Path: <linux-kernel+bounces-14906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67215822463
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 23:03:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3E8F283D2C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 22:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52FFC1803D;
	Tue,  2 Jan 2024 21:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ERCXYkmD"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15DA81802D;
	Tue,  2 Jan 2024 21:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2ccec119587so39886251fa.0;
        Tue, 02 Jan 2024 13:57:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704232669; x=1704837469; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZrAMhCdZp/DH6n9t5/40nGjHO+BryyqAdvgXAu3yxZg=;
        b=ERCXYkmD0SYi/uUaACZWyOsk163y6DC0yQsSzONhZelq8wu5oOtPOfr+n12vBnWjiP
         w3mJ6qC5PAGao6C+8cEgG4zz0e9bRjpYzG9RCacT8R+IjZYxR52gJmhV3X8T0cWKM/b/
         KPf23vrHbBtGJbVoVGl9DYZSznt9kjYKHPu6YhDx34wrnq4Z+9v762zeM3S8N1LngSf0
         e0bxDG8qtm5rESA76khYforZC5VtqfmLASL/h3Kme/mNh9PuMgjOHP0e0YpVc5CBDB2/
         KMbiJft/H6K0VFy5OGvagLGc49tU9j7pn+K/kWXV4a5aG0cPKEFDowbRaH12YGFfkkue
         p+VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704232669; x=1704837469;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZrAMhCdZp/DH6n9t5/40nGjHO+BryyqAdvgXAu3yxZg=;
        b=MQrKBgmk1eXok/pqVET80cxO39Q+z+FtIdbiwlDkrcy77Kk+odzr8UrhZFhGpQH3G1
         5clNYviXt/QV9tvGPJc8ctVYHyw3IdSq6N+znaVPK9ChRoyI+E2WV2CTi6uGBIpt7sIq
         VUZeH19rvcMclfvGQOwRIR8QzecwhdzQUgAa/4wYYZFUH5M2sJVGTquBvZnDBv6ElvUd
         VIw6OrqIsLhTAwTjWNFvoyRx3+j9v72qsDSNSsh5Tw4zqEHA6WRCWVXsV/I15VXPnc9x
         whmUC+6CVVC6I2UXeHEjznx71306V4yByp+yJ2NjWY9EWLU5s8SFud4QwQ7jZxGjQ8mI
         fqow==
X-Gm-Message-State: AOJu0YyDIYE/Kh92FwxQ5gbkyCE/vI2ZHhivcUX6s1Y3nsZ61ai1Fmjn
	6nD+G4dWINcuEP89uTh4D6t4xHbb1dvPQJ3+c1Q=
X-Google-Smtp-Source: AGHT+IHzUSZtz+OUNX8UQoqMyVVgg5FAvazfZuxlzjRw+s9gJSPpVl5k2CigK3FMR7t54xPqnkPKcDa140v/KOzYRe0=
X-Received: by 2002:a2e:8902:0:b0:2cc:5780:6915 with SMTP id
 d2-20020a2e8902000000b002cc57806915mr8428433lji.10.1704232668610; Tue, 02 Jan
 2024 13:57:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231220045228.27079-2-luizluca@gmail.com> <ZZPtUIRerqTI2/yh@shell.armlinux.org.uk>
In-Reply-To: <ZZPtUIRerqTI2/yh@shell.armlinux.org.uk>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Tue, 2 Jan 2024 18:57:35 -0300
Message-ID: <CAJq09z61JRNOBy6zLJ+D2pOVP-FCkofLjNghHSOkFJ=5q=6utQ@mail.gmail.com>
Subject: Re: [PATCH net-next] net: mdio: get/put device node during (un)registration
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> On Wed, Dec 20, 2023 at 01:52:29AM -0300, Luiz Angelo Daros de Luca wrote:
> > The __of_mdiobus_register() function was storing the device node in
> > dev.of_node without increasing its reference count. It implicitly relied
> > on the caller to maintain the allocated node until the mdiobus was
> > unregistered.
> >
> > Now, __of_mdiobus_register() will acquire the node before assigning it,
> > and of_mdiobus_unregister_callback() will be called at the end of
> > mdio_unregister().
> >
> > Drivers can now release the node immediately after MDIO registration.
> > Some of them are already doing that even before this patch.
> >
> > Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
>
> I don't like this, certainly not the use of a method prefixed by a
> double-underscore, and neither the conditional nature of "putting"
> this. That alone seems to point to there being more issues.

Thanks Russel.

At least one driver (bcm_sf2_mdio_register) is writing directly to the
mii_bus->dev.of_node and not using of_mdiobus_register(). We should
not put a node in the MDIO bus if the bus didn't get it before. That's
the reason for the conditional putting the node.

I wasn't sure about the names. What would be an appropriate name? The
same without the prefix? In order to put the node only when the bus
was registered by __of_mdiobus_register, I opted for a callback but it
might be a better approach.

> I also notice that netdev have applied this without *any* review from
> phylib maintainers. Grr.

Some reviews are required. Should we revert it?

> Indeed there are more issues with the refcounting here. If one looks at
> drivers/net/phy/mdio_bus.c::of_mdiobus_link_mdiodev(), we find this:
>
>                 if (addr == mdiodev->addr) {
>                         device_set_node(dev, of_fwnode_handle(child));
>                         /* The refcount on "child" is passed to the mdio
>                          * device. Do _not_ use of_node_put(child) here.
>                          */
>                         return;
>
> but there is nowhere that this refcount is dropped.

The same file where we have the get should also contain the put,
ideally in a reverse function like register/unregister. It is too easy
to miss a put that should happen in a different context.
fixed_phy_unregister seems to be one case where it put that node after
phy_device_remove() but I didn't investigate it further if that was
related to a different of_node_get. mdiobus_unregister_device might be
a nice place to fit that put but I'm not an expert in MDIO API.

> Really, the patch should be addressing the problem rather than putting
> a sticky-plaster over just one instance of it.

I'm trying to address an issue I ran into while modifying a DSA
driver. We have drivers putting the node passed to of_mdiobus_register
just after it returns. In my option, it feels more natural and this
patch fixes that scenario.
Other drivers keep that reference until the driver is removed, which
might still be too soon without this patch. I guess putting the node
should happen between mdiobus_unregister and mdiobus_free. If the
driver uses devm variants, it does not control the code between those
two methods and it should just hope that it is enough to put the node
as its last step.

I issue that the child node you pointed to should also be addressed.
However, I think they are two different but related issues. Any place
we see a device_set_node(), we should see a of_node_get before and a
of_node_put when the device is gone.

Regards,

Luiz

