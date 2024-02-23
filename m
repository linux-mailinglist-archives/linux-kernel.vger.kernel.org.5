Return-Path: <linux-kernel+bounces-77930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3D96860CE2
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 09:34:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30EA11C24BD5
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 08:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F08F1AAD2;
	Fri, 23 Feb 2024 08:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hspgkU4V"
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D18917BAC
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 08:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708676907; cv=none; b=CEjZsU5AbYYNQZmjiNIjHnmLWeTQwHMh2tuOW3+TqRUEiRBryTEKY3OeFgJ53JvDRrJ1T6VpJjS+ONGKaCvFiuSh89/7sVqjI7TygYFHjVdt/MiF7dXoK6mcjx6qBbCHaBc/ncUR0vLXvP45G38ATPyboZE6T7aAwpe9f5XrJpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708676907; c=relaxed/simple;
	bh=8AiynCpe9xm6kQcOTCDN5hH0DOETixPNQfpGOskMMBI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O9Pv4J/AZ523w+A8b3+/AqF8pPK5Pjjh8hp+2+0G+CXQXXl019DetysBvxqDBRbZdisAdJucaz5APE42IimIiCYXlHd61UuR7XCBXHb7tDGBchXQnCmMSpAGPICXyMViYGHNFBbSPKZJsCcPBU/OdSgCzskWIGxktPfBiukwWcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hspgkU4V; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dc6e080c1f0so92705276.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 00:28:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708676904; x=1709281704; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8AiynCpe9xm6kQcOTCDN5hH0DOETixPNQfpGOskMMBI=;
        b=hspgkU4VuOYaCAYPBmvVF/+2R5JyzbNB2B/GRCJWBySrNNcG9uQ/mZQ/Oh7kpaFp8X
         qPAxk4/A39k38ZhDtIbMoh2kByr/fcOQKvqqJfZzb867K8L0olDNFw71V0UAeP3aUxvp
         aKXbmTeibIXNwTdIxJPzGDzt7M+L3lk+5STrThAdgXWVcJv62Wz96p2+3qg2tYCRK0X0
         kbGA+w+b+2xbwsrgDZ/IFW1KjuLV3b9G2ZPoGNLsOrHFZdAAKuL8sL+yw4xvidIMk/Dz
         UVPh21EP1q0ldgz56cbHLbWI5U+/yxHmkJmpF2g9d4U+dybUOlefuJO8K/HcouBSh2h6
         R5rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708676904; x=1709281704;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8AiynCpe9xm6kQcOTCDN5hH0DOETixPNQfpGOskMMBI=;
        b=h3B7qQG3yUQM0QAcP/rGJFFJy/WXBoNgw2+H8h/zKspJuoSBT057Qht9p8HAqzsMI5
         dYPa4yqIWUC7apHnATtz77KgvLrhWezK6T964vVt6fhxsOpg7x5pBxqnq6ZswtqcNy00
         /k5t2EAkTUZgYWcfzsB4sHut5kmJBxkIbMypSZhOWi5A8rQ5LHnzmuZMOvM5Nsyi3bQy
         Y9ggqB/C1+54ksY+2UjxR5mED977STYCHUr0ltaJm9OKrnBdCCN6MWh8b6mAAIDqu+yQ
         dppO1yIBgbv1Tf/Tk6Uz/sLcns3Y3lBFsUVkQIlhzbddJDJHrE9Tc2gvBQDM3LqPBAFv
         FEeA==
X-Forwarded-Encrypted: i=1; AJvYcCUNZfdeYvawxoGb1GtpiAICHa/Cx7oJRTOKfaGNwLd94ONqwaUXpDgt4JuLvp7ITl9Lvr8EOicD0MoNLKa0W8VtbP17efBNzwukwRGn
X-Gm-Message-State: AOJu0YyxcnQrUx6ja5XTL6FeitnZRhEwiv304KwzAVJqv88c+wBiDGM2
	o1yQZOLQXeQ1mRYHChQSAKWkDRdcQsmNmBWQ2WHsYfVkB9XcPxzFREvLdq2I08YXYdXyOCqmcCD
	VHuYxxcqHYUod1uF4fAE7kxw7y6IbQmpmrFJegg==
X-Google-Smtp-Source: AGHT+IFZmfPy2te5fRsS6uPQOwURXMnZozqqnqYceFRPogHaB094n6NaUZkzBM6xsJv0mbIN5skNvcuRImnUSaccFbQ=
X-Received: by 2002:a25:5f4b:0:b0:dcc:b69c:12e1 with SMTP id
 h11-20020a255f4b000000b00dccb69c12e1mr1538778ybm.59.1708676904144; Fri, 23
 Feb 2024 00:28:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240223-pinctrl-scmi-v4-0-10eb5a379274@nxp.com> <20240223-pinctrl-scmi-v4-3-10eb5a379274@nxp.com>
In-Reply-To: <20240223-pinctrl-scmi-v4-3-10eb5a379274@nxp.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 23 Feb 2024 09:28:12 +0100
Message-ID: <CACRpkdZLuWwecacBAimT=Vj67dGabzBH-7aaqzoyj1B1sY6o_A@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] firmware: arm_scmi: Add SCMI v3.2 pincontrol
 protocol basic support
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

On Fri, Feb 23, 2024 at 2:08=E2=80=AFAM Peng Fan (OSS) <peng.fan@oss.nxp.co=
m> wrote:

> From: Oleksii Moisieiev <oleksii_moisieiev@epam.com>
>
> Add basic implementation of the SCMI v3.2 pincontrol protocol.
>
> Reviewed-by: Cristian Marussi <cristian.marussi@arm.com>
> Tested-by: Cristian Marussi <cristian.marussi@arm.com>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Oleksii Moisieiev <oleksii_moisieiev@epam.com>
> Co-developed-by: Peng Fan <peng.fan@nxp.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

This looks ripe for merging for me, there are clearly dependencies in the S=
CMI
firmware tree so I can't apply this to the pin control tree, but if
someone creates
an immutable branch from the SCMI firmware repo (based off v6.8-rc1 or so)
I'm happy to also pull the branch into pin control.

Yours,
Linus Walleij

