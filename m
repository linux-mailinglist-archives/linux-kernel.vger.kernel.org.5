Return-Path: <linux-kernel+bounces-104705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D6F0387D296
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 18:19:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2BCFB233C8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 17:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9752482EB;
	Fri, 15 Mar 2024 17:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dfp/7Zfj"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CAD14CB4E
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 17:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710523151; cv=none; b=pIzylUTy0OjEfcDADlFMK7ZHXlkPj4gSObF5JZeEZxRW8LltLwVHPz3idn+KWM9A4IYF3jdHNfzPS+tXNtNJME5TIdgPRKvLdkPMq7cRqNr/FCrs0/HDUhiZ183+13koNLLzeY92qDdJqASedRxG/SCly5LlQYZJgxGnAduW4Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710523151; c=relaxed/simple;
	bh=qRK4ZscALIRnI/Of3VT62asNNrLU4CTGdfxsnMiJ6ig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=en93v4KE6EVPNqLDLbPLr8TMLdV54Z201soBlLMc4M2hXH2hPRZBCMhXT7OtNAMLmHoDveH562bxZm9Q4k0ogwR3q+nWabWWOKkKPy0UwVZLd6oUX5gHjpOIqVGxoKHy97jjr42QhMoXWyZVNlI5NDMxrM9eywW19abxdIjJI3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dfp/7Zfj; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-568aa3096e9so1888746a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 10:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710523148; x=1711127948; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fEn2MW7lH3siih5lbV/O0t/j/pQJQRG/TR3SpZhG1N8=;
        b=dfp/7ZfjRIbRZgBgi/aA7nv7ikTSI3xoqqaKa42/AFgofuyLNVvm8nWhxS7C5apUXH
         HR9ykbpLR66F8IyZLRjc4r+47Mmg4KhZC+I7YvJMIXkm1fv2etmu3kA7J2WxfQKlF0tz
         YwvkHrn+A5j1HUzu2mShEsyybQAZ/nkAcP+NtGluzb5eQSD07l9Y0CTLtT7uWA5cY6pf
         tjAecw3QrQqsRQcJ2ayN55q5zhFKX1Y3pl0TezVR8su3TU5wGjfWGxTvZr7yHS5N8H+j
         vWr7fhOvztDSDkud6j1ohMGEizY6DWY/8PjERo7iRAAXVh3/6JmwhNGbu9B3pTvqumwp
         52CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710523148; x=1711127948;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fEn2MW7lH3siih5lbV/O0t/j/pQJQRG/TR3SpZhG1N8=;
        b=lGmjb/I4amEb+CjSxhyqylGV3WBfWZ/hZw45E/RZNm2EqGQvxQDT8jn1J6y3TiKsOM
         IfUlSCZV5Lrkrf/B2banb+FrVeW2loVkgDkbhXtlfCNU1orPYEz24yxbFnGbQg9/XNnP
         +Ja0fGx03TrGiZ3x+J2SmoWjKC+JNbgDz2bWMHNedAdfkTpI6O4UpbXOI4AIwXnjzVWc
         4hpEBSlFfwe5eLsf++VhTgHQuCGJf4Bx2sXKyH2/M3Sz93NHMBvZ3KteIL9f/rxedPgr
         6L5mthl/B7ruTkHAdjNmmdKuZT+uE2HqwlXNQfUapLywqSGxWImVxFKNuHdglXuAAzny
         sDaw==
X-Forwarded-Encrypted: i=1; AJvYcCVtVE2Ma7dIHMjZvCe60lCc4O8SXlFIzVjExDYbDRJ9FhI9q+Lr3wH7ef9uRnbvwlor5nUFj4gSJLn+7CUWQ+7UnULXfEWIJ+zt78BT
X-Gm-Message-State: AOJu0YzNlELnvOkmXULbIiH+vSNr6SztF4zssbf1fFE4FthY/5XKRcs9
	S1C9UA7oIdohY8pgw8Cnv170FyeKt+D5xV7Btz4koiLn76Z40vs0MsA6dGZ0Y1k=
X-Google-Smtp-Source: AGHT+IF7nk0Cxpc8FXrSI4MRq1X8DD2Pewv4xFgdhyWLGeBmwN6KKB6qOdZcg4exb9NBjfEg8gqdog==
X-Received: by 2002:a17:906:2bd3:b0:a46:268b:228a with SMTP id n19-20020a1709062bd300b00a46268b228amr8356154ejg.29.1710523147749;
        Fri, 15 Mar 2024 10:19:07 -0700 (PDT)
Received: from linaro.org ([188.24.162.93])
        by smtp.gmail.com with ESMTPSA id d10-20020a170907272a00b00a44ef54b6b6sm1887264ejl.58.2024.03.15.10.19.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Mar 2024 10:19:07 -0700 (PDT)
Date: Fri, 15 Mar 2024 19:19:05 +0200
From: Abel Vesa <abel.vesa@linaro.org>
To: Rajendra Nayak <quic_rjendra@quicinc.com>
Cc: andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	quic_sibis@quicinc.com, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: Fix the compatible for cluster idle
 states
Message-ID: <ZfSDCZ0g0ZN7SIPB@linaro.org>
References: <20240315132423.2422484-1-quic_rjendra@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240315132423.2422484-1-quic_rjendra@quicinc.com>

On 24-03-15 18:54:23, Rajendra Nayak wrote:
> The compatible's for the cluster/domain idle states of x1e80100
> are wrong, fix it.
> 
> Fixes: af16b00578a7 ("arm64: dts: qcom: Add base X1E80100 dtsi and the QCP dts")
> Signed-off-by: Rajendra Nayak <quic_rjendra@quicinc.com>

Reviewed-by: Abel Vesa <abel.vesa@linaro.org>

> ---
>  arch/arm64/boot/dts/qcom/x1e80100.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> index 8e517f76189e..6b40082bac68 100644
> --- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> +++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> @@ -284,7 +284,7 @@ CLUSTER_C4: cpu-sleep-0 {
>  
>  		domain-idle-states {
>  			CLUSTER_CL4: cluster-sleep-0 {
> -				compatible = "arm,idle-state";
> +				compatible = "domain-idle-state";
>  				idle-state-name = "l2-ret";
>  				arm,psci-suspend-param = <0x01000044>;
>  				entry-latency-us = <350>;
> @@ -293,7 +293,7 @@ CLUSTER_CL4: cluster-sleep-0 {
>  			};
>  
>  			CLUSTER_CL5: cluster-sleep-1 {
> -				compatible = "arm,idle-state";
> +				compatible = "domain-idle-state";
>  				idle-state-name = "ret-pll-off";
>  				arm,psci-suspend-param = <0x01000054>;
>  				entry-latency-us = <2200>;
> -- 
> 2.34.1
> 

