Return-Path: <linux-kernel+bounces-10073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53D7C81CFA6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 23:11:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB6F22864AD
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 22:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBE082EB14;
	Fri, 22 Dec 2023 22:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E0+/SbTl"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8FC2E844;
	Fri, 22 Dec 2023 22:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40d4f5d902dso136825e9.2;
        Fri, 22 Dec 2023 14:10:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703283054; x=1703887854; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=gCLvoz9oWI8Usfn961/vLhk6ER6XyjpcObYFpVk00EE=;
        b=E0+/SbTl296q0+R4Pf+VjNxSFbPld4GuphzR5TelKJApdhZUFRp96FNXSC2qWoLb/G
         6RbJRJnPPyvbo7NvYR3ViaXiMq9HhprseLdpEjmw9bl+0ilkO4laHJ51Imm5EMUMeKxA
         ecgaI9JNJEoNKM5wffX/BKDCrlDMb8uEkYKJ3/pQt+ha40a/wbhoiOICTQt6BgHiT4ZX
         kbeSc+Mmz2B460WdWj+F8d3yYl0p0LsTskvHc/VuSTB+F2IJJLb4Kf5xvLCqTv4jAkSe
         9OyqDQUO2arxI0lakJ9HvlT/aBcnO/KOWlFzrxJAJF+5D3flazauYLoXAefZ0ZJ5hoIM
         4ydQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703283054; x=1703887854;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gCLvoz9oWI8Usfn961/vLhk6ER6XyjpcObYFpVk00EE=;
        b=GbDrA+kkC+yM2FfPbM8SuqsNfFO4WMF/wRbXa6p9Ri4hj3kZMbmh9+Qouu4mcreU56
         PJZf9UtMqe/OWjs1Byzgh/8S4mgduwBepYCshvSAhOIGDxKdAatWdCxiXhpNPWTjmAW9
         bVVFZ6vpUEOTXDk9TKcLIIpRHy6zcbwUVXZIXW2A9YMIT4yoFnAB3XOtFzgVc1qabDCI
         UUqYEgrVwlap7Hf2mkXlqVF764Q9fS2w3t4EdBwHVxYHHNmXlCjwMlJ1ZBaZGejA7lkI
         AQmGZW1lq91v1xE4VtKMnqb/RdHnghpiaINJukDCQN5/oqk5p7kJkA6K4AVdochpyVI6
         ALRw==
X-Gm-Message-State: AOJu0YySqoZ7W3qBfbM9PcHLZROVzS0IB9LcjCZpvGm/5UkXoCkEsQ7p
	mYsRTc9rkMlcP5gUUKDnmy0=
X-Google-Smtp-Source: AGHT+IElAO3C56YOO2pWG1e68GcncYDxk7cc4Fb8aiDDgzJhIuHcUgD4w5UdQzlhe1VddXOuVN8uyg==
X-Received: by 2002:a05:600c:3ba9:b0:40c:f7d:27b2 with SMTP id n41-20020a05600c3ba900b0040c0f7d27b2mr1189958wms.2.1703283053985;
        Fri, 22 Dec 2023 14:10:53 -0800 (PST)
Received: from Ansuel-xps. (host-95-250-248-68.retail.telecomitalia.it. [95.250.248.68])
        by smtp.gmail.com with ESMTPSA id a15-20020adfed0f000000b00336673a4153sm5157811wro.80.2023.12.22.14.10.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 14:10:53 -0800 (PST)
Message-ID: <6586096d.df0a0220.1a02f.6ace@mx.google.com>
X-Google-Original-Message-ID: <ZYYJEW8WUKnNBzhV@Ansuel-xps.>
Date: Fri, 22 Dec 2023 23:09:21 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Rob Herring <robh@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>,
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
 <42ddbe25-8acd-4959-ae84-269e943f7c84@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42ddbe25-8acd-4959-ae84-269e943f7c84@lunn.ch>

On Thu, Dec 21, 2023 at 10:34:41AM +0100, Andrew Lunn wrote:
> > I do worry this continues to evolve until we've re-created the pinctrl 
> > binding...
> 
> Hi Rob
> 
> What is you opinion of the pinctrl binding? Should we just copy parts
> of it?
>

Hi,

I have the new series ready but I'm not sure pincfg-node have useful
property.

What we should use from there? From what I can see only output-low would
be useful to us. I didn't find a way to handle the inactive mode.

Should I send the new series so we can continue the discussion there or
better to wait for Rob feedback?

-- 
	Ansuel

