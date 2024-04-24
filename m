Return-Path: <linux-kernel+bounces-157266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69ADD8B0F37
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 17:57:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D37B21F24C64
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 15:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28D0A16130D;
	Wed, 24 Apr 2024 15:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h7Q/YNVj"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6D215E1EA;
	Wed, 24 Apr 2024 15:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713974213; cv=none; b=CuPvCzb/i7LzyyeKTYF/+CwFYxvIA5Y7+vieq5tOHayvvjfuPQ5MjUytelR082EIjkL/Q+ZEYpi3ifPpFhN99Mas6BTuSC+9HaqAWOXgrI5vXYPL5R3wr6XklFZ4q//emiQUgcL4VUO4w+4aQfTpGP8XQ7YYmlUffcylrx7ALx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713974213; c=relaxed/simple;
	bh=rN2dEb0j96WS7aDMNa9rrVDrS8FsAQHis4iO9y0VQ6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qzERFTLv5ZoJ2HGPGu/IJWxC59e98tGOIUPUfER4aVRW8N7gREO98ks9Vbj7EWycP1yZjMhVMc/DOynql2n1JcFInndLZTWlweHSN7ce0i7tI9VF3g92Xru7GirkSjtLMNRW+KLp5QJiFm/4cw6VOTwHaJnaiR8MNhohMkUs7l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h7Q/YNVj; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-41a0979b9aeso31965185e9.3;
        Wed, 24 Apr 2024 08:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713974210; x=1714579010; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nbeaRYy7X99b1fx2dTJa7zclHfv8D7MVJnbrzwhaT7o=;
        b=h7Q/YNVjV6oL58zBFokPSvNPj86a2O+RKnsp07pYIF0ZwKRg97grN+SU1+zYb4bz9I
         GXAvLGOcvs6wjLZAVoi1/pxUMjH/Q2JNly8tVMLsIMndU65R8N2d6xcdjZREllsVynlP
         DLMQY1vtDFn0uU5d1Smr70X3aUKWduSBge7pfpoWQ4QJ+/pXB0x4xr8Nln4vJVPn1vRg
         u6WTdPQgE2RD8ej5aIRnRafE5NcxH6QmR/27llx6QDOzIOCMX9gPxMaSelmt1CpOw7PJ
         gQCZhDrdaqrc4g3tG16R3gi+9m/PXCZZ7tlEmMLYw37P1GWHkfufGrEQ3peksf2CaYUe
         yNYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713974210; x=1714579010;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nbeaRYy7X99b1fx2dTJa7zclHfv8D7MVJnbrzwhaT7o=;
        b=Z6dhkZce7fov8n7xfwxy8sh7KOLxWcZuI6T8wwfXapj5x+vPnGHzAe2tFlf+lRCXV3
         00j6Fj4Llm8EB1Q26yUtgZ5BHVDR8Imasc3DcwrZXOfZ967UUBXWsUB+rwOa8pl6oVQF
         UEhz/YWXIpH9iJ4G5l9uhiDraXhHsueudplh96D8TaSQKBRApYaImQk4Wfil1bROxdE1
         4424cMnOLMZpT5PhdKbc3CV87pmXY6B8gQlrYB4HKEiyK42aRsjCrYQ3m27UVtJloP0a
         cZy1DPFJ6UtlPZiRfn7En5jiSH/DFHUBp4S/I9ein211yBYSBGHYBdluoFGsPquKGpSX
         zo8Q==
X-Forwarded-Encrypted: i=1; AJvYcCVixyUt/x/f229pStLWNfuW4ndIIGwAhecYCCpnoXe1MjukW1nShluFRMuH1h2ZExmfydT9ZOIIPT25BNFbpJlWwMHW7uCDd1jRmuMt/t33mNcfaCm92wyIiVjYizT7ms/6n3N4IipXlLlCu6/fIplJpHV05UKlMscRWtIsyiVHMQ==
X-Gm-Message-State: AOJu0Yw6IKw0vVK3khG+CtcZwzDqIcdqcphDZXnFftH51GiPSYdmPXLZ
	VQF9aAyD7/xDFPb5wSX/rkwBN59EVCfWLkrTGaOxkMLs+Y3vHqPT
X-Google-Smtp-Source: AGHT+IHOQVLqrm4X7IfGHZNmNr9BueDcUUh1FuRtSN3/JFvZBb74YcdrPSnlWQsbK9YfE26T9a2FNA==
X-Received: by 2002:a05:600c:1f19:b0:418:792d:f8b4 with SMTP id bd25-20020a05600c1f1900b00418792df8b4mr2788565wmb.23.1713974209920;
        Wed, 24 Apr 2024 08:56:49 -0700 (PDT)
Received: from eichest-laptop ([2a02:168:af72:0:4762:b27a:e0ea:f82f])
        by smtp.gmail.com with ESMTPSA id i13-20020a05600c354d00b00419fba938d8sm15638063wmq.27.2024.04.24.08.56.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 08:56:49 -0700 (PDT)
Date: Wed, 24 Apr 2024 17:56:47 +0200
From: Stefan Eichenberger <eichest@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	lxu@maxlinear.com, hkallweit1@gmail.com, michael@walle.cc,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] net: phy: mxl-gpy: add new device tree property
 to disable SGMII autoneg
Message-ID: <Zikrv5UOWvSGjgcv@eichest-laptop>
References: <20240416121032.52108-3-eichest@gmail.com>
 <3f7f278f-e490-47f1-971c-ecf44a70cee4@lunn.ch>
 <Zh6clAtI3NO+nMEi@eichest-laptop>
 <5ed39628-4ac0-4c4e-9a16-fd4bf9a6db29@lunn.ch>
 <Zh6mIv1Ee+1h21Xo@shell.armlinux.org.uk>
 <Zh6z90iCpLqF4fla@eichest-laptop>
 <Zh6/oVHUvnOVtHaC@shell.armlinux.org.uk>
 <Zh94yqo2EHRq8eEq@eichest-laptop>
 <ZiE156+BPpx/ciL6@shell.armlinux.org.uk>
 <Zikd+GxuwMRC+5Ae@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zikd+GxuwMRC+5Ae@shell.armlinux.org.uk>

On Wed, Apr 24, 2024 at 03:58:00PM +0100, Russell King (Oracle) wrote:
> On Thu, Apr 18, 2024 at 04:01:59PM +0100, Russell King (Oracle) wrote:
> > On Wed, Apr 17, 2024 at 09:22:50AM +0200, Stefan Eichenberger wrote:
> > > I also checked the datasheet and you are right about the 1000base-X mode
> > > and in-band AN. What worked for us so far was to use SGMII mode even for
> > > 2.5Gbps and disable in-band AN (which is possible for SGMII). I think
> > > this works because as you wrote, the genphy just multiplies the clock by
> > > 2.5 and doesn't care if it's 1000base-X or SGMII. With your patches we
> > > might even be able to use in-band autonegoation for 10,100 and 1000Mbps
> > > and then just disable it for 2.5Gbps. I need to test it, but I have hope
> > > that this should work.
> > 
> > There is another way we could address this. If the querying support
> > had a means to identify that the endpoint supports bypass mode, we
> > could then have phylink identify that, and arrange to program the
> > mvpp2 end to be in 1000base-X + x2.5 clock + AN bypass, which would
> > mean it wouldn't require the inband 16-bit word to be present.
> > 
> > I haven't fully thought it through yet - for example, I haven't
> > considered how we should indicate to the PCS that AN bypass mode
> > should be enabled or disabled via the pcs_config() method.
> 
> Okay, I've been trying to put more effort into this, but it's been slow
> progress (sorry).
> 
> My thoughts from a design point of view were that we could just switch
> to PHYLINK_PCS_NEG_OUTBAND instead of PHYLINK_PCS_NEG_INBAND_* and
> everything at the PCS layer should be able to cope, but this is not the
> case, especially with mvneta/mvpp2.
> 
> The problem is that mvneta/mvpp2 (and probably more) expect that
> 
> 1) MLO_AN_INBAND means that the PCS will be using inband, and that
>    means the link up/down state won't be forced. This basically implies
>    that only PHYLINK_PCS_NEG_INBAND_* can be used can be used for the
>    PCS.
> 
> 2) !MLO_AN_INBAND means that an out-of-band mechanism will be used and
>    that means that the link needs to be forced (since there's no way
>    for the hardware to know whether the link should be up or down.)
>    It's therefore expected that only PHYLINK_PCS_NEG_OUTBAND will be
>    used for the PCS.
> 
> So, attempting to put a resolution of the PHY and PCS abilities into
> phylink_pcs_neg_mode() and select the appropriate PHYLINK_PCS_NEG_*
> mode alone just doesn't work. Yet... we need to do that in there when
> considering whether inband can be enabled or not for non-PHY links.
> 
> Basically, it needs a re-think how to solve this...

Today I was playing around with my combination of mxl-gpy and mvpp2 and
I got it working again with your patches applied. However, I hacked the
phylink driver to only rely on what the phy and pcs support. I know this
is not a proper solution, but it allowed me to verify the other changes.
My idea was if the phy and pcs support inband then use it, otherwise use
outband and ignore the rest.

Here is how my minimal phylink_pcs_neg_mode test function looks like:

static unsigned int phylink_pcs_neg_mode(struct phylink *pl,
					 struct phylink_pcs *pcs,
					 unsigned int mode,
					 phy_interface_t interface,
					 const unsigned long *advertising)
{
	unsigned int phy_link_mode = 0;
	unsigned int pcs_link_mode;

	pcs_link_mode = phylink_pcs_query_inband(pcs, interface);
	if (pl->phydev)
		phy_link_mode = phy_query_inband(pl->phydev, interface);

	/* If the PCS or PHY can not provide inband, then use
	 * outband.
	 */
	if (!(pcs_link_mode & LINK_INBAND_VALID) ||
	    !(phy_link_mode & LINK_INBAND_VALID))
		return PHYLINK_PCS_NEG_OUTBAND;

	return PHYLINK_PCS_NEG_INBAND_ENABLED;
}

