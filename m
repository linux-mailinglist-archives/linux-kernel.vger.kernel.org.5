Return-Path: <linux-kernel+bounces-14973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9C91822588
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 00:33:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38DAE1F23439
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 23:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 941161775F;
	Tue,  2 Jan 2024 23:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BOxMgSO6"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1B217985
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 23:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2cd10001532so13963001fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 15:33:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704238414; x=1704843214; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=idbn+oW+ru79HvN1qxo/ff+LJhpYNwODr6kmnulljN4=;
        b=BOxMgSO6Ua3dcWWtt/6WKfOXsHqM0wbe30ijg71RaFyfkjZY2WATTG18j5BQE2jQFh
         7QB0Rm7+m4GfQ3+w/hDHM+/emEdSVIUOroiRav+SGenN9q68MCiHMm1hnwf/tWKXHSgB
         WJ+JK9xj4DwIPnz9bAaiXXdx4348AYGOtl0JBZYbDcbLVSQF2cxAVT4D6frXkeHjILam
         Eb4zJXKCPg4B8fNAbTfpVsjVETBA9EjOyWIPBrnODt1ImHlD6JI4e4MGLw3N/dd6WuLA
         GuIkvY1A6q9Yhv5u1hlP0SA7OGfrBDZAtWCTZdynbpSiAEOWfMHtvaQapkia5TV1lQA+
         qG6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704238414; x=1704843214;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=idbn+oW+ru79HvN1qxo/ff+LJhpYNwODr6kmnulljN4=;
        b=ms8jVPUKLwUDytqi5NMoU8db9/xBNj6Bl2TIPT6I67Zid9tLdDij8s2L+MQ5BnVJ0n
         tuwQLaUztrCcMldjxGU9NxLuFMyN40+b3dQaPQ8D7n+zB1RHAW+3nClRiMA5LPR3CPP5
         jNIApwu7L95CW0fRedlyUl+Mo9aUal1O6IJm4a9NcHFbheocXlo443Zm4aVkZQNI1hGJ
         /Wiwr88071ZGXnlWYF8XUXadXQ7FqIASJQPyOvSpvjHjzsbby1kWLyexooh3p1i1yEVQ
         8YMGNp4VSN4BuXfsx9nAdUZsqTu+Z5HDxZAWx7Mh6AsYWtR+qw2hHLpYPbynzgrN9JzI
         PeCQ==
X-Gm-Message-State: AOJu0YysWtv9q32IBeVQ0V6u14RSbZB61j4DhC5+ZCbSgdfWRUvDgGh5
	WLPfFRh59avmtrDdEyuej5S/72Rdhtl21w==
X-Google-Smtp-Source: AGHT+IF4WB/wHeBDxLZQA+hq3pgf2KuxfIsCfu9z6Ah8FS7+nNNRGyvvP5PeHgFRmdJA9/e5eBvpcw==
X-Received: by 2002:a2e:88cf:0:b0:2cc:dbbe:7c55 with SMTP id a15-20020a2e88cf000000b002ccdbbe7c55mr4684881ljk.94.1704238414248;
        Tue, 02 Jan 2024 15:33:34 -0800 (PST)
Received: from linaro.org ([79.115.23.25])
        by smtp.gmail.com with ESMTPSA id t25-20020a056402241900b00553b6b5bb44sm16499540eda.67.2024.01.02.15.33.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 15:33:33 -0800 (PST)
Date: Wed, 3 Jan 2024 01:33:32 +0200
From: Abel Vesa <abel.vesa@linaro.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Georgi Djakov <djakov@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Rajendra Nayak <quic_rjendra@quicinc.com>,
	Sibi Sankar <quic_sibis@quicinc.com>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 3/4] arm64: dts: qcom: x1e80100: Add missing system-wide
 PSCI power domain
Message-ID: <ZZSdTKe/aw2M1/2X@linaro.org>
References: <20240102-topic-x1e_fixes-v1-0-70723e08d5f6@linaro.org>
 <20240102-topic-x1e_fixes-v1-3-70723e08d5f6@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240102-topic-x1e_fixes-v1-3-70723e08d5f6@linaro.org>

On 24-01-02 19:29:49, Konrad Dybcio wrote:
> Previous Qualcomm SoCs over the past couple years have used the Arm DSU
> architecture, which basically unified the meaning of the "cluster" and
> "system". This is however clearly not the case on X1E, as can be seen
> by three separate cluster power domains.
> 
> Add the lacking system-level power domain. For now it's going to be
> always-on, as no system-wide idle states are defined at the moment.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Reviewed-by: Abel Vesa <abel.vesa@linaro.org>

> ---
>  arch/arm64/boot/dts/qcom/x1e80100.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> index 6f75fc342ceb..fc164b9b3ef1 100644
> --- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> +++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> @@ -395,16 +395,24 @@ CPU_PD11: power-domain-cpu11 {
>  		CLUSTER_PD0: power-domain-cpu-cluster0 {
>  			#power-domain-cells = <0>;
>  			domain-idle-states = <&CLUSTER_CL4>, <&CLUSTER_CL5>;
> +			power-domains = <&SYSTEM_PD>;
>  		};
>  
>  		CLUSTER_PD1: power-domain-cpu-cluster1 {
>  			#power-domain-cells = <0>;
>  			domain-idle-states = <&CLUSTER_CL4>, <&CLUSTER_CL5>;
> +			power-domains = <&SYSTEM_PD>;
>  		};
>  
>  		CLUSTER_PD2: power-domain-cpu-cluster2 {
>  			#power-domain-cells = <0>;
>  			domain-idle-states = <&CLUSTER_CL4>, <&CLUSTER_CL5>;
> +			power-domains = <&SYSTEM_PD>;
> +		};
> +
> +		SYSTEM_PD: power-domain-system {
> +			#power-domain-cells = <0>;
> +			/* TODO: system-wide idle states */
>  		};
>  	};
>  
> 
> -- 
> 2.43.0
> 

