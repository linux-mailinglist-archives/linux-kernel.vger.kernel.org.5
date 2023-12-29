Return-Path: <linux-kernel+bounces-13245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D39778201EF
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 22:41:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 712901F21D72
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 21:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EA5F14A94;
	Fri, 29 Dec 2023 21:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b="IvI/93aV"
X-Original-To: linux-kernel@vger.kernel.org
Received: from ahti.lucaweiss.eu (ahti.lucaweiss.eu [128.199.32.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51E414A85;
	Fri, 29 Dec 2023 21:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=z3ntu.xyz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=s1;
	t=1703886088; bh=xLta2et/RCU0Zo2v7ZHpE3DZ9Yskf/Y+2hhuLWPw8Ew=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IvI/93aV6sGg+QjpqN/k8TxpIC7p57mFS8443iWsaFkmjUeJHZ2L+Ka/m8YRG/4Ac
	 OlkN3kS3Fjfn65XaagnwE1Okf1ncqJcDPq4CYU4fJtP6VryPeDdR56n/Bg4rgD05Jl
	 cEfrjhb6ci4bvQV0IeAR4kzDgRgRkTyVyKcInIFY=
From: Luca Weiss <luca@z3ntu.xyz>
To: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Dylan Van Assche <me@dylanvanassche.be>, David Heidelberg <david@ixit.cz>
Cc: David Heidelberg <david@ixit.cz>, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH] arm64: dts: qcom: sdm845-oneplus-common: improve DAI node naming
Date: Fri, 29 Dec 2023 22:41:28 +0100
Message-ID: <6001009.lOV4Wx5bFT@z3ntu.xyz>
In-Reply-To: <20231229200245.259689-1-david@ixit.cz>
References: <20231229200245.259689-1-david@ixit.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Freitag, 29. Dezember 2023 21:02:33 CET David Heidelberg wrote:
> Make it easier to understand what the reg in those nodes is by using the
> constants provided by qcom,q6dsp-lpass-ports.h.
> 
> Name nodes according to dt-binding expectations.
> 
> Fix for
> ```
> arch/arm64/boot/dts/qcom/sdm845-oneplus-enchilada.dtb: service@4: dais:
> Unevaluated properties are not allowed ('qi2s@22', 'qi2s@23' were
> unexpected) ```
> 
> Fixes: b7b734286856 ("arm64: dts: qcom: sdm845-oneplus-*: add audio
> devices") Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
> b/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi index
> e821103d49c0..46e25c53829a 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
> @@ -508,13 +508,13 @@ led-1 {
>  };
> 
>  &q6afedai {
> -	qi2s@22 {
> -		reg = <22>;
> +	dai@22 {
> +		reg = <QUATERNARY_MI2S_RX>;
>  		qcom,sd-lines = <1>;
>  	};
> 
> -	qi2s@23 {
> -		reg = <23>;
> +	dai@23 {
> +		reg = <QUATERNARY_MI2S_TX>;

I did the 'reg' part before, either I missed this file or it was added after I
made the patch.
https://lore.kernel.org/linux-arm-msm/20220603094710.64591-1-luca.weiss@fairphone.com/

But looks correct:

Reviewed-by: Luca Weiss <luca@z3ntu.xyz>


>  		qcom,sd-lines = <0>;
>  	};
>  };





