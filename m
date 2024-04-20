Return-Path: <linux-kernel+bounces-152070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 507558AB86A
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 03:47:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC50C1F21923
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 01:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9375610E;
	Sat, 20 Apr 2024 01:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oS+NQhOD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8A339B;
	Sat, 20 Apr 2024 01:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713577623; cv=none; b=d1k90Fk0aZSwXWSbolUA06bjo7PqtT62N1ZV/P8fEOJDpSdfF/HaF98g/y4gA4eDSFZrWrXVNjhGBKaW4x3RWzYJJFtbImhEc7AoGRGGA5iet7dHQnF2HIIN+ij8mPEVVWx73PqTSqOM7dFik+cTfTQu63ZWmETezSobY1ZnfqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713577623; c=relaxed/simple;
	bh=+sUZLTG+t90yoU9i3sUGvWL7wWsSrAjylIw68RYc+Zo=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=B1Yj+a7PpXcb4eQCbnYu7gDE078r/oiplgEgovrd/lcX33uQkyzCKF0SvArA9SSGIhbM95u6ufzmHu1zD8CjU2ygHu+esE8LylehepvvDrr0FBcx3gKRFKtDFVKXr+lWGVfju8iPX7UN8iLNW2+OLhDX0gTavjiW998x3TFDl1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oS+NQhOD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F4F2C072AA;
	Sat, 20 Apr 2024 01:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713577622;
	bh=+sUZLTG+t90yoU9i3sUGvWL7wWsSrAjylIw68RYc+Zo=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=oS+NQhODQ20kg1MTtN8clw9/2/QFBDeTfyYuWD041J5m14038RxMFNyAaphbRqjC8
	 STAqCxd8ff67DIVjH2IoU8a5TBN1Fwk6SWLT1TtJpATFNE6F75Wkgz9ac6eS2/JZd9
	 FE+oBKJkAlgdDunqbkvtn2PT6uNbezuHlqy8OmrTW4Uinohk7hVXD4tllJzG8MkpqB
	 TkzvRyy+9rlWxo/qrJ7hWbDsq5zcNb1vSpLx7Jv94KwGqnRfolTNa92/sV67b4YDYm
	 BJhKRei5NGEUEEUd+27gM04Rr22OYw5ey3921IxO8jwGF8Gvj/cthjTMGaGHVFgrHX
	 wGdzNAydXfLDQ==
Message-ID: <ca6611df78c2518dac607ab2241d1556.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240417-spmi-multi-master-support-v10-1-5bc6d322e266@linaro.org>
References: <20240417-spmi-multi-master-support-v10-0-5bc6d322e266@linaro.org> <20240417-spmi-multi-master-support-v10-1-5bc6d322e266@linaro.org>
Subject: Re: [PATCH v10 1/7] dt-bindings: spmi: Add X1E80100 SPMI PMIC ARB schema
From: Stephen Boyd <sboyd@kernel.org>
Cc: Srini Kandagatla <srinivas.kandagatla@linaro.org>, Johan Hovold <johan@kernel.org>, David Collins <quic_collinsd@quicinc.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Abel Vesa <abel.vesa@linaro.org>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Bjorn Andersson <andersson@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>, Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>
Date: Fri, 19 Apr 2024 18:47:00 -0700
User-Agent: alot/0.10

Quoting Abel Vesa (2024-04-17 13:00:53)
> Add dedicated schema for X1E80100 PMIC ARB. This is not the first
> platform to introduce multiple buses. In fact, all platforms that
> implement the version 7 for the SPMI PMIC arbiter have multiple buses.
> Since the compatible should not be version based, the platform specific
> one is used. The X1E80100 platform is the first platform to really need
> the second master, as all the available boards have the PMICs that
> provide the eUSB2 repeater on the second bus.
>=20
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---

Applied to spmi-next

