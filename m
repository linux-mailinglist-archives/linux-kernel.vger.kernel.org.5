Return-Path: <linux-kernel+bounces-42735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EFBD8405C1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 13:56:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67BE71C21D3B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 12:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6180A64CC9;
	Mon, 29 Jan 2024 12:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lZNpLXw/"
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE3764CCC
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 12:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706532794; cv=none; b=exa8jAMsBKgOlIv63bO7DDGr5e/kOU4Ay5zrYrvSQFgpCg6oj8/UOxbhkjrRNtHcXDMLeNojDuRsQ7qhfRsKqgumPK72i3L6IhBftdGBiqbDnYMbMRjZCwiLj+uj1Bg8+QnV49iGZ11JwvrHABFHT36HqSClSxxLAS6nq0BRkhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706532794; c=relaxed/simple;
	bh=KroOacCdu2ZA86CNRDamGPo4cG4+JEigTyyM8PMovL4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qNg4a6e5PV/dv3JeDS1yiKLNkzVVEs7ZTGZC+qa63zcOiBt7oghWUhWtzNOpOVSKSYzA06dz6oAyEBKdcCT/9JzQfe36cQwl1oWf8WdT4dqc9du9+nuhhL5sJr3jtSH/SOXzyyAkb/sEMsxqY4p5iwc3gq3wJ/xZrHfjxdVqt78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lZNpLXw/; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-68c438fde8eso16317706d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 04:53:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706532792; x=1707137592; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y6yW26oSt7/NM1Cy4RXMzke9upnPad+ksE3lOYBG0Qc=;
        b=lZNpLXw/LwyqnL8SowEvzusml8Ezml7alSpcgIxA6PeU/qZ7uSIiT4IYt8XyHNZAv3
         c+2rGE/pTikIyE/x9f2bygzproSWzPPc9DAESJsH9Mv4ja3jMfpn4vX5ZLSkO2zJMBYo
         aGEgNT6cjXfHfpydeDD1Y4c1ohJRFDsE5QzNQu99JQfKurakDR9Jwki1AH4FRvFM92NU
         5xbnHLtGeF58xopMGB2tm9y8kIJtQwR2wi5POdmYp4iGJcbpfNj0LB/njb8mdaXoFdbB
         rl5d7n1eTh7REfQbXCr2cnpew75kp/VU1ZFuGyDnf0jWDR4fwqkqy2SREIICS3VUXaSg
         FazA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706532792; x=1707137592;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y6yW26oSt7/NM1Cy4RXMzke9upnPad+ksE3lOYBG0Qc=;
        b=W7QsvPKKAyFzl6IPFBj2BmeMQry6k/Va4KUiH2u7hPKRKnImw7qZ1j+SMKJ/zuvEL7
         DrDaoLfTPuRmCSgzBF40Flks6olNnM6eAYN8oh1Yv0gUT+tiOy4MiA1nkLdbXxEaybkx
         l5Nqi3f+FXIGrc4rHSceF5ku1vv/EiKM/DzhSgUyqaWAjNqRdF+lO2/c0CnO9bXpKpoq
         n2aOnvL3yusIP8FP9CAAUy95uwEvjfLS36FRB8pvKmU1rKAt0f5UdT7u1Xs/CKx6hydf
         XIuw7ZCG51Qj1pOpDmiianIpLG7UzktLO5hTxFCyUwyLOtWJ9OJuoMgE7mLjg8t+ZXWp
         H31A==
X-Gm-Message-State: AOJu0Yw7OOS6Hv+tXueZTKSwmoBeyFVuwK9FDJ1dD8ieCZ3E/zdXdR6h
	23hS4h5cyE6ISUx9jbx+mXiFHdSufZTbtsOtZcwJUX4j+7L9PedsX4cbSXiXstMwTOls44lD1Ee
	4AHjJEUPN9SpUr0ErIfZXXKVCoKg5miLId0cmDw==
X-Google-Smtp-Source: AGHT+IHaTbedJRWq3pLve5Uwkk1A3p87XLbvR2SU1L7KPzQbeRRz4TTsTCOmsE1SzDacGL8OW16099YRwNP2A8GD5NY=
X-Received: by 2002:ad4:5aa8:0:b0:682:d676:e971 with SMTP id
 u8-20020ad45aa8000000b00682d676e971mr6470001qvg.110.1706532791889; Mon, 29
 Jan 2024 04:53:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240127001926.495769-1-andre.draszik@linaro.org> <20240127001926.495769-4-andre.draszik@linaro.org>
In-Reply-To: <20240127001926.495769-4-andre.draszik@linaro.org>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Mon, 29 Jan 2024 12:53:00 +0000
Message-ID: <CADrjBPqbVei7jMwjJxiXk=b-OwDHpxduM0zJdXSM0Dg8kvKXUA@mail.gmail.com>
Subject: Re: [PATCH 3/9] clk: samsung: gs101: add support for cmu_peric1
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	linux-kernel@vger.kernel.org, kernel-team@android.com, 
	tudor.ambarus@linaro.org, willmcvicker@google.com, semen.protsenko@linaro.org, 
	alim.akhtar@samsung.com, s.nawrocki@samsung.com, tomasz.figa@gmail.com, 
	cw00.choi@samsung.com, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 27 Jan 2024 at 00:19, Andr=C3=A9 Draszik <andre.draszik@linaro.org>=
 wrote:
>
> CMU_PERIC1 is the clock management unit used for the peric1 block which
> is used for additional USI, I3C and PWM interfaces/busses. Add support
> for muxes, dividers and gates of cmu_peric1, except for
> CLK_GOUT_PERIC1_IP which isn't well described in the datasheet and
> which downstream also ignores (similar to cmu_peric0).
>
> Two clocks have been marked as CLK_IS_CRITICAL for the following
> reason:
>     * disabling them makes it impossible to access any peric1
>       registers, (including those two registers).
>     * disabling gout_peric1_lhm_axi_p_peric1_i_clk sometimes has the
>       additional effect of making the whole system unresponsive.
>
> The clocks marked as CLK_IGNORE_UNUSED need to be kept on until we have
> updated the respective drivers for the following reasons:
>     * gout_peric1_gpio_peric1_pclk is required by the pinctrl
>       configuration. With this clock disabled, reconfiguring the pins
>       (for USI/I2C, USI/UART) will hang during register access.
>       Since pingctrl-samsung doesn't support a clock at the moment, we
>       just keep the kernel from disabling it at boot, until we have an
>       update for samsung-pinctrl, at which point we'll drop the flag.
>     * gout_peric1_sysreg_peric1_pclk needs to be hooked up to
>       sysreg_peric1 in DT which will be done in a followup-patch, at
>       which point we'll drop the special treatment from here. We're
>       adding the flag temporarily here so as to not break the boot (due
>       to pclk otherwise getting disabled).
>
> Signed-off-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>
>
> ---

Thankyou for being verbose on this reasoning behind CLK_IGNORE_UNUSED
and CLK_IS_CRITICAL flags

Reviewed-by: Peter Griffin <peter.griffin@linaro.org>

