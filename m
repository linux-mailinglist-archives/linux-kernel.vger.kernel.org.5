Return-Path: <linux-kernel+bounces-151459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 870568AAF35
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 15:20:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 218CC1F2328A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 13:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0698886643;
	Fri, 19 Apr 2024 13:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gyxpWJ7D"
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B10127B75
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 13:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713532821; cv=none; b=AIEMxE4cXNmYAstI8oH1n1SwScNMHMNTbFBXzbU+b133MAYxbJRXf4vIWJDuOTncQ4bz6i5uJmvJlwhok4Eh6wko6ngSUkjXQSqmWitAjugTp45hP877scao+ve1OVc2Vi7GB9wnhmKSmlvXVynsUsSxfo33WMmJjdliIWU5NME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713532821; c=relaxed/simple;
	bh=ukqNim2wR4zF3yUVwL5ebSYvcGgLz6CYpTrNBxxNrNU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zp6yN/vtAkbOOJe3TGtWSMe0ScoVJ8FcWcM4ICtXlGB8I8Y3Azfwnqt4OqLa1XL1YU1MgFH04JmlIX4CsvIXdJyfonVKqeki3sn12HWv1ow6BnNS6CXs99Se3P8WVlOvhEVYrEmOM1nNQJ/8/PlnzcmVaF8eIiTnNyEsABso4wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gyxpWJ7D; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-dc742543119so2202069276.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 06:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713532819; x=1714137619; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ukqNim2wR4zF3yUVwL5ebSYvcGgLz6CYpTrNBxxNrNU=;
        b=gyxpWJ7DQoONgUIXaVXhsNH+4a//S2TMpfKpHA8nOBSsAifOpd9YXMcffjOfiKsQzC
         mUtuuhBBe/tauEnU2uRBZkwY8uw5l28Fp/MwFBYQ7VSv4DVK5yGJcfFEKb5aKCEBeTyE
         P+TtlJCHE+zynCGlX6X5WyZlZyebnHSYyjRz3UChIjxSKz0pHf/G3pvo3CKGcdHzUYHZ
         zs8AO1E6klEYdRYLJe9TPgsv8OTzW7eCczq8mhdMx14eYv1xEaFNf2jyDhWousRhbHTO
         CnJHfcwm8eysEdPujMC/a2nDuRTMLric+lDJOllwkxuL4kEoc8pbj0TOd+oCIRnhbkjG
         ZAUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713532819; x=1714137619;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ukqNim2wR4zF3yUVwL5ebSYvcGgLz6CYpTrNBxxNrNU=;
        b=ZOx22u3CCsguNcM0oPiljTNwhb1uGy5S1KuyDR5+EAfo3ZEANI2E3dQhTHaR/jRMs6
         E4bcvd2pH1p863TDcem5bgxO3sSJoRUBl8Z/u53SulKqHIagPdzFjhgGhgCCq4QI+h6O
         WlQD37Adm0SVW7RQt3JqfC1VEESifOfyu5TCUVvofMMic1g3atNxX8OFazl0cXoGyYAB
         /ykVC9/KOjcHLnJl/pBoyA1pAyHqIusYpBxOavPZ8b5o9Z3Futgc/6K/p3U45h/dhLHZ
         VTUnng806J28jjxREWeu5IBjD+dhF1uXz+3R8fs9mp5bC0XdU+OidmnHWTGEfja9WI8i
         6twg==
X-Forwarded-Encrypted: i=1; AJvYcCV3UQVQ4NBDGuHDpKj5injkDaiXN7TBcDUXfhOLi/mE+HJoupdBloXD3OgrWtUr2tcoaCuq59CzVXpxpxwijPO3m4qliix21IMBaltc
X-Gm-Message-State: AOJu0Yy2D0E+pnmJ7SyCWplQFhNXj1UF1mA7nxHzrU6NCwkJDHQxglIx
	8F3eKLMqA2NvuXHqQaLQtuBdo6brxB6s8/1fnML1qpDRDKQGUUV1cNB2CiAg/J9RPeQZrkvLHCq
	hrTXTk79st7aYgj3NPJwputOMV/RFlCXmAr2xlQ==
X-Google-Smtp-Source: AGHT+IEI8D+Rjptnk9iY+KnYSSwY8zcUnaRQkQica2+cfdRoT6xlKYqfZKkb6nl1YXf4Kgi4R3V+bGAEnQx8Wp+MmB0=
X-Received: by 2002:a25:acdc:0:b0:dc7:4460:878a with SMTP id
 x28-20020a25acdc000000b00dc74460878amr1977072ybd.3.1713532818807; Fri, 19 Apr
 2024 06:20:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240418-pinctrl-scmi-v11-0-499dca9864a7@nxp.com>
In-Reply-To: <20240418-pinctrl-scmi-v11-0-499dca9864a7@nxp.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 19 Apr 2024 15:20:08 +0200
Message-ID: <CACRpkdbswetf2Tr6H216nxb8XKX8evyiWiVcsK5E=inqBUUVng@mail.gmail.com>
Subject: Re: [PATCH v11 0/4] firmware: arm_scmi: Add SCMI v3.2 pincontrol
 protocol basic support
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Cristian Marussi <cristian.marussi@arm.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Dhruva Gole <d-gole@ti.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, 
	Peng Fan <peng.fan@nxp.com>, Oleksii Moisieiev <oleksii_moisieiev@epam.com>, 
	Andy Shevchenko <andy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 18, 2024 at 3:24=E2=80=AFAM Peng Fan (OSS) <peng.fan@oss.nxp.co=
m> wrote:

> Per Sudeep's reply in v10,
> "This series looks good overall. Since it has pinctrl driver, I need Linu=
s
> to ack/agree to pick the whole series up or I can ack them so that Linus
> can take the whole series. Either way it is fine for me."
>
> v11 is just minor update per Andy to patch 4 and Andy's R-b applied.
>
> Hope v11 is good for you to pick up.
>
> Linus, would you ack or this patchset go through your tree?

Since most of it is in firmware rather than pinctrl I suppose
the best is to merge it in the firmware or SoC tree, so:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

