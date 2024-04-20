Return-Path: <linux-kernel+bounces-152075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98C4A8AB87A
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 03:48:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38AF81F22131
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 01:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 383B38F6E;
	Sat, 20 Apr 2024 01:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uHDftXS8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A4E8F5D;
	Sat, 20 Apr 2024 01:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713577691; cv=none; b=Hv1OWFDR8uzk2p0us1BOfRmR5nLcfye1RganNiVs3wy5T7GPe2S2bQDydxItDCVPiPuek3oghLip/hTkR+5lbRK4YC2Vm9JNuedb4yNDOXWO0q+6Blhl/HdQyFeiv5HQMrbNHb87KVMm+1f73KCq//usgWkJtIQIuh17dS+MjyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713577691; c=relaxed/simple;
	bh=JoSO9lCcr1WGFQ3qpQ8hPbZPOyeuTvk2QeXaFvbAZp4=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=lsUB4fUvoFPFiTouA1modPTmD3tXPxmKZYWsL3DVVW6sJKtFTSWn7+muRtOEImhGwKXvDr+NH+e63bFEkzyuU2v88Mbw5MHHCx6ZU3ILsrPb0bVIy5HjAdk5KMsGY+WAty72OIFYs56GlTz9Po2YjKeq/3qRA2UeYdBtG9Mljr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uHDftXS8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C30CFC2BD10;
	Sat, 20 Apr 2024 01:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713577690;
	bh=JoSO9lCcr1WGFQ3qpQ8hPbZPOyeuTvk2QeXaFvbAZp4=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=uHDftXS8Omw6VttWWXD3YU6Tn2SLiDMC6gvGKkLk6xvgRqL1vlU4jYWW34jrkkIzj
	 lduW7CbIOfVQxAcKFbIiLFydYa2L0uzj2OSMVCZi3wQrTlUfRhGRyRBnUFiy6l5z9/
	 lpx5AztNQgxEAx4zq84lwGG7BD1dWjbS/wTQA4RXiwmYQa1lYOUCekGFAmIfjnMoro
	 pkdH9dJCOplwRMlywxUSEahWvM7ExrNBJQOBnoGfxcVorbDyC+Q6Znwn3ai4DslBhI
	 CMuOiXhx+wk2mEuHQGe4CiGPFSwNxXIXzsbQhSxW1u99mhoU2vpCazjrh6HvlGcWwk
	 /JGXMzjCfJ6cQ==
Message-ID: <d5cd2bf8a6f2e12d5e3cb6bf68ccdaf8.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240417-spmi-multi-master-support-v10-6-5bc6d322e266@linaro.org>
References: <20240417-spmi-multi-master-support-v10-0-5bc6d322e266@linaro.org> <20240417-spmi-multi-master-support-v10-6-5bc6d322e266@linaro.org>
Subject: Re: [PATCH v10 6/7] spmi: pmic-arb: Register controller for bus instead of arbiter
From: Stephen Boyd <sboyd@kernel.org>
Cc: Srini Kandagatla <srinivas.kandagatla@linaro.org>, Johan Hovold <johan@kernel.org>, David Collins <quic_collinsd@quicinc.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>
To: Abel Vesa <abel.vesa@linaro.org>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Bjorn Andersson <andersson@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>, Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>
Date: Fri, 19 Apr 2024 18:48:08 -0700
User-Agent: alot/0.10

Quoting Abel Vesa (2024-04-17 13:00:58)
> Introduce the bus object in order to decouple the resources
> that are bus specific from the arbiter. This way the SPMI controller
> is registered with the generic framework at a bus level rather than
> arbiter. This is needed in order to prepare for multi bus support.
>=20
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---

Applied to spmi-next

