Return-Path: <linux-kernel+bounces-7975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12D9D81AFFD
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 09:06:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C94A1C233CA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 08:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7580615AE9;
	Thu, 21 Dec 2023 08:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X782y/94"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72DB5156E4
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 08:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-5e266e8d39eso5664267b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 00:06:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703145984; x=1703750784; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S7MnvmBC0PDW2dA6Fz6TSLG0xbK9jfAoZs6lV1vRHHI=;
        b=X782y/94O5Ag4gKWtxjeZtZUd+ap2n+JMOcLMYaizCHxCiaWmv30dEnfPNRqcZ5jy2
         obAHDRmHxlr7MvKZMCABTq6UefYuqIkGyIPDQwa/yld7ai+3mCyasG2nkDpITm8OZIRm
         Ta/MnccWbbgbhvrw0gNnFKbtAU7+6n+WB36aSmASGjiBMPJinMIRALIn6FYb7I01fCg+
         SzdzQjPGALzz0PcEeZQwkyM1yZMq6+xF3Z0+W2DUV9SEj12e5JYuO0qtx9D3YsPS4fji
         FjXfCBqDJlztlstirKji+3xTjMEFW8VebFZvwXniso9LC6wT5fyleFBoQ/OtddBsQJmV
         0KLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703145984; x=1703750784;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S7MnvmBC0PDW2dA6Fz6TSLG0xbK9jfAoZs6lV1vRHHI=;
        b=QJMds+w/nc+4IQz+G3ygZxkUUPb+mH5iNsmXy4JwdCYRQmsZ+ESTumeU836c2DPIb7
         HQuO8rOlBUETjSZd39J/QLfu+2fxinYzYsLAvK4k9IUxyA25XPyZpZ5C0Ee+7Z2Vy3y6
         CLz4+kWK0CRmh7mfgA50zyzEy00dXSbk0VvvmScabx50hcQMuRH/NkC9hZad/d9eBoOW
         hbykLqJdMqXVHE0XqfS0sgx4CBNEjRvcfg8FOKcrOsU8rnagS1DpKM+afNxsmK4ZJV/7
         VpUpx6mJXR0zqMbFpl92V2RmKK8RWxGmW22nasxQlSrru0fsAPpuEEBRMZbCMczskleH
         A3jA==
X-Gm-Message-State: AOJu0Yyk44qzSt6IXzQfbA32D/c3NZj3diGYQMjP9urDz198leeBdfqi
	ja28VLZ+ToK7Zm7bk33FPtJKtUcWAa13EGiOYPgGfg==
X-Google-Smtp-Source: AGHT+IElBBLbm29CF99k2e2smo3K3wGeeZiMFnIyoHCG750znXGo9kQEMBUl5LRIIwJWKVMnqLqGeqvBF6SsfUp6Jjs=
X-Received: by 2002:a25:e0c3:0:b0:dbd:2b6:6cfd with SMTP id
 x186-20020a25e0c3000000b00dbd02b66cfdmr763204ybg.2.1703145984546; Thu, 21 Dec
 2023 00:06:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231215-lockdep_warning-v1-1-8137b2510ed5@bootlin.com>
In-Reply-To: <20231215-lockdep_warning-v1-1-8137b2510ed5@bootlin.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 21 Dec 2023 09:06:13 +0100
Message-ID: <CACRpkdZnPPHgRf+taFPOM4P0U+4w2LuAUyfgJuRtawVhFQWQkg@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: at91-pio4: use dedicated lock class for IRQ
To: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Cc: Ludovic Desroches <ludovic.desroches@microchip.com>, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, linux-arm-kernel@lists.infradead.org, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 15, 2023 at 10:35=E2=80=AFPM Alexis Lothor=C3=A9
<alexis.lothore@bootlin.com> wrote:

> Trying to suspend to RAM on SAMA5D27 EVK leads to the following lockdep
> warning:
(...)
> Fix lockdep false positive by setting a different class for parent and
> children IRQ
>
> Fixes: 776180848b57 ("pinctrl: introduce driver for Atmel PIO4 controller=
")
> Signed-off-by: Alexis Lothor=C3=A9 <alexis.lothore@bootlin.com>

Patch applied for fixes.

Yours,
Linus Walleij

