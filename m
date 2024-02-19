Return-Path: <linux-kernel+bounces-71462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B77285A5A4
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 15:17:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE11A1C21AF4
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 14:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FAC23613E;
	Mon, 19 Feb 2024 14:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MTv2Tzzd"
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8B6374EC
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 14:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708352215; cv=none; b=DUaHmmrylhxu6oFe9EIVuLADAf5afvcOctZOmkFrSrr0rCgDYmrhcWJdV8h6Unqux02LVV/DmbFqn0JqKMLFAa+sNl3E1kLBdVrhCnBosVq8D9E02yQA8UvH6Kdz4EuDR1aaWisWMczn2l217Ut/Yreps9W5jkDNAR5F9jjUtfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708352215; c=relaxed/simple;
	bh=8NtoIAADVPgZfZLTu67UGU+6DVV3ajBVgGPX09bdDig=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JFQ24xJP9vYkotrFxTu1jxnxrBT5SsgvDwyYXHkNzlfzX04mUbmdCVvJ4w2zjVKPsMZDFONQZiDezubbF5RTASr5k0qEjR51+1+RIASeetymlPO/nYpjDPwOCSquxAR0Kuo5o6pY8Jd/27ClV0Iu3GSJjVymHiGefmHC0hle2MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MTv2Tzzd; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-d9b9adaf291so2561714276.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 06:16:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708352212; x=1708957012; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8NtoIAADVPgZfZLTu67UGU+6DVV3ajBVgGPX09bdDig=;
        b=MTv2Tzzd2/VA7oqnWwbz7W2mSvD1P0Xm2hX6E33qmD4jsA4JVl9TLcvElzZDnxGpJ1
         KMbzO+SyjetWDcFovc2LMOG3bO4KqygaXRmpuyX4MCbNNEjSEGEbr67tsOiDctvnKBSs
         cka6Q8vAoh48DbRQFiOzYzyxX9PTQzGlQcuTSZw22/64TPzm6CVIAqfIDLnR63acoQVT
         NYjpVUw3nFq3mcgbwpH8Uwp6LQy1YJS2edqC3SApJuEtqu8kusqH8VbGyui1o0AIhBkt
         rw+WfqKQ0R7sHoqxyziSmMf4hhKmLVlui4cpqCgzk4JzMnvbKZ0aODGjI7ZHithOYPz9
         RP2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708352212; x=1708957012;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8NtoIAADVPgZfZLTu67UGU+6DVV3ajBVgGPX09bdDig=;
        b=qUIcD2O3/lOOXlaFn7TCkdvxfY+spktWdkAsF6qmxT85qAFbf80EJzSooZlEaVBZvm
         QkcfOlsetLTqtelupgnICX8ouOIVhcvFDDMmti2UI9Fbr0DMSh/6/1yF0FbL8dR4SeLm
         2sYvOsTa4F31qDXT0ju14E0iOa1Dp7Wnd4evU9ZeZLHvMrwdXHm8/b0HKBaVDCelecz+
         DDKINxxo7HBqPN0HU4SMwOx5FZhpu9g3hTBPy3Ui2bBgEKzR/bWnrJ07lSFYN3UNnySA
         n65mbcfwzHFInGtuNTAlNpsU9yBu+lUeJQVXI6UaMwA/GUjtNYEl28sVdCaQRa+M2RFi
         MTYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFOYrbZPCkifeb9qlqik4ByI0F5a+xTc2wxoJlSnQgEXI/nVfENHDKT+b9xnol/EaG00SpbKR1kBgnKvyZL0w4yZulgKXyyMaMq8hD
X-Gm-Message-State: AOJu0Yx+wPhG31UaFdC569abnwrcaYbvswjWZ4CYZ8HMz22KYwNXDEj/
	W1wkcW3B29wcg1x77Vm84ZLb/yQsnkUzmD0KndZQ5KgmMPgqT8szd7nd7U2H9QNXcN3EFpbXfv9
	hPrA54HnS8Q0R4VekWnCceFH9uD5UP2hFzMBmuw==
X-Google-Smtp-Source: AGHT+IH8zoIF6nwlmjqS5YKC62u1494qWLmxwhbcebn26N7GSaVYv8uV1vUneZZY53AiRhaVHNae5A7n3HAWkkeHKYM=
X-Received: by 2002:a25:d64a:0:b0:dc6:af04:2e05 with SMTP id
 n71-20020a25d64a000000b00dc6af042e05mr8299772ybg.7.1708352212135; Mon, 19 Feb
 2024 06:16:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240215-mbly-i2c-v1-0-19a336e91dca@bootlin.com> <20240215-mbly-i2c-v1-6-19a336e91dca@bootlin.com>
In-Reply-To: <20240215-mbly-i2c-v1-6-19a336e91dca@bootlin.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 19 Feb 2024 15:16:41 +0100
Message-ID: <CACRpkdaUJ6tM51o5tDSMURFS3u8J=dfMN+p4j04QNXdGUPzCXg@mail.gmail.com>
Subject: Re: [PATCH 06/13] i2c: nomadik: use bitops helpers
To: =?UTF-8?B?VGjDqW8gTGVicnVu?= <theo.lebrun@bootlin.com>
Cc: Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-arm-kernel@lists.infradead.org, 
	linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, 
	Gregory Clement <gregory.clement@bootlin.com>, 
	Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Tawfik Bayouk <tawfik.bayouk@mobileye.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 15, 2024 at 5:52=E2=80=AFPM Th=C3=A9o Lebrun <theo.lebrun@bootl=
in.com> wrote:

> Constant register bit fields are declared using hardcoded hex values;
> replace them by calls to BIT() and GENMASK(). Replace custom GEN_MASK()
> macro by the generic FIELD_PREP(). Replace manual bit manipulations by
> the generic FIELD_GET() macro.
>
> Signed-off-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>

I'm a fan of this style.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

