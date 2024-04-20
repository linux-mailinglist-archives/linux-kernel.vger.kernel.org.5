Return-Path: <linux-kernel+bounces-152073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E964D8AB873
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 03:47:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A725E2816DA
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 01:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2B9979DD;
	Sat, 20 Apr 2024 01:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GvB7Cbpw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE24A48;
	Sat, 20 Apr 2024 01:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713577667; cv=none; b=IUfHyT5Utg5AyYbnb0VeGE9WNohKb52XlgjjnHACbVMjzLbtLz68KsDhpyx5R882ospaeX/mJqAPzMHKbKYB687Mn4KcOsXAndm6S2UaCFuc5M5ZzFPHwfnebcZez8yEl2yiEyX/s3lqr3TPRxW8c+yPs2n1XC5HF3v/08shdrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713577667; c=relaxed/simple;
	bh=cWMroMMkLbwhg0gSs8q2CbxK/P5KZ4bNvKuihB+CO8w=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=J0LomfExYDe3JwI5GT9Te7e51kPH3d0HSj+UNzXvwza5E0aV/QMdImQaOmcHJNLOyLgKnTCahKJH2/nl0s5eZQO1+dZ2DC3WKXxex+KS4mXsX8RglOqKf07y3Jyhm/kEnQ+RNc4d1UpfOF7cPhU/wGEb2hGv9Z3rqzqxtL1MwQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GvB7Cbpw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EB8BC072AA;
	Sat, 20 Apr 2024 01:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713577666;
	bh=cWMroMMkLbwhg0gSs8q2CbxK/P5KZ4bNvKuihB+CO8w=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=GvB7CbpwrgLe+19HALfFpWAblKKATYyBaO+VbWrsY+zQva+CXF92UhJTlaHuT3ktn
	 XKgZc3N0k2ujq+jUTyDeNxZDNl5g8DRdgQwC4whH/6K+L0PQI9QeTdzBw7c16qfK3M
	 x+6k39438SwPQhHbE1AXu3LeUmSYo4JsE0wBQAd85FBzGdiru3cmtgBU7EtTyIK+RI
	 FJHGwbOxnplGExwNqqdRxfQIjo+nLD/TTkN0+LY1vlRCbOguAdp04zvAGmcWMxaQb/
	 w3Gc33XonrJyYZBXP+bhebdBuvaHCFuFY0DQQuzxh3PBLWPTrwmDvloak1sCLu9XzW
	 Fja6e5FBHPZ4Q==
Message-ID: <729d8422f7ecd601019d015f53bd7cd5.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240417-spmi-multi-master-support-v10-4-5bc6d322e266@linaro.org>
References: <20240417-spmi-multi-master-support-v10-0-5bc6d322e266@linaro.org> <20240417-spmi-multi-master-support-v10-4-5bc6d322e266@linaro.org>
Subject: Re: [PATCH v10 4/7] spmi: pmic-arb: Make the APID init a version operation
From: Stephen Boyd <sboyd@kernel.org>
Cc: Srini Kandagatla <srinivas.kandagatla@linaro.org>, Johan Hovold <johan@kernel.org>, David Collins <quic_collinsd@quicinc.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>
To: Abel Vesa <abel.vesa@linaro.org>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Bjorn Andersson <andersson@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>, Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>
Date: Fri, 19 Apr 2024 18:47:44 -0700
User-Agent: alot/0.10

Quoting Abel Vesa (2024-04-17 13:00:56)
> Rather than using conditionals in probe function, add the APID init
> as a version specific operation. Due to v7, which supports multiple
> buses, pass on the bus index to be used for sorting out the apid base
> and count.
>=20
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---

Applied to spmi-next

