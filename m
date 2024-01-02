Return-Path: <linux-kernel+bounces-14620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB518821FBE
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 17:57:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AB6B283AA9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 16:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 812AE14F9D;
	Tue,  2 Jan 2024 16:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FKc1lGke"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8879F14F95
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 16:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-5f15a1052b3so18756917b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 08:57:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704214651; x=1704819451; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5wk4N7lmV0VhLdq0PkFpCuSEzkzGL6KduOmoT0VC7jU=;
        b=FKc1lGkeg8eQUAf6ZYO/awJ698ZYqSDZ2eMApS3EYT9POdtFRO8JKtdj+IhE6KUKxs
         6lvAhdxSdYQXdM7n/oW3kG8R2qFPRN8c5AY31V3Q1WplllbLNC67xUDAZbvAYDH+YfIN
         od+62RTT051UjPS9eUETm7Nq5wTcLdUvW1n1frbXLxETqEb8Vh6B7GLKiB5ENRnSmMsn
         JWkh3MxePMCjielYxJTqYiPNLG2VWWAxbG3dpvpwcYV4Tcro4cuDdf70ppYQTrCK31bk
         QfU04h0Bz8s1qGsqeVwaTTj91gr4ZjRhX8GLLJhj9Llu2CTBfsOOGERJJ6n0WN5EjzQU
         wYdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704214651; x=1704819451;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5wk4N7lmV0VhLdq0PkFpCuSEzkzGL6KduOmoT0VC7jU=;
        b=QvuCgteNqYlJxRoU5YKjTu8diriDq1L+PrWJli/M1u6uclfsufzQg8mzg5bfHVxzrI
         ugGht/KoktyJdCMibuo5CXI2i45uqzwYMzTxi6hSqBsatOMFUXjcv0DQmHaGBzLzWlBE
         Nsp5ghU1GTfaqcqbDy2dRrehF4lvvhvGwVWEYTtX0LgsuwchWBJnCUPPWzSjstibpWkH
         ocUNqbKcbLuHrs/KaMJjVRf79zIzpQZhaGfrK+mmiviK6Y3SV9D83cumvexjAikhZ93F
         WPVK2cr4UNZu9RBl3NovtlaM3WnBegnHoykvectSsg1mfd8n8lJzEnzaGliHKYKVH2ht
         hyHA==
X-Gm-Message-State: AOJu0YxtqJrGFZgM3b3kTkEN6i06OUGOrUOxHfoeSBo4Kdi5qxM+BTFa
	Wpa1DuwZVn7QhhVsWVnm7uBQm7FK5nZZiEdM/Pehrjmrh3JAhg==
X-Google-Smtp-Source: AGHT+IEjtOPKsRyajYMxbHL80czYGam47afsRAbV0f6T2b+vZzSF+3Mk2d2iP/UGzBJAnyxqycP9y0gExlgC+LvRYdI=
X-Received: by 2002:a05:690c:12:b0:5f4:c40:1265 with SMTP id
 bc18-20020a05690c001200b005f40c401265mr466633ywb.68.1704214650754; Tue, 02
 Jan 2024 08:57:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231209171013.249972-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20231209171013.249972-1-krzysztof.kozlowski@linaro.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 2 Jan 2024 17:56:55 +0100
Message-ID: <CAPDyKFo6xh8k_NjAziEEuj_us_n9GMgdwVGMKXodVLHq-TbS7w@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: mmc: synopsys-dw-mshc: add iommus for Intel SocFPGA
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 9 Dec 2023 at 18:10, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> The DW MSHC node in Intel SocFPGA ARM64 DTS has iommus property, so
> allow it to silence dtbs_check warnings:
>
>   socfpga_n5x_socdk.dtb: mmc@ff808000: Unevaluated properties are not allowed ('iommus' was unexpected)
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applied for next, thanks!

Kind regards
Uffe


>
> ---
>
> I assume the DTS represents the hardware, thus iommus is real.
> ---
>  Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.yaml b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.yaml
> index b13b5166d20a..a6292777e376 100644
> --- a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.yaml
> +++ b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.yaml
> @@ -35,6 +35,9 @@ properties:
>        - const: biu
>        - const: ciu
>
> +  iommus:
> +    maxItems: 1
> +
>    altr,sysmgr-syscon:
>      $ref: /schemas/types.yaml#/definitions/phandle-array
>      items:
> @@ -62,6 +65,7 @@ allOf:
>          altr,sysmgr-syscon: true
>      else:
>        properties:
> +        iommus: false
>          altr,sysmgr-syscon: false
>
>  required:
> --
> 2.34.1
>

