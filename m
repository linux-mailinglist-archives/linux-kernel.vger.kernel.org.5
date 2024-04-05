Return-Path: <linux-kernel+bounces-133394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D2B189A338
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 19:09:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61C33B268FF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 17:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9979171E6D;
	Fri,  5 Apr 2024 17:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="rDe9hRhp"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24483171E68
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 17:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712336894; cv=none; b=c88ztps15Y8nESUv6jpLXpTH9dLAgYHSL0gkY8RnyAFUrb62obDHwEL2ory1+eG1/lu/2AEedb9oIVS+yR0tWuHpoXK/Xs6Uuy4mhtNEMlxQIR505nMCVxlFs/6PT5Kqdh1+X9nVRcikwbRNW4pVilsrQKuMScvSyd6zvpaz/oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712336894; c=relaxed/simple;
	bh=GMxbFhRgw5yfXi1j+ccoYRSW3nkas6eAR14+YGjH+64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kb1W51sH3GsBxW4J0NOhYVbthcA9Nn9qOprsgloIcrSjluwMQw2uvP0WWpYYU62lw5hyrNOM+mQQkiVBhldgUKttjoSpARThbuNhKminUXK07oiNVHARyWAIlhzIXE9qV+vAFKBHCl8k2nHtZt0JyV4W1XiOFrVtqV5dkM1O3M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=rDe9hRhp; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1e3cf5b171eso3104675ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 10:08:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712336892; x=1712941692;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:dkim-signature:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XnwA3IQIKVbX5TtpnpowKO0T6lwnxkQ6mM8Ph3vpATI=;
        b=aUQ04igq2tYE8rISbDh4uKoSbvJ2tjKkEOnuho/dzKOOYi5RDEu4vSyWxngSH4dOvI
         WKyv2k3SUZts5p1uR0zfI3aU9FRkNLZnciHxuwNT/YK0ikPoIX52R88nSk+0fpHyeLDH
         6+cgiexfEy8WOpYgpQJQyqNhYyAtcN5BSjhr4OZ97eiE74ni0IFs0lzed4eoSY8ZL7zO
         aVIhpA48yAyZ7Pj4DVy+YFc8S4jRRONs8hTp5B1l5H2VX1Fvw/Btes2UaTmYLSBnrJCi
         sH0+pI+V8ELXI3nRNmsqf7l+O3GqVAbA1qcjD64rvk3mb5cVHNWeTlStGs66PoRGbHQP
         GU/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUi8ksQXXmEmEYQhfgQ5No0HsIkzaRrANtNU5VqgshXKl4p7Kvm3DCrqLeK+63NywbJSBOvgkVk7B9KjB1nRvG8u31VsciTVG2mJgJp
X-Gm-Message-State: AOJu0YwWHU8c1XX390u5v5oTr/UN+TSyfqQRPOY+NgyfbQa58XZ4aYPX
	5J0+bDwbCMqYkost3XwyJZmiBNM7pPAjEatImhDgL1zu5rqP8vmS
X-Google-Smtp-Source: AGHT+IEASoP3F94AXrP/j8HTv/ikxF7pg4M+6ywVmU6cnIUTIRjvyRm3C2Ux7lJjevJhmXt0VLvfAw==
X-Received: by 2002:a17:903:32d0:b0:1e2:6165:80cd with SMTP id i16-20020a17090332d000b001e2616580cdmr2475431plr.38.1712336892391;
        Fri, 05 Apr 2024 10:08:12 -0700 (PDT)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id kr12-20020a170903080c00b001db37fd26bcsm1820471plb.116.2024.04.05.10.08.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 10:08:11 -0700 (PDT)
Date: Fri, 5 Apr 2024 14:08:07 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1712336890;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XnwA3IQIKVbX5TtpnpowKO0T6lwnxkQ6mM8Ph3vpATI=;
	b=rDe9hRhptOqWLf7DP7DE7KkviR7KGu4+QARyO4C94hn1S3211fVZuUtazrUf71pBUnOxsr
	2ZoCYvJ23rw7TvHr/6YKe+YpZWwyaATvYTb+cZZMlVNALgAQ+55o8rlAruZE8I0OtQPNyC
	XjIfhDqxL5m4JW3kZ4qRSJN96wwhbP0OQZ77vT4YWG631w5hnxwUOV97DzCJBGpK0vk3Su
	W5hYf5C9dYgNllTF+zrcmopBSLY22O24eDqRgi9YeE63hrmlgiXdv5IrCHA8KL1n5IdFvQ
	bnVClunI+pvMZ+gEBx2XIxmAcAST/kNi1JRLZ3MOW3ZF4vZqsfyeGBeuFq4CGg==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
From: "Ricardo B. Marliere" <ricardo@marliere.net>
To: Vinod Koul <vkoul@kernel.org>
Cc: Kishon Vijay Abraham I <kishon@kernel.org>, 
	linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] net: phy: core: make phy_class constant
Message-ID: <4yxiyk555fts7ibsjubatreugv7pdmvcbnnamcuqoxpwx4g3wr@f6t33jkfwcve>
References: <20240305-class_cleanup-phy-v1-1-106013a644dc@marliere.net>
 <ZhAtQngu2uChbCCt@matsya>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZhAtQngu2uChbCCt@matsya>

On  5 Apr 22:26, Vinod Koul wrote:
> On 05-03-24, 15:18, Ricardo B. Marliere wrote:
> > Since commit 43a7206b0963 ("driver core: class: make class_register() take
> > a const *"), the driver core allows for struct class to be in read-only
> > memory, so move the phy_class structure to be declared at build time
> > placing it into read-only memory, instead of having to be dynamically
> > allocated at boot time.
> 
> why is this tagged net: ...??
> This has nothing to do with networking!

Hi Vinod.

My mistake, it was due to poor local tree management. Please let me know
if you can review and take it as is, changing the subject line, or if
you want me to resend.

Best regards,
-	Ricardo.


> 
> > 
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
> > ---
> >  drivers/phy/phy-core.c | 26 +++++++++++++++-----------
> >  1 file changed, 15 insertions(+), 11 deletions(-)
> > 
> > diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
> > index 7f9b4de772ee..5776d44fd32f 100644
> > --- a/drivers/phy/phy-core.c
> > +++ b/drivers/phy/phy-core.c
> > @@ -20,7 +20,12 @@
> >  #include <linux/pm_runtime.h>
> >  #include <linux/regulator/consumer.h>
> >  
> > -static struct class *phy_class;
> > +static void phy_release(struct device *dev);
> > +static const struct class phy_class = {
> > +	.name = "phy",
> > +	.dev_release = phy_release,
> > +};
> > +
> >  static struct dentry *phy_debugfs_root;
> >  static DEFINE_MUTEX(phy_provider_mutex);
> >  static LIST_HEAD(phy_provider_list);
> > @@ -706,7 +711,7 @@ struct phy *of_phy_simple_xlate(struct device *dev,
> >  	struct phy *phy;
> >  	struct class_dev_iter iter;
> >  
> > -	class_dev_iter_init(&iter, phy_class, NULL, NULL);
> > +	class_dev_iter_init(&iter, &phy_class, NULL, NULL);
> >  	while ((dev = class_dev_iter_next(&iter))) {
> >  		phy = to_phy(dev);
> >  		if (args->np != phy->dev.of_node)
> > @@ -969,7 +974,7 @@ struct phy *phy_create(struct device *dev, struct device_node *node,
> >  	device_initialize(&phy->dev);
> >  	mutex_init(&phy->mutex);
> >  
> > -	phy->dev.class = phy_class;
> > +	phy->dev.class = &phy_class;
> >  	phy->dev.parent = dev;
> >  	phy->dev.of_node = node ?: dev->of_node;
> >  	phy->id = id;
> > @@ -1238,14 +1243,13 @@ static void phy_release(struct device *dev)
> >  
> >  static int __init phy_core_init(void)
> >  {
> > -	phy_class = class_create("phy");
> > -	if (IS_ERR(phy_class)) {
> > -		pr_err("failed to create phy class --> %ld\n",
> > -			PTR_ERR(phy_class));
> > -		return PTR_ERR(phy_class);
> > -	}
> > +	int err;
> >  
> > -	phy_class->dev_release = phy_release;
> > +	err = class_register(&phy_class);
> > +	if (err) {
> > +		pr_err("failed to register phy class");
> > +		return err;
> > +	}
> >  
> >  	phy_debugfs_root = debugfs_create_dir("phy", NULL);
> >  
> > @@ -1256,6 +1260,6 @@ device_initcall(phy_core_init);
> >  static void __exit phy_core_exit(void)
> >  {
> >  	debugfs_remove_recursive(phy_debugfs_root);
> > -	class_destroy(phy_class);
> > +	class_unregister(&phy_class);
> >  }
> >  module_exit(phy_core_exit);
> > 
> > ---
> > base-commit: 00ca8a15dafa990d391abc37f2b8256ddf909b35
> > change-id: 20240305-class_cleanup-phy-668a148b2acd
> > 
> > Best regards,
> > -- 
> > Ricardo B. Marliere <ricardo@marliere.net>
> 
> -- 
> ~Vinod

