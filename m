Return-Path: <linux-kernel+bounces-41440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16A0E83F174
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 00:02:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6671287481
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 23:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8F74200B2;
	Sat, 27 Jan 2024 23:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LL5J5/am"
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17191F93F
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 23:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706396569; cv=none; b=AomusCTUpgXCx5VRVyjEghLO3O8xjFW1eGQUvK6uJMlYbO3MFjpvGY+NoT/JfSksR+UXEBdt36p23q/vrF582DLhnNj1eDRPi8sS+TcJ+QLw2swR3gs0XlruMIvGTb28L5Sd6bE+2CBN6ou2XHYMf6XI8z5W9mZENvNQlc6GgHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706396569; c=relaxed/simple;
	bh=OI/DYxsJSWBx+d25tKtsRfVL4GAUVdxqmdpn8lShZf4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=At71nFkgbWpfeemW/sCHge7nBERpmW337ELut3uXq0iy92lUtH2dBJlrm+AHQiSqUx+q2CkpkFYo+8p+vrWaZ//TsnwrCvb0UmWsxjjQc72x8RBa1O1q1yzE6fT1DvrNeN3/+cQEuc1K83NwbhalqWLfQgfVlNsIJzj4cHxiQcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LL5J5/am; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-5ff7a8b5e61so15049687b3.2
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 15:02:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706396565; x=1707001365; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OI/DYxsJSWBx+d25tKtsRfVL4GAUVdxqmdpn8lShZf4=;
        b=LL5J5/amWFJyixSoJ4X2157faCEDESiXfEqGXLzuJt4ntBLdTnR8KGnquBI5J+zLHf
         RWghWMasiJqaD7N3H11e8rTymFRe0B154vMispUPO3t9fMyCtf17XZKph10kFok4QVRu
         cVc6qLoMJaYrflGi73rh9yDKdyrqBnIg2c025wURB5TpupoCXv/6ckkfS0SQ2GJOIL1v
         8oe9zCXmLy6Cx66UKAjaPEmvu/AjfXWJhmNySjrU0yizVfxwgyaZJebW7ELoZbc6Yct+
         fuBhxDTqCmYO4U2kMS7gsWJjX6FIUTd8T9uMkSV/i0mBiA8+8LY9V7GUsB3l5My+L9Nt
         R0AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706396565; x=1707001365;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OI/DYxsJSWBx+d25tKtsRfVL4GAUVdxqmdpn8lShZf4=;
        b=ob+Aysup+Mxws1QpQ21NlHM9G0yQUZxmf7tx/BalID2AlVJ1lSeETJYooHfVhLsrPa
         BZ8Imn63BvRyrgYpUtmroLOhYbiPqrDM8q5dYgr7cEV0yWcFABH3EYiDNvJFVCWe1kBq
         gOjl+7yZCAiG+Q+W35OgerPyt8lWh3HHjlv7iBgb6+KmJLxxU1R7+cCb10a3rQGcUHR8
         XxzB4R20/HidqPEW8Xp+U4QiULGBE46SllPWQNjuuwgyN/E3kIhuLpiptEMYlsTgEuaT
         AvxkxG9Bmh7Ww8c1HEzV2osiOJUEPQj9w1hcXBUw2Jv3CGqwekpfR3dnZuLU0WTnQdYs
         hoZA==
X-Gm-Message-State: AOJu0YxYlt5bYMfnxrLZpA+iuNmILD6V7n+wcxDESncdjcKfEaqLEOY9
	fyC8C84dLsqdob5hvIY0Av3QE0gsEYE2cQ5nVpbPSbVaPDXncP/oGtCPLlgh6+5/FF2QWu/hhE1
	gszG/DjR6GJW5n/DolVwyiOjpjfd9+T5zj5qvZA==
X-Google-Smtp-Source: AGHT+IGyjw9LIiDDoT2S5tGsoR6J36rkT7VTljb52lUEVS87VMLK8vJpNqzNYIdeGvFGjm5XifyDw3lPWoEfckgnn6c=
X-Received: by 2002:a81:a709:0:b0:5ff:6173:e98e with SMTP id
 e9-20020a81a709000000b005ff6173e98emr1920073ywh.63.1706396565671; Sat, 27 Jan
 2024 15:02:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240103132852.298964-1-emil.renner.berthing@canonical.com> <20240103132852.298964-3-emil.renner.berthing@canonical.com>
In-Reply-To: <20240103132852.298964-3-emil.renner.berthing@canonical.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sun, 28 Jan 2024 00:02:34 +0100
Message-ID: <CACRpkdZhzC_4ZFV6cpA5=tHfzyv+NjFBoFC3=jenS2x0-0DZmg@mail.gmail.com>
Subject: Re: [PATCH v2 2/8] pinctrl: Add driver for the T-Head TH1520 SoC
To: Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc: linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jisheng Zhang <jszhang@kernel.org>, Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Drew Fustini <dfustini@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 3, 2024 at 2:29=E2=80=AFPM Emil Renner Berthing
<emil.renner.berthing@canonical.com> wrote:

> Add pinctrl driver for the T-Head TH1520 RISC-V SoC.
>
> Signed-off-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>

This driver looks mostly fine but I am waiting for the bindings
to be hashed out.

Yours,
Linus Walleij

