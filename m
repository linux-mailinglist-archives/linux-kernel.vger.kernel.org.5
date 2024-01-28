Return-Path: <linux-kernel+bounces-41479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C3DC83F287
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 01:28:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27B5F1C22041
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 00:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C68DEC2;
	Sun, 28 Jan 2024 00:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BnN6bWTh"
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F256817
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 00:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706401673; cv=none; b=qJw19GbRrWOZM542oF+Qff7mVvbvMGKx79z+qVx6D6HGLLUalgILr0l4dnB14/a4m7QAa6prg5/Qg1vHBknmMjpXF0iRP67ywrXR0N8jOxIob6LmZ53gRCC2q1BhWOWf0myxNS7mnRr16xBMrzus/9w5vFUHxjNMHX7OTWaiuPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706401673; c=relaxed/simple;
	bh=3G1BZUc/awZCAssluIQWHzMdeWDdPsi0QWKz/a/W1nk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d0ogkRtr3iQH6shs5plTbvjbo4jzn6UmOmIdDUeIXSQEF0RPkulM4ysbLj+QpvmqHq8fjuDNa+4Ms4ssxuUTAlCh10fVOwgplF2XfAKT9jPUk73e6iiKZmSYHzrKpkNIf7zQ4AKiFy6HayJ1zXC1qkoipio5B4uNfeXv0tbljxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BnN6bWTh; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-5ffe7e7b7b3so15214527b3.3
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 16:27:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706401671; x=1707006471; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3G1BZUc/awZCAssluIQWHzMdeWDdPsi0QWKz/a/W1nk=;
        b=BnN6bWThu7NpMfg8VfYYXG/LgBS5Ix792mJZ4jS5eHGMgYSbOTcpPrU0m1aFZm/7LL
         XXVhGAGAbEZhhRDDiYDfcBxguApjnZUW8bPWLQiV1X2LwNq8xQkm0huDyFCDzafLch8i
         zyq9R8lUrwdTej80rG2GxdlgIokg/bqoLgzq7RR/pqAi2J9pjOOfZLbKbGbj1wj58bKU
         /3qpVeL8UIemA12k0lH+Bh+qJzh7Ic/DTEI6j56DGni65iOAeJE/1JaN0f/eJJB78pD8
         it8zAbrxGdfunjzWYMwJNtSHxAYRtATHJiatmX6NLGRXLZXC0FpURrToHTO1Su52C9Bc
         ewqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706401671; x=1707006471;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3G1BZUc/awZCAssluIQWHzMdeWDdPsi0QWKz/a/W1nk=;
        b=mVBC5HikR1lOBgIRr3nmcFo6hCMf126WOTZLmHxDliE61+ecINizpRP+QLElEiSiAy
         DM0F0V9c9VdO71eUgLn6iISeL8lGBCUiTJ1XBBl6KUsgO9XscYpxFMKsdUcwIeW67lAo
         2+UAIenmDh7caXVCGXGsfPhHp1LGeOGKeGyFs+bSKuLjQMOjGZzzijuWsnf+8OueeXMs
         /zwEsWOomhEvSaM0Xqzw1+R5diWdg16AQvhI8x8Twi3jCFnJaCcADW/H2h3PSowdt3hj
         E0hD+RM3FQtYL81xcFoOokUtD/469WOP9lT6HQU3AI3WgH0xOjsHrkwAYyePWIoJRcrP
         n9fQ==
X-Gm-Message-State: AOJu0YyoLLe/03mn/qdsmiWUFyibmzXujAq7mEPFOCy0labUkz8XHWFt
	7rYs5t54y36BxBjLD+jb3rtXI7S07MUhmEB5fLlbPmSfwHvBj9w84/0EgsUW2gPvum/ODbeWrzE
	JL8oU7Y6jMR1uvtsGAbt5f7z+aO/0xMOiUS57IA==
X-Google-Smtp-Source: AGHT+IEjSeC4hi0heaZUTpDAlmgTOe454SwsHBCH276W4pkjTAEo3a9iak0Qm8B8Jxx0QZUWAh/wBBvgSnVka9DoPL0=
X-Received: by 2002:a0d:cc93:0:b0:602:c94d:6b4c with SMTP id
 o141-20020a0dcc93000000b00602c94d6b4cmr1654809ywd.50.1706401671202; Sat, 27
 Jan 2024 16:27:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240121-pinctrl-scmi-v3-0-8d94ba79dca8@nxp.com> <20240121-pinctrl-scmi-v3-4-8d94ba79dca8@nxp.com>
In-Reply-To: <20240121-pinctrl-scmi-v3-4-8d94ba79dca8@nxp.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sun, 28 Jan 2024 01:27:40 +0100
Message-ID: <CACRpkdYOj4gDzVNyfkDEsTfHZcQnV+X6bqQ7Vt1KH2kPa0hPbA@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] pinctrl: Implementation of the generic
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

On Sun, Jan 21, 2024 at 11:18=E2=80=AFAM Peng Fan (OSS) <peng.fan@oss.nxp.c=
om> wrote:

> From: Peng Fan <peng.fan@nxp.com>
>
> scmi-pinctrl driver implements pinctrl driver interface and using
> SCMI protocol to redirect messages from pinctrl subsystem SDK to
> SCMI platform firmware, which does the changes in HW.
>
> Co-developed-by: Oleksii Moisieiev <oleksii_moisieiev@epam.com>
> Signed-off-by: Oleksii Moisieiev <oleksii_moisieiev@epam.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
(I have just sent nitpicks anyway)

Yours,
Linus Walleij

