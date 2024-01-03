Return-Path: <linux-kernel+bounces-15014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D8F7822625
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 01:53:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC67EB22531
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 00:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 897F0EC5;
	Wed,  3 Jan 2024 00:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HhZQnVr8"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9E910EE;
	Wed,  3 Jan 2024 00:52:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 137EAC433C9;
	Wed,  3 Jan 2024 00:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704243172;
	bh=qmEKcOhYGpPJ/WAJPz7M6JwZUPvd4RGL0nA8rLtBRn0=;
	h=In-Reply-To:References:Subject:From:To:Date:From;
	b=HhZQnVr8s1QLAQpVFoyAGFTnDQ70UMnQeM5aTEBC7ftABslpXzCZ6nPyDhPfqcb+Q
	 ScT9H3azL/TuvcNt5IJ6iQONhMaAl+EpNH7HNdY3hZlH9KH0m/2mNu6mTN0xw1uEPo
	 sdz+FsJfzqN9tyJDhRzTaUQQK3Lu09JMsz1rAM+9z2kLASeHGn2Aa6yximGdjAeqg1
	 znpkwNchkgRhnJpnRImtBg3b7pKC04RY8YYa0Ay3suHuLLjFErAEBeEyIWJ/Fq70zZ
	 Y+nJWzMnpwKrFZ3j3/eBkyaoVrwpMGyW9hY/l7KI4pRTG4/3+8m3JFeYjfyEyUrDI8
	 BG2Sss2qNfiFg==
Message-ID: <ce30101e45da9be9d1617a35e89313b3.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <07e76a544ce4392bcb88e34d5480e99bb7994618.1702849494.git.daniel@makrotopia.org>
References: <27f99db432e9ccc804cc5b6501d7d17d72cae879.1702849494.git.daniel@makrotopia.org> <07e76a544ce4392bcb88e34d5480e99bb7994618.1702849494.git.daniel@makrotopia.org>
Subject: Re: [PATCH v7 3/5] dt-bindings: clock: mediatek: add clock controllers of MT7988
From: Stephen Boyd <sboyd@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Chen-Yu Tsai <wenst@chromium.org>, Conor Dooley <conor+dt@kernel.org>, Dan Carpenter <dan.carpenter@linaro.org>, Daniel Golle <daniel@makrotopia.org>, David S. Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Frank Wunderlich <frank-w@public-files.de>, Garmin.Chang <Garmin.Chang@mediatek.com>, Jakub Kicinski <kuba@kernel.org>, James Liao <jamesjj.liao@mediatek.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>, Michael Turquette <mturquette@baylibre.com>, Paolo Abeni <pabeni@redhat.com>, Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh+dt@kernel.org>, Sabrina Dubroca <sd@queasysnail.net>, Sam Shih <sam.shih@mediatek.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Date: Tue, 02 Jan 2024 16:52:50 -0800
User-Agent: alot/0.10

Quoting Daniel Golle (2023-12-17 13:49:55)
> Add various clock controllers found in the MT7988 SoC to existing
> bindings (if applicable) and add files for the new ethwarp, mcusys
> and xfi-pll clock controllers not previously present in any SoC.
>=20
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> ---

Applied to clk-next

