Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7381D7F9306
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 15:17:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbjKZORc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 09:17:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjKZORb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 09:17:31 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB4FF101
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 06:17:36 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-40838915cecso23569275e9.2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 06:17:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701008255; x=1701613055; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QcndzPm7z338RHK94VwEZXvnKMZos/UvhLkmjn4xC/Q=;
        b=RU4YCTGTF3V7MB5nzdM43ikVnMAcZ/vxsb8cq99diNtWf6dyCDXUysxgjaectB4pEv
         oaGpOZ4oVkGhZQK1M7lja7sV3xFC9z6Foien+Fk7iabEYBxf74EUfy/13SWSYeIKzHAh
         7JvpMic+hlAoIt6gaArjyIy2d3lPIFycmaCmgdBXrmLBTyoUZjaoY1STxExXt5uJe3mw
         Ki2MT9dB1Ngt6o3gPCSBloaDGod6qcnYq1nre+r+0FPLcezacgVGdPG8M+eRHzlKn7ps
         KrKLX8+RbISecip3ISGSkiVsYsy3j5tS5OJi6eSfs2VKaqGbu85vinNKO3fnP6hI7rFD
         KLaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701008255; x=1701613055;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QcndzPm7z338RHK94VwEZXvnKMZos/UvhLkmjn4xC/Q=;
        b=spMDOYIWupCD7jxh5GZ5M/zcxbvYnz7kvdwdXysqNYV/wnJh3+4Fsz+5fckIyT0G5E
         2iR3jL8WODKylWpDcYM1zLVG7UTsiqtI4fYEPxZStAWzCqy21ibw5wPSyFmd+RcZYuW1
         vV7JgPJku3JAR4CDbC0E/99nyqjEB502oFZuYCmByP9jEwIe2+4d7RAHqKbvC45Rxbk7
         iTV1tMN8uliYR2B6uTCyL40QC3Jqv5z2JLR9yYCRDLzMzkeuc/1dq2hJcTmNffjLnOqm
         OPILY61u+UBy5Bs+Y6AjWCOkvurmBmPPYx/7PXi7pDCeKC7YDlQ3bGS6hAHcYpTVa+9V
         V5ag==
X-Gm-Message-State: AOJu0Yz+qnbVaXJzOnmpM8OuXNdiraaKkj0NJbr0f5g8XRkAYiBcDle/
        rB9jP9XpNG9wqiLmkKZBXfFRVg==
X-Google-Smtp-Source: AGHT+IGkk9pdn9r7g1J1o/fcsxC78jPge+mZy3lXPIb8wrgrQCxYQ08bQdBSvKnCzAF2mipxLo0QBg==
X-Received: by 2002:a05:600c:154f:b0:40b:3dbf:f39 with SMTP id f15-20020a05600c154f00b0040b3dbf0f39mr2924922wmg.37.1701008254426;
        Sun, 26 Nov 2023 06:17:34 -0800 (PST)
Received: from [192.168.100.102] ([37.228.218.3])
        by smtp.gmail.com with ESMTPSA id u17-20020a05600c19d100b004064cd71aa8sm10565101wmq.34.2023.11.26.06.17.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Nov 2023 06:17:33 -0800 (PST)
Message-ID: <1dce7a79-be67-4d44-b03f-63ef5cbb78e3@linaro.org>
Date:   Sun, 26 Nov 2023 14:17:31 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/12] dt-bindings: display: msm: qcm2290-mdss: Use the
 non-deprecated DSI compat
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        Robert Marko <robimarko@gmail.com>,
        Das Srinagesh <quic_gurus@quicinc.com>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Rob Herring <robh@kernel.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev
References: <20231125-topic-rb1_feat-v1-0-11d71b12b058@linaro.org>
 <20231125-topic-rb1_feat-v1-1-11d71b12b058@linaro.org>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20231125-topic-rb1_feat-v1-1-11d71b12b058@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/11/2023 14:17, Konrad Dybcio wrote:
> The "qcom,dsi-ctrl-6g-qcm2290" has been deprecated in commit 0c0f65c6dd44
> ("dt-bindings: msm: dsi-controller-main: Add compatible strings for every
> current SoC"), but the example hasn't been updated to reflect that.
> 
> Fix that.
> 
> Fixes: 0c0f65c6dd44 ("dt-bindings: msm: dsi-controller-main: Add compatible strings for every current SoC")
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>   Documentation/devicetree/bindings/display/msm/qcom,qcm2290-mdss.yaml | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-mdss.yaml
> index 5ad155612b6c..3d82c00a9f85 100644
> --- a/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-mdss.yaml
> +++ b/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-mdss.yaml
> @@ -56,7 +56,9 @@ patternProperties:
>   
>       properties:
>         compatible:
> -        const: qcom,dsi-ctrl-6g-qcm2290
> +        items:
> +          - const: qcom,qcm2290-dsi-ctrl
> +          - const: qcom,mdss-dsi-ctrl
>   
>     "^phy@[0-9a-f]+$":
>       type: object
> 
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
