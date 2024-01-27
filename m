Return-Path: <linux-kernel+bounces-41344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA59883EF1F
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 18:32:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCC821C226B5
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 17:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCFB32D052;
	Sat, 27 Jan 2024 17:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b="cJ25gUiG"
Received: from ahti.lucaweiss.eu (ahti.lucaweiss.eu [128.199.32.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E692D022;
	Sat, 27 Jan 2024 17:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.199.32.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706376768; cv=none; b=UDDnmtkuP9vXfrTm9lT6jrZqsIXHe6Pb5e6KJJ4vPDkhh99t5tFOAFHbI9ThVtLZNtEFRlkUhpPVQopSD4wwa8psq6LKIeR0qoBDY9QlrWhPgXE/YxwOT8fxfcHHzbVss7GMqYg5NiT2NtVloT93AP/sQMsEP1aJw8XuEgfbYhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706376768; c=relaxed/simple;
	bh=p7QvBnitX24maA169i0Q3vHfx6Dzrw5UMf1h0W8pJdQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rcYHpJydKEpVqunJQRZseGyU+fslGt1nQg9fUktGFniFdPNVVXzkg0Zm0395H4UXwJSP7gbtIGv/5wUE+MPHLx007PaUMutq/rSGRIYbPRlwPSoeAIDrXZtWjMDpnc4R1h7BvJWKA6ViVkddgHcSHYPgy8zAx9WhgESJVRckPhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz; spf=pass smtp.mailfrom=z3ntu.xyz; dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b=cJ25gUiG; arc=none smtp.client-ip=128.199.32.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=z3ntu.xyz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=s1;
	t=1706376764; bh=p7QvBnitX24maA169i0Q3vHfx6Dzrw5UMf1h0W8pJdQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cJ25gUiGIpLu6oj/VaeYRe1P1HnzHdSTbOYG+kjdv23WniqBSHs+HlPi1tZ4UTDlQ
	 L/Xw0qZa4Ljb6CZgXw/nnPG4VEGDoUF09Lm9PzcfT999S4jXgQ72oHxeJXyKP1m1bM
	 zSTQF6ZRs3pWtSzHnxgDC1rGk8+5iY9QuYjByLiA=
From: Luca Weiss <luca@z3ntu.xyz>
To: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Vladimir Lypak <vladimir.lypak@gmail.com>,
 Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 2/2] arm64: dts: qcom: msm8953: Add GPU
Date: Sat, 27 Jan 2024 18:32:43 +0100
Message-ID: <4539846.LvFx2qVVIh@z3ntu.xyz>
In-Reply-To: <c58c5897-b3f0-4449-a5b1-df10b117733c@linaro.org>
References:
 <20240125-msm8953-gpu-v1-0-f6493a5951f3@z3ntu.xyz>
 <20240125-msm8953-gpu-v1-2-f6493a5951f3@z3ntu.xyz>
 <c58c5897-b3f0-4449-a5b1-df10b117733c@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Freitag, 26. J=E4nner 2024 00:50:43 CET Konrad Dybcio wrote:
> On 1/25/24 22:56, Luca Weiss wrote:
> > From: Vladimir Lypak <vladimir.lypak@gmail.com>
> >=20
> > Add the GPU node for the Adreno 506 found on this family of SoCs. The
> > clock speeds are a bit different per SoC variant, SDM450 maxes out at
> > 600MHz while MSM8953 (=3D SDM625) goes up to 650MHz and SDM632 goes up =
to
> > 725MHz.
> >=20
> > To achieve this, create a new sdm450.dtsi to hold the 600MHz OPP and
> > use the new dtsi for sdm450-motorola-ali.
> >=20
> > Signed-off-by: Vladimir Lypak <vladimir.lypak@gmail.com>
> > Co-developed-by: Luca Weiss <luca@z3ntu.xyz>
> > Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> > ---
> >=20
> >   arch/arm64/boot/dts/qcom/msm8953.dtsi            | 115
> >   +++++++++++++++++++++++
> >   arch/arm64/boot/dts/qcom/sdm450-motorola-ali.dts |   2 +-
> >   arch/arm64/boot/dts/qcom/sdm450.dtsi             |  14 +++
> >   arch/arm64/boot/dts/qcom/sdm632.dtsi             |   8 ++
> >   4 files changed, 138 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/arch/arm64/boot/dts/qcom/msm8953.dtsi
> > b/arch/arm64/boot/dts/qcom/msm8953.dtsi index 91d083871ab0..1fe0c0c4fd15
> > 100644
> > --- a/arch/arm64/boot/dts/qcom/msm8953.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/msm8953.dtsi
> > @@ -1046,6 +1046,94 @@ mdss_dsi1_phy: phy@1a96400 {
> >=20
> >   			};
> >   	=09
> >   		};
> >=20
> > +		gpu: gpu@1c00000 {
> > +			compatible =3D "qcom,adreno-506.0", "qcom,adreno";
> > +			reg =3D <0x01c00000 0x40000>;
> > +			reg-names =3D "kgsl_3d0_reg_memory";
> > +			interrupts =3D <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
> > +
> > +			clocks =3D <&gcc GCC_OXILI_GFX3D_CLK>,
> > +				 <&gcc GCC_OXILI_AHB_CLK>,
> > +				 <&gcc GCC_BIMC_GFX_CLK>,
> > +				 <&gcc GCC_BIMC_GPU_CLK>,
> > +				 <&gcc GCC_OXILI_TIMER_CLK>,
> > +				 <&gcc GCC_OXILI_AON_CLK>;
> > +			clock-names =3D "core",
> > +				      "iface",
> > +				      "mem_iface",
> > +				      "alt_mem_iface",
> > +				      "rbbmtimer",
> > +				      "alwayson";
> > +			power-domains =3D <&gcc OXILI_GX_GDSC>;
> > +
> > +			iommus =3D <&gpu_iommu 0>;
> > +			operating-points-v2 =3D <&gpu_opp_table>;
> > +
> > +			#cooling-cells =3D <2>;
> > +
> > +			status =3D "disabled";
> > +
> > +			zap-shader {
> > +				memory-region =3D <&zap_shader_region>;
> > +			};
> > +
> > +			gpu_opp_table: opp-table {
> > +				compatible =3D "operating-points-v2";
> > +
> > +				opp-19200000 {
> > +					opp-hz =3D /bits/ 64 <19200000>;
> > +					opp-supported-hw =3D <0xff>;
> > +					required-opps =3D <&rpmpd_opp_min_svs>;
> > +				};
>=20
> If you remove all OPPs but this one, can the GPU still spit out pixels?

Yep, phosh is starting and is rendering at a few fps.

fairphone-fp3:~$ cat /sys/devices/platform/soc@0/1c00000.gpu/devfreq/1c0000=
0.gpu/min_freq
19200000
fairphone-fp3:~$ cat /sys/devices/platform/soc@0/1c00000.gpu/devfreq/1c0000=
0.gpu/max_freq=20
19200000
fairphone-fp3:~$ cat /sys/devices/platform/soc@0/1c00000.gpu/devfreq/1c0000=
0.gpu/cur_freq=20
19200000

Regards
Luca

>=20
> Konrad





