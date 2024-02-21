Return-Path: <linux-kernel+bounces-75674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AAF9B85ED3E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 00:42:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C0D6B21D70
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 23:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76BDD12BEAE;
	Wed, 21 Feb 2024 23:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n+5r/B/8"
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E449129A6C
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 23:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708558943; cv=none; b=qyzmjdRdLqFOXYNctkjIPGAnFT9wogU0/NOXX31vgQKoWTgUhYZq6GJDuTpoFzroFHrJt+WejPc+vwmWBUspYzERcR2T493c3GoMU2peLY3UYc7/dT2MFmHV/1TgU3+4eVZC0hSyP95efaeLmMazXzzDkRyWiluzLFbm24TEJ6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708558943; c=relaxed/simple;
	bh=R30h1HMhJTW2Hl0gQhY0c5uAgK3flvLTGgjb/74w7kk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C9+ZQmr93/3dT0tsb++NcQ4ZJj4u9UteKJvjTdp/W/Ixv5gKfK+3sufe8CJCipGiDbQo3s3DUBTrqNRLLay89nEMr0n6Ta7gSI8kMqLSCq21kZsAS/h+Let9+NjXHQ9r12/6fMJa6g55bytzjAgndfHy1UC5RNiuDOwGncTnXqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=n+5r/B/8; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-db3a09e96daso6395228276.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 15:42:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708558941; x=1709163741; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=C/dj756VosTuwMpPJNGyW3MhpcrxAFO76cK11lx7rxo=;
        b=n+5r/B/8QsPnDxmK1oO/9JxDKxfbmgeikWZefanD8qDfeFviUkPQNYQ2IopWBIvI4v
         0IRWihrLavCxR7/g6TJaKjnC624DeE1EnhdVpnQYP8J/Zn2KFQ2dzqDPQsmKDBhqDwQ+
         Htclg7dIu14I2+bdEluF8zrQMuXSDnHxvtLsiHDWY9T/HAW+2m5qhrWnuJoQ1pEUURMV
         xzRMkCHAExFQ8m+uyazB+tqzUPibS63Hm5dEXAcwyGsRUuGdsCezKGflQz6raJG5A8tF
         EddIjVogMs3o5o8l9CPKROyQwO4NvzSL/6TjHj/auy30+jtBSBc6IEfPBuhaI7/psAVx
         VZGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708558941; x=1709163741;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C/dj756VosTuwMpPJNGyW3MhpcrxAFO76cK11lx7rxo=;
        b=Zcb/hnnrpOguJOMsE+QlYC1hWk94DSL/yA9h/NocoQdW55vmpmhFahtxPu7KZ4xsA/
         H6S6TfHVegWFwDy6F4aO4FhA8g7jldnn3jO6K++BTKAiFymF7S5mBF8u9EfywuTOBxY9
         ZPN+WObszAeD7QwJSjJvLOVZ8D8z0K48glIJHLV0EmmY/jVVMypnMCrvnvUEe5qKi5uI
         /SLBLUQWEqrrQL9LKGcPGWMJ1NDVvY6f+qEOlE4IW3cCRTVzSGquhjuo3CZRIJc1oUoR
         +zFORdo+NkvlfumyuWC3sENESomuaEYpP54Ary4WIOj1oTEkGB3wk7/hTPU44x5p8Gdk
         dIqA==
X-Forwarded-Encrypted: i=1; AJvYcCWpNe70AJF2kEgkR8bC28zSzOYbklZsG4BHYErxRotEvFYQxxb1HL7A7c90/i+riMj1NIcQqoDmfz/Tb0b7UeLEC3oC/o3fQjIKNCl7
X-Gm-Message-State: AOJu0Yz+COfEzc9xInC5LzQaLA3Ey0O1c+BXd25S692t4HBT2+FflCBf
	1e54iHM9Dio21C0tX9uHEEd9GXEgVBJ1cqewZQHogTbuoCioYFpIu90SpTmzfVkf80txEYT38W8
	OsUAI8o679h4peKJ1ITqte1ZZA4XIZXIxuVo9YA==
X-Google-Smtp-Source: AGHT+IEPTkax+cblPH2B3OK6zkJGmVKi10jTkKNhhoD5CPKfbwC59MAyFljD4sz8HRB3ajKPgQOsU016PTTq8M/17rY=
X-Received: by 2002:a25:1e41:0:b0:dcc:67a7:430 with SMTP id
 e62-20020a251e41000000b00dcc67a70430mr834243ybe.15.1708558941152; Wed, 21 Feb
 2024 15:42:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221-rb3gen2-dp-connector-v1-0-dc0964ef7d96@quicinc.com> <20240221-rb3gen2-dp-connector-v1-5-dc0964ef7d96@quicinc.com>
In-Reply-To: <20240221-rb3gen2-dp-connector-v1-5-dc0964ef7d96@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 22 Feb 2024 01:42:10 +0200
Message-ID: <CAA8EJpqtj-+PaUWeXH32_jfNaOUM+V-H0j5mZSW+rcaAQTdMzg@mail.gmail.com>
Subject: Re: [PATCH 5/9] arm64: dts: qcom: qcs6490-rb3gen2: Enable adsp and cdsp
To: Bjorn Andersson <quic_bjorande@quicinc.com>
Cc: Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, cros-qcom-dts-watchers@chromium.org, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 22 Feb 2024 at 01:19, Bjorn Andersson <quic_bjorande@quicinc.com> wrote:
>
> Define firmware paths and enable the ADSP and CDSP remoteprocs.
>
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> index 32313f47602a..ab498494caea 100644
> --- a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> +++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> @@ -451,6 +451,16 @@ &qupv3_id_0 {
>         status = "okay";
>  };
>
> +&remoteproc_adsp {
> +       firmware-name = "qcom/qcs6490/rb3gen2/adsp.mbn";

This should be either

       firmware-name = "qcom/qcs6490/adsp.mbn";

or

       firmware-name = "qcom/qcs6490/Vendor/rb3gen2/adsp.mbn";


> +       status = "okay";
> +};
> +
> +&remoteproc_cdsp {
> +       firmware-name = "qcom/qcs6490/rb3gen2/cdsp.mbn";
> +       status = "okay";
> +};
> +
>  &tlmm {
>         gpio-reserved-ranges = <32 2>, /* ADSP */
>                                <48 4>; /* NFC */
>
> --
> 2.25.1
>


-- 
With best wishes
Dmitry

