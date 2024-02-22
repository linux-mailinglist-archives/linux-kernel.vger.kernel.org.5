Return-Path: <linux-kernel+bounces-75915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DFB885F09A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 05:57:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FD861C2143B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 04:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3140363AE;
	Thu, 22 Feb 2024 04:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mpf0+kip"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B27E79F5;
	Thu, 22 Feb 2024 04:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708577858; cv=none; b=rhvpnYk5K45r9RzwlVJpD0CRdyZeNDFRsqk3N1qtVdSSdaorgCoLnvHOrB8wSdKsxRD6PHpm+LddTWEm6NzgUCnMlfKku6z0FkTDkPLAXCHGRlmtbxB/kwCFdongfp43b8cuOTI6WaXT7sr/tA+VVy2Ehj5kEPqIJCmq6MXWQNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708577858; c=relaxed/simple;
	bh=LD1a12Iwotseh8k/EGNm4xpZFXAbJSrLwQ+zzlGmHig=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=K+W5Vhz7xeeQKU3khysJDd4ZYR8nnhUsoNHG9YEoZLzYcIZeuqu4PhoECNM7nQYKtJVN9EMv5i1hTdtlusgM7VVbQIaUdLtJc/I8MbA1UnY3wYrkyVeYDaDcDapigZH/h1fYmyjhajchKdhcRGK71pFsc8Fm/gMD10DWzl5ZXTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mpf0+kip; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA6D5C433C7;
	Thu, 22 Feb 2024 04:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708577858;
	bh=LD1a12Iwotseh8k/EGNm4xpZFXAbJSrLwQ+zzlGmHig=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=mpf0+kip2Qpa8fBNhkgu10pfovZVp/XhCe3so/ZwGXGy7ouvjKVJSMbPqbQT4HoEY
	 IYL4sO8wl/gNLWWHIpnLytePYJekOwa4Yni42JKIZbDhz3YoiF/w7eZvOxoIYDja6a
	 Hlfw06K0Fk7+eomJ35IRKRz+VppDF4ANsbkhDrcDN8tcxc6TT12DuAbcj/KNTKaRrm
	 R9eKvy60DoccYwdeqNsG9orebBpOuaUpglOm1ZM5WVxlix+N8Ax2ACtkV7bAKoE9dv
	 oWhVdTkq7BomERG4a+sVYZd8KjoJFVDTaJyrOuiW1fqCMclCWqWRIbQAq7vxpLCVvQ
	 mj1pTVptYMXcQ==
Message-ID: <f631feddb58950b63ecb21e2353e5892.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240214061233.24645-4-zajec5@gmail.com>
References: <20240214061233.24645-1-zajec5@gmail.com> <20240214061233.24645-4-zajec5@gmail.com>
Subject: Re: [PATCH V4 3/3] dt-bindings: clock: mediatek: convert SSUSBSYS to the json-schema clock
From: Stephen Boyd <sboyd@kernel.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Russell King <linux@armlinux.org.uk>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, devicetree@vger.kernel.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Michael Turquette <mturquette@baylibre.com>, =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <zajec5@gmail.com>, Rob Herring <robh@kernel.org>
Date: Wed, 21 Feb 2024 20:57:35 -0800
User-Agent: alot/0.10

Quoting Rafa=C5=82 Mi=C5=82ecki (2024-02-13 22:12:33)
> From: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
>=20
> This helps validating DTS files. Introduced changes:
> 1. Documented "reg" property
> 2. Dropped "syscon" as it was incorrectly used
> 3. Adjusted nodename, "compatible" and "reg" in example
>=20
> Signed-off-by: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> ---

Applied to clk-next

