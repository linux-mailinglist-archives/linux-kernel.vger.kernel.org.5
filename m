Return-Path: <linux-kernel+bounces-161599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D2738B4E77
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 00:05:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A405F2812B8
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 22:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4709410976;
	Sun, 28 Apr 2024 22:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ferroamp-se.20230601.gappssmtp.com header.i=@ferroamp-se.20230601.gappssmtp.com header.b="x69P09HD"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318C0C122
	for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 22:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714341900; cv=none; b=WzHd02scXkQ1wEVmQoSlMg38ni+NDm3Jwd1mgvX82wWE6JXMkh5r1dwVGnauhau0Bfhr9njfePVb1QWlSGZhP/j0nlCHkjIrj/Vis4VDMu0w7Nron9xHyFsZ8mn9WeDgCi9SsKCaIv0MsFA4lWpQfEJx3DYNadENBMXekOIVgYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714341900; c=relaxed/simple;
	bh=4RqsDjz6bW3uKuO0Fsvr3+kThoLZuoIPu0ISXkKrTyE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JJBfjY6g1GQUohCD3fRyjP4TFux+3nirftTL57fdOVW35w2PMlcmIiyncHxM4LuCG59taxebjSPxnR+yBbiQxPj41EyerlSU5plclyLa8g3FJ5//mXi7gQCg8MMvwyEO3aBc+iR75OZ2AWwze9xPwQcZQ5VuFKVNgUxe4P75YVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ferroamp.se; spf=pass smtp.mailfrom=ferroamp.se; dkim=pass (2048-bit key) header.d=ferroamp-se.20230601.gappssmtp.com header.i=@ferroamp-se.20230601.gappssmtp.com header.b=x69P09HD; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ferroamp.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ferroamp.se
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-51ae2e37a87so4583636e87.2
        for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 15:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ferroamp-se.20230601.gappssmtp.com; s=20230601; t=1714341897; x=1714946697; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=H1dBr2tBHwkZy3R1A5ZSprdad8ekfhB+9jofNOvQ5fE=;
        b=x69P09HDqj18ZyhohC3t9ioNl3G/T7Z05fJnLDxHMnHKU/CrzSFEeLkrriCO1dri+e
         lS8P99CTC4dapjY/qpnsbe8u7iwnE1U0glIaPnej8sk/lS0YKqCgkHxkX7Yn7O3UkQnh
         5OnY/8uirQgSUF7RK5hr3NT5mmhmLDV7lz/fdATjRXIK5fnECMF8j5DyZLOeDcCQH1XF
         r758vnNfKGCzQz5frBzNlCziqFw4m1NjTUgVgWkk/AGlSAj66sLzLdqJcXNOlFmX1/VM
         dZjM6O1PnpBc3MtSKY8aGudcQKADRNm43jAFSFh5qP/8G3VyOs0WbTl02PNRZxDtso9x
         cdGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714341897; x=1714946697;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H1dBr2tBHwkZy3R1A5ZSprdad8ekfhB+9jofNOvQ5fE=;
        b=YM8eAN/GhFZkb7zLgy3zzxFG+0Hesby+uKUnOQsO8wwVO2+2p7I/7VlXJeE7RZV/a1
         auNVJNxK/0bNKCv0OIIz0m/CX46Jy9aGhyLmpE5019nbh4kzWY9k4CwTZm/sBdwaCzB0
         a04iKY4sxsf4XnE6594Ux4dLb0Tiv7BjgRw6TPFoWda3MKEv+mSbw/ZLkr1ypO7cvx0J
         2N8S6XVACg7zUkhpeVB/AVPDtNWOz98AIyAdRqcoFjwISG6JDtNpUKJlo8yjy+U8G17S
         OFLRZ2QwEsuHSxq6kPaT2jXJQTbO9swLI98P+5gVJB1MXzlACo2KYLzFxB+L/NXOJa9U
         C4QA==
X-Forwarded-Encrypted: i=1; AJvYcCU4LkIcPIhOyVrt43pNjuosi8JsFoUS1ZNfFyqfqObOSiOeQ6PcoNAtUYKXCGm4ltjuO+hI4dP4w3pF7N0sdP4hxh/NIc2q9lLjL9B3
X-Gm-Message-State: AOJu0YxilXVkN6fisWhZCXCZELIUurshK5sjAefjBdt9vhTBC0ubaI7Z
	CEm8bmocCMUa1e0qr3HX8o0nDwSNpXG9pBHNOcioCuplYk+Seg2StI14z7rxl3M=
X-Google-Smtp-Source: AGHT+IGsfdQ5hwxsPrYlKFP4rOafGl9ZX1COj2lhKabxTOxWM5ZO2gZkVWsJ4WnGwxMJE16O6x9P0Q==
X-Received: by 2002:a05:6512:3294:b0:51d:4473:48eb with SMTP id p20-20020a056512329400b0051d447348ebmr2172432lfe.38.1714341897439;
        Sun, 28 Apr 2024 15:04:57 -0700 (PDT)
Received: from builder (c188-149-135-220.bredband.tele2.se. [188.149.135.220])
        by smtp.gmail.com with ESMTPSA id o2-20020ac25e22000000b0051cc6cd306fsm901709lfg.168.2024.04.28.15.04.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Apr 2024 15:04:57 -0700 (PDT)
Date: Mon, 29 Apr 2024 00:04:55 +0200
From: =?iso-8859-1?Q?Ram=F3n?= Nordin Rodriguez <ramon.nordin.rodriguez@ferroamp.se>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, saeedm@nvidia.com,
	anthony.l.nguyen@intel.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, corbet@lwn.net,
	linux-doc@vger.kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org, horatiu.vultur@microchip.com,
	ruanjinjie@huawei.com, steen.hegelund@microchip.com,
	vladimir.oltean@nxp.com, UNGLinuxDriver@microchip.com,
	Thorsten.Kummermehr@microchip.com, Pier.Beruto@onsemi.com,
	Selvamani.Rajagopal@onsemi.com, Nicolas.Ferre@microchip.com,
	benjamin.bigler@bernformulastudent.ch
Subject: Re: [PATCH net-next v4 05/12] net: ethernet: oa_tc6: implement error
 interrupts unmasking
Message-ID: <Zi7IB_uKdFkJLtCS@builder>
References: <20240418125648.372526-1-Parthiban.Veerasooran@microchip.com>
 <20240418125648.372526-6-Parthiban.Veerasooran@microchip.com>
 <Zi1Xbz7ARLm3HkqW@builder>
 <77d7d190-0847-4dc9-8fc5-4e33308ce7c8@lunn.ch>
 <Zi4czGX8jlqSdNrr@builder>
 <874654d4-3c52-4b0e-944a-dc5822f54a5d@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874654d4-3c52-4b0e-944a-dc5822f54a5d@lunn.ch>

On Sun, Apr 28, 2024 at 04:59:40PM +0200, Andrew Lunn wrote:
> > n  |  name     |  min  |  avg  |  max  |  rx dropped  |  samples
> > 1  |  no mod   |  827K |  846K |  891K |      945     |     5
> > 2  |  no log   |  711K |  726K |  744K |      562     |     5
> > 3  |  less irq |  815K |  833K |  846K |      N/A     |     5
> > 4  |  no irq   |  914K |  924K |  931K |      N/A     |     5
> > 5  |  simple   |  857K |  868K |  879K |      615     |     5
> 
> That is odd.
> 
> Side question: What CONFIG_HZ= do you have? 100, 250, 1000?  Try
> 1000. I've seen problems where the driver wants to sleep for a short
> time, but the CONFIG_HZ value limits how short a time it can actually
> sleep. It ends up sleeping much longer than it wants.
> 

Good catch, had it set to 250. I'll rebuild with CONFIG_HZ=1000 and
rerun the tests.

