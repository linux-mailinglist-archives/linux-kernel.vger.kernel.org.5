Return-Path: <linux-kernel+bounces-167383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C00F28BA8BF
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 10:29:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75AD81F22B28
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 08:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7089149C7F;
	Fri,  3 May 2024 08:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NLy7oWC8"
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73DC148853
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 08:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714724965; cv=none; b=sBbsIOZwnGUVsedLPCdX+qkc8qei79sEdSOTqEIMnXvJhZY8QcHqH5RTdGG9LbXbSuDv4vBVxniszGRzwVAjuPp9tpOYserzNNHnPzrZ8ndg5NssGdRpGad4sC32EfI/Fl4gtLciVAMR5hURGynyaVNIFfAVT3eJkKC9QKlbLpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714724965; c=relaxed/simple;
	bh=/MOdj/lifA2AeS8oNIVW2cyzjNKX16mBXmADEVtzHTE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BM/Oi7nEnoxOxdavY2XdKaNDgCdw3sUMVB1BXE+OyTEKLOXML+uVP76qYtGkji5fudd7oSeUmB7eyoR0DNC1F/iaDUtA3f6QMNwEGg8+nEMLYLB8sNiqX9O0AxicHgeu/Im13QObdGgC0++kj+AGKxUNPy4sxCBZcFK3QYm8xA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NLy7oWC8; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-61816fc256dso91651737b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 01:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714724963; x=1715329763; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hzQNzscPC/5W0S2y6e/zudtD8W7uyT+JqOosYf+h760=;
        b=NLy7oWC8TTrNsBXz+1Bhoc02nBlA4kukWsU1I1vttmfZPlOJojsS+5tHZgZgJVPSDS
         C6A1puitbVKMx+UnqbRENcSDPsO3xq4SDFRJ+hhcvAfu0K4ZW4zIM/C1osB+qiaak7FS
         SduKaWrRPBc+/y/G4HUrD1AOF8uveEsUsZDBCb8sQPs9qnAWbJY5VzfS9I+Z9QTOFwdD
         m7+UkVDr3UXbwG/BBTvqFrLU2H/kEItKAYlOLhXOFRl8Y+++mfMMSHpClpA4kas3EIix
         NpNjEjWvgGMzJjQtItpbv7C3HQ2LeyenIvtSAbWqg/61pLDqXO5889OChoG84ooAJMU5
         +b0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714724963; x=1715329763;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hzQNzscPC/5W0S2y6e/zudtD8W7uyT+JqOosYf+h760=;
        b=L6fXHIxrCv0u9DIAiYBEH4Vq7tSTKc+hRYVVPaWP2zzHx0MhdA717G37qsi0fAxKh/
         CtGUFqFYc9vl2EEd6ZqI3r8uL5iMh/jpMg6ioKKcfW0PjiwmxnKWYBClbLorYeyWGEuX
         YNlYkNPiB+Wxv3J1cGH01bdK0kfkHYnSiaCmUt2RjASjOtXKOrDNtxoejGE/PrF6LgsR
         F4LfyV1gJKZERQkxqexTHE+ER2NqXayftfcflDv+GRoN3+B5dgVF1r3nkf7Mm2xDaAL5
         sKisC2qf/5K4kU1805vLHW8WGHS5cm6ZcOKEKw8dGk1PyJ4aoS28q3d4UFBSnhj2+DzU
         19Xg==
X-Forwarded-Encrypted: i=1; AJvYcCUVZ6BYu6RHm1XS4OLkJls8t5FFotrrBpfxedjw7BJwGc6fIq6x1U4Qm2rHOwkUf15z1yO+Y7Oxmv/dZ2+b60oPku3Jzp/FKpBz6JBq
X-Gm-Message-State: AOJu0Yx/Q01RsYjd2uzGI+MhIDr6rZohInG9qvR6/Zx+dEyqEn5u0pya
	B9noWIGPmtTKzcOUquaJRQtwm08BaT4iyLUUiFP7uodWE8ps9t8E1lH8d79ZkSJo0eTtWNR4iOp
	HljW3epz2DoZQfAvPBWED50QVJ12YA2O2qPkCNg==
X-Google-Smtp-Source: AGHT+IFWt9csUbF6rdhUA308re3cw714GiuH3rgl9HYzJ9A8Ue2Wv0YkRUWpPDVM8TxawqhSypKCCP0CB/OMjaYSqPw=
X-Received: by 2002:a0d:e2c9:0:b0:618:8b6c:6c1b with SMTP id
 l192-20020a0de2c9000000b006188b6c6c1bmr1824030ywe.4.1714724962750; Fri, 03
 May 2024 01:29:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240424185039.1707812-1-opendmb@gmail.com> <171411680836.6435.15788506275238936215.b4-ty@linaro.org>
In-Reply-To: <171411680836.6435.15788506275238936215.b4-ty@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 3 May 2024 10:29:11 +0200
Message-ID: <CACRpkdaBTwhmzs5guoBEqkvHrrowD8+zmSsHmFroxr7a5CCc9g@mail.gmail.com>
Subject: Re: [PATCH 0/3] gpio: brcmstb: add support for gpio-ranges
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Doug Berger <opendmb@gmail.com>, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
	Phil Elwell <phil@raspberrypi.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, bcm-kernel-feedback-list@broadcom.com, 
	linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 26, 2024 at 9:33=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:

> [2/3] gpio: of: support gpio-ranges for multiple gpiochip devices
>       commit: e818cd3c8a345c046edff00b5ad0be4d39f7e4d4

I'm not sure this is a good idea. To me it looks like the commit violates
the device tree bindings, which says offsets are on the local GPIO chip
and turn them into offsets in the Linux GPIO numberspace.

Yours,
Linus Walleij

