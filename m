Return-Path: <linux-kernel+bounces-69333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 986DD85877F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 21:53:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 552B928C860
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 20:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF28913A88B;
	Fri, 16 Feb 2024 20:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QELlytjF"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD231D690;
	Fri, 16 Feb 2024 20:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708116789; cv=none; b=Jpgs8E/NU9fQuY7RLko+/qccbULCVtRRGFT3ya/M+LBgU3ksVIELgVGM5w+knimTlN2o+2UYEGpYxGhWZce0GsGvGNZWN4+yXmPUZV4HSGLt3GyE+Z4U/EAs1W2UDnyc6LEtAOnsId8btS+aG0OwRYMgHtc43Rm+Eao6u5VHPIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708116789; c=relaxed/simple;
	bh=bJFoLhJIy8Ldus1bMGVPuw/0hLQGmz9TRmx5cOR8DQg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P8W1XCDNwtg9ok5M/kNmi2ZtsBuewJQRgRWPUT7KWqrJqcHvhF3kjLjtBvRauisOM0zFxjvZ6/aE9o3SSlooUUOmRE1ScyYkYaAlbR5/vtbmj/8Ua/MLt0NrStd0uF4mdPs7r+KYOR7kj1LoTUBHIrypJwDq3a4JbWO/Mo77ShM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QELlytjF; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a3d6d160529so150709766b.0;
        Fri, 16 Feb 2024 12:53:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708116786; x=1708721586; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8k6u5v/IIS31CpQ7yJE8KmztE2tyWtuh+i65Ku7owlg=;
        b=QELlytjFBzR/hQ50JgRxKzlgoe7JJuhc9/z3Tvb7DJnCmDO4Pa3B6XRyIrFNkLzCoS
         NeCdtAH0M8NO4pyz7yw4rD/RnVs+EJzaw5T+s1sql+uJxkd+X4fLwctxSe+9rpVhTuaS
         iRs5DVd6oE6zn3zOnnJZGY/y64Lobpqj1XxcdPP2kU936Pydy4eBguTEISKPHSHbeW1n
         zKmQxDYNiSrC5NN9Wp1ne1HXAPlE1lWjglqMEHJzld6nfzoXnjShGDRfcCYWHMtZUjzw
         9C5oM2ClXI0ilcZfLTICEh7FkL/ryUHA7rPNi5Xt32ji6PzLEm+rikexQ/+1+M0w0DPG
         Wq0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708116786; x=1708721586;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8k6u5v/IIS31CpQ7yJE8KmztE2tyWtuh+i65Ku7owlg=;
        b=AKFtRpndjlCyY+urTz22b4hEQ9Qu8CORfI7+YaovLj8b44hjeME4E/nCuca4//kdxH
         3xSPKo90TPzwH6DfqOsrLWz7HgCbVQbbo00V7129SQ7TVuOvnI2vvTujBU4XRYSDcUUo
         Z88vhynbMJD8PhRC5wsdxK8iy0FQMGni12JaLpsmvrjgBFheQChZ77cn+iZ/5/brwOdm
         lerepGcLZNQ3e/kH3SH9MbgZ39Lwv14dcIM+P+EZ1xKs+71+8yiuhAKmiLfL6WhRBJPF
         8f+7UQ7wIHmbXq0khUZ5D6/K9+WBAHWFmMgGe+Z6YCsQHgItCt9qdRAMa2p56Sm3RE1M
         YnMg==
X-Forwarded-Encrypted: i=1; AJvYcCUgip/gJYZ8U6OfWD08kiW2Z3nOpziM4+k7zmRU3sebRZmMnYeM15BuwO1mChSgNKlSP9AcAfimjkZi+aLVP+gLBEBXSTJT4bs4aJjZBis8AHCK8M/p7fegsmAdvecwS6HpTGXX
X-Gm-Message-State: AOJu0YxyoXPLImdJ3N+6j35nU0lvIYELtH0Y0UORh315o0TcR7mn7Zv+
	xYyu2E0vOxoDKm6Rwxw2IEb7WQMU6qcVptjBti5jMgEqBejHTDOS
X-Google-Smtp-Source: AGHT+IHdjG52bCC5e7grroCqkwPF8LjGui542YDrj/LbvgnC95FzO1rOxKzxAapGSYjT6tezkJ6/sw==
X-Received: by 2002:a17:906:2b09:b0:a3d:2222:7f84 with SMTP id a9-20020a1709062b0900b00a3d22227f84mr4558963ejg.37.1708116785671;
        Fri, 16 Feb 2024 12:53:05 -0800 (PST)
Received: from debian ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id n18-20020a170906379200b00a3de6cf49ebsm331799ejc.6.2024.02.16.12.53.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 12:53:05 -0800 (PST)
Date: Fri, 16 Feb 2024 21:53:02 +0100
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: Gregor Herburger <gregor.herburger@ew.tq-group.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Stefan Eichenberger <eichest@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH v6 net-next 05/14] net: phy: marvell-88q2xxx: add
 driver for the Marvell 88Q2220 PHY
Message-ID: <20240216205302.GC3873@debian>
References: <20240213213955.178762-1-dima.fedrau@gmail.com>
 <20240213213955.178762-6-dima.fedrau@gmail.com>
 <Zcy9E4riyFRk8B1P@herburgerg-w2>
 <20240215202403.GA3103@debian>
 <Zc8oUt4fnD7ltxq4@herburgerg-w2>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zc8oUt4fnD7ltxq4@herburgerg-w2>

Am Fri, Feb 16, 2024 at 10:18:10AM +0100 schrieb Gregor Herburger:
> On Thu, Feb 15, 2024 at 09:24:03PM +0100, Dimitri Fedrau wrote:
> > > Hi Dimitri,
> > >
> > Hi Gregor,
> > 
> > > On Tue, Feb 13, 2024 at 10:39:44PM +0100, Dimitri Fedrau wrote:
> > > >  static struct phy_driver mv88q2xxx_driver[] = {
> > > >  	{
> > > >  		.phy_id			= MARVELL_PHY_ID_88Q2110,
> > > > @@ -255,12 +439,26 @@ static struct phy_driver mv88q2xxx_driver[] = {
> > > >  		.get_sqi		= mv88q2xxx_get_sqi,
> > > >  		.get_sqi_max		= mv88q2xxx_get_sqi_max,
> > > >  	},
> > > > +	{
> > > > +		PHY_ID_MATCH_EXACT(PHY_ID_88Q2220_REVB0),
> > > 
> > > I tested the series on a 88Q2220 REV B1 (which is id 0x002b0b22). The
> > > driver works fine on this revision.
> > > 
> > > I understand that in the Marvell API the initialization for Rev B0 and
> > > B1 differ. For B0 some additional init sequence is executed. I did not look
> > > into the details of this sequence. However this patch seems to work on
> > > Rev B1.
> > >
> > > Would you consider adding compatibility for Rev B1 and following? I
> > > tested with:
> > > 		.phy_id			= MARVELL_PHY_ID_88Q2220,
> > > 		.phy_id_mask		= MARVELL_PHY_ID_MASK,
> > >
> > 
> > thanks for testing. I would stick to the exact initialization sequence
> > provided by the Marvell API. Registers and bits are mostly undocumented
> > and I think it is safest this way. Besides that it should be relatively
> > easy to add the support for rev. B1 by just adding the init sequence for
> > it.
> 
> Ok. I will have an closer look at the marvell API and eventually come up
> with a patch for Rev. B1.
> 
> There is also a Rev.B2 for which I cannot find any init sequence. But
> Rev. B1 will no longer be produced so I need a solution for B2
> eventually.
>
After having a quick glance at the latest Marvell API release, the init
sequences for B1 and B2 are almost the same. It differs by a single
register write. Would be great if you can come up with a patch.

Dimitri

