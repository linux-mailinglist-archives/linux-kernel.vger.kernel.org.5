Return-Path: <linux-kernel+bounces-15011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9ADA822619
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 01:52:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61A501F23565
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 00:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0C92A57;
	Wed,  3 Jan 2024 00:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hGvDwHPq"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37DDA655;
	Wed,  3 Jan 2024 00:52:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A6AFC433C7;
	Wed,  3 Jan 2024 00:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704243128;
	bh=pv2/604wB1FbsSwfgxevhJWAEYEnsxB4DMwv7K7Gywk=;
	h=In-Reply-To:References:Subject:From:To:Date:From;
	b=hGvDwHPql+T2nr7Ckh38R5cHAioVp82CFXOlcYglkFtzL1vNQ2Xpdb3KU5q+bcZJb
	 3o+9plQn+3B0XVxZkaEsmBCTsBUE+xP7fDazumgQ0eJTCeRePFXoLhqmdUHtbOb6fA
	 nn0+e1WN9LTya3j0xcfA56sLTCodlTNGoUu6Ax8RJUlAWn7zX/MPbBgVWNx2VLNNOY
	 nSdY2qcVPD84eU3rR7Mq/rAkiy2XRNYa4v9RSCqJ4UG3pPe98Vnv/Ri8lMOeCLhRb+
	 JHrYe8L7ytvKa0qvFXJT0Oqcox/k2S4xAFxCnIUrrjn8GAuXK9EalHpmlmK4jMsDid
	 qMp0bfd7KrKkw==
Message-ID: <ce85d733622a998396598efd64882e9d.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <27f99db432e9ccc804cc5b6501d7d17d72cae879.1702849494.git.daniel@makrotopia.org>
References: <27f99db432e9ccc804cc5b6501d7d17d72cae879.1702849494.git.daniel@makrotopia.org>
Subject: Re: [PATCH v7 1/5] dt-bindings: clock: mediatek: add MT7988 clock IDs
From: Stephen Boyd <sboyd@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Chen-Yu Tsai <wenst@chromium.org>, Conor Dooley <conor+dt@kernel.org>, Dan Carpenter <dan.carpenter@linaro.org>, Daniel Golle <daniel@makrotopia.org>, David S. Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Frank Wunderlich <frank-w@public-files.de>, Garmin.Chang <Garmin.Chang@mediatek.com>, Jakub Kicinski <kuba@kernel.org>, James Liao <jamesjj.liao@mediatek.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>, Michael Turquette <mturquette@baylibre.com>, Paolo Abeni <pabeni@redhat.com>, Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh+dt@kernel.org>, Sabrina Dubroca <sd@queasysnail.net>, Sam Shih <sam.shih@mediatek.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Date: Tue, 02 Jan 2024 16:52:06 -0800
User-Agent: alot/0.10

Quoting Daniel Golle (2023-12-17 13:49:33)
> From: Sam Shih <sam.shih@mediatek.com>
>=20
> Add MT7988 clock dt-bindings for topckgen, apmixedsys, infracfg,
> ethernet and xfipll subsystem clocks.
>=20
> Signed-off-by: Sam Shih <sam.shih@mediatek.com>
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> ---

Applied to clk-next

