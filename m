Return-Path: <linux-kernel+bounces-163000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C27E28B6333
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 22:07:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63A811F22B90
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 20:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 837021411E4;
	Mon, 29 Apr 2024 20:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IH0tPWo7"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1101411DD
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 20:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714421206; cv=none; b=DHjlJ5a+GBX32fdUSY/Ri5OoL8/gNc3CKhPR1D8lHSF72hcy7jmy9N3KyKnTWI3+t0VS+3szkt0jmRklzVaqAnbvUSuzeYZOaqCWma3U4cFc40/usiyh9gn4xRWo0g0/LVFqL7J1K3tfx7hAZDuNs+k/A4vIm6yh4Eof322uefg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714421206; c=relaxed/simple;
	bh=8jUOgi1XXZrbwIAYkNr9gAmLVkhI5hRZK/P2iEf8yFY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qHNh/woxNfHK/CZEiKIybDAS1qiHCkyP0Ie+YJXHyU+BBXl7lyOZGMkM56JlcruHYNLXCyFrkG02JBOcFbpf6V8u3UCXZ8ANCW8jFP+DBsW3XZpxP7WQhw+t+3C9No/z6vlyTDgN7i/dBtpec1M6JR1b+oKrQ17izo7LUo3YNDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IH0tPWo7; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-41b4ff362a8so44494105e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 13:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714421204; x=1715026004; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8jUOgi1XXZrbwIAYkNr9gAmLVkhI5hRZK/P2iEf8yFY=;
        b=IH0tPWo7ar8LriYX/sf9mw4BjARP1yv1gRmiiyCucXTP3pX6TRx9BaOYRJSoC7N5gK
         3KaGqCb70J7d7ftVT2T9fOzhjnMGDSKOzwf5+sPzP4ZPaL5grNj4pTGBgTxb1R+wwGNK
         5JaGSyPUFruHWPgQP33tvK7jHW4D6rJmj6XFqzWnAY+QV20rHS3+B4ufR2rCiF7INgTp
         8VgjPqqg3zF//W5QCyQrAJcWcDriRmnquwLiWzhO5x7qvREP30oAFityuNAfIxltU7mh
         dhcAh27QJ/kGjfpr2CTW4SNVObT/jAO86zrju8ndGXbex1TGohmiM5bGZ6QhGoA23q2l
         OicQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714421204; x=1715026004;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8jUOgi1XXZrbwIAYkNr9gAmLVkhI5hRZK/P2iEf8yFY=;
        b=esPCJfw1WHCd6NDPnXrwbXbNpIzowz3LfoHd3m5Iom5zcwzJtPJStyFvTC0P8+P06Z
         n2/znUSLywHqm4Zc4XWqNeZ4ty+EhAhRJi2m1nCSrpMhOuldljBtgWGoobSywPCOxuvP
         l69uOAoJnj7burzWHOGX2FatCpnlEniwKSZhdiukrsdCgca7hjQN2/YgFCCu2F8Acdv3
         e5lCDEYaCbA1ANWxGQoRw+weesRmj0yQ11ySaRq+PZ5WtdlBxbZDIEfg6I750wLKnzql
         zTs93lyTRjRtf4kwv0MW+rPbo0chRSEak8RRKh1wYBuXN5JXiSRW3949WdufWVd6W9MH
         Nk4Q==
X-Forwarded-Encrypted: i=1; AJvYcCU/fEy9PNJo3lUUnuSSr1C9LdeGd1ezmhqSDBSe3ZULTuiuOIiMCYNyaUHCkTsInpcLE51C7WRdokeTLdUc1d3Fh3ZCS8zKm+8ORh6B
X-Gm-Message-State: AOJu0YwyKJdJQf3dnDsz803ZDKfSq9EguCEJJEodDOmnRa7t54YE8ImM
	oa3nwF8ELkVE9P/JZeIGSkaIcSVLVf1PzykhoA4XbQ3HdcQV7rdJzXXwD1XFKOk=
X-Google-Smtp-Source: AGHT+IG/JkC3NmGrBVKnO/crSew2RZ93tKu5q64K7Be/fwVJ6UWNWK9tDLgS4WLRBO92OWd/6DjpYQ==
X-Received: by 2002:a05:600c:198c:b0:415:540e:74e3 with SMTP id t12-20020a05600c198c00b00415540e74e3mr10044316wmq.40.1714421203786;
        Mon, 29 Apr 2024 13:06:43 -0700 (PDT)
Received: from draszik.lan ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id s20-20020adfa294000000b003455e5d2569sm9432577wra.0.2024.04.29.13.06.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 13:06:43 -0700 (PDT)
Message-ID: <8309a9a8906d3b910f775c6d55d9f75681b03802.camel@linaro.org>
Subject: Re: [PATCH v3 0/2] clock support for Samsung Exynos pin controller
 (Google Tensor gs101)
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Krzysztof
 Kozlowski <krzk@kernel.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>,
 Alim Akhtar <alim.akhtar@samsung.com>, Linus Walleij
 <linus.walleij@linaro.org>, Rob Herring <robh@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Tomasz Figa <tomasz.figa@gmail.com>,  Peter Griffin
 <peter.griffin@linaro.org>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>, Will McVicker
	 <willmcvicker@google.com>, Sam Protsenko <semen.protsenko@linaro.org>, 
	kernel-team@android.com, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, linux-gpio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 29 Apr 2024 21:06:41 +0100
In-Reply-To: <479aeb87-ddc1-421a-a451-d9e62893eef5@linaro.org>
References: <20240426-samsung-pinctrl-busclock-v3-0-adb8664b8a7e@linaro.org>
	 <171441172281.306662.17546797534297489946.b4-ty@linaro.org>
	 <479aeb87-ddc1-421a-a451-d9e62893eef5@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3-1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Krzysztof,

On Mon, 2024-04-29 at 19:45 +0200, Krzysztof Kozlowski wrote:
> On 29/04/2024 19:28, Krzysztof Kozlowski wrote:
> >=20
> > On Fri, 26 Apr 2024 14:25:13 +0100, Andr=C3=A9 Draszik wrote:
> > > This series enables clock support on the Samsung Exynos pin controlle=
r
> > > driver.
> > >=20
> > > This is required on Socs like Google Tensor gs101, which implement
> > > fine-grained clock control / gating, and as such a running bus clock =
is
> > > required for register access to work.
> > >=20
>=20
> Where's the DTS?

Here: https://lore.kernel.org/r/20240429-samsung-pinctrl-busclock-dts-v1-0-=
5e935179f3ca@linaro.org

(I was waiting to see how the HSI2 patches pan out)


Thanks,
Andre

