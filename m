Return-Path: <linux-kernel+bounces-37738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE29183B4A7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 23:27:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49772B2188D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 22:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB655135A66;
	Wed, 24 Jan 2024 22:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kzv5aaGZ"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD90134750;
	Wed, 24 Jan 2024 22:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706135247; cv=none; b=U4zw7DvvEqF9OV3LxvgQdCu0X5aAUBzbM+yfAKrMCbVEgy2YmJwCXgyYzH+QLYWR8GixeFC4Us8qAn4hlbDGhUlx2FQ56Y9fcT2DNJNMgGORF7gohKcw/NDXPs/5fLfeWiT/ykkAp7UAMqEFB/e2AA6iDuxdnAtOpBqCWB/9V0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706135247; c=relaxed/simple;
	bh=o3gr9vmWJomYS3b+A7pJvyEVvUjx4yijbu5oA1OyYhs=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kujNKzK5gHP1HlL23bj1dB0FaK2qXVyG42+nyTKc51p2OlLeRijiBKzsgPLnF1ht/7adhIUZ8BdCIt64B9YEJxeCsupXOxs/QnYwtTPk68NZP5jATzxAO+hXzlzRD2PGVdml+ZoaiOIMof9YNzdM0Gt/uPtTFDB0AC9BWLxxiUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kzv5aaGZ; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40ec048e0c1so19345765e9.2;
        Wed, 24 Jan 2024 14:27:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706135244; x=1706740044; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fjxjDY56LiTFFCRJEw1kPUjEBGjDsgw409gTnMdwrYU=;
        b=kzv5aaGZDyxp+1cRtp6+SO/NT0W9sXRYWAH1YmJLqeSr4Ob5jW0D7yNg5YFckj7fGl
         n5FaWYJMz101TndftSwwo4FftR7FxiNk/zahUSBI1n3EZ4LZr0Tpuk5jZEX9mBifrdbf
         eetRFy875HUyUvA1OGJV8mrKQNNGJAfrFuqhim9tVR40eJLom6UjShvhqsTeg4KJc3Kh
         tbfCX9Ir2fWfpbyZ5rMDbw5vL3eKY0jZEUVa1H3wwVtEQwHaTNoFtk3vx6oroJcdqQUU
         CPRRSFDZB68JukXfi6VhM9PqSzdMitjJkYqR/TVm1dJXvkchZF8proQi00f7RtTGmIIz
         CWZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706135244; x=1706740044;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fjxjDY56LiTFFCRJEw1kPUjEBGjDsgw409gTnMdwrYU=;
        b=JGO0s8ngLsu+1O6yo3Uv1Ty9WGtLYc3QSSSZRKcpfqiY1ndIOA8K+JQlEvnyvJqmaB
         /eMVRKxsHpENflJ/V21viF6dEGwJHjXvqdg12+ivnu9YMEPqaMpm5jUV58cIvAdvpnTg
         6l3HtqGnyfhfyGSrnX6MXNnzkeLnCv6b60UcLK+Yi2X8RKfnwa2q85DIY8VmWy6BJHPW
         R2k93bMJVVT94eKdddkmNjKxdCY1sRjN8H2PCQDRxHE9ON1rh8168UhaVtZjax5rbIs8
         AqDVH5VIXoeF+CM5q7KvqaeO4kZOasyXY3FYz9jCUZJDb0LSKeYxu/Sz6bbdrrEuIiB1
         6doQ==
X-Gm-Message-State: AOJu0YxQggikIgI/4rW/tbSUz0vDE0GfA4uCEayzHOzn9dZwuCUk1zLh
	k6pNeeTHAKfU8Bk6nDr+EUAvKZvRfVIZLN8L12KXYrVo3xxwGjrq
X-Google-Smtp-Source: AGHT+IHo0xHU71Kl4mbLJfFOzOZmwFw4o0ZJNf0UzzxYJamL98tIZRGcfx8ulWIDmNIJ0ZmBHcfqMQ==
X-Received: by 2002:a05:600c:a4c:b0:40e:ae0b:62ee with SMTP id c12-20020a05600c0a4c00b0040eae0b62eemr2057460wmq.56.1706135243495;
        Wed, 24 Jan 2024 14:27:23 -0800 (PST)
Received: from Ansuel-xps. (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.gmail.com with ESMTPSA id v4-20020a5d6784000000b0033940bc04fesm5367320wru.16.2024.01.24.14.27.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 14:27:23 -0800 (PST)
Message-ID: <65b18ecb.5d0a0220.e8e31.c94c@mx.google.com>
X-Google-Original-Message-ID: <ZbGOyCRxCxFCiuk2@Ansuel-xps.>
Date: Wed, 24 Jan 2024 23:27:20 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Robert Marko <robert.marko@sartura.hr>,
	linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH 1/3] dt-bindings: net: ipq4019-mdio: document
 now supported clock-frequency
References: <20240124213640.7582-1-ansuelsmth@gmail.com>
 <20240124213640.7582-2-ansuelsmth@gmail.com>
 <010becc5-51f6-44c1-863e-f5092ca5018c@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <010becc5-51f6-44c1-863e-f5092ca5018c@lunn.ch>

On Wed, Jan 24, 2024 at 11:23:05PM +0100, Andrew Lunn wrote:
> > +  clock-frequency:
> > +    description:
> > +      The MDIO bus clock that must be output by the MDIO bus hardware, if
> > +      absent, the default hardware values are used.
> > +
> > +      MDC rate is feed by an external clock (fixed 100MHz) and is divider
> > +      internally. The default divider is /256 resulting in the default rate
> > +      applied of 390KHz.
> > +    enum: [ 390625, 781250, 1562500, 3125000, 6250000, 12500000 ]
> 
> Hi Christian
> 
> 802.3 says the clock should be up to 2.5MHz by default. So the nearest
> would be 1562500. Please document that if not set, it defaults to
> this. And make the driver actually default to that.
>

As I said, this is very fk up and default value is 390KHz unless anyone
in the chain sets it (sometime uboot does it but it's not that common...
default qsdk uboot doesn't do that for example)... Ok I have to change
this to default to 1562500.

-- 
	Ansuel

