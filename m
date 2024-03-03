Return-Path: <linux-kernel+bounces-89903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E61A86F718
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 21:56:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0C021C20978
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 20:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E4937A158;
	Sun,  3 Mar 2024 20:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AY5rdt7v"
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D00A957;
	Sun,  3 Mar 2024 20:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709499388; cv=none; b=JF96BBFj6NN7g9NwXMlCesQZnpIxWB94i03xFRnGTToXVJH6LCEMdg1QeJF780fmYWerusq+j/XpKJmTAQaD1yZKvgz4JFV93m81ZlvFsQrMo22QRah8h/kwYPKQVQYrHybUQWfw2iDUScPRk+tPupf+seZviqs1dUrJxEhh7+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709499388; c=relaxed/simple;
	bh=UbvcmCf/ZNBzClT52hYrifGzgp651ApHQ59cRO1SWR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=maVFNZc3Omz4XQau+IJguzAHO7XG29PI3ZmjHFuaTN7BlGOkOgfs9soCG6ccxX5ErMJxF+gJUOpBmXrO+mtfSCAoU/fnYZIlWp+Bg53yUKd17vySmSeZUHP7VnAOVJ6qTLz7ocQtRaxwtj5M/4nBL7ld+rxzizBhFUvmkdMU2dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AY5rdt7v; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-60982a6d8a7so30518227b3.0;
        Sun, 03 Mar 2024 12:56:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709499386; x=1710104186; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lUlwWyeD8wtN0Yiye52/NFRnTVNfRkd0UskjSRBJusA=;
        b=AY5rdt7vYYzEhYVBIS+9SqedVj/VFKSA0sgTjp//yC/BE6uX3+mCweJcG7aUI52wDx
         BpIgLsTrlQR2eyegGbNmIc77WI0SL2mPCyksMM440d9OSfSY7L/+a8aw9/rNQdGglHmc
         Wx3EoA/72g7LWY4gs+Xq0y3PqsulDB1LQQJpcmWIJhz1jJpJsjckUNi2/W49gJZf4LQ5
         fDonOegLQyziuG28geZ+3k2HC72UaKAZBwNnxjQf09RoKVqNnGHvOEOiyM4ZsPdb7aPn
         WXTYHQR76gr4B5P7od9NI13yDBMDa379qxLeyI8JUC8KW63k5i7w1LIw9n+VWH5YTQOH
         dRvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709499386; x=1710104186;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lUlwWyeD8wtN0Yiye52/NFRnTVNfRkd0UskjSRBJusA=;
        b=rsMhq5zdMlrRTLKdkqvDAkzqD5HEoXXhVHaYBVFkr2KNpnV5pyIA3lsl2NwKpF32CE
         JX+Ft7FpE6Bv0ymoyrHUiRtcTB87wgqiuFO15a1TCCvW/QOmFKBrcETztC/KMFsiuy8d
         13MsaWJtvDtb5exHBIZFqeVtx2phWJNYUSgCADMbeLLCqGgysTycAw7GgE2QkPa9gIYr
         D197ZbO1ugyKw6PoeXRzPcMG08slQ32g6c2s7GTNRMRyhJIi7HKWrK5JWlhePS3ucxLK
         okEY6CTxB/7VM/iI21DdomBuY0TU1szb/RyeuxmHmWcNwgee3LJzD1j0jhvvpB3nchnx
         Q5IQ==
X-Forwarded-Encrypted: i=1; AJvYcCVkDltVaYIR7YDUpyC84yO//6vLUr7l6Vtk902/v2PZcjF7BJpiDXzDRmUeWg6yWBAkV0E/xNtY7m4s+U7bpmJs4TW3SfCDWaXGGHQ9tRpYI5E7wvD44Bl5iUctJCWUehaGUGS0jHunULPIOHFLOe5vrLJfsMLYnzKGPqHLONXX8Pbl7g4=
X-Gm-Message-State: AOJu0YzhB49cCmuNZVsr8ieN2XULyPRULpMkg5/LsKi2Xlt/Mi2bfQCr
	IjY29/bt3yefMpkvnQVDYfw1UKuNKyMHwkSxuN39c5IlHKOGPxJe
X-Google-Smtp-Source: AGHT+IEMH2ZpOlzBOX/XP9oGNCEo7HCMfPSqirGENtbdV4d7lFuZmWbLldFKBVbQ602N2DaOmU0uVQ==
X-Received: by 2002:a0d:cb10:0:b0:608:922:4001 with SMTP id n16-20020a0dcb10000000b0060809224001mr6370866ywd.5.1709499385764;
        Sun, 03 Mar 2024 12:56:25 -0800 (PST)
Received: from localhost ([2607:fb91:20ca:fa23:a05e:7311:56f7:3a04])
        by smtp.gmail.com with ESMTPSA id h5-20020a81b645000000b006094292e834sm2245184ywk.75.2024.03.03.12.56.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Mar 2024 12:56:25 -0800 (PST)
Date: Sun, 3 Mar 2024 12:56:21 -0800
From: Yury Norov <yury.norov@gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Chris Packham <Chris.Packham@alliedtelesis.co.nz>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Andy Shevchenko <andy@kernel.org>,
	"geert@linux-m68k.org" <geert@linux-m68k.org>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"andrew@lunn.ch" <andrew@lunn.ch>,
	"gregory.clement@bootlin.com" <gregory.clement@bootlin.com>,
	"sebastian.hesselbarth@gmail.com" <sebastian.hesselbarth@gmail.com>,
	"pavel@ucw.cz" <pavel@ucw.cz>, "lee@kernel.org" <lee@kernel.org>,
	"linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3 1/4] auxdisplay: Add 7-segment LED display driver
Message-ID: <ZeTj9cRkafeps0dT@yury-ThinkPad>
References: <20240301014203.2033844-1-chris.packham@alliedtelesis.co.nz>
 <20240301014203.2033844-2-chris.packham@alliedtelesis.co.nz>
 <ZeIb_TaKK1DE6l6U@smile.fi.intel.com>
 <f17adc70-be85-4be2-bbe2-336866907d68@alliedtelesis.co.nz>
 <CAHp75VfCt-3wOKykUNE8MnV9nHKvkbDY9vs25j559+cX-OudzQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75VfCt-3wOKykUNE8MnV9nHKvkbDY9vs25j559+cX-OudzQ@mail.gmail.com>

On Sun, Mar 03, 2024 at 10:35:03PM +0200, Andy Shevchenko wrote:
> +Cc: Rasmus, Yury
> 
> On Sun, Mar 3, 2024 at 9:58 PM Chris Packham
> <Chris.Packham@alliedtelesis.co.nz> wrote:
> > On 2/03/24 07:18, Andy Shevchenko wrote:
> 
> ...
> 
> > >> +    DECLARE_BITMAP(values, 8);
> > >> +    bitmap_zero(values, 8);
> > > Why do you need this zeroing?
> > >
> > >> +    bitmap_set_value8(values, map_to_seg7(&map->map.seg7, linedisp->buf[0]), 0);
> 
> > Without the zeroing above GCC complains about use  of a potentially
> > uninitialized variable here. I think because bitmap_set_value8() does &=
> > and |=.
> 
> Hmm... Rasmus, Yury, do we have any ideas how to get rid of this redundancy?

DECLARE_BITMAP(values, 8) = { 0 };

