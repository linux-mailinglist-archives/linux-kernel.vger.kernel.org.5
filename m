Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD0917D6681
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 11:16:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232666AbjJYJQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 05:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232428AbjJYJQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 05:16:32 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27C0FDC
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 02:16:29 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-508126afb9bso1340665e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 02:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698225387; x=1698830187; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dkMR9DQLmnzg6433Y9KFCsuvQ/1vijrskslyV3CpRuE=;
        b=BLuo5e5CEEY8wwbz/iLRU+pNGSFKB/S0asMak4tjFBdUXtY+VTkPm80BvFv6OBSTD8
         WJ0qWvYSst9aNZBxf43unaQRejS0eLyf1Emtb8SqSd0uqPGV3k7WihOvzvRtTKhylnWm
         bZ0FT3SpZwtnfxQCD5LuazeTLERFKgj2vwuh4+BOQBDXLySK5ajwcS4LPIl9eIHCYGgy
         +Q+myG7S9Jc1P0DAuMvsTYwYud7lqJlYzDlW9RNh/jQXVnVqbIf4eIFVItpiDuLdil00
         HJ8TotaipLWg9Vd1O6OG22rMgvrfKHQ1Th97mltOgQ7AotYHeN3Obo3Bjih2w9cIdzfF
         RSJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698225387; x=1698830187;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dkMR9DQLmnzg6433Y9KFCsuvQ/1vijrskslyV3CpRuE=;
        b=UgyOxUlt9DDV6vlUuAZvkJND9oByi8aq7LWf/rQCsNkq0NCdjBgHVNoHMzVSdYDLyR
         O+1qxxWRj2wgXFFyicQy1wTmmZPcBqIqd/x3JlV2cUn/tIFFbGLeXTuSAxeEoLnC6D8L
         GhYOc0QN+YEfRo18/Ny9urGfCImwpGsKk24y9myxsuPT8EUkS6HRQpjFOpkyLYJvsKUw
         By8RyEc14uh/hG1S8hk+VjSRI743DklUhzdxp1NYohIke+r1gsVTFQyH0x/w4gPHlGqF
         qFF4dxuTRT7pEh8siqP+DrCD16BeW7r8BZ5yMETFAuo9d/PhCGbTf5hbSg4RSFC920YY
         K7Cw==
X-Gm-Message-State: AOJu0YwSzGK7oj27SbFG0ojnmz1j3mPMLb3r5uUrUJkT0lGVniuvpTOr
        LOEkqpv9aljASeSxya5KmsUvog==
X-Google-Smtp-Source: AGHT+IG+8hlU7/gyP30B0hMc3Hc3WZ6IDoa8IyFLNr20MywZzm4fh/W9cr4rBR49QkVDcHfsLDEgzw==
X-Received: by 2002:a05:6512:314e:b0:507:9702:c11d with SMTP id s14-20020a056512314e00b005079702c11dmr9065901lfi.64.1698225387369;
        Wed, 25 Oct 2023 02:16:27 -0700 (PDT)
Received: from [172.30.204.57] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id m5-20020a056512114500b00507d1cc0458sm2470539lfg.51.2023.10.25.02.16.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Oct 2023 02:16:27 -0700 (PDT)
Message-ID: <75c4a105-b925-4d6a-8c42-38f3ab32a7ca@linaro.org>
Date:   Wed, 25 Oct 2023 11:16:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] media: qcom: camss: Convert to per-VFE pointer for
 power-domain linkages
Content-Language: en-US
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        hverkuil-cisco@xs4all.nl, laurent.pinchart@ideasonboard.com,
        rfoss@kernel.org, todor.too@gmail.com, agross@kernel.org,
        andersson@kernel.org, mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231024224255.754779-1-bryan.odonoghue@linaro.org>
 <20231024224255.754779-2-bryan.odonoghue@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20231024224255.754779-2-bryan.odonoghue@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/25/23 00:42, Bryan O'Donoghue wrote:
> Right now we use the top-level camss structure to provide pointers via
> VFE id index back to genpd linkages.
> 
> In effect this hard-codes VFE indexes to power-domain indexes in the
> dtsi and mandates a very particular ordering of power domains in the
> dtsi, which bears no relationship to a real hardware dependency.
> 
> As a first step to rationalising the VFE power-domain code and breaking
> the magic indexing in dtsi use per-VFE pointers to genpd linkages.
> 
> The top-level index in msm_vfe_subdev_init is still used to attain the
> initial so no functional or logical change arises from this change.
> 
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> ---
[...]

> @@ -653,11 +653,11 @@ static int vfe_pm_domain_on(struct vfe_device *vfe)
>   	if (id >= camss->res->vfe_num)
>   		return 0;
>   
> -	camss->genpd_link[id] = device_link_add(camss->dev, camss->genpd[id],
> -						DL_FLAG_STATELESS |
> -						DL_FLAG_PM_RUNTIME |
> -						DL_FLAG_RPM_ACTIVE);
Good opportunity to inilne vfe->id and get rid of a local var!

> -	if (!camss->genpd_link[id])
> +	vfe->genpd_link = device_link_add(camss->dev, vfe->genpd,
> +					  DL_FLAG_STATELESS |
> +					  DL_FLAG_PM_RUNTIME |
> +					  DL_FLAG_RPM_ACTIVE);
> +	if (!vfe->genpd_link)
>   		return -EINVAL;
>   
[...]

>   /*
> @@ -1128,10 +1124,10 @@ static int vfe_pm_domain_on(struct vfe_device *vfe)
>   	struct camss *camss = vfe->camss;
>   	enum vfe_line_id id = vfe->id;
>   
> -	camss->genpd_link[id] = device_link_add(camss->dev, camss->genpd[id], DL_FLAG_STATELESS |
> -						DL_FLAG_PM_RUNTIME | DL_FLAG_RPM_ACTIVE);
> +	vfe->genpd_link = device_link_add(camss->dev, vfe->genpd, DL_FLAG_STATELESS |
> +					  DL_FLAG_PM_RUNTIME | DL_FLAG_RPM_ACTIVE);
>   
> -	if (!camss->genpd_link[id]) {
> +	if (!vfe->genpd_link) {
>   		dev_err(vfe->camss->dev, "Failed to add VFE#%d to power domain\n", id);
>   		return -EINVAL;
And here

[...]

> @@ -1113,10 +1111,10 @@ static int vfe_pm_domain_on(struct vfe_device *vfe)
>   	struct camss *camss = vfe->camss;
>   	enum vfe_line_id id = vfe->id;
>   
> -	camss->genpd_link[id] = device_link_add(camss->dev, camss->genpd[id], DL_FLAG_STATELESS |
> -						DL_FLAG_PM_RUNTIME | DL_FLAG_RPM_ACTIVE);
> +	vfe->genpd_link = device_link_add(camss->dev, vfe->genpd, DL_FLAG_STATELESS |
> +					  DL_FLAG_PM_RUNTIME | DL_FLAG_RPM_ACTIVE);
>   
> -	if (!camss->genpd_link[id]) {
> +	if (!vfe->genpd_link) {
>   		dev_err(vfe->camss->dev, "Failed to add VFE#%d to power domain\n", id);
>   		return -EINVAL;
And here

[...]
>   
>   /*
> @@ -478,11 +478,11 @@ static int vfe_pm_domain_on(struct vfe_device *vfe)
>   	if (id >= camss->res->vfe_num)
>   		return 0;
>   
> -	camss->genpd_link[id] = device_link_add(camss->dev, camss->genpd[id],
> -						DL_FLAG_STATELESS |
> -						DL_FLAG_PM_RUNTIME |
> -						DL_FLAG_RPM_ACTIVE);
> -	if (!camss->genpd_link[id])
> +	vfe->genpd_link = device_link_add(camss->dev, vfe->genpd,
> +					  DL_FLAG_STATELESS |
> +					  DL_FLAG_PM_RUNTIME |
> +					  DL_FLAG_RPM_ACTIVE);
And here


Konrad
