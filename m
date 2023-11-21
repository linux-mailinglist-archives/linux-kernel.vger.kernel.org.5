Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE7887F237B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 03:02:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbjKUCCC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 21:02:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233186AbjKUCBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 21:01:35 -0500
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A375100;
        Mon, 20 Nov 2023 18:01:30 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id 6a1803df08f44-66d0ceba445so13691316d6.0;
        Mon, 20 Nov 2023 18:01:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700532089; x=1701136889; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ud2wbnDHnTrARrEBLi1hXnjXYj97H/dIcLoVNVIK3P4=;
        b=Qo4VpbIxb5wlMARFUrDm6Jg5qG2tQBDi1AeAMq0w8eOGKIMYH6E1Wcff6BjZOqQCpc
         YvEoNoJc7F7PrQVWwhxVZrR8Zn0HHA6x7WPQp8orldqx37hMxJi7NTtDz8RXkU8N7dWx
         gJZxN51eclznOBT63M9t84MmZ2MvyTWhXfnU3WUgv0jWHE3rdqt2qLIYQW0LswU5D1yl
         xlyAeWL+7EqUF/7N+8w13MwBv4pWRnO4f4nsGuc0c+gDE8f1sc7mEbkgVV1U0Ub2HE0T
         5HqmanDWxbKAtmslEo44uD6o0sHDfUe+xRe/HRE++LQn8SpQe88heFm1Qr5mm21pm4+8
         n06Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700532089; x=1701136889;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ud2wbnDHnTrARrEBLi1hXnjXYj97H/dIcLoVNVIK3P4=;
        b=Pm+Wl1RbEhQem8wpeYRqvmS+Ab9XLnU5GlKog2OdB7a14sc0nT+4xmWgwYfnP88WwW
         9Co5gIinZ2ZeWKSlwVGu0UOGwsLcXV6OxLUrque83PKtYBI+fUJUpUJfUTHpnp/rRs3N
         owCbRUkq61KcSSW5O75AXAHmaTMnNuyfoNrEjsTaG0buIJk2CJBIH3PMmLvPpGL551+b
         y10UcdxzE4IMnqwQ3IL7/LpIPdtYOrDqJGNFo6v6mbXgOrOIM41/mDtiQbjSwWLR9wEe
         XtuxQ6q+u9Ekjz9PjfCoarVzFfP81A/F10+cg9UmnXUVe4sctPLdAOIc5gwkcTBFPvy6
         eE1w==
X-Gm-Message-State: AOJu0YwqOz22mEMQlauggAwHjImx/HiEvV5r5uGlzTeFK8c2Le20DnKS
        zu+LmQ6rgTpLS5J2q0jxFVcp4COdfs+Xuw==
X-Google-Smtp-Source: AGHT+IG3r61SWPQbDOGF+sdTnp+vfRXsKvmLw2YQ3Rx/gPRU/Ji7LfmlJdQ1x8w81yw48pn4BL8QHA==
X-Received: by 2002:a05:6214:2b0e:b0:677:f341:c5a1 with SMTP id jx14-20020a0562142b0e00b00677f341c5a1mr10715687qvb.30.1700532089431;
        Mon, 20 Nov 2023 18:01:29 -0800 (PST)
Received: from localhost ([2607:fea8:529e:7800::80ec])
        by smtp.gmail.com with ESMTPSA id j16-20020a0cc350000000b0066cf2423c79sm3509228qvi.139.2023.11.20.18.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 18:01:28 -0800 (PST)
Date:   Mon, 20 Nov 2023 21:01:27 -0500
From:   Richard Acayan <mailingradian@gmail.com>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 07/11] arm64: dts: qcom: sdm670: fix USB wakeup interrupt
 types
Message-ID: <ZVwPd8OmjwMjtB3k@radian>
References: <20231120164331.8116-1-johan+linaro@kernel.org>
 <20231120164331.8116-8-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231120164331.8116-8-johan+linaro@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2023 at 05:43:27PM +0100, Johan Hovold wrote:
> The DP/DM wakeup interrupts are edge triggered and which edge to trigger
> on depends on use-case and whether a Low speed or Full/High speed device
> is connected.
>
> Fixes: 07c8ded6e373 ("arm64: dts: qcom: add sdm670 and pixel 3a device trees")
> Cc: stable@vger.kernel.org      # 6.2
> Cc: Richard Acayan <mailingradian@gmail.com>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---

Acked-by: Richard Acayan <mailingradian@gmail.com>

>  arch/arm64/boot/dts/qcom/sdm670.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/qcom/sdm670.dtsi b/arch/arm64/boot/dts/qcom/sdm670.dtsi
> index ba2043d67370..c873560ae9d5 100644
> --- a/arch/arm64/boot/dts/qcom/sdm670.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm670.dtsi
> @@ -1297,8 +1297,8 @@ usb_1: usb@a6f8800 {
>  
>  			interrupts = <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>,
>  				     <GIC_SPI 486 IRQ_TYPE_LEVEL_HIGH>,
> -				     <GIC_SPI 488 IRQ_TYPE_LEVEL_HIGH>,
> -				     <GIC_SPI 489 IRQ_TYPE_LEVEL_HIGH>;
> +				     <GIC_SPI 488 IRQ_TYPE_EDGE_BOTH>,
> +				     <GIC_SPI 489 IRQ_TYPE_EDGE_BOTH>;
>  			interrupt-names = "hs_phy_irq", "ss_phy_irq",
>  					  "dm_hs_phy_irq", "dp_hs_phy_irq";
>  
> -- 
> 2.41.0
>
