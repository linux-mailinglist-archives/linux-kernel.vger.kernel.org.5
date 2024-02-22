Return-Path: <linux-kernel+bounces-75913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5498985F094
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 05:57:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A94E284C3D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 04:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED3F14C7E;
	Thu, 22 Feb 2024 04:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j8PLpDcM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327CE1396;
	Thu, 22 Feb 2024 04:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708577839; cv=none; b=Z2t02IC72qG49C0wD8BVRSFs8QsdK9DrlQWyNsJArnwxdNiPj/EA3UGV5WjZUhT1cprDUwvRhNmUvP8ISf+eF0Y3YJodbE0SQqXV24G05y3EYJsEJj8mWRkAo5l0SCzWvdOJg4LpaemJR2DxeXtBiTbqak4AIuG4BODdmXa3Kdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708577839; c=relaxed/simple;
	bh=h0xKN2jUIqLJv3oULNhPWv+pSYgawbESaRrEvYOTM2o=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=JFJzpcNr5hNmcyBEcH9uzCKx0jca5x6wVCOVIXuMIiq339C/43zRvMKTFhpDNKH+xouikiF/f00f+4clT5u2oopMiYtI5sCKFu0Af6sty+iZyV3P2j7a/MZAffAEBVl7wUNH9KMkZe3zidLlPvKWjItT1BLeFiHNVwgqAHKf7Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j8PLpDcM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90348C433F1;
	Thu, 22 Feb 2024 04:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708577838;
	bh=h0xKN2jUIqLJv3oULNhPWv+pSYgawbESaRrEvYOTM2o=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=j8PLpDcMsIh1w2Vfa9NcWW8SPXwzHWw8nd+aFCfptlv20qbE/4+8rWWieRtWMEa8E
	 Pqb8KLkGbiEAqqbVhjhcEE4fk3eMQ+ibSXBZNX0zP9+UZhB5utZMX74SRhti0RkGEa
	 2L+34nm6QlP6iH6k6ZhWyKVCh+um3SzHMQQERRHs2B8xIKhDRxeoaHnx64sN1D1w3y
	 G2/6OXTtil5JIvsM8PV1zr4Pxu24h6A0MmPkwCSy+0DgWYDzhvlgxQYi24ZQZJMwmH
	 hbY9ImVA4yv/uvW0bBUzsEhCXrNqIK2KAWhKqhirFC2CUBTj18XAYTOIEVhJs8O/F/
	 fve0TtGZ4WaQw==
Message-ID: <f6ed0b3e66e346994003e4c3954e1edf.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240214061233.24645-2-zajec5@gmail.com>
References: <20240214061233.24645-1-zajec5@gmail.com> <20240214061233.24645-2-zajec5@gmail.com>
Subject: Re: [PATCH V4 1/3] dt-bindings: clock: mediatek: convert hifsys to the json-schema clock
From: Stephen Boyd <sboyd@kernel.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Russell King <linux@armlinux.org.uk>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, devicetree@vger.kernel.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Michael Turquette <mturquette@baylibre.com>, =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <zajec5@gmail.com>, Rob Herring <robh@kernel.org>
Date: Wed, 21 Feb 2024 20:57:16 -0800
User-Agent: alot/0.10

Quoting Rafa=C5=82 Mi=C5=82ecki (2024-02-13 22:12:31)
> From: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
>=20
> This helps validating DTS files. Introduced changes:
> 1. Documented "reg" property
> 2. Documented "#reset-cells" property
> 3. Dropped "syscon" as it was incorrectly used
> 4. Adjusted "compatible" and "reg" in example
>=20
> Signed-off-by: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> ---

Applied to clk-next

