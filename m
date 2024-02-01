Return-Path: <linux-kernel+bounces-48550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8989E845DAD
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 17:48:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12E601F27DFE
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 16:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB0C65399;
	Thu,  1 Feb 2024 16:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RDyERvyv"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FDA74417;
	Thu,  1 Feb 2024 16:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706806114; cv=none; b=kqnzheKRf+z0JlKRozMyS3ZNhF91EIQ4JEZ/6xItZFurleRa6/KlDZg7ilzWdeLWxU75pUQc8vdz1I7c1/k9QCZL2Ceu8vNZrfrXNnGPZgaRxL+L7KbcCNcwBmbIBtObrBboMc0aPaa66iC0xSaThWcAViA3woSmatB7aUq+ZRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706806114; c=relaxed/simple;
	bh=ZVorHm2AvCLICM1BE9csEp3jGdsytcnTIrrzgKrD/2E=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BbnMrI6u5DMbDmXA/f+DuhlzvvdAutUkE1pnngT5wuu02vFg7XMlv22wz8PgLFEXaFNN2oGgp5fGxnI/bC1zYWmpo2gOYusBsJX6CL7btR9onYlMp7Up7ONvW25p8IqXSi0aWk0SBmFATNCzwPW/MeucmJXmiHSect6046hBmRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RDyERvyv; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40e80046246so6686475e9.1;
        Thu, 01 Feb 2024 08:48:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706806111; x=1707410911; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9tssXavVHnjqR+cY+rDAK/zqOzyXLWdNWVW90h2Gxqw=;
        b=RDyERvyvW7hecwEdUwAvXT18JMx09vjRiMrYWMYdhmLty12XxqDzWBzxK965jnJiQH
         fW3+YE/pKPVPuDh4PpB5T/rIol00DKxWGHW+aMuNb37TTeWWy1tpdCGaG84hheoaXf6x
         6Oh/ONdTZxMD59m4d3vhksYEnCN/3/y/qg4Bj8HQWjQrqv64mpIHUlVTcwyPhiaDMZ11
         1aq0B8neu7jAx4bHTCoVDZlWhDSAxkkzH9lVV7qhqtV6JBZH0rGJL9WXSZG99mNXomCS
         TGhqBsYeihfEFIUKF5jn2bxZx6ScfkblsK6Ym/xjgPWFnDpku3YXYHPiHHYaDir5snnZ
         jE6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706806111; x=1707410911;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9tssXavVHnjqR+cY+rDAK/zqOzyXLWdNWVW90h2Gxqw=;
        b=ae4VQdG+dugmB8RvOCjKo1YJQRIEkT9r/PORnNGHrbwXDedTPWC5u7ECfcdOCEgVpY
         S97M0k2EukB+Wh95hTlpoaZg6PTNFEhi+KLn1SZwCleg3yjOHGm16ZOzkmBjp02wQL8h
         TjAE0itEFj2dTMqm1hq/WxUGu6XK6NEgDVnsRUmr5XJ35AoAfA2jk61kqO1JI3vIF0xT
         +ycY2fsUO0TSLy/eaT/jyj01ToOQkhuyzvCzCOH+qQjzMcYcyblpfxpX5E7Yi94gqxKv
         wL21cNNaC2SweF+LGSeC43v61KuPGdsGlbW7/YK7b2uxhG5WoZ0ozp4hXXk1E25gHMZR
         cN2w==
X-Gm-Message-State: AOJu0YyIQmIr0Tgdt3iAH14DgujXWVXWSTyxAOzOpAQ073zKpoF2aIde
	wU5q7ERxON4WUXaYtOvRtl2UZGEw5EUrRSAYBnHOZ0vFSmq1FcFh
X-Google-Smtp-Source: AGHT+IGOKfsLjkHJHoLvbDXNlepEOtUKN3Ayjk+T7/vSplhVCwg6xpFYCIRrb8POY9e14vg8y3v56w==
X-Received: by 2002:a05:600c:1d23:b0:40f:21f:4dfd with SMTP id l35-20020a05600c1d2300b0040f021f4dfdmr8101169wms.5.1706806110343;
        Thu, 01 Feb 2024 08:48:30 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXDYEOTGD5Ix/Fx3lXHNncUAr3VCwufi+YUnx9xtQbINFs++9Qlo298bxKfZEUG85Ebj7JK4QuDaTYb5bONo2TRu2sLt79cdb7Qf8XxNhYCz89fuy9qLL2UMNAMBxjlJJ3MBwyVRZfa/r/7WZADVrYQy0z7ApOg94me98gSwrrY91osfqFsFV6PmrojQyEf01nmtpBAhQIYWC4YgsJsrnOdJE2dn4uNkLpHrofy93aMNXF/+IIW9QOK72iyPk2HcdKxTmRRfaYg8ejeCvJ8WQGkcJg9i3H2NNge189gv/lE7oV/LP9+VWKJU/gJGTl2kRZ7+U9GSVCG/lYmlFYJq2dObLoOB6hoHG+LTS3Xs9wOtWmkzAsYvemCjvea7TnQq+x7LyKTEBJu0EcNr2Og8Mnik2cIMLHs7YxTzRurqFTVRMoCEiX68/z5Jpu3jZyohApy2yJRcG49gLX8YpTh3auPlT6PTkbyjlpDfQYKsbLNjNK09tl3uc/oy2nOie/1hYAk0784oLomCg+g97PWiFFF9O/VHijJzEFgEQ0iwYY5JXdZ2bdu22Zg1NqEjJ9f1XGVWiruqdP8FmIpZPiMda8aiKUbCWVZvQ==
Received: from Ansuel-xps. (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.gmail.com with ESMTPSA id jr15-20020a05600c560f00b0040ed1d6ce7csm59366wmb.46.2024.02.01.08.48.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 08:48:30 -0800 (PST)
Message-ID: <65bbcb5e.050a0220.52fda.0654@mx.google.com>
X-Google-Original-Message-ID: <ZbvLWmslClcV_qQN@Ansuel-xps.>
Date: Thu, 1 Feb 2024 17:48:26 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Antoine Tenart <atenart@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Bjorn Andersson <andersson@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Frank Rowand <frowand.list@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>,
	Robert Marko <robert.marko@sartura.hr>,
	Russell King <linux@armlinux.org.uk>, devicetree@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [net-next PATCH v5 3/9] net: phy: add devm/of_phy_package_join
 helper
References: <20240201151747.7524-1-ansuelsmth@gmail.com>
 <20240201151747.7524-4-ansuelsmth@gmail.com>
 <170680562826.4979.15332968112575820833@kwain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170680562826.4979.15332968112575820833@kwain>

On Thu, Feb 01, 2024 at 05:40:28PM +0100, Antoine Tenart wrote:
> Quoting Christian Marangi (2024-02-01 16:17:29)
> > +/**
> > + * of_phy_package_join - join a common PHY group in PHY package
> > + * @phydev: target phy_device struct
> > + * @priv_size: if non-zero allocate this amount of bytes for private data
> > + *
> > + * This is a variant of phy_package_join for PHY package defined in DT.
> > + *
> > + * The parent node of the @phydev is checked as a valid PHY package node
> > + * structure (by matching the node name "ethernet-phy-package") and the
> > + * base_addr for the PHY package is passed to phy_package_join.
> > + *
> > + * With this configuration the shared struct will also have the np value
> > + * filled to use additional DT defined properties in PHY specific
> > + * probe_once and config_init_once PHY package OPs.
> > + *
> > + * Returns < 1 on error, 0 on success. Esp. calling phy_package_join()
> 
> So, < 0 on error ?
> 
> > +int of_phy_package_join(struct phy_device *phydev, size_t priv_size)
> > +{
> > +       struct device_node *node = phydev->mdio.dev.of_node;
> > +       struct device_node *package_node;
> > +       u32 base_addr;
> > +       int ret;
> > +
> > +       if (!node)
> > +               return -EINVAL;
> > +
> > +       package_node = of_get_parent(node);
> 
> Is the node put on package leave?
>

Didn't read the get_parent was incrementing the refcount... Will update
the leave accordingly!

> > +       if (!package_node)
> > +               return -EINVAL;
> > +
> > +       if (!of_node_name_eq(package_node, "ethernet-phy-package")
> 
> of_put_node? + below.
> 
> > +               return -EINVAL;
> > +
> > +       if (of_property_read_u32(package_node, "reg", &base_addr))
> > +               return -EINVAL;
> > +
> > +       ret = phy_package_join(phydev, base_addr, priv_size);
> > +       if (ret)
> > +               return ret;
> > +
> > +       phydev->shared->np = package_node;
> 
> Just looked quickly, looks like ->np is uninitialized in the !of join
> case.
> 

Correct, I will update the non of variant to inizialize ->np to NULL.
(in theory we alloc every struct as zero so it should not be a problem
but you are right with being safe on this.)

Thanks!

> > +
> > +       return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(of_phy_package_join);

-- 
	Ansuel

