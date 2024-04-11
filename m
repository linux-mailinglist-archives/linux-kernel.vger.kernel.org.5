Return-Path: <linux-kernel+bounces-140002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D976E8A0A28
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 09:41:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16C451C20E7F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 07:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB2B1411E0;
	Thu, 11 Apr 2024 07:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jhEtD+8g"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E248A13E04A;
	Thu, 11 Apr 2024 07:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712821212; cv=none; b=RCPtJX3/PQwGkERG2/kQ2sOyWyL0qr6G9qjwW/kEnqDXgikHPfVA2yMl4L8M/BzYEl8Z+Y4VVZEFcQU76PQONZ89Lm8fUkQ7+l9dlO5YDLtbDi2jpQg7V9QV9dbFl0OV8PUqXJOZ+lZluqcXqYQxpspoLZnRISQHjW1E+eMLm3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712821212; c=relaxed/simple;
	bh=LA+wn9kfgecU++lwedY9kqi1RgDT6C7KkTtw8hPYVz8=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=tHyyKfDf15yYx0ewa08cBKO8EpqqbHYySiIQMORwwpJxY5y6k7m5fzVLCvVIOO22iKa/6UxePMnJpZVZgfNvEFzcwL6lZnROS61kAeuXMd+iiTHUX5NQe6Mq1hd3qCxs3Wjd6QMHFH9kguvsW/DrOrsNiG3uLKw9sksiV4s0EDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jhEtD+8g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 597AAC433C7;
	Thu, 11 Apr 2024 07:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712821211;
	bh=LA+wn9kfgecU++lwedY9kqi1RgDT6C7KkTtw8hPYVz8=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=jhEtD+8gQsJCMDWmXcnrfLyAeM0K0uK7O8o1zvkj3msA7C1JgMCODIWZjTFB5esOI
	 3U9Y8LMrIZLETrO9tXP6GSmI+5qKB3YW6aEpQrWAiIWg9lEw6e2GSNAvmCx1wYMLpZ
	 SUrt1IvS703nMUllbwR4ItAp/3t1jEjdymKbQgAWZJpbaEMVwjOsEoPND8Cw8Tdg0b
	 uubiieQVjmUiVzX3JPe/92++s8VMG3/nyf9lTjzDhwFw8TiJpA3eRBMeQLCiogohUX
	 OaePVeeYoESA0VXSlkOm3OBnTlaHvK2stUG31Y9lGEaWxugWeUycE2v8nEcfuHF0vG
	 V3LMZ7Obiv4Zw==
Message-ID: <a83130157adf70f6f58f4d2e6b9d25db.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240110133128.286657-1-jeeheng.sia@starfivetech.com>
References: <20240110133128.286657-1-jeeheng.sia@starfivetech.com>
Subject: Re: [RFC v3 00/16] Basic clock and reset support for StarFive JH8100 RISC-V SoC
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, jeeheng.sia@starfivetech.com, leyfoon.tan@starfivetech.com
To: Sia Jee Heng <jeeheng.sia@starfivetech.com>, aou@eecs.berkeley.edu, conor@kernel.org, emil.renner.berthing@canonical.com, hal.feng@starfivetech.com, kernel@esmil.dk, krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com, p.zabel@pengutronix.de, palmer@dabbelt.com, paul.walmsley@sifive.com, robh+dt@kernel.org, xingyu.wu@starfivetech.com
Date: Thu, 11 Apr 2024 00:40:09 -0700
User-Agent: alot/0.10

Quoting Sia Jee Heng (2024-01-10 05:31:12)
> This patch series enabled basic clock & reset support for StarFive
> JH8100 SoC.
>=20
> This patch series depends on the Initial device tree support for
> StarFive JH8100 SoC patch series which can be found at [1].
>=20
> As it is recommended to refrain from merging fundamental patches like
> Device Tree, Clock & Reset, and PINCTRL tested on FPGA/Emulator, into the
> RISC-V Mainline, this patch series has been renamed to "RFC" patches. Yet,
> thanks to the reviewers who have reviewed the patches at [2]. The changes
> are captured below.

I don't think that's what should be happening. Instead, clk patches
should be sent to clk maintainers, reset patches to reset maintainers,
pinctrl patches to pinctrl maintainers, etc. The DTS can be sent later
when it's no longer an FPGA/Emulator? Right now I'm ignoring this series
because it's tagged as an RFC.

