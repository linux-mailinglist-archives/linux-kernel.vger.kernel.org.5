Return-Path: <linux-kernel+bounces-167463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58EC48BA9E3
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 11:30:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 159F928342D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 09:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7A8014F13D;
	Fri,  3 May 2024 09:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="grBC8Hap"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0DA14EC67
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 09:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714728611; cv=none; b=Ch0E8qeRBO9cP313Gmw3IA94mUGauRRXJ29RcRMgk3aCKKtA6HdM4ryJCmSD1ApT4BDC3Ty5eDF+inrMSf2B89cMERQidNawg1bmMeH4HPVIPtvClpU/sxh0qfuCzlKd1cGqdXxdiOvo9w+YjVTr9s5yjep+V1OgnIdC/IUSHLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714728611; c=relaxed/simple;
	bh=ZNb2/oSuDvsekJbrUvzVBARQvr1M+l1FF1dsoV5we18=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KxnPSgGDTnOMgWb6OUmqarGkjCNS7Rf38qex5lMZf/j5OX/fs09b+ql7epioG6YQElMD08FQXTAcMwUcZX74RuwT+zVVZiqjTodcM5zN7fFZeEu06t0IX5SuzF7KZtg6Qgtib7yRsZRpeM4odeiO2V/o74ZOMowO1nCkTfCN2UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=grBC8Hap; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-41b9dff6be8so49011605e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 02:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714728608; x=1715333408; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KULRcTjxfat7nflWft5bz9NukEzEddiZ2lggi8GzZ0E=;
        b=grBC8HapctbhvTbub7vtfg58qy5UOfQxyjgAjDMr32V+DGEd/69rY110u70yzZlY6a
         YmTPKt6IV/MsENRwslhCcbDgSBGDe4k4WwzTlYIt+UO878ZX9DsXIkIBMxVOx1zoJcMY
         FgyP0o6IbUbVXaV/zQE9StkIZtrzmXk2HHCRqlXL4sUGRIgGwR6+/lv89I0zWRDMwEYT
         G/IBabHtyjy3TnI+0zk87noYm/ZWO0Zw3J2clS2bjmnsg/8KU+9cPmQN6GJ1G5t4k8al
         m5T7fR3TvFhtVSnfpYMK9+YV2RvBLszqst1ruyBDcymP28MMtXB2/tAKCpwzjRoyeK5+
         Xd6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714728608; x=1715333408;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KULRcTjxfat7nflWft5bz9NukEzEddiZ2lggi8GzZ0E=;
        b=G0fi7D0R2sJ3SfUA6m8CKW6EmujZOoztqO6a06xGoecBgY/dV5MxoaWLPwXxZp/vFo
         y18UYYSxYYGANGesa/9fjuEMiIqYSHdrRa1cx6Js+Fs7WEL61meRDLjSNgnbqkFY2jUT
         J8TykPOuS8RcmjrS2rVRoCOj2xCppjEKcLNd51AOATnbKVElRcwIHXXlBUKOw7ZQ/qxK
         XrTP0wnF96usHma8mtTd2hSEm0urXkenBPwmdXU76EhZteXX2Qgq2kpQfaxgWY87VpuS
         N+jXpo8enc9dinkb0m1V+SFSRqQ31Qm9unc/Z2TDP0iLQNvx7WP+TWlucyPkBSvdTGga
         sgqw==
X-Forwarded-Encrypted: i=1; AJvYcCUYnXi9snhXEAj9eDY/J8GSJLy713jfCZwTUa7lmXGStk+gwNbzSaJVtKY+3EI5q/xbgY51TDX4Ihhrabr9arjDmTuft7wDTfndMTAC
X-Gm-Message-State: AOJu0YwESqy54HzMh+4iRlLQ/IyY9D58LvRWKEIrDC+SFAjHdr/5LP/J
	hJGjJHVU3QRQ1GzWNghohI40rt4uiFehYZuJfZSuZDNkDP8EM7nxbrBN25RW4F0=
X-Google-Smtp-Source: AGHT+IFMjfL7kc5atSQVs5RqNDVKOWw0871oLlfuW3vxv/8yUSCVntr1NwQgjxnL3bhXh2tYDPwLzw==
X-Received: by 2002:a05:600c:a01:b0:41b:13a3:6183 with SMTP id z1-20020a05600c0a0100b0041b13a36183mr1736973wmp.24.1714728607700;
        Fri, 03 May 2024 02:30:07 -0700 (PDT)
Received: from [10.1.1.109] ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id bi9-20020a05600c3d8900b00418db9e4228sm4988571wmb.29.2024.05.03.02.30.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 02:30:07 -0700 (PDT)
Message-ID: <0106b6f58ce19752c2c685d128e5a480103ee91c.camel@linaro.org>
Subject: Re: [PATCH v3 2/2] pinctrl: samsung: support a bus clock
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, Tudor Ambarus
 <tudor.ambarus@linaro.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Alim Akhtar <alim.akhtar@samsung.com>, Linus Walleij
 <linus.walleij@linaro.org>, Rob Herring <robh@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Tomasz Figa <tomasz.figa@gmail.com>, Peter Griffin
 <peter.griffin@linaro.org>
Cc: Will McVicker <willmcvicker@google.com>, Sam Protsenko
	 <semen.protsenko@linaro.org>, kernel-team@android.com, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Fri, 03 May 2024 10:30:06 +0100
In-Reply-To: <c39eab66-4e78-4f24-bcaf-003161b38ed0@kernel.org>
References: <20240426-samsung-pinctrl-busclock-v3-0-adb8664b8a7e@linaro.org>
	 <20240426-samsung-pinctrl-busclock-v3-2-adb8664b8a7e@linaro.org>
	 <ea6f17d7-49bf-4a1e-ba3b-757e29221590@linaro.org>
	 <9a960401-f41f-4902-bcbd-8f30f318ba98@kernel.org>
	 <c4c73732595b067369a6c8d71508d54358962552.camel@linaro.org>
	 <c39eab66-4e78-4f24-bcaf-003161b38ed0@kernel.org>
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

On Fri, 2024-05-03 at 11:13 +0200, Krzysztof Kozlowski wrote:
> On 02/05/2024 12:41, Andr=C3=A9 Draszik wrote:
> > I was initially thinking the same, but the clock seems to be required f=
or
> > register access only, interrupts are still being received and triggered
> > with pclk turned off as per my testing.
>=20
> Probably we could simplify this all and keep the clock enabled always,
> when device is not suspended. Toggling clock on/off for every pin change
> is also an overhead. Anyway, I merged the patches for now, because it
> addresses real problem and seems like one of reasonable solutions.

I had contemplated a global enable of the clock on driver instantiation
as well, but in the end for me the reasons why I chose the fine-grained
approach here instead were:

* Since the clock is only needed for register access, it seems only
  natural to enable it during register accesses only. (The same would
  happen if we had support for automatic clock gating in Linux).
* If we think about external GPIO interrupts, they are likely to occur
  very rarely (think button press by operator on some external keys or
  I2C interrupts), it seems a waste to have the clock running all the
  time.
* drivers/i2c/busses/i2c-exynos5.c and drivers/soc/samsung/exynos-usi.c
  also kinda do it this way. Bus clocks are only enabled when needed
  (e.g. during transfer) (granted, the IPs (IP clocks) are also fully
  enabled/disabled in those drivers when idle, and there is no such
  thing here)


Cheers,
Andre'


