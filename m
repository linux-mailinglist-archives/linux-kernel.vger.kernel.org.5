Return-Path: <linux-kernel+bounces-14975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AA6D82258F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 00:34:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0998B1C21A70
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 23:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 377AA17986;
	Tue,  2 Jan 2024 23:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j09U362r"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE9F17981
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 23:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a285d66a79eso97548466b.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 15:34:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704238444; x=1704843244; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zk6oHVMcIK6wAHvWLyxW6Opf0LhWwnBN+RD7Fzz1+XQ=;
        b=j09U362rZHEiwrIAalDcXl0yd0KQ+jDRCz7nmg2EWocZTKYkg1dtwbrA7Tq5xLbLK9
         /5jhRtLJgHnIkU0T9xOPsm05qnWqX7IG+3Lov792fN8BDmSvvTwJkr6DDkCS1zUAKkuP
         jqUB95uyjHviOC5aNSLGsag0b+212SAyjE0yftUkPKz25a/+6aNRqn0dGJgHuSUzLIc7
         VnynI7aqrNKZAXj3+naLCRwpdd4nXm9CKdOfHMFTD3iJDPBCS78b7zU+xGo/8FwWbgFv
         eNIM1xYA/ZvD1Xvjss9rtTKmtdvTgSL3eqmxHkyrX7lHttwjHmNwkZtsCsHZejm3E5UI
         y83w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704238444; x=1704843244;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zk6oHVMcIK6wAHvWLyxW6Opf0LhWwnBN+RD7Fzz1+XQ=;
        b=Vpu/6oVSiuhBKQwXp4l/CKd20u10yGpBSamyA59q3GLq2Zhi0j2LtkrWBpXLIH+enp
         SWenDdPYm6cjww/7i3bQoeOBJZjHDsftSHSgo21/CgkRGlC+lZeLLdknk6ECWhnCL5vK
         PFJmnTjJbwf8+y93OZOeV4My2mYRM1mZFsBRinmQTmpPrZr9aByCBZxo/+l2AnD4tYw0
         FYqL93ATkiA8Ozo6qiaZb8NmB9AaCVNggXzFgNX6257w8Ln6eJQmZu34UlhscWwX0M3B
         41zBDhRcZwrSiPxjlIBQfPDnvsLgrz7bEdcPiDLmFJ6b/2fImFMq74Zq+b4hzIDPKg/D
         kOHA==
X-Gm-Message-State: AOJu0YzlpB3nQYTdHCn3BOhW7KNldaFSetri30wSe4b8ZjatoCo6Mvaf
	sWpOlhlbw9pyVqeFdaAIAOhG4j1cg4fQYQ==
X-Google-Smtp-Source: AGHT+IEDIWbYuebx/kzhfTbw4i0zNV2fm/AuZ9oe97CUJHNKf5NgUTBvTFrKDjThsWg+6Vrbi+m5NQ==
X-Received: by 2002:a17:906:97:b0:a27:a92a:ec15 with SMTP id 23-20020a170906009700b00a27a92aec15mr2652703ejc.122.1704238443706;
        Tue, 02 Jan 2024 15:34:03 -0800 (PST)
Received: from linaro.org ([79.115.23.25])
        by smtp.gmail.com with ESMTPSA id jt6-20020a170906dfc600b00a234085cfa2sm12187081ejc.190.2024.01.02.15.34.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 15:34:03 -0800 (PST)
Date: Wed, 3 Jan 2024 01:34:01 +0200
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
Subject: Re: [PATCH 4/4] arm64: dts: qcom: x1e80100: Flush RSC sleep & wake
 votes
Message-ID: <ZZSdaXpwqb7jfhQZ@linaro.org>
References: <20240102-topic-x1e_fixes-v1-0-70723e08d5f6@linaro.org>
 <20240102-topic-x1e_fixes-v1-4-70723e08d5f6@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240102-topic-x1e_fixes-v1-4-70723e08d5f6@linaro.org>

On 24-01-02 19:29:50, Konrad Dybcio wrote:
> The RPMh driver will cache sleep and wake votes until the cluster
> power-domain is about to enter idle, to avoid unnecessary writes. So
> associate the apps_rsc with the cluster pd, so that it can be notified
> about this event.
> 
> Without this, only AMC votes are being committed.
> 
> Fixes: af16b00578a7 ("arm64: dts: qcom: Add base X1E80100 dtsi and the QCP dts")
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Reviewed-by: Abel Vesa <abel.vesa@linaro.org>

> ---
>  arch/arm64/boot/dts/qcom/x1e80100.dtsi | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> index fc164b9b3ef1..2a14e8e39b3b 100644
> --- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> +++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> @@ -3334,6 +3334,7 @@ apps_rsc: rsc@17500000 {
>  					  <WAKE_TCS      2>, <CONTROL_TCS   0>;
>  
>  			label = "apps_rsc";
> +			power-domains = <&SYSTEM_PD>;
>  
>  			apps_bcm_voter: bcm-voter {
>  				compatible = "qcom,bcm-voter";
> 
> -- 
> 2.43.0
> 

