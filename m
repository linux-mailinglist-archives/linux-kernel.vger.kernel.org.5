Return-Path: <linux-kernel+bounces-134857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5E7C89B7E8
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 08:48:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1E491C21667
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 06:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E921821364;
	Mon,  8 Apr 2024 06:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PB6WFMUB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AFCE2B9B5;
	Mon,  8 Apr 2024 06:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712558928; cv=none; b=e2JXsFshDOwnJ2PYXgD9ng76j3uf8cTCgFLq5MG/G3HqpeYuAnY21npLaT2j1CM6Cgfr4PitmcMX3MusiW7YpLBY5vJhREdxI06UQOSIq+Sp6c/ubEiAZDUYpcklqaxz2BFr9Ugh2EFjbXdgMaXRUpcOk1srAwWgtDnpN81V37k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712558928; c=relaxed/simple;
	bh=fdlmo9nLEZZM0AajDxaXARTs2D2/fr2yANRzgsov9XQ=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=BvLT0SpLt5BDeEwDmXiCVE+mJELSt7LP9CnHR+Qk2rXJ7LniDD3lhf6s6Iwp9Yg0PHtua2okGJZoY5QLEN0kOskGL2JJmon7sIN9P+Wsd2RXYczWwqshWgf/Ykg8uBgfj6AihHpr2QcZdZ8+BhGQatG3RzkgZUjUtaNtOBllt6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PB6WFMUB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9475BC433F1;
	Mon,  8 Apr 2024 06:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712558927;
	bh=fdlmo9nLEZZM0AajDxaXARTs2D2/fr2yANRzgsov9XQ=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=PB6WFMUBsWePt6MPDVGzjykATl5kIcolPq/DLxwqs//oBCb1C/Yk/z9Of2FEs0bUq
	 fZ16EyAYreDRW37w6FaiAvs2FGG/zKeNxkM9ELyV7TGrlAjgYOQhS0tpvW6YAFyvz8
	 IcLsT5SP1jheavN5f5UTTd16JvwjoedFC105oS5BIhBsmy5m1+9jYm2BUcRUYI5zHw
	 4v2XQKaZD04yAuzuIxJZArCpAwgwrEjtH4YIxP2SrAuwLAsDLwvOWtcN1FysAPMDhq
	 +Xe9ooN4viv3dsoHK4nSFO5xV2lrZOsCxpZn1KiW3Vgep887kUpfBcp+GKVmGxpUWh
	 1GGXb/AIOeKcA==
Message-ID: <5b88fb4c1e02303bcbc59b92496735c9.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <87frw2a2e4.fsf@oltmanns.dev>
References: <20240310-pinephone-pll-fixes-v4-0-46fc80c83637@oltmanns.dev> <87frw2a2e4.fsf@oltmanns.dev>
Subject: Re: [PATCH v4 0/5] Pinephone video out fixes (flipping between two frames)
From: Stephen Boyd <sboyd@kernel.org>
Cc: Guido =?utf-8?q?G=C3=BCnther?= <agx@sigxcpu.org>, Purism Kernel Team <kernel@puri.sm>, Ondrej Jirman <megi@xff.cz>, Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, stable@vger.kernel.org, Diego Roversi <diegor@tiscali.it>, Erico Nunes <nunes.erico@gmail.com>
To: Chen-Yu Tsai <wens@csie.org>, Frank Oltmanns <frank@oltmanns.dev>, Jernej Skrabec <jernej.skrabec@gmail.com>, Maxime Ripard <mripard@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Samuel Holland <samuel@sholland.org>
Date: Sun, 07 Apr 2024 23:48:45 -0700
User-Agent: alot/0.10

Quoting Frank Oltmanns (2024-04-03 08:31:47)
> Dear clk and sunxi-ng maintainers,
>=20
> Patches 1-4 have been reviewed and there are no pending issues. If there
> is something else you need me to do to get this applied, please let me
> know.
>=20

I'm assuming sunxi maintainers will pick up the clk patches and send
them to clk tree in a PR.

