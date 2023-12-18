Return-Path: <linux-kernel+bounces-3044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F8E81668C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 07:32:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 059481C2198F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 06:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A17556FB5;
	Mon, 18 Dec 2023 06:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lpRvyy4t"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59056FA2;
	Mon, 18 Dec 2023 06:32:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A4EAC433C7;
	Mon, 18 Dec 2023 06:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702881136;
	bh=0w/82EmxDdtEcR36oapMX0tmq6V73gwFqUVRTEPC6C8=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=lpRvyy4tKQJda+cxtKyuQnl4PWpo7xC9qBUtL77BJkjqBn/1kHsbh5F6qL5DgI+e/
	 JxavVlwV2Ebc5mdU0QAIQc7jwtLJi+KAhOb7K8/WLml0RkTf9SNE/yzH/XP7OOQ/W3
	 PmZnB6bLsu1fT+mZC62LnlWBJ1w0IcSyd7UxcEfgK/NOYB5Mt2RIWgyoxXpf/xPLkC
	 jMhXCLH47fHT8+fwKuSnAySUuM1OxbY8bqTwXMAJUcUM4WahE9QFi6T9C8pWMUyU6m
	 /FMNAyKJLO0dVBao1mI6g3TEYdouuMJOOFUgBysr4/3b0SFqdsCNBktfCNxR1m1PNr
	 spW+wI9GmyYNw==
Message-ID: <26a42eaa71f3826ce165e6bbf08618fc.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20231124-alvin-clk-si5351-no-pll-reset-v6-1-69b82311cb90@bang-olufsen.dk>
References: <20231124-alvin-clk-si5351-no-pll-reset-v6-0-69b82311cb90@bang-olufsen.dk> <20231124-alvin-clk-si5351-no-pll-reset-v6-1-69b82311cb90@bang-olufsen.dk>
Subject: Re: [PATCH v6 1/3] dt-bindings: clock: si5351: convert to yaml
From: Stephen Boyd <sboyd@kernel.org>
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Rabeeh Khoury <rabeeh@solid-run.com>, Jacob Siverskog <jacob@teenage.engineering>, Sergej Sawazki <sergej@taudac.com>, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>
To: Alvin =?utf-8?q?=C5=A0ipraga?= <alsi@bang-olufsen.dk>, Alvin =?utf-8?q?=C5=A0ipraga?= <alvin@pqrs.dk>, Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Rob Herring <robh+dt@kernel.org>
Date: Sun, 17 Dec 2023 22:32:13 -0800
User-Agent: alot/0.10

Quoting Alvin =C5=A0ipraga (2023-11-24 05:17:42)
> From: Alvin =C5=A0ipraga <alsi@bang-olufsen.dk>
>=20
> The following additional properties are described:
>=20
>   - clock-names
>   - clock-frequency of the clkout child nodes
>=20
> In order to suppress warnings from the DT schema validator, the clkout
> child nodes are prescribed names clkout@[0-7] rather than clkout[0-7].
>=20
> The example is refined as follows:
>=20
>   - correct the usage of property pll-master -> silabs,pll-master
>   - give an example of how the silabs,pll-reset property can be used
>=20
> I made myself maintainer of the file as I cannot presume that anybody
> else wants the responsibility.
>=20
> Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> Cc: Rabeeh Khoury <rabeeh@solid-run.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Alvin =C5=A0ipraga <alsi@bang-olufsen.dk>
> ---

Applied to clk-next

