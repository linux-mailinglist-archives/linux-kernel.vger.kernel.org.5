Return-Path: <linux-kernel+bounces-41472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB10083F263
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 01:06:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 197051C22153
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 00:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6232B1C36;
	Sun, 28 Jan 2024 00:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kvFaXOq7"
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B9115D1
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 00:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706400401; cv=none; b=fCWAjzUobsrCQolf1UfAMW7eTGZQ/XwAi2bESI8IUQQc9S25JyZYfZf6oULDY6//89Rj6H7o18mj8aO5Ieaf1QLoAjrjpdq48SZB5vMa+s32TJ6m+f2ykoz9BLTPQKPhUkuNk7jOwETeEfCga0q1djsjpV53hcD1YjF8phnAE90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706400401; c=relaxed/simple;
	bh=ammylFPq3l7kcWoDBrB+c62nBJSB6kVIemC4JBj/rF8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z0INnGz8DSjywjxKLOFDyJrnhJX4KOUwuQYf2XyNQcSn/lrbs2UbC9cTCZ9NTPBirD0B6muCMmcyF5rDBE8aGOU31BM52gmxKclH48yeM9oDaJ+BCWWa0nQVieHjGxC63KASq4dUWFyX6zZBn+3CGRikhxi5PmlD4mGUAmOYUsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kvFaXOq7; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-5ffa694d8e5so25075357b3.0
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 16:06:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706400399; x=1707005199; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oeb/WqSCatx9ZWHQi1P+avr9vJYUzW5yoj2SSuS3mkY=;
        b=kvFaXOq7HMBZRffSBFNLbYYe5nwUYjVb9HiotZbkddnYM+nYpiCk5VaZwwQyhPl9RO
         KZs64ES+xP98weC6AiIdVtdRcDVoaHHfXXFwfuo0tH2ZyDrCWW3TfgjPyFMViWME50/1
         p6yU7y4uDLReFv7pOgBxLHiK8yBUS3tAolDKbe8LrtFPYI1hN2ZgGE2WJF/MO0NMrzKL
         wYlyvs/6NLTKiPIiUNnXWxFvRdNlSoZprFjCleW8+XGm43MWi+J+uGq1FMJu7/XjlgOa
         3vNv8NDkqCK/OLOm7qCXr8b4fM+PzVTLenrk34BjZLnzu/6rpnCvV7nzkIltwkmv3vJA
         p1+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706400399; x=1707005199;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oeb/WqSCatx9ZWHQi1P+avr9vJYUzW5yoj2SSuS3mkY=;
        b=AVzHLG0MKoC4xzlPDjlnQg+0Vbds14oEcuoY0hJ/iijjRk6/cGwZyk1dqdPNB8l03+
         Dri95ayg1Ep8pH5vt7+ouRkTwNauD2gdK2pV2WXuAm69iO7ZN5XTb/NPKxPHND1XZ+sM
         W+P3P2As1xMqGKNWDYvruWZQORY8N32N/K/uHkLLqHUcGJCrS1TdZii2JZkdl845MfAV
         Wc3Dk+vi/to57lAM9TpfrCqJsVfvza5Rf3r3VngIJQThGewjFS6y1XmYn7TqI72jURZ6
         mApDTy9nDyL9Qafnlu0UiZU3sL/b8Utz2/jepyC+zipLVaT0ZYXjpTKN9eg1JgZbgBJK
         Wn/A==
X-Gm-Message-State: AOJu0Ywz/RcXk+mDD0GfZzkcm8an+ScLl/tKa2U1X8TZBddtsy/qWvTN
	iwAacn0/x6efZ7m5FpacU6CtBYTkPF5NSQy7eLGZa+/JUjHsgGWqXOilJm5qATtdbFW9GnMjh5q
	flZk5uLzR+IZ527FvV3G+VHdSFDf1duxjegS0zw==
X-Google-Smtp-Source: AGHT+IH8ey5M/U7KKK8/OFPC1e1ZRlA7GCbuqfy0BCvDeBIsu+/tzOOfOJ6Bk0ZVkw2d8ogJvaR+3xSia+nEk0U1xXE=
X-Received: by 2002:a0d:dd0c:0:b0:5ff:87b2:e43d with SMTP id
 g12-20020a0ddd0c000000b005ff87b2e43dmr1973626ywe.36.1706400398954; Sat, 27
 Jan 2024 16:06:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240104-pinctrl-scmi-v2-0-a9bd86ab5a84@nxp.com> <20240104-pinctrl-scmi-v2-4-a9bd86ab5a84@nxp.com>
In-Reply-To: <20240104-pinctrl-scmi-v2-4-a9bd86ab5a84@nxp.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sun, 28 Jan 2024 01:06:28 +0100
Message-ID: <CACRpkdbOVu4A0JdwvBaxvgvoT5u3VbjTyQi0mgqknCixR2vzYw@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] pinctrl: Implementation of the generic
 scmi-pinctrl driver
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Cristian Marussi <cristian.marussi@arm.com>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Oleksii Moisieiev <oleksii_moisieiev@epam.com>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, 
	AKASHI Takahiro <takahiro.akashi@linaro.org>, Peng Fan <peng.fan@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Peng,

thanks for your patch!

On Thu, Jan 4, 2024 at 11:45=E2=80=AFAM Peng Fan (OSS) <peng.fan@oss.nxp.co=
m> wrote:

> From: Peng Fan <peng.fan@nxp.com>
>
> scmi-pinctrl driver implements pinctrl driver interface and using
> SCMI protocol to redirect messages from pinctrl subsystem SDK to
> SCMI platform firmware, which does the changes in HW.
>
> Co-developed-by: Oleksii Moisieiev <oleksii_moisieiev@epam.com>
> Signed-off-by: Oleksii Moisieiev <oleksii_moisieiev@epam.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
(...)
> +#ifdef CONFIG_OF
> +       .dt_node_to_map =3D pinconf_generic_dt_node_to_map_all,
> +       .dt_free_map =3D pinconf_generic_dt_free_map,
> +#endif

This looks like with !OF the driver becomes pretty unusable doesn't it?

Should we just depend on OF in Kconfig or are there already plans for
ACPI or similar?

Yours,
Linus Walleij

