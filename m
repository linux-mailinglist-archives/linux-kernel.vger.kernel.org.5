Return-Path: <linux-kernel+bounces-141838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBCD38A241F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 05:01:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A12581F22D7D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 03:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 721A11757A;
	Fri, 12 Apr 2024 03:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BNRDc/hD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC22518E1C;
	Fri, 12 Apr 2024 03:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712890836; cv=none; b=GPKEfXkhgV+3nPbV795gghOTrdma2dHhWvJ7SzsVdjeWJoDmB9foKQFun+vPjU5kQoxCOheV2kIsLVUPk+tHsMysjkHCrSL9+Hvg8gkT8glCLYzQWolRTrvGaXbXApR1+OfZqzyaDBFXIXj/lj+oQ+BrTjmMeg5NvsqbT2hqeIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712890836; c=relaxed/simple;
	bh=otq3wISb2ZRkd93ltkPOvNmjY7y7cS7tl665m79FoKY=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=n++bb+tuU/sshxKz3KsxszfI2Z5tIyDEXqxbDojyiYZpic8S9926V66aaQU50hLolC7DMIcqBY5YBKA+gah4beUyYaEStciYXAHfjOuS90ys+NnQLvJvLi2W61VVWusdwjMrARzqfu4H+sUPo4fr048oyqRDHTTP0TJRd+jsZ8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BNRDc/hD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10286C072AA;
	Fri, 12 Apr 2024 03:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712890836;
	bh=otq3wISb2ZRkd93ltkPOvNmjY7y7cS7tl665m79FoKY=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=BNRDc/hDZ3wcHawmkCwPuhGf+6T/StT1d6HS+sFlNc6VXru/JhG/ZTBMd/me86ZD1
	 4QcW+CCC/rpeIe85+4Nz1hMZoCyLQep+T+p2hdHG8E+WSGyjMNC3Fo7295pyumzuIQ
	 DzAcw6WPGtgnOPE264Jq5KlL0DC3ORdBaCVtFQPZudNUnrUha/UHLnm00UeCxqyerG
	 LlPiUIdqOTr8na9IxeTUSbWaK9BBnPsOJhCbBqFZ0Ikq0UQpd7Q+ah17+Y0ZU8XbaP
	 mhoKgCfUDB1V4NJFwOE5TleaUJ5Sm4kee4cr6UJB2zpJuiyWNsR4XfYVQ7pxi6usLP
	 F5yRansdJMVmQ==
Message-ID: <17e03db98ea960c58b1c012ee04bcbf6.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240411-euphemism-ended-706f23d4a5ca@wendy>
References: <20240110133128.286657-1-jeeheng.sia@starfivetech.com> <a83130157adf70f6f58f4d2e6b9d25db.sboyd@kernel.org> <20240411-euphemism-ended-706f23d4a5ca@wendy>
Subject: Re: [RFC v3 00/16] Basic clock and reset support for StarFive JH8100 RISC-V SoC
From: Stephen Boyd <sboyd@kernel.org>
Cc: Sia Jee Heng <jeeheng.sia@starfivetech.com>, aou@eecs.berkeley.edu, conor@kernel.org, emil.renner.berthing@canonical.com, hal.feng@starfivetech.com, kernel@esmil.dk, krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com, p.zabel@pengutronix.de, palmer@dabbelt.com, paul.walmsley@sifive.com, robh+dt@kernel.org, xingyu.wu@starfivetech.com, linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, leyfoon.tan@starfivetech.com
To: Conor Dooley <conor.dooley@microchip.com>
Date: Thu, 11 Apr 2024 20:00:33 -0700
User-Agent: alot/0.10

Quoting Conor Dooley (2024-04-11 03:29:51)
> On Thu, Apr 11, 2024 at 12:40:09AM -0700, Stephen Boyd wrote:
> > Quoting Sia Jee Heng (2024-01-10 05:31:12)
> > > This patch series enabled basic clock & reset support for StarFive
> > > JH8100 SoC.
> > >=20
> > > This patch series depends on the Initial device tree support for
> > > StarFive JH8100 SoC patch series which can be found at [1].
> > >=20
> > > As it is recommended to refrain from merging fundamental patches like
> > > Device Tree, Clock & Reset, and PINCTRL tested on FPGA/Emulator, into=
 the
> > > RISC-V Mainline, this patch series has been renamed to "RFC" patches.=
 Yet,
> > > thanks to the reviewers who have reviewed the patches at [2]. The cha=
nges
> > > are captured below.
> >=20
> > I don't think that's what should be happening. Instead, clk patches
> > should be sent to clk maintainers, reset patches to reset maintainers,
> > pinctrl patches to pinctrl maintainers, etc. The DTS can be sent later
> > when it's no longer an FPGA/Emulator? Right now I'm ignoring this series
> > because it's tagged as an RFC.
>=20
> Since this comes back to something I said, what I didn't want to happen
> was a bunch of pinctrl/clock/reset dt-binding headers that getting merged
> (and therefore exported to other projects) and then have those change
> later on when the chip was taped out.

Ah ok.

> I don't really care if the drivers
> themselves get merged. If the JH8100 is being taped out soon (or already
> has been internally) and there's unlikely to be any changes, there's not
> really a reason to block the binding headers any more.
>=20

The binding headers are sometimes required for the drivers, so the
driver can't be merged then.

