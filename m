Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF01B7E0CDF
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 01:43:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231748AbjKDAng (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 20:43:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231444AbjKDAnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 20:43:33 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE7AED7B;
        Fri,  3 Nov 2023 17:43:24 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1cc3bb32b5dso23664855ad.3;
        Fri, 03 Nov 2023 17:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699058604; x=1699663404; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2hEpMF27cYmQ7QR3eSkelLoy3Uy4PXBtKKdQ0d9isBo=;
        b=IeOWfTaYT9rwJhfB9rdpRTJujbyC8TGa/lmxlTaMEPcK/suzJ/mzgORBcGXshV0zTm
         DGfOsikTMspkEZkk87lzBcJAF4YDddOauAPNpAQiHus5O4cvPjxWLZ3NhErlTkH1+zH3
         5VD+crafrhi7QMF/pansxvRKu2TqSxBaNpL/AJqcpjZp4TSfyu78cw6G2WUIB0MftqgC
         XIF+q2miRNfzOBslDR2KVXcTigSgxSLu7YbqEOAs2nhxWqo9ViqnHu72I/eSwBPULRN6
         GaX09vGrFFJOjNbxS7blV8KJ4l/8QFSTq8/Zzx/Qc75zZnlP4W90DVLdZDh5rUmx6P03
         3V8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699058604; x=1699663404;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2hEpMF27cYmQ7QR3eSkelLoy3Uy4PXBtKKdQ0d9isBo=;
        b=Jz3eGlojsbXf6JC7aoKzdyb5M5t4SA29whQITngtBfcXA76Qv9gPBlNFPMDQ9NKZ6i
         bwnCnScdZiQrKnt1XWyNnQOJ2K4IXnvBjyU5SNar0aK6g1OamGWTvrmuK7KecombqSrn
         kC8dpIkWEDVvA8WCDPHD4x9EpnbcQJDLivH018GgJ0/Uk6RiOI21D8XUevjxkZ8tk7ql
         qUGpOY5/ywccelStu19A/gqiS9FqILroMY/M3ldMuaIpESbOn19ij9kwEBiazoQyEWMD
         7fKDwRFmKRabQ5Igr45AYpKHP2dr53g9QoLypkH5GdOfgw33Uh8Ebk6qFV/BzA+sZ29z
         rNEA==
X-Gm-Message-State: AOJu0Yzw2BerxqtbPWpbz43yDygXjfoEqDGdpcS1lI2TABtizYfZGvCX
        mWXC1t72uz/JNO8kGrww81E=
X-Google-Smtp-Source: AGHT+IE982aRxuBDEEvESwmSp+15uaDNIq53uP31Fy7Y8J5JSMOxZ2xPRWNtDUMLKcPHi9bo5uiQzw==
X-Received: by 2002:a17:902:d552:b0:1cc:50ea:d5db with SMTP id z18-20020a170902d55200b001cc50ead5dbmr19378549plf.4.1699058603926;
        Fri, 03 Nov 2023 17:43:23 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id jc4-20020a17090325c400b001c613091aeesm1888840plb.293.2023.11.03.17.43.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 17:43:23 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 3 Nov 2023 17:43:22 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-watchdog@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        swboyd@chromium.org, Andy Gross <agross@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/9] arm64: dts: qcom: sm6350: Make watchdog bark
 interrupt edge triggered
Message-ID: <8331ff50-e825-4c27-909e-37f5a9387344@roeck-us.net>
References: <20231103163434.1.Ic7577567baff921347d423b722de8b857602efb1@changeid>
 <20231103163434.8.Ic1d4402e99c70354d501ccd98105e908a902f671@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231103163434.8.Ic1d4402e99c70354d501ccd98105e908a902f671@changeid>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 03, 2023 at 04:34:34PM -0700, Douglas Anderson wrote:
> As described in the patch ("arm64: dts: qcom: sc7180: Make watchdog
> bark interrupt edge triggered"), the Qualcomm watchdog timer's bark
> interrupt should be configured as edge triggered. Make the change.
> 
> Fixes: 5f82b9cda61e ("arm64: dts: qcom: Add SM6350 device tree")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> 
>  arch/arm64/boot/dts/qcom/sm6350.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm6350.dtsi b/arch/arm64/boot/dts/qcom/sm6350.dtsi
> index 8fd6f4d03490..6464e144c228 100644
> --- a/arch/arm64/boot/dts/qcom/sm6350.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm6350.dtsi
> @@ -2524,7 +2524,7 @@ watchdog@17c10000 {
>  			compatible = "qcom,apss-wdt-sm6350", "qcom,kpss-wdt";
>  			reg = <0 0x17c10000 0 0x1000>;
>  			clocks = <&sleep_clk>;
> -			interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupts = <GIC_SPI 0 IRQ_TYPE_EDGE_RISING>;
>  		};
>  
>  		timer@17c20000 {
> -- 
> 2.42.0.869.gea05f2083d-goog
> 
