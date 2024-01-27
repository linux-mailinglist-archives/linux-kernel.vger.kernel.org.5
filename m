Return-Path: <linux-kernel+bounces-41020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 470DF83E9F6
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 03:43:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 795EC1C22F22
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 02:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18479BA22;
	Sat, 27 Jan 2024 02:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V/XJEUnm"
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0101170A
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 02:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706323411; cv=none; b=hTyDQCiEMsoG2C8TByOBrJMPz6e9OqDARYUL5QEjrllUE1fA31NwL24SwVg0trdMI4RgFB5sItu17HGpiyhW0/jrgkdePcZTBRo/Z0EJHaG3uAd+7U/jc6Zkahqikbep0t4JA7nOQ7dUz/6U6koHPpFFcgevkdzFXCvxiU6/uuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706323411; c=relaxed/simple;
	bh=J83cGtBp27ayZDyo/vtlJCIGI1RJIiUwBxfYHghGR+8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rEip6P6OGi5Y6wep5RFy/rPrwwRlvuGUT5J+VLSS761DlbeosJyckGyCL5Pvz0RZ917ykEw7YotVKNCSgENvi/D9W4FtMWdVCJpha91E7QI2D0dHVy9vMyHn3TWXz+rEkakQF5lY3cHuPC/50pMzPdgbBuSgElv6UL4XvoOk/Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=V/XJEUnm; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-21481a3de56so552401fac.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 18:43:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706323409; x=1706928209; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RyfKTninr//YcXdmOl6ikrOzMr02DwwXqiLooW8dVos=;
        b=V/XJEUnmJ9mWN2PX/j3PLfikIw4+o93DDV6PMaNj3zAWJbYaZmHxHezHm1nZ8oIyRp
         2MUQDtqLAGC9sUPjKwY01f1PX6G/6UPF9l2BMpYlUa9GdMjHb+SIl/gPEpGfX7j3l2B4
         T92LWex/aIvVa6oDi+lSa8QzaiYs39NWkKsQpKnQMK/7YFMTBFL5ifIdmZLB5RhJOX4y
         wuAvn3rlkhIf/u9eS58HeVWJW7aTvsUjRkGgeDKwytZbKjeSpfi/QxhnAUeEUQ6Wfpfp
         g8segA8ghUlMYqy3tWLY5/cwDqFpeMRIcToHq+fR+Dkv14gXFSFBDK2U8wMKjtBzo4Da
         tUxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706323409; x=1706928209;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RyfKTninr//YcXdmOl6ikrOzMr02DwwXqiLooW8dVos=;
        b=tL6tFztEUgupZGbmUkC4qUdfZ5sufOI4D1jhbQc/hOCloLQDlrfC/DBEHQkBWAXxLo
         LkHqmd9NRcI0pL7/sJeph3UGp7qEqpvMQtgp7xqbySqReYlAQIDSjIe0dMrSgWxjj79t
         4/1AGK53+iLgiWfBOvwd6F/cjpFGjIN493BuIK8PJhRTbSbBsPz4IjYsFnjPY5gcrQo2
         UCFTlJsF6qNoYT6W2H0phw5lu/cxm6EIq7WHwIAS6Gx2MvDFy+94Hnui8T3BWb5vHlR+
         J4lpLinK1/PfvVzEDTQs6W4DR7KnvrHMv+Rhnl42ZQyV0JaBjyk4uhFW2M/AmFdQsXZa
         CN3A==
X-Gm-Message-State: AOJu0Yy/sNK403j28xS/O0j/FGD8mfSh8r61BPVgiwtDc3vhcCliBtJk
	EDNLJyqDBiMnplmh4GehSB1N34KuPG94jlu8WwGHHBdEumC64sQ5k684a9H+gnMJR3IzfkvlUhs
	k7B8pvKEE/TNqmL6YXA3EzoPHKpNkwdXc+SYU9A==
X-Google-Smtp-Source: AGHT+IEkKB2QGZKiNjAvXXH6n/PcZozMYAW4AsJBipNdXovvgdJy3/oFIt22t48sGdYch0IDB1RqphlBj23SyagKhCk=
X-Received: by 2002:a05:6358:60c4:b0:176:b156:f69d with SMTP id
 i4-20020a05635860c400b00176b156f69dmr656246rwi.31.1706323408911; Fri, 26 Jan
 2024 18:43:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240127001926.495769-1-andre.draszik@linaro.org>
In-Reply-To: <20240127001926.495769-1-andre.draszik@linaro.org>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Fri, 26 Jan 2024 20:43:17 -0600
Message-ID: <CAPLW+4=3o6kGQcQhzo=1JwPFp+qF7GpuVYuZ_Jvh_7o9d0Mbbw@mail.gmail.com>
Subject: Re: gs101 oriole: peripheral block 1 (peric1) and i2c12 support
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: peter.griffin@linaro.org, mturquette@baylibre.com, sboyd@kernel.org, 
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	linux-kernel@vger.kernel.org, kernel-team@android.com, 
	tudor.ambarus@linaro.org, willmcvicker@google.com, alim.akhtar@samsung.com, 
	s.nawrocki@samsung.com, tomasz.figa@gmail.com, cw00.choi@samsung.com, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 26, 2024 at 6:19=E2=80=AFPM Andr=C3=A9 Draszik <andre.draszik@l=
inaro.org> wrote:
>
> Hi,
>
> This patch series implements support for the 2nd connectivity
> peripheral block on gs101.
> This block contains an additional 6 USI, 1 I3C and 1 PWM
> interfaces/busses.
>
> i2cdetect shows all expected devices on the one i2c bus that this patch
> series enables.
> Everything that's in scope in this series works also without the
> clk_ignore_unused kernel command line argument.
>
> While working on this, I noticed the existing peric0 support for gs101
> has a couple issues. That explains why there are differences compared
> to it and a separate patch series will be sent to fix up peric0
> support.
>
> Cheers,
> Andre'
>

Looks like PATCH [00/xx] is missing in the subject.

>  .../bindings/clock/google,gs101-clock.yaml    |   9 +-
>  .../soc/samsung/samsung,exynos-sysreg.yaml    |   2 +
>  .../boot/dts/exynos/google/gs101-oriole.dts   |   9 +
>  arch/arm64/boot/dts/exynos/google/gs101.dtsi  |  42 ++
>  drivers/clk/samsung/clk-gs101.c               | 347 ++++++++++++++++-
>  include/dt-bindings/clock/google,gs101.h      |  48 +++
>

