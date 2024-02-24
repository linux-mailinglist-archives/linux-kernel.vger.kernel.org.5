Return-Path: <linux-kernel+bounces-79891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51B668627FD
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 23:34:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEBE61F21974
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 22:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26EE54E1C3;
	Sat, 24 Feb 2024 22:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SFUX6wpq"
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1941CD12
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 22:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708814089; cv=none; b=BF1O64DtepcFDGfeNK5EG41ShZYuel8QQ8e2zFgKfYAY0SdcMnXKSj2c9G99maak7dxbp0VqkK1l4gWoa/yRkSCd0aA8TPb1sSWCZZydwaLYcIAFP3BmfQNbf5byFlSDakfx2aL4p4nmVeZl6HEqUw00FpVXSR4EleyQ/P6miCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708814089; c=relaxed/simple;
	bh=eulGHgL6SA7y7GwoqKwqLFCs+wque3qqAtEd/9jIavI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cq/JEGmrhZ30GNvUAhJJwWs7h05GVMaxfwgLSNDgVvbQRRWmqA4q9idrCdJ/qyfHK04YaCA7UNxNnqn29UYaJ8NqVRQ11dexYR3wVg9nrpHNd4hZetWG77vM1K2StD4osCDDrzwCN5hKes8ww3fMXNjgdqgyunYT8zMFSX3CWvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SFUX6wpq; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-608e3530941so2155547b3.1
        for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 14:34:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708814086; x=1709418886; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fSWAzifwmBABORc4RLjDBXc5wdSEcZlyZ0ioROWY0qc=;
        b=SFUX6wpqAPCSrbTryE7iUsXUBgaOrQ2fcKq//h465qYsvEUVFZpPH28XevuOxzkmxq
         Wu1R7KcKZHiOgTjvvhgM4/Q1yn2pueQDl7y1q9lW+DzwAr5dXDOFINu9u9MOAPEVfEce
         ye4IuPqcphUwQsAAvSX59A+Ua7O3tO4HVxeZAKf116mVYl17mbxAkPTgYv8T8bsXi04T
         Y/Q4mL6paqMFhQDjjI+QVFJgRo87l0xOHJ8ULNY9zsRIMZlf24OwnkVsuqom7UEJ8M6I
         XJ/H4bXccMgCqjQywnC8CxIMS+nFxfcTAtSOKXY7p4wuGtOnBKtSqCukwpsMavNcybCS
         fLew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708814086; x=1709418886;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fSWAzifwmBABORc4RLjDBXc5wdSEcZlyZ0ioROWY0qc=;
        b=Wgde+xCYjwKrXw+zpw4mKS6iJQ8V3GW+vntq7nox1d5B6+6iZfSK6uEBGL/cw8KRwm
         gPvz+9cXjXzD/Me1cR9bZXVe2T3TjJCdje8F8EIL6IrP0VPsAO30A79hvXNtaUafJ3sw
         QqZ37vJXVM2bM3NPtnHoaMLPujc/MqeEpwb2CoKbTzxeF+9/ZtlsM3NkSFe2tI5SiHa4
         jkrIYhSmd5iRqVwHk9yK/sxjGhOQK3TTyxwPq647ORKpuwzmPqSWE3j0r/AYQP84EZ1F
         XgQyLJ++zBjJfVakj1R73rKbfBfaSUF4Jz9Bk9j1JC+6bcqdVNpVl1G+/eQVo7rxysyb
         FsEw==
X-Forwarded-Encrypted: i=1; AJvYcCXDe4pxCGvGouGZ31UvRVzHu4gqKPCimLWwES4plnefa8Zp2YpsNgoK8KMy8kNc+KBJ5sdFghFjQrjMripym1zFCnFqbmEWYCtTgGum
X-Gm-Message-State: AOJu0Yy7rjCPspi9qOp/ihskuEO+AiW4Qwsjw7h1dLBBMuIZoUBKIDUU
	srY8HnUvKf8BtvFNMnY+wiGcKzGFwB8e7koazD7D5YFKlpJN57OVrRonwz3JAEH2minzouz6F84
	1FXIlN4paHnwoj5wTwf8eDthIXC0/61DzHTnxVTHL/YncdZJV
X-Google-Smtp-Source: AGHT+IEt0J5rY6GTeFZWhG/mY3NWmwow/MGIgHtdSvjrLUVIVDeFiV4UIk5CN4JD9H1JkWvYeScpNmeVrxVqVCTFU04=
X-Received: by 2002:a05:690c:c1b:b0:608:3c43:9186 with SMTP id
 cl27-20020a05690c0c1b00b006083c439186mr3300115ywb.45.1708814086115; Sat, 24
 Feb 2024 14:34:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240222-x1e80100-display-refactor-connector-v2-0-bd4197dfceab@linaro.org>
 <20240222-x1e80100-display-refactor-connector-v2-1-bd4197dfceab@linaro.org>
In-Reply-To: <20240222-x1e80100-display-refactor-connector-v2-1-bd4197dfceab@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sun, 25 Feb 2024 00:34:34 +0200
Message-ID: <CAA8EJppOBHhaZpS_Z34fmFmGr4aRe0-k8w=5ScquNhCrnzRDgw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: display: msm: dp-controller: document
 X1E80100 compatible
To: Abel Vesa <abel.vesa@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>
Cc: Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Kuogee Hsieh <quic_khsieh@quicinc.com>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Johan Hovold <johan@kernel.org>, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 22 Feb 2024 at 17:55, Abel Vesa <abel.vesa@linaro.org> wrote:
>
> Add the X1E80100 to the list of compatibles and document the is-edp
> flag. The controllers are expected to operate in DP mode by default,
> and this flag can be used to select eDP mode.
>
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>

Rob, Krzysztof, Connor, gracious ping for the review. It would be
really nice to merge this patchset during the next cycle. It also
unbreaks several other patches.

> ---
>  Documentation/devicetree/bindings/display/msm/dp-controller.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
> index ae53cbfb2193..ed11852e403d 100644
> --- a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
> +++ b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
> @@ -27,6 +27,7 @@ properties:
>            - qcom,sdm845-dp
>            - qcom,sm8350-dp
>            - qcom,sm8650-dp
> +          - qcom,x1e80100-dp
>        - items:
>            - enum:
>                - qcom,sm8150-dp
> @@ -73,6 +74,11 @@ properties:
>        - description: phy 0 parent
>        - description: phy 1 parent
>
> +  is-edp:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description:
> +      Tells the controller to switch to eDP mode
> +
>    phys:
>      maxItems: 1
>
>
> --
> 2.34.1
>


-- 
With best wishes
Dmitry

