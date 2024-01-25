Return-Path: <linux-kernel+bounces-38125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3C9E83BB2E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 09:02:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14FF21C25830
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 08:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D1D017593;
	Thu, 25 Jan 2024 08:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zRw+5CBB"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE03199BE
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 08:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706169670; cv=none; b=WWkW1Mr8NslnWsggfpOlorF0jK8QKSGpAovclSCifVpV3u0eIg5kFTWDEcZoI5yw11sIwB05SEKmrJR8scFHKlQje0PqZ7cBYorZnyMP0yoPYySkmRP/NaTAyzii7LUAxiBl+TDW9w9R/tz2fR8tF3CZajo/vtK8bn6JkMRWP9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706169670; c=relaxed/simple;
	bh=iFYbbyM+nQ0ro0IYJXBv56mfFK+KQxu+c2++uA+eFY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z9kay5QNvuA12EYA6g+f8g4D0ZbES0QvFUjTG9Ja6v6jTI67Nkp9+85MUpfVk0ps7DmRvlqXcKmIrE8p3TdXmjmIrmEm/5fHXMk7qbMEFyMc2TC+yswJt8SikdMQmAFMmIcrBHb9I8aF70yUzpLsYOmM5DIkJoIjngt0qpventI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zRw+5CBB; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-55cdaa96f34so856446a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 00:01:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706169667; x=1706774467; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bdCsaPdfHyF0+3oh1xtxlDB6UHXp/bOH9izBPavO0Fw=;
        b=zRw+5CBBAWKmYIUoPywYgXjybQ6GCCmsRutJvCtJ7Yji7ikUa7myIROnTHYH6F/Ts+
         m4wtcPQItzDQJDWDST0qjuHXL+q39dtJ72g6DEMiV/77FyD9UrZmmxRYzfvbZi6Bp7Xi
         v1O7umg7K0i3C8GBO41UW8u6R4VOhOBv71LQYuQXZzW7LmtggIFKo/CERU7dCTBljdlw
         NuaB/ONTDRX6YYk1OsfWObP/ZyNyw4mlo6pLTWBaIw2xi9CDb6vUm09IahPDF7fL26Sf
         TnNUrC76ItK2QBHa6QPBJFxHqRPj53gcbI8dizuGg8KQAviiL/wHHwRk6H8scLSlI8xt
         09xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706169667; x=1706774467;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bdCsaPdfHyF0+3oh1xtxlDB6UHXp/bOH9izBPavO0Fw=;
        b=AWQQYMY47qxcYms7KUo6y9mMvWqBJEFQr3qTkZgxX8eWvgKuJy3Pp0MD8VZ891tLeu
         1yTyc8OQ6px/JA776AJG1B7RtJmeBXaFT3LcuqU8qEQyokK1iF2716uQC847eAt54RBT
         cF9MXCRzrHNQ7c07pWVOE8n0Tmzi81OZb08DOmCBSkIltjWUqEyL67JrJwqqWsq3f2BB
         /WS1h/MotdpPYjvCR0fmUIc06cEdn0vS+YnRAe61WpxfxA/7KIHzjCtjqdNaYSRZgqJW
         lmG1wsdod55Kc8JXBPFmB4LFagvq1SzoajldHITxbMr2qojfOSO4NlGWqA6IWEm6n1YB
         k7lw==
X-Gm-Message-State: AOJu0Yw9J49SzFiglqg7Ev/C2O7RWOV4DbAcPrBpIsoyioHGsKeMEkWt
	zsDGZBm3+UVxgL/nogw3vM7mB555pYclKzz449vmMJGP/1PHzY0gT7dEID0DVQc=
X-Google-Smtp-Source: AGHT+IEIGh2RPoqSNs6gjgwEeb+4JoGwghNAzOIOwVVQIN9icNRWS861KqVYt0Yby6sWa372ycFsgg==
X-Received: by 2002:a17:906:1b57:b0:a31:7d52:a787 with SMTP id p23-20020a1709061b5700b00a317d52a787mr344859ejg.60.1706169667062;
        Thu, 25 Jan 2024 00:01:07 -0800 (PST)
Received: from linaro.org ([79.115.23.25])
        by smtp.gmail.com with ESMTPSA id dt3-20020a170906b78300b00a2f1888ddecsm736677ejb.166.2024.01.25.00.01.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 00:01:06 -0800 (PST)
Date: Thu, 25 Jan 2024 10:01:05 +0200
From: Abel Vesa <abel.vesa@linaro.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sibi Sankar <quic_sibis@quicinc.com>,
	Rajendra Nayak <quic_rjendra@quicinc.com>,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 08/11] arm64: dts: qcom: x1e80100: Add display nodes
Message-ID: <ZbIVQat9onAlKGWa@linaro.org>
References: <20240123-x1e80100-dts-missing-nodes-v4-0-072dc2f5c153@linaro.org>
 <20240123-x1e80100-dts-missing-nodes-v4-8-072dc2f5c153@linaro.org>
 <07cef0ec-dc18-4cee-a6df-8c7f16600c50@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07cef0ec-dc18-4cee-a6df-8c7f16600c50@linaro.org>

On 24-01-23 19:36:17, Konrad Dybcio wrote:
> 
> 
> On 1/23/24 12:01, Abel Vesa wrote:
> > Add the required nodes to support display on X1E80100.
> > 
> > Co-developed-by: Sibi Sankar <quic_sibis@quicinc.com>
> > Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
> > Co-developed-by: Rajendra Nayak <quic_rjendra@quicinc.com>
> > Signed-off-by: Rajendra Nayak <quic_rjendra@quicinc.com>
> > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > ---
> >   arch/arm64/boot/dts/qcom/x1e80100.dtsi | 518 +++++++++++++++++++++++++++++++++
> >   1 file changed, 518 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> > index e8d2ea2b26ed..247ff7a9e405 100644
> > --- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> > @@ -4,6 +4,7 @@
> >    */
> >   #include <dt-bindings/clock/qcom,rpmh.h>
> > +#include <dt-bindings/clock/qcom,x1e80100-dispcc.h>
> >   #include <dt-bindings/clock/qcom,x1e80100-gcc.h>
> >   #include <dt-bindings/clock/qcom,x1e80100-tcsr.h>
> >   #include <dt-bindings/dma/qcom-gpi.h>
> > @@ -3298,6 +3299,523 @@ usb_1_ss1_role_switch: endpoint {
> >   			};
> >   		};
> > +		mdss: display-subsystem@ae00000 {
> > +			compatible = "qcom,x1e80100-mdss";
> > +			reg = <0 0x0ae00000 0 0x1000>;
> > +			reg-names = "mdss";
> > +
> > +			interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
> > +
> > +			clocks = <&dispcc DISP_CC_MDSS_AHB_CLK>,
> > +				 <&gcc GCC_DISP_AHB_CLK>,
> > +				 <&gcc GCC_DISP_HF_AXI_CLK>,
> > +				 <&dispcc DISP_CC_MDSS_MDP_CLK>;
> > +
> > +			resets = <&dispcc DISP_CC_MDSS_CORE_BCR>;
> > +
> > +			interconnects = <&mmss_noc MASTER_MDP QCOM_ICC_TAG_ALWAYS
> > +					 &gem_noc SLAVE_LLCC QCOM_ICC_TAG_ALWAYS>,
> > +					<&mc_virt MASTER_LLCC QCOM_ICC_TAG_ALWAYS
> > +					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>;
> > +			interconnect-names = "mdp0-mem",
> > +					     "mdp1-mem";
> 
> You likely also want to add the cpu-cfg path
> 
> [...]
> 
> > +
> > +		dispcc: clock-controller@af00000 {
> > +			compatible = "qcom,x1e80100-dispcc";
> > +			reg = <0 0x0af00000 0 0x20000>;
> > +			clocks = <&bi_tcxo_div2>,
> > +				 <&bi_tcxo_ao_div2>,
> > +				 <&gcc GCC_DISP_AHB_CLK>,
> 
> This clock is not actually registered with the CCF.. Which means it's
> also never cleanly shut down.. Please fix the clock driver and check
> which others got omitted as well.
> 

Right, so this clock is actually enabled on probe and is expected to be
always-on.

And I just noticed that at least on SM8[456]50 it's the same.

So I guess the solution here is to drop it from the dt node and fix the
dt schema. For all these platforms.

> > +				 <&sleep_clk>,
> > +				 <0>, /* dsi0 */
> > +				 <0>,
> > +				 <0>, /* dsi1 */
> > +				 <0>,
> > +				 <&usb_1_ss0_qmpphy QMP_USB43DP_DP_LINK_CLK>, /* dp0 */
> > +				 <&usb_1_ss0_qmpphy QMP_USB43DP_DP_VCO_DIV_CLK>,
> > +				 <&usb_1_ss1_qmpphy QMP_USB43DP_DP_LINK_CLK>, /* dp1 */
> > +				 <&usb_1_ss1_qmpphy QMP_USB43DP_DP_VCO_DIV_CLK>,
> > +				 <&mdss_dp2_phy 0>, /* dp2 */
> > +				 <&mdss_dp2_phy 1>,
> > +				 <&mdss_dp3_phy 0>, /* dp3 */
> > +				 <&mdss_dp3_phy 1>;
> > +			power-domains = <&rpmhpd RPMHPD_MMCX>;
> 
> Likely:
> 
> required-opps = <&rpmhpd_opp_low_svs>;
> 
> so that the PLLs have a chance to spin up
> 
> Konrad

