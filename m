Return-Path: <linux-kernel+bounces-147268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77A098A71C3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 18:57:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33AF62843B0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 16:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 064C9130AE6;
	Tue, 16 Apr 2024 16:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xb5J9BNu"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C4F86255
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 16:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713286667; cv=none; b=B5WjXwm7Q0OLpP9RABjXldwZVegxPeQIdpKWcz6uEcFwyGobB5IXv3h+Isez4JNCNBh6VurIEzdW9hW8kJUbxkmiPu4PaUHScjRU1nCJ+VrjOSUxu+XUa0Cfwm7KdsqiClaCKpPsl9uYMmrsFBLzkIXxYz9pcB6zkJO8bDQDnTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713286667; c=relaxed/simple;
	bh=8B8T20wTCBW9BOKM/mQM//HuSXmdcJjW0wYxFxTR0RQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QH/IziCtmKn90ULxwlVaX56FK35oxIaHAarnXgn+tMMYbEBqIk/v/DGGnb0tX5SN6sY3WXHJtSrf0CrFSw+OHcmVpeyIs+/1FiK32T04NJE0F2EImKFLOcCnAjj4jQ03XrmcW+kAev7FqwgOb8rLm2wZzgwdMPGLOxc5UNx5svE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xb5J9BNu; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2a559928f46so2712262a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 09:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713286664; x=1713891464; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Rw1srMaM4ShVIEeEfySOxO+TrGv+HQPY/srdrVtHzS4=;
        b=xb5J9BNuJBwh6vNFAo2V3VJB50/6zhGP1aJZZBz3WqRgiRjWkbJD3wPzACia3Sc2xQ
         2b3MaOVq2WiCsmArXaS371Prtkm2OwbzEM22PpOYyyCk2xcbPjxs5gxYwWxQpH805nOI
         JMPRfXwdzibtN8Wj6Iii9Hjs+hc3z8k5Iyyd1pK/fh9BU9Ahlxf2LZC0VzF5eZYT9RYw
         qV5ehu8YmQGjQnKvmBpCPUbKoSgj2uv3vO9NjhoZZFjXe4ahX1IdK+7+UWwcfJhJpuo1
         SIZe+XENvdp/X1SR4DJ7nHXioPzdzjeK/SXdsMlu5HtXokDmiukEzXh2jMVor80Rhw87
         UdqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713286664; x=1713891464;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rw1srMaM4ShVIEeEfySOxO+TrGv+HQPY/srdrVtHzS4=;
        b=jSuPCv+fmV6PFI+eq0GMfVA9ou9cnTz/X7ujuJbMo7dEvrWH/GvycRlAcvaZEv0REN
         ZYCZz/Ocpu6wKz1iKNAV07go1DNCivC7KM5OEqAFOEyqMfGE90AvbC1t6qP6j3u8jatj
         A/COXxfmjHW2z4Mu1j0xqgIpNYwp2x4uPWwx3QUhDtLKcVIfDrV8kN8VjGwaw3QLxNMj
         JY2CWrqIME108p3JVk9GLDLUBTOv6Hv+sXs1TftG3vZzGfwZXLMil5pV0OT5TQ4uWYPS
         z9t1ut6gL50x4eXVrGh/Bfm01kVmbkQZSvvY3KWCA+b5bOgiw1tik9kqEeM67DLE24gf
         iWQw==
X-Forwarded-Encrypted: i=1; AJvYcCUDjTpJJiMpn7xkMlPLtnKNVg5XyKj3ikwD3iUc84Pd/xkoGQd1LFB8wXWCfgVttAHRjN9fRT1+rTFBYtH8168SFVZHc9WOYykXHD1H
X-Gm-Message-State: AOJu0Yz4CQju14OrHPFVOnZ+Rewxr1mG0uOvhTclhHqiII6LLo+DFmP6
	Zt7s/jqtdfjZPEyTVDfj3Htpz47/Stac1IVYB73IyBxWQMkCfR9SoLSQz+OE/Yc=
X-Google-Smtp-Source: AGHT+IEp84o6IK282BkD3qXrX+vMTGaXMfMKPn9YJTqjKw0JZ1i5GYptiKbnVjjF3JOST3nhPrPtyQ==
X-Received: by 2002:a17:90a:34ce:b0:2aa:ead0:900c with SMTP id m14-20020a17090a34ce00b002aaead0900cmr1113127pjf.24.1713286664143;
        Tue, 16 Apr 2024 09:57:44 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:6e4e:6aac:cff6:726e])
        by smtp.gmail.com with ESMTPSA id ei18-20020a17090ae55200b002a2559fe52esm9147190pjb.56.2024.04.16.09.57.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 09:57:43 -0700 (PDT)
Date: Tue, 16 Apr 2024 10:57:40 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Tanmay Shah <tanmay.shah@amd.com>
Cc: andersson@kernel.org, robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	michal.simek@amd.com, ben.levinsky@amd.com,
	linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v15 3/4] dts: zynqmp: add properties for TCM in remoteproc
Message-ID: <Zh6uBDdyiTnSvrhg@p14s>
References: <20240412183708.4036007-1-tanmay.shah@amd.com>
 <20240412183708.4036007-4-tanmay.shah@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240412183708.4036007-4-tanmay.shah@amd.com>

On Fri, Apr 12, 2024 at 11:37:07AM -0700, Tanmay Shah wrote:
> Add properties as per new bindings in zynqmp remoteproc node
> to represent TCM address and size.
> 
> This patch also adds alternative remoteproc node to represent
> remoteproc cluster in split mode. By default lockstep mode is
> enabled and users should disable it before using split mode
> dts. Both device-tree nodes can't be used simultaneously one
> of them must be disabled. For zcu102-1.0 and zcu102-1.1 board
> remoteproc split mode dts node is enabled and lockstep mode
> dts is disabled.
> 
> Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
> ---
>  .../boot/dts/xilinx/zynqmp-zcu102-rev1.0.dts  |  8 +++
>  arch/arm64/boot/dts/xilinx/zynqmp.dtsi        | 67 +++++++++++++++++--
>  2 files changed, 70 insertions(+), 5 deletions(-)
>

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-rev1.0.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-rev1.0.dts
> index c8f71a1aec89..495ca94b45db 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-rev1.0.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-rev1.0.dts
> @@ -14,6 +14,14 @@ / {
>  	compatible = "xlnx,zynqmp-zcu102-rev1.0", "xlnx,zynqmp-zcu102", "xlnx,zynqmp";
>  };
>  
> +&rproc_split {
> +	status = "okay";
> +};
> +
> +&rproc_lockstep {
> +	status = "disabled";
> +};
> +
>  &eeprom {
>  	#address-cells = <1>;
>  	#size-cells = <1>;
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> index 25d20d803230..ef31b0fc73d1 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> @@ -260,19 +260,76 @@ fpga_full: fpga-full {
>  		ranges;
>  	};
>  
> -	remoteproc {
> +	rproc_lockstep: remoteproc@ffe00000 {
>  		compatible = "xlnx,zynqmp-r5fss";
>  		xlnx,cluster-mode = <1>;
> +		xlnx,tcm-mode = <1>;
>  
> -		r5f-0 {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +
> +		ranges = <0x0 0x0 0x0 0xffe00000 0x0 0x10000>,
> +			 <0x0 0x20000 0x0 0xffe20000 0x0 0x10000>,
> +			 <0x0 0x10000 0x0 0xffe10000 0x0 0x10000>,
> +			 <0x0 0x30000 0x0 0xffe30000 0x0 0x10000>;
> +
> +		r5f@0 {
> +			compatible = "xlnx,zynqmp-r5f";
> +			reg = <0x0 0x0 0x0 0x10000>,
> +			      <0x0 0x20000 0x0 0x10000>,
> +			      <0x0 0x10000 0x0 0x10000>,
> +			      <0x0 0x30000 0x0 0x10000>;
> +			reg-names = "atcm0", "btcm0", "atcm1", "btcm1";
> +			power-domains = <&zynqmp_firmware PD_RPU_0>,
> +					<&zynqmp_firmware PD_R5_0_ATCM>,
> +					<&zynqmp_firmware PD_R5_0_BTCM>,
> +					<&zynqmp_firmware PD_R5_1_ATCM>,
> +					<&zynqmp_firmware PD_R5_1_BTCM>;
> +			memory-region = <&rproc_0_fw_image>;
> +		};
> +
> +		r5f@1 {
> +			compatible = "xlnx,zynqmp-r5f";
> +			reg = <0x1 0x0 0x0 0x10000>, <0x1 0x20000 0x0 0x10000>;
> +			reg-names = "atcm0", "btcm0";
> +			power-domains = <&zynqmp_firmware PD_RPU_1>,
> +					<&zynqmp_firmware PD_R5_1_ATCM>,
> +					<&zynqmp_firmware PD_R5_1_BTCM>;
> +			memory-region = <&rproc_1_fw_image>;
> +		};
> +	};
> +
> +	rproc_split: remoteproc-split@ffe00000 {
> +		status = "disabled";
> +		compatible = "xlnx,zynqmp-r5fss";
> +		xlnx,cluster-mode = <0>;
> +		xlnx,tcm-mode = <0>;
> +
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +
> +		ranges = <0x0 0x0 0x0 0xffe00000 0x0 0x10000>,
> +			 <0x0 0x20000 0x0 0xffe20000 0x0 0x10000>,
> +			 <0x1 0x0 0x0 0xffe90000 0x0 0x10000>,
> +			 <0x1 0x20000 0x0 0xffeb0000 0x0 0x10000>;
> +
> +		r5f@0 {
>  			compatible = "xlnx,zynqmp-r5f";
> -			power-domains = <&zynqmp_firmware PD_RPU_0>;
> +			reg = <0x0 0x0 0x0 0x10000>, <0x0 0x20000 0x0 0x10000>;
> +			reg-names = "atcm0", "btcm0";
> +			power-domains = <&zynqmp_firmware PD_RPU_0>,
> +					<&zynqmp_firmware PD_R5_0_ATCM>,
> +					<&zynqmp_firmware PD_R5_0_BTCM>;
>  			memory-region = <&rproc_0_fw_image>;
>  		};
>  
> -		r5f-1 {
> +		r5f@1 {
>  			compatible = "xlnx,zynqmp-r5f";
> -			power-domains = <&zynqmp_firmware PD_RPU_1>;
> +			reg = <0x1 0x0 0x0 0x10000>, <0x1 0x20000 0x0 0x10000>;
> +			reg-names = "atcm0", "btcm0";
> +			power-domains = <&zynqmp_firmware PD_RPU_1>,
> +					<&zynqmp_firmware PD_R5_1_ATCM>,
> +					<&zynqmp_firmware PD_R5_1_BTCM>;
>  			memory-region = <&rproc_1_fw_image>;
>  		};
>  	};
> -- 
> 2.25.1
> 

