Return-Path: <linux-kernel+bounces-7610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 233CA81AAC9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 00:10:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BC061C20DAC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 23:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 438194B15E;
	Wed, 20 Dec 2023 22:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VwIuqz+G"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271494645E;
	Wed, 20 Dec 2023 22:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40c39ef63d9so2031965e9.3;
        Wed, 20 Dec 2023 14:53:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703112798; x=1703717598; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Nclggf2he0zPUgzUtzVNusuGq5DYWatgL0vR1Ajc/sA=;
        b=VwIuqz+Gg6+8CJntNRu363aVzqdj30oezjxtzHL2LsAXHLSI1L4o0NiCsyF+zHFmI2
         /5X7F6Jzd0UVs/RanTHmdc4qJNUtRLyFGtTWLmiaOes4jJGd+wjtoPmj9dnlQUenSpfR
         LueN2iILO7p+rdj+2y78zXrhog/GBaEKj9Ax+PhhD/vDabpcbL2DfxPCMvOvwVvnOAJ7
         folq5DDmb4av63DEU6Ks6OUK/j8AZ0YcDDw5qWIvaSYRVgY2cgxJsiTtd7NNQ4tWAWa9
         Pt/0U6FKlhdMRNUFNTRYoqsZvoIc7kEs0qzfiz7pk9HUZC3egr17HVXI0VS4Pd9zu72+
         1YHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703112798; x=1703717598;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nclggf2he0zPUgzUtzVNusuGq5DYWatgL0vR1Ajc/sA=;
        b=ngZcRfLbjvaJ2D6Dz5yghgV313B4iVcQWchEHlAbyIBbHbt7++NtuanZkvle7Pb2sQ
         UGfsqN/IPuc9UfVDxeXgZnjunQAC6+NL95JAdlPJh9iVHQlAyBBCAdNPxzf0WiuvGMtV
         kMjGa3Jq3IDG/Ij24klsVV8KfklD4GW0zICaXjV5kNBAmnNloWhqXnmZancvRAEOZzJ0
         WjtsM5Agw6xjVYfEDqOBIWFtEUDprLdSjf0j+tl6uQODalCkpuSJWrpeRAjZB6Rhs6Mc
         nlJtWZAc0MC7MqG3CJ4TcWW3/o6cfFrjpcfLo3MlcNevJjsCQs6KTIOGp+rvzZxjb/1f
         wILg==
X-Gm-Message-State: AOJu0YwvisihHAce/bWCIPihD6sgknIZnsZ9mgZtY1oP4ahA99GqGxKd
	gU/Y3JyAHyIc0p/q+OaBq/k=
X-Google-Smtp-Source: AGHT+IEo1z37b4hacYUj8UoMuL2erFGk05NYdH5xhxZpFqVleEHWWiPf6XIphny9MgRFLeQT953pFQ==
X-Received: by 2002:a05:600c:b57:b0:40d:3d64:1145 with SMTP id k23-20020a05600c0b5700b0040d3d641145mr46511wmr.131.1703112798070;
        Wed, 20 Dec 2023 14:53:18 -0800 (PST)
Received: from Ansuel-xps. (host-95-250-248-68.retail.telecomitalia.it. [95.250.248.68])
        by smtp.gmail.com with ESMTPSA id w20-20020a05600c475400b0040b4fca8620sm8815820wmo.37.2023.12.20.14.53.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 14:53:17 -0800 (PST)
Message-ID: <6583705d.050a0220.6e903.083d@mx.google.com>
X-Google-Original-Message-ID: <ZYNwWkr2znb7A--K@Ansuel-xps.>
Date: Wed, 20 Dec 2023 23:53:14 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Rob Herring <robh@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Tobias Waldekranz <tobias@waldekranz.com>
Subject: Re: [net-next PATCH v4 1/4] dt-bindings: net: phy: Document new LEDs
 polarity property
References: <20231215212244.1658-1-ansuelsmth@gmail.com>
 <20231215212244.1658-2-ansuelsmth@gmail.com>
 <20231220152209.GA229412-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231220152209.GA229412-robh@kernel.org>

On Wed, Dec 20, 2023 at 09:22:09AM -0600, Rob Herring wrote:
> On Fri, Dec 15, 2023 at 10:22:41PM +0100, Christian Marangi wrote:
> > Document new LEDs polarity property to define what mode the LED needs to
> > be put to turn it on.
> > 
> > Currently supported modes are:
> > 
> > - active-low
> > - active-high
> > - active-low-tristate
> > - active-high-tristate
> 
> Why is having a polarity unique to LEDs on ethernet PHYs? It's not. We 
> already have 'active-low' established on several LED bindings. Please 
> move the definition to leds/common.yaml and extend it. I would simply 
> add an 'inactive-tristate' boolean property (if there's an actual user). 
>

Should I also drop the active-low from the current schema that have it?

Also we have led-active-low. (should we support both?)

On the marvell10g series we are discussing of using tristate or not. We
notice tristate might be confusing, would it be better to use
inactive-high-impedance ?

> I do worry this continues to evolve until we've re-created the pinctrl 
> binding...
> 

-- 
	Ansuel

