Return-Path: <linux-kernel+bounces-152074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43A008AB877
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 03:48:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7D9F1F21BF6
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 01:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91D6779DE;
	Sat, 20 Apr 2024 01:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q0i0Ls0l"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2BB205E1E;
	Sat, 20 Apr 2024 01:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713577679; cv=none; b=UwqwBFAUXptg+LrnwrMrZeyNvuzn6NOOEg01+awmGdCrboxVVLHngPNN+hvFQM09SGVo/8dqnHx0VNe3GnkOXISvySkP9khhGFmEHAP0sb/2SQ3jpcnZH0S6AQWzMqdGIFJwbSgSwCOtmc2/j943zrCk2V7GvJ+QmWoZ15XRbXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713577679; c=relaxed/simple;
	bh=/5CmRS8HiH3kJSMeFtEZR5LQApr/dDvkmDH/E2gNETA=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=AyZknC5Fjkf0vTRHaqEaaxB2IgFCLstZM+N/0bxjXAs4JEl8HFCdMkyAZRxwBxYBDmKlLCn61Sbe1MapAAz6Ec1Ctkp5KWEjVo1udj/NhqTo5Otn5pwz5EikM1Sb4NDE2mVmBrkPXjInv9XblxfqMSZ2idcC0BBGkG+93rueb10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q0i0Ls0l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E53BC32781;
	Sat, 20 Apr 2024 01:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713577679;
	bh=/5CmRS8HiH3kJSMeFtEZR5LQApr/dDvkmDH/E2gNETA=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=Q0i0Ls0lPJ8FBbPIewbSPyGgnNRLZOjN9bvMpeDX4Apw2MgROEB6JeIQlomfK2wpj
	 O4NBJX0/Xwu+Ap7bQsaWwGvidYUzi2viBS8owbo2GWwH6Hw8AIS2FtnNi2nAXRCcZh
	 zIs/IcowzC2T2FXDr2qzw7lTiLJ6DwXtcZdcm+Lkljqnzj5rihEFyhZV/TFmnxk7Bv
	 8LnZXHcWv/JkZKdUhxxwim2k7PndfRho1epxkEzkNtdmak/uhZhZzYDNYwhXDsYNTV
	 Lwbg/HMRATn284Gq70sSdeqwMP/r3/xlcpUsiF9lg9ucFRP9l/L9C5PtHvdZ72ldHK
	 7KikMiUH1y16Q==
Message-ID: <492aa42a333063a4d148d1ce9398b106.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240417-spmi-multi-master-support-v10-5-5bc6d322e266@linaro.org>
References: <20240417-spmi-multi-master-support-v10-0-5bc6d322e266@linaro.org> <20240417-spmi-multi-master-support-v10-5-5bc6d322e266@linaro.org>
Subject: Re: [PATCH v10 5/7] spmi: pmic-arb: Make core resources acquiring a version operation
From: Stephen Boyd <sboyd@kernel.org>
Cc: Srini Kandagatla <srinivas.kandagatla@linaro.org>, Johan Hovold <johan@kernel.org>, David Collins <quic_collinsd@quicinc.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>
To: Abel Vesa <abel.vesa@linaro.org>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Bjorn Andersson <andersson@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>, Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>
Date: Fri, 19 Apr 2024 18:47:57 -0700
User-Agent: alot/0.10

Quoting Abel Vesa (2024-04-17 13:00:57)
> Rather than setting up the core, obsrv and chnls in probe by using
> version specific conditionals, add a dedicated "get_core_resources"
> version specific op and move the acquiring in there. Since there are
> no current users of the second bus yet, drop the comment about why
> devm_platform_ioremap_resource can't be used in case of "core",
> as it is not applicable anymore.
> Don't switch to devm_platform_ioremap_resource though as we need
> to keep track of core size.
>=20
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---

Applied to spmi-next

