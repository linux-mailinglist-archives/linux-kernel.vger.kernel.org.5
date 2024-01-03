Return-Path: <linux-kernel+bounces-15013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 679A4822621
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 01:53:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72EFAB226BD
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 00:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 906D74A28;
	Wed,  3 Jan 2024 00:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XrOXl094"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF44423D3;
	Wed,  3 Jan 2024 00:52:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E29BC43215;
	Wed,  3 Jan 2024 00:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704243140;
	bh=V7ZMMxY08OYA5uN5t/1uTGmU08BXdfN8CaBDPQSuYio=;
	h=In-Reply-To:References:Subject:From:To:Date:From;
	b=XrOXl094GCIcDcleUHAWtg6GAUXIxc2+jQCYde7C7jffU4zUZVHUUUwXswEmhQhSB
	 OHG7+IfFG9/zMiJeeA6dwAVoaQmWH2JCpLYfd/LZbOmFGuLazSgFwpuNuykCYLq2z1
	 sy31VRJaXjMEc06Uqqy9CQwnLFTxYJDD+aMt5v3ZPbpO2ZEJV9RGvtN5FlWo4tySGN
	 lgEnTuEr8fSAM4qsF9trP7+opLrv1Jom2AmoAQAguQiGAC7FxqkXBHBZABcF3NJpwg
	 3HQbRkGA6Sq2HplukfFVUg/lbvt1MXzsYsgAphHgpSr+xcCK6kHxHdGuBb/6u5LNrQ
	 S6nfI3ZqCKYEA==
Message-ID: <0decc5ec227b4dfde5324d99cea31b97.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <0c14bbacf471683af67ffa7572bfa1d5c45a0b5d.1702849494.git.daniel@makrotopia.org>
References: <27f99db432e9ccc804cc5b6501d7d17d72cae879.1702849494.git.daniel@makrotopia.org> <0c14bbacf471683af67ffa7572bfa1d5c45a0b5d.1702849494.git.daniel@makrotopia.org>
Subject: Re: [PATCH v7 2/5] dt-bindings: reset: mediatek: add MT7988 ethwarp reset IDs
From: Stephen Boyd <sboyd@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Chen-Yu Tsai <wenst@chromium.org>, Conor Dooley <conor+dt@kernel.org>, Dan Carpenter <dan.carpenter@linaro.org>, Daniel Golle <daniel@makrotopia.org>, David S. Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Frank Wunderlich <frank-w@public-files.de>, Garmin.Chang <Garmin.Chang@mediatek.com>, Jakub Kicinski <kuba@kernel.org>, James Liao <jamesjj.liao@mediatek.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>, Michael Turquette <mturquette@baylibre.com>, Paolo Abeni <pabeni@redhat.com>, Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh+dt@kernel.org>, Sabrina Dubroca <sd@queasysnail.net>, Sam Shih <sam.shih@mediatek.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Date: Tue, 02 Jan 2024 16:52:18 -0800
User-Agent: alot/0.10

Quoting Daniel Golle (2023-12-17 13:49:45)
> Add reset ID for ethwarp subsystem allowing to reset the built-in
> Ethernet switch of the MediaTek MT7988 SoC.
>=20
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Applied to clk-next

