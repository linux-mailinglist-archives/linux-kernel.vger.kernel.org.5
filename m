Return-Path: <linux-kernel+bounces-70562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D4A485992D
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 20:58:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 970391F2116C
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 19:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6399971B4A;
	Sun, 18 Feb 2024 19:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mvh+r39r"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1BF02B9A7;
	Sun, 18 Feb 2024 19:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708286273; cv=none; b=sRtn8DtLK2UjJA0CM+HOJwG6klM9d6HHRaliw6fkSnOcFNcc4Y1YiJcs+5tZuI+u430BEtJ1fPUeuV+07k81PmgJIQowKcFSkkNUc/cSW3eYof+4jf09lvw9NQ4dJ3JJryLrmcQpWApx/zu1J3Mhb72pGXmUS6C2c/LxntLkkVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708286273; c=relaxed/simple;
	bh=B97CQKrbZaN1m0Dc3XAMhg5QZM98tFxIgoLYFbSWzKY=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pTSksCwhye0z8skat5/lKzaz8XuKb63ElUXnZQJ7c3kfvgiCp2lH0S64iN34SVLltpa1sLJL1M2GjW9FFXGX1vHOxQbkT0RVe/gTKm+3HMtreG+kmGPUSy0pBpZ/EwoEpKt/cECIHXHmH3rZY15utTPHWcktxw/i/kCJMj1ojFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mvh+r39r; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2d22d0f8ad1so10876631fa.2;
        Sun, 18 Feb 2024 11:57:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708286270; x=1708891070; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=p8rJJNHwNbRHM4EW1L1FxTBQsv+BBPhJTZyu1VMF04Q=;
        b=Mvh+r39rpHF7ORAmKQlNAKEwVMng2BMlPQfoQfoOpNEJLw/5lw0uxr3+ZSEjjAxtRG
         v1fAzXO9Tcw762RivRIm6EuEszJ5jTi/orCeL4ddbN/26vkh9Gff0R+4J2hVtaFAqM5q
         vIBJFb3OBESvyagOBvPyLcHIR1+PHda8FxNiPVKV0JSld8WT+Qj4jfPOkIEEMeefZYes
         uDBi9uoW146fE/KfpEToE85rbCCb5+Mn8Ys+kw6krg95WzSKvoWMcR2ZAt5jnI309IFI
         4SN4O6TJ9z6wWM2b1rrBOXbCF3erqUC39hfkNVBCe2RvFvm/7Yiim/HS1z+TlpE8SP8P
         lIOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708286270; x=1708891070;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p8rJJNHwNbRHM4EW1L1FxTBQsv+BBPhJTZyu1VMF04Q=;
        b=ZKQX0os1qzjvZrav+x3XmwT2DPLYWOTKJ1hvAZuK1YR08v6AyAelc39mqVPEnAIBsY
         RHt9D5ScDaOr7gyhAWIHeOMnfGP4ajOEfpFOE8b3vwzHoUwiu+b1UUx8ztqOzaelXpLZ
         UF6rCxtUzR2vbR8SfLV24izjiHBtJBh9X5ZDzHQyeiukHpI+l/Jb3cNNBIZUtvSHd4kZ
         fYs4FOxOL8isfTUnqoO5LSHfGQ5xRu/h7HzR8pGbTaghO1lQSVOPDcLOfE8jilIeJXGZ
         SyiRSvhCN1hxKsFiZhDXW2bR4ZwrizpoidLBD9S2VpcAg2bzcSdUQBm31l4yHpYNtTpO
         qoAw==
X-Forwarded-Encrypted: i=1; AJvYcCXWA7bqUCyixjxz52PYGkAs9G18PAw9jJDgqm76eAmWu8DIugI2RNM/RaVCn7oX+P8YakIBe7ZoDVga890Mqoqi5cnT7rUna4LdwkZfxQ3RQOfZOjps4gdVNcfXjI1adjq34PrQ
X-Gm-Message-State: AOJu0YzJhl8tHIdimDZiQgHfDsAbJi6880buerXSsYBwI5Os2Gllnjo0
	fZPod9s+9gro3qFep6yjz3OsIQ4bsWEtJum2hKI6alIY+Ysksh1o
X-Google-Smtp-Source: AGHT+IH6BJNtYI5N+KVot61fht6Ywra/gBWfJIqauhgnC4rp+IMv5DNrExiScLVPxz2KhvkknvDlzQ==
X-Received: by 2002:a19:ae0e:0:b0:512:b28c:f722 with SMTP id f14-20020a19ae0e000000b00512b28cf722mr755351lfc.15.1708286269731;
        Sun, 18 Feb 2024 11:57:49 -0800 (PST)
Received: from Ansuel-XPS. (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.gmail.com with ESMTPSA id o11-20020a1709064f8b00b00a3c180170e9sm2197238eju.160.2024.02.18.11.57.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Feb 2024 11:57:49 -0800 (PST)
Message-ID: <65d2613d.170a0220.2eb48.a510@mx.google.com>
X-Google-Original-Message-ID: <ZdJhPSh4yksUAeNa@Ansuel-XPS.>
Date: Sun, 18 Feb 2024 20:57:49 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Robert Marko <robimarko@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>,
	Nipun Gupta <nipun.gupta@amd.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Puneet Gupta <puneet.gupta@amd.com>,
	Abhijit Gangurde <abhijit.gangurde@amd.com>,
	Umang Jain <umang.jain@ideasonboard.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [net-next RFC PATCH 1/6] net: phy: add support for defining
 multiple PHY IDs in PHY driver
References: <20240218190034.15447-1-ansuelsmth@gmail.com>
 <20240218190034.15447-2-ansuelsmth@gmail.com>
 <ZdJbciylnw8+ve8V@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZdJbciylnw8+ve8V@shell.armlinux.org.uk>

On Sun, Feb 18, 2024 at 07:33:06PM +0000, Russell King (Oracle) wrote:
> On Sun, Feb 18, 2024 at 08:00:27PM +0100, Christian Marangi wrote:
> > Some PHY driver might implement the same OPs for different PHY ID and
> > using a mask is not enough to match similar PHYs.
> > 
> > To reduce code duplication, add support for defining multiple PHY IDs in
> > PHY driver struct.
> > 
> > Introduce a new variable in phy_driver struct, .ids, where a table array of
> > mdio_device_id can be defined to reference multiple PHY IDs (with their
> > own masks) supporting the same group of OPs and flags.
> > 
> > Introduce a new variable in phy_device, .dev_id, where the matching
> > mdio_device_id is stored. PHYs supporting multiple PHYs for one PHY
> > driver struct, should use this instead of matching for phy_id.
> > 
> > Single PHY ID implementation is still supported and dev_id is filled
> > with the data from phy_driver in this case.
> 
> This looks like it's been reworked somewhat with my suggestion, or maybe
> we just came across a similar structure for comparing the IDs?
>

Hi, I forgot to include this question in the cover letter. Yes the
matching logic is from your suggestion but I changed the other part of
the logic. What credits should I use? From and Sob? Suggested-by?
Make it a separate patch?

> > +	phy_dev_id = (struct mdio_device_id *)&phydev->dev_id;
> 
> Why this cast? Try to write code that doesn't need casts.
> 

This cast is needed to keep the dev_id const in the phy_device struct so
that other are warned to not modify it and should only be handled by
phy_probe since it's the one that fills it.

Alternative is to drop const and drop the warning.

> > +	/* Fill the mdio_device_id for the PHY istance.
> > +	 * If PHY driver provide an array of PHYs, search the right one,
> > +	 * in the other case fill it with the phy_driver data.
> > +	 */
> > +	if (phy_driver_match(phydrv, phydev, &dev_id) && dev_id) {
> > +		memcpy(phy_dev_id, dev_id, sizeof(*dev_id));
> > +	} else {
> > +		phy_dev_id->phy_id = phydrv->phy_id;
> > +		phy_dev_id->phy_id_mask = phydrv->phy_id_mask;
> 
> So this is the _driver_ phy_id.
> 

Ok I think I need some help with the naming here.

phy_id refer to the real PHY ID (but it's empty with C45)
and anything in dev_id would be the one from the phy_driver.

I was confused by this as I wasn't thinking that phy_id from driver
might apply mask and is not always MATCH_EXACT.

> >  static inline bool phydev_id_compare(struct phy_device *phydev, u32 id)
> >  {
> > -	return phy_id_compare(id, phydev->phy_id, phydev->drv->phy_id_mask);
> > +	return phy_id_compare(id, phydev->dev_id.phy_id,
> > +			      phydev->dev_id.phy_id_mask);
> 
> And thus this code is now different (since it _was_ comparing the
> phydev phy_id, and you've changed it to effectively the driver's
> phy_id. While that should be the same for a matched driver, that
> is still a change that probably is't intentional.
>

Yes this change was done with the assumption that MATCH_EXACT is always
used but this is not the case and actually makes the thing wrong. Will
drop thanks for poitining this out!

My original idea was to "migrate" to device_match_id and trying to
deprecate phy_id but this doesn't makes sense at all since they reflect
different kind of data.

-- 
	Ansuel

