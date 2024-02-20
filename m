Return-Path: <linux-kernel+bounces-73160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60CEF85BE58
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 15:12:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 948E21C20CE3
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 14:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F0D06A359;
	Tue, 20 Feb 2024 14:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jwGeAk+R"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073976A352
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 14:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708438335; cv=none; b=PBzEOgtMz0yIPGOl6wBvXSFHoXd/9CV4qmW/sPE2OBZACSmaP5RwpVCwxOSc2gxriTMq/m7HQbAn119LpyQFHCMTziDQYuJ71YmpbLyJk/RvQSK8L302DUClDwnMR/LAHQTIwMinGC6eDC6ACk2oKAsWHReAwrwebPrJwOZzAJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708438335; c=relaxed/simple;
	bh=ZUd/4SIGCstdqfJUTd63+Gsgaaki8fxiSzh0mr3PVCU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gsqh7jNJASbfBfyeXQ/RVY3XS91FLVee9/WwAssW0ygbCLbk86Wni21ZVE1DRWTn3xso+tlzTquLL3XEMbEsL9GCbuXHv0BTgUa1QJGa96nTZl3RjMv6B4EqxTK0b6vQ8qkVV8v5my+IUdyoa9x+DOF8dq2c9nAytWGtNDOZYk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jwGeAk+R; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-33d153254b7so2634316f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 06:12:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708438332; x=1709043132; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VlCI9F854lrsWDUIN6PG7zZ3hJeSzAbz00+8LmilWc8=;
        b=jwGeAk+R6VThW+JUlY4uPM1hbUFeOFHIh7TvNpyFy8lqUbVkMmMSUZO+mies2RHt8S
         DMQIo0B7bwaXIxYNYV66GyXKgq6tKRjMSAt87kA/IstD/uW8sxlz3I/+D8GRstrYaHap
         ReGFQhe+o49yE8gcedT1MZIovD2u7U9aODQZ60x3OS+B13BTcBm+g1G+C0N7+GYvbwv9
         909FFIGpJJptV230JtxKxaLcWuhLSLlUowxFIjvv9YD71qcp3ipAF1dNqaxOPBsK2GC4
         VUmKNrSNddMrBuKNX9UIZtPTajQFSz6X0AzdrTNo2XCQgplAJ2frDxP0OyEW9uHAJA9q
         wc5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708438332; x=1709043132;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VlCI9F854lrsWDUIN6PG7zZ3hJeSzAbz00+8LmilWc8=;
        b=gQNI5sW+6xd7Qw1w+Frfub7+P0VYlFckPfaFhmQTz+rwwRzJ6kQkEtI35HgQJ3vCwO
         /VDlAf9mkaHlbTb1GVALmXsZvBFRjvoAwdocKgKxMDFfga3bQq9IUYxr35GA/izKeIwW
         FEZdUwCATrQExyJVzqgZSRNvq3ym4JNP2/ZNYYlFLwax00r6tZGR+MCcilBJv6PKXcTs
         oclmO5M5k1KBK4avEVh8+r7Wpreu8TjIiFQCNlulPoUHbkAYAHjL+S8hlAa0MBomUZxM
         bPrvGRpgpAyKBjW4sEXqiHLrZ31VDK7unw1xYXwY0uUrtYq925O/W6uTa4Xeqf/73FYn
         d0SQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYfcW2y0F3groitpTzX6sCmzNHgiLKQSJ9eGsA+j4IGfX6drzb9Z3x/VwBMVECorPD3b4shxD00lLc3LRAZthnr5vr6kVQy6s7COUK
X-Gm-Message-State: AOJu0Yzc8Lg6Tp2l8fj0DygtcStdKuhUYApJz6hssNo7T54JJrGJE7YZ
	uyJW83vN0laJbeye/Jb8yhNAJ2egTyxaeHo6vkdyetFs0LLmMK9SNPSCcaK6Mo8=
X-Google-Smtp-Source: AGHT+IHoWaPYXgMjU6PeB2yk8TgKT2tZQUeUz9ykPdB+ZXJLtJWkH3ETMuOSkIOY4HbiE/fpQppbBg==
X-Received: by 2002:adf:ec44:0:b0:33d:3ceb:5308 with SMTP id w4-20020adfec44000000b0033d3ceb5308mr4607368wrn.42.1708438332431;
        Tue, 20 Feb 2024 06:12:12 -0800 (PST)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id bq5-20020a5d5a05000000b0033d60ab6bc8sm4662665wrb.50.2024.02.20.06.12.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 06:12:12 -0800 (PST)
Date: Tue, 20 Feb 2024 14:12:10 +0000
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Luca Weiss <luca@z3ntu.xyz>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
	Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
	Helge Deller <deller@gmx.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	"G.Shark Jeong" <gshark.jeong@gmail.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maximilian Weigand <mweigand@mweigand.net>,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 4/4] ARM: dts: qcom: msm8974-hammerhead: Hook up backlight
Message-ID: <20240220141210.GG6716@aspen.lan>
References: <20240220-lm3630a-fixups-v1-0-9ca62f7e4a33@z3ntu.xyz>
 <20240220-lm3630a-fixups-v1-4-9ca62f7e4a33@z3ntu.xyz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240220-lm3630a-fixups-v1-4-9ca62f7e4a33@z3ntu.xyz>

On Tue, Feb 20, 2024 at 12:11:22AM +0100, Luca Weiss wrote:
> Connect the panel with the backlight nodes so that the backlight can be
> turned off when the display is blanked.
>
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


> ---
>  arch/arm/boot/dts/qcom/qcom-msm8974-lge-nexus5-hammerhead.dts | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/qcom/qcom-msm8974-lge-nexus5-hammerhead.dts b/arch/arm/boot/dts/qcom/qcom-msm8974-lge-nexus5-hammerhead.dts
> index 4aaae8537a3f..8eaa5b162815 100644
> --- a/arch/arm/boot/dts/qcom/qcom-msm8974-lge-nexus5-hammerhead.dts
> +++ b/arch/arm/boot/dts/qcom/qcom-msm8974-lge-nexus5-hammerhead.dts
> @@ -182,7 +182,7 @@ &blsp2_i2c5 {
>  	status = "okay";
>  	clock-frequency = <355000>;
>
> -	led-controller@38 {
> +	backlight: led-controller@38 {

Again... a minor nit regarding existing problems but this node doesn't
follow the generic naming recommendations:
https://devicetree-specification.readthedocs.io/en/stable/devicetree-basics.html#generic-names-recommendation


Daniel.

