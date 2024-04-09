Return-Path: <linux-kernel+bounces-137188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 313CB89DF23
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 17:31:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB02BB2D052
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 15:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2682413A3FB;
	Tue,  9 Apr 2024 15:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lD5pDhhS"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD91131BB1;
	Tue,  9 Apr 2024 15:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712675378; cv=none; b=uZfRZP6lXLxNV7ACJX5wfvqjzCMTPTsCDMu3zfHhMN4c9fBTrDaOK9tZI3Ipvc6Cm9Pa6X790DweGZAXSv1IGzS4akL1REQmB7F+RCBKfd+iJdKgKFvsMTfgqu9tn0LXBK8uEl06Qs5IME+g1/lNMfrNQKBNuKsW9WuOlUpV2Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712675378; c=relaxed/simple;
	bh=bUohk7QMBggJgRuT885dzbT7hJA0V+PO3DKCoFWY5s0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eTLN6yrxl+JCMTSHHlrLzWHKjlfDB3QKo+4IJZV1a6Qf6AOfSilzCdPPsW4et+5hvqV3V/DoKPLuRUuZlLktL8eI992GjvtLgfGWJphozHVD5PwT0R8eWuSG2oLzQETwzkFkzb6vt7M/jmNXLxBS9AwEQwYjPjURyk5TTiMrG4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lD5pDhhS; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-416923f05faso10512035e9.1;
        Tue, 09 Apr 2024 08:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712675375; x=1713280175; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hV8Eh9BHD0D9CZjicZrX01zekb30l/NMwat8BaMKtgA=;
        b=lD5pDhhS3zywG4KzFCiKSzaWY+lYiDeaGORRV9cnadZi09Ql7rUb0Gh50rifpwBEvV
         9Fb8AgU75zM9ctYJTAgm0+A91dC0I9PzOz8rL9xw+VDornu+KO0WLJAll2HilwX/435K
         T/WjLgFWCzGYB38TMabqAARsj1jymoCva0lcY43AvA5yyCbK/fJjFBhQjktH108Sszij
         cAx5UFNK5Ud8v4+H7wGd1KLtVYw6xCW9lrDHBZ4gyKzkysN/jwV+hSeSPSUELxTAawOg
         VX1i/Clim+exsa2/Z9yVP+KSAeon8Us7DkyDJjRPtiKo3xb132X8EottsAKSMRXa/e7v
         r8mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712675375; x=1713280175;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hV8Eh9BHD0D9CZjicZrX01zekb30l/NMwat8BaMKtgA=;
        b=Xn+2F1JzGEhU2OZQ++nGIiro3J3NpmdnEmFtWcfSP14IAvAjGGKigK0b7lmZKUyEZH
         QLH71r6ghrLYQrL3rmICqOSP4x5oTLGgkr9RWG4tiN0/F/R4tfFjIedR6P9y3pfmnTjF
         rSrPEXhUNAzYJ0z3nboSTswBU/IahdQ4nFH0ZoRuFYSnSXt8HkCv52uVvlt1hj2GQuHg
         TShvFXLKqFePrhiRT9Z02L/5E46ERho7iNm0zDVFtglmKwOsnKDI2OyorlA+BKWQB/9t
         4CDlCINmhGsgm5wfa5Fv9hVlekkyn9sejUxfqbEmRi7kxSoEX7wC3yn9CCZFU6TzAaue
         Jbqw==
X-Forwarded-Encrypted: i=1; AJvYcCVFU2qCjXaeo4TLVyGedjiQfzkX7hGG0emRJHVOwX+CLv2lEx3rAT0JfgykSv5mUG8giDCgi0AH2ZtdWehi7g8M6935EeiLkx77Rn21D9CcWam1lg6EV9Co4ZMStkyvUEsAPwLCID2SbBDLQILjnbFa99BEjbJRhbVGT48RyKuKTk0cXw==
X-Gm-Message-State: AOJu0YxUpQqQHkAG/ZdvWE0OL86tcdwYxLzM3G3qKffd9n1DUzYi3ROw
	XXN7eSCmKT1mLf88Wcl3Euv1MEGKO3OIjA4I3YMrz40mMOKFDIQt
X-Google-Smtp-Source: AGHT+IHAepUDHftdQEpWcio4JYkLD84VF76cy3I5PbYSo3n5J26JdZX15C/h0yZQHJwB34IjbU3HYw==
X-Received: by 2002:a05:600c:3542:b0:416:81b6:7590 with SMTP id i2-20020a05600c354200b0041681b67590mr3631710wmq.11.1712675374762;
        Tue, 09 Apr 2024 08:09:34 -0700 (PDT)
Received: from giga-mm-1.home ([2a02:1210:8690:9300:82ee:73ff:feb8:99e3])
        by smtp.gmail.com with ESMTPSA id ju8-20020a05600c56c800b00416253a0dbdsm20692015wmb.36.2024.04.09.08.09.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 08:09:34 -0700 (PDT)
Message-ID: <73fd3f42c2d63467bb1b04888659e829f9e54f52.camel@gmail.com>
Subject: Re: [PATCH 0/4] DONOTMERGE: ep93xx-clk from ep93xx device tree
 conversion
From: Alexander Sverdlin <alexander.sverdlin@gmail.com>
To: Nikita Shubin <nikita.shubin@maquefel.me>, Conor Dooley
 <conor@kernel.org>,  Arnd Bergmann <arnd@arndb.de>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>,  Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Tue, 09 Apr 2024 17:09:35 +0200
In-Reply-To: <42f9da044fdc11e2495f6845c061afefa796f7cf.camel@maquefel.me>
References: <20240408-ep93xx-clk-v1-0-1d0f4c324647@maquefel.me>
	 <20240408-friction-mosaic-ba48bc27788d@spud>
	 <42f9da044fdc11e2495f6845c061afefa796f7cf.camel@maquefel.me>
Autocrypt: addr=alexander.sverdlin@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Nikita,

On Tue, 2024-04-09 at 14:48 +0300, Nikita Shubin wrote:
> On Mon, 2024-04-08 at 18:03 +0100, Conor Dooley wrote:
> > On Mon, Apr 08, 2024 at 11:09:52AM +0300, Nikita Shubin via B4 Relay
> > wrote:
> > > The goal is to recieve ACKs.
> >=20
> > I dont see a maintainers entry in -rc1 for the drivers/soc/cirrus
> > portion. Who is gonna give you an Ack for that portion? If you
> > intended
> > maintaining that driver, should you not add a MAINTAINERS entry for
> > it?
>=20
> drivers/soc/cirrus got it's ACK from ep93xx MAINTAINER - Alexander
> Sverdlin.
>=20
> Arnd, Alexander - should we add it now ?

seems that we have couple of things to fix:

WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
#51:=20
new file mode 100644

WARNING: please write a help paragraph that fully describes the config symb=
ol
#60: FILE: drivers/soc/cirrus/Kconfig:5:
+config EP93XX_SOC
+	bool "Cirrus EP93xx chips SoC"
+	select SOC_BUS
+	select AUXILIARY_BUS
+	default y if !EP93XX_SOC_COMMON
+	help
+	  Support SoC for Cirrus EP93xx chips.
+

total: 0 errors, 2 warnings, 269 lines checked

--=20
Alexander Sverdlin.


