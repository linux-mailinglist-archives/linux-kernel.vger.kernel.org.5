Return-Path: <linux-kernel+bounces-135182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB59C89BC5A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 11:52:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 198811C219F8
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 09:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C2934D9F4;
	Mon,  8 Apr 2024 09:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nikrOt6l"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789994C600;
	Mon,  8 Apr 2024 09:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712569959; cv=none; b=f6bfMhXQeNQOlyxH7vq4LJ9v0ARssyTGXd8yH9xoJCPyw/QPLCXjmYzWsdnNtdTSPrjqu+79dlWfyTX+aH/drIS//7jlZ71PiAS3YwiL4JqW7VvFkcRP2rP/tFWJiuQ8fh0dSjRQ24eSL2VqVyGVONTEkwbtaDqyRLQ6og3orXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712569959; c=relaxed/simple;
	bh=GuJ9Gj+u419IyvxtgxIuYGQxug7EYXq4Dcg2jFi9tQo=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=ZwXem10hqLDvtn3Mm/dF9NO+ol+erWNpheQisbUiGJUG9xz/X+TznddLT6uTy37de2Sw1x3zAUznDIuLfuq+LvqmzGwx0R+QYN9fer1a8c7TXrJeBEDxKv9e0Q/PEhOeVT01bY1AxOeExZvcrXnGcBbQ28fiSOpmdO/565pBCRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nikrOt6l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33413C43399;
	Mon,  8 Apr 2024 09:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712569959;
	bh=GuJ9Gj+u419IyvxtgxIuYGQxug7EYXq4Dcg2jFi9tQo=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=nikrOt6lchAeiXTOY7KStWdF/H5VAt7Vkss+si1WV89KtJr71O/CYJckUdGrB/yHT
	 v7NPaqT2H1iLrrY3CHB3mEyEEPIisGJUA2/EkfBi1aJEw1pJmr1CUiQLeywbW4wBpQ
	 OGnS+ucMK6o2npixP5tOKTPZr0Jp5BkLXPfXbdBnONsgKDuttG2E2EHFmx8Gxlc6Tv
	 0nwCHWc2JvBIAMikAVuv4a2lCTcKuxo+BIwjOyVHVA3oqkQi+U7rqyUnoalbTc1twm
	 o7k8onZI5TJ+U553u1P9oboP8b0hv9I0Q0Huzj3u0t6DhJ9cJmauMuLNGIIaryXNPS
	 El7J/j/5xgDAg==
Message-ID: <13617b7a892424d2b024c725505a6f4f.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <f01cdd910ab35316b8012795f73fd2b34c8e6f8e.camel@pengutronix.de>
References: <20240328010831.884487-1-jan.dakinevich@salutedevices.com> <20240328010831.884487-2-jan.dakinevich@salutedevices.com> <1j7chfiz8e.fsf@starbuckisacylon.baylibre.com> <e3a85852b911fdf16dd9ae158f42b3ef.sboyd@kernel.org> <f01cdd910ab35316b8012795f73fd2b34c8e6f8e.camel@pengutronix.de>
Subject: Re: [RFC PATCH v2 1/5] clk: meson: axg: move reset controller's code to separate module
From: Stephen Boyd <sboyd@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>, Martin Blumenstingl <martin.blumenstingl@googlemail.com>, linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
To: Jan Dakinevich <jan.dakinevich@salutedevices.com>, Jerome Brunet <jbrunet@baylibre.com>, Philipp Zabel <p.zabel@pengutronix.de>
Date: Mon, 08 Apr 2024 02:52:37 -0700
User-Agent: alot/0.10

Quoting Philipp Zabel (2024-04-08 01:21:47)
> On So, 2024-04-07 at 19:39 -0700, Stephen Boyd wrote:
> > Quoting Jerome Brunet (2024-04-02 07:52:38)
> > >=20
> > > On Thu 28 Mar 2024 at 04:08, Jan Dakinevich <jan.dakinevich@salutedev=
ices.com> wrote:
> > >=20
> > > > This code will by reused by A1 SoC.
> > >=20
> > > Could expand a bit please ?
> > >=20
> > > >=20
> > > > Signed-off-by: Jan Dakinevich <jan.dakinevich@salutedevices.com>
> > >=20
> > > In general, I like the idea.
> > >=20
> > > We do have a couple a reset registers lost in middle of clocks and th=
is
> > > change makes it possible to re-use the code instead duplicating it.
> > >=20
> > > The exported function would be used by audio clock controllers, but t=
he
> > > module created would be purely about reset.
> > >=20
> > > One may wonder how it ended up in the clock tree, especially since the
> > > kernel as a reset tree too.
> > >=20
> > > I'm not sure if this should move to the reset framework or if it would
> > > be an unnecessary churn. Stephen, Philipp, do you have an opinion on
> > > this ?
> > >=20
> >=20
> > I'd prefer it be made into an auxiliary device and the driver put in
> > drivers/reset/ so we can keep reset code in the reset directory.
>=20
> Seconded, the clk-mpfs/reset-mpfs and clk-starfive-jh7110-sys/reset-
> starfive-jh7110 drivers are examples of this.
>=20
> > The auxiliary device creation function can also be in the
> > drivers/reset/ directory so that the clk driver calls some function
> > to create and register the device.
>=20
> I'm undecided about this, do you think mpfs_reset_controller_register()
> and jh7110_reset_controller_register() should rather live with the
> reset aux drivers in drivers/reset/ ?

Yes, and also mpfs_reset_read() and friends. We should pass the base
iomem pointer and parent device to mpfs_reset_adev_alloc() instead and
then move all that code into drivers/reset with some header file
exported function to call. That way the clk driver hands over the data
without having to implement half the implementation.

