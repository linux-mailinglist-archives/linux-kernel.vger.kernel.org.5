Return-Path: <linux-kernel+bounces-148055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 365E98A7D21
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 09:34:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5994C1C21096
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 07:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFD4874267;
	Wed, 17 Apr 2024 07:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JA/R5b9D"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 956DE6CDA1
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 07:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713339263; cv=none; b=DqaCM4paq6tvmYSrCSZtfqgc+fHnR8C0vhxhzsYdziU/DVGklGI0TxtkVGlJq04ipy5JCwiibIR6RxbHTyutA+fBARd2e0/Bv0gmGqLKUVSMJzhGzeak9imWk9pecRy6xLQ23wzLARhTavePX70vSekBOgf3NmlCPgEB/0mski4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713339263; c=relaxed/simple;
	bh=fgddyO9hlvexv3nlt/MmFf5mf73RtUyfjBgF9PLA0kg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rmvuQ5x/KeALOcZ4lTXeLBbns6HoXbkeu1UsZGQaalHaBf/SqJ+W5XcZ1BExCkzZV8t37q1p4Shq0xXVaHM4epG7XG6VkumeMFJuJ0z7mmLLwBQaMSirlG4zKw78nHuM3Clo6F+Po7zz9j3mvc7E05lBngz4SpLYaKSwlbBTHCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JA/R5b9D; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2ab1ddfded1so418052a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 00:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713339260; x=1713944060; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0K72Tz2ZkclPVJuZv0gvxvgq7QFl2/X172+ji7HZ4mc=;
        b=JA/R5b9DKPHtNh7eCmyBdgs/Cd1Z5NmKNPCI8QBvuLiXAMm+bIhnxqEN/X76248HE+
         FpsgCz+eQNHIV48SxxcsKRdaMlxrW5dyAuv9o2j0Swa7R+D+WXhzqa8ccM+jSy9MQLUI
         JtEcDtzLCx9xbwdBZMAmn/N9g2ynSj/SMo22CoF2l7cfzYBwvTpNwJS5HOaj1Pgy2W6P
         p9pJj1quHVlFxo0d5/OJwMfLc5JVNPEreVZsHp5tjcbvTm5/0sMohBMY9KVtXiPTZ/CV
         Zj5FS1BgGyK/f3TE/3gpOKbPrRGQOXpyDiYBiqfUIBVx1tEhb1jQ9qwNTY3QmiGfk9/W
         gVJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713339260; x=1713944060;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0K72Tz2ZkclPVJuZv0gvxvgq7QFl2/X172+ji7HZ4mc=;
        b=kaocn3KFRPT3uqZe3MwW990LeGm7eP5po7/wXl+nTEvds02HPhTA0Gk0mXcP5D862o
         CX23+kKWXzHt3iVRMxBJnFNQJgMDR4NbqgTPw5vQobD2npV7H7Ju4PRMUXogN2xwLWgh
         HXInQx8dzHhquiqbipwCEed5u463obHN+/G9HXrxDpe7oW5wMWZSXvzQOXy/1Mb2InVK
         TkR4yXCN72SED4CpVJvyCQV2hwE2/fV7L5q4HBitDVCFO9gVb96LvS0QOe6m7szyIMU4
         4EIFqF+qRE581+/RFXvSiqxv+ZTxqQXQn7MIAYmc8ChowJ+QEcoYnZNOBaSyNGNvl0tJ
         WJAA==
X-Forwarded-Encrypted: i=1; AJvYcCWrVab7YnICyoCtBbh3WGV6HKxBWkkF9TgC5DnPYo3nfXeQue0PMuXpQ6muY9NKr6dDBxyPqNS+YqS++mGw16trCrpIPSsvaudHrTCa
X-Gm-Message-State: AOJu0YwEbv0G7nTDJhoHHalB7LxqbbAYISrkVsBtMW+WHPzxiHJUDkQo
	yhobe3o5NNazoLtCaOQDtVwZf0sbfbQxpU5H7SKUCcC1pvUNBM9VSA1e2gqhPQ==
X-Google-Smtp-Source: AGHT+IGIAgoL/zhZk3pa0SMj5BgxpoFiLpBLAx6xC/5k4oCxlIq9Bo6Xf+jtd58QVgNCbJOeHuSBkQ==
X-Received: by 2002:a17:90b:3c3:b0:2a6:db3:1aa5 with SMTP id go3-20020a17090b03c300b002a60db31aa5mr15282164pjb.18.1713339259756;
        Wed, 17 Apr 2024 00:34:19 -0700 (PDT)
Received: from thinkpad ([120.60.54.9])
        by smtp.gmail.com with ESMTPSA id e3-20020a17090a728300b002a2b28de64esm742387pjg.14.2024.04.17.00.34.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 00:34:19 -0700 (PDT)
Date: Wed, 17 Apr 2024 13:04:12 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Alexandru Gagniuc <mr.nuke.me@gmail.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
	linux-clk@vger.kernel.org
Subject: Re: [PATCH v3 7/7] arm64: dts: qcom: ipq9574: add PCIe2 nodes
Message-ID: <20240417073412.GD3894@thinkpad>
References: <20240415182052.374494-1-mr.nuke.me@gmail.com>
 <20240415182052.374494-8-mr.nuke.me@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240415182052.374494-8-mr.nuke.me@gmail.com>

On Mon, Apr 15, 2024 at 01:20:52PM -0500, Alexandru Gagniuc wrote:
> On ipq9574, there are 4 PCIe controllers. Describe the pcie2 node, and
> its PHY in devicetree.
> 
> Only pcie2 is described, because only hardware using that controller
> was available for testing.
> 

You should describe all the instances in DT. Since the unused ones will be
'disabled', it won't affect anyone.

> Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
> ---
>  arch/arm64/boot/dts/qcom/ipq9574.dtsi | 93 ++++++++++++++++++++++++++-
>  1 file changed, 92 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/ipq9574.dtsi b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
> index 7f2e5cbf3bbb..f075e2715300 100644
> --- a/arch/arm64/boot/dts/qcom/ipq9574.dtsi
> +++ b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
> @@ -300,7 +300,7 @@ gcc: clock-controller@1800000 {
>  				 <0>,
>  				 <0>,
>  				 <0>,
> -				 <0>,
> +				 <&pcie2_phy>,
>  				 <0>,
>  				 <0>;
>  			#clock-cells = <1>;
> @@ -745,6 +745,97 @@ frame@b128000 {
>  				status = "disabled";
>  			};
>  		};
> +
> +		pcie2_phy: phy@8c000 {
> +			compatible = "qcom,ipq9574-qmp-gen3x2-pcie-phy";
> +			reg = <0x0008c000 0x14f4>;
> +
> +			clocks = <&gcc GCC_PCIE2_AUX_CLK>,
> +				 <&gcc GCC_PCIE2_AHB_CLK>,
> +				 <&gcc GCC_PCIE2_PIPE_CLK>,
> +				 <&gcc GCC_ANOC_PCIE2_2LANE_M_CLK>,
> +				 <&gcc GCC_SNOC_PCIE2_2LANE_S_CLK>;
> +			clock-names = "aux",
> +				      "cfg_ahb",
> +				      "pipe",
> +				      "anoc",
> +				      "snoc";
> +
> +			clock-output-names = "pcie_phy2_pipe_clk";
> +			#clock-cells = <0>;
> +			#phy-cells = <0>;
> +
> +			resets = <&gcc GCC_PCIE2_PHY_BCR>,
> +				 <&gcc GCC_PCIE2PHY_PHY_BCR>;
> +			reset-names = "phy",
> +				      "common";
> +			status = "disabled";
> +		};
> +
> +		pcie2: pcie@20000000 {
> +			compatible = "qcom,pcie-ipq9574";
> +			reg = <0x20000000 0xf1d>,
> +			      <0x20000f20 0xa8>,
> +			      <0x20001000 0x1000>,
> +			      <0x00088000 0x4000>,
> +			      <0x20100000 0x1000>;
> +			reg-names = "dbi", "elbi", "atu", "parf", "config";
> +
> +			ranges = <0x81000000 0x0 0x20200000 0x20200000 0x0 0x00100000>,	/* I/O */

Please use below range:

<0x01000000 0x0 0x00000000 0x20200000 0x0 0x00100000>
<0x02000000 0x0 0x20300000 0x20300000 0x0 0x07d00000>

> +				 <0x82000000 0x0 0x20300000 0x20300000 0x0 0x07d00000>;	/* MEM */
> +
> +			device_type = "pci";
> +			linux,pci-domain = <3>;
> +			bus-range = <0x00 0xff>;
> +			num-lanes = <2>;
> +			max-link-speed = <3>;
> +			#address-cells = <3>;
> +			#size-cells = <2>;
> +
> +			phys = <&pcie2_phy>;
> +			phy-names = "pciephy";
> +
> +			interrupts = <GIC_SPI 126 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "msi";
> +
> +			#interrupt-cells = <1>;
> +			interrupt-map-mask = <0 0 0 0x7>;
> +			interrupt-map = <0 0 0 1 &intc 0 0 164
> +					 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
> +					<0 0 0 2 &intc 0 0 165
> +					 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
> +					<0 0 0 3 &intc 0 0 186
> +					 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
> +					<0 0 0 4 &intc 0 0 187
> +					 IRQ_TYPE_LEVEL_HIGH>; /* int_d */

Use a single line for each INTX entry even if it exceeds 80 column width.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

