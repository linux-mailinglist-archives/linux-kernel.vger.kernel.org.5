Return-Path: <linux-kernel+bounces-1429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2217F814EF1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 18:37:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45A8C1C23D3B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 17:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A57582EEB;
	Fri, 15 Dec 2023 17:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DvHYZMzD"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3401430101;
	Fri, 15 Dec 2023 17:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40c6ea99429so3445655e9.3;
        Fri, 15 Dec 2023 09:37:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702661831; x=1703266631; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rmrj+rZPQDEb03B1/Gdj9DCEQdcm144w/bczgbq9U/U=;
        b=DvHYZMzD3eKNtLMA/3PMq9+CXwQ4LEiiqYlaJdfj1ErgGHUEuFX1sQCL69+OM6lfKq
         6uvLhptHp3evAhrBRm5xzCgSKcqBO1paQ8kSMUX7m7WO+4VHMJCJWWFjnOoTm0s6N/Zr
         Rcqx5Z4m1jCS7DbiJd+5enttpGPTZtkYpHFbSY/olVhy9s0ZyTu7h2ENu6x68VzbJwPd
         LAPQN7G5JOu7tNh759osR7RXf09SdpUANoA8ampJxSj7UqfyyOsHxVP+97IpHe053Z4J
         ecbF0m8j8pNXg6e3JXzhk6lxOHi0qObNmlj8Vix4yLZZXvBjzWlfpyUZ2UzPtiy0RxVI
         INHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702661831; x=1703266631;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rmrj+rZPQDEb03B1/Gdj9DCEQdcm144w/bczgbq9U/U=;
        b=r2FK1UNvoZylh5A6ElDscY1YgxUyQgq3mLzN5wdcgonD+alYmlKSdhSULQPnWCJ8TG
         0QAKW7F9U5pH97j013KAxM0JivwIiIKB5qRAWIIdJrW5fvJExwTbC/UVMxj0OJUSsgIv
         uu7dEfdEgVkSPnBfUKpkUmgk0tbyYTGLrniyO1byC0UH3yqRXK+G7saPUXVi9dBVTgZU
         S9LacAd8fdD9z17W+UGtZXwBPjYM86O7oHdYCt7pSO2mfksEXkXp1w8VWT/i6WbedDM6
         BYk2dA7rwSqrpxsCFLPEJ2Jr0aVxyZR40C/DzXWvvpMVXb9ahNzVQEUGaxLNu+VG+mQ7
         Jm4g==
X-Gm-Message-State: AOJu0YzVUQMjpeRoI4JdRWFRELXaT1u+MjtS7eV4oC/eCwvCQi74aUND
	DqF3zQ/Vu4kYOR/r24oGlyk=
X-Google-Smtp-Source: AGHT+IHLSxSjX8Sc+Ia0bfAk77WGTCfUuon0C1mIPimKZ6zTF3NQ18hgGG7u66cBNOBTFjsKFmntZw==
X-Received: by 2002:a05:600c:4694:b0:40c:6a86:659f with SMTP id p20-20020a05600c469400b0040c6a86659fmr523775wmo.224.1702661831139;
        Fri, 15 Dec 2023 09:37:11 -0800 (PST)
Received: from Ansuel-xps. (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.gmail.com with ESMTPSA id e33-20020a5d5961000000b0033346fe9b9bsm19381084wri.83.2023.12.15.09.37.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 09:37:10 -0800 (PST)
Message-ID: <657c8ec6.5d0a0220.4648c.58d2@mx.google.com>
X-Google-Original-Message-ID: <ZXxhkFUAwAKnZDJp@Ansuel-xps.>
Date: Fri, 15 Dec 2023 15:24:16 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	tobias Waldekranz <tobias@waldekranz.com>
Subject: Re: [net-next PATCH v3 1/4] dt-bindings: net: phy: Document new LEDs
 active-low property
References: <20231213111322.6152-1-ansuelsmth@gmail.com>
 <d63e8b6a-c0fc-4d99-b399-86f66f369176@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d63e8b6a-c0fc-4d99-b399-86f66f369176@linaro.org>

On Fri, Dec 15, 2023 at 04:48:35PM +0100, Krzysztof Kozlowski wrote:
> On 13/12/2023 12:13, Christian Marangi wrote:
> > Document new LEDs active-low property to define if the LED require to be
> > set low to be turned on.
> > 
> > active-low can be defined in the leds node for PHY that apply the LED
> > polarity globally for each attached LED or in the specific led node for
> > PHY that supports setting the LED polarity per LED.
> > 
> > Declaring both way is not supported and will result in the schema
> > getting rejected.
> > 
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > ---
> > Changes v3:
> > - Out of RFC
> > Changes v2:
> > - Add this patch
> > 
> >  .../devicetree/bindings/net/ethernet-phy.yaml | 20 +++++++++++++++++++
> >  1 file changed, 20 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/net/ethernet-phy.yaml b/Documentation/devicetree/bindings/net/ethernet-phy.yaml
> > index 8fb2a6ee7e5b..9cb3981fed2a 100644
> > --- a/Documentation/devicetree/bindings/net/ethernet-phy.yaml
> > +++ b/Documentation/devicetree/bindings/net/ethernet-phy.yaml
> > @@ -213,6 +213,11 @@ properties:
> >        '#size-cells':
> >          const: 0
> >  
> > +      'active-low':
> 
> Drop quotes, no need for them.
> 
> As pointed out in other patchset, bool might not be enough.
> https://lore.kernel.org/all/74cb1d1c-64b8-4fb0-9e6d-c2fad8417232@lunn.ch/
> Anyway, both cases probably needs to be considered here.
>

Hi, thanks for pointing me to that series. Leaved some message there,
would love if you can check some ideas on how to handle the LED
polarity thing DT wise.

-- 
	Ansuel

