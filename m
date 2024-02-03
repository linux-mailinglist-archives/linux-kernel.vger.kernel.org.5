Return-Path: <linux-kernel+bounces-51182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62E66848772
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 17:28:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C18B28448E
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 16:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA5AB5F853;
	Sat,  3 Feb 2024 16:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nYR9cA9V"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0D75F843;
	Sat,  3 Feb 2024 16:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706977691; cv=none; b=WeXEsYf4Ra970IKWm7Y9PD8WM3rETap3i4rGY7CZfKBy4rCDp3Mk4klwRacoR8RQZgPpjpopKESfkCyWkQJSgk0/06NozcEnh/KDlCJtjFkZPjmGVFKOq8QfJIOyRacXy6gDyL6c8h5XZtK1R3sLZj5qw3W3scjG/t0Zt8XWDdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706977691; c=relaxed/simple;
	bh=6V+6hanOVQqDNQ9px+eX1cNnxoJnRfwrdgS3FDJGxQs=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cTsaEdsP5bR93qU1MbFtTUwqEdD6eDsYTkAquOWIYMaJTJSfovKzXgeyDIX98wiYi0HPHWtJa0gzpl7OTVfqfxjy8uSp2oOlQitmJ0CLyCLQiwW3/KG1zoupGM2rbLYyr/3mMyZBwgHf5UoA9BvexJxW953cgbshh0Hrkg6P380=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nYR9cA9V; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-40fc65783aeso14597505e9.2;
        Sat, 03 Feb 2024 08:28:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706977687; x=1707582487; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=GS/BDC9cqJY3NsuxlNWLdJ/c0yhbHpkPVMKk/bSeWvA=;
        b=nYR9cA9VW41te+JyUScvY72qkk4L66WhtoAmoy2BfaBx19/A9Fn70UOMpV1G1Zzj+7
         PQ9Unu+HHjQxAfOp5Y/Qjt53JkzB/D13cuU1mEvZUCdCZBHCQhGLFxgUTOez+rrQhFqE
         6t1EtHkBMg6Y6qA5UuHnyNqkRGtO4cX3QpJfEvfVCbM+7SL1yqnlDauL7B1smYtL4UpE
         gz4ASu050HSgRTbhx/JJGNYX1zfpEUvhMlyV7dwuacA/uva6djBz0wDse1NCQLEPD1MX
         U7k7Q0K/U577Zv2X1hS6NEDfBBZLbnvdJXQUqowA0Fq7KyZT/ycwAlhhbnOgUuEtlPUh
         XVqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706977687; x=1707582487;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GS/BDC9cqJY3NsuxlNWLdJ/c0yhbHpkPVMKk/bSeWvA=;
        b=aUxd7BuMQX4K0AoGBSHVU/jcO7nAu9BnSn5OuyQGnp8EL6rTqr1GVK+pWkwToIF4HQ
         RvrWmXRKn+PrKhyv8Vfqp1CFmCtRl2RzyI6v6dfRUplVdp1wvOCj6uZIMFO6kr7Hf9c0
         OA+THYqBwxtSpmGLh3sMbz3AbbWCF4RZ/NwlW1VOdrhjQiBQT8cxa5pcujIQgvI1Cqq1
         vZ2+6whQU48UCTHLkRMVFRHs4rPN6nrSx1nEtUAlMM/GSZGzyTOskNBl0xYz/cOwxRbB
         kRkFLvDrrPpQQJySkx+FkuJ91h2rtGtYr23J/IRyt/QxCiBjjkpqpbPoTDBvY9YHUDg9
         6jSg==
X-Gm-Message-State: AOJu0YzJkRb+ObVp+f+XPQqGaojNaft63XI4p0J7icQj/eDfw64olKTF
	OSuWvjeEeBhE25gxFwdFm229v9IJy0Bezm2k0AaorPDKbKZESdi9
X-Google-Smtp-Source: AGHT+IFZi4hVOIAerpcyvJSDucWbbOaS3/MTQMCOcFUZOAjnLU/6PIKvKYstNkZWNd7izQcI+JNkPQ==
X-Received: by 2002:a05:600c:3583:b0:40f:20e:bf71 with SMTP id p3-20020a05600c358300b0040f020ebf71mr1339216wmq.5.1706977687368;
        Sat, 03 Feb 2024 08:28:07 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUDMefEEkz4sDh5F3KKg8tLo1bHdknErdzPlp3ZSApUFvoUMRZ0qL0RLovls/Zu2HjjIpB6P415JUyCkBUGrLeiD9Ztth0+a7nlfCMGEopXBnTW3YMltNr8J0HabfGtXNPARxRARxK2i29Ek8MtCayJxqL/7HbXKYLpGjuQrRNOKWhmM0lNeV3qGnoA4YqkqM4VWYHJHsJMdFGFjVicHZLmOAFSEnuhBMpa8xtzvh/L+n+EdaMhXvDKs6L6EQev10hh4JlV9LAEs/Um7TVBqY6y1pEPwvemY5ESC/9DlSG5hWtv/PWMoU3cAecmszWcyyQLIWeJ0U/BSnKqMEL1ydBwDKYffewRY1jyYdIhxpuot6kYZUhxjCRChZH2v26rhG6pqreuioaJXqSW0uErea7+RCGcpxkDlGvrOWkjlPWYiPQh2xN7CNRYVB8ljBLoUdN5hiPr93fDo2sXTWNE7yBAO/ZrBZY/pLieT5meAUL+JsB9FcQ+EsUN0KIoxWV2MvNRZfrWxcxjSIlXKj6FXgjLgdHz68wGQ1NjUo3ZRk/jhbNekzUF6IeQDKneIuVRVX59fw==
Received: from Ansuel-xps. (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.gmail.com with ESMTPSA id m9-20020a7bcb89000000b0040e813f1f31sm3315328wmi.25.2024.02.03.08.28.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Feb 2024 08:28:07 -0800 (PST)
Message-ID: <65be6997.7b0a0220.3acf.de81@mx.google.com>
X-Google-Original-Message-ID: <Zb5pkz6b1ytMTiaI@Ansuel-xps.>
Date: Sat, 3 Feb 2024 17:28:03 +0100
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
Subject: Re: [net-next PATCH v5 7/9] net: phy: qcom: add support for QCA807x
 PHY Family
References: <20240201151747.7524-1-ansuelsmth@gmail.com>
 <20240201151747.7524-8-ansuelsmth@gmail.com>
 <a530f40c-b8fd-4da1-b4df-f80ab05f0394@lunn.ch>
 <65bd29f9.050a0220.a175d.3d5f@mx.google.com>
 <c3447c2b-4b43-4c09-b89e-d6a44971b923@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c3447c2b-4b43-4c09-b89e-d6a44971b923@lunn.ch>

On Sat, Feb 03, 2024 at 05:25:23PM +0100, Andrew Lunn wrote:
> On Fri, Feb 02, 2024 at 06:44:22PM +0100, Christian Marangi wrote:
> > On Fri, Feb 02, 2024 at 02:35:11AM +0100, Andrew Lunn wrote:
> > > > +static int qca807x_read_fiber_status(struct phy_device *phydev)
> > > > +{
> > > > +	int ss, err, lpa, old_link = phydev->link;
> > > > +
> > > > +	/* Update the link, but return if there was an error */
> > > > +	err = genphy_update_link(phydev);
> > > > +	if (err)
> > > > +		return err;
> > > > +
> > > > +	/* why bother the PHY if nothing can have changed */
> > > > +	if (phydev->autoneg == AUTONEG_ENABLE && old_link && phydev->link)
> > > > +		return 0;
> > > > +
> > > > +	phydev->speed = SPEED_UNKNOWN;
> > > > +	phydev->duplex = DUPLEX_UNKNOWN;
> > > > +	phydev->pause = 0;
> > > > +	phydev->asym_pause = 0;
> > > > +
> > > > +	if (phydev->autoneg == AUTONEG_ENABLE && phydev->autoneg_complete) {
> > > > +		lpa = phy_read(phydev, MII_LPA);
> > > > +		if (lpa < 0)
> > > > +			return lpa;
> > > > +
> > > > +		linkmode_mod_bit(ETHTOOL_LINK_MODE_Autoneg_BIT,
> > > > +				 phydev->lp_advertising, lpa & LPA_LPACK);
> > > > +		linkmode_mod_bit(ETHTOOL_LINK_MODE_1000baseX_Full_BIT,
> > > > +				 phydev->lp_advertising, lpa & LPA_1000XFULL);
> > > > +		linkmode_mod_bit(ETHTOOL_LINK_MODE_Pause_BIT,
> > > > +				 phydev->lp_advertising, lpa & LPA_1000XPAUSE);
> > > > +		linkmode_mod_bit(ETHTOOL_LINK_MODE_Asym_Pause_BIT,
> > > > +				 phydev->lp_advertising,
> > > > +				 lpa & LPA_1000XPAUSE_ASYM);
> > > > +
> > > > +		phy_resolve_aneg_linkmode(phydev);
> > > > +	}
> > > 
> > > This looks a lot like genphy_c37_read_status(). Can it be used?
> > >
> > 
> > Yes but I had to expand genphy_c37_read_status. Hope it will be OK.
> 
> You can expand it, but please keep to what is defined within 802.3. We
> don't want any vendor extensions in this common code. Vendor things
> should be kept in the vendor driver. So you can call
> genphy_c37_read_status() and then do any vendor specific fixups
> needed.
>

Sure the expansion is just adding a bool signal if the link has changed
or not (to make it possible to exit early and skip the additional vendor
call...) I didn't add anything to the c37 function ifself.

Anyway of from this, the revision is ready, just need to understand if
Rob is ok with absolute or relative address for PHYs in the PHY package
node.

-- 
	Ansuel

