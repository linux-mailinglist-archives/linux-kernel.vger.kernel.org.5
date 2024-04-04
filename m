Return-Path: <linux-kernel+bounces-130819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62BAC897D76
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 03:42:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C34C1C26117
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 01:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76DBE1758F;
	Thu,  4 Apr 2024 01:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="Rd7AfLqq"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2800314285;
	Thu,  4 Apr 2024 01:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712194915; cv=none; b=uw3d72832JtlFy0zxPuRJ9hlfadZjdrzGcQ2ytmQ75a5c3nXnTvk2V4J0JK3Da8HKmV7KllsrQ9dxJj+GO2O4w4TgB6ygFoxrSusoyGk5FiMtROQrDV4++eb4J9KqJsg2qK3PiRe7GF9qy8Ren2FdXKYTHwS/s8fWX8kQfdnhfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712194915; c=relaxed/simple;
	bh=k5pZjV7/RGdylgzBC888Uj6ijWFfoEo8rl/duzOWrhw=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=m4PzThAdgbxkfE27eKI8+H7xOky0x82D1TRjZxYchfgT+RX5lSJOc9zc9ZTglhLyVCE67nCOGc2MlV0Mrg0IsMHTSB94MZpIW0VSyfCSpPsnVeHW84HR9EDXAjF2wklnpXlYe3JtcR9xQJkCCX9BDIti/WE4iTM+CRohU7HR2/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=Rd7AfLqq; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Received: from [192.168.68.112] (ppp118-210-182-70.adl-adc-lon-bras34.tpg.internode.on.net [118.210.182.70])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 896E520172;
	Thu,  4 Apr 2024 09:41:49 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1712194911;
	bh=W1rbTsbAAc/AY4aRyLkyhlHpWGVkjcjrUfElUyeAL+U=;
	h=Subject:From:To:Date:In-Reply-To:References;
	b=Rd7AfLqqaJYPit6Ul8UxmB8t1ecf1btM92WAriPvXV7pbzzbn2zUNTh2jFfru/mBp
	 g7pF0Vz+rmxtckPjnbdR9CwIeHWQvU5yfY7qEmAp0q7N5ZccNZ1eMz56R+KvRaaPMa
	 3s3ZXX74Csgfh7O0sZ86yY/HEMrplzGxldN8Sg54aCiuam152zMnBTXsnSJWeJqkBk
	 I8sTyKvAIah0lsCBmlVRCJrVFCyDr/PUrEkd6YcQQ73wD0VG6zBlWwtVRpnH9m/ZLr
	 XeMHqOMpJvXUWwF87YiAlWwRnFR0NaDMJyD4VvL73ugbL6YNmA3mPTpRceEtStuMdS
	 5arEaLy77C+8w==
Message-ID: <8610e0a8aa5c2916fa04292a10e8a843862ff0ee.camel@codeconstruct.com.au>
Subject: Re: [PATCH 1/4] ARM: dts: aspeed: greatlakes: correct Mellanox
 multi-host property
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Rob Herring
 <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>,  Conor Dooley <conor+dt@kernel.org>,
 Joel Stanley <joel@jms.id.au>, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
 linux-kernel@vger.kernel.org
Date: Thu, 04 Apr 2024 12:11:48 +1030
In-Reply-To: <171213860535.16780.4635499105199545058.b4-ty@linaro.org>
References: <20231209104412.12916-1-krzysztof.kozlowski@linaro.org>
	 <171213860535.16780.4635499105199545058.b4-ty@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-04-03 at 12:04 +0200, Krzysztof Kozlowski wrote:
> On Sat, 09 Dec 2023 11:44:09 +0100, Krzysztof Kozlowski wrote:
> > "mlx,multi-host" is using incorrect vendor prefix and is not documented=
.
> >=20
> >=20
>=20
> These wait for ~4 months and they were not picked up. Let me know if anyo=
ne
> else wants to take these.
>=20
> Applied, thanks!
>=20
> [1/4] ARM: dts: aspeed: greatlakes: correct Mellanox multi-host property
>       https://git.kernel.org/krzk/linux-dt/c/7da85354c4fa35b862294dbbb450=
baeb405b5a92
> [2/4] ARM: dts: aspeed: minerva-cmc: correct Mellanox multi-host property
>       https://git.kernel.org/krzk/linux-dt/c/e515719c17beb9625a90039f6c45=
fa36d58bdda2
> [3/4] ARM: dts: aspeed: yosemite4: correct Mellanox multi-host property
>       https://git.kernel.org/krzk/linux-dt/c/af3deaf9bcb4571feb89a4050c7a=
d75de9aa8e1e
> [4/4] ARM: dts: aspeed: yosemitev2: correct Mellanox multi-host property
>       https://git.kernel.org/krzk/linux-dt/c/cac1c1dda6130771e06ace030b1b=
0ed62096a912
>=20
> Best regards,

Ah, my apologies. Joel's on leave and I'm accumulating patches in a
tree for him in the mean time. I've had some things going on
professionally (changed jobs) and personally, and these fell into a bit
of a hole.

I'm okay for these patches to be integrated through your tree, given
you've already applied them. Feel free to add acks if your branch
allows:

Acked-by: Andrew Jeffery <andrew@codeconstruct.com.au>

I'm working to stay on top of things a bit more now than I have in the
recent past, so hopefully I won't miss patches again in the future.

Andrew

