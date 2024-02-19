Return-Path: <linux-kernel+bounces-71470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55E4685A5C4
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 15:21:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB1E8B2142E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 14:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E678E374F5;
	Mon, 19 Feb 2024 14:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tTKE/O3m"
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA5B36B17
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 14:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708352501; cv=none; b=CzgaO9YKDMTct23nU3gKNLjvsRYvglAc+eyM8XjDXAmlsletYRpmoFjsGV11N01ofheGe7pcB8yxmdcDiDukUq07oi+tPUEqZF1EuaZIVsEma41bh2gqz4xjJZ5HZsM/wYVtmzCMfaDAawOVgvUbcc5Y4yR5kN46bmsAEZ5yJwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708352501; c=relaxed/simple;
	bh=SrwC0+4KeISVGwaFeZbt6eoTCX4pOFuHjyV4acTEdn8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pA63zjDLBKOokYdMGlI/j4avaBl32khdiFOuHFJennf7t1+DxUprxLf7z408LruJHUP8tcgmiRpvEZ/PFvFGIzeSxVepxgigavrkx6biVtDqF+bFdp6lEiPziShoiRQHoauaccULPy2SJWu4LbEEjfLDn8SAlzTZAb9U828DKfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tTKE/O3m; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-dbed179f0faso3751227276.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 06:21:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708352499; x=1708957299; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SrwC0+4KeISVGwaFeZbt6eoTCX4pOFuHjyV4acTEdn8=;
        b=tTKE/O3m1ig1JfmukMOVlcj0apK05F9sHBrjZZLTBULHI9BN2gazcHtXkSDnb6xCYd
         WfZ656EQgv0JCpsSGckqoKmDaJMUHfoavozMkgxR4JVU9gPGtr7UjW9XczgmCBuSUaUi
         4A6zZ2WZ1xfI2Oug/shfdKmJAsXs+50ma4/m40nX90nbPq6GAE/BU/MehJF0xVTk+ogu
         BTPc/U5ip9whYC8BxpIVO7gqmQxmdkQyouo0+54+UwpXzmRYn6iGSqQHZ86J3w042Hws
         HxStEv/HeJe64OHL720Tk8A/P53E5xxkjXHvHAe+KM3+6HE7OVhxMMbFZi09wFGPYJfC
         2RLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708352499; x=1708957299;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SrwC0+4KeISVGwaFeZbt6eoTCX4pOFuHjyV4acTEdn8=;
        b=Gr4DtPV4TeTyLR3V4756J370UwlqLm3z7mREPQ9VVaB8p7Zevu04w3LOHRl7tOryaW
         GLQfY5jCqppvauxSqvj1I6Hl9iL6TLVByYZudHEyBLjjatTRxg/NUu+aYMa5hEVp7Nh0
         Vs1FFoXVds2rSZTwBwMiUDlyprfUncsI7y1qYUo+gUz26mqWuxSygHdSObITLENXaL9Z
         SytqAJXr4B4WpTVv/sV8YehaOCLqDL1StTjBaMuINoyByqPayCx2lkFP5YjFN4B5+vHn
         1OPq+eSPbfG00OZsBc2h/bmYLF7p5g3JN6Un6kaobVXheue9BXj8NfZNyER1G7UKdJdb
         /OUg==
X-Forwarded-Encrypted: i=1; AJvYcCV9xXxitm3KebeZwFm0+tAH9x+MSQZIPonfkxWYA9ZD58PHNsmo/cSgQqfCSmCnSbuyC6DKbhSJ7hPTy157dk6+FrHvn2OwUUNV+3Fi
X-Gm-Message-State: AOJu0Ywt7moosi4clsebGaNGbF2FDpAHxLLljOfCGRIonAuFxK9r6SzU
	PyVkq98Dyf/FKI8hEwfLSyizPwgAQr1+GAUDDSUftHWOa3SMMP8C6ifMOXWpNbBrONkYS0QGwPt
	mdLo6h3PfE+t3l+M2pfnmRw5q4LUdCU46hVIkBUTGyIP0XkZ1OCo=
X-Google-Smtp-Source: AGHT+IHNfSIGwbZ8da8WA4wu3utNXpd89Nvp2VMBYUutX9dQbg95IHwCqHaWvUBTbOVrAfhe6rvgUYD4B+AnWJejaYE=
X-Received: by 2002:a25:838c:0:b0:dcc:fe98:368 with SMTP id
 t12-20020a25838c000000b00dccfe980368mr6937583ybk.19.1708352498795; Mon, 19
 Feb 2024 06:21:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240215-mbly-i2c-v1-0-19a336e91dca@bootlin.com> <20240215-mbly-i2c-v1-8-19a336e91dca@bootlin.com>
In-Reply-To: <20240215-mbly-i2c-v1-8-19a336e91dca@bootlin.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 19 Feb 2024 15:21:27 +0100
Message-ID: <CACRpkdbuTX50syD0CMFcZXBmAHw4nwpcSc-C1OOUQEA9WHqCwA@mail.gmail.com>
Subject: Re: [PATCH 08/13] i2c: nomadik: replace jiffies by ktime for FIFO
 flushing timeout
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

> The FIFO flush function uses a jiffies amount to detect timeouts as the
> flushing is async. Replace with ktime to get more accurate precision
> and support short timeouts.
>
> Signed-off-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>

Excellent patch. Thanks.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

