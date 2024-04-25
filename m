Return-Path: <linux-kernel+bounces-158594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2C808B229B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 15:26:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D819E1C21210
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 13:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17786149C75;
	Thu, 25 Apr 2024 13:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vo9XqYqo"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A39149C58
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 13:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714051422; cv=none; b=UGedk15WHb7l8wc3U3Zr5wdeLclQfTqEZTU5CKE5DYa7eXpsK7+UklFVXdllpVGb8yFldHHMpXs9O4K8mj04L+g0uqrug6MId7L/g8OACuiENEjwq9IdGLsnRXfwdHCzu0bEhg9nvxHf6EKty7wSm4KfAl8YhkjwFIp13Y7Tc8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714051422; c=relaxed/simple;
	bh=2BTXCw+6vC31dUTeKdIMEsyHikhtPpKJtrh+xSZfBw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VOSp0NUk77EegX4OLNwVEjJBKas1U1EaZxW+bq+llelof7fG6nqXz+7o9AL4DnvqhxQNiBsdk8ZAfHGv8Ht+i7mjKg7QMO1YOdXn057OT0dT3TQHpIhTWN8bbc/RTt6Ng3ZOPd/pqIkzRLXDUAnprQFsNcAawkRdmaaWX/6vh4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Vo9XqYqo; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1e83a2a4f2cso6092655ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 06:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714051419; x=1714656219; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4rnjNjenfTwjulfe8NiDD/HuQ2B2O5By8Tzxa2258wk=;
        b=Vo9XqYqoAROOZqvz61KFpl+urz4JiLx956pPWW4FPoxDEG4H3DvcHq0UAnfwhSNEtd
         AyXrI1brYqlRXtBFRWHwdAcxRL8IqfIX1s1iWk1WYzs1e9d5gkC0SWtRdlPXMuG0sIIT
         FiaY8+zsSmJeBg24kNUE7cj2nDFp8b9HIEiE7cDGrDzp6C/OgM1Ps0BHu85MMQOIWcv4
         oHTQrP/goYXTHj8xNc6hWZtn1ZNL8nwOuzoO0UAbYVMxhXF9zZ1Vm+egZSMxSt9+POwp
         mQNFoOcYwsmJlNVaECahwu05OpzI9x1GJbsLtdX2hw3IPHtpzz738DPHKfjtdmrHVM2K
         ojyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714051419; x=1714656219;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4rnjNjenfTwjulfe8NiDD/HuQ2B2O5By8Tzxa2258wk=;
        b=XBKdq7j79H7JghgNYUOUkq3GwMQJ8IPCWXYb1vfqBhz/TedEmwpgUirXNfVThvLeCo
         f3ImjkBbTeEoK7S632R8yb+p5E+PiJcEeVvXOuh0mtBcWqSs2O8Z0WZnRK/KPrXbPWrD
         WNmV+wMuusiBPx7EurPpdvBXV6gd/9kJO6bFyFU5KDWDWmh04hUA+hhq5uIJTNkcVVX/
         ZjFEQSe1Hm+0xfUuTmH19EUvO1ESMbM9OOY4PWdjTq2HNNdsXirus/fvafFFwqrs9mCa
         cTcgxKTEzex11LGdwIljcSauJPU/XtRJ3qMD3dzIRrRx86zH9jtDn7YqememeBbEXZRn
         lnPQ==
X-Forwarded-Encrypted: i=1; AJvYcCWzSXLxUg+/AmZE6aSsBqfq0zrXMxgP7NmD6B57TBV2KsrUQY3tGJsZiJuhS/FsHNnDmKKA8DfapZsH5V3j58g0wFKg6jc5HSqqx1UL
X-Gm-Message-State: AOJu0YxfbnURM5Pd3rgpjeR9pluYvb6IOL9dhTYXhJNrbNMBJactOm3D
	TB0YdG2QdHKEJjEWfJ6jtVSl1Wa7SdFAfmmEO6XC7XiyBmt5tD3fj79CJzQ7Vw==
X-Google-Smtp-Source: AGHT+IGQgE4up32nxXIDaz9S5N6qgK3mFXrWlujwJLi1C9Z9wCvM86apKS3py4JfB6t9GkbA4djMvQ==
X-Received: by 2002:a17:902:edd0:b0:1ea:2753:2b9f with SMTP id q16-20020a170902edd000b001ea27532b9fmr5225787plk.20.1714051419049;
        Thu, 25 Apr 2024 06:23:39 -0700 (PDT)
Received: from thinkpad ([120.60.75.221])
        by smtp.gmail.com with ESMTPSA id d8-20020a170902b70800b001e4fdcf67desm13749895pls.299.2024.04.25.06.23.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 06:23:38 -0700 (PDT)
Date: Thu, 25 Apr 2024 18:53:30 +0530
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
Subject: Re: [PATCH v11 4/6] arm64: dts: qcom: sm8450: Add OPP table support
 to PCIe
Message-ID: <20240425132330.GD3449@thinkpad>
References: <20240423-opp_support-v11-0-15fdd40b0f95@quicinc.com>
 <20240423-opp_support-v11-4-15fdd40b0f95@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240423-opp_support-v11-4-15fdd40b0f95@quicinc.com>

On Tue, Apr 23, 2024 at 02:36:58PM +0530, Krishna chaitanya chundru wrote:
> PCIe host controller driver needs to choose the appropriate performance
> state of RPMh power domain and interconnect bandwidth based on the PCIe
> data rate.
> 
> Hence, add the OPP table support to specify RPMh performance states and
> interconnect peak bandwidth.
> 
> It should be noted that the different link configurations may share the
> same aggregate bandwidth, e.g., a 2.5 GT/s x2 link and a 5.0 GT/s x1
> link have the same bandwidth and share the same OPP entry.
> 
> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  arch/arm64/boot/dts/qcom/sm8450.dtsi | 77 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 77 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> index 615296e13c43..2e047aba220b 100644
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
> +				/* GEN 1 x1 */
> +				opp-2500000 {
> +					opp-hz = /bits/ 64 <2500000>;
> +					required-opps = <&rpmhpd_opp_low_svs>;
> +					opp-peak-kBps = <250000 1>;
> +				};
> +
> +				/* GEN 2 x1 */
> +				opp-5000000 {
> +					opp-hz = /bits/ 64 <5000000>;
> +					required-opps = <&rpmhpd_opp_low_svs>;
> +					opp-peak-kBps = <500000 1>;
> +				};
> +
> +				/* GEN 3 x1 */
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
> +				/* GEN 1 x1 */
> +				opp-2500000 {
> +					opp-hz = /bits/ 64 <2500000>;
> +					required-opps = <&rpmhpd_opp_low_svs>;
> +					opp-peak-kBps = <250000 1>;
> +				};
> +
> +				/* GEN 1 x2 and GEN 2 x1 */
> +				opp-5000000 {
> +					opp-hz = /bits/ 64 <5000000>;
> +					required-opps = <&rpmhpd_opp_low_svs>;
> +					opp-peak-kBps = <500000 1>;
> +				};
> +
> +				/* GEN 2 x2 */
> +				opp-10000000 {
> +					opp-hz = /bits/ 64 <10000000>;
> +					required-opps = <&rpmhpd_opp_low_svs>;
> +					opp-peak-kBps = <1000000 1>;
> +				};
> +
> +				/* GEN 3 x1 */
> +				opp-8000000 {
> +					opp-hz = /bits/ 64 <8000000>;
> +					required-opps = <&rpmhpd_opp_nom>;
> +					opp-peak-kBps = <984500 1>;
> +				};
> +
> +				/* GEN 3 x2 and GEN 4 x1 */
> +				opp-16000000 {
> +					opp-hz = /bits/ 64 <16000000>;
> +					required-opps = <&rpmhpd_opp_nom>;
> +					opp-peak-kBps = <1969000 1>;
> +				};
> +
> +				/* GEN 4 x2 */
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

