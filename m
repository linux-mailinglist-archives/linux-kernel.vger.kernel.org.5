Return-Path: <linux-kernel+bounces-70564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A1771859930
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 20:59:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31F78B21210
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 19:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B11071B4E;
	Sun, 18 Feb 2024 19:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R9nm3XZ0"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212D31D689;
	Sun, 18 Feb 2024 19:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708286357; cv=none; b=dbFRJeJp5X+jR4qwu/rXwzr/QX2dooquFDXaFWA7dpD9amIeQhLRBHDbGLBFC9DLo7xEwJeDXcpJOlzaFiubVM4u6NmVm52rByxVGa/9wNHHf6Ma9IxDUbleC1SGNtFNVgJZ+jvf/mylwfBzZq5ViVB0lRA0QrPdrE4yMlpYqr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708286357; c=relaxed/simple;
	bh=mtYVGYqrcZThi0f8kTrPi2RQIdlBdDSazGXV27N9Y/A=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=csKqGOAfwPuOnQEINDgPnfNtIkYdaepsJ0qOv0Nl4lhwRH1jCOF8huAWWtP+zpXMeYloYkhe59mEwWYpmOvmaEMb8ytU2i7DjnugMebrFnUhpQWcHRf25OHPzE7FGhbsCjGcjFO5m4tbJXN7dYh3wehaK8aIen78i5W6ThzMcAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R9nm3XZ0; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-41261233e61so3040995e9.0;
        Sun, 18 Feb 2024 11:59:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708286354; x=1708891154; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=o1OJWHwsLe5Ksr9YLKIBrbQqjA4TyujMo1Gkhq9EkQ0=;
        b=R9nm3XZ0FKsP+eJFftNeoYo7kNOHseTmLftW/a3bxKkZH3ZyozhPMUNVBsWEdC9p9H
         rYi/S+mXwDzqlbBl9WPb/jycGo9/cv60oUUafvwbM3z7py8HBF+sGv1G/yp5uLFPZtCU
         ugvxxXHOpX+pEEoObwqAqI8+xw8+lAdbgKC1WEBwyQ6xcGRT38uczap1kwROXLxUoZkv
         952A3Jrdsg6vJfdrho0MUyn2ThniQMUioR6Zi60Hdlr25b0qDc/nqVRHw6A8jWo2l3Bm
         /62cEV80yjc1EBQ1GF0l3yhR9Jr7dmw6hgqCrXaZZvPz1EAgseQEpohhPsYWJgD0+KdF
         mVVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708286354; x=1708891154;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o1OJWHwsLe5Ksr9YLKIBrbQqjA4TyujMo1Gkhq9EkQ0=;
        b=U9WLhVNMwyoSGs1tWy/30gOcae4uwD6NudsFeUAbK5zVZm+CiQZygjoB0KrAqP5qQh
         ReA+YqYLz+XqI99ZRsL6W9kwA7mzAj9Gv01iHlp9OxlPPkf3bsMrIDWW4f7YaF4QVvlh
         rOHUGoK8ZO2rqE1tXTW1oZBnBBTJtf3sOKcYqUGevvKfXWgHSGMdc8rI6WRJPYfdPEDh
         0fBRKWjesQsymsdsWwUakeKahkBVD53Ip1F94yfZ6lz48ri/DEXOzqb6vntRhhiGbcKp
         vMUPKNB6tiREy/87jwj1w2MQDu1WV4jT2tkx9wldmQ4s+11ZBS49rYFMGU6VE9l1behr
         3fnQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbCcsCbrIDpzmJySq0AMmV23R1EdHdaqcbN62kCVaZvCEEQz6LnGKLT80Rh6ATJB1ILMOMwp033oYrlbal8CCFifjgQ7GbcUeXCpvaW5ELGMA1mSPMcAQ7Bf1Qaxv/5ogBuIkJ
X-Gm-Message-State: AOJu0YzNDtW/oZXk3aSkOoMKB4hu4h9N5KCUm+LYT6YfAcC1JmJmGGKs
	N1j/Pa0+dPVX7mOgIK1Z+Lfb0h9lrLKFNVfGAWLTarU+L0ycfp8T
X-Google-Smtp-Source: AGHT+IGsD53MPPTmkciafnCOHdqyJw/fXy28ZlLmotusNidntZcAAn8ik0eUsF3bO+U0JObvC+/pLQ==
X-Received: by 2002:a05:600c:4f8a:b0:412:4731:a5e9 with SMTP id n10-20020a05600c4f8a00b004124731a5e9mr5932473wmq.4.1708286354252;
        Sun, 18 Feb 2024 11:59:14 -0800 (PST)
Received: from Ansuel-XPS. (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.gmail.com with ESMTPSA id u12-20020a05600c19cc00b0041061f094a2sm9261097wmq.11.2024.02.18.11.59.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Feb 2024 11:59:13 -0800 (PST)
Message-ID: <65d26191.050a0220.8ac8c.1e41@mx.google.com>
X-Google-Original-Message-ID: <ZdJhkjb7kM462GYD@Ansuel-XPS.>
Date: Sun, 18 Feb 2024 20:59:14 +0100
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
Subject: Re: [net-next RFC PATCH 2/6] net: phy: fill phy_id with C45 PHY
References: <20240218190034.15447-1-ansuelsmth@gmail.com>
 <20240218190034.15447-3-ansuelsmth@gmail.com>
 <ZdJcArE5/hXb1xFe@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZdJcArE5/hXb1xFe@shell.armlinux.org.uk>

On Sun, Feb 18, 2024 at 07:35:30PM +0000, Russell King (Oracle) wrote:
> On Sun, Feb 18, 2024 at 08:00:28PM +0100, Christian Marangi wrote:
> > With C45 PHYs that provide PHY ID in C45 Package regs, PHY device
> > .phy_id is not filled.
> 
> Intentionally so. Clause 45 PHYs don't have a single ID. Marvell
> 88X3310 is a case in point - there are at least two different vendor
> IDs in this PHY.
> 
> Trying to squash Clause 45 PHY IDs down to a single identifier is
> not sensible.
>

As said in the cover letter was something I notice and was curious if it
was intentional or not. Thanks for the clarification, I will drop.

-- 
	Ansuel

