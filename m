Return-Path: <linux-kernel+bounces-66172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40BB4855819
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 01:04:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E53FB1F211CF
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 00:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABB96A50;
	Thu, 15 Feb 2024 00:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iRjHVmKA"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FCE2182;
	Thu, 15 Feb 2024 00:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707955473; cv=none; b=PLVYj/lUusCWZ6Hxm0ApjrR9YS9cSqcxDoIGgG1vi7aJ7q7QCrbjDAzkU7pDBjOCab7BsNqVBil8gyCfEKKNQaBgLV5lgVjph49e2QK2mBGOc7n4k0nb3cEwLvPN2LY/ALf0joNKAztq4LlU5mkDJLbZVM+z1D40XgJHivIhZPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707955473; c=relaxed/simple;
	bh=KT+3lHY/eWtb5HJ0+QE94m1qxjGdvw4OXd/BfuHF/FA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S7JjSSj44/+Bsu/lAot0iehRweH3ewzag77iN81WTHpJHxJBvd9PwGS9pAgsFqIFTOeeNSoSlftmpTiNdluhgCBH/bALrmtxlOFnFtPyuuC3TSuONi2JvsOx+0ibw9HdoNvPqLwVaEwW8soYWpFJVoEsjeXT1+s81MYtAOBYE80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iRjHVmKA; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5639c8cc449so423302a12.2;
        Wed, 14 Feb 2024 16:04:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707955470; x=1708560270; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=U2JYaMyFtklDh5eCdGIM85R2vCUSc4Ghr2AddHJamko=;
        b=iRjHVmKAWYtB42Ks0nJRpuhyxUaeTVvAk3/42rgGFhCw1eJ+AE3d0LwsEWniQ8b0oY
         hBVtcAcr45Cdr0A0af8NrPoo9XXpIowUprM6eMW7iGZtf/ZzOdOESl+LjhRyIMyHVx9S
         caYlmUxWbF4EfXDw86eWDs1P6FCcDrOVb4RBp4wGIXe4I+V0jYIpc42Cr44nwTXt5OAA
         fbthTPpq8j3G2qw839zbi29Yfv5Sp4/yXnUVlsHyb3rlF3Ss+u1eES1SEFCy5ewkPPjx
         6s6CBRzhSh52Pc8b1Bq/DP7k+ym31wd1rzXgDH9ksbg5F9gDZGWTnGl6hoNp1TRwxTEm
         RzSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707955470; x=1708560270;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U2JYaMyFtklDh5eCdGIM85R2vCUSc4Ghr2AddHJamko=;
        b=irYmUV7qQhs32cLwKBu8bLSHTpfFSxQrkwiqUojEcP05byKLxEx2Ed0bmiW+tziBem
         ggl3oxKJFHruBem2vcyMznXTC0YKnNtzbbPHqSFEnshzm16EvYNTU2XXXtt0h56fgzae
         Vf/87oBEECx65HOaUs/GA7gBcXFYKojts8edLli4kIHU6nuKxeuP21We2IS47a7Vclb5
         Z7j+ffcUsApR7FPWa+eFXhkNHg/RF9sMoNkQ376UVVSFN++kl17hzs/qDWLQlchoc2aK
         fFJLjmj99nfZcdGOvPM5GNpJ7X2UEu3I4MEHBvgOD7vvyIiqpov0hHxClkkB3+5cnf8J
         JaGA==
X-Forwarded-Encrypted: i=1; AJvYcCVA8rMD5iexe6mM/AupkZHO1aYnE8z3OBxnOFmFGzGec55dPW8DKCBBnsdsa7XHfsMubl/adqPM7aencYUfq06lhjMLyO35/M08WAkh5Rms7rf07cAR0DFR9Al2iR8/+l73eP60
X-Gm-Message-State: AOJu0YxgUOxTZNEsh4KD7N0lD0lV0Cj2P0Byc56iay9/XmZCqQgC0t6q
	D8/z4A5xI/7DG7Nlk2YNlHeilB230iEjGqG+4yEbJxiXmr4+u7E9
X-Google-Smtp-Source: AGHT+IF1lnnekgMDsZ2AKEFrqUrtMCICp8AW+GkheN6Llm0zB0DHVT9Z6nf8etoqLrP3S/zgmOe/MA==
X-Received: by 2002:a05:6402:3413:b0:561:f130:9a76 with SMTP id k19-20020a056402341300b00561f1309a76mr115525edc.2.1707955470199;
        Wed, 14 Feb 2024 16:04:30 -0800 (PST)
Received: from skbuf ([188.25.173.195])
        by smtp.gmail.com with ESMTPSA id u4-20020a50eac4000000b00563a771593csm37877edp.35.2024.02.14.16.04.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 16:04:29 -0800 (PST)
Date: Thu, 15 Feb 2024 02:04:27 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: =?utf-8?B?UGF3ZcWC?= Dembicki <paweldembicki@gmail.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
	linus.walleij@linaro.org, Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com, Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 02/15] net: dsa: vsc73xx: convert to PHYLINK
Message-ID: <20240215000427.jdivtxc5jxolmi5q@skbuf>
References: <20240213220331.239031-1-paweldembicki@gmail.com>
 <20240213220331.239031-3-paweldembicki@gmail.com>
 <6db0fd10-556d-47ec-b15a-d03e805b2621@gmail.com>
 <CAJN1Kkz9NPMuoKsm4XdmGS=Y9=SkYM-_EZhqxBojfGZycegtjw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJN1Kkz9NPMuoKsm4XdmGS=Y9=SkYM-_EZhqxBojfGZycegtjw@mail.gmail.com>

On Wed, Feb 14, 2024 at 01:56:10PM +0100, Paweł Dembicki wrote:
> śr., 14 lut 2024 o 00:19 Florian Fainelli <f.fainelli@gmail.com> napisał(a):
> >
> > On 2/13/24 14:03, Pawel Dembicki wrote:
> > > This patch replaces the adjust_link api with the phylink apis that provide
> > > equivalent functionality.
> > >
> > > The remaining functionality from the adjust_link is now covered in the
> > > phylink_mac_link_* and phylink_mac_config.
> > >
> > > Removes:
> > > .adjust_link
> > > Adds:
> > > .phylink_mac_config
> > > .phylink_mac_link_up
> > > .phylink_mac_link_down
> >
> > The implementation of phylink_mac_link_down() strictly mimics what had
> > been done by adjust_link() in the phydev->link == 0 case, but it really
> > makes me wonder whether some bits do not logically belong to
> > phylink_mac_link_up(), like "Accept packets again" for instance.
> >
> > Are we certain there was not an assumption before that we would get
> > adjust_link() called first with phydev->link = 0, and then phydev->link
> > =1 and that this specific sequence would program things just the way we
> > want?
> 
> Yes, it was the simplest conversion possible, without any improvements.
> 
> Some part is implementation of datasheet (description of ARBEMPTY register):
> 
>         /* Discard packets */
>         vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ARBITER, 0,
>                             VSC73XX_ARBDISC, BIT(port), BIT(port));
> 
>         /* Wait until queue is empty */
>         ret = read_poll_timeout(vsc73xx_read, err, err < 0 || (val & BIT(port)),
>                                 1000, 10000, false, vsc, VSC73XX_BLOCK_ARBITER,
>                                 0, VSC73XX_ARBEMPTY, &val);
>         if (ret)
>                 dev_err(vsc->dev,
>                         "timeout waiting for block arbiter\n");
>         else if (err < 0)
>                 dev_err(vsc->dev, "error reading arbiter\n");
> 
>         /* Put this port into reset */
>         vsc73xx_write(vsc, VSC73XX_BLOCK_MAC, port, VSC73XX_MAC_CFG,
>                       VSC73XX_MAC_CFG_RESET);
> 
> 
> I agree that VSC73XX_ARBDISC should be moved to phylink_mac_link_up.

FWIW, ocelot_phylink_mac_link_down() also calls ocelot_port_flush()
which is more or less the same procedure for a different piece of hw.

By re-reading the commit message of eb4733d7cffc ("net: dsa: felix:
implement port flushing on .phylink_mac_link_down"), I can find a good
reason to flush the port on link down and not on link up. With flow
control enabled, packets would remain in the queue system until there's
link again if not flushed there, otherwise.

Paweł, maybe it is simply the case that you should move the procedure
from the datasheet into a more clearly named sub-function?

> Other things could be optimised and it needs more care. (eg. This
> implementation doesn't disable phy when the interface goes down.) I
> plan to tweak it after the driver becomes usable. Please let me know
> if it should be fixed in this patch.

What do you mean by disabling the PHY when the interface goes down,
exactly? Down as in administratively down, aka "ip link set swp0 down",
not when the link drops?

That's a thing for the PHY driver to handle, by implementing .suspend()
and .resume(), I guess?

What driver do the internal PHYs use?

