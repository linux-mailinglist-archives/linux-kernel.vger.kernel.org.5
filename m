Return-Path: <linux-kernel+bounces-41342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F6FA83EF16
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 18:25:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2F351C21BB0
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 17:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93DE22D04C;
	Sat, 27 Jan 2024 17:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b="K9mpjh1w"
Received: from ahti.lucaweiss.eu (ahti.lucaweiss.eu [128.199.32.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB522E629;
	Sat, 27 Jan 2024 17:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.199.32.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706376297; cv=none; b=l+r5Ue493NmytYiu8Rh3cA+/W5p7FG2Z83m2tDAyvIiGRsqavv9QquMkQyUNuaIhSBv77ISzcM2E0xg9smFrsQT7KhA3by99DBhWnaAJ4eYysZ/JlaNv4ZQOMnbFX1/691Aps/kG43IWbA8cDTcRR1qV+wFDKHvzuttoZpzcUBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706376297; c=relaxed/simple;
	bh=um2zQi0rBzC8vtFhb5/Jr5Ju8k+jgRVIJhHFh1WG0GQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g4oxQLhWOX1beG1Il4PqsUqSLs33HjC01tCtnCyvzMTLvOs/jP9C8drOOnWmnn88djDarKuktzswzqj5w4wVPvgZdy9u0dyClbM47hFvmPp/XRat0+s7QJP50PHySHpvTyfQnfwUL4KZSzWZVvsHIJ5gw/qAAKEMIjespW/LuA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz; spf=pass smtp.mailfrom=z3ntu.xyz; dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b=K9mpjh1w; arc=none smtp.client-ip=128.199.32.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=z3ntu.xyz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=s1;
	t=1706376288; bh=um2zQi0rBzC8vtFhb5/Jr5Ju8k+jgRVIJhHFh1WG0GQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=K9mpjh1w99h/qZJXyhsZ0vx7eSlMDE5z+MlrrtjViAdsFilQbubnRXXZs7ILkS+O+
	 HZYrfKY21rt9or3WbeMF78RgtUYmofwTbRC9UFNIpe1BR7slgcfujz52TIGKdFFBCN
	 tTlXdkxr5ojIaE5/MqPC9ODVhxrvqpJ8/QAIrPJI=
From: Luca Weiss <luca@z3ntu.xyz>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Vladimir Lypak <vladimir.lypak@gmail.com>,
 Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 1/2] arm64: dts: qcom: msm8953: Add GPU IOMMU
Date: Sat, 27 Jan 2024 18:24:46 +0100
Message-ID: <6009977.lOV4Wx5bFT@z3ntu.xyz>
In-Reply-To: <a75d8b2f-a55a-4087-b039-60769678a480@linaro.org>
References:
 <20240125-msm8953-gpu-v1-0-f6493a5951f3@z3ntu.xyz>
 <d576e655-5d00-44ff-9405-0fceaa2d3935@linaro.org>
 <a75d8b2f-a55a-4087-b039-60769678a480@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Freitag, 26. J=E4nner 2024 00:49:55 CET Konrad Dybcio wrote:
> On 1/25/24 23:24, Dmitry Baryshkov wrote:
> > On 25/01/2024 23:56, Luca Weiss wrote:
> >> From: Vladimir Lypak <vladimir.lypak@gmail.com>
> >>=20
> >> Add the IOMMU used for the GPU on MSM8953.
> >>=20
> >> Signed-off-by: Vladimir Lypak <vladimir.lypak@gmail.com>
> >> ---
> >>   arch/arm64/boot/dts/qcom/msm8953.dtsi | 31
> >> +++++++++++++++++++++++++++++++ 1 file changed, 31 insertions(+)
> >>=20
> >> diff --git a/arch/arm64/boot/dts/qcom/msm8953.dtsi
> >> b/arch/arm64/boot/dts/qcom/msm8953.dtsi index dcb5c98b793c..91d083871a=
b0
> >> 100644
> >> --- a/arch/arm64/boot/dts/qcom/msm8953.dtsi
> >> +++ b/arch/arm64/boot/dts/qcom/msm8953.dtsi
> >> @@ -1046,6 +1046,37 @@ mdss_dsi1_phy: phy@1a96400 {
> >>               };
> >>           };
> >> +        gpu_iommu: iommu@1c48000 {
> >=20
> > Nit: most of the platforms use the adreno_smmu label. But maybe the
> > msm-iommu vs arm-smmu makes difference here.
> Not really :)
>=20
> Please keep the labels unified

Ack, renaming to adreno_smmu

>=20
> > Nevertheless:
> >=20
> > Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> >=20
> >> +            compatible =3D "qcom,msm8953-iommu", "qcom,msm-iommu-v2";
> >> +            ranges =3D <0 0x01c48000 0x8000>;
> >> +
> >> +            clocks =3D <&gcc GCC_OXILI_AHB_CLK>,
> >> +                 <&gcc GCC_BIMC_GFX_CLK>;
>=20
> And align these

They are?

Also any comment about the issues listed in the cover letter?

Regards
Luca

>=20
> Konrad





