Return-Path: <linux-kernel+bounces-127619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D2CC894E78
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 11:17:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EC171F229EF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 09:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFD8056766;
	Tue,  2 Apr 2024 09:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O9krRRCO"
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4471E525
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 09:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712049453; cv=none; b=FS4kwItHSiD9Z34omdNNWRqKo7Gy46yCVtXmJDRNAcGnm/qOsStvO84uR0uqpu4CozLH5gZZVH57X+f51v35+cWfw9Ve7AkC6sX11sndgKULzbWtgODt9Syusnd0CVtYQruJIpYbZkmce/0oVfs+q2R+Atpw1QBTK6yakt9a5H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712049453; c=relaxed/simple;
	bh=yWVCQtaYew/qGdbiB4oLUOpW8u2i9W1Zhnom51HquQ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LvjzSSnUQm9tEzPzQNyc24dbDV+pDnighTcgwm+BjYVL8N13Nvavq/D9Wrq+Dc3vd6aHTH/cy04akGw5WHxPT07wYFHJbabfq4OTtRlqhXOFBCiQ0kNRMpLjZhLBeS0/mNiRmtf7cTheA6yV1tjY47SNgAPaAb2PT2gFHYhVwpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=O9krRRCO; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6144369599bso26071067b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 02:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712049450; x=1712654250; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=b4JOTAGSSqxD/6R2HooZD6KzFss24TTWtPE7MY2K138=;
        b=O9krRRCO+zsGCfcJMYo+MPGjALhc7+n9Z3jVwh7fp6p8yg79YuOBdogcHIX6uypw13
         dx/rGocaZhxxQM7uRqY8Lh1BFQyFYylUBdTCEj0Q51p6gKLo9sh8SV6/z1Q2Rnv0HXKh
         EVHaisYIsymg27lJNzYjkLbigixg0I0q/wZEwQnGLP27KDnTsVlymzLrNYaoMQc+W7zg
         C3bONTc8/3JHcFaN67lI1NuqaklxA7sG9rEtFEvayNx58my4IcSTuIfFva+gZeMoaISA
         h4yyMw5gDpNicdW4FeqYR5oShFNct2Ooi946rtLQOIVT5p44e0rUWJhSan4SfbLRXvu7
         qLJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712049450; x=1712654250;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b4JOTAGSSqxD/6R2HooZD6KzFss24TTWtPE7MY2K138=;
        b=nVhch42CaBKg1s0jgP+VWCvE+F4CHW0tkU6HXeZJdmqcmWjkaC0u3cwDzP7YboSUzg
         LnibBWur+89z8aJNTLHEA4eEIUawfW2y/yCc3RkNp5B2iNMEA2/TeuvIgXOZ3eq39bmw
         EZrw6bPj6otsAghc5PtzTU1gC3oZfHecGFv9du5MRfZOdDvHBy6wB01qbysmIc5zbPD7
         uyOBsbAQtvJBh9EX//K1Wux481gBAlACs7oYYP6EFpmjyLa3S80C+WpqIgkSmbDoO4oQ
         WoH4ZsTZ+6CDklT62yc7J4AcS3NxRXWfWHY6wWpIUNw2b39r5EUt/krO07n/rLxrJHbI
         2SeA==
X-Forwarded-Encrypted: i=1; AJvYcCVjLdBcF2IwaW/H02d2cXgh2YNKgqXD9yBgDyFa12NUwLkq2wc0HMMc62TU1sDmj1rc96kaHv+RjeClVjjlRHW014hdPcVdw1C5RsdU
X-Gm-Message-State: AOJu0Yy1ivQ4Z2jBrb/pStUFdAQ3k5HnytIF5IaF02Pj16YlawSDXKXP
	P2mHv8gIgrhAeGadnIfLXMnGLaprXzIiqpmEZ7n/hTTGQoMQ4hVja4/K21yCMwXr4f5iSjCtXuB
	LCVd+d2KwqptKnLNKSy2geDZmSp+j6sAXaOeYYw==
X-Google-Smtp-Source: AGHT+IH/v6rRl4ktlb7lChkoh6kfocXEqdgBd/iPimn9Wrhvfrfh02M2zbhpCuH2oxhKtIIcQ1ADClydxwHpYS06brI=
X-Received: by 2002:a5b:cc2:0:b0:dcd:4d:d342 with SMTP id e2-20020a5b0cc2000000b00dcd004dd342mr10425848ybr.50.1712049450632;
 Tue, 02 Apr 2024 02:17:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240402090349.30172-1-quic_kbajaj@quicinc.com> <20240402090349.30172-3-quic_kbajaj@quicinc.com>
In-Reply-To: <20240402090349.30172-3-quic_kbajaj@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 2 Apr 2024 12:17:19 +0300
Message-ID: <CAA8EJpofbeyER39_tjG=sYmVp+vN2WbNZyhU6NEaePxd-QUZaQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] arm64: dts: qcom: qcs6490-rb3gen2: Enable various remoteprocs
To: Komal Bajaj <quic_kbajaj@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	quic_tsoni@quicinc.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 2 Apr 2024 at 12:04, Komal Bajaj <quic_kbajaj@quicinc.com> wrote:
>
> Enable the ADSP, CDSP and WPSS that are found on qcs6490-rb3gen2.

No MPSS even for GPS?

Anyway,

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

>
> Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> index 97824c769ba3..a25431ddf922 100644
> --- a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> +++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> @@ -434,6 +434,21 @@ &qupv3_id_0 {
>         status = "okay";
>  };
>
> +&remoteproc_adsp {
> +       firmware-name = "qcom/qcm6490/adsp.mbn";
> +       status = "okay";
> +};
> +
> +&remoteproc_cdsp {
> +       firmware-name = "qcom/qcm6490/cdsp.mbn";
> +       status = "okay";
> +};
> +
> +&remoteproc_wpss {
> +       firmware-name = "qcom/qcm6490/wpss.mbn";
> +       status = "okay";
> +};
> +
>  &tlmm {
>         gpio-reserved-ranges = <32 2>, /* ADSP */
>                                <48 4>; /* NFC */
> --
> 2.42.0
>
>


-- 
With best wishes
Dmitry

