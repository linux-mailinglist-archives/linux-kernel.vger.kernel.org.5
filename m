Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27D717F192D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 17:53:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233724AbjKTQxm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 11:53:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233703AbjKTQxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 11:53:37 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 051D8D8
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 08:53:33 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-332c82400a5so744619f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 08:53:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700499211; x=1701104011; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0+gDpEFBGCZPC35kFuu8atg4ddHQhZ0gqgHVoGyLF54=;
        b=BYEyMmMwjSA2hXJjTOUKF1oYgXJzduN81Beekvwey654UpjT/NRoqkqJ0Lj+i2scby
         ELbrX0o1UvoY6Ul5T5eeARzDn7Sk2H/SXogz4+hjf/SVDyU1XVm7paIwcJuHQd8iJm6n
         0x2h+vOPT5j9K/xpLtHhG/oyxNYsIrOQZh0EKnOVaXy7Qgr1btC6MloTSGW6sdFr7UjS
         hMDPVd/8bHOgTlUNL3RCa4fZdV3Tk/heZd9CP9whnsuLIm4fKfelQP4MhYHNyhZJ5yQ9
         66GyXYbVg5g5UldmrpQfOdsSnEPRb6H9jWDzD1jQH8NmNE16u007lzQXZm7K9mshv49s
         5CeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700499211; x=1701104011;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0+gDpEFBGCZPC35kFuu8atg4ddHQhZ0gqgHVoGyLF54=;
        b=ZvnjqxxxVYd6cv5WcACg3mdU4WewAq/3XQPaht4SkA3yZRI7B22s2SNZDoCu08RaOn
         Z3kC0umBxvE02xKpCs29Dc096CSxqPQGP3gLvSDAR32/SHdqfduziSaiXtK28c+Kgpjh
         RqPUjdlaowQGYoOBwU5hfId4JV/x2ePEKP5BBItDrdqefvwXZ9xi3ivemGEhJS8HXf+A
         Ewk0B4f/8XnUk0A40aMQh6rhnTFjpfl7W4Yxj5fuM501BLVRcZDHXZKmh3yOPc55wBOW
         1OVF7WmwEJdr3Uf9kr07MnciEHyq+ltf8KkyWhRjdeFDFmRIA65cNnVVU37g3Moek2Ot
         q/oA==
X-Gm-Message-State: AOJu0YxKLVlSs4F6uhlu2IHSjIuU6BP559OqUsvyEB7ncTrwT/hScgTu
        f3woZs8mu3TfN4BHqaD/OL6UMA==
X-Google-Smtp-Source: AGHT+IEvxCLLUYVrYXIWophHdZIhi/VeSga73kO+5zNIwblLLdJFqZU8ZxKMQCA+n16sBchlEO7bhg==
X-Received: by 2002:a5d:5f90:0:b0:32d:967d:1baf with SMTP id dr16-20020a5d5f90000000b0032d967d1bafmr5701802wrb.1.1700499211433;
        Mon, 20 Nov 2023 08:53:31 -0800 (PST)
Received: from linaro.org ([86.123.99.122])
        by smtp.gmail.com with ESMTPSA id b8-20020a5d45c8000000b003142e438e8csm11707602wrs.26.2023.11.20.08.53.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 08:53:31 -0800 (PST)
Date:   Mon, 20 Nov 2023 18:53:29 +0200
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/11] arm64: dts: qcom: sm8550: fix USB wakeup interrupt
 types
Message-ID: <ZVuPCch2Tf6fK5R+@linaro.org>
References: <20231120164331.8116-1-johan+linaro@kernel.org>
 <20231120164331.8116-12-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231120164331.8116-12-johan+linaro@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-11-20 17:43:31, Johan Hovold wrote:
> The DP/DM wakeup interrupts are edge triggered and which edge to trigger
> on depends on use-case and whether a Low speed or Full/High speed device
> is connected.
> 
> Note that only triggering on rising edges can be used to detect resume
> events but not disconnect events.
> 
> Fixes: 7f7e5c1b037f ("arm64: dts: qcom: sm8550: Add USB PHYs and controller nodes")
> Cc: Abel Vesa <abel.vesa@linaro.org>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

Reviewed-by: Abel Vesa <abel.vesa@linaro.org>

> ---
>  arch/arm64/boot/dts/qcom/sm8550.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
> index 7b9ddde0b2c9..9b5b098bb7e8 100644
> --- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
> @@ -2923,8 +2923,8 @@ usb_1: usb@a6f8800 {
>  
>  			interrupts-extended = <&intc GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH>,
>  					      <&pdc 17 IRQ_TYPE_LEVEL_HIGH>,
> -					      <&pdc 15 IRQ_TYPE_EDGE_RISING>,
> -					      <&pdc 14 IRQ_TYPE_EDGE_RISING>;
> +					      <&pdc 15 IRQ_TYPE_EDGE_BOTH>,
> +					      <&pdc 14 IRQ_TYPE_EDGE_BOTH>;
>  			interrupt-names = "hs_phy_irq",
>  					  "ss_phy_irq",
>  					  "dm_hs_phy_irq",
> -- 
> 2.41.0
> 
