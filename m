Return-Path: <linux-kernel+bounces-82965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85906868C54
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 10:33:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B65DF1C20DB6
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 09:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3783013698B;
	Tue, 27 Feb 2024 09:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ehl+mHtf"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00061136675
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 09:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709026406; cv=none; b=Sde7XPgiCDQ8EIpbEOZKimBUKwqcfOj4uDbBk3BB0dY9rbtz9m/iTqmV9n5Yb56sbPzgl7pXgkbFbYfBdkneGX/UydJjaq2ag3F/JK6KGqVZRKa1r718o+BT4F2+mP26edhUtWM1kUg1Ca/a7yp/4jwn34femAgEPHD2TRTB24o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709026406; c=relaxed/simple;
	bh=kOrwJkWW/GuiFA7CyA6sLsvyK1cjc9RpN/dkCRvi1vk=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CD3Hlpw6A693DULZonsKRQkxvDR3FeNQ382FiLUMN1Agy2iuLi3wflRn2DQkCL5vZcgSxKZycsC4WjHkkp/oTUjUhXJ5YiMaUN2TnNYXWg0Oo/3ezRT9if+QJiCfWsYODGVY4r1J6udX/Iv5qv/2z/+kOL0gA+gCKcF82DvodEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ehl+mHtf; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-33d6fe64a9bso3115519f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 01:33:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709026402; x=1709631202; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZO+fVvYT4dAHrJttHWDIajXQWAvXStDBe6OqNkn5JDY=;
        b=Ehl+mHtfRa82LCNlIk7UexCTHIR1Vl5rRaWIFnHpVku9qxXB9/HN6NZpI/G1fXDp02
         hK7n83juhdR+PeFeeuVYRF4chamQSqYdGC4AwtInl9ovDVbbuegFOfEjNBegwy6Rgwov
         8fhTnW/gd/v4mTzeslRaPy2/XMomTBxi7ljlKnhFU1krrrBW0q7c5pQxdM5dxDUQVrYc
         Enk14RQ3dnoOHb0eziS2pRjYZVZHULxD80i62ksAcEZUb/tT8QWPRYUIZjp57LVBnuWQ
         seBZduak0LfO1/GwOdcqhhyLNBEMs2XfUQR2bAmH6nzwLgPcsg6iuKEA4i71lX5Cmrh3
         Ab8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709026402; x=1709631202;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZO+fVvYT4dAHrJttHWDIajXQWAvXStDBe6OqNkn5JDY=;
        b=lX/nk7i1P3D7mVsvd7kbKR+3Mjt9BCFXtUHz7xFAnP/VDw9Bqd19wHXZMRKp5hsUw0
         VczhzID2wCLhjnb+pf8FmuOkX70vUCfD4PYcBJJuy7lZFomuN4NkF9sqlX4y70tKjbje
         yurNqbr3K9Lfa/0RJqcAqmKYZrU9VBbU8+EYiFHPl6QzV7qHSdl+mEqvv2FsX26uN5zW
         6j7cg1YIlGa3dYZGB3Sl1D5MUbaEN486XeKuXsZQvHm96tCjdwpoTRnMZNu44YlsxR3D
         BJHo0kVgJCCq38aSV9XjJ1hr0x+0ocAdFakAJ2Zvno34+z5F802BCdp2OkmgCaIumJnb
         GInQ==
X-Forwarded-Encrypted: i=1; AJvYcCVWHkIvyrsBf2wtkGxjpbYrXyFxACU4NtNkIr35E2upM08NEMYKogD4LbddRRrc+t13AL0NhB5eEnLcey4qQubsH+mW4RnDmVYVzcgV
X-Gm-Message-State: AOJu0YyIdJ0G8V0In2r2rZZ5qyElzQnYjsRniPva0YIg/Bsaq8vhQZNo
	WtDm3ZdcipSu1G2I6cuVFJ/bNWBfvrsJYNnNB4rCNyXaSAvKo1F0
X-Google-Smtp-Source: AGHT+IG52GbGx7L1akWKfhHhkraAZLo5t6gUtoUDZpAOXgAOO4xK/CVxXGuQV6KkJ2HPJ5K0/H+4Kg==
X-Received: by 2002:a5d:4743:0:b0:33d:73de:d552 with SMTP id o3-20020a5d4743000000b0033d73ded552mr7058498wrs.61.1709026402016;
        Tue, 27 Feb 2024 01:33:22 -0800 (PST)
Received: from Ansuel-XPS. (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.gmail.com with ESMTPSA id ck12-20020a5d5e8c000000b0033d9f0dcb35sm11061913wrb.87.2024.02.27.01.33.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 01:33:21 -0800 (PST)
Message-ID: <65ddac61.5d0a0220.a0c6e.35bf@mx.google.com>
X-Google-Original-Message-ID: <Zd2sX0qUNY0ew_lE@Ansuel-XPS.>
Date: Tue, 27 Feb 2024 10:33:19 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: Michael Walle <mwalle@kernel.org>, Pratyush Yadav <pratyush@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>, linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org, David Bauer <mail@david-bauer.net>
Subject: Re: [PATCH v2] mtd: spi-nor: Add support for BoHong bh25q128as
References: <20240220200325.19089-1-ansuelsmth@gmail.com>
 <f7c45e7b-993c-444b-8710-042da7512bbf@linaro.org>
 <65d9d08f.df0a0220.988bb.3177@mx.google.com>
 <CZEVS9033HET.1NPH0K6PQLR87@kernel.org>
 <4d117770-6e0c-412f-ac1a-d9ba84b5b4ba@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d117770-6e0c-412f-ac1a-d9ba84b5b4ba@linaro.org>

On Mon, Feb 26, 2024 at 10:53:34AM +0200, Tudor Ambarus wrote:
> 
> 
> On 26.02.2024 10:51, Michael Walle wrote:
> > Hi,
> > 
> > On Sat Feb 24, 2024 at 12:18 PM CET, Christian Marangi wrote:
> >> The user just tested this and It seems there is a problem in JEDEC id?
> >>
> >> [    0.726451] spi spi0.0: setup: ignoring unsupported mode bits a00
> > 
> > What SPI controller is used in this case?
> > 
> >> [    0.732850] spi-nor spi0.0: unrecognized JEDEC id bytes: 68 40 18 68 40 18
> >> [    0.739725] spi-nor: probe of spi0.0 failed with error -2
> > 
> > And what kernel version is this? This should only happen if the SFDP
> > header is wrong, but according to your dump, it is correct.
> > 
> 
> I assume the test was done on an older kernel, where the identification
> of the flash based on SFDP is not yet available.

The test has been done on 5.15 and 6.1. The support for this was
introduced later? Can you point me to the commits so I can backport
them?

-- 
	Ansuel

