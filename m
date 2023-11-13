Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10FAB7E99D7
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 11:09:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233358AbjKMKJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 05:09:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233255AbjKMKJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 05:09:24 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70A6610C0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 02:09:20 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-da2b9211dc0so4152641276.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 02:09:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699870159; x=1700474959; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LTeLgW8CvRb7cxtMxy0EsZxPLzWZ8KwGmGaV7tRJB1M=;
        b=nBwH0l6cIoEUGETfjXk9QTEcpZ5Pui5vVrmnB5K90LfOyk5H4Gs4Lw6UK7fhvPVHR9
         UNa+AE7c2x6gfaNN1Ikhkc/Y1vJMlwPcSbFEOgmmLFHStvRiIzL6TWpFn4TWrJ70rW9y
         JEA6vqDjvy4QVSEPn8Q0qkdoRQhfCA8zz5pYvOW+PL1DQry8ABXhRDXdDHrQPsOge6Ya
         KgpJGv3u88jVts2jhn6lrPm6K3zljp6r1dN/Sjj5j3dCkSEHbO2KRWUNN6EQoiDE6x/M
         L3fRrc0aVpifib/Wt9cy0N9Chxux7xoOAwqQiL+eKpikhqYGdQCr9fFsr+qbSIC7u6/d
         brag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699870159; x=1700474959;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LTeLgW8CvRb7cxtMxy0EsZxPLzWZ8KwGmGaV7tRJB1M=;
        b=GsREgAHvK+Fe93uQgM7xEJeuQn4Ls3NqLHW2zlq+JwHWixbl0PtGezTt4+7YuO511w
         KgIfR32L1/Ho0K3wuW95/da734Euo/HqcfVF29Q4g6H5XTXgFyucClKUNkKUthtKAcjR
         9oTxe75MXRh0QQ5++CySa9RjT4pkFvgqtoQ3l+o9q0omiO8A6WePNOKHpyFhu75+3+Hg
         yNdXAs6Gxbw17W2JWrAxhESMmxFP27hgcZcSDmnybqvukHQ1qZ4uvUJo35OKEdZMK/h1
         94avtu0r6BQxsRLSu0o4lo6BeCIgSLctrqrgpS/s2FgDKMti4V+Omj2pe5Q85yNKdKJr
         XpWQ==
X-Gm-Message-State: AOJu0YwSL6NVekYkX7iUAO8AkJrfbWT5hgR28hPW53eQjw/Tehp9y4PZ
        vedKgKxAibljmNE6qsIBszr7a2ZITxAjJK4bfbLkIA==
X-Google-Smtp-Source: AGHT+IHagcgO5SbZ+FDx8rzNuCIFQabokjyG6WQDrmEqHV78EtJqdrNniMpYtKkxfYMdzu3YflD5B+sro9YoieMSUe0=
X-Received: by 2002:a25:414c:0:b0:da0:5775:fd77 with SMTP id
 o73-20020a25414c000000b00da05775fd77mr4661466yba.63.1699870159609; Mon, 13
 Nov 2023 02:09:19 -0800 (PST)
MIME-Version: 1.0
References: <20231111094645.12520-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20231111094645.12520-1-krzysztof.kozlowski@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Mon, 13 Nov 2023 12:09:08 +0200
Message-ID: <CAA8EJpoK1N1LBY5ZjL7hb0Sqge7iF4X=rm1n9VZPx-0nOm3bkw@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: Revert "arm64: dts: qcom: qrb5165-rb5:
 enable DP altmode"
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Nov 2023 at 11:46, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> This reverts commit b3dea914127e9065df003002ed13a2ef40d19877.
>
> The commit introduced unsupported and undocumented properties:
>
>   qrb5165-rb5.dtb: pmic@2: typec@1500:connector: 'altmodes' does not match any of the regexes: 'pinctrl-[0-9]+'

We need this property to enable DP altmode on RB5. It has been parsed
by the typec subsystem since the commit 7b458a4c5d73 ("usb: typec: Add
typec_port_register_altmodes()"), merged in April 2021.

Rather than landing this commit, let me propose to send the proper
binding instead. If we can not agree on a compatible bindings document
within the sensible timeframe (e.g. 1 month), I'm fine with dropping
of the altmodes from qrb5156-rb5.

>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/qrb5165-rb5.dts | 7 -------
>  1 file changed, 7 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
> index c8cd40a462a3..3bd0c06e7315 100644
> --- a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
> +++ b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
> @@ -1423,13 +1423,6 @@ PDO_FIXED_DUAL_ROLE |
>                                          PDO_FIXED_USB_COMM |
>                                          PDO_FIXED_DATA_SWAP)>;
>
> -               altmodes {
> -                       displayport {
> -                               svid = <0xff01>;
> -                               vdo = <0x00001c46>;
> -                       };
> -               };
> -
>                 ports {
>                         #address-cells = <1>;
>                         #size-cells = <0>;
> --
> 2.34.1
>
>


-- 
With best wishes
Dmitry
