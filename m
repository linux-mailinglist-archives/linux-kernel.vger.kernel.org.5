Return-Path: <linux-kernel+bounces-139730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B28D8A06EF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 05:51:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D415B230CD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 03:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 322D613BAF5;
	Thu, 11 Apr 2024 03:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pi2yBecI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75BAF60DE9;
	Thu, 11 Apr 2024 03:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712807495; cv=none; b=InzKAi/9iTx8+yaNmJXHvgWGMAaX2Zfj7RMlz/U8JdZn3OPDX7x0WOWhAh/BspdMf1omN/cH9V/cSDrb8uuox9h7RGL5dW1vx9fKOP0N4mOfHL9DeLBpV0CC1H+d6tEnt4+8qt6jSki9RbiVmNT98LxO+bIzH0b3dC95Bx/6wcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712807495; c=relaxed/simple;
	bh=QzOkavWBdzojcTXfBnZjWgEzp813BhmfxvjhEGotijg=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:To:Date; b=cBfWTp9LY6nwX4kxfts3m4LRpiQ30W93VXzhXU5UEi8ke7/X81zouvMw+uuepacfD+qeioBkH/7W1/1FdfRrxt8TEXCRM0PWjlxGfkaYxyyxz9haQ1cyhUbN8+Ml6Ljt6EZSY1EnUxKSFy/7k+1iaQCbHtgcWZP7Zqtcm/f4BJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pi2yBecI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 467C3C433C7;
	Thu, 11 Apr 2024 03:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712807495;
	bh=QzOkavWBdzojcTXfBnZjWgEzp813BhmfxvjhEGotijg=;
	h=In-Reply-To:References:Subject:From:To:Date:From;
	b=pi2yBecI8C4BqcYbx1BNEu5dvdBLrZH6KG97GjlRif1s6wcGuUt3d7tV4ad5lZh+E
	 LaQTShoA2o7O25i4goWwKgZGDTnO+Ood0N8tAYiXF++z3EWTOS6wTyCU4SELlrFP+n
	 MPM1fi5fDQ/aWYVQp/HEFZ5gCZEkN1N/3JbhfOZbyrJnavVfO17QtWmXDExgWC390v
	 hq2cfIRzJ4sPYPD3d2eSv0qG/XW8ZDHHd68rnxSYuzrG9qrpT5yYawU7GxgYpUXjd7
	 6cyEO9HDaWQVzrpd7WwZObiIN8DzsxhHJTqNHyoQMLjq0zGqwt/ZKLBPJ/RHNrFjmZ
	 TXAf9mvwF9iJg==
Message-ID: <72a9ba5cf9384acc89c59123d3c1ea18.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <279294c6bfb8af858c2d522dbe3b76b2.sboyd@kernel.org>
References: <1da2506a51f970706bf4ec9509dd04e0471065e5.1710367453.git.daniel@makrotopia.org> <279294c6bfb8af858c2d522dbe3b76b2.sboyd@kernel.org>
Subject: Re: [PATCH] clk: mediatek: mt7988-infracfg: fix clocks for 2nd PCIe port
From: Stephen Boyd <sboyd@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Daniel Golle <daniel@makrotopia.org>, Frank Wunderlich <frank-w@public-files.de>, Matthias Brugger <matthias.bgg@gmail.com>, Michael Turquette <mturquette@baylibre.com>, Sam Shih <sam.shih@mediatek.com>, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Date: Wed, 10 Apr 2024 20:51:33 -0700
User-Agent: alot/0.10

Quoting Stephen Boyd (2024-04-10 20:47:55)
> Quoting Daniel Golle (2024-03-13 15:05:37)
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
> > ---
>=20
> Applied to clk-next
>=20

Actually I'll send this in fixes because it sounds bad.

