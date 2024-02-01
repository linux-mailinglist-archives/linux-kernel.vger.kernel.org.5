Return-Path: <linux-kernel+bounces-48559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34A2B845DDD
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 17:56:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD7FC295918
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 16:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0454F5CBE;
	Thu,  1 Feb 2024 16:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="memqZ//+"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72271468C;
	Thu,  1 Feb 2024 16:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706806575; cv=none; b=DkDtSzLCyJrO+De1cpWOhwW7fKiDZ7l6b3vQ28PXvuf9SY3Umc5+C/WqAGwmXVhs/ZJhjfZdq/ClSPRbDp/ewJg+IxMnl4gnYDASqTZhHihyXClAYFXIoOmjnoWNPvX3BUYc0vTmGP9qCKIFDnltKOXcjxgj3fDDCRTaugETpRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706806575; c=relaxed/simple;
	bh=z3Remv4QfHt/lpAm+q6drL+AsGVbzUcUothMsaLNhTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C3gadKLrRiw0yQXgt0m4m1iVFdrfXtxwvf8/KEwVFkdKkGGZF0vvDjPFU7igDXTEVx8FSMuPhGal1f6cFKRpKXp+B0ATRKdqgMfdmCmcjxpNSFlbQYmvSwRu2DD+TwpcJBdmzm1vbG3iDIAF4LvIpWiwiRxgG3MTtPG6DMHh2qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=memqZ//+; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-33b0e5d1e89so811062f8f.0;
        Thu, 01 Feb 2024 08:56:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706806571; x=1707411371; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WRONz3zs2Ye8kp8mlNb2mkGa+oDmC9gtz59sMXR+/Aw=;
        b=memqZ//+/GIPJydCbOq8OdYi+Lksvq5kWAaDqpiCbeLyvFCd86JcoawneAxshEg3Y4
         XPJW44tqBm3ILm4Vp6s2lkGyIv9bkS9LvleXTbE+rlPB7CPZARYcYPKHJXiFKKzWSvBZ
         BAcbj1DkAcoyrUozri9BcKmcNnzG9XZoCHTfHHhswaVr2fF2ss38oCiO8OvN+HBoj8JA
         buoxLhakKMP6z8bD84J/qoHEDYTc6zjU5pUW0V7e05ZDZvIqnAyvcyBxTutjZpjyl4jr
         s8g6M6w2eOLyeB3PU5LSAKNoh/KVdLgZvhR66sYJkknNBrvcxFqekbY4fgzRbEhcfaUm
         6Xug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706806571; x=1707411371;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WRONz3zs2Ye8kp8mlNb2mkGa+oDmC9gtz59sMXR+/Aw=;
        b=lXxPj+RRrZqfCNnxqgdjJH18AMjEuirlH+jgEUVENYCvi6Gd+LZrSk0q6iTJWxwkz0
         IcRBe/v/w7miCEzARvyPQDfJalSBEOikvPz55LwQZ6mSDE4/niECLxfJQAA2lMPPzS8f
         WzxaBp/nt85zJXxFHwkWxhs/1E+/1fQ/cz9bnWtcIdQzEkgtAUJr7v07bGUdQnIScUjb
         lP12HWba02yLrZeA+Q9/fCoQaLhE2ktqVUwY1V/inT11UqLiqaM2ekoyyeMlmXXPcugP
         Cw+jZu+WIE+sxt5HYcXLUSS58TOqNW98HBueL8API9THli0ZlfA8u+eE161xMffiBVVd
         94HQ==
X-Gm-Message-State: AOJu0YxnGTKuz32+QmuSKk5OHETQVqRrmukEHlyfiw9J4m0t3JIR4W5e
	Ieq+AjPxDQdfvW+ZesPJGjwT/DAoVA0bD2piKNyZjXu1F+kHpQvY
X-Google-Smtp-Source: AGHT+IEN7piBAHgnsH6iF/KjuouX1TsTmXKCFnH6zypAeAmK3ksCuMdXsSBTTbmVGDAgLcth2+4FKg==
X-Received: by 2002:a5d:64e2:0:b0:33b:17c5:f25a with SMTP id g2-20020a5d64e2000000b0033b17c5f25amr1723832wri.64.1706806571598;
        Thu, 01 Feb 2024 08:56:11 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVeIhYc1bdHcoOq49k918ll9ufcHPwUS1uMRPCBVPg6NM0QHqmbl/8a0+Kc5D+nxToRxKb/os+NbNRaE3FUHYWb/AeDqmke6MYZm6AArQbY7vrqUj7uLw3vNSWx6DFnLUgeNkGzW2Ao9uLsQnWudVBvld+j30BEGZ2MuXDbFtxUTqRjKHi9RC704VM2/KdUOy3ZupHBL3YzIwvpQgO1f13eeixA8M0n3RAPQuyEqNV93YVjbDzeGvziclROkPQIo5M09LswlYi3yzOJnQ6sFvZYxGjG9mRMaJyNVS4S2wxF2fYiz521256/m6G9gEcqYIpHPBF3IFZbGsNq99Lz0nVA2S+xk7zuOjBL6gmHAglKGZ15hyiFj3FAJm9i9nQrXIlz2g==
Received: from debian ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id ba15-20020a0560001c0f00b0033ae54cdd97sm14380311wrb.100.2024.02.01.08.56.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 08:56:11 -0800 (PST)
Date: Thu, 1 Feb 2024 17:56:09 +0100
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Guenter Roeck <linux@roeck-us.net>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jean Delvare <jdelvare@suse.com>,
	Stefan Eichenberger <eichest@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH v5 net-next 08/13] net: phy: marvell-88q2xxx: add support
 for temperature sensor
Message-ID: <20240201165609.GE48964@debian>
References: <20240122212848.3645785-1-dima.fedrau@gmail.com>
 <20240122212848.3645785-9-dima.fedrau@gmail.com>
 <88a60be9-083b-4618-845c-6983bcad3540@roeck-us.net>
 <c9866a56-d82e-4a3d-b335-db22c0413416@lunn.ch>
 <a02c7451-8515-45d4-ae7b-9e64b03b5b38@roeck-us.net>
 <20240201162349.GC48964@debian>
 <b4fc0bc4-1585-4ae0-a980-10814e6d9ff6@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b4fc0bc4-1585-4ae0-a980-10814e6d9ff6@lunn.ch>

Am Thu, Feb 01, 2024 at 05:47:21PM +0100 schrieb Andrew Lunn:
> On Thu, Feb 01, 2024 at 05:23:49PM +0100, Dimitri Fedrau wrote:
> > Am Thu, Feb 01, 2024 at 05:39:25AM -0800 schrieb Guenter Roeck:
> > > On 2/1/24 05:27, Andrew Lunn wrote:
> > > > > > +#ifdef CONFIG_HWMON
> > > > > 
> > > > > HWMON is tristate, so this may be problematic if the driver is built
> > > > > into the kernel and hwmon is built as module.
> > > > 
> > > > There should be Kconfig in addition to this, e.g.
> > > > 
> > > > config MAXLINEAR_GPHY
> > > >          tristate "Maxlinear Ethernet PHYs"
> > > >          select POLYNOMIAL if HWMON
> > > >          depends on HWMON || HWMON=n
> > > >          help
> > > >            Support for the Maxlinear GPY115, GPY211, GPY212, GPY215,
> > > >            GPY241, GPY245 PHYs.
> > > > 
> > > > So its forced to being built in, or not built at all.
> > > > 
> > > 
> > > Even then it should be "#if IS_ENABLED(HWMON)" in the code.
> > > 
> > >
> > If using "#if IS_ENABLED(HWMON)" do I have to add the dependency in
> > the KConfig file ? When looking at other PHY drivers, they do.
> 
> Please follow what other drivers do. Its easy to break the build,
> resulting is undefined symbols. What we have now works.

Sure.

