Return-Path: <linux-kernel+bounces-48555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E8C7845DC2
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 17:52:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D108E1C29AAA
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 16:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C52385257;
	Thu,  1 Feb 2024 16:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hq16+ADG"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845306FB3;
	Thu,  1 Feb 2024 16:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706806347; cv=none; b=EgzK7/gt5rRYYLkvGMx8kQHbfl01fZHAjKXfHLrNii2TEJFxTxUwZ4tf5Np0lLBuR6o5j6wcUoZvguUnvelCAJBzbwiZEwp6upvpK79acOyVyjVPPQIU5TtsCquUTRpc6BgxSREIkgXOGxVhLymVdwfb5tQ4whiY6n/VdpAgj64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706806347; c=relaxed/simple;
	bh=vz6LudJL4eKqv3CjXYHs2B5Tec5lKHc2ygrfhj4xYF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pmrfRB/s0BEQ3ASpGf18BrjiZddaBOqFTLfaHrCvsRc4llwYRPMoyANg2AVq8dQxR/+oVrUGpekDcmoGdHO+COGAhzJicjg3+RiylOtBSYQd+oiA1WynI1js+3kvy3nCzy0sYVaCLCZWLEMT7t8iknE6S99gwyfwqzaxAeFeups=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hq16+ADG; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40fc22e53f1so4755485e9.2;
        Thu, 01 Feb 2024 08:52:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706806344; x=1707411144; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=36YMN2QmFQFae2ekkCq5RQmRrLMnTH3/M270MHoKBFo=;
        b=Hq16+ADGJeV7plohduFbAFAcY21rUaCR4aGpsIjbuBY/CG9iX4r/U+8AVNIT9yZcFx
         73jmsKzTRIzA/N/8eeJmbR10TrmcHw+lO3e7qRr5VitEOSn3kp4sNIRD+kf+2hkOLGQC
         KLge0cu5lujkqWHlm/VyGUk17udhIyfIWQg4vTl19z3CbLVtoD+W3G6ombK7eivDK8uF
         ubpj0gWqFtt9EBbuD5E9yZ0HaqvLcYcawG95oPtdbsruLzv+ELqRdEf0fRR8esbozPVY
         09VDsNnrC1H73rFeQeXRuQ6vAzy4Kycj5JriBk+b0UXvqEUUOsYdDqx86viaVbM/zV/4
         82kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706806344; x=1707411144;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=36YMN2QmFQFae2ekkCq5RQmRrLMnTH3/M270MHoKBFo=;
        b=KtZDs8Uj+Cl/lXT8pitO0Nrb7LCf/pEjXrp3PdOYiD3/WtU50HXmlQlpEqfnN49p7w
         E30VhQisZNQ5JQ4a26FBQ4TBrtfwP4Ps4VgtiUYfua8t6kJ27brwWCyWBYTHUbGpZIc5
         Ezd+m9ePj3ZVeWjdtuhnb0GGyId04XvlHXU1rHYIqccLXDjOk9hfzInIXXDC3mXisItI
         FUMCmPPKDqU2UA33Z1an9cDKrozZgrz9A2E1uD4oG0nqflJTeTQwotJ+m/yP1BAunmtX
         fEHGw6zc18ISvVKKhet2FJXzZhsbqpyzZzR1fYAWBidbff8vdf3YEbJgmd+OPfn2mODH
         HP4A==
X-Gm-Message-State: AOJu0YzJXBfkbvJ7IBYl1P6Odk1UYk52BgRKtp6Ccd8kLE+E2Vb6mWt7
	HBjeLif+pWlaPhipRHFBl7SnqvWO3tfoehhuy+ms6xa56rE7HQJF
X-Google-Smtp-Source: AGHT+IG6yuiQUuYWLdX4eGgPosOUbrfcFbE8B2VVupH1TRMhah/T+64W/jSfdtRkeHK3qCQhtdCP3Q==
X-Received: by 2002:a05:600c:3510:b0:40f:b03d:86b8 with SMTP id h16-20020a05600c351000b0040fb03d86b8mr3730677wmq.28.1706806343568;
        Thu, 01 Feb 2024 08:52:23 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVFQ81UwtOJOLZF1rbu9HOtiRi+P6+IFJ3wq3EdVDScvs8o9ZTWl8xgfnGgKbXPYyXsg3Nx3kMYwyEAJS7Rw4Fc4nP/w2b+PQNMByDje51OAvNSabwjGUh+N1C/SmJLq32vAL9kG05OJmSEZEj+DBpdyizcxeofgdQaGbBKzFAhvxxcWPvy9aHmiThDH4cVKlvoPsiYgKD/1fONJi///sS4KP1/qOe06RfdAzAX8Ta1NjVloXiZslBE6z3/RX7SQq3Egzb8hqDr6wkTmdY4p1CexESQ6zCImpQzrsqjv3POOXhBEh+G8RePxwwz30wDDvQpoZHmHDlnioa+DzJocUr1Sdmxv37e6sgffJoW6bmQCGD9LdPKwfrthFGNOFfoHog=
Received: from debian ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id p15-20020a05600c358f00b0040fafc8bb3asm135112wmq.9.2024.02.01.08.52.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 08:52:23 -0800 (PST)
Date: Thu, 1 Feb 2024 17:52:21 +0100
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Stefan Eichenberger <eichest@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH v5 net-next 08/13] net: phy: marvell-88q2xxx: add support
 for temperature sensor
Message-ID: <20240201165221.GD48964@debian>
References: <20240122212848.3645785-1-dima.fedrau@gmail.com>
 <20240122212848.3645785-9-dima.fedrau@gmail.com>
 <65071184-428b-4850-9e0c-baaa73513c6d@lunn.ch>
 <20240201071137.GA41347@debian>
 <a8d7125d-156c-4c7e-a49d-d246719dcfe2@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a8d7125d-156c-4c7e-a49d-d246719dcfe2@lunn.ch>

Am Thu, Feb 01, 2024 at 02:23:15PM +0100 schrieb Andrew Lunn:
> > Anyway it's wrong. I couldn't find a good solution to use the temperature
> > interrupt. Will have a look into this, and probably figuring out how to
> > do so. But it won't be part of this patch series.
> 
> I don't know of any PHY driver you can follow, those that do have a
> temperature sensor just report the temperature and don't do anything
> in addition.
> 
> You might need to look at thermal zones, and indicate there has been a
> thermal trip point. That could then be used by the thermal subsystem
> to increase cooling via a fan, etc. In theory, you could also make the
> PHY active to thermal pressure, by forcing the link to renegotiate to
> a lower link speed. If you decide to go this route, please try to make
> is generic to any PHY. But its going to be quite a disruptive thing,
> the link will be lost of a little over a second...
> 
Making the PHY active to thermal pressure sounds interesting. Will look
into this.

