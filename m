Return-Path: <linux-kernel+bounces-63970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D3E378536F5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 18:14:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DFF31F28F9A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 17:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 673BB5FDB5;
	Tue, 13 Feb 2024 17:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HiYNNylG"
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2335FF01
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 17:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707844465; cv=none; b=aA2tmQXnvPrvs5TgNHtQzQ+bTzpT2w3DNZoc7wcTxBB0y/tv6Qx8PT/IuNMCiipeUZmdgjKNUoFccE60Z7JHbucPWzPdhQzkyEqQDhD+PCbQ4LMMqtJmqAjoZWTcRyNT9wkjE9ptqdm/joPxT16jDxO7efU3SZECT9EjVOlfbvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707844465; c=relaxed/simple;
	bh=tcxnntMDjTGlm2TP7peUr1fDpFlSE77ShltMlTMyXiI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AMvomLasDLa8Ld/bMNEnGve2JbvbEoZDeUwOpIFmbsgoNJPq9vLmZjbbT8nViMSL89kyDZ6J7bonN+nCs8mllgSlJ0/LiZfxxgTOlBfaO/Z3wG2MTcFqxqADTuM4ujaJOizG/6fVMrnG7V975gG6PD2ygkWlGdnmrF25IiIomjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HiYNNylG; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-599fc25071bso3059600eaf.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 09:14:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707844462; x=1708449262; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wWYkFPfiCpaWEvWgISX+b5xO2e9ZobwEg3qfP5joRSo=;
        b=HiYNNylG+RRAT2fGdy72pPtEyHPBotR8t1/69viOKDmqvuu+Z8o1vRHqrFGKQpVr8a
         PvmFOLWeozDe9/vHDYwFEH1lcE5yDn5HStf54xcCx/sTivVj23gJCUacNHfFv6hrrPD/
         nCYu8qWa0zik9aRZ58Qf1/LJyRTT03k9es5gUaRTX4mfNcjR75q/wD2+fZHwZmxonSHW
         YxiPOA6J+wH4XAY3PbLm/LxBPmFqhpsU728BGO1QfxJDGhThc6z5lWIMrt79fXApzOdp
         6cOhdgujkdoTSfWsnlJlbcNXE7W9E6SYSpEVQGPSHOWdAcqP+t+r0i8Uu29iQtyIQ+8j
         tvqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707844462; x=1708449262;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wWYkFPfiCpaWEvWgISX+b5xO2e9ZobwEg3qfP5joRSo=;
        b=EWNPcj3Mztd7wc/2gbpT+TQWAAIkWD+kghlCEEhjBJs1iCFnsvxQPk06xfN1DhKSMx
         rS7ARmBJSLTz3eFNuGTdJ5yH3/3jpMo2gZQkOzCMm1eb0d1YCqSJRK9OyZ5tGgyuB75G
         i5cWazn6smkZ+KFb6Mt1EE0BCsimxe8eQXExXkfnHEdsiVcEyoga7l6k5Cvll3MZ90jq
         FtdjkYUxt1NZM3oTz52DSvazfa6BAr6VmoW46taZeTkDWqn2DJCQDdHo0l03oET0Ffs0
         +lFENnH9HikS73iZ45hyOb0P7aujAbpimcd7SIO0bT5oFfUvtH9sK1AmmN3ikT2dIgvT
         axdw==
X-Forwarded-Encrypted: i=1; AJvYcCUuUaeM/ZUgwuP0H0KzP0K+m2VHYuqBWhd3q6aPPE6D6ElYXaIF/+m3UA8dMfKw7k21BCb8HrjCwBz3qdmrdw9v54m9fLaetLZEKN+o
X-Gm-Message-State: AOJu0Yxb21uh9t21eJEhPrd+s3DhOXgrHsmGanEr2pfvfNZU0qsPyWUJ
	QuIKC2Q6G6n+V8Ettp1c7P8LhFQoWQFRnv3JA8zrZbYjpORaoUOtOixRcRqFEg==
X-Google-Smtp-Source: AGHT+IEOxWREUBGC0f7j04zpR6Kvian2c+B0Gtj/AEmJlX+piv4UW9N3HlTOkwOh7O/jFM0uKb3VXg==
X-Received: by 2002:a05:6358:7e81:b0:17a:f91c:825b with SMTP id o1-20020a0563587e8100b0017af91c825bmr1386833rwn.5.1707844462506;
        Tue, 13 Feb 2024 09:14:22 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVTTgBUbmGTHDb4FXx248cvObvI7tZiwQlGpHHld8LDVzYO0A6bzBrbXY7aB/TCOYqiejrdehcIGzPl0LXiSw3+2M+8wY+txYKFiWGQRtz+NpuYPssTeVaNTKgKmMfNIoYYZVpCDq9DAdhZjqm8ssH+Yr2NrvAcfbPZox7yQ3T9CT2joEIM1Ycslj7tko93MRssT+7TJC+ZYXpPD8Q8ZYprEXVlzNeT/NcGEmBKa3hkXihCDYiIyq/fEMeSBREgjqOhxdL3Wz5YIxYi6ziPkrM4Lt4OZOuQV9109eOfh836hsBqAAPNU2NRKn/Uf/Y=
Received: from thinkpad ([103.246.195.75])
        by smtp.gmail.com with ESMTPSA id fa12-20020a056a002d0c00b006e0f6e6c014sm1826010pfb.84.2024.02.13.09.14.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 09:14:21 -0800 (PST)
Date: Tue, 13 Feb 2024 22:44:16 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Anton Bambura <jenneron@postmarketos.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/6] arm64: dts: qcom: sc8180x-lenovo-flex-5g: fix GPU
 firmware path
Message-ID: <20240213171416.GB30092@thinkpad>
References: <20240203191200.99185-1-jenneron@postmarketos.org>
 <20240203191200.99185-2-jenneron@postmarketos.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240203191200.99185-2-jenneron@postmarketos.org>

On Sat, Feb 03, 2024 at 09:11:55PM +0200, Anton Bambura wrote:
> Fix GPU firmware path so it uses model-specific directory.
> 
> Signed-off-by: Anton Bambura <jenneron@postmarketos.org>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sc8180x-lenovo-flex-5g.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc8180x-lenovo-flex-5g.dts b/arch/arm64/boot/dts/qcom/sc8180x-lenovo-flex-5g.dts
> index 0c22f3efec20..49b740c54674 100644
> --- a/arch/arm64/boot/dts/qcom/sc8180x-lenovo-flex-5g.dts
> +++ b/arch/arm64/boot/dts/qcom/sc8180x-lenovo-flex-5g.dts
> @@ -350,7 +350,7 @@ &gpu {
>  
>  	zap-shader {
>  		memory-region = <&gpu_mem>;
> -		firmware-name = "qcom/sc8180x/qcdxkmsuc8180.mbn";
> +		firmware-name = "qcom/sc8180x/LENOVO/82AK/qcdxkmsuc8180.mbn";

Where is the firmware located for this device? I couldn't find it in
linux-firmware [1].

- Mani

[1] https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/tree/qcom

>  	};
>  };
>  
> -- 
> 2.42.0
> 
> 

-- 
மணிவண்ணன் சதாசிவம்

