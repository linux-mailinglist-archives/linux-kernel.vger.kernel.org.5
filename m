Return-Path: <linux-kernel+bounces-42337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17B3483FFD0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 09:16:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4ACBF1C22BF3
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 08:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0552B52F97;
	Mon, 29 Jan 2024 08:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MXFHZndS"
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D156AFC1E;
	Mon, 29 Jan 2024 08:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706516177; cv=none; b=eYNXfBFEOXTvHDcphD0Idgzhe3cmsq0ZdCX+trAuRRfAdi+toUe4lwkhZA3FpOqbek21QqmTB1UmB+YadPq7WX/KCGELaMDRyurS1htaR9q3zkAU8xnb0QiUjHr5Q6NCVFeRn4cccSvzKpRLF1wvYTpg32TkLiZeczZ4TVAfilU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706516177; c=relaxed/simple;
	bh=jFq6CQO9eMcsqJNLoTyOaRKicc+pCL4ISPcZG7GRp1U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JvsSOugODvt09evKW45ZVstBn+z3SKQ5ceck8K8yzZORrLnpBrraubEmy9JnT/hUr/L+YmV+PMmRr9NYgPyOMyH3EHMG9Lk3jDNDiOZ5i20heXrTrrGY/se//QIfc4Mv+7ArEFPlH8rWWEEab2AKqwNnk/nWmTyewWNIfikQjZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MXFHZndS; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-4b7fc7642fcso340797e0c.0;
        Mon, 29 Jan 2024 00:16:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706516174; x=1707120974; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/OL962hsrazE62p7R/jJW2A1J29P+0IWGTWAVOKd3dc=;
        b=MXFHZndSOTqGhp/9kDYBFlzd98hV4Dfee8lxBS5KV64dToev0O7UKr8wXk/WbNNh8X
         ZAw4RHlLHowE925ko6IHzq5zQZ8NjIJ7LT/KfurqVOIfGoWsUVar3AxphGj9AgzI4Xlr
         2Ry37zZW2QtYH1Wd/CplNjrEqh74L4Biy8sRG3SdOfen17p8sBF1tjfdOU9Sm6CE3aMn
         hHhvpdbh+DU3zvUuA2MA4UksZftTgYjhWFU/W/Zd81p3JC066DnbpBut9agv1/bp9sdQ
         supa/e87LFFJlPFNoqr5/kFNOmL6dWDhGL/FHQwgEKGp4ICKVgZX/9UIFs6t6XIUr7dH
         JlEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706516174; x=1707120974;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/OL962hsrazE62p7R/jJW2A1J29P+0IWGTWAVOKd3dc=;
        b=ZucXktoLourPE34pKHCtRomsUq2q7mU+HDUr9w1a2l8I2bpllmtC7n9RbwMtC9n/Ce
         Ei10Uk2MwCL4HyGWMqIwayFqN/iH9fsMTCTrgt5Oo5xnhXr5vjSxQtglufheLoGrCD+C
         fReUTIiJFieTM3gjCfJ+lTTmwpeVDqsNaFkPn0F2f/FboI9G+cwr+6xkoXWtkHwkrhrh
         kV28xj4roYnJQ+V5bUpY+uV5PemKJUYoEGOxvvTc9lUyj/lyGVP0W0gg7SQmViqAFtNQ
         7Vxusn8FIqw2a1nQLnJrdbFct4J5f4+tHRH3AKCmEFsux0dpThfw52mIWpcW90txvLuu
         zQTg==
X-Gm-Message-State: AOJu0YwR3946pQbIJOMDJ6240YvaivNnQL17mopH0dBOX+xme+DE4ZN/
	pGBdQ3mcmHKS+/x3IDq7/IM385Q0Eto6P/MvVixJDIr3F/HGwqyOD0v6Ap3xfla9FtMjkx9LzAE
	5+/wbSNCB1m4rswInmeKjHlPQPYI=
X-Google-Smtp-Source: AGHT+IFVLswNDcWZYfO3yzzAlQv+TtXRezQ/W4fDx0M03rR10TDzekL3bjX7/Ul6Vk7QpTK9ppe6q4oY0+U+lD94G6U=
X-Received: by 2002:a05:6122:2528:b0:4bd:5799:2c09 with SMTP id
 cl40-20020a056122252800b004bd57992c09mr1524815vkb.5.1706516174654; Mon, 29
 Jan 2024 00:16:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240115130817.88456-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20240115130817.88456-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Mon, 29 Jan 2024 08:15:48 +0000
Message-ID: <CA+V-a8t4v2CxZWrLRKBinS5fyG-_FzDFz5zA=mgcrNutJABr5g@mail.gmail.com>
Subject: Re: [PATCH v5 0/4] Add missing port pins for RZ/Five SoC
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Linus Walleij <linus.walleij@linaro.org>, Magnus Damm <magnus.damm@gmail.com>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Geert,

On Mon, Jan 15, 2024 at 1:08=E2=80=AFPM Prabhakar <prabhakar.csengg@gmail.c=
om> wrote:
>
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Hi All,
>
> This patch series intends to incorporate the absent port pins P19 to P28,
> which are exclusively available on the RZ/Five SoC.
>
> Cheers,
> Prabhakar
>
> v4 -> v5:
> * Made struct rzg2l_variable_pin_cfg variables u32
> * Updated PIN_CFG_PIN_MAP_MASK macro to use GENMASK_ULL() as reported
>   by kernel test robot.
>
> v3 -> v4:
> * Rebased the changes on top Claudiu's patches
> * patch 1/4 is new patch for using FIELD_PREP_CONST/FIELD_GET as
>   suggested by Geert
> * patch 2/4 adjusted the code again using FIELD_PREP_CONST/FIELD_GET
> * patch 3/4 fixed rzg2l_pinctrl_get_variable_pin_cfg() as pointed by Geer=
t
> * patch 4/4 is unchanged
> * patches 1-3 have been boot tested on g2l family
>
> v2->v3:
> * Fixed build warnings for m68k as reported by Kernel test robot.
>
> RFC -> v2:
> * Fixed review comments pointed by Geert & Biju
>
> RFC:
> Link: https://lore.kernel.org/lkml/20230630120433.49529-3-prabhakar.mahad=
ev-lad.rj@bp.renesas.com/T/
>
>
> Lad Prabhakar (4):
>   pinctrl: renesas: rzg2l: Improve code for readability
>   pinctrl: renesas: rzg2l: Include pinmap in RZG2L_GPIO_PORT_PACK()
>     macro
>   pinctrl: renesas: pinctrl-rzg2l: Add the missing port pins P19 to P28
>   riscv: dts: renesas: r9a07g043f: Update gpio-ranges property
>
>  arch/riscv/boot/dts/renesas/r9a07g043f.dtsi |   4 +
>  drivers/pinctrl/renesas/pinctrl-rzg2l.c     | 284 +++++++++++++++++---
>  2 files changed, 248 insertions(+), 40 deletions(-)
>
With recent changes to pinctrl-rzg2l.c this patch series (patch #2)
does not apply cleanly anymore. Shall I resend it?

Cheers,
Prabhakar

