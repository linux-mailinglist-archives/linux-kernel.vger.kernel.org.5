Return-Path: <linux-kernel+bounces-275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 39BD0813E8D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 01:11:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77318B21DA1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 00:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EF9D650;
	Fri, 15 Dec 2023 00:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WQ/kQ6Tf"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC14170;
	Fri, 15 Dec 2023 00:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-336445a2749so64648f8f.0;
        Thu, 14 Dec 2023 16:11:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702599066; x=1703203866; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=FOpSAESrCREh7iwA0QrEwcVuNo2mOCVPdcWa/LmmpC0=;
        b=WQ/kQ6TfduZNutCNpRpPuBWLzQvAcM3ZImRGRdUWTXfrkBOKRGBkRtFGFYT3tfcMeU
         eDNi7cf5LWCK3WWqjscBkGEsPQFGGF1xKBZXnB/CAQodTH+07tka1igqmmeyIKb1o7Qd
         TQNeYnEShnS5+l8r/Xp63YRDYc5N2EaAiqWo+h5wKyunizG4p++1oQFhGZUpweFtjJSV
         nS+tqirOz4Iaez/2rYcJf/ZPN8fL5nYT/EUyBZw0p0z22negHENdFeh01Tc7PFSee6IM
         B0hhD4lOrJT98kkEAr5E4FPe7HG/4ajj2z7xLMNBmiy2xovd5+9AopIg/2H4POi2wqTj
         UYTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702599066; x=1703203866;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FOpSAESrCREh7iwA0QrEwcVuNo2mOCVPdcWa/LmmpC0=;
        b=KrCzo0XXkMdPRp4KYPv5IxP9ltPxX94Q+wxoLl0WtReYtQJVk/WHp2OGDHwha3PK2S
         UTLnhZFGppaD51s4o4v2uVfsTdmLpbPNtCdLpU034q3WQN5YvT1pkpkq7O5zFohiS9YO
         DHxdDtWSh7yKJ+0E/+qCRbQXwdwdENyJ6hFn/mIhT0dTrxSi0HabonX0cgjk+1TnBUKG
         5M/rTpCX4DpaeT0lyQEczl7CqXr01Spc+Fgvh6/eSVf/egLR+xw+jO8FkenGkcjVzTeE
         jN3NUuhwWUwkOthUqCCb3bi6QwXqPJQ/Ox6w0K8SDcVqcDygQXV+46U3ZVvs7kz3a4OQ
         ECKQ==
X-Gm-Message-State: AOJu0YwNYdUmL64FjHz0QujYZbPph+QIBeAuE+boiqww1RbHFkZDy3Tw
	4fMF8t0owT/Ql0EKSyMchcI=
X-Google-Smtp-Source: AGHT+IGRLFSwBQ7r/U+FCLN15MTtsKW96qVozGODlps0NVHzFVD7yrQxyMq5DL9In0vMTriQUQsLAw==
X-Received: by 2002:a5d:6042:0:b0:333:40b5:fa07 with SMTP id j2-20020a5d6042000000b0033340b5fa07mr4919371wrt.137.1702599066184;
        Thu, 14 Dec 2023 16:11:06 -0800 (PST)
Received: from Ansuel-xps. (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.gmail.com with ESMTPSA id v14-20020a5d4a4e000000b003333541a5bdsm17286559wrs.80.2023.12.14.16.11.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 16:11:05 -0800 (PST)
Message-ID: <657b9999.5d0a0220.ec414.ed08@mx.google.com>
X-Google-Original-Message-ID: <ZXs7eIBY7MgNsgCW@Ansuel-xps.>
Date: Thu, 14 Dec 2023 18:29:28 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	David Epping <david.epping@missinglinkelectronics.com>,
	Harini Katakam <harini.katakam@amd.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH v7 2/4] net: phy: extend PHY package API to
 support multiple global address
References: <20231214121026.4340-1-ansuelsmth@gmail.com>
 <20231214121026.4340-3-ansuelsmth@gmail.com>
 <ZXs14wrGKGtTfiui@shell.armlinux.org.uk>
 <657b921d.5d0a0220.7815b.87dd@mx.google.com>
 <ZXuVsotg1DV596lV@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXuVsotg1DV596lV@shell.armlinux.org.uk>

On Thu, Dec 14, 2023 at 11:54:26PM +0000, Russell King (Oracle) wrote:
> On Thu, Dec 14, 2023 at 05:54:51PM +0100, Christian Marangi wrote:
> > What I don't like is the wrap check.
> > 
> > But I wonder... Isn't it easier to have 
> > 
> > unsigned int addr = shared->base_addr + addr_offset;
> > 
> > and check if >= PHY_MAC_ADDR?
> > 
> > Everything is unsigned (so no negative case) and wrap is not possible as
> > nothing is downcasted.
> 
> I'm afraid that I LOL'd at "wrap is not possible" ! Of course it's
> possible. Here's an example:
>

Yes I just think about it and I'm also LOLing at the "not possible"...

> 	shared->base_addr is 20
> 	addr_offset is ~0 (or -1 casted to an unsigned int)
> 	addr becomes 19
> 
> How about:
> 
> 	if (addr_offset >= PHY_MAX_ADDR)
> 		return -EIO;
> 
> 	addr = shared->base_addr + addr_offset;
> 	if (addr >= PHY_MAX_ADDR)
> 		return -EIO;
> 
> and then we could keep 'addr' as u8.

Ok just to make sure

static int phy_package_address(struct phy_device *phydev,
                               unsigned int addr_offset)
{
        struct phy_package_shared *shared = phydev->shared;
        unsigned int addr;

        if (addr_offset >= PHY_MAX_ADDR)
                return -EIO;

        addr = shared->base_addr + addr_offset;
        if (addr >= PHY_ADDR_MAX)
                return -EIO;

        /* we know that addr will be in the range 0..31 and thus the
         * implicit cast to a signed int is not a problem.
         */
        return addr;
}

And call u8 addr = phy_package_address(phydev, addr_offset);

Maybe one if can be skipped with the following fun thing?

static int phy_package_address(struct phy_device *phydev,
                               unsigned int addr_offset)
{
        struct phy_package_shared *shared = phydev->shared;
        u8 base_addr = shared->base_addr;

        if (addr_offset >= PHY_MAX_ADDR - base_addr)
                return -EIO;

        /* we know that addr will be in the range 0..31 and thus the
         * implicit cast to a signed int is not a problem.
         */
        return base_addr + addr_offset;
}

(don't hate me it's late here and my brain is half working ahahha)

> 
> Honestly, I have wondered why the mdio bus address is a signed int, but
> never decided to do anything about it.
> 

Maybe because direct usage of mdiobus_ is discouraged and phy_write will
use an addr that is already validated.

-- 
	Ansuel

