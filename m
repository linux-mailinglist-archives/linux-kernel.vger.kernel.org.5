Return-Path: <linux-kernel+bounces-152076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0E518AB87D
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 03:48:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7734E1F22621
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 01:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B56D38BE7;
	Sat, 20 Apr 2024 01:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GKvc2O9Q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031F5205E27;
	Sat, 20 Apr 2024 01:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713577702; cv=none; b=ZpMXS+6LkoEVOk0z1xnpOYQb6C6yEnE7bx9LvaEMEJy3lC5Ogt6VYnaeWjrtEPwTPwisYW3aBW6/XB7QcZzb6YQsFqUB5jkwfJ/jE7WMt1D5wFJ3Jf8OC9VgajB0l/Rhay5LPzx3AtrFs89PQu7BSR+IdoswTnNL+s8i+EaiWlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713577702; c=relaxed/simple;
	bh=qdQRmHFWyDLfIm6MfdCH9hirTy/VGkixvTbfYmty+0w=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=IjiNmYjr9KV40bg1FOhlR5zpXTuraNyXlEzCOe8mYEd7ZegCm77SeInbpzgcFJBOXZ0GEfhlv46XpLaHa9UHFJSuBaz/jNQ+QeUEs0/An5qZEwT1AVkH498g+KdUV/qt9LCUFqhEB82F6Ln5m3OZMPYv8XjDYHuPZiFh0ArwI/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GKvc2O9Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1AA9C072AA;
	Sat, 20 Apr 2024 01:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713577701;
	bh=qdQRmHFWyDLfIm6MfdCH9hirTy/VGkixvTbfYmty+0w=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=GKvc2O9QBA4/T6kSbPGpakPMu2OFRctBdEKKtXVlckvR38b6wNQ+cyWl09AhVFUDY
	 0AUb9wSdWxAPwE0ihhOTjLCCvAKdvWXNc9UbTWG4qkOYf/9BS8GGJf46TbaWWWgj5k
	 Glk9M3jch2/6vJlNnJIVuOZE7YJ2XtlzTYKB6h/Ol5tef9HzwOLgU1HK8RrB0wjFo+
	 lzpcO5MirgXg8BIyXdDVh/rtfthJzijnYyafPTU8Y1GrtA7EOX4FpjcstTgJTI3RG8
	 so41t3+pXXHDO+qzGWP1gUH4IWxyCkfq25pnRJNu9AbmmzXgf2XaB/5rKXMLa406fm
	 6FdN3tmO4wacA==
Message-ID: <135367b4b04dbfd9600372c92d8669db.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240417-spmi-multi-master-support-v10-7-5bc6d322e266@linaro.org>
References: <20240417-spmi-multi-master-support-v10-0-5bc6d322e266@linaro.org> <20240417-spmi-multi-master-support-v10-7-5bc6d322e266@linaro.org>
Subject: Re: [PATCH v10 7/7] spmi: pmic-arb: Add multi bus support
From: Stephen Boyd <sboyd@kernel.org>
Cc: Srini Kandagatla <srinivas.kandagatla@linaro.org>, Johan Hovold <johan@kernel.org>, David Collins <quic_collinsd@quicinc.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>
To: Abel Vesa <abel.vesa@linaro.org>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Bjorn Andersson <andersson@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>, Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>
Date: Fri, 19 Apr 2024 18:48:19 -0700
User-Agent: alot/0.10

Quoting Abel Vesa (2024-04-17 13:00:59)
> Starting with HW version 7, there are actually two separate buses
> (with two separate sets of wires). So add support for the second bus.
> The first platform that needs this support for the second bus is the
> Qualcomm X1 Elite, so add the compatible for it as well.
>=20
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---

Applied to spmi-next

