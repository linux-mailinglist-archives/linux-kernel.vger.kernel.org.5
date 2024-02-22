Return-Path: <linux-kernel+bounces-75920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B680D85F0A5
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 06:02:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7D861C21DD7
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 05:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F4E85680;
	Thu, 22 Feb 2024 05:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mpRDZKFV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4CC7483;
	Thu, 22 Feb 2024 05:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708578164; cv=none; b=l/4+b6w5EghuiF+veoIaSIVUnuI2Ban77apl3LGiGDRaUN4HxHgdRPIg4v3HWkYOTlAwO9pFl9uFvpLZ2h6GHvq6U406WMKCezhA3PSoOYWht51WUCvZG++YuYakzfuL5r5owbry5jJ/D1yGyu6uvleLRnexn8kcexCQZ2rAHaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708578164; c=relaxed/simple;
	bh=enf5/IVeYMNDehryU/3ZMg5SHL/howmfENfbcpvNnmk=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=hzqxM18/GujuAPIXG/ebbYJ7796hq6J8buyO9JkSO04dFOHJjU0LEojzuDGLiIVzz5BsGHFr3WbgJDixtnZHmoowFA2xQCLsvppviV39nPpHLl/uWixr8LLe/CX8rytWoqep+xpwBh0liyV3Wc2NzgwZQBkIbV7aer94l6iNvHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mpRDZKFV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 378C0C433C7;
	Thu, 22 Feb 2024 05:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708578164;
	bh=enf5/IVeYMNDehryU/3ZMg5SHL/howmfENfbcpvNnmk=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=mpRDZKFVhs6qq0cVBPIlcNZghwLUnUYC1rxX7vmacx8Y3v/pkQDJxTsNAlldvyMZP
	 8//EOfUgh7X+wP12JmRYQM1u0pEHA3Lez/2ESA7R4jaLIU5uv8LCMpSa/UPHmvcRCR
	 JeO/hknX6obZzSlV+6KDt11PN6EPVRTBkgNIx7BYH129SVLoipcmgdICjrkraulWeS
	 1ussSgqmGFK9OUjWkXL303IvmmR6226pFhiieYZQq414mwtN9L2XPCMijjrhDOlEO0
	 Z0C3iNRHEB1F6zaytWwPijSKXiMueVN0rHSl/DqdInQuHQTqfbKFTQ6kpRuc5pzzsA
	 n3VDKX+JHRVTQ==
Message-ID: <e82d900ea88e0b63f14b0042677269d5.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240201182409.39878-2-linux@fw-web.de>
References: <20240201182409.39878-1-linux@fw-web.de> <20240201182409.39878-2-linux@fw-web.de>
Subject: Re: [PATCH v4 1/2] dt-bindings: reset: mediatek: add MT7988 infracfg reset IDs
From: Stephen Boyd <sboyd@kernel.org>
Cc: Frank Wunderlich <frank-w@public-files.de>, Sam Shih <sam.shih@mediatek.com>, Daniel Golle <daniel@makrotopia.org>, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org, Conor Dooley <conor.dooley@microchip.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Conor Dooley <conor+dt@kernel.org>, Frank Wunderlich <linux@fw-web.de>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>, Michael Turquette <mturquette@baylibre.com>, Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh+dt@kernel.org>
Date: Wed, 21 Feb 2024 21:02:42 -0800
User-Agent: alot/0.10

Quoting Frank Wunderlich (2024-02-01 10:24:08)
> From: Frank Wunderlich <frank-w@public-files.de>
>=20
> Add reset constants for using as index in driver and dts.
>=20
> Value is starting again from 0 because resets are used in another device
> than existing constants.
>=20
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> ---

Applied to clk-next

