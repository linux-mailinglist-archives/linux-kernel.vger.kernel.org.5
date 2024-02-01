Return-Path: <linux-kernel+bounces-48683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B6E2845FBF
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 19:23:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9540BB26CC0
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 18:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AF2182C8D;
	Thu,  1 Feb 2024 18:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ODIz70cQ"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24550779F8;
	Thu,  1 Feb 2024 18:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706811762; cv=none; b=dBVN1r3NI1NX9jbEQnj60oZhlf3Wsg+XQE8L2fKMXjCL+4tGAtYK+oOqx5P2+cWV4liuJ8tCN9IC47gr/cpL0I1K08gpWDrfW7lwvUdSlN7dgCW1mA5OBZ0qRHNotnT/CuJWn2Bk9aUq6dXOeSEIXDZpbe+TfQJ3UQuYYTR3Z90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706811762; c=relaxed/simple;
	bh=cLSkI5IBu1sLgJ+AB7I0pNKDEEb48J57fLxzeatJ6vQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=caCcSGmc5c0h2vA+8f0ZxyB+zpUVxB1xbln5BbI2bBTYj0EtjB1Tig2k8pRnWfKQ3XHa1Qi30roqU9nBdFNLKsamEhQSpwNCfKB7YotD4HNFvpu+FC4Y+5koLUpC3/wHN+lNeMStECvD/948x4ki88DaqxqRZXJJq7q/3LJiSek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ODIz70cQ; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d751bc0c15so10861095ad.2;
        Thu, 01 Feb 2024 10:22:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706811760; x=1707416560; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jPhuLzzBaanFkbxZrNOz+54SWmvRq/NmuPTyh/Ud9JY=;
        b=ODIz70cQ096sIrka3M4CHxlkABBV8lMVO5rq3WEo+LZiAEI86BR9hjp6vYL3FVVj+U
         5YJ+OhjAbe1t1fgGkZ69XQybk4e/jlZ1wQqjVutagtfEfhMGpEc2qUz8SXhZhTGRiMcA
         C2p5sJOxSEO7cmFFiDTFXucF1AKVBLKhSTbS9U1iMYq3LZDUaiJwgsBVNoxoBzANjtyn
         x40O1LEBblkPszZMLIlj+WRC5it7LzfOtInLv3mr9102YGKgkvbjQS8EsxabvKIEc60L
         yPHL0EPd950Kvg04qyvJVEv7V1lfsb7vAvSDW+vr15cOmVqAb2Mhy2hiUY2lw7hs3AZ2
         UoUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706811760; x=1707416560;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jPhuLzzBaanFkbxZrNOz+54SWmvRq/NmuPTyh/Ud9JY=;
        b=we4pxHlyxXak7sxOSY6jIPWlY/dj9ugdyYBsLLHkf3rJZmhTU7wUKDctEQ4VHbkcNY
         ryeoRv7O18d2ODzCSDOypp6JggcgYBmNqZA5tJnGqDlpaNJ+IQfv54ZmJs2uBO9TdHEG
         nXmZ5RyMKCg/gdHvBv33WGMtqhszlrMug5EjhkoYSHt1Q2YzFpUrnK2hGluzkAHyHk7+
         rOAmQyVLsZwPGXRISenPC+s6oTXhSboEDkUVaxV1H2VgEBdVaokC2vkVNCWMyKx9d6tl
         lCDKPcbmke59n5Bixj9dD7DcrxXsZL4DO0aRZefuI/KouCi6zfvH047/eepJCghsZ09+
         hqyw==
X-Gm-Message-State: AOJu0Yxd+ANMISnXXitKZ6yoKAxC3gBAOShPiqtTtfWxc4j0Rhk4eshp
	r/DdKf9Qxl8jSkHd3SZV5rcAp7HbpjrHD5tvTMqna7VUsGETIZoD
X-Google-Smtp-Source: AGHT+IFeGzxHfBcXGwVjYK3ufH+44i8PF4Dp/jrC0oCoLEVT8MX9e2dDuxRGLPIbO4ofMRVQ0mtNCA==
X-Received: by 2002:a17:902:dac4:b0:1d9:5b4d:7004 with SMTP id q4-20020a170902dac400b001d95b4d7004mr1846907plx.29.1706811760258;
        Thu, 01 Feb 2024 10:22:40 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCU+IBY81Kz6rLwPzYCi1ipUBA536vINVT5q/KW0MHqg7zcBHVGVA+ThOaFFkztfMB8Xg44Iy2yxYQrJdpDIZkjAq8ABIQ9UdLHH4eGgRkDigdc6q7HitD8R25haOs9WJW4CmJf7iIp4Cxv4DM0k/eRDpGghZTrEDPjJZiPUfE7vKP6N/dgySzuvyvL49ugAHjywb3w01X2X1UsST/RtcetsXkAoK3f0qfhzoQVIo9JmOEmYIqSM0TKX5JR/fjlQ9sI9G6BvrR/yjnvbY+WHiyz9Cdvp5+BbH8blpqkeHmBZ06ztuMYKCvd59lDeivoGDsuKnLvq1s5Rc9ccbE6u1kR8KxnHPanfUfOVGaldB6c0KEWhaMWOirxov2cnk2acj5idvw==
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f7-20020a170902ce8700b001d91849f274sm111308plg.134.2024.02.01.10.22.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 10:22:39 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 1 Feb 2024 10:22:38 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Dimitri Fedrau <dima.fedrau@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jean Delvare <jdelvare@suse.com>,
	Stefan Eichenberger <eichest@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH v5 net-next 08/13] net: phy: marvell-88q2xxx: add support
 for temperature sensor
Message-ID: <5fdc3741-c169-4457-bffa-dab3d2ee42fe@roeck-us.net>
References: <20240122212848.3645785-1-dima.fedrau@gmail.com>
 <20240122212848.3645785-9-dima.fedrau@gmail.com>
 <88a60be9-083b-4618-845c-6983bcad3540@roeck-us.net>
 <c9866a56-d82e-4a3d-b335-db22c0413416@lunn.ch>
 <a02c7451-8515-45d4-ae7b-9e64b03b5b38@roeck-us.net>
 <20240201162349.GC48964@debian>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240201162349.GC48964@debian>

On Thu, Feb 01, 2024 at 05:23:49PM +0100, Dimitri Fedrau wrote:
> Am Thu, Feb 01, 2024 at 05:39:25AM -0800 schrieb Guenter Roeck:
> > On 2/1/24 05:27, Andrew Lunn wrote:
> > > > > +#ifdef CONFIG_HWMON
> > > > 
> > > > HWMON is tristate, so this may be problematic if the driver is built
> > > > into the kernel and hwmon is built as module.
> > > 
> > > There should be Kconfig in addition to this, e.g.
> > > 
> > > config MAXLINEAR_GPHY
> > >          tristate "Maxlinear Ethernet PHYs"
> > >          select POLYNOMIAL if HWMON
> > >          depends on HWMON || HWMON=n
> > >          help
> > >            Support for the Maxlinear GPY115, GPY211, GPY212, GPY215,
> > >            GPY241, GPY245 PHYs.
> > > 
> > > So its forced to being built in, or not built at all.
> > > 
> > 
> > Even then it should be "#if IS_ENABLED(HWMON)" in the code.
> > 
> >
> If using "#if IS_ENABLED(HWMON)" do I have to add the dependency in
> the KConfig file ? When looking at other PHY drivers, they do.

Yes, to handle CONFIG_HWMON=m. Note that it is "IS_ENABLED(CONFIG_HWMON)"
      				                           ^^^^^^^

Guenter

