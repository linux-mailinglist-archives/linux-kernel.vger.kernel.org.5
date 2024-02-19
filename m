Return-Path: <linux-kernel+bounces-70792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18E22859C73
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 07:57:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48FBF1C2165D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 06:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C47E12033B;
	Mon, 19 Feb 2024 06:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i2K+myPa"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8242C200D2;
	Mon, 19 Feb 2024 06:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708325853; cv=none; b=qsJ+if07MeJp43uAnj6ZSZy3EORf+Ci1Ltts1PDnXsuGsDfXrG2of4ksVZByirljAno7Hp4u/A1jezx4Oj/r5+StG9cA+o8cEnxsIBmmfMEx/AqxybYJvP6uA53h51E0o0a+XO01TH/I2jpXfD0vJXwidMAJjGUdivCuWv5Xiko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708325853; c=relaxed/simple;
	bh=iFYxmub+rVWGXZmh6QJyK1qV+jAft9bD1NIwuJ0i2+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qQ0Qx9+j4h7h3/4G2QNhof3EZ3YoqZ+uD8xPxwnpIZacsmQxi7KUSeGFFV33K5jK9laCFImqbFniP5N6nvJbs9icpUGo2r0v1r3p5Ker9ln+Ffx8H2HfrP/EJ9rSKnHHvPNUoO8vp89/o/9JKZLDCWQmIb1HmGdtbcdDsZWY/YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i2K+myPa; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-33d509ab80eso152615f8f.3;
        Sun, 18 Feb 2024 22:57:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708325850; x=1708930650; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Rdfq3ZIhfI4G+FZTUQuj2JrPSLPOEMVHqCwSzXS6Rww=;
        b=i2K+myPa3am+XwQCKa+24ypzJ47GcL3YQejBLFMdjFqaYq9md+AMgu7J2K18FwJRaa
         b9rJcb0+S/l7xg92v518//g4bAK8b9MJZnCNHtUIy9n0IvZIUUlmN6TQwZ37ADQ9Pjj2
         HhkoPUw6HQpMHJgLSGwCQPhBnYm6urCQXoBxUxJ+RY20h1od31V1nrznYvHFdR9Dbmbh
         n9exPCF3S42bI0sja0S5Gzj/k81jzKBxfSe22LGjvVpqJMznqkg9rb6jT2zQkOMK8JLT
         W1ySgtKldE/uW5w00fhUgwPbEp7HxU0Nwl0ULUMFDTUpYieMUm1oHZXco3QyewYx8qec
         3qRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708325850; x=1708930650;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rdfq3ZIhfI4G+FZTUQuj2JrPSLPOEMVHqCwSzXS6Rww=;
        b=QG8KCTKohDDxIAX5r15nyiL7OwJPm4MMFM2JKk1AWiT3PlJ9PYrEmdqmZiGn+ekNoQ
         BpzYV6rhy9hc6KKtPU1hWSNOiuTMkF13/jkCtKFXXxNQwffe+fUBt+sMi9u0l+IMflD7
         1fflC+HWwUAsI4uJjpDbUAPmABkyw7r0utc+h0u3wiunjAbQRksaTrxAlwliLjGZAayh
         xTEy81Llyh7snhuie+HkKpJTM00CM+wJHEOehOf7uf8wDGNAf0gDW5KiF8yhLAJ6NCGP
         DD0maECqEE7sMJedhobL+rst4XzHXQymKJbDgK0TMJrR9ju4jklcjuxIjaqeZdk2SqPH
         eySQ==
X-Forwarded-Encrypted: i=1; AJvYcCXOf2ZjJUUZPo/KWD6XgEKt2AS9MLOb1Pj1BEUZVytp1b/tvKgVI2qRlj2g3Scqj7AUPGMh3rVChBfaqkZo2BGzmnbtnRBuDMhDxD3cOlPWYm6+bPXm8BAtXyan/csQf3R+J9d6mzDdY4KH+ZYK3tQBSYWSaW7HWD53RePgM7c1gI/RoSgkHg==
X-Gm-Message-State: AOJu0YwRuyf+4FxKXK4wprQotLM62u9e+YCYpuUTLFWxkM3IiI9inLQ3
	/r6M/77hRit0qMuWW9lXvk9U28dcZu1aMzGRdiQClzH/WL0496ja
X-Google-Smtp-Source: AGHT+IF8JFcDTdrR6y73cIEurgS8m7OxloBy+Evb9Ck/KwLltIcZEonwX1GXrqEsB7VlxG9x+XagxQ==
X-Received: by 2002:a5d:5487:0:b0:33d:3ee3:cc11 with SMTP id h7-20020a5d5487000000b0033d3ee3cc11mr2153461wrv.47.1708325849679;
        Sun, 18 Feb 2024 22:57:29 -0800 (PST)
Received: from Red ([2a01:cb1d:3d5:a100:4a02:2aff:fe07:1efc])
        by smtp.googlemail.com with ESMTPSA id bp1-20020a5d5a81000000b0033d38cbe385sm5147560wrb.6.2024.02.18.22.57.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Feb 2024 22:57:29 -0800 (PST)
Date: Mon, 19 Feb 2024 07:57:27 +0100
From: Corentin Labbe <clabbe.montjoie@gmail.com>
To: Alexey Romanov <avromanov@salutedevices.com>
Cc: "neil.armstrong@linaro.org" <neil.armstrong@linaro.org>,
	"clabbe@baylibre.com" <clabbe@baylibre.com>,
	"herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"khilman@baylibre.com" <khilman@baylibre.com>,
	"jbrunet@baylibre.com" <jbrunet@baylibre.com>,
	"martin.blumenstingl@googlemail.com" <martin.blumenstingl@googlemail.com>,
	"vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>,
	"linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
	"linux-amlogic@lists.infradead.org" <linux-amlogic@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	kernel <kernel@sberdevices.ru>
Subject: Re: [PATCH v4 00/20] Support more Amlogic SoC families in crypto
 driver
Message-ID: <ZdL713ae1swwTU_B@Red>
References: <20240212135108.549755-1-avromanov@salutedevices.com>
 <ZcsYaPIUrBSg8iXu@Red>
 <20240215104719.njq6ie2niisntcnv@cab-wsm-0029881.sigma.sbrf.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240215104719.njq6ie2niisntcnv@cab-wsm-0029881.sigma.sbrf.ru>

Le Thu, Feb 15, 2024 at 10:47:24AM +0000, Alexey Romanov a écrit :
> On Tue, Feb 13, 2024 at 08:21:12AM +0100, Corentin Labbe wrote:
> > Le Mon, Feb 12, 2024 at 04:50:48PM +0300, Alexey Romanov a 'ecrit :
> > > Hello!
> > > 
> > > This patchset expand the funcionality of the Amlogic
> > > crypto driver by adding support for more SoC families:
> > > AXG, G12A, G12B, SM1, A1, S4.
> > > 
> > > Also specify and enable crypto node in device tree
> > > for reference Amlogic devices.
> > > 
> > > Tested on AXG, G12A/B, SM1, A1 and S4 devices via
> > > custom tests [1] and tcrypt module.
> > > 
> > > ---
> > > 
> > 
> > added patchs up to  "drivers: crypto: meson: process more than MAXDESCS descriptors"
> 
> Including this patch or not?

The crash start with "drivers: crypto: meson: move algs definition and cipher API to cipher.c"

