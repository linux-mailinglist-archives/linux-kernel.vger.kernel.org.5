Return-Path: <linux-kernel+bounces-134860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D50D489B7F6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 08:50:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7564C1F2167A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 06:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 907881CAA4;
	Mon,  8 Apr 2024 06:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QMZZlJQP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4D318026;
	Mon,  8 Apr 2024 06:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712559003; cv=none; b=kcRpT7nX+AxkqiUbIu/igiBuVcpfBpQe9cWXOf7mzOHj0fU5GgKpmBCl4OXpF64iQNwTbPkG0KNuW8bS7DdhslQnFSZy/yFVaNPRu6J/KZp6+04kpkUFrjjdBOSoeDM2sAxgI3TekU5Nm5vQ74vjpTvOBZ3X+0S5vDchYQ619oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712559003; c=relaxed/simple;
	bh=+5HCfq5uK8y7rOB5VKTxwaht8j5UlBg/L7xDpwpFvFU=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:To:Date; b=qBkbmNkOWK2ekLxL83WXFZIe30XgqP7snnKUblkjX5omkZtc5f/md3VBcxcnOZ2VtA49MZeKoiG9NOPeX5MD2zwQQa4Ve1UUK046NxhgacWrDzTZrlPGCyKlR/sqpyUNvGD7TobzXjqaamK7M3kBJdmQSQIUrvLJ5HqRarzhq1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QMZZlJQP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54743C433F1;
	Mon,  8 Apr 2024 06:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712559003;
	bh=+5HCfq5uK8y7rOB5VKTxwaht8j5UlBg/L7xDpwpFvFU=;
	h=In-Reply-To:References:Subject:From:To:Date:From;
	b=QMZZlJQPcbxI6rLSJoLYM7+1EiE4Yc56PsWcKu10aGZRrJ20HZBv0Ut7uW2oGwrNz
	 01kIAyLirLsfv84XHi55FpSU5LiG0At+KOsSPol/yaqA9jdO1/9CixUGR/nMXomixi
	 VVTSLGAa436AHH/wWClW1kL7Quh3AASTcSLH/vs7/yCicGSqLtqto/P3zzwHtJkTbo
	 7IY99e7qFRcBAD0jWjN+uUbGfJUtPGi3KXFYXKEc5vy01D64Z5bHtU2wNgXgMqaqig
	 OrNDdWgFtS/P1XOzoFPvULIIYr+5zLVYHQ8eBJUxQopuCerLBIo/8pMUeYOt1HX9td
	 +WxQdG8lGP2NQ==
Message-ID: <6e2934870cc523f26953a856dc454441.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <f0383126-99c4-4233-b222-597caacf43b9@collabora.com>
References: <1da2506a51f970706bf4ec9509dd04e0471065e5.1710367453.git.daniel@makrotopia.org> <f0383126-99c4-4233-b222-597caacf43b9@collabora.com>
Subject: Re: [PATCH] clk: mediatek: mt7988-infracfg: fix clocks for 2nd PCIe port
From: Stephen Boyd <sboyd@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Daniel Golle <daniel@makrotopia.org>, Frank Wunderlich <frank-w@public-files.de>, Matthias Brugger <matthias.bgg@gmail.com>, Michael Turquette <mturquette@baylibre.com>, Sam Shih <sam.shih@mediatek.com>, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Date: Sun, 07 Apr 2024 23:50:01 -0700
User-Agent: alot/0.10

Quoting AngeloGioacchino Del Regno (2024-03-14 02:44:59)
> Il 13/03/24 23:05, Daniel Golle ha scritto:
> > Due to what seems to be an undocumented oddity in MediaTek's MT7988
> > SoC design the CLK_INFRA_PCIE_PERI_26M_CK_P2 clock requires
> > CLK_INFRA_PCIE_PERI_26M_CK_P3 to be enabled.
> >=20
> > This currently leads to PCIe port 2 not working in Linux.
> >=20
> > Reflect the apparent relationship in the clk driver to make sure PCIe
> > port 2 of the MT7988 SoC works.
> >=20
> > Fixes: 4b4719437d85f ("clk: mediatek: add drivers for MT7988 SoC")
> > Suggested-by: Sam Shih <sam.shih@mediatek.com>
> > Signed-off-by: Daniel Golle <daniel@makrotopia.org>
>=20
> That's funny. Anyway:
>=20
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>

Are you picking up mediatek clk patches and fixes this cycle?

