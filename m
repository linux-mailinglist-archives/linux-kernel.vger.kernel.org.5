Return-Path: <linux-kernel+bounces-22349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 121C5829C75
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 15:23:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2D20280F06
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 14:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECE744A9B2;
	Wed, 10 Jan 2024 14:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Cz5SThqY"
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C03495E2
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 14:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-5e82f502a4cso32958637b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 06:23:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704896618; x=1705501418; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U1KahT73zVp8kQdnLgcee+QY1qSTfdyvfyvMO4J8j1I=;
        b=Cz5SThqYORp/zxP+prH/2JlTZ39DV0p6zkreFSSe9bvXG5b7SWBj5Bzq3rDbv45HIV
         EYZrEw+KM+K6y5WL5r87nrxedutzYOHotYGGvp4SPqB2nnXjP3evguV73rgz3CpS96DP
         MBrlKCTDbqDWusR/mb7JvRjgyrguz1hysu7thOEzQ5QGkNuXs+awEwTeAnFAEyhTvB8j
         +zHI2+uxeGkQP53uwY956t+jdsPIwiRr9DkQKKe0Eo4qztLwsXA7BOzRTTVpTs29pSWq
         nfAiXmFPy3+VKfpGAglGPOBvuCiY6ra/Jy8WAkRLlgOfRgmGl8Z8FxLmyoRTNYVD8dyO
         F+1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704896618; x=1705501418;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U1KahT73zVp8kQdnLgcee+QY1qSTfdyvfyvMO4J8j1I=;
        b=gOC6xXHkELP4wtZQ9/kLpofYPbp2xkqDmPAB1rd9F6p34f4y4yLvYeI3mUo30VKqM1
         vQux2ocFmRpsYcOIx3JvC4qZ+R5ngVbLN47I8AbKeVdxmRMqJTLUsX2BbCmoTw/UGnyj
         uT0ypUJZ1NNYF7Gbd46+Jl3NIBWExVoVk+j4jdajjJIHSd4KcpOJGN0eDK9GGh89tpho
         vgBp6VsJMao/c8ON1Op5Rcef+yBu8X3wpvB4cvx2ZXie3imXdVMalDIkpX5b1sQxIBzV
         ej9J6pZchNg93H9oFQPLsmjx8EZOdR0uIQJG7Yx5OEGa7L7cKN1IHRkdVocErcFTyKwi
         HnqA==
X-Gm-Message-State: AOJu0YztZeQ0ucPC8Fm7P1WQ3rx6ud28W1Wj6u/geDpq/47Hs5vQC6wW
	XjfzcfDP6M65CtIiErBSTtuu1K5trj+WHIsK2WjaiVCXW7irZA==
X-Google-Smtp-Source: AGHT+IGoBJrdSouc5G7V0M3BWF91ljY07dml4dK3g0/CQgBFTa1LMhmxdzyUhzpB+ebjkM6xeu0Y06QNYW0hjlJzlH8=
X-Received: by 2002:a0d:d207:0:b0:5ef:767e:11fe with SMTP id
 u7-20020a0dd207000000b005ef767e11femr881955ywd.4.1704896618427; Wed, 10 Jan
 2024 06:23:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240104-pinctrl-scmi-v2-0-a9bd86ab5a84@nxp.com> <20240104-pinctrl-scmi-v2-2-a9bd86ab5a84@nxp.com>
In-Reply-To: <20240104-pinctrl-scmi-v2-2-a9bd86ab5a84@nxp.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 10 Jan 2024 15:23:26 +0100
Message-ID: <CACRpkdZggU=P8pjcrRLZtS=yYjeS1+FT=gsRf7jq3ehLb4sEiw@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] dt-bindings: firmware: arm,scmi: support pinctrl protocol
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

On Thu, Jan 4, 2024 at 11:44=E2=80=AFAM Peng Fan (OSS) <peng.fan@oss.nxp.co=
m> wrote:

> From: Peng Fan <peng.fan@nxp.com>
>
> Add SCMI v3.2 pinctrl protocol bindings and example.
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

This looks good to me.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

