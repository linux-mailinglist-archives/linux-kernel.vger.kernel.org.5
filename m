Return-Path: <linux-kernel+bounces-63790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89EAB853468
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 16:15:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 289CD1F231F1
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 15:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD34E5DF0E;
	Tue, 13 Feb 2024 15:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FyA5XqZ+"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1FE58105;
	Tue, 13 Feb 2024 15:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707837352; cv=none; b=q4B9m0CD5hQ2SMeYlsOuuX1ytANaQnF4Bxa7T5JXKjfAeuqAWWqhbUK36OgdxT3j/mVCAwBh3HR/NNZ5vN+5ux4kQglqx1hudSUYr81WYRZB66vb0u/JE9ty/M3A4NJcowrbHkWn8DuWP0S3DvzqJBrm/kbBTGn7XWadLLB3+YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707837352; c=relaxed/simple;
	bh=k4oOxKcYZyEq6YjY1eN1q/nkEMvOrsu2JIaDdZAAxNM=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AenJzrUJWZ3RysZLPLpRhff+c1rVOJuI5iCsc1gne/rMt6KyFCCIqZk76LVBz4DdMS6LiSNceulHlngE9T247whaj2GZhVETy7c0tL1P3Wy7qB6d8Hcxl2EY/HAAhgGsiJwXeS1ElbQ+z5gO5sbk6w8i+o6qVIn0DOFiT9XoC4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FyA5XqZ+; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-33aea66a31cso2630596f8f.1;
        Tue, 13 Feb 2024 07:15:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707837348; x=1708442148; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=EWbtSDfnGjcwi2wHYGMjwerm3bMEBcFqsyDVWZr+IWo=;
        b=FyA5XqZ+VgCKdkOXE9bEWhORJYG40LvluWfaN3sIkp4B28dtruth67iHF29vR9rVY0
         b+XgjMWHRmgUZC6MKaW/lKYaYIEt4g/hFQFOMaLbe8Q2ohPBksZwdVTmn8WKwUcNfroj
         WHHoh3uegencWceuDi8kXTT1jNht4+YUfaguie3DVDSCmVN+rUjnFe0fGXYlYbkNUM25
         nI2v/hQ86TKUC5/dp/uSt2QlZe5m0h9XB9Gfv9xnBbzIhxb+3RjmnEJZvxkmdUSOr/HV
         PXjI/b5Wp4hN/BK229GoDBihbiEVSUYCPruyG5kOLVeb6ZImq0fEmS1DVf4DFJOQsSsM
         97tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707837348; x=1708442148;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EWbtSDfnGjcwi2wHYGMjwerm3bMEBcFqsyDVWZr+IWo=;
        b=AJlh4DRJo3h+z6RAlt0hnqvH+3igWa9lqFqhz4xxHWqwnjelLi5AmGLDlHRwEobcG5
         LXVTVkaqHmFy+LgOVLMrdSHdUYpjWKnSIDguOh3s72ZMJ2vPsuPzq73pJQ9C/YZyCJGc
         XkgywD4z5DdN6rZHtytsf+qfohsR0i9TF5x14NV0hfLiH15Qd71ECwiII4IlUFqdA4FU
         sVDDv5QECCfcP2PNOtzcxbs9B9nMWRjXgxwZFR6Pu5UuD3Z7sk77O8S1OSogKdqcsoqY
         QzvMN3UKPTaLYF9rLjA82x6tvUId4qHiGJee+rcidi7YkcInbqKB5WE9kJa/Qznt3lpE
         DNVQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7+hKNz8zboKwrOMiAw6nL0VFFrHLwHAPy6CEBbuchVOnzaht13BcFgFmwgbMDR2KFOIIp6HsLjzAi1GP12A72IkdqsaChGi5BC4+TquG08ol4pBSX7r6Chib+nHukGVlBn1y4
X-Gm-Message-State: AOJu0YzxESwp2r6mla/dqEPZxT+u8JVSMuBF4NAXRMobVYswtwbJx7c3
	mLZtsbdLnyVlj9Bcf57bZYnCIF/d9/dB3TbMiEwfgx7dqu1OCPlN
X-Google-Smtp-Source: AGHT+IH69la8E5K5xN63QUjTTjL/gRgiJhgdVnK5KDBw4Z57Fo18hW3gp/Eu/FOsO0A80Njt1SUpxQ==
X-Received: by 2002:adf:ed06:0:b0:33c:d4ff:5fa6 with SMTP id a6-20020adfed06000000b0033cd4ff5fa6mr1616648wro.22.1707837348081;
        Tue, 13 Feb 2024 07:15:48 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUui7VsYHqf6B5cyTVHLemd2BjrwSswNPAYDTk+TKfE/yvAhodjZFkcBtt8YLWSFTk4K55KGR2O04vzSdq9XE9jLDJj1xCItsGWSZTEstc1AgYlCAykwIFop+Qo1DxlxJM9VvibUuXxJRBA8kPU31TsHJm1k0A4zyQR00lTXb/C5WPF08Cxa6Dq4ocRgKrX+GA/+Wn1MTfChGo2UPvnoADmfPrpzQ4S7ope4gVgoNrSLo4X6V99oYbC2M3onzg1jzzPi2tSvrBhRQyhfGsMqekvE8yTqmJJHySiuVaJA1TalVhSOVl54KDYSggXTjI/JcgRGVcuhrtu5eZi
Received: from Ansuel-XPS. (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.gmail.com with ESMTPSA id ce9-20020a5d5e09000000b0033cddadde6esm1537692wrb.80.2024.02.13.07.15.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 07:15:47 -0800 (PST)
Message-ID: <65cb87a3.5d0a0220.69795.6a1d@mx.google.com>
X-Google-Original-Message-ID: <ZcuHn4Sg4Yrv2NLF@Ansuel-XPS.>
Date: Tue, 13 Feb 2024 16:15:43 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Robert Marko <robimarko@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH] net: phy: aquantia: add AQR111 and AQR111B0 PHY
 ID
References: <20240213133558.1836-1-ansuelsmth@gmail.com>
 <233cd45b-28d5-477d-a193-8273684953aa@lunn.ch>
 <65cb7a25.5d0a0220.de7b7.a1f3@mx.google.com>
 <a10c3b55-c6c3-4982-b294-d6e5b9383e31@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a10c3b55-c6c3-4982-b294-d6e5b9383e31@lunn.ch>

On Tue, Feb 13, 2024 at 04:10:01PM +0100, Andrew Lunn wrote:
> On Tue, Feb 13, 2024 at 03:18:09PM +0100, Christian Marangi wrote:
> > On Tue, Feb 13, 2024 at 03:09:57PM +0100, Andrew Lunn wrote:
> > > On Tue, Feb 13, 2024 at 02:35:51PM +0100, Christian Marangi wrote:
> > > > Add Aquantia AQR111 and AQR111B0 PHY ID. These PHY advertise 10G speed
> > > > but actually supports up to 5G speed, hence some manual fixup is needed.
> > > 
> > > Any chance this is a "golden screwdriver" situation? The chip really
> > > can do 10G, but the firmware is supposed to limit it to 5G? This is
> > > just a firmware "bug"?
> > >
> > 
> > >From [1] the PHY can support up to 5G so yes it is a firmware bug. I can
> > try searching for some regs to fix the wrong provision values if really
> > needed.
> > 
> > [1] https://www.marvell.com/content/dam/marvell/en/public-collateral/transceivers/marvell-phys-transceivers-aqrate-gen3-product-brief-2019-09.pdf
> 
> I think you missed the meaning of golden screwdriver.
> 
> https://www.urbandictionary.com/define.php?term=Golden%20Screwdriver
> 
> It could be that the silicon can do 10G, but marvell are selling it as
> a 5G device, with firmware limiting it to 5G. And that firmware
> limitation has a bug, so some of the 10G functionality is leaking
> through.

Oh! Yep I didn't know the meaning of Golden Screwdriver.

With the amount of things we are noticing on these PHY it can be
anything from Marvell itself, from OEM messing up with the Provision to
a buf in the FW itself...

(example that thing that Asus made on the other patch where they HW
disable the port by default, that is against any default spec of the
documentation)

(or also a patch that I still have to submit where some manual fixup are
needed on aqr112 since the FW mess with the SERDES startup regs (again
probably OEM not correctly provisioning the FW))

> 
> Anyway, you change looks O.K.
> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> 

Thanks for the Reviewed-by tag!

-- 
	Ansuel

