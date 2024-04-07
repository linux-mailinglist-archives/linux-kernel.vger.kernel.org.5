Return-Path: <linux-kernel+bounces-134528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F65C89B28D
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 16:45:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1547E28200D
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 14:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F008139FC3;
	Sun,  7 Apr 2024 14:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I0nHgsty"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59CD39AF0
	for <linux-kernel@vger.kernel.org>; Sun,  7 Apr 2024 14:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712501121; cv=none; b=LehfTvKVcmwmSiQ0y9BjNFFvI0YJ0OUye3jiJOsWinevvdc/6sqruj7Ki27BTvdFxuyqSWpylZfDo7dQiDUe8SfQ+kYMGT9dyE+rkAV8eJRKiXcXESGzUYk5R9h6Q0jgNeYWZHM4H9pNHET+gQRZ2DphY2PFALkkyQ4nfjoLNJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712501121; c=relaxed/simple;
	bh=zAVEBXOS1UCmuWPFa3NvXWxQVJDx8fG5WOkx1TFLm5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OY+yKuPSOIBgAUaxWs3bM/kjTBVH/fNAMelTVUfq1vRm1j1NEYc+ul1XXcvochIu4G4NmCTvcNoRqh+SLct36urzwp2PlBSB+6Iy7WQQel2bXOow6xoHuCFwH3RANXE6PKaJFZggTDNDJSjb6POzgW1Ws9cPgsIXlkpaD6BVC/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=I0nHgsty; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6e703e0e5deso3323865b3a.3
        for <linux-kernel@vger.kernel.org>; Sun, 07 Apr 2024 07:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712501119; x=1713105919; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qhyVRxqK5AqjHscgxtd5ktasU/myfa3FBDWSuBFIWmI=;
        b=I0nHgsty8zrw/z6vkcr6HRsHysvYIiMRaA8HOGS5mnKgy5+CZEtyknzpCiUaNHMv0Q
         O1+BeAiMDhgRPz81M2TzxgmktpWTXlo7bSLCu/du8C+FuvfQ5puaiQ5vj7TqCJWTi+vg
         mbjEHSEWXyrXRPdsQ+ocDkSC4nGEl2XoNehfGvdUzhV4BC6BOSlmHh37wsj2/OSi1Mr3
         CCaVbI57Kjs7sAO6k0nidmcShU/5VxfXQm/pJlw6JcfF2VNthpisIhSHmfn2b8EyoRiV
         qOoFutGoApto5Br5Q43m1PYg5ptl4/QHRCvbhxCZpZXvfWUE9fPSn+MfGbrdn19IA0Ts
         DyrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712501119; x=1713105919;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qhyVRxqK5AqjHscgxtd5ktasU/myfa3FBDWSuBFIWmI=;
        b=R95zry/1RLiEO2/lhNAOSZfh+OqkUs6oth715wqpf9urSzpmU8piuNSS4RCMzgVXGe
         ZEHRUfPmDuJhYMkdb16gmopMpj2sQG/O34UX9OV0WwxvmgnYvEuCIbj7nfBgt/myu9kW
         B2Nvv/3Ciab31PPOecfPkegPkV3CJz8ZLs3u3R/rPzT159iGfXhkQbr6b6b6SToHAZZ/
         afnyN1JwGXCkFAXGirDok8PqyhX+wtPp1rPb53Q8vrmX8MqWBKc15ii/QUjOhDGZPSds
         uEYPJFQVZ9nLg7luHSzrrmhdQkv1Lc9OU1XJNYR3KARfQiovOSwQVhicxNGEdBIt276h
         JFGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVd4Pe9a602rYTjnTkOgEBAC8KAbaWIpRamtMQHmhGllacl+XB0k2r/stckWU9TmSaDN0FELL9ZSAMbRfEAWetNwuLNXy9Md39xWajh
X-Gm-Message-State: AOJu0YyhTVIgeZA1HFWa01jus8gM+k5Q8aO2M4Qx8TYzIkq38/WjRJkz
	D+Pson1CrEMKFrYgRBy0va4nOsifu5CQqi9uY5mwa/dEi1ZEyGh3kpveyLfqsg==
X-Google-Smtp-Source: AGHT+IGtrEwjMPAr4IjRSduTFx845THlBva6yxJTug3j99tv2qZB7XyKDyBNddpCjrxb+6DN4zwn4w==
X-Received: by 2002:a05:6a00:1884:b0:6ec:fdcd:18eb with SMTP id x4-20020a056a00188400b006ecfdcd18ebmr8270455pfh.21.1712501118786;
        Sun, 07 Apr 2024 07:45:18 -0700 (PDT)
Received: from thinkpad ([120.56.192.184])
        by smtp.gmail.com with ESMTPSA id g14-20020aa7874e000000b006e69a142458sm4684046pfo.213.2024.04.07.07.45.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Apr 2024 07:45:18 -0700 (PDT)
Date: Sun, 7 Apr 2024 20:15:10 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>, johan+linaro@kernel.org,
	bmasney@redhat.com, djakov@kernel.org,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	vireshk@kernel.org, quic_vbadigan@quicinc.com,
	quic_skananth@quicinc.com, quic_nitegupt@quicinc.com,
	quic_parass@quicinc.com, krzysztof.kozlowski@linaro.org
Subject: Re: [PATCH v9 4/6] arm64: dts: qcom: sm8450: Add opp table support
 to PCIe
Message-ID: <20240407144510.GD2679@thinkpad>
References: <20240407-opp_support-v9-0-496184dc45d7@quicinc.com>
 <20240407-opp_support-v9-4-496184dc45d7@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240407-opp_support-v9-4-496184dc45d7@quicinc.com>

On Sun, Apr 07, 2024 at 10:07:37AM +0530, Krishna chaitanya chundru wrote:
> PCIe needs to choose the appropriate performance state of RPMH power
> domain and interconnect bandwidth based up on the PCIe gen speed.
> 
> Add the OPP table support to specify RPMH performance states and
> interconnect peak bandwidth.
> 

Same comment as the bindings patch.

> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sm8450.dtsi | 77 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 77 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> index 615296e13c43..881e5339cfff 100644
> --- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> @@ -1855,7 +1855,35 @@ &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
>  			pinctrl-names = "default";
>  			pinctrl-0 = <&pcie0_default_state>;
>  
> +			operating-points-v2 = <&pcie0_opp_table>;
> +
>  			status = "disabled";
> +
> +			pcie0_opp_table: opp-table {
> +				compatible = "operating-points-v2";
> +
> +				/* GEN 1x1 */

s/GEN 1x1/Gen 1 x1

Same for all comments

- Mani

> +				opp-2500000 {
> +					opp-hz = /bits/ 64 <2500000>;
> +					required-opps = <&rpmhpd_opp_low_svs>;
> +					opp-peak-kBps = <250000 1>;
> +				};
> +
> +				/* GEN 2x1 */
> +				opp-5000000 {
> +					opp-hz = /bits/ 64 <5000000>;
> +					required-opps = <&rpmhpd_opp_low_svs>;
> +					opp-peak-kBps = <500000 1>;
> +				};
> +
> +				/* GEN 3x1 */
> +				opp-8000000 {
> +					opp-hz = /bits/ 64 <8000000>;
> +					required-opps = <&rpmhpd_opp_nom>;
> +					opp-peak-kBps = <984500 1>;
> +				};
> +			};
> +
>  		};
>  
>  		pcie0_phy: phy@1c06000 {
> @@ -1982,7 +2010,56 @@ &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
>  			pinctrl-names = "default";
>  			pinctrl-0 = <&pcie1_default_state>;
>  
> +			operating-points-v2 = <&pcie1_opp_table>;
> +
>  			status = "disabled";
> +
> +			pcie1_opp_table: opp-table {
> +				compatible = "operating-points-v2";
> +
> +				/* GEN 1x1 */
> +				opp-2500000 {
> +					opp-hz = /bits/ 64 <2500000>;
> +					required-opps = <&rpmhpd_opp_low_svs>;
> +					opp-peak-kBps = <250000 1>;
> +				};
> +
> +				/* GEN 1x2 GEN 2x1 */
> +				opp-5000000 {
> +					opp-hz = /bits/ 64 <5000000>;
> +					required-opps = <&rpmhpd_opp_low_svs>;
> +					opp-peak-kBps = <500000 1>;
> +				};
> +
> +				/* GEN 2x2 */
> +				opp-10000000 {
> +					opp-hz = /bits/ 64 <10000000>;
> +					required-opps = <&rpmhpd_opp_low_svs>;
> +					opp-peak-kBps = <1000000 1>;
> +				};
> +
> +				/* GEN 3x1 */
> +				opp-8000000 {
> +					opp-hz = /bits/ 64 <8000000>;
> +					required-opps = <&rpmhpd_opp_nom>;
> +					opp-peak-kBps = <984500 1>;
> +				};
> +
> +				/* GEN 3x2 GEN 4x1 */
> +				opp-16000000 {
> +					opp-hz = /bits/ 64 <16000000>;
> +					required-opps = <&rpmhpd_opp_nom>;
> +					opp-peak-kBps = <1969000 1>;
> +				};
> +
> +				/* GEN 4x2 */
> +				opp-32000000 {
> +					opp-hz = /bits/ 64 <32000000>;
> +					required-opps = <&rpmhpd_opp_nom>;
> +					opp-peak-kBps = <3938000 1>;
> +				};
> +			};
> +
>  		};
>  
>  		pcie1_phy: phy@1c0e000 {
> 
> -- 
> 2.42.0
> 

-- 
மணிவண்ணன் சதாசிவம்

