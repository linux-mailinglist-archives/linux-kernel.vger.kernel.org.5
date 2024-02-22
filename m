Return-Path: <linux-kernel+bounces-75919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D3D085F0A2
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 06:02:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D02FFB23813
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 05:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 855DF566A;
	Thu, 22 Feb 2024 05:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EtQRxNMT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14D210E6;
	Thu, 22 Feb 2024 05:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708578155; cv=none; b=q9TnAQyTXwENvfmkKeE2RhG4l2jjWwmi38R9eMCaQlZOdAbqyogkrwwpU2SnXK3N+Uf6BvPsHdNdHQEZ+Dg/URdq7kM42QqJERdQm0A0UbpwghmKUQvs9mtfD9Xqw8+nIHrkHXfIGTdZAFJzl/hfXQM2flD/CMoY6x6VGdrAB4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708578155; c=relaxed/simple;
	bh=V/H8ZH5cCurKQ8BQRm5x3d74U9mlF3EMQATdNzjS3U0=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=MxN8C/UugANKM3lWQPwjpZaOb+l48QPhE8GCADfkA81O/qrgAzvAJrTiQ3Ze9OHdobWydVVNxUV6nAJTsuXLBV+0eqMmWZVmJ5EUH2syv8qAN6/tTGj8tWQaXjsxXhaC274vgNTx96z50HFpEXBpXeZPrcGWcvla6U4vfl+eDVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EtQRxNMT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F9F1C433C7;
	Thu, 22 Feb 2024 05:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708578155;
	bh=V/H8ZH5cCurKQ8BQRm5x3d74U9mlF3EMQATdNzjS3U0=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=EtQRxNMTek721ifTOvr80UuXi/VVvCszQwwcPClFgnqTkUn2ZyvqNzu6xTbhyhoAP
	 ZCjAxhxqTaeNrGH0dKcuQPzhdhV6JLAUbiPUlij0l6lqu38AdIWGqSQ2pn9DscqTa4
	 nPxHrUcfdnelyxZxmmpS5bH1Hl50GaJyFqsgT9FHrMaNHQWmcaigMclnVucGjIHcZh
	 ucYG08V0p4U3n7kbzhmr1+Ygr3QKbYBiSkauVqIweqWMu/GFxKyNNEDXsg/KaGeloR
	 sG9PbyN8wHjl3ADNsUMiTHDRbKcpaNVvIzwinp+8FWVVd86Tm0A9ssjWoRbAlswC85
	 AOvfpmEQB8iPQ==
Message-ID: <d788965caa6347c989c1cc6f9d20d48e.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240201182409.39878-3-linux@fw-web.de>
References: <20240201182409.39878-1-linux@fw-web.de> <20240201182409.39878-3-linux@fw-web.de>
Subject: Re: [PATCH v4 2/2] clk: mediatek: add infracfg reset controller for mt7988
From: Stephen Boyd <sboyd@kernel.org>
Cc: Frank Wunderlich <frank-w@public-files.de>, Sam Shih <sam.shih@mediatek.com>, Daniel Golle <daniel@makrotopia.org>, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Conor Dooley <conor+dt@kernel.org>, Frank Wunderlich <linux@fw-web.de>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>, Michael Turquette <mturquette@baylibre.com>, Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh+dt@kernel.org>
Date: Wed, 21 Feb 2024 21:02:32 -0800
User-Agent: alot/0.10

Quoting Frank Wunderlich (2024-02-01 10:24:09)
> From: Frank Wunderlich <frank-w@public-files.de>
>=20
> Infracfg can also operate as reset controller, add support for it.
>=20
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> ---

Applied to clk-next

