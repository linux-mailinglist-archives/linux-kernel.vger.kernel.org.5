Return-Path: <linux-kernel+bounces-139684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72FB08A0678
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 05:06:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 292571F22204
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 03:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D58913B787;
	Thu, 11 Apr 2024 03:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L/eZxjtf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA341F5FA;
	Thu, 11 Apr 2024 03:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712804797; cv=none; b=lvwAOXhStOgPP2Mid1rPuXFguYrPGapBED/a2CpLBpeqB6zrQtUCzy8ayT2k1QJFp4NDdCvu7nVU8f8w3n1vR3FvBJvf6X7UxFIuhIyWaJ5GqC0zuMWPkdHc1kDcmwnUNtfpKg0PjNDikjOlthHCPo/gI+MI35J+JV6c21ENnt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712804797; c=relaxed/simple;
	bh=tdJ0lgF+UwsqfOZfw3fpBD95sXmyAoj2othwTClSfJE=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=u1m63Adcz1fRbuWzGRpTYmgWKkboMVQdqR0AI0PpmNifJKo7TD4CGqMixr6mN926d9xtLGOx60vCa2SXiQT6x+XIN2EVqZCBxPgW9Cmu78pvgSskCC+wKbZgylqufePcO7xFAE3Olwk+SBZ62qSDbCiklyFyHHV0P6gxudu4HdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L/eZxjtf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D10B5C433C7;
	Thu, 11 Apr 2024 03:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712804797;
	bh=tdJ0lgF+UwsqfOZfw3fpBD95sXmyAoj2othwTClSfJE=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=L/eZxjtfp55i5cWvAWE5b6ObdnG+fiTqKBQ4sVFR4SMAruzZ/dVCFou+5hvn+fYEv
	 7tBLQ5GlKEOKb0NdUGRqaP1mWZLhSaq8D/DgDA6rNQnHKCdHgZo4gkOizsOq4hVPUR
	 uWmnFXbUuqCnuScJ/OBuSR7Y8INxeIJHrTSiz85C+jTPNQTCL2xju6dClMupdmEp6i
	 Pp9oLsCdF0YqC27sUINL8FUUiMuYx1XhI2MoKBP0auAWXXa3lBlHS2PAczDCfR/RlH
	 FVktnQaSK7TtAx6sFNZUWsfWIVytlMfUKtE0IitP6FiG0bDHT90q2bmy+ODECEjyqk
	 WChS70Bal3K+A==
Message-ID: <4ce9f3cea1ecd3777cf3e291cc865210.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240410-mbly-olb-v1-4-335e496d7be3@bootlin.com>
References: <20240410-mbly-olb-v1-0-335e496d7be3@bootlin.com> <20240410-mbly-olb-v1-4-335e496d7be3@bootlin.com>
Subject: Re: [PATCH 04/11] clk: divider: Introduce CLK_DIVIDER_EVEN_INTEGERS flag
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-mips@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org, Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, Gregory CLEMENT <gregory.clement@bootlin.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Tawfik Bayouk <tawfik.bayouk@mobileye.com>, =?utf-8?q?Th=C3=A9o?= Lebrun <theo.lebrun@bootlin.com>
To: Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh@kernel.org>, =?utf-8?q?Th=C3=A9o?= Lebrun <theo.lebrun@bootlin.com>
Date: Wed, 10 Apr 2024 20:06:34 -0700
User-Agent: alot/0.10

Quoting Th=C3=A9o Lebrun (2024-04-10 10:12:33)
> index 4a537260f655..cb348e502e41 100644
> --- a/include/linux/clk-provider.h
> +++ b/include/linux/clk-provider.h
> @@ -675,13 +675,15 @@ struct clk_div_table {
>   * CLK_DIVIDER_BIG_ENDIAN - By default little endian register accesses a=
re used
>   *     for the divider register.  Setting this flag makes the register a=
ccesses
>   *     big endian.
> + * CLK_DIVIDER_EVEN_INTEGERS - clock divisor is 2, 4, 6, 8, 10, etc.
> + *     Formula is 2 * (value read from hardware + 1).
>   */
>  struct clk_divider {
>         struct clk_hw   hw;
>         void __iomem    *reg;
>         u8              shift;
>         u8              width;
> -       u8              flags;
> +       u16             flags;

This can stay u8

>         const struct clk_div_table      *table;
>         spinlock_t      *lock;
>  };

We should add a kunit test.

