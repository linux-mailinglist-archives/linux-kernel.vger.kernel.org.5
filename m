Return-Path: <linux-kernel+bounces-14621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C97E7821FC3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 17:57:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64DDB283B12
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 16:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC31F154AD;
	Tue,  2 Jan 2024 16:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GoCxToQu"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2CC15482
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 16:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-5f0629e67f4so26164037b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 08:57:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704214654; x=1704819454; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VVh7m29Ky9WukziqxPzevKkxIvdB0PDoPjGRWVMZV14=;
        b=GoCxToQuXJ99CCfr5iMWA63EfTF0f/Yimi0ufjs5iv0aNPM+SOh68DIHyKv3N6r9oB
         DD3OuGiufNXVYbFiaQ1xfyaqG4OpssyYv66cWnLwjKu83WHE/gAmRxp+HkORBOAGJCWx
         JTkm5CpVfYlNjm3COcY7U3xJi/5md8Qwqv9VIa3i8QBgFSZRKh+pUtGGe9f2E1bKQJsY
         uVcTGXsAMzVN4ihifHLHWv0fotUw9v9zwCKVl3Db5I5nX2BCj43O8u/LQMp6lDa+25mo
         L9fAKUXezj7kBFmPxL92XOW3v6Te+vXKAx2n9asNlRIY+GmtMAYG3kKJthQnVdUEKsxP
         pTjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704214654; x=1704819454;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VVh7m29Ky9WukziqxPzevKkxIvdB0PDoPjGRWVMZV14=;
        b=dWk1yF0IyqTD17pb7/ukHLV9lR0HsKqJfAhjAAAxgDbds8l9hJKVy9o7BT0+tzwUwY
         Y+k0fPkuobUsMm8kz/QCy42ZQhaTDyul4d9OAd2ASNWSRW6O8P/DDVkgyCNmvZryVsWT
         H2US8DW18FXnbWw4F3bW9SnXAOqzm25ZAUzLmXUhpgpOvRkXYoMtfccDSEuCYqcquxZm
         DNxFbGBl8Q1UPgZKZdITwee/bvcRHh2UqS4nmov8S3Fi+7ABV6POumi/M0qE+9fYDTyE
         +mwrQ7KMoZahcGKGrZJfGmvb/RTon+Wnc5oHVK3bw3yvXO96J3OsIRXdQ8OYoVouWI9Y
         nUMQ==
X-Gm-Message-State: AOJu0YzmUeq++ZOTSLoG0+F49yOisvjIfmnGa9oKZAoeZzSUBs8uInb/
	1ym6LVs7YTv4gL/pRpeWoH6mcoamGdP5UxNWrF6ASl/KqS9IfQ==
X-Google-Smtp-Source: AGHT+IG3cKejQU1lw6kB8D1slP13fhxQrPArTQrPYYY9m76Qm4R78xwRcBK6XSjxNJfA9eOGogYLST+VoA5oeAJFa5c=
X-Received: by 2002:a81:b718:0:b0:5eb:bfac:69c with SMTP id
 v24-20020a81b718000000b005ebbfac069cmr8701530ywh.45.1704214654000; Tue, 02
 Jan 2024 08:57:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231211085830.25380-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20231211085830.25380-1-krzysztof.kozlowski@linaro.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 2 Jan 2024 17:56:58 +0100
Message-ID: <CAPDyKFo3kpTrKctYX0oZeCxSeBF1ehLmEtFoE4HQfvG0wnEh=w@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: mmc: sdhci-msm: document dedicated
 IPQ4019 and IPQ8074
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Bhupesh Sharma <bhupesh.sharma@linaro.org>, 
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 11 Dec 2023 at 09:58, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> Add dedicated compatibles for the Qualcomm IPQ4019 and IPQ8074 SoCs,
> because usage of generic qcom,sdhci-msm-v4 compatible alone is
> deprecated.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/mmc/sdhci-msm.yaml | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> index 86fae733d9a0..c24c537f62b1 100644
> --- a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> @@ -22,6 +22,8 @@ properties:
>        - items:
>            - enum:
>                - qcom,apq8084-sdhci
> +              - qcom,ipq4019-sdhci
> +              - qcom,ipq8074-sdhci
>                - qcom,msm8226-sdhci
>                - qcom,msm8953-sdhci
>                - qcom,msm8974-sdhci
> --
> 2.34.1
>

